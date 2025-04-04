Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D615990C
	for <linux-cxl@vger.kernel.org>; Fri,  4 Apr 2025 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743807659; cv=none; b=WRX3abkbfZC7LdhZZzc/M5CRtJIBlUzsf85zZav7vICvZSOJ3vuNdQR88pwfrzY8QSafx31uPbdpGmmYmaHsc1yM7Nwwsv2tFi+dm8aN+j9/FWbBK9+iYX4DEV7bvSxv1UNmVTZTdjZCBsKltcCZIWbqoQJacHDOFvoRZLIrF28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743807659; c=relaxed/simple;
	bh=8UukJ7od9194w+AZpeJi+LadeVF6Wy1JvRcUC4clVmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8YI9F6+ISgD/RRssD513Su/REmLrqnoN+8htQau7wrUbjTt37I5HYeELfJNVZ41zOWZCEHVLCCbxu8g0zi4PBxvF0QkaKXni57V+iVqcu3he+R0+7gqaNrPEv12VSASCE1pwvRob2CJtNG5KTk2o+7inAplh5vJNL02mZl8hCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3D8C4CEDD;
	Fri,  4 Apr 2025 23:00:58 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com
Subject: [PATCH 4/4] cxl/test: Add workaround for cxl_test for cxl_core calling mocked functions
Date: Fri,  4 Apr 2025 15:57:36 -0700
Message-ID: <20250404230049.3578835-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404230049.3578835-1-dave.jiang@intel.com>
References: <20250404230049.3578835-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cxl_core calls a cxl_core exported function and that function is
mocked by cxl_test, the call chain causes a circular dependency issue. Dan
provided a workaround to avoid this issue. Apply the method to changes from
the late host bridge uport mapping update changes in order to enable
cxl-test.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c        | 51 +++++++++++++++++++++++++++++------
 drivers/cxl/cxl.h             | 16 +++++++++++
 tools/testing/cxl/Kbuild      |  3 ---
 tools/testing/cxl/test/mock.c | 34 +++++++++++++++--------
 4 files changed, 82 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 70cae4ebf8a4..ed6bdbd6b452 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -39,14 +39,19 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	return 0;
 }
 
-/*
+/**
+ * __devm_cxl_add_passthrough_decoder - Add passthrough decoder
+ * @port: The cxl_port context
+ *
+ * Return 0 on success or errno on failure.
+ *
  * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability Structure)
  * single ported host-bridges need not publish a decoder capability when a
  * passthrough decode can be assumed, i.e. all transactions that the uport sees
  * are claimed and passed to the single dport. Disable the range until the first
  * CXL region is enumerated / activated.
  */
-int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
+int __devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 {
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_dport *dport = NULL;
@@ -73,6 +78,16 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 
 	return add_hdm_decoder(port, &cxlsd->cxld, single_port_map);
 }
+EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_passthrough_decoder, "CXL");
+
+cxl_add_pt_decoder_fn _devm_cxl_add_passthrough_decoder =
+	__devm_cxl_add_passthrough_decoder;
+EXPORT_SYMBOL_NS_GPL(_devm_cxl_add_passthrough_decoder, "CXL");
+
+int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
+{
+	return _devm_cxl_add_passthrough_decoder(port);
+}
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, "CXL");
 
 static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
@@ -139,12 +154,12 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 }
 
 /**
- * devm_cxl_setup_hdm - map HDM decoder component registers
+ * __devm_cxl_setup_hdm - map HDM decoder component registers
  * @port: cxl_port to map
  * @info: cached DVSEC range register info
  */
-struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
-				   struct cxl_endpoint_dvsec_info *info)
+struct cxl_hdm *__devm_cxl_setup_hdm(struct cxl_port *port,
+				     struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_register_map *reg_map = &port->reg_map;
 	struct device *dev = &port->dev;
@@ -199,6 +214,16 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 
 	return cxlhdm;
 }
+EXPORT_SYMBOL_NS_GPL(__devm_cxl_setup_hdm, "CXL");
+
+cxl_setup_hdm_fn _devm_cxl_setup_hdm = __devm_cxl_setup_hdm;
+EXPORT_SYMBOL_NS_GPL(_devm_cxl_setup_hdm, "CXL");
+
+struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
+				   struct cxl_endpoint_dvsec_info *info)
+{
+	return _devm_cxl_setup_hdm(port, info);
+}
 EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, "CXL");
 
 static void __cxl_dpa_debug(struct seq_file *file, struct resource *r, int depth)
@@ -1150,12 +1175,12 @@ static void cxl_settle_decoders(struct cxl_hdm *cxlhdm)
 }
 
 /**
- * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
+ * __devm_cxl_enumerate_decoders - add decoder objects per HDM register set
  * @cxlhdm: Structure to populate with HDM capabilities
  * @info: cached DVSEC range register info
  */
-int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
-				struct cxl_endpoint_dvsec_info *info)
+int __devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				  struct cxl_endpoint_dvsec_info *info)
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
@@ -1212,4 +1237,14 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(__devm_cxl_enumerate_decoders, "CXL");
+
+cxl_enum_decoders_fn _devm_cxl_enumerate_decoders = __devm_cxl_enumerate_decoders;
+EXPORT_SYMBOL_NS_GPL(_devm_cxl_enumerate_decoders, "CXL");
+
+int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				struct cxl_endpoint_dvsec_info *info)
+{
+	return _devm_cxl_enumerate_decoders(cxlhdm, info);
+}
 EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_decoders, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b27e9d3306fe..ffcd6de18e20 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -911,6 +911,22 @@ bool dev_is_cxl_root_child(struct device *dev);
 int cxl_port_setup_regs(struct cxl_port *port,
 			resource_size_t component_reg_phys);
 
+typedef struct cxl_hdm *(*cxl_setup_hdm_fn)(struct cxl_port *port,
+					    struct cxl_endpoint_dvsec_info *info);
+extern cxl_setup_hdm_fn _devm_cxl_setup_hdm;
+struct cxl_hdm *__devm_cxl_setup_hdm(struct cxl_port *port,
+				     struct cxl_endpoint_dvsec_info *info);
+
+typedef int (*cxl_enum_decoders_fn)(struct cxl_hdm *cxlhdm,
+				    struct cxl_endpoint_dvsec_info *info);
+extern cxl_enum_decoders_fn _devm_cxl_enumerate_decoders;
+int __devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				  struct cxl_endpoint_dvsec_info *info);
+
+typedef int (*cxl_add_pt_decoder_fn)(struct cxl_port *port);
+extern cxl_add_pt_decoder_fn _devm_cxl_add_passthrough_decoder;
+int __devm_cxl_add_passthrough_decoder(struct cxl_port *port);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 387f3df8b988..34ea6e6f773b 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -5,9 +5,6 @@ ldflags-y += --wrap=acpi_evaluate_integer
 ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=nvdimm_bus_register
 ldflags-y += --wrap=devm_cxl_port_enumerate_dports
-ldflags-y += --wrap=devm_cxl_setup_hdm
-ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
-ldflags-y += --wrap=devm_cxl_enumerate_decoders
 ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=cxl_hdm_decode_init
 ldflags-y += --wrap=cxl_dvsec_rr_decode
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index af2594e4f35d..f3d97652b9ee 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -13,9 +13,21 @@
 
 static LIST_HEAD(mock);
 
+static struct cxl_hdm *
+redirect_devm_cxl_setup_hdm(struct cxl_port *port,
+			    struct cxl_endpoint_dvsec_info *info);
+static int
+redirect_devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				     struct cxl_endpoint_dvsec_info *info);
+static int redirect_devm_cxl_add_passthrough_decoder(struct cxl_port *port);
+
 void register_cxl_mock_ops(struct cxl_mock_ops *ops)
 {
 	list_add_rcu(&ops->list, &mock);
+	_devm_cxl_setup_hdm = redirect_devm_cxl_setup_hdm;
+	_devm_cxl_enumerate_decoders = redirect_devm_cxl_enumerate_decoders;
+	_devm_cxl_add_passthrough_decoder =
+		redirect_devm_cxl_add_passthrough_decoder;
 }
 EXPORT_SYMBOL_GPL(register_cxl_mock_ops);
 
@@ -23,6 +35,9 @@ DEFINE_STATIC_SRCU(cxl_mock_srcu);
 
 void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
 {
+	_devm_cxl_setup_hdm = __devm_cxl_setup_hdm;
+	_devm_cxl_enumerate_decoders = __devm_cxl_enumerate_decoders;
+	_devm_cxl_add_passthrough_decoder = __devm_cxl_add_passthrough_decoder;
 	list_del_rcu(&ops->list);
 	synchronize_srcu(&cxl_mock_srcu);
 }
@@ -131,8 +146,8 @@ __wrap_nvdimm_bus_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__wrap_nvdimm_bus_register);
 
-struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port,
-					  struct cxl_endpoint_dvsec_info *info)
+struct cxl_hdm *redirect_devm_cxl_setup_hdm(struct cxl_port *port,
+					    struct cxl_endpoint_dvsec_info *info)
 
 {
 	int index;
@@ -142,14 +157,13 @@ struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port,
 	if (ops && ops->is_mock_port(port->uport_dev))
 		cxlhdm = ops->devm_cxl_setup_hdm(port, info);
 	else
-		cxlhdm = devm_cxl_setup_hdm(port, info);
+		cxlhdm = __devm_cxl_setup_hdm(port, info);
 	put_cxl_mock_ops(index);
 
 	return cxlhdm;
 }
-EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_setup_hdm, "CXL");
 
-int __wrap_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
+int redirect_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 {
 	int rc, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
@@ -157,15 +171,14 @@ int __wrap_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 	if (ops && ops->is_mock_port(port->uport_dev))
 		rc = ops->devm_cxl_add_passthrough_decoder(port);
 	else
-		rc = devm_cxl_add_passthrough_decoder(port);
+		rc = __devm_cxl_add_passthrough_decoder(port);
 	put_cxl_mock_ops(index);
 
 	return rc;
 }
-EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_passthrough_decoder, "CXL");
 
-int __wrap_devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
-				       struct cxl_endpoint_dvsec_info *info)
+int redirect_devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+					 struct cxl_endpoint_dvsec_info *info)
 {
 	int rc, index;
 	struct cxl_port *port = cxlhdm->port;
@@ -174,12 +187,11 @@ int __wrap_devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	if (ops && ops->is_mock_port(port->uport_dev))
 		rc = ops->devm_cxl_enumerate_decoders(cxlhdm, info);
 	else
-		rc = devm_cxl_enumerate_decoders(cxlhdm, info);
+		rc = __devm_cxl_enumerate_decoders(cxlhdm, info);
 	put_cxl_mock_ops(index);
 
 	return rc;
 }
-EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_enumerate_decoders, "CXL");
 
 int __wrap_devm_cxl_port_enumerate_dports(struct cxl_port *port)
 {
-- 
2.49.0

