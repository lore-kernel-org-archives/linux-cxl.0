Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2C14C8FE3
	for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336480; cv=none; b=QyZo1spKb1LZDXzvWjNHY2jt0Xb3WjXaPql/7MG5F8EpgUSu+wv3rJP02+vmy77w8jMgNd3Yv2Txmu4nPN8VDfNhYH1F5wig83vvw0WhAvU8N7hsnL2N6CFmI0hU4oJTxKwv0pOywopwzxc+A2LkKWNqn2CpmUAo06fSEnPbSZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336480; c=relaxed/simple;
	bh=TTMOY2fZFNZ9to25DAyguXipu7ZylHJM05ZnvGrBuk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQC77uqIQ4ggaFdBYzxMGwTWRAwotUNUotU6U2pEiEMorJExg+kODBi619a8/ijKuQf+WbUQNI+hxuQQGeSOkQvdO5CgnwWCtqfkXshZasMweDlY1EKI8Sz8V629y9jSFizNnYyDzodbxicNz8p/rcDMHdCPc7K+9zX2adEvoCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6qC1yXk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6qC1yXk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785336479; x=1816872479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TTMOY2fZFNZ9to25DAyguXipu7ZylHJM05ZnvGrBuk0=;
  b=j6qC1yXkgab+Kas29py0IrrYtXUohQoJuu8oD8hWVwktxNQt165hH0TQ
   vq3L0gCB4On+fsd3T4TlgCJPtAFFGqxrln/384sZmOpdQMD5Efq5Itcaz
   BkJPM0S/xmDEYCYG1Szx5FBwku176m+k4qZMMd7UIpLePfMM+J7Yu8luU
   h42pyxHDn2YXqMNCaLyTystJDvM3oAn2v5jDBKd+kdCxXi/tInrmJANq1
   d6XLI5pI/s/xR/dfHv4yG9kF6ZidCZINLCSqCSwKCfkDXmA0ZuSagPj/c
   8MiREyEsbqFWWy+Y7WK0EFtG3q8CWOAHIEDVR5tN8s/RW354PgCPM1puH
   Q==;
X-CSE-ConnectionGUID: K2V/YSxSTZWjTT2CUlw1HQ==
X-CSE-MsgGUID: wmdk9ocMSPK6Atl5Mx3SfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86133650"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="86133650"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:47:58 -0700
X-CSE-ConnectionGUID: DIRx8iN+TkyZQuHNiBIh1g==
X-CSE-MsgGUID: xxtaG2MHSyege38di/25Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="258788881"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:47:57 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	philmd@oss.qualcomm.com,
	qemu-stable@nongnu.org
Subject: [PATCH v3 7/7] hw/cxl: clear poison lists and feature transfer state on reset
Date: Wed, 29 Jul 2026 22:46:45 +0800
Message-ID: <20260729144645.1552511-8-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729144645.1552511-1-junjie.cao@intel.com>
References: <20260729144645.1552511-1-junjie.cao@intel.com>
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
index 2392358071..0b36485344 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1327,6 +1327,16 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
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
@@ -1377,6 +1387,14 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
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

