Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4347284B49
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034407; cv=fail; b=gOdW4ZbuNjLKDmdzgxruwBewhk9v8WDMUGTpXhGBlAZwTTs3YoiAEwU1tn3WQnSVtRr4uY+c/I4LLTeoi6DrCS23MAtuM4D6stxF7JQCoII7B/uXtbaIRir6NhbtpBZz00s1QJT8BByxeJubOfqmxfBjCpZnYRJteEF+OrpiOfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034407; c=relaxed/simple;
	bh=ZsNZaTL/nM4DWKeLg5/nSKuBWesbfnMeRWvQLgahBoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BO2hXzguXSrgpN1TsXf1TpHb3f1Y6G0Arx1voZdg5lkjMSm1Ob3L8qCEixlnyl+spfTemUjKRc9UAG4dEuJoIuyBG7aDouNVZtjM9whw9fYOWj0BXTWkX8weI2nN3yVMKgeIZWJIZox10y4FwDBBnJgewzF9EKmfSQcaQG3s0Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VC6iKGCp; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VC6iKGCp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxcOOTreG2hs2SSA7RtHc77TqIrl7M7dCRYDPcr9JUmLfYsib0Pwm+Ysu+zNy6Ld+CZKqA0Ew1gpY67gi7VMM9xbFOLfxvNJTdK6ZzKfOoFwx39zYDjVPBnscLquZny9e6mjPwce3edttyi/q9A88ci+nHXfTyyePomstcEbJwONYq3Z/8AJfBpd0k0T199T9PabwvBiBcfgKRmrY9tbpn1AC7zGq0Uis1rcxNZgQbDLg5M08VFMOK6eRvm631mhf4mswu9k+vQ+nYTNb17FO4ChLhDnn1i5AtGRfoU/+BOrry7cQEI7cpxYaeuplA1SuK9f7DULH2RaCRTbkGrKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uuyq5Wx+cSJqCPia0aaNXrIKfpc+tKb82hd0jpbX0Ew=;
 b=pXRyq/DRjSkXCqvQE52b1K6jIQyXUCkAe+Je8utrMsfY19vCKKsIq0cqYMXEmtFKMQPdM/tqbewEpHyKyQTuSw3gEER4DiJUiSG01jEOZ4ppnj87JHhywxiJOw983tVqB6xSSdPkO+g4WBwnxWYoIf6SU5DoQ7k0aGOcHdp4Ae/rCq8kN7rMPjU64dmQ/G3UNeHWShsZPHkeRG6IWkp0tjd0i++dAGRanu9M29/asUtAZ25NJztlDcPYv7FBX2Nsy4cYYq4WETQwLc3W8D3JSiKLmRCjO08LwbU6DwO1g6K37MjEazBieBWCnLhGBdtMAtIgvP3KykBUjG0ryshZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uuyq5Wx+cSJqCPia0aaNXrIKfpc+tKb82hd0jpbX0Ew=;
 b=VC6iKGCpD+EuPc4r9dGk7CBx65Be3xSat8kS+fk8VBhXra8pExNOBG8RfV9Pb3bGy2TcZwwjtMcDxVA2HPxhoRWpqtWPIaGGcbeE8y9KKxwp2T2Ko2oragPBCBOJR/Wa9wmcFUury9gWaad3kfCnvle+7GYVMYqjywpSVAjd88w=
Received: from CH0PR03CA0118.namprd03.prod.outlook.com (2603:10b6:610:cd::33)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 21:33:23 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::63) by CH0PR03CA0118.outlook.office365.com
 (2603:10b6:610:cd::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.23 via Frontend Transport; Tue,
 12 Aug 2025 21:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:33:22 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:33:22 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 16/18] cxl/cache: Add cache device counting for CXL ports
Date: Tue, 12 Aug 2025 16:29:19 -0500
Message-ID: <20250812212921.9548-17-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: f7610d20-51f1-4db8-da78-08ddd9e7dd41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K8O5ddQGuE5k8guJJFjsg++F477reGKlpwyPhCUNfYOCX4mcoHHVDnmGHmbn?=
 =?us-ascii?Q?LTyZKWggC3AVaTtE7mabTBXDsvRqBbDB4mbpxpH3d2AmJ0/F4NqWjkzZi7eg?=
 =?us-ascii?Q?Fpx3xAm362VFwa9Yy8Rzq+QMISJWeI9IKC2kjVe7Ru71lqJHAx7uGDSaxjq8?=
 =?us-ascii?Q?LT57NKnjKCkzd4LKxOcax41/N+1mlsjawYgsDqcK6RruZuLDLX0kCSuyaTVh?=
 =?us-ascii?Q?c8UXrsvpgXR2rcDxKf3YrkgNHkFV5GudVC5RFj4jm3LZoeLM3bmuCObuwse0?=
 =?us-ascii?Q?RmrusPGa9xPfETcM4sULenS2o+vA5XmevzPMdqKirSgUY0bdY3uKl99gM598?=
 =?us-ascii?Q?GN42mlxyC+nXfw81k5z0qg3sCLFaZxkQabLoWrMZuwdqbD79TC+id5Hz5/Mn?=
 =?us-ascii?Q?o7+3lVgULXlHAAQvb6zqBPQopPN4cBKWMNR3fwGN9aAPnVezVd1JnRwg+I7S?=
 =?us-ascii?Q?cQWM00qeTAdU/Ssg2NF3B6/9lTY0sK8KAxrywW1HQysS3krObwZ+No4v2rQ3?=
 =?us-ascii?Q?Wj+OnD6gDxVSNpXzs5/jANVjZ2JrINrSyLvovs43b32Syv/RRFH0/3yvVDVH?=
 =?us-ascii?Q?fIE/+idmEhth7lstew30ydaIdM6QRhb7gEhpFXOFaqU8+g2psaV8ECeLeeqU?=
 =?us-ascii?Q?IUL6Qx/JkgSn08mMTupa2wEObUqGlt+XHSUQ74TUs57kpTEKs6LlWBugpGbe?=
 =?us-ascii?Q?W7ZZRNW+fCUF+j6aUr6+URly8c3gsCsdw82rQBAcHYuuVNd4JvZ1Q/l3ekEP?=
 =?us-ascii?Q?hvxcue5r1foZITxfbz4fgwHBnPKBFskBDcobUfFMIz+1m5ftRZyCAXIgVQAX?=
 =?us-ascii?Q?54jMWvguCb98B1OcvccM5+SKN/aispN2//fYjS6y9Fi+AMezrGXM+jiivPZR?=
 =?us-ascii?Q?6L9viKbr5Zmz9J+siq3v2MnmjsD1+bh/j4ScL6dki5wkaGAGF74eEOEzz1Bn?=
 =?us-ascii?Q?jnmla/MrynxdEm4b/2iAT3ZBPcPmeul6H7zeXQjuX/tSiLuNNKlgvubkFiWf?=
 =?us-ascii?Q?v4Ff21YrFDHeVJYSgAYrjoUSd2zhV/Q1ovtk7qVY3GKv6NKfzHiftSZam8d8?=
 =?us-ascii?Q?6QEo9LCh4hk46H2K00OTvDhCPEGkGkoyE8r5kdluXhtVDsK4+eTV8ti+vnmU?=
 =?us-ascii?Q?YsrHrh3ikzWpgq46/+YcpGlIvEA+91negPFLQbWdc+UyZ/+ACx0VSa9LvK6j?=
 =?us-ascii?Q?T0132eMwwFfwi6fFVp3BeGqXv4gdFd9Y/CMIFQup4wVsbOSwIYzEiayCIlX9?=
 =?us-ascii?Q?Jk4t5Ob0dMS21v84LLS0gHZ88FZ7kJKEjqqwq93Qb+4e2ThYIwFavxoUhYjI?=
 =?us-ascii?Q?LF4R0vQDSjzLvIGPoSwbZ6dUMzYHV1XhELJGowUgJH4FH+Gx2yiUKFbh+PNK?=
 =?us-ascii?Q?IDU91vwb2RZxloGh/Yh7yv4DUQon6n9j07UJQWBQAvbJIiXeHGxWR/gRVAeY?=
 =?us-ascii?Q?L142n5i5jcbS++ZBkZvnwrycSlf47OTrjRQtAXWBdq8ms2i6QZH8d4OVTvl7?=
 =?us-ascii?Q?A+dEC/kvXB8OmJZrmXal7KuqUqw9mwJ0nyCY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:33:22.8415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7610d20-51f1-4db8-da78-08ddd9e7dd41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207

Having more than one CXL.cache enabled device under a port requires CXL
cache id capabilities (CXL 3.2 8.2.4.28/29).

Add tracking of how many cache devices are under a port. If the required
capabilities are absent and more than one device is enabled under the
port, fail allocation of a cache id.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c     | 42 ++++++++++++++++++++++++++++-------------
 drivers/cxl/core/port.c |  1 +
 drivers/cxl/cxl.h       |  2 ++
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index fa3223165a18..886f9794472c 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -62,8 +62,12 @@ static int map_cache_idrt_cap(struct cxl_port *port)
 	if (port->regs.cidrt)
 		return 0;
 
+	/*
+	 * A missing Cache ID Route Table capability is only an issue
+	 * if there are multiple cache devices under the port
+	 */
 	if (!port->reg_map.component_map.cidrt.valid)
-		return -ENXIO;
+		return port->cache_devs ? -ENXIO : 0;
 
 	return cxl_map_component_regs(&port->reg_map, &port->regs.component,
 				      BIT(CXL_CM_CAP_CAP_ID_CIDRT));
@@ -71,19 +75,11 @@ static int map_cache_idrt_cap(struct cxl_port *port)
 
 static int map_cache_idd_cap(struct cxl_dport *dport)
 {
-	int agents;
-
 	if (dport->regs.cidd)
 		return 0;
 
-	/*
-	 * A missing Cache ID Decoder capability is only an issue
-	 * if there are multiple cache agents in the VCS
-	 */
-	if (!dport->reg_map.component_map.cidd.valid) {
-		agents = atomic_read(&dport->port->cache_agents);
-		return agents > 1 ? -ENXIO : 0;
-	}
+	if (!dport->reg_map.component_map.cidd.valid)
+		return dport->port->cache_devs ? -ENXIO : 0;
 
 	return cxl_map_component_regs(&dport->reg_map,
 				      &dport->regs.component,
@@ -136,6 +132,19 @@ static int find_cache_id(struct cxl_cachedev *cxlcd)
 	return devm_add_action_or_reset(&cxlcd->dev, free_cache_id, cstate);
 }
 
+static void cxl_deactivate_cache(void *data)
+{
+	struct cxl_cachedev *cxlcd = data;
+	struct cxl_port *port = cxlcd->endpoint;
+
+	for (port = cxlcd->endpoint; port && !is_cxl_root(port);
+	     port = parent_port_of(port)) {
+		scoped_guard(device, &port->dev) {
+			port->cache_devs--;
+		}
+	}
+}
+
 static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
 {
 	struct cxl_port *endpoint = cxlcd->endpoint, *port;
@@ -167,9 +176,17 @@ static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
 		rc = cxl_dport_program_cache_idd(dport, cxlcd);
 		if (rc)
 			return rc;
+
+		port->cache_devs++;
 	}
 
-	return 0;
+	if (!is_cxl_root(port)) {
+		cxl_deactivate_cache(cxlcd);
+		return -ENODEV;
+	}
+
+	return devm_add_action_or_reset(&cxlcd->dev, cxl_deactivate_cache,
+					cxlcd);
 }
 
 static int find_snoop_gid(struct cxl_cachedev *cxlcd, u32 *gid)
@@ -239,7 +256,6 @@ static int cxl_cache_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-
 	return devm_cxl_cachedev_allocate_cache_id(cxlcd);
 }
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 3606ad557bfb..f9f1f0ff08c9 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -618,6 +618,7 @@ struct cxl_port *parent_port_of(struct cxl_port *port)
 		return NULL;
 	return port->parent_dport->port;
 }
+EXPORT_SYMBOL_NS_GPL(parent_port_of, "CXL");
 
 static void unregister_port(void *_port)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9c475d8c1573..c67da9a378df 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -646,6 +646,7 @@ struct cxl_dax_region {
  * @cdat_available: Should a CDAT attribute be available in sysfs
  * @pci_latency: Upstream latency in picoseconds
  * @nr_hdmd: Number of HDM-D devices below port
+ * @cache_devs: Number of CXL.cache devices below this port
  */
 struct cxl_port {
 	struct device dev;
@@ -672,6 +673,7 @@ struct cxl_port {
 	bool cdat_available;
 	long pci_latency;
 	int nr_hdmd;
+	int cache_devs;
 };
 
 /**
-- 
2.34.1

