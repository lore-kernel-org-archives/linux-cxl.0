Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319792FBDFA;
	Fri, 31 Oct 2025 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922021; cv=fail; b=tm9UQgqZ1tHZJaUVqENhejkn1UGiuGrMsshxASHQ+GTElt0XHywh6JRuB0X1+gjF/+PG3EEoeJbyZ/UWmtkJD6cEVnwFOmokdPJGhyfp1BT3QFxmVCeddgsvg3Rrfh5dQ2VhOIhhcckPQX6IVV9u0+FS6zyjVkyaLBirgPb89ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922021; c=relaxed/simple;
	bh=QH6YacOHnBUUw2ELxrtjTiHQs3SqnYTmaT/MRIKC7w8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lyhdxmED3xrD8jib6bEsvLOwoSLIcDVmdeo0j6zCIUa83RiGRtFeqnSRsx+7lA/GU4Fm74+efSz5IiDPnNngXw2QVOfwHemy3kADGhnMnxbVHY4PSTF1B13KTTovUPh0cRep+cGll4g4/qOGgXlgJW1rcidcpWvkUZHri6QTOG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWrTohLu; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWrTohLu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761922019; x=1793458019;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QH6YacOHnBUUw2ELxrtjTiHQs3SqnYTmaT/MRIKC7w8=;
  b=kWrTohLuaubEo/7x5UB8fE9ymtMyfOlzYyafFOrGgpn9yQlorZ9mT/0C
   j6KhghAcUcPhYKnTKAODoD+sMV1L7fxF+XwnhQppstjLKvAV1edky0rXW
   D7M8A2jsgaakYmLAoM+/z5RkkeZ8w6MOWqTD+iawZvF7Eb6g9qWiHzQJt
   Y9/qMnABO+zVvF2jCZOasBjc4ef0Zuq4V0amea6MSEU1gLo18UrkUF9rU
   RnU00/vp2PFGA6ww7Ky9w0uaaOfwUI93CEr/yMxtnxXNCup4yE9Or7H7A
   gaChx/M4AiBu4Xy+JLuX2XeSBZtpOKe3ZdkdqhHeg98zTuw9EUH09wOJd
   w==;
X-CSE-ConnectionGUID: ZqdeK9KKTjGfhup6ygZqRw==
X-CSE-MsgGUID: tdpAloNrS1GZnrRjP4dIRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="89547536"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="89547536"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:46:59 -0700
X-CSE-ConnectionGUID: 6IaGcUX8TmuAV+gLbJcCeA==
X-CSE-MsgGUID: a5HrkVmcRDank02F570CEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="191393659"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:46:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 07:46:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 07:46:56 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 07:46:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1Ep1gy1wMn3yYKESEuS25KIr+Mqz9mzG19TxJ/ScP5sCvvu3Iw01Nlr7CSPVupCYKOEoKN4fRmjVpETOBIszNKtH7m6i5C+9pT/xfj6fOLkLq7nrrsBH4SAokTh9criVCM3GdN4VzpVWjYGOtznolr4+qWD1xtQHv1QzqMdmfWpNDlQLF2r31ZhnQM13xBbYiHmA2bzd/OY2qs77XcTuD3o3/uerxrHt9dSnQ4crzgOe8cMdYJSfwvI5Q67SKloSRAZFJsckSt6gw0YR1z2NRzAm0RBxYytYuGfdzX3oeFeXDbW1lSqe1k4pczD7y8FiworScA7MtOa3ylM9OZbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDZNQuzNZE7qR9/KKJk5JTu4On+ywX8TtXWJi9PvN/A=;
 b=bFdXv1flQ30q6zdu1u+mplajhXbuA/cMBjQlqja1xktqjNXZB8tbrMmm/lTh6EUjx9G4I32wTfzZG3B/f3m9bQNY9yC862oQWKPfZVWlQXmgQyIef/Nb89CEfjJAhHgAPbuVfkv8qJ7UmE1H1EXL4M6RRk/PG4puczZhRvCIcZGU9Dy7/ycYjYdATx2ztogLNm7SRxn6VqDLXtbCdpf3iOhD1203iNX94i5JqlhjIVkV91dnovknsLrjliij7so6Q6RxRrPFaWltly+5N0vptqOansQOiehQxOqL2MXW8fH913HE370Nl5yJRj3qsyG9n47CCN7i6uJFPxHOHq97oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by DM4PR11MB7759.namprd11.prod.outlook.com
 (2603:10b6:8:10e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Fri, 31 Oct
 2025 14:46:54 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 14:46:54 +0000
Date: Fri, 31 Oct 2025 09:49:16 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Marco Crivellari <marco.crivellari@suse.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Marco Crivellari <marco.crivellari@suse.com>,
	"Michal Hocko" <mhocko@suse.com>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/pci: replace use of system_wq with system_percpu_wq
Message-ID: <6904cc6cb4123_23741210067@iweiny-mobl.notmuch>
References: <20251030163839.307752-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251030163839.307752-1-marco.crivellari@suse.com>
X-ClientProxiedBy: BY5PR20CA0034.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::47) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|DM4PR11MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: f29a1278-b624-4435-9ef4-08de188c55bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JmVv2HyGFEkd69T/RAsCKEVnlPh/a80IjCf8HjiCGA6K7oTuCdT2Sxm9T/ql?=
 =?us-ascii?Q?iyq9M/tQa0xQBhL8JPtXiocycxi5f7xag5yHRlfXsYh7PZewW0UY+G18adnR?=
 =?us-ascii?Q?RFJOi204FfzIpkjVWTf2bSWK9nMU+aovhumINCfy+9JSZEsnOoYdk5umQS3y?=
 =?us-ascii?Q?IXCeeACO6dpEFfnWtdgAv9XDdV/atlqziP43cfzJWzGLJTvVF0TdnsG4HIN+?=
 =?us-ascii?Q?wcVQuqqNsSamMErkw/ZW7lF78djVNSQDdHSME7xrSGt5yhJ26lWGTPUz7+DY?=
 =?us-ascii?Q?PvWLId4DWBvIpfsJYxfZrULTQPcqeVM1gZH0mOkFC3lJPz9Ftay6AYmMJ74R?=
 =?us-ascii?Q?JpOPvnWHxmVXUmcbcd2FZRliy/2VFkm/kJBB3YgZh5QQlaSnIPaxOdkSlxBL?=
 =?us-ascii?Q?nLAdfvtLiDGC2qc/KHs37OILcsTzAGp3z3MTf4g3ufyCyxHWe0EoA5+i/Ve4?=
 =?us-ascii?Q?hzzqR3G7JBWrs5gVgH66cGusDpDM1K2eql5iOk5+1cg/a0wTPIkZfymchxFu?=
 =?us-ascii?Q?wmBzW+VWKR53kRostTQABvCscm8IEjWpPvxHszvyJIIWlh28RppYDJtOLP4C?=
 =?us-ascii?Q?euQ4TH6zlTNPq3eav0NDRfMptxfsroYQUkdtLpAmzemGsG3X+400Xq0XGYuI?=
 =?us-ascii?Q?W9I6U+EUSKliUfqXsQ7qjcAJg1oFna5tmDbpWUG3hFVHrxFxriHr3pEE0lkI?=
 =?us-ascii?Q?SLAdvQp5UJw2BZdxmZeYK36PcRZihq81l5hZr3dUDewuf1V43xuKsGsqv4ov?=
 =?us-ascii?Q?vXyJZd7qNAR7EBHnsQRe0oO6XT4M7x53zdVImWx9TKt4OzumEiU8sA5Qjehy?=
 =?us-ascii?Q?uYz0aZaqCRK61Y0TwIXApmH+CyYK7ExZNo1+fTYruPyGHTcZM/DBUf+Shaka?=
 =?us-ascii?Q?SLl3xyCfhrAU7NtYmnJcj+mbBM5fVcMTQ/WkL/8hETa7mPqx+Kw3jdOpTy9c?=
 =?us-ascii?Q?kLC1XHJBexhnUM+RUiky5clYpD0+k9uf66dGYgAa3OmIaNkaJPwyFlt0piFJ?=
 =?us-ascii?Q?ECd//+1k6VrZEW/C08zp4blxnYnS9JpXCvNU3yAaC4t+9SYAhrhJpfdh1RiV?=
 =?us-ascii?Q?I77iOXMOSD16pptDamTtkfLggVej88PV3lIsnDk9rcsH+YZe87T/Dy21hQZP?=
 =?us-ascii?Q?aIdHkMAuuZlrrpEv6WlBEF4Zd9nOnKqOOmYIWRej00woVJ9GLj+eJrPgcCbd?=
 =?us-ascii?Q?OwIttssVn1lWKHUbvPvlXdTRU6BoJtkTeiIvjkg3ETqIeymn2wCsLQBpE/SE?=
 =?us-ascii?Q?K+63+URVlS8vjQKPyOFdbbC4GuJwE/bk4gD8E/+Y62tlo0NaWqRBZsMs+hoo?=
 =?us-ascii?Q?ZQ68fTI9hLmTk0rLGGRX6ipZFlrBobfRFg/xmmt7Ou7beYdGRbYxspx3oe81?=
 =?us-ascii?Q?Gy37ZOvfBytEcNdifY9B/E/tZT30XmTdUPG/tB3danEN5WSQxNUsfsT5hCMK?=
 =?us-ascii?Q?MTvnTFf7JvXWOoFd8MnQotceLqtvrojh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hs8mzyzDjyhqHBOUrt+Ecf0d0B48RJIEGsc2ON8VYrfysdeD60Ka8TYTbA8P?=
 =?us-ascii?Q?rcIIURYdluxznIZxBfxiZQyOspwdcYka36xb3CioOn1UEmk26GDERSDP7jy2?=
 =?us-ascii?Q?NmcAd9gbd3x2F8ao7yJ/WjNU2yAgMLFLQIMW8t9R6KidC8SOpm0C08BxsGJg?=
 =?us-ascii?Q?AXPvZf+TqvJRKUYh0VYS/MPavFXrjgKiYP6ZzqCAZcGhRF+a/m3p3ogstWeK?=
 =?us-ascii?Q?gW9Oiufk6FZiM37ZpbAqSIwKF3e2/nF8GFe97xQovArlW/zB76n1Ag4yI4GE?=
 =?us-ascii?Q?eYBbaRqTZ5Ln8MsVc76MwANpBZ7Psvat8QVoJzXlXpbO7b/0Kc6CXhDmjZZN?=
 =?us-ascii?Q?ux/HY1ZBrdVJFQKJvNrKExp0GtRzJquUIldMvQQS9wHEH4998dlUtW4KcY54?=
 =?us-ascii?Q?JnOc+rEWbFtoAT6eJ0dsjDZgm9v4To8XxZHnWw4Yb3c2dJiu549egZeyntb9?=
 =?us-ascii?Q?Wwn7mxx0qEsCIn4QCGrv8jVYnIZwQ8Qr4c3YzuNAhnTymQe482e+FcX/nuVe?=
 =?us-ascii?Q?s/eEKC1yKor0/m6SxOBy7WRbc8HJ1YbW3DLHeFesGE5Nc0l5AcOL+FUEX9pI?=
 =?us-ascii?Q?dYoYXm4M5djT6AZNcmrpfl9IrdfnKd3kS1TB9KU0qyq36+AJ7kxQtH+03ncg?=
 =?us-ascii?Q?gWFMoc2/P3YWW4IY5Ir+nqIIZUTuuDjy88tM2n29QY90Gk6MFzma3LmQ6NC8?=
 =?us-ascii?Q?LOVr9NQfpMIvAu2JPFZR/QjhSd7aVJttrtcv3egV8qhHWTHd+/MLCW+5aPSX?=
 =?us-ascii?Q?Q6XJb19rHJTiefRE5qGWYCD2RuJ0m7rEMBMRhr+kvS1Esqf7Uvx7LNJEe5Q5?=
 =?us-ascii?Q?jbuJtiwYLvR2F7PqgAnfgSyQKIgpxlw/DCdp9gkE6IkmbaDYDdjeOTo45klL?=
 =?us-ascii?Q?+LhNFisIWcz3sdyJQjnv2w27BPZRIIoYeNZ+EvKpsyRyL8Tl0Jkk4/tWY4+l?=
 =?us-ascii?Q?J2ocdBNw16tqmeVWP2PyOQ3Wo3Y2TbJxAEEip9VNckgKyKi7dPfgOHKpIH9B?=
 =?us-ascii?Q?1PRPHL7dxKBLmojnafSxkZkR/X9uaw2D4T7OMicqPJIQhrhwHhOoaNICZTlT?=
 =?us-ascii?Q?397+mrnaJ3raAxaMbjTg4G+94dqYda6BObMYDzRj9qLANWxUSg2uR1GqdMGS?=
 =?us-ascii?Q?5o9/Z+sTxCl8TUH6y8M41liBRBheV2+tl8P5++s2cck6ZCwulKr92hSOhL+Z?=
 =?us-ascii?Q?byeDryH/pEhr0NUFz0QLqMq/UsxZautpPHxQAdhK07cng62m4aRJzmougCou?=
 =?us-ascii?Q?sE1vysRXEfThfD1l7Ro2SkK76zXdk4ce0ldXSwr0iEFvziKXY4I4aitW/Mkc?=
 =?us-ascii?Q?MHyeQvQQAOQjmDhqXa1f76f/Gm1QaqZ5tqNFpbk4wqTAK9Lq5/Grk2WOuPAp?=
 =?us-ascii?Q?O8gw74z4DFnsgBEtvX7E+0RrO4kC37lHSjjBZl/y6xbs0sNyls8/0aCBqOzj?=
 =?us-ascii?Q?Ht7U59mWLCAavIJOxPBhJSe4IELtcxfmLGdzsuQDpXB8ICgHH2AHrJmtTqgJ?=
 =?us-ascii?Q?HYJdTqXPgimMB9lTrW2L9yT47u3p7MKjZV4CZxF3eW6JM/1xNJKRxJaI/jhi?=
 =?us-ascii?Q?S3xQdkMuhFgSk3PQsihxy1HH/dwMf+Y1sjAy2SS5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f29a1278-b624-4435-9ef4-08de188c55bb
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:46:54.7677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSLMajMVOrkbLoPjBA0ipnwQtQ846NAjrA+QgtbputQbEKvbZToRszaXEFtlWW/CLRctMhsk3rzrzMs8hTwy+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7759
X-OriginatorOrg: intel.com

Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistency cannot be addressed without refactoring the API.
> 
> system_wq should be the per-cpu workqueue, yet in this name nothing makes
> that clear, so replace system_wq with system_percpu_wq.
> 
> The old wq (system_wq) will be kept for a few release cycles.

A reference to:

commit 128ea9f6ccfb6960293ae4212f4f97165e42222d
Author: Marco Crivellari <marco.crivellari@suse.com>
Date:   Sat Jun 14 15:35:29 2025 +0200

    workqueue: Add system_percpu_wq and system_dfl_wq

...

Would have been nice just to save reviewers time.  Regardless.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
