module ApplicationHelper

  def avatar_url(email)
      gravatar_id = Digest::MD5.hexdigest(email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=32&d=identicon"

  end


end
