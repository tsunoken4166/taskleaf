require 'rails_helper'

RSpec.describe 'tasks#destroy', type: :system do

  let!(:task) { create(:task) }

  it '一覧からタスクを削除できる' do
    # タスク一覧ページを開く
    visit tasks_path

    # 削除ボタンをクリック
    find('.btn-danger').click
    # 削除ボタンクリック後のconfirmに適切な文言が表示されている
    expect(page.driver.browser.switch_to.alert.text).to eq "タスク「コード改修」を削除します。よろしいですか？"
    # OKをクリック
    page.driver.browser.switch_to.alert.accept

    # タスクの削除が成功し、一覧画面に遷移している
    expect(page).to have_content('タスク「コード改修」を削除しました')
    expect(page.current_path).to eq tasks_path    
  end

  it '詳細からタスクを削除できる' do
    # タスク一覧ページを開く
    visit task_path(task)

    # 削除ボタンをクリック
    find('.btn-danger').click
    # 削除ボタンクリック後のconfirmに適切な文言が表示されている
    expect(page.driver.browser.switch_to.alert.text).to eq "タスク「コード改修」を削除します。よろしいですか？"
    # OKをクリック
    page.driver.browser.switch_to.alert.accept

    # タスクの削除が成功し、一覧画面に遷移している
    expect(page).to have_content('タスク「コード改修」を削除しました')
    expect(page.current_path).to eq tasks_path    
  end
end