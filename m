Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010050.outbound.protection.outlook.com [40.93.198.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7869A3750B1;
	Wed, 11 Mar 2026 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261475; cv=fail; b=da8Yp8aNcfjqYnzUM7nmMqBBMEHu4vSxkEyUluWtF1jGZSQ2WGzTgcHniLrZUlncvEjseJMZRck1nmMFz5osxl3ByUFkjogatVt0DztJ/1RgAAaGCGGZi3ejqnJdxehs4CCDecVr+HFHP+WsoLQUHLT0/OEVwL2Odly024BdakM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261475; c=relaxed/simple;
	bh=NTolRLeI1yLv4hGrM89eY3l7ZJM2oN6dds8QlrhFJq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edfVQcQMPy3Ttz+XuV5WQqd9tPgKX+vr2CqKf0bn55KpoIMjg6lkvqheRYAQljARsjsSo6/tC+2iM1IY2w8FeDc86VOpNjm8Mpqgqq8PwqGlucR6hpepypwLokd2JhzLrBPu9POp9nukEDjS15xxgMjJy8vB2hULYorFYhtOGEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qbafMvPn; arc=fail smtp.client-ip=40.93.198.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qbafMvPn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+E+3k6CbOU+bP5neFvkBZH6a5zsLwpeMwm3WNGGUyyiZsey1IBZhogS0LwgOvH+0vL9V0bTghT1Y3qMGbYAxQsnw+Dbmg1llQ+5ghXmDzynxhzxoN016rQevHiYvNS3f2x3+u1+UcM1W2HA0RJ6GANOCHSAtd6vxhTNt2EzVEKs0eKqCkj+ZEooC/Jv6C9DpnUDLxqt+rdaQawccGwXrFifQoWLYXWqfg2BzpCFkxi2ezVYGG3n5A/s7m+QGXThZm9tOKJFn0SPMHGiCRX5YhiVTitwg4OjGd3aIijrZ3+L+/KshBdDtkH107/r9ImKFYNF9o3EUU94f6Bh/b08QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6JrNAE9RbgweA7MhIoYm3P7ydsxCvg1wrUeUvUmNpM=;
 b=O6zoJ5GsorgczVOPUBzc9mBjxxHQaHTwhteHkn1AgeDny5GkCI/2PsnQCnHrKSlcWK0SnDgDMAUSUXEd7/L1M4ZxqjpDvmtkl9wqUVY2P5C0QQ+dyzhSPXmwn1BdmQMlqAVw5q1j+Ojm/kl6NhfvKUfCQ6kXrgy1DO5wkgNpB6J3q1BMZmj/O+X9HIhLMSEhSJ+0qnS7V2Y/SCnJ09Dyoa+QnWD+7oHihwu8YhIaneXxoecQc2WEPToYmWhzF80LCQCgP8Y01KPLSNGKO2QkQHqSrhlip010cyFOcKsIQ6a+b6y37DEqbcCxYtgr7h3Ce1nzVXTVNut0mTb8xaVEtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6JrNAE9RbgweA7MhIoYm3P7ydsxCvg1wrUeUvUmNpM=;
 b=qbafMvPnzCCgZrzP5fDBjvOAksydiP8u4QPqi/Tx1NXDWGdiUiEYQdxAQGA/iZZ0fTwcwSs/gKzT7Znge0/HnAd+Fd4IcZsBccYKxBnRjFLrcpCymDqpLbqnlVesCKx/OQ095vkWSouqP4m2xcSU8Lk+ek5WZkznhVluPdQFgQN7RfZN3iVFihhnPCxf/n4gyLVrweqKQ2mJjF7MKeVg6SBpVGlr2AbJ3XtJPwObwVzOoh5WFp3Kx4x0UhUiNvaby9gNviO1i4cniLke+y4w3EfaSrQzRuE09vkZzZanIlEnaaui1qICxdlX5BJwvZyRJNrwToI51qH5YwXr9+kLxg==
Received: from DM6PR05CA0038.namprd05.prod.outlook.com (2603:10b6:5:335::7) by
 DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Wed, 11 Mar 2026 20:37:49 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::2c) by DM6PR05CA0038.outlook.office365.com
 (2603:10b6:5:335::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 20:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 20:37:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:37:28 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:37:27 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:37:21 -0700
From: <mhonap@nvidia.com>
To: <aniketa@nvidia.com>, <ankita@nvidia.com>, <alwilliamson@nvidia.com>,
	<vsethi@nvidia.com>, <jgg@nvidia.com>, <mochs@nvidia.com>,
	<skolothumtho@nvidia.com>, <alejandro.lucero-palau@amd.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <jgg@ziepe.ca>,
	<yishaih@nvidia.com>, <kevin.tian@intel.com>
CC: <cjia@nvidia.com>, <targupta@nvidia.com>, <zhiw@nvidia.com>,
	<kjaju@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <kvm@vger.kernel.org>, <mhonap@nvidia.com>
Subject: [PATCH 20/20] selftests/vfio: Fix VLA initialisation in vfio_pci_irq_set()
Date: Thu, 12 Mar 2026 02:04:40 +0530
Message-ID: <20260311203440.752648-21-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260311203440.752648-1-mhonap@nvidia.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: db26646c-4b3c-4e7e-ad69-08de7fae0fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3etJ6HkC5hotjvN1byoPsWPng9DPn/Z/trUj91skOo8SQ0JKx4w6JLBVueg2fjOiDAtdRQ3kpFtvORa77g8FRSHdmNV53GPsZjanG57VbxCpU0dTGrTXLOo65QxDjIXoCx3fDPUwsCsjwjQXjv5F/9h/UOY97RnsNbbTmAtT59PD3z4sLe8Vs2kyE4s4lr2BqUykG894LeLDba8Ls9aVhmrmcSUlh1RjF3wJe1BC/Q8U8ZeFGCxJSPCd31sSE+PfSNEvLhBlBo//z8xdFuASPoQ+EXKsvni5Fui9e1J+Ni8RL+XOzeIwQiaeua+9bF0H4UVtLPq4EP8wDXE6GUPu5cQAH9WMIW6AsO5lFm+6zNlO/LsOW5+NOLaeTOQbzoAgWu5xxH/cvlK6h8bXA6Npywi2PhE/k7xCWEaEftQa3/LGJG4lvEWwjXLslaNuPkcK2kxK7aUXk6P1TANODJUdOViNoEl0ELxLIr5FseuHpEP5znfT4c+H0SMY/SJhlwQ830qtAirSmKcv4bQ4YAkz+Q2FFGGEGsbswAcIQq5nr7uZgYs9YghGD0Jn6T8Tu44IzK8uP8kYGiFkai5cFrIwbe9HKw3+HFim5+gq9JgSKXQgbbuYQRY/8akueFZO0da+mRc9ZhFdyRk8DRTWCohjH/M497SA9pTmAjpQhkANgsDWDHQJL25B95zNm5VrgzAbmCmoy9Z9LgSmDViTz3hBusfMwdU8CXA81iTcHmlsLJ4RPksBgclRH24LeA1sW+Be95GL8dF51m2NVSwCz7fV9ATeDW7Jz3eCuMjmLyvEXAChM1cYjXsQPxVlXP2AFCoA
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OE7fDMRQVIrV5Ad1HDp6EsnGGhC1Q63LXbF4tbgjBGCM1yYu7pIuDgSnqy7YrOmoVgdHQFcmrsyE9D9IjhR1jN12aGmB7HqFYNRRtYXzWArR/G65T+LiGGp0rM8dQjuFLylqo90tldvzCh2siHp0FcN+xoMH2kAj0KIZs7Osg1I38m7shMhEuOdZC+Z3Rn88fPSTumeUotGwYewRx/2AwQIN7KPbbiRiimFHi8OQ2aA5sCfpgmwaIqeJdw2AxioratoGmEkAa7SAqur7vDr1YrLADdX8npzb93/1ye12lGnRWRx4P7ydBrf2XTWx7hM/kVIior45SGxchpk+VGmIuBLsYAC7taIiLxWU1c53j3AwXweCijLSGSk7A21JuXJ4DKNv+CHz2qlvlCN2ldXGz7/5UUwjcI0N65PnhFM+aCZKMOrYdNI3JvJIixgyQm6L
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:37:49.5373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db26646c-4b3c-4e7e-ad69-08de7fae0fa6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863

From: Manish Honap <mhonap@nvidia.com>

C does not permit initialiser expressions on variable-length arrays.
vfio_pci_irq_set() declared

u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] = {};

where count is a function parameter, making buf a VLA.  GCC rejects
this with "variable-sized object may not be initialized".

Replace the initialiser with an explicit memset() immediately after
the declaration.

Fixes: 19faf6fd969c2 ("vfio: selftests: Add a helper library for VFIO selftests")
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index fac4c0ecadef..3258e814f450 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -26,8 +26,10 @@
 static void vfio_pci_irq_set(struct vfio_pci_device *device,
 			     u32 index, u32 vector, u32 count, int *fds)
 {
-	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] = {};
+	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count];
 	struct vfio_irq_set *irq = (void *)&buf;
+
+	memset(buf, 0, sizeof(buf));
 	int *irq_fds = (void *)&irq->data;
 
 	irq->argsz = sizeof(buf);
-- 
2.25.1

