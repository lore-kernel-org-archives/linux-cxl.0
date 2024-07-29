Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655D13B597;
	Mon, 29 Jul 2024 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242799; cv=none; b=BSB2boTOS9Y6Qx/6CyFxdLs1+GKco/gGlMzuTM8DhxB0uQMynaUKCIJrEgz3fSEzbYukKONUhoQ26wXgoq7x3k70TR5lkOGlUGLjd9Rqeku+zOhq9ml5s6FGCIichDVlIYyr/gN5mxxGrxAqSOXsXaJpj4AuCr5fdajio3t3muI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242799; c=relaxed/simple;
	bh=nReScesO0VsDDOh0NefNC0i7f2oCC3fkJxj/Ji3q3E4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D1+Xl78VMpzmil/I+bsPVePgP42LnywxoTwtDVVWkiydlkcPvdZaAbBnehqE60//CCD3uQhkadfeM/xYNlzHs0CmWQZc+FFQ6U+Q2tIg0Y9HV3Zf5miXqzNehwBIMdBBMpw96NjQIgZmidw3Bv4EiArmm9IJqW24D3nHww1SS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCD4ZTFT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCD4ZTFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722242797; x=1753778797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nReScesO0VsDDOh0NefNC0i7f2oCC3fkJxj/Ji3q3E4=;
  b=lCD4ZTFTjFqFFIMqBgfpmC5nCqoJ9iodXOgcSOuFj9+Q/wmq0TmLISmO
   R/wfBrf5W2thT+yoO6Rpc7f4lT5CxFIpVlEWjsNo3c/NKTchGRjfGgfr0
   8AE/h5NZrPcNRRtyjcqi89O3nOdsYBJsxjK+rmwWdYdWiz2kghtCdNZDD
   2oxvxhOsNX78zXtODQ0cs55OF8FatXvM5AUGgQmt3VIrX9B1WrkmzBJPE
   BGAS7f8r4DOj8q11Hm68TAb4FrD2Rlf9kalKdUjSOgWgRPHif3dYKmraD
   rD3ja612uxmkHRC5Srs3Gfr5hHD2jjG6CboYyiBhAUDqnRuTDduTMfjnz
   w==;
X-CSE-ConnectionGUID: 6T4nw+vbRFaFOsv/m4DQ1g==
X-CSE-MsgGUID: SOD+XaPqTeGChjUszWVoYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="30647134"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="30647134"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:46:37 -0700
X-CSE-ConnectionGUID: 227TU7ltQGaatZUrsa16QQ==
X-CSE-MsgGUID: Y8vyPdVCSK2AgiR4IpN52Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="84856220"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.6.133])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:46:35 -0700
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
Subject: [PATCH 3/3] cxl: Avoid to create dax regions for type2 accelerators
Date: Mon, 29 Jul 2024 16:46:11 +0800
Message-Id: <20240729084611.502889-4-ying.huang@intel.com>
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

The memory range of a type2 accelerator should be managed by the type2
accelerator specific driver instead of the common dax region drivers,
as discussed in [1].

[1] https://lore.kernel.org/linux-cxl/66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch/

So, in this patch, we skip dax regions creation for type2 accelerator
device memory regions.

Based on: https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9a483c8a32fd..b37e12bb4a35 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3435,6 +3435,14 @@ static int cxl_region_probe(struct device *dev)
 					p->res->start, p->res->end, cxlr,
 					is_system_ram) > 0)
 			return 0;
+		/*
+		 * HDM-D[B] (device-memory) regions have accelerator
+		 * specific usage, skip device-dax registration.
+		 */
+		if (cxlr->type == CXL_DECODER_DEVMEM)
+			return 0;
+
+		/* HDM-H routes to device-dax */
 		return devm_cxl_add_dax_region(cxlr);
 	default:
 		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
-- 
2.39.2

