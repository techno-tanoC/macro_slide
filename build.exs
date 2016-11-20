defmodule Build do
  def build do
    text = EEx.eval_file("template.html", [
      markdown: markdown("slide.md", [
      ])
    ])
    File.write!("index.html", text, [:write])
  end

  def markdown(file, bindings \\ [], opts \\ []) do
    head = ~S{
<section data-markdown data-separator="^\n---$" data-separator-vertical="^\n>>>$">
  <script type="text/template">
}

    foot = ~S{
  </script>
</section>
}

    head <> EEx.eval_file(file, bindings) <> foot
  end

  def source(file, lang, bindings \\ []) do
    "\n\n```#{lang}\n" <> EEx.eval_file(file, bindings) <> "```\n\n"
  end
end

for _ <- Stream.cycle([nil]) do
  Build.build
  :timer.sleep(1000)
end
