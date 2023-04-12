Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA620C7619A
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 05:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDLF5N (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDLF5M (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Apr 2023 01:57:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587CC1FEA
        for <linux-cxl@vger.kernel.org>; Tue, 11 Apr 2023 22:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681279030; x=1712815030;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZohBXOsrMmTVC/0HDFf+o7PLg1mYf58tEs2yXyeOtLM=;
  b=Y+7oCGSotyTkaMcj3MeDDhUU/5tQqwZ6NdiemFr3Y2/eoxdcW3uvIEMv
   bLkt6CbqjGT0lIo22nUOKPQ6KC/lmecWr59HRS9UuR7trBUBcRUYQzaVo
   IIGJ1nUqKyzyAvNa04/+8kD1NJsPNcRjqEa+DBTP0AKEZFGTh8MQFjQUs
   Y5lqikOwpg04LuCQd5ccxIys9OREuk8k5iYD00MgoJJBlvQ29ULAccW7L
   fgJxmjde6J0WPIJLPW7UKdm3mg9+AadS8mUqgI4NSM+ZQZkuYasXjhRM6
   NWEeP1kEEpzLv7ZhrCmwYgjTs1MOtZF8ZXNj11+TgxoZOuwlwIDnvPadS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="323436894"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="323436894"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 22:55:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="688838337"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="688838337"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 11 Apr 2023 22:55:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 22:55:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 22:55:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 22:55:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 11 Apr 2023 22:55:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF7oXs9gBX12IMt9s9Q5IsI627VXaFqmNxH1/Q4aFp847yqFqzwmGORn6wv05ir8GHfCYG/ecgTf7HoSCryypVEt1gwm5sU4WtJVscFMatIlDVs+8r+PxDrUjhhN9zcTJJwH9QISwnMiRb2jL2KNRUHfYAwmXQ2esSktnwW/xyTXtemrWhDjAges2W/Kuz9UPY8l3KckkCVQ3QIJHL+sl3uKnE46EWrsezsyNQgOyUyLTygPPcwUxDmlkDvd4CRRw9Qyxxb7f+LsU+PUUtZi9TKvB2Vp9vYKaMtUSMB7v/mvK5PMM762IEpwTt8dsiSLJxxAnEiDD9jpFsRToJtqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwmzcdnaDy+QfbbVkk/SoqP4dB0yZoY7Mi0WoI+UJ9Y=;
 b=ejToMYUKdriVN66arRV7YWofXR7dWnfX4dHPNnz3qxMXhJ7gzAlxLrpZwqKy2hV/DB9etc83RblBCyy4sd+jjUp1T8XNdkKCa7teimZPYOl56WL/imOjuu4HOjqbQfQF9wg2P7Z+B07VWMp3xRxW7Pa3c7hkMKf6FYzac4FeZ+PI1tZniBleTA1iGz2EjClbKEWXN7nd6nnZJDxWs30p36z0TEQA1A0PqXUJGM/BIUX9xWQKMGJvGvvkX0iTRBLdSaA9PpARlpEkJSEEC4Rh/yixvuO17/1+F38ww53GARH+qa8Gw9I31vg5KAYSCDPCiGxX45l8yxz/Hy6276+N7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 05:55:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6277.035; Wed, 12 Apr 2023
 05:55:51 +0000
Date:   Tue, 11 Apr 2023 22:55:49 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v12 4/6] cxl/region: Provide region info to the
 cxl_poison trace event
Message-ID: <643647e5502ab_417e29445@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1681159309.git.alison.schofield@intel.com>
 <92a8eab0aadde1c65f57e03d1ae0160929b23921.1681159309.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <92a8eab0aadde1c65f57e03d1ae0160929b23921.1681159309.git.alison.schofield@intel.com>
X-ClientProxiedBy: BYAPR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 846aaeb9-976d-4e40-fdb2-08db3b1a9229
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIYmUXHeFOSuPqyUzZ5j08oPXrw1iuYnJpXEj3GhC3cNr/XyRx+tzlnK+4fvWUaqvi4ijJJjSIca87NKWH7PZGCvqR1GWf1qmDqcJNhIOLqwVr4vQytGjX4tWDAXpmQi4AiuL50PUBeSSNifb69a8fSLvsgdQH5TOvJnF/xjmV6ewPvroizQNYTijLOu8/rtnPll7Ilwx0fWXRm0k/Tf9Z0iMoieuAcZfzgy+wbtJUflWtbPCCR2toMtYnxE1SKUFO07V11cSbI2qrx3C9NENRJs0uHXlV/9n15dWtTQCYX2dJX4WatfFP+WOrbmqp+SJIWtYjJ4cHubbDdLAmGWExV2OOR46DS+KXBdpFeltXP6M6vkMuN5/PnuUsh0xKXrGCBqTuYxSNnmwAjSAyV4Gc7tH0quDaJzMuuD3YMx8ZO9d//DFKbdgg1O6RCPKBU533+frJ9g5A/u0W5VjhTxCC9RTSH50A4nj/5aqTXJrRgw3LP4l4Np267U3ToeLkS4n1zuhtee8CEzzdgM3TvFqbnP0pu0DbGx2Sva2neEsunLhStUW0B2701AT07Zrne0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199021)(316002)(478600001)(82960400001)(86362001)(54906003)(110136005)(4326008)(66946007)(66476007)(66556008)(38100700002)(83380400001)(6486002)(41300700001)(2906002)(186003)(26005)(6506007)(6512007)(9686003)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6wl1ZAmDVrjWCBYMe4nyqcy90ZMT5xKt5DrTDeh3VgShx5Kyl+VSV5sTf4fW?=
 =?us-ascii?Q?LmKei6XrrWQFRJrCndZvmlPlPRztwuhouSWV4qk++INeKXP7rnHOtOm0GNn2?=
 =?us-ascii?Q?ebn3/Ef4UKxyClcSoT6+CsqSLptOY5NMkf8VKLsGjgC1A5Vx1ilcyUwhIs0K?=
 =?us-ascii?Q?eLuOfxXWot6J2yHpilUtPPeJ4jnZxopyIJRYC7w+eftlSyux+EaA5Ea/40E7?=
 =?us-ascii?Q?OQd+gzFWYamcLIRIViCPCuxhBkmLnV3/sZ+h62G2BKNTd9QspJOxcGLp2aaW?=
 =?us-ascii?Q?H7ZDl0mIJ1DtDbP/aQzS+cOU++VqFG7lsSJqo6EV9/YEC2/qZPzRp0MnQ0KD?=
 =?us-ascii?Q?YKMXW+eBkFg3fd4r0xfWwIwHuE6yWJUinRPqymyJ4MTUIf779vEI+MMhVnLb?=
 =?us-ascii?Q?P2awrN3QPPOD0adEANjpDu7nw3ZQLNiGz7n1eJpEV3aT4r/JQGRE3U7ZmlwX?=
 =?us-ascii?Q?ImaktQKrMT24qVIAQbUU3khH4gHo24qYB4c2uJD2/5P8KvmZqnKtLXULj6EH?=
 =?us-ascii?Q?wpzQpFFBjnk0fWtDO3mixwC3fKXDQYensl2uDKG1lTt/OqD2/k5u1f9Ci9HE?=
 =?us-ascii?Q?xZCrV+FNGMnNrJwcug9oC1p8H+826hDKSa3pFjCCLFF0oGj2tV1YiH5jWS0k?=
 =?us-ascii?Q?/uBqk8bWO/wPIWBQ5fuB3Z6FRH9/qX8q8jfJWsWTKP6pJo/pMSDyCC7IrfPU?=
 =?us-ascii?Q?ldx1nOMlzmMFzVvV3bKWrSmE4LJKpmBM6L6/gtl+j7jZZEN9dHsGCyZpvNj9?=
 =?us-ascii?Q?s/4BrSSEpi8yFY4YB3j6R05icUQfSvTli3Mzhq+JHDKmathT6YfKDUiqjqa2?=
 =?us-ascii?Q?OLZnJ1IK3V0ZJR21AF4V7BTEVQoTHEFa5zmoP3eUyEy0D8oCNSsHq5G/nGoc?=
 =?us-ascii?Q?Zyq56i0GFRW1uEf+ByBNAPfnu2OMz/N4SI31hpFi/emI5aGq3QFTuBY2N5Sy?=
 =?us-ascii?Q?0QhgYn/taQ9g+LiZsl1FsFhHUu+5ZtZKPBJCXXdv4r9KDCZPqvr2bmlSi3im?=
 =?us-ascii?Q?fw3sE43L3289bigTVZtmlFXs0JiCfVUdhlDvi9gkkyj3zaA+nTF2a5dtQfmB?=
 =?us-ascii?Q?6CBeyWx38pUuXQfLB8OisOwluBpNnp+RwvKNsAEVSa6XyXeS3hxZglMVTvmD?=
 =?us-ascii?Q?a4CxMqh8PKX4zpMRpQktT1RpRT6inuRPGhXdeot2xT5L+ikmPs4uqKeIlVd5?=
 =?us-ascii?Q?sc1aFPUAWbCPyWmG/iIEl4rUwpY6e4z/nJLPOT29zYqSQd/E8MXx+LlN/dJ0?=
 =?us-ascii?Q?ltCCbj/fpH6f4Xb6E/Z7MQcsN4JYr7uU/KJv+9F3RAkBzsDjflzs/5SzCocE?=
 =?us-ascii?Q?wPJN3zIjGaBOzzpsqq04lm1GEPkkQ08YZeVta9e6ZU5QDeM8sPZ5b60p+XJu?=
 =?us-ascii?Q?Sb2H7+By/7RXAx9qzCCeEl97lIthnGWZwnEX7qWRYgvedxpvkDgh2heIP+pt?=
 =?us-ascii?Q?+O7bGRTCOLbMReHeMDygsuM4uPNywxHWvTUqlkYycJRMmDHK8qCa2PK3e/Cl?=
 =?us-ascii?Q?0Y2Gz1brtlicALAO9jP0eFKcch5TxAjU3gS4z5GZQfDtr3SNRrcJbw6HR59u?=
 =?us-ascii?Q?/bOhs75vJZRBUtovZ8qypn7tTBLg/ItLka+YHzCTJU98wWYedqUCfFTKxFlo?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 846aaeb9-976d-4e40-fdb2-08db3b1a9229
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 05:55:51.3423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GpMgFKq+Klt2B30skA2u1QdvisLo7bcpg5srPIWZAxi5v7A5tHAUlFv/XZ1KvwRjJHawQwhfXLfMVuKc8w2nmBXvklKw5I3A99lQIZvtzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6375
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
> reads the poison list for all the mapped resources, control returns
> to the memdev driver, where poison is read for any remaining unmapped
> resources.
> 
> Mixed mode decoders are not currently supported in Linux. Add a debug
> message to the poison request path. That will serve as an alert that
> poison list retrieval needs to add support for mixed mode.
> 
> The default method remains: read the poison by memdev resource.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/core.h   | 11 +++++++
>  drivers/cxl/core/memdev.c | 62 +++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/region.c | 63 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 135 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index e888e293943e..57bd22e01a0b 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -25,7 +25,12 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
>  #define CXL_DAX_REGION_TYPE(x) (&cxl_dax_region_type)
>  int cxl_region_init(void);
>  void cxl_region_exit(void);
> +int cxl_get_poison_by_endpoint(struct device *dev, void *data);
>  #else
> +static inline int cxl_get_poison_by_endpoint(struct device *dev, void *data)
> +{
> +	return 0;
> +}

For a public function the lack of type safety jumps out at me... more
below:

>  static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  {
>  }
> @@ -68,4 +73,10 @@ enum cxl_poison_trace_type {
>  	CXL_POISON_TRACE_LIST,
>  };
>  
> +struct cxl_trigger_poison_context {
> +	struct cxl_port *port;
> +	enum cxl_decoder_mode mode;
> +	u64 offset;
> +};
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 297d87ebaca6..f26b5b6cda10 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -106,6 +106,47 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> +static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
> +				   struct cxl_trigger_poison_context *ctx)
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
>  static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> @@ -139,14 +180,33 @@ ssize_t cxl_trigger_poison_list(struct device *dev,
>  				const char *buf, size_t len)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_trigger_poison_context ctx;
> +	struct cxl_port *port;
>  	bool trigger;
>  	ssize_t rc;
>  
>  	if (kstrtobool(buf, &trigger) || !trigger)
>  		return -EINVAL;
>  
> +	port = dev_get_drvdata(&cxlmd->dev);
> +	if (!port || !is_cxl_endpoint(port))
> +		return -EINVAL;
> +
>  	down_read(&cxl_dpa_rwsem);
> -	rc = cxl_get_poison_by_memdev(cxlmd);
> +	if (port->commit_end == -1) {
> +		/* No regions mapped to this memdev */
> +		rc = cxl_get_poison_by_memdev(cxlmd);
> +	} else {
> +		/* Regions mapped, collect poison by endpoint */
> +		ctx = (struct cxl_trigger_poison_context) {
> +			.port = port,
> +		};
> +		rc = device_for_each_child(&port->dev, &ctx,
> +					   cxl_get_poison_by_endpoint);
> +		if (rc == 1)
> +			rc = cxl_get_poison_unmapped(cxlmd, &ctx);

Ah, cxl_get_poison_by_endpoint() is a function pointer to
device_for_each_child(), that really feels like a detail that's private
to the implementation.

I would reorganize this to something like:

     if (port->commit_end == -1) {
             /* No regions mapped to this memdev */
             rc = cxl_get_poison_by_memdev(cxlmd);
     } else {
             /* Regions mapped, collect poison by endpoint */
             rc = cxl_get_poison_by_endpoint(endpoint);
     }

...and then internal to cxl_get_poison_by_endpoint() do:
	    
             ctx = (struct cxl_trigger_poison_context) {
                     .port = endpoint,
             };
             rc = device_for_each_child(&port->dev, &ctx,
                                        poison_by_decoder);
             if (rc == 1)
                     rc = cxl_get_poison_unmapped(cxlmd, &ctx);

...then the header file reads more calmly with the added type-safety.

> +	}
> +
>  	up_read(&cxl_dpa_rwsem);
>  
>  	return rc ? rc : len;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f29028148806..4c4d3a6d631d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2213,6 +2213,69 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, CXL);
>  
> +int cxl_get_poison_by_endpoint(struct device *dev, void *arg)
> +{
> +	struct cxl_trigger_poison_context *ctx = arg;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port = ctx->port;
> +	struct cxl_memdev *cxlmd;
> +	u64 offset, length;
> +	int rc = 0;
> +
> +	down_read(&cxl_region_rwsem);
> +
> +	if (!is_endpoint_decoder(dev))
> +		goto out;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> +		goto out;
> +
> +	/*
> +	 * Regions are only created with single mode decoders: pmem or ram.
> +	 * Linux does not currently support mixed mode decoders. This means
> +	 * that reading poison per endpoint decoder adheres to the spec
> +	 * requirement that poison reads of pmem and ram must be separated.
> +	 * CXL 3.0 Spec 8.2.9.8.4.1
> +	 *
> +	 * Watch for future support of mixed with a dev_dbg() msg.

This sentence can go, mixed will never* be supported.

* at least until the vendor that manages to ship such a thing comes and
  explains why the kernel needs to work around that awkwardness.

> +	 */
> +	if (cxled->mode == CXL_DECODER_MIXED) {
> +		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
> +		goto out;
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
> +			goto out;
> +	}
> +
> +	offset = cxled->dpa_res->start;
> +	length = cxled->dpa_res->end - offset + 1;
> +	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> +	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> +		rc = 0;
> +	if (rc)
> +		goto out;
> +
> +	/* Iterate until commit_end is reached */
> +	if (cxled->cxld.id == port->commit_end)
> +		rc = 1;
> +
> +	/* ctx informs the memdev driver of last read poison */
> +	ctx->mode = cxled->mode;
> +	ctx->offset = cxled->dpa_res->end + 1;
> +out:
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


