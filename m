Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E843D51A;
	Mon, 20 Jul 2026 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564838; cv=fail; b=jB60xP/oDvQt1xFtXJd8FIyI+oW4YqXp8MT8I3PYJjZJOFFUc1X141S0HouQpu+TjTmJ7mQpCWVTwV+HUfMwd+bq1vzwgxLALglUOYFRAVymCjeZMblQGdRGrv4LSxUv5n0Sg63HV8FD4khwKMaONWzt6zum5lMtkMBDD+olSno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564838; c=relaxed/simple;
	bh=stfSIcszC5Jk7mP54Ic/AwzKErSJpy78VQhOGQPA3yc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b6mXFDr9VMO4cQ9+vTYOrCNSejtUFrinxloINsDOF3jCgzz0AM3cLMRVLaTPCPcXG5aYPCVEgsRi7Wp0Pe1mwvDSUFQ9rnCx3+Y+/BnkinIuS3vJCmFblZmbrEb0FVU6UUh/fGWa+FW/6Kc7RyNd22hteCUxrHLm3irG0dIJa7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XF8szcxj; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XF8szcxj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784564834; x=1816100834;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=stfSIcszC5Jk7mP54Ic/AwzKErSJpy78VQhOGQPA3yc=;
  b=XF8szcxjNEsbhWkh0f6k0fX6tsVOm9saG6lSmFHGfo3xrEB58clsSZIF
   a73qdBiUHIXzowLp8gf3eoRW+0Oud2olVjMjj7532YmPMG1vSTRKAKizd
   zKfFDuzIYyHD7EXiOhJ1Aa/Wj0FhmZ6RhE1ugG9gZSBtnB0tYfAT+rIUX
   ONfSB8wVun+vqYplP96FCw3tHaoI2k14Cxrkt6nWRw8sn2A/V6sgUZxp0
   5so3+grv+YvI4s7sQpEyBm0p0So5nu93E54HcDF5skcdQKyKun+6B8N0W
   4DhPZHR6TiBoP7IxtyT2m8TtCz/I1OLdGPBZQPbtTNWUXG6EjMq6H1b75
   A==;
X-CSE-ConnectionGUID: 5IKCEjslRxe4xci+w8mopA==
X-CSE-MsgGUID: Kz5LMnaZRV+IYXSitDgSvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84131465"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="84131465"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:27:07 -0700
X-CSE-ConnectionGUID: OxLDy3WeRZqEo7AyCi9/fw==
X-CSE-MsgGUID: JZp9aRsWRRm75XAEYYdfVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="254871075"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:27:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:27:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:27:07 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:27:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1+9LXOdJvAYHyorhm65FVD6MUr6aJX0IcfWBxEuHqSq8ypBkueAOGF/6swUamEjZprW2OHtsKOM3Zv4kZ7LvRmnrlL3niPQmFq7+yHLtfoYUuomwi5S5lgTvXhWmEb7vkmJYdBRclze4AsKRMmCEH6sjCt7koO2Gg2pW2z3yajCAHZL53QiMMO3yooMdWb7zTp45hfEchuzh+kjrfJIfpElFh+KZpAExKqNRZ2BT3IJ78zDgop/+jZIhP401FIIDmqUUFSL+3dENk12+WdAW5JJY7f+HJ4qs7toiXjrlwZ5B0ZixRZ4nCO+ELDMCPy5kfucdebvIVFwJV5K1OxYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2f2DhflAAvuazmd7iYqMctLrrchCAnigO1P/fPyB43E=;
 b=kD4tfFG7sdvf/Ivo4/ta2zli+pCvJNOMaGc1t27sz9ZZPpVRSwjGB1Ml+GmHjWZWmu/grWS3gjlGRbqNtAY7prAomVYIrHYO+dEW3J0OtLjikArtu4YHf01BqDpcSfqTWR3ALbD6T2GrVCqLNxEVvPSGMDyrskO8oT1Z1sfQC51hl1wm9foPnNYpeW6/Qfm+k/el41emt0pqGFxDsMxlGZiVVrl4SaE+BdLJyOH7lDJMcNZelmL+a2bVEXEEsjHSD/4IiSrF138FkL1kKHWHV15QTHdXBysxQZNun8zTg5eyKGeQ0qo8EoPr6bCNq3yRZ4RDDEn7h6jBADhMwvHkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA4PR11MB8992.namprd11.prod.outlook.com (2603:10b6:208:56e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:27:03 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 16:27:03 +0000
Date: Mon, 20 Jul 2026 09:26:59 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<terry.bowman@amd.com>, <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 06/10] ACPI: extlog: Defer CXL protocol error handling
 to avoid lock inversion
Message-ID: <al5MU5B8M60GiiRK@aschofie-mobl2.lan>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-7-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260717161647.1493259-7-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA4PR11MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c19717-441e-4760-0b7b-08dee67bbb99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: KTkVE13AV5+cWuKWBBDDm4f8lnTcFVR4wOpIaWeDd2ygiujyYADy2BR4mBY8p+7iTj/vw90FCJOeDHugDZDTbaTGSCzjPxbn8H+Seds5T8Tg+yNheFO4t0tA+9FWVCvEHbrKe+k1BLUNfd7adG3fQMIiqFMBaUJITz4pMq0LSTh83Ql7YLcIsApsuNQTPSJve2zwe+fjhFdiqawXMDRlkMB5/TIMziLTlaypJb34CRQE7rzDwuzxaEHSt+TRdbU8nrVCqJBHzAbkSyKgFu8asRZhx81KYxdKOkkQTsOS5axlK01+gohaX32ibQRSvDIvMIiX47w5k6zwOK0BpFJ39VBEa/CeC5LbB7Uwu+l2pvVioii1rLkSPe4gxh+s5pOaA1RtGp3dPJXEl4ONszNo3vaYa5JkGlr4BJdugd6awLCaA1SczlCdbzLbsU/rQhPBD9R8BWi8MtTVy6GtWE4CtTiyQpQo2zpjULRXvy7JD3wXFXdVcDNl9yrPoGKOj1msS5z0zIAb8WwnZyhvNKFMIwtjWITD+o4CUcPrxoO6Jb8uRCh27l2IiOQg27V1ldDn5K9/iwqiOJakUeN7+OIUCNcuFGUQGdblKMmJCv4ZjZQ6kN+Oc2YX/TtLt0QSpuF04KFMPYKC2A0uAEvTniUhC5GYiM/wa1C8hRrX80FRTDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+qbbPkSE3zgNAcb55uwHGTZ1tCXC1NIVvdmtf9CyzvOxYUVQyFslEP2jalNZ?=
 =?us-ascii?Q?8NEt1l2PQJR0a+YnaTpra3Bi1y6hku7jyChMaNhSj/kVnQKFPFRfSjKAevYl?=
 =?us-ascii?Q?6tmoX9NbJRe7NXqudpmzvf6E/mIV6620TmTAkBkfkFQ13EzVlwWNsfvLKHvz?=
 =?us-ascii?Q?CsWlsk5i9eB/vfGCtYtrIilCfGytSe+ehIaRY6KdT9Q2Ry5u60lWCFlgOpN4?=
 =?us-ascii?Q?/sZxYgnbVy6knIDk/ZagJZJ+i7fn/7CWxldfDYEMFDrobYaz3STqt7qGksrS?=
 =?us-ascii?Q?Ae/r63xQxUsAsm1uiMpU2uxudLJtaDiMZ5uWYb4YdMMMaWW0TVxnorVqwf5I?=
 =?us-ascii?Q?q3vvaFXa71yeIJ/laiHwYSEQRMBKBafC+6avr9ihTrv2NvjTSFVSMwf42yuD?=
 =?us-ascii?Q?J+fXf+hbrk8GHYVDDu0QyXxOvSb3M/hV5HqJ2TXbFMlSxlBGzOwFtWDO2IGi?=
 =?us-ascii?Q?3CICtdQmPCZUwAKFYeS3/5hNYip8P9kwD5uuddRc+TcaQHSaQzNTwSLt2Stn?=
 =?us-ascii?Q?2iPML3RkN/aUOu3dW0OuNIMvy5bQ86TMbh8TVia89FNkDnq5aAPKOoxi2h6G?=
 =?us-ascii?Q?6PRQjJD+iA9DmHc2E/FmSCdfyb4oq93/n0Hl6g+KKOxSujPzv5i/0/fdgNa0?=
 =?us-ascii?Q?V/xMMdW70xsDxnpqpYBNfTFbscesEgypxbLFy/B7LZ1yJV3TZFTM1EWzlFOy?=
 =?us-ascii?Q?YUm7RgZSg9+JFVefKL74suP++bDK3zkoGJDs8V0+oFAWS9KGV5zLF2nY8a1I?=
 =?us-ascii?Q?8w24/Q8WRSNZr/wjF+E2xEY9FuvQXNakdvZwR0DZKeAw60q1T1fLLxD3gPp7?=
 =?us-ascii?Q?yEEnNSUhki1byyEbkOITgs6AQMXJPOvpSbUnF+6mZyuq/97xCXo+UR0wEck0?=
 =?us-ascii?Q?CETZ7z+5kDLKAoYx/8T5xIRcx5s1D6MQrYHcYltR3llrK8mRdZsQNd7pC7Ee?=
 =?us-ascii?Q?Zugv3lM9gLZqQxiTSL3opzGQsfPrDyxf59ZqzNDWSTgtzwHgVpPenCoCOyAL?=
 =?us-ascii?Q?g1OSWU55qfxd8Z4+9oRWdOLteUQzQkpZRyvDUMREq2WZ7m8iybgFT51dL8Br?=
 =?us-ascii?Q?/GQtVl9RTIDQnhvaW9Cu868S2tnf4eW1t6EzH9ETZJR4s5Z7pl5T6+P0tc6r?=
 =?us-ascii?Q?dFm8ab/RSOt0pZFtX1C7z1bw/xjBsGGssUUOjScw3hjtSx3pYtHQ+oEtEYdu?=
 =?us-ascii?Q?7OKzxqCkI419LViwCBW+S0Stsqkzw81zexBLlyVV1yGrOzIaVFKT5alrZwxq?=
 =?us-ascii?Q?M14nn4uvxk+x524cCuOd3CxIDV01oqm84bGSqg6CBLp4lGKGq+EVrzvILoHs?=
 =?us-ascii?Q?E34RjWdhLNNVr1I1IZipf+apD3ULJFqIP/s0UDZP36ZSYRvrKMHCINzi2it1?=
 =?us-ascii?Q?+FqkN6TU5rswGOxojUTceXpfK2I/R9IFE3SQD6PLjwHjMmvMiEzOFUUbInvW?=
 =?us-ascii?Q?HN58Dpisf5K0pwYwZELSd5oTAhTvi1Lj+Hj073yDLXU764hm5keYUsJ9fwmF?=
 =?us-ascii?Q?of3SgTgU7gFYfkGXbT4c5BTxxiRSk+XPvf7qc9pb5UxYjIEsbd127tAYWBNZ?=
 =?us-ascii?Q?hQ5oJ1jk8DwoDO2o39Fu6otH/ESg/QFQLMdu7ih6SbbeLWBgG9I2dg3xiFyI?=
 =?us-ascii?Q?+3smz9rpBY2LWJdFA2p3l7F9M7sTf4V5YMglS2CikK4Nf+oypyBcCb3lGWh4?=
 =?us-ascii?Q?a/30DB/tIXL995z6/Ojr55JfAk9kqXLdlOYEU3ZyR+j906AazFC/57qvKXBL?=
 =?us-ascii?Q?K+xiTju0QoRPqoWXg8j1BdV6r8RLVAc=3D?=
X-Exchange-RoutingPolicyChecked: WgK4nmm0B87Cy0AUPBJ+xPESlN+DvOBvBKD+3gmmHMdIOCe7VnnSRLrYN5lmxq1NuZSM0am9cRae0ca9vXevJQ4kcOK8030RQNfQKJrVtfUnnWVDemI/gZkCqvqWcIMYmN3/G6m9pihY5DteFrFxzqSkVVT11gtZ13iiDUfm4RrAaQHqkdk9pJaKb1snJ/qzDXn8fHzIAgkA7jUC08Utn/LGH4TlPZuEiRPVznHdC0sesR4IWuanHYKyI27k/FnBNyqwjiOxfg8p2y5aRCLE0XDpas/AJ5Rwvc+YfgZ1L/qzYYAeUC/0xPcyi3JOUANAIZdHyQprTJ7nZdvvqdsqkg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c19717-441e-4760-0b7b-08dee67bbb99
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:27:03.8351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TM2dj16E5AgVpgaeEBv5HCQSJmAAxJiThv7rUBYfModYDRPkLU78Wz3cpKEB/S5K8hZkNIzpqNgMTma/zCB/clgiRNFxEtEM8ojiAeqXco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8992
X-OriginatorOrg: intel.com

On Fri, Jul 17, 2026 at 09:16:43AM -0700, Dave Jiang wrote:
> sashiko-bot flagged an AB-BA deadlock between the PCI device_lock and
> the MCE decoder chain rwsem.
> 
> extlog_print() calls cxl_cper_handle_prot_err() synchronously while the
> MCE notifier chain rwsem is held, and that path takes the PCI device_lock
> via guard(device)(). The probe path takes the locks in the opposite
> order (device_lock held while mce_register_decode_chain() takes the
> rwsem), so the two form an AB-BA deadlock.
> 
> ghes.c already avoids this by posting protocol errors to a kfifo and
> handling them from a workqueue via cxl_cper_post_prot_err(). Export that
> function and use it from acpi_extlog.c instead of calling
> cxl_cper_handle_prot_err() directly.
> 
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
