require 'rails_helper'

RSpec.describe 'tasks#new', type: :system do

  it '新規作成ページの各項目が正しく表示されている' do
    # タスク新規作成ページを開く
    visit new_task_path

    # タイトルが表示されている
    expect(find('h1').text).to eq 'タスクの新規登録'
    # 名称フィールドが表示されている
    expect(page).to have_field '名称', with: ''
    # 詳しい説明フィールドが表示されている
    expect(page).to have_field '詳しい説明', with: ''
    # 登録するボタンが表示されている
    expect(find('.btn-primary').value).to eq '登録する'
  end

  it '一覧をクリックすると一覧画面に遷移する' do
    visit new_task_path

    # 一覧のリンクをクリック
    find('.nav-link').click

    # タスク一覧へ遷移している
    expect(page.current_path).to eq tasks_path
  end

  it '新規タスクを登録する' do
    visit new_task_path

    fill_in '名称', with: 'Javascriptコード改修'
    fill_in '詳しい説明', with: ''
    find('.btn-primary').click

    # タスクの登録が成功し、一覧画面に遷移している
    expect(page).to have_content('タスク「Javascriptコード改修」を登録しました')
    expect(page.current_path).to eq task_path(Task.last)
  end

  it '名称が空白の場合、バリデーションがかかる' do
    visit new_task_path
    
    fill_in '名称', with: ''
    fill_in '詳しい説明', with: ''
    find('.btn-primary').click

    # バリデーションがかかりメッセージが表示されている
    expect(find('#task_name').find(:xpath, '..').text).to have_content('* 必須項目です')
    # 一覧画面に遷移していない
    expect(page.current_path).to eq new_task_path
  end
end