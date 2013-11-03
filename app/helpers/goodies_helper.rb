module GoodiesHelper
  def goodie_image(g)
    if g.image_url && !g.image_url.blank?
      g.image_url
    else
      asset_path 'NoImageAvailable.png'
    end
  end

  def goodie_price(g)
    number_to_currency g.price
  end

  def format_price(p)
    number_with_precision(p, precision: 2)
  end
end
