Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69863876D0
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 06:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160842; cv=none; b=vBTo3OLxjPB1tTjRmzEyxZ7eiJZ4WTIjekSKCxW2WGz1zJm+jhW/Oxr1N8cJ4ocpHVKb93RWJ/NZvlJaLtJggAKaJdBNHIy7xlUvOncSTXQVmC1i/r5EJABcmiZEN0M9wE+ufrnJSOQfIk0ymNJEyB1x5MhG1kC7ydPH3CdNwFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160842; c=relaxed/simple;
	bh=bjCmdxXe78AH05DYv6kC/9KUguuQjGAQp6spxywWFHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiqJHbZCK/rmSPStdvLVpE8qZ+fdsjJ5wgzhipAHfvrf8VnN3FA6IjWRRhfqmqlCjz4Uxw/DDf27CRYUF6/xyGHBz9lwSN0Z6hQWtJaMkca0oj1+avDYz5N4JHDWREjwZx0RoCUt8WA6/8TMS601wVYYahHjdJLqFiq/AZG0vVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SeNiCMzo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SeNiCMzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781160837; x=1812696837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bjCmdxXe78AH05DYv6kC/9KUguuQjGAQp6spxywWFHo=;
  b=SeNiCMzomawzDWH9M5B0rs2LM4148kT1cuh5gb6OTQQd/3vFAtOZIaIj
   nst1/meO/+aKvJB97uxsqZcLlpiBmwU/cSkJl5XzvKw4CQJMAyV0oCOWM
   xgTlgyUgIUCvudi9pAO3z6/GH9N0R2Jchxeh7iXuHKU7NDIIa47oXMUUu
   HTlMkLVdLY3iuzmwskDyiWmeYTr4zWNwjYm9GBUvRa38y64XQ3JhZzwGo
   eDwpfhyWPVz52FnguayzomC5VRmdnIGI7ZCblPCczjOSw2/cAVy+wL60R
   tXwMVvtYzG8QZTI2DTdEYPqmwcfov34Q2w12VMCHs+VlJ2YfHbA5QHbv/
   Q==;
X-CSE-ConnectionGUID: noQl0LKcROKydrw4VSgT0Q==
X-CSE-MsgGUID: 4hEU/aSJQ+6m3W2hXfJzsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85595483"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="85595483"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 23:53:57 -0700
X-CSE-ConnectionGUID: Oc6XA8rdTryoyY9ABve7LA==
X-CSE-MsgGUID: NbzhNLcVQpK5YutRdt3wSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="246469819"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 23:53:55 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jic23@kernel.org
Cc: fan.ni@samsung.com,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	junjie.cao@intel.com
Subject: [PATCH v2 4/5] hw/cxl: trace event log insertion, overflow and clear
Date: Thu, 11 Jun 2026 14:30:26 +0800
Message-ID: <20260611063027.1166493-5-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611063027.1166493-1-junjie.cao@intel.com>
References: <20260611063027.1166493-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add trace events for CXL event log activity.  Event insertion, overflow,
and clearing are exercised on every error injection or dynamic capacity
event, but the interaction with the per-log overflow counter was
previously opaque.

Three trace points are added:

  cxl_event_insert   - successful enqueue, with log type and resulting
                       occupancy (queue depth after insert)
  cxl_event_overflow - overflow threshold hit, event dropped, with
                       cumulative overflow count
  cxl_event_clear    - bulk clear with log type and number of records
                       removed

As a minor optimisation, cache the result of cxl_event_count() in a
local variable so the O(n) queue walk is performed once per insert
rather than twice.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-events.c | 13 +++++++++++--
 hw/cxl/trace-events |  5 +++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 5356dfb5b3..685ef5dc44 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -13,6 +13,7 @@
 #include "hw/pci/msix.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
+#include "trace.h"
 
 /* Artificial limit on the number of events a log can hold */
 #define CXL_TEST_EVENT_OVERFLOW 8
@@ -98,6 +99,7 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
     uint64_t time;
     CXLEventLog *log;
     CXLEvent *entry;
+    int occupancy;
 
     if (log_type >= CXL_EVENT_TYPE_MAX) {
         return false;
@@ -109,12 +111,15 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
 
     QEMU_LOCK_GUARD(&log->lock);
 
-    if (cxl_event_count(log) >= CXL_TEST_EVENT_OVERFLOW) {
+    occupancy = cxl_event_count(log);
+
+    if (occupancy >= CXL_TEST_EVENT_OVERFLOW) {
         if (log->overflow_err_count == 0) {
             log->first_overflow_timestamp = time;
         }
         log->overflow_err_count++;
         log->last_overflow_timestamp = time;
+        trace_cxl_event_overflow(log_type, log->overflow_err_count);
         return false;
     }
 
@@ -133,8 +138,10 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
     QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
     cxl_event_set_status(cxlds, log_type, true);
 
+    trace_cxl_event_insert(log_type, occupancy + 1);
+
     /* Count went from 0 to 1 */
-    return cxl_event_count(log) == 1;
+    return occupancy == 0;
 }
 
 void cxl_discard_all_event_records(CXLDeviceState *cxlds)
@@ -234,6 +241,8 @@ CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
         entry = cxl_event_get_head(log);
     }
 
+    trace_cxl_event_clear(log_type, nr);
+
     return CXL_MBOX_SUCCESS;
 }
 
diff --git a/hw/cxl/trace-events b/hw/cxl/trace-events
index 609def2dec..17f9e7059c 100644
--- a/hw/cxl/trace-events
+++ b/hw/cxl/trace-events
@@ -4,3 +4,8 @@
 cxl_mailbox_cmd(uint8_t set, uint8_t cmd, const char *name, size_t len_in) "set=0x%02x cmd=0x%02x [%s] len_in=%zu"
 cxl_mailbox_cmd_done(uint8_t set, uint8_t cmd, int ret, size_t len_out) "set=0x%02x cmd=0x%02x ret=%d len_out=%zu"
 cxl_mailbox_payload_error(uint8_t set, uint8_t cmd, const char *name, size_t len_in) "set=0x%02x cmd=0x%02x [%s] len_in=%zu"
+
+# cxl-events.c
+cxl_event_insert(int log_type, int occupancy) "log_type=%d occupancy=%d"
+cxl_event_overflow(int log_type, uint16_t overflow_count) "log_type=%d overflow_count=%u"
+cxl_event_clear(int log_type, int nr_recs) "log_type=%d nr_recs=%d"
-- 
2.43.0

