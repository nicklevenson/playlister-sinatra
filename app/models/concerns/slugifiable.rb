module Slugifiable

  def slug
    name = self.name
    regex = /[a-zA-Z1-9-]/
    slug = name.gsub(" ", "-").downcase.scan(regex).join
    slug
  end

  def find_by_slug(slug)
    self.all.select do |obj|
      obj.slug == slug
    end.first
  end

end