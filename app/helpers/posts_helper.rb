module PostsHelper

  def randomDeletionConfirmationMessage
    prepost = "Post Deleted,"
    confirmations = [
      "#{prepost} your secret is safe with me.",
      "#{prepost} I guess you really didn't want anyone to know about this thing that happened you know when",
      "#{prepost} perhaps next time we should stick to posting cat photos"
    ]
    return confirmations.sample
  end

  def likers_of(post,max=3)
    votes = post.votes_for.up.by_type(User)
    user_names = []
    unless votes.blank?
      votes.voters.each do |voter|
        user_names << (link_to  voter.username,
                                profile_path(voter.username),
                                class: 'user-name')
      end

      if votes.size > max
        votes.size.to_s + " likes"
      else
        user_names.first(max).to_sentence(:last_word_connector => ' and ').html_safe + like_plural(votes)
      end
    end
  end

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end

  def likes_post(post)
    post.votes_for.up.by_type(User).voters.include?(current_user)
  end
end
