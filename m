Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6F3D3D05;
	Tue, 29 Sep 2026 02:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790647478; cv=fail; b=lbHEgQBXZLWRETZ87yDiBrdeVI9uba2PjWxzwUIDbXk/aT4esYNAoQ0UpG23QFOw7KGF8bpBBErPgWBZP4hiEXMgOsSz8a16U3vYZRsc624qJgdxsFwocG2c0K3imSIaFS90Ypysapgc8K7NcaJ1z/HDGNDH3El3PBotV8lhvqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790647478; c=relaxed/simple;
	bh=ne1W700p4OhBWPIhgGTyhAcybIfJSh5NdeTKHZKpNUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gULIZMHwBRa/uiGAambW7uz3CkoVSYwRYqwSszkp0V0nPMC95DZCf8ta/xJkQv1mod4/rmswMrb48ztodj8IaYKg7be5eC7sdVsr3YThZex7Z9pc+fr8Nfbhu0E95LmyFabJAmPzAVtN3wSECIq0iFwIXI4BaCIwqmax2amWP/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s0GG31TH; arc=fail smtp.client-ip=40.93.195.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s0GG31TH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+PCh63R5Hdv6bHXFa2bHVN14VDjdNq/T2GZ1SkJCAwFtYM8xkhxTBX56XebGe2OJW9Sx2jMduv1zZcTfbq3xCNHxRpYIoBNR3CywqlNlKQj0ZfkgHVsSHoOGUSGPrXasY8o1riMlyy2cJinF3byBf2C8KAlhJy0Ks76OCZeovbP1AxcLtL+1A3HZH6XcboiGR2KofxZYXY9i+j15jgwzK23JyxtFkD1kz3ZQ0RG6Yza5b6TDQ0TJLWvMG89ggjGkgevlOONndUMwWVhIpjQQO731ivDsqcsntlYdjpAFIIVGLWht1jSsYkVN89z5sUbuHJUyPr2Iqux8RvOrIyfpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFkqwvCAcXyU0LVBmpNqPDBxI1Wn5BhslVVXK4z1euc=;
 b=dMTuBGyKY3whYpun1eKUcJgXtcu+D76X2+1qdxWo+KWV0PlMDdMlz22YdTsr8wpvtV7qQvd8fcrXCZjCth7Y3B+SQz37XThPQnnxjoWwHGlR6u/ydt28YXl0jupqf9D76m6Aro5OEKlk2yM5Udaq0LcpebomAAMdarJ/aeZVh/G68Wc4jVplbqns347sTPBmxeGnJ4hsLqgqqxFfhua8j53DsQmNjX2zLTChYGxBBpbk+CB8pKBukyctznaYw2AwtRMtdLWoF4oK03lN/3UGp4ZKfVpoA9FePrwMeLGcQmTYV5VkTErcgAnSAueyyO0r6R9nt3GWn4MiMOrSjhnxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFkqwvCAcXyU0LVBmpNqPDBxI1Wn5BhslVVXK4z1euc=;
 b=s0GG31THrzIpk6ZYi6uAiVKTqxuYCypeYSyUT1uVKYhNbrW+Lg6RBTsYZW9+RUyDL563nZeHz4UiypyDi4pT7QKnxtjFsbPzICn/tpW31mlAhe5h3gfhdREw3R9U+GnZl5vohVFo0Naw8NiAqFMQvKrY96dcm8sQmxNPVfd+1YZlS9HqrAaUptvdp/gtrlu5jUUm/rn8wjLn05ECIu9ei9iJ+1hBLshp7YMC0avJ5uPgSdv06uyGZZs9zhaAlp5u8GeWaDTzQP8ivNXOWBi/wvXBq7GGTFUxdFpvI/wTnTuNugmQRuYoHG0V6q1tWfSF5nAvgllEUBUgkgM8pMl/iA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 02:04:34 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 02:04:34 +0000
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
Subject: [PATCH 3/4] PCI: Skip state restoration when configuration is inaccessible
Date: Tue, 29 Sep 2026 10:04:04 +0800
Message-ID: <20260929020405.9724-4-icheng@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ddac266a-e0c7-431f-caaf-08df1dce018c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fwCpDhADpFT8V0FdoVPwjK1p7JE7Q0vGo4jtpK/UUoKGa2MlBKdDqBxDrIJbumvbuGKeg3cjYQTBMbL/HHzvM04ilzqag16yng7GJLh35ftNfh4Vhts/hCuU0cXVCFufiXYUwDlQvqIKEMEf2FTtJxikjHXQOD574Jr0nFHEtd5+szB9cA57vTPRKs+VfkMADNhdKu8xrXpKTJlsg2STnX1bzvE5dvpxwXbbgtF6US8DTBVb7KXe86Gn/R6MKbLkbultlYJEDO26NDqeyX54d+OTYMgUGvAo9NjJSfNhTZk2LVZwaTFMicET/v5KAuOuF/hDMQziDIuF2JDnRPCJV9SHdgUS11fJ46zJqh5c/37fItFiUSkvbFkdBnZ3eO7mChu8MyENc4qJqC5FYJW9WAYzC8dza18jQafPz2LrYpkWA36YOojApphT0Ej7wXS3/PpXZNqJfwV8Cxlpm6HJfjqCLTshjFZD1W36k6INLW3ZWTWs/YZCdnC8YzbHW+FPBngfvlb5lbXTA1BWltGWaygJKHvxDFr39+ndlpZNbOMuUISm2mnFZpTXjBYjsSd6E673mXMs8V8zeikmEXOETKuk1KcafFcuvtfmZAy4/zL5kp4VZML8Q53ZJ07d4z1a5g8Uyii2fu1PsIDCE1Ku3XTu/WeQgfRY+x5zWgragbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3LR8//k0qNrg+xJgh09oHyarKKHGzX9Ll6rblLTTZFb2F+JaV8UAUZpl09mc?=
 =?us-ascii?Q?Axq/EoPOqxLx5wKM75HZ9uLQuS1aE9gg3No9FnpkVXO4p65IEpskua0wmYzV?=
 =?us-ascii?Q?gORQC/1k6ea3/SHqm6rda9p+blZ3nJf/Eb3cK+0xsZpwOhrDMzz7nXlsBEkO?=
 =?us-ascii?Q?WbUxRFYrHHji5OASfinhMcEuAtdrZzG6Syms1616ZClnSydn1WaOnh5zYTxC?=
 =?us-ascii?Q?kVNJ75Q7TkUpvvO3NooHkOpwAP1jtV973214VH7/xoctSApbvm3kkzHCGnnT?=
 =?us-ascii?Q?c6/huosCIs1GuRQZhRdok46Nu6TfQRQAvKiamHgS2mN/FuDEYiyPMePKgaBH?=
 =?us-ascii?Q?f0udgN2k5fuwKgcxPNBlkKXCtOMVd3wMoRNOABeIqgmTrSKrtGilETjod+mT?=
 =?us-ascii?Q?0CElkcNf+darhQdO0NCBgmQGtt3tnp2mITGsT0aF/lZuGLQkxS0boeI/kUeF?=
 =?us-ascii?Q?o3YNqxMR5nX7jkWd9Yn/rstIjN1GF8SAlcsJoXDTM4remv0Rb5Vn2kGmecoV?=
 =?us-ascii?Q?tateEXWfvlsaxmr/iU6TmSBM2r+c4lIrOTZVuTFewfhyYzgDPeWsgCFG7NxT?=
 =?us-ascii?Q?wW/isZ4LElgOZ/fWY8+REtNKbgXTuVAn4ZgOpxbn6twwhrIjpwEKyfKB3Mwg?=
 =?us-ascii?Q?ff5oEEes42dqjZ8Vxv0CC9w05Per4iOUhASlF/WNaiL3AcQESWhqRnGLbg+h?=
 =?us-ascii?Q?xDR6pIQzbNfxKgrxAZLt01R5JHq0le/iB2Cq+Vvg/m+ccXpSBN7MXoIWy205?=
 =?us-ascii?Q?SWFKDyWMORC9WOSMb6JGVD4SKCfI7AZMAtTtuIQYY+R4yi35WUMQ2gmjYC7F?=
 =?us-ascii?Q?Y434rFz/7h1O0RVw3sz/zvl8akBOzMoYv8VBGthssDtDOu8WULgtqUZ0OQ68?=
 =?us-ascii?Q?bprHtWJxIXK7zWDhcBmmHWs9VWhybDkpdv20F0VwrCLIqlLuljJxp0fWItFp?=
 =?us-ascii?Q?tUdTeLV0m5MWyq/vdlXv8T0v9LJzyfXs7F3rNoh6njZ4m01hVKns/a5zyasj?=
 =?us-ascii?Q?npSOIkcJ+SELSeSdrsh10+KRYk2k9Nkbyea1nXKiyM1tnj0Y9SfimQRaLGTG?=
 =?us-ascii?Q?x344w5xHqyEdJPwsk3KCZKeEW23aPdCka41wXeXk+HKfJ1QKKklCrveDArl7?=
 =?us-ascii?Q?e1nnzs7iBuglAKWrXnx8jeO0x/CNx4IZp7KTWc/AxTrekPrcFSPHXrf9OlBn?=
 =?us-ascii?Q?ZlVMLrDeBo33huVAOm56ye/NnkozBDVUbXdmM5vYI6nY0D+5Zg37+ZMv5oHq?=
 =?us-ascii?Q?OeRWDsr0/7+YNAnKyPSVLz//ZRvQY4HK1sEwGVA3Y05u+1t9b4ujlDVYyjVn?=
 =?us-ascii?Q?ptBFueAYmzdqNo+vul6/gh/Q/baUopA/oiIQxb8KTa/Lvk0N+Pj+7XaWnKuF?=
 =?us-ascii?Q?weQ+Qrt+AlRzihZcV8QQ1yTUGHOnpDuUpvhE/y8YYctzZR76dr8/OChFXw15?=
 =?us-ascii?Q?TDV/fgCuS0znZL9NkOzBUNYQ5qEDfc1Er7sUCAvgXEuR46oONODuoUVWF3fJ?=
 =?us-ascii?Q?XDl8sjoIZp5oieZU1La01aE2oXv3NOD6sofOMAkb85Wk0I5l3M4Il+TdSZur?=
 =?us-ascii?Q?7ZM6W4X/hvYnAhtQDdAa9JLMtRC8NsrOn4DXJqWBCohY0LDCp9hgZgecasI6?=
 =?us-ascii?Q?HXDbXDTApkw64zZTCfL6MbP0W0a1TEHekLJjl4o8bLPBsG9f2R3UAnjprqBg?=
 =?us-ascii?Q?vdh93xgEOPLm7n/g/RFLksodhz3ALINejF7GNDpUZtSMiRtb2dOOYkqgq7zs?=
 =?us-ascii?Q?LPMclndQ6A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddac266a-e0c7-431f-caaf-08df1dce018c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 02:04:34.1076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrWiRaW6SnXsnNEcuuk7zo0wTkpXLPG3evlV7ODS8o8g3I6iPEyDsZnRt/BdUnkUmiPBuuHNjsIpq1WNrcDwng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025

pci_dev_restore() restores state even when the device is inaccessible.
MSI-X restoration can then issue MMIO accesses that trigger DPC.

Check configuration accessibility before restoring state. Keep driver
reset callbacks and reset return values unchanged.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/pci/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d59a374a350d..9a343f8b5429 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5127,7 +5127,9 @@ static void pci_dev_restore(struct pci_dev *dev)
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
 
-	pci_restore_state(dev);
+	/* MSI-X restoration may access device MMIO. */
+	if (pci_dev_config_accessible(dev, "restore state"))
+		pci_restore_state(dev);
 
 	/*
 	 * dev->driver->err_handler->reset_done() is protected against
-- 
2.43.0

