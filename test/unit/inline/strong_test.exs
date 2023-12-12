defmodule Test.Unit.Inline.StrongTest do
  use Support.InlineTestCase

  describe "simple" do
    test_conversion "__ __", {"strong", " "}
    test_conversion "__alpha__", {"strong", "alpha"}
    test_conversion "**beta**", {"strong", "beta"}
    test_conversion "**gamma_**_", ["_", {"strong", "gamma_"}]
  end

  describe "complicated ;)" do
    test_conversion "**_delta_**", {"strong", {"em", "delta"}}
    test_conversion "** *epsilon*_**", {"strong", [" ", {"em", "epsilon"}, "_"]}
  end

end
# SPDX-License-Identifier: Apache-2.0
