Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F908168B8
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166376; cv=none; b=TNMx53MndIiyL7rfDfwrAVnJGPRkYTQps9Ww0t0gjqBbOvDziq2Y/2IOzptyx0zQkljQ0Dp+qEtDzvhdCcX2vG0jkg1GD5iBjZwkpHF93raBjKUCZRIkv3O6zm8YEMsfL0lA5aAqJNpVgj1aWu/3pQNdos6d+L8VnuQ0wtjlpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166376; c=relaxed/simple;
	bh=oIbWs+UZfqqOJDiFVzfWPMAK/8jTOvNTk+8Qtj735UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFKP9CdOxfYTf3/DT2j8aLg/sY0EukJMmmogl03Yyk6CpLIZcNQxH52Vme+ZqCSVuvAJcmigH7uc6BvskLGVYNtcVTOx/vEpYTIWpwuExim76/pbZU98t7H8julmVSYhWyJgE3yiQy+fTnQYCXFd13TUyC57pQTy3J23oTXW3e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557F0C433C7;
	Thu, 29 Feb 2024 00:26:15 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH 2/2] cxl: Add checks to access_coordinate calculation to fail missing data
Date: Wed, 28 Feb 2024 17:25:42 -0700
Message-ID: <20240229002542.634982-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229002542.634982-1-dave.jiang@intel.com>
References: <20240229002542.634982-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jonathan noted that when the coordinates for host bridge and switches
can be 0s if no actual data are retrieved and the calculation continues.
The resulting number would be inaccurate. Add checks to ensure that the
calculation would complete only if the numbers are valid.

Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e1d30a885700..2c82fe24b789 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2110,6 +2110,20 @@ static void combine_coordinates(struct access_coordinate *c1,
 		c1->read_latency += c2->read_latency;
 }
 
+static bool coordinates_invalid(struct access_coordinate *c)
+{
+	if (!c->read_bandwidth && !c->write_bandwidth &&
+	    !c->read_latency && !c->write_latency)
+		return true;
+
+	return false;
+}
+
+static bool parent_port_is_cxl_root(struct cxl_port *port)
+{
+	return is_cxl_root(to_cxl_port(port->dev.parent));
+}
+
 /**
  * cxl_endpoint_get_perf_coordinates - Retrieve performance numbers stored in dports
  *				   of CXL path
@@ -2142,16 +2156,25 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 	 * port each iteration. If the parent is cxl root then there is
 	 * nothing to gather.
 	 */
-	while (!is_cxl_root(to_cxl_port(iter->dev.parent))) {
-		combine_coordinates(&c, &dport->sw_coord);
+	while (!parent_port_is_cxl_root(iter)) {
+		iter = to_cxl_port(iter->dev.parent);
+
+		/* There's no CDAT for the host bridge, so skip if so. */
+		if (!parent_port_is_cxl_root(iter)) {
+			if (coordinates_invalid(&dport->sw_coord))
+				return -EINVAL;
+
+			combine_coordinates(&c, &dport->sw_coord);
+		}
+
 		c.write_latency += dport->link_latency;
 		c.read_latency += dport->link_latency;
-
-		iter = to_cxl_port(iter->dev.parent);
 		dport = iter->parent_dport;
 	}
 
 	/* Augment with the generic port (host bridge) perf data */
+	if (coordinates_invalid(&dport->hb_coord))
+		return -EINVAL;
 	combine_coordinates(&c, &dport->hb_coord);
 
 	/* Get the calculated PCI paths bandwidth */
-- 
2.43.0

