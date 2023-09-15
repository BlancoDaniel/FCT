require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path

    assert_response :success
    assert_select '.product',3
  end

  test 'render a detailed product page'do
    get product_path(products(:s95c))

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

  test 'allows to create a new product' do

    post products_path, params: {
      product: {
        title: 'ps4',
        description: 'casi nueva',
        price:150,
        category_id: categories(:tv)
      }
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Tu producto se ha creado correctamente'
  end

  test 'render a edit form' do
    get edit_product_path(products(:s95c))

    assert_response :success
    assert_select 'form'
  end

  test 'can delete products' do ||

    assert_difference('Product.count', -1)do
    delete product_path(products(:s95c))
    end

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Tu producto se ha eliminado correctamente'

  end


end