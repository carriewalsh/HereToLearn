require "rails_helper"

describe "As a logged-in Teacher" do

  describe "when I visit a student's show page" do
    before :each do
      @course = create(:course)
      @course2 = create(:course)
      @teacher = create(:teacher, role: 2)
      @teacher.courses << Course.first
      @student = create(:student)
      @student.courses << Course.first
      @student.courses << Course.last

      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "present")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "absent")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "present")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "present")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "absent")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "present")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "present")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "present")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "present")
      @student.attendances.create(course_id: @course.id, created_at: "2019-05-26 02:00:00", attendance: "present")
      @student.attendances.create(course_id: @course2.id, created_at: "2019-05-26 02:00:00", attendance: "absent")


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@teacher)
      visit student_path(@student, {course_id: @course.id})
    end

    it "should have a strategies section witl all strategies for that student" do
      teacher2 = create(:teacher)
      strat1 = @teacher.strategies.create(student_id: @student.id, strategy: "When Seattle Public Schools announced that it would reorganize school start times across the")
      strat2 = @teacher.strategies.create(student_id: @student.id, strategy: "district for the fall of 2016, the massive undertaking took more than a year to deploy.")
      strat3 = teacher2.strategies.create(student_id: @student.id, strategy: "Elementary schools started earlier, while most middle and all of the district's 18 high")
      visit student_path(@student, {course_id: @course.id})
      expect(page).to have_content("Student Strategies")
      expect(page).to have_css(".strategy",count: 3)
      expect(page).to have_content("By Me:", count: 2)
      expect(page).to have_content("By #{teacher2.first_name} #{teacher2.last_name}:", count: 1)
    end

    it "allows me to add a new strategy with a popup feature" do
      find(".add-strategy").click
      within ".modal-add" do
        fill_in "strategy[strategy]", with: "He's just a super kid."
        click_on "SAVE STRATEGY"
      end
      expect(current_path).to eq(student_path(@student))
      expect(page).to have_content("Successfully Added Strategy")
      expect(page).to have_content("He's just a super kid.")
    end

    it "allows me to edit a strategy with a popup feature" do
      find(".add-strategy").click
      within ".modal-add" do
        fill_in "strategy[strategy]", with: "Super."
        click_on "SAVE STRATEGY"
      end

      find(".edit-strategy-#{Strategy.first.id}").click
      within '.modal-edit' do
        fill_in "strategy[strategy]", with: "What a great guy."
      end
      click_on "UPDATE STRATEGY"
      expect(current_path).to eq(student_path(@student))
      expect(page).to have_content("Successfully Updated Strategy")
      expect(page).to have_content("What a great guy.")
    end

    it "allows me to delete MY strategies" do
      teacher2 = create(:teacher)
      strat1 = @teacher.strategies.create!(student_id: @student.id, strategy: "When Seattle Public Schools announced that it would reorganize school start times across the")
      strat2 = teacher2.strategies.create!(student_id: @student.id, strategy: "district for the fall of 2016, the massive undertaking took more than a year to deploy.")
      visit student_path(@student, {course_id: @course.id})
      click_link "Delete Strategy"
      expect(current_path).to eq(student_path(@student))
      expect(page).to have_content("Successfully Deleted Strategy")
      expect(page).to_not have_content("#{strat1.strategy}")
      expect(page).to_not have_link("Delete Strategy")

      expect(Student.first.strategies.count).to eq(2)
      expect(Student.first.strategies.first.active).to eq(false)
    end

    it "allows me to choose pre-made strategies from a list" do
      builtin = StrategyReference.create(built_in: "Graphic Organizers")
      find(".add-builtin-strategy").click
      within ".modal-builtin-add" do
        click_on "SAVE STRATEGY"
      end
      expect(page).to have_content("Graphic Organizers")
    end
  end
end
