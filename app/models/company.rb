class Company < ApplicationRecord

    has_one :pitch

    before_create :set_slug

    def set_slug
        self.slug = self.name.parameterize
    end

end
