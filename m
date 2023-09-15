Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6862FCD37A9
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Sep 2023 20:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbjIOUOi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbjIOUOR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Sep 2023 16:14:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E762701
        for <linux-cxl@vger.kernel.org>; Fri, 15 Sep 2023 13:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694808835; x=1726344835;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mxarw50kGGRv9xrL83sJ7XfbssxD8sWsMQA81gYrFiI=;
  b=g+t3sKOuoO/8UmcKvhlGyOy532F6irLRHP+uciWQK38n+HkQVDDcwWzs
   B/55nw/Z8Iq5idW2mEcha83KlOgtOPp2OiFUpeGLRlOmUNRyLw+pheFEK
   S+/r6JUx9Gvj1jTn43KJ1/SiuWl5RCiRmqsH2/Xct+1fQy3fjRdqQ/Jpz
   KRxwQQOju/MPlq78iQ/FzhTyucs2zi4ehP6lQpuxfweUHq1DtAumOZ40e
   kmWPuxa1zLEdlvpURc5wJaqTdOhfIVNVIY9RCVdyx59WKftPkT6h1uaLl
   E3Nn0g1zX1BDMcZ9KnbIUNVj4ljQFuUaywTwmBvGG5sNxsl+QSan4tLom
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="465693189"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="465693189"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 13:13:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="815305018"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="815305018"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.129.178])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 13:13:50 -0700
Subject: [PATCH 1/2] cxl: Move command enumeration from dev_dbg() to
 traceevent
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave@stgolabs.net, jonathan.cameron@huawei.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com
Date:   Fri, 15 Sep 2023 13:13:49 -0700
Message-ID: <169480882977.2690926.2796694282356938267.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Given that event logs outputs are all emitted to traceevent, move the
enumeration of log types to traceevent as well in order to keep all the
outputs at the same location.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c  |    3 +--
 drivers/cxl/core/trace.h |   31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ca60bb8114f2..ab6b6c4d7a48 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -787,7 +787,6 @@ static const uuid_t log_uuid[] = {
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 {
 	struct cxl_mbox_get_supported_logs *gsl;
-	struct device *dev = mds->cxlds.dev;
 	struct cxl_mem_command *cmd;
 	int i, rc;
 
@@ -801,7 +800,7 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 		uuid_t uuid = gsl->entry[i].uuid;
 		u8 *log;
 
-		dev_dbg(dev, "Found LOG type %pU of size %d", &uuid, size);
+		trace_cxl_log_type(mds->cxlds.cxlmd, &uuid, size);
 
 		if (!uuid_equal(&uuid, &log_uuid[CEL_UUID]))
 			continue;
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a0b5819bc70b..817c5377eca2 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -703,6 +703,37 @@ TRACE_EVENT(cxl_poison,
 	)
 );
 
+TRACE_EVENT(cxl_log_type,
+
+	TP_PROTO(const struct cxl_memdev *cxlmd, uuid_t *uuid, int size),
+
+	TP_ARGS(cxlmd, uuid, size),
+
+	TP_STRUCT__entry(
+		__string(memdev, dev_name(&cxlmd->dev))
+		__string(host, dev_name(cxlmd->dev.parent))
+		__array(char, uuid, 16)
+		__field(u64, serial)
+		__field(int, size)
+	),
+
+	TP_fast_assign(
+		__assign_str(memdev, dev_name(&cxlmd->dev));
+		__assign_str(host, dev_name(cxlmd->dev.parent));
+		__entry->serial = cxlmd->cxlds->serial;
+		memcpy(__entry->uuid, uuid, 16);
+		__entry->size = size;
+	),
+
+	TP_printk("memdev=%s host=%s serial=%lld log_type=%pU size=%d",
+		  __get_str(memdev),
+		  __get_str(host),
+		  __entry->serial,
+		  __entry->uuid,
+		  __entry->size
+	)
+);
+
 #endif /* _CXL_EVENTS_H */
 
 #define TRACE_INCLUDE_FILE trace


