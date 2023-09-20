Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC73CE79A8
	for <linux-cxl@archiver.kernel.org>; Wed, 20 Sep 2023 00:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjITAPC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 19 Sep 2023 20:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjITAPC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 19 Sep 2023 20:15:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752CE9D
        for <linux-cxl@vger.kernel.org>; Tue, 19 Sep 2023 17:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695168896; x=1726704896;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YnUv5s50ZxbLfk5nYJNeeaA0GkIw7XjVD1XlzesInKQ=;
  b=j1sEZrB3nfFLY/eM0HU5g+5Vrso1fCi8wMof+AjqJgGSUbGQkBD0THtK
   bwPbjYFWHBIl7KXBOrg9V3OjjQTfRgq9CPR+pvX9veeKG2FGZJ0YYSBBD
   Ki9CN2Su7JUJ2QEzjuljQkk3oLc1ioKilP0u4Rusr/SAS4TXaj1VGNPed
   Eyb82YroKcKurUPSL72sW5qmWtRUpceVCyJiMFB0BrxALzr7mWaAuUJug
   J444ME0oI+lGy3E3B/RDzjeI6rIsOYccmv/tDbeWXJQaoEVao7w9/99kk
   3Qr7b6naUj3gNhO6xo7bKEszuL8kH09kJZN48+CESYe0wSZa+0IbK0aRa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="444180656"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="444180656"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 17:14:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746431077"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="746431077"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.236])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 17:14:55 -0700
Subject: [PATCH v2] cxl: Move opcode reporting from dev_dbg() to traceevent
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave@stgolabs.net, jonathan.cameron@huawei.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com
Date:   Tue, 19 Sep 2023 17:14:54 -0700
Message-ID: <169516889447.3000874.6411946866257133358.stgit@djiang5-mobl3>
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

Due to the change is in cxl/core, the enabling of the traceevent must be
done after cxl_core is loaded but before other cxl modules are loaded.

$ modprobe cxl_core
$ echo 1 > /sys/kernel/tracing/events/cxl/cxl_log_type/enable
$ modprobe cxl_pci

Reported-by: Alison Schofield <alison.schofield@intel.com>
Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
Add enabling note in commit log (Ira)
---
 drivers/cxl/core/mbox.c  |    7 +++----
 drivers/cxl/core/trace.h |   30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ca60bb8114f2..038bf70c01a6 100644
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
index a0b5819bc70b..993fdf3b71e5 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -703,6 +703,36 @@ TRACE_EVENT(cxl_poison,
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


