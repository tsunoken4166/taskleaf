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

    subject { get edit_task_path(task.id) }

    let(:task) { create(:task) }

    # リクエストが成功すること
    it { is_expected.to eq 200 }
  end

  describe 'PUT #update' do

    subject { put task_path(task), params: task_params }

    let(:task) { create(:task) }

    let(:task_params) { { task: { name: 'hugahuga', description: 'testtesttest' } } }

    # リクエストが成功すること
    it { is_expected.to eq 302 }

    # タスク名が更新されること
    it do
      subject
      expect(task.reload.name).to eq 'hugahuga'
    end

    # 詳しい説明が更新されること
    it do
      subject
      expect(task.reload.description).to eq 'testtesttest'
    end

    # リダイレクトすること
    it { expect(res).to redirect_to tasks_path }
  end
end
