Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2059.outbound.protection.outlook.com [40.107.215.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872111CAAC;
	Thu, 29 Aug 2024 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935971; cv=fail; b=Pty6RzArM46IuAd1hHl3G3/uVt4dtdQkv9He9lz2viWYnZFmJ7CWnvwSgq/B77WLJbboEiZBcNguaOsVNJ0ANESwdEEqFTh+PWHtaOmt02I14na2GEQI0eLRmfANs1hRsH3dXDIlbRniRdG6sCDdCrKxw5dkXBUNUVXVIq7mvF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935971; c=relaxed/simple;
	bh=Di59dCS1rM0ALl5SfzjzDqADQVA6k636/ae909RdVXY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gY9CP/GkZ+T/0NHXV3SzzkyPWNq3Zor7Ie3L5XoavyiYacpCC2rC39PI6eKhg4V2S0UE0HYnMjWCF12TaOUk3VF/NIDMFsilqSKCSRaJvdYq4zTq4zAEwjZpt8INBUPCv3Ruyc70CblAlZLo7Ge97kPjWoiOWKM5WRJczUVvJFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JtTQgtdr; arc=fail smtp.client-ip=40.107.215.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JtTQgtdr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeReX8/Ihf2AjbPTmQJ4jcG/iduN1c+WcetaRr15zMsNf6FGOPTpO/SwONtQcYJzrQpORUh+x3z5IyoxrAFR9tzJ4kosFPwr7jc05D0v4UwIv12o0Mazv+ok9YPPq8sM2pYGCQXMy81rRTbQcKteOIGpm76kAs7oW48Yjhwa2Tgy1dvGrcnjK5cysDW3lqaTaIeDtxbXdKWnpCz574ohm/M4gxpNitSsbBYa33OT7g34Q8qHRReaNwSAYZ4J/PkQv5dExSG1oGb9nR+88O3ej/scY0vj9ES6LKA0jVgoByjuXPUWFDpGMziS9ig2Rbsa6RyaIHWSLVuwSeYZAILLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pa0odwKLT6YYnfgKQfkmeuWYX7ByIvBWY8YSsGpPzic=;
 b=gM6PwgIpxGAkTtYxRgDwApisuWG7LdkG+hX+vTCj01GQQbGFIp6C4eR1p9/FwRci0fGRL52v/O0as7qPyLKwJ6AhJg+Bw0glsIz+/xMbjvv8l+5C6/C4WYN/SseeLGefD1uXH4mZ4h3XjdLkUZDcvPHkeHlv9nzVvEG8MJu7P+W6jrNYFUp94vw8rFO7KUMtbCVMKH1XOxmsRQb7JX2LYcZiAR7/mrPMhxugExXfI4axGHz0oCeMoMwPbwZoSAgF00oz8NisNHDR4Pb2659KHBUS4TPRTmrKMDSIqtMQSTt8fhmFsW7lpppFuqNfPbgvy6esCPorUxI/eD0Sfzzz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pa0odwKLT6YYnfgKQfkmeuWYX7ByIvBWY8YSsGpPzic=;
 b=JtTQgtdrQAb37IC+0yS/JLIB1j2QOUgf5A64P5yq8b3fLpO2WLcEsv8Teqf/Vwbn+lAFW1ONCNAnw/fAi59Fc/OTc7022h/z1kBK3CTt+HYgFYss7OyAvsLqKlqvEemp4bKO9/lXqLA/sHVvVAB1aQWe0KmhYzW0MZBDBez7BA0RgiBDX6FURlw1lQ65M44b5g2pwFwn2OnS+dcqsXclQcGEJ1QU2SXH8Rq2XNC9c8S+PCuLxj7WStrV+y3ogJvhqcdkIczD1sFcHFbUga/1GWvZLAtpIESNzUs48a3aOv4TnyjEjaEMhAMdWy203B/hiw8QJRiAIqowp1Z0MzrYLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by TYZPR06MB6024.apcprd06.prod.outlook.com (2603:1096:400:335::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Thu, 29 Aug
 2024 12:52:46 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:52:46 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com,
	Benjamin.Cheatham@amd.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH v1] cxl/port: Convert to use ERR_CAST()
Date: Thu, 29 Aug 2024 20:52:35 +0800
Message-Id: <20240829125235.3266865-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0366.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::6) To TYZPR06MB5709.apcprd06.prod.outlook.com
 (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|TYZPR06MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: f8af8e1c-0529-4568-9eff-08dcc8297afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jIYYLobnJQcKYz6AhACIty4R+X0yv/9mPaFvMh/23SiUmizd+B2wAtv2S3lk?=
 =?us-ascii?Q?bih5/YEO2Y71eR2UrfKwpbj3NxLKF01XlTjnM57GVsfEj+CPh8LpQ1r2ok98?=
 =?us-ascii?Q?Fo0f+O5oohDi2643zIpn28jvLIfznKwNBIN2fWE2HttKS0+r0Yg3tXprNHyK?=
 =?us-ascii?Q?bLl5eTPfUu6cFnqf64JOCRyvUAqgGezKN+nqNLrzZwZpnGnVmM4HHnsTnhQt?=
 =?us-ascii?Q?2OEs7AOw+uDgS1fSkre8k7bsns2ceGP51jUE9qDCuERRoSdjPNW7s1Rvd464?=
 =?us-ascii?Q?mZ0xI/BptuJ2Oa+2Qa5kTpqSCZge72VYFdVikVLON1H245zsVSe3O4kF7ehR?=
 =?us-ascii?Q?vxe5N65Rm7Y88+5F6iX75Ejnulk5BtKEH74UkVAXaOMoYRDxc6X6HxN2M1hd?=
 =?us-ascii?Q?bzCdHNlUF27CNvseB7axcbbXzGeb1Ro5whTUvgy5DlHsDljYPfY6uRKSx27R?=
 =?us-ascii?Q?dMtaacs+su/Ddyu1ByJjplZ/7rd0TkIqHmx4eI7mRiCU4eb5Ri5s18fUAnou?=
 =?us-ascii?Q?c3YFTLnogk8irlZD6RvT6XxqF76A4pyrchAVxEA572R4UX5730J3HeDVo3sp?=
 =?us-ascii?Q?EHrdqV+55yYTrSnoR75/W5lEnF1osI3du4NyDn95Dw7pQCFEXk3EaYJhUltO?=
 =?us-ascii?Q?lNMkB2TVbrInoBiTHoGaSkWF2GlH1LU6UU/SQjKjI39FpqYHslFmENsLLCJ/?=
 =?us-ascii?Q?HsxW/+ao3Em6649dEljbqdywYI4D/fcw6QBzm8CarKzjA8CCdow/08dhXHpK?=
 =?us-ascii?Q?oYuWymHefqEFtcVSlQDbeU8LQ/0DoVox6vc/ETCG0dkUUQYE7iOiq4AB5G/r?=
 =?us-ascii?Q?6QP+dZ82xB6ZpGB64IzKqrmsGHcwT5OaIJHQIsyxyLVkgRkRf3XcEEkRuanT?=
 =?us-ascii?Q?lN6WY6G7sMI9HDILZ8C6zgYNOd7KM4mTlH4i5OBrdytjUADzaM0gb9El7xMv?=
 =?us-ascii?Q?FKHQq/cfRl37BJiUzt++yGNmJYIIxgotOxyoUwUF54vKTSgSEKN9OhYt161G?=
 =?us-ascii?Q?dSDU3dXfYheLTSfxCPJBYRq6LzfkQkHdHPuQEkrzszLJA/pAeyeMMI57fV+B?=
 =?us-ascii?Q?0nhvJVn1MosXb5zEB4znFkbltT8ThBTS5U6Yq/dixcrCcgLj3xO52+e/N30A?=
 =?us-ascii?Q?oHnHIss4NT8dGyVen+VSIy2U16APPPFRl/xMPrKG4dENFNeUCc5UT+tqcfty?=
 =?us-ascii?Q?2jMIPZURlHFCaRFW+iL7awwrF5e6KvaVIEwb9G1V2zOjoN01/JiXSs7v96ZQ?=
 =?us-ascii?Q?kJD+YlZ8nbhpxdJzn64MU0Y3dXxtFuKgsr4Tq8OZDIdYHFxl+Y3dwAXev9Yp?=
 =?us-ascii?Q?O6lI1nCXTDTgO+vRSi9MYLpiSxzR85BhHSoxFQYiKBDTsY2HLcS0sAH1cj4r?=
 =?us-ascii?Q?QZRHMa8j9jkbVq9cFBxIb4v4Fsaj7QcoQiOlR/H1jd0v2n5UmtZYJ2uQrtwz?=
 =?us-ascii?Q?HmlXAgdPAFM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aJGcAY7vCpxvq4sTpOV+GmoA2tecJmGFc5Acaqp+nEslC8LZSwMptQwVRb7x?=
 =?us-ascii?Q?b0lbtYiYGeyQqi7AFaecjLetry+hXIrDM3GHjREeg88mDBgsCQ9pFVAefomZ?=
 =?us-ascii?Q?AhEUUvbOjnC+L4LmTLB90zufc7POX+3wp414abgrbRyhcXlQwA4Yer2dNs5q?=
 =?us-ascii?Q?U5bblwZeboC+PDtRpt6W3yUcw7l5HgFESYM/VtXOvP20A95fK9cCC1mAD1v3?=
 =?us-ascii?Q?5G0C/QHU3QjER8tl37xYI+JtDvpNVnW2W5eJElMTTvkwvoOIxr0qRphAZgYL?=
 =?us-ascii?Q?PxQBFoKshSBsIAXYEo+yCrlOI/T8KtP3wUToVXKRqXiQzAgCDKpxpRVfgNSC?=
 =?us-ascii?Q?+JhSJ0602Owzmu4EfIOVfd+KVAC12d8lcH/7EqlCODSv73It2rwtOuyOoZ5g?=
 =?us-ascii?Q?LrceeX76kvCTGPijZe+hBTYElw5SNZUYmWKW66oJsOT0kCbD2W/iV+j3tK2f?=
 =?us-ascii?Q?oRcTEvWNQlP4bkF9rl5czfyqt5RAVQU2a9IRfgFegGJRB6278evRvHBkYNNY?=
 =?us-ascii?Q?yJK8drn0bCb8xZxg9rDjqaaikGZ0QXNzsHMaF40z4mVDuiC098T21QSKV84c?=
 =?us-ascii?Q?J/LgyWUTFxKYqYx9exWtgknoXr7Ar9yTdGETSwgZgdYpemE2LNONhRBw/rs9?=
 =?us-ascii?Q?k8Ri1qr1egvwBoVKDTYBCRAxsldX2to4GlH6Wfrcm+BNdD5XGvhimqSYHAk3?=
 =?us-ascii?Q?13cMgXoBz4yVzRFt7Z0KUwSx0UO1lKY+I473crB11G4OpyCrzEkCAqyf2Yyr?=
 =?us-ascii?Q?XwkTLJIt7bXS/CioqGawiUto6KzGuxRKAQBc3VB9NIpKjMrClI5ZsXLQdVvW?=
 =?us-ascii?Q?MNIuRznL2PR6gk/dXafOgYv71eYeH67FWNochw/s4Y4vZVm3ucPM48gQElhH?=
 =?us-ascii?Q?7nW0oeqb1Ubt5a4nQNcuim4G/OuLNmECQ8ff+CdhAqB6tVleKJWjtU3Obvcr?=
 =?us-ascii?Q?ku/I7C4lbm/DQ7wf7QIH+Gw5Flgt1pIW4bnQfTbZ+ThofXv2kRFylpoWikAR?=
 =?us-ascii?Q?o/AS+scjOJrwgdEIrl719GGNOHpzr0fqZYoGSA1ujRPd3V5sgadSGLRs9U8I?=
 =?us-ascii?Q?nu8Q4nYwdX8v/AFIeQKlAJSJoX8Sxz+eLJBtFTMrMZ0yPI3pV9e2Ou2LPZZd?=
 =?us-ascii?Q?JAVWNgQX/UWOqz8F/2NJAKESZa201hVVao08PAIkeN6gckJlVWedN5fKYiq3?=
 =?us-ascii?Q?aIAAgx5jAZt1QfnAAgyNg5WfW5FeJzFherXx4Yn9EgkdupGPGo6gfCukCrOG?=
 =?us-ascii?Q?DUZCrxtVUVVupAve/nfkFkOPy4Nq+nMfgg3HRkFtXyZMFiRdJaM+QzitxaJV?=
 =?us-ascii?Q?J8lApYFSPAcSVZEBo0/LogsizfGhP3ubgQejeCLmRuPVEwvvRkOV/4lw56eh?=
 =?us-ascii?Q?agsY4fz9wE4qxg4iu66F5vs8AQnwD8cUZRVGrS1PisY2SzLQLl/hD+gSb9Ng?=
 =?us-ascii?Q?s1YUKCepcJ2KzD8yWoCYBwUPSY+J37g0Q3DNWqekdIWuFzv+gB9sqoTmFkGP?=
 =?us-ascii?Q?Mw9knWkeeb97fBu7auZMHOoN4iPHscqVene13q3/EP334/tJe8EEdvfxxr6v?=
 =?us-ascii?Q?HJ3amaJqIEBw2aDI9osH891VFyr6l77H2IFcFc7F?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8af8e1c-0529-4568-9eff-08dcc8297afb
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:52:46.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfRj6/4Qku5iJMXCvNmLAJYy8uG5GofhjUCa8Lc5M5frFZptv1tfaaumISCfChRi62v9oXgJHF+bxe6VeGxKWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6024

Use ERR_CAST() as it is designed for casting an error pointer to
another type.

This macro utilizes the __force and __must_check modifiers, which instruct
the compiler to verify for errors at the locations where it is employed.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 drivers/cxl/core/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..bdd3275ad417 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -941,7 +941,7 @@ struct cxl_root *devm_cxl_add_root(struct device *host,
 
 	port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
 	if (IS_ERR(port))
-		return (struct cxl_root *)port;
+		return ERR_CAST(port);
 
 	cxl_root = to_cxl_root(port);
 	cxl_root->ops = ops;
-- 
2.34.1

