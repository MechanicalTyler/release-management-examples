from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy

# import models
from config import Config

db = SQLAlchemy()

app = Flask(__name__)
app.config.from_object('config.Config')

db.init_app(app)

### Models ###
class Users(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    given_name = db.Column(db.String(80), nullable=False)
    first_name = db.Column(db.String(80), nullable=False)
    last_name = db.Column(db.String(80), nullable=False)

class Posts(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(120), nullable=False)
    content = db.Column(db.Text, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)

with app.app_context():
    db.create_all()

### Migrations ###

with app.app_context():
    from flask_migrate import Migrate
    migrate = Migrate(app, db)

### Routes ###
@app.route('/api', methods=['GET'])
def api_index():
    return jsonify({"message": "Welcome to the API!"})

@app.route('/api/users', methods=['GET'])
def api_list_users():
    users = Users.query.all()
    return jsonify({"users": [{"id": user.id, "username": user.username, "given_name": f"{user.first_name} {user.last_name}"} for user in users]})

@app.route('/api/users', methods=['POST'])
def api_create_user():
    json_data = request.json

    user = Users(username=json_data['username'], given_name=json_data['given_name'], first_name=json_data['given_name'].split()[0], last_name=json_data['given_name'].split()[1])
    db.session.add(user)
    db.session.commit()

    return jsonify({"user": {"id": user.id, "username": user.username, "given_name": f"{user.first_name} {user.last_name}"}})

@app.route('/api/users/<user_id>', methods=['GET'])
def api_get_user(user_id):
    user = Users.query.filter_by(id=user_id).first()
    return jsonify({"user": {"id": user.id, "username": user.username, "given_name": f"{user.first_name} {user.last_name}"}})

### main ###

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=Config.SERVER_PORT)
