module TestDataHelper
  # # REF: https://www.rubyguides.com/2015/03/ruby-random/
  # def generate_word(max_length = 20)
  #   charset = Array('A'..'Z') + Array('a'..'z')
  #   Array.new(max_length) { charset.sample }.join
  # end

  # def generate_email(max_length)
  #   charset = Array('A'..'Z') + Array('a'..'z')  << '%' << '#' << '$' << '!'
  #   suffix = "@local.com"

  #   if max_length <= suffix.length
  #       raise "Error on generate_email, max_length should be greater than #{suffix.length}"
  #   end

  #   (Array.new(max_length - suffix.length) { charset.sample }.join) + suffix
  # end
end