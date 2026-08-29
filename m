Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B263F106E
	for <linux-cxl@vger.kernel.org>; Sat, 29 Aug 2026 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787963497; cv=fail; b=fYc/8h76AlF4FPD6j68qRp3O56180VP2IGLriUKWaPvP+Sr1mszvtM/JOGTma89zpNQqkfH3gHEwivAMTJmi4YM9UU9Bd8W7WYhZtjqXmSoHbH81lbKMFS32JlNMeHbM2r+T4Q+4b/oPgsHg9rMVpDlM+n4h7rsj6DLDCHoSeFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787963497; c=relaxed/simple;
	bh=X3uGIkw5x+vg+Sfe4BZnQpVRxtIUgBlk1CnrUcJbYVM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GKl+9pHFZDLOJTMzfJeO7AhGPqFW7VlHSwwdztXGuIVH7MUO+fSdeXcwt0I0lUx/k5dt2jUTm3W/8eeisQTsib0rco7VqOK0/intxpA3tKqpTJM1DurK40aPtkwayrcRwCg6mzeyzG//9dDZmFfDHh36ZvS7k+gRsz04dz3SDvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VG2DFnE+; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VG2DFnE+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787963494; x=1819499494;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X3uGIkw5x+vg+Sfe4BZnQpVRxtIUgBlk1CnrUcJbYVM=;
  b=VG2DFnE+qup2246cnuSb9+att02H9yTS2KuwCQT/yDVkAZZ5GxHP70EC
   fTF75dWhoqGoPX4pMoYx/csef4KljQmM/01lN57MPXyb5q3TAQNl9XpWE
   SFter16Dmf5zRyAj+UzRKcnPpemjiwg0NOQ2vXxbppnWrBzfk0N+GFa37
   kDskVpGNgtPWsEvXarkzt70E7cFNracQ09WcweLX7KtOJaMivV43HWjNj
   8wMnnffPWacfBysPUPyU7xfT1J2Rd6E/gyZ0UJ2eSQFMkVtDZnlAEp7BF
   tMjLI+pg9LbOKmtwy8RwqQT4D6ox9de/F2otDE4+dH1u3gSAG0ixyqauB
   A==;
X-CSE-ConnectionGUID: U2ZxCdVsQJGbLvZbwJAnEg==
X-CSE-MsgGUID: FnYB7THWSPGKzmmEMpTfDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="105999628"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="105999628"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 17:31:33 -0700
X-CSE-ConnectionGUID: h4IYgMEgR2yg/XHX+NosIQ==
X-CSE-MsgGUID: 0xIM0hYwS3qH7XJyIl6dPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="262198215"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 17:31:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 17:31:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 17:31:32 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 17:31:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wpe8+xiWZd1cwi0A54yzsth4fTM+Cpx1MSlVw/KKk8rs484zdUG3QT8lCLfecymoJAlmGskBzyyXQ6tmKwdVjQiCe1mRqKzQX29XmQG4WPQGnQaw1HE9Sdlqm2DKRvRVsUuIauzHkpq88Q4Z/j0L38TRE99BXbG/7PuSSwpbfRd4yiWUTTwLMxQQu/v0SH/2xRRjhl6cFahTscwYT01SAJQRxZLgcWFKQatz5c3hgum5fPROha0X9q5TrD0VU95JPC6ayvvqpb6IK1anF1kAjdh8cQ6672r2Rs8TYYO8eHn/1Lji35k0CiHEKCIeJ2ZKGyhYVUbVCvz17iEs+FM3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D9tS/32TEz0XXi0f5POsqphAyG0QhOrWlKnQhP10Bs=;
 b=VWOKOrOfAANsXKRWWYSM+NXaO0Zk8UBAzIgJPstSK/qJloZXrMq3F8UwPjQiJ73VkEI31YMwwn+HUk+YiT0mXrEKnVwQPArc0b9BJxGZ50A3sPPhK/jBMsiG3bs793pmBHxBYenVC0UC0Ofso2pGdKNFNezvPUieOn3SAhaGxHuh7e8ljWf7dF/8bUKVcf1078GBUMjCwYYSSUbvD/dbHnps4Op/acAgYXcXxpgdr+OxQ4qDTnZsATwrYnohyaCr8e1JtPPsIpSja3GW4X4FKeCwFRzsYAwQJOk+mMIzRbBhyRp+xerQeDgWgCMf8R+rjiDQHb3Izf0kfHFJxcqNzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB7755.namprd11.prod.outlook.com (2603:10b6:208:420::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Sat, 29 Aug
 2026 00:31:30 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 00:31:29 +0000
Date: Fri, 28 Aug 2026 17:31:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3] cxl/core: Fix dport use-after-free via the
 einj_inject debugfs file
Message-ID: <apIoXt4WQiMdVef_@aschofie-mobl2.lan>
References: <20260828074752.3336779-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260828074752.3336779-1-kanie@linux.alibaba.com>
X-ClientProxiedBy: BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: a24b35b8-8d31-4cf5-abd2-08df0564de61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: RaUtZFxSjc12S5sNmIK7i6ER+fgMSj9r/TCjTJowH4taHhPhmZ/1/3HNPEPySrSaMpVIJ07NzeBOLnO8hhKBKkbFtTH4f7pfwq+b1/CJ3M8Ueew6fBzCcg+Q6n4GD+URXhQBub0AJ3R7c+74B2uVO7lQZPLcGpnZiX4K8DJukPZOo8/c1u02rwlUupEdccw04+59a3CAZjoFfXjN2qD5rsSK0brto81PV/pvdjIvZzGlKP/3a1T41A0tMd02sDkcZwDLnxSWdbf7mLCBHxaePyLITk8aKgWaBmFS3keoZcADgf7gOj76U0Ltcj921o5LxzSiVkyLJWZrcbPS2hHbTFnRhDn0O9ywd7o9gWjgs1G4S2Fc0GXpykXzWMuqlSgt+i95i/MEDjtqG2Q43/cZnexVxQ7YiPs+Xs6OPsTb5kDLFEU5vWscXF4RTiKKT78EiGPMRkmeoV4yz18HvZoGvN+gwA/UaDmbXX69Q4ctwbNAl5JmOJf/utH4zJDfgVI+7D4VPJ8f1HwfuPNDhl3d70H+qBoYWkUqlSbHwzklIKrfFf8S0CUJMMr/tnJR3jsL5+WM6VHNqQ9GuUikl4ZRzAG3Uw0U6znLFf3O5zYg9l2zutWmkIRKtE6rOdTsnEcwljsxTaAar0XrDVcvHhT/W5k/EJZHgCxgNPKzAz4yBbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?juIkq2UfefmICg0leWVaxrKMbtzlMFbydupV20UM33MHgzkteTWbRLCHdQ3P?=
 =?us-ascii?Q?VtAbnreSb1nK9ZgzdtUjaI3sTqINZFXhubPmWzV9T1EU4BuRTMr8C3SdOk/4?=
 =?us-ascii?Q?/CWZnD5f3hMYmSjjTpj0J4cyDP0HlKH07To2SLbhN89q394hmVdkxImhaSvD?=
 =?us-ascii?Q?waizJLalguaOXb/zToi+0NRNnBC+0StNqIOJ6x2GbP4vfG/t7iNywFvOVQqo?=
 =?us-ascii?Q?ZwhHAbM/ttsfVqooPcCprXBv/gBGwgXblmysY5/k0gnpQuHEp+RpDK32X9oB?=
 =?us-ascii?Q?6y5OQMBI9WbN2Jj71lXFLotYm1aBxWedCnjeu5EBVumewwYX2HkFtu9RO6kC?=
 =?us-ascii?Q?W6y8tUnhzybvRR1Mgyi1e+RFARndnQa0Dkuf3S/jpywaRuxY6cvP9bk9jxhe?=
 =?us-ascii?Q?vMlbPQ5WnxI3h+jJvMrgjdM2DJCqVkXgsyAP3PXbjdlMfaURjo1UFsAsFvNZ?=
 =?us-ascii?Q?r7XwRhCLq2RgCcr+kymMXRuLarl8gl4hHNcFX4BdfVT1S90zXbkX3mfS7l+k?=
 =?us-ascii?Q?nWhdezL0BlB4gPzBXauG6G6bDF18DjVKIxDFsiqpob5WKWwuowJD/r9eEUcj?=
 =?us-ascii?Q?US5hxK2N5wIXsBVxHDJ03GQyN/9qUrdutXtheKs0SeMn6l/8dWeutlnueIRe?=
 =?us-ascii?Q?n0s+38Sd5S0WQZmaqOavXRNEEKNI6ikrh1lGzoyBT9c3k+L4HcX2e0HnOScK?=
 =?us-ascii?Q?3rD97zKR5P0bajwiqyhXdZlOHdQJJ9t8TLCwEepQWZ1E0EbuJsatqiKDkwim?=
 =?us-ascii?Q?hEZpG050sWAtKS+2TYFHW8wmBDGj+8Nw31OPiDBuaylhDCWKrAwlPBsJnjJu?=
 =?us-ascii?Q?jOczhwyrNLjvWv08rhfVgoV53lyKMgkm9kpiyV3OUasqfl18Aasj5uohQliF?=
 =?us-ascii?Q?EyEHpJWsH+/vuV5ce41h2YDQZBhuSjmamlFors31QOvezWKbqEwZdL4KAEwK?=
 =?us-ascii?Q?fpcKpp1/UFwpLH/KcuA6+IH7DffAYsObfOiFMG5H3OZmBcmXKgWOy5EkJf5t?=
 =?us-ascii?Q?8OzrNQu065FypYL7cEvwVJPHbNFiTaX7pSDDBBbBVLnNZXOblHCzFMgHXvps?=
 =?us-ascii?Q?Q6GfxkCf7/R6asAHSOkF8poyDWl46zdiA45+QhO2Xzo9GK/Dz6+9NG29uqtp?=
 =?us-ascii?Q?GkpdqIDcZ/+2NtApW3UVL/8h3sO02SFqSaioD09X30UIW4wLAaOU0axjFz7V?=
 =?us-ascii?Q?geZLdHcqTQ04kGVrytYTMTOO2cHOH4u9hxSzDZ8i91XqhxxHqPi1mBs9UZnf?=
 =?us-ascii?Q?8sVHfYG38g8JpDpQaJlavZ3lbiH2kfKU3q5rz3n1qeFJaycYcqFOyd8TOebH?=
 =?us-ascii?Q?oaVEeRhYgvot5f1s4UzBHqGWG/T5rRC68EpFxdKw3DHHbELqCAI+SmD/tXwi?=
 =?us-ascii?Q?9jRb00k6DeLOKGtmjcu9Z15V8CoqgO1x2e+oJLewoIELX2GAsNd2ppHBkDVF?=
 =?us-ascii?Q?BgmnsAomChFFHcFXrikmLeHpsXQsDiNx6Kdm1CZhW14+hmlx0/3ODGvNYzEE?=
 =?us-ascii?Q?y1QA539Z1OTWS+UOTn7VRpyHMC30+j6FTyrYG7dvHLPl3baDsj9Tbg5Bkbtx?=
 =?us-ascii?Q?bF6vvEGNvnp4IjZk0k/9d6BHmuzUBHOAHIMiz+h3KhWMfZKdS+vUkNtw5J9f?=
 =?us-ascii?Q?f6DuRpZBEyFkTKsGqM1kgo1iekZVo1qzQ6fiEAVwqFXE1PKUx5gqt/xZzfJJ?=
 =?us-ascii?Q?v8neZpJq4i5RZlNcI4NSu1wcCiObmgCvYEZtbBQUZzCglaJXMHiHA9IIsWrD?=
 =?us-ascii?Q?f0Pipttj9xpjOtlYlEgzCGkqDxniqWw=3D?=
X-Exchange-RoutingPolicyChecked: Qtc31wyr/K7wNOiGOHCcHlq5fW9VOgv/FdVuJn8gmcuLkiWwe0Mj7uHx3wb1c5XQyRRi49+oiDM0KZScZNa9pqSqmg/WLavOassQe4u7+/TsnoXQFVGMhRwq3kIaL2J4oJcgueERgm0JaMO7tBqtMiU/kmoHyA0KKYXGlkqG11Rhg7ZS8ggm3iPk0jjcbQ3K76rb1rbgCIMwcZ1dPJzYFy3Hovpf9y9ChgQ1nG9WuyB6W6zXdUaC+DmlS+/EZynTWuYx3a/of/zblQ9hump/nzbII0aBUnfW+YKzdZJMF26PlzIbsRk0jPR4BakeSNeLzYgd7LcAuWy4Hxe5NXqE6g==
X-MS-Exchange-CrossTenant-Network-Message-Id: a24b35b8-8d31-4cf5-abd2-08df0564de61
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 00:31:29.7393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7odKpvGJ/nAuL7ozd/3ZrhalbQ9oyIwYFK2XYiLevs0kyu2momwxjP43Qv4dLnmEevkYEtspbF2npu4kcKQXbtCV68G3bPRAfftj2dWEyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7755
X-OriginatorOrg: intel.com

On Fri, Aug 28, 2026 at 03:47:52PM +0800, Guixin Liu wrote:
> The per-dport einj_inject debugfs file retains a pointer to the
> 'struct cxl_dport', but its lifetime is not tied to the dport. Unbinding
> the dport host frees the dport and leaves einj_inject behind, so writing
> the file dereferences freed memory:
> 
>   BUG: KASAN: slab-use-after-free in cxl_einj_inject+0xa1/0xf0 [cxl_core]
>   Read of size 1 at addr ffff88810880ac90 by task bash/1690
>    cxl_einj_inject+0xa1/0xf0 [cxl_core]
>    debugfs_attr_write+0x61/0xb0
>    full_proxy_write+0xfc/0x1c0
>    vfs_write+0x1d4/0xe60
>   Allocated by task 213:
>    __devm_cxl_add_dport+0x1e1/0x14d0 [cxl_core]
>    cxl_port_add_dport+0xd6/0x200 [cxl_port]
>   Freed by task 1622:
>    release_nodes+0xfa/0x2c0
>    devres_release_all+0x113/0x1a0
>    device_unbind_cleanup+0x76/0x260
>    unbind_store+0xde/0x100
> 
> The stale directory also prevents recreation on rebind.
> 
> Remove the per-dport debugfs directory when the dport host is released.
> 
> Found by code inspection, then reproduced on a QEMU CXL topology with
> KASAN (the einj_cxl_is_initialized() guard had to be forced open, as
> QEMU emits no EINJ table). Unpatched, writing the leftover file after
> unbind gives the splat above, and rebind hits "already exists in
> 'cxl'". Patched, the directory goes away with the dport and rebind
> recreates a working einj_inject.
> 
> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>

Thanks for the changelog updatges Guixin.

DaveJ - KASAN trace could be left out upon applying.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
