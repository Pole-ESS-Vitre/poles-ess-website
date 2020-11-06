# RailsSettings Model
class Setting < RailsSettings::Base
  cache_prefix { "v1" }
  has_one_attached :logo

  field :project_name, type: :string, default: "Pôle ESS"
  field :baseline, type: :string, default: "Dynamiser les projets d'utilité sociale sur le territoire"
  field :baseline_pre, type: :string, default: "Accroche"
  field :logo_instance, type: :integer, default: 1, readonly: true
  field :admin_emails, type: :array, default: %w[bonjour@lassembleuse.fr]

  validates :logo, content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'], message: 'doit être une image' }

  def self.logo
    self.logo_instance.logo
  end

  def self.logo_instance
    self.where(var: :logo_instance).first_or_create
  end
end
