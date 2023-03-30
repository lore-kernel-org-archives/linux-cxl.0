Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E269C6FD1D
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 04:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjC3EVn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 00:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjC3EVm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 00:21:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D9A1723
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 21:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680150101; x=1711686101;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZNzxFeRlAJHhfYJV/z66KFIvgADtqTEruw/fItg4G1g=;
  b=hdCnrvJaFLZQoKjN7QgWJHOfBhY8KsdnpcGtmj4NmQ+w6zpDh6WHVicF
   i6BQnWcCxn4ovXtVu4E+bX0bemVSDCKNwOLWmIufIIf7UgNSMIUbmxdq7
   aZhAbq34nDlkMzo0IsmMU83HyoZek6YXm7ihatC+aZ9MHvhi+Tu4Hg+CI
   13+2Oe5tW/c+exT23DzuFLDR1/sxmrDAmUAiw9+unran2jAaQM0L4944P
   C3DQdDOSOaLLV9kHWg3V7co/TIztUaZdADpCB6Z9P/ugZgozmP/zfIb/z
   k07m3vrT13aZT1Bfyf9vljpxQJd3q49p3vXttzKWO1jZWPET250iLqhWp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="342675465"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="342675465"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 21:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="858752716"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="858752716"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 29 Mar 2023 21:21:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 21:21:37 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 21:21:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 21:21:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 21:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU+sgdcrYVgx8qJuLxOa8ALEYGigjXDJN1q5J9exM9ZdqDoJzGPdNIM+k8Oed7HdgPeO1T1tc/XhInZcUbh2YY9zVSFY+LJII75HDPptgMnL1PPTczwUoQ5iKjNgtOqx0zBTGXqwIeCvHiuR3WDzAn51I9o5CAdjT/HeGVGinb3oJrm1iZ/4Wr/YJ3Tu+FrrIOsmgn8oVn3njkzOdeYkxWtNK1C3NQSWdOwZE67QoCk7p66+te6ChI8QI+wilSNnY6S9ty0urZLSeook7tpNyNFNjS6aQ0MlnseeeJqwKB4SCdLlFROvpk+WfjR6WZq3gi9Lxa187LiBpcKTygGdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIsCpdD0fcGBmzxrWVpB0TcY7oO+T5k+Cp/ReyuRaNg=;
 b=IwPXaM1arWValDa5BFRv7fesnMoVxeYAIyqEpSi2eEZfQSX3ahlIuSt49epN9F1nnYjXWcbDVNRsXTDbspXDxB8NHSw8VnKC84Z4CDHfhu1ln1bm8JOpDn5jikphHITAtUE+XNKzMDkdeludOQ1x2ZdDTQYRdrybQzyPyobvo0ZnHtPIHbRAqP6j2vdabEPQHXv2H9zp5yBQkKwhYD1ncfYkf7o82JVU6nmHVqtCJUy6gdJQgFsPi8qZbXrSWWNJnKxLKxWR/592Jg73jbHanBVdAtePqIlcmRGs6ZD7c7h9oQT5S9R2qU9RBH71fBMA1wMul021hOd9XJTT+hJXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7835.namprd11.prod.outlook.com (2603:10b6:8:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 04:21:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%4]) with mapi id 15.20.6254.021; Thu, 30 Mar 2023
 04:21:28 +0000
Date:   Wed, 29 Mar 2023 21:21:25 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
Message-ID: <64250e45bea49_c722294c2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
 <ZCRhhUDcmypVKu0X@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCRhhUDcmypVKu0X@memverge.com>
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd42269-14d2-49b0-8b8a-08db30d63b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYPhDTXoxMzX0JyAIq/Owe+YlS5RXmRCgFlVb9T0EOsj+QtA1vQ0SXHrK0SygBEHc0TzqP5gYQcmSs2mhJRiwzPfx7L//p9t27BZsdfFmm4UiUDkqYkM58zWcdkvf8Gx+klGoYj3o0mei5xPczMHm297X0Bb3uHXCPTF+HyLpCOpbg8qsgUYhqDDEkUUcMaaDU+XgcXGyR7ScZoFQeGXQk/LO7dCUJ+brlma8i7dFe3ZIEgRQcUTYYyaI7rPicg2GnvO4M+hCtyWBYCm+SywbowjaE4RVnmPJgm/2gpj8RHALMy7dgqvP77kefNRfkc8O6W7NB9eN+ILnCE+vBcALpsHG4PKqcLeLVY72fkFQnusojmyK46npmJV0gkVkiezkD9zO4o4TnHB/QYvWvSlL88ZkaD8v/cE0zynizRXLKBvXEUsfQYzWJFTquCt6fTxr8b7c+zsP9NUlFdGSke8TOLw83VGqKXqkZJyTDL5dkatgItzhmok4BiBMg2J0mtg6mOEEUQVp91mX2R86o+wtyJdEDtg6krqsesjwfEIVpeD6LkvLKFHSVzUXQh7saNT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199021)(186003)(478600001)(6666004)(107886003)(316002)(6512007)(110136005)(9686003)(6506007)(26005)(83380400001)(66476007)(38100700002)(86362001)(8936002)(5660300002)(6486002)(66556008)(4326008)(66946007)(8676002)(2906002)(82960400001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cOUx7VUqAFc0vpvvzQcPo2TzTZrmSZO8sXQtVDO8oBPewf96OojIVyY+ISOR?=
 =?us-ascii?Q?T6hp64OlAkHe6Z68VHDu3xlzY/R1i52zhq/1GF3yqxrnsyB0nr18zTt4hSZw?=
 =?us-ascii?Q?12pCNH5EpmKamk+4MLR/GCJFGrAoeXrTkfkDLLozOFP9PRJrK+ygGaZx7PAB?=
 =?us-ascii?Q?vlISLSAieDQmCeyeg9OCKVpnzQ1RnVe2D7sXwWnDlSTaYUdx/wfx5Ri8323+?=
 =?us-ascii?Q?9B6k/HFQhM4CyWyQOIufaOD045t8b7YNS4Nc7VyfFNrCd3FAlW7Ccn/8uPlH?=
 =?us-ascii?Q?0SqPvR0stJlEb/HQLdmKeEQoz+1spu8lvXHXl4VqSZpQrxn6KuHg11k0tH9k?=
 =?us-ascii?Q?oVq1TWDvgleuW3skyMqJtPDYu6BtDpZQUqd3GsCIGF5v6Yj5sC3NaNzUs5MI?=
 =?us-ascii?Q?Au3yBufKITMOpCbOWUOVBGXiFO6YxckTWzee90y5AEUduV/GcCIvDClnXifW?=
 =?us-ascii?Q?uDqRotAxx4TyBMAFY0/VFWweVPDlOl0/YgdBPNn00yuxJo0jHkk9K6J8Sccw?=
 =?us-ascii?Q?3bRgxodf+9UNo9WzEk3wk9LyEGb06hM0xh+VLnG8caV4JnPRk8nbFKv7gmYw?=
 =?us-ascii?Q?6Jmv9mChN/cR7VCqd39XaT8VH75wGB9/tMX+tfgrbyUYCW3vzM6TKIaq2M6F?=
 =?us-ascii?Q?VL6K8E8cAEqlgZksD5wthH86ftO/A6nIELYXqpBC/4kv6eWhnnRTe1SstG+I?=
 =?us-ascii?Q?S2lzIg7gkLo2WJxHn06P5vp60+P+Ys0uYk7cu+PauIFBEa0WQacrHULmY6l/?=
 =?us-ascii?Q?Xnv8sqfcQRPDdHfzvWXCSoWD2CAM1AzegjRyRbHxhohkM2w8/apke0RJEBne?=
 =?us-ascii?Q?U4OgmaGLnaJ+g5q0OfeheTlWXeNXuAf0A90PyTKnVLhGFKd6VM71gNae8PXQ?=
 =?us-ascii?Q?q9jcm0ppEz4PhwTOGN8QpOA3ILj6Xczk5/MfQyFRq3OiyY6zOi//9wzQ3ktw?=
 =?us-ascii?Q?oJwceApNLiRBBxBTH8fg2liQSLlbACCZJx+UWcLSBTxYbUnO0r4JE1XaIiSx?=
 =?us-ascii?Q?kPq19FLN/BfrSaQBI2rU3LUSPzB43A//5CzWP1IUSGav0OXAz8F+pzw8+dRW?=
 =?us-ascii?Q?42SErPAZZmYtlIttD3pv/lOuwH5mDztf0sz7xJ2TE2KDYZuJM6SKlZ8ONel4?=
 =?us-ascii?Q?6Ra4oPUgqe3JH2OAKnY/sSXzbocvA87CGPLlUlOLczBDfWjVTllZ9gpcBgtQ?=
 =?us-ascii?Q?KZyKBcuxsSPuAIOCckZcG5K7ypcqqRvS1RKDa0Ni429khVypUw2O3AaNiDmA?=
 =?us-ascii?Q?Q256VGIxCcSQ8pmUHTK/BIf7LaeOuvUy0VhkIqAwdQPjzaPPhCBd42C1/4pT?=
 =?us-ascii?Q?5hHYf3anAeGC7f3wLI99CZGRES8a+v8/esk98z2udkxX/7RDM5eMbY0KVWG2?=
 =?us-ascii?Q?0Qqf0rQryX4tR3lQOTjL73oE3CiLiso5xQ3RYnZY+f+XrA52/VJKRT/X7brm?=
 =?us-ascii?Q?N+jwvpVhmn4xs5MPB7GQLOzxjhfHoOYBbPglEULgictbiw8L/m/w91WG88HO?=
 =?us-ascii?Q?HW81K6GiagsaNRlT7G97+1FKYz9SOvA+RDFe2JaH3z1glHgTmrJ4GTkQJw+V?=
 =?us-ascii?Q?v5otLo38a+ilKX43XmIV1Gor10rH9AfcyVP3mPn4jzOh3D0Zw3W/0Kxr5X8O?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd42269-14d2-49b0-8b8a-08db30d63b71
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 04:21:28.3888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbOFyjRISJ9WVPNtSF0Od/zKEA2dVqWNGFaZBSgtrTFRUV16ieRTFyK4fMe0PjiwdhHmU1Yp8HF533/xctfw+S7WtRPKXSCTR3ILT+yWWHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7835
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price wrote:
[..]
> I have an example host where *dpa_base ends up being 0x0 here, and as a
> result later down the line the region fails to register with this:

First off, thanks for testing.

> [   21.974117] cxl_pci 0000:3f:00.0: mem0:decoder1.0 no CXL window for range 0x0:0x1fffffffff

So, this debug message is a statement about *HPA*, DPA is the device
local offset, it just so happens that in this case the HPA base and
DPA base are aligned.

[..]
> (full cxl log with bonus prints i added)
> [   21.607034] cxl_pci 0000:3f:00.0: No component registers (-19)
> [   21.641831] cxl_pci 0000:3f:00.0: DOE: [d80] failed to cache protocols : -5
> [   21.642866] cxl_pci 0000:3f:00.0: Failed to create MB object for MB @ d80
> [   21.643686] cxl_pci 0000:3f:00.0: Failed to request region 0x0000000000001fff-0x000000000010201e

I assume that this is the attempt to map the RAS component registers
given the driver load did not fail. Would be interested to see this
platform's /proc/iomem, but this is separate from the DPA mapping issue.
Perhaps this device tries to define the RAS capability with another
block that was already mapped?

> [   21.644371] cxl add_dpa_res: (0, 1fffffffff)
> [   21.645540] cxl add_dpa_res: (2000000000, 1fffffffff)

Ok, this device has a 128G ram region and no pmem.

> [   21.965692] cxl hdm dvsec range: (0, 1fffffffff)
> [   21.967045] cxl emulating decoders: dpa_base(0)   <-  *dpa_base

That's ok...

> [   21.967778] cxl_add_to_region: searching for root decoder with address range(0, 1fffffffff)

Now it switches to search for a CFMWS for the HPA that just to be
identity mapped to DPA by accident.

> [   21.972824] cxl match decoder: found root decoder, r1(1050000000, 304fffffff) r2(0, 1fffffffff)

I am assuming that this means the only CXL window defined for this
platform is 1050000000-304fffffff?

> [   21.974117] cxl_pci 0000:3f:00.0: mem0:decoder1.0 no CXL window for range 0x0:0x1fffffffff
> [   21.974905] cxl discover_region: failed to add to region: 0x0-0x1fffffffff

Driver is giving up for cause because either the BIOS failed to program
the range registers of the device correctly, or it failed to publish a
window for where the device is decoding.

> Ultimately having trouble deciding if this is something broken with
> bios, the setup_hdm_decoder code, or the discover_region code.  I'm not
> PCI guru, but we should expect the rdm dvsec range to be in the range of
> the root decoder window / CFMW:  r1(1050000000, 304fffffff)

Yes, either that or a CFWMS for 0-1fffffffff

> confirming this is the issue, i *forced* the dvsec range register to read
> out base+0x1050000000

Nice!

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 7328a2552411..6fc6df0f7b5a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -340,12 +344,16 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
>                 if (rc)
>                         return rc;
> 
>                 base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
> 
>                 info->dvsec_range[i] = (struct range) {
> -                       .start = base,
> -                       .end = base + size - 1
> +                       .start = 0x1050000000 + base,
> +                       .end = 0x1050000000 + base + size - 1
>                 };
> 
> 
> And this resulted in everything working "as one would expect"
> 
> [user@host0 ~]# ls /sys/bus/cxl/devices/
> dax_region0  decoder0.0  decoder1.0  endpoint1  mem0  region0  root0
> 
> [user@host0 ~]# numactl --hardware
> available: 2 nodes (0-1)
> node 1 cpus:
> node 1 size: 0 MB
> node 1 free: 0 MB
> node distances:
> node   0   1
>   0:  10  50
>   1:  255  10
> 
> [user@host0 ~]# echo online_movable > /sys/bus/node/devices/node1/memory33/state
> [user@host0 ~]# numactl --hardware
> available: 2 nodes (0-1)
> node 1 size: 2048 MB
> node 1 free: 2048 MB
> node distances:
> node   0   1
>   0:  10  50
>   1:  255  10
> 
> 
> Basically the question is:
> 
> Is the DVSEC Range Register expected to be programmed by bios, and are
> not being programmed correctly?

This debug experiment makes me think perhaps the *device* is at fault,
not the BIOS. Perhaps the device accepts writes to CXL_DVSEC_RANGE_BASE
to set up the decode as expected, but reads return 0? That's the only
way that I can see that forcing that offset results in successfully
talking to memory.

> Or is there something else missing here to correct for the CMFW base?
[..]
> If it's the former, then this patch set is gtg and i'm happy to add my
> Tested-by tag.  If it's the latter, can we hotfix it before release?

Yeah, FWIW, I don't see anything wrong from the kernel side, and would
be curious what the BIOS reports if it reads back what it wrote to the
CXL DVSEC range registers.
