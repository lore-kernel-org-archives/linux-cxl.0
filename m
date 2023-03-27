Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD77C7619A
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Mar 2023 05:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjC0FCT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 01:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC0FCS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 01:02:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FBA3A8C
        for <linux-cxl@vger.kernel.org>; Sun, 26 Mar 2023 22:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679893336; x=1711429336;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JtR7tUq24AqDBgnohqTIjjPWYu2rTy9ajWFW/HnFhr0=;
  b=DuCDp/hBIl/poAwMPG2WVuW3E4ECatj3vzoLLSjaxcPdhGCQlCx+vPOc
   bFMCj0SupEegU4ftvUFguKtJg4p/bznYUTKhLwt/GaagmCUE1MhZnSBGy
   +tN6MIVUjsCGbZFr+PyzRQM9/y46Kbv0U8WEkKRR2hCTmyqdac7v/XXaE
   8N8mGlK37H4q3VXOIIpGAZoqSscJ5gniQuYjBwOABQ+VrYhiIKERP6pso
   WgaLrnXcpF7oEenLNfrWypR5g0GdN3aZlHsf0IOiGxY4DTqmVzRr2QJ2v
   SAa4d4uxChABvDhesMyoGFLms4tfDt0uWGBZ0MINhotOjmcVeIVl62UrT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="341753839"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="341753839"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="747856138"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="747856138"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.227.2])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:02:15 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v11 0/6] CXL Poison List Retrieval & Tracing
Date:   Sun, 26 Mar 2023 22:02:06 -0700
Message-Id: <cover.1679888450.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Changes in v11:
- Introduce the hpa field in TP_printk in Patch5, not Patch2. (0-day)
- cxl_trigger_poison_list() make rc ssize_t
- trace naming: s/LIST/List, s/type/trace_type

Link to v10:
https://lore.kernel.org/linux-cxl/cover.1679448904.git.alison.schofield@intel.com/

Add support for retrieving device poison lists and store the returned
error records as kernel trace events.

The handling of the poison list is guided by the CXL 3.0 Specification
Section 8.2.9.8.4.1. [1] 

Example trigger:
$ echo 1 > /sys/bus/cxl/devices/mem0/trigger_poison_list

Example Trace Events:

Poison found in a PMEM Region:
cxl_poison: memdev=mem0 host=cxl_mem.0 serial=0 trace_type=List region=region11 region_uuid=d96e67ec-76b0-406f-8c35-5b52630dcad1 hpa=0xf100000000 dpa=0x70000000 dpa_length=0x40 source=Injected flags= overflow_time=0

Poison found in RAM Region:
cxl_poison: memdev=mem0 host=cxl_mem.0 serial=0 trace_type=List region=region2 region_uuid=00000000-0000-0000-0000-000000000000 hpa=0xf010000000 dpa=0x0 dpa_length=0x40 source=Injected flags= overflow_time=0

Poison found in an unmapped DPA resource:
cxl_poison: memdev=mem3 host=cxl_mem.3 serial=3 trace_type=List region= region_uuid=00000000-0000-0000-0000-000000000000 hpa=0xffffffffffffffff dpa=0x40000000 dpa_length=0x40 source=Injected flags= overflow_time=0

[1]: https://www.computeexpresslink.org/download-the-specification

Alison Schofield (6):
  cxl/mbox: Add GET_POISON_LIST mailbox command
  cxl/trace: Add TRACE support for CXL media-error records
  cxl/memdev: Add trigger_poison_list sysfs attribute
  cxl/region: Provide region info to the cxl_poison trace event
  cxl/trace: Add an HPA to cxl_poison trace events
  tools/testing/cxl: Mock support for Get Poison List

 Documentation/ABI/testing/sysfs-bus-cxl |  14 +++
 drivers/cxl/core/core.h                 |  15 ++++
 drivers/cxl/core/mbox.c                 |  75 ++++++++++++++++
 drivers/cxl/core/memdev.c               | 108 ++++++++++++++++++++++++
 drivers/cxl/core/region.c               |  63 ++++++++++++++
 drivers/cxl/core/trace.c                |  94 +++++++++++++++++++++
 drivers/cxl/core/trace.h                | 101 ++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  72 +++++++++++++++-
 drivers/cxl/mem.c                       |  36 ++++++++
 drivers/cxl/pci.c                       |   4 +
 tools/testing/cxl/test/mem.c            |  42 +++++++++
 11 files changed, 623 insertions(+), 1 deletion(-)


base-commit: e686c32590f40bffc45f105c04c836ffad3e531a
-- 
2.37.3

