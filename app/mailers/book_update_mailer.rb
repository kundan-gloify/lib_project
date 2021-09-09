class BookUpdateMailer < ApplicationMailer

	  default :from => 'kundan@gloify.com'


  	def send_bookupdate_email(user)
    	@user = user
		
    	mail(to: @user.email, subject: 'Book is Added / Removed from the Library')
  	end

end
