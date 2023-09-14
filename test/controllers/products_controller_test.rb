require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path

    assert_response :success
    assert_select '.product',2
  end

  test 'render a detailed product page'do
    get product_path(products(:ssd))

    assert_response :success
    assert_select '.title', 'SSD 480GB'
    assert_select '.description', 'SSD 480GB SATAIII'
    assert_select '.price', '20'
  end

  test 'render a form' do
    get new_product_path

    assert_response :success
    assert_select 'form'
  end

  test 'no permitir campos vacios' do

    post products_path, params: {
      product: {
        title: '',
        description: 'casi nueva',
        price:150

      }
    }
    assert_response :unprocessable_entity
  end
end