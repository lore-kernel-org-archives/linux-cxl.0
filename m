Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C04DBD6B
	for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336477; cv=none; b=H+Ij23iMnrmsOV7S9+zfSbe0fCVmlSEF48MnIalz5Tn15crT7M+zk3eBmCBBsJomWSC5lRaBSFcnWrdv3wUGLM103Xy98NEATBZJczha87HqG7G4F4fS6XBgSn8CjJhXMAFm8Fq4E5pYIxi7fz6glwV/fe2zVzqXXMnyqyUF/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336477; c=relaxed/simple;
	bh=0LPXenqXy+FBHwOhYVrUaTV2tGSOIChI14pMrmNyX60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d824N/eifDKtUnEhtWojOyJLP0qHQI20f1jZWyJEPkwgKzfb0R8yDN85wMIb7C6/PxazzbiHBYEHbZNXBv4EOWIxQ73V8Sb+qaijxXrZ7B7J1dMp20/h53flpRVLgexLTD/8tZRdLWTA2A7tcvr3odEik9t+hDiDhQY1kneQt2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSbG1PIV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSbG1PIV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785336476; x=1816872476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0LPXenqXy+FBHwOhYVrUaTV2tGSOIChI14pMrmNyX60=;
  b=WSbG1PIVj8cfAdrz2QMZi0915hDfumTHeIobgBmQA/YfXwVdixIbw4+p
   jwqi3B9RkN2DdKGAmtgnrkphk2cuPqwNuo4AnFemlZTabZ1lohXRPApBC
   0r4A0qzpoRgnOzPt7deOtXjMNUBQnPd4cHXuN5s/xcLST/7EXV6FyUB+h
   2Xow+SDAf75dhBzqhcHqoWaBqyD7grKqRjV5qciTVvIVrDGpir6yQvArX
   2wXhDXWUl7oUCilJ9JFzdm5jEcysO0d2t2OkShUNJZ2cNz1QI6be1JdpF
   RK/5MZTVvKNTAvAaE/qN2FdvzQE8OuI1KmHB9xyZCBjy+/3jIZyGXXugn
   w==;
X-CSE-ConnectionGUID: kk4v4JMrS96VsVwIixIuiA==
X-CSE-MsgGUID: HxZJT0OCRImZgurZMOmuaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86133641"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="86133641"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:47:56 -0700
X-CSE-ConnectionGUID: 254ZiHc/QHGUWJcThx+Qyw==
X-CSE-MsgGUID: jgAzanGPQ7ylU6UXzgpNiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="258788847"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:47:55 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	philmd@oss.qualcomm.com,
	qemu-stable@nongnu.org
Subject: [PATCH v3 6/7] hw/cxl: clear event logs, scan media and interrupt policy on reset
Date: Wed, 29 Jul 2026 22:46:44 +0800
Message-ID: <20260729144645.1552511-7-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729144645.1552511-1-junjie.cao@intel.com>
References: <20260729144645.1552511-1-junjie.cao@intel.com>
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
index 3a5eea76f2..2392358071 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1360,6 +1360,23 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
     }
     cxl_initialize_t3_ld_cci(&ct3d->ld0_cci, DEVICE(ct3d), DEVICE(ct3d),
                              512); /* Max payload made up */
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

