class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new # guest user

		if user.role == "Owner"
			can :manage, :all
		else
		 	can :read, :all
			can :new, User
			can :create, User
			can :update, User, :id => user.id
  		can :delete, TimeClock, :user_id => user.id
		end
	end
end