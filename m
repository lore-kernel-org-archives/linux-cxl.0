Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111EFC678D4
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 21:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCAVgj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 16:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAVgi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 16:36:38 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD76E12847
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 13:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677706597; x=1709242597;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qn/hwWwJhZp6X1TAkMr8Mit7X5WMRFSVrTnih+knO6k=;
  b=muPXXcky53PXiBtJK3amIIGzk7Kd2RCZvb2GqrgvCU0LvjeWF1MHrWQR
   RN/TZAzv/PfyaCmU2Ig2wLTHP0kPh6QY+zPaQOCYDAYjSZfzB0CT/XvjZ
   FLGy/oObhRMeMwHMr1dU2qJL3wi8vUq9GF9JKcPBIneAhLU3eTRWatbpR
   NsiKK6mQw2Th5siMGt+3QszODBeSIObkprfxe0BWXqiU24I1GcU0rx5fk
   QkuFU6u5KyE7QOSMO5cGNu6Am+oress9v3XL9p622+WFO/t4ylrRh9572
   KCbpTG+u5K9Y93kW3O2XyG80y2coXPplm1Y5lFRjlzmtatTLpILPagx/s
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397094664"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="397094664"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 13:36:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="784520762"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="784520762"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.70.38])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 13:36:36 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v3 0/8] cxl: CXL Inject & Clear Poison
Date:   Wed,  1 Mar 2023 13:36:25 -0800
Message-Id: <cover.1677704994.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Changes in v3: 

- Built on cxl/next plus the Get Poison list patchset here:
  https://lore.kernel.org/linux-cxl/cover.1676685180.git.alison.schofield@intel.com/

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

Link to v2: https://lore.kernel.org/linux-cxl/cover.1674101475.git.alison.schofield@intel.com/


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

