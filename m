Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A6DBE55
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166782; cv=fail; b=BelkXQCnSAgaH9S+Y7KhqMIRUkkaiEV5KEHvMsuGmxWNXiH5VuWIpciaAmPdfS6vBNwicHp/wmWYZal0vd1uzWlJTcIRSjlNvJphs6sXebjr1GjP9U83wfrzAtyy9MlWoLGUHx9fB+xXwfsDJx55CqcTd4Fo3r39NKIEgfkZ2Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166782; c=relaxed/simple;
	bh=S+8YCie89xdrpn2+lBKzID4jaXshjM66OHtLKFqW0A4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qdT9vESkXW2e8iPG/TMB2ZlMuuTeGG9ZK0D8ms+252d+qqvpbCVOXGfACxFcfta4c6DZFcbqmTyW8NB0wAS2ZuMv0JhK7b5Gu6yRYIwjBeLR7aU0kHGa0DYuMOEinc6PJGneWshDSbLaJy+siChAnKkuqhsO6bjCQzLWVgFKEMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRHAiMez; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRHAiMez"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709166780; x=1740702780;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S+8YCie89xdrpn2+lBKzID4jaXshjM66OHtLKFqW0A4=;
  b=VRHAiMez/TdkToXRkcAA0zLXxBCpBLV4wilofA1/i5N5mriXCFRIADW+
   l2qUhDjd9SeIRpro3FHovys6BeYgqwW/ChC4CZGIg8c2M+7oVqt7eyaTG
   gSqrrzuwLAPVPWzFXpdvVRhe9K6W9kstkDWFVW891vdlMRDjmmuAgd/wC
   Dh7AsOb6rjnZXI/rYqM/mex8b3TDa4MTjlzAWeFLuiFpO8OGML0O9ScQq
   0iUDnJPBb0SMBwmh04b1AWP5exjeMiWxssa5qkVaVi6H38x3zvWmMNdvI
   Bm/etaRgfMylCAivDp9PNFZTHG4AFGD/JX0LqhaLTha0PdagDxJgliT8a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14754129"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="14754129"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:33:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="12323542"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 16:33:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 16:32:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 16:32:59 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 16:32:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQTdEn3QmyjVunmtojCpyEw7N5SuL/SXYFRlZ8Y75DYoNgk5zBTCyggHvC8wMnjtojxOm7lDdI+6zUUHcKv3oQuYzgBOgWxNt/UepdN+XcctSQ5h0ww1aylqAlOxtP2jxGUcBTavwbD6tUQHfqxYvYg7F56v0Iccu9QZa+/AskihXueYhlV+ykMwmQ3IwKDZAlCRUsWQvAMbCSHWKUvEy6xsRvR583y130+V31ikUdEuTcQzi63Gi/YFNUNCA9ioTUjxjhhjemrEGF5lZboxw8YsiiqDMr/l6O7TRfvgP/wbQmfPo5Q5QsfmhDihKTQCg4Jc9GVkOe7lwfLt+jodLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+8YCie89xdrpn2+lBKzID4jaXshjM66OHtLKFqW0A4=;
 b=Bzk9ZqbW+ek97NwCrCJOdP0PtPUaaSe8z89aHz/Qy+eBGLUFRdcQoeMhfKC48qhwTBRN6tAr+RSq+N/MFNnEOv4Oac6lNYJHx1T6NZS06oaxhgLfUKSGkhpt98NoCN4981+M5FaQQNI1sC2ykft2gmpU1PIvke7qOCl9VtuCxGD1qle00niTdRPC4UqjlklCpoX3bxXiMGg+8FwzEqc/9prNnN6wKwkJG/+XLCWBPpbQy3Bljy1UNwsUvtmjGp8D8Hw/yNomXee2ODibLnX3ZYrUdQ4TBj+VbUnl2N+QnkTBki1KFvXhFJrMncm1NfQwYhRko6N4bHkhuYO6/fuLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7838.namprd11.prod.outlook.com (2603:10b6:208:402::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Thu, 29 Feb
 2024 00:32:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Thu, 29 Feb 2024
 00:32:57 +0000
Date: Wed, 28 Feb 2024 16:32:54 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH 1/2] cxl: Remove checking of iter in
 cxl_endpoint_get_perf_coordinates()
Message-ID: <65dfd0b697797_1138c729458@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240229002542.634982-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240229002542.634982-1-dave.jiang@intel.com>
X-ClientProxiedBy: MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: f1340c3b-0f6b-4365-7f90-08dc38bdf9b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ylkutdwcVTOLhycLUWZQLpQ7Qts/cZ4zk0MqGHOvZiebXzqfzyo9CV0/UdGOnsR4l+u0Ya4YJdLFJQiSYGkmGpFsZa+M35fT5DLz/3TrROsTJkk1l1miWnDFqDCWQ+NYNdv6ixV3BI7TkBoI+Z6qLZYUHCac2q3Ls2gOX4j5MiKNBO/W8VfxEDQT6EjuIfrE68SYF3NRqRrXqbnqH0P2R4HSxpwc56hLExw+yw90PIp7HqCJAbAKb4mvD25TRm9p0BOabgG8Nia43DTdPKD//yz17QDt7LGFawqk9Jx9xmgTVevIobsPOyYhcOnzQL8P9ChFl0uv/+l71JtWvaGJWgi0a3KDKVQeOpBatpe7FKO8SliNV4dECy+Qe8D0aU5/1RMzluCnybrJDwVNrUMzWbcSfI2xrsbo7QMyGm2jgNu4VT+k+7Z/t8ajkFsfT0KsGVclOynzCYr78s0TRyLteEI4p7YVkY1Ic4uksF++xojWBVJ7qgOyGKsGPzLhng61KBHQBQAqs1bw/MuNeZeQhzAQHun6k5KUBXKqSJzd2euMDebslwthjZYpreduIgDEBcy6GlFQZKsiHx3X7vBU++V2XrnVaTawlNaB3a6uLxkNwljnvHhSK20GAtEELx6bxiRLDkUiqQfLg4FgQ8fGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LW1a914JNFFActS3sXCwKm6Uvu8HjFc/mhuq3h/pnmK22e5lsHNFqFGymU8c?=
 =?us-ascii?Q?06SezKBkgLZ5A2+gYBkDryqUWFsjNcVf1uXd2NxX0LyPVHESej/4nCkzhsy4?=
 =?us-ascii?Q?3/81WpWo3rghZ1ta6RtZWSMWbNWBjsCqOaSbXMtFruyp1xXDs1EMbBnjqZPi?=
 =?us-ascii?Q?+o0j1J5nuiiXGek8bEYjL2QAw9NzQHE9UkLPP7NhHN4wX40GRbSedwBWm8w8?=
 =?us-ascii?Q?Hpgnygzzmhs+zxKVuIx/tfDt2iMUEsPjIqti3GdMHCcv2sCVvBo9YYswBz26?=
 =?us-ascii?Q?jcT2t4c7Oith59HvYd7zQNPHjPC8lV18k4COmbrIwYLsdP3tP+ZuZao1dr74?=
 =?us-ascii?Q?uLA50WhMWRW0Il52nHNwrENUljYyIIewW85+7Z61cQshkO1oB0h0MYTLDMb9?=
 =?us-ascii?Q?uQOjdOPK+pjFlSBp5zcDVF8uiGWcBlCoT7LRQTO+xJW7Ce1SUVPnvPJaRlUV?=
 =?us-ascii?Q?cJN31EseBrNkhweP9bLika38xnRldgB7ciNDZHBhleocd6S3dJrd9roOICX6?=
 =?us-ascii?Q?DiNk2uPvWCzFfpcQOW5xyqAKQJqUBX5zxAkhhJwGe6TAeOpjbLNmum0C8YWy?=
 =?us-ascii?Q?esFJSbVz/ZFuWDahDKnKqN/WWajKjK2hwOIQWI+GxZzXkUOE/22BqPpkc92h?=
 =?us-ascii?Q?I1pY5bg6AeJN62dUwB2s8Dh9Zpk0S6ERS+FxC/EpvjLT0BPpJ3Rw/xXI4v1W?=
 =?us-ascii?Q?KGqfL1K1J+78I+fy0Mdq8aeKjh7G+udNrKsHBDkvMEda6rUOqA5XNLOQVjQq?=
 =?us-ascii?Q?8odZv2ePkvOtBv7JWFPJ2fbDqZqkqHyBd2Gt3taBA6WnbSEnR5iV1SjqLNIh?=
 =?us-ascii?Q?rH38SpLVQayS7BDCRiqItkZ+VZEqF7Eomow/v8EBQXELzI6sEenBZT6Kx9L5?=
 =?us-ascii?Q?Lmc0KaB+Mda66Rq2Ez/sL2cTB+Rd2P6Jh8xoWsuh/Uj4tMh6B8KKvAHtn9D5?=
 =?us-ascii?Q?4gpWUDw+5kFS8ad5dfA/KYydi1pGwGgWQP1ADHDEOkaUzph2ihVcBKZ9eVd5?=
 =?us-ascii?Q?aa9JzfkujQzL/f4/rDQd8zX706HoQBLsnktWUtwe/CEvaVd1PugK8spQfOym?=
 =?us-ascii?Q?tIZh5jjsUTEHvihnedwmgOiM84qwccgg+bWnrJL/R/h5chHqoBH///IO0/7f?=
 =?us-ascii?Q?bO/WVlUbWQ68emc7TglMaawStzcQKy7dJtMZHpqDYanZQHt3kvKGEYVrj5cp?=
 =?us-ascii?Q?sYHCez5UaDNkSx0U+4j3ZD5qnEP8V7U9NtnIWj3qD8SO/CFzJUh+uyK0Wv49?=
 =?us-ascii?Q?z2zr6vg3zCLJ79n0yCZUsmHAHhmduXG/3LOanllG5r1a+glvo9JRFvZfGayf?=
 =?us-ascii?Q?afwoY9NXENfDTa5ZH/G8FhB8t2NaOsVyloVDdVlJ7Mc6rTgmr7Upvhr+zdwK?=
 =?us-ascii?Q?+n7xA+KK6IIoccT8BS/abF0+MPzGGaMCahA6PFze5GbpgHBO8wjIhWaKADOv?=
 =?us-ascii?Q?TMb+nqrK7W8/3ie/zhhPuhGpyG42XY4XAwyvjSca0j8FUZthcObpm7MlZHeZ?=
 =?us-ascii?Q?92S8cH012vTZ49EuKQhPcb68efnOSNVohnRIHV6KLS7dK0q6m2Md1PwQX5GW?=
 =?us-ascii?Q?FnVL/D9U84l8ZcxlGdSmKaNJFFWiescl+VK3vfhyWTcZQ5Vz4jSM+pxuujX8?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1340c3b-0f6b-4365-7f90-08dc38bdf9b2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 00:32:57.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5JU8x2k9rPmkxB8NW+T5iwtarugBgzzI4CkdwH+cXIThARiOda0K2Od0lcn3EgEPgnoQDtsXnoi2DZ8mT2LvTDxF4B1LHpmB0Iu/8nJqu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7838
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> The while() loop in cxl_endpoint_get_perf_coordinates() checks to see if
> 'iter' is valid as part of the condition breaking out of the loop. However,
> iter is being used before the check at the end of the while loop before
> the next iteration starts. Given that the loop doesn't expect the iter to
> be NULL because it stops before the root port, remove the iter check.

This smells like a fix, but no "Fix" in the title or "Fixes" tag. So, is
this a cleanup or a fix, and if it a fix what are the user visible
effects of the bug?
