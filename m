Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D64C9541
	for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336472; cv=none; b=q30v13tZEI7NWBNX++k6sbPHI1/yezgDHQQ9Mp5GRasHbBEZ78h//mH1X578jHHjgA/S8gATW0IGb5cetFEcFkF6Q/yNqFpB8l1lZ4Pjl1PuvCTNXxcAQZVyT2iwK/XbY+IOxD8zaZnLUo/O42KcdJUMXrWkw6h7PNhhAAQxUfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336472; c=relaxed/simple;
	bh=IZkVYtHbGkW+5yL2wuZYKdTkdZ36MHZfVxyXkH+h+HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9R0CX/0IfZLxrp6fEDJT2VKIFejlDjkLO/sohWI53CTwLxjKNXL6oSbKOUFzDq+uHnR59s+9mVaDqABpkWKVJ2+6NiWo0FYXgBBYY76vb/5T5ICRBlEsQV0dLDP9UkwUkRxQN2xMywj/aakUOBo7IAz9qFbVW7b1e0Y6fjfKxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwAoiL7P; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwAoiL7P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785336470; x=1816872470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IZkVYtHbGkW+5yL2wuZYKdTkdZ36MHZfVxyXkH+h+HU=;
  b=ZwAoiL7PNNTa+GcX84h+/DsRovq/Z0hA735j4Iyk3JMNs/cNxc8ksix8
   EvdvVboN/C22skk4Vaa7s7SyBgxK90Ln9k3qgzJKit6AsT7SCWS8mr2Jj
   J/CrdgAmgSm+g3+xNoCcNU5iKqhQ6GZOfM+KlSmpjJuQjr33Kxawl1UJt
   XN6bkHOk7NI9+vpKnmZ2YL3fVrNFL89DRY5FNErZ5tNEeEZ4fknP/G+cO
   msvfpH6in0BSg9scsrBlYh+l0Pweq7DEbFRyi37y2+QJL2qTtay+13s0g
   QokwOOlu1P684YyXjbyA0jOpb9jJ7njMiUkjVMEqN7sz6ZtDmYdgDHvTe
   w==;
X-CSE-ConnectionGUID: a4bRitDxTJiHul/WuJGyuw==
X-CSE-MsgGUID: 6NoZxZboSbazWuQqKUHM4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86133623"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="86133623"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:47:49 -0700
X-CSE-ConnectionGUID: TtCttvBERSuJ8I4sUEQB5g==
X-CSE-MsgGUID: bl4qEm4nQ5azkvwTzO3sDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="258788806"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:47:48 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	philmd@oss.qualcomm.com,
	qemu-stable@nongnu.org
Subject: [PATCH v3 3/7] hw/cxl: convert cxl-type3 to three-phase reset
Date: Wed, 29 Jul 2026 22:46:41 +0800
Message-ID: <20260729144645.1552511-4-junjie.cao@intel.com>
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/mem/cxl_type3.c          | 16 ++++++++++++----
 include/hw/cxl/cxl_device.h |  2 ++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d730a25645..ce2cb6558c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1329,13 +1329,18 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
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
@@ -2467,6 +2472,7 @@ static void ct3_class_init(ObjectClass *oc, const void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
     CXLType3Class *cvc = CXL_TYPE3_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     pc->realize = ct3_realize;
     pc->exit = ct3_exit;
@@ -2480,9 +2486,11 @@ static void ct3_class_init(ObjectClass *oc, const void *data)
 
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

