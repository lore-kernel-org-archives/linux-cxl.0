Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9886340;
	Wed,  5 Mar 2025 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169426; cv=fail; b=cBIncjEqUvzOMubRwMFoZBYUYOwnL1/eyomiObvI5hPegnnz9Nc76uIpMTHvMxS0uDVA9WPIfFFvuWdI1jM6BYoYAgPfYmuGSlnEh+k3/+kEUbFJtbqoTcxMkPShc0Zu7dPbX+fgdLDi6kNLhnpMcedO7YP2NMfSWlsCC8pa9MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169426; c=relaxed/simple;
	bh=kZa2bTD5/2ychuCQMvAXh2WQ9LMBLYRQs1WpED2dYSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NC1yBBPE/hvNTRbSlO3iG4GvkqbXtv0D+hhIEjIrX8y9W/TxgOwUfgvm+UQGAQJ81Wnc/emTD80+XzZT7r8hpec8xrnmaHXzvRHDWJ3xr5vUdHFjuq0XkfsZqP92GgQL7c6O801pB34KmK6thmcIEtP2ka4hK/WdTt8zNQyPJD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EXOSTPMJ; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EXOSTPMJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdCsrv4XRhKqMEgNtNiItR5q+oggg23hHDoyBhBQNC2pL5urjqnsgQ+O6ixdJ4Jhy6FP9MK0EahxGZkZF4GCBWhcf31rGndeilMSXW2UlM4EUcRvpiZXpdt4rRsvWn9+fgY9NFwjd2ZQC2V9Fw95HDUG9GOvvxv0MF5II2bDNklL5nBK4Yc/AZSm8/+Zeaj2hN4rpbAv3c9c379jk85Q9rEm1fsisYYAqngOq4DVYvZJQFw0GcZa/DCMI29qvaqCELvWLKt2OnESnJgIhZQmYPHH34InvKAAL7XsFb2NqlLDKpn00pIQ79Tse27m4ySb4yuZqKw3p/twqPHVjzqALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1dE34zEt+RhcO50/ixd3H+WEcPmR2qKGgyR5Mq3TyI=;
 b=rvcQ7vR9QlC3a+62rrJ31qZdSfVWXPXrYcnbSF546uc9yKIzHiWT5aIAJTRM442/KOj2pHcOzv7tlXu6AwmZDw4lUliqBi1HeddLhet/H30TERewLmAsE/rqbeWq2J4J8Y6l125FGt7BYsUvcs+OcIk123qv6AWNbCt3frCTk2Cicw6tBKgwutxRy/GBY/3eLY1+8banSIs+I3OyCdmbAlJ+x98XgVDoidFidbKy67MqHT+F8ylxTv/t/DpnFzCQMa78lCbngyN5OT42GxFrGyrKRAWUSGUD6kSAVa6daNZEp41PeNOmSS5tdhYVb2L/VLUkk1QnCLXAef4Uo4ZSJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1dE34zEt+RhcO50/ixd3H+WEcPmR2qKGgyR5Mq3TyI=;
 b=EXOSTPMJoa39mAqXiFNQFj1p33JIRut9K2fP6Aorhl2FsA9MOWh1Mbc+1S9M4anYQhfp7h6lfvfz9WKBNqhNtSRyF9HpQnwfPcLFWYBB5F3GYCV3wVV0y1FedFyjtNiWznXHuG18pz76XpX6tT2XsZwIhKXFWbBf70gkrf2PfA0=
Received: from BY3PR10CA0023.namprd10.prod.outlook.com (2603:10b6:a03:255::28)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 10:10:22 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::6f) by BY3PR10CA0023.outlook.office365.com
 (2603:10b6:a03:255::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 10:10:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 10:09:40 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 04:05:41 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, Terry Bowman <terry.bowman@amd.com>, Robert Richter
	<rrichter@amd.com>
Subject: [PATCH 2/2] cxl/pci: Check link status and only enable active dports
Date: Wed, 5 Mar 2025 11:01:23 +0100
Message-ID: <20250305100123.3077031-3-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305100123.3077031-1-rrichter@amd.com>
References: <20250305100123.3077031-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: a6140de5-e7d1-4c45-f1fa-08dd5bcdf065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?loiLopW81NpmNCffvE75p6EuLoicDyJv2ltT8+dz6AUirXI2B8PjgMD1Ahnu?=
 =?us-ascii?Q?Lm3rYTldireUzvK0UJzIvpXq+YnGz25/VVc6FszU0+0UuZtiZ0Ah+1BNCw7B?=
 =?us-ascii?Q?bmF63RsxD6UTtOa17HtqhXGRlZN490fQ0122kJyIGnAS+MStUqAvlkOlF7z6?=
 =?us-ascii?Q?cLxllKBLmDT3lrAB5O3ye0VqtFGhgiAF8oPKW/Sl4NzZVnPtPfQWQPK36o5l?=
 =?us-ascii?Q?RbcDod4dV6etCL8E9eVtXhO/LEBiU041L1NZuQw/KAYzyqLeQsM8KpkqX/k6?=
 =?us-ascii?Q?61/ALWqxr1U7SDKRXoxK+4RUb0L7FGYwX5iiVf7ERGgzUKCXob/ZyL9cHYOA?=
 =?us-ascii?Q?L+Tq4oPkjlfgkAUeNaqLJ/Kb4SGidsJllk78D+mW1uq3lBdNa5iK3wp/uC/Q?=
 =?us-ascii?Q?GdOmOlp54PILcSzhSAsUgn24ndrUIYKE0/jxtsWrey0UmD+s1jq26dpdoruc?=
 =?us-ascii?Q?rKL6ZTyj8Tr604UmKLTdiILMuIfPr/u1mqE9xN6f+yY3UjRHNN1mzMv822GZ?=
 =?us-ascii?Q?jl2wUSqdYv6a9M0thXdTl+veLlif7jlGgWxCSQJExisa8VnNLh9KG0iotYU+?=
 =?us-ascii?Q?BOtz8cNMe0NabSPv3JsBmKKevJx1UNBv8w2TVMTymeQS1Z5spIrZZ/r5Fy4N?=
 =?us-ascii?Q?ule81+9hj7jK6pL8bvujpz+8+GBe+DEvonriVpn5M1yQRquldjXH2dHDsYQb?=
 =?us-ascii?Q?I+rPAMf2SapMSl7nJS1P2PB1aYS3p/VaAiJ5Czfo5wPp2XNjQMwRr12NqYjR?=
 =?us-ascii?Q?Io55hynvCVk5v+b/2TOn1FDq7QAYFn/eXt6Db2tuk1iaGqm0ZGTm/nrze5Kc?=
 =?us-ascii?Q?K+RscgSlO31OkpkIFTPmm9VIQ0xzRLp4xCDhKUb2snRPqFlLwe+4ARkrfwUD?=
 =?us-ascii?Q?kj/n84jteO63rD+VbiBLqtnEUhm9ROjAtLWipHBXAgbI3hEnpQhM71oZgvp/?=
 =?us-ascii?Q?Z110vpQ32SFan5mIXm5lwPGfRTqSL28MVq48mrtkC1HhZy6tbg6uVNDoF2uY?=
 =?us-ascii?Q?lK1g8hG9X8iVuP1NxpzGae1hRX9ARtEHffj4ohl6PTNzWB8P1AjpCRsfo1j0?=
 =?us-ascii?Q?5AzdQqxbm6De7cpQkM/v0g4XNHagEwTDwlipRZAQ07fW3aRNfjYWqa4ruNj8?=
 =?us-ascii?Q?ZfkmWL3zMgjg5whMrNEFKNgk1YL4X/Fu+/eiYRCf1SS6CqL1sKxt0UcJkYBM?=
 =?us-ascii?Q?ssIuI2vK8prpUhjGpub80EOAkN6HFEIFT/BphTrwF+deJ5ycBmD1Cj4X8NcC?=
 =?us-ascii?Q?D5uHtfJImtbVIaOqUk/Pv2WjR9WjHN84HUIDaVoBnvCI8beHoJn98qK6E/FZ?=
 =?us-ascii?Q?Ggc7fLQVDQKGZ2Y+7ZjEuYTsgDxdAIyZfrWA9qzAvQVqC71uy3hgkpbmm0V1?=
 =?us-ascii?Q?fzKgZ0J50jQ24jpNcNSumtV/zonVo1vzOiYBIiv/cshEONCUzJmU2Bk5X3u/?=
 =?us-ascii?Q?loT2MPdIqB/05Galak3O1xqkxyHy5GPqLmFJKaLlSGTDZupj8QiNf95/vVPP?=
 =?us-ascii?Q?ppBcstUtSVjj2Fs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 10:09:40.7988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6140de5-e7d1-4c45-f1fa-08dd5bcdf065
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524

When downstream ports are enumerated, some of them may not be
connected to a corresponding endpoint or upstream switch port. The
dport is inactive and its link status is down then. For permanently
disabled ports a HwInit configuration mechanism (set by hardware or
firmware) may assign a (further unused) default port number. The port
number may be set to the same value accross other inactive links.
Those duplicate port numbers cause the downstream port enumeration to
fail including the root or switch port initialization
(cxl_switch_port_probe()) and all its active downstream ports.

Prevent a port initialization failure by checking the link status and
only enabling active dports. If a dport is inactive, there is no
matching component (endpoint or switch) connected to and thus, it must
not be enumerated and added to the kernel's CXL device hierarchy.
There is no device that will connect to an inactive dport.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 524b8749cc0b..72683e1b41e3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -32,6 +32,26 @@ struct cxl_walk_context {
 	int count;
 };
 
+static int get_port_num(struct pci_dev *pdev)
+{
+	u32 lnkcap, port_num;
+	u16 lnksta;
+
+	if (pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &lnkcap))
+		return -ENXIO;
+
+	/* Skip inactive links */
+	if (lnkcap & PCI_EXP_LNKCAP_DLLLARC) {
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
+		if (!(lnksta & PCI_EXP_LNKSTA_DLLLA))
+			return -ENOENT;
+	}
+
+	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
+
+	return port_num;
+}
+
 static int match_add_dports(struct pci_dev *pdev, void *data)
 {
 	struct cxl_walk_context *ctx = data;
@@ -39,7 +59,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 	int type = pci_pcie_type(pdev);
 	struct cxl_register_map map;
 	struct cxl_dport *dport;
-	u32 lnkcap, port_num;
+	int port_num;
 	int rc;
 
 	if (pdev->bus != ctx->bus)
@@ -48,15 +68,17 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 		return 0;
 	if (type != ctx->type)
 		return 0;
-	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
-				  &lnkcap))
+
+	port_num = get_port_num(pdev);
+	if (port_num == -ENOENT)
+		pci_dbg(pdev, "Skipping dport, link is down\n");
+	if (port_num < 0)
 		return 0;
 
 	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
 	if (rc)
 		dev_dbg(&port->dev, "failed to find component registers\n");
 
-	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
 	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
 	if (IS_ERR(dport)) {
 		rc = PTR_ERR(dport);
-- 
2.39.5

