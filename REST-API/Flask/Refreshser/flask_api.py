from flask import Flask, request
from flask_restful import Api, Resource, reqparse, abort, fields, marshal_with
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
api = Api(app) # Wrapping the app in API (Initializing RESTful API)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'
db = SQLAlchemy(app)

class videoModel(db.Model):
	id = db.Column(db.Integer, primary_key = True)
	name = db.Column(db.String(100), nullable = False)
	views = db.Column(db.Integer, nullable = False)
	likes = db.Column(db.Integer, nullable = False)
	
	def __repr__(self):
		return f"Video Name = {name}, views = {views}, likes = {likes}"

# db.create_all() # Run only the first time to create the database 

video_put_args = reqparse.RequestParser()
video_put_args.add_argument("name",type = str, help = "Name of the video is required", required = True)
video_put_args.add_argument("views",type = int, help = "Number of views on the video",required = True)
video_put_args.add_argument("likes",type = int, help = "Number of likes on the video")

video_update_args = reqparse.RequestParser()
video_update_args.add_argument("name",type = str, help = "Name of the video is required")
video_update_args.add_argument("views",type = int, help = "Number of views on the video")
video_update_args.add_argument("likes",type = int, help = "Number of likes on the video")


# class HelloWorld(Resource): # Inhereting from Resource
	# def get(self): # Overwriting get method
		# return {"data" : "Hello World"}

# api.add_resource(HelloWorld,"/helloworld") # Adding resource to the API
# /helloworld : Denotes through which endpoint the resource can be accessed

# api.add_resource(HelloWorld,"/helloworld/<string:name>/<int:test>")
# <> : Used to pass parameters 
# <datatype:name_of_parameter>

# videos = {}

# def abort_nonexistant_video_id(video_id):
# 	if video_id in videos:
# 		abort(404,message = "video_id is not Valid !")

# def abort_if_video_id_exists(video_id):
# 	if video_id in videos:
# 		abort(409,message = "video_id already exists !")

# class Video(Resource):
# 	def get(self,video_id):
# 		abort_nonexistant_video_id(video_id)
# 		return videos[video_id]

# 	def put(self,video_id):
# 		args = video_put_args.parse_args()
# 		videos[video_id] = args 
# 		return videos[video_id]
# 		# print(request.method) # Tells which method is being used
# 		# print(request.form) # Used to get information on the data/payload that was sent through the request
# 		# return {video_id : args}

# 	def delete(self,video_id):
# 		abort_if_video_id_exists(video_id)
# 		del videos[video_id]
# 		return "", 204

# api.add_resource(Video, "/video/<int:video_id>")

resource_fields = {
	'id' : fields.Integer,
	'name' : field.String,
	'views' : fields.Integer,
	'likes' : fields.Integer
}

class Video(Resource):
	@marshal_with(resource_fields)
	def get(self,video_id):
		result = VideoModel.query.filter_by(id = video_id).first()
		if not result:
			abort(404, message = f"Could not message with {video_id}")
		return result   # Serializing the input from instance of the class to JSON object

	@marshal_with(resource_fields)
	def put(self,video_id):
		args = video_put_args.parse_args()
		result = VideoModel.query.filter_by(id = video_id).first()
		if result :
			abort(409, message = "video_id already exists !")
		video = VideoModel(id = video_id, name = args['name'], views = args['views'], likes = args['likes'])
		db.session.add(video)
		db.sesssion.commit()
		return video,201

	def delete(self,video_id):
		abort_if_video_id_exists(video_id)
		del videos[video_id]
		return "", 204

	def patch(self):
		args = video_update_args.parse_args()
		result = VideoModel.query.filter_by(id = video_id).first()

		if not result:
			abort(404, message = f"Video with {video_id} doesn't exist, cannot update !")

		if args['name']:
			result.name = args['name']
		if args['views']:
			result.name = args['views']
		if args['views']:
			result.likes = args['likes']

		# db.session.add(result)
		db.session.commit()

		return result

if __name__ == "__main__":
	app.run(debug = True) # debug = True (For logging, debugging used in testing environment)
