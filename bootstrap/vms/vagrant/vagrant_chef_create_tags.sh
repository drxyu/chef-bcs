#!/bin/bash
#
# Author: Chris Jones <cjones303@bloomberg.net>
# Copyright 2015, Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Sets the base roles for the nodes so as to start over...

source vagrant_base.sh

# Set the environment for all of the nodes
for vm in ${ceph_vms[@]}; do
  do_on_node $CEPH_CHEF_BOOTSTRAP "$KNIFE node environment set $vm.$BOOTSTRAP_DOMAIN $BOOTSTRAP_CHEF_ENV"
done

# Now just set the specific nodes...

for vm in ${CEPH_MON_HOSTS[@]}; do
  do_on_node $CEPH_CHEF_BOOTSTRAP "$KNIFE tag create $vm.$BOOTSTRAP_DOMAIN 'ceph-mon'"
done

for vm in ${CEPH_OSD_HOSTS[@]}; do
  do_on_node $CEPH_CHEF_BOOTSTRAP "$KNIFE tag create $vm.$BOOTSTRAP_DOMAIN 'ceph-osd'"
done

for vm in ${CEPH_RGW_HOSTS[@]}; do
  do_on_node $CEPH_CHEF_BOOTSTRAP "$KNIFE tag create $vm.$BOOTSTRAP_DOMAIN 'ceph-rgw'"
done

for vm in ${CEPH_MDS_HOSTS[@]}; do
  do_on_node $CEPH_CHEF_BOOTSTRAP "$KNIFE tag create $vm.$BOOTSTRAP_DOMAIN 'ceph-mds'"
done

for vm in ${CEPH_ADMIN_HOSTS[@]}; do
  do_on_node $CEPH_CHEF_BOOTSTRAP "$KNIFE tag create $vm.$BOOTSTRAP_DOMAIN 'ceph-admin'"
  # NOTE: ceph-restapi can be split out later if desired
  do_on_node $CEPH_CHEF_BOOTSTRAP "$KNIFE tag create $vm.$BOOTSTRAP_DOMAIN 'ceph-restapi'"
done

# Just use the first VM as a radosgw node
#do_on_node $CEPH_CHEF_BOOTSTRAP "$KNIFE tag create ${CEPH_CHEF_HOSTS[@]:1:1}.$BOOTSTRAP_DOMAIN 'ceph-rgw'"

# Just use the first VM as a restapi node
#do_on_node $CEPH_CHEF_BOOTSTRAP "$KNIFE tag create ${CEPH_CHEF_HOSTS[@]:1:1}.$BOOTSTRAP_DOMAIN 'ceph-restapi'"
