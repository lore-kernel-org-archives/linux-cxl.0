Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845CEC38142
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 17:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjAWRNI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 12:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjAWRNH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 12:13:07 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FF2EF9B
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 09:13:04 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P0xRc6G43z6J6C2;
        Tue, 24 Jan 2023 01:09:48 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 23 Jan
 2023 17:13:02 +0000
Date:   Mon, 23 Jan 2023 17:13:01 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] cxl: CXL Inject & Clear Poison
Message-ID: <20230123171301.000071ba@huawei.com>
In-Reply-To: <cover.1674101475.git.alison.schofield@intel.com>
References: <cover.1674101475.git.alison.schofield@intel.com>
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

On Wed, 18 Jan 2023 21:00:15 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Built on cxl/next plus Patchset: CXL Poison List Retrieval & Tracing:
> https://lore.kernel.org/linux-cxl/de11785ff05844299b40b100f8e0f56c7eef7f08.1674070170.git.alison.schofield@intel.com/

Only tangentially relevant, but I've only just registered
as a result of getting a lot of 0 timestamps (which is what
you return if the timestamp base is unknown) that I don't
think we currently ever set the EP timestamp.

Recommendation in the spec (8.2.9.4.2) is:
"It is recommended that the host set hte timestamp
after ever Conventional or CXL Reset"

I'd go further and assume that if we are doing native error
handling then it's up to the OS to initialize the timestamp.

Also relevant to Ira's series as events are timestamped.
Currently Ira's QEMU code doesn't take this subtlety into
account (poison doesn't either - but I have patches).

Jonathan


> 
> Changes in v2:
> - Add Jonathan Reviewed-by tags to Patches 1,2,4
> - Clean up input payload structs for both inject and clear (Dan)
> - Commit message cleanups, including spec references (Dave)
> - Use CXL_POISON_LEN_MULT in define of clear write data
> - Use IS_ALIGNED() for 64byte align check (Dan)
> - Add Kconfig CXL_POISON_INJECT  (Dan)
> - Trivial space cleanup (Jonathan)
> - Doc/ABI cleanup (Dave, Dan)
> - Mock: Only use injected errors for get poison list
> - Mock: Use 'POISONLMT -ENXIO' text from CMD_CMD_RC_TABLE  (Jonathan)
> - Mock: Add Patch 6/6: A module param to mock device inject limit
> 
> Link to v1: https://lore.kernel.org/linux-cxl/cover.1669781852.git.alison.schofield@intel.com/
> 
> Introducing Inject and Clear Poison support for CXL Devices.
> 
> These are optional commands, meaning not all CXL devices must support
> them. The sysfs attributes, inject_poison and clear_poison, are only
> visible for devices reporting support of the capability and when the
> kernel Kconfig option CONFIG_CXL_POISON_INJECT is on. (Default: off)
> 
> Example:
> # echo 0x40000000 > /sys/bus/cxl/devices/mem1/inject_poison
> # echo 1 > /sys/bus/cxl/devices/mem1/trigger_poison_list
> 
> cxl_poison: memdev=mem1 pcidev=cxl_mem.1 region= region_uuid=00000000-0000-0000-0000-000000000000 hpa=0xffffffffffffffff dpa=0x40000000 length=0x40 source=Injected flags= overflow_time=0
> 
> 
> Alison Schofield (6):
>   cxl/memdev: Add support for the Inject Poison mailbox command
>   cxl/memdev: Add support for the Clear Poison mailbox command
>   tools/testing/cxl: Mock the Inject Poison mailbox command
>   tools/testing/cxl: Mock the Clear Poison mailbox command
>   tools/testing/cxl: Use injected poison for get poison list
>   tools/testing/cxl: Add a param to test poison injection limits
> 
>  Documentation/ABI/testing/sysfs-bus-cxl |  40 ++++++
>  drivers/cxl/Kconfig                     |  10 ++
>  drivers/cxl/core/memdev.c               | 122 ++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  11 ++
>  tools/testing/cxl/test/mem.c            | 178 +++++++++++++++++++++---
>  5 files changed, 341 insertions(+), 20 deletions(-)
> 

