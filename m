Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1F173
	for <linux-cxl@vger.kernel.org>; Wed,  4 Sep 2024 00:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725408800; cv=none; b=k0B561PUaf76tVGfryGCJM1eSmEmlxHPygamApp0DbLmNyeOnI/kM8lWTnmeQhovTOJJbGs+W4MRJ2rX45InWDMPDmjcprxvXgd9VT8hAL07WZKHkcBLAjG2FM9XgrlyTqwZUlSn8im6vU/glaOa4/7JkdNlvyQr27qsSX8OXd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725408800; c=relaxed/simple;
	bh=sonsEKU6qa0Qf43Kit9xxSz4ba5CMrT6GShp+p0QvLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbWOXyh4buhIf1WcpBYaxMJs52xuKdoOIFXasHPTdXJArr1hvGRda7iYlN+SxqatpZX/IfewMy63kqUYuHvf8Gw9pfY7UoMhPeC0NfSkHoU8QbrhQn3T7NV1ab+P5zjrTw03zW80JeUuF/ZJxjcTi6n+wPgfKt7Tfjli9TWOjA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454D6C4CEC4;
	Wed,  4 Sep 2024 00:13:20 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v8 1/3] cxl: Preserve the CDAT access_coordinate for an endpoint
Date: Tue,  3 Sep 2024 17:11:50 -0700
Message-ID: <20240904001316.1688225-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904001316.1688225-1-dave.jiang@intel.com>
References: <20240904001316.1688225-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep the access_coordinate from the CDAT tables for region perf
calculations. The region perf calculation requires all participating
endpoints to have arrived in order to determine if there are limitations
of bandwidth data due to shared uplink.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v8
- Rebase adjustment against v6.11-rc5
---
 drivers/cxl/core/cdat.c | 10 ++++++----
 drivers/cxl/cxlmem.h    |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index bb83867d9fec..fea214340d4b 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -15,7 +15,7 @@ struct dsmas_entry {
 	struct range dpa_range;
 	u8 handle;
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
-
+	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
 	int entries;
 	int qos_class;
 };
@@ -163,7 +163,7 @@ static int cdat_dslbis_handler(union acpi_subtable_headers *header, void *arg,
 	val = cdat_normalize(le16_to_cpu(le_val), le64_to_cpu(le_base),
 			     dslbis->data_type);
 
-	cxl_access_coordinate_set(dent->coord, dslbis->data_type, val);
+	cxl_access_coordinate_set(dent->cdat_coord, dslbis->data_type, val);
 
 	return 0;
 }
@@ -220,7 +220,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 	xa_for_each(dsmas_xa, index, dent) {
 		int qos_class;
 
-		cxl_coordinates_combine(dent->coord, dent->coord, ep_c);
+		cxl_coordinates_combine(dent->coord, dent->cdat_coord, ep_c);
 		dent->entries = 1;
 		rc = cxl_root->ops->qos_class(cxl_root,
 					      &dent->coord[ACCESS_COORDINATE_CPU],
@@ -241,8 +241,10 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
 			      struct cxl_dpa_perf *dpa_perf)
 {
-	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++)
+	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
 		dpa_perf->coord[i] = dent->coord[i];
+		dpa_perf->cdat_coord[i] = dent->cdat_coord[i];
+	}
 	dpa_perf->dpa_range = dent->dpa_range;
 	dpa_perf->qos_class = dent->qos_class;
 	dev_dbg(dev,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index afb53d058d62..2d9208aabdf8 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -397,11 +397,13 @@ enum cxl_devtype {
  * struct cxl_dpa_perf - DPA performance property entry
  * @dpa_range: range for DPA address
  * @coord: QoS performance data (i.e. latency, bandwidth)
+ * @cdat_coord - raw QoS performance data from CDAT
  * @qos_class: QoS Class cookies
  */
 struct cxl_dpa_perf {
 	struct range dpa_range;
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
+	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
 	int qos_class;
 };
 
-- 
2.46.0

