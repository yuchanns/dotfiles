#!/usr/bin/env python3
"""A slow GitHub lookup must outlive the short-lived Eww button command."""

import os
from pathlib import Path
import subprocess
import tempfile
import time


action = Path(__file__).resolve().parents[1] / "scripts/eww-desktop-action"
with tempfile.TemporaryDirectory(prefix="eww-github-open-") as directory:
    root = Path(directory)
    gh = root / "gh"
    gh.write_text("""#!/bin/sh
sleep 0.6
if [ "$MOCK_GH_FAIL" = 1 ]; then
    echo 'mock GitHub failure' >&2
    exit 1
fi
printf '%s\\n' "$MOCK_HTML_URL"
""")
    opener = root / "xdg-open"
    opener.write_text("""#!/bin/sh
printf '%s\\n' "$1" >"$MOCK_OPENED"
""")
    gh.chmod(0o755)
    opener.chmod(0o755)
    opened = root / "opened"
    log = root / "cache/eww/github-open.log"
    env = dict(os.environ, PATH=str(root) + os.pathsep + os.environ["PATH"],
               XDG_CACHE_HOME=str(root / "cache"), MOCK_GH_FAIL="0",
               MOCK_HTML_URL="https://github.com/owner/repo/pull/22", MOCK_OPENED=str(opened))

    def invoke(url):
        # Capturing both pipes also detects accidental background inheritance:
        # even a completed parent must not leave Eww waiting for the network.
        return subprocess.run([str(action), "open-github", url], env=env,
                              capture_output=True, text=True, timeout=0.2)

    def wait_for(predicate):
        deadline = time.monotonic() + 3
        while time.monotonic() < deadline:
            if predicate():
                return
            time.sleep(0.01)
        raise AssertionError("background action did not finish")

    assert invoke("https://api.github.com/repos/owner/repo/pulls/22").returncode == 0
    assert not opened.exists(), "the parent should return before the slow lookup finishes"
    wait_for(opened.exists)
    assert opened.read_text().strip() == env["MOCK_HTML_URL"]
    opened.unlink()

    assert invoke("https://example.com/repos/owner/repo/pulls/22").returncode == 2
    env["MOCK_HTML_URL"] = "https://example.com/untrusted"
    assert invoke("https://api.github.com/repos/owner/repo/pulls/22").returncode == 0
    wait_for(lambda: "no safe HTML URL" in log.read_text())
    assert not opened.exists()

    env["MOCK_GH_FAIL"] = "1"
    assert invoke("https://api.github.com/repos/owner/repo/pulls/22").returncode == 0
    wait_for(lambda: "mock GitHub failure" in log.read_text())
    assert not opened.exists()
    print("slow lookup survives button timeout; URL checks and failure logging passed")
