Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B68DCD37A7
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Sep 2023 20:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbjIOUOj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbjIOUOS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Sep 2023 16:14:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A1B2724
        for <linux-cxl@vger.kernel.org>; Fri, 15 Sep 2023 13:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694808836; x=1726344836;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NzNR14q2QC04I+MHlYybGiK8cV6A0HSgf/+ah9CDfV8=;
  b=ET2nNgMRiZqBPsiuDDsuMyCsHg/9MqCg/OC9ERVN4KECq6f1xO4fzPk1
   d4Hi8hjVb/dgziRxVSpwWXp0tjTKw6hWvmbCZRHysWs60zd6XD6INnFE5
   o0KBYOuEzOrF00PVEYp00OH8JNDI/5nqw6CG8qeb8BpE0ssQz4O1J8fBQ
   Gxiq1PUEsmfbcVabF3A4IqiwbjfBO0NcvxWxlH2iqfWT/fx/ARkvdaKI7
   WQA5BqkGWy8JLYO0JIia3HzvP7Jq/T1ARNFnAaQjgW1Qx0fNPqiBNjj5c
   6vl6JHxEs85kgD2VCnQmK4tDODkDdXUZQ1qfguVDvtRkSodLrvKlMQHuK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="465693206"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="465693206"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 13:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="815305037"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="815305037"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.129.178])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 13:13:56 -0700
Subject: [PATCH 2/2] cxl: Move opcode reporting from dev_dbg() to traceevent
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave@stgolabs.net, jonathan.cameron@huawei.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com
Date:   Fri, 15 Sep 2023 13:13:55 -0700
Message-ID: <169480883568.2690926.2900058137618374817.stgit@djiang5-mobl3>
In-Reply-To: <169480882977.2690926.2796694282356938267.stgit@djiang5-mobl3>
References: <169480882977.2690926.2796694282356938267.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison has reported that against certain hardware devices the opcode
discovery dev_dbg() can emit several hundred "unsupported by driver"
messages while parsing the CEL. Move the emission to traceevent to reduce
dmesg spamming and let software parse the output if there are interested
parties.

Reported-by: Alison Schofield <alison.schofield@intel.com>
Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c  |    7 +++----
 drivers/cxl/core/trace.h |   30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ab6b6c4d7a48..59089b540add 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -707,7 +707,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 {
 	struct cxl_cel_entry *cel_entry;
 	const int cel_entries = size / sizeof(*cel_entry);
-	struct device *dev = mds->cxlds.dev;
+	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
 	int i;
 
 	cel_entry = (struct cxl_cel_entry *) cel;
@@ -718,8 +718,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 
 		if (!cmd && (!cxl_is_poison_command(opcode) ||
 			     !cxl_is_security_command(opcode))) {
-			dev_dbg(dev,
-				"Opcode 0x%04x unsupported by driver\n", opcode);
+			trace_cxl_opcode(cxlmd, opcode, false);
 			continue;
 		}
 
@@ -732,7 +731,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		if (cxl_is_security_command(opcode))
 			cxl_set_security_cmd_enabled(&mds->security, opcode);
 
-		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
+		trace_cxl_opcode(cxlmd, opcode, true);
 	}
 }
 
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 817c5377eca2..c48e4c836d77 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -734,6 +734,36 @@ TRACE_EVENT(cxl_log_type,
 	)
 );
 
+TRACE_EVENT(cxl_opcode,
+
+	TP_PROTO(const struct cxl_memdev *cxlmd, u16 opcode, bool enabled),
+
+	TP_ARGS(cxlmd, opcode, enabled),
+
+	TP_STRUCT__entry(
+		__string(memdev, dev_name(&cxlmd->dev))
+		__string(host, dev_name(cxlmd->dev.parent))
+		__field(u64, serial)
+		__field(u16, opcode)
+		__field(bool, enabled)
+	),
+
+	TP_fast_assign(
+		__assign_str(memdev, dev_name(&cxlmd->dev));
+		__assign_str(host, dev_name(cxlmd->dev.parent));
+		__entry->serial = cxlmd->cxlds->serial;
+		__entry->opcode = opcode;
+		__entry->enabled = enabled;
+	),
+
+	TP_printk("memdev=%s host=%s serial=%lld opcode=%d state=%s",
+		  __get_str(memdev),
+		  __get_str(host),
+		  __entry->serial,
+		  __entry->opcode,
+		  __entry->enabled ? "enabled" : "unsupported"
+	)
+);
 #endif /* _CXL_EVENTS_H */
 
 #define TRACE_INCLUDE_FILE trace


