defmodule WeatheradoWeb.PageController do
  use WeatheradoWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
