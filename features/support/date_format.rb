class DateFormat 
  class << self
  # format used by 
  # Albania, Algeria, Bulgaria, Canada
  # France, Iraq, Israel, Italy, Kenya,
  # Luxembourg, Pakistan, Portugal
  # Saudi arabia, Spain, United Kingdom
  def uk
   '%d/%m/%Y'
   end

    # dot format used by
    # Armenia, Belarus, Bulgaria, Georgia
    # Germany Greenland, Iceland, Kazahkstan, Kyrgyzstan, Latvia
    # Macedonia, Poland, Romania, Russia, Serbia, Switzerland, Tajikistan
    # Ukraine, Uzbekistan
    def eu
     '%d.%m.%Y'
    end
  end
end
#Countries that use multiple formats: Canada, France
