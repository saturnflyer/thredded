require 'spec_helper'
require 'timecop'

module Thredded
  describe Topic, 'associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:categories) }
    it { should belong_to(:last_user) }
    it { should belong_to(:messageboard) }
  end

  describe Topic, 'validations' do
    before { create(:topic) }
    it { should validate_presence_of(:last_user_id) }
    it { should validate_presence_of(:messageboard_id) }
    it { should validate_uniqueness_of(:hash_id) }
  end

  describe Topic, '.find_by_slug!' do
    it 'finds the topic' do
      topic = create(:topic, title: 'Oh Hello')

      expect(Topic.find_by_slug!('oh-hello')).to eq topic
    end

    it 'raises Thredded::Errors::TopicNotFound error' do
      expect { Topic.find_by_slug!('rubbish') }
        .to raise_error(Thredded::Errors::TopicNotFound)
    end
  end

  describe Topic, '.order_by_stuck_and_updated_time' do
    it 'starts with stuck topics, followed by the rest' do
      stuck = create(:topic, :sticky)
      old = create(:topic, updated_at: 3.weeks.ago)
      create(:topic)

      topics = Topic.order_by_stuck_and_updated_time

      expect(topics.first).to eq stuck
      expect(topics.last).to eq old
    end
  end

  describe Topic, '.decorate' do
    it 'decorates topics returned from AR' do
      create_list(:topic, 3)

      expect(Topic.all.decorate.first).to be_a(Thredded::TopicDecorator)
    end
  end

  describe Topic, '#decorate' do
    it 'decorates a topic' do
      topic = create(:topic)

      expect(topic.decorate).to be_a(Thredded::TopicDecorator)
    end
  end

  describe Topic, '#last_user' do
    it 'provides anon user object when user not avail' do
      topic = build_stubbed(:topic, last_user_id: 1000)

      expect(topic.last_user).to be_instance_of NullUser
      expect(topic.last_user.to_s).to eq 'Anonymous User'
    end

    it 'returns the last user to post to this thread' do
      user = build_stubbed(:user)
      topic = build_stubbed(:topic, last_user: user)

      expect(topic.last_user).to eq(user)
    end
  end

  describe Topic do
    before(:each) do
      @user = create(:user)
      @messageboard = create(:messageboard)
      @topic  = create(:topic, messageboard: @messageboard)
    end

    it 'is associated with a messageboard' do
      topic = build(:topic, messageboard: nil)
      expect(topic).not_to be_valid
    end

    it 'handles category ids' do
      cat1 = create(:category, messageboard: @messageboard)
      cat2 = create(:category, :beer, messageboard: @messageboard)
      topic = create(:topic, category_ids: ['', cat1.id, cat2.id])
      expect(topic.valid?).to eq true
    end

    it 'changes updated_at when a new post is added' do
      old = @topic.updated_at
      create(:post, postable: @topic)

      expect(@topic.reload.updated_at).not_to eq old
    end

    it 'does not change updated_at when an old post is edited' do
      Timecop.freeze(1.month.ago) { @post = create(:post) }
      old_time = @post.postable.updated_at
      @post.update_attributes(content: 'hi there')

      expect(@post.postable.reload.updated_at.to_s).to eq old_time.to_s
    end
  end
end
