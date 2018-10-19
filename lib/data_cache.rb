module DataCache
  FILE_ENCODE = "ASCII-8BIT"

  def dump(data, file_name)
    dmp = Marshal.dump(data)
    offset = 0
    while offset < dmp.size
      offset += IO.write(file_name, dmp[offset..(offset + 999999)], offset, encoding: FILE_ENCODE)
    end
  end

  def load(file_name)
    dmp = File.read(file_name, encoding: FILE_ENCODE, mode: "rb")
    Marshal.load(dmp)
  end
end
