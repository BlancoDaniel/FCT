require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  test 'render a list of products' do
    get products_path

    assert_response :success
    assert_select '.product', 12
    assert_select '.category', 10
  end

  test 'render a list of products filtered by category' do
    get products_path(category_id: categories(:cars).id)

    assert_response :success
    assert_select '.product', 2
  end

  test 'render a list of products filtered by price' do
    get products_path(min_price: 400,max_price:2000)

    assert_response :success
    assert_select '.product', 4
  end

  test 'render a list of products filtered by text' do
    get products_path(query_text: 'Nintendo')

    assert_response :success
    assert_select '.product', 2
  end


  test 'render a detailed product page' do
    get product_path(products(:pixel))

    assert_response :success
    assert_select '.title', 'Google Pixel 4'
    assert_select '.description', 'Le falla la batería'
    assert_select '.price', '100'


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
        category_id: categories(:videogames).id
      }
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Tu producto se ha creado correctamente'

  end

  test 'render a edit form' do
    get edit_product_path(products(:tv))

    assert_response :success
    assert_select 'form'
  end

  test 'can delete products' do ||

    assert_difference('Product.count', -1)do
    delete product_path(products(:tv))
    end

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Tu producto se ha eliminado correctamente'

  end


end