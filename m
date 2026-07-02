Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B2147B436;
	Thu,  2 Jul 2026 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983358; cv=fail; b=qeo6qJaA1vA8u9pt8k+2AOK43uP3DqU8mcnhpEhYbE3NVbuiwK6UhiFDBBB5xU9qjP5mb9DEdnpoUa/6jgF1aKYE69QO5L0wfUmlN0Q0FBW/76F2tbuSMsbUd5rc3wLkQkDB4xUkktgJRC9in6qJR0gSjgrqJbFALrCB29Xe4eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983358; c=relaxed/simple;
	bh=/bohQ7q4qkdXRfoY61yniaqDj9kdHy7JQ1b1JAV08YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y1I856iEVjssXDN7nQh4nivSofo8TFidvD4YIAVPSsUyP9iAHe9I7+jb9gTT1aOH+zjUv/SMzlxGXy/pV8eFz0i94zG7zSNPfTYk56jYlan+0riPNkYz/p+II0rLJKPocAy2mF4zdbJ8o5ri4TP7ppwCoAJ5v9HbPzFzqI3oL1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wawq9LXp; arc=fail smtp.client-ip=52.101.85.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wawq9LXp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ovh1nYwWqPnLCsukH2ahHgzvj522jEFdoNwhAKFVK0rwmqTMzmQke0VUbZVHkawvHG649BLiQdXI5Wprb3eVuT9hIvoRgbQiMjIdfFEAYVGnKwOsvBvgBaTNFm0BjYJNs6qIW8d7GII2Rlk7tEB7i25kAxvqS1zCb6OQzLRsiyuFj0dyk1Q4ydwYBz4JVcYWYi3kY+ENxl29beb+Jo/dm+pNZAVV3Cr/g/I7V4dVW0G4Qp/I3aWqhmVXIbhyDvq6OMuQwfa3rRI29o1N8V9nMAIDE/rmBuu6E00TGRQalYrE9kZ/Tek0utCrSPjCytTHYysfju/TKzJrRCx7XRmYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZIp74iNtYqR1dgOKEOx/P4Wu7x095AzMOulm66gx20=;
 b=SITq3KhHpcs7GkoQ6QazrUV3WrLT7+bKG5Z9r+RFyaOxKoG3VCdRP22bQ/G80grNfSkZq5Ql4Psa1eHzhljpaXQzjgzRsRkYDMOkXbOBDHQt5moPHHfqIqfLQLNRkt1IBrvHQecp6wXWq8HXyhJmdrBuG1cWqvO0bmL1fbLcnPPl8jwaDCV/osuxTYKeZTSOop60sEy/FHX22GxmaIKkKCkUGF0CbmY7j2vG9M/ND9h8KMEge+g5AAZ5Qew8EdsY5uOppMMScBSumg+thMccgXoHD9l9U42tPhuT9eTCmLWLY3apLfA1HyqOiXyQFZLian2JqnCz4OnWlxLibFg2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZIp74iNtYqR1dgOKEOx/P4Wu7x095AzMOulm66gx20=;
 b=Wawq9LXpA9+Jj/15KSaFUsh0w89PS/NIXmcyv+iANDjleFqFiCVI2ta73E6Nfo/s2zuyMgfQ1z1bfkGCVbeOnz7XzUGxiu5cA6nEeiNkvVThD7CLFRs7zpzckf5Sk2IHbPEBmtm9TbuHsDVNm3LYOSPXxod58ORDhF+nDa8luF3ptAZqafg2Q6q/yueNn9QKYFtz1tRrhe7mmAi2N6FNXtZaPODiY40XWwIo5M2/efe8lPoSNpReRGoybtWTy/ws04iK2iZgToWo8NYrkREn4OfQLNn2TtVarza6HyazupEfSQidxYL4KhXR5Es0FKiEz8eTkWO64iI0DhMLn/XTwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH1PPFD8936FA16.namprd12.prod.outlook.com (2603:10b6:61f:fc00::624) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 09:09:12 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 09:09:12 +0000
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
Subject: [PATCH v2 2/5] cxl/region: Scan all partitions for unmapped poison
Date: Thu,  2 Jul 2026 17:08:46 +0800
Message-ID: <20260702090849.47501-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260702090849.47501-1-icheng@nvidia.com>
References: <20260702090849.47501-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0075.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH1PPFD8936FA16:EE_
X-MS-Office365-Filtering-Correlation-Id: 59861c8b-4698-4088-53ae-08ded8199545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FyNY8X/0WpjBXSBrIvqU5kani7qV14n7ulYFufRyfa83UpoLExFnrYVKCZYBfxeLpIaYP/eZqki4EGWUsmaTAAh0AvgdmzCdfU4F5PtvAqxZ4yFPXkYUzMW5Ec1UX+hDPDzFL3dELgVOxMSjVtwet2fuPk7Tqxu7buYxNy/YK/d291UyG4bGPnrue29vV9uGGh71dytbvw46eR7NYAt+FhvjGVPIjitwkvYWvTEcNSjbY0Vm1AYwDA9NHfPblcG9oRPilyDd6XBbkHl95JxJNhUZEbRkQzLBbql9mNBO1oLLKG2DhtydWzX4onu9qy/v87QbcxZ3h0SOlKtSR78yt28kRTFPZC4x7w96t6eCv5TXnZvfHidiBi/50rCiBj0urmlklgKrs0/6JNHGHjskVnvhC+eYHTV6QC82MqHdIfDBsUaAX0eQd31A92clpjmN4n08Uiho0cDAa5Gu8d2QIzIYqVJjxPXd5Q3ARv/606DCB8F+tOzOaXP+ONmsxfT9cLV0QSvhEr+s9Z7bkWcWNv/c4FzkKNWA1Ce8fzhPwux/MqGTcqBZokDjlLwCNlOALb7iKJrhHT+M0av3+HzauAsjuClIE3FY0zV0sIWql2tUvbYezi5DPhlfmsskHEcTJ6TMm4ZOi+DbJqUzOfspyd1ZoqhvIqs4cTQF5/FdnfE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dL49Opc1hkq+rXaOb59o95fEBVMC/6p20/MI3xcyf8abvlCmsrmqph1snbDh?=
 =?us-ascii?Q?Ian35gEpo3dZk6OeTPQ7RpIf8Ze8GJrbqDAzycMSI6Yc3wEBAeANghpesrmD?=
 =?us-ascii?Q?UwQbajjfQSzqMIkgmHI+DsKXxor70t728e4YG2tB8nHXy97IKBoPOoK40qyb?=
 =?us-ascii?Q?xu5v4Un20+2aywW1sGsQ0z/EQZeVMhKqRVd9cQ+9PLAgpnvEHSvDAsFw97mv?=
 =?us-ascii?Q?5UJJPPpE84PF048tH8EhZ369YpHqZWZRmsPP9O0+pbOyuF0lr7EkIimtlbCS?=
 =?us-ascii?Q?l/rYYLjCOVtlIZ48GF8dYuH8opFqUmILN6wfpgylT0ZuJ2ASSQtMkRxKA2oB?=
 =?us-ascii?Q?W+bt+s2OyNjg/9iO3s9jkiAlS3aQvHo63TydpjjnhWA3axEyYQbP4jkihG2p?=
 =?us-ascii?Q?lfDNpyMLcDP8gvnNJB66B293Uixk4wHNySUzqIZDOC1gMgUP9tR6uaiVQH4W?=
 =?us-ascii?Q?a4NdIsUAa93AeNcpGYxUKK6pZsQW4MqrHGt3AdFawgdAG65YZEChGI8pt2Ke?=
 =?us-ascii?Q?tVP2SnzgEhjc0LWBXAoM3G6IcyIKl71Wac+W+hrRkMlHjqlYN92kRR2kVvxG?=
 =?us-ascii?Q?G/g8Z2Bqk//NIgJ8miy7YaNt+56xt6xMekaN+0J4EnqUGtc+tsQD98ChUUPL?=
 =?us-ascii?Q?v1tYU0nbmQLtBPvpjUMdEp+2fonR0iOzAwAznyGro9zUC8eExdmNd0b6nbVA?=
 =?us-ascii?Q?9GWvv2T+2bifKvHZNzxg+Q9IvZM7fPxyB5RYSw+hUgxHEAHJxpioJoin311Y?=
 =?us-ascii?Q?akPBeP3obxSKTOwrPRPsB8/JprNLMLUbTlwEWiqAv5QKId2WstkOMErTyPj6?=
 =?us-ascii?Q?UKc8VXLt41S5ETaBpxYAoMhJ9wbGFCJkfGGOEfLtGZXfWAwIP069VMsoaLQ/?=
 =?us-ascii?Q?HbTx1rXrScb96XvF9FEIu7OVcB6pz/EchzKr9YW7Kp9eOTCvNpgtdzQS2e+U?=
 =?us-ascii?Q?tvkFk+eF545YbORwt4xUIZgYePs3yiQti1cqbJ9jrgnK4cfwkTyTk/avgRyd?=
 =?us-ascii?Q?D4KHvUurlFQFB3IckO96x0308qZcSJmqW7umZIRrZcRtcJ4jojjrNSKEyE2p?=
 =?us-ascii?Q?stjYCxyftXRA6IoSYEg40zsGLAqn/sw4kTf8W3yXRCyoocMS0D8BDju7+CCs?=
 =?us-ascii?Q?kBIo+ptzShGREq2c9cKkXlRabTf7IDlQXWmG8ZkogPzfUma7Fiyn0r41pqOS?=
 =?us-ascii?Q?s4VWIn1wmnZtN6ItAfXz3elcSolt6CwXoBpX1V7oTcRSZQCutXR5p1yuRoUR?=
 =?us-ascii?Q?/t/8cqILqpLHb2uX5s5RJ0OYGZ0XYfIa50FVEWo7DKhzgGIP5bG9zRcJw9yG?=
 =?us-ascii?Q?U3ktNlG5OPjenKmOVWKegwx1kD9qnBkwNFN2T/NIK5Q7M6VjMXO4sOwKgmHk?=
 =?us-ascii?Q?xazC8aNVCmIlnW7ywxOsqnMYj+DKoGiBtrVPbkSUsgPC0uc0Ipcv62xEk5PV?=
 =?us-ascii?Q?Vnbabqhr8kcDkwGfLBtMYFTuXvaHxwABslw8PFDZsrBcwAIQqQFafle6VRWf?=
 =?us-ascii?Q?niGOWdmetbo5AASiRhw+XaCVVyWjKOfrWdiMEmIhoANpD48xnTpgg42CrOsA?=
 =?us-ascii?Q?uzWAMYu2v8HGylgH2xgkfMpESJubQQ2tKkbUaiJxcIfWFIUVfOmkQjslsDw6?=
 =?us-ascii?Q?qmEL434PEABMoqxlHitybuSJgMgmhAZoTG7UgPc8lje8/OzlSogeZY4QPMh+?=
 =?us-ascii?Q?topV5KYDQFaD70GmEh4oW/b3bNiwa58XD1Y4jZjnF3A3DaW2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59861c8b-4698-4088-53ae-08ded8199545
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 09:09:12.6674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7hgC+l5dwE6fAszUaFRNfb9fXM+9f7qP7YtVR7MV4aNDfVwiuBpz4zwUwbgGQ00klZRh/5weLpZwz1cnj6N9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFD8936FA16

cxl_get_poison_unmapped() sweeps the unmapped tail of each partition
from ctx->part onward. A fully-mapped partition has no unmapped tail,
it's a normal per-partition state, but the loop treated it with break,
aborting the whole sweep and silently skipping unmapped poison in all
later partition. Use continue so a fully-mapped partition is skipped and
later partitions are still scanned.

Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1->v2:
    - Tweak commit message
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..be246fb09c99 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2931,7 +2931,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 			offset = res->start;
 		length = res->end - offset + 1;
 		if (!length)
-			break;
+			continue;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
 		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
 			continue;
-- 
2.43.0

