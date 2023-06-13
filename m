Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB05EB64D7
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 22:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjFMWDl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFMWDk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 18:03:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7E8186
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 15:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686693819; x=1718229819;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2jz8fMBPBpqydB5BgeNTpKg7NfTO5ezOC65DxtCM4T0=;
  b=aV+CDZZRNKHBdVkpPWT8s269Z093wr3D61BtAayk0n7NguZlebxN03JU
   rOM0Y79RKZmxX3qMQkawQNvOK29Z5ti/+ca40OrVMpw6XgP7/1df+LTT+
   QAmdJvYx9uHvnQJXNp71YUSMttv1Ie4Zk7gYKQAXd0wFVb8OZt3kWQJiK
   wnmHLESAD5G8yyGO7XyCiB/ozbJxDg5Mt7YbMO2xdpVlBWcfkGkttpstM
   yXxxOLb5BxCBFB/js/Bd3rDAHYS7HQbSpc4UgvnEZeE8KmYN8tN37nxV3
   8iedGXDQi2JeBpTcQInl7mp/4ZNvdMW1U55Zpno9DBNIyycwAgxbN87+6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="386864481"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="386864481"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 15:03:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="662155105"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="662155105"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 13 Jun 2023 15:03:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:03:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:03:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 15:03:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 15:03:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c26oUrAG73FhQzoXofGZIjZ5nRsf4WCOmTBWjOuWY3LJrr6L9COIl9Elfg6GUYKECO2AP+a5cMcQnb1fYh2O/72A5hd50qX49hefgqY8VD8uufinadU6Y6ZiFEffOK2iFJ7pobdZ088jkMXT3fT5LWsqkp1SW+bZpxXL5eFlSkgh29p+HW0PzLCyIGoZpnk/WVF61PxS9kTegh++3ZvqZ90Hm0mxxzV6Xyq9nmmS0k0PwUHp0UEt2ohF4u/v0CwtK5m/abzeWrc7tiE7FQxHKDC3JSRMKXY6lMUDl/q6GeK0NT9+3z2rGQ8i6WQZ+GP5UVY0QczkFokg8uLrW9gVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hliSyNQ6+ePl7iBmBTIuyppOyCr8CcA0Nnuy4r7Ze+g=;
 b=DY+LkEmSL0hvyCE/ZF+jQluTgvWzmqF7tr2lPYJE63mab0b6/3bWG9MzKFUwYNDNjMH+MT6EU8Isg6LCFtBxNhqDgJZ6NX+8MOF1CMre/y4w/k1pf/Pt/gteqbJp6t5Hq3KlXwYHWlxIQ2UdGhfHnbeaH2gCJqTZ0qcZVH443jwFax2fZSffl8DuYqDO2t6TjI5o1+eRaiapqFRAP1nEJ9/JtxPEtdln9jNUoHEPID3E7hUCVs2WRF2l46YEN6iu97WKMxMMJjLlr/CY/XxDhbq39gIDGJqoxKYYkjw5sODd822Z4uvm8ZEZJD5qEcWZcetoDnsN3pwsAbAPywld3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA0PR11MB4589.namprd11.prod.outlook.com (2603:10b6:806:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 22:03:36 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 22:03:36 +0000
Message-ID: <691c1be9-1a51-2b00-980f-a7c6480ef378@intel.com>
Date:   Tue, 13 Jun 2023 15:03:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 01/19] cxl/regs: Clarify when a 'struct cxl_register_map'
 is input vs output
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>, <navneet.singh@intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592150323.1948938.2728742883585170051.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168592150323.1948938.2728742883585170051.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::30) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA0PR11MB4589:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a4108a-c714-40aa-a5a7-08db6c5a08ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+Qdqq4N+2klfMQhhMwxoRcq78uVzRFNzbC4hAeuMq9CM7+Z1IfQsPBNgQDAZU2gH94FRnuy5xX2MymZMFjjD44XajDDaW4UJw5lC7h3EpPuKJGEfbiPq5NB3vN6g1Ie3Pj5/XmHtE46+DxS2OuFfdZCl6wdoQDDJrlT2ATcaCbUW2ibh+RyCysNREaqWP6uiqPOJgafbCUYkr1YTbP1+x4kn6etY6kYYCvlJgzZHVMiryy075+eyVJ1WEpoqj8/VxmRzSpMq0u4rfcZRmh+3WL3CD7t786z6PRH6yEmXCA5oCUCfiKYHvSoCP8mwVskWSo+NlavGC77ck1Ba/Pv0XlyLaAY/wRTWOFNgzelKTPUsED+Voj5P90KzuJs90CLm0sxYaczCSl603FsYM15yVQICVhhBsS+7hyDbznH8tajmPFNFEA0VhxFlb8mZ7jfWkXkC67a1VygzLp67BFiX+c7S4BEPGIWwtu8Me2KsNd9YvIaSLobUXfdowX9tmC/ZPgnGyXSgEyxibxIcFLfZirGZm9E3CBug1jmwMcnaaKU7iNHSbUnfIr0xDmrtC2WFSKUhx2ajv/OYyohW0+5rs+0oZCMOhfIKrOyGfJo0gxbyptE/vGS3SSmlwnVcG4tM0rNRJHH7Oo3x45pgXrPGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(41300700001)(6486002)(6666004)(66946007)(66556008)(2906002)(82960400001)(66476007)(38100700002)(5660300002)(8676002)(36756003)(44832011)(316002)(86362001)(31696002)(4326008)(478600001)(8936002)(2616005)(6506007)(53546011)(6512007)(107886003)(26005)(31686004)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEtnQ2M2OTAyblU2UW9WYUM4ZDVyN2dWNjQrN0FqRjFzWVlBZ1pxSHJvZUNJ?=
 =?utf-8?B?c3Y5WlBqTTh3SEdzWFZCSTFkQ1NJZkNEWktGSld1dTdaVXlGQlhHRXBtSUFW?=
 =?utf-8?B?VXExOVp3NkUvYU0wTUJTdU1UaEx6MFF1Wk1yYnhNUWs0S2t1MjZCR2NHaFhy?=
 =?utf-8?B?Nys5RXdsR0hPNGdydCtTUmRtNXVydXNKelhPNEdqakFKZUFwY0FkL1ZiTTU3?=
 =?utf-8?B?NmZDRlJKbUNlMlhpUlVvbXdSNEZsU2o1NnF2bDNtb09KbER3U25XdnkrcVll?=
 =?utf-8?B?c0oybnhhcmlkaStFUGRFSUF2d29YcjFGWncvVGhOb2MzMkdkbzV1SXBjdUxj?=
 =?utf-8?B?UVFIYmczYThoczZGRk84VlNNZUFjWlA5TEVsV2NOL09pUUN2cDk1RGJkRGlw?=
 =?utf-8?B?cTBLdGY3MTNYQVcwWGJQLzliQ2pCZFQxcGdQVkVDSEhiTFpCVmJPZzZiWXVQ?=
 =?utf-8?B?V2ZjVmVLWStSdFdQejV4NnJleVdCcDJTQVJnTGVYZFMrb1Vla2wyL01CZ2tr?=
 =?utf-8?B?N3lWdG9rQ3BkNW5ySzk5M1RIV1pLakUvelprbEdOQTUvSFFOUzF1QmV6Nktu?=
 =?utf-8?B?b3BMenB0cnA5aS90Y0FpVlB6ZkFBbGVvdnVML3ZoY05rKzA1a1dLYkFYOUl5?=
 =?utf-8?B?RGFMSjFROExoM3hVVnlBallwY0lIWmowOGlwL1ZOdUY4L1hqYk1NVVlDZTlK?=
 =?utf-8?B?SVVZZy9xWUxJVi83QkpSVkVURXVMQUxTWnpaQ2pxSXplOFM0eVpZSzB2THMw?=
 =?utf-8?B?UFBQeUQycUxKN05CaFdhYmRYTFgyWHZxWUtMQXA0U3JRMit1eDdrVG1qc2Ja?=
 =?utf-8?B?S3BkNE5OQmRyZWpGSXdoV3Bmb1J5ZFo0Z3VSdWp2ZDE4V0dwOUhVN1YzMzN5?=
 =?utf-8?B?ZWlHbFV0N1RZUGtERTlBdGRkQ0N0c2FkWUc2M3ArTU9yN1YwZ0NydVNaMDU5?=
 =?utf-8?B?d2x3UEkva0p0WlVMM2YwL1I0dHp2d1Q0eE5td3hVR0x1WEpRLzgrOWpuMWVO?=
 =?utf-8?B?NkpRNDZiclFyQ29PWm56TENaMFBXUzUxeFlnWm50enZXNTBVdldhZFUzSjhW?=
 =?utf-8?B?c1RvNWRIUTZoajdlaHNFaG9UcFNYWmJVVm5jYUVjSHcvRGo0Z3Q4UFlMK0Yx?=
 =?utf-8?B?enRHRlhaaS9UVDEwdkVZLzlubnlYc0J5MkFHdjZWSXExTXZPSzNzS0lwVUJa?=
 =?utf-8?B?UEhWOERXdVc3ZmV0UFZSa2tOVlVUd2dIdWZhU1lQRkhHWW5KdDZHMTZ6WHlk?=
 =?utf-8?B?UGZnM2lyYmZQKzhXclNtVitEVnVaWTYrNXdxVlNGZ0F6TElZd0ZsSDEzMkdx?=
 =?utf-8?B?ZHcreS9vWVVtUjE3RktURzhyT3RiUTQ1TUUraUdsOUlSSURzdnk3UlhsbUVN?=
 =?utf-8?B?YVRobG5iMTNwOGdaWFFOWk9QYXlQckc1Sm9LT0NaY3NYRisvcU9qNGFsaXFw?=
 =?utf-8?B?MWZhL2N5eTJkT1Qrb2VYR2NYUk1TdWQzSGRKckJxb3pLdzBIL1FOR0d3dlJP?=
 =?utf-8?B?MWFUMDVuUDRtN3dXSmlKLzVpVURmNlcyWnpxaU1LRVRKWW4vWWZhaFpHMEha?=
 =?utf-8?B?eSs5VU4yc096a1hTZURTQnFQQlFJRHdjdkVTaHNWdjFycm8zMEFVZkFZdzlz?=
 =?utf-8?B?RjVFY1pVYW5yVi9hMUV4a3pEQ0RMaHhCTmNCMGR6MHlGNlBwQmxyV3FEOUpm?=
 =?utf-8?B?eHpGbFpXSGNMaWpvN0RyYXFGcDFqUkwyVmluL3o0MDk4amlaVlkzMlo5aFVD?=
 =?utf-8?B?d25NNXJxb2lHNWt2SjlUY2VBclNYUSs5K3EwYzMxa2pSVmZhZFg5NXBPY1VL?=
 =?utf-8?B?K2pxVDhEWEY0WGZtemVVT2NGdndNZjhHZ3BXdXFQeEdJTnJZZ3RVRmlFUUUr?=
 =?utf-8?B?bTU0ZEt6Z0lZR2E3ZnM5dllRSDd3VE51Q2dYdFhRcjEzSGFYRFUxaGo4dGhH?=
 =?utf-8?B?Q3N5Ynhrd2FXV2V5YWFZK0xESEdTUXY5c3I1WG5GOVUwcmR1elkvWmJlTW1F?=
 =?utf-8?B?YUVqM1BhRElGblVFbks0MUV6NExaTnBSaDN6VHZLYzNRaC9QbWx2dE5kbmVw?=
 =?utf-8?B?TXVnZWhLdUZIWjlML2ZPbmpiYUV4QnBrdmxvTWtWR2xSdXFCa3dESGUzRkpu?=
 =?utf-8?Q?RzemJniYMnlbVPFdve+HfkH1W?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a4108a-c714-40aa-a5a7-08db6c5a08ea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 22:03:35.8074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p46RY6aF1pXWJJuueN7avawf44q6Qfkv/7bpq7TGyBCQ2YBdqpnBn5kax98rSgHyFk1IaM6a7LGGNh+9wAMw2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4589
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 6/4/23 16:31, Dan Williams wrote:
> The @map parameter to cxl_probe_X_registers() is filled in with the
> mapping parameters of the register block. The @map parameter to
> cxl_map_X_registers() only reads that information to perform the
> mapping. Mark @map const for cxl_map_X_registers() to clarify that it is
> only an input to those helpers.
>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>


Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/cxl/core/regs.c |    8 ++++----
>   drivers/cxl/cxl.h       |    4 ++--
>   2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 1476a0299c9b..52d1dbeda527 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -200,10 +200,10 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>   }
>   
>   int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> -			   struct cxl_register_map *map, unsigned long map_mask)
> +			   const struct cxl_register_map *map, unsigned long map_mask)
>   {
>   	struct mapinfo {
> -		struct cxl_reg_map *rmap;
> +		const struct cxl_reg_map *rmap;
>   		void __iomem **addr;
>   	} mapinfo[] = {
>   		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
> @@ -233,11 +233,11 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
>   
>   int cxl_map_device_regs(struct device *dev,
>   			struct cxl_device_regs *regs,
> -			struct cxl_register_map *map)
> +			const struct cxl_register_map *map)
>   {
>   	resource_size_t phys_addr = map->resource;
>   	struct mapinfo {
> -		struct cxl_reg_map *rmap;
> +		const struct cxl_reg_map *rmap;
>   		void __iomem **addr;
>   	} mapinfo[] = {
>   		{ &map->device_map.status, &regs->status, },
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f93a28538962..dfc94e76c7d6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -254,10 +254,10 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>   			   struct cxl_device_reg_map *map);
>   int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> -			   struct cxl_register_map *map,
> +			   const struct cxl_register_map *map,
>   			   unsigned long map_mask);
>   int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
> -			struct cxl_register_map *map);
> +			const struct cxl_register_map *map);
>   
>   enum cxl_regloc_type;
>   int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>
