Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEC335C190
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897432; cv=fail; b=gWbrOioCy11EExrZ81tpzOWgjKfrSqrJyq3REZTN1PT/nlx/Dth2WxHRaaKIKZ6CpeaOzsvSQUCka9uaG77r4pkTaIY+sVJKDK8Hyo6pn8YRQhfHTncKhpEUIBpuQZ0NdgPFDGTaoHn0UCEJ2GERMeO7uxrc2xiuPx9XIN8o2+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897432; c=relaxed/simple;
	bh=It7j8gAbFB52Jyewx5QfHUwJEyia65902Y72H/fXc9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8ahVawqz9m5Cd+0ayJCAsyfjLWj40qosKAQ2wJpFzH3sbOwN24WT+RIl83rjAGcLLtgO1cuwdDzVTlMHOHTp9jqZawe4uN/L9NUn5653AH/4ICcmQ6Y7YEVw3cPVy9tu3/Afvk9yOTSD+RazzhUtumhedPbXAD4GnZUywaufRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xBLn9n2h; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xBLn9n2h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBQKx+y4GyzU7AwQjaIOkQzg+3vT2l8OA4xdnrRqXGyz7kx3mst8iHet4ReQS9N+OHWqADRVjUa+lHSEEj57iqsWd8qZLJNhNoAYZCqcsd4zcuwTh9wKJspelbQhk5XE8N15sZfv6mEWKy45kcZ1Td6BX2R1MYwf4fZ/fN51oW+wp3Yu7jzXuAHAhecpchEL3OJYguf/6do8pSK2YmJD46DWh4y+vrxfWZ2DpTBj4JuoDAlZEfKkaLpW+8L65IdiyMnSj0ffsUdLgTklP+B+iQEkcnkP7lkgY+B7hUi4tspL/236BW3f6mpVOCus41dSkuze4/QDTGbiI9AUbi0pcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/4vRPK6keUqCa/jWFg+1vXbbDMsis04z2CWGVE4zmM=;
 b=IJi2hHV0hjaMHE43OQkiYE5ZpQGUwlrP9YxaASocH+y6VtIxjMbQOmu8B6cRWh+Xsw/s+QtB2wKvTpBkL1TDiSMWkrTGYmtignlzxx9gBacLI0nE7EtYRHeAJYvSp+dvq7eb5KEjmJ17wwa/UwdgVCVbce2uZj71elH67QhjVjqWvj0lLvULpeJms4iKmAjVFmL14qGWl6duOFtSXS6hQMB/KcnZhYONODX3P1TGWnaaL04dVQUdBeXQpi8yKTYF3cBPhKo69yLA1cPc2aSjRjb06K89J5iXzhDdjNI2ES7hPoqJqtlehPZEnggsybst7f+nMeH4wuoLj+xVgvj2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/4vRPK6keUqCa/jWFg+1vXbbDMsis04z2CWGVE4zmM=;
 b=xBLn9n2hvtRAL42bs4jNSpbDDrVwRn72Gx46EPtLEZ6bVm2p7fe9TmKW4cqa+AX6a7qd9D3YO7QGTA893puBGciZHxN5dfN0rQHVWgydXIFoX17xuqKRE1OHj0V65sGsN8xran7A1FIR0LMb0ZvmEaDC3dzsUsTdR/O7VtOxKFs=
Received: from SJ0PR03CA0157.namprd03.prod.outlook.com (2603:10b6:a03:338::12)
 by DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 21:43:47 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::a) by SJ0PR03CA0157.outlook.office365.com
 (2603:10b6:a03:338::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 21:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:43:45 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:43:44 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 15/17] cxl/port: Bypass cache id for singleton cache devices
Date: Tue, 11 Nov 2025 15:40:30 -0600
Message-ID: <20251111214032.8188-16-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: d191e713-7a71-4d25-6873-08de216b63de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oFgy8yBCkflrkwezyCQitoq7r9A3MPl/IVMvqWYuoBCU1eqEgNhSP0wmJ2MQ?=
 =?us-ascii?Q?zrffWhcUCEhkkiN14k6aFVtZPVHtGwDsSXB8kbzEwZlu0cvW+Fj82hcyzjlm?=
 =?us-ascii?Q?YQtqpyIbZtJD0oBMC+8b02Z5amRsDx7QXoiTLZDzPzbYUBcekkITBOvoaQWC?=
 =?us-ascii?Q?bZWHV/YJ1JCNQa1xhhYY9kZYgfd4GPcMp5ZKlhE/qhAfK2tykghqOBBYk5B/?=
 =?us-ascii?Q?cvuZQrUd//sWnNrlODt1b5hZF/nn/gx7ytC6PdK4OxmHYswCyPLNIw9DEFRl?=
 =?us-ascii?Q?eg//bXed2XEGuqD0/xVOtKTHN+EZUMY/pMQMc/gkPe+PZ17sPMO7czOtcofy?=
 =?us-ascii?Q?PtRfm3EuEoLUqmY92+KgwHFDw6YDHzOgKJ8lTx8EYEFQ+puyCfvC5hHwtOkn?=
 =?us-ascii?Q?/AOCxOKFoV3mYRBOQuv4dLUK07ABt1jzVlTjbizKhPTlJCtvdeANB6614ega?=
 =?us-ascii?Q?l/eqPMaivltF3mmsULIB5Nw4V6BOQzZ3u5x9g7QoKVUL7NvjdnYrw26b1/Gd?=
 =?us-ascii?Q?fNb95Pz1bvJK2V+Rb0ur2+cb/3Od0Dw5G9LOjPiNha1YqKF/51TWZ/n9Yh0z?=
 =?us-ascii?Q?KILlwW+O0tuWXMUZk9KtoVNFNRQVE7js4Mp1SyL1P5jiSCQHl4zZD+Qpcld6?=
 =?us-ascii?Q?ujB4/TB2B1tZ3fZilgPD+d1m9EMQDekPqx0hMdCmD4YI3x7KTkPjL/KWXiF9?=
 =?us-ascii?Q?LPj1Pbs14P0gjHvKd+A97/jcqBnxfRln8WqAIbfL9bhyhWpBGBiDl9+jVxCO?=
 =?us-ascii?Q?sD2EZqXeHwzjIba7KMZIZyWnsVeKJQ+/wpYpCK3MjAW0WdEsZxy3bXLBJr6r?=
 =?us-ascii?Q?SvXP3wLDXA5260Z1/fA6vRr04T8LV/NlFpXplwpgu/cWwfusbHDmt7iPygDv?=
 =?us-ascii?Q?oOXynSdbS0FPFQamm5diIZmqyU2RyR/O2j1fG58N/Z3ONYO8tZRx2su/oS8m?=
 =?us-ascii?Q?+sYAgXn0FBX1qPbi7cCcQ6CSh4p14i7V7P7C6T6ZcncSMElnwjemsn2VRd08?=
 =?us-ascii?Q?Cz9eCI3eSY4nPrsBjBqpzH/6QdZRB7xSkoRVdO+ry09IYDBrD0kojORz7Tmd?=
 =?us-ascii?Q?VpvziTS4yu/mIFzaNUPvv5vTPHMxnzCO0H7lJ0kPTKMyAX1pc0uKHYfAIiyX?=
 =?us-ascii?Q?PqO8Hh+W84CxQUrDXo6EkRw4F7MBxKbsURddNFS0pnvG4T6bgAr02viWBob0?=
 =?us-ascii?Q?GjFOiuhufryUSIyZutpSSEe+YILuO5rHEbjIlca4zMvcPZkR7YV7fA1foPWO?=
 =?us-ascii?Q?/qe7GgVP9AVfA7nYWM/Gt/s1vd8A8kiieJrSA3LILL9rQS5M3N1wVaju5Z+c?=
 =?us-ascii?Q?yUUDoqD07EVIZjDOaAD/niHfIHdqFcZHSh63MDKzyWhZLcob4cv7xE8JYl5a?=
 =?us-ascii?Q?YlLKiCtgaq7GYilqr7uqNL5XUFLoMDptKDq4AY8tFaOZX0l547ObtAEiz0GM?=
 =?us-ascii?Q?3N8S2Zh5/A7sblQdJaSxWI1qPyHDO2/DruNbXhO7f+4MtEbMkn5SeNKefzF0?=
 =?us-ascii?Q?6g4G4QdBZ9sCIp2PBftzH9A+2kTr6xKtmlUxGGE/LDOLJR+qdvtl/g8V/EHU?=
 =?us-ascii?Q?fBQwnk5wrHcGTF76oSM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:43:45.2581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d191e713-7a71-4d25-6873-08de216b63de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838

The CXL cache id capability is required to have multiple CXL cache
devices in the same virtual hierarchy (VH), but is not required if there
is only a single cache device in the VH. If the host does not support
the cache id capability and there is only a single device in the VH,
skip allocation and programming of the capability.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/port.c |  1 +
 drivers/cxl/port.c      | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e6e25a201ff9..3d9da6c3f672 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -617,6 +617,7 @@ struct cxl_port *parent_port_of(struct cxl_port *port)
 		return NULL;
 	return port->parent_dport->port;
 }
+EXPORT_SYMBOL_NS_GPL(parent_port_of, "CXL");
 
 static void unregister_port(void *_port)
 {
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 4cecb731ec5b..68b6d9e34706 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -98,6 +98,28 @@ static int cxl_mem_endpoint_port_probe(struct cxl_port *port)
 	return 0;
 }
 
+static bool cxl_endpoint_is_only_cachedev(struct cxl_port *endpoint)
+{
+	unsigned long index;
+	struct cxl_ep *ep;
+	int cnt;
+
+	for (struct cxl_port *port = endpoint;
+	     !is_cxl_root(parent_port_of(port)); port = parent_port_of(port)) {
+		cnt = 0;
+
+		xa_for_each(&port->endpoints, index, ep) {
+			if (is_cxl_cachedev(ep->ep))
+				cnt++;
+
+			if (cnt > 1)
+				return false;
+		}
+	}
+
+	return true;
+}
+
 static void free_cache_id(void *data)
 {
 	struct cxl_cachedev *cxlcd = data;
@@ -113,8 +135,16 @@ static int cxl_cache_endpoint_port_probe(struct cxl_port *port)
 	int rc, orig, id;
 
 	rc = cxl_endpoint_map_cache_id_regs(port);
-	if (rc)
-		return rc;
+	if (rc) {
+		/*
+		 * It's fine to not have cache id capabilities if this cachedev
+		 * is the only one in its VH
+		 */
+		if (cxl_endpoint_is_only_cachedev(port))
+			return 0;
+
+		return -EBUSY;
+	}
 
 	guard(mutex)(&cache_id_lock);
 	rc = cxl_endpoint_get_cache_id(port, &orig);
-- 
2.51.1

