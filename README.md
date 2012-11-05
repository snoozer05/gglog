# gglog

gglog is your partner for finding a good commit message.

## Installation

    % gem install gglog

## Usage

Register github projects to your seaech targets:

    % gglog register https://github.com/rails/rails.git

Search the text related to the contents which commit:

    % gglog search "Work on"
      Add support for Object#in? and Object#either? in Active Support [# ... rails 635d991683c439da56fa72853880e88e6ac291ed
      Add support for bare ActiveSupport via config.active_support.bare      rails 39034997d1bd1fbaf33ddf1d6e3996b3c298a409
      ...

Show detail if you need:

    % gglog show rails 635d991683c439da56fa72853880e88e6ac291ed

    Add support for Object#in? and Object#either? in Active Support [#6321 state:committed]

    This will allow you to check if an object is included in another object
    or the list of objects or not.
    ...

---

&copy; 2012 Koji Shimada.
