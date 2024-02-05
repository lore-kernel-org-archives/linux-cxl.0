Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D55C5FA
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161548; cv=none; b=UN/WRPEYazm9+M7xSv0in5sveJXGvtBq8jdFlm4IxwYLrQvPmgoiUJjyMoJQ2d1UM2RR0CAxsZ2281XX5NxGvhyUlR++O6ln4P7PQb9Hoebidc9QioX6Q/oWa8rkHh30HKgiQ9hNtIyIoDLZYExe5cGX8eG/UEyENufxVNSScm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161548; c=relaxed/simple;
	bh=r1yJja/ZTKPYQpTVA+OX1aYWYVyA1csPY1eGv/eCJKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNIoRvP8yswNgVJdBoDgsQO9X6upUEqlP7DnVRybYRFch5yJaYjixfgt3B3V2F+7mbJI87TlZG11dpKuVLGHK5od8UGxZSsRWmLwONfXn8+xBzhW79h+H3kYuw6rkFPBf+W8HCB6df0s6euvGWywHt0lz7a0NynCdzMPbfGetEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A217DC433F1;
	Mon,  5 Feb 2024 19:32:27 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v4 2/4] cxl: Remove unnecessary type cast in cxl_qos_class_verify()
Date: Mon,  5 Feb 2024 12:30:32 -0700
Message-ID: <20240205193218.1657243-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205193218.1657243-1-dave.jiang@intel.com>
References: <20240205193218.1657243-1-dave.jiang@intel.com>
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

