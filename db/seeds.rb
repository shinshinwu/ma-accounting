# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = Admin.first || Admin.create!(email: "anna@mail.com", password: "password", first_name: "Anna", last_name: "Wu")

unit = Unit.first || Unit.create!(name: "Start with the basics", sort_order: 1)

course_module = CourseModule.first || CourseModule.create!(name: "An Introduction", sort_order: 1, unit_id: unit.id, duration_days: 3)

convo = Conversation.first_or_create(sender_id: 1, sender_type: 'User', recipient_id: admin.id, recipient_type: "Admin", course_module_id: course_module.id, subject: "Hello, I am confused")

msg = Message.first_or_create(conversation_id: convo.id, sender_id: 1, sender_type: 'User', body: "Can you explain to me the module 1 assignment? I don't get it")

# units = Unit.create([
#   {name: "Lines and Shapes", sort_order: 2},
#   {name: "Playing with Perspectives", sort_order: 3},
#   {name: "Design and Flow", sort_order: 4},
#   {name: "Tying It All Together", sort_order: 5}
# ])

# modules = CourseModule.create([
#   {name: "Line Drawing", unit_id: 2, sort_order: 1, duration_days: 3},
#   {name: "Line Weight", unit_id: 2, sort_order: 2, duration_days: 3},
#   {name: "Shading and Light Source Info", unit_id: 2, sort_order: 3, duration_days: 3},
#   {name: "2D and 3D", unit_id: 3, sort_order: 1, duration_days: 3},
#   {name: "Point Of View", unit_id: 3, sort_order: 2, duration_days: 3},
#   {name: "Perspectives", unit_id: 3, sort_order: 3, duration_days: 3},
#   {name: "Design, Thumbnails and Image", unit_id: 4, sort_order: 1, duration_days: 3},
#   {name: "S Curves", unit_id: 4, sort_order: 2, duration_days: 3},
#   {name: "Tools of Graphic Contrast", unit_id: 5, sort_order: 1, duration_days: 3},
#   {name: "Fit and Flow", unit_id: 5, sort_order: 2, duration_days: 3}
# ])

CourseContent.first_or_create(course_module_id: 1, description: "Welcome, please watch below video and feel free to DM me with any specific questions!", sort_order: 1)

CourseVideo.first_or_create(course_content_id: 1, title: "Welcome to Tattoo Tutor", url: "http://asdfasdfasdf.com/wers323", sort_order: 1, length_minutes: 2, length_seconds: 34)

CourseVideo.find_or_create_by(course_content_id: 1, title: "How it works", url: "http://asdfasdfasdf.com/wers3we23", sort_order: 2, length_minutes: 1, length_seconds: 4)

work = CourseAssignment.find_or_create_by(course_module_id: 1, title: "Upload Intro", instructions: "please write a little about your background and why you wanted to participate in the program", sort_order: 1, duration_days: 2)

CourseDeliverable.find_or_create_by(course_assignment_id: work.id, description: 'Example')
