Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23E2628D;
	Thu, 27 Mar 2025 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743082574; cv=fail; b=eG3ZAgT/Fev11UrdaS8WalA3UaIO25A0Tv15/mCpU0Uw8b+tfNGh+Xt0Fnw+cgt8st/qkLd0fzkxAZkhO9dbabMpfinytqFNY3PETPmcDej54qLVgvTRlZV+QmVRZNeuJbA+fmpK3ZA7Zzviw6Ff3AK2Cja0Yg2Zjr8m+j5U8H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743082574; c=relaxed/simple;
	bh=XRAWpff/N5e6QXaqZCwXYnsWo+eS5ovNaRAvc1R2/sw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=scBaoR9vr60bWjFXpkLJfHB2nj+vUef5bjiXcbNLARKqANZUWKywNGsZ0DZRDCLoZydTgkcC1s7ZCwpRHhq6psx3TOW3JDDa4vD35JH3j3k61ut2FkmsO3QdQauuGZKJ3TfTlCn+qOnNHwnL+wPhA2fckLqibq/vfF+3XRDklpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjCTNByf; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjCTNByf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743082572; x=1774618572;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XRAWpff/N5e6QXaqZCwXYnsWo+eS5ovNaRAvc1R2/sw=;
  b=hjCTNByfUP1eSK1wpCd6x7uCUt4exNl9MipLkP3YQ3kB6MN44QtgcqRR
   N60iEjcquvZ2KsLU2bo0ysOrQLhr6W4PndtVuZxDSam6280D+A2GDjfR9
   ZcBfyrDKXfLdCzCtuUTLvaDh3S/vk89bxDppHEeDhCxHFuCWlT0nf2mz9
   O4Rsr2fWAalWgOjQ8b9XydERdiryLZUcZiysvmtoCTNE30ZlaMjpxYlLy
   wDMrPWtBb3yvi6/JHpp2TfWmonRfRQYb6Al7fTyMWWn4PEgOnk8EdNqRg
   WC53+cOluckeR8qT9caXgsq6eZh8AJ0b2cZRp14odss+WZZJ3SKqzczPF
   Q==;
X-CSE-ConnectionGUID: yhVTURxuRNCvL5HrqTDR4Q==
X-CSE-MsgGUID: rWObETRCRYC7n+YbmLz0HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="47147356"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="47147356"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 06:36:11 -0700
X-CSE-ConnectionGUID: LQJudJibT++3BSVmgorTvg==
X-CSE-MsgGUID: syciOIsfT9KiTdw6iOBW4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="129996916"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2025 06:36:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 06:36:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 06:36:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 06:36:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWndEbrpkrsmBrhZwfRkWqX70TdA04eWDru9pDj99FSlVoMLiXunUMXruYdLxwdyqmDvQ9Yt5+TtC0ROJk0aSO28CdRU/Xu4zRKJ7JIuD9wN5xPtc2287YONz768sVTHYNJIbKn7gfwyeZgc9eqqWvkCYv1B3vR1lAASMhJ7evK5UUvZx/AqBhLGUnJOY2MAqKWzUi43c7VbejMuTTjRE3GaK0OfKOszd2I3lijIeOWgGCw5MrVjJR7BcxkclydbJ7s/3sIiK401RwnCbkGeghw5M8lvFBFoU0+4NaAv4kXaFCda5qIQU+E/fb1HwSFZp/WF3a5yMWDDd58/cOCoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyE103pvsFk5ZuFy9pzjL6E6A6G+lNU4n8qKsbKBPqc=;
 b=uoFyPyX/dlq8iomlEabw8WzhlsSMvkLJdNlMyZj2xCOkzF1exHJ/ueW39L67arFsz3U+kUboQTuoRsTgyWtfqqTlIlKqStDiZBCsI7/X2O6WrrfHynoCOL2XAgvWVDRzzfIaAnD565Ak7eS9EPiTZZHUAcJK0nXe6p9Ecz1A5ay/X6uyZL5XBSCbkaaNb/8u2kgpKEob1RtGvsO17at37bzSqk0vG2g8e+9fVxGf2U0fUWsOjkYB4QN+kWbDrii9IRmno+Zk1kqd3W3GeHxnkZMBtgF1NL1Bx1hb02ssJxLQqGzHpUQ/1zDpxi1TxvXITLIFBTjrc2F4wEojjAqzWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7473.namprd11.prod.outlook.com (2603:10b6:a03:4d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Thu, 27 Mar
 2025 13:36:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 13:36:06 +0000
Date: Thu, 27 Mar 2025 09:36:02 -0400
From: Dan Williams <dan.j.williams@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Ira Weiny
	<ira.weiny@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Verify CHBS length for CXL2.0
Message-ID: <67e5544237027_13cb29432@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250326074450.937819-1-lizhijian@fujitsu.com>
 <67e4c9aaedd08_138d3294ca@iweiny-mobl.notmuch>
 <1ed912df-42c7-4319-8765-3167963df7b3@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1ed912df-42c7-4319-8765-3167963df7b3@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:303:b8::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 391352fb-651a-443f-61de-08dd6d345361
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EE9kc94P0YTYeGmPVhWVgHNm7L3ZtHsOSFCB63p1f/X0gPLbytZ0lHCuZ5iS?=
 =?us-ascii?Q?V+ti9F9Yw+aw8EqhL2rNYNaohhXX71JPi5TTESp6cPsDid2oTfX27V+2Y2UW?=
 =?us-ascii?Q?TjR6qwradoRyBQcEjWsFCNbtQChmS9gQh2y1LlhwTSStiGn4RMr97kP4bwHA?=
 =?us-ascii?Q?PzPUAM89sOTN5KfA6tBFaXJqg2rI+KPunIg1j/N97T+8Atwvz4enk3LnnSOt?=
 =?us-ascii?Q?ZfTEMiwjYHQgpIUEwK5XUz1Twox5SqOX6q561kAZHNjPO1J6SDg0M/0mJ0hd?=
 =?us-ascii?Q?Ur/SH1w6c94jM86/fMI2eExQExIsMK3nbuLxpz/K/2Jex+kgJgsGLWWHlnn2?=
 =?us-ascii?Q?TpTsCukMX8PndwqE6m690QeEV+s5aToYGEQJOl39QIPBetpYTskfXGyiHCkE?=
 =?us-ascii?Q?AbY0ezZYSefmrK9S9ISU6O/8O+SdDe50sMwKuWng6C34N0p7O9Jm5XWZj/iE?=
 =?us-ascii?Q?tBAUpiNpavMvL/xK1sA1oSj7kGcFek5wA85Lv4dnQlMVPQ9wAAPOvU2rU03t?=
 =?us-ascii?Q?ob62+EGhC3vICA8IauZyzD7WbPsySv7ySogFBrAf0D6YLtJHry/WlHwCXz3F?=
 =?us-ascii?Q?kLafjgz8TrI+vu0nd8RsUTUgtIlFsUHFfMyRlOrIzqLOBQJuasiicWPFhYV3?=
 =?us-ascii?Q?YFhgGyZMFURLOoTc5Bv70QowCotR7U4IbrUkAr46//YotmnOoljSQDAFsMuY?=
 =?us-ascii?Q?EIKJNZhyrPgVbyDM5XQz796tgut7WBGGDZRBxyGgmgRVR2GLWstus+UgmvwD?=
 =?us-ascii?Q?joNVmCgQ9jGpjG/XsZYQdeRdE1U+wCEm/2vwxtvx6Hi2VnifXMgTZddoo9AL?=
 =?us-ascii?Q?vMdSG4tw++z9inB9MhL5o+9/IvZGlB9GXFNjmu62meHkCn2gEcGEecHWSnGb?=
 =?us-ascii?Q?Ig+aLYgD6dv3BEBiGTbtRkvyVBZ7c7LMfzkXEm0iOkU4ymITx1aQxBGCPfD8?=
 =?us-ascii?Q?CdxHmsWemx5lEzKmJay39bFaE0vVKiCAbbxPuNuMoi0EcdxX9y4n/9OZOS0I?=
 =?us-ascii?Q?zF1kLMGBBpXqh0rX7ZLNFtHTSoQIuPhBJrJ09FnYMxZgyYyPIL+dgh8oupMA?=
 =?us-ascii?Q?wtTW9BYoH/0n8grbAx0uZMCs6LIMSnmmJLlSHgsfpON2UmsfWg2aLvUfPexn?=
 =?us-ascii?Q?+85kKluz4ExJ9WN8M4Kj2GX7SHu7KcyAU20m8ptrs+72u11HE46GvdFERygQ?=
 =?us-ascii?Q?Jiu/vwzuws9umWP1a0COMb1BiBmOgN//sA48MES55FrcdLQfVz3wpLNS2g/B?=
 =?us-ascii?Q?XBBan/c5zVUGjjZftfClk7vqjzG9F5m26kmG1QyLKQbuaNBjtPaQNO/MEtxq?=
 =?us-ascii?Q?63smNMlC+LM7dgs40w0t9/RaA6RXK7/55rLrtKerKjm3PW2wibQgQ2pBWWnM?=
 =?us-ascii?Q?oeY61GYtF3ADyfahSXdVUOO9xoX4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rBvse6AYOBUBVb/z+mFyrz658wLfvjP/PJIWJkc4iRCRoZuNkjrGB5l+WXB2?=
 =?us-ascii?Q?7C2T/EZtf7E70LivVCb65uLBN9bi6O5jvmwFStBjEEKreOvlC9Ej7ZsNK7ke?=
 =?us-ascii?Q?cweqb53ASqUqVlqIZvxOgxkDZJiG7YnEjRpX39euvIIc0hYJCvK2fZGNlIrb?=
 =?us-ascii?Q?mGt7rS+lpWz+co5iNifKOn2yEan9cJWUG+U83zeav+o/7/MXGH6cvOpwIfB1?=
 =?us-ascii?Q?0WmUCm3r1rNGyiRFSEk+nbKv3aew8WLOxctQFBcvD/IR/3LiLNqiUR5tkhQ+?=
 =?us-ascii?Q?wc8MvZb08xG8KiEh53rCXklnXh60SMWQdS7Bmeq2ITE7YuvA/XSlyF0vFNZw?=
 =?us-ascii?Q?4bot5dMrdClAtq8BMdrzJFgLdkBxHPZpv1XFSfL1GfM7ntVOCfb2+31thUkA?=
 =?us-ascii?Q?OLoNDsCYBJmAVgj32IUAnEJ6N03pjL0Dzk2H8/JyYDqc7GnMvF39geOsTrwe?=
 =?us-ascii?Q?T0C5ymRz1nljyeg57rSmlSZhsWX1zbK9fnUMdFB4Pfh3zY+8zJnwCr0Xmlv7?=
 =?us-ascii?Q?ISIrQROPvFzmu7cPkdHG7DAXvjiRMtNiCWJPojViezUyJYH5D1WaqzWx7klm?=
 =?us-ascii?Q?hx2Eec9MZJdbr1siw1cL0UQQIaZlaafnqkPzUuPriiae104K0xuJTTs9Efxq?=
 =?us-ascii?Q?bFRnrhxLYT65lLoFKI1N/Xlc0r0j7FvimXDp827vOhJWs5tTrvdI2OmHaZF7?=
 =?us-ascii?Q?yseFGqAkCSdUPR6tkvMdMEIs6P+t451QdxegxHjvGghFm/gg4TyEMEq9RgxP?=
 =?us-ascii?Q?ScgINOigXeB5zUBuOn1k6L+i3cPVxYX06TtIV4cqC2P0gQ5PN7oS46y+ASNz?=
 =?us-ascii?Q?AbekhgSK/28pkDiePl/LPmiqTBCFVonCq1WLH3ztI+slU9DX1/tzvJNsyFYU?=
 =?us-ascii?Q?d9c56ejRxAJtQCYwJM1RI/RD3bB4zvBIg6ijQoOen8tPhB7Arb5camXtRwOu?=
 =?us-ascii?Q?XpvSKv1zHab0u0/sc2aqhQeXoXIoMaNnuhHWdLq03TFLiw9LIY2pgChG+xA6?=
 =?us-ascii?Q?wANKIlvSC6ZfDpWS+OomM/bplzEKnwgxD+P6yPJMqWsOnTYWRJ6GSuEGh33O?=
 =?us-ascii?Q?8ndvMfl5WSJtBLfTl2kyFeKz+QN1FVinURtPHHTsbtsZtEELLafRGXIBhopS?=
 =?us-ascii?Q?eZupE3Ixt5olkzlASIHv4sPEe3smpG4XftNytJOznYRkde1L+Hn1/TYMU82H?=
 =?us-ascii?Q?jUy/6U25aYSRp/3FIhbW5uaSgb9E6mAJD7VMzzTnLRdMPNDHCUe92bk61y6j?=
 =?us-ascii?Q?b3D4o978UBPgQwaPtqVpoOX/xulbaDBCTEWjiIGcqCiF5EviB+jhNvWQVdtj?=
 =?us-ascii?Q?xX+Hh275n4OYRnsF/j8NjS1rWW5oBsN5KiMTkCNz12VSB6YdWPHcwKPQbB6W?=
 =?us-ascii?Q?ZKHjAiPCdT1cPT0JgVtGSJvCp50W7lkiPzsQwGerpu+itI22HlvopBXJDhO7?=
 =?us-ascii?Q?Qap22TPvm+ihdp6ir5UByJPIUvkXRozDDYzU5cgb3T+VfyBFbAeHAubQa8tA?=
 =?us-ascii?Q?iKlIDgSwQSlFnyJ0gHjFKtuO9eJot6TXWUTG/6FrtoZ8c5E8CJU8kR4cbHha?=
 =?us-ascii?Q?Ap0RuL2/u+xvOhi7aNraSbZcmhQeUs9V4+a8G8l49xgIcBohSPyUa9ILknhv?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 391352fb-651a-443f-61de-08dd6d345361
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:36:06.3647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U11XH6WhCL44iKRjo0c3ABGaK9FCzU7uXs7c9uPy1FU8jrk+Gwi5OZ7XFvOaXxalRLJXcq+yBAswR4kbwbLs/bpMxEhu6GTqjsSilcsWCjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7473
X-OriginatorOrg: intel.com

Zhijian Li (Fujitsu) wrote:
> 
> 
> On 27/03/2025 11:44, Ira Weiny wrote:
> > Li Zhijian wrote:
> >> Per CXL Spec r3.1 Table 9-21, both CXL1.1 and CXL2.0 have defined their
> >> own length, verify it to avoid an invalid CHBS
> > 
> > 
> > I think this looks fine.  But did a platform have issues with this?  
> 
> Not really, actually, I discovered it while reviewing the code and
> CXL specification.
> 
> Currently, this issue arises only when I inject an incorrect length
> via QEMU environment. Our hardware does not experience this problem.
> 
> 
> > Does this need to be backported?
> I remain neutral :)

What does the kernel do with this invalid CHBS from QEMU? I would be
happy to let whatever bad effect from injecting a corrupted CHBS just
happen because there are plenty of ways for QEMU to confuse the kernel
even if the table lengths are correct.

Unless it has real impact I would rather not touch the kernel for every
possible way that QEMU can make a mistake.

I.e. if it was a widespread problem that affected multiple QEMU users by
default then maybe. Just your local test gone awry? Maybe not.
