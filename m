Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF9AC00144
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 19:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiHATOT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiHATNH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 15:13:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B98439BAC;
        Mon,  1 Aug 2022 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659381106; x=1690917106;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=E7HTa0QWpwtfA3d/03DYLxJ48dRn592i941CUIRMx70=;
  b=GeRYKg39RwflXvghmAAUYV0BuBqzr0PkeymyBkYAuLtuskOE5i8YMSRA
   79OPbw6nt6SGivDqyFB1+0AcyuB8bhc5IP4+2bzYM6m7PmnyJcsNXBHlo
   vBZRRSv+bqAwDiSZgShMEzU/RwGoIAFT1a/cDNV1iqOB/RsEwq7DMvsRI
   geLjeCElD3ZJulizaIfEHRirYsnGkHgdQaV16OPqO+2jhPIJZXwKqFi54
   CVG+TbEsRsYTgSOB9bMN3+9M0fEQEGyr2wye/KzaUyALwLiWSrqyUUxhr
   aGlUvuh9+qKkCYxpzkPMX70hKYU+XzwV5bH4QT2XPWJW0g56yRSEkEhaU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="375527760"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="375527760"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:11:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="602144450"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 01 Aug 2022 12:11:45 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 12:11:44 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 12:11:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 12:11:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 12:11:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkqLfRc9K0NE4+FMFJ6T5DE4WtbTVtXJoXwB25QGHlWvmzqA0SoIw6bQ+W301xrQ2BDB+tm/QBHn1uc81EaC01wfrTjTuR6Q0Nk8fyv2zBp5JjyAUnzCA9ycogeH1n+clElqGyLPH2HfEh1hYmSCjq0rGbzHxmfdfYA0xqlDRtd7j1fC2vKaMDZqGG7RhBBZf08Lr0HLNPUuWl1oXUhSmdX8u+ZMPLpAo8FXDkqEk7GwEnLnY3cacERln/GJx5TTMlKXHb+Z2xbzT/K1yj8cWbZKEHVXWUux8221TkdlNuTYXg/i9k7wC2Mbd1ADGjDcdF9gzKAiVmot7wZb0NGJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0HxTnEnUGH2zxtCh+2+5lc+2jpfn/ZEzluDMGfjVYM=;
 b=dBi3H+5Z02No/CG9n5tviNqaY+oCcHKoHrkGchQ7qfAssqEQ6CRbFFwpk8LMYia/ccougmGK8sceG+QHcoB9U96CC0+srVIMkwppK39rc5TKm5ywV599rUT3WNlzXWy9+Aa67KpUyHcCTw+8hQp1mhl/YHIlcHRT6rxEGX5VboLRTXO8/lZTYeSUwuCXW6LNy+ISXieFWcd/SOo6ZLOEYVFwOmarAiX9T6T0VlFHECWsfuef1eGhjes8FuG8TxXoprYsDEn5aU0XUMmdC4C6FoiScliGLlUVANIMgxI/NCzIP77cDPxxwML3tX2E000ecqF2Q25uvJhPwwJ3xot39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM5PR11MB1547.namprd11.prod.outlook.com
 (2603:10b6:4:a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Mon, 1 Aug
 2022 19:11:42 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 19:11:42 +0000
Date:   Mon, 1 Aug 2022 12:11:40 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 3/3] cxl/region: decrement ->nr_targets on error in
 cxl_region_attach()
Message-ID: <62e8256c1a915_b075294e1@dwillia2-xfh.jf.intel.com.notmuch>
References: <Yueor88I/DkVSOtL@kili>
 <YuepCvUAoCtdpcoO@kili>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YuepCvUAoCtdpcoO@kili>
X-ClientProxiedBy: SJ0PR05CA0151.namprd05.prod.outlook.com
 (2603:10b6:a03:339::6) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6492e05-0d62-4ab7-64dd-08da73f1ab50
X-MS-TrafficTypeDiagnostic: DM5PR11MB1547:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nbc8ZJCFrY+w1kjiZ1bCRndxLqDml5Rb7L9iyM9ElMOclwwrvHNkhowOw4OOYyXHqTM0UIDunsuluJ7DbRGuWc0cI9JTntSaRDa1KyfUd1rtDbID+f7u3ZHEvtMZpWNqs1JSjXh1s8nR5OY2GGOd3WwK7Anvv60OlMavBp1edh1uAHtzPYSYb02JXx7GopcnGjGce96AvYr5jeXpq+1LtpRjrT2nv7GT4jFyL4zuA8a+sgheFqbMDTBCrxsIoqCvJdAbacxO2woyimaQEkhlMclXhEZfpV9K89elC4FSa92OBzI5BUIjYgodLhqn8ojtOJ/YM5tnUvt0rrBQocdewth92xSjD+Y7M2UNHoo9QjSmY40NDjKQNC1+4bODdyB5mzxi2XL7/lWDSbkPPptX24bC/0P7QJmiXy9UJPCQxSU8QKSR8o562NB829b996lTYYAHA2/aLEEFD3fiuIGruXs6MhWKC1085lGmCyWl+wrMH5voTk+NO6BBX9M4wWxpI/iHnaz/rLPV9XKR14Xcv8OlOltstd/R8VJg6nbiFCQoxzkL+7R/OZJRqCtBKw0VBBcwsHq1xS/kRXnPmD6Rp8L1eF4+ExHwNlFdAnxDz2XKAD3Bs+oP/rZROQyJaF6oxb4n3/u472/xXVtzn0qktxFm3DKmRosQTEu812YMfN2X1DM1s1IByfBOEHqip5yGoDStvJ/8r63iA6Y9PR8Md1fyWoqJe7zJKJhWX0PuN+dMsABM7h/aiSe0FvfwkzFs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(136003)(376002)(396003)(6486002)(478600001)(316002)(83380400001)(2906002)(110136005)(54906003)(41300700001)(66946007)(66556008)(5660300002)(4744005)(8936002)(66476007)(8676002)(4326008)(9686003)(6512007)(86362001)(6506007)(26005)(82960400001)(186003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YF4lw8cS/iuzHmAwQtVrcrL/CD/0scNNymTQyVMLuXvOY5ygagRHJGZYKtkA?=
 =?us-ascii?Q?khqnEYEh6zVCW9FbPGQMO+9uBBMMURXlFOoHVCTq6T3Kv+dzkg1Fv4QcYbnb?=
 =?us-ascii?Q?woB/nGqLM7M8DsenQdzoA8rYnIqRQ1itGAEZ0+DPslmtV9VGcw3YxluBeKNI?=
 =?us-ascii?Q?QsCgBD3woi335CHBpQ1ZpuPydfiMU8sVrZNswQFE6ANv18umaRsSG96z8e8y?=
 =?us-ascii?Q?3QZT9e51OaCXgGQO/EmeUjjFl+BPVJtExWdewHBlxpU8h4yJPs+WXvAvgtwo?=
 =?us-ascii?Q?TJiAJoAQOJEhj0GuodnzXPAYrhY6vO4S+7y5Mb2HlEJmE+5QJsserM2/oUI4?=
 =?us-ascii?Q?S25qreebhNG34xxvrV3inX7na/baNA0T77Vb70DxepyKjsMrsKcVElya61Aq?=
 =?us-ascii?Q?5QRBL4VFZmdrXh4VrN7QaeMdM4PBUMDvPmHyIPqdgBbyU4NPP2orwfAt+lHi?=
 =?us-ascii?Q?yFC3DMuhb23dh7iTRD53G5+DOc67YL/Cwyl4RdkMQ/5emY3AGhSYSTffM/hI?=
 =?us-ascii?Q?YmWxchxXIl2FWAnUD5unVm+W2jSgmNmN1qAvsgEsKO8MeQw36MLFTlEbWpxH?=
 =?us-ascii?Q?NMkzLgWXtQFCJYfRIP0S8JhnCbElFLGeCLCAAVR1x92lJ88oIYP/pOEKQufD?=
 =?us-ascii?Q?iNdusJuU3DJevk2v4o7yoYqag60cJ58PlsjqwSnivX1Fzg3rmy4+y4o06Zyo?=
 =?us-ascii?Q?Ej85NLyBODP2oOGb3WO8GJJtscigdRDTl9GIyTugVzCHW+jt49keKs1BO0WA?=
 =?us-ascii?Q?efYNkbkJtuSmnFNTfSs14fNwzBcWTuFJpXa0FuqjPsNfMPD/PtpysHghBewV?=
 =?us-ascii?Q?fEU8jumtPZ39ONzYU6EqxURIek54D8Fe3W/l+0TpghiaUm9ChREpszKcVmTq?=
 =?us-ascii?Q?/N6wFs4TMox5xZDDW0iqY2MHjq65rkrPwI3n2FcyDku0q2IaW13ZHbJqSCAC?=
 =?us-ascii?Q?IRsETdoDqC5AAgleMQqVDfqgN9be5DbqW5drsjnDOL2yjbCSRkPGjokb76dT?=
 =?us-ascii?Q?vD1zpWkVyociXTdKf0Xx8wnmeJ2yL9hWKgSptR0OK1ak8EnocG1H++jfydfe?=
 =?us-ascii?Q?8rVoUKKFC3e9GNuzrFBLaiEQ8n7j0OGmKL1U86hbmsZIhk7y0jvCDkD5YGAq?=
 =?us-ascii?Q?fcCDEsmkw9LZf5MGIHehttrJjWD44kR6Q38EqhcDPtNGQjpmuuOAIOPzZX2/?=
 =?us-ascii?Q?x8Z+9uTQ0sEWUbs/LtVFvzY8qWh/0C3t3R9fn/Gt0yxWf0xw5bJve2CkP/qK?=
 =?us-ascii?Q?I9sNVcDyrBt5/Sqy8HT6S1qCvn/ttyjH9mApvYc2uB48JWAg7PAe9kKzUdTR?=
 =?us-ascii?Q?CCd37mTa9CVpGQpiV6U3jufVDQQuT30nLiON46vTV1wNuYA5jhaYZyBngtod?=
 =?us-ascii?Q?PZl6HlaR9nqCZSyQmFvx8TPu53H8bsDBKHeKitvXk/YhUkua0Kdrd1/Af1Im?=
 =?us-ascii?Q?YUGR9IjgDFqFqcQVXipJwfTTg0Yo+Q/lInGvK5JpUeYW3QiyCJp+ZWbMVLVB?=
 =?us-ascii?Q?4jJh5ju9XVNXIB2+3ux4Ibhyyd8bbhZwpEvDgYlHBKcgeNdgDnqpnues01B+?=
 =?us-ascii?Q?9Mn+Pd4GD+UqFY9ax+I33SsGNJyPrRAlfGdx/dRXu/rHsBbSwIde9EFTvVxF?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6492e05-0d62-4ab7-64dd-08da73f1ab50
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 19:11:42.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXjw851Shs1Rg2pkxEomI8HP7EgNYpEiajXx6c4CNwoQHDnREV2QZhzm4NfxmRBLMsFwZLjkw+zkL3GfzzBmGdoEtJ7HRTHEjuUtyI1tE1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1547
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Carpenter wrote:
> The ++ needs a match -- on the clean up path.  If the p->nr_targets
> value gets to be more than 16 it leads to uninitialized data in
> cxl_port_setup_targets().
> 
> drivers/cxl/core/region.c:995 cxl_port_setup_targets() error: uninitialized symbol 'eiw'.
> 
> Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/cxl/core/region.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c80932bca667..0450354bff4d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1217,12 +1217,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	if (p->nr_targets == p->interleave_ways) {
>  		rc = cxl_region_setup_targets(cxlr);
>  		if (rc)
> -			goto err;
> +			goto err_decrement;
>  		p->state = CXL_CONFIG_ACTIVE;
>  	}
>  
>  	return 0;
>  
> +err_decrement:
> +	p->nr_targets--;

Yes, looks good.
