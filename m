Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E5D944F
	for <linux-cxl@vger.kernel.org>; Fri, 10 Oct 2025 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760132037; cv=fail; b=h26nMTtoK/CVVC62Zga2OQiJRtdxpuK27OGq9Oh2mgHk9Kkr7MKEt8MQc2AfNjVP/O5XbcLmnWoy5k3NxSMPKGiAGUXRw1ftwVhFpGLlDPBDO0NbVYcxf+y1S3BsYxUW8bc1cehM2Wvs4Eig2YXt5k8EEnj5ZcdretQlIr1Hfjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760132037; c=relaxed/simple;
	bh=nhHnY+ZNKEr5dAibd5ETJkx7pIGCSBnky8G1c4+vcCo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n/eqY8aW7CYWQnQPwnFDbuRVRD1LWkbMV1J/5LUl4BthHNyNsD9eweXf3/xyRFTlmaLR8hQObDkBRQQQhdY2dK+iScbm6x+pPQVkcMtAK6Th3/26eLfZd5iBTYrYbfkc9CDfObhnNa8i2bA2UqSrifgTjKiOo5sfDIQef3F/wSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wd+Xvyb9; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wd+Xvyb9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760132036; x=1791668036;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nhHnY+ZNKEr5dAibd5ETJkx7pIGCSBnky8G1c4+vcCo=;
  b=Wd+Xvyb9VcCAaPFyesD/BfE68IrM+TRxalTo1qHDYVtd887kfBWEL4pS
   zoJNtoibwk7q892dveaXJc0SZqvY7iuP22nh6SF0vDl6FArmI1aNaNgTF
   KORTmhXwvEIub4hyHapFncwjtblNiXfcGGcj9j6Ow/j+lwEjpd1yDtgMw
   URKMMF6QjqPXf2mL9m7hTclOxFwrqc4kSdEF9aPM0kc3vTwiy2NoCgUwj
   +a/agMmBfrWRzBhOxJybE1yxUOAqCypIWigeyTrJ2Z5CNhtQb8WNklB6Y
   Zhn9nGcTj4H1cNNLFhfbF3EiQw5fTJTjVBP2DdVUYdRX5dYQcCoubj4Da
   w==;
X-CSE-ConnectionGUID: njIPLNfGS5CO0Hplc0YFog==
X-CSE-MsgGUID: C3oMG0NGR++L8wVOqbvm8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="49917449"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="49917449"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 14:33:55 -0700
X-CSE-ConnectionGUID: jcZAzVsFQ+aqYJhh6iPUmA==
X-CSE-MsgGUID: cG+oq1b8Q+yxJ7eydmAAWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="185333674"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 14:33:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 14:33:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 14:33:46 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 14:33:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLSb5vfwlWrF05KkLZSboX94PIqyiBj3ySunsROJAuZaTXMiVs9huikJiXJpzPxDWu21/11kBD3j2yXLzBQ4I6Uq1BdIzi77hldW//tyB5IUhnVXa+7pruXZC7fsI4pYhNAr9dwTt7JsxBIwh/JbW+Bk99QXQ423wUbJFOwQWAO+HGCUSfPgsDy19WixW612Tvpelp2e/gGbEk2EW36+1XP2o3UiFJEnqh0hW7WXBxTnzFCqJuK/1LvB13N0gFmqIZaXRQLlnxM0VPT9Lmku9oTHchWx7W8OS1UiH9Ra+G+5hQs3/WNau72Kru0DAgDNmq6XBaY5NwBBjnuIvxXb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmwO181pGdpo3Hz0sJK5taEBPpUsPAnzpzHCPm0Z50Y=;
 b=sBTm0W7bNN1Wn04HtLoAQ8hxEank6E2QmkjeVghrQzgNaL5ZymjMbBy+I3NB4xsDIDycVXTkwLdhd/x8AxP5l0/0RSehPq4X8kgrrWlNt6NN8EVTIwcl5xlaY3Dw9K08jvatSAhK4RG8Eohe5CuVBDyDMnyaEmyN3wl8uvKivuoyhVchzqsnJiWedEcPu1cC7xxgg23D2FpzomTp5xoJ4MtP/5kF6gL/a21zPLoiNFnN4wQAYAwW1thBrqCN3NLkx/NfrSgmGgUElJuYZWZl4LOiw7x+EXcDm6r0tqAAzXaX4PJ2VC5IBNY0bMFEKGPgepRljNiZovI1snTYr+eJRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB6916.namprd11.prod.outlook.com (2603:10b6:930:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 21:33:44 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 21:33:44 +0000
Date: Fri, 10 Oct 2025 14:33:41 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <stable@kernel.org>
Subject: Re: [PATCH 3/3] cxl: Fix match_region_by_range() to use
 region_res_match_cxl_range()
Message-ID: <aOl7tcmm5Bpf55NH@aschofie-mobl2.lan>
References: <20251010205755.205280-1-dave.jiang@intel.com>
 <20251010205755.205280-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251010205755.205280-4-dave.jiang@intel.com>
X-ClientProxiedBy: BYAPR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::37) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aab100f-1548-4b8a-1681-08de0844b075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ninlrS+9YsCroDXL/TOG2kefQcamvZVeRJ1FOqEBKw+LQjJm+GYU2gl9q8bv?=
 =?us-ascii?Q?CFq7XDmNLl1SvOX+FORoRxv7/jUU/gjl3Id/4inrbMEoXXxwJGVNKbA0mX3T?=
 =?us-ascii?Q?pXLQjX0IZRQq45kZ8rekU/k1dx8WB+6xJTBYfIzdXqw55dvurZhcQVfnAmgX?=
 =?us-ascii?Q?0Gt+A7YGzDOhahoa4Vv9lXFc7f1aOMCPi61NqyaNDMW5hKhMXrg1Mrs08hQQ?=
 =?us-ascii?Q?NGhVm/3X6jpEQI8dE3jeE6g5xV0+3Ownj6Fzhx5eOLWAC3IWK2noes5iHOac?=
 =?us-ascii?Q?aUuzItmIqEqahsUhX5YHCsM1GPSnJUedhwIxDIDAlhCK5ZgZQjoKWDQR+CTV?=
 =?us-ascii?Q?skI/dNmzmwOQksOz/F2KbhIF7k81YRpPP+8PzTI5x+KOcfNnM8ZGdlz2YerB?=
 =?us-ascii?Q?4m+lAdNroO8E82tpNqNp0rdibUMip43VEsc4KNw4R8Vl8bSYGmXBLe5FTMri?=
 =?us-ascii?Q?AmFcOOeaRz8B9aXPhHr2ofqp3g2a1Q/6J/LrJ3fbleMIE34eLGADGs/x9jqJ?=
 =?us-ascii?Q?Y0UqIqvivMtld2Dd2SZA5Z1D8NVcbves3s0RYf2vnZrwZIIk4xvGP71OWdMB?=
 =?us-ascii?Q?TuoE2H+guEE8o5WhYUOExsbtszZG0bX5knXl0EeUX1hHnzNvglT1hwZaM7GS?=
 =?us-ascii?Q?5hHVsiHHAFZ6VaHc3FIIvKQPl0H8ly7URNBQEkseHFywxnNg1REtitG38OA+?=
 =?us-ascii?Q?jnJbeZ/mw378XfkpSSsoOxUWnvucwuCe+xm0TfcpqGbVkmwbzuloy8tCsFsE?=
 =?us-ascii?Q?I2ldUtEucPROqu6pLbou5drdaRjc+ogdWXwIKDe5jbe5hiQBvgCsnqxBlG0W?=
 =?us-ascii?Q?L0EVxRcS/02betjbDrUeZevVdtT9ngP8jy3502PhyMVUYdeL27XS6kktyePv?=
 =?us-ascii?Q?n9rou+M34sC+PksL2garuKggrrmkdS1S8JNAd0auIvaoM/nkGT6fGdDJ9+2Y?=
 =?us-ascii?Q?U54B+CXSWQfX6IrxUckoNEkP6JN3vOvYoo5IZci1yPM+jjwby6uuQauM8EIZ?=
 =?us-ascii?Q?PAVD9eMcWwW9RLtOSBsqm1edKeQkruBO/WGi9zUZziyHioyA8lmMwFbRqejQ?=
 =?us-ascii?Q?E4Mw/vGVRCWH9KxNiy3GmV7wcWsA0DGDy+uSys0J6UuFfQKRncLyDsitdv2v?=
 =?us-ascii?Q?cm8zXdALJ2KsBb6dk7uw+bdRpM27TUqZKcqd59TLmw6fU/wYsGKvjihuo5Zd?=
 =?us-ascii?Q?ilftEUaauV9F6ZYgvXCVf91zVpokaWEcI3ACDXX02qpov3iZpN9cDoenRybk?=
 =?us-ascii?Q?iiwO430AmS7CqiSKMbGg5gB+pmj93GPcHCYKsczpUkKFCe9GzUX+Pt7aVQNR?=
 =?us-ascii?Q?wu9y1ROA+Fp0V6yK3oZl0Obdjp4lqvHvk2qfzXWbSELqsx4tWI+KdDFE3evh?=
 =?us-ascii?Q?OREBnwfT947Uf2efMcpfj4Tgr6nMYM7H3+m4EPgyEkOoBWywd+vSg8HMD7iH?=
 =?us-ascii?Q?TUnczmriltitTNxRXjB6oKtMrQBxPE6h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wBQPTXltZAt9LQX/8MgRK/w07Xi6RkdF/weHJd+SllX3KyGyF5YOXfuQwofC?=
 =?us-ascii?Q?vsHm7TquZqL6ZX8ZMNXfnoXQnmAQ0mbJIbcRNitzAY5xB2+5LgoLq2Ej3o7k?=
 =?us-ascii?Q?OJpNTEwUt0tfonEe3V6Hui43wOjqmsP+jTHLzXgdo+x80fqxf39bBIqP8wN6?=
 =?us-ascii?Q?Ate9/xPRnjR36SvPwf63RU5izm2YLEnkjBpMYDGAhHQuEH17Nk+XJiG83mA8?=
 =?us-ascii?Q?oOeK4+Txnwfe5mUTl9p7c8Btxk2vEgKnjiySK9HnPhVd4HQX9CWeOO/DhVJR?=
 =?us-ascii?Q?n3NXa5DoQKMTAUUMfMiEde8pxPKJ99gP2geJx6WW9o1Cz0FraW0JVPBPBXcj?=
 =?us-ascii?Q?Rma8syUaIpW/TL/KONBvNP+nO6G781RIAKBuLnfU6yWkoMEYZTQsPpN+pW9X?=
 =?us-ascii?Q?7i0yFC48RPrZRMz9zJsaLtCe3bw0hSFZtozk9YgQ+DzCkGb+yMxgsmmMyt/U?=
 =?us-ascii?Q?njHJbsNri9CWV7pfo92nFCfvoO/51JMEfb8kItK8jU/94mVau9eFSCRrsrj8?=
 =?us-ascii?Q?VKFBIBQjDUs4ctU+RSGi/lUANJaXQHNnGtLcw5sq/zyzyMwuweQDWTerTrjn?=
 =?us-ascii?Q?IeuxfkNg6h9wzgeQ/4KMIx5xi1XJOoVWmHQyAqvUuqHBXfKYLSltM08Vb5rF?=
 =?us-ascii?Q?JIFZPHn51dCECXXVibydEsfefuVsjzAlNZyDsRwhVd460BtFd8hhlKkvZkai?=
 =?us-ascii?Q?GdYYvsFXYhxOdJMjuCcLv10dZXMGidA7wbpZfUIbr+dA7zXzr1NGS1pBYSm4?=
 =?us-ascii?Q?0EFgL1EmnuKP5gH7qE+HmIlvLt9wFdtLNDoPATgTuI4D/hc6NUCokAGoK/x4?=
 =?us-ascii?Q?BLSBU8VNSAXTH9N0rczS3JDC4/s2Q/YlV0gTon93w9NMsdo9+XnxhS5b2kJH?=
 =?us-ascii?Q?ZNQ970UEK9zJx6Y/6lhOB0I6+6nZeuxqQZQZK7+VxaPoHmP71dz4oEuCwwO4?=
 =?us-ascii?Q?S+QJnTfEh+u5NPZUwkKyVdbJmaW4zbMw7I51bn5RvudnTmbyyc70C5fhc7Ut?=
 =?us-ascii?Q?tjF544fOOQOYiCr/1THQ1KDdplfWyRMAHJosU2JfTo+CF/KpxNWID36NMR4U?=
 =?us-ascii?Q?cMpKiShi7komKf8LIV/BYZyz2OK1ExPTA4SJhedriWdSI+j169aoW+n3m/nM?=
 =?us-ascii?Q?GJ+WrAkFDwECP12gE8CS2xur/+6giAFUZ1EujfpklCsKlMntWyzKpNAQ++WO?=
 =?us-ascii?Q?wWSiqMFEKf340tS7cFWwSdMR11SqAq97qA7wms9jmlut8WjGQcPmdWaB10x7?=
 =?us-ascii?Q?6Nw5dc8CR+FrAaVHRYY7rnGGiTRINPM2nUm1AWNZjjPXs7q6N+DqPRCeWKLX?=
 =?us-ascii?Q?luDkHak4wa4LBp3Ep1JiztNYKq6AG7gyqWcQqJPQDHUzZO3qWL7zFD9uG6vQ?=
 =?us-ascii?Q?ZZ5stj2Xe5d36o97nfM5Ab9TcHCxXn3GqAkvCdQUDs3sa1UEN9vptOj87iBu?=
 =?us-ascii?Q?ab/aQmgwJBFut2+hcjCN09xzMvnwqPpLxz137pKIBTAdB/ljRkLdIz6Y1398?=
 =?us-ascii?Q?Y/HDU9ATipKBR0VYfIFgLDvpJpGW9LyIV+2/JibpFrob1QvMnHpTb4tOumVg?=
 =?us-ascii?Q?i/HGZvUmw1RvHapN8DKeYGgQiTTDfPZbuKvYjaDpFu/ZnjEkktELgfSOP9Zy?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aab100f-1548-4b8a-1681-08de0844b075
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 21:33:44.6201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucS7aNG2+Hv67NBHkoAT1OJyYKC5HEAcpbvg6vYpDvhYBNEOctUITXUMN7+/jgIjJgFu7YwNbfkhMiBeUycSlr5RgXo/kzva1Ot1rMDtSAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6916
X-OriginatorOrg: intel.com

On Fri, Oct 10, 2025 at 01:57:55PM -0700, Dave Jiang wrote:
> match_region_by_range() is not using the helper function that also takes
> extended linear cache size into account when comparing regions. This
> causes a x2 region to show up as 2 partial incomplete regions rather
> than a single CXL region with extended linear cache support. Replace
> the open coded compare logic with the proper helper function for
> comparison. User visible impact is that when 'cxl list' is issued,
> no activa CXL region(s) are shown. There may be multiple idle regions
> present. No actual active CXL region is present in the kernel.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Fixes: 0ec9849b6333 ("acpi/hmat / cxl: Add extended linear cache support for CXL")
> Cc: stable@kernel.org
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0ce50998c49f..be4521184328 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3287,10 +3287,7 @@ static int match_region_by_range(struct device *dev, const void *data)
>  	p = &cxlr->params;
>  
>  	guard(rwsem_read)(&cxl_rwsem.region);
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> -		return 1;
> -
> -	return 0;
> +	return region_res_match_cxl_range(p, r);
>  }
>  
>  static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
> -- 
> 2.51.0
> 
