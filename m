Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A10A135401
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747532; cv=none; b=dCBguYFjql1mZSwRUVJbB0jhTMCCk2XFkJrapmnkwVYa/VENGxgmxMkjm52SqSSHU2/rWzqD3kWpvzayvfuMEXC1pHyovyGKQQ+e8aVgfFpJPmwOLINLLBgUqD9Ngvv6B7Edfgx7Dx0Zq0BSd8RqiUZ5QZ0rirDgCJ+8gg3H284=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747532; c=relaxed/simple;
	bh=MP05vN636CCviEe9zeuqKHohMUr59IfGQLAlutkrezg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EK+Vx0YAjfuH96dBKn58FtPZVZN+EyimD9siwTlqtIp9kScVYiyyvND5RrhkzkndrsB6ZmiEYfXezGzXyGepw1N3HhJlD24nEmt0sLsSytPhzBMr/FsvEGwT63hoAy/VGxT/AJ+Hw+y5suJjt+62wAyv3wNv2xguYCXP2A/1M2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28C8C433F1;
	Wed,  6 Mar 2024 17:52:10 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v3 1/3] cxl: Remove checking of iter in cxl_endpoint_get_perf_coordinates()
Date: Wed,  6 Mar 2024 10:52:02 -0700
Message-ID: <20240306175204.1906538-1-dave.jiang@intel.com>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

