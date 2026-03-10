Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAEF3C3BF4;
	Tue, 10 Mar 2026 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179842; cv=fail; b=HOhSUVQPeKsKA3RPxHNMrqERVRci0lfI5igRsukLMs+QgUY7uYFsjCsQ+Te+hIukzogd3XoPiGA7cjU1V6OWQFnBuF1Qn6IsYoUU47pQt1JjoMhhF4d8VH2gQ+RhjlNUXnyPihimMPKhAHb4JSQ1SuT5qXsYc0CH/RRTYesp8tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179842; c=relaxed/simple;
	bh=kkAvwn5NZyzNZEjOi9K6ZvkaPnr4pcnHYm8CLy+YX+Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c3Ir+HRAW6c9zPwdfFMm7dFP17YWacjhddT1wu+qsn4tY1QZTrPS7OtulJtbnCnBGrv/yHlHAj9A/PVZxyCnceyCPEE2XqcbqF7Kd2Qj85V/XoVbx+Mj1NsWcWi6zw+oC2ISQ7x2i0mpUXGjWxLJFYMss+HF+32atusDSIK00Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mi5g66y8; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mi5g66y8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773179839; x=1804715839;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kkAvwn5NZyzNZEjOi9K6ZvkaPnr4pcnHYm8CLy+YX+Q=;
  b=Mi5g66y8Z/YgKQM7jYusnrhQDfCk6hTiZE/9WgF09gjFP67ugs5dgq8n
   33AC7Wr0wrWifwrdU+qvlh5UPWZbHzbk+LYTwle0KWbQ82CQHnxaWO4p7
   m5SXpTAjmIgcac2m8IMYyLbt6P1olvYc/jxl29YCsN5NEiRkNqGKjFvEM
   fBtm4MHuwMKiNsDlWgXrrB4B2KtDgnoEQX73JiA2iAWExnBK/eZX2aNPa
   E3JaZHnLgWEJzSL5y5wuwZuXWrysBKv4V04AWEOCbB/s3cF2cvLYLbLLy
   xPzzixM9EwBnqYF2OqVikEwLhO1eNC5pweKGiF+XriOs2eQdcksMPuTs1
   w==;
X-CSE-ConnectionGUID: fZjzkwFjSkmbGs8EoBbg/w==
X-CSE-MsgGUID: N5hVOzGCTni5PTFfyjxojg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="96855985"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="96855985"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:57:19 -0700
X-CSE-ConnectionGUID: LYPo1I2oS3mkHREAdAwuhA==
X-CSE-MsgGUID: q5AqJgW8Q7WR0pZAdj/upw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="250748236"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:57:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 14:57:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 14:57:17 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 14:57:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzsR2GT0zC88DcgdBZ5MHoiaetrTIGh8wg2z1strmzLA8x6LLqplGB0xZuiwbFmaaGWt610TkkxRvC7AZ5ylsZGDcfggXvAm4EhN+k8kp4z53n5ZK3iyO4PQRfdrS0ENUHsbCKecXsodQbe/gMIlJe1anppdaYkKnWpnMI7dk8h+ssjFuNJ/utPw3GcPTQPFsaUI5zEuk4sGwsFxRWGlTnt69FyBtLhyV7auOttQk88EF8x/AEpySoPFeUHlGEsFWZ7yM0wi2KlhQALXpIyerx8JbtTkF1Gt4dbY8EibZVxOcsiPH0K13ZJ2IdbEryLZdlsQyO14kFF4L2Kt3kVefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMRcM6zbCp62vmFoq4LJJB6zWy8T6iRBm6IXTS3yb50=;
 b=pB9GjPpirO1kvh6+26VCp9U1IHmDcpDnpuxSQbKzIJ2z16vjckxGBQXS9vOmHxxZ6LehlwjG5WnYLABzjv1mvkmxZic6dX+FAKxY1/BsdSJlzPfga7dyJ63FRyZXrAoLRLq7qaad92P9DWBgADHf6Uht88lCrKnCHq/bPawRzVLsqz7d97YwvA8mHLglrF7NJXUOuCNqs+YaWAhALq3EhxR/RvC9j1KiO5eAm1ekceMXorDLwZyhMV3NyI/MCPM4yIo02Cb7whbcuf8z+F9VR4sFMPyxBeyxEa+PCAwWYbgsZfwjV2n4/besi9JPPDUlQashmQN8LAlv6fNhjkumPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6793.namprd11.prod.outlook.com (2603:10b6:510:1b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 21:57:13 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%7]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 21:57:13 +0000
Date: Tue, 10 Mar 2026 14:57:04 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
	<driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/7] cxl/region: Hold memdev lock during region poison
 injection/clear
Message-ID: <abCTsNbGoOpjAn5y@aschofie-mobl2.lan>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-3-94fe919a0b87@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-3-94fe919a0b87@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 63aa120c-6a10-471d-d73d-08de7eeffc48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: zCAl0HxTNuAtmJIdaMNLhCrP/sZijnaalHbXGVBLWrzEQvGbSfC/9KCkjdh318w1eE3ElRmGwPZjn3HX0pfjTX1VCebujWkBCXOc/8UwMx/oycg6jPQN5Bh82J0+WOqmKKjsCBeLnkKZcZoPZSlbUFdnf+BhIogh7EcxwFuQelVxPU2mbfwnAwWkgF7Y1ZIL2W4w4cfrPoYu9Tz48RF6rKNF7Qi62BeorHrpQoZ4vRS/c8vk9TMQ2FvVB1oEC16n90njjFhrsiPDoDV8Rna9i0hanjH7Q+0XwmhjNAnPSFX4iABwQcvbJTxRw/l8th7MHdx1qRmnVbUOEIrvMHutngMCY9FGBvuv+1xWlUzIeFRQ3VjcuN3Hmm6gnFrdgq9I58eqMFVqvGDGsmr7ndJ+Dr0uTpxIE5G9qUcAaOYC1BlBgjXykjdS/o7vOwWucOFGaCAIQ33BfqI0sWqUT26+rh4e2BtpvLgS5YNZv26jnySfrVl1Gj4D5iYDbIbu4oinb9IeQIa3e5mVtrinYL0Gx//g1wLlbJuK5iZ3Kx95xc62UoXU7zPr+s3MpyF4Zk80pYj415cVxtYVddcH4nq+lDCMA8tU4j1eH03F+Nbamced93gs/mHEvKgBy06rtDTK3P8kYkZIMi1gondfnrC2j0/NE+/83+0Z8jjExYwtr1krIsOx0u2Y4BzkP4gFUEB50EZC2aBlIuK0sCbRLZJzLKQFNnJbrejr6pmgxEGZguc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2hwXoa68Gc4TptQu7fhFKWE8rXtY4ij8tXxRRzFHpshDFfyllvtmkhquEmgJ?=
 =?us-ascii?Q?yxeyp3FtXbCJQaQ8yVZ0E+gt61DRngq346mCXWTyin+2CVu+eQ21aLctlbuJ?=
 =?us-ascii?Q?n6uCLSzF01GBWmLCVRwUJXQP2YZzqYAPQX/YR4zDwyRqVQ64fSHkV89VSY95?=
 =?us-ascii?Q?j9reBB49b9scYxJ+kQlj/VuzrHJ7wjb/TOGfAMJltHhhdhhw40YWn1kRrfvV?=
 =?us-ascii?Q?D7qYvuPGgnH7koDnfiG7iQmcf+MRmX8FnP5pXt2LxnL3eSZgE6PoaDvCEZxX?=
 =?us-ascii?Q?FFupGZU2zVRy+z5wK1C3En/69VZHStqDJK3itqqxb/IibomJqvbBBfTJUNxo?=
 =?us-ascii?Q?iaAvtx2PiWtKvqtcD+bu4HrF924n+F25/hAGyOq4CFMb5eSTTX9IYRc8Gmnz?=
 =?us-ascii?Q?ljODzVVirESE7nGpjn55TDSP3kPgyAvVC84ZN/sfUDB29BzPkxsvKvM6WfdJ?=
 =?us-ascii?Q?Jas6bOCcnryMfn50CNu/+d9o5JVjV711+wEeIpg5d3p5Tj0E0dkD/WXbDu/Q?=
 =?us-ascii?Q?kvFWlXeUGOvDpI932vdpUBf7WmwIuziQx7jE+768LEKity5MW9jjo3f6kDoK?=
 =?us-ascii?Q?nA5OueSs3UwEEQFYQOQKoF54H3vFLnuM8EAM3n0X+KWNALzQ+RUHyepvQt7g?=
 =?us-ascii?Q?BtKDs0NaCeeGCGK2eX55ds0uOW1pQ3OwI7XBFMOTf8MyCUywiufLBVvNwzyA?=
 =?us-ascii?Q?BB0CZpeatB8GjkD1a410ofSHM8KUo5ZyaPh5u/q3W5K+rnHLGg/O3H5xgXdy?=
 =?us-ascii?Q?E9k4eC6eHP1sete3rhqArlb9pQ3cXPZ1snWrtA9jeTtD6rwkhJpg8lWWsVwW?=
 =?us-ascii?Q?nuHQpjCiLRgCloQZ0rnrtgBKtlVz9FYBABUiD5lwqOocC7HefG1DNWse9rM1?=
 =?us-ascii?Q?RcVE0fXm2MXCOejIGUl5IMoYUPxSmoRyOrBziLHUjJrG4+XzYMn2BlDrJieE?=
 =?us-ascii?Q?5cJQO4nEVmoHt6E/StelzSVWy6XO9xsxtKCr45wx1oGRKBZuckqWgekmH7MM?=
 =?us-ascii?Q?21ouuPG0u8vZZ7vaOnenOehFUiz4aZUiwqw1LM71pO5c9kx1bhd81r24GzSz?=
 =?us-ascii?Q?kC87QV2JUwq/1l68ZA6edeOveDnmcoxZ7x5tuyOEvOyIJHFWCUS/vAB8XPdv?=
 =?us-ascii?Q?0LSK7WdSdAzHva6cvw8BgwuCywhO8TWEL33G4zP3C4kwkeshpt1pVr8CHl15?=
 =?us-ascii?Q?BT5qm11Z4fI4iyuhYUpgMfhrqQi0JZXCMi9u3R0cat7CcjuAojzUQqBAffOZ?=
 =?us-ascii?Q?edhl0ubyrQNsqI7qWZdemgPJ2GFqPCDTkGBiCqpVxz4xsZfuc2WLZCwX/9V5?=
 =?us-ascii?Q?L2Nx++iFd4gSY/aZBmAQg2Ed+CKXFlLuFZ4ZDxyO6+VeI8mubakjgGFxjL3g?=
 =?us-ascii?Q?iPh540soZwkrEHiKVbe/0ayZusNaNHFCLdqywOpTjC/3ebiYXJtwG516fcfa?=
 =?us-ascii?Q?f3wGq3iQVKrdvk0awIPMPwzPumNDkyFqd8eLAFJT6YRv9MBzWQik6eofaXTO?=
 =?us-ascii?Q?13wT8eSWDeXiNAOViHhmYy3+QHGrHacWShFiLzz18DawgOnkTi46zmQ/YIEA?=
 =?us-ascii?Q?KlFyoUsORID8q0DUhMQERljD19EYrmyKMfFdcfPom8W4k0De+pMoSNACYMDa?=
 =?us-ascii?Q?NUTlxwgSOYVDdNbVhAe9oewQiIc8NTro8wGVfsNhAtCXcJi6Fa+DQ5Df8nCF?=
 =?us-ascii?Q?GXTQmC85pmFZYy617B1SagSo5lhygF+K0ydHjanJuoFf+3fFmws0aGcAU12Z?=
 =?us-ascii?Q?aFF1Tk5BHo2Hp8xIeLIza1fPSTwh9r0=3D?=
X-Exchange-RoutingPolicyChecked: SziYIXKvreIvFBUr4jr9F5OFZEp42lUyM/L3HO+Sy2rIG71KWtx+oE3t6P7o+7U0TUj0gsOI4cljDo0WXRSRLtKOfmhL2yYNuHsw/9nOsDLu6DPPp+bbgJRh/iWSJSgNqknrR/N9yfDHICOvt/90VSchjFq9IC4zw0/jljppRHDi6Vy9EdUGzcd+8k6VckbgeJyDKpV1bmjvbP2u4DBCb21hHU43fSilhbXRDzvcOsnbD0M1YT5o1yrhSojX6ZAN9ZHNV+w9XffQU9dctv+9FL6IdJCfX5kGgg4PjdaHKgCqFjpPtOjdhXNMk3P+B/CJjJMRioOUuH8YCqHRODnwPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 63aa120c-6a10-471d-d73d-08de7eeffc48
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 21:57:12.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KU+HEruLMMJPd5rmns8FwhwlHHulR39CBaui0ZeCiMA8y41Vt2gUrZjqalHOjCK9tbr2QYFy+Gy+apXEseDdGz2u0H2edoBwTj/74KU7Nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6793
X-OriginatorOrg: intel.com

On Tue, Mar 10, 2026 at 11:57:55PM +0800, Li Ming wrote:
> cxl_dpa_to_region() will require callers holding the given CXL memdev
> lock for endpoint validity checking in the following patch. To prepare
> it, region poison injection/clearing debugfs interfaces need to ensure
> the correct CXL memdev lock is held at the beginning.
> 
> To keep lock sequence(cxlmd.dev -> cxl_rwsem.region -> cxl_rwsem.dpa)
> for avoiding deadlock. the interfaces have to find out the correct CXL
> memdev at first, holding lock in the sequence then checking if the DPA
> data has been changed before holding locks.

This seems complicated, that this path needs to do needless work to
comply with a new locking scheme that this path doesn't really need.

One thought, if in Patch 2 we lock at the debugfs callsite for
by memdev poison, then here, we don't need to think about following
unnecessary locking protocol. I say that because I think locking
down w dpa and region rwsem is enough here. Then there is nothing
new to do in this path. Might that work?

Along w that can cxl_dpa_to_region() go back to safety checking as
opposed to the new device_lock_assert?

I haven't gone thru every case in this set, so might be way off ;)


> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/region.c | 101 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 77 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 42874948b589..806512dfab07 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4074,12 +4074,60 @@ static int validate_region_offset(struct cxl_region *cxlr, u64 offset)
>  	return 0;
>  }
>  
> +static int cxl_region_poison_lookup_locked(struct cxl_region *cxlr, u64 offset,
> +					   struct dpa_result *res)
> +{
> +	int rc;
> +
> +	*res = (struct dpa_result){ .dpa = ULLONG_MAX, .cxlmd = NULL };
> +
> +	if (validate_region_offset(cxlr, offset))
> +		return -EINVAL;
> +
> +	offset -= cxlr->params.cache_size;
> +	rc = region_offset_to_dpa_result(cxlr, offset, res);
> +	if (rc || !res->cxlmd || res->dpa == ULLONG_MAX) {
> +		dev_dbg(&cxlr->dev,
> +			"Failed to resolve DPA for region offset %#llx rc %d\n",
> +			offset, rc);
> +
> +		return rc ? rc : -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_region_poison_lookup(struct cxl_region *cxlr, u64 offset,
> +				    struct dpa_result *res)
> +{
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> +		return rc;
> +
> +	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
> +		return rc;
> +
> +	return cxl_region_poison_lookup_locked(cxlr, offset, res);
> +}
> +
>  static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
>  {
> -	struct dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
>  	struct cxl_region *cxlr = data;
> +	struct dpa_result res1, res2;
>  	int rc;
>  
> +	/* To retrieve the correct memdev */
> +	rc = cxl_region_poison_lookup(cxlr, offset, &res1);
> +	if (rc)
> +		return rc;
> +
> +	ACQUIRE(device_intr, devlock)(&res1.cxlmd->dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +		return rc;
> +
>  	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>  		return rc;
> @@ -4088,20 +4136,18 @@ static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
>  		return rc;
>  
> -	if (validate_region_offset(cxlr, offset))
> -		return -EINVAL;
> -
> -	offset -= cxlr->params.cache_size;
> -	rc = region_offset_to_dpa_result(cxlr, offset, &result);
> -	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
> +	/*
> +	 * Retrieve memdev and DPA data again in case that the data
> +	 * has been changed before holding locks.
> +	 */
> +	rc = cxl_region_poison_lookup_locked(cxlr, offset, &res2);
> +	if (rc || res2.cxlmd != res1.cxlmd || res2.dpa != res1.dpa) {
>  		dev_dbg(&cxlr->dev,
> -			"Failed to resolve DPA for region offset %#llx rc %d\n",
> -			offset, rc);
> -
> -		return rc ? rc : -EINVAL;
> +			"Error injection raced region reconfiguration: %d", rc);
> +		return -ENXIO;
>  	}
>  
> -	return cxl_inject_poison_locked(result.cxlmd, result.dpa);
> +	return cxl_inject_poison_locked(res2.cxlmd, res2.dpa);
>  }
>  
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
> @@ -4109,10 +4155,19 @@ DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
>  
>  static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>  {
> -	struct dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
>  	struct cxl_region *cxlr = data;
> +	struct dpa_result res1, res2;
>  	int rc;
>  
> +	/* To retrieve the correct memdev */
> +	rc = cxl_region_poison_lookup(cxlr, offset, &res1);
> +	if (rc)
> +		return rc;
> +
> +	ACQUIRE(device_intr, devlock)(&res1.cxlmd->dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +		return rc;
> +
>  	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>  		return rc;
> @@ -4121,20 +4176,18 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
>  		return rc;
>  
> -	if (validate_region_offset(cxlr, offset))
> -		return -EINVAL;
> -
> -	offset -= cxlr->params.cache_size;
> -	rc = region_offset_to_dpa_result(cxlr, offset, &result);
> -	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
> +	/*
> +	 * Retrieve memdev and DPA data again in case that the data
> +	 * has been changed before holding locks.
> +	 */
> +	rc = cxl_region_poison_lookup_locked(cxlr, offset, &res2);
> +	if (rc || res2.cxlmd != res1.cxlmd || res2.dpa != res1.dpa) {
>  		dev_dbg(&cxlr->dev,
> -			"Failed to resolve DPA for region offset %#llx rc %d\n",
> -			offset, rc);
> -
> -		return rc ? rc : -EINVAL;
> +			"Error clearing raced region reconfiguration: %d", rc);
> +		return -ENXIO;
>  	}
>  
> -	return cxl_clear_poison_locked(result.cxlmd, result.dpa);
> +	return cxl_clear_poison_locked(res2.cxlmd, res2.dpa);
>  }
>  
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
> 
> -- 
> 2.43.0
> 
