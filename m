Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F6AC6FD18
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 15:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjDWPnE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 11:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDWPnD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 11:43:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D1710E5
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 08:43:02 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q4CBT67w9z6J6st;
        Sun, 23 Apr 2023 23:40:01 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 23 Apr
 2023 16:43:00 +0100
Date:   Sun, 23 Apr 2023 16:42:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v6 0/10] cxl: CXL Inject & Clear Poison
Message-ID: <20230423164259.00006f8f@huawei.com>
In-Reply-To: <cover.1681874357.git.alison.schofield@intel.com>
References: <cover.1681874357.git.alison.schofield@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 18 Apr 2023 20:26:24 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Built on cxl/next plus [PATCH v13 0/9] CXL Poison List Retrieval & Tracing
> https://lore.kernel.org/linux-cxl/cover.1681838291.git.alison.schofield@intel.com/

For 1-5 given I've poking them from QEMU whilst testing the emulation and
it all worked well.

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com.
> 
> Changes in v6:
> - Drop patches: The deprecate, and the removal of raw access, introduced
>   for all poison commands in v13 of CXL Poison List Retrieval & Tracing,
>   made these 2 patches obsolete:
> 	cxl/memdev: Make inject and clear poison cmds kernel exclusive
> 	cxl/mbox: Block inject and clear poison opcodes in raw mode
> 
> - The device always writes the write data on Clear, regardless of whether or
>   not the address is actually poisoned. Stop stating otherwise. (Jonathan)
> - Update Patch 1 commit message to refer to CXL.mem driver (DaveJ)
> - __cxl_dpa_to_region() Stop the walk on a match (Jonathan)
> - Set & use cxlds->poison.enabled_cmds for inject & clear
> - Simplify inject payload address assignment (DaveJ)
> - Use down_read_interruptible in inject/clear 
> - Tidy up the memdev core api for inject/clear by using cxl_memdev
> - Use the available cxl_memdev rather than dev in debugfs_create_file()
> 
> Link to v5:
> https://lore.kernel.org/linux-cxl/cover.1679892337.git.alison.schofield@intel.com/
> 
> 
> Introducing Inject and Clear Poison support for CXL Devices.
> 
> These are optional commands, meaning not all CXL devices must support
> them. The debugfs attributes, inject_poison and clear_poison, are only
> visible for devices reporting support of the capability.
> 
> Example:
> # echo 0x40000000 > /sys/kernel/debug/cxl/mem1/inject_poison
> 
> cxl_poison: memdev=mem1 pcidev=cxl_mem.1 trace_type=Inject region= region_uuid=00000000-0000-0000-0000-000000000000 hpa=0xffffffffffffffff dpa=0x40000000 dpa_length=0x40 source=Unknown flags= overflow_time=0
> 
> Example in which the injected poison landed in region5:
> # echo 0x40000000 > /sys/kernel/debug/cxl/mem0/inject_poison
> 
> cxl_poison: memdev=mem0 host=cxl_mem.0 serial=0 trace_type=Inject region=region5 region_uuid=cfcfc13a-5290-4983-aa74-4c8465c25f26 hpa=0xf110000000 dpa=0x40000000 dpa_length=0x40 source=Unknown flags= overflow_time=0
> 
> 
> Alison Schofield (10):
>   cxl/memdev: Add support for the Inject Poison mailbox command
>   cxl/memdev: Add support for the Clear Poison mailbox command
>   cxl/memdev: Warn of poison inject or clear to a mapped region
>   cxl/memdev: Trace inject and clear poison as cxl_poison events
>   cxl/mem: Add debugfs attributes for poison inject and clear
>   tools/testing/cxl: Mock the Inject Poison mailbox command
>   tools/testing/cxl: Mock the Clear Poison mailbox command
>   tools/testing/cxl: Use injected poison for get poison list
>   tools/testing/cxl: Add a sysfs attr to test poison inject limits
>   tools/testing/cxl: Require CONFIG_DEBUG_FS
> 
>  Documentation/ABI/testing/debugfs-cxl |  35 +++++
>  drivers/cxl/core/core.h               |   2 +
>  drivers/cxl/core/memdev.c             | 172 ++++++++++++++++++++
>  drivers/cxl/core/trace.h              |   8 +-
>  drivers/cxl/cxlmem.h                  |  13 ++
>  drivers/cxl/mem.c                     |  28 ++++
>  tools/testing/cxl/config_check.c      |   1 +
>  tools/testing/cxl/test/mem.c          | 216 +++++++++++++++++++++++---
>  8 files changed, 453 insertions(+), 22 deletions(-)
>  create mode 100644 Documentation/ABI/testing/debugfs-cxl
> 

