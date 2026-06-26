Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBF63C81B6
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jun 2026 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782456969; cv=none; b=hnvFtHUf9HpryyQz0ZYW/SHEE5R5e95O4+x2ZelN0zdK/cFTQf9T0DKTkD1VhMz+SnH1Oz5VxoD4p3iDbk/kPAtvTefD9u9RkjL2u2MUhPRTk5ezv3JADCDCcAoyBrptOAJmVRIXJy0nYssy1Hc4NUMswmZLtOnR6MHEfI9z738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782456969; c=relaxed/simple;
	bh=hBO3fzaslaoxTxxwV/97htR4gR1dlBLu3SsAm+it1ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfkhzNVwjIT4ShIXVvgPPABivXIZkaCREGFBxNiuLQJa+3ZjcajJGJtXN7TE/DBQSw3FcvTcnZSLx+ondwqVHZkvoYY9CmXoeGEh26jcYEH7OIxHIcKqu9mLgxteqaakUTg+rGix0xUjxMXMr10i459KwDrYNpgNRcjz946azyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUIqvmkZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUIqvmkZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782456968; x=1813992968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hBO3fzaslaoxTxxwV/97htR4gR1dlBLu3SsAm+it1ik=;
  b=hUIqvmkZWa4u3OMBgzrB0K9tlLslqqAI1g+1qE2Yie/fAYGG2dTkVis4
   lC0tv5kCDP//Vq9FD3GvAWfsYkLu00DJJHNNaGcGJRtHCBkT5Vf2JsE9T
   9sgMuZEqvL/Lhre1LCH9I6dJgPwmsQ00L2JA9WsX2smCk7gLyF85B24ez
   /eEEiNLVsfEmBtLoMP0+gO0p9hzmSCG3KGGJf8AF1Djy6XGp9/qMO3t4k
   PuDPlcBhRXL6XcuQY33SGR5JjlMpXogAjVMlhrloAVBjHc6XCRGkVPsdo
   GFedbTzG3JsyDmQ77Ty4LRYJeT9wr1tIgl4l7rYsxvPdgYY9x1lq+gpsz
   w==;
X-CSE-ConnectionGUID: 33szraD6QJ6QgCwF6oJYbg==
X-CSE-MsgGUID: QtFnBM+BRG+4zsR5w0YSrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="85802337"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="85802337"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 23:56:08 -0700
X-CSE-ConnectionGUID: Z8FIXWuASSaPzL369Bc1Ug==
X-CSE-MsgGUID: DI6gJO+qSrKvunDrRJuEHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="244865876"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 23:56:06 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-cxl@vger.kernel.org,
	junjie.cao@intel.com,
	qemu-stable@nongnu.org
Subject: [PATCH 2/6] hw/cxl: destroy primary CCI before re-initialization on reset
Date: Fri, 26 Jun 2026 14:21:45 +0800
Message-ID: <20260626062149.1844334-3-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626062149.1844334-1-junjie.cao@intel.com>
References: <20260626062149.1844334-1-junjie.cao@intel.com>
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
index cba05ec57d..4ac6eaa950 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1073,7 +1073,15 @@ static void ct3_exit(PCIDevice *pci_dev)
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
@@ -1328,6 +1336,9 @@ static void ct3d_reset(DeviceState *dev)
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

