Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2017F1C7B99;
	Tue, 15 Oct 2024 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975514; cv=none; b=HopGh/1pSHki04uY/sbl4KBLNAuEzFIMbvzME8ODJWCBlrNsPpxM/gBDvOyEeZEUK2V7MEGQVSyVbop4owGrNxGzuMsqS+r1RQIzQwnjr+NKLOMiR9PTZo1jjBg2OgajfHX6DNi6H26RNl4bq1vOq+iCHzKAiutVPuIRpYeCRnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975514; c=relaxed/simple;
	bh=rdfJ2s+ybBBsiZWkLx6WCDUJESH8OwrCvCQaJyX1YaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cAyKMWMYO5TK1/9FkkxNxJLYYRPgmB5zqq50UNLEF9HuI7ywChf1b+XFCyCcSTZJyhqwlcGjD6BuPZhA4He17ga0c69l96hWoVRr1P6oH6GSbY5+PKCFCtLX9DsPY3fTgIpcaUqtA8C8bVmVFuu84HYETNimFmeXxNAy3xhLnNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYi5aUPq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYi5aUPq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728975514; x=1760511514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rdfJ2s+ybBBsiZWkLx6WCDUJESH8OwrCvCQaJyX1YaQ=;
  b=bYi5aUPqVRP46V+ZB2r3ZoK3ZSoAh+gTaLORphU6YtGtc2EPfKrBYXZu
   iEXFEFzOlt1VAvBYate0TOTI+N4sEldtISts8dKb3UE+RuPH+CPAJMZRu
   EXLXtelhycCDBiQWoCQQJCWmwWGasJY0YjbKtev5gR1lTMMajk4Rv9wt/
   +Zp0cU/RTpoZ163G/lbEMSi1nN0N6UOnYJZ7HmsucvxNJg1O37zA6a2P2
   lfDkUo3/4jHlYlf4ZymMfsqpbxgGtGichuylTxcVbgXU5VQ8LSoKdFyIH
   /nBMlkIrIa5eLX0JPljDj9Pce/stc0qCh7l1ag19uAGq3kpGPls32w7Wi
   Q==;
X-CSE-ConnectionGUID: UpVmXI9SR3yYLwFu3iFprA==
X-CSE-MsgGUID: CySwF2NbS5is1dYqmyn+Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28447876"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="28447876"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:58:33 -0700
X-CSE-ConnectionGUID: LPAqurBaQ/yaUiD/0Ni2Iw==
X-CSE-MsgGUID: /2ss5ox9QNSaykbqey4WHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="81776923"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:58:30 -0700
From: Huang Ying <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Gregory Price <gourry@gourry.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH 5/5] cxl: Avoid to create dax regions for type2 accelerators
Date: Tue, 15 Oct 2024 14:57:13 +0800
Message-Id: <20241015065713.308671-6-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241015065713.308671-1-ying.huang@intel.com>
References: <20241015065713.308671-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory range of a type2 accelerator should be managed by the type2
accelerator specific driver instead of the common dax region drivers,
as discussed in [1].

[1] https://lore.kernel.org/linux-cxl/66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch/

So, the patch skips dax regions creation for type2 accelerator device
memory regions.

Based on: https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alejandro Lucero <alucerop@amd.com>
Cc: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d709738ada61..708be236c9a2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3473,6 +3473,14 @@ static int cxl_region_probe(struct device *dev)
 					p->res->start, p->res->end, cxlr,
 					is_system_ram) > 0)
 			return 0;
+		/*
+		 * Accelerator regions have specific usage, skip
+		 * device-dax registration.
+		 */
+		if (cxlr->type == CXL_DECODER_ACCEL)
+			return 0;
+
+		/* Expander routes to device-dax */
 		return devm_cxl_add_dax_region(cxlr);
 	default:
 		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
-- 
2.39.2

