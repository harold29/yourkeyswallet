class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show update destroy ]

  # GET /transactions
  def index
    if current_user
      @transactions = Transaction.find_all_by_user_id(current_user.id)

      authorize @transactions

      render json: @transactions
    else
      render :json, status: :unauthorized
    end
  end

  # GET /transactions/1
  def show
    if current_user
      if @transaction
        authorize @transaction

        render json: @transaction
      else
        render :json, status: :not_found
      end
    else
      render :json, status: :unauthorized
    end
  end

  # POST /transactions
  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      render json: @transaction, status: :created, location: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transactions/1
  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /transactions/1
  # def destroy
  #   @transaction.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.where("id=? AND user_id=?", params[:id], current_user.id).first
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:user_id, :transaction_amount, :operation, :transaction_state)
    end
end
