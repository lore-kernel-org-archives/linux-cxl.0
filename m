Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2603F88AA;
	Wed,  8 Jul 2026 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496591; cv=fail; b=qqFNq8r/7Z/9hHnEyIF1xxNkiyW8sYk/jXL8R4NrITYEhN5g5xVbYIM8Pr5pGeV2RYxKMYqC1c5bOa/PpHX3lk7hq9MI0OK4C72ag4QthHkNcEGtXNg43C142NC5XG2wLT5xNBQcTlOungMakuJCg8XQ9VhRLt91miCiHbHveOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496591; c=relaxed/simple;
	bh=fTyM9vIW08K47Yw0GBoMEH9BP+n3GOECLXX9lzzNZS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pJcEfGfzKc3b4jiQmneKdysad1G5dC5iNPPUdmF5mu2xrOROhL8vqUzWvNLY8jgCyaMsw/xcqdkNHt+TRRp8RYn/KtV5xopYZFGhfp+1amSrwplA14xcZefYE6Txw0DNkd2QNGpGFjDjYepTsq+WaLyZqnTPSCW/VaQC8UsxBZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dok0rKFN; arc=fail smtp.client-ip=52.101.85.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dok0rKFN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acESHFgIB7HGxwdZ5Q5GRu6vHEOKY+DnNn75OfBihzY/Bx55IzLJOFgTxv1Idqm9kOqWlZZQK8Pu/w9bYnVzQlwUuNACOLJmV7ehFOLM77bDWlYgAiZEJ4dLfPgpO8Wb3eCo7AfsALxziH+5mq8T882cdYQq53h1cPkHtLYDOkyKzXJrQn/QlLsJlbYzOQkjgnhkd2CkL0+jDjrPMFx02gh6ti+CPG+bwoqO5QrhmGo1ZKjOIuw6A+WUgVbWBWYxaaNu0V4WIuGfzf4S1KHHPq9D2RYsoSLj86Wum4B/dZ8MQuT9Lk/lHRScLtm5DIXJdyMLPQWCwmtBNWqoDhscsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJ05MykHuN4wwCmzdmIxlC+3iwi9MR6WeC8Ga1wE8yY=;
 b=P46jnW/eT9Zviqri9CO1Mim6QYIFaMtcGYarTqFnNimeX7aaWCH9p/oiy8kl7yVq9f23mH0tFtOTzEVrLbCNiE3CsvjAvP/lcdIIsG6IULZUGsynnJAusAFemAVifflrZ+4zNYX2gr7hb/c4Yo2NcINs7O4WeOeYxlFoA351llbAiI93+fOgwdNYP90htxbnEXlTaJZz8ErVFxwV0QQquYvbXfEsKnMTRg3P0GS4qR7w8IsPCqJFGbQ9694WLkZDMxdLf1QY/gN+fTgUO2u3HH7t9IcTZH/mJi6aDrhpTBTAoiJF/UUOUfCNTyhMo6fkWxFSm4I2k9rPx4akLAB3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJ05MykHuN4wwCmzdmIxlC+3iwi9MR6WeC8Ga1wE8yY=;
 b=dok0rKFN10PauHr+ENyVrSHRwjDbRoMrUxGmFToSOLAkLfn4T2miyk/xWLtJHYj4xZMyn/M/ZhLudvZwgdUbQOcRq6paPOTjibzBm44kAf6pQsH61zh3gTjL6W1qtZt+0XJtbNwcAwat4hMkQgQXTJWxkdNX82cE4Pj559OPx4bSFqETz5+wVRrLL41rhsD1F8nDIkLH1wRzftAqq5Wt5vdCLAYTYQ3Wiao5m0PWSuYWsOTQkRN7BiZKTD7+icQ8DQdNQf7NbxctwO9SZCkI2SLAoLG7zLWmLWj3MtENDak3ZZKi2LKq/CZm8e5txNt68p/T/6eSCu0E73S36Vws0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by BN5PR12MB9462.namprd12.prod.outlook.com (2603:10b6:408:2ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 07:42:53 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 07:42:52 +0000
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
Subject: [PATCH v3 3/5] cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
Date: Wed,  8 Jul 2026 15:42:26 +0800
Message-ID: <20260708074228.43654-4-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708074228.43654-1-icheng@nvidia.com>
References: <20260708074228.43654-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0026.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::20) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|BN5PR12MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: fe970bf7-0b4e-44ae-7698-08dedcc48451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	M9iJz6aIzkdK6zj2km/6s4j51l/LCfnnqZgYi5I/Z8SaOu4QyQvh6g76VW2QyAXRmKWeYb9TxBzQ8g/LzgDcRxWPaD4kShrrdVtoeAcPenObzP/dW/BkKD+SXQnLKTTAhunuzRN70wjCRTtQqDyAABMp2v5uM5aCG83FJSejPcyXmeUuuBYyZ5vDLEiL356MO/5N9AOxd/MTdSor2mt6jO/osAKh4GeuUOeyakG+f3yaBy50yncpR/vv4F3MNF0y/DL8TduWBnM4UrgEL/MO45IVZLEZmy68vA2XpdDBIHYHmbTsk7YCJah7mmRO465nuGrgNsY9TBwzJZkVrSAiL6uon65MuHI1HeUj3PLzduwUCYAzLwV34arOwmtr8aArNAHE/C5RA1qU7r4tj1rrbXlrJFeMvfa6cQQSw6Wm7WrfBzl3+MwVbE6olI5O3Ry3PCnyKe6Y3gNrR6IO1ejP5ZATQ6Z2GK2BgqN1olj29KF3NXLDjDmq+h7nMI/nfrW1qb1Y/11+vBn6OHZ7PKCpJoZcXrYC1ERKRab7LK1/NeTHgq83IvdMrfjYdSRAekn813Dz/+t9Hf1e0TjPVOyqwb0OkZAm7nYxBdlzUthn5hwb6MTZcZvfpv80umehBeCmXLUuxg7O9z4af2g/nPkMeXxjGo4BexesBHJAiclS2eU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FBs5zQox9bN3raoCUtW+U9Q0mfTOKX6d7W8xJ4DKqyOUmcrVYNQfhgsrzLqz?=
 =?us-ascii?Q?icReAkhf3OTTx4/Fci/Nft1hzbz6wZ3ZcGqJE0TDw9yKSAcExPfzDfuOeXsX?=
 =?us-ascii?Q?57vjpqYm4l6q7bOCSDoTq4C+BR92+Y0fjt9J6MR6iIjTeAgBgx3p7xJSAK5d?=
 =?us-ascii?Q?I/fR+cF3Xj3FmfHzM1iDlSLpXQCtEx3kvCHq8463z8rpkP55xsAlsc6qL5rj?=
 =?us-ascii?Q?F4PuYvKtBP4A7YQYi06pAGXjCyxXLUkl1WIEb2kdt+OLjyxwLBWlaeL0+7Uz?=
 =?us-ascii?Q?PL54BhJM6sDFgJmV6VC0t6AnK8hu9fKBrRMZ4ZRV0o8hTiUp3mxomW/KHr90?=
 =?us-ascii?Q?hRX8hBK2DiJKaV8BVWJk4SqMuYkRoo1JNBWlwnud0YcAF5x03K8awc2Z/jtI?=
 =?us-ascii?Q?DVfb3POl6KbKbVviV+k6wjTrSjolK6P1KlmS4EqSaSk6ZYEsLjrxDDzBHNTq?=
 =?us-ascii?Q?TIHaX9Od41668ZqSo0AJqQl2lneY/HD09OKnk/Zq19L+LNi6UKPOrgNhr4qf?=
 =?us-ascii?Q?pmtVBBO4AY3JrlF3Uo8pAWj7FjrIV0JfZDUj6nVxatYgvcAg974A+7cnrWHt?=
 =?us-ascii?Q?z378UBTEffEzrWBMbwJtzh5MnDIQwF73I7K0UMNTGqGfRK2EyhtB5fJ6MdS3?=
 =?us-ascii?Q?d+2dUtS9+JwANZrmSyVHczhfq9jWx0VETS5lYEdZdEe+QFatC1S6l0IvRfnI?=
 =?us-ascii?Q?MHq2m3c65/JUrxQStdmwbP5xfIfx0YNU92+tbGLpCoHhKBOZWXo9fmSqVX4M?=
 =?us-ascii?Q?u4AwIeZQd+5abmxF8OBogngmGaTTqJpZn0COL1CQ5WEXD7w6HJZot4dXpxmk?=
 =?us-ascii?Q?8aLkh9jsdYhvVsz1Y6P8GOp0tlOzO3XGpNsIpssn4kaAV5tZNMnjoeSLuR6+?=
 =?us-ascii?Q?9WV5LdI1K6B98tBY4w5Tgyl0IzE+KC+6umxux88Qt8tZRxnORQUZfSwyWJQk?=
 =?us-ascii?Q?wXRNyAvIqf3Cn+Mre7p+y3dNXysGPP+9Bk08bHpU+iChYRcNDJfnMAUAt4UN?=
 =?us-ascii?Q?ZTEdNvgl+Ey4W4SceFM8JR+N0wbn/suaVPh04ZdrkaM7LoDZvSQsnDPT5ccE?=
 =?us-ascii?Q?vUQbQhXUB7O8dux7e+kUsPrrBIkelxeg/6BUc2tNvs9uHiWBE5cIC9YqIadR?=
 =?us-ascii?Q?rykAxtfa5MJncfkRhhJV2r9Fmk5SqBCEVXPKLcKYaA7+rqQRl+fgJKkWXnOG?=
 =?us-ascii?Q?qYG/sOd5YNLy+9x8I0PUW2X6RFKlXQEnKIKLuEZedCzhcZrha5HqEyaE070Y?=
 =?us-ascii?Q?Easylko27IRtFIO60eeU1sxC991TxlKV/gYjop/DUOu9mQTSFs+mxr72+cUa?=
 =?us-ascii?Q?l3lIdYLQCu1Bw9uH7p/dNaKUxM0d7NxWuEWmta2zH9BW664gLXuHF77eeLJy?=
 =?us-ascii?Q?TeI83pwbo+/7XElTyrymB/XnpdELaG1R2CgLq9FtNFqNOD64QRJunmCbIBgm?=
 =?us-ascii?Q?pdpZ/0ssEid/9MPVb5GQwPG849J593ks3ulatjyx/4T0w6s5xZ+0V637Bn+p?=
 =?us-ascii?Q?8ufe2jomCkQjy90rI+CQqVi0EEgn18D+8YtxCnPyUAr7D/3XMySgFKIWGlSA?=
 =?us-ascii?Q?sFO5IDDKOipMJ/M5LaGen/mMqI5Bso981NbrxBhJFadksbrgV1qZx9THQ+jK?=
 =?us-ascii?Q?syWIXtdgzgj3SewdmES6bo7GlP+2X95XTz7DehTJOmWNsGgFhHbbaPDAA/Nj?=
 =?us-ascii?Q?8zV/pjTLQ9FSPrRGztFATqZdfBBDQTCkaQGsKIz/B+X7kOEyiUqhZRJrVX/7?=
 =?us-ascii?Q?Yi6PuNyPXg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe970bf7-0b4e-44ae-7698-08dedcc48451
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 07:42:52.8224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmsrNQCTp5+ayD9qncbitvEiJpIBnes2e4rOG1f0xeF8cBFPgglTvIgackqo0EzPvThHnkwPYVg05UuxyhkRxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9462

cxl_get_poison_unmapped() tolerates the -EFAULT a RAM partition returns
for Get Poison List by skipping that partition, but left rc holding the
error. If the tolerated RAM fault was the last poison query before the
loop ended, the function returned a spurious -EFAULT and the poison-list
read failed even though enumeration succeeded. Reset rc to 0 when
tolerating the fault, matching poison_by_decoder().

Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v2->v3:
    - No code changes.

v1->v2:
    - No code changes.
---
 drivers/cxl/core/region.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index be246fb09c99..52ba8e9e4288 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2933,8 +2933,10 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
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

