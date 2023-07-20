Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9075EB64DA
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Jul 2023 13:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjGTNEN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Jul 2023 09:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjGTNEK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Jul 2023 09:04:10 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997B4270D
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 06:03:47 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="104650354"
X-IronPort-AV: E=Sophos;i="6.01,218,1684767600"; 
   d="scan'208";a="104650354"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 22:03:29 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 037B7D29E5
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 22:03:28 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2B2D6D6164
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 22:03:27 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A06492007896E;
        Thu, 20 Jul 2023 22:03:26 +0900 (JST)
Message-ID: <25748e3b-1f33-aee2-163c-4ae496e432cf@fujitsu.com>
Date:   Thu, 20 Jul 2023 21:03:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Xiao Yang <yangx.jy@fujitsu.com>
Subject: Question: how to create a cxl region with the specified numa node and
 distance
To:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27762.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27762.007
X-TMASE-Result: 10--11.626900-10.000000
X-TMASE-MatchedRID: J/NqXV0mzJf4CT5pWw/YERFbgtHjUWLyTJDl9FKHbrkSdCEp3KAaLzdM
        oT0/Z54OiwAYJIsOK4oOPeSe9fB/o7aaK/A0riJACtzGvPCy/m6qaiJb7nHDvr8r2YKZauYGevc
        IgYMG75pa6KMtUGwDZ1dbqAzxizwITX7PJ/OU3vKDGx/OQ1GV8tigzzbKqYUy+gtHj7OwNO0UQC
        QtpNwWekUitoeYPWVKu1rGo+nE+eTeD+vCW1+Ci78BzBk63rAu
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi All,

I tried to simulate a cxl memory device by the following qemu options:
--------------------------------------------------------------------
...
-object memory-backend-ram,size=1048576k,id=m0 \
-object memory-backend-ram,size=1048576k,id=m1 \
-numa node,nodeid=0,cpus=0-3,memdev=m0 \
-numa node,nodeid=1,memdev=m1 \
-numa dist,src=0,dst=1,val=15 \
...
-object memory-backend-ram,size=1048576k,share=on,id=vmem0 \
-device pxb-cxl,bus_nr=12,bus=pcie.0,numa_node=1,id=cxl.1 \
-device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
-device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
--------------------------------------------------------------------

With the above configuration, the cxl memory device (mem0) can locate in
the numa node1 but a new created region with mem0 still locates in a new 
numa node2.
--------------------------------------------------------------------
# cxl list -M
[
   {
     "memdev":"mem0",
     "ram_size":1073741824,
     "serial":0,
     "numa_node":1,
     "host":"0000:0d:00.0"
   }
]

# cxl create-region -t ram -d decoder0.0 -m mem0
...
cxl region: cmd_create_region: created 1 region

# numastat
                            node0           node1           node2
numa_hit                  310897            2090               0
numa_miss                      0               0               0
numa_foreign                   0               0               0
interleave_hit               250             691               0
local_node                310897               0               0
other_node                     0            2090               0

# numactl -H
available: 3 nodes (0-2)
node 0 cpus: 0 1 2 3
node 0 size: 955 MB
node 0 free: 480 MB
node 1 cpus:
node 1 size: 938 MB
node 1 free: 908 MB
node 2 cpus:
node 2 size: 1024 MB
node 2 free: 1024 MB
node distances:
node   0   1   2
   0:  10  15  20
   1:  15  10  20
   2:  20  20  10
---------------------------------------------------------------------
Q1: How to specify the numa node for the new created region?
Q2: How to specify the numa node distance for the new created region?
     The default distance is 20.

Best Regards,
Xiao Yang
