#!/usr/bin/env python3

import sys
import time
import json
import fcntl
import subprocess
from pathlib import Path

THRESHOLD = 2
TIMEOUT = 0.5

STATE = Path("/tmp/sway-workspace-scroll.json")
LOCK = Path("/tmp/sway-workspace-scroll.lock")

direction = sys.argv[1]

with LOCK.open("w") as lock:
    fcntl.flock(lock, fcntl.LOCK_EX)

    now = time.monotonic()

    try:
        state = json.loads(STATE.read_text())
    except (FileNotFoundError, json.JSONDecodeError):
        state = {"direction": "", "count": 0, "time": 0}

    if (
        state["direction"] != direction
        or now - state["time"] > TIMEOUT
    ):
        state["direction"] = direction
        state["count"] = 0

    state["count"] += 1
    state["time"] = now

    if state["count"] >= THRESHOLD:
        workspace = "prev" if direction == "up" else "next"

        subprocess.run(
            ["swaymsg", "workspace", workspace],
            check=False,
        )

        state["count"] = 0

    STATE.write_text(json.dumps(state))
