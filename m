Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27A019D89E;
	Tue, 31 Mar 2026 23:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001459; cv=fail; b=uTG7ohK82eATw4zQFBZ1YNOy4yGA2zaU4yaYfWxl12Azcz/kXNxyb9b5JuuwIRNpxdmqopW+8/h5Aj+bCIa3gIcVwQDi2pa826Bwlonnhvz2iJsYy9PUJdbG03Av8XzU3vj70LAunPvG0miLPGASxsN0kx7zNBa7HgEtCu7PXZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001459; c=relaxed/simple;
	bh=gT16U+sVt5ZfxLtdMNt7RILaAt2ZRlxzgUJUrdTMHtY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kugnHKT0m7LTCyPUGOlXLG8GYKhKMhjdc5sgk+CUZMmSGyPm7l7PGHk+DQ+UXpX1wyfzfB/bLIndRiuy5wWxBvpZ1v4TMdJqLb9V0tR0XyuuM1/zE9/rGdq4muuJN87vBWF+RNIiFqFADMtkxad+PoUUedJRQTL7fZ6GM+J/uyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMb9sK+S; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMb9sK+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775001458; x=1806537458;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gT16U+sVt5ZfxLtdMNt7RILaAt2ZRlxzgUJUrdTMHtY=;
  b=jMb9sK+SOHX8QDMe4GY8ntVhUso7QnK/eS89asd4KEE0n3LCkahsBLLi
   VUOH16/TL8xNm8yowvs9qtCf4PFOjritbt5uucBO2Ve3TRVKKfDg/raZQ
   SSh7NZFj11Ie/gVkKYwaaQEre18T/IReGfJY51Y+19Il5kZCIweIEfUQZ
   OkiYE4Ws8z70mL60fC5hJDXMmccIyJsyHoNdsluwl20adYZ8Q2eTHN5gI
   JgaL2g34mQgR8q69pmUEWyHb0PMtDNHS/jovp/V+vKIu3k7SSr0rYsX8c
   A6/MjgXTwhIfu7ObQjAR911QOPnuF11L0uNr1+iG0rasTS1LGydksmAyB
   Q==;
X-CSE-ConnectionGUID: kCk/tVz4QCu9Hql3Wcl3/g==
X-CSE-MsgGUID: PW26nG/LT4eqglj7JSLvgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75067532"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75067532"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 16:57:37 -0700
X-CSE-ConnectionGUID: gGRUCQnDR0mnHCTYpuhhAg==
X-CSE-MsgGUID: DKQjI1OYT3GKjIlj8xRtPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="231446295"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 16:57:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 16:57:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 16:57:36 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 16:57:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKy6H8lzt1yQAiPKo0P5oKkQKjDp1BjLtKoSrJWXVJi1p3OWpJEqNPId9VkzjCH9vDeKdqvzcAKdzoi2UIw40YSkc6bt6eor2dDpypxgcAMUTRTOGvgr+y0CngJgKSB+qZnoRIZ7AjRlwi5gfLaPpYWyGHMERvc47QerxV8JBLPCoIRrle51WsG3wW9fQIqSj/f33RcA1PozNkPMOznRV3T9PjTx9m5fM36tjmDvqkB80+FFNs/FysE3l+bpKjknMg1P8YMZRYHG0hZNQ724Da9zszDMjOwbMtxRLxU/PhwB2jDsiMae+Uvw9Oy34VgA5pNRkuY2D0xfahTtFJ5kFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qznNQU4zo4BBfwO7z7exYG7Sl1JEj7a2S80a2jdhj8A=;
 b=hQ93jEPQX3gq2mlfjdfieBKSYYu5PCGgi4CW+khn10KO7GImHTYakOrxUgzf+T9Ma6vq0As9z48PuE9KMEmbct6n4qV696qQnBC+NijhAyh+/edplcB3XYpcrglMeCnT2egLj1/Nk5k7TsQAosPBxFCfetW30Nj16Z+Is/yPyM0FT5H0lwFfDYt99iv8zO0sDKS3Bgeud7iDYDA/teZkjFRy+14LPRnLJEgOmPdqo5KWPLj/cySjYM106stFa3y/E+0kxzEPSOQ2zQZTUB/z+KybnbpdGTtPmd45vvCGUDM/aXalozPUd/WQheBlptXklRUxksW21BFFyyV9MD2kug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB5093.namprd11.prod.outlook.com (2603:10b6:510:3e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 23:57:32 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 23:57:32 +0000
Date: Tue, 31 Mar 2026 16:57:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Add a region sysfs interface for region lock
 status
Message-ID: <acxfZiQWfYaIY2BU@aschofie-mobl2.lan>
References: <20260329-expose_region_locked_status-v1-1-cd860feaff6e@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260329-expose_region_locked_status-v1-1-cd860feaff6e@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: 4514ef2a-70d1-4c99-30e0-08de8f81462f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ic2ZRMYxm8j507NmN2wfoMygYcERNK5FobLsxxkI4kMO1ft6tWeRrUVPpY31H3OcMpax2kJHODnmOHe85Vo1665tiz9toxWsKva8gmfKENvqgFwAsNd5zNb9NH8nvofeFpx+iUScaZ5qTm+hndvNzN5RW9S1wp6Z80X8mIazE4MLkbtQcG0XBmZ1YytlICXeJbY/5nlMXCY1a/JBqVW4XdU9JwVTWfbX0uQUT7LwIS73ofd0yuD4zDJWgV9v25w2MmYuLZpCgCIJ62DSa4NdBbhbRIy42rVMWlZe7fEdnkrTXEG4vPqyrS6TEjs1DO0m+DIxDAgXhGZCsLs6SKJMhASP5wZTUAP/3DVcc9WYwlgYDLdNuC2w59fOQNCzqCldebDVEue+3RAooZOEseh9FXM+oDLj8lGQ9F/ct8bQjrOux3p68dbsnwpmcTE8qTRX+FCFlJi36HlvDpEMLGHDYxwj1Ds6hNep+mcBmVdMcNxnjYk4FM/XsEfWc2EdzU0wDyQtQ4jJO5cddmOu4Aw4Yt7olOqGSKa1UEPm0ZqZy/hBuNJNBBsk8Q16giWXqN0eq9BB2togrq+CdB+gwDhC4J0IXxjKj/9tsdjQu2/pvZu9NXbIVyN6A6+hWtvE0xk9KAyJ6lEyxGznT4URRYNcZ87oRbAN9iM9Ylxs3dM6gDDwty+SavXe8m03rA81A+TwspjBRrr1k2OHavnKHWN8wprMAQdpOsA9lD55RuJoITw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WHr1uwBOiFL8fut9ciqtbfW17gU9H1PHKvhQw6N1in6sHDtHIF3fsK6YHtin?=
 =?us-ascii?Q?umtce7un/AshtrT/o2/QE9lklUzlIIig+NOzC+TTeaUcRwU6I+Y70m77Zusj?=
 =?us-ascii?Q?tbu0tFB+mJmKl93U+EfNgfHbhVssruW6sgDflMuuqHuSsYrL9KbD2/Ri6cEr?=
 =?us-ascii?Q?D5ynYJYiTRYuaZXH9GVqldHc6b2+nwZuDrAG0YS3XZKuUyZVdthYS1dt+RN2?=
 =?us-ascii?Q?eKakUWxFvf7c41NpaJELgurEUBXnuu+psE28HCMvu3wQiCJOD24Y/6q/nK8o?=
 =?us-ascii?Q?8Q0BalUTb+TDj2lxaV3FhDDTe0B/ThhIhJ9L8ZtKhXmr/ZPOOKdj9OEkCTX+?=
 =?us-ascii?Q?Qriiq6nePpcklJW279W/egdvHrFGF6YlSCwdWmF0LgNllq/Q/YEzb9SCWSeV?=
 =?us-ascii?Q?ob51bH5nW6xiMjjynkr6yetIKqwJ2NxqAPM8ywTEuU8n5dj1n4L83mZj+omz?=
 =?us-ascii?Q?LdR+gx4WGsONtPPaRUdz3yIweHjFBYoLB++UOilvlmEGIFWHgebMFgJIHIrF?=
 =?us-ascii?Q?jFRh23zmpTuOBeyCCeLj8P7coYnta3EaRLnq1hPetnuSfbrn6paeYMaVE3ma?=
 =?us-ascii?Q?B2p/3EIPloPqEW36+k8xjsaou2B0uo3AEN8XHuS04cv0/CsA8FQ4Sq0eC01U?=
 =?us-ascii?Q?xgzTwvEL/6rR/KaNmEhhYxzswClx1ewC11RFSdaT/T+dFqhH+Tzb6dzkvw6S?=
 =?us-ascii?Q?HU1zg8OPjfjDAKn3sfv4tJRmqKl4qTUT9afDO0b8ZKGtf3dC8LK9Hl2KdJk1?=
 =?us-ascii?Q?yrq3tM9CIB72VvxcIxkBGQD3Nx3OU3242bssZmHQMU1ro4cTilRHYz1quaaC?=
 =?us-ascii?Q?ypkogwjZqCiruoLJ4HzLaR++s4WDjHgh7s8qPrjyL0j22QvMR30C3AzZ4ySj?=
 =?us-ascii?Q?fhv6S+NwXA+OWAF29ejzITGmxzyqVert1PQ79raW0IWsk3bwbqgacnHlXkYE?=
 =?us-ascii?Q?h9cHY2iI8W3cHWUEu4mVuWG8r7HaMCVKIhRC7WAXgC4IT6FKIy2XrcYvgCEA?=
 =?us-ascii?Q?HzHAjI6a+F4iyCmDY+kJgsZWUeQ8H5maHVM6go5TtV1/BY1BxWuHacg18XcB?=
 =?us-ascii?Q?aDMPLzLoXLAwm7T/ksb4SPrcxes1kYE/ARaQmO6GGTNs/lrGZu8IowAD9l/r?=
 =?us-ascii?Q?OGj/ZkIV4dMreR4W+o70NwgdiyqixZ1BMii+SvXruN/qPfmYt2mRsukWgcNc?=
 =?us-ascii?Q?lA0qlZqYUwJuwunYlStAarHzSP5O9sPmoPTB9ZycbuNUpyNzVWHmq6O2B46o?=
 =?us-ascii?Q?KuYp78xY+xuyYzp+BWPcKG1NqDJenxUADOJVOj568yu9BWIuQBq3bk0MXX+q?=
 =?us-ascii?Q?WtuS+k7Rqhkj8WSQ+Wqr+D0JW2481s3XcLVMjEiW6AxWOKXUc8npc8CUCyI8?=
 =?us-ascii?Q?+NIlnFgrhHFUUTNsrWiFD1fJlNazh2zO1i0peWmTU7kERs6pYIcGdJwWaoVc?=
 =?us-ascii?Q?82vtBNl2oL3tgnZV7lZFIA69o02xvXy1LujJYirRd/aJ0kQqFpI/nr7wSuxH?=
 =?us-ascii?Q?xbkVcfdMkZYYpUqqOkVX4xR9yNEYwIPAosDOCNTcPduRrdR1K6eB5hMWPVoS?=
 =?us-ascii?Q?mib6wmlGtrxuxAkKgm+xqV/1OErPJl4Y1PvSqFH933a/imSCY27Rf21zmvHU?=
 =?us-ascii?Q?Acm09GfKa3TeQJIJlmgOV2emu9aqSXh9pNeUWJNMZ39ym6bK3wZkZdqwi5pZ?=
 =?us-ascii?Q?NXvB2/MVydJ8kyzbkf3rXDPwIWMyNpLcPQ/I4a6HrfC1CqafWR0Zr77uBWPT?=
 =?us-ascii?Q?jN3KctYTl64VTHe1ZRWGeyOuDQgrZUU=3D?=
X-Exchange-RoutingPolicyChecked: T/CVW545/NUD2bYmHv2YdqCepfMLYfGEYKBk6PPxABrbt6qv1cRh0vlFP/WcbIYt7LdDVa1QCDHQUi/7d3zpV5sG4pa8mP8lB6q70wHMjzbMWjAuf9RWigpWRTVHBgOaRxfDfDq8Fb6JmF6ErspCQsW0zHHDqY661U8hBsDmPN2ySjAcoNejfFk7M1gb7S4mQLJdyZgbei7Lec7kErhUoLw/wx5sJbfPLKIQ2kn66d09ui10r/1eeMGLL8V1u4N21mISrEGY8VexvAjqe5fRE2rX36OtkklMviEnZqM7V8urdn/F/VCctXQeKszneANxiteTbOWmPsc+bV/aOO8ffQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4514ef2a-70d1-4c99-30e0-08de8f81462f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 23:57:32.5993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5MDWRC5udbAMM7ogFxUHKjhgT/kZnPNnrHBPJoB5CV2l46Klsl2/Ff1rKGsWC1VCmt/OgDkmtLJ5GDBcSsV+oDBPGn5VCDnqzEpsJqmpj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5093
X-OriginatorOrg: intel.com

On Sun, Mar 29, 2026 at 10:44:17PM +0800, Li Ming wrote:
> If a region is created on a root decoder with Fixed Device Confiuration
> attribute, the region will be locked , meaning region destroy
> operations are not permitted. CXL region driver returns -EPERM for
> region destroy operations.
> 

There is at least 3 paths to a locked region:

1) the FIXED root decoder attribute (above)

2) CXL_HDM_DECODER0_CTRL_LOCK
   Both 1) and 2) well described in:
   2230c4bdc412 ("cxl: Add handling of locked CXL decoder")

3) AMD Zen5 region creation always locks the region, regardless of the
   FIXED attribute or decoder ctrl bit.


I like the added info provided by this patch. Please consider expanding
the sysfs 'Decription:' field. If user reads the decoder lock sysfs
description they may think they can reset their way out of a region lock
situation, and I don't think they can.

more...

> Although the locked status of the corresponding root decoder implies the
> region is also locked, exposing the region lock status directly to
> userspace improves usability for users who may not be aware of this
> relationship.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 10 ++++++++++
>  drivers/cxl/core/region.c               | 17 +++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index c80a1b5a03db..50bf7334465b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -508,6 +508,16 @@ Description:
>  		(RO) The size of extended linear cache, if there is an extended
>  		linear cache. Otherwise the attribute will not be visible.
>  
> +
> +What:		/sys/bus/cxl/devices/regionZ/locked
> +Date:		Mar, 2026
> +KernelVersion:	v7.1
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The lock status of the region, region destroy operations
> +		are not permitted if the region is locked.

Maybe similar to the sys/bus/cxl/devices/decoderX.Y/locked, say:

The CXL driver has the capability to lock a region based on a
BIOS or platform dependent configuration. Regions created as locked
are never permitted to be destroyed. Resets to participating decoders
will not result in a region destroy and will not free the decoder
resources.

Maybe the last sentence is too much.


> +
> +
>  What:		/sys/bus/cxl/devices/regionZ/mode
>  Date:		January, 2023
>  KernelVersion:	v6.3
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 42874948b589..95d81816008e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -767,6 +767,22 @@ static ssize_t extended_linear_cache_size_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(extended_linear_cache_size);
>  
> +static ssize_t locked_show(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
> +		return rc;
> +
> +	rc = test_bit(CXL_REGION_F_LOCK, &cxlr->flags);
> +	return sysfs_emit(buf, "%d\n", rc);
> +}
> +static DEVICE_ATTR_RO(locked);
> +
>  static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_uuid.attr,
>  	&dev_attr_commit.attr,
> @@ -776,6 +792,7 @@ static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_size.attr,
>  	&dev_attr_mode.attr,
>  	&dev_attr_extended_linear_cache_size.attr,
> +	&dev_attr_locked.attr,
>  	NULL,
>  };
>  
> 
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260329-expose_region_locked_status-b05c4b8f97d6
> 
> Best regards,
> -- 
> Li Ming <ming.li@zohomail.com>
> 
