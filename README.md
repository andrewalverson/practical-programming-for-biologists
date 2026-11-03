# Practical Programming for Biologists (bookdown)

Course book for BIOL 51573: Practical Programming for Biologists, University
of Arkansas.

## Building the book

From R or RStudio, with this folder as the working directory:

```r
bookdown::render_book()
```

Or from the Terminal, in this folder:

```sh
Rscript -e 'bookdown::render_book()'
```

The finished HTML book is written to `docs/`. Open `docs/index.html` in a
browser. In RStudio, you can instead open `bookdown.Rproj` and use
*Build > Build Book*, or run `bookdown::serve_book()` for a live preview that
rebuilds whenever you save a file.

## Publishing

The book is published with GitHub Pages from the `docs/` folder of this
repository (on GitHub, Settings > Pages > Deploy from a branch > `main`,
`/docs`). The built book is committed along with the source. To update the
online book, rebuild it, then commit and push:

```sh
Rscript -e 'bookdown::render_book()'
git add -A
git commit -m "Update course book"
git push
```

GitHub takes a minute or two to publish the changes. The `docs/.nojekyll` file
tells GitHub to serve the files as they are; don't delete it.

## Course data

The shell examples run against `files/data` and `files/file_types`. Students
download the same files as `files.tgz` from the book's website
(`docs/files.tgz`), so the output in the book matches what they have. If you
change anything in `files/`, rebuild the archive, then rebuild the book:

```sh
COPYFILE_DISABLE=1 tar -czf docs/files.tgz --exclude .DS_Store files
Rscript -e 'bookdown::render_book()'
```

## Files

| File | Purpose |
|------|---------|
| `index.Rmd` | Title page, welcome/preface, and the shared setup chunk |
| `01-unix.Rmd` | Chapter 1: Introduction to Unix |
| `02-shell.Rmd` | Chapter 2: Tailoring your shell |
| `03-project.Rmd` | Chapter 3: Organizing your project |
| `04-remote.Rmd` | Chapter 4: Working remotely |
| `05-git.Rmd` | Chapter 5: Version control with Git and GitHub |
| `references.Rmd` | References (unnumbered, always last) |
| `templates/notebook.Rmd` | Example project notebook, shown in Chapter 3 |
| `_bookdown.yml` | Book settings, including the chapter order (`rmd_files`) |
| `_output.yml` | Output format settings (gitbook) |
| `style.css` | Styles for the callout boxes, keyboard keys, etc. |
| `images/` | Figures, one subfolder per chapter |
| `files/` | Course data used by the live shell examples |
| `docs/` | The built book, published with GitHub Pages (don't edit by hand) |

To add a chapter, create e.g. `06-python.Rmd` starting with a
level-one heading (`# Python {#python}`) and add it to `rmd_files`
in `_bookdown.yml`.

## Writing conventions

- **Live shell examples.** Bash chunks are executed when the book is built,
  starting in `files/data`, so printed output is real. Chunk options:
  - `dir = "watermelon_genome"` runs a chunk from a subfolder.
  - `sandbox = TRUE` runs a chunk in a throwaway copy of `files/data` and
    `files/file_types`, made fresh at each build, so examples that create,
    change, or delete files (`gzip`, `tar`, `sed -i`, ...) can run for real
    without touching the course files. Sandbox chunks share one copy, so
    changes carry forward to later sandbox chunks.
  - `error = TRUE` for commands that fail on purpose (or exit nonzero, like
    `diff` on files that differ).
  - Any other chunk that creates, changes, or deletes files must use
    `eval = FALSE`.
- **Exercises.** Use a fenced div with the class `exercise`. bookdown numbers
  them by chapter ("Exercise 1.3"), and you can label one for
  cross-referencing, e.g. `::: {.exercise #ex-pipes}` and then
  `Exercise \@ref(exr:ex-pipes)`.

  ```
  ::: {.exercise}
  1. Do this.
  2. Then this.
  :::
  ```

- **Other callout boxes.** Use `warning`, `tip`, `note`, or `goals` (the "In
  this chapter" box), and start the box with a bold title, which is colored
  and given an icon automatically:

  ```
  ::: {.warning}
  **`rm -r` is dangerous.** ...
  :::
  ```

- **Cross-references.** Give sections IDs (`## Pipes {#pipes}`) and refer to
  them with `Section \@ref(pipes)`.
