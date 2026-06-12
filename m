Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012026.outbound.protection.outlook.com [40.93.195.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E61D2D4B68;
	Fri, 12 Jun 2026 01:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226762; cv=fail; b=E0hOXwsowlRQ+LHowYg6kgpN+lTb/u844ht3Zh/x9M243t+6kkNxkJchNP4Hhtq+2l88Tl6oTs2G4SBA/avcDeVXVd82JR7P496uBCdsnlW5/km9cnrM7M0JktZJR9P9KskjPsstSY4nWP++7vaM3cChs3l72P6RiSHiSSlKA8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226762; c=relaxed/simple;
	bh=PuUxXUL9CJZIsRSrrC6tG1ruc0V+8V8ABD/l9zGTRlc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oCMd88xJehT0aVLU3wPvNHVJbVINZb36SYx7k0SfoEbCpRgXUTrahENj5o9MI/tTcGbr/UcnLbJoQt8EMZKTWU4Lgtu18vD0JU4bfy7v5BGkXkK1UJebY+UB2BuwGi9LJUy+Ku2R0VsKBHkvVLfwJBOYO7TDVi4c3IKVKOiJBH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EnI3eYg/; arc=fail smtp.client-ip=40.93.195.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EnI3eYg/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpsdyYoZ6O/9r7fB1QE2KmT14NGHjjf1LRT0y8YL4vh6PsWT3ydi1H9wPuAxa8PMp63hcm1AXLulAry6PvfJbjG8AMQeFRfznMlTltkw6O/bOzj7/pk8IZZj3lH6MLky7iYMdwq/yEmszVrjgrSwT3BnQ9eHppYk35WY1054N920ZfFu9HW2wk9DhpHsHCd/Jn6uArj1itOySRsgOpQTfCc3okDol6qW7iOXal5ZugAeGEfiPdz/8Fi8UTB/NiccCEZQEj3wqZg+Ol2pxgA9LwbUjfgf7SyM8UrVtW8+RF/l7WFd8VvMcfKVRzIsnj09CC8cZ7J6GqnkJXMOv36Qdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw1dHDelci5Hkm5EqhlGtpyEQ9gTCRMxw64nHiilJLg=;
 b=Db+yPYFAoZ/2sZ+kCTwKSRCtDkL+y+jwkFUzxFyNXTo44wS4iMlm2EhwXG381oz0RdaGcD23M5EuC2r7yM5Tw11XDvDc/N06oI9nVIpI/crTsryZ9son2C39mrnxTjOuH8ONLsb4WSzoEIpVPtDqhG7N35NiNHZrhREi2f2ktGQNHBHJze2XAI7PBrx074vUBmT87hpff832soYJ8cSJRzuSpbpBZvivT3tLWvxmBz67NKgoue3nv+Qs73bIcA+R1mBVh3fojS/9ItLqbIwXnvIB3g23c2Wyj+5p3P+NJal2ePpA4fviHmKDwSq0Ts2YToXADCsgYruosW+CcjOcoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw1dHDelci5Hkm5EqhlGtpyEQ9gTCRMxw64nHiilJLg=;
 b=EnI3eYg/ADNORa53Uw7veb6LCBpQtDxOl4ORvTcWNr/V/aRS3KQvm7BgQwpFT4CoxT0Owmsgn5AGG2+1JJ9J3uvJzunLBtp50r0gq9/cQnknm8XV0UWb6ZVR9XkCFWOPUVjH79hRSr4CNjCsKlZHfZiy2ksSu57lNOIwDVnsorRTcc3sqtOhFAjNSO25+BiG/6g3Mo2oDjt748mMcQT+IxYpBS/VXV0aCc4OvdQU0ftVPBrkRfNrViwJDQkqqgPGbgjACMlopz8m9CiB30p9KVEHh92AGiKoTvBR+18coHHZARDRBwa7Hhw9UXQPsXQJNkHnJrEmKTgcHrbmRFAhWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB8756.namprd12.prod.outlook.com (2603:10b6:610:17f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 01:12:34 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 01:12:34 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org,
	shiju.jose@huawei.com,
	ming.li@zohomail.com
Cc: alucerop@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH RESEND] tools/testing/cxl: Resolve auto-region decoder targets like real HW
Date: Fri, 12 Jun 2026 09:12:27 +0800
Message-ID: <20260612011227.4220-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0057.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bfe4acf-a456-4822-e21d-08dec81faf35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|6133799003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZNrp/FmmWtacNg1jLljEEqVOZRBsp7f9RV8j3ZCaPweorNn/LgjFqoTHooaVGTXnG7sQBz1L/XojVQq7p8vBkdBs4QaPR61xKHtEUDhuVsiqYOeG7rDElBLiQLOXb9F9bSEGSWNiYHwCXhRTKPgCKPY2qWsRwAp08L5eULmrbXWngQ71/Rko9ymVmB9d4ZbkBSBf89MDB8fbEd7zxZ3iZWTsHaboLptbHIb/o6f10PXErcp+xXjOAqaoElI0dU/fOQMNu5w4VWU3USYYxj4eeClCsuBVF7W0oJr59PpijlBkwuUtauFKMioonJWJotERUBAk9Dan10IUQ8fnMP9SOLfvgauymUmAZ8oEVCzNH6gzs9kvw3Wxk48JApL5S+cK4fIRQm+fkqTO25O0ax+cnhqYemWJZV+It3c1VlhGHOe+fhWHad35+39P3e0NfZotSsqqg3cRpwP7E63I0+PnqPju+hXvl+fhHShkfX1doXCHGjvoFKAGiTrzrz5HqOvV3o5bkwW8e+5NOfw9e5mJP+twWVC9hi3okVJQDoB9AlWNZwUjKV0P1tx8OM7HP+O8SdLHKo1+LhxxPkC+Qjpcb9utYHnedoZWSnT24txRAVyKzOhLM9faQ+iU0Uaja4uqv8VPeS08Xv56ncG+EUgBuEjBK1cxl8WXm0TBXfyFB/0lQ93pITabtLhCQpbCBnlS4KhEjMaL6R6hFkEg42h5cA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(6133799003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3cgkdX980qSMB1j2jhqgoq5c79CLR9MyYXp6jwmRkMe5O8lyHpNKWg3KDaZp?=
 =?us-ascii?Q?jYOetd1l2XrDTzybdRgxJQWmQF29GIrZSpYXhPRkuj++SeJpcZ9ZdatpPOla?=
 =?us-ascii?Q?JRZhfe9NDBZeEkstJxKxPId1Yd1nTD/QrE3IHaqkLbHLvJmz+E2oLO7ZAGZS?=
 =?us-ascii?Q?c5IFZyAx8S/E6Ngund9PwskzQy12gqd4jOrsGHZN61sf4xz/YMIQmjYHCRKD?=
 =?us-ascii?Q?SOQZu2i/GZvqN4LgG74riRvMVNw02HbQvJhCqCJNnRW+OHw6Rbw8tjLzzBLK?=
 =?us-ascii?Q?ZzFK1SD/vcNWGGONnmm9ez4ovIcS2jnBaByButMxdv3PwM3/YYyWUlqLCQ3N?=
 =?us-ascii?Q?DAhp3xJKghAd/8pteeUb3Fl4TLtCIEV6Gj6Hh6o0pYElwjYSyiAjXBsevRdI?=
 =?us-ascii?Q?ESeAvRkJ0FOBu09KToJ9eHoChKu7lXPnxke8aU02NkLCIPrsxJureA9ZMNDu?=
 =?us-ascii?Q?0HQiIUEhRTH0m9pU+jBEboW6NpYsbcHSM6/yBHFiZxRIMH85hHAGTl69ByUU?=
 =?us-ascii?Q?v8JqJkqxJ7RJTypaqOfzaQgm2UfLnw16Jwp68jjalj34taHPPRyYPo5K6B4f?=
 =?us-ascii?Q?ir8SvGkNjUhTwFnLkmM/nF8Dy8a6k9kTBVioChaSmXozIsDuO3hSWjgkzcWI?=
 =?us-ascii?Q?88pvNsZFnGTVssFjBps+f34lqzi1S96RHXSyfqnYR+7tFb3RCvWMtxK+YQKI?=
 =?us-ascii?Q?Trx/WWydzLzAQJezTis/dnItbmqVuVlNEY1fTBOSI81lvR99eMoTkXV3XPsx?=
 =?us-ascii?Q?HvEq3SwV7M7PoN8D5nG2+9wOYyq2X7xX+baQg5oBuwzhD5fu6vTnVdZMsfEG?=
 =?us-ascii?Q?morxaijNVXZOeZEvvNDYz4VD58ieISlsvWhDP4E4JqkSJ4XUxR8Ws0EpPVo5?=
 =?us-ascii?Q?ze3UKmtfV7SV6rtDb4JtzZqyGhd643mSB1pKIhd9mpfnAbc9Mf9sAP+IFOYJ?=
 =?us-ascii?Q?nOKYLEY48Iq+ucg4x8vPy1D3ZTOQzDCLgMO4PKetxxuMscQx0Xgx+NyedyVp?=
 =?us-ascii?Q?nnBO2o4fbFX2/kDEiJ/pA2zxOrSTNBZaaOYPkwXKE5TFG9gmcMmYczUyxWHy?=
 =?us-ascii?Q?FYkpsufNvdRZBc/yl8FSzq3+0nFFpUVf2PWw9NNytKTGjqk+dzR9K7R7PdX2?=
 =?us-ascii?Q?YUmV+DG0z9gThfPQ77QDh9YCue0GM3mKOCJvF4OrC637Quaq3/GRmJUf7AB2?=
 =?us-ascii?Q?y8o7y3oE73zw8FsIKtdjQ7qZM/VxabuzieegN9xKM9DBPuMU9T3nZQCHURlU?=
 =?us-ascii?Q?puT6/0XMu2rkVFQcR2kW00riSBRRCVuuohkmoIfK2KHqJaCzyFRo+ESzAQOp?=
 =?us-ascii?Q?tq8wtz70pMMc/syKNQBBEYLAUkGQsbaY6jGFRwM45seLex713HLPGW+NOm9L?=
 =?us-ascii?Q?7Fn9pLmAHhgLSNo4yniCypouOuM8NXHiKqHw+DqWDhvd8zidzJPaSVqx4ZF9?=
 =?us-ascii?Q?t+niUwV21LuFKB/I0VmOY+Z4uU7ZOpGpyxRbqLgYJKNLutRYh2ENUXTgbD/v?=
 =?us-ascii?Q?eOg3f7P50rYAB69yfoKo62IK4VBdv/aoNCQj6p6WzzXJclPBBFFnjDVlZrXu?=
 =?us-ascii?Q?bbjOsxnD2soGfjqT75+7DZaUST4tyzx+AIInmJQHqzAQoz1wTPABpfAYts/h?=
 =?us-ascii?Q?wXeEW4UF1oE2xIscjiUVG6sgOWcwrD3BX6VN6pMzszviW2BxaRMvowq6M0zK?=
 =?us-ascii?Q?RBgLkRXecG6s0TLvoSB8sHAl28oUMBraYzSLdaHQ9MQsgf1RlGoqJQ7bBa+Z?=
 =?us-ascii?Q?c3u0mmcQQg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfe4acf-a456-4822-e21d-08dec81faf35
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 01:12:34.6528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztCgxoblcd+kk/9g+mb8Gd2CWvOY1Q8YqohpPeLnT2EGZhZ90G1IFeAjG9gOWREsfaIJBU0ZfUu0WfxxTqgdMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8756

The mock auto-region created at module load wrote switch and host-bridge
decoder target[] directly, in addition to target_map[]. Real HW programs
only target_map[] and resolves target[] as dports enumerate, via
update_decoder_targets(). Region replay already follows that ordering,
the initial auto-region did not.

Drop the direct target[] writes and call
cxl_port_update_decoder_targets() so target[] is resolved the same way
as real HW and region replay, exercising more of the auto-region driver
path.

This is inspired by the discussion [1] below:

[1]: https://lore.kernel.org/all/20260521084806.28232-1-icheng@nvidia.com/
Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
cxl_mock_mem didn't load together when I manually modprobe cxl_test
module, should we make them loaded together automatically for better
user experience?

Best regards,
Richard Cheng.
---
 tools/testing/cxl/test/cxl.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 418669927fb0..5266aa3733cb 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1181,15 +1181,11 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		cxlsd = to_cxl_switch_decoder(dev);
 		if (i == 0) {
 			/* put cxl_mem.4 second in the decode order */
-			if (pdev->id == 4) {
-				cxlsd->target[1] = dport;
+			if (pdev->id == 4)
 				cxlsd->cxld.target_map[1] = dport->port_id;
-			} else {
-				cxlsd->target[0] = dport;
+			else
 				cxlsd->cxld.target_map[0] = dport->port_id;
-			}
 		} else {
-			cxlsd->target[0] = dport;
 			cxlsd->cxld.target_map[0] = dport->port_id;
 		}
 		cxld = &cxlsd->cxld;
@@ -1212,6 +1208,16 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		cxld->commit = mock_decoder_commit;
 		cxld->reset = mock_decoder_reset;
 
+		/*
+		 * Only target_map[] is programmed above, mimicking
+		 * firmware. On real hardware target[] is populated as
+		 * dports enumerate, via update_decoder_targets(). The
+		 * mock's dports are already bound by now, so fire that
+		 * resolution explicitly here rather than stamping
+		 * target[] directly.
+		 */
+		cxl_port_update_decoder_targets(iter, dport);
+
 		cxld_registry_update(cxld);
 		put_device(dev);
 	}
-- 
2.43.0

