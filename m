Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606414A0A2
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159332; cv=none; b=KBKeqVGjVxo6bAk+3ijU6ruhpYUxF6aqt45d1TVfcOvW0QD7wrq2rCErnTRFApPXNKiNsAagAiPkPhg0WThWZYN373onTSHnmuQp8HkNcRs4WVjin0NmaasDNORnpmQFGs2/sgy3/oaZz+poZ1OyICQapbScDpCl4V88xpLinqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159332; c=relaxed/simple;
	bh=Pv+FyXjpfAetiPjStiEOtJb7AsfOAqggK6o+5etYUp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRnygbanSIq0KInlieeVsLD18bBDW2f29n/VYw0197gTo7Hn3i6te3ABpUmcjC+E9JhHebItS9W8Xth3qUUnYGnMQSIRJpkKagQ8mXO4m8Dr70YVSC8gTGlU2rBZJNkdtgqQxTyXdclciWmfwCF74OdFGEuUEdqMkK3ibpluMdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7868C433C7;
	Wed,  3 Apr 2024 15:48:51 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v7 1/5] cxl: Remove checking of iter in cxl_endpoint_get_perf_coordinates()
Date: Wed,  3 Apr 2024 08:47:12 -0700
Message-ID: <20240403154844.3403859-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403154844.3403859-1-dave.jiang@intel.com>
References: <20240403154844.3403859-1-dave.jiang@intel.com>
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

