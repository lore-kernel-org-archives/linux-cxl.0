Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CE820FA94;
	Thu, 27 Mar 2025 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743081753; cv=fail; b=s58ajC3Zpet9PPmTa2B+6YX8JdE+wB2nHwccF3k7ki1MBT/OLG+98sO5NiGv+PQNgNfnF9fkKZNat69cQr5tnzC7Za555dWzteAVFw7z/Te23IqCGNJDJzVK2MLJw4hRREAlnIZm9eG7AB+nWSU01VwJqHggzZfiIh7hdzqCXNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743081753; c=relaxed/simple;
	bh=dyPu7SkpSH7tDhi5wUqGnIJTN9kqR2FMNRLIjb4X+CI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c7bT1+fm1TzNzFdiWSCs8ltwBfqGvtL5kw4gGRJ82FTmfGtYm0bP7tH83/n1CrUkv51n+hFNB8YsDhpVcPKwBQaO2qAJOcFcn7AVm+xpZnJl6KQWoFZtn3bpSp2xfIfagqvPcpGyYw87r5NXVYpTcRW8/km5SM1ySQr64RGI3Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsUnhIs3; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsUnhIs3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743081752; x=1774617752;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dyPu7SkpSH7tDhi5wUqGnIJTN9kqR2FMNRLIjb4X+CI=;
  b=ZsUnhIs3erWRA3mK0JbYY3W5DYvBcx3Jxc//Wh1J4Kxh25WNIf/Q8mJp
   yLLUcj2CL3J3bf1y9hSy6DApp+W7JWuoRtGtSN5rb93bheVs9NJPLXsrH
   O+fV/o2sjkDOXCKqdTYxQxTouXUfKrcG6WhZUfe16/YLYwk5EcUVwipPJ
   P992lw+Y+Ifr9fY6FRCwovcjaQr2L0k1lFHYVxeCsNmDfWrR7GU5FBeih
   gmJkGIAofR0KHeWXsv+4HoMl9uPhdjszLLq/07Yz93yNGz+GTIC/tZPOG
   fjawKDvLJ1F9tn4Uxov8vJltH6rcD/H5XynqGLJhywD5RvFyOJxvFrxrE
   A==;
X-CSE-ConnectionGUID: i4sTDzlxQmqH9d+D1QDaGA==
X-CSE-MsgGUID: BZCOg94WTSqSboe33EpHaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55782728"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="55782728"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 06:22:31 -0700
X-CSE-ConnectionGUID: HWioK3C1R869x+A23o+Thg==
X-CSE-MsgGUID: CS0VSO0DR/KPrWxBIZNz0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="130331412"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 06:22:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 06:22:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 06:22:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 06:22:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viLTsEYaRG24mNav1dVUKlWWDQxM8Nre+Gs24/rzrGhaLKVIJBz74jgR/TKkyQv1EGrPZFcpFpL1OL33YIwuKCKg7MAn4o0Oxsq4Zt2pCrX3ehIfBVyGq4vByAZLquWKBn7Wb60HbxKldOZ9r7pbrBtInRUQVGhgkFSk6Bwoz8xCwlN/0Q3PC4K5sS5l2/qA4BoYJiywNYoo5nWuXvqlaCAXGlzsIoFxqN+mRDRZXSGUysojuUq0xWxoAuwL7QJhmSGZHZC4vUQHb14YbGGlWH8EDV5anGzIICCdNy23ZSS4kHdQLwCa1MXMHGG1OAy7JzugdWrfaS4r8kQTeolDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUSv37GPlj6GX8SRgrSpmWwzS4TxtLZDWSyEIqi7gmQ=;
 b=tXpQl3Nxrv/KV4YCIRL4GD6ejGqBU+kpafGk8RBQCB0qy/fONtpEeXOi7WXBZ19KE4luaZQ6Ic2t1k+WpkwUUuW9NvYOoLVRFDILJ7ZDft+wKzNlknP6y7IuD8jwDRLR2U6qblebTexwifd+VeruJJY4lXHSTbyvPOJ4M1JZM9cffOdHkTdEm9Jd1OpN0BEt1vwU4gfby88u4igvD6abQWW8xkFQ9VpTCKA5I4xv7MxdxUdNV/8JWjml7Siada3XKQzsyU0JkOpsuyDnMJ7Y+qzoAV9kIHm8nrXlmt3fbAGTPB6AYxtQdPvvi80UEMLd5IgANUMgJAUEPQgQSr9Qyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7630.namprd11.prod.outlook.com (2603:10b6:8:149::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 13:22:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 13:21:59 +0000
Date: Thu, 27 Mar 2025 09:21:55 -0400
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<lsf-pc@lists.linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <67e550f39d57d_13cb2941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <20250313165539.000001f4@huawei.com>
 <Z+Ubvvrj9DovVs71@phytium.com.cn>
 <Z-VGN79KVjuRg41K@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z-VGN79KVjuRg41K@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: MW4PR04CA0324.namprd04.prod.outlook.com
 (2603:10b6:303:82::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e74ef1d-5805-40e8-9eb6-08dd6d325aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cYt94xj09CLkXHDykhr+WTjEqJFYvn5qPPCX7MgIPxKKjJeckAmVYh8mRWDr?=
 =?us-ascii?Q?4tlX++36fqF3a493DSPMDZnIGJaZbBDubsoXa/nEF8eCzUczfQQRxg5wK6jt?=
 =?us-ascii?Q?1varBqNn6zDiRv2yFk/X1y09NfGwvV49O0zyTaw8ySONlhUolZ5n1m5G2R0D?=
 =?us-ascii?Q?t3NcWxjhQxPILol0e/zBGzxynt2Sx3fqmhQqf+xlBOrtyWWwgOOMVJ4IfN4T?=
 =?us-ascii?Q?4DuybrhhOHGq/5BFVGQOHPsx/6zhrzzoH4K/J+TVYf6Cad+KRgCOMNGIXSGF?=
 =?us-ascii?Q?Ed7QhLYwnpgXQxl0v7VwnZLPZF3y9NYWXbTs7TZpG4O4qbqtSXugPJzcJ6Vx?=
 =?us-ascii?Q?u9Y1qyqIfaxLdP3OwafGn5BKrXOeGlMOreULBr8gqUO41e/pccqAsae15+KS?=
 =?us-ascii?Q?KMMuGr7JoSLpMB4dtnB8rcp24Zol6H1fwlNY2vA1vDd3gyYuOveeojVxAzMU?=
 =?us-ascii?Q?3JKxxBQRkHmB++54py4YPaZz/1Oi5aacQjZGo8JcFx62R9Z0j7hv+Rj5MQ5B?=
 =?us-ascii?Q?K3q30b+f8ND2pInUK4LGPxwf7quN+VCh0MnSCCH5ZrEQ9TN9RSDTvdj6xEb9?=
 =?us-ascii?Q?Xg2anzdJHXESeMlItN8tGbMqOLe8Rx/J3FCFN7VjRi5Sij1wlgKSQizVfSOS?=
 =?us-ascii?Q?dwm6wp00/8YjeZKfJ1LU5JtukfkmR7sYJ5knwQz4lcw5On2tG/o6S3LMDTgC?=
 =?us-ascii?Q?zl0HHjcTAwdHlrDts2bxv84WeAb891p6yChrsNTbLSeFIu99M/jRu8RKELfY?=
 =?us-ascii?Q?tkerbM83JBkHgiChtYxkyzTokdirCXar+6y9PO3WtIiJyRyUcdrdsYmZbRFO?=
 =?us-ascii?Q?NVrOfpEtgyRn8ugVjqz9qvBlxH/+RqhGsho6mnuRcnL7b4+Lyb2wwkotfJCi?=
 =?us-ascii?Q?RvPsa+FSrs3AHODA5BJApOSGYGsGi0I3q/hZsOl5B2oHxUicCeYlX7jG5zC1?=
 =?us-ascii?Q?1CmVJw8OwfDu0NWpy0ockrQkQ6KYcNnw/+HR/9P5Ff8hX+kf/j+4ZaVpDJAo?=
 =?us-ascii?Q?JyKcCBGsRedURXArNoxkJ4ny5Vfgv5miilUl+MCSBKJack99OVDPAybXEyGv?=
 =?us-ascii?Q?u0XYFSBSlknj6uzmiAtKBlyaL+qUDl8WdYT2iU4gD09XSZiqojmxvuwT2aEJ?=
 =?us-ascii?Q?GMKYoFKSycYCcZTPYIDxmCCH3bFv9hLR/EgsjXxE5oDx5L568i8OCcDjlAEb?=
 =?us-ascii?Q?f7aXOurfs6Mqzjhx426DCXQHNx8qJbZCaWCp/i6nIWwV0ZvxroYRHEvd8HTM?=
 =?us-ascii?Q?9uS6TIGW8D8TNKYHKZLJiayxSj96n7ICADr0oTLkTi2oUa46JrvtNRDpNWZn?=
 =?us-ascii?Q?yeYf87PgL1p3wbPWtnXRwP6n2K+944r1h+UQyEPFUCej0+9GpHN6uFgVfr4o?=
 =?us-ascii?Q?RbS1pjzMC6RdBUTpv3Q/fujgUKF0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N255rndu8nLl5fL8iJwBKr3k0wGkUREemrRIK1DOb0trmTx3jTM3EFA6meB7?=
 =?us-ascii?Q?hKSJrbInFj+lrmPGQ3LiG5tfisd/32hLYFftIvaYZFUuNZR1JHC91L9/uHvs?=
 =?us-ascii?Q?CTcUc9UM2tKpgWFyASMI5Bb9DKdBpD2G28bVv1Kcdf1w/UjhBclid6tt/SYj?=
 =?us-ascii?Q?avPh+idGV9X4pTZD56DN+hSp0IVXSorsoBbuQFnSOJ8oxHEza9XIqh3Z8rnU?=
 =?us-ascii?Q?BTRKXuitpAPp4KlA0pfZFZUP7u4R40sZLBfTd7PHfzQnZMZJk/nb7aeBvuH+?=
 =?us-ascii?Q?aN5DH9ZZXAkJgvegU4VTF7XbNL4bp2sdZG7WFq3DlBHK3tESttVjZmvDmllg?=
 =?us-ascii?Q?UwqPwppcZmqsBxwwsUonO5k5RWNiI2i1mWNmnBf6+yHext8V21oHAszPpd8C?=
 =?us-ascii?Q?fUdrX2ThVxLGaJ4oNgHhcK3pKGjqSItWtKxfHgGZGvazsqEEjUdWmKYhkyC/?=
 =?us-ascii?Q?NVhjLakOjRoAtHty2Sw2XDuDXq82h4PNub+SMhMUN737PQzMavyy5sOVdsrD?=
 =?us-ascii?Q?MX4fPSROr2NB88F5ZGzO3eoV5u54CYrM0YPgG2Sze979ScRoEGEODKNWMJFH?=
 =?us-ascii?Q?GfAuJ1D+IOZyHHI9aWfT3tG1x3MDHoeJgUMaOaY2Q0Sijj++Ku7WgbS+kPCZ?=
 =?us-ascii?Q?r53rzGxhwJmPKqb1OFsYc6B1BcKlK5nyy/HZjalgHCGOk8dYb6Aju3i167si?=
 =?us-ascii?Q?nsEPcaCabRqRjG+Dn6V/BcQkLq058tmmmmPKJIeX1gUeRUsT3NwcxcY9gMFx?=
 =?us-ascii?Q?cqh6qLVHyOs7y5BwJhFNDrsvc2LhqNgW+GvsevM/CBUTVJgA22Ggq2ZPTxZ9?=
 =?us-ascii?Q?7gJvGOQKa3VLCw5clfmu/8/BqHD/zMHiPI582kLRbsj30bbpU47rzU0hm6Zr?=
 =?us-ascii?Q?hjgwfb4sL+5Quc16Kn4Mcjr0sBWeB+HCeocqi4jpNM6aVl8H9+e5ekeyoke9?=
 =?us-ascii?Q?4OaRnJWoIHuxsdbh13auBiwu2j8OMP89sqpwRkX/D6MeO+4VYIQIKygvggpg?=
 =?us-ascii?Q?IDZDvH/Z+e1fFSqaN91N4nOM5VzZAxLOrHCGalVJmy6XjEUIp46WAvwvaSmN?=
 =?us-ascii?Q?7wy7F0rzNJGH+HpuXtUJlv6fGPglJSkNAzVShHS64K5doZIfXmx996VjqW0S?=
 =?us-ascii?Q?HzAGm7/aeFAWg2Q2IaX0rIckMQGXaDlaec0a3W4bWOEvyBeVCwzEFJCMuoh0?=
 =?us-ascii?Q?q6AJ7ypezGF91pjabk9rtNA3OEzpZE8vKg22evrRPZM8Wi6uwAfp1bW8sIIZ?=
 =?us-ascii?Q?hUS9aiLJ74s9ggax2gBKkvstqI2XWex7jNu/Oh3DXXggoNTVmy/7gp9SGscV?=
 =?us-ascii?Q?TNf2faFAukyBRcSTfKV9+HNG2Q5Vm38+5POdvnWeuwdLVgvBp48SNssYEc1x?=
 =?us-ascii?Q?j2og7L55UxStcHPBVV7r0HcMvxRBNPyeQns/vdaJbyAaBnZp+7+wo4cg623b?=
 =?us-ascii?Q?q3ZyGYYrK5EgtmeoBa845NwiqG34bh/amQWbBrN6N08W0WGmdEAQMi+mzIhm?=
 =?us-ascii?Q?3u3TBcFWn/pJlkCZU7y2lnmMx6zfzcMSkMNux8wpDnQFUeVv3kpKYTgk4AN/?=
 =?us-ascii?Q?uAqP11XI1IrklLmip7uRLIcNiNcTTWUdpGVfFrbyMxPj0AfrWRkXXIXFgIHo?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e74ef1d-5805-40e8-9eb6-08dd6d325aba
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:21:59.6194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j81xmvasBoj6mXaLnmGrT0qEXeNiPVFlTEcszqayveg1YeBWpIT7ngyCYnMhUyqvb7T7/riUOmmQW/tPEoXqNYC5dK4fIBjjm8PqpKb1FFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7630
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Thu, Mar 27, 2025 at 05:34:54PM +0800, Yuquan Wang wrote:
> > 
> > In the future, srat.c would add one seperate NUMA node for each
> > Generic Port in SRAT.
> > 
> > System firmware should know the performance characteristics between
> > CPU/GI to the GP, and the static HMAT should include this coordinate.
> > 
> > Is my understanding right?
> > 
> > 
> 
> HMAT is static configuration data.  A GI/GP might not have its
> performance data known until the device is added.

The GP data is static and expected to be valid for all host bridges in
advance of any devices arriving.

> In this case, the HMAT may only contain generic (inaccurate)
> information - or more likely just nothing. 

It may contain incomplete information, but not dynamic information.
Now, technically ACPI does allow for a notification to replace the
static HMAT, i.e.  acpi_evaluate_object(..., "_HMA", ...), but Linux
does not support that. I am not aware of any platform that implements
that.

> It's up to the platform vendor.

Hopefully saying the above out loud manifests that Linux never needs to
worry about dynamic GP information in the future and all the other
dynamics remain in the physical hotplug domain.
