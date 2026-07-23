Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864F818CBE1
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 01:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769444; cv=none; b=A9FKgArs6bBwYi6PLoYwvh4W0q1jjGZMlMDrc0bsUQOdsEPf7H32ufMUhvth/SEs1o8EDwu3T5xwxB+sOBfawpmQxLitsbp53vUcJ6EeEryyZVBevRhORcfqtaurZx5Z+8RNBSa4qkPy4FXlKhZ5JIJEYDCM3o7b/9LeS1pc63Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769444; c=relaxed/simple;
	bh=/QW+6bMVfdc3+/VQ5V93oBga9b/YPL0PkvFyIV5avEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogxdOzGXRtRvgTeWnkfV7sFPHqrpx8xfQwBSxC41BvSgAr8VNp7P4SAWLZXcgsVrEUmfmPhM4MuHSRkZ+a7bqmcU4ik2ofqk9SLZMMi+19G23EzVeG8NmU4jAw/xahC5Qrl3l0+Coeo+yJXoepkNa4h8+Hub+VeLBAmjwAo3NQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a40gZNkb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a40gZNkb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784769442; x=1816305442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/QW+6bMVfdc3+/VQ5V93oBga9b/YPL0PkvFyIV5avEA=;
  b=a40gZNkbIp/3zcsfVSQPpdmm3uUOOicinkCtEp0vID9bpi/Cyl4vh/V5
   Xh5YNVRWh5IsA10G6DNj8Ho5eZ7PXTOCW8UQuFKlcIyrT60GtpJe3xmWo
   CdTv4ZLo8CFpCdz4natf0jdY63+Xk5VP+XNVyh9DpbMCBSCqzDIl7LRIr
   was55V2UHYclzmc3g2iEvNL/ng8Rtji/xxPuYouXj+vlsoxCVpspcfDeP
   XtEw3oklrxCbcN25oXmvsXQxe2VbALUO2a9aC3iNIQKEV4jUXKYZRpgA2
   H1fm+UTSSmbKxSX0nITlVmNRsAwkGBKjEd21rQYvPgdLPqSr4NwryFZQ2
   g==;
X-CSE-ConnectionGUID: GJmr2wYYSOmzHr2b9blbFQ==
X-CSE-MsgGUID: imXogSjsR42Nv5NMWYMG+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96074843"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="96074843"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 18:17:22 -0700
X-CSE-ConnectionGUID: cj7CMRtFSOqmc9+SVmQkLQ==
X-CSE-MsgGUID: c1A9hUpoTTC97+e0urPpmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="251943350"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 18:17:21 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	qemu-stable@nongnu.org
Subject: [PATCH v2 3/6] hw/cxl: convert cxl-type3 to three-phase reset
Date: Thu, 23 Jul 2026 09:16:22 +0800
Message-ID: <20260723011625.1117034-4-junjie.cao@intel.com>
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

Replace the deprecated device_class_set_legacy_reset() registration
with the three-phase resettable interface, following the pattern
already established by the CXL root port (cxl_rp_reset_hold).

Only the hold phase is needed; enter and exit are left NULL.  The
parent hold phase is chained for correctness: TYPE_PCI_DEVICE installs
no hold phase today, so parent_phases.hold is currently NULL and the
chained call is a no-op, but capturing and invoking it is the correct
forward-compatible pattern and mirrors cxl_rp_reset_hold().

No functional change — the reset body is identical; only the
registration path and function signature change.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c          | 16 ++++++++++++----
 include/hw/cxl/cxl_device.h |  2 ++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4ac6eaa950..b842e71c66 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1326,13 +1326,18 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
-static void ct3d_reset(DeviceState *dev)
+static void ct3d_reset_hold(Object *obj, ResetType type)
 {
-    CXLType3Dev *ct3d = CXL_TYPE3(dev);
+    CXLType3Dev *ct3d = CXL_TYPE3(obj);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(obj);
     uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
     uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
 
-    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed,
+    if (cvc->parent_phases.hold) {
+        cvc->parent_phases.hold(obj, type);
+    }
+
+    pcie_cap_fill_link_ep_usp(PCI_DEVICE(obj), ct3d->width, ct3d->speed,
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
                                        CXL2_TYPE3_DEVICE, ct3d->hdmdb);
@@ -2464,6 +2469,7 @@ static void ct3_class_init(ObjectClass *oc, const void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
     CXLType3Class *cvc = CXL_TYPE3_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     pc->realize = ct3_realize;
     pc->exit = ct3_exit;
@@ -2477,9 +2483,11 @@ static void ct3_class_init(ObjectClass *oc, const void *data)
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->desc = "CXL Memory Device (Type 3)";
-    device_class_set_legacy_reset(dc, ct3d_reset);
     device_class_set_props(dc, ct3_props);
 
+    resettable_class_set_parent_phases(rc, NULL, ct3d_reset_hold, NULL,
+                                       &cvc->parent_phases);
+
     cvc->get_lsa_size = get_lsa_size;
     cvc->get_lsa = get_lsa;
     cvc->set_lsa = set_lsa;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ba551fa5f9..b7e20e3fe4 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -805,6 +805,8 @@ struct CXLType3Class {
     /* Private */
     PCIDeviceClass parent_class;
 
+    ResettablePhases parent_phases;
+
     /* public */
     uint64_t (*get_lsa_size)(CXLType3Dev *ct3d);
 
-- 
2.43.0

