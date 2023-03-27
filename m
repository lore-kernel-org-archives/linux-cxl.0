Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9635CC7619A
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Mar 2023 05:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjC0FDW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 01:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0FDV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 01:03:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CE34234
        for <linux-cxl@vger.kernel.org>; Sun, 26 Mar 2023 22:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679893400; x=1711429400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+NJ0zBlsAPSXSaf4WuVWnDyhaGw7U+BUIclSYmPc+4c=;
  b=MFkaxS0+XcVlGZgcpfUOo+X/wP8W0KHsK19LpIS9YcBYLvYZOY0AnI13
   aSuDpIB8UKBYAC53sSJI6G5nAG3eBvgocKXZerHZhGfp/nLL0FsclpPnX
   a5pKPthlbKwixbOBEesEK18xU4JBxmyi2T0iRbMURKLRNpGYufCoU17Jl
   VybcclLthRLgu3vQE2Hce91CCTQG4jmn2mn1UIiiEqcvb4zd+m87b1wDe
   559I66BGDg7D76cAhHCk/mL2uKicqhEOUP7A4uDR5OR7+K8JN/BbttG8Q
   wEz8dpnB4VKmNSCIRjJ8RALe1RVAVv8rosv8/bhPvU5nz6XlHXd+cocmB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367920174"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="367920174"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="633492240"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="633492240"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.227.2])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:19 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 0/12] cxl: CXL Inject & Clear Poison
Date:   Sun, 26 Mar 2023 22:03:06 -0700
Message-Id: <cover.1679892337.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Built on cxl/next plus [PATCH v11 0/6] CXL Poison List Retrieval & Tracing

Changes in v5:
- Move the inject & clear sysfs attrs to debugfs attrs (Dan)
- Allow inject and clear to mapped DPAs and dev_warn_once() 
- Add cxl_poison trace events for inject and clear (CXL Community Forum)
- Add conditional compiles for CONFIG_DEBUG_FS
- Conform to spacing in uapi header cxlmem.h (Jonathan)

Tags: Kept Jonathans Reviewed-by on, what are now, patches 6-11
Link to v4:
https://lore.kernel.org/linux-cxl/cover.1677704994.git.alison.schofield@intel.com/

Introducing Inject and Clear Poison support for CXL Devices.

These are optional commands, meaning not all CXL devices must support
them. The debugfs attributes, inject_poison and clear_poison, are only
visible for devices reporting support of the capability.

Example:
# echo 0x40000000 > /sys/kernel/debug/cxl/mem1/inject_poison

cxl_poison: memdev=mem1 pcidev=cxl_mem.1 trace_type=Inject region= region_uuid=00000000-0000-0000-0000-000000000000 hpa=0xffffffffffffffff dpa=0x40000000 length=0x40 source=Unknown flags= overflow_time=0

Example in which the injected poison landed in region5:
# echo 0x40000000 > /sys/kernel/debug/cxl/mem0/inject_poison

cxl_poison: memdev=mem0 host=cxl_mem.0 serial=0 trace_type=Inject region=region5 region_uuid=cfcfc13a-5290-4983-aa74-4c8465c25f26 hpa=0xf110000000 dpa=0x40000000 dpa_length=0x40 source=Unknown flags= overflow_time=0

Alison Schofield (12):
  cxl/memdev: Add support for the Inject Poison mailbox command
  cxl/memdev: Add support for the Clear Poison mailbox command
  cxl/memdev: Warn of poison inject or clear to a mapped region
  cxl/memdev: Trace inject and clear poison as cxl_poison events
  cxl/mem: Add debugfs attributes for poison inject and clear
  cxl/memdev: Make inject and clear poison cmds kernel exclusive
  cxl/mbox: Block inject and clear poison opcodes in raw mode
  tools/testing/cxl: Mock the Inject Poison mailbox command
  tools/testing/cxl: Mock the Clear Poison mailbox command
  tools/testing/cxl: Use injected poison for get poison list
  tools/testing/cxl: Add a sysfs attr to test poison inject limits
  tools/testing/cxl: Require CONFIG_DEBUG_FS

 Documentation/ABI/testing/debugfs-cxl |  36 +++++
 drivers/cxl/core/core.h               |   2 +
 drivers/cxl/core/mbox.c               |   5 +
 drivers/cxl/core/memdev.c             | 179 +++++++++++++++++++++
 drivers/cxl/core/trace.h              |   8 +-
 drivers/cxl/cxlmem.h                  |  13 ++
 drivers/cxl/mem.c                     |  26 ++++
 include/uapi/linux/cxl_mem.h          |  20 ++-
 tools/testing/cxl/config_check.c      |   1 +
 tools/testing/cxl/test/mem.c          | 216 +++++++++++++++++++++++---
 10 files changed, 479 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cxl

-- 
2.37.3

