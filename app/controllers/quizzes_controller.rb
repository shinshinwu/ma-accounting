class QuizzesController < ApplicationController
  before_filter :authenticate_access!
  before_filter :authenticate_admin!, only: [:index]
  before_filter :authenticate_user!, only: [:submit]
  before_filter :set_quizz_context, except: [:index]

  def index
  end

  def show
    if @quizz.passed_by_user?(current_user)
      flash[:alert] = "You have already successfully passed the quizz!"
      redirect_to quizz_certificate_course_module_path(@module)
    end

    @attempt = @quizz.attempts.by_user(current_user).order(created_at: :desc).first
  end

  def submit
    correct_question_ids = []
    params[:question].each do |q, a|
      question = QuizzQuestion.find_by_id(q)
      answers  = QuizzAnswer.where(id: a).sort
      if answers == question.answers.correct.sort
        correct_question_ids << q.to_i
      end
    end

    passed = @quizz.have_passing_score?(correct_question_ids.size)
    # add quizz attempt transactions
    QuizzAttempt.create!(user: current_user, quizz: @quizz, correctly_answered: correct_question_ids, passed: passed)

    if passed
      redirect_to quizz_certificate_course_module_path(@module)
    else
      redirect_to quizz_course_module_path(@module, retry: true)
    end
  end

  def certificate
    # redirect unless user have passed
    unless @quizz.passed_by_user?(current_user)
      flash[:alert] = "Sorry, page not found!"
      redirect_to :back
    end
    @attempt          = @quizz.attempts.by_user(current_user).passed.order(created_at: :desc).first
    @certificate_info = Base64.urlsafe_encode64({date: @attempt.created_at.to_date.to_s, name: current_user.name, module_num: @attempt.quizz.course_module.id}.to_json)
  end

  def certificate_pdf_preview
    certificate_info = JSON.parse(Base64.urlsafe_decode64(params[:preview]))
    respond_to do |format|
      format.pdf do
        certificate       = ::PDF::Certificate.new
        send_data(certificate.render(certificate_info["date"], certificate_info["name"], certificate_info["module_num"]), { type: "application/pdf", disposition: "inline" })
      end
    end
  end

  private

  def set_quizz_context
    @module = CourseModule.find_by_id(params[:id])
    unless @module.present?
      flash[:alert] = 'Sorry, module not found!'
      redirect_to :back and return
    end

    @quizz     = @module.quizz
    @questions = @quizz.questions.includes(:answers)
    @question  = QuizzQuestion.find_by_id(params[:question_id]) || @questions.first
  end
end
