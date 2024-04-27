Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB192BB0A
	for <linux-cxl@vger.kernel.org>; Sat, 27 Apr 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714177834; cv=fail; b=MjmA4OkuDFyePG9Y0iHToewOeA6InqaFipzYsu8y5sQZWdPMo+rIv/AhegzSbKw8kvAjTsJkZL3L6MonWC0TqwQW0mDN7Z3o/StvPmjIQ+7BAe8DRnM9aHIXQyhji8efVpTfhOeV+10RfiXPKyokeObeg/hxboNvNmgkQ2Zm804=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714177834; c=relaxed/simple;
	bh=7bztZhRnXOHVHvafXHQi1i0JUfUyyXitmlWZ8hgCWf4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cpUc5mOVz5hp2GDfESpj5Ha/iXaEQ7zEM2qSAQSoCGg+A7iYnCMFUv10dwbfD/3sOH4MdCFvhQMjO0DW9kkM5xeTrb/JfoILTX0duZcDqgRykiS6WHN4jmSIIOzaE5tNxkUJeKthUxX6pC1p3v89bWkJ3fx04qNwkrxt10F67+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqJpQBEC; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqJpQBEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714177833; x=1745713833;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7bztZhRnXOHVHvafXHQi1i0JUfUyyXitmlWZ8hgCWf4=;
  b=fqJpQBEC4tj9gF7+bJQISDHkDW+bx2UihhDMIqqp4Tzro4f0iMlI0xmY
   WOIhsgByoEBbAuQBEnNxHyAMASO0nUosMXgZMCkpaClOgXkMShmhjutDn
   Fwq7YsE9EN1lIOa4JcrFPqAfFjOD7755YiyNitHD2BmNT6GzCefrk8K0f
   DD+ucMeoDPZPYrs6c4BlabBWARuF7qYSTzp9rmnY7ah6jrgDrf1uSYPWp
   oky6G50DpwH8ZSiWpZirXZyPNAf9yBBp2wIg6Le2MoF/LVsbS/a0uDviE
   LTn7eQh5WyfbmoTNSFsxY1NQDcgoe3XBdW240jmlGQxgfB4jSsuPGS2Ht
   w==;
X-CSE-ConnectionGUID: hmJD0NH2QZuokANoNQhbcw==
X-CSE-MsgGUID: sYD5WbPBRwyazOYeW+EN5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="13759741"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="13759741"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 17:30:32 -0700
X-CSE-ConnectionGUID: 9nq1FP41QOK1d3ppEUMOKw==
X-CSE-MsgGUID: 1NLxYpqFST+5G6BVPjSygQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="30386002"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 17:30:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 17:30:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 17:30:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 17:30:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SX7TgXOSQscoW3CdbCw/1rVx13qzH8bgIp7//S1baUXgVYeDfvERhRX01oRYdRdlXB54BZ2jP/nfpF9wh1BSvBdq2MMUYUZ3oV3ZvEGtMDk51f5OXuHH10zl3Yu8kwDj8jIb83fjXvo6yVswIKgKmbtP5cVyvCB8wuuktq28iLGYVm+V6gz8lqlDk7kp1y6a5+pIDc3pOydDb0YLfYsk/U4HMFKckpfI296fRiHfnIE6xIPXCvzhiY4ACdzotx/djzCpVamkeds2C/UVy3m8TUNah3ATQDSuCG55bRBAqShtwfvUO4xtciZHiHWyXqsTWKmwyxoxSyW9Zuu3+KoQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=je4/i6L32wdr3ll/m+OgS+IFghnpxc/kvv0HH/hl91E=;
 b=EEqus6xYPzWzj0WwCcYVHOMT7MSyzYiJClaxW7a5LPpp8QaqJV1uhgsq3Grsk/sNSYZHTfVDqRr/s8/eXnCAJUeLsTFMHY6p3aK3iw+EdF1mRN0rMvP3oaUagGW2hVnPTlT7OuL9EUxBcRmDajZQjJNgcrFKEHTL9vhZR5tqISoDCvju9a3qCTNKU0aM7mnCkj2vhDkd+iTjTGPcR/43XI3j8LLyxawhWn35Mi0mELYUIOsH9cD16GXSxi6nUAW7tuLN+HFmvgNTM6nvZ2YZQ/LXDBWQzuUXWxWpdGOEYWizktV9f7N3ykiZmBp+0Iy6RnGebL4nLzOTjZweZadpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7910.namprd11.prod.outlook.com (2603:10b6:208:40d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Sat, 27 Apr
 2024 00:30:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Sat, 27 Apr 2024
 00:30:22 +0000
Date: Fri, 26 Apr 2024 17:30:19 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 3/3] cxl/core: Add region info to cxl_general_media
 and cxl_dram events
Message-ID: <662c471aefe43_b6e029445@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1714102202.git.alison.schofield@intel.com>
 <a45eef6938944be3a21e862d238ba65921f07a42.1714102202.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a45eef6938944be3a21e862d238ba65921f07a42.1714102202.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0153.namprd04.prod.outlook.com
 (2603:10b6:303:85::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 51dc97fc-5e6b-4599-76ac-08dc66513966
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bSDo24CuSid0E3IfoPzTBNCzBrA2mvI3zNkWQ2f4AVCJrpO1x6O2w+0zbn/L?=
 =?us-ascii?Q?rav8BOT3E2mnNRI3POEzG29J7Wo3BCTHwao9RoM2mXKivLwHX0p8QgCdfaIC?=
 =?us-ascii?Q?W4w+2Lz8Rpyv0jUpERB3cuq2f9o7vTSmBkP0U8MWSSvxDyIinPA9iNzTN0vq?=
 =?us-ascii?Q?GDloK4H1wdDrGGKVIJN8la4aZ+2UjdzAMbgJXygUGXoez8JF1KErnVFBOmcR?=
 =?us-ascii?Q?8FJOPMb4Zh8Qn/qFTetNwk/2bVN7yzNsHZRozfson/eIl9JfrKHlUzQ3Fuck?=
 =?us-ascii?Q?RjFHCaxU/oSJ4NcU7+ey2pO+Yh0JPF1FVC2PJnNsJ6RXir9qq43UsBNaqac9?=
 =?us-ascii?Q?ozFLSSwcP/tvx+ZXvgYGH4izQWEThU5gbvwo8Croc6ZghuWeA/jeNbNPrTzD?=
 =?us-ascii?Q?MFJlGBAfzGsZO4vMyzPE+ZJShdhjExbdN0gyrW909PRFlEWN9P/B2C4AdMmi?=
 =?us-ascii?Q?8wQdRPhwwZD06mRDCOHss6MqaVzNmikrxWPIM1UtmvKXnd6qAO/LpyK5/TF/?=
 =?us-ascii?Q?JWxmAO48pfTLphMyofsteYtVupRi5VvHkPqBQSqFAgAqQWVECijMl18GJ/an?=
 =?us-ascii?Q?p3HlJiDuk0EaI2yAAP5kF7iDIzPdj8UPEASTOKSnwNXog16/4hegkrUcnAEV?=
 =?us-ascii?Q?43zC50FlbFRA+f0w8qF94ldcT0vldLKzQH6ZRWYnfK5kpUbkC69zuBOPVX16?=
 =?us-ascii?Q?tuHExM7IAs8gbEUu07iOKK7kS66sqbXhPAPS3axgyg4ERf/wu3Pk7a7aIr13?=
 =?us-ascii?Q?EoQmIyUJVLf3nu9i3YKDgNH9oQiqafLvNFFQBTfQzglZuX7f/ksPunUfqIR/?=
 =?us-ascii?Q?xOyzufRGVmH+g8BPc+NVmbB0ShA0jzJZ17ZdRcf5CZ8HybSxoP8ZG/uI/U/x?=
 =?us-ascii?Q?KC/9f2zmYJYgSf1qypGz2co66+F7nB1gX4MkD3/hJ42/5qRb6ZNA+zmf4AtQ?=
 =?us-ascii?Q?BHQ9lMw+jIlBlUH1XUBs4yeOpXLpyfzA44Zz8C0cOtO0NvH0hoD47HIBVL/F?=
 =?us-ascii?Q?NLYw7mNuZVOUn5xb4Wg9ajnLX7FjOffVvV8tRbiDo8Mx5MjquEfKVmWN6YYj?=
 =?us-ascii?Q?BcqaYUdBRwr2esuJbuvy0tXngZcbbkKZEpk2W51VtYcJUI3TnWuL5Z6VT0X3?=
 =?us-ascii?Q?OnSvqB1CYfWcLYa5uvVPP9hfBxo0n/at7z3etiuFNOIGr/M2TfKZpsJfzm7T?=
 =?us-ascii?Q?wI/hiUyAx8frJ43otvhAsTa41dUcupHJmOX///t86G2mAAADsvRbNQqVOR0d?=
 =?us-ascii?Q?hBlWBq7PTniUPuMC4lSumX6XYVfwKX/E9PsF1Q55BQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kq7Xmi7sjxLdfs0GbSIbpY608WS75f0WN3UncTu+UvovlH9x/HJJYyA9cYqO?=
 =?us-ascii?Q?wcxDtrsJ2Ffd04BNMWWh3D/8+9ng995LLmisFXGWmTBdTHwu0TDPd42uFPu/?=
 =?us-ascii?Q?hL8rns1f6qdKoUMNZnzKHbhIO1IxZzuTyWgXlw+fTOfYFo6oRM2K8zwE0hZu?=
 =?us-ascii?Q?F8ak0l56kt0ggNmxuCCk4oQtvwXViBv3t3N5xvZne0XoSUDtzGCF/BCL4yOV?=
 =?us-ascii?Q?+0xpSQgW+ziBqm59V79saZRUDI9L3A8O19hBXnLFPwshYi72chbqThFnom+4?=
 =?us-ascii?Q?erja+k8KLe4krs1XgL7sXl09oFA+r1cJIPXpUJcN8rtxer1ZolQrtVUrB0+J?=
 =?us-ascii?Q?C8x3+ucKPAFH8+1D8KwbaP7u6TJ868XXEbRaAJiZPQH/7O1hXOmZv9dim7IT?=
 =?us-ascii?Q?XKl+Q89Iy1/vLVsUbX72becC68cLBG97bJ6LJDxBNLPhy8Y/H+JdzvahZg6y?=
 =?us-ascii?Q?CyseXEOAEqWlPh9ZUWwlGu/k0bgUBaip46KEBZzrGxYdpU1cjrA6nVy5zWxt?=
 =?us-ascii?Q?+zD907Mls/AzitIm5wNS64d2FzavhUaxQrUN3BdUJMT5b/Jpao8eoQOsT7Q5?=
 =?us-ascii?Q?vc9mJsDA8eq1iLq2YvDh9Varz2MZYw/oXwDPA5OauNG4Ay9FiHBytG5RC3Pp?=
 =?us-ascii?Q?MNksK89Dd2NHb8I+Z6NTzljZkdZaEBDbmTRr0vKTlX/J70b1DgSnh3Jn3taL?=
 =?us-ascii?Q?L9G/aZkJiV6u9dB2V1NdcgMcXzn8EfVhHPeFy+g9r2Yfwp4vNJcP5wsU2M2t?=
 =?us-ascii?Q?1/n/fChLmqA5zh2+GaGDTPrLpKR/mpnKs9vJ4IFmZW8Uu1A7skApE2G2Awmn?=
 =?us-ascii?Q?GOVEwi33BbSwolgucyRfyL0ygKtBMJ8k0ptHDpqAT0zk6g0PQ8iFMMNnOoyJ?=
 =?us-ascii?Q?8yd3MV80ZoZ3vkA1zF6YdhgEbe64D7c2stZ9y+gbJC1fNmSp8UdT0IuU3wXV?=
 =?us-ascii?Q?yrDod4k+U+pKTRkEZcBiS8jvTaNAv1KjbWF6NrRVzYsWHqatC/javlXBntdE?=
 =?us-ascii?Q?ULiq46OB457xhyFW0TzSIaYYqcl80QfQMJHVhTDPTVlva0RBkM3SVyVgj+2U?=
 =?us-ascii?Q?4YKQImtwTudhX+9ljANWx5eBoKUToWRVVe+YYImtLijUJrsBmHO8olWemdNl?=
 =?us-ascii?Q?lppO7MCTJeg+gvW4TovyH68FdSJFrs4y9f06rNiVoq5XdAkpxCYLCtSCOLDl?=
 =?us-ascii?Q?qZcQsLfgx6YelnPT6M7x2WEnYyD8kdxgx3CayT5nygh/6xxCs/AxBLKE3y6S?=
 =?us-ascii?Q?RURA1yG/6cPrIeaSwVIwL6gqxud5EruU6MJxsKOYc0tRVRHtBBDrH0S0nlvy?=
 =?us-ascii?Q?5P+GNC5/ZMCdpN8VcnH61uOgjPRS/kLx/vgOi2RLXq37/WXlP7gJs6Vxb3wo?=
 =?us-ascii?Q?TtOeddXu4VVlyRLR90KmQj/dCq/5JPqUQUTPCKC2ghJC6p3nWUi7FgTWwmq4?=
 =?us-ascii?Q?Zwx1smsbfQjWsckiOtJ3STa1OSPRVFtCTqOkvRooZdGL3Q4jaICnLD7lhc55?=
 =?us-ascii?Q?qblHcPB4qfhxDZ1WC3Ph24Tv4Zh4Daxx1QvTzVJEloTeFrUD7KaZbj0ZxFFf?=
 =?us-ascii?Q?oayl9JuIlQwsI6ZgOhwiwN3fmsMPBBdOKstURtExN1XuJrR+u9k7M0DNQCjw?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dc97fc-5e6b-4599-76ac-08dc66513966
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 00:30:22.3057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4hEW43Hs798M27a4qhZseNCtsy1ZDAX8TTi9xZbbfImU6plBSArtWSSqXP2XU5p0gxg6FlS/Vbp8dvfxraatHxKfPj96LBGXQyb2pmD19c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7910
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> User space may need to know which region, if any, maps the DPAs
> (device physical addresses) reported in a cxl_general_media or
> cxl_dram event. Since the mapping can change, the kernel provides
> this information at the time the event occurs. This informs user
> space that at event <timestamp> this <region> mapped this <DPA>
> to this <HPA>.
> 
> Add the same region info that is included in the cxl_poison trace
> event: the DPA->HPA translation, region name, and region uuid.
> 
> The new fields are inserted in the trace event and no existing
> fields are modified. If the DPA is not mapped, user will see:
> hpa=ULLONG_MAX, region="", and uuid=0
> 
> This work must be protected by dpa_rwsem & region_rwsem since
> it is looking up region mappings.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/mbox.c   | 36 ++++++++++++++++++++++++++------
>  drivers/cxl/core/trace.h  | 44 +++++++++++++++++++++++++++++++--------
>  include/linux/cxl-event.h | 10 +++++++++
>  3 files changed, 75 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9adda4795eb7..df0fc2a4570f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -842,14 +842,38 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt)
>  {
> -	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> -		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
> -	else if (event_type == CXL_CPER_EVENT_DRAM)
> -		trace_cxl_dram(cxlmd, type, &evt->dram);
> -	else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
> +	if (event_type == CXL_CPER_EVENT_MEM_MODULE) {
>  		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
> -	else
> +		return;
> +	}
> +	if (event_type == CXL_CPER_EVENT_GENERIC) {
>  		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
> +		return;

Minor, but I think you could shave a couple more lines by keeping the
else-if tree going and skip the early "return" calls with a final:

	else if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled())

> +	}
> +
> +	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
> +		u64 dpa, hpa = ULLONG_MAX;
> +		struct cxl_region *cxlr;
> +
> +		/*
> +		 * These trace points are annotated with HPA and region
> +		 * translations. Take topology mutation locks and lookup
> +		 * { HPA, REGION } from { DPA, MEMDEV } in the event record.
> +		 */
> +		guard(rwsem_read)(&cxl_region_rwsem);
> +		guard(rwsem_read)(&cxl_dpa_rwsem);
> +
> +		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;

A merge issue here for Dave to handle here since CXL_DPA_MASK is known
broken. Do you want to wait until that bikeshedding on CXL_DPA_MASK
replacement name completes, or just take the simple:

  -#define CXL_DPA_FLAGS_MASK                   0x3F
  +#define CXL_DPA_FLAGS_MASK                   0x3FULL

...for now?

Otherwise,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
