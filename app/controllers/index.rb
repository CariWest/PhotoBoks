
get '/' do
  erb :index
end

get '/surveys/new' do
  erb :create_new_survey
end

post '/surveys' do
  survey = Survey.create(
    title: params[:title],
    user_id: current_user.id,
    )
  redirect "/surveys/#{survey.id}/question_new"
end

# for creating new questions
get '/surveys/:survey_id/question_new' do
  @survey = Survey.find(params[:survey_id])
  erb :create_new_question
end

#display a survey and its questions
get '/surveys/:survey_id' do
  @survey = Survey.find(params[:survey_id])
  erb :survey #need to show the survey - Create survey.erb
end

post '/questions' do
  Question.create(
    content: params[:content],
    survey_id: params[:survey_id],
    )
  redirect "/surveys/#{params[:survey_id]}"
  # redirecting to the survey page but not sure how to get the corresponding survey based on the question
end

post "/signup" do
  @user = User.new(params)
  if @user.save
    session[:user_id] = @user.id
    redirect "/#{@user.user_name}"
  else
    flash[:error] = "Username already taken"
    redirect "/"
  end
end

post "/login" do
  @user = User.find_by(user_name: params[:user_name])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect "/#{@user.user_name}"
  else
    flash[:error] = "User name or password incorrect"
    redirect "/"
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get "/:user_name" do
  @user = User.find_by(user_name: params[:user_name])
  if session[:user_id] == @user.id
    #enables partial that allows you to create surverys
  else
    #lets person see all of that user page's  surevys and take them
  end
end
