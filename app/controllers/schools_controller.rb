class SchoolsController < ApplicationController

  def index
    @schools = School.alphabetical.active.to_a
  end

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    
    if @school.save
      redirect_to school_path, notice: "Successfully added #{@school.name} as a school."
    else
      render action: 'new'
    end
  end


  def show
    @school = School.find(params[:id])
    # get the price history for this item
    @orders = @school.orders.chronological.to_a
  end


  def update
    @school = School.find(params[:id])
    if @school.update(school_params)
      redirect_to school_path(@school), notice: "Successfully updated #{@school.name}."
    else
      render action: 'edit'
    end
  end

  def edit
  end

  def destroy
    @school = School.find(params[:id])
    @school.destroy
    redirect_to schools_path, notice: "Successfully removed #{@school.name} from the system."
  end

  private
  def school_params
    params.require(:school).permit(:name, :street_1, :street_2, :city, :state, :zip, :min_grade, :max_grade)
  end



end
