Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67256B89
	for <linux-cxl@vger.kernel.org>; Mon,  1 Apr 2024 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014489; cv=none; b=Sx2JQLamUnHRRB/fCKJFHizWm0AwazAv0dCp65z4/UlT0kad4gM5lyTmiaj1+2SHyQsUtULLr35nHphbCaHJzOrGx84Xu9kw6hq+w5b3tyUdiCQAJpnxZOCJS1u+fA6Qdw3cU6ySmUBsYvWp7rbbgq/Ze0oNdyyIUAsWeqP8Jzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014489; c=relaxed/simple;
	bh=Dtzq9FeMVnKB0QJtilFN0ct3j5KFduq5PaQTx8IA9sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1MW7PD/nLs4jrHnu6YB7BqFAMg+LacD6KSim2N1QtKPqyyZIaArg2MlLugsTE3Qyz2Bi7Ip/fdNJXAPsb0Xcc2I+F0+ctWYvFfTmyNGHKkqZ/KxbDfCyvRJwfPoBCxJTypQi9w31XdDa6Jf5iyCkHZu5fJdj2t7ACMxn7qQF0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BA8C43390;
	Mon,  1 Apr 2024 23:34:48 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v6 1/4] cxl: Remove checking of iter in cxl_endpoint_get_perf_coordinates()
Date: Mon,  1 Apr 2024 16:32:59 -0700
Message-ID: <20240401233445.3057332-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401233445.3057332-1-dave.jiang@intel.com>
References: <20240401233445.3057332-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The while() loop in cxl_endpoint_get_perf_coordinates() checks to see if
'iter' is valid as part of the condition breaking out of the loop.
is_cxl_root() will stop the loop before the next iteration could go NULL.
Remove the iter check.

The presence of the iter or removing the iter does not impact the behavior
of the code. This is a code clean up and not a bug fix.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v6:
- Simplify commit log. (Dan)
---
 drivers/cxl/core/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2b0cab556072..6cbde50a742b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2197,7 +2197,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 	 * port each iteration. If the parent is cxl root then there is
 	 * nothing to gather.
 	 */
-	while (iter && !is_cxl_root(to_cxl_port(iter->dev.parent))) {
+	while (!is_cxl_root(to_cxl_port(iter->dev.parent))) {
 		cxl_coordinates_combine(&c, &c, &dport->sw_coord);
 		c.write_latency += dport->link_latency;
 		c.read_latency += dport->link_latency;
-- 
2.44.0

