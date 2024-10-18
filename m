Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534D205144
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280843; cv=fail; b=pBxhTcJXevto+unj0jrIs569kw3GsKsX1jMCzXNbnhYWJ1jzuEi6bAOLryc87Fgyfkdvd0Hvdw1TQzQtLnC51NMmfOhL/IBrKLA9dQA8mOz87n4GBpK8HwRVx2ElDf644tQYC+HblYXRthq5d8NUW4SnZgwAKR+bqx7TJY0yNwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280843; c=relaxed/simple;
	bh=YAbeEiQIciEHpg3bfRTflj9CY6HAu3rJzr+ZiKvPIKc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G8VMOlEKFN0gb8/YNGeJgOft4tGy/+KsQwJtSR4pLDYHlJ6TD0BTgNA0c0SPN1N5Q/CGiRqQrCCX/Ju3RnPqP3BKYJGRjiae26EEsjhF1au4yqyFcyRWG7V9iy3d86pLnM9XZu86HvPiXE71d/yOajO9LS8VyZQQzzNjsgV92uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ky/sGwvU; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ky/sGwvU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729280841; x=1760816841;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YAbeEiQIciEHpg3bfRTflj9CY6HAu3rJzr+ZiKvPIKc=;
  b=Ky/sGwvUs688OPOsY3YmSsUTlXYeZifnDEDy+hYslsrfUeLC0Huj3Ca6
   RcrK2L/E5rGlVRiJQVj3SpfYWglD0BshE8t70AVKOc7J11jcbpiIwdsyq
   G9feelV4EtErl3RdFzdYZqPd9tjxvphRbh8d/G0TBE6M932dcJPSIz30m
   zLbDgQCss7A7hdwn93OW5pQHKu37AWXj8hsX5GST5MUvipi0hmmRuqlXH
   /yw9zn3paCCGgcm9mTjf9ySpLDykNBoed+ifIT3+CACtE7Z35G8CIwL0e
   z8X7PdnS2lUjFoKTEbw2mEph3EHsR+kCrYbKfofbhgu2uar/3dpVJFkwh
   g==;
X-CSE-ConnectionGUID: fhJzn/OSSCmCVM5LOwvfHA==
X-CSE-MsgGUID: KsZ/C0ylQ/ag6HDEO3TTZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="31688759"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="31688759"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 12:47:21 -0700
X-CSE-ConnectionGUID: c50Fv2WURNWWvOMuwywgpA==
X-CSE-MsgGUID: klob/AjSTYaWtGB6xFVLPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="82917267"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 12:47:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 12:47:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 12:47:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 12:47:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 12:47:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neFZP4c1y0NPQB6c+ey4QWDaLZUiaqaKZ+y+nxUgfonLKcvvJ/jomcALEPIqi35Fs6UQ0lssCUZH8HRbnwISUCnfHdRiS4PdMEohggqbASXr7MARe87XyZT/c5mwIMCJPxv/axNNl1+ix0RxupclrmaaAgqM4E+/Abi3c2x2yyzpXesDiO0w4MD/GWv1NoYJc8r4nNmKau2oGmpEROcuXDMzvCzjFrQ4/6F2WaldxXewv6n5oKgTwUkryEtrRrgMLYka/+G8dWoE8qQsWWXV5IpDE4kNeA05lIiy0xCgd7Qec9Cp8zXnUHRnMJV4j+4mWBsGj63cpNxerjrLpUEd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYidReMZqL8zTtB57HhiLucea1zdlIFx4oE86tZEXlE=;
 b=koU38Ary2XAd35Gslq7dymU7gMYWI4jqVzcxrFEElijD9Mfw4yRDbctO4ba4BdwXdg2rrH67OukXDXnnklsYzN9l4sBbxrNGToRVR1ihBE+H6BFhre0AQtV4yNprkh+I4IGx55cbd/dY/rIFZkr38GISbNNac51z+KtN5OZH2kPACfblCbkMHaDUWzW4oqFmJkoWkMIqFkx6sXcEuPtbZ7qcnEWPpHpsiXFCbzbGgRN/A/WENx8CWgpUpLOT4AdPw+yyls/NX+dnq8XqMmS4xltF8Ef7khYwyXS2QEErQF7/J1qFcY3p3kDDWyiR9rd/bkFE0k6iEV0SQAADgq2TeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 19:47:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8069.018; Fri, 18 Oct 2024
 19:47:17 +0000
Date: Fri, 18 Oct 2024 12:47:14 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <ira.weiny@intel.com>, <dave.jiang@intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Li Ming <ming4.li@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] cxl/port: Clarify add_port_attach_ep()
Message-ID: <6712bb425d4e2_10a0329445@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <172921380683.2133624.1708770961640157143.stgit@dwillia2-xfh.jf.intel.com>
 <172921383206.2133624.16072155083340676420.stgit@dwillia2-xfh.jf.intel.com>
 <20241018120401.00006e7a@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241018120401.00006e7a@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:303:6b::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a0b1e6-d4f5-4f99-bbe0-08dcefadabb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ygwpto4Op/kLASAOp+CzEDfzFqPQPzZjsFKyGeFtZcu97EmfQNYANkAAmQdw?=
 =?us-ascii?Q?BKK8Yh+CvCdEu1juJ024Usa7iZqV/jgNNmkhVaOz0zKkQ57W0nMx9wSid7EX?=
 =?us-ascii?Q?N61tkziMV5RdCROpuk/LV0+Ufwp07lzfoSyNFk8+eanlvUPHBgyiLbHVtzBj?=
 =?us-ascii?Q?C1QZfnzqk4igRnAAR3VcxrJ6ozkGm9E4Rt42sV4EqPR7VWTVpMWn4nEd9rHE?=
 =?us-ascii?Q?wdsNd2OWqm/cpvmz0osIy4lfmC+lcSflVE+z3oVQNficZh1BPJAY63m60bbO?=
 =?us-ascii?Q?8Ln/XyYo/F78wMhV10zohjwn5fSk34RcVB91XxaZ5shdFQ2KJzUzuTXU0itk?=
 =?us-ascii?Q?Cx0ouEHAAaM9oWASGaPybZdPWj98Ia+H190fXSmn4XLLjczqjGB+pXlrBQSh?=
 =?us-ascii?Q?1/ew46pkNn0c3iAkCEuHh7T0f3QEZYHNlU7KMUNglbiTvsO1b/zdWodxZvdY?=
 =?us-ascii?Q?TVM8ufJjXC7IUwU0DtSfFp7pgzFpHVHMpst39FwkkMxuiwjrjpWRl9qKIRsT?=
 =?us-ascii?Q?KP6Mj+oSuxGHB0DA5scx6zabzNKo+iTigx3wioMUaFhP6xLXLzTr2jeFvIQW?=
 =?us-ascii?Q?D4cQIOVLJYRVEHVJ7Ksn5wssMk+kw8yftzJ9Qfyb8He2K7fk9ntAKS2hHQkW?=
 =?us-ascii?Q?o8sDx1YPwSSvXV+OCJNjAUPcYplu6/MOCbnzyArkyesKSol9ZG5jauaWZ8P1?=
 =?us-ascii?Q?JaLH9DF6J89bWgzgdD3tonk8jp/QfgtXdLfKUdyJt+wzWQxQ9q472+JDk4Af?=
 =?us-ascii?Q?gUgxnBmbF4kRnJpBK1ZOT9MafEYjj2rh53d4WqMXBge4GeSCb43YM7ESnb8o?=
 =?us-ascii?Q?q8K4cKjjApGu2SyENXzPGIHPVHHgojK+vcgLcnqhl4YpM4FxZpBWNY23zrMS?=
 =?us-ascii?Q?ve+lzmaafj3fE6dfOx2UTzYYA8ddmMVOkwOX6NhBbMxppHA1arGS7HU57ekr?=
 =?us-ascii?Q?fEzkJo+LewIRagn+TbvugHZSLYt4Z6Ui27Dtf/ZMCcLX7NjFn/AX64HkKLGe?=
 =?us-ascii?Q?CiTFe/f9LrtE1/Jj2ivA9a8W2rRvgcKCVyteydoRvSCaRPJqRGtVHdoeDV8l?=
 =?us-ascii?Q?87YC6xF3k+cYKpY1pvA+IfuajuqVKXx6z83dZeLiYgYMi9TW0dt/wByBFCDY?=
 =?us-ascii?Q?GqrdM454Bgp+oRKlyq5Kw1iVEIMzJ4grZxuyss0pUqAWwZ3u1CF9qrNBN4IP?=
 =?us-ascii?Q?iRmkgu8bOPoE0cWD/kr12LYPM2ATEE18j8clGGEHIikteUIVCPw9R5Mqh0bQ?=
 =?us-ascii?Q?CkGeVAt88ZNKKPGTA67f0zQOfFvEMi1bYIlZcVB+2YQlvmlhuHob0JCnh+VZ?=
 =?us-ascii?Q?uXWAQEFMrMNPNpCH42vDwgS9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p5zAW1UQ3uR0WlGkGUqhdTtDWeD6jaTUC96AkQTF2a18tU/pmIdBM77jcNmZ?=
 =?us-ascii?Q?KycoFPNGSdPppk0go0zIq7RSA+68k/k4PQi20MtVsduQbIssNnfgQmVZGd8D?=
 =?us-ascii?Q?zxpuryt5KoBA9A71Q/7Dv8THNpS+9rRhRfzgzbLzTA7bDZmNsOfW0v7C1wUt?=
 =?us-ascii?Q?JpcxlpDPMQcKZKlmhQhzl3YxZM4UoDfVzsjtu9KxFk2QBXh6ex7QLZikkH99?=
 =?us-ascii?Q?4bBF8RaeiXW9QpDsupbsMTq2FKTs4uihcI67Ec5F5jENaw/exiwuRDitdAvF?=
 =?us-ascii?Q?lqfCyULiApqs4s8Y9mrkx+cr2iF9v3FdeB/KockJThJAlkCysJ1cFY9/aZhi?=
 =?us-ascii?Q?4Owle+R+50nlWSjhY7qsNeFOabjAVYSz6N0GTPMUcDii4GgyMo8xHS96qsUi?=
 =?us-ascii?Q?lwg42n9K0RqjlFGuFveaM3ntOuST0aZHMMz2r8z2TwuHRgzeAw2S+mNORUb+?=
 =?us-ascii?Q?LZfSbfcHlE0NFkzHloquz+A64KlQpAD3XiLBii+wBkxBO9g8umTw08sGqXZd?=
 =?us-ascii?Q?kpvfzPnwARpZnYrApCluZCy/AZ15zVtk2cxjmSz6NJdy8tKHWLvZV8zI5/33?=
 =?us-ascii?Q?Y1LyFG+HjM7IxN3YOvq24+/rK3YyJLBkPbTaStuHUz66yJ5Z4+qdmf7AEZq8?=
 =?us-ascii?Q?R12/5BxO1rB9aC4r22XOmCpKyL609wpC+W9o0h3JJbVSAMIZn6xk+5154BcS?=
 =?us-ascii?Q?IomEAeoTY2IRmhw5Ifjz+VyXSs+IuQZ2IWan1TAeLLD1ewk6qBKrzqbNJ+ik?=
 =?us-ascii?Q?2Suu8tYUbBw32hul/UF04oAcRUzIUiQ4sQ34zNjWmArrCT5XxdxQKIHELTjQ?=
 =?us-ascii?Q?Xll89XzbldMypa60zEHb0GLK+0RXTZVDSGMGbsQ+OYqkM/hwE1svPKCpR/9w?=
 =?us-ascii?Q?BmdynyYnGjGqOh9fpS2KQ/M7zR7wuSNaBTk/HVCVTBwUHJ4tuiHxVFNwwDVi?=
 =?us-ascii?Q?qXzFeOTKCMJBEII7MvHB+20huPeN42iwkFcumstWQWPUpF7V2M6Q24nk6RbV?=
 =?us-ascii?Q?ZbMutZp9fMO9puj8mtHv0gkyyCZV4ls2HogDfZpCF8Z+kAK3OsPEY3nVJVVD?=
 =?us-ascii?Q?Qv/hpNqhRHTacHPFYFxp3IKWzeP7rawxFs2lITiBJuChvXcSP8xVsfYvV60W?=
 =?us-ascii?Q?P30VxbNoUV2meXeRMmumxn6amjhbbn9z2xf2Todd7AkAVWjJD3vsYBoeHaI1?=
 =?us-ascii?Q?PDgwvKBb+7PLC+/PnpJkzpG+Sr7lrW7PGYEKlnKCyWZRRnStzRCIPahOh3/R?=
 =?us-ascii?Q?qU2P8US8I5BYhA7YTyNbVMYY/Ajgu48Hl+UqZjYwysVSA1XG7YxMrZnkso2Y?=
 =?us-ascii?Q?vD3sSmEI2ljFq87HyhlCjeI6nK/iMFHsoOYkBykHtxEGXgF3dzcWIleg5NMP?=
 =?us-ascii?Q?kt5OSXYf1dMPcY1BRhFXiZAmcJiGS1OEgFmu4LjNjUeN1j76ByCSp0VyKBU+?=
 =?us-ascii?Q?qQl2A4dfCgLhWfIiC8+NiEnh5NWg2OwCnmnjMWV1J7N6foGv0smuFxpeAkgc?=
 =?us-ascii?Q?aCFzZD59PosRnu3fzvPxB9qCMK407ZadZIMbg1IirWT2/6m4al1mfIWu7KlR?=
 =?us-ascii?Q?zZsIWscGoqcKF4ZYUa+vLcjgAyIz3sJQ75ZTBHoZ2nAClEzyDzj1/N1vtvvM?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a0b1e6-d4f5-4f99-bbe0-08dcefadabb4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 19:47:17.0374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IVCFhmehkHAnkOWpBN9CCWW8MwExUz0y9jlKABygzSd3nuwLdLV2rm3M7oLYW+OTX2lDIGRZ3o1VKt5PqVrleKdAPVDGWq2usgk9dJbAqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7200
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 17 Oct 2024 18:10:33 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The subtlety in add_port_attach_ep() is too high as even static analysis
> > checkers had trouble following the error exit logic [1]. Jonathan points
> > out that at a minimum the 2 acquisitions of @port should use 2 variables
> > [2]. This patch goes a step further and refactors the code to:
> > 
> > - drop the redundant uport_dev argument
> 
> Feels like an 'and' patch.  Maybe split off this first trivial bit as
> a separate patch. Also a move of a comment could be done as a final
> patch to simplify the diff of the important stuff.

ok.

> > - move all device_lock dependent code to a new find_add_dport() helper
> > - clarify why the @port reference needs to held
> > - clarify that @port is not devm released on failure
> > - create a new __free(put_cxl_dport) helper for this case of passing
> >   around an implied @port refernce
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: http://lore.kernel.org/2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain [1]
> > Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Link: http://lore.kernel.org/20241017181244.00003e1f@Huawei.com [2]
> > Cc: Li Ming <ming4.li@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> A couple of trivial comments inline, but definitely looks much better
> to me after this!
> 
> Jonathan
> 
> > ---
> >  drivers/cxl/core/port.c |  112 ++++++++++++++++++++++++++++-------------------
> >  drivers/cxl/cxl.h       |    1 
> >  2 files changed, 68 insertions(+), 45 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 8e6596e147b3..599b1a4caa70 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1539,14 +1539,63 @@ static resource_size_t find_component_registers(struct device *dev)
> >  	return map.resource;
> >  }
> >  
> > +/*
> > + * Check if @parent_port has a child cxl_port that hosts @dport_dev.
> > + * and if not create a new port attached via the @parent_dport
> > + * downstream of @parent_port
> > + *
> > + * Caller is responsible for dropping the port reference after using
> > + * @dport
> > + */
> > +static struct cxl_dport *find_add_dport(struct cxl_port *parent_port,
> > +					struct device *dport_dev,
> > +					struct cxl_dport *parent_dport)
> > +{
> > +	struct device *uport_dev = dport_dev->parent;
> > +	resource_size_t component_reg_phys;
> > +	struct cxl_dport *dport;
> > +	struct cxl_port *port;
> > +
> > +	/*
> > +	 * lock serves 2 purposes:
> > +	 * - Resolve races to find/create a new port
> > +	 * - Prevent found / created ports from being freed before a
> > +	 *   reference can be taken
> A breadcrumb on why this second one is true might be helpful
> as no immediately obvious why holding parent would do this.
> I'm guessing because reap_dports holds the same lock?

It does, but the more straightforward answer is that it holds off all
devres release actions. I'll update this comment to:

/*
 * parent_port lock serves 2 purposes:
 * - Resolve races to find/create a new child port
 * - Hold off device_unbind_cleanup() triggering unregister_port()
 *   (via devres_release_all()) for the child port before a reference
 *   can be taken
 */

> 
> > +	 */
> > +	guard(device)(&parent_port->dev);
> > +	if (!parent_port->dev.driver) {
> > +		dev_warn(&parent_port->dev,
> > +			 "disabled, failed to enumerate CXL.mem\n");
> > +		return ERR_PTR(-ENXIO);
> > +	}
> > +
> > +	port = find_cxl_port_at(parent_port, dport_dev, &dport);
> > +	if (port)
> > +		return dport;
> > +
> > +	/*
> > +	 * Note that this port is only unregistered when @parent_port
> > +	 * is unbound / removed, not if this routine returns an error.
> > +	 * It is a shared object across multiple downstream endpoints.
> > +	 */
> > +	component_reg_phys = find_component_registers(uport_dev);
> > +	port = devm_cxl_add_port(&parent_port->dev, uport_dev,
> > +				 component_reg_phys, parent_dport);
> > +	if (IS_ERR(port))
> > +		return ERR_CAST(port);
> > +
> > +	dport = cxl_find_dport_by_dev(port, dport_dev);
> > +	if (!dport)
> > +		return ERR_PTR(-ENXIO);
> > +	get_device(&port->dev);
> > +	return dport;
> > +}
> > +
> >  static int add_port_attach_ep(struct cxl_memdev *cxlmd,
> > -			      struct device *uport_dev,
> >  			      struct device *dport_dev)
> >  {
> >  	struct device *dparent = grandparent(dport_dev);
> > -	struct cxl_port *port, *parent_port = NULL;
> > -	struct cxl_dport *dport, *parent_dport;
> > -	resource_size_t component_reg_phys;
> > +	struct cxl_dport *parent_dport;
> >  	int rc;
> >  
> >  	if (!dparent) {
> > @@ -1560,50 +1609,23 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
> >  		return -ENXIO;
> >  	}
> >  
> > -	parent_port = find_cxl_port(dparent, &parent_dport);
> > -	if (!parent_port) {
> > -		/* iterate to create this parent_port */
> > -		return -EAGAIN;
> > -	}
> > +	struct cxl_port *parent_port __free(put_cxl_port) =
> > +		find_cxl_port(dparent, &parent_dport);
> >  
> > -	device_lock(&parent_port->dev);
> > -	if (!parent_port->dev.driver) {
> > -		dev_warn(&cxlmd->dev,
> > -			 "port %s:%s disabled, failed to enumerate CXL.mem\n",
> > -			 dev_name(&parent_port->dev), dev_name(uport_dev));
> > -		port = ERR_PTR(-ENXIO);
> > -		goto out;
> > -	}
> > +	/* iterate to create this parent_port? */
> > +	if (!parent_port)
> > +		return -EAGAIN;
> 
> Just to reduce diff and hence make this slightly simpler to review,
> I'd leave the formatting as above.  If you care trivial follow up patch.

ok.
