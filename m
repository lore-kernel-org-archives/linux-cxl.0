Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1076AC41513
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Jul 2023 02:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGWCzy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 22 Jul 2023 22:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGWCzy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 22 Jul 2023 22:55:54 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8712B1BD3
        for <linux-cxl@vger.kernel.org>; Sat, 22 Jul 2023 19:55:52 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="104281084"
X-IronPort-AV: E=Sophos;i="6.01,226,1684767600"; 
   d="scan'208";a="104281084"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 11:55:50 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0ACDADAE0C
        for <linux-cxl@vger.kernel.org>; Sun, 23 Jul 2023 11:55:48 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4B157D3F02
        for <linux-cxl@vger.kernel.org>; Sun, 23 Jul 2023 11:55:47 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id ABB406BF6F;
        Sun, 23 Jul 2023 11:55:46 +0900 (JST)
Message-ID: <e3a27d20-d55c-096f-8a98-d9f5c4997b02@fujitsu.com>
Date:   Sun, 23 Jul 2023 10:55:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: How to find the correct corresponding relationship between mem
 devices and target postions?
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
References: <be32d40f-4fe3-5d50-6ae8-b394f7aeaca3@fujitsu.com>
 <ZLxSqdB9VmR2uZ6c@aschofie-mobl2>
From:   Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <ZLxSqdB9VmR2uZ6c@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27768.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27768.004
X-TMASE-Result: 10--17.534500-10.000000
X-TMASE-MatchedRID: 5U6uFEJz7+qPvrMjLFD6eK5i3jK3KDOoofZV/2Xa0cIBLwIiWDU8azUB
        0rXMh0JarycJJmqvUrpg3t1DWHRjJ2JZXQNDzktSCp8Uics7X6pMVCcj56k8hlHB0AGeSMcHvjN
        9OkaN1tqLVDMXzEGmRaqIzsr8BNhuE9wooMew8CGsOGJbGXAB5dPZWt1+42smqRTAHcwAECcn4J
        kU8L63QdYrQc5g34AdNttT+PtIHfhKf70fyYVtP3tNecKMjy32tAQ1UAnR9ndqBZZ8SbtvoYRMy
        N/ppM4nZfimYRvSI6Ngz/Pvx4ih53sSZu+XceD6ngIgpj8eDcC063Wh9WVqgtQdB5NUNSsiDrBA
        jvbPhh50HSe131POnjsAVzN+Ov/smpxetSlEMxaPCmKR6+uZMsni5QfuzEOVBnBDeT6pSgj6T5E
        3mZElvg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 2023/7/23 6:05, Alison Schofield wrote:
> On Thu, Jul 20, 2023 at 09:41:23PM +0800, Xiao Yang wrote:
>> Hi Dan,
>>
>> I tried to simulate four cxl memory devices by the following qemu options:
>> --------------------------------------------------------------------
>> -object memory-backend-ram,size=1048576k,id=m0 \
>> -object memory-backend-ram,size=1048576k,id=m1 \
>> -numa node,nodeid=0,cpus=0-1,memdev=m0 \
>> -numa node,nodeid=1,cpus=2-3,memdev=m1 \
>> ...
>> -object memory-backend-ram,size=262144k,share=on,id=vmem0 \
>> -object memory-backend-ram,size=262144k,share=on,id=vmem1 \
>> -object memory-backend-ram,size=262144k,share=on,id=vmem2 \
>> -object memory-backend-ram,size=262144k,share=on,id=vmem3 \
>> -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>> -device pxb-cxl,bus_nr=22,bus=pcie.0,id=cxl.2 \
>> -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
>> -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
>> -device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
>> -device cxl-type3,bus=root_port14,volatile-memdev=vmem1,id=cxl-vmem1 \
>> -device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
>> -device cxl-type3,bus=root_port15,volatile-memdev=vmem2,id=cxl-vmem2 \
>> -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
>> -device cxl-type3,bus=root_port16,volatile-memdev=vmem3,id=cxl-vmem3 \
>> -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k
>> --------------------------------------------------------------------
>>
>> I failed to create the new region with four cxl memory devices:
>> --------------------------------------------------------------------
>> # cxl create-region -t ram -d decoder0.0 -m mem0 mem1 mem2 mem3
>> cxl region: create_region: region0: failed to set target1 to mem1
>> cxl region: cmd_create_region: created 0 regions
>> --------------------------------------------------------------------
>>
>> The root cause is that all cxl memory devices find the wrong corresponding
>> target postions(e.g. mem0 <-> target0 is wrong)
>>
>> Is there any way to find the correct corresponding relationship in
>> userspace?
> 
> Hi Xiao,
> 
> You can use cxl-cli tool to find the order before doing the
> 'cxl create-region'.  (Some folks may just know the order
> by looking at your qemu setup.)
> 
> Knowing you want to use decoder0.0
> $cxl list -DT -d decoder0.0
> 
> That will get you the list of targets. nr_targets should be '4' and
> the targets will have a position #.

Hi Alison,

Thanks a lot for your detailed reply.

nr_targets is 2 on my enviroment:
$ cxl list -DT -d decoder0.0
[
   {
     "decoder":"decoder0.0",
     "resource":31406948352,
     "size":4294967296,
     "interleave_ways":2,
     "interleave_granularity":8192,
     "max_available_extent":4294967296,
     "pmem_capable":true,
     "volatile_capable":true,
     "accelmem_capable":true,
     "nr_targets":2,
     "targets":[
       {
         "target":"pci0000:16",
         "alias":"ACPI0016:00",
         "position":1,
         "id":22
       },
       {
         "target":"pci0000:0c",
         "alias":"ACPI0016:01",
         "position":0,
         "id":12
       }
     ]
   }
]

> 
> $cxl list -M -p <fill-in-a-target-name> | jq -r ".[0].memdev"
> 
> That gives you the memdev for that target.
> Repeat for all 4 targets, by position, and use that order.

Each target links two CXL memory devices:
$ cxl list -M -p pci0000:0c
[
   {
     "memdev":"mem3",
     "ram_size":268435456,
     "serial":0,
     "host":"0000:0e:00.0"
   },
   {
     "memdev":"mem0",
     "ram_size":268435456,
     "serial":0,
     "host":"0000:0d:00.0"
   }
]
$ cxl list -M -p pci0000:16
[
   {
     "memdev":"mem2",
     "ram_size":268435456,
     "serial":0,
     "host":"0000:17:00.0"
   },
   {
     "memdev":"mem1",
     "ram_size":268435456,
     "serial":0,
     "host":"0000:18:00.0"
   }
]

Do you mean that I have to create a new region with four memdevs in the 
fixed order? For example:
$ cxl create-region -t ram -d decoder0.0 -m mem3 mem2 mem0 mem1

In other words, I cannot create a new region with four memdevs in the 
following normal/random order. Is it right?
$ cxl create-region -t ram -d decoder0.0 -m mem0 mem1 mem2 mem3

> 
> You can use the cxl unit tests for examples of how to find the
> memdevs for a region: https://github.com/pmem/ndctl/tree/main/test
> Search for where we do 'create-region'

Thanks for your suggestion. I will look into these examples.

Best Regards,
Xiao Yang
> 
> Hope that helps,
> Alison
> 
>> ch
>> Best Regards,
>> Xiao Yang
