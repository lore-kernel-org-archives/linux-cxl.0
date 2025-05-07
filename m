Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866A15E8B
	for <linux-cxl@vger.kernel.org>; Wed,  7 May 2025 00:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746578593; cv=none; b=KeoEH7CIXuY2A4qIL1UPJRd3KqvSpLAVxMSS/V4qDj2Cw9qh3vM2OFHjep7WGZQw7F/CqTdCP8h3OretypFq8dSVlYwvrF1a74A/maLqaYrOoXEsMXIfooEZQQq1S5794ndzLiqCBCzDLeFOp/YN+nyPB9CWctbsAxSLy/ztsZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746578593; c=relaxed/simple;
	bh=sNt3OOsDenOiMMDnqg9vCvR9tFiIUpH0hhLQJeMY4MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTT8hWhOBdbkWu97RYTN/ruhDEJmT1G7VaPTNYi26e4PaDKox3GNdyL/A/WA9XpGGCFCeNCcMScMRV2AF4XILzi27yvHcd4OW75xhPA+utDz2SVp/y7qcii/LBH1vJO7Z/HU+E9GLapLkVC5MdcG6lJ+XVMT6HPFLyCArqOj/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313C3C4CEE4;
	Wed,  7 May 2025 00:43:13 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com
Subject: [PATCH v2 01/10] cxl/region: Add decoder check to check_commit_order()
Date: Tue,  6 May 2025 17:43:01 -0700
Message-ID: <20250507004310.3536991-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507004310.3536991-1-dave.jiang@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_commit_order() attempts to convert a device to a decoder without
making sure the device is a decoder. So far this has been working due
to pure luck. Issue discovered while doing deferred dport probing when
child ports are now in the midst of decoders due to ordering change
of child port additions. Add a check before attempting to do decoder
conversion.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c3f4dc244df7..a91d4eb061e4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -788,7 +788,12 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 
 static int check_commit_order(struct device *dev, void *data)
 {
-	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	struct cxl_decoder *cxld;
+
+	if (!is_switch_decoder(dev))
+		return 0;
+
+	cxld = to_cxl_decoder(dev);
 
 	/*
 	 * if port->commit_end is not the only free decoder, then out of

base-commit: 3c746d4821f507304b08789e3c7c151554fc2356
-- 
2.49.0

