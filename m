Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A63C5856
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jun 2026 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782456978; cv=none; b=rj907v0AwT5dc6487WtIUvGVlutBlgoBOkC8uBbpJ7t/NfnejIivlYG6fl9apnsK+J6vEEuOkdUg3C5xwWHaC7EvtXDT89Y1oRS/dduwuhpyfWULSuPgXA8oRSMGWDPM91/q6Ia6kXCquxE++BElRNBNqa7/VEzGu0T7hSVud60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782456978; c=relaxed/simple;
	bh=msD/IOsgmuLyQHdlEUt3k5JKbV4W8J9VzDhB5nHKV2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Krqqky+bpafKkb4AR4fpC5lPAb4qIqky/90IzhPyjGzrmbQy+amo+nq0q523i2hWMuQVEyBy7aOz7AGP/0Hh+nEOEcIDoeEQx1Bxg75uP56Avqi4Hv5s4otfR8GuqAnrMfq53R4sEKII/ZZeUPeheFEOBdpFRvLqLaOcJ3g99jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BC8XyDXR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BC8XyDXR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782456977; x=1813992977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=msD/IOsgmuLyQHdlEUt3k5JKbV4W8J9VzDhB5nHKV2I=;
  b=BC8XyDXRLZHuOB22Zm26yBr5KGbghObsZynVPgsahEa/F9q+Mg3a6dtr
   raVYNBwdl3i5JE3ux+I68O760vQ5Y/r/nabVocdJn9gIrCDlAxFYtlG8+
   n9QSXwGH2BtA669BO5Qc0MCuJyYWwo9+VujitSiCpeOwn163v56R8pNr8
   YjW3r0Rbhid4nfHDG2N4qjEHH3uQIIBNK7Mx//WPQzJ8Bu6gKKor2fX8m
   LbIgGcBvy1qOZlKxuBhI1rOwVuLuMSSYhYj+FyyUd2uqoYqVxCJG/3PbQ
   24pIZDquk1HEvUNCnQn5zT4VgtznKUcod9+AIkrS69ubJQdiFRXHhNGaV
   A==;
X-CSE-ConnectionGUID: M4WpJPUKSX6d1GWCw2UZlQ==
X-CSE-MsgGUID: P00MPK71QjmqKJGM3VydbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="85802346"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="85802346"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 23:56:17 -0700
X-CSE-ConnectionGUID: RE1eX4R+QEm8ZMh339y7FA==
X-CSE-MsgGUID: pYhZOP3aTlmyINgEoZUj/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="244865887"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 23:56:15 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-cxl@vger.kernel.org,
	junjie.cao@intel.com
Subject: [PATCH 4/6] hw/cxl: free in-flight sanitize state on reset
Date: Fri, 26 Jun 2026 14:21:47 +0800
Message-ID: <20260626062149.1844334-5-junjie.cao@intel.com>
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

