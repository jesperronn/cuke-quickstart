=begin

Copyright (c) 2012, Nathaniel Ritmeyer
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

3. Neither the name Nathaniel Ritmeyer nor the names of contributors to
this software may be used to endorse or promote products derived from this
software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS
IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=end
# see https://gist.github.com/2995205
# and http://www.natontesting.com/2012/06/26/list-all-tags-in-cucumber/
# modified by Jesper Rønn-Jensen to show number of occurrences


require 'cucumber/formatter/console'
require 'cucumber/formatter/io'

module Cucumber
  module Formatter
    class ListTags
      include Io
      include Console

      def initialize(step_mother, path_or_io, options)
        @io = ensure_io(path_or_io, "list_tags")
        @all_tags = []
      end

      def tag_name(tag_name)
        @all_tags << tag_name
      end

      def after_features(features)
        h = Hash.new(0)

        #count each tag
        @all_tags.each {|v| h[v] +=1 }
        maxlength = @all_tags.max_by {|x| x.length}.length
        h.sort.each {|tag, count| @io.puts "#{tag.ljust(maxlength + 5)} #{count.to_s.rjust(3)}" }
      end
    end
  end
end