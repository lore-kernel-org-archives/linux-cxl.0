Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FBA171B4
	for <linux-cxl@vger.kernel.org>; Tue,  6 Feb 2024 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246278; cv=none; b=FVuO4/cIgpAaVE2eM2UxG3xoqpJczoJ9Kdfd9LKPq4RSrx9CTXx0Sryzn68TL6AmsBsiJFO4JqUxb3/dYrKYmYrRTBHC22AiUb13A5qApuuNXhrmqA94uJkrwL6yS92cpGd6LVOECwaXSTWKHpUNTJKbkkLN6pDZzXDZPDTowPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246278; c=relaxed/simple;
	bh=r1yJja/ZTKPYQpTVA+OX1aYWYVyA1csPY1eGv/eCJKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCl3Wt/rk2yr7hJACYMeIfgG71ckSV4GeeP2P2jvHe12d9yzM+JghoupPHB2Iy1rbBhyWbq9rqiNUxXw2og9ieGsSDtrSb4G4cXLXaCQ3MEXXLAvZ0CLJRKHt3UQ1AzZ2GXrIw1bUF56WndKrGvG84j4YMOp71TDmJvGdHn+BKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEFDC43390;
	Tue,  6 Feb 2024 19:04:37 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v5 2/4] cxl: Remove unnecessary type cast in cxl_qos_class_verify()
Date: Tue,  6 Feb 2024 12:03:38 -0700
Message-ID: <20240206190431.1810289-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206190431.1810289-1-dave.jiang@intel.com>
References: <20240206190431.1810289-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The passed in host bridge parameter for device_for_each_child() has
unnecessary void * type cast. Remove the type cast.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index d66acc917dac..ecbd209ca70a 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -334,8 +334,7 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
 
 	/* Check to make sure that the device's host bridge is under a root decoder */
 	rc = device_for_each_child(&root_port->dev,
-				   (void *)cxlmd->endpoint->host_bridge,
-				   match_cxlrd_hb);
+				   cxlmd->endpoint->host_bridge, match_cxlrd_hb);
 	if (!rc) {
 		reset_dpa_perf(&mds->ram_perf);
 		reset_dpa_perf(&mds->pmem_perf);
-- 
2.43.0

