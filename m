Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F62472AA
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 01:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769451; cv=none; b=u9I+DDlXmLfoEScTjYPFfg9Mto+tLiVYNVM6wUzepWmhLkIjwKgTtIuV8PotRKPo1W26Kw2MSb6QnJ4KuXa8np4ZPDjbHvek1IsSGKYxdQVUCPT6aRmaHIxP4yxUsSedyebhM3Wktdwklo28+2+4L588RrwrT8shlyRfgnnNSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769451; c=relaxed/simple;
	bh=LFZDeluVb0jYrFBCNzRihUZyA/8sIedwSTGxxS78Gns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8MCyN077LDh1cmuA+6TAZ8y947CKT48fhhhRHGwZp2WjoVfwQkionAMLw1y5oz0Bv5/a4zBdnp91534YhMcuKQ/O0pOm9PE44l9rPxRfaDsZ1w+fodO1HrjjT0o8Z8lcKv8zIUeKltk575qeHzr8lkYVRdYZuQLcdbx01qrbwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcQLHR2A; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcQLHR2A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784769450; x=1816305450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LFZDeluVb0jYrFBCNzRihUZyA/8sIedwSTGxxS78Gns=;
  b=kcQLHR2ACmOBsLS5igDTEVefgA/4M/sQNUh9o16irm3Rj09QLUrEPPFh
   c7hyK72+gnky1NP6DcjG4c8LBr5YeO9E0mqO4cv2ovaPSRVfccJKO2PL+
   NZRG6fLY9tc7z9CoSHpMHw8+yV1SvrZHUC0zwQaLo7ArKD4Cy6wV2KivQ
   hIo1oY+AG6mZ/5l05G4JZrHo7DpaD3krbHtJTL1jGwm3Rf7PQoUp1i9s/
   Jr7HxW/CVWaYFtN7WiQusMI+us6Lx4ryM4EkIrxrY1lMp/v0ldD71SM87
   5B4NwiUhVwC+L4CmDYNyYtFtz+KGIjEUrhRItqmP/E/cS2JNNg34sRggA
   Q==;
X-CSE-ConnectionGUID: z1xMMof3RYevnBdMJhLU7w==
X-CSE-MsgGUID: 9SIhQSUyTw+Kc55xcDEXOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96074858"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="96074858"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 18:17:30 -0700
X-CSE-ConnectionGUID: H+h8YyNAQWKTeVFtEXdS3g==
X-CSE-MsgGUID: yLavuJHuSj+zmx5W/s9Ezg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="251943360"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 18:17:29 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	qemu-stable@nongnu.org
Subject: [PATCH v2 5/6] hw/cxl: clear event logs, scan media and interrupt policy on reset
Date: Thu, 23 Jul 2026 09:16:24 +0800
Message-ID: <20260723011625.1117034-6-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723011625.1117034-1-junjie.cao@intel.com>
References: <20260723011625.1117034-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Event records, scan media results and event interrupt settings are
device-internal dynamic state that should not survive a device reset.

Per CXL r4.0 Section 8.2.10.9.4.6 (Get Scan Media Results), "If the
Scan Media command has not been called since the last Conventional
Reset, the device shall return the Unsupported return code."  This
explicitly invalidates scan media results across reset, so clear the
scan_media_hasrun flag.

Per CXL r4.0 Section 8.2.10.2.5 (Set Event Interrupt Policy), "All
event log interrupt settings shall be reset to 00b (No Interrupts) by
the device on Conventional Reset."  Clear irq_enabled for every event
log accordingly.

For the event records there is no direct spec mandate to drop the
stored records on reset; the Event Status register (Table 8-203) is
non-sticky and resets to zero per Section 9.7, and no reset flavor
requires the already-reported records to persist.  Draining the queues
is therefore a reasonable modelling choice that keeps the records
consistent with the freshly-reset status register, rather than a spec
requirement.  Call the existing cxl_discard_all_event_records() helper
to drain all event queues.  The event log infrastructure itself
(mutexes, IRQ vectors) remains intact as it is initialized once during
device realize.

This is also where reset-type gating begins: a wakeup from suspend-to-RAM
(RESET_TYPE_WAKEUP) is not a Conventional or CXL Reset and must retain
device-internal state, so the hold phase returns early for that type
before discarding any records.  This mirrors the RESET_TYPE_WAKEUP
shortcut in virtio-mem and virtio-balloon.  Only the unconditional
mailbox interface re-initialization and the in-flight sanitize free
(whose backing timer was already destroyed) run on a wakeup.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a5e6df3033..5bf0cffb72 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1371,6 +1371,23 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
      */
     g_free(ct3d->media_op_sanitize);
     ct3d->media_op_sanitize = NULL;
+
+    /*
+     * A wakeup from suspend-to-RAM is not a Conventional or CXL Reset.  The
+     * device-internal dynamic state cleared below (event logs, scan media
+     * results, and the poison/feature-transfer state cleared in subsequent
+     * patches) must be preserved across resume, so stop here for a wakeup.
+     * virtio-mem and virtio-balloon take the same RESET_TYPE_WAKEUP shortcut.
+     */
+    if (type == RESET_TYPE_WAKEUP) {
+        return;
+    }
+
+    cxl_discard_all_event_records(&ct3d->cxl_dstate);
+    for (int i = 0; i < CXL_EVENT_TYPE_MAX; i++) {
+        ct3d->cxl_dstate.event_logs[i].irq_enabled = false;
+    }
+    ct3d->scan_media_hasrun = false;
 }
 
 static const Property ct3_props[] = {
-- 
2.43.0

