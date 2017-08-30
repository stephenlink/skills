module ApplicationHelper

	def alert_for(flash_type)
    { success: 'alert-success',
    error: 'alert-danger',
    alert: 'alert-warning',
    notice: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
    end

    def profile_avatar_select(user)
      return image_tag user.avatar.url(:medium),
        id: 'image-preview',
          class: 'img-responsive img-circle profile-image' if user.avatar.exists?
            image_tag 'default-avatar.jpg', id: 'image-preview',
              class: 'img-responsive img-circle profile-image'
    end
end

module PostsHelper
  def display_likes(post)
    votes = post.votes_for.up.by_type(User)
    return list_likers(votes) if votes.size <= 4
    count_likers(votes)
  end

  private

  def count_likers(votes)
    vote_count = votes.size
    vote_count.to_s + ' recommendations'
  end

  def list_likers(votes)
    user_names = []
    unless votes.blank?
      votes.voters.each do |voter|
        user_names.push(link_to voter.user_name,
                                profile_path(voter.user_name),
                                class: 'user-name')
      end
      user_names.to_sentence.html_safe + like_plural(votes)
    end
  end

  def like_plural(votes)
    return ' recommend this skill' if votes.count > 1
    ' recommends this skill'
  end
end
