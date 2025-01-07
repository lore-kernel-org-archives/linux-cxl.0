Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7274E14F9FD;
	Tue,  7 Jan 2025 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222313; cv=pass; b=a00rfZy7lQpB3pB3YVdmRQIAlnCl8CkU2RGC405TpyonJxxO+Ah5U76BK9HSIXdA6yR5kG3IF2SgJgZpQSkKw7aKdaRAqUpXCEHQB+zGx63q9JQImi3sFCR5v4j4MiWCB/RLeXMkMOLP1Z/yEJWTywxbr9VCq7NU7P/0NzNbiDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222313; c=relaxed/simple;
	bh=yGQY2jobpoPyyWyv8ALwgoLQF/nXPZikai9+tl3z6lY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ztcpypy+OOtvUWmV1iARozXvKz9SFC7rWv0kexSlVn9MGkqf/8AnayhpU9ESbHeoXIcNTFOuSbYRL88OkYU3TfLJvypChl4yrT0w8jZSokh7tzOOOR4HqZh0/QRFXd0rD1eA3b1MD/k0MJRu/YfsVUeZcsIOkqStOAXLRTnO7eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=d77w07JD; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="d77w07JD"
ARC-Seal: i=1; a=rsa-sha256; t=1736222285; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Og0Ir0nOyeVSICdIAc5/mQINztxiedCRzmYOyKj08uJdUr2IC4JJZv9FdCT5PFPRv/pRqyahd5IbhTffS1Ww2XzLU/H3DO0bSSU1t71c27GJRpzhOrWiNJUB4phkPcBGSZfrZoEb6j/Y8d/y7hvdZ82lGbxg0PFgl36CJCmfytk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736222285; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xtx1Y0qNloiBiG48S0dYwcxuoZj69hd4Fnz1ee2aAyc=; 
	b=CdErRd/mwawhDHH7cWIsEy7v6N0Sl/R8RT01PTgNi3T6pKxkM9EUpL0HwvlbOq6YiJn8RwXsflt3PnMd4TPGOAF+X0DeyMfADumq34c2UNFZFswPJZ1Psnoc6P38iZAjZT1FvPgQTUU14nFzpMAlyukTiuYHsXgeCMcJjFUUByA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736222285;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=xtx1Y0qNloiBiG48S0dYwcxuoZj69hd4Fnz1ee2aAyc=;
	b=d77w07JDH5X+pacisYVtP5V4GKCz9LhbUujfbBsFkTC7E5wB/vWsSMTpWc6GTsHJ
	1dcmhI8h6R8YT1X16xd1pGA8uXNC4f2b1xGPQx4+YqVZ3/6+dilpHILNeWj7rmXrC+6
	Jyc9bW6y43BeIR2aLZUNP84tXPVpCeykEvbcNTQc=
Received: by mx.zohomail.com with SMTPS id 1736222283105600.1208529234427;
	Mon, 6 Jan 2025 19:58:03 -0800 (PST)
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
Subject: [RFC PATCH 5/8] cxl/port: Remove component_reg_phys parameter from devm_cxl_add_port()
Date: Tue,  7 Jan 2025 11:57:05 +0800
Message-Id: <20250107035708.1134954-6-ming.li@zohomail.com>
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
Feedback-ID: rr08011227af989cad0c073ab114caf994000043d42f35344d37d822569302e4839a7b8a32b9a893ed199608:zu08011227629b8e546cd1d307c8ed576200000225a6d961be14539e59c266feed87628be8dc63dc4dce1ca3:rf0801122dc633b6006627fa3cb8f6e194000025b11bb1f6ece12df4fb97d45fadc650442744261412d03e8436f9f7cf0e6f:ZohoMail
X-ZohoMailClient: External

devm_cxl_add_port() is not responsible for port component registers
setup anymore, the component_reg_phys parameter is unnecessary for
devm_cxl_add_port().

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/acpi.c      |  3 ++-
 drivers/cxl/core/port.c | 19 +++++--------------
 drivers/cxl/cxl.h       |  1 -
 drivers/cxl/mem.c       |  3 +--
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cb14829bb9be..b754c2c55659 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -662,9 +662,10 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	if (rc)
 		return rc;
 
-	port = devm_cxl_add_port(host, bridge, component_reg_phys, dport);
+	port = devm_cxl_add_port(host, bridge, dport);
 	if (IS_ERR(port))
 		return PTR_ERR(port);
+	port->chbcr = component_reg_phys;
 
 	dev_info(bridge, "host supports CXL\n");
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 57ed152d96d7..b406ba64f6bc 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -873,9 +873,7 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 			    &cxl_einj_inject_fops);
 }
 
-static int cxl_port_add(struct cxl_port *port,
-			resource_size_t component_reg_phys,
-			struct cxl_dport *parent_dport)
+static int cxl_port_add(struct cxl_port *port, struct cxl_dport *parent_dport)
 {
 	struct device *dev __free(put_device) = &port->dev;
 	int rc;
@@ -900,9 +898,6 @@ static int cxl_port_add(struct cxl_port *port,
 		rc = dev_set_name(dev, "port%d", port->id);
 		if (rc)
 			return rc;
-
-		if (is_cxl_root(parent_dport->port))
-			port->chbcr = component_reg_phys;
 	} else {
 		rc = dev_set_name(dev, "root%d", port->id);
 		if (rc)
@@ -920,7 +915,6 @@ static int cxl_port_add(struct cxl_port *port,
 
 static struct cxl_port *__devm_cxl_add_port(struct device *host,
 					    struct device *uport_dev,
-					    resource_size_t component_reg_phys,
 					    struct cxl_dport *parent_dport)
 {
 	struct cxl_port *port;
@@ -930,7 +924,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	if (IS_ERR(port))
 		return port;
 
-	rc = cxl_port_add(port, component_reg_phys, parent_dport);
+	rc = cxl_port_add(port, parent_dport);
 	if (rc)
 		return ERR_PTR(rc);
 
@@ -956,18 +950,15 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
  * devm_cxl_add_port - register a cxl_port in CXL memory decode hierarchy
  * @host: host device for devm operations
  * @uport_dev: "physical" device implementing this upstream port
- * @component_reg_phys: (optional) for configurable cxl_port instances
  * @parent_dport: next hop up in the CXL memory decode hierarchy
  */
 struct cxl_port *devm_cxl_add_port(struct device *host,
 				   struct device *uport_dev,
-				   resource_size_t component_reg_phys,
 				   struct cxl_dport *parent_dport)
 {
 	struct cxl_port *port, *parent_port;
 
-	port = __devm_cxl_add_port(host, uport_dev, component_reg_phys,
-				   parent_dport);
+	port = __devm_cxl_add_port(host, uport_dev, parent_dport);
 
 	parent_port = parent_dport ? parent_dport->port : NULL;
 	if (IS_ERR(port)) {
@@ -994,7 +985,7 @@ struct cxl_root *devm_cxl_add_root(struct device *host,
 	struct cxl_root *cxl_root;
 	struct cxl_port *port;
 
-	port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
+	port = devm_cxl_add_port(host, host, NULL);
 	if (IS_ERR(port))
 		return ERR_CAST(port);
 
@@ -1661,7 +1652,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		port = find_cxl_port_at(parent_port, dport_dev, &dport);
 		if (!port) {
 			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
-						 CXL_RESOURCE_NONE, parent_dport);
+						 parent_dport);
 			if (IS_ERR(port))
 				return PTR_ERR(port);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9877a0ddb5e9..7763be02ef81 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -748,7 +748,6 @@ int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
 struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port);
 struct cxl_port *devm_cxl_add_port(struct device *host,
 				   struct device *uport_dev,
-				   resource_size_t component_reg_phys,
 				   struct cxl_dport *parent_dport);
 struct cxl_root *devm_cxl_add_root(struct device *host,
 				   const struct cxl_root_ops *ops);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 2f03a4d5606e..39da99a4bf4d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -65,8 +65,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	}
 
 	/* Note: endpoint port component registers are derived from @cxlds */
-	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
-				     parent_dport);
+	endpoint = devm_cxl_add_port(host, &cxlmd->dev, parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
 
-- 
2.34.1

