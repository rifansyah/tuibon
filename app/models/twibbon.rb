class Twibbon < ApplicationRecord
    has_attached_file :twib_image, styles: { medium: "300x300>", thumb: "100x100>" },url: "/system/twibbons/images/original/:style/:basename.:extension", default_url: "/images/:style/missing.png"
    validates_attachment_content_type :twib_image, content_type: /\Aimage\/.*\z/
end
