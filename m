Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6511A230BD9
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532541; cv=none; b=ArNrliWX79d/dmgUvimIv28rZMFQ2upAWmYoXB+B903Ryo2uMZ90EzSmCCQW+j1Aa00YeKBvTg1a6ji2Sek/AIHkb6kGuK0pqN70x91DM6gGjzVQS5ZTxu++whFEKBquQIT9u5OenhSNROlHMO6473z+GeLqXMRwwdOG35/QyDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532541; c=relaxed/simple;
	bh=r6BVoyeHERajfBI2HNnjI9Gzl+ur+jbYt/A/2+zMGrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuxzvfQ0S/wnW3/z6Zch2jhcQPW/sN4PAkCSFkhPNxtqcsWc36iy4kI+xCDsvDNnCOFOqldTSol1Nncl8/nN7uFwpY7Jbk0Pni2Vo5j9EGFpzxRp+WDAqYPS/TYvINDoepOyTd3i9urT1HbqVhDFsbyHed+a48sz0yJdEgn/hKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD25BC4CEED;
	Mon, 14 Jul 2025 22:35:40 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Gregory Price <gourry@gourry.net>,
	Li Ming <ming.li@zohomail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 01/10] cxl/region: Add decoder check to check_commit_order()
Date: Mon, 14 Jul 2025 15:35:18 -0700
Message-ID: <20250714223527.461147-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714223527.461147-1-dave.jiang@intel.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
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

Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6e5e1460068d..b94fda6f2e4c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -787,7 +787,12 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 
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
-- 
2.50.0

