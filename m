Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA19463
	for <linux-cxl@vger.kernel.org>; Sun, 16 Nov 2025 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763256642; cv=none; b=VnpvwHe30BuaAai4gkokUMmGzyOJzgeKHbx513qq/Q/bHXIm5kngH5JqRkujJAteeWqxHloTx4BVpJqfk49VuhiIwbwzZU7pKHKI8wtUN3uKaU9jDJ4HwFBrFHH2Jdy5vQ/Bakt79BE/DyaPAKIh0SWVYTOumoZTr6LRza1Gcj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763256642; c=relaxed/simple;
	bh=IcC3O37zAFtwlO5QRzilP2WStEEEGyvAYhWdzivZ3fE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UHAoHbptN8jrw1drOaF6vWzy68yNrpvbGLxIyTmz+Lugpd8NPNWk2XpTfIdr22TTG0XjGPG4dRyuZ0YzuGNZ8qfKLrh4eg3d1uD2FwqjsPwk3NjGY4Bo8aZixlCv6eTJA13V2IwhW/pi8T0Q1YID1HADJMLJWKPAhjwIOD04WQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLUjbRq+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLUjbRq+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763256642; x=1794792642;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IcC3O37zAFtwlO5QRzilP2WStEEEGyvAYhWdzivZ3fE=;
  b=dLUjbRq+r5M9NZ3qh1vnf5XdDHvY1wpnv2APmmHPlHxQ3AHMYy+gW2te
   YYR5etUBFheR3LYbL5TPk2aseGpQkvitdjoG6rNzQNX2FSi7t4J9mup3f
   Xby8B+YcaUCC9FUjFtb2CjeUEQ+rnUKuL4BrqjURJAr8ACfGsOwq9Gv57
   P7I2kwj8OBeQBVDTc89Tlw683otanYM9IBBaup4ipN8waBaroSy61M6zg
   vkCrQCRffcLej2tjn82OKGZkXHasniFgfaooZ0Me//3g/MMCOFePDybZy
   MoZDioXHpkkZmPswMpNCDv17vH1fR03e0D4wWS7xvTLIPXboPkZXFYxUf
   A==;
X-CSE-ConnectionGUID: 0yWUjbTSSP6gZOK+AiO7Kg==
X-CSE-MsgGUID: x0QlGnOVTAS8MzOrsk0y/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11614"; a="65185273"
X-IronPort-AV: E=Sophos;i="6.19,308,1754982000"; 
   d="scan'208";a="65185273"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 17:30:41 -0800
X-CSE-ConnectionGUID: hw4aZL1dTXSno9slroLdZQ==
X-CSE-MsgGUID: wpwXEQR9TtCQT3gTvOkxPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,308,1754982000"; 
   d="scan'208";a="227471523"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 17:30:40 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/test: Assign overflow_err_count from log->nr_overflow
Date: Sat, 15 Nov 2025 17:30:32 -0800
Message-ID: <20251116013036.1713313-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mock_get_event() uses an uninitialized local variable, nr_overflow, to
populate the overflow_err_count field. That results in incorrect
overflow_err_count values in mocked cxl_overflow trace events, such as
this case where the records are reported as 0 and should be non-zero:

[] cxl_overflow: memdev=mem7 host=cxl_mem.6 serial=7: log=Failure : 0 records from 1763228189130895685 to 1763228193130896180

Fix by using log->nr_overflow and remove the unused local variable.

A follow-up change was considered in cxl_mem_get_records_log() to
confirm that the overflow_err_count is non-zero when the overflow flag
is set [1]. Since the driver has no functional dependency on this
constraint, and a device that violates this specific requirement does
not cause incorrect driver behavior, no validation check is added.

[1] CXL 3.2, Table 8-65 Get Event Records Output Payload

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/mem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index d533481672b7..9853bccfa185 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -256,7 +256,6 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_get_event_payload *pl;
 	struct mock_event_log *log;
-	u16 nr_overflow;
 	u8 log_type;
 	int i;
 
@@ -299,7 +298,7 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 		u64 ns;
 
 		pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
-		pl->overflow_err_count = cpu_to_le16(nr_overflow);
+		pl->overflow_err_count = cpu_to_le16(log->nr_overflow);
 		ns = ktime_get_real_ns();
 		ns -= 5000000000; /* 5s ago */
 		pl->first_overflow_timestamp = cpu_to_le64(ns);

base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
-- 
2.37.3

