Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C8F143754;
	Thu, 16 May 2024 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715854893; cv=none; b=ZTxLtZE0aPx9hTd9wAE2tSiRwufKiTlDxwuwkwSmO1BKjTK6yu2gs5imD704ZY+R5Je635ZFBJgZ9isiH/2WuYdtP46uU/3nr0muFhO5Ebot7csK6ePIs3OAuHArLlkZO/4YGxuJKuxq8N71DQNfloybno34YHqyePhezat17LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715854893; c=relaxed/simple;
	bh=Joxfcfe7fW8z16rGh8KZuwy8XFk9ndFsv4HjTAGt6mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sX65VhdalfwYEThUK9Pyltd6ixXR1IgQE+XwmXIIx4KDpVLznziPsz0DmFI//l7Ugt4xoC+9q3AnyXmH1iAY2CgwvRKlZzgN+IvweENuYAlTyev/EiUhiLrl804q9NvIUYcPLSccRV72NVU2kMfkpolhiLnuZiSGTSDBJki+h2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YlwsgGEn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YlwsgGEn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715854892; x=1747390892;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Joxfcfe7fW8z16rGh8KZuwy8XFk9ndFsv4HjTAGt6mQ=;
  b=YlwsgGEnqglsstaM1XF3Rb36DRXnrptdkscCo4mBvPG+8oGB70sp4ihx
   xTuWUlQPRkA5AveYgE7Y0jX6XBoDiOjdC28ahhq4KuZcXNWM5+F7fQz22
   DMuh+P6ljMDXljmuhq0z9Tn3iobMyObAEmM0RNm1dzL8BwCIY9bjXLa+L
   JWb0bcqblcSIVU60fIfcU8hXGWBBn+Fbn2IseZK6Y5D0uLA0D1vzNnDZl
   3483p/bBm1ZLXW8J9oy0Pziz6IWJZSPJ37qzjLJMnvAZn7JySdwMBEdRj
   w6TdgdBhCdtDFM+r3kdrpsxPEY9qD10xU9sVlFgQDShu4QRoxGactBFei
   Q==;
X-CSE-ConnectionGUID: yetk3EliRki5TZoBad2fqQ==
X-CSE-MsgGUID: kCuMvmLoRRy1YVi4KFBslA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15779736"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="15779736"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 03:21:30 -0700
X-CSE-ConnectionGUID: RCvc+vtDSGuT5szdcLGb0w==
X-CSE-MsgGUID: ReIRkGR4SP2DTeALuC6vlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="68834528"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.246.216])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 03:21:26 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v2] cxl/events: Use a common struct for DRAM and General Media events
Date: Thu, 16 May 2024 12:19:53 +0200
Message-ID: <20240516102116.3512377-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_event_common was a poor naming choice and caused confusion with the
existing Common Event Record.

Use cxl_event_media as a common structure to record information about DRAM
and General Media events because it simplifies handling the two events.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Fixes: 6aec00139d3a ("cxl/core: Add region info to cxl_general_media and cxl_dram events")
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---

Changes for v2:
	- Extend the commit message (Alison);
	- Add a "Fixes" tag (Alison, thanks).

 drivers/cxl/core/mbox.c      |  6 ++--
 drivers/cxl/core/trace.h     |  4 +--
 include/linux/cxl-event.h    | 70 +++++++++++++++---------------------
 tools/testing/cxl/test/mem.c |  4 +--
 4 files changed, 36 insertions(+), 48 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2626f3fff201..ad4d7b0f7f4d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -875,16 +875,16 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		guard(rwsem_read)(&cxl_region_rwsem);
 		guard(rwsem_read)(&cxl_dpa_rwsem);
 
-		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;
+		dpa = le64_to_cpu(evt->media_common.phys_addr) & CXL_DPA_MASK;
 		cxlr = cxl_dpa_to_region(cxlmd, dpa);
 		if (cxlr)
 			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
 
 		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
 			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
-						&evt->gen_media);
+						&evt->media_general);
 		else if (event_type == CXL_CPER_EVENT_DRAM)
-			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
+			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->media_dram);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 07a0394b1d99..2c7293761bb2 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -316,7 +316,7 @@ TRACE_EVENT(cxl_generic_event,
 TRACE_EVENT(cxl_general_media,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_gen_media *rec),
+		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_media *rec),
 
 	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
 
@@ -413,7 +413,7 @@ TRACE_EVENT(cxl_general_media,
 TRACE_EVENT(cxl_dram,
 
 	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
-		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_dram *rec),
+		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_media *rec),
 
 	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
 
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 60b25020281f..e417556cc120 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -32,41 +32,38 @@ struct cxl_event_generic {
  * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
  */
 #define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
-struct cxl_event_gen_media {
-	struct cxl_event_record_hdr hdr;
-	__le64 phys_addr;
-	u8 descriptor;
-	u8 type;
-	u8 transaction_type;
-	u8 validity_flags[2];
-	u8 channel;
-	u8 rank;
-	u8 device[3];
-	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
-	u8 reserved[46];
-} __packed;
-
 /*
  * DRAM Event Record - DER
  * CXL rev 3.0 section 8.2.9.2.1.2; Table 3-44
  */
 #define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
-struct cxl_event_dram {
+struct cxl_event_media {
 	struct cxl_event_record_hdr hdr;
-	__le64 phys_addr;
-	u8 descriptor;
-	u8 type;
-	u8 transaction_type;
-	u8 validity_flags[2];
-	u8 channel;
-	u8 rank;
-	u8 nibble_mask[3];
-	u8 bank_group;
-	u8 bank;
-	u8 row[3];
-	u8 column[2];
-	u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
-	u8 reserved[0x17];
+	struct_group_tagged(cxl_event_media_hdr, media_hdr,
+		__le64 phys_addr;
+		u8 descriptor;
+		u8 type;
+		u8 transaction_type;
+		u8 validity_flags[2];
+		u8 channel;
+		u8 rank;
+	);
+	union {
+		struct_group(general,
+			u8 device[3];
+			u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+			u8 gen_reserved[46];
+		);
+		struct_group(dram,
+			u8 nibble_mask[3];
+			u8 bank_group;
+			u8 bank;
+			u8 row[3];
+			u8 column[2];
+			u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
+			u8 dram_reserved[0x17];
+		);
+	};
 } __packed;
 
 /*
@@ -95,21 +92,12 @@ struct cxl_event_mem_module {
 	u8 reserved[0x3d];
 } __packed;
 
-/*
- * General Media or DRAM Event Common Fields
- * - provides common access to phys_addr
- */
-struct cxl_event_common {
-	struct cxl_event_record_hdr hdr;
-	__le64 phys_addr;
-} __packed;
-
 union cxl_event {
 	struct cxl_event_generic generic;
-	struct cxl_event_gen_media gen_media;
-	struct cxl_event_dram dram;
+	struct cxl_event_media media_general;
+	struct cxl_event_media media_dram;
 	struct cxl_event_mem_module mem_module;
-	struct cxl_event_common common;
+	struct cxl_event_media media_common;
 } __packed;
 
 /*
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 6584443144de..0a8fd145c391 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -378,7 +378,7 @@ struct cxl_event_record_raw hardware_replace = {
 
 struct cxl_test_gen_media {
 	uuid_t id;
-	struct cxl_event_gen_media rec;
+	struct cxl_event_media rec;
 } __packed;
 
 struct cxl_test_gen_media gen_media = {
@@ -402,7 +402,7 @@ struct cxl_test_gen_media gen_media = {
 
 struct cxl_test_dram {
 	uuid_t id;
-	struct cxl_event_dram rec;
+	struct cxl_event_media rec;
 } __packed;
 
 struct cxl_test_dram dram = {
-- 
2.45.0

