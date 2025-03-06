Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE9525333D;
	Thu,  6 Mar 2025 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279527; cv=fail; b=AX4Xtg+KZTOFJMal+o9Ru1ybmY9XL6PMLJSSabK5kVpfZHs6KrIefrOtSs+IfPUbGotvQqhJLxjFi4oD5iIE6WfkdNaNgOHhvmHumeQSc/7RbJadSNHgSNmqJGFYc6TPmjyT0duvzfBv/y4ef8Py20rDYTmaVxzMqw19SOetATY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279527; c=relaxed/simple;
	bh=3eTnioFJmC5hh7I7shNf/0Ena7ZdlWTrQgGUsqv6wwc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpNvyOJWeeXrRBreOPRyXiTI0Qf2kSr72al+Dh/RqCwIepwSVgYQKBX/Jdusg8pA8xIyYENtXTa6iYIILvNmPXR2oXhidzH6Pt9aFr3de3ZfducJn/eO0W/LM8IYrBJZpVxogZZscXknBj8eJ5EC1KuxQgW249m1zwUjov84jAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Si7ayMY; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Si7ayMY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLnURTqE74cfM5N342F9LiYCqP9gvVdnMPs/FqE2riPTkKORTkSjWdcxmoCN4koAk/bDJ7Q14unRCkexFKPeb3QdeUSXb6R7Hom3lkjBy88JsmCxJe3tGg+mvwjkS62la7yJ6NJs8hh+uGbYqvWCUK2iZuymdRNHJHZsTOhwxFUNnxpu7vAM3u+PRhhhzKpsA38eOo/0Xp+MUoQv1BM+ClMufBsXFooWFZqA2e/m2+XzAF27wwFHVaagpTscTs4XhCUfRv1pXHV4eZRyE9sjtAgWf4oJriA7+bgCgxfooZ0WjCH83rnTUdlFUTvp+MyryesvSy5cJxjSvMPh60bHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WQbPMnYnpg4Cn461+cE8PhyWselLsDjtNbM6Upb7Ok=;
 b=yJp8VLYpD91BG8y+Y7psrycT/ZHD3aKIXsaso4zLrjNq+yLHqkR5AeS4Tm5NV9P+A1ng5vErazYO9b33U2rzJ8HXFEP1dmmi9cjopvCtZV6OGNcasevIY6dudebuVk6ALTJWPULYlR4gZNGsZOKOVgIScV0dXeqyZfYEhvsa09NHFm0BZUaQF2oD+SScgi+AvOeNOJ6+0fx6QZkCpkYbN24xZUIi3+j9XSlqyNB74nSdTq3ayQ0KL7QxeVqa9LO0zFlZVtlnuarTl97j33QNzwrrSaVMEdNi1gOKXfMzdHXCLLRDZcE0+t3eRvUFwiLNNXiFQLh4LWn4/6jXjcdMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WQbPMnYnpg4Cn461+cE8PhyWselLsDjtNbM6Upb7Ok=;
 b=4Si7ayMYC2qaRsR2dI3Ye15i80rd8/oKcDQKxz4FGY8nsisOR1LihMDsd5um3oTt4Tsl8z2vNgyMz+v1jDr2curtpDzc3wFeotp+o4BzsgykGox1KT5D5j4FtumrDHWPIH60JmZCGb2ydQbrwq8ipLI+bqtWfPyLJyH0Gq1hznc=
Received: from MW4PR04CA0099.namprd04.prod.outlook.com (2603:10b6:303:83::14)
 by SA3PR12MB7904.namprd12.prod.outlook.com (2603:10b6:806:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 16:45:23 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::91) by MW4PR04CA0099.outlook.office365.com
 (2603:10b6:303:83::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 16:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 16:45:21 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 10:45:18 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 04/14] cxl: Introduce parent_port_of() helper
Date: Thu, 6 Mar 2025 17:44:38 +0100
Message-ID: <20250306164448.3354845-5-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SA3PR12MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: ef36556a-d105-41ac-4d71-08dd5cce4912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?twJFwC8aCqYaJRkWiUXSWKn6IcQKrTS1G5+eMIcky8oKm3T2P7ji4hY/1SJ+?=
 =?us-ascii?Q?eB6dZau2765SdzQz5KZkW5Pn3HWI0Mt4t/iustL91T4ZFphqceHhh18YyZy8?=
 =?us-ascii?Q?8N2y09zCrqNYdmNzN4k8MpftzJWdO09llzrkxiJdbdTRb4FSM9+XAa4JikkG?=
 =?us-ascii?Q?/IxSXAWRe7JxVwhYHrZLMQrf38M6a8lDzxy/AaoBaYHuKCDEGYfyS4RhN8aP?=
 =?us-ascii?Q?29n6oTxBnH4kYaf/VQYK5kEygPlx+a4uNSAy6pzl8kJRuu1dul1MAr8mDQ7n?=
 =?us-ascii?Q?aWp8MUHssE/YrrvW3RJhxMbLrHtQx9QaeK6TKZ+Q/RcreTxEOi204CMdHY4N?=
 =?us-ascii?Q?7SE3A9v4O/vudBoJxTNIImCGYydflcHWETMfoX+ltsQ7MPx4G4mvsZYYwpI7?=
 =?us-ascii?Q?GErW84S8ewN5TocSq9nb1kUGQi6gTyCgUCFY4rNkkzCGBi9yb42qJrCi+0LT?=
 =?us-ascii?Q?dj6XdosX/+2a78DfmFxIX0s5Hr+Z40vE7FWwHY80nm0iTnGA7YrhssbpM+Lu?=
 =?us-ascii?Q?fUinf76YJ7rfw3tATcbjH6IVsGHWO04zLJeS1WGh8TuoSbFbx6YHnqoB7IrK?=
 =?us-ascii?Q?FrPqM+YSdLvIC7dzayXVndOCvTeBZoMfgj7aBVS7OBlZD98hSh4Wb7oFa1R0?=
 =?us-ascii?Q?6Y/it4v6zSLhHgSzmjtKUikroZhPAJ3OlLtWrHzZIwKDNBMvL1zQrY2Qrf2V?=
 =?us-ascii?Q?5JBpX3J/A+NrJa7EHSB6Y8fcIP+XqzbMESUIDRIQC0G2OcXPz8FIc7lGF4fq?=
 =?us-ascii?Q?N9OJOhqMpUwPkQxDTKbtoNqXiPRjMgT/+/uJlhQPyyVjx7sZ9GV1yQmAfGLh?=
 =?us-ascii?Q?pnRkxWH+usNTZwA2Yg2aW1j4JHJqL3QjiI2+0D6nz5d0V3MnJif+sEN57R1d?=
 =?us-ascii?Q?Zt82r1LBiZq6tuwI66nKr0UNeN5EDFPjztc7Fcgt930m0FXmO0q4plV9D0gt?=
 =?us-ascii?Q?SYis4MwfhBEsNZwBmr2wS3HykOJdregHWwllMqPs7gW9BuBfyPNbQQmHfGuR?=
 =?us-ascii?Q?UEmPQFFY2qwpnyyuGPFPLgu7TlpJG6wKlFm20jgN5Eka0SMRoez8L7SOwE2B?=
 =?us-ascii?Q?BzHFSXufoA9tTdOKOzOIdgJHKnGCu4Mo3oxp65sJSM106/RxASIyFdE4RD8+?=
 =?us-ascii?Q?IRKEI30GmwiNeXMytG1fTBIRvThGRbnqYsyyZiil6QxvltIoaIhZpVDlWZZu?=
 =?us-ascii?Q?C5sYdqS5kFJudOEEWii1KFbicYv3OL4WBYKaOZSOJ8KVrQux0yyYU2giHU2p?=
 =?us-ascii?Q?tw3MvLC0PVm1/0ayo4yZDwA6Nc3nRVN5AcmUvyeoxVZnav5imL4unrGjT8LX?=
 =?us-ascii?Q?0prRXO0JFDlybk+WGz9/BODY9w5/LTRyCJ4JprfhFrmvpayJzQCau1PKW/lF?=
 =?us-ascii?Q?ngjT0h1PbIDuZgRcbGZ6zd12hXXk2LduJkEL45fBmhMcdQUOCQjrl0Aa49JR?=
 =?us-ascii?Q?ar5EE0WwI0FWY6cp0t5BIhEDRqPHtT5NE9cPeYX/FUru43fgFprKqS1Znfkn?=
 =?us-ascii?Q?tYWI3ltGAhIk/Lk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:45:21.3558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef36556a-d105-41ac-4d71-08dd5cce4912
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7904

Often a parent port must be determined. Introduce the parent_port_of()
helper function for this.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/port.c   | 15 +++++++++------
 drivers/cxl/core/region.c | 11 ++---------
 drivers/cxl/cxl.h         |  1 +
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6a44b6dad3c7..25eecb591496 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -602,17 +602,20 @@ struct cxl_port *to_cxl_port(const struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_port, "CXL");
 
+struct cxl_port *parent_port_of(struct cxl_port *port)
+{
+	if (!port || !port->parent_dport)
+		return NULL;
+	return port->parent_dport->port;
+}
+EXPORT_SYMBOL_NS_GPL(parent_port_of, "CXL");
+
 static void unregister_port(void *_port)
 {
 	struct cxl_port *port = _port;
-	struct cxl_port *parent;
+	struct cxl_port *parent = parent_port_of(port);
 	struct device *lock_dev;
 
-	if (is_cxl_root(port))
-		parent = NULL;
-	else
-		parent = to_cxl_port(port->dev.parent);
-
 	/*
 	 * CXL root port's and the first level of ports are unregistered
 	 * under the platform firmware device lock, all other ports are
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cbe762abf6b3..4f79cc17c9c8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1748,13 +1748,6 @@ static int cmp_interleave_pos(const void *a, const void *b)
 	return cxled_a->pos - cxled_b->pos;
 }
 
-static struct cxl_port *next_port(struct cxl_port *port)
-{
-	if (!port->parent_dport)
-		return NULL;
-	return port->parent_dport->port;
-}
-
 static int match_switch_decoder_by_range(struct device *dev,
 					 const void *data)
 {
@@ -1781,7 +1774,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	struct device *dev;
 	int rc = -ENXIO;
 
-	parent = next_port(port);
+	parent = parent_port_of(port);
 	if (!parent)
 		return rc;
 
@@ -1861,7 +1854,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	 */
 
 	/* Iterate from endpoint to root_port refining the position */
-	for (iter = port; iter; iter = next_port(iter)) {
+	for (iter = port; iter; iter = parent_port_of(iter)) {
 		if (is_cxl_root(iter))
 			break;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index be8a7dc77719..24cec16d02a6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -724,6 +724,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
 int cxl_num_decoders_committed(struct cxl_port *port);
 bool is_cxl_port(const struct device *dev);
 struct cxl_port *to_cxl_port(const struct device *dev);
+struct cxl_port *parent_port_of(struct cxl_port *port);
 void cxl_port_commit_reap(struct cxl_decoder *cxld);
 struct pci_bus;
 int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
-- 
2.39.5

