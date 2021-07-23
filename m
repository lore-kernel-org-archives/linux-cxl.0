Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7B2C4320A
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CCD60F23
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jul 2021 21:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhGWU0I (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:26:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:34287 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231684AbhGWU0E (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 23 Jul 2021 16:26:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211671183"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211671183"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:35 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="497436107"
Received: from rfrederi-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.136.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:06:34 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH RFCish 00/23] cxl_region and cxl_memdev drivers
Date:   Fri, 23 Jul 2021 14:06:00 -0700
Message-Id: <20210723210623.114073-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


I will be going on vacation for the next two weeks so I'm sending out everything
I have, even though it's not fully baked so that folks who might want to
continue it while I'm gone, can do so. Many of these patches have already been
sent as separate series, or RFC.

The ultimate goal of this series is to create two new driver types, cxl_region,
and cxl_memdev. The cxl_region driver is responsible for region creation and
configuration, and the cxl_memdev driver is responsible for handling the CXL
specific (non-PCI) parts of CXL endpoints. In order to establish that in a clean
way, the cxl_core driver needed quite a bit of rework. The next step is to
complete the HDM decoder programming.

What's specifically not fully baked is the cxl_pci driver claims part of the
component register space, but the cxl_memdev driver also wants this resource.
Better coordination here needs to happen, most likely the cxl_pci driver must
relinquish any resources it won't be needing. Some of the patches started to
enable making that easy, but it's not complete and as a result I believe these
patches will OOPS (there may be other issues as well).

If you feel like reviewing any of these patches, that'd be great, but I'm
equally happy to resubmit when I'm back and have things fully working.

Patch breakdown
1-11: cxl_core reorganization
12-18: cxl_region driver
19-23: cxl_memdev driver

These patches can be obtained from my gitlab as well:
https://gitlab.com/bwidawsk/linux/-/tree/cxl_memdrver2

Ben Widawsky (23):
  cxl: Move cxl_core to new directory
  cxl/core: Improve CXL core kernel docs
  cxl/core: Extract register and pmem functionality
  cxl/mem: Move character device region creation
  cxl: Pass fops and shutdown to memdev creation
  cxl/core: Move memdev management to core
  cxl/pci: Ignore unknown register block types
  cxl/pci: Simplify register setup
  cxl/pci: Retain map information in cxl_mem_probe
  cxl/decoder: Support parentless decoders
  cxl: Enable an endpoint decoder type
  cxl/region: Add region creation ABI
  cxl/region: Introduce concept of region configuration
  cxl: Convert driver id to an enum
  cxl/region: Introduce a cxl_region driver
  cxl/core: Convert decoder range to resource
  cxl/region: Handle region's address space allocation
  cxl/region: Only allow CXL capable targets
  cxl/mem: Introduce CXL mem driver
  cxl/memdev: Determine CXL.mem capability
  cxl/mem: Check that the device is CXL.mem capable
  cxl/mem: Add device as a port
  cxl/core: Map component registers for ports

 Documentation/ABI/testing/sysfs-bus-cxl       |  53 ++
 .../driver-api/cxl/memory-devices.rst         |  25 +-
 drivers/cxl/Makefile                          |   9 +-
 drivers/cxl/acpi.c                            |  44 +-
 drivers/cxl/core/Makefile                     |   5 +
 drivers/cxl/{core.c => core/bus.c}            | 711 +++++++-----------
 drivers/cxl/core/core.h                       |  22 +
 drivers/cxl/core/memdev.c                     | 230 ++++++
 drivers/cxl/core/pmem.c                       | 201 +++++
 drivers/cxl/core/region.c                     | 389 ++++++++++
 drivers/cxl/core/regs.c                       | 235 ++++++
 drivers/cxl/cxl.h                             |  67 +-
 drivers/cxl/mem.c                             |  94 +++
 drivers/cxl/mem.h                             |  19 +
 drivers/cxl/pci.c                             | 325 ++------
 drivers/cxl/pci.h                             |   8 +-
 drivers/cxl/region.c                          | 134 ++++
 drivers/cxl/region.h                          |  34 +
 drivers/cxl/trace.h                           |  33 +
 19 files changed, 1867 insertions(+), 771 deletions(-)
 create mode 100644 drivers/cxl/core/Makefile
 rename drivers/cxl/{core.c => core/bus.c} (55%)
 create mode 100644 drivers/cxl/core/core.h
 create mode 100644 drivers/cxl/core/memdev.c
 create mode 100644 drivers/cxl/core/pmem.c
 create mode 100644 drivers/cxl/core/region.c
 create mode 100644 drivers/cxl/core/regs.c
 create mode 100644 drivers/cxl/mem.c
 create mode 100644 drivers/cxl/region.c
 create mode 100644 drivers/cxl/region.h
 create mode 100644 drivers/cxl/trace.h

-- 
2.32.0

