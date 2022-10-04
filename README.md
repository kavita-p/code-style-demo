# Python project code style demo

These are the tools and techniques I've been using to style the Wealth NextGen Django app.

## Tool recommendations

### Poetry

[Poetry](https://python-poetry.org/) is a package manager for Python that installs packages on a per-project basis, which is useful because it largely erases the need to deal with things like version number conflicts. (I think it's also faster than pip, but don't quote me on that.) You can install it with the following command:
`curl -sSL https://install.python-poetry.org | python3 -`

A quick guide to Poetry commands:

- `poetry init` will initialize a poetry project inside your current folder, allowing you to define dependencings interactively. It creates a `pyproject.toml` file which lists dependencies, both standard and dev-only.
- `poetry add` followed by a package name installs the named package to the current project and updates `pyproject.toml` as necessary.
- `poetry install` installs all dependencies listed in `pyproject.toml`.
- `poetry shell` activates the virtual environment for the current project, allowing you to use command-line tools specific to the current virtual environment.
- `poetry run` runs the command passed to it in the context of the virtual environment as a one-off.

### Black

[_Black_](https://black.readthedocs.io/en/stable/) is "the uncompromising code formatter." It handles all sorts of trivial things like line breaks, extra spaces, and more. I mostly have it installed so as not to deal with having to go back and correct things like `print( 'Hello, world!')` to `print("Hello, world!")` manually.

If you install Black with Poetry, you'll have to run it from inside the Poetry shell, or use `poetry run black .`

### isort

[_isort_](https://pycqa.github.io/isort/) sorts import statements. _Black_ does some of this on its own, but to my understanding, isort is more thorough.

### flake8

[_flake8_](https://flake8.pycqa.org/en/latest/) handles code linting, which is to say typos and bad practices in code. Black can do a lot, but it mostly tries to reprint what's already there in a way that looks nice; it doesn't make changes to code behavior on its own. flake8 will catch things like unused imports and variables, etc. Modern IDEs will also do this to some degree, but flake8 is nice because it will treat these bad practices as active errors, not just optional to-dos.

### pre-commit

The ultimate tool, [_pre-commit_](https://pre-commit.com/) will handle running all of these commands for you before every single commit, refusing to commit if any of them return errors. It saves you the trouble of ensuring checked-in code is formatted and styled appropriately, which is good.

## Using these tools

Here's a quick demo you can run:

1. Install Poetry using the script above.
2. Clone this repo.
3. Run `poetry install` in this repo; this will install all of the dev-dependencies.

The following steps can be run in the shell set up by `poetry shell`, or as one-offs by prefixing them with `poetry run`.

4. Look at the badly formatted string in `demo.py`. Then, run `black .` and see how `demo.py`'s text changes.
5. Now look at the imports. Then run `isort .` to have isort sort them.
6. Next, run `flake8 --extend-exclude=.venv` to lint the file, and observe the unused-imports errors you get. (You exclude the `.venv` folder for obvious reasons.)
7. Reset the git repo with `git reset --hard`.
8. Here's the big one: run `pre-commit install` to set up git hook scripts. Then, add some throwaway comment to the demo file and try to commit it. You'll see that pre-commit runs all of the tools we've just used automatically. This will run on every changed file in a commit every time you try and make a commit. Pre-commit actively prevents you from messing this up, which makes it far easier to share work across machines and with collaborators.

### On modern IDEs

One of the major advantages of modern IDEs is that lots of them have support for LSP, aka "Language Server Protocol." LSP is a tool Microsoft made to make in-IDE language support work on multiple IDEs, so that the same tool that displays the following in Visual Studio Code:

[Visual Studio Code showing a faded-out import name to indicate the imported package isn't used.](screenshot.png)

can do so in plenty of other languages as well. You don't _have_ to use Visual Studio Code — I use it sometimes and not others — but it's worth checking if your current IDE has LSP support, and if not, considering whether you might want to switch to one that does.
