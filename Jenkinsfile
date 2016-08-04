node('internal') {
    slackSend color: '#439FE0', message: "Build Started: ${env.JOB_NAME}\n${env.BUILD_URL}"

    stage 'checkout'
    checkout changelog: true, poll: true, scm: [$class: 'GitSCM', branches: [[name: "origin/${env.gitlabSourceBranch}"]], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'PreBuildMerge', options: [fastForwardMode: 'FF', mergeRemote: 'origin', mergeStrategy: 'default', mergeTarget: "${env.gitlabTargetBranch}"]]], submoduleCfg: [], userRemoteConfigs: [[name: 'origin', url: 'https://gitlab.zespre.net/starbops/openstack-ansible-noc.git']]]

    stage 'configure'
    sh 'ansible-galaxy install -r requirements.yml -p roles'

    try {
        gitlabCommitStatus {
            stage 'build'
            sh 'vagrant up --provider libvirt'

            stage 'qa'
            slackSend color: '#439FE0', message: "Check it out!\nAccess dashboard => http://controller/horizon\nAccess console => http://essos.zespre.net:6080/vnc.html?host=essos.zespre.net&port=6080"
            input "Check it out!\nAccess dashboard => http://controller/horizon\nAccess console => http://essos.zespre.net:6080/vnc.html?host=essos.zespre.net&port=6080"
        }
    } catch (err) {
        echo "Caught: ${err}"
        currentBuild.result = 'FAILURE'
    } finally {
        stage 'cleanup'
        sh 'vagrant destroy -f'
        slackSend color: '#439FE0', message: "Build Ended: ${env.JOB_NAME}\nResult: ${currentBuild.result}\n${env.BUILD_URL}"
    }
}
