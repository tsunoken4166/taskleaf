require 'rails_helper'

RSpec.describe 'tasks#edit', type: :system do

  let(:task) { create(:task, description: 'test') }

  it '編集ページの各項目が正しく表示されている' do
    # タスク編集ページを開く
    visit edit_task_path(task)

    # 適切なタイトルが表示されている
    expect(find('h1').text).to eq 'タスクの編集'
    # 名称フィールドが表示されている
    expect(page).to have_field '名称', with: 'コード改修'
    # 詳しい説明フィールドが表示されている
    expect(page).to have_field '詳しい説明', with: 'test'
    # 更新ボタンが表示されている
    expect(find('.btn-primary').value).to eq '更新する'
  end

  it 'タスクを更新することができる' do
    # タスク編集ページを開く
    visit edit_task_path(task)

    fill_in '名称', with: 'hugahuga'
    fill_in '詳しい説明', with: 'hogehoge'
    find('.btn-primary').click

    # タスクの更新が成功し、一覧画面に遷移している
    expect(page).to have_content('タスク「hugahuga」を更新しました')
    expect(page.current_path).to eq tasks_path

    # タスクの名称と詳しい説明の値が更新されている
    expect(task.reload.name).to eq 'hugahuga'
    expect(task.reload.description).to eq 'hogehoge'
  end
end
