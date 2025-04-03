Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D61419A9;
	Thu,  3 Apr 2025 02:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743648068; cv=fail; b=LLRLyfbD6chRnQV4MTt8pu6uMbW5FJc44fDCQArRkCz2zIr3SPFQpGXikZh/D7Ivpf78/Si2eOV0FzZvb1YNaBhLdRODvF1FzwwmBeO5g7ylbwbqtxnh7y0YORcvYDg+SMqrSbQJwrLebhKDROR/HbnWtK2BDlByVOvBc5mGfxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743648068; c=relaxed/simple;
	bh=dtnxtHe9EtKNxRLHGOV2ebtQQfjzb+PvUFckLtdsCCs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VS8l2hF/uSI2pvzslr1KadJuAsbsD1OuerGTEoANJijF/i5wB6SvzkYsTzxKsdy3j+/KdhTRk18k9JAicblUOpXRt0ZKwUqvWjeXGwIFGtpFSZbBz2SEl8m6Gw6F0scfSsotquUo1RYIwkL8HSE1etT2Ma3S44PODgWEWcSQBMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpJO/kLF; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpJO/kLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743648066; x=1775184066;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dtnxtHe9EtKNxRLHGOV2ebtQQfjzb+PvUFckLtdsCCs=;
  b=YpJO/kLF8xS3UQ487jFbz6d/TSoFFlRa2n3yzXVNSU/XCHMzPgQN+DZ7
   fmrKlx381ndgSPusjnhH2dEUs25Vcn5cAmWieBsFXSTuKnnrIjIHl3a5Q
   X7vlWlCxiyY4ebOCrch+W0+4aKA7/QUf4qk3gKS/2vG0e6SNealKyUu2L
   WlCa/04yfbhZugA9nPRIxZunkPfJb9rClwZTmMnDLA5jfG1Fx34P+UlaX
   Gs4vns50mM9sLEBGJhYAja8KC9NIhIRKD46lE9ecuoZjIs1ZSwKiE0j2S
   2EAM6CAIWsa0dVH95sp1xzZZlY5KSZ3ni0WnRb71SM6q+KJLX23lrm5m2
   A==;
X-CSE-ConnectionGUID: crz7O4xvShKrcLpWspvVPw==
X-CSE-MsgGUID: ikgw/3iuS+CXjA0pQT+D5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="55234561"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="55234561"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 19:40:53 -0700
X-CSE-ConnectionGUID: Gd1n/IqRTaSFu6XAApqhIw==
X-CSE-MsgGUID: KewVaKdXQdi2cHzGjqdT2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="157822008"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 19:40:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 19:40:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 19:40:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 19:40:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmG8b2OfXxPXfir8o4BrhDA7vYnMRwGBHW1dCyzYERNUHMY+XpGk/pvMsgTZksRdU+WaavixZ2wSDMQLP+RpgdtqKHGbL+LDVZcSE05rjiO5Ac4HGcQQbaPfwLtTxcQLQNsYMAQZsUFSGNFTAAOSZ5LyhEzRTPorOjiCO0sxFY3zjkDH0JjP1OChTjkcBlopY3O5Y9BTcm7sZE4Tu/385vaQj6BZkJgmXZ3D2rEu92IbGa9gq8Uo9fEM/R0FsaY3Whb2fTkuGB1EohEl39ZOuEZgO8izwqx6YhaB2p4sVwQO+DnIQvwMFQGUoXWvzeDA094TkQ4Q5xjAbEozO8+CLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFfc9Fzlm/WNaX6RivVghc5veah7LiB8LUyC1mJHi2Y=;
 b=W5OulovlkouIG9X5jYUCRtkuC6b1R+3vRScojbWC9KocYIytIdqizy9yV75xNIAQjyXlN7mb1EMpM+OLO6xt5iX+DLRIn3oglbRzFqiBhHfUwM+E/i8PItjgvTduVbP1oYlno/S1RCRrWN/n6bm2qR9ETBFFx2+DIQ4X2YXL57BgPW98RGS6aQDkAn5CRo7wG12mctr4FHt61dz6loYVz49CqCv7wxwa6lQ3hrBwC61IjBx3iqvKeQXOpghDUiBhv4dXmOxwsXGzVlGt6nvWvli+Pa0a0Ti6YF3cV8bHO4zuEQvSo0QaT/g9ut/22ePKoShhfaYI8tIpwzcpfKp/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7940.namprd11.prod.outlook.com (2603:10b6:610:130::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Thu, 3 Apr
 2025 00:00:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 00:00:10 +0000
Date: Wed, 2 Apr 2025 17:00:07 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH v2] cxl: core/region - ignore interleave granularity when
 ways=1
Message-ID: <67edcf872e1a3_1c2c629460@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250402232552.999634-1-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250402232552.999634-1-gourry@gourry.net>
X-ClientProxiedBy: MW2PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:907:1::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: f34767d9-4aeb-42aa-638d-08dd72428009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kgBF8CeRf3C1aif+dMl7H8X9PTLVnodO48PceNehcNHlhEPEGr45xA4vADPI?=
 =?us-ascii?Q?23+WJplyHiJfHMT35IsHHolQdZJbWYiyBs+OblY+YkB/DcA+GtFTiLelDsFi?=
 =?us-ascii?Q?UTQ4azjbw18XNXEjK8KeChKGyAMLWhUsypav38u21jtAt6vRmjF7YvWXu4Wk?=
 =?us-ascii?Q?oqhJ0jqF3aMf8PpChyqXIidSQdWFSRg7zqp6StyG7YK478E9Gqw7eL9ftv4C?=
 =?us-ascii?Q?/uFCpLCH4soUbyIRivaSEygx2azFlTtx3mZDWvxiYvUJs1NfzTdL8R49KEEY?=
 =?us-ascii?Q?gyBIdOj0ysETPFduNrUk8f5dnYoOjvTQWbx782XL4SEszsdgJ2qKEdFOP3aa?=
 =?us-ascii?Q?7+v4FO6oatZP1Q/2/yJcEzjNmJIU7NoZdt4ORdyo1hKaQjboselSFXeF4BdT?=
 =?us-ascii?Q?Wt8K7OuqF+dfnVT1uOyMDmfhJTZGWEJrhWpqSiKchiCcbOXfnKJ4GjBvt3KW?=
 =?us-ascii?Q?afjPgxVnDlq/Urr6ZQC5d4R1dHdPhW4QTsRFbwS+yo+tu35FMHVLmXpOiGlf?=
 =?us-ascii?Q?G56Ec6pO/H5YjH/mgXNFzRcw809H/ywcc7DpW5DLH3VeOJDvHN4paR6ofR8/?=
 =?us-ascii?Q?iP978KxjtOzr0cBiHfaHQb6ISVdpJR6MSAbmqUVCxgSvvS7Y6Y6AlglCUQds?=
 =?us-ascii?Q?kKmDlS+mI90Bf0fHUMaH1quopIaQhL4Xqd7lS70YAgABEbfmnEnlJlxsXlfc?=
 =?us-ascii?Q?uBSg+yUrXx2rtK8UEnotNvThiViw4zw8NZvh3595DBTQgf+zhfB0QCey5+me?=
 =?us-ascii?Q?d1/ouf+SW9fdaZPQ2O3SfK2/iJtba4t+nt3PI1Vcbd++PXeshKNTqL8QkoIW?=
 =?us-ascii?Q?2RAxeNQbi/9XOOTWgnU2aVWNVaVXVNvrg1YbSqoc+g6+rkjvR6euv1my8bQW?=
 =?us-ascii?Q?vbBn5bpZkLx5pu5NI6Hi5XYR9DNckqwLzhtBsg2rM8BJOoFleM8fcWrYBQWM?=
 =?us-ascii?Q?jMTZyGXO7XYtZ0l7uFc/dGgiIL6uDxZfTx/vGB4UrZMzeAEi5YYfO7XrZrHW?=
 =?us-ascii?Q?qAkdNbmZB40uARtAE6BnjKuMzRvfOGhfe7jfvDergTq2nslBxzLALY+Pwilp?=
 =?us-ascii?Q?OGZT998UTU/J9JvdC8dW6sU7gCDarJAMLQJaZOxWtTMZI9c04zcHpfAXOScV?=
 =?us-ascii?Q?ERKxj8aFn2ik9J5a/XLFooToZYKFAqSTfv8m6ucGr0gO8l52EYD6x0P+Labh?=
 =?us-ascii?Q?e8eMQRjOUQd62efh7+ViRUdzb2pLwymF5VU6WaNUMaS/BF6QdYJg+p/iMt4L?=
 =?us-ascii?Q?oMgs/JnjbHiNNOaQqbNrjLlhVuZJLNxsVcSZHTR5iiJROoZx1voNRJ9WqUap?=
 =?us-ascii?Q?/+5mJs/DIS94KVlDn38sqOjm+DXqIygz7ClRjKYgujG6B4M7NBLTJP3l7ciF?=
 =?us-ascii?Q?vk31dBrYPTdXyYnE/ay5DvcTlZsB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TOj/Fw6BkScmNoc4CCRpSW1Z6xDXaN6buewAl7xRog2wRWewgkwC47o3e/P3?=
 =?us-ascii?Q?AGAwjRSJTaAfVGvdEAaWATf0kSz3uQgUNxyGHOuQ1bek/lhBgnVvhQx/g2uV?=
 =?us-ascii?Q?cngbRbRYfK5JkcMiveGhB/wpOIzHJAqm8R/sgxjXl8Qq6loKni+FLgYeajwe?=
 =?us-ascii?Q?oYh/0FCqLHYJmTMclCX/bew5E77qX9tbQMJ3eBC4nCF+9pcFezi2yHY3ntWB?=
 =?us-ascii?Q?s+UHwRoLNIRdDFk8EHboDZ+FkZjbXpeRyDkO+nGiBAfj/IQZZBvgq9xsBB9l?=
 =?us-ascii?Q?Vx+RnVJ0x9bTFzL4WaR2YEi4ZAEb827wdV7OvVTs/yaSLWKu4zc5veDqj+Vr?=
 =?us-ascii?Q?G8veQ718egYxIjaEcYOqIKSZJ2Qx32T0Lf4sEHf+YMB3lXNSM2BwR5sLSU9+?=
 =?us-ascii?Q?6s7XTVLHRBnae35bJJEKrjCAV8iuN9z2Eu8vTZx+f6cm/xC3oVdPp+XiXZu5?=
 =?us-ascii?Q?GfekdQLVqjZ25WvrzdNHsv1JzYumbHxV3GU/nxJ4QlSr6xs7dHLxr+r6PrUY?=
 =?us-ascii?Q?qSAyGJ0Y6UxmgUkEszIKXoCf8PYAj/obwj0psusxJ+uXjH7SD87no2r5o4Wx?=
 =?us-ascii?Q?EXPUGoFwPwf/6i4A41ltbNCmDPQlPqSXME2ZtD2Drv9TkgZMdpskbLZ/rEab?=
 =?us-ascii?Q?RaGETsyVNDFieVIxVzvmPa1/hT9GgpltJQF5uipW1JHTQQyyqqpnnVsSRapE?=
 =?us-ascii?Q?rtePUXgD+6KIr/OIcDi3FdtjriE+6BQBF3HrHJX3dvTa2nx+Hd/f78tFAW8a?=
 =?us-ascii?Q?/ofOH1snJcaIgGyNbZdVxEzCTdPYyocEy0uRDgVkB0yyuzC65htGRMXtYqL4?=
 =?us-ascii?Q?sOFOQcOhcDE9qhd843ql8/mrngj92IuxJS3Ie8nVmkjFdCYYlyLJ0Z2CxEcQ?=
 =?us-ascii?Q?USg1N/7ylrscDkwIgPYvrJXlE3atzVJQjSUeSWNn2R9XT64Lu/QxB0GQODOf?=
 =?us-ascii?Q?dcRsEyeHP+YP0Ma1kd/Sg/bxIEMzsbgmmyyJ8Mg28QhfsEqegidmLgmtcGv6?=
 =?us-ascii?Q?8oV71ENCDMjt3msrrudCfA6A81pgZPlZQjgfNAPKP8XV55DpWPyj6It0mymy?=
 =?us-ascii?Q?YEN5KbZPhu7U6DBHPEILLLp+iRJwcOm8pxehKEOqOf3d3TZnc37xAyl3nJlk?=
 =?us-ascii?Q?jv8pZ9w01bZzElKYO4Fyz2jF2LwrKfe2JoGaq5OpjD27b0rmhSuEjErOLH0U?=
 =?us-ascii?Q?djOzjj7i/PerS52YZK8nE3/UmP8CrFHEWDohE4d79ZUumqV02UBvx/JF8jdB?=
 =?us-ascii?Q?lHUtb50V4dTJ1MsIGbHqB18PO62LjkXnvpjYmihqwdG8myup36U4Of69mTb9?=
 =?us-ascii?Q?77yHG1Fl8OSXDDOPcl57o4MfX6qGUZfsL47AQEEs2HrLxgsHIeqAmw3EG/R0?=
 =?us-ascii?Q?QAsvErh86nmu/MIoTcfGgiMHXoxuwqbyP0FpdTlR12XKxhfGTEzncowqnR+L?=
 =?us-ascii?Q?52SFH/Z9lraVJgyQq7DzkjwnVxje35gH299pwlUVb8TVRB1Klmym+dzYOZ9u?=
 =?us-ascii?Q?BSut94C9YrNLPVWM48z0UjBkcj1QTB7xtqZEiQgS9LYlFtzG0K6RGCP11wJv?=
 =?us-ascii?Q?55wjeJenlBRlX1dAjwQf2k3PKnCNElEkAAa1GZsVA6MtUtjIjP+CZE1vNZHf?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f34767d9-4aeb-42aa-638d-08dd72428009
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 00:00:09.9723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HG04sOb73zdybSH8A+kE0aidEuOX7QcRt9BHCVWVpHg53k0B12ffdK/0VIBpLzgL/b/LafY7cjA5hcynQrLOJcv9lY2GQmdJD7qDNc/aZCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7940
X-OriginatorOrg: intel.com

Gregory Price wrote:
> When validating decoder IW/IG when setting up regions, the granularity
> is irrelevant when iw=1 - all accesses will always route to the only
> target anyway - so all ig values are "correct". Loosen the requirement
> that `ig = (parent_iw * parent_ig)` when iw=1.
> 
> On some Zen5 platforms, the platform BIOS specifies a 256-byte
> interleave granularity window for host bridges when there is only
> one target downstream.  This leads to Linux rejecting the configuration
> of a region with a x2 root with two x1 hostbridges.
> 
> Decoder Programming:
>    root - iw:2 ig:256
>    hb1  - iw:1 ig:256  (Linux expects 512)
>    hb2  - iw:1 ig:256  (Linux expects 512)
>    ep1  - iw:2 ig:256
>    ep2  - iw:2 ig:256
> 
> This change allows all decoders downstream of a passthrough decoder to
> also be configured as passthrough (iw:1 ig:X), but still disallows
> downstream decoders from applying subsequent interleaves.
> 
> e.g. in the above example if there was another decoder south of hb1
> attempting to interleave 2 endpoints - Linux would enforce hb1.ig=512
> because the southern decoder would have iw:2 and require ig=pig*piw.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks for the respin!

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
