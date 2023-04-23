Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1CAC6FD18
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 15:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjDWPaR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 11:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDWPaQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 11:30:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6B310E4
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 08:30:14 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q4Bvj5Jlbz6J6D1;
        Sun, 23 Apr 2023 23:27:13 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 23 Apr
 2023 16:30:11 +0100
Date:   Sun, 23 Apr 2023 16:30:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v13 0/9] CXL Poison List Retrieval & Tracing
Message-ID: <20230423163011.00004b45@huawei.com>
In-Reply-To: <cover.1681838291.git.alison.schofield@intel.com>
References: <cover.1681838291.git.alison.schofield@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 18 Apr 2023 10:39:00 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 

FWIW I've just been hammering the QEMU emulation for this to test a new
version of that, but as a side effect I hit ther corner cases with this as well and
it all looks good to me.

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> Changes in v13:
> - New Lead-in patches
> 	cxl/mbox: Deprecate poison commands (Dan)
> 	cxl/mbox: Restrict poison cmds to debugfs cxl_raw_allow_all
> 
> - New Patch: cxl/mbox: Initialize the poison state
>   Patch connects the lead-in patches with the rest of this set. Poison init
>   was previously done in the GET_POISON_LIST patch. With LIST deprecated,
>   needed a method, along with a reason, to discover device support. 
> 
> - cxl_poison_state_init(): use kvmalloc for potentially large payload (Dan)
> - cxl_poison_state_init() unset poison enabled bit on failure
> - trigger sysfs: make the core interface a proper api (Dan)
> - trigger sysfs: use down_read_interruptible (Dan)
> - Reorganize the by_endpoint work to make typesafe (Dan)
> - poison_by_decoder() only fill ctx when iteration is done
> - Remove mentions of mixed mode as a 'watch for'. Just say no. (Dan)
> - s/overflow_t/overflow_ts in cxlmem.h struct and trace.h struct (Dan)
> - Really remove errant line from cxl_memdev_visible() (Jonathan, DaveJ, Dan)
> 
> Link to v12:
> https://lore.kernel.org/linux-cxl/cover.1681159309.git.alison.schofield@intel.com/
> 
> Add support for retrieving device poison lists and store the returned
> error records as kernel trace events.
> 
> The handling of the poison list is guided by the CXL 3.0 Specification
> Section 8.2.9.8.4.1. [1] 
> 
> Example trigger:
> $ echo 1 > /sys/bus/cxl/devices/mem0/trigger_poison_list
> 
> Example Trace Events:
> 
> Poison found in a PMEM Region:
> cxl_poison: memdev=mem0 host=cxl_mem.0 serial=0 trace_type=List region=region11 region_uuid=d96e67ec-76b0-406f-8c35-5b52630dcad1 hpa=0xf100000000 dpa=0x70000000 dpa_length=0x40 source=Injected flags= overflow_time=0
> 
> Poison found in RAM Region:
> cxl_poison: memdev=mem0 host=cxl_mem.0 serial=0 trace_type=List region=region2 region_uuid=00000000-0000-0000-0000-000000000000 hpa=0xf010000000 dpa=0x0 dpa_length=0x40 source=Injected flags= overflow_time=0
> 
> Poison found in an unmapped DPA resource:
> cxl_poison: memdev=mem3 host=cxl_mem.3 serial=3 trace_type=List region= region_uuid=00000000-0000-0000-0000-000000000000 hpa=0xffffffffffffffff dpa=0x40000000 dpa_length=0x40 source=Injected flags= overflow_time=0
> 
> [1]: https://www.computeexpresslink.org/download-the-specification
> 
> Alison Schofield (8):
>   cxl/mbox: Restrict poison cmds to debugfs cxl_raw_allow_all
>   cxl/mbox: Initialize the poison state
>   cxl/mbox: Add GET_POISON_LIST mailbox command
>   cxl/trace: Add TRACE support for CXL media-error records
>   cxl/memdev: Add trigger_poison_list sysfs attribute
>   cxl/region: Provide region info to the cxl_poison trace event
>   cxl/trace: Add an HPA to cxl_poison trace events
>   tools/testing/cxl: Mock support for Get Poison List
> 
> Dan Williams (1):
>   cxl/mbox: Deprecate poison commands
> 
>  Documentation/ABI/testing/sysfs-bus-cxl |  14 +++
>  drivers/cxl/core/core.h                 |   9 ++
>  drivers/cxl/core/mbox.c                 | 150 ++++++++++++++++++++++--
>  drivers/cxl/core/memdev.c               |  54 +++++++++
>  drivers/cxl/core/region.c               | 124 ++++++++++++++++++++
>  drivers/cxl/core/trace.c                |  94 +++++++++++++++
>  drivers/cxl/core/trace.h                | 101 ++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  83 ++++++++++++-
>  drivers/cxl/mem.c                       |  43 +++++++
>  drivers/cxl/pci.c                       |   4 +
>  include/uapi/linux/cxl_mem.h            |  35 +++++-
>  tools/testing/cxl/test/mem.c            |  42 +++++++
>  12 files changed, 740 insertions(+), 13 deletions(-)
> 
> 
> base-commit: e686c32590f40bffc45f105c04c836ffad3e531a

