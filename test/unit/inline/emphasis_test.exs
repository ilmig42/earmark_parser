defmodule Test.Unit.Inline.EmphasisTest do
  use Support.InlineTestCase

  describe "simple" do
    test_conversion "_ _", {"em", " "}
    test_conversion "_alpha_", {"em", "alpha"}
    test_conversion "*beta*", {"em", "beta"}
    test_conversion "*gamma_*_", ["_", {"em", "gamma_"}]
  end

  describe "complicated ;)" do
    test_conversion "*beta __test__*", {"em", ["beta ", {"strong", "test"}]}
    test_conversion "*beta _test_*", {"em", ["beta ", {"em", "test"}]}

  end

end
# SPDX-License-Identifier: Apache-2.0
