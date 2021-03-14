
require 'rails_helper'

RSpec.describe 'tasks#index', type: :system do
  it '一覧ページの各項目が正しく表示されている' do
    # タスク新規作成ページを開く
    visit tasks_path

    # 適切なタイトルが表示されている
    expect(find('h1').text).to eq 'タスク一覧'
    # 新規登録ボタンが表示されている
    expect(find('#new').text).to eq '新規登録'
    # テーブルヘッダー1つ目の項目が名称である
    expect(all('th').map(&:text).first).to eq '名称'
    # テーブルヘッダー1つ目の項目が登録日時である
    expect(all('th').map(&:text).second).to eq '登録日時'
  end

  context 'タスクが登録されている場合' do

    let!(:task) { create(:task) }
    
    it '登録されたタスクが一覧に表示されている' do
      
      visit tasks_path

      # 登録されたタスクの名称が正しい
      expect(all('td').map(&:text).first).to eq task.name
      # 登録されたタスクの登録日時が正しい
      expect(all('td').map(&:text).second).to eq I18n.l(task.created_at)
      # 登録されたタスクの行右端に編集ページへのリンクテキストが表示されている
      expect(find('#edit').text).to eq '編集'
      # 登録されたタスクの行右端に削除のリンクテキストが表示されている
      expect(find('.btn-danger').text).to eq '削除'
    end
  end

  context 'タスクが複数登録されている場合' do

    let!(:task) { create_list(:task, 3) }

    it '登録したタスク数と一覧に表示されているタスク数が一致している' do
      visit tasks_path

      expect(all('tbody tr').count).to eq Task.all.count
    end
  end
end