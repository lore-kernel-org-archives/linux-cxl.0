Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB031FF615
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 22:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738620574; cv=fail; b=mtAT5op3qsjWWw4o9jMcme82jwWtabdpSjtVJZZk7Tbh1rcTb81pdUhF+JPwwdOI4njNyEVZKDfmtcFpU8jITSqftzRIS0iRdzwEnm9KzSuCViVv9+WpO1g0C02zc8RueZSeyoJPt9AzxkGroQauExrp481kwz/xm7wmTe4A53k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738620574; c=relaxed/simple;
	bh=Ax6+JBdlC0faQCuVbsKSfDnlTFoEtXCZLgdiM+rqs+Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qhC/6wW6yjjPgn9AOeZ0l4KB0CPa7myy4mF36hpUhFP+DA2Uzp2ZV2tpW5o0xo89gjn4/1KbQUmO5oo8I2XKsRarYVpjxIoFDfnLHmTJ8HKWQRh0ziV7+fH54nLl6LSyhHEWjSPVRYcnJBJRimGrKZgHtYetu3p6l7mkbpO3qZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KnNK6Agj; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KnNK6Agj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738620573; x=1770156573;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ax6+JBdlC0faQCuVbsKSfDnlTFoEtXCZLgdiM+rqs+Y=;
  b=KnNK6Agj7Tl/HVUKz2SjIDo6t4TeaSJBW4KlUbtP/JndGMUh6SBkwATF
   YWjsZcG+y3UmgojeoRW3KBfhdAzgQgE6UteO21FzkYJdYKPgTScO0XUgj
   Ts7TEJkYkf09TwM9P2oVjTsM+TZNmx92JIZwX1UV6dBWGYe4nnChKKX9y
   lFihaYbxaKD9Gfv5Z09PpEylimSUBZpfKCbZGdeHJg0cYxiM6VRKpjWjR
   odZtWUpbPdPtuwyvvTr7Q+2CtpMnzbgqdMuQkXf68JxS+r1+xz92MQhWp
   jbwMxxm9KstlH1SQ+5jZZ+ny3o+cOF/PTPCkr7vedeXV6B+QMbLW5vjn3
   w==;
X-CSE-ConnectionGUID: 4ugOR+JHRnefLQsyYDXlXA==
X-CSE-MsgGUID: Gqch4bSvSjqkLl0d0l4GYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39230740"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39230740"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 14:09:32 -0800
X-CSE-ConnectionGUID: aH41XkkzSkapX2cZ1HXKeQ==
X-CSE-MsgGUID: 86aOwcJKS3yhddVTWdTxDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110878691"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Feb 2025 14:09:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Feb 2025 14:09:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 3 Feb 2025 14:09:31 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Feb 2025 14:09:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkJo5ipVDQgfILfyFb2aSuOuTbFpCbw4AgU8+tG3S+q/Qr872ZzNBd8ElKQOWxSDEXapGsI7ckeyitXvlpVlMTaPr4QYYTlrcFdTpYrueVWOZOi8Md3DVdfXgr18GGkK2wFnqlyEQ+cdo9bz6J7CNUiOybub1q4bvKoCm7Y9mR9JIzrixRsUiOkTvce1G/g0r0OnFvUM0/IXS20Mlo5haWPtmWBFr8Px4MFdfnOSjObZZX4J6KiAuWwRGNbv4sdVlTaSCvk62SceYkQr5AVyfsLWpMmss7EbmBLNEKekoq9K9NsoNLE5kT/hyNDtms8eugo2/zcI/oat+wFRH4R9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0VNQl6RsRkPkEzIX89Ia9MCB09F+zQD9ebULywi2ww=;
 b=RFRf7AfaZLei0pfTyfhD3aK7uBPorMsTXhKApXMEvLyBMOINzxDWP/lGR+kAnCMmk7Uc8M21sk+2xaL1eZTRZCeVWcuSXjqBmNBHeu8dghldccfpMOGK6Zr/zEspqeX0/x9SLwlPBiZ5H2iWIyMmpXjhYDffD008+seQvrtPm8Mvh7E/VvwdQgbRi85B4cQz9NvoYJ6aOSpZoA2VdltwPQkeKLnUDU931TDG03xVpQwkcrWAiGmQiilgn1zTr8NdvyAkYB13k0zkNrLW4EKTrClZyRRFE1S/2+zXuoYntBnBXYk6JG/VQCDDd12u9JHiqx2dyGfE2ZFMzFvwYxmG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7778.namprd11.prod.outlook.com (2603:10b6:930:76::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 22:09:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 22:09:28 +0000
Date: Mon, 3 Feb 2025 14:09:26 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>, <lsf-pc@lists.linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>, Byungchul Park
	<byungchul@sk.com>, Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <67a13e969daf_2d2c29412@dwillia2-xfh.jf.intel.com.notmuch>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <CAB=+i9T15XXbbZsvz2sg7JQNOVjaHzpj0LtCW9QtOQfwqq8W_g@mail.gmail.com>
 <Z55MILLApIoPh0A1@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z55MILLApIoPh0A1@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: MW2PR2101CA0010.namprd21.prod.outlook.com
 (2603:10b6:302:1::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 27bfeee0-7a82-4a53-2b2c-08dd449f6d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGtYaXlFdGJCT1NCeTlGNnAzRG9taldkZ3RBNTAyQ0hmaGdvUVpaeFlqMmhI?=
 =?utf-8?B?SmlPeVNXclVOQ2NzK0NNZUxpU005S3JCci9ZWmQvY3BYUEluVGV1Y2J1YVR0?=
 =?utf-8?B?WU4wWVRwUnhZWEc4UmNYVkhBZHlPSVdtV25XbjRyQjJ0ZlAwTDBLK1RCUE13?=
 =?utf-8?B?NmptUTZFRU8xRVJweHNoby9MR3ZjME9NUHk0Uks5VG4yMVFhd2NWZHRTdit6?=
 =?utf-8?B?c3NEa2FMclZBWWFubnBzbENiK3ZqU2dYTDRnZkxLNXFnSG1OMHZuOTJER2pn?=
 =?utf-8?B?L1Rab0MwYzhDamdYVmFBc0hiTXE2Y2w4TVlFOFdFQnhtSXBMRk5yd2xXRk0v?=
 =?utf-8?B?eEFucDJxdTl0RHk0cldtMmhWRG1KemJJaWw1MjU5VEQzNEJuZ0dvRERPcHNF?=
 =?utf-8?B?QkRXSFpCZTVkOVhxZ0V5MmQ4TmxNZGpxaTlXV1Q5eG1icXFyYkN6R0tURndV?=
 =?utf-8?B?V1dWNkFrVnFtUkU1Wkh6MXZjN2gxQ3JKeXBocU9hZ1NMNnBpc0FRSHJGcEMr?=
 =?utf-8?B?ekM2VnBTMFFNdmFnOE1PODUvYzR0SnNZL1Z0c21vYzRNdlNrTDBXVDdFU2ts?=
 =?utf-8?B?Nk9qV25OK0dhNGFsc3NJL2s4Ni92dCtUMkQzOTVPcW1RZEJ0RVUxOGg5c01p?=
 =?utf-8?B?Rlh3WVJvRkZlTkNrOWc4ZnJUK0luOE5mMHVET1RGK29naUhyYnZ4OXFiNGpG?=
 =?utf-8?B?VXVZanJCZWdSOXJUdXdCaHRvM0xkRnJPNkFwa0pxbUFueEpUbS9nM29NUlNT?=
 =?utf-8?B?OUQzQVBpNm5DQnRDVmJUQkJMTkFhVUQ2amlUTlZnQ0wrVXRPSG9hanVTUHht?=
 =?utf-8?B?QmtwNmY1Vk42Q09iY0RrVWw5UnIvL1lGSjl3aGdyNTFkMWZ6S3BQTnJacjBs?=
 =?utf-8?B?bkNEdXNzcEtZOXRMZEdtWVROL1dvd0lCb0ZlZnh0VHVsUDdydlMrUDFhK0NT?=
 =?utf-8?B?QWRxLytYeEdSMnhZTExSRVlFdSt3RXY0QnJFQkpCcnNIMnJRZ1VrN2tvZ24x?=
 =?utf-8?B?TEZKUWRFcXNZSWZCekxZc2IydzRPaWJBdEU2SXFQbmFjaGVVUXNuVjFUT3ln?=
 =?utf-8?B?MG45MGtXZ3E5TGVGUUJlUXVVMWtWbGttdG1yekViV1VPUGlmVlM5aGE1NXlu?=
 =?utf-8?B?TlFWc1YyTFcxYWFLWnd3OTBiemVoZXBmSFMrN2NVb1NycWtQT0VRWUt1ZlVS?=
 =?utf-8?B?L3Q0U0l5NUZOU1JubXNUN09pdVJqZG9KMzRDL1REcFNCKzlHNGN0TzRtT0I5?=
 =?utf-8?B?TEN1djFJNkthRHQydUV0Z0d1dUhRK0pwNGR4TGZFMWE5bWNOUzhXcno4cStn?=
 =?utf-8?B?a3NDSnhNV3EyeXM5TTQ1Rmo2Z3UrOW1XUWtHRHJ1KzlQVWhOZ0F0cTRqN0d1?=
 =?utf-8?B?cHBJYnZIdWI1ZXNSakVLN1Q2L3pJbmsvSTNjU1NDOXB5SEtQMWpwZkUvc3dn?=
 =?utf-8?B?VGxIZm1JZks0cTJ2ZFNWaEk4UlU3MzNJRnNFRllISExqK1kwaC9KVnFMcmsz?=
 =?utf-8?B?RWRaSXNVWjg4SmFaNCszeVl6U1FYbnByVk9zQ3l1VzVqNUNTSDRCUEk0anlS?=
 =?utf-8?B?MEJzZVRwZUVydGFiU1o2blVReTRhRnRXOGNaelFVNEY2djJ4cXQ1TjBlUHdt?=
 =?utf-8?B?WjdHK3VLWXJBbUJaVDV3ZktlbXp1Sk5adkk4TkJmVDNiN0JRdHlPcmd0SGlW?=
 =?utf-8?B?Z0RvemxJSUpuVWlidmJENlI5cFRia2JsOVBYNy8wMitWanNudGpXdURrWGtq?=
 =?utf-8?B?VGNOWHNCbUdXdUJqd0dFU3ZmSXZTZkVVUnNnckFDcnJESlhIUUNZTS9UcWdI?=
 =?utf-8?B?b2J1UElxV3IvRFF5cHpGVStYeUQwY1pWdVF2U3hhMlFZMVV6L3lZc2pwVEdP?=
 =?utf-8?Q?n24U1MZaFrjM/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjJsdDUwU3g3ZEZCcWNIZnNldzE0S0R5MUFLdnhPa3Ewdk4rY2V6eDgyTits?=
 =?utf-8?B?eU8vMVZPTTE3djRkZzJZM3Q0ODFlelpnNXIvdW1WZXBIV216K2RTVzJuVHVI?=
 =?utf-8?B?c2pSRm12N2kvQ2NCb3NJaVM5N1JRRlRla1BWT2VkVG0yWW5hQU04dE9WdzVi?=
 =?utf-8?B?WVdrTG5HWkdDUVNmeUdYUjdBa0Z6QUNGNXpUL1RFK2RxU3ZTcStBU2RSdzYr?=
 =?utf-8?B?UU9XOTNRVXhkMVBsR2hZa3NpcjZwd1VCZEYwU0R5L2t3cTd0M0d0Yk5xRlFG?=
 =?utf-8?B?M2ZYR1pRVk8rRElrcXFaTksyV1FqSzJLbzRnR2JYdHZCZkNkRi9jajNVbnF1?=
 =?utf-8?B?djlHMGJMcDNhT21FQlVCemxhY1E5UUFKNWJ2d1AyQXY4ZWlRdzcxcXMwUUNI?=
 =?utf-8?B?RnRNd3p0SlE3NGlnMHBkRTVYSHZIRFpKVHVkNXJ2R3R2RmF5NjlYU1BkOUI1?=
 =?utf-8?B?M3FUS1ZYQWZtV1g1Q0JkRElpdlh6YklvZmNDajFEL0l1MDFUbzdlSVNRQnZG?=
 =?utf-8?B?YnYzSTNKVi92dXk3bFp1TmhUOWxDWXgyOXllcVhKdlEwRkxtajllcUhJRlFq?=
 =?utf-8?B?QThmbEY4eFBPaDVOOUthMDhBTWVvaktEZmpVQmdHL25Qek1aYUFsUnpiRGtr?=
 =?utf-8?B?TU9QVGtyNHF6NVN5WG5uZHVQZHRCWGIzSzR3ODhjYWVRMmJsNUJmQUdKSFFp?=
 =?utf-8?B?SGtKenJ4dVpqNXlHSDU0bldITGVtSnBWWlFjUEVBOGNaUnNvWU1ad3owTXY5?=
 =?utf-8?B?MVMxdTNYYVJFUVVKRWtpOTNlS3I1d2pJUmJsMlRTakFJSnp5NERyb2FtMlZL?=
 =?utf-8?B?V1oya3gzSVZPUzdUTUFIY1ZGbjVmVWdEVWlwYVhkZTROakUwdXQ3bkF6azZN?=
 =?utf-8?B?QUhJMTg0UEhRS0YvUkg1cmZxNllJb0hpUCtaRlpMd3NpS2MxWGlkb0FBcTAr?=
 =?utf-8?B?UTlOQTlRV2JOcnRSRTRSNDJuZE40N3dVUzZhQlVETXVYaFVSYVF1aXRyY3h0?=
 =?utf-8?B?RjQvZFNHWjRRM2d1UnJvQzh2WWgxQ2ZsemVwR0RvRWxVY2xoV1V5dGRZMzRw?=
 =?utf-8?B?OVhYbFNuWmtqa05VakRWZXlNNjBFL1FsYjlRY1luaHhkcVd4RWt5akZMVzl5?=
 =?utf-8?B?OURhOXduQzR6cW9nYVErZEdGWVM4VTFnYWxXZkpXMTl2ditNamg1RVU2TGI5?=
 =?utf-8?B?LytSb1hNeXFhWEsydWxsUDlMOU5hdW9RYThlVnk3blFvbTN6OFZuRng5UC8x?=
 =?utf-8?B?alRJYndzTGR0cll6aGRiREpGbHljRkp0dlE4OVIxdFcxd1BzcHpNcHRWQWxk?=
 =?utf-8?B?OWtGQ0ZZeUZXczNPWXpFbnlHbzNXblYzd3dScXkrNEtJVHR4eUIrVENqODdG?=
 =?utf-8?B?eFNpTk41SWMvVXNubS9YSTZ5OVl3RmNNcjhpSWxvcS9QK0l3eVN1RHp4TlNw?=
 =?utf-8?B?TzdQaFFnLzdFcFVYbXNSY2ptQXUvRjIzaFd3N3g0RFNXMFUzbjBKL2ljRjZN?=
 =?utf-8?B?NGdYdmFtNWV2bmJGb2RhYnZxcWhnZzlLZ2luNHlZWEF2TUszN3NLc1BpeWR4?=
 =?utf-8?B?dEJaTWpCZ3FvWlBRWnZlTVlwUGRPbS9ETUJYMXFsSWN5NlhVTVJ0ZDhXT2NT?=
 =?utf-8?B?RU5tNzFjMFQzTVAvU1AreFdGUHhMYzJocWY4ZjZ2S0RDTHdPQUpiVWR1US96?=
 =?utf-8?B?b3Y5Z0JpOU5UbGpNbHB4cDJJVHpNRThXSUJkOVdtYmdCYURKSHFUcS9lUVE3?=
 =?utf-8?B?Q1dyZGVDUHlRc015TGtRMEhhWE55RWVvZU94RTl3aDFncVhmRnlIVjJXZVNs?=
 =?utf-8?B?Wmp3ZFh3YmhjSzNkaWlDUDFzeUFvVnVDWkJQaDZTTWgwektLNHcrbFFnS09h?=
 =?utf-8?B?RlBuZDZnMkswcmhMWXM0WUxwN0k3M0dFeW1Rc3lVL243UUltSkVkL0lWNVE1?=
 =?utf-8?B?QnpON21XNFNBWkxlT3R1TWltNnNBWmd4b2hKeWR5a1NBMit5bEhuZjN0OWdG?=
 =?utf-8?B?ZDBxZUI5VVJEeUJWb0NGQUV0MytJYktXTHE5YU5WUE1Db2hoVEY3WjJFNEFZ?=
 =?utf-8?B?RitVc3hwZGZCN3BVS3BGZkRtdWYvT2hpaEFIZDZmVldnb3lnQ3QzelNGaEYz?=
 =?utf-8?B?YUNEbjN2QUMza0NwVzF6QXRuWEpYZVh4ck9pc2NJbW8xRDlKbUxTU2JSYzFm?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bfeee0-7a82-4a53-2b2c-08dd449f6d70
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 22:09:28.5110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnwogR4d+LtnXapTIqsuZOxHtRtTnltHLdAPkrIcnsbn4WzSwXeLQBqADom99IvLVuSX7tHnfQ4jQLcQwy0p8HQibcHBuRDU5ivggk00U8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7778
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Sun, Feb 02, 2025 at 12:13:23AM +0900, Hyeonggon Yoo wrote:
> > On Sat, Feb 1, 2025 at 11:04 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > This all seems like a grand waste of time.  Don't do that.  Don't allow
> > > kernel allocations from CXL at all. Don't build systems that have
> > > vast quantities of CXL memory (or if you do, expose it as really fast
> > > swap, not as memory).
> > >
> > 
> > Hi, Matthew. Thank you for sharing your opinion.
> > 
> > I don't want to introduce too much complexity to MM due to CXL madness either,
> > but I think at least we need to guide users who buy CXL hardware to avoid
> > doing stupid things.
> > 
> > My initial subject was "Clearly documenting the use cases of
> > memhp_default_state=online{,_kernel}" because at first glance,
> > it was deemed usable for allowing kernel allocations from CXL,
> > which turned out to be not after some evaluation.
> >
> 
> This was the motivation for implementing the build-time switch for
> memhp_default_state.  Distros and builders can now have flexibility
> to make this their default policy for hotplug memory blocks.
> 
> https://lore.kernel.org/linux-mm/20241226182918.648799-1-gourry@gourry.net/
> 
> I don't normally agree with Willy's hard takes on CXL, but I do agree
> that it's generally not fit for kernel use - and I share general skepticism
> that movement-based tiering is fundamentally better than reclaim/swap
> semantics (though I have been convinced otherwise in some scenarios,
> and I think some clear performance benefits in many scenarios are lost
> by treating it as super-fast-swap).

It is also the case that CXL topologies enumerate their performance
characteristics, "CXL" is not a latency characteristic unto itself.

For example, like "PCI", "CXL" by itself does not imply a performance
profile. You could have CPU attached DDR that presents as a "CXL"
enumerated device just to take advantage of now standardized RAS
interfaces.

Unless and until this whole heteorgeneous memory experiment fails all
the kernel can do is give userspace the ability to include/exclude
memory ranges that are marked as outside the default pool. That is what
EFI_MEMORY_SP is all about, to set aside: too precious for the default
pool => HBM, or too slow for the default pool => potentially CXL and
PMEM.

A kernel default policy, or better yet distibution policy, that more
aggressively excludes CXL memory based on its relative performance to
the default pool would be a welcome improvement.

> Rather than ask whether we can make portions of the kernel more ammenable
> to movable allocations, I think it's more beneficial to focus on whether
> we can reduce the ZONE_NORMAL cost of ZONE_MOVABLE capacity. That seems
> (to me) like the actual crux of this particular issue.

Yes, I like this line of thinking. Even if CXL attached memory struggles
to graduate out of cold-memory tier use cases, that struggle can yield
other general improvements that are welcome indepdendent of CXL.
