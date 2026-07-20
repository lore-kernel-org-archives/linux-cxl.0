Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2E14086A;
	Mon, 20 Jul 2026 02:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513233; cv=fail; b=mG/h4BttZ3VZS7Bg0B/yx9nqzwxaGFK447bMMDO2nCsWeacUHGcRbsg/VYnVMAp0kWlqfc9frxdrCtCcY87lwlDWwQHIFWRFfKD5HLiOimaZylv9UlPyg4Ldcd9+16giDr1mlnGfnpJmVXhaHjnww+49mJDWWSCpnnSBLh+e9Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513233; c=relaxed/simple;
	bh=DoWAsJ+XsgXOa3xfvjzDKb1FVAzkvR6EgiCZAuUEN7o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ud6sLM7JkR2FNOyY16T6iOC6A8u5YNIOji3R9ynCONBGHwtjBeaJOf8RSPo+P4Z0ThyFz5NDcpcSG1y9lVn1OVvh84mNqLpeT+PpS827rv+z2BN4+ZLvG1vjlKdH5X+0DQ3wsOxwrEztTF9tHO77mokWz7WB0nfCUZGdsM5gsuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jzhFhAQ4; arc=fail smtp.client-ip=52.101.85.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jzhFhAQ4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BabFbAr1OIxNZUKqvx9VvHfb+YM0Mv3MmyEsAvzsk8eF4aS/T9E0fFLuohoBFu3h81SJr0eidLnwcWWb8xZ/0EJOI7dgcHpIZ19ovnCMjZx5c4aTZgycuLRIv/vCdmfiVIlphl+UVzanXxf2dH7Fw+izH/rzZp2N5Up3Ype8y56ZKFJIMni+lo4P3sGJ6A6UCwED9EfmyTnic0jJDV5HURVI/UqlmenzLsyzHf7JvmV8Qa4jgD7RHR5iv4kZ1eKxenU5vlpDQBQzCZ+USE0oh64Q5rqxi+vj7MNkmofGSO966Yl07elbgtNXAfQcLTouOoS3WMIa1ZTK14yw4CkoBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c48qZLa/B/sI+2tLwAmuhQqI1A/ErWfJRUtg/y7R28=;
 b=xxL3TDsUWwsC9Or81ejJAkNYYE1+0u2k74Z5njHVPBKDMfSKEBZNQ+q9Nyyt1efDfid87TZG9Pa5GpAY8gZ/1mfBka7K4if8sNsWRgXBmr3xl9ZKu8z8rRcKYibjUfIqEXV/Uec5R2UeQR/CpZqkJCtW1U8u2Sw5awWH5UIiqk2FiaUBvxSHWMd5clvl2Z2534NATsdM/ptYxkMu8HDl7ciuvI8sLPKMEDkr5m0M78WF0roLw6Z3W8vUridjsBkXPMkGPgiEKRQ61x3luff0Q/QtnLFFL0+VjrShWU3FCroXip7c1B8TVApogpUQlwUMOmatl+/Ug6zEpeMVWZsbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c48qZLa/B/sI+2tLwAmuhQqI1A/ErWfJRUtg/y7R28=;
 b=jzhFhAQ4eA6Rt7pIyETu+z2UrW6mgVhZj4fSfgGoDqraPM1L2MRh5kiodVvU5nw+bn4eTyQ5KvvtH1onnaL/cd6jWhJXxbLew0hWfCnNVxC9en3ZEWe8yrujJqy3rAmdeo+lsCBKTH9vmdFlpSu/nUtSaZJ8/aDERRdB4U1l/+u4amOwJTDPyoaXxpsOfvpyB3SwZi9/VEwF7H7DSplSy1SdVbJXfWZRK1RZJ1U0SQW4sd7HIWnPr2Y894hLnSUmnNO6GVc2sJWX8ebAxksNTx2gWRE/Sofk58aoWGd1AOIAy3/aW5YYVbLJ8OWDiTIYICymWGl59nFS+84B1HmDfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 02:07:07 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 02:07:07 +0000
From: Richard Cheng <icheng@nvidia.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: ryan.roberts@arm.com,
	ardb@kernel.org,
	kevin.brodsky@arm.com,
	anshuman.khandual@arm.com,
	yang@os.amperecomputing.com,
	chaitanyas.prakash@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH] arm64/mm: Check the requested PFN range during memoroy removal
Date: Mon, 20 Jul 2026 10:06:55 +0800
Message-ID: <20260720020655.9607-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: 6894345d-4d04-41e9-ffbf-08dee60399d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	xAMEMd7r12akk0dUWLgcPH9iDcXHKGiZyE4z2lY2QrKphe8amqXshn9sGfCNqYPCv4QtKYVx3MKKPxwQNZ8lg/TMv7cFY/fzK/sHo5X67CiBegOBNsGBK7j9+tWtwhDzmGP+BlT6GwW2qmCdnFYnGABmhzmHz0s+PfNlDUX4MqUh8jd7L91jEiBlqKO6+qaFWJCoLgE/TXPE1OyNInaZb6I2uo4LJb7aCe+JGl/3U00CfYLeDkVjiKjUWEOhUpLmNigr9KKgS/CmQx9HjAWEmwssLPxiNtOrAceMOUZIz81zsEHkZREkkH6QK0cHZevCy98rN9UM305RB+9z97LMHNcK9t98E1PDV3dfWt/XAu8L3KSLCgFOV79X6Tvjl1FxJVjEsR2na3vv/lzv7fNxY/cyFa6C0sf4v/B1cHwJ0ypogNvc39/J23Rmu6BlCUyH0+dNAjLskktYbmoGcCkXa1WFrm2nwEtu86UNTnbCmj0/nM+/ZW8l2SNoJtYKcwsneXk9l6VVsazroiNk7ruv0D37RrFhTCfn5QjPYuM5Tr4KgbqO/u3ckOZxxrW2AMa/K2CFu7qZIXrvyOfWhSeFeZm9aHSkWvOhnyA+3QKXW2qir0wkN6o5s54hVaS3CRNWLdc6MUezlCjLgBASKD2aWpeWKjbpwFRjaQqKkBICkng=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OkLCw01yHA3V20RSzDHONagkSE/YhuN8eF8OGGL+c+rcVgv8z24Tou2PUFP2?=
 =?us-ascii?Q?e/c7Zjab/zluJdB7Wxcsj7JZz+7pkLXwZBBzkrdZ1yvejXfyqNnxys+MN6Qr?=
 =?us-ascii?Q?jqRyk0dtp21oXtEvv7+LAmQg2lIdXoubSwkbBalfUvxDf05xLaLDmPanQqwC?=
 =?us-ascii?Q?YP0Ya1yBDYqGZQb+pM588F6VexsD8cpZUDJpj1NRiM8igtDKsiGSZuHLDwgw?=
 =?us-ascii?Q?a/S05PUC0lkZEnnCv+QjQ4WJ9f+mxxFZSiP0qbT88ROoiA7+cWVpseqMygYX?=
 =?us-ascii?Q?pdvE4VhjruLyzozwES/wd7MIm1Glxdd+yWMobF9rYZy/ckVl0RHUjfH7Wnas?=
 =?us-ascii?Q?j7WCZZSuOrAn0n0I20M+nZYMTghq4KLf2YJgE6kg6yCC74IsctY1xpob0di0?=
 =?us-ascii?Q?KWemho75JMuKTf4/RQqVhdzzG9Vh4L+vlmf6Z0I9D6W4itDu+OYNbcqNiwmf?=
 =?us-ascii?Q?sfORpJv9DEyBcQzJuuA1R4sF9HZJMpKGx4pAVrQTSlULFEODTCeCDbHRYc4c?=
 =?us-ascii?Q?GPhftB70KyTkqm7UsjDL42+OtDAPci5qDzJPaZw/nVuHsKTvuMUw7/hJy0ag?=
 =?us-ascii?Q?pxuAn62ijiym1QWJtLMkmODfLXsPm2xayJfCesExxEfIrfdKYbi9K1+7NDsd?=
 =?us-ascii?Q?duLk5vPJsc6CcaGVwJuNjfnjXNFHYOpf0/sn3WF3m96tOhN2VtAc5FCXFmLS?=
 =?us-ascii?Q?QBjUhqVx3hR4AEBvJnpKRyEDeidAftzvSnLI/rsgUY9Tz7JUa2VUuLoNoO7c?=
 =?us-ascii?Q?qCiqejYlIwRNB1TlUdjdOVPhR+H4GDJI/GOyAv5mV4q2n9dRAK8BLpKftvLc?=
 =?us-ascii?Q?26bDnS0u4x92100RnleluezLs5MCFQxdk75G+loHoKI/U2wU6paMmHOr8noM?=
 =?us-ascii?Q?BgjqI6koXeA8TMhAimnYBhO9QICRBmYWrlIIyac8HUMP/ed9zJFFSCffYUDJ?=
 =?us-ascii?Q?vutgCZSPVIgix2+jDZ6t1cqo7HgjoLgfg5HhvpN/HRR08BC+IKpCWPZjKfyv?=
 =?us-ascii?Q?0ZkN007Ej79I3wXwM7RlQMr2mEzBfSuzi4FDrEWzPSaVuKHCHNV9KgjAEtj4?=
 =?us-ascii?Q?IOGrPE7fvee8qMfAQHVdr/uWlDQWHTkjxfOU7AwxMG168gTnY5G/mAhb/1kG?=
 =?us-ascii?Q?2RIL3TD7dbqPO1bo7C4oRS9jral9DJMkphP4N/vFituUW0qz1E7GWPvIzpUu?=
 =?us-ascii?Q?lD02IXSskAZf0gdUpBTvm13UZm0w1I9Kzoy2BiyOWyfGBZq8FXgWqlgEejjU?=
 =?us-ascii?Q?gyJJttZq7X98GqufX+vcSvy7th+YLEo6a77iOVL65941xWJ7Tb2sqcE5rIXU?=
 =?us-ascii?Q?T7h3b8QbViQMGtrnwcSDQ1j6S6bd0475Upo9epqkDEKbXKAGfyUzGlQ3C7yl?=
 =?us-ascii?Q?PdhlNuAVB74p5gM8MVVtYZS3SDLgnopNRawpClIBq+744UQvLDcI+KPTVW7X?=
 =?us-ascii?Q?mEDxQ/yKUr6AkWnff82z8CLO4JEBJATLUG3xMPAGV47NEBuS1tmJk8Igpx0L?=
 =?us-ascii?Q?RCjDWEBHgqjoP9+KL9FZXOzAXL2p+PxeGSabOy4oy06pylDLE+dHVqWOKEnA?=
 =?us-ascii?Q?KU+Sr6AIaPke+r+CAvok3iiWrSB7pzUj4w6dX34pTSjHf6HXAInDgd8YUUUy?=
 =?us-ascii?Q?u4T3J1zJ1MFoZG5CEp/JLAK6D7pZ7HoMC+AAoBYw2ToXledURPtwosEhMft8?=
 =?us-ascii?Q?oHD9s34hnUAqLv89gMsUkAv0rnkyUpdQkC4YvcjVjjj+qKZr9EuVhuNOUib8?=
 =?us-ascii?Q?Ru0Zo+T4TA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6894345d-4d04-41e9-ffbf-08dee60399d1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 02:07:07.7307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRr4vBms9StM97xsxHgzBgmfUI90pAyuPb5/RIb9WpFiVzFY9HHBPRPEKcm+AVE0tr8cWeglvDCd72VTW2xkyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200

prevent_memory_remove_notifier() advances pfn while checking whether the
range contains early memory. After the loop, pfn points to end_pfn, but
it is passed to can_unmap_without_split(). This checks the range
immediately after the requested memory instead of the range being
offlined.

Consequently, valid requests can be rejected with shifted address range,
while an unsafe request can be accepted when the following range is
unmapped. This was observed with CXL DAX memory, where the final memory
block was incorrectly allowed offline.

Pass arg->start_pfn so the leaf-split check examines the requested
range.

Fixes: 95a58852b0e5 ("arm64/mm: Reject memory removal that splits a kernel leaf mapping")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
The bug occurred on a machine with CXL Type-3 device.
Branch: cxl-next

Before 95a58852b0e5:

"""
$ sudo echo offline > memory557056/state
write error: Operation not permitted
$ sudo dmesg
---[snip]---
[440008000000 440010000000] splits a leaf entry in linear map

$ sudo echo offline > memory558079/state
$ cat memory558079/state
offline
"""

After:
"""
$ sudo echo offline > memory557056/state
write error: Operation not permitted
[440000000000 440008000000] splits a leaf entry in linear map

$ sudo echo offline > memory558079/state
write error: Operation not permitted
[441ff8000000 442000000000] splits a leaf entry in linear map

My fix corrects the checked range and prevents the false acceptance.

Best regards,
Richard Cheng.
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a25d8beacc83..18a8b0d3714e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -2194,7 +2194,7 @@ static int prevent_memory_remove_notifier(struct notifier_block *nb,
 		}
 	}
 
-	if (!can_unmap_without_split(pfn, arg->nr_pages))
+	if (!can_unmap_without_split(arg->start_pfn, arg->nr_pages))
 		return NOTIFY_BAD;
 
 	return NOTIFY_OK;

base-commit: 5ca04f3ba91f1773bbd5da6d9c654ccc1ba7831d
-- 
2.43.0

