Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A3C1990AB;
	Mon, 17 Jun 2024 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654748; cv=fail; b=aKBFkEbUN0sQ0WdUzu1zxVZt2+CF7VsNfGn9NqzuMkKnbPRk+0oVos79eLAxMKuzCornxKrGPB0CMvxmHlHbMXnFA4N83+gI9naLUE08Oc29Wnss6ImcyCGSBnPStgdXdQI9pDJV55Yl/WjGjNx2lubEqXPmml60DyAaEKzGTME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654748; c=relaxed/simple;
	bh=AQznya0ccgoWLuT4eXFlv4qzKbvV87kJv4Achwny0Vg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfB6o4sI/nXzoFlMfSHkSEazkmIFVVdJM4NEMAPlNDtZj2nyY0bOux/gCOmEWqr9QX3z3rqYC5wn3kvJOkCcdFDG1ZkkAcGaQdkN5+bETsYTsBgBY5sph0rNR4TkzIbESs1wffc6nVnNZbU4syueHyfPQouBT77n7oQN14k7GDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iu7CfVu5; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iu7CfVu5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQ0aeVh9KMCmJuInjI+7ctRakgIAtAY9rVx0LlcTIle63fCjm1VvJ8XSj+rVakGfcc46NdMDc5ZCsofCfC644zbBDxCqWznlS6IcTLT+mcx1hRB7Ph1ls1pGBt9b5O2rNLY5k+LzQZDlJHU/mxHG5kXOG5X7HEo/A1jt76isw4UbYwjqv+SDaQEXTkqf7JlNGGW/s5OFr6Yx6p0de+EXTpTOObM4+7Dk+VbuTgqP1qcFQ07ni2C+2J0FR+HMyTONcSKl9/zF0+mSBLSJu6OpLMiAJAe7HW9UKGKbEAEf9IC9G0MtMmIzFJRQbUi5xQiBkBlKMsHM16SjJjQXuLf5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HvJ/jRE1dq/SEfTEIhVL/EFl9NGIKorrAXaRQWcz0I=;
 b=Jb4NmccgKQZ6DstWxkeWF1dGLFqBycM1iTiZH1papRifDegVVZaDPkB77WxNM/65MxEwq033h+j3h6S6pYauDpE/uAnnYqAl/mIW7nZS9v4AN5e5u0Qcs8sNFKIhGjzr95TSpS9Y6sbttfcuzSnvz128ON55ZTl3Z4+lUyKGWIc6HEwrF9nurAF1J5OEmg/jn0SaFb7YZEJ/EQUAoAVal3VbLngozKFaR5ohb4JhpCFsNzKDkc1RArWnWRhxDCuRmIwBTz/ZKJ/rwmGCrm3COz6JKkR70yyWtP3Y3Of4O8o0jkaW7Yq5T5EDv1aFjCNbDXrbPf9LicGhgjcxpTfimw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HvJ/jRE1dq/SEfTEIhVL/EFl9NGIKorrAXaRQWcz0I=;
 b=iu7CfVu5ag8wCGeeNmEB0ble4T3mnuHTGzv7IeW/4To2Am6iZLRaycqjr0zauSYOQsMQ0IXGBT5vJUUl1PWguuYSZCZZYsnw3RhSPxpzP0FDqnTiuTdxHXoAv3O4KCFAIvilPeS2t5pUltqyECBuoEvM0vz6kDlJUgMoocV0YWo=
Received: from SJ0PR05CA0068.namprd05.prod.outlook.com (2603:10b6:a03:332::13)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:05:43 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::2f) by SJ0PR05CA0068.outlook.office365.com
 (2603:10b6:a03:332::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Mon, 17 Jun 2024 20:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 20:05:41 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 15:05:40 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <terry.bowman@amd.com>,
	<Yazen.Ghannam@amd.com>, <Robert.Richter@amd.com>
Subject: [RFC PATCH 7/9] cxl/pci: Add atomic notifier callback for CXL PCIe port AER internal errors
Date: Mon, 17 Jun 2024 15:04:09 -0500
Message-ID: <20240617200411.1426554-8-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e47d74f-2619-452a-e377-08dc8f08dd9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|376011|82310400023|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0SfnFi0MNvlF6WXy6A4u+nGNnCQsKzo7LSRINx/eD8geWVycy1MTsaaoJyyB?=
 =?us-ascii?Q?kCnAx41xFipe5fYlY9fzKVzNOXkigL62chO5ctkqZt4WQKal2+D9NHKeGviC?=
 =?us-ascii?Q?qxnDx99U+1Tl/saRFaEhP3CBEtUd587tnQcl463zC7+V3+isKxnyrd2ZmqcX?=
 =?us-ascii?Q?nbtRRmjw/p69ABtWpDaG+BTpDXXlbDbAorCVNHJMbL/lfgNxxvlCpMVAiyGi?=
 =?us-ascii?Q?vseNKjTHz6Ijsfv0/wCP0W9x6MUPI8+iAlVSXzNXEQJ16nlyQ0Pberv9ZzE0?=
 =?us-ascii?Q?ZvMl+f+7If3JihexWZ79i8zK94AXKofVFRsWEP+E/G2ch/qh8QAOlLh1mGrs?=
 =?us-ascii?Q?YPbOopmt2Kkwq1R+JURu/bfkuyq9WhkWV2ugrBgW6kZHB2MfjtQG8aBtcOTF?=
 =?us-ascii?Q?vpElUOQh9yEnwbQIo7pM0NkwMRo8IYJYa1s9jXZjjH+IBgBD3yy4Ks/i81Se?=
 =?us-ascii?Q?bmlWswl8jOyRbJ8hhrSdrNARI6aJipIpydImZb4uzKMaHIGhE6kytBZTDDko?=
 =?us-ascii?Q?nUrigUo6cug7NSvun/8//t2odCELVOmhaAhhTNaWlg/aadjePfK9MQ0Tg4e+?=
 =?us-ascii?Q?BfYbzVRWiNeR+ZEJxVq2zhK+dyw1IX9atcxNv6E6V9OH3QfxjxaBY2eNTiPE?=
 =?us-ascii?Q?xbjTVcLhjhW7TmOtoJUxjXM7LMfjJ+JMz+t0jysvjaC7I0NXpMxTwjLuD6a1?=
 =?us-ascii?Q?BbfEpwU65YNeabwqbPDgTrlZxs/Vf713D4mcdFAifOKHoZ1cisD0Ef5g5d9M?=
 =?us-ascii?Q?AgY59T6Q2k8FTJ4r8wLrr/tSXH8/5tvmn5GjCXpFMXH8pesdZzQ+ft0Zgw0U?=
 =?us-ascii?Q?m5QOCr3n1uXAUyw6qlrsr1ILLF9GpIEA2jUJUa2ZTTh3bFRCLTvO5KMXXP5l?=
 =?us-ascii?Q?XXI4QtWMeyLG586iwZGIgs2rPQjLiygyxkN9/FjxNDGETVIvmqMhnv2l1T5i?=
 =?us-ascii?Q?nh3tKGayXrn5jOaxwnlNcHSA0VbGZQMZhTB778al3BlaOIHlKmxdCqYqZItI?=
 =?us-ascii?Q?dQiJtFrdHnrzGKVrCLr0Kq22n4XoTlbqwiEbZ20kEIDaPgBeuHUeficyYd3z?=
 =?us-ascii?Q?oEICoi7HqkGFMR3yGjpOS8esPCeLrCZjC6KiV7me689oRdJO3J2sHmhTF1aH?=
 =?us-ascii?Q?CDGQ8a1zG74NpAXlDuCDgyKZbkG1riei4S5Sg4ofvW7+/NDJqE/wk6VeO9UJ?=
 =?us-ascii?Q?mLRIl0veAM8jnqpY9UqW16zA8FUm8xAHSu/BwKialeR3MzQ34AQkvfFwJL0e?=
 =?us-ascii?Q?p+PHbVyG1Y43rL2vH/6p2TGKGEGHowusIvVO0VZs1aHtnDbU1uVXHsFoxj94?=
 =?us-ascii?Q?ba7N8rmq3Yca5ZdF7JCJiTXQvuOnAFFO1IdR2hSfqz87GrcSv3XBCMnlvZQ1?=
 =?us-ascii?Q?9uB7WgXwFmh5A3R6+JlSFFj++EGrD74iGmrwdzZSVPtR4npVJyefob5WFYpw?=
 =?us-ascii?Q?Zq39SskO9EI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(82310400023)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:05:41.8229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e47d74f-2619-452a-e377-08dc8f08dd9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234

CXL root ports, CXL downstream switch ports, and CXL upstream switch
ports are bound to the PCIe port bus driver, portdrv. portdrv provides
an atomic notifier chain for reporting PCIe port device AER
correctable internal errors (CIE) and AER uncorrectable internal
errors (UIE).

CXL PCIe port devices use AER CIE/UIE to report CXL RAS.[1]

Add a cxl_pci atomic notification callback for handling the portdrv's
AER UIE/CIE notifications.

Register the atomic notification callback in the cxl_pci module's
load. Unregister the callback in the cxl_pci driver's unload.

Implement the callback to check if the device parameter is a valid
CXL PCIe port. If it is valid then make the notification callback call
__cxl_handle_cor_ras() or __cxl_handle_ras() depending on the AER
type.

[1] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
             Upstream Switch Ports

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/core.h |  4 ++
 drivers/cxl/core/pci.c  | 97 ++++++++++++++++++++++++++++++++++++++---
 drivers/cxl/core/port.c |  6 +--
 drivers/cxl/cxl.h       |  5 +++
 drivers/cxl/cxlpci.h    |  2 +
 drivers/cxl/pci.c       | 19 +++++++-
 6 files changed, 123 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index bc5a95665aa0..69bef1db6ee0 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -94,4 +94,8 @@ int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
 				       enum access_coordinate_class access);
 bool cxl_need_node_perf_attrs_update(int nid);
 
+struct cxl_dport *find_dport(struct cxl_port *port, int id);
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport);
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 59a317ab84bb..e630eccb733d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -689,7 +689,6 @@ EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 static void __cxl_handle_cor_ras(struct device *dev,
 				 void __iomem *ras_base)
 {
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	void __iomem *addr;
 	u32 status;
 
@@ -698,10 +697,17 @@ static void __cxl_handle_cor_ras(struct device *dev,
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
-		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+
+	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
+		return;
+
+	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+	if (is_cxl_memdev(dev)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+
 		trace_cxl_aer_correctable_error(cxlmd, status);
-	}
+	} else if (dev_is_pci(dev))
+		trace_cxl_port_aer_correctable_error(dev, status);
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
@@ -733,7 +739,6 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
 static bool __cxl_handle_ras(struct device *dev,
 			     void __iomem *ras_base)
 {
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
 	u32 status;
@@ -759,7 +764,13 @@ static bool __cxl_handle_ras(struct device *dev,
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
+	if (is_cxl_memdev(dev)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+
+		trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
+	} else if (dev_is_pci(dev))
+		trace_cxl_port_aer_uncorrectable_error(dev, status);
+
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -882,6 +893,80 @@ static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 }
 
+static int match_uport(struct device *dev, void *data)
+{
+	struct device *uport_dev = (struct device *)data;
+	struct cxl_port *port;
+
+	if (!is_cxl_port(dev))
+		return 0;
+
+	port = to_cxl_port(dev);
+
+	return (port->uport_dev == uport_dev);
+}
+
+static struct cxl_port *pci_to_cxl_uport(struct pci_dev *pdev)
+{
+	struct cxl_dport *dport;
+	struct device *port_dev;
+	struct cxl_port *port;
+
+	port = find_cxl_port(pdev->dev.parent, &dport);
+	if (!port)
+		return NULL;
+	put_device(&port->dev);
+
+	port_dev = device_find_child(&port->dev, &pdev->dev, match_uport);
+	if (!port_dev)
+		return NULL;
+	put_device(port_dev);
+
+	port = to_cxl_port(port_dev);
+
+	return port;
+}
+
+static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
+{
+	void __iomem *ras_base = NULL;
+
+	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
+	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
+		struct cxl_dport *dport;
+
+		find_cxl_port(&pdev->dev, &dport);
+		ras_base = dport ? dport->regs.ras : NULL;
+	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
+		struct cxl_port *port = pci_to_cxl_uport(pdev);
+
+		ras_base = port ? port->regs.ras : NULL;
+	}
+
+	return ras_base;
+}
+
+int port_internal_err_cb(struct notifier_block *unused,
+			 unsigned long event, void *ptr)
+{
+	struct pci_dev *pdev = (struct pci_dev *)ptr;
+	void __iomem *ras_base;
+
+	if (!pdev)
+		return 0;
+
+	if (event == AER_CORRECTABLE) {
+		ras_base = cxl_pci_port_ras(pdev);
+		__cxl_handle_cor_ras(&pdev->dev, ras_base);
+	} else if ((event == AER_FATAL) || (event == AER_NONFATAL)) {
+		ras_base = cxl_pci_port_ras(pdev);
+		__cxl_handle_ras(&pdev->dev, ras_base);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(port_internal_err_cb, CXL);
+
 /*
  * Copy the AER capability registers using 32 bit read accesses.
  * This is necessary because RCRB AER capability is MMIO mapped. Clear the
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 887ed6e358fb..d0f95c965ab4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1027,7 +1027,7 @@ void put_cxl_root(struct cxl_root *cxl_root)
 }
 EXPORT_SYMBOL_NS_GPL(put_cxl_root, CXL);
 
-static struct cxl_dport *find_dport(struct cxl_port *port, int id)
+struct cxl_dport *find_dport(struct cxl_port *port, int id)
 {
 	struct cxl_dport *dport;
 	unsigned long index;
@@ -1336,8 +1336,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7cee678fdb75..04725344393b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -11,6 +11,7 @@
 #include <linux/log2.h>
 #include <linux/node.h>
 #include <linux/io.h>
+#include "../pci/pcie/portdrv.h"
 
 /**
  * DOC: cxl objects
@@ -760,11 +761,15 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 #ifdef CONFIG_PCIEAER_CXL
 void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
 void cxl_setup_parent_uport(struct device *host, struct cxl_port *port);
+int port_internal_err_cb(struct notifier_block *unused,
+			 unsigned long event, void *ptr);
 #else
 static inline void cxl_setup_parent_dport(struct device *host,
 					  struct cxl_dport *dport) { }
 static inline void cxl_setup_parent_uport(struct device *host,
 					  struct cxl_port *port) { }
+static inline int port_internal_err_cb(struct notifier_block *unused,
+				unsigned long event, void *ptr) { return 0; }
 #endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 93992a1c8eec..6044955e1c48 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -130,4 +130,6 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+int port_err_nb_cb(struct notifier_block *unused,
+		   unsigned long event, void *ptr);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..f4183c5aea38 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -926,6 +926,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return rc;
 }
 
+struct notifier_block port_internal_err_nb = {
+	.notifier_call = port_internal_err_cb,
+};
+
 static const struct pci_device_id cxl_mem_pci_tbl[] = {
 	/* PCI class code for CXL.mem Type-3 Devices */
 	{ PCI_DEVICE_CLASS((PCI_CLASS_MEMORY_CXL << 8 | CXL_MEMORY_PROGIF), ~0)},
@@ -974,6 +978,19 @@ static struct pci_driver cxl_pci_driver = {
 	},
 };
 
-module_pci_driver(cxl_pci_driver);
+static int __init cxl_pci_init(void)
+{
+	atomic_notifier_chain_register(&portdrv_aer_internal_err_chain, &port_internal_err_nb);
+	return pci_register_driver(&cxl_pci_driver);
+}
+module_init(cxl_pci_init);
+
+static void __exit cxl_pci_exit(void)
+{
+	atomic_notifier_chain_unregister(&portdrv_aer_internal_err_chain, &port_internal_err_nb);
+	pci_unregister_driver(&cxl_pci_driver);
+}
+module_exit(cxl_pci_exit);
+
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
-- 
2.34.1

