"""Seed shim — delegates to bootstrap_admin.py in mycel_iam_service/scripts/."""
import subprocess
import sys
import os
from pathlib import Path

service_dir = Path(__file__).resolve().parents[3] / "mycel_iam_service"
script = service_dir / "scripts" / "bootstrap_admin.py"

if not script.exists():
    print(f"[seed] bootstrap_admin.py not found at {script} — skipping")
    sys.exit(0)

result = subprocess.run(
    [sys.executable, str(script)],
    cwd=str(service_dir),
    env={**os.environ},
)
sys.exit(result.returncode)
