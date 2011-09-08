# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


#Product.delete_all

Product.create(:category=>'картриджи', :producer=>'Bro', :model=>'Руби TN-2075', :title=>'Bro TN-2075', :print_tech=>'лазерная', :color=>'черный', :compatibility=>'Brother HL-2030, 2040, 2070, DCP-7010, 7025, MFC-7420, 7820, FAX-2920', :capacity=>'приблизительно 2500 страниц при заполнении 5%', :weight=>0.848, :description=>%{<p>описание товара на данный момент отсутствует</p>}, :price=>2327, :image => '/media/Documents/Documents/Dropbox/svopart/public/images/wqe/pic0404/tn-2075.jpg')

