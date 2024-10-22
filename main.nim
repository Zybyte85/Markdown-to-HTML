import std/strutils
import markdown
import os

proc printHelp() =
    echo "Usage: nim run main.nim <markdown_file>"
    quit()

let args = commandLineParams()

let script = """
<script>
  const toggleButton = document.createElement('button');
toggleButton.textContent = 'Toggle Dark Mode';
toggleButton.className = 'dark-mode-toggle'; // Add class for styling
document.body.prepend(toggleButton);

toggleButton.addEventListener('click', () => {
    document.body.classList.toggle('light-mode');
});
  </script>
  """

if args.len != 1:
    printHelp()
let markdown_file: string = $args[0]
let markdown_text = readFile(markdown_file)
var html = markdown(markdown_text)
html = "<!DOCTYPE html>\n<link rel=\"stylesheet\" href=\"styles.css\">\n" & $html & "\n" & script

let file_name = extractFilename(markdown_file.replace(".md", ".html"))

writeFile(file_name, html)
echo "Created " & file_name