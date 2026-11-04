Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793784534;
	b=Q8YYEpmdjVTBybdhQjMgCzCip46nPwq34xV7lkK8rDB3qqBO+3ArU8FAQ2bpAf6UTkHa
	 92/JKzvotGqyOZ4ZGC3UJbeIWs6NKqZZPgtuXzfiIsmkdp45awHeNIYcjLws0uHj77HB0
	 9P1rzoh2whyZb3WIlf/0nOoWr5mDjpvZ33zvGqyUnaGYDrsAbeDKKcII5Q4w/P6gF8uBw
	 +ovTgpOsLo3E1EFyHf/dOkqt9hBVi+EHA1h3pNVLOAIUgXy5Zmyg/XQH2WhXkSncS8mpp
	 mDcd6skYbFnvRCeye+gK3rcUdfYyplzz2okkqHeJsk0XvC8dolmCC7JgZKfq7Q8YIAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784534;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=z6NprCUBat4+8W29vvXp0PNk916idbZxztBECMcqr+w=;
	b=T8Vfi8zLOudKbYTY1+95iFtyYaSpWqW9LoH6u6+kx8HNf4qN2e6YkJT4P+nbl93aBSV5
	 IwzQ6I4LmV2RwC63CHo3sSVmI9ULjeS8s4RVZwGcMMParHs+C4s38BxreGyscPYGPNyIO
	 QXcoDpJQb8SL1Na7pxixXItnGD6DH3w+oP7meBBYHgk4N8Mt4FEGNT16o/eLIEoVynIqO
	 ONaBPQvEGnKEzYep2BH5Lq+n2iweiyJOVrITf2tOl7eQpieWFm8H7Ccse8x5vP7gwDKIy
	 9T9rCwTQBAn9B6nvuekU8CsjBz1YyY5qL6eWl3K1GmXOzf72+tsVuVKMU+AD7FdMukQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=i+GF6nKb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.45
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B7606A33B;
	Wed,  4 Nov 2026 09:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 054B7606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=i+GF6nKb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rb1+T+X8u9LYD0FsqfhtOnnKsN0exmv85i3HgbTE3Ztoga3Yzh7u1HQS8p6RkIAjVOI1l7Ke3+uDHjlFq5AH09IPXUxL6qee/+gfNnW5y5HV1ElrohunarQ+S5nwJpVvi9s3LsDNujbr6swzKoFq27pPvrPwtrnlZTcwUipMJl0LyMI96jP0IKKqaKkM84Wf6AeCL0YFtKw7wMRi68fuSMlCo//zzHBP8YoXGJRqsM4DMGoH4Cn5b5UwVPMfzqEN11RUbCe0Y9ua5Kd7M+s7HuQ9+u4XLDajbw2jw6vujplpcMDwWMUdXLupyrni5d5QP6RxVXoAP6FOOFx9fRE8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6NprCUBat4+8W29vvXp0PNk916idbZxztBECMcqr+w=;
 b=SdbO2DKfYkwett/omXElTRX47I1KVwIaUyO/KE24Og0o/tuyk0tQ9bAeMB4oegl532iwQPlXVRuoLppX1rhQQeqBDKupX2mlYlRJ+PYPmKSRrfH34Y/LDVolkNGGEzko3XhUnZbES2Zn/pzzrMk0E1I6yiXNEuvW1pM+iLSLCUZKFhjimI2Wl8sn/stiLfUlnIriEws/jA8t0xxT5U4QA+FZf1OPsyzuTEA7U9H95/bZnSV2V4LRWrg+VOF+5rvhxs0jmmAvQp4FkfkPIZWM+fQUixTp/3iBe8L8iiS8riWdbnAyKFs04ZPUv1qV2e4jsXQd5QyTFo2s/iHwseXOQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6NprCUBat4+8W29vvXp0PNk916idbZxztBECMcqr+w=;
 b=i+GF6nKbVw79OZr5BcPxMd5wa+mhpP+Os77mMuNqduX8Y5TX+fllQe8AOEbK3M3HWFFOc+NGK/HcR/Esoy+OhhwXWZUOSZIPTfBoPoFNKt7nl/aG5ogZS64iM9y1QNeyHhAtKx2qb2GsPlsd08OX5FBDLHBrql9mUj9X8t9gSV74IAQzvACUn129ZawtGRVx+fPnQChUjfllfDs4GLN7WTXiVimKY8+RYKSpnrCJqtoX3PJnCoDS/GeS0TWWH0x9HwzGynm6PoPI/ruJNy7xLsr0clJBWb8lz9U+nmHTXkC3TtvhX63fjbApuwbYsOLYLwILTffa/W7PMVhrw8QsIA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:28:49 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:28:48 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	gourry@gourry.net,
	rrichter@amd.com,
	alucerop@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/region: Fix target accounting when detaching direct EP
Date: Wed,  4 Nov 2026 17:28:40 +0800
Message-ID: <20261104092840.56715-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:990:57::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: f980273b-9487-4b8e-8229-08df3a5607eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|261021121427099003|261026140227099003|261021123027099003|261026121527099003|10067099003|261028144727099003|261102123227099003|261009223027099003|11063799006|261022105027099003|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	OZZKp+sd4pUwU986/zZCb0VmkWrYXdYw2Zs75NwviFbGdP6VjzH5rtFx4/6DJfKOciAlm/qOujf5N1sFgTyBfaETX6bZ2L6xmFGNg3A53W1rneGWTfKkRe4H/CNd2mGuORL+6t9/cWKu9WWJ4fekqAlQ3bj63HqbrTXTlzoIEanCfx6D74zLrdiWNqBup+BAg6geuMItKUq1/TAS2M8+6eF9wqEWk3gphahfqN5nCGR+Fm3Qwq+sDEL26sqWk9NNai62uZcIHbryHsm4CFuOlQnrO60fzADuQR3uKyor3LSGEkzOR38W9oL7h3E8wdnhltcstcb22bvvB6Pdn7tnHnorhWY7TME43f251MYeVyDRtei+QmrpygywFRgWDFVyf+IdaR+NLUFdmx2aiYvDo9TJWAhb3vlxGtlcG/RcsQvP+lBwj8yZWDftG5aLvXWlfjHfJ7dNm11sMKZ9C8FYH1+sp03IYImcK6xhGt863FCj5bq1K3eZFMflBKsskJL7uv3UM4R51ocEd9alWbkpuod++E373/PBSi8TG0+w8QQwlH5e25vqL0bFXAw4AGLsXZ0gfTnw7oJHslM1zttie2PmOAeGT9GO8iWusGrORUKFnwsye5ppdwHVAHcMq/qWGiYbdZCn6n8BAUYvcQTxuoXYrtE7Ol8f/DJN6CYJpXA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(261021121427099003)(261026140227099003)(261021123027099003)(261026121527099003)(10067099003)(261028144727099003)(261102123227099003)(261009223027099003)(11063799006)(261022105027099003)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lFL3CMddb7RD/R1IUDQ93pOeIs8A52JNnxBjEtNR0opfUanM5c5nqfeWMwfn?=
 =?us-ascii?Q?bplETKjaERgxeQ0ffKMbaXcp3gaF391EGj92nWptMFOvN6pQKxHCuK/2hDcy?=
 =?us-ascii?Q?B1TFoVQZSWdV+YW73h7wIk79QaEjtTzuM99pDFRs39biQbWKkT4jwbJS5F8f?=
 =?us-ascii?Q?/5qYrJqcI67JVfQexagYdkfe2l6ZpAFIxPSA32Ql5uPtpsDuhhVdZxvLHhgV?=
 =?us-ascii?Q?2gTe7XeuGwFEI5oWZt7Lf+fspz+wZFmtTKYn61LPFCehFDuriwHxodCyFIna?=
 =?us-ascii?Q?/I3h9b+ZZ91Iefx87ZDx+7WC3Ek96gn8NJJYYvNAkUmafpIsfHt+fJjPhIfm?=
 =?us-ascii?Q?sxOoPgMdvi2aD4VVo3q0C/zbG0D9/dIgdyZ4Gp20qdKjLvGmSBLwcfOIo8FP?=
 =?us-ascii?Q?mbfi+qz/uGnKu1FMotg1w50OInYe5RVS+9jww6k006js+pN86RPStd/rZqqb?=
 =?us-ascii?Q?tssoZDQTcok0/uZZ3J+hIrKiAcS9uBTtE9nSEdkHTXTThnlSRvCBy9ORV4Xf?=
 =?us-ascii?Q?VqbQA7aW9Fhh4YE3Q0LW9sLELTkIm/pQoceAudZ9RvBpU2kY4iMaAndgdlRu?=
 =?us-ascii?Q?FgwKTU+qphLHr6Z8LbK67WLXVCFTNjXlaq4C049iRvjYuh+0qDiCCNHeHj+t?=
 =?us-ascii?Q?1fRUeO8dZFnGneka7gyndWI+LP2hTCsX+zOMxpNBCTEyY65bVZAiOCz3jnj2?=
 =?us-ascii?Q?O6tiEJaNKYBc5a7IQmLSHpHmO8PxlDNhVzpFw5MHRNL+nCnMK4Ru1lIpcV6V?=
 =?us-ascii?Q?hwpZ8j+ke+4hr1tdIblylxYrvcxOLkt1ABdGG3ccUggaYXnR3/8QVJjvL9e2?=
 =?us-ascii?Q?RQFnXnIUQpuCbpVN9pXrw/yVEJ+n2M1nwy0Khd5l1VEilOraT3P5Sy+IFxK3?=
 =?us-ascii?Q?2PveYSJpRmbr+NPaTBwADtDpHbWBgzApHa9R/aPX4YkT6h16YRzh6pQ+dy5B?=
 =?us-ascii?Q?lG2ZMRjdZcj7OFTdS6TfblbeDeTACIdQLlyToR6zs3fkVtSKslHzN9YVb1uP?=
 =?us-ascii?Q?jqmPCOZsOthqOEhEW6X/5P7oSVZ9FBhiVwsQpOA3fBZ9JISgYrwBLQnNgIdl?=
 =?us-ascii?Q?all9o5dDp7LTtqMMGwYkKRsZ0thovKLayz14/MUUXoNVlFfOsNKtADrprJnU?=
 =?us-ascii?Q?5w+agYvfruOCTYTGjRemDbs262R5xdjrdmspZo8z2bK5mrWfEDkLVN3eat7t?=
 =?us-ascii?Q?eS4lziYwofG4F2zUTBecU71XRLuzQ0BldsLjeQXlItgFAnS0WhfUVf4XwO/p?=
 =?us-ascii?Q?y9cqtY6pOaJoGfJu0ZqOaD33MscHDCTy+6G447H3xkFYifSnJTY1WfXEb/26?=
 =?us-ascii?Q?3AoxSM9BGMKNCIfk1LtlGaxOdnWOAxJqWOlY6GxqqIp435DD+0ew41Saed/x?=
 =?us-ascii?Q?eQqY9l3r6JOeaFg597F+TTb+mfwRdoLmagAnGhfOFvLra5+86gzG9/25rgV2?=
 =?us-ascii?Q?fxZnHOT3YKv6lAFWJ6f3zTt46YXc3o/A69RWGpFJTRsFw4QtA3rI5fFvyPJn?=
 =?us-ascii?Q?P8AtBXA8y9k4J5LWmjt9Zjqt39Sf6IefxhglZ7tXgucZ1Hb8/S0k2m+E3E6k?=
 =?us-ascii?Q?vo0IhxhT1MCEE5mz7eH1M0yq+mAuXrsYNXBPLyYY+YkPAnDqtMKFwnfajYvi?=
 =?us-ascii?Q?J3/YkODKNskoC3lymgcIjI+/IK+RKzK+tWgfPFkORN0rQ8AFRFVZXwAR76r1?=
 =?us-ascii?Q?3x6069F7TtA9c+5crlPdTPSiotil3Wnu6q6JM1LqbOClRonRlK6szHVRj5M3?=
 =?us-ascii?Q?oA+bFpWykA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f980273b-9487-4b8e-8229-08df3a5607eb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:28:48.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tb4FkS/uXvUWvPkGHITok2K1IvNATj7X35FC2ZTVv1A9LjCx8jLkDjqOxnFvpTfbaiQnYDphc7ggZnKLcmdWTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236

cxl_port_detach_region() avoids decrementing nr_targets if another
endpoint in the region has the same ep->next. However, for directly
attached endpoints, ep->next is NULL. Comparing these NULL pointers
incorrectly treats EPs on different downstream ports as sharing a
target. Removing one endpoint while another remains therefore leaves
nr_targets stale.

E.g. 2 direct EP using a 2-target switch decoder, clearing one region
targetN entry leaves nr_targets at 2 instead of 1. Refilling that entry
then attempts to add a 3rd target and fails with -ENXIO, even though the
requested config fits.

Decrement nr_targets when the removed endpoint has no next port,
regardless of whether another endpoint also has a NULL next pointer.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Tested using tools/testing/cxl in an isolated arm64 QEMU/KVM guest.

Configure an 8-way PMEM region across the 8 memdevs under the mock
two-target root decoder, reserving 256 MB per EP.
Run the following as root:

```
    set -eu
    sys=/sys/bus/cxl/devices
    region=region3
    r="$sys/$region"
    decoder=$(cat "$r/target0")

    test -n "$decoder"
    test ! -L "$r/driver"
    test "$(cat "$r/commit")" = 1

    # Clear only target0, leaving the other targets populated.
    printf '\n' > "$r/target0"
    test -z "$(cat "$r/target0")"
    test -z "$(cat "$sys/$decoder/region")"
    test "$(cat "$r/commit")" = 0

    # Restore the endpoint decoder to its original position.
    printf '%s\n' "$decoder" > "$r/target0"
    test "$(cat "$r/target0")" = "$decoder"
    test "$(cat "$sys/$decoder/region")" = "$region"

    # The restored region should be committable again.
    printf '1\n' > "$r/commit"
    test "$(cat "$r/commit")" = 1
```

Before the fix, clearing target0 succeeds but restoring its decoder
fails with ENXIO. With dynamic debug enabled, the kernel reports:

... overflows targets: 2

With the fix, the clear, refill and recommit sequence succeeds.

Best regards,
Richard Cheng.
---
 drivers/cxl/core/region.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a048bd5c06cb..30686059ec7b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1344,7 +1344,8 @@ static void cxl_port_detach_region(struct cxl_port *port,
 				break;
 			}
 		}
-		if (!found)
+		/* Endpoints with no next port do not share a target. */
+		if (!found || !ep->next)
 			cxl_rr->nr_targets--;
 	}
 

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.43.0

