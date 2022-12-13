Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3184C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Dec 2022 05:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiLMFhw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Dec 2022 00:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiLMFhv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Dec 2022 00:37:51 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC3563E8
        for <linux-cxl@vger.kernel.org>; Mon, 12 Dec 2022 21:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670909869; x=1702445869;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DKIusfCWm/jGkcE9C1jb02gmnjHfSnFQRFb3nTOYCvc=;
  b=hIKWXoaZKjGX1IC0XE+VPI4kuzmxptRsmal2BKMWdsQQiiB7UjXB6fMm
   Uo31g+CUslDDZ1qqGpnKiTPn5uKn0x03rekmfMwMvo7RrTgML0TMeKkyr
   KOgVSq1qedfrRQzb+2E1zxrWTfrRrPaoM5E5BAr6v4fq4XnKiHRpTCOxO
   P7Ahru2BCxT48PJEollHJFnAU/YCdHbp2/1t0KYY6HasxiVRVBua73oxd
   8UkiGiTAN43qvcp7DT42xUtz6q3gSwTvX23oMyhTAjWLuosSS1BlL0Y9M
   jFVLJPCzHtWrgR9BMHIxPf9qQgDVRYcMpqOZU+p16fb9ULD4jRn4/AH+o
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="297726563"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="297726563"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 21:37:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="598709720"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="598709720"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 12 Dec 2022 21:37:48 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 21:37:48 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 21:37:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 21:37:47 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 12 Dec 2022 21:37:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5+wIwwniV8WBr3CAY3wBDiKqeECMK8p1U20K75bgMdtSwJB/k0MZMWmopNyLW6Fw62mq+DlJp8xJT85QpvRIu8i5o0Ig0afSMk+ID2BMxoWDRyalBACk/r30vonGP1OyNf/Bj0j1trGBapmbJWui/7ffcCt/aaQ3HTGPnPGSPekZYvYTQslU0+oRw1MHbp8bHfJYIeBVAGqwJUB/CakzBrpWTJr8WEBkMOaE3CvSJmIhAtguM1oiThxeWrQwpQS7cRr2R/nUTONqJLiapTPeWmvIpSOL0rRuw2QMlZq5rIHjxV7+Hq18TpF8HGDc3ZOMvpDfP6WtYphqBMQmyQ4Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYgFs8/fwIWyC6Xb5wPb1MvhtI/YLXiQA2YObrOktmw=;
 b=nbIMw2Llt8Qevlo4Px1dAPw+trmeX9y/+j9zZVaovIKyEnGPdKFmOtvq3hwhslbrKdrdA4Yvm/A9gps9iNe+4B2L4X448cKuucTbL/l5ED9b5SkM8FHftOq9+n0Votdh37QSZytdDulRvebiEL/+yojLrAUcbiXeaZj212cQ142kxIlSm0FkEjeb16Wz48FWTYLVYU0C0SpPN6jVnpGKCGKF2AJTgavhK/48/oDIbJ4FXgOBq2S6DLH8PehFtAXsR4zkZU09f4c6ZcOeweATgcfdHXRB5Y3t0L1mE4wWLCKjzO+6A2Bak11ERIRGl//cOs/R/oywB2XoceiQJMdhFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ2PR11MB7574.namprd11.prod.outlook.com
 (2603:10b6:a03:4ca::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 05:37:45 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 05:37:45 +0000
Date:   Mon, 12 Dec 2022 21:37:36 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>
Subject: RE: [PATCH] cxl: add RAS status unmasking for CXL
Message-ID: <63980fa088d9c_b05d129462@dwillia2-xfh.jf.intel.com.notmuch>
References: <167088362227.2423645.1158488960356900672.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167088362227.2423645.1158488960356900672.stgit@djiang5-desk3.ch.intel.com>
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ2PR11MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4adfd9-1e8c-4ba4-ca27-08dadccc2874
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZoyBHnkIJUCrw7SzHu3XDsNOOLJs4+tWKjv7+A6kqQYheSX7AJT1b0hl8P9TYVnjCKJCVDpcTvY5dibHSd6C7ZJc1JV4UXRJTQKuMl92NCz6WTddNs6PzBCcm1ydt7UoJOJW3oCyGMgXiVFoDL6nPx3AgnewYimMhXHTuNYnG9pQPdeX05uUFOUML4s6Dl31zbPmnmoY/JcfjV8r5btuhPM+dV/rULWgm7ZTjv9LlbAH1n2c2ZpqKBfzQY7a8r6SLIKVC812Fh/9kUa79QZzq3THSd5uAA/O+JnVT+QKnsdZpHOa7Zwd9jbBVbluQQYlNcVd9DGXESywzjj6lBe8Q88wafS6pOp3RE82yPDfQE2arPaKBio6ZNUtqDQySoW58PKQUSCI2BDnt8oYpxY5emG43oF73Q7+2kh1BLrLCyoPTaL93HPx4fIWYDbLNFS+38asS8Sa3wiTLHaUSzvM1g+iyMeFSuNuuQipco0U53spcPOm+usdnd8Whp53pv5a1AZ1L3EmfnYDQWAxTZiV3g486Dtw9YLrAfgEYznH6hg43ZsbfBQs9keNYYyD8nZOn1mWjtvkzSgembl9KyXIvqT2nGMG3XBwB+jJM5jS8+k+C0CXd1550Au1QVFpEy21wuLH0lLMtXcPVSPSWvsaZzSB8tCidCdPpsjn8c4gP04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(86362001)(966005)(478600001)(6486002)(6512007)(107886003)(9686003)(66476007)(5660300002)(4326008)(66946007)(66556008)(8676002)(316002)(41300700001)(8936002)(2906002)(6666004)(38100700002)(26005)(82960400001)(186003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YURzSJyEYRTfgOtQjHPyAWnwlS1jXrPS8HfrFKpMq8aORG+aEi3teS9Li721?=
 =?us-ascii?Q?6HjL1c7LT+NRwnocSVCtGqxl5SV2kYGIxFHFMtvSrxRXWnUIPdLQ5R6BaEkD?=
 =?us-ascii?Q?XMcG8WMmlhJOXkCFBQIiAwUqaMm/o9GZZaJpyu2uXSHaZY2Lg8IwC00nTKcM?=
 =?us-ascii?Q?zlIWoAyP8PrjGPr/LkKTtiuCLwa78wLKhPhGQyeWBoc4oicEcfEKl1IiuwVe?=
 =?us-ascii?Q?Z+uxzk47qBsVMICdsVW4nmgx//UDY4msWr0vTDheJSloiWaAHwz7afeQKMti?=
 =?us-ascii?Q?EvhOuP9XEhh9nF0ltOD42EN1qy9IcwD376adt6ZLwESUqewR9/A2VGkWfnxw?=
 =?us-ascii?Q?9LOSAOqYLTwUtKvwFbCwb4tTK4Aco5IwJaM62HdAG0Z0AfUeykRK6YAINnwb?=
 =?us-ascii?Q?xsKMSWCwcB2SDmMwLjkrsFPCtx4sVmDekpL6mHL9AgK6b3/I2J+awPCgOwBK?=
 =?us-ascii?Q?PLmMfY2mGfTAL+RqhTJY5QpDh5pdebZwUT4+Iqs6gRsXsess3siJ2rWV99By?=
 =?us-ascii?Q?FwEX9+J+mzelIjfkRQLndeDl4z9lcK1IReOjtUYRjqlNVaZHLZBGpX8nvqmp?=
 =?us-ascii?Q?xQKkq/3FjH9R0/KtrtKOfF24siyEHqFBsDvD3pcmO4qrX9m0Wrl6/k0fUrYd?=
 =?us-ascii?Q?VQt/YI7Yb9qjfQbiVs6L8Sr0AGHy82NZp2zIiiX1SpiwYo7Rd6oL4m98Y/u3?=
 =?us-ascii?Q?CxsKDYijK3hwHTNOHNKeagUIcT8bfnzHEbvXawRlIZv2Rrsq51yc03xmjA1d?=
 =?us-ascii?Q?OGqpoRC1Ezz4CTmDv5qAus3MvtOqjDeg7UXqxn8LcVupRcUUi6Zn1pc33ffj?=
 =?us-ascii?Q?qW1unFZVHkOlUfNGkegKhNXaXN5FDX6cjs8IQFbcrnnX+gNvAqlPyaZylSga?=
 =?us-ascii?Q?4NKVX4d2nO+1Fid9jINAhtPR3NPhUOwtxU8r2K6TMi6gFHXj2Flkm7NiJKSV?=
 =?us-ascii?Q?wmJT3s2EBM6ZHY+P/qdcfb5BH6+Mc9kIvouTJwNmir1OI3Ge6tAXA9YTMCds?=
 =?us-ascii?Q?EfHCz2CZp5DXWtu6P29oWgcaY6QQcKg26l85U1sdo9xb5ZrlimuhM81y1WnK?=
 =?us-ascii?Q?Jl3RcoPtX47uTwyhktRF8lsSCdj9hWx45YEBLyOJVAhYJpUw2yevqp8tzGUE?=
 =?us-ascii?Q?poNPFpss7qSlkQuuyfeI4ydDsCiK3BepIu25pvQxsvYg0t4IY+bZD4dbF/nY?=
 =?us-ascii?Q?CKkaMiOsJ/473CjtHLJhmwnH8D+uUG35l/BQkZI7JWjg2oDTuX73TCDGom63?=
 =?us-ascii?Q?zzOrbK23asBufOQOR6PLnl4PWrYlmr7HT+3+psFc0vYiHlMXhIapQSY4XKTq?=
 =?us-ascii?Q?kkDF1q6iJ7GBc0JSqY6e6WVewD6/XhJJoXjwmyYfUOTNQZa8KIkqFtME2pOd?=
 =?us-ascii?Q?cutBMxjsU5P5XxLI2Ah1BYiSPCHGqFWxPbxRB0PGaKc2qUaVswbdhoYaerBl?=
 =?us-ascii?Q?ykk5+MWeJRx3j8uMbE2oGRGDy0Ux9GeSDN+PKFm8NJZ/I7hvoyxQwDHZcxbK?=
 =?us-ascii?Q?KRtewoM9ob6cO8cdDjbMwpx5rPO6wxz/89/k7Ch7dy8Ah87+7kaNGUkT3iwE?=
 =?us-ascii?Q?3cwSMCRDIr6Hu8qVrqDk0Nl4BmGufflTobQjJT64JeVxmdsFI5rhAh1SF2Fm?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4adfd9-1e8c-4ba4-ca27-08dadccc2874
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 05:37:45.3401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wvKR9zE/EdzRGgodB6oOasmB09VWSodOKu+uFJAIzVtgfJEUA4sa11t4+gaPyNmVVcupuuY4KiBE38NaRKZFPoQd5w4yCBSAqHhv2aoqa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7574
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> By default the CXL RAS mask registers bits are defaulted to 1's and suppress
> all error reporting. If the kernel has negotiated ownership of error
> handling for CXL then unmask the mask registers by writing 0s.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> Based on patch posted by Ira [1] to export CXL native error reporting control.
> 
> [1]: https://lore.kernel.org/linux-cxl/20221212070627.1372402-2-ira.weiny@intel.com/
> ---
>  drivers/cxl/cxl.h |    1 +
>  drivers/cxl/pci.c |   36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1b1cf459ac77..31e795c6d537 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -130,6 +130,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
>  #define CXL_RAS_UNCORRECTABLE_MASK_OFFSET 0x4
>  #define   CXL_RAS_UNCORRECTABLE_MASK_MASK (GENMASK(16, 14) | GENMASK(11, 0))
> +#define   CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK BIT(8)
>  #define CXL_RAS_UNCORRECTABLE_SEVERITY_OFFSET 0x8
>  #define   CXL_RAS_UNCORRECTABLE_SEVERITY_MASK (GENMASK(16, 14) | GENMASK(11, 0))
>  #define CXL_RAS_CORRECTABLE_STATUS_OFFSET 0xC
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 33083a522fd1..7fce67d493f3 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -419,6 +419,41 @@ static void disable_aer(void *pdev)
>  	pci_disable_pcie_error_reporting(pdev);
>  }
>  
> +/*
> + * CXL v3.0 6.2.3 Table 6-4
> + * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
> + * mode, otherwise it's 68B flits mode.
> + */
> +static bool cxl_pci_flit_256(struct pci_dev *pdev)
> +{
> +	u32 lnksta2;
> +
> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);
> +	return lnksta2 & BIT(10);

Add a definition of PCI_EXP_LNKSTA2_FLIT to
include/uapi/linux/pci_regs.h?

> +}
> +
> +static void cxl_pci_ras_unmask(struct pci_dev *pdev)
> +{

Could return an error the same as pci_enable_pcie_error_reporting() and
just have the caller ignore it.

> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	u32 val;
> +
> +	if (!cxlds->regs.ras)
> +		return;
> +
> +	/* BIOS has CXL error control */
> +	if (!host_bridge->native_cxl_error)
> +		return;

It would be nice to have a dev_dbg() for which errors are unmasked by
this event, so just print the initial value.

> +
> +	val = 0;
> +	if (!cxl_pci_flit_256(pdev))

Perhaps, before this, check if any of the CXL protocol got enabled
(bit0, bit1, or bit2 in Flex Port status) and skip touching mask
otherwise?

> +		val |= CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
> +	writel(val, cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET);
> +
> +	val = 0;
> +	writel(val, cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET);
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -498,6 +533,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	if (cxlds->regs.ras) {
>  		pci_enable_pcie_error_reporting(pdev);
> +		cxl_pci_ras_unmask(pdev);
>  		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
>  		if (rc)
>  			return rc;
> 
> 


