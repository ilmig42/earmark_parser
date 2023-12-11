defmodule Test.Support.ConversionTest do

  defmacro using(_opts \\ []) do
    quote do
      def test_conversion(content, expected, context \\ nil) do
        quote do
          test unquote(content) do
            assert_conversion(unquote(content), unquote(expected), unquote(context))
          end
        end
      end
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
