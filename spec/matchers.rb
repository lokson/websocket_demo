shared_examples :ok_page do
  it do
    expect(response.body).to_not include 'exception'
    expect(response.status).to_not eq 500
    expect(response.status).to be_in [200, 302]
  end
end