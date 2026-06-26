Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0F33BA220
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jun 2026 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782456963; cv=none; b=NBRa9fawCEsrI7G9NJXOkwY/PJ/5EnLUA2vWWo5xfftImiy5GamsxikeHnOZ2TK/pyLG3sHZ0l9DA8tcCcIkbHZbzOFWXpwODhpNpWXIC5tM4K1VtsWancIK6A4/XY+jcFZiXF2WbN/Dj5cKIUbn8dXCaEf9eJNG6nu5otOWbnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782456963; c=relaxed/simple;
	bh=KBu100xg1Txpv8RJacu5T0T7HrIl9c2cdIu5LTVA4PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cy9yYtSAy146Et+wkoVayF9roLRiysJT9S2ILi35H3cpcSIhDsUS80AB/1jgtiltqWhLKdkH4MRNJCDfWy9XGSVaNkARhXCnqmlRfGmW6p5yMJSObNro0y2fRf9PFg0UrJgeGfF2650NP5Sw5/Hc4117YBuHM/NflPQ6XJSIozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4Bk4kTj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4Bk4kTj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782456963; x=1813992963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KBu100xg1Txpv8RJacu5T0T7HrIl9c2cdIu5LTVA4PE=;
  b=n4Bk4kTjv3ns/X7MXxH1+v4wqA9F6kEsoJHNMRNNGZ/X0MH6rah76AUb
   gtUvray8UnXrOqyr1bVyaLpgj2hKQds5WMqgt2x6AK48O4rKbwY00cNCp
   jMhfFiTLljItro8ZBMAHJI9Pgo/f7wAyycFG/pgoJc8zv97PySJnHSYhI
   DZBISxmMBxr2TaimMUj34IZjv8GsK7dJcrWj7VVcQ2ZBJyMKrfkE7ObkX
   B8wo0KDLA0X9qA0yI3jSlfdy/GNgSjDxggK3qg9e02A7s28mR6X5n5qjw
   aO83fPtygqZumevHOx1d7GIeWT4fNHTeeogOZeP0zt+nPDdMDbzHeOHCW
   w==;
X-CSE-ConnectionGUID: l6e9zeQ+S6mIOdydIZuUkA==
X-CSE-MsgGUID: x5lyMZ1UReShnAezOp/h6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="85802331"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="85802331"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 23:56:02 -0700
X-CSE-ConnectionGUID: Anq9gpsGSSiR2V1+eDjgnQ==
X-CSE-MsgGUID: 4iJqnzP2T7WXbdJTS1ZPRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="244865870"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 23:56:00 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-cxl@vger.kernel.org,
	junjie.cao@intel.com,
	qemu-stable@nongnu.org
Subject: [PATCH 1/6] hw/cxl: fix timer leak in cxl_destroy_cci()
Date: Fri, 26 Jun 2026 14:21:44 +0800
Message-ID: <20260626062149.1844334-2-junjie.cao@intel.com>
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

cxl_init_cci() allocates a QEMUTimer via timer_new_ms() but
cxl_destroy_cci() never frees it.  This leaks a timer object on every
device exit path and, more critically, on every device reset cycle since
the secondary CCIs (vdm_fm_owned_ld_mctp_cci, ld0_cci) are destroyed
and re-initialized each time ct3d_reset() runs.

Free the timer with timer_free(), which cancels any pending expiry via
timer_del() internally and tolerates a NULL pointer, then clear the
field so that a repeated timer_free() on the same CCI is a safe no-op.
(The function as a whole is not idempotent: it also calls
qemu_mutex_destroy(), which asserts on an already-destroyed mutex.
Callers must not invoke cxl_destroy_cci() twice; the .initialized guard
added in the next patch enforces that.)

Fixes: 98cbac128f1c ("hw/cxl: Support aborting background commands")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 20e0b7e476..18a455e89c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -4770,6 +4770,8 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 
 void cxl_destroy_cci(CXLCCI *cci)
 {
+    timer_free(cci->bg.timer);
+    cci->bg.timer = NULL;
     qemu_mutex_destroy(&cci->bg.lock);
     cci->initialized = false;
 }
-- 
2.43.0

