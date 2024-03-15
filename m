Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F02B9D8
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519498; cv=fail; b=Nd3EjyJZjP8JfeSRmjLC+iSUCPun1UU/o8KFBX7ctzMlEzvSXkmVIgfpz865ptK6ndMzzTqhozc3eqMREDP45+97QI7RNPCO5moNaS1XE1muF7akW+5hp9LjGCqGCaal7gQBDwZj/RX+TaXrnm18sihiQfc1EYDB06+Qp3zPtfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519498; c=relaxed/simple;
	bh=S1TQmncoJy9YAfEXRrY2JdedFbW0Q0MAsDtT4UYQTx8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RcTpq76XBaxDg1Yxuf71qU6P+D7D0idnMFWG4fXHZNiNt2ewJyzuXzRLCnab93fwC6S5v7QjvNkmgXff7M9oLztC52m4ss3TmPPx6tHnWQO2g4YdTuE4SqwD24eiqbQp0TYuEklTJark0nf86ZTEysC7SpqMKA8QGImbsWnmE7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YN19CfcW; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YN19CfcW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710519496; x=1742055496;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=S1TQmncoJy9YAfEXRrY2JdedFbW0Q0MAsDtT4UYQTx8=;
  b=YN19CfcWGYZTFU6UyIeMstfhXyq6/1DlqGrhiZKSgKOmQXFm1Hh6hOjV
   /ciE+rt9O1JKZMyf9R5kq5v6/EFeHIA9mlfk7ClZZSgFf9D5k2Vo729ev
   wwhn5/11jCmKzB1YCLz7Tjz4GE6qs8hInEYCaDMY+5WwIHti54qZnM7/D
   5H76J+9G6MRXXNlihCncP9Ei7ZY0Q3apa99lWZTLCMd2JFZMenF3k7sGF
   qIWsTLoGI2snbNiUwLOmqN7L5PWZyzYin56F6pP051K4aIXnzxkPC5eOo
   zaSsNWD5/o5lHzFPM553aBpr8mvTJN6/DS8Lki7+f6yrHsK9zlzInvLfG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5240213"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5240213"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 09:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="17415124"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 09:18:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 09:18:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 09:18:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 09:18:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR53iBKEDjCMy7MYJTcuTioh0DQAhMuNLX/nRhEfudeGyHs20LgcwNGEI1h5KN64QSZevmfH4xMNX43wD5o4NnRyUxFPnAEuk3F0+fAHGKSZaGEv5ERPFMM4OmIFZoFD6TH2x8NyGSGn5AGuoRZAJVBOJYxDxOzVow0O8qR/TWoLjFMck2s+O7w0M6f0IxtAu8WoaihhGLGTH5eIESXauFjJVdBAYmoqd/ExHWLJ0XJXjtPFDkxTR+OQuO444RH0MDGVX5PfU/hJqUIooMtg4SSzPgWJnJxUMLNIyt4vryo3MLJOBRPZSWSZxLB3XuXjlJmsjHgiHoGPMlyYGNNMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wq8vcCJqqcUGEFWP1h8jgLTBtU0PtC7AYdPVT19AYyI=;
 b=IcbZYhaEi2kPZMofi4BmT/VrMi3i594A+0dctRAJ/qOAnRv+MUbKoF1e/ShM48NTBWa3GKY38I28ieOL+e+F2j/MeFIM2idIVJSrG+RQOtUGWw6FVJtjBq026ha/g4ighNSg9bhuYzyPl1JLv7VvuZPmyliCX7f2sY/KchNnoipYFM4bm33JQlmSylAhQJfe8hvft/IEnzLOF7YQjm0+4ML1glp2diLklGW2QUV7kHvK4uqet8JIRxG6MJhcKu6BWfYDQPuWRkegdMFl8WIA5TRBgpoajHPaA0Sh1SRZDqA/l2Z4ewVcOvvDEwmHaLf4zY9O4THcDVoQH6aEsZdJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7878.namprd11.prod.outlook.com (2603:10b6:8:f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Fri, 15 Mar
 2024 16:18:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Fri, 15 Mar 2024
 16:18:06 +0000
Date: Fri, 15 Mar 2024 09:18:04 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, Alison Schofield
	<alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/trace: Properly initialize cxl_poison region name
Message-ID: <65f474bc214eb_aa22294dd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240314201217.2112644-1-alison.schofield@intel.com>
 <20240314164136.6d10aa28@gandalf.local.home>
 <ZfNmfCmgCs4Nc+EH@aschofie-mobl2>
 <20240314171737.2025ef60@gandalf.local.home>
 <ZfN8AP/KdbsN32l1@aschofie-mobl2>
 <20240315064703.2202cc69@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315064703.2202cc69@gandalf.local.home>
X-ClientProxiedBy: MW4PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:303:b9::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: cbcbd5bb-34b1-469a-16c5-08dc450b7f72
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/0jhCJUBx+mZebihvp92VxTLRnysFHu/4QMCvVRYQgzNgvA0hI1SaxShk8n3TqNzNZ9AGFs+MEv8fcnQ+o8pN7JjqnwbJzHwSt0ZJIFhs+EO/Xyc0fvpcFmC63VqWf1FjD7KEhjUxIrrPQwPLNx19B36ff6Lx0laMqicoKaIeKL1HiYdGJgEQgVMJXaVUYGQBDtEI0qurNJkr0nVJhzWjOAVK/xV+Fws8NFrHrHYQrCsoVJ7FDl6MYrrZe4kL1pomzDWq4lGRdgE0oTaBKtrwTXsGu/kag02A4jHxYDfweia/DeUBNR+Yat6CN2vqT6IuwR+rS+UJyEVBjtgLwt5zZ7EkCeaOgVo6IgDTWZX8M8dw0wqgvuJl3zce21Qo73yPhU4wNJ95XCjpxbGKulUubl6WK43Mpm+yLG8Id26hfMpK32c0C2ffiIZM4AyzSzUTmOt9ep6VQZw4eQ7wWcA/7HX2N0oW4VRkE6RJfFuVPaiV7P4kU8nZkrvIORscLrfDS1rzGmA4O61XY+6GHq9URRXq0bm+ZFsCZ0mFDNsY5ld+R/nc2rTxhVArwdu2Z+i5ntD5IBeYNlNiq9w3EIqrOmcgSmRGEocVkzMp2o6aI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azRkdldRNTBQT3V3NStkUnozWFdwVkcyWVJNdklVUExxbFdYYzRIRmxIcyt5?=
 =?utf-8?B?VDk2NEZXTy9XaHZBOG0rOXpVb3NEL0JrT1VDSDNnQXpTZ0JWazRLWXlGLzk5?=
 =?utf-8?B?QkdtK0lReFpjR2pZcU9UeGtUQVFUQXJoRENoc0syMGJLSFdGR0NCdlNiMHcr?=
 =?utf-8?B?K0l2ajIzSTZQSXNjOEtndEZIT3VONmZjaTNja3UvQ0JKekpORTZLU3pSVU5z?=
 =?utf-8?B?WU5rSUw0U2ljdUw5eUdBaTU2OHN3RTJjYm5TdWkrbEpNcG5jTlJxZEZzN1hw?=
 =?utf-8?B?UHI5WlZoR2VjbHIrbHFXVC9oOHplQ0c4VkRLV1c5VUpBVUhDYXZ6U05uZnNJ?=
 =?utf-8?B?ZUJTVkpJUDBxSWNnT24zUW14Umh5Q2tMaCtpV1ZMY01hOHNKaFZJQmhlZkhl?=
 =?utf-8?B?MjlCMFhHMVIzUWxwU2NnTjFEYjJBYm9QT3BMQklid1duV05IYXZWSGUveXNB?=
 =?utf-8?B?SGlrN09UY3ZUZVVwd3BNOUN5UjZmQmlvNXcyM05JcWxkb3BRZS9PdENUOE1i?=
 =?utf-8?B?bzZONWxwbHN6OHZFU1VvK0FMRWZlUlJKWXRuSXVvVE5ITGNIakRZUXNLRHA1?=
 =?utf-8?B?NDJLOFNSUEpmOEc3MU1tL3huZFM1WmdXcms3L2VFVnlYMjcralJ5Z0Z2YUNF?=
 =?utf-8?B?SWZKQmVvS0FoZnNTdFlPblFZMDlBMnZXTkZLcHdRRlNZSGUzdUZaNStWcm9t?=
 =?utf-8?B?eFZyNFYwaHhKVGFFSmpOM0NJU0tvUnZUdGQvaklzZWRxQy85bEJ1WnJodXRj?=
 =?utf-8?B?bUZZMHZNUHREeG0wMUF4aW1NMFRVdWJCQmY2bUVlTHFldm9hS2Q0VC9HYkht?=
 =?utf-8?B?MTQwakZWOWkvd1NrMlZTRm52OW56MzlGMndndlRvNUlWblNpMFFYTTBoSGpr?=
 =?utf-8?B?NWw2V1BLZkpJSUFxekZnK0xJbFo1cGVPVDdhK1BDVlp3Z0dLUUtMWVd3YjIy?=
 =?utf-8?B?RmwyYm40cnFuOWl4eTJZMDVCN2xtcmU1VnhnT2tIK0tvMHhzckx5dXBOWUNl?=
 =?utf-8?B?YUdLc3dRMEpLM1ZTVVkwRVlVMGsvTXgzY3dGOEF1eTkzZ3YrRSsrSTU1cldC?=
 =?utf-8?B?NDBJcnIwMjEvYVprYXcxY0N4MjZ5dFN0bTZLdnpmWEZFMzB6cCtZT3pydlhQ?=
 =?utf-8?B?UksxZ2YwRVN3NHVFR2RHTmRpdTlwVHViTm5hbWlJTG83UUNlYURQMEU2blJM?=
 =?utf-8?B?cmhvU0RvVERlMXdaQkkyb0xhby9aaStaUTAvRkhtOVpQcVB3amVaY3FFd3pa?=
 =?utf-8?B?eDhweFhNQ0lOYUJqVC9jZThRam5URWU3M0xGR3g5WDRPZTl4Rit5K3gvQnAy?=
 =?utf-8?B?b2ZxZ01IYmpGalV3aTlqSFZiMmhMcEpuU0pZeXRERElub2trQzhGSzY5eTE5?=
 =?utf-8?B?bGVzaGNWdFNaeWcrQmszaHVLejlRRUYxNS8rUEpsTVBlSWVVenVXQk9wdXB5?=
 =?utf-8?B?RGJkZXN2eGFhc1JLRUFSb1UrY2Nzb2cvSENSTk8rV2R5MEJjcEQ2U1dWY1pQ?=
 =?utf-8?B?M2xFckpGRTZ6U0hVRkVZMkZmOFVBNFM1Z3h2Tjg3QUpCMysreWNnR09pSTFI?=
 =?utf-8?B?dk5GU29BSkNiRDV2Q3k3VVRSaHg4UzVrYS9ZeWt6OU9WZ1lDY21IQkduMURL?=
 =?utf-8?B?YU9oWTMvN1V0SW5GcFFLa2xIbURnQmxnTDJTd21vUFRSZ0pSVEIvaXJIY0t6?=
 =?utf-8?B?L2JJRG9IRnRGRkhGZ0pwN20rWmozZmJSUEVySzNUamgwOVhya0VMbGJXbzZR?=
 =?utf-8?B?NmR5Q0dkbmZIM1Fkd09GaTVzakw5MW5rYWJQWXZTVXV3K2JhNEcxYnRieGF4?=
 =?utf-8?B?MW9aQXZQcCtqTVM1eXBoTCtFTkJOWURyZlZ3ZmozdnVYWTVWUFl3SHgzWVRt?=
 =?utf-8?B?dVZ2VkdtNER1cVlMQzZwQkJaQXFlZGlQeVY0WVVNanI3cm9COFFJWGhaVGlU?=
 =?utf-8?B?ZWluVFJsNCt2TXdVTXd4V3R4S1VEeXh0cXNrc2ErQU5BZVc4aVBRYVdkK3Uv?=
 =?utf-8?B?MEQxSGRQY2pjMVJzazZPRVdXajVDc0hDa25MUkJQd1dpdmZzV014dVRDMjRO?=
 =?utf-8?B?UGM3S1hHY2pjUzhZSnZyL0xPdGZoN2YxM0x1a3B2bFZ3RUo3dkIvMGs0WGtG?=
 =?utf-8?B?aWhtbU9XaFNTZWZWcjJUMW5kNHNhWTZYSXRHcDVxblJ2SUpMVmZ5bDhLdmNX?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcbd5bb-34b1-469a-16c5-08dc450b7f72
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 16:18:06.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ma++F+6E8wqMjZuQJBy+szXTY0tCNtnXfMjA+i+19SN0vzBBpYBQOsvLlVWvwuvsuWyYzVth99n08AHkr3c7Q5NAlhRgqu4dQgiWmmYbSh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7878
X-OriginatorOrg: intel.com

Steven Rostedt wrote:
> On Thu, 14 Mar 2024 15:36:48 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > On Thu, Mar 14, 2024 at 05:17:37PM -0400, Steven Rostedt wrote:
> > > On Thu, 14 Mar 2024 14:05:00 -0700
> > > Alison Schofield <alison.schofield@intel.com> wrote:
> > >   
> > > > > I'm still curious to why NULL didn't work. I guess it may never have as I
> > > > > noticed there's nothing else doing that. There are cases that a variable
> > > > > returns NULL and the __string() handles it. But I guess the compiler gets
> > > > > confused if the NULL is a possible return to the condition in __string().    
> > > > 
> > > > Here's the full warning spew:
> > > > 
> > > > In file included from ./include/trace/define_trace.h:102,
> > > >                  from drivers/cxl/core/trace.h:713,
> > > >                  from drivers/cxl/core/trace.c:8:
> > > > drivers/cxl/core/./trace.h: In function ‘trace_event_get_offsets_cxl_poison’:
> > > > ./include/trace/stages/stage5_get_offsets.h:50:21: warning: argument 1 null where non-null expected [-Wnonnull]
> > > >    50 |                     strlen((src) ? (const char *)(src) : "(null)") + 1)
> > > >       |                     ^~~~~~
> > > > ./include/trace/trace_events.h:263:9: n  
> > > 
> > > The full warning didn't add any new information. The above was all I
> > > needed. But I'm curious if you applied this patch if the warning will go
> > > away. (Note I didn't test nor compile this).
> > > 
> > > -- Steve
> > > 
> > > diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
> > > index e30a13be46ba..dfae18d8f4df 100644
> > > --- a/include/trace/stages/stage5_get_offsets.h
> > > +++ b/include/trace/stages/stage5_get_offsets.h
> > > @@ -9,6 +9,13 @@
> > >  #undef __entry
> > >  #define __entry entry
> > >    
> > 
> > +#ifndef STAGE5_H_INCLUDED
> > +#define STAGE5_H_INCLUDED
> > > +static inline const char *__string_src(const char *str)
> > > +{
> > > +	if (!str)
> > > +		return "(null)";
> > > +	return str;
> > > +}  
> > +#endif /* STAGE5_H_INCLUDED */
> > 
> > Happy to try it out...
> > 
> > Your diff, with the ifdef above, makes the compiler happy and it functions
> > as wanted - no garbage in the fields.
> 
> I created the patch:
> 
>   https://lore.kernel.org/linux-trace-kernel/20240314232754.345cea82@rorschach.local.home/
> 
> That adds this. But now the kernel will not build because it requires the
> fix of this patch. Otherwise it fails with:
> 
> In file included from /work/build/trace/nobackup/linux-test.git/include/trace/define_trace.h:102,
>                  from /work/build/trace/nobackup/linux-test.git/drivers/cxl/core/trace.h:713,
>                  from /work/build/trace/nobackup/linux-test.git/drivers/cxl/core/trace.c:8:
> /work/build/trace/nobackup/linux-test.git/drivers/cxl/core/./trace.h: In function ‘trace_event_get_offsets_cxl_poison’:
> /work/build/trace/nobackup/linux-test.git/drivers/cxl/core/./trace.h:660:34: error: passing argument 1 of ‘__string_src’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>   660 |                 __string(region, region)
>       |                                  ^~~~~~
>       |                                  |
>       |                                  struct cxl_region *
> 
> I like that the patch also catches other bugs where non strings are passed
> to __string(). But I can't send this to Linus if it breaks the build.
> 
> I'm breaking my pull request up as there's some other places that break the
> build with my new checks. I'll do a pull of all my updates first, and after
> Linus pulls in my change I will base the next pull off of that merge commit.
> 
> But this requires that this fix is in Linus's tree before that. If not, can
> I take this fix and add it to that later pull request with all the tests. I
> want to make sure that the kernel always builds.

Acked-by: Dan Williams <dan.j.williams@intel.com>

...for you taking the fix through your tree, and yes, please Cc stable
on it as well.
