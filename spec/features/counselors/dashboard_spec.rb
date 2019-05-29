require 'rails_helper'
RSpec.describe 'as a counselor' do
  describe 'when I visit my dashboard' do
    before :each do
      @t25 = Teacher.create(role: 2, first_name: "Steven", last_name: "Hendricks", email: "stevenh@comsenz.com", password: "password")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@t25)

      s33 = Student.create(grade_level: 11, first_name: "Wheeler", last_name: "Taffurelli", student_id: "251997", google_id: "C2cf0gBVQpd")
      s34 = Student.create(grade_level: 11, first_name: "Natale", last_name: "Mayow", student_id: "352623", google_id: "Pb3kGek9dY")
      s35 = Student.create(grade_level: 11, first_name: "Andrus", last_name: "Bollans", student_id: "520585", google_id: "XbLuYM6wsWH9")
      s36 = Student.create(grade_level: 11, first_name: "Nikoletta", last_name: "Phlippi", student_id: "688338", google_id: "ZJIdb5cmLha")
      s45 = Student.create(grade_level: 12, first_name: "Melosa", last_name: "Rothera", student_id: "848148", google_id: "n9IZoilO")
      s46 = Student.create(grade_level: 12, first_name: "Cherye", last_name: "Bysshe", student_id: "386896", google_id: "8VWMez")
      s47 = Student.create(grade_level: 12, first_name: "Karlens", last_name: "Newton", student_id: "960110", google_id: "tiimeY8")
      s48 = Student.create(grade_level: 12, first_name: "Gail", last_name: "Vasilyevski", student_id: "695299", google_id: "FGBBjNY")
      s49 = Student.create(grade_level: 12, first_name: "Sandye", last_name: "Baselli", student_id: "281144", google_id: "BMt3Ev4YJe")
      s50 = Student.create(grade_level: 12, first_name: "Zorah", last_name: "Torrent", student_id: "699119", google_id: "tSCzgNUGvi")

      c96 = @t25.courses.create(name: "Counseling 9th grade", period: "0", start_time: "2019-05-21 12:20:00", end_time: "2019-05-21 13:20:00")
      c97 = @t25.courses.create(name: "Counseling 10th grade", period: "0", start_time: "2019-05-21 12:20:00", end_time: "2019-05-21 13:20:00")
      c98 = @t25.courses.create(name: "Counseling 11th grade", period: "0", start_time: "2019-05-21 12:20:00", end_time: "2019-05-21 13:20:00")

      visit '/dashboard'
    end

    it "shows me all of my classes" do
      count = @t25.courses.count
      expect(page).to have_css(".course-card", count: count)
    end

    it "shows me all of my students for each class" do
      count = @t25.courses.first.students.count
      within first ".course-card" do
        expect(page).to have_css(".student-card", count: count)
      end
    end
  end
end
