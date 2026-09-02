Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A8388E64;
	Wed,  2 Sep 2026 05:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327574; cv=fail; b=YFdhUN3xT6oeRkp41hUEvZ/HYV/AgYgzBsG+bA4doDgxFB4xNSCVw0wdFELEMi/4duENAW2iWB1AFvHoiuzQ/Eu0puG3IY7ERJ2yFsdTcP/OID65VEwnr0r1xD9WPF4KtXknFgt2HnVRIhVzxD2KeeDtrTeG8nlkZLVmZn+4PCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327574; c=relaxed/simple;
	bh=gVHhm+K9bqr0BfKSZielCZ6EYtR5pN5HgRYY1utyWCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JcdU1K/sjjlrjBOLUJibpYpyMap96uLXAOCf9dnIQ/Koubjxy/HoaIIpPzeB84JiWlXAt86qtcyaT9OwmOetLSn5OplEkhoHmeaRsjw/p0G++d8aQtnp60Ld1dvINHNkzEpjufqfwEbUCgVk1hGfNg1CKfhYV6TCwHBrxrDHYao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b08K4CSZ; arc=fail smtp.client-ip=52.101.56.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b08K4CSZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCte8PWlvskC5qoeRH8IH6933rliFUk7v/Mhw+YJMVwtzjsZBq0HP59quOy6+xtz+WGX3O5vGW7woYElAQp8eo3SnZLc1JbelwCEn1h5wdXBZ5ABi/Z4ck/1zU92p5ZTGLrPkO4zCA2AHNcndQ9p8zfmLsZy8vy27I6va3m1shRLqKZpyAQ5aCuGMDTXZkoAhZqC0I9qzyzVwvxtdcFA/o8pAVSdA2Y9UescrnMNnptcTqULBRFuB1DhDE3IbmdxwrFvwd8tRCvavlzzyApvmTk6uosQCWakDJDIo+tkZvsA93VdwdBif8JQnRMwKyus45OJgABRwyjg+sPB1WXdHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbyqPxrkXCIq55a+ykr/enupMWGNut1KsIfSmLHBcDI=;
 b=WyaQxbZ8zthY5yoF1cawtsfXYfp8ZReGQXNOSB8hl9o2dcJ7Vb6VeVULWNPqhhih8hdeBWMy8YXRsniwdi0KgMfMPRRzST9x02muK15Qkp8BaYpd/Vxs1jzXdEVpqj1GDnQwjHNzaUTvd8xnfFbqxVej64H7tErABmlKaeOv7hEkQrH/wcdKYo555dkCTYjdtQs7GK16ygyOovcuhcM3ELMRciuVKebSuK2MHFI6ML9tNAuEGGZAH5v+lDmFFLXozkOjA0KXZw3TlyKRNhetbCq4jSj19jgpBUNHmECHhvL+BNVcI4q6S9eJewv+Bd39bkHQh87QPj3yOeEFNAz2Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbyqPxrkXCIq55a+ykr/enupMWGNut1KsIfSmLHBcDI=;
 b=b08K4CSZePMxC+bbNFqbTTcnVrexj6Oh4OxTNv17O0kex36VUBZcu5mZYTev3EOS/MbstmK8PxcCl9qC68FSQU6H1cKYbFyAiXk6h2Zcht3zDVS8JnZaerKzhtcYwbS2wVM4PcRs9/VWDwXo5vsRQSgO5H1DLsfHEzPzAvC7ZF/q4bl/wU6XV2sUL1/C8N6jmxpO1KrwYqTt9kBE59WLHjUrVU1yZfedvTDeGC82K1D52avFh2TeZi76z0i7UkLN1ZLgox06e3p/rLMG8hGK25YiC8fsV2CW3sNpwvqDbORqLbdtpIOzE2Pn7+mun2bBE5DxJfUJIhEjSH7hT35jtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 05:39:28 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:39:27 +0000
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
Subject: [PATCH v7 5/7] cxl/memdev: Don't overwrite the error from an earlier partition poison query
Date: Wed,  2 Sep 2026 13:38:37 +0800
Message-ID: <20260902053839.25595-6-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260902053839.25595-1-icheng@nvidia.com>
References: <20260902053839.25595-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ecf3e4-5806-49f6-9efd-08df08b48d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	T2mH04CoHBanjZDi5/OQXaymK34uyIpOPm6VsHxtSv+YusqINLWUYAJijQXD9iCXfiTTD3ppgC1kgpWuIq9ow5rXm7VJ74pO3BREdKnBTJUYMOnr9wS2mTdIpJdQcerzfZnaSP6EcXGZur8u9ZD5+IpPkO0ODckW0QtSn0YC7jKnlpgiotd3Vs0ugZJpZNGCM4jt9h0I0c0B0WVouRfUciM6/Chx3jmm7VciBAPaeJqWnlLGgMB5d5Rx5a9q8esifjkzbe2EbYcvYjMKzZ+9rrBHTSQ3LJSMhZwZWl0FVxr/Ihv/YS9iTl5IJ09/D+i03YR0mIIdRNQqlaBklxvKzmzgIrriukUfgDK1ZHYHMIa57wxf/deWAv9jpcCOmNIw84AicnDsKwarvmeg+195WsnsZn98ldnNjeYHPX8lV9xTEAfdtTMh2YUSAeTGxSuGeX6P+MKWU3gzWWnDr9Odu5ciE2lq9fnHl8Jkc2JnV+wromXWlw4d0LIyBB2sn6ooZM+FaJvNBnRY/AxnU0ngq4DDvMmJp3VKvxtku0LGyIhHeY1q+gwhBfgCKRhZqoXMYwEh3dK1B/nIcsF6+9eTkpy9Q6WCQiJjGWVPcgdIUsjoczdbNw1I5Ul03X5O955EZZcPBe/3f+yr31IDZ9sxgtxq25ZS2Qih35ZCp3g0cac=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FDJLj9K0LqX/RPF72fI7H7dCHPiYn3WFMtHlbN+Ric1kWzc/B1AFMTFZaPvc?=
 =?us-ascii?Q?ZVCLa5J6AxBb4wJ/uElcV17EW4EaGoloqv8XARdbpfv/lD/efG6wY95RpZJz?=
 =?us-ascii?Q?bfEc4ATodOFr6QqLcWYxdyDo/c483iSSlz3cs8o2oK5WbvZ7jvuidbVCp2GO?=
 =?us-ascii?Q?zuzmECMbO5YvhGL5xORt7f2z4UNjzLBBvWyiOM8AW9sR1xRWsdeAtdBba3Ra?=
 =?us-ascii?Q?UmLG5IhCab7cfEl7uCLpBUWGPaj6nEWfeyUXyrFL01lbMLu7B1wX9F8SSBEq?=
 =?us-ascii?Q?9aaKKJVzoK0diEXABUlauL6fR3SMgR6c226SV4SgIBzKJwM54KIoZpatNJna?=
 =?us-ascii?Q?K5Hn6+MfEpAQXQ32AOEfCPEd+ktRTyeN2pl7jwMpPICleGB/x3CGdKk8MFZ6?=
 =?us-ascii?Q?+9hK6zxlDSGkItuJdtmVr+GZzeyxxm1GX9UIxRV+W7iKwaYjGBw5ExN/n0YV?=
 =?us-ascii?Q?8gJRPGz1I5YxZ17KXnEgWk5ALzTD2h4WKz9i+oncn5pmmBYdq+NOO/a3nmGV?=
 =?us-ascii?Q?2Y8xLb0mnboIeV47S+vTPh9289I7Em3O2IDJC/6hwZBjFd5MF7y6kthD67t5?=
 =?us-ascii?Q?m/WZk1puG1Yg3JNpSUnupKkVb//xItGlj90/qj7u0nsfJV2uIKFz36nww4vS?=
 =?us-ascii?Q?OakP1KGY+2Tdqwqg9dMEZ59t5vCnHlDnBOkqi1maymgatgJxOYjae4HmGgct?=
 =?us-ascii?Q?9cfu3+RdrF7RkqO2Io6qdjPfW0Jtx0SEc2NoJTo8zSnDnz8jvhsJsPaP+zmK?=
 =?us-ascii?Q?ob+1333DKh8dq1OfCEpHsFQdnlx3GLLBswgo8+JIXrQJGAOfVTDqwm/gPBvj?=
 =?us-ascii?Q?eJp7QlcIjlwactvRZVPlbK3wsTHnc3GmRDccuLbz+rKVXFjO/NUvhKBz2vXm?=
 =?us-ascii?Q?yye6g7J0IEBGDhgH7vbnGuPh8iDaCk8Qt2YwVEuENSDjBQ3Q6qAfa+tFQ0K9?=
 =?us-ascii?Q?2lQRQcm/RNP0ET6mCBmVyO8bWpq31gojJR1ThdjmbBL+9RdIpRBPCCUOVF2C?=
 =?us-ascii?Q?7qsbV++uyZU/HtyKIxExnv9f+i4b4sZ72LwiA/OADlTtMt59HGwS0w1YLX7v?=
 =?us-ascii?Q?Aqk6d2ODO5VHCTQTTFO3k8ByMT5frKm1KSrH3AeUM5edD2j7QkeJwW6SmaWl?=
 =?us-ascii?Q?xDDZ4qwg6LBCyFnspac6ridTygjcy7rlJUNG3epruc/o8fZCAQ731vjIho5T?=
 =?us-ascii?Q?0D3jIPniyj3q6lCONluP4xgGoObkaB0AgZTsLRIG1i1lvT8bP7W4BG0D7T2c?=
 =?us-ascii?Q?YjJvIDkmdtYlg77t7eGLrIBCgashH0gTI+Ty4Bj9gxC9MHFsYM+TjTkVrnqD?=
 =?us-ascii?Q?fy+LleZWaloPBffikN0WtVCrsAStBlUeRhMOtgUaM93wDRhO8ocDiFWvyxJn?=
 =?us-ascii?Q?5VPChvXzm6HhdfI7YIgP0MT67b40IPhH3oHxNFxgMeqW9LWkRopg7enDGemO?=
 =?us-ascii?Q?yZ+DVa77+gJzpr/coXoYpm+rVynh4IwkW9LZYFpDTmSwnp1ZzWJxgKG95Uyw?=
 =?us-ascii?Q?1nxWbzCYVUkuTHkiMeCSx28eADg+nNdEiwTaXtWxn5bPy9palbG5dWhO9JCu?=
 =?us-ascii?Q?wCgE47GeX6et3Z97v+IKmhF/5ACa0lneXdM/pejeYaSNTAIC9gxBnVFvYZ4a?=
 =?us-ascii?Q?lB2oGY67UwDpXIMJ60+oW3wlEFYJqbE1QxH9AO08Nx4tfg+s0xnB105n2QX0?=
 =?us-ascii?Q?PMJkNxJDk8lAT2LWGlM7xPqVRZEO9jIxcSru7Hs8bBmXiCaN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ecf3e4-5806-49f6-9efd-08df08b48d21
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:39:26.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /x0YTbxa6zSujfB3ooR5PD/YBtu8/UIelD69oE1Bdxrq5EQBK5DaSY9FmeXcd/czcAT/WesD7xf/sh76/ZVxYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

cxl_get_poison_by_memdev() queries Get Poison List per partition but
never checks the result inside the loop, so a later partition's success
overwrites an earlier partition's failure and the whole scan reports
success while that partition's poison went unlisted. Before the loop
conversion the PMEM query returned early on error. Stop the loop on any
error not already tolerated as a RAM -EFAULT.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Closes: https://sashiko.dev/#/patchset/20260708074228.43654-1-icheng@nvidia.com?part=5
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/memdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b3419df586b9..e39b3d13fd56 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 		 */
 		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
 			rc = 0;
+		if (rc)
+			break;
 	}
 	return rc;
 }
-- 
2.53.0

