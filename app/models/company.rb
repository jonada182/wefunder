class Company < ApplicationRecord

    has_many :pitches

    before_create :set_slug

    def set_slug
        self.slug = self.name.parameterize
    end

end
