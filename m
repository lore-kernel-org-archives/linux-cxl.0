Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E01C433FE
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 23:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82CC611CE
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 23:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhKCXvw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Nov 2021 19:51:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:57764 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhKCXvw (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 3 Nov 2021 19:51:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="230342122"
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="230342122"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 16:49:14 -0700
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="501308469"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 16:49:14 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jonathan.Cameron@huawei.com,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/memdev: Remove unused cxlmd field
Date:   Wed,  3 Nov 2021 16:48:57 -0700
Message-Id: <20211103234857.3689354-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

This field was left over when the connection between the cxl_memdev and
cxl_mem was tighter.  It is no longer set nor used so remove it.[1]

[1] https://lore.kernel.org/linux-cxl/CAPcyv4hcgh2gb8qsS_UXTBSGqYfMPnC6p5kkvNUjm+V6kVKM5g@mail.gmail.com/

Suggested-by: Jonathan.Cameron@huawei.com
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1:
	Change Subject

[v1] https://lore.kernel.org/linux-cxl/20211103223413.n6fmf3gtop56wssz@intel.com/T/#m79c2c7ba4cc897c10e26acdaca890887e1dd487f
---
 drivers/cxl/cxlmem.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index f978a046591b..8d96d009ad90 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -97,7 +97,6 @@ struct cxl_mbox_cmd {
  * Currently only memory devices are represented.
  *
  * @dev: The device associated with this CXL state
- * @cxlmd: Logical memory device chardev / interface
  * @regs: Parsed register blocks
  * @payload_size: Size of space for payload
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
@@ -124,7 +123,6 @@ struct cxl_mbox_cmd {
  */
 struct cxl_dev_state {
 	struct device *dev;
-	struct cxl_memdev *cxlmd;
 
 	struct cxl_regs regs;
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

