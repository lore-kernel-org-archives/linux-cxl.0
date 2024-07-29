Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59481474CF;
	Mon, 29 Jul 2024 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255904; cv=fail; b=f4ijTqf+uhwglkpmTqnJNfDtuilXGSgh9+cCgzgrZwJoH7WOMswKnFbbLEYUD8PWLMrqtZ2tncdn9maeWZxZr0UaXTSmMtUTYErZWUDfabL7V1EWYxE/31xcv3q7g6M7gfG80z0f4ZSW1Kt7XcFP8TCOB4Hoif776uz4y8KxxMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255904; c=relaxed/simple;
	bh=63uhS99GLHjBsVaxf5rqBaK2pMdVMjpoww4YXzhmV9Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E+TmHhwZn17LEvrvojopg0W0xuyQ+n3JUHQtL7HZLvtdcmyL1KTbLaya2uC8PnrX3znTnPwaOOIt7/lxqE/KimVsU1WOUPh2TGq3MqEEOmfJtjfMo2ciydzwuX11ZolOdfmpgSRPJGWZyfcmQ0sdUxD5rFAuoDb9BTo3gGUB3WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNPUd89h; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNPUd89h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722255903; x=1753791903;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=63uhS99GLHjBsVaxf5rqBaK2pMdVMjpoww4YXzhmV9Q=;
  b=fNPUd89hSYeaMOV0dDLw3+YLWgNgNEuIv+ceRok7tYAETQ8N4EI8zJ2z
   iTY7jVBzpbcWUvBfoIXO6Sw0ULXkLKy/wIryEDJ+aoBqNw7NZbgshJeES
   lqsgWtlHyz7MzCq3KYSNfuvFp7332xPRtoXRlwWwRGEaoaArDKxQgh0ey
   u85303PQp7oRdyY5rBAr7PYkmtQMOU+mJN/stmyYV9lBThD0HjTbBt/sc
   0eBpO+58oYK3aUxcPsuBHoi2ISQqKFj54LLav9mU8Jll0f2rCTs07WM8/
   jtaamfPmjG+E8ZrdjbODN6wtO1NatYLZyXQFeWpnNAYyBNSNvilUEVTyT
   w==;
X-CSE-ConnectionGUID: /TxHmx+tQG2aiApSCVTzhg==
X-CSE-MsgGUID: ii5QczRlQfu0CUvAhS2fuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20135378"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="20135378"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 05:24:36 -0700
X-CSE-ConnectionGUID: 9tJqL3mZTee11F6DgofRag==
X-CSE-MsgGUID: Q4wbITHoSoy5fbJ743MftQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="58283282"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jul 2024 05:24:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 05:24:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 05:24:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 05:24:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 05:24:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjwymTJce56AYqqG5/3pPdDxGHgXFAnT7d1fC4ydrmjq5yXFhIR9zU78qh5ppHjzkhr7uPgoAurKEL1KJ4X77vPNO8r2YPgBhpeWZfnsfcG19E80w8+IBIWzc0WQw5GVb2Qq9c044Pt2hTIOQ/op5kmamLhDF/0PAKDBVEbzNsarX8ur5gsKpPKgD2Tdkm/0qC3vtbU8MqeA24jj+mxQix6P17knU1VwKsIIscvsGuBtmuyOOUEmgaOhfi51rKYvqPLp2VVVKtiZTo/DttgyM6AsTDavZRAermte2OsQV/yK6IlE/Ok3dF2TT/4wkkgx3yhgofYtOb2X+ZizL1AA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLLHKvWxGgIKhph5omi3GeXG0H38Ia/ffV5WUjnWRyA=;
 b=DNDM7Nqo0AFVC1QVfGuIWtF3Sak1IaUJTNMS/f50UNRCwljOe/zA+ebT456hT/+6UCx1DY9nkIj1OeSbkfH6dxp39t7yba7XfNjFd7bZXHHJL+/ADsGwiu3N1obFKJQ4Wd+/lae8hfeLTqAipnf/Xg0yEZY/E1HcaBVHHlDtad5MYCmAjCz9wQ7hHHDRM+2MTU6vj9TLOrL6RGv/iL9ZqpxZWUkacn3GL7jpE5mMRWiZ4pcbJfyzJS2kyEEVPJ0BDVAEAzpc1gqXhBZwC95D7t36/i5TPpYq6jiofKXEJoZKFsJIjiwJx+E448CY67wsxX+p0xdhwm3DXYERFr8PzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 12:24:32 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 12:24:32 +0000
Date: Mon, 29 Jul 2024 07:24:27 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Dave Jiang
	<dave.jiang@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] cxl: add missing MODULE_DESCRIPTION() macros
Message-ID: <66a789fbbdda7_2c6e48294a9@iweiny-mobl.notmuch>
References: <20240607-md-drivers-cxl-v2-1-0c61d95ee7a7@quicinc.com>
 <20240607151046.00002ae2@Huawei.com>
 <aef7c12f-cefa-4823-b3a2-920c12990afa@quicinc.com>
 <73d13869-cb80-4226-b8fe-3e45fb7d2518@intel.com>
 <cafa6bbf-446b-4b4c-9b6e-f4db6a19ae55@quicinc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cafa6bbf-446b-4b4c-9b6e-f4db6a19ae55@quicinc.com>
X-ClientProxiedBy: MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 4717bd35-b1bc-48ec-5943-08dcafc96660
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U0fRPEU4gE+DtSQPXcHBy+s54G79Zgcx4x8hpEVkh5EK/IoX1+joukA6hzS0?=
 =?us-ascii?Q?7MYv+bMssCxsqKW0VXfxoWj4LXC6yBGuEk6MhyRFeS7q8khLkl1kFyViafk9?=
 =?us-ascii?Q?nsDnPDoTP0o8AkqSY0b4nUMZKI443FneoLn/7PJzJUxiyfI5qTBpEqhpFcgK?=
 =?us-ascii?Q?9fgRD7oYtbz27aTo765muSirrN7KqrXPKPZZAZMQS+wkleBryqndTY1EMYhM?=
 =?us-ascii?Q?GcJUqaS1qQSjZjY3xdMt7HCocx9THcUBv2at3MxjtSwAHtL8PS8UDRs5CDis?=
 =?us-ascii?Q?Q+q57kLnbK8auIFe74MPcQlcikWEXYkpKolRhnkJ6yfsH0leLO7vgGSNt5yR?=
 =?us-ascii?Q?xvIBsb6tMOAueAiIdHaQZx6UIO72Mfa+Cx1cf0jvScmv0bPcXFjMenW2logS?=
 =?us-ascii?Q?woHfP+UqGRLGMQmosDaPHYH5BjM+OpC1mgSZQUBJIhT1A6tNiV0wuxSj9Uu+?=
 =?us-ascii?Q?s/r8f0V2anfFoMV28/081Ge6BzbTsmdiLaX56mlv62KYdTlrEatptw5brdQz?=
 =?us-ascii?Q?dPZ54rXNj0bwvbdk8+MXVHk40gIDm5Ptw/f4lKYpCcyzUELeK3zTOGbKLSth?=
 =?us-ascii?Q?OhQDjXZpMFCf8AlK30e8BVeLO647LEk75JbpdFEZRNdNTuytRaq+3C4YJSpq?=
 =?us-ascii?Q?q9K8QemRHoAlN0i7LYa5EbrLGqxDuhr4yr14/XlNaq+PaU17wB6hvg0+wV4b?=
 =?us-ascii?Q?sf1HwCLpUFK46Q+NPSy3JffqHh/XJlAJlf7bB0F2RiemEYtYGUSNofC/gR1H?=
 =?us-ascii?Q?mvZugW7oO6Sj9bYEycB1jHhvDE7W0M7uqGPxLmBy7T8B6gxkTdtO9nNW/Q0W?=
 =?us-ascii?Q?oyExNhxRCTK+5tzZN128dIPnVryMH477fV6zJv/iVMfzrFuPDadDyoAWwCTF?=
 =?us-ascii?Q?M9tFYDmspqgD5Kv+U72q+xq9E4mPecgTFWXVdPtHy1JR+hVFkLz2RHMnVR3O?=
 =?us-ascii?Q?/H2uK313eaujz4xjzOPPz+NI8pjFcGvpN8VjgA46D5r7IFtiD0HyNOGfMga0?=
 =?us-ascii?Q?TNql4y3a29jsoROQdhAXzsGgG4+bSgtjUSrf0Lu7hZFdOfVDQ8ZFakgAQ/o/?=
 =?us-ascii?Q?TBai03s+OBw/GCihxtzqNgzdR/Rr3QZGF81VxGPe86FRGFCpskFr+3WYxKgY?=
 =?us-ascii?Q?PXGoA9tcpugfCHce1rcoGwlTeLFD7ZjeuFFnLVV1A1q2r+BjUVLiqBOt57Fp?=
 =?us-ascii?Q?oH9z4ufBaUvAkM3g0Hm80naIBmp2ZS9c5lKOlkUm9ZtJ8I76/KEn4D2DV2Zs?=
 =?us-ascii?Q?rYYLStGzFieFfTqhSQLcC3+hq1OlnWrHsgtX3+KXIT2BKWKn2swDSFl+s+ZC?=
 =?us-ascii?Q?uBr36Cpz6m9uBNATeufGwwnXL0X4ID2Q1DIydMZkeHxvkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3/YDln1lFaQ4kkp2trEx1b98aWg/f4jy/VpD8MgmOHqtNY7fcuwt/4fy29yc?=
 =?us-ascii?Q?u2hhE1HSHkYW1saM0BCXAJ+cAwGOvmTSKfr7oldAlavQvJhUo7ApFuQvYy+l?=
 =?us-ascii?Q?1sXrVLKktu1bfG6MR45UAhboWD0yUvI8mNEjQpoGTPYq2kdCSLwNffRTOo27?=
 =?us-ascii?Q?uREzNM1suGMBXt7/cmjEi+Rz74c+vkuCxA9Viu35+B/X54hgK+W7VlvdDM6e?=
 =?us-ascii?Q?1l2ZX3njIsrJhwrte7fPDO84tysYMH62SzXTb8G8o3M+u+anryT4IEMD0qll?=
 =?us-ascii?Q?9lTa3+TF+ooCh7Dr5Oz7/9NqMpcL4KNc+H70Z12sFNYqYWhDDqymCuq6b1n0?=
 =?us-ascii?Q?OLR0MWp4i4Pf5/34W8pkvnMFMosdGB2QB3gfvukcxYn+CtoqZT/+JEIWEedn?=
 =?us-ascii?Q?d4GniZF6lDREyGZ7wsBGzwvMHZjSUlF9zF+oSfk1NQUlYY8QL9L+GE6nZc06?=
 =?us-ascii?Q?C37NABdjqF7O4osKqy1XIpGME10m6i+/j1ocXIdRVo95WFZlXX3m4xNhbkRh?=
 =?us-ascii?Q?DwHc09zr7iJPjrMvPGT4qnzxBtu0bIri24Zv4QU5FcbB2/l73RdyjzQ+akDN?=
 =?us-ascii?Q?fY2h+NXAafJZmAsp2rZuL4yvjfqrhJsF41EEzC4JXSZXqr9fHu6OVsvc9ZJk?=
 =?us-ascii?Q?bvJKk42zGqMa8X49/Lw3k4CqA/Ii4MGQ1AY3x0ctnRV8o4KlzGjj3hUtU2He?=
 =?us-ascii?Q?MyOlGiUGbX5RBbLoP/jRvGFv0VyaTRrLQ3JOOhxDzXDBd4OPRaRwLIjGQI0b?=
 =?us-ascii?Q?XLeNnLVtYMmAD6zIZZJHIIv+TskKMsL6z/WAMTD0PSeLSowFVyvawqlu9y3y?=
 =?us-ascii?Q?PXBMWabfJXpsOdkfyZTDjMJUeZFwiouR1+ZpZeJemUCrYoo6Bwiwq9lNaXTz?=
 =?us-ascii?Q?+l3QzTUQUo97hdt9k7MR1ehZ7ZMU8XhHom5y9+g6bspZr/60O3ccgOem9OFR?=
 =?us-ascii?Q?+MuCe0+XUdjNp0LrqlIRG8aLMRF/mso/Gf2bqG88MfuHyUlN+cCCmaoFCCjb?=
 =?us-ascii?Q?uMbiE+B9y5DyMvopxTr5RTPyi77jxkVANpZ1Mu3qlSCFOwJQqqHECsAUAxJa?=
 =?us-ascii?Q?Vm43i91stgNO8p81K4vkhDZ2v43yZokbBxPxY3Ghgj6PltLH4TBEW6G1UkoV?=
 =?us-ascii?Q?LN6RilZI6holWJ+76ggm6wIKNSv+koxmoBf2LJ2cOGlLOE/nZ2V+nR3QJJPA?=
 =?us-ascii?Q?lCAEgaCHJzKgDUGK929RS1O5PtewCRGzUxfQU+xhBdhXeGb48zDMlndRB+8W?=
 =?us-ascii?Q?7oX3jCDIvW+DkiYxaWR6aRW1PwKap1pucET+RL2/i7e4kk6viKOOmssUQugZ?=
 =?us-ascii?Q?IfDQAbj8hvQVA4UBp1/m3R2VzZHun37yekYawjp5NWqQfSrcPxhm/2SJ9AnM?=
 =?us-ascii?Q?teEcbQbMkt0B5vTpC0GOzts2xp6heKw4zXyfFo4FDXAY35RaGwacNIvN/ySW?=
 =?us-ascii?Q?ZTu87fWUfUDSSyKXwxSXnfU4gyx5XzbOlhbrjUehbPv2l242A++oVcSx/rad?=
 =?us-ascii?Q?M6G+Y85unmXw3S4lsWpbGOFv39jk7dCDUqZND7jsLxN7S0HixlQ7HQpqN5Ml?=
 =?us-ascii?Q?wZzsh3+jW/Bn+ZfXdgbLjvWGL82wRozepM1F8gcJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4717bd35-b1bc-48ec-5943-08dcafc96660
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 12:24:32.2590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJOfuDYPWgnqE0FuZnwGGL1Uv8X+3RXWNi9gJ6U+N+UX/U6t5GWSf1jVKSEau8aVupc/SSK4TmXGUyBWYVhnaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7458
X-OriginatorOrg: intel.com

Jeff Johnson wrote:
> On 6/26/2024 9:41 AM, Dave Jiang wrote:
> > 
> > 
> > On 6/26/24 9:02 AM, Jeff Johnson wrote:
> >> On 6/7/2024 7:10 AM, Jonathan Cameron wrote:
> >>> On Fri, 7 Jun 2024 06:57:15 -0700
> >>> Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
> >>>
> >>>> make allmodconfig && make W=1 C=1 reports:
> >>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/core/cxl_core.o
> >>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pci.o
> >>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_mem.o
> >>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_acpi.o
> >>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pmem.o
> >>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_port.o
> >>>>
> >>>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> >>>>
> >>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> >>>
> >>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>
> >>> Thanks,
> >>
> >> Following up to see if anything else is needed from me. Hoping to see this in
> >> linux-next so I can remove it from my tracking spreadsheet :)
> > 
> > I have it locally queued, but will probably push to linux-next after rc6 drops. 
> 
> Hi Dave,
> 
> I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
> Will you be able to have this pulled during the merge window?
> I'm trying to eradicate all of these warnings before 6.11 rc-final.

This landed yesterday.
Ira
