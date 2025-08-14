Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9E427381B
	for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755210191; cv=none; b=PFsqQ2ZmJymI+CNQJ64NQzVB3qMZEZ2IVx3az7d6Sd5hWgoUdYRkFidOvhF7QEX0mDft2mr7Dxq0GqUwiRoFdzSIduYBDMj71HazH3IdUEcnintUAT5c8w37jUpfbYBEMl4fiU8rNU9CSrQi2yUChFaUs4kcnQDtrGps/RdxzR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755210191; c=relaxed/simple;
	bh=3gbAY1CW3AyncaasOS68v2fqWqF+6az425QK5vFVSZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACxGTe6qgZUu0rz9EOlcioxBgqPXO2l8xw0uWYiUrAhqofl0NmSd2u9D55Hu8T+QyVBeFlIiq0+kOzSAZvYM1j8jXfs49t2BTpz2fAK+2v9JkHHmY7Hn/s9LEebXcik4DspsQtdnKtmWwdoOaz+JTx6sYki94CfVdtIH1RMQSFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1051AC4CEED;
	Thu, 14 Aug 2025 22:23:09 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 08/11] cxl/test: Add support to cxl_test for decoder enumeration mock functions
Date: Thu, 14 Aug 2025 15:21:48 -0700
Message-ID: <20250814222151.3520500-9-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814222151.3520500-1-dave.jiang@intel.com>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
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

The following functions are being modified:
devm_cxl_add_passthrough_decoder()
devm_cxl_setup_hdm()
devm_cxl_enumerate_decoders()

In cxl_core they are defined with "__" added in front of the function. A
macro is used to define the original function names for when non-test
version of the kernel is built. A bit of macros and typedefs are used to
allow mocking of those functions in cxl_test.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
Jonathan acked this in v3, nothing changed.
Needed now due to decoder setup is now moved to core
---
 drivers/cxl/core/hdm.c               | 27 +++++++++++++----------
 drivers/cxl/cxl.h                    |  9 ++++++++
 tools/testing/cxl/Kbuild             |  3 ---
 tools/testing/cxl/cxl_core_exports.c | 30 ++++++++++++++++++++++++++
 tools/testing/cxl/exports.h          | 11 ++++++++++
 tools/testing/cxl/test/mock.c        | 32 ++++++++++++++++++----------
 6 files changed, 87 insertions(+), 25 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 5263e9eba7d0..ef30f93e1e10 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -42,14 +42,19 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
 	return 0;
 }
 
-/*
+/**
+ * __devm_cxl_add_passthrough_decoder - Add pasthrough decoder
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
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
@@ -69,7 +74,7 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 
 	return add_hdm_decoder(port, &cxlsd->cxld);
 }
-EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, "CXL");
+EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_passthrough_decoder, "CXL");
 
 static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 {
@@ -135,12 +140,12 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
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
@@ -195,7 +200,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 
 	return cxlhdm;
 }
-EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, "CXL");
+EXPORT_SYMBOL_NS_GPL(__devm_cxl_setup_hdm, "CXL");
 
 static void __cxl_dpa_debug(struct seq_file *file, struct resource *r, int depth)
 {
@@ -1156,12 +1161,12 @@ static void cxl_settle_decoders(struct cxl_hdm *cxlhdm)
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
@@ -1216,4 +1221,4 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_decoders, "CXL");
+EXPORT_SYMBOL_NS_GPL(__devm_cxl_enumerate_decoders, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 796c27e98afb..ba8811388dc8 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -817,9 +817,15 @@ struct cxl_endpoint_dvsec_info {
 struct cxl_hdm;
 struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 				   struct cxl_endpoint_dvsec_info *info);
+struct cxl_hdm *__devm_cxl_setup_hdm(struct cxl_port *port,
+				     struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				struct cxl_endpoint_dvsec_info *info);
+int __devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				  struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
+int __devm_cxl_add_passthrough_decoder(struct cxl_port *port);
+
 struct cxl_dev_state;
 int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			struct cxl_endpoint_dvsec_info *info);
@@ -942,6 +948,9 @@ u16 cxl_gpf_get_dvsec(struct device *dev);
 #ifndef CXL_TEST_ENABLE
 #define DECLARE_TESTABLE(x) __##x
 #define devm_cxl_add_dport_by_dev DECLARE_TESTABLE(devm_cxl_add_dport_by_dev)
+#define devm_cxl_enumerate_decoders DECLARE_TESTABLE(devm_cxl_enumerate_decoders)
+#define devm_cxl_setup_hdm DECLARE_TESTABLE(devm_cxl_setup_hdm)
+#define devm_cxl_add_passthrough_decoder DECLARE_TESTABLE(devm_cxl_add_passthrough_decoder)
 #endif
 
 #endif /* __CXL_H__ */
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index d083cf8cca3b..cc2d2c25b5f9 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -6,9 +6,6 @@ ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=nvdimm_bus_register
 ldflags-y += --wrap=devm_cxl_port_enumerate_dports
 ldflags-y += --wrap=cxl_port_get_possible_dports
-ldflags-y += --wrap=devm_cxl_setup_hdm
-ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
-ldflags-y += --wrap=devm_cxl_enumerate_decoders
 ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=cxl_hdm_decode_init
 ldflags-y += --wrap=cxl_dvsec_rr_decode
diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
index 0d18abc1f5a3..45fbe8804ddf 100644
--- a/tools/testing/cxl/cxl_core_exports.c
+++ b/tools/testing/cxl/cxl_core_exports.c
@@ -17,3 +17,33 @@ struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
 	return _devm_cxl_add_dport_by_dev(port, dport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport_by_dev, "CXL");
+
+cxl_add_pt_decoder_fn _devm_cxl_add_passthrough_decoder =
+	__devm_cxl_add_passthrough_decoder;
+EXPORT_SYMBOL_NS_GPL(_devm_cxl_add_passthrough_decoder, "CXL");
+
+int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
+{
+	return _devm_cxl_add_passthrough_decoder(port);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, "CXL");
+
+cxl_setup_hdm_fn _devm_cxl_setup_hdm = __devm_cxl_setup_hdm;
+EXPORT_SYMBOL_NS_GPL(_devm_cxl_setup_hdm, "CXL");
+
+struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
+				   struct cxl_endpoint_dvsec_info *info)
+{
+	return _devm_cxl_setup_hdm(port, info);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, "CXL");
+
+cxl_enum_decoders_fn _devm_cxl_enumerate_decoders = __devm_cxl_enumerate_decoders;
+EXPORT_SYMBOL_NS_GPL(_devm_cxl_enumerate_decoders, "CXL");
+
+int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				struct cxl_endpoint_dvsec_info *info)
+{
+	return _devm_cxl_enumerate_decoders(cxlhdm, info);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_decoders, "CXL");
diff --git a/tools/testing/cxl/exports.h b/tools/testing/cxl/exports.h
index 9261ce6f1197..7f06207f9f8f 100644
--- a/tools/testing/cxl/exports.h
+++ b/tools/testing/cxl/exports.h
@@ -7,4 +7,15 @@ typedef struct cxl_dport *(*cxl_add_dport_by_dev_fn)(struct cxl_port *port,
 							  struct device *dport_dev);
 extern cxl_add_dport_by_dev_fn _devm_cxl_add_dport_by_dev;
 
+typedef struct cxl_hdm *(*cxl_setup_hdm_fn)(struct cxl_port *port,
+					    struct cxl_endpoint_dvsec_info *info);
+extern cxl_setup_hdm_fn _devm_cxl_setup_hdm;
+
+typedef int (*cxl_enum_decoders_fn)(struct cxl_hdm *cxlhdm,
+				    struct cxl_endpoint_dvsec_info *info);
+extern cxl_enum_decoders_fn _devm_cxl_enumerate_decoders;
+
+typedef int (*cxl_add_pt_decoder_fn)(struct cxl_port *port);
+extern cxl_add_pt_decoder_fn _devm_cxl_add_passthrough_decoder;
+
 #endif
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index fd73a06f6ccb..8b1ab7f6cb5a 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -17,11 +17,21 @@ static LIST_HEAD(mock);
 static struct cxl_dport *
 redirect_devm_cxl_add_dport_by_dev(struct cxl_port *port,
 				   struct device *dport_dev);
+static struct cxl_hdm *
+redirect_devm_cxl_setup_hdm(struct cxl_port *port,
+			    struct cxl_endpoint_dvsec_info *info);
+static int
+redirect_devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				     struct cxl_endpoint_dvsec_info *info);
+static int redirect_devm_cxl_add_passthrough_decoder(struct cxl_port *port);
 
 void register_cxl_mock_ops(struct cxl_mock_ops *ops)
 {
 	list_add_rcu(&ops->list, &mock);
 	_devm_cxl_add_dport_by_dev = redirect_devm_cxl_add_dport_by_dev;
+	_devm_cxl_add_passthrough_decoder = redirect_devm_cxl_add_passthrough_decoder;
+	_devm_cxl_enumerate_decoders = redirect_devm_cxl_enumerate_decoders;
+	_devm_cxl_setup_hdm = redirect_devm_cxl_setup_hdm;
 }
 EXPORT_SYMBOL_GPL(register_cxl_mock_ops);
 
@@ -29,6 +39,9 @@ DEFINE_STATIC_SRCU(cxl_mock_srcu);
 
 void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
 {
+	_devm_cxl_setup_hdm = __devm_cxl_setup_hdm;
+	_devm_cxl_enumerate_decoders = __devm_cxl_enumerate_decoders;
+	_devm_cxl_add_passthrough_decoder = __devm_cxl_add_passthrough_decoder;
 	_devm_cxl_add_dport_by_dev = __devm_cxl_add_dport_by_dev;
 	list_del_rcu(&ops->list);
 	synchronize_srcu(&cxl_mock_srcu);
@@ -138,8 +151,8 @@ __wrap_nvdimm_bus_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__wrap_nvdimm_bus_register);
 
-struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port,
-					  struct cxl_endpoint_dvsec_info *info)
+struct cxl_hdm *redirect_devm_cxl_setup_hdm(struct cxl_port *port,
+					    struct cxl_endpoint_dvsec_info *info)
 
 {
 	int index;
@@ -149,14 +162,13 @@ struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port,
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
@@ -164,15 +176,14 @@ int __wrap_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
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
@@ -181,12 +192,11 @@ int __wrap_devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
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
2.50.1

