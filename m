Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523FB3C5857
	for <linux-cxl@vger.kernel.org>; Tue, 11 Aug 2026 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478277; cv=fail; b=H85PVBMehNEGidVUv4K1uMFlpKl+f93PKOTvg/epsJyo8I+KMn7hRPzeiObOpx47oEBh+b6WooDIpADTw5Q+33hRGiYq1buvHunFehPo7DtfDgw9uQzD3CwCEqNiq1vpisJ8yMCX4XSJm3QuOUg4jTfMddVMZtDaMP5lnTPxP5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478277; c=relaxed/simple;
	bh=Ta3vUYSgzNLVUtA3WZXM3Kd0o3LwYHpsepcv2gni8yI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l9Bh7SEOhDIz5LYBurZSxq/OYmygucHTA5UHqgzRwLRI1xMkqLZU9zC91DbnLhOIMeUKdQCFYvQYWa/JPowOoz31tjl91M+OUC+I9qnAVBWHl90nl6dN7egnrmPeajr7gPR7iNcg3fXzJbcqvsX+2few9JASxa1ChhzbjDKIxf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJHV7x6l; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJHV7x6l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786478276; x=1818014276;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ta3vUYSgzNLVUtA3WZXM3Kd0o3LwYHpsepcv2gni8yI=;
  b=jJHV7x6llB2GSn7Y1sZK8sfLRcbvL1EGEwJqskbkPryvCqVX7knXkKkf
   EO5UTq5dNxrFXMjGSVO0iclSUhDcdKQiZHqy4udvpzzHm/K67FZKhTXJS
   g25LMoJh3ENWv2p8UzcSILYZLtZeTIrm51lyJO4UmFa2RCwFQdo8A+8Uv
   lZHBRROOGicAfGNRzC5jrWXacIc+F33ZpTTYp5FXsB6qbvBVj38h/QMYX
   S6OWHv6FELE9plxl+TTjZrMQB0iBBD1srqcXphuVsbiZKAn3OW+/ew5JL
   25VPzq4YGPE9QGwgvQdHJqjpSO+yPF/ChRys9KFNDqScMEC+f3Wl6Bq8Y
   w==;
X-CSE-ConnectionGUID: JXci0r23TES058K5O/Wy/A==
X-CSE-MsgGUID: VWz33ZKRSHSjI2pfmu1ktA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86897065"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="86897065"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 12:57:55 -0700
X-CSE-ConnectionGUID: JODVE1opRU+Lf30b5E5bIw==
X-CSE-MsgGUID: /xddLZA0Smm1fm+Pvl6Dxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="261682161"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 12:57:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 12:57:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 12:57:55 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 12:57:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WU2kRzEdMyxbspX5ZX8/C0M6pWcy+DQXrqL1AngftJubUWBzX5yi88FKg9vsdIlMKV79NLRdZfupVZKPhXcIZxQ1EjyGLxQ0ou9VdycVhEZePPLqhBZZCvLUIwbPM+5Y8TXJUr4ZHt1/ZblDv1qSm9uXo2LG1rxxtiEyuWTArPaANXPSnRD4FfUnL/FtqWlhYtu+owQR98iU9qNBjFU5SeMvWUZ8d+ACF/cf6LHWm4fybqeBnl5qZVmV2YtsO118kefeBC1imjclPf8AXhE1IVj3wcdOV6t15RDHuY8TxZd5vooDm3wF9VqXNQizHw+M/OB5bHqFbtrh6rjUuQDfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTmYy0sz2v3a8OysOdRn+fjhQ5zOQKubsxA7BKiWBvk=;
 b=A1Cnurg/A6VFaugPcv0BGMVaI4a28TfDyeBvOvwA5yitkCXZog4wj7vdKWfjgNX3wiF5Vlju7vcZaBsPyfzhp5p1vNLkJ+8zoXPwubI1lYVQ5tzsCEEhKFEmmFkQeFUeKrfCu9w9vPASpjH+10pdOsjeUnmiCMdrpwhlG/Az6ThkTYABcsFmUREsN2/B8PoUgKoM3Npvy7x/zfzCNP33SmUYSb8B1XSRHl2RcGJr7LTLxwKEnoUL9ryhtFvs6EmZkhL0ScDpxrWPhonepHOSEA1paldSIx+W2EvMtim5/oFuA5PxZmodk8bhEmARONldYz9HRNgajuT8CxpczpzV7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB5261.namprd11.prod.outlook.com (2603:10b6:5:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 19:57:50 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 19:57:50 +0000
Date: Tue, 11 Aug 2026 12:57:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>, <xlpang@linux.alibaba.com>,
	<oliver.yang@linux.alibaba.com>
Subject: Re: [PATCH 0/8] cxl: Assorted fixes
Message-ID: <ant-ttVtO_tFY_rt@aschofie-mobl2.lan>
References: <20260811113608.2815625-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260811113608.2815625-1-kanie@linux.alibaba.com>
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB5261:EE_
X-MS-Office365-Filtering-Correlation-Id: 230a292a-d47a-44b7-3432-08def7e2d255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|11063799006|56012099006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fHT/YOSHM4XDTfl34f0qSJPsuoKZbWkBrm4BGSxXncQghJUc03XA7HpkL2jbLIFbRGqa0wFdzxeFVjMRHi0r4jKMBr5fuZG6bZt8rVIzQPo4buibiuSWgx10F2avfIklY2XOTMM4w4fMAQaCGQs0pX8odcAXABNgRVI0QkMFTD6FB0Wr2jiu4qyr10/GRLaYFL+AtiGkC7L6xmOPG7GIMCcU5hDSCnCdjCt64CFN7x9BeKfGvPRa1XJ+HXaAc5dAUWaFF8DN1XLa8TZrW2pO1hz4OBjF7lhrVG8+JezE8plMJIwMjedob00f7li4j2uuV8nZgY3oD2mu6G3AucRLQklYGtsA4D5FziqhHC65Xnq72hTNwXKYjlHJ0wpg4LLxaXXjKzLi5r+DfyXe9L50LfjXXTpL6JW9Cob25cwTQqhw8mweag+XkJriCGqdQCp8hBhB3xXrYE2tsouphsbAXJlr60A0pDXb9cgeUFNzWmPCA8S1p4NHJu5sB1sx8dMI2D1UX8MeJS6JOI4f7SC5WlWqu2WzXKy0jgw9tdqJDjAgeWZDL2T97hHQ6eXKGzwxN2xMm5p6tvlSsGpsK9Uncg8KdRwjA3a+/2624VPUotY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mnNMPKJjYpLomoE9EBfI48fRQv01CC/8D+nHcftu0n475CShCzWducmFNwAs?=
 =?us-ascii?Q?HhV6mT6MOVJ9hXKooyZqwDMh1ClEuD3XSKCWbsEFl0zJY6S3PwIftf0cDdBB?=
 =?us-ascii?Q?uBrZ/l8Zaxbf4wvShhQIf79Fod+nADoIFHBinA0LGWQUuPQFv7SMnXJWRG3i?=
 =?us-ascii?Q?k43jBGElWQVgzoOOyvaZeuk1Asnug8qZvXucY0gnbYj9yzwFudnmK7fAwP+j?=
 =?us-ascii?Q?GPytBBC+Fbvu9G5vbfEkqmbsv/Kpi2GRm/EqlgvLaR2Bmo76bvPXVYMx3BLx?=
 =?us-ascii?Q?WxtpWuapxxLK1ZlevOrRMhwR2dF2Rw/bH3HVcj75Gv9hBfvg13LKT5TQ6KNH?=
 =?us-ascii?Q?a82PDcV/h+jun0kvFHjqoMOMLLlPcISriN0IqXT/nFrZIr1i/SAoUgixC6Hh?=
 =?us-ascii?Q?LThgXkN/Gr+/mGFXAat3dZjArvO2+YVwFYKEiq4lzTgneq3HXB7YvqGrstqD?=
 =?us-ascii?Q?dR1pyznBnz+jeoTitKp0Rlsl/ckoKD+WhDwrY5J+6VVP+fskyX729Gw+L5Ig?=
 =?us-ascii?Q?Lb3GobdhZwOux7YAgaF+kiH9YlRyeS9sHp7Wnu3a6vmjyrllosSkTBkLh9Pb?=
 =?us-ascii?Q?HSB+e5dj3No2krSDe1EksLLUa1Ip0IqZzCdjfqE8nTaLIFzY+G4BTApfPPKb?=
 =?us-ascii?Q?BBaP0D1JOuRgf5V/ubAUOsp5I3rDA/yZ+sFeItQEO5JxPYTDnAOAqe6Drqqd?=
 =?us-ascii?Q?FzpzF7Kh6HQ1qi94icxqgLcA4IkirafBGY2QNd6Xjp/fU06k8Nq9Zn3BPnnR?=
 =?us-ascii?Q?D2NaV0d9lE1ibgzD+hnevKm/1H909Csao5b5YNGBSk3GcIT+P1Wy0YXri7MA?=
 =?us-ascii?Q?SDtYntPo7R3PPqvfFN4L9FOY+mlLcQRjVE3Drb9vcU/4z1OxXRTblmi0fymY?=
 =?us-ascii?Q?xE5I5YeUYDe/PnlWWr6DJFczPzYHDERMH7sf05s1CmDZHvTXqJumfd6dmcIU?=
 =?us-ascii?Q?xE+8MG5XRKJzaw51pnVD8pKu6PrdVf4vELV8PoE2XvP00gPX/2dv2JCahqtO?=
 =?us-ascii?Q?iKNTUgNEWdRHHPkH97ttJ6e29tjirZ0lUvH/2NWzC/1+UqtiwASNd7kLEBzJ?=
 =?us-ascii?Q?6QBXvF2UOi9f9bac3YmwOQxr0L6RN0ToMoTg5mSUJ915nD6xsAkaFgU/65YC?=
 =?us-ascii?Q?TWG8cg3kRrNH63lPg6znxbWB+s9GLSrHCvyLnUBNVhoGOdJ/LDyqq/3/RHUi?=
 =?us-ascii?Q?jtbC8DQ6GWUWU9HeEpLo2ET+0VbecV0rt5xMxvy7fZgplORaDc8x1svqd/lo?=
 =?us-ascii?Q?Mc6XD2YjDwZt4SqEQ/+BS1sXdPwex7jKQsLe5gFLZaKiOTnErCYqb0MwQ/Wh?=
 =?us-ascii?Q?hx4KByvRvspUtNbztVqVY/fRrLbHGD20g3gO7Q4j81rIwOa2ejOLGt/2wxm8?=
 =?us-ascii?Q?+xcqfkle5Y60dq+R4IczSqRQ0PdT57xblV4U5kDH1VSsEMxOh1qMY9S8eVW6?=
 =?us-ascii?Q?NSqAfcrZrKW5NeCOQG/XRR+4pwUP8ZuMQIBIcewznEv/ikyqWU52ZLgM3mQn?=
 =?us-ascii?Q?zwgNLFVzs36kVQkJhSTpAjIpb5f0RftCUzi3AP6rGlSNflFjH7BGlTby1d16?=
 =?us-ascii?Q?NhNDsqrbtGGzwCufPqA85q3yB7dBOTNy2c4RGg6WMqnMTs5/8lzP/WMGWGqn?=
 =?us-ascii?Q?ght9Atmg0U70Wk16D4eB00RAXPLjoy/RDZg4aiR2H8Lpg8b0wB1IAlb6o0wj?=
 =?us-ascii?Q?hhONV3jmYT9iVv5I0S7NAn/yiCuxcS7+0rbJIe0Ot+3yZpAcsvSlDN0EcF3T?=
 =?us-ascii?Q?cacAqrgBuxc5aRTkmkrgWZahINAIkx0=3D?=
X-Exchange-RoutingPolicyChecked: CMW/Rsm9z0nk0MbcTOTCg3w6lagfZwKh8e1k3Smnk/SvHgIezQhe14+2KxUQeuciEmdLUMqyUaI4s9suiu8OUDhxXcpo4w/Rn4Le3ogQQq2yvq13mSRJWfamK2t3aEL5YYriQHP/euAuVIga0I4yVnE4TZmtJJJyFGQHJsRiyojU8bVde3fQ0WBmKnuzZvq8jbvnZJVTkFO3o3at/1OjKn1xulFU2KKPun/Q0DvDeGJWbCX1Nu8BIBHBFw4oxwOtfUQJa9kq3rst89AHygj+s5RlZbaMcWOLBhlFn4Roq6eWN94yDRw29xUNZ0STnOm8b+bSbYeARGBxh0Q7Dlkehg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 230a292a-d47a-44b7-3432-08def7e2d255
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 19:57:50.2846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvAxQ/1ABD8pvh5yTYeLPjjq7U/3zUg9eGgl5qhLb5uG4v5JecqxC+YJEwyktWCS/T+aqbkub6TRdEcPX+mS1pxRNYdMYb7TeNTxN5nsMmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5261
X-OriginatorOrg: intel.com

On Tue, Aug 11, 2026 at 07:36:00PM +0800, Guixin Liu wrote:
> This is a batch of fixes found while auditing drivers/cxl. They are
> independent of each other and can be applied individually or dropped in
> any combination; they are only sent together because they came out of the
> same pass over the code.

Hi Guixin Liu.

Thanks for taking a look at CXL and putting these fixes together. I
appreciate that the intent here is to make the individual fixes easy to
take or drop. From the maintainer side, though, a grab bag of independent
findings from an audit has somewhat the opposite effect. It leaves us
with the audit results and the homework. :)

We have been working through this kind of cleanup in focused functional
areas, like features, HDM enumeration, etc. Please take a similar approach
rather than collecting unrelated findings into a single series. Address
one area at a time.

As part of that work, please check mailing list traffic and cxl/next for
fixes that have already been posted or merged, and review the pre-existing
complaints reported by the Sashiko bot against your patchset:
https://sashiko.dev/#/patchset/20260811113608.2815625-1-kanie%40linux.alibaba.com

Please also follow the conventions we use for fix commit messages. They
should not narrate the code change, but rather describe what happens today,
why that is wrong and its impact, then state how the patch fixes it.
For an example of switching from code narration to behavior description,
take a look at my recent reply to a commit message w similar issue:
https://lore.kernel.org/linux-cxl/ant2Z1mzHCrzmzXn@aschofie-mobl2.lan/

This up-front triage is becoming increasingly important as we see more
AI-assisted audits and fix submissions. Without it, maintainers end up
determining whether each finding is still present, already being
addressed, significant enough to fix, and where it fits with ongoing
work. That review burden does not scale with the volume of AI-generated
findings. 

Rather than reworking this series as a whole, please apply this feedback
to focused CXL fixes you submit going forward.

Thanks,
Alison

> 
> Guixin Liu (8):
>   cxl/features: Validate the fwctl RPC input length
>   cxl/features: Bound the Get Feature output by the user output buffer
>   cxl/core: Fix dport use-after-free via the einj_inject debugfs file
>   cxl/pci: Fix NULL pointer dereference in reset detection
>   cxl/hdm: Fix out of bounds read of the decoder target list
>   cxl/cdat: Fix uninitialized stack use in endpoint bandwidth gathering
>   cxl/mce: Validate the memdev and endpoint before use
>   cxl/region: Unregister the pmem region bridge on setup failure
> 
>  drivers/cxl/core/cdat.c        |  6 +++---
>  drivers/cxl/core/features.c    | 15 ++++++++++++++-
>  drivers/cxl/core/hdm.c         | 12 ++++++++++++
>  drivers/cxl/core/mce.c         |  8 ++++++--
>  drivers/cxl/core/pci.c         |  8 ++++++++
>  drivers/cxl/core/port.c        | 18 ++++++++++++++----
>  drivers/cxl/core/region_pmem.c |  6 ++++--
>  7 files changed, 61 insertions(+), 12 deletions(-)
> 
> 
> base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
> -- 
> 2.43.7
> 
