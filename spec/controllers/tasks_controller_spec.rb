require 'rails_helper'

RSpec.describe TasksController, type: :request do

  let(:res) do
    subject
    response
  end

  describe 'GET #index' do

    subject { get tasks_path }

    # リクエストが成功すること
    it { is_expected.to eq 200 }
  end

  describe 'GET #new' do

    subject { get new_task_path }

    # リクエストが成功すること
    it { is_expected.to eq 200 }
  end

  describe 'POST #create' do

    subject { post tasks_path, params: task_params }

    context 'パラメータが妥当な場合' do

      let(:task_params) { { task: { name: 'Javascriptコード改修', description: 'hogehoge' } } }

      # リクエストが成功すること
      it { is_expected.to eq 302 }

      # タスクが登録されていること
      it { expect{ subject }.to change{ Task.count }.by(1) }

      # リダイレクトすること
      it { expect(res).to redirect_to tasks_path }
    end

    context 'パラメータが不当な場合' do

      let(:task_params) { { task: { name: '', description: 'hogehoge' } } }

      # リクエストが成功すること
      it { is_expected.to eq 200 }

      # タスクが登録されていないこと
      it { expect{ subject }.to_not change{ Task.count } }

      # リダイレクトしていないこと
      it { expect(res).to_not redirect_to tasks_path }
    end
  end

  describe 'GET #show' do

    subject { get task_path(task.id) }

    context 'タスクが存在する場合' do
      
      let(:task) { create(:task) }
      
      # リクエストが成功すること
      it { expect(res.status).to eq 200 }  
    end

    context 'タスクが存在しない場合' do

      subject { -> { get task_path(1) } }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET #edit' do

    let(:task) { create(:task) }

    subject { get edit_task_path(task.id) }

    # リクエストが成功すること
    it { is_expected.to eq 200 }
  end

  describe 'PUT #update' do

    let(:task) { create(:task) }

    let(:task_params) { { task: { name: 'hugahuga', description: 'testtesttest' } } }
    
    subject { put task_path(task), params: task_params }

    # リクエストが成功すること
    it { is_expected.to eq 302 }

    # タスク名が更新されること
    it { expect{ subject }.to change{ task.reload.name }.from('コード改修').to('hugahuga') }

    # 詳しい説明が更新されること
    it { expect{ subject }.to change{ task.reload.description }.from(nil).to('testtesttest') }

    # リダイレクトすること
    it { expect(res).to redirect_to tasks_path }
  end

  describe 'DELETE #destroy' do

    let!(:task) { create(:task) }

    subject { delete task_path(task) }

    # リクエストが成功すること
    it { is_expected.to eq 302 }

    # タスクが削除されていること
    it { expect{ subject }.to change(Task, :count).by(-1) }

    # リダイレクトすること
    it { expect(res).to redirect_to tasks_path }
  end
end
