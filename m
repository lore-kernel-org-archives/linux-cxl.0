Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EA2C25B50
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 23:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjAWXmh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 18:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjAWXmg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 18:42:36 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703771207B
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 15:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674517355; x=1706053355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e4C5DSGcrM8Aox/+lC3Prh3srDYmtXZchpf8xcTonM8=;
  b=gxhWW7/mBXxHfP7z0x5/AF7XkFz2ujEkBMQy2sN5GlkpVRCOtZHfTLIL
   t7Qa6A+w+8vk+gSZX1CBSvWCzqJKDWnZHkDAUDIQcBtH0Wk4o0hyBdVb8
   hvD9evEJho+SDodmJlNRyzfAxPqCSQcffUFsme9aKYSUvG+3nuxKJnNEW
   z/7GHOjgYW58xHDTzi/OC0TeOTjzOpgTPG8JG9aY0zHF/FyXvqsS9F5T7
   u+QFS5x/jtQnQkOaEzk2FJohLHDq7VGkHRpkBhMh+jNKjBTE1OkkEh79m
   Ee4WVArZps+m15CSjzFwhHGjJ/CleRI1Tsuho99oB3/BXY5i/YQoHCbB5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="323881914"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="323881914"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 15:42:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="639382515"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="639382515"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.2.84])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 15:42:34 -0800
Date:   Mon, 23 Jan 2023 15:42:33 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 0/6] cxl: CXL Inject & Clear Poison
Message-ID: <Y88babGTKB91a5qV@aschofie-mobl2>
References: <cover.1674101475.git.alison.schofield@intel.com>
 <20230123171301.000071ba@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123171301.000071ba@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 23, 2023 at 05:13:01PM +0000, Jonathan Cameron wrote:
> On Wed, 18 Jan 2023 21:00:15 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Built on cxl/next plus Patchset: CXL Poison List Retrieval & Tracing:
> > https://lore.kernel.org/linux-cxl/de11785ff05844299b40b100f8e0f56c7eef7f08.1674070170.git.alison.schofield@intel.com/
> 
> Only tangentially relevant, but I've only just registered
> as a result of getting a lot of 0 timestamps (which is what
> you return if the timestamp base is unknown) that I don't
> think we currently ever set the EP timestamp.
> 
> Recommendation in the spec (8.2.9.4.2) is:
> "It is recommended that the host set hte timestamp
> after ever Conventional or CXL Reset"
> 
> I'd go further and assume that if we are doing native error
> handling then it's up to the OS to initialize the timestamp.
> 
> Also relevant to Ira's series as events are timestamped.
> Currently Ira's QEMU code doesn't take this subtlety into
> account (poison doesn't either - but I have patches).
> 
> Jonathan
> 

Jonathan,

I hadn't seen the Set Timestamp cmd, but I think we are OK with
Get Poison List and it's overflow_t reporting, it does not use
a relative timestamp, but absolute since Jan-1970.

Table 8-106 says: 
Overflow Timestamp: The time that the device determined the poison
list overflowed. This field is only valid if the overflow indicator is set. The
number of unsigned nanoseconds that have elapsed since midnight, 01-
Jan-1970, UTC. If the device does not have a valid timestamp, return 0.

Alison


> 
> > 
> > Changes in v2:
> > - Add Jonathan Reviewed-by tags to Patches 1,2,4
> > - Clean up input payload structs for both inject and clear (Dan)
> > - Commit message cleanups, including spec references (Dave)
> > - Use CXL_POISON_LEN_MULT in define of clear write data
> > - Use IS_ALIGNED() for 64byte align check (Dan)
> > - Add Kconfig CXL_POISON_INJECT  (Dan)
> > - Trivial space cleanup (Jonathan)
> > - Doc/ABI cleanup (Dave, Dan)
> > - Mock: Only use injected errors for get poison list
> > - Mock: Use 'POISONLMT -ENXIO' text from CMD_CMD_RC_TABLE  (Jonathan)
> > - Mock: Add Patch 6/6: A module param to mock device inject limit
> > 
> > Link to v1: https://lore.kernel.org/linux-cxl/cover.1669781852.git.alison.schofield@intel.com/
> > 
> > Introducing Inject and Clear Poison support for CXL Devices.
> > 
> > These are optional commands, meaning not all CXL devices must support
> > them. The sysfs attributes, inject_poison and clear_poison, are only
> > visible for devices reporting support of the capability and when the
> > kernel Kconfig option CONFIG_CXL_POISON_INJECT is on. (Default: off)
> > 
> > Example:
> > # echo 0x40000000 > /sys/bus/cxl/devices/mem1/inject_poison
> > # echo 1 > /sys/bus/cxl/devices/mem1/trigger_poison_list
> > 
> > cxl_poison: memdev=mem1 pcidev=cxl_mem.1 region= region_uuid=00000000-0000-0000-0000-000000000000 hpa=0xffffffffffffffff dpa=0x40000000 length=0x40 source=Injected flags= overflow_time=0
> > 
> > 
> > Alison Schofield (6):
> >   cxl/memdev: Add support for the Inject Poison mailbox command
> >   cxl/memdev: Add support for the Clear Poison mailbox command
> >   tools/testing/cxl: Mock the Inject Poison mailbox command
> >   tools/testing/cxl: Mock the Clear Poison mailbox command
> >   tools/testing/cxl: Use injected poison for get poison list
> >   tools/testing/cxl: Add a param to test poison injection limits
> > 
> >  Documentation/ABI/testing/sysfs-bus-cxl |  40 ++++++
> >  drivers/cxl/Kconfig                     |  10 ++
> >  drivers/cxl/core/memdev.c               | 122 ++++++++++++++++
> >  drivers/cxl/cxlmem.h                    |  11 ++
> >  tools/testing/cxl/test/mem.c            | 178 +++++++++++++++++++++---
> >  5 files changed, 341 insertions(+), 20 deletions(-)
> > 
> 
