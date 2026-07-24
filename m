Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CA33603C3
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925448; cv=none; b=kLZK8Iz7cGMcwz4aPpp51GlNV5o3KxOJ5ETtu7Xs/N37ig5ocrgIKdTNXMUuojpeLZyMvuUboRIozUD9j3NxBNlxlAxstlfFMpOKd9FBTGVTycs+oWvaMNcGkxkAXLXlmGUDSEI34dVFWvnasMwnQ8r8pC/Xy+Xdp4W1uHsS/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925448; c=relaxed/simple;
	bh=IRnPktXExwHS8O8vRGeWbb95GwtN9gS24CB7HZ496C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFZE8vRS52j/nooKDlF/fpu2VpdcvYfZXd03S7C7Vy8myCK5cwvx1DrPWk+C9l7ZW2DWxwE3bU8YmzaEWa6hlOfVqjpxsjGIDF0bWBi88EFyYu9rD3Bp/B36UclOBLDLBovP3oS4Km8Xh2iYRYS9JgU/PI42suEj6kX3QdZezWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QoC7UYpK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QoC7UYpK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784925447; x=1816461447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IRnPktXExwHS8O8vRGeWbb95GwtN9gS24CB7HZ496C8=;
  b=QoC7UYpKo2lDhn6QfhXsL/GysHyeo9RU4f/QeD0XkkLVmkLgsoQKJM20
   M8Bqlgg4koPvKxJ7SYEpQaDDe8swxLmEST4HBijNh9WHJsBPqpxgf08om
   BBBBx3C3Udy67j0xmyeXdIywvqUoEU/G+OLDnqdiSC0Wrg6NhPiSuf7+L
   0C9By3ALut4T9IxVR9R7da3AASy6LUiHHrW2pAUDPxeHKb7av/GC1ACYJ
   mRIYfSWoXwpqOiM2fibjGfb2mFW3j1pN7yEmbaZJc6pObyMYlxj8FIqbR
   mGB3v8bSy79tu42Bb4CuTTECTaLKe+cRf1XqKO4b8FQfqNZ6QTGxKdda4
   Q==;
X-CSE-ConnectionGUID: Dh+Vme+zT4OfVBH95gJWsA==
X-CSE-MsgGUID: yz65zXZySWyGieXfrqbsuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="103008236"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="103008236"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 13:37:26 -0700
X-CSE-ConnectionGUID: CWwr03W+TwWOCClZoRAmZQ==
X-CSE-MsgGUID: Jo5lGMpARte+N38RleHQUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="258872387"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.232])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 13:37:25 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 2/3] cxl/core: Format the memdev serial number as unsigned in TP_printk
Date: Fri, 24 Jul 2026 13:37:18 -0700
Message-ID: <46651395b6c1e552ae2c4fecf3058a062eb0c3f0.1784924949.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1784924949.git.alison.schofield@intel.com>
References: <cover.1784924949.git.alison.schofield@intel.com>
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

