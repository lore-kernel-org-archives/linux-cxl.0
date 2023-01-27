Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D2AC38142
	for <linux-cxl@archiver.kernel.org>; Fri, 27 Jan 2023 23:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjA0XG0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 18:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjA0XGZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 18:06:25 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F847D6DB
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 15:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674860782; x=1706396782;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2SxopTlNHCaHDybrdkg7e40o1l/9aoAAV92SpnA1Mtw=;
  b=EjqPL0vMxdDdNV5ndS3g3la9vXRJilMlj6+JNXU44uk7liOK+UFydinW
   K9hWIv2DvbkTx4yTK1MeQFe6e0vO3vEsp6AXJh/HHr+JmltwTfBb74DJU
   B6kYzVQ65fRNdsPeHEYd0j3XML4cGjP924kzWub5ywY1+qjVt69OFRDUO
   umHjhwVMklPwfKFt2HSSXLeXmMe4iAgED49wzV3fZxBca5ilaE4l1VzJk
   6mUO1syqN3D6mEcqrgRdfFaYbK8l0KzH+yvFU8M16SsH5Rfru9sDhsRv8
   jo7rd7euzp4H+eN6LyNcjI5pHx7NQuB+0n7e2dPXpW8rKlu/ZxMO0pYi4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="391768390"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="391768390"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 15:06:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="663437229"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="663437229"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2023 15:06:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 15:06:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 15:06:21 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 15:06:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj7YGXV5IreCgeWtRgp4L+rl04CaSBMq8nN41hfONkqhIdOWsISL1VqlZfJbLcx3M233+Cnvx8le3Lp25EzGqrtCSctM/Ndjp2RrT4uNKy7wOUkGMu/aEntdc6gRgOOGNtC3jmeYAwN8mTUK5IETwgRdOIaN0pAWmINbBTGRb1IjeFbmNIr29RHSRJi7p/AV1w04Z6KTtuj5FNBMuPQ94mYTj3Qd2c+I17BqeGFFcvcl2BoTWTlIy2+diBGYSnWBpAvH58NAK+alVRTZUMZyLY8UBzbguVpBNs/1JvHkflT1O1U3WeGHXC+k1lXz/vs4BWYLfWDrnlrR8n+FMcys3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8y/lX0y/M7+TKg+SiC/pzUFusuFbrM7OEIWnma9zoM=;
 b=WGHFEr1TO0TP3xkksX2UzNj3HF+qpRATmeM0ldPGEfHtVzpBgt5Go8iy7t2eJYc+lFSu541il2dtYX//Pnwd9B3eGj4I/PTzjtfIL4Mb0Un4k116BH/xY3d2/ssulPkKSyPKUzslGWVe/htIeKarAFyU0+MEj4goFOov2nQJ6D45I00Q3dJTYMcueaegz1SEU9RIeSG0Vh4h7SqKNMGLvc72P5Zi5s30dUeWRjwCyisgqGROl5NmWH6gmLpVaCPbAcqR7GkHM1sMbEgcOsbzR0HwvF29QYHU+v1J4KrHGrIvPmXOIAIfhPNcQjjM5Lyh372pXniZGaZDyvhQv88Sqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6294.namprd11.prod.outlook.com (2603:10b6:8:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Fri, 27 Jan
 2023 23:06:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 23:06:18 +0000
Date:   Fri, 27 Jan 2023 15:06:16 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v2 1/6] cxl/memdev: Add support for the Inject Poison
 mailbox command
Message-ID: <63d458e7eed85_ea222294af@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1674101475.git.alison.schofield@intel.com>
 <97a0b128d0d0df56cea1a1a4ead65a40b9cf008e.1674101475.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <97a0b128d0d0df56cea1a1a4ead65a40b9cf008e.1674101475.git.alison.schofield@intel.com>
X-ClientProxiedBy: BY5PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 0019fa04-db5a-44be-4180-08db00bb1902
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gbof2z3vLEvrKpYyn3sowuCFF9v3H7PloNBdgHy7f5f/4cAgg4xkYiPdwzrs4AwmO05JWyC9G75cXvIddWUaGLkZLi0Wg48KRj+hL/NrPSZHM8Yic/bi0H8OE3Bn5RC6uxK9bJaGEb5CmsBbtz180ynAukpTyLCELh7yGfKEoDWtB9yBGYWudZLlFdiQSuEMClSI+fY3OtFM00iitE1rJqgY9rF3rWASCp7eR4IwBrQvE+cDcZ29iCoVwtTeGF+ePoxqxhdZxgMwogg4JC/w5RDdGLyNwPFuJv8YBrX7mr1cDoe3+KGXNGhXdbni/ONYClwZe9mQoh8XTsRTg20mWOmeFlx8hAEF9l84BfpDCBp1LEyQYEFkTrPqVBWoeC20ZOmbWUq8v/XbfQKXDhx8KYwwOfirNgPXMInMdwUh3FT6a/289aHnDFiLz8ZgPrst37FPp6VnBLiRpyiVfs+0avjts2vQXYoz0vt4aqPOo9Natl3OWBFEsekVVBVsQXwwGXLUUTIm4hEmkRUrb7BvES2uU87eROPriC0qA+5YtIEqRgvyfo6RwpJZF+SvNrEtkqcadN+hXIq/qiGzIs2RJRc3SF3tb4HBBWBVI+fSJG1FOMW+ffkqRli2Q+cMMsuSeQO0VWOnpDBT+EH/eh6q+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199018)(478600001)(6486002)(2906002)(15650500001)(86362001)(5660300002)(38100700002)(110136005)(4326008)(8936002)(41300700001)(66946007)(66556008)(66476007)(8676002)(82960400001)(9686003)(6512007)(26005)(186003)(6636002)(6506007)(54906003)(83380400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FzC5Sgf2wc87kGmS25oDH/1l85D+vuJiNSpJrRtciCcAMGOYrI0VEkuDOuj7?=
 =?us-ascii?Q?Y2yVIGLFUEA6fzgAS2rCIcy3Me0JYoLkFK92zs30H6sgsk+Syo+WUButaX1Y?=
 =?us-ascii?Q?YLPHYINvK8CXMVECBOr6sCzCV55t/RMP7h1zdaKtMRzWdhJ/P6PCZowQdLla?=
 =?us-ascii?Q?1BFVflHAeOwsUm+VDoffzUqJz7ZhZ1ZOEEPUl/XBC/6Zsc2EpnzIexM0XeCO?=
 =?us-ascii?Q?1pcfZMl7d7dLWJ5WdV786Ky46+LOyPa2NoN1SXpGxH0t9Ug8PjERGslEBhmw?=
 =?us-ascii?Q?FB6NRDjRHMRqB8KWKo+j0tqB8UfZ9rfJF3W8uf21E9FGRl96Wlm3jzZZJorO?=
 =?us-ascii?Q?ipXB1asJRbk89t2YEN27dbjdu5fOMz6TYi3aqycXmkH+Hbl4RgLhQqabx/Jt?=
 =?us-ascii?Q?Dq0FiraidjpOUsPCt8QNCj7xmAzn2LQV+Dj2Ak6HaCzVZXn70Jegkz3TgZc+?=
 =?us-ascii?Q?7SF6DsRSxOQPZnabtdj+wGm/kvTjOeXGGOkT1Xrrb6Nd4ToJpaR+Bx/K2hdl?=
 =?us-ascii?Q?n/Rd0Vo4h9L/KZ8xtoxgm4la7qRtpf362EOcCSUmLyLweVp3meXOpVXg0Yj7?=
 =?us-ascii?Q?8hwOM5b+ODsu44G+Pums+qmbSUu451kwClCvd3maWx7A3ADl9uMPE9ob60SY?=
 =?us-ascii?Q?vdwXuXIGZJJo3TBiiodBDV10n5tkKCRItelTXv14B5xdjdtg0QyVvVumdLg0?=
 =?us-ascii?Q?6m+JP0pHzm10Mvri8QJIOBEvLVjAJCzbd9bAhcjxFPFwMkw6QyZ/CoZTo0Ow?=
 =?us-ascii?Q?EMRlru8zmNbY8nbQ4o2NTEbjJNgeyrc0xWncvL2Q+6abRnrKNbJNnaNj7NKE?=
 =?us-ascii?Q?fE1iz58KkGsFWC02J4+Rzs4Ls58HMBB/18y/8tB96YVUrdES7OSbuaq/Waf8?=
 =?us-ascii?Q?E3//1jfnQRQFrA3416vkWDa0OrmfP/dUYaY9QbLSVLzTKAY/1VJD7QAZ3okH?=
 =?us-ascii?Q?ZpkSr+0oojf2vDWE959qu2/FGC1loCaNB0cAxmHgnbhRrnA9lmMVS/PQe9Xa?=
 =?us-ascii?Q?93cDvNpwX5muy54HP8thTafiIAI7bUZkmOmpgnEowRkPbrltUa/ZjCjCHtGH?=
 =?us-ascii?Q?cnTiVLM4CDLumZIBkCTFMxWUVq4Nqnmo1wD1lBl+g7DzCoermfMlR9G2Tm1P?=
 =?us-ascii?Q?z0rAqvXqnRabB1a8zQPxcxu9YeZEt7lu/+WNS3NfqBAdpif/NJ9KURsORkHt?=
 =?us-ascii?Q?a/SLPb5gqZRvAtIDIr1SrWoluNlUmXFAWw7kYTrkDuz/wQvOMXozmQr2mLak?=
 =?us-ascii?Q?Ka6qdpCaQ9YU+vA9pETDLXP0FuxPjrVvsFlmLN50VSmR4bGXKqInUWx/IKLm?=
 =?us-ascii?Q?Ii4pi7cgMZQ0FPsOdZ6jSoZdsBFqvRGVaYMt9YSsXi0zgoO/TNTiK+ZSCPiG?=
 =?us-ascii?Q?1jZABzfbRxeXxSfXX5UckSpnI99N05RTbgYgNKpP1fINXefGCApMSotZ8kMX?=
 =?us-ascii?Q?HHV3BK+visue0RYpZaDRgFVf/ChiY3pv0BZMTnXImtTf1kH+XIT2ZteomdXZ?=
 =?us-ascii?Q?my3ZSVK88kLzAyLIqNz5/Sj6Fw5W7Q43s/ugXldI32iAL41Op4sDuO8A49kE?=
 =?us-ascii?Q?csheBnGfFHq2BERvDb/CupHy5pHPpoYvHjSoKW0OAjY3APQl0k4ZRYDGjuUq?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0019fa04-db5a-44be-4180-08db00bb1902
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 23:06:18.4645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/Qo3t6lndHy0ndoJNZ+B6L7jl1wC6Q1Tmk7tDvmtl7vU6GIwxGmaJT1f3658IOH2B9COW4nUC01ueIcrfsv48rq3UZNKh0Prc+Jfq8AeTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6294
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices optionally support the INJECT POISON mailbox command. Add
> a sysfs attribute and memdev driver support for injecting poison.
> 
> When a Device Physical Address (DPA) is written to the inject_poison
> sysfs attribute, send an inject poison command to the device for the
> specified address.
> 
> Per the CXL Specification (3.0 8.2.9.8.4.2), after receiving a valid
> inject poison request, the device will return poison when the address
> is accessed through the CXL.mem bus. Injecting poison adds the address
> to the device's Poison List and the error source is set to Injected.
> In addition, the device adds a poison creation event to its internal
> Informational Event log, updates the Event Status register, and if
> configured, interrupts the host.
> 
> Also, per the CXL Specification, it is not an error to inject poison
> into an address that already has poison present and no error is
> returned from the device.
> 
> The inject_poison attribute is only visible for devices supporting
> the capability when the kernel is built with CONFIG_CXL_POISON_INJECT.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 22 ++++++++
>  drivers/cxl/Kconfig                     | 10 ++++
>  drivers/cxl/core/memdev.c               | 67 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  5 ++
>  4 files changed, 104 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index b715a4609718..e9c6dd02bd09 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -416,3 +416,25 @@ Description:
>  		if accessed, and the source of the poison. The retrieved
>  		errors are logged as kernel trace events with the label
>  		'cxl_poison'.
> +
> +
> +What:		/sys/bus/cxl/devices/memX/inject_poison
> +Date:		January, 2023
> +KernelVersion:	v6.3
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a Device Physical Address (DPA) is written to this
> +		attribute, the memdev driver sends an inject poison command to
> +		the device for the specified address. The DPA must be 64-byte
> +		aligned and the length of the injected poison is 64-bytes. If
> +		successful, the device returns poison when the address is
> +		accessed through the CXL.mem bus. Injecting poison adds the
> +		address to the device's Poison List and the error source is set
> +		to Injected. In addition, the device adds a poison creation
> +		event to its internal Informational Event log, updates the
> +		Event Status register, and if configured, interrupts the host.
> +		It is not an error to inject poison into an address that
> +		already has poison present and no error is returned. The
> +		inject_poison attribute is only visible for devices supporting
> +		the capability. Kconfig option CXL_POISON_INJECT must be on
> +		to enable this option. The default is off.
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 0ac53c422c31..6541f54725cd 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -129,4 +129,14 @@ config CXL_REGION_INVALIDATION_TEST
>  	  If unsure, or if this kernel is meant for production environments,
>  	  say N.
>  
> +config CXL_POISON_INJECT
> +	bool "CXL: Support CXL Memory Device Poison Inject"
> +	depends on CXL_MEM
> +	help
> +	  Selecting this option creates the sysfs attributes inject_poison
> +	  and clear_poison for CXL memory devices supporting the capability.
> +	  See Documentation/ABI/testing/sysfs-bus-cxl.

Could maybe clarify that this is meant for hardware debug scenarios so
that is the reason it is disabled by default.

> +
> +	  If unsure, say N.
> +
>  endif
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index e0af7e9c9989..226662cf3331 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -142,6 +142,61 @@ static ssize_t trigger_poison_list_store(struct device *dev,
>  }
>  static DEVICE_ATTR_WO(trigger_poison_list);
>  
> +static int cxl_validate_poison_dpa(struct cxl_dev_state *cxlds, u64 dpa)
> +{
> +	if (!resource_size(&cxlds->dpa_res)) {
> +		dev_dbg(cxlds->dev, "device has no dpa resource\n");
> +		return -EINVAL;
> +	}
> +	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end) {
> +		dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
> +			dpa, &cxlds->dpa_res);
> +		return -EINVAL;
> +	}
> +	if (!IS_ALIGNED(dpa, 64)) {
> +		dev_dbg(cxlds->dev, "dpa:0x%llx is not 64-byte aligned\n",
> +			dpa);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t inject_poison_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mbox_inject_poison inject;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	u64 dpa;
> +	int rc;
> +
> +	rc = kstrtou64(buf, 0, &dpa);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_validate_poison_dpa(cxlds, dpa);
> +	if (rc)
> +		return rc;
> +
> +	inject = (struct cxl_mbox_inject_poison) {
> +		.address = cpu_to_le64(dpa)
> +	};
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_INJECT_POISON,
> +		.size_in = sizeof(inject),
> +		.payload_in = &inject,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	if (rc)
> +		return rc;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(inject_poison);
> +
>  static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_serial.attr,
>  	&dev_attr_firmware_version.attr,
> @@ -149,6 +204,7 @@ static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_label_storage_size.attr,
>  	&dev_attr_numa_node.attr,
>  	&dev_attr_trigger_poison_list.attr,
> +	&dev_attr_inject_poison.attr,
>  	NULL,
>  };
>  
> @@ -168,6 +224,10 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
>  		return 0;
>  
> +	if (!IS_ENABLED(CONFIG_CXL_POISON_INJECT) &&
> +	    a == &dev_attr_inject_poison.attr)
> +		return 0;
> +
>  	if (a == &dev_attr_trigger_poison_list.attr) {
>  		struct device *dev = kobj_to_dev(kobj);
>  
> @@ -175,6 +235,13 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
>  			return 0;
>  	}
> +	if (a == &dev_attr_inject_poison.attr) {
> +		struct device *dev = kobj_to_dev(kobj);

I'd move the IS_ENABLED(CONFIG_CXL_POISON_INJECT) inside here so just
one spot in this function handles the poison attribute.

> +
> +		if (!test_bit(CXL_MEM_COMMAND_ID_INJECT_POISON,
> +			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> +			return 0;

Ugh, this is a problem. So "inject poison" never should have been
enabled for the ioctl path way back in:

87815ee9d006 cxl/pci: Add media provisioning required commands

All the nice sysfs interface and compile option to turn it off in this
patch is moot since userspace can just send the ioctl if the sysfs
attribute is missing.

On the one hand this is already shipping ABI, but given cxl-cli has not
been enabled it chances are high that it can be deleted without anyone
caring (i.e. breaking deployed configurations). That would need to be a
lead in patch. As for how to detect that the inject poison opcode is
supported, that needs something like a custom "cxlds->has_poison_inject"
flag into cxl_walk_cel(). I.e.  cxlds->enabled_cmds is only about the
enabled ioctl wrapper commands for CXL opcodes not the availability of
opcodes for cxl_internal_send_cmd().


> +	}
>  	return a->mode;
>  }
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 28ba0cd8f2d3..862ca4f4cc06 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -436,6 +436,11 @@ struct cxl_mbox_poison_payload_out {
>  #define CXL_POISON_SOURCE_INJECTED	3
>  #define CXL_POISON_SOURCE_VENDOR	7
>  
> +/* Inject & Clear Poison  CXL 3.0 Spec 8.2.9.8.4.2/3 */
> +struct cxl_mbox_inject_poison {
> +	__le64 address;
> +};
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
> -- 
> 2.37.3
> 


