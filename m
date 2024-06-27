Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F913FF9;
	Thu, 27 Jun 2024 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719528422; cv=fail; b=KEUz0Idccj5Pv6v+3u4Kldi9NCydlh4jyRyikVRqGhIPgSVd/x+ef8Nn30Ng04IBsyWi9H9F4bu1L5fNUxZb/jf0Kt8hWaT+8+M1Ze6tvtzAklaLnFmV/RnnA0XfNnqh6tlvb6Mg7j+0iJxP8Oy4J5F/jvf1BVL83oIG9M2vcOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719528422; c=relaxed/simple;
	bh=CSUBmafGC/wwdSnalGy7Y+ViTsiZtqFnkD3xzP8Vx6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWzmu7HW2s6BXOfpmA56QJcHxOLsAMBroWFYrEH6nPrc0lyHGHn+I84wXUNfiSsJ4Z2HXhBIyz3yzJlAcHEeLXUqkFhYH8Zt1fozg3DPM6XuzKX7AzUdSHkkxu/gka2502l48uqbtJD4hR5xmR3olltQF1YQiB1E86iwufRO44A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sG55TQYq; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sG55TQYq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+dB4qRZnEchnl169sDT/MRO+lYglqp6ckmPTVZuyhRRHotB8vA00QF6aGqGsBuFaJ1jM7YrtDF3twkogO0PTENw6tEB0WVffJqd1qYcJ449tu/wgrGZoHDpr8x+vjTNsHoHurzSEedfPvlPGAi4fvREVsE869lIZlhv+lJYT2tVEfnHw/7t0rW83ZKTN8OqQVTC76Z28MZ8EXvRG2krnjjSKiIOJOgHceO4Wd973sc+K0NSw2DSHnkm9VJ0iIQYW9+AaeQWkLKXxdeZ1lyJc+ZKtaAseVLP/NKvaB3c3Ibb17gJkeTYT3rC5OHPed0Kt8eM0oluOmZMI1jedkJTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvTHDYS5g3rvFskiyopebg68RQxdzwYWGUVzm2Z7aB8=;
 b=JqCgn3i7Mzg1BmP7umihasgiXgv40XCc5ASzWmuFpPI8KLj87DuCw6zkcyMhWKbjblO986yPOY7crAm2uT98pUNl3d6qJefSXwAHm52tGZGkpW+mXjrY2vq7WUpn5by0e5CvrLm1rAI+yfwDJAGrTbP3kSqmQGevsgsQJdR75rQE/xtvBKBohKLRmFBugqomjYBE5Hp9lO4i9rXCuWn44vXHS2D5vI1cAzPraFybYfsXT3Bdq/guhnv2KGOrlcPSH/beNX5Js28RDVXI3hZqWz7n8KzSEn8ubIoCfFR5KP2erG8acpHwwQtuz1BGHAgFWobK/pgXxqIYQ3/nunjCUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvTHDYS5g3rvFskiyopebg68RQxdzwYWGUVzm2Z7aB8=;
 b=sG55TQYq/ZG1quXI/q71ZNJEgNkxkbzZJrVDSFRvpKCuPTxoCDnCMs6C1v/7HQzBEwXy5Pf3zwhOuZ10ynXKXSVI1ldZLXU1gN/Exk/s30b5AyD+XVbIf9V4AamdjKIm0kso8/JIQVYfhy9txty/cQvKuCqbj9yUgoydyXwG9CY=
Received: from CH0PR03CA0064.namprd03.prod.outlook.com (2603:10b6:610:cc::9)
 by SA0PR12MB7075.namprd12.prod.outlook.com (2603:10b6:806:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.33; Thu, 27 Jun
 2024 22:46:58 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::e0) by CH0PR03CA0064.outlook.office365.com
 (2603:10b6:610:cc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 22:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 22:46:58 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 17:46:55 -0500
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>
Subject: [PATCH 3/5] cxl/acpi: Add platform flag for HPA address translation
Date: Fri, 28 Jun 2024 00:46:12 +0200
Message-ID: <20240627224615.854162-4-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240627224615.854162-1-rrichter@amd.com>
References: <20240627224615.854162-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|SA0PR12MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: c5978da9-7fb2-4ddf-c1e0-08dc96fb0d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FXNUOekbpB22ZI2fZIpZC+PnSanjy56wcBAg6p1f+0r0373+aCnEiW1I/AJy?=
 =?us-ascii?Q?1bdral/Ypyza2s/VZHMC7HPmIVn69bjK8oMAZ4X52uEO2BmUE5I8HGiXzWjQ?=
 =?us-ascii?Q?bJ7+uslJd0pDtVComo1hjMA878XTOYQ4LbPMA+zHDOFtPAEznNzLKoMYvZt+?=
 =?us-ascii?Q?Vm5wiWgpkmwdkPSwIOPeLceYCPasVkUWeyowLdB8SPhNG/qfPewNeA2RzFyw?=
 =?us-ascii?Q?1riZjhrns0scK/jglWqwKh1IyLJogWL6zftsv6XbRHPD7AGOU9V1xZdHKnuS?=
 =?us-ascii?Q?BtAeR1BPPR3kpYfjNLUKVQUi5lU/qfRSaZkQjJ//RWzCfWmKUk/c72F65EUc?=
 =?us-ascii?Q?t2+SMYjksNqqG8IzlCfpUei1UiH6jpu9fmL0YxXSWv7oyVErkDM8xCV2LNqy?=
 =?us-ascii?Q?HYyb9j7ChQsJ0JxlHBlXOVBURKAxQuy0itvBXv3+tS/DNCpg9vU38U80IGf5?=
 =?us-ascii?Q?y/OzVn9UONEINC0DBteLHmmOSeXj5FNFYRE2ozLOdAyk2LmnAnYc983qk1nB?=
 =?us-ascii?Q?N+QymK8BiFn6ED9texSR+QYHzgJ51KFs9qhSMJOPH6RgXWHtXeoH00/bIjBf?=
 =?us-ascii?Q?TU+m/jMoyZSIqqbH4wUsPSQYHUDxT2zNcdhJmAEIPp+nASBKLbNq6SQQUG7b?=
 =?us-ascii?Q?owIt/poNmTZXQ8ldtxOQ3ug9EFmVKFDh0BfcgXjOrbGdojW+ouPRWs5wfE7p?=
 =?us-ascii?Q?yO52cYgF9afNIO4nUB6A1Sz9EVDa5i4Es4fG5CH0r1gTRlU7NX5M3UKKVItw?=
 =?us-ascii?Q?APCTkJDWbBVmMXiOBQKX5p0aP2JdaHGvyN8VvZ05bE1Qh1d788vXYFy46Ffz?=
 =?us-ascii?Q?6u5RLhW6KOAYY0WMOu0+N/olHDeWnPq85TdlUDcELEog7oFuafh06Y7s1LkZ?=
 =?us-ascii?Q?b9Kz3UkdQ0CjqsbGpfVkLPCxasknEkIUapm1Pgvakj16+Zk8cYRLGDIRkn8n?=
 =?us-ascii?Q?2lV7t49rBwxHyU8QuuVz1nfH7K8a7PQS+rTgcg/vSZH9ePOVU9fr4TlvrCde?=
 =?us-ascii?Q?WCeH+6joGo8WnAD7yY1xo2Ci7rkEWhFBk1HPZSnmODPIVjE2N+KmXR2Cg3TC?=
 =?us-ascii?Q?jDzQFUtGJN9G2oquz9oENLwJn2hvVO83DwUiwGGtRmJKO03Xc97k9NZXQIuT?=
 =?us-ascii?Q?PP6US0uuyZnslH+78Zgf3+xqScAArb1ylmLnxxwNiTS0XE3vcDoUI9DnO/uT?=
 =?us-ascii?Q?lO33/e5lBH224br/CtUsV+J2mcieDE8eXnR/6tWb3nhBn9/4jX50blM3/tdY?=
 =?us-ascii?Q?Dyh6hyuHH0aUnP3LM004mTjpshcT1JzDiKU7rz0TaAiMH85OLiPD9qXhNCMk?=
 =?us-ascii?Q?8Weyr8If6OXxPXNU6nvFEkzZGiC1qImz47juJtVAZY9z07NNCbRH7Q5GHYr+?=
 =?us-ascii?Q?higV3jGL6hGQDk+eSNWXCrgEI33zXWuPujJH6UQc9lhzNYoFgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:46:58.1112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5978da9-7fb2-4ddf-c1e0-08dc96fb0d2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7075

Adding an early check to detect platform specifics to (later) enable
HPA address translation. The cxl_root structure is used to store that
information.

Note: The platform check will be added later when enabling address
translation.

Link: https://lore.kernel.org/all/65c68969903b1_afa429460@dwillia2-xfh.jf.intel.com.notmuch/
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 7 +++++++
 drivers/cxl/cxl.h  | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 571069863c62..67f73a831bd3 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -536,6 +536,11 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
 	return 0;
 }
 
+static void setup_platform_quirks(struct cxl_root *root)
+{
+	root->hpa_xlat_enable = 0;
+}
+
 static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
 {
 	struct acpi_device *hb = to_cxl_host_bridge(NULL, dev);
@@ -838,6 +843,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 		return PTR_ERR(cxl_root);
 	root_port = &cxl_root->port;
 
+	setup_platform_quirks(cxl_root);
+
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_dport);
 	if (rc < 0)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 603c0120cff8..95d054dc1af0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -627,10 +627,12 @@ struct cxl_port {
  *
  * @port: cxl_port member
  * @ops: cxl root operations
+ * @hpa_xlat_enable: enable HPA translation
  */
 struct cxl_root {
 	struct cxl_port port;
 	const struct cxl_root_ops *ops;
+	bool hpa_xlat_enable;
 };
 
 static inline struct cxl_root *
-- 
2.39.2

