Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749C319047F;
	Thu,  6 Mar 2025 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279559; cv=fail; b=bedS8pM/B2SfBSeSpRn2yd40R2JR5ttrIIKrdx/kjRu2D7vSb1hJ4L9QxqbKMVs3OQD25P/O/NZlTej9H8EXPeBsNxiDE03SDdPA+Q/hSKaXXRjf4yAAxhPmEvDumF022lUXFqUThmqyBXqSXSiv3IkzWMezalr76vHI+sRiamk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279559; c=relaxed/simple;
	bh=gUlPVSDsmC3cL6+ayXRxAP/ntPgslCWu+/BBekjjoh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoKyMThhzL6pPRjPhldzuMsEEaqTz/KDhbOA/0NIYL/JQNIHOzftZWYrO4y/CsYiHrGbzSOlYAbmP63fr74VpeTDv+rJwfrU/jrQcOIS7LXf4hRkCR55dw9+lU4Ad5vGAPJaOT1oPpB1AKO408qy2yffkMCvgQxzthNKzxBe1WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FaXoxPuQ; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FaXoxPuQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Emf22bQC4AdA0K8wDu9rFQpM7bnicVk1KsfqRy6UnLo+j2agoC3QSAwe7x20sCiGAoUUXix4Rl3WuC+fqf+99Y4oXXPVSfStMmSO4NLnhNV7jM/wLAnGDweVdTu31q7PLadkfRdtse0mBGdcCbHIA5d9JE3kipenDEAwWaZOUzgK9h0p687V0BBXxmZkWSrsibN5y7usBHFruKSNb9O1POSYU2WiBwsvC2Ex/1HwqoioCSAeMo3ucHVVggRu6uSoHv9mlmnmCJn4C1dGeSfkFFfwRWzHHE+88F6vnEQ4nAs/PXEzDp8bZ8ucKSYtdy6Up7BceTlQWDXXSrHI3bMKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8IexHW0Oly6jIL7mLsUdMwExV0Nh5XaQerOnZ7I30o=;
 b=yP4DODuvxcXEiFbP9BG3aJCjT41t8IOCDFWCyuesFnQbH5XlRU5s4ZtuAb43DH1VICJPOo+k4zhXrg9EGq1jpab1N8h+1o7htjKNzRNecCzVQMkQ+A5thDexRPfmFCZOfOWw57cOLKfEcoRfMQ81AIUUmP0na8L65BS+7wmx1a1n5d2Ys/qURcekUO7onzXsRdv9mWhJqD1cBNRH+E9xuNtoPKX9Pjc9X8TmhCtm9/16IKitkBjCXEKhgt3Jhuqm7WOrUHYkl+jOxPpzwAC/nl/po9d2+X/EipdrNUIVgMHyn2qenL+9vk2WNix0h+NyGjVx0NGxmuw9ILnD4oPRwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8IexHW0Oly6jIL7mLsUdMwExV0Nh5XaQerOnZ7I30o=;
 b=FaXoxPuQbxRIcbl5GMxjtvyyXtQnAi2B5IhdNRBDv1JH5M5C+Bs8KqV9UaJ6VgbJZ4M0RKVlSFSRSsj85LGYvrcn6djs7feqBgNgqZuH9X4b6M8R+gdmtjM9WpnnPdb21hlxrhAINidJ3GhgbOcnWD05APl71SBUOMdCCG1SMGg=
Received: from MW4PR03CA0341.namprd03.prod.outlook.com (2603:10b6:303:dc::16)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 16:45:47 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::e6) by MW4PR03CA0341.outlook.office365.com
 (2603:10b6:303:dc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 16:45:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 16:45:46 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 10:45:43 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 10/14] cxl/region: Add function to find a port's switch decoder by range
Date: Thu, 6 Mar 2025 17:44:44 +0100
Message-ID: <20250306164448.3354845-11-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c1bb75-67b7-43bb-2efb-08dd5cce5853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6NqVdR7yj1D09KxKGGtqSScYJm8fUxI8kspuyybdgIvRLu44bCoRORKhMXSP?=
 =?us-ascii?Q?i0RMbe1v7Bdq04+9GWjfNczPz8bGTUE/FEOF0xKDUJ+WgjTuX/SX05llnPEN?=
 =?us-ascii?Q?ot6nX2rWKkAh51xOJQ0aafo0UtjhKFN3VU8/pW/1g/Pg9ou9KX79x1PJTu3I?=
 =?us-ascii?Q?JW4ChU+h8ldjRKcsX+B1PvA+CvDh1j4ROVlomU48v4n5iZzMXHQUnJxbtLc9?=
 =?us-ascii?Q?9GlksT1lmpmUXgp/1Elqt8uL+5OUUIfESfyHQyAY+02rUMu87wsbTC5UC5vu?=
 =?us-ascii?Q?cqFzie3kxL+0uKzJ0hirqFVrrZdqG6ZSH742CaZR6CIUASzH0EMLrJVgIaIr?=
 =?us-ascii?Q?vYBr4u3p/C/ruD1ZpAlK8zkNOgnpJ82qhBaBG3hCGfsLJshnaHERBmn1+LcT?=
 =?us-ascii?Q?t7dCUQ0vct3pM0RtRTlaVoMxbE3qpxHsKfkCx0MoYE1j/tg4rZW2RHJQbteP?=
 =?us-ascii?Q?3ADFAtXJOFyisJNFsoUWRvDY0RjMdp/iE+IKd7q5oXcO1E/2eNc+6Xn8FRVk?=
 =?us-ascii?Q?4uGVTvbSMGwRapiebyf2Wqw7oxEJagr4NtXf+ik3rGyLqjHjwxSSVvIa8bs8?=
 =?us-ascii?Q?RYVwdeI1pgpA2nurXB+PmD9PWB4edj+8CXSSjWk6XPhKbGBKtQ8WQaLiywxv?=
 =?us-ascii?Q?OVxQSY26xqqQZZjpX2mW8uNnS6DAPPVwtmIs7iBwSp8aBQqeoBWkt6CwGLdN?=
 =?us-ascii?Q?0rOtb/OxWl1e3ypNRgEUCYj1V8Mb/Trscbo9oexSZyX8mVNf1bkknjO7h9Tl?=
 =?us-ascii?Q?zbDcseZSiuio97bQo/TT98a48LsPhmX04aiHw7GzZ+zA97dn0GTOP/L3e0JU?=
 =?us-ascii?Q?kCe7Z40o7DuqwCaTw48zJAjSyadjRBS3xze3f+a67zYDZBrecK27iV1iZHSY?=
 =?us-ascii?Q?i+eQr2OV2YQsRY5rmdPt2Wn91Oo89HGgxvj3+auuuCO8AesJQqVwTiq/Hvww?=
 =?us-ascii?Q?Dwt1q/4pFGPG9Y25sodRVO7BE0SCklDQGOuRn35ypb4/oIoSX4mTy6iiUewh?=
 =?us-ascii?Q?xRsgS/PeYhuzwMovne9iH3ykJnL6CBdCfGE1NKtNnHR0p5/rNYw/1nCySEaH?=
 =?us-ascii?Q?4Z0vmwOiR9N1EAxQWg5cRGxCndlASEhq3Oftj5R68tmodbRrcRGpIbCjvqWF?=
 =?us-ascii?Q?NnRp1PyPzOsE30psFsrKaXLvnW1KoB7yAgy2C/uhET7AIFWDpHNaCfwi82AK?=
 =?us-ascii?Q?SHK1Yk35NkMYbLR0fK5fmhsCA9ijJxy/7vxnp2j8rZekveoIzyMolg4sigyU?=
 =?us-ascii?Q?oL/YGSFcJcnAsFKZICE0FTIFg5NKXo0oSIikBC92y1b4mOeoLTD/PCCtCYtt?=
 =?us-ascii?Q?gqW45rm0oKYx5kiqURBDSTqdJvUJiTzv0Ok6FbN/Khot9EBvLuBpd6oqcymY?=
 =?us-ascii?Q?tkkd6TlMmFYlROW3XxM2cU9E0BtWlr7sp6oxAnuE1e4zxJPQdqjquk9x5Xle?=
 =?us-ascii?Q?FWViZIcx0EX/WDj7Qjl7O/ejM/ksY9C3iwYkjxWTSwg1MF2KC8eLFp/z1/JT?=
 =?us-ascii?Q?d/o+LFVt4I8Agos=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:45:46.9624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c1bb75-67b7-43bb-2efb-08dd5cce5853
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551

Factor out code to find the switch decoder of a port for a specific
address range. Reuse the code to search a root decoder, create the
function cxl_port_find_switch_decoder() and rework
match_root_decoder_by_range() to be usable for switch decoders too.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 48 +++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 70ff4c94fb7a..cf58ee284696 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3198,33 +3198,48 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_root_decoder_by_range(struct device *dev,
-				       const void *data)
+static int match_decoder_by_range(struct device *dev, const void *data)
 {
 	const struct range *r1, *r2 = data;
-	struct cxl_root_decoder *cxlrd;
+	struct cxl_decoder *cxld;
 
-	if (!is_root_decoder(dev))
+	if (!is_switch_decoder(dev))
 		return 0;
 
-	cxlrd = to_cxl_root_decoder(dev);
-	r1 = &cxlrd->cxlsd.cxld.hpa_range;
+	cxld = to_cxl_decoder(dev);
+	r1 = &cxld->hpa_range;
 	return range_contains(r1, r2);
 }
 
+static struct cxl_decoder *
+cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
+{
+	/*
+	 * device_find_child() increments the reference count of the
+	 * the switch decoder's parent port to protect the reference
+	 * to its child. The port is already a parent of the endpoint
+	 * decoder's port, at least indirectly in the port hierarchy.
+	 * Thus, the endpoint already holds a reference for the parent
+	 * port of the switch decoder. Free the unnecessary reference
+	 * here.
+	 */
+	struct device *cxld_dev __free(put_device) =
+		device_find_child(&port->dev, hpa, match_decoder_by_range);
+
+	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
+}
+
 static struct cxl_root_decoder *
 cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
-	struct cxl_decoder *cxld = &cxled->cxld;
+	struct cxl_decoder *root, *cxld = &cxled->cxld;
 	struct range *hpa = &cxld->hpa_range;
-	struct device *cxlrd_dev;
 
-	cxlrd_dev = device_find_child(&cxl_root->port.dev, hpa,
-				      match_root_decoder_by_range);
-	if (!cxlrd_dev) {
+	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
+	if (!root) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
@@ -3232,16 +3247,9 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 		return NULL;
 	}
 
-	/*
-	 * device_find_child() created a reference to the root
-	 * decoder. Since the root decoder exists as long as the root
-	 * port exists and the endpoint already holds a reference to
-	 * the root port, this additional reference is not needed.
-	 * Free it here.
-	 */
-	put_device(cxlrd_dev);
 
-	return to_cxl_root_decoder(cxlrd_dev);
+
+	return to_cxl_root_decoder(&root->dev);
 }
 
 static int match_region_by_range(struct device *dev, const void *data)
-- 
2.39.5

