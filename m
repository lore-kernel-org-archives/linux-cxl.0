Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC4613AD32;
	Mon, 29 Jul 2024 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242793; cv=none; b=dKIYDFC4DH3oFhLXdlXlzrB+OLmIJdNwvMmrqxWuqkvw/3hAOU+Jqyd+8xlT0fumx0/PzrMluQrSyoIgZO6OD2DxBvxR8q2nEJr3CwLWLRi9qX5NGliiK190Mz3VX9tRY8PRj49TipsAcMQBtkrhNKg8s6EHtxTWLyVvPlyORTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242793; c=relaxed/simple;
	bh=oVqLNYnmOu9YKlL1pACxxLFRoyiaoCqMtjg51eu2kMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GrTTj+7a+WZSqqffWq3oDvIH9RgIRkfH7wE81QC6PgRZWsOtfJLoNNbsk/tz/oVjq0oEopoMUsN7g3RjZAhMkED5D7KIldNedBMkH5F1fke5bIwOem8GzPWAe7DWRqr06JVXZ3M163XRgBdatQX8BqYLx8WD7QSienbdFyQBIbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTsnyvyB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTsnyvyB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722242792; x=1753778792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oVqLNYnmOu9YKlL1pACxxLFRoyiaoCqMtjg51eu2kMM=;
  b=NTsnyvyBvjpjIcPPsVP4iNCRJuGqSx+Xbut3E/d+N7eUsBMk5RPelJaT
   8PsXk/wSp57I0dIUzqw3ZMgHwzznX41WO2bhxqLvRE4e9DGQCUST5/6hu
   c3CZa0mqYPftEwfTVhytzMU7rM7CnN291K1o3IqBdRs6L3iDwrJ6EYOWV
   fm+Le5EkkYsyzxoHb1SiJx34wUCXgqXSqyGkOpATqNYvyEqGjabpIX1l2
   JhIUgFXW6fgbq7kz7DK/8ZqrT+DhzPe2xx/RlsCQSBLJ5pNMK8W7aR896
   B30eSe1odJt+TXBR032TtRTUpQkcmj/rkRi2xNb3WiohstCOpD5yVgNNB
   w==;
X-CSE-ConnectionGUID: E8NrKG6QTWCSubV7VaZQUQ==
X-CSE-MsgGUID: /9Aj/3J5SUeyRKji1OdLoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="30647118"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="30647118"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:46:31 -0700
X-CSE-ConnectionGUID: ESbu5/1VQk6VeDf8R/0fYA==
X-CSE-MsgGUID: RyleqdnNRCi9lIKKABcsOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="84856212"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:46:29 -0700
From: Huang Ying <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH 1/3] cxl: Set target type of root decoder based on CFMWS restrictions
Date: Mon, 29 Jul 2024 16:46:09 +0800
Message-Id: <20240729084611.502889-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240729084611.502889-1-ying.huang@intel.com>
References: <20240729084611.502889-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, the target type of root decoder is hard-coded to HOSTONLYMEM,
because only type3 expanders are supported.  To support type2
accelerators, set the target type of root decoder based on the
window restrictions field of CFMWS entry.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/acpi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 82b78e331d8e..40c92ad29122 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -382,7 +382,10 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 
 	cxld = &cxlrd->cxlsd.cxld;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	if (cxld->flags & CXL_DECODER_F_TYPE2)
+		cxld->target_type = CXL_DECODER_DEVMEM;
+	else
+		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->hpa_range = (struct range) {
 		.start = cfmws->base_hpa,
 		.end = cfmws->base_hpa + cfmws->window_size - 1,
-- 
2.39.2

