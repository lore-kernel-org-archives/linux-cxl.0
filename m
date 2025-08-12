Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AEB2F068B
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034278; cv=fail; b=XH7xgII+Z7+p0qYy7oPj23Vs3jfa2z8Vq/ci9MKMGSXxv9vy1zJwXRgSdV4g5Wg8tUyYDKhAaVo2qvpps2soKkL7QtHanEPWCgIcBQZn2QbpG7ZBeMDNDEzjIku6ouRYixTjFPHUNIEGChIzyceT0h74fqpmdN2eQyC/ulF5n7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034278; c=relaxed/simple;
	bh=PwXu3DmwCb/lXZV3iBV7L74lxy2P79OiLNxH8w7eDPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Se0FQsmiCyvYDcgbS2p12HOfcyAYLxbiNPuDOsI4lD1JN+U0UmO29fBxsdRWvl2m/6o+Hza4YTZhuJonEfNYyj44NLmQSd6tyBW8qQP17SVb7U7JOOhk0ZSZh2P71n71KYxsazb5zXzAmzCW2tIRcwe0L6It8+lX2V3xwIBsPzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G66XUa81; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G66XUa81"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+kOkPGQ5JOZJncMRme18grAWQ4qkWlbfgtoFRsr4OUyeMv85EXtEIE/8/aUB8OJhgOYt+Q6CTGmmqWs7KZRCeOQhVpuva+c9vgc6DzhhGkUkjktJiCDdJ1TBXZ2D6PpYiWtI/XI7+HnYv8CPzsFlromsLpN8LmeZW0u94HMLtWY91ifZK9ZIWhdufArLl6NxpMJOIPU7iLTftedFy/63KNBTbd9Z0BNtJ5HEpRPcLrI2y6uY5CqezlrsS3kI7cujwRpH3QGgWoriHi+thnQVxAOcBGoLEEf7RrWwNtMaLXkxirqIL5vo96rnNDb5NM1xGf3iUEK8uVNT3NNthNyvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fUeeL/lqUUxudPqQ3YqEaEr38oaOXcVlw1m6Qnpc9c=;
 b=Sa06Jsrem53kovmBjdTGUkJIsa9pO+q6eN5I6Rzf2wb5cMuOSa5nK5vbjad49AL45+mO5Q6cdUsk70QjHF01KqINzn8TryQubuogbjlyh9eHBIV82v06NbHsPqNg7p4+ccCYYJaNxmcYbTj7BrCiHqZbS0lBRVsjS9EKO8p8V5YRfK+fIImUUKXsUFxJMrf27u6C06ZFa5gt4tK5XJ7pvw7KZOnzd+PmgEoCmFcWl+u7SaP6xr0kJm0Wbc3Slr1H0avxPvucJpN1U+OpXqBGAWG22CeutBZRVPg9R5q+jhPAPNyxDoDqYGScjuL4wtEZ/j5pElfUEQnrmxByEfY8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fUeeL/lqUUxudPqQ3YqEaEr38oaOXcVlw1m6Qnpc9c=;
 b=G66XUa81wx0+UzwvZ5wKxR2Kko42FT8JP2GSmL2SJz1cw7eqplNBHC6TwO04CD46BqP3DO9afa/MFyyA2GPGCbZTS1umoDyc9AFCSPxY5xKV7vBhIr8OUAl2uzVAgaJ6Ha6968dxhb7HoyLUUWkeXDmUxuOR2yqKnq8BKOvwt2U=
Received: from CH0PR04CA0039.namprd04.prod.outlook.com (2603:10b6:610:77::14)
 by SJ5PPF816B88375.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 21:31:09 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::39) by CH0PR04CA0039.outlook.office365.com
 (2603:10b6:610:77::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Tue,
 12 Aug 2025 21:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:31:08 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:31:05 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 06/18] cxl/port, mem: Make adding an endpoint device type agnostic
Date: Tue, 12 Aug 2025 16:29:09 -0500
Message-ID: <20250812212921.9548-7-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|SJ5PPF816B88375:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3cda22-72a0-4455-bc50-08ddd9e78d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4zS2aZfKmfqXO6XuB16XNIIIVVXwKdlviI7erDxKcwwzoa6TaenHd8OzMq+B?=
 =?us-ascii?Q?ECoZWoTONbrtaaTRBxEqFPpvmB07KEEMkypEWKmom5Ew+sbfhClScvW8ON4K?=
 =?us-ascii?Q?D60NyCYkNJpxoTLIJht0Qx9cBCruWmZvQsZImTMW4LXBsbEsAavyHZJY9ST0?=
 =?us-ascii?Q?u6XLPyW9cC9pY1inNjIBUkp892+u6407cT3yhhmHe/rw29DzLU7sVtb+Bt+o?=
 =?us-ascii?Q?q9mFOxsDqYqxDGM684JEB4rglCrwa/AexUFXTFPmarYJrSIRFqAMwENyN7lN?=
 =?us-ascii?Q?K7DvGK3CjlhEMBVVnkMQEnyLkeoFnsldyqpQvuVEyjJ1dAj61s/uqA/bVJ9/?=
 =?us-ascii?Q?FJbwbQ6+pJvxQCgYChinDgcFHJdmHFuFqTBYYFvI7AxW7f+YIQYtptcEM3qZ?=
 =?us-ascii?Q?z5wiQjcFCbd9w/YfaZQF/oCLp/VOg8ztbcf5b9uPLITFN4broBnrSnyW+dph?=
 =?us-ascii?Q?HsggEl/qDmLyyYlU8n2JGNT7RCXie4FFSJrwliWAY9YXHMExbGJyqzWT3CsE?=
 =?us-ascii?Q?yy23lZhBQSYuqq9FPecn4vVAR2ypUiqi1BmQKQt4rOUzTsLF4sLlsMOCSVY8?=
 =?us-ascii?Q?JZL7iaIIed0d2zVGzjOqX79Ybr606V9k2+wNZ+DF70t/P2ak/1lsYrREDATT?=
 =?us-ascii?Q?CUSsKLKPpsvEQpPAoCcG/Y0ouYB5bBHtpi/Pq+eAGUZ9A1XJeEG1CDmKuqoE?=
 =?us-ascii?Q?by5gnWIHgC0RunFlITz3/crRPzCF2bKpX+9+Lllk7fT6MjzEBzwfhyaa6CdX?=
 =?us-ascii?Q?FGtVnbivyIVaxc6GJgD86S8Gl0IS45tzMt+Ghb9rUKik2CrVn3+1Z+uTIeLL?=
 =?us-ascii?Q?u4u8JrCk1s+bYE+nrimzFy0ODgGnyN8e+jGJlIApt1t8aaCSHPyby4t7w5zU?=
 =?us-ascii?Q?QmA/xUOaJg6342q5tWO8M70CpR7oCq9H8ScRSAqZWPlswgPPceUW2OJsVteK?=
 =?us-ascii?Q?m6Us58utR4fmCfjaG1EBVWA6sCuQ97rcka/VGHhuGVehAc1J4tpSRAUgYt2y?=
 =?us-ascii?Q?uuFPt5o+Fut9gkrh6y73Q+b1M6ou4aBE1hcEKW+45Vu79N8vTDSXJTX+/jEs?=
 =?us-ascii?Q?VP6u+lAgnexpy2/3p4tbvuDA/+1IY612dyfijRxK2pnuhI3joGCCNTKoDGpJ?=
 =?us-ascii?Q?o63JlMean3mcpp1SjueHnUUuxuEQ2tjClWVKxr//FSbImhzzg6IkueCsVvEu?=
 =?us-ascii?Q?sLDTTgN/dRKzFcel4NMkT8LfPW2H0Ne4nRLyKIwkPs8kyBMECnNw8zOZAcqW?=
 =?us-ascii?Q?QWTb3i729x45j8xEiDx++6avtXgxXUzu7zOsmQCkPoZTUMl5LtWyGl4GF9Q4?=
 =?us-ascii?Q?m7CUdM+7OS/OwpCvkcO60Ov4yGHrAcacliryyZzufEaoR+H3WZBLpeofoSF/?=
 =?us-ascii?Q?oaYVmMpkHQFml+1dOYQlz6UPSCj7Oz1vGghEX+krCzkJWdNfE9vDDg3UsWr6?=
 =?us-ascii?Q?uDB8uT33I3E58HEt7uaxBnPTRQGlns6bFYgJ2bcWkIKOtZRh3YnfpDTkyxzw?=
 =?us-ascii?Q?A+Hw7HCLOKm/fPfTfP/S5qYccFKf4TTpo8J5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:31:08.7806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3cda22-72a0-4455-bc50-08ddd9e78d59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF816B88375

Change devm_cxl_enumerate_ports() and devm_cxl_add_endpoint() to take a
generic struct device * instead of struct cxl_memdev in preparation of
adding cache devices to the port hierarchy.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/port.c | 112 +++++++++++++++++++++++++++-------------
 drivers/cxl/cxl.h       |   4 +-
 drivers/cxl/mem.c       |   8 +--
 drivers/cxl/port.c      |  11 ++--
 drivers/cxl/private.h   |   2 +-
 5 files changed, 90 insertions(+), 47 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0eb406d4a131..5144ddac7145 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1451,10 +1451,21 @@ static struct device *endpoint_host(struct cxl_port *endpoint)
 	return &port->dev;
 }
 
+static struct cxl_port *cxl_dev_get_endpoint(struct device *cxldev)
+{
+	if (is_cxl_memdev(cxldev))
+		return to_cxl_memdev(cxldev)->endpoint;
+
+	if (is_cxl_cachedev(cxldev))
+		return to_cxl_cachedev(cxldev)->endpoint;
+
+	return NULL;
+}
+
 static void delete_endpoint(void *data)
 {
-	struct cxl_memdev *cxlmd = data;
-	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct device *cxldev = data;
+	struct cxl_port *endpoint = cxl_dev_get_endpoint(cxldev);
 	struct device *host = endpoint_host(endpoint);
 
 	scoped_guard(device, host) {
@@ -1463,21 +1474,34 @@ static void delete_endpoint(void *data)
 			devm_release_action(host, cxl_unlink_uport, endpoint);
 			devm_release_action(host, unregister_port, endpoint);
 		}
-		cxlmd->endpoint = NULL;
+
+		if (is_cxl_memdev(cxldev))
+			to_cxl_memdev(cxldev)->endpoint = NULL;
+
+		if (is_cxl_cachedev(cxldev))
+			to_cxl_cachedev(cxldev)->endpoint = NULL;
 	}
 	put_device(&endpoint->dev);
 	put_device(host);
 }
 
-int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
+static void cxl_dev_set_depth(struct device *cxldev, int depth)
+{
+	if (is_cxl_memdev(cxldev))
+		to_cxl_memdev(cxldev)->depth = depth;
+
+	if (is_cxl_cachedev(cxldev))
+		to_cxl_cachedev(cxldev)->depth = depth;
+}
+
+int cxl_endpoint_autoremove(struct device *cxldev, struct cxl_port *endpoint)
 {
 	struct device *host = endpoint_host(endpoint);
-	struct device *dev = &cxlmd->dev;
 
 	get_device(host);
 	get_device(&endpoint->dev);
-	cxlmd->depth = endpoint->depth;
-	return devm_add_action_or_reset(dev, delete_endpoint, cxlmd);
+	cxl_dev_set_depth(cxldev, endpoint->depth);
+	return devm_add_action_or_reset(cxldev, delete_endpoint, cxldev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, "CXL");
 
@@ -1711,7 +1735,7 @@ static struct cxl_dport *devm_cxl_add_dport_by_uport(struct device *uport_dev,
 	return devm_cxl_port_add_dport(port, dport_dev);
 }
 
-static int add_port_attach_ep(struct cxl_memdev *cxlmd,
+static int add_port_attach_ep(struct device *cxldev,
 			      struct device *uport_dev,
 			      struct device *dport_dev)
 {
@@ -1726,7 +1750,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		 * CXL-root 'cxl_port' on a previous iteration, fail for now to
 		 * be re-probed after platform driver attaches.
 		 */
-		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
+		dev_dbg(cxldev, "%s is a root dport\n",
 			dev_name(dport_dev));
 		return -ENXIO;
 	}
@@ -1747,9 +1771,10 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		struct cxl_dport *new_dport;
 
 		if (!parent_port->dev.driver) {
-			dev_warn(&cxlmd->dev,
-				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
-				 dev_name(&parent_port->dev), dev_name(uport_dev));
+			dev_warn(cxldev,
+				 "port %s:%s disabled, failed to enumerate CXL.%s\n",
+				 dev_name(&parent_port->dev), dev_name(uport_dev),
+				 is_cxl_memdev(cxldev) ? "mem" : "cache");
 			return -ENXIO;
 		}
 
@@ -1786,9 +1811,9 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		dport = new_dport;
 	}
 
-	dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
+	dev_dbg(cxldev, "add to new port %s:%s\n",
 		dev_name(&port->dev), dev_name(port->uport_dev));
-	rc = cxl_add_ep(dport, &cxlmd->dev);
+	rc = cxl_add_ep(dport, cxldev);
 	if (rc == -EBUSY) {
 		/*
 		 * "can't" happen, but this error code means
@@ -1802,14 +1827,13 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 
 #define CXL_ITER_LEVEL_SWITCH	1
 
-static int get_hostbridge_port_devices(struct cxl_memdev *cxlmd,
+static int get_hostbridge_port_devices(struct device *cxldev,
 				       struct device **hb_uport_dev,
 				       struct device **hb_dport_dev)
 {
-	struct device *dev = &cxlmd->dev;
 	struct device *iter;
 
-	for (iter = dev; iter; iter = grandparent(iter)) {
+	for (iter = cxldev; iter; iter = grandparent(iter)) {
 		struct device *dport_dev = grandparent(iter);
 		struct device *uport_dev = dport_dev->parent;
 
@@ -1823,13 +1847,13 @@ static int get_hostbridge_port_devices(struct cxl_memdev *cxlmd,
 	return -ENODEV;
 }
 
-static int cxl_hostbridge_port_setup(struct cxl_memdev *cxlmd)
+static int cxl_hostbridge_port_setup(struct device *cxldev)
 {
 	struct device *hb_uport_dev, *hb_dport_dev;
 	struct cxl_dport *dport = NULL;
 	int rc;
 
-	rc = get_hostbridge_port_devices(cxlmd, &hb_uport_dev, &hb_dport_dev);
+	rc = get_hostbridge_port_devices(cxldev, &hb_uport_dev, &hb_dport_dev);
 	if (rc)
 		return -ENODEV;
 
@@ -1852,7 +1876,7 @@ static int cxl_hostbridge_port_setup(struct cxl_memdev *cxlmd)
 		guard(device)(&port->dev);
 		dport = devm_cxl_port_add_dport(port, hb_dport_dev);
 		if (IS_ERR(dport) && PTR_ERR(dport) != -EEXIST) {
-			dev_dbg(&cxlmd->dev,
+			dev_dbg(cxldev,
 				"failed to add dport %s to port %s: %ld\n",
 				dev_name(hb_dport_dev), dev_name(&port->dev),
 				PTR_ERR(dport));
@@ -1872,7 +1896,7 @@ static int cxl_hostbridge_port_setup(struct cxl_memdev *cxlmd)
 	/* Add the dport that goes with the newly created port */
 	dport = devm_cxl_add_dport_by_uport(hb_uport_dev, hb_dport_dev);
 	if (IS_ERR(dport) && PTR_ERR(dport) != -EEXIST) {
-		dev_dbg(&cxlmd->dev,
+		dev_dbg(cxldev,
 			"failed to add dport %s to port %s: %ld\n",
 			dev_name(hb_dport_dev), dev_name(&cxl_root->port.dev),
 			PTR_ERR(dport));
@@ -1882,27 +1906,45 @@ static int cxl_hostbridge_port_setup(struct cxl_memdev *cxlmd)
 	return 0;
 }
 
-int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
+static struct cxl_dev_state *cxl_get_dev_state(struct device *dev)
 {
-	struct device *dev = &cxlmd->dev;
+	if (is_cxl_memdev(dev))
+		return to_cxl_memdev(dev)->cxlds;
+
+	if (is_cxl_cachedev(dev))
+		return to_cxl_cachedev(dev)->cxlds;
+
+	return ERR_PTR(-EINVAL);
+}
+
+int devm_cxl_enumerate_ports(struct device *cxldev)
+{
+	struct cxl_dev_state *cxlds = cxl_get_dev_state(cxldev);
 	struct device *dgparent;
 	struct device *iter;
 	int rc, i;
 
+	/* An error here means @cxldev isn't a supported device type */
+	if (IS_ERR(cxlds))
+		return PTR_ERR(cxlds);
+
 	/*
 	 * Skip intermediate port enumeration in the RCH case, there
 	 * are no ports in between a host bridge and an endpoint.
 	 */
-	if (cxlmd->cxlds->rcd)
+	if (cxlds->rcd)
 		return 0;
 
-	rc = cxl_hostbridge_port_setup(cxlmd);
+	rc = cxl_hostbridge_port_setup(cxldev);
 	if (rc)
 		return rc;
 
-	rc = devm_add_action_or_reset(&cxlmd->dev, cxl_detach_ep, cxlmd);
-	if (rc)
-		return rc;
+	if (is_cxl_memdev(cxldev)) {
+		rc = devm_add_action_or_reset(cxldev, cxl_detach_ep,
+					      to_cxl_memdev(cxldev));
+		if (rc)
+			return rc;
+	}
 
 	/*
 	 * Scan for and add all cxl_ports in this device's ancestry.
@@ -1910,7 +1952,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 	 * attempt fails.
 	 */
 retry:
-	for (i = 0, iter = dev; iter; i++, iter = grandparent(iter)) {
+	for (i = 0, iter = cxldev; iter; i++, iter = grandparent(iter)) {
 		struct device *dport_dev = grandparent(iter);
 		struct device *uport_dev;
 		struct cxl_dport *dport;
@@ -1920,22 +1962,22 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 
 		uport_dev = dport_dev->parent;
 		if (!uport_dev) {
-			dev_warn(dev, "at %s no parent for dport: %s\n",
+			dev_warn(cxldev, "at %s no parent for dport: %s\n",
 				 dev_name(iter), dev_name(dport_dev));
 			return -ENXIO;
 		}
 
-		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
+		dev_dbg(cxldev, "scan: iter: %s dport_dev: %s parent: %s\n",
 			dev_name(iter), dev_name(dport_dev),
 			dev_name(uport_dev));
 		struct cxl_port *port __free(put_cxl_port) =
 			find_cxl_port(dport_dev, &dport);
 		if (port) {
-			dev_dbg(&cxlmd->dev,
+			dev_dbg(cxldev,
 				"found already registered port %s:%s\n",
 				dev_name(&port->dev),
 				dev_name(port->uport_dev));
-			rc = cxl_add_ep(dport, &cxlmd->dev);
+			rc = cxl_add_ep(dport, cxldev);
 
 			/*
 			 * If the endpoint already exists in the port's list,
@@ -1960,7 +2002,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			 */
 			if (i >= CXL_ITER_LEVEL_SWITCH) {
 				struct cxl_port *pport __free(put_cxl_port) =
-					cxl_dev_find_port(&cxlmd->dev, &dport);
+					cxl_dev_find_port(cxldev, &dport);
 				if (!pport)
 					goto retry;
 			}
@@ -1979,7 +2021,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			if (IS_ERR(dport))
 				return PTR_ERR(dport);
 		} else {
-			rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
+			rc = add_port_attach_ep(cxldev, uport_dev, dport_dev);
 			/* port missing, try to add parent */
 			if (rc == -EAGAIN)
 				continue;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3ad25229a48b..c857c112772f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -869,7 +869,7 @@ DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device
 DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
 DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 
-int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
+int devm_cxl_enumerate_ports(struct device *cxldev);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
 struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
@@ -913,7 +913,7 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
 {
 	return cxl_decoder_autoremove(host, &cxlrd->cxlsd.cxld);
 }
-int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
+int cxl_endpoint_autoremove(struct device *cxldev, struct cxl_port *endpoint);
 
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index cdac7bfa2289..c615e6c4ee60 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -104,9 +104,11 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	rc = devm_cxl_enumerate_ports(cxlmd);
-	if (rc)
+	rc = devm_cxl_enumerate_ports(&cxlmd->dev);
+	if (rc) {
+		cxlmd->endpoint = ERR_PTR(rc);
 		return rc;
+	}
 
 	struct cxl_port *parent_port __free(put_cxl_port) =
 		cxl_dev_find_port(&cxlmd->dev, &dport);
@@ -138,7 +140,7 @@ static int cxl_mem_probe(struct device *dev)
 			return -ENXIO;
 		}
 
-		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
+		rc = devm_cxl_add_endpoint(endpoint_parent, &cxlmd->dev, dport);
 		if (rc)
 			return rc;
 	}
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 7d88a8bec8e8..aa6ee6cc714e 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -199,7 +199,7 @@ static struct cxl_driver cxl_port_driver = {
 	},
 };
 
-int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+int devm_cxl_add_endpoint(struct device *host, struct device *cxldev,
 			  struct cxl_dport *parent_dport)
 {
 	struct cxl_port *parent_port = parent_dport->port;
@@ -214,23 +214,22 @@ int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
 		struct cxl_ep *ep;
 
-		ep = cxl_ep_load(iter, &cxlmd->dev);
+		ep = cxl_ep_load(iter, cxldev);
 		ep->next = down;
 	}
 
 	/* Note: endpoint port component registers are derived from @cxlds */
-	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
+	endpoint = devm_cxl_add_port(host, cxldev, CXL_RESOURCE_NONE,
 				     parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
 
-	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
+	rc = cxl_endpoint_autoremove(cxldev, endpoint);
 	if (rc)
 		return rc;
 
 	if (!endpoint->dev.driver) {
-		dev_err(&cxlmd->dev, "%s failed probe\n",
-			dev_name(&endpoint->dev));
+		dev_err(cxldev, "%s failed probe\n", dev_name(&endpoint->dev));
 		return -ENXIO;
 	}
 
diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
index 49c588b95c19..04ec30ab5f31 100644
--- a/drivers/cxl/private.h
+++ b/drivers/cxl/private.h
@@ -16,6 +16,6 @@ struct cxl_cachedev *cxl_cachedev_alloc(struct cxl_dev_state *cxlds,
 					const struct cxl_dev_ops *ops);
 struct cxl_cachedev *devm_cxl_cachedev_add_or_reset(struct device *host,
 						    struct cxl_cachedev *cxlcd);
-int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+int devm_cxl_add_endpoint(struct device *host, struct device *cxldev,
 			  struct cxl_dport *parent_dport);
 #endif /* __CXL_PRIVATE_H__ */
-- 
2.34.1

