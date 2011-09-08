class Ability
  include CanCan::Ability

  def initialize(user)
    #@user = user || User.new # for guest
    #@user.roles.each { |role| send(role) }
     
    user ||= User.new # guest user (not logged in)
    

    # banned client moderator admin
    if user.role? :admin
      can :manage, :all
    else
      #cannot :manage, :all
      cannot :read, :all

      can :create, Order
      can [:create,:update,:delete], LineItem, Cart
      #can [:create,:update], Cart
      #can :read, Order do |order|
      #  order.try(:user) == user || user.role?(:moderator)
      #end
      if user.role?(:client)
        
        can :create, Order
        can [:update,:read], Order do |order|
          order.try(:user) == user || user.role?(:moderator)
        end      
      end
      if user.role?(:moderator)
        can :create, Product
        can :update, Product
        can :read, Product
        can :manage, LineItem
        cannot :create, Order
      end
    end

    


  # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
=begin
  def banned
    cannot :read, :all
  end
  
  def client
    can :read, :all
  end

  def moderator
    client
    can :manage, Product
  end

  def admin
    moderator
    can :manage, :all
  end
=end
end
