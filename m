Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C934C00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 22:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbiHEWhI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 18:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiHEWhH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 18:37:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DABD1ADA6
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 15:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659739024; x=1691275024;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n82CzOCcvtK4J1HLLn12503pOTXb+6+dYd6x3YGm+dM=;
  b=ToU6QyQnk+2qDClfC/+abFUnpzMXAbu7Oh+VlPnPFVKxfGAQFJbeg8pT
   AWQLCzKFKRAwxGKh2yJmmrxRn+ebeLfF0K3GIBvKee4i5j3EWhZaP0dFc
   kP+y5gf9xboUULH2lvwOPJo5vqjkP1L8+K402dMjS+VrjQac3PREFgtzm
   x3iBcAugofD9smuMeu8qqUWkBqqX/y8V/lr08EuwSbFRm2ckU1719YO2C
   Dm8Ls8PrJasz2ez3VoQJ7A0STU/ZgtU6MBmYhe9eAHJ7YZXcmzoCeK+Ih
   m8dl2gqkYbdS3n1WiALCOvpYkWv0xMaW4AMRbvY2ZRIQYYT6E8p3YGMcE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="354305697"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="354305697"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 15:37:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="607278059"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga007.fm.intel.com with ESMTP; 05 Aug 2022 15:37:03 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 15:37:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 15:37:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 5 Aug 2022 15:37:02 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 5 Aug 2022 15:37:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kH4elarsJjHIO03GRAX7DiZvTg0qo61ABuUmldT/c6DKxiZGwLTGQjbXnwl7uscAczSosJ6oO2JBQLpA4Wi/KR+VHIo5X3nc6S5yZOQf2wwZyrpaUI+teuTUgS0gTK3KBnWuZVg7PA/CeAXVUYam2wqp0XOkYlwDGqVMImxCGs67+EvV18IHsHY/NSBgFQqPZWYC5Wzpis1R/6Dvg15mIZB5NkL4+yJCrHTJgMSWiljQKw2Lftit+iI/91dqgQ1EUMEF73ggPhNUZE9gP5oQJKXZWE8ivT0jja7XCKStWsJ4hM1DCA7nfVl8RU0PMAQv729JZ+B03nxNtJIZJ9qiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOR1imMOx8kUafnnJpYyb7A7hI1Vv1dVKrGEYBYebqs=;
 b=n2xkDAseG78Qd+WqRGONjOEfFWbixnaRB/cOJHOcbhZfbHrglDNSzaKvb3o08lAXIdVGsQt6ebB8UbMAGAbiMeyAw0wp7LrPXcPfFdxb5GCXsCdGWA0PTl0Ool6QGDyu53810T4spIjnOqF5HkzD03BijS5hl4achmUNn6jmRhXT7ibMtQZ+c8BEkZp2PVcJGouqx+bOjLn06xqTQT2lU1WZAfIZEXUkgU7k2+I9ENO/UAFgWaBpMPkzOqjy51Ny3xBVFse1+2ohGeBsWHoKJW2E3kGmRW9sr8Mns+uZenljgLta2ENHYz2MYad9YJ2vxXt4d2IjimAH5oH05l2hVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BN8PR11MB3713.namprd11.prod.outlook.com (2603:10b6:408:8e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.15; Fri, 5 Aug 2022 22:36:58 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058%4]) with mapi id 15.20.5504.015; Fri, 5 Aug 2022
 22:36:58 +0000
Date:   Fri, 5 Aug 2022 15:36:53 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH] cxl/hdm: Fix skip allocations vs multiple pmem
 allocations
Message-ID: <Yu2bhYYdfQtkQBDS@iweiny-desk3>
References: <165973754730.1558392.15466392461645857658.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165973754730.1558392.15466392461645857658.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::37) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 485d8e13-d42a-43e9-4c18-08da773301a0
X-MS-TrafficTypeDiagnostic: BN8PR11MB3713:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUQdepa3qa4XGAFdL/MWbimxURLEXLR8wBE7SOQhArbh8fkWHXXL/cEzkRhLFe7dvWtPI57R57YbzAPxjGD2Qr1rouuxxN3hzJ+MRlKTWBcyMvRrdtj6iEzTfURWhuSLibrqsGgVs+16ZDHZpzmAvfVUU6KKIr9uDXDxrOTRKHleak2IQC/snCTp0GZDCIUQ0fuAOG29Tr0dl0RfCVTqtLghqYcUhYcg50BG3cmxDr3ymf8yzv1QsFAnIRiOpXOAVPCv6/eIR8oMI04LAhNw9iQC3aKBizBwDk8qIn/kzMQUrIjw5hSI5iJsQHuCmCYivRg1Jg/DGg03YBe8O495++nAQkMEqN63n1AC0wZqFl7286iPj9AWxkJoE7xlwNHiFSkgqv04pE/9tdTDW23U4lEMME6DGuOScF//Rq+SD4Dl8MTF9jxJQ3dVobQngnsVBL23vTEIMCvZkFk3EvF+xLtMdWKeQQwFAAhMoeCQWG9mbvoOBBa+BtDsjOcSEFZTjZUF2OIrT3TWOVFVJ3MccHuAzSHZg7osIk5O+/HGOil517AYtLE2leEWdeYhOoExtOgQ36s7GMl/bhxKj5HSvW+QOPkYMn30Y2PU40QP7t0Dp2UOmUF57a9ZlulZxQgdRJm8DFO6vChoTMlkCMpED+orBw46+zSIL+a0an/KU8ySClLv7VzNK40YLm/7Bz+9cT9qUqcEui2CYmUveDVam1JUmhfeJMQFW2aHheWAjHQb3bSuHjbcBka6Rdt6kKAc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(396003)(346002)(39860400002)(366004)(136003)(83380400001)(186003)(82960400001)(26005)(8676002)(107886003)(66556008)(66946007)(316002)(9686003)(6636002)(4326008)(41300700001)(6862004)(6506007)(66476007)(8936002)(5660300002)(44832011)(86362001)(478600001)(2906002)(6486002)(33716001)(6666004)(6512007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xVjalrrX4cIHHEHailQC8fXD1jca98d2q5iSYG7esUp6cSWDCPFwHIh5dJ/f?=
 =?us-ascii?Q?eYjW1DH9e6gbGvNdnoV8U3+7ZceQDyP2X5Q8MfuUrQecGEhMSqvLp3VtA5LN?=
 =?us-ascii?Q?/OVvgOMbw6cc2npfg6jDqf8PbR+xSnRZLyAyRbxV+kwRyH7yA7Q7+YUkvSPF?=
 =?us-ascii?Q?77q6s4JRMQ7eIK0FQkh/2qfG3ExnXIPl8QZ5H3qN+aUv4UNS6x2AQq8tr8DU?=
 =?us-ascii?Q?gonGTFDrWfxHfXKBhCOuDpXZg6NtdIJVxif6rBdu5WZ1Zlv+wub9qk9/XA3Z?=
 =?us-ascii?Q?W8BzXf/Yi8/gmGyeyChJJy0+YQVKRA6k8AK6gnUxRhylfoHQA/V+l9gEEagO?=
 =?us-ascii?Q?dobteethIs+AgJNZ6TdbGSPjJ2lDXEkzcGPsCWC5s9/ACtb2JNrlt8SqLsxR?=
 =?us-ascii?Q?tsWIfeS1b2Xh3xIYjBBVQmASUj+3ofF4zaGA/7W/7FTMNbZZOsv8ETIvV3CA?=
 =?us-ascii?Q?2/w8gnjn5QuA0bf2oB5xpDXbjkjOU2ipAhPZ/GAh/oEUwufs/ZCHMSCmsKcV?=
 =?us-ascii?Q?gpuQgFV6s7zzNS24nvS6Hp4af1YkcF2SE1M8u7cUXN0v3eTA73Ktbp9SE1iB?=
 =?us-ascii?Q?Vy7gYc0Ti7NidwI6o9i6JncXJQ8HROf6vtldFVQSpi2liXF9OtgljVAh3wIw?=
 =?us-ascii?Q?414SxQChP9IWaM+e+Z4Or9Fg/CDVcSnxD0Vbz+ZFdddFxMvr4cwEjBlPQ07T?=
 =?us-ascii?Q?fZmXrFAjM6ShAmHt0RNFNwBMKafVPtgczalL1S66ZCwRzNLdDp+iwYRkJeL0?=
 =?us-ascii?Q?JqdlmEliHZZsEx26KDgdtsMCU2c0uIVVok4nYZqdsOg1hSoLuQLBK78YgdI9?=
 =?us-ascii?Q?UQE0r29sCSSszx3f8tyeVz6cgzOaUIS/GNqtTy++9OzR1y+vRbXgQR/VRnR5?=
 =?us-ascii?Q?wT/loKMXBgmNyHNOX0I+hwu+UCeM/61SLsWE9SUGPZlkCY9j/7BCPIwjmzWa?=
 =?us-ascii?Q?oa7L98HA+YActdtlWpL/HxAFeirCtbwHy0ne/OawP37MoB+LUPEbIk40LLqR?=
 =?us-ascii?Q?7WGsbkOtbirmmZC6sJ0Qw1z4WRE0HepKbF4icrE0hc2dlIJU9jUxmr69mn+8?=
 =?us-ascii?Q?q9diM2SKXwTfoG8GzVdvDG8rBjfvaoWC9QXhmu8wu/SELaGsrgXlezQgnqZ0?=
 =?us-ascii?Q?DLEOK3IrgcZp/HWCQiP9S3hbIts3TlocKIZhgORrZxJ2UhHzMg6rJkkLXHfv?=
 =?us-ascii?Q?n47K96yNBu2hhmeqenrPpk/243s4jFR3la/b4VtumeA5502xtsXzvbZFojBV?=
 =?us-ascii?Q?m9peSjhCOVHe+sDsAwxl+/gWAZXFO/qCneGUFcU/wo1ZIoMw/mOFDFF2la59?=
 =?us-ascii?Q?YRHr+ecwj+A69GVamDaPUIV+bezpG8hWtkJt6Id3HDinBd/YFzvyGPuvJy2R?=
 =?us-ascii?Q?6vs6ZlqyMe8/9MhlUOH7pFt4OlZOkUkWlnOfr2xnceDpt9HMK+k3ACA2+JeX?=
 =?us-ascii?Q?jnd6I4jNgg/geCTUS3kuE0fh8UnrAq8tQxNcn1pg0i/lUb6B8KjH1t0ddfhL?=
 =?us-ascii?Q?S3duiuSFvcc7Gfyi5OKxAQSUnk6n0RUSUUstHMyZUTgcFheFZySnpGcaoFyo?=
 =?us-ascii?Q?HHiqg1SYtXinn2fr6tKMIljWIsXT+9Ff6uy1ezpI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 485d8e13-d42a-43e9-4c18-08da773301a0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 22:36:58.2541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxuQePOS0r94yfJ7ju/gNOmlJTE54cnvWef5oXMTBBYd6HrbOXze9/SMFHXmIb8QoFD+UKoGEOdncg5CP4nqHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3713
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Aug 05, 2022 at 03:12:27PM -0700, Dan Williams wrote:
> Vishal notes that when attempting to define a second pmem region on a
> device the DPA allocation fails with a message of the form:
> 
>     decoder11.1: failed to reserve skipped space
> 
> Recall that the skip setting is used when there is a pmem allocation in
> the presence of free ram DPA space. The first pmem allocation skips over
> the free ram and subsequent pmem allocations do not require a skip. The
> bug is that a skip is still attempted and the DPA reservation code
> flags the double skip allocation conflict.
> 
> Fixes: cf880423b6a0 ("cxl/hdm: Add support for allocating DPA to an endpoint decoder")
> Reported-by: Vishal Verma <vishal.l.verma@intel.com>
> Tested-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/cxl/core/hdm.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e096f74e19df..d1d2caea5c62 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -445,7 +445,16 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  		start = free_pmem_start;
>  		avail = cxlds->pmem_res.end - start + 1;
>  		skip_start = free_ram_start;
> -		skip_end = start - 1;
> +
> +		/*
> +		 * If some pmem is already allocated, then that allocation
> +		 * already handled the skip.
> +		 */
> +		if (cxlds->pmem_res.child &&
> +		    skip_start == cxlds->pmem_res.child->start)
> +			skip_end = skip_start - 1;
> +		else
> +			skip_end = start - 1;
>  		skip = skip_end - skip_start + 1;
>  	} else {
>  		dev_dbg(dev, "mode not set\n");
> 
