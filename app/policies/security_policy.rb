class SecurityPolicy < Struct.new(:user, :security)

  def show?
    user.admin?
  end
  
end