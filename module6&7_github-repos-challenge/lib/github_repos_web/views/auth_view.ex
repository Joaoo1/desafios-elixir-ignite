defmodule GithubReposWeb.AuthView do
  use GithubReposWeb, :view

  def render("sign_in.json", %{token: token}), do: %{token: token}
end
