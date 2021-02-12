[all]
localhost ansible_connection=local

[nodes]
%{ for ip in nodes ~}
${ip} ansible_connection=ssh
%{ endfor ~}
