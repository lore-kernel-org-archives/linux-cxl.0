Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761A070CB3
	for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407760; cv=none; b=r9NFYYyoPy/u2EXyA4ie76Bv1B4Z0fsZq+BBQ5cisTp3q6+1H08IlkJG0hrT6ObPL4oPoZvZtipFt0KC/ibUSWo+Kk0VRMk3wifrCY1rQLymD3phraiKL5BhSMvwRNTtoN7jWur5cYBRGIbnB1pJcoOnCbG7x+h7Ivq/MeSAJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407760; c=relaxed/simple;
	bh=H4y17Sgfy8LTqSxoRShrPDmA80GWORR6j57CUSxUHyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DapeDuw3oB2MdE8vGiqcLJ2QUGv45JHFIc7qnu7E9zvd+enEpl2qPmlmuuJJMhS88vZUOW+w8oSoLd664roiiYH+d15sorimLZEWbcBOPLQp8avTAGffojefX9W4oQOMicxPqGwUdrWHT6bLp5YyqrNWO+VlKkahh6FXouVvT0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B28C433C7;
	Mon, 25 Mar 2024 23:02:39 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v5 1/4] cxl: Remove checking of iter in cxl_endpoint_get_perf_coordinates()
Date: Mon, 25 Mar 2024 16:00:48 -0700
Message-ID: <20240325230234.1847525-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325230234.1847525-1-dave.jiang@intel.com>
References: <20240325230234.1847525-1-dave.jiang@intel.com>
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
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
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

