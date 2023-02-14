class WalletsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wallet, only: %i[ show update destroy ]

  # GET /wallets
  def index
    if current_user
      @wallets = Wallet.find_all_by_user(current_user.id)

      authorize @wallets

      render json: @wallets
    else
      render :json, status: :unauthorized
    end
  end

  # GET /wallets/1
  def show
    if current_user      
      if @wallet
        authorize @wallet

        render json: WalletSerializer.new(@wallet).serializable_hash
      else
        render :json, status: :not_found
      end
    else
      render :json, status: :unauthorized
    end
  end

  # POST /wallets
  def create
    if current_user
      with_error_handler do
        @wallet = WalletBuilder.run(current_user, wallet_params[:currency_kind])
        authorize @wallet

        if @wallet.save
          render json: WalletSerializer.new(@wallet).serializable_hash, status: :created
        else
          render json: @wallet.errors, status: :unprocessable_entity
        end
      end
    else
      render :json, status: :unauthorized
    end
  end

  # DELETE /wallets/1
  def destroy
    if current_user
      if @wallet
        authorize @wallet

        @wallet.destroy
      else
        render :json, status: :not_found
      end
    else
      render :json, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.where("id=? AND user_id=?", params[:id], current_user.id).first
    end

    # Only allow a list of trusted parameters through.
    def wallet_params
      params.require(:wallet).permit(:currency_kind)
    end

    def with_error_handler(&block)
      begin
        block.call
      rescue WalletBuilder::CurrencyNotSupportedError => e
        render :json, status: :unprocessable_entity
      rescue WalletBuilder::EmptyCurrencyKindError => e
        render :json, status: :bad_request
      end
    end
end
