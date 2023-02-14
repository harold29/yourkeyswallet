class CurrenciesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_currency, only: %i[ show update destroy ]

  # GET /currencies
  def index
    with_authenticated_user do
      @currencies = Currency.all

      authorize @currencies

      render json: @currencies, each_serializer: CurrencySerializer
    end
  end

  # GET /currencies/1
  def show
    with_authenticated_user do
      if @currency
        authorize @currency

        render json: CurrencySerializer.new(@currency).serializable_hash
      else
        render :json, status: :not_found
      end
    end
  end

  # POST /currencies
  def create
    with_authenticated_user do
      @currency = Currency.new(currency_params)

      authorize @currency

      if @currency.save
        render json: {
          currency: CurrencySerializer.new(@currency).serializable_hash
        }, status: :created
      else
        render json: @currency.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /currencies/1
  def update
    with_authenticated_user do
      if @currency

        authorize @currency
        
        if @currency.update(currency_params)
          # render json: CurrencySerializer.new(@currency).serializable_hash
          render json: {
            currency: CurrencySerializer.new(@currency).serializable_hash
          }
        else
          render json: @currency.errors, status: :unprocessable_entity
        end
      else
        render :json, status: :not_found
      end
    end
  end

  # DELETE /currencies/1
  def destroy
    with_authenticated_user do
      if @currency
        
        authorize @currency

        @currency.destroy
      else
        render :json, status: :not_found
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_currency
      @currency = Currency.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def currency_params
      params.require(:currency).permit(:name, :code, :symbol)
    end

    def with_authenticated_user(&block)
      begin
        if current_user
          block.call
        else
          render :json, status: :unauthorized
        end
      end
    end
end
