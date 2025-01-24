Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074B1DB363
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737757333; cv=fail; b=rcfOngtMWVo9bo+ASDsoYNkJZuowm6QY/FH0g4w8UByqn831EIP+YBtkZiiAXvSXHyfjq5dv7nKqTHUrR0rnMWDmbxfhSdBukdXobfD5BbvQflG+K2EKH2g0gZdLcOogh34FWgJoFbSWDuNPdIxrckbhj26S8TcJQLNyhPByCq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737757333; c=relaxed/simple;
	bh=+y7VdLSFQPUOAErALeQkIPUBDYfLNHRx7l5rNbreZ0A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DVNKNEcsFtQRceb2jVW7/4lcg6MxiHWUJElIuWS4uM6k7pAXbKm2NRSIeE3iEOqUZ0+F7rT74EeJa10UwskJGTvfv2lQQUjqNsHe1NeX/ojaoTVK5rRuLWdyqKnh1Xz0yYGPyoxBubd8DujHTNcAWsvkyOcvh83yOAkq6HEKK6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUi0Lruk; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUi0Lruk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737757331; x=1769293331;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+y7VdLSFQPUOAErALeQkIPUBDYfLNHRx7l5rNbreZ0A=;
  b=mUi0LrukdjmnYc3HBWlTbKS4wnuHj3IvceEL8JVimzVp9uMq7TmQD78Z
   OVZMsspQ0gAjhm6o9EATFb+0OysNFvnlGGhY6eLgDCjpxErbX9v5BgNpP
   bgo96excpIGp55U1LUf/fVSXkL4aFhU1cXTsOBzXEnt0QqLFIGte82Rmg
   GS5Vu6Un+QF/RzPWX4ZP04iBsRCKF06K1v2q3l8rUopX+L+Og5DUT6cjd
   j1C4oXGAXrSjlhXxWCgbNPmmJIcBMf+0xalQehyCMYhyUMg+1o1iqRnIr
   0Xm0T/HYogzeIesKO/qv4rzr37uUAj/O+h7mvzVDpZvhXvzdm5oaIgZNC
   w==;
X-CSE-ConnectionGUID: dIZg383xRoipZ17SQNWcPQ==
X-CSE-MsgGUID: 0S1Q1fS0QJOAtsiBubWb/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="48893409"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="48893409"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 14:22:11 -0800
X-CSE-ConnectionGUID: YOM3/8y3TeiAbU9rvTfJ1A==
X-CSE-MsgGUID: 1L1Vt3gISw2sPGrLHGHZew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112828945"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 14:22:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 14:22:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 14:22:10 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 14:22:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYRs0n54ZM7mJ7KlAYV+AxQQEJKqQNnDdWnuPgFbFACrj2yh3wfSzmJqGrNxlZfWGjDyRXrl/R/i76LLIcnRSIlksTagBo8STv/t6VR7WhOGoiWAmgbdB0EOge5ABZMlVhwkUsKr5wztBKddV+cCGRwibPv0lXG+kdlm0eylxQoj6bpqu9pB/2lEhOg8dQUKSiyf5uM4KLhUZwYPEkxFyadNk4177ojrCRQzbUBKZXdeuI5gRaCsIOCWWifWyBxeFfrLVBntbg4zCmWObL38fwIqmfHHqozk0PmcgUMjvK93CGpW9aJzdxTs2DnH/USodinoODBIBo9IFY1K6nIFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Vob4NAtXtxHoQwhukGplYwz4/ewfVyA6BcV3PcYLH0=;
 b=k8MgOgNuZtnl25Or8vT6oPWT86IP+eRyVR0TpIGRWvaavU/7FIDYd/Tud2cIXGLGti7LABnALBq9040MzpjbKOGwd+kLYE4sYN3u45zW6XGf9TimbVi7OiNDnzFCjRXFXsImU/OoFXdnugNnYeeqlqWKrfYxfdsWhfcU/Dg9+0ajctYI7FNVPS0XkAx2VXLXkwcYoehWrfqupGLY61bFaCues0hIuwQypQM3ug1YEhMHxVzkYqNV+plE7652duhkG1ghx/273VGopE/AMWX/DUjtvSmyZhSxOLc+AdIr4Pz+tKO6tKRy/j/d0ulBhxoeT5Umsc/k8rRzOmfefoGwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB8296.namprd11.prod.outlook.com (2603:10b6:a03:47a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Fri, 24 Jan
 2025 22:22:08 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 22:22:07 +0000
Date: Fri, 24 Jan 2025 16:22:04 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Alejandro Lucero <alucerop@amd.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 5/5] cxl: Kill enum cxl_decoder_mode
Message-ID: <6794128c4a9e_a117a29414@iweiny-mobl.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753637863.3849855.16067432468334597297.stgit@dwillia2-xfh.jf.intel.com>
 <67912e07cc2f3_1eafc2948c@iweiny-mobl.notmuch>
 <e5783dcb-1060-43ed-bb4b-04ad737adb58@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e5783dcb-1060-43ed-bb4b-04ad737adb58@intel.com>
X-ClientProxiedBy: MW4P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d60779-c8c1-4c46-9be5-08dd3cc589e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hsl2R/h9lZwd3CQoP+8DKafcPWdX3nml8INkH+dq8rUwVuI2iwy+19JTnCtM?=
 =?us-ascii?Q?7amXtTMXrl8w53ACO/f00ZhXMGMj4JNhHXK83luTbgvJk3AJe8JVyjjExFgD?=
 =?us-ascii?Q?V7uzEL2x7iBuQW7EQfW35Mdw+N62LlfgkBAAwzvDkfTtoKQalgEdcZfztcjP?=
 =?us-ascii?Q?D+jU1OPk+sN8a6cgW4ySdVstMjYbfL1u8FWWp2Uxz2GPz1db5I29gCQuKcM3?=
 =?us-ascii?Q?u6dqOVgN1isL+wxRzm4ELihFGcxV8nC9lPZjURrWvH4iaFPy8kZXTnIU9DLB?=
 =?us-ascii?Q?8/tqq6c/FTCzD5VBWtRnq2lS/S1nFcy8hP3bU7fNYHYyJFFwzyrJCjZYbwQh?=
 =?us-ascii?Q?gzNle4OSNYjZt3AM0fgLBeO1BlWzMSx+DHQJWi1W6CJVXcDzc+velCqjp5de?=
 =?us-ascii?Q?GRD77P+V9Kxf/4DEbQvGiLK1Ma4t5CwHkyDrjefLuWgDVhAtyeu+/oOESLn8?=
 =?us-ascii?Q?aP46o8RaKHgF0ZvPpOsxz9CUxBGhLChjm2PeC1/RrnSQ59zxGZQJle8So831?=
 =?us-ascii?Q?p+Ijm9ATowTDrWLaJWRYyHS+FhkIzfiiLQQWNoDkz3brf0s67DDfBl0PuLhA?=
 =?us-ascii?Q?frAAEQtZyjt7EMxN3EacTGjoev2+I+ZBuKTf0rMd+thAgj5b0l/Q42faGPg0?=
 =?us-ascii?Q?Ej8mxswVpOx4a1jzi0LLc/KZEALyY+IjOcQPvVM0V1uwUIledzQCUg6eLnkH?=
 =?us-ascii?Q?GHfEHJhSProa9YF9km9Krb0anvcK47AagfJP9r5c8AdiHFdp0vnEohQUzMtP?=
 =?us-ascii?Q?L3XrOm4eUns/JNx7U9GPHas3CLSe3B9/n/OWgU50WxTw0i9aNrGyS9OxZxI1?=
 =?us-ascii?Q?wpjAwj1JQTSJ/TH6m/wn2CBVue+u0YU1jxiXlov3gfI3AZ/TK+huJKDpenq4?=
 =?us-ascii?Q?QPbC1fJMlxWXUSTUFS+l0KDAneO+kKtLbyBFtwUmlP0ye4FsEJe2a12bOiiy?=
 =?us-ascii?Q?yWg/mPrXWBu+Iwqbj+3uuJ5+i56gYHwu+4aYzyfZ90R1A8pwxV/0lOyM//Bd?=
 =?us-ascii?Q?Ep2kJQsCAI30iDhNDatyUJZQrqQ63PDaiWq9TgNy4C1nN+tTQXzEnbS1H9F9?=
 =?us-ascii?Q?55xLtflPzkxSAljlUuqZ6nSUA9S38suEmPSNp+S5M1eY2pFHLgyJL3vL/arY?=
 =?us-ascii?Q?aEB9EiofJooYPfRsi3MRszCwMqCGvLS7aE1SzY62vAe2fvLpWbKfQ8ICpsRG?=
 =?us-ascii?Q?CRlTWtmyCbDr4/UhFI8wvPpf+e72U0ReAYIIGQDfWBCnpxuOUWj1/tz2AmAQ?=
 =?us-ascii?Q?STRMmWJ0jf2rUwV+BqD5PYUq7qpAOposMnrXk8qIxRaF2ynYLumhJ98vbn1i?=
 =?us-ascii?Q?sBdv2QQRoDstEi236csxiBGnOUQqL7MeqcRadgZk9LAF3F//LEAFo5MC8+V0?=
 =?us-ascii?Q?uqOZ5klbndv4mk0XP9jbaJz+8eg/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iGcFt5AMzKGGCOrjz3DNgtKTnt2KFfMGxrI4GnC/oXa9tA2eXHl/7EL/ojM8?=
 =?us-ascii?Q?ECXoK5RA5z22muyzgnwAuSc/W5apsIcBEd9HSwYs1GOiVAamIzHxBaZNMuNI?=
 =?us-ascii?Q?1BIsjSVG073jD4G1wTz+ZGmVT1yO4OhY88i5zRbqdqcF1fnFRlcFrECQsBV+?=
 =?us-ascii?Q?PURGcFmiRrr6f9a05qDHri5cuX7aT78SHqSd+ikBhF3E1ShwIHG9r7biqBNi?=
 =?us-ascii?Q?VWLSETId1ejLu3JderVBmqDh4EKS87CpBO6W9ZHo0Nh9soKVCMAgel6gN0Ts?=
 =?us-ascii?Q?5R34xlBXfOirEXXzLKUBEvgNEtwN4PAS6h1FqSFf9026VixD0PuGBUdKUYHm?=
 =?us-ascii?Q?TU77Jl4OVanAfwdbXTvw9fbLNDJEFBdNpgW2OC6X377fER1VvDZWzCf+Xge4?=
 =?us-ascii?Q?gJxwiYzxQ73+bJCT/C/QeeJUSj0/9Zaqs2fQ+n+uAbBMsti9rHMaSNBKN/8C?=
 =?us-ascii?Q?yUmCn+SUge2JVq1wMe/FHCny3cwTAXKItgMII8qcuyt4I1DsFNLz63/rfptk?=
 =?us-ascii?Q?SGfmwtZOGvaviozurhBDsBot4YtBc0/mr9hCno0BHOc51Pk7hz9ZePsTiEP0?=
 =?us-ascii?Q?I2cCdNNsFWKJPw3zecYdyZoDAff60MV3hhu56h3aPvdBporiBwegP1fmZfuB?=
 =?us-ascii?Q?Xb8HygKqx8V4XmHWuxXrQO2ti0xGfn4YoLBIWa9BvlXZ7/hzFf1kQ9QkbQqV?=
 =?us-ascii?Q?4lSbLXNcNyUJ3h6v85yWxR/6q1B03kjgp8bJBnAxSN9LN92DEUGNmpKKWG8X?=
 =?us-ascii?Q?GI+ZMev62iLLtIOfGQWld4Tb+M5Ca/xr270MjY60epPSYmEomh48wb0O0T/F?=
 =?us-ascii?Q?+pmzR9CAPYoFRMTlYJYHF460LB8uU9OdJU3NXEb/6E/y+7j7T/EQR9+ywAmC?=
 =?us-ascii?Q?d+4nqihD2IioRHmP+iUmRgTqdqBXfn1AcbpOt7sLBbYXsujjJw8EtJUyeOtr?=
 =?us-ascii?Q?c6ySJgRH5n5fP+wPNUoCtfAc5N6gLgmgMw2KwwmlYxzYtTl4mZfot0Urxtsu?=
 =?us-ascii?Q?TohmOH4VzhsLwsWf+avZ/dRqBkS3zE23ZBX9ziaO2YQQdcb4ttp28jJMCWfW?=
 =?us-ascii?Q?71L2/4XDSVQh3Ni8KNOHY0D6gWYeAQE/I8yLHdv/JsO9ZbC1muq4+PJzsRR7?=
 =?us-ascii?Q?XwS7RQxfx9Yh19bHL3epg5NKgjvivOPGTWlJATTIsBxmWKNJ6OSbEwdLb8eY?=
 =?us-ascii?Q?wQMna76mc1V+1jHVq8k4g8w2pQubk5O2tn+0ko7LPl41rXFObdJmpy/kud4h?=
 =?us-ascii?Q?bpKcv5A7WGk+/Cx96Cf4wUwbc1dFUX9q4PdlLQgf/TvWv+uc7wDMhYucqElV?=
 =?us-ascii?Q?S23YRNbmTB88d6GIjf+v3r8G2ChqtVxkfZF/jIH7ZVbcxU4Eex5M3a/1Paz6?=
 =?us-ascii?Q?lgdCoVINvEvKr+luZlv9qgFtP4KzSSFckZIe8vEJeUXCejzSfVHU2aih3Ee2?=
 =?us-ascii?Q?bHgY9BnM1wpONXqXwV5qJHDGC8ctVwwe5nTNKJ2NElP02r2PESS5Egh6A8Rv?=
 =?us-ascii?Q?7hpS27D3Cu9mYPxv2wEls4StkMxFqgiJVqg95UlmZOAlGPZ1+0W5qQqMZF/S?=
 =?us-ascii?Q?DQXUaLiqbOvJmRRD+A7UORVj07JY61S59QTlMLiF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d60779-c8c1-4c46-9be5-08dd3cc589e0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 22:22:07.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Y5DC5DNdN9RZ2lWVhtPF+xBvpy08mpsy6gj3xrXOrpl6+jeYJVsFTldAZyiZGsDTNIAQB9bCH4WJBlTp5z2pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8296
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 1/22/25 10:42 AM, Ira Weiny wrote:
> > Dan Williams wrote:
> >> Now that the operational mode of DPA capacity (ram vs pmem... etc) is
> >> tracked in the partition, and no code paths have dependencies on the
> >> mode implying the partition index, the ambiguous 'enum cxl_decoder_mode'
> >> can be cleaned up, specifically this ambiguity on whether the operation
> >> mode implied anything about the partition order.
> >>
> >> Endpoint decoders simply reference their assigned partition where the
> >> operational mode can be retrieved as partition mode.
> > 
> > You really seem to be defining a region mode not a partition mode.
> > 
> > I did a lot of work to resolve this for DCD interleave in the future.
> > This included the introduction of the DC region mode.  I __think__ that
> > what you have here will work fine.
> > 
> > However, from a user ABI standpoint I'm going to have to play games with
> > having the DCD partitions in a well defined sub-array such that the user
> 
> Are you talking about instead of having additional elements in the partition array, DCD will have it's own array?

Not it's own.  But a well known sub-array.

Dan does not like that though.  He wants the partitions to be anonymous to
the user and based only on their attributes.  So I'll defer to that and
let the next person deal with the fall out if anyone ever makes an actual
device.

Ira
