defmodule MarkdownTest do
  use ExUnit.Case

  doctest Markdown

  test :tables do
    markdown = """
    |  J  |  O  |
    | --- | --- |
    |  S  |  É  |
    """

    html = Markdown.to_html(markdown, tables: true)
    assert html =~ ~r{<table>}
  end

  test :fenced_code do
    markdown = """
    ``` elixir
    Markdown.to_html(markdown)
    ```
    """

    html = Markdown.to_html(markdown, fenced_code: true)
    assert html =~ ~r{<code class="language-elixir">}
  end

  test :footnotes do
    markdown = """
    Markdown extensions. [^fn1]

    [^fn1]: [Wikipedia article on Markdown](https://en.wikipedia.org/wiki/Markdown)
    """

    html = Markdown.to_html(markdown, footnotes: true)
    assert html =~ ~r{<div class="footnotes">}
  end

  test :autolink do
    markdown = "http://devintorr.es/"
    html = Markdown.to_html(markdown, autolink: true)
    assert html =~ ~r{<a href="http://devintorr.es/">}
  end

  test :strikethrough do
    markdown = "~~strikethrough~~"
    html = Markdown.to_html(markdown, strikethrough: true)
    assert html =~ ~r{<del>}
  end

  test :underline do
    markdown = "_underline_"
    html = Markdown.to_html(markdown, underline: true)
    assert html =~ ~r{<u>}
  end

  test :highlight do
    markdown = "==highlight=="
    html = Markdown.to_html(markdown, highlight: true)
    assert html =~ ~r{<mark>}
  end

  test :quote do
    markdown = ~s{"quote"}
    html = Markdown.to_html(markdown, quote: true)
    assert html =~ ~r{<q>}
  end

  test :superscript do
    markdown = "super^script"
    html = Markdown.to_html(markdown, superscript: true)
    assert html =~ ~r{<sup>}
  end

  test :disable_intra_emphasis do
    markdown = "emphasis_between_words"
    html = Markdown.to_html(markdown, disable_intra_emphasis: true)
    assert html =~ ~r{emphasis_between_words}
  end

  test :space_headers do
    markdown = "#space_headers"
    html = Markdown.to_html(markdown, space_headers: true)
    assert html =~ ~r{#space_headers}
  end

  test :disable_indented_code do
    markdown = """
        foobar
        bazbaz
    """
    html = Markdown.to_html(markdown, disable_indented_code: true)
    assert !(html =~ ~r{<code>})
  end
end
