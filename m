Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9C227BAE
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718845; cv=fail; b=Hjf+zjVk5B/wMkeeveBKNlSJ2selTBgla4GVZWoyMHKm5Zc4ZSONrKHnGXrv9/2R7N1MG4diI5xGFlaOlMXm/lKYsu/bDWmMOFwATVp/6d9z2Xa13ijjhXL1nUKtc9WJQ02ZV1UX/YK+lDlVCM4OnbYFx3kV1LAk9vSY7zRizmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718845; c=relaxed/simple;
	bh=5OkzQ5HNCYW3pAhlTUs0nx7WK2b+tGiWLu9G3QBquI8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SCNU/mVE23lqYuofGhtbsng4S9AKjDR9lHEFKCodMtqU9GiOerRp3qdnAPv52KR8fWbBMjmK6IuIKevrYgxBPV8m8IO2lOl/PbQeDPq1tVLn5hw+/wcUXpejaRrWkVAWv0vU6oTav5yVwOq+Vn//GsV+kcnkiURdEE4S8CjHBj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5TwstqY; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5TwstqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738718844; x=1770254844;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5OkzQ5HNCYW3pAhlTUs0nx7WK2b+tGiWLu9G3QBquI8=;
  b=e5TwstqYd2W3UU0jN4R2mTbyg67FLt7igp6pc1s5S95THZ/dj0IfcxPT
   oraCBsip4ERXZj6GCmzvpnXVkI1TS+YafSgBnQp51JViW1zVQDKfrHrat
   V0w4OxS8YP5Uu9wvAPAFlCWTGI/F1ZrnmJ84lemRh3OL3FRnfQbb22ws1
   lT33Oq4lpIg8ZHg1z56u5SKTYQywXe0I0qSNhKqiM8VdEdPJkhTbugmEh
   PeqO91kGLtMMf4/82Pd4nBG/wx0w1EVsgdPjhsknuGghqQwtQepCrWKCV
   9BFTy+LIHQ6z7b3wgVdi53sq6ltRxyq5ySDV2KYfFuHoUIWzHCDssD9RC
   Q==;
X-CSE-ConnectionGUID: eXfjySsWSoK20yHiGpZmRA==
X-CSE-MsgGUID: x0rptDTZRmKXNIUsZRx+IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="26873248"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="26873248"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 17:27:23 -0800
X-CSE-ConnectionGUID: vDgH/DIWSzWrU932Pq8W3w==
X-CSE-MsgGUID: oXQ+tnn9TDee6HTC3nF8Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111637413"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 17:27:19 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 17:27:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 17:27:16 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 17:27:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0hCKxIlLu7rKF+vEnUEX7A7zSXLS6LylnwDmHnjwn8Hx+EKFlOrgQtBMnyyrqwZ03PQQ9+JP50aylirlnRCThFumEnVAVDhXRw1SIOcgGIjx+WgE4NGvhTwGh4gpjpXyQQPGd1Xzk+VOcYh8RQ3fNickUtKuhsXehYaL2lLMBDzCeIIxk1h3EqxSZhN3fxg2oujlE8TtXtRdoosHWTqbRJfdMs7xutw2Zi8oP+pQJDFkjs6gZga61OJLZW1pFCSqHN1cY1I+jMiob8ZbAaDhuUtEOlmvB8dVVOObWVIZpbxDNuoN/bG+sGtRWgvzXDwY8IZRNbxx75+PPIAjLtrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2n+hEW+kwt0sVVQU8NkMav+eNJGtZJ1uODrb156D10g=;
 b=bOMBJ7U5O4bUBJdUosF9l3xvfCbeyae+h034rWL3QNMCcEseQxUMsjtG8ci9b+UsLxmQQiP8ap8s8cRiQGgP3/prrb98xMsyb2ZYM2ZwoshaHGzxSeecxR0aNXpq9mdsRJGjk1LuEYLn+CilqaMhIYWrAUyVUjOzGJ8VGJQEc4q4BEWhVuZfbxtuuO19a+ceCqBvXKQm+J2hs/K+RaK+j4+sUbqzhS2HEIAeJrIN+gPvXu1kSs7T72T9FwWxc9aSoFxQ2qNxicDyFlwBy051pSa/zTp/8tnmljw2HTue6ehCaMzbfkaUnPhJ55l3ZLxmufgC1zX6aET+GQqaAseZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7801.namprd11.prod.outlook.com (2603:10b6:8:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 01:27:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 01:27:08 +0000
Date: Tue, 4 Feb 2025 17:27:06 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v3 09/16] cxl: Add support for FWCTL get driver
 information callback
Message-ID: <67a2be69ebda1_2d2c294cc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250204220430.4146187-1-dave.jiang@intel.com>
 <20250204220430.4146187-10-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250204220430.4146187-10-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0385.namprd04.prod.outlook.com
 (2603:10b6:303:81::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6bef0c-ba88-40af-15a2-08dd45843501
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BMA2RNhv2oOCpPKCQUEwufeUzwMPXgFzhUJBWGeWszqWDn/71FiZZ+LsNDHJ?=
 =?us-ascii?Q?jL5nyhpIw15pG8ANwBv3UkV5PawIH/8+ycgalU5VmtFLsNwQCzoYIiX2fuir?=
 =?us-ascii?Q?gdi1MrokSpwILL4Y8PmhtcpScAf2sZ7mayRZjwXiHSL6lM7ws7a0KTIjp7h3?=
 =?us-ascii?Q?LRN8IMHotAeLJhoM2zDUqzGq8FSBO+H1/A7TJskERAnuGWYeiqxb9MwWJZkp?=
 =?us-ascii?Q?1CROIrM+5zUSQvbALh/6vDaWTzopoYAjXkscEfOcWMnmkywRi9JOCdXyMzlq?=
 =?us-ascii?Q?KFvjb9DCHKsMyaPYhm491dK+sesbbqNs2qjy0tZWByAmLPEuapwscvIPeU5T?=
 =?us-ascii?Q?f/1LfMES6QaH8Uv03qBwSyV7dNoPVle6Ik9lGq0UDcDUCsSsWBTvKSGv1xjB?=
 =?us-ascii?Q?O1TwGgff+o1kMPPqq8SOdlkajmmW3lBXXcPDU+7UjY6tpfNxy5qlcFODriFI?=
 =?us-ascii?Q?nHyc7C8nXnl52brFu83wNkf3hkLihuD6gj1FHO+LdFESxn5u9JJ16ybOY9g3?=
 =?us-ascii?Q?SdInOk/YWJQrfS8YRl/j5D2TN/eK8rUgX5rzGunraD/ORMDNHuUK5mdn9v0F?=
 =?us-ascii?Q?37nMAzQ7wXECQ4++liemN7GaAKj8JKFbq35Ze1mgBRzzJqqtZqAIODnwEW7K?=
 =?us-ascii?Q?JggLdEgAfFuU8qNczTQXd1afAKuonF9RI75+vb6bH96D0hnPzm4xdvQ9emqz?=
 =?us-ascii?Q?sMbNe6lGS9XZJtJh7ggBkdfn/ge11KhQyzsGJ+OfxYiBjmV5A0Buw4WCrxvx?=
 =?us-ascii?Q?gOA8Cidg7Q8nDefE2bHzp8KF7Z7wHa2eYu5P4luKeqhb52tXmMSbO8a45NdI?=
 =?us-ascii?Q?prpc0904lHmGe4ZSG8WUgQ5pCBf48JquIrrEiYO3bOcsR3KaOKDqDzDjkBHu?=
 =?us-ascii?Q?Gd0Xig7heovt9cblI39YVZy9kxpm1JWhO1l1mU8CHCVdBgcf1IB9bVUm46tq?=
 =?us-ascii?Q?GnNDPBVu3k3hVV0Rew8s1zoF1lzRSNvHGWHWzcklTLyb32R+p2F2jFAXL5hm?=
 =?us-ascii?Q?Menqtw1JieT60nxR8UYc3etdKwJZnad3PhmbrYX6kokOtPC2ouM2rzZq2tBP?=
 =?us-ascii?Q?bnuyzC4WfQLRtKDZEZ+IZo/xUIQkm3+Mz/vw0q96wlpMwZp4ACJ8Sntv9qHp?=
 =?us-ascii?Q?g4EzE9+MBv3EQv+HlyNkFYel922ps7eqkiF8xXcsMprMy0iDmqmlvg+0XGcc?=
 =?us-ascii?Q?J4Gupzf/5Arr9zzNfJItltPNG82OaDTx921iwcoJUr4kPsEBYIhXJsxfggBz?=
 =?us-ascii?Q?Vq/zkQ1nD4gYLPJvV2qi/SnPysXxocfJSD+xvtxqDSjE5OdvAWodNoiwF+JG?=
 =?us-ascii?Q?QI8O5Kks0aD1jDMsuPrrZctQSid6b5xuCBOrXFluq0nSxgQz5Cyo8HHPlzUM?=
 =?us-ascii?Q?4b4EFC+J5EgW2MchvN4VyXL6PlKm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VgJgsS4IrAtncv7cmXiyJ2LO4mlfsBYhraq26lfcgk4LiaFvFIXrAa3F65tT?=
 =?us-ascii?Q?Amnv7tDZ0GlfcemmmDf7UKUiCB6kUtn5t9HIZYxph9Jw3KTn0QZL+pg5lsnw?=
 =?us-ascii?Q?oEUx4MJYoCHIGDfYHNQmusZi7HfPoGWJp7EHFflTAJZWRzfC+1F0bxwIvT0r?=
 =?us-ascii?Q?0P2J6wa+PD0SgTfogvBK1yvyvmDqZV6/Kry+0ZoLd4CN5J6/You33pjSnVWq?=
 =?us-ascii?Q?rxNPTp61hYGNsiLkX1Fvozc5Owwv38fjE2IDfOW0wcZBWL/VAzq8FWbD9Qk5?=
 =?us-ascii?Q?NHBB09hkGpGGkuaSTvhy5ifr9hXRVs0CdlyHEBEDSwg4KyA3DQTsCcHjgQWN?=
 =?us-ascii?Q?JQD1QrGg+kziPz5OilCAdy0Z8jzmPNwK0CFOVGPPfJ9QKD5ExtSqITwpIr/7?=
 =?us-ascii?Q?+wzQEdE1H/ycjtcLXeHLIqIYtEAWKF5DpOG1y7BlbmPCugoX4CMjpP3bFuHz?=
 =?us-ascii?Q?3chS4VAYw0Lgviv6h6BVAH+DE4LPqM/PcybTImiKfdsdqSNKv9Of8WJU+ZBc?=
 =?us-ascii?Q?lZE/1ZDQVk6C+RI7GTjW2lXYfeyppUicWc76+r4YN+/0js2nIxzeFT38SN3S?=
 =?us-ascii?Q?X6ysoR7XCGYeQfpHGKifWMjb4QcIhDJHniHrNMiVmc+TxByr8yE4HNdBBBDr?=
 =?us-ascii?Q?yacHTqc+OkQjyJI3+20wE0p1HIblvReU8PS6vm8Wmi5HLZXV5KAIs82YkBRD?=
 =?us-ascii?Q?NyaRdzdH7+G2WQtBaapwQOmC3JcLBfADVpE4FiY+gbZDR6AgFtmoBScBZSgG?=
 =?us-ascii?Q?QXXIIdteeRBl38J3vDInT9ZbJPEVTERqc9W0NgGvagD4/va03yW2vipRHRhQ?=
 =?us-ascii?Q?/puUivxvGWpy2oMgSV6k7XnUVl36zr0M+WqRZ0Jdj1K1keIqrjxEwroVHPXw?=
 =?us-ascii?Q?hPPUGF87DjwaG7PFD3PIUDiOovdvvfKZqlSQiZ2F/7VCdXzDYEtsKrfDwqC7?=
 =?us-ascii?Q?27/bLwr3s0iesnGLhzm23jDVRCjvta9zF6gjC64V08sLNVvgvbBYTjOT2DBa?=
 =?us-ascii?Q?eEOP8ctP4Lo4gtT0zZ3lhHkdWq+oizgCLseu6A6ecK7hb6gWBqcFmk7I94mU?=
 =?us-ascii?Q?Cc59CJAVLENqch9n1w1cG2DGFDxeOXgWZ6JtV18SoAFh9P5ivoQrbZNE9xmi?=
 =?us-ascii?Q?RY62EkZ7URJLrA03wpS9BRSIiNkpCSCB4HvS23Ols8/aq/oPlNiQ1Qwr4q83?=
 =?us-ascii?Q?9gHJjZB54G+LLK/5LjITSzbUsSKb48GGx9OyFRCp0uejWDmmrODlcy0PafjL?=
 =?us-ascii?Q?H/4H8bPY21rlECkrlmFcsn7ZK+1+Z+LtG/7FCssNmITDGCs8v52+7eKio0XU?=
 =?us-ascii?Q?u7VQ6PC9Zws7PXH2yz2ZSenspbJNX/oxFUG/WF4jjP0LErJuLlFpPgK3cgDi?=
 =?us-ascii?Q?haKh981PJ//N3pJmPrvJ0QIrHJeNGfqoeFMyHo26BH0hklOlFT04C6oiRHSL?=
 =?us-ascii?Q?mrmc9VB2Dd3ZCJft4Ni1pBPC1MI5F/wTFD5eommAikcfI9qtGOdVVgBw+uGK?=
 =?us-ascii?Q?djC/FMj7oANXsBcb8EVf/TN4aWFc22IArqqmgRhLgD3ZBCRaQOq+d2Mx4mCM?=
 =?us-ascii?Q?WdkuOjTkM0hxArwCJby6nVudWvreZPnF//OoYBduysFdRlX9/zn7Ii4l1Zc3?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6bef0c-ba88-40af-15a2-08dd45843501
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 01:27:08.5323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdurixKQSQtY6nw4MVgN6dB1O2Dn21zqtUHRx2c2m9H0hW1kbuU51+In4F30aQUOGQ6fESI4EGqKDLIGv4UbOnbT+SEaa8WvjKvem9tblGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7801
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add definition for fwctl_ops->info() to return driver information. The
> function will return a data structure with a reserved u32. This is setup
> for future usages.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Set command_info to reserved. (Dan)
> ---
>  drivers/cxl/fwctl.c      | 18 ++++++++++++++++--
>  include/cxl/mailbox.h    |  1 +
>  include/uapi/fwctl/cxl.h | 19 +++++++++++++++++++
>  3 files changed, 36 insertions(+), 2 deletions(-)
>  create mode 100644 include/uapi/fwctl/cxl.h
> 
> diff --git a/drivers/cxl/fwctl.c b/drivers/cxl/fwctl.c
> index 985315d5d503..85dee01d89d1 100644
> --- a/drivers/cxl/fwctl.c
> +++ b/drivers/cxl/fwctl.c
> @@ -6,6 +6,8 @@
>  #include "cxlmem.h"
>  #include "features.h"
>  
> +#define to_cxl_features_state(fwctl) container_of(fwctl, struct cxl_features_state, fwctl)
> +
>  static int cxlctl_open_uctx(struct fwctl_uctx *uctx)
>  {
>  	return 0;
> @@ -17,8 +19,20 @@ static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
>  
>  static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
>  {
> -	/* Place holder */
> -	return ERR_PTR(-EOPNOTSUPP);
> +	struct fwctl_device *fwctl = uctx->fwctl;
> +	struct cxl_features_state *cxlfs = to_cxl_features_state(fwctl);
> +	struct fwctl_info_cxl *info;
> +
> +	if (!cxlfs->num_user_features)
> +		return ERR_PTR(-EOPNOTSUPP);

You could save an error case by not registering the fwctl interface at
all when ->num_features == 0.

> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*length = sizeof(*info);
> +
> +	return info;
>  }
>  
>  static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
> diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
> index 99d3bbe1ba2a..bbbbff3af61f 100644
> --- a/include/cxl/mailbox.h
> +++ b/include/cxl/mailbox.h
> @@ -4,6 +4,7 @@
>  #define __CXL_MBOX_H__
>  #include <linux/rcuwait.h>
>  #include <cxl/features.h>
> +#include <uapi/fwctl/cxl.h>
>  #include <uapi/linux/cxl_mem.h>
>  
>  /**
> diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
> new file mode 100644
> index 000000000000..4e766ffb1388
> --- /dev/null
> +++ b/include/uapi/fwctl/cxl.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2024, Intel Corporation
> + *
> + * These are definitions for the mailbox command interface of CXL subsystem.
> + */
> +#ifndef _UAPI_FWCTL_CXL_H_
> +#define _UAPI_FWCTL_CXL_H_
> +
> +#include <linux/types.h>
> +
> +/**
> + * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
> + * @reserved: Place older for future usages

ignoring the s/older/holder/, I would just document this as:

	@reserved: zero

...and not tease a future.
