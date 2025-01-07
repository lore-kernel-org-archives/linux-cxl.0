Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228318248D;
	Tue,  7 Jan 2025 03:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222337; cv=pass; b=Tatxv38odgC6/3Xbrf01xVoGliF8FwHw/17TdbI6MZZZGsQ4Tca52MEHwpJB+xv16LmPyB5Fb4lBKEVcaG0J3TFdAKof4hvCIcUZDOXzrde9Sr4POsfM3KWT2lMEVUZ0829Grk+hsA54y/neiavwIkvVa/2C+00Drc0dDta1h3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222337; c=relaxed/simple;
	bh=vmE2HGufo81XaUlVPpvMfRseeHPjcv3rSy6iL5FRr1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yfm4kHgqRxsTXKFFRq91mdZ0F3t3Opn0kPz/1rSU6S9TBtwDz6G4ChrG6NxM1vyCYqc+lQcfmMQQX0+Y2vstk3kCdGKfeWOwlRnDo79zKYGackjckRExoib4gcWAFyCrb/afN3IfPW7w1T999iCa3y4Iiieflr0OvhSiIPuPMUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=LV9drbLw; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="LV9drbLw"
ARC-Seal: i=1; a=rsa-sha256; t=1736222302; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hqJS6wcFaBynaaAZ/bQ+b2P0CoM2okL9QSeebROyOHbU2UmH0JTKBxgEsS9kEPwNVwZje8K9nEtzlZSx6e4SHcHHSZR+TgBqOKMxS4EWk54bNNOX4qHQ4mUbOS+URz3460pFrADwujShHpUzFDAdpaHQ2k+HbIiSPnON4jfin2w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736222302; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QsagTF1sqpb9JvFymmJIf9sxdVQ5YelFSbEClzxoVbY=; 
	b=WXM7/gcrpgjlkBBaoVEeVZQs7vDIagb0FhC8VvkROfBB4igK5RlNf/0i9cK1QN1LuQ3Vxj97ACSOmRpo+PW3fI7KF4xrwUcrGMmivI+GDlSAsoeQ+UufozFgWt4zTqlYyxqYrhaaDjjxlbPB4oTqnlegYLcoOnUCtq3NXmayqFg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736222302;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=QsagTF1sqpb9JvFymmJIf9sxdVQ5YelFSbEClzxoVbY=;
	b=LV9drbLwNlE29pTAnnjIP6DVztIOqAM++eSoQr18neIw5MNaU18u9H0nctGPwIRQ
	OG9v9mkbxSHHqDHn8dJ5H9laFIPSDckJJnWo6FfLjUm9xAArQ9gBER8kVlWTpnZJhaH
	nEGUOmIdq2+92jG1+2Z9yBnMevzBfmK0fS1I8gSQ=
Received: by mx.zohomail.com with SMTPS id 173622230031819.636274695121756;
	Mon, 6 Jan 2025 19:58:20 -0800 (PST)
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
	Li Ming <ming.li@zohomail.com>
Subject: [RFC PATCH 7/8] cxl/port: Remove component_reg_phys parameter from devm_cxl_add_dport()
Date: Tue,  7 Jan 2025 11:57:07 +0800
Message-Id: <20250107035708.1134954-8-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107035708.1134954-1-ming.li@zohomail.com>
References: <20250107035708.1134954-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112272d67b17ffbb4aedb913b19aa000075ee5274852ffe2fd7bb652e400f7ecc65588584397b8c7665:zu0801122786aa572f67f866847da1255e0000260cd114d33cac91e36c3a900115d37d0469cdcb51fb098caa:rf0801122d131082eb8a0061df18c9ab1100003c3db1610d0a5096f96390658d24bf686a00f62481b89c541b5a8feadbe96d:ZohoMail
X-ZohoMailClient: External

dport component registers setup will be triggered in
cxl_endpoint_port_probe() when the first endpoint attaching.
devm_cxl_add_dport() is not responsible for dport component registers
setup anymore, so the component_reg_phys parameter of
devm_cxl_add_dport() is unnecessary.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/acpi.c            |  3 +--
 drivers/cxl/core/pci.c        |  2 +-
 drivers/cxl/core/port.c       | 13 +++++--------
 drivers/cxl/cxl.h             |  4 ++--
 tools/testing/cxl/test/cxl.c  |  4 +---
 tools/testing/cxl/test/mock.c |  3 +--
 6 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index b754c2c55659..7efd650ab23f 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -596,8 +596,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 		dport = devm_cxl_add_rch_dport(root_port, bridge, ctx.uid,
 					       ctx.base);
 	} else {
-		dport = devm_cxl_add_dport(root_port, bridge, ctx.uid,
-					   CXL_RESOURCE_NONE);
+		dport = devm_cxl_add_dport(root_port, bridge, ctx.uid);
 	}
 
 	if (IS_ERR(dport))
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3b22f3033484..7824f05713a6 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -51,7 +51,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 		return 0;
 
 	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE);
+	dport = devm_cxl_add_dport(port, &pdev->dev, port_num);
 	if (IS_ERR(dport)) {
 		ctx->error = PTR_ERR(dport);
 		return PTR_ERR(dport);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 04617ab825ee..b879520ef3cd 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1178,8 +1178,7 @@ static void cxl_dport_unlink(void *data)
 
 static struct cxl_dport *
 __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
-		     int port_id, resource_size_t component_reg_phys,
-		     resource_size_t rcrb)
+		     int port_id, resource_size_t rcrb)
 {
 	char link_name[CXL_TARGET_STRLEN];
 	struct cxl_dport *dport;
@@ -1256,20 +1255,19 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
  * @port: the cxl_port that references this dport
  * @dport_dev: firmware or PCI device representing the dport
  * @port_id: identifier for this dport in a decoder's target list
- * @component_reg_phys: optional location of CXL component registers
  *
  * Note that dports are appended to the devm release action's of the
  * either the port's host (for root ports), or the port itself (for
  * switch ports)
  */
 struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
-				     struct device *dport_dev, int port_id,
-				     resource_size_t component_reg_phys)
+				     struct device *dport_dev,
+				     int port_id)
 {
 	struct cxl_dport *dport;
 
 	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
-				     component_reg_phys, CXL_RESOURCE_NONE);
+				     CXL_RESOURCE_NONE);
 	if (IS_ERR(dport)) {
 		dev_dbg(dport_dev, "failed to add dport to %s: %ld\n",
 			dev_name(&port->dev), PTR_ERR(dport));
@@ -1302,8 +1300,7 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 		return ERR_PTR(-EINVAL);
 	}
 
-	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
-				     CXL_RESOURCE_NONE, rcrb);
+	dport = __devm_cxl_add_dport(port, dport_dev, port_id, rcrb);
 	if (IS_ERR(dport)) {
 		dev_dbg(dport_dev, "failed to add RCH dport to %s: %ld\n",
 			dev_name(&port->dev), PTR_ERR(dport));
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 601818861441..64a1199786f2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -766,8 +766,8 @@ struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
 
 struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
-				     struct device *dport, int port_id,
-				     resource_size_t component_reg_phys);
+				     struct device *dport,
+				     int port_id);
 struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 struct device *dport_dev, int port_id,
 					 resource_size_t rcrb);
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index d0337c11f9ee..4639ee990e6e 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -968,9 +968,7 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 			continue;
 		}
 
-		dport = devm_cxl_add_dport(port, &pdev->dev, pdev->id,
-					   CXL_RESOURCE_NONE);
-
+		dport = devm_cxl_add_dport(port, &pdev->dev, pdev->id);
 		if (IS_ERR(dport))
 			return PTR_ERR(dport);
 	}
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 450c7566c33f..bcaab0150087 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -254,8 +254,7 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
 	if (ops && ops->is_mock_port(dport_dev)) {
-		dport = devm_cxl_add_dport(port, dport_dev, port_id,
-					   CXL_RESOURCE_NONE);
+		dport = devm_cxl_add_dport(port, dport_dev, port_id);
 		if (!IS_ERR(dport)) {
 			dport->rcrb.base = rcrb;
 			dport->rch = true;
-- 
2.34.1

