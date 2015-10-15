class ChargesController < ApplicationController

  def create
     # Creates a Stripe Customer object, for associating
     # with the charge
     customer = Stripe::Customer.create(
       email: current_user.email,
       card: params[:stripeToken]
     )

     # Where the real magic happens
     charge = Stripe::Charge.create(
       customer: customer.id, # Note -- this is NOT the user_id in your app
       amount: Amount.default,
       description: "Premium Membership - #{current_user.email}",
       currency: 'usd'
     )

     # update the user's role
     current_user.premium!

     flash[:notice] = "Thank you, #{current_user.email}! You are now a premium user!"
     redirect_to wikis_path(current_user) # or wherever

   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
     flash[:error] = e.message
     redirect_to new_charge_path
   end

   def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: Amount.default
    }
   end

   def destroy
   end

   def downgrade
     # change user role back to standard
     current_user.standard!

     # make all private wikis into public
     Wiki.where(:user_id => current_user).update_all(:private => false)

     flash[:notice] = "Your premium membership has been successfully cancelled and switched back to a standard."
     redirect_to wikis_path(current_user)
   end


end
