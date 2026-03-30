Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70AD3C07A;
	Mon, 30 Mar 2026 21:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907931; cv=fail; b=lGDR7drqseq0VlN2cWKgab+bGrnD51DAX0yNSodGnSjilJzVewi3uDgxAaEiPpEbtygRf11FGEuedOldh+pg+lhpBSLjZfOEW0yfDh5N1kTA6T/Lq+c1Yym48vp78Y4RtyIbuG8J+RQIM1JoqD9Bb9rQpF4jp0mw+rqhNeQ7/T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907931; c=relaxed/simple;
	bh=ZzsOlf9OEyGlOjrvDBNFpfimwuG/0mutU7ybZ9qa9Yc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=DYHsBisQuGJpzqz6KihAkJbBzBh6g3nbMoAv5Yt/0HPzQwyeUOtuECNv+uw1U8QMnG197VuafDT8JGr7XFv9CvDm2dKFjIrg6oViDY6jUUcOBIlEYqVDwJJdFhTUry4nTGVqa8tZ7Lm8lYM6YcWPiEMvJTEFGcpSgVTuKusS0rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGRkDrmF; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGRkDrmF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774907930; x=1806443930;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ZzsOlf9OEyGlOjrvDBNFpfimwuG/0mutU7ybZ9qa9Yc=;
  b=MGRkDrmFsSjHlaG/QEaQVc1atUImhDW4ucWXOs4KbuvABYx9+HW/iX1m
   UyAMugcmBAY8a1ZxycrQ/ovWC+q1rD6nxMz/5UKN8M3IazMcwtisCO1QZ
   4etvTfqOjtshEiJdXPDueQYriyIclsSR8CNvmhptQVI7rMLgi4z+s8iU5
   u/JxdSU1qefwHagvwUjqeUHWvpXdnj3Esof5bBQOBdaQ/eMjm4ORu11Ec
   GHyhIizE23XSCZavXubDVIUoc77QL1QYEOaeKrJlyckG0s5nyjVI+oZ9I
   JpFD8mkXKiFllOiPRJJVFISLLnbkDEP3NqhlI/Y8g/YglD60GdrrpN79+
   g==;
X-CSE-ConnectionGUID: vHsldZxsRj6AbEXsgoQPHA==
X-CSE-MsgGUID: pABzRcHwRci10OrrqpRmGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75798375"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="75798375"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:58:49 -0700
X-CSE-ConnectionGUID: ceZFENreQGWtQtf8v9UeKw==
X-CSE-MsgGUID: OcgXiUMMTemy90gVanXJVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="222862670"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:58:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 14:58:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 14:58:48 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 14:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdXdyOQHqE7ic6pbpozdbL4WJZIQ0SpmPaodHxtWzYP1p4KGk5mUJXL5yVfN5qjtr90bH2M0HGHIaIfP8BJtWRWrEofF6dGKfx/faiEYr/6EQ4bpqWhFqq8/RQ6TSm6xI467kSZjSpXby17Q08OGl5Vis/8Kyyui/x+j2hbU2M5CtIc9lXxOr9Xh7UY3GDWN0VLjiYcs+cTzCzgzRI8fJkPVffjEMWTR51G+Lluzu342a4QsG4/bkd4eOAmItBQ391idE9gw6uIUp7dwMvGyS2R9rxo5b6UF5A5YdujB+qz4E8mHq5uLT7o1mVvx/qYquYBFB/4VXCQkchzPNWjrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aoI1aLenX/tI+Z6zj+oaNvCi1cwoRquC9adKgq3A+I=;
 b=Bo5Yr3a5SrV7Ly2GYSeCHE7LkVN9j/eHnubHfHKfwWTkGpB3Fw9dyOi2QO8dSrVofa1cctV4ZNf+9r5zX9vYdMVAZK0KbbiU0pAgoE1qOiK7EQAFd8zGT78eWTMHrKu+b+Cr3YwIdFR2io4jALQxj2OYcr8ckT5D/u1orfdwcssG3bXYjhTcm6bIVGenV/2pRpUMTS3LpMOVIo8yEn9jy91O819wBqs894rPDRkbG+qt0La8zEmQX24s+pBDS4XWjTgoqadJXyVRcc2ABMoSZlkpYmsqetp+RKIj2/D2Eqg5faJDqtyQ2sP30fniJUVDYpv6j4+Ssv1VPnF07fph9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5275.namprd11.prod.outlook.com (2603:10b6:408:134::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 21:58:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 21:58:46 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 30 Mar 2026 14:58:44 -0700
To: Sungwoo Kim <iam@sung-woo.kim>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Ben Widawsky <bwidawsk@kernel.org>
CC: Dave Tian <daveti@purdue.edu>, Sungwoo Kim <iam@sung-woo.kim>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Message-ID: <69caf2141dd3d_178904100ea@dwillia2-mobl4.notmuch>
In-Reply-To: <20260330130156.2212694-3-iam@sung-woo.kim>
References: <20260330130156.2212694-3-iam@sung-woo.kim>
Subject: Re: [PATCH v2] cxl/hdm: fix a warning in devm_remove_action()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0281.namprd04.prod.outlook.com
 (2603:10b6:303:89::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 5970bc35-2391-466e-ce1d-08de8ea783fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: hlqyg+GxjlmjdL7xN24KcqXxiLmZngN1qNILExE6PT1fX2irZyQIrz1XMz3qLJr+QK1rmghn2WbXCwD5S/6embMHniDOgQU8yUG15lwIya83iW85N8mw6AMsSIWj2l3yScBemhra0E0FE0ucUw9Ae9ShIRhSsgVprgjUaSwn/SzKIZHz2DSTb/m5tjcu08R//nI/bhEev/HDkt9GKKur6jRfarpH7siKMDxTK7+AS8ysnCdVxcFMMEK3OIJmMuNN9pCJYQ6a/DCO3l1/7J9gl5f9540mrwDVSNvKuXVvgUHetBpYoLpOu8HM4l13fTd/MMRsuFuZFqgku03j5HuEPFpphRO0xfRe+logv80PE4YwIyUVPezdqFDrM2ivF82Pmcoxj5fLl3vDfZKcmxxaA+lD87SKCtsVAkxB0wISawOeSJqzA5AvNh5xhMSNl1s0B8vvdXaKrdQOngBsAT9yYKlw1D8dWas7/HWX9KkDZmlXJdSu3AJcoxi1r3dBCrmUZxavyV1TzbkQrkScTzKAPQ1doLXYdIawYIJPlD97Z138URrRT28wb+NtYs4wBMma3KTbIyB17zs1lozh+FW9i79giksvnfH5BMqAolVgFKvbBguzxC882H7snHhRQRL4kjDoQuZ6N5Bl1QxVIjXasdZncfdoMec+BltggEaB0WQrhI3YJjnflUDTvAKLB7f7QPWVONZjpxLsMIwcDfhUUyMcOZ3vGABA0REhJg9HujoUEjN8AuAC+BC1Vc3PWl8s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFNUa21TN1FMWDBUNG1mOEh0aytjSms1RFJZckIrU1F5K2xaZ3lvNlMzVEY1?=
 =?utf-8?B?V0l3T0c3SE8yUkc2S05sYmRVK2FkSjFLN2NrNDkzQUswMkdna2tFZ3RlaFlG?=
 =?utf-8?B?a2RwM3AvRjJXWTRZR1ZWQnp5SjRzM09Gcm5LZDd4T0ZQdFNNUjRiWFlISUkz?=
 =?utf-8?B?TDFZZndQQWpGK002WFVUSWxSY0VWS1hZaGo0eW1KVnhkOHY0TlgrWW9hRFhN?=
 =?utf-8?B?QVJWbGJkak9ZYTlUREdFU1h5NDd3WDgzbHZrMlowUmRnVnJPWkQyRDdUL2lr?=
 =?utf-8?B?dm5OUGFSUTE4Wm9LUTJWL2U2Mi9UN1BRMG50akZZK3A4eDJ3OVh6R05FMUxl?=
 =?utf-8?B?QkV5ZlFFT3NCQ0tkZWI0N2RxL043SzlUcGx4TjNsUFFJRnRQT1YrMytPMG8y?=
 =?utf-8?B?em92NTZCZVVBVFNqbkZjNVArMzNSMUZHdVkxRXhiUytEQTJybnNMNDRHZHBO?=
 =?utf-8?B?aHVhM1FQcHJER1dIM2Y4MENvSXBjWEcvY2FOWXFUeWJQMEN1eStvVWVESmVn?=
 =?utf-8?B?VHdVVDZIeld6b003UyswOHBPSG11eGw5dkdKMUlpR1NZWngwQmZHWFpCamE3?=
 =?utf-8?B?aXFYbFpmUnhXVU1yM0hTNTNFVW5IekVTV0JOcEJjU1hHTjJ0NjMybHBlMmFW?=
 =?utf-8?B?YWFpdk9kNjBIcWpEVFUyQXp2dVh0NUFEZEZzUDJ6YnBpV3U4NmlQdjhCbUl6?=
 =?utf-8?B?QTVBU3RvQnBnVnNaUXZMT1ZVK3NPNzNGV1lmM09qSnNISi9aSjh0ZlB4ZmhD?=
 =?utf-8?B?bjVNNVlsK25yOHBNQmFiUGtpMUoxcFF2N09STE52ZWwvdkRLbDlBUmZCUmVh?=
 =?utf-8?B?ekx4VHBuR3U0SHErNCtXcnYxa2MvamFCQloxSEpxQjhpaHFJVExJT1pWMzRw?=
 =?utf-8?B?M28xUTRDRzViSXhmQU8vM2VDeW96NlRhZmNXeVRUWXhLdnl5dklXbUs1Y1BT?=
 =?utf-8?B?ZjhSSVIrRExQZmVuNXMxaWo5aXYyd1ZlUlc5MDlEKzhWZ0lhUDZKcDlMN1hL?=
 =?utf-8?B?bVI5UDB6cGkxb0tDbS9QRnM5Z3hzWnpLVkxJZ0hpbnpERTlhcWI0d2tVaTBQ?=
 =?utf-8?B?WlgwY2hrWUJPdzNvRDlORTNBbTBWZGxzclNISzhzS1RjVWVucG5hQ1ZTa1dx?=
 =?utf-8?B?eFJZTjREMmp2NWRiNUFmSFh1bHFZMWZ4MFFiaS83TlF0WWkrWVdtc0toYUty?=
 =?utf-8?B?emtsaS9IMFpvN2d3U2NnUkQzTWFyTGwySi9OZnY4V0laQzM2T0JKZGpZV0lF?=
 =?utf-8?B?Sm5hbk9JeWs5a1VPV1hVQ2svVC80NUVVOU5FbnF1ZmJsenI4NlU0UWg3WEZG?=
 =?utf-8?B?TVd3YjVOblFLMHgvU2syVVQrcXFCQ3gvY2xYNHNmNitRY0F2dDVLS2thSm5Y?=
 =?utf-8?B?WDVhYURWUnkvbWtRbmpLRWF6bVBmdGIvcTZlbW9vWGRQbmxzTXNvRlpxcU9x?=
 =?utf-8?B?dUw4L011RFl1RVdLRDVnQTFPT0haODF4UXZwZld1SFVTbEU5ZmtVQjJqM2hR?=
 =?utf-8?B?dExDUFNBdlhUMVVuMnhja0s3RmtOZ3VZbzNlc1M3eFRFTVhUc0hnNitxS0k2?=
 =?utf-8?B?L1VQVUdweWNmMDJuSG82L0F0T3VwOWt3Y0crcHRHS2R3b1RNamJCNngzUWc5?=
 =?utf-8?B?anU4b2dwdjlqYVFiYU9MdGYxVWE0SGV1OFVCblE0UlpBS0pHT3BpSitIVDVD?=
 =?utf-8?B?Wk03b0dqenM0dFJkZ0VHY1hWVjk0djYySWpDVk9BaEV6OHJpakx2ZC85cUNM?=
 =?utf-8?B?RjJDUFFSSGkrQlBpLzRuOWZzM2NWbXZqWkQ2SXBiVmNLcis1Qm5iU0dVTXhX?=
 =?utf-8?B?M0VCT012NC9IMmQ0Sy9hZWNoRnNYUi9LZFoyeW9vS1p0RlF4THRLL1RueTFx?=
 =?utf-8?B?MEtUK1kvSUpHLzc2WHBTRWFWeWlOY2tNbjlaZjdwYkJGSzBPdWVNMVcrY1JI?=
 =?utf-8?B?YXllQjlVZXY3NVM2OG5aSUl0RFVxcUYzUHoxaW01b09icS82bmVLckQxbkRT?=
 =?utf-8?B?R2dLTmdtdTU2MDVHYnlFNXZTOHFadGJlbUcveGxiM25QNWpRR3AveU12SmlB?=
 =?utf-8?B?L01rMjZkRW9iYmFVdkhjNkJ2SEJQVVFwaENOZitVMmN0TGFDSWdUY2tOSnRh?=
 =?utf-8?B?YjN0SWZ5NVlvblkzdFg1RUx4MCtVem5idHMyYWthc3dIVzM2dDY5QUVoQUsr?=
 =?utf-8?B?ZXJpbXUwUEtUdWFiaGw1YlBpN0pZSVNOV1Y3bFVqUXJWcUhEc2E4dW0rS2o3?=
 =?utf-8?B?VEI2SEptSHJPa3h5L1lKNk9pMVNaNHk5MElqa0k1TTRieXpWVTZSMnArb08x?=
 =?utf-8?B?VzIvMnFReGk1cnVqcUFiRFJKV0ZQK1pHWGZmY2NGZU8rQTl5eWZuWkhPRXVC?=
 =?utf-8?Q?ttboulNDe9L/3RtU=3D?=
X-Exchange-RoutingPolicyChecked: IHn3gUT2r3z/G+R+3KSJ3CgBWyrons8ZT3TUESB9O20SAA2vY5lh7djlHttC7NARkIPAc9S2F+osQVHPi55QctvWougQzu9se9sTpLR9wlwI0w7jno0Zo2xrSN6PeNdsXJQwUUibm0FJ6uB0Dsjxw7P6ZXM7QHgASUcUlVHTUqdUsABvNA1jtCLxiVE6NrXFPwVpKlbEPppPODReVWGHKDahbTRva8WyGrX/KtEFAQf84EcP/XFS5J6Swr3G9rOtO068NGULNK9tgy3zCDm9fLRfBXc4pClCB6U5QmAmSFWNEr8SlFz7KAN27hO8TLlsPpovZNudScPRP4scxNY6mw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5970bc35-2391-466e-ce1d-08de8ea783fb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 21:58:45.9554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DPxanynFq6FP/O3Eh0PHoxdX3TrqOyWwKIReLFT4ylll3RCiuK4N9FOZaRC27RXIAJSlYXNfkaD0UQiDS22bJN/LwBxxKgXLjgL8QlvL+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5275
X-OriginatorOrg: intel.com

Sungwoo Kim wrote:
> In the following race scenario, devm_remove_action() can be called
> before devm_add_action(), triggering a warning because there is no
> action to remove.
> 
> To fix this, __cxl_dpa_reserve() performs devm_add_action(). This
> extends the critical section that embraces cxled->dpa_res = res and
> devm_add_action(), so cxl_dpa_free() cannot observe dpa_res without
> the devres action.
> 
> task 1:
> cxl_dpa_alloc()
>   __cxl_dpa_alloc()
>     guard(&cxl_rwsem.dpa)
>     cxled->dpa_res = res;  ...(1)
>   devm_add_action()        ...(4)
> 
> task 2:
> cxl_dpa_free()
>   guard(&cxl_rwsem.dpa)
>   if (!cxled->dpa_res)     ...(2) pass, due to (1)
>     return 0;
>   devm_cxl_dpa_release()
>     devm_remove_action()   ...(3) warning, no action is added yet
> 
> Splat:
> 
> WARNING: ./include/linux/device/devres.h:160 at devm_remove_action include/linux/device/devres.h:160 [inline], CPU#0: syz.1.6464/25993
> WARNING: ./include/linux/device/devres.h:160 at devm_cxl_dpa_release drivers/cxl/core/hdm.c:290 [inline], CPU#0: syz.1.6464/25993
> WARNING: ./include/linux/device/devres.h:160 at cxl_dpa_free+0x2a4/0x320 drivers/cxl/core/hdm.c:572, CPU#0: syz.1.6464/25993
> 
> Fixes: cf880423b6a0 ("cxl/hdm: Add support for allocating DPA to an endpoint decoder")
> Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
> V1: https://lore.kernel.org/linux-cxl/20260309000810.2632065-2-iam@sung-woo.kim/
> V1->V2:
> - Let __cxl_dpa_reserve() handle devm_remove_action() to reduce
>   duplicated patches. (Thanks to Dan for the suggestion)
> - Make the comment concise (Reflect Dan and Alison's comments)
> - Make a warning log in a commit message concise
> 
>  drivers/cxl/core/hdm.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index cb5d5a047a9d..63bd0d5f31df 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -408,7 +408,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  
>  	port->hdm_end++;
>  	get_device(&cxled->cxld.dev);
> -	return 0;
> +
> +	/*
> +	 * Perform devres registration while holding cxl_rwsem.dpa so
> +	 * cxl_dpa_free() cannot observe dpa_res without a matching devres
> +	 * action.
> +	 */
> +	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);

This needs the pattern you identified in v1 and comments should be
reserved for cases where the code needs more explanation. Something
like:

/* 
 * Invoke the release action with the unlocked __cxl_dpa_release() since
 * cxl_dpa_release() acquires the the dpa rwsem
 */
rc = devm_add_action(..., cxl_dpa_release())
if (rc)
    __cxl_dpa_release()
return rc;
