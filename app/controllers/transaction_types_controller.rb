class TransactionTypesController < ApplicationController
  before_action :set_transaction_type, only: %i[ show update destroy ]

  # GET /transaction_types
  def index
    @transaction_types = TransactionType.all

    authorize @transaction_types

    render json: @transaction_types
  end

  # GET /transaction_types/1
  def show
    authorize @transaction_type

    render json: @transaction_type
  end

  # POST /transaction_types
  def create
    @transaction_type = TransactionType.new(transaction_type_params)

    authorize @transaction_type

    if @transaction_type.save
      render json: @transaction_type, status: :created, location: @transaction_type
    else
      render json: @transaction_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transaction_types/1
  def update
    authorize @transaction_type

    if @transaction_type.update(transaction_type_params)
      
      render json: @transaction_type
    else
      render json: @transaction_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /transaction_types/1
  def destroy
    authorize @transaction_type

    @transaction_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction_type
      @transaction_type = TransactionType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_type_params
      params.require(:transaction_type).permit(:transaction_type, :description)
    end
end
