Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED27C19F2D
	for <linux-cxl@archiver.kernel.org>; Tue,  9 Aug 2022 16:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243928AbiHIQTG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 Aug 2022 12:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiHIQTF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 Aug 2022 12:19:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF3C1EEC7
        for <linux-cxl@vger.kernel.org>; Tue,  9 Aug 2022 09:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660061943; x=1691597943;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m5UzXwsVpG43ElCVcI36ad4Ai6d1jDlFfjDGtk+tzSs=;
  b=Oy0MoIduP3533rFyRiTZExCuXMYI7E9FQOLwsBP1JXZ4YqTQoIKhbvZW
   ak8x2UZzEV3DkZb0PcCbuRkb7f72pckBPSp0hQbsGIZsa7bB3V/Bv1DA2
   dNbn71f69pzKx6g5zmzpAsw4VaShslDoVXXR64t9FODFC/TY98gk6B00z
   tOacp7xozJqN4hL5ielFFn56c5OXBk8mlr4JGdwUrlfOU1yFiZIFIb1Yz
   /VVw3l2/Ih8NUl9nRk5GdTXozl4tHvKfygYAnXQmib7WqmbNSr4Cnqw/Z
   /BpzZ1BSBVcSItPnAUQEx/lDTiij9XcS4YM/meWSsxoLIDraIGgATPZZ2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="270650471"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="270650471"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 09:19:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="580862156"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 09 Aug 2022 09:19:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 09:19:02 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 09:19:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 09:19:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 9 Aug 2022 09:19:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cqut/B+ckSJRbZBGG2uVCdGjMFyszCAj4ihznVNiFX3eW8AeJ6A1s2hZnQsQihpw+wxBX9yK72/Tj5Z/WTuglB3rRGVmMeciEPNT6hrqS6z9zZ1pf+UWzjQpsFvjvD+K9qpk5CgnE/W3nB0GaVKzV/JMwiVKGZP9x1q1iKHsEAezjOfkz8oT46KxV7kPZMm/4gxCVHuywvoitD8aqcsC2oUWSrQpLkzKbfX6DjDRAJ1R1tOXu+4H79TS19ZjSlu40yXXESLZgryDoLWU3MGRc0UKcfBTMU+h5AA7vH32cE5cl23kDyU1ibZ+ziL6ZekP9P6FIkScV3YiLziTB1kNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaTynB0E6X6U0ipNvjav0JUYOK9K++nrMFN6Q8Ck1EM=;
 b=Kx0hnRqQ5+2HyCdRiIall8cCdjjVKv+aDPIzxUgZbqcJpQDGHVrQGwe5lM05KprXLBXkknzrtrtZdwLTSXCpQIAlFOvMpS6oNRKokJ1bGHN5yvMqYReRvvHA7SuwMuJwNv7w+iLEkiInLItjeBkX0ZhYau3Cvm7VhH9cZxJ/0SqwpbG0+kj0TGt1vrGxMKDAeDcvkGzbwmNy29/6JzFh7ISuqzHijpEGVAX8XZO6fZGFf+eirFdffHh3u20I4Tw6rSkBgXd/ubc0ICNSOshaKuKiHfiwK+NCiisXmBdXybz8GwLzZkbA7+46xl1ZB0ZmB/ujmVP0lSMFgZkJqroPGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB4582.namprd11.prod.outlook.com
 (2603:10b6:208:265::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 16:19:00 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 16:19:00 +0000
Date:   Tue, 9 Aug 2022 09:18:57 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH 1/3] cxl: Add check for result of interleave ways plus
 granularity combo
Message-ID: <62f288f1cb88a_1f18b2943a@dwillia2-xfh.jf.intel.com.notmuch>
References: <165999244272.493131.1975513183227389633.stgit@djiang5-desk4.jf.intel.com>
 <165999281717.493131.1159254270127915425.stgit@djiang5-desk4.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165999281717.493131.1159254270127915425.stgit@djiang5-desk4.jf.intel.com>
X-ClientProxiedBy: BY5PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::42) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5ac85d6-055f-4100-a984-08da7a22dded
X-MS-TrafficTypeDiagnostic: MN2PR11MB4582:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EslumpoheNS0gLuZ6gEisQ9WUpe2FejxcnkWIPUQpZ0advH4I/cnz6/AIDAuYidyqPtQwFBeyEGsE8Kllif+dX5BneyFzOJ09SqzjqbINl/oeGTRibJJ1SbNf7EyFQCQRM5SxLZSLLwK3LeRfRnD9MWLw3kFPIOzxXXrqA53lCzyHeaBPh2kazSlKqGMXmfSk0ohR6GDnZ17A2GFBWTsdeeEz/yvcRKEQl8SmcbKN7l3oQedzZkZU30jpWnj7dIXpgIfngXGRR0dmTGnOsI6aDVGrNIENtoL4aHDObMQ9/7nSd6FGRfr2HP4ZvnE7zfY4S3XDA5qIX+WSoLwCzpfCR/QiaL79iB8TFKm2140MofXBYTpiaPGDXQVwY47/OR7IeRRqdXa1v2CriCgrn06xLPfrgV+7BzqYjCQCccUfrhZh/JP6ZgpAPPHT0JSe5ObT35tFoyr9OQERBX2uw3dx2bPef953CTJjA645AvZRYJH8FOeD4M1sZnc1FoINA2tdm3s+fcgXj0PHsLJ+B8FXsFonkNReOwVJdBuHbO8G/7VaTz0m7uVAzSrhkkmdIAvenKrcRSmJP+tNU8SaSIAZCvIio6aEfziDFuVSYUDwHW92dxRLAAo0utMlW1R7dojE6TrviHjQRAT5cRewQ9N6cEcJrYN6lDVLraF2fpVCZDmDVL4v1QpazB60CeRIZirJA61+yyK+bnX7+2x3QVmmqzwqGqY27P1dsYiyw3sdZEJb4lijZBfMThK8ET+6SgJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(136003)(366004)(346002)(376002)(41300700001)(26005)(86362001)(6506007)(6512007)(9686003)(6666004)(38100700002)(82960400001)(6486002)(83380400001)(186003)(8936002)(5660300002)(4326008)(66476007)(2906002)(66556008)(8676002)(66946007)(316002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?flZwiz5FAGOiL1R+H3AgAtbOloW2cO6Y+7qvrzF0c/Pjox4T/95h/1tYnt6+?=
 =?us-ascii?Q?XTrIctr9DAatDWybUsBi7zIscwk2UB5wUlT6KogBKzRa7Ln7jMFwmhWn0yrx?=
 =?us-ascii?Q?RB+ujJK/E4uWY5t0QPIFTroRcxq9VEL+suoI5tpVCOzo5LB7bfTnM5SIej1z?=
 =?us-ascii?Q?+wg9oqoOtNDLzEQCZIOR9y5UJg6GKIDF4m6nNOGjdILTZPN4oswPEDTH6h/H?=
 =?us-ascii?Q?i+PfJr12+IBElKknuDzhrWXABwCxJnjNaBQ1wltdGNdyctQt1lW75hlwcYH3?=
 =?us-ascii?Q?d5c3ZvKQFeveHcmatUpoijxBhFb0Wb0+PjpF4PumDJttxea4gYTpMgfnALbS?=
 =?us-ascii?Q?jrq7RfA/et01JFrLUz1x5Ia/UzIUUoL1e7yF6kYJDmuZxP6QFjuvjWB8idnE?=
 =?us-ascii?Q?OFSXIKvXd86AvA63n+oIlr3Bu3DE+V1V9FoOkr7hyR4HJJLXPYW/iJU0/3NU?=
 =?us-ascii?Q?YIlZZvYgCqXkaqpbga15bmvP8jJR1nrudyxUgaB/Nz5v4bFDjLPbVoFdl1Uf?=
 =?us-ascii?Q?OQniZijdwbGhIpHX5OSCYCqJyzWD4YK5R+qdrQ1Oyhf6OjlKBkKbiW0XpbNm?=
 =?us-ascii?Q?d1HG1Cg5eTMu1St1iQJFhR3UFjYAbGFEqi2luV6j4fn4aFh0zo10X9kxYjh3?=
 =?us-ascii?Q?FpoeYXxe0qLuoEpbuJjSFTKms3IMDe+QhgU2UC/cTMv5zL0v8zO6XuPKHuyo?=
 =?us-ascii?Q?AhSjRWp2DA/rZtQVPEf3Lc53pKmvZQWqs9p404Aj5H44b/N9MvFE6g8gWXuf?=
 =?us-ascii?Q?WVZGTy44QWGY9uWnHQ+RoBTOVJpvzKtWi/QZvdraMRTeslI00Tffobe2qjEm?=
 =?us-ascii?Q?5ysxy7PclauvUtUHUEDfQPdZoXXVK2hWRvlZ60DQq61EVzfqVTsEDcodM85B?=
 =?us-ascii?Q?hNbZGxM3z8SAe8MiISx8YPzjrAZTaZzFSKnq5g6eWAi7NaOWya2HFhFw2KIA?=
 =?us-ascii?Q?LMFCVqzPc8Phk7sOaEYksrHhHnq73CK5qCjO4Hbbe8LqD2t11WQDq6kdX4ml?=
 =?us-ascii?Q?KOOuHfI0Orx5H3NC6wNCZW9UFUpAUGkNVwX/ecpqpbb27STW0lCcAARBwhQm?=
 =?us-ascii?Q?s57i8ZSuDwrp5rpT0TXc9ByEsf21z/WOerBrueP3rt7K3hDg5sAIpPOZea5Z?=
 =?us-ascii?Q?QXFbMDzZbhzKgT3U/WHPLRBcF0H3EB+rl+Yp0AYI7xe0EF6lGB8q3SreZlHd?=
 =?us-ascii?Q?iS9yzrSKDfKbTVRmu2Y6c/aytx+URAxnpxoxcG3zB2+U0joxdTEesESQV/7E?=
 =?us-ascii?Q?Q2sxkH8Otj0RWQga+JjRxLRBOEo5rDBFANui4C98dhRaUkrwLdKJxL8rnBJG?=
 =?us-ascii?Q?A1DxYkB/cjMrMXWVAQCJWAZgGcTNO3jC8fjY/nofFT61IDSIe5l8a6i5MN/X?=
 =?us-ascii?Q?HVmg6qGSunAYvR1Qc9N6KHTQHHUy8LqDI1YYbOc6GWvctPoqDBMFdwuGLnY5?=
 =?us-ascii?Q?Ay9vPYLiFOePYrklLmWaiobomiC/Hy8VQmq6YnIKV8MSLPowiNpIMLoePAkp?=
 =?us-ascii?Q?344mlw83w5lkNY5ITRr+YyfoI9Ct7AkuevPw2pMn3cu9mOnPFHlBrYbRuz+X?=
 =?us-ascii?Q?XpbHbWyIL978QQ50/I/2ZYP9d6Q3nylGcSO5hMFzoq/nhXFl9UHsbnxu/fd3?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ac85d6-055f-4100-a984-08da7a22dded
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 16:18:59.8725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yhal1HhW+x7AKAbEEQlBCZIL+b4qP4mEjTt6U8nAgEYLK254v7fIDRTQ9vkQZ1ua0xgtHt2CmYiVuVGATi2QBHYPMk++P8SwHEL3l7TAemk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4582
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
>  drivers/cxl/core/region.c |   17 ++++++++++++++++-
>  drivers/cxl/cxl.h         |   11 +++++++++++
>  drivers/cxl/cxlmem.h      |   31 +++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index cf5d5811fe4c..a209a8de31fd 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1081,6 +1081,13 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		return rc;
>  	}
>  
> +	rc = cxl_interleave_verify(port, iw, ig);

There are multiple "interleave verify" actions, this function is just
handling the interleave address bit capability, so how about:

s/cxl_interleave_verify/cxl_interleave_capable/

> +	if (rc) {
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave & granularity combo: %d\n",

If this fires I would want to know the iw and ig settings, something
like:

    "%s:%s interleave (ig: %d iw: %d mask: %#x) exceeds capability (mask: %#x)\n"

Likely that message would need to move internal to
cxl_interleave_capable() where you have the address masks available.


> +			dev_name(port->uport), dev_name(&port->dev), rc);
> +		return rc;
> +	}
> +
>  	cxld->interleave_ways = iw;
>  	cxld->interleave_granularity = ig;
>  	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport),
> @@ -1218,6 +1225,15 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -EBUSY;
>  	}
>  
> +	ep_port = cxled_to_port(cxled);
> +	rc = cxl_interleave_verify(ep_port, p->interleave_ways,
> +				   p->interleave_granularity);
> +	if (rc) {
> +		dev_dbg(&cxlr->dev, "%s: invalid interleave & granularity combo: %d\n",
> +			dev_name(&cxlmd->dev), rc);

...and then you don't need to duplicate the message if it is internal to
cxl_interleave_capable().

> +		return rc;
> +	}
> +
>  	for (i = 0; i < p->interleave_ways; i++) {
>  		struct cxl_endpoint_decoder *cxled_target;
>  		struct cxl_memdev *cxlmd_target;
> @@ -1236,7 +1252,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		}
>  	}
>  
> -	ep_port = cxled_to_port(cxled);
>  	root_port = cxlrd_to_port(cxlrd);
>  	dport = cxl_find_dport_by_dev(root_port, ep_port->host_bridge);
>  	if (!dport) {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index bc604b7e44fb..275979fbd15a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -61,6 +61,17 @@
>  #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
>  #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
>  
> +enum {
> +	CXL_INTERLEAVE_1_WAY = 0,
> +	CXL_INTERLEAVE_2_WAY,
> +	CXL_INTERLEAVE_4_WAY,
> +	CXL_INTERLEAVE_8_WAY,
> +	CXL_INTERLEAVE_16_WAY,
> +	CXL_INTERLEAVE_3_WAY = 8,
> +	CXL_INTERLEAVE_6_WAY,
> +	CXL_INTERLEAVE_12_WAY

I'm not sure this new enum is worth it given only one of these will ever
be used.

> +};
> +
>  static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>  {
>  	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..d5f872ca62f9 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -401,6 +401,37 @@ struct cxl_hdm {
>  	struct cxl_port *port;
>  };
>  
> +static inline int cxl_interleave_verify(struct cxl_port *port,
> +					int ways, int granularity)
> +{
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	unsigned int addr_mask;
> +	u16 ig;
> +	u8 iw;
> +	int rc;
> +
> +	rc = granularity_to_cxl(granularity, &ig);
> +	if (rc)
> +		return rc;
> +
> +	rc = ways_to_cxl(ways, &iw);
> +	if (rc)
> +		return rc;
> +
> +	if (iw == 0)
> +		return 0;
> +
> +	if (iw < CXL_INTERLEAVE_3_WAY)

...just do "is_power_of_2(iw)" here instead.

> +		addr_mask = GENMASK(ig + 8 + iw - 1, ig + 8);
> +	else
> +		addr_mask = GENMASK((ig + iw) / 3 - 1, ig + 8);

