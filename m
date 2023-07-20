Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02542EB64DC
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Jul 2023 13:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjGTNlb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Jul 2023 09:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjGTNla (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Jul 2023 09:41:30 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BD61986
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 06:41:28 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="103993021"
X-IronPort-AV: E=Sophos;i="6.01,218,1684767600"; 
   d="scan'208";a="103993021"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 22:41:27 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id E81B0C68E1
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 22:41:24 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C207CF7C2
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 22:41:24 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 900C620076857;
        Thu, 20 Jul 2023 22:41:23 +0900 (JST)
Message-ID: <be32d40f-4fe3-5d50-6ae8-b394f7aeaca3@fujitsu.com>
Date:   Thu, 20 Jul 2023 21:41:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Xiao Yang <yangx.jy@fujitsu.com>
Subject: How to find the correct corresponding relationship between mem
 devices and target postions?
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27762.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27762.007
X-TMASE-Result: 10--7.163200-10.000000
X-TMASE-MatchedRID: alNhoJufFSTZC6gBBBgpoEIww1YA2si+7xtPw/8I7HSJy/P0PFqswRGb
        vPrj6ZNXj6kCfX0Edc57L4dx4z+0QCbSyZk5sIPECtzGvPCy/m6Tjlc0Xf11TozKfHXhvI1To8W
        MkQWv6iUD0yuKrQIMCOrtHAEBNfzgC24oEZ6SpSkj80Za3RRg8GV3mZFsB3Izf0ALBYJzU5ypFC
        WUnQK2YVQXC/DkC1B/mCxQMQcrwv8=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Dan,

I tried to simulate four cxl memory devices by the following qemu options:
--------------------------------------------------------------------
-object memory-backend-ram,size=1048576k,id=m0 \
-object memory-backend-ram,size=1048576k,id=m1 \
-numa node,nodeid=0,cpus=0-1,memdev=m0 \
-numa node,nodeid=1,cpus=2-3,memdev=m1 \
...
-object memory-backend-ram,size=262144k,share=on,id=vmem0 \
-object memory-backend-ram,size=262144k,share=on,id=vmem1 \
-object memory-backend-ram,size=262144k,share=on,id=vmem2 \
-object memory-backend-ram,size=262144k,share=on,id=vmem3 \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
-device pxb-cxl,bus_nr=22,bus=pcie.0,id=cxl.2 \
-device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
-device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
-device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
-device cxl-type3,bus=root_port14,volatile-memdev=vmem1,id=cxl-vmem1 \
-device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
-device cxl-type3,bus=root_port15,volatile-memdev=vmem2,id=cxl-vmem2 \
-device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
-device cxl-type3,bus=root_port16,volatile-memdev=vmem3,id=cxl-vmem3 \
-M 
cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k
--------------------------------------------------------------------

I failed to create the new region with four cxl memory devices:
--------------------------------------------------------------------
# cxl create-region -t ram -d decoder0.0 -m mem0 mem1 mem2 mem3
cxl region: create_region: region0: failed to set target1 to mem1
cxl region: cmd_create_region: created 0 regions
--------------------------------------------------------------------

The root cause is that all cxl memory devices find the wrong 
corresponding target postions(e.g. mem0 <-> target0 is wrong)

Is there any way to find the correct corresponding relationship in 
userspace?

Best Regards,
Xiao Yang
