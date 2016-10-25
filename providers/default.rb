def whyrun_supported?
  true
end

def load_current_resource
  @current_resource = Chef::Resource::Sed.new(new_resource.name)
  @current_resource.file(new_resource.file)
  @current_resource.search(new_resource.search)
  @current_resource.replace(new_resource.replace)
  @current_resource.insensitive(new_resource.insensitive)
end

action :update do
  fileName = new_resource.file
  searchString = new_resource.search
  replaceString = new_resource.replace
  insensitive = new_resource.insensitive

  fileContentsOld = open_file(fileName) 
  fileContentsNew = substitute(insensitive, fileContentsOld, searchString, replaceString)
  writeFile(fileName, fileContentsNew)

end

def open_file(fileName)
  file = ::File.open(fileName, "r")
  fileContents = file.read
  file.close
  return fileContents
end

def substitute(insensitive, fileContents, searchString, replaceString)
  if insensitive 
    notify = fileContents.gsub!(/#{searchString}/i, replaceString)
  else
    notify = fileContents.gsub!(/#{searchString}/, replaceString)
  end
  
  if notify != nil
    new_resource.updated_by_last_action(true)
  else
    new_resource.updated_by_last_action(false)
  end
  
  return fileContents
end

def writeFile(fileName, fileContents)
  ::File.open(fileName, "w") { |data| data << fileContents }
end
