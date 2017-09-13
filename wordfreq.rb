class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

  def initialize(filename)
    @document = File.read(filename).downcase.gsub(/[^a-z0-9\s]/i, ' ')

    @word_array = File.read(filename).downcase.gsub(/[^a-z0-9\s]/i, ' ').split(' ')
  end

  def frequency(word)
    count = @document.scan ' ' + word + ' '
    count.size
  end

  def frequencies
    @word_hash = {}
    @word_array.each do |word|
      if STOP_WORDS.include? word
      else
        @word_hash[word] = frequency(word)
      end
    end
    # @word_array.each do |word|
    #   if STOP_WORDS.include? word
    #
    #   elsif @word_hash[word] == nil
    #     @word_hash[word] = 1
    #   else
    #     @word_hash[word] += 1
    #   end
    # end
    @word_hash
  end

  def top_words(number)
    word_array = frequencies.sort_by{ |word, count| count }.reverse
    final = word_array[0, number]
  end

  def print_report
    top_ten = top_words(10)
    top_ten.each do |word, count|
      puts " #{word} | #{count} " + "*"*count
    end
  end
end

if __FILE__ == $0
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end
