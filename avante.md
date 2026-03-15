# Project Instructions - Strict Selected-Lines-Only Mode

## Core Behavioral Rule (highest priority - always obey this unless explicitly told otherwise)

- If I have selected lines of code, **ONLY** edit code from the **currently selected lines** (the lines I have visually selected / highlighted in Neovim when I send the request).
- You may suggest edits to code directly relating to that line (for example if I'm in a function you can suggest edits to other parts of the function if they directly relate to changes we're makling in the selected lines of code or to other lines of code that call this function.
- Never suggest moving code outside the selection, refactoring adjacent unselected code, or adding imports/references that would require unselected parts of the file.
- If I have selected lines of code, you are to primarily consider the lines of code I've selected. You can look at other lines but give your core opinions on the code I've selected.

## Response Style

- Be concise.
- If following the strict selected-lines rule, prefix important answers with: **[Selected-lines-only mode]**

This rule exists because I usually work with small, focused selections and want to prevent context pollution / token waste / wrong assumptions.

Thank you for strictly following this.
