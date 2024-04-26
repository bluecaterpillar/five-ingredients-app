require 'rake'

class TaskController < ApplicationController  
    def run_rake_task
        Rake::Task.clear
        FiveIngredientsApp::Application.load_tasks
        Rake::Task['db:import_recipes'].invoke
        
        redirect_to home_path, notice: "Database seed executed successfully!"
    end
end
