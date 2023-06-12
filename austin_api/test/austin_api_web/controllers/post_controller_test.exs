defmodule AustinApiWeb.PostControllerTest do
  use AustinApiWeb.ConnCase

  import AustinApi.PostsFixtures

  alias AustinApi.Posts.Post

  @create_attrs %{
    content: "some content",
    published_at: ~D[2023-06-10],
    subtitle: "some subtitle",
    title: "some title"
  }
  @update_attrs %{
    content: "some updated content",
    published_at: ~D[2023-06-11],
    subtitle: "some updated subtitle",
    title: "some updated title"
  }
  @invalid_attrs %{content: nil, published_at: nil, subtitle: nil, title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get(conn, ~p"/api/posts")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create post" do
    test "renders post when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/posts", post: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/posts/#{id}")

      assert %{
               "id" => ^id,
               "content" => "some content",
               "published_at" => "2023-06-10",
               "subtitle" => "some subtitle",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/posts", post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update post" do
    setup [:create_post]

    test "renders post when data is valid", %{conn: conn, post: %Post{id: id} = post} do
      conn = put(conn, ~p"/api/posts/#{post}", post: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/posts/#{id}")

      assert %{
               "id" => ^id,
               "content" => "some updated content",
               "published_at" => "2023-06-11",
               "subtitle" => "some updated subtitle",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put(conn, ~p"/api/posts/#{post}", post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, ~p"/api/posts/#{post}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/posts/#{post}")
      end
    end
  end

  defp create_post(_) do
    post = post_fixture()
    %{post: post}
  end
end
