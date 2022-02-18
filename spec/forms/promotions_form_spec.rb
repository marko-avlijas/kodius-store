require 'rails_helper'

RSpec.describe PromotionsForm, type: :model do
  fixtures :all

  let(:basket) { Basket.create }
  let(:discount_20_percent_off) { percent_discounts(:discount_20_percent_off) }
  let(:discount_5_percent_off) { percent_discounts(:discount_5_percent_off) }
  let(:discount_20_euro_off) { amount_discounts(:discount_20_euro_off) }
  subject { described_class.new(basket: basket) }

  describe "validations" do
    it "is valid" do
      subject.code = percent_discounts(:discount_20_percent_off).code
      expect(subject.valid?).to be true
    end

    context "is invalid" do
      it "given not existing code" do
        subject.code = "No such code"
        expect(subject.valid?).to be false
        expect(subject.errors.added?(:code, :inclusion, value: "No such code")).to be true
      end

      # this spec catches a bug which was present
      it "given not existing code with a code already applied" do
        basket.promotion_codes << discount_5_percent_off

        subject.code = "No such code"
        expect(subject.valid?).to be false
        expect(subject.errors.added?(:code, :inclusion, value: "No such code")).to be true
        expect(subject.errors.count).to eq(1)
      end

      it "given already applied code" do
        basket.promotion_codes << discount_5_percent_off

        subject.code = discount_5_percent_off.code
        expect(subject.valid?).to be false
        expect(subject.errors.added?(:code, :taken)).to be true
        expect(subject.errors.count).to eq(1)
      end

      it "given code which can't be combined to other codes" do
        basket.promotion_codes << discount_5_percent_off
        subject.code = discount_20_percent_off.code
        expect(subject.valid?).to be false
        expect(subject.errors.added?(:base, :invalid)).to be true
      end

      it "given code which can be combined when code that can't be combined is applied" do
        basket.promotion_codes << discount_20_percent_off
        subject.code = discount_5_percent_off.code
        expect(subject.valid?).to be false
        expect(subject.errors.added?(:base, :invalid)).to be true
      end
    end
  end
end
