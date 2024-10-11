Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129F2576F
	for <linux-cxl@vger.kernel.org>; Fri, 11 Oct 2024 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657368; cv=fail; b=OyRqhgHpDltyRey+qmMYiPgVRqHYAgFAkFk+J94S1RQy10gpFXsn4PZRif0sH8QJxGOKtOb/fIviJhTNC8v+ZtsG065+E8e5o0cgeOvFcB9229sfx9tusNIxWDE/7pk7i463o8Rt8CnUjXvRgEi68sMK/Kad20/91GB8RtBtPcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657368; c=relaxed/simple;
	bh=6LmIVPKD9LXFwjJMtvK/Vp+7Q0Kuk7PFVkSiUwxY4uw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bInE4nGKjdFFxiSu9/yUxvZKDVbiECYKx0WavcP7inmhjO4q1XamXDmOmmzmaa9JDvbTkEXWTexHFMY71QW2c3fLX3JDkgq/YbRFPKjXJ5jn38T4hQ59J+crxuKqUbnhB61hhzLyhUaa8Jcz0rqGxRaZon0tGormI49OLqWlLec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fGNVGn0I; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fGNVGn0I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728657367; x=1760193367;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6LmIVPKD9LXFwjJMtvK/Vp+7Q0Kuk7PFVkSiUwxY4uw=;
  b=fGNVGn0IWyJ/x+jXseq1ef1iGjzeqNuiXy8gX6pEJgawAsQgWrhXhIzF
   RFqsY0HGjBok7WsncrEO5IVYOfJqAR52jO6SHZObfMWUnOWHdaFFQ1lJc
   pjkb/dnqlThlS7+13X9J4PmH/7hmlmS5jmz2DAm5j63upASuuQ0J1OVnD
   0pPneVf0xJemOW4fLcd7vnGkmsIb11ulgS++GnrjRN3HNpZpthkqQW502
   Zjjo5e46nCp6q/EJhNrYGg5ER+coyIxb1+Q9hGH3qtwBttrbynvMbIXHl
   6APwcNueRoFCsclFYV8QeM2Scp5CyWnKVIc9nzZoE4YrWOSG77zHSMRuh
   g==;
X-CSE-ConnectionGUID: JVi8EW0jTcyNvWTRMrQFww==
X-CSE-MsgGUID: PsN5ZymnQwqmXrFutGzTlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28149404"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="28149404"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 07:36:06 -0700
X-CSE-ConnectionGUID: enxq8z8iTXGcHnmpwTC4Ag==
X-CSE-MsgGUID: S40pb4gOSFK8tdAsSD13+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="114391954"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 07:36:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 07:36:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 07:36:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 07:36:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 07:36:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sayGbFY8MudhbZN/U2KmITuyxApVo/ynDIiCj38GJJHryq9JACS0WNP8mOguKFCTE1Z3cS3b/yzUFucq1EZlH4ZTf/4vL9bcK9gh4hcAAxBnyXWVUx95oostVon18u+T3FsY6r6ZSg/IC3xg67eaN75clO0EEJAKPimZmgkzc8JOPa/CahxK40FYJcxGxv4WDBT3x+CI1+gYuSX+6eSGjNFyM6+iPhxi2F+yVk9549j7ElUMeu42/ZU5RJ+/XRtP2xigobiAg2FjUrd1UG0/G4PcIP3JkGmoQZefLH6Tj0GBAwJg7dlwpLf/LLLoNKYNctuMWVEHmnspkjRdx74B9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yWVoHi4IlNKG8Uyf+JoEeu4QjnCE8riYVI3iMb0ZXA=;
 b=yppl7EpGZYHu5NwLI4USLsLIF3dHKtJ+KtBzeRgVu0Ure5OT17vYVo1db4eSDkuAW9bw6MgOqSUhtjrmxSP2cDwGbC7guZFOKCSbbnxuLHIqXgH0tR4ucz8gYQCW+qSLZ8JPCbkYYxwDN1sG/46yEDzmVvwDZEBnR5+8rwFoDi7qt1Evs9y8CxTTwiCM9k9Gt4ZeD458nC3JM1DEvYw5QbbGaN9no4oO3xyagFVr01uu12gXEbC7b/xAJAf3YbCvaU8Zhjttab+ix9jHNkp5bGY+2US33Rs3e6yAy4jYYNLGIWzeDoOi36mtJNIA9FJrWINO0Bv7wy/zOyIRdzG/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6846.namprd11.prod.outlook.com (2603:10b6:806:2b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 14:36:03 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 14:36:02 +0000
Date: Fri, 11 Oct 2024 09:35:58 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<will@kernel.org>, <mark.rutland@arm.com>
CC: <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>, <fan.ni@samsung.com>,
	<a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <dave@stgolabs.net>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3] perf/cxlpmu: Support missing events in 3.1 spec
Message-ID: <670937ce7b7fd_9533f294b2@iweiny-mobl.notmuch>
References: <20241010025208.180458-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010025208.180458-1-dave@stgolabs.net>
X-ClientProxiedBy: MW4PR04CA0382.namprd04.prod.outlook.com
 (2603:10b6:303:81::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb4a991-972e-475a-5dbd-08dcea020833
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lGITnZVzRRtvusgQCDRJxpahMzsNbZtWVRcJzr19B+l3Zrs97RiIdjgDzJSt?=
 =?us-ascii?Q?RewaRj7rgV88wQgPrXZw3Hz8Ir8m23roD8tgai6v6YM1mJtTNjPRuxltSHSb?=
 =?us-ascii?Q?bJgqwmqSpCUpVXxLhEmztCbBzrWyavZ7DsEjcD34sUyLyE7qFDgGWwqQLNYY?=
 =?us-ascii?Q?HlHlj+XBKvCXHuzXZJxZR2ImO6MY4Guw9frDJ1+YlX+9E5MvsEsOFkHfHsNR?=
 =?us-ascii?Q?LCdkf6kP1WHri37z0GNQPBn/dUoqbWlDVKllWCHQD5NVp72K/RR3QdKogS6z?=
 =?us-ascii?Q?4AXs0xtcPWlbTpfi319aam5nUq2Iczr6WI+kd3Ym3ZmDe6kmJjpGS7y3ygSN?=
 =?us-ascii?Q?3YHpT5ooo+Hzug7xs+jFR17r8IHX4GVfvjTnjV7XkxWu937tx2TLD3R3is65?=
 =?us-ascii?Q?2SBpefs5oCI2kO6wyEqrinQQ9Rt1hE53PSlPyU9wnyXam+RiaZqxuzf9bsqF?=
 =?us-ascii?Q?busAbV3Vzgnw/RLGuT/1mATeqzAW3KnMYwuKDbW2bJ4kXKqKusU4Udo83h3H?=
 =?us-ascii?Q?EO8VNRjBBuhPGaOqpQ74nn4PsHgfpwGYzfevNE6M/RVdZ8nO5rJYVbEiO00w?=
 =?us-ascii?Q?qtYQyR4NmG97SEaahffo0Lj/7OwQBXqAjngP0jhz0y8bfBZL5fH3cFOLdy+n?=
 =?us-ascii?Q?IuvAvCxqL5tSO8EOrHoczqKwuJUZlj8kqYaLkvNZT+MfYkDey08Bfu1sOphN?=
 =?us-ascii?Q?uLKnQYOs+R7aWqhWZgLlXGBv9kvDM9SO1oY9RWuljO7xGMlxcnPBS/MV/naF?=
 =?us-ascii?Q?cRvqelJ1ikSyBYFwLEqseJA/oLRWXXAtRzgC+mjW0naQcwEsn6UuNERC8JFQ?=
 =?us-ascii?Q?R4ah69Y8Sx3yLvuFJvKRVvNrrpO6nJfhjvPW9bx1uaZkZdPNNz6KYm/LYksJ?=
 =?us-ascii?Q?0/c0F9CiWPmALzbTKI8Hy3ETJDCg++dIwt+iufeTXFFoUNp7yfBOPafrdhtd?=
 =?us-ascii?Q?1py5pcXHDcI8rOGxEDOGGAYwHesH77annitpaVkN0aSXsIJO886JSS4cOLxz?=
 =?us-ascii?Q?C9l+jtHQ++3tJpZidyBLjjnvB9e7nAm6xjb+9XiaiKzMnl+Gf1tAzN6hJoQQ?=
 =?us-ascii?Q?HzCuUmdF4g+e00wQpKXDSE8k6RJBToaTJiKsXcr2Ox8l720wK63qEhLpZcKJ?=
 =?us-ascii?Q?KmwtiDFstC7xLGuTICl5Fa7MWLOrexEWSPpPFEmpcXZqhn6GmkSbmZ0v3hEw?=
 =?us-ascii?Q?pqFabltuu/lwVnTvBrVSiVzaS5fkxOMFOCewjpShSCsiyf5FDYWP2V6wUTvn?=
 =?us-ascii?Q?ferAvEDDEBH7dH+eH82ju75PtLUc9ztR6xO0ziJMWg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J0DWG69alFRzWdTOR0BymTfQXNXkscP/UdXly20eP4lXZu7XdSgeoot4jtyr?=
 =?us-ascii?Q?fvwoxHEGzbq01u2AqeBdCjqoR8DIea0LxdTey+GVpPTAl04m+fhpMM+7SHEp?=
 =?us-ascii?Q?Oq0R/iiHavZHlRuBmZxhhWXBwTf995N2dTdhAS7ZH9dDELBsgKyUHGdfC7kj?=
 =?us-ascii?Q?XMBqVyMv7Tz54YJlickKxkJc4xnkRZEDBNq5g/dj6Zpjir0AozVgN8Urqm1O?=
 =?us-ascii?Q?nmwJuBQDZ/PdyBiZtC06/DrSMGky6SQvPt6S0yrVtw6nZucodELbwoG84npl?=
 =?us-ascii?Q?pfG1C8aDpyF8Gi6clZzMFdE+SYN4huQAFWisTJQBGwASPgihJoU6HbRocon/?=
 =?us-ascii?Q?gF4QD7TCZ+7fM4GuQGF1j4kaaXad4v1T7xCU90wFbobULKTaF7RTb7p1FfJk?=
 =?us-ascii?Q?ilP6xtA9C4Nf0HDx/Roex8Ron5tS7a0R7Nt8AeaHy32qPr/kKWktBlWotdOV?=
 =?us-ascii?Q?FqKim/c0vytRv922fLp75zBZdyv5zJgcKPuuFLIUeFMURQn10SfLP7KEQ/3X?=
 =?us-ascii?Q?ucYdnSdpgTqTIdmB+TtRIk0Y9CUxTdG1f6UUoiKa9p+ldXevRB9yXceOD8Hz?=
 =?us-ascii?Q?pzrlCYRRt2hyKCT+iFyslfdm8R4+zL61HfRpcHeQYYziUPsQWZZDMDLIKU+R?=
 =?us-ascii?Q?RMePGHQ1SfIYFbT9+S/BE3t1utgUfz7nW0/TppeA+13yyBxSDAmciuZrIw1Y?=
 =?us-ascii?Q?7Ct6I4pC+kVFlHBqABcAkSs0GZyuXheWckbRGWIipGsAU/cJH/sXkhplzwZ5?=
 =?us-ascii?Q?U93iNU8Eyp+U2rSOS9yEv6bYgRHIQwYcPXYbc021k52BDBMcNRABC0s0efm5?=
 =?us-ascii?Q?L83KzD8SrqYPTyC8BexMpy1UvVSoVF48StNMKZFgmgZ5tMbEfZerc+9xFxPb?=
 =?us-ascii?Q?X17P6bSktXeo04CMTnbTwfLHFZ83O/Vrbn6UpCNWQJdjqvNP+RIxbu6z6Gdq?=
 =?us-ascii?Q?4YAvmYd1uvsqVDFgaDH0BEv+16dFYyVPtqBohDFPk550rgiG8VaInDrQjXVP?=
 =?us-ascii?Q?WgyW30BN2Z4qAoQHSi8UMxFrzLTZb8Tbe8QDJpIYvhDSzeEYamxEWqHc7SZv?=
 =?us-ascii?Q?QF0pWYA9kg5nopSYIDwRCikF3i4WPaGfznBL04AV4HjCD5YC5CkcNMUj2/jC?=
 =?us-ascii?Q?Jo3mEQ90YTXrgwK8h8CzJ1EINsxH5q+Tkz3WF/7Z56DMkJQ2ID4Ia1jt2nCZ?=
 =?us-ascii?Q?IvL5yOSjq7rhLv2zclUP5H9X1lMURU9w0FAr4UEROQsRfnfWXq1G8jsIE5Ft?=
 =?us-ascii?Q?/tW5yXvKWvLcf9RRxGGKNJUtp7aAsdqjBDyMCcF4oG3iB7nILXh+6+BJvmY6?=
 =?us-ascii?Q?OFsD4bWBpotzRKojZAfk/1gQRT1BIDCEgwoLPa2xfiJCLxb8OKPm91UJJNbK?=
 =?us-ascii?Q?whVTTBm8GjdAYqswyYNw8jvdre7CiArVYciGRLsYSY9S8Ozks8IId/p5PuqT?=
 =?us-ascii?Q?Fn/inRSzHAyBlpHG7Ek0vwefYPvjeOfDtTjXzeFaP0akPes1ijDDrK6lMZwF?=
 =?us-ascii?Q?Z1gdN9WQQjvDkg7lvp+3TFV5tykvmEXKegKnVzrfBv0mpLfiKIBC4ae1p1yC?=
 =?us-ascii?Q?9QBzuon2TsIConSuohsR8Ct/TSYtkH/5AWGfP8Vt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb4a991-972e-475a-5dbd-08dcea020833
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:36:02.9213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEw3kHNeLiP2YaaATc8Fy+t9bqmQIAX5/1fP1B0Dsf6pewMSZTTGZQ0BbbZdqWiHrMRKzpQzKiapUstddq2FmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6846
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> Update the CXL PMU driver to support the new events introduced
> in the latest revision. These are:
> 
> - read/write accesses with TEE constraints.
> - S2M indicating Modified state.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Just to be sure: Jonathan you are taking this through CPMU correct?

Ira
