Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5EFEB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 14:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbjFOOva (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240267AbjFOOv3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 10:51:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F3D273C
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686840687; x=1718376687;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=norn7/n+dAvKLkRGDp4RhqmAc9SswMZSjEp75ojV2KI=;
  b=b9JEi636n0DGPC795MWZ+T4MMtVEzTxTEZCc6+Kf1VLwqyLkrztskqZe
   eT5TV61DSASFjgh8k/FF2oK8uFzGPU/DyLaTVmio7mxXRTLIHwEERY7Hs
   +cstAHu2JMoiFDJpYhzKEcPXccOYjdRhTE8bd1aC3DEQbJLZCEEtkh0Xd
   BLSneecD3NSoxd2c0CrVL5JVy7SqXf3FCOEArkeCTbhdZs6CgpbHXVapo
   XlmpNEx4XoonRlFupGvVsf6Cm2k05LN6iLevey1lhd4TzyDDDhh3WrBHe
   vSd7h8GhG8f9LcR5UeqmPeOmOiibmosf1h6TptsykyR/ZV88qvN43mQR5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="358925860"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="358925860"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 07:51:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715661994"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="715661994"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2023 07:51:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 07:51:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 07:51:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 07:51:25 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 07:51:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/enDQRgq81H6syaOuXo5FatvgxwSduj3NZh2DmiGrcoOY8jdr/C/Vhmmfvzv/xadAJNI0nP2qLwu8MebBp1GhIi/ZXmQjlqotJtLjxXCv1KVRS1OEV6IpHR+/ep7Qpm1Yn7W+KOK7t8VrvBsEd7Iyq8dRTYaIpeGePZGPk4321nSegAZQSmouaAIdg4JjOSNP1E+f5OprO/irLPcqxf+Uk4D85/MzpRGIjoDSHcZrcFVghVKkJ3U1SNTNd15VD2k+6zHBYPSR90WzTJEFkV4yfRMf3/fvKZCDJd5/+0Y5U6QjE/d27QPvVFXXAWyhBvypNvPrT+Gt0U4zgOwVGIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rwGlhAL1Pli3Mc02VtalLoCoo+NEoaVr3pKt1CBmTA=;
 b=J/v8RBCXrno+LvoYOVqMxoNv3+np5BUQvO5yKFqLfA7+76S3G5sPsdnUVwjTR/HgGgAgH06HhrJ1FS5gyBRyfalRnNQD23CnkEiEGCukRwBEy+PVxyn+Zhj4TjbjeQTnWwje/qznXGFcK61lEjxhCDZuwWpkWCYgXB3eB12Eur4pnMQPn3Y0J0WMN//nlxv0fDapFyoxwCq51DxqmXE3rr+YkvwtvQ0iLbFlyOfrB/ba+6Yx2Zkhkyj1ejhbSJ1OraBJK984GxvgPNxAGMIp284F0SrST4cFO/M0aaNJv20oCdjS3bFE0/pdxGTITTjxooNKCdmJJ2wYfcmO7Q6CiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB6668.namprd11.prod.outlook.com (2603:10b6:303:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 14:51:24 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 14:51:22 +0000
Date:   Thu, 15 Jun 2023 07:51:16 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     <ira.weiny@intel.com>, Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 0/5] cxl/dcd: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <648b2564bf039_1c72cc294bc@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
X-ClientProxiedBy: BYAPR07CA0108.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::49) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4fb180-a3eb-43f0-385b-08db6daffbe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6lFg6oYYKQBwxKYW9CHXlFnC7yI8SB8epd9q1mVynTmU19iGpi+kx1aJsrlM5mJJG2WLmLIEmEy4R/GxJGEx+0Xbgjg9xa4xADmtulAwuL0nys4z6MTPv2DvJBhMiu2nUEWnYJ5j3zPhtvxeHQSg7kFo122s905P98AYEcZfj0TLEJpr97fARQh/kmwQNECc8V+8/SAN4b5GDxDJKcp2n565y2kZ27FlZr0fm+jmf80GugoW+QMFnbTJzh3AO3zyaJ5cea7XVaTSC8CJlgcXsjjeswjWFielEDhqcfkLy3RfoHcpHie/iJrAFj0ktQcl+CKZx0/hHbCQeOPhIvZYu3VI3lLiYD4PNoGs+jYPigg2dxYuxufS/UpR27WhmZyGwb4xgjv7r9GsGR0r8wtfuPRu2ThaJ3fZMn/IeTZaVhCxqWwLNL3BeAmVaK9ASSV7mHUAdIZEmYC6uOCGTQk3a3niY1/OVkc/XcGp8EBw2619tnFZoOJmbL5oN3rXW/jHfQdoEw0rbKg6u6plsaYFQ9my4X6aEA9YjcjXdVZKN+fAutDhb/VtqNRvkA5jSnnf6YCk/aFbYiaF3kAF6hsQqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(5660300002)(8676002)(8936002)(9686003)(66899021)(186003)(44832011)(6512007)(6506007)(110136005)(26005)(66946007)(6486002)(6666004)(966005)(316002)(66476007)(41300700001)(66556008)(478600001)(83380400001)(2906002)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ksL5yyAysNxBBtq2Vb58C5NubZ2RC3xZXAzwxYDTE9gGm57kL3uinvWudGjs?=
 =?us-ascii?Q?sBf4srYUceQjn5HMh6xXH5feXZ2ivozChcpPcfif7r3DSYQngnOYU8VGx6jU?=
 =?us-ascii?Q?3PPVIhlEfUU8GxjnTuelsbQaCsPO4HeKAb9UiujM2lJUd7utOApT96J/B15Z?=
 =?us-ascii?Q?THaDldlonK8Mf24Jc6Iw068CdB88v8oOUBQ5S6GGR6eRHxqFO7IIGCciu8Mv?=
 =?us-ascii?Q?Sk+ygrieEj7DG3TEp+nmkQAVIjfEC6A+jPrlZKlMA49fnyL0Sz38wnRaUp6X?=
 =?us-ascii?Q?EdPDFm9qG+CkSkeZ737dR2OolI0/U7GpeC/juSX2DSjPHnynU2ExstZd0p6R?=
 =?us-ascii?Q?vew+wk/oWA7SAOP4Cfj1gFaKlwTjvegMelr6LwUHOuTrPn9zmFe4jDS1lFu6?=
 =?us-ascii?Q?286URJYRuCx+/d8/IpNRxWp/XJV/kTlFiUPEyPtnQ78tw+RALh0HgPcn3OHa?=
 =?us-ascii?Q?D/3gKsFJpUi1KcZflsxBb64swwUhZf8kqIo5+bXQuzjIuvwJeUv2aiyivGdZ?=
 =?us-ascii?Q?DY5BYaQ/cLDVzDtL6z4al5UDena5cfPxWoY/pNgdgE1gIt5u/BuDc6GFbwOQ?=
 =?us-ascii?Q?LOzGzTF92faBbVdIt3a/8xQyRqSxOcnpRYfJTl528R5qOIKFZ7atDvfE6HW1?=
 =?us-ascii?Q?2CWhmHRfLdcEWYQAxEdIg745wMpRwt5yIppWZy1T90TnQnObDiIDeKXq7T7c?=
 =?us-ascii?Q?Mt7hCWTPpW1RP6Py6GxjQ/MsS0JHubhsxHvlhbTVl61Tr6ns9g024yCGzkrX?=
 =?us-ascii?Q?mh2jFDxpEChcdiB3P3MpTKx2uIkwJsjF+2p4glxD9Y8WxAuOBZiyami4WjnA?=
 =?us-ascii?Q?/pn5U81uTuW9bZPPCZN+NCdKffieLi6lCyg97cWbwBNsQ+csgTRY/YkNnbTa?=
 =?us-ascii?Q?mKOosJUeh1C8svjWluQjidpHdbQwGxUxNhljWO1HUdDgAXXpB6sQI625/yWz?=
 =?us-ascii?Q?g2XhbFqVTlwoZ/ReqWl0qfsPSetyaN79nFH4ITRVAtmSER3m8mxEUCLmBLq1?=
 =?us-ascii?Q?8sVFuMhXICBjLYCbD3JI95fJwa+NwCLerjszBMyECmhbuwvWi8shJuQAGIf4?=
 =?us-ascii?Q?AQA69y4JgYbotwkvsU9tOvEG0mQ3cgzhox1vh5cNSpDYxBbtuupWXsAnpmxk?=
 =?us-ascii?Q?wx7xKJyCjEO7HDcyqgxdSLE0taaVtoV1nP7Ee6tmpZqdqa4HysgUX2KmTqK6?=
 =?us-ascii?Q?H+eggODZ5oabTDSYSelfJd8gVkCnSW8p5k/6ljFGdJ50dkV2xbvo1/cUEuPO?=
 =?us-ascii?Q?7vP8V8iudf0gxiN42v6NtKSAyKMaR9889XqLfvIycpPpuOnWqE7KhxJqYzSm?=
 =?us-ascii?Q?jQ8UGLa5RACjZYyhMhvzlF6b+9H2ItNs227KdrcEoPtTOlPfd+JXHBA/4CDn?=
 =?us-ascii?Q?pYOsqAk7oa7wrlZBAjoSThxkXiwR8vfchwX2QsDzSzy09qhvuexLYbmjRJWa?=
 =?us-ascii?Q?9SDnBKjprbL5NAH8tCLwGWvopQVYh3k+NbarFiLIFUXb7DPlcFYJC9ChXlke?=
 =?us-ascii?Q?l5HmPcRicyANpHrkkR0dX6TigGjLOfIciCtH2ECvl14gSpyfODa3mfUjvE7g?=
 =?us-ascii?Q?15P6qSFhtBnMHPqJtmCiUdNUd73Z2bmcKP8npwnZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4fb180-a3eb-43f0-385b-08db6daffbe5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 14:51:21.8821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11cL2uOGGwbX3yRYWQlVOs4tBV3pKU01jMlGKlohY8+lzQuKwRE1XB4Yltr/js59gpGowfvRYWObOHZjkozzwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6668
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

ira.weiny@ wrote:
> I'm submitting these on behalf of Navneet.  There was a round of
> internal discussion which left a few questions but we want to get the
> public discussion going.  A first public preview was posted by Dan.[1]

Apologies for not being clear and marking these appropriately.  I
intended these to be RFC to get the discussion moving forward.  I somewhat
rushed the submission.  Depending on where the comments in this submission
go I'll try and make a better determination if the next submission is RFC
or can be a proper V1.  (Although b4 will mark them v2...  I'll have to
deal with that.)

Ira

> 
> The series has been rebased on the type-2 work posted from Dan.[2]  As
> discussed in the community call, not all of that series is required for
> these patches.  This will get rebased on the subset of those patches he
> is targeting for 6.5.  The series was tested using Fan Ni's Qemu DCD
> series.[3]
> 
> [cover letter]
> 
> A Dynamic Capacity Device (DCD) (CXL 3.0 spec 9.13.3) is a CXL memory
> device that implements dynamic capacity.  Dynamic capacity feature
> allows memory capacity to change dynamically, without the need for
> resetting the device.
> 
> Provide initial patches to enable DCD on non interleaving regions.
> Details:
> 
> - Get the dynamic capacity region information from cxl device and add
>   the advertised DC memory to driver managed resources
> - Get the device dynamic capacity extent list from the device and
>   maintain it in the host and add the preallocated memory to the host
> - Dynamic capacity region support
> - DCD region provisioning via Dax
> - Dynamic capacity event records
>         a. Add capacity Events
> 	b. Release capacity events
> 	c. Add the memory to the host dc region
> 	d. Release the memory from the host dc region
> - Trace Dynamic Capacity events
> - Send add capacity response to device
> - Send release dynamic capacity to device
> 
> Cc: Navneet Singh <navneet.singh@intel.com>
> Cc: Fan Ni <fan.ni@samsung.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> 
> [1] https://lore.kernel.org/all/64326437c1496_934b2949f@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> [2] https://lore.kernel.org/all/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/
> [3] https://lore.kernel.org/all/6483946e8152f_f1132294a2@iweiny-mobl.notmuch/
> 
> ---
> Navneet Singh (5):
>       cxl/mem : Read Dynamic capacity configuration from the device
>       cxl/region: Add dynamic capacity cxl region support.
>       cxl/mem : Expose dynamic capacity configuration to userspace
>       cxl/mem: Add support to handle DCD add and release capacity events.
>       cxl/mem: Trace Dynamic capacity Event Record
> 
>  drivers/cxl/Kconfig       |  11 +
>  drivers/cxl/core/core.h   |   7 +
>  drivers/cxl/core/hdm.c    | 234 ++++++++++++++++++--
>  drivers/cxl/core/mbox.c   | 540 +++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/memdev.c |  72 +++++++
>  drivers/cxl/core/port.c   |  18 ++
>  drivers/cxl/core/region.c | 337 ++++++++++++++++++++++++++++-
>  drivers/cxl/core/trace.h  |  68 +++++-
>  drivers/cxl/cxl.h         |  32 ++-
>  drivers/cxl/cxlmem.h      | 146 ++++++++++++-
>  drivers/cxl/pci.c         |  14 +-
>  drivers/dax/bus.c         |  11 +-
>  drivers/dax/bus.h         |   5 +-
>  drivers/dax/cxl.c         |   4 +
>  14 files changed, 1453 insertions(+), 46 deletions(-)
> ---
> base-commit: 034a16d0165be3e092d60685be7b1b05e6f3059b
> change-id: 20230604-dcd-type2-upstream-0cd15f6216fd
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>
> 


