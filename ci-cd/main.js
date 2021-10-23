const { default: axios } = require('axios')

const portainerUrl = process.env.PORTAINER_URL
const portainerUser = process.env.PORTAINER_USER
const portainerPassword = process.env.PORTAINER_PASSWORD
const stackName = process.env.STACK_NAME
const branch = process.env.GIT_BRANCH || `main`
const githubUser = process.env.REPO_USER
const githubPassword = process.env.REPO_PASSWORD
const stackFile = process.env.STACK_FILE
const swarmID = process.env.SWARM_ID
const githubUrl = process.env.GITHUB_SERVER_URL
const githubRepo = process.env.GITHUB_REPOSITORY

async function deployStack() {
  const requieredEnv = [portainerUrl, portainerUser, portainerPassword, stackName, githubUser, githubPassword, stackFile, swarmID]
  if (requieredEnv.some(item => !item)) throw new Error(`Missing required envs`)
  const { data: { jwt } } = await axios.post(`${portainerUrl}/api/auth`, { Username: portainerUser, Password: portainerPassword })
  const headers = { authorization: `Bearer ${jwt}` }
  const { data } = await axios.get(`${portainerUrl}/api/stacks`, { headers })
  const stack = data.find(item => item.Name === stackName)
  const envs = Object.keys(process.env).filter(item => item.match(/^STACK_ENV_/i)).map(item => ({ name: item.replace(/^STACK_ENV_/i, ''), value: process.env[item] }))
  if (stack) {
    await axios.put(`${portainerUrl}/api/stacks/${stack.Id}/git/redeploy?endpointId=2`, {
      'env': envs,
      'repositoryReferenceName': `refs/heads/${branch}`,
      'repositoryAuthentication': true,
      'repositoryUsername': githubUser,
      'repositoryPassword': githubPassword
    }, { headers })
  } else {
    await axios.post(`${portainerUrl}/api/stacks?endpointId=2&method=repository&type=1`, {
      "Name": stackName,
      "SwarmID": swarmID,
      "RepositoryURL": `${githubUrl}/${githubRepo}`,
      "RepositoryReferenceName": `refs/heads/${branch}`,
      "ComposeFile": stackFile,
      "RepositoryAuthentication": true,
      "RepositoryUsername": githubUser,
      "RepositoryPassword": githubPassword,
      "Env": envs,
    }, { headers })
  }
}

deployStack().then(() => console.log('Success')).catch(e => { console.log(e); process.exit(1) })