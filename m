Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7942F1C84A2
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769436; cv=none; b=ZjcRwfFrQGnH/InO06i5WfYaEAR5y8n2qN+zA2rNoN40LcPeDpTZEuITaUeUl0QanGqxuWSlq3kmyLEe/qA7uyjOLvil/muM1Hon3SV0++E76sgxeAeYbMBpZ6/eRBd6yY08N4kLU4Xel8hLAwiG2TH5sqUqNK+wfLbF6N1PKk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769436; c=relaxed/simple;
	bh=bUy4y8HW0wfdIIGwFykmmFvUk5kLIyAYGJ6OVufZCcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HywPFkKzQ0lUEE+oA04QfvLcdxvYwDjGxn9GBIbL/5d56OV+GO9n8bH36j9lYt4H2/dnx33fmEin5AROTThQYfU2F8QLvZz2zgyBo8Eu+V9CNiVZlgG3maE5rmjUVDr01o4ofLCGRweq3BKyjdH3RGCMVFBCw1cW8ING39/UtXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLJNOL/9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLJNOL/9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784769434; x=1816305434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bUy4y8HW0wfdIIGwFykmmFvUk5kLIyAYGJ6OVufZCcQ=;
  b=OLJNOL/9GY0lzM7LTXfk+WGTGUSE6P4iHxZAUFdr4P9QBcQ5U3r8pcfK
   E3LtAGE8nPCoMOwjDdS2oELbl1qVXzSsorqPZHNvE7OabeN5qFOz5/B+2
   V+98jNi7GZSCACfCOeXztTW9dDtsMsXTlxHypdvmlwKUCuZtkU4tGibZk
   KzOXZVILXtQL7A6rmeW/4VnwGgQxUkmOxiygo8N6YnsQpg2uxCEEA82q2
   ztTYVeeEheflmbs3n6g8mytc+BahWknzYyyBueU681jKosiMRKr0iJ+wd
   sXhJ3LWKPa0PScCGbVqSL5LqlUV4Gi5rb+5r8T4OlYd1QOAaA/jMbOcW0
   w==;
X-CSE-ConnectionGUID: CIsIdZuNQJqJGvjUY6/UTQ==
X-CSE-MsgGUID: RmGqNrflSdu47saw387o7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96074832"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="96074832"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 18:17:14 -0700
X-CSE-ConnectionGUID: WBJjti8ISJmASN3vb3+jRg==
X-CSE-MsgGUID: 6/5Q7KSLR2+GFgXFsMn6SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="251943345"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 18:17:13 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	qemu-stable@nongnu.org
Subject: [PATCH v2 1/6] hw/cxl: fix timer leak in cxl_destroy_cci()
Date: Thu, 23 Jul 2026 09:16:20 +0800
Message-ID: <20260723011625.1117034-2-junjie.cao@intel.com>
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
---
 hw/cxl/cxl-mailbox-utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 20e0b7e476..a1b9f0243b 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -4771,6 +4771,8 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 void cxl_destroy_cci(CXLCCI *cci)
 {
     qemu_mutex_destroy(&cci->bg.lock);
+    timer_free(cci->bg.timer);
+    cci->bg.timer = NULL;
     cci->initialized = false;
 }
 
-- 
2.43.0

