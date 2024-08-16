Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159331B3F16;
	Fri, 16 Aug 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817915; cv=fail; b=HWGKx6WKIas0oKvYtmexpt9Sc2XiZRFVDj18X+m8xoHYZTsyLtOiIgvM+Wqk6P5nHWLKjV09cTuLuH53ke84MUnUu9RmP1WY4TucsRnhZe9sZucp2HwL3vNFsXUcnjIP3kZRH5ByUKbEWGWO+FqdMwiisbWjjhtJ1o0QRKBFOoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817915; c=relaxed/simple;
	bh=wuLoJbBV+Mjm7tAenrdZmFtUQket07XlaqH+zQbRLII=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JwdGqT+ObLc7QKNxSeB//q8kpA2/FpWo7MhUwqnc5haqJRGmckW+KaA1LqX6Grg0f8izxSRR/SPjcJYUw5SUWU/8nDp/cF7Lspby7z1izVOaJuf3C06sLwyRJv4fg7iXIPqJKirSkbxpshrDNHVXeE7YYNrXYXTUB+lFXQAFkBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHUeB4i8; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHUeB4i8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817913; x=1755353913;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wuLoJbBV+Mjm7tAenrdZmFtUQket07XlaqH+zQbRLII=;
  b=KHUeB4i8p6n275ZztWp1tetT1xi6T3xsk+dF1dudLauyvfrWitBIP3ux
   0OU+SVZGcejmhxD5OCmQjWqtykjO+L4xEISLZ3SVyS/ybJuKckxe2p+Gj
   qJMWvmrhZk1MNY1nNDfOW4pshQvNXD/Ry/acAm3a846nUPg4oTIdHfixG
   E1DqcHwnmOwZGKvLCdgJBph+K8BLgl/v5RynXomw81bsLVDe8xDA+yB+2
   4Xa0qFkl86fAt9+Z/VX1IKfT2DLh8JsEjMQLAL+bZ1+mJbpOGqhWAJU3a
   UMLfFOKFiCNeDCJESw4PY78pg5vmB9WQjmj/4ak5hMribXOEZ4nrWXnwK
   Q==;
X-CSE-ConnectionGUID: G3gSaNKJRfG+j05WhmC9mw==
X-CSE-MsgGUID: mvKmf7TaSrmOpuCgChF+Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="39627626"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="39627626"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:18:32 -0700
X-CSE-ConnectionGUID: 9Ki8du0QTOeGHpnWoM+Ecw==
X-CSE-MsgGUID: xlDqvkn5RqWQmkYddkGzWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90416326"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 07:18:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 07:18:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 07:18:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 07:18:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwtPyuhf3Q/I1PT45vezzBISCbATVeSj/+m96VmvcTfiBdYhAjwOm1efuHecIb5lgffJk1FKtzjSLiWSZNuxo2qplRmrJIdDnP5v4cHqygGbB9T3LUEETrRor0n5/3Z2FRnsoKI7GtuiTVGVDMOmJ3YM+nibjUoLLxlndJj+DY6OnyJIm8oobVe7SmSY8lDnkbLBDzcKv/MPTbFAkGdancod2Vb8yOgs/TnxnP9Q/t0uxTbX7idn2m/vF3lofiSXsa7lU80dTfNYo4hMUQepW2xm7lrUHCTeZjHpOZz3r/iSdAo8XKogYmtgLXrEuHgyJTZi4TAshWgqCDhRHJziYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AHMTdFuCJpVgBg5dVGbNy8TRZW/gJM6zjXf5gc9cic=;
 b=iXGfsmwL4fYNRGXwUff1thmUtLPhEQ1+g2pY0F2B5iosnbzTfV1RitFy8qrIdzcgWYhQEgNIXzIVxVd5KMx/a29ngresBE2KshbT2eiukckx8hFmfAk8xL/9CyPmvo/ORQttCq2lKU7bp/4EE4dFhP5mAs53eV+NqGMG0Nc6U3q75Wt546C1r2L054zMVxY8Z9zlzGlJWOhliuhI3ghXBueU06dzEj9XW2k1KW//VNq7rB/0AHj7ZpnFCWxrxMciTucOrGx/KYwVmZyRFLPAfev8YVBcR3kpNz6IPgfW0mIymkVxacnGQiHEJQoOZwXc5rYv9EGDWjgkI0dDjBPZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB4805.namprd11.prod.outlook.com (2603:10b6:510:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 14:18:29 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 14:18:29 +0000
Date: Fri, 16 Aug 2024 09:18:24 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: Navneet Singh <navneet.singh@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 00/18] DCD: Add support for Dynamic Capacity
 Devices (DCD)
Message-ID: <66bf5fb0badab_2232852942@iweiny-mobl.notmuch>
References: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
X-ClientProxiedBy: MW3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:303:2b::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB4805:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9526cb-97fa-4058-0013-08dcbdfe4cf4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YmIvgu/9zV1L9GMyRujmGZxfrldKGtc4P+rTREJP3sU9CERHsXdwBV+Ql9W6?=
 =?us-ascii?Q?KY3muBzKoaIOmq+CrbB52KQJxAM+UWDy45Xq/NSQ7JvbtbaZKl1LMrWtUU2j?=
 =?us-ascii?Q?/w3EfOJ9661RxlnzmvPEcGOI620vJk/bZ6cAsLZ4hbqPhKnW21tKCTVwMEUx?=
 =?us-ascii?Q?cM7+DFeBki0ak82hNUJvxZiNMvthm2varzmCHmxJZbWBS/0lH5b0PX15EUWA?=
 =?us-ascii?Q?tFp0gQR04ZoddEthLxFmWqtyqHg+87b0p8Y83Xrc6SxjuAFuRZZ8pSFs0Rvy?=
 =?us-ascii?Q?qHQ7TbwrEdUFv6YkiiIjx75wVLc43p3qU8ZEqWZLM16bmIvEfmX7wxt86aKc?=
 =?us-ascii?Q?tinhmristxfkOUvMy2HeufkG5hnjGi+lHb62dZyI6wkm5ekOudvEg28y/oQD?=
 =?us-ascii?Q?FGXNetdgZXo6WUYlBWt/OIUVwJU208+uIsUhwY0saesQnY/rVtsF7hFmWtux?=
 =?us-ascii?Q?x0ZKDyzhaPMAoqnu9MH2ccA0CkmD+MAXmpfsf5HZT8nC99c+mK0RgS0OcueL?=
 =?us-ascii?Q?chcoP7jTZ9gKnO6EJEPw7XRO4/fMPVIoORQncxHG7gbRHIGueNEJBLT6Nz76?=
 =?us-ascii?Q?q6HBquXVEWw8J5gOs9Y8RtfF7wXYrMlf3U+xc5JF+Tf6ofut8YCgJ4woGsKp?=
 =?us-ascii?Q?1cLqKDX5Hdt3ViqM18sHOf46O6ybk2bVfMRtssjngmKDczWR41XtrRQ7Edso?=
 =?us-ascii?Q?Uu2FlPLE4PUDQmXPHUlcTbDvvVoSWzYpVx34coMEHJoEO3Jl1YRyL7/JIx6W?=
 =?us-ascii?Q?tLOo5Sa5ngQTJXUa27EFM055NCucfIqwDOpXG0G3fBV1+s+DantpJUfcJp6X?=
 =?us-ascii?Q?UplPzH8wv7wOz+ago/QLND6EPW3FQI1FXMua4KEtIsoFPP/RXAbeUo1UxE6x?=
 =?us-ascii?Q?3ZGzRcI3+MHHtcz8rrUEhhyV8b9z2wqcMQpXqWW5twRKQanD9axmcTQkCK3R?=
 =?us-ascii?Q?VGgYjKHCW2Yc9BN3pdHcvMvvVQOwYwAdLlBtpcR9spAcMOMiWaGatXbv7UAn?=
 =?us-ascii?Q?cAwmwbCXvfKkHGrbil4nG+JI/rq71nZIZF48MiX5w/XfmJjgg4jRaU1A25fQ?=
 =?us-ascii?Q?6OVOOuJCXhEiu5oubFKlmcRGQYeef5KrFJiSMIvK6ZTZ9//Pg3sT3mw6MR1w?=
 =?us-ascii?Q?a+fpHd0p8Hy7m4+yOqeWVoDGqVr7x4QcKvaoee8oD4KS0oZacurc5Rhfghn9?=
 =?us-ascii?Q?qfLM8CaSELe/jLz1JqfLlbQFNClzssbix5Ja0WPrLFOECVdenmI6jncPhmJz?=
 =?us-ascii?Q?JSJ7pWNpEzErx7j+vGzAXdA02mRYXpkipqyEhg8KMg4i8bqZ2EuWI+8/rj5i?=
 =?us-ascii?Q?WVmpCukiMgVX72YsgsjSG0nH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQdjYSE4kPr3HwglD8sInlsGN5g10W5ULLGfW1vXX9ci4na72iE1g2XU53cE?=
 =?us-ascii?Q?v21+BWNeI00lEPp1ySS3roFlrPbAvrEonR2Ppxunhw+DctDuaGFMn7/VsMev?=
 =?us-ascii?Q?O6S3zC3dOS7Hdz2LVwHdXa1NmU90R+CiR+9vSEXlW7/tqIIdH3MHemlXqOuK?=
 =?us-ascii?Q?qnUztRlLH+54YUBtaJL1yU6hkavyJKZR+JBzLX5RsBcXo+MZpDtLO5K5l0OE?=
 =?us-ascii?Q?7TwYt5XXT5TyqX0OEzYgImwvf3MMhLfrtPn8dIirrgxmxgnc5cC0sZgEYwk0?=
 =?us-ascii?Q?TXAQtq9Qdc+AgDsDLz7c7kVlaTYagS0Se7EyBlM0b/4Upv3vHzMtOggGf7py?=
 =?us-ascii?Q?cUYKCwqTpwz7fEO/LqDrR06D5+tl0l9xzyp9KeJDFdwBqUpfY5hsoMySkFJs?=
 =?us-ascii?Q?OUAYqR1r17wB0gpVrPc+/JugniZo5s5A2bVJrxYPcJQEyHMZsZslkH6bNc9U?=
 =?us-ascii?Q?/zVRv8RDuF36eVX4x6Ar/QHzwunTvl4VOS/mV7cQEeoKRLNCfcA04407HRyn?=
 =?us-ascii?Q?UYxnIElUT5tTA0aQx1BZelDMQY4VV8oRcJSvtJtbhfRvVfQIuUKA4JckCMJc?=
 =?us-ascii?Q?wnvov180u9vLQahrYnIgZam3PRYKOvXU2EUi22JMJzEFD+yqhb4VS+nV36c1?=
 =?us-ascii?Q?bVqQ5bqQDiVWQYSQSKiMQ9v6k13NfwHFmDURsV77rlLVf4qzIX1GldEDf4MT?=
 =?us-ascii?Q?Xr4E8L8ez69zObs2V9JWbxaXQ0xfQZnohAZzSox3P0PVq1qVcDpNmORhxMiO?=
 =?us-ascii?Q?66O3OrropdfPAYlX64Og6GVnGZeCXtsL8rnCGaydyrTY9VoPsrOHL7JWB0ZG?=
 =?us-ascii?Q?6g1/YrXSSqEhtsld/bUtj6D2TtWQQ60a6et7mEI8NBzW3xjqQcoGsPfk2mu/?=
 =?us-ascii?Q?6MVCBf7h+PdbKxtKcKUF35zjd8du3d2puPq1sPgk4rAHjMrYdf9FgrLXI4lT?=
 =?us-ascii?Q?aRKcgTPdmn7a12dYO1v/vGWkM4KmBUTk4iGRz8xpyXxGzz3TX3KUX23MdVjo?=
 =?us-ascii?Q?4gHUkc0kwAU+M5WeqexCTGPRmqwUPiMhCc5J4pO1y+tOz8rR+k72Gon1nWFD?=
 =?us-ascii?Q?cxw9lHLxpMdzDJF90x+riKXvE5M1MvlXSXVR6+bMjyW0MLybuPZCpHbGJySh?=
 =?us-ascii?Q?5EeXNvFuE43KR0eXZaZakHDzjGY9Ab8OTeJ1x1RkOFsRiQK/98CnUlKcEqfD?=
 =?us-ascii?Q?cUrfyBGIrc/zepioZmo4/x/VdH1Y7M1l1PW9Iu/sr7NTlJNsfzQ5up7+2ufy?=
 =?us-ascii?Q?/LbFPwJrdPHd4vLytgAZ40X6WYH3PIX7BYHaa1OGNod7PP9xiE/7p+rRHFzG?=
 =?us-ascii?Q?80GkhYvKTDwgnLIDWBdIYHFNcqbxxOdJt/6I8DEpVFtEJaujYPDQi6+WoOWy?=
 =?us-ascii?Q?VDVJm4RXrRG55pJj8lirswPB+dr+xQYBNYRqx/tXn66afftcTC51OEGDoNuK?=
 =?us-ascii?Q?OccwdaiusCfUnhmF5sox6PzxG3V65S7tka0fvNslP38cIXpF6BZvUIwIszkZ?=
 =?us-ascii?Q?HjO9XJcv4k0PLF59YuBzBXGHo37coTo2JHRlaIx8fdzJPJEvrb3RbT33+zY2?=
 =?us-ascii?Q?ugC/ph6hRhSIRlRFLoXNyn6gj3LFt6h/fMtAJU1v?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9526cb-97fa-4058-0013-08dcbdfe4cf4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 14:18:29.1852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPZs3Hi8etFUCIkW8gRRGWMGYzJ29eKClQLLnR0rpCmEURoZT9Rju9P+FdFZbzBx7YXCkD4G1/qv8QtxujvsUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4805
X-OriginatorOrg: intel.com

Please ignore this RESEND.  It is a very old version and sent by mistake.

Ira


Ira Weiny wrote:
> A Dynamic Capacity Device (DCD) (CXL 3.0 spec 9.13.3) is a CXL memory
> device that implements dynamic capacity.  Dynamic capacity feature
> allows memory capacity to change dynamically, without the need for
> resetting the device.
> 
> Even though this is marked v2 by b4, this is effectively a whole new
> series for DCD support.  Quite a bit of the core support was completed
> by Navneet in [4].  However, the architecture through the CXL region,
> DAX region, and DAX Device layers is completely different.  Particular
> attention was paid to:
> 
> 	1) managing skip resources in the hardware device
> 	2) ensuring the host OS only sent a release memory mailbox
> 	   response when all DAX devices are done using an extent
> 	3) allowing dax devices to span extents
> 	4) allowing dax devices to use parts of extents
> 
> I could say all of the review comments from v1 are addressed but frankly
> the series has changed so much that I can't guarantee anything.
> 
> The series continues to be based on the type-2 work posted from Dan.[2]
> However, my branch with that work is a bit dated.  Therefore I have
> posted this series on github here.[5]
> 
> Testing was sped up with cxl-test and ndctl dcd support.  A preview of
> that work is on github.[6]  In addition Fan Ni's Qemu DCD series was
> used part of the time.[3]
> 
> The major parts of this series are:
> 
> - Get the dynamic capacity (DC) region information from cxl device
> - Configure device DC regions reported by hardware
> - Enhance CXL and DAX regions for DC
> 	a. maintain separation between the hardware extents and the CXL
> 	   region extents to provide for the addition of interleaving in
> 	   the future.
> - Get and maintain the hardware extent lists for each device via an
>   initial extent list and DC event records
>         a. Add capacity Events
> 	b. Add capacity response
> 	b. Release capacity events
> 	d. Release capacity response
> - Notify region layers of extent changes
> - Allow for DAX devices to be created on extents which are surfaced
> - Maintain references on extents which are in use
> 	a. Send Release capacity Response only when DAX devices are not
> 	   using memory
> - Allow DAX region extent labels to change to allow for flexibility in
>   DAX device creation in the future (further enhancements are required
>   to ndctl for this)
> - Trace Dynamic Capacity events
> - Add cxl-test infrastructure to allow for faster unit testing
> 
> To: Dan Williams <dan.j.williams@intel.com>
> Cc: Navneet Singh <navneet.singh@intel.com>
> Cc: Fan Ni <fan.ni@samsung.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> [1] https://lore.kernel.org/all/64326437c1496_934b2949f@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> [2] https://lore.kernel.org/all/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/
> [3] https://lore.kernel.org/all/6483946e8152f_f1132294a2@iweiny-mobl.notmuch/
> [4] https://lore.kernel.org/r/20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com
> [5] https://github.com/weiny2/linux-kernel/commits/dcd-v2-2023-08-28
> [6] https://github.com/weiny2/ndctl/tree/dcd-region2
> 
> ---
> Changes in v2:
> - iweiny: Complete rework of the entire series
> - Link to v1: https://lore.kernel.org/r/20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com
> 
> ---
> Ira Weiny (15):
>       cxl/hdm: Debug, use decoder name function
>       cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
>       cxl/region: Add Dynamic Capacity decoder and region modes
>       cxl/port: Add Dynamic Capacity mode support to endpoint decoders
>       cxl/port: Add Dynamic Capacity size support to endpoint decoders
>       cxl/region: Add Dynamic Capacity CXL region support
>       cxl/mem: Read extents on memory device discovery
>       cxl/mem: Handle DCD add and release capacity events.
>       cxl/region: Expose DC extents on region driver load
>       cxl/region: Notify regions of DC changes
>       dax/bus: Factor out dev dax resize logic
>       dax/region: Support DAX device creation on dynamic DAX regions
>       tools/testing/cxl: Make event logs dynamic
>       tools/testing/cxl: Add DC Regions to mock mem data
>       tools/testing/cxl: Add Dynamic Capacity events
> 
> Navneet Singh (3):
>       cxl/mem: Read Dynamic capacity configuration from the device
>       cxl/mem: Expose device dynamic capacity configuration
>       cxl/mem: Trace Dynamic capacity Event Record
> 
>  Documentation/ABI/testing/sysfs-bus-cxl |  56 ++-
>  drivers/cxl/core/core.h                 |   1 +
>  drivers/cxl/core/hdm.c                  | 215 ++++++++-
>  drivers/cxl/core/mbox.c                 | 646 +++++++++++++++++++++++++-
>  drivers/cxl/core/memdev.c               |  77 ++++
>  drivers/cxl/core/port.c                 |  19 +
>  drivers/cxl/core/region.c               | 418 +++++++++++++++--
>  drivers/cxl/core/trace.h                |  65 +++
>  drivers/cxl/cxl.h                       |  99 +++-
>  drivers/cxl/cxlmem.h                    | 138 +++++-
>  drivers/cxl/mem.c                       |  50 ++
>  drivers/cxl/pci.c                       |   8 +
>  drivers/dax/Makefile                    |   1 +
>  drivers/dax/bus.c                       | 263 ++++++++---
>  drivers/dax/bus.h                       |   1 +
>  drivers/dax/cxl.c                       | 213 ++++++++-
>  drivers/dax/dax-private.h               |  61 +++
>  drivers/dax/extent.c                    | 133 ++++++
>  tools/testing/cxl/test/mem.c            | 782 +++++++++++++++++++++++++++-----
>  19 files changed, 3005 insertions(+), 241 deletions(-)
> ---
> base-commit: c76cce37fb6f3796e8e146677ba98d3cca30a488
> change-id: 20230604-dcd-type2-upstream-0cd15f6216fd
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>
> 


