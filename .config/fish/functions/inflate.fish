# Defined in - @ line 1
function inflate --description 'inflates deflated things'
	elixir -e 'compressed = IO.read(:stdio, :all); z = :zlib.open(); :zlib.inflateInit(z); uncompressed = :zlib.inflate(z, compressed); :zlib.close(z); IO.binwrite(uncompressed)'
end
