Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5C4C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 01:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241624AbiC3B3w (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241633AbiC3B3t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 21:29:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2996D24D9A0
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 18:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648603686; x=1680139686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHF16x5D3zgG3WciOb/MCrBwV+747JgXvKxMM306SMU=;
  b=mS/1f0ZlQaPhu6tzA/D7wGJmeIFIhyROqOK3hj728CnB1x3ewRAp1dsn
   qF1xu+AK7LsGdHq5DlKDWZbbOOChi+4h+h3VG2vTbfU9aIS4FZseRvBN+
   z6QFiUZiIOv9abrx9IZ2DEauZW14uDu54l44WNvCoy9Dm6XoYZ/3G5y9N
   XitD92iLjwJdw7XP2VFplYqilro5CI+eBDEDNwuPgeCoiD6VNx+J770tP
   94ZOcMN+oPf/Z498b7igoExGLVbgadE5gv23CzQY+jL7LbfO7uY7VNGbt
   I9eoHfskRyGtpAC/Sc7VeEO0Ez/14Fb4ZjjQezidVUg27m3wzq5X75BvF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322601864"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="322601864"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 18:28:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="719776962"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 18:28:01 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v4 9/9] cxl/pmem: Remove CXL SET_PARTITION_INFO from exclusive_cmds list
Date:   Tue, 29 Mar 2022 18:30:24 -0700
Message-Id: <56e8479832ef95bee0aa9099148ecd3e5539c372.1648601710.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648601710.git.alison.schofield@intel.com>
References: <cover.1648601710.git.alison.schofield@intel.com>
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

