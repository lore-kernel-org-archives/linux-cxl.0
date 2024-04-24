Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809216D309
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980022; cv=fail; b=cvkrDkprWNGEB/o1U+x1Kqq9frAbzwuHeSFPNaCf+7CZG9IeYzcMBla6JdgB/BQpEIEne88BSf4LMb4YQGZtqO4XSWdIY7DNmCLO4FC56fmOq4Ln48BOtTgM3sdECu42Npu31Hwq7jA0fcekfywjYadgXoWuB7cKPBM+Ka9Uf3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980022; c=relaxed/simple;
	bh=HFB3VMdJSA/xuseLr43E5JPggIyRf4NMj++adQD4jHM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gq24/PuSJffV1bFr6AK4u7hi/ZBV2B62iwjusenG/vOluKvIBUiCvy4ZcwJa2lpxc2T9snlqyfoICavD8+uGJ0IJ6x9DfFtA2+r8r4G+7n+FlrcMzcca6OjP5/PghizhUBhaB83+nJcISGEQZLupXrq8CizQlOze0mLTosksQ5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djkou+LN; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djkou+LN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713980021; x=1745516021;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HFB3VMdJSA/xuseLr43E5JPggIyRf4NMj++adQD4jHM=;
  b=djkou+LNcgoVBZ81pH/5VAj2rVLRHpTtyD5Uu+aF/SLvA8REiurL3fn+
   jfToK80nShLk4ho/WEyEkUmJCQBi2dHbnJrnEIb/d5W+/95dvT50w2BJ4
   Eu2o0InSKMUe3apd5Mjskgo+PQaI8HG6xnDsAxhyjMKl+u7WReUP9kJHF
   c/4yUnut+hkLcK4srg4ngmap3Irt9vboWnQvqTB9vVjOPE044T7HTZo6V
   SZ0m1bNLsTBUPLPDHD9lC99xwi8YntYiSkovh/SpY+f/hpGCzVxqnzt8S
   uzrNSExdk044eI6tycwQqfALZHyavcog4rpBc7jlxJo8MEtgTgZVyNS/2
   w==;
X-CSE-ConnectionGUID: AI1U5rJkTLWUrcpKC7iw5Q==
X-CSE-MsgGUID: mk7XyM57TUqbOnPPjl3fbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="21038436"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="21038436"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 10:33:40 -0700
X-CSE-ConnectionGUID: Nl0RHZe9Ttq3Djz5c/0rmA==
X-CSE-MsgGUID: Dp76McFJTRqssvbOnTLvYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29267738"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 10:33:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:33:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 10:33:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 10:33:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOaKHEkAYjXTZTJ3/+ocDmzt2soanF04hWjG2D6iB5t0s2VQXBRmFt361FJUoergkfmSWgdPli82BWUhfTvSk2eN/1LvEuV+GkmrCHwuNyhk2ShTqOSOJLfwDTumeYWjid8DJd5mNOvic7848SShQSd1RUFAKeVe8VhLC/ymsgcKLaE18nKYK4cEInqSSM40gSNH4JWOGTSABt3FPlfTzU03VDmMPeochGcBQfH3eQtLRLOgwBHaUKuB229juHj5UiJg/RzgmJr44mnjj/k9AZwmhqkJHpGWRLXd+Z1zZQwtyY1WfJnit4mbxpJ3ORgWbPDgn7bTU+DTplEret3qQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/T/wl6MczSuRQTNiinhVuHtAEsA7TEVnpEDBW/BT0Pc=;
 b=Jdzn0L7iGjNvExmQw4N0TTOW/JMoQ9BE3kwPWqhwA4+UQquVgk9MGYUcXLRfkRQpXdVIysfORP6yBkH+tzTI/bIa/SWb2cQ4Kqs0sgXoHfPBE3ehS4WQw9w/+EaCbwW+kPdR8fa85UaZUd3rgOVm47mB1i343jzquA+98hLb8hepDEICyUEpDu2gdtrGt9YQeMeCAWyEkFiCTjPNyvRRQHLoy7UaBSMyvawTYAmzaE+fQwRetbPVD13lJ8lP1vB/Wk0gPnyzmcL+ik/QTogKhp7kuiJCWO8tVBuFtF+HOySIg4zhutM1CHp52WMjjCOMOMApNjlTX5bq1h6C+ljUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB8596.namprd11.prod.outlook.com (2603:10b6:806:3b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 17:33:36 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.020; Wed, 24 Apr 2024
 17:33:36 +0000
Date: Wed, 24 Apr 2024 10:33:33 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Markus Armbruster <armbru@redhat.com>, <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <jonathan.cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <gregory.price@memverge.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, "Fan
 Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <6629426dcdbb3_e1bea294d8@iweiny-mobl.notmuch>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <87a5livrdr.fsf@pond.sub.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87a5livrdr.fsf@pond.sub.org>
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: b7846eb7-d7b4-43be-3059-08dc6484ac36
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MX1wdjpsDb199Ep9RsCgJ6jlRYQvTHgIwlXbskNSiiKHjuf+712ooYVOx7Qz?=
 =?us-ascii?Q?BLsYpASrJn6I6yyWR8Lzny//vgal/n5gXz7lzQeuL0A1f+Li1SAPQ0HhwAwA?=
 =?us-ascii?Q?fdqfUNTc0DNlHdi87w9xgnZTJVuN1C8o9VbYu0t6Irz57rSvk4JjqnhbrjWM?=
 =?us-ascii?Q?Jt5Qvn9dkgbsq0kb6bVhoWcN13d+2AUEZzcfWIIhLi+ry4rP8wxxiTnSzzer?=
 =?us-ascii?Q?jksnX2I71X4mk+8+9HmfE54axiNrb9lbsDKj0UCsB8OyARSP1AFQpHtjHxIz?=
 =?us-ascii?Q?mhAAMpMdAf35u87gE/FV99e+rJiiHbTUa0HaN9AngHfFYcrLlNwkky0IsuEs?=
 =?us-ascii?Q?YAftDsUTKGgW66W2N9sTFPK10/CG1hho7Sou9dCKcycHnNuDNUtCAYcF8wvv?=
 =?us-ascii?Q?OOwvfBVB6g90rKv968xx0BJB+yyYePEqrDzGPMswPFGU3hOqRmXTlPxjF0pE?=
 =?us-ascii?Q?EkW4zVNJYPl3IlibCmNhai+vy174rOsx6iXmYHnaBomsNuzvLlfs2faXwwuV?=
 =?us-ascii?Q?gp2mVtcW7WbrIAGSuZxIcJFq5cCEznKj6BkpD80W1iBt38ON/eFtBfOLLhXt?=
 =?us-ascii?Q?133QA4IKl5Z7M+cm6OZASrWPs1TaUoiU907yNvMav54zsY6FxjVQ5MAeyM0k?=
 =?us-ascii?Q?4KOvW074Nv5huaPY5j8iG/xESLSFS+ERW0bl2Uq6qUy+MMbcCNMxX28mAuhB?=
 =?us-ascii?Q?yzxPKxCoWcsMnD/iBO9bydWcCfZrkJgopfZC9WeLE6hLGaJsAser198qCEN3?=
 =?us-ascii?Q?qYYapBNQjqi6fdslNustPhYbW5ousv3mntzkr8zc0poWyPLY3r2CBlcyeGqX?=
 =?us-ascii?Q?AhQcPTpxFKEY+fOZUYOrCQc4DlBTpdPbtrA8ZlPmTnQpCWF+zMx7DDnD/UJd?=
 =?us-ascii?Q?PCm6jmumL8eZeOPqR3AOsTl6Pd89jihkD80o7MEL5XCg+e1N9Z4ZHpQvdp6P?=
 =?us-ascii?Q?fyYwig8cIg4ToDGxokPCEV7EC4wNjOBNjnDvsVIPOtCUe0b37NHR9GzOMvc1?=
 =?us-ascii?Q?46xBTp2hZn6J40haiZu50rHri5b3SGQ+Je7Z+kOYpKxGj36djUUC7JXFaA4T?=
 =?us-ascii?Q?iLsxiZqVtpHrewUao/yMgiS5Y3xGNKDJb4BG8V7plk5hzMpeJT7KcIhZoNI4?=
 =?us-ascii?Q?GyXObv6ab8NPJEOxnZizo30s1PXVRoQS7nuAXZ8ad9lQANj+sviC+Ro23kup?=
 =?us-ascii?Q?MQvVDdWhBEqalz2+hD8yGadNScrkC9uzuKf3jFAyl7kel0NqoVO+xYbN6Jy2?=
 =?us-ascii?Q?sFhSKNBzA3eAVt+JJQB0b+1oz14tteQQA7uHZuCEbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oSGOuaQapXPyjnn/MeNZwP1Fb3N/mqF5FVZkrmQzNK34qsKanIAKniwV//Zp?=
 =?us-ascii?Q?ZHJpsgrlcfKS0FpbwJ0BVWKivknU8N06NROCy/RzO8cX1rz0skwLlp9Wz+UU?=
 =?us-ascii?Q?M0mwZppJMIsnqgtvbHDTuRBMfyE95qOr27srTEKzW7cPQd+uCRwoQGBZI/hH?=
 =?us-ascii?Q?LMDC7fPAqz8qo2To6DhLvvKDFRdGd8TKCEP9ZojybPHmR3O1LD37920xrdjC?=
 =?us-ascii?Q?KFqVDdPDFQic2gZAjPvIS44S5HvT7gISZwP4YAXQja6mpjscPXdBTE92nwBI?=
 =?us-ascii?Q?u86BP5QMfHUpERMAm4ELdAItZs5HHIZyKKvDwUms6b7ZKjvXXLngsDDuCdf9?=
 =?us-ascii?Q?60Htm8sMjndz/mksW1h2rfzuaa0fPISJyQGbXT9xb8nbHXvP3VxAeEaTmF9Y?=
 =?us-ascii?Q?De7OLUTEBZNmgoYGpPgx+qBrXIqQkCacugT8Jl75XAiEenJJcL5GiAj3DKzT?=
 =?us-ascii?Q?TghkdBIRNqoTkBQoHEUD3WKeIrENx2LAeEFGDXaMhxbHAUyMJn6neCUKVBRZ?=
 =?us-ascii?Q?pMnsxeAWj+l0dCpesjMiM5GxuU2l0wjp23kSwjccpZWwBPXjTQayDpfXv16E?=
 =?us-ascii?Q?ZoBU/gV+/ubzHrdrr3DtewL2HHqac5xJXJ7ftf3BDqlo3HRRH4SayyU8vVfe?=
 =?us-ascii?Q?5C9abUjNzf+dnc8RWXObK7tDZELaK9OcIujCbCVwzsTG8sm/Tsv7wPndA2C5?=
 =?us-ascii?Q?4LLPOGIM/qfNX2cMKNEcmVcvTrLyN8A3152Y73zA5aq6C0mvlxzJJjAhGmhR?=
 =?us-ascii?Q?LCbZ/UQ+AH6Zw+YftT311okl/1MV1nAl+0izEuwTdB8tOTHBjf0V+4DmzAcO?=
 =?us-ascii?Q?9UxIvBetsAoIoSpnE5H34TKsiUwjDEqweB9xwzWy40udqbbWX888AO7PpJKd?=
 =?us-ascii?Q?zeCk7BcOTmZ/bR60yujyndcssPGCDk/u/LXXRumMkHUy9duea3m/wfoC7Uge?=
 =?us-ascii?Q?sWk4e9/shcu/JX8ZJ/h+X2G5mHYlA5eGinZpP6iq2B2ZAk/N57XX3AZbD9UD?=
 =?us-ascii?Q?JLM2/MweIER2fPY8nkAylEqkbns7rJma2ryVUYVYlwHdtHQxc7GOZg4a/uMq?=
 =?us-ascii?Q?Hgjtvi3qqh9t+WPYZmY8uY/8vRfRWe1I0Ah2JVb6gTgZPdyuVIqbO3MkX1YZ?=
 =?us-ascii?Q?iztKqzwDYolN7Mvq+YVbAXcbLZ49T/pG6aaW6b3z2FE58G7JmOV/I/FZ8xr/?=
 =?us-ascii?Q?b7WTQ0+CK6uK5HljNpkjB3m4qYwQX5T7djr6uZxaY/jNtmAXknEEOGhi76D7?=
 =?us-ascii?Q?tvLVFBD/Ct6E2DLwe+J6/YHvuS05Kzi/FflyT2WuGZkMnBALx+hn042I6nuI?=
 =?us-ascii?Q?w0+p35EH2COtGkl6CvUzRN4Wy7r3zB5g9Z85DfQ1WbuRK0MW0pMDuTkM+AqY?=
 =?us-ascii?Q?+ajZCkFsZgikzdVFEdXmxEBpGq32yPwioq8XvTXZj+nibQgJ3UlTbzrraK3+?=
 =?us-ascii?Q?C1K2+3vxgqopKPtUXP3DnzbO5FVsoCrl7ArTA79RJDnKaH6q5CDqfNqss3hf?=
 =?us-ascii?Q?zAg+a4f6SctY0k57crBNQZd3Gsrs1V04RlxuwsnRYnwUS2vAZvKik8T5+qYT?=
 =?us-ascii?Q?xvcqfGjwGkuZIQlJxUkPZ6XdudZitMImtj0aDCaS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7846eb7-d7b4-43be-3059-08dc6484ac36
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 17:33:36.8702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMGLwM48Vr9JcouBG5D2I0Yn4ZKtGbw/K1SbDIInCEc/9ScH38eAMM/N8VtOkSG7zs98elujbP1SitUcG/Qs5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8596
X-OriginatorOrg: intel.com

Markus Armbruster wrote:
> nifan.cxl@gmail.com writes:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> >
> > Since fabric manager emulation is not supported yet, the change implements
> > the functions to add/release dynamic capacity extents as QMP interfaces.
> 
> Will fabric manager emulation obsolete these commands?

I don't think so.  In the development of the kernel, I see these being
valuable to do CI and regression testing without the complexity of an FM.

Ira

> 
> > Note: we skips any FM issued extent release request if the exact extent
> > does not exist in the extent list of the device. We will loose the
> > restriction later once we have partial release support in the kernel.
> >
> > 1. Add dynamic capacity extents:
> >
> > For example, the command to add two continuous extents (each 128MiB long)
> > to region 0 (starting at DPA offset 0) looks like below:
> >
> > { "execute": "qmp_capabilities" }
> >
> > { "execute": "cxl-add-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "region-id": 0,
> >       "extents": [
> >       {
> >           "dpa": 0,
> >           "len": 134217728
> >       },
> >       {
> >           "dpa": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> >
> > 2. Release dynamic capacity extents:
> >
> > For example, the command to release an extent of size 128MiB from region 0
> > (DPA offset 128MiB) look like below:
> >
> > { "execute": "cxl-release-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "region-id": 0,
> >       "extents": [
> >       {
> >           "dpa": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> >
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> [...]
> 
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 8cc4c72fa9..2645004666 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -19,13 +19,16 @@
> >  #
> >  # @fatal: Fatal Event Log
> >  #
> > +# @dyncap: Dynamic Capacity Event Log
> > +#
> >  # Since: 8.1
> >  ##
> >  { 'enum': 'CxlEventLog',
> >    'data': ['informational',
> >             'warning',
> >             'failure',
> > -           'fatal']
> > +           'fatal',
> > +           'dyncap']
> 
> We tend to avoid abbreviations in QMP identifiers: dynamic-capacity.
> 
> >   }
> >  
> >  ##
> > @@ -361,3 +364,59 @@
> >  ##
> >  {'command': 'cxl-inject-correctable-error',
> >   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> > +
> > +##
> > +# @CXLDCExtentRecord:
> 
> Such traffic jams of capital letters are hard to read.
> 
> What does DC mean?
> 
> > +#
> > +# Record of a single extent to add/release
> > +#
> > +# @offset: offset to the start of the region where the extent to be operated
> 
> Blank line here, please
> 
> > +# @len: length of the extent
> > +#
> > +# Since: 9.0
> > +##
> > +{ 'struct': 'CXLDCExtentRecord',
> > +  'data': {
> > +      'offset':'uint64',
> > +      'len': 'uint64'
> > +  }
> > +}
> > +
> > +##
> > +# @cxl-add-dynamic-capacity:
> > +#
> > +# Command to start add dynamic capacity extents flow. The device will
> 
> I think we're missing an article here.  Is it "a flow" or "the flow"?
> 
> > +# have to acknowledged the acceptance of the extents before they are usable.
> 
> to acknowledge
> 
> docs/devel/qapi-code-gen.rst:
> 
>     For legibility, wrap text paragraphs so every line is at most 70
>     characters long.
> 
>     Separate sentences with two spaces.
> 
> > +#
> > +# @path: CXL DCD canonical QOM path
> 
> What is a CXL DCD?  Is it a device?
> 
> I'd prefer @qom-path, unless you can make a consistency argument for
> @path.
> 
> > +# @region-id: id of the region where the extent to add
> 
> What's a region, and how do they get their IDs?
> 
> > +# @extents: Extents to add
> 
> Blank lines between argument descriptions, please.
> 
> > +#
> > +# Since : 9.0
> 
> 9.1
> 
> > +##
> > +{ 'command': 'cxl-add-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'region-id': 'uint8',
> > +            'extents': [ 'CXLDCExtentRecord' ]
> > +           }
> > +}
> > +
> > +##
> > +# @cxl-release-dynamic-capacity:
> > +#
> > +# Command to start release dynamic capacity extents flow. The host will
> 
> Article again.
> 
> The host?  In cxl-add-dynamic-capacity's doc comment, it's the device.
> 
> > +# need to respond to indicate that it has released the capacity before it
> > +# is made unavailable for read and write and can be re-added.
> 
> Is "and can be re-added" relevant here?
> 
> > +#
> > +# @path: CXL DCD canonical QOM path
> > +# @region-id: id of the region where the extent to release
> > +# @extents: Extents to release
> > +#
> > +# Since : 9.0
> 
> 9.1
> 
> > +##
> > +{ 'command': 'cxl-release-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'region-id': 'uint8',
> > +            'extents': [ 'CXLDCExtentRecord' ]
> > +           }
> > +}
> 


