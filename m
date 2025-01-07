Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C081F3D2A;
	Tue,  7 Jan 2025 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259102; cv=fail; b=WgccJmpvoSogZVZ3gECewpL0GfviUC5sis37nGMLveXkyYZdWWv5Xvkwx6Dm4Fa2TgJGorurt1aqdJsORUF/KdkouPoprICYnHMr5KMUbWE6TR71qAFgaWDc6naPpGZ7T+sfAZfiuzvZrRgpbM2iTy5pG0cmkcgHv0Us3VEl2JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259102; c=relaxed/simple;
	bh=9Cy6ikxcE17B56wVZ4hytVBZFYAbBnPuJs6LAxcViww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpY43B2wprjmE1N+KhXaExyLUJIEsQWitNsT6Nu1qtpS6KHmG0ajbhTSUn2Go0F3HggUkgRDVuuHNL1oAyNDuHxh0IfV0SPBv8d41l4Y6VJsEKZ38hmzMwUzO6wmOqSoLHSCerKae/NosvhbmSUEsmu7HZgjZIl1i0yVQDSGAkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NIQB/+S9; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NIQB/+S9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htxCQDdViHSlBWLl8c7ExEVvmHEwLb6B78PUKvn8vx1HXJ3SwI3hNpchmOPFKPoBurgh5xCn93+EdqctTBnUukp1S/5ev1FxG0GNayBfCb2du0rDQd5DfNV6jviJnjH1QWMoKaBDkvZBWPy85aKmA1RW4NsT3DDCN0LLexC1wDNPE/cEjgle8Q5tFAL2iyG22lRy01ArZyePnxLa3tH69FETyG9/7NVjLpazlodxV+40q7Y9uM8cBefYJT/t2PzxY0mAti/cHpdpLZLtMI0veGLRHMIrtCZ0EJxxyWY4ZT/vc9ZPVmIvsboeDyg9hnPqraVc+CUIvxsy9o9YT3lOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oyw96nJ8ualpu+Bsk4Zu+3fVycxPgQ5EQrwHVhG9FRs=;
 b=ugi/bOmTk3GlOpPZfFFt1W/5Wz4WAaOX4u65LoGCgVGeHvz0+q+cBsMk1p45YJT9vxdUf9Ebj9PavetqREqlFnQH5QkysG3qqSPZL/6Ia+IyZSW8gkKussfuS24S/B0MZsnNkaXprYuERdIJr8cOW/2TkrBZFanoDgx0r3e89Zi/m64+VRjwZnIFEPv3lVF8XQy8wsxMnvXZIXOcllNR2kS6b/orh23T853g7dUJQgQWChYcKmRxpAH3ZU4X7N3t5svK47PzPY47tJF4Q8PnR/9t9fuaxoH7wQhauUnk+nd5aMDLpXCU50GhSPjYotGDI5f+5h1j4OSSX5f9DG7Eag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oyw96nJ8ualpu+Bsk4Zu+3fVycxPgQ5EQrwHVhG9FRs=;
 b=NIQB/+S9q3dEJ+6FaWayv6vr8/kRxEyLB4J/Ym/9Yy3PpJrPtuDSMLZ7PJ3Ejnap5ZsOh8pzD3z72sdYorzyEEcHjCCj5w18tn5OabydeC/fMTNZQqLD+85TAuoViRYio0Ool83PzfJIu4mxWeBvq7fjQ8NqLV9wqXYbn5oaVDM=
Received: from MW4PR04CA0069.namprd04.prod.outlook.com (2603:10b6:303:6b::14)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 14:11:33 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::bc) by MW4PR04CA0069.outlook.office365.com
 (2603:10b6:303:6b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:11:32 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:11:29 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 14/29] cxl: Introduce parent_port_of() helper
Date: Tue, 7 Jan 2025 15:10:00 +0100
Message-ID: <20250107141015.3367194-15-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 7253a726-3f2e-4f17-39f5-08dd2f253073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wMxWluFhNcfWtbraqhJS139/1VWStR7fmA0oMbCStorQBt/ZQjDZP3e+XmgM?=
 =?us-ascii?Q?4ciQOf+aeT7weQTGUuNnTbBHLXdy13iPz9Xe+V5OcFK7IflkW4cJVvhTesZe?=
 =?us-ascii?Q?JCYy5enNWJhfMm9l6SG3fsR6ncRN6o253a1VVY2o7UHcM9GTeKsMv99HSrc7?=
 =?us-ascii?Q?kEBOvklZyiaYltrx/gTx/BoWhbSMESByNYNdMy5kdhZy4GZVXFtIuee4SqCV?=
 =?us-ascii?Q?KnUOX3mnOHTTC24+O8QJ6maBLQ3WJ4gTsDGLkwVAZXYDUHAxR4ohkg8CDF5c?=
 =?us-ascii?Q?wl7jY5nlmctJ8J6we/G7JIIofnwf0MAsVjINPNdxTvcrdWT1k8W2sCj4E3x4?=
 =?us-ascii?Q?C2svO6TOC0YYRyGcaruhvB1atFuTFcPddpFjC+vRjch0DSqS0YB9jEdKhaJh?=
 =?us-ascii?Q?NJbIMQCeUmkKY5bjLxLvYYtVr230fbA4gdmyRW5WzJUtxEohc62bxnPWhGsC?=
 =?us-ascii?Q?g8AjKY2VbT6CjOcC8Izhs38is3dnxx4+xhwzE5R3uBeSOCxUVOl7wJzo2x2L?=
 =?us-ascii?Q?Jj6GytP1QeAkeDc1LlRgb+eJyBUgn8BUZwiB/xLLZHeVGHXbcTqm6V0ceLdY?=
 =?us-ascii?Q?chUIiBKQj53eft2rPBmoRhtbisDiQO2c7onVotXcYQRv83AGq6vOQixkjuSk?=
 =?us-ascii?Q?nZ/at13XPd8yf/obzBIukhEIlfDJab3nqIhr6r/O7O6Q70mKdvmF5wHImImV?=
 =?us-ascii?Q?3dAhlcwioqU7daXcN+RsQt6b+uYtqtl/O2ML8CGvXmGjk+Q13WHcs5IiCCao?=
 =?us-ascii?Q?AYZXx64xCQn5wenwMQv97WOm6Ig+rnmsuQXWCbbXSPNAMR8wZKxlq5SqihES?=
 =?us-ascii?Q?/cvl+dSLfMvfom3xiUACt9yUM/gpX3hQudkE4qQa3By+v/H9Ig48QW4yjcwz?=
 =?us-ascii?Q?aNB/KX/sgWNaFAQ391FKesPObhf3rixWi7nMEEo7MziZVMuepUYkwih4HCf+?=
 =?us-ascii?Q?g/jlKyettiSJVlAULg0/5b005C56O3clF2REwYKnV0KYR84tcKi4JtWtqJT7?=
 =?us-ascii?Q?3dmZFjc3RVtdWGRC9NlZHxGxoVPgMCRpTeJqluyEdUHTfyDBS2TEA8fGb61J?=
 =?us-ascii?Q?8Ivb8tfk8LCGgZ0huaV8isuz2fJGOMELKVgB0hjBBtVkjdWF2S024MC8FHcQ?=
 =?us-ascii?Q?H1VfRdi78hhLeQLY8j/5HqykFaM1XGjW+Fw+oTp9Qj5VTHoLRWcOj65j7Vv2?=
 =?us-ascii?Q?YmmmEH0dL1vAO0pCgmaeF5NBsk9VuhZGQ5qxF4tUNL5I1tqew4ZXo5mJzv80?=
 =?us-ascii?Q?dlkM+cdQcnFaFxwSqKMcjf6VGOgYRQSBizZ+EcBYGsG9TGdvzPtPyK3V2mfD?=
 =?us-ascii?Q?rrDTPFNp/1bfBtSZe2R56S4f+SWJgNAbOaxuaRzHYdgaka7nDbK2gdYbnDtX?=
 =?us-ascii?Q?N8b0a4GoZ4ybOrnEk6YJme3EIXXzkDTSCtgfm6F7KD4yXxLt/BAuik/inqWB?=
 =?us-ascii?Q?7Do2fEaw/srVhyu33ssoU7asnmEC2hCUhFcF0FqmVzMB7hQMzjrFKQEgCmnS?=
 =?us-ascii?Q?1ssJqNU1QzV5Vvc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:11:32.8069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7253a726-3f2e-4f17-39f5-08dd2f253073
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456

Often a parent port must be determined. Introduce the parent_port_of()
helper function for this.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/port.c   | 15 +++++++++------
 drivers/cxl/core/region.c | 11 ++---------
 drivers/cxl/cxl.h         |  1 +
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 78a5c2c25982..901555bf4b73 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -596,17 +596,20 @@ struct cxl_port *to_cxl_port(const struct device *dev)
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
index 9443507ed4e1..09a68e266a79 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1726,13 +1726,6 @@ static int cmp_interleave_pos(const void *a, const void *b)
 	return cxled_a->pos - cxled_b->pos;
 }
 
-static struct cxl_port *next_port(struct cxl_port *port)
-{
-	if (!port->parent_dport)
-		return NULL;
-	return port->parent_dport->port;
-}
-
 static int match_switch_decoder_by_range(struct device *dev, void *data)
 {
 	struct cxl_switch_decoder *cxlsd;
@@ -1757,7 +1750,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	struct device *dev;
 	int rc = -ENXIO;
 
-	parent = next_port(port);
+	parent = parent_port_of(port);
 	if (!parent)
 		return rc;
 
@@ -1837,7 +1830,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	 */
 
 	/* Iterate from endpoint to root_port refining the position */
-	for (iter = port; iter; iter = next_port(iter)) {
+	for (iter = port; iter; iter = parent_port_of(iter)) {
 		if (is_cxl_root(iter))
 			break;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 49280e0f8840..c04f66fe2a93 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -741,6 +741,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
 int cxl_num_decoders_committed(struct cxl_port *port);
 bool is_cxl_port(const struct device *dev);
 struct cxl_port *to_cxl_port(const struct device *dev);
+struct cxl_port *parent_port_of(struct cxl_port *port);
 void cxl_port_commit_reap(struct cxl_decoder *cxld);
 struct pci_bus;
 int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
-- 
2.39.5

