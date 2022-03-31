Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E1EC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 31 Mar 2022 01:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352308AbiCaB0v (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352312AbiCaB0t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Mar 2022 21:26:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D94F43389
        for <linux-cxl@vger.kernel.org>; Wed, 30 Mar 2022 18:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648689903; x=1680225903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHF16x5D3zgG3WciOb/MCrBwV+747JgXvKxMM306SMU=;
  b=O0we0tjf2qMEaXEK/xDl9aSEKt4jEXhoMzTgNri+l59fGu0TlQLm554m
   rNlJ95D8TQTGncCGIV2b0zSYH3Bx7psf/DNldV6DBE1DR0xPsZGhYEXxH
   qgDdyYmZ4imTVgfkfOxEKsNkps6d7NsenKqRb20YKq1uoR8PlDsn/heoB
   miXcpSrA/olzYC1jtpaVNjJNi5a/ck4TRPL7sMBJOR76kljhICDJV140v
   HwDbmFPXzsI2xFivConKfNP2PZU3yLWZMTS5qZka0WTewgVmqhyFot9mg
   rzQhVWN2Yoi79Sb83ioQAlyCxeBaUEHNswkA0Vv8VJMZgzd+LDgRokhb3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247186039"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="247186039"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:25:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="838664698"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 18:25:02 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 9/9] cxl/pmem: Remove CXL SET_PARTITION_INFO from exclusive_cmds list
Date:   Wed, 30 Mar 2022 18:27:19 -0700
Message-Id: <accc6abc878f0662093b81490a1a052f2ff6f06e.1648687552.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648687552.git.alison.schofield@intel.com>
References: <cover.1648687552.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

With SET_PARTITION_INFO on the exclusive_cmds list for the CXL_PMEM
driver, userspace cannot execute a set-partition command without
first unbinding the pmem driver from the device.

When userspace requests a partition change to take effect on the
next reboot this unbind requirement is unnecessarily restrictive.
The driver does not need to enforce an unbind because partitions
will not change until the next reboot. Of course, userspace still
needs to be aware that changing the size of persistent capacity
on the next reboot will result in the loss of data stored. That
can happen regardless of whether it is presently bound at the time
of issuing the set-partition command.

When userspace requests a partition change to take effect immediately,
restrictions are needed. The CXL_MEM driver currently blocks the usage
of immediate mode, making the presence of SET_PARTITION_INFO, in this
exclusive commands list, redundant.

In the future, when the CXL_MEM driver adds support for immediate
changes to device partitions it will ensure that the partition change
will not affect any active decode. That means the work will not fall
right back here, onto the CXL_PMEM driver.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/pmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 564d125d25ef..35c6f3af18f2 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -344,7 +344,6 @@ static __init int cxl_pmem_init(void)
 {
 	int rc;
 
-	set_bit(CXL_MEM_COMMAND_ID_SET_PARTITION_INFO, exclusive_cmds);
 	set_bit(CXL_MEM_COMMAND_ID_SET_SHUTDOWN_STATE, exclusive_cmds);
 	set_bit(CXL_MEM_COMMAND_ID_SET_LSA, exclusive_cmds);
 
-- 
2.31.1

