Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A08C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 09:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJKJkg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 05:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiJKJkO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 05:40:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FC640BCB
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 02:40:11 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MmrLz5LJvz6H75x;
        Tue, 11 Oct 2022 17:38:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 11:40:08 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 11 Oct
 2022 10:40:07 +0100
Date:   Tue, 11 Oct 2022 10:40:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <ira.weiny@intel.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 0/6] QEMU CXL Provide mock CXL events and irq
 support
Message-ID: <20221011104006.0000217f@huawei.com>
In-Reply-To: <20221010222944.3923556-1-ira.weiny@intel.com>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 10 Oct 2022 15:29:38 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL Event records inform the OS of various CXL device events.  Thus far CXL
> memory devices are emulated and therefore don't naturally have events which
> will occur.
> 
> Add mock events and a HMP trigger mechanism to facilitate guest OS testing of
> event support.
> 
> This support requires a follow on version of the event patch set.  The RFC was
> submitted and discussed here:
> 
> 	https://lore.kernel.org/linux-cxl/20220813053243.757363-1-ira.weiny@intel.com/
> 
> I'll post the lore link to the new version shortly.
> 
> Instructions for running this test.
> 
> Add qmp option to qemu:
> 
> 	<host> $ qemu-system-x86_64 ... -qmp unix:/tmp/run_qemu_qmp_0,server,nowait ...
> 
> 	OR
> 
> 	<host> $ run_qemu.sh ... --qmp ...
> 
> Enable tracing of events within the guest:
> 
> 	<guest> $ echo "" > /sys/kernel/tracing/trace
> 	<guest> $ echo 1 > /sys/kernel/tracing/events/cxl/enable
> 	<guest> $ echo 1 > /sys/kernel/tracing/tracing_on
> 
> Trigger event generation and interrupts in the host:
> 
> 	<host> $ echo "cxl_event_inject cxl-devX" | qmp-shell -H /tmp/run_qemu_qmp_0
> 
> 	Where X == one of the memory devices; cxl-dev0 should work.
> 
> View events on the guest:
> 
> 	<guest> $ cat /sys/kernel/tracing/trace

Hi Ira,

Why is this an RFC rather than a patch set to apply?

It's useful to have that in the cover letter so we can focus on what
you want comments on (rather than simply review).

Thanks,

Jonathan

> 
> 
> Ira Weiny (6):
>   qemu/bswap: Add const_le64()
>   qemu/uuid: Add UUID static initializer
>   hw/cxl/cxl-events: Add CXL mock events
>   hw/cxl/mailbox: Wire up get/clear event mailbox commands
>   hw/cxl/cxl-events: Add event interrupt support
>   hw/cxl/mailbox: Wire up Get/Set Event Interrupt policy
> 
>  hmp-commands.hx             |  14 ++
>  hw/cxl/cxl-device-utils.c   |   1 +
>  hw/cxl/cxl-events.c         | 330 ++++++++++++++++++++++++++++++++++++
>  hw/cxl/cxl-host-stubs.c     |   5 +
>  hw/cxl/cxl-mailbox-utils.c  | 224 +++++++++++++++++++++---
>  hw/cxl/meson.build          |   1 +
>  hw/mem/cxl_type3.c          |   7 +-
>  include/hw/cxl/cxl_device.h |  22 +++
>  include/hw/cxl/cxl_events.h | 194 +++++++++++++++++++++
>  include/qemu/bswap.h        |  10 ++
>  include/qemu/uuid.h         |  12 ++
>  include/sysemu/sysemu.h     |   3 +
>  12 files changed, 802 insertions(+), 21 deletions(-)
>  create mode 100644 hw/cxl/cxl-events.c
>  create mode 100644 include/hw/cxl/cxl_events.h
> 
> 
> base-commit: 6f7f81898e4437ea544ee4ca24bef7ec543b1f06

