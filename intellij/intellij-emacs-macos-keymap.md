# IntelliJ IDEA: Emacs + macOS Combined Keymap

## Overview

The "Emacs + macOS" keymap inherits from IntelliJ's built-in **Emacs** keymap
(which itself inherits from `$default`) and layers Mac-standard Cmd-key
shortcuts on top. This gives you Emacs-style editing (Ctrl+A/E/F/B/N/P/K/Y,
Ctrl+X prefix commands, Ctrl+S/R for incremental search, etc.) alongside
standard macOS shortcuts (Cmd+C/V/X/Z, Cmd+S, Cmd+W, Cmd+F, Cmd+1-9 for
tool windows, etc.).

The keymap file lives at:
```
~/Library/Application Support/JetBrains/IntelliJIdea2025.1/keymaps/Emacs_macOS.xml
```

## How IntelliJ Custom Keymaps Work

A custom keymap XML specifies a `parent` and only contains **overrides**. Any
action defined in the custom file **completely replaces** all bindings for that
action from the parent. Actions not mentioned inherit from the parent unchanged.

This means the file only contains actions where we're either adding Mac
shortcuts or resolving conflicts -- all other Emacs bindings come through
automatically.


## Conflict Resolutions

Where the Emacs and Mac keymaps bind the same key to different actions, we
made the following choices. Each entry documents what the Mac keymap would
have done and how to access that functionality instead.

### Ctrl+Space: Emacs Set Mark (not Code Completion)

| | |
|---|---|
| **Kept** | `EditorToggleStickySelection` (Emacs set mark) |
| **Displaced** | `CodeCompletion` |
| **Alternative** | **Alt+/** for basic code completion (Emacs `dabbrev-expand` key) |
| | **Ctrl+Shift+Space** for smart type completion |
| | **Ctrl+Alt+Space** for class name completion |

### Ctrl+G: Emacs Cancel (not Select Next Occurrence)

| | |
|---|---|
| **Kept** | `EditorEscape` (Emacs keyboard-quit / cancel) |
| **Displaced** | `SelectNextOccurrence` (multi-cursor select next match) |
| **Alternative** | **Cmd+Ctrl+G** for Select All Occurrences |
| | Menu: Edit > Find > Select Next Occurrence |
| | You can add a custom binding in Settings > Keymap if you use this often |

### Ctrl+D: Emacs Delete Char Forward (not Debug)

| | |
|---|---|
| **Kept** | `$Delete` (forward delete character) |
| **Displaced** | `Debug` (start debugger) |
| **Alternative** | **Ctrl+Shift+D** to debug current class/test |
| | **Ctrl+Alt+D** to choose debug configuration |
| | Toolbar debug button or menu Run > Debug |

### Ctrl+R: Emacs Reverse Search (not Run)

| | |
|---|---|
| **Kept** | `FindPrevious` (reverse incremental search) |
| **Displaced** | `Run` (run current configuration) |
| **Alternative** | **Ctrl+Shift+R** to run current class/test |
| | **Ctrl+Alt+R** to choose run configuration |
| | **Cmd+R** for Rerun (re-runs the last configuration) |
| | Toolbar run button or menu Run > Run |

### Ctrl+V: Emacs Page Down (not VCS Popup)

| | |
|---|---|
| **Kept** | `EditorPageDown` (scroll down one page) |
| **Displaced** | `Vcs.QuickListPopupAction` (VCS operations popup) |
| **Alternative** | **Cmd+9** to open the VCS tool window |
| | Menu: VCS (or Git) menu for all operations |

### Ctrl+M: Emacs Enter (not Match Brace)

| | |
|---|---|
| **Kept** | `EditorEnter` / `EditorChooseLookupItem` / `Console.Execute` |
| **Displaced** | `EditorMatchBrace` (go to matching bracket) |
| **Alternative** | **Cmd+Alt+[** / **Cmd+Alt+]** for code block start/end navigation |
| | **Ctrl+[** / **Ctrl+]** also navigate code blocks (Emacs-style) |
| | Menu: Navigate > Code Block Start/End |

### Ctrl+O: Emacs Open Line (not Override Methods)

| | |
|---|---|
| **Kept** | `EditorSplitLine` (open a new line below cursor) |
| **Displaced** | `OverrideMethods` |
| **Alternative** | Menu: Code > Override Methods |
| | Or assign a custom shortcut in Settings > Keymap |

### Alt+Left/Right: Mac Word Navigation (not Tab Switching)

| | |
|---|---|
| **Kept** | `EditorPreviousWord` / `EditorNextWord` (word-by-word movement) |
| **Displaced** | `PreviousTab` / `NextTab` |
| **Alternative** | **Cmd+Shift+[** / **Cmd+Shift+]** for tab switching (standard Mac convention) |
| | **Ctrl+X P** / **Ctrl+X N** for tab switching (Emacs-style) |

### Alt+Up/Down: Expand/Shrink Selection (not Method Navigation)

| | |
|---|---|
| **Kept** | `EditorSelectWord` / `EditorUnSelectWord` (structural selection) |
| **Displaced** | `MethodUp` / `MethodDown` |
| **Alternative** | **Ctrl+Alt+A** for method up (Emacs `C-M-a` beginning-of-defun) |
| | **Ctrl+Alt+E** for method down (Emacs `C-M-e` end-of-defun) |


## macOS System Keyboard Shortcut Conflict: Ctrl+Space

If **Ctrl+Space** requires multiple presses to work in IntelliJ (e.g., you
have to press it 2-3 times before the mark is set), the problem is that
**macOS is intercepting the keystroke** before it reaches IntelliJ.

### Cause

By default, macOS binds Ctrl+Space to **"Select the previous input source"**
(for switching keyboard layouts / input methods). The first press is consumed
by macOS, never reaching IntelliJ. If you have multiple input sources
configured, the second press may also be intercepted.

### Fix

1. Open **System Settings** (or System Preferences on older macOS)
2. Go to **Keyboard > Keyboard Shortcuts > Input Sources**
3. **Uncheck** both:
   - "Select the previous input source" (Ctrl+Space)
   - "Select next source in input menu" (Ctrl+Alt+Space)
4. If you only use one keyboard layout, you lose nothing by disabling these.
   If you do switch input sources, rebind them to a different shortcut
   (e.g., Cmd+Space is Spotlight by default but can be swapped).

After this change, Ctrl+Space will work immediately on the first press in
IntelliJ and all other applications.

> **Note:** This also affects Ctrl+Alt+Space (`ClassNameCompletion` in
> IntelliJ). Disabling the macOS binding for that key too ensures it works
> reliably.


## Quick Reference

### Emacs Essentials (inherited from parent)

| Key | Action |
|-----|--------|
| Ctrl+A / Ctrl+E | Beginning / End of line |
| Ctrl+F / Ctrl+B | Forward / Back one character |
| Ctrl+N / Ctrl+P | Next / Previous line |
| Alt+F / Alt+B | Forward / Back one word |
| Ctrl+K | Kill to end of line |
| Ctrl+Y | Yank (paste from kill ring) |
| Alt+Y | Yank pop (cycle kill ring) |
| Ctrl+W | Kill region (cut selection) |
| Alt+W | Copy region (without killing) |
| Ctrl+Space | Set mark |
| Ctrl+G | Cancel / Keyboard quit |
| Ctrl+S / Ctrl+R | Incremental search forward / backward |
| Ctrl+X Ctrl+S | Save |
| Ctrl+X Ctrl+F | Open file (Goto File) |
| Ctrl+X K | Close tab |
| Ctrl+X B | Switch buffer (Switcher) |
| Ctrl+X 2 / 3 | Split horizontal / vertical |
| Ctrl+X 1 | Unsplit all |
| Ctrl+X O | Next splitter |
| Ctrl+X H | Select all |
| Alt+X | Goto Action (M-x) |
| Alt+/ | Code completion |
| Alt+; | Comment by line |
| Alt+% (Alt+Shift+5) | Find and replace |
| Ctrl+/ | Undo |

### Mac Essentials (added by this keymap)

| Key | Action |
|-----|--------|
| Cmd+C / Cmd+V / Cmd+X | Copy / Paste / Cut |
| Cmd+Z / Cmd+Shift+Z | Undo / Redo |
| Cmd+A | Select all |
| Cmd+S | Save all |
| Cmd+W | Close tab |
| Cmd+F | Find |
| Cmd+G / Cmd+Shift+G | Find next / previous |
| Cmd+Shift+F | Find in path |
| Cmd+Shift+R | Replace in path |
| Cmd+O | Goto class |
| Cmd+Shift+O | Goto file |
| Cmd+Alt+O | Goto symbol |
| Cmd+L | Goto line |
| Cmd+B | Goto declaration |
| Cmd+Shift+B | Goto type declaration |
| Cmd+[ / Cmd+] | Navigate back / forward |
| Cmd+Left / Cmd+Right | Line start / end |
| Cmd+Shift+Left/Right | Select to line start / end |
| Cmd+Up / Cmd+Down | Show nav bar / Edit source |
| Cmd+Shift+[ / Cmd+Shift+] | Previous / Next tab |
| Cmd+1 through Cmd+9 | Activate tool windows |
| Cmd+0 | Commit tool window |
| Cmd+, | Settings |
| Cmd+; | Project Structure |
| Cmd+Q | Quit |
| Cmd+M | Minimize window |
| Cmd+Ctrl+F | Toggle full screen |
| Cmd+` | Next window |
| Cmd+N | New element / Generate |
| Cmd+Shift+N | New scratch file |
| Cmd+E | Recent files |
| Cmd+R | Rerun / Refresh |
| Cmd+Ctrl+R | Rerun tests |
| Cmd+F2 | Stop |
| Cmd+Y | Quick definition |
| Cmd+Alt+L | Reformat code |
| Cmd+Shift+/ | Block comment |
| Cmd+Alt+[ / Cmd+Alt+] | Code block start / end |
| Cmd+Ctrl+G | Select all occurrences |
| Ctrl+Tab | Switcher |

### Run & Debug

| Key | Action |
|-----|--------|
| Ctrl+Shift+R | Run current class/test |
| Ctrl+Shift+D | Debug current class/test |
| Ctrl+Alt+R | Choose run configuration |
| Ctrl+Alt+D | Choose debug configuration |
| Cmd+Alt+R / F9 | Resume (debugger) |
| Cmd+F2 | Stop |

### Code Intelligence

| Key | Action |
|-----|--------|
| Alt+/ | Code completion |
| Ctrl+Shift+Space | Smart type completion |
| Ctrl+Alt+Space | Class name completion |
| F1 / Ctrl+J | Quick documentation |
| Alt+Space / Cmd+Y | Quick definition |
| Ctrl+Shift+P | Expression type info |
| Ctrl+H | Type hierarchy |
| Ctrl+Alt+H | Call hierarchy |
| Ctrl+T | Refactoring quick list |
| Ctrl+Shift+J | Join lines |
| Alt+Shift+G | Goto class (Emacs-style) |
| Ctrl+Alt+G | Goto declaration (Emacs-style) |

### Selection & Multi-cursor

| Key | Action |
|-----|--------|
| Ctrl+Space | Set mark (Emacs selection) |
| Alt+Up / Alt+Down | Expand / Shrink selection |
| Ctrl+Alt+W | Expand selection (alternate) |
| Cmd+Ctrl+G | Select all occurrences |
| Ctrl+Shift+Up/Down | Select paragraph forward/backward |

### Structural Navigation

| Key | Action |
|-----|--------|
| Ctrl+Alt+A | Method up (beginning of defun) |
| Ctrl+Alt+E | Method down (end of defun) |
| Ctrl+[ / Ctrl+] | Code block start / end |
| Ctrl+Alt+[ / Ctrl+Alt+] | Code block start / end (alternate) |
| Cmd+Alt+[ / Cmd+Alt+] | Code block start / end (Mac-style) |
| Alt+Left / Alt+Right | Previous / Next word |
| Alt+Shift+Left/Right | Select previous / next word |
| F2 / Ctrl+X ` | Next error |
| Shift+F2 | Previous error |
