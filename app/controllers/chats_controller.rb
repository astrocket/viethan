class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :edit, :update, :destroy]

  PAGE_UNIT = 10

  # GET /chats
  # GET /chats.json
  def index

    if params[:category]
      case params[:category]
        when 'all'
          @chats = Chat.all.paginate(:page => params[:page], :per_page => PAGE_UNIT).order(updated_at: :desc)
        else
          @chats = Chat.where(category: params[:category]).paginate(:page => params[:page], :per_page => PAGE_UNIT).order(:updated_at)
      end
    else
      @chats = Chat.all.paginate(:page => params[:page], :per_page => PAGE_UNIT).order(updated_at:  :desc)
    end

    if request.xhr? && params[:pageless] == 'true'
      render :partial => @chats
    end

  end

  # GET /chats/1
  # GET /chats/1.json
  def show
  end

  # GET /chats/new
  def new
    @chat = Chat.new
  end

  # GET /chats/1/edit
  def edit
  end

  # POST /chats
  # POST /chats.json
  def create
    @chat = current_user.chats.new(chat_params)

    respond_to do |format|
      if @chat.save
        format.html { redirect_to @chat, notice: 'Chat was successfully created.' }
        format.json { render :show, status: :created, location: @chat }
      else
        format.html { render :new }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chats/1
  # PATCH/PUT /chats/1.json
  def update
    redirect_to root_path unless @chat.user == current_user

    respond_to do |format|
      if @chat.update(chat_params)
        format.html { redirect_to @chat, notice: 'Chat was successfully updated.' }
        format.json { render :show, status: :ok, location: @chat }
      else
        format.html { render :edit }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1
  # DELETE /chats/1.json
  def destroy
    redirect_to root_path unless @chat.user == current_user

    @chat.destroy
    respond_to do |format|
      format.html { redirect_to chats_url, notice: 'Chat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_chat
    @chat = Chat.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def chat_params
    params.require(:chat).permit(:user_id, :room_title, :category, :banned, :anonymous)
  end
end
