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
end
