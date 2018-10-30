module SafeFileName
  TABOOS = ["\\", "/", ":", "*", "?", "\"", "<", ">", "|"].freeze
  FULL_TABOOS = ["￥", "／", "：", "＊", "？", "￥", "＜", "＞", "｜"].freeze

  def to_safe_file_name(source)
    safe_name = source.dup
    TABOOS.each_index { |idx| safe_name.gsub!(TABOOS[idx], FULL_TABOOS[idx]) }
    safe_name
  end
end
