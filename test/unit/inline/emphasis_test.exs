defmodule Test.Unit.Inline.EmphasisTest do
  use Support.InlineTestCase

  [
    {"_ _", {"em", " "}},
    {"*alpha*", {"em", "alpha"}},
    {"_beta_", {"em", "beta"}}
  ]
  |> Enum.each( fn {markdown, expected} ->
    test markdown do
      assert_conversion(unquote(markdown), unquote(expected))
    end
  end)

end
# SPDX-License-Identifier: Apache-2.0
