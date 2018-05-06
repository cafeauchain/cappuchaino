# from flask import Flask
# from flask import request
# import subprocess


# app = Flask('chaincreator')

# @app.route('/createchain/')
# def createchain():
#   chainname = request.args.get('chainname')
#   chain_command = "multichainutil create {0}".format(
#     chainname)
#   try:
#     chain_success = subprocess.check_output(
#         [chain_command], shell=True)
#   except subprocess.CalledProcessError as e:
#     return "An error occurred while trying to fetch task status updates."
#   return "Chain created: %s" % (chain_success)


# # if __name__ == '__main__':
# #     app.run(host='0.0.0.0')

from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Flask Dockerized'

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')