from flask import Flask
from flask import request
import subprocess


app = Flask('chaincreator')

@app.route('/createchain')
def createchain():
  chainname = request.args.get('chainname')
  networkport = request.args.get('networkport')
  rpcport = request.args.get('rpcport')
  chain_command = "multichain-util create {0}".format(
    chainname)
  daemon_command = "multichaind {0} -daemon -data-dir=~/.multichain/{0} -networkport={1} -rpcport={2}".format(
    chainname, networkport, rpcport)
  try:
    chain_success = subprocess.check_output(
        [chain_command], shell=True)
    daemon_success = subprocess.check_output(
        [daemon_command], shell=True)
  except subprocess.CalledProcessError as e:
    return "An error occurred while trying to fetch task status updates."
  return "Chain created: %s\nChain started: %s" % (chain_success, daemon_success)

@app.route('/')
def hello_world():
    return 'Flask Dockerized'

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')