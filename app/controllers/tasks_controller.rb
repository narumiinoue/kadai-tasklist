class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy] 
  
  def index
      @tasks = current_user.tasks.all.page(params[:page]).per(15)
  end

  def show
  end

  def new
      @task = current_user.tasks.build
  end

  def create
      @task = current_user.tasks.build(task_params)
      
      if @task.save
        flash[:success] = '正常に登録されました'
        redirect_to @task
      else
        flash.now[:danger] = '登録できませんでした'
        render :new
      end
      
  end

  def edit
  end

  def update

      if @task.update(task_params)
        flash[:success] = '正常に更新されました'
        redirect_to @task
      else
        flash.now[:danger] = '更新されませんでした'
        render :edit
      end
  end

  def destroy
      @task.destroy

      flash[:success] = '正常に削除されました'
      redirect_to root_url
  end
  
  private
  
  def set_task
      @task = current_user.tasks.find(params[:id])
  end
  
  def task_params
      params.require(:task).permit(:content, :status)
  end
  
end
