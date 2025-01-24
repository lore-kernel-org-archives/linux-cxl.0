Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CDD1C4A26
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 23:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737760520; cv=fail; b=G+mE/fNRrrCvM/uCMrn9b2acSY0AzalpAuQG5USz7Y6pbLnMj2prHClULAOhzLNjsEyB7+8l+fmuirnXSdQNiLnRh3qm/ipctjX1xqPqmeHIz9lVgB9Tv8Dj3IQf2/ZDWJ7WtXUDAiiyL/LxBrBf0JcJDkK8lZdmrGcmsnq/O/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737760520; c=relaxed/simple;
	bh=OxJCljGAyyUw0a2zcp8EcTsDZjDgay7/CXE0X9GiWoI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kFyQnpWrOEwZqgPVT4IQ75QXoeXJyYKW2S1HADDw4FAMoH5zPsEIdH/ay5Gnkmv+vgLUTzwV4VCTvC5Ul4H0sb5F/utlCh5ltGSYYTwLL1nMNjt/ILX+lcnX+GFINxahKgsyKx42U/c08BksvWWXXisrmZBOAa93ntneayor9gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XdwNe5Cd; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdwNe5Cd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737760518; x=1769296518;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OxJCljGAyyUw0a2zcp8EcTsDZjDgay7/CXE0X9GiWoI=;
  b=XdwNe5Cdm4UZIsCiX2IZn+jFd1VNbLHzOBpOoAsnIz1Pi13DzjERa+CJ
   nD/SI1GHMbfhsGcOV1B2ei+TXIeX4T5MloHXpbtsIYBOlHizT8hmc5M6t
   5ew+mY7wZ4ax5YJbnacqP5KLFvedAzLUkync+DkqIDEsoWN3l76JqIYp6
   nxxfkVHHoDU7pAPf2QeRGZauAdSyiK7IT0kxSmJy9v3Ekgt3Nquuh3OpH
   K9hkVJNbC8pPQwVM0W6FEDgv72bKM870ZxWT36ecxGyGtWsOrTyBP19+I
   lPM1shTu+DthJk9r3YI91LefKoG/y49AwPsgeo3SggxPfuqvZJgZpqJ6V
   w==;
X-CSE-ConnectionGUID: 4aHYyQFNQ4ec6E5239pTlA==
X-CSE-MsgGUID: zgS2LHesRju46xxmIIBBJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="38450599"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="38450599"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 15:15:17 -0800
X-CSE-ConnectionGUID: Mbqel0AiR7m3uhk82qKT6A==
X-CSE-MsgGUID: I9jk1K8VRt+23kRMOWulSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113038682"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 15:15:18 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 15:15:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 15:15:17 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 15:15:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjYZLx4eWVqYlz1JFMSBA9gERUq0HWOXwjUC7nllY0Yi6RC173zm//+zie+fsxA4wOKungAWbvu8NDuc1tKu73vF3HGbxPYF/dS3rLAt3d6TAagDjzXkvYjPr+F9YlbRXzNubz+1dzLyWWlFL2wE8bLF50q6c6GxYvdsMhJSKbPyIv9I1IPANp0PSIA5JbI4Vw1xTjZMGvm1yn1zmU/OSHtT71S1WHQHruzYHOWfR1lJkF4oIAfaS+qIAug3Ss74u1/hOWmEAWmzbqcgYE9UC3Rm79H6j14fKq+PSsaFwsN3mSSoT/WLWj5d61jv1zpiV7T2RPPHFAIs5Nj6fIPhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81LhGa6igpRbbarzMCfY4amocTAslU+c0XHAdS5G6W0=;
 b=dWroJvUn+4nGxhY2HzdAhRkQEKXifipAdceXt0/2vgkUhk8UytCcOpqT+jNcJEkbEb/Pebtq+xzAaSoPEybCkB5elZEatLWCis2qmUVhzj3wfTsbcriKLwOoWmgE1iKxpsqkloHJHm45uqOJybnfbAdM7p9N3/GyM2t343/cADwGeDgt70weMeZPZqoPm8K+yrqY2ugdvMBQB8bcuEg+6rCPR5hzNVGpoKdxaYiIePp5CZxwBLf4M/SU1niq+SjkKHGGB417AXx4t7aCK4QdbCGAt7GrwpNECYhUVFS6ky4/YrbLHxp/v86ZRlHOg0YDSiRbmRXQXb7BuzVh6mS9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5302.namprd11.prod.outlook.com (2603:10b6:208:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Fri, 24 Jan
 2025 23:14:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 23:14:33 +0000
Date: Fri, 24 Jan 2025 15:14:30 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 10/19] cxl: Add FWCTL support to the CXL features
 driver
Message-ID: <67941ed6721ec_20f329473@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-11-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-11-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:303:8c::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5302:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d39a48-57ba-4a57-3c45-08dd3cccdca8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WJ0+7udGGdOspQr8TOLpXdxKhrDweuQWIr561yjR9wTfiblqN4JDIkSAWd2H?=
 =?us-ascii?Q?eOGxJNyR36UtGYEo9DI3rAGoPpGE88LQtXJhKzeUHsA5Gcrh1bZza+t2VZwS?=
 =?us-ascii?Q?vGQrS6kDK7OXa4kObe2cYYLRVJ6bgTyKVuUGf4qDSucHEoEoOCd3bRLTFUj0?=
 =?us-ascii?Q?cSoB2saZeKsuGKD5mBCmHHihwKhl95BCn7Qhiyokpl6gsvLBroIxjnwdEYy2?=
 =?us-ascii?Q?AkGn4zKp/o4HUEYlSF+Gq27o0EOS/19LehwOGg3TetWWYDFX3eDG+1BX4fC0?=
 =?us-ascii?Q?/J5MLzqrIWhqvE2sphnQuYGvLyILyIq4wzW6z5p87NC67NHpNcccPtfueEWq?=
 =?us-ascii?Q?dNOUFaxOhQK8A5riB/YdQls4p/nxLoeGYRNwV2080mI35/fgo+nfKo73eQBD?=
 =?us-ascii?Q?D10t2y7WgGWx9tgONU0kJtbK3/9l09UjYZQuILssoKpRs2qHC/3ddqWSbPAl?=
 =?us-ascii?Q?ZoKl0V44P955ULsOBztD/f83NqRhdi3UyeO/HVLGy2KEfdM8R5UvgCmersQZ?=
 =?us-ascii?Q?3fbGiZlK/wdACMS171gOylUIU1UeOVp0In2Kj/VsCXoTiZ9raR74gSmuVPiC?=
 =?us-ascii?Q?5MSib8JuKvx6TOgnUxRKz9ia2BvMI4rW2+Gy8oL/JIvpRlNPliiU2uAEHTik?=
 =?us-ascii?Q?3Yoa7FLO5bIJlhSCcHLcL8OxuJkAOkys8Z4P9z8HPsZDEzQ26GQSDq2rH+ak?=
 =?us-ascii?Q?Y5hjpKeiIr1IaFOpGyiRAp0dvDEPaHgXNi2nMFGltwtpSuZTRdtkwObGTBGC?=
 =?us-ascii?Q?vbl1D2Lohnosq4bVG7SD0Sag9BB8fHAS+HiM+EHqv5Pr1ldiDKaSXvxF3sGU?=
 =?us-ascii?Q?OEWlf2MCGdSmO8LExAr578a+RdMQUE3bTybf/K380z1ujK8SGu42lUjd6ePo?=
 =?us-ascii?Q?rK1L2ailHZfJOf2OToavaxOfwepxw03VKdZWS9463GvVDKv6HvPs0hIy+Sk5?=
 =?us-ascii?Q?jt3CDwEgP8ntqp8sG5u9PMTDDaKAmhkWOlH1sM3oLB0YOndtMf6w7jdh+7Ma?=
 =?us-ascii?Q?xfK9DTANxwAYTQl43qPg/ckNJMa6n5Zx3YmwnB+t8Z7MMnW8BP1Em6701lPx?=
 =?us-ascii?Q?G1fCUw42+lzBrd37r4oIyvJm94WQANuiobyHW8teYVUJlWhV7jEYHD1KG9LA?=
 =?us-ascii?Q?C4idxafRhUWBPlSjUDJ53NiWCpwifFYKjSo6FaVJIs0w7CMe/Imn8aIj8o/R?=
 =?us-ascii?Q?HHlI83Tx5pFj6uh29MPejpNGcwV5ZUGfUHnuOXP2fvML0rMelpJgV1uEMPtx?=
 =?us-ascii?Q?+9yrqN/hPnQt6SVBMIhUVLYh7LBMPqVpRjzPZA6tsZBGapmSxFeieIxvtOYM?=
 =?us-ascii?Q?hELEdg7rj9v4qJIxGxryTw2f42bhS0rcm6JinpCp9i/qBuJNoGlCLzo98wHx?=
 =?us-ascii?Q?9rnRi5wawS+uGjoZvtCsu1pjuWuV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BEC+OMph75Xuq1OPA3cEUOlGGG23SyhzmMr4pvIW0dS5/hgfGiuEl4UQKM/0?=
 =?us-ascii?Q?Wu52eVOrxQ5wiopUesmzso6MzmKpaCGVWNk7qUoeVgwRv2uzBKZ3KfnL0H7b?=
 =?us-ascii?Q?DyoITWBHvNOkJJO8CzVsHI8XY8r7RVnVpWpyPXuhHLp7oTBUdfHYkGcyvw4v?=
 =?us-ascii?Q?PJtmgHjzCz1vTFk77UrKqV4pALjYi1wBL1IxtkYaGNmmI7lURhAzBKl9BVTG?=
 =?us-ascii?Q?b9OQMbTjM173I7ETZmxrOSObc5+Y/efgdUJt56SWOZ94eQAUlTQchWFqd3Ic?=
 =?us-ascii?Q?ql8w0oJtiWpeWjhL7CY22OybYy92BQm1xBHQWfnXMLeYQxYAf4XWpJJft3Yu?=
 =?us-ascii?Q?nbqr4OLxLgthAHiHAGXVkYilIu5zqm+vM3LF5/DrhBUxMBH0jxVAIdxiDdu/?=
 =?us-ascii?Q?Yv3wMYh4fR+MvgmT6gRAKMQ2QXYMMjUCQKbVVM1ISF8qfYGC6IQkZIa7pRk8?=
 =?us-ascii?Q?IsGWuRc0lFNv39Y12Aysi6y4wsXCai0lMrLCXTR1QPDcq9ciKSb5GJy9JSrC?=
 =?us-ascii?Q?Hg2mWeQvLC95s4UC/Z5nb8ougJ0+I+Cj83K9vWKgmm0IDAEJIQ+hS5oQE32H?=
 =?us-ascii?Q?/FDPetYekeUF+4pI4P+MLWB3lETo2qATPWjDYgPs37ZXVBMDptpfnvPHcE3p?=
 =?us-ascii?Q?P8qME9Jq7JJUXEQC/UUoPmkxxdTDpqTt4mPBMUdC1IhuDXYnlaZ6X9xNanGf?=
 =?us-ascii?Q?Mg9uPYFh3TX1hj1W5gsHkA3z0/6iWcZhof/zfWaqondJ6VPtGkBWajN+ah9d?=
 =?us-ascii?Q?A040EOubVvaZq/t12c5HNolds4ImgjLA9RBCiaGSgYnN/GvCMHxeW0UAp9kJ?=
 =?us-ascii?Q?CZp176nmxI02HOmUCTSlYpc8mjsk3SURvwWqwZrinAGA/9VA/OUWmhx8uWLX?=
 =?us-ascii?Q?BTSjK9fpJBAeycM8lI+RS7R2HF5+b5fLUrWk5X/0Ky5gefBiTSt6RnuVvNpO?=
 =?us-ascii?Q?zf2du8CMU9EQ+V7opRsURFoWN/SufR1a+a3IRayuR0J/vEursTN4oWYazjGn?=
 =?us-ascii?Q?SOS9oahVGQk1AKV1UvML+oleSn9mI5vwMn9mFcSje7PDEbjxguGH2xki6wf+?=
 =?us-ascii?Q?wO7tGJ/7UrqUvzJ37p8vLnouTV7/ave2k88nULltCpykldWXu5JrgotJYwFb?=
 =?us-ascii?Q?GKY8T9hjxg77bEwrWhHPD9zkYvjKz1d/uh0kobOz5zbptrh7U9U2tttM1rZT?=
 =?us-ascii?Q?xs9q7DLAzTbba+HEZCydok/jCbqMwH83kb6quxdrx2DDFUg/EGKqE4NWI1wb?=
 =?us-ascii?Q?Q4ABkmF3TA/ckx4et1l1js1g/RYFa3aRVtKV5B5d8m7V1XZjrbe7P2b2JIEs?=
 =?us-ascii?Q?RRnP+xKZ+Ycccegsc8cxeQ8mIVpZOq+knFi0LtacZdrbJGOECiUB3FynOmKK?=
 =?us-ascii?Q?FOsJ7avV9sNb00613j6ZPAgYWU8dTWU8oe4y8WYlnMUBpjIv8HImBGbRiVab?=
 =?us-ascii?Q?KnHRuo3MWvmNdra+Xdj5OnAalBMZ+6FUXk52R3tNbdwg3RVJYMXdY774H/MO?=
 =?us-ascii?Q?e3AuWQA2XfdvT8sIyXL12/SUIT7nhSbx+F08n5kWmIaZ1ArHREwSO/ejMlTk?=
 =?us-ascii?Q?aFCScsuSJ1sJ0owEOEEQ6Jwcp4TQemLXpnunkegs4kMw+eXXk9aDOFbm5Tig?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d39a48-57ba-4a57-3c45-08dd3cccdca8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 23:14:33.0878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCDACZdHYOAY+70aBY7M4sIoR/UfA+0ikFc3To3FKB1C6kZvfIaGN02trFaAvy6khenOtGYduLwWkm9saERJRRcGpMLf15KEJ1OG8xjz2MY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5302
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add fwctl support code to allow sending of CXL feature commands from
> userspace through as ioctls via FWCTL. Provide initial setup bits.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v1:
> - Add missing dev_set_name() (Jason)
> ---
>  drivers/cxl/Kconfig        |  1 +
>  drivers/cxl/features.c     | 44 ++++++++++++++++++++++++++++++++++++--
>  include/cxl/features.h     |  2 ++
>  include/uapi/fwctl/fwctl.h |  1 +
>  4 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 9a6ffd81ac0e..5de06c3806ce 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -148,6 +148,7 @@ config CXL_REGION_INVALIDATION_TEST
>  
>  config CXL_FEATURES
>  	tristate "CXL: Features support"
> +	depends on FWCTL
>  	default CXL_BUS
>  	help
>  	  Enable CXL features support that are tied to a CXL mailbox.
> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
> index 1c4bcd7465cb..5a2b771586d3 100644
> --- a/drivers/cxl/features.c
> +++ b/drivers/cxl/features.c
> @@ -9,6 +9,37 @@
>  #include "cxl.h"
>  #include "cxlmem.h"
>  
> +static int cxlctl_open_uctx(struct fwctl_uctx *uctx)
> +{
> +	return 0;
> +}
> +
> +static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
> +{
> +}
> +
> +static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
> +{
> +	/* Place holder */
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
> +			   void *rpc_in, size_t in_len, size_t *out_len)
> +{
> +	/* Place holder */
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static const struct fwctl_ops cxlctl_ops = {
> +	.device_type = FWCTL_DEVICE_TYPE_CXL,
> +	.uctx_size = sizeof(struct cxl_features),
> +	.open_uctx = cxlctl_open_uctx,
> +	.close_uctx = cxlctl_close_uctx,
> +	.info = cxlctl_info,
> +	.fw_rpc = cxlctl_fw_rpc,
> +};
> +
>  static void cxl_free_feature_entries(void *entries)
>  {
>  	kvfree(entries);
> @@ -146,13 +177,16 @@ static int cxl_get_supported_features(struct cxl_features_state *cfs)
>  					cxl_free_feature_entries, cfs->entries);
>  }
>  
> +DEFINE_FREE(cfs, struct cxl_features_state *, if (_T) fwctl_put(&_T->fwctl))
> +
>  static int cxl_features_probe(struct device *dev)
>  {
>  	struct cxl_features *features = to_cxl_features(dev);
>  	int rc;
>  
> -	struct cxl_features_state *cfs __free(kfree) =
> -		kzalloc(sizeof(*cfs), GFP_KERNEL);
> +	struct cxl_features_state *cfs __free(cfs) =
> +		fwctl_alloc_device(dev, &cxlctl_ops,
> +				   struct cxl_features_state, fwctl);
>  	if (!cfs)
>  		return -ENOMEM;
>  
> @@ -161,6 +195,10 @@ static int cxl_features_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> +	rc = fwctl_register(&cfs->fwctl);
> +	if (rc)
> +		return rc;

Repeating our offline discussion...

After looking at what cxl_features_driver does and the fact that the
EDAC scrub support is enabled by registration calls from cxl_mem and
cxl_region. Let's just have cxl_mem or cxl_pci register fwctl relative
to a cxl_memdev. So, similar to how a cxl_memdev hosts an ioctl interface
and a fw_upload interface, add a fwctl interface with no new
device+driver objects.

When / if other components like CXL switches want to support fwctl that
can also be had as just a fwctl registration relative to a cxl_port
device which would have been awkward to handle with a sub-device+driver.

> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index f9b27fb5c161..2c3817592308 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -43,6 +43,7 @@ enum {
>  enum fwctl_device_type {
>  	FWCTL_DEVICE_TYPE_ERROR = 0,
>  	FWCTL_DEVICE_TYPE_MLX5 = 1,
> +	FWCTL_DEVICE_TYPE_CXL,

Jonathan and Jason already handled the comment here.
