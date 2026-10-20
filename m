Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792473269;
	b=nQjhoYTUwEMBYDsXV9iQlnq8Y5qVfzGuANvH+8UidDyRFYSJN3RId1cg2o8LqRMxerOI
	 i6JOg3dLy8e+TPgI42zkbOtZlgdXpObb7FF3uYpPF5XuStWSoPbuSVRt4e2CMWaS2uBYp
	 Z6n3lwGDHRhBK1QR8eVhxjonjO0xoLF3qq7KR3xHLHb1izfDxhk53S8nmOOHiRvIW2nvL
	 xsSegmKdfB7A5rK3J0huYANp5PbpCIM1cE+wySYOsF1ROIvsf/Hk9ybSqQU5nDJltL3kN
	 g6tZKEU1EuuBPdQhhE+nvLc7CXaSX3TlS83B0C+TyEj09Vdcq/UWaI+9dM9FO631n0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792473269;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=73bRAI3wxDb0Y+EjHYbvFbRakmsf9Y4NIcJNHn6LoA4=;
	b=BFVl/bswJEhnQREGBmFizoXY3Fs2zk96r3mG8N/GD9Si+kY2y/h4Gs3QY+KWkYKXXwOS
	 wlJrW6+BiyC/tnIZGQ83Bo5hvPlRNl6Bi8/DiHTrF12mvk1iszA2S75V3yvDbbmtUMdUR
	 AuAEcE2jX3wvALBzgN/fQc8f81VZc6gfiEqPa5SpcNUaUp/rnUBc1exo6IgJiwlticHeG
	 pyhRoyTlUveiNwqx4voNdHL8XxJ37isv7IzTDYEmF9BOGKy5toQurQhb3/TKuUwVnT25r
	 z/2B3lthbA4k9uB5aA7gOUvx64dQWPbzOoooaDFkSaCFC342rEyb0D48X8rq5DCoViw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pIiEG4Nh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.28
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010028.outbound.protection.outlook.com [52.101.193.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4606E606A31A;
	Tue, 20 Oct 2026 05:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4606E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pIiEG4Nh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vT61pK3BLDOnT27zB7YK/Dqq4JsW6kSzl3CP4hDZm0VfisWX53ay5a47iEYo6KuZE0Ds1fg0ZQ6ZZEQ1onyaTRj3L/6lt6CKpyQKIdGc9db6avCIoXqYL+Iz96mWrigl1a1TLTpADzudOXU4+JpTNKV+GGckWSAxUZ7G441/YevEqCmxkiKmHZWciBzd19kwTb/5f6+4HS9v1BwnwDm/z1XcFKaQPAK8y1ni+esd5Bxxzt5ng+HLluJ3FJ2pKuweFydhTgiMZo1GsTIQclMh3RlCoNcItAXoWzuLgatatzfqGuf4uyy+ByNTpq8TrbClg8Dh/XEU7Pl03JmjVMAKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73bRAI3wxDb0Y+EjHYbvFbRakmsf9Y4NIcJNHn6LoA4=;
 b=QNNdXc1lfYFIXUH/PTT2Vy0WUWxCfP/7DEgMVnaws59TnRnufTpluhkG+keYPnpGBA9NH3w8gMCisumS63Y9H9jivOE8TV4vXRpK8ZVh+1xB4ihuFsMlhgaLJwhwDtSXK1zu10+zcqXQoTPn/abg1DmaW8+6eXIlQmtXPCT5NV+PIo7RV5Do/NKKqvKCbSCwMlite2NVyL9YZDIUJDnbOMybH2QjOHt4PoXVG+A3yf18xz5uHQCZU3VX5Mx2P6rs8+6oSS/dRTrCX55jWUj8PJi9gIJu53NBGAXUM4odfoe9lG1B4siJJUt23ClkK0BgLZGLibWlceoy2Ei3acqM6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73bRAI3wxDb0Y+EjHYbvFbRakmsf9Y4NIcJNHn6LoA4=;
 b=pIiEG4Nh5CuiKG5CStkpN4HvKUGJPHf4+9UQ4DiRXIOyxOcETDwTq7r9FO56niO32uL6PtxS+pdOM/ythHcQzgqrYP0D0h9gTo/UdX+vsSAiqvLPtJ1PgZq24LjrXr5b223hiCQ/ryfbElECl3DKFhzH1lS7CICGPZ5stMWgh39nsnTMs/9Hx20IUsfQbBSSVBBDjWDWp21/IpBdLnSCaIZS1DUIjiR/6y5fslj+lneBelKtLZXGdjET0WXIIteyLxx8ZTnyh7+d2qw4FA6oFVPlQZ3HTNgZmASy4l98/LA7pjEebGwmIu1MP040VC4NnN2wQEL+zOw9sLYNdkRErQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB292992.namprd12.prod.outlook.com (2603:10b6:208:5a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 05:14:27 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 05:14:27 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	iweiny@kernel.org,
	ming.li@zohomail.com
Cc: gourry@gourry.net,
	terry.bowman@amd.com,
	alucerop@amd.com,
	icheng@nvidia.com,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kobak@nvidia.com,
	kaihengf@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v9 2/4] cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
Date: Tue, 20 Oct 2026 13:14:01 +0800
Message-ID: <20261020051403.14186-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261020051403.14186-1-icheng@nvidia.com>
References: <20261020051403.14186-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To BL0PR12MB2370.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA1PR12MB292992:EE_
X-MS-Office365-Filtering-Correlation-Id: e753bade-b4be-45fc-f5b4-08df2e690281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|11063799006|261009223027099003|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xZhzcF8aoR2CSoSSFqFS2DQHYV+DvqlxougHnP8oDdQPKntZbIisvqVWtNVvcR9ljVpkz0nCXsd929ckr0xwu1nVqH59HzC0P+VhgeXpajZhWpjOIWzjwt/xdFPB6EptNoxkrsCv+4c4vzrEA6jdtpxNMFrsp0UD7kMknszWlFiaKmR5aVt1E8x2+34u1EHxwMxsqv0nrX/j8mZUgfDCvzjKT+AwWBsKIQvxV9FXX5MDZ+M22b1mE3WPGQDvY5sVBC2OyiVY9VvIVsjKzFFXh6uI2Sm409PxerhkIow/mb3+3voNPvxTTLq6OpOYKvygrfbw0h7VDM+8SVk8Of6vF8mbKrsUMky+7m3uLLEJKn3qTE9BdR7oUq6i5AxaLxbz0WYTTzN5RaVKjPmNIDLEkozAxG0yiRZgogERY/TXq9FQIkwaZsBpiHx6NUCNeqXzgvC30C0KPUTyvXELDzpwFTmVlfQ1HITQhGPPqNl6vkNEWZAPmFo1ps9zFkWGSpG4bp4CLQIefT+G4dnfVz81GxLhCYSmx2nf7Gucm9vmrVF/WKlcnQiRNWlpmxEO2GGzpmexCbrRd2RXZET4ez01Lb5h56aVoI4NMrzuLSF1IvafUwf0TQ+/a36RtxE/3728Tbo6cedrGQt8hnh1aMOO2yDewsoB6FoxKnYu/ObL9Uc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wLvjjWtvUmu1UwX4FEG1Mi1hkn/SP8lt2Pn+/iK/g6pMMtcOQwygpvlVM9bG?=
 =?us-ascii?Q?U3gtQSC15ilNzJYs8r7cXJ1eXzymidejoQzGOe/8vQtyR7EpA5Mu8G9HVgNE?=
 =?us-ascii?Q?Zs5GdzYa0EoRPjUwYXbkoJStuQUkUmKC1GH9Ele8bA2M70rRJ+R+lyi3Q/w5?=
 =?us-ascii?Q?kuQH0gdylN9hBpKlpyVjNg/A+jODQ1GzG5zBJr/2ppfU76hUrTEpJRoGoXuY?=
 =?us-ascii?Q?TW90UQ00YffOwoI1wcS6SuU4hqeYQoejOEfryLa4KP5Z6J7ENYHLVwVH8i/Q?=
 =?us-ascii?Q?W+b49w6BAXga8mZqq8T1A3UDwzP6zKS/iuKMsdxqpx/0KdJbDBZ2UF168CvB?=
 =?us-ascii?Q?/BsNO0qPEL0UFe3Y56OKedTc196xrDAwvq+TuVTIRLliLXD/NwKB2hXys8IH?=
 =?us-ascii?Q?x/QeCNFlWZPj0qANNNujEe+mQg1KKhobvbsDfM+ZSjcGxHREd8iruBmtnqZk?=
 =?us-ascii?Q?JsdmLOiEeNywfhrvGPKUIIsC0Riedemo6nam0cOXQfUmZVi/tLT6EvQqe7+2?=
 =?us-ascii?Q?XuLjLs/xrOJbu5amIB3lIRlyyHNnhMZYSOsP75lJUiv2W/GRY3BlMZZ9SzSO?=
 =?us-ascii?Q?UXDISUU3ADPqqhKvNFPaZChBVZfYbnZC5PUf7Rf7qL0Yc9U+StYSnvtSc+2X?=
 =?us-ascii?Q?RiQb4aRd9ihjBy1TPU+B9q+iXUpgY0628fSyGHGFejp+MCfSuTYSvN1I+day?=
 =?us-ascii?Q?d9eOROqms+OLvLDqMz6JaOSbqRiqbl4SoDBqrdMrXkADeF9G2szgH6Pw+l+J?=
 =?us-ascii?Q?o9poOS3MGYmehlQapNZ7cECuWC42/+SbX200Q4LYnYzdNod5T263wcqsrloo?=
 =?us-ascii?Q?K82TDvm4LtAgDSo3DhuwiIaAVqPsF/WkW9BxRYrWjgbyKM1fRb1uxTLzmcQG?=
 =?us-ascii?Q?djuvJ+nEq4bJgyqtbvFboLRNlkl3aIs6lHgwv/yV9FTKosIXhoqqRzWP4eAR?=
 =?us-ascii?Q?7A7L/3jebZtR2d7rjF1VIiEVx20AuIAvwCQH1eItKIq42aKrPmMMEnclaq5Q?=
 =?us-ascii?Q?PeYrBgzXTCcv0JELf2ELrWJcPPOTlJwZfzNdaqFJENmwBPtpU4kqbHHb8Dkp?=
 =?us-ascii?Q?6FaJ11737R24qLsLONci6ajDxnDmv7nxxyGvmxRCP6TfVJAaKOEk+iDX7e98?=
 =?us-ascii?Q?3BS4EhZg0JsRjBwU84yOCK/wRO6i3zCJRE0hyBRsUrMneoviaVOVHBbmFCQu?=
 =?us-ascii?Q?CTss4KlvJZYS+h2wEfirc/umeUY16T+X21lwty/vFO7ex9Rbk4FY4Z+sReJv?=
 =?us-ascii?Q?nV0WTfP5TN1N/YKEaYN5HWBwUCDVRRhhiV7aH7mU0RCinvcHaHzIrS4w6e7Y?=
 =?us-ascii?Q?SpnubkVzjno8bBFahHEkQDKBgOzdIhczjGnLMuTW0/W5c7LzZD88CAZqCtDo?=
 =?us-ascii?Q?KBQRGMRzloamAuSgXOAXSOsJNwbzfs0Mv9geTdLi/gePzGhwEHZrWc1yihuO?=
 =?us-ascii?Q?lP1Ff/rUBglsYMQ8dezGg2nORyvaAj9xL1BKPkrAu1hFbP7rDMTI2wWSKwMW?=
 =?us-ascii?Q?MyDm1gaJdSaInEBX1/Ghmyl8fpAzWthD+1Elqj6KrDxSyp7U/D+6nDUxUH4C?=
 =?us-ascii?Q?Ay1E4DZnhkjbrXPUlT41xWxam6xg82OicJuYhF4CZxeEaf82CNmWxWLPMTHz?=
 =?us-ascii?Q?Z9zJ4KlzyFQSURcwR/ql+FcJz0ZDUUS9vSGS+lHKOB1V/EsQmNSriMTmPciT?=
 =?us-ascii?Q?X5GPvXOQQ45Kl9Zbe92tN5EgqiTilC22lbfcmadgy4FVKoUg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e753bade-b4be-45fc-f5b4-08df2e690281
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:14:27.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODqRyPezysD68H4GRdVlvUGzlDHRvQtqf+zMVoyAPmb60FD29YyeZA6vL9wsc0JJFC6VmLTezy7oqsx++pWN7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB292992

CXL 3.0 section 8.2.9.8.4.1 requires Get Poison List to return Invalid
Physical Address for a volatile range when the device does not support
volatile poison lists.

For example, consider a memdev with a single RAM partition and a
committed decoder covering only part of it:

  RAM partition: [ committed decoder ][ unmapped tail ]

On a device without volatile poison-list support, querying this tail
returns Invalid Physical Address, which cxl_internal_send_cmd() maps
to -EFAULT. The driver tolerates this response for RAM because volatile
poison-list support is optional.

When cxl_get_poison_unmapped() was converted to iterate over partitions,
the RAM-specific error handling became a continue without clearing rc.
If no subsequent query overwrites rc, the function returns the tolerated
-EFAULT and incorrectly reports the enumeration as failed.

Clear rc before continuing, restoring the previous handling of this
expected response for RAM partitions.

Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b03f30c04d35..ddf12075b95c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2930,8 +2930,10 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 		if (!length)
 			continue;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
-		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
+		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM) {
+			rc = 0;
 			continue;
+		}
 		if (rc)
 			break;
 	}
-- 
2.43.0

