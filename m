Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202F2E84D
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479674; cv=none; b=FzRSaPcsatKqJ69sPumWZMWgIXNboHdQ6p+sf9SjnKE1ScwTuiz9lWwMU5YS3E1jvm2lnLaqiHC33lCCa/03/JVFjqyg/0eLB0I1OWaXUUPVxEtX5XdGAP/ztvaqeoDYpxQUkTavnLm3AwarX9ldFJLRm5lcwNzTA0nWY3CfyKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479674; c=relaxed/simple;
	bh=mQHyVxtzVrTnz39NDmI9v8dW/gnW5WW3wrsd/evxS7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zafxe611uSassT1yhEjkrMMbag0emyAhJVsnlGXBQULl9J/ZnD4hSpunVtDVRi6BKb8rvJ6kfts2sGaYnFKUZp3rkJZL64fm5MQaUmqrTCSSLT4ghT6V1fBF47SCaXtM4sjKTc73otKma08xfqEjFt2KUSEi7jTL/Gt5+ckVh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GbRxi4Vk; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GbRxi4Vk"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1707479673; x=1739015673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mQHyVxtzVrTnz39NDmI9v8dW/gnW5WW3wrsd/evxS7U=;
  b=GbRxi4Vk9AhcTEEreyhHZwv3N4vjtBvQ2UXNZMCfEPAjBijionb7kfcH
   VkJyVah+G+p2n3RL0zaW+wJ9SwAkJC7fDlHvW8hjLMnVtHuD22MgqpIsy
   XEywYGV503vCqxaG7R6m20cCMbwBebz7c94CwTkXjfjJBCOAxQM1vJePX
   Qyf/47mWaj2wmx5Dy7CwJXKJ29v/x4QS+lnjUehe+6eoASL5JAleA9Hif
   PuZlvk3OnJt3GGxTOwkAmbGrhuY8Id4qZX5PlLB2uSufFQ4CSPtc3s1x0
   32nhPDGd1upjPNwVqjjEaWOb6U5QudXXBt5pNZqdU3FEFUrBcAq7bbdQv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="150666673"
X-IronPort-AV: E=Sophos;i="6.05,256,1701097200"; 
   d="scan'208";a="150666673"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 20:54:24 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 92EEC268A1E
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:21 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id C8534D4254
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3889920097CF0
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:20 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id D04721A009A;
	Fri,  9 Feb 2024 19:54:19 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com
Subject: [RFC PATCH 5/5] cxl/core: add poison injection event handler
Date: Fri,  9 Feb 2024 19:54:17 +0800
Message-Id: <20240209115417.724638-8-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28180.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28180.007
X-TMASE-Result: 10--16.762300-10.000000
X-TMASE-MatchedRID: kREspPIIG7TvjhWxSrUkKRFbgtHjUWLy/OuUJVcMZhsshTvdDYMpJmdv
	IBM8UuLSCuUOawo+L53hfMsvIi6boIkJXr+VAiTlxDiakrJ+SpneGeDcpMd5NjoUdFbHYUawvwU
	evDt+uW5/XjpbSJS7axmGGSZ2LT4ZE2kkwHbrOXXfSQNpZkETVMMKxxeacM3vNS9A3X1uuOA1Qh
	zyZr8Mz4tgKpAlQHHw8P0p1mD2iGGtVKSQoU2TwYldKbZsGYatCoPXqoZQJeaqA3rusLu26mjMh
	fybFcqMJZ5+dQl9ac+AMuqetGVetnyef22ep6XYkGUtrowrXLg=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Currently driver only trace cxl events, poison injection on cxl memdev
is silent.  OS needs to be notified then it could handle poison range
in time.  Per CXL spec, the device error event could be signaled through
FW-First and OS-First methods.

So, add poison event handler in OS-First method:
  - qemu:
    - CXL device report POISON event to OS by MSI by sending GMER after
      injecting a poison record
  - CXL driver
    a. read the POISON event through GMER;   <-- this patch
    b. get POISON list;
    c. translate DPA to HPA;
    d. construct a mce instance, then call mce_log() to queue this mce
       instance;

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/mbox.c | 42 ++++++++++++++++++++++++++++-------------
 drivers/cxl/cxlmem.h    |  8 ++++----
 drivers/cxl/pci.c       |  4 ++--
 3 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index e1c67159acc4..fa65a98ada16 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -838,25 +838,41 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
-void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
-			    enum cxl_event_log_type type,
-			    enum cxl_event_type event_type,
-			    const uuid_t *uuid, union cxl_event *evt)
+static void cxl_event_handle_poison(struct cxl_memdev *cxlmd,
+				    struct cxl_event_gen_media *rec)
 {
-	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
+	u64 phys_addr = rec->phys_addr & CXL_DPA_MASK, len;
+
+	if (rec->phys_addr & CXL_DPA_VOLATILE)
+		len = resource_size(&cxlmd->cxlds->ram_res) - phys_addr;
+	else
+		len = resource_size(&cxlmd->cxlds->dpa_res) - phys_addr;
+
+	cxl_mem_get_poison(cxlmd, phys_addr, len, NULL, true);
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
+		/* handle poison event */
+		if (type == CXL_EVENT_TYPE_FAIL)
+			cxl_event_handle_poison(cxlmd, &evt->gen_media);
+	} else if (event_type == CXL_CPER_EVENT_DRAM)
 		trace_cxl_dram(cxlmd, type, &evt->dram);
 	else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
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
@@ -868,7 +884,7 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
 		ev_type = CXL_CPER_EVENT_MEM_MODULE;
 
-	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
+	cxl_event_handle_record(cxlmd, type, ev_type, uuid, &record->event);
 }
 
 static int cxl_clear_event_record(struct cxl_memdev_state *mds,
@@ -979,8 +995,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 			break;
 
 		for (i = 0; i < nr_rec; i++)
-			__cxl_event_trace_record(cxlmd, type,
-						 &payload->records[i]);
+			__cxl_event_handle_record(cxlmd, type,
+						  &payload->records[i]);
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index f0877f055f53..1e9e3b9c11d1 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -824,10 +824,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
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
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 233e7c42c161..29a5e641decd 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1003,8 +1003,8 @@ static void cxl_cper_event_call(enum cxl_event_type ev_type,
 	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
 	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
 
-	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type,
-			       &uuid_null, &rec->event);
+	cxl_event_handle_record(cxlds->cxlmd, log_type, ev_type,
+				&uuid_null, &rec->event);
 }
 
 static int __init cxl_pci_driver_init(void)
-- 
2.34.1

