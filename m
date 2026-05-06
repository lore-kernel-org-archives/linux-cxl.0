Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D832DCF57
	for <linux-cxl@vger.kernel.org>; Wed,  6 May 2026 04:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778042313; cv=fail; b=pGfgnGRgIeDchUITtXt8G/rYbJl3J23pSWTe32DandnlJ4tz7UX1TmIdP/O7YWLpF92/pAhXUDlpxSoOfcfxCy2r8trVooUE3WteRfOj1yjIGAElaPSVnyg42/F0LdD6dBaDLNERSXNzIgaq+EsrfbGi8xaRMtx0lGyyzCFRBwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778042313; c=relaxed/simple;
	bh=tBctJLHe/p6jqtLn+L/DaLg6+vPCz2aaJDEv7lUK+XU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BWFcQA3Wa4Gs2VgDxYnd77Ixp42teVEPvDUWJrKpMmKOJKoqpvEvFVua1nH7t/ENHH0/GTt/o+jEqBBXC6aYiVVBS7M44br1lhDeXO++zs1sTY9cPVW8J7UhKkdo8InU+US8Bv5GME+fLvuU7uzfEOK2F7JhrCJjq3yjP2hrM3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aRmdH+2U; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aRmdH+2U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778042311; x=1809578311;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tBctJLHe/p6jqtLn+L/DaLg6+vPCz2aaJDEv7lUK+XU=;
  b=aRmdH+2U9IPXGtdj+qvYLBXh7r3B96X0KqCYwIHOWarRRKqIGsHk6puX
   fdcIxV83Wwc9CMLy8vHacWGtdLZzQpLLj18/BTeQvXrtnuPkkFwfEcdnC
   7b0lJXZaLXhFZT/unheLMUYPe/gMRWTgdOcBB6CKW+5kOhWyxwfXf/RdR
   snf4fpykCXkazVfo6V58fB2A0/mJBvTWllM60aRdGV7GFcM0iA9kW9jOA
   kZDdtSExFzFx2yB9Zrk9LFsvAkOU0i0usDpw7+H6KLhFi1q5uQ9Ev4Cb+
   VKltS/vStAhqn/8usZQByIMxAmHj4eZEYZGd7KNMrHWbCwGMrUnsezJO2
   Q==;
X-CSE-ConnectionGUID: t5GAHA9eSoaAjgEM2A6hSA==
X-CSE-MsgGUID: t1/vHRs/Q4mNHul9TDwTLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90303955"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="90303955"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 21:38:31 -0700
X-CSE-ConnectionGUID: t5W3qFq7Qc6VPUTZKk9DWw==
X-CSE-MsgGUID: OfQ9QCRxS7Sqh2scSMKKmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="259675778"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 21:38:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 21:38:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 21:38:30 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 21:38:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ob6bxsp5MiIYyPIXk9e98CMSWu19lhIEm5jxHhTU+KGS/gmVJiJtTjkckW9I78yU8rNMKaM7/+bwaM5MxpZKlRf7jAz/2qzHdvHZpnUWB5UGXqHb5SXuuNXgcq+PIdo2l6wk8OxUF6q3K93f1h1/BzTvEsANSnXCEmbHUIhtyxfF5XCjtm/ZXdCms5DQB9jy9e8D6nynRw6bZ3jqrAr0KszS4CS00U9WKzA0CnHXTUQMjpYxIr7wb3vf47iFtLtXt0QRwcr2bAmLGkibM/Ew1b4dEFl3JQ0OS4oq4gvhTyw/H7dxFl+27FzOJEv1xBko+big6qUzarirPCpzcyTZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixgss59b5DXCxRj8uwXZGB04X6+wyGIKKAErt3WDjpw=;
 b=m1xdG1Gnn4yP2KeZP9Y6Kaya1Bp6+buaVh+08PD0nkcZXr2HxWRZEEUae+IV87q4tSbGHt1pWK/CbHzUIqXICdX5uLnZAkan8tVqUZAoKuQtTyfJjjVe11/D1meJo1OPlZrIiv8gIOFF/OLx/ONe7ee9FdUsf99BNT9miB4I8IR0OMY41KPEWUSFW023NyYFLOiM0Ibgv4tqlEjv00JSF94xouqFI4n9MbZwa2kCO+4DAJRR7uUAE3mkfTscdejfXfOEizjJOLkwG8xW8tYZogBOT+2QBIckmgarlt1PbBMETe5vcVIkWp5oZ0FnTjIPRXAed+C5UXqJCYSM86hs1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA0PR11MB4687.namprd11.prod.outlook.com (2603:10b6:806:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 04:38:23 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 04:38:23 +0000
Date: Tue, 5 May 2026 21:38:19 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>
Subject: Re: [PATCH 2/7] cxl/test: Add type2 support for mock CFMWS0
Message-ID: <afrFuzfkLtGlkmAP@aschofie-mobl2.lan>
References: <20260422230237.2599333-1-dave.jiang@intel.com>
 <20260422230237.2599333-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260422230237.2599333-3-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::32) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA0PR11MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a276773-f2d1-4730-5bc2-08deab294e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4/Wj6qcnBU8IjVgKaiX70y660Y3apDfp+mjGKLhVzWwJzEFpN/d8TwEmXNUt0WJfGl2wdzonU25fe/gTKPNLnA/pOzH+ZwN1XzZ6/LUegX/NTF1Xtmn8H2g4CqbnugkTOaID6rLT+3n+6DegVr+spXnLQyW0OAOu2y2qYOoJFLaTMbLBtyI1m9PK76dyB4v0jYYJJAPpFJTvT5PD/6jgiH0LPUHqcSPDlcerX84S3Gwu+VsyCvxtZSHKdtLzRZUf4M84mPrM8AF9FSvqKSj4yKSsWJVBnIDGnJa5JJ/KJQMI0yWNdYod1BAjzLQSTgOrulM9II8ychHcNBnynb9FMTuZr7NjOBG33r4yIg6Iu7DHqXtKasWHicCfqFXKO1gdlxC5DbZXNI1zeWcq8eCy8gG0+Nr2pQ9r3aZxQMBXHXl8hG63paZ47fd8NyCPO9XOOjI9QAZuR57vPXw6AR25L9bnEpryPFkQ8fKa14HFNTIWs8sMHR6FwCMztpbNfSzKtIB7akXe29mxCPuNc2jwbDWXOGNlpO8Wy+2traRN2iRmcKFddcCAok03v6UVYzXN5B1VYzB2Y3O1+sPmyU9l/DKv5Ekp9W68F7/D2OiAnY71ItSPVHP1ms/lND5M3acKVoyjD98255XBu6wkBwZoEjXBIrmPr4ue2ub7t/UkPpjO7/0Hd1OQ3yM/+3ZGKU2R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uIQo/7kd251lkJ//y8F761Tf7G2z9P93E1oHfjQbp2b2Ybn0JnBOp9s9T4z2?=
 =?us-ascii?Q?HmCYMpOwDD/VbdCEtekUFHuR94fGJ7ZLt1O7BenNc4H54JuCoCgEhZo8w3CJ?=
 =?us-ascii?Q?dYg41hbZWujS0k2Dt6MhXhiyXv9s5h47DNDKCQYKOs72gyDaXTQ2kB3+zGqN?=
 =?us-ascii?Q?kX/7FxAATguhrkqpwPMtRdsZaW5f4PvarW2/fZtnzrzORp1uPIGE75OlSmNr?=
 =?us-ascii?Q?7ySaUEZGppAcXNzVRgo0Yzq33divMn4+P1vw2/mCi/xOU6o8lKB3dpp6pZ+4?=
 =?us-ascii?Q?nkLoteREdy2MhKMh58p1Lf2hnJhnsD3giy+otQDVK8XrcIPoXY/tSMy/vIHd?=
 =?us-ascii?Q?+KOMKtFHU5ymznZ8wnuzw7DsiV1DS6HeZCUGUqyn4W3R/kShfs8e8dGt+Xpp?=
 =?us-ascii?Q?/QYfIfAYKvtQZsRqheK4DG3aaRImwENjCOO4AHCcL1rz1xHNW6IR3trHSBUK?=
 =?us-ascii?Q?fNG118q8WdJwH0oZiSGhQglfdGUGxjkVwvOFh/0bR/OfIzzQVAwqVctg3BBq?=
 =?us-ascii?Q?uLpZRzuIBRlT3eRDE3bf+nZz861/FXTQulyKzN5JortNESdd/weKdBNX9uCD?=
 =?us-ascii?Q?vKzHV/zrXWZiPm4JB88IU81jTOC3Q3OkxxZpQ0mvTTaG5eQBpG28OOJSa/Zp?=
 =?us-ascii?Q?5GJomaJsPizR/wzMqyBZGF7wbZrFDcF1I6EGAVRod6ktM3SKreaKd9oxCTgB?=
 =?us-ascii?Q?UQdK6Hzjceq1KiaQxs1RxIybtsgjP6YgJbAJmGntMWPOWGT6rfZvukVNlApi?=
 =?us-ascii?Q?42qD8hiT4dMApoE/UJKWiLCxxUiUii8wj5uIkJt+r/4feIKa6Gf1QJvYuJ0k?=
 =?us-ascii?Q?NQmAp4+yeyssOaoAFsDAnCRKVhTVDAOgTWc1BNVZYarR0lf3IO+e+q8SSiM4?=
 =?us-ascii?Q?0n93ETvG4KpEN9/lqux7jrjoqmJZ3a7ffFI2YuSgkt+szhl1ia8oVNmmIWXZ?=
 =?us-ascii?Q?8Riz39cr9d2/aTY/ckZJWE6L8OLzIBGDTV2ZGxxFgOfnNOFClc9V33haMrMk?=
 =?us-ascii?Q?pE2V5sUDdEkzbl4mNNtB3E5LdIEFGHLQEydOdyX8sdwUyZTdmZr/1+e2SsLx?=
 =?us-ascii?Q?WKx1RqQTIGtXJmZL+AP7G1FHVNqQt2kRDGfu0o7H0F8neBqpdzLjcjDJSXst?=
 =?us-ascii?Q?oXJ309rFBqFIMuzdi9MFATCuywPlSico9IudQZh71KyvV3zkIElunEQMu+ky?=
 =?us-ascii?Q?6xdihqa8NwqAJ/1LTvrVYbk/2MPLYh4HwxevZaoeB1v3A3hD/1cQ5QAjxYoG?=
 =?us-ascii?Q?2wY5B8VZCt302uiwdGRI77ppbb3X5W/pnnEYERMaR3dfvL5OJqivQoAaD1er?=
 =?us-ascii?Q?if0r0SJF4L7kOGelGXQwvC59jUYpmmBObhzyredblTpgmYBtTZyUC6q+V/bU?=
 =?us-ascii?Q?PTwRFmtEYmfGGAKfauIiTACZSlCCfqXlHPCmUrf0iCM1lolp2ZnpmS0v04z/?=
 =?us-ascii?Q?ng4BQM3Fx3fImlK8WqreG8BnrKQPSwoO16+aD3XfNEwJmrCv26nJC6v1mc/+?=
 =?us-ascii?Q?r8OVovzijCA8N1kCiZJawONIYbKCzEZbhstSkoXez1zLprGy7X4J4zJZhMEH?=
 =?us-ascii?Q?IFAAQNO7c0r4EVLllMUoyUFJ0IY0xD01H1jHURr7PXtKtu3/WxzVtwgJjlOB?=
 =?us-ascii?Q?3Ok1JZ9G/XwWFHAHuYUB806vsllbMgfAvQTaOmRPn1mtIGkZt2+OdjYL6yWQ?=
 =?us-ascii?Q?TRaWFAnH6WULLBey4LE6Z7A8vchN17qQdKFhxGFY+PqPqFKj48Q9CyetMTCA?=
 =?us-ascii?Q?7nGq7uKduTst7WZviy5lflHOob7f0oE=3D?=
X-Exchange-RoutingPolicyChecked: a61TzMSgtKIdnO9VZG4khN1M1XMOsNe1PUZJktKRq6yFcL7zCXEAbGnbDYzkgU3rzqMXk9jFhrWiwlnNEuCuIzuZfbNqHyAQ8RLfx5TO3qC5fWRjcnqHCiqabm7ha7czaGNEsr2VyFA1uthMmTTh/vJzc2SdgrJ5LUaYDfrMAwhUFFKH4Y0HF59Z44ylypCglljoFdRRs0snvLWzkHv+eB/3Bl84+fQkhaZnhtdXtGjvPtrbwupeBS6hgWPf/dIZw22RDZneBrMxmHwGaEuTpkXMl/WZUqf01JGgujBDg8nY56ENq4FLstBCRQ61H3CUQMmv2Mz1fbeHbMLALa9rGw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a276773-f2d1-4730-5bc2-08deab294e56
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 04:38:23.0754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5JjDHWEGdPtRkojrDGV+Zc1ZQDgEmIcZ6Gq/CCYuJRKuA0+5FLq8tMOQwHris4rqOSfSq1wR1EPeI52IBG2ohTLGRFrOLmguqm6MhtLRks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4687
X-OriginatorOrg: intel.com

On Wed, Apr 22, 2026 at 04:02:32PM -0700, Dave Jiang wrote:
> Add a module parameter 'type2_test' for triggering type2 test support
> in cxl_test. Setup the CFMWS0 configuration to be type2 when 'type2_test'
> is set.

Now that this joins the module param party, realizing we need some
rules. How about starting with a simple enforcement that only one
module param can be set at a time. Probably a count of params near
top of cxl_test_init() will suffice.

Nothing else below, but I am going to comment on type2_test usage
in Patch 4.

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index c26c37cef12c..903223013e41 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -16,6 +16,7 @@
>  
>  static int interleave_arithmetic;
>  static bool extended_linear_cache;
> +static bool type2_test;
>  
>  #define FAKE_QTG_ID	42
>  
> @@ -383,6 +384,19 @@ static struct {
>  	},
>  };
>  
> +static struct acpi_cedt_cfmws type2_cfmws0 = {
> +	.header = {
> +		.type = ACPI_CEDT_TYPE_CFMWS,
> +		.length = sizeof(mock_cedt.cfmws0),
> +	},
> +	.interleave_ways = 0,
> +	.granularity = 4,
> +	.restrictions = ACPI_CEDT_CFMWS_RESTRICT_DEVMEM |
> +			ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
> +	.qtg_id = FAKE_QTG_ID,
> +	.window_size = SZ_256M * 4,
> +};
> +
>  struct acpi_cedt_cfmws *mock_cfmws[] = {
>  	[0] = &mock_cedt.cfmws0.cfmws,
>  	[1] = &mock_cedt.cfmws1.cfmws,
> @@ -471,6 +485,11 @@ static void cfmws_elc_update(struct acpi_cedt_cfmws *window, int index)
>  	window->window_size = mock_auto_region_size * 2;
>  }
>  
> +static void update_type2_cfmws(void)
> +{
> +	memcpy(&mock_cedt.cfmws0.cfmws, &type2_cfmws0, sizeof(type2_cfmws0));
> +}
> +
>  static int populate_cedt(void)
>  {
>  	struct cxl_mock_res *res;
> @@ -492,10 +511,14 @@ static int populate_cedt(void)
>  		chbs->length = size;
>  	}
>  
> +	if (type2_test)
> +		update_type2_cfmws();
> +
>  	for (i = cfmws_start; i <= cfmws_end; i++) {
>  		struct acpi_cedt_cfmws *window = mock_cfmws[i];
>  
> -		cfmws_elc_update(window, i);
> +		if (i == 0 && !type2_test)
> +			cfmws_elc_update(window, i);
>  		res = alloc_mock_res(window->window_size, SZ_256M);
>  		if (!res)
>  			return -ENOMEM;
> @@ -2029,6 +2052,8 @@ module_param(interleave_arithmetic, int, 0444);
>  MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
>  module_param(extended_linear_cache, bool, 0444);
>  MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
> +module_param(type2_test, bool, 0444);
> +MODULE_PARM_DESC(type2_test, "Enable type 2 support testing");
>  module_init(cxl_test_init);
>  module_exit(cxl_test_exit);
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.53.0
> 
