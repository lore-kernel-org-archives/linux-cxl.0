Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A85C48BDF
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Jun 2021 18:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E242D613F5
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Jun 2021 18:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFJS7e (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Jun 2021 14:59:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:35899 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhFJS7e (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 10 Jun 2021 14:59:34 -0400
IronPort-SDR: GqOjwPqR4VojBqaMgRDBRfeEotVTOw0Lp8GeG5Hkvm+SQ5H6o7tVaHAHhx0ad6OzZGRbY55fvf
 jAarIcHvSJdA==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="266527350"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="266527350"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 11:57:37 -0700
IronPort-SDR: gxv9jIHB7K/Gxg59D0UyGo6ecrV2Bbty0KmIhVlbIcMCEgxY8azBqx35THejsfD8oLKpZGGiko
 VunA2qbHWaXw==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="482963767"
Received: from millers-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.140.70])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 11:57:37 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 0/4] Region Creation
Date:   Thu, 10 Jun 2021 11:57:21 -0700
Message-Id: <20210610185725.897541-1-ben.widawsky@intel.com>
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

Introduced here is the basic mechanism to create and configure and delete a CXL
region. Configuring a region simply means giving it a size, offset within the
CFMWS window, UUID, and a target list. Enabling/activating a region, which
ultimately means programming the HDM decoders in the chain, is left for later
work.

The patches are only minimally tested so far in QEMU emulation and so x1
interleave is all that's supported.

Here is a sample topology (also in patch #4)

    decoder1.0
    ├── create_region
    ├── delete_region
    ├── devtype
    ├── locked
    ├── region1.0:0
    │   ├── offset
    │   ├── size
    │   ├── subsystem -> ../../../../../../../bus/cxl
    │   ├── target0
    │   ├── uevent
    │   ├── uuid
    │   └── verify
    ├── size
    ├── start
    ├── subsystem -> ../../../../../../bus/cxl
    ├── target_list
    ├── target_type
    └── uevent

Ben Widawsky (4):
  cxl/region: Add region creation ABI
  cxl/region: Create attribute structure / verify
  cxl: Move cxl_memdev conversion helper to mem.h
  cxl/region: Introduce concept of region configuration

 Documentation/ABI/testing/sysfs-bus-cxl       |  59 +++
 .../driver-api/cxl/memory-devices.rst         |   8 +
 drivers/cxl/Makefile                          |   2 +-
 drivers/cxl/core.c                            |  71 ++++
 drivers/cxl/cxl.h                             |  11 +
 drivers/cxl/mem.h                             |  26 ++
 drivers/cxl/pci.c                             |   5 -
 drivers/cxl/region.c                          | 400 ++++++++++++++++++
 8 files changed, 576 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cxl/region.c

-- 
2.32.0

