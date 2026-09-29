Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348183CCA12;
	Tue, 29 Sep 2026 02:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790647484; cv=fail; b=V/oj3yXyatthHXWkznQNL4EwPAjGhI0e6rXozv3CwNsECu0XlQKHs3xf0KAOfOyh/70IqdG4sxKSBYl5GJzQm6FaTeRJaS+upYPRg+yOPTr9gr655QSJVgVBhOY4/MsFODuhu3dY/1DlitBainiR2p6OWJ2T5CHAe6HKW42wa5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790647484; c=relaxed/simple;
	bh=3Pe6Kot2+5e1GEGIDIIbWv6rs4c9Fv9BoMcV7AA03e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sdTeEFx/Fnt1D1pcRbVHQjPf+jXj5i98YlhusY0uGLrCyak1Qn9uL+LlqKD16AWLcG/+CmeOK1vGsl3Zanl7GmQqdVr2Q27J050pfltzptQ5Xxok6ASr3tj3NXSOw3oD4MlWkpSbLuYpVYSJdfmVdI/YSnWgrxHgDnIKF5EQWFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H5kei25o; arc=fail smtp.client-ip=52.101.48.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H5kei25o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1ND8/9HBngI+lX4FoUwDny/rh1BXJwWlvEKrhsG/aM34Yrza9xl4C3xbO6TC3TBMcrT9hY2HDzAI1PhUHsA4ZeOgE8DgstugHNfeTEdA68MmG7UvosiQ0scVauS3PnsAY/oablnOvPDQX/CABoIm40YXwEmTAANLqUEVrPOX1hEcs8LBDRIitxzCoo4d3EXUJbOfNHCye+aiuRa6QK/pxvI/jGA7WLr0YX3JRA63q9x6IPASaTEY3fGvow2YV+MeDcwjfAaW/6I0r5M5MSmRDOxMz5PhAVCP5XDgzOglSreifMlOEH5PKWrqGRFKn5CZy52UEo7illPZ6Dd9mFP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIgbakwtFsHCFeUDaUh843Fx6sSxbapHz/mGO3E7d9k=;
 b=tcen130IBtVHRj9+hs6dn5wzeZj4rZEXb33MLTQhqp0GIOaaGxFUHEoN80da3N+Ae83UnJBmLbNtaS786eujoEDo1ZjJGfzoZNlRJaWwIVTHcDJaEa1VQN5XnwWrRLwcNCbdw2nBteSlWmSrZSXRBKpSpJsEW9G9JF6uxOgu1Z/jFHiUG7gp4lfnyntw/DAmFnbcxVzZrUFBC6TNy6Lc0rso0gDlMYR9P3WRV7SnwWB3RgOY8jW7wp2Ak87maloSMVYJk5m9qpoyJ1AcAB0cyU9Hee7G0arrXBlD1g+uwfookt8EQfoxCTGvriCiI+0of8f2S1Pg141QRU/Y9HviAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIgbakwtFsHCFeUDaUh843Fx6sSxbapHz/mGO3E7d9k=;
 b=H5kei25oWebrCWrY4AwF602uPolUQLcorPoiwal24Jlx4gBnOwvjZ7mf1ibRyd+Mp6N+oKo6xmpzTmhD6RNkXWv1jlhMnoJfNy/Nj2mMaJkGLB/tnhxHvZqjbjb34CfiGh2piwI/fotujLiWwIhqHk/YflDO5yzSVaYA+pO+ZcQE9DRob4eM7l3uOfavVzLn9VdwFCS82F1RfRbvNWDUsaHsyFCLp+MeyL6H/Rfh8auD1HLGeqpQ+DWkz+GkEpd0r0abfvsik4aQcmLyQM5ID00RKPDHqwvBUQw/PJ5u3Qyy3RpENHWW7Y9ob60a28Hsv77ayzRew4QSU9b2PFLUBQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 02:04:40 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 02:04:39 +0000
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
Subject: [PATCH 4/4] cxl/pci: Guard decoder accesses after reset
Date: Tue, 29 Sep 2026 10:04:05 +0800
Message-ID: <20260929020405.9724-5-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260929020405.9724-1-icheng@nvidia.com>
References: <20260929020405.9724-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0007.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::7)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d699ed-0756-4e0b-f964-08df1dce04fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JkvfCeUtwyEOiStiCXdG0ougOzlIjd23vOySomfAwxwC9oKyhXRsxff2h7gp0DBSF/Lx+KWu7TJ5sNgNltYuaD3/BV4Of70gxJqKQ9KvnFXz/FwzQ9mgiW7IJQCPH4zXAxOOXWdV9ZgRi0fIW8rl+mrlKz+HBn54VlFq2wemiHhAlSuuEokbEmKVUr004Cc2TT42TG7W02bjqgW0sgKzgv8eJ0Yl0z8KKveFRWBWlxvN3jMvrKEReLogb3CdWWMJSVPua6fDpjeDea0yc0cyl/Ev5zZXDjVxdn7+LOR+94538EygaUAcxct7abb6h/3ooQbOCLxQjH1uLWJhc2xntZYNeqm0uEEUeVDIljSUJSa2TpRi1r5tqHgdAhLQqdk6CyIRY0n4KRRfDq4CXBdCZcaxAfhDWg4aQ4raBRhw239gfd8hNqN2iByPt1GkV5C4vxGzPajYckBkfv7SKBJsAniAQ9WMAPqgELX/e1rcpVep+AibP14kWfzNSBQImE1sCNLw/kxlyGuh4abZmyrkdKQoq+5VENBdh5TAJtSWiZj+dKFNLzFgEo1NzO1dh0U4EQ1ByMyWoFPFid3n8AjHiZLRynrt0dWIlpn6EKQLJew7Ero5qJNrxGuEqNo07fohmldJ+ZvJNHBGteNay1SIsdnmIgmxg3f6UiQmqFpn6+w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L8SowXDOrGil01/XmHaxPIiY/gZQw/1esQVTqsZ4fnJEwEr7ht1vdIznewH3?=
 =?us-ascii?Q?HLxUecWMkiF8PAceF9AvMqbGHqErB8i3Bf2cJd0tIgkKhU9QgtOuxVmUjAoP?=
 =?us-ascii?Q?UhrK+znSqOlxndawB67+kP/dR//4WwVAKrEEokXmKHDrvmS3fSriZ0uGx8TI?=
 =?us-ascii?Q?0SlVjH1WUR5/4ROYxWezntV1IG71g/1ovE8qFF88DcxfrND0XRt1NQ9ryDzA?=
 =?us-ascii?Q?0TYT3oc5XlE/VpsXCA9I/z3WW2CeFUdBqyNl4lBEk8oe8hECZ2SNvq0VONbq?=
 =?us-ascii?Q?9ZDOiLO84VhaqC4UcRnvHBIlHnPQIFQ/YgFiV0sjMeOjPpyEp045w3AemeXB?=
 =?us-ascii?Q?5xV/8h0c+njAic6eQ0gqRUCSopzw8hP/nNv/07Dq6xneXfkfpfdVjBplhlg7?=
 =?us-ascii?Q?JehBcScHe8TlM7HVJFRpFtZpStBZnMAdpzaVAJjXlGZkRpNsfIDRonl2sGfc?=
 =?us-ascii?Q?hAPHnM67We72hl/Ev1B29DDPi4Evng04+wSKOzZNuWX13jLY/K/7ZAd9d69L?=
 =?us-ascii?Q?alCx7haM5+gpIRTYyJ2tO52UEMxfkNmiWJxHPVGcBpUCUcpe2VQYMsPbNlI/?=
 =?us-ascii?Q?BJSJB0fiw5BjLtq+JPpXoAtTYAJ9fydMZ5E1dxsFJKfHGcWUESdpCVRNxcNH?=
 =?us-ascii?Q?UaIdgKJIZ/E4OMrfwHH2STwY3FtIxInEtAxuC+YZ/viKZWntQ9Sij4gLO4S3?=
 =?us-ascii?Q?Pmky7DfgddcB1+ZViBuJsolexM57J6zAIUa3SWPMjAJS+LgrZqW251iIdjGo?=
 =?us-ascii?Q?rljY2Yz4xUUoPwxQSCvP3I4qIw2rFfbh0MPKydQ6ERvdq0BAjVRw1f3HX3/+?=
 =?us-ascii?Q?gzqIeeWpso1damF6mOo3X5TgYEkjVJrWI3aPmPLsRl/7RqiAlysl/uT2T+IT?=
 =?us-ascii?Q?KJQOvvM6CwN19c4sTOBqzAPbWmcgqAZgSG8viHuq7ENFOLuuVtt2MPUF+lo5?=
 =?us-ascii?Q?dFhA1jpbTlNXwf27rKvSShGxrfZ2pFW12Ijj2Dm9Or490niCWWfhNYHnCaMf?=
 =?us-ascii?Q?FAN3XEfDzKXdyDiVeUMU/kcz98Hy1T93gz8t9P96OJ7WTA2TmuZovbtJJ6ft?=
 =?us-ascii?Q?QNg9oUKqShFCqGTMHJ8e+1BYCS1A4Gz6/LmD1E8jDzirzAD1YfGdzkSQhbbs?=
 =?us-ascii?Q?EtyZtyIvQBQGy+NIUXB+mIOiMw9S7SV1TJjAiatHwId6iIPm88CTAaYrezDF?=
 =?us-ascii?Q?U4cKISXXSjVLyWvst+S4AKRfpmIyj4xxEfQfKnnNNCZVgy0qmer/S0UHNKVF?=
 =?us-ascii?Q?EQTl81RHmtLuOyP9x2nRVg1XGxI4xEo4y/H6g7gHXZ3c28q2vljyvBhynxzX?=
 =?us-ascii?Q?Q+FPj70rOnf5OEhDx84ryn2DG5XdpISE0x+3kTUnhJ/Ecjiiz54/qao8dKZ6?=
 =?us-ascii?Q?8rZCuWNJSPc38msk3SML+INyM4Zy00kHrCsLJa58QQSySja7QWbbpCgPr15Z?=
 =?us-ascii?Q?HmIYINu8o6XsMw36pkdcpxy0Ldg5WmL5ghVsqxe3rJdN8Lj3dviyh8pL/7Q0?=
 =?us-ascii?Q?/sdMackjSJEAMHw67EbxU0GMTkbonHtkFmoclEHgOJE+zy4EaRNxnG5NjXNt?=
 =?us-ascii?Q?qzRYZjLd1LaeFKTjNo+xpirKR69hsdYrrNpwvXVZZmT+PrzUj7L/r840SAXv?=
 =?us-ascii?Q?NeNaANWp66tSyzf5ZLFyA4sUe6ah/VCtvPnfeXP3+LG1jqBkqO7ykivWtaTr?=
 =?us-ascii?Q?aGedT73o8g3l59rwU6/zQI9UDmP0UXZNYvkfuwX2KNedCWx/u6W6Anqs4OQW?=
 =?us-ascii?Q?Kz4RL5Qq1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d699ed-0756-4e0b-f964-08df1dce04fc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 02:04:39.9261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKPev+b9zlreognQjaAR5laVwjrajIdiGxUxy80TmF6yfN2mZNiuyc3tSNoDZpn5HMHVYYXKd4DL4vocCgFQhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025

cxl_reset_done() runs even when PCI state restoration is skipped.
Reading HDM decoder registers while the device is inaccessible can
trigger another error.

Skip decoder checks if the PCI Command read fails, returns all ones, or
Memory Space Enable is clear.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index c7c91e8dc51d..2294f7761e50 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -976,6 +976,12 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 	struct cxl_memdev *cxlmd = cxlds->cxlmd;
 	struct device *dev = &pdev->dev;
+	u32 command;
+
+	/* PCI state restoration may have been skipped after a failed reset. */
+	if (pci_read_config_dword(pdev, PCI_COMMAND, &command) ||
+	    PCI_POSSIBLE_ERROR(command) || !(command & PCI_COMMAND_MEMORY))
+		return;
 
 	/*
 	 * FLR does not expect to touch the HDM decoders and related
-- 
2.43.0

