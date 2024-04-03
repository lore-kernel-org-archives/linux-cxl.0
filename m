Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21B14A4E9
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159336; cv=none; b=kV0Kkx5D/xx0fvWG0jnJ28IqLGBbdZ8SHmvg8nkJ2VwEIDXqLFSlK8FscFCD+eqpsU9BkbgNc8TYcU4c+JDTBemUrzXc7wK6HNsN2Coq+rlRkxS3O0pxA4P7qE4f21SumlPgEsH6Rg6Al8UTms5VnEGnkDaFUkPk5Hkce+mx7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159336; c=relaxed/simple;
	bh=v/i3KBuauxaft6sxzthGoc4nYljTOJe8Hr0WxvM6dKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7O8zsU1cnfBuyWV4KfZMThnx4zkns3IcN84LUW+oBpSE7gLqR/FkuKMZnFAtZtb1PPHdnfU6zSCDFTFXSiQvHJxKySIb6E15c/Bk6XH/YFhRP812ONqn3t4dpYw8KrZ53GjN24Rf+f10EetwSRbu992zHomyyEdIRRCFlMdMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EAEC43399;
	Wed,  3 Apr 2024 15:48:55 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v7 5/5] cxl: Add checks to access_coordinate calculation to fail missing data
Date: Wed,  3 Apr 2024 08:47:16 -0700
Message-ID: <20240403154844.3403859-6-dave.jiang@intel.com>
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

Jonathan noted that when the coordinates for host bridge and switches
can be 0s if no actual data are retrieved and the calculation continues.
The resulting number would be inaccurate. Add checks to ensure that the
calculation would complete only if the numbers are valid.

While not seen in the wild, issue may show up with a BIOS that reported
CXL root ports via Generic Ports (via a PCI handle in the SRAT entry).

Fixes: 14a6960b3e92 ("cxl: Add helper function that calculate performance data for downstream ports")
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 801c4018a1dd..762783bb091a 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2141,6 +2141,18 @@ static void add_latency(struct access_coordinate *c, long latency)
 	}
 }
 
+static bool coordinates_valid(struct access_coordinate *c)
+{
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
+		if (c[i].read_bandwidth && c[i].write_bandwidth &&
+		    c[i].read_latency && c[i].write_latency)
+			continue;
+		return false;
+	}
+
+	return true;
+}
+
 static void set_min_bandwidth(struct access_coordinate *c, unsigned int bw)
 {
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
@@ -2206,13 +2218,18 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 		 * There's no valid access_coordinate for a root port since RPs do not
 		 * have CDAT and therefore needs to be skipped.
 		 */
-		if (!is_cxl_root)
+		if (!is_cxl_root) {
+			if (!coordinates_valid(dport->coord))
+				return -EINVAL;
 			cxl_coordinates_combine(c, c, dport->coord);
+		}
 		add_latency(c, dport->link_latency);
 	} while (!is_cxl_root);
 
 	dport = iter->parent_dport;
 	/* Retrieve HB coords */
+	if (!coordinates_valid(dport->coord))
+		return -EINVAL;
 	cxl_coordinates_combine(c, c, dport->coord);
 
 	/* Get the calculated PCI paths bandwidth */
-- 
2.44.0

