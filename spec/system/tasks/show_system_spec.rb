require 'rails_helper'

RSpec.describe 'tasks#show', type: :system do

  let(:task) { create(:task, description: 'test') }

  it '詳細ページの各項目が表示されている' do
    # タスク新規作成ページを開く
    visit task_path(task)

    # 適切なタイトルが表示されている
    expect(find('h1').text).to eq 'タスクの詳細'
    # 行の項目名と順番が全て正しい
    expect(all('th').map(&:text)).to match filtered_attr_names(task).keys
    # 行の値が全て正しい
    expect(all('td').map(&:text)).to match filtered_attr_names(task).values
  end

  it '一覧をクリックすると一覧画面に遷移する' do
    visit task_path(task)

    # 一覧のリンクをクリック
    find('.nav-link').click

    # タスク一覧へ遷移している
    expect(page.current_path).to eq tasks_path
  end
end
