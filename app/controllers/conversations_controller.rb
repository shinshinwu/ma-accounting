class ConversationsController < ApplicationController
  before_filter :authenticate_access!
  before_filter :set_conversation_context, except: [:new]
  # Bypass CSRF protection for mobile APIs.
  skip_before_filter :verify_authenticity_token, only: [:mark_read]

  def show
    @messages   = @conversation.messages.order(:created_at)
    @has_unread = @messages.unread.exists?
  end

  def new
    @conversation = Conversation.new
  end

  def mark_read
    @conversation.messages.not_by_member(current_member).unread.each(&:mark_read!)
    render json: {success: true}
  end

  private

  def set_conversation_context
    @conversation = Conversation.find_by_slug(params[:slug])

    unless @conversation.present? && @conversation.is_engaged_by?(current_member)
      flash[:error] = "Sorry the message could not be found"
      redirect_to :back and return
    end
  end
end
