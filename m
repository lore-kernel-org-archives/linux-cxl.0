Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C18C61DA3
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Feb 2023 15:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjBUPco (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 10:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjBUPcn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 10:32:43 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC102A9A3
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 07:32:41 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PLjsq0q7bz6J9fJ;
        Tue, 21 Feb 2023 23:30:39 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 21 Feb
 2023 15:32:38 +0000
Date:   Tue, 21 Feb 2023 15:32:37 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        <linux-cxl@vger.kernel.org>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 0/2] hw/mem: CXL Type-3 Volatile Memory Support
Message-ID: <20230221153237.000068d0@huawei.com>
In-Reply-To: <20230221140023.9315-1-Jonathan.Cameron@huawei.com>
References: <20230221140023.9315-1-Jonathan.Cameron@huawei.com>
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

On Tue, 21 Feb 2023 14:00:21 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> v3: Noticed whilst chasing an unrelated kernel bug.
>  - Drop setting of DVSEC range base addresses.  Whilst harmless,
>    expectation is that this will be 0 until the OS sets it (or uses
>    HDM decoders instead)
> 
> Based on following series (in order)
> 1. [PATCH v4 00/10] hw/cxl: CXL emulation cleanups and minor fixes for upstream
> 2. [PATCH v4 0/8] hw/cxl: RAS error emulation and injection

I sent these in the wrong order. Now v5 (comment change and some tags)
Other series unchanged.

> 3. [PATCH 0/2] hw/cxl: Passthrough HDM decoder emulation
> 
> Based on: Message-Id: 20230206172816.8201-1-Jonathan.Cameron@huawei.com
> Based-on: Message-id: 20230217172924.25239-1-Jonathan.Cameron@huawei.com

Based-on: Message-id: 20230221152145.9736-1-Jonathan.Cameron@huawei.com

> Based-on: Message-id: 20230125152703.9928-1-Jonathan.Cameron@huawei.com
> 
> Kernel code is queued up in kernel.org cxl/next for the merge window
> that just opened.
> 
> Now we have some kernel code to test this against (and it looks good)
> I'd like to propose this series for upstream following 3 other series
> already proposed for inclusion:
> 
> Original cover letter with minor updates.
> 
> This patches provides 2 features to the CXL Type-3 Device:
>     1) Volatile Memory Region Support
>     2) Multi-Region support (1 Volatile, 1 Persistent)
> 
> Summary of Changes per-commit:
> 1) Whitespace updates to docs and tests
> 2) Refactor CDAT DSMAS Initialization for multi-region initialization
>    Multi-Region and Volatile Memory support for CXL Type-3 Devices
>    Test and Documentation updates
> 
> The final patch in this series makes 6 major changes to the type-3
> device in order to implement multi-region and volatile region support
>     1) The HostMemoryBackend [hostmem] has been replaced by two
>        [hostvmem] and [hostpmem] to store volatile and persistent memory
>        respectively
>     2) The single AddressSpace has been replaced by two AddressSpaces
>        [hostvmem_as] and [hostpmem_as] to map respective memdevs.
>     3) Each memory region size and total region are stored separately
>     4) The CDAT and DVSEC memory map entries have been updated:
>        a) if vmem is present, vmem is mapped at DPA(0)
>        b) if pmem is present
>           i)  and vmem is present, pmem is mapped at DPA(vmem->size)
>           ii) else, pmem is mapped at DPA(0)
>        c) partitioning of pmem is not supported in this patch set but
>           has been discussed and this design should suffice.
>     5) Read/Write functions have been updated to access AddressSpaces
>        according to the mapping described in #4.  Access to the
>        persistent address space is calculated by (dpa-vmem_len)
>     6) cxl-mailbox has been updated to report the respective size of
>        volatile and persistent memory region
> 
> 
> Gregory Price (2):
>   tests/qtest/cxl-test: whitespace, line ending cleanup
>   hw/cxl: Multi-Region CXL Type-3 Devices (Volatile and Persistent)
> 
>  docs/system/devices/cxl.rst    |  49 ++++--
>  hw/cxl/cxl-mailbox-utils.c     |  26 +--
>  hw/mem/cxl_type3.c             | 294 +++++++++++++++++++++++++--------
>  include/hw/cxl/cxl_device.h    |  11 +-
>  tests/qtest/bios-tables-test.c |   8 +-
>  tests/qtest/cxl-test.c         | 146 +++++++++++-----
>  6 files changed, 392 insertions(+), 142 deletions(-)
> 

