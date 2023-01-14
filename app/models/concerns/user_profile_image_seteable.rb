module UserProfileImageSeteable
  extend ActiveSupport::Concern

  included do
    attr_accessor :profile_image_file

    before_validation :set_profile_image

    def set_profile_image
      if @profile_image_file.present?
        content = @profile_image_file.read
        base64 = Base64.encode64(content)

        self.profile_image = "data:image/png;base64,#{base64}"
      elsif profile_image.present?
        self.profile_image = nil
      end
    end
  end
end
