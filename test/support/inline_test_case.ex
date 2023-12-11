defmodule Support.InlineTestCase do

  defmacro __using__(_options) do
    quote do
      use ExUnit.Case, async: true
      # import Test.Support.ConversionTest
      alias EarmarkParser.{Ast.Inline, Block.IdDef, Context}

      alias EarmarkParser.Options

      import Support.Helpers
      import EarmarkAstDsl
      import Support.AstHelpers, only: [assert_asts_are_equal: 2, ast_from_md: 1, ast_from_md: 2]

      import Test.Support.ConversionTest

      defp assert_conversion(content, expected, context \\ nil)
      defp assert_conversion(content, expected, context) when is_list(expected) do
        assert convert(content, context) == expected |> Enum.map(&_mk_ast_tuple/1)
      end
      defp assert_conversion(content, expected, context) do
        assert convert(content, context) == [_mk_ast_tuple(expected)]
      end

      defp convert(content, context \\ nil) do
        context1 = context || Context.update_context(%Context{})
        Inline.convert(content, 42, context1).value
      end

      defp _mk_ast_tuple(tuple)
      defp _mk_ast_tuple({tag, content}) when is_list(content) do
        {tag, [], Enum.map(content, &_mk_ast_tuple/1), %{}}
      end
      defp _mk_ast_tuple({tag, content}) do
        {tag, [], [_mk_ast_tuple(content)], %{}}
      end
      defp _mk_ast_tuple({tag, content, atts}) when is_list(content) do
        {tag, atts, Enum.map(content, &_mk_ast_tuple/1), %{}}
      end
      defp _mk_ast_tuple({tag, content, atts}) do
        {tag, atts, [_mk_ast_tuple(content)], %{}}
      end
      defp _mk_ast_tuple(list) when is_list(list), do: Enum.map(list, &_mk_ast_tuple/1)
      defp _mk_ast_tuple(tuple_or_content), do: tuple_or_content

      defp with_link(id), do: with_link(Context.update_context(%Context{}), id)
      defp with_link(ctxt, id) do
        id_def = %IdDef{
          annotation: nil,
          attrs: nil,
          id: id,
          lnb: 3,
          title: "title",
          url: "lnk1_url",
        }
        %{ ctxt | links: Map.put(ctxt.links, id, id_def) }
      end
    end
  end

end
# SPDX-License-Identifier: Apache-2.0
