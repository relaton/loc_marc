# frozen_string_literal: true

RSpec.describe LocMarc::Codes do
  describe "code list isolation" do
    it "returns the country entry for a code that is also a geographic area code" do
      expect(LocMarc::Codes::Country.lookup("aa")[:description]).to eq "Albania"
      expect(LocMarc::Codes::GeographicArea.lookup("aa")[:description])
        .to eq "Amur River (China and Russia)"
    end

    it "returns the language entry for a code that is also a country code" do
      expect(LocMarc::Codes::Language.lookup("cau")[:description])
        .to eq "Caucasian (Other)"
    end

    it "does not find a relator code in the country list" do
      expect(LocMarc::Codes::Relator.lookup("aut")[:description]).to eq "Author"
      expect(LocMarc::Codes::Country.lookup("aut")).to be_nil
    end

    it "gives each code list its own database" do
      databases = [
        LocMarc::Codes::Relator, LocMarc::Codes::Language,
        LocMarc::Codes::Country, LocMarc::Codes::GeographicArea
      ].map(&:database)

      expect(databases.map(&:object_id).uniq.size).to eq 4
    end
  end

  describe ".lookup" do
    it "marks a deprecated code and removes its prefix" do
      expect(LocMarc::Codes::Country.lookup("ac")).to eq(
        code: "ac",
        description: "Ashmore and Cartier Islands",
        deprecated: true,
      )
    end
  end
end
