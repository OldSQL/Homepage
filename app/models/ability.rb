# Copyright 2015 Unicode4all
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License. 

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role? :owner
      can :manage, :all
    elsif user.role? :normal
      can :create, Comment
    end
    #  if user.role? :owner
    #    can :manage, :all
    #  elsif user.role? :member
    #    can :read, :all
    #    can :create, Comment
    #  end
  end
end