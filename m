Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676E17545
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 00:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166344; cv=none; b=T65Ea7TEwqHVQu0pkAdJXadn088ANWZeQ5KcBoMEr3l5bvdQC/tSlOSGn5zbmTL/jLq1OO6/RXDaOhMV0A2o1JwwsrNcM1RMu6xAUpaAGx1QPVxXrqgZ784und51Ipm3uY4sU8ZT+I3UQ66NngIEOEq9/AKwI+C62PaoYy+slrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166344; c=relaxed/simple;
	bh=N9u4vquzUznTMveyTWc2JwK3UVgD5pcbAfxe90w8vVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HO8FhQfiv+eC+s+ezaUtbop1ZB6IEfFIzYrIPTW+fSdVzfYnCulrCX/r0yE3i5wPM5vLk/8JyHZ0A0YYpSTtXwStBZHZ2sDP5641U1Ahz4c/sUf7ZO/I5VdarOjqkkC9rNiF5cCvS8kJB02HERvvn4vHyFZh03Q0jQEsZOGR9Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F243AC43390;
	Thu, 29 Feb 2024 00:25:43 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH 1/2] cxl: Remove checking of iter in cxl_endpoint_get_perf_coordinates()
Date: Wed, 28 Feb 2024 17:25:41 -0700
Message-ID: <20240229002542.634982-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The while() loop in cxl_endpoint_get_perf_coordinates() checks to see if
'iter' is valid as part of the condition breaking out of the loop. However,
iter is being used before the check at the end of the while loop before
the next iteration starts. Given that the loop doesn't expect the iter to
be NULL because it stops before the root port, remove the iter check.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e59d9d37aa65..e1d30a885700 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2142,7 +2142,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 	 * port each iteration. If the parent is cxl root then there is
 	 * nothing to gather.
 	 */
-	while (iter && !is_cxl_root(to_cxl_port(iter->dev.parent))) {
+	while (!is_cxl_root(to_cxl_port(iter->dev.parent))) {
 		combine_coordinates(&c, &dport->sw_coord);
 		c.write_latency += dport->link_latency;
 		c.read_latency += dport->link_latency;
-- 
2.43.0

