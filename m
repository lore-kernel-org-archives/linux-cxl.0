Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A8F13D8B8;
	Mon, 29 Jul 2024 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242796; cv=none; b=WI5yX8RXmyEh0tQVJVV3eLu1QadrGLxs0dmGvJlmPadjgFuoi+mj6M8rwrSwXaGNCRVB3T15HOBpzj+odY3xHEWpdkXZcnW89yURBy5ZYRtwWLRUsZYoJQRsiOGQ4FQg4lgbuDEwcw8A1Ij9I16MAWbxoaiIVf7k16m5MCOJ6G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242796; c=relaxed/simple;
	bh=Rc+FUVCpEEGnIoQecKfuSEkIqJi6i4jv0E4N2CMhCW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lEWIy9FzcDiDEdKLIFG4HXiiUsk+xXlV3xIFVj3fO1zPVo/p1/f9vSruu2/rjc35RBI4+2Do7hH7L66Gu1PPJbtgcYL56xcMsEqkRQKrG+3f6VGiPqWQQ+CPIpWlPdIHBBBlCDlxnpiBkyWIIVrN9VIS7f7tmXk9AS2NH7f8FbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gb/CHhjZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gb/CHhjZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722242795; x=1753778795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rc+FUVCpEEGnIoQecKfuSEkIqJi6i4jv0E4N2CMhCW4=;
  b=Gb/CHhjZSBH/xopGgGwtiEH3x+fwHMWungCjrsHYJA9LN+znfPUKyoUh
   YkF3aB+l1MUdYwe01Hw3fcpgSXNwUZ/MKdbtEP5iNzbkQuaAGjCfTeQh4
   wFz58qGqBGQDG63g7HUFuWNtV5E5rQH3w/n1u90XPr58CJfmUxoe7kVvG
   wG8fg7pkhYDkiVAiFMgU++A496Sv4JUZfz2cUPHn4Gje6sk1gT2G+azby
   qcVYk2Cy2f+mtfvcZE71BE5+66U8JM5FDWSw5bj7SWpH2c3E/yqX6CLGA
   NfaYrmSl1wgSRWoe2nDXvQ7USk6UPrz3/Lu3yHJQJerGoOYCr2/BVYK9a
   w==;
X-CSE-ConnectionGUID: JQHScIy+TmK+5DQWQ1yv8w==
X-CSE-MsgGUID: 2vuZc4JHS1qZahFy1McqUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="30647125"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="30647125"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:46:34 -0700
X-CSE-ConnectionGUID: qVZeHLmHQOWYct+DBOfzww==
X-CSE-MsgGUID: 6Whi9fOuTAW+Skh6HaeD8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="84856215"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:46:32 -0700
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
Subject: [PATCH 2/3] cxl: Set target type of region with that of root decoder
Date: Mon, 29 Jul 2024 16:46:10 +0800
Message-Id: <20240729084611.502889-3-ying.huang@intel.com>
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

Now, the target type of region is hard-coded to HOSTONLYMEM, because
only type3 expanders are supported.  To support type2 accelerators,
set the target type of region root decoder with that of the root
decoder.

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
 drivers/cxl/core/region.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..9a483c8a32fd 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2545,7 +2545,8 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode,
+				   cxlrd->cxlsd.cxld.target_type);
 }
 
 static ssize_t create_pmem_region_store(struct device *dev,
-- 
2.39.2

