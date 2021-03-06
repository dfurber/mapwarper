class Wms::LayerController < Wms::BaseController

  def generate_wms
    @layer = Layer.find(params[:id])

    map.setMetaData("wms_onlineresource",
      "http://" + request.host_with_port + "/layers/#{@layer.id}/wms")

    raster.tileindex = @layer.tileindex_path
    raster.tileitem = "Location"

    raster.status = Mapscript::MS_ON
    raster.dump = Mapscript::MS_TRUE

    raster.metadata.set('wcs_formats', 'GEOTIFF')
    raster.metadata.set('wms_title', @layer.name)
    raster.metadata.set('wms_srs', 'EPSG:4326 EPSG:3857 EPSG:4269 EPSG:900913')
    raster.debug = Mapscript::MS_TRUE
    send_map_data(map, ows)
  # rescue RuntimeError => e
  #   [nil, nil]
  end


end
