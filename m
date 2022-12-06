Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D425C3A5A7
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 06:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiLFGny (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 01:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLFGnx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 01:43:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F50186D6
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 22:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670309033; x=1701845033;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DJ0lZPEuRVG+ycSZw/4siZg8AUT7qj1EqpfIewF+PLc=;
  b=TVBhf1dsj/pFVuNWVTr7R6tAFuPUCMel1YMIbmE1jO3ukli8F9h7q0Vk
   V9gGsaIZyVY3IM1XRGV7hkqG1d90etWjCAk6oPkfJRMlsOJVBvP6RXdDd
   ec87IRmmi8sems1HhNsxjJ3PY5/1d4kRaySSrAyh5yw9HqlTpobNZVRZa
   Nntl5NRH/40GD9GYsthF3pZjRZYtfLQLp/XAveM+Sf5d1kcdaZc3SmrX+
   +4SxQNSzFgoq43FHO5TDA3IK8Epl6k0pR1LiYnQXIKft0GxxE8q3x5gc2
   aVFzyVnQPsLwyMJXqthNwSgWfb8n1/aeDlRMkmIEVJxFBGPaWl4jFT4JB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="343569834"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="343569834"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 22:43:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="752514396"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="752514396"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2022 22:43:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 22:43:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 22:43:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 22:43:52 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 22:43:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABKZc+67fpvaZi1wpliOhQJZMv9xwZsU5KWZzrYeSYYUtfxMmwHI9BfucJLzYpXvfy400oYX9xwc/lNqWZQ4e+hCOStKXf7pPnWUIr//YRcMon2j75nSDDYbNjvj/yy9XH9aUNTK5jgeoKLSUk5tBsGCbBNKyVpxeU+O6KolFQ/ipJTjdDa3dA4wEPz60Iswa1mcrXVWFbrxFGIxHUUr62AToc4ZE7yM+6lb5Mue5IDsKd+EU2BdZHP6JBrmt9rNet2b7jsHG9l/hlTJKEhPvSIUvZVPOaxub4QeQN2MkRI5V/kn0L0XqbA/r1WE7+jtyaGznCETE6x/pz9o/dRi7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcIZfJhZAR4bS6OXjAfOw+ZwlvrNg8LRN7jDAEcaK2o=;
 b=ab4tfjraUKSGhq4Cq7w/HmEWodvfXinzwAGQ+16AhAOdnclhqrpRO6mxGL3mMl3g/SmoXtBU8R6j944UZDKjA8AhZowtJIbGVVjYqtcZITSA2OFRvsfLQuDnLJ6uFQUrOwVzIdNQhG9ZzQI1lRJLQB94VhEQGAnll2k8T9fWLwhnYiKm1ky/gQ0IHvGomMVL0rSLcFJNlS1mm8WE/Ir+Rg0oA2QOuH8b0UWEeOYhLgTQjQTs+fzn24IFdKQXohblGyJaqVp1c0FXbUL1JC8kqM5uUl+gRCN8nPgTkb42znge9i7Lj1FqwEDc0Wl7h5YeuKJ6gsvAE0b2/2Lic1NFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Tue, 6 Dec
 2022 06:43:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 06:43:45 +0000
Date:   Mon, 5 Dec 2022 22:43:41 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/pci: Remove endian confusion
Message-ID: <Y47knR08oCyC+uxO@iweiny-desk3>
References: <167030092025.4045167.10651070153523351093.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167030092025.4045167.10651070153523351093.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR06CA0041.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfcba9c-dcdd-4be3-2e91-08dad75538b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHpdg1i28EGI0cNGbqnG/1amBCyqYyuQhAJFLSnUunGWoKQQ3OX4EdBzOoc8aDSIz2ot50YEEBaBbM0YHx1x+DAee1f2MHd0E987BaoE4+4H8fVTu4RQUreMpOlbVXOe0pX3/+589cQpQqiYY6IVh8sxmgGu+Lrt68ZBba1AP0Ys2L7bRV8BUN7SQo4S+nSvYrfZrQahDc/hOPRETNE3L6VkG5APJ56KNbxmkSbrCqOBfleSWo6rexhXbo3zsARDpgTwpouYImyeGN0Qf/4NAWY2KR2FJ3UDhU/nXpcm2XwBDHbuZl2at8pjFYm9bcZHMnjQTSARNg2EGoXYQ8Nhzj9RpmtyunqFYpJKC2kc8BDaVdigio35j7vYSLe4kNvqwaCnDIbStwTwkvnd69TmncMkpouMJbLt4rZDn5WUs0wffSuZZFCHHIznYDX19yJ6wPvnGfnoJDZw4c22oSe2DoAiwsBLAp3fr3Yp2s3egcXr8n5J4cWlAYA+cA1ocJaaikwR+sKrxPJn/9Yb+J22jLnBQ+p7dNUZezxCD24OkQ5n3hxA91aRFzJPD/yd0KWGd8aOgFGozJO6xT4q+Xy2cPb5flHhzSi0gE3uNNBdaAGAim/Qat1AwDF1e+/0w8qSbmNVKkz5oJ7GjssWEwKzmBXJR/EHM12q0yGn92dHxCTvzbwV2W5U1imQwd1jQ8Mo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199015)(54906003)(6636002)(316002)(107886003)(2906002)(66556008)(41300700001)(66946007)(6862004)(5660300002)(44832011)(8936002)(66476007)(6486002)(478600001)(8676002)(26005)(4326008)(6666004)(6512007)(9686003)(6506007)(86362001)(83380400001)(186003)(33716001)(38100700002)(82960400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7/b7EbXkBP0c4Be6YSjjnenlzgt3A4TOxGu0PxYpvI/tUzov/9KxULWh7GLm?=
 =?us-ascii?Q?NqXwPXdIhvYkt+Gy+a8wrK1Mg//9eHKICPnHanf7JgZKYhNGZKq+zeOGc4SQ?=
 =?us-ascii?Q?BYkFppG8m8GBMumjc6SCfnZ26aazAw7zairUb495GbZqiRxYw4wcP9kbWsRc?=
 =?us-ascii?Q?VZyXUUFTNzArcr1qIu9XVPFNFh8Y2vkV4+qmf7Z4aIeeU6cqxNkHFbORCKzu?=
 =?us-ascii?Q?zcw10sZnptmFB8HbhMoqSdkis8edcWS5o48KoynWqmaGtDpFrGjmXQeZqTlM?=
 =?us-ascii?Q?2YitCNINdw9NyoV3ZwRPCV8gisE8NXk/oiUHYDOsX16yzrcJFnpS5np7vrnq?=
 =?us-ascii?Q?rnUunr25SYZiwck1vxqLwdAfe8M8ixlHyZGUI+UAICqMJQXgbl+9AHWErie4?=
 =?us-ascii?Q?utZDLe57nczKnqSQxcxxoo80UO6Fa2G0hNZ+3LwutCI6J+Z1kWFqRj7Xkrpo?=
 =?us-ascii?Q?tzr5XNC+nF3RlCToZEgeg76UImg1+BrUyCwRes9GxmAwgM0o9m8gJhcK5isg?=
 =?us-ascii?Q?KzEJuzG1cE4KJKd9qlRNTaXVFIt8LVh3nvRnBQNipPI0yurHestbg2lJbtsB?=
 =?us-ascii?Q?pSq+glt5aYS57BRcZCjt29W1eu+4HeCOMWNQQ+JC2KBwgUm+BANzUjDrCRP8?=
 =?us-ascii?Q?sFdzNdQ+8Izj/F6Fa0qPuFEp67z9amR7lB4yq3z2jP+HKmufq9HB9aAN2dtw?=
 =?us-ascii?Q?ZRUpvYrm5E5ggAiJP1nEECVMy1J8P/4M4PMzhQaE7Ec9ic2PekKEE5aMHco4?=
 =?us-ascii?Q?IBCc6F9StiCIk0wbxozPZOpUoJEZnDd8WclzVppwpv8MwL3vndy3s0jOIGCm?=
 =?us-ascii?Q?klxmZ6ICRcHqvgOmBDsQpnrPNlukpu0st5BWeRz7UsPPHQGgsNbUdCqOF/jh?=
 =?us-ascii?Q?K05y7aPnZy6IEQHOGTj+PVrDPpqczdbLRffEhoI4TCypfOdOA0MlkWz+RuCQ?=
 =?us-ascii?Q?pCEebbjzZTpbeW/6HUyhJbugwYYtTz+x8+xsD+nEq9rbXNamvWjSzO2jevhz?=
 =?us-ascii?Q?nB59KVkAMpvFnUytK6vcSPvApVs5lVNpiAnILmD2g0mPR28UxirNdVPRovJi?=
 =?us-ascii?Q?F5LiaQLUVaz2pts62f1eY4utJh4SBrBHhULkIpxgSJNngNExQSYCzMnRh4Ym?=
 =?us-ascii?Q?sqX1UFPxp+YxjU69CeNc8V4YCOo/V3lGGMXy4F/zUjwaqtYHfjvr8oiBPAC8?=
 =?us-ascii?Q?O4GdKR9XhS/5cp90HghYPowxP8amiqZwmbdiufIY34BLE7sP9vbLpLtsN48A?=
 =?us-ascii?Q?IiLgyKOWi5Ln/nvk0oUY6Hw3ABr4rDztMQJ7Q18tWT2PKNObAlJOor9yOxUd?=
 =?us-ascii?Q?+oD9peUyfbfQ7a1XtC4tRie1j2tE7I61t1Zy/VL/Vhf9XGs91Qsge7Bxyjut?=
 =?us-ascii?Q?SdR65B5cA+ECgGWVV/+4i3/3wUAZtIrJNX9+JOEPfO/O46wNoUgYVfj5/pa2?=
 =?us-ascii?Q?kxoh75n8XIeqL0c97kXx5/lsIvsCejLu6etFTLYfwZMCaD6+9FSyvnUx3y4Z?=
 =?us-ascii?Q?rh41yuWMQxuUjHgEItc1IisZBX3kpoF0FEgFPvbYwbO/pO86l5k351OnNFwE?=
 =?us-ascii?Q?sddu+V4mNKaTNabNZC7E2if5oyGF0eB3gt6bzLW1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfcba9c-dcdd-4be3-2e91-08dad75538b9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 06:43:45.1761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rx1e70DczTgstSpAbmAX1hm83XqxGpuH0rgiKc3troA4AJKxBp9a7k5jaWOFO/dAaVk4tYjVLJP1gQpyz9xDew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Dec 05, 2022 at 08:28:40PM -0800, Dan Williams wrote:
> readl() already handles endian conversion. That's the main difference
> between readl() and __raw_readl(). This is benign on little-endian
> systems, but big endian systems will end up byte-swabbing twice.
> 
> Fixes: 2905cb5236cb ("cxl/pci: Add (hopeful) error handling support")
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/pci.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index cced4a0df3d1..33083a522fd1 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -548,15 +548,14 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>  		return false;
>  
>  	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
> -	status = le32_to_cpu((__force __le32)readl(addr));
> +	status = readl(addr);
>  	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
>  		return false;
>  
>  	/* If multiple errors, log header points to first error from ctrl reg */
>  	if (hweight32(status) > 1) {
>  		addr = cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
> -		fe = BIT(le32_to_cpu((__force __le32)readl(addr)) &
> -				     CXL_RAS_CAP_CONTROL_FE_MASK);
> +		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK, readl(addr)));
>  	} else {
>  		fe = status;
>  	}
> @@ -641,7 +640,7 @@ static void cxl_cor_error_detected(struct pci_dev *pdev)
>  		return;
>  
>  	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
> -	status = le32_to_cpu(readl(addr));
> +	status = readl(addr);
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>  		trace_cxl_aer_correctable_error(dev, status);
> 
