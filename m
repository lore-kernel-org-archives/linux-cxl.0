Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E12C388E51
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160837; cv=none; b=QA0+/s45S0xt6rrsZzGk31rlqWHkGG2i4j6aP5OYmH6ltLz4vb8AdL4KuC2Va4zbZlMhQzy2JbAU5fzIlWJY+wTSchDlbS7iBI6RD/RKyqaeg54AeumoW+P3PaSBAzZ21DBXzgkECDTuMb1rMHazzR546bVgAqEXnfY8GNIg6wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160837; c=relaxed/simple;
	bh=XslrJf12EJ3eRNweZWttn06qZaJHFF63Vau0ofOISDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVqDNzkhBFVYCRWmJ7BuRvNe3TaWWDOWr068ahmhCLlWmAyFltvWl6HT2nhG2xEkSedyEKWBTzdcHUQaRFTGtXWUbltH8/gDP+Jhw5C48hZ3FubpOTFW30yTzjKKbDB7wAXhAfEcXHEs4SCP23F3gyMbSgwalmx24aq0Bvj9Z4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EiDtO6R+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EiDtO6R+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781160833; x=1812696833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XslrJf12EJ3eRNweZWttn06qZaJHFF63Vau0ofOISDk=;
  b=EiDtO6R+rOmRnGGXKezUoHKR0Qme+YU1leqxa5Sl7xcthwMD9cU25VLu
   1cs54qYMJR9PUnOxmJXKS5ABa8bUlNIERnVK68FRiV25sWFhG/VUPVZ8E
   uGmEVZ/jacB7YqjZIOqgq7/v3hmA2cifSXXfRvwSl4833Ux3aWT+EdHsh
   dAeM7NFhb6zUDDoNvdiWe6uPeUhP8EiWVLIGLx9MmyMeMvRhuNH9eZWx0
   UlG3sKUUuL8nhU5bGw/arrdsqjBQQeHBQVE6yfLdc7PQwOhB3PYSEq0Q7
   k5l4uTyuiRB1bBEtp2KxPLWne99S/e+ZRFYWcbWk3HhrgHcxmZpoo9o08
   Q==;
X-CSE-ConnectionGUID: H91TWBu8Ti6/IwYxN+OmWw==
X-CSE-MsgGUID: IqWMGZSHTu26z1pP094EHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85595474"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="85595474"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 23:53:52 -0700
X-CSE-ConnectionGUID: ONMn0cpuST+k+fUZDPrknw==
X-CSE-MsgGUID: VgodT8ZGTN22uX4QGF7vkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="246469799"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 23:53:50 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jic23@kernel.org
Cc: fan.ni@samsung.com,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	junjie.cao@intel.com
Subject: [PATCH v2 3/5] hw/cxl: trace HDM decoder write, commit and uncommit
Date: Thu, 11 Jun 2026 14:30:25 +0800
Message-ID: <20260611063027.1166493-4-junjie.cao@intel.com>
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

Add trace events for HDM decoder programming in the CXL Type-3 device
model.  These paths control address-decode behaviour and are among the
most frequently debugged during CXL topology bring-up.

Three trace points are added:

  cxl_hdm_decoder_write    - guest write to a decoder CTRL register,
                             with the raw value and commit flag
  cxl_hdm_decoder_commit   - actual commit with decoded base, size,
                             interleave ways (IW) and granularity (IG)
  cxl_hdm_decoder_uncommit - decoder uncommit with index

Base and size are extracted using the same split-register pattern
(ldl_le_p + 0xf0000000 mask) used by cxl_hdm_find_target() in
cxl-host.c, producing architecturally-meaningful addresses.  IW and
IG are extracted from CTRL via FIELD_EX32.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c  | 19 ++++++++++++++++++-
 hw/mem/trace-events |  5 +++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4739239da3..c3f7483b70 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,7 @@
 #include "system/numa.h"
 #include "hw/cxl/cxl.h"
 #include "hw/pci/msix.h"
+#include "trace.h"
 
 /* type3 device private */
 enum CXL_T3_MSIX_VECTOR {
@@ -419,13 +420,24 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
     uint32_t *cache_mem = cregs->cache_mem_registers;
-    uint32_t ctrl;
+    uint32_t ctrl, low, high;
+    uint64_t base, size;
 
     ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc);
     /* TODO: Sanity checks that the decoder is possible */
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
 
+    low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + which * hdm_inc);
+    high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + which * hdm_inc);
+    base = (low & 0xf0000000) | ((uint64_t)high << 32);
+    low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + which * hdm_inc);
+    high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + which * hdm_inc);
+    size = (low & 0xf0000000) | ((uint64_t)high << 32);
+    trace_cxl_hdm_decoder_commit(which, base, size,
+                                 FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW),
+                                 FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG));
+
     stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
 }
 
@@ -436,6 +448,8 @@ static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
     uint32_t *cache_mem = cregs->cache_mem_registers;
     uint32_t ctrl;
 
+    trace_cxl_hdm_decoder_uncommit(which);
+
     ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc);
 
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
@@ -623,6 +637,9 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
     }
 
     stl_le_p((uint8_t *)cache_mem + offset, value);
+    if (which_hdm >= 0) {
+        trace_cxl_hdm_decoder_write(which_hdm, value, should_commit);
+    }
     if (should_commit) {
         hdm_decoder_commit(ct3d, which_hdm);
     } else if (should_uncommit) {
diff --git a/hw/mem/trace-events b/hw/mem/trace-events
index 8b6b02b5bf..07c7315148 100644
--- a/hw/mem/trace-events
+++ b/hw/mem/trace-events
@@ -6,3 +6,8 @@ mhp_pc_dimm_assigned_slot(int slot) "%d"
 memory_device_pre_plug(const char *id, uint64_t addr) "id=%s addr=0x%"PRIx64
 memory_device_plug(const char *id, uint64_t addr) "id=%s addr=0x%"PRIx64
 memory_device_unplug(const char *id, uint64_t addr) "id=%s addr=0x%"PRIx64
+
+# cxl_type3.c
+cxl_hdm_decoder_write(int which, uint32_t value, bool commit) "decoder=%d ctrl=0x%08x commit=%d"
+cxl_hdm_decoder_commit(int which, uint64_t base, uint64_t size, int iw, int ig) "decoder=%d base=0x%"PRIx64" size=0x%"PRIx64" iw=%d ig=%d"
+cxl_hdm_decoder_uncommit(int which) "decoder=%d"
-- 
2.43.0

