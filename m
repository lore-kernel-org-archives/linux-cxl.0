Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012013.outbound.protection.outlook.com [40.93.195.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA9A47DFA6;
	Thu,  2 Jul 2026 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983386; cv=fail; b=CchiL10+fZnY9Q/lCAroK8W4vnw29FNHHD8aBN3/9xwT/LyqUNUDAV+LfywVsemQvrjL+Tc+0V3YmEEWk+LoP/8hs/QED8rgd3QVsNeN0HoW62YkWlGOPQvC9C+xGS8fmPiTtc3lK4nH945onanKT7nRNxn+2nfRK4hLO2Z7I7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983386; c=relaxed/simple;
	bh=hoenvHEHGscaJJr4aWTk/p1UcDSKLsJRRuEpW34fkf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HjFccWel/66IChG5e4rw5NpuOp2eiQlgZwdNVzpzRz6hEqrRKYyca1tvNSqs+3yI9MUjUKyzbD3knKKjr11HLaQYyJezl3O5M/8DQhmqAnjieeENFE0iwH8efVorp2BMQ2I0z4eAw34u7eszL2Ei85Xft+Kfi1orxoaeuQPikWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aI6AKNRr; arc=fail smtp.client-ip=40.93.195.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aI6AKNRr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vC7sMQOMQvDLkMu6oVPXBAhyZwL2y/wgHHi4iLfRMbvbOocih6+ylXVkMyNvRvKGzLKi8c1UcYuULcxW/pKv1i5g4MMTAB2CrrY1Oi52OvrmemlAJXA2BuSrAIuhkCxVTokS5ALADB6FuPnLORqh+vMwWa9pO4aSOXsDtOc+nsBaf3cxGT9lU1SuPWMxGJ+bwYezaLxEDRJ7wDN3ftexH2/jn2iNhyX7tsxzruTcj0KkTr++oZieTS2E7sQcScrj6bTDTlxBmrsIj66l/osX9yNM53+pcKIrwBbZlqW/xpK/vdWdZMxj1wtkFl+MKF6rMeu4L/dQB6jt8FP1hCpmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXvWBnV1yxL+ZYTf7HuQXFhFoQ1DL06NBVXiuWoPbms=;
 b=Ev0MAE/Bbvq4djcgmrIaeiWd1zStOxNy0nzobeBTNEO5eB50Ge0y9PFzdf9Mgk3bYygYA5nf5RlO9KMaDUPC0SD8sSfFIyxAyC+aMyx5nODUQO4avD6r8CHjLjxg9+e0eTu/SQ5VGv8MiSic+Dmsh46Ewa2Q93b5G8MX232YGXIfgCcMbyC0//4xrGM4TC+5M3VIYfg1/jOC7WT4bqa0HP58BKNrQFlMvD6/lnGjjru0cx1JPaDiARX2PRjGc/2kQv/o9Rt2ikTa4Ph82hFbRCkoyijcKRtSaFR4FQ1/LRKJAFNXKXnwFBYnxBX9h4dbRoOSZxjkAoh+t8VPcmrZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXvWBnV1yxL+ZYTf7HuQXFhFoQ1DL06NBVXiuWoPbms=;
 b=aI6AKNRrm3riVu+zagFn8LxsfEhtTdhsqHXbgJK7S8G5g8jXlHZBXwdZbszMXDNH9/5/EHMVi8v3g4n3aYjQiHxfP6iFO/HR6g7+7X+FgfvmlvWsgJyl4cQiCivXwUp1CUokI/wMxzvZSmKzRGoVbH1Sd1CNpVfEIBBazilk+jhvhIujdZPCtG7fDLfppj01B8hZUDBZQ4Cs/MkS166Lc5/VO2rjUkD7Nvb2V+y669g6aS1BSdPDwPg/0GET5iBVEYkPWlKuh6ZWzn6MF2AvCizYC+qx706oSqQuVTu5ksKYtB+r80eAcYT5/MxwLQy9sFzMGTGT8ndbVlg2FR/Kng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH1PPFD8936FA16.namprd12.prod.outlook.com (2603:10b6:61f:fc00::624) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 09:09:38 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 09:09:37 +0000
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
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v2 5/5] cxl/memdev: Don't overwrite the error from an earlier partition poison query
Date: Thu,  2 Jul 2026 17:08:49 +0800
Message-ID: <20260702090849.47501-6-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260702090849.47501-1-icheng@nvidia.com>
References: <20260702090849.47501-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0013.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:17::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH1PPFD8936FA16:EE_
X-MS-Office365-Filtering-Correlation-Id: e59acf83-fb0e-4660-e53d-08ded819a421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0/ak72AFEJ5Y7nXG4DovkAkDSWEQCxFEm6ckQslP69v3Y6ba0cX6QBPFl/FCaE3YOv+tWH9lQPzl9jGSjUaCuUqeTlr5y47WDujBrOVkBpGovu3wm9vOwzDEV4NwD1a64U/gcIu03ADkdDfL8x8iAyemxUI5By8D0S1g6bv/3zVWf9S19NbK01kemqsMF+OpUCrdPTVL0u9GZGEe2/VQdbVI8v67CWw0A05PAxqZXtBlj9AG5FHK34UI5vu77CaWA8XPDUGyTgTmzPsx5TXjxkr4x+Y0nEHFYRpFE8AIP63rvWSZVG7uIIRpd4AjoF1IW2MLFaRi0g0ZmpFkowuLOS1eyLIzgZJzJKpiqtFVnvjWVfMm3hbqJVROb2F6LPyocythOd1gekImYWDP6yfNuSnqQXarVPl38JKn+hRfL6czh3U0l/qyy8EVL5GNeuHPvQSx855GJyPuLZxPpGO0gCBiP+YgIQ3f1hP7Dd1zUbjU859qvdZfl8ps8brNclESjb6Hu4qOy0GABSKL2+KxUXf0x7QJaFmxT2BKA7ztSfKBj3uFXXTdGz+Fm/Ur3cUZ4rotHSngWWmgS5augsjjaVRoOKrsUiKbByWrwwC0LBm6PgeAc8kll2dC779qFpzX6VeNvr6jkgIW/xTgQembsB56gX/I/T4ToeCH8+snnvo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FklNcIFMujT9Vg1ZG5FRpoHVpdpV9wobHfGbHB4j7khhBcFnrrNZ69I2sjEr?=
 =?us-ascii?Q?XDxxE2a/O2OPGXJl5RO+MWhiw0uc127asFFKAwIO5evnXh0iIPzGri1VzL/1?=
 =?us-ascii?Q?myKWd67XbfdiSuYsjDR5AGcO3h26SpwXn6Qh8KW0HPdQYDlogNLpuN5Q4Wk/?=
 =?us-ascii?Q?D30ZlqZDpD5DZAs7znPMVgTJil28ttnmr8DhOe9FwXvIEixQBPV7QvyaANA+?=
 =?us-ascii?Q?0V7Lr8h9L+QeSv14TWFc4Iil4uK6xwmW8RHJzaNWgktBhJjHuG01jv78oyJa?=
 =?us-ascii?Q?+EB93PLxsBNC0uuth52hYXdRn82BhwOxT3IFfxxTIzKOGK+CIt0Zdzsr+cwA?=
 =?us-ascii?Q?963DOJdFVqqnzqmAs0OvRzlSQSd1rVQYa5CG1yv7iAwTUMZSQxOacfLH++E4?=
 =?us-ascii?Q?vecH+f3hCQBu6Afc7Y6hVDRtBvnmJe5lAefHvglU2fE7r+AEMPQQ4PlaPLT5?=
 =?us-ascii?Q?7P7ELORloGnr2RXO5YE4Bl/PWe80ZiNffdqvTRyuQSafjAcvbszutHb5U93S?=
 =?us-ascii?Q?IYBoU2qZEZNYf7Yx7TznfQ1e3Xi74M6JbK9SGDrTkCYrAgx4WZz3qvkLvnKK?=
 =?us-ascii?Q?jDoFB960TOZMak5DJ0NcDz0R7RhotW3llLxD1MRsKKwIHxOFYpxPVITcJdRO?=
 =?us-ascii?Q?ZbxoH9zbZ+qbVvKzwecP7Ql7cpob94Nq2K/SIcuqm4t9e9LEdbQ5DpsWBXml?=
 =?us-ascii?Q?SeCEJHCYLtIARW7/oSg5ca5OAOs3tOiadhybOm0ffklVCbnqexPMtLhLQ+Lr?=
 =?us-ascii?Q?G+JqPkIpKmqv43+vHeiht7G4uVyl1RR33tQeDzrkhVOfT+Tc7wbiGc98b2hv?=
 =?us-ascii?Q?P48W8yN9P27oKzOczqO/TnJ+MYQok2/kDlb2+jsL7BbxRdBNrN0z6zJ6/q4h?=
 =?us-ascii?Q?NIfsxxMidEuk40RUIwEfg1pe3o2zo+WLpaOPlVzWOeHu9Tc1yvjiApU87re3?=
 =?us-ascii?Q?lvMCPIbAFRhpljdPVtMOBYLBd8HQMtOl1tMPRv9RTg/Ra+d/ByMbUlCumLwY?=
 =?us-ascii?Q?Jar/i4fqlZnWLOKguUkP4t9KL4+R1z/VcZK9nrBwst1N2iAJjUYHwDLBMWud?=
 =?us-ascii?Q?QoIeKcJlMzknWnKJaDSG+gLEk+6gzHN3l+sg7/utPzb2ZsgHk08+j6NnsROj?=
 =?us-ascii?Q?EQpMu3NRZRmSv06LtEC5ZsaMUaYGjGEDVA6n1T8xbKo+8/THLRGW2ZgFLW6V?=
 =?us-ascii?Q?/T9Em+IPtln87Xv6c/Q2+ySyXRV/tdxkrS3sPzPUApJmEv7Vt57IP0eaqa79?=
 =?us-ascii?Q?G3zXJPsq9Vuu6EMumUk+NYUQCKGr7z3Tl5e3lsU7ul3/mccioWqixscZIyYH?=
 =?us-ascii?Q?8rIzUDgekTrnqDGSqM2QHKoFPVOjJeqA+XI3BrsiotBFH/fHkv64uvlQ/z/u?=
 =?us-ascii?Q?XHWO1pPfovnbOccUT5RxQcc7X6y8VkIxDtqF1Qr0hbjqtT/8610HvJNLjAq0?=
 =?us-ascii?Q?Ow48b5PlOKfTy20jrI4+9q7OBtziDjYYGYGXxpw2gfISIxCYh75Y9gAwcsGA?=
 =?us-ascii?Q?a/dN5XWDuobzv3NJHfNlt7oewXUzJhxnelhAmIrLR1e79D0Oa2CQ2vtAZLUm?=
 =?us-ascii?Q?5mfmKMY0qnLH2E6UMAHp6OOzCjeITea3t8gHI13Xk13JwAtXTyEtMFHpYNrE?=
 =?us-ascii?Q?A7Dkbn+9vhGM5cEl4ujKa8zqpE/DZiC6aIxpOarPciUDTakBZRqPLZ4oDzvG?=
 =?us-ascii?Q?o+qwFzLj/VMJ6VVOonjL04G/KOM/MXLrgsxiazC4n7dinFNQ/t9078F+ytXp?=
 =?us-ascii?Q?b36TlXu25g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59acf83-fb0e-4660-e53d-08ded819a421
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 09:09:37.8683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ov0ewPAjRdQBSRs3QWdt0enJAc+ry9eTI5xZN+zmOK+4e+wuv2B8/OvDrOhna4qHWrR8naXxYjQ7d2FkWTGMEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFD8936FA16

cxl_get_poison_by_memdev() queries Get Poison List per partition but
never checks the result inside the loop, so a later partition's success
overwrites an earlier partition's failure and the whole scan reports
success while that partition's poison went unlisted. Before the loop
conversion the PMEM query returned early on error. Stop the loop on any
error not already tolerated as a RAM -EFAULT.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1->v2:
    - New added patch ( sashiko-bot's report )
---
 drivers/cxl/core/memdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 33a3d2e7b13a..8718964b9c5e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 		 */
 		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
 			rc = 0;
+		if (rc)
+			break;
 	}
 	return rc;
 }
-- 
2.43.0

