Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D13C4B82;
	Fri, 29 May 2026 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047695; cv=fail; b=eshkJEvNdx3airb14ecjtXWg/lrwLvNq3gHtCEC+tuPLF6PMcWAX/pwYVmmKG6pIZtuXc6HceMQp/fBG4pEFrKlIPSm9VvXejj435XKfv6GBY0DPNlSzBdcB39hQZny/RcZtnhNk+oa9kP+kEBliVPys8G7VWHGAI06ZHHiMyH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047695; c=relaxed/simple;
	bh=PuUxXUL9CJZIsRSrrC6tG1ruc0V+8V8ABD/l9zGTRlc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ph0tBw7KrlSrx3bnBn2I798e5g+L4ImvsZnfB0eO7088EDQBRlCOteSfE/vCEwZmDLbuM6wUmvq1bHLqpaH/3PIVQNrFy0fSP+lKCZ5cHwZqOQhr2X69lo0k5JymW3iJzzs/p220XlYUuMUyoL/kZ0BldgZwXm1thsfADcD31Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BoalQm6/; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BoalQm6/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rayc0bqtjmNhDJZ0Plg9K51HJe4WihuYqAJLIsPreoue0/PxE/6v6qlH0gS8vI/qB2z4fmTtFOodVUu1ajKtZmRmRu5C2xUxR3CGFN39DzS1nuinrPkIwNQczpU2QETku7H0aogqdSmnMBcGgjlDUo+CHA1Q67NTkpfWWNDDY1vefNVzcFjvfTjDz/jdjmyKq4+AqM7tqgbr43f7bYbnvR+MYM9+6LX38/p28WBKXKwJAW5wQ794iJc6sA7XnCBSjI97wQxjaAyC+4ARExvuGWyfMIfkwumhEc8gRAw+xcoRjc5nabkLOmI1dcgi4GEgVXMXuK5ZOHiJtuZB+3av8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw1dHDelci5Hkm5EqhlGtpyEQ9gTCRMxw64nHiilJLg=;
 b=OxkcbCf5QNmVm7cbi3zBWHBHTWDHK1g6l0/d0DXYiAYIrCvPVtPkZ4Fo118WSAc+9hRqm7ErevomVKBUYX339GulClNqpXEX2OL3g7ZQm0YIWfJFilfKr0oUjOUYSNfJ+Ux1yOh3VxE+UgMBNbPvGBQa+ClLWyvfUVetV17JrCI9Z2nM2CRZn6PxOfJblZR/FDqjQ9oXJ1wSOfxBoLE/cD2WdeKLlyIsLUKSsWXgF8l+0u5Ilfz/uu408fZmOjO3CevmnMgEcJIf8avib5U4wivkRggz89O1t4M5IqJKLv+KlGIxT2aEYTNbGgxGXBTofXRaUQTDKL+ja1XPNx5KDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw1dHDelci5Hkm5EqhlGtpyEQ9gTCRMxw64nHiilJLg=;
 b=BoalQm6/1b1Ygz6BR4abjYidk9x6/7Fm/rtPJZUamWMFOfHh8aSDfxk0LCsm+c5a5UctAwv3KeGC0cD772M7F9VTeIz9Mf6Xc4afk2PTFXqDW1NixO/XbCOJX2/S3w4nPvsxFQf8vWuEFSDLMZZS8+HZETF1PNGFC6ZM6oawtV0mdp74h2zpmvLOUo/R8180r2MKzMkP7YorcWYiITYJgxK6lgRu1+SE3W2KyB2XIBHjklioV5bz8KoIats+gVZzsJbhBgucM0sdox3WPIbnlsTMD0369gCS70WWDDieoZdt0/mDTh/a/q8fkkBANW+Nq5Z06hR+RwLiE3vai4TdNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by BN7PPF7F4CD71A4.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 09:41:26 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 09:41:26 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Cc: fabio.m.de.francesco@linux.intel.com,
	ming.li@zohomail.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH] tools/testing/cxl: Resolve auto-region decoder targets like real HW
Date: Fri, 29 May 2026 17:41:19 +0800
Message-ID: <20260529094119.49331-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0023.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::7)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|BN7PPF7F4CD71A4:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df1e8ca-25a4-4f6b-125a-08debd6673f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|6133799003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	nRLoT+RKdU9o90IetsE6mY/wdFgGf/xEqaK+2fiITg1c5gauRLOOjOS9qu7hLJ9vAjb81BT8erFgQgiPNJglohPDozo8dQY/9XtfoQhhyOPMv/ngBPyN+7hcX5ZA5Ah7eyU0DiiusQx2MXUSCk0+vaaodE+a9/yQwrlMRNF2xYahvan0pCIaqzWqJRAnt3/EgXvRo0z3qzSYccDF+6T3KisZIC8l1gu535dQDwbisz30sMh4heGl0Y2w2R9lN1IbqZS04cyd/oeNzvLjKWOX84NvdXg9cb8Ldi1qt7IjxIt7AMqZPfmdAZnVWStTohNkfFZNAQ7TOniae4MC3gJ7oWFENZq8/vRO4HQRVo7yVRETzINaEOUvdwPuz/ufAQeWgqT0ximZ1S56dX6Jn94R2v2yp1/rDTWbwowUkgxTupjibz2XBHtbDnyk/A5v+VGEHXK+7px1IXn7Im5MGQcMuYlpjcCRtUZTPGlEHhWqninCK/iznUWorqArKynVeCOI2J7HvO2PxqwU1AvNpetfia5q92fSkJO6rVnj0sjJHcnn+CjX4hLGXuPBrjWTiysXrhW4EK7uJyEJsbZcvNGMnM6qCLulmlO0aW4JLq7CHPfDGCzJ4/9z8phaBjDYw5Bj82ZlsA29HDEj9WfMmz+U4/0jxwO4R1/Dhy0maeo0RsRuUNabg9yH/ENqS4sufrE3w/YRLUW6zzp9DhP3iBf/EQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(6133799003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eh6C+bvjyn8JrwM9O4XrquE2MG6T6b3QKPPctyExmZyiNomrmr6ZHggXt6s2?=
 =?us-ascii?Q?pdXbcGfEXPi6d5zsEAyNhLyWSd3ycPu2xNgO5ny4pPsDZ13UTvgyFzI7i5Yl?=
 =?us-ascii?Q?E6v9TepL/IdIhnnfJ4FWbaSSwJFxDq8CoTEUlr2CS4P93Zdbt7otTDFkVK9s?=
 =?us-ascii?Q?kuhasK4GHjG+5AWGXj21weNjiFDi53zeNLAAsqMqBXJpUEKgoEt210uFkwgf?=
 =?us-ascii?Q?jQxWhIn7CTLvQ0Y5m5FF2cleqjD55H8J17YaTeRP6fETg4Hf7XUoL+V1B6iF?=
 =?us-ascii?Q?GnELFlgkA9kXILn7a5cGJdw1xPZXUNlnS3b2mXulYnYdmRQvcwDFiECOHYt2?=
 =?us-ascii?Q?5ul1d1TocujisTjvjqreJ7ktKRG3+xNwgNL/k2Ob7zyxFELSU3xvvFCylxID?=
 =?us-ascii?Q?P0IFRvtxCHKbQ9+PvC44+d7yRlrzahIj2gQ/bMQ0PHq1W8CHfUekqS2r8nvU?=
 =?us-ascii?Q?uvDq3c6McHvE2l2AWI16I28aTyFS2BCumXZcwT8VASbJuUPyiMLIqXe78f94?=
 =?us-ascii?Q?Y6WBl+XT+TqAj6NGw9t+rsBBCm5Sb3pr+0mPuKw3RsI9Eec7yxBELqv+hyIT?=
 =?us-ascii?Q?RE7DQNbCd7+YRRgUICC9fQIYJh0RjrcII5Mq4mJiDipao0nHIPx3rOkzSgkX?=
 =?us-ascii?Q?db1+zTNhxEh2vH/ooACdXXbDw9fsF9N58Mh8YBYhbloaS+M1FsTcC2RKxxFb?=
 =?us-ascii?Q?oj6AGvkQ9/FHJ49R4DnbnXtIR+Dz+/+wnvfAGryHZcME+fCVj563I84S+/g+?=
 =?us-ascii?Q?Z1cGJoDDIG4sf/RuRvVzmxsHe/qPWmd/Fqy8+TRR+Q5465g433mhiMW/NYsr?=
 =?us-ascii?Q?OcRE8sqcBcoe1u4R1t34g4U7CqeyEKwUbeR+jhyyPKDrvQslyCJR76JOitIm?=
 =?us-ascii?Q?/9X4b9wzSnqZZW+nSBqbbvC2o2pM6FrfPkPb5mtZQMzltGtdtgqych3g27M9?=
 =?us-ascii?Q?IylvG11vVRW8xIwtjdF/kW6/6nbBXO2PAzEwfts1QjHB65ZQDx9Lf0FuGH17?=
 =?us-ascii?Q?w228F8fehLpY7fXYqLJTL2btm6u89AtkSM1cz94C0vcRyOUF//4PuUGb2JtA?=
 =?us-ascii?Q?EMcs93Y3sxWKFo7q6FRaYWJGPhiggBcyXiMJ+JK4G4l/T+WEksqKrspX/J6v?=
 =?us-ascii?Q?Vb8Kqf0dy1atafWapXME/Bi7u6bZC02FKMisClzsSDTRglVLC3F/u5m1oMdv?=
 =?us-ascii?Q?Ulm7zmEOIup3mXoUQaIfA+Rdk/Vr9RQ8prEauk9eaAOlW2xHMkoQVRYeDoG2?=
 =?us-ascii?Q?81/mcFI/Lo8j57DMV7AaM6nds4qLfusYGtzzPLiERJVsuKouLCBjpgrZusEC?=
 =?us-ascii?Q?3Uydrr8EwAX4CzttxwKkPgtZvHsKRHBPXLBXnheoCHAUG+fWYeYR4O/MLJ1z?=
 =?us-ascii?Q?/cZmnaLwxNs9rw0JgZu4pAKkzQ9WkEFAQyj8TlQqz/93O6l1cNKl5A/0CTu5?=
 =?us-ascii?Q?eVpZYR2O246sU1OCGn49gazDTA7a3dLZTQZV4ZZ8MaxzmjfTFRJ8vUKM27cc?=
 =?us-ascii?Q?DalFcTDSbkcgFj+PkYIbe5vgrkSJ6V98GsrS4MU31j/CkTNBgIE3+WkhYPM0?=
 =?us-ascii?Q?Tufa2fL6TJilOjQL/C5Be/K575dICUvg5y/yoX6mYopbfpuF+ZRjaFKxNiwI?=
 =?us-ascii?Q?eQSDCbFN/AhvFo7iRnkgrM0iocR13zvD2ZOo7G5b8TzVkQTulsoAScO/xWC3?=
 =?us-ascii?Q?7Us6Ybjp/226pkqkzuVafLlJdRkJK/P9MKJlYQedVXiMehIftIYc9HGLgb8l?=
 =?us-ascii?Q?xrmGsMfqtQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df1e8ca-25a4-4f6b-125a-08debd6673f6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 09:41:26.6235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIfVX8h2pivgXG4fA88RbL5p5gN7WMWpGAbOUyRPzgoRa95RRDxl/Ksn6D/AuAooz43reHlZ94Km335X3LP/WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7F4CD71A4

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

