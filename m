Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55B86A8BA
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340332; cv=none; b=NG82hxnHwUkiz8r0QwAbKVRXoov0dNpzuslXU83vIqBW/u8iauo/Ef9/MRE1mousL7n1G0aIdMg0NDFwqpG0B5/8US7/R33k7xd8Rdms2kvX2MI6B0myTDJZZoXAptJ0Cz70szm/j1ZhjBiI+ttTEsiCCbM7z7sHm9eA0r2Q97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340332; c=relaxed/simple;
	bh=89O176AgrkL1yroy9Jo+jq3lmWUoJwoXlAdzQfc3vn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZVOq6rF9ICVQs/H70dEHes13De6KADEJKKqEK7ns6bw1sopBZu25tKcP2DK74wWTgum3PeiVmk5JMufNOmBVpsijGOPsQ6H/hbCc/vM6my8Y2pRIg5s3LPpk3oMKB+6UeZXdM2YX0mPkOoHwpfrIawdVE8A9TWZ+MZ2W953DY3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CD6c//ao; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CD6c//ao"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1713340330; x=1744876330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=89O176AgrkL1yroy9Jo+jq3lmWUoJwoXlAdzQfc3vn0=;
  b=CD6c//ao3ekVSQYcigDCL9IQZSrqa/VaqBAdD78w9SnTvFsFkfjT90ez
   01Ax00Q/OSp7eBPEIk/V6kTs6QRx37wr0LqWL6T6FYANBD9EeAVfYo8TM
   ygrTkBP8yHl9vydlvnFyHoFMxAvtI6J/5FcS4xzihpyM/YJtNWoVb54tu
   x++79bDp95advDq6PRPj7OtrI9JNqiG8thORQ7aH3pZU6usCfudfb25Ee
   QXN1/bylAp+AtDGWK4wI4JcJcreN6haHpj08KxfQMrKoj2Z5UmJ238B1w
   /XOLn0XFN5Jcqki5C81oqhRMheU5U0YubuezWfAlA5ZuJonIItQ0+3PpY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="155886662"
X-IronPort-AV: E=Sophos;i="6.07,208,1708354800"; 
   d="scan'208";a="155886662"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 16:50:58 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 30AA12A0E1A
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 16:50:56 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 56D51184465
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 16:50:55 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id D43D52030D2B8
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 16:50:54 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 54CCB1A000A;
	Wed, 17 Apr 2024 15:50:54 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	dave@stgolabs.net,
	ira.weiny@intel.com,
	alison.schofield@intel.com
Subject: [PATCH v3 2/2] cxl/core: add poison creation event handler
Date: Wed, 17 Apr 2024 15:50:53 +0800
Message-Id: <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28326.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28326.005
X-TMASE-Result: 10--16.044500-10.000000
X-TMASE-MatchedRID: DIEPoA0d9jzvjhWxSrUkKRFbgtHjUWLy/OuUJVcMZhsshTvdDYMpJmdv
	IBM8UuLSeJaFFPX0aSQzZRFJRee/WnuDhljfG03rTuctSpiuWyUUi4Ehat0545Tx+2LIqNmteVs
	0skyEaS3LfxMfp01yFeQEkglipGR3fDPEC/yQgPRFThfcy7XcjI5UafLmrvaGvn+2qfQyWg0Skx
	jSj8Gsp+GmDaCURky8QvDfXpsV7A2f80tdhYBdg9Hu43wY4QfHfrTt+hmA5bK7Iv2OMTayQWlwp
	eAR2tzqI0ExTNeC7Ia4Yr4jUnU84qqoNk0mVBa9MrR3zbmt+0V9LQinZ4QefPcjNeVeWlqY+gtH
	j7OwNO0CpgETeT0ynA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Currently driver only traces cxl events, poison creation (for both vmem
and pmem type) on cxl memdev is silent.  OS needs to be notified then it
could handle poison pages in time.  Per CXL spec, the device error event
could be signaled through FW-First and OS-First methods.

So, add poison creation event handler in OS-First method:
  - Qemu:
    - CXL device reports POISON creation event to OS by MSI by sending
      GMER/DER after injecting a poison record;
  - CXL driver:
    a. parse the POISON event from GMER/DER;
    b. translate poisoned DPA to HPA (PFN);
    c. enqueue poisoned PFN to memory_failure's work queue;

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/mbox.c   | 119 +++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxlmem.h      |   8 +--
 include/linux/cxl-event.h |  18 +++++-
 3 files changed, 125 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f0f54aeccc87..76af0d73859d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -837,25 +837,116 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
-void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
-			    enum cxl_event_log_type type,
-			    enum cxl_event_type event_type,
-			    const uuid_t *uuid, union cxl_event *evt)
+static void cxl_report_poison(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,
+			      u64 dpa)
 {
-	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
+	u64 hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
+	unsigned long pfn = PHYS_PFN(hpa);
+
+	if (!IS_ENABLED(CONFIG_MEMORY_FAILURE))
+		return;
+
+	memory_failure_queue(pfn, MF_ACTION_REQUIRED);
+}
+
+static int __cxl_report_poison(struct device *dev, void *arg)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
+	u64 dpa = *(u64 *)arg;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if (!cxled || !cxled->dpa_res || !resource_size(cxled->dpa_res))
+		return 0;
+
+	if (cxled->mode == CXL_DECODER_MIXED) {
+		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
+		return 0;
+	}
+
+	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
+		return 0;
+
+	cxlmd = cxled_to_memdev(cxled);
+	cxl_report_poison(cxlmd, cxled->cxld.region, dpa);
+
+	return 1;
+}
+
+static void cxl_event_handle_poison(struct cxl_memdev *cxlmd, u64 dpa)
+{
+	struct cxl_port *port = cxlmd->endpoint;
+
+	/*
+	 * No region is mapped to this endpoint, that is to say no HPA is
+	 * mapped.
+	 */
+	if (!port || !is_cxl_endpoint(port) ||
+	    cxl_num_decoders_committed(port) == 0)
+		return;
+
+	device_for_each_child(&port->dev, &dpa, __cxl_report_poison);
+}
+
+static void cxl_event_handle_general_media(struct cxl_memdev *cxlmd,
+					   enum cxl_event_log_type type,
+					   struct cxl_event_gen_media *rec)
+{
+	u64 dpa = le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK;
+
+	if (type == CXL_EVENT_TYPE_FAIL) {
+		switch (rec->transaction_type) {
+		case CXL_EVENT_TRANSACTION_READ:
+		case CXL_EVENT_TRANSACTION_WRITE:
+		case CXL_EVENT_TRANSACTION_INJECT_POISON:
+			cxl_event_handle_poison(cxlmd, dpa);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void cxl_event_handle_dram(struct cxl_memdev *cxlmd,
+				  enum cxl_event_log_type type,
+				  struct cxl_event_dram *rec)
+{
+	u64 dpa = le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK;
+
+	if (type == CXL_EVENT_TYPE_FAIL) {
+		switch (rec->transaction_type) {
+		case CXL_EVENT_TRANSACTION_READ:
+		case CXL_EVENT_TRANSACTION_WRITE:
+		case CXL_EVENT_TRANSACTION_INJECT_POISON:
+			cxl_event_handle_poison(cxlmd, dpa);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+void cxl_event_handle_record(struct cxl_memdev *cxlmd,
+			     enum cxl_event_log_type type,
+			     enum cxl_event_type event_type,
+			     const uuid_t *uuid, union cxl_event *evt)
+{
+	if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
 		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
-	else if (event_type == CXL_CPER_EVENT_DRAM)
+		cxl_event_handle_general_media(cxlmd, type, &evt->gen_media);
+	} else if (event_type == CXL_CPER_EVENT_DRAM) {
 		trace_cxl_dram(cxlmd, type, &evt->dram);
-	else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
+		cxl_event_handle_dram(cxlmd, type, &evt->dram);
+	} else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
 		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
 	else
 		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
+EXPORT_SYMBOL_NS_GPL(cxl_event_handle_record, CXL);
 
-static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
-				     enum cxl_event_log_type type,
-				     struct cxl_event_record_raw *record)
+static void __cxl_event_handle_record(struct cxl_memdev *cxlmd,
+				      enum cxl_event_log_type type,
+				      struct cxl_event_record_raw *record)
 {
 	enum cxl_event_type ev_type = CXL_CPER_EVENT_GENERIC;
 	const uuid_t *uuid = &record->id;
@@ -867,7 +958,7 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
 		ev_type = CXL_CPER_EVENT_MEM_MODULE;
 
-	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
+	cxl_event_handle_record(cxlmd, type, ev_type, uuid, &record->event);
 }
 
 static int cxl_clear_event_record(struct cxl_memdev_state *mds,
@@ -979,8 +1070,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 			break;
 
 		for (i = 0; i < nr_rec; i++)
-			__cxl_event_trace_record(cxlmd, type,
-						 &payload->records[i]);
+			__cxl_event_handle_record(cxlmd, type,
+						  &payload->records[i]);
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 36cee9c30ceb..ba1347de5651 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -822,10 +822,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds);
 void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
-void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
-			    enum cxl_event_log_type type,
-			    enum cxl_event_type event_type,
-			    const uuid_t *uuid, union cxl_event *evt);
+void cxl_event_handle_record(struct cxl_memdev *cxlmd,
+			     enum cxl_event_log_type type,
+			     enum cxl_event_type event_type,
+			     const uuid_t *uuid, union cxl_event *evt);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 03fa6d50d46f..8189bed76c12 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -23,6 +23,20 @@ struct cxl_event_generic {
 	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
 } __packed;
 
+/*
+ * Event transaction type
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+enum cxl_event_transaction_type {
+	CXL_EVENT_TRANSACTION_UNKNOWN = 0X00,
+	CXL_EVENT_TRANSACTION_READ,
+	CXL_EVENT_TRANSACTION_WRITE,
+	CXL_EVENT_TRANSACTION_SCAN_MEDIA,
+	CXL_EVENT_TRANSACTION_INJECT_POISON,
+	CXL_EVENT_TRANSACTION_MEDIA_SCRUB,
+	CXL_EVENT_TRANSACTION_MEDIA_MANAGEMENT,
+};
+
 /*
  * General Media Event Record
  * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
@@ -33,7 +47,7 @@ struct cxl_event_gen_media {
 	__le64 phys_addr;
 	u8 descriptor;
 	u8 type;
-	u8 transaction_type;
+	u8 transaction_type;	/* enum cxl_event_transaction_type */
 	u8 validity_flags[2];
 	u8 channel;
 	u8 rank;
@@ -52,7 +66,7 @@ struct cxl_event_dram {
 	__le64 phys_addr;
 	u8 descriptor;
 	u8 type;
-	u8 transaction_type;
+	u8 transaction_type;	/* enum cxl_event_transaction_type */
 	u8 validity_flags[2];
 	u8 channel;
 	u8 rank;
-- 
2.34.1

