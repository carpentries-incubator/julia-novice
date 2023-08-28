# Create Notebooks and Markdown files

Assuming you are in the root of this project run:

```bash
julia --project=@. generate.jl
```


## special admonitions

In this lesson we use some special admonitions to handle different question types:

- `mc`: for multiple choice questions
- `sc`: for single choice questions
- `freetype`: for questions with a freeform answer

In addition we always refer to other episodes with the `.ipynb` file-ending since this is the most unique of all the output formats and replace these with the correct ending in the post-processing step.
