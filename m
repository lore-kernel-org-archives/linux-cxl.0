Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42425C433EF
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Sep 2021 02:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E6D60FE6
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Sep 2021 02:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbhIDCV6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Sep 2021 22:21:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:53401 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240791AbhIDCV5 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 3 Sep 2021 22:21:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="241848024"
X-IronPort-AV: E=Sophos;i="5.85,267,1624345200"; 
   d="scan'208";a="241848024"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 19:20:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,267,1624345200"; 
   d="scan'208";a="647068295"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 19:20:56 -0700
Subject: [PATCH 4/6] cxl/uapi: Fix defined but not used warnings
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, alison.schofield@intel.com,
        ben.widawsky@intel.com, Jonathan.Cameron@huawei.com
Date:   Fri, 03 Sep 2021 19:20:56 -0700
Message-ID: <163072205652.2250120.16833548560832424468.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163072203373.2250120.8373702699578427249.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163072203373.2250120.8373702699578427249.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

Fix unused-const-variable warnings emitted by gcc when cxlmem.h is used
by pretty much all files except pci.c

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/uapi/linux/cxl_mem.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index f6e8a005b113..8d206f27bb6d 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -50,7 +50,7 @@ enum { CXL_CMDS };
 #define ___C(a, b) { b }
 static const struct {
 	const char *name;
-} cxl_command_names[] = { CXL_CMDS };
+} cxl_command_names[] __attribute__((__unused__)) = { CXL_CMDS };
 
 /*
  * Here's how this actually breaks out:

