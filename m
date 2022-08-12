Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C25AC25B06
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Aug 2022 00:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbiHLA7u (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Aug 2022 20:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiHLA7t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Aug 2022 20:59:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8230EA220A
        for <linux-cxl@vger.kernel.org>; Thu, 11 Aug 2022 17:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660265988; x=1691801988;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6pyOmm1dvU8zEyday+hE/8WXkuI6v2B0MdPIxUQmLuE=;
  b=bOFx1pLyMtzuV0oIAF43nXY8g/pbTNx5Rqj2yDIIWn9sTWq3lnv6muD9
   J+OcroiuQzop+wmnc3XTiAWHjazW0TlSdECEa7Uqyo9uGcI7I6ZQbNQzG
   CQ4PLhlbhSmo6QN+vDPnZcrMIF3Dszas1LGpsBCfdt68akBbjJUn9pR+B
   pS4qMQR5MNo8e9qJ7zmN5ByKHBUnmVuskNq2mV8uP1bfSBWxPMpnxTmxf
   8tyNapFMSgSih05SJGeRv5w5OdghqFEM8kdSsGFBm0ayeGhjWFJuaXiyV
   dmRPSoBoSujE1LQGVZQRAAshZGo1T85YH5yGP/1bCUWLyyHCUJoe5JX/8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="289064377"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="289064377"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 17:59:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="602355877"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 11 Aug 2022 17:59:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 17:59:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 17:59:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 17:59:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 11 Aug 2022 17:59:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xym/mgIZeuB3XcaZaOK5gDRM8I4BzMLtGyV0XZSb/0pXuvTvjSpgjQhLxFy9Oqu3p3sh8z39BF8bN33KEs7ACsdyy2Yx3RzV7K1Efa0GZS4hyfpZ03EzB/4HuiyODwIi6mBLFxR1izmw9NXeFR5RRZlzIoWafuT8OdF0I6hlpE4Fqng46fq8sp1CMyy06DtGK7cbV3DE0KCHok8ZpCyg/6WBcE0gwNYKJA4iCocadvtdmM1mAzTuEjJoup+nv56cNCQ9VN5dq/CjfsciIUsGiT3Bfc1aHkOiStyPcJv1ov+YNhqQ8b5BCTnTdP0INSycvbU7OG65oX6w7YmrrE/UJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oy5XBuv8qTIq0+XsKcXzw3GJgWxg43Ydxk6qcoGtxg=;
 b=WCmFhsogbjGrgOe1G0tWc3h1Ml6LkyIEvDJd+Kdcy+IHEbfUY5V5yQudJiRBryd1ABRkR6Vt8Tzu7J/E1cdH/u2Rw6zWYMtgkvf45I7Ix9ZwBPhbrjhoUUXdnxV8r8/Ry//Z3yltFf1LjYvhFGC7KALy/6eoxhdJGi3XOkECupTA0sZjON+ueqmFuibFqLC9Mmzl2Z//L9f6qM5G0vDrxzeAlCwvN+BtQZqygIoajlvedaZQvWEK5JU8OeAcOKiepFgrc3veOXLyjPIQCfrgP6+AxsODdDMhKly9/OxdzsKtwMfqa+tpNrqtVxvbS+Q+Jnj7FqNfpA/ORsBKmhjMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB4143.namprd11.prod.outlook.com
 (2603:10b6:208:137::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 12 Aug
 2022 00:59:20 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 00:59:19 +0000
Date:   Thu, 11 Aug 2022 17:59:17 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v2 1/3] cxl: Add check for result of interleave ways plus
 granularity combo
Message-ID: <62f5a5e58e37e_3ce68294f6@dwillia2-xfh.jf.intel.com.notmuch>
References: <166026184968.1454405.494690416353090765.stgit@djiang5-desk4.jf.intel.com>
 <166026221529.1454405.7141583168966440657.stgit@djiang5-desk4.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <166026221529.1454405.7141583168966440657.stgit@djiang5-desk4.jf.intel.com>
X-ClientProxiedBy: SJ0PR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:332::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad9cd4d2-a7de-47f9-b5e5-08da7bfde33f
X-MS-TrafficTypeDiagnostic: MN2PR11MB4143:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MuVYB7SOJkF+JGhYQwW0YV2WOUbDPGUrQ4pLrU7OREFyeNKKhpixdDV44Jr+G1SusBSI6/LX4mu92nqIiAYGXpT7Z7rVui5xrfLydp9e6QvIiSYGQYph7oV5HW/QnmsIMOfVzFCCw7+Y+6dPBrflwoeYo79cZT2VX0gJzuA7pz2+ewNURXag0XhunHUHDvg6txY+Twt+aTBYDDM39U/IkbLKuZE1S01P5SutzuD9exltS5NEjNiKSaqsEiX096GxeR+yCpAQTtY7nJs63DE7HaGy7hH/AW3oajccD5/a2WhFo/kwkrrY+zQRsPWdZcQqnMwcS0Cl7IFKA5Zuqbdbt97sNVlASMawVqthae2vvHMyXtNoiDbeZadow+oJhXAd7e+rJ0+9NpMMu9Ee0b57ZJcKHvD8pChBZ9f2YFQemwFLU+6/O+WYIVZj77F15Epj6VhSMXF1jLW7p/67BPWCB8yJbCi0lpNC5I5CjpVowoY1tUoaxRDJ5n+tbdbnWj31X93ODxo9NY5I0mOKfcYLRXLcfoDwarGyHA4U1K+5lQJ4SuNLVMdK8UrdcNwRMQ3CRjI3uxxJEUvtuqql7w1rarZnVvYSZ+M/EEMm3GT00yF5esPp6aa4qHRM6EzUnm5BLgVUazlMIm52BvjlBH3hpGvdD5jh0XzZoF6I5CEo6WSREVscMcLmERX2GGNUuaYtEKOBDE7LqOyf04mm5TKoYhkgMzYVGrzYopzvz1qhuv2MnAQLyoL20liqhdP1rCQb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(346002)(376002)(366004)(83380400001)(86362001)(82960400001)(38100700002)(478600001)(316002)(6486002)(66476007)(4326008)(8676002)(66556008)(186003)(66946007)(6512007)(2906002)(6506007)(26005)(9686003)(5660300002)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+s5HW84yhyVjIGSbfcZGbL+KN1/ZH4S7rW6G4R6ksmNcwBVKA6SNcCfKqbO8?=
 =?us-ascii?Q?p6QbN8C6eif9cZylKypWh0/BEH2S3C/mQZLohTqAnp7gLT4LqXE+UmiHDlV8?=
 =?us-ascii?Q?pPziMfaeBuzmFGaZmCyEMb5hKVl8hxd1nHrZ0XEnDRy9OuWcsF4AP8RKHcPT?=
 =?us-ascii?Q?xVfG6QCGJKcSYrd9Q4pm03VYx6KAxBUNzoNdhT2KL+ye+hX93csdx5DGFFQH?=
 =?us-ascii?Q?UUdk2PC/RwCHBAhgbrvrh7tDLLyIrY14AHC7ogKXfLNBLE7LcOlr7U3H9yNW?=
 =?us-ascii?Q?7hpFCBa9jrrGz7Ejg9czbsSBIK6d7P1rWhhPrieRmMlsQi1zK2I+dIEkK3I3?=
 =?us-ascii?Q?4gN1b109rb2LL3ho370JyPI/LJ5M6bmIdLAmjRqFgY39uY28ntbR9CD2AhZr?=
 =?us-ascii?Q?L0emXK1uDKSAymZ/ZyH7H0QdAc+rFinJTweCM8r9jeZ2w6US7wwLtYAvNsX1?=
 =?us-ascii?Q?Kg7LS9nWYVFGDqUsgAwzpwSAHFJw1Z3q0PoVH78tp8E1MF5P1F8iWh39KGS8?=
 =?us-ascii?Q?0xzzHetRiUw5wLJS+rb3/VqngMoO+YFrJEaJTRZofyd6McnCs0CY60wgrbYI?=
 =?us-ascii?Q?hrI53bxm6jSWl7RnqwL9JJs7WS8Ztxm8ZiOtK+Lv/gTkm2gC0/E/JwwmCfqW?=
 =?us-ascii?Q?EHjxbXBpEPOG+XSj+kltXJJQ6gql6Yu8CkBCU/F9W2Pc0YBhAP8Ze6UALKpg?=
 =?us-ascii?Q?777rXp2/fFWBeOyR2XYJbt2uYlaVk+RXuQD4e45d4jBNCorwycEVagAiCchT?=
 =?us-ascii?Q?cOdSbLsmqNNxznPl5sDsCj7iF09R33uA176RK3Z4nsgGBBI2N5r7w7qmfjm0?=
 =?us-ascii?Q?eT8uTYxo6EWLUBlRtaOx5abANSGIZf5Mk9A/7rPXukbokA/OZQ4aW0m6bjKA?=
 =?us-ascii?Q?/Ti7TCuEZHmmwPNutImp/BDHckVySao+a0V0tLhOTynXouzwTqMfXXVLyRJ0?=
 =?us-ascii?Q?CkEaatGiRKTJ+dZZ9AL3LTVtCT0VaNAKUgNQvnnip3Em/SBl3CbKWs3qVFaQ?=
 =?us-ascii?Q?f7KnuHrNT/oJ2LrG9ooQvdr1ZnsfQUplYGc+2u6Wr0DVhroGfPwLRw/ciEPr?=
 =?us-ascii?Q?kH0Bc6nFXjFRriL3m9mwxUgalYLGf4BK7sErR4iVNjcf3akNd8TdQ4IVOpQ9?=
 =?us-ascii?Q?KFUEIdC86+rtwZvi3mUL864bjkcfcW+I/6vcCuYi5qt2Y3sVUK2t8BTwXgO7?=
 =?us-ascii?Q?jw4u1f4CKshSvDxG9ef/+lAM0RUxTabOPjTS41b1AKBSEvx4SCdhOlHNGz23?=
 =?us-ascii?Q?CYRpbAUOdeKKapnCBQh/q0u+EinEI+cmQd/5hxchqkEFJpA9wJXIKqNPgp75?=
 =?us-ascii?Q?sbJgnO8qnjnZSieugX2Q3c8i2Bf+ItBeWiUGMUGlIlYIy6mqDI5YG8AtdASs?=
 =?us-ascii?Q?gsL/9L94QxGk7PEzCt/h4gwIQiggmpFWyvP532nT6cc/3xvSIueGDGAZS1f3?=
 =?us-ascii?Q?dkgLa03ZQJZjCiYMfGEYH/BgGg9tsK2bvVhVoiOtNCdxzcmEwT4cvgGJKUk6?=
 =?us-ascii?Q?bWwRE+DAtO2L4jGNLUxpb2xQEHXsRUMULqDwJB1aDmYpoSo4cRLa65cGjf9R?=
 =?us-ascii?Q?k7sGjUG91aRqNkkeTw2BN+WR9/TKKtzg2xVni6gUX4XT23r1VF6e7x9OM3g9?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9cd4d2-a7de-47f9-b5e5-08da7bfde33f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 00:59:19.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGNKsdDxcDpslTFJeAj3CfxMrgHmd8I+L9SmiitQCo5UDe6wEqwJPJLh3BuenEohAowAKG3F6yQbAZT7dU0JUg/2qfdLN81jDQW7rW9Xl48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4143
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Add a helper function to check the combination of interleave ways and
> interleave granularity together is sane against the interleave mask from
> the HDM decoder. Add the check to cxl_region_attach() to make sure the
> region config is sane. Add the check to cxl_port_setup_targets() to make
> sure the port setup config is also sane.
> 
> Calculation refers to CXL spec v3 8.2.4.19.13 implementation note #3.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c |   11 ++++++++++-
>  drivers/cxl/cxlmem.h      |   37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index cf5d5811fe4c..6f77ad22d47d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1081,6 +1081,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		return rc;
>  	}
>  
> +	rc = cxl_interleave_capable(port, &cxlr->dev, iw, ig);
> +	if (rc)
> +		return rc;
> +
>  	cxld->interleave_ways = iw;
>  	cxld->interleave_granularity = ig;
>  	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport),
> @@ -1218,6 +1222,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -EBUSY;
>  	}
>  
> +	ep_port = cxled_to_port(cxled);
> +	rc = cxl_interleave_capable(ep_port, &cxlr->dev, p->interleave_ways,
> +				    p->interleave_granularity);
> +	if (rc)
> +		return rc;
> +
>  	for (i = 0; i < p->interleave_ways; i++) {
>  		struct cxl_endpoint_decoder *cxled_target;
>  		struct cxl_memdev *cxlmd_target;
> @@ -1236,7 +1246,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		}
>  	}
>  
> -	ep_port = cxled_to_port(cxled);
>  	root_port = cxlrd_to_port(cxlrd);
>  	dport = cxl_find_dport_by_dev(root_port, ep_port->host_bridge);
>  	if (!dport) {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..625fce0b6c2c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -401,6 +401,43 @@ struct cxl_hdm {
>  	struct cxl_port *port;
>  };
>  
> +static inline int cxl_interleave_capable(struct cxl_port *port,
> +					 struct device *dev,
> +					 int ways, int granularity)
> +{
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	unsigned int addr_mask;
> +	u16 eig;
> +	u8 eiw;
> +	int rc;
> +
> +	rc = granularity_to_cxl(granularity, &eig);
> +	if (rc)
> +		return rc;
> +
> +	rc = ways_to_cxl(ways, &eiw);
> +	if (rc)
> +		return rc;
> +
> +	if (eiw == 0)
> +		return 0;
> +
> +	if (is_power_of_2(eiw))
> +		addr_mask = GENMASK(eig + 8 + eiw - 1, eig + 8);
> +	else
> +		addr_mask = GENMASK((eig + eiw) / 3 - 1, eig + 8);
> +
> +	if (~cxlhdm->interleave_mask & addr_mask) {
> +		dev_warn(dev,
> +			 "%s:%s interleave (eig: %d eiw: %d mask: %#x) exceed cap (mask: %#x)\n",
> +			 dev_name(port->uport), dev_name(&port->dev), eig, eiw,
> +			 cxlhdm->interleave_mask, addr_mask);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

Looks good, just this function is too big to be a static inline. It's
also not used outside of core/region.c, so it can just be private to
core/region.c.

Other than that you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
