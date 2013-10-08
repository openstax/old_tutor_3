class UsersRegister
  lev_handler

  paramify :register do
    attribute :i_agree, type: boolean
    attribute :agreement_id, type: Integer
  end

protected

  def authorized?
    !caller.is_registered?
  end

  def handle
    caller.is_registered = true
    caller.save

    transfer_errors_from(caller, {scope: :register})
  end
end