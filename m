Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FAABE46
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 00:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446116; cv=fail; b=mCpbYNDprMxewzXJWQvzvMjUpzI5EO6gJml3i3AMM845AdEPNXZYkTQ5GfVS0bnr/TPm9UyiOXROEGAPUR2nj30KgK6FkaREb5we3P4Vu4bWNEuoFow6n1eAX8huV3kJTCZrAoM3BmI/QYgvrIv5GOajxcvnGOwn64Y12X22bxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446116; c=relaxed/simple;
	bh=Nl6BfmMNTpuFLvBmcW+mLxF50luxcwfAMVpBNG2iRFk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qI1QUwYMU8gRdKs7QHf76QRefuBfwmoeo5+Ninh0TwtN65DXZhFKClQSxub/Ual2Zkn5V2/j3tezL5jR3kG0gwOwa1wEYCf+C3A5lqgomo/eRFmiydgU/LzWWOoEVUwmiQyMSIRzX8vzi8ap+QL1V8eHlrQQjbd/SoORnOCmdAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZoS8IucQ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZoS8IucQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733446115; x=1764982115;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Nl6BfmMNTpuFLvBmcW+mLxF50luxcwfAMVpBNG2iRFk=;
  b=ZoS8IucQsP/n8MREDgd/sEVjnS2lJ1EObpB8mwE54hoffcQRzJ0MGE1q
   EdF0UyIVyAL8UKyNFUACx/wgB6H8myNAMJvqI6PhheaCCxWR5oujyPvYT
   pqfivjyAMk1qYSc9GJX7cKS7YdDF70ye/tFOE1HtQqmX11ePm49n3AYIH
   brlUNyzK09sF0cdB8bJq4501zhiqpARjGxNOHsfro61JHx+UmzWfsf6Fi
   I2686dAd7oeEsvkHGl7c7CDkOLckUYcBjcHyuP8FgaWg4mWyYOeZ3eFLe
   /h24qqvSO0sxWHtLQ+dHu/WzZ12Xdx/Fby1L7KmfdDAgIjuCTPeeVyl+O
   A==;
X-CSE-ConnectionGUID: RTyp/2V+QQyKay8tpzxvcw==
X-CSE-MsgGUID: 9GlWHpEVQ7aazCp88CmIZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44396540"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="44396540"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 16:48:34 -0800
X-CSE-ConnectionGUID: wC+EWJ2ZSb+v2BAZDNtyEQ==
X-CSE-MsgGUID: 641Dc4ZlRw6Cd92C7qE0uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="94126528"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 16:48:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 16:48:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 16:48:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 16:48:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkHMtbmkcIX6l2aaaWEajQWIhKZSSjN1cdlrCFaxYKwSevFJwm9JwY4CvjrQclvpAjczTBfKcNk0g9dyyIGE5QGj5cpzzYbT838GSnBrnhrwl1bhnZuKl1nxxFeC8kVVpOMunrYYgt34m1jvNB6bEUc4UyoX+Cuy3fqM3ACDrunH6m57KLienA7uUV+MTFQTdubDrsH7JLixhgv+rnnf0mncNa42EtsZ4J6E751+Jv5eXKembBehIdpWUKFWA/8dYyw+g9s7ZAZxHfDGfeLQayTSB8E8YDppkzAYsViGhPSUYzvAJ0IJgMdjuot3oweF1QXYh1UNkRP6LdPK0HOk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0i1WTuboOs3Zv83cFM/lht9tbpLREoZbmTuHiI/HNSc=;
 b=Rm3eeARGfKZ4fcCcdZHZt4PGld8cjb/QBjBjnbcyQ36VA3q7HjXkJKeAQRBOvi2/n2Gra0zMM2I4+FMlw+BVct+1AzksaspgjWutZZTHpsbXwM/mI4jDymyLKJsyKWxWK/Ws0ziV9spTZUmUIbV6mQS9rcbuNLilux+U4a2+gFiL8FuJqRJXQh9x0IKK5vLT5+ziHP6nLMAA/pPuLXvdqaCwoIbqsTT8lgUv1WEUthzOv0qNRPvJ3GBzZPViyGvdgl0SkGQTP9zPgMNNpp6sXiSOmnfPZQ7ptDJPVULHP3Hr7Ppg2ux0RVLcSEnR3LRJH2KSY5bZLVonw9BA0eaxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4557.namprd11.prod.outlook.com (2603:10b6:806:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 00:48:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 00:48:23 +0000
Date: Thu, 5 Dec 2024 16:48:21 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 06/20] cxl/mbox: Add SET_FEATURE mailbox command
Message-ID: <675249d57899e_25073294f4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-7-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-7-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0293.namprd04.prod.outlook.com
 (2603:10b6:303:89::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: 464662fb-1fa6-4627-9a8c-08dd158fb032
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gsUjJVujfLjlRbwR9q60t1OD2HiViTgwOq7Jo3XNrMqiQqjuaGXvLocOOAsT?=
 =?us-ascii?Q?BuUd2PS7g6c9DfW2VE7tiAbzV1iGsyJGym/ooQPv7cf92mW2jep2oJqaYB8f?=
 =?us-ascii?Q?7t6YljoVEzmn5wRxEuMjZD9l/SZgbagg2VbQGwnb+ezna0RG/kONUbBBimMr?=
 =?us-ascii?Q?5WnDV3uXzqjlalV+cSO+vhyKmflTupK0P1gOHE/hUGTjs5TTkLx9sShJAM8g?=
 =?us-ascii?Q?oHSWOrOROfRhkkQwXE5CEHRTdbC/jSdDvK4f7PcM/GFcP82t+Zwp0Nc2x+Br?=
 =?us-ascii?Q?UJWMmMwhjFQAu9RpcSePyN2msrohVD5GLHyYApEG4fPDSKVvzaKBpLQ29H8B?=
 =?us-ascii?Q?n+8jMI2j5aaeqUAEVtnODIPkELyfYv9kf3emRzG/U6dK7bAoOT4rozb125be?=
 =?us-ascii?Q?Nmda0qcis+mpf/bqpo+Bfbbu9r3XpoPgATSURN/LxtAdFYKyle9Gv4hP5723?=
 =?us-ascii?Q?vSCnmkGHgmCUBAiwRrAjyb+wemfyIK69sH0MwRWTdZ7T3QS3UOncC8dT0w64?=
 =?us-ascii?Q?M9D02ghcRRSJgfx10vlwekz3al7FriFDBwcYakMHCV9PsMVSc/TWEwTx9VwC?=
 =?us-ascii?Q?PO7xPphQZXgiimzBPLHx1/efpkuEiyIReDgqqZUa88pxQ3zrhozBBCSPzjVo?=
 =?us-ascii?Q?EqJ+lE7zwf7iheoTTeFXphJ1EqHkRaHK13Kd+gRhWes5asVktQicGUHZ7Xys?=
 =?us-ascii?Q?Ac0ux4CQb5wWI6uWNEyrKhsDdAO5UDxOsIPAQv+hPNtaIbIq4+ZL9TMdHxAC?=
 =?us-ascii?Q?VCpNQVEN+vLPqrxRscaXEBtpJiFAayy5ECFN+dVkV3+vipg16YUsxxJbtCLq?=
 =?us-ascii?Q?e/FhWa/3EWWGgDX7oi10mjpPYQjc8OI9sTT8axwVEGwLB2MH1mgIipYBPe/8?=
 =?us-ascii?Q?xi1Zftbj07ftlXF/3nVmgpV0BaUn7o5O+wwgJifk0vqp/WL0cRvnJPsS012t?=
 =?us-ascii?Q?Uo2Yzq3FmYUo22QIOVuT04kYICtAjz5N52zK3UWqM+Xr1Ok3l3bDiQ4hhUKP?=
 =?us-ascii?Q?aGRtWAYVtjYJVnLKNhBZSK3WmCrEuoICzQxylXoIGVj8JpPsaYoZUrhuFR/B?=
 =?us-ascii?Q?stCRdOIEQK9IMTGrKHZi+lVWj7t9U7JIJsoxGiz3Xiw8oXFLFCdGqnJJZzEM?=
 =?us-ascii?Q?SHlK4dwSRNm1/im4Wwzl3/iu9pTgINhTAJl/xpmdu9A4mYB1fe/1BFxe5JyA?=
 =?us-ascii?Q?kXB7e4BGd9Ob8TPZ+bvasyV8x0VN8FGmpMIIxW/lF6Te44T0JZvHdZyhXNud?=
 =?us-ascii?Q?rph9okvecGHBez0NddYcUIicSAKL1PVoic8F4xefaESZ4yzxxxUZEQtp9sDt?=
 =?us-ascii?Q?eToMg4hczPrLfQAdv2bsz5JX0oOrx7gq0Q8K5YJYjKjDHQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bey3+NWDod70BID/E/NNj0B3Q2Mioi7F2QrV5C/W2ipIiFpvBMsbia4/IqED?=
 =?us-ascii?Q?ceaO492wBEGaKosW5Y/ChJHSqfBnm7PnQQ/WZ+Lcj7YCurt8eJ9L4Y7n1FJx?=
 =?us-ascii?Q?o6c/NQhdAeL5zPAKSj013WsWNfh8rQ4ZVHYH+h6IqBP9iDA9vUAEfo4cCJ0N?=
 =?us-ascii?Q?RF1zCUVfBPnbbdkV8lD/ddAl1P2x4q/acKNNv8wfaygSiA5zGfMljT8qBEEs?=
 =?us-ascii?Q?3YnuwhiB2x3Zbc2eq1N1bwdWJppjQzqUamJv/V+b49guyu86tyOO2NPmiTgq?=
 =?us-ascii?Q?vXmyMsv5hJAX3QiLVuKyzCZUCS/Jo8HYvmDQ2qoerrgNXyctG7wIJUcXxtTd?=
 =?us-ascii?Q?dbl4BQwRKfaPRZ89suX/bYKKUxOultCSVcHt6U3cwvWoGsvXUL/+erY2ltIx?=
 =?us-ascii?Q?xm7Du53DjOToQo56w7nxg+aMpMUNGtY6pMT8j1dwBafGcZuyBYV67hFYNiBI?=
 =?us-ascii?Q?XuUxCxDIBpMgtaKrQgkPtYzgqTo+IefSrjdV/dqy0tN0XyUXeFycSGFDBcty?=
 =?us-ascii?Q?xYz0agHWs+xcaL9Vnrehd+mPKirFTxj4/42M/pN5RcuHpZuMoeW2X0GRpIc+?=
 =?us-ascii?Q?Qnb6cgGstcvXF4oGV6I0PVZi+r/Y8KnKy2Z1oUpwJFi8Yp9eRKI52d/G4+Tn?=
 =?us-ascii?Q?Vaikh5Uq3nyOSQnPJ8xSvAIKeXwasbbskPs5UFbruewNNdm+Tr20kPHBlbJZ?=
 =?us-ascii?Q?lOSrbt1R+efHT6Df7luhCVLSNwUCLcwWIEmvn2+pWVXANC3PbZiAXEDACoor?=
 =?us-ascii?Q?cRnthUqCViEly9T8a/wjdy0NWzdud3jJBc8qopAKQiHOacbOoUAsbLYA61zS?=
 =?us-ascii?Q?TijvScpZbCYPTCtzisUv8UXDVgyTfEK2DtZZm3Ks7Unl+CMcItvshhxsnoXU?=
 =?us-ascii?Q?VvC6Jkdg0zIs+VOSuirxteY1fdzp97vcRX7ZHlhpxJrjbxmKUCW12IRc9uEJ?=
 =?us-ascii?Q?E7iTPr/mMeQB1NLDGBtZTHg+RwsNh74+c2VSl1gfM7EqcAk9QNEdHZ5bxRRq?=
 =?us-ascii?Q?lNWRsh8MyCj0+1MYq/dHDfg9CCL2I0uW3ywp5iKBaj9GUfDmlINnHf07DqhV?=
 =?us-ascii?Q?6LHNHyWMe97vH7pvqf70d2m7oeWZF5wZdUtMOWsN/J2dKm4y0tv2wfz77fg6?=
 =?us-ascii?Q?Vw6M7e7k/dF4Y43+6dlMjFnFoQTg50UBR+cX2AQ9JZyDwdZLWKRGq/sFz3dG?=
 =?us-ascii?Q?aF4HvJG//v4S1DLJuhAgOPcc6088HMsnpI6bI5o52hXKDInqhKzz2qIVbGmD?=
 =?us-ascii?Q?f03qo4/m+OJLb0/qB5SPVShCFtGxY3Rn2hQTmpgWOueSfs6DlAWFRoCVtG4Z?=
 =?us-ascii?Q?6KBSW5xibDSj99H/cF30s46oKW8fM7ivU4cNe7HURwSKnGtIpX1oTYoZnH96?=
 =?us-ascii?Q?nT6/QGJbHbf7Rrl/XyS7kowBSWQLq6uSK5LXkKuSVogtNsYoIkHN7I+E1+Ns?=
 =?us-ascii?Q?1n3FYHGM33SobZf0XXPQpPTxQlVdOs9y+jnEyrwigjXz3vqGV9CbVuUC111C?=
 =?us-ascii?Q?bm8K7eQVg/D0WlpbBy7YOPwgSYY05SLEiNhr2tB88sgwze7xjXtuo05/vRGv?=
 =?us-ascii?Q?twaQqIwQOTKpXSUXoUwRq9AWLDSwT/gxzp+uiZvhKhqv23j/eFm5+RFggz8G?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 464662fb-1fa6-4627-9a8c-08dd158fb032
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 00:48:23.8423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JbKJElnrEGtyYjF8Z5skZG0XtTOudLEOTfhwTDBL6a2XyS2zlNB34yJW/8L344b8uAasQMEFar0o2kc1fbiSgC8trtpGkBBZHtNn6y6uhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4557
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for SET_FEATURE mailbox command.
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
> The settings of a feature can be optionally modified using Set Feature
> command.
> CXL spec 3.1 section 8.2.9.6.3 describes Set Feature command.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> This patch is not needed except for the opcode enumeration.
> ---

Same reaction as a the last patch.

We can always circle back to add this on top if really necessary, but
lets keep this set on topic with the cover letter of enabling
fwctl for features.
