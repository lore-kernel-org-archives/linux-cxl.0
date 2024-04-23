Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174BB38DC0
	for <linux-cxl@vger.kernel.org>; Tue, 23 Apr 2024 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713915478; cv=fail; b=pxhzRLpxDZ2rkOaSp2w0h5gxD9YViv2yq44fmPAKwio86vcpXx393/Xil06rQZvtyAGuTFFrSV9X64dnrA54nPYaGFB6O5jbhhWlJODO6KObcjiIORRm7n7UVdm3uYMszHVEXVDH5I/Vww7UUxvisou9X+ImUIb9J9Kglj9xJn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713915478; c=relaxed/simple;
	bh=v6ypw1Oc9uZtSXfIHkoVwZVuIZDTNvAlsYQ8u6FnJ8k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W49kc9bxAQmcZ/YulpmTRYK/l1Kma/zTwYkG5cz6xqpze04f8go9c9/F5fEDfpfs9hmclg0kBije9+5nrcsd60nM96iibqx5KQ2wnJd3vjlmcWSrftF2jnisLt70k5THzlrEOOG/gUWbf76oQXdQ29QQFvhDqomifm7n4F34kOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/Z0ItCs; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/Z0ItCs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713915477; x=1745451477;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=v6ypw1Oc9uZtSXfIHkoVwZVuIZDTNvAlsYQ8u6FnJ8k=;
  b=l/Z0ItCs7MH5jQ6lzQTVGo3YwLRHDykJb/TJ86OHbKb19JSgHj7F4AJ9
   BcF0wIBwvArgGNXmtPwAUlyF7pLzpnYKJcgv2VWXqELWKK/5YZeMFT127
   QiX33HkvfW6NjAo1xsAxrVTOFHkM/UNJ+ToQu63leh3TGeud1XCqSogV6
   vmNI9VC1f7jLt9H3bUsvKF1ilMykOTdK6pt/ZNP3YzDz8sIpv15tslbzC
   BqHGbtSo0foRlFuTw4W6MDmmT/aufX+iUZ/c6KYUC+7vztxeQNiA17RLg
   +U8fi6Ui+scJaIHzE+ET16Ue/n2H2jcq7DBI7fI0mD78DA0OXZeF7fJ7K
   Q==;
X-CSE-ConnectionGUID: TxZhAbdFT3W4UetoXv+fsA==
X-CSE-MsgGUID: 7aVCcaqKSAGcIuk2Xeov2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9398777"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9398777"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 16:37:56 -0700
X-CSE-ConnectionGUID: fm43XPDETK6Ded3IqvVJYw==
X-CSE-MsgGUID: EgqPBLfjQIef1RZRhgIglw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="55727664"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 16:37:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 16:37:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 16:37:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 16:37:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9qf6RqAesnuiWLGpWaxDOyHWmD+WuzZS8S9yTLZmM7isXDTIb7lfhSPly80BhVLyV0RBJB0Ik5435x2KhW9Tt8bzNfyA4/BN+uNbp2ujdQa9YI2lWKcchDxImq4wwaGDfk8iQDrvKKDqedv7ymuI9l5VAvuzwSwcKXq4namGZC3+WC48VZnjszZzL4EJg/6AcEDbTQgHtuWGbX6jpOaMEDdVW8fc1fH/qaLdiRfoZdSdzqG1JNDLpgeVfSieZQK7bqyjOsycz5iKTsbzoCYgT8avkvCpB/0L70AjBlkpkfNrlOgzDK0Ak2lk3x1Temp7AQ5DehJdupNfceDkWARJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1upCkSiEVR+BKeSZB0fTqTKcFC7g9RTKN8Tu8/7DV/k=;
 b=KcoZGcKeBJxmGD6Yuae+vbqPehrd7e4cq2TON0m+19vJei992e5/IxkmtVxA4J1gu+3zd50DhA7ztSrtDvEBm/HJP8z9pg3UAIiES0J67xrss1GHZE819e8IcivUL+kYKWWmIcI1yZzjXPGD6IbDWKCdh6LdepaHeSXfsyA0443ydpmjZnt+MUYHGdkj9udb8Hzk/GQk7kFOa3P81nBiKPCcioaKTmRFcOMlDl7Gyp2o9POelw3x6G02BkdKsL39Qc44BSn/rC8YHk0hH8X/oKFLOhnCqz7V9LtyNC+d7RRgen8Cc1Z9E7MkEgI9CWNSWhvOm/onWrp/HRl7a/nKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6546.namprd11.prod.outlook.com (2603:10b6:510:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 23:37:53 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 23:37:53 +0000
Date: Tue, 23 Apr 2024 16:37:50 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v2] cxl: Calculate region bandwidth of targets with
 shared upstream link
Message-ID: <6628464ee73bb_d567d2943c@iweiny-mobl.notmuch>
References: <20240411181641.514075-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240411181641.514075-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:a03:338::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: b91edd5a-cbee-4f4d-451f-08dc63ee655d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pJ5VoAE8LBTKsR4FTu3wsW5cVkx8lwypKdSDfIDJNRm0U4ga0ZnXFd2XjmhU?=
 =?us-ascii?Q?x9hFG8GsmqjSSr2qOQOdLVy8oKmlc8tnS2sJ6acuzj/Znsfn14XoawNc6a9P?=
 =?us-ascii?Q?QHrBqNTJ5w3yfj8ByCs4JTu1Grgd5raxocDkNAGeHxSNI4RecJbCApyIIAOO?=
 =?us-ascii?Q?o3l/JSf7st9YueLBRDVhaA1+TOrA6OQrlASIfsy1J0Eviuuv1VvD42pUxgrc?=
 =?us-ascii?Q?o/UVerpdXsH+xNl9bVeIDVKkSZi0el//KdWulyjMkpxA9gpc1dPNXScAjfdC?=
 =?us-ascii?Q?gq4S7UGeIkGvgI4sSbu1tJt0be+ee76UaVaP+RAqtzDtWroxKAhNu8u6nENc?=
 =?us-ascii?Q?vjmX26OvvGF5HSg0h3SJbqISZA7ixz6Xz94bbyWntdzUu4YtUESouEIaskmL?=
 =?us-ascii?Q?SoEW5Ssqa9+5lhe+2YsnQLKW994idMJsNOxH3m5lrNVOJ3aewKUB/k+bBc+9?=
 =?us-ascii?Q?OG3evn4k7oe1+QG4yZxW5gSNuWO8/J9g80sr5ITFspu0mrCjQwMt1GgvPmcO?=
 =?us-ascii?Q?dPByI8p6RP8XoOMiSJeHUdD0Fq1Y81e3GExIuVCVKNmbgPDPzFPIliLYDEHj?=
 =?us-ascii?Q?M2XZXwMeeXAqc5lgajSWi5siML7zCmACzLOL4NfIZzbQ9ioMu1bOlOrhjnmp?=
 =?us-ascii?Q?XtHGbi09g3VKSFFGv7F4qXXiYS1PbOMyHaKg4pIIpQubLMW7iIdZBcRW9xqP?=
 =?us-ascii?Q?CfOAmcD+lILoGj+mig5pMkqDRNCDwCcaI2FHs1UGFVRq8y7HfYy/W7avQnwM?=
 =?us-ascii?Q?xyCnMLdOcYdTBolmPsOSkYS8v9BUHSq2HqyMkV6dwWUEk2GyU3/M4bverwhJ?=
 =?us-ascii?Q?obj0sy/nA4KONtZ67eBJI/r5JUZTg2OlpbGuEI3r0EsBVS0ED9dGdclbHatJ?=
 =?us-ascii?Q?68hWTYdNNSVTrj2ZXJGEwxSfzQWa7NyJjpEBy5I76b5jcKFHLiSnETc1JC+r?=
 =?us-ascii?Q?sTmQKJEmCEKtsb+gc4a3Pse60AKN4omu4RKTc5WHI2JjBaeSZvR30X9pB5aE?=
 =?us-ascii?Q?ea4WPT9YjRojfo0a/C7OYBs1JqMylLuzV8ELFg8Lsu3z0TuJBELxQ3PX/qNf?=
 =?us-ascii?Q?QCb01sDToF5E2zGSwjovlaCYVzkFLABSws5vb/SuVI6VEDpZCD39u1S6AWFc?=
 =?us-ascii?Q?wkw1Iz0qDHWmAuSdf9Wv0aM2Hozj1Z1cYYDfpcZ1tHDjuvDgV9UEuUuLeZXq?=
 =?us-ascii?Q?0rF/YxZOqMFkMAMCsaWo7SPFTQBereujrwi7HsAxNuNnhcUKNy1HOk/phNO1?=
 =?us-ascii?Q?BudX27V0FIu/awO9/rS5vpJ6/3Azba9xrALQylrJkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m0zskbHHIJk5LKd8P1q6pwxPePbyvDpOeZImABhDP1nwwAn9QKgHwbYGlxmQ?=
 =?us-ascii?Q?dJDPdTQffvEj7WIbiZOSw/d4nOBZH80dev1CYR2VjAJVvXuJ1XPNOjMZlTso?=
 =?us-ascii?Q?zpgf3y79TWzpt+q+gKQC3cye50QM078scoJrR7zW/YsVxL/crXaYw1zkQWMw?=
 =?us-ascii?Q?3J9lWmoK6NcX6F9Ij03xc6QJdPIEY5hus0QtmYPxZfH10Y47tPPoqI9Wurfd?=
 =?us-ascii?Q?HJvaKcoP/nJpCgNGlWh0f1VuIbcpJsaFtbIBJITxZgvd8kqx7efkIde/IOjV?=
 =?us-ascii?Q?5jM/m6Xw1igcsA5yE3O62Zon1Gil0V/hri7xAfJYWwWvYp2G5/1Q74bcAEWO?=
 =?us-ascii?Q?acMPU7mMpAFSGopFI63ih+IhTbyIaQtIgZlSXjxt2U0mm5IIiMSbejpJR4T8?=
 =?us-ascii?Q?5aQ5A3mSYGcKhcGF2vdRKPDiai7Z3TsrjXETfFAgeJeQtSQIgKihwlCNFyQm?=
 =?us-ascii?Q?DxSIRuvHQFsUe0CJQyHSnOO7u2yjpnnVSioHovAGTAgsPVTSqGp6eaGLeieA?=
 =?us-ascii?Q?xWWIg+yjVhCCbLiNDE1vcpUtwpHZNyUYpW2Qrg6DoBerut2VlGUmV3A4RJz6?=
 =?us-ascii?Q?4x3klAqPmXA2ZDwoIahdEfFq/TLKQSO/0p2yZIE0+z7G33XP8bnOoiexKcKi?=
 =?us-ascii?Q?G/3duv6q+6rskj1Oelq742C+fg26RgfbGNZQGv2dhXrIkE6rFyufON8Cw1an?=
 =?us-ascii?Q?Ww/+GHcquor1wHi8uMmKYahP9Z9afgOXZ194IN938GIDY1aQRf3VMfeRq49d?=
 =?us-ascii?Q?HwBf2oynacTwjSmTwzVyvrO5EnyHjdV7HGX+L3t1nUVmi+6vRpHtwh4NvAyK?=
 =?us-ascii?Q?nbd//FDzcfHt/D5x/BupCpJw99bF3+HUdFFqBdp3ozVF4H0jLTOxxWHfU2X/?=
 =?us-ascii?Q?1eVZqNzqevUpfW6CkweJcoP1+HEbEeOA9DbGNn4MvXMGLFWbxt3QJyOk9vZk?=
 =?us-ascii?Q?gJogxzTux2bHCfFSGQBKHZyf80lCosdSwWKhy0ubyrsA4a0CMjE6DzPfTI4K?=
 =?us-ascii?Q?s51zCW2hlkgEgaB84F8eANqzI41imr3JcVlKXKFhNayraaKUqW2tjhV7qvMs?=
 =?us-ascii?Q?CdWkoE+vizS12DNC3EHS5kGMJs64E6kG/F/VlZJsvtlxU9Y5nr8otO37ndbv?=
 =?us-ascii?Q?YgJFBoT7DushaW+QFc4JicwyG1ZS8q3/QgrWcwb1Phnf4h3O/J+mrLLZGjMc?=
 =?us-ascii?Q?HVkmwzDDUWSgGk3TI6UOqPggf5l6XhRZebaABptsU04cTehLjwdUPuTMJCuB?=
 =?us-ascii?Q?qH/HUoU4U4nSOGwfz3Xu9dV8AzHtB5zkDw6H8K5TsFej10f0AQafUi2KSNtr?=
 =?us-ascii?Q?4F+UDBbAa3Ls95itUHDUMn2WC5mTlRJXi1oNiD/h7fnoyLLgRRJ/hIhvAHVH?=
 =?us-ascii?Q?skHeicH2dN0DtfdyXnSh+KDcrgLrYTprT0llPmY38Lm6reMZ8/SVdeJNXshl?=
 =?us-ascii?Q?qgZR0DImIwAhCirsEgiBJvHzVNctviUf/wZj/SSdl+AMrgJ9T2MdnbfZxaVj?=
 =?us-ascii?Q?OiENT6KHNIN/MAKRb9g+9wFF/wswaPqO8BEcaGcBCeGlO3S9QZ/NE+81G2UR?=
 =?us-ascii?Q?76r6B2dcESqfBgsPHF5OSsw14WLd2cFfMKrM8FBu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b91edd5a-cbee-4f4d-451f-08dc63ee655d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 23:37:53.5353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftSqP33Ai1AEum3s1vvg/mZ/Ll0C8Uu/xFdgzSqYu55VwPWOLD5zT1PFGn62kjFwG4oLq3bcUNbqdKNgiZBZIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6546
X-OriginatorOrg: intel.com

Dave Jiang wrote:

[snip]

> +/*
> + * Calculate the bandwidth for the cxl region based on the number of targets
> + * that share an upstream switch. The function is called while targets are
> + * being attached for a region. If the number of targets is 1, then
> + * the target either does not have a upstream switch or it's the first target
> + * of the shared link. In this case, the bandwidth is the sum of the target
> + * bandwidth and the collected region bandwidth. If the targets from cxl_rr is
> + * greater than 1, then the bandwidth is the minimum of the switch upstream
> + * port bandwidth or the region plus the target bandwidth.
> + */
> +static unsigned int calculate_region_bw(int targets, unsigned int usp_bw,
> +					unsigned int ep_bw,
> +					unsigned int region_bw)
> +{
> +	if (targets == 1)
> +		return region_bw + ep_bw;
> +
> +	return min_t(unsigned int, usp_bw, region_bw + ep_bw);
> +}
> +
>  void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  				    struct cxl_endpoint_decoder *cxled)
>  {
> @@ -551,7 +581,9 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  			.start = cxled->dpa_res->start,
>  			.end = cxled->dpa_res->end,
>  	};
> +	struct cxl_port *port = cxlmd->endpoint;
>  	struct cxl_dpa_perf *perf;
> +	int usp_bw, targets;
>  
>  	switch (cxlr->mode) {
>  	case CXL_DECODER_RAM:
> @@ -569,6 +601,12 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  	if (!range_contains(&perf->dpa_range, &dpa))
>  		return;
>  
> +	usp_bw = cxl_get_switch_uport_bandwidth(port->uport_dev);
> +	if (usp_bw > 0)
> +		targets = cxl_port_shared_region_targets(port, cxlr);

I'm not quite following how this handles a x4 situation with 2 upstream
ports and 2 devices under each of those switches.

     +------+            +------+
     | HB 0 |            | HB 1 |
     +------+            +------+
        | (link 0)          | (link 1)
     +------+            +------+
     | SW 0 |            | SW 1 |
     +------+            +------+
      /    \              /     \
 +------+ +------+   +------+ +------+
 | EP 0 | | EP 1 |   | EP 2 | | EP 3 |
 +------+ +------+   +------+ +------+

In this case the region BW should be:

	min ( sum(link0, link1), sum(EP 0-3) )

How is the sum of EP 0-1 limited to the link0 BW, and EP 2-3 to link1?

> +	else
> +		targets = 1;

Maybe a comment to indicate that targets == 1 is a failure to read the usp
link speed so defaulting back to the sum of the endpoints.

> +
>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>  		/* Get total bandwidth and the worst latency for the cxl region */
>  		cxlr->coord[i].read_latency = max_t(unsigned int,
> @@ -577,8 +615,14 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  		cxlr->coord[i].write_latency = max_t(unsigned int,
>  						     cxlr->coord[i].write_latency,
>  						     perf->coord[i].write_latency);
> -		cxlr->coord[i].read_bandwidth += perf->coord[i].read_bandwidth;
> -		cxlr->coord[i].write_bandwidth += perf->coord[i].write_bandwidth;
> +		cxlr->coord[i].read_bandwidth =
> +			calculate_region_bw(targets, usp_bw,
> +					    perf->coord[i].read_bandwidth,
> +					    cxlr->coord[i].read_bandwidth);
> +		cxlr->coord[i].write_bandwidth =
> +			calculate_region_bw(targets, usp_bw,
> +					    perf->coord[i].write_bandwidth,
> +					    cxlr->coord[i].write_bandwidth);
>  	}
>  }
>  

[snip]

> +
> +int cxl_pci_get_switch_usp_bandwidth(struct pci_dev *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pci_dev *iter = pdev;
> +
> +	do {
> +		if (pci_pcie_type(iter) == PCI_EXP_TYPE_UPSTREAM)
> +			break;

Why is it not ok to do:

	while (pci_pcie_type(iter) != PCI_EXP_TYPE_UPSTREAM) {
		...
	}

Ira

[snip]
