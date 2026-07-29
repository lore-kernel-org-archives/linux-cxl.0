Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192714C041A
	for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336473; cv=none; b=kVrGyC7VrVhwMZfoEOIaK9Zgics4SkAEnk/CYkmr057YwNrMUqSRclhkrchRmrkazy1mvtvflpzXvxeXVzcrI8LBUTRMPPs8EtVRNW9yKYd7b0WK48zJOv8FdNtBJx6/wlYNbgKdteB3TpbYaDZKgLaQb+sqaFA4XGUxQIsn1kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336473; c=relaxed/simple;
	bh=+XEqTvJkhJL8Zjzo3UW1sPiWBb9hzsCcLzLQ1Vw9yso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BSAu6UOa8N7cmMM0OLTWB1camHnxfa+/fnB1gl6wqDW4EqpyBbYte+g5NCZuzwIieRA/i6MoOAO8UaXxILcsJe/Th1V5RXDdocoOr2bE7M27inpqaUB2RFcLbGd7SX5VMAX6rLKdjCdTvH/0ORgsQfHX+XZXdEJFU92kQsrKnks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7Rl2OpN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7Rl2OpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785336472; x=1816872472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+XEqTvJkhJL8Zjzo3UW1sPiWBb9hzsCcLzLQ1Vw9yso=;
  b=G7Rl2OpNsIIfLSfoeU6SuaxccWBasU2KDkpxhlcwoY/LGRcj33W2U+gq
   +zheE2w5qFb5XVg/IERM5dkqrXIu8iFuOovGCBRfCoGUe7ztcNWaUdU+K
   Mh2mFUCP7RoeuS9hYoC8cA52mQdPoNa2uo6X0oDSRG6wkA4UZmJqIs/sy
   DiwdRjrtuEoBTqCMJsa/yrShbsDp9rLkp/RkG1AJdhqJw0o1lS9CYOS/K
   rTzjX4Ma8AAxhilzJLalHV9g+FomuS7E/lzyRpjPvH4urIr0BfOSLODNP
   Ao/a+w12iYAC2KyOSdtUMbEntKmxEFL2M5TKtX7gio6ZqEO24Yy5QbFXd
   Q==;
X-CSE-ConnectionGUID: cGUsJ5gwQmmbY/bZGfBrgA==
X-CSE-MsgGUID: nSxY4kTeSnaYO3P8PizTbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86133628"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="86133628"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:47:51 -0700
X-CSE-ConnectionGUID: lNn4tTa/RfuIF7wDg75jtQ==
X-CSE-MsgGUID: AEbLXD/WRHa2Js+/w/uCxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="258788810"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:47:50 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	philmd@oss.qualcomm.com,
	qemu-stable@nongnu.org
Subject: [PATCH v3 4/7] hw/cxl: add cxl_destroy_mailbox_t3() as the mailbox teardown counterpart
Date: Wed, 29 Jul 2026 22:46:42 +0800
Message-ID: <20260729144645.1552511-5-junjie.cao@intel.com>
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

The primary CCI teardown is open-coded, guarded by .initialized, at
the two places that need it: the reset path (before
cxl_device_register_init_t3() brings the mailbox back up) and
ct3_exit().

Factor it into cxl_destroy_mailbox_t3(), the teardown counterpart of
cxl_initialize_mailbox_t3(), keeping the .initialized guard inside the
helper: the primary CCI is only brought up from the reset path, so the
first reset after realize and an unrealize before any reset must both
skip the teardown.

No functional change.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 7 +++++++
 hw/mem/cxl_type3.c          | 8 ++------
 include/hw/cxl/cxl_device.h | 1 +
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 603677a97b..bc00fec9f8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -4843,6 +4843,13 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
     cxl_init_cci(cci, payload_max);
 }
 
+void cxl_destroy_mailbox_t3(CXLType3Dev *ct3d)
+{
+    if (ct3d->cci.initialized) {
+        cxl_destroy_cci(&ct3d->cci);
+    }
+}
+
 static const struct cxl_cmd cxl_cmd_set_t3_ld[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ce2cb6558c..3a5eea76f2 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1076,9 +1076,7 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
-    if (ct3d->cci.initialized) {
-        cxl_destroy_cci(&ct3d->cci);
-    }
+    cxl_destroy_mailbox_t3(ct3d);
     if (ct3d->vdm_fm_owned_ld_mctp_cci.initialized) {
         cxl_destroy_cci(&ct3d->vdm_fm_owned_ld_mctp_cci);
     }
@@ -1344,9 +1342,7 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
                                        CXL2_TYPE3_DEVICE, ct3d->hdmdb);
-    if (ct3d->cci.initialized) {
-        cxl_destroy_cci(&ct3d->cci);
-    }
+    cxl_destroy_mailbox_t3(ct3d);
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index b7e20e3fe4..608d05165a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -325,6 +325,7 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
                                           CXL_DEVICE_CAP_REG_SIZE * 2)
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
+void cxl_destroy_mailbox_t3(CXLType3Dev *ct3d);
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
-- 
2.43.0

