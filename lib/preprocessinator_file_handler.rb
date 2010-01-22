

class PreprocessinatorFileHandler
  
  constructor :preprocessinator_file_handler_helper, :configurator, :tool_executor, :file_path_utils, :file_wrapper

  
  def preprocess_file(filepath, includes)
    preprocessed_filepath = @file_path_utils.form_preprocessed_file_path(filepath)
        
    command_line = @tool_executor.build_command_line(@configurator.tools_file_preprocessor, filepath, preprocessed_filepath)
    @tool_executor.exec(command_line)
    
    contents = @preprocessinator_file_handler_helper.extract_base_file_from_preprocessed_expansion(preprocessed_filepath)

    includes.each{|include| contents.unshift("#include \"#{include}\"")}

    @file_wrapper.write(preprocessed_filepath, contents.join("\n"))    
  end

end