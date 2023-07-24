Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695C8C001B0
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 08:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGXI6y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 04:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjGXI5z (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 04:57:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A62CE64
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 01:57:51 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R8Yr01xHPz688p7;
        Mon, 24 Jul 2023 16:54:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 09:57:48 +0100
Date:   Mon, 24 Jul 2023 09:57:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <nifan@outlook.com>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>, <gregory.price@memverge.com>,
        <hchkuo@avery-design.com.tw>, <cbrowy@avery-design.com>,
        <dan.j.williams@intel.com>, <a.manzanares@samsung.com>,
        <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>
Subject: Re: [Qemu PATCH 0/9] Enabling DCD emulation support in Qemu
Message-ID: <20230724095748.00007e46@Huawei.com>
In-Reply-To: <64bcb1f6ee016_760de2943b@iweiny-mobl.notmuch>
References: <SG2PR06MB33976BB3F9C47CBE08F02D09B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
        <64bcb1f6ee016_760de2943b@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, 22 Jul 2023 21:52:06 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> nifan@ wrote:
> > From: Fan Ni <nifan@outlook.com>
> > 
> > The patch series provides dynamic capacity device (DCD) emulation in Qemu.  
> 
> I don't the patches on the list.
> 
> https://lore.kernel.org/all/SG2PR06MB33976BB3F9C47CBE08F02D09B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com/
> 
> Did they get sent?
Something odd going on...
They are in https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg04105.html
though threading is broken.
Also seems to have made it to qemu-devel on lore
https://lore.kernel.org/all/SG2PR06MB3397F3E74A083607F7492FA4B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com/

Might be a backlog somewhere that will take a while to drain...

Fan, perhaps just resend the lot and make sure the threading works so we can find them more easily.

Jonathan


> 
> Ira
> 
> > More specifically, it provides the following functionalities:
> > 1. Extended type3 memory device to support DC regions and extents.
> > 2. Implemented DCD related mailbox command support in CXL r3.0: 8.2.9.8.9.
> > 3. ADD QMP interfaces for adding and releasing DC extents to simulate FM
> > functions for DCD described in cxl r3.0: 7.6.7.6.5 and 7.6.7.6.6.
> > 4. Add new ct3d properties for DCD devices (host backend, number of dc
> > regions, etc.)
> > 5. Add read/write support from/to DC regions of the device.
> > 6. Add mechanism to validate accessed to DC region address space.
> > 
> > A more detailed description can be found from the previously posted RFC[1].
> > 
> > Compared to the previously posted RFC[1], following changes have been made:
> > 1. Rebased the code on top of Jonathan's branch
> > https://gitlab.com/jic23/qemu/-/tree/cxl-2023-05-25.
> > 2. Extracted the rename of mem_size to a separated patch.(Jonathan)
> > 3. Reordered the patch series to improve its readability.(Jonathan)
> > 4. Split the validation of accesses to DC region address space as a separate
> > patch.
> > 5. Redesigned the QMP interfaces for adding and releasing DC extents to make
> > them easier to understand and act like existing QMP interfaces (like the
> > interface for cxl-inject-uncorrectable-errors). (Jonathan)
> > 6. Updated dvsec range register setting to support DCD devices without static
> > capacity.
> > 7. Fixed other issues mentioned in the comments (Jonathan&Nathan Fontenot).
> > 8. Fixed the format issues and checked with checkpatch.pl under qemu code dir.
> > 
> > 
> > The code is tested with the DCD patch series at the kernel side[2]. The test
> > is similar to those mentioned in the cover letter of [1].
> > 
> > 
> > [1]: https://lore.kernel.org/all/20230511175609.2091136-1-fan.ni@samsung.com/
> > [2]: https://lore.kernel.org/linux-cxl/649da378c28a3_968bb29420@iweiny-mobl.notmuch/T/#t
> > 
> > Fan Ni (9):
> >   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> >     payload of identify memory device command
> >   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
> >     and mailbox command support
> >   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
> >     type3 memory devices
> >   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
> >     devices
> >   hw/mem/cxl_type3: Add host backend and address space handling for DC
> >     regions
> >   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
> >     list mailbox support
> >   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
> >     dynamic capacity response
> >   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
> >     extents
> >   hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions
> > 
> >  hw/cxl/cxl-mailbox-utils.c  | 421 +++++++++++++++++++++++++++-
> >  hw/mem/cxl_type3.c          | 539 +++++++++++++++++++++++++++++++++---
> >  hw/mem/cxl_type3_stubs.c    |   6 +
> >  include/hw/cxl/cxl_device.h |  49 +++-
> >  include/hw/cxl/cxl_events.h |  16 ++
> >  qapi/cxl.json               |  49 ++++
> >  6 files changed, 1034 insertions(+), 46 deletions(-)
> > 
> > -- 
> > 2.39.2
> >   
> 
> 
> 

