import os
import xml.etree.ElementTree as ET
from pathlib import Path

output_xml = Path("results/output.xml")
summary_path = Path(os.environ.get("GITHUB_STEP_SUMMARY", "summary.md"))
repo = os.environ.get("GITHUB_REPOSITORY", "")
base_url = os.environ.get("ROBOT_REPORT_BASE_URL", "").rstrip("/")
run_id = os.environ.get("GITHUB_RUN_ID", "")
allure_url = os.environ.get("ALLURE_REPORT_URL", "").rstrip("/")

if not output_xml.exists():
    summary_path.write_text("## Robot Framework Results\n\nNo `results/output.xml` file found.\n", encoding="utf-8")
    raise SystemExit(0)

root = ET.parse(output_xml).getroot()

def extract_failure_message(test):
    status_el = test.find("status")
    if status_el is not None and status_el.text and status_el.text.strip():
        return status_el.text.strip()
    for msg in test.iter("msg"):
        text = (msg.text or "").strip()
        if text:
            return text
    for kw in test.iter("kw"):
        kw_status = kw.find("status")
        if kw_status is not None and kw_status.attrib.get("status") == "FAIL":
            text = (kw_status.text or "").strip()
            if text:
                return text
    return "No failure message found"

stats = {"total": 0, "passed": 0, "failed": 0}
failed_tests = []
for test in root.iter("test"):
    name = test.attrib.get("name", "Unnamed test")
    test_id = test.attrib.get("id", "")
    status_el = test.find("status")
    status = status_el.attrib.get("status", "UNKNOWN") if status_el is not None else "UNKNOWN"
    stats["total"] += 1
    if status == "PASS":
        stats["passed"] += 1
    elif status == "FAIL":
        stats["failed"] += 1
        failed_tests.append({
            "name": name,
            "id": test_id,
            "message": extract_failure_message(test)
        })

status_emoji = "\u2705" if stats["failed"] == 0 else "\u274c"
lines = []
lines.append(f"## Robot Framework Results {status_emoji}")
lines.append("")
lines.append(f"- Total: **{stats['total']}**")
lines.append(f"- Passed: **{stats['passed']}**")
lines.append(f"- Failed: **{stats['failed']}**")
lines.append("")
run_url = f"https://github.com/{repo}/actions/runs/{run_id}"
lines.append(f"- [GitHub Actions run]({run_url})")
if base_url:
    lines.append(f"- [Published Robot log]({base_url}/log.html)")
    lines.append(f"- [Published Robot report]({base_url}/report.html)")
if allure_url:
    lines.append(f"- [\U0001f4ca Allure Report]({allure_url})")
lines.append("")
lines.append("### Failed tests")
lines.append("")
if failed_tests:
    for t in failed_tests:
        if base_url and t["id"]:
            link = f"{base_url}/log.html#{t['id']}"
            lines.append(f"- [{t['name']}]({link})")
        else:
            lines.append(f"- {t['name']}")
        short_msg = t["message"].replace("\n", " ").strip()
        if len(short_msg) > 300:
            short_msg = short_msg[:297] + "..."
        lines.append(f"  - `{short_msg}`")
else:
    lines.append("- None")
summary_path.write_text("\n".join(lines) + "\n", encoding="utf-8")
