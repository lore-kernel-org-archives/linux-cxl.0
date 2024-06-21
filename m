Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080381514C1
	for <linux-cxl@vger.kernel.org>; Fri, 21 Jun 2024 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992272; cv=fail; b=thDYJa4BidYVwr418GnR9rVPHWPEmg/1NsGpmcbke+jt0Kv8+wTMslEVf0+bQlbQ82FmnPrK4QvkSBLbxuFtkUnmKDZpdr4Kx80wJSUJHM9vZQkUSJjP6bh4RarnQtfSzjQ4c0vLipUzKKhXXaH8zABDz9DZ6mNnp+HMxReQCQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992272; c=relaxed/simple;
	bh=SLeii5j5k5vGYEw4iDrnweH4Ox0CgUP8QDAOEhrkh9U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LuYv6iAkh4U1mzq1XU+WlRoEgnt48CUxY+lIey/72CLk7LzokukX4bIphLmIe8P7kjL36tNfGB0+0RCvM30nf74EPrJbsf9iAcFMvwYo+wCmSKQN0uEbQc3rPjcd5sCLvKAeUZQBB7Ex7c4ZU5k7LU1T8NfKfQiWEkBCz6jVUVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QijJcdLv; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QijJcdLv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718992271; x=1750528271;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SLeii5j5k5vGYEw4iDrnweH4Ox0CgUP8QDAOEhrkh9U=;
  b=QijJcdLvbXGp987DTdXNKnty0jAH6hDWJyrqjj69Xh8JU7mfIyjPE+2Y
   DwYZbKcn6aYax71gaFt4woCafgr9UH1yisYRDFNhEQwU1OZhxn5Y/T5an
   jkFs0+4EoD29hrBRU/FANdY+GtE9ANwj5/YhmOsnJI/7UqLF3zrGnDF+z
   b2cM94zUoYsmLny7jQdYBxl0b+OP4FJCwG6JCB+E2TqSNKeFdfrpaEEXT
   7se4HrWm70bGl+uX/xjze/Ir0KZLhNYo0fzdaqpgzuK8MRyJHrp3AjF1N
   avI04R3W/EFHFMPAKOQ3FwZaLQDHPbPH9f2kXnP5PhKqpbrPZNSMx+PAA
   A==;
X-CSE-ConnectionGUID: wvPTspndSGOe2qG9BFBkhQ==
X-CSE-MsgGUID: 0ISbuA6ZSj2EcN6UjhH/3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="38557255"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="38557255"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 10:51:10 -0700
X-CSE-ConnectionGUID: uv8bsZJwRdCXkS2BYLf1Ew==
X-CSE-MsgGUID: pShUpPRYR/arHZWo8JNNNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="47838398"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 10:51:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 10:51:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 10:51:10 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 10:51:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYApV3Aa+yIcLoR/tYQ7GM24iVEGdgMaFttHZMaWrKSm/9xeZ104dWoC5Q+t3LsdTo8qUEHUr1Wkf8WnyoPUNM8wqIK2VKPG1rEqr6XD581hJrcHAJEAoICEpJzr/k6orSVudHUCeEtdHZYzB0XjhGxwMITWvAde4cBUjCr7arLE7tnj2B/U7Y0O7dRa8rDp74o05YmALhQ6yu+UEomA3Zgvml4cr7JB5aKJlO+en1tm7FgRe1KUKS4MKJ9jI6X3dZ/BHKVebzf96mRI9kSpLj37uDJc1TiLLMAsXdP64YNfMOKJIEgLexLYwl3UQ22RU65f57enK7astJHIyGE5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqsrz5xEx5q/Cn3pzsYEV8OkOpHNIhZ+4o13XXfkuwE=;
 b=l6YJKOREVMb55tFbqafvZkVGT3GX2MVkxNtTF3UiTlYWa+7923hkfpw3Lb3/2Yrzzmgc3fPlU05nVr44jt7EWOkPlzJ0kjXWDVDOLfrRvPFZTuo/Cld30rov/P97kRNRd+zvw+GtqC5Lxvn2w+h1qd27KcVBO9h5SJrs6rpA781tl72+H/5Wz/+ZaDwr+VJr0Z4dRGc9rJkDSQ1P09FVWSd7HgkuMU0wXpHlkOWrPqNNLJH/jCARusA80KuKvm5B7GFtfac4d6ffPn+2Cqbfi7fD+Gd3rmsz9f9LHUkZLaEetH0W7BUmlNWlxWYMUybuy8JQqoKp0G9LIFefnJkMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4535.namprd11.prod.outlook.com (2603:10b6:208:24e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Fri, 21 Jun
 2024 17:51:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Fri, 21 Jun 2024
 17:51:05 +0000
Date: Fri, 21 Jun 2024 10:51:02 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <ira.weiny@intel.com>, <alison.schofield@intel.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
Message-ID: <6675bd86ea005_57ac29411@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0260.namprd04.prod.outlook.com
 (2603:10b6:303:88::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: 729ca789-495d-48b0-823a-08dc921ab92a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NkQJqCVLHPrJHIKnD65qDWDD/kAxESNDGEJMjJvwExHOeUx4w0iixlrYlRlp?=
 =?us-ascii?Q?A+QxDtujffwRWwJn6jgZz6Otjme+mKzHCWGGtc2UuYRMFiSu0+Kzx9866FyS?=
 =?us-ascii?Q?GECSDY+BLMgNuwnf2dc1KNRiBTvVPMuW0qwMShECxDjIX0H6dvpTcxWF/Q9w?=
 =?us-ascii?Q?Z6kPLpgf4668SvxBOLRyBoJ95twJ0BrGI92FTSRflmDghcA6HycmZS/5LeRs?=
 =?us-ascii?Q?8wSwBtOc7PecmZxYI61+L9Zb0g43S/HFIWe3w1yqLj+XpK1MRMWIpLoLNHof?=
 =?us-ascii?Q?pF6h+JUdAIoV3AWRd+o0VT37GNTInCvduwEBOv0VTkASU8SkgHNAamuVWviT?=
 =?us-ascii?Q?cSN4zh+qLbC3qzDgxWf5Bi3bwli6q8ESkaCqxTK5WsEm3/L75NBVCaNB5M3u?=
 =?us-ascii?Q?u3gJNCQMKTf9XmweBQN0Sk1oldo2czz/RZ/Lqab7XB193GUyP7yhfu920/XE?=
 =?us-ascii?Q?NEkO5ZZvl86C0VWXrhMX3CvF2yzz+X82W/xzocASYW1qSNaZxLYM9IseMg96?=
 =?us-ascii?Q?43py+A33Qm+sXNWkibVhwSKv0xmj2R5NBhL2/BlJBgR+xTQLDOBX4bLy84Q0?=
 =?us-ascii?Q?7aQ4tpOKlhfRMF3jEnWDDj+D7sWB2vpx36EHU2kLJMwg4I4ZMjwWvbqm9HdN?=
 =?us-ascii?Q?pAJWVUHtYViu2eTRgLJ/C8Z3aynyGAjXcTuYI/d50Tl3V69/iwQun5FffKu9?=
 =?us-ascii?Q?9h6fIFaI2/5MVMyZAAcqjApD/r1nHq3QCXiDZFWKTqHK2wkbYI0xBXPdeHn5?=
 =?us-ascii?Q?cR5zy6CHKzMZKbCXeGC0+o/YKqD4pw1XZUivoxF58UbmKPZNiT2xEkwKy+gp?=
 =?us-ascii?Q?MHieLSZAbKVQOgKTqX4SrXSSdKKDsBqeOyB5Q/gypAz2UleEOrJzpttuygED?=
 =?us-ascii?Q?+Ipeb1kumB8FuO1pL5XTL8BduVgAhHiswkZp0wYc64Gykpnx5/Sj0fUw/mEU?=
 =?us-ascii?Q?1E6sC8Im5MCZuhbXIhW7C6rmmpTpqmhvQbIa25D5aqGvZ62OEi9wJQTfYIXS?=
 =?us-ascii?Q?+HBSRzLazGr7Qc7WCE1DrTpNDOSjBK7YIHbZq/VBbm3ypDb6BUFZdfuDtYKe?=
 =?us-ascii?Q?+k8LCMLOul75WtqlXWX1KW8/g5WTljrzi9kPtvE2/rA7zg5gIwTAGAYb41L+?=
 =?us-ascii?Q?VSI9Qo8nqbw/V05eELnile2z/sejaNGrSHtlGT2dq/X8tkxfBD5HKyER3xvP?=
 =?us-ascii?Q?GxDEakKNjDXG6oPVKo+6KUzyzFlhTox7fKF8pF+6766C6F7JLkqQ8AOaXbof?=
 =?us-ascii?Q?wEPsOBSvbDoj1CwV4dR6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HxbKeavvIaa7QgACgLcqE0bVidB4iC7fVZfSbaDzqbHi+FnZtgGPKMsvJz6n?=
 =?us-ascii?Q?ZiA3+xV+GVQ/aZ0acHHVzWnfsMUU45LkRtkBHfcCd6jPu9KkAvmr/jqqu9bV?=
 =?us-ascii?Q?XYoNsCFdXD+BZv4nJiA7WUPofQqmb+u8N9ncAUT3I5EsoBtNkwUVDa5k9G1Y?=
 =?us-ascii?Q?YXZuw+UYpIpaNWWlWz+NSClf6dwukNuVLAKpLYOJZ5uQTSSu1eAxwBZGqn6n?=
 =?us-ascii?Q?COVY6yJne8gPAwDEqhlBC72PEYxb468smwjo0NVv20FvJG+sekv4QmmqfIix?=
 =?us-ascii?Q?eJDB5TarId3S3VNAA2kROQREHE1H0Mc7uHz+eDvFcPWgP1ZUg1mLGqwAnOes?=
 =?us-ascii?Q?UIl914rE5+lPycAe3aAdH9EKArB1VViK12eWZa5LtWymMVEAWtdYjYtOyAJ6?=
 =?us-ascii?Q?/sV6QRFqLsky5PvaEYpPq7Mv24SW0pkHtWHWfeDZflRVoZi3KnpUInyMgsgw?=
 =?us-ascii?Q?h9eT1XWRg271E1jDFbWTVRlGRzDxJB9CeuoHzBS2Uar3zerTlHx/ynnKlM4N?=
 =?us-ascii?Q?lKpdzVpZJdMumhmr+Uo2KqT3Y+zexTImIbJivHdeglSjFECX/8StllrInnz2?=
 =?us-ascii?Q?UDINLg/Mv6psw1QfsZfu0HHGDxDdbqcZX27o9VTQJdhhwfK2YT2Dxcru+lNh?=
 =?us-ascii?Q?e9ESRvJtybd6k7GGu65Y+KSSuRrmBWAPBfAg0mx5FAw23weao+9xTRRTHeCl?=
 =?us-ascii?Q?9bvJ7fivd1p6LvzyXAJ5p8ci8vIvVbyepUvAz5pcTfgBtldRFZTnwTJIzX6T?=
 =?us-ascii?Q?U3O7IfFWYtVT2oqMSGjLkya2Q15wflHkZiUVvv1PUAfgpoVYGyUnq17ypxxT?=
 =?us-ascii?Q?xvgDzipQfopb/acfkpRltomqAMNB7iAQ6evS7X7BIvUGrVyjwlYMdgAH7M00?=
 =?us-ascii?Q?cXl4UZ8l3ekg2whHxssCN9k20+kZzXLQEihT4WmrWar+vYlLm9LBNu9aWK9M?=
 =?us-ascii?Q?DjOmf7qeWvwZPXmxNcrdrv42RjbdZLCtkIsOQBMeQRABGEiNfVG4VXGNYrrs?=
 =?us-ascii?Q?ijE2M11fkp9ykn0aAw1wi5FkAnvH0ktsbp6KkvsE5MDb6ke5QjFIlVj/QOvB?=
 =?us-ascii?Q?vVvVrj5EaIhRD2urAuOZPzsiEya+a9GX/icZCmfIzMXFawUSdZA/HVX7Grn5?=
 =?us-ascii?Q?MmfDr8rFjJRcGhH9YuGFXN7uJZ1EYhiyDPYL5tnfinvJn0VCdMJ0uz+Pvufs?=
 =?us-ascii?Q?YxkIgeXnmacqjUCdOPxhvRLAP7bCpfdzKa/QtCNP7PxRqBB0U0lykQhs57va?=
 =?us-ascii?Q?CgNZgMfOl79AAU4D0Kk0caZ7zxf5sScPs00cxyQ9sp+lQbL1/hy8iP8/qxNq?=
 =?us-ascii?Q?VhjE+p+XjV5UElabyZxkccmF0HAtmN7luECy68OZ9f2T/VTWxedwfkFrEEPB?=
 =?us-ascii?Q?2/2gDL5li4vJXcrxpqmi6e2sVWMo/2g/F+Ul7hSGLvtRxHQ7BHEWJXj/ed+m?=
 =?us-ascii?Q?jSYjBS8Gtl4Y/RoHaWXWsLT8Az6KtsidzQjNGb7tJnXY9D61rMI+K/E776iR?=
 =?us-ascii?Q?TVX4vlKH+VtlL2Jzs3GlaAUdHnXVI/Sr0VRZvwD+ITj8z+U2S/CApcfNIpOR?=
 =?us-ascii?Q?66SIeKjpfcX5tOQxzc8XobGrJ6SgehPl5bJ2S9wvsfevGzHMj+evP6Z5QAgm?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 729ca789-495d-48b0-823a-08dc921ab92a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 17:51:05.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2E3BBSfNjYXtaJWwjcSBYCg3r3f7cgs6H0yrrpJ/gu28BWEPMcM1R5CPPjTkiKJtqxPrcw0vJk2Yb3qdz+qkJ72fnM3/MUmWFh5JQnAKsNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4535
X-OriginatorOrg: intel.com

Shiyang Ruan wrote:
> Background:
> Since CXL device is a memory device, while CPU consumes a poison page of 
> CXL device, it always triggers a MCE by interrupt (INT18), no matter 
> which-First path is configured.  This is the first report.  Then 
> currently, in FW-First path, the poison event is transferred according 
> to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES 
>  -> CPER -> trace report.  This is the second one.  These two reports
> are indicating the same poisoning page, which is the so-called "duplicate
> report"[1].  And the memory_failure() handling I'm trying to add in
> OS-First path could also be another duplicate report.
> 
> Hope the flow below could make it easier to understand:
> CPU accesses bad memory on CXL device, then
>  -> MCE (INT18), *always* report (1)
>  -> * FW-First (implemented now)
>       -> CXL device -> FW
> 	      -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)
>     * OS-First (not implemented yet, I'm working on it)
>       -> CXL device -> MSI
> 	      -> OS:CXL driver -> memory_failure() (2.b)
> so, the (1) and (2.a/b) are duplicated.
> 
> (I didn't get response in my reply for [1] while I have to make patch to
> solve this problem, so please correct me if my understanding is wrong.)

The CPU MCE may not be in the loop. Consider the case of patrol scrub,
or device-DMA accessing poison. In that case the device will signal a
component event and the CPU may never issue the MCE.

What is missing for me from this description is *why* does the duplicate
report matter in practice? If all that happens is that the kernel
repeats the lookup to offline the page and set the HWPoison bit, is that
duplicated work worth adding more tracking?

> This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
> to check whether the current poison page has been reported (if yes,
> stop the notifier chain, won't call the following memory_failure()
> to report), into `x86_mce_decoder_chain`.  In this way, if the poison
> page already handled(recorded and reported) in (1) or (2), the other one
> won't duplicate the report.  The record could be clear when
> cxl_clear_poison() is called.
> 
> [1] https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  arch/x86/include/asm/mce.h |   1 +
>  drivers/cxl/core/mbox.c    | 130 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c  |   6 +-
>  drivers/cxl/cxlmem.h       |   3 +
>  4 files changed, 139 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index dfd2e9699bd7..d8109c48e7d9 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -182,6 +182,7 @@ enum mce_notifier_prios {
>  	MCE_PRIO_NFIT,
>  	MCE_PRIO_EXTLOG,
>  	MCE_PRIO_UC,
> +	MCE_PRIO_CXL,
>  	MCE_PRIO_EARLY,
>  	MCE_PRIO_CEC,
>  	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..0eb3c5401e81 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -4,6 +4,8 @@
>  #include <linux/debugfs.h>
>  #include <linux/ktime.h>
>  #include <linux/mutex.h>
> +#include <linux/notifier.h>
> +#include <asm/mce.h>
>  #include <asm/unaligned.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
> @@ -880,6 +882,9 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		if (cxlr)
>  			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
>  
> +		if (hpa != ULLONG_MAX && cxl_mce_recorded(hpa))
> +			return;
> +
>  		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>  						&evt->gen_media);
> @@ -1408,6 +1413,127 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>  
> +struct cxl_mce_record {
> +	struct list_head node;
> +	u64 hpa;
> +};
> +LIST_HEAD(cxl_mce_records);
> +DEFINE_MUTEX(cxl_mce_mutex);

I would recommend an xarray for this use case as that already has its
own internal locking and efficient memory allocation for new nodes.

However, the "why" question needs to be answered first.
