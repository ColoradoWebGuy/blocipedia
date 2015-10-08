require 'rails_helper'

RSpec.describe "wikis/new", type: :view do
  before(:each) do
    assign(:wiki, Wiki.new(
      :title => "MyString",
      :body => "MyText"
    ))
  end

  it "renders new wiki form" do
    render

    assert_select "form[action=?][method=?]", wikis_path, "post" do

      assert_select "input#wiki_title[name=?]", "wiki[title]"

      assert_select "textarea#wiki_body[name=?]", "wiki[body]"
    end
  end
end
