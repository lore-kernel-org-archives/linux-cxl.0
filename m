Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E58F66
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464210; cv=fail; b=Gzz3a44wpz8Qp7RczQc49rAHloy2IeQ6ncst2XJIMUEEcvSnTBdABKJTVgb+cNSKXCSJj4biG5yH/x2LG7t3mpMtkfnYdRIHc33U6RtKFhXTvek4o81Ui6ZjUsyIdns8ANBj7M6/qlLhROxZRKBS/cFWAlVv3fGliHzT6i27Ir0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464210; c=relaxed/simple;
	bh=itVTPHZ+PuIsZE0BM1sYE24Fx3SDQYfvY7I/eCen5PE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uSlYfVYxam34Lt1KDR2D4A9iDD3WD7KFIqoV8X4T3Qs5tv4ctFuDdRosbysMufcxEngcOnGmNbXvlOD4T24kxkLpslvbG9ScL3IgLl+UAuVrXlFGmGUjH8LAtJfO+iWoCmFip7z71B3tbZUbU+ypb4qmqOWZw6IpCkGWeNpUkOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMXRIxAL; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMXRIxAL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733464209; x=1765000209;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=itVTPHZ+PuIsZE0BM1sYE24Fx3SDQYfvY7I/eCen5PE=;
  b=FMXRIxALUGq4hS5LVbnusbsT1Nxb5wZJodP5Hp1lvPZJKybD/OBl7gsq
   p18p1d7D0h+fsFtSQughzA/ebZpiOxbZF8O/C5ZiBRMs7WwBjIDvGhdJ6
   qQjnQQE3n/Nvi+aA5Imlm30GJDN5U+uyqhZqSCQkfIGYjRR0JFJcmKm6r
   SnEhdsgLouZHDh4zTMXLXA1sL+8jGYcaLoWOJdsHqMtTDGO2MmFfDqrpM
   v2hkdCCGjaI0EYkwGPp5m8p19S7GEjDYvgBWyrao+o3izrjXFKgqIz+jG
   68wfTfNd873sjLvhJCK5JOMFp2zHdD0O8MYNe/XUAtv+zOU6R/g7SQKxH
   A==;
X-CSE-ConnectionGUID: 2OyQsE6oS2KMDNL9tnu42w==
X-CSE-MsgGUID: /bU8oy7cQ/O7Dq97zZP1bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33955848"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="33955848"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 21:50:07 -0800
X-CSE-ConnectionGUID: 50DANJ1JTDetOxd8tx35mQ==
X-CSE-MsgGUID: fxAnajDvTWinmfDSyPW77g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="94186605"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 21:50:06 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 21:50:06 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 21:50:06 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 21:50:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6DMeHdKiqvHssTPji5o+hj+PzcKAv/fnwjUSNIhcRAvhoEL2Nj663MqYX1SspMlyDx2+9ludFmjtP92NuNGrV63ndzMZ72xBVNdYFhGGxpUfV4qzWMWz5qDAXgj1oogU3NCcgp5c9mJ0b+pJeIy1RgD9O2H7/m9F1yIL7LaNBbaX4el78D8EnOE3XGZ+jynoBMXKIRYbJbQGefUYM3y84AYpfiEhImBSFvAb24lRSnwxOCPHUoHSfw7UJk3T0QWNEGL07b+RjGSBQQaBldZN4X6ifC9pzMF8LdAfbP/yXJKUnxcEUZrYR108kRSgFopqjWt3liWU8c0HnXdK08NBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itVTPHZ+PuIsZE0BM1sYE24Fx3SDQYfvY7I/eCen5PE=;
 b=XwK5RMEqcBZhm/TCSRxUzLFJ6UUweunMM6DBDE/2i1urP8TyLXjjyNujACfOpLBnrA7xhCRXLFXGctyjZhWWBJ49qdIBicScjb0LSGnib9/O3OYxFYSSVXNf4+iDi2uKfuRKoFJg4K4cyE5vT2L+UDrepEcUPHTHXsXruCplDRP/Pik/krtSNcNAI2jSqjeliet++X5gSlqPcTQQA8judStcO/koyH+1qWn0B6yH5ZiWH45r1dV6OnWNYD7+IAb69nG7X5Vgj4AwemWko3/opEC5hU980J1q/DYU+83JXPftYTTrqsx3c7JxUiTF6S5bvvTZYl6hYSo3xWpCT5Hqhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7798.namprd11.prod.outlook.com (2603:10b6:930:77::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 05:50:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 05:50:03 +0000
Date: Thu, 5 Dec 2024 21:50:00 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 14/20] cxl: Move defines and error codes from
 cxlmem.h to cxl/mailbox.h
Message-ID: <6752908851a1b_2507329479@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-15-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-15-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0295.namprd04.prod.outlook.com
 (2603:10b6:303:89::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 0002c31a-8c48-4b6f-377a-08dd15b9d40a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aHK3TwKDyB40SedRn7BQqER8/1TGg+CIdSU6dKRi77/SEkmfKsLvUCBNvOsL?=
 =?us-ascii?Q?cNrRDMXIO3t/bZhAkbcHZbnZE/17+/AGusz2nyBhgT8385dwu5gsspd1dMF9?=
 =?us-ascii?Q?l+C9D7mW/Z7gUGyDzxGFBdVDp99dcZnu19GyMxCGlzrIsC0qADji6a0kZwAB?=
 =?us-ascii?Q?LU7s8OT7uk7M+16qvFBdkFrhXsXaVZU5i+arrghyjvSFKaqO20JoHbNXdtZh?=
 =?us-ascii?Q?ai8dwKD2XZ68vuc+IN86ZgRSAlTQjiQUlhj2y5s7Zxk6NBv1z0jRSDc+Tpe7?=
 =?us-ascii?Q?UbLOVK27Uydkl1MG3jVrFVn2vHu5Fg0acNs9fzNvWYZWxtp946e8JNgu5FCT?=
 =?us-ascii?Q?M5jtRnpHixfez5mbOjpNXUvA7utD9mQdcdw00oq9bfgiOyVfHD6fnGe6gXRZ?=
 =?us-ascii?Q?pi5y8XwO/cM/uIkZKczh4N0Qj3MGSx2Q2Uo//qhs61wROmTUg58k5ge+XuYm?=
 =?us-ascii?Q?2WjXub1VkAg6akQRbyxQii3x9rVjWUC2LBdYUjCPlLx+6iYbuM1kofr+w2EU?=
 =?us-ascii?Q?8YReC7NPQluTP02e38dG+vpbDvrAsukej8mYZ0e84dY0sE2El2KUAPoNP0FI?=
 =?us-ascii?Q?P3zv0s5DmnUsW9vXMFzR0NC9SZhD8iziZz4Hk/7siTw0VhocvFp+LUi8Rfqu?=
 =?us-ascii?Q?V9H+Gf3EJoDNX6hIzKV2nRaXhKINiP4kXjcdhIM7FNUT8rfde48ULEISAGJ4?=
 =?us-ascii?Q?qc1J2wYeLhURuR2BmWKWLb2oXHMfmr1x9PI2d7KxoUm1jEocI9Bs/GmUaTdf?=
 =?us-ascii?Q?jzNUkNVBwQiXxFv5SdacKJn4OrXwfXllck8d4QDzssvoWQmEbNWqMI5JNf5X?=
 =?us-ascii?Q?RslrRer0qibJdgQnUm/A5G5HDBWg2fcpiicaGrLQCqByk7VumY+AnuWuM1Ac?=
 =?us-ascii?Q?j8n4ZSCvyeYN9lg9sZGzZB+PDwMGY1w6A56EdjmONLAvGYLyWOVfQrRU3I1Q?=
 =?us-ascii?Q?dyz2jnnNupReiwiE5PRAH4ojwASqnoQNFnaXS7ARAQHqNcDMlbf1u5qIS9L0?=
 =?us-ascii?Q?pakTFtBM6/2TqBVehbNsJkg3130kdpq4Whpwyrs7e8ts5F8CMM6126kGMd0E?=
 =?us-ascii?Q?W0wiUhiJqYvEf+Vv2uJtJ4U14Ah84Mmr08PI1zkBkO6R95wwDQW8/eWQ4s/1?=
 =?us-ascii?Q?+MA2EOP0Bz9NZGODSSWR+pWj2iaW9faryCLnl1x9MSDUEHpDoIDdKO0grSed?=
 =?us-ascii?Q?hPIT/EGppv8XoQ69Bk8mOwTJ1U+EC4ZPgtazWKO/S071mGn/S+Y+0C52mTJH?=
 =?us-ascii?Q?i9UHuwv6mU1SrdErbt72ByLSDSGWhBA3Aiskbphy3t2bvQglVNIoQ5NEthYE?=
 =?us-ascii?Q?17HmzwQI7xQKvi2WvCRJzsmEFn9uviNJRtWt7pDXiHgfUw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ljD4T35MJu0XSjmYevhtSEyby0cdJLKWjEbwTpgH2p40DCeraiKx6ZceFTBW?=
 =?us-ascii?Q?F6IKew8HXObfoIpIRHLpWE63prYWN0ig3rMrGA9Tzyxg9w4gpiWKu72ss2Qm?=
 =?us-ascii?Q?i3AXgI//VSxo5hGh/ye9GENiUNRb0pbNp4p8Cliq7SzzC/TxvwOo22+sOgy+?=
 =?us-ascii?Q?6uvx9Ot+QrVqBrRPAedzGqbzKA8GPOpk/y/1VktLtYxs7ajztk3dUOLydTNm?=
 =?us-ascii?Q?/+AXTifux0aDCM6x79tpGcrw8K77IXgWsfQRGoMbpaG/JFPwTlmGnN7U5txo?=
 =?us-ascii?Q?Lfxzv+tQBt/JDdG3yeP9rQgfIPmtk0efDB2Il0bc3ha7e3+PGY9GIUp6WQJd?=
 =?us-ascii?Q?4GkJG7w7W58EOLeWHUkO/b1KNQ9p3k/vFbUN2z81DZX/A8iwE1hwH8SQ8GBT?=
 =?us-ascii?Q?Fmvt1zFCbTjuQ/XMCFwiB+iNRSJpKuwv2gwdqlj++DusugCjkRY76TYVkvJ6?=
 =?us-ascii?Q?/2ByaLwyYUWNS55iW9B7tG9b3AQPwpH5jKRK3d5QdoExJ8loKk8EYOMu1Wd2?=
 =?us-ascii?Q?Hny7081D9MSMneTgvvMZyJRwuiHVlUldqOI9pBUc+xZug5lRsFw4vMeOVIF+?=
 =?us-ascii?Q?KzXj259ra/I4g9DPQJehEW9Oo8EMeMpOINbX2RCbldJzPenr6dSOm1E5yH/2?=
 =?us-ascii?Q?9G6/O5Ljq1KwOz88rp77Bd6yMJh2JGOTAtQ36fDa9v0F3b1+/0Lo7XD8UBGe?=
 =?us-ascii?Q?3awwah3XUdV5IBqzjIPpq1RZxsGZm7sziLjMd9IvGPv+r5QuCFfaE/xFXZJU?=
 =?us-ascii?Q?s7srxIBEFX7u8Xw/ABkoBzIS2x1PfwDypJqYu6FYe0N5Nk8CILcZLv3U7pfZ?=
 =?us-ascii?Q?lGBppwnOlewVFMYlaVWG86bKve21PeT1pwj1gLqayiiyYTiKYZXrEYrRL/MQ?=
 =?us-ascii?Q?5gsi3VQ0yeNWxjByUYpqULVGn7DuBgFv5RHHbOcC0GCeTzOXVj8oVwwD3RpO?=
 =?us-ascii?Q?hh7F1VxiWoeEWiYR21xGl5C36IVx7bLIYTyb84XZxGoSf0CqjKnTn0IJZG+f?=
 =?us-ascii?Q?LfPwJJNHxS7jkQuvbYO/awZ3XAeQiITuChQWNJlJFUXXudchBKE1PugBENOz?=
 =?us-ascii?Q?s3BeyINHWbdoZUbspnsv/tbuUaxHUOaR4gmV8BuEUSKEwYJuZX86iJpNnXYx?=
 =?us-ascii?Q?ULMi8xZS8sNwKsusGGAVBF0ZVTZONohrQGb9bYCs4HrC3U88U8x2q/CaSpHu?=
 =?us-ascii?Q?2veHeIgTHasDxMmCYP/JF3WzhXUNK23tkKIi3BF5oAZtuCt+cpKFh21MDuO2?=
 =?us-ascii?Q?fUNujkuDEOKEh1sIrNcR96BlhBokb0j71VUdxBqBPdbPL2Rup31/t5XI8MW3?=
 =?us-ascii?Q?Mj1yncfZFJD9NSX1RCiIvOSRwMCUxE12qiIFocWsewtmyYymuYXzKiU5c0Pv?=
 =?us-ascii?Q?npm/feGSNDyDcfMu4zR559XAuDAhPSANhMiJDlAXWc1H/pHwnNjp+AitLU06?=
 =?us-ascii?Q?D2m6nv1a0Czhp6BZweX5XBGIFeC5xh5ePsOLOUweCkXAI2oCTZ40VtWByNtp?=
 =?us-ascii?Q?5eEF7iQnSEZDyka1i7cPSDi4uBYPVQMn3S6pYB2neu9+1SgoqQDWeM8kNV7o?=
 =?us-ascii?Q?HOKTnsj0GdSSvmB+6zEYSjGxa5l6RlR3Zp3r0OcDpTq2oQgWjb7SeDElkLLN?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0002c31a-8c48-4b6f-377a-08dd15b9d40a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:50:03.2049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Bw+Wzy/TRG5ZqdVwyD+O9xqZwt00Ojdo7tcSpWO2BzNu5jPbsnXemQuFJS5WGX2y7VQR0yNOBwRqThnB4l3xjkaexipzvhkoTVaB+EGAkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7798
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Moving some internal definitions to cxl/mailbox.h in order to be accessed
> by FWCTL CXL driver.

I would first like to see some rationale for: drivers/fwctl/cxl.c over
drivers/cxl/core/fwctl.c. If the consensus is drivers/fwctl/cxl.c then I
think only the opcodes and 'struct cxl_features' needs to be exported.
cxl_mem_command() deals with CXL command ids which fwctl should never
care about.
