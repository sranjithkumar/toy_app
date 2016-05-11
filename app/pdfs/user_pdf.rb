class UserPdf < Prawn::Document
  def initialize(user)
    super(top_margin: 70)
    @user = user
    format_user
    line_items
  end
  
  def format_user
    text "order #{@user.name}", size: 30, style: :bold
  end
  
  def line_items
    move_down 20
  end
end