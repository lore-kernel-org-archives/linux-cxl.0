Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98343C38142
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Jan 2023 10:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjAXKVd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Jan 2023 05:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjAXKVd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 24 Jan 2023 05:21:33 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11305272
        for <linux-cxl@vger.kernel.org>; Tue, 24 Jan 2023 02:21:31 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1NGG1MjTz6J696;
        Tue, 24 Jan 2023 18:18:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 10:21:29 +0000
Date:   Tue, 24 Jan 2023 10:21:28 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] cxl: CXL Inject & Clear Poison
Message-ID: <20230124102128.00002316@Huawei.com>
In-Reply-To: <Y88babGTKB91a5qV@aschofie-mobl2>
References: <cover.1674101475.git.alison.schofield@intel.com>
        <20230123171301.000071ba@huawei.com>
        <Y88babGTKB91a5qV@aschofie-mobl2>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 23 Jan 2023 15:42:33 -0800
Alison Schofield <alison.schofield@intel.com> wrote:

> On Mon, Jan 23, 2023 at 05:13:01PM +0000, Jonathan Cameron wrote:
> > On Wed, 18 Jan 2023 21:00:15 -0800
> > alison.schofield@intel.com wrote:
> >   
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > Built on cxl/next plus Patchset: CXL Poison List Retrieval & Tracing:
> > > https://lore.kernel.org/linux-cxl/de11785ff05844299b40b100f8e0f56c7eef7f08.1674070170.git.alison.schofield@intel.com/  
> > 
> > Only tangentially relevant, but I've only just registered
> > as a result of getting a lot of 0 timestamps (which is what
> > you return if the timestamp base is unknown) that I don't
> > think we currently ever set the EP timestamp.
> > 
> > Recommendation in the spec (8.2.9.4.2) is:
> > "It is recommended that the host set hte timestamp
> > after ever Conventional or CXL Reset"
> > 
> > I'd go further and assume that if we are doing native error
> > handling then it's up to the OS to initialize the timestamp.
> > 
> > Also relevant to Ira's series as events are timestamped.
> > Currently Ira's QEMU code doesn't take this subtlety into
> > account (poison doesn't either - but I have patches).
> > 
> > Jonathan
> >   
> 
> Jonathan,
> 
> I hadn't seen the Set Timestamp cmd, but I think we are OK with
> Get Poison List and it's overflow_t reporting, it does not use
> a relative timestamp, but absolute since Jan-1970.

I'd assume most devices have no ability to get that timestamp without
a set timestamp command.  You might get some with an RTC that is factory
set, but I doubt it will be common.

> 
> Table 8-106 says: 
> Overflow Timestamp: The time that the device determined the poison
> list overflowed. This field is only valid if the overflow indicator is set. The
> number of unsigned nanoseconds that have elapsed since midnight, 01-
> Jan-1970, UTC. If the device does not have a valid timestamp, return 0.

Yup, but Table 8-60  Set Timestamp Input Payload has

"Timestamp: The number of unsigned nanoseconds that have elapsed since midnight,
01-Jan-1970, UTC."
above that it is the text that says the host should set it on Conventional
or CXL reset (which obviously includes boot).

That's where the device idea of time is coming from so that it can be returned
in places like the Overflow timestamp.  My reading of that bit about
"not have a valid timestamp, return 0" is that is targeting the case where
a timestamp has not been set since reset.

All in all, we are fine (in that it 'works') but with out set timestamp
the generated time stamps are going to be garbage on many devices.

I'll spin an RFC patch adding the call and we can work out what
conditions it should be called under in that thread.

Jonathan



> 
> Alison
> 
> 
> >   
> > > 
> > > Changes in v2:
> > > - Add Jonathan Reviewed-by tags to Patches 1,2,4
> > > - Clean up input payload structs for both inject and clear (Dan)
> > > - Commit message cleanups, including spec references (Dave)
> > > - Use CXL_POISON_LEN_MULT in define of clear write data
> > > - Use IS_ALIGNED() for 64byte align check (Dan)
> > > - Add Kconfig CXL_POISON_INJECT  (Dan)
> > > - Trivial space cleanup (Jonathan)
> > > - Doc/ABI cleanup (Dave, Dan)
> > > - Mock: Only use injected errors for get poison list
> > > - Mock: Use 'POISONLMT -ENXIO' text from CMD_CMD_RC_TABLE  (Jonathan)
> > > - Mock: Add Patch 6/6: A module param to mock device inject limit
> > > 
> > > Link to v1: https://lore.kernel.org/linux-cxl/cover.1669781852.git.alison.schofield@intel.com/
> > > 
> > > Introducing Inject and Clear Poison support for CXL Devices.
> > > 
> > > These are optional commands, meaning not all CXL devices must support
> > > them. The sysfs attributes, inject_poison and clear_poison, are only
> > > visible for devices reporting support of the capability and when the
> > > kernel Kconfig option CONFIG_CXL_POISON_INJECT is on. (Default: off)
> > > 
> > > Example:
> > > # echo 0x40000000 > /sys/bus/cxl/devices/mem1/inject_poison
> > > # echo 1 > /sys/bus/cxl/devices/mem1/trigger_poison_list
> > > 
> > > cxl_poison: memdev=mem1 pcidev=cxl_mem.1 region= region_uuid=00000000-0000-0000-0000-000000000000 hpa=0xffffffffffffffff dpa=0x40000000 length=0x40 source=Injected flags= overflow_time=0
> > > 
> > > 
> > > Alison Schofield (6):
> > >   cxl/memdev: Add support for the Inject Poison mailbox command
> > >   cxl/memdev: Add support for the Clear Poison mailbox command
> > >   tools/testing/cxl: Mock the Inject Poison mailbox command
> > >   tools/testing/cxl: Mock the Clear Poison mailbox command
> > >   tools/testing/cxl: Use injected poison for get poison list
> > >   tools/testing/cxl: Add a param to test poison injection limits
> > > 
> > >  Documentation/ABI/testing/sysfs-bus-cxl |  40 ++++++
> > >  drivers/cxl/Kconfig                     |  10 ++
> > >  drivers/cxl/core/memdev.c               | 122 ++++++++++++++++
> > >  drivers/cxl/cxlmem.h                    |  11 ++
> > >  tools/testing/cxl/test/mem.c            | 178 +++++++++++++++++++++---
> > >  5 files changed, 341 insertions(+), 20 deletions(-)
> > >   
> >   
> 

