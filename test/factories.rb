Factory.sequence :email do |n|
  "test#{n}@example.com"
end

Factory.define :user, :class => User do |f|
  f.display_name 'Test'
  f.parent       false
  f.confirmed_at { Time.now }
  f.email        { Factory.next(:email) }
  f.password     "password"
  f.family       { |user| user.association(:family) }

  f.after_build do |user|
    user.password = "password"
    user.password_confirmation = "password"
#    puts user.inspect
  end

end

Factory.define :parent_user, :class => User, :parent => :user do |f|
  f.parent true
end

Factory.define :child_user, :class => User, :parent => :user do |f|
  f.parent false
end


Factory.define :family do |f|
end

Factory.define :minute do |f|
  f.amount      1
  f.description "did something or other"
  f.created_at { Time.now }
  f.association :user,  :factory => :parent_user
  f.association :child, :factory => :child_user


end

Factory.define :scratch do |f|
  f.association :user, :factory => :child_user
  f.body "7:45"
end
  
