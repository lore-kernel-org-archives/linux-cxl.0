Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905BA71B3A
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724736498; cv=none; b=QAYUqb7bgaSy0coF446r6mbp1xIzZRgKnks48CCZ2zc2QyBZqUb5DJeuTE02Za7t0/FIDeTeWcu/D8MVbnOcoHr8AmkXGEjw7DS2sP4kXLnrrUif04AnYVxLmcDTrFEiFceSGiBxgE4lyCKzKD1mKzfS5hsAvwK8prxSS8RkAZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724736498; c=relaxed/simple;
	bh=MSH8aOu/mlbHSVWmpwdXXynqXgSs116XX4lCUeuuBS8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gCUgtrXYmTHP/kg184jEFf6+/Ua3HyDKUvFV2NcrLBnQCuX2lPi4krtB/xq0xQTn2ntHOWKHrmdox7mIGqTogEEVNlHSJLA7CsZRBZZdl0QHFzHzIxjD6qoPV3gS1a03GohmWFG7bjJQKsAyrsa6V8kn1aOltL8o6aNJS5Ptrlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUV1crld; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUV1crld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724736496; x=1756272496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MSH8aOu/mlbHSVWmpwdXXynqXgSs116XX4lCUeuuBS8=;
  b=dUV1crldJl0uRMMMOFiMqPuK4duDd6ZtdfwejW4NwH8BXFH8rm7xh72N
   8pOZntQuXKZajO582qFroQzdOb2z+35ILzIgmKVBsSOJJCtu+R7NmCsFe
   dwl5QxnuND8NJV/OYTHwZSHkFdEiTtYNdgupABpMU1CrmukxS9Q0zOI2J
   JXpDOzSlhfI3wEOArk5o2rV+csrFlGAgdX3z/MQsv1BCQaXx9S/3hULDl
   ycegsCZrlcJq4mlzl8syyGLdjauxnxXJmez85WQeNDr4SF9lpJD9LMmjR
   LE2z3k7v0HrQ7Wxzb0AGhYw3Xi7jPUWE3S83UECbD+mWgwiJ7ZMfamY1e
   w==;
X-CSE-ConnectionGUID: zghCZhmMR5yjQQQLNvXAgQ==
X-CSE-MsgGUID: typrINvfTd6oTQ2+HyRCkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="22715152"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="22715152"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 22:28:16 -0700
X-CSE-ConnectionGUID: JIRFwd7HROW6fj7h/Ldl7A==
X-CSE-MsgGUID: Jfpi6louRnOarc4DAXeOJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62577895"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 22:28:13 -0700
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
Subject: [PATCH 1/3] cxl/pci: Rename cxl_setup_parent_dport() and cxl_dport_map_regs()
Date: Tue, 27 Aug 2024 04:57:53 +0000
Message-Id: <20240827045755.1837473-1-ming4.li@intel.com>
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
rename the function to cxl_dport_init_aer(), it is easier for user to
understand what the function does. Besides, adjust the order of the
function parameters, the subject of cxl_dport_init_aer() is a cxl port,
so a struct cxl_dport as the first parameter of the function should be
better.

cxl_dport_map_regs() is used to map CXL RAS capability on a cxl dport,
using cxl_dport_map_ras() as the function name.

Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/cxl/core/pci.c        | 13 +++++++++----
 drivers/cxl/cxl.h             |  6 +++---
 drivers/cxl/mem.c             |  2 +-
 tools/testing/cxl/Kbuild      |  2 +-
 tools/testing/cxl/test/mock.c |  6 +++---
 5 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 51132a575b27..9761178372b6 100644
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
+ * cxl_dport_init_aer - Setup AER on this dport
+ * @dport: the cxl_dport that needs to be initialized
+ * @host: host device for devm operations
+ */
+void cxl_dport_init_aer(struct cxl_dport *dport, struct device *host)
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
+EXPORT_SYMBOL_NS_GPL(cxl_dport_init_aer, CXL);
 
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9afb407d438f..c4b7a0d6bb22 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -761,10 +761,10 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 resource_size_t rcrb);
 
 #ifdef CONFIG_PCIEAER_CXL
-void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
+void cxl_dport_init_aer(struct cxl_dport *dport, struct device *host);
 #else
-static inline void cxl_setup_parent_dport(struct device *host,
-					  struct cxl_dport *dport) { }
+static inline void cxl_dport_init_aer(struct cxl_dport *dport,
+				      struct device *host) { }
 #endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 7de232eaeb17..e464ec3681bb 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -166,7 +166,7 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
-	cxl_setup_parent_dport(dev, dport);
+	cxl_dport_init_aer(dport, dev);
 
 	device_lock(endpoint_parent);
 	if (!endpoint_parent->driver) {
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 3d1ca9e38b1f..f9eb12eb3f1b 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -14,7 +14,7 @@ ldflags-y += --wrap=cxl_dvsec_rr_decode
 ldflags-y += --wrap=devm_cxl_add_rch_dport
 ldflags-y += --wrap=cxl_rcd_component_reg_phys
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
-ldflags-y += --wrap=cxl_setup_parent_dport
+ldflags-y += --wrap=cxl_dport_init_aer
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index d619672faa49..6cf89e16fa44 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -299,17 +299,17 @@ void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_endpoint_parse_cdat, CXL);
 
-void __wrap_cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
+void __wrap_cxl_dport_init_aer(struct cxl_dport *dport, struct device *host)
 {
 	int index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
 	if (!ops || !ops->is_mock_port(dport->dport_dev))
-		cxl_setup_parent_dport(host, dport);
+		cxl_dport_init_aer(dport, host);
 
 	put_cxl_mock_ops(index);
 }
-EXPORT_SYMBOL_NS_GPL(__wrap_cxl_setup_parent_dport, CXL);
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dport_init_aer, CXL);
 
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(ACPI);
-- 
2.40.1

