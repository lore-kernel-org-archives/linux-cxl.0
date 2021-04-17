Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EC9C433B4
	for <linux-cxl@archiver.kernel.org>; Sat, 17 Apr 2021 00:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02AD46115B
	for <linux-cxl@archiver.kernel.org>; Sat, 17 Apr 2021 00:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhDQAn6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Apr 2021 20:43:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:6137 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhDQAn6 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 16 Apr 2021 20:43:58 -0400
IronPort-SDR: dtx5NJtdtXEwD5q8309UjZZzHCXkB+B6M8/B4CPmcAPnoS5sKA1dF1ONyuSfRL39l/DU32pE3E
 3YLf13Uhb/aA==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="191945091"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="191945091"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 17:43:31 -0700
IronPort-SDR: U0HwynFJN13frkFgYFNfwQPVWtRdY+KYaNF7l9ODADqWQIyzW5rc0qAq06K/bsDSg6zWO0R1ls
 gJ9XA08qrveg==
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="419317971"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 17:43:30 -0700
Subject: [PATCH] cxl/mem: Fix memory device capacity probing
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com
Date:   Fri, 16 Apr 2021 17:43:30 -0700
Message-ID: <161862021044.3259705.7008520073059739760.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The CXL Identify Memory Device output payload emits capacity in 256MB
units. The driver is treating the capacity field as bytes. This was
missed because QEMU reports bytes when it should report bytes / 256MB.

Fixes: 8adaf747c9f0 ("cxl/mem: Find device capabilities")
Cc: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 1b5078311f7d..2acc6173da36 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -4,6 +4,7 @@
 #include <linux/security.h>
 #include <linux/debugfs.h>
 #include <linux/module.h>
+#include <linux/sizes.h>
 #include <linux/mutex.h>
 #include <linux/cdev.h>
 #include <linux/idr.h>
@@ -1419,6 +1420,7 @@ static int cxl_mem_enumerate_cmds(struct cxl_mem *cxlm)
  */
 static int cxl_mem_identify(struct cxl_mem *cxlm)
 {
+	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
 	struct cxl_mbox_identify {
 		char fw_revision[0x10];
 		__le64 total_capacity;
@@ -1447,10 +1449,11 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
 	 * For now, only the capacity is exported in sysfs
 	 */
 	cxlm->ram_range.start = 0;
-	cxlm->ram_range.end = le64_to_cpu(id.volatile_capacity) - 1;
+	cxlm->ram_range.end = le64_to_cpu(id.volatile_capacity) * SZ_256M - 1;
 
 	cxlm->pmem_range.start = 0;
-	cxlm->pmem_range.end = le64_to_cpu(id.persistent_capacity) - 1;
+	cxlm->pmem_range.end =
+		le64_to_cpu(id.persistent_capacity) * SZ_256M - 1;
 
 	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
 

