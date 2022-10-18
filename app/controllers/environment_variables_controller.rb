class EnvironmentVariablesController < ApplicationController
  def test
    @envVariable1 = ENV["TEST_VARIABLE1"] 
    @envVariable2 = ENV["TEST_VARIABLE2"] 
  end
end
