Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F028C1FBCAD;
	Tue,  7 Jan 2025 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259157; cv=fail; b=TtrGYBy1j8kWM1sUgsrLOcLljoVaSrbBHu1KQCEag+Pb0MY+gAIBO9bhHe/zzyqypH7rJufuTF8/RYJOPCLvlvIIrqGiJxTmMI3esUvTasDdlyXZGgZhzLVZo2dNl2kVAf3k7tlcB0im7SXjXRr37yONsZnlaXpel/Pa9rp4tB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259157; c=relaxed/simple;
	bh=sgWMsD99cmtznBWecqRI5uszKEIDKiEhWQHo80Ys7+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZoCf/S/+hookujP3thO/N66pu2PG7WB76cKibU2eslo0VbmOM3Q5tJtYCdLLcSJy8h0i8NJaUb0DPzqsJa3Q/hrpkcdiaHeUD1mFqtVUkVrVZ5rC8iEteSJ7ACWfbFFbdGu+ip9pL5bEVKkfAmpXfnRm34EhnBNl2gYrByDHNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a/vTlQf/; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a/vTlQf/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBpUOKAlvcMm1oI9h0bniQEhmjW3sGZMgFeLFeM28NwzTCiZYbvemTK95g7kMltLytTXMO4k710k1SgiKCPiLraDSA1WDMjc7+SKaMB2D65J/tw/4JSVf5/5qUXTbcXLQW0BTGc4npVQw8V8c86y5SNBHML5asSwhcHJW1hz1eK0dfwdhRy3eBO3ukofOcUtwN9IUZ7YD379WvEi5rDDxEOaGZG/JQw56yREknZljBVdTnZN5QTiEcF2wwRov2T8TQ6t638tDqIj7zfVF8JfjDx4j2slIXpBR3E5n8xdn9xIJFtIqWuvFg00EAjD0syeo7rYFyrrrxtrj91d+s93tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfsVssPsAzfVBpqa6ajs/QG36MX9NcCVxF32NI9lg24=;
 b=rZa5M2zgOAbVElrwtJHeLMO41AUlZ1o2VT2QSAhFGHhPtXjjnUshnlwVbX+gjY1rPNECCJtfxrQ87+GdNTOJRdLW8VpvCBewpz9fXYrYApKdCfs04IQvWIBFKhTjE+8Ka0ipzi2Ii8iQHGoLdYA8gunPkcrBNwN0nuWxz/oYcOzV/UgyZrbQ76X5hlJBc5Ewo31ctNNoptDFc+I1f6MjMqgTnxjQdQmQBcfujMnwFJLZo8bhg131QrlWxIz+N9ZHJqh8ymLE/T73Tv3HRcXO8FTAnPr1tJHXwprfZBziymmwkd32r77LPmlKdGkMOolnlq9c75qlDee8mCuHIsc6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfsVssPsAzfVBpqa6ajs/QG36MX9NcCVxF32NI9lg24=;
 b=a/vTlQf/iEHUwFUN/5h6oRnxzWWvQeqqjXMgA3Fbu2IYZhWGt3dcJHJiwWvCtb3HN0n2k/21Dw5kTG73R10tVgiUoTpXIBfxnOxpPVuYrJihSX9BOSSdjAjV7pQtsrzjflLAXlYR+ETBDcRX2gjrweh77Q9uqqpY3gtBWIJtGbY=
Received: from MW4PR04CA0079.namprd04.prod.outlook.com (2603:10b6:303:6b::24)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 14:12:27 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::fe) by MW4PR04CA0079.outlook.office365.com
 (2603:10b6:303:6b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:12:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:12:27 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:12:23 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 29/29] cxl: Show message when a decoder was added to a port
Date: Tue, 7 Jan 2025 15:10:15 +0100
Message-ID: <20250107141015.3367194-30-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb8254e-f4b9-4dd3-9649-08dd2f2550cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vcoWKMy9h7y7n+//aooMMaICjlF+O29pA+DQY7rEMZzy5Sfk0AQCoioH1HN4?=
 =?us-ascii?Q?moQdWAQAsGjvnfdQN0e9B9kUCdf+ycVRJGvyOzXKYxb1pTbefnNre5nk1b+v?=
 =?us-ascii?Q?V1rhPXmGI1vLb6ddH3odefJD+xKb3rtmKzDX73xps35bfEytfLbWQMq2kawf?=
 =?us-ascii?Q?2alFUE7MrmKuFFKb6oojuHWkCy2r7WI4Yw1hDkj7KKwtme7OceL3FXGpnLWg?=
 =?us-ascii?Q?sPTzOjnSjmFAFVN0qIXL8QUQMoqOeERIu+0V1NJyzpBHQPOa/UPdT23h8VMt?=
 =?us-ascii?Q?CvHJmoJIjwv3Mm7RHdmQOR5TcngYsy3c61N55by8coBNB/VxraKwmHwfpeXZ?=
 =?us-ascii?Q?T00Wpf2SfxiiyBDZjweZsUBNQsgqoiesHHpYBheuLwuJAjaugsKv60W3iMT5?=
 =?us-ascii?Q?SGF+WxQiuK5vApcB2nkOdn1aDowhXNtogmYorcdCrTGib6dRDlsZxaMypm/c?=
 =?us-ascii?Q?yo8y/mEYAq4UnZmohSIGENvNgbPHEKWsdIwDV/ZWYUqxMs0E2+nxyPqtoVM8?=
 =?us-ascii?Q?TiUSaoefmgxjCV0rSmoiS5FIdJWOha2/Cvdt1EmxFkYx7uXkb6G5W/YyD0KX?=
 =?us-ascii?Q?F1flQmLq52nYUesQ30ItdJwrw3PbBQhP04IQPOLLiaS7kuIf1QskWZcE89p1?=
 =?us-ascii?Q?zCE2bQehxil2/A7ozMvyxYkkHnBo6XhXj3si72gYCl46BSOshDKdBLZtIuQQ?=
 =?us-ascii?Q?Xrh8auvioC/M/eQS3ou/e3TDdIrgbjorPArZdmFnES8R2J7uRFB0KKNchUag?=
 =?us-ascii?Q?TfVnJxfK3cjSatYg7Iakbo1gJO+2jUW0IfSvpxnKN1sJ2SAZCrwacr4Mav4W?=
 =?us-ascii?Q?luSp5eGte8y8wzpaRNYP78ZLpwaFhAl4eA2vWVkO1a93I0EBxCKBwwizpaAX?=
 =?us-ascii?Q?GCxUx9fdK+pTkyofsqWUWz/2sdm+7zD7ixMacri7AkahxkYJwcTDTClSd9u3?=
 =?us-ascii?Q?caSe7Kbdik2qKSWGXuGCjedWUyyPP+4GScmpa3fWsNbYY2/13oktlh7iZPWl?=
 =?us-ascii?Q?W+kyaVx5v0W9DHFSaTT2zKeKPId5X6mEI1Iy2kFN15PGLj2L/5GQD/q3fjec?=
 =?us-ascii?Q?5QCZ0i8QBf+2gSg0ygrvj8QZAZ0h3FdrHSABlsVnlpBsP3eaZHqePQ7CJtXp?=
 =?us-ascii?Q?qAK6TXuFWNJEXoVkVsmQmAOxP5PhtRxu58aTvVxlE2OZWFIPV3zRyOq7Jd5n?=
 =?us-ascii?Q?FPVyCZFNKsVMoNCCbi9y64EqzQugfsIOw6LSHOBcV2Vepmr9asGrW8VZBaHo?=
 =?us-ascii?Q?IzaHi1yBnibxzPL4bw23AExnNUlAVBkgrg/YeoQTtfAhtX0cXzeLpoi9b3s/?=
 =?us-ascii?Q?R2Zx67zkycGxynrbVufB8VJm1PzOy+dhKK3Y2hubV2vq/PMFDDITUank/xYh?=
 =?us-ascii?Q?SUckHmZ2VcDsugGGHH1J7Qn8Jmw8M5T4u2t/Xxm1+yRxxveMY98wEyporvn4?=
 =?us-ascii?Q?QYPJtNQGJTot42td2NR89j28fst/zyS0/tKdQv3LN4KzXyrYqQjmqZst+Bbz?=
 =?us-ascii?Q?M5/rfCVHz9A30Xs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:12:27.0730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb8254e-f4b9-4dd3-9649-08dd2f2550cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856

Improve debugging by adding and unifying messages whenever a decoder
was added to a port. It is especially useful to get the decoder
mapping of the involved CXL host bridge or PCI device. This avoids a
complex lookup of the decoder/port/device mappings in sysfs.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c     | 10 +++++++++-
 drivers/cxl/core/hdm.c |  3 ++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index b42cffd6751f..ac74b6f6dad7 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -421,7 +421,15 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	rc = cxl_decoder_add(cxld, target_map);
 	if (rc)
 		return rc;
-	return cxl_root_decoder_autoremove(dev, no_free_ptr(cxlrd));
+
+	rc = cxl_root_decoder_autoremove(dev, no_free_ptr(cxlrd));
+	if (rc)
+		return rc;
+
+	dev_dbg(root_port->dev.parent, "%s added to %s\n",
+		dev_name(&cxld->dev), dev_name(&root_port->dev));
+
+	return 0;
 }
 
 static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 28edd5822486..7d6778f908c8 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -34,7 +34,8 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	if (rc)
 		return rc;
 
-	dev_dbg(&cxld->dev, "Added to port %s\n", dev_name(&port->dev));
+	dev_dbg(port->uport_dev, "%s added to %s\n",
+		dev_name(&cxld->dev), dev_name(&port->dev));
 
 	return 0;
 }
-- 
2.39.5

