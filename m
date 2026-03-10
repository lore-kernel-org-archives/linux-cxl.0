Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DB34CFB8;
	Tue, 10 Mar 2026 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773170432; cv=fail; b=gU2ZPzsKje8DNF8iLHcwPVB+OiP87qe8KfzvxrkCj7gPOYW9LlylYOP77mfyuY8HB/xWPVLFYwifCyO1/dcp35uUvCooffF87EfSTO4jI11Dj2UzcXV5aM+hlkrgszdLjtbJ3fvhTxGJ+5EZyXEgm4GK0w8fusRmG0JLqRauKrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773170432; c=relaxed/simple;
	bh=Q7UePYaVzXcSKvRYQDce2wfRN7vzizJMZub8kH8xYXU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=irIZguzirUvM5UbC2jB0y0yYxK13Pyal6lXEjn7nsLZdRkLymgC7yuFJhIud2KrTyB8+z3eAI45rWQUEA98iADIxPgLx4mdts86OMv3qSQf3rtWstUjInFYtXxIbhtsqfC9NH4Hu8AZbCiA/Cmy1VvsAt+kjA9ARqHx1FJS4pQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+gf7gtt; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+gf7gtt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773170431; x=1804706431;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q7UePYaVzXcSKvRYQDce2wfRN7vzizJMZub8kH8xYXU=;
  b=a+gf7gtthCCUfBH/QSKxISqSsO1l6tfSZEBDDxq8RSauNESZrOVYZsdH
   tS4W0qz+bmO6ydRXr+tZvsnZN9rSUjUsutxrKMurUJsSo9G1O7vSYwaQv
   07GZkzwA3WrI6S2G2t+uuby0z46PCWpJRZS0edq1gd/8csa6uRA1nmqpm
   E7GvUQgqEzkSflYSomdnTzaiWSGtyK6fwA3NwNjOcVv4ZKrlHv0TIP/kJ
   /DIn5LGqOcr6wFu+/VQdofdRnFgL5NtqeS9xmCaVpDoUgPbW9qk1hhZE4
   tH2ITkRMN13m3Kew66D5iNSm4zBKBawFXydYz2dmw1lgR7vBLwRamXv5S
   Q==;
X-CSE-ConnectionGUID: tUkpseWzRu+XQmXi29Ib0g==
X-CSE-MsgGUID: Fi0uoKmlS3ywdC3ccRHJkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="91614196"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="91614196"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:20:31 -0700
X-CSE-ConnectionGUID: t+cUlN2UT/yTAXRG6cBYag==
X-CSE-MsgGUID: o53/Y7cdRHyuEQ/yPJUorQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="224397457"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:20:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 12:20:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 12:20:30 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 12:20:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaV3SF9pNcbaaHei84Cs8g4W/cCAxXKX7nzkRlYiJicImG7QzEmsslUek1q7Hp+Cg07HIBFTh8EsdVsYlpWL60+hMz4icFaKKwOY656WZUBgi1FY1H+4ctUe9j3pL+aGFiCFFDZM5E46qCBOxzCVRDAkSLGRqE9nT6v09VLZ2etS45dxuhRZ2R71X/czJChjahSIPeRQFOGlMASw4Dw7rDnyebBoRV+ozeotrCSZRrwlCbIasQY6a0x9YUIbHcgyiWHCl3p5FVk4HH2jDQDPjoAdD9TAq3zA9sRWOSlUqtHqwFUMtKsg3WtlkpZAmKiWqVvfyP8Xe25MvuV+eZchXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeFPtVXBLjxKE0v67/3ct2he9ZKX41AFA9wq10eoIHk=;
 b=tTKsFNIb/sxUMQDhMjOxHNRaNF5r+MyJYDttCFtCFnKLD8y2E5MoMKlUDasY8c+YlaChnKn3zpDXsLrAJAWeR+ifiXiSEVP7SpFZ6scPcf92BEJRcvFltR1eD/C55N6rYUpI3d1eo4pakc9iyt+7wgh8cD4/UQcXmCBdqZqPLkQMcAvv7u4XvYuc7EFoUpQAxnm9f3EWKA8E5u7KNNASL9DIVAy9jXCqk+sknbYMS4q0tPjLYx+Xk+iCyZRAcYc9pFZVTn4ivf3F1OPp4RboYWY6pJWOLiK+QgpuCx67tYKEtN3m3rdKBFfuOrPaPj7RdBbtULl5bMIE+aEDtPyHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB7065.namprd11.prod.outlook.com (2603:10b6:806:298::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 19:20:27 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%7]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 19:20:27 +0000
Date: Tue, 10 Mar 2026 12:20:19 -0700
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
Subject: Re: [PATCH 0/7] cxl: Consolidate cxlmd->endpoint accessing
Message-ID: <abBu898S136I1u25@aschofie-mobl2.lan>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:a03:333::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: c0dd9510-b8f5-404b-40fb-08de7eda15d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: mD3BDYJ+JzI3fZudWedL9fJEluvlMjzDDf5+Q6RM+0TWseV1fWLwabgib4j5me67hT7MZkiKJHg8d6RdEo/riX+x3XjimJjbMGdcNoUoRXEzc1LLJHazAi6uf2SiLfzYRZPN2buNB/JXtSG46Kjj8rCkdSYr/zJNCFDAnzbB6VfCwwa6roRi1yTQBXTt4cnMY3e2nF9+s+KoL8CVB9pzp1RDEwtUS5c2qu+AHUMmIUb+U1dfWQPrgAZJPw1P2uZxXLt+Zcv3+XSOaDSu2FYms4rWcqQRZOyz8W80yaj3SdZmIq3+lDhfRk4KS554xhFzoPa7O911wZWvb5cehovIhHGRaAJ8cjO6wtMpTF1sFpJJb42gO/6Q5yRf43Ix4Tro5ofdlZEZgibY/ffM9/760FJvOLTizS6++qhnF6gju9zj8Js0bbd7WmxxkAgbvdHlpVzUWUzHxnVQnV2A27q9UuLAg1XnGPPnz28zGHlU1NFN0LvcrMN5Ik//CiF78Vrxy61+tt6PeBK5IOJU3YgbEc5NSCnYF7+oY2bzFtqXwfoWdp7Tuy4/yjeQUq1iY31JRe4N5AfigJQrtQ1S7cqs8JUcgA8d9iJRIyyMRFvrErJYUgATWDA9wmF6RfvNREEU0MyK1Ghls2Ay1EsR3CmeYSCpULL6TMMAYS53cjebhdtRwQVI3tK56bV5mLiWwhz2F6+OxWFw6Uv9vVZe7d3XI4tCrK1ao8fEGKVF8gfhPSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yo7DZ0y/qtp9Eq2J8YS2qlVFZgxYBKU5RQIs1hWAZanDtsjtNZ4P1e2nRV4H?=
 =?us-ascii?Q?JJ7YKrT1Gu7SCaS8xsIHBtttpD/kqMxw0TkC0kZgG4vHC0dnyrc5GDYKDYSe?=
 =?us-ascii?Q?nuSg6uJsZyWOfia2NW9DNHTWSmTqoHAwmit2Mqxl4Uj8P35mIctQ9dtaaf6g?=
 =?us-ascii?Q?NpsDtkKG+6qF4F3u12N7tIr3a4QNuPqIhCeZ5lPIXqGgeb5cbNQ1lhEL2Kxa?=
 =?us-ascii?Q?niv4kbjRVY3rZXod5e675rY5Y2776Lo3oGff8tcvarZNUWlWRGfM9CUUyAiL?=
 =?us-ascii?Q?E76suT9+OGKJoRwSZcVLRm8iZb4kri8G+X2Vc/rjNRSU+Nq/sSG+bnFDooax?=
 =?us-ascii?Q?oBFa5HKHXjfZUZVkN3MQqbmczis+bCe6MzA9IEunySmsI0+9/Hde9rVWoRuG?=
 =?us-ascii?Q?n45ShvmJL5DLZk3V45SRtsh2sHQaMUaSnH2QT8RzxZZsRCGwW7oysAiJ/Guz?=
 =?us-ascii?Q?2r4nFM06Z0saLjriwyFW+SKRwEY+r3l9nxfs6NoIIUvywDJTkDQ60Ej5383p?=
 =?us-ascii?Q?bOKGGtqQOBksqNT4hScbzJAAg2An89iytCUBBBAwXFO26B0XDSgDlKfvyBH7?=
 =?us-ascii?Q?am5EuwcmRE+MhyZq4JfE3L/I2MHrrxZwsp9aqeiZur6ggSKI3srfdLnFV/Xx?=
 =?us-ascii?Q?tDkAMyoSky8s8WUO/xbxc/HmR821Hj14rOgOA18e/R8RFysRtbY0qaWMVyzl?=
 =?us-ascii?Q?897oSx27oK3mgwhICro3IKZA4suPIIxwm9tMmH948U/mY0/B/PFRrDjDKaz2?=
 =?us-ascii?Q?nhii+atyhsXwINT0DDQn3qZGyqL03soQfxhhTF/+JAlVOKNmrUo0faojHgQf?=
 =?us-ascii?Q?MyXYTmDeFAb4RCxqqHlmEZsCCQudoSh/R0XBUmaG27TGbx4C8J4ptjZpzHyp?=
 =?us-ascii?Q?ibxtnLMYlm2/6a8dBeBVldgxHB+Fe3ZFpq/wQK2qd6U5b8I34LlWH5CxTiX+?=
 =?us-ascii?Q?IBLHV537YC6IJ31qSjJ53dCKbGzjwSXh7ras4ask5mO6G0C9HoiRgqvZkGwd?=
 =?us-ascii?Q?DPS+0fGUK84Ru+PtWum9CDKKyF6tkJ+12h7Gz1arWCit6QVxTl+Bm2Qh9vmu?=
 =?us-ascii?Q?KxKXDrm4VvQZOQL9EPtxLKv2ZeO4hN50lHLCZ6Q3Pz0k+f8jl8vybYWsOF9s?=
 =?us-ascii?Q?9MlchXYWwP2L8umOZEGIUXrMdXYsKcWJS5eQ7VvHPgwHB+MxRtbyuCH8Da5E?=
 =?us-ascii?Q?cAG1myulVa5R9xRw4lFy2lA+fDFQre169ToEishFjpB5QD+/Irq4Ljx42XOH?=
 =?us-ascii?Q?yvtglNmArYPgwabcWkTSuTckzccj/wyNrTDUWpI9ySQuAv59Q53aYwshXo9w?=
 =?us-ascii?Q?MIuATMb53aWlHLpbZ2TmNPf7fn7fKftUyO73dP/nnYT2yR635DzsgiLarJ4P?=
 =?us-ascii?Q?THS8+lqIcjcubjwbqGkmFs1a0fZBym8Hr/Ma4XjxZvMEiXDb7XD0aowABcbc?=
 =?us-ascii?Q?v/IBdeRA9bzGyScOQIIJxG7bms+LvnAKeFDWvj1JJQhfHXMuJkQq5WRLs24P?=
 =?us-ascii?Q?r3vAMo9yMDvJXKrmpeXcWMBqib7srjLjdX6FM7X8TUsYbNGvMKy05lGcGzSX?=
 =?us-ascii?Q?W7p6t0j59nHvelMw35NRmwxKYq3jBq0xRcH+s5DQgjT8ZvVojvLS8QfdLFBS?=
 =?us-ascii?Q?/F1hfcB0+GAy++4YxuwE2DZeuzJA6Lv4CQ24Q69OBdETftyFGl4jBdxTducM?=
 =?us-ascii?Q?Mh5i57paCpTyLpLW2KVYa9r4hdeaaCXOjhBmOmDX00bsKD9IzRxC+ZjRvmVP?=
 =?us-ascii?Q?I7pIP+fc/fre0w+WGn9AlseeadHreYk=3D?=
X-Exchange-RoutingPolicyChecked: RZU60p+0m/gUgyDNiCAJE4Gx0v4HRE2JlQLBJ3y7QS5WanN/Zw12h8kyykt85yDsKj5rU85W30DZ8loCyKiziMQzqdPjfCPp5FzTt9RI4gzE8VbNYc2b7rPydsjS9iy89v4+wM1vit1bYpCUMAbuzW7gDZ1/KB9lHgC8AGK8Unsj7OCOfT0C+/pMc2ncFLsSKJsV2u6Zke0EN2WYUH8/cgifFYKJAZeI8pc3Dlt8wppp+/aqpkKZuKKSoeYGi4k2rxt4MDMQJFx6G7s6SZmYpYLbWzk1RJ07yapPa6t1EC5cH5se5R1JaooR2hWiztXB5C1TwoKfH7+okkT8rnpPkg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dd9510-b8f5-404b-40fb-08de7eda15d9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 19:20:27.0143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbsOkqHtep6l8OPHHvB9fF+4/BwpwTMLwf0mOC1DXQ7UPjac4SFGRyqSv1z2Rww0mP7lI6LssLwA9nGPUaGS7R2KZFY0UCqCWwqMkX/Ve8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7065
X-OriginatorOrg: intel.com

On Tue, Mar 10, 2026 at 11:57:52PM +0800, Li Ming wrote:
> Currently, CXL subsystem implementation has some functions that may
> access CXL memdev's endpoint before the endpoint initialization
> completed or without checking the CXL memdev endpoint validity. 
> This patchset fixes three scenarios as above description.

Hi Ming, 

I notice you didn't give each patch a fixes tag, I'll comment
in that per patch.

Below - a couple of questions about reproducing these failures:

> 
> 1. cxl_dpa_to_region() is possible to access an invalid CXL memdev
>    endpoint.
>    there are two scenarios that can trigger this issue:
>    a. memdev poison injection/clearing debugfs interfaces:
>       devm_cxl_add_endpoint() is used to register CXL memdev endpoint
>       and update cxlmd->endpoint from -ENXIO to the endpoint structure.
>       memdev poison injection/clearing debugfs interfaces are registered
>       before devm_cxl_add_endpoint() is invoked in cxl_mem_probe().
>       There is a small window where user can use the debugfs interfaces
>       to access an invalid endpoint.

Do you have a reproducer for this 1.a above?
Meson unit test does support parallel execution, so we could create
a race btw poison inject and region reconfig. It's an interesting task,
yet low priority considering the debugfs feature is for our expert users.
If you do have something, please share.

>    b. cxl_event_config() in the end of cxl_pci_probe():
>       cxl_event_config() invokes cxl_mem_get_event_record() to get
>       remain event logs from CXL device during cxl_pci_probe(). If CXL
>       memdev probing failed before that, it is also possible to access
>       an invalid endpoint.

b. is reproducible.
Since your original find of this, I've been thinking about adding a
new group of tests, like the 'stressors', so that we can do things 
like this on demand, but not as default in the existing cxl suite.


>    To fix these two cases, cxl_dpa_to_region() requires callers holding
>    CXL memdev lock to access it and check if CXL memdev driver bingding
>    status. Holding CXL memdev lock ensures that CXL memdev probing has
>    completed, and if CXL memdev driver is bound, it will mean
>    cxlmd->endpoint is valid. (PATCH #1-#5)
> 
> 2. cxl_reset_done() callback in cxl_pci module.
>    cxl_reset_done() callback also accesses cxlmd->endpoint without any
>    checking. If CXL memdev probing fails, then cxl_reset_done() is
>    called by PCI subsystem, it will access an invalid endpoint. The
>    solution is adding a CXL memdev driver binding status inside
>    cxl_reset_done(). (PATCH #6)

Is 2. above reproducible, by inspection, or something else?

> 
> Besides, the patchset also includes a fix for cxlmd->endpoint reset,
> cxlmd->endpoint is set to -ENXIO by default during cxlmd allocation. It
> will be updated when endpoint is allocated and added to the bus.
> However, the CXL driver does not reset it to -ENXIO when the endpoint is
> released. (PATCH #7)
> 
> ---
> Li Ming (7):
>       driver core: Add conditional guard support for device_lock()
>       cxl/memdev: Hold memdev lock during memdev poison injection/clear
>       cxl/region: Hold memdev lock during region poison injection/clear
>       cxl/pci: Hold memdev lock in cxl_event_trace_record()
>       cxl/region: Ensure endpoint is valid in cxl_dpa_to_region()
>       cxl/pci: Check memdev driver binding status in cxl_reset_done()
>       cxl/port: Reset cxlmd->endpoint to -ENXIO by default
> 
>  drivers/cxl/core/core.h   |   4 +-
>  drivers/cxl/core/mbox.c   |   5 ++-
>  drivers/cxl/core/memdev.c |  10 +++++
>  drivers/cxl/core/port.c   |  14 ++++--
>  drivers/cxl/core/region.c | 112 ++++++++++++++++++++++++++++++++++------------
>  drivers/cxl/cxlmem.h      |   2 +-
>  drivers/cxl/pci.c         |   3 ++
>  include/linux/device.h    |   1 +
>  8 files changed, 114 insertions(+), 37 deletions(-)
> ---
> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
> change-id: 20260308-fix_access_endpoint_without_drv_check-f2e6ff4bdc48
> 
> Best regards,
> -- 
> Li Ming <ming.li@zohomail.com>
> 
