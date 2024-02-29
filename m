Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3135BB656
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238642; cv=none; b=osOLafre8MIFz400LOTXv/jO7Aq+++zdfeMyyNYQzno/Ik+bHvxPDSzXnsHyB2R53fNa4QSaoRJXbNZpKXxRNQ2EQ7sT5tDOidaxTKWGnQNKRcpZJbRah99Bvku67fJAIfiNE8b5EDt6HD9TVUgD1xIl9RHJ+tfMSheGvHz9NN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238642; c=relaxed/simple;
	bh=RTdo8F/pdUfrNP1yMYvRioWse/t9L/RIyDsz8poaJZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0+pExD3TTdv3bKQVDuuIY6V7Or0bE/ss41pKrrjijZkBFl9YEOPuIJmhNv2+enOprKOOG+SA7dRubMDI5BTubgmV1qj/Z2wpn7n0XYBhkU4mGrW5rVcjhaKl8GJibRBR6fl+0b23mKITjBrcoxuKEbNbfE6ouKj+sIvm8cazlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9578C433F1;
	Thu, 29 Feb 2024 20:30:41 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v2 1/2] cxl: Remove checking of iter in cxl_endpoint_get_perf_coordinates()
Date: Thu, 29 Feb 2024 13:30:39 -0700
Message-ID: <20240229203040.755450-1-dave.jiang@intel.com>
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

The presence of the iter or removing the iter does not impact the behavior
of the code. This is a code clean up and not a bug fix.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Add explanation of not a bug fix in commit log. (Dan)
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

