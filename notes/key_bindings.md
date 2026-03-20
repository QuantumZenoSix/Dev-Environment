# Key Bindings Reference  

Leader key for vim/neovim: `<space>`  
Leader key for Wezterm: `<C-W>`  
This means window management is verly similar - <C-W> for window actions in Wezterm's multiplexer and <C-w> for window management within vim/nvim (keys for splits, movement, remain the same).  


# Table of Contents


---

# Shell
## Apache  
`apachelogacc` - tail -n15 -f /var/log/apache2/access.log  
`apachelogerr` - tail -n15 -f /var/log/apache2/error.log  
`apacherestart` - sudo service apache2 restart  
`e0` - tail -f -n 0 /var/log/apache2/error.log  
`ee` - tail -f /var/log/apache2/error.log  
`er` - watch egrep -i 'DBD::' /var/log/apache2/error.log  
`rr` - sudo service apache2 restart && echo 'Apache Restarted!'  
`re` - rr && ee  
`tomahawk` / `tt` - (custom script - possibly a music player or search tool)  


## Custom  


`_` - sudo  
`ps1_powerline` / `ps1_starship` / `ps1_ohmyposh` - Keep ohmyzsh as shell environment and switch prompt customizer between powerline10k, ohmyposh, and starship (catppuccin mocha).   
`ccat` - colorize_cat  
`ch` - /home/bobby/bin/cht.sh (command-line client for cheat.sh cheat sheets). Example `ch perl/array`  
`chatgpt` - [custom] - CLI interface to ChatGPT/OpenAI  
`cless` - colorize_less  
`create_and_assume_user` - [custom] self-explanatory (note: adds user to sudo group)  
`colorme` - [custom] Pipe to this to color your text  
`csvlens` - Interactive CSV file viewer  
`diffy` - [custom] see diff between two files (side-by-side)  
`dirsync` - [custom] Directory synchronizer (sync files between directories)  
`docx_to_md` - [custom] self-explanatory  
`docker_force_old_version` - [custom] Set Docker version environment variable to 1.43  
`dockbuntu` - [custom] Spin up quick ubuntu container (with sudo, vim, git, curl, and wget)  
`mp3_dl` - [custom] Download MP3 audio from youtube URL  
`egrep` - egrep --color=auto (grep -E)  
`eget` - Easy binary downloader from GitHub releases  
`ff` - (fuuzzy finder) fzf --height 40% --layout reverse --border  
`fgrep` - fgrep --color=auto  
`fv` - 'fuzzy-vim' fuzzy-find a file in the pwd to open with nvim. `nvim $(fzf --height 40% --layout reverse --border)`  
`fzf` - General-purpose command-line fuzzy finder  
`ggh` - SSH connection manager  
`grok` - [custom] - xAI Grok CLI  
`lazydocker` - Simple terminal UI for managing Docker  
`lazygit` / `lg` - Simple terminal UI for git commands  
`lazysql` - lazy-based SQL tool  
`ollama` - Run and manage large language models locally (CLI for Ollama)  
`pandoc` - Universal document converter (markup to markup/PDF/etc.)  
`perltidy` - Indent and reformat Perl scripts  
`postboy` - [custom] Simple CLI-based API tool  
`posting` - Postman in CLI  
`posty` - [custom] Wrapper for posting with saved collections  
`qc` / `quickconnect` - [custom] quickconnect - ssh and rdp in cli  
`reposync` - [custom] ------- SEARCH  
repo synchronization tool  
`scpdownloads` - [custom] cd ~/Documents/SCP-Downloads  
`spf` - (custom script - possibly SPF checker or sender policy framework tool)  
`sqlcmd` - Microsoft SQL Server command-line query tool  
`ssh_keyupdate` - [custom] (complex ssh-agent + ssh-add command)  
`starship` - Cross-shell prompt (customizable prompt engine)  
`tmux` - tmux -2  
`update_lazy` - [custom] self-explanatory  
`upandup` - [custom] sudo apt update && sudo apt upgrade  
`update_aws_creds.sh` - (custom script - updates AWS credentials)  
`vscode-cleanup` - [custom] cleans VS Code cache/data  
`vscode-cleanup-all` - [custom] cleans VS Code cache/data - all  
`vscode-cleanup-pbx` - [custom] cleans VS Code cache/data - pbx  
`which-command` - whence  (?)  
`yt-dlp` - Feature-rich command-line audio/video downloader  
`wcp` - [custom] Copy from WSL to Windows host  
`wcp` - [custom] Copy from WSL to Windows host  
`uv_start` [custom] - Initializes a uv virtual env and syncs dependencies  

## Diagnostics  
`pscpu` - ps auxf | sort -nr -k 3  
`pscpu10` - ps auxf | sort -nr -k 3 | head -10  
`psmem` - ps auxf | sort -nr -k 4  
`psmem10` - ps auxf | sort -nr -k 4 | head -10  

## Terminal Buffer Manipulation  
`Ctrl+x+e` - Open temp buffer to run in cli (can run on previous commands or whatevs is in cli)  
`fc` - edit your lsat command in $EDITOR  

## Dir navigation  
`...` - cd ../../../  
`....` - cd ../../../../  
`.....` - cd ../../../../  
`......` - ../../../../..  
`.4` - cd ../../../../  
`.5` - cd ../../../../..  
`..` - cd ..  
`-` - cd -  
`1` - cd -1  
`2` - cd -2  
`3` - cd -3  
`4` - cd -4  
`5` - cd -5  
`6` - cd -6  
`7` - cd -7  
`8` - cd -8  
`9` - cd -9  
`callouts_to_list` - (custom script - converts callouts/markdown to list format)  
`cb` - clipboard manager. See `cb -h`  
`l` - ls -lah  
`la` - ls -lAh  
`ll` - ls -lh  
`ls` - ls --color=tty  
`lsa` - ls -lah  
`md` - mkdir -p  
`mkdir` - mkdir -pv  
`pls` - ls with pretty output  
`rd` - rmdir  
`cd` - 'cd' is now bound to 'z' (zioxode)  
`cdi` - to view zioxide interactive list  

<br />  

### Git  

`git_apply_stash_by_name`  
`git_merge_changes_from_stash`  
`git_fixconflict`  
`git_addcommit` - Stage and commit  
`git_reset` - Re-track current branch to repo  
`git_discard_old_stashes` - Current stash count (keeping latest 10)  
`lg` - Lazygit  
`showmerges` - Shows last 15 merges  
`showmerges` - git log --oneline --merges -E --grep 'DEV-[0-9]+' -n 15  
`git_force_push` - Add ssh key to agent and push  
`gc` - 'Git Clean' - drop all local changes - head to master, git pull, and restart apache  


## Oh-my-ZSH Plugins  
- `ccat/cless` - colorized cat+less  
- `copyfile` - copy file contents to system clipboard  
- `<C-o>` - copy cmdline contents to system clipboard (copybuffer) 
- `copypath` - copy file path  
- Allows pressing `<C-z>` again to switch back to a background job.  


## Nvim  
`config_sync_alpha` - Push local nvim config changes up to alpha machine  
`local_config_save` - Update local nvim config with latest from repo  
`local_config_update` - Update local config files with latest from repo (doesn't replace ~/.config/nvim and keeps cache)  
`local_config_update_and_nvim_update` - Update local config files and nvim config with latest from repo (replaces ~/.config/nvim and removes cache)  
`edit_nvim_conf` [custom] - open nvim in ~/.config/nvim/  
`nv` - NVIM_APPNAME=nvim-lazy nvim  
`nvim` - Neovim text editor  
`nvim-custom` - [custom] NVIM_APPNAME="nvim-custom" nvim  
`clear_nvim_swaps` - [custom] self-explanatory  
`fv` - fuzzy find a file to open with nvim  

<br />  

## PBX [custom]  
`clear_wgets`  
`download_veeam_report` -  
`perly` - /usr/bin/perl /home/control-io/www/DevSandbox/Sandbox/_templates/perly.pl  
`perlyprod` - /usr/bin/perl /home/control-io/www/DevSandbox/Sandbox/_templates/perlyprod.pl  
`prod_scratch` - /usr/bin/perl /home/control-io/www/DevSandbox/Sandbox/_templates/prod_scratch.pl  
`rl` - tail -f /home/control-io/www/log/templog  
`rl2` - tail -f /home/control-io/www/log/templog2  
`reposync_thisdir_to_alpha` - reposync . alpha ongoing  
`restarthive.sh` - (custom script - likely restarts a Hive service)  
`restart_hive`  
`perlygrep`  


---  
<br />  

# Wezterm (for multiplexing)  
- Leader key: `Ctrl-Space`  
- `<C-T>` - New window (tab)  
- `<C-R>` - Reload conf script  
## copy mode options (so vimmy)    
- `<Ctrl-X>` - Enter copy mode  
- `<C-F>` - Start search (once in copy mode)   
  - Enter search term and then `<Enter>` (then use `<C-n>`/`<C-p>` to search throughout matches  
  - End search: `Esc`  
- `g` - go to top of pane (scrolls to top)  
- `G` - go to the bottom of the file (scrolls to bottom)  
- `<C-u>` / `<C-d>` - act as they do in vim  

## Panes  
- Split Windows Vertically: `<leader> v` (like vim)  
- Split Windows Horizontally: `<leader> s` (like vim)  
- Navigate subwindows (panes): `<alt> <arrow-key>` (like vim)  
- Zoom/Unzoom panes: `<C-Z>`


---  
<br />  

# TMUX  (no longer using)
## TMUX Configuration and Plugins  
- Enable TMUX plugins by install TPM: `https://github.com/tmux-plugins/tpm`  
- Reload config file: `tmux source ~/.tmux.conf`  
- Reload TMUX environment: `<C-i>`  _For re-loading Theme for example_  
- Custom Bind key I've set: `<C-t> R`  
- Open cheat.sh: `<bind-key> S`  

## Tmux copy mode options (so vimmy)    
- `<bind-key> [` - Enter copy mode  
- `/`/`?` - Start search (once in copy mode)   
  - Enter search term and then `<Enter>` (then use `n`/`N` to search throughout matches - search starts at top of page, use `N` to search backwards)  
  - End search: `q` 
- `g` - go to top of pane (scrolls to top)  
- `G` - go to the bottom of the file (scrolls to bottom)  
- `<C-e>` / `<C-y>` / `<C-u>` / `<C-d>` - act as they do in vim  
- Paste (from tmux buffer): `<bind-key> ]`  
- Paste (from system clipboard): `<C-S-v>`  

__Neovim and Cli quick copy commands__  
- Tmux quick copy (from cli to system clipboard): `Mouse select + y (while selecting)`  
- Neovim copy (clipboard) => `Select (mouse/v) + y`  

## TMUX Panes  
- Split Windows Vertically: `<bind_key> |`  (with my conf I use `|` instead of `%`)  
- Split Windows Horizontally: `<bind_key> _`  (with my conf I use `_` instead of `"`)  
- Navigate subwindows (panes): `<bind_key> <arrow-key>`  
- Show pane numbers: `<bind_key> Q`  
- Move current pane left: `<bind_key> {`  
- Move current pane right: `<bind_key> }`  
- Zoom in/out to make pane full screen: `<bind_key> z`  
- Close pane: `exit` or `<C-b> z`  

---  

## TMUX Sessions  
- Open tmux as a named session: `tmux new -s <name>`  
- To detach a tmux session: `<bind_key> D`  
- View tmux sessions (from cli): `tmux ls`  
- Re-attach to session (from cli): `tmux attach -t 0`  
- Rename tmux sessions (from cli): `tmux rename-session -t 0 <name>`  
- Killing tmux sessions (from cli): `tmux kill-session -t 0 <name>`  
__Where ‘0’ is your session id/name__  

## TMUX Windows  
- Rename Window: `<bind_key> ,`  
- Create new Window: `<bind_key> c`  
- Show all Windows: `<bind_key> S`  
- Show all Windows (with preview): `<bind_key> w` _Enter to select_  
- Switch between windows: `<bind_key> <number>`  
- Close Window: `<bind_key> &` (or `exit` if all panes are closed)  

# Vim  

## Vim General Commands  
- `ter[minal]` - Open terminal (may need to hit `i` to beging typing)  
- `exit` / `<C-d>` then `<C-w> q` - to close terminal window  
- `:verbose map Q` - see what is mapped to the `Q` key  
- `<C-\> <C-n>` - Exit "terminal mode".  

_On "Ctrl-\ Ctrl-n"_  
This key combination switches the terminal buffer from terminal-insert mode (where you interact with the shell) to Vim’s normal mode. In normal mode, you can use Vim commands like :hide, navigate windows, or edit other buffers. In terminal-insert mode, Vim passes most keystrokes directly to the shell, so you can’t use Vim commands like :hide until you enter normal mode.  
`<C-\>` is a special prefix in Vim’s terminal mode to signal a command to Vim itself rather than the shell.  
`<C-n>` (or Ctrl-N) tells Vim to switch to normal mode.  
You’ll notice the cursor behavior changes, and Vim’s command line becomes available (e.g., you can type : to enter commands).  
Visual cue: In normal mode, the terminal buffer becomes “read-only” from Vim’s perspective, and you can’t type into the shell until you return to insert mode (e.g., by pressing i).  

There are loads of good vim cheat sheets out there and this isn't a substitution, but rather a list of common/handy ones I've found to be efficient on my workflow.  
[Ultimate Cheat Sheet](https://catswhocode.com/vim-cheat-sheet)  
[LeanXinY](https://learnxinyminutes.com/docs/vim/)  
[vim.rtott](https://vim.rtorr.com/)  
[DevHints-vim](https://devhints.io/vim)  


## Modes_  
- `<C-b>` - Visual-Block mode (Ctrl+B)  
- `<S-v>` - Visual Line Mode  

---  


## Bare Vim  
(common settings to apply on a ad-hoc plain vim editor)


```vim  
colo slate  
set number/relativenumber  
set mouse=a  
set ignorecase  
set hlsearch  
set incsearch  
set cursorline  

# Additional
syntax on
filetype on
set wrap! (toggle on of off)
```


## Vim File Explorer (netrw)  
- `:Explore` - Explorer (opens file tree)  
- `:Vex` - Vertical Explorer (opens file tree)  
- `i` - Rotate betweeb views (3rd is tree mode)  
- `v` - Open file in vertical split (opens to left by default unless `set splitright` is set  
- `u` - Go up one level  

## Vim File and Buffer Management  
#### Finding Files
- `:args **/*filename*.pl` - Search for file by partial name and file type recursively  
- `<C-q>` - Adds :args results to Quickfix list (keybinding)  

#### Working with vim cmd/shell
- `<C-r>3` - Paste from 3 register (in insert mode or into vim command line). Useful for pasting into a search regex  
- `:read !<shell_command>` - Paste shell output into buffer.  
- `:g/function/d` - Delete all lines matching the pattern 'function'  
- `q:` - Opens a buffer of previous commands to execute (with enter key)  
- `q/` - Opens a buffer of previous searches to execute (with enter key)  
- `<C-l>` - Move window to far left  
- `<C-w>` - delete previous word  

#### Managing Changes
- `:wa` / `wall` - ("write all") save all open buffers  
- `:e!` - erase all unsaved changes  
- `:bufdo e!` - erase all unsaved changes (in all open buffers)  
- `u` - undo last change (normal mode)  
- `<C-u>` - undo last change (insert mode)  
- `<C-r>` - Redo  
- `:w !diff %` or `:w !git diff --no-index % -` - view changes in vim before saving (or add this in .vimrc `command Diff execute 'w !,且git diff --no-index % -'`)  
- `:earlier 2h` - [Time-based undo] Reverts file to state 2hours ago (can use `m` or `s` for minutes/seconds)  
- `:later 2h` - [Time-based redo] Reverts file to state 2hours ago (can use `m` or `s` for minutes/seconds)  

### Buffers
- `:E` - Open file nav (short for `explore`)  
- `:e ~/.vimrc` - edit a file by name (short for `:edit`).  
- `:e` - reload current buffer from disk  
- `:e!` - Remove all unsaved changes  
- `:vert ba` - edit all buffers as vertical windows  
- `:tab ba` - edit all buffers as tabs  
- `gf` - Find and open the file by filename under cursor  
- `<C-^>` (which is Ctrl+6) - swap back and forth between current (#) and alternate (a%) buffers.  
- `:b6` - Go to buffer 6  

### Viewing Buffers
- `:b` then `<C-d>` - show all open buffers to cycle though.  
- `:ls` - view buffers or (`buffers` with plugin)  

### Switching Buffers
- `:b file1.txt` - Select by filename (tab shows open buffers, but can open new files as well)  
- `:bn` - rotate to next buffer.  
- `:bp` - rotate back to previous buffer.  
- `:b3` - Select buffer #3 (may need to force with `b!3`).  
- `:bf` or `:bl` - go to first/last buffer (f/l)  
- `:badd myfile.txt` - add a new buffer by filename  

### Deleting Buffers
- `:bd myfile.txt` - delete a buffer by buffer number or filename  
- `:%bd` - Delete all open buffers  

## Windows and Panes  
### Tabs
- `:tabnew` or `:tabnew {file}` - open a file in a new tab  
- `<C-w> T` - move the current split window into its own tab  
- `gt` - move to the next tab  
- `gT` - move to the previous tab  
- `2gt` - switch to tab #2  
- `:tabc` - close the current tab and all its windows  
- `:tabo` - Tabonly - close all tabs except for the current one  
- `:tabdo {cmd}` - run the command on all tabs (e.g. :tabdo q - closes all opened tabs)  

### Windows
- `<C-w> s` - Split open buffer horizontally  
- `<C-w> v` - Split open buffer vertically  
- `:vert sb {filename}` - Split buffer with another open buffer (you can enter file name or use tab to cycle through open buffers)  
- `:e {filename}` - Edit filename in current window  
- `:sp {filename}` - Split the window and open filename (if empty just splits the same buffer)  
- `:vs file` - Vertically split window  (enter open/unopened file)  

### Managing Windows
- `<C-w> q` or `:clo` - Close current window  
- `<C-w> <up>` - Put cursor in top window (works for any direction)
- `<C-w> w` - Focus on next window  
- `<C-w> w` - Switch to next window  
- `<C-w> H` - Make Leftmost full  vertical window  
- `<C-w> L` - Make Rightmost full  vertical window  
- `<C-w>=` - Gives the same size to all windows  
- `<C-w>|` - Current window width = 100%  
- `50<C-w>|` - Current window width = 50% of initial window width  
- `<C-w>_` - Maximize current window vertically  
- `:only` - Close all windows, except current  
- `hide`/`unhide` - Hide/Unhide a window (only 1)  
- `:qa` - Quit All open windows (exits vim if on last tab)  

### Folding    
- `zf` - Create a fold from selected lines  
- `zf10j` - Create fold from current line to 10 lines down  
- `zc` - fold a block of code (z = fold and c = close)  
- `zo` - unfold a block of code (z = fold and c = open)  
- `zM` - fold all blocks in buffer  
- `zR` - unfolds all in buffer  


## Vim Navigation  

### Moving along line
- `t{` - Move to next `{` and use `;` to see sebsequent match (and `,` for previous match)  
- `e` - end of word  
- `E` - end of word (punctuation included)  
- `{` / `}` - Move up/down in paragraphs  

### Moving along file
- `gg` - Go to top of file  
- `G` - go to bottom of file  
- `: {num}` - Go to line  
- `zz` - Center screen with cursor position (don't confuse with ZZ - save)  
- `I`/`A` - Go to begin/end of line  
- `{`/`}` - move up/down along chunks of text (paragraphs)  
- `gd` - go to definition (where func/sub is defined)  
- `<C-o>` / `<C-i>` - Jump forward/backward in jump list (`:jumps`)  

### Markers
- `<leader> rm` - Remove markers  
- `:marks` - View all markers  
- `:cc 22` - View the 22nd quickfix item  
- `'` - View all markers w/explanations [🔌]  
- `m {a-z}` - Setting markers/waypoints as {a-z}  
- `'{a-z}` - Move to marker/position {a-z}  
- `:delm!` - vim clear all marks (or specific ranges like `:delm a-zA-Z0-9`)  
- `''` - Move to previous marker position  (thats two single quotes in succession, not a single double quote)  
Note: Lowercase markers are local to a file and uppercase markers are global across all files. Meaning you can re-use `a` for different places in different files but `A` only refers to one place in a single file.  

## Vim Searching and Replacing  
#### Searching
- `/` - Search (grep): type text and enter then `n`/`N` to iterate through matches  
- `<C-q>` - Save search results in a quickfix list (we can even grep the quick fix list with `/`)  
- `cn`/`cp` - Next/Previous item in quickfix list. Mapped to `F11`/`F12`.  
- `<C-r> "` - Yanks the unamed register into the search box. This will paste in anything yanked.  

#### Searching, replacing, and RegEx
- `\r` - This represents newline  
- `:%s/(foo)/\1\r` - Replaces matches with itself followed by a newline ('%' represents every occurence in the buffer)  
- `:s/old/new/g` - When text is selected you can use a replace (without the %) to replace text within the selected range (use `gc` to replace with confirmation first)  
- `:s/\VTEXTOMATCH/REPLACEWITHTHIS/` - The `\V` (very no magic mode treats all characters literaly except the `\`  
- `:s/\v\w+/` - The `\v` (very magic mode treats most special cahrs as special - as in regular regex  
- `:s/old/new/g22` - Replace 'old' with 'new' every every occurence in a line (g) including the next 22 lines.  
- `:noh` - "No Highlighting" - remove highlited matches  
- `:vim /function/ **/*.pl` - Grep all matches of `function` in every '.pl. file in current dir (recursively). Then `:cope` to create a QuickFix list  
- `:vim /\Vfunction/ /home/ubuntu/**/*.pl` - Grep all matches of `function` in every '.pl. file in current dir (recursively). Then `:cope` to create a QuickFix list  
- `:g&` - Apply previous replace action to the entire file  
- `:grep '^sub run_powershell' -g \*.pl` - Regex search using grep on perl files  
- `:grep '^sub run_powershell' -g '{*.pl,*.pm}'` - Regex search using grep on perl files (ripgrep)  
- `:grep -E '^sub run_powershell' *.pl` - Regex search using grep on perl files  (posix grep) Use `:grep text %` to search current buffer  

Notes  
- `:s/foo/bar/` - replace 1st occurrence on current line  
- `:%s?foo/bar/` - replace 1st occurrence on every line  
- `:.,$s?foo/bar/` - replace 1st occurrence on every line until end of buffer  

#### Quickfix list commands
- `:cope` - open quickfix list  
- `:cclose` - close quickfix list  
- `:cnext` / `:cn` - go to next quickfix list item  
- `:cprevious` / `:cp` - go to previous quickfix list item  
- `:s/foo/bar/g` - replace text on a highlighted quickfix line  
- `:cdo s/foo/bar/g` - replace text on all quickfix list items (globally - every occurence in each line)  
- `:cdo s/foo/bar/gc` - replace text on all quickfix list items (globally - every occurence in each line)  - with confirmation  

### Finding Multiple Occurrences  
1. Select text (in visual mode)  
2. `#` to highlight all occurences (can use `*` but that begins at next occurence)  
3. `n`/`N` to select next/previous occurences  
4. `v` again to select the highlighted occurence  

### Change multiple instances without multi-cursor  
1. Select text to change  
2. `#` to highlight all matches (selects next match)  
3. Make sure you're in normal mode  
4. `cgn` - change globally (when done changing, press `Esc` to exit insert mode)  
5. `.` to change every subsequent match.  

_(Can also use dgn to delete multiple references)_  

## SYDC (Selecting/Yanking/Deleting/Changing)
- `gv` - Re-select last selected text  
- `viw` - selects just the word.  
- `vaw` - selects the word plus any surrounding whitespace.  
- `<C-r>w` - Copy whatever word is under cursor and paste into vim command line. (Useful for pasting into a search regex)  
- `o` - Reverse order while continuing to select (switches cursor between start/end of selected text)  
- `/<term>` - While in visual mode, select lines based on RegEx  
- `<C-v>` - enter visual block mode. Once text is selected enter insert mode (`a`/`A`,`i`/`I`,`c`/`C`,`p`/`P`,`o`/`O` etc) and make changes. They will appear on the first line, but once you hit Esc those changes will be made to all selected lines.  
- `gs{char}` - Global surround. Example: Select text then `gs"`  
- `d` or `dd` - Cuts (Deletes and yanks)  
- `D` / `d$` - Cut to end of line  
- `Y` / `y$` - Yank/Copy to end of line  
- `C` - Cut to end of line  
- `:m 5` - Move line under cursor (or selected lines) to line 5  
- `:2,7m 5` - Move lines 2-7 to line 5  
- `vib` - Select inside next `()` occurrence (works with `y`/`d`)  
- `viB` - Select inside current `{}` (works with `y`/`d`)  

#### Multi-Line
- `10y` - Yank 10 lines  
- `10d` - Delete 10 lines  
- `10V` - Select 10 lines  

#### Mass Select
- `ggVG` - Select entire file  
- `:1,500y` - Copy everything from line 1 to 500 (use `d` for delete) (can start/end on any line - usefull for slicing bits)  

#### Continguous Lines of text (paragraph)
- `yap` - Yank with newlines  
- `yip` - Yank without newlines  
- `cap` - Change with newlines  
- `cip` - Change without newlines  
- `dap` - Delete with newlines  
- `dip` - Delete without newlines  
- `vii` - Selects the "inner indent" block (lines with the same indentation level as the cursor, excluding surrounding blank lines)  
- `vai` - Selects "a indent" block (includes the inner block plus the lines immediately above/below with less indentation, like a function definition).  

#### Registers: Viewing/Yanking/Pasting
- `:reg` - View registers (vim)  
- `"0p` - Paste from 0 register (in normal mode)  
- `"2p` - Paste 2nd to last thing yanked (grabs from 2 register in normal mode)  
- `"_dd` - Delete line and yank to black hole register (keeps registers the same).  
- `"1yiw` - Yank word under cursor into register 1  
- `ayy` - Yank line to "a" register (overwriting register a).  
- `Ayy` - Yank line to "a" register (appending to register a)  
- `"+y` - Yank text into system clipboard  
- `<C-r> *` - put the clipboard contents (X11: primary selection)  
- `<C-r> +` - put the clipboard contents  
- `<C-r> /` - put the last search pattern  
- `<C-r> :` - put the last command-line  
- `<C-r> "` - Paste from unamed register (anything yanked). Works in insert mode and command mode  

_Note: '^J' in a register will be changed to a newline when pasting._  

### Brackets && Braces  
- `%` - Select top/bottom of current block  
- `v%` - Select Content within parens/brackets (inclusively) if you're right before a bracket.  
- `vi{` - Selects everything within the block... then Esc to leave you at ending "}"  
- `ci{` - Change text inside brackets (exclusively)  
- `ca{` - Change text inside brackets (inclusively)  
- `yi{` - Yank text inside brackets (inclusively)  
- `ya{` - Yank text inside brackets (exclusively)  
- `di{` - Delete text inside brackets (inclusively)  
- `da{` - Delete text inside brackets (exclusively)  
- `{action}ab` - (y)ank/ (d)elete, (v)isual select entire block of code including lines where curly braces are on. Or, `zcdd` (zc to fold the block and dd to cut).  
- `[{` - Go to opening containing curly brace (can use repeatedly)  
- `]}` - Go to closing containing curly brace (can use repeatedly)  

## Editing    
- `ciw` - Change inner word (replace)  
- `xp` - swap two adjacent letters (move letter cursor one place to the right)  
- `J` - Merge lines: Apend line below to the end of the current line.  
- `cc` - change entire line.  
- `dt/<searchterm>` - Delete text up until search term  
- `:sort` - Sort selected lines (`!sort` for reverse order)  
- `:norm I#` - Insert a '#' at the start of each selected line  
- `:norm A;` - Append a ';' to the end of each highlited line  
- `:norm I/* A */` - Insert '/*' at the start of each selected line and append '*/' at the end of each selected line  
- `:g/error/norm I#` - Insert a '#' at the start of each line that matches the pattern /error/  
- `ct{` - Change everything from cursor position to next `{` occurence  

### Casing/Capitilization  
- `gu` / `gU` - Lowercase/Uppercase character under cursor  
- `guiw` / `gUiw` - Lowercase/Uppercase word under cursor  
- `guu` / `gUU` - Lowercase/Uppercase entire line  
- `u` - Selected text to lower case  
- `U` - Selected text to upper case  
- `~` - Inverse casing of selected text/character under cursor.  
- `g~w` - change case of word (until whitespace)  
- `g~~` - change case of entire line  

### Identing  
- `<<`/`>>` - Indent code left/right  
- `==`/`=` - Auto indent code (`==` for one line and `=` for multiple lines)  

### Sorting  
- `:sort` - Sort all lines  
- `:sort!` - Sort all lines in reverse  
- `:sort u` - Sort all lines and remove duplicates  
- `:sort`/`:sort!` - When lines are selected, this will sort in ASC/DESC order respectively.  

### Indenting  
- `=` - Auto-Indenting (based on rules - works on selected text as well)  
- `=ap` - Auto-Indent Paragraph  
- `<` - Indent Left  
- `>` - Indent Right  

### Numbers  
- `<C-a>` - Increment Highlighted Numbers  
- `<C-x>` - Decrement Highlighted Numbers  
- `g<C-a>` - Increment Highlight Numbers in sequence (each matched item will increment one more than previous match).  
- `g<C-x>` - Decrement Highlight Numbers in sequence (each matched item will increment one more than previous match).  

## Vim Macros and Automation  
- `q<letter>` - start recording a macro  
- `q` - stop recording a macro  
- `@<letter>` - execute macro (once)  
- `@@` - Rerun the last ran macro  
- `<number>@<letter>` - To execute the macro <number> times  
- `:3,9 normal @b` - Run macro "b" on lines 3-9.  
- `:reg <macro_letter>` - View register (holds macros as well - note '[^' represents the Esc key)  
- `@:` - re-run last vim command  
- `.` - re-run last command in normal mode  

### Best Practices when recording macros  
- Once recording has started, type `0` to begin at the beginning of the line.  
- Once done with commands, type 'j' before you finish recording to ensure ending on the next line (in case this macro runs multiple times).  

## Commenting/Uncommenting  

### Uncommenting  
- Put your cursor on the first comment character (like #), and enter Visual-Block mode (`<C-b>` for me)  
- Go down until the last commented line and press `x`  

### Commenting  

_Option 1_  
- Enter Visual-Block mode (`<C-b>` for me) then enter `:s/^/#/`  

_Option 2_  
- Enter Visual-Block mode (`<C-b>` for me)  
- Go down until last line and press `I`, then press `#` (or other comment character), then `Esc`.  

<br />  

## Vim Troubleshooting  
- `:highlight Delimiter` - See what styles apply to the "Delimiter" highlightgroup  
- `:highlight Delimiter` - See what styles apply to the "Delimiter" highlightgroup (verbose)  
- `:echo synIDattr(synID(line("."), col("."), 1), "name")` - See highlight group applying to item under cursor  
- `:echo map(synstack(line("."), col(".")), 'synIDattr(v:val, "name")')` - See all highlight groups that could apply to item under cursor  

_Note: `<C-...>` should be taken to mean `Ctrl+`. All other keys are to be entered in succession (not simultaneously)._  

---  

# Neovim Keybindings  

- `:source $MYVIMRC` - Reload config (and plugins) without restarting nvim  
- `:MarkdownPreview` - View MarkdownPreview in browser [🔌 Markdown-Preview]  
- `<leader> ` or `<C-^>` (which is `Ctrl+6`) - swap back and forth between current (`#`) and alternate (`a%`) buffers. [🔌]  
- `<leader>u` - undotree  


## Custom Motions  (using leader) 

| Key              | Action / Command                               | Description                                          |  
|------------------|------------------------------------------------|------------------------------------------------------|  
| `<leader>ld`     | `:set nonumber norelativenumber`               | Disable line numbers                                 |  
| `<leader>le`     | `:set number relativenumber`                   | Enable line + relative numbers                       |  
| `<leader>ll`     | Toggle number + relativenumber                 | Toggle line numbers (both modes)                     |  
| `<leader>h`      | `:nohlsearch<CR><esc>`                         | Clear search highlight                               |  
| `<leader>rm`     | `:delm a-zA-Z0-9`                              | Remove all marks                                     |  
| `<leader>tb`     | `:highlight Normal guibg=NONE ctermbg=NONE`    | Set transparent background                           |  
| `<leader><down><down>` | `20<C-e>`                                | Jump down 20 lines                                   |  
| `<leader><up><up>`     | `20<C-y>`                                | Jump up 20 lines                                     |  
| `<leader><leader>` | `:Neotree toggle`                            | Toggle Neo-tree file explorer                        |  

### Change / Replace Word Variants  

| Key       | Action                                          | Description                                          |  
|-----------|-------------------------------------------------|------------------------------------------------------|  
| `<leader>cw`  | `*Ncgn`                                     | Change next occurrence of word under cursor          |  
| `<leader>cW`  | `* \| :%s::`                                | Replace all occurrences of word (whole doc)          |  
| `<leader>aw`  | `yiw \| :%s:\V<C-r>":<C-r>"`               | Append to all occurrences of word                    |  
| `<leader>cy`  | `:%s:\V<C-r>":`                             | Replace all with last yanked text                    |  
| `<leader>ay`  | `:%s:\V<C-r>":<C-r>"`                       | Append last yanked text to all matches               |  
| `<leader>fw`  | `yiw \| :vimgrep ... \| :cope`              | Find word under cursor → quickfix list               |  
| `<leader>fW`  | Telescope `grep_string` on `<cword>`            | Telescope: grep string (word under cursor)           |  
| `<leader>fs`  | Telescope `grep_string` `"sub " .. <cword>`     | Telescope: search for `sub <word>`                   |  

## Custom Motions  (non-leader) 

- `gcc` - comment out current line [🔌 vim-commentary]  
- `gc` - comment out a select range of lines [🔌 vim-commentary]  
- `gcgc` - uncomment adjacent lines [🔌 vim-commentary]  


``
| Mode | Key              | Action                                 | Description                                  |  
|------|------------------|----------------------------------------|----------------------------------------------|  
| n    | `<C-d>`          | `22<C-e>`                              | Scroll down 22 lines                         |  
| n    | `<C-u>`          | `22<C-y>`                              | Scroll up 22 lines                           |  
| n    | `<C-e>`          | `4<C-e>`                               | Scroll down faster (4×)                      |  
| n    | `<C-y>`          | `4<C-y>`                               | Scroll up faster (4×)                        |  
| n    | `E!`             | `:bufdo e!`                            | Reload (discard changes) all buffers         |  
| n    | `<C-_>`          | `:split \| resize 15 \| ... terminal`  | Open small terminal below                    |  
| n    | `<Esc>`          | `:nohlsearch<CR><Esc>`                 | Clear search highlight + normal Esc          |  
| n    | `<C-b>`          | `<C-v>`                                | Enter block-wise visual mode                 |  
| n    | `<F12>`          | `:cn`                                  | Next quickfix item                           |  
| n    | `<F11>`          | `:cp`                                  | Previous quickfix item                       |  
| v    | `>`              | `>gv`                                  | Indent + keep visual selection               |  
| v    | `<`              | `<gv`                                  | Outdent + keep visual selection              |  

## General Information  
- **ggh** — SSH connection manager  

## Git (General + LazyGit)  

| Key       | Action                          | Description                       |  
|-----------|---------------------------------|-----------------------------------|  
| `<leader>gu` | `git reset --hard HEAD~1`    | Undo last commit (hard)           |  
| `<leader>ga` | `git stash save`             | Stash current changes             |  
| `<leader>gg` | `:LazyGitCurrentFile`        | Open LazyGit                      |  

## Gitsigns (buffer-local – usually in plugin file)  

Common keys (often buffer-local):  

- `]h` / `[h` — Next / Prev hunk  
- `]H` / `[H` — Last / First hunk  
- `<leader>ghs` — Stage hunk  
- `<leader>ghr` — Reset hunk  
- `<leader>ghu` — Undo stage hunk  
- `<leader>ghp` — Preview hunk inline  
- `<leader>ghS` — Stage whole buffer  
- `<leader>ghR` — Reset whole buffer  
- `<leader>ghb` — Blame line (full)  
- `<leader>ghd` — Diff this  
- `ih` (operator-pending) — Select hunk textobject  

## Harpoon  


| Key       | Action                                  | Description                          |  
|-----------|-----------------------------------------|--------------------------------------|  
| `<leader>m`  | `harpoon.ui:toggle_quick_menu`       | Toggle Harpoon quick menu            |  
| `<leader>M`  | Telescope Harpoon menu                  | Open Harpoon in Telescope            |  
| `<leader>a`  | `harpoon:list():add()`               | Add current file to Harpoon          |  
| `<leader>N`  | `harpoon:list():prev()`              | Previous Harpoon file                |  
| `<leader>n`  | `harpoon:list():next()`              | Next Harpoon file                    |  
| `<leader>1` – `<leader>9` | `select(1..9)`      | Jump to Harpoon slot 1–9             |  

## Indent  

| Key          | Action                            | Description                     |  
|--------------|-----------------------------------|---------------------------------|  
| `<leader>ie` | `Snacks.indent.enable()`       | Enable Snacks indent            |  
| `<leader>id` | `Snacks.indent.disable()`      | Disable Snacks indent           |  
| `<leader>iee`| `:IBLEnable`                   | Enable indent-blankline         |  
| `<leader>idd`| `:IBLDisable`                  | Disable indent-blankline        |  

## LSP  

- `:LspInfo` - Get info on current LSP  [🔌]  
- `:MasonInstall <language_server>` - Use mason to install a language server [🔌 Mason]  



| Key       | Action                            | Description                             |  
|-----------|-----------------------------------|-----------------------------------------|  
| `gd`      | `definition`                      | Go to definition                        |  
| `gD`      | `declaration`                     | Go to declaration                       |  
| `gr`      | `references`                      | Find references                         |  
| `gi`      | `implementation`                  | Go to implementation                    |  
| `K`       | `hover`                           | Hover documentation                     |  
| `<C-k>`   | `signature_help`                  | Signature help                          |  
| `<leader>rn` | `rename`                       | Rename symbol                           |  
| `<leader>ca` | `code_action`                  | Code actions                            |  
| `<leader>lf` | `format`                       | Format buffer                           |  
| `<leader>lr` | `:LspRestart`                  | Restart LSP                             |  
| `<leader>li` | `:LspInfo`                     | LSP information                         |  
| `]d` / `[d`  | `goto_next` / `goto_prev`      | Next / Prev diagnostic                  |  
| `<leader>dl` | `open_float`                   | Show diagnostic float                   |  
| `<leader>dd` / `<leader>de` | disable/enable diagnostics (buffer) |  
| `<leader>l`  | `lint.try_lint()`              | Trigger linting (current file)          |  

## Telescope  

| Key       | Action                             | Description                             |  
|-----------|------------------------------------|-----------------------------------------|  
| `<leader>ff` | `find_files`                    | Fuzzy find files                        |  
| `<leader>fg` | `live_grep`                     | Live grep (project-wide)                |  
| `<leader>fb` | `buffers`                       | Fuzzy find open buffers                 |  
| `<leader>fh` | `help_tags`                     | Search help tags                        |  
| `<leader>fc` | `command_history`               | Search command-line history             |  
     |  

<C-u>	Scroll up in preview window
<C-d>	Scroll down in preview window
<C-q>	Send all items not filtered to quickfixlist (qflist)

## Vim-Fugitive  

| Key       | Action                  | Description                    |  
|-----------|-------------------------|--------------------------------|  
| `<leader>gs` | `:Git`               | Git status                     |  
| `<leader>gc` | `:Git commit`        | Git commit                     |  
| `<leader>gb` | `:Git blame`         | Git blame                      |  
| `<leader>gd` | `:Gdiffsplit`        | Git diff split                 |  
| `<leader>go` | `:GBrowse`           | Open file in remote (GitHub)   |  
| `<leader>gl` | `:Gclog`             | Git commit log (current file)  |  


<br />




# Yazi
[Docs](https://yazi-rs.github.io/docs/quick-start/)  
`ya` - (alias for yazi)  
`yazi` - Blazing fast terminal file manager (Rust-based)  
`yz` - (alias/variant for yazi)  

<br />  

`.` - toggle hidden filevisibility  
`:` - run shell command  
`[` / `]` - tab switch  
`<C-c>` - close tab  
`a` - create a file (end with `/` for dir)  
`f` - filter files  
`space` - select file(s)  
`t` - create new tab and 1/2/3/... to switch to specific tab  
`Tab` - show file info  
`z` - fuzzy find file  
standard vim commands for movement/searching  

<br />  

---  






