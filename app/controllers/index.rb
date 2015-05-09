get '/' do

  erb :index
end

get '/users/new' do
  erb :user_new
  # use single quotes inside the double quotes to override white space delimeter
end

post '/users' do
  user = User.new(email: params[:email])
  user.password = params[:password]

  if user.save
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
    redirect '/homepage'
  end
end

get '/survey/:id' do
  @survey = Survey.where(id: params[:id]).first
  erb :survey
end

# get '/question/new' do
#   erb :question
# end

# post '/question' do
#   question = Question.new(
#       content: params[:content]
#     )
# end























