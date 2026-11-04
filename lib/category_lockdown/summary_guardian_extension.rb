# frozen_string_literal: true

# A topic's AI summary (Discourse AI) is its content in short, and the summary
# endpoint checks only that the topic is visible, which a locked topic is.
# Gists stay: one line in topic lists, the teaser.
module ::CategoryLockdown::SummaryGuardianExtension
  def can_see_summary?(target, cached_summary: nil)
    if SiteSetting.category_lockdown_enabled && target.is_a?(::Topic) &&
         ::CategoryLockdown.is_locked(self, target)
      return false
    end
    super
  end
end
