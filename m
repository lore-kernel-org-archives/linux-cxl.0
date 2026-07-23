Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077D71C84A2
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 01:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769448; cv=none; b=PTM6/0Nwp3L7eIvbl41onxJKVJZzVsxXqXdymACDhwQpKDTQvwaSCT++zzS9+2I6+20i2XYHOafOAupEJ2FXnHZAauHzf2IW8jOR1lC+uG58G7+7+7QoFafLad9RoC5AvxcAVfOLvUiqBRNQJci8fUSElk8XIRhQDsebMNDP48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769448; c=relaxed/simple;
	bh=msD/IOsgmuLyQHdlEUt3k5JKbV4W8J9VzDhB5nHKV2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwL8jcwk4+8dDrB5sW+af+d+kXQpuXoSEVC8Rch34erQigT4V93zM8UgtQ8RJwhIkrFP6OzbVAhtx+5X2KOYzlOFJP+EQedRGtEoSq/aQ37+62nS55SSeQNzKKBMOcQHdP5kgpUIjTlW4khEpwiY9Cqzwe4rDJXoOrl5C6RZdpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwvFRnUZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwvFRnUZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784769447; x=1816305447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=msD/IOsgmuLyQHdlEUt3k5JKbV4W8J9VzDhB5nHKV2I=;
  b=kwvFRnUZPFFX/TiOOKXOmBlC2i5Vl62sAjyYHAdHfUNf6E1slMs4oNoT
   a50bCYY1KyQcDGrl2727MSBL1hasPCNK52akXiWO7tTOLBUrQ5CBnT9gv
   c5ORnbjpWCARocHH1BRSx2Ssm+Z/y1S/PpwPILx13fob1zG5tXTELbrEI
   IBEAZGwhc447Ja3gJsxb6maznMKk14WWXP6PgGbuWZu0egGVqAtiapxf8
   hwxloWO4IL4lOV+mZS6X8m83BRQvJRk86JFPNpRHCNKz8PY8X7NAdLBxH
   C30B2QFnbkinWcxZSxdAokpTielK0qZgn/+8yfqVJcdXbcyXq4R7ir27q
   Q==;
X-CSE-ConnectionGUID: Dr2LI0MxQFi2BAhSFNGA+w==
X-CSE-MsgGUID: iV95w67MRramyOhjl0BUZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96074850"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="96074850"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 18:17:27 -0700
X-CSE-ConnectionGUID: Dl9Y9zC2RNaOcTDehEnZWA==
X-CSE-MsgGUID: OvRJj6M5RqWgR14rnKSHsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="251943358"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 18:17:26 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	qemu-stable@nongnu.org
Subject: [PATCH v2 4/6] hw/cxl: free in-flight sanitize state on reset
Date: Thu, 23 Jul 2026 09:16:23 +0800
Message-ID: <20260723011625.1117034-5-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723011625.1117034-1-junjie.cao@intel.com>
References: <20260723011625.1117034-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per CXL r4.0 Section 8.2.9.4, "Background commands do not continue to
execute across Conventional Resets."  If a sanitize or media operation
is in progress when the device is reset, the background timer is already
cancelled and freed via cxl_destroy_cci(), but the per-operation state
(media_op_sanitize) is heap-allocated separately and would otherwise be
leaked.

Free it unconditionally at the end of the reset hold phase.  The timer
that advances the operation lives in the CCI that was just destroyed and
re-initialized, so the operation can never complete after a reset of any
type; preserving the heap state across reset has no benefit and would
leak it the next time media_op_sanitize is assigned.

Note that Section 8.2.10.9.5.1 additionally requires a device whose
Sanitize was interrupted by reset to remain in the Media Disabled state
until a successful Sanitize completes.  That latch is not modelled here
(reset re-enables media via memdev_reg_init_common()) and is left for
future work; this patch only addresses the resource leak.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b842e71c66..a5e6df3033 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1361,6 +1361,16 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
     }
     cxl_initialize_t3_ld_cci(&ct3d->ld0_cci, DEVICE(ct3d), DEVICE(ct3d),
                              512); /* Max payload made up */
+
+    /*
+     * Free any in-flight sanitize state unconditionally.  The background
+     * timer that would advance it lives in the CCI just torn down and
+     * re-initialized above, so the operation can never complete after this
+     * point regardless of the reset type; keeping the heap state would only
+     * leak it on the next allocation.
+     */
+    g_free(ct3d->media_op_sanitize);
+    ct3d->media_op_sanitize = NULL;
 }
 
 static const Property ct3_props[] = {
-- 
2.43.0

