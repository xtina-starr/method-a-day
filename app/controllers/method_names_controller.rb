class MethodNamesController < ApplicationController
  def index
    @methods = MethodName.all
    @array_methods = MethodName.where(kind: "array")
    @string_methods = MethodName.where(kind: "string")
    @integer_methods = MethodName.where(kind: "integer")
  end

  def show
    @method = MethodName.find(params[:id])
  end
end
