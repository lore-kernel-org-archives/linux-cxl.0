Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3DF235071;
	Fri,  9 May 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746808211; cv=fail; b=nwcVINX572emRtH3ikJboUxUv1Pk2Mp6uazVDNA13GyggOzLvPSNRxYX4YQG8s6z/aXY76hQck5lOKxMfy6uXhhmxriyaKPbSH+caUHYhK/XQNd+igKqRXC6NKnY/6cebeGHMVRNZfTaScgT9CZ723AnJHD+IX55C0a9JGHOC5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746808211; c=relaxed/simple;
	bh=2GfoyxixWREB8j9uN1ZxyaIs5+GY58jkfE6F3BwDmE0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fwdHdAAVba7/aB+wpDEAcpwLcOGWESSdRaujLO56fX/Mfpjq1tO5RJpfK6vf6IRdKhkRskgaS3qAaJaF051L5qB1PzAVvyTYQfXZnEo3ab2ClIFN3ALgwnYkF7HXfm8TCCTgB8fK4MkAsFzjGIWcq3/nztNxnGwVyv4Urpq8cuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITodAjqm; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITodAjqm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746808209; x=1778344209;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2GfoyxixWREB8j9uN1ZxyaIs5+GY58jkfE6F3BwDmE0=;
  b=ITodAjqm944qKNoAGLCntIu1qHGxyCQkjcqfviq9RHVnMZO9TiYSCJY3
   K9kZuM8bMQbdIsLIbqhn4iJzdyCJldVfz+CSbBhr063e3s/9/aAs9HPZl
   grxiUUtY3lAqP3F8CEUdB3Emsu6h8fJ5yLIrEpkaS8HVHi4AlC7UfB0TG
   qcvMKR3LNz9VtJWuE7W3Cmw/UbsI7/A9G+tMl6rV2hYZLDpis9sRqcHE5
   ItGD/poyFPmDpTGGWXDs0E8Ygghd8hrZITcQxSFRCtmOtR0dGrbNPezQ/
   S/dt+HiFyMdITWeLx9AnW3o1I86WUOZxhJVMVI3X/jZuvVyf1Abd5TS7p
   A==;
X-CSE-ConnectionGUID: noiKnxGuQV6J9idnoSZkSQ==
X-CSE-MsgGUID: h8/FWqmWRO6HbENmtiaKTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59989513"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59989513"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 09:30:08 -0700
X-CSE-ConnectionGUID: 7X1WW7N1RNWzPx+/zu2dAQ==
X-CSE-MsgGUID: IY5qS4X4Rq+im/YYRpEtGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136357671"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 09:30:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 09:30:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 09:30:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 09:30:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOt63JSbYtR3WDiWFgJUCIy31q0rGas5aAOZTtp0Kxd01+ecH1Dj1Z3Zg38JharwsDze4wyVBNNqrSXSD1h9UUs5M8VMYAlik4q0e0309nqw23l00RZQaQ5L0YsiK8lUpLHy9eNG42aYkUJBMi91pNIWNL9xNYEbZ9exvEcJatPlXyRCw0IfyBPPpkGVvlW2gvSbT9chkHvvs3qHms9S9dQh2FTdgASms6BhmKvHVmPEnShFOPBeJ80AdVMY6hUWNy6dYgDsKl+SItD7aIVeLNXkz5qG5yRvIc3wZQkMuAjLSTbArsQAETBUbelqRgvny7IZTdXyaMdOc1LElJGg1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2OAJQq/sF6PEWPhsvebMfVx7Fh+uYLSrqdAhcVCqs4=;
 b=V/IxGZHPlhJGB2ZVaUnYfVp4l2PJJLi4iggrVT6V2sxVPYb0+dqHnSfwWy4G//9AEzXryjAxCqE8JjXxqEu+SxmiTSe99W06YUT5pbfuSsXRqlgYRIjKNaQ6C/+udST69C0Z7vHVX4pjcSZH1fW9tqqjMCKnFx3Bokc+JSjfNBwYmMRU0GNlAg07L6CKb5+qVqC5YGP/hnWyhY9IczhIhXrSznfI0MUtBGjXb1wNgo+caU7sb8CzjY5NJ0D/Zt0wuoKJLDlDFjEi8siWuejbi+ZTgNXAWZxPurOfcB/md8jpbJ8PA8mfS9A+o3y2I1JCg9TukWVxJCe2RTgZVyaAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5293.namprd11.prod.outlook.com (2603:10b6:5:390::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Fri, 9 May
 2025 16:29:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 16:29:52 +0000
Date: Fri, 9 May 2025 09:29:49 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v6 10/14] cxl/region: Factor out code to find a root
 decoder's region
Message-ID: <681e2d7d4e63e_27eca02942@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250509150700.2817697-1-rrichter@amd.com>
 <20250509150700.2817697-11-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250509150700.2817697-11-rrichter@amd.com>
X-ClientProxiedBy: MW2PR16CA0058.namprd16.prod.outlook.com
 (2603:10b6:907:1::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: 061bd8e2-fa8d-4291-0a91-08dd8f16b959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OBmclhDa7XOVwAyMeYxcpeW8VIuhFKVes2Ki1WxTdpZIdjMIdp0S5AoiIInj?=
 =?us-ascii?Q?0x521g39HQlZiOQQJ7y1vq+W6c2qrETn9MUhcgIjPbsHuh2+5o1rWaPOTCSt?=
 =?us-ascii?Q?OiKTpvTcd6cs8c2RqS0lRH6OUzmXklAeeXZHUREWOA3Dq+1fMwZguxI7mU6o?=
 =?us-ascii?Q?fgaK0jhu5cpDH0namDBNUa/74LlfHoTx4k9Bbf/EEJ0IJxIeCjFiBg3QYLlP?=
 =?us-ascii?Q?rS4TMkeOUclHE5aOrwQnYVPs/YeSPaiv0GqxzHflehlU6uGYc+71Iyn2f30f?=
 =?us-ascii?Q?JDFRL78ZrtBFjcwBmSIVryQjQfZnvLegAiXr1VR/+RqmFMIMpPcqd8EZXugQ?=
 =?us-ascii?Q?/NpTErZfHK3Wc87AXb/5OWdTkADE7uKh8MXBJaiCs8mk3laFV8kj4L7QDGbY?=
 =?us-ascii?Q?6eBXCjHnrulmOYRFhoH4oHMCHnnHaWPzsNCwMONx9Ml1Qss7z7xTSkVm4DTK?=
 =?us-ascii?Q?2SwBnuEAKy6H4V1ACpVHpkBihz+6GRP8XHtnKmeSMZCLBj0H/NXEsi0lSX/m?=
 =?us-ascii?Q?XzvjrJ4UqoUS2FqV42rRsRajsvcNS/SqgbaghQBuhWUGMOoYmFxht8IqeRAc?=
 =?us-ascii?Q?iAOr52MuA3+7FUzb7S9nHnWqDrQwGw8es8O0/+MSgAmgxg8nRSpVa7WrC2Ev?=
 =?us-ascii?Q?yXi1kf7f+j8lLZvizpyWj45C6yvr10amPuJ7EnHNSXtZWmd8jXwWnB7J9fIA?=
 =?us-ascii?Q?4F03eLO0Qgqucu5+HqBo12qCobtpmhDYppZwBFm2qJx1PAKHqny/fSPRVL4c?=
 =?us-ascii?Q?06hxCsyfDJgabE9kSsSiaUbqb8zlyDldKnDgL9AEVx7MWFU3HdBqxWqrRReU?=
 =?us-ascii?Q?1beTIpcz130dt2YM79n4I+bnMc57OZ+q3b8YFG1F7TodBF3GyfVyQC/tm/We?=
 =?us-ascii?Q?aARIPNRhrjfS5BMXMaYVX6PFzZKBqCtJGdRQ6Hj3+kskqQv9aAuuzodYR/OT?=
 =?us-ascii?Q?ZAidMa/7qP8GyOKkC/3cCDz4SJNhyeDBekPngK1OCDeRzcU8XLqZ7sW+WpGd?=
 =?us-ascii?Q?MOXni14HE8gT4R4S67seCYQYs4HmZfD9Zuzs1lUM0PMoI0SEwRl0hRm/SRvS?=
 =?us-ascii?Q?PbWqAa/pLG3oSaD/4tYDyNWi8q/ZB/IhExNE1N8unxddP1++QAl9yDuna2MI?=
 =?us-ascii?Q?fHTKFnR9kOrDLrgVnrOkwexYe3arUMIl3izTbXHRkkYF6Cb9uRQeydJ2+rwp?=
 =?us-ascii?Q?aUI9sflEmxhEQioDShTh4SCp8HOqInYJHppCtvALNySNlAmqnFsGWa1Bz/YD?=
 =?us-ascii?Q?Q6KAk7J2MUgUM+wBZdclNQsjUXqgcBZufJOt5XJ6lXP9dEkGd8uR9/xm2Qov?=
 =?us-ascii?Q?gRjJq33hdFXcmirhK58dT/JnfdV9eN1dDPXbm0SNscqwJ2++HteerAynKK4a?=
 =?us-ascii?Q?A8Lrn/4U+m6jv2vEsZyTZdhKiVmuY4KKvbVc3yYRC5uoR4vUDfgdmn+IbQv9?=
 =?us-ascii?Q?SEckhjpbeKY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FQ4jnlagzhq7YyQqF+PGYMlH7AB2716lxLIyWmT0odOMtSm7rKywra1U/LOR?=
 =?us-ascii?Q?DkgjAm9RQ/v9Ow4ISKIQuiT2uVGhSTqzOUbyIw0B4i/olY4p+sfxdPHhKbr+?=
 =?us-ascii?Q?IcGimuCsHcjt9tDhZrgNPx07S5w0xM83pgFVVcxXhqby1VjP8eLtuWLKs0YM?=
 =?us-ascii?Q?nJ6YLQguR9p1f9yfl/l3BdJO5F80cJhjS30dLfnuzDqKijBFWJNMrV94JI3c?=
 =?us-ascii?Q?/xVzXsNQtFdQkMDA5vhptYHrU5ciI/bljTscPXoSyvJTkDox5uP4MY0T1/3y?=
 =?us-ascii?Q?xch6nOSx3oPvdv/xuMWHr6IjpO4SL83aW0JwWSoNRgIjz7IfzQw1+QvKfrIM?=
 =?us-ascii?Q?mr4ShQHgp9AA96TgvK5jA3jKap2ssNATu+ksi7Bc3CYVXgoq8FJMwR6kxpd8?=
 =?us-ascii?Q?+0jYKwOAC1eiV9dMbVXOAVUqhagzd3r78LToiobUHyWVQLO2CaejH/57lQPP?=
 =?us-ascii?Q?m5tsBeBAMvgDHdf4feMHA+V8TjqaLEt8ZqsYjU5AR3ylVdkC/Y9x+CLEhnFF?=
 =?us-ascii?Q?0vALyyXowURtUTWYRNM3KfFw7V4giiuy7Ie1vJl4kRIyJoo5vWto7m0ZNFJc?=
 =?us-ascii?Q?bEn3YjeyBHB7w8S/mylN9CJupTVxQvCPc4P1PosOQ9Ns0kHxt8a1Zvxr9aHe?=
 =?us-ascii?Q?l8PjO/dAenXiOl2qJhWtJY9pW1IvV6bN0y4bTsdE9rBVIBHkpGiaqLfq2Xho?=
 =?us-ascii?Q?ts7qsZ/A+BDVFsRFmWIvWTWtni+joNNwU0kwR08iTgY+8kE7Mc6Omk+ZN2DY?=
 =?us-ascii?Q?/1neo/1+K/n1HhwJIz4S3OBPAO0HYXgzi8SuaIkGcsDOwQzQrroVSmSV/GSG?=
 =?us-ascii?Q?iKw6eG+rVagZRAFeDMF/H5s+NYFDtZtjuNAvtJdQixLoC/JtDRRNRzPl3s7I?=
 =?us-ascii?Q?BZFV0wk9iHwH92qXFrqUkvFtzy86oZsIwlemsNW8voCDnWPebxZqwxHxNzJ/?=
 =?us-ascii?Q?cqUiOEfDGjJ6Sy/hFHlvClsEcNkYFkIYJ6Bta/MOxH2lGa+gYDFEhcRgadxV?=
 =?us-ascii?Q?SiB6ohRuygmlKNIwIeSmeNbmT7b0SLTrFdCGtVz7IQxQfdBJjTFpuqeHp+wL?=
 =?us-ascii?Q?PXHoII6prbjWLnPYuL4lrd5/imAN0w7qoAuqTMVVDOTvHmIVJ2RgrQBwkYmL?=
 =?us-ascii?Q?eEDS9nC+AhQC6Xu32Ydk0Rt3nrIMr5FBJIp86cK1HM4d0XTGiJdo8+gkmVG4?=
 =?us-ascii?Q?KKl8RQuGHJZG5B8okOadd9mCWqkgPgzqHQetRMkcwooTLh/x+kPAlq1oLJrA?=
 =?us-ascii?Q?mZvuQUYe37xqRYWd0N5vqsIWCCpX4c0WaOMnIdqa9Eq/dpMIqrUI6K3PdXWL?=
 =?us-ascii?Q?4r7vf7wmHsM0X2rYTs4VLQCKeMDlvAiynt12+8uf9OYHeNJ0DEmwNROc20vv?=
 =?us-ascii?Q?kH8PQG6utHuHlZh7SzacYIvdzjJiDWQdnk98IFQ0HJKHFCo0Z9szzMBO2XHH?=
 =?us-ascii?Q?NpP/luL60hAczCXsKaVDWiMnQvP/MgkSCymvXvnkRyskPasnf8vRiGFxdJK0?=
 =?us-ascii?Q?lfxd/xNxsI0rLFcvJv6RJlbikJSjQL90X87+SthOHiH/VvIHY11XsItDU2C4?=
 =?us-ascii?Q?ZpU90/JbAFh3qnqcOqSNrySl8rAKdnd8iNpsPbo/ldD1KaqGirCRpgyA/iYR?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 061bd8e2-fa8d-4291-0a91-08dd8f16b959
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 16:29:51.9941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fP91+CIL/THjUbjum828kK+wH/2pt8hYIiqrXLgaOv4ESRpzipbwGHO922nMA+1HQz8mTmuk6mkTuktTP5ssfYcc1l+zLSlMJoznSBl0nDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5293
X-OriginatorOrg: intel.com

Robert Richter wrote:
> In function cxl_add_to_region() there is code to determine a root
> decoder's region. Factor that code out. This is in preparation to
> further rework and simplify function cxl_add_to_region().
> 
> The reference count must be decremented after using the region.
> cxl_find_region_by_range() is paired with the put_cxl_region cleanup
> helper that can be used for this.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/region.c | 26 ++++++++++++++++----------
>  drivers/cxl/cxl.h         |  1 +
>  2 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 45f5d2c7dfdf..8fdf03058b2f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3405,13 +3405,25 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	return cxlr;
>  }
>  
> +static struct cxl_region *
> +cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
> +{
> +	struct device *region_dev;
> +
> +	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> +				       match_region_by_range);
> +	if (!region_dev)
> +		return NULL;
> +
> +	return to_cxl_region(region_dev);
> +}
> +
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) = NULL;
> +	struct cxl_region *cxlr __free(put_cxl_region) = NULL;

Another instance of the "obj __free(...) = NULL" anti-pattern to clean
up. The reason it is an anti-pattern is because it risks mixing up the
assignment order with the declaration order leading to subtle bugs.

Scope-based cleanup should always be exempted from "x-mas" tree
declaration cosmetics.
