Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3735A2F855
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733448081; cv=fail; b=MhWqWJjcOzm8EtYKo8096mH+vXP8ee82u2rH6s0TN8/8d0onlZ9gYIi0c9a5gDx4n+75JYefxarnkDxYf8SySpmR+gd2AB7km5y3WaedSPrrdjNNIvE9XF6Ct/CaZoS5xP1rXzIHbOgzUTSqecJRedy6jSyneJ8DKTRNe79LAP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733448081; c=relaxed/simple;
	bh=8+298+fkgbApLwOlRmYR5oQadViBfhhsJHunJajJC/o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hhaqDNMh8PmPKkaSr5un4X5matsFsvL7ls26fdL0XfP1FT2Gav/0hAei1h/35llN2fDf7v3I+U9Re2omzJteqmG8fMZjAsKiej0iyZiVqCuyhZs7FRTpg8jdBawrhHIpQv733xlDl2WR5HqoSCP+WfbqMCar4PdTljikJX6b8gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3p+wzO9; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3p+wzO9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733448080; x=1764984080;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8+298+fkgbApLwOlRmYR5oQadViBfhhsJHunJajJC/o=;
  b=l3p+wzO9/ulik4p+5rDRNqpqNEnZCUReL4C8Qyk2R99Ipt/QFeKKqepT
   E+EQqEgPYTfFOiXlnbhp8bf2O5VT6tiylScVLxYpzmp08BmCQ8okzrYiG
   3JLLAwX3AW4F5f3jNjiwjm1dnSMthVrATnH0uOSudAPmqVLqU4+YR6rC9
   ONyXXs4cweDrwWAglmXgOxth3WXJsg4V3Xq+CFWUZUZqbXeGGU0Q/W7Bg
   aUK7vzinlCddqpRLXJIxDDq136YbXLG7M+/ovZqSlEp8enBIEJsLsstGc
   Yt6Q6xAnEBqa4KLmw1NeTmjiKgSrurt8uM0K9PYJqtlYd1giq/gsutyeg
   A==;
X-CSE-ConnectionGUID: pXr5wI0dQlqulJ/8/ZHCxA==
X-CSE-MsgGUID: u2hdEJy7Svap1uOkCjFD1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="45182070"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="45182070"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 17:21:19 -0800
X-CSE-ConnectionGUID: exxB2y64QQuCjIJHyoYohw==
X-CSE-MsgGUID: v+Vycft2SCqZPfMRLRZhDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="131678072"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 17:21:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 17:21:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 17:21:18 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 17:21:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4yFGx4oK5I/dB1iYF0Xsnq63We5iQJfIC17sWmaQTLCaxJOcXSK0Ujp87supLv52l4neDVLO/jaZukouZv/xQd//ZspNaJpcFgnmscmUOiYh450yaKxXUhr8goX6G5UnaetuIohqSaSpDTovn/mjewz/sKu1gYGTYIuZ0R2287eELorklP5jx5UiR3GAuqyEOeg0EPH79yXZ8LKga4wCyeU/h92nxw3PsOhuHgyGAbOhAQyvaFOv9/Ktah7xLJmIb2j421gUF+4ruSDPdBba4lZkLpCLv5XQv2h8hgD4XAZ/q8SKBtxJk/Mnd0TJuUAYAxA2Jj1l8cX1Z9SKbDcAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHyZFSXKE5ChwTqVCQMPpqt1M0OLq71dsLEwFENPf7w=;
 b=sG5Kybu7f1PG88jcvwgU5Tp7wpXgfCyjVxLG4M/uOvuhSpfHT1kYbzkTwQ7E2Q6p0nCzqYIvR5sMfANYf1jYZqBjlpzrxhXYpcE8XOK6F0XcLdkzo/wVTTS2WOBV1r709V++4c0AC7OfForUu++BRp7NGlJETkGKr8s99/F3cv7gskzlRZYfDoiycc9TRWr0LW6NsR6x+WI3UV1RpE1xYenFerKqn20LPOaY7frqNZd4Sc8nuI5SR175vKjPi1F2YB46vfr8bzUrhKfGxxxuD99iqaHU2q8WTB4T/LSBa1u9mAfe5nG+19D8iGWh2BmQosPVBBByRS6J5pXeiA3hnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6723.namprd11.prod.outlook.com (2603:10b6:510:1af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 01:21:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 01:21:15 +0000
Date: Thu, 5 Dec 2024 17:21:13 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 09/20] fwctl/cxl: Add driver for CXL mailbox for
 handling CXL features commands
Message-ID: <675251891af76_250732949@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-10-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-10-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:303:b8::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: e59725ec-5917-4cd9-19b0-08dd1594475b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5A7DsmP++OsEZV2Mv7emL3PJ7zTTF0hohAw37DdofeMZmbdNjCx6tBOWEp1+?=
 =?us-ascii?Q?1kk0V5ILI/V2hwbPVHbmHrWkIuv/EMecVoTdgtAow8KBfNEJluyDk04vsGfe?=
 =?us-ascii?Q?ZJi/NusFjbJ0gn1/uXSacARlLdEmeZFFmL1uaGFmjRyVC6YDP0/t4EOHlso6?=
 =?us-ascii?Q?s6HoZ5Cb1b5is5xkKn2xC72cCCAJY2Immywnrxfj7BkMvkpL/9GOWu8MpEkE?=
 =?us-ascii?Q?plA5NqZXS45MOb2xDtD/kym6nxvsIrPQhX+dc4yAAr8muTZY91yZ5O1SAjpR?=
 =?us-ascii?Q?TBKD5FDvwnTZxbu1sW2X5q9sZoDtcevghYHfi7ppIwNEcaG0Rffh38IIekJ2?=
 =?us-ascii?Q?1R6xS0JJdm8Q5OhOI8jQLfxPNbQy/ZkW2GoywMFdZIcnEwa44Tpoi3FDN/Ne?=
 =?us-ascii?Q?EV6ZxLPPTyvRedgPQdXi5AMu1S80WovjijHx43EHaIwdWiJRySzzEG1LsKhs?=
 =?us-ascii?Q?6MFyZoaJYZ+u7/8B64VpSAUPSu29I3N3NB2QJINhcnsGtniYJ01gf0174wJ5?=
 =?us-ascii?Q?xIBOjdi/RsxiZ4+w0wgXeBmTMkb1lDRqwk8RlFPMH7bVhXnhCuZR3JxOudXS?=
 =?us-ascii?Q?HwBVFgkW+w/QKNTwsGYL3Ui48knhL9Gb+5bKi9Tl1h86ZV0sUSjhLlxkASf3?=
 =?us-ascii?Q?U9Wdcht6NvVvVcs2q7/t5RTnp+rJ7u6e04iqUsSnOWhZI6JG7fV+LZoXP6on?=
 =?us-ascii?Q?NanJQKFrmGkeKCSeoyKz/qjSbf1mqeQ4s5xuntStHfp13sq3hvRwj/hqAlag?=
 =?us-ascii?Q?vUGm/jw95VxbC7oof24dYrI1qwRTtV3mYCvwa9/YHJll/XwT8U0SmguIFF6D?=
 =?us-ascii?Q?H4JMmveVuSMmyt7RuDWGQHGdyoalsmIqIDLjwxnVnAzcfgJX2pikExWc+lAb?=
 =?us-ascii?Q?8p3yzvAEKIBPeFrCAgydwP/duz0dKdDGpOHMDRlmeqKgLXkyrpvAZoBwv+1L?=
 =?us-ascii?Q?Qr+GVfTb2d4L0BH6dCKWos8VJSQd68uk9M9GCM75Q928+CdW0hfSi8xFOUO8?=
 =?us-ascii?Q?/oQbDXz6kDaacXxpTkP4JR6rnqHFAVMbTPxb5dDnlJzhPL83j0mqM833ZJBD?=
 =?us-ascii?Q?ccrf+62Hz++ArjKzqMgOkKih7/e1bqTPSm6nQ4lMVF0ijCIm7EoGe4wTIeem?=
 =?us-ascii?Q?C0116MawGSgToXdgWsNe/lUeu1tW+dLt0Sy3L7wDHdbQ9iGa5erZjNtzEZ6p?=
 =?us-ascii?Q?7EV9eL2aoZyP3VU9QTwz9UY6yB4FhxP3Y60t1b9iQpbap2Upl8vFtggrpA74?=
 =?us-ascii?Q?UIENgk6B+VjxfBWUInvY0ZO8l5jaapPWGsCiG69NsFQ8x/NnSWuAy0O+FlNb?=
 =?us-ascii?Q?dHOl+iYvfZ0X0Gn1zp6xH+BKD1RAONxr52X96ERMgLcFTg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KdRvFHztv22qnAj5ItjOnkecwlDJxppiis99lk3Iea82WwArNZcYF5eV3fKh?=
 =?us-ascii?Q?a4hmAdFvy2Xdgr/EY7A0r75bFhWhbvjqXGcfRe+kzZl8L1YufpL+DLrdXjN4?=
 =?us-ascii?Q?LYFfcX6LTVuJkyRkYTHxrBpgDsu8lXg2EJq0h+T5ixahQ0roku24l8faBtSB?=
 =?us-ascii?Q?Ve+UZ1AcpEvF+6i2tBACewLQrIwkSA23hWLYGUJkZndwX+ABcBI2z7MA7QDt?=
 =?us-ascii?Q?YzXl5s5E9FXAFgyMxNz3QalszggFAMOIqybTzUPylrQIdHIKBGHAeijPuBYE?=
 =?us-ascii?Q?Va2MRivdi6rfk/v6P0lEgUgB1WgDdXCMSszsAB+8DgV3bh9VjalKUNQ87vH7?=
 =?us-ascii?Q?TWSEU7uBgZbhSj12GkxCeMCdorhSsu5ggMoDLoZR4sz4KmUvktzI/fg9LtU2?=
 =?us-ascii?Q?nZoAF6vWC9o7FX7ua5ZEqYqPzn6wqbcwYI+FIrE0vGGFCt7xc+ZsGkI5QJc9?=
 =?us-ascii?Q?sfBLXOrMathJVVkqvp0X+PVXMVUk0ZOsG6RLgNNG6K6vxBfeUG7jZHjBuJ3C?=
 =?us-ascii?Q?8ugZLzJmcycw4Vm1G0WFEteoma4gjIsFU1pcPwCSU6BWpRSKNlzxeRPZ84ch?=
 =?us-ascii?Q?/G5SUNL5rBcdSecxxHxogKvxzz9FmgBjO9mh5sdqy4NyLnV9WMgMx+bJmYOJ?=
 =?us-ascii?Q?9jzSHhp1QfVd+6WenfUtnJ7TcgVXoCcTW21pZg89gDxG7kdAv7oXrkWvk7YN?=
 =?us-ascii?Q?pAdV3+VY1CmNj+19Qa6Ku0iyCQsaHFyQrTgJRI6ZFc0lBIRNJW3Otjf6fVi6?=
 =?us-ascii?Q?AODi7xCUro9KpRICGlfbYZ2bv4itudt/zEoE0zyMzuXJzpn71B58vIRvkZ1q?=
 =?us-ascii?Q?3oAtEOhU9jdbQpH4Yhx2/wGjxa+kaTWtokeSbsJ9p9WwCDRB4HFY9BhKlqta?=
 =?us-ascii?Q?8ShqkBIbBpLNpMBTKBPFvxvqnUw05YMzEqTOrbIMEj8Yr38FdSvyKCiJgVcS?=
 =?us-ascii?Q?mg+5KOQL9VirNhRsl3W8L0dE7gnyWi75bUzhYrsXD5i3C7TKvVdPk8WGOfAi?=
 =?us-ascii?Q?j+Ts2wnpYQAlevu5S193asUYOJtsMDTPwcJa5QbTnI6Z+KOwdovYySWC5l9b?=
 =?us-ascii?Q?w52iAhKe9qeg5jqxoAW1wv3KIXunEQ8/gSzaDwDZIEa5mBru92u20jrOvlg0?=
 =?us-ascii?Q?2OON/N7F9ZMAznwMOEfA3fRWT+pE0O0m1cnHXF4eteJ23tCFhsuzRff7u5S9?=
 =?us-ascii?Q?dg7m/fNG9akn711ReyJxaA5Iwumf2f6hXKK0A8zsY83y/0xsXTYdb6+hj/oG?=
 =?us-ascii?Q?iwThJt0nkkpUyJI83Klfm9CEiNXkOXYsaC69UJTvhccM91VO3gellRrD0/EQ?=
 =?us-ascii?Q?sLdv0tjF7BWmKg4h1RVGipu1gV7MtpYMj3hTovXSaQPMKmPDTFjHmu0DRye7?=
 =?us-ascii?Q?x3gIOBHW+uFATz3Dw+EKuMCLm12I94d0TC1aclo+rw81I4S8zAWo7r2L8Hs6?=
 =?us-ascii?Q?WYh8YKVeZt0G4jcT8pb5e8C/SmT4YbRcZbsZFrw2kE2fNWPC1MZXm50XlwcS?=
 =?us-ascii?Q?fG3A27FeItqWZSSZ56V8Q9Xt+A/Gxr13fia0dM3cVZrnXnFe+hts0G/5len2?=
 =?us-ascii?Q?xPerR89yJH52jXChbp3gMaqkYg3YtUqxHnqtWIRtuaq2dom58wJURnVYh5Vs?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e59725ec-5917-4cd9-19b0-08dd1594475b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 01:21:15.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PmGT71+xoYozGEPDMck8jv3QthowaICRKJ//+17l8z0vJnNvHnYO3gAEbMHQtUKMm5bhUcNGq1BiOFeNDJyVkymlIC3oalJurLKxQikJ6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6723
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add a cxl fwctl driver to allow sending of CXL feature
> commands from userspace through as ioctls. Create a driver skeleton for
> initial setup.

I don't understand why fwctl support of the *existing* mailbox needs
yet another sub-device and driver?

In the mlx5 case, as I understand it, multiple families of device can
register the common mlx5_fwctl auxiliary device to share a common driver
for that piece. For CXL that shared object is the 'struct cxl_mailbox'.

The changelog does not help with a rationale for this split, so I am
tempted to just say fwctl is always resident if your cxl device has
registered a cxl_mailbox and the CONFIG_FWCTL_CXL boolean is set to
true.

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Move to cxl_bus from auxiliary_bus (Jonathan)
> ---
>  MAINTAINERS                |  8 ++++
>  drivers/cxl/core/mbox.c    | 41 +++++++++++++++-
>  drivers/fwctl/Kconfig      |  9 ++++
>  drivers/fwctl/Makefile     |  1 +
>  drivers/fwctl/cxl/Makefile |  4 ++
>  drivers/fwctl/cxl/cxl.c    | 97 ++++++++++++++++++++++++++++++++++++++

Is there some private functionality in drivers/fwctl/ that
drivers/fwctl/cxl/ would need access?

That was the rationale for drivers/dax/cxl.c because it uses the private
drivers/dax/bus.h to get its work done.

Now, I am not opposed to drivers/fwctl/cxl.c as a library that the CXL
core can use to implement CXL fwctl support, if it helps to keep all
fwctl users co-located, but I don't see a need to make it a new CXL
sub-device.

>  include/cxl/cxl.h          |  1 +
>  include/cxl/mailbox.h      | 17 +++++++
>  include/uapi/fwctl/fwctl.h |  1 +
>  9 files changed, 178 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/fwctl/cxl/Makefile
>  create mode 100644 drivers/fwctl/cxl/cxl.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93f74bc58d99..6b52c4168b94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9389,6 +9389,14 @@ L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	drivers/fwctl/mlx5/
>  
> +FWCTL CXL DRIVER
> +M:	Dave Jiang <dave.jiang@intel.com>
> +R:	Dan Williams <dan.j.williams@intel.com>
> +R:	Jonathan Cameron <jonathan.cameron@huawei.com>
> +L:	linux-cxl@vger.kernel.org
> +S:	Maintained
> +F:	drivers/fwctl/cxl/

I don't think we need a new MAINTAINERS entry for this. Just extend the
CXL entry:

@@ -5772,6 +5772,7 @@ L:        linux-cxl@vger.kernel.org
 S:     Maintained
 F:     Documentation/driver-api/cxl
 F:     drivers/cxl/
+F:     drivers/fwctl/cxl*
 F:     include/cxl/
 F:     include/uapi/linux/cxl_mem.h

...and call it a day.
