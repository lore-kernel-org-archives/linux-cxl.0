Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB16125
	for <linux-cxl@vger.kernel.org>; Tue, 21 May 2024 04:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716267381; cv=fail; b=I8PAvgP48+lR2DDc8xXqrX9FWoqgD6D4M2jjaZ/2rGkGncfIz7zIP7SYOdGVOaYT7/OvIN9rZszaOUMGNYrNyPigZ/AV4aGWUgSkKcpImEzURf5cTDYVbvIg2fO9GHD7ns8BFIAplF6Xb7bF+PGCJH5S2Cn/UCCN85+okBuvvQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716267381; c=relaxed/simple;
	bh=0WWkaOsw48re0aQV4dsQq3Bki/4kxWw5V86WK4GWO70=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oGARl2/ht7tKKqg5biYdWQWvNvtaX23ql+R5OZuw3fXsyar/yasWjXEhLJqp6SJcc9YRXKGE/Rh6eboU8u7umRcW/zSkciuX2t8o0gS+8vqZAiGkE0nYlBVDW5OS7Ny8TvvFk2teQte886ga3z+zmgIKCEPfOr05pNpBWLzSfoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lgLiRIvg; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lgLiRIvg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716267379; x=1747803379;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=0WWkaOsw48re0aQV4dsQq3Bki/4kxWw5V86WK4GWO70=;
  b=lgLiRIvg0UHWmSWf4P+r1SB80JURUYb3Tjhn7hx8UicME2cNbIqyAHhk
   n4QPkBp5+Zyevj8yi7t5hYNsnEybQudmqPaXI6Hd9iiYx+La+IO0B1XI3
   kY1GIafWre1plX2cEl9Co1kS3Dg6j/+a8U99u8mPFGhU+Dm6VKkVdL8MW
   1peawWMDYapXagqNjSCfQL0ZJZ9ZQycBB8n8+Qk0UZXZzQ6BJAH3M7Zf1
   ImzT7UuJlg8SjGWGmiRV4ntKAIDVYdVcKip27MB2yrNUW3wvyqCOJXmxr
   u1r2/f8sZFVCSY5gpmSbQRhPQzEq5O6WMNBGy/TfCuQGxr0M/f8doVdB9
   Q==;
X-CSE-ConnectionGUID: aAuauSRtQ7C34sfVQcSXYw==
X-CSE-MsgGUID: QzEnKSaxS/ymEl8Tlp+sTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="11623490"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="11623490"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 21:56:18 -0700
X-CSE-ConnectionGUID: fo/3ibEaTaqxQ6zYhjUcGw==
X-CSE-MsgGUID: CiDESXzpRpKvZksIUQB0kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32953965"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 May 2024 21:56:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 21:56:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 21:56:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 21:56:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPf9p0q/9QmMWmW/3Ovgs4z40aGywWOXaGjO2cqz8TpMEEa1PqrQddiVINwk93PX1bDov3pN/LP0kAe51ZRxIhdBneNDwki5ZxAwdMwLUVAA/W8bDQNIIyAL9K3WnS6LLGGxI1gdxF4qp6I5WCdkI186+1MdSP6WAD9dwXC+MafL618zieZFsFgT9BRJK5Wtqk5ILtWioVFJgllsWGmTjoVaoUWCp0FvHLFPEVZV/Z0Jj4FccdasXTe+LVXe2p+O/7Rrt+mXLfXJmDuBAoFyP8iZf/WOPj0yymc0XjBeVjJNfxBB/QN7zw5u1rg8SpoJIPNWilESzh6pK98BEykFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W69OkrX/ATk4LKn5EFmukcLNzUrR5qlHAykspPyMj4I=;
 b=DoGT5Xl04kHvotTsDdVMlfyY524S8mSUPXJqWmccmvS3eLj+X6cJr0tVeb8xrXDrfmsHCcho6IcLtMNokxvTRe4dKovb1HsYDJL2DxuOVVxXJRN0H4M6AZidv3Hq5IAMrKDclWDEWc432b0NErklACSh2KuanFStjEBVkOafVTrgMz596upbLnkzap4bygV0IQYLTbPg/mQ5GcEBSedGnLFFXSwgwCBmSmR/Qgn3VnuS5NGdfpBdLb+/iZTf452cIMjJAnLVWerPFAEkc5OH5ekTadSKGEfQIc7u5J2YR9HVP35O9uHRh/PlYNAT1eoBT+sCP7m72HLx7u42qu+B5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7682.namprd11.prod.outlook.com (2603:10b6:8:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 04:56:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 04:56:14 +0000
Date: Mon, 20 May 2024 21:56:11 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alejandro.lucero-palau@amd.com>
Subject: Re: [RFC PATCH 00/13] RFC: add Type2 device support
Message-ID: <664c296bacb6f_a0282947a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240516081202.27023-1-alucerop@amd.com>
 <66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch>
 <0a5e5366-92ef-d608-43ab-e0756e0458c8@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a5e5366-92ef-d608-43ab-e0756e0458c8@amd.com>
X-ClientProxiedBy: MW2PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:302:1::37) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: c001bc6c-07f1-4da2-6fcb-08dc7952574c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?9st7LDgpWMbrcLkrMUO2rn1SRwnJgNDI7Lmf/9ggQXgVs0NbQwa0G+ArLw?=
 =?iso-8859-1?Q?aRRPQCQwA74F14vm/jKjZbw+AnVDNA/zXBmy5SsnuQov2toO1JQQ5Qxk6G?=
 =?iso-8859-1?Q?ZyyG783RCXKJ6VCWBbb+eoVj7ushTR0zf8RJbMErKhpLiZEp2sgAzEnu+8?=
 =?iso-8859-1?Q?iARxH346bZ6UPgHJoUSVit2BX3caPnVP8RJjyytPpLCuEzw8ImTskIBTkS?=
 =?iso-8859-1?Q?fE5RfuxClpsF/CcqDgV6I/g2BT6n7QcbIQ5779zrXm8l0YgNWtU2LMCqYk?=
 =?iso-8859-1?Q?g7s3tiOk+XAyftWq+GWb/Dx9lTmwQwYxyXjunsZqok6YmBZx7gi8RriBBb?=
 =?iso-8859-1?Q?1tzR8OPdrr+L/0t+WB3dwY2yxCDtGXJy3QGch6a5TrSpX9QGPUSs67Shl4?=
 =?iso-8859-1?Q?lmTnW54xCst/PVnceRoJ+vCxyRFIpZjGfWLPbjIhQCUS57XC+AGX92mW6d?=
 =?iso-8859-1?Q?FZLjLBsLbGp3UAz+zn1M7cBZuRtra5uyEKYtVxnmWfPItomJKd7cQhHJjd?=
 =?iso-8859-1?Q?6H9BERR0oPbK6vLVoeCSppZ9zaVd0ydTO4jZAc+4cYmt8ImsRem1A/ngyg?=
 =?iso-8859-1?Q?f91HQclA80AlblWdqNYvCMnfejNLYeY+PqtOc5lQQ/KecLSgLuTxol3mJL?=
 =?iso-8859-1?Q?8GQtGird4aXRWF6+UpnhFY3i8+rFME6j8KtVhlgyNfWdHl6ROJZ8R/Kso0?=
 =?iso-8859-1?Q?Dqn50YDuwGhRecNl0+elW2w2MU4Jp1IijCRlzwnU6enLZM8xXmvHOGvxnr?=
 =?iso-8859-1?Q?k3yR5D+EHVRCtS+OlrU55fO5KdnhdZ4IHMun0c+g2VuPt76Mbi/MwvxZD+?=
 =?iso-8859-1?Q?c5igKJbFDV6pRyO9pzMOweTHTfVNpWyX513zVb4tHmzJSNhyjU3JNoxD/T?=
 =?iso-8859-1?Q?B7BqyT22CFWN91Cq5G2RwcfBxeGi2wfMPuPbkHbXQFBDJCfxHRvO+3nRWr?=
 =?iso-8859-1?Q?BrvcbPeyPoPw4WEJUqD/E4iQ9DKC0gI+gNFOhfwe4+lv3vpP06an+XYD5C?=
 =?iso-8859-1?Q?MtT9hxnKMb32aK5mbH8nbvQSDp+AstH6e7QD1SW6HHlNLxRnRtYN9cVmzv?=
 =?iso-8859-1?Q?0556h+AKte8OzCkzMGJj/8BgDmd3iogktwlM44EwZUrhTAP4P85AfLORC0?=
 =?iso-8859-1?Q?8PmOd+y/p0M68cnDwC/5FLvgcX9x6rb5RsvcFVLCFxn9+HAze8OmQ2XlGz?=
 =?iso-8859-1?Q?qAl9UYd93P/fdLbM/tnGt7E3fm/fiYwBeRsjHH81AjmzAOnP1ox37EPirp?=
 =?iso-8859-1?Q?TrQhwm4iYr+XvIP+WbtbL+us52bU4KRbapqsjfcHWhXU/1Ep6iraMQ3qTO?=
 =?iso-8859-1?Q?xH0uuGC+MA3FkVCKpvqERKyKhw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6gQtDtJIKJrjdWESl7aQnSPATht+znsRYJKNAjd+tavUf6DABSXe2Iyw9s?=
 =?iso-8859-1?Q?c+bnI+qJd5BmbZ1FD6lNZCp7LHyiv8tHwC/m5qYv/JWVz3t/vGVm4anL9N?=
 =?iso-8859-1?Q?qPpF1P3PRyIrslvoal9di8HsQflP6Ju0fs4zMCvfd4ewsITZqlf77/dEHB?=
 =?iso-8859-1?Q?HROJRAkWWO6RQ4svqDufKe5Pdblu4mlGOxYQV0AQQUBLZLUF8OlbPJZN87?=
 =?iso-8859-1?Q?lhxv0fPisG4DirwgBSQUQ7ta0u/MVmK4I2/hCWTQa4MiTqzPWqCszessHf?=
 =?iso-8859-1?Q?DuCUMYjFsiWPDse1LRq8ewJA5J2c/WN9bbzVrWdPEuXSPy2V+63kLc5tFE?=
 =?iso-8859-1?Q?VJzfe+ZWrpOnmdVzgy3cwkyIdlSWL7MOUcFGP68u1a1gKrhS9HEBpLT8ks?=
 =?iso-8859-1?Q?9+SjZILCnVbL27Xm++xcfoYJYeMDw/cz6ApADnnEnajfcnl9CUaPCnT/ng?=
 =?iso-8859-1?Q?yoL3g8ERL6y2L0RH5IRx2T+fPoQj0Iob8Wdj9dnQIcJPknLrmhLZhD8BgV?=
 =?iso-8859-1?Q?j5akA9KDXBp9r+OWxIjAQdWwarQSYhu/yxJq/VXVwyDToOYc3upCHW2tTP?=
 =?iso-8859-1?Q?PYZEKdtVmn8bE8CDGkcIQ3kmO/l/BHo92z3onLmO5M4ByWATfHO36WBlL7?=
 =?iso-8859-1?Q?lgWhnVdRgQYKq5l/cyNjmZ439IUodG03TVV0OfTczOwd6qTGptzTOQwqUk?=
 =?iso-8859-1?Q?kk30nfmq2HnsqZSVtMkc5xTe6n1l50akSMGnftFfqxmUKWiCznlH47BpLi?=
 =?iso-8859-1?Q?e5p9ehpPap+5vsgyNGGSTPY0MWI66sGQEybp5G3pyD7nsGcSfVUI/NewWP?=
 =?iso-8859-1?Q?ncSPwiVVaMsQSOKqHR16wrB+6pjuHU6EAwyeCptCs8Lvz1PVcowUTM3nUt?=
 =?iso-8859-1?Q?RYmmOKV9nadoa91NE5gHppdddQ57G1Y6DwtLKolu4/xo4TUCtkN6Kd6CFP?=
 =?iso-8859-1?Q?lGx7kJVelM1/i8rZOrNuTE+V39rOHyAUX6puu8pLMPXpe8efSaGbSXz71d?=
 =?iso-8859-1?Q?ooh4AadHnfDydIY0BiidsQGx0GB23RzvaIWA1s8xfxp9LWoaLNSGveR1sE?=
 =?iso-8859-1?Q?EObN0cV83rnsQCTcQS7t3oceT/sySJt6ADBDeWiIoF52lVHMFKe9alJm3c?=
 =?iso-8859-1?Q?ZCuyepVsSm0izQWe4KaF2KEHYJ4CgNHhFskT4wsI7ddxbLNWYPPSc7ba89?=
 =?iso-8859-1?Q?oyGyr8QxY00EvrgBphPWBy/pz1wqyq0GbndWabrjdMc6Zcu9Yk4yhVgHhO?=
 =?iso-8859-1?Q?SkxqcJejng6TOqAbsrqXWnIai6zaa5u3dslmzvOj7hiAq/H2okcEpJrBwF?=
 =?iso-8859-1?Q?3ABdtlZtf85f6FyXHQObYm/c+xb/y5d6jxR78cz9Fot52PLctONpkcNEU/?=
 =?iso-8859-1?Q?gi3PO3NodH/H81q+rtVRkXSu2TAiistW8By3/PYo9EkgYJW2OstELSpKFv?=
 =?iso-8859-1?Q?HXcDIkJkc94avykee6VSpr0Sq7HlQh5T5Ept6wMGwDnBuos1XUbAQbcYiw?=
 =?iso-8859-1?Q?AmvOODlKT4CRVBLDg8vIhcBr9lQb8Yddr8dnNDZyd14ssEaqFD7ufAvj6X?=
 =?iso-8859-1?Q?BdwaK40ryYZUSDKhr2EvlutOULy1Zybn+cSUMzemh79YbSA6+oJvGDldIj?=
 =?iso-8859-1?Q?/e1CQPZRw+yo1/dFHvCHdqt1F1xIWEXCGmFDjcN1aSOxh6L+ob934O+w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c001bc6c-07f1-4da2-6fcb-08dc7952574c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 04:56:14.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cLWZdTox3DpRvN1sPAH0F9ZIA4XhMw2rpStphza6nURS7pTRNQlcMzO+ZdHcjIkQTM/7S1ZSrXTzpGGwFpOlY1AbaDkQqODO+EO4PL/y4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7682
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> On 5/17/24 01:08, Dan Williams wrote:
[..]
> > My expectation for CXL accelerator provided memory is that it is marked "EFI
> > Reserved" in the memory map (or CDAT), not "EFI Conventional + Special Purpose
> > Attribute". Recall that the EFI_MEMORY_SP attribute is just a *hint* that OS may
> > *not* want to consider a memory range as part of the general purpose memory
> > pool. CXL Accelerator Memory is far from that definition. If a driver needs to
> > be loaded to effectively use a memory range that is not a range that can be
> > transparently converted to "EFI Conventional Memory".
> 
> Well, that "EFI Reserved" is what we want. However, AFAIK, it is 
> EFI_MEMORY_SP the only one being discussed with our BIOS/UEFI contacts.

Well, tell your BIOS contacts that they need to honor what the device
puts in the CDAT for the memory-type, not just make it up on their own.

From the Linux side we can scream loudly with
WARN_TAINT_FIRMWARE_WORKAROUND every time we see a BIOS that has failed
to match EFI memory-type with whatever the device puts in the CDAT,
because that's clearly a broken BIOS.

> Because how to assign those flags seems to be based on BIOS 
> implementation, we count on some BIOS versions doing the wrong thing for 
> our purposes, so I have been working on a workaround implying udev 
> events and executing a modified daxctl for switching a dax device mode 
> or even removing/destroying it.

Yikes, no, lets not do that. Another thing we can do from the kernel
side, in case the CDAT is missing, is to never attach device-dax to
address ranges within CXL windows with the "Device Coherent Window
Restriction".

[..]
> > It would help me if you can summarize what you did and did not adopt from that
> > proposal, i.e. where it helped and where it missed the mark for your use case.
> 
> I basically took your patchset referenced in the RFC, specifically the 
> 19th one, and tried to work with it from a pcie/CXL device driver. I did 
> debug all the problems precluding the CXL invoked function to succeed 
> and applying those changes from previous patches required and not 
> committed yet. Patches 7, 8, 9 and 11 are based on your patchset, with 
> just some minor change since I did not see a reason for changing them 
> after studying them. The other patches are those fixes for having a 
> Type2 finally able to create a dax region and map it.

Ok, let's not add dax region's for this case, but the rest sounds
straightforward, I'll take a look.

[..]
> >> The reason for adding such a Type2 driver instead of changes to a current kernel
> >> driver or a new driver is threefold:
> >>
> >> 1) the expected kernel driver to use the functionality added is a netdev one.
> >>     Current internal CXL support is a codesign effort, therefore software and
> >>     hardware evolving in lockstep. Adding changes to a netdev driver requires the
> >>     full functionality and doing things following the netdev standard which is
> >>     not the best option for this development stage.
> > Not sure what "netdev standard" means, and not sure it matters for a discussion
> > that is constrained to how the CXL core should evolve to accommodate
> > accelerator-local memory.
> 
> You know I could not add to a netdev driver just those changes for CXL 
> initialization, then mapping a CXL region and doing nothing else. Such a 
> mapping needs to be linked to something inside the driver what is just 
> under development and testing.

Ok, you're just talking about pre-plumbing the CXL bits before getting
started on the netdev side. Makes sense to me.

> >> 2) Waiting for completing the development will delay the required Type2 support,
> >>     and most of the required changes are unrelated to specific CXL usage by any
> >>     vendor driver.
> > Again, [2] already path cleared the idea that early plumbing of the CXL core for
> > type-2 is in scope. Just need to make sure this effort is focused on general CXL
> > specification use cases.
> >
> >> 3) Type2 support will need some testing infrastructure, unit tests for ensuring
> >>     Type2 devices are working, and module tests for ensuring CXL core changes do
> >>     not affect Type2 support.
> >>
> >> I hope these reasons are convincing enough.
> > I am happy to have general specification discussions about core functionality
> > that all CXL accelerators need and plumbing those ABIs to be exercised via
> > something like cxl_test.
> >
> > I expect that cxl_test only covers coarse grained inter-module ABIs and that the
> > fine details will need to wait until the accelerator specifics are closer to
> > being disclosed and the real driver patches can start flowing. In other words, I
> > am not keen to see QEMU used as a way to proxy features into the kernel without
> > disclosing what the real world consumer actually needs.
> 
> Sure. FWIW, this will end up changing a internal driver mapping HW 
> buffers which are now based on PCI BAR offsets by same mapping based on 
> CXL region mapping.
> 
> This involves, PFs and VFs, and because CXL is only advertised by PF0, 
> this all brings more complexity to those changes than could be expected.
> 
> I think taking the CXL core to the support needed, hopefully based on 
> this RFC, should be started as soon as possible instead of waiting for 
> our driver/device to be ready.

I agree, but continued transparency on what the CXL use case looks like
in the final implementation helps make sure the right upstream CXL
mechanism is being built.

For example, just from that insight above I am wondering if we need some
centralized interface for VFs to lookup / allocate CXL resources from
their PF0.

[..]
> >> Type2 implies, I think, only the related driver to manage the CXL specifics.
> >> This means no user space intervention and therefore no sysfs files. This makes
> >> easy to avoid the current problem of most of the sysfs related code expecting
> >> Type3 devices. If I´m wrong in this regard, such a code will need further
> >> changes.
> > Not sure what you mean here, I am hoping that sysfs ABI for enumerating objects
> > like memdevs, decoders, and regions "just works" and is hidden from the
> > accelerator vendor driver.
> 
> If a Type2 is fully private, should be any sysfs files about it?
> 
> AFAIK, those files are mainly for user space able to create memories 
> joining them, or for changing the dax mode. What do you think a Type2 
> needs through sysfs apart from info? While writing this I realize I have 
> not thought about power management ...

They are primarily for userspace to enumerate resources, and they
provide kernel object names for CXL error events. For example userspace
could generically map a CXL switch error to impacted endpoints without
needing to know or care whether it was a type-2 or type-3 endpoint.

[..]
> > If you think we will still be talking about this driver enabling in September
> > I would invite you to submit this as a topic for the CXL uConf.
> 
> That would be great!
> 
> If this RFC work is integrated by then with the CXL core, that would be 
> fantastic, but the CXL.cache support will still be pending.

Sounds good.
