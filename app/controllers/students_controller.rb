class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        students=Student.all 
        render json: students
    end

    def create
        instructor=Instructor.find(params[:instructor_id])
        student=instructor.students.create!(student_params)
        render json: student, status: :created
    end

    def update
        student=Student.find(params[:id])
        student.update!(student_params)
        render json: student, status: :ok
    end

    def destroy
        student=Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private

    def student_params
        params.permit(:name, :major, :age)
    end

    def render_not_found_response
        render json: { error: "Student not found" }, status: :not_found
    end
    
    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
