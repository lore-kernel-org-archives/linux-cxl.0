Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E5BC0015E
	for <linux-cxl@archiver.kernel.org>; Sat, 22 Jul 2023 22:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjGVWFd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 22 Jul 2023 18:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGVWFd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 22 Jul 2023 18:05:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C745171F
        for <linux-cxl@vger.kernel.org>; Sat, 22 Jul 2023 15:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690063532; x=1721599532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YH2WCNvMMC0Mq7x1cTv7O+GYQvZagPlXsRy5OGIgMzQ=;
  b=ZOf4HqQDL7ndwNO+q1HrFdgoQue11TOvHJ3IqEBl4helOCz6J8VfNHTM
   D3gVaQpVpZkKmiuA7P0fNId1mkH1P7jlgMD7PiYMl7rcPerbdftERLbZ9
   g4KLFqM6MVACPxLmKYk+VoJSK/7qQyxr69UuGEQppT8ua/hZPCAYk2JF0
   rjfMrgnt9s6EXE3ZhBAoCuQRlJaDa4ni2ghcg9i0+n+kFIW7CeB1c2pFr
   R4oac6xkmJ9WAsr5Xll+Zgre25rirY+mHHSM4GvYGN/VL2f7P88HKGoRW
   TkZq6OmBwqSG0rkPKaO35ZBlC7Bjy9rYfrHCdkupIGnyJr8ATO78y7vO9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="367258359"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="367258359"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 15:05:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="1055961652"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="1055961652"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.182.235])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 15:05:31 -0700
Date:   Sat, 22 Jul 2023 15:05:29 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: How to find the correct corresponding relationship between mem
 devices and target postions?
Message-ID: <ZLxSqdB9VmR2uZ6c@aschofie-mobl2>
References: <be32d40f-4fe3-5d50-6ae8-b394f7aeaca3@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be32d40f-4fe3-5d50-6ae8-b394f7aeaca3@fujitsu.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jul 20, 2023 at 09:41:23PM +0800, Xiao Yang wrote:
> Hi Dan,
> 
> I tried to simulate four cxl memory devices by the following qemu options:
> --------------------------------------------------------------------
> -object memory-backend-ram,size=1048576k,id=m0 \
> -object memory-backend-ram,size=1048576k,id=m1 \
> -numa node,nodeid=0,cpus=0-1,memdev=m0 \
> -numa node,nodeid=1,cpus=2-3,memdev=m1 \
> ...
> -object memory-backend-ram,size=262144k,share=on,id=vmem0 \
> -object memory-backend-ram,size=262144k,share=on,id=vmem1 \
> -object memory-backend-ram,size=262144k,share=on,id=vmem2 \
> -object memory-backend-ram,size=262144k,share=on,id=vmem3 \
> -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> -device pxb-cxl,bus_nr=22,bus=pcie.0,id=cxl.2 \
> -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
> -device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
> -device cxl-type3,bus=root_port14,volatile-memdev=vmem1,id=cxl-vmem1 \
> -device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
> -device cxl-type3,bus=root_port15,volatile-memdev=vmem2,id=cxl-vmem2 \
> -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
> -device cxl-type3,bus=root_port16,volatile-memdev=vmem3,id=cxl-vmem3 \
> -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k
> --------------------------------------------------------------------
> 
> I failed to create the new region with four cxl memory devices:
> --------------------------------------------------------------------
> # cxl create-region -t ram -d decoder0.0 -m mem0 mem1 mem2 mem3
> cxl region: create_region: region0: failed to set target1 to mem1
> cxl region: cmd_create_region: created 0 regions
> --------------------------------------------------------------------
> 
> The root cause is that all cxl memory devices find the wrong corresponding
> target postions(e.g. mem0 <-> target0 is wrong)
> 
> Is there any way to find the correct corresponding relationship in
> userspace?

Hi Xiao,

You can use cxl-cli tool to find the order before doing the
'cxl create-region'.  (Some folks may just know the order
by looking at your qemu setup.)

Knowing you want to use decoder0.0
$cxl list -DT -d decoder0.0

That will get you the list of targets. nr_targets should be '4' and
the targets will have a position #.

$cxl list -M -p <fill-in-a-target-name> | jq -r ".[0].memdev"

That gives you the memdev for that target.
Repeat for all 4 targets, by position, and use that order.

You can use the cxl unit tests for examples of how to find the
memdevs for a region: https://github.com/pmem/ndctl/tree/main/test
Search for where we do 'create-region'

Hope that helps,
Alison

>ch 
> Best Regards,
> Xiao Yang
