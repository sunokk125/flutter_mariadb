class QueryMutation {
  static String fetchPost(corpId) {
    return """ 
    query{ 
      getPostsList(Company:$corpId){
        No
        Title
        Writer
        Counter
        CreatedDate
      }
    }
    """;
  }

  static String loginUser(String userId, String password) {
    return """
    mutation{
      login(
      userId: "$userId"
      password: "$password"
      ){
        token
        user{
          No
          UserId
          Company
        }
      }
    }
    """;
  }

  static String deleteUser(String userId) {
    return """
    mutation{
      deleteUser(
        userId: "$userId"
      ){
        resultCount
      }
    }
    """;
  }

  static String createUser(String userId, String userPW, String userName,
      String userEmail, String userMobile, String corpId) {
    return """
    mutation{
      createUser(
        Company:$corpId
        UserId: "$userId"
        UserPW: "$userPW"
        UserName: "$userName"
        UserEmail: "$userEmail"
        UserMobile: "$userMobile"
      ){
        resultCount
      }
    }
    """;
  }

  static String updateUser(String no, String userId, String userPW,
      String userName, String userEmail, String userMobile, String corpId) {
    return """
    mutation{
      updateUser(
        No:$no
        Company:$corpId
        UserId: "$userId"
        UserPW: "$userPW"
        UserName: "$userName"
        UserEmail: "$userEmail"
        UserMobile: "$userMobile"
      ){
        resultCount
      }
    }
    """;
  }

  static String createPost(String title, String contents, String writer) {
    return """
    mutation{
      createPost(
        Title: "$title"
        Contents: "$contents"
        Writer: $writer
      ){
        resultCount
      }
    }
    """;
  }

  static String readPost(String postId) {
    return """
    query{
      readPost(
        No:$postId
      ){
        No
        Title
        Writer
        Contents
      }
    }
    """;
  }

  static String updatePost(String postId, String title, String contents) {
    return """
    mutation{
      updatePost(
        No:$postId
        Title:"$title"
        Contents:"$contents"
      ){
        resultCount
      }
    }
    """;
  }

  static String deletePost(String postId) {
    return """
    mutation{
      deletePost(
        No:$postId
      ){
        resultCount
      }
    }
    """;
  }

  static String createComent(String postId, String contents, String writer) {
    print(postId);
    print(contents);
    print(writer);
    return """ 
    mutation{ 
      createComent(
        Contents:"$contents"
        Writer:$writer
        ParentPost: $postId
      ){
        resultCount
      }
    }
    """;
  }

  static String getComents(String postId) {
    return """ 
    query{ 
      getComents(No: $postId)
      {
        Writer
        Contents
      }
    }
    """;
  }
}
