Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5F53AE71C;
	Thu,  1 Oct 2026 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856094; cv=fail; b=q3TQeukVJp6BCdy3L/WezSfd906sDfML7vHWY/OO6IbM9LZQfRhpXP9Xim1+vYPOoMsUSaW93aMKVv2JPJtS7LaCBBD1duRayWrH/5hnpiJkIo2KNG7OlYxHGlclcQOJoi3YqTRL+Ts/DeFVS3oG9KGizOPtur9YeJwh6RSth4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856094; c=relaxed/simple;
	bh=jdO/XRvf5PV8WTeEYiQlaVCPED6GZdvQbcrJLLrA+W8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyTFB09ovisqcxHCv5CKi8Sf2ENcex0fa2NiRxxxabBoYB63R7jxkuzOygSp9n7yy/OVfFb5xt88o3kRCdydUS7NA1gCHZmYkv3WTRSs4JacGsaFFWcJ162EXGUxS6YNEPzaElU3X2OPWEBCgNsQuBk4KKIpdV9UNHvKHXlCHxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rl/RpdNp; arc=fail smtp.client-ip=40.107.200.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rl/RpdNp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUTkCRZWgGgEW97I64mznBNxOH8mjwHT+pSNy17MPphFZOAhnf4mSE/i/47MdH7ZcplFXrjSO7AlHp2xOqaZ90w64xzmUmtNpes5R7w4bSVERQ5HX5RfwA8zxR+Vr7q7fUKokfahJYUg7PKS9PpYkBqo3lqdAwxAT2E/62vkMbXeEsSdfFaqmkhwsch7T2O5rYUzooIpucJXXg2LdzHr7fxG5DM1c1l7ld5py+chfGGkliVKS1GZEF88I/xh5LgKuAFej70XN/hJcLKmcl9Bud6R1UtB68+XKzRvZO4VYfZyKbXhRkO2A46e6C4rDdjgIqJ5wB8vqHZ3YeF8u9lRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LdkMY7qL5ZRfPcWmuQKhRcrmms/ge/Y4SboiA6RKcU=;
 b=tAHSq4DRi4ZFk+P9O1y1UxvIZQip+dHetVFboVyYplaPRuVnkZXSnBlFJprOOrHzBJZ0b7rVOy4W/PQ7TtxFYVvgJtC/OmBTjPLiqEaMasOJ77TTIDcYVZqDrpaQlmleV+zVEsqZOLOk/TJZ5paEGjdxAtR/xKr9r2rfun71bgaMrbIhG74zNp+vtaArBhkFFObIUVYOD+aaI7bhuOZVkyKKJZWmhnsMxhHhTzhgpM+ZkBK5iOZWpHbUGpWWMpDjNem2WADD1sj8nkTX/4an3CUW2Pb6h1IE+a9Wo8s6djB021Fw48KNVfBPXr9pBLHJ7N+Y1O2ThPEsTQupXbozyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LdkMY7qL5ZRfPcWmuQKhRcrmms/ge/Y4SboiA6RKcU=;
 b=Rl/RpdNpaFJdW5XuB9g6zLpN5U+iiUR5HI18ddiJvi+3542iORO9vn7zJG0UKmHor5ixRb8Clk3hG5dkFAl78HGd+w01OyT1jCAzO225B6bV/U9BEKRvaU4VxpeCdBqOJgrEcduNNpRcu/4RBpffUtZrEASSulwoHH7ITRwMswM=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Thu, 1 Oct
 2026 12:01:21 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::25) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 12:01:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 12:01:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 07:01:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 07:01:20 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 07:01:18 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <icheng@nvidia.com>,
	<rafael@kernel.org>, Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 1/4] driver core: Check for supplier requiring PM at link creation
Date: Thu, 1 Oct 2026 14:20:20 +0100
Message-ID: <20261001132023.17032-2-alucerop@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261001132023.17032-1-alucerop@amd.com>
References: <20261001132023.17032-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e081cf6-2876-4497-6b5f-08df1fb3b530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|6133799003|11063799006|10067099003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	/F4Esmuw2MHN+cObRNOGP7viF4a8W9yXPdRvxxDKGYAcev2jBUYeyssMlVAaowY2bGkW3u9G4s5J04q0OFaoI/YQJzy/EeYq4aUrJJnkSyK2Ym/MANH53sc4JWicx6+c0EN0fU3Xbj8B7ePtIrhWawQm8+Eogbij/CmxTmyegPBJrEB6qTTuJLBOxpFPQD+X92Pth4UvJlWgf/0p+K7I3aKaYATjOXVJ7HV1giQ7nnyvNK9xqfMy/y3eHaQTh5xhwVtNVgZaMExVccB3Yq0tqV0ZIfisjSjb3+PHcmqeuMdEn8nDXyoI/JJOsbBi77u/50ukW+EZeGsvDM7T4bcFf8FeYe22+1aIM65CKzMwIdMUcSdEE1aQkqB+SmUmDHn/tN0Eb0/g+b2MTuIesyAhFHYYNWTIpeaWrOu1rk7fm1w5HMo+JvEriABywyR3QTv/7TDXfhhr17K8I7waQF4wNDk9pn3a7VFmv6AR6aT7c6ABqfwFSkgQF45aMyvnlfr4FW/EfY5N5HpEpHmqSHvA1guAYozUf65867ue2faypJ227LPWnk7CP+HGIlE20uF6lGvxw1c0P2xm+dVqiwChtJrxedV2XNuMSqnLBRn1xtg0RvWMk6M40UgZi8hCp0G9gKhX2KtWYpMwM84HzE3WJLff1rTs93bwCNKARCQyWHHDsHtFRxz9GBXfQm/frfWgeTWjj+x3w2sMfeb4euYp2A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(6133799003)(11063799006)(10067099003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Vgjf0kFE+d1A6lYO/EahXpxWkdyR6+xXzwubGO7LYKvbvgcZjm0+gOhHfFNiKFocJPv+5JnqGxQRt2E5AALfA9Kiq/QO7GeeO4dUvf9jX4Ydz0z3VjgoE35oBmfBkiZPXASF3vZEyvtzvfwmpnmhdze/IIno8UWMmemNR/+9MCl71cBXKQt5WER6XAgLVTRIsaUZxTh/WPVJEC1qUMJXMgdOD2zob6J3pnMNr9IqF6BD0CqHlZfoKDQXb12Ie5raGIrncP3w5g+SEcCkB12R9nLoYhQyVaCVv3xTozRb9tE4R1ogJRfUxLxzYNd/v62MB+g2nCGRbmSP2zvQtE6AMA+gRYNH1un+B4olFvQXc8tsNNlRJoeLaMOIYXbLveQKVlRlHeXwFos8zBQ5pi+UpEc6DJe9kqDXKCpkQU7+vLgVRo0tCfKFvN5k9wkVBURk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 12:01:20.8356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e081cf6-2876-4497-6b5f-08df1fb3b530
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179

From: Alejandro Lucero <alucerop@amd.com>

PM initialization could not be necessary for some devices.

Avoid checking for supplier PM initialization if so.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4c0c373998a1..bf0513beafad 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -840,7 +840,7 @@ struct device_link *device_link_add(struct device *consumer,
 	 * SYNC_STATE_ONLY link, we don't check for reverse dependencies
 	 * because it only affects sync_state() callbacks.
 	 */
-	if (!device_pm_initialized(supplier)
+	if ((!device_pm_not_required(supplier) && !device_pm_initialized(supplier))
 	    || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
 		  device_is_dependent(consumer, supplier))) {
 		link = NULL;
-- 
2.34.1

