#   (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
####################################################
# Registers an endpoint to add a new agent service.
#
# Inputs:
#   - host - Consul agent host
#   - consul_port - optional - Consul agent host port - Default: '8500'
#   - address - optional - will default to that of the agent
#   - service_name - the service name what will be registered
#   - service_id - optional - if omitted, service_name will be used instead
#   - check - optional - if the Check key is provided, then a health check will also be registered
# Outputs:
#   - error_message - return_result if there was an error
# Results:
#   - SUCCESS - parsing was successful (return_code == '0')
#   - FAILURE - otherwise
####################################################

namespace: io.cloudslang.consul

flow:
  name: register_agent_service
  inputs:
    - host
    - consul_port:
        default: '8500'
        required: false
    - address:
        required: false
    - service_name
    - service_id:
        required: false
    - check:
        required: false
  workflow:
    - parse_register_agent_service_request:
        do:
          parse_register_agent_service_request:
            - address
            - service_name
            - service_id
            - check
        publish:
          - json_request
    - send_register_agent_service_request:
        do:
          send_register_agent_service_request:
            - host
            - consul_port
            - json_request
        publish:
          - error_message
  outputs:
    - error_message
