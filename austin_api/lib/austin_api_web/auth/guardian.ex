defmodule AustinApiWeb.Auth.Guardian do
  use Guardian, otp_app: :austin_api
  alias AustinApi.Admins
  
  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end
  
  def subject_for_token(_, _) do
    {:error, :no_id_provided}
  end
  
  def resource_from_claims(%{"sub" => id}) do
    case Admins.get_admin!(id) do
      nil -> {:error, :not_found}
      resource -> {:ok, resource}
    end
  end
  
  def resource_from_claims(_) do
    {:error, :no_id_provided}
  end
  
  def authenticate(email, password) do
    case Admins.get_admin_by_email(email) do
      nil -> {:error, :unauthorized}
      admin ->
        case validate_password(password, admin.hash_password) do
          true -> create_token(admin)
          false -> {:error, :unauthorized}
        end
    end
  end
  
  defp validate_password(password, hash_password) do
    Bcrypt.verify_pass(password, hash_password)
  end
  
  def create_token(admin) do
    {:ok, token, _claims} = encode_and_sign(admin)
    {:ok, admin, token}
  end
  
  def after_encode_and_sign(resource, claims, token, _options) do
    with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
      {:ok, token}
    end
  end

  def on_verify(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
      {:ok, claims}
    end
  end
  
  def on_revoke(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
      {:ok, claims}
    end
  end
end