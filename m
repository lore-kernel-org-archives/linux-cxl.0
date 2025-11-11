Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E808418A6B0
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897360; cv=fail; b=sHq8IiRAb1aZOFhJn2iGMuqSCXJg7y3nX+wRKs+rsTMDPWlNE9G79FfUmRJMXVrb+UONRFYCMEM/RuEv1FZ4QAQb16OVdvVidffRyqSoypiBbV/EcmNrDEwZDkEsRFvWtxnyUute9QSbGQdtXrL9gwxIDjXac94jEgeI2GZ+xOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897360; c=relaxed/simple;
	bh=b36PB6GCWzCdDUtCI5hD8hw1EFZEJkYnshDzj4ZUVAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEgYspluRzP/UW/8tqpAWxQwCq5LAlVvTwr9mllCUTOll7eY7s057HkD3Wunki9EeiuG7/ktF1YlPXPnizw/wCEf6Fr6IonJTSYH+7PXRqi/yV8iFo5Zo+3xg41t1hhPlZB4j+2Z9YDjbANQXyf6alww7hhqzPjVPzv8eOa+M5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D8odvhc+; arc=fail smtp.client-ip=52.101.56.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D8odvhc+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxAvZmJt/nZnj2tdXpz/3LMk2qk7p/o2Z9CRT5aNKglf4aZMDGuXyHYP3hfdj88VhDL01pFGePOS/U3NbEfWtY9jySgs/Mr5Tp+hCPHFREFvm8KAhi1BjSzXIwMfSXcb4yFln/KRtDQpSE7NcoVcyBsJ5oVr34LvbPhrzNDYNCtHmVxQvtwXskknc9aHEcW2dGao97+chgXzSDU3uIEr2pcFEHkH2QnB1BDvb/AIVI/I9ia+EwhellOEJwO60HC62OBGuHfqhcG0QXA4cFYQoxaIBUACwSDoSjtM/s4BMluMeL1cwJNf+JsTjnjTzPfIrwnkUtCrNUsbSg1N/XYXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucRfgHEvKx3HQldi4+QnFkDisnlho1obvaA0OwBvSXQ=;
 b=OBWoBLLfUHPJyrItqMOTg/akXVuto+4rWoDA57fGcYnu4K8PtonDYSLXoh2RwsAphFr9mNWI++t9I47zSlioySLdyhLPE1708Q/ZX/jgzLjhOoHwDnmGoQ2xnWYy2S18QyfAwAjy76P9OYydP+QTEQO59j3k6GZN56xQ1EQSjcZq0P1bUuIl2USf3zyepxMEZRn7wiRqza4cY7PzgyuwcFJNT1ZLurLI2HdE18CEzBAqG6c5/Fa4EJjLBfNL3eXLahC1/+yfLy+u644yTNYQqbeN6q3lXRzf5EN/SC6TZWUbs6KAcOtDGiXeEGVxgBnkk5eoTXPHIYHgDddXOtLlyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucRfgHEvKx3HQldi4+QnFkDisnlho1obvaA0OwBvSXQ=;
 b=D8odvhc+1HoRpw7d6wonfFlkQarTAvL4jUOXPNxl2gfTrEjit1+/R5PWdr4PTLxAvndcnK8g1CZl3gQ0maKgxW5WcDmDSnB21+TvJmdsLKJxeKMonnR6BED49nqxLH2Of2a136ezs07UQWQBctON/0JGw+o29ThheY6Uof1FMKQ=
Received: from BL0PR1501CA0029.namprd15.prod.outlook.com
 (2603:10b6:207:17::42) by BL1PR12MB5900.namprd12.prod.outlook.com
 (2603:10b6:208:398::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:42:36 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::2a) by BL0PR1501CA0029.outlook.office365.com
 (2603:10b6:207:17::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 21:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:42:36 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:42:34 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 09/17] cxl/port: Split endpoint port probe on device type
Date: Tue, 11 Nov 2025 15:40:24 -0600
Message-ID: <20251111214032.8188-10-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d8f0e7-b2f3-4caa-8f7b-08de216b3a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n6r7HM4MexLGWhhuvb/rC3w5rLME9RRlIUTbNjts4CTBaxcXCOoRKJJyu7zz?=
 =?us-ascii?Q?zocoq7TW4ho4x/Vzqxb3x9QfBFEdGVXc6+sGhQLEk12Dv5sLTM0awpEJ27cy?=
 =?us-ascii?Q?5fBOn7k7/TehZ1ZHYZx4LeInkUpn8MRfj6IThP5X2vCTWXSdrdhlYrKCos5b?=
 =?us-ascii?Q?jMUzZXaXUJQ8pTagqEUBfDLpDGctQK11o03EEe0qLN+6+vh8YmkjwCgu+VF5?=
 =?us-ascii?Q?MJ+QZbMzoVyPRHamgNY2aC2m/6ui7K4SzEqLnsJq7IPy5v/T/4oyM0yvuQtG?=
 =?us-ascii?Q?GhXAUZ8BUh5njQiIk94Bao44kQdX/TsTUMmm+hLy4KaVpkF6nx4H17Ou2F+y?=
 =?us-ascii?Q?eRSiRRHG2ncUe/RlFp2QLIuTs2otX5osGUCiTN5kJ1l9Re+HhaCgbqXM1N3C?=
 =?us-ascii?Q?pXqSKqSZsYi6p3k1J8aoYUE0GEacG5r8/Gd2og3oEvkA7ZSLWhaazq64N9cm?=
 =?us-ascii?Q?A4kbX52QgxMhhkeXe5ONdbycMNGV+pqA3mzl/EEwn+Og6vsJG2MaTbcwAiqM?=
 =?us-ascii?Q?qp1CIWkxa4nsuSGuu15dzJPzkB2KnVb5O28M7Lx83D8Z0ZeKXb47idT7oRlu?=
 =?us-ascii?Q?zhveTUNCYxbGy40I5fqMSrHml5iuDfaAdXz0cJOZyjx9D76W5kZOKfRlL3LX?=
 =?us-ascii?Q?ChWVJnOxMGSkQvKxpSnzUJvltzU5xXwfk0b1vkW8AvHCy6FXLAhe8RH7AGA/?=
 =?us-ascii?Q?OolH+PTsOqwldmGgalRiLl0JWKkJzXh6yi5F88KeWyn4sLmE5Be5lTif5LaH?=
 =?us-ascii?Q?r0VmhVwTT77JEEH99gXqLrQa+YjqaqhELg44nFhqJiSq2AxjZLUf7CLumfhW?=
 =?us-ascii?Q?pgB84md0wFCRTvOy6wuNqWhJ8Lxqbggj7mgSn06EGV4qqSV8lNtzQeo7Rip/?=
 =?us-ascii?Q?3X3BPG25mqq8g6ewHSmXkzGbQeovFeakSvMrz2rWDIbHdfOmVtql7G+I6DAG?=
 =?us-ascii?Q?P4hO1Reh7hGtaVAulwdOqo/DrMGCnOgvYMeMVqyCTcIZ5yGTYTHBUNqXzhbA?=
 =?us-ascii?Q?3C2O88iC+2Dw2t3tKshGagLvlHhKAsWDHnWmdfhp0XBE1GnLjJLzODtCSAdy?=
 =?us-ascii?Q?UKKYqTE5ijxI5X9OMkoDh0vIo59Wn/UzwQGhUGrh9XWfg4N2oF4A+Oql8OPh?=
 =?us-ascii?Q?6xy6xZ54jKc0bvPJWsJO5vgPnNcmv4oZMO3ljFbwt/mPF4ZFPFGYMPW99b0D?=
 =?us-ascii?Q?Wayrcl5lyXmY/kBN0xSmoJUVNu5xyQU7/OAE0fyTK51bOr+Dq0kq+W9Z+CFB?=
 =?us-ascii?Q?rjmsPMksiQruINCWP3OwsSdJhPGOi+UwX4PxtbsCN2tflwhOE+qwlQ560KPO?=
 =?us-ascii?Q?Bnz+coWExlLyyFDo6k+vMD7XyqPZ/DSCaQyGJeIZbZTThqDvCSjPL0ZD0mR1?=
 =?us-ascii?Q?n8tjGP1ED8RF9inr/PXD8mnmQK+H9GG1uNfWYUL8JRRkepjFZMhBUEH3Uwar?=
 =?us-ascii?Q?7HIQkmzCtPZ7hqqkTTdbhUQ46VoTXw8ufhNNY9PNXWK6ebd86b4VLJlz2SPC?=
 =?us-ascii?Q?pp5h6YuvH5Bbpm9OGg4TZGHHv9Y27jeH3dPULvg4QR56rV4xH6iBK542uOoC?=
 =?us-ascii?Q?LCWsqxNsXWeluK1uMUE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:42:36.1493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d8f0e7-b2f3-4caa-8f7b-08de216b3a9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900

CXL.cache endpoints have separate set up requirements than CXL.mem
endpoints. Split cxl_endpoint_port_probe() into functions for CXL.mem
endpoints and CXL.cache endpoints.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/port.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index efea9b04b323..14319219d23b 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -69,19 +69,15 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	return 0;
 }
 
-static int cxl_endpoint_port_probe(struct cxl_port *port)
+static int cxl_mem_endpoint_port_probe(struct cxl_port *port)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	int rc;
 
-	if (!is_cxl_memdev(port->uport_dev))
-		return -EOPNOTSUPP;
-
 	/* Cache the data early to ensure is_visible() works */
 	read_cdat_data(port);
 	cxl_endpoint_parse_cdat(port);
 
-	get_device(&cxlmd->dev);
 	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
 	if (rc)
 		return rc;
@@ -99,6 +95,23 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	return 0;
 }
 
+static int cxl_cache_endpoint_port_probe(struct cxl_port *port)
+{
+	/* No further set up required for CXL.cache devices */
+	return 0;
+}
+
+static int cxl_endpoint_port_probe(struct cxl_port *port)
+{
+	struct device *ep_dev = port->uport_dev;
+
+	get_device(ep_dev);
+	if (is_cxl_memdev(ep_dev))
+		return cxl_mem_endpoint_port_probe(port);
+	else
+		return cxl_cache_endpoint_port_probe(port);
+}
+
 static int cxl_port_probe(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
-- 
2.51.1

