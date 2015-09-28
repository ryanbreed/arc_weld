module ArcWeld
  module Helpers
    def constantize(literal)
      (literal.to_s.split(%r{[ _]}).map &:capitalize).join('')
    end

    def uri_join(*parts)
      pieces=parts.flat_map {|p| p.to_s.gsub(%r{\A/},'').gsub(%r{/\z},'')}
      format('/%s', pieces.join('/'))
    end
  end
end