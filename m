Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694251990A1;
	Mon, 17 Jun 2024 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654717; cv=fail; b=Qes0/PvdyyoS6KMqOISLLZrCJ1qrdnTx/Jz3id5kO1bNBd7jWQvZF6hwpg7PDu87mjWEwZ9zj5IuZM0O1ypDRY4pCFymAwRkmPDK5YumMtbAdevHSs2/967NrGMIOD27X5e0uWvUhNXyuMfKQEst+dzAK9IBTUCNIZcRbN81oeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654717; c=relaxed/simple;
	bh=vpAjLN0Q2W03GmpM1WSixDUGVhbjHYnHoYotzOBU4bs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plwpYNuAtS19IvDdyitknAzXLiMFkomsF7wbsTfWtsTgY3Sql9hAS+W2kVpgR6oAtUiQz3HpqC6nUp/q0oU0si9Mc5wRqJh5g+pUjqU4Ay3/jbIjqhisCb1ydxl1f8gFS8jHYji6CxiXvwFdYFU0Aq7TQR2qA1psViP/sYPkeuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uFac7V+N; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uFac7V+N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUVV+4MhU/Tk13iyQQb7LSk6eOyGMmonSswYE03x8cn/17DESgKvoALVIiiQrTcYvmLMgouXp7BXzOJuYi+d6NmMjfh17BTmNcqvmnTZ9p40Zd2BgK8vOKxgUtBt9LaRKB450jYmC9OapXWsG2kGOr6zIE4pvIY1z+l+jLHqz4jH2GZmvzxqPaHWA4XmUKZxGr45XcjtSCuzTfAqBVgZT0KD0C3RgeQJRzGbP8JXdt8Gsjl5STcvtyN/2m8x1L9zIvSfZjXLq7Iv4WTJin3qLsnJnbzM31fkcTwsr9ggAomW+sfhDZWcvv4plwmj+I6F0HpMgEy0dapLT9uZbGmovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVtoOEcp5KRdOrLEHoxVb2q71bT6xZkcV470l7qosps=;
 b=U0i7pM1S482V1ebEt/EFlSm556dusv3bYxE20MdzUF7D4qMbLd3rXyqZfTLItJ/IEX2HTHZ9TJvHI8CLcU4iM/9E7TgoYpqN0loZOfPlyMPmkI11UjDoODNhynAKGFhl2cU4nbN+YkbEmx0jCeI/j+dSYGkMSAFBWIKH8i108tr+jgxsq2tIsisMuvjCI0ksRzJ0qFc6zq+eQnO0HMiXTw9UIrO1L8jLBGwihIQtwQrS4lGFKmQhzygLrdgqV8dloMIBlROQ8Mrfzue04GocgeAJzeWqPmAypafVYMAiREFZ7QKBqPk35ZFkce0E3bgR113GsVyO+TUftSy3guf32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVtoOEcp5KRdOrLEHoxVb2q71bT6xZkcV470l7qosps=;
 b=uFac7V+N+x+WLQyWjhrvMHhwTMhu5xrx6eRLj8L49fGWkQYOg7X7BddpzHvh2DPqqTb4J3zoVlYUwLm545GDUaVkbge6x6Ygy/5zFfWDzpOFWlRII93rebg0Ga3rFkP+1aHzSSZE8i7zViJFIPQcCKimn+Fc9TTnZ6OINkz07A4=
Received: from BYAPR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:40::32)
 by PH7PR12MB7796.namprd12.prod.outlook.com (2603:10b6:510:275::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:05:11 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::55) by BYAPR04CA0019.outlook.office365.com
 (2603:10b6:a03:40::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 20:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 20:05:10 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 15:05:07 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <terry.bowman@amd.com>,
	<Yazen.Ghannam@amd.com>, <Robert.Richter@amd.com>
Subject: [RFC PATCH 4/9] cxl/pci: Map CXL PCIe ports' RAS registers
Date: Mon, 17 Jun 2024 15:04:06 -0500
Message-ID: <20240617200411.1426554-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617200411.1426554-1-terry.bowman@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|PH7PR12MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 59206555-cac9-4393-9a4c-08dc8f08caff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|82310400023|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zHyIAmcRJdst9+yZQ9ZEZGxHcWtbE7ZCHvWQqkvmExFvitvJ6YmpKXRVUfJ9?=
 =?us-ascii?Q?tGryRUU9zVIdDyuIIk1XzlPC+k/rCHhTnEhhAijQZkBebqifXbm1EY1kfHqO?=
 =?us-ascii?Q?Gyr5ww1wz2kEw+Zb4Xac3fd8VwlN9vv4iVAEXnUmvy3eEBHelRAfhzrNxMZ9?=
 =?us-ascii?Q?KTjzwEhO0pDdZ+To18vR55P9SNbY5adUCbvPPwWjAsVgdWMCTXcxZM5zxrHL?=
 =?us-ascii?Q?mD3LuXtpRK/1V7Ntw5LDPEA8z96KsPGLszAcpAXx+PnNgtQpDb+dD0bzYcVH?=
 =?us-ascii?Q?SUwXx+IyONbQeEWX/2nAIpRjfbatVFTeF3zBSmWeGtFpHoJMGDa4YW6aS7Vi?=
 =?us-ascii?Q?+1d3vwIufHyPYJwYuHjVDTxMuKLJesnnqr57E9mLVT3sxEWKr0EMaCXCs6e1?=
 =?us-ascii?Q?9HUzao5UdnKYycFgHZEiP8Ghgzx4jJTTN1dkgUhp87HAH1IqgMbSzqJfTFlr?=
 =?us-ascii?Q?wGNnG3a1KFoW4Hq6me/e1wcMnU0J5lb6rTqzdiwugsYtcT3vyS4Tzlbb4v+M?=
 =?us-ascii?Q?HEhyVSWYYQTCOAvm6pIxopxcHfmKVTCqvLez7MYJKA0dI1CPO/2J64uIZllc?=
 =?us-ascii?Q?AYxZInVcKJf47dmqJW/dt5zQ7AYkzPFyZkBUGftHiIFZLEGL1ZCVUkfQkgou?=
 =?us-ascii?Q?N8otPPrplsvV2Yomw/6ayNon+PYhed/jXT/0lkoFZ3T5HufNnB4C1SFs+nQj?=
 =?us-ascii?Q?DAj0nvfNsPKzkUjrkaAbfD+gsCYFzm1lz3DlGRrzJcqnKIl8dV9F0rr5V4sP?=
 =?us-ascii?Q?RKhQ4EsEJuzkgMpNvN1OdiQfaI3poPhwCq5DYKKunCQrvgZzC2ROFaR4+spB?=
 =?us-ascii?Q?rQzANwF7Ux2fMuVvL7Rt0jUg7gbMTIBOoclWAKt0fIvdUFvDKKOzphEXJ/y+?=
 =?us-ascii?Q?jva/rnnWt2kxK29oF2KfqI3bkRBX1WlSA7OllRjqF5rQITSHl5ozxz7rlcb7?=
 =?us-ascii?Q?Z3BXkViN/ydllFIxdC2HjXlYhXyt5xSKezc7iQ/SQOLDHdNKywaXIy1efdTT?=
 =?us-ascii?Q?wBFTxvLb1LAlAJOGRv3k2tkrFpa9Ms04wdhHnro73u72xd+7aFIniPabcmEY?=
 =?us-ascii?Q?Qecc1NUPiOUgvWFHFkMFoT9Fwf4EjTE5rnbzyKFTe6IY/CyMyPVYLt6VQBzr?=
 =?us-ascii?Q?747A6rIQdgZfMfiZDPT6gGFGMZUR+LEatiN1TnNsN+nRbn/oc2clHsnqo4bd?=
 =?us-ascii?Q?gHpMVE8di7/uJ+9NJ34QulZs0zdGXXY6op7canm1qcCGdIWbSQyAZb43vw3t?=
 =?us-ascii?Q?CJXnpkykv3lTRDRkteAUWkVgDycH6LgustRZ8rJp/QvowDDm2BvEU7zOUGGP?=
 =?us-ascii?Q?ZOY6uPJ/HQC3oPEwVEICq0i0HEYFeGQplWweIOsQd+Tm9dtPXuEXiIseileA?=
 =?us-ascii?Q?o7e0JZiB8NxjW4TuaNKK+VeIkxRDzt43c48gCiVkCs0+ekX7VA95wwz1Cuh9?=
 =?us-ascii?Q?i+9G1YbvRfg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(82310400023)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:05:10.6620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59206555-cac9-4393-9a4c-08dc8f08caff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7796

RAS registers are not currently mapped for CXL root ports, CXL downstream
switch ports, and CXL upstream switch ports. Update the driver to map the
ports' RAS registers in preparation for RAS logging and handling to be
added in the future.

Add a 'struct cxl_regs' variable to 'struct cxl_port'. This will be used
to store a pointer to the upstream port's mapped RAS registers.

Invoke the RAS mapping logic from the CXL memory device probe routine
after the endpoint is added. This ensures the ports have completed
training and the RAS registers are present in CXL.cachemem.

Refactor the cxl_dport_map_regs() function to support mapping the CXL
PCIe ports. Also, check for previously mapped registers in the topology
including CXL switch. Endpoints under a CXL switch share a CXL root port
and will be iterated for each endpoint. Only map once.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 30 +++++++++++++++++++++++++-----
 drivers/cxl/cxl.h      |  5 +++++
 drivers/cxl/mem.c      | 32 ++++++++++++++++++++++++++++++--
 3 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0df09bd79408..e6c91b3dfccf 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -787,16 +787,26 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 	dport->regs.dport_aer = dport_aer;
 }
 
-static void cxl_dport_map_regs(struct cxl_dport *dport)
+static void cxl_port_map_regs(struct device *dev,
+			      struct cxl_register_map *map,
+			      struct cxl_regs *regs)
 {
-	struct cxl_register_map *map = &dport->reg_map;
-	struct device *dev = dport->dport_dev;
-
 	if (!map->component_map.ras.valid)
 		dev_dbg(dev, "RAS registers not found\n");
-	else if (cxl_map_component_regs(map, &dport->regs.component,
+	else if (regs->ras)
+		dev_dbg(dev, "RAS registers already initialized\n");
+	else if (cxl_map_component_regs(map, &regs->component,
 					BIT(CXL_CM_CAP_CAP_ID_RAS)))
 		dev_dbg(dev, "Failed to map RAS capability.\n");
+}
+
+static void cxl_dport_map_regs(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->reg_map;
+	struct cxl_regs *regs = &dport->regs;
+	struct device *dev = dport->dport_dev;
+
+	cxl_port_map_regs(dev, map, regs);
 
 	if (dport->rch)
 		cxl_dport_map_rch_aer(dport);
@@ -831,6 +841,16 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	}
 }
 
+void cxl_setup_parent_uport(struct device *host, struct cxl_port *port)
+{
+	struct cxl_register_map *map = &port->reg_map;
+	struct cxl_regs *regs = &port->regs;
+	struct device *uport_dev = port->uport_dev;
+
+	cxl_port_map_regs(uport_dev, map, regs);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_uport, CXL);
+
 void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 {
 	struct device *dport_dev = dport->dport_dev;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 036d17db68e0..7cee678fdb75 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -587,6 +587,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @regs: mapped component registers
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -607,6 +608,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	struct cxl_regs regs;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
@@ -757,9 +759,12 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 
 #ifdef CONFIG_PCIEAER_CXL
 void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
+void cxl_setup_parent_uport(struct device *host, struct cxl_port *port);
 #else
 static inline void cxl_setup_parent_dport(struct device *host,
 					  struct cxl_dport *dport) { }
+static inline void cxl_setup_parent_uport(struct device *host,
+					  struct cxl_port *port) { }
 #endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 0c79d9ce877c..51a4641fc9a6 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,10 +45,39 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
+static bool cxl_dev_is_pci_type(struct device *dev, u32 pcie_type)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
+		return false;
+
+	pdev = to_pci_dev(dev);
+	if (pci_pcie_type(pdev) != pcie_type)
+		return false;
+
+	return pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
+					 CXL_DVSEC_REG_LOCATOR);
+}
+
+static void cxl_setup_ep_parent_ports(struct cxl_ep *ep, struct device *host)
+{
+	struct cxl_dport *dport = ep->dport;
+
+	if (cxl_dev_is_pci_type(dport->dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
+	    cxl_dev_is_pci_type(dport->dport_dev, PCI_EXP_TYPE_ROOT_PORT))
+		cxl_setup_parent_dport(host, ep->dport);
+
+	if (cxl_dev_is_pci_type(dport->port->uport_dev, PCI_EXP_TYPE_UPSTREAM))
+		cxl_setup_parent_uport(host, ep->dport->port);
+}
+
 static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 				 struct cxl_dport *parent_dport)
 {
 	struct cxl_port *parent_port = parent_dport->port;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	struct cxl_port *endpoint, *iter, *down;
 	int rc;
 
@@ -62,6 +91,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 
 		ep = cxl_ep_load(iter, cxlmd);
 		ep->next = down;
+		cxl_setup_ep_parent_ports(ep, &pdev->dev);
 	}
 
 	/* Note: endpoint port component registers are derived from @cxlds */
@@ -157,8 +187,6 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
-	cxl_setup_parent_dport(dev, dport);
-
 	device_lock(endpoint_parent);
 	if (!endpoint_parent->driver) {
 		dev_err(dev, "CXL port topology %s not enabled\n",
-- 
2.34.1

