Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103A0C6FD19
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Mar 2023 18:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCJSt0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Mar 2023 13:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCJStZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Mar 2023 13:49:25 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6055080E26
        for <linux-cxl@vger.kernel.org>; Fri, 10 Mar 2023 10:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678474164; x=1710010164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nBVcR2rNE1rUkGDZUgF13bbY6Ee9sIBDIrPJrLs0VBY=;
  b=JEsJx+4KkxffSxegvAzFF2aXuB7XgJVscDfKjpeymNdgIRCd08ofp2MA
   tq2IkyH4DwLeFAFxmQ58M4nM4j1HLMN6oRgnB/PBsaJ30RIuGzNsuG6aA
   7LKDU7XvFkTFsPAJtmQj/us+o6VLMfpiuMWkds1w4ixwRnW7P6Oul05Pz
   cPsfoIBupmw3kJnbsY+JoDm+ZB7BP6TWHW7c7YgLfvnhAhvsx1AZ7vY5r
   PRuVjMiCNG5jCD6DQJ6R1pQwRdD/k5xbuEURWKPkT+c226Yy5UdigGqfA
   4ghTTcsAW2moZ5AmISFNpzQivC3fNwZYTx4G35Ia4ab27D5Jk6aBTQ4oE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="316452270"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="316452270"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 10:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="680292283"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="680292283"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.255.228.62])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 10:49:22 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v4 0/8] cxl: CXL Inject & Clear Poison
Date:   Fri, 10 Mar 2023 10:49:01 -0800
Message-Id: <cover.1678471465.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Built on cxl/next plus [PATCH v8 0/6] CXL Poison List Retrieval & Tracing

Changes in v4:
- Patch 1 & 2: update date and version in Documentation/ABI/

Changes in v3:
- Two new patches are appended to address Dan's deprecate ask:
  	cxl/memdev: Make inject and clear poison cmds kernel exclusive
  	cxl/mbox: Block inject and clear poison opcodes in raw mode
  I didn't deprecate the ioctls as Dan suggested. Instead, I followed
  on Ira's recent clean up wrt enabled and exclusive commands, deciding
  that the honest response to a cxl_query() would be 'Enabled' (if hardware
  supports) and kernel 'Exclusive' (always). Please take a look.

- Move IS_ENABLED(CONFIG_CXL_POISON_INJECT) test into each attr check (Dan)
- Fail updates to poison_inject_max when poison list is not empty (DaveJ)
- Make poison_inject_max a sysfs attr, rather than module param (Dan)
- Kconfig: add note regarding debug intent (Dan)
- Kept Jonathan's Reviewed-by Tag on Patches 1-6

Link to v3:
https://lore.kernel.org/linux-cxl/cover.1677704994.git.alison.schofield@intel.com/


Introducing Inject and Clear Poison support for CXL Devices.

These are optional commands, meaning not all CXL devices must support
them. The sysfs attributes, inject_poison and clear_poison, are only
visible for devices reporting support of the capability and when the
kernel Kconfig option CONFIG_CXL_POISON_INJECT is on. (Default: off)

Example:
# echo 0x40000000 > /sys/bus/cxl/devices/mem1/inject_poison
# echo 1 > /sys/bus/cxl/devices/mem1/trigger_poison_list

cxl_poison: memdev=mem1 pcidev=cxl_mem.1 region= region_uuid=00000000-0000-0000-0000-000000000000 hpa=0xffffffffffffffff dpa=0x40000000 length=0x40 source=Injected flags= overflow_time=0


Alison Schofield (8):
  cxl/memdev: Add support for the Inject Poison mailbox command
  cxl/memdev: Add support for the Clear Poison mailbox command
  tools/testing/cxl: Mock the Inject Poison mailbox command
  tools/testing/cxl: Mock the Clear Poison mailbox command
  tools/testing/cxl: Use injected poison for get poison list
  tools/testing/cxl: Add a sysfs attr to test poison injection limits
  cxl/memdev: Make inject and clear poison cmds kernel exclusive
  cxl/mbox: Block inject and clear poison opcodes in raw mode

 Documentation/ABI/testing/sysfs-bus-cxl |  40 +++++
 drivers/cxl/Kconfig                     |  11 ++
 drivers/cxl/core/mbox.c                 |   6 +
 drivers/cxl/core/memdev.c               | 162 ++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  11 ++
 include/uapi/linux/cxl_mem.h            |  21 ++-
 tools/testing/cxl/test/mem.c            | 216 +++++++++++++++++++++---
 7 files changed, 443 insertions(+), 24 deletions(-)

-- 
2.37.3

