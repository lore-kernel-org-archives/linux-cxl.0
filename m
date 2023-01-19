Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737AEC00A5A
	for <linux-cxl@archiver.kernel.org>; Thu, 19 Jan 2023 05:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjASFIp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 19 Jan 2023 00:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjASFHx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 19 Jan 2023 00:07:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E596874EBD
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 21:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674104572; x=1705640572;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TseuALqX0svJSabOKgU/IkgQjwsW18i1XyLfxvJa48E=;
  b=bVrurkXr8c0drHoVGrD75N8RcmDcXn/4KPRPNdVBDgQYNwGso1n5o5gR
   akWbVaavh1d0s3RyBsH+5UkakK0CIf99rxX3gzm3d8tot3ZO2xTPDrQ55
   /5cvBGTl6kqzz/7UcZX2TK+XpIFJ/g4MhbFholA2ObHQVfi+ugbrNSENl
   RqXe5gQ8iCkiz/aq0IukYToD/xQEJCA8opPXhOsl1AMn1ANgKKF9x8Guk
   ZQCr5x6uBaGQzf99zcqTU6304JC8C5O3Ual6fbHJT2Vh1pIs8oKSUJd1o
   GbpS3yZIMxFYDfpCDSN+TSEvcM+THe3J0eU9LVSCs4mhAm5LyfIM9aB0g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="304881129"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="304881129"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 21:00:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="783932548"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="783932548"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.119.104])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 21:00:23 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/6] cxl: CXL Inject & Clear Poison
Date:   Wed, 18 Jan 2023 21:00:15 -0800
Message-Id: <cover.1674101475.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Built on cxl/next plus Patchset: CXL Poison List Retrieval & Tracing:
https://lore.kernel.org/linux-cxl/de11785ff05844299b40b100f8e0f56c7eef7f08.1674070170.git.alison.schofield@intel.com/

Changes in v2:
- Add Jonathan Reviewed-by tags to Patches 1,2,4
- Clean up input payload structs for both inject and clear (Dan)
- Commit message cleanups, including spec references (Dave)
- Use CXL_POISON_LEN_MULT in define of clear write data
- Use IS_ALIGNED() for 64byte align check (Dan)
- Add Kconfig CXL_POISON_INJECT  (Dan)
- Trivial space cleanup (Jonathan)
- Doc/ABI cleanup (Dave, Dan)
- Mock: Only use injected errors for get poison list
- Mock: Use 'POISONLMT -ENXIO' text from CMD_CMD_RC_TABLE  (Jonathan)
- Mock: Add Patch 6/6: A module param to mock device inject limit

Link to v1: https://lore.kernel.org/linux-cxl/cover.1669781852.git.alison.schofield@intel.com/

Introducing Inject and Clear Poison support for CXL Devices.

These are optional commands, meaning not all CXL devices must support
them. The sysfs attributes, inject_poison and clear_poison, are only
visible for devices reporting support of the capability and when the
kernel Kconfig option CONFIG_CXL_POISON_INJECT is on. (Default: off)

Example:
# echo 0x40000000 > /sys/bus/cxl/devices/mem1/inject_poison
# echo 1 > /sys/bus/cxl/devices/mem1/trigger_poison_list

cxl_poison: memdev=mem1 pcidev=cxl_mem.1 region= region_uuid=00000000-0000-0000-0000-000000000000 hpa=0xffffffffffffffff dpa=0x40000000 length=0x40 source=Injected flags= overflow_time=0


Alison Schofield (6):
  cxl/memdev: Add support for the Inject Poison mailbox command
  cxl/memdev: Add support for the Clear Poison mailbox command
  tools/testing/cxl: Mock the Inject Poison mailbox command
  tools/testing/cxl: Mock the Clear Poison mailbox command
  tools/testing/cxl: Use injected poison for get poison list
  tools/testing/cxl: Add a param to test poison injection limits

 Documentation/ABI/testing/sysfs-bus-cxl |  40 ++++++
 drivers/cxl/Kconfig                     |  10 ++
 drivers/cxl/core/memdev.c               | 122 ++++++++++++++++
 drivers/cxl/cxlmem.h                    |  11 ++
 tools/testing/cxl/test/mem.c            | 178 +++++++++++++++++++++---
 5 files changed, 341 insertions(+), 20 deletions(-)

-- 
2.37.3

