Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF31205E3F;
	Wed,  5 Mar 2025 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169317; cv=fail; b=tF5dzN+CSREB2lMHbRrnD+rq9EVm+dbbCjIQwK3zinl/g5+uNT20aEM2N37kt8YPGeCETR4YjdVp2IPPy8yqhWa7PdufBprg1Fd8KhQOVd/IXiRO+dD4cUSSGHRoh8wg7u2UM+z44fJhttNOJmNG/BikUjc0ZygLxkJDBbyHMB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169317; c=relaxed/simple;
	bh=NCdh4bIK0E19UuMICkPNaXzatFCb2nxa9oLxPGoQNCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTHFJO3ax1TzARGI1NSuGScn1mwYzmJFNr5mPHW0rjMaCnn7QNl8Dtr+PsEcEYIZ4vz92e4bfuSFgp5Xz+b3aDpiJQkCUzKVakjo9Ml6V6aMXM87pIyE81QWbwGQ5Uk7PUb6MfBzDTMJdiED5Cyii2scnOc6fTtQXoh+D8s6b8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CtwnrpyC; arc=fail smtp.client-ip=40.107.102.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CtwnrpyC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRCjCLga7l5hqgDSsRNOWeQV+2bbRHG9ksL9oM6sTAvLNOUyddZnslNOxLXv9m+66yaTRy7XDqZkhqw3JEXpsrE4ZAdYqQn6u529cG3OfcF6kKBRRWZXqO7fvOqL9ccWdGjNsICiPcuH7ZTiRYx4G7JFvUVAQlFCvhioKSczVDDVqlKKzzTQ/KI6U3xxJlyjhuOHL2prlBqKAwJh5PGEPuHj2Wbo1BSWhXs0Ff3H1hPmAw90gLK3lH0kpyYQ3YPxIYrsA/HYH4rhKY3kkh0CTVLNYNeY8b5RbVug7vi0vJ35lf66CieW3pwoN8oi91c4df3lpRpyk471bncnH6aP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTWzWg5JDuBJXVDjel5VKDcS4yVvgVRkpUWOQ369gvo=;
 b=jeJ/W+n/GQX0MOV5NEmQ9Y20leP5lQQbzfVr0PuUSDxloCZxVvbLvhJ+N5hCskKqmfdoeSoezlcO/mZKndEKqF0W318CpY77/pjLgeKQlPRXQjfAN2lGj0/ILRSV1Ordr/ikd6w5NH7CxGf5N/7gb1xz5PR70I6sQpLiLHywMGzirY2LO7gp2sIW1Yj+aStdSYyiE4PAsu1gU/V26i7FT6LjjID4j9fFBhHNXdXeFeKoI2d2NMPy0Brwmn2NwHR8jlpLV2WCr1MfOaczvFCOIcu4CB/oZNDtCQuHyjHIiJce0apB8AN9Riq0KYtIHJGCAkq5n1tody4EjH/CpI0ZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTWzWg5JDuBJXVDjel5VKDcS4yVvgVRkpUWOQ369gvo=;
 b=CtwnrpyChfxAPBxEH4vqB6ueVsoS26URWdcBIeZoBRDbxYlQUKQxhLX8Fge/wYOTp8Am7obuqbgPGnS2jV/JKAkoior00yv7LtZuPWxIctcBROJ/nHjVQK0tUgsxibGfxfhSlx2SCP7zLAihakYgYu4rbcxnkBtfcHic1kDT6lo=
Received: from BY3PR10CA0013.namprd10.prod.outlook.com (2603:10b6:a03:255::18)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Wed, 5 Mar
 2025 10:08:31 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::6e) by BY3PR10CA0013.outlook.office365.com
 (2603:10b6:a03:255::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Wed,
 5 Mar 2025 10:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 10:08:30 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 04:04:15 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, Terry Bowman <terry.bowman@amd.com>, Robert Richter
	<rrichter@amd.com>
Subject: [PATCH 1/2] cxl/pci: Ignore downstream ports with duplicate port IDs
Date: Wed, 5 Mar 2025 11:01:22 +0100
Message-ID: <20250305100123.3077031-2-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305100123.3077031-1-rrichter@amd.com>
References: <20250305100123.3077031-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 537cf4fa-a883-45ea-0341-08dd5bcdae7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S7BUDKvKWONBmtzHgzNN5v0IcV5zR/6W37gKBxVN0RImffxgofWc8OkkQyin?=
 =?us-ascii?Q?QKPXvYjUvGgAKSk5+TvnxKdvqees+icvAAXVVbOMAzXg1uFQ4+79VQfl3rT0?=
 =?us-ascii?Q?edjvyuVNJ0uWyXK1CIdfCq5Rk4J1dBzJ8oqVgFLxaZc2i7Z/zos8S2ZsvHZ4?=
 =?us-ascii?Q?SYV1310jtu0VRz/A2pU3oSXaoV0ksKytthfIlvb+3Xry+g5FI+oDgk5etFQy?=
 =?us-ascii?Q?VMXRrnsZcko5MdpPwrjb0I6V9pcUGoQJJyKa2fy/K6n6qXblv7odID6+f3yW?=
 =?us-ascii?Q?JKfj6C3oaYfZsC6I+UOx8iW1AVviC4F1OzF44OxyYJXH3a8GW9Tqcehp9KH3?=
 =?us-ascii?Q?Dcn2fMIDNm8lXHHGvBjPSxE75MYxPut6/HUoF1IjO/iZi9cXya5y5qjOSQWO?=
 =?us-ascii?Q?5LIrRDlRC1Nb8dg9sWB+4ONCICLpSTn2CEEN/VbZJtRHSidjFBpgdpHiBUd7?=
 =?us-ascii?Q?b+EgdK8G8unpXcSeG2hxNrnYEVjMvyK5FmlbWN+qXHDbTqXssG+U/dWe1n2B?=
 =?us-ascii?Q?99wvyXoIITCDHEtrZXWZe75n/Hmqr3yqS1yEn5fJTyRJu+dFlnIE9gZmhGgK?=
 =?us-ascii?Q?4E8twRRzlIwEIEyfeKi8lfEJCuaM2M4JqSWtppwC6uJ5ErtJewmcHc5AIZBD?=
 =?us-ascii?Q?QChvC3CFp0MvSxrGV1TFKXR5tagu4w7RPYjSdUt1P8U5HLoajmns9Q9dzaky?=
 =?us-ascii?Q?qJCFWOgEvREFxzDMRHvzmTpc3gF9oXjFy0ibFH+zp8xmWOfEc5DGRqiiOEDF?=
 =?us-ascii?Q?cG1MqrSamJIdPUr91pzfQ4ItR3MhmavO9pxoWivRborMNgXlND1pu+BwYb7i?=
 =?us-ascii?Q?cv2h09kUPngfJjqSoh3uvI7oe0zrbl9ttD0xdB2vuP50e2+sztHXWb3qRKlq?=
 =?us-ascii?Q?lB6Eb9/X0JxYYhHSsh3fOjj92rp+C1BvEboaIgn5nEEcHN8wrW/Qxm9p0VYz?=
 =?us-ascii?Q?Lk+JoaP8/U26JlzN11pJlTOVYVTgu3WYldGt2ClLX4SpJEgVdbEaSRiDVe08?=
 =?us-ascii?Q?wOUibOIuvLz58EQzDfJtVhnd/9lAtObjfNN+11iMpOQ7aGa5BXNNqMwbLz7A?=
 =?us-ascii?Q?Q/oxdZDeYo+RtuW/8O1IFU5kCypd3uk8iyja7NLM25Gh9+Gzjgq1eMb3fOeD?=
 =?us-ascii?Q?VyXP8YAYfd7DotvaC4DBP2i/0GU2KB7QyNapAUP9jiyyAPcsJvxvNVYqWLr4?=
 =?us-ascii?Q?BmEYBp/6XaCQyZ8Dxn565jTGxwYaubN26X3YKZv1ItaHBlIkzLb3OG1woUyF?=
 =?us-ascii?Q?VIoSgI/hJynLtrK+g2lmilwEJyq8hLP2z3Mk1GbFOm54xqKKPcWyrSqcZbjT?=
 =?us-ascii?Q?d2dE8/JKVcpB4ey9geoF3MXU8zc1oxINZ1JjVP6/tl0ssxHfgQJVcdNgW/SW?=
 =?us-ascii?Q?LCnCF6D2kiSn6Gp1aL7CFepyQPpRQOfXHjctuY49ZPBcFofdxyarZ65X9r0I?=
 =?us-ascii?Q?wTuBhsPojLdXcUZunYXdaNN1uLH6d0lrPW7EWlOBKMdM1B5HDFfcyNo9bQM4?=
 =?us-ascii?Q?wTT7Guow27bDZGM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 10:08:30.8142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 537cf4fa-a883-45ea-0341-08dd5bcdae7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889

If a link is inactive, the port ID in the PCIe Link Capability
Register of a downstream port may not be assigned yet. Another
downstream port with an inactive link on the same Downstream Switch
Port may have the same port ID. In this case the port enumeration of
the root or downstream port fails due to duplicate port IDs
(devm_cxl_port_enumerate_dports()/add_dport()).

Relax the check and just ignore downstream ports with duplicate port
IDs. Do not fail and continue to enumerate all downstream ports of a
CXL Root Port or CXL Switch. Turn the related dev_err() messages into
a dev_dbg().

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c  | 10 ++++++++--
 drivers/cxl/core/port.c |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index fbc50b1156b8..524b8749cc0b 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -59,8 +59,14 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
 	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
 	if (IS_ERR(dport)) {
-		ctx->error = PTR_ERR(dport);
-		return PTR_ERR(dport);
+		rc = PTR_ERR(dport);
+		if (rc == -EBUSY) {
+			dev_dbg(&port->dev, "failed to add dport %s, continuing\n",
+				dev_name(&pdev->dev));
+			return 0;
+		}
+		ctx->error = rc;
+		return rc;
 	}
 	ctx->count++;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 33607301c5d3..8038cbeffbf7 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1071,7 +1071,7 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
 	device_lock_assert(&port->dev);
 	dup = find_dport(port, dport->port_id);
 	if (dup) {
-		dev_err(&port->dev,
+		dev_dbg(&port->dev,
 			"unable to add dport%d-%s non-unique port id (%s)\n",
 			dport->port_id, dev_name(dport->dport_dev),
 			dev_name(dup->dport_dev));
-- 
2.39.5

