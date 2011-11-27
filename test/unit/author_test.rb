require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :authors

  def test_name
    author = Author.create(
        :first_name => 'Joel',
        :last_name => 'Spoolsky'
    )

    assert_equal 'Joel Spoolsky',author.name
  end

end
