Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90325C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 24 Mar 2022 01:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347075AbiCXBK1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347082AbiCXBK0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Mar 2022 21:10:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF72F53A49
        for <linux-cxl@vger.kernel.org>; Wed, 23 Mar 2022 18:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648084135; x=1679620135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHF16x5D3zgG3WciOb/MCrBwV+747JgXvKxMM306SMU=;
  b=mpF45kKBYGTKTCUWSgpDTbYF0aHX8T6F/ebTEEIGo59tVDKHb4uSRPvw
   hrRnV+CCZHQgdZV6+y4KvdjWvRxmjOren++R1bVN/rrb8Jlkc3jXkYQRz
   kuxmVucOOEpSkMt5Fi6wb2NVB5kd7G/TqFK7io75j6IR2rkV41kKMrP3E
   cPjJ0eeI23MjA48AQf0SDSaS6JLGBvUZYNSMaSuTIMBktPaEEUHyCLyUx
   mAY+EeZkRkcvcW7bpJgdcRCyyouIlyP44t++w9FYH1YiSyg+V+kqFKRPL
   OHGvsUMvz9srKUfjES2djwoN2WRxBLyVcDPDO5Zd/cIhg0wpAVEbZHR1H
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258215015"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258215015"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="693142840"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:08:54 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v3 9/9] cxl/pmem: Remove CXL SET_PARTITION_INFO from exclusive_cmds list
Date:   Wed, 23 Mar 2022 18:11:26 -0700
Message-Id: <20220324011126.1144504-10-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324011126.1144504-1-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
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

