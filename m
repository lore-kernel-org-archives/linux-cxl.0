Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD2BC4332F
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Nov 2022 22:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiKGWQU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Nov 2022 17:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiKGWQT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Nov 2022 17:16:19 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C5720191
        for <linux-cxl@vger.kernel.org>; Mon,  7 Nov 2022 14:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667859378; x=1699395378;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PoDmAxe8/YBoCjnLeQ+GRLbkFN54Th4uzg4uPaH+o18=;
  b=MK3bTvyEzkq9n6VrU2OWw8saLKGUy6zLWkYWBKDLIt9lCRUukTLI2Joh
   xPJWtWmSDx3ZJfCHnlk2/76RUmZrw7SyLeYJoEG6ftDqovlT+rzmmHUCT
   0xyfSHH1Zk6MJ8B7rxyM+eRUXkUxbt1V+GZcI7yVBH8SIuwxABMjGJrU4
   zBvdYfNwO7OBhCP64MxVkAeYXI1JjXTrGhuM/WoHnW0OGtrn0H+O7AYXZ
   BqxZORW4tDUZqxDpryB4yKat4Yr98xuXLSZEsqHFCbgndJnigOaz7Npit
   sDIglOoH7YfT+FM4123ly3gKpVO98WDNye6p0foI0IcrGhFGQLeXF4FrB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="396834754"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="396834754"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:16:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="965336811"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="965336811"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 07 Nov 2022 14:16:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 14:16:17 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 14:16:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 14:16:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBMLxJTmHZz8l+dBIp4YbIq3V55vyTNIF5SqSLIomG/dSxnpPHOguybRi9wtfgDhruvtEZuNjbHNAKNUHxw/GP1wrw9lFb1AvNYOhK3W2RFhGj+5jmgQ/+XYOxwqTUrH+gnBnA4ehVeUD6Y/X9IcAHavAosXNpGxeIQ3s8YooG7w2633GhiM+jxW/J8xqqcpXJjufp0PyDU3wg2sxpUSmunhypOEjJsUMT2TSzRIGP3GCRdet98ms4BMAzqPSxhr1fXeHnfvhRxrRA/uCmzu12MGED2asUqWsaPoUnuvgVPkR/qJcvYgGrPTbr3AXxdsEtQKsy46MM4KUPCeNeyQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhLEv9Azjt0qY3Evn//GIuOzkhajeIhDg4z9tuIM0sw=;
 b=drGUj5IuUc7XDlwPhPREK36eAwakOo1CqDkETYU07fxgcPemhjF0FWvDXtlm1MzTIVCBmRKHXtlwi7uNVl3f9+y8n9SMOE1m3UVRRmgboEjpoLpOLR6/fwqaiW0Rr+FgpcM2brYBnyie4HZl463K/3lEGIUbznHDxNw5n6t+zdW7bR30KnkDT+ftO7Xkt3TpOq1P9IeQvy23fIn0ytKVn+b7Oc2zbwX1/LqiWxGYBv82CALFSi1to3N+lUoyEAW3hhhAkTkmVlsVWOehsS/I1PqcRbVAzlSUoujQtiOtx+780vhw5Fe/cC8C7avEJKPfXOELUsbwN6T0rpt9FbGDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6615.namprd11.prod.outlook.com (2603:10b6:806:256::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 22:16:16 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 22:16:16 +0000
Date:   Mon, 7 Nov 2022 14:16:12 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <jonathan.cameron@huawei.com>, <mst@redhat.com>,
        <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] docs/cxl: Fix some typos
Message-ID: <Y2mDrMFgTZIQrraE@iweiny-desk3>
References: <20221107180923.27072-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221107180923.27072-1-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:a03:333::10) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a39f24-c1bc-4ea0-2da9-08dac10db02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQGFwGeyUnLVypQxbonTicIjViGyOyYnMHIushVGjnSTAKDpGKkKOmBGgLpki7nKxzeqfhbyD35A2iEkc70Saqhgu5AQLvMpGamcwR3mugpb6fCZT+Z67DWi3nqtsp/6JlPg+FlC6DqySJfkyNfYJiG+Giv/rAdQn7gWTCt+9J9+iHcD1HslCFpnfssXHMmw8KspWnBTLjticJ3KWNf48h3C2HR7WTDjdBn3gTWvyavBVtgfi6FvnLCcU0QVao55dLPy92NSAOGT+xMtpJByztYYOPCN6cr5GoT91ZFX5L5Kn0CvevHdxFyu+pEaj/pww7XK46Kgug4IabWsLw1rrlDbCkooPEuRvjcJxxodOKM3fbj1Dy8cOsKwHzCsowpV3BFQgFqlzDWr0F5Pmlb/4xfm6UzlR2lWBifAvBZs9RmiyJ1HTxDmzUjMLln5aWHwyUApwGUW5eb5OmABngRe5cZMI658QJ1qZZrLoAbKEPC3RxZim7UpNroxsRyp9G50/Nrmd5VJWIsk4QPH8TUzSeOsECNIOTFbsIfw7J9WmkFJbfDodrO0xBAS4fg9WkbLgi1x1v4k3DFGNL2AT0BtCaqCzNF2Bl4IYdBXTQDJeZ/tUY2RS5th2JRx/eTLlpSr0/mNf40mAEZnccpk2P7EzPulmZ2EB3pVAv7BsBc14S/ktdUcAMnXGxIfNk0OM6lKemWTQqzCVOen2hER8jtROQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199015)(478600001)(6486002)(41300700001)(5660300002)(8936002)(44832011)(2906002)(6916009)(316002)(66556008)(66476007)(66946007)(4326008)(8676002)(83380400001)(6512007)(82960400001)(6506007)(6666004)(86362001)(186003)(9686003)(26005)(33716001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZI8Lr5q0dSI8GYO8Hhlv8BnpIyht2JfPvb/Kc/A/fM7N9dCkpeW8qDq7d+OP?=
 =?us-ascii?Q?/tXgOMmTUywS1e7r9XdfWv7B2S2qOBxXzNex6qT83ERRAZ+2FqN1CaLTj/Xc?=
 =?us-ascii?Q?4Xo0JBkVsfz7x84OQjeh4L5DVcWVVgaxkhMQi6kXdrR6EAMxTOVHCM0k85y6?=
 =?us-ascii?Q?BPKO1jkRoJEEag+Z8VAJVhypVFl5DiN20Q0EP7m+5sUnY9IrRk2D9GqN3i3P?=
 =?us-ascii?Q?8R0pSUeOCImuhalpczTXrKS3fXhbrnmmfLjxuVgJG4vNE8teHMc2FOb9qHro?=
 =?us-ascii?Q?Jb/pfB+p2SvaRKIhm9EqHtW4dwn+4++ZfC0a2X2AXJG/wyeUZIesOMfbEJGK?=
 =?us-ascii?Q?a7Ji9qkN3v8y0jKTKw0iUV+F1e2D57Kbth1HcXwVBryDt8jfm3fALxVOq95h?=
 =?us-ascii?Q?TYE72aUKQMTguxiMOHjisAd87D+rBq9vgOr4n7ECCCgACWODRl8UrVNRoeHB?=
 =?us-ascii?Q?MGIILWg3h73nRZmlGeSlQXSkFgAIGxM/hLUJbYHpmKBF882IIiuMMv8c5YTa?=
 =?us-ascii?Q?6Mr8UYf6CapJxCePFgo1bQ5B8qWjABA1k0Vm8c1Ms8aVttYgf+ZvB5cYoWl5?=
 =?us-ascii?Q?347p41SbOA4iqCZ4HAi0J6EYhn8TTIAGb1Mb8McqV1nNEI76JyIvrVez2kcZ?=
 =?us-ascii?Q?6tP3J8Ha9+m3llVMCw03YMBGhyhaFUSj+RDqnHteUJniUHbaMRC7GfjBwwJb?=
 =?us-ascii?Q?aoS2+h+iPjot/DgeMbgz5hwllQI9K4tavCA8V7oNmVBatsz0jYrtMt3HOPmd?=
 =?us-ascii?Q?ygb5Yds+7fDY7iFzSgkcjyXv1Xs00RLzx4petaM8iRUzpoyLpgGLbPGnLydj?=
 =?us-ascii?Q?9U0bprA9EFAWnGwf+wEkm8sW4rcYC7TqDiXLHi6Hky5HsSNkMK94HJzEphTJ?=
 =?us-ascii?Q?uBQBlkB/wDSK7X7swC9M54xAsWRlW9m3hGC35GbUUI/iLpzypZRtpi7ZYydt?=
 =?us-ascii?Q?70Bo/pCdc5FObcW8gUnCBtci9UqXPCYfKKN8aOe2PbxZhglyHNUDV1kssSdV?=
 =?us-ascii?Q?GPeVTCX1FJ7RMziU5ksxuBkyxntyeCFYziPJ80Sw8X8WUDJU7DfeXvfEcKGQ?=
 =?us-ascii?Q?S1qoKpobxhH8vsJMw5Q9mfGcyhqwsflKoHJ5sjiF80Nb88nprrZbuVjHDR5x?=
 =?us-ascii?Q?0mFANLZHfqKLnbS8pzJH4HiFbsVyAjFI/4yUaP0nC/d5u6t8u9tTS5VdzFqb?=
 =?us-ascii?Q?+X3p8hmK1SdoT/daTyuPafT0oY/qCSrxyoHP1BmRgmJ+DGdNKNc+CSUZqxOQ?=
 =?us-ascii?Q?/lxpyFDnGJakIYvhRJBkSHL+qxYBaTL6jAza389E4/zB54fsro+wsiCRq+EB?=
 =?us-ascii?Q?yivL7irwtSVSk2a5pdMxdtDbcn2Vll2Hp+Gu+ZAU5buBdUSJYKbZQzkyHNWb?=
 =?us-ascii?Q?xN2p9TPwN6nmQW4aaJUYRe/yMtglIXoXbpgHTSHzdU36q7AtTblXRBcrIW9I?=
 =?us-ascii?Q?moC4aYIfhWY2ZUr+cS/ixrS0VE2qGI6apkdme+nZAPy3pZGxx5w5k+2hr0cy?=
 =?us-ascii?Q?Bvl2wtHbVq1Lg3JuKrG3IAt27di6zrJAzK+2UmmzGxExc4F5AA7GOYymyGEt?=
 =?us-ascii?Q?ORbd3WmpOryoz2OcoWlMJ1MLPYbiIlSwXGJkjR+7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a39f24-c1bc-4ea0-2da9-08dac10db02b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 22:16:16.2732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCdvtH5YT0I0wX+IMmGF7wn2aqfU/7onfFestu8aJdrcPo+f3Sl6BEWciEkHYrdy6rRVu0Z2Qcv0tTJdxZ9WTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6615
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 07, 2022 at 10:09:23AM -0800, Davidlohr Bueso wrote:
> Found while reading the doc.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  docs/system/devices/cxl.rst | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index abf7c1f24305..891bbd65d9d8 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -83,7 +83,7 @@ CXL Fixed Memory Windows (CFMW)
>  A CFMW consists of a particular range of Host Physical Address space
>  which is routed to particular CXL Host Bridges.  At time of generic
>  software initialization it will have a particularly interleaving
> -configuration and associated Quality of Serice Throtling Group (QTG).
> +configuration and associated Quality of Service Throttling Group (QTG).
>  This information is available to system software, when making
>  decisions about how to configure interleave across available CXL
>  memory devices.  It is provide as CFMW Structures (CFMWS) in
> @@ -98,7 +98,7 @@ specification defined register interface called CXL Host Bridge
>  Component Registers (CHBCR). The location of this CHBCR MMIO
>  space is described to system software via a CXL Host Bridge
>  Structure (CHBS) in the CEDT ACPI table.  The actual interfaces
> -are identical to those used for other parts of the CXL heirarchy
> +are identical to those used for other parts of the CXL hierarchy
>  as CXL Component Registers in PCI BARs.
>  
>  Interfaces provided include:
> @@ -111,7 +111,7 @@ Interfaces provided include:
>  
>  CXL Root Ports (CXL RP)
>  ~~~~~~~~~~~~~~~~~~~~~~~
> -A CXL Root Port servers te same purpose as a PCIe Root Port.
> +A CXL Root Port servers the same purpose as a PCIe Root Port.
>  There are a number of CXL specific Designated Vendor Specific
>  Extended Capabilities (DVSEC) in PCIe Configuration Space
>  and associated component register access via PCI bars.
> @@ -143,7 +143,7 @@ CXL Memory Devices - Type 3
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  CXL type 3 devices use a PCI class code and are intended to be supported
>  by a generic operating system driver. They have HDM decoders
> -though in these EP devices, the decoder is reponsible not for
> +though in these EP devices, the decoder is responsible not for
>  routing but for translation of the incoming host physical address (HPA)
>  into a Device Physical Address (DPA).
>  
> @@ -209,7 +209,7 @@ Notes:
>      ranges of the system physical address map.  Each CFMW has
>      particular interleave setup across the CXL Host Bridges (HB)
>      CFMW0 provides uninterleaved access to HB0, CFW2 provides
> -    uninterleaved acess to HB1. CFW1 provides interleaved memory access
> +    uninterleaved access to HB1. CFW1 provides interleaved memory access
>      across HB0 and HB1.
>  
>  (2) **Two CXL Host Bridges**. Each of these has 2 CXL Root Ports and
> @@ -282,7 +282,7 @@ Example topology involving a switch::
>              ---------------------------------------------------
>             |    Switch 0  USP as PCI 0d:00.0                   |
>             |    USP has HDM decoder which direct traffic to    |
> -           |    appropiate downstream port                     |
> +           |    appropriate downstream port                    |
>             |    Switch BUS appears as 0e                       |
>             |x__________________________________________________|
>              |                  |               |              |
> -- 
> 2.38.0
> 
