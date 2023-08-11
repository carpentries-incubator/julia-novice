---
title: Setup
---


## Software Setup

::::::::::::::::::::::::::::::::::::::: discussion

### Details

This lesson requires installation of the following three components:

1. terminal emulator ("shell");
2. a text editor (either "VSCodium" or "nano"), and;
3. Julia.

:::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::: solution

### Windows

### Git and Bash

1. Download the [Git for Windows installer](https://gitforwindows.org/).
2. Run the installer and follow the steps below:
   1. Click on "Next" four times (two times if you've previously installed Git). You don't need to change anything in the Information, location, components, and start menu screens.
   2. **From the dropdown menu, "Choosing the default editor used by Git", select "Use the Nano editor by default" (NOTE: you will need to scroll up to find it) and click on "Next".**
   3. On the page that says "Adjusting the name of the initial branch in new repositories", ensure that "Let Git decide" is selected. This will ensure the highest level of compatibility for our lessons.
   4. Ensure that "Git from the command line and also from 3rd-party software" is selected and click on "Next". (If you don't do this Git Bash will not work properly, requiring you to remove the Git Bash installation, re-run the installer and to select the "Git from the command line and also from 3rd-party software" option.)
   4. Select "Use bundled OpenSSH".
   4. Ensure that "Use the native Windows Secure Channel Library" is selected and click on "Next".
   4. Ensure that "Checkout Windows-style, commit Unix-style line endings" is selected and click on "Next".
   4. **Ensure that "Use Windows' default console window" is selected and click on "Next".**
   4. Ensure that "Default (fast-forward or merge) is selected and click "Next"
   4. Ensure that "Git Credential Manager" is selected and click on "Next".
   4. Ensure that "Enable file system caching" is selected and click on "Next".
   4. Click on "Install".
   4. Click on "Finish" or "Next".
3. If your "HOME" environment variable is not set (or you don't know what this is):
    1. Open command prompt (Open Start Menu then type `cmd` and press <kbd>Enter</kbd>)
    2. Type the following line into the command prompt window exactly as shown:
       `setx HOME "%USERPROFILE%"`

    3. Press <kbd>Enter</kbd>, you should see `SUCCESS: Specified value was saved.`
    4. Quit command prompt by typing `exit` then pressing <kbd>Enter</kbd>
This will provide you with both Git and Bash in the Git Bash program.

[Video Tutorial](https://youtu.be/339AEqk9c-8)

#### Nano

nano is a basic editor and the default that instructors use in the workshop.
It is installed along with Git.

#### Julia

- Open a web browser and visit the [Julia download page](https://julialang.org/downloads/)
- Download the **Current stable release** for Windows
              by clicking the **64-bit (installer)** link.
- Run the installer once it finishes downloading.
- Click on Next to accept the default directory (or after
              specifying your preferred installation location).
- On the *Select Additional Tasks* screen
              under *Other*, **check the box to Add Julia to PATH**.
- Click Next.
- Click on Finish.

We will run Julia through the Git-Bash interface. Once you have it installed:

- Open the Start menu and click on the **Git** folder.
- Click on **Git Bash** -- *not Git Cmd!*
- A warning message might pop up about a missing icon: click "I
              see," and continue.
- Once the terminal window loads, type <kbd>julia</kbd> and enjoy the
              lesson!

#### VSCodium

- Install [VSCodium](https://vscodium.com/#install) for your platform
- Start VSCodium
- Inside VSCodium, go to the Extensions view by clicking View on the top menu bar and then selecting Extensions.
- In the Extensions view, search for the term "julia" in the Marketplace search box, then select the Julia extension (julialang.language-julia) and select the Install button. This will add Julia to your VSCodium and automatically link the text editor to your copy of Julia you installed earlier.
- Restart VSCodium.

Then, test that everything works:

- In VSCodium, create a new file by clicking File on the top menu bar and selecting New File.
- Inside the file, type `println("Hello World!")`
- Save your file by clicking File on the top menu bar and selecting Save. Name your file `hello.jl`.
- Run your file by first pressing <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to bring up a command palette for search all commands available in VSCodium. Then type `Julia: Execute active file in REPL` in the command palette and press <kbd>Return</kbd>.
- If everything works, you should see a message "Hello World!" appear.

[Video tutorial](https://av.tib.eu/media/62060)
:::::::::::::::::::::::::

:::::::::::::::: solution

### MacOS

#### Bash

The default shell in some versions of macOS is Bash, and Bash is available in all versions, so no need to install anything. You access Bash from the Terminal (found in /Applications/Utilities). See the Git installation [video tutorial](https://youtu.be/9LQhwETCdwY) for an example on how to open the Terminal.
You may want to keep Terminal in your dock for this workshop.

To see if your default shell is Bash type `echo $SHELL` in Terminal and press the <kbd>Enter</kbd> key.
If the message printed does not end with '/bash' then your default is something else and you can run Bash by typing `bash`.

If you want to change your default shell, see this [Apple Support article](https://support.apple.com/en-au/HT208050) and follow the instructions on "How to change your default shell".

#### Git

**For macOS**, install Git for Mac by downloading and running the most recent "mavericks" installer from [this list](http://sourceforge.net/projects/git-osx-installer/files/).
Because this installer is not signed by the developer, you may have to right click (control click) on the .pkg file, click Open, and click Open on the pop up window.
After installing Git, there will not be anything in your `/Applications` folder, as Git is a command line program.
**For older versions of OS X (10.5-10.8)** use the most recent available installer labelled "snow-leopard" [available here](http://sourceforge.net/projects/git-osx-installer/files/).

#### Nano

nano is a basic editor and the default that instructors use in the workshop.
See the Git installation [video tutorial](https://youtu.be/9LQhwETCdwY) for an example on how to open nano.
It should be pre-installed.

#### Julia

**juliaup**:

- Run `curl -fsSL https://install.julialang.org | sh` or `brew install juliaup` if you want to use homebrew.

**Manual**:

- Download the current stable release from the [Julia download
              page](https://julialang.org/downloads/) and follow the installation instructions.

#### VSCodium

- Install [VSCodium](https://vscodium.com/#install) for your platform
- Start VSCodium
- Inside VSCodium, go to the Extensions view by clicking View on the top menu bar and then selecting Extensions.
- In the Extensions view, search for the term "julia" in the Marketplace search box, then select the Julia extension (julialang.language-julia) and select the Install button. This will add Julia to your VSCodium and automatically link the text editor to your copy of Julia you installed earlier.
- Restart VSCodium.

Then, test that everything works:

- In VSCodium, create a new file by clicking File on the top menu bar and selecting New File.
- Inside the file, type `println("Hello World!")`
- Save your file by clicking File on the top menu bar and selecting Save. Name your file `hello.jl`.
- Run your file by first pressing <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to bring up a command palette for search all commands available in VSCodium. Then type `Julia: Execute active file in REPL` in the command palette and press <kbd>Return</kbd>.
- If everything works, you should see a message "Hello World!" appear.

[Video tutorial](https://av.tib.eu/media/62060)
:::::::::::::::::::::::::


:::::::::::::::: solution

### Linux

#### Bash

The default shell is usually Bash and there is usually no need to install anything.

To see if your default shell is Bash type `echo $SHELL` in a terminal and press the <kbd>Enter</kbd> key.
If the message printed does not end with '/bash' then your default is something else and you can run Bash by typing `bash`.

#### Git

If Git is not already available on your machine you can try to install it via your distro's package manager.
For Debian/Ubuntu run s`udo apt-get install git` and for Fedora `run sudo dnf install git`.

#### Nano

nano is a basic editor and the default that instructors use in the workshop.
It should be pre-installed.

#### Julia

**juliaup**:

- Run `curl -fsSL https://install.julialang.org | sh`.

**Manual**:

- Download the current stable release from the [Julia download
              page](https://julialang.org/downloads/) and unpack the folder to any location that is in your `PATH` or link the binary in the `bin` folder to such a location.

#### VSCodium

- Install [VSCodium](https://vscodium.com/#install) for your platform
- Start VSCodium
- Inside VSCodium, go to the Extensions view by clicking View on the top menu bar and then selecting Extensions.
- In the Extensions view, search for the term "julia" in the Marketplace search box, then select the Julia extension (julialang.language-julia) and select the Install button. This will add Julia to your VSCodium and automatically link the text editor to your copy of Julia you installed earlier.
- Restart VSCodium.

Then, test that everything works:

- In VSCodium, create a new file by clicking File on the top menu bar and selecting New File.
- Inside the file, type `println("Hello World!")`
- Save your file by clicking File on the top menu bar and selecting Save. Name your file `hello.jl`.
- Run your file by first pressing <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to bring up a command palette for search all commands available in VSCodium. Then type `Julia: Execute active file in REPL` in the command palette and press <kbd>Return</kbd>.
- If everything works, you should see a message "Hello World!" appear.

[Video tutorial](https://av.tib.eu/media/62060)
:::::::::::::::::::::::::



