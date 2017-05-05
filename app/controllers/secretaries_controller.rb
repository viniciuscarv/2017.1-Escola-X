# File name: secretary_controller.rb
# Class name: SecretaryController
# Description: Controller used to communicate with the proprietary view of secretarys

class SecretariesController < ApplicationController
	include SessionsHelper

  def index
    if ( is_principal? )
      @secretaries = Secretary.all
    end
  end


  def show
    if ( logged_in? )
      @secretary = Secretary.find(params[:id])
    end
  end


  def new
    if ( is_principal? )
      @secretary = Secretary.new
    end
  end

  def edit
    if ( is_principal? )
      @secretary = Secretary.find(params[:id])
    end
  end


  def create
    if ( is_principal? )
      @secretary = Secretary.new(secretary_params)

      if (@secretary.save)
        flash[:notice] = "Secretário(a) criado(a) com sucesso"
        redirect_to @secretary
      else
        render 'new'
      end
    end
  end


  def update
    if ( is_principal? )
      @secretary = Secretary.find(params[:id])
      if @secretary.update secretary_params
        flash[:notice] = "Secretário(a) alterado(a) com sucesso"
        redirect_to @secretary
      else
        render 'edit'
      end
    end
  end

  def destroy
    if ( is_principal? )
      @secretary = Secretary.find(params[:id])
      if (@secretary.destroy)
        flash[:notice] = "Secretário(a) excluído(a) com sucesso"
      end
      
      redirect_to secretaries_path
    end
  end

  private

  def secretary_params
  	params.require(:secretary).permit( :employee_cpf,
								       :admission_date,
								       :shift,
								       :name,
								       :address,
								       :phone,
								       :gender,
								       :birth_date,
								       :permission,
								       :password)
  end

end