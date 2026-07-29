Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF8038330C
	for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336467; cv=none; b=KURqTIkWVWHSMXBYWvdPnp21fbZsb2cLHk0Tz9Nx7TZ5HZRvwzVjN7VReJi+mx38K4PkrTpuACOhIY0XJuvprbn0SH21u2qH+gpKCfRVcJFBlcEFCOqAf6lijN5crgI7Nk+hcaF8xuUfFRqxUmOiWZhwOQnA3Jixtth1iVNV3GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336467; c=relaxed/simple;
	bh=5PnG4xRW/GZtwi7X3p6EKgSZ/dyG9T25icwTsVBZ8kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrmscKOdHgOQjJIDs4ZZCESg+uRj5/18HyrWLVf8DGUMTVg1fE1P3irIXQEj2lwgync0pN6Li5+4CALBZdFdkok3oiCSpbCfQgjc6q3T3C7ORefUUpBwYjaqRlrDjtx2yiAj+hzGKIRMsmuELqCsSwX3ScKHW91UQypx8Zo+eK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgHx+KQy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgHx+KQy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785336465; x=1816872465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5PnG4xRW/GZtwi7X3p6EKgSZ/dyG9T25icwTsVBZ8kU=;
  b=DgHx+KQyxr66GoRpjU9v/8FUMXBsGTrhTl7afh7N/LrCA+DnPH1xlGQE
   YchL20rPGdq442TNMQ0zXx1HGh0fiXnH/24YFunyTRtbCrwXbUWw1ncMg
   tTJjtZ1UENwvojHVW7HzFuETIoTjIBpZ/Q+AV0pv33nX4fvlojc2dsH3B
   a2R5wSPGvcTBmuisQrPGwzQc+ntnw7cUG7NcZGn2VbiZXHu6PjhbvxgwA
   43nncGJ+UWHkVZAsO4QuajTRLQO3q0qH+887jm3d1ZiyhOIBsAdiEcVIo
   KVT5fm/39dMKAuLi+CmCE0cdFuxMi0Q+QGoR5ynmWldYEu60bfja9xKSJ
   Q==;
X-CSE-ConnectionGUID: 4fEAXKz7SUOfURGQSud9JA==
X-CSE-MsgGUID: IEyTl18iTd6JggJF+JMHzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86133609"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="86133609"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:47:44 -0700
X-CSE-ConnectionGUID: uevd9xgMSBGKtfTotOA5eA==
X-CSE-MsgGUID: D0SSyiZwQ8ScMosv1vsxtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="258788797"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:47:43 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	philmd@oss.qualcomm.com,
	qemu-stable@nongnu.org
Subject: [PATCH v3 1/7] hw/cxl: fix timer leak in cxl_destroy_cci()
Date: Wed, 29 Jul 2026 22:46:39 +0800
Message-ID: <20260729144645.1552511-2-junjie.cao@intel.com>
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

cxl_init_cci() allocates a QEMUTimer via timer_new_ms() but
cxl_destroy_cci() never frees it.  This leaks a timer object on every
device exit path and, more critically, on every device reset cycle since
the secondary CCIs (vdm_fm_owned_ld_mctp_cci, ld0_cci) are destroyed
and re-initialized each time ct3d_reset() runs.

Tear the CCI down in the reverse of cxl_init_cci()'s setup order:
destroy the mutex, then free the timer.  timer_free() cancels any
pending expiry via timer_del() internally and tolerates a NULL pointer;
clear the field afterwards so that a repeated timer_free() on the same
CCI is a safe no-op.
(The function as a whole is still not idempotent: qemu_mutex_destroy()
asserts on an already-destroyed mutex.  Callers must not invoke
cxl_destroy_cci() twice; the .initialized guard added in the next patch
enforces that.)

Fixes: 98cbac128f1c ("hw/cxl: Support aborting background commands")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ec18338b42..603677a97b 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -4795,6 +4795,8 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 void cxl_destroy_cci(CXLCCI *cci)
 {
     qemu_mutex_destroy(&cci->bg.lock);
+    timer_free(cci->bg.timer);
+    cci->bg.timer = NULL;
     cci->initialized = false;
 }
 
-- 
2.43.0

