Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F578211A3D;
	Mon, 28 Apr 2025 21:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876632; cv=fail; b=YzMqIR2GZDn4faH+xLDTZKGQbJSZH7TieLkSHnVykRatuwPZTD/dCiYdQiPH/1Edlcjd8RdphMTRWxkXg9e/vpOPozUAv8FysqBcVVyToAXAAe0arCQCFLce1zoa1Gzyhh/7Or0cZ6eRvQGPMHqM/Q711aIS5qWu9IdHJdNNKSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876632; c=relaxed/simple;
	bh=xhBUp8nET9ppoakyWUBzHBaA6ntz6KsifpDpfw2il4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/V/KYdfHOxjJ1Z2qkf1bJR4deWh1kYSPuXi3kP/pKOVhMOf7/bTSwoe9BXkeM2kZZmwiW1AEOr/Ce0AbfL54cS0sMYMGGyaBuey/IPM8mvkatXV1QZgDjdgJoXVoXPAkS4oOpETeTjrBE1zFvBUbUWO2e5iHc/5fp/lDrRa+RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JGIgtbK8; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JGIgtbK8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DndxzwRJrR/Vp+sqLEIaVtqDeXQU4QEBtFzXKxREQt+nzWOWCpP4TLbIF36LaLlKkm5Hdrcsz8dG3MX9VcjSr4a2ocLkHraux/c0S+hjH/6GhTb6cvwSJXtOuZehqH4sOgQx40g1rwk07YFr9zkFoRkj6U9P/bbmYbe3PIrRzw3eq3l1sGc1OhGvCpoT4iqhRkK+x8A/ahWoWKObvaiIbvnNZk0S0LgDNDHB+g2M5zFZ8jKcRUwCp6mQLNxKRYe9qnHxVdM7LlOHrwe+JJ6IZawJlBNSOeXdWSgd5zD937sTc82CHgEwuZ00lXV+eKvtaet62ZU9pmlj+4CezEF2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXoFh1cmutgh2xjo7yNx913plwwSQa1rFrtln0TUseY=;
 b=YIdaf8LuEDZUfaHNlWfW7WaguoZ3i8QSEB1c0jrfhi963bK0eW23gxx+yYJjfYLidsV5y357HXLJz+z3Fel5zi6Kj8nw/SE1SZdHlLSk2uZ24GJvcpFxSnEhhFECuRpsVwAuVvP+UgbdvXF8VO+I7PwBgS9OQ7kYEsOJJYhPxMLBYjgzjhR5UfqsSM+wr9W3+TSKpNJTAUIwzfXapfTu4rdXijrXlXoU5oZ4bJL6LwFfpWGTss8+ZJblM5PJnndtjkZ/+hp0WJWNVyK2FCrE+gAthCwwre20qrwd9YzkAFxcSZqC0ayTlaZB+75beGHOjL8b7xGDuVPBYcRvMhZvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXoFh1cmutgh2xjo7yNx913plwwSQa1rFrtln0TUseY=;
 b=JGIgtbK8roK59ghO0dZOMeV44z1eye17NoFzNlKX/q47MPc0I8MoBxpitVWRgAWwWn/H7HiIWOkw07z2+ljeUCIjlL9ayoGnVAN9Jl9enaalXK6/euQO9GzFRvsPyaLEcOZX0Dchz+Vu2iUXIZRL90+MM1YVaDblXwK+RePWrxM=
Received: from MW4PR04CA0182.namprd04.prod.outlook.com (2603:10b6:303:86::7)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 21:43:46 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::7d) by MW4PR04CA0182.outlook.office365.com
 (2603:10b6:303:86::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 21:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:43:46 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:43:42 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 03/14] cxl/pci: Add comments to cxl_hdm_decode_init()
Date: Mon, 28 Apr 2025 23:43:06 +0200
Message-ID: <20250428214318.1682212-4-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428214318.1682212-1-rrichter@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 592b86bd-b559-4cfa-3647-08dd869dc10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mWsJyl/RTKtVDfdurR0XlBGuaIY1KsM80zcotcPCZRyIK2xBgfuGBZD89iew?=
 =?us-ascii?Q?QQmw7qDVLJLFBYj39gdAktBzOZh5Rv9s+y8cxK1HK50FiLFWjjggjSZi2+0p?=
 =?us-ascii?Q?jyTI/i5anH7ewZzQ12AfA9degU/CSzjMPJ+iXieMJ+VSYsTheonGOxdmYtxv?=
 =?us-ascii?Q?MC7Pg9My+3TYBQ27WRGIp/WsS2dSvXOWyyqcvhHW0vyYyfy+qOoVmdSHbbnM?=
 =?us-ascii?Q?ZLEdHaHltMUFKMsgATWXKuQVFNSfmD5UYGrBeH6KFVZX2EtQ+2axXGd9ZzjT?=
 =?us-ascii?Q?2auhqH9oWG1MHfIQe3ndJf6xV9qASEdwxJqV4OtslNd6NovocJeniZ40Ek7G?=
 =?us-ascii?Q?MUe4Zcaj00am7rJLJ3fnJ6yFIbE8YKjrZaBIM6FScC2ao0VLJFOApOez7+1t?=
 =?us-ascii?Q?IfiFLdRSLpS9KgCtH1twTG8h4OgeC+SlrCzyLbN8dEZHZ/nfZYgi0wdYOk8b?=
 =?us-ascii?Q?ZwP8YAuWZbTa3G9c/GPCxkSZDz74WD4XlYON8V3BwPnp9sR1vPgsac3Dg9HJ?=
 =?us-ascii?Q?iLOzDgBTYewrLH2dRFusj6Q8OKCHcVgLYPw7UN0BuDS+jh9/6AvvjA0Yoiiz?=
 =?us-ascii?Q?y6odicJaO6Kb8rIFWckJQo1A6qjDObwI9qo0RH2NpggwL8RMQcFsamZcdbOg?=
 =?us-ascii?Q?lhTZMvU4fcR9ZSBn8sImIEJPZKJ/X67wtWVrq0NkoUzRqgzKY1sELM7Xwccu?=
 =?us-ascii?Q?ewAPhNFxlB5xExr1xVtx3f9h3xocdWincrdsjlHNjsdNeR0p2xE9sz93Lxmr?=
 =?us-ascii?Q?i25kUS2mKXTLGQSRdMk48a/IHkIe3H7Yq2t/azOWKOBltpa0c3jT8Ib4k3er?=
 =?us-ascii?Q?MwivrBqxfP+PHzUnSURLahJtfSuJKNR1+Vdxoq/bGsPcA/Pd8xivE1aPRaMv?=
 =?us-ascii?Q?egNp0wuHj8GhUWQcEPf6yu4TjH3mKMu50rj+sto73gVJMNlx0e0W0CKF0Sps?=
 =?us-ascii?Q?PYrTDmxTHAV04ZWIpHRJrWfqe8nJQlf7sPBUU8II2spko4nwKXKztotEsAx0?=
 =?us-ascii?Q?00loGfcBmwIJTDw3aYgHDE6LD8in4Bt5sWKbi1vT0rBvrJliBcCUvV5MFgIj?=
 =?us-ascii?Q?rlXZE5XMsAciiXbQ3gLcxKd0AJu6QLQ3S4RX1TSKtEfityYWc4T+ORaIw9Ch?=
 =?us-ascii?Q?Mmb96egVbM5a1uPMRohUUUvpOjOS5GSdBQg8G4t1iDzh4QZv9X1SXo1IiYAk?=
 =?us-ascii?Q?XvgcLHFD7iSc4rAdZXjfyB+LN2bt7m6bR5PCWOxijkK4gMT8X8aNrlm+QZDw?=
 =?us-ascii?Q?7AxJTr1n1j5BDt8N0bZpTth0sWIqZla33F97jHdUkkYTgTt3oOkIY2MBYL3/?=
 =?us-ascii?Q?vkbCQEW6b71W0qPMzGYmbKPKibC4ukoiPPnGqfAigbYIVdQCOeCeExLAOof4?=
 =?us-ascii?Q?Sx1gvsUermQXekqkoFct4qluIfPItF9HSbqyK5KWLxBp3XZU73Rv3X76ddpT?=
 =?us-ascii?Q?XhV8TbkC+U5ZbhWBdCHV/Y9cwijH0gTUjUYI6YyUDIjGvgoqmvnzYYoaNCtt?=
 =?us-ascii?Q?5CXjnlWF3ao0PMxPq/YxNmVc4vKD6kknKZWH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:43:46.1601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 592b86bd-b559-4cfa-3647-08dd869dc10a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072

There are various configuration cases of HDM decoder registers causing
different code paths. Add comments to cxl_hdm_decode_init() to better
explain them.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/pci.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 6386e84e51a4..80bfd8ca4f8d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -416,9 +416,19 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
 		return devm_cxl_enable_mem(&port->dev, cxlds);
 
+	/*
+	 * If the HDM Decoder Capability does not exist and DVSEC was
+	 * not setup, the DVSEC based emulation cannot be used.
+	 */
 	if (!hdm)
 		return -ENODEV;
 
+	/* The HDM Decoder Capability exists but is globally disabled. */
+
+	/*
+	 * If the DVSEC CXL Range registers are not enabled, just
+	 * enable and use the HDM Decoder Capability registers.
+	 */
 	if (!info->mem_enabled) {
 		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
 		if (rc)
@@ -427,6 +437,18 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		return devm_cxl_enable_mem(&port->dev, cxlds);
 	}
 
+	/*
+	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
+	 * [High,Low] when HDM operation is enabled the range register values
+	 * are ignored by the device, but the spec also recommends matching the
+	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
+	 * are expected even though Linux does not require or maintain that
+	 * match. Check if at least one DVSEC range is enabled and allowed by
+	 * the platform. That is, the DVSEC range must be covered by a locked
+	 * platform window (CFMWS). Fail otherwise as the endpoint's decoders
+	 * cannot be used.
+	 */
+
 	root = to_cxl_port(port->dev.parent);
 	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
 		root = to_cxl_port(root->dev.parent);
@@ -454,15 +476,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		return -ENXIO;
 	}
 
-	/*
-	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
-	 * [High,Low] when HDM operation is enabled the range register values
-	 * are ignored by the device, but the spec also recommends matching the
-	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
-	 * are expected even though Linux does not require or maintain that
-	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
-	 * Decoder Capability Enable.
-	 */
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");
-- 
2.39.5

