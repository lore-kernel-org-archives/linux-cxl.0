Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9C73BA220
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jun 2026 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782456984; cv=none; b=U1ShsfDgKd1ZK1B/yPaIHIyRf8qcVJDf8KJ5rtd+ufdKE+p3x2yB2scaEQC6koIEtMR6a2hKvrGIeuL+wtY2ovB/NiO+O5pJA3/phfoZy+lagyWlAGiDa8u2YHuwVtcm/kdhaJqQTu7jQPna/GANGZ7sV2mQdntfQfSeKNnp6Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782456984; c=relaxed/simple;
	bh=X6xEQGmKsqT36tEuVzuNvndUEQfjM0ecSdHXQUXdAaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4cDjzte52Zk7QV6SMUHUkzuwkDMkKzRZY9a8XDhVsGQMmslutkIUz7w8j/JDA7ojcr/l4OHDmpu1CPYyuCxF1JML5qCDR9F5qLWIkREbl/F7ZOHulXtz6h+ifQoj8NdL4P0I1beFJy3UZHtDTZ3d0qCEbaKauWJWnYQX3ESzbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+D1h3EH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+D1h3EH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782456984; x=1813992984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X6xEQGmKsqT36tEuVzuNvndUEQfjM0ecSdHXQUXdAaw=;
  b=e+D1h3EHW2i1O3F8VDIr4yPBAqtlzVd6SQS5RdeR+CBUV+MjvUf+Eg+9
   WhIl8xGAha5PmVsxd+DEzNTuMXXatlI3VDS9K2aNFFq+vRYPsLFMNO2Ny
   G3Xets31Fs0kOpFZtIcr62TGmHIN45f2eRAjGKHX8oX4IcNWZx9Ab8Ase
   CBxCP8Ipj7luyk9n/jmT+5lY+wcT7IF9nCpq2kIgz1pnk+u0GZCyCPvET
   HqNtmue3R51NcW3//oFkIR5e0X2UankWiEeNWo6izZ5ngzHnZ6OCt5JpJ
   WCcSc4tkQCFbRVjX6jOTmvxgI0fvW+32WBqbxCtnt5EMc/Me6anIOHWi9
   w==;
X-CSE-ConnectionGUID: qfrAPzorSsmXGDsGWt73hQ==
X-CSE-MsgGUID: xBtJTuYNSqmufwsCsVG8Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="85802363"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="85802363"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 23:56:24 -0700
X-CSE-ConnectionGUID: GRpNmuGqSe2wG5uo1eUbfg==
X-CSE-MsgGUID: 5DOEQNMSRgCPp2qTpYFN2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="244865904"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 23:56:22 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-cxl@vger.kernel.org,
	junjie.cao@intel.com
Subject: [PATCH 6/6] hw/cxl: clear poison lists and feature transfer state on reset
Date: Fri, 26 Jun 2026 14:21:49 +0800
Message-ID: <20260626062149.1844334-7-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626062149.1844334-1-junjie.cao@intel.com>
References: <20260626062149.1844334-1-junjie.cao@intel.com>
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

