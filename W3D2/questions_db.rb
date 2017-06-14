require 'sqlite3'
require 'singleton'

class QuestionsDataBase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Question
  attr_accessor :id, :title, :body, :author_id

  def self.find_by_id(id)
    question = QuestionsDataBase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL

    return nil unless question.length > 0

    Question.new(question.first)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def self.find_by_author_id(author_id)
    author = User.find_by_id(author_id)
    raise "#{author_id} not found in DB" unless author

    question_author = QuestionsDataBase.instance.execute(<<-SQL, author.id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    question_author.map{|auth| Question.new(auth)}
  end

  def author
    User.find_by_id(@author_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def save
    raise "#{self} already in database" if @id
    QuestionsDataBase.instance.execute(<<-SQL, @title, @body, @author_id)
      INSERT INTO
        questions (title, body, author_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = QuestionsDataBase.instance_last_insert_row_id
  end
end

class User
  attr_accessor :id, :fname, :lname

  def self.find_by_id(id)
    users = QuestionsDataBase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    return nil unless users.length > 0

    User.new(users.first)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_name(fname, lname)
    results = QuestionsDataBase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    return nil unless results.length > 0

    User.new(results.first)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    avg_karma = QuestionsDataBase.instance.execute(<<-SQL, @id)
      SELECT
        CAST(COUNT(question_likes.user_id) AS FLOAT) / COUNT(DISTINCT(question_id))
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      WHERE
        questions.author_id = ?
      GROUP BY
        questions.id
    SQL
  end

  def save
    raise "#{self} already in database" if @id
    QuestionsDataBase.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?)
    SQL
    @id = QuestionsDataBase.instance.last_insert_row_id
  end

end

class Reply
  attr_accessor :id, :body

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@subj_question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_reply_id)
  end

  def child_replies
    children = QuestionsDataBase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = ?
    SQL

    return nil unless children.length > 0

    children.map{|child| Reply.new(child)}
  end

  def self.find_by_id(id)
    replies = QuestionsDataBase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    return nil unless replies.length > 0

    Reply.new(replies.first)
  end

  def initialize(options)
    @id = options['id']
    @body = options['body']
  end

  def self.find_by_user_id(user_id)
    user = User.find_by_id(user_id)
    raise "#{user_id} not found in DB" unless user

    reply_user = QuestionsDataBase.instance.execute(<<-SQL, user.id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    reply_user.map{|user| Reply.new(user)}
  end

  def self.find_by_question_id(question_id)
    question = Question.find_by_id(question_id)
    raise "#{question_id} not found in DB" unless question

    results = QuestionsDataBase.instance.execute(<<-SQL, question.id)
      SELECT
        *
      FROM
        replies
      WHERE
        subj_question_id = ?
    SQL

    results.map{|result| Reply.new(result)}
  end

  def save
    if @id
      QuestionsDataBase.instance.execute(<<-SQL, @subj_question_id, @parent_reply_id, @user_id, @body, @id)
        UPDATE
          users
        VALUES
          (?, ?, ?, ?)
        WHERE
          id = ?
      SQL
    else
      QuestionsDataBase.instance.execute(<<-SQL, @subj_question_id, @parent_reply_id, @user_id, @body)
        INSERT INTO
          replies (subj_question_id, parent_reply_id, user_id, body)
        VALUES
          (?, ?, ?, ?)
      SQL
      @id = QuestionsDataBase.instance.last_insert_row_id
    end
  end


end

class QuestionFollow
  attr_accessor :question_id, :user_id

  def initialize(question_id, user_id)
    @question_id = question_id
    @user_id = user_id
  end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDataBase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, fname, lname
      FROM
        users
      JOIN
        questions ON users.id = questions.author_id
      WHERE
        questions.id = ?
    SQL

    return nil unless followers.length > 0

    followers.map {|follower| User.new(follower)}
  end

  def self.followed_questions_for_user_id(user_id)
    followed_questions = QuestionsDataBase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, title, questions.body, author_id
      FROM
        questions
      JOIN
        users ON questions.author_id = users.id
      WHERE
        users.id = ?
    SQL

    return nil unless followed_questions.length > 0

    followed_questions.map {|question| Question.new(question)}
  end

  def self.most_followed_questions(n)
    most_followed = QuestionsDataBase.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        questions
      GROUP BY
        id
      ORDER BY
        COUNT(author_id) DESC
      LIMIT n;
    SQL

    return nil unless most_followed.length > 0

    most_followed.map{|question| Question.new(question)}
  end
end

class QuestionLike

  attr_accessor :id, :question_id, :user_id

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.likers_for_question_id(question_id)
    likers = QuestionsDataBase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.user_id
      WHERE
        question_id = ?
    SQL

    return nil if likers.empty?

    likers.map {|liker| User.new(liker)}
  end

  def self.num_likes_for_question_id(question_id)
    num = QuestionsDataBase.instance.execute(<<-SQL, question_id)
    SELECT
      COUNT(*)
    FROM
      question_likes
    WHERE
      question_id = ?
    SQL

    num
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDataBase.instance.execute(<<-SQL, user_id)
    SELECT
      questions.*
    FROM
      question_likes
    JOIN
      questions ON question_likes.question_id = questions.id
    WHERE
      user_id = ?
    SQL

    return nil if questions.empty?

    questions.map {|question| Question.new(question)}
  end

  def self.most_liked_questions(n)
    most_liked = QuestionsDataBase.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        question_likes
      GROUP BY
        id
      ORDER BY
        COUNT(user_id) DESC
      LIMIT n;
    SQL

    return nil unless most_liked.length > 0

    most_liked.map{|question| Question.new(question)}
  end
end
