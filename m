Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41F4C9541
	for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336469; cv=none; b=AcKVd3sd89D7sGmnaJSY1ecUNqIgJ7Cx9qXSfIj8pUEiZEDGml3GiF9ecx8Dz8nHNsjvr2FePOeGS5NKJ071HjblFBd0vIviXRBcbNv0UtjuoDauDzSJkDSPoqL/9NQTRyCuLum3RrizGG7Qu4MBSABKIe9r4s62HTeVqnYwuW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336469; c=relaxed/simple;
	bh=EKJQjBaNTzDsYQ/c0wEU7XruIeRIsa+KlEE3cSskXJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sj/V9G/fyqP71bjyog64YlTbL+et3tja6ndW5bGQUW5AbG3J9Mnc1RaWSwoIl+Rc+CtLaHoYlLUaSB1TqQPkFUmd9PoSWqVSn9DCnKRNcsMnCWHRdYuRnx+SuW7vvG5fZNcAcn+F3d3x0KQKTawEnhT6M1bSD+9VvJolEEuBDH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfNvaDVj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfNvaDVj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785336467; x=1816872467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EKJQjBaNTzDsYQ/c0wEU7XruIeRIsa+KlEE3cSskXJ0=;
  b=FfNvaDVj8754IpZrMPDV7qZG/FylvclV6ULpHb1afCwpv3SF7TM35q8/
   dl7JpOkTZN1OwJxJl8F1HAldkbi4uOHWH0vegh47epKbJpVQgUycDhvEo
   tznb/MUzEfKEFvogx1sIGkqsA1KJgluHd2UtDD+s3t4VLCVg5o1ad+n6c
   y68RWxKgZqvX1BrsHIKGzaOhbztAUWERmJ7/pc6AfPz2J+9UykWGtGbqw
   Fc/X4s3Mj3C3tzMTCvVnDdBF/Zlr9BdxD+qxBYvTzi/9urKP0vDZIxFTT
   2aZUb/h1JlLN90YNgucM2xaF8d6JZgwys0UI1jPepYg31OAKhK4grLyW/
   Q==;
X-CSE-ConnectionGUID: rHUouAaLSoSFcJHPdMKDIw==
X-CSE-MsgGUID: DEzp9wQZT4KL73ICmIZbdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86133618"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="86133618"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:47:47 -0700
X-CSE-ConnectionGUID: XjlcosJtSieexzoMl42BEQ==
X-CSE-MsgGUID: z4KMsdawQA2qAUSptPKG8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="258788801"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:47:45 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	philmd@oss.qualcomm.com,
	qemu-stable@nongnu.org
Subject: [PATCH v3 2/7] hw/cxl: destroy primary CCI before re-initialization on reset
Date: Wed, 29 Jul 2026 22:46:40 +0800
Message-ID: <20260729144645.1552511-3-junjie.cao@intel.com>
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

ct3d_reset() re-initializes the primary CCI through the call chain
cxl_device_register_init_t3() -> cxl_initialize_mailbox_t3() ->
cxl_init_cci(), but never calls cxl_destroy_cci() first.  Each reset
cycle therefore leaks the old timer and leaves the old mutex
undestroyed while silently overwriting the CCI state.

Per CXL r4.0, the "Mailbox Interfaces Ready" bit in the Memory Device
Status register (Table 8-212) is set after a Conventional Reset or CXL
Reset once the device has re-initialized its mailbox interfaces.  The
CCI is the software abstraction of these interfaces and must be properly
torn down before re-initialization.

The secondary CCIs (vdm_fm_owned_ld_mctp_cci, ld0_cci) already follow
the correct destroy-before-reinit pattern in the same function; apply
the same discipline to the primary CCI.

Also destroy the secondary CCIs in ct3_exit() where they were
previously leaked at device removal time.  Guard the primary CCI
teardown there with the same .initialized check used for the secondary
CCIs: the primary CCI is only brought up from the reset path
(cxl_device_register_init_t3()), so a device that is unrealized before
its first reset would otherwise tear down a never-initialized CCI.

Fixes: cac36a8faffc ("hw/cxl/mbox: Pull the CCI definition out of the CXLDeviceState")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 28f41fa623..d730a25645 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1076,7 +1076,15 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
-    cxl_destroy_cci(&ct3d->cci);
+    if (ct3d->cci.initialized) {
+        cxl_destroy_cci(&ct3d->cci);
+    }
+    if (ct3d->vdm_fm_owned_ld_mctp_cci.initialized) {
+        cxl_destroy_cci(&ct3d->vdm_fm_owned_ld_mctp_cci);
+    }
+    if (ct3d->ld0_cci.initialized) {
+        cxl_destroy_cci(&ct3d->ld0_cci);
+    }
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
@@ -1331,6 +1339,9 @@ static void ct3d_reset(DeviceState *dev)
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
                                        CXL2_TYPE3_DEVICE, ct3d->hdmdb);
+    if (ct3d->cci.initialized) {
+        cxl_destroy_cci(&ct3d->cci);
+    }
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
-- 
2.43.0

