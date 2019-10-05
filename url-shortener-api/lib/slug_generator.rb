# frozen_string_literal: true

class SlugGenerator
  def self.generate
    # this gives us over 44 billion options. 62 choose 6 = n!/(n-k)! = 62!/56!
    charset = ['A'..'Z', 'a'..'z', '0'..'9'].map(&:to_a).flatten
    charset.sample(6).join
  end
end
