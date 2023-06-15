Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805DBEB64DB
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 01:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbjFOB3z (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbjFOB3z (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 21:29:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2E12126
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 18:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686792594; x=1718328594;
  h=subject:from:to:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ETgMGnLnnoj6rFq1EdeDXrJSM4OCBgpx2fhD9SJIWLw=;
  b=nvJj4LShBskn/AwYqmoM9ILxOuLgKWJpiTmN0C0tPLo+mvnn2cPdhaVG
   c+nqa7vJODEIbLcYTBFQPZG9Sl5uXo1TMHwCk1JfI46lQDxdfz1bRL87C
   jqLKXni0wEJzoOEGK+WIlbV2veCjCK11wLa0K8LRbFH/7cZQBZdbhxGsS
   qUYuVW+dD3zEvZRh4+vjfTzDueWPOndduX0I32bUfXoywqUPKFFpQ37Vc
   84ZickaABff08NffgWV9vzsedVHR3WBQzpfk1Y6+JnHcIL+4jcXVV58DA
   CJb3RbL3mY2W+dYzw3HF/psA1Jb3h+ac+O4uAxEknCSbtLWmQRwnNRdMw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="445150672"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="445150672"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:29:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="689600065"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="689600065"
Received: from rtpearso-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.87.28])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:29:51 -0700
Subject: [PATCH v2 03/12] cxl: Fix kernel-doc warnings
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Date:   Wed, 14 Jun 2023 18:29:51 -0700
Message-ID: <168679259170.3436160.3686460404739136336.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

After Jonathan noticed [1] that 'struct cxl_dev_state' had a kernel-doc
entry without a corresponding struct attribute I ran the kernel-doc
script to see what else might be broken. Fix these warnings:

drivers/cxl/cxlmem.h:199: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Event Interrupt Policy
drivers/cxl/cxlmem.h:224: warning: Function parameter or member 'buf' not described in 'cxl_event_state'
drivers/cxl/cxlmem.h:224: warning: Function parameter or member 'log_lock' not described in 'cxl_event_state'

Note that scripts/kernel-doc only finds missing kernel-doc entries. It
does not warn on too many kernel-doc entries, i.e. it did not catch the
fact that @info refers to a not present member.

Link: http://lore.kernel.org/r/20230606121054.000069e1@Huawei.com [1]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxlmem.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a2845a7a69d8..8e4ba5b52902 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -195,7 +195,7 @@ static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
  */
 #define CXL_CAPACITY_MULTIPLIER SZ_256M
 
-/**
+/*
  * Event Interrupt Policy
  *
  * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
@@ -215,8 +215,8 @@ struct cxl_event_interrupt_policy {
 /**
  * struct cxl_event_state - Event log driver state
  *
- * @event_buf: Buffer to receive event data
- * @event_log_lock: Serialize event_buf and log use
+ * @buf: Buffer to receive event data
+ * @log_lock: Serialize event_buf and log use
  */
 struct cxl_event_state {
 	struct cxl_get_event_payload *buf;

