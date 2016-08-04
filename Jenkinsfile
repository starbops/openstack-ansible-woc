node('internal') {
    def color_code = '#439FE0'

    slackSend color: color_code, message: "Build Started: ${env.JOB_NAME}\n${env.BUILD_URL}"

    stage 'checkout'
    checkout changelog: true, poll: true, scm: [$class: 'GitSCM', branches: [[name: "origin/${env.gitlabSourceBranch}"]], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'PreBuildMerge', options: [fastForwardMode: 'FF', mergeRemote: 'origin', mergeStrategy: 'default', mergeTarget: "${env.gitlabTargetBranch}"]]], submoduleCfg: [], userRemoteConfigs: [[name: 'origin', url: 'https://gitlab.zespre.net/starbops/openstack-ansible-woc.git']]]

    stage 'configure'
    sh 'ansible-galaxy install -r requirements.yml -p roles'

    try {
        gitlabCommitStatus {
            stage 'build'
            sh 'vagrant up --provider libvirt'

            stage 'qa'
            slackSend color: color_code, message: "Build passed!\nAccess dashboard => http://controller/horizon\nAccess console => http://essos.zespre.net:6080/vnc.html?host=essos.zespre.net&port=6080"
            input "Build passed. Check it out!"
        }
    } catch (err) {
        echo "Caught: ${err}"
        currentBuild.result = 'FAILURE'
        color_code = '#439FE0'
        slackSend color: color_code, message: "Build failed!\nAccess dashboard => http://controller/horizon\nAccess console => http://essos.zespre.net:6080/vnc.html?host=essos.zespre.net&port=6080"
        input "Build failed. Check it out!"
    } finally {
        stage 'cleanup'
        sh 'vagrant destroy -f'
        color_code = currentBuild.result == 'FAILURE'? '#EA0000' : '#12B439'
        slackSend color: color_code, message: "Build Ended: ${env.JOB_NAME}\n${env.BUILD_URL}"
    }
}
