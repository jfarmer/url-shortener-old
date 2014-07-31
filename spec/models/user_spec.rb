require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:links) }

  describe '#valid?' do
    it { should validate_presence_of(:email) }
    it { should allow_value('foo@gmail.com', 'foo+bar@test.io', 'foo.bar@x.museum').for(:email) }
    it { should_not allow_value('@', 'foo@', '@gmail.com', 'foo@gmail.c').for(:email) }

    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
    it { should ensure_length_of(:password).is_at_least(6) }
  end
end
