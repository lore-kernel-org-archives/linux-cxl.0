Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880AE215075
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 01:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769455; cv=none; b=njPZ2Ux1d1+0/2np9Gs9o/ChPE1sgeQBX6yZaUmM/oiI6Tvcn/6A5IwUVCk83bQjP1SDGRol80SQtDxuvz6NQiZ0MuuI2Et9WENl3rEZR1JvbpiRRZP6r+vOVPRh/JIiBB9M3L2DVJSsl25OJY57vfC/Ym3DaDMFJB+P1rkhjm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769455; c=relaxed/simple;
	bh=X6xEQGmKsqT36tEuVzuNvndUEQfjM0ecSdHXQUXdAaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBxZSlrVRIAFj/aQTQnlQBe9fE69M9PQltxGWY+5wJjJ/lngAa933P2qIeeKBKA8yNsfgHDe5rq8+TlK2q7SWWcKLJ6SmWRki+TxegD8y4rRrDbHd1v7Tc9D33K2Zkjvfc5x8HYvTAzbDpYAum5dajZ2dnByV7Tj3E+fYjDOvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDb/ZXGJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDb/ZXGJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784769453; x=1816305453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X6xEQGmKsqT36tEuVzuNvndUEQfjM0ecSdHXQUXdAaw=;
  b=NDb/ZXGJsFTbbepaleTxWDcm1wrC7Blnqq7s/3XNfuXp7ho8AnYFzjr4
   whbFwMA27NEH/tw/+EOTMvSf+WkDmekMLHoKmVOLTQvsm930drfMATgAI
   p4uTfsfZsfJqI+g2S7VtQPL1I7nVTDz7cGxZvJsFThzJOVEnSk+stsSRY
   nYy7tI9VV5s1qSppA4vlpvPmPwMfn0sb9iPe0CQ/IzoivqKq1uazlnoy6
   XC4KTgfbIe0LP63XeyJJJWMKH9tBOg2GhPm9zAQEl2C2m+zGSxzpN0U7H
   zhBdE0NIDcU4iPjLjGJ6QwBujhV5ILuKR6MXItMEte+m2WPIWaJwcVx4e
   Q==;
X-CSE-ConnectionGUID: 9dcxKFU3TcquxmlH4EhTsg==
X-CSE-MsgGUID: ii7ohwZQS66pdPOf4iyHug==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96074861"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="96074861"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 18:17:33 -0700
X-CSE-ConnectionGUID: eyUgdSFDREWExWZcDxv3bA==
X-CSE-MsgGUID: sZ11ZRZrR5Ga6XQpKQRfHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="251943363"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 18:17:32 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	qemu-stable@nongnu.org
Subject: [PATCH v2 6/6] hw/cxl: clear poison lists and feature transfer state on reset
Date: Thu, 23 Jul 2026 09:16:25 +0800
Message-ID: <20260723011625.1117034-7-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723011625.1117034-1-junjie.cao@intel.com>
References: <20260723011625.1117034-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The poison lists (active, backup, and scan-media results), their
associated overflow tracking, and the Set Feature partial-transfer
state are all device-internal dynamic state that accumulates during
the device's lifetime.

Per CXL r4.0 Table 8-309 (Identify Memory Device), the "Injects
Persistent Poison" capability bit (offset 41h, Bit[0]) controls poison
retention across reset.  When cleared — the QEMU default — "a
Conventional Reset or CXL Reset shall automatically clear the injected
poison."  Clear all poison lists accordingly, reusing the existing
cxl_clear_poison_list_overflowed() helper for the overflow tracking.

For the Set Feature transfer state, CXL r4.0 Section 8.2.10.6.3 (Set
Feature) requires: "If the Feature data transfer is interrupted by a
Conventional Reset or a CXL Reset, the Feature data transfer shall be
aborted by the device [...] the device shall require the Feature data
transfer to be started from the beginning."  Zero set_feat_info on
reset so any partially transferred Set Feature is abandoned and must
restart from the beginning.

Both clears run after the RESET_TYPE_WAKEUP early-return added in the
previous patch, so this state is preserved across a suspend-to-RAM
wakeup.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5bf0cffb72..1fe4d56762 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1326,6 +1326,16 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
+static void ct3d_clear_poison_list(CXLPoisonList *list)
+{
+    CXLPoison *ent, *next;
+
+    QLIST_FOREACH_SAFE(ent, list, node, next) {
+        QLIST_REMOVE(ent, node);
+        g_free(ent);
+    }
+}
+
 static void ct3d_reset_hold(Object *obj, ResetType type)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(obj);
@@ -1388,6 +1398,14 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
         ct3d->cxl_dstate.event_logs[i].irq_enabled = false;
     }
     ct3d->scan_media_hasrun = false;
+
+    ct3d_clear_poison_list(&ct3d->poison_list);
+    ct3d_clear_poison_list(&ct3d->poison_list_bkp);
+    ct3d_clear_poison_list(&ct3d->scan_media_results);
+    ct3d->poison_list_cnt = 0;
+    cxl_clear_poison_list_overflowed(ct3d);
+
+    memset(&ct3d->set_feat_info, 0, sizeof(ct3d->set_feat_info));
 }
 
 static const Property ct3_props[] = {
-- 
2.43.0

