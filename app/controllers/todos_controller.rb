class TodosController < ApplicationController
  def index
    render plain: Todo.all.map { |todo| todo.to_pleasent_string }.join("\n")
  end

  def create
    todo = Todo.new(todo_text: params[:todo_text], due_date: params[:due_date], completed: false)
    if todo.save
      render json: todo, status: :created
    else
      render json: todo.errors, status: :unporcessable_entity
    end
  end

  def show
    id = params[:id]
    todo = Todo.find(id)
    render plain: todo.to_pleasent_string
  end

  def update
    id = params[:id]
    todo = Todo.find(id)
    updated_status = params[:completed] == "true" ? true : false
    todo[:completed] = updated_status

    if todo.save
      render json: todo, status: :created
    else
      render json: todo.errors, status: :unporcessable_entity
    end
  end
end
