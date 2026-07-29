Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF74D98EF
	for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336476; cv=none; b=hjwBNIUpknD8WkZU6p9V+hloDXPH0pMi0y8MwliA4XGdfxW5I4QWNbvIUIt3PJ+UhGBuc/A9q2baBqdnb5sB3wFEDlIteRcZtmwyYHAdXL/0h13SA9YbtPXSgMLoarFGhhrxi47e8mKTAu+1AUXU9uxcmbeA6hNvY7HfiR0+Tgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336476; c=relaxed/simple;
	bh=vbh6j/yVXhjUgJsuEkmBoPmh0Q2oLphjP1TzurM+BmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DT5ivwGSRQ+2dC2e+r+ViIHNLOsQx2RVBxXVGHDkVcjYvyXYA2cdqTrFux9LcG/B1VVuSTayQqdCr7xWrFMNz3DOr3hx7hUnxQ4frvgjpFZT7qo5PaGiLOHQw2f6D+7E4lRL7X4Z0216WDhEvjr1TsIEvEir9dxHVR2owQY7M6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGMY3vEV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGMY3vEV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785336474; x=1816872474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vbh6j/yVXhjUgJsuEkmBoPmh0Q2oLphjP1TzurM+BmM=;
  b=IGMY3vEVNAGXTRHx+zqt3b0cgaU3gBj0OkHVjCAahlAHh91KG2JZDRYQ
   rscqLT78KWxUBU8lTZCWf6rZ802mKYYFBky79n3nVvV5P74Mf6CdEAzXC
   tBdKW7HP8r34iokeVg/kt2+nYvur2o01KWC5TzYutUlEODsiYNZQQg+R8
   G2d0Uvkm+Oyx12AZINu7iyK+skP+1xG502DUscaH32GiGurKnb1sSOEfc
   Iebna/QchGuVg6KAjPNGqtfRTLzOG2JthtiRYvy9s867KJEyS31OX/0tV
   AAh4b2/hOKwbHIqpIs3BYAfPkfmgw/FsrTPNqfqRvwVIrZ2zglPJvtBDR
   A==;
X-CSE-ConnectionGUID: 7kes1MeETaOnOGTI9w+HYg==
X-CSE-MsgGUID: 45toIIu3RQyHbh8vMSgHXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86133635"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="86133635"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:47:54 -0700
X-CSE-ConnectionGUID: d0yMF8R2RsqTRxp/mGLOKw==
X-CSE-MsgGUID: t6i3EbevR36Zs68m4BAXkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="258788811"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:47:52 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	philmd@oss.qualcomm.com,
	qemu-stable@nongnu.org
Subject: [PATCH v3 5/7] hw/cxl: discard in-flight sanitize state on mailbox teardown
Date: Wed, 29 Jul 2026 22:46:43 +0800
Message-ID: <20260729144645.1552511-6-junjie.cao@intel.com>
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

Per CXL r4.0 Section 8.2.9.4, "Background commands do not continue to
execute across Conventional Resets."  If a Media Operations sanitize is
in progress when the device is reset, the background timer is cancelled
and freed via cxl_destroy_cci(), but the per-operation state
(media_op_sanitize) is heap-allocated separately and would be leaked.

Free it from cxl_destroy_mailbox_t3(): the timer that advances the
operation lives in the CCI torn down there, so the operation can never
complete once the mailbox is gone; preserving the heap state has no
benefit and would leak it the next time media_op_sanitize is assigned.
Routing the discard through the mailbox teardown also covers device
unrealize, where ct3_exit() previously leaked an in-flight sanitize.

The completion path in __do_sanitize() frees the same state; factor the
free into a cxl_discard_media_op_sanitize() helper used by both places,
so the whole media_op_sanitize lifecycle now stays within
cxl-mailbox-utils.c.

Note that Section 8.2.10.9.5.1 additionally requires a device whose
Sanitize was interrupted by reset to remain in the Media Disabled state
until a successful Sanitize completes.  That latch is not modelled here
(reset re-enables media via memdev_reg_init_common()) and is left for
future work; this patch only addresses the resource leak.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index bc00fec9f8..cbd6ebf9fe 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2636,6 +2636,12 @@ static int sanitize_range(CXLType3Dev *ct3d, uint64_t dpa_addr, size_t length,
     return address_space_set(as, dpa_addr, fill_value, length, mem_attrs);
 }
 
+static void cxl_discard_media_op_sanitize(CXLType3Dev *ct3d)
+{
+    g_free(ct3d->media_op_sanitize);
+    ct3d->media_op_sanitize = NULL;
+}
+
 /* Perform the actual device zeroing */
 static void __do_sanitize(CXLType3Dev *ct3d)
 {
@@ -2653,8 +2659,7 @@ static void __do_sanitize(CXLType3Dev *ct3d)
         }
     }
 exit:
-    g_free(ct3d->media_op_sanitize);
-    ct3d->media_op_sanitize = NULL;
+    cxl_discard_media_op_sanitize(ct3d);
     return;
 }
 
@@ -4848,6 +4853,12 @@ void cxl_destroy_mailbox_t3(CXLType3Dev *ct3d)
     if (ct3d->cci.initialized) {
         cxl_destroy_cci(&ct3d->cci);
     }
+    /*
+     * An in-flight Media Operations sanitize is only advanced by this CCI's
+     * background timer; with the CCI gone the operation can never complete,
+     * so its state would otherwise be leaked (CXL r4.0 Section 8.2.9.4).
+     */
+    cxl_discard_media_op_sanitize(ct3d);
 }
 
 static const struct cxl_cmd cxl_cmd_set_t3_ld[256][256] = {
-- 
2.43.0

