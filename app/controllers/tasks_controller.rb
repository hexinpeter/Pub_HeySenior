class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :accept_bid, :close]
  before_action :set_task, only: [:show, :edit, :update, :destroy, :accept_bid, :close]
  before_action :check_permission, only: [:edit, :update, :destroy, :accept_bid, :close]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.page(params[:page]).per(10)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    if !user_signed_in?
      @current_user_identity = 'stranger'
    elsif @task.user == current_user
      @current_user_identity = 'requester'
    elsif @task.bid_already?(current_user)
      @current_user_identity = 'bidder'
      @bid = @task.bids.find_by_user_id(current_user.id)
    else
      @current_user_identity = 'potential_bidder'
      @bid = @task.bids.new
    end
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user = current_user

    respond_to do |format|
      if @task.save
        TaskMailer.create_email(@task).deliver_now
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def close
    @task.close
    @task.bids.each { |bid| bid.close }
    redirect_to @task, notice: 'Closed successfully.'
  end

  def search
    @tasks = Task.page(params[:page]).per(10)
    if params[:subject_area].present?
      subject_area = params[:subject_area]
      @tasks = SubjectArea.find_by_name(subject_area).tasks.page(params[:page]).per(10)
    end
    render :index
  end

  def accept_bid
    @bid = Bid.find_by_id(params[:bid_id])
    if !@bid or @bid.task != @task
      redirect_to root, alert: 'Permission denied.'
    end

    @task.bids.each { |bid| bid.close }
    @bid.accept
    @task.accept
    TaskMailer.accept_email(@task).deliver_now
    TaskMailer.bid_accepted_email(@bid).deliver_now

    redirect_to visit_user_path(@bid.user), notice: 'Accepted successfully, contact your senior to meet!'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def check_permission
      if @task.user != current_user
        redirect_to tasks_path, alert: 'Permission denied.'
      elsif @task.accepted?
        redirect_to @task, alert: 'Permission denied. This task has already been accepted.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:user_id, :subject, :description, :upper_price, :lower_price, :location, :title, :status, :subject_area_id, {documents: []})
    end
end
