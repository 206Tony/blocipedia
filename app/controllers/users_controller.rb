class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new
		@user.name = params[:user][:name]
		@user.email = params[:user][:email]
		@user.password = params[:user][:password]
		@user.password_confirmation = params[:user][:password_confirmation]

		if @user.save
			flash[:notice] = "Welcome to Blocipedia, #{@user.name}!"
			redirect_to root_path
		else
			flash[:error] = "There was an error creating your account. Please try again."
			render :new
		end
	end

	# def downgrade
	# 	@user = User.find(params[:id])
	# 	@user.role = 'standard'

	# 	if @user.save
	# 		flash[:notice] = "Account has been downgraded to standard. Privacy deleted."
	# 		redirect_to :back
	# 	else
	# 		flash[:error] = "There was an error creating your account.  Please try again."
	# 		redirect_to :back
	# 	end

	# 	@user_wikis = @user.wikis.where(private: true)
	# 	@user_wikis.each do |makepub|
	# 		makepub.update_attributes(private: false)
	# 	end
	# end

	# def index
	# 	@user = User.all 
	# end

	def show
		@user = User.find(params[:id])
		@wikis = @user.wikis.visible_to(current_user)
	end

end
