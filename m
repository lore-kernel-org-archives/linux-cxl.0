Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9E31D131D
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000197; cv=none; b=arXjJg6GqdLfmVZK6S/Y50v/RmXMZgh/jiwjM+0iOSCzuVRbi/VlRFwIvvtjFBNCwpVWKZ1A4pVdGM2Fvd5cg7nguQ/6V1yw8tyl1fCtwpTRHJ/VmoNY3nX/dIQnWlyuOhtTuZSevgoX6K4U09rZQLLfSuyw0e7XCqIGEzvWPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000197; c=relaxed/simple;
	bh=qVXbmzaqyqoeex3xIhRoHSGFDyy0uvJQXmRAomvZr/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OfJY65cAzgcEtdmgmlP4dzXdSp34QhdT6MGpPvtGNHJK9Lasb3BUCWtTEa3Vhx+8TbxfsIKEokrZvJJE6wXg+9blvVvWYfmYgNrJe5KkPSxH80qVcem70HOPfXJwlOAThPlkXDpiSC1gSuZZQBWJcCXuqzvxP/OLDqa0f4nrtrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gl1/iZkv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gl1/iZkv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725000196; x=1756536196;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qVXbmzaqyqoeex3xIhRoHSGFDyy0uvJQXmRAomvZr/g=;
  b=Gl1/iZkvxJVh/NIKI9JES9k1wXhqiko66KiqB5MXlw12S30hF4Ri/rap
   Dj8vZDWRdJYUBEHMGDMqu/vLmjwupttWcpAxc52ZPmJ4KG+/pdcMgoraF
   EMAusWI6yyZVYMf/fwe+G+TRwJ+xCATDhUAugbyZ/LEL33suQ1ut78tRs
   B3qh+6krPaiQ+xWs+QM1y7crnv9OrRpHuHn40R3dpPJauCGVCiDiXmiZL
   FicBjCGo7Mb/wCyCQzneauJs5tSsVJY9s4kLlFcSA72hEEcao1fy/BzfO
   KUPjspQFpOW00fnj7Xy3IFk1uw4RVZbg550aKnDkGqw9K8IGfvYZ33N3M
   g==;
X-CSE-ConnectionGUID: 2L/KNLBpQcWxcKAbLx+prw==
X-CSE-MsgGUID: jlrpV5WMSjiOMHxEXmMilA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27424896"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="27424896"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 23:43:15 -0700
X-CSE-ConnectionGUID: EXCiWiDhQyW61SSVvsAGNg==
X-CSE-MsgGUID: 9J4ZNI7cRBy6lvXMqYABiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="94631074"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 23:43:12 -0700
From: Li Ming <ming4.li@intel.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	Li Ming <ming4.li@intel.com>
Subject: [PATCH v2 1/3] cxl/pci: Rename cxl_setup_parent_dport() and cxl_dport_map_regs()
Date: Fri, 30 Aug 2024 06:13:06 +0000
Message-Id: <20240830061308.2327065-1-ming4.li@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The name of cxl_setup_parent_dport() function is not clear, the function
is used to initialize AER and RAS capabilities on a dport, therefore,
rename the function to cxl_dport_init_ras_reporting(), it is easier for
user to understand what the function does. Besides, adjust the order of
the function parameters, the subject of cxl_dport_init_ras_reporting()
is a cxl dport, so a struct cxl_dport as the first parameter of the
function should be better.

cxl_dport_map_regs() is used to map CXL RAS capability on a cxl dport,
using cxl_dport_map_ras() as the function name.

Signed-off-by: Li Ming <ming4.li@intel.com>
---
v2:
- Jonathan: cxl_setup_parent_dport() renamed to
cxl_dport_init_ras_reporting().
- Jonathan: Adjust patch 3's title
Link to v1: https://lore.kernel.org/linux-cxl/69ec6922-08da-4ebb-a45f-24111f0ee2f2@intel.com/T/#ma73e64c1373de3b21f0152ff04f8093244b8d3d1
---
 drivers/cxl/core/pci.c        | 13 +++++++++----
 drivers/cxl/cxl.h             |  6 +++---
 drivers/cxl/mem.c             |  2 +-
 tools/testing/cxl/Kbuild      |  2 +-
 tools/testing/cxl/test/mock.c |  6 +++---
 5 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 51132a575b27..87f992a7f14a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -787,7 +787,7 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 	dport->regs.dport_aer = dport_aer;
 }
 
-static void cxl_dport_map_regs(struct cxl_dport *dport)
+static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
 	struct cxl_register_map *map = &dport->reg_map;
 	struct device *dev = dport->dport_dev;
@@ -831,7 +831,12 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	}
 }
 
-void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
+/**
+ * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
+ * @dport: the cxl_dport that needs to be initialized
+ * @host: host device for devm operations
+ */
+void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 {
 	struct device *dport_dev = dport->dport_dev;
 
@@ -843,12 +848,12 @@ void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 	}
 
 	dport->reg_map.host = host;
-	cxl_dport_map_regs(dport);
+	cxl_dport_map_ras(dport);
 
 	if (dport->rch)
 		cxl_disable_rch_root_ints(dport);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
+EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
 
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9afb407d438f..3327ebad3b81 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -761,10 +761,10 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 resource_size_t rcrb);
 
 #ifdef CONFIG_PCIEAER_CXL
-void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
+void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
 #else
-static inline void cxl_setup_parent_dport(struct device *host,
-					  struct cxl_dport *dport) { }
+static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
+						struct device *host) { }
 #endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 7de232eaeb17..f7a69f79a164 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -166,7 +166,7 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
-	cxl_setup_parent_dport(dev, dport);
+	cxl_dport_init_ras_reporting(dport, dev);
 
 	device_lock(endpoint_parent);
 	if (!endpoint_parent->driver) {
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 3d1ca9e38b1f..b1256fee3567 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -14,7 +14,7 @@ ldflags-y += --wrap=cxl_dvsec_rr_decode
 ldflags-y += --wrap=devm_cxl_add_rch_dport
 ldflags-y += --wrap=cxl_rcd_component_reg_phys
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
-ldflags-y += --wrap=cxl_setup_parent_dport
+ldflags-y += --wrap=cxl_dport_init_ras_reporting
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index d619672faa49..bbd7d938156d 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -299,17 +299,17 @@ void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_endpoint_parse_cdat, CXL);
 
-void __wrap_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
+void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 {
 	int index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
 	if (!ops || !ops->is_mock_port(dport->dport_dev))
-		cxl_setup_parent_dport(host, dport);
+		cxl_dport_init_ras_reporting(dport, host);
 
 	put_cxl_mock_ops(index);
 }
-EXPORT_SYMBOL_NS_GPL(__wrap_cxl_setup_parent_dport, CXL);
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dport_init_ras_reporting, CXL);
 
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(ACPI);
-- 
2.40.1

