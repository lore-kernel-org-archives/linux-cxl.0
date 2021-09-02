Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BB3C433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B10FE61053
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhIBTv2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 15:51:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:41966 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231467AbhIBTvY (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 2 Sep 2021 15:51:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="198778193"
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="198778193"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:23 -0700
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="533451602"
Received: from kappusam-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:21 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 00/13] Enumerate midlevel and endpoint decoders
Date:   Thu,  2 Sep 2021 12:50:04 -0700
Message-Id: <20210902195017.2516472-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Every CXL component may implement component registers as defined by the CXL 2.0
specification. In preparation for creating and enumerating regions it's
important to at least enumerate all HDM decoders which are a subset of the
component registers. To do this, a new cxl_mem driver is introduced which is
responsible for binding to a CXL.mem enabled device. In order to determine
whether or not an endpoint is CXL enabled, the relevant subhierarchy must be
enumerated.

This serves as the stepping stone toward enabling regions because regions must
be able to determine if the devices selected for the region are CXL.mem capable
and enabled.

There's two issues that need to be resolved but I'm going to propose we fix
them next time we need to touch this code...
1. cxl_pci now relinquishes its component register mappings. This may be
   undesirable as cxl_pci may need to use those mappings.
2a. some amount of component register enumeration is duplicated in cxl_pci and
    cxl_mem
2b. awkwardness in cxl_mem where memdevs get their component registers from
   cxl_pci, and ports that enumerate their own component registers

The obvious fix for both of these is to move component register mapping to
cxl_core, and let cxl_core arbitrate the mappings for the "client" drivers.
Since the code needed to enable cxl_mem was small and subset of the existing
code (and fairly error resistent vs creating a cxl_core API) I'm hoping to kick
the can down the road.

NOTE: I do not have a way at present to test switches. For this reason and for
patch readability, the switch enumeration is left as a separate patch.

NOTE2: Some of these patches were introduced in an RFC for region creation. Upon
further inspection, it made a lot of sense to land these before region creation
so long as it's understood upfront why the new driver is needed.

I've pushed this to my gitlab here:
https://gitlab.com/bwidawsk/linux/-/tree/decoders

Ben Widawsky (13):
  Documentation/cxl: Add bus internal docs
  cxl/core/bus: Add kernel docs for decoder ops
  cxl/core: Ignore interleave when adding decoders
  cxl: Introduce endpoint decoders
  cxl/pci: Disambiguate cxl_pci further from cxl_mem
  cxl/mem: Introduce cxl_mem driver
  cxl/memdev: Determine CXL.mem capability
  cxl/mem: Add memdev as a port
  cxl/pci: Retain map information in cxl_mem_probe
  cxl/core: Map component registers for ports
  cxl/core: Convert decoder range to resource
  cxl/core/bus: Enumerate all HDM decoders
  cxl/mem: Enumerate switch decoders

 .../driver-api/cxl/memory-devices.rst         |   6 +
 drivers/cxl/Makefile                          |   3 +-
 drivers/cxl/acpi.c                            |  39 +--
 drivers/cxl/core/bus.c                        | 326 +++++++++++++++++-
 drivers/cxl/core/core.h                       |   1 +
 drivers/cxl/core/memdev.c                     |  19 +-
 drivers/cxl/core/regs.c                       |   6 +-
 drivers/cxl/cxl.h                             |  65 +++-
 drivers/cxl/cxlmem.h                          |   6 +-
 drivers/cxl/mem.c                             | 237 +++++++++++++
 drivers/cxl/pci.c                             | 124 +++----
 drivers/cxl/pci.h                             |  15 +-
 12 files changed, 727 insertions(+), 120 deletions(-)
 create mode 100644 drivers/cxl/mem.c

-- 
2.33.0

