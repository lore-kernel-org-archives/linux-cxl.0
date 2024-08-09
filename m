Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976015534B
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723239874; cv=fail; b=NWOwHdfTp0RbE1aYh1OTB121tOu8opwBpXfsH1YTdvZQOme82fZ3+X2Hsqjk7MIBGSeal4725bePnPP0fVwwdxdU49X4xvFeu4dbRz/cxS+uqzcAcVbc1PWjzlfP8QmxvAJusj1kLHLMW+z36t4tU0qsI00AqyDmYvy2FuGjVu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723239874; c=relaxed/simple;
	bh=ohvHnDf4m+cYlyoDd6HcEDZkBAEFbuDoGTgZ+8Qi99U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PQn1ZrWkCQVD87/yKfoSycC+p8H6ssvKVbeU0hbVMi2mV7KNJLLil/dehA8Lghgwhd+/TZEvDMaKoZV/oKm6yKPGIarpA9TYp5RAENF/Ww+tT8f/glzMpHTMUULfZ0/CTo/AcwbGVxaICOD/JkdZab6uVTFJFguLX89HW6V863s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nor1EQhv; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nor1EQhv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723239873; x=1754775873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ohvHnDf4m+cYlyoDd6HcEDZkBAEFbuDoGTgZ+8Qi99U=;
  b=Nor1EQhvENHmzgcRaigMi1uZmV7dwzBg61XNynIogNzEoYuGke86igqc
   cgnR3J2DFMvNqpTJoSjORYMmqcj+Q+clqxB/Ner0CGEPNZ7VyDKMLH8ck
   H6AuXnc82sM4SQXroR5GjsngWpAaPZhwtUzkQPoxxLMral77Jnj5vXgsT
   dLu3jvBPjzHZHmOHqjfW1oFkHV0mEHPxdgaJpdX4fD0iCcho3ea/B5s8Y
   OGlz2I9phu3DxhuveBbjKRhqfPor9klBaA7WB1OGTtBjKDIbnorMXWc1r
   i3lSnNkZTiDY7vi9DB3WXx772/OnfpH61mtDe8eS1gGsMTdjSphZB4BUD
   Q==;
X-CSE-ConnectionGUID: 8EIeG3FrSW2IbtF0eScdJw==
X-CSE-MsgGUID: JQCIsX8XSAqiFCIYxFULRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21600917"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="21600917"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 14:44:32 -0700
X-CSE-ConnectionGUID: Eo0a/aswSbK8438CsAlj8g==
X-CSE-MsgGUID: 0jtfZfLDTxqzLYSguMj0vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="95209203"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 14:44:32 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 14:44:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 14:44:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 14:44:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLTzrkUz4oWwGC5PAlha5Sg+kglRqc5meo3SLHX8f/WaUE5fcgSdr2zIkAVgFQtDjZVtm1k4epmeqEfzi1G5VlDBSVlLgbTSR6ZlJWdi6UbAYERU3VqJQNcZhf83qNxIAAANRKDijtTJ3x8wBNbBuabHZN5idXLeJUj7HVfbYEQ+RpA+M5HdGN/sXj3pc4PJz2tt9Wwyh2ACXf0N8k0Q6n70CLtEaVR6puCsXTy5nulnLzFo+dUYy4wZliDM82FuXr4ipnexpc3Y3qXAt/E9KSqbyr3Xxr49GjHqcnpG0XRc/Xdcqvap+fzseP9VbedSk+xOEu+asiuMvzjGgoRUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKSzmjyWMWOJgaRXwmFOl4+BlDikE8hV6lbp/kd/vy4=;
 b=QJXbY0xi/qHKNJ9f7MyxgDd4domSRTLUdwP3OStlhEunw0J/4u13jl1IpgsVC9qB6RPx6BQp7a2YVo1KJr/flxXJyFEuHp5vjvBlTyrxhig0+zeY+ynQWBSk+CvNjW57p4+FQZeW3ZgeqpjcHIsRzsYucZUDyFOZlvLUeUH90oa2QV4cJDf6FHLCc04cCoGeJJomafkxyvdr32Cw5JjMymC9yA3Qbqy/tZWaoaphUqxf0ywtfwoohnz1SkrI14/apbiVsz3PizaPCeTTNi40frpILNeCYEsAkmgFbzYHu1OQEUPrvvbBVS6g+QBjdOinSPEIXmnC1asFaHatAvStAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7820.namprd11.prod.outlook.com (2603:10b6:610:120::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32; Fri, 9 Aug
 2024 21:44:28 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 21:44:28 +0000
Date: Fri, 9 Aug 2024 16:44:23 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Li Ming <ming4.li@intel.com>,
	<linux-cxl@vger.kernel.org>, <rrichter@amd.com>, <terry.bowman@amd.com>,
	<alison.schofield@intel.com>, <pengfei.xu@intel.com>
CC: Li Ming <ming4.li@intel.com>
Subject: Re: [PATCH v2 0/2] Fix get a wrong pci host bridge in
 cxl_setup_parent_dport()
Message-ID: <66b68db7b3f3c_6285029485@iweiny-mobl.notmuch>
References: <20240809082750.3015641-1-ming4.li@intel.com>
 <66b68bce7fb41_2575294e4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66b68bce7fb41_2575294e4@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:303:b4::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b27bfd3-4171-43ab-3abf-08dcb8bc719d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dX1RFB5l28/aN+Qki6KjIaDKI6ZJnA+wnjBIvpdRgwlBJ4TWwqYW13jQ+LwU?=
 =?us-ascii?Q?JFeyLiCU47eGLjtECoAmEIAKA4Vg186bwoKcC4J4+EPQdyt2P95OLXhWCH+8?=
 =?us-ascii?Q?XFN2sY8tXd0pqBXV/6tf8DNdS3J+laSgjvhbcNMwExwWm5APX/GtLEIW8Eb3?=
 =?us-ascii?Q?LICbqHiiTlrCx9ZVv+4B2bRywvQjLATpEkUaynja7RqIM2Vurrdpsx9N2oF/?=
 =?us-ascii?Q?Q5gEfZDtkXLIp8vRHBi3F2J8MiT+sk6egfheAW07xUhVk9QyKwcPxfSIBqOn?=
 =?us-ascii?Q?vn6wVLW5X2bMVpDfL+LNVJ8pM4bSL1D25hoNfXusz9Yr3qG+x5L6PSZsgUE7?=
 =?us-ascii?Q?fLeFlbD+n2O58qw0kyssWki0yo5q3gpgql+bhClHgIHXy2A6zuzFFS1tKz55?=
 =?us-ascii?Q?1fY1nTJIXDR9cebxmd1UbTvbT86zfe1TTnXn+06uwhSsUWkGI8Qlk5lEEV4Z?=
 =?us-ascii?Q?ws5E8VzjT0EOYKw+YNqpUR3emTz3IJymsJnLbuvy10yGMMwUJqdTiYeNUnNB?=
 =?us-ascii?Q?Bkg1sJrm5mrEvSU8R71+xaZ0HKyh9ubr/YmCbjs11AjLiSWvLwaHkx2/Jly4?=
 =?us-ascii?Q?NW/NtTwmbQPbYGpbIUrbbx9DiEpEPGggzdosSJTGp2238ZAYkHTwaioT9iFi?=
 =?us-ascii?Q?wky6rscjBh8DebxWZz65Ki9q/EyEdblf8oj8nMLvkd/zqGVU+IjoKy7QYCUm?=
 =?us-ascii?Q?8YkKNTXMjfVLbh/4OyakVwPNuu2I6N1t0/58Amidl2+2SOzX8+uMsIa5dV5B?=
 =?us-ascii?Q?ivleVKP5SFiyNqRNjm+u8Hdvp33ghNZEcQc5woK7Z6Oeelr6hiJLCxf0cPee?=
 =?us-ascii?Q?/kAR5VmmoNTOGjf0cq7ZGjxHIdZdJhOA0Dh/VDFg5YvwhuiZpyK9v+kPBfj/?=
 =?us-ascii?Q?uhsFcmduwvl2B0Kfrn3vgIubkGpQYHWj8B8kMJPwYkWnbqK5F2mzgaqIE3vZ?=
 =?us-ascii?Q?gCv1YPwOps6mjKooPkoOwdOMgwxyw5rsu0OBZXmo9b3pq2vsaJZMaZuS8BkO?=
 =?us-ascii?Q?Zy037zxwlIlqql/Su+Qv7/YEiFRi4jX95UidPrU+yD7ytxsicqqJgxfIkidg?=
 =?us-ascii?Q?2t2UG8aD5Bn/R6jiVWtHJ4rMVfKyRX34MXAevltGGCZwrc5rEGd4aP6dskoP?=
 =?us-ascii?Q?y5viVp1pDp9mWep5JvtGcvrDVNBzlah86MIodrz9SxEK0X7eOXcqUcyVJAn5?=
 =?us-ascii?Q?y0NjS/iM9c+6mjrCkgkyxBmt0f6xvmJ8U1F6d8DlDTuAaEQaKZiNCCTrCJf3?=
 =?us-ascii?Q?m/Ye/MOXKdYoJTkZ0Qx9Kfi8jFGcteXz1DyMDuRYCsR7QLk9sFLpB7na6PeW?=
 =?us-ascii?Q?bKU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ahEGkvuSPtddG/gCVu96xpstjn24ZrXG7rxLbWoRvgU9gGbCYc+lWVG8uzoK?=
 =?us-ascii?Q?S1LP4ClZkEA1kyrLWKD9egYQW/eLFm3RbcVNG3kpdIc6GaTFooO4bnmtqshq?=
 =?us-ascii?Q?N5Fg9bSA1UIsrRi3qSySethbCA9nABHWpOQI6CVm9ngLCt9atP5eDya/OTER?=
 =?us-ascii?Q?+LoetYLRNZNoxD8bNm7uNOUsGTEQ7nPQ/rh7VsvpbFAX2OmTSFgYQGLdt/x8?=
 =?us-ascii?Q?MxX1jtAtKRoFffi+wMEY+NvPxEx2ZbmMBhVmJ8yLeiwXmHJh9nJiwxcS45+x?=
 =?us-ascii?Q?93m0jNVSwAC/G0okNqg/4Xm70Xy3ILxhtrxqPhMqN8S1C56Ru3g+HtPcB9G4?=
 =?us-ascii?Q?IrKfqTOtpccxBBuIONjar/E7cYAzqKbVGVTulzu6+GCABsrpwOYvdRLIhPhI?=
 =?us-ascii?Q?0z9+d0/muAAaMAyyuPa6JiuRjP5lo1gUyZAesyPDhfqGO2ndDEcufRWpmqrl?=
 =?us-ascii?Q?H21M2Sr2my8VgorH9z692BfRteEIig4WTtaIf4C8ZsoZUQGuCxFo9MNWa5eG?=
 =?us-ascii?Q?1y/aoLQ/H11hZzZ9//NaxvUcOw/SGM0eIfNmHRtjSfAYUQtt/uY3+Ma+lllJ?=
 =?us-ascii?Q?ZBJj9/I+RDEtorvs0O1JtUYTWqJ1xXGayYg8F6YzSOCTo5ne3A7MG3SgtR/x?=
 =?us-ascii?Q?jNkbBzqSPPipFWdIfesMvAwmf0mMPS+bPYGTZbwhCV0zXPiVLvOcA05wkk2P?=
 =?us-ascii?Q?vqakjHyp77j1Nh5reB/C0vgB1Pnjw0A2qRn/XMB3zHbRSt3RASWqBlCyjSFY?=
 =?us-ascii?Q?ni9TsJOs6e16OqyaL+agGGKzSApBwc5gohf0ElaaLFmzwBrb6SO79Hdk4bCo?=
 =?us-ascii?Q?3eX3cML69wAMvCmZDWffYqyYfvl7XVypK9sJuh/CWkDHVSlNV5llD4rkB5AO?=
 =?us-ascii?Q?+m91DI9je57mPR1H+tMMBShzAP7bcPDju5lyFi/IXPnk3MfxJ3U7telCe640?=
 =?us-ascii?Q?g7fAoHJ4an0FkHCUxIqwJGG1M0JEsf+UsE1lp3AUcWZHAYES8mnw1LdKb47J?=
 =?us-ascii?Q?qT4JLmIraNAAeKEVzTUrrhMmQRlblxexqttIUVhTe6mUIVn1u/7hL7igLnjJ?=
 =?us-ascii?Q?u2fSN8CSVtE5tv186V7oO6gY94M77noR3NdXDcSkPjE+3HLjlqH8xfnLMzMe?=
 =?us-ascii?Q?9CZ3OrXZN87n61fSxS+YUmkZYpxLWRcCzJZGfcsCee5dT6eRaUoXr/UN/mC9?=
 =?us-ascii?Q?evUTjOedtvnYAVYNgV/PLc5dqHIYvDYOvs+Agpwqc8d8xc5famG3TNQ44BTB?=
 =?us-ascii?Q?SKr2QREFE8wFKaTqaK6o0yKxD/9dvx5Tmau/gOmX02xMYHsogczOuZ7pNjJ0?=
 =?us-ascii?Q?OJ/9vPoeCLckHCtAll+Ovsi+VhGJ7TYGuQeE3OgLyJaGR2jpvb0AbfF71wW+?=
 =?us-ascii?Q?qyrz7O2/oWbANuOsyIKBwSHRXUGclaesr2D1jTSLpGh3cCj++dei5YPxcShB?=
 =?us-ascii?Q?D5bGCnDcGtvi1iQE6XHZYznUjucC2+SREBbvDcje7fOOlPAjTq/Xujb1mjk1?=
 =?us-ascii?Q?irg/rvdbZUU0OsS+H7Fv4k4s5yZBydS0kHKCZquvM/c/p7FPTDXuPDSP/TPi?=
 =?us-ascii?Q?s19UbTvKLgqWyQ5MOfOcHmoZRhl+zCKhYz0UIh1K?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b27bfd3-4171-43ab-3abf-08dcb8bc719d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 21:44:28.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jz9WvTztCmhAemKADgxbN16dmwbzmNgZUYBZBnO7wpJabsOqNsHd1ExnkHeN3f5UQU/rb9XT90WJYqhcaZUGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7820
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Li Ming wrote:
> > The cxl_test unit test environment on qemu always hit below call trace
> > with KASAN enabled:
> > 
> >  BUG: KASAN: slab-out-of-bounds in cxl_setup_parent_dport+0x480/0x530 [cxl_core]
> >  Read of size 1 at addr ff110000676014f8 by task (udev-worker)/676[   24.424403] CPU: 2 PID: 676 Comm: (udev-worker) Tainted: G           O     N 6.10.0-qemucxl #1
> >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240214-2.el9 02/14/2024
> >  Call Trace:
> >   <TASK>
> >   dump_stack_lvl+0xea/0x150
> >   print_report+0xce/0x610
> >   ? kasan_complete_mode_report_info+0x40/0x200
> >   kasan_report+0xcc/0x110
> >   __asan_report_load1_noabort+0x18/0x20
> >   cxl_setup_parent_dport+0x480/0x530 [cxl_core]
> >   cxl_mem_probe+0x49b/0xaa0 [cxl_mem]
> > 
> > The root cause is that a wrong host bridge was gotten from
> > dport->dport_dev in cxl_setup_parent_dport(). In
> > cxl_setup_parent_dport(), it always calls
> > to_pci_host_bridge(dport->dport_dev) to get a pci_host_bridge structure.
> > There are two issues in the implementation:
> > 
> > * to_pci_host_bridge(dport->dport_dev) should be used only for RCH
> >   cases, dport->dport_dev points to a pci device rather than a pci host
> >   bridge in VH cases. The solution is checking if dport is in RCH mode
> >   then calling to_pci_host_bridge().
> >   (Patch 1)
> > 
> > * In cxl_test unit test environment, cxl_test will create a emulated CXL
> >   topology with emulated dports, the dport_dev of a emulated dport
> >   points to a platform device. to_pci_host_bridge(dport->dport_dev) also
> >   gets a wrong pci host bridge in the case. The solution is implementing
> >   a new wrap function called __wrap_cxl_setup_parent_dport() on cxl_test
> >   side, the function will filter all emulated dports, make sure only
> >   real dports can be handled by cxl_setup_parent_dport().
> >   (Patch 2)
> > 
> > v1 link: https://lore.kernel.org/linux-cxl/ZrHR+0w3bwM1Ik8h@xpf.sh.intel.com/T/#med6200e54ec12f09fdcc04571516adda261c9561
> > 
> > v2:
> > - Add call trace log into changelog
> > - Remove 'dev_is_platform(dport->dport_dev)' checking out of cxl driver
> >   scope. Check if dport is emulated in cxl_test.
> 
> I am suprised we got this far without this being a problem earlier.
> 
> For the series you can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

This fixes some of the issues I was seeing in the cxl-test failures.  So
I'm going to tag this too.

That said, on patch 1 I would like to see further clean up.  Diging into
the details of the dport->rcrb.aer_cap usage this check and code should be
moved to cxl_dport_map_rch_aer() and make aer_cap a local and remove
struct cxl_rcrb_info completely.

For now, for the series.
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> ...can you also follow along with a rename, documentation, and cleanup
> patch?  cxl_setup_parent_dport() tells the reader absolutely nothing
> about what the function does, and that it is specifically initializing
> PCI AER operation.
> 
> It should be called something like cxl_dport_init_aer(), and it should
> have kernel-doc associated with it. The cleanup opportunity I see is to
> consolidate the ->native_aer check for the cxl_rcrb_to_aer() and
> cxl_disable_rch_root_ints() into one location. It is a bit silly that
> cxl_disable_rch_root_ints() needs to check if dport->regs.dport_aer was
> initialized when it was just setup a few lines above. I.e. there are
> just too many helper functions and it all could be consolidated in a
> bigger cxl_dport_init_aer() function.
> 
> > 
> > Li Ming (2):
> >   cxl/pci: Get AER capability address from RCRB only for RCH dport
> >   cxl/test: Skip cxl_setup_parent_dport() for emulated dports
> 
> This is the right thing to do whenever possible. The usage of
> dev_is_platform() only makes sense for scenarios where a function is
> called by the cxl_core that needs to avoid getting confused by cxl_test.
> 
> In this case, since cxl_mem is making the call to the exported
> cxl_setup_parent_dport() symbol, then mocking it for cxl_test is
> appropriate.
> 


