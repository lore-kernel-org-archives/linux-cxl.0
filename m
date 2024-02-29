Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486ED2CCA0
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 00:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167477; cv=fail; b=fGYZfiUobFDdL9cKpozMlL2LWjue8FdNoT0gPG/Coi724kRc/LmaAfyWnutg6kycQgsQRGpMYuyhd1HezxOZj8fFZz+g1Yl048O7O9XFena4J/RSv4/gk4S65TYa1l/INdB1hXXKuqwStefMkXwIxkbRqjglAEc8Cxv6X/f91/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167477; c=relaxed/simple;
	bh=y5ywLtuVz+pbnKVHjKS1njtqq4mq+suscSadowNOoOI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=buq3JGcAAO8eloCL9+3cCqJQioA+ULKk4hDqmFKbzuSiSbmDSPgRQr/zLmtNcnHbVRe90am51toG8xXrRezxzAt4ZYbB3D4PkUfrp36s8A7KzHotMh+3c4Z8GMA2F+wZCp8nBU/AoRnN1xM4va8/9JxGYn1GsRXF0gtxAhwL8mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+dE49FT; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+dE49FT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709167476; x=1740703476;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y5ywLtuVz+pbnKVHjKS1njtqq4mq+suscSadowNOoOI=;
  b=i+dE49FTcKiiNm/qd/iVk7S9vlRp2QLTDdZenjBeL2uG+Gz2wnL7HfYD
   uLZTKhAehhIEPLLpsrggnA2CuAtza8V2rA8kaix7HXAHGZbawJgyqL1iM
   ipG5Tpo87YlzW6biuUhycJRKQkcdEiIEoPzefk+FOwGQO36jfOEk4rMgp
   XQMNirH2dz8b2FyG1J/MvsoikQk/eZRU8XZyBRQpG4yI1arlmaPpCdHpd
   j6UJYzlJtuhdZ45iFHF8Z6q5xnNPWWfnq2vTc7ZhmCvqEuw7Kh+ZjfuqF
   Yi2AllzalSk67ZKDz/+in4bFEanmvtojjsrlr7uuRIhbo3o53TveQOsHP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3472510"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3472510"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:44:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7563375"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 16:44:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 16:44:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 16:44:35 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 16:44:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdJ2k6smiSrKm6bsOzRtTqiJyhQCFAW8BIDa8TinCK5Y0AT0v80V/R/nJL2dKQZgwAw+miLoIN8m1/nOXwsZwL/2ZbGV/sccfvUMoK2UeWY43Ks9ohExp8OQ16V0NIxeiekF2NBSv73eOxDePVDtx+9IOg0bLYsxBkYe1PhAz6Lyr8dY2Wyt4Rk0PZGTjhHBYa9IBr4p4UmWydCqoVj1pkIh5aoxazCt6DrwdYtJxps4/AfzzwvNEA8zbggAQNTmTf4QSOND6d5PX4jUSmKSxVz4TEHBUmk87AJerANJvTvz4H4/2PqXvORGqg+7da5PwDFRIspOEAVG3I43hMb2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qEW4fUIrS/kACcWJogN4YjKTEDu94bgzew8MznArB8=;
 b=hzfhtgjIWVFyfMQtSiakwTR6WTv3ls5GqgOzC1kByo0aUQjgWAZAuKlfDB8SAIJyPep2OE5TaxG6jZtaCFKSXp2xXRQ1nqMvOIk+MgD8jLAlD+/noIxMtSJjGs0+5fv336MiAzAW/Uo68UA0zEASLR1LBhqC3FvSZFakzsA0rf+XsoJGfzBzXaDYh9TDa6WWeJ9pAa+15cm55G49mHar4+kmrt0RrkaxYwvKBpW5T72efBuDK8gfV3k87wH3lwcI7xrIwM7DMjHgGBHqJMyOOPDn/Y+EC3n/Lm3ZZQBFjrxBIOMVvXa90xZJ9C8ZG/UtEv1hsneZFDMNGAbM79t2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6229.namprd11.prod.outlook.com (2603:10b6:208:3c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12; Thu, 29 Feb
 2024 00:44:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Thu, 29 Feb 2024
 00:44:31 +0000
Date: Wed, 28 Feb 2024 16:44:29 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>
Subject: Re: [PATCH 2/2] cxl: Add checks to access_coordinate calculation to
 fail missing data
Message-ID: <65dfd36d990b6_1138c729463@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240229002542.634982-1-dave.jiang@intel.com>
 <20240229002542.634982-2-dave.jiang@intel.com>
 <65dfd137a1406_1138c7294dd@dwillia2-xfh.jf.intel.com.notmuch>
 <9a20ce22-5910-418e-b13a-2312880e2400@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9a20ce22-5910-418e-b13a-2312880e2400@intel.com>
X-ClientProxiedBy: MW4PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:303:8f::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 55be0625-cbec-407b-9857-08dc38bf97dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHidp360mjsGtYTWGw/rZ8aHXpub3RfX7i4mIJJCOQCrLiV2206p6PRAl54zzJgtrhhRKAj/rs5Qh/UBA6PjjgzxQLthRlWb9m30SRp+fZjXKxmrS8z6T0SSo4kSJamR4ktFBdNew1CJAQm7addE0OWmvQeme+FFKuwEcIhDJ9DiRrNIP8DtzzH7KfJqt2ul1QrXGn2w0FMvr10Vlrm9AJ6vTMBgyB0+g6M2OVIl9BEgD/rig5UQL7coSlPQltv0x73GhJzZmGYI3q9tvgx0fCC08Be5viHDpKI21SOCW+p6516YtUJweHoV8fyNw+qnwOIfMEr7NvNmsf2Q3W/77Si/JwKuz1CGKFykbk2SRwKuZ2IPXTK7wWL87Wwk3YMnoBrkU1vm634SLDWWwxBpN4PAjnvQ0XWABD8OICz7bkCEFWCeILizdDjqLxwm7mX5CrdCCmCpVTgFgdhMYs6x9FtxxlNr0w3NFtvoqrqOQpyRWbRHni50Hlup/r4hZc/7bZxSU7H7l0vd9G46U4q4F5CTuUCFk2Ibi1HmlQS59XxeGgeVnFzwgkksbTIOqnvC9cjaJr8VLB4uIPn6ux7ZD9vJPQp0ooMpHctcSKCkCIGsYxClKfy0DiLOPtklamRXFNSFklaKEg7CpIXfgtJ4iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nZhxJgemCYLcWnFa4ZwV3AMj1wXZLnPMTq8cRvRV+Ed9vp3TRw4VRtVdPx8q?=
 =?us-ascii?Q?orab0B5C6oxCJ4Qb0QuwcPlI6SQxLgXmBJ6C7ZF1kOw+w3Ey+stc5LAru4Dy?=
 =?us-ascii?Q?3jwmhghBQTJwSDFUdjwKgSVQLHjinGhu/PCXZ5Pe7qhnSOC1WGH+xF459S9u?=
 =?us-ascii?Q?aEPtwbcKAEi4gKfEpAKMmddRwGf7VE+t72s15qpAbHenAaiA49/SC6xjdwEM?=
 =?us-ascii?Q?aDsxstMsb0UWWdN4NhupMpX5T3Zmv1m46dMMv6lnKIYPSAyGTuEV3CTlKSjo?=
 =?us-ascii?Q?Qxp4mwWOcevclZhbA5NgiBSq11JnJ6HJDdLYATQQxLaKIH4+ApEDjot+PKFN?=
 =?us-ascii?Q?ZDW2mtLl96ZAEOeoCnfehyWMHidf+bv+2aevCk0ypC/mUi51YeY5nU4C/cci?=
 =?us-ascii?Q?3i5yrKWp2Ay82a5/px61kYMDwrN0OdB6fqXJFlvkOYrX3DlWaaVU/uyUtocu?=
 =?us-ascii?Q?ZXHsUgHKNva57CA3Jv0lStSDEqhNdPCacrqXHIF+fNmaSPUBfMDSkZdD/voP?=
 =?us-ascii?Q?JjXoznng2zQ2N0yZWJ4aEvKboAnCKDRCPnqb7ZJKMxGH+wce/yE1RJfOdXU8?=
 =?us-ascii?Q?/VU3tP11rvGRjKpOE91rqlKKWt7fW+ylvg7oiZG/rU2xufssRa4rkBuyA9kL?=
 =?us-ascii?Q?y+Nzsfmhv8XmDAphMfvvPbYFMdfj2DQW0Hp4uNpvWqaGri57xDRR6h9dq3xG?=
 =?us-ascii?Q?0mraLulDOaMNbyPCut4eNj+1toJwM9jwcaG0j0BgJyqz9lvmSQeZliInul0s?=
 =?us-ascii?Q?LLbzhBFFIMaSr9fXhwvA2cQpBFMvbu6W8CvFVE7cv+wp35yBa4fGaa+qFEc3?=
 =?us-ascii?Q?ekt5mkOn2gx0kfB6lkp+HGFOATiy6i/AFuTIRqlzOmyWWY9ouuT8jTRiS94+?=
 =?us-ascii?Q?kv86ATUJV2P9OlmLUCn/zd3hPRkmUNTj6cHWfQ1Nt3l7U0+U1t/Dkum0roMo?=
 =?us-ascii?Q?MWMpHwfgKbEuOwwjz0hvuyjQ2xyeP5yrVbV3QGK46/yOnReKwQAASrkGBgvK?=
 =?us-ascii?Q?0zvNG1InvS6U03+tOXGpz8ceShP+7tL0iygxtfo2P9qtlEiJv0Ghz4ngtaR7?=
 =?us-ascii?Q?2rnArXu9o8RFbRGO7V9RweFEtGPLBs1dbbqysmaeSuSdTObxsr5OjBLX0mgF?=
 =?us-ascii?Q?D7s0pgBn1v3QOPAilnN6X4EgUe/HC8+Qkla2wLw4w40stWOF8iM4n+epVzEH?=
 =?us-ascii?Q?dmpTyRggOOG2CYmylhBJPrTHWwCVtyhZtMCxwO7AweOSsxXnjTCkOzJvFZHy?=
 =?us-ascii?Q?3/SgAtFW5hpuT1OMYPUwZ0tyNcJZgxaiFVh/p724Hzhup9cPmbb5XMyIy8Ge?=
 =?us-ascii?Q?Z6DVskPnU5PAVtqaRfXIEVJMqRwDudPLyRylhR2beOfZXdj9bOqIo22MfTwF?=
 =?us-ascii?Q?dE6EfXmSp9nXTyS7DC/LDIdm9uV/xGjOrYl5x3Mgvyhn/HQVPUi7TS7g8m3N?=
 =?us-ascii?Q?LJLOBp8x6aDETYSsPLyY+TS/VYnTIxhNM4wd09gY54ReGYBJGHTpINleH4xV?=
 =?us-ascii?Q?lfmt2qnVxqX4iOOY9dZJNK1JGofh0Jijlq/uLF1FCJT+Rga5yuFQBE5y7JID?=
 =?us-ascii?Q?qfp8cMAPTuhdhzxf6qXA8qKX0ig2JpaQ9AWgelCh0o800iMhC0JCYchR7Of+?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55be0625-cbec-407b-9857-08dc38bf97dd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 00:44:31.8744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mtzf4iv1ku8LGCqOslXXyi62tOuGr1sey7tvPzuQOmAVaLSPqGHD2+9m5/XOKnuiJER3s+vCf7ipwSxeyp3Txxk74LwJIy9A/bE/TPLS3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6229
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 2/28/24 5:35 PM, Dan Williams wrote:
> > Dave Jiang wrote:
> >> Jonathan noted that when the coordinates for host bridge and switches
> >> can be 0s if no actual data are retrieved and the calculation continues.
> >> The resulting number would be inaccurate. Add checks to ensure that the
> >> calculation would complete only if the numbers are valid.
> > 
> > Similar comment as patch1. This smells like a fix, is this an urgent
> > thing to get into v6.8, i.e. most configurations are busted without
> > this, or is a nice to have fixup for a QEMU effect that may or may not
> > show up in physical systems?
> 
> This would only be an issue if the switches do not supply a proper
> CDAT and/or if BIOS does not provide proper ACPI tables. I think it is
> only experienced on QEMU currently. I'll add a fix tag if you think it
> should be a fix.

No, but please add that relevant clarification of impact to the
changelog. It would have made it clear this is a nice to have thing for
v6.9, nothing to worry about for v6.8.
