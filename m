Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D6674E0C
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 20:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710447143; cv=none; b=gQ3mTWgY6bQCp4TGhy/cgHUO3kciSXBeVM684NO0VIksXVhlYp+OA3IwoVGV0VBzcIA9RZe1CNLygbwdxSJPiMmCkrtwrPmbKdylNnl3u/Tt9mCWD+HWnOSnzututtHUsTyVhz+BTh66CJ6hc029Va5CgeDMsO+bQhqxpGeK3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710447143; c=relaxed/simple;
	bh=aqxP6bjhB0EoTGrYNzgAPx7gmGI0qr8E9o4xNCHk9p0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uz+PTWLZRQx/0EF7pZV2umXIjJB7y6jZcsr1vIDG5W5EzdL80Mq6scJOIphZrjeP4vIPuaChtvPEqso5nWxVt1dD6kIQDL8yIpp50qIlyZ6QJ/kvDCDc4YQ5mXeVJv9u+pj1gbsfijmRAfnTxS4EvjthAs5npdoJGmyxVdIvxkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLZ8Arg2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLZ8Arg2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710447142; x=1741983142;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aqxP6bjhB0EoTGrYNzgAPx7gmGI0qr8E9o4xNCHk9p0=;
  b=lLZ8Arg2G0+PxJi7Vww5cPGemrXV/CvRvug4nh4HgMoRh3eEovhyQ+Kp
   YyjuG/e3bTGVHcrV9wyxCKaryMMoQAch/KCFor0blqQxKUjpCam7Mbne+
   RDMzo5kEwDdb5dymDWbQTGVEz+GqmzfOoxB4WIgUwsEeKk1wWFPkKLOBE
   1psw6cFc7Z2AqhoBKyOxb2BbrW8jUkdqn7JVINCPHj3y3INKbbJR4nS0J
   +HOxNfB/IuRndPeiLdH9GpMD5p5f1dO4CLA4kfxi/68jKjZY8GoVGI+U5
   LHQQ/NuegP5zPSvHKxqX5VNfercT/nomBV5FY+t2LlsXhRaP9BIpdXptw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="8232102"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="8232102"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 13:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="17030476"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.72.214])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 13:12:20 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Steve Rostedt <rostedt@goodmis.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl/trace: Properly initialize cxl_poison region name
Date: Thu, 14 Mar 2024 13:12:17 -0700
Message-Id: <20240314201217.2112644-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The TP_STRUCT__entry that gets assigned the region name, or an
empty string if no region is present, is erroneously initialized
to the cxl_region pointer. It needs to be properly initialized
otherwise it's length is wrong and garbage chars can appear in
the kernel trace output: /sys/kernel/tracing/trace

The bad initialization was due in part to a naming conflict with
the parameter: struct cxl_region *region. The field 'region' is
already exposed externally as the region name, so changing that
to something logical, like 'region_name' is not an option. Instead
rename the internal only struct cxl_region to the commonly used
'cxlr'.

Impact is that tooling depending on that trace data can miss
picking up a valid event when searching by region name. The
TP_printk() output, if enabled, does emit the correct region
names in the dmesg log.

This was found during testing of the cxl-list option to report
media-errors for a region.

Fixes: ddf49d57b841 ("cxl/trace: Add TRACE support for CXL media-error records")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
- Initialize the region name with an assignment (Steve)
- Rename struct cxl_region 'cxlr' instead of overusing 'region' identifier
- Update commit message & log


 drivers/cxl/core/trace.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index bdf117a33744..e5f13260fc52 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -646,18 +646,18 @@ u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *memdev, u64 dpa);
 
 TRACE_EVENT(cxl_poison,
 
-	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *region,
+	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,
 		 const struct cxl_poison_record *record, u8 flags,
 		 __le64 overflow_ts, enum cxl_poison_trace_type trace_type),
 
-	TP_ARGS(cxlmd, region, record, flags, overflow_ts, trace_type),
+	TP_ARGS(cxlmd, cxlr, record, flags, overflow_ts, trace_type),
 
 	TP_STRUCT__entry(
 		__string(memdev, dev_name(&cxlmd->dev))
 		__string(host, dev_name(cxlmd->dev.parent))
 		__field(u64, serial)
 		__field(u8, trace_type)
-		__string(region, region)
+		__string(region, cxlr ? dev_name(&cxlr->dev) : "")
 		__field(u64, overflow_ts)
 		__field(u64, hpa)
 		__field(u64, dpa)
@@ -677,10 +677,10 @@ TRACE_EVENT(cxl_poison,
 		__entry->source = cxl_poison_record_source(record);
 		__entry->trace_type = trace_type;
 		__entry->flags = flags;
-		if (region) {
-			__assign_str(region, dev_name(&region->dev));
-			memcpy(__entry->uuid, &region->params.uuid, 16);
-			__entry->hpa = cxl_trace_hpa(region, cxlmd,
+		if (cxlr) {
+			__assign_str(region, dev_name(&cxlr->dev));
+			memcpy(__entry->uuid, &cxlr->params.uuid, 16);
+			__entry->hpa = cxl_trace_hpa(cxlr, cxlmd,
 						     __entry->dpa);
 		} else {
 			__assign_str(region, "");

base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.37.3

