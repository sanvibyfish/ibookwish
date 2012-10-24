class Ability
  include CanCan::Ability

	def initialize(account)
	    account ||= User.new # guest account (not logged in)
	    if account.role? :admin
	      can :manage, :all
	    end
	end


end
