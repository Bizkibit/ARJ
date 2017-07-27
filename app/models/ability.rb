class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user.is_admin?
        can :manage, :all
      end

      can [:create, :edit], Organization do |organization|
        organization.user == user
      end

      can [:create, :destroy], Application do |application|
        application.organization.user != user
      end

      cannot [:create, :destroy], Application do |application|
        application.organization.user == user
      end

      can :update, Application do |application|
        application.organization.user == user
      end

      cannot :update, Application do |application|
        application.organization.user != user
      end

      cannot [:create, :destroy], Review do |review|
        review.organization.user == user
      end

      can [:create, :destroy], Review do |review|
        review.organization.applicants.include? user
      end

      can [:create], Event do |event|


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
  end
end
