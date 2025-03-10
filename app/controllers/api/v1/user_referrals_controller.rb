class Api::V1::UserReferralsController < ApplicationController
  def create
    user_referral = UserReferral.new(user_referral_params)
    if user_referral.save
      render json: user_referral.to_json, status: :created
    else
      render json: user_referral.errors, status: :unprocessable_entity
    end
  end

  private

  def user_referral_params
    params.require(:user_referral).permit(:user_id, :referral_by)
  end
end
