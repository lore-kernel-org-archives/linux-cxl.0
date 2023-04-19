Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86744C77B76
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Apr 2023 03:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjDSD0l (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSD0k (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 23:26:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB3CD2
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 20:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681874797; x=1713410797;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HkSxLhX6qDkSKJlQr5QcUXq+GqN3pDfLcqoWLAJU2Y0=;
  b=VUevjI4eE3M3X8vIZ4hGCAmWT/GOR4uGpZ50BvQHas7gsJR330S4VU3E
   IvmuQCaH+S7Bw/OB3BJom1EtHLJGg/mD+M0Q2uFvflls5ldX79m8flz7L
   oWo8dA03kjX6t+e322OybSHuoCsVdySUTL9CQHITrVF+4WXEC4oQesh4R
   eEDwNvSNYNIWqtV/5+X2g2O3bcHRtLgcM2LioDSRax8XgRMoOOQNc0j1p
   C84mQ6w117jkT85gS0jqFanTnT1JHC8sDmqBlIW1yEZ+shhAwhSWul5XF
   jCaKzDhDhpzukKDI8FBXp0j2YLxx1dmyvDWq/rUEVZAUgjG9ehfvZQzoZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431621680"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="431621680"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780711082"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="780711082"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.152.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:37 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v6 0/10] cxl: CXL Inject & Clear Poison
Date:   Tue, 18 Apr 2023 20:26:24 -0700
Message-Id: <cover.1681874357.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Built on cxl/next plus [PATCH v13 0/9] CXL Poison List Retrieval & Tracing
https://lore.kernel.org/linux-cxl/cover.1681838291.git.alison.schofield@intel.com/

Changes in v6:
- Drop patches: The deprecate, and the removal of raw access, introduced
  for all poison commands in v13 of CXL Poison List Retrieval & Tracing,
  made these 2 patches obsolete:
	cxl/memdev: Make inject and clear poison cmds kernel exclusive
	cxl/mbox: Block inject and clear poison opcodes in raw mode

- The device always writes the write data on Clear, regardless of whether or
  not the address is actually poisoned. Stop stating otherwise. (Jonathan)
- Update Patch 1 commit message to refer to CXL.mem driver (DaveJ)
- __cxl_dpa_to_region() Stop the walk on a match (Jonathan)
- Set & use cxlds->poison.enabled_cmds for inject & clear
- Simplify inject payload address assignment (DaveJ)
- Use down_read_interruptible in inject/clear 
- Tidy up the memdev core api for inject/clear by using cxl_memdev
- Use the available cxl_memdev rather than dev in debugfs_create_file()

Link to v5:
https://lore.kernel.org/linux-cxl/cover.1679892337.git.alison.schofield@intel.com/


Introducing Inject and Clear Poison support for CXL Devices.

These are optional commands, meaning not all CXL devices must support
them. The debugfs attributes, inject_poison and clear_poison, are only
visible for devices reporting support of the capability.

Example:
# echo 0x40000000 > /sys/kernel/debug/cxl/mem1/inject_poison

cxl_poison: memdev=mem1 pcidev=cxl_mem.1 trace_type=Inject region= region_uuid=00000000-0000-0000-0000-000000000000 hpa=0xffffffffffffffff dpa=0x40000000 dpa_length=0x40 source=Unknown flags= overflow_time=0

Example in which the injected poison landed in region5:
# echo 0x40000000 > /sys/kernel/debug/cxl/mem0/inject_poison

cxl_poison: memdev=mem0 host=cxl_mem.0 serial=0 trace_type=Inject region=region5 region_uuid=cfcfc13a-5290-4983-aa74-4c8465c25f26 hpa=0xf110000000 dpa=0x40000000 dpa_length=0x40 source=Unknown flags= overflow_time=0


Alison Schofield (10):
  cxl/memdev: Add support for the Inject Poison mailbox command
  cxl/memdev: Add support for the Clear Poison mailbox command
  cxl/memdev: Warn of poison inject or clear to a mapped region
  cxl/memdev: Trace inject and clear poison as cxl_poison events
  cxl/mem: Add debugfs attributes for poison inject and clear
  tools/testing/cxl: Mock the Inject Poison mailbox command
  tools/testing/cxl: Mock the Clear Poison mailbox command
  tools/testing/cxl: Use injected poison for get poison list
  tools/testing/cxl: Add a sysfs attr to test poison inject limits
  tools/testing/cxl: Require CONFIG_DEBUG_FS

 Documentation/ABI/testing/debugfs-cxl |  35 +++++
 drivers/cxl/core/core.h               |   2 +
 drivers/cxl/core/memdev.c             | 172 ++++++++++++++++++++
 drivers/cxl/core/trace.h              |   8 +-
 drivers/cxl/cxlmem.h                  |  13 ++
 drivers/cxl/mem.c                     |  28 ++++
 tools/testing/cxl/config_check.c      |   1 +
 tools/testing/cxl/test/mem.c          | 216 +++++++++++++++++++++++---
 8 files changed, 453 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cxl

-- 
2.37.3

