pipeline {
    agent any

parameters {
    string(
        name: 'BASTION_HOST',
        defaultValue: '',
        description: 'Public IP of the bastion host'
    )
    string(
        name: 'TF_STATE_BUCKET',
        defaultValue: '',
        description: 'S3 bucket containing Terraform state'
    )
}

    stages {
        stage('Check Prerequisites') {
            steps {
                sshagent(credentials: ['cassandra-bastion-key']) {
                    sh '''
                        set -e
                        ssh -o BatchMode=yes \
                            -o StrictHostKeyChecking=yes \
                            ubuntu@52.66.103.170 'echo BASTION_OK'

                        ansible-playbook --version
                        test -r /opt/cassandra-one-click/ansible/inventory
                        test -r /opt/cassandra-one-click/ansible/site.yml

                        echo "PREREQUISITES_OK"
                    '''
                }
            }
        }

        stage('Check Cassandra Nodes') {
            steps {
                sshagent(credentials: ['cassandra-bastion-key']) {
                    sh '''
                        set -e
                        cd /opt/cassandra-one-click/ansible
                        ansible cassandra -i inventory -m ping
                    '''
                }
            }
        }

        stage('Verify AWS Credentials') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'aws-terraform-creds',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    )
                ]) {
                    withEnv(['AWS_DEFAULT_REGION=ap-south-1']) {
                        sh '''
                            set -e
                            /usr/local/bin/aws sts get-caller-identity
                            echo "AWS_CREDENTIALS_OK"
                        '''
                    }
                }
            }
        }

        stage('Verify Terraform State') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'aws-terraform-creds',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    )
                ]) {
                    withEnv(['AWS_DEFAULT_REGION=ap-south-1']) {
                        sh '''
                            set -e
                            /usr/local/bin/aws s3api head-object \
                                --bucket cassandra-one-click-786971362087 \
                                --key cassandra-one-click/terraform.tfstate

                            echo "TERRAFORM_STATE_ACCESS_OK"
                        '''
                    }
                }
            }
        }

        stage('Terraform Validate and Plan') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'aws-terraform-creds',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    )
                ]) {
                    withEnv(['AWS_DEFAULT_REGION=ap-south-1']) {
                        sh '''
                            set -e
                            cd /opt/cassandra-one-click/terraform

                            terraform init -input=false
                            terraform validate
                            terraform plan \
                                -input=false \
                                -lock-timeout=60s \
                                -no-color
                        '''
                    }
                }
            }
        }

        stage('Approve Cassandra Deployment') {
            steps {
                input(
                    message: 'Deploy Cassandra configuration to all 3 nodes?',
                    ok: 'Deploy'
                )
            }
        }

        stage('Deploy Cassandra') {
            steps {
                sshagent(credentials: ['cassandra-bastion-key']) {
                    sh '''
                        set -e
                        cd /opt/cassandra-one-click/ansible
                        ansible-playbook -i inventory site.yml
                    '''
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sshagent(credentials: ['cassandra-bastion-key']) {
                    sh '''
                        set -e
                        cd /opt/cassandra-one-click/ansible

                        for node in node1 node2 node3; do
                            echo "Verifying Cassandra on $node"

                            ansible "$node" -i inventory \
                                -m shell \
                                -a 'for i in $(seq 1 60); do nodetool status && exit 0; sleep 5; done; exit 1'
                        done

                        echo "CASSANDRA_NODES_RESPONDING"
                    '''
                }
            }
        }
    }
}
