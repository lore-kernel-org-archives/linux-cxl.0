Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23580E784AB
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Oct 2023 16:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbjJBQ7T (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Oct 2023 12:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbjJBQ7S (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Oct 2023 12:59:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6B2A9
        for <linux-cxl@vger.kernel.org>; Mon,  2 Oct 2023 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696265955; x=1727801955;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7weu15f99GSni0qM9JMoK1RSgFgeNGX3YqVES03pJLo=;
  b=KEaQepW3XkXnVGv1e1HkR2Ht1srJGCf/hCYSCkQdOgb4tZXLRXp5Pr5W
   L7oPfkV1LKQUYLPFwQI5fgd0HEMI7UIvk57H8y0JthpL/IG3iMskWYw7H
   d2IMuNsY51JE0rW8xAw3StkNUPJKjBo8E7JsE0sFeOvSM8WwEoPfgRX9o
   HvqZZ3G22DbjmwzAv2DI8H5416027ZfDvfXhYdKYASGEq2duadEO7zx4P
   6mxdrdsbXFZw59Q6iP/DX4QntPfAPHpaHvQoMfcBVxeaDWctcB4FoVHPI
   8fn3lWT8W9KSARWZAF8SfQwHywOOM6X2+9T6yfCb3PUQhHQq3OD/Fdlqx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362957655"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="362957655"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 09:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="997686378"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="997686378"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 09:59:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 09:59:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 09:59:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 09:59:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 09:59:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCgVkL4lA2AMGtTWotkd+D3mfWdYnMGBMoTnWsWk4AgNR/ewSwXKtZMS7C+w62zz1bHTQEEu2ZcUtI9zmNkED5Y94fTAO29gwF9wNCnipm3mdph/MMJhY469bzAwSabjIMQxMX1tFMJoQTzJvuKf0GA/J9BAxFb7U2YgZMSCGO/nkjqPTYPM6S47bWMbwnPgf3YbdS8RnNeAaVjMDL+0rSXGQCs+Ych/+Ufg5bnBAlmW8ZQAlgp4Z41vuIrOWoDVL+iR5lFGvl6gCvDNOHGUsdq8xkBL8O6cSJg9vZQecrePVZaqh6IYxAVPwifepAO4/JObadHvL4FiHa5IQUXRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBor4s79ve4sAegqdD1lzoHsiI+/O/Xmg2TKYjUO3SU=;
 b=hSRC7ix1pj07tB8xgBf/x3U7pCr0WGP6VLUVZa82IO5vOhVNAbszmiOaVod7uX31f9EItkSQtP9yehWXYIDGJsj7PxIGMAcUkHpAZx8H1SC/swpVfqhcxzKOr6Rz04puYPMZUBPLvhSPdGlYFcXioaxAb6NJ6Yo+rWS5m6bdtXeNU4hlO9iURRXfVIf0V1FPhzlvnnijqnv0OKAs+WE8myBvdWc4TrUL8dwGQRphfAg1pxhUKTqKFEZqJGO6qRTKagvK1Wmc9AjTFMKw69FkKj7snaMtGoVvCIXaV1ZSeQtRbpIyVipq7genuAEbpFVOK0ocOt5YTXJbP+qgP8xJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA3PR11MB8119.namprd11.prod.outlook.com (2603:10b6:806:2f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 16:59:12 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.029; Mon, 2 Oct 2023
 16:59:12 +0000
Message-ID: <0644eaeb-7222-4bef-9acd-cd881fb5db30@intel.com>
Date:   Mon, 2 Oct 2023 09:59:09 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 3/4] cxl/pci: Fix sanitize notifier setup
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>, <ira.weiny@intel.com>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0044.namprd11.prod.outlook.com
 (2603:10b6:a03:80::21) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA3PR11MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f66dff-4d6a-4d5f-32c8-08dbc368e6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xjwWAdaHuxkMDgLun6g3sAubOzThxvgLEK2AoimEIyiajz8+F2Yp9WViqcgZL3c3L69BMvTm8/AMubU/Ax7LG8j8pxXYl6B8AxKpKzW5XaelbVsiu0PdTPTRrKuBPok4Zp/DJCdp9dCSEgfXFundcSYRtdfqs6CjV/+Dl0PrHaVMglCuWXOxYqWAC6garu0XcmIukd5uSBma2yyXz6V1MvHVZ2ZGpHHi++nP9SFtKPVqkYcHBA5EJcOQ2VoN8hmH8hHRmJH85nchTIJ2P/amUT8qaRB09CzoT3D4XD2xKzHOQ3pL41+Y02lrzi8EOP8GHAojRz9eCTBbscMvg7ltPhSnTCO49kf/Svj7Pm3MfT8PGBhvKYGo4c/uILlqe6FZh3eDcUOFymP5bQsb/X4tiPORaSculEF2Y3k5Vw6aPIcUcyeSubsJH84d8zBVIbFdueoEam7mD6EGZDu3Ii1f4FMnj1JTj5a3XM8yvlNDKgwZpxUIAiIMszx/q1Bc9zXGvUJtM7dRxoWfxD2cHf1beA7BX8wmi5t/QfxwTa/kbo9YPpR6B+GhADghmXDmkONeE4ccSI7Gxr2wYAwNRi1h9FHmj5OtYt34RvHVdI0CVAJu1iNIQVW12nmM2rFfd6Cz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(4326008)(8936002)(8676002)(31696002)(2906002)(86362001)(26005)(2616005)(53546011)(107886003)(6506007)(36756003)(6486002)(6666004)(82960400001)(38100700002)(83380400001)(6512007)(478600001)(5660300002)(44832011)(316002)(66946007)(66476007)(66556008)(41300700001)(54906003)(31686004)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2Y2cUlLZ0M5WlMzR1lMamk1ekZuMnc3ejRCNW9wUU9xUjJ0bGg2OVc5OHFC?=
 =?utf-8?B?YmozcXBGY1c4WkZ4TnRJTFEvREZiRHhqZFMrMHBKNXRTRmpkOWJRQ2IzUEtX?=
 =?utf-8?B?Q0t0R2dGOS9kaytmYW1ycndwemt0QjBqYzMwemtWQk5mdHh1K2NxcWxoREMz?=
 =?utf-8?B?WHNzWVpFL3FxSE8raHdiL1pJRWpRNzJsdFdkTGlKUHczMG5YNHlZMmxyaTZi?=
 =?utf-8?B?My9CRXNpQ0ZoZ1dmZGhMeUZTcTJQajR6YS94U1JaTlU2THk1YkhTK1pNYXF3?=
 =?utf-8?B?RjNONC9rMzEzUnV3SHd3ZHNaNjMvdFF4YnpHb1dMUTB3bmpJYVpaQnlNWEJZ?=
 =?utf-8?B?cy9MZWk0NXBiclFpQmovVTB6RnFmaldmcUxtc2RpQU03SWRiVVZQbjR1cVpt?=
 =?utf-8?B?d3N6Z0ZXS2Q2Mmt6dktUeERIU1U0MFE4UHdPSzVSYXpFMkpxOC83QnRGbE5C?=
 =?utf-8?B?V1JVSkVDd1Z4MXpoQ1lUSUNJWUdMRXBya2FNYlQ1MGxWbUQvbFRpRFRkb05S?=
 =?utf-8?B?NzA2ZER1dTJRTDZJaVkxMDBrcG5zcTV0OEFKdWhVUUFGNnFoQ0FnRlNKcEpS?=
 =?utf-8?B?UTJ4NXJsaTFXU1dxS2VPQTlDVVVOZWlmcWtDZHlCbVZQVVRPSHArQ09ZWk9m?=
 =?utf-8?B?SHpmbExBL2dWMlVDU1B2eEs4N0xJOEl5SDVlRTBVZ0poMEVrWEoraTFZazY2?=
 =?utf-8?B?M1RoSWZhWHpoM0lwTkVtYjhvRm1PdlBVMng1Y0V4TDRZMk9WajdEMW5zamZ0?=
 =?utf-8?B?QnJwcktXRXBzUmkxaGNLNU9GeHJDSzFMbzFXV3RRSm00MDM4bDNyMkhXVjdY?=
 =?utf-8?B?elFFaSs1U1pjaTkyZlVEQmtOSWQ3TkdZMG1VdE5VK2NqNkxVZVRlMEVrMjFL?=
 =?utf-8?B?eDhDVVlXRVVhSTdPc3ZjKzYvdEVZa1lYcEhXSkY5aTBIMkdXQzlycXBVNDd3?=
 =?utf-8?B?clB4eDFUZENIWE53UFBjMTFmU0VUaCtoeHJRakdDQ0Vha2ZjaGM1Mk9VRGp5?=
 =?utf-8?B?MmJGbWVwUlJOM3RNSnh1dHh2VmFHZ0RGNDF5RGszV0R4TzVjTkpaMXBwRGpU?=
 =?utf-8?B?V0x2cCtJeFM5Ni8reExZZEJ6MmUwZUdzb2FFWkJvT2ZiWEh2WW4vRi9KY2Nm?=
 =?utf-8?B?SXBnRmRtSmVQWTZVQXdLdy9BWThmdEtXOGpaTjNJais4SzZzck9QVDZXYi9Q?=
 =?utf-8?B?a0NPRnhqekVJaWYvUExJMEsxb2UvK25URmJEK0ZxZkt0eGVpL3lIeC8rSGc2?=
 =?utf-8?B?ZXJBUHpZWEhZaWtFT2poekpYNVVOaVloUm1RMmUxYTc0YVRnOWIrNXRxcjkx?=
 =?utf-8?B?eWRibGV1bmZWL1VabytrM1hma1QwU1lTRFl3QzN0OEdhQ29SNTZjblRqYWVE?=
 =?utf-8?B?Mlp3am5aQUhaQTVlWXBXZG4yeFVFUkY3dFNZZForVklPVFQ4YkYvendlckVR?=
 =?utf-8?B?SjM5M2RtUitFMTEyamdMVXBoeXV2VmdQc004QW9saWFTL1dUWm11SzRHUVhV?=
 =?utf-8?B?ejJaSnlpamo3aDZuUXZuemRaay9iYTN2MDBPQkErWll6MlN6dDJZcm9OT2Jt?=
 =?utf-8?B?SzduQlI5aDlOZzM1SUJjNFY4ajVJL1dRcFVsMTRJSUQybmt2NTZUY0t5Rysy?=
 =?utf-8?B?OEtoQ05HL3Q0b0NBODdkSXdtK2hneVh0a0QrUDFNR28yWmUxUzNjVy9XV2ZV?=
 =?utf-8?B?dDNndE1GM1dXam9oRTJDQTZkRjVkWTQ5WWppNmxOT0ZIaVpaQjhSZmtmcitU?=
 =?utf-8?B?ZWFlb3dhVzZiZ2Qrd0VjV2RPUnJLVGZoS3k4STBvRVBhbE1xbXkzWU01Z1Av?=
 =?utf-8?B?Mis4VnVCL2w2NnBlZTdqM1VSa3F3WXloQmNrNzhZemc0RXpRTGxJYlFlM0NR?=
 =?utf-8?B?SEZ0ZE1KeFlPODR2cVFFZnBGN3dPbDJINlpSK0VQcmNXdDl0cXhCNGNLZ3Ez?=
 =?utf-8?B?eVBqaU9UWXJGbDl6NS9rYjVXcUxQYU52d084ekFUcnFtKzQyVXo4a2NLZmJi?=
 =?utf-8?B?enRKOVUrdUlNdTZrbGhHcjh4RXhZVGdQZXNWYkhHZWh6UEd0MDNMeU4wdEZa?=
 =?utf-8?B?aitJcTcyZ0pYNEZhZmMzS3FMY0g2UzhabGR5THc1ZTkwQkloTFlHRjMvd2Nr?=
 =?utf-8?Q?rTWS0U82k+uhPBofa9SvJgJZq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f66dff-4d6a-4d5f-32c8-08dbc368e6cc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 16:59:12.0919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nb+cW1UEZiEqPK1eVPvgVd7wmIogizsVaGF5yhsd9mSzoqIYYPVkF99oIyBzDZgo5i4dHE6GNPJvfHpupD3wJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8119
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 9/29/23 16:09, Dan Williams wrote:
> Fix a race condition between the mailbox-background command interrupt
> firing and the security-state sysfs attribute being removed.
> 
> The race is difficult to see due to the awkward placement of the
> sanitize-notifier setup code and the multiple places the teardown calls
> are made, cxl_memdev_security_init() and cxl_memdev_security_shutdown().
> 
> Unify setup in one place, cxl_sanitize_setup_notifier(). Arrange for
> the paired cxl_sanitize_teardown_notifier() to safely quiet the notifier
> and let the cxl_memdev + irq be unregistered later in the flow.
> 
> This fix is also needed as a preparation fix for a memdev unregistration
> crash.
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/memdev.c |   42 ----------------------------------------
>  drivers/cxl/pci.c         |   47 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 2a7a07f6d165..a950091e5640 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -556,20 +556,11 @@ void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  }
>  EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, CXL);
>  
> -static void cxl_memdev_security_shutdown(struct device *dev)
> -{
> -	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> -
> -	cancel_delayed_work_sync(&mds->security.poll_dwork);
> -}
> -
>  static void cxl_memdev_shutdown(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  
>  	down_write(&cxl_memdev_rwsem);
> -	cxl_memdev_security_shutdown(dev);
>  	cxlmd->cxlds = NULL;
>  	up_write(&cxl_memdev_rwsem);
>  }
> @@ -1001,35 +992,6 @@ static const struct file_operations cxl_memdev_fops = {
>  	.llseek = noop_llseek,
>  };
>  
> -static void put_sanitize(void *data)
> -{
> -	struct cxl_memdev_state *mds = data;
> -
> -	sysfs_put(mds->security.sanitize_node);
> -}
> -
> -static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
> -{
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct device *dev = &cxlmd->dev;
> -	struct kernfs_node *sec;
> -
> -	sec = sysfs_get_dirent(dev->kobj.sd, "security");
> -	if (!sec) {
> -		dev_err(dev, "sysfs_get_dirent 'security' failed\n");
> -		return -ENODEV;
> -	}
> -	mds->security.sanitize_node = sysfs_get_dirent(sec, "state");
> -	sysfs_put(sec);
> -	if (!mds->security.sanitize_node) {
> -		dev_err(dev, "sysfs_get_dirent 'state' failed\n");
> -		return -ENODEV;
> -	}
> -
> -	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> - }
> -
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_memdev *cxlmd;
> @@ -1058,10 +1020,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
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
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ac4e434b0806..b0023e479315 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -165,6 +165,49 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>  	mutex_unlock(&mds->mbox_mutex);
>  }
>  
> +static void cxl_sanitize_teardown_notifier(void *data)
> +{
> +	struct cxl_memdev_state *mds = data;
> +	struct kernfs_node *state;
> +
> +	/*
> +	 * Prevent new irq triggered invocations of the workqueue and
> +	 * flush inflight invocations.
> +	 */
> +	mutex_lock(&mds->mbox_mutex);
> +	state = mds->security.sanitize_node;
> +	mds->security.sanitize_node = NULL;
> +	mutex_unlock(&mds->mbox_mutex);
> +
> +	cancel_delayed_work_sync(&mds->security.poll_dwork);
> +	sysfs_put(state);
> +}
> +
> +static int cxl_sanitize_setup_notifier(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct device *dev = cxlds->dev;
> +	struct kernfs_node *sec;
> +
> +	if (!test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
> +		return 0;
> +
> +	sec = sysfs_get_dirent(dev->kobj.sd, "security");
> +	if (!sec) {
> +		dev_err(dev, "sanitize notification setup failure\n");
> +		return -ENOENT;
> +	}
> +	mds->security.sanitize_node = sysfs_get_dirent(sec, "state");
> +	sysfs_put(sec);
> +	if (!mds->security.sanitize_node) {
> +		dev_err(dev, "sanitize notification setup failure\n");
> +		return -ENOENT;
> +	}
> +
> +	return devm_add_action_or_reset(dev, cxl_sanitize_teardown_notifier, mds);
> +}
> +
>  /**
>   * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>   * @mds: The memory device driver data
> @@ -875,6 +918,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_sanitize_setup_notifier(cxlmd);
> +	if (rc)
> +		return rc;
> +
>  	pmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_PMU);
>  	for (i = 0; i < pmu_count; i++) {
>  		struct cxl_pmu_regs pmu_regs;
> 
