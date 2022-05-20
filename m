Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F946C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 20 May 2022 16:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351564AbiETQXg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 May 2022 12:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344508AbiETQXa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 May 2022 12:23:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F4D17CE57
        for <linux-cxl@vger.kernel.org>; Fri, 20 May 2022 09:23:29 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L4X472XlWz67xxK;
        Sat, 21 May 2022 00:19:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 18:23:27 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 20 May
 2022 17:23:26 +0100
Date:   Fri, 20 May 2022 17:23:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <nvdimm@lists.linux.dev>, <patches@lists.linux.dev>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 00/15] Region driver
Message-ID: <20220520172325.000043d8@huawei.com>
In-Reply-To: <20220413183720.2444089-1-ben.widawsky@intel.com>
References: <20220413183720.2444089-1-ben.widawsky@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 13 Apr 2022 11:37:05 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Spring cleaning is here and we're starting fresh so I won't be referencing
> previous postings and I've removed revision history from commit messages.
> 
> This patch series introduces the CXL region driver as well as associated APIs in
> CXL core to create and configure regions. Regions are defined by the CXL 2.0
> specification [1], a summary follows.
> 
> A region surfaces a swath of RAM (persistent or volatile) that appears as normal
> memory to the operating system. The memory, unless programmed by BIOS, or a
> previous Operating System, is inaccessible until the CXL driver creates a region
> for it.A region may be strided (interleave granularity) across multiple devices
> (interleave ways). The interleaving may traverse multiple levels of the CXL
> hierarchy.
> 
> +-------------------------+      +-------------------------+
> |                         |      |                         |
> |   CXL 2.0 Host Bridge   |      |   CXL 2.0 Host Bridge   |
> |                         |      |                         |
> |  +------+     +------+  |      |  +------+     +------+  |
> |  |  RP  |     |  RP  |  |      |  |  RP  |     |  RP  |  |
> +--+------+-----+------+--+      +--+------+-----+------+--+
>       |            |                   |               \--
>       |            |                   |        +-------+-\--+------+
>    +------+    +-------+            +-------+   |       |USP |      |
>    |Type 3|    |Type 3 |            |Type 3 |   |       +----+      |
>    |Device|    |Device |            |Device |   |     CXL Switch    |
>    +------+    +-------+            +-------+   | +----+     +----+ |
>                                                 | |DSP |     |DSP | |
>                                                 +-+-|--+-----+-|--+-+
>                                                     |          |
>                                                 +------+    +-------+
>                                                 |Type 3|    |Type 3 |
>                                                 |Device|    |Device |
>                                                 +------+    +-------+
> 
> Region verification and programming state are owned by the cxl_region driver
> (implemented in the cxl_region module). Much of the region driver is an
> implementation of algorithms described in the CXL Type 3 Memory Device Software
> Guide [2].
> 
> The region driver is responsible for configuring regions found on persistent
> capacities in the Label Storage Area (LSA), it will also enumerate regions
> configured by BIOS, usually volatile capacities, and will allow for dynamic
> region creation (which can then be stored in the LSA). Only dynamically created
> regions are implemented thus far.
> 
> Dan has previously stated that he doesn't want to merge ABI until the whole
> series is posted and reviewed, to make sure we have no gaps. As such, the goal
> of posting this series is *not* to discuss the ABI specifically, feedback is of
> course welcome. In other wordsIt has been discussed previously. The goal is to find
> architectural flaws in the implementation of the ABI that may pose problematic
> for cases we haven't yet conceived.
> 
> Since region creation is done via sysfs, it is left to userspace to prevent
> racing for resource usage. Here is an overview for creating a x1 256M
> dynamically created region programming to be used by userspace clients. In this
> example, the following topology is used (cropped for brevity):
> /sys/bus/cxl/devices/
> ├── decoder0.0 -> ../../../devices/platform/ACPI0017:00/root0/decoder0.0
> ├── decoder0.1 -> ../../../devices/platform/ACPI0017:00/root0/decoder0.1
> ├── decoder1.0 -> ../../../devices/platform/ACPI0017:00/root0/port1/decoder1.0
> ├── decoder2.0 -> ../../../devices/platform/ACPI0017:00/root0/port2/decoder2.0
> ├── decoder3.0 -> ../../../devices/platform/ACPI0017:00/root0/port1/endpoint3/decoder3.0
> ├── decoder4.0 -> ../../../devices/platform/ACPI0017:00/root0/port2/endpoint4/decoder4.0
> ├── decoder5.0 -> ../../../devices/platform/ACPI0017:00/root0/port1/endpoint5/decoder5.0
> ├── decoder6.0 -> ../../../devices/platform/ACPI0017:00/root0/port2/endpoint6/decoder6.0
> ├── endpoint3 -> ../../../devices/platform/ACPI0017:00/root0/port1/endpoint3
> ├── endpoint4 -> ../../../devices/platform/ACPI0017:00/root0/port2/endpoint4
> ├── endpoint5 -> ../../../devices/platform/ACPI0017:00/root0/port1/endpoint5
> ├── endpoint6 -> ../../../devices/platform/ACPI0017:00/root0/port2/endpoint6
> ...
> 
> 1. Select a Root Decoder whose interleave spans the desired interleave config
>    - devices, IG, IW, Large enough address space.
>    - ie. pick decoder0.0
> 2. Program the decoders for the endpoints comprising the interleave set.
>    - ie. echo $((256 << 20)) > /sys/bus/cxl/devices/decoder3.0
> 3. Create a region
>    - ie. echo $(cat create_pmem_region) >| create_pmem_region
> 4. Configure a region
>    - ie. echo 256 >| interleave_granularity
> 	 echo 1 >| interleave_ways
> 	 echo $((256 << 20)) >| size
> 	 echo decoder3.0 >| target0
> 5. Bind the region driver to the region
>    - ie. echo region0 > /sys/bus/cxl/drivers/cxl_region/bind
> 
Hi Ben,

I finally got around to actually trying this out on top of Dan's recent fix set
(I rebased it from the cxl/preview branch on kernel.org).

I'm not having much luck actually bring up a region.

The patch set refers to configuring the end point decoders, but all their
sysfs attributes are read only.  Am I missing a dependency somewhere or
is the intent that this series is part of the solution only?

I'm confused!

Jonathan

> 
> [1]: https://www.computeexpresslink.org/download-the-specification
> [2]: https://cdrdv2.intel.com/v1/dl/getContent/643805?wapkw=CXL%20memory%20device%20sw%20guide
> 
> Ben Widawsky (15):
>   cxl/core: Use is_endpoint_decoder
>   cxl/core/hdm: Bail on endpoint init fail
>   Revert "cxl/core: Convert decoder range to resource"
>   cxl/core: Create distinct decoder structs
>   cxl/acpi: Reserve CXL resources from request_free_mem_region
>   cxl/acpi: Manage root decoder's address space
>   cxl/port: Surface ram and pmem resources
>   cxl/core/hdm: Allocate resources from the media
>   cxl/core/port: Add attrs for size and volatility
>   cxl/core: Extract IW/IG decoding
>   cxl/acpi: Use common IW/IG decoding
>   cxl/region: Add region creation ABI
>   cxl/core/port: Add attrs for root ways & granularity
>   cxl/region: Introduce configuration
>   cxl/region: Introduce a cxl_region driver
> 
>  Documentation/ABI/testing/sysfs-bus-cxl       |  96 ++-
>  .../driver-api/cxl/memory-devices.rst         |  14 +
>  drivers/cxl/Kconfig                           |  10 +
>  drivers/cxl/Makefile                          |   2 +
>  drivers/cxl/acpi.c                            |  83 ++-
>  drivers/cxl/core/Makefile                     |   1 +
>  drivers/cxl/core/core.h                       |   4 +
>  drivers/cxl/core/hdm.c                        |  44 +-
>  drivers/cxl/core/port.c                       | 363 ++++++++--
>  drivers/cxl/core/region.c                     | 669 ++++++++++++++++++
>  drivers/cxl/cxl.h                             | 168 ++++-
>  drivers/cxl/mem.c                             |   7 +-
>  drivers/cxl/region.c                          | 333 +++++++++
>  drivers/cxl/region.h                          | 105 +++
>  include/linux/ioport.h                        |   1 +
>  kernel/resource.c                             |  11 +-
>  tools/testing/cxl/Kbuild                      |   1 +
>  tools/testing/cxl/test/cxl.c                  |   2 +-
>  18 files changed, 1810 insertions(+), 104 deletions(-)
>  create mode 100644 drivers/cxl/core/region.c
>  create mode 100644 drivers/cxl/region.c
>  create mode 100644 drivers/cxl/region.h
> 
> 
> base-commit: 7dc1d11d7abae52aada5340fb98885f0ddbb7c37

