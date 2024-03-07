Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371DA335C7
	for <linux-cxl@vger.kernel.org>; Thu,  7 Mar 2024 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709852680; cv=none; b=JsvY5SI40IdPgUAQK+rT+bb/hxYMnIEikiHhYC4UMWMMD3gM8GghpDBWVnVytJQP+PirdZwxOJdFA+0EYC2j4TkDzE7Y6P4AqaF1I8/N2XawVJyqaaxgKwjfG/qeeEF3j54fK8/WRcX22jNMAXRmBuY31mrMEkWUhxYtDU8qRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709852680; c=relaxed/simple;
	bh=tA46EJZUzagP+EFam89puP2PdFYhEXn+dpSITbWsnr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7QYwDzdKP3yg70jqiBQLKV0moxy/FYDqly/8p+f1zT+ExEEZEJYWRYRbCXiT8Dyqf/N1HeR9zlGl8gml9nHZbIPufCtZOjLq5bXNmjbogkTClf73nrLf8+GgAHBFnzhA51ov9TZY7qBxCk3xNB0F7NnHi1vbRaRdM49ZHd8DPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10529C433F1;
	Thu,  7 Mar 2024 23:04:38 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v4 1/3] cxl: Remove checking of iter in cxl_endpoint_get_perf_coordinates()
Date: Thu,  7 Mar 2024 16:04:30 -0700
Message-ID: <20240307230432.2006490-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
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
2.44.0

