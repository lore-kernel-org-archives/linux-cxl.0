Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658322931E5;
	Wed, 26 Aug 2026 01:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787708776; cv=fail; b=A53ZTEvBUXj2Ica0tUQrtWqV/unnBnyPtyAMibkpJlg9c15kTGRYvhobX4KA33TzzwkAwayWagZ5SK4foW9oT57VhaqMUxUzxl93RrJ4tBduJ9glU5v6+Ivu2ZNmkTISddBGZIX6BHUk9nfMP3cNmYWNxF4Y/4fKJ7DxhYXx3ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787708776; c=relaxed/simple;
	bh=VFmyMXMqg8tcoIgwz6QVEmUkR+eqAEiQ3aDU3Zi0jc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EtirZNXciqTV87Xrrjazrrt7ne4Hix5OnnynsdN4uFjETWok0GhbtHfDhoMfYNLjemToiF0t0tZQUHvB1slG7icAKJhESOyRxFmVjLwgeJ+3HFwLN+Fna12ikGvMeR/Sn6IOjbn5YX7ZQHaAHPvnF6JJOIRxMJsQiV5v4GE0ot8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lU/xtIbn; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lU/xtIbn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iT9c8DoIsuqWxtfUQJFb1jtOdOuL9ypBw5WScsWCZoMhHg+7DYryfXeQ5oUy7LuQ13Y5lhnYJInJIJsAHjafeusX1CznaG1RPzSVHckqfwiAJNK0YklaUhPOoYrarXO1gFatIJJNZSffaFzmDw33OQMbC3V/rj+MomE3o7XJ2MB+7zU+ZhOEsWhnQLFFheynadEuUrj2nKUtS8bj8REgSZdiBEdS+nPTYmSOAh85w94xIN6SB7+w1wqq7zqP3Mfl+GrOudV5F/Y6pUyX6kSEiP3gMNR+LjM+9TLQyeSBcYt9FgnEPAvNohC+wIG3gjYi4kXh0kM2EpHJrBjYE2FqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ/w+FgUXkffWxt9iwsNfGAt5njzVP25NtvN6W59nY8=;
 b=e73GpGTtT0DOCTmddv+EaGLXiiXaQYdWSUcCpqtceJNOqAvkrOdP3Ulu7354YoaSM4Z1VIh//Bk3N6yPu3DBJu9coiTXtATQN2MXFHoMYWYheSFgDkt9t6Lm4PV8hX/UfSh+fSsOo50QRpBd9s3rP4bOTdP179Ptj76L0NvJuygMfftuh3bZOcvRp2dWfueSD73QkCaOPjkMbQmUU30p0EBAjP34+YqoGHjMu3hsLz5la4UIsSlg7M6Z7Wb6W/muc8lrcOMZDEGaX41UN3symsdFdqyV99sGnu6tE0mpTHyWdHMDzlAgiNz3hhvExAbxlpiESQRZcUgIXMfOVjv29w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ/w+FgUXkffWxt9iwsNfGAt5njzVP25NtvN6W59nY8=;
 b=lU/xtIbnyIYgNGelF6TzDpmsT/0hLDoTQdFYoLin++qGc0Ic86lC/ATMtjm8/604OJeVqwAnsF1nhfSHupBDvETSpO8PZVrtn18L/N+DfWUz0Cfw1ivCtYDCTRFeRhE6HEi6GHyhMV9IpDkcQP39ovUJGYECgIpoYfTU1E1Vopu3AhaoSisuRFqVZBWy0DwpQvEJVF6nxrOgDVuVNvX2AkJkS6G4p4IK+vLKEVqXRIVMSm95i4O4NWXt/JV9oMwpmDyM+TwCjOuAU2Xfw2WR/OydAgpR4bndvFJ2B6dtuzhn6W1iXudeiNMgnXBd6o0kFZvdteUNCzGbGtiBQ2kuMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.6; Wed, 26 Aug 2026 01:46:08 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 01:46:08 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v6 6/7] cxl/region: Reject poison scan for decoder without a partition
Date: Wed, 26 Aug 2026 09:45:07 +0800
Message-ID: <20260826014508.9989-7-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260826014508.9989-1-icheng@nvidia.com>
References: <20260826014508.9989-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PS2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::33) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: e90f6444-3e4c-432b-1771-08df0313cc4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lKXgEqDHb8qjP4ZyC0ln2MJZ2EZHbL539oSwcQ80Mnc0asvEBvE79DzPXZUApeUHjoQSfAyLSSnM/3rldMZ7dKCLFzZ75oT6vByTFYhGe4XLz4G5WJhCjOq1GoSopYwpvw98+U14xT34IGGTfSltiDkH/BcfJ0Qx2VJEmnDH1lzws2zrRgNLkt9VdSQgLJ4X0vmidyJ6IY8nTdRbH+k+BAIK/d18qcYRdNLjx4zcK3NdTtbksbq6h/9/DGyKwrGee85XjAicBjnO3j0vXnbG6qo35esIwW6PAj4uq7NLglOGjoEj/O86v6KfaOyLM5tqpuOv7OviYbOw4iOFIH00n0YUcFteY0+UEwNry2OTQxlzRzFYwO2nDfIdOIeMgrDZ6jhfdYS5hQfRNRK5C+Nz7qhnnFs9gEXFFsqQSB5YWvkpdYE5tRHyM8C5fpsZYthyKtuI+byyDPEws66SpWiuVsR6WhJRBSQI6TUFunofNl6dM8KvPRaylAm6gkTDYMV9NEOmKmSa9gjgTa7FgslzaSHoC6UyY5uf54Pk8auqH5WiCSvRf6CF+GuTB3X4NosXFPcsqs4Ip1zdA1PwCKuYllQoQHAgUh+UxZieZXhewPOQc6nzQg3QM8eOojVa9+R/VerFip5XMqWWwASKvi9/ASN7+U1AKvB7EXXJebwFQFA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pyg/FmClfsq0s/FJAY1A+lssNRnvmV0kIotC4U/I8kR90cESa58axhT9QI4+?=
 =?us-ascii?Q?C630NDSoGN3kYfE07LnbNWmGP7M5bV9NadsdCcMT0dcKqI6zBTta1r8fHKem?=
 =?us-ascii?Q?T/Y2OfIzI5tax0dCoW9CPxtZKN270QgpXYLCNqUZlexo3QY6GXAX/qeV8aXT?=
 =?us-ascii?Q?t2hgEP44b9W4JFlxYZCQrE1LephEGv5KqYE48YwWGjNBpxEgdjXNdhybxWHQ?=
 =?us-ascii?Q?B5CqDqqJ1OwHuywy89hRpSp80SaWvAW7Ljf5xBIchOdS9ROP98vmzg0azTu2?=
 =?us-ascii?Q?TTO9IoOC8JGEBsZyHE+fMLJN5fl5d2NPYOkfn8GEK20f39dn2O78SWtFNXrr?=
 =?us-ascii?Q?DCDw6n/MT3OTFrOGNyv8AahyKxzJNTBvBdyuvboDmsxVdHlGGk6CsEgZnnRm?=
 =?us-ascii?Q?pYrFa9TqJjKJVdpJQeE1juT6qtufGsra5Y/rko1FO/SUomPh3ZywvTqDDsD+?=
 =?us-ascii?Q?NRFL5eqH+gJF5rUNsfxnCM3iRz/I+p9kC06gOLw2VQ34KxemzJkZlDQ3P7Uu?=
 =?us-ascii?Q?qPfbe0FbAVIfLwKhM2L9tEz5wHTk7zdvOmpIhhAsc6qt7vPm6doc8eNMP3sm?=
 =?us-ascii?Q?wg/I8uuluxYtCJ1RAFmcYh6LT9FzHWdeCQbff2VfUK07RqFigOcB+lRGSOXL?=
 =?us-ascii?Q?Oct1XtU15/sCZgjiAWt7p+EIs/ZbgXJuXxb+Joaz1Nchy8pDrnZ6KSORrisY?=
 =?us-ascii?Q?GO++NR0r4pgl2VizO0KcYqTVmHfYOz0Q5c33rePWgE51Xz4C8JiGZmqgXrXB?=
 =?us-ascii?Q?9av+9tbv0i0YRlCHVbZRL1qhK+9UZy8JqKJtfmIdEF3nW7tKRMKs82Zq0IoC?=
 =?us-ascii?Q?aEiy+9jgicK10Z8mbnZp7mX1zb7VZpI8MNWju5K3krcWh0TTgaofPsefjoGL?=
 =?us-ascii?Q?TvikOZMMY9V6K5qSUQ7B8+B0gHlwuK8/IUmTcd2nsmmYYBuDQMfFQa8kDXuB?=
 =?us-ascii?Q?OUweQE5HYq2E5g387jW3Gd7wLuYc8o3QxHWlPy7cvDkQ2sBXbBqBhuPRncRi?=
 =?us-ascii?Q?hFmLHvRjzeeIJqOqwsXUGOQLGRcZyOfeTAPu6UW+TkQhCXtRmwMJImKtPSPJ?=
 =?us-ascii?Q?v6cX/ZI+I6WTnwQoeXveJt8azBgxyCBE+NFBHYScHtw/5a5D45Eye30jgMVV?=
 =?us-ascii?Q?gXgCKJg5mhdrBCdhNKjHWAaMfPvSwxG4TRN7jzc3cu8neERMtZHju+4G/L/M?=
 =?us-ascii?Q?QsCxPsIwaTkuTuZAd7fZOpnC/t0zrxu3pNIy7/ul+KGMLC2pX942ou7s9jW4?=
 =?us-ascii?Q?0Bcn5Sufr2Wl2jsDtkZXJGF12RcJ3k0VYKPyjJr8QfD006lF3/gbpYI8tk7i?=
 =?us-ascii?Q?t7m8xl5+0dF3fTQuw+hBIyqwVAIyE2RDWd8Gtv49+xHDfDuY09dpZ1u8vQ5C?=
 =?us-ascii?Q?iQn9z3mEGQq9kZ+ai4J7+AT+sA+K/z+XGoDPYxTXLmgaudnEmuggm1+DGM0D?=
 =?us-ascii?Q?7GTQGAoAy91rrNOgfW5Dnn8c9buttF/7vv/PPtdtz1gNclg/fnAArT3IDEED?=
 =?us-ascii?Q?OrQDQ3KBHLfuPX2ICkqqk2ZEvP9nJdUIl20Tl8ecr0INDz4gbSxuwwEYlTeG?=
 =?us-ascii?Q?1q90xsx7ealRLYkxK+p03UrOr8xlHLdRZCEI1bBtgJif/6QEE4W4iKI7VqoS?=
 =?us-ascii?Q?Tkg4in+gJWTQv15G7fd+6QH15MqtuB7Gf6Hoot0J1rrG5f+jMwzTL7bwX/qV?=
 =?us-ascii?Q?Pi5Ta9rwwDjpwd/E3ZIMvYfavQJxUgsMxb56xR9TW430vxBIT5ttyouxQj1c?=
 =?us-ascii?Q?A2W/K7AfVg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90f6444-3e4c-432b-1771-08df0313cc4e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 01:46:07.9486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92ERJIiW3Wj7J5RRpNu++J8iTls6++CPWRUC0kI/tUk+z6bmc7ZCn19mvjiWoCGpEbpend1TGAwCTHDRICTxLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372

__cxl_dpa_reserve() may leave cxled->part at -1 when a decoder's DPA
range doesn't map to any reported partition, while still keeping
dpa_res. poison_by_decoder() then indexes cxlds->part[-1], causing an
out-of-bounds read when poison collection is triggered.

Return -ENODEV before accessing the partition array when no partition was
assigned.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b7dc5d4988da..afe3fb57b7fe 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2954,6 +2954,8 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	cxled = to_cxl_endpoint_decoder(dev);
 	if (!cxled->dpa_res)
 		return rc;
+	if (cxled->part < 0)
+		return -ENODEV;
 
 	cxlmd = cxled_to_memdev(cxled);
 	cxlds = cxlmd->cxlds;
-- 
2.43.0

