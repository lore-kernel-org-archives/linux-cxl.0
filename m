Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0FD1CFBD
	for <linux-cxl@vger.kernel.org>; Tue, 23 Apr 2024 03:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844095; cv=none; b=VkPssZcwFJ087OFel0JgLKWoNdGbTppTeKXditJWzGa2A+8GmkXNUKEhXwmfprvdsa/pqdfJOAhMWsDfKXrNPj9/B7plztAbzgn8Fqlmrz1g4OgDo2HLBa788mnZwSZci+rhWL6o9DyyVmgqqI9mn+Q/J9l9Du7kwwS66bx1GKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844095; c=relaxed/simple;
	bh=Bm21AZGUnvoLbfmQ36OgN3ggg0k1mdJr8Pu9OGlBCRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tp+1kAPmwENhj1pQEMO/K+gz4Ah22b+noFa4AAOkMRuTk2VupiPxZmuwyDfKKGwEkAXr7CjFu3Pnym2KHd9CguYRhX7GEHzFmiSitnu7n7vam864/QgYDFSGvjycF8ueNVN07k22tsICb7lPI+BCeuukCjenE2sSLGvYnEJEtHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVjMfRNi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVjMfRNi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713844093; x=1745380093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bm21AZGUnvoLbfmQ36OgN3ggg0k1mdJr8Pu9OGlBCRU=;
  b=LVjMfRNisTgQF4aJecP+WIRt0iSsVbxIWme+MnXKKmYb04bPF0g4Tt/p
   w+YnzoR2+N3g17bxvTS8PhEIMUyhhU4CMn0Wi5OrRonD0wwGtDikbo7Vc
   VMYYYjPVYSTjv8qWz27VEvFJg4Ft21W8ZPpmySshf7Rkw762ELAApwFVx
   0Br9AhUxx0h5UDhZL7jmxMlY9lrd1hK+pwMF7XifWMhUxRxRtQ4Tk2q/6
   pkCpNOqTvb7JapV5OI3ibjwmmAYeSu7TJ7c9J6XPKy6Yk6xaadpgiXD9x
   PvgvGrvLX4Ui3qLip5WYBE6BxK6OSpHbn0hnalCKmol7SpAm/TMOYrTPh
   A==;
X-CSE-ConnectionGUID: q6P+j6C5QZed7G9SF8GwwA==
X-CSE-MsgGUID: +o1IaVsdTiGZA8PjKU5HnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="26925902"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26925902"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 20:48:12 -0700
X-CSE-ConnectionGUID: vG+sPtqpT9ecP4BKEDukbQ==
X-CSE-MsgGUID: 1NfrmRRlSIOvDOVfU6C95w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28884711"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.73.120])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 20:48:11 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 4/4] cxl/core: Remove cxlr dependency from cxl_poison trace events
Date: Mon, 22 Apr 2024 20:48:06 -0700
Message-Id: <9a125b4bbf6556b9dda5727a4fad3e7ab25a1e1a.1713842838.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713842838.git.alison.schofield@intel.com>
References: <cover.1713842838.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

cxl_poison trace events pass a pointer to a struct cxl_region
when poison is discovered in a mapped endpoint. This made for
easy look up of region name, uuid, and was useful in starting
the dpa->hpa translation.

Another set of trace helpers is now available that eliminates
the need to pass on that cxlr. (It was passed along a lot!)

In addition to tidying up the cxl_poison calling path, shifting
to the new helpers also means all CXL trace events will share
the same code in that regard.

Switch from a uuid array to the field_struct type uuid_t to
align on one uuid format in all CXL trace events. That is useful
when sharing region uuid lookup helpers.

No externally visible naming changes are made to cxl_poison trace
events.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c   |  5 ++---
 drivers/cxl/core/memdev.c |  8 ++++----
 drivers/cxl/core/region.c |  8 ++++----
 drivers/cxl/core/trace.h  | 27 +++++++++++----------------
 drivers/cxl/cxlmem.h      |  3 +--
 5 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 3c1c37d5fcb0..60a51ea3ff25 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1299,8 +1299,7 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
 
-int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
-		       struct cxl_region *cxlr)
+int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len)
 {
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 	struct cxl_mbox_poison_out *po;
@@ -1332,7 +1331,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 			break;
 
 		for (int i = 0; i < le16_to_cpu(po->count); i++)
-			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
+			trace_cxl_poison(cxlmd, &po->record[i],
 					 po->flags, po->overflow_ts,
 					 CXL_POISON_TRACE_LIST);
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 0277726afd04..1a0b596da7b6 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -200,14 +200,14 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 	if (resource_size(&cxlds->pmem_res)) {
 		offset = cxlds->pmem_res.start;
 		length = resource_size(&cxlds->pmem_res);
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		rc = cxl_mem_get_poison(cxlmd, offset, length);
 		if (rc)
 			return rc;
 	}
 	if (resource_size(&cxlds->ram_res)) {
 		offset = cxlds->ram_res.start;
 		length = resource_size(&cxlds->ram_res);
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		rc = cxl_mem_get_poison(cxlmd, offset, length);
 		/*
 		 * Invalid Physical Address is not an error for
 		 * volatile addresses. Device support is optional.
@@ -321,7 +321,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.address = cpu_to_le64(dpa),
 		.length = cpu_to_le32(1),
 	};
-	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
+	trace_cxl_poison(cxlmd, &record, 0, 0, CXL_POISON_TRACE_INJECT);
 out:
 	up_read(&cxl_dpa_rwsem);
 	up_read(&cxl_region_rwsem);
@@ -385,7 +385,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.address = cpu_to_le64(dpa),
 		.length = cpu_to_le32(1),
 	};
-	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
+	trace_cxl_poison(cxlmd, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
 out:
 	up_read(&cxl_dpa_rwsem);
 	up_read(&cxl_region_rwsem);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a5b1eaee1e58..8cd057fc212c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2585,7 +2585,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 	if (ctx->mode == CXL_DECODER_RAM) {
 		offset = ctx->offset;
 		length = resource_size(&cxlds->ram_res) - offset;
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		rc = cxl_mem_get_poison(cxlmd, offset, length);
 		if (rc == -EFAULT)
 			rc = 0;
 		if (rc)
@@ -2603,7 +2603,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 		return 0;
 	}
 
-	return cxl_mem_get_poison(cxlmd, offset, length, NULL);
+	return cxl_mem_get_poison(cxlmd, offset, length);
 }
 
 static int poison_by_decoder(struct device *dev, void *arg)
@@ -2637,7 +2637,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	if (cxled->skip) {
 		offset = cxled->dpa_res->start - cxled->skip;
 		length = cxled->skip;
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		rc = cxl_mem_get_poison(cxlmd, offset, length);
 		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
 			rc = 0;
 		if (rc)
@@ -2646,7 +2646,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
 
 	offset = cxled->dpa_res->start;
 	length = cxled->dpa_res->end - offset + 1;
-	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
+	rc = cxl_mem_get_poison(cxlmd, offset, length);
 	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
 		rc = 0;
 	if (rc)
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 2e24364b2b8d..1cfdd1558e6c 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -686,23 +686,24 @@ TRACE_EVENT(cxl_memory_module,
 
 TRACE_EVENT(cxl_poison,
 
-	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,
+	TP_PROTO(const struct cxl_memdev *cxlmd,
 		 const struct cxl_poison_record *record, u8 flags,
 		 __le64 overflow_ts, enum cxl_poison_trace_type trace_type),
 
-	TP_ARGS(cxlmd, cxlr, record, flags, overflow_ts, trace_type),
+	TP_ARGS(cxlmd, record, flags, overflow_ts, trace_type),
 
 	TP_STRUCT__entry(
 		__string(memdev, dev_name(&cxlmd->dev))
 		__string(host, dev_name(cxlmd->dev.parent))
 		__field(u64, serial)
 		__field(u8, trace_type)
-		__string(region, cxlr ? dev_name(&cxlr->dev) : "")
+		__string(region,
+			 cxl_trace_to_region_name(cxlmd, cxl_poison_record_dpa(record)))
 		__field(u64, overflow_ts)
 		__field(u64, hpa)
 		__field(u64, dpa)
 		__field(u32, dpa_length)
-		__array(char, uuid, 16)
+		__field_struct(uuid_t, uuid)
 		__field(u8, source)
 		__field(u8, flags)
 	    ),
@@ -717,27 +718,21 @@ TRACE_EVENT(cxl_poison,
 		__entry->source = cxl_poison_record_source(record);
 		__entry->trace_type = trace_type;
 		__entry->flags = flags;
-		if (cxlr) {
-			__assign_str(region, dev_name(&cxlr->dev));
-			memcpy(__entry->uuid, &cxlr->params.uuid, 16);
-			__entry->hpa = cxl_trace_hpa(cxlr, cxlmd,
-						     __entry->dpa);
-		} else {
-			__assign_str(region, "");
-			memset(__entry->uuid, 0, 16);
-			__entry->hpa = ULLONG_MAX;
-		}
+		__assign_str(region,
+			     cxl_trace_to_region_name(cxlmd, __entry->dpa));
+		store_region_info(cxlmd, __entry->dpa, &__entry->uuid,
+				  &__entry->hpa);
 	    ),
 
 	TP_printk("memdev=%s host=%s serial=%lld trace_type=%s region=%s "  \
-		"region_uuid=%pU hpa=0x%llx dpa=0x%llx dpa_length=0x%x "    \
+		"region_uuid=%pUb hpa=0x%llx dpa=0x%llx dpa_length=0x%x "   \
 		"source=%s flags=%s overflow_time=%llu",
 		__get_str(memdev),
 		__get_str(host),
 		__entry->serial,
 		show_poison_trace_type(__entry->trace_type),
 		__get_str(region),
-		__entry->uuid,
+		&__entry->uuid,
 		__entry->hpa,
 		__entry->dpa,
 		__entry->dpa_length,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 20fb3b35e89e..a733b31b7799 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -828,8 +828,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    const uuid_t *uuid, union cxl_event *evt);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
-int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
-		       struct cxl_region *cxlr);
+int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len);
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
-- 
2.37.3

