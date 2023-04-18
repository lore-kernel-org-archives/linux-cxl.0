Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B2BC6FD18
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Apr 2023 17:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjDRRjO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDRRjN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 13:39:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED17098
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 10:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681839552; x=1713375552;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wAPEoo5Fv/XVhXCvkxezD0cVkIEkT6FsJUnOyaIlX+o=;
  b=T4pm5xjK/ghqbBMUqacFdnKoyWLqBl8oFtIf2NpfeQ1iuAAuKd4LlRpc
   3hRb1dlgAfwr4CUjb83QbjPyqxgwMC3SEWn8kEjJADJiHumOtnCp7BZPQ
   1X2TrZAeThU2o/sBRMC86aO4YaOXB7U9014klfoKLHAA/XfCeszH7OHFM
   62OX0bnmAdHCDzYzQHywcYaQfTaNij4IgVDYudIwIcAmQ2uGr6Qk+3OXR
   WbjmuGxn5f19bpSbAPeRTz1x86Na5x+wcuNRbtnrSQiy0BuREbRUGo/CU
   Uaf0DAU02IFI4VLug70hDaKdmXMf4WiaoxZDTfH0ATPbb81c7+DoJhYWC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="410470694"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="410470694"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="865505396"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="865505396"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.152.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:39:11 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v13 0/9] CXL Poison List Retrieval & Tracing
Date:   Tue, 18 Apr 2023 10:39:00 -0700
Message-Id: <cover.1681838291.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Changes in v13:
- New Lead-in patches
	cxl/mbox: Deprecate poison commands (Dan)
	cxl/mbox: Restrict poison cmds to debugfs cxl_raw_allow_all

- New Patch: cxl/mbox: Initialize the poison state
  Patch connects the lead-in patches with the rest of this set. Poison init
  was previously done in the GET_POISON_LIST patch. With LIST deprecated,
  needed a method, along with a reason, to discover device support. 

- cxl_poison_state_init(): use kvmalloc for potentially large payload (Dan)
- cxl_poison_state_init() unset poison enabled bit on failure
- trigger sysfs: make the core interface a proper api (Dan)
- trigger sysfs: use down_read_interruptible (Dan)
- Reorganize the by_endpoint work to make typesafe (Dan)
- poison_by_decoder() only fill ctx when iteration is done
- Remove mentions of mixed mode as a 'watch for'. Just say no. (Dan)
- s/overflow_t/overflow_ts in cxlmem.h struct and trace.h struct (Dan)
- Really remove errant line from cxl_memdev_visible() (Jonathan, DaveJ, Dan)

Link to v12:
https://lore.kernel.org/linux-cxl/cover.1681159309.git.alison.schofield@intel.com/

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

Alison Schofield (8):
  cxl/mbox: Restrict poison cmds to debugfs cxl_raw_allow_all
  cxl/mbox: Initialize the poison state
  cxl/mbox: Add GET_POISON_LIST mailbox command
  cxl/trace: Add TRACE support for CXL media-error records
  cxl/memdev: Add trigger_poison_list sysfs attribute
  cxl/region: Provide region info to the cxl_poison trace event
  cxl/trace: Add an HPA to cxl_poison trace events
  tools/testing/cxl: Mock support for Get Poison List

Dan Williams (1):
  cxl/mbox: Deprecate poison commands

 Documentation/ABI/testing/sysfs-bus-cxl |  14 +++
 drivers/cxl/core/core.h                 |   9 ++
 drivers/cxl/core/mbox.c                 | 150 ++++++++++++++++++++++--
 drivers/cxl/core/memdev.c               |  54 +++++++++
 drivers/cxl/core/region.c               | 124 ++++++++++++++++++++
 drivers/cxl/core/trace.c                |  94 +++++++++++++++
 drivers/cxl/core/trace.h                | 101 ++++++++++++++++
 drivers/cxl/cxlmem.h                    |  83 ++++++++++++-
 drivers/cxl/mem.c                       |  43 +++++++
 drivers/cxl/pci.c                       |   4 +
 include/uapi/linux/cxl_mem.h            |  35 +++++-
 tools/testing/cxl/test/mem.c            |  42 +++++++
 12 files changed, 740 insertions(+), 13 deletions(-)


base-commit: e686c32590f40bffc45f105c04c836ffad3e531a
-- 
2.37.3

