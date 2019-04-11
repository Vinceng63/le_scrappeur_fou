require_relative '../lib/dark_trader'


describe "the dark_trader function" do
  it "should return client, and client is not nil" do
    expect(dark_trader).not_to be_nil
  end
end