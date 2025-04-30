Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73612DC78E
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746049015; cv=none; b=MSRqDerIWsYM15coQ+136lZRYfCy2NScfvzIKYQcEjH2EEkrKsLjhdnfuCj7A3TfDB5HCz+01OP23CSc/pFbwC1lnmmCqZcEMMmZMj+kuE8x+/iXVlyqsNhNfu8ZcIddpUaRhVkIARoN8VdDKgNU7sk4PG1r9hGctBrLw0uYkHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746049015; c=relaxed/simple;
	bh=LfADrb5h9rAElt5Eg/5OS7Q4BWdnFXSHyWUSYvhw0I4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cfUrLkousczp6aNArn+Rry+LzPxozAKQKGm8cuzaGL+5ke8G340V+Lhi0Ps838GFMCYCwST31u88ceH7FDiQy7zCxzEHp56HeXfFDBwsEOrItJAU/EucY3N9n5tiq6bcNKCJU9xTk7beJR6JUXA97GU10qnsQXgkUkeg2mRX9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD21C4CEE7;
	Wed, 30 Apr 2025 21:36:55 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH] cxl/region: Add decoder check to check_commit_order()
Date: Wed, 30 Apr 2025 14:36:53 -0700
Message-ID: <20250430213653.1904302-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
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

Fixes: 105b6235ad0f ("cxl/port: Prevent out-of-order decoder allocation")
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
-- 
2.49.0

