Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB31342CB6
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756491037; cv=none; b=PiEXy+Wndt7ubpBCF1NRuVlbgLZ/QEyaYt2KT2Hjq7XId7Ckb041f5NucIsjNn/oys2YWQUAhbVFWyCB/JWPzsMmhxfLlefduh3szA14d9ANnOsR7efprBxCGI9WRAJ/2cEEJF9c71S5LLsvCIuHLpKzZqdGBIcYt6YFIIXtfSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756491037; c=relaxed/simple;
	bh=VReDBoxeVkBACNCxOOEbaUk8pGmSxyFitxskr+XHqFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5sjTnq+kqXI16movQw/OD8kglakvMCTP+TOCJ3RuzH5Ppb3GJmskmlIZXgyST/NCaxA2ML0Njl8PnJrr/qLi3+EO0SZakV/9Wb+wysA39pGsDIMspqDKLf2pcnMjeBtVtJsZR7XBoznp94BYgoE8iCTINLji/VmGNUApbH5vJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35FFC4CEF0;
	Fri, 29 Aug 2025 18:10:36 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com
Subject: [PATCH v9 08/10] cxl/test: Adjust the mock version of devm_cxl_switch_port_decoders_setup()
Date: Fri, 29 Aug 2025 11:09:26 -0700
Message-ID: <20250829180928.842707-9-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829180928.842707-1-dave.jiang@intel.com>
References: <20250829180928.842707-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With devm_cxl_switch_port_decoders_setup() being called within cxl_core
instead of by the port driver probe, adjustments are needed to deal with
circular symbol dependency when this function is being mock'd. Add the
appropriate changes to get around the circular dependency.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c               |  6 +++---
 drivers/cxl/cxl.h                    |  2 ++
 tools/testing/cxl/Kbuild             |  1 -
 tools/testing/cxl/cxl_core_exports.c | 10 ++++++++++
 tools/testing/cxl/exports.h          |  3 +++
 tools/testing/cxl/test/mock.c        | 10 +++++++---
 6 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 72594f84d2a1..5fa7635c9b75 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1216,12 +1216,12 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 }
 
 /**
- * devm_cxl_switch_port_decoders_setup - allocate and setup switch decoders
+ * __devm_cxl_switch_port_decoders_setup - allocate and setup switch decoders
  * @port: CXL port context
  *
  * Return 0 or -errno on error
  */
-int devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
+int __devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
 
@@ -1245,7 +1245,7 @@ int devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
 	dev_err(&port->dev, "HDM decoder capability not found\n");
 	return -ENXIO;
 }
-EXPORT_SYMBOL_NS_GPL(devm_cxl_switch_port_decoders_setup, "CXL");
+EXPORT_SYMBOL_NS_GPL(__devm_cxl_switch_port_decoders_setup, "CXL");
 
 /**
  * devm_cxl_endpoint_decoders_setup - allocate and setup endpoint decoders
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index aa916f0d186b..8bdc74121736 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -814,6 +814,7 @@ struct cxl_endpoint_dvsec_info {
 
 struct cxl_port;
 int devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
+int __devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
 int devm_cxl_endpoint_decoders_setup(struct cxl_port *port);
 
 struct cxl_dev_state;
@@ -937,6 +938,7 @@ u16 cxl_gpf_get_dvsec(struct device *dev);
 #ifndef CXL_TEST_ENABLE
 #define DECLARE_TESTABLE(x) __##x
 #define devm_cxl_add_dport_by_dev DECLARE_TESTABLE(devm_cxl_add_dport_by_dev)
+#define devm_cxl_switch_port_decoders_setup DECLARE_TESTABLE(devm_cxl_switch_port_decoders_setup)
 #endif
 
 #endif /* __CXL_H__ */
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 81e3795673c5..0d5ce4b74b9f 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -10,7 +10,6 @@ ldflags-y += --wrap=devm_cxl_add_rch_dport
 ldflags-y += --wrap=cxl_rcd_component_reg_phys
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
 ldflags-y += --wrap=cxl_dport_init_ras_reporting
-ldflags-y += --wrap=devm_cxl_switch_port_decoders_setup
 ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
 
 DRIVERS := ../../../drivers
diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
index 0d18abc1f5a3..6754de35598d 100644
--- a/tools/testing/cxl/cxl_core_exports.c
+++ b/tools/testing/cxl/cxl_core_exports.c
@@ -17,3 +17,13 @@ struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
 	return _devm_cxl_add_dport_by_dev(port, dport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport_by_dev, "CXL");
+
+cxl_switch_decoders_setup_fn _devm_cxl_switch_port_decoders_setup =
+	__devm_cxl_switch_port_decoders_setup;
+EXPORT_SYMBOL_NS_GPL(_devm_cxl_switch_port_decoders_setup, "CXL");
+
+int devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
+{
+	return _devm_cxl_switch_port_decoders_setup(port);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_switch_port_decoders_setup, "CXL");
diff --git a/tools/testing/cxl/exports.h b/tools/testing/cxl/exports.h
index 9261ce6f1197..7ebee7c0bd67 100644
--- a/tools/testing/cxl/exports.h
+++ b/tools/testing/cxl/exports.h
@@ -7,4 +7,7 @@ typedef struct cxl_dport *(*cxl_add_dport_by_dev_fn)(struct cxl_port *port,
 							  struct device *dport_dev);
 extern cxl_add_dport_by_dev_fn _devm_cxl_add_dport_by_dev;
 
+typedef int(*cxl_switch_decoders_setup_fn)(struct cxl_port *port);
+extern cxl_switch_decoders_setup_fn _devm_cxl_switch_port_decoders_setup;
+
 #endif
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index e98101f083cd..995269a75cbd 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -17,11 +17,14 @@ static LIST_HEAD(mock);
 static struct cxl_dport *
 redirect_devm_cxl_add_dport_by_dev(struct cxl_port *port,
 				   struct device *dport_dev);
+static int redirect_devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
 
 void register_cxl_mock_ops(struct cxl_mock_ops *ops)
 {
 	list_add_rcu(&ops->list, &mock);
 	_devm_cxl_add_dport_by_dev = redirect_devm_cxl_add_dport_by_dev;
+	_devm_cxl_switch_port_decoders_setup =
+		redirect_devm_cxl_switch_port_decoders_setup;
 }
 EXPORT_SYMBOL_GPL(register_cxl_mock_ops);
 
@@ -29,6 +32,8 @@ DEFINE_STATIC_SRCU(cxl_mock_srcu);
 
 void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
 {
+	_devm_cxl_switch_port_decoders_setup =
+		__devm_cxl_switch_port_decoders_setup;
 	_devm_cxl_add_dport_by_dev = __devm_cxl_add_dport_by_dev;
 	list_del_rcu(&ops->list);
 	synchronize_srcu(&cxl_mock_srcu);
@@ -138,7 +143,7 @@ __wrap_nvdimm_bus_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__wrap_nvdimm_bus_register);
 
-int __wrap_devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
+int redirect_devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
 {
 	int rc, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
@@ -146,12 +151,11 @@ int __wrap_devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
 	if (ops && ops->is_mock_port(port->uport_dev))
 		rc = ops->devm_cxl_switch_port_decoders_setup(port);
 	else
-		rc = devm_cxl_switch_port_decoders_setup(port);
+		rc = __devm_cxl_switch_port_decoders_setup(port);
 	put_cxl_mock_ops(index);
 
 	return rc;
 }
-EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_switch_port_decoders_setup, "CXL");
 
 int __wrap_devm_cxl_endpoint_decoders_setup(struct cxl_port *port)
 {
-- 
2.50.1

