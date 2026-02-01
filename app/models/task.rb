class Task < ApplicationRecord
  enum :priority, { high: 0, medium: 1, low: 2 }
  validates :title, presence: true
  validates :priority, presence: true

  def priority_label
    I18n.t("enums.task.priority.#{priority}")
  end
end
