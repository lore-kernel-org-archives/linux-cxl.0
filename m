Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A1A1B81CA
	for <linux-cxl@vger.kernel.org>; Tue, 31 Mar 2026 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918261; cv=none; b=YLLjr882luaGMBumMxAfL318GCuIE/+uTaXrI9wHZmUREyflIwLj1org/G9hjaljqzJZJTYSUij1Tizh3qhNghhOISt8GToO2Ck3aCVo6G7WIvT/TaAbklkeGnX79ywS88dhAbkrvw2mu4Li9q+yDyv2Anvc0s2LdhqY3K20OnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918261; c=relaxed/simple;
	bh=ckJXxDgKe1fag0cLOpSceRQ7W7yyFrttKGt49TRkg6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipHUTXS/hbWwj/OjHzP+LO0TbMsPaMWLUepfC8+JfBRT5yo8/O5Iz8tAMJiIhr023sNOxvR8Ju+X3n9jKEiu1/NP5ljTzS+JN2ouOA8wk8/QOYVmkG5EOAkm9mixDCwTqi88D3JnSmukIvgmOOSJETchFyXoR3Jmx6+UCFJH4hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdNwbl5D; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdNwbl5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774918259; x=1806454259;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ckJXxDgKe1fag0cLOpSceRQ7W7yyFrttKGt49TRkg6A=;
  b=IdNwbl5DKdNzijsNHQ1IqZUL78KVe+8xuGOSpkuBTlHUB/EAfURuXDal
   q/dA/AoZQz0BuZQ9HpHJ/vIvIOZnVVLmpw8r7moa6QNBNH7U0zYBccUGY
   O7oMyHoJVMyUPubmrz3apmgsQKGo4pgYb5g5+MtPR135H4/L3ADpg2Lap
   KY+FvUbHWZGFrNWmtJYuykTzt/7AI4SCdbX8DgCUq7QXWG35oTxdPhID2
   WnXyBDq8LnXURGUE5HegUw2OstYR48ycbsLo6Jrlx5MabgQd+1mCnib8Z
   9p56VKJq08jQjbaiW8cwzr+RQCzV/lLpJvBS1FT4WqwV+zcrIcLeQDKm8
   w==;
X-CSE-ConnectionGUID: ZN7lS6kNRiG6RURcFF7NbA==
X-CSE-MsgGUID: wG6YIId+ROuMJCdfqG6XUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="101380082"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="101380082"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 17:50:51 -0700
X-CSE-ConnectionGUID: 8tTtfn1OSV2ZqPKBumy5fw==
X-CSE-MsgGUID: G9bSgK4gSgGA7Td2H0n4pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="221806332"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.190])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 17:50:50 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/core: Check existence of cxl_memdev_state in poison test
Date: Mon, 30 Mar 2026 17:50:45 -0700
Message-ID: <20260331005047.2813980-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before now, all CXL memdevs were assumed to have a mailbox-backed
cxl_memdev_state, so poison command checks could safely dereference
the @mds.

With the introduction of Type 2 devices, a memdev may not implement
a mailbox interface, and so there is no associated cxl_memdev_state.
Guard against this case by returning false when @mds is absent.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/memdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 273c22118d3d..591425866045 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -204,6 +204,9 @@ bool cxl_memdev_has_poison_cmd(struct cxl_memdev *cxlmd,
 {
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	if (!mds)
+		return 0;
+
 	return test_bit(cmd, mds->poison.enabled_cmds);
 }
 
-- 
2.37.3

