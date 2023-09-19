require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
    @ps4 = products(:ps4)
    @driver2= products(:driver2)
  end

  test "should return my favorites" do
    get favorites_url

    assert_response :success
  end

  test "should create favorite" do
    assert_difference('Favorite.count', 1)do
      post favorites_url(product_id: @ps4.id)
    end

    assert_redirected_to product_path(@ps4)
  end

  test "should unfavorite" do
    assert_difference('Favorite.count', -1) do
      delete favorite_url(@driver2.id)
    end

    assert_redirected_to product_path(@driver2)
  end
end