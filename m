Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C547A0A2;
	Wed,  1 Apr 2026 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062234; cv=fail; b=iFEbooz8wdvtjuhGFp8vndsM6LMZQrVqoNcQ1n7Hq5hCTXbVZDeD9ypsfJX94CfmoaJgBSZ1Su1FT/X9uTpWKAwdt3C/VfuvyP8pQCHzIeRc2y/FR7UsxHMAeQeGc1rptWfHBrUbfCIjJjm+DH6qaIRIAqST6WRzH/Hs6BR0wEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062234; c=relaxed/simple;
	bh=ieqwunbXVYzLyNJP3dPnKudT921bXt1UcG9hNaKdagk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U5ITvgXBCHxYj7jWOohH+i/5IpQ4h4K0BcBXlpUJvBdh2YCDbJRqkaNY2QPzVEo4Zb2MMuzoa1zkAIcgKOfa0tqBhf/GljahEeDXcEWf6fG3E5X0hskc8UQVQLs2w/GcuhNQV1yuEVJ4fBsYIX6JBj5UmywhZseZDs5fydKBLS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IChMjUbl; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IChMjUbl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775062233; x=1806598233;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ieqwunbXVYzLyNJP3dPnKudT921bXt1UcG9hNaKdagk=;
  b=IChMjUblFzPJQ/JO2tIjo43xQrRXoXz6aGoZLbmUBNJ4DOWIAxwMhDqv
   YqYtYPbuqDXPr+SXQ+7IawmaxRoUR0mh4XbdxiAVy3pzi6aXpYiniBWzw
   jzdaB1s6hoBE07rRxRagG0aC+EIDfHrGlv/TFHIvAsqFdkOgeKtSE/PtU
   mSLazWcZc2lofwX6OB9nbuHAhZOsqhGJgqr4EBP7y9ToiRxyPVbdHuED3
   6PJQs3r3jenIpfYuoTAdEdMMRpiavA2FnbdVWnkib/JV9lxd51TJPAAUw
   POS8mXQyTFy7Ym8kpLCkk4WqSRhvZbC3FESpUct7zauWZ+eslyypcQBAv
   w==;
X-CSE-ConnectionGUID: 3msHOmDMT22SQUmVXsXGGg==
X-CSE-MsgGUID: ySVCzaevRxyA5u3FzdmuIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86721810"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="86721810"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 09:50:32 -0700
X-CSE-ConnectionGUID: DtWVEOH/Tb6JLCWHpWhgmQ==
X-CSE-MsgGUID: Vfs0pMoMTg+jsX4AmWqwgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="226718197"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 09:50:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 09:50:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 09:50:30 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 09:50:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmIeUUo6yA2HeDvfkI2EIB89oC9TcBa0J2rsvgCc4WX/wvPjp6EuLoC/a1Xq1m4bvks/Qm0AG0gUSmLyZztP7Yj8Jd+mvH9TR2B6M9eHrRS2v4ut8AiUlbhpsUIkdkj82IsdBu35U34Il60RZbHK57EnhznRShKy7ViSjIyBGpGNuGoQEp0+tmwiUDagc5GIE+cPKzvguS+E4oCVogVLM1Lc3ALTh7AKWUECQQBXVeHE9ysVNVvQ8T2hqSTMWiDRw6R1yYG7x9SK/soSa1RsnuvBraFF40aCah6p2u5sVDODsochZBC7ZK4KHlbzPPiGw0+ERMRt7RgesJxf1Joneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xegS/YclFuAvc62vls7AXZt+yau7S6ldy6qWsiZqG78=;
 b=FaC2joWrXEAOqrya7y7WQgpAonweq5QIGzuXPdXA8uxbt/F79kMOJWLaXkIVo/TXVwoIaNxRC+LL1Yx+FBBMru79SV6kQNQeM1gGfGGd33dmzxdiQTzSkCgAx8WeFRdxvmQ0KMewXyjOPWUzcdgz1xMJdf/9fM0RX358nQ0HtnrPUtjjM77cbfvA0e1wtCB1JVLkfkzydjYqyn9gpeGdPL0a097U5bt1sSwysGBuRyujMAGkizsdOqF+RMtAJob2GIXv5X2F28eksAi+PC7yGzKeCPoE3yAf0TK8sGMxMQJl9uGGr+dQpZUPiy3QJ3hhNpgqM60mLI94C3q3iggXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH3PR11MB8547.namprd11.prod.outlook.com (2603:10b6:610:1bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 16:50:28 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 16:50:28 +0000
Date: Wed, 1 Apr 2026 09:50:24 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 1/1] cxl/region: Add a region sysfs interface for
 region lock status
Message-ID: <ac1M0Mkbu97MkvB4@aschofie-mobl2.lan>
References: <20260401124951.1290041-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260401124951.1290041-1-ming.li@zohomail.com>
X-ClientProxiedBy: SJ0PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH3PR11MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: 40db080a-1ed4-4707-7606-08de900ec70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: m0QZaeUALStc+dSD3tg0SqtKGjGH+BtqqBr5/46rp6eRKlVIlr8hCm0WapdKJokwjGhRYC/jGtBoIvRPh3vGh2UAJWDPGE9MCShNGe/5D2I88rywfFv29R5FZXdvs79VIs2IGQh+tuYWWLkSDUEJNOIqITTw7aky3akAjuU60U4S6nsjEu0LqSgDD00HooKZDO9UB40i+slBeqYVeFWh+SzRKCdsOZLyc5qKbeYcE35Irqyns7ETFYx+m5REjAR1PbFh4A/IF3HpAI/dYFfdR+K8ZVvFvfFX0aIWXPyKol7EHsTAZziBa3xRgd27W+RXZ3QdPQ/QDwk+iOSyBW/6hGXUCJHr7edWgQOkIzt4TjaZZtT0IjvsIF4RIsX1Nxhl3hWm7dYsPSYwFvwdHYCfg2bdC+z7ZN0+G45x/D6Bj9VMgjjfYYcKVCspZSy2/3sHgQMyHjXjj0iyToGPKpp2TdXQ+xNnwa1cOPccdYW4tnsG7/EaT8wmDaOEPPDf+4CX/NFl4CIQAqJ7NFIg+Hemy35rSwfujm+Zc5Qbf333h4FM67FaH2RNqU5GBvZBXcHh/0BQQri94B+e5/W/135YxnJ2ppZcVXAbud+V5/G8hgc09PYI9XFEz98g3wblRv6wCvXLYUPXITD4QA674R2AdJo/SOxtzMphK3lxLmGsGi2IFrhe4FnDV+0KAiuFu4eWPOmAVYZvNyHrjIBTudK9Hz1ie5U1ERXgaAIo1bUIb1E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6IO8V3Dz8xRrApw8q9AlLrcoT1Aq38v1ZiXD6REXd4lQ80LzZ3udNp5syGeR?=
 =?us-ascii?Q?+QFhG4gvz4quxcnVHPLbFW2NOTn1Ve1oS9qofRU81np7ckceHZlMDeweCr+w?=
 =?us-ascii?Q?zq0rEa1gJZxJaV22PpyNCt9u9iyH34Hmhdv5a8mB2z25xULjG+wxm7U8Z4jq?=
 =?us-ascii?Q?AuVUS9M/kRhV7qHZXvMtg+K3fA+MHwS+4+WOm6Vavx4zQuRm7b90XHPsJ5eb?=
 =?us-ascii?Q?l8rs4TncGxXrd7BGkL/8kU7guMPbF7ouJM/D+dN+aP8nU2W8NU60QXY+isYf?=
 =?us-ascii?Q?c19tj3G8yAM8vA/zzwodWx/YyVRbp3MWlxIAzy0PxWC9ElIk6qPlMw749giA?=
 =?us-ascii?Q?V3FDsdpsgdL1BPHpb6G7873Af5Gc+1Ti2Kp5Gm4w2siUoFyBsSsIozdbqVdt?=
 =?us-ascii?Q?+qQjBqZJU3Pw4qmSqTw3h+jKG0ICTSWXTEYXrRIn4ChKXKHsVnqCVJueDbBP?=
 =?us-ascii?Q?r+/5f5BI0P3cAdH/oFQWcDdBROemaBA9EKrxLSujsMMyF6wNUz9g8dNJUWEx?=
 =?us-ascii?Q?rjiAHGaLv8QruGsUSgEmVNpJMSU3xmSqLa8iOLvMlIeh1lcXHhkdV594iASC?=
 =?us-ascii?Q?tAtYlcEMbWQ8WT4wWw8z6m64bL4vOLu2vZxMx+ZYow3vBByRKm7aMB6dqdew?=
 =?us-ascii?Q?snog8o4nnyvsZZQIMcta8KmRK2m12R1PvB4kOEQBtjmW3LWEfJhd4+pZ1/Y3?=
 =?us-ascii?Q?uNQ7ISuJgX66jFdmd5xdQQnyfqFEF47rHam4CzYTl9L66vUbbCDHOW1NTx4O?=
 =?us-ascii?Q?OTwM0wqj7+tTmB4Q8GP6G8AOG3V4VJ4j9r9jgvqlapVUFYDPlQsghNbwQ3mW?=
 =?us-ascii?Q?AZT8eCYDqZSCRVUy70aYylFny8oqdvQFHnuqCSG+d8/fKdNNmvTLx3K3nCvk?=
 =?us-ascii?Q?6caJGGYjkyEsBY0wxwias2ILCVn6EHYf11mVY1zhnjtftM//q+aBNz5gq7km?=
 =?us-ascii?Q?ysPkLfuXGFQW3jm9386zk+Hv6QFRwwkWqX1DchJPvRrvAuheTbnYsTmvoiQ4?=
 =?us-ascii?Q?NuzNrIi0uJSc6bt5feByTK0z90OiC/TibVPRRB2e79qQS3E0k5MHassZwQrB?=
 =?us-ascii?Q?DGNxGaFp5ltB/RWXfnYqE9k9sb8s1EX83VJ+nW+x97YOCAYKvPWcKHOCN18g?=
 =?us-ascii?Q?LtN5hS/u4WenjmJtzj9RAlxwajfxgOVmVwcDXrsd0nx2cLXXrlA904I24I9h?=
 =?us-ascii?Q?JpSbVnPXLP9hErhS4ZBo5l5k4RE3G1H8q9vMZkP7hs8mxJD0Kf/mm5UR8YfD?=
 =?us-ascii?Q?N+BOVTrlnD+T7DX1fT/AngOk7mujHPcCtbUwijTH99s3hmfj8iUN8Si5FPMH?=
 =?us-ascii?Q?umA4LO0RzwccEAfVbMIxO1R/WxR4uvN/0+8QZfD1au5KgRNTNfyDWKX4cpmU?=
 =?us-ascii?Q?om49wjzlQ1MdX2EFfW6AGdj4bvD7E1yeqxvaWpHLVbAyKtxzoBFrTa+goTKd?=
 =?us-ascii?Q?A5tHLn8i2un6r0+jLGDMHzY0BwMOTt+LYYqyl8GBQO8KtcmP+7SeowZwcC9u?=
 =?us-ascii?Q?s6HDYwK2apU1WlQvgHes5x6PnZfF3aLtqKY/FoXbOeQ1A1rg9ZlLa5VWsDVl?=
 =?us-ascii?Q?nBvabKsGd/JrqwhFOYuOcFGBELoRS1iZnS16nmniocZw3VkXyklhl4I4k6bL?=
 =?us-ascii?Q?YST3mi8oKQuNzpMpHMVkCPEym3xfNpLd9gM5gL3Rs6RGH4ZAELgQfNwgwlNF?=
 =?us-ascii?Q?KjTE6wyAmW5AaFKYAu3rtoSnbxNKyGO+E0RnviNAetSS7LIx/rHxCgFpz5Dy?=
 =?us-ascii?Q?Iv0UUPPNmZskYwHKIuK2zi3pjaVWRJU=3D?=
X-Exchange-RoutingPolicyChecked: fHoWAiYC4P7p/7A1xrFxmAhUkl/JbNwW8OE3jRTy4imFwlT8jfURuONEvSe+ibLZvbKggcspD5uCTqUF4Y4e0+/OtGxoH5jaMc5qfTyVaQMU30TXZGHvK+BtHm9mWzT/MwS7E+B3Mh/4G7guuVipbuRH3ajT0CuJKF7GgECyrn9Mg4NAUPd1EAs2wSNuUr4FIrQmXJaa4IRpoHbVGNkiTiiti80fGci0lAf+Z2wjLz/Hm35Y62isWBuCHQachEiFmLHRUBXhnu7OdtCiVTtnEqBFlAv7z5EGVAZr9GRI30xwp7vaqV21SSHKeMgpzxKMGdQq+TlKGiT/wRHvDGbRkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 40db080a-1ed4-4707-7606-08de900ec70e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 16:50:28.0241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syatEYkycHze97Sc91dFIeW0EPAAEo78H6uG6bJ3v1CrKjtAza+pLA1klXs0t/pbl8K5YDTq40JcLtBkdlePn4jKxgcbcn9w97T8abwCXgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8547
X-OriginatorOrg: intel.com

On Wed, Apr 01, 2026 at 08:49:51PM +0800, Li Ming wrote:
> If a region is created on a root decoder with Fixed Device Confiuration
> attribute, the region will be locked, meaning region destroy
> operations are not permitted. CXL region driver returns -EPERM for
> region destroy operations.

The above intro is too narrow for why region may be locked. See v1
comments. Let's keep it similar to the sysfs 'Description:' field,
like this:

The CXL driver has the capability to lock a region based on a BIOS or
platform dependent configuration. Region destroy operations are not
permitted on locked regions and the CXL region driver returns -EPERM
for region destroy operations.

Otherwise, LGTM 
Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Although the locked status of the corresponding root decoder implies the
> region is also locked, exposing the region lock status directly to
> userspace improves usability for users who may not be aware of this
> relationship.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> ---
> v2:
> * Add more info to the interface description. (Alison)
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 13 +++++++++++++
>  drivers/cxl/core/region.c               | 17 +++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index c80a1b5a03db..16a9b3d2e2c0 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -508,6 +508,19 @@ Description:
>  		(RO) The size of extended linear cache, if there is an extended
>  		linear cache. Otherwise the attribute will not be visible.
>  
> +
> +What:		/sys/bus/cxl/devices/regionZ/locked
> +Date:		Mar, 2026
> +KernelVersion:	v7.1
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The CXL driver has the capability to lock a region based on
> +		a BIOS or platform dependent configuration. Regions created as
> +		locked are never permitted to be destroyed. Resets to participating
> +		decoders will not result in a region destroy and will not free the
> +		decoder resources.
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
> -- 
> 2.43.0
> 
