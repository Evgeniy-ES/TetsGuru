users = User.create(
  [{first_name: 'Name1', last_name: 'Surnsme1'},
   {first_name: 'Name2', last_name: 'Surname2'},
   {first_name: 'Name3', last_name: 'Surname3'}])

categories = Category.create([{title: 'Cat1'}, {title: 'Cat2'}, {title: 'Cat3'}])

tests = Test.create(
  [{title: 'Test1', level: 1, category_id: categories[0].id},
   {title: 'Test2', level: 2, category_id: categories[1].id},
   {title: 'Test3', level: 3, category_id: categories[2].id},
   {title: 'Test4', level: 1, category_id: categories[0].id},
   {title: 'Test5', level: 2, category_id: categories[1].id}]
)

questions = Question.create(
  [{body: 'Question1', test_id: tests[0].id},
   {body: 'Question2', test_id: tests[1].id},
   {body: 'Question3', test_id: tests[2].id},
   {body: 'Question4', test_id: tests[3].id},
   {body: 'Question5', test_id: tests[4].id},
   {body: 'Question6', test_id: tests[0].id},
   {body: 'Question7', test_id: tests[1].id}]
)

Answer.create(
  [{text: 'Try answer: answer0', question_id: questions[0].id},
   {text: 'Try answer: answer1', question_id: questions[1].id},
   {text: 'Try answer: answer2', question_id: questions[2].id},
   {text: 'Try answer: answer3', question_id: questions[3].id},
   {text: 'Try answer: answer4', question_id: questions[4].id}])

  # UsersTest.create([
  #  {user_id: users[0].id, test_id: tests[0].id},
  #  {user_id: users[0].id, test_id: tests[1].id},
  #  {user_id: users[1].id, test_id: tests[3].id},
  #  {user_id: users[2].id, test_id: tests[2].id},
  #  {user_id: users[2].id, test_id: tests[4].id}
  #  ])
