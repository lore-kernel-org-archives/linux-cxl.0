Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6264821322F
	for <linux-cxl@vger.kernel.org>; Tue, 10 Jun 2025 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749578043; cv=none; b=dC8tPKtHDEzBNspbXPuDloD82713KLeF2UBQxpBkoVGfRpcDx/BesuOfKKobVQ64metObOeNnb8Cc3OsVOiNMADrCRW0yg2Ys2U/y4yd4UVMWqiyoZn39HEGZ8TtTyjSTM0zf6m3vagkCgeBIZaHxDRGVQE+REGKmUc7QDUUdUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749578043; c=relaxed/simple;
	bh=PFvoDY0p7WMfmJqMIjK0ei2DI45qdI5ulfOLJAZkB9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PUt2gK3dhQ28mk4ERwvCEgh+0gZCYDBV1IV2x+3wsMFM/xiwPKAEpYysb4ygJZI27QssNPCmK9U6foIdkr0KP2T+CmcXFyrVKM0eoReILpZh1x7heIupYmBthO1uzKletjb5ZFJOAvZoXsRnGImwTsU1RrJHmw2exA7g9mro7mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD74AC4CEED;
	Tue, 10 Jun 2025 17:54:02 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH] cxl: Add comment about 'cxl_root_decoder' and flex array
Date: Tue, 10 Jun 2025 10:54:01 -0700
Message-ID: <20250610175401.172660-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a warning comment for 'struct cxl_root_decoder' to not add members
after 'cxlsd' since 'cxlsd' has flex array at the end.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9a17e8beca7a..68596e9216f3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -445,6 +445,7 @@ struct cxl_root_decoder {
 	int qos_class;
 	const struct cxl_rd_ops *ops;
 	struct cxl_switch_decoder cxlsd;
+	/* DO NOT ADD AFTER THIS POINT, cxlsd has flex array component */
 };
 
 /*

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
prerequisite-patch-id: 77982cd1ed494cf0f747ccf74c6b8949be9837d6
-- 
2.49.0

