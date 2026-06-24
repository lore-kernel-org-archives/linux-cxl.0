Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A623B14CE;
	Wed, 24 Jun 2026 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308875; cv=fail; b=DPXBKqH+0ozqoHFxi2xO0FrJz7gbwEhoZ5Y9V0Pd0PcJhx4liQEyKCeG9yebGGVZgPLnwfflWuFCvK2OKuqa24N4OQ1riX3bQAEP2lmDC7hqJOlQU03mNXtJgvG3OPdXj7iIXaTMQBAN3TZPpVHEZpDwaTKW4ogMPuwxEiRn6eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308875; c=relaxed/simple;
	bh=cPbYvYtrZ1T64PV3kixxL8Y9fOlJF9Sh9+/G8QwRfyk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KkXbP3RRdnPNS8kN3RnPO9nOCZNr2K7HJumwGwEMRkVIai+NN848fns+ZFYpneQIgFGgNBs4oD3Pgw+dgrjmJNKJr4lsg9Eum59jZKfCwByYwfDC+ixOdpjwU9wiiC4UyYiy0N5seLb3g7I8yQrgPWNTALuvoO/apCOyoLCc29k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IbL5ZxfU; arc=fail smtp.client-ip=40.93.198.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IbL5ZxfU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkepO2n7mtCoD8zeZmeos4EpgxkZQUomREdDdRi4a9EjEu5a8JTnPh7Q9+N/hw19RCZwwUQyJ1DrQiijcsf5WrYqegwjkSVBx0pDfDrCguG+mT44NXmtItMCrMcvQ8IsDF5b4akhxxGxc1XxFJEgt0iqWJGCn/6eGl5Je8Fw2m5hHK0QmjSaT3g4qHi/2GmhTnzuWbHkOCFGawHUw71Q7A4JcvStkemBYYom7293OBRkG7/gUfzKptuUQL5lqd+kRwXuLDFjLdO0xb8FoN+rQiMmKIC6xmqVPKa9sxpIZf9SWXvhBsOztNnepsC4wGRFpdBD0CbWJA4GqasOH4Rfzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rhznjeums3lsz0/zBjluJ6PUFeeNLrzhyvGcWHNquo=;
 b=JLlXr7i0/Qp1zxcp/B2uqSISNjiiBRbRYQ7RvtXW+Ax7Q695KR9mkA1eViOEE3E52omq4hlB13ek6QBzg0Zc/NPn2zjGaWsdOZ9nuxQgtGqAJ3b5f5nptQyoGBipObryNqGuiLy+KhWpSR3la/JRWlzt9JC/VGpC1JuDgEN7+5zWPCyWEywad15ktDOBMsgN6yNlQFYbpDm7JWqzuDP4acMzrkYsAw3u3+Com5JPZZyhhETdGCD40VNd6XeLOlwTkDkCQzaLwfY6hoQ+QuDwP4m9aAfn9GjtuRMkdHsEb0OkNpcWZFjLYFuX5xaIh4MYviHfy6/k+UMd+4G8iSgvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rhznjeums3lsz0/zBjluJ6PUFeeNLrzhyvGcWHNquo=;
 b=IbL5ZxfUMA8mIRU3AMLBUJxCWeMLWzaeQ0cqud2XPdNjqPx/5q6jlrDmMox0jkoz2xy7hcKZlflTNK7YXGOngE1RtOYp27AOgp4ragmp/77eq+ioVPgZ1QJjuYjmHHPHWaXWn+whvfrVmH3IqaIJbeo4oOCmlLGOKmkN6KibRO3Hx1mefzD9uXP0AKkBql8Ao3yvAr8rQeSudkY7Vx4Udq2ldnfFC+29j9kjXpDAdBN0JIlv1BJDGQo36iswqZgJz8lQJiW5d6uQR87cOKdRwV65VGZuaTzH9cnnMDY3u5R8n1aC0u6rMe4vM8B/y8/vnRa9HsuVUUlgDL2IQ358vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by CHXPR12MB999221.namprd12.prod.outlook.com (2603:10b6:610:2fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 13:47:50 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%6]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 13:47:48 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	kobak@nvidia.com,
	kaihengf@nvidia.com,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v2] cxl/features: Reject Get Feature count larger than the output buffer
Date: Wed, 24 Jun 2026 21:47:37 +0800
Message-ID: <20260624134737.49166-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU3P306CA0013.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:15::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|CHXPR12MB999221:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f520c5-1fdb-4a1c-31fc-08ded1f72ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|56012099006|3023799007|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	9VU72/I7FsfFqAWXsfshldJu0NKYI+mipLhasYngu/4wsmkR31ypC3rUupwopuEzh/s2dwVPeI7x9/smaIrWWnyhjGYq1Zu5BuFywUKc1Zica15krE/LuJNDYW9fCfuzKQlFzhgLYqr7Swpg6RigkbobUmgEvQYdBwZTEAuJuQ8IUa+kAbMva7Ij+PisfakqDaL4jZDnSrmX6bIuN+fiKJPDi4EZAvZ+3ua3AFVR4HDi/9C45Z0GdsBNByvvahp+m8ry02kr/SZy7qt2AGWI/yJssh6fyD8sDpE3PUQD1Is9DBkFq6t4PLQXEFpotjaCP1QqGFyoQs51o9vBnLRHFP6NpvAcPzAujB1SHiCeD6hAeUqcg5y+RlA7MPvV6yEQG1r8LJ9K6SoIXzUbidorMQXY+D9YC3wFw6tFGcibKUUQQsPZAPalyTcxbMH4kT9D7AVcisaavjEHjNSHKT5LUZVkTLHFWDB7WZCcQ436SPU1ODPLqqRPkwUlDNyvlwRT0ORviPvV7g9LDkMYffUtH4ei5Dqrdl9tZe4wyKxA28A1gXS2ZMCccQDkTcJIB54gJzdcrClCcjiJyinqtSA+FoRMsDKaYL8h/n/BrOXX6sAcYtRuEDD6xiFZwHvDK34YJm/gRregyVZszShRziD5VabvuWjw4qAoLWcVxnp54i8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(56012099006)(3023799007)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y2lPBqak/xLAj5CNmF7ctM4TXOnYHyFvk8ZvLyMXnwEIDnHfBZl2omQLhAK4?=
 =?us-ascii?Q?MjVliBJlJklMV2uKIdCN4Qt4WPJAgN/ecFFrOHA8Og+Nc//2p94MKIRkD8k3?=
 =?us-ascii?Q?0fPGb4pOh0MTB923vJHFJRu3Gvj4dXoV9POc2h5kmDN1tD4NrPInL8doCWga?=
 =?us-ascii?Q?LdDjpO91fz1lHi/sgSyMhBNbk9H84jVJa+i7tqo7wN5nA/buxaclY6WS9VK3?=
 =?us-ascii?Q?eNdHXFWja9mCFCO4A+daY795aUcqE91WyqQW03u5tUKB6vFR+qyS76Q7gN8J?=
 =?us-ascii?Q?9Y6BWPcRdok4o3+H53cjKeaQxQPSYR1fMdiGLWXulMc1bBrFZzwNHJuhaWoL?=
 =?us-ascii?Q?58exludpjamYU0dXyNXWP7u3pzs26zkQ2+9ZbD3fxuDbmfcKuLFpzNJqQ17H?=
 =?us-ascii?Q?dQCwCdW+YgPdtSfRoOw3B0gY0YAzjf6CkP5A7FMtvZYOEBBh//Vg3T87UJz4?=
 =?us-ascii?Q?gaZzC0lxpRTdOsOjIvxxt/NdQ1Z07gQWFyZeYMQq86OIj9VxrBla0D9ju39D?=
 =?us-ascii?Q?6UcsJgODtInmVehPAxm8f2faNkBDToVxbHzZU96Q0thwcCYY6mVL87acYo20?=
 =?us-ascii?Q?7nkN2EIwLoeU2yRFQ67VdHHY9y+shYXnlkWOq9maCFSvVZVhgFySqaBhVIE6?=
 =?us-ascii?Q?s7Gt2n3AJ10PthTByJgBXMWamxf+GmEV8uKDKqSc9BTcqDqlVADAeCXDggKw?=
 =?us-ascii?Q?9oCkES7MTZyp8o4Q38pJ7jLzupcFYYHG2mIluC4CpTy1ntDFz7MCa9lflks5?=
 =?us-ascii?Q?2lWRbIj/BmmmnUkTLRlSsNGxTAOcpZZ/Cda0vzaHLpvkXtG9HBMDz60BJudm?=
 =?us-ascii?Q?gudaKOR651lkT2C19YU1AeSsgC3FFdMDwCLNL53y3D55+zUboE9UN9AHY1aN?=
 =?us-ascii?Q?gOvVjWIhkL56QAGIVlGJs+XoAgwjRiRzbcEZVNV5zPbhQbuDwjmowMUIXAsI?=
 =?us-ascii?Q?PbFMnMerjFmxXrrzdU05StP2MgAOj8FRUEPtnZXoCdsgYz7KnoueNJnK9ajN?=
 =?us-ascii?Q?C1B+u4G4tuLrZc8+tAvUVGV2voHOkKepS+XD01s2EfMzEyrvKRuDnLDr1z5b?=
 =?us-ascii?Q?w/2OSc1fuGs9l/IrRnk3UMSzNnbCyjeatOeUwPOAtMkdhPkQxn216iJIP4yI?=
 =?us-ascii?Q?+2ElSZh2rl5TNDAr7ed5Cv+KpDInyx9xQfaUHB+0+msd6TdCw2Y7wuR5qIRj?=
 =?us-ascii?Q?OYKzJH7g1/qYFmHqwj+zzlwhCToOU9Hy9m4N9FW2JT2vNJ6l61PO0dXddd3w?=
 =?us-ascii?Q?LCNeNz/HaKvQiTe6XrHeQnSnOQN8fVwrKbRCWHeCLvphK1Q1jyj8HJhceB8x?=
 =?us-ascii?Q?pucd2dTM75pv3evoeqbEElUyda8Mni1bM2QnMW4CuolxZjavl+Fj0BtrHUZB?=
 =?us-ascii?Q?m1hORsIe/gC8oz3MjbB5QTD0qWo7rsqqUJoUvf/xR1rg6h6mqc2Rvuk4njVd?=
 =?us-ascii?Q?TLMyYOQ2PS/QOBNPHYuL+vpEl7+5Rp8UjmLWYLiAHZBSP0G0rBrf/6nVLYRO?=
 =?us-ascii?Q?Fk4lE5711h/18lLjELndltoDolD4naH6LhpyIFa7XrnpqvHiESUhtnSGPEya?=
 =?us-ascii?Q?EEXVLIFW9IbO2YJbIdvxqDaG6OcAIFdv/3FpvKMHNNhQawuSp2AiPri+dFu3?=
 =?us-ascii?Q?eKUUF5zWkCmfO7019vmVdW/1gaZvoIOKbjoQy2kfJ8e0HlqujrH2RXWPqhYK?=
 =?us-ascii?Q?Zglc18On+W1BEfi409TncdYxbPAROvoGlhQIclTbQitV3p09RJ1Rax6ZABR5?=
 =?us-ascii?Q?9nO+W6ynkg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f520c5-1fdb-4a1c-31fc-08ded1f72ae5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 13:47:48.0285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKp1Z0mK/ElUQoci7seoMMYJB1kDwWcsKmApJ6+L0hbTQ9ci1I31HinhY+wJjxthKbPbIjqU/Lgo2XNCnqqBHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999221

cxlctl_get_feature() sizes its output buffer from the user's
fwctl_rpc.out_len, but the device is told to write
cxl_mbox_get_feat_in.count bytes into rpc_out->payload, which is a
separate user-controlled value. Nothing bounds count against out_len, so
a small out_len with a large count overflows the kvzalloc()'d buffer.
A heap OOB write reachable from FWCTL_RPC.

Reject requests where count exceeds the available payload room, before
allocating.

Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
Reviewed-by: Koba Ko <kobak@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1 -> v2:
    - Drop the reproducer and trim the KASAN splat in the commit message
    - Sent the reproducer as a regression test in ndctl separately.

Best regards,
Richard Cheng
---
 drivers/cxl/core/features.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 85185af46b72..9c714ee42a41 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -471,6 +471,10 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
 	if (!count)
 		return ERR_PTR(-EINVAL);
 
+	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload) ||
+	    count > out_size - offsetof(struct fwctl_rpc_cxl_out, payload))
+		return ERR_PTR(-EINVAL);
+
 	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
 		kvzalloc(out_size, GFP_KERNEL);
 	if (!rpc_out)

base-commit: ef0c9f75a19532d7675384708fc8621e10850104
-- 
2.43.0

