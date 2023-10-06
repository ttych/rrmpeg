# frozen_string_literal: true

require_relative 'configurable'

module RRmpeg
  class FFprobeConfig
    include Configurable

    BIN_DEFAULT = 'ffprobe'

    var :bin, default: BIN_DEFAULT

    #     var  :bin, default: DEFAULT_BIN
    # flag :hide_banner, option: '-hide_banner', default: true
    # option :verbose, option: '-v', default: 'warning'

    # flag :show_format, option: '-show_format', default: true
    # flag :show_streams, option: '-show_streams', default: true
    # flag :show_programs, option: '-show_programs', default: true
    # flag :show_chapters, option: '-show_chapters', default: true
    # flag :show_error, option: '-show_error', default: true
    # option :print_format, option: '-print_format'
    # arg :input, mandatory: true
  end
end
