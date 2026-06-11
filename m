Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D63876A9
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160846; cv=none; b=dsQN+pNpTU1K7bIxoh43q0f5HWJa3jgIoRzBLGF61XiSxixZpmobptpRFEwOdj+HEHlGulQOLa1pMscbpZvA2xHUGrp+cSLfVT3k/A/zoHCLg/3Nue/4GwWqu+NQv05GhvTh9Lc9KvObbXikmmDTKA6LsvgnXj9afpLX1GZ64gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160846; c=relaxed/simple;
	bh=qup0vXFsbeVo8wh1KUc1tA872Gp1A1fyFRgp6CLCQlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbsrTSGFKIV8L8VnMtAxK+k3VqM//eBLy5i2vD7qtd4awuAO+rCW3kY1nZBUyXjmrrW+rqMGnHnn7KnzUcMlg4O5ft8kw9EIpAQh4rWbfyoTwi94AfISiI/5zoGEExopoLclS6G/9oMCRjOCwbVxb/XzDIpyxFvTbZ4bCEx9mM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVDgaTHJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVDgaTHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781160843; x=1812696843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qup0vXFsbeVo8wh1KUc1tA872Gp1A1fyFRgp6CLCQlk=;
  b=MVDgaTHJmqdB3ddjE0humyidC8J4nE1Jvsgdfpj4feBI52reBl9lXyDn
   2svfb50v0InJe6TtFKlrimX9OhBEgj2M3Oa3cpVf6qwVAtxCNx1jFOeYp
   nVom7H38ymQuwbeuAnxO2kn9GjIkOkH/MMaDdja2Elp/67qdR9PdkCyOM
   XeCksjxv4Po97bfXFLH5p1jEztb9ybofq6RJYfFgpEyGfPfhcBHdtnMUx
   NQrNMyiWMqHA3vWCJn11fqxoWAz/d1EbbeZQXugstfY0tnh1U0U2ZSwQI
   2qUawLmUtu0D5uSMK2T3RBCRZF3+tFcNGNjHv48ClXcXhbMVpZuDzw7/+
   A==;
X-CSE-ConnectionGUID: sTwl7olyRwKqfQXsG8T2eg==
X-CSE-MsgGUID: 6ar+7J1cSe+Ut2nQnFAHDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85595500"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="85595500"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 23:54:02 -0700
X-CSE-ConnectionGUID: Yt3EXWXKSPOSxTY3+4RcFg==
X-CSE-MsgGUID: XIhIlnedRmmRiXMD1Z5BfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="246469849"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 23:54:00 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jic23@kernel.org
Cc: fan.ni@samsung.com,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	junjie.cao@intel.com
Subject: [PATCH v2 5/5] hw/cxl: trace CFMWS address-to-device routing
Date: Thu, 11 Jun 2026 14:30:27 +0800
Message-ID: <20260611063027.1166493-6-junjie.cao@intel.com>
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

Add trace events for the CXL Fixed Memory Window address routing path.
This translates a host physical address through interleave granularity
calculation and up to two levels of HDM decoder lookups (host-bridge
and optional switch USP).

Two trace points are added:

  cxl_cfmws_lookup          - entry to CFMWS decode with the computed
                              root-bus interleave index
  cxl_cfmws_target_resolved - HDM decoder produced a port target (fires
                              for both host-bridge and switch USP lookups)

In non-passthrough topologies, a cxl_cfmws_lookup without a following
cxl_cfmws_target_resolved indicates the host-bridge HDM decode failed.
Passthrough-mode routing goes through pcie_find_port_first() without
HDM decoding, so no target_resolved event is expected in that case.
A dedicated passthrough-mode trace event is deferred pending upstream
passthrough topology support.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-host.c   | 4 ++++
 hw/cxl/trace-events | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index a94b893e99..0efdfcdfa7 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -21,6 +21,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
+#include "trace.h"
 
 static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
                                            int index, Error **errp)
@@ -169,6 +170,7 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
     PCIDevice *rp, *d;
 
     rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
+    trace_cxl_cfmws_lookup(addr, rb_index);
     hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
     if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
         return NULL;
@@ -191,6 +193,7 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
         if (!target_found) {
             return NULL;
         }
+        trace_cxl_cfmws_target_resolved(addr, target);
 
         rp = pcie_find_port_by_pn(hb->bus, target);
         if (!rp) {
@@ -227,6 +230,7 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
     if (!target_found) {
         return NULL;
     }
+    trace_cxl_cfmws_target_resolved(addr, target);
 
     d = pcie_find_port_by_pn(&PCI_BRIDGE(d)->sec_bus, target);
     if (!d) {
diff --git a/hw/cxl/trace-events b/hw/cxl/trace-events
index 17f9e7059c..0cfaa0c128 100644
--- a/hw/cxl/trace-events
+++ b/hw/cxl/trace-events
@@ -9,3 +9,7 @@ cxl_mailbox_payload_error(uint8_t set, uint8_t cmd, const char *name, size_t len
 cxl_event_insert(int log_type, int occupancy) "log_type=%d occupancy=%d"
 cxl_event_overflow(int log_type, uint16_t overflow_count) "log_type=%d overflow_count=%u"
 cxl_event_clear(int log_type, int nr_recs) "log_type=%d nr_recs=%d"
+
+# cxl-host.c
+cxl_cfmws_lookup(uint64_t addr, int rb_index) "addr=0x%"PRIx64" rb_index=%d"
+cxl_cfmws_target_resolved(uint64_t addr, uint8_t target) "addr=0x%"PRIx64" target=0x%02x"
-- 
2.43.0

