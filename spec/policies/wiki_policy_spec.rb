require 'rails_helper'

RSpec.describe WikiPolicy, type: :controller do

  let(:standard_user) { create (:user) }
  let(:premium_user) { create (:premium_user) }
  let(:admin_user) { create (:admin_user) }
  let(:public_wiki) { create (:wiki) }
  let(:private_wiki) { create (:private_wiki) }

  subject { described_class }

  def resolve_for(user)
    subject::Scope.new(user, Wiki).resolve
  end



  context "admin user" do

    permissions ".scope" do
      it "returns public wikis" do
        public_wiki
        expect(resolve_for(admin_user)).to eq [public_wiki]
      end

      it "returns private wikis" do
        private_wiki
        expect(resolve_for(admin_user)).to eq [private_wiki]
      end
    end

    permissions :index?, :show?, :update?, :edit?, :destroy? do
      it "grants access to admin user for public wikis" do
        expect(subject).to permit(admin_user, public_wiki)
      end

      it "grants access to admin user for private wikis" do
        expect(subject).to permit(admin_user, private_wiki)
      end
    end

    permissions :create?, :new? do
      it "grants access to admin user for public wikis" do
        expect(subject).to permit(admin_user, Wiki.new(private: false))
      end

      it "grants access to admin user for private wikis" do
        expect(subject).to permit(admin_user, Wiki.new(private: true))
      end
    end
  end



  context "premium user" do

    permissions ".scope" do
      it "returns public wikis" do
        public_wiki
        expect(resolve_for(premium_user)).to eq [public_wiki]
      end

      it "does not return private wikis by other users" do
        private_wiki
        expect(resolve_for(premium_user)).to eq []
      end

      it "returns private wiki by current user" do
        wiki = Wiki.create(user: premium_user, private: true)
        expect(resolve_for(premium_user)).to eq [wiki]
      end
    end

    permissions :index? do
      it "grants access to premium user for public wikis" do
        expect(subject).to permit(premium_user, public_wiki)
      end

      it "denies access to premium user for private wikis by other users" do
        expect(subject).not_to permit(premium_user, private_wiki)
      end

      it "grants access to premium user for own private wiki" do
        wiki = Wiki.create(user: premium_user, private: true)
        expect(subject).to permit(premium_user, wiki)
      end
    end

    permissions :show? do
      it "grants access to premium user for public wikis" do
        expect(subject).to permit(premium_user, public_wiki)
      end

      it "denies access to premium user for private wikis by other users" do
        expect(subject).not_to permit(premium_user, private_wiki)
      end

      it "grants access to premium user for own private wiki" do
        wiki = Wiki.create(user: premium_user, private: true)
        expect(subject).to permit(premium_user, wiki)
      end
    end

    permissions :create?, :new? do
      it "grants access to premium user for public wikis" do
        expect(subject).to permit(premium_user, Wiki.new(private: false))
      end

      it "grants access to premium user for private wikis" do
        expect(subject).to permit(premium_user, Wiki.new(private: true))
      end
    end

    permissions :update?, :edit? do
      it "grants access to premium user for public wikis" do
        expect(subject).to permit(premium_user, public_wiki)
      end

      it "denies access to premium user for private wikis by other users" do
        expect(subject).not_to permit(premium_user, private_wiki)
      end

      it "grants access to premium user for own private wiki" do
        wiki = Wiki.create(user: premium_user, private: true)
        expect(subject).to permit(premium_user, wiki)
      end
    end

    permissions :destroy? do
      it "denies access to premium user for public wikis by other users" do
        expect(subject).not_to permit(premium_user, public_wiki)
      end

      it "denies access to premium user for private wikis by other users" do
        expect(subject).not_to permit(premium_user, private_wiki)
      end

      it "grants access to premium user for own public wiki" do
        wiki = Wiki.create(user: premium_user, private: false)
        expect(subject).to permit(premium_user, wiki)
      end

      it "grants access to premium user for own private wiki" do
        wiki = Wiki.create(user: premium_user, private: true)
        expect(subject).to permit(premium_user, wiki)
      end
    end
  end



  context "standard user" do

    permissions ".scope" do
      it "returns public wikis" do
        public_wiki
        expect(resolve_for(standard_user)).to eq [public_wiki]
      end

      it "does not return private wikis by other users" do
        private_wiki
        expect(resolve_for(standard_user)).to eq []
      end

      it "returns private wiki by current user" do
        wiki = Wiki.create(user: standard_user, private: true)
        expect(resolve_for(standard_user)).to eq [wiki]
      end
    end
    
    permissions :index? do
      it "grants access to standard user for public wikis" do
        expect(subject).to permit(standard_user, public_wiki)
      end

      it "denies access to standard user for private wikis by other users" do
        expect(subject).not_to permit(standard_user, private_wiki)
      end

      it "grants access to standard user for own private wiki" do
        wiki = Wiki.create(user: standard_user, private: true)
        expect(subject).to permit(standard_user, wiki)
      end
    end

    permissions :show? do
      it "grants access to standard user for public wikis" do
        expect(subject).to permit(standard_user, public_wiki)
      end

      it "denies access to standard user for private wikis by other users" do
        expect(subject).not_to permit(standard_user, private_wiki)
      end

      it "grants access to standard user for own private wiki" do
        wiki = Wiki.create(user: standard_user, private: true)
        expect(subject).to permit(standard_user, wiki)
      end
    end

    permissions :create?, :new? do
      it "grants access to standard user for public wikis" do
        expect(subject).to permit(standard_user, Wiki.new(private: false))
      end

      it "grants access to standard user for private wikis" do
        expect(subject).to permit(standard_user, Wiki.new(private: true))
      end
    end

    permissions :update?, :edit? do
      it "grants access to standard user for public wikis" do
        expect(subject).to permit(standard_user, public_wiki)
      end

      it "denies access to standard user for private wikis by other users" do
        expect(subject).not_to permit(standard_user, private_wiki)
      end

      it "grants access to standard user for own private wiki" do
        wiki = Wiki.create(user: standard_user, private: true)
        expect(subject).to permit(standard_user, wiki)
      end
    end

    permissions :destroy? do
      it "denies access to standard user for public wikis by other users" do
        expect(subject).not_to permit(standard_user, public_wiki)
      end

      it "denies access to standard user for private wikis by other users" do
        expect(subject).not_to permit(standard_user, private_wiki)
      end

      it "grants access to standard user for own public wiki" do
        wiki = Wiki.create(user: standard_user, private: false)
        expect(subject).to permit(standard_user, wiki)
      end

      it "grants access to standard user for own private wiki" do
        wiki = Wiki.create(user: standard_user, private: true)
        expect(subject).to permit(standard_user, wiki)
      end
    end
  end
end
