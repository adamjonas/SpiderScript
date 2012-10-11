require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'sqlite3'
##### connect to database #####
db =  SQLite3::Database.open('studentinfo.sqlite')
students = []
##### get student pictures #####
css = Nokogiri::HTML(open("http://students.flatironschool.com/css/matz.css"))
images = css.to_s.scan(/\.(.*?-photo)[^}]+?background:.*?\(([\S\s]+?)\)/)
##### get student urls #####
index = Nokogiri::HTML(open("http://students.flatironschool.com/"))
index.css('.one_third a').each {|e| students << e['href']}
##### get individual student information #####
students.each do |url|
	next if url == "billymizrahi.html"
	cred = {}
	contact = {}
	tagline = ""
	app_names = []
	app_decs = []
	first_name=""
	last_name=""
	bio=""
	image_url = ""
	studentID = nil

	page = Nokogiri::HTML(open("http://students.flatironschool.com/#{url}"))
	#get image name
	image_name = page.css('#navcontainer div').first['class']
	# cred
	page.css('.one_fifth a').each { |e| cred[e.children.first['class']] = e['href']} 
	#contact
	page.css('#side-nav li').each { |e| contact[e['class']] = e.children.first['href']} 
	# tagline
	tagline = page.css('h2#tagline').first.inner_text 
	# fav apps names
	page.css('.two_third .one_third h4').each { |e| app_names << e.inner_text  } 
	# fav apps desc
	page.css('.two_third .one_third p').each { |e| app_decs << e.inner_text  }
	#name
	page.css('.two_third h1').each do |e| 
		first_name = e.content.split.first
		last_name = e.content.split.last
	end
	#bio
	bio = page.css('.two_third h2~p').inner_text
	##### adding data to database! #####
	db.execute ( "INSERT INTO students (first_name,last_name)
				VALUES (\"#{first_name}\",\"#{last_name}\")")
	studentID =  db.execute("SELECT id FROM students WHERE first_name = \"#{first_name}\" AND last_name =\"#{last_name}\"")
	# db.execute ( "INSERT INTO index_info (picture, tagline, bio)				
	# 			VALUES (?,?,?)", NULL, NULL, NULL)
	# extrat proper image url ##
	images.each do |e|
		if image_name == e[0]
			image_url = e[1]
		end
	end
	#### streilization ####
	bio = bio.gsub(/\"/,"'")
	tagline = tagline.gsub(/\"/,"'")

	studentID = studentID.first.first
	puts "----------------------------------- procssesssing ------------------------------------\n"
	puts "INSERT INTO profile_info (students_id,picture, tagline, bio, email, blog, linkedin, twitter, github, codeschool, coderwall, stackoverflow, treehouse, fav_app1_name, fav_app1_description, fav_app2_name, fav_app2_description, fav_app3_name, fav_app3_description)
				VALUES (#{studentID},
					\"#{image_url}\",
				 \"#{tagline}\",
				  \"#{bio}\",
				   \"#{contact["email"]}\",
				    \"#{contact["blog"]}\",
				    \"#{contact["linkedin"]}\",
				     \"#{contact["twitter"]}\",
				     \"#{cred["cred-github"]}\",
				     \"#{cred["cred-codeschool"]}\",
				     \"#{cred["cred-coderwall"]}\",
				      \"#{cred["cred-stackoverflow"]}\",
				       \"#{cred["cred-treehouse"]}\",
				        \"#{app_names[0]}\",
				        \"#{app_decs[0]}\",
				        \"#{app_names[1]}\",
				        \"#{app_decs[1]}\",
				        \"#{app_names[2]}\",
				        \"#{app_decs[2]}\")"
	 db.execute ( "INSERT INTO profile_info (students_id,picture, tagline, bio, email, blog, linkedin, twitter, github, codeschool, coderwall, stackoverflow, treehouse, fav_app1_name, fav_app1_description, fav_app2_name, fav_app2_description, fav_app3_name, fav_app3_description)
				VALUES (#{studentID},
					\"#{image_url}\",
				 \"#{tagline}\",
				  \"#{bio}\",
				   \"#{contact["mail"]}\",
				    \"#{contact["blog"]}\",
				    \"#{contact["linkedin"]}\",
				     \"#{contact["twitter"]}\",
				     \"#{cred["cred-github"]}\",
				     \"#{cred["cred-codeschool"]}\",
				     \"#{cred["cred-coderwall"]}\",
				      \"#{cred["cred-stackoverflow"]}\",
				       \"#{cred["cred-treehouse"]}\",
				        \"#{app_names[0]}\",
				        \"#{app_decs[0]}\",
				        \"#{app_names[1]}\",
				        \"#{app_decs[1]}\",
				        \"#{app_names[2]}\",
				        \"#{app_decs[2]}\")")
	## remove in production ##
	# break
end

