# frozen_string_literal: true

class Integer
  def to_filesize
    units = %w[B KiB MiB GiB TiB PiB EiB ZiB]

    return '0.0 B' if zero?

    exp = (Math.log(self) / Math.log(1024)).to_i
    exp += 1 if to_f / (1024**exp) >= 1024 - 0.05
    exp = units.size - 1 if exp > units.size - 1

    format('%.1f %s', to_f / (1024**exp), units[exp])
  end
end
