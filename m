Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48D7212F87
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519429; cv=fail; b=SBmARznwxlEe8ZZ2fiU71vw1Nn2tMqHs/yGxAFktfFgPvyD+dEZdMFXya8AIlsv2w1XvQ8kzFMGjhYffxhsVXJpD4xGwVeiRI8fO2L8A3B5S0WSJdlr5wNd9aQ6pdYUAyBY8tIYdUfa5qXXABk/54uwRIfV+pcpF91PiJlKbwj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519429; c=relaxed/simple;
	bh=IS38NdZhb8qZh8bHXs9gB3NFVx5sM8iaWvRGa4KoTXU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YKp1r58XdK1teS3vff1002Tqk9ayetVnPcfPdi5sijfE9k1cEChIKbQZXfjUu/s2HtjrGy0CqUMwcN2UgtFKQRqSl9dJThGe+OPVxegp1tIVt94a2QUd30TQDqW1ZiUgulJnfS+17pRENSyF4T3YULn1PffIAI9ORacGQ/QOek4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfmmJMu/; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfmmJMu/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733519428; x=1765055428;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IS38NdZhb8qZh8bHXs9gB3NFVx5sM8iaWvRGa4KoTXU=;
  b=SfmmJMu/jMIGz65StyFRooVsQ7SdPXNhXGFYfkF/FLZN+CvaDJuuVrvX
   nog/mJod7HnBjZVQG0byCgPMZuIsZdxnygeHVxwuv7l/nJbpQAKDDV93Z
   8awPmLutU0T0vfXJ9rGFiO3qLVnzhfAF9pTiBN4A234ssVo0hmL5T2vkC
   NWRrfI1ZM9m3pCwuJwlxph9dkrGemftHlxVo/Vg3Fml/d65/GKh7vN9Lw
   oW3ttNFbpt1DpW6WVrbIFb7Vr9ddHdhApALJ202GY8mM1SrLFAIfGdpYC
   prQcAWyU5imb0i0ZxhA7oAIawrSzS9z+weczLz1B3RFhSNLG4yQO0DI0T
   Q==;
X-CSE-ConnectionGUID: AREUm7WJRvyBq7zb+YpV7Q==
X-CSE-MsgGUID: u7ug4cZSQRKOLURmZoK+2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="34012403"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="34012403"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 13:10:25 -0800
X-CSE-ConnectionGUID: Pr68G/kXTx2v0z8Ef31JCw==
X-CSE-MsgGUID: aED9YgU2T1uZW+LUOBK3Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="117763039"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 13:10:25 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 13:10:24 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 13:10:24 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 13:10:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjvM5wr/1rUesx8seIU5TIM5i7roXt7WHYI7iIQFFPRPNoXQRC8vESJNJ1/1FGKIbqQ2A78sbr3wWmj1RGjE2eqQc4SRuodDp7yHHNaj7gpqiXr5NjN+2ouWuiEOQCHS3ry4Q/M3k24WCk1y5q9K0rfSlZ35Qigm9aYiBqO8FGUOoP/MlBMXu+xVp8MxIN2noWeBP3kexpfqscFpMIDiQ2Pi4JCKQ6S8gCOL807WzY8jDt3ClkudduMaDGSQ1paV8Khfs8XENyRuPaZgX0nTR+OSmi5iVQx5uJkLt65S+PtO0kFv+BiMt9p1Zp3/efRcHz2aIhNBvxql+j92njglRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5WrZRVbjeSr3BqGHyEbsk9CBxLQG8iyLQr6yNhp/To=;
 b=mRkxX9n2kICV1q4ZrfRN17KuQyz07bvosTv/GWJeDM/28d6GWJwHILqWe/0J4b7JdKmUCGcXiVqT8JgBVKRLnrX7Q9ijlH0WkIqaiIygCLZwtQe5vNHNHy6f+YXwPC83c/IQWa956OqWCkFDP4tAMWS+FnWJz5WPz53Jc5STiKU6btmWi0SfSinNK30YAJGrnyfUcsb6FAVL00A3C2/wkorusfNhyoTyY/NEW4UKSfsmyEOjaEHkp+ceuhVUEmBUezfpHiV2S+1UuigYRV2sN5msZ3dyveNmdfrxwti8PegMlBh+r2e7DVk1IiErsV77r2PfBZDDia/CZIRIXO9Dsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6672.namprd11.prod.outlook.com (2603:10b6:a03:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 21:10:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 21:10:20 +0000
Date: Fri, 6 Dec 2024 13:10:18 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 20/20] fwctl/cxl: Add documentation to FWCTL CXL
Message-ID: <6753683adf23_10a083294ca@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-21-dave.jiang@intel.com>
 <20241122152655.0000717d@huawei.com>
 <26d8e8fc-e631-4ef4-9e04-e1e4fda03ea5@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <26d8e8fc-e631-4ef4-9e04-e1e4fda03ea5@intel.com>
X-ClientProxiedBy: MW3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:303:2b::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 58334450-778d-46d8-464c-08dd163a6479
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b9aspC3wGdGLzUlZKZXABdvtT3250cm5Pm/Myf3bEwaOlvyAdub4F5Pjmut3?=
 =?us-ascii?Q?fy9Q+IXdkKuJEs9kuJyXm95Mlv6gVZnLfMmH4IXRgJeMCJEzbvga6bBGGLaU?=
 =?us-ascii?Q?h/lO6qjtylXj7r3axFlhSl/VjZvYDfTkFBVJ9agcrvlgEGISXVIO40VNGbgb?=
 =?us-ascii?Q?Rmuzxdx8QVClwDSHWrFW1b7EI0JH0YWgRkXgoHvzhrzwx6sj/UE9dIoCLgqN?=
 =?us-ascii?Q?CrnN0EW1m3Y8PNxtywOZHltocwmA9HlLitRvwje89f0eoBBr2JooWkkIAzwn?=
 =?us-ascii?Q?2miYFz25K7MkwUy9Dq/KeP2Hl1wskmXWqiv58tCqqOwkLRJ4kyPotAcRdDfA?=
 =?us-ascii?Q?e3pjpmT1NutBjQELO/fatw8WCxvQYsG6g+KsVgPa2o/aV3FNuV+FkjaY8QHJ?=
 =?us-ascii?Q?5f55XdA2B/lX1B1NNslQeqLo59zk4961+4D85XXZOkEyoZp4mjW/eLyJm5cg?=
 =?us-ascii?Q?h0siNKh8t6WXyHieEuA/LTtrpdrJq5LWe0forLRZhm5Y8bexJDe5ZknnamkW?=
 =?us-ascii?Q?/KuuoYn1uJD0e1+XENUUaY8PP1EJgLedtPpSSSf9BYzrK2arJvhgR2BI0WIA?=
 =?us-ascii?Q?YJS4oKHKh17m33BW7t12oWXER8Tmg3pCpOBON0uONjq6P+vixdm62aIYITjI?=
 =?us-ascii?Q?hdSWuYsuKEUSDdQHwBunf7+x9ut4IVRBQ89cqtIuJJa+y2dtgBEzgrZmNdf7?=
 =?us-ascii?Q?706RyIjO/zeGXSMdOuS3os0j8mirsRAM4YVVKZ63UTVMG2lYliblybH8XpPJ?=
 =?us-ascii?Q?0h+We/jj6ojMTKvTwt7ePMMcGEzDngfHDsHlVseCRHFovqRtVXMkSL1gX7K9?=
 =?us-ascii?Q?/A3cxNgBwlTtiiUXJtXBURB46CR3sfj4CREeERG87zrwOgqBnAbRMvkjqP6F?=
 =?us-ascii?Q?PHmevpHD03MGZrL3QBQRqWXqgFWFKNJVmcu43fW4cZvcfbzg23VO/4FyrRfu?=
 =?us-ascii?Q?CtkBCEogYb6m9UnZAh5v51T9B0m86dMwScgM7QBjzVzIFWuAYE8kw75QP5qb?=
 =?us-ascii?Q?gtFppXwbR84G2n2RoowE3fFXbYv8+s3dRLA+qfe3OfcHzN2OGQqZ2lnKJ2gc?=
 =?us-ascii?Q?v/PcPwBIiZG/d2Mklxtri2NSXIp6jg/U95rFn9zLjBf8h5brFoTFJtxOt0vy?=
 =?us-ascii?Q?KuUa7b5ETelaa62HcDY4z5cnCcFpoP/YJEehKHhEEikiAlKKtrgYhyRt4b4Y?=
 =?us-ascii?Q?BqzjfItiYhzjZCKUVz+lMAuRR0x3UIM/eED4CXq3Z60mJWLmiwbadsRy0tPm?=
 =?us-ascii?Q?GMTEORnGxIHFgrxCNJT6+WlsKxxj759qwr/V9vjre6/xvRspIXtpvafT+cye?=
 =?us-ascii?Q?H3rb8LIejzaHdadd2N93WfISEqe5dZCSuTvCn059wUWQoQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UBbWF3j8xhO9mweyNn/NTrlG+I7mODFTvRJ18OIab3pc9IkNVV86t4vLBIic?=
 =?us-ascii?Q?IvEMv1x6kjA5b3U94aYpZFLy6urGcKUw6zS5gNI/NQkYtDJDMx9k/3uhZqqC?=
 =?us-ascii?Q?HmuYx8KTozRJFhbchf9rlIjKyDEt7pS3NO1xXS21rFF3SAoOpeg3z0UyG6hr?=
 =?us-ascii?Q?JFpSkHg5i+z4tEaguTn8I0yz9+az5OJz+v816DwNAZpMI8SeV5yn43B+BjOk?=
 =?us-ascii?Q?ih3THFy+yrk/1byWdHbNYea48cVP2v+Gf4p+ZkUBpmY6bR4uoIacc9T7cPhg?=
 =?us-ascii?Q?O++CrSgwrP72CLbkFQ1TW7e8WH8CLe1GTqSnRdnEC4Kl8AV7I15oW2+1K6ai?=
 =?us-ascii?Q?/suJKsMb8AbTpd6ulnOhfcHLIxUa6vMDp+arLAcUNFhSu364/LJhzHtwxv/u?=
 =?us-ascii?Q?KavBp5crGEzqEW32qikgtUQG2LEyqVVn6LSNZEIFW7G7q8p0U+KD+c7JhoK9?=
 =?us-ascii?Q?yJ7QIMWBGFyNA5jD7wI6OuW4bxvSYu43aXq98oYCpZ/wPa0/0hsBX8WuGroC?=
 =?us-ascii?Q?GgrmfK+2HynS1b2yhx+1GQLnyRt2ejl5LU7fmYvIQqdHHwVICrHSiWioVq5E?=
 =?us-ascii?Q?AQCeeXtgapz9cF/3Rtv1SeDFh7xQ5X1ULZ2CONTlhrircsivLfnPn2P8W7IR?=
 =?us-ascii?Q?adWgHrmntNByoqA6f/Jb/HxCezpGMlpGQ5hil8l8GIgMEPvij57emxHHtL6J?=
 =?us-ascii?Q?wDxWVd2Xb0CPwQnM9gFwd/ItAw3sXCChmd/UPwLPJQgk966vAKzLxYAoGm+C?=
 =?us-ascii?Q?rcDT2apfwcnp6kyAkSyxuj+SjqWfIbQUt4H7ZaNVdsSiZ7TG7R7i/TjO2ObB?=
 =?us-ascii?Q?RkCqF+V96cy+mAdN17e4e8T69UPkwYhzaZ3VKovpJH8NSq+Q/7GqsDvPUPk4?=
 =?us-ascii?Q?Bl8cDqpCVOG6aUcIbAfEupLfda3zC2v6+r4OeX1m4qpOoe+7A0yO+OEF6FFR?=
 =?us-ascii?Q?IhaJGMFZEA+YryLoI1xdPSQDoWzABfPuf5htLm8/IS8yx2DEeAwZ/h5k8xMq?=
 =?us-ascii?Q?oPVeBIsUuJzfGxUKGi2zLGITM4jloYPcQkIwSPiRqcbrew4SZGIZmVGq82BD?=
 =?us-ascii?Q?U6+eCMglQe5VI7ZUCInk90W11mbeYzRwtd5FCH76fMyt5gfMPi8CD2kHq4ya?=
 =?us-ascii?Q?bm5tRDmuUovwTetBVh6bwtqYrBubAoV7Z40iZtkR96Vrm1soLd5btdjptdTO?=
 =?us-ascii?Q?Hji1d0LvSkqLE4Yq0n+zD6mawi6rk0YZp/hQuiVEVCOpB3WfkUHgY/n1o6Gy?=
 =?us-ascii?Q?txHRPw0r02pe1cyJVAON3Irhl+ic9G3ETkqreiam2+Hh+LpOxaKD7uml+SUI?=
 =?us-ascii?Q?HQZglaURIqO5KoT05UjMOqGMr0/U7Ji+D9iUcof9flIn2MPAgtwM4IUeT9oi?=
 =?us-ascii?Q?M7cXqBPZNwZZVmKAf06dqpdvpakdIjvArPjQRp7aliwZo3rvXhEMQ0Rm3Y3d?=
 =?us-ascii?Q?vARyqRIM9/3ETnqB9d5M/iAbkJ0IGp5ilG62fr/bzPNbeo4icvfxvziux0BB?=
 =?us-ascii?Q?bUhr/exc/UhUakVWUGYw5NlnhhMpH0xthbNKJKV6Ei8lhi092WZduZlxVdKe?=
 =?us-ascii?Q?eVtbLDcrf/BxdX9yoVR8p/UX30GIBtdBzaFRp1eGbKxMrbcKFO9po7g4V/dV?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58334450-778d-46d8-464c-08dd163a6479
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 21:10:20.7528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3dy/UjjHKi3bh3hPXJtCff/fR2m8PzAS6QOzQespALQbcxBUXk7FQVZyay6VtwWV8Rn/1hR6VXyiE0FhS1uE6HHU43o26nWtRI7+zkm0ZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6672
X-OriginatorOrg: intel.com

Dave Jiang wrote:
[..]
> > As per earlier feedback I think we need to reject get/set even if they are not
> > listed in get supported features so that bad userspace doesn't get away
> > with sending them anyway.  This is particularly necessary as I suspect we'll
> > be removing features in the long run from what we let be accessed this way.
> > 
> > I'm not sure how we document the potential for removal of a feature that
> > was reported by an earlier kernel.
> 
> Userspace should query the driver for whatever features that are
> "available". Given one feature may exist for a device while another
> does not? So maybe the expectation from the app should be feature does
> not exist unless reported by the driver that it exists. 

Right, the whole point of this fwctl experiment is to make the CXL
device and firmware more responsible for honoring security and
compability contracts. If a device drops a feature in a firmware update
causing an application to regress, take it up with the feature vendor.
If the device violates the security expectations of the kernel that's
the device's mess to clean up.

Even with the legacy kernel mediated CXL command path both of those
risks still existed. Nothing in mainline stops a device from removing or
regressing a command it reported as available with a previous firmware
version, and nothing in mainline stops a device from cynically violating
the kernel's security model.

The fwctl interface lets the CXL driver document a security model on top
of CXL specification defined Command Effects, and then its up to market and
regulatory forces to keep implementations within that model. That frees
up the subsystem to focus on the primary functions of the device and
ABIs that read beyond "ioctl passthroughs that the kernel need never
care about".
