require_relative 'potd-vigenere-cipher'

describe "VigenereCipher" do

  let(:key_single_letter) { "r" }
  let(:message_single_letter) { "t" }
	let(:key) { "reddit" }
	let(:message) { "todayismybirthday" }
  let(:code) { "ksgdgbjqbeqkklgdg" }
	let(:key2) { "kurtrussell" }
	let(:message2) { "breakdownwasawesome" }
  let(:code2)    { "llvtbxgorhlcunxjiew" }

  describe "Setter Methods" do
    before(:each) { @cipher = VigenereCipher.new } 

    describe "#key and #message" do
      before do
        @cipher.key = key
        @cipher.message = message
      end

      it "validates the #key and #message to only include letters" do
        @cipher.key = "a&&*()(&^%$$#%$%&*(*aaaa11223344''''''''aabbcc"
        @cipher.message = "eebbccdd039324834;;.,..//\//r"
        expect(@cipher.key).to eq("aaaaaaabbcc")
        expect(@cipher.message).to eq("eebbccddr")
      end

      it "nils @code if changing an instance variable after @key and @message are set" do
        @cipher.message = message2
        expect(@cipher.instance_variable_get(:@code)).to be_nil
      end
    end

    describe "#code" do
      before do
        @cipher.message = message
      end
      
      it "warns the user if the code is smaller than the key" do
      end
    end
  end

  describe "Getter Methods" do
    describe "#key" do

      context "when key is present" do
        before do
          @cipher = VigenereCipher.new
          @cipher.key = key2
        end

        it "returns the value" do
          expect(@cipher.key).to eq(key2)
        end
      end

      context "when key is nil and message and code are present" do
        before do
          @cipher = VigenereCipher.new
          @cipher.message = message2
          @cipher.code = code2
        end
        it "returns the value for the key" do
          expect(@cipher.key).to eq(VigenereCipher.cycle(key2, message2) )
        end

      end
    end

    describe "#message" do
      before(:each) do
        @cipher = VigenereCipher.new(key2, nil)
      end

      context "when message is present" do
        before { @cipher.message = message2 }
        it "returns the value" do
          expect(@cipher.message).to eq(message2)
        end
      end

      context "when key and code are present" do
        before do
          @cipher.key = key2
          @cipher.code = code2
        end
        it "returns 'breakdownwasawesome'" do
          expect(@cipher.message = message2)
        end
      end
    end

    describe "#code" do
      before(:each) do
        @cipher = VigenereCipher.new
      end

      context "when key and message are present" do
        before do
          @cipher.key = key2
          @cipher.message = message2
        end
        
        it "returns 'llvtbxgorhlcunxjiew'" do
          expect(@cipher.code).to eq("llvtbxgorhlcunxjiew")
        end
      end

      context "when key and message are nil" do
        it "asks for the user to enter a key and message" do
          @cipher.stub(:gets).and_return("#{key2}\n", "#{message2}\n")
          expect(@cipher.key).to eq(key2)
          expect(@cipher.message).to eq(message2)
          expect(@cipher.code).to eq(code2)
        end
      end
      
      context "when key is present and message is nil" do
        before do
          @cipher.key = key2
        end

        it "asks for the user to enter a key" do
          @cipher.stub(:gets).and_return("#{message2}\n")
          expect(@cipher.key).to eq(key2)
          expect(@cipher.message).to eq(message2)
          expect(@cipher.code).to eq(code2)
        end
      end

      context "when key is nil and message is present" do
        before do
          @cipher.message = message2
        end
        it "asks for the user to enter a key" do
          @cipher.stub(:gets).and_return("#{key2}\n")
          expect(@cipher.key).to eq(key2)
          expect(@cipher.message).to eq(message2)
          expect(@cipher.code).to eq(code2)
        end
      end
    end
  end
	describe ".cycle" do
		let(:response) { VigenereCipher.cycle(key, message) }
		
		it "cycles through the key until its length == message.length" do
			expect(response).to eq ("redditredditreddi")
		end
	end
end

describe "Dictionary" do
  file =  "/usr/share/dict/words"
  before(:all) { @words = Dictionary.new(file) }
  subject { @words }

  it { should respond_to :all_words }
  it { should respond_to :words_by_size }

  describe "#all_words" do
    subject { @words.all_words }
    it { should be_a Array }
    its(:count) { should eq(71670) }
  end

  describe "#words_by_size" do
    subject { @words.words_by_size(3,25) }
    it { should be_a Array }
    its(:count) { should eq(71621) }
  end
end
