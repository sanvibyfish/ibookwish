#coding = utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', city: cities.first)

# puts "开始初始化城市..."
# Location.create!({:name =>"北京", :pin_yin => "beijing"})
# Location.create!({:name =>"上海", :pin_yin => "shanghai"})
# Location.create!({:name =>"深圳", :pin_yin => "shenzhen"})
# Location.create!({:name =>"广州", :pin_yin => "guangzhou"})
# Location.create!({:name =>"杭州", :pin_yin => "hangzhou"})
# Location.create!({:name => "宁波", :pin_yin => "ningbo"})
# puts "结束初始化城市..."

s6 = Homeland::Section.create(:name => "书愿网")
n1 = Homeland::Node.create(:name => "公告",:summary => "...", :section_id => s6.id)
n2 = Homeland::Node.create(:name => "反馈",:summary => "...", :section_id => s6.id)
s6.node_ids.push(n1.id)
s6.node_ids.push(n2.id)


