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

    subject{ post tasks_path, params: task_params }

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
end
