Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B623F274;
	Fri,  7 Feb 2025 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942709; cv=fail; b=ncvpqZRNL2JY4RKQnZ4Ifj/x9hned4DquNM7tCMzE4hmtcSQ5RVC9GKg0Wh70YPaYBALSIxh1HnsGvgZNkGHKs1eyCLPF5nyLrH+eWhIrPLPZgX7ZlCcayEFvNnxxxAZccXIsFv6ekWQcxkILRM5TE76Y6aNr/qk1fi6byCVtFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942709; c=relaxed/simple;
	bh=HctftZt4phy7RUzNlo1oU4o6ZQu3T/CIKChVYDFPCmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyZQ2u3JtMLPJUM4Ic1m2xgm8TnphShynNrTeaykqWr2Bo5Vy2TFoWKQWlCRE2dLA/dEhm6PI5NUMN0DWJOwaN1+JVWCxE+8n9ybo9I+A5r/mJbTSmQz31zCjPXJpRrkNacf0z8ii2u67FKEgjlYbLZ72D19ydelxgMsvb2GcDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2n5lU/Ct; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2n5lU/Ct"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lO7UQWx1+DbVGj4WiesXDdpJqnKZ/pyi0kY+SsmkyjODee+ofntMKCCOs7xe7avI+Pnm2zNDIYxQOV8imebW6hykRQ+DnLzMSGh0ZYh+CCy9xo7BLEtr5KyVh298rlyvHHh47EE1hM4/RkQbpb0voIRC5gNidxuxKFo3zi6alRB5/wzjAGH9S6U1nl/KxGYbtS+5Sw0dv3ZxyOIn5k9w4kWYNVy1cANGFxDr8IqH/rCTCXQbpVuzmuQnQ4yt1Bxo2uAfrCweU9ABDIFl1kK43CK1VgQx4aSeRoNAcIkzJ0FwWSvVo0HaG1SjSTTPpIdKQCv7tzTJe2DhiQTDoTFf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4x3CtQeGmNhfdTPpXJrjEjEEfXMXIeR5dDfwrkRAyU=;
 b=opO6ePSsX7OG67Ss/edG4zj+IM4ZtX1nY3ufylp5/VRxuHwhj42HbAkSmaBKN2MLfudkae3b4zTAPpdcHwfj/Qtl/LJ8PjFMxj7bgJAbw6blZolOUUJ3QdmcgPUtNnldLbujXBvZaOufn+hXVKYwZneRy6hgS3I0S1Uj3I0byovfdKKTyTlGJUPwEf3QSpyg/TXX4CwdLL+8LWkX34fP+govT9nLTBMtY+6GQrKaqD4De41SbsD6TUMQegGm0QJHaeWs6Itqr1e44/wYOzzpzfxY3K6tSOwRaxKiaT9ldebhJ1aj6fFtWEbsCMQlAaRwiSnuRaZtO1GrYv+3ayS+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4x3CtQeGmNhfdTPpXJrjEjEEfXMXIeR5dDfwrkRAyU=;
 b=2n5lU/CtFJ8BgZ2vjI+sMLl89a4Q9nJi2G3RNNSTLGOjTaiAeTETZOV+u93zTtc0xHInPR+CfWtazby2hovhqlMH9W9QJpr6URIWFLO8ouvAx48JribScdZL/WpL9euZVPGbaNCXLbCPq00sCZnrVC1GJ2p3LiOvQQAbeHszQ60=
Received: from MW4PR04CA0322.namprd04.prod.outlook.com (2603:10b6:303:82::27)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 15:38:23 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::1d) by MW4PR04CA0322.outlook.office365.com
 (2603:10b6:303:82::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 15:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:38:23 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:38:20 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 02/18] cxl/pci: Moving code in cxl_hdm_decode_init()
Date: Fri, 7 Feb 2025 16:37:37 +0100
Message-ID: <20250207153753.418849-3-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153753.418849-1-rrichter@amd.com>
References: <20250207153753.418849-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: b07bc2cf-550c-48f7-916d-08dd478d74f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tMoOVDYKsB2GOg5fSgJ6G0z/6LrHm0C7yY+gJrGbKBIgxLnkn3dmp0VdEW4M?=
 =?us-ascii?Q?wIbsWzS2jnvTaY5SPCB0Hls2AYZEW0EnMAVI/CscLMkJfzu1xKmYZZTgoLvR?=
 =?us-ascii?Q?hm0P6bWtwPEtyaL/XeerNxZtcFXqWgshd2VbAh+r3+Ijhu3OdYZ8PtzHhqSr?=
 =?us-ascii?Q?i/mlkjqY8CdM+UbKWQ30tu1yPjPTS4anxOgyThDkSrayJSdLtouj19IShoKN?=
 =?us-ascii?Q?yd6brv/7u6QGiL15nTZf9s8cZq7iWEbgiIWOSBKgRUc4PbfrS0QAldqKHF5c?=
 =?us-ascii?Q?55vLLBtHPrQSdnrGjM4Trsd4WbkNdFP+KIjjev2sMZnOTcEOHBTicOcXnE9P?=
 =?us-ascii?Q?AJRGOZX8qtwhUbndlg5KKs4tst+OkqSVlV/8ktvNKmYkshFxBJ7NS3Hbl982?=
 =?us-ascii?Q?UXYj7n5/m08Fgsn02kaAPd5s23sXBYBzyHXB0gn2Y+BYxd4aRJlqTm8pZ3WE?=
 =?us-ascii?Q?lDEJFW94Z+3ZeV8r2VM0w02FhVgzPnKbiWfLtkzeen/b4daBtRGESd9JJlIc?=
 =?us-ascii?Q?PyT/IzM33VUF41eG5X88XNEfM0VHn3FaQg7JRSj/Ylp8usSpwpAWeMlqcVwq?=
 =?us-ascii?Q?6hxJt79Jnd9cH/xOnX7jtKusH1M6GwIPmlFhYAVoboIUCRCVLavC2QzfdIO6?=
 =?us-ascii?Q?Id8NqvM+IJ6NCC2D2M2IV44OHcMAO45bH/p4EZCocMW5pwBak0oIHCVOXbkt?=
 =?us-ascii?Q?6qcGgUqwXt4qA+ZSj3EEvRBaOW4tl7Gixm5n2MTWWxvAPQXLDWVGeaOJNEjJ?=
 =?us-ascii?Q?IH5SqmLS+fsJEUYsrxIrXXJjIUGhq7uFTUZRn0wLMD3sYnDGy3DqMxVriSDu?=
 =?us-ascii?Q?reFqvfC5GW/EkGPIEDrNAkX+DLsVjva/exIjxaguCgmk71kzj5DM864vozWq?=
 =?us-ascii?Q?vL1Z3fglJ462yaH4pEjUUOQxfLnFT1FA7l3qGaJOm/PvMqNglV512282UfqL?=
 =?us-ascii?Q?kp/CCZZPeef6AU6LsPVLqET3D5R8jOz2nNIxJuynycxp0tP7Kp/+i0LqH5PI?=
 =?us-ascii?Q?xn718e64CkADH3jtNdzOIKXT1f+0ZWm59yewdbxM3Si3trRnlOA021W/yq+4?=
 =?us-ascii?Q?aDKI39iNDxrh+kXmeyyLm3HNHfWMuMB5RK74mdBURYYojLEkETj6KQXyF3dU?=
 =?us-ascii?Q?oXz4NPRbkrQRQ1bi2Jgx4BAk1LPRuN8ZhHnXlt9ZPoM1z5Ig5Ujy3wEZsObb?=
 =?us-ascii?Q?BkCFZNiMN4XLZm7lZI2KfnApK+dUC4aAjxSxVeYOs8hjFHs2AoNbRgLBMGMJ?=
 =?us-ascii?Q?PBz8g6iw/pjYxGpk6jk70mmHQDK8oqOBznld0wJQJIcJucJDZmRGvbuT/eLJ?=
 =?us-ascii?Q?AD1nNKXV+YjUtEC16GNtmZxadTbca94Lbn/Op+302z3ZhVPFkdeAuIJXBhB2?=
 =?us-ascii?Q?SMtopDvCXmSLDazybE5gQEu9lICI0Uihz7NPdOobAN4rQPBiubWptazjr0Cj?=
 =?us-ascii?Q?rk5jwLoyQXv2IjOty4Z77Jd8PjJz8+dEKeqYFUTcDrhbd3ZQpUlkvCshscX5?=
 =?us-ascii?Q?/GH7Q4M49hY6NLo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:38:23.3323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b07bc2cf-550c-48f7-916d-08dd478d74f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911

Commit 3f9e07531778 ("cxl/pci: simplify the check of mem_enabled in
cxl_hdm_decode_init()") changed the code flow in this function. The
root port is determined before a check to leave the function. Since
the root port is not used by the check it can be moved to run the
check first. This improves code readability and avoids unnesessary
code execution.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2ec8c97ab160..f8e22bc278c3 100644
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

