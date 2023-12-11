defmodule Test.Unit.Inline.LinkAndImageTest do
  use Support.InlineTestCase

  describe "edge cases" do
    test "empty" do
      assert convert("") == []
    end
  end

  describe "reflink" do
    test "strong inside" do
      markdown = "[**strong**][lnk1]"
      ctxt = "lnk1" |> with_link()

      assert convert(markdown, ctxt) == [{"a", [{"href", "lnk1_url"}, {"title", "title"}], [{"strong", [], ["strong"], %{}}], %{}}]
    end

    test "just an image" do
      markdown = "![Img1][img1]"
      ctxt = "img1" |> with_link()

      assert convert(markdown, ctxt) == [{"img", [{"src", "lnk1_url"}, {"alt", "Img1"}, {"title", "title"}], [], %{}}]
    end
    test "image inside" do
      markdown = "[![Img1][img1]][lnk1]"
      expected = [{"a", [{"href", "lnk1_url"}, {"title", "title"}], 
        [{"img", [{"src", "lnk1_url"}, {"alt", "Img1"}, {"title", "title"}], [], %{}}],
        %{}}]

      ctxt = "lnk1" |> with_link() |> with_link("img1")
      assert convert(markdown, ctxt) == expected
    end
  end
end
# SPDX-License-Identifier: Apache-2.0

