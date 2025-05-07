Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046C15E8B
	for <linux-cxl@vger.kernel.org>; Wed,  7 May 2025 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746578597; cv=none; b=hzyPLL3e9Tlp86GeP9GHAlOs1rL6KpAy2Io11JcpGJgYczP/6/g9PiAZQIhpoXlQsrGJk9s7v8dkmUZc4yMVwcvun65XwV0+pfMGnr5Ei8ciWX8vv//q9wJTE+qo1Zl1aSpR3f/4gjTuCDN1dJ5NoQogEAU1UVsyTTuqoOaZSpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746578597; c=relaxed/simple;
	bh=i9UomS2lkP8vK+onfnvNu/ixXk/PB7KtAdW4N5VvtiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5kDho/CdquXt/7+jMVtyA+ayEufdEkGrpMWYlclJl1yl41iDzZJLLNxAxpunAHl29wnT7w9LeGcvER6fj+4CcFBCMj7BE8VtRuY9Xg55Pw9ZSe+dL+/esDQ7fAxUnbny91zwI3zIxtJbkJ5+FpzTfudUPqnahZT8dYkYEOMxy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BF2C4CEE4;
	Wed,  7 May 2025 00:43:17 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com
Subject: [PATCH v2 04/10] cxl: Remove adding of port_num via devm_cxl_add_dport()
Date: Tue,  6 May 2025 17:43:04 -0700
Message-ID: <20250507004310.3536991-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507004310.3536991-1-dave.jiang@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for delayed dport probing, remove setting of port_num
through devm_cxl_add_dport(). Will temporarily set the port_num after
dport is added for now.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/acpi.c            |  7 ++++---
 drivers/cxl/core/pci.c        |  4 +++-
 drivers/cxl/core/port.c       | 18 +++++++-----------
 drivers/cxl/cxl.h             |  5 +++--
 tools/testing/cxl/test/cxl.c  |  5 +++--
 tools/testing/cxl/test/mock.c |  5 ++---
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cb14829bb9be..6f8630e50800 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -593,16 +593,17 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
 		dev_dbg(match, "RCRB found for UID %lld: %pa\n", ctx.uid,
 			&ctx.base);
-		dport = devm_cxl_add_rch_dport(root_port, bridge, ctx.uid,
-					       ctx.base);
+		dport = devm_cxl_add_rch_dport(root_port, bridge, ctx.base);
 	} else {
-		dport = devm_cxl_add_dport(root_port, bridge, ctx.uid,
+		dport = devm_cxl_add_dport(root_port, bridge,
 					   CXL_RESOURCE_NONE);
 	}
 
 	if (IS_ERR(dport))
 		return PTR_ERR(dport);
 
+	dport->port_num = ctx.uid;
+
 	ret = get_genport_coordinates(match, dport);
 	if (ret)
 		dev_dbg(match, "Failed to get generic port perf coordinates.\n");
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3b80e9a76ba8..3b84b43ab194 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -57,11 +57,13 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 		dev_dbg(&port->dev, "failed to find component registers\n");
 
 	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
+	dport = devm_cxl_add_dport(port, &pdev->dev, map.resource);
 	if (IS_ERR(dport)) {
 		ctx->error = PTR_ERR(dport);
 		return PTR_ERR(dport);
 	}
+
+	dport->port_num = port_num;
 	ctx->count++;
 
 	return 0;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d7a4a2ef6ad..70173d23139c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1145,14 +1145,14 @@ static struct cxl_dport *cxl_alloc_dport(struct cxl_port *port,
 	dport->dport_dev = dport_dev;
 	dport->port = port;
 	dport->id = id;
+	dport->port_num = CXL_DPORT_NUM_INVALID;
 
 	return no_free_ptr(dport);
 }
 
 static struct cxl_dport *
 __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
-		     int port_num, resource_size_t component_reg_phys,
-		     resource_size_t rcrb)
+		     resource_size_t component_reg_phys, resource_size_t rcrb)
 {
 	char link_name[CXL_TARGET_STRLEN];
 	struct cxl_dport *dport;
@@ -1182,8 +1182,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	    CXL_TARGET_STRLEN)
 		return ERR_PTR(-EINVAL);
 
-	dport->port_num = port_num;
-
 	if (rcrb == CXL_RESOURCE_NONE) {
 		rc = cxl_dport_setup_regs(&port->dev, dport,
 					  component_reg_phys);
@@ -1244,7 +1242,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
  * devm_cxl_add_dport - append VH downstream port data to a cxl_port
  * @port: the cxl_port that references this dport
  * @dport_dev: firmware or PCI device representing the dport
- * @port_num: identifier for this dport in a decoder's target list
  * @component_reg_phys: optional location of CXL component registers
  *
  * Note that dports are appended to the devm release action's of the
@@ -1252,13 +1249,13 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
  * switch ports)
  */
 struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
-				     struct device *dport_dev, int port_num,
+				     struct device *dport_dev,
 				     resource_size_t component_reg_phys)
 {
 	struct cxl_dport *dport;
 
-	dport = __devm_cxl_add_dport(port, dport_dev, port_num,
-				     component_reg_phys, CXL_RESOURCE_NONE);
+	dport = __devm_cxl_add_dport(port, dport_dev, component_reg_phys,
+				     CXL_RESOURCE_NONE);
 	if (IS_ERR(dport)) {
 		dev_dbg(dport_dev, "failed to add dport to %s: %ld\n",
 			dev_name(&port->dev), PTR_ERR(dport));
@@ -1275,13 +1272,12 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, "CXL");
  * devm_cxl_add_rch_dport - append RCH downstream port data to a cxl_port
  * @port: the cxl_port that references this dport
  * @dport_dev: firmware or PCI device representing the dport
- * @port_num: identifier for this dport in a decoder's target list
  * @rcrb: mandatory location of a Root Complex Register Block
  *
  * See CXL 3.0 9.11.8 CXL Devices Attached to an RCH
  */
 struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
-					 struct device *dport_dev, int port_num,
+					 struct device *dport_dev,
 					 resource_size_t rcrb)
 {
 	struct cxl_dport *dport;
@@ -1291,7 +1287,7 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 		return ERR_PTR(-EINVAL);
 	}
 
-	dport = __devm_cxl_add_dport(port, dport_dev, port_num,
+	dport = __devm_cxl_add_dport(port, dport_dev,
 				     CXL_RESOURCE_NONE, rcrb);
 	if (IS_ERR(dport)) {
 		dev_dbg(dport_dev, "failed to add RCH dport to %s: %ld\n",
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f4fe523aaf12..4ba3bbe9600b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -345,6 +345,7 @@ enum cxl_decoder_type {
 #define CXL_DECODER_MAX_INTERLEAVE 16
 
 #define CXL_QOS_CLASS_INVALID -1
+#define CXL_DPORT_NUM_INVALID -1
 
 /**
  * struct cxl_decoder - Common CXL HDM Decoder Attributes
@@ -754,10 +755,10 @@ struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
 
 struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
-				     struct device *dport, int port_num,
+				     struct device *dport,
 				     resource_size_t component_reg_phys);
 struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
-					 struct device *dport_dev, int port_num,
+					 struct device *dport_dev,
 					 resource_size_t rcrb);
 
 #ifdef CONFIG_PCIEAER_CXL
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index eb36408d287a..4846082127c4 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -968,11 +968,12 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 			continue;
 		}
 
-		dport = devm_cxl_add_dport(port, &pdev->dev, pdev->id,
-					   CXL_RESOURCE_NONE);
+		dport = devm_cxl_add_dport(port, &pdev->dev, CXL_RESOURCE_NONE);
 
 		if (IS_ERR(dport))
 			return PTR_ERR(dport);
+
+		dport->port_num = pdev->id;
 	}
 
 	return 0;
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 6147f0966ffd..d9e8940d9328 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -246,7 +246,6 @@ EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dvsec_rr_decode, "CXL");
 
 struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
 						struct device *dport_dev,
-						int port_id,
 						resource_size_t rcrb)
 {
 	int index;
@@ -254,14 +253,14 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
 	if (ops && ops->is_mock_port(dport_dev)) {
-		dport = devm_cxl_add_dport(port, dport_dev, port_id,
+		dport = devm_cxl_add_dport(port, dport_dev,
 					   CXL_RESOURCE_NONE);
 		if (!IS_ERR(dport)) {
 			dport->rcrb.base = rcrb;
 			dport->rch = true;
 		}
 	} else
-		dport = devm_cxl_add_rch_dport(port, dport_dev, port_id, rcrb);
+		dport = devm_cxl_add_rch_dport(port, dport_dev, rcrb);
 	put_cxl_mock_ops(index);
 
 	return dport;
-- 
2.49.0

