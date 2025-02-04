Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69212040B5
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 23:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738713054; cv=fail; b=T3obhAxWAHijBiDzCNeBE3lNA88i8x6jvFznRua4UPVXiDKuCLg/PhEWg3H8I7CuLKP6qBeu3oBAlf+ql+X3CL9a0lKxrAdE2k++GBrgLYPz9uqn8ryYSP3Lvl1FO22PMMeDQjdEmbxRIPwONrL9T8tbqSDe4BvEkvWs5wEFh54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738713054; c=relaxed/simple;
	bh=K7MXV2AYYOnwdzm84tKCC67PIcoHDo7KkVJUKkw9uhU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BWfsWvwg6ropD8FplLPMYplHCDGRfuyqq0TBPrnl5krBWppq2pnb+G/s6Iq12/wMPWccgaVnGA7+VFKhXJYDClAXD/5DeNInIE1qp1PoAJBrJb9sKrbjfQfflHBOxFJPv+9aV1N7sLWS/mlzs+jDnuAgYLHJ8sKz7RXUiTaMBds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJUFMxgD; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJUFMxgD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738713052; x=1770249052;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K7MXV2AYYOnwdzm84tKCC67PIcoHDo7KkVJUKkw9uhU=;
  b=XJUFMxgDPwFJH5w7ZgAz0ACCi8qOKl5ZDfnq09bhPbmBwNjTcB3Qxo8v
   kRKDdWxxt1wSywZXUOvoiyDjSldQ3CuBCgHsAKxBZ1MDcAQEYvpN4fjEJ
   vz0GMoq1GvCWMmwNJhOhojhpN8tzdsy5l/dJ9tAFqMKm7ujjaSfUK6Z8U
   /aFALZGeI2S8P6KKYcwO/Gj/4qlNhWIeAR6jSnqCaJM1yau4szRnDajvk
   yEpNRgxV5PRT4ChIgWZ69Fibi5zFu+2kiS9LjUAMIvi3OLH42k/bCq84b
   9lpkuoEQm8GQDW1eR4qzchalar3rt7FLl2RRc4cuCmVmrNkMCo1+wy78N
   g==;
X-CSE-ConnectionGUID: ncVe7LzQS/q+JIWRuUiEmA==
X-CSE-MsgGUID: 9J+XfbFBS6Cy0olFzqIlIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39152086"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="39152086"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 15:50:51 -0800
X-CSE-ConnectionGUID: DjXOHTBvSYCdC6wVPsmQwA==
X-CSE-MsgGUID: bCq0a6bITwCo4Xb5i41prQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="110729004"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 15:50:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 15:50:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 15:50:50 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 15:50:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBIMs2w+gnMBiZ17PLn/gWdYk/jMvWdWO06mMhemYVv8pctabsR3HTfuncJKQSZRoUkdbWAauJBOqsVNyYGT3m0UfPmIIgWqMb1yvFpTUx4VbKZVJm0pxyJkIxLvaMmDWAmOOwQSaPMHTX/H5inl+WYeIqAIUbFKdIKkiMNSPwqh7n2RoOihLLHEULNFiXo9r9q3EmqWcTCp6rGWsFokThM+hg6v73sl58V3IAvrnpOmRHm9CbsaVhrJcKUGIIyMtubO0tAHF8kS+slIvYlmhV/PsbOvrWklNFtCKabwPCxMBnb6ICSeLo9/KJiLvER6VLCbqoJ2h1yqkfRBzK5ubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNJvrPmScl/1iXkhQwBFFFG7JCKkOGlHhGVA8FcCu4g=;
 b=RxguDfpzB03E1AKUvbQ1cid2f3a1C2LjArmRyVXlSpmHD4mh/W5/optMcujBImg1VgzxmJa6QlxqhxjQ0J0r2l3/pChk9saNIKAdNBkmCchgTbARZgvoFPOYE6L2VgI/VzSsjSY6U68T+8kC5wj+oUfevqJggUp49zNDLnnH5DnZioE2VkL1pNCRfzCL7hWqxvQ/dQzqn6/8eMQOe+EjzE+DBcKM7SwIg/Benes7HkYqeAO9hWDIpzDIlp7PNJwWNyyIq5l/dCpIbEFwiSX1IPjhTwvBM7ud1l5jTfMia1CQAdaQAemSugrz78hxcJ62Chdaxyy5C5fhdn/NQkPOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8123.namprd11.prod.outlook.com (2603:10b6:510:236::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 23:50:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 23:50:48 +0000
Date: Tue, 4 Feb 2025 15:50:46 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v3 03/16] cxl: Add Get Supported Features command for
 kernel usage
Message-ID: <67a2a7d62e298_2d2c294d7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250204220430.4146187-1-dave.jiang@intel.com>
 <20250204220430.4146187-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250204220430.4146187-4-dave.jiang@intel.com>
X-ClientProxiedBy: MW4P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 035fcd2a-7ab5-4ce6-7c8e-08dd4576c006
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YbXoBSX9hzwuFUT9iHuA4En02r6TT6Nr/8O0Qam0x4vkzps9ORce4z7Zhira?=
 =?us-ascii?Q?g2MXMCDjDQS8IZVVuiAM+H0HCLBUw+sunrsHYpW6AhCU5bTUDGIZGw9cnoH0?=
 =?us-ascii?Q?7REiqpfZn7w8wZbRNrlBlNdzgcYmVX+RoDBDSzlr5IqccVWynZRkyxRJ7bNj?=
 =?us-ascii?Q?eElI0hrOWYUZZnVy1sxvLgstGUAV5mZwdWuJRzEg+mOx7EcYae0oraAnB7HC?=
 =?us-ascii?Q?P/T2rXHfFF1AOaktRJ3Zo0zRoYCzwH1bWOfP8IzEtpgdQBq2CL/t/YrBRmct?=
 =?us-ascii?Q?TVH1ZAAc1lZ7CyoRWe0idfsyyGUnqUloyZ2AqLhF3DMiVSntI2EvUbUsBScO?=
 =?us-ascii?Q?O8YWdg3A+7rIjMcks3qh7xFnQli1QwH3UP/5sEU7p0ra+esETgxgyrDQ4tB5?=
 =?us-ascii?Q?+mol2Y58BinX0t/hHYEFmfrMJTqSE147CKTw6jJuqEKfYyuJFjknFkV41FfG?=
 =?us-ascii?Q?frUGoCbkphect2gn3C6beApG8bvmvouikyZWBMheqkx2mPuKboOnTlbtqlIE?=
 =?us-ascii?Q?UMtRhYBQOF+T8ItWUuZIHCapQlYzHS862CYWPQXGwkpAzhESK7f6TQ9OSsDi?=
 =?us-ascii?Q?MZ46QokWQKb+bmdFL6bT6w9VC4FN5nOIbgZi3t+JapBO7BCMaQonCFsw+O+M?=
 =?us-ascii?Q?uo5G4dW8GdFTFuA9gydpKcMUCi+T26BCRmrdj1lVORxmE8FIshN5G5Gccgk/?=
 =?us-ascii?Q?Pj1z9n4s3UF1ywPNahvhePT/gfhRHN6StzuM/tGKNP/fkHBQS7H549HhFCEO?=
 =?us-ascii?Q?WlB2wWY1AavviIVO8UCguG/2Uk9pJ+cVYupL0C/P4iCl9yNV6U+ItD6l9TVc?=
 =?us-ascii?Q?pHls3qGuJO3USP35zFVBpjyrIQkNWd9fe4TYgpODC6m/sBQzyIWLwEmflRrb?=
 =?us-ascii?Q?nXeNY++/VJ3CRe5NUbpM3lrsjl+sFKioxsU7Z3ZjazJjzURavqw/u0yn/nKj?=
 =?us-ascii?Q?qIHJfhPj/EBFhzAzGtP6gU8ln8h1lbcITpkRdSUPJ3kB1Mhm0M/sJOShaDpA?=
 =?us-ascii?Q?i0ZZsk6D0/GsipgcQjGwydkiBlcwY0UcDJuQqvwzVn1LdQ7VA/dbSYVOBFAq?=
 =?us-ascii?Q?QpieTWtX2oMALN9FoL6cAkncUfJLWllDfv9XdX/RXgavjdut/Evv873gdSPN?=
 =?us-ascii?Q?pjsXKDyYNs0Fw0OZjmo0c/rvN+owCwR/jPgohnQ7del9sLD6dE0/DooOhBnO?=
 =?us-ascii?Q?ZgpVXq17GzUwLXfzVlEvjdEYfo/ziC/Np5U5u534LGkHyFErDPAe0ao650L5?=
 =?us-ascii?Q?oGp0PhgJQFEaBFaehDrzORZDtatYyrtgOssmBpkhXKx6Tu4aH2BqqW76xJY3?=
 =?us-ascii?Q?RHzsJYoM3Alm46tiwp+zrXL5ApFW6EJCpM1TgKy4rHQ9dGKHQNgvUKJyfQtA?=
 =?us-ascii?Q?QcbF6YgMWZkoBzZMq2mA4UTfn8qi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GnAGOjItYOV7D8pUyHOQlmw9xOAMOW6crkaOHsAnBUt4FQZdjdcb7CYLrJX2?=
 =?us-ascii?Q?jVRzRVw0YSn898oVAOJeQ6HJHj2BjgsFm1bhNIyRB5PsVwdGYSOvjKsXOLk7?=
 =?us-ascii?Q?qph3SSp8ZvE3VvXCrZuiOGQm7qpfsQnUHcbgKC9dI2UVnx3duoxZm4eFGAgh?=
 =?us-ascii?Q?uiEnehLaf8lm2XB0VXsGyyRrPtjKFtBPH/DOI/6dYjIRlDByZq3FVugs0zPE?=
 =?us-ascii?Q?TAjDM0ZIHrgAK29pYAymlyX3I9JqHlz6uVVSUlHrDVJuqoo2UunAFIi7/jcF?=
 =?us-ascii?Q?Q4BwypDmfMZ89cMhY1TrEBTwfZLgGTawiDQ817yYIu0DXz2vwPWgPoW//Ppe?=
 =?us-ascii?Q?4kU9O0yZa63/0JrA6QH9eug2UWH0u8ZtVGQSmxZa7xwfc8dP2IWP0a3GIVhM?=
 =?us-ascii?Q?ATyL/+4rzFXbbaTk1YMrQEzD2HHJUYfOIydGX1Aala3J5vXzEMwSkZ/1SXV9?=
 =?us-ascii?Q?PYpPWjSqyT4eP/hMe8LDeWjjCROFy3kpV/x+0HW1aSvxxWyNgQPUSMmxEjCg?=
 =?us-ascii?Q?K+HNjydVz5LkV6p61iUAq+CYoyGt2hqTEFHKOQFldtmHS51AHm9MXO+Q5uTw?=
 =?us-ascii?Q?aqXhDNfu4BawxKor1a4YuxQ2CeUEtiqVdqZQUQ16ujnXJDna6hInBdD3sPB+?=
 =?us-ascii?Q?X0MVZL9bQ8qS5KON6BieXCNKCCENOMe5CeDJQdyAnn7pbLcpI7Ga+/jWSXu3?=
 =?us-ascii?Q?WDxsXmCUYkwVnf6FP7wcUXjZD3Zi8dOX16rWKLqSuYXgoXHShDYYC3QHpaj0?=
 =?us-ascii?Q?0Y9y1cEyr2e6jjJ3qO7bQp0h5cQSKPImS2MuHzyZ1rIA8njLtg8DfC07IMY2?=
 =?us-ascii?Q?+fl01y/R8MBnJVM/bs6po8iqatD6pye+o5C+JJzIF5kHKW0QZt9sXzeZ1NOi?=
 =?us-ascii?Q?Mm0ZZw4KX0YRlXUTtA8aKpbEomG370qVc+T8nD9v8UYrPFDnjp/0Is6hWNhL?=
 =?us-ascii?Q?cccUQqbHmTpA6P6kc3N149DTsFdihsF+tYZ6lK4PEcxJ/HTU4rHMrH4wxswE?=
 =?us-ascii?Q?1sU3zBePs1loIV8kK54UjN+9+WypZjCNWuAMs8+lMgyAO/3ICogiG8VZ3+cj?=
 =?us-ascii?Q?KO8OfRqxD1a1WG26Mx6AlVyVtsz/vFI99bhyrMLhX+XgeQgB0XXeKQ0rZC1m?=
 =?us-ascii?Q?01qL11bJQaJ1jRA62UPkzHFlyYwzxvv7cIdm6/WtICivApBBdmsCv924CQRG?=
 =?us-ascii?Q?s5ZO8J6DKTKdVbSpYjwJjRvsziI99O8mUj6iJpKAjQXuWhRjP9c1fatST8oz?=
 =?us-ascii?Q?nJKG1SwrffQYzl7DSj0tk6k+0OHc5OBmCWsVrIR2DVrVAtZL/bBPxPfmWH8P?=
 =?us-ascii?Q?swN0LivIxGqYWaBvEHNDKoJVMxnOp243vCR8Vy1izpPgLpubrqksYt8pavoX?=
 =?us-ascii?Q?4vnRzBq6CYTixNT4FnxarirsBqBDQFglGzO0IvPjT5LK6ImdUxLx6eiAQpe3?=
 =?us-ascii?Q?oRFNaArZ8OpHCN6qmRIz8kAspETLbkgI+9AAEG6MOYp8RrngoZo/U0DkGVcH?=
 =?us-ascii?Q?K6ImqWrj9CxsDF84cD2i2tM3A+8PKYqVOObH1ozwS4xQJUt0v62mnxb4Cr2t?=
 =?us-ascii?Q?4lb4gsU7VwpFIe91DZ0K7E6XKBitY7qrWXrEJAYSUoe/jZ13CPU7nYxfCT5J?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 035fcd2a-7ab5-4ce6-7c8e-08dd4576c006
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 23:50:48.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0H3kF/fMLo/Po/KzqDVAh+jpoqLoH4RUCP7Ge1ZREM0oE27oKWbcvLSF3So2UQZ4YVfe7gwTlxvtEyLPCZh8AcD6z615oFzfGW/YKIO+5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8123
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> CXL spec r3.2 8.2.9.6.1 Get Supported Features (Opcode 0500h)
> The command retrieve the list of supported device-specific features
> (identified by UUID) and general information about each Feature.
> 
> The driver will retrieve the feature entries in order to make checks and
> provide information for the Get Feature and Set Feature command. One of
> the main piece of information retrieved are the effects a Set Feature
> command would have for a particular feature.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Use struct_size() instead of open coding the calculation. (Jonathan)
> ---
>  drivers/cxl/features.c | 138 +++++++++++++++++++++++++++++++++++++++++
>  include/cxl/features.h |  57 +++++++++++++++++
>  2 files changed, 195 insertions(+)
> 
> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
> index 958e4828a58d..4d8c603121f0 100644
> --- a/drivers/cxl/features.c
> +++ b/drivers/cxl/features.c
> @@ -7,6 +7,139 @@
>  #include "cxlmem.h"
>  #include "features.h"
>  
> +static void cxl_free_feature_entries(void *entries)
> +{
> +	kvfree(entries);
> +}
> +
> +static int cxl_get_supported_features_count(struct cxl_mailbox *cxl_mbox)
> +{
[..]
> +
> +	cxlfs->num_features = count;
> +	cxlfs->entries = no_free_ptr(entries);
> +	return devm_add_action_or_reset(&cxlmd->dev, cxl_free_feature_entries,
> +					cxlfs->entries);

This is a memory leak. At this point cxlfs->entries is NULL having been
marked NULL by no_free_ptr().

It is awkward to mix a return code, a return buffer, and a return
features count all at the same time near a devm handoff. I would suggest
solving it by:

1/ skip calling devm_add_action_or_reset() inside of
   get_supported_features(), make the caller responsible for devm
   wrapping any allocations.

2/ Convey the error code and the object via an ERR_PTR() from
   get_supported_features()

3/ Move "num_features" into the allocation for @entries. Something like:

struct cxl_features_state {
     struct cxl_memdev *cxlmd;
     enum cxl_features_capability cap;
     struct cxl_feat_entries {
         int num_features;
         struct cxl_feat_entry ent[] __counted_by(num_features);
     } *entries;
};

...and then have get_supported_features() return a 'struct
cxl_feat_entries *' pointer.

> +}
> +
>  static void enumerate_feature_cmds(struct cxl_memdev *cxlmd,
>  				   struct cxl_features_state *cxlfs)
>  {
> @@ -77,12 +210,17 @@ DEFINE_FREE(cxl_free_cxlfs, struct cxl_features_state *, if (_T) cxl_cxlfs_free(
>   */
>  int devm_cxl_add_features(struct cxl_memdev *cxlmd)
>  {
> +	int rc;
> +
>  	struct cxl_features_state *cxlfs __free(cxl_free_cxlfs) =
>  		devm_cxlfs_allocate(cxlmd);

devm and scope-based should never appear in the same statement.

>  	if (!cxlfs)
>  		return -ENOMEM;
>  
>  	enumerate_feature_cmds(cxlmd, cxlfs);
> +	rc = get_supported_features(cxlmd, cxlfs);
> +	if (rc)
> +		return rc;
>  
>  	cxlmd->cxlfs = no_free_ptr(cxlfs);
>  
> diff --git a/include/cxl/features.h b/include/cxl/features.h
> index 8e1830f0ccba..c65760342f97 100644
> --- a/include/cxl/features.h
> +++ b/include/cxl/features.h
> @@ -3,6 +3,8 @@
>  #ifndef __CXL_FEATURES_H__
>  #define __CXL_FEATURES_H__
>  
> +#include <linux/uuid.h>
> +
>  struct cxl_mailbox;
>  
>  /* Index IDs for CXL mailbox Feature commands */
> @@ -25,11 +27,66 @@ enum cxl_features_capability {
>   * @cxlmd: Pointer to cxl mem device
>   * @cap: Feature commands capability
>   * @num_features: total Features supported by the device
> + * @entries: Feature detail entries fetched from the device
>   */
>  struct cxl_features_state {
>  	struct cxl_memdev *cxlmd;
>  	enum cxl_features_capability cap;
>  	int num_features;
> +	struct cxl_feat_entry *entries;

Per above, this organization results in some buggy gymanistics.
