Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D455338C
	for <linux-cxl@vger.kernel.org>; Thu, 25 Apr 2024 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064477; cv=none; b=Z2H0eJblcCBRZMuw0nXRVsH+u+s0Be2hNpCTPLcJkF6eAfUR/XDf0tk8ge8fDoQUODxK6HQLMQd5XozFeJrikaIjeBnwlR1zOG10r7BQ3SPqS4GJncWBZLJEB5yI2UTARuzD/OfO7F2SV1swNM7Y7M2GHtb4MVH8zrF3uWNaVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064477; c=relaxed/simple;
	bh=zCSSYT7NHUykUDt3xm42jj0lXmgDO+9AlXN0/uIqY9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dGpWov8PK2RTREOuy5zMpYqnE6IY6cdg8WXoVBsEvT5Cz1142jp8OXX/YmLXR/u/icvjQf3lJAiJVsLQM2LZKEEmH7V9qpDPnE66CFiIxy8SGW1/35Ip0IQ1VrkBaOGgCSdh+Urm16KgZ+fuezeWDS9Ny7jdpOiY1ph/3Qv7LKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08BAC113CE;
	Thu, 25 Apr 2024 17:01:16 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH] cxl: Fix white space issues in __cxl_coordinates_combine() function
Date: Thu, 25 Apr 2024 10:01:14 -0700
Message-ID: <20240425170114.843163-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix excessive indentation in __cxl_coordinates_combine() function.

Reported-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index bb83867d9fec..210a66743c38 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -518,15 +518,15 @@ static void __cxl_coordinates_combine(struct access_coordinate *out,
 				      struct access_coordinate *c1,
 				      struct access_coordinate *c2)
 {
-		if (c1->write_bandwidth && c2->write_bandwidth)
-			out->write_bandwidth = min(c1->write_bandwidth,
-						   c2->write_bandwidth);
-		out->write_latency = c1->write_latency + c2->write_latency;
+	if (c1->write_bandwidth && c2->write_bandwidth)
+		out->write_bandwidth = min(c1->write_bandwidth,
+					   c2->write_bandwidth);
+	out->write_latency = c1->write_latency + c2->write_latency;
 
-		if (c1->read_bandwidth && c2->read_bandwidth)
-			out->read_bandwidth = min(c1->read_bandwidth,
-						  c2->read_bandwidth);
-		out->read_latency = c1->read_latency + c2->read_latency;
+	if (c1->read_bandwidth && c2->read_bandwidth)
+		out->read_bandwidth = min(c1->read_bandwidth,
+					  c2->read_bandwidth);
+	out->read_latency = c1->read_latency + c2->read_latency;
 }
 
 /**
-- 
2.44.0

