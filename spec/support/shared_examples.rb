# frozen_string_literal: true

shared_examples 'Can Not Access If Not Login' do
  it 'redirect root page' do
    sign_out user if user.present?

    subject
    expect(response).to redirect_to user_session_path
  end
end
