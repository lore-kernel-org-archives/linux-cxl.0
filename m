Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E01F8904;
	Tue,  7 Jan 2025 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259111; cv=fail; b=s8fzECZ1OVa93zT6UtmFgW/ojmMuJMv5iCtk2KyA65+bC573VKAlEOPuqpNyMikqp/zr+632Ne7Uf3PxRxhR+aNMl/WlnYjfBAWhgQAf2sy2vZTO4RZyRZdTCcV/ZuLfaA22zgShQBE2oaFexjucd9liamQoaESkBJa4zJP41GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259111; c=relaxed/simple;
	bh=qxbk5t87FOBOs2H06OOlmOEJT1gIjXiYBQYD+xrA1PQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ps82JgcfYSy8fM4Au0i3Q6dXOtPVTxvlsCyGW7rKV00f0CLpefHNWLqmOMCZXx5qf1IrFjRrO0hc+u1fr84nOS1ZqiKZjAxwMO33mDsPDyaTjTrCQEG6Q/ifBcXT0UdgUgO8WekanQ/wO9u3zdrq2WK3NpvWEvW5//hFHQbsY5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Pcd4WI7; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Pcd4WI7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAvuAMZUHV7NitW73a1Pc0pJVo86uq8AfskdGRfE5yl5MEoqQQ1zC4eihC1Y2/ecOcEQM+SFPERu2yk+ObIbrjTOiJrWvaykyEZojnWuLYengjsjXYLfiiRZK/9wZwecAK8THMt/WXLKf3oQaWhWCdSBM3yah+Ka+8yuOnVgTUvyVTYUx8ZyNCZQzYw/8cbY6TftYd5Vhf/udhJxuBlOcuEQW5oTm3b9ulybvXIXcLXRDVxaUUp0pZHOF3a3Dq+ZPzCnM61UA94S5uu+zobDhuF6pLJtZ6t3vdGDRm2BASRqtDaiJJTNGygDY3vMSfxZAShBxe0cJ89I++DtuLnLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwCzteXW8+AnvM22bExdiW5RNlXlDsZTDKHqmWsqbD8=;
 b=Znhn1ac9pg+Bgh5rwDejrm/L+BvxC1AvkQOTIImwafjc3RLn5YW5g0PSL6RAcmmY0n9YsSPJRM9F6/Tc23lG6IYiC+PxK0YgqNGRbX1cRhzeV8KVQz7AVeK2DlHjpFdqlpXSi/nf3dhFuHxPsWjeYUbaBnRvUaSq/hOtM5fHUppoZMtlAInF5dVibGeDRRJYiA/3bGhsDZe2Rcv9Nui4CvFtcZfqZzHKIk92SzHnM56EnNLNoxDn8S6xuNBxeU2h8XfIO+RWG7cWFQ/TQX2+6xTA18U0F1KwH/Ig09hacEPn+4OWTIGgeMG21RVk6/G3wT6iS+nbBWrgfQZlz4iDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwCzteXW8+AnvM22bExdiW5RNlXlDsZTDKHqmWsqbD8=;
 b=4Pcd4WI7OcV+YVQzaMx+BBlUDeMnPGyohLD/B3F7EbxgkqsneO9+bMn9DolVDM34eA6cPZZb28+seA66ugVoWYT8qMotGtp/7aypcOhaUn+Bx/PPf2DYAskLTrT6C8EDb5WWXkEeb8bpVkqrPK8ProEv9uiKmSwKQHLhnjTFpN0=
Received: from MW4PR04CA0087.namprd04.prod.outlook.com (2603:10b6:303:6b::32)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 14:11:44 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::7c) by MW4PR04CA0087.outlook.office365.com
 (2603:10b6:303:6b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:11:43 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:11:40 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 17/29] cxl/region: Rename function to cxl_find_decoder_early()
Date: Tue, 7 Jan 2025 15:10:03 +0100
Message-ID: <20250107141015.3367194-18-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6fbe1d-250e-4785-679c-08dd2f2536f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SsW3W5l/FY9ta6bnyqoa0WTECZQtNptAVenMXHBb9J1+jj5EgFp6QHytHaeJ?=
 =?us-ascii?Q?yULnVUd+Ql6mOGHMTWxnze8PmXc/I2kM2dr/uKx8vKMrk23wYul/Zfr7BJho?=
 =?us-ascii?Q?35HRByv8mPmSoAAQn+7tUiRJG5XlocTDr2EcVb+rXWA5Duvf7o22/K8mHZSN?=
 =?us-ascii?Q?5OAJlfcbeKA3pw1aNfq7cXF4POMw6WJyuIAOM5FLGaNTL2UDI3Y8u/M+64br?=
 =?us-ascii?Q?3qO4BZAwoC75uX8zMjzqMOfHaEgfUW4Bveb9m6u3+C4ufgOgs94lpUiN7C/5?=
 =?us-ascii?Q?yfxqUVEkdilopldpXD0z+HDLIwVeMu/Ok48NhlanaFFsAEYS9B+GIo2XWzOs?=
 =?us-ascii?Q?sMIuqTHTwW7oDZGfEIgazguVPpIDsUkMvZk0PVdMknBmUTc0ixbulzzv/hiv?=
 =?us-ascii?Q?TF5GscfKJVMWwy4GYg1h54PyP+KXItd+MlLkAnQvqkFZDn4+ixq4+zsfOkqa?=
 =?us-ascii?Q?z3yrLYE/46N1FEiQU4VrglZzoqUe6Dj+wk2c/9Ij9CNy/ErtRJi2dcUMjX1/?=
 =?us-ascii?Q?3L5eCFJqftHJcQYlxPBa14X8vOUs4GevRsWdK3Qit5R8aHZYDA9c/3rK21ZF?=
 =?us-ascii?Q?lgAUXj7BnSlROlHAFu70+ezze8/ssA7UZF5ZmumnzxNT2sspMgkJItQbHMGz?=
 =?us-ascii?Q?D2mxcyfX+Tj86RWgA+exC5BvNbER8czMdjH6hIACnnqNOgyoEKBj0ueXXzyg?=
 =?us-ascii?Q?GyCzTn5EX/tLqtt8MZQzNf/lPaB/Ng9K8y2p+KS81fi2xoCOSUbRXav43MD9?=
 =?us-ascii?Q?coBns/Fpzp6EkCOFMJyj4DVNxuehJpVslhxSZVOW7Fm2qUrcqBGvaQIQ2G0F?=
 =?us-ascii?Q?pPzUy+GOIO3QSOKIb/+HBE7mJtCuUut+RtrzvolLBIhilJOb8qCar5ovP2QW?=
 =?us-ascii?Q?NmcALfkK3cQGxt+4vy2rxqyoQj5wkwhcbWcx2G5loi6hE2dVd2hIbckfs78N?=
 =?us-ascii?Q?Ysn2SzUuu6m4iQxWyojstlEDujlePaB2/ZOhkVTq3OV5js+XinCXOffV/sNV?=
 =?us-ascii?Q?O6QB+YYFsnoOae32BqCM1HNlAA0bufUH7f5TnHn7Bn+Et55AuAgWuPyKxWGS?=
 =?us-ascii?Q?wCTvNVzqKRU8lxC/CGBDoMbWCM+sNI6eNbonsin0Psb2YtCPZhRaOZWPiPoL?=
 =?us-ascii?Q?HmMibjKjCcHcRfS1y9RwTiz3XegUa279bUtYGtw8rCUWaEa2eBKIo+4/gcxB?=
 =?us-ascii?Q?wJsg4HNyhfKTdMWJ+m/TjJb6wsnbPf33T/jTLSIpPK7O+Cd+s9g+5lugzHgD?=
 =?us-ascii?Q?zFAA464VAzNBt5O57c5rawchNh2HSJtfCT9c2nbsquGRuaonB9kvE/RNNQkf?=
 =?us-ascii?Q?0xP0Veo13njhZbLH9YE24jJe5TdcSCxHN/pTHhu6TeWGqVhiwWrrAoKDKkD5?=
 =?us-ascii?Q?C4ifS4rUZclX31KZPo73iDh6AF3I0RTumFDHVBKe0RSXKO7+9bxEXThMGDD8?=
 =?us-ascii?Q?sdtvXu69HJP5qx7znx8gl5iQAneZG4S3NO1Sohe8Qip3hGkiSWZQCcIQJvR0?=
 =?us-ascii?Q?pUS2HLF6FoATWZY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:11:43.7132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6fbe1d-250e-4785-679c-08dd2f2536f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408

Current function cxl_region_find_decoder() is used to find a port's
decoder during region setup. The decoder is later used to attach the
port to a region.

Rename function to cxl_find_decoder_early() to emphasize its use only
during region setup in the early setup stage. Once a port is attached
to a region, the region reference can be used to lookup a region's
port and decoder configuration (see struct cxl_region_ref).

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c1e384e80d10..2bc2028988d3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -878,9 +878,9 @@ static int match_auto_decoder(struct device *dev, void *data)
 }
 
 static struct cxl_decoder *
-cxl_region_find_decoder(struct cxl_port *port,
-			struct cxl_endpoint_decoder *cxled,
-			struct cxl_region *cxlr)
+cxl_find_decoder_early(struct cxl_port *port,
+		       struct cxl_endpoint_decoder *cxled,
+		       struct cxl_region *cxlr)
 {
 	struct device *dev;
 
@@ -944,7 +944,7 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
 		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 			struct cxl_decoder *cxld;
 
-			cxld = cxl_region_find_decoder(port, cxled, cxlr);
+			cxld = cxl_find_decoder_early(port, cxled, cxlr);
 			if (auto_order_ok(port, iter->region, cxld))
 				continue;
 		}
@@ -1032,7 +1032,7 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 {
 	struct cxl_decoder *cxld;
 
-	cxld = cxl_region_find_decoder(port, cxled, cxlr);
+	cxld = cxl_find_decoder_early(port, cxled, cxlr);
 	if (!cxld) {
 		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
 			dev_name(&port->dev));
-- 
2.39.5

