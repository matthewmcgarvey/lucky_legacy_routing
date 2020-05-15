require "./spec_helper"

class BaseAction
  class_getter http_method : Symbol?
  class_getter path : String?

  def self.add_route(http_method, path, _action_class_name)
    @@http_method = http_method
    @@path = path
  end

  def self.setup_call_method(arg)

  end
end

class Users::Index < BaseAction
  include LuckyLegacyRouting

  route do
    1 + 1
  end
end

class Users::Show < BaseAction
  include LuckyLegacyRouting

  route do
    1 + 1
  end
end

class Users::New < BaseAction
  include LuckyLegacyRouting

  route do
    1 + 1
  end
end

class Users::Create < BaseAction
  include LuckyLegacyRouting

  route do
    1 + 1
  end
end

class Users::Edit < BaseAction
  include LuckyLegacyRouting

  route do
    1 + 1
  end
end

class Users::Update < BaseAction
  include LuckyLegacyRouting

  route do
    1 + 1
  end
end

class Users::Delete < BaseAction
  include LuckyLegacyRouting

  route do
    1 + 1
  end
end

class Users::Profile::Show < BaseAction
  include LuckyLegacyRouting

  nested_route do
    1 + 1
  end
end

describe LuckyLegacyRouting do
  describe "route" do
    it "handles index" do
      Users::Index.http_method.should eq(:get)
      Users::Index.path.should eq("/users")
    end

    it "handles show" do
      Users::Show.http_method.should eq(:get)
      Users::Show.path.should eq("/users/:user_id")
    end

    it "handles new" do
      Users::New.http_method.should eq(:get)
      Users::New.path.should eq("/users/new")
    end

    it "handles create" do
      Users::Create.http_method.should eq(:post)
      Users::Create.path.should eq("/users")
    end

    it "handles edit" do
      Users::Edit.http_method.should eq(:get)
      Users::Edit.path.should eq("/users/:user_id/edit")
    end

    it "handles update" do
      Users::Update.http_method.should eq(:put)
      Users::Update.path.should eq("/users/:user_id")
    end

    it "handles delete" do
      Users::Delete.http_method.should eq(:delete)
      Users::Delete.path.should eq("/users/:user_id")
    end
  end

  describe "nested_resource" do
    it "works" do
      Users::Profile::Show.http_method.should eq(:get)
      Users::Profile::Show.path.should eq("/users/:user_id/profile/:profile_id")
    end
  end
end
