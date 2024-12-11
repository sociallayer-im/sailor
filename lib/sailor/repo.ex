defmodule Sailor.Repo do
  use Ecto.Repo,
    otp_app: :sailor,
    adapter: Ecto.Adapters.Postgres
end
