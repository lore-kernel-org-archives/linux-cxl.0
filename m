Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2FC254B09;
	Thu,  6 Mar 2025 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279522; cv=fail; b=uSkvhQAaK8V7V98WYW1U/9dwyB7z+2PPamiziHea1GMtIM6be3GaRBDWJC74CtTZ1XCbEXIzqNDklGtOMru5ftDma66dpqxYtKTgs55UD/3JjjM5o1ob6eE//aBLUfpsln+kMfzBXgJgK6H/X9eLk5mG9kdp+uteBginx54fwHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279522; c=relaxed/simple;
	bh=DHDfqNB+ueU4t8taHsrHcDJZ69Xm3Vg9ZmfOh0q8aZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGyD3VMuFmI3qUiWe+tE9RZJSTiXlEQ9iI/B0g3VduN+ILtlrM/3ThYzeosht2pQNRP5cOosovyCqDp7uX3WyqFCdZdUwArcUal6Ec8Y2czZ2RBX6uZzOepKVJnHHkPyXxQm8HqhIc2GfpTCfORFTN6XW2O6fX6XWm7Kq8e/7VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OX2trJji; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OX2trJji"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAhyhbfhng9kalZZwy+AuavW+o0tAkBA/lBjE5LKDhJnRr/MQNdS5iBgask0o28+FyAzqk9NmNCAQqxx/AxKywqx8wHH7nOxzqWpQfxY+95QGVAAubJ2axUay6e/4anL8lzx182UwpJN4i738Pw/v9NsW8IVjUE+YbD2vWsmfBwPswDy2abvh+vRo3lmpwwpd9ixce+0xLLlBYOcLsLRQNzBKmHQTFhDmCsiBx/c1tEa+rEOvT2EUoOaEVWN97zGHuU0DU5u4Fq0T5d+e5uj/kaiFPbXf1Bo/M0w7OYvO1ALAH3ROqwwd2UgbgKGfqnxf70YyP7y/YDVpLImrERDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KnRjPysUG12TBtDUoNxCjBv9lA7sofyfs+XDoqF4PM=;
 b=lIvdlvrij5AdIV5BweHMSENW08Ngzy3DiYZuaWyrSzWDXjoYcEjjbvA3ENcsaRfjWKUahNQujfyAXk0IFXJjBFy448mkq8kvhPcvEtI45Gf8AspLnCyMRgjw3n3122i7j63uV2EOBR+7cwfPdfvTQxa4CeLW35WSdRCMm4BAQ9lfFpgMpiGAGRWFEEqfMrqcUIRtUAniHli3YTxUMOnabSZeTGq8qvOzdq4o0QN212Mo+5kLJpk4Uwnc49ENTwjwBm8mOcJ30AJFErRHhhPPR8MZhVvKMvpAsVPD63N4h4ax4VqyCePS9NGaFoB5jJSBOChHVhXTgOKp13ki63yNyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KnRjPysUG12TBtDUoNxCjBv9lA7sofyfs+XDoqF4PM=;
 b=OX2trJjiqLkNRZCzQSi/ozQNCUa+6x3sEjfDBNQwjRCAKAULNfS62FKCHb1twZZb/SDWdG99x5bCX0eh8JXWBV9P4J+IaSAanN7PUmaauBN7aJLF+HOuUEvWmFpaFewPcCa942Uy0hgSLRHBRAOmx7TTryjPF3/ZRv66TUzUAdI=
Received: from MW4PR04CA0119.namprd04.prod.outlook.com (2603:10b6:303:83::34)
 by SJ2PR12MB8651.namprd12.prod.outlook.com (2603:10b6:a03:541::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 16:45:14 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::b3) by MW4PR04CA0119.outlook.office365.com
 (2603:10b6:303:83::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 16:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 16:45:14 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 10:45:10 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 02/14] cxl/pci: Moving code in cxl_hdm_decode_init()
Date: Thu, 6 Mar 2025 17:44:36 +0100
Message-ID: <20250306164448.3354845-3-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306164448.3354845-1-rrichter@amd.com>
References: <20250306164448.3354845-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SJ2PR12MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: 5283d1c6-544a-4ca7-ded3-08dd5cce44d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9nBAu22wyWbVXOcTSiP/hbdzzAc9AiwxV5MLBiYrNY25J1HdGTzamrjOZJ39?=
 =?us-ascii?Q?e4gZeu7fMoiOQhXZ1t/p2osmrY6tu3iOxybT0K2LSDB4VI2r4ezFv6khp0SY?=
 =?us-ascii?Q?42N8hRvrWNfsyb0ufSpsEqKFZgq1KKJ5gPuiED0z0ODf0Wbo+O1MI5oQrFWx?=
 =?us-ascii?Q?ktaxuTM5SjszEHjoQKKiCYeEM3hIU/Lexh0X0wFtwJX+17Mia5cWNnXibh1c?=
 =?us-ascii?Q?sXT7LzfZgXqc2fqsXX9M108e0FVpnRKzTCezjYTjyrgugaaKgcc2/vYFjG70?=
 =?us-ascii?Q?TsjBZB2Wz22UyNo7yLUb2OUqcRfdIBU//10x05Xzrw3bUgByK8EDfn24MQDZ?=
 =?us-ascii?Q?ODbWnuBoJJXE66wOjvEN+MdtMutf3Cb7CjQy05q76P3sAufk5IcYDRtCNbWN?=
 =?us-ascii?Q?vHsMLbOPTmVJHRdqIfGF4asCm/0AznlpNtcfQwcrYH+Jjh8BAYgcyJBb/4ki?=
 =?us-ascii?Q?wvSqqfA7IEu89aOdVvbLcD2brdEBuExU2jbSK0nr7knmhPFVN4l43ptSp+/d?=
 =?us-ascii?Q?HFtJlB8CV7cELYgicNW2Wjzw4e4WqBFgL87b3ebJ8FYgXQeAqv+BWkgdTbE6?=
 =?us-ascii?Q?FDeUjAImfCK5P6iIEFZK3NbrPo7jrv+7VytfRVQgAL230g8MXZDsNiGy1fRg?=
 =?us-ascii?Q?MPLy7veLiGqsdN86Dj79q5mQI5ny1ffCMCDwsTZQBMh9uIkMmW04Q/VC8BV3?=
 =?us-ascii?Q?QcpJJnoTRpLPAQgfjdDRNQkZGK3TAgPawfPoc6QTiNYnKL0DmqEazeniyB+Y?=
 =?us-ascii?Q?iVf+gfCWhLK59U205yjoqWkmQYvEUwg8vrisnxEc7lAowbBDrHvQgQoqjggX?=
 =?us-ascii?Q?7hiBDrEg3E18x30Bxn60YACzSsvGu4/NA6C5Hy+FWmHqXyoFa1O3ZjDPDzvc?=
 =?us-ascii?Q?bLk2oE5Q12XjSh/stbTMmlYF6gVfTVE3tz4t05MQrb+iafhicBO7dYdTGX3h?=
 =?us-ascii?Q?QJTmoieWXb5nk0A7xqXhof64+bQ1fwFkQvqzeXXfz4WCaMnBzGMD+ch20OhO?=
 =?us-ascii?Q?i4uGj7/7ip712z3JVhlz7yFCnYy1vgBWgbJqEiP6cGnio78QQ7vzB5HIjP3X?=
 =?us-ascii?Q?k1V10+0h24mO0RKIs5AtAmyiLMwduShuhXRnzxhIeGyikOzv96Rs28uFFcZL?=
 =?us-ascii?Q?12eprTksP7DkjNd84QREn2pTvAnNJ00gB90o+6t1nc7Id1XCgI+7PhaRlFJ6?=
 =?us-ascii?Q?KmxDBwzGCwrpBOVLe62TPo9nmwnV7KMR2nN+UzbEku+GelqX4Tcf1SU4sgpO?=
 =?us-ascii?Q?Sg5OHbEY2N9AMEod+uwCyh505QOftcVrVjvcRzYyihD4BxhDB36Fj1gc2z8W?=
 =?us-ascii?Q?ZpZdq0GUPUG/dco0MghmwgnDvCjr1caewJrX7mzmUTEPzvPUA/ZIeb/mnEqY?=
 =?us-ascii?Q?6LLi9G8fnzMPSvx5QVHQAomUevOMRghJd0lkYXC7xpnzQ0FNCwEOOsU3cm++?=
 =?us-ascii?Q?4aYKY18zF6LBKvq0o0LSHoA/8XcykIfcmv4FtRa02v7VCW/dZCNtmlu9H0q5?=
 =?us-ascii?Q?SBfaRQXd/lLFUjg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:45:14.2932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5283d1c6-544a-4ca7-ded3-08dd5cce44d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8651

Commit 3f9e07531778 ("cxl/pci: simplify the check of mem_enabled in
cxl_hdm_decode_init()") changed the code flow in this function. The
root port is determined before a check to leave the function. Since
the root port is not used by the check it can be moved to run the
check first. This improves code readability and avoids unnesessary
code execution.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/pci.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 33c3bdd35b24..6386e84e51a4 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -419,14 +419,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (!hdm)
 		return -ENODEV;
 
-	root = to_cxl_port(port->dev.parent);
-	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
-		root = to_cxl_port(root->dev.parent);
-	if (!is_cxl_root(root)) {
-		dev_err(dev, "Failed to acquire root port for HDM enable\n");
-		return -ENODEV;
-	}
-
 	if (!info->mem_enabled) {
 		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
 		if (rc)
@@ -435,6 +427,14 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		return devm_cxl_enable_mem(&port->dev, cxlds);
 	}
 
+	root = to_cxl_port(port->dev.parent);
+	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
+		root = to_cxl_port(root->dev.parent);
+	if (!is_cxl_root(root)) {
+		dev_err(dev, "Failed to acquire root port for HDM enable\n");
+		return -ENODEV;
+	}
+
 	for (i = 0, allowed = 0; i < info->ranges; i++) {
 		struct device *cxld_dev;
 
-- 
2.39.5

