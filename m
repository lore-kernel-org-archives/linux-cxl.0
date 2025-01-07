Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F61F707B;
	Tue,  7 Jan 2025 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259093; cv=fail; b=cBD85YFnaik7kTQH14Wptv+m2Eq3pxXrZUQSQiqw0RV//RYO6/OBlJyeHrexyYaH1dJAvFe+c2GG3xJ0pI+aSu4fsyMkEaDuRHPv7NMqw0bYiA64Qd7ImAzlvEb06fUfJD7A9T+6KO0iPZTebVNkC3mCG4ICHS0d79CaCq3Jpag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259093; c=relaxed/simple;
	bh=E2wpDr2qVc2Vj8Q3mc2S+KFC/Y7JLMXW8cpFHyq740Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usIL8RA16X9xLjp7V3WhugnIyKb0P/ov8XlE+52AwpuAXG0c73Hjk10lsJTnq1n99w/jKD5GrAh16pSnaNFAvdPOet7QOXU68SJVAnNRb4ro3Ez0fbSHV/QksdkGiZ15MW0+EkoAS39ci515Klf0bnl8a0W4vnOGKYaxSt5BBFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GjZI9Piq; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GjZI9Piq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqoDCZ54kWRhyi0NPdGslPt81lDm4/18yYDsRU/ZlbHyWCStKF/dZEFMa0r5fVqbWPT/p3mLJqswpilf5XKWAJZx6LXz6xvF73tb7jyT9Rzfu7FupHTeSdsmsMyTUyOrz0tl4d36FAzR19cZO6B2Jow8+YDk4oMgYBN+WRNGtZAqq+98S+1Ofh523vSvuN5VoGn0gfFgSYTKG7Cpv6zVv4H+qyttI8phdKG52bJcq1qcP09YcHa4ZNJQOMdUZcpFWq+EdXSsgLIXTdGox2pJ/91+mcH7IfdvNIKPmKxcDpfhBKekOnrWMV0mXNOfG4etR2YHFz1/pDuww7AO9npF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbGYql5wadTo2HNfd8QYvNBrUqQ+W4fiY8DM+PIOBD0=;
 b=aJ/Xy/ZDuwVv0T7o8nSl3t3x45ca66Fo2htxtHe+pnazDhc+E2zgD/lW3jDGkkBq+3JD4TKTQXUGAtBqD1bqvr2VjpoGNZ/ns9RXOQb5XZm6I+hZvP1wgNJtlPm7GcvBouBV2psn17/UQtzXaVEmmIcWhElwGes9mzV8hltpWK/b3HeKBWKJG14D9rRQ/CnxxGPC+hmsk89yieGO2E30R3fcAx0lZy7pl2bFOEkvnh0O4/EFQUdst1Wh/IK5WAXv6tVr7qA5Vfwas2Nos+o/CEyZY/6l7EJWDpNIL9oR3+2+MXZB1ZMRX71VZ+DFNtGj7k8Pl5tpw7oxgcWjGYf9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbGYql5wadTo2HNfd8QYvNBrUqQ+W4fiY8DM+PIOBD0=;
 b=GjZI9PiquA6j+lex5gXb2LZmqiGvYIlGyEREXqUDGDtMuiaJQkHyprHJpns5WfzCXSVdFsA1+Srew74mUF9FXB6qifmGRIQV9im9D0kMMKl/1pFX55RkxFtJYYvNgFGB+Vrfwf1oF4Ed3bZYVxc17F58ekQRq6lv8dVwCaaS+4Y=
Received: from MW3PR06CA0017.namprd06.prod.outlook.com (2603:10b6:303:2a::22)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:11:17 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::c) by MW3PR06CA0017.outlook.office365.com
 (2603:10b6:303:2a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:11:17 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:11:14 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 10/29] cxl/region: Add function to find a port's switch decoder by range
Date: Tue, 7 Jan 2025 15:09:56 +0100
Message-ID: <20250107141015.3367194-11-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 67366987-4f32-4aed-4385-08dd2f252756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?usIW67d5Y543PQ0KAJdBUaFpjOsg4WKjiFITxHVvbsO62SmL7rfrsCU+Y39D?=
 =?us-ascii?Q?WJPKTGgnTKGtabaKmEXV5u/QK5IKFfoQ9xtnwraxokzDdMH/QiR2xIhRPnCE?=
 =?us-ascii?Q?HIiFDJcxq6nbbJ2v6om8jB8/GtiBQs35uZSbT4wvjUyibwuOnkZsXs4Ov5Uy?=
 =?us-ascii?Q?h8VpWM4vGK97uvf6tKznzER2cgtqz5ezDHUEk0LZajqPq91QBRpT2PaGGUOE?=
 =?us-ascii?Q?gm+qIhLF/V1QGaKLK1XNND+/1e1CxnGx+9Wa/PqPmEtYIGQw0aoHH4zjBxZ8?=
 =?us-ascii?Q?v1BAvkCoDXv+sWt4lGIghRpz8wTQaDVbd8MtxNpb7u3UwCzh5FVvCMLxfS/o?=
 =?us-ascii?Q?QKcCYxrLP+0AOODh/etrZLQ4Eu9wdsj0HvRdKPmuFGOvNne9c4C4+OW0NMaz?=
 =?us-ascii?Q?+I0tJfL/J6Je8H6wKYaC1HsR5iPTA0QopWJ+a+lPk3mRT5MEtZ15qiTNyvSI?=
 =?us-ascii?Q?IMv4ZiUo/Gy+TOvnVk0TLrLTHeXNP5IRYcn4LjruGNI/k4sQRjErxwQYDQIe?=
 =?us-ascii?Q?5dQIRZqpmqt3IuBaAYFmX8kutz9ZvU3DBDkeHnHq/PZsayAVccu5aT8JibQH?=
 =?us-ascii?Q?ICyqUbFgc/p1zC9PbAsJVhpUKvTvqN6qw/BiiZ4uI24cdPU7w7pvvRLDsFu6?=
 =?us-ascii?Q?rdetPINLHKGkJVp5YFe66Gl+y5Bhdedoc8E7R/HYdeSX9dSpNvwxNSZKkKJX?=
 =?us-ascii?Q?Et0xHabL4x2rdjKGLqtSsBajofKrsB/LoPDufTpJ4T1Jcmeu45zI4a0rPq0a?=
 =?us-ascii?Q?O4VQrqvGWdjVzr7kZ5gwjJAiFpvGSif0cCvh4cx5jS7m9cis2S7GJ1uRtQnE?=
 =?us-ascii?Q?UwJM/Wf3t2iaDqPnrzpKCuR/j9I+OsgQDAJZ53gh+zgTGoG4P+AM60spEKOV?=
 =?us-ascii?Q?m9LYXHcjcL2WLZZ0Qhp04jG3ANhwm08xE7hldVD4iSvGLK5e6oRvp8WdOtt1?=
 =?us-ascii?Q?LbBTY1crPOGIu+NkPXJ6TWK+/kouW6RbQFgCZxK/PA5ewCPZDvZLmxoAGGu5?=
 =?us-ascii?Q?2PxEaviujjoTVOhd2kcl+sAwJlfrOubeMF6HhMs+zZ04VaBv3uRSEg5V1ez0?=
 =?us-ascii?Q?PIFNrgG0V0eu166ooOId0/T/B9IcgZjDpI2XAduMNeNaVuOVB5ZMEdMH213B?=
 =?us-ascii?Q?pTgaFEOaZdJeqYfXCQVjneWxN9cx7L9eSJPxikvWOA09w7PuLvbyZ5fvhEUZ?=
 =?us-ascii?Q?EvFGUH3t+sBbS3BXZQqEzduFf1xkGLlfLgEQiAw6A5pQW+QsZQzvh6K6aQ3T?=
 =?us-ascii?Q?D+mtYYHWqmoLGWo7yFveEuvyAgFNPHTskN1fOeIsc1k4+imH++mGuNgchvgK?=
 =?us-ascii?Q?76vf+T3mM8dOwnePEPeVup8Hwn/p5flwYd1gPb10dD2yCoZmypKTzgbRqCGh?=
 =?us-ascii?Q?OyHTmqgxHL8/dNtVXNEYMfRhZlEVGSIYgpCfho7cwyzhz8qEzXuhhlRqkNQW?=
 =?us-ascii?Q?dWOISNyR7BVqmS8tGl2IgOt7YETXj4QxphWFrzREA0LL4dqgfdin+brApZU0?=
 =?us-ascii?Q?pzV8fKftDbb2O0U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:11:17.5176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67366987-4f32-4aed-4385-08dd2f252756
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105

Factor out code to find the switch decoder of a port for a specific
address range. Reuse the code to search a root decoder, create the
function cxl_port_find_switch_decoder() and rework
match_root_decoder_by_range() to be usable for switch decoders too.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 43 +++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5750ed2796a8..48add814924b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3189,19 +3189,35 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_root_decoder_by_range(struct device *dev, void *data)
+static int match_decoder_by_range(struct device *dev, void *data)
 {
 	struct range *r1, *r2 = data;
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
+	 * device_find_child() creates a reference to the root
+	 * decoder. Since the root decoder exists as long as the root
+	 * port exists and the endpoint already holds a reference to
+	 * the root port, this additional reference is not needed.
+	 * Free it here.
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
@@ -3209,7 +3225,6 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 	struct cxl_port *iter = cxled_to_port(cxled);
 	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_decoder *cxld = &cxled->cxld;
-	struct device *cxlrd_dev;
 
 	while (iter && !is_cxl_root(iter))
 		iter = to_cxl_port(iter->dev.parent);
@@ -3217,9 +3232,8 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 	if (!iter)
 		return NULL;
 
-	cxlrd_dev = device_find_child(&iter->dev, hpa,
-				      match_root_decoder_by_range);
-	if (!cxlrd_dev) {
+	cxld = cxl_port_find_switch_decoder(iter, hpa);
+	if (!cxld) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
@@ -3227,16 +3241,9 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
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
+	return to_cxl_root_decoder(&cxld->dev);
 }
 
 static int match_region_by_range(struct device *dev, void *data)
-- 
2.39.5

