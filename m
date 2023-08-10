Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B6DC001E0
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Aug 2023 19:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjHJTXi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Aug 2023 15:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbjHJTXh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Aug 2023 15:23:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BA08E
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 12:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691695417; x=1723231417;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pRKk/jFJrV9dsGOKn58dN8n3nzZWQB3I4RrLVbqK608=;
  b=D4H02PBBKwOb+fqAQtUM5+i92+A0sTNnciTGRsQcz1PUiy2LAXBytzAy
   /+nHK2cuT1VuU+s1cOqqStRHKgiw1Q4xzBs5gzvZx5yaA9kJue9rVZ0sb
   W1+tm8feq9Rywjs9ECECayb+/zbArg6XfnLy3lyL/ejcEHf5wE7Bue1cR
   6+srKZ5Vwxj8480YYrvr4TIxdsYELOQsnhjBhFb51MPPyIRsGvp6s59/Y
   7fsOPrXlLSe1QKp5pPpnPDgPaYD5DZV3QADlaSxl4fkwamPXELYLugEho
   Hp1jJVZqTFe9qdajH5dHUn5hAhpwLKvOPGwiJ/vOQoJNPckXu4VvXXttX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="371506776"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="371506776"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 12:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="856017418"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="856017418"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 10 Aug 2023 12:23:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 12:23:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 12:23:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 12:23:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 12:23:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqB6XCY4yvDvJrY2HC0eKHotZVM/5W1500R/jt18jc58ocMb4D/wCmwYcwfRcwOoKWUlHzvIc+eLEnqlNpLFchR3Rd3FpRfPDzS2NwqAqbbTfCnia+ROrXzhNTxPbCLlNY+5oakH3mtFP+J9XSb6y0utfYvoBesosm+Y/3FmNKF0RyTa0QobmSsPjEGKR/hDh2C83geudoQ0962jlFhCZ9k6J1evFtF9fu7CqMLEA42CT8tn1ybod9brGkPDE4GomrFJrBAg4S3QsGhcrPc6hTkXtzMDKt5SoB1KiTcsVk3NZEXA91KSdjWAr1t+tZ4IuTPyHtdxtTpfz4BlJzO3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xa3cKJPSkIJ1PJlz1vbsHsyKkhxfTqecFqpUKb9gleo=;
 b=BPmw9tT/IN3BWhciFX5ztMcOxgYP/pAKeVhHt9CKeju9qRvru0j39nxq61rqnx91NH3TkSwNp9/5ZVc+3HO7aTLfpPEl3CxESO80GarOyDyLAXgqKCfsmgWo5vPw+lT9EFoFD5SQh2/CjPx1l/OmiYVMeZ+OKuV97DTn8nMHo7B3hdZ5Ej4BRQIVXEY1KD1yNapVZusRjzKlnjJONJ00ba2E2IwmAMpfzbpDYwu3kRzDJ/IrVSmbkSBjMnofERtn0FRsHsYrZHYOP7yuM9Q6wvRRDwOMj0qOTE7wTK9ej5N1bXKt/DFPZX3x4wbZsNoqgRBg7zDulAWx7gAn3cPKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB8206.namprd11.prod.outlook.com (2603:10b6:8:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 19:23:28 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 19:23:27 +0000
Date:   Thu, 10 Aug 2023 12:23:23 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
        <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/memdev: Decouple security init from
 devm_cxl_add_memdev()
Message-ID: <64d5392b3364_1aed4629443@iweiny-mobl.notmuch>
References: <20230809163733.32008-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809163733.32008-1-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac02fec-0b1d-4198-3891-08db99d7459c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6cONbXWkaYSoaTlBlkmIjjmz+kmNi/wBF4bEfT2YUJ85Urgq9WRkYJm63UjmIVKtsTkQM0SB1OVRXNYVAlo6by67Fp8Zy3rycWmiQ67/fH5sD22f60YF12gZEQKa67+7qDj4ysfRthBfIMKoOGvEuh5cy0RXbMh0NDYieugszqHoqDndAIlOccQwjuAdi2fvQnglBXjUzJVLa+Y7DNfIVvgOnHf4aXMQN+EzpjLu24yIEBUAGy4XwgLVMTaWLNdIvM99Y/lood1620fP89CvowzkXHgJhrxunMXArywKX/H4fobSyMz2kjJVJ1IkI5EE0//MlargIZRAGFtzXzu/qfI4isszZEE3iWOGN1TsaeBWHCFK1sXHUW5pWQnuXQ+iF/kd5aEQjyMdV3TpXjJaGMzXI2LjUIIp43nuub5yWy1PKE/R0G/UQx5gpRUWk62fz+jwOES/HW3WcwBQ/a6KcaQ25Det3NvV4fnu8iTIcvhanPq8YPF2l7N29LVIpxifL6AVBx7Qc0o3YYP4xpq6DZydwoQ4LQAGMOpHA7k20g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(346002)(396003)(136003)(186006)(1800799006)(451199021)(6512007)(9686003)(6666004)(966005)(4326008)(6636002)(66946007)(66556008)(66476007)(316002)(478600001)(6486002)(5660300002)(8936002)(8676002)(26005)(6506007)(41300700001)(86362001)(82960400001)(44832011)(38100700002)(15650500001)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?64YRtht0MEzEP9yN2dv+eF0OHRfEInrNRFDjDLBxLAvhx/dZniRHks8rHkGc?=
 =?us-ascii?Q?+FhCAB0dk47Gnzn6F4UH6CdxtV48Dazh5T8bg6L+avkcvpow+lEyiLOtut/j?=
 =?us-ascii?Q?mLPTsWec0TSgilVucBDk+VSocrWMGPl61FBIRd3dPwpTNtaiKM8LyBpeaMOi?=
 =?us-ascii?Q?+YZUrBw8gKS5rR+prpnZG3QKxlH5alkQKVfgKsPZEckEdOJccPUsSQ2c7gBz?=
 =?us-ascii?Q?6cf0vBdldRGvw2WO6ENcsrqDwAI6KwgJoFwW/6zbgjzQNHmSNkEGOplpy46v?=
 =?us-ascii?Q?6m0NInBBVtrUk/ku7ap7xiqtSrnM9STw4lHkcaThroFwgcFQehL73wKGw51d?=
 =?us-ascii?Q?GmoMcMkfvH6UDB8oSPvZsSSaYujZMo7hcx8gvHPF4LkP369J0Acsj5RdbS/X?=
 =?us-ascii?Q?2qvuVvXxea/L1IGkI3DIIJjI2w4DlxWaaeCRARYesj3errRWPQzNwwU+3Nx5?=
 =?us-ascii?Q?ukgBqSG6i8v6mxV5FWGO3KVVl/JvApiGX36MBfvA6I6B839jy4N518H1T43L?=
 =?us-ascii?Q?WCQE1u42wZuG9CJ4L942Yy0M1YNLB8Sw2rlPOHt4qP/HV+Cg9TjhlC/wO5A4?=
 =?us-ascii?Q?jod85IwLy+gmCVattVG7WpUSv81xANGiPBsrFCVg07XYZLOZ/5+IuPEqh5a+?=
 =?us-ascii?Q?R8VhP2dkcO1y0cPHX3CkC5U1RgTJhcxC/ZT18ETT8ex2wqDh6F20kzzRfDzq?=
 =?us-ascii?Q?bq6dzSW4kKZaHuRQNhymJBWkxtMb+nJpgyIn/ZAKEfKEQTAp5bumkueGbeih?=
 =?us-ascii?Q?83SGqA/DJhCN7a7UZTtOPAo0yPgfK/qTy4uBZaCwi1uwbr9nO28QyrnDHZjP?=
 =?us-ascii?Q?Ahbvlkb9rEjpX7zo8Uc1eWOZMswOv9ifo13+1L2cEgYbwANeQNTOjQD/M8D7?=
 =?us-ascii?Q?nxaa6oKyy5LsvoneQsSb6m4mdm/3sWZbaPwAKQCPhya7u0MF43wdYV+1fTd0?=
 =?us-ascii?Q?dY/GmAlrEVUBTUeZQKquCXwXMRPy/m0W8caweBgSXoXpsJurYv6ZoTk3pEAJ?=
 =?us-ascii?Q?7mj8H7E0HwC0n9ivP6wuHt5IpQ4r1RXdbGvMsOPCaUujAcQ88tD7FAsAt5ZU?=
 =?us-ascii?Q?+La+k8xHz11TzBSZTMtF2zwANo9b3iLklB6kgbEpBARJ61OG+f6VK34TFErN?=
 =?us-ascii?Q?izGLuVSGX8qFml450giSA8wzimCKgeavey/7PJ5XDWpdyKuQt7GlGlFK24lU?=
 =?us-ascii?Q?uKdswv7vD+2vaF+eiYxEmWCfswxVLq/ED4yn3aFewjXu2i8wgtlQ8OWb93PS?=
 =?us-ascii?Q?9NDp+y2Y/dvt8emy9JRjMV6aevMJ2BOqgfpw7mcV7ZRyNUSjB7ACmRDJ+fRr?=
 =?us-ascii?Q?dzAsC0rhEuvV8bo02oLl5hetqFFQvArgi9qeq3q4HmHDZjfnDtNgFmxFVln+?=
 =?us-ascii?Q?HdtV0mR2watoUdIwzXyUlZdLT6ZRIH6hjy2KcbLkQo96Z++pgsxQfWTbfdFE?=
 =?us-ascii?Q?hMiXZcn7tW9+XPLajfXZi0BpokQyrloRSwEw3MZnibe4BYPciHGkQriWjEsC?=
 =?us-ascii?Q?jx3iJaq9JKKr8Yhr8oxP9f/v/uVis7kNDyxDiLxTSGBcj2RW51EmKzaGEukq?=
 =?us-ascii?Q?Cb1eb++qS3y6BcSCKc3j2frtxRRfQDBUoGnZMQ7U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac02fec-0b1d-4198-3891-08db99d7459c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 19:23:26.9786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XifDuxHDYFvab3w1taoVgfyYX+xnqQxy2JW8z0KW/k7fLQqqRGyJvy0svjc+kX+mND4mMVyWvPIZjlpIJ1awA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8206
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> A crash was reported during type2 device entablement[0] which called
> devm_cxl_add_memdev() without an mds, causing the security state
> init steps to be bogus.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000278
>   [...]
>   RIP: 0010:devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
>   [...]
>   Call Trace:
>    <TASK>
>    ? __die+0x1f/0x70
>    ? page_fault_oops+0x149/0x420
>    ? fixup_exception+0x22/0x310
>    ? kernelmode_fixup_or_oops+0x84/0x110
>    ? exc_page_fault+0x6d/0x150
>    ? asm_exc_page_fault+0x22/0x30
>    ? devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
>    cxl_mock_mem_probe+0x632/0x870 [cxl_mock_mem]
>    platform_probe+0x40/0x90
>    really_probe+0x19e/0x3e0
>    ? __pfx___driver_attach+0x10/0x10
>    __driver_probe_device+0x78/0x160
>    driver_probe_device+0x1f/0x90
>    __driver_attach+0xce/0x1c0
>    bus_for_each_dev+0x63/0xa0
>    bus_add_driver+0x112/0x210
>    driver_register+0x55/0x100
>    ? __pfx_cxl_mock_mem_driver_init+0x10/0x10 [cxl_mock_mem]
>    [...]
> 
> Move out cxl_memdev_security_init() and allow the pci probing to call
> it directly.
> 
> The cxl_memdev_security_shutdown() counterpart will still be called
> by the unregistering scenario, but is removed, however, from the
> devm_cxl_add_memdev() cleanup path - as this is about ioctls and
> there is no way for the sanitation to become active during that time.
> 
> [0] https://lore.kernel.org/all/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
> 
> Reported-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/memdev.c | 17 ++++++-----------
>  drivers/cxl/cxlmem.h      |  1 +
>  drivers/cxl/pci.c         |  4 ++++
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 14b547c07f54..628d9d1fb795 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -561,7 +561,7 @@ static void cxl_memdev_security_shutdown(struct device *dev)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> -	if (mds->security.poll)
> +	if (mds && mds->security.poll)
>  		cancel_delayed_work_sync(&mds->security.poll_dwork);
>  }
>  
> @@ -570,7 +570,6 @@ static void cxl_memdev_shutdown(struct device *dev)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  
>  	down_write(&cxl_memdev_rwsem);
> -	cxl_memdev_security_shutdown(dev);
>  	cxlmd->cxlds = NULL;
>  	up_write(&cxl_memdev_rwsem);
>  }
> @@ -580,6 +579,7 @@ static void cxl_memdev_unregister(void *_cxlmd)
>  	struct cxl_memdev *cxlmd = _cxlmd;
>  	struct device *dev = &cxlmd->dev;
>  
> +	cxl_memdev_security_shutdown(dev);

NIT: Moving the call to cxl_memdev_security_shutdown() kind of threw me.
I see why you did it.  But is there is a way to make this call mirror
better with pci probe?

>  	cxl_memdev_shutdown(dev);
>  	cdev_device_del(&cxlmd->cdev, dev);
>  	put_device(dev);
> @@ -1009,11 +1009,10 @@ static void put_sanitize(void *data)
>  	sysfs_put(mds->security.sanitize_node);
>  }
>  
> -static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
> +int cxl_memdev_security_state_init(struct cxl_memdev_state *mds)

This needs to be exported.  I get the following error when trying this:

  MODPOST Module.symvers
ERROR: modpost: "cxl_memdev_security_state_init" [drivers/cxl/cxl_pci.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:144: Module.symvers] Error 1
make[1]: *** [/home/iweiny/dev/linux-dcd-work/Makefile:1984: modpost] Error 2
make: *** [Makefile:234: __sub-make] Error 2

12:12:19 > git di
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 18ecb9c90412..492486707fd0 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1025,6 +1025,7 @@ int cxl_memdev_security_state_init(struct cxl_memdev_state *mds)
 
        return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_memdev_security_state_init, CXL);
 
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {

>  {
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct device *dev = &cxlmd->dev;
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct device *dev = &cxlds->cxlmd->dev;
>  	struct kernfs_node *sec;
>  
>  	sec = sysfs_get_dirent(dev->kobj.sd, "security");
> @@ -1029,7 +1028,7 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
>  	}
>  
>  	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> - }
> +}

NIT: this is an unrelated change.

With the export fixed:

Tested-by: Ira Weiny <ira.weiny@intel.com>

Ira

>  
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  {
> @@ -1059,10 +1058,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  	if (rc)
>  		goto err;
>  
> -	rc = cxl_memdev_security_init(cxlmd);
> -	if (rc)
> -		goto err;
> -
>  	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
>  	if (rc)
>  		return ERR_PTR(rc);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 706f8a6d1ef4..b99099eb2402 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -884,6 +884,7 @@ static inline void cxl_mem_active_dec(void)
>  #endif
>  
>  int cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd);
> +int cxl_memdev_security_state_init(struct cxl_memdev_state *mds);
>  
>  struct cxl_hdm {
>  	struct cxl_component_regs regs;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 1cb1494c28fe..5242dbf0044d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -887,6 +887,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> +	rc = cxl_memdev_security_state_init(mds);
> +	if (rc)
> +		return rc;
> +
>  	rc = cxl_memdev_setup_fw_upload(mds);
>  	if (rc)
>  		return rc;
> -- 
> 2.41.0
> 


