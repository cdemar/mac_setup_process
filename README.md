# Mac Setup Process

This README contains instructions for setting up a new Mac. It serves as a guide to help you get your Mac ready with the necessary tools, settings, and configurations.

---

## Table of Contents

- [System Settings](#system-settings)
- [Software Installation](#software-installation)
- [Terminal Setup](#terminal-setup)
- [Wezterm and NeoVim Configuration](#wezterm-and-neovim-configuration)
- [Upkeep and Maintenance](#upkeep-and-maintenance)

---

## System Settings

### **Initial Setup Steps**

1. **System Settings Configuration**  
   After creating your account, make the following adjustments to personalize and optimize your Mac.

   - **Touchpad Settings**:
     - Change "Click" to "Tap to Click".
     - Set "Secondary Click" to "Click on bottom right".
   - **Dock Settings**:
     - Go to `Desktop & Dock` and change:
        - "Automatically hide and show the Dock" => On
        - "Show suggested and recent apps on Dock" => off
        - Show items => on desktop => off
        - scrole to bottom => "Hot Corner..." => turn off
   - **Spotlight Settings**:
     - Turn off the following categories under `Spotlight`:
       - Events & Reminders
       - Fonts
       - Images
       - Movies
       - Music
       - Other
       - Presentations
       - Siri Suggestions
       - Tips
   - **Network Settings**:
     - Set the Service Order to: `USB 10/100/1000 LAN => Wi-Fi => Thunderbolt Bridge`.
   - **Keyboard Settings**:
     - Turn off: **"Correct spelling automatically"**, **"Capitalize words automatically"**, and **"Show inline predictive text"**.
   - Install [Homebew](https://brew.sh) from the terminal

---

## Software Installation

### **App Installation via App Store and MAS**

1. **Log into your App Store account** before proceeding.

2. **Install these apps from the App Store** or via `mas`:

   - Password Manager
   - Grammarly
   - Honey
   - Super Agent
   - Slack
   - Keynote
   - Numbers
   - Pages
   - Usage - Device Monitor

   Use the following commands to install apps via `mas`:

   ```bash
   brew install mas
   ```

   To search and install apps using `mas`:

   ```bash
   mas search {app-name}
   ```

   Example for Pages:

   ```bash
   mas install 409201541
   ```

3. **Update Installed Apps**:
   - To upgrade all apps:
   ```bash
   mas upgrade
   ```
   - To upgrade a specific app:
   ```bash
   mas upgrade 409201541
   ```

### **Homebrew App Installation**

**Install the following tools via `brew`**:

- Wezterm
- Zoom
- Discord
- Microsoft Teams
- Thinkorswim
- Logos
- Arc
- AppCleaner
- lookaway
- spotify
- Obsidian

```bash
brew install -cask {app_name}
```

**Install Development Tools via `brew`**:

- Git
- Python3
- htop
  - use `sudo htop` for process management.
- font-meslo-lg-nerd-font
- powerlevel10k `Zsh theme`
- zsh-autosuggestions
- zsh-syntax-highlighting
- eza `Improved 'ls' command`
- nvim `NeoVim`

```bash
brew install {Dev_tool_name}
```

### Use a Virtual Environment (safe & recommended)

1. Create a virtual environment in your project folder
```bash
python3 -m venv venv
```

2. Activate the virtual environment
```bash
source venv/bin/activate
```

3. Now install the package inside the virtual environment with pip:
- pyperclip
- boto3
```bash
pip install pachage_name
```

4. Run your Python deploy script while the virtual environment is active
```bash
python name_of_script.py
```

5. When you’re done, you can deactivate the virtual environment with:
##### Option 1
###### Deactivate the virtual environment
If you're currently inside the environment (you'll see something like (venv) in your terminal), just run:

'''bash
deactivate
'''

This will return you to your system’s default environment.


##### Option 2
###### (Optional) Delete the virtual environment folder
If you no longer need the environment or want to clean it up:

'''bash
rm -rf venv
'''

This deletes the venv folder and all installed packages inside it.

---

## Terminal Setup

1.  **After installing powerlevel10k, zsh-autosuggestions, zsh-syntax-highlighting from brew, add the following to your `.zshrc` file**:

```bash
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
```

```bash
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
```

```bash
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
```

2.  **Then Source `.zshrc`**:

```bash
source ~/.zshrc
```
3. **Then open `.zshrc`**:

```bash
# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
```
This will allow zsh to save the history to a file and configure how it should do so.

Then go back to the command line and run to see what up and down arrows keys are:
```bash
cat -v
```
Then go back to `.zshrc`:
```bash
# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
```
If you installed `eza' add this to `.zshrc':
```bash
# ---- Eza (better ls) -----

alias ls="eza --icons=always"
```
---

## Wezterm and NeoVim Configuration

### **Wezterm Setup**

1.  **Ensure Permissions**:
    Check the permissions of `~/.config`:

    ```bash
    ls -l ~/.config
    ```

    If needed, change the permissions with:

    ```bash
    chmod 644 ~/.config
    ```

2.  **Create Necessary Folders**:
    If the `wezterm` folder does not exist in `~/.config`, create it:

    ```bash
    mkdir -p ~/.config/wezterm
    ```

    ```bash
    touch ~/.config/wezterm/wezterm.lua
    ```

3.  **Edit `wezterm.lua`**:
    Open `wezterm.lua` with your editor of choice, mine is `nvim`:
    ```bash
    cd ~/.config/wezterm
    ```
    ```bash
    nvim wezterm.lua
    ```

If you want to use the same setup as me or want inspiration from mine you can go [here](https://github.com/cdemar/mac-new-setup/blob/main/wezterm/wezterm.lua).

### **NeoVim Setup**

1.  **Install Dependencies**:

    ```bash
       brew install ripgrep node
    ```

2.  **Create `nvim` Configuration Files**:
    ```bash
    mkdir -p ~/.config/nvim
    ```
    ```bash
    touch ~/.config/nvim/init.lua
    ```
    ```bash
    mkdir -p ~/.config/nvim/lua/{your_username}/core
    ```
    ```bash
    mkdir -p ~/.config/nvim/lua/{your_username}/plugins
    ```
    ```bash
    touch ~/.config/nvim/lua/{your_username}/lazy.lua
    ```

Follow NeoVim Setup from the [Video](https://www.youtube.com/watch?v=6pAG3BHurdM&list=PLnu5gT9QrFg36OehOdECFvxFFeMHhb_07&index=14&t=324s) or use my setup [here](https://github.com/cdemar/mac-new-setup/tree/main/nvim). If you do use my setup make sure to change `cdemar` to `your_username`.

---

## Upkeep and Maintenance

### **Homebrew Maintenance**

1.  **Update Homebrew and Installed Packages**:

- This will update Homebrew

```bash
brew update
```

- This will upgrade CLI tools

```bash
brew upgrade
```

- This will upgrade apps installed from `--cask`

```brew
brew upgrade --cask
```

2.  **Clean Up**:
    To clean up old versions of installed formulas:

```bash
brew cleanup -s
```

This cleans up only old versions of formulae.

```bash
brew cleanup --prune=all
```

This cleans up old versions and also removes all cached downloads and anything that's not required anymore.

3.  **Check for Issues**:
    If you're having issues, run:

```bash
brew doctor
```
