class Instructor::SectionsController < ApplicationController
	before_action :authenticate_user!
	 before_action :require_authorized_for_current_course, only: [:create]
   before_action :require_authorized_for_current_section, only: [:update]

	def new
		@section = Section.new
	end

   def update
      current_lesson.update_attributes(lesson_params)
      render text: 'updated!'
    end

	 def create
    @section = @course.sections.create(section_params)
    redirect_to instructor_course_path(@course)
   end

  private

  def require_authorized_for_current_course
    if current_course.user != current_user
      render text: "Unauthorized", status: :unauthorized
    end
  end

   helper_method :current_course
  def current_course
     if params[:course_id]
      @current_course ||= Course.find(params[:course_id])
     else
       current_section.course
    end
  end
  def section_params
    params.require(:sections).permit(:title, :row_ordeer_position)
  end
end
