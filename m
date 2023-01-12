Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20CCC61DB3
	for <linux-cxl@archiver.kernel.org>; Thu, 12 Jan 2023 18:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239955AbjALSB2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 Jan 2023 13:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbjALSAi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 Jan 2023 13:00:38 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD2B30A
        for <linux-cxl@vger.kernel.org>; Thu, 12 Jan 2023 09:21:34 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NtB983S1Dz67Xmk;
        Fri, 13 Jan 2023 01:18:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 17:21:31 +0000
Date:   Thu, 12 Jan 2023 17:21:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 0/8] hw/cxl: CXL emulation cleanups and minor fixes for
 upstream
Message-ID: <20230112172130.0000391b@Huawei.com>
In-Reply-To: <Y8AppXP+eP9cEz+i@memverge.com>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
        <Y8AppXP+eP9cEz+i@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 12 Jan 2023 10:39:17 -0500
Gregory Price <gregory.price@memverge.com> wrote:

> On Wed, Jan 11, 2023 at 02:24:32PM +0000, Jonathan Cameron via wrote:
> > Gregory's patches were posted as part of his work on adding volatile support.
> > https://lore.kernel.org/linux-cxl/20221006233702.18532-1-gregory.price@memverge.com/
> > https://lore.kernel.org/linux-cxl/20221128150157.97724-2-gregory.price@memverge.com/
> > I might propose this for upstream inclusion this cycle, but testing is
> > currently limited by lack of suitable kernel support.  
> 
> fwiw the testing i've done suggests the problem isn't necessarily the
> implementation so much as either the EFI support or the ACPI tables.
> 
> For example, we see memory expanders come up no problem and turn into
> volatile memory on real hardware, with the same kernels with just a few
> commands.  My gut feeling is that either a mailbox command is missing or
> that the ACPI tables are missing/significantly different.
> 
> I haven't been able to investigate further at this point, but that's my
> current state with the voltile type-3 device testing.

My assumption was that all shipping hardware platforms were doing the
enumeration and bring up of memory expanders in the BIOS / firmware.
Those are then presented to the OS already set up exactly as if they were
normal memory.  We could do the same on QEMU but that means a lot of
work in EDK2. Note that it makes no sense to do the enumeration and
creation of ACPI tables in QEMU itself though could hack it like that.
This stuff is done in firmware because that enables it for legacy
OSes. Everything is more or less presented to the OS like you would
present RAM (EFI memory map, ACPI tables etc).

Firmware enumeration doesn't typically support hotplug, so if we add
support for hotplug of volatile memory type 3 devices to the kernel
we will also be able to do 'cold plug' and have the kernel bring them up
in a similar fashion to what we do for non-volatile (for non volatile there
is typically no real support in firmware as there is a bunch of policy to
deal with that doesn't belong in firmware). (simplifying heavily ;)

So I don't think we are missing anything in the emulation, just in the
software layers above it.  Could be wrong though ;)

Jonathan


