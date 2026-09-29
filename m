Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D7C2DB78C;
	Tue, 29 Sep 2026 02:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790647477; cv=fail; b=n/xd6ZNLTXw3dNKmrG+CgLs+bIn0O56WiDVEPzpTVfJekDsV4ADL36fRyZS1yWwJHCP4uhHtvgntTBrsftMWAzQUc6lVIb/iC/if6eE/f9Ij7QBgJ7A8Jwk3XbOylqzTB5IqmRx6eA3+Q99EwU0XSY4fFHkCxfyhg8IyIpAd+Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790647477; c=relaxed/simple;
	bh=993+nOyiurZY2DEqCOJ/8lAXXNjTlAQdgnlNwtJgq0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qw1HUJAfplQNOoxs41CD/oHNWDETX7Xn1K0+7Ph51tf7gbmsxHYC0MHoj2UfJNIBpCkQOT22p6Yu5MoFPEQyWhSk9rHDslY3yib3uUxP9kkLErOKuVSZHCKWquZMpPGNBM3CEyc+VAoaCz6Wc+p7OLjMYd9jxiAy2WFBH7RNpHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VudGkjtL; arc=fail smtp.client-ip=40.93.195.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VudGkjtL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7NyunolyrEIuRvEiwmlh3GupkiK3hd7bi8c5NSGOdn6tTjrVXA4ebtLN9uEqMoi3GUJl4O4mEFH1Pko1XB3uVwHa81BrItyWhy0GEqnhkwCzPw0vDhWMdCw5+3jGYS0MKFxLd00AdAzWTDYd1ZwdhrcQ2CAbKrzblRIaanOYz4kYpyypEoeCvToxo+Tp0zZDo/5Sv0vq1bKRhNCGyqnKFV+Sm/vdHGEC5t48t/5vgAblF6Yk48FQgM9tJxzte9dinB7GClZ8Moz7rpb2yF4uVTXkuyQpmCYTpAPmcrB4Tha01I4/2IJ1XFgfjrPxoWcD4gNrhL0KcMyg6UHu/Gc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lP0cGrjTOjIPUyHTN+v1ynHLAp3kmSe6Tt/u755fDM4=;
 b=uCggPAAHuUjb2DWXV/oeh/EYuCwYycgduVkwZE82B6tjUCWY9A2GdzKsh8gpZ4gTsMXhnnKKKt0Gays0iR1bqAF2AXn+QHzLqcn2KPIPmGYKMsoUFhrpj/Cg6gLDROo9ffx9f23x4RPOCXzbq3pnzTy2SENSDpFeMT3ScIg9PuQb76TTwiGL9efDxL/8kbWbz8+AT9Bo3X6FTiQDDsjeX78K2zl/ANVxunHEcTlYVWV6tgJ7COBZV/3vehVkabePfZ138J4DJeGGg3Le3KB7uMeTqbSxcpz8c0+40RJHapVGWXGl664fFVWrZOodEn3SoY1pIyRLhUiOOOabFwB+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP0cGrjTOjIPUyHTN+v1ynHLAp3kmSe6Tt/u755fDM4=;
 b=VudGkjtLSPDkf//H5NstZKnhzwjR16j2Jt3d1J/qWMF50GnNlQX9y1d7fcsh06hGssO4Y7k8kjUv1DiAtCjm0LmZhy/9+yXLpQTNuyHT0CIlDuAtJr/SwwxEXy4Nw48DkGEaP1Xg2sw3LLKU+0ooS0V0CZpVneKe4FzNy70Af/rld8X2sMjyPAIyRz9a2SQzH518s89/+6zuwX73vwAUJ6BTnpf/bAUHqGaB5GNk9ItZ8PaNGF09aim3XvdUnMDCEnzyo/y2qZOwskUo+SaPt/F0ejENiLIKCpncvBOrFL5mGIGeIqaKrPAGUdJKmKITtCNTX1KrEw3ejmivd81+LQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 02:04:32 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 02:04:28 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	iweiny@kernel.org
Cc: ming.li@zohomail.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH 2/4] PCI: Return -ETIMEOUT when reset readiness polling expires
Date: Tue, 29 Sep 2026 10:04:03 +0800
Message-ID: <20260929020405.9724-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260929020405.9724-1-icheng@nvidia.com>
References: <20260929020405.9724-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0013.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: e63bb301-1afa-4688-c301-08df1dcdfe59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vCHX3t1AruGHeJ3CQoOWtr+nMOMYbrAqtM8k/V75liElQjY8/Y5VBrF4rt3nuiS61eNB+8oeq3TebKIwcatM6ieKJopp5RzTNvSt4eEbAdu86hxbusdKrXMv+xPpe468iuuWZyT7M9eO0V+BRcAvaYWhcr2+2+WZySFbeiP/M5r8p3YFWhmNwu0kHs2GShoj51HvR0YfUO28GwdreWmito6tDxQqrKkkc+dEJd4H0K5EC0c8/+Y1Kkg8CPL7Ab/5QI7i/u5AZrd3uqJybBWAaVAXEdKbp09xAfNI5oQoI+d7xJYHS+SwgwxQTyG3G9PO+lDlRTWVSNDWhWid11DCsuTICeW/8SKdqyxq25DebwtZZoG56TdSoFnrzsag5tmP2Yq8L/mEgQgtaH3didYG+nfcr3iU8lZyFZBG9JGpxkDbqh7f6PIlRGPGLpGmmIvcBWvkrhcExwGkHygiLM7+iyASX5ueUn1L003rJr8P3346vKQbeFicEmh2SrmweN/b3Bj4vvKNeTOJgJzzltWVLMKO4CJ7HuC0oN4K7Za3sCpoYM6FmXjpUMmN9cizQ58hCFTHX1mLhOeuzKSvbKVo3keHNcC81dygv3njE7MG1WrrEDJTliVCfCS/qOpzK1DLZcsEp+bnkNj3tENvFpZZ8B2iFrfi+XJYU0A/RlXODYg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AEOv5XoYrvGPc0Cwrbi7DxbEG0vWB0zY0X+fGXhqNcj0M1GLKepla2PqEtg/?=
 =?us-ascii?Q?Pei1Mor7ljwr5l3/ViJDKBNVICXRn71S+PB4nvJywULLy1/xJgtDGslLFjGo?=
 =?us-ascii?Q?VTrDOINRMu8C9ef7e64b6Ql+oLQwNXifybZIc8xTbmmcuSZSbYs5HKY/mpbf?=
 =?us-ascii?Q?L1P/Cywe5iUWavUC2ho8ZUUjRNIc2xzSvpwLThlypVY82G/y/xyJXXVXq1e6?=
 =?us-ascii?Q?3XshVNievoFM1drAlXvatkmBGhvTztP09uQEbGTjA6NacnwkFN8qUKpQJqHr?=
 =?us-ascii?Q?GzB6SU2m/C/FrSqtZxIfAUuXPSQoiikKVizrq7jxEo3EdN2OhLe6Kqo2l5m7?=
 =?us-ascii?Q?fosOdnJv/gONcjIrhqRLSaQxj2ooWJwsBp6EvBwQQrf3oaOHTChoeasxBJzi?=
 =?us-ascii?Q?l4vGNPDIG6zpbTUmmtgFpMO4aqTP3GxeHssOuQLovTBxj7ANDKYEUHtgN60F?=
 =?us-ascii?Q?dSFVJLmcYDcmGWr285BUg4vU8M0f6f/yBs2EllzqCURXLsgK1VkodHHuKL69?=
 =?us-ascii?Q?MJmIluru5hLonUbRHgz4q7JmYP7JP24I34CJQbEIEYkGq6Ed6Vb9dwbn3RSN?=
 =?us-ascii?Q?N7SBIvnRsqAeiQw/sZ2L9DZX7Qcewh/DTGghqs40V6DdVSLyanQ5jof2mxY/?=
 =?us-ascii?Q?EZoDDvfmhuwKFDf6E2DV3BxEe+EGblNTzxXztRP0/Hd6a9Jkfp6t4F3A+CfL?=
 =?us-ascii?Q?rOAPmYCntpNv58PllgcUeo6ob575nGXWccOnmJ6Qph1zaJCgZAc80AVqOM4C?=
 =?us-ascii?Q?8IwstvlzRj4Tz+cqtcHtQPnkbIJI2F87bwDDi0tm0ANY9DSAz8dOcTrDGLmB?=
 =?us-ascii?Q?wCO6Efb0MadiM6VmCSO2+bjRL3YWSHfFeKW2y6kb4hf5ukPDgPFr9qpp3Sx0?=
 =?us-ascii?Q?N/ncwaNOBrEBmjlGlz1zCnLQW2wZvxl1vy9Fnb16P0/R5fhQ4tblS/VaLvv9?=
 =?us-ascii?Q?+Hj4eVv4WMEEODaKqLB60Ko6ctEzz3y1gDGY9S/1LTyOEcDAHCsEC+sTYPOE?=
 =?us-ascii?Q?pO3qFBWt15G2AxEHFrDTNQAURGDEr8kXvON4uoW4LROOMwHQTRI4NSrN2PEO?=
 =?us-ascii?Q?Ot6wh0ey9DOy/8QNo2fqqJ8BkKjbaeLs3G4x+GtXtfWoORsQNKTQPialGz7z?=
 =?us-ascii?Q?TnQXPVGEdKdXF+x6/CnEXoggeFIW8PZCy73BBdXFGh/K6R0WowTxFGRtjKI4?=
 =?us-ascii?Q?ve3Cy5q0U8TQAFP4/9dVkU0tV7mKDrfLfygo/4uA+oZvtQBPieQOmU+FLQB4?=
 =?us-ascii?Q?+z+qX6dO7kfAxt6FxE2xKGSofxKm4RrJlndZlJ4Uo1nwaa57cHSxqw05H6r2?=
 =?us-ascii?Q?zwBDggJ4+I3yt19KhOTot5t4Qeg8qaWd+Hjp2AI6bUIYZpDH9DLk4c0BhsJk?=
 =?us-ascii?Q?evWc2YTfZ9jn0a+vkleiFFMWQqppQYPKzNGNHRZhd5GL2PdnvXVWgrkv40/a?=
 =?us-ascii?Q?JMEq8CZUMzG/4DVLyNV/4XgaKkeH99vooe5z9icXHj5V5Q4cpISdYFWLGczC?=
 =?us-ascii?Q?W7ThYmW/ZgVO6yctV0t4ASWUNzoIH19CsRB8/6WwNwcVGCa7VbRuN46ox1XI?=
 =?us-ascii?Q?48fnFfZjZ+xhBaUCponCkBNgT8OGw2PoSXqizvhhwVNTnRCPp0nr68zJfJn5?=
 =?us-ascii?Q?z+vRdnRdmHUoJYZ3h3LV7F8Y9yEl8A0FG7DkrdNhE7TL5XcpdxTceBja+dnQ?=
 =?us-ascii?Q?lOrv+516jmcMZIDHj3GN+d7EwddQzKGrFcRGT80YyuipxkkjxcORDdOe8QdX?=
 =?us-ascii?Q?hz1BRTzD+A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63bb301-1afa-4688-c301-08df1dcdfe59
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 02:04:28.5857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMk5xaBx+oFNhMzY+5o9dIwkxCPsI2Y7eCmcRbHpdLO1ZUhNBUHXntVrQWjhgvEtvrHQc0lmFsE2K2KMTZU6Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025

pci_dev_wait() return -ENOTTY when the device fails to become ready. The
reset framekwork interprets this as an unsupported reset method and may
try another method.

Return -ETIMEOUT to report the timeout and stop reset-method fallback.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6461274bdbcf..d59a374a350d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1279,7 +1279,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 		if (delay > timeout) {
 			pci_err(dev, "not ready %dms after %s; giving up\n",
 				delay - 1, reset_type);
-			return -ENOTTY;
+			return -ETIMEDOUT;
 		}
 
 		if (delay > PCI_RESET_WAIT) {
-- 
2.43.0

