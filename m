Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCDA7B3E1
	for <linux-cxl@vger.kernel.org>; Wed,  8 May 2024 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194079; cv=none; b=XPL83yVTl9XBDY8IOjljWkTjNdNtS5dQz0npHWT2LVoOhYiDJ4aea+SMPpmycMPw3z2lbORXjtGY8EGQsfZ4llpb5JGUZTOA65v6PAHY8zch7eBCqq4eudGNGMZORCzjHSNavTjUnjXrkTaspCADm926oDiI/p9e+1+hfM48l/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194079; c=relaxed/simple;
	bh=AgVEq8xn6oX0OJvh64e7eF7az3f4hWwSYG8fdmhEyMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QaiVgJVFa5H4fTM/WBDkMNTIFK8n3Brgo+gRjTkcy6i53r+iDoN/rIqI2H8jt97rJd4067dGiDQcq0gULjd/W5lSAUPIwTiESzyFMlsz4+okpXPhM7CVAYk7nsDx2yCKhngEFl31dhisMALHF/M6KKFlHudpv8z4BnF0Vl8k17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJl4Dypy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJl4Dypy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715194078; x=1746730078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AgVEq8xn6oX0OJvh64e7eF7az3f4hWwSYG8fdmhEyMQ=;
  b=JJl4DypyjNVOjz3zNG4fqdZthrMXr5OATP1LBna7Kwb7CojOC2A5i+4Z
   6mEzsxIG5bOIhRL0zFWk0rrZTywrYOtvCS5qOn7WODoQQn30jhSJ8aMrE
   gtCro6U2JVefUWz8clf0zXHVX5aCc+UQANKxXBlrCV80eHQSRtxwX1MN6
   yHWeuDaOLDINN6SNwW2YWb8A6v0vSnTbgLFWr+YDfUH4sM/2ZtqVNSrnv
   4d+C7hgj9Hj+d7qO7OT7r5ly2DBpcKh8HHdCGAVa3qbSIMhr6HTRTZK3q
   HD5z6xDbFoe6qaZ1ISlnJhga8JsXsjGKTnX4MPnUUn0bAvkz3MPZF0P2o
   Q==;
X-CSE-ConnectionGUID: +y8ZnlRMTNOhPQk+U+NdZw==
X-CSE-MsgGUID: UY//swyIQAOBi3WKE+4GDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="21675607"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="21675607"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:47:56 -0700
X-CSE-ConnectionGUID: 2HhyzJGtSZaBMt11XZx8Nw==
X-CSE-MsgGUID: EE2kCqvLQyyQChb2w/91kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33531054"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.242.107])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:47:56 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 1/4] cxl/core: Rename cxl_trace_hpa() to cxl_translate()
Date: Wed,  8 May 2024 11:47:50 -0700
Message-Id: <27686c91cf4f8b09991534708f6ad2dfc2443af1.1715192606.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1715192606.git.alison.schofield@intel.com>
References: <cover.1715192606.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Although cxl_trace_hpa() is used to populate TRACE EVENTs with HPA
addresses, the work it performs is a translation (dpa->hpa), not a
trace. Rename it. Since this is the only translate work in CXL,
drop the _hpa suffix in the rename.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/core.h   | 4 ++--
 drivers/cxl/core/mbox.c   | 2 +-
 drivers/cxl/core/region.c | 2 +-
 drivers/cxl/core/trace.h  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 625394486459..8ceebd3b51d2 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -28,12 +28,12 @@ int cxl_region_init(void);
 void cxl_region_exit(void);
 int cxl_get_poison_by_endpoint(struct cxl_port *port);
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
-u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
+u64 cxl_translate(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		  u64 dpa);
 
 #else
 static inline u64
-cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd, u64 dpa)
+cxl_translate(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd, u64 dpa)
 {
 	return ULLONG_MAX;
 }
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2626f3fff201..edc54a1ca298 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -878,7 +878,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;
 		cxlr = cxl_dpa_to_region(cxlmd, dpa);
 		if (cxlr)
-			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
+			hpa = cxl_translate(cxlr, cxlmd, dpa);
 
 		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
 			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 00a9f0eef8dd..245edf748906 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2797,7 +2797,7 @@ static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
 	return hpa;
 }
 
-u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
+u64 cxl_translate(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		  u64 dpa)
 {
 	struct cxl_region_params *p = &cxlr->params;
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 07a0394b1d99..6925a6a31f01 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -704,7 +704,7 @@ TRACE_EVENT(cxl_poison,
 		if (cxlr) {
 			__assign_str(region, dev_name(&cxlr->dev));
 			memcpy(__entry->uuid, &cxlr->params.uuid, 16);
-			__entry->hpa = cxl_trace_hpa(cxlr, cxlmd,
+			__entry->hpa = cxl_translate(cxlr, cxlmd,
 						     __entry->dpa);
 		} else {
 			__assign_str(region, "");
-- 
2.37.3

