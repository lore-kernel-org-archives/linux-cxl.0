Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBFF44C7C;
	Sun, 23 Mar 2025 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742722445; cv=pass; b=RpHlULlR1AmMJPOoZEHHkSLBqcoX25nQIF1UbngW5Tib+Wr1CXLFLGnml1BRnJzDDAAqAEBv7tOnB79xDoUBrG7NWlrbkhqf1tEkGRBxg/hhXuCy58r4nsTuq8sC1TBOUg2EXXtVofSAfg7DzcRaRQcuF1SwQwAjTXwN5qBG11s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742722445; c=relaxed/simple;
	bh=tiwSqqhU97+P/pZXJ5bsuvt5+gojkBlYhAQQZZeUjEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TPuqWeYjvz7X2JKH9UUujD9HTi07/T3JZ+eSYm/uc5sz5dareObo6ToI28V0/KXGR8RJJa8wsf3NJmtRHF7gT1U9DF+lXlalR5YDXw/HrWlJNM9sMyddcT35XWZAsNtkp04G2YGHkd6WyZiw0QDvvecPS6uKi7kGQJQU/LydQj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Il/SzoQw; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Il/SzoQw"
ARC-Seal: i=1; a=rsa-sha256; t=1742722301; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cN+KGQ4g+TTxm4AP8ttD2DOhN3tx9OI8IPVSikJeUBrl5VjIPssloL8DWQnG5YlR6TZl3eg6JZgkis25w9EEBmSSe4kE5W64OOdZqawLlvfhNc6kOrRpLRWBcN+2BTjCX6EZ9hMZHYaCSZv7z/ExangTNX30Mha4zAg/49S9kew=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742722301; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=o9601PbxCzI05wBpWnhCTayb7tVKJyyt4KV5MPhpKH8=; 
	b=B1O74MZ2kBLHyH32FcRvSiikc+XVfVsw3Axk2QwO5z6eQEuoOXv+AcBY0DQmnURtxL1mWHK2ravNej+iJ83TNpkZSqHnMqeGKfw28BheDXHQ3M1peGsapTK1LVVOGO1VpVfisyAduHVw/VPV+r+zM2osVgzCYA1px16Kgj5K8+U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742722301;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=o9601PbxCzI05wBpWnhCTayb7tVKJyyt4KV5MPhpKH8=;
	b=Il/SzoQwzJAhhlETvik4CYXZW5yg0FZgpopcCXjsCdWdKNCngaIUHBk9OYlfpQju
	VS6u3yfuaHg5+B7+BBH/UKCm+fKEf5YOE6beDTwokKqhTwt1QTpkoIafw8XC0khZ8bJ
	KXtJ4QEEHhG6LqW47VW0iP6u39RX5Psnmedx8QC8=
Received: by mx.zohomail.com with SMTPS id 1742722299718726.7777804781059;
	Sun, 23 Mar 2025 02:31:39 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 1/3] cxl/core: Fix caching dport GPF DVSEC issue
Date: Sun, 23 Mar 2025 17:31:08 +0800
Message-Id: <20250323093110.233040-2-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250323093110.233040-1-ming.li@zohomail.com>
References: <20250323093110.233040-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122703d781f4e69c7554d54b01780000e24019ae35fd6d907faa59a108f52f8692472a50c22d5dd5d2:zu0801122729b53c49b6a1ca58f36afa72000038ce6b46a57f20ab8c612e4b897ae0d1645c6348acf3c9faa3:rf0801122de5d741d6409889408286d8bc0000464c6c384d9e9363ee361fa3eca2360c6cc3dcca85bba997b793e61c457fe2:ZohoMail
X-ZohoMailClient: External

Per Table 8-2 in CXL r3.2 section 8.1.1 and CXL r3.2 section 8.1.6, only
CXL Downstream switch ports and CXL root ports have GPF DVSEC for CXL
Port(DVSEC ID 04h).

CXL subsystem has a gpf_dvsec in struct cxl_port which is used to cache
the offset of a GPF DVSEC in PCIe configuration space. It will be
updated during the first EP attaching to the cxl_port, so the gpf_dvsec
can only cache the GPF DVSEC offset of the dport which the first EP is
under. Will not have chance to update it during other EPs attaching.
That means CXL subsystem will use the same GPF DVSEC offset for all
dports under the port, it will be a problem if the GPF DVSEC offset
cached in cxl_port is not the right offset for a dport.

Moving gpf_dvsec from struct cxl_port to struct cxl_dport, make every
cxl dport has their own GPF DVSEC offset caching, and each cxl dport
uses its own GPF DVSEC offset for GPF DVSEC accessing.

Fixes: a52b6a2c1c99 ("cxl/pci: Support Global Persistent Flush (GPF)")
Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/core.h |  2 +-
 drivers/cxl/core/pci.c  | 16 ++++++++--------
 drivers/cxl/core/port.c |  2 +-
 drivers/cxl/cxl.h       |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 15699299dc11..17b692eb3257 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -119,7 +119,7 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
-int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port);
+int cxl_gpf_port_setup(struct cxl_dport *dport);
 int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
 					    int nid, resource_size_t *size);
 
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 96fecb799cbc..aab0a505d527 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1128,26 +1128,26 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
 	return rc;
 }
 
-int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port)
+int cxl_gpf_port_setup(struct cxl_dport *dport)
 {
 	struct pci_dev *pdev;
 
-	if (!port)
+	if (!dport)
 		return -EINVAL;
 
-	if (!port->gpf_dvsec) {
+	if (!dport->gpf_dvsec) {
 		int dvsec;
 
-		dvsec = cxl_gpf_get_dvsec(dport_dev, true);
+		dvsec = cxl_gpf_get_dvsec(dport->dport_dev, true);
 		if (!dvsec)
 			return -EINVAL;
 
-		port->gpf_dvsec = dvsec;
+		dport->gpf_dvsec = dvsec;
 	}
 
-	pdev = to_pci_dev(dport_dev);
-	update_gpf_port_dvsec(pdev, port->gpf_dvsec, 1);
-	update_gpf_port_dvsec(pdev, port->gpf_dvsec, 2);
+	pdev = to_pci_dev(dport->dport_dev);
+	update_gpf_port_dvsec(pdev, dport->gpf_dvsec, 1);
+	update_gpf_port_dvsec(pdev, dport->gpf_dvsec, 2);
 
 	return 0;
 }
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0fd6646c1a2e..726bd4a7de27 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1678,7 +1678,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			if (rc && rc != -EBUSY)
 				return rc;
 
-			cxl_gpf_port_setup(dport_dev, port);
+			cxl_gpf_port_setup(dport);
 
 			/* Any more ports to add between this one and the root? */
 			if (!dev_is_cxl_root_child(&port->dev))
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index be8a7dc77719..2d81ccd83916 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -592,7 +592,6 @@ struct cxl_dax_region {
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
  * @pci_latency: Upstream latency in picoseconds
- * @gpf_dvsec: Cached GPF port DVSEC
  */
 struct cxl_port {
 	struct device dev;
@@ -616,7 +615,6 @@ struct cxl_port {
 	} cdat;
 	bool cdat_available;
 	long pci_latency;
-	int gpf_dvsec;
 };
 
 /**
@@ -664,6 +662,7 @@ struct cxl_rcrb_info {
  * @regs: Dport parsed register blocks
  * @coord: access coordinates (bandwidth and latency performance attributes)
  * @link_latency: calculated PCIe downstream latency
+ * @gpf_dvsec: Cached GPF port DVSEC
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -675,6 +674,7 @@ struct cxl_dport {
 	struct cxl_regs regs;
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	long link_latency;
+	int gpf_dvsec;
 };
 
 /**
-- 
2.34.1

