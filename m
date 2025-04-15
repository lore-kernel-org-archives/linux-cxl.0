Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7950257443;
	Tue, 15 Apr 2025 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744752625; cv=fail; b=Y1KptAoPG9HPb783HX1z79Lj0G89s3cvPHJOSNnChcZAmndmI0DeQ9+wB4qQrOj2ImYLlD6kh6TjcT5kzol8WkIXAgIpeOlrQj7LGbEymjQe5LsmP18LS0MjwPZMMvVLUgj0kvohTsvD7FYW+q1x/heZ6LHyMNU3iyV4qbcldyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744752625; c=relaxed/simple;
	bh=46wyz+HVKWw7a7kGZ8VhKh59fzWvPR4XawzHCCsGG+4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mQet/X0ckl7nQ+pGWqijTCyOUmdUQo5Als0IARjhwl1z7hnCWEp+muN0gukcCjmesxhhV0t/wH5s8gsrqkwplgeLXfFAGg0086B3cNwMgj28La2ClA3t6HYji0ist5B21YpSeogRiGnzCjrcZc13XZk8mchmUBdMV/PFLzv3LD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vmfj2HBC; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vmfj2HBC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744752622; x=1776288622;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=46wyz+HVKWw7a7kGZ8VhKh59fzWvPR4XawzHCCsGG+4=;
  b=Vmfj2HBC7qoYgTQ/CGu6TKYRTgTt03emmEZNXNwJqNnH0x524cGTnEGf
   jrAhZ/Ecnm2JtQTiVSQ++3ciFHNPoRoUEWwFc7q3L7MbyaV3QiKXEtxDF
   27KeRJrvhW51mB4iTseyW06aQ0ETxFArJ7g83FbPk9xwXDrDB1NtcT9ZE
   VsRV0RuwqMVJ2yHuT+jmQLU3ux6e2Y4zZ3V+yZ0Xxa3ScJBSN6CMq4ELa
   ZLe1ooybPTaBBCv9vsj0cgB3NQCiq06A5R9guFyzsGmlFtlGVGh16WP2l
   JftRysjUEyRizh+UTcw7FFh9nh1sQMTiS0pQ9dE61/ryw1rGyH7pR+zoq
   g==;
X-CSE-ConnectionGUID: NUOowHKuQP+D88pxf5AaWw==
X-CSE-MsgGUID: F37HyYNpT3m41FCkAyYXqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="50105327"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="50105327"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:30:18 -0700
X-CSE-ConnectionGUID: ryiFkG9ORIyCOYK3dYlQ7w==
X-CSE-MsgGUID: Y7rh5B6TSQmR85HaCuA5KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="130195528"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:30:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 14:30:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 14:30:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 14:30:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqmEvvrvBNOw6KepiV/CygqINtUMJX73CLPpY3KqNLuUjFAaIZFnCB5ILejA8r0KcjFHC1sba9smlmZDlbNf26+46Ja6rh5S/VxTibE1hVPik6QAfDAcFcA9ERImLwbI+JRjTo4FR/V+evGP/HtlUpAIQE4zb2pBIvk7s3nQ0htfJI8aWO35+TneD6iDT7lBy7yabB7XL8oagBswF/yxy16WqUQ3c0GddOz3ovTeABrPeR3LgxinoMIxQDyFbuP+dTPefwilvPTdTnZT+oOWLrtl5Ki6B8xM0LsH60HOOYl7dc8gb6u/XIb0GCHTP6KGkPNM4RnoBaXdSy/ErsHFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUvy7D/cvGU+txh0cd0X2UVLZgpETAnbvVaRQbEG/AI=;
 b=XfyUL/+rZJ8ks18W4qmn/ld9pr0XjqMxCzJDN2ZScjjl7p00cW0eRe30PmaDuc7QU6Chu2AYFDBWE5sGtxxpSz5qcx2BTLEw3yiR+vBBfZz46wNcfYVF4MdUa7K/8w+sUcWhEMSQ15Db5JZD/bOcn56jxyX0aSBHlQ7pLazJN+OkZmFWBVDFFpgfY49NJrL8nWg8dScGuGfYALPjBDeTwZEiM4bTTONPSqwj8DuyPvh6BGVrNudK8yTm13dtiqSyIn/dVcpvlWjl4DG80uuXlgAKnSN7te19EMtZra2wa8eo8f/1dQcTTLDCMgU1Pn9MV3C+Ydxctr3OSFwOAgvOpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS7PR11MB8827.namprd11.prod.outlook.com (2603:10b6:8:254::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 21:30:14 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 21:30:14 +0000
Date: Tue, 15 Apr 2025 14:30:10 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v4 03/14] cxl/pci: Add comments to cxl_hdm_decode_init()
Message-ID: <Z_7P4ny6RFgewnbC@aschofie-mobl2.lan>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-4-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-4-rrichter@amd.com>
X-ClientProxiedBy: MW4P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::30) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS7PR11MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 164a014a-8498-465d-0afa-08dd7c64b572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5dOhewopSzrCCd6jBPK+bgYWex6uQ1XJZFheDssT5TJmzf+MMq3JG6NTemaT?=
 =?us-ascii?Q?4OppgmKaVpA8+s0krDuotFXGYwGKcI9oUuNDz9sF+XKccLz3p6nTGAVmk/0b?=
 =?us-ascii?Q?7ogqASWEeOtW0OiF/Jzq0nCku/REiIwXMhmeZ1zZuxgKLxa+i8nqiZ3g5YBo?=
 =?us-ascii?Q?d08mraz2iMKqn6aytC5w0gK/+wgFEIBZn/wLU+VIL2MhbJIBGcVUcK9vSox8?=
 =?us-ascii?Q?E+tutaXfRXPbU4owk1k1SP/vuB7MMPBd7DEXkz5TtDEL1z1zfj3JjVTkXy1W?=
 =?us-ascii?Q?jpBCF1X1cxsDm3xDfOOQDOU4o00jsxI7QPBd2RokwwUTZpYZJ6ksnxabV475?=
 =?us-ascii?Q?zwzrFGgJJRWpYwjjeB/mOyV2S7ZM87nuQD+9JZ6X3BsVmuTQzKH9yHIGBSHU?=
 =?us-ascii?Q?ii6VTG+FVC3fjLkqstydjA0alKOo69qUVGP1V+29kiy6fsL7Sf1T4jVF4tN8?=
 =?us-ascii?Q?6lAYYc0W2ByaGy18cFX3OjwXLdGZ+ypbuh0lUJacmAzkaY6gncskVvEoO80M?=
 =?us-ascii?Q?WS4Wl493WhAR89rU2OOE+qFZCdqiU2MtTI+Ht7y2WldLnKb8vk2vsLteaE9t?=
 =?us-ascii?Q?5NIMGHaW1ovSGy9rDrG93P1/ctCbBnmjUVOkmHJbKD1CF99YL0LQG5j0STpS?=
 =?us-ascii?Q?CthXuWiPX+FlNNlMqJuuv4ssWfNvB7ORf7JrVRg5Ko6yGdwIC3fuaiChNWO4?=
 =?us-ascii?Q?T8JXB4nWt70+HcqMX+m4aHt74yyMajCRN0T3j+HroM0rLAXMu+vFHpFhJR/k?=
 =?us-ascii?Q?QZ9dO79iZGVwgZhjCCNSEtTmne+80w0+fyEuCjHFbL+TcaYe9v4dqDDW3gqM?=
 =?us-ascii?Q?0IupTOTVv/BvEVHqnbLAqVAOR4TSs4TfYvsT5emptiDaz3DQP+oUxVkRYJsr?=
 =?us-ascii?Q?ziYxqNdCvQV+lsec3ltLZ5SETw+c9rSIhUkfonrt/fTvw45UcOfPIA4z4HFI?=
 =?us-ascii?Q?r1FTcaFd4BVS/N36nUWWodNVJ8M4nOb0ueL+4evYDbmnsNOhLjTldLQn1sWG?=
 =?us-ascii?Q?ri8+1dnyd2pI9j5mWVkYZ/zdmldzsVk6bRkFAWtAPYlQ5C07+fkMd5z4wnnb?=
 =?us-ascii?Q?c1hqwnY4XpAM09f1BujHbp084clEo7581UukkHUa+QCBQ6atES6o32irdAaT?=
 =?us-ascii?Q?1mQlkuHbLKsK/lnMHs46pzG3w6DDtFnNRGvqDmSU3QNh1uDl4HOABmCgDUJX?=
 =?us-ascii?Q?x8SpAhmnlkYCY3TvTOrAwAcod9FSKgwsMtH/mYYUwg+3m8ip2UkiyoRxQqsV?=
 =?us-ascii?Q?rVOQL/Vnp08EHXJ8nNrA/fep+fn1cAgVvdATxXC/gbMhNlrR77HBhbDP4w8d?=
 =?us-ascii?Q?Wn5ZCzRxLeiIul1Dnk+zBBukTbyz7SINXplpwbY+vEorhLjQ6VPEQhgCaCTE?=
 =?us-ascii?Q?nynNd4n1vHt6o2S2B1T+KGfqURjG9KGPb8jJzTywoVSH1DphWItRxydK1bLa?=
 =?us-ascii?Q?Q/TlfDk3FwM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?po7u91D4LbaW2hNTdoeksMLin/rrUJR+ROg5PtCXquuNWKfydLGv56uvCmxv?=
 =?us-ascii?Q?Ub1bxHZDWSwsAtYefxIbQBxTBW1eiFrQ8UcIqfzbsUxBAekDFYCjPnkjAiOd?=
 =?us-ascii?Q?ADJLAS4S3/rNAzN1D4x0Gp+jbyMyJpY73FFM5WX6MDADAuUA3Nv5mXZyROOE?=
 =?us-ascii?Q?RkVmnjSqsgZUYtJb/4MlYC4+DQtvcFViLdZNowswKSdDcXx674+rg7LozOP+?=
 =?us-ascii?Q?cVG2tUFb/1bwC10WyEc82wgffUhhC/Q/hIxkl+HGlorkjgY8Awum+eFCfkr6?=
 =?us-ascii?Q?dZy4uTx+4g0By78w3l8wDbL8nGOelBhngNLp8QWkTByP+JLxBUXPcYqTnV94?=
 =?us-ascii?Q?+uYQL3z9IlTU99AZaiLo5ry24pWgKwwR7U3gHv8PDLZXk08oWSqcQotwDZnx?=
 =?us-ascii?Q?NDotboW0AZq1CcIGLOFWm3Bx/5RmO9Jq6l6gRcLfAVmpTDyUK4+E0oUQntPF?=
 =?us-ascii?Q?mloLCG+rJ4tUG9PD+VCnFcuDzuhneTmwBj7if9KOByQAqNIudgcYcUtgBVbq?=
 =?us-ascii?Q?RZ3555g0KQCcTSLyPBaW1yViQOCu8E8uNRvGP4Hpwpcaqd9HUfJtx5EKkFJE?=
 =?us-ascii?Q?CbnaWPFGJ4fmn5MeqRD+8mP4dzXg3tWjeBkUp2WFRTifwhnyBJRMqd8TjAPm?=
 =?us-ascii?Q?s4h3n3Jab3ZqovB2oXoJTX5D4sx2j50uN5nwH5y5BagyleqDyhhopCMOCsAP?=
 =?us-ascii?Q?3SzA3M6yzjCNpgYWA+FipcSF65sO/y6vD2Vdx6hFcI3s49CiN+iOYycbbCWO?=
 =?us-ascii?Q?jzppg15gFTI7U3wlnMQs45e7y+Y13GpxEolmc08BVVIXowj2bRwsXoM8VOLV?=
 =?us-ascii?Q?3k3SGQKLD1YZjj2nbtsA3jjjorh5MACRnIfpthHGFgTfCelQ1BI73FHzp9mC?=
 =?us-ascii?Q?bns3xSyJxI+A3Sm4fNedr1QGnhpestvFCBj7+/NO7ou2HnMhRGikWvs/ewHy?=
 =?us-ascii?Q?glDdUVDmY6fHc5qy4dJzznci01ml80AaMiR801FxPyW2WbdGF2YFI7tqNage?=
 =?us-ascii?Q?dpsvVwXbC7OzT/rpBZP6cGLwAWVUD5qjjJgQF5iwjUg7SguYnTK8Yd/bnl0k?=
 =?us-ascii?Q?tFi/c8qQoEQSp5x5Qf4Vy1yf33nbGlw7ZOjBTmCJdaTYkLmsCcki6pmO0/GL?=
 =?us-ascii?Q?yagnf/qDi+aDzWmp2y7F7vpUJMjzdau8SCuyz9XOKxq13s9f5yGqZmZwUhHA?=
 =?us-ascii?Q?42f+kZ/Mria1fuNS5WT150AGgUeSNSqZn3hJKT6M+iwtyBYvQ/Flc7KwqCjC?=
 =?us-ascii?Q?MwbKhGZsCLzt0OjlifEZPP23mD47YuiEyJupN4n+Mt3iePslcHWOHqOQAFMu?=
 =?us-ascii?Q?vIu3VXkZrTMWXXjVmEbF1UIM0lPgdoHnve6z39Sg3HqlX28590+eKnneuEoq?=
 =?us-ascii?Q?JOuBQa7X1g1OlMhY/p87JTwcnmwf5zRcZ0UDFhLYJy+VCbt3PCj/1wRmiHqU?=
 =?us-ascii?Q?YuO7tqbTPCphyEt+dATeeK+zJt6X1ZQ7V/9yEAHTIiHk0GFApGafa/Rx5nf1?=
 =?us-ascii?Q?tFIJh9qlPBfclNTrDEHVn13e5O8gGAmGxyZk9afVWlf7Ht9x4O8htADvNqgQ?=
 =?us-ascii?Q?QeblKR3+A2Zpzo/oguaazOfIxbiyYVT6lWdww7FeY/B2PFuHJX93bkf/OnEh?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 164a014a-8498-465d-0afa-08dd7c64b572
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:30:14.1240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQHneIKOtQlcOiLOO66SVPKoCqOhDszX+t9xAlcdzAW6UQgxacz+Nt6ijLKHCUPPu1E0gkd8twV86agSokE+FN6xF+RApDD21EfPjfaphag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8827
X-OriginatorOrg: intel.com

On Thu, Mar 06, 2025 at 05:44:37PM +0100, Robert Richter wrote:
> There are various configuration cases of HDM decoder registers causing
> different code paths. Add comments to cxl_hdm_decode_init() to better
> explain them.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


