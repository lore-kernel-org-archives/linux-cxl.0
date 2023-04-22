Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15339C77B78
	for <linux-cxl@archiver.kernel.org>; Sat, 22 Apr 2023 21:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDVVgg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 22 Apr 2023 17:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDVVge (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 22 Apr 2023 17:36:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535EA18E
        for <linux-cxl@vger.kernel.org>; Sat, 22 Apr 2023 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682199393; x=1713735393;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4aBDylWuHNPkQB+6ysNqNiSJSQ/PyIx6ZEPfCDHZ2NA=;
  b=U5MDmRhdQccsTFM5BuHTqZl6ET4Ez0fELpxMFSo5Wh4Q2MzGY3QyaqdK
   bV5p4OTDiC9HUD1T6SfpSAMg2+mckngIgjL80kXsJ+LxiurSHIDEStsil
   jpWfNzdnHf/pHSNoWDc2VSnPdZOdKuhJDn4ur6LQ+QBMERTbEp9no0Frb
   L5zZckTirvc2KfJtKznOmSkJRwvI6IbReQxPNlaDmfnAXF8izqK8S+QyT
   mbctunKItxkySW6P51yi9WezAWaQEdE38khxm2Du0GmqPUeyGKkA04zHh
   1yv5vU34rXo16GpfRWJ+cUU8SQuaBawSKuBbSHjSrVxHUx+AEmdWjZX4q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="409140097"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="409140097"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 14:36:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="692615515"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="692615515"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 22 Apr 2023 14:36:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 22 Apr 2023 14:36:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 22 Apr 2023 14:36:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 22 Apr 2023 14:36:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agHf/7xjtE41PVjeNzltg7wm3mcgQJLNhw9FtjrnQOlG3ELq5vVH+EZwjYhUIr9VZnN+DrlDEGpHZZIS+TUrgsOt+TxI9H02LunWSD8mo2F+Ma1BPtdRickurxDAQwc1vdILIC1GWpByWOMbqv1IbcTQXCiskvVV2l5Wn047HBYbGyMrDAOLqsjuzSZJLcU5XtkkTVtUBMW0/ZubEFoykxceEiCaRMJnApl4LdayUeM6eK9Np44FVHF9jt3aUM0hH3chWtREEM9KbLS0eqXFj/9sA+yd4cv8ZStkx75abRmV0VXmmQ2bES3tP+yJTs+ECqaTFQV30HIragqLr9lobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xdjW0v9c/knlq8V8EyT4vb5nTzauYjDUmqCpfprL0c=;
 b=TslCytNN4TVLqQRyf6JzvLx9G89ylIGWX2VebNaLIwVQmAZBBb0BU8R65wOoB6V/9T+qDgkAr3Rm0UHe/RVQgIfuEKXGOF1GxghrY4O55QAzqPvcJT2rIpQmNQPlMyn2MxnMBsPYbgzCZqOtkovcy8LXs2a2UHaR1fNgrPNgj9YC6+r6WiccBexXBLf2niL482mjqhpa270+vSOTslH3cQYt3SUszJ4bcgg2Rt+QppzgkMwJmxO0fCUZoZmKvWF3tTL8gvpJck4AHWCbgJ70sLAAe94INYG3khIh55jevuIMcmhGZlu0H6YIRlhTZilSnVqFhtWpGTITY7bD6T8KPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB8085.namprd11.prod.outlook.com (2603:10b6:610:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.29; Sat, 22 Apr
 2023 21:36:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Sat, 22 Apr 2023
 21:36:24 +0000
Date:   Sat, 22 Apr 2023 14:36:21 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v13 7/9] cxl/region: Provide region info to the
 cxl_poison trace event
Message-ID: <64445355408e7_1b66294cf@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1681838291.git.alison.schofield@intel.com>
 <438b01ccaa70592539e8eda4eb2b1d617ba03160.1681838292.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <438b01ccaa70592539e8eda4eb2b1d617ba03160.1681838292.git.alison.schofield@intel.com>
X-ClientProxiedBy: BY3PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 834b7d54-a82b-4938-fc77-08db43799eb8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8sAHSd83nO1OreWGQz9ucbuA+V4CXyef82OeRJRh7TQ7wHKjzQcLi908FgYjgm+IlQ+83t+R1f/aNT+eYIzBlpFUgoA6pne9kfg2goxtXTTLaji6aH/5zU+1OMRDd8igPpSjuRpzGqnxmM3uF7d+wcACNCRTvpj3XuEHar6f+T/ghpuUk5T7BaIRQFmASBxffDjtr2LKNYVtWnzYMFAJe4Rtl7uK7rjfj8Vfyz4XHMh0AeF60uwdGhhBsHhQPhyLlW7Bz/Rs2HjSlwOw84PADj1LPxc64V88gGZjSHTFOCLGF3sQYbOoIBWLWQ8BgWCHt1Nm9HvReJ62iCN1FX4NDuIyNleE6erAY1L1oJ2+iQMB+HD8/vnANhkfzXBmYE/4TIoN11nPUYSxRuEUtq02/oPQUsm1N1fl5sDxhfw9jouHLYPnfn53TkHU6QZ/frRiQuFOlbtlhl5rHJNugUS5EoFERZK3vzZWofvQeYneYeuszY3Wqa6cRI33QJ2Q0OiZ1AVzUPqsP/LYds1lW2spC7JNWNo3whS8e/39YuDc4qkjJbypwKLuvfDJlxDxlYW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(26005)(6506007)(6512007)(9686003)(8936002)(38100700002)(8676002)(186003)(66476007)(66556008)(66946007)(4326008)(316002)(110136005)(54906003)(478600001)(86362001)(6486002)(6666004)(41300700001)(82960400001)(83380400001)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oyicPEUHVtKeiAkcjVOQqrDeR97kIDcKg+cOZwCMaqJkR5ivJfBMXHvVEzbl?=
 =?us-ascii?Q?LZppl7AmRqdfZgvlB1xEAR74VITKOOQjw5i9HGlzXW4HxDcVoRmcoJbwU7tC?=
 =?us-ascii?Q?ZoTBLLpNFiKL05txAaghUbAqdSonXqvO4lV9t/YkHNU148nzY2iHMoI1yDpV?=
 =?us-ascii?Q?/KsTFuFjbt/papmnR7OBsZyoO2xEz4Wksm7BiLhwVx6/06Bg14O3tqp/sAxV?=
 =?us-ascii?Q?4oizEKZGUyqXHd7eY3VtLJOY/LSgDWr1nbeYEzAPAq7Jwq+w/N/iqfHlpgJm?=
 =?us-ascii?Q?378/eBKMMUGZbxLGIZ5tvP/bEx/+NYW1H2afZ55sPQWZGN3uPWmy5mF5KeOR?=
 =?us-ascii?Q?MM7IqSqVGM6gEa2iODgfov4FRb27hUN41H5EGNfPPA0bWdWojb2/4+ae+Tj2?=
 =?us-ascii?Q?4loC6+eRBIMVdaUtRofXJSq6LbLdXjQficKCmjxtnGczAUFlFFk4zcD+9BUQ?=
 =?us-ascii?Q?E4BhWK5qvMoo5cPFb8mltNIq/15MVbTj9y/Ktir37p26EHcUWJf2Os7cT+B5?=
 =?us-ascii?Q?Iw8xh7+N7NgYoLHHubj6EWX4WNUIDZo7a/tg03R4BFEYns8/lq6etvOKxgkI?=
 =?us-ascii?Q?IAVbXcHefs10ItA8nc7ZTEoQinbqz43/Jyqp4XhKJXKefTuaH/YFTS25iXqE?=
 =?us-ascii?Q?IgP2eOI7uw5r5TKYCzxHa/6P+Yv7s7+ZVZNVtIaR7gy4a6UjssPlJRwp1Btg?=
 =?us-ascii?Q?JVJc1ce+6CbTIpgpG/2Z16/QEI7eVAfp7KoOBsy0yyCQs21CnLKibDfovk1n?=
 =?us-ascii?Q?vk/JHNZe7GJE+m4yLpl0ktK+qe0iYdEnOC8WP9+crhcMVzhwXQy8MS/aCFz1?=
 =?us-ascii?Q?zhztIG73hRj2AFMTxrKkUHN1B6/R+NUW8Dg6Pw8OaqBu4HoxDgb6wGv1Au/O?=
 =?us-ascii?Q?ZOSwt52KEUzdPXpD6YAs6nYALv2QJVMJPsbNniTsmhy1lZYxPclv692vvd66?=
 =?us-ascii?Q?X922+/+5Gp1BjxQiXhqvR8cpf7wOdBqyb8/0i/UCMCGo8XNHRlhmlhDjgFmF?=
 =?us-ascii?Q?a4/NOmhnXXc3qpjvdUscjriXJmtyzjvoNUgDgSKUtOQtVUTEgvvF2lcsGS+3?=
 =?us-ascii?Q?zj0QJmrG6bni0txtrFgd6qckvJ5aOeBV5WspfjbWI2b90zpuRN3XGrFUa23I?=
 =?us-ascii?Q?Ru3+ZFMjY9u7QMHncR+ku8qlJ5KfNKjFuZPkbPLl16vqNlimRA7Jkfme7jCb?=
 =?us-ascii?Q?alj88I1+e0OEi1f+36OfHpvOE8/+VKOtYhNGyUpPEyf0sEQp57j7/GaVgZxw?=
 =?us-ascii?Q?DU44KicFRA7MXIhwqabDY65ZkT51dpUZputRZHqh2qbLkRm3SHeeQNm2jxXh?=
 =?us-ascii?Q?ue59nFHW/Dy99Gow9YCH6e2ECwg4Vxw6qRhbSLsGWIQ6H0G+eovP/zHar+Ri?=
 =?us-ascii?Q?P7GJPGRcvAfT/SEphDHLByXQBCV2Dam9Fvw8u9rEmxCSRUk8q+ulhWkr5ySY?=
 =?us-ascii?Q?oPX2LpPTaxMp0bcHm7vqy097XshoRUaNoOy3IFj+2bV/Tk2SvS1GrwcIZYyk?=
 =?us-ascii?Q?nAi3gQIsU1tZ5QbZM8JrWwJ1956vmDN3dzCykYbklGaWnLP7VwgQm84ck9J5?=
 =?us-ascii?Q?oiC1KjM3Ikfuo+7w/PsEvN6a2ymCb5jfpv7foFiG+6GWE38h65HQ/LUXj2x2?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 834b7d54-a82b-4938-fc77-08db43799eb8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 21:36:23.9966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlJlLwOYBtZo8+Opai7popjdbFBhfNQEma5UNNra3SkvpLXu4PWVEFPYXwLIzkXQk18FYyXLJMERvrHlga3e8+1NRucYimNZCfevSleT49w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8085
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> User space may need to know which region, if any, maps the poison
> address(es) logged in a cxl_poison trace event. Since the mapping
> of DPAs (device physical addresses) to a region can change, the
> kernel must provide this information at the time the poison list
> is read. The event informs user space that at event <timestamp>
> this <region> mapped to this <DPA>, which is poisoned.
> 
> The cxl_poison trace event is already wired up to log the region
> name and uuid if it receives param 'struct cxl_region'.
> 
> In order to provide that cxl_region, add another method for gathering
> poison - by committed endpoint decoder mappings. This method is only
> available with CONFIG_CXL_REGION and is only used if a region actually
> maps the memdev where poison is being read. After the region driver
> reads the poison list for all the mapped resources, poison is read for
> any remaining unmapped resources.
> 
> The default method remains: read the poison by memdev resource.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/core.h   |   5 ++
>  drivers/cxl/core/memdev.c |  13 +++-
>  drivers/cxl/core/region.c | 124 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 141 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index e888e293943e..deb5f87d6d0a 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -25,7 +25,12 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
>  #define CXL_DAX_REGION_TYPE(x) (&cxl_dax_region_type)
>  int cxl_region_init(void);
>  void cxl_region_exit(void);
> +int cxl_get_poison_by_endpoint(struct cxl_port *port);
>  #else
> +static inline int cxl_get_poison_by_endpoint(struct cxl_port *port)
> +{
> +	return 0;
> +}
>  static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  {
>  }
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 71f5ec6ba6c1..8db7f220f182 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -136,13 +136,24 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  
>  int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  {
> +	struct cxl_port *port;
>  	int rc;
>  
> +	port = dev_get_drvdata(&cxlmd->dev);
> +	if (!port || !is_cxl_endpoint(port))
> +		return -EINVAL;
> +
>  	rc = down_read_interruptible(&cxl_dpa_rwsem);
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_get_poison_by_memdev(cxlmd);
> +	if (port->commit_end == -1) {
> +		/* No regions mapped to this memdev */
> +		rc = cxl_get_poison_by_memdev(cxlmd);
> +	} else {
> +		/* Regions mapped, collect poison by endpoint */
> +		rc =  cxl_get_poison_by_endpoint(port);
> +	}
>  	up_read(&cxl_dpa_rwsem);
>  
>  	return rc;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f29028148806..5f1c8ce9d956 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2213,6 +2213,130 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, CXL);
>  
> +struct cxl_poison_context {
> +	struct cxl_port *port;
> +	enum cxl_decoder_mode mode;
> +	u64 offset;
> +};
> +
> +static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
> +				   struct cxl_poison_context *ctx)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	u64 offset, length;
> +	int rc = 0;
> +
> +	/*
> +	 * Collect poison for the remaining unmapped resources
> +	 * after poison is collected by committed endpoints.
> +	 *
> +	 * Knowing that PMEM must always follow RAM, get poison
> +	 * for unmapped resources based on the last decoder's mode:
> +	 *	ram: scan remains of ram range, then any pmem range
> +	 *	pmem: scan remains of pmem range
> +	 */
> +
> +	if (ctx->mode == CXL_DECODER_RAM) {
> +		offset = ctx->offset;
> +		length = resource_size(&cxlds->ram_res) - offset;
> +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +		if (rc == -EFAULT)
> +			rc = 0;
> +		if (rc)
> +			return rc;
> +	}
> +	if (ctx->mode == CXL_DECODER_PMEM) {
> +		offset = ctx->offset;
> +		length = resource_size(&cxlds->dpa_res) - offset;
> +		if (!length)
> +			return 0;
> +	} else if (resource_size(&cxlds->pmem_res)) {
> +		offset = cxlds->pmem_res.start;
> +		length = resource_size(&cxlds->pmem_res);
> +	} else {
> +		return 0;
> +	}
> +
> +	return cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +}
> +
> +static int  poison_by_decoder(struct device *dev, void *arg)

Looks like an extra space snuck in there, I can fix that up on applying.

> +{
> +	struct cxl_poison_context *ctx = arg;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_memdev *cxlmd;
> +	u64 offset, length;
> +	int rc = 0;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return rc;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> +		return rc;
> +
> +	/*
> +	 * Regions are only created with single mode decoders: pmem or ram.
> +	 * Linux does not support mixed mode decoders. This means that
> +	 * reading poison per endpoint decoder adheres to the requirement
> +	 * that poison reads of pmem and ram must be separated.
> +	 * CXL 3.0 Spec 8.2.9.8.4.1
> +	 */
> +	if (cxled->mode == CXL_DECODER_MIXED) {
> +		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
> +		return rc;
> +	}
> +
> +	cxlmd = cxled_to_memdev(cxled);
> +	if (cxled->skip) {
> +		offset = cxled->dpa_res->start - cxled->skip;
> +		length = cxled->skip;
> +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> +			rc = 0;
> +		if (rc)
> +			return rc;
> +	}
> +
> +	offset = cxled->dpa_res->start;
> +	length = cxled->dpa_res->end - offset + 1;
> +	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> +	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> +		rc = 0;
> +	if (rc)
> +		return rc;
> +
> +	/* Iterate until commit_end is reached */
> +	if (cxled->cxld.id == ctx->port->commit_end) {
> +		ctx->offset = cxled->dpa_res->end + 1;
> +		ctx->mode = cxled->mode;
> +		rc = 1;

I think a "return 1" is appropriate here with a "return 0" below, I can
also fix that up on applying.

> +	}
> +
> +	return rc;
> +}
> +
> +int cxl_get_poison_by_endpoint(struct cxl_port *port)
> +{
> +	struct cxl_poison_context ctx;
> +	int rc = 0;
> +
> +	rc = down_read_interruptible(&cxl_region_rwsem);
> +	if (rc)
> +		return rc;
> +
> +	ctx = (struct cxl_poison_context) {
> +		.port = port
> +	};
> +
> +	rc = device_for_each_child(&port->dev, &ctx, poison_by_decoder);
> +	if (rc == 1)
> +		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport), &ctx);
> +
> +	up_read(&cxl_region_rwsem);
> +	return rc;
> +}
> +
>  static struct lock_class_key cxl_pmem_region_key;
>  
>  static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
> -- 
> 2.37.3
> 


