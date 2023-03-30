Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1806C6FD1D
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 17:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjC3RpW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 13:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjC3RpT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 13:45:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37388EC58
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 10:45:17 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnW454tGLz6J7Cy;
        Fri, 31 Mar 2023 01:43:33 +0800 (CST)
Received: from localhost (10.48.159.148) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 18:45:14 +0100
Date:   Thu, 30 Mar 2023 18:45:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v11 0/6] CXL Poison List Retrieval & Tracing
Message-ID: <20230330184514.000011ac@Huawei.com>
In-Reply-To: <cover.1679888450.git.alison.schofield@intel.com>
References: <cover.1679888450.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.159.148]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 26 Mar 2023 22:02:06 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>

FYI, I took a glance at the changes since v9 and this looks good to me.

Jonathan

> 
> Changes in v11:
> - Introduce the hpa field in TP_printk in Patch5, not Patch2. (0-day)
> - cxl_trigger_poison_list() make rc ssize_t
> - trace naming: s/LIST/List, s/type/trace_type
> 
> Link to v10:
> https://lore.kernel.org/linux-cxl/cover.1679448904.git.alison.schofield@intel.com/
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
> Alison Schofield (6):
>   cxl/mbox: Add GET_POISON_LIST mailbox command
>   cxl/trace: Add TRACE support for CXL media-error records
>   cxl/memdev: Add trigger_poison_list sysfs attribute
>   cxl/region: Provide region info to the cxl_poison trace event
>   cxl/trace: Add an HPA to cxl_poison trace events
>   tools/testing/cxl: Mock support for Get Poison List
> 
>  Documentation/ABI/testing/sysfs-bus-cxl |  14 +++
>  drivers/cxl/core/core.h                 |  15 ++++
>  drivers/cxl/core/mbox.c                 |  75 ++++++++++++++++
>  drivers/cxl/core/memdev.c               | 108 ++++++++++++++++++++++++
>  drivers/cxl/core/region.c               |  63 ++++++++++++++
>  drivers/cxl/core/trace.c                |  94 +++++++++++++++++++++
>  drivers/cxl/core/trace.h                | 101 ++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  72 +++++++++++++++-
>  drivers/cxl/mem.c                       |  36 ++++++++
>  drivers/cxl/pci.c                       |   4 +
>  tools/testing/cxl/test/mem.c            |  42 +++++++++
>  11 files changed, 623 insertions(+), 1 deletion(-)
> 
> 
> base-commit: e686c32590f40bffc45f105c04c836ffad3e531a

