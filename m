Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65A2C2B9F4
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 17:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC59613CA
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 17:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhFQRku (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:40:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:2462 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232604AbhFQRjM (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 17 Jun 2021 13:39:12 -0400
IronPort-SDR: /pa9FfS6Kdd2yb+IhOQSNFBTwNyDLIi0UOFE6vz+gK72scLRQcgaHzMxcQ/g2qPU8zonPOIRfe
 pxSsOHsRSn/Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193732187"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="193732187"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 10:37:03 -0700
IronPort-SDR: SL7X9UZMXA/S5FJv/Oj0931ZnO7p2yz5xchYrj15vbKng0UP89hTCPfer5UGUl0fg4bqJF1vOq
 gBB4hicCS/TA==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="421944096"
Received: from mkalyani-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.30])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 10:37:03 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/6] Region creation
Date:   Thu, 17 Jun 2021 10:36:49 -0700
Message-Id: <20210617173655.430424-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL interleave sets and non-interleave sets are described via regions. A region
is specified in the CXL 2.0 specification and the purpose is to create a
standardized way to preserve the region across reboots.

Introduced here is the basic mechanism to create configure and delete a CXL
region. Configuring a region simply means giving it a size, UUID, and a target
list. Enabling/activating a region is comprised of three parts:
1. Validate and find space for the region in the CFMWS (included here)
2. Program the HDM decoders (WIP)
3. Adding the region label to the LSA (Dan WIP)

Here is a sample topology

    decoder1.0
    ├── create_region
    ├── delete_region
    ├── devtype
    ├── locked
    ├── region1.0:0
    │   ├── offset
    │   ├── size
    │   ├── subsystem -> ../../../../../../../bus/cxl
    │   ├── target0
    │   ├── uevent
    │   ├── uuid
    │   └── verify
    ├── size
    ├── start
    ├── subsystem -> ../../../../../../bus/cxl
    ├── target_list
    ├── target_type
    └── uevent

Next Steps.
Next task is to create a CXL memory driver which will enumerate CXL capable
endpoints. A CXL capable endpoint is similar to the existing cxl_mem structure
except that it's known that there exists a path from a hostbridge down to the
endpoint that is CXL.mem capable. Once that path is established, the HDM decoder
programming can be determined from top of the hierarchy down.

Ben Widawsky (6):
  cxl/region: Add region creation ABI
  cxl: Move cxl_memdev conversion helper to mem.h
  cxl/region: Introduce concept of region configuration
  cxl/region: Introduce a cxl_region driver
  cxl/core: Convert decoder range to resource
  cxl/region: Handle region's address space allocation

 Documentation/ABI/testing/sysfs-bus-cxl       |  53 ++
 .../driver-api/cxl/memory-devices.rst         |  11 +
 drivers/cxl/Makefile                          |   5 +-
 drivers/cxl/core.c                            | 108 +++-
 drivers/cxl/cxl.h                             |  18 +-
 drivers/cxl/mem.h                             |   6 +
 drivers/cxl/pci.c                             |   5 -
 drivers/cxl/region.c                          | 492 ++++++++++++++++++
 drivers/cxl/region.h                          |  45 ++
 drivers/cxl/trace.h                           |  33 ++
 10 files changed, 760 insertions(+), 16 deletions(-)
 create mode 100644 drivers/cxl/region.c
 create mode 100644 drivers/cxl/region.h
 create mode 100644 drivers/cxl/trace.h

-- 
2.32.0

