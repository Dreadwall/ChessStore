class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
       user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    if user.role? :admin
        can :manage, :all
    elsif user.role? :manager
        can :read, :all
        
        can :manager, User do |u|  
            !(u.role? :customer)
        end
        can :manage, Item
        can :manage, ItemPrice
        can :manage, Purchase
        can :manage, Order
        can :manage, OrderItem

    elsif user.role? :customer
      can :show, User do |u|  
        u.id == user.id
      end
      # they can update their own profile
      can :update, User do |u|  
        u.id == user.id
      end

      can :create, Order
     
      can :show, Item
      can :show, Order do |o|
        o.user_id == user.id
      end
      can :cancel, Order do |o|
        o.user_id == user.id
      end




    elsif user.role? :shipper
      can :show, User do |u|  
        u.id == user.id
      end
      # they can update their own profile
      can :update, User do |u|  
        u.id == user.id
      end

      can :update, Order 
      can :read, Order
      can :show, Order
      can :read, School
      can :show, School
      can :read, Item
      can :show, Item
      can :ship, OrderItem


    else
        can :read, Item
    end
  end
end







