Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884B3D8138;
	Fri,  3 Apr 2026 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775249977; cv=none; b=E6TUxGf/3bsRGfxD75LyA05unD+ld973TaNx4/e4V4nQxEFjHUlWf7t+91Hx6kqGL3S45E2Ps326l2HZJQ8B18Wxln5vBmeSeJ1fNy818rdcu+MsqRNBo2xG2Y4ktADvYSxnEcwCvI2pAOQyhF15EocEccmSr+dCv0vhgE/WGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775249977; c=relaxed/simple;
	bh=cbAYPgREboJ2uyzmWxIdJ9NfLngERxBdJQ87WFdMGw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGPLrbB/d2Y5yVSYEnhuSFfvQPtPrKHz224fnOyT45Bj+ND7XpEOBPNofZTATwYuqjbpxpnYjGVJ3WIr8j/UxO1sP9pDO81T5AkhfOiRg9j6YLXmPXOwg2Whlu9YJ3dmEfYT8lIt801vU6UDRGRryJz4QF9Yejt0CkXkUxNsaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0C8Ty0Y; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0C8Ty0Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775249976; x=1806785976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cbAYPgREboJ2uyzmWxIdJ9NfLngERxBdJQ87WFdMGw8=;
  b=a0C8Ty0YDYjMUxMGzd6zv8z2GWPcdjWYKLgT/qciDYf6b4d/cmGMeVbb
   3kuPmO7qj7fgazDRuRw1DQ7/VaQwxr1+Svb0J0Ymyf1wPBFEFJHgyW4N7
   CbfIA9U2rF7ltX0zkiWYT52UZsphPfAZxpNqroseog8ydbTzcYfstDy87
   8bCfq4cUQBB5HNOHxU6/vqAofmfM1QSU97BW2AHcrt8SuOPYUrQvL8qse
   aYae5gMbAwZrV1JUtLFH7RzsHWUjyCVXVboruLJQsasI9gs8mveYCw/Xt
   O/aW/3GsMB1bocC1naTSbq5+x8Ic89lCX5HUjpDzxGFhMLGsY+jQktY8l
   g==;
X-CSE-ConnectionGUID: T+3TJF/4SrKpSy4Fxg4DMQ==
X-CSE-MsgGUID: v9eYNGoaS2K+++9q1VLh4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76281468"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76281468"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 13:59:34 -0700
X-CSE-ConnectionGUID: Nn7HNYV3RY2pdI3/GYw01A==
X-CSE-MsgGUID: IQ1kWgTsQv+pex2NhXnP5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="265280477"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa001.jf.intel.com with ESMTP; 03 Apr 2026 13:59:33 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alejandro.lucero-palau@amd.com
Subject: [RFC PATCH 1/4] cxl/mem: Add support to cleanly continue after attach
Date: Fri,  3 Apr 2026 14:00:47 -0700
Message-ID: <20260403210050.1058650-2-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403210050.1058650-1-dan.j.williams@intel.com>
References: <20260403210050.1058650-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For drivers that want to fallback to PCI-only operation, immediately
cleanup on attach failure. Otherwise vestigial topology objects are left
until driver unload.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index ff858318091f..5e7fa378dd66 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -201,7 +201,19 @@ static int cxl_mem_probe(struct device *dev)
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
 				       const struct cxl_memdev_attach *attach)
 {
-	return __devm_cxl_add_memdev(cxlds, attach);
+	struct cxl_memdev *cxlmd;
+	void *group;
+
+	group = devres_open_group(cxlds->dev, NULL, GFP_KERNEL);
+	if (!group)
+		return ERR_PTR(-ENOMEM);
+
+	cxlmd = __devm_cxl_add_memdev(cxlds, attach);
+	if (IS_ERR(cxlmd))
+		devres_release_group(cxlds->dev, group);
+	else
+		devres_remove_group(cxlds->dev, group);
+	return cxlmd;
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
 
-- 
2.53.0

