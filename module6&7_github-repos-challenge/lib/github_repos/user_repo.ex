defmodule GithubRepos.UserRepo do
  use Ecto.Schema

  import Ecto.Changeset

  @required_params [:id, :name, :description, :html_url, :stargazers_count]

  @derive {Jason.Encoder, only: [:id, :name, :description, :html_url, :stargazers_count]}

  @primary_key false
  embedded_schema do
    field :id, :integer
    field :name, :string
    field :description, :string
    field :html_url, :string
    field :stargazers_count, :integer
  end

  def build(data) do
    cast(%__MODULE__{}, data, @required_params)
    |> IO.inspect()
    |> apply_changes()
  end
end
