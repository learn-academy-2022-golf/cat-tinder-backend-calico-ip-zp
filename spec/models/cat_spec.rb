require 'rails_helper'

RSpec.describe Cat, type: :model do
  it "should validate presence of name" do
    cat = Cat.create age:5, enjoys:"Long walks", image:"https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg"
    expect(cat.errors[:name]).to_not be_empty 
  end

  it "should validate presence of age" do
    cat = Cat.create name:"Morgan", enjoys:"Long walks", image:"https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg"
    expect(cat.errors[:age]).to_not be_empty 
  end

  it "should validate presence of enjoys" do
    cat = Cat.create name:"Morgan", age: 5, image:"https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg"
    expect(cat.errors[:enjoys]).to_not be_empty 
  end

  it "should validate presence of image" do
    cat = Cat.create name:"Morgan", age: 5, enjoys:"Long walks"
    expect(cat.errors[:image]).to_not be_empty 
  end

  it "should validate presence of enjoys" do
    cat = Cat.create name:"Morgan", enjoys:"Long walk", image:"https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg"
    expect(cat.errors[:enjoys].first).to eq("is too short (minimum is 10 characters)") 
    expect(cat.errors[:enjoys].first).to_not be_empty 
  end

end
