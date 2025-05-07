Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40963220F5F;
	Wed,  7 May 2025 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602614; cv=fail; b=fzDQL76hVAxoykRC72XxGuCgP96Jkfk2a+s4wUVyMEl7ajRCCQaOCB9ptr6N5TzXx41UtX/hk6yp9yACsUtb3+nseEBlVE2XJcXJD88H+gpJbA2pb1xfn5/80TBvH7KWhNqC1ppEktlA0mtHwmOIl9OD8wKES4p8RTRjkZPRSLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602614; c=relaxed/simple;
	bh=2wXXUHsGQ6RgiF5wfVmJ76emVVN8Oiw5VEJbc+4ohRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nZeR/PRhKLdaQviPJi1/3ZOexaBImIvddXmynAOAFT5g6AmZblkmBFCWdOt0j3HqBRMLWx76A0uWidvlDzYeU/HoatAQTkLCdQ0ShqbZZZfyNNv+CdzJia3dkVxwKEPt+AOuey385AagXTXXtDAfjjns+pDjBqp63OKw/xZLGyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9mehkfC; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9mehkfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746602613; x=1778138613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=2wXXUHsGQ6RgiF5wfVmJ76emVVN8Oiw5VEJbc+4ohRM=;
  b=L9mehkfCed+gMlO6Yulm75hO02LVQiv4RJUFyLv/i0bkFDhnWU5+IKcn
   UPDUR04MVChHkHU58Ri0+JVxIM3UxaCn/Gqo+73QRzLqaeBwESIFayrM+
   qsIz6qLbTKVc067OFfrGfdnNLUyf175CFCCTtRI54f0McWqMJHEQ4aizM
   3T/9bY/TNTPFHy/Tybf0Ozl+fXTr5/yB2UM7dslssoDisRxvcJ6+0Ulm1
   EfjtR6VO/wivuNs25ypDyRQdZfCdzbW9dBHmn57WaBM9hC7HnRC976BLy
   kxM+7hxZnRhw5RDzpg8GBoXFlByHFv/ID7K1l5LH9KQxzd907DKPeM+T+
   Q==;
X-CSE-ConnectionGUID: DQ8ZEwwER6WuhcW/181dcg==
X-CSE-MsgGUID: N+Nm82pFRJ+4Z0BNDbTreA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="58510845"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="58510845"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:23:28 -0700
X-CSE-ConnectionGUID: Q7RrXBRyRPW3t5XZ6F7OEA==
X-CSE-MsgGUID: Ob2ZEsvVRpGvjdPtxTmkHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="140603582"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:23:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 00:23:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 00:23:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 00:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkgart5mB5UxL6EQGrUvRSWXnU7HtMorwQ1KQLvlDddH9pHso65HIE7CJmLTtd1QPgef2cmbWlFOJ7BgNmzjAhLixlppFYPE4EymglQhHyCtDKkf5rFaDgJ67iYUMXz5Rog3i2DArngZf7fw1B1vdoPCswmqr6XWJLTskBui7asZlgjN6nwM0EkB7KW9ukfiUX9QqodZqBYEV5e/trM0cQrFOOcQjgRAmSkwFE9Cjf1qnqGPFFYyknV5tT3g3uQT4rk5iywqcYC0Xm36/8vR0M3IycoQpWDHl7wsLQvqndHdhBcZL5AfQZbkD81fUcBrplvJCPTl0MY0//3V6v5Ceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVsRmVuMscAXuUwAnbvzxrgxNiChXh66kjGa3pMK+fw=;
 b=sZAzcjTWFParrkRUVGZXNpngbU442iZfAEeskqU441qwZ5ba7Wol5UeL4R25gbirGoJ+8coxRc6z5x5xi+sDPOFX43XJKJbYm4cov0LwL34YgAVK7a9a7R4pLzQRLU9u7nhZdjrYBAqJUl3IJWASfT/fxzhbBf3/bDuTtn/PHSEmz9VKXtKcLMJ2iAYRQkyCQMqKjTYCY17vgpDG1VGwJkaS3n0gw2HshqXU2jAoFjDWEGhhu7hsyo+QrXoiaX4qVyF4vIuWipmXEy9Czol9VIfVFOF1+6lp8BnNLSX6JOcwNIDcHoVSICvaxQ6sb+/jw5n9wFSO6gzo7PtMfKDAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB8270.namprd11.prod.outlook.com (2603:10b6:a03:479::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 7 May
 2025 07:21:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 07:21:51 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 3/7] cxl/decoder: Drop pointless locking
Date: Wed, 7 May 2025 00:21:41 -0700
Message-ID: <20250507072145.3614298-4-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507072145.3614298-1-dan.j.williams@intel.com>
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0313.namprd04.prod.outlook.com
 (2603:10b6:303:82::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: aee9baf3-2b62-4f18-dcf3-08dd8d37d658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?APWH3IxmkY046xu1fM7HHtIbLLuEdba09UxuX0Ltk6UrwpZGazjp16XpaaJN?=
 =?us-ascii?Q?9zF09INyuv3Va8Osv97qeTH21bMx4XxKxuYpYbCd0LFQU0B9NhkM/e6pts4E?=
 =?us-ascii?Q?NSzIt4K1DCC+R3JaMRe69HWP4LJ7cC/Hyo1Es7k/hvZXI2SzN9eucbEVJ/oS?=
 =?us-ascii?Q?O9WrWBeg8igW49uWspsIfi2Yj0mB+2NOQ1CKHj6tndCdXunY0bmpOw1O7vwy?=
 =?us-ascii?Q?OE7p1mjV8yoHveoNEQJxnwH8gxAT49SIdcquu3b1i/KACbZvKApnubC9c/c8?=
 =?us-ascii?Q?KsrAC0qm0vKNd+uXjJAPE3eVhAH843ld8h3kh8S+gpGLub5vI1VMzy+ejBOH?=
 =?us-ascii?Q?SkOJsl7ofa6Q+yBkhEzxuz8CNhiaEMPMsWs9MIoBsCQAe+T2NmXLUqxAowYB?=
 =?us-ascii?Q?xE7XMWUorx6tDr9smEtX+10Wq1uv/OCPeu6WaZrs+kCUH2r8hJ5/vaS8Ge1f?=
 =?us-ascii?Q?lxAdPHPRsY2oE6mF7bBFpOs9XIQzUZmwqByYbZ4/55OBE79RwCD4eYPbjxq5?=
 =?us-ascii?Q?f16KUk4MxrmwHiWXu9RtUtUqMF+gymTLr9R+cPv0S6xXgmHhqjr0SkZVF/lO?=
 =?us-ascii?Q?JxI+0xiFvSmqH4bwGe06vvRIuCiwc+TG+LsaDGMnZWZaSZXWKSfY9K11i56H?=
 =?us-ascii?Q?3KH3ogvE+xBsVfeMGPTKHHV0vW3K8yGMiAvbvRcT2sEpVvv+PMdPPMSWeUIL?=
 =?us-ascii?Q?B5YhQxBjgqQHA+qJWNyPIou7e1LtnFB4mkVaY9fus+TYTIahF4SElJD2U/8u?=
 =?us-ascii?Q?AMcaupzBC2i9bSRzo/Szx6PHG57GYwZuzOEq6Tid2SKJondTmNugfYi6HxjP?=
 =?us-ascii?Q?mH6zsql9rMdaumsBAAB92ntBOz38m1JWhVs4uaGZFNRVlqkPf+Xxn1zv5gmk?=
 =?us-ascii?Q?Ea8DsOgCqyNTxbKeOBbgaEdwnDtKWtoQrSRpadZ4G8Yw5qwhQgpkrCmzgMg8?=
 =?us-ascii?Q?MSXcWzdjfsgEz3ldTGfFSXj1mFfUe9yL4WAiMU5W7qIQvy9O5w7mG8EB3lzP?=
 =?us-ascii?Q?Fw2lgatfHyxfFBQRBDv6Z9FHCkysgzFdJwrPAVBh3qlI3bz3hDiZZMxKD4iy?=
 =?us-ascii?Q?uMIPvsRnzFlg/efY3F57ogaVhXJerZk6S0GygTME8fWRQ4oC67m65J0heuh1?=
 =?us-ascii?Q?Zn6EhzkFcDD7Ui5+TxO6hHHgpx1nvQLmd+2lEwDx+PYuW4RohgQXDrCZFHRW?=
 =?us-ascii?Q?7xm6Jjk9mi3Vie4tEkhq1QBDe95uxgb2+QcoUMOwFnvEWMdX9ATVXFujb86l?=
 =?us-ascii?Q?Jufy+OgT/tCg4YbnyeLOoEx+G2BvWXsr9ZwlomFUZ+RHzrExbgRkZICQGBhU?=
 =?us-ascii?Q?A9J9j/Tqey6GcXh5NzdsyThPqDffGxEeGTJI3HFReCHkOm7sq/N91LKh4tp7?=
 =?us-ascii?Q?HWwQZaEf+Ock030vLz/v4y8Mw5TRjvtFbf+La1fYKjqZc9I9f3di71a5Uxls?=
 =?us-ascii?Q?Dy5KDRSntJA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vHcLG4rOpt8UDq7e439hkYS8j7LQKngl++KZCmlz42+2XhuRssApgIllzLkq?=
 =?us-ascii?Q?ivximfhshnriYeNmorevwgnTEo504Jawy8JLu1ykUsvZe7FUNurafRpBr2BY?=
 =?us-ascii?Q?bOUtXNj5hWowSsDjf3OzkE/svjldUPS3zQwgWlITpg5QW3c+gqHo05YvS1Qy?=
 =?us-ascii?Q?or4BHRiymPl8laZiqNmHaY1pWWgYlpq/Qb3XpjYCcoNp3E+fW1WeUOyBcHHG?=
 =?us-ascii?Q?iNWbUF2dv6K4qeO7K612j2bgWIN1kJB+LD4XosFPwnCi884lHfYkrup27ytc?=
 =?us-ascii?Q?ylM+HsfTzUr5JNHoTcGNCmm6zwBQVVL1h5U8MOZ3lW51g9cKw5h17rzab1SN?=
 =?us-ascii?Q?TLGdScAqvhnT7vvo3vVGDlfzSOHXRwvdqW3MYdC1EaXsAFSV2P8cOMnp5Mt2?=
 =?us-ascii?Q?cIX1YBQpVevOFfuc5wJFr2AbmavHydGwqlD1FEG6e/HBwLk0cPIUDfCuNHVQ?=
 =?us-ascii?Q?BpsFJe7jwznyIkBv7VEcmuzG5jmFVTAvWMeMxvozzOWs4TAhiG3pMd0zLS+g?=
 =?us-ascii?Q?JemQX92OZl6kFudNBQmZkLs+p23LtFgdyIG/hVdO9adDKwyYS3JUH7cQytTb?=
 =?us-ascii?Q?zIbFau7GyIwCQboTkmuVXbmd+YvWDAIztlf3dIeqOh50YwEGow3rxutivjGX?=
 =?us-ascii?Q?yEUnPdORN9jH7PnfNW0vD+tWFfNgItTL0xt/UNTynGcGe+FWdNaTo6pZo3lZ?=
 =?us-ascii?Q?NhoRFj5F8xP6WyhRKwPtJMEyEAzflu7hA9dxLGFfhvZL4bnVD6e+RVR+6mVB?=
 =?us-ascii?Q?hzvamCyYbQsrgrpF79mXj4M5HUIQCh4ZR0F0wAcFcszti0mox7Y+F2woa8H+?=
 =?us-ascii?Q?EmW1U5RBqKD3Z6Uzl4/qePqQIhMYQxBNY+hzI/J2omW33D/uKhZOl3rpfRog?=
 =?us-ascii?Q?KUft5pzplyfQJPoxDX/gIkXuLST7WuJ+lxw2Eo7WYhxKOu2pVx2pXm4xolo3?=
 =?us-ascii?Q?eXQ13t2TfTq44gVYF8PgHaQg4DCdQ7AX1LeSxCG6xBD5HMdXkpq26GI+and6?=
 =?us-ascii?Q?0aRaWr62hhuGt3VBwqteDwD+m7SwbrSnI00ent71TavLMXews9iatti8emW+?=
 =?us-ascii?Q?9ULAJV2Vqe+Dp0XPx0bP22U9RMbeMSN3Ieg0/1kcIPwe4qb+IrFBUfuIRhNd?=
 =?us-ascii?Q?D2oES692KlH3SCN+jZUjiJCxxafwYCiofXPFHRs2kgML97A/usDvA+4/JiuS?=
 =?us-ascii?Q?mvSQTfbhgEhj+Iplga9pzR1Yf2e37Rvy5egliSCSf+Pxzuj/PP7dM+6Oi/27?=
 =?us-ascii?Q?5vEz10ouCY4jzJeeOJPpwLjx1N41JHhWVJXdO01dQgBDH0Z47WB5zRgV9kUR?=
 =?us-ascii?Q?fODjcpcq+WCoAhVcpr18+3z0EcRpAeKAJfrU99941vk2qe9KUEY/Z6Kb0k7H?=
 =?us-ascii?Q?FnZmvRzsTwNtsxRXe6e9viQKdLyAw3dZD7ncwT+aNf65WtbENptQRQZ4JFMc?=
 =?us-ascii?Q?i7yYknhBqQRi9pIy0cyEF2KCe9Fx7gdS0JdzaKwTu2A/dAD8fMwaEElbjR3t?=
 =?us-ascii?Q?joFPbOO1xUQY+ARBfARV4zuUUv1bKVhefHakbj8y4Xr2QRz4XduR6Ue4tHMb?=
 =?us-ascii?Q?RUrsmB+XsqhjMY/L34Cx7XPUMwselFFWWyb/UKxGsQy+ofyyKSbZ3Ell27Ti?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aee9baf3-2b62-4f18-dcf3-08dd8d37d658
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 07:21:51.7090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vXpMVgDoACbLDhNfduX7W/rox+Ne+7d/Ouc85ieUfEp2uES/L5hhZyL5Ol1rjPp7hgESiU0X0ISFaPn/PDLRVCaojlXEPFraBBTMf2fes8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8270
X-OriginatorOrg: intel.com

cxl_dpa_rwsem coordinates changes to dpa allocation settings for a given
decoder. cxl_decoder_reset() has no need for a consistent snapshot of the
dpa settings since it is merely clearing out whatever was there previously.

Otherwise, cxl_region_rwsem protects against 'reset' racing 'setup'.

In preparationg for converting to rw_semaphore_acquire semantics, drop this
locking.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 418539e859e3..1c195f495a59 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -913,7 +913,6 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 			"%s: out of order reset, expected decoder%d.%d\n",
 			dev_name(&cxld->dev), port->id, port->commit_end);
 
-	down_read(&cxl_dpa_rwsem);
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
 	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
 	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
@@ -922,7 +921,6 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
-	up_read(&cxl_dpa_rwsem);
 
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
 
-- 
2.49.0

