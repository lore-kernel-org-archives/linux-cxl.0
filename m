Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D2DC76196
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Apr 2023 20:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDJU4D (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Apr 2023 16:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjDJU4C (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Apr 2023 16:56:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB8A2712
        for <linux-cxl@vger.kernel.org>; Mon, 10 Apr 2023 13:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681160139; x=1712696139;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S0wnJefOIznTHt2Lj8tbE75l/jKGdXOxNjSslJW8jdM=;
  b=RlGfc+iFBXNYtIEyd+5wJphneK2NnDQd2Jq5HCJ9P9iinRRkygUMHSWn
   wPZX3AdlSzU3tGa/SDsFO+/pW15PYRTRfkMFKu5w6LZByWRAFPz+3HApc
   RXT35GjoSdncVzVRKGRpdXnkPvMaQjcxyA8uZ5sxRJGS7zXHuWtfS0dMC
   MTUcUMhbeMulTday3xFPaIwNuzEFbhR+xB6rwYkECxq6yHmfFovZ6UGah
   Mpm3UKEO7hCiSiI0WpkfUrpHxYbQiI5dWlsFJlNGuE+wm6iEY990xOw6p
   TgtEAbnLdz4UOsGM6BVUE6w2jm7flxT7E/nuVxt3J+EqmFs3AXOyUWbvl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="371295512"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="371295512"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 13:55:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="688375751"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="688375751"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.230.103])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 13:55:28 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v12 0/6] CXL Poison List Retrieval & Tracing
Date:   Mon, 10 Apr 2023 13:55:19 -0700
Message-Id: <cover.1681159309.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Changes in v12:
- Pick up Reviewed-by Tags:
  2/6 cxl/trace: Add TRACE support for CXL media-error records (Ira)
  4/6 cxl/region: Provide region info to the cxl_poison trace event (Ira, DaveJ)
  6/6 tools/testing/cxl: Mock support for Get Poison List (DaveJ)
- Update sysfs doc to say logging happens when cxl_poison events are enabled.
- Remove errant blank line in cxl_memdev_visible() (Jonathan, DaveJ)
- Rename cxlds->poison.payload_out, poison.list_out
- Update commit message syntax (DaveJ)
- Shorten mailbox struct names (DaveJ)

Link to v11:
https://lore.kernel.org/linux-cxl/cover.1679888450.git.alison.schofield@intel.com/

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
 drivers/cxl/core/mbox.c                 |  74 ++++++++++++++++
 drivers/cxl/core/memdev.c               | 108 ++++++++++++++++++++++++
 drivers/cxl/core/region.c               |  63 ++++++++++++++
 drivers/cxl/core/trace.c                |  94 +++++++++++++++++++++
 drivers/cxl/core/trace.h                | 101 ++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  72 +++++++++++++++-
 drivers/cxl/mem.c                       |  36 ++++++++
 drivers/cxl/pci.c                       |   4 +
 tools/testing/cxl/test/mem.c            |  42 +++++++++
 11 files changed, 622 insertions(+), 1 deletion(-)


base-commit: e686c32590f40bffc45f105c04c836ffad3e531a
-- 
2.37.3

