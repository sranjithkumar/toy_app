class UsersController < ApplicationController
  require 'openssl'
  require 'base64'
  require "prawn"

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.pdf do
        pdf = PDF::Writer.new
        @users.each do |user|
          pdf.text user.name
        end
        send_data pdf.render, :filename => 'products.pdf', :type => 'application/pdf', :disposition => 'inline'
      end
    end
  end

  def pdf_sample
    puts "-------------1--------"
    Prawn::Document.generate("hello.pdf") do
      text "Hello World!"
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # puts "----------------------1-------"
    # @pub_key = File.read("#{Rails.root}/public/public.pem")
    # string = 'MDQ2YzhkZmM1YzQ5YTFjYzUzMDI3ZjNjNTU4MDljNjM5ZDhhNmVjNSZlbWFpbD1rcmlzdGluZS5laXNzaW5nQHJhbmVuZXR3b3JrLmNvbQ==';

    # public_key = OpenSSL::PKey::RSA.new(@pub_key)
    # encrypted_string = Base64.encode64(public_key.public_encrypt(string))
    # puts encrypted_string
    # puts "----------------------2-------"
    @user = User.find(1)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = UserPdf.new(@user)
        send_data pdf.render, :filename => 'products.pdf', :type => 'application/pdf', :disposition => 'inline'
      end
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
