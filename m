Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3257404E
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 06:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448626; cv=fail; b=Ck6ZjKo20PTAXGq9OQ80xnDCz5I9KmMemTc2hHsT4hcMLWlg6kNRoao6odB3NhoBiV9DzKX/bDF84wj1kb13R839ekUSMcycbhgbnJGdxiLevqKZV6Y+/ncLxSSIMNUk6/l1mLZNLKKgVJKoFbxk1TQKXREhVsW9RFeEj515LR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448626; c=relaxed/simple;
	bh=+wsPVvKrgPtQ3YlMbgT8AylBRM1Cf4ztJ5rKPYzcI+E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y4ZI+YII4tJWITdoT1nzrhPZL0WUQam8aE/4C85aiZtEUVISROoWLzFB8ljfB2Ws9iHNPCtJ5aHNklz2bHExLHV77HCJJMAQK6Uj10QMqwN1VCsivTGQNcbwgTgTpVCtsN3Qe0bPk+qfGkWev5WZsFvsawJzIzcbLkxysoBU7YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqCNSSjQ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqCNSSjQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756448625; x=1787984625;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+wsPVvKrgPtQ3YlMbgT8AylBRM1Cf4ztJ5rKPYzcI+E=;
  b=TqCNSSjQgKDQ9n4xcFXXUpxvl4xoz5EXVgk/R4KDOQ63JPcU7eFBhoA8
   BcDL7SWh+CvAeHNyw5jQe2lw/HJ3XtB1KPydjTUwKytVT5bRTpPoOKjxS
   Hi23kjsPSIJcQWWB2hrrTlk0unET5FL+XAbv5iVBioffvftVhEqNum3Tb
   rBMJGdVOB1eyjq3mHqCOC8+lfTgE5pRZz7ocHA9eMdErJeM7aQAvKbMAz
   3/Suej/b6twXM22OnceJPkj9anOJlacf630x93A1ssg4jGJHFgoHwC9sn
   IPjAopDuWs1cKO8MngFLeSUD7YOSoJK5HGEZuwPFnJ/t2HTmLCNGIpaia
   A==;
X-CSE-ConnectionGUID: HSg0I5lnRoiIDRsGFFEX+A==
X-CSE-MsgGUID: 1gQcF2yjSJKsKiB9iloD/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69440589"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69440589"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 23:23:44 -0700
X-CSE-ConnectionGUID: nClygov4TcujSU8vwzo92A==
X-CSE-MsgGUID: AolIAqriTsGvJ0wMjWdC9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169834456"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 23:23:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:23:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 23:23:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.47)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:23:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDct3NRcP3su193txQrltgAZW7s08Zhs5yGjcXponR55Y/KgVLzWLmLQONWQszfpp+PzUR9VpGuOZ/Kwjm7fUtOLSJ3NIu/vH582CgbDxg0ZlzbfNYOW7JmmndV5XNry5FyUf8gFhDVaRl/SjSLafq6QkNGnHvhY2XtAnA89hVXJkj8nIqEHWgeYViUP7kqMHM/NyTmP/fL+isxj7Yehh1ELsKJSfORpUp9Xoh45dMzw4AZRDc3uC90q7tkmJpgxECZVOgEBpmLBYK/8xdo02wJ4tf/PCXkocwhDBMvTRiRud00Oqem4vO8qUawesXS+1i048O3hcmJyEOjDPlu7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKCbdAn1W/2RYVtJXmQLhQcg9rYpWOiyDXCH7e4RwZs=;
 b=mGHSENeSRnVl/7XxLUe7+waljdza3CaUigZ3Mi/WhuO8YOQwswqLG/OHfiXmWpuwYHg3OANFU9XNARvBhxzGGTdo1R07n2iVIG7ICmFBsy1N5B1ETieXZPt7tm3CNg9a4lcf9qjyiToVut6fbOHgzffUqi+ejFmo2Bpld/ftJdWJkVH+hYlF/xbbYvJaqtQfO6Rajz0/9yZY7JFFHayBy/PC8qVvaEhLPss3Iz1qLJNGajRVdAsk0IC5FiZW31A9igLKAyFmG4lAkWyujBQvEy/z9c00SESe6rATFmsDabAM+x0Lhylujnsu9Y7UFMmV1NjokpNcElmAIreL8BEPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PPFCA3BFC2BF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Fri, 29 Aug
 2025 06:23:40 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695%7]) with mapi id 15.20.9052.023; Fri, 29 Aug 2025
 06:23:40 +0000
Date: Thu, 28 Aug 2025 23:23:37 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/acpi: Make the XOR calculations available for
 testing
Message-ID: <aLFHaRKvYYc2ffeO@aschofie-mobl2.lan>
References: <cover.1754291501.git.alison.schofield@intel.com>
 <e2ffaa6a29117fd9832542e4ac314b46ab2d1fd8.1754291501.git.alison.schofield@intel.com>
 <20250808171921.00000cb9@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250808171921.00000cb9@huawei.com>
X-ClientProxiedBy: BYAPR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::43) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PPFCA3BFC2BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 4014cc9a-8f77-4424-180d-08dde6c49877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vCknAyFqOieJZ2KGljqxR9XAhkT4wEyXakQcVVjarDUvUL8dB05xWmqNO6ay?=
 =?us-ascii?Q?+ujCWd8ScOWClVJmBjXoxa/a+7BMs0eNA557iB/dhUEsu/k9Z6DPDMB8ApfR?=
 =?us-ascii?Q?rKdfsMOBFw/AWmQQi7FaVBhPAmznvqKWvLDAvzEiIUJ68wYgapERSCv6Kikn?=
 =?us-ascii?Q?m8J31iqhKOvj1bGk+EoXw9ytN93UxygLlgzJgY7EMbzVj+UhmPZLn/goeq2S?=
 =?us-ascii?Q?sHADXa7meCKLgAxT8BJgU5fhAPGzX2S4D4vVjRz7GZ1Ey16OiKnxHAL3ipTC?=
 =?us-ascii?Q?GCtoaQclCBI08PQjhK+icwXHwWPbHNhLtTmjf8ZcBiVxdfhHzhkc7FYlmKS3?=
 =?us-ascii?Q?cAYovdicstEc8izOt1Kx1UPLRR3tRt2lCJ5vTR9WyaHZeFi54xMWzqu5hfBp?=
 =?us-ascii?Q?5ky5P3Y9kqgFFCN7kwjPtuUeEoXCn7jSIRHoU77PZcGRiGTVGwQ225nxaq+o?=
 =?us-ascii?Q?HhjBbj6uu9pACowXrKLpFN2ab5p+z/4mr1cfy1d4YnlnQ3rYpW79pn9pWRxd?=
 =?us-ascii?Q?K05OnsHHFfY+mzkaNnuLBOHER3jHWFLZKj7I1unQJmFs4qmCwcKtcRWAWznn?=
 =?us-ascii?Q?JhnRZa+jnxZh3PUxIDf/Kne1vezVUxH+FJ8nzs9QlWYbT+N7/5NpNra01KHM?=
 =?us-ascii?Q?cHil4WvxrDYIPcYKTF1tJR3wRkk6w+Z2xArw732gUuWJ1OexdA3mJF3hGEcE?=
 =?us-ascii?Q?/81kN79IVEBawcKIRIat/zXns9wYJ/g7li5FFbDruOJNGnAfXoqQoo4O9JH6?=
 =?us-ascii?Q?U3oTQDvfLqxQbh0WHa3qgIMLQE8QSs4dAEvtj6HdpWTKpV2dJQ6tIfsvW/w6?=
 =?us-ascii?Q?YAUaDZvD3RfNe9JF6xD1xN3b/RvAA8yqjyH1pAsfrnAAkR+Z8JxCTkq4MFcp?=
 =?us-ascii?Q?aEWtBonJaDltNu1ybOGxviYx/1O20/PZ2oTTmrCmSv2fc3FhgTn6ePefQYEm?=
 =?us-ascii?Q?mLPMNvn6Hk14Q84fVBwvT9XcCtCY3/N+TzcDz9mJQKOaGUd8WKWUg9DPbUQf?=
 =?us-ascii?Q?IzuUJYxzuTLAsHiQLlzT46BuVRLMwMbdHQhQhqHxmteLx2iyrKGktnnTjDwd?=
 =?us-ascii?Q?hsH8ydTxH8avLWnNMEp8lSLorfOPLcA03CRrgGo6NhDM70U5vZGwkhLBZWg9?=
 =?us-ascii?Q?XKkX9xo4Uw3dh5wCLLQWM0KHJfS7CiXq2pD+dPZvCif9MHZKwZaIFLKKAzpy?=
 =?us-ascii?Q?xChpbhT2kLrmnT9/q67To98IOa0UPraMeuSDXzzM4yWysBbWEwDb6V4aH/e0?=
 =?us-ascii?Q?HkkNxvWVViKUapIeTOrrHLu9PLdwFomZkq4qk+UFO3RrrqDhuvAo34VpNQ6g?=
 =?us-ascii?Q?jtwuaFx7sKGUW81WalvDPJniep7NPTAeBCJ90pkQTGTzF2asGT5jB8COJTAq?=
 =?us-ascii?Q?wRzZdiDRB3hoT967e+6e/6HAW1hBRkQnqmrgR76vKEl5XMX/tbv2ZhUFF3zP?=
 =?us-ascii?Q?5lyYi46trwg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l/5g+BGfGPksjWEqHmxHMLAwZZykdGQWaQuhlWtn37bTXuMhzHHvDCCLkxF5?=
 =?us-ascii?Q?z43PuLqx9VjCYC6TBHkjAcFIShYOZmaHIwLoN6KBlMkn3UQqElkrJ4r2D0P9?=
 =?us-ascii?Q?B7KxaYxLMHLvyRoMS3ATkJSUhrpKCfEqsGUxRwGqfxZNOfARk5nxnvYx0OrZ?=
 =?us-ascii?Q?fAB2wiIAX9CF8881gBcTa/x6tGLnlUy4ySGnDATyZsgHxLeSB2e/oAgiwQpH?=
 =?us-ascii?Q?OgyMEzWIe8GozyEtmh9NQk1/DksZ2f4MhwWBQm0xa8Xsaj33b2rX99knSees?=
 =?us-ascii?Q?rxfWvh8B6eyC0Vnp9tnYKueITRcVuib1Ceq7gnWd4HwR7xxHVDFlMqJ2V+DE?=
 =?us-ascii?Q?gdHRLuky4LE6bDAmi6YvW4HS2eZIxl4FI4iqMRqAALZrbUptmq4hHKUuUwZg?=
 =?us-ascii?Q?6neS9oBK1r/KmNT+1XJumVwSJpw+wEEXvbLwnoust/y1IdTCEJTq+jCxERvs?=
 =?us-ascii?Q?wzQqQxNy73xEKYoruTIaIIFI8SSg8VDpKwA0AOENyBwyz0WJiqfE0E8HjtZy?=
 =?us-ascii?Q?BJzSqfpw4Olk63OKqMTS4oWeWhsgrihMTchlWszEpTcpys7kjEOnW66N/SGQ?=
 =?us-ascii?Q?bJ4ToM4fDLQBDNn3MrqQ4NTxdFixlS4yP47AyeCNVjePPTC+6jU2Za5fmdFw?=
 =?us-ascii?Q?UH4Ea3iw+EVLDxKPF0HZmUsQ/hrsp4PwTewovYeVnarS1lzk3wRdEWsGUY3F?=
 =?us-ascii?Q?OS6Am4ExSv0nyTk78fgi2yYBJqQ+JbXPe68ku+7ZS9UMWSGOUUccwPNNoZS8?=
 =?us-ascii?Q?usQJcjJ8w2B9wuOtJj02vYQyRH/FDOqxQ9PahOalsFkljgY7GGCLjC7uOJYd?=
 =?us-ascii?Q?R7Pf24E0Ni6FfjDug1zzzaPEyybAjSD9mxKAQfhGZ2a7XCfjkel9PJ7JpI7K?=
 =?us-ascii?Q?+d7nEPA0Pjqt3r9ksQouduwslE70YBC6DPFz4tHawdzN0k0ByvbtU89DYegG?=
 =?us-ascii?Q?Zu0Rq2qO2GvbR4Sw5yLkzL9Efu4/tHkwsTSstTFUD8iAvcuvazXABsoF/fXd?=
 =?us-ascii?Q?PpdLK1bslDu524s5PNsQ6NJIVkYutCZ8w7JVvPwDsVSTZPxgPepPWI2drn9H?=
 =?us-ascii?Q?Hzy9g4lmD7ofDwWfSsM1EXM4U5E+EMpbAkJkv05mg0/cVl6FndkcMTiQzJRv?=
 =?us-ascii?Q?Lt16ZLkS4zrmi/nPG7xwM89gJIPwzzPb1IEwHqEThGS5upAS1OB1HufJmdIb?=
 =?us-ascii?Q?qTLQMYunwD4WXXFrWKgSN/ULb9VoadvSE8VlVjCavX5Hz6fhjWAdJrL+W3zH?=
 =?us-ascii?Q?lM9kmq39tEmTrcQGhdM6IpkuayqtwzxeQwzdVsNBVo+ilfYyACcB1Uuhldvf?=
 =?us-ascii?Q?fp2YUmzR/Uga2OwJuJEmMuamttfpgNVRTVBKXz8wnujeV0xkDJ5CKAKngUp5?=
 =?us-ascii?Q?3KKkfESb+5XLKyNETU77Zg8VvU29JmHJS5Bwu8J9dY6BdGppzIqLA1sNtEDj?=
 =?us-ascii?Q?AbaHp+/L6F6Rqbcn3s4wKqroXVhAW9QyFba0TAQKMpfRPjknbAmEG1ga/ytI?=
 =?us-ascii?Q?Kx9banH36zgxWk83wRpTnbCWDsH2XlZmTOAlytDZ17Y6VXEZxZ3mh+ZfGkL4?=
 =?us-ascii?Q?BKcNHeOVO9/aX8b4ON6Ie2+rojSkwpsU8SxB/B5+r6SVSxtBaWjXL3G5ilfg?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4014cc9a-8f77-4424-180d-08dde6c49877
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:23:40.4993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNR+gMGFCthCw1btmhdxQML3pC6hEAVGwuh+1tTRYPXgPLdwYHrZtViZlXbMbtpbYPpXH35rzSJjDw7V/o71Nh21OuLHx+aPpjcW0XX7LJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCA3BFC2BF
X-OriginatorOrg: intel.com

On Fri, Aug 08, 2025 at 05:19:21PM +0100, Jonathan Cameron wrote:
> On Mon,  4 Aug 2025 01:52:40 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > In preparation for adding a test module that can exercise the address
> > translation functions performed on XOR configured regions, the XOR
> > function needs to be refactored and the ability to create a CXIMS
> > provided.
> > 
> > Refactor the XOR function by extracting the core calculation into a
> > standalone function. Enhance the parameter validation since this new
> > function will be called from the test module where the parameters
> > may not be guaranteed valid.
> > 
> > To allow the test module to create a CXIMS without exposing the full
> > cxl_cxims_data structure, add new functions that can create and free
> > a CXIMS.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Hi Alison,
> 
> I'm not particularly keen on code that is just there to create opaque
> stuff for tests that may or may not be built but I guess it's not huge
> so fair enough.

Patch 3 is the test module that uses this, and the CXL unit test that
uses the test module is on the list for review too.

Thanks for all the reviews!

> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
