Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BF3C4320E
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Aug 2021 17:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B31C60F56
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Aug 2021 17:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbhH3RS1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:18:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:52385 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237940AbhH3RS1 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 30 Aug 2021 13:18:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218360685"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="218360685"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 10:17:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="427905708"
Received: from lopezale-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.130.82])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 10:17:32 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 1/3] cxl: Fixed defined but not used warnings
Date:   Mon, 30 Aug 2021 10:17:24 -0700
Message-Id: <20210830171726.2342558-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This fixes unused-const-variable warnings emitted by gcc when cxlmem.h
is used by pretty much all files except pci.c

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 include/uapi/linux/cxl_mem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index f6e8a005b113..1236dd9ffe23 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -50,7 +50,7 @@ enum { CXL_CMDS };
 #define ___C(a, b) { b }
 static const struct {
 	const char *name;
-} cxl_command_names[] = { CXL_CMDS };
+} cxl_command_names[] __maybe_unused = { CXL_CMDS };
 
 /*
  * Here's how this actually breaks out:
-- 
2.33.0

