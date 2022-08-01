Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69225C3F6B0
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 19:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiHATMN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbiHATLw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 15:11:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019304E637;
        Mon,  1 Aug 2022 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659380846; x=1690916846;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kG74WahF5FuVl+8PCVKwcj1nJ2/JGNwYRqyhQbbY4+k=;
  b=W0yBSObnX+J17F/4DsfXb8Cp8YF5SzhMM4U7EliT364YfM8lNVI0r+MV
   cf6iuJ7Wlw7Q62USPZVIJOyU/qJ3YclEAW5MTxvcF5xfTPSZS84s+GVEO
   IafT4ug0NAmXEHBLaCMfViWr2ISyzCX5BPgN9NtYSG0QDya6Cno9g2etU
   EUsMlmNb45zhtGYzAOEzKV8nnYaC9GwsyDDI9QAt/AyU7U5Xam1NMNQKm
   Qp3Wshga//gdidRlY4CIHdre29VlEYJEka5OlvRpfRGTWhcrq/RTjUq3R
   1de3HmJMYDeZzioSpeyO/KB8l06UxGhyatBQISC1F61CPTr9clAk5VsEm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="269606814"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="269606814"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:07:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="670152559"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 01 Aug 2022 12:07:19 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 12:07:19 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 12:07:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 12:07:18 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 12:07:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF1WZfoQlv92a8zcg3vfgIVS34/3H1uS4df9gPFYzkIWgjjKBBmw/LW+JnvEIUkGwUFaP9ZgcZ7zVOugc5pcff3gz8NV2OmiPR5YqHTbk699NIA0+/mvng5mOAMYZb3WPsCu7EkbxLHYTvQo5YfNr8FxbXMr9txY0R+KQR8MK4TgKijCwFDwtznvc+aO3/J55whqivMfQ+88JXMRDZ2tsNxtTghiR5McFfaJVdal3hqL9yPD3lA06Qj34ZYG8iOzB7w43O+IdmpfxP56vRVZ6ttl1wnuBDDp2ptoFo0qCctAY4sU/6oJvomHjo/CwPoO2SfOd9zx75rXI9tNgUNHzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cjk06sNNCY215y5oOg9ml5oi3I3xZRxC4sKPZ+KVszw=;
 b=DFivzFL8O5nGi0ihR3Jgad6mGcK9iNHNAFBKTjvGK1vOyPO3ff+qsUC1C+kQsC5tQUXlAbE2cDnm7cUDFm2TtAO7ezaISAupqkSOmxLXFTTvrs0SZaUpuL2LOXTIAuyR4oNRmAfLe+tV23u4tLTobCZgS4qcD93rWPAND3wl8HdyPrhvNJSG06XJP+EhH8CASp5tXSPE17Mvd05yx/Zg9F/B89JxbsvKLbDfeiMClN8AJv/muM3J/gtsuY+3ljtrx1tf8FnZ4iGFyn01DZ3AaRgVuyMMYXzFLqjEbZhuRdR0ipbe3Syuj2sg/LBt9d7C5JUKTv1oRl2Fhwl7TFjuSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB3727.namprd11.prod.outlook.com
 (2603:10b6:208:f0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 19:07:16 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 19:07:16 +0000
Date:   Mon, 1 Aug 2022 12:07:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 1/3] cxl/region: uninitialized variable in alloc_hpa()
Message-ID: <62e824628507e_b0752943b@dwillia2-xfh.jf.intel.com.notmuch>
References: <Yueor88I/DkVSOtL@kili>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yueor88I/DkVSOtL@kili>
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc96c9b6-05c3-40e3-92ec-08da73f10cb9
X-MS-TrafficTypeDiagnostic: MN2PR11MB3727:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kI+m8RNZlSbOZF/ruOKJ7SasnH3eGtd4kKLz4MEDYAPL0irjzLR0WmwRVdKy+h5rUVVavuYKDmhf99BabBO2jJbvwzsjLfy+7eyj6Gq4SF8e/ahGqfhDD10dHlTZ1RWC51BYUxU0d0JGnu+jVSKQubzGPSadzxJ11IBozCee6+O78NobJTGptkxJuX7ChiJQSgt+I7FaTd4XnAAHCoPw35GyutzNdjEx3bQ+RPI88EVOTU7fNCxDiP7N/jqukhjFRHHrBvtQT9Ki+TxE33VrZDY0Qe71mFxhDiqbDwlbbeZ2eUmwTxypr6ywpHQFRS1BUjWviBEW+mApSZr7EE8vQmpeYj7H0O6NDAtmuo44eMy5/UyfH0Vh9s8BakM4VlIzzKX5MRSHtzPXf9qf739tHrZ4O4UuCJPowDyU/4CkC5jVBDRVuRDmb3hAS4jVfdGOocmioylDiPIQnx/67kwQ+TLHFSc4KpxJg+/tOY1t/i7P00Pd6HKJFAmYGEB/GvDzmBPISY4N5Z8aoyAWb6el7CdPm8NdTNlcktuvDCzt5UBPx6e3gHlfUl1CIyBg5Gj96xJps4b0Rq4v8pAziDPccWY2EaQfCc3Fujj2K+ywRnrLvqttnEluda99DCGH0RNkzmIIyaaM0q+xgZm5pQTRjtsFJOBAgfQdSP4pKldE3pw0mjq/No5uJDcTvipsATjtCEffdyOv6AbFywnjylMnwhu4Lz7M+RKNJsF/bjEswElBNx9boRJx35azUBu0vXDR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(136003)(366004)(376002)(2906002)(38100700002)(82960400001)(83380400001)(54906003)(8936002)(5660300002)(110136005)(6506007)(316002)(66476007)(6512007)(66946007)(186003)(26005)(66556008)(8676002)(4326008)(478600001)(6486002)(86362001)(4744005)(9686003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qUiZeNcLL3Mjk5R1wFYBw2OxDvKJfIoSe0F3U6P5e2CZAXkGKX5BKwzGD77g?=
 =?us-ascii?Q?qNFccUijf4Pdt16Zz13DkWLypuxlvzDOD4vtW5zLzX4Ml+mMxVL6ex/JYHDE?=
 =?us-ascii?Q?QM9VKH0FSxIyVH072rVIhe72H4lyak3xqYOoYhUEulQ+PVMGue/XDV1RVHr8?=
 =?us-ascii?Q?AwsYWapPrdeAheg+wMxsWpZYE/2ugki6/Xf93TeDkM1Ob+QqsVvs2mn1D2xW?=
 =?us-ascii?Q?OPRjT9kO00BQh3lSmumcgL9xegvUNDM99fomT6E9j28qCXxekU5XFe00Zo96?=
 =?us-ascii?Q?yYcDn3pxQImd0qTz0DFArfoAvFn0WE6Ut3JCCGeZ978d5AUD1D5Kf0l+W1Hh?=
 =?us-ascii?Q?5OYfl/RxgC2ptMS0qGQ86OZ+VRVa0AQtwlBx1sVpCKjXGxJ4CaZgia9dDnKa?=
 =?us-ascii?Q?NrcdNGJi8MYkoQBH9prMM0vIl24lXwV93J5yRAuq8O+xc4rmoFJSa7VW7vAO?=
 =?us-ascii?Q?Z/D/5q3wuXD12GOmObktDEuK7w89rkaMuQhcLIcqrb8FAMEDpETSrk0YCkXR?=
 =?us-ascii?Q?BX8hT4Bw+qZKKfxXmAHbhIxqazlS+/KjtmQCe1rmYiZ8FrZqXcOKBNswhnN/?=
 =?us-ascii?Q?3IWUR3K33tQ5W5sIwmlQu3AEQ3mEvXkOEBONLXtpKl3eoViYtBQTeWFshqhB?=
 =?us-ascii?Q?eGtE8DRjHGrcqRoXqmaGohMlRaVENDILwkU43rM2bLxRKUMbN3o80pcS8AIN?=
 =?us-ascii?Q?dTs4+h8/PzJJG8SE91IxlgQN4vYzf7KtT6BeLyJCzr0vFkyqDvGUwy0t7yWi?=
 =?us-ascii?Q?IhIM+IL2U3XFUVeexz+SsnlqSm81KH7lHJAtq9cz/wqs2u9l3/U60jyXSzOt?=
 =?us-ascii?Q?xTjeDK7mArjc1uSqxNoWeNT4mGCoX2I/TwOQIoTQnWzGxKzxT1g+kh7LOHl8?=
 =?us-ascii?Q?gHu+fzaqVSgY+e6XajLSU884Q8CIQuN/7DPMNGp2rfDbcdvLjtsawNduvJ+B?=
 =?us-ascii?Q?mgaATP5FPdMYNwbzoqya+cW/DEXwwaXpPs7+f9ek/30WlcXyFJMIXCkUZC9n?=
 =?us-ascii?Q?FZn7Ydd/4AnfRb7jpO9k6+aptvVVgfxAlZ/Mt+42UV7bwERyubzVxTg5l8+Z?=
 =?us-ascii?Q?EHHt74x4XmGElPnlHcd3K2jD652qthDcmzqf44wei1m9wi+lwFd3ik4CUz/p?=
 =?us-ascii?Q?krc/uyjzUG4JPfkDECPq1IZI+sfqB6Wx4j2Lb1gCRuMh14/1/PbNPqdjEpgw?=
 =?us-ascii?Q?9ERqtqvvg6gZ8Rk/dAA9M2W7D0CuMNdti4p1ITsAtvw8WmTgW2Pp0m1TTPCO?=
 =?us-ascii?Q?8qi7mJGvNzjaYkQQy6UNR9jPKl1qJKYgoEHUvTN4b/kGimOGb9pWrzJaEniP?=
 =?us-ascii?Q?iCRBQqKZit4PEtP+PMujMYNn29JhvFfMsMomFPu6THhkl2Hvyu10d2kSsKOI?=
 =?us-ascii?Q?Mf4unrz2v5rgs6lcCjM3lvdoCV2vGwZvXOBDRgPEH8H/3MSL3LTpPnLo0WQi?=
 =?us-ascii?Q?JIvFSs88tSyVc8DzXeD5SZO8mkWfseWAAGS0ABwHcQhyqUlbenTnT2kqaP3z?=
 =?us-ascii?Q?3c3vH0KT3TziLi8vKqfLT1HwZu1rX6UTL+71az9KohrFgOVSQATKNIKwVlik?=
 =?us-ascii?Q?vkx72Z8UpOw0pDl8YMsTbr2/E6NkdTJO3st8iPrpAmwaqMR3+R/PvD7WJD9Q?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc96c9b6-05c3-40e3-92ec-08da73f10cb9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 19:07:16.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOjc/6xeJEHbkk6uqwLvzcWJHfr/rTrddvEU20Qi6u82s3lLBrprR68FsAqtbF+undzjjKd/S6tzFMPuikQdyCEvzNN0JJ/rEty2bj7RZAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3727
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Carpenter wrote:
> This should check "p->res" instead of "res" (which is uninitialized).
> 
> Fixes: 23a22cd1c98b ("cxl/region: Allocate HPA capacity to regions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index dc71ec457608..c80932bca667 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -454,7 +454,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  	lockdep_assert_held_write(&cxl_region_rwsem);
>  
>  	/* Nothing to do... */
> -	if (p->res && resource_size(res) == size)
> +	if (p->res && resource_size(p->res) == size)

Yup, looks good. Surprised this was not caught by my local compiler, or
any of the compile-test robots.
