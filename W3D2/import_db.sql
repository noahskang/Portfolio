DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  subj_question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT,

  FOREIGN KEY (subj_question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  user_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Noah', 'Kang'),
  ('Greg', 'Park'),
  ('Kelly', 'Chung');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('question1', 'hello world', (SELECT id FROM users WHERE fname = 'Greg')),
  ('question2', 'where are you kelly?', (SELECT id FROM users WHERE fname = 'Noah'));

INSERT INTO
  replies (subj_question_id, parent_reply_id, user_id, body)
VALUES
  ((1, NULL, (SELECT id FROM users WHERE fname = 'Greg'), 'Hello, Greg'),
  ((SELECT id FROM questions WHERE title = 'question2'), 1, (SELECT id FROM users WHERE fname = 'Noah'), "I'm right behind you");

INSERT INTO
  question_likes (question_like, question_id, user_id)
VALUES
  ('TRUE', (SELECT id FROM questions WHERE title = 'question1'), (SELECT id FROM users WHERE fname = 'Greg'));
