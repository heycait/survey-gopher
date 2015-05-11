get '/' do
  erb :index
end

get '/users/new' do
  erb :user_new
end

post '/users' do
  user = User.new(email: params[:email])
  user.password = params[:password]

  if user.save
    login(user)
    redirect '/homepage'
  else
    status 400
    "you fucked up"
  end
end

get '/login/new' do
  erb :login
end

post '/login' do
  user = User.where(email: params[:email]).first
  if user && user.password == params[:password]
    login(user)

    redirect '/homepage'
  else
    status 400
    "You aint down"
  end
end

get '/homepage' do
  @surveys = Survey.where(creator_id: current_user.id)
  erb :homepage
end

delete '/logout' do
  logout!
  redirect '/'
end

get '/survey/new' do
  erb :survey_new
end

post '/survey' do
  survey = Survey.new(
      creator_id: current_user.id,
      title: params[:title],
    )
  if survey.save
    "Survey saved!"
    redirect "/survey/#{survey.id}"
  end
end

get '/survey/:id' do
  @survey = Survey.where(id: params[:id]).first
  @questions = Question.where(survey_id: params[:id])
  erb :survey
end

post '/question' do
  question = Question.new(
      content: params[:content],
      survey_id: params[:survey_id]
    )

  if question.save
    question.to_json
  else
    status 400
    "cannot save such question"
  end
end

get '/question/:id' do
  question = Question.where(id: params[:id]).first
  erb :new_choice
end

post '/choices' do
  choice = Choice.new(
    content: params[:content],
    question_id: params[:question_id]
    )
  if choice.save
    question = choice.question
    survey_id = question.survey.id
    redirect "/survey/#{survey_id}"
  else
    "Boo, not save :("
  end
end

# '/survey/:id/take_survey'
get '/take_survey/:id' do
  @survey = Survey.where(id: params[:id]).first
  erb :take_survey
end

post '/answer' do
  # This doesn't work. We're not sure if we're accessing our information correctly. If we are, we apparently, can't use it correctly to create an answer object

  # params.each do |key, value|
  #   Answer.create!(
  #     user_id: current_user.id,
  #     question_id: key.to_i,
  #     choice_id: value.to_i,
  #   )
  # end
end
















