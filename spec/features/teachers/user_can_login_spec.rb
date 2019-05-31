require "rails_helper"

describe "As a teacher" do
  before :each do
    @teacher = create(:teacher, password: "password", role: 2)
    visit welcome_path
  end

  it "I can log in successfully" do
    create_list(:course, 2)
    create_list(:student, 4)
    @teacher.courses << Course.first
    Student.first.courses << Course.first
    Student.second.courses << Course.first
    Student.third.courses << Course.second
    Student.fourth.courses << Course.second
    att1 = Student.first.attendances.create(attendance: "absent",course_id: Course.first.id, created_at: DateTime.now.midnight)
    att2 = Student.second.attendances.create(attendance: "present",course_id: Course.first.id, created_at: DateTime.now.midnight)
    att3 = Student.third.attendances.create(attendance: "absent",course_id: Course.second.id, created_at: DateTime.now.midnight)
    att4 = Student.fourth.attendances.create(attendance: "present",course_id: Course.second.id, created_at: DateTime.now.midnight)

    expect(page).to have_content("HereToLearn")

    fill_in "session[email]", with: @teacher.email
    fill_in "session[password]", with: "password"
    click_on "LOG IN"
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Successfully logged in")
    expect(page).to have_content("Logged in as #{@teacher.first_name} #{@teacher.last_name}")

    within "nav" do
      expect(page).to have_link("Log Out")
      expect(page).to have_link("Dashboard")
      expect(page).to have_link("My Account")
    end

    within ".course-container" do
      within first ".course-card" do
        expect(page).to have_link("#{Course.first.name}")
        expect(page).to have_link("#{Student.first.last_name}")
        expect(page).to have_link("#{Student.second.last_name}")
      end

      expect(page).to_not have_link("#{Course.second.name}")
      expect(page).to_not have_link("#{Student.third.last_name}")
      expect(page).to_not have_link("#{Student.fourth.last_name}")
    end
  end

  it "I cannot log in with bad credentials" do
    fill_in "session[email]", with: @teacher.email
    fill_in "session[password]", with: "not_password"
    click_on "LOG IN"
    expect(current_path).to eq(login_path)
    expect(page).to have_content("Sorry, wrong email/password combination")
    expect(page).to_not have_content("Logged in as #{@teacher.first_name} #{@teacher.last_name}")
  end

  it "I can logout" do
    fill_in "session[email]", with: @teacher.email
    fill_in "session[password]", with: "password"
    click_on "LOG IN"
    click_on "Log Out"
    expect(current_path).to eq(welcome_path)
    expect(page).to_not have_link("Log Out")
    expect(page).to have_content("You have successfully logged out")
  end

  it "Shows that I'm logged in on the welcome page" do
    fill_in "session[email]", with: @teacher.email
    fill_in "session[password]", with: "password"
    click_on "LOG IN"
    visit welcome_path
    expect(page).to have_content("Logged in as #{@teacher.first_name} #{@teacher.last_name}")

    within ".dynamic-container" do
      expect(page).to_not have_button("LOG IN")
    end
  end
end
