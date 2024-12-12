Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A4193084
	for <linux-cxl@vger.kernel.org>; Thu, 12 Dec 2024 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033465; cv=fail; b=K3v+rgU6MKBbzeiyGH5sI0/6lgEIrCms99ABXu109E1m/s3/i4ViZaC+xF+HiC8qrlZASqua+QwVEY7YC80k7zgndu4hUdDKchFa+6KbLWStFSpzoKdjKRcUse9XCLW1/pBUkmqI53kiv8DJORbuZSclZjOEr3t+3/TkI3rve08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033465; c=relaxed/simple;
	bh=iMviHiprtEaKo96gZE9xLeAm4Yvze0ySzoPf4bjmXxs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m5ydz5U8YowHhIuBZI8eEGwmp7ibiluLp+Wf206d+Fe8aDbNZtrGJHf1r2CcQFzY6/kr9xqP3hKIz/ugu5JJWlA45dK8koIiWJEs9KTnV/pUjum8KYi7KxP320x9wW6rPkfCCKzkzxNCE+XjBAZEL2E7VTpG8nk/Fmh33djZzzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwLMnHOF; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwLMnHOF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734033463; x=1765569463;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iMviHiprtEaKo96gZE9xLeAm4Yvze0ySzoPf4bjmXxs=;
  b=iwLMnHOFREp6wMYNdIc7QMsIOtIvHK2YXYKv2vFT/YDNom8FhI3936k0
   WfVJS37Gntgp+g4IQUaHeTp0UzQM1+WCwkitxXOdxn2zxNn509ffAZqEe
   lqrRM9D3PXyjPbRXl+CRZEpxI+d8E0mcAyy0XsNpkRseOhPRz7t4is9wD
   JdElzFdy2AsnwrdSzVDmBcilSToCKVB0sZdlSE7kELXL80xBepwf6rsxi
   4VSivhvTkiKxco/gArn7Vy7AY8lp5MNq8w2ypVwqnn2oOR8d+nLrlE3Dv
   OeFJem4GTaqfpAXPJz1FaPkS1yNowOBMgGN5wsvdrjJyCBei99xdv6SCi
   Q==;
X-CSE-ConnectionGUID: 6KWhjfPsQZqtbshme1eHNQ==
X-CSE-MsgGUID: px0Ki/DxRbG+ylK6o6gM4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45856156"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45856156"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 11:57:43 -0800
X-CSE-ConnectionGUID: zvTKjP3bTGGG7Ja5VbU+Pw==
X-CSE-MsgGUID: rsZO9bJqTquU1WiLSmYSIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100905634"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 11:57:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 11:57:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 11:57:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 11:57:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajwsReynNSqG966CniTHEl8RRHaDrWmHkveMXNidiWc+b4/sasnAbN4eqdIyPUQpOgoj/EBaqXNxP1jrLEYkt9UFM4gyxjjKv0Agh3iMvNRKIfHd5EIwK94jkj74AWUMeeYoGRBZ0Lq8Cc5iPJd70YFo976rGbAu0riZhrpqzac9cv9JZHVzU7jSUhk8L8qV+gx5p8juQWerO0N4p1gDcFdB+FrTdIxBQLJeqOCDZhcEJqfsVyVBZaaaBYd5/ltL8yTQyoVZUcFMOFrYqYIUDX+v6R39whkvROboECle3doWOJ6HzqiM9Ot57IYCd78Dt10cP4xHyD+e2N41wHFuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hohFkwQg885ZWJCqNpSzmux4WpmdD/fZPFhGg86Lxo8=;
 b=XF8E5H0Nxlw3o5J6zQT6+tGQueWSjQmH3A3X/vHK/Xw6BfkmYgemkkaIIPZ/uKI7FpQ+T0HrmtORIW5Q1x7SFzyKgrANAJim3CzERjgMRvgoM3tmhYGs5fuVVtp1xmibzB92uP7ebwB+O45GD1mZuyp5BHbSQfHfVGnJiSiAXOikhf39YUQH8a8TvnyNEpHnidp3rfkJABA9+Z7N+8eDB8SGm95hZyjHrqwD3bQbKhBiIhx/VSQsPajS8v9juzmiNT4aNEwCF+sbJyJpVt4jAu/3T/nkmcr5qqePCMl0Rc0rnhJXp9G+uZbrmqcBYKqsEb4gSOTQiutvXIkLm+TYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV2PR11MB5998.namprd11.prod.outlook.com (2603:10b6:408:17e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Thu, 12 Dec
 2024 19:57:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 19:57:39 +0000
Date: Thu, 12 Dec 2024 11:57:36 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Fontenot, Nathan" <nafonten@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Nathan Fontenot <nathan.fontenot@amd.com>,
	<alison.schofield@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
Message-ID: <675b403019d4b_3e0f62942f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20241202155542.22111-1-nathan.fontenot@amd.com>
 <675a12a3d09d7_10a083294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <a37fafb3-ba2d-49ce-9270-e0a082652b45@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a37fafb3-ba2d-49ce-9270-e0a082652b45@amd.com>
X-ClientProxiedBy: MW4PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:303:6a::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV2PR11MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: c7012f67-4536-43aa-b19d-08dd1ae73b39
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R30T4VwKay+JegF/2C+bFQoNxXkdOMJvgu75ASUo5kye1Xpaa2jh3BMOHfcN?=
 =?us-ascii?Q?YJx0qLqM5DoZ9bCdMCaD8TuzJe2f/SFmjatII4ed5K18R6d2qxMFUMnS8ytM?=
 =?us-ascii?Q?fVOXOLuCch5dLnS265s1aMkefZ/KkhhwCt7UwZq6qnnxMAXeVThEIxG7clyr?=
 =?us-ascii?Q?XBHDRAOweDaBwGMgKTsA8mK4Nw8BoCLgWT3X+iV9fqZYklzEvTDMuvzMuiy0?=
 =?us-ascii?Q?oh5/57c/N3fuRcsOxzJKdMkkmjUt0p/kxJzU6waMz6wP3RnOEjc7qV609Cq7?=
 =?us-ascii?Q?T3wU28A7Z4Vj5q9Sc2mH3mn+QpLqTPJ1mjmB089Kfg28R1hwOey+9YUfASR1?=
 =?us-ascii?Q?Bgw35WjepRuev9szyHojQ4x0PJsRo6E4rOEEBaLoavA4EcysKbWLb7F9fc7T?=
 =?us-ascii?Q?63daiPU3pBfIqG+N6Vx+VScHxun1h6xE5qQyuXQUfKPMGEC7rIoUV5SOshZt?=
 =?us-ascii?Q?12B7ODh6XctJp93usYvqNR0S8IuBIkL5Wogv5Bdw+/AAH+eZjQd8mU3uCYY8?=
 =?us-ascii?Q?GBF4w6r/RtdOD9xYIzoPlQF5aeJh87FVjQ3ffRO4+5cA8s5jdHeyTUfUzbAg?=
 =?us-ascii?Q?AHO0My1pi0Y7f2lzUlHqjJ4FaSBTKGX5hJQX9qZi6hrQcppfgOBU5ZTSn2yi?=
 =?us-ascii?Q?x9fK2xth+9QHzaEQNpCdbiuDqGPrTGhozO2RreZ/1HeVCP/S5jd63ZWHo0ww?=
 =?us-ascii?Q?98vRI9VXhT4Xa4BkskazcadaTyGJ3bb9rcUq+FGrVnsgIflS4mUHpMZPI07J?=
 =?us-ascii?Q?wNF+DJZ7Vj4iOBKkz4JnS8Vf8rHM3S4Im8vv+X9hNZB6WjLdtRuSC4ByVsn5?=
 =?us-ascii?Q?INVxjxR0hzJ//bhgU62CRk12Ik76OsnPqnTF+wfxQmDrMzrG0KqBaZmHM9jv?=
 =?us-ascii?Q?VVd6OXoh2Pd+vEFr/Hckq4JTxyRE1IVfvnr/8KyDd3ZBtXLBceEzm9HMP06n?=
 =?us-ascii?Q?zw0D/YLYJLBniXyUmWD20QF2H6rJhmp0WhCK3WjHmRhJld83qkeUlf1EGTuE?=
 =?us-ascii?Q?KdaphHCtqVqaQ63dr8sMwdzNtzMk8lXw0JbCXmViaYSLYA8aIFW641/5+4u6?=
 =?us-ascii?Q?zppzN/SUKql7402bvynFdel+EOMqBw3TU2B2wd6O/2wB5xvKLAD+2OGrJ+hh?=
 =?us-ascii?Q?05SN1wKzCQg28vebPGr5gLUez9HYu9Q2b373Wglqr11uXu5KiAMCxQ1XZnjv?=
 =?us-ascii?Q?CITEDkwzIJvwcdE1OQjzPxV+jiLmvq/PIdfOULA+rjQS/wwt7dlMu+7hGUy0?=
 =?us-ascii?Q?UEqbEvgcbrxd5Kfj4rGWRO2xahPPY5IE+pz0rUl6IT/uTPuxxfRwMHLPhTYi?=
 =?us-ascii?Q?Z8LErtuuh2BK5XiSanTkOfwN7M62qBibVYLPeK4iRRjLmmNGSjqXGygnoPuf?=
 =?us-ascii?Q?MpyL9zM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NX1ff4mSbYfybtSHxjgi4f1zckGVfCTxCKyg9fQoyWovacYvs6ejFH7YbvfJ?=
 =?us-ascii?Q?mnBK2y41l//fPxS893qrP1Ir7m/mFGHKdQh8OMKeq5/MJDU2OOoTn7dprwMW?=
 =?us-ascii?Q?WzlFFrt4l+7w4VpBDKHv+ixRgTAhgvRmAC0Zj8nEqp20/2fdBlrCnEtRW2ka?=
 =?us-ascii?Q?xNf4/qtlnw6R9kyrl1X2VbmPSgbDYpMJ8XZ6mRXeYaNP0CtId6dQy6EuUs+8?=
 =?us-ascii?Q?RRzFtU+mj2JXCQMRm8jeIYmIZ4OtMtRckAm0oSuWjGjiXjNiUwk4g0krkL1W?=
 =?us-ascii?Q?x4r/SH1vLMBvvnKQ8E++km4FlZx42OCWqfwKFNYEWSdJGYnfvqoWTy8+vOSK?=
 =?us-ascii?Q?vcC116JnBYH6diJv7zHMzx0N718MsidVVJ+BdNyAq3zcyJ6Q/jQBV77eVX3d?=
 =?us-ascii?Q?tENRIOE3mmXPq/pNOox26ovY8Y+fealfbPQw+aY584WpCJ9/P6N3AlrUr/QA?=
 =?us-ascii?Q?whlA+HIDLUdtpbAC6Cgl4JAC1OHqP7p7T0NDCUwt6z28SKWcBJyWkVS2sO/l?=
 =?us-ascii?Q?FFgkOHPgZXTElaarMlCfxyiMCaXyWmWyQW0QfvI57TqrpUVah4pc5PTEpzwa?=
 =?us-ascii?Q?R9pLgBjv+kIbmPcgO1V/V2ea8x29HKgtQVK2KHpMZezzqDyPXZhZV2HbazeW?=
 =?us-ascii?Q?1pGqZlKNjqUhv9zQ/e9TNgruFz2PfiulmyeLsu8zl+bSE7szGbu5g7XWZQmP?=
 =?us-ascii?Q?a8B/BcRtb3KgWwjP+IVUl/Ab3TcH6mj7xeBvInEF2oolCfCz/Qama3lx8axk?=
 =?us-ascii?Q?k0iT9Z1B3t+ZzR34YDOSAu2uQ3iUBvpFJHY+nTVrU1gUNqwNbGnSPXLhEEIa?=
 =?us-ascii?Q?nLwP6Ggkpr8DP3o2K7CSe6LLu5YMYQ/xewVuaEhc64UU4ZvfpXRyOkO2M70L?=
 =?us-ascii?Q?rMJLIBx1TttaETkxfwHBVrZJoCsX9aRH7YwxeoASwTOEYOQxwKcnEXjuxkiX?=
 =?us-ascii?Q?3Jgz+fnLOT6nplfzdaQGzai5aBFYaF+az+u+0ExOibxz6wLNohcHPG0IjdU/?=
 =?us-ascii?Q?ROov6YC9PSZL6H2YpDmsumTgcCnpvKAQqRyaaqK4N60/5rWn7Ka9/rgp1EKW?=
 =?us-ascii?Q?KGwM7/wykgah5p58MR++uDfOEcXz+0DcoQb4O+qNXLxPDJJSNc6h/u0BuBv5?=
 =?us-ascii?Q?VGvof4tSloBD8OgEVbscfroLf+tpxy+dAoMD8B5yadCbz/BGXF2SiRy314Jy?=
 =?us-ascii?Q?ptiVWIhu+9LPFcBElUIcfGwPVQUwsvMffRFEg+O/INO0iDHFORcj5ROWuPjf?=
 =?us-ascii?Q?WXo457fmOVJ3jQOOv6CMepTiMLN7EAPAksVYPvNqysV+m/2ay0XHMavh53cs?=
 =?us-ascii?Q?13rx1fhO8TY04S4ILrwWKek+0a60K7KxXGPnTanqcGGOEqUVXI2B0UfKvw1Z?=
 =?us-ascii?Q?HMiTmflM1H7S5y4lqQ7CzWSFXatXv0/275ORj7YAvZQMzcMCPnBZMlAIcsh1?=
 =?us-ascii?Q?cX/nak2mstBWo7zQkbyduEO5YVXhlfAr0DNAQII4+HeDJqmRvoSce0cRsV4C?=
 =?us-ascii?Q?cpyDUmAL8AfXdtgC1it/HHCa0G8BK543VTRbe4NpW4CkYtr+DwYtL3L80nBl?=
 =?us-ascii?Q?7lZ91jSR3cRTSY/vLx5AFzvJCDrFbetBm8+IhytnQuHTTygLi+fSSstIqPgr?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7012f67-4536-43aa-b19d-08dd1ae73b39
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 19:57:39.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKBxK9OSVMSmv51o9GJ67HqQyPnTtqgJUka7rlqXdkt1EKNTFH11vCHrTFDbT9xCKncI+5XHksexv7m/DxsNGriYVL1Gd8or4FfYOex60JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5998
X-OriginatorOrg: intel.com

Fontenot, Nathan wrote:
> 
> 
> On 12/11/2024 4:30 PM, Dan Williams wrote:
> > Nathan Fontenot wrote:
> >> Update handling of SOFT RESERVE iomem resources that intersect with
> >> CXL region resources to remove the intersections from the SOFT RESERVE
> >> resources. The current approach of leaving the SOFT RESERVE
> >> resource as is can cause failures during hotplug replace of CXL
> >> devices because the resource is not available for reuse after
> >> teardown of the CXL device.
> >>
> >> The approach is to trim out any pieces of SOFT RESERVE resources
> >> that intersect CXL regions. To do this, first set aside any SOFT RESERVE
> >> resources that intersect with a CFMWS into a separate resource tree
> >> during e820__reserve_resources_late() that would have been otherwise
> >> added to the iomem resource tree.
> >>
> >> As CXL regions are created the cxl resource created for the new
> >> region is used to trim intersections from the SOFT RESERVE
> >> resources that were previously set aside.
> >>
> >> Once CXL device probe has completed ant remaining SOFT RESERVE resources
> >> remaining are added to the iomem resource tree. As each resource
> >> is added to the oiomem resource tree a new notifier chain is invoked
> >> to notify the dax driver of newly added SOFT RESERVE resources so that
> >> the dax driver can consume them.
> > 
> > Hi Nathan, this patch hit on all the mechanisms I would expect, but upon
> > reading it there is an opportunity to zoom out and do something blunter
> > than the surgical precision of this current proposal.
> > 
> > In other words, I appreciate the consideration of potential corner
> > cases, but for overall maintainability this should aim to be an all or
> > nothing approach.
> > 
> > Specifically, at the first sign of trouble, any CXL sub-driver probe
> > failure or region enumeration timeout, that the entire CXL topology be
> > torn down (trigger the equivalent of ->remove() on the ACPI0017 device),
> > and the deferred Soft Reserved ranges registered as if cxl_acpi was not
> > present (implement a fallback equivalent to hmem_register_devices()).
> > 
> > No need to trim resources as regions arrive, just tear down everything
> > setup in the cxl_acpi_probe() path with devres_release_all().
> > 
> > So, I am thinking export a flag from the CXL core that indicates whether
> > any conflict with platform-firmware established CXL regions has
> > occurred.
> > 
> > Read that flag from an cxl_acpi-driver-launched deferred workqueue that
> > is awaiting initial device probing to quiesce. If that flag indicates a
> > CXL enumeration failure then trigger devres_release_all() on the
> > ACPI0017 platform device and follow that up by walking the deferred Soft
> > Reserve resources to register raw (unparented by CXL regions) dax
> > devices.
> > 
> 
> From my initial reading of this are you suggesting we tear down all
> CXL devices for any single failure? That seems a bit extreme. If I'm
> reading that wrong let me know.

I would say "comprehensive" rather than extreme. It could be softened a
bit to say that any incomplete or unhandled soft-reserved ranges get
returned to pure dax operation.

Otherwise the fact that this patch as is did not resolve the recent
regression report [1] is a sign that it needs to be more aggressive.

So if a softened approach can be done with low complexity, lets do it,
but the status quo is already extreme: end users are losing access to
their memory because the CXL subsystem fails to interpret the
configuration.

I.e. the minimum requirement for me is that all Soft Reserved ranges end
up as dax-devices.

[1]: http://lore.kernel.org/d8d2c310-2021-431f-adbe-71ad0a17896a@amd.com

> If you remember I did try an approach previously using a wait_for_device_probe()
> in the cxl_acpi driver. This didn't work because the wait would return before
> probe would complete of the CXL devices. From what I saw in the
> wait_for_device_probe() code is that it waits for drivers registered at the
> time it is called which ends up being before the other cxl drivers are registered.

Right, I think that's solvable, especially now that some of the init
fixes have gone in [2] where cxl_acpi knows that the cxl_port driver has
had a chance to load.

It might require a gate like:

    cxl_acpi_flush_probe(...) {
    
        wait_event(<cxl_pci && cxl_mem have signaled that they have loaded>)
    
        wait_for_device_probe()
        ....
    }

[2]: http://lore.kernel.org/172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com

> This was the reason to switch a deferred workqueue approach. I do agree that
> this can become a guessing game on how long to wait and is likely to not wait
> long enough for a given configuration.
> 
> I'm open to suggestions for other approaches from anyone on determining
> when CXL device probe completes.
> 
> > Some more comments below:
> > 
> >> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> >> ---
> >>  arch/x86/kernel/e820.c    |  17 ++++-
> >>  drivers/cxl/core/region.c |   8 +-
> >>  drivers/cxl/port.c        |  15 ++++
> >>  drivers/dax/hmem/device.c |  13 ++--
> >>  drivers/dax/hmem/hmem.c   |  15 ++++
> >>  drivers/dax/hmem/hmem.h   |  11 +++
> >>  include/linux/dax.h       |   4 -
> >>  include/linux/ioport.h    |   6 ++
> >>  kernel/resource.c         | 155 +++++++++++++++++++++++++++++++++++++-
> >>  9 files changed, 229 insertions(+), 15 deletions(-)
> >>  create mode 100644 drivers/dax/hmem/hmem.h
> >>
> >> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> >> index 4893d30ce438..cab82e9324a5 100644
> >> --- a/arch/x86/kernel/e820.c
> >> +++ b/arch/x86/kernel/e820.c
> >> @@ -1210,14 +1210,23 @@ static unsigned long __init ram_alignment(resource_size_t pos)
> >>  
> >>  void __init e820__reserve_resources_late(void)
> >>  {
> >> -	int i;
> >>  	struct resource *res;
> >> +	int i;
> >>  
> >> +	/*
> >> +	 * Prior to inserting SOFT_RESERVED resources we want to check for an
> >> +	 * intersection with potential CXL resources. Any SOFT_RESERVED resources
> >> +	 * that do intersect a potential CXL resource are set aside so they
> >> +	 * can be trimmed to accommodate CXL resource intersections and added to
> >> +	 * the iomem resource tree after the CXL drivers have completed their
> >> +	 * device probe.
> > 
> > Perhaps shorten to "see hmem_register_devices() and cxl_acpi_probe() for
> > deferred initialization of Soft Reserved ranges"
> > 
> >> +	 */
> >>  	res = e820_res;
> >> -	for (i = 0; i < e820_table->nr_entries; i++) {
> >> -		if (!res->parent && res->end)
> >> +	for (i = 0; i < e820_table->nr_entries; i++, res++) {
> >> +		if (res->desc == IORES_DESC_SOFT_RESERVED)
> >> +			insert_soft_reserve_resource(res);
> > 
> > I would only expect this deferral to happen when CONFIG_DEV_DAX_HMEM
> > and/or CONFIG_CXL_REGION  is enabled. It also needs to catch Soft
> > Reserved deferral on other, non-e820 based, archs. So, maybe this hackery
> > should be done internal to insert_resource_*(). Something like all
> > insert_resource() of IORES_DESC_SOFT_RESERVED is deferred until a flag
> > is flipped allowing future insertion attempts to succeed in adding them
> > to the ioresource_mem tree.
> >
> 
> Good point on non-e820 archs. I can move the check insert_resource() and
> add checks for CONFIG_DEV_DAX_HMEM/CONFIG_CXL_REGION enablement.  

Perhaps it can be more general with a new:

config SOFT_RESERVE_CONSUMER
	bool

...which drivers, that scan the soft-reserve resources for ranges that
belong to them like DEV_DAX_HMEM and CXL_REGION, select. 

I am assuming that we want to define a point in the kernel init flow
where insert_resource() stops deferring Soft Reserved to this lookaside
tree, just not sure where that should be.

> 
> > Not that I expect this problem will ever effect more than just CXL, but
> > it is already the case that Soft Reserved is set for more than just CXL
> > ranges, and who know what other backend Soft Reserved consumer drivers
> > might arrive later.
> > 
> > When CXL or HMEM parses the deferred entries they can take
> > responsibility for injecting the Soft Reserved entries. That achieves
> > continuity of the /proc/iomem contents across kernel versions while
> > giving those endpoint drivers the ability to unregister those resources.
> > 
> >> +		else if (!res->parent && res->end)
> >>  			insert_resource_expand_to_fit(&iomem_resource, res);
> >> -		res++;
> >>  	}
> >>  
> >>  	/*
> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >> index 21ad5f242875..c458a6313b31 100644
> >> --- a/drivers/cxl/core/region.c
> >> +++ b/drivers/cxl/core/region.c
> >> @@ -3226,6 +3226,12 @@ static int match_region_by_range(struct device *dev, void *data)
> >>  	return rc;
> >>  }
> >>  
> >> +static int insert_region_resource(struct resource *parent, struct resource *res)
> >> +{
> >> +	trim_soft_reserve_resources(res);
> >> +	return insert_resource(parent, res);
> >> +}
> > 
> > Per above, lets not do dynamic trimming, it's all or nothing CXL memory
> > enumeration if the driver is trying and failing to parse any part of the
> > BIOS-established CXL configuration.
> 
> That can be done. I felt it was easier to trim the SR resources as CXL regions
> were created instead of going back and finding all the CXL regions after all
> device probe completed and trimming them.

The problem is that at resource creation time in construct_region() it
is unknown whether that region will actually complete assembly. That is
why I was thinking that committing to CXL taking over the range needs to
be after that "all devices present at boot have probably finished
probing" event.

The easiest is undo everything on failure since that does not require
new code, but we could do the softer, "trim everything that got to the
point of succeeding cxl_region_probe(), and fallback to undecorated
dax-devices for the rest".
