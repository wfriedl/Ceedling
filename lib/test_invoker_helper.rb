require 'rubygems'
require 'rake' # for ext()


class TestInvokerHelper

  constructor :configurator, :task_invoker, :dependinator, :file_path_utils, :file_finder, :file_wrapper

  def clean_results(options, fail_results_list, pass_results_list)
    @file_wrapper.rm_f(fail_results_list)
    @file_wrapper.rm_f(pass_results_list) if (options[:force_run])
  end

  def process_auxiliary_dependencies(test_list, *more_lists)
    if (@configurator.project_use_auxiliary_dependencies)
      source_list = @file_finder.find_sources_from_tests(test_list)

      ([test_list, source_list] + more_lists).each do |file_list|
        dependencies_list = @file_path_utils.form_dependencies_filelist(file_list)
        @task_invoker.invoke_dependencies_files(dependencies_list)
        @dependinator.setup_object_dependencies(dependencies_list)
      end
    end
  end
  
end