defmodule Support.InlineTestCase do

  defmacro __using__(_options) do
    quote do
      use ExUnit.Case, async: true
      alias EarmarkParser.{Ast.Inline, Block.IdDef, Context}

      alias EarmarkParser.Options

      import Support.Helpers
      import EarmarkAstDsl
      import Support.AstHelpers, only: [assert_asts_are_equal: 2, ast_from_md: 1, ast_from_md: 2]

      defp convert(content, context \\ %Context{}), do: Inline.convert(content, 42, context).value

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
