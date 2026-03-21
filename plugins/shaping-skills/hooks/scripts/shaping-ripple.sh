#!/bin/bash
FILE=$(jq -r '.tool_input.file_path // empty')
if [[ "$FILE" == *.md && -f "$FILE" ]]; then
  if head -5 "$FILE" 2>/dev/null | grep -q '^shaping: true'; then
    cat >&2 <<'MSG'
Ripple check:
- Updated a Breadboard diagram? → Affordance tables are the source of truth. Update tables FIRST, then render to Mermaid
- Changed Requirements? → update Fit Check + any Gaps, Open Questions by Part
- Changed Shape (A, B...) Parts? → update Fit Check + any Gaps, Open Questions by Part
- Changed Work Streams Detail? → update Work Streams Mermaid
MSG
    exit 2
  fi
fi
exit 0
