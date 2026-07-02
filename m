Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B511A2C0B
	for <linux-cxl@vger.kernel.org>; Thu,  2 Jul 2026 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952258; cv=none; b=VV8NhvUhRvh4/ihMQYMkinLp3GptknzsJ+VzKS37B8k6COW6Xe3fPGZTWADKwxZn+ktnGvJS1saTUOIvKeIDlsH86oIWJFI6BRwxWbg9s8lhHwiXhZe0lZXHEByc7GuFOojhcr8fiLrNdiI44mJbYWHUjRahN4RJRkO/vBAx1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952258; c=relaxed/simple;
	bh=IRnPktXExwHS8O8vRGeWbb95GwtN9gS24CB7HZ496C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFbZYq+crk3lVH+fj4jRy/utN044vtOvIwiwDRv5rn8ejkHN5hGkQTVkCMuW8xrrd3c0xl1i12g0vXI5dBiIeHhkmQRyi3MLebMHvkjzqXNuHcjbdn5Yr7p3NvhtWorU8GwDHtf3nJnjR4om+I+DYDRllmpbRCy6qWPUE77ZIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QkdZ+ihv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QkdZ+ihv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782952257; x=1814488257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IRnPktXExwHS8O8vRGeWbb95GwtN9gS24CB7HZ496C8=;
  b=QkdZ+ihvdPoINJuPT2wY7GPJeLOS8RcGKIIPPBt93syICL2QkwNs+cjR
   RxsdRhzfd44k8Hhz7Djgt60Gqe9uXctv377ycHGiGjYg3DRwxspk1ngCg
   jY1B5YzTx6ug4mpywVm/hK7EzhbJiajKlwu43EOWLtl74i/7DGCy/XWAY
   u4odivnp6KgXXEvPccarok7EcrI+kIuWxOyXAYmR5Car65JKr835QPpuV
   fcxKcmLfm9c0BHdwF9hWZ5VTzHBQIg1J+RQZzc/Yd6ndJPH2YJZA+g+SL
   WN44Q2umvwysh02SXKbZqrVxhfgBqmsdp5iYH7X+1HyiaefpJuq0NG2lK
   g==;
X-CSE-ConnectionGUID: RSJA+k5tTTyT5ZjPO5B8DA==
X-CSE-MsgGUID: 6YqFyf/mQoe40fydVNFdcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83565778"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="83565778"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 17:30:56 -0700
X-CSE-ConnectionGUID: Bp2qjKPHTaGNEP9MG02RLg==
X-CSE-MsgGUID: r7iparIKSymVg8WWDh0EEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="275920058"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.139])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 17:30:55 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 2/3] cxl/core: Format the memdev serial number as unsigned in TP_printk
Date: Wed,  1 Jul 2026 17:30:45 -0700
Message-ID: <7b5c35da659d62ee4bec38f0427266ae4e3123f4.1782948930.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1782948930.git.alison.schofield@intel.com>
References: <cover.1782948930.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL memdev serial number is a u64 PCIe Device Serial Number, but
the tracepoints format it with %lld. Devices whose vendor OUI sets
bit 63 therefore appear with negative serial numbers in formatted
trace output.

Note that the trace data itself is already stored correctly as u64.

Format the TP_printk serial as unsigned decimal, %llu, to match the
underlying value.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/trace.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index d37876096dd7..c379d60047fc 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -107,7 +107,7 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 		memcpy(__entry->header_log, hl,
 			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
 	),
-	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
+	TP_printk("memdev=%s host=%s serial=%llu: status: '%s' first_error: '%s'",
 		  __get_str(memdev), __get_str(host), __entry->serial,
 		  show_uc_errs(__entry->status),
 		  show_uc_errs(__entry->first_error)
@@ -166,7 +166,7 @@ TRACE_EVENT(cxl_aer_correctable_error,
 		__entry->serial = cxlmd->cxlds->serial;
 		__entry->status = status;
 	),
-	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
+	TP_printk("memdev=%s host=%s serial=%llu: status: '%s'",
 		  __get_str(memdev), __get_str(host), __entry->serial,
 		  show_ce_errs(__entry->status)
 	)
@@ -206,7 +206,7 @@ TRACE_EVENT(cxl_overflow,
 		__entry->last_ts = le64_to_cpu(payload->last_overflow_timestamp);
 	),
 
-	TP_printk("memdev=%s host=%s serial=%lld: log=%s : %u records from %llu to %llu",
+	TP_printk("memdev=%s host=%s serial=%llu: log=%s : %u records from %llu to %llu",
 		__get_str(memdev), __get_str(host), __entry->serial,
 		cxl_event_log_type_str(__entry->log), __entry->count,
 		__entry->first_ts, __entry->last_ts)
@@ -279,7 +279,7 @@ TRACE_EVENT(cxl_overflow,
 	__entry->hdr_head_id = (hdr).head_id
 
 #define CXL_EVT_TP_printk(fmt, ...) \
-	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\
+	TP_printk("memdev=%s host=%s serial=%llu log=%s : time=%llu uuid=%pUb "	\
 		"len=%d flags='%s' handle=%x related_handle=%x "		\
 		"maint_op_class=%u maint_op_sub_class=%u "			\
 		"ld_id=%x head_id=%x : " fmt,					\
@@ -1088,7 +1088,7 @@ TRACE_EVENT(cxl_poison,
 		}
 	    ),
 
-	TP_printk("memdev=%s host=%s serial=%lld trace_type=%s region=%s "  \
+	TP_printk("memdev=%s host=%s serial=%llu trace_type=%s region=%s "  \
 		"region_uuid=%pU hpa=0x%llx hpa_alias0=0x%llx dpa=0x%llx " \
 		"dpa_length=0x%x source=%s flags=%s overflow_time=%llu",
 		__get_str(memdev),
-- 
2.37.3

