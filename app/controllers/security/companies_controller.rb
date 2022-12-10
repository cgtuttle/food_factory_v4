class Security::CompaniesController < ApplicationController
    before_action :define_resources, only: [:edit, :show, :destroy, :update]

  def new
    @company = Security::Company.new
    # authorize @company
  end

  def create
    @company = Security::Company.new(company_params)
    authorize @company
    if @company.save!
      redirect_to company_path(@company), notice: "Successfully created company #{@company.name}"
    else
      flash.now[:alert] = "Could not create company"
      render :new
    end
  end

  def edit
    authorize @company
  end

  def update
    authorize @company
  end

  def show
    authorize @company
  end

  def index
    authorize Security::Company
    @companies = Security::Company.all
  end

  def destroy
    authorize @company
  end

  private

    def company_params
      params.require(:security_company).permit(:name, :code)
    end

    def define_resources
      @company = Security::Company.find(params[:id])
    end

end
