Dir[Rails.root.join('db/seeds/*.rb').to_s].each do |seed|
  Rails.logger.debug { "Ejecutando #{File.basename(seed)}..." }
  load seed
end
