Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5008F54774
	for <linux-cxl@vger.kernel.org>; Wed,  6 May 2026 05:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778043938; cv=fail; b=Oz6TClPmKUiNYtvQAlxz5BbCeDBMMWtv021P2FF8MWjcf6EaQah9FLWZBH7kAbEdF9MSB25YgPEUzBJGbh8GoEt64MOXq+jNgRIwMyi38aDRfB+5/ML90xldaCnifa9q7Ddve6ztja7YOjQbSBGKcRf6I5MgAvErw4jmU2j2Ot0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778043938; c=relaxed/simple;
	bh=iYExAs+xgV1TM26Hl5DTdpUoty3bl5VBJVrY2RVlBt4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YmTBt+3vxWarRCdHsKJRtdcradlxEVR0KkZz6uRirPtNcvFUjd9fWDb7xundmpnfYh8xdPHJpsm3cKRFU8tRRYkYBoaEXKib24/ZpGNwkCliEDlV61zl48+VkdTJoTRN8EKt+AW0tb1Ril66acD7NRVU3gF+KNHvtNFqQrv3zus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEXPJlax; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEXPJlax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778043938; x=1809579938;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iYExAs+xgV1TM26Hl5DTdpUoty3bl5VBJVrY2RVlBt4=;
  b=nEXPJlaxNHVmbc12P71hlHN0ZzLmkmA7x53ZLU2BwwK4WR+QiWDENHTn
   zpsILxzeqcG7sCVP662WItDHViPSg/Zs9AeaajvB9bFvmLkMDSKzNp6dw
   95c9hMKkmtj7BOmNJkOrlk7E6llT0dLuEkaVykqMFh35w48GFvRthfT2l
   GtbPTXKqYreUpqUziwd/meYno6a0vhdvYAS1R4dJrDFu5GsXdY4VuU/UE
   qLTSx2hB2uKSr1mW51Vg/9o2OXHHC8jVn4eyGMzUcehOKXfl5GRk6KgfD
   Sda+rrfRL6UkfDbGYW5cRxZBum7OCiO0llXg9twtU404aljWJ6vllnZr6
   g==;
X-CSE-ConnectionGUID: ky+MwDbUTfuNZ2dQy+bGUw==
X-CSE-MsgGUID: hXQxb4haTBm1Gzj8iRuIBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78953360"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="78953360"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 22:05:37 -0700
X-CSE-ConnectionGUID: otAe583CSHGAXWLWD85Ziw==
X-CSE-MsgGUID: zGhHYaVORLSmaOCzHBgGOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="236267015"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 22:05:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 22:05:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 22:05:36 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 22:05:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCcjcFT6BAM7WoHcXpDvJIQjJxiI6n9s5Z+8cqNtet2Ao5TZaABg1TQngO7FtyCCw3XBF529llrfedyt1nQdzYs0codwN1k6Zb7dJZxhfFiRCWXB++P5/8UPsWRpzqXZDFGfbKjcxhOt7Y89qEg9GozCyVEACEQsdqHjrkm7StL9cwhcQkVCp9HpY4ZZ9AUwgfnLktCAOrvE6d2ypHm4k9U6yc9Aw8Gc/aczYoSQrQyH7qtvMAyV/7Ohbd4aZ8JieOfpMXEy6ozfVUv29lTymXCsXE3rP7wT9ZmsBje16ajf0aQIuaIt1hbdO994ciHQusvHokTD4LlT+jSYTRjNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ey0s/x1xsKsAoMkYMPSbN1C/0BLSLY9FFUbBX2nQsZc=;
 b=W25T7Y7yIO7+K7qQxh6OEblex6Oo8CWwsRDxaPgBVsfhET0aRuMN2iF1xHw8rqmbu9n4tgFZCL5/25jgoiipTEppFthCKnZX54PrxdDIwauQKiDMAakkOAKTzeTrlADz0RwA+bGg850ReMP90tffNtu6BZmeKwU39KiD69wNHxU6e/q8KCm2x+JDgeMRppEV84cuoKhg6xH0ZSIlchtnK2cXBBPPf2ublQ0s8WmH88zN/IF0cqb4Bi6/cJRIZqlfWAvHRV5AK+Sf3rRccGW28uiEp5fBqJSuej+BDB3i8MHXyoY69I2TYD5fe5u/xSvZDif53x6AJnM+xbDfCLgE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 05:05:32 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 05:05:29 +0000
Date: Tue, 5 May 2026 22:05:21 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>
Subject: Re: [PATCH 4/7] cxl/test: Add hierarchy enumeration support for
 type2 device
Message-ID: <afrMEbtJf2m7ZFTF@aschofie-mobl2.lan>
References: <20260422230237.2599333-1-dave.jiang@intel.com>
 <20260422230237.2599333-5-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260422230237.2599333-5-dave.jiang@intel.com>
X-ClientProxiedBy: BYAPR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:a03:100::38) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW5PR11MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 930dbc1e-07e9-472f-31ba-08deab2d176e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 2Xt7BBythGlsLsSRe1jzE/8/ETu6z1TLICPrKFD5IH2iGMIe/Xs+bS17oPOiaSTuAmpn2iLG3P/Z91gZorsjo7XWM1UT5JQt/osKZjBxgpH/4zfy7VPszEe5etUlcAtVjAgJ6I+Mq8vLePWk0f5Y+2hUlMvTuGP/DyId96tYidClKYZX6W55gHezLEAj71Cs1cfSIPnyYDac0YWlS+fVnfyOUEnp2EFh9aTqwrHxqSnAbT6HOhFD/pIqKZHG7V0U9yAymqftQS/tNLSV+BAAY3S4Wbh+oE3/QXMWCphDFnwMeHeeuC2r0W4DyClpmucnUl0SK0mJTeS7Rufw/sQwfy/YxRp1hE1G0QlwT7/h2WDP5yzNIN8hOpenutW9IXRQZq6Hwzq0SDsM1ieoG7W8lg1lfN9DiQlYAmSdw+zJ8EUxBV58ILgMppdYwaKe/rJwbuM/6f+vlr3ZCCrMx6SVDAF6LZm7D9Ecknx2RZwl/thFnM0Pzhl04Q54CQQwbvSKqfr2l6dV6k6WbxFwaXt3K3b1rktDNbDUh9zGxz6Lu2wjulQXtK7c7FAKiRuAE3EPREZb3eWRXeZJOFPNueqqtoyFabtIiS3M539a0BelCBjoxzSV0Z0xz3JOfZuAPE2FpxDIeWZIcKlyJYFc0x2WaT1rYL1YX2DcCWjORcrhPkvOHRTC+TiPZrjVZLzZOjAS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6vissvTTrOkii23qOZ4RCc7T0EjNz6R6YqRQ3kU8wahhYFM1N1Lh8yfW0rRN?=
 =?us-ascii?Q?TPpYUNpyxcQngir8phW9CKXBP2uCYrmoKlahVfhEpX+FT8oL3jSPQq5h06vH?=
 =?us-ascii?Q?bv6Ie7S9iBvPQhGl0CrU6IkVZgzRqkoxeS/sj39i1Q1Sd9ieSzLIcQXNyJLj?=
 =?us-ascii?Q?wuFJAsMfoGNn54pbY572xGgPlMLR+ghfVo/krW+mNeZBKxn5+z9hFJiq1eYf?=
 =?us-ascii?Q?bHbS5ljIvzTL7EouZc6CghzSRXE0+IG1/snNaSUVfA0kRzESrDms91Z4rfLE?=
 =?us-ascii?Q?wJgNnOVSv2IBMHgp5ZGqbeUtFruq7ncjueoaMevvfOj4zo0H7r3tryDSykY6?=
 =?us-ascii?Q?4Cs6Jkzkjq4yZxMTtc/QA/8IfcamJxv8XFOH79POSKurhrjD6x3xzxX4rGkP?=
 =?us-ascii?Q?c0Z3qyahxSwmn5K9tWSgEhx/5jcWAt/5rYI+mSmDtkvqrB/rXdHnyfDc41ry?=
 =?us-ascii?Q?Yr9zvGJ731lKuY8BajVzbKEMk6jma6vUVFs6gNOt+l9+1JUnnoieRV/W3eVl?=
 =?us-ascii?Q?DL+/KsQCXxe1dLpkxks0qNx/KMTLEJfhx60hHS9u5ke4qjIBkZxkli49tN6t?=
 =?us-ascii?Q?ZmZxmOExFQIKZyLeG78qgyK1+ZBtlJ7NdSy3iKU03ACXDWbJvbzrXyfq46mE?=
 =?us-ascii?Q?JpWMlOexxiYcW2zlL3uwCS9urUKg3O6QmlRQu/2Y1ckuxwMaunwVGHMnklGD?=
 =?us-ascii?Q?L7YVdsn+syxthpDYLYeoCb25iZa8gxLdgGSdeerQQdjWsiXabCU2yf7zo4+h?=
 =?us-ascii?Q?SmXn+XcVTW7j5hPULAZ2HZIL8YqhhTk8umuKIKzKiO9hADMbU5Y59wpK8m8Q?=
 =?us-ascii?Q?MR/Ewuhx8RSh/cR3uPrnYIU+BIfIuMuI819G/HchQWX/QadG1MFKIKXmr0n1?=
 =?us-ascii?Q?K+LTZwvyGfwofaDn17jSBNqhD9XAJaCTX9XWH6mFGAD6TwA8KOw8o1yVoiVJ?=
 =?us-ascii?Q?0VUVcG4RLiQDnJX+ySEXzwdoHNwnhZmjnpmlObjpXMt8/3p1YInxhr5CchRc?=
 =?us-ascii?Q?MUp389/zMC9mZOr7bB6Uyuvv4c30BulX8UaWy0/l34A31frEoRYs6BpTF2El?=
 =?us-ascii?Q?AkFVdkIjt//p3NQB5oyQoJ9BSUjLiyw81SJpRPYVngRL5+wbwjCTLpN6ZhOw?=
 =?us-ascii?Q?JC2p1YbG8Rdr3vNe4GFqQdG/gfh3r4AFfWCrXMLyBpYuCLZSSnhdUER/w760?=
 =?us-ascii?Q?78cpFjidW7rCOjWiNqcfQtVTcJ74TU1NMn7Kl8KW8VjiG1jsl8jpIIK0Vd8O?=
 =?us-ascii?Q?8m1HHLfpur70VE8KcJyoJA0F/dhmbsq4/P4zVI1D/4CYlfcal9qpup7LmfRP?=
 =?us-ascii?Q?NUbd2l3XUH8i4/F8zQPxYxWXJB8Zw+hVLBVi8HXZJ7TLygtBWHR+Iu+Ex5D9?=
 =?us-ascii?Q?+9srus1gptQ99UZkEwEdOfRdrz7XYrT/vZqdHV4rVbPkCRqTv9idEaEWbCsd?=
 =?us-ascii?Q?S3bmE8gB/VU2tC9mxzePpTf81fhYbfv/0Ol7g6an79EdKKTb5Pr8cX3pMpej?=
 =?us-ascii?Q?YTjDPfoipBoGE5j343XDucyzR8ts46XWPPVgJeTcdqq6amamEFsHuqJI+Lwe?=
 =?us-ascii?Q?LVdN/cky9mzza45rBTBVTR31pC4esyLhfeiQSqGb6fZJ85I735YsrTiWTrhe?=
 =?us-ascii?Q?b/UTHHg+qjpnLiQ4zTVTfYHdgy1BDXSewzTS4HN+rcleOWOL8ePr4k9Nrt48?=
 =?us-ascii?Q?kiRWiaPCvUUQzCkQBgGX37T7Zmf/F9EOiYa7jheDrM81qdichon+SHaMbn3j?=
 =?us-ascii?Q?YQNZy2NYya0kGCo65of25qvQb5695V0=3D?=
X-Exchange-RoutingPolicyChecked: AIht85PdobD1EOtXpTBFURh5PfokHAt74STp3A7zsBRyCVd3VhCab1ktejRANa7oxCuwoeRRnrbjW/IVSL5qZRNN3qoLtJl8MwbvadJIcemg1InKYUdYMd88M8ogCDzvc5LPzUwqxpIdsKd+Qx5IKHnteACVCwchxk6D0FUWEvLd71vM/Ti3t2qmC97v40fbc3GfXLKUK77ZH1mAuKN39a9xdMyKrKHwGPnbJEla4YjCB6HMcUAq9bdi4TMzZ7thraaA/MVdwwHmZqehX2ghmBl59oIx6+k3RvVutn9VgO19HYW241+ZJ4CHEnVWaCoB/Nyg72/gkcDYYXxN0zR0lA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 930dbc1e-07e9-472f-31ba-08deab2d176e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 05:05:28.9550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J18pijl3oCYu7VJaXgoelCjhFrv9lIhV00eUbg0sr1QcKcD6i0wW6lCFkwWw+46QUzKDiul7uwc43yZhZf41n+KfQifdZnq5aiMslZ02Q7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5787
X-OriginatorOrg: intel.com

On Wed, Apr 22, 2026 at 04:02:34PM -0700, Dave Jiang wrote:
> Add enumeration of type2 device hierarchy in cxl-test. The type2 device
> is setup to be directly attached to a root port instead of rp -> switch
> -> device that type3 hierarchy is setup..
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c | 110 ++++++++++++++++++++++++++++++++---
>  1 file changed, 103 insertions(+), 7 deletions(-)
> 

skip


> +static int cxl_type2_mem_init(void)
> +{
> +	int i, rc;
> +
> +	for (i = 0; i < NR_CXL_ROOT_PORTS; i++) {

I'd like to drop the artifact we carry here after copying type3 setup.
Type 2 doesn't use the second pdev. I think we can make the one accel
one region constraint explicit.

How about:

	#define NR_CXL_TYPE2_ACCEL 1  /* One Type2 dev, One Region */

and then in cxl_type2_mem_init():

replace this:
	for (i = 0; i < NR_CXL_ROOT_PORTS; i++) {
with this:
	for (i = 0; i < NR_CXL_TYPE2_ACCEL; i++) {



> +		struct platform_device *dport = cxl_root_port[i];
> +		struct platform_device *pdev;
> +
> +		pdev = platform_device_alloc("cxl_type2_accel", i);
> +		if (!pdev)
> +			goto err_mem;
> +		pdev->dev.parent = &dport->dev;
> +		set_dev_node(&pdev->dev, i % 2);
> +
> +		rc = platform_device_add(pdev);
> +		if (rc) {
> +			platform_device_put(pdev);
> +			goto err_mem;
> +		}
> +		cxl_mem[i] = pdev;
> +	}
> +
> +	return 0;
> +
> +err_mem:
> +	for (i = NR_CXL_ROOT_PORTS - 1; i >= 0; i--) {
> +		struct platform_device *pdev = cxl_mem[i];
> +
> +		if (!pdev)
> +			break;
>  		platform_device_unregister(cxl_mem[i]);
> +	}
> +	return rc;
>  }

snip

>  
> +static int cxl_mem_init(void)
> +{
> +	if (type2_test)
> +		return cxl_type2_mem_init();
> +	return cxl_type3_mem_init();
> +}

The precedent above would be good to follow for the topology helpers.
Now we have scattered 'if (type2_test) return 0;' at 7 sites that need
to know which topology this is. How about:

static int cxl_type3_topo_init(void)
{
	/* inits all the things */
}

static int cxl_type2_topo_init(void)
{
	return cxl_rootports_populate();
}

static int cxl_topo_init(void)
{
	if (type2_test)
		return cxl_type2_topo_init();
	return cxl_type3_topo_init();
}

static void cxl_topo_exit(void)
{
	if (type2_test) {
		cxl_rootports_remove();
	return;
	}

	cxl_rch_topo_exit();
	cxl_single_topo_exit();
	cxl_switches_remove();
	cxl_rootports_remove();
}

> +
>  static ssize_t
>  decoder_reset_preserve_registry_show(struct device *dev,
>  				     struct device_attribute *attr, char *buf)
> @@ -2008,6 +2098,9 @@ static int cxl_dsps_populate(void)
>  
>  static void cxl_switches_remove(void)
>  {
> +	if (type2_test)
> +		return;
> +
>  	cxl_usps_remove();
>  	cxl_dsps_remove();
>  }
> @@ -2016,6 +2109,9 @@ static int cxl_switches_populate(void)
>  {
>  	int rc;
>  
> +	if (type2_test)
> +		return 0;
> +
>  	BUILD_BUG_ON(ARRAY_SIZE(cxl_switch_uport) != ARRAY_SIZE(cxl_root_port));
>  	rc = cxl_usps_populate();
>  	if (rc)
> -- 
> 2.53.0
> 
