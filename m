Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66832E370E
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753147739; cv=fail; b=IBtczxeJO7cm7i4ixnT05Y81swlVbbBNfVZLsX/gHIcIQTZV7gjVi+kpS2MWpXUfI5gNPErejTioKbtrlqPq/SFEAfb1m9oiy9LcNSPxPn2XzfzzBq5/C1SLqI8ubZz8xkSaZJ+AJk43JRZryBoH4qrj86BIJkEXr5AX2EItuNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753147739; c=relaxed/simple;
	bh=m7ruLRTaE3OQwIdnq9jHzZkIbwPhXDGK/ZDEyEvydQA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mA5tWPg7bg4g0hDTMLM3Tqx97ae4HMjOwWpgRrqURGIzuEStmS40Ki036MaT42GD2K+VSnPQL6qbTpkBqL3jwE1PO6sJAPtL96SSVk3Sv28JGHye4MA7lu7Fo/1T4hIBU9UC347ddkKjbVa3jP4aD3DS66xWSulIjmmEY1Fa0Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCeIhHBi; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCeIhHBi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753147738; x=1784683738;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m7ruLRTaE3OQwIdnq9jHzZkIbwPhXDGK/ZDEyEvydQA=;
  b=iCeIhHBis7/VAKX45/sT7zXWq3q1SVuHueAxYHr7qD9k2KjWNOjIIPG3
   gMtS/LSPnlbjvvkvi0xjuGlyL0gqr6LgPzO8pi+fceC5vF8oc27Y8Pn3Y
   aj1fD0Dz4yTHpMv7P7uQLEIztkYGiaWSeHnCyjoP/5Yd8ogUvVEWdgIpU
   yjdmrbA77hASczFJ4OqVxUhZkVmSxnQoN54Uau20l37vR7AC60P7CR8Jz
   2GhuFB9VuxYEQ/u8u5H10hlO5OxIT1s6HZdXHAmYg92jyA+j6CIyr10OI
   +BUIJF6zkWdKGRLVvxCiv99fpR7TJwyC9J809/YL41fqzcd7Hm/FTry5+
   A==;
X-CSE-ConnectionGUID: y1uLQcefSf6ZCvADB8CwOw==
X-CSE-MsgGUID: Du+rqvupQW+SEqHLI+Gx8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="72951475"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="72951475"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 18:28:57 -0700
X-CSE-ConnectionGUID: +tqC4xzJSPSIiAkSoVRIGA==
X-CSE-MsgGUID: MM8GK40sRdqOHpaB8gtmSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159085777"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 18:28:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 18:28:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 18:28:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.61)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 18:28:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0lSClCOqfsceBYEcPMzc2yMu7sP1FUVKn2Kz1djPRB0D51WMyJAW6x+yI4/2+9p7hkf8t05OpnkabqU3aBMKwykbNHjQnthJIYPQcvddhEpKLQ//q4EPduXEbyYR7DcPAtURPPQvm/0F3tuEAVZotZVYP19khbL8qf6Mlr8gOQqRLoX+RNOSIh6mc0wmdFNcIwlH05Expy6WtdEo+oC/6Gut85E4A3dQ7ZR00izmLZjYSmS2uxQqcNeWusESfrtIIoropUNSbpVG/U2FqwRYSO3rI/DOLZH2TNW79RrCAp4NqKnCXtQSB0RgFPdTaaqA86Ti5ULLeOYTHz613slww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtxJSHFRgEUUWFy9F86Eg+Oqx5ZSyMpjEZRL2cyh2kU=;
 b=whR9WiQIvtg65lkpVYtfWAOA9Zxc992XPoA8wUy44Fg9UpZh7gLnXSAjjbdR77NalaLdPKBuXZY/TR29+PlGIWfGLltfW2SsozZZAH1VBeo8rfz7OOmUYQ10c08h9ZKqHin3ThmxoqwcmsC+F10cG+BcIXXLH6sbct2ktJCmm7L24sQ4lkFAb+ub4j0KxuC0xVLHdHZOBI/RjzbpLDlaDdXzUoIEW/1qDp6dcKQa9EmGgUPDb+Z+TnK3W10XjxfvzIHkFuIqS9prrxMijfI4MOpBovzAldjYEBkaAM/4ke5VPl0oMJwGcShqYmtSm4JqpLhyJmMsbHortivJj/Qupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB4933.namprd11.prod.outlook.com (2603:10b6:510:33::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 01:28:53 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%7]) with mapi id 15.20.8922.037; Tue, 22 Jul 2025
 01:28:52 +0000
Date: Mon, 21 Jul 2025 18:28:44 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<dave@stgolabs.net>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl: Add hpa_to_spa to the root decoder callback
 operations
Message-ID: <aH7pTJghWo7pZCAz@aschofie-mobl2.lan>
References: <20250709200746.2567860-1-dave.jiang@intel.com>
 <20250711174530.0000291a@huawei.com>
 <aHFazzPSfwvymGZF@aschofie-mobl2.lan>
 <20250715162342.000069cb@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250715162342.000069cb@huawei.com>
X-ClientProxiedBy: BYAPR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:40::34) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB4933:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1a7389-dfd2-4e9b-8172-08ddc8bf1dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yd747CIh+8pwF3htGJ/I5LywCvSqYVAPhwQYJuZ0MYnVvZzfUgrq4ePJ85oe?=
 =?us-ascii?Q?XCSHl9qtLiQ0cJ21oIZxkgJkQfaBiIaS4vB05157FlARtw5GLZUCGdzi3Fsw?=
 =?us-ascii?Q?Du0A/Qd19S1rQQOLyrChQaplB3pV0RWZ7P74277u3s9UY1dMzWBEtCxbe7wO?=
 =?us-ascii?Q?hEClHqkBwvm/003+UJ/QvrVze53ZVZNtw2dtpSGc+SUXDIPx9NhIvFpEW/aH?=
 =?us-ascii?Q?56Rxa8mpPagJ75JH0P246Re3vtGh0L2S5nM6QXYtgdYhiHYwJJWA1sVOwHOf?=
 =?us-ascii?Q?/319djFlZ+NcA+efv32yQ/UVuhyI494xuBgwLuRK40asHyjHw/Wxjdqo5lG3?=
 =?us-ascii?Q?qKLf2ebLJ9IqTuOxZh1ID1+dfzhCm8Dn8drqne/HNjiVpQfwpVKXBflTkab3?=
 =?us-ascii?Q?SlBCWrMdVXZcrfTolFHZDjFDatlp73DJ+m+ag/hBrzTW9D9zZypYDpmD4AdY?=
 =?us-ascii?Q?WAT8TEnvjeEcrszqmsTjGRWFG4kgz45mLNRMt57KJ5X+ZRx/PG9SG44MS1yd?=
 =?us-ascii?Q?csO1FCq9GwXemQ6s05AEFoAtpjOcZ71f60g9XYD/4nwJOpjNraZ9g6LddR61?=
 =?us-ascii?Q?NYVuYlhp7J51twNywV28gwR+YVsBvSs4/7/ehaMyTI2m86y+5OkVYOzBjROC?=
 =?us-ascii?Q?3JLMlBZoo/FEuNaZlr/mi+VDDWPfgYiELcQf3ZR4kDJZ1Z+WiqfyrKrOxvca?=
 =?us-ascii?Q?8EMiOsVRIuIUHL5c13ZV8KlrjYCmfVwowniE6KEEv4BHda/RxVMM4GzPCOiJ?=
 =?us-ascii?Q?TOLx6R+l2GmIv2e5YXskV+utPrTXM7Lbn7vykCXQyXFZG5fxq34uyEeY/RuU?=
 =?us-ascii?Q?FWrGWcqnS/cNdNGkjshcWk0eMda0SijiTFSQMtkrJ3XRdK/kwX3R+88pURhj?=
 =?us-ascii?Q?XYkZi4PdIpGSpuZdeGoYBcTJ5GgfnTxYKTl4UL/1tz1gbpzaWXaksuU6lGJo?=
 =?us-ascii?Q?EE6t7RkscgXw+k5Q2HNh0JKIz74nL22OoYbeUFFQiXNbAYSWo5FCdU257Q4w?=
 =?us-ascii?Q?KihM0893fDNUPxdmwibqRX1Ao/GFY6VxS+c4aFFFcISxWdsB7bFE6+jjv8vj?=
 =?us-ascii?Q?YJxWS267LqHx6VYO5fvIEoa9DKSW/Fzis7HxDavTbtN7RvxdWclmVI2bWpng?=
 =?us-ascii?Q?u3r7ejP18ZbDpYrcKgu7MwtTmq0qzOooQEdpfSR3tbhVgeNYqIXr7vQkxsBl?=
 =?us-ascii?Q?WnAge9Uomu+7BPetZOY9lESYeZE4juXj06pqg5aYjC7et68sGH+B9n1b/7wf?=
 =?us-ascii?Q?o/XJYVth9M+4gZfgE3uGGfDcstp354+u1qbTpuwJNvYO/EqANrrEr8kYc7RQ?=
 =?us-ascii?Q?N8oKREPKTMct4EwXL5Xo1YgozbTn3c7Qs/LB5dPeQQV3fVYeN52k4qGa7RI8?=
 =?us-ascii?Q?lNREW3kmTQNj6O2A4N00B/SJ071Sb83uhcHxcKLVxEEtl90eru8TR2HyMTND?=
 =?us-ascii?Q?nib9bPex2h0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oEFOuiDk/VFd1tjEKw7HquzQ1Z+OmvfRwQR9+N4VIvjPJqSrH3wOyg1g+k7y?=
 =?us-ascii?Q?4wxhLlFT9rsXaeFiqHCi70uzE0Hh/GhOpDmcx6LpORIoa3Oip8XMXsYrZyed?=
 =?us-ascii?Q?c/6kzZFTw0CrZoWEMAUjaK1mUQ6z0sb+P/7UVDv1qV7gptExDt1y2JzHIJvJ?=
 =?us-ascii?Q?2DAdJjqYx/0NfN/L1Vsm21s5wp4ENRZh7FFwBaS34VzHGoWHuM75QquoCU/v?=
 =?us-ascii?Q?OD7ldUoL2WjGB7UwilH51e77ddQka4+ZZHYcCqsjd6yfTKnouNOr6t0alZu7?=
 =?us-ascii?Q?i+JGBcoXCCVayAQ/V0ThxZYE4LcR3L0Mi9RIEY+VfFUvA4y0IirikqKLhp/f?=
 =?us-ascii?Q?m5sLCmlkjjUkFcoqaQaxcPrP65aAx51ylzll06HLj53+WGT0RQM6J037vMsr?=
 =?us-ascii?Q?1rd1i777Hmi9M+HK0RKPVQUg/n2R81TwGG3G8jXPMObFBF82qaUOhxPALCRA?=
 =?us-ascii?Q?SkmiIOGHxVqb/p8UUcAJ5SyxU6lZ/qkeqKqV+5BU9NsSMMdIKdEuH60f+igy?=
 =?us-ascii?Q?aHMZgcoqSObGsoO9Z0FBo3wKsCFDnPJ4egAMpQEvHWEeAmmdjtRPv2q27QIO?=
 =?us-ascii?Q?XRvCRldgWYvXQvyfy8jJEpFvAVwj6FeYQ7lBt3J9seu28ZA+N2nVO4KqRuEb?=
 =?us-ascii?Q?A80b2ThsE/KTwNiyJhU9fHfJToY5rEP0H7q7GVGZSrAsRsD9NvNVLF5oY9n1?=
 =?us-ascii?Q?nExmBiIVvLxOWar3o1koOiJCIkgkDsZsnQENKiKLHoPSTwTRAQpqEjjqLo+5?=
 =?us-ascii?Q?Y8i9DNkpDvwNWjjDhVrp5m2pTQuSSV3Y6CCG29lNZZZt6i81j1DCaLihmF2k?=
 =?us-ascii?Q?HcteGHgVB+TLQ9FfQwS70RWFchjdtEqB/cGpFFGkyv5RRh0u4B/P5QDuIQhF?=
 =?us-ascii?Q?3SB3MSf4GVxldRmN7aPUWFA0MHcuNFDyLleDbRJIlY/ZTdd7yrYIzI89NrcJ?=
 =?us-ascii?Q?MJaqUcKj10eCS2NxW0RRKPjReQg7AWH9/Y1RFj8iMXHnsd9RhmSz5iSJHhcF?=
 =?us-ascii?Q?HEJVE6wlo3W7bqJAhHhZOAAkkid5P3+yhgK98Xa0x7Vnr2qqXqowNkam50OB?=
 =?us-ascii?Q?LYC3Cpi+JQiE0kEDP36lksAejKVHtjnW53Zb0wm+bx9nIz/U/Bu+auPqLU1x?=
 =?us-ascii?Q?ascfYFh7V+wmjVCUOHQNGH3NUKCXEYjhuR6JeCZv/iB0Ys3nKY/7NR2O+56+?=
 =?us-ascii?Q?ViWpGpwxJVOYSfTrb+wTsHOKGYF5G27PdyY/wAUN+YhZK7VLwnW/d6/UMIqR?=
 =?us-ascii?Q?COn1St0PZ2dny6ToSpUHKkqtmeumPwr4V9WJCnzcb63c8lvBXLyAhnQayATi?=
 =?us-ascii?Q?gYiriYHed0mWl6vqvQt87Sa/pJPzydAcUKOaHt1ySzsy0OPo9TBBVUG0OzfZ?=
 =?us-ascii?Q?IhUDov8+NRJUc4/xyMQYMKldzekOytBzUcjAtTtny3fzRLaGHTY0HvlUzQX5?=
 =?us-ascii?Q?O3GAFCU4ieleezxExRPca+V6NX75iaZGRxI/vNHSPMNVQLF4cIaCMOihybc0?=
 =?us-ascii?Q?UnIbo0/aj9sPPweZoyz31WkyJMDEZlIgyaOixVSKkaV+6vGKgxcWwMtz9BQk?=
 =?us-ascii?Q?4J18jF8mRQwZGIQc6+OLhrVEmwa+247F1+gJLwwdSHeQQbY3WFxdVLhEmYGS?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1a7389-dfd2-4e9b-8172-08ddc8bf1dec
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 01:28:52.7776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/LQXhA1d3DDFzj6Te1h5/iZtgKmAraN81gTUWlV1Gqnp2aDpLusdStTnmaUX0l8ELiWdmreS6agzkJGBXCl/vRAXaR4jADWkZcrM/QRRq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4933
X-OriginatorOrg: intel.com

On Tue, Jul 15, 2025 at 04:23:42PM +0100, Jonathan Cameron wrote:
> On Fri, 11 Jul 2025 11:41:19 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > On Fri, Jul 11, 2025 at 05:45:30PM +0100, Jonathan Cameron wrote:
> > > On Wed, 9 Jul 2025 13:07:46 -0700
> > > Dave Jiang <dave.jiang@intel.com> wrote:
> > >   
> > > > Remove cxl_hpa_to_spa_fn callback from cxl root decoder and add the
> > > > callback function to cxl_decoder_ops. Refactor to group all the root
> > > > decoder callbacks together.
> > > > 
> > > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> > > 
> > > Question inline about mixture of types of CFMWS entry.
> > >   
> > > > ---
> > > >  drivers/cxl/acpi.c        |  9 +++++++--
> > > >  drivers/cxl/core/port.c   |  2 +-
> > > >  drivers/cxl/core/region.c | 11 ++++++++---
> > > >  drivers/cxl/cxl.h         | 13 ++++++++-----
> > > >  4 files changed, 24 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > > index 48478bc406ee..9f7e2a49dc5a 100644
> > > > --- a/drivers/cxl/acpi.c
> > > > +++ b/drivers/cxl/acpi.c
> > > > @@ -20,6 +20,10 @@ static const guid_t acpi_cxl_qtg_id_guid =
> > > >  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
> > > >  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
> > > >  
> > > > +static u64 cxl_default_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
> > > > +{
> > > > +	return hpa;
> > > > +}
> > > >  
> > > >  static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
> > > >  {
> > > > @@ -342,8 +346,9 @@ static int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
> > > >  	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
> > > >  }
> > > >  
> > > > -static const struct cxl_rd_ops acpi_rd_ops = {
> > > > +static struct cxl_rd_ops acpi_rd_ops = {
> > > >  	.get_extended_linear_cache_size = cxl_acpi_get_extended_linear_cache_size,
> > > > +	.hpa_to_spa = cxl_default_hpa_to_spa,
> > > >  };
> > > >  
> > > >  DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
> > > > @@ -425,7 +430,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> > > >  	cxlrd->qos_class = cfmws->qtg_id;
> > > >  
> > > >  	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR)
> > > > -		cxlrd->hpa_to_spa = cxl_xor_hpa_to_spa;
> > > > +		cxlrd->ops->hpa_to_spa = cxl_xor_hpa_to_spa;  
> > > 
> > > What happens if we have a mixture for different CMWS entries?
> > > Some xor, some not.  
> > 
> > A separate root decoder is created for each CFMWS entry, so no
> > conflict. Is that what you're wondering?
> 
> This isn't modifying a copy. It's modifying the global structure
> that you make non const above (or I'm lacking caffeine.)

See it. Every root decoder will save the same address of the 
acpi_rd_ops struct, and then some will modify the contents.

The extended linear cache set that started the callbacks went
in another direction and no longer uses a root decoder callback.
I've adopted this patch as a precursor patch in the poison set,
so you'll see a variation on it soon.

> 
> 
> > 
> > 
> > >   
> > > >  
> > > >  	rc = cxl_decoder_add(cxld, target_map);
> > > >  	if (rc)  
> > >   
> > 
> 
