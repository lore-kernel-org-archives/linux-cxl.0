Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9EF1F4638;
	Tue, 11 Feb 2025 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267727; cv=fail; b=RUQx8xPNdKkVLTeok2ZK5Qaep37lSd0wSs9CperAcDIMZLZztl1/jH8Ws7HrTglepDzw3PgcsrKLiIhATFIbsAjQrOx9BQvqv638QytYfm8WQqKpSkD2tOJbWyCUS1VDOfobXlhOOi9GcpakAqEPj7UYtizjGi0bIyewHk/lsNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267727; c=relaxed/simple;
	bh=V1uXTXumt5mnbeW4il4sFiT5/NoeqmeEU7nmJKNaiKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAkQNIpf9LesKJ1BxUB8mbiZc04KTPmueANPiuBAP0KVXKLZcaVMCkkdLm7cTHMZSZUYzEX07QAOJpBVeoj3SQI/UbrtibxiE0rQ6972oWaGzQjkDF3zMi5jODlDwoVamLEHq5tAv+yaVhVVkEvDC2zo1lUCquUVBBt0tEey22o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dHTW6+J9; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dHTW6+J9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJ+bATn8Im3pysEbssxJa6MC2RDVn6SrR9OePKL12wy9axIGGGvdveQHgqM9mkcqtFib02zqAEsgUowLvN2Eut6Z4dH4zPVtoH6hAhGtcrvv6UtDuOoEFpD6Yd1JXgaO7xg4aT7R4uP/ucpDvc62Xm1B+34TfZBkPrKT+mzNvKKp/x89b+bcMhYKqOIvQv1VD4YOTEwTSxHDxPNJ2NfSIbWv8WBCJ2uEb5+ZX7h0pbB9J/9aAaMjxeOLJDh79aMzB+cnY/nob7eMUKsBno8Vqb0kQJ074DzSjLvC3c0LpdvU40ZI2RyQYpo3HpQNZs9/JMqjDUv5/Vgwxgw9vufFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5IIhh2MjphrDw+DADj93WXlZBpkTf46nXODWqSzpNE=;
 b=KtDsgmCVAO17FRImOczMwD8tupwn3l7MYD/+1eV/4RCR7rGPhBbQqWqAoGVyiFeIT7UV6goAfHNRFzW0w0UlvlfQgbueLi9oY7wmxYzpn0bW6sn9IxENot5NGceSYPTVRLGzDVFJlUDm3KimtOHOcaRgnHU2glTEJXYf2088um3FqHUxLvW7/PuopCmziYWWon6bFdcULYaVJNhhpoDvlKuumLiDqRGxu5kTCXjDXhhwhd/1dWSUBqc4LsEWj0J25kPJBbmDqxDe90zWGQAhaIJEWS3e2K9l1MgR9WQ1igvwSqFWxyMiF1UwZFOiIFxgdhasuNNYX5dRx+XKGbv/vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5IIhh2MjphrDw+DADj93WXlZBpkTf46nXODWqSzpNE=;
 b=dHTW6+J9mHaP06k/wzuTGrWzD9B4iOR6Vpa1KR28agILLiljBf+nuMYCNEqg3qg6a212Wh1ti8/xylYJUVew35DmLnxCkCyPsTr4cIzZb4XBJBLHA/aGL3PhCDYWVK6cE6A9/IuDE7ke+QR675A9eA1x41/3SU4hsUiE48bWwEg=
Received: from MW4PR04CA0248.namprd04.prod.outlook.com (2603:10b6:303:88::13)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 09:55:22 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::7b) by MW4PR04CA0248.outlook.office365.com
 (2603:10b6:303:88::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.11 via Frontend Transport; Tue,
 11 Feb 2025 09:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:55:21 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:55:17 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 17/18] cxl: Add a dev_dbg() when a decoder was added to a port
Date: Tue, 11 Feb 2025 10:53:47 +0100
Message-ID: <20250211095349.981096-18-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211095349.981096-1-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: d9dc412e-1201-47fb-864e-08dd4a8232c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TXQFmfNMsfFcy0fKTED1S6gXIcj2iL+T19iM6pUGECbuVE6a99WMzbe2kKZD?=
 =?us-ascii?Q?kAT9twe3hEjsvR5MPFiT5jZ22+ZL2Z+KRtdbDjFzi8HPB7if/xDqeJFgrl5b?=
 =?us-ascii?Q?Bkg0UMetmBMW/NL1cu+84Bz78UCi5Xi3iEhmMmulfEfH9Dl3PxCM/45P4gXQ?=
 =?us-ascii?Q?XYHs3wQbXKoRk2vaRrxRyM0owci7Uh8VGzI+DTMl/50iFKQrFxwTTsA+I3rg?=
 =?us-ascii?Q?N6ETgPeGxvXnn/stWWgjPu7yo4z+c8Xj0ykCtJjCr9jp2KO01l5lzCr6k9u6?=
 =?us-ascii?Q?Lg1FaRrMe+UxY2u37JxUMQjdLWTLIwiWfGKAIOy94a2w3unVopOEwd1sXeFb?=
 =?us-ascii?Q?bujzuCV0MRPRdhJy8dE987iT/q3M5UEOWPnP7vogNVrjhhM1btNUGVAPJPsV?=
 =?us-ascii?Q?4ZJ1cYhVwNhNRZ1cC3WhhHEGPKMzale7t3wXzFYRPTSawnosikxIWSYttybt?=
 =?us-ascii?Q?z/XNRxXKDcFSjoS2Oy36UaxodHQIfYeknsOSYLvnE2zKKzO414o6bcXwB/aY?=
 =?us-ascii?Q?+ZzjwFl4RldnEaZCMgnCP3+kEN7hGvvc2eX5otVHwglcAYRX/xoe76V+9Wbh?=
 =?us-ascii?Q?GySnUoQ8tzPjQdufpifXmAS0VNM2qli53l7akdfm14XTQCwdEGcN/7lDf9jO?=
 =?us-ascii?Q?dsnrVL8aPuDP+sDnYbTIJMmih8ANW8I9g45RvVo85rUtDMvnQeM4nYKgNUMn?=
 =?us-ascii?Q?jomMHHeSz9YBWNN4LyOKvSxvaWPVr2wyTgvuGX9wTyH9edRJrZqiUx/3a54Q?=
 =?us-ascii?Q?NuCugEYsoQQduUBmpSAQv3iW/AiIOpEbwOmYT0Bfkc2roZSu1mLqDBs3S4/O?=
 =?us-ascii?Q?xujPYiXwEi3j5IQqwhFAhf1KfXIU01IqM98AC42dulPwOIUbp5wnul6+/Isi?=
 =?us-ascii?Q?NLbGl1HAByy3zUJPrv6hUH4nLAVfa2h7qBEEscSfIgJZ2SnBxKlwujyOV016?=
 =?us-ascii?Q?Y1Xbfi7HPiMcdDFNUvJdiHk2lWK+HIb3/jEpaPXR8O4NbFjs3DJiOUkSxv0t?=
 =?us-ascii?Q?xioltrZULvtSOnFbC2NGCPZkLIlUTnSbOyfrAB2ZOEo1qLShL0+d1pjpwZSa?=
 =?us-ascii?Q?6OCuR0eB4yBITIByvkzzejhfOjLtLJOonNkX3i2teMCKHDoAAHTVcu3oAWGg?=
 =?us-ascii?Q?DP91OsfUspu8w3N4RYeCFBtAhsCa3e3HyW6MoM6XM/4j42GRwkxL0vMNR1s4?=
 =?us-ascii?Q?lvy6JB2w+r75adp7E39tIAxVPHUg+LyBs6UHH/SWjLScRF+vKm32bFTqWIBo?=
 =?us-ascii?Q?Df2Dy/Dc6LZgXekKCQKvPncJZVr2ij8SZd8/Re1jnxrVA8LNAc0vdBMRit7p?=
 =?us-ascii?Q?vGcRxvvEX8zWFjAHwq9qUaB5Pj72OLUb4UxPQpQvudddWYVeoIWZdn7mFUjS?=
 =?us-ascii?Q?6xt4KFWH2R8XQztYd76bfjK07IpeL6FHRmMfpxRwU1sOx7rp97P8M/kF3plo?=
 =?us-ascii?Q?wRf2XAYSR9DSlsY9tY6bDpyt4Oaxe2QguGq4ZhaPtlZyIebJKcGV4FIkXJIr?=
 =?us-ascii?Q?BFvf/IsgtKJud+E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:55:21.3706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dc412e-1201-47fb-864e-08dd4a8232c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750

Improve debugging by adding and unifying messages whenever a decoder
was added to a port. It is especially useful to get the decoder
mapping of the involved CXL host bridge or PCI device. This avoids a
complex lookup of the decoder/port/device mappings in sysfs.

Example log messages:

  cxl_acpi ACPI0017:00: decoder0.0 added to root0
  cxl_acpi ACPI0017:00: decoder0.1 added to root0
  ...
   pci0000:e0: decoder1.0 added to port1
   pci0000:e0: decoder1.1 added to port1
  ...
  cxl_mem mem0: decoder5.0 added to endpoint5
  cxl_mem mem0: decoder5.1 added to endpoint5

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/acpi.c     | 10 +++++++++-
 drivers/cxl/core/hdm.c |  3 ++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cb14829bb9be..3e75e612cbc4 100644
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
index d705dec1471e..467e4fef6a53 100644
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

