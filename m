Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2756422DF84
	for <linux-cxl@vger.kernel.org>; Fri, 18 Apr 2025 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744940713; cv=fail; b=ge0SG++e98oF+bxUELujO59S13aDVXQuIwaQRBpeRF+5VWv0YbcQiY9Zawve5QMCPaEs37VBBwZyEJ3MgDaka9EaXt6RihsKOTJgAAu/akOU6/POr0zyxLHG3WaK+lG65mMdT9DutsPKTrY3wEvCa7UTbzP4YuXVy1QsxAXtPW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744940713; c=relaxed/simple;
	bh=4trB9u6fVVZ9rh2LPQjnZbPjIN6wQ1y1K4KUklFOCCE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j3JetiWQTYXNi+Hh/oAxWZm/DNFSe3bjDip5cQMZgIo80iVU/aP5M64qb+cB9Mp6TXdWPpq64cD0CyJUbopDvk6cu3Ars+TFxtM4ZkAqKKQcSbAdL9g7K3QWswJlpgiR1ckP3aT9kP8lFJwAsK57PIC6UvyXalYMpH+Gyc34HEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HB48cMWP; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HB48cMWP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744940711; x=1776476711;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4trB9u6fVVZ9rh2LPQjnZbPjIN6wQ1y1K4KUklFOCCE=;
  b=HB48cMWPsqCTx8mRZs6wlQZhDJkCtOzAnjM27zx4fnjOFMeVOLO2WTGo
   gWwomgMLwQYOphvHab7n0eXbU99gNDqkG6Gm+I5PtNFeRa/7+Afd0ndoJ
   DikJUSuwrPVm14UVhlXK3kc/AqFND5uF7LmGpQu2eYeN6B+drZm7nC/9n
   G4kYSWm1nzN+eQU/ZQYoSt1WqDZaee/m4gqe849rkXZ1iIAl9USgxFASO
   tgzJNEMBow7BFX1JpjzBT1XzVAEUuXIfFwU7K+mdhQf0iwlNdD4TeIEJg
   yhKE93b7eHWAC0cJNrXksAQYnsvY5wbES3gB6HX2Q2g30jT7cGWU8qr7b
   g==;
X-CSE-ConnectionGUID: crib8LsSTYyCt9JyZkOVcQ==
X-CSE-MsgGUID: 16Cv8onaSkOve8NRC+O06Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="45693574"
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="45693574"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 18:45:10 -0700
X-CSE-ConnectionGUID: TGIxDqt/TFqZyntPZv8/Iw==
X-CSE-MsgGUID: D5Pa5WujRLuW3DIxgI2uuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="136096457"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 18:45:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 18:45:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 18:45:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 18:45:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJFUx8087Gpa4Y/5wUdfTL33dRq3JsNxAH08OFKtAIfz8E7B+XTlcb9JsKxGILeue9WC7iQYYKABev0ezFi7x3TytrHiIwcJ10dHncJXrBEpSXJc3SpGJgqdVb0zcpqqRFXhn9iTdmwlWCmhcnO5rDPgKZj8k7mHQ55ZvJtJ04w9J2+0gaVGIV8UuLfewOHe6KX6mzrukJ68PefEe5NyanDPK7rxu1PGjGh/tPQaLWHgUP9Dy5z4VPyk+oX6j2YxKZXS2nVVdT9usQVgraYWEMkI/hhLKw3PDkJGTT0j9EAXcUARg0V0teu4FwxztkEZejqGYREQZ/ghgKBdWIO0ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2WP0vtpLRjrzdk3JiCt2O9gmtWeIBGpw9r+zwcNLgo=;
 b=PvIv251M9riEcT+CeXyAP5X+niHyw+SD55Hp7R8lWjDwH8iRUspd2/lbLI15B9L2ir1UsBfx0kR14/PnmdefxxiDk+JQ6p3nN58YH5NGJxqTf11yNAYOtFMdDmivOfYmW/jHLH8sdFd3Ixn1hyY1RWJRRZtQ8EiEk/nsB6V2adA5uh9swJMfT4oJWcU8qMKs8v0ofMpEmXefS2KrcKAN1LO5aK49gGgXlZvmMFWtnzPE2fP4f6jF1Rv3x/RWPhAyAUHW920i3QoA0pizp34c4f36Hp6Di0VixONvl7eClnTfNmf31K4a3waYiNSH3LCBqFdxweqzE2FKERJ7a00BNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5318.namprd11.prod.outlook.com (2603:10b6:208:312::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 01:45:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 01:45:06 +0000
Date: Thu, 17 Apr 2025 18:45:04 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl: Fix devm device for cxl_fwctl initialization
Message-ID: <6801aea053466_71fe2944c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250418002933.406439-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250418002933.406439-1-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0223.namprd04.prod.outlook.com
 (2603:10b6:303:87::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: 475fb7e6-0abb-432d-6770-08dd7e1aa54a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FJYwZ2oIlKuWqGvSkmlY6hGC3k4ux3OmhBzbDTMY3TgBP5C84tgAqs7xCCXo?=
 =?us-ascii?Q?4s6lgxBHp1GAiVNgjwSoSUElSA6D+sSQm/vHVMyCfw3TRmrpuh2dhAoAyaE2?=
 =?us-ascii?Q?qPxcnDuYtvos6V7f+I1u+gQ7P449DdO6Ph6H7qc8YFI0+5LYLe5mp8BfoVRk?=
 =?us-ascii?Q?kj+CdbS5nrVKSSO1Tsy1vOkZzZvSkDRx/Qglv9jr1yXpXyApsW6csjbd3JCy?=
 =?us-ascii?Q?2Uw/qXbFi6ckfXPXVqrO9yJRb83EQHmzyY9zApjXrl9IDedDKn+1chb4/8NN?=
 =?us-ascii?Q?x3e3lg072gCRFr0FVhtNqdeC3oXR0tUIxwU0v6xtgJkkqrCbwPR6M8DEWgHK?=
 =?us-ascii?Q?P5yJi//xQU3FcFu/jVF6N93p0D1nI3feeJuOEX/dPjovRHeMpWCxuLQLlUBx?=
 =?us-ascii?Q?zZVORk/UWk+gQH30OwXm5dkKUzyWRi+LnPXRvf4xmkjQk2rq64majI4TZAeZ?=
 =?us-ascii?Q?xZSFaSoF6jwhad9t9Ujb1vea72hGkGNNOXbvQTZZOO84clHlifo8JiL0n2b3?=
 =?us-ascii?Q?X7lFwwBBIT6HS1eAzJfB8yTkQyR5uUcXc1va3FFd4MNcKO2+epB6peo3pTXG?=
 =?us-ascii?Q?4D07FgE0mP4rPQczqOp4YRkrBgrbSAURwV0R/17G7fgoJFbwIaVgr16JaGcC?=
 =?us-ascii?Q?kiv9yXbo/PJDyfLV34t7+g6/606fRJ2N710jqYzq9/6UweCb5XLkaGmIl3eP?=
 =?us-ascii?Q?x8lXaWReQImmj+aqHH1hqUUYQK4fLdlyqiiYR5M/syYz/JDHu0ebLYjg4Nld?=
 =?us-ascii?Q?shgJZHW7p7DMDObwc5q+77LmnLt6h98MuxQvA71jaDTal3qM+5eEACzRRlZH?=
 =?us-ascii?Q?EKTafHbn0jR0zLDeH/8FYys9JsKDqf2DqU7cRL+cYK+rqK3uduOBLP2Pt1qk?=
 =?us-ascii?Q?b/PAlILC9kx4Um2gqUTeG50nI8GRWa3EByqwy4GUz5HvHu2DL06TrlOb0ybV?=
 =?us-ascii?Q?N/XwShptnLGH9FIlyqewsIUBqmGaOWeDepZV5z0kiO8v1mMeo0mUkbUu2IVr?=
 =?us-ascii?Q?H7XGknD/4WJVjvl3HDapyjyAA+Ag4un+b7ERXZv1sdKYPRgbpYN4frOXTAs8?=
 =?us-ascii?Q?+OIaCL4yTZhDT9IjkTp0ijxcmuDQ1HNCLGwlFfAoglxetvljHFuA5gUZ0wLy?=
 =?us-ascii?Q?cdAkJDMni+FqmSbHNUEDFYOu/P5XJxxNgl713EEW/0I9NmMQTzyL5VarzMmd?=
 =?us-ascii?Q?/Mn/OkpbUdBS+TVoJy4dACmNhhwfclfOe5CkDpm88vooabJ3HiX1CcEA1ds6?=
 =?us-ascii?Q?AbuSAoqOz4q22A86zCMfa2N9s2pLcR8FeqgvJcniNvVFhG0j0NmwI5SF3IDg?=
 =?us-ascii?Q?n4JLGbIaUX4/EBXGCqteUk9qsoq285d161nbOplK2VX40sH1UWDPpOVK6m7Y?=
 =?us-ascii?Q?v7cAcIkeLLDB3rWLtuHlKGYWhJklXTNoAbUEFLsA6eXbMB55vyp27mRoSQEV?=
 =?us-ascii?Q?TdPjTHfQhn8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jIM8jwOlVqSPPZMJjaT2Y9hG18q/oruB+Sym/fvZeZGqqssjAvRYRORHsAYc?=
 =?us-ascii?Q?r1cXP92USTnqDoXXD0wJvvIKd+6zRivEhiPQTnA0JkjHslEqLhm8BPUC9XDN?=
 =?us-ascii?Q?MhIBQR6jexBqA9uefgeWyV9BJ1D6tkcvP7gMCgDLnz6SGwW/vvTG+XLI5uXL?=
 =?us-ascii?Q?Q0U2Fa0gXaY9cD1FcEPaMt8mv5VjX0OQYOjIpdHXer7MHMQnVGfn1R8YDyEB?=
 =?us-ascii?Q?paKnVALqkuuvXiZ4VhJn+dKtzr9vtmLmPfdm91pr9d0oQFbBKb3ToOlbMJfm?=
 =?us-ascii?Q?x/5B6ZBuq44AM62QhnEcBfXs5yTuxG0HBaXcgEgmvH01WKxmAtQ3ryf5iTvY?=
 =?us-ascii?Q?a/a2E56n03AMGa0aXZB/y48othg3QJr2YEt0q0k4MFV2eYyDtshkItCzLZ52?=
 =?us-ascii?Q?xR2aynappF95kGo2a8bXD2r3EvfRwdwEf9gTNc558g4+hPmHXVnTasJ/LnDm?=
 =?us-ascii?Q?e/UHa1Qjrq9oGxvZHDDVeZ8LQN6aolwh0Zr9+BKaTTNW7I0VNfrOTXqE2z4z?=
 =?us-ascii?Q?BmSrHXQtkJ0N480dL87YVA0J/b+jsZ8B6V61DKw/zBF0Nr5gBot9zFRrW5vE?=
 =?us-ascii?Q?6mVLyh5mPwOLE5sfhgLa2SMFLyT1cS5saG4GDlsdYKLhx/VcF02LvJg+7yY9?=
 =?us-ascii?Q?xtKm230pNfvx+0BUtWk1r3rqMO/IPYL9StLWyI+RHZKg75o61wM0ypGlNpWn?=
 =?us-ascii?Q?a7jXsSvYG7zfsSU+ZlK/gV9w+90IMvnORMhHIulCmd8WP9HTAA8kzfNvKaDY?=
 =?us-ascii?Q?0iJ0V3ly/Epz4pgbb29SeaKvOQj9y1C1PZet4D6A693tZCF50lKfeeL92U0Z?=
 =?us-ascii?Q?SQD+/C2mjjiGoXZ1q1k8bEMPV9fVVwn2jNDKWrAOZ06Cs/LXh3x+2d2MDEg7?=
 =?us-ascii?Q?D1huQ35XZhHv6s8OcW9ATaQCXRavmDP1r1ZKfplAAhfS/kv3GkVxJ2NZAIfT?=
 =?us-ascii?Q?eBblVI0WTCu/9E+aPmSPJDhS67SojRDfXvnel5UFYuOA3mWycRKBeC0qg3sS?=
 =?us-ascii?Q?h67E7sx1QvKwSriXpQVsZ8rO/wn/2nz+OcHtZ8oWFITE/x8zLf/IeFiucNNu?=
 =?us-ascii?Q?Bwl6mMbG1qSH21voBK0FADd2ISVgFL3imveWBMBORDMstcsRYkgc9Cczuf8S?=
 =?us-ascii?Q?pHajEnQBQQmtA4iLkW/Lf2TmyjglA33BAy5DTFjuGAqrmjmKdJ/Y4pda5VCp?=
 =?us-ascii?Q?tb3GuWMM0xJK1QXQTIXvB/lX8CPL29F+H6TojECbfU0Sdk9RXhAgl5ER/A++?=
 =?us-ascii?Q?KUhTonSUn+wu5QCD4XO+OxjnyYlDt37nO+x1xJ8YR5RK2+UDGLjbcBlQ2bDU?=
 =?us-ascii?Q?dtx3Fo0lWJxoCwtryxIxEOCdTf2WuQR0ujPPDh0brLI9NVp35ksQJK5BClcl?=
 =?us-ascii?Q?mq+fi8G1AO0USEdWkSobPSeqS1oz6x/sYTLV3kvGyJ36EZZ2EofFED198iHy?=
 =?us-ascii?Q?BDsTRmXhjiVTEUi5LasZ6IV4JH6aMGFB60HIldtieQG0gx74kOOPNdhDhbQm?=
 =?us-ascii?Q?glszbWb3Nhy7QnjZK37iPOzMaFCffx9f714HM8zYBH45QkPbZJXVmJh6MgOo?=
 =?us-ascii?Q?8rnScp6loX2bVuxe8H3WWYccp64Q20svXxZZ7QkCa3T8bydxM5fUhm7Qjp+R?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 475fb7e6-0abb-432d-6770-08dd7e1aa54a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 01:45:06.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAEmTvpW9DyqrCP266nOz9XpBnHMzM+yEhmLB2qG/XaaVxj0hZxgIgA/qgiQoSqJaB1DwiiUIjnjZTNPSo3eMT+Ap7+E2PJkz5CsmZ80B2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5318
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Testing revealed error message of for a CXL memdev that has Feature support:

s/revealed error message of for/revealed the following error message for/

> [   56.690430] cxl mem0: Resources present before probing
> 
> Attach the allocation of cxl_fwctl to the parent device of cxl_memdev.
> devm_add_* calls for cxl_memdev should not happen before the memdev
> probe function or outside the scope of the memdev driver.

Always nice to include a "how missed" explanation in addition to a how
found. Something like:

"cxl_test missed this bug because cxl_test always arranges for the
cxl_mem driver to be loaded before cxl_mock_mem runs. So the driver core
always finds the devres list idle in that case."

> Fixes: 858ce2f56b52 ("cxl: Add FWCTL support to CXL")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

With above, looks good:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

I tested this with the patch below that catches this bug and tries to
catch the issue generically across the kernel. However, it results in
too many false positives so I do not see an easy path to ship this
sanity checking upstream:

-- 8< --
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index d8a733ea5e1a..f96a5bd37452 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -231,6 +231,16 @@ void devres_free(void *res)
 }
 EXPORT_SYMBOL_GPL(devres_free);
 
+void devres_add_unlocked(struct device *dev, void *res)
+{
+	struct devres *dr = container_of(res, struct devres, data);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->devres_lock, flags);
+	add_dr(dev, &dr->node);
+	spin_unlock_irqrestore(&dev->devres_lock, flags);
+}
+
 /**
  * devres_add - Register device resource
  * @dev: Device to add resource to
@@ -242,12 +252,8 @@ EXPORT_SYMBOL_GPL(devres_free);
  */
 void devres_add(struct device *dev, void *res)
 {
-	struct devres *dr = container_of(res, struct devres, data);
-	unsigned long flags;
-
-	spin_lock_irqsave(&dev->devres_lock, flags);
-	add_dr(dev, &dr->node);
-	spin_unlock_irqrestore(&dev->devres_lock, flags);
+	lockdep_assert_held(&dev->mutex);
+	devres_add_unlocked(dev, res);
 }
 EXPORT_SYMBOL_GPL(devres_add);
 
diff --git a/include/linux/device/devres.h b/include/linux/device/devres.h
index 9b49f9915850..7ad9f7fea46c 100644
--- a/include/linux/device/devres.h
+++ b/include/linux/device/devres.h
@@ -30,6 +30,7 @@ void devres_for_each_res(struct device *dev, dr_release_t release,
 			 void *data);
 void devres_free(void *res);
 void devres_add(struct device *dev, void *res);
+void devres_add_unlocked(struct device *dev, void *res);
 void *devres_find(struct device *dev, dr_release_t release, dr_match_t match, void *match_data);
 void *devres_get(struct device *dev, void *new_res, dr_match_t match, void *match_data);
 void *devres_remove(struct device *dev, dr_release_t release, dr_match_t match, void *match_data);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 5c8d43cdb0a3..2bdf625916fe 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -338,7 +338,7 @@ int msi_setup_device_data(struct device *dev)
 
 	mutex_init(&md->mutex);
 	dev->msi.data = md;
-	devres_add(dev, md);
+	devres_add_unlocked(dev, md);
 	return 0;
 }
 
