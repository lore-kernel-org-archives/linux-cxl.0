Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AF4286D73
	for <linux-cxl@vger.kernel.org>; Fri,  1 Aug 2025 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063861; cv=fail; b=Zl8i5TsBAsRQdtD3RgyR0sO08wQ/qd0DLbja4Iw2CsL27rzMe5eHwK1TUjhnWbiVg5/NC03tjipltUneskbCwcGhJ8/q4WNJ7xtaeuF/Bl3CaYIL2lq6h46v7Rwt7xxC5tk1ayZFN+0XMMVd3jfysjrZvgDiM0xTdVeQjuNUNv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063861; c=relaxed/simple;
	bh=DTzZFwUik6+1d2iDXublSOU4skn+/qh4JPYlPHf+ngg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HlkTV2VUnl0ws1T/otckQlPQBDvMKEOORTTvfW1GKWIfIzD6LufRXLiL/L8Cd6EZvKKqRXKmsizxemn8WaSTBqZaf/o+hIg8zCBYgrcTbVHIslsdx2tfrKQXVY5Nkuf/q8u9R6U0dR2+NwF5twVlJdnF/mCNZembYqF0eUkAPE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dx/K8wXu; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dx/K8wXu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754063859; x=1785599859;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DTzZFwUik6+1d2iDXublSOU4skn+/qh4JPYlPHf+ngg=;
  b=Dx/K8wXuYABSSX9uNBFS9GrC2A/JlJPjA/t3MfdoO7gTKoHQBtuOtz1E
   56UyN75aGS5nqb9+SpETvR7aFkgoHDIdchEM/hBYAeQn1FyMUi8Rn4sjZ
   +4o7DbH+g5meXJIG2S5eWYMxE+daojUzVSTOHYcon/7dGNPTrt96gUYxw
   mPT/cfID4Hgal6Qr5WUpr5ptsv2HIefvvnhNN+5KfBDw3jMh6U05pd0Ey
   S35TLEqf+LGJ0K4/hG5I+4Q/Nad4RJngRCGLaCatXl+30tDVstzzDO5hQ
   YZJZS+7Ea9c/2gE5Zq6a5o3o7uV4KQeVaLBENn3acQTHdWggXOazyHNPR
   A==;
X-CSE-ConnectionGUID: RdlXbLgyTceRlyzvqqCaxQ==
X-CSE-MsgGUID: 5HeO38iUTV+jPFpwiitIBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="74004427"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="74004427"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 08:57:36 -0700
X-CSE-ConnectionGUID: 3ROsK4bHT8qa3beJeO2Zcw==
X-CSE-MsgGUID: Y+devvomRbqUrVXfGCT8nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="168897011"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 08:57:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 08:57:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 1 Aug 2025 08:57:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 08:57:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfFTeK8Ph03MadQYgJHg20Efh10Jq9TeWYpuiMYag2ZRtLFPJG8ZRpBFlr0ReHYkbe94RfwANMUbdyPJ9mwU9Nve+LGlnP8Xfb9k8D0xGPzP7xEyVltg3KWZfI//RDPUbGg42sK5Z8R2o8JIzivLPizVOjhzSkkLAJ2/s2MM3SMrA1ZE0UP6kIWoJlBz3eQBvU0KywM+ASrpADEbfTlwHtGj0AyUihpFSLeXZCSWw+S/ytBaM7jdjqosWEgPTHT0WNDq3DxRKKno4PrL8obC4dfesTT5wrRm/OsEbRi9oUFa2yWFHAEr2kc9jSpiu0VwqAfbZ3eUUZhdY+GBTpGVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rt53clN9OJNpB9fSqGRTyo8rje39vyP8JT5NapwMIyc=;
 b=WNtnE67x647GwPzaHYWZER/8goH0bDmWkTG/XzQUZkbZf8Fx6Obq/1LNrjQivDP+Uqb34LHkziQ5yYfR2rdAmteGewq458uduscgPQz28X3wdfZe3XWfm3naw4Mewh6/rS26O+nz3Fka7uIYGmXpWb6PocdzgeJtQlnolKZO4asgJmQFvmAjthmyIjWDCN8SVU4/VrczX3a62fXnqdTnK6x49s5YishdbVnCfaqM6SGcS6iKwAU35765YKm8hhS4gnoxE8PT1sPTFvtu6afPniexxfFqRBPnbUGW1z3eGx769/wi3E6rZwTwgNSdMTM6cyXhw4ETfAecTRx2yY6QqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB6493.namprd11.prod.outlook.com (2603:10b6:8:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 15:57:16 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%8]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 15:57:16 +0000
Date: Fri, 1 Aug 2025 08:57:12 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Robert Richter
	<rrichter@amd.com>, Terry Bowman <terry.bowman@amd.com>, Joshua Hahn
	<joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v5] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
Message-ID: <aIzj2AkBaDbPqkGK@aschofie-mobl2.lan>
References: <20250730152519.125601-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250730152519.125601-1-dave.jiang@intel.com>
X-ClientProxiedBy: BY3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:254::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa2d293-3df9-4e93-994c-08ddd1141637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5qkFfNzXebi0Tm0v09lpCQLkptYo8pTSMErnvK8kNcfPAlRPGi8YxYmAqugh?=
 =?us-ascii?Q?4IA+pfTWQKe5FzRgoOgXMIKq8+AzSnRTJ/7/5cEtU79b3tL/7AEEJQsND9fP?=
 =?us-ascii?Q?nP33SjGTp7005GVfefuiQa2oYv8N4V6g0j/NfwzSERg4I8rt+TtaPTYsqdFe?=
 =?us-ascii?Q?AOG1DdzUW/05L1NMKPgyZyHHwdUPz5HO1Q20XU+l9e1V3cH+TacolJBQ5qgQ?=
 =?us-ascii?Q?Bkn93KEVFRHM4apSYgdi3F8sVmsSe+C82TKMj/Zih6OGTSujgyZAlthN6wRT?=
 =?us-ascii?Q?xHYygpKNO99e9hMQB6ssvLrdPzWttm6LvwA8IzN878BgWma7hsHu1lIaH4Ko?=
 =?us-ascii?Q?05rCuVgAKJgHZXhhJF4NfjtZ8yhkSt1yzFKtEoJqAD6AhTvv16xXV4LSsjib?=
 =?us-ascii?Q?gT34NWnP0fijatf6Nm/ojHdV5MpBYPDLfga1IjpKfS4Iv9+2FQ83P1z/0S53?=
 =?us-ascii?Q?nK+JDy+Y8qQ+rL+g8tGgRG5XcE0m4oDi3KXZznl6YYhjJEJgZGNgKYdSDm5F?=
 =?us-ascii?Q?PRpqKsLNy/KrSL2+y9vo/jmAWfu1Ggj9En8Qaem4v8bQT5CUWqa2+ORgkcS2?=
 =?us-ascii?Q?qxyxLW6O6PTjHHnMfPeQ7ofMnoh850GKS7WsVatdtKeXIyBYTY9GwiCZ0lS3?=
 =?us-ascii?Q?JvgGXG1a8yoBMAwQVcWe1rDgnCTd52af9EHpq108OBGaGvvZOfmBL/lUZxfc?=
 =?us-ascii?Q?ufdEy0L5jNgithuYMhf5FVzH5GoEIHrJrtrCA/bklKSytzAp3FXCAJS0jR8V?=
 =?us-ascii?Q?OXtoYfBA5Y3qtrkgdb9v/X4vO+DsuhCMsvmF0OiAtcy0ESpbVurnZj4to3vA?=
 =?us-ascii?Q?pcl2mrwA+2QkSQAq+bc97ygjcJgC5iZ0W4hMvOb+YtyY8K4BaSm2kr3B5dBC?=
 =?us-ascii?Q?6XlwiTROn/oBGPybGSByoetry1rT3u0TcFVPkMiSFFU5ImwdYKFyJ63IbYFU?=
 =?us-ascii?Q?ABtdRox7p8L7AsVz1IuyPEVXCkwmOCyJeeASm3jeG8z44rM1vwmnDZi5g70x?=
 =?us-ascii?Q?izVnLbutkAG8Q7qw+N8UvszqhyhvAQE5HyDoWhzB6uYPEa+nWrr8GLK2qpiV?=
 =?us-ascii?Q?dFLglKfODNaoKKaclUO9D8Lj2Y++eA6OKQd9Qft5vFws8uWNLXm/CrhbZyiA?=
 =?us-ascii?Q?IdgFN/PIk0wfueok6clufbx1G3E5XzmC5B9S2DuyipvlRrx9LhIYr2Q8fe3S?=
 =?us-ascii?Q?kXlv3ZvYjrlRQlL+91qhsPI62cMt7duIN4l254gB9+3S2m2whvgQYOPhA2FT?=
 =?us-ascii?Q?OJBxL4H45aYtKJ4YeGAX1Rp2KEfpOlUYuGpJ67ctXLIWlwTgTaNN69U1v3n2?=
 =?us-ascii?Q?ohabCDG7KoVA76szUJjxi41ySQJyXW/Z7U7jzcsknE0ZriFsm02TU6FKMHsT?=
 =?us-ascii?Q?FzjtelFL7FPmkRBfcsZvqg0HEVQ2l83saK0VtSSX7oyRd8hHy2zb0tdVo5aI?=
 =?us-ascii?Q?LNsn0irNBf0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lx7w1G55CO0MmWqI4QvFbPuQWpspcPf6sskteVjuuvj+qAxzXJ83Vnj1m0uX?=
 =?us-ascii?Q?6rNKT5bI2EHF7VSlkpkH+YV9yc4Wbw8i733PjfbsXVWxXTINHSaLExNS+G4R?=
 =?us-ascii?Q?+oXBC2VHoOufMmO28ANDx/R2GNbbveMlY/izrk1vZ3n418kSdmzVQ7EDLv+s?=
 =?us-ascii?Q?1I9vaQcsyLAvyjtEq4SJfO0BlGWn8q9Dyx6IfjuFAHOkvcQB4ND44McxKboa?=
 =?us-ascii?Q?v+xyLJyOI7Mud+ciusiFlJYjGZm7vRUe6YSgBAAl2v75CE+ARbSnqQY1i481?=
 =?us-ascii?Q?kL7vlVyqJPnWuIWpNPV53kuZgsECXpUaBGbKFR5snPx58g86nFPmqjIpMhFM?=
 =?us-ascii?Q?HKIh+C4RO03KpamUM4+hCP2JrxGcaHoU9IxFRJ8P2l84I8P/MqnK3clRNj33?=
 =?us-ascii?Q?buvw8fYt65+mlwIXQCcLE5FmXqwhIQk7YjffyFKtLWCmMWscNRWVUIS7fs3s?=
 =?us-ascii?Q?bGXznfERjNJsFqdjUGgaM/EzW1Hpc06YWWo7HqhRxfY6H1XZ0uM0EfI5CtxJ?=
 =?us-ascii?Q?p5LRzNsPAuc1lBQqjP4jYVOLSeTigyGfLCqCCC5UJX8PbaJxpGXMzBHgrOeQ?=
 =?us-ascii?Q?20ebox1QBeZizQJcXaa7uZr7br1Rqj91j01G90fLesZIHr4gc606nSxfXjm/?=
 =?us-ascii?Q?GmJW39Jd2WQMBmdJfW2fn9Y6Ju9WGVOdC1CZJG2lkJLnBTNptVihnS3URtWI?=
 =?us-ascii?Q?6i/Uob1WRjqh5qKZeh5feVDJChYAMM3Mhal/yTomnBqHAqgAjCea9nJ9vx6y?=
 =?us-ascii?Q?MfEtJdPKzvPEJ8TWtanoA6WcP36D1cfeVETlC43+OU/fOaCKDI9+26h8Ih1c?=
 =?us-ascii?Q?zVEsfErSS4JbHkhdB2PhoTDA1c0tVcofgXsNklQqyo53o1pNydKPCcIAQvdL?=
 =?us-ascii?Q?9tOtScYliLcSX6anGHg4mRPmb5bJqCKz3aOCxFayJhDJNfHSRLKEaOwUF5EY?=
 =?us-ascii?Q?VVbxNq0nk3eEjctlL/JOMDaMJ2Ednv7OaI/3jAvflmRJK38wvUpKNXwuAoYT?=
 =?us-ascii?Q?vswbnT7WQLguS8Tfnux6taWaiG7zqdwgWUbviIznHuVF5woY/dMhvDIvEDIf?=
 =?us-ascii?Q?liKQ+KG7csOY1uZP7UnrifzzKrqXQRsNxHhwRkeXOejR96xpnM8uKIdIM+n8?=
 =?us-ascii?Q?JBwkdPZo2TRRyV+dWwyVHasi5s2TXr9voWRTQ98l+rcMpIJ8biLRIOXsVy9V?=
 =?us-ascii?Q?aC8/FkWDTUOoJjnmWUIISxUTsR2xaYbj2Tx6uHYaQ70TvLyNchnc/5t2IRYN?=
 =?us-ascii?Q?+xq/WSfwkmQQ64zeZJZlebk/Mq9QjBblS3awEBabsC9B1SldpjlD0o9WLqEj?=
 =?us-ascii?Q?CYznCfQc+skpV+RnAc1WQvUkuq/xT7S+M4+i9jhvMD4758J8h2BtjdE1Bmvl?=
 =?us-ascii?Q?NCYXcFK9rJQPKXl0zj9gPEThgRGo3H6wdFcwtkac2Rd6MskDlbqF9Xzn3gvX?=
 =?us-ascii?Q?pQOnvEqpz3LXI2Sl+LpVBKQ5QN3ysdFh+alsQEB+6kySwHu+dQYHyHENlW83?=
 =?us-ascii?Q?lWsJ4EiPMYH8adpwNT8A1CPg2z6O9E2cF3hYJByeZAs6tivRyVGHUz4kWMge?=
 =?us-ascii?Q?77FecX+Pqx2xQGIiS8N07h/cqRsF6V4M196DJ7kTWMzFlViSDtx5PmRd3bku?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa2d293-3df9-4e93-994c-08ddd1141637
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 15:57:16.1294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mggq9nrdPeFJgob4Qt0WlhmZoLdGK4u4GZs3iNwocoof/iHnQwPt+UDK3roS/km6EEwHnapeq1vFp2DsY/MRdwAEPKEuWIZ/cVkm/G80nf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6493
X-OriginatorOrg: intel.com

On Wed, Jul 30, 2025 at 08:25:19AM -0700, Dave Jiang wrote:
> Create new config CONFIG_CXL_RAS and put all CXL RAS items behind
> the config. The config will depend on CPER or PCIE AER to build.
> Move the related RAS code from core/pci.c to core/ras.c.


Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Cc: Robert Richter <rrichter@amd.com>
> Cc: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v5:
> - Make cxl_handle_rdport_errors() static. (Dan)
> ---
>  drivers/cxl/Kconfig       |   4 +
>  drivers/cxl/core/Makefile |   2 +-
>  drivers/cxl/core/pci.c    | 319 --------------------------------------
>  drivers/cxl/core/ras.c    | 312 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   8 -
>  drivers/cxl/cxlpci.h      |  16 ++
>  tools/testing/cxl/Kbuild  |   1 +
>  7 files changed, 334 insertions(+), 328 deletions(-)

