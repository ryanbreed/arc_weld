module ArcWeld
  module Helpers
    def constantize(literal)
      (literal.to_s.split(%r{[ _]}).map &:capitalize).join('')
    end
  end
end