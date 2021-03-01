# Note Taking using Sphinx

## Installation

```
pip install sphinx
```

## Generate a project

```shell
makedir project_dir
cd project_dir
sphinx-quickstart
```

## Build

```shell
make html
open build/html/index.html
```

To build automatically,

```shell
pip install sphinx-autobuild
```

and execute the command below.
```shell
sphinx-autobuild source build
```

Also, add the following code to `Makefile` and execute `make livehtml`.
```
livehtml:
        sphinx-autobuild -b html $(SOURCEDIR) $(BUILDDIR)
```

## Using markdown

```shell
pip install commonmark recommonmark sphinx-markdown-tables
```

Add the following code to `source/conf.py`.
```python
from recommonmark.parser import CommonMarkParser
from recommonmark.transform import AutoStructify

extensions = ['recommonmark', 'sphinx-markdown-tables']

source_suffix = ['.rst', '.md']
source_parsers = {'.md': CommonMarkParser}

def setup(app):
    app.add_config_value('recommonmark_config', {
        'enable_math': True,
        'enable_inline_math': True,
    }, True)
    app.add_transform(AutoStructify)
```

## Using Jupyter Notebook

```shell
pip install nbsphinx
```

Add the code below to `source/conf.py`.
```Python
extensions = ['nbsphinx', 'sphinx.ext.mathjax']
exclude_patterns = ['_build', '**.ipynb_checkpoints']
```

Note that first-level header (# header) must be writtern in a notebook.

## Using mathematical expression

Block mode delimiters:

```
\\[ ma = F \\]
```

```
$$ ma = F $$
```

```
```math ma = F ```
```

Text mode delimiters:

```
\\( \sigma_i \\)
```

```
``$` \sigma_i `$``
```

$...$ cannot be used.
The following script `build.sh` replaces the expression to valid one in markdown files.

```shell
cp -r ./source ./tmp
find ./tmp -name '*.md' | xargs gsed -i -E 's/\$([^$]+)\$/``$`\1`$``/g'
make html
rm -rf ./tmp
```

## Sphinx theme

For example,

```shell
pip install karma_sphinx_theme
```

Add the following code to `source/conf.py`.
```python
html_theme = 'karma_sphinx_theme'
```

## Setting Github Pages

1.Add this following code to `Makefile`.
```
BUILDDIR      = docs

html:
        @$(SPHINXBUILD) -b html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
```

2.Add this code below to `source/conf.py`.
```Python
extensions = ['sphinx.ext.githubpages']
```

3.By building again, `docs/.nojekyll` will be generated, which views the style of pages correctly.

4.Commit and push the whole folder to github repository.

5.Set the branch `/docs` folder as source in github pages.

