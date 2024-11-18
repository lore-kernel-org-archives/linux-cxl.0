Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F1F199EA3
	for <linux-cxl@vger.kernel.org>; Mon, 18 Nov 2024 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947575; cv=fail; b=bGyz6/NGFqFazgGAN22xvhB4l/iLF78mIeSM6bh3N327AxzcCSsHUqIlsynXdsigeedJQuCL+p76xh1fa5ml7yer8BypbkLWAkLNOBvlDGAuk4Xm7GZwPD+UmZvVgDUtO/mYWBqM+X3erf93ViDr3BlxEFe+vMaOKkQ0WViD0OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947575; c=relaxed/simple;
	bh=/+jEDrUMCZKHgV+VJivsiCGlyDhQTbiQ0+wqTy3qSgU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jDI0BNn6o6MdG1HtLzXgv4FOZoWhODvcGemaIdYPcyzgogZKV5TyVdZ/OpMuGlOeeeOXJWMWGp/8bZd/XMXtqIJYKPrHO5KrJdvjZondDKP4Lfl1vv5RARjRXqvdBLgYwYTJtnLipj7nj70juzCZWnKtRvKtY48RzBLBfNhofik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UhpHbky+; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UhpHbky+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2ZEAajg02Gke3cmq9Kx4OwVbZTES7uHHHnqoG/Ptk2GZvRND0xvbp/+a+GG8jDW1TD0Eh7lcN33G7tP44rsVeoxVz8RCWNTav9ZGoq+i4OVP6/zd1eYx2IIXkx80QWyx3BHD0q6JoR2XIe6xYLkEH20AYFnLhq96E0EraR9m/CqmzHjjoxkBE5NwK7s6+e74u1ZiN1dx6XBt3tlul+Y4R4WASOvwbCiztNfTORw7ZCeSCb8MltVVAl14VkH4OcP/uymBPOrogbG1Zv5fO9lS5jkM0act3Q5hSUhvOxUuVMNwTHaZAq8PQyZVsKlIte4qwDEtEvOz9jhmy8l3lthxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWAPpfQyUk4MYcF36jVCDsC6Sbr0e8zoBDhd7FjqaT8=;
 b=UlPNmHESsFGrJBe05kDHpO+RA6+qDOvyNc6JqxLx3RiMgJqnbOQ4VBoad586XCMYXa71et2V6c66oRe8eDIH6AhIMD4LisxVrN91JVkUu4Z8eU7W+Whia+vQdKLTBXFBKJS6AhkOJzSXsbwPqsRCqsbFzPnfH0MGm4qMpoD2QQBXmkGHk/KkWEYcasUudJr2zDlV2mu+eyf6SW1YD6xwax+3/0/wznfkvoOzaHyTG+K2T/OjxxnCOa2uj0umEmsy8/kmNl9xXtB/4FcwGTmv9sRbmKceRhGL79JJM+Fh42wzVjAn/jp4y8j0vLMbtsewkJjhW+YxfaXvpnEubKXf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWAPpfQyUk4MYcF36jVCDsC6Sbr0e8zoBDhd7FjqaT8=;
 b=UhpHbky+XdWU07d8BZtsi9X4j3zuwatH2wWMRTTCwfBLu/8svCZGrJ08ceBEdGwrxbhHDeMnDS5jJO8XOHaDnkWjyAEx86wcp1x23KTMyaas4JSF3fKNkAXWER30mn/ufX2KtIn9+vxL+aBK2zqMnQeMT4KO6WxfTyzK+vJc93M=
Received: from MW3PR06CA0012.namprd06.prod.outlook.com (2603:10b6:303:2a::17)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:32:49 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::bb) by MW3PR06CA0012.outlook.office365.com
 (2603:10b6:303:2a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21 via Frontend
 Transport; Mon, 18 Nov 2024 16:32:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:32:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:32:47 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:32:47 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:32:46 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
CC: Alejandro Lucero <alejandro.lucero-palau@amd.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: [PATCH v2] cxl: avoid driver data for obtaining cxl_dev_state reference
Date: Mon, 18 Nov 2024 16:32:38 +0000
Message-ID: <20241118163238.6723-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f25ba83-f1b0-4eff-41a6-08dd07eea3db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k7B97UoVXNzzFDvMGF51Erbi5fIt6zp2+8EOqujADPJZEsiq5enn6xRbQ3Jy?=
 =?us-ascii?Q?L75y+hRSr21Dul11OqJcAzmqO5uVBjTmZ2FF0MiVGPyFvc24dXdSMMutuMmD?=
 =?us-ascii?Q?FnYRrK/r3XBZct04mKyKlDknRl5fdFFS8kEjOX4F/U7o8aotYdCx6/PycVfL?=
 =?us-ascii?Q?dcBeMm35YHSb5uQfAlz7IEOQeuqvK0a5VA4FeWaC5jUXYjFkOWxQDv6LUjwc?=
 =?us-ascii?Q?MKxWDHH//8kaJWPblWeOV2aFRoCkGcLlmCYTlT8udu4OPseUH+Hr94+jpzjd?=
 =?us-ascii?Q?kVWnbMH6eQaudzU7BdkXvZ/j0AtYBuYupBlGYKZO0242JoUrd2wCfMf03JAA?=
 =?us-ascii?Q?IHVqEooHNDV8wPdKn5dcJSJB5cGZkoILjzeZlDUbKG0eokDSzKvboAGLp8eC?=
 =?us-ascii?Q?yrBH8sTPfm2Qveja0ijl+AmGMkyot9JDMrPhJRbiExCDT6B0rJhyKLLHpiDx?=
 =?us-ascii?Q?XhVL6lbr/ZUCi+ZhirqR0FRPsLOPTFnUaoN/9/fYxKWII+YX/70vGfu0kBvc?=
 =?us-ascii?Q?/G+txcPrEt4XWhRVL37BZuoPqJL+zhZiO8beKRXu9CQcEUb3OEhfrh8O8LqT?=
 =?us-ascii?Q?18fbryopzez9a8P3NJgMnA5RzRhChbpgYEW7drbW1FXyYKMwFy1ZfDZvQoF1?=
 =?us-ascii?Q?9u9VnPi1Eg6ddofb/mzWeEBjl3I+OOv9JBqRI4jjRKFd3u+vMmn/vJUL/osV?=
 =?us-ascii?Q?GzGoIjaHFAaonVULdAPhQwRrQliIgDtXDJn2xQHFHqNTXSOid88yPRK97fqh?=
 =?us-ascii?Q?SbA6X/UfbWgid9gjhoODWfjlIsuNWjwV/F/0DDAAbRNrS8sQK7x1EilU20aM?=
 =?us-ascii?Q?JLGYqvLhFD1QZw5ryd6bZmeDyclwZ0c8Wo9Rv5IUuMSpWQn794N/tnCy6gRI?=
 =?us-ascii?Q?wVrINuXf5JCCd8reCo6V5DRJZVymSLFXpKiYWWSZ/rDo/OysLv1EUk3lGkaK?=
 =?us-ascii?Q?5Uf5nK8N5a2w8PfXMG4EDquheFN4RJwp2ZXIjhR3Pu+M94AsqQrF/R1fQ7sW?=
 =?us-ascii?Q?74VouiQAmMpZcUfAm+G3pYYmdt9eEK80PxVVstVRulkAykY7vNlDBwF7RaIH?=
 =?us-ascii?Q?11u3qA++wSlhy5Oo9TeuZYubDO4cYA2PGi7ElC4Mlngby2KMLHaVrDQx6not?=
 =?us-ascii?Q?XLadGwXwV2bWBKRrMADNYhHlyKLhP9VmjdKCiioVoW5Bx/WjWbmrUOxMGeSE?=
 =?us-ascii?Q?YjZ1U/iqZWu5y0SgJff5k+pj5LsP8rCh49+khqLAIT+eCdRDcp7DYEZCQGyX?=
 =?us-ascii?Q?2IDdiybjatbZc0wwKChaf1mk1hV10ZQXOfNt5uqzxQMNNS1dgthJcOQeogyS?=
 =?us-ascii?Q?K0EXPrcKhFHe5ob5+XFNUVagR+h9n0eUb2k9/6ZTEejLrkYafwdIR/9R2Rhf?=
 =?us-ascii?Q?EjAbYKuIYCq8YWSCqFOAUazg8+EVRQ0Sv+ZFCAPtFO0Px/zIgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:32:48.7582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f25ba83-f1b0-4eff-41a6-08dd07eea3db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376

From: Alejandro Lucero <alejandro.lucero-palau@amd.com>

CXL Type3 pci driver uses struct device driver_data for keeping
cxl_dev_state reference. Type1/2 drivers are not only about CXL so
this field should not be used when code requires cxl_dev_state to
work with and such a code used for Type2 support.

Change cxl_dvsec_rr_decode for passing cxl_dev_state as a parameter.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c        | 6 +++---
 drivers/cxl/cxl.h             | 4 +++-
 drivers/cxl/port.c            | 2 +-
 tools/testing/cxl/test/mock.c | 6 +++---
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5b46bc46aaa9..420e4be85a1f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -291,11 +291,11 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
 	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
 }
 
-int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
+int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			struct cxl_endpoint_dvsec_info *info)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct device *dev = cxlds->dev;
 	int hdm_count, rc, i, ranges = 0;
 	int d = cxlds->cxl_dvsec;
 	u16 cap, ctrl;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5406e3ab3d4a..a2be05fd7aa2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -812,7 +812,9 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
-int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
+struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
+struct cxl_dev_state;
+int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			struct cxl_endpoint_dvsec_info *info);
 
 bool is_cxl_region(struct device *dev);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 9dc394295e1f..acf2ac70f343 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -98,7 +98,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_port *root;
 	int rc;
 
-	rc = cxl_dvsec_rr_decode(cxlds->dev, port, &info);
+	rc = cxl_dvsec_rr_decode(cxlds, &info);
 	if (rc < 0)
 		return rc;
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index f4ce96cc11d4..4f82716cfc16 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -228,16 +228,16 @@ int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
 
-int __wrap_cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
+int __wrap_cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			       struct cxl_endpoint_dvsec_info *info)
 {
 	int rc = 0, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
-	if (ops && ops->is_mock_dev(dev))
+	if (ops && ops->is_mock_dev(cxlds->dev))
 		rc = 0;
 	else
-		rc = cxl_dvsec_rr_decode(dev, port, info);
+		rc = cxl_dvsec_rr_decode(cxlds, info);
 	put_cxl_mock_ops(index);
 
 	return rc;
-- 
2.17.1

