Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34523C27C76
	for <linux-cxl@archiver.kernel.org>; Wed, 25 Jan 2023 22:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjAYWRW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 25 Jan 2023 17:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbjAYWRK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 25 Jan 2023 17:17:10 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202AD5EFA1
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 14:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674685027; x=1706221027;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WRVMsFAnGETA71eRR3zbF1PB/xYOEirWFhlF/+Mxk5Q=;
  b=JLST5Rz32vLBVr6PfQxLpepJImZVMXpctB0JXlNzCuu1XGQHykmNTQdT
   zi4OCA0kOKrBvxkDj5c4VXLcbolg2Vk8JTeOFjCtoYW89TxQjCJmQu2gc
   0Q4jxKnBeNdGLQc1Ls6a792u+gRu4sSCGxgE3BCu51lLV3P1l99OLCtvi
   I5wSw503fJEgfRObvvsSeiw1lSZXm3yI6pBEKMyA0nFBYfIYZ3tsELiaV
   BFjP8SKP21rIu/B9WMYx2dXdMoc1Yt7/IwR4PhOb0sYnew5MtPogPfiZp
   j7WBG0cZj8+8FwTjHL+8KhHDqneTVM8In5cy6PyhQfj593suLIkHMFcQb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="353982055"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="353982055"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 14:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="612591774"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="612591774"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 25 Jan 2023 14:17:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 14:17:03 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 14:17:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 14:17:03 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 14:17:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKKEI2pZhzHfLaCy0Kne98WfMSWyOelqVgMpheVW+IsGOBJModm4wFCO3iNASwnTV/yNp9rGHQmw79Y2HpjVC/auFULezLNRgXqzBamY4mcxfw0IJFJNnDDo4QG25LXgfh0eS9jX7S9NdTprlCvPk0G7E5st6o8B+nscbjyrYp+i0XWvDuS+Fc/ctb9yX+YudoM49YV9y/uRf2j/+sJ7roKkI3l3de6RPgmaots1XEjzuRte/INY9D8zxkDEwmctjxG4T1JPqgZTn/plSrSBfSq04q22YJERb96FWG8nDFqVtsjj7BMZ8tqmBFpxTfcF4pwFRfb8Q54e9nRtnrvyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arg0PQMuGe+Y2kZpBBOTUdXlKtfUCIxLIo8BWxUDfYc=;
 b=bdKoxuJdtudm96TYx8Gvyo6uxN/ZH+xYXEOWBdmKho2JFf8vkSuyjwQTMRynzJz0nVmvuFxgUreu/Ud5HVcesbVMQtRuAGLdrgxf6Pdxx5fvnRF0f9uduw8OXkvg+QrzQC0iuLm/tuz2aY2MPc2MnMHKHdVOAMwvMDlvGJohJ6uhoaqwHscZHzpY1fpUyi3/SkYmTjxctax50Pj96w7M9arzkWySbfycmeSdxDlZgvRCSaxlCoo160MDdVLV2s5HkuYmZxl2zegs7hHNQM7+bQZWh3nHIe+0HueI3dXgWa8IAGzuZ3xxxscifqdYUKZzOyIi/frTO9ARn98zPHt3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4760.namprd11.prod.outlook.com (2603:10b6:208:266::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 22:16:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Wed, 25 Jan 2023
 22:16:59 +0000
Date:   Wed, 25 Jan 2023 14:16:56 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <jonathan.cameron@huawei.com>
Subject: Re: [PATCH] cxl: change 'cxl_nvb' naming to 'nv_bridge' to improve
 readability
Message-ID: <63d1aa584f7b5_3e04229451@iweiny-mobl.notmuch>
References: <167467326134.935137.4655746929377717768.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167467326134.935137.4655746929377717768.stgit@djiang5-mobl3.local>
X-ClientProxiedBy: BYAPR07CA0107.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::48) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4760:EE_
X-MS-Office365-Filtering-Correlation-Id: b1406926-d4f0-402b-10cd-08daff21e083
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVg9nd4O9AnGtWL2+2EdHUvyexy9P2nsTdXBo6DrsqQ9E0w3AQBwqV//ZQJ8bevSw4apWC6DeCYCx9fQt+45ST7yz4d7ECvn1gYC56Crf10g7wK9TEaNswVgwMS68qj5DnlcnXCYtiDzPjEffR2qKGI/+NfW4oJJNpADdtBq7zChsou79ycbTcozcnJfGij3NzOB+KX22j0yY6d/HhS1cHNiOUogZAe4FmOy9lg7xY9/YmtZjCtG5Ijf5ULy/FQpd/HwbMtTrP1o8YH4CfhqjjTUS1JUhTgjgUCgGvB3Uh64M/+ky++/JUFmM2uRxn/6SX+ZMXL/E7meQaPefjUApxHAiSa4n6eiIp3IXEpEBt4Pru35Yirg9ECdNTF3IuEdevZgiPfY1xDyTz6v2ec0O65eXBxuK41X5oTKaxGBXUMEiLHp97XULi70R2F9ejeTqBIxRn1gbZ+wHrkIsqSHoNSJwV/UCFzuU+Nriv/P9mYJLXqrZPVWVgIOv1v0gkFKvFv6k4drKBXNE7AzTXGIMXcbQm12C9/nHxpb8logRm9pNosNDDYtN1vBZ9CoBJn3WLvJQRJdWYdT/1pF5koAvF4LItFx2NPZuEMONEEDtNhIMO51/jPpZf4C85evweknKa7Et0OpWQkXkpYW7NL+tVY5ZiIyxXmqjrUiKnoYsBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199018)(38100700002)(83380400001)(26005)(82960400001)(5660300002)(30864003)(2906002)(41300700001)(86362001)(4326008)(8936002)(44832011)(316002)(6512007)(6666004)(6506007)(186003)(66476007)(8676002)(66556008)(478600001)(66946007)(966005)(6486002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cBr346KND8v/9mSZvEE8wNfJmZ8VzGgUMPI0KGnTokY79tWSpNOnT1aXiOPj?=
 =?us-ascii?Q?Vx3bjZfg9VLq31RxNr4bU8wdlfSDBM+1tZJu1C2gTSqNkuuWMtTQL90PFGR9?=
 =?us-ascii?Q?7mgjNtwl39aoiEtebH/sZ1hyzwcreGM2cX0lyyxTgFLQPaLAyO2Krd7Rezib?=
 =?us-ascii?Q?LSCYRMieGlgmyThIUJrv08IEA4awQjeiFS5GseXr6EzqIavh1G1M3eJczxCj?=
 =?us-ascii?Q?f/zzIUUO7QNQkicpEuBjEvrut7PGTK//ERoEw6bQmWTxP7FomSpXypyiItXJ?=
 =?us-ascii?Q?dwfXZApIOS3JkCn992TAoMY8odP3use/FpJtqXYcPleIv32nIEeAzsxAq2nU?=
 =?us-ascii?Q?opB6bAwzChvTG/JqXK6C10ka4g1d2OPINF2lBDD7HXyyumW6RG6kwnc+5XVG?=
 =?us-ascii?Q?V6K6H7kfoqRMywU/C6tTMrX2czmJ04LBDqPrj9IsMCFBvf3uNoblF2G2x1vb?=
 =?us-ascii?Q?ig13WEbi/dYaRBDgsfK1LpJrBrbUHAea9OH4vM5rFMFCW70/Grjy2Rfr2GFR?=
 =?us-ascii?Q?D0fpxIKjd/hDNQ7X2tZ/hSdMKDHzeqZPB2r88F+mbXG1S3mX40NhGoZVX74R?=
 =?us-ascii?Q?UTzrSgjWAT6CIjh2EMfez5DYnbDi7W+ghPduiaMLM2Z3wxPydyv/xReOLVD4?=
 =?us-ascii?Q?+CmUrdzfuPkqy9mYnSgiP3aN/TxzWxMqs6xKzKJKbmsHtwOTjcv4PQBWNmtC?=
 =?us-ascii?Q?GhmQruCTacfW02ihQAxmiKY1w2vuIB/KumYwsYmgbHq5aMltPAhlImhlCreV?=
 =?us-ascii?Q?BaRM+VESdvzlmIbtiGqM+szlXO7k5CT/v93SzonMdQehZlXH+sDZsXfIBtVT?=
 =?us-ascii?Q?h35wPTMvoh+QuOQ1feQPlfhP74fWEKCfjqJ+lTscqAmyztkw100ZSYKlKtq0?=
 =?us-ascii?Q?RQqWtuz4Kqgq1NGQYlKKXytfF96XxFfCd94p6m0wMrzWQksSDvCO7Qsk7yYU?=
 =?us-ascii?Q?erTgs8DmEQx4bgHGS712ai7aBbVK6rAGhJAATjmOzeGBzRcPebcuyhXlbtE3?=
 =?us-ascii?Q?zrtnN/x15mPieP4Osn0E7BFRSXgl4n0c9gjHlcH0Cf2PFU4gABFX4RnTIY6w?=
 =?us-ascii?Q?D8UhqikjpBb1qeZb6aIm51c0T0VJQHaykReDr9EXlyNx+nIRS8Mb+B4u93BB?=
 =?us-ascii?Q?RnVi0N619zzXroST6vKj9mlQ7MrZHmouUbKXTXwfqSXaWVNAe7qY/w4BbQVb?=
 =?us-ascii?Q?lzqZ8oX85d2/g2BnW0zJ5hdD2dDuYlYpHOOEHtV9LCInM1KQlGyL4kTIQcoU?=
 =?us-ascii?Q?kJ9U3wB84oLhbmjWCnph4LQO8GpdYvcP62/7NUVgLgnjDWqq66z9sNzQPqbT?=
 =?us-ascii?Q?NbfmrWisMO1bc3weWM9NFcuitVtERWeLVyBv58Z84Q63oOTyQ7SA4XFruqhx?=
 =?us-ascii?Q?/Nu9Y8pQdQXG1xAmTZDtMNfpGFpk2CEWwNU88PRnKOIedqDRXkFR/7O/BxrE?=
 =?us-ascii?Q?BbbWnMz45Ohq/IGDna0QneKhmhvajgV0VIg8ptO81ERl4Gc/ZTz5Pi25ucM7?=
 =?us-ascii?Q?nUFvb/RZKI61dCFQI782SCZJ18XoGMqr7hd46aImnEtIsa/c9HUyP3J+Rw8R?=
 =?us-ascii?Q?0dRaRzgX47LqMgTllzwRJtHjZ0mueq+Zf+IOjhA0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1406926-d4f0-402b-10cd-08daff21e083
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 22:16:59.4535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSd2ra/OaOSkbA+mG10eQS0RfS5UBDBBlgS2ZPsyrqd7dRqsIo636X/27wX8Zxae1rzAh5KrF41rQAU+2khqhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4760
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> In CXL code there is 'cxl_nvb' for CXL nvdimm bridge and 'cxl_nvd' for CXL
> nvdimm device. Having both in the code causes confusion with code reading.
> Change all instances of 'cxl_nvb' to 'nv_bridge' in order to improve
> readability.
> 
> https://lore.kernel.org/linux-cxl/20230124164453.000029c6@Huawei.com/T/#md44f8d931541fcfa990d8e7e30404a9d37902d9a
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/cxl/acpi.c        |   10 +++--
>  drivers/cxl/core/pmem.c   |   84 +++++++++++++++++++++++----------------------
>  drivers/cxl/core/region.c |   42 +++++++++++------------
>  drivers/cxl/cxl.h         |    4 +-
>  drivers/cxl/cxlmem.h      |    4 +-
>  drivers/cxl/pmem.c        |   28 ++++++++-------
>  6 files changed, 86 insertions(+), 86 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index ad0849af42d7..53a7a7b474f1 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -480,7 +480,7 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
>  {
>  	struct cxl_decoder *cxld;
>  	struct cxl_port *root_port = data;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge;
>  	struct device *host = root_port->dev.parent;
>  
>  	if (!is_root_decoder(match))
> @@ -490,13 +490,13 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
>  	if (!(cxld->flags & CXL_DECODER_F_PMEM))
>  		return 0;
>  
> -	cxl_nvb = devm_cxl_add_nvdimm_bridge(host, root_port);
> -	if (IS_ERR(cxl_nvb)) {
> +	nv_bridge = devm_cxl_add_nvdimm_bridge(host, root_port);
> +	if (IS_ERR(nv_bridge)) {
>  		dev_dbg(host, "failed to register pmem\n");
> -		return PTR_ERR(cxl_nvb);
> +		return PTR_ERR(nv_bridge);
>  	}
>  	dev_dbg(host, "%s: add: %s\n", dev_name(&root_port->dev),
> -		dev_name(&cxl_nvb->dev));
> +		dev_name(&nv_bridge->dev));
>  	return 1;
>  }
>  
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index f3d2169b6731..58f879e70d6e 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -25,10 +25,10 @@ static DEFINE_IDA(cxl_nvdimm_bridge_ida);
>  
>  static void cxl_nvdimm_bridge_release(struct device *dev)
>  {
> -	struct cxl_nvdimm_bridge *cxl_nvb = to_cxl_nvdimm_bridge(dev);
> +	struct cxl_nvdimm_bridge *nv_bridge = to_cxl_nvdimm_bridge(dev);
>  
> -	ida_free(&cxl_nvdimm_bridge_ida, cxl_nvb->id);
> -	kfree(cxl_nvb);
> +	ida_free(&cxl_nvdimm_bridge_ida, nv_bridge->id);
> +	kfree(nv_bridge);
>  }
>  
>  static const struct attribute_group *cxl_nvdimm_bridge_attribute_groups[] = {
> @@ -84,21 +84,21 @@ static struct lock_class_key cxl_nvdimm_bridge_key;
>  
>  static struct cxl_nvdimm_bridge *cxl_nvdimm_bridge_alloc(struct cxl_port *port)
>  {
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge;
>  	struct device *dev;
>  	int rc;
>  
> -	cxl_nvb = kzalloc(sizeof(*cxl_nvb), GFP_KERNEL);
> -	if (!cxl_nvb)
> +	nv_bridge = kzalloc(sizeof(*nv_bridge), GFP_KERNEL);
> +	if (!nv_bridge)
>  		return ERR_PTR(-ENOMEM);
>  
>  	rc = ida_alloc(&cxl_nvdimm_bridge_ida, GFP_KERNEL);
>  	if (rc < 0)
>  		goto err;
> -	cxl_nvb->id = rc;
> +	nv_bridge->id = rc;
>  
> -	dev = &cxl_nvb->dev;
> -	cxl_nvb->port = port;
> +	dev = &nv_bridge->dev;
> +	nv_bridge->port = port;
>  	device_initialize(dev);
>  	lockdep_set_class(&dev->mutex, &cxl_nvdimm_bridge_key);
>  	device_set_pm_not_required(dev);
> @@ -106,18 +106,18 @@ static struct cxl_nvdimm_bridge *cxl_nvdimm_bridge_alloc(struct cxl_port *port)
>  	dev->bus = &cxl_bus_type;
>  	dev->type = &cxl_nvdimm_bridge_type;
>  
> -	return cxl_nvb;
> +	return nv_bridge;
>  
>  err:
> -	kfree(cxl_nvb);
> +	kfree(nv_bridge);
>  	return ERR_PTR(rc);
>  }
>  
> -static void unregister_nvb(void *_cxl_nvb)
> +static void unregister_nvb(void *_nv_bridge)
>  {
> -	struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge = _nv_bridge;
>  
> -	device_unregister(&cxl_nvb->dev);
> +	device_unregister(&nv_bridge->dev);
>  }
>  
>  /**
> @@ -130,19 +130,19 @@ static void unregister_nvb(void *_cxl_nvb)
>  struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
>  						     struct cxl_port *port)
>  {
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge;
>  	struct device *dev;
>  	int rc;
>  
>  	if (!IS_ENABLED(CONFIG_CXL_PMEM))
>  		return ERR_PTR(-ENXIO);
>  
> -	cxl_nvb = cxl_nvdimm_bridge_alloc(port);
> -	if (IS_ERR(cxl_nvb))
> -		return cxl_nvb;
> +	nv_bridge = cxl_nvdimm_bridge_alloc(port);
> +	if (IS_ERR(nv_bridge))
> +		return nv_bridge;
>  
> -	dev = &cxl_nvb->dev;
> -	rc = dev_set_name(dev, "nvdimm-bridge%d", cxl_nvb->id);
> +	dev = &nv_bridge->dev;
> +	rc = dev_set_name(dev, "nvdimm-bridge%d", nv_bridge->id);
>  	if (rc)
>  		goto err;
>  
> @@ -150,11 +150,11 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
>  	if (rc)
>  		goto err;
>  
> -	rc = devm_add_action_or_reset(host, unregister_nvb, cxl_nvb);
> +	rc = devm_add_action_or_reset(host, unregister_nvb, nv_bridge);
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> -	return cxl_nvb;
> +	return nv_bridge;
>  
>  err:
>  	put_device(dev);
> @@ -197,7 +197,7 @@ EXPORT_SYMBOL_NS_GPL(to_cxl_nvdimm, CXL);
>  
>  static struct lock_class_key cxl_nvdimm_key;
>  
> -static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *cxl_nvb,
> +static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *nv_bridge,
>  					   struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_nvdimm *cxl_nvd;
> @@ -231,7 +231,7 @@ static void cxl_nvd_unregister(void *_cxl_nvd)
>  {
>  	struct cxl_nvdimm *cxl_nvd = _cxl_nvd;
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlmd->cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge = cxlmd->nv_bridge;
>  
>  	/*
>  	 * Either the bridge is in ->remove() context under the device_lock(),
> @@ -239,7 +239,7 @@ static void cxl_nvd_unregister(void *_cxl_nvd)
>  	 * for @cxl_nvd and doing it itself (while manually holding the bridge
>  	 * lock).
>  	 */
> -	device_lock_assert(&cxl_nvb->dev);
> +	device_lock_assert(&nv_bridge->dev);
>  	cxl_nvd->cxlmd = NULL;
>  	cxlmd->cxl_nvd = NULL;
>  	device_unregister(&cxl_nvd->dev);
> @@ -248,14 +248,14 @@ static void cxl_nvd_unregister(void *_cxl_nvd)
>  static void cxlmd_release_nvdimm(void *_cxlmd)
>  {
>  	struct cxl_memdev *cxlmd = _cxlmd;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlmd->cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge = cxlmd->nv_bridge;
>  
> -	device_lock(&cxl_nvb->dev);
> +	device_lock(&nv_bridge->dev);
>  	if (cxlmd->cxl_nvd)
> -		devm_release_action(&cxl_nvb->dev, cxl_nvd_unregister,
> +		devm_release_action(&nv_bridge->dev, cxl_nvd_unregister,
>  				    cxlmd->cxl_nvd);
> -	device_unlock(&cxl_nvb->dev);
> -	put_device(&cxl_nvb->dev);
> +	device_unlock(&nv_bridge->dev);
> +	put_device(&nv_bridge->dev);
>  }
>  
>  /**
> @@ -266,21 +266,21 @@ static void cxlmd_release_nvdimm(void *_cxlmd)
>   */
>  int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd)
>  {
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge;
>  	struct cxl_nvdimm *cxl_nvd;
>  	struct device *dev;
>  	int rc;
>  
> -	cxl_nvb = cxl_find_nvdimm_bridge(&cxlmd->dev);
> -	if (!cxl_nvb)
> +	nv_bridge = cxl_find_nvdimm_bridge(&cxlmd->dev);
> +	if (!nv_bridge)
>  		return -ENODEV;
>  
> -	cxl_nvd = cxl_nvdimm_alloc(cxl_nvb, cxlmd);
> +	cxl_nvd = cxl_nvdimm_alloc(nv_bridge, cxlmd);
>  	if (IS_ERR(cxl_nvd)) {
>  		rc = PTR_ERR(cxl_nvd);
>  		goto err_alloc;
>  	}
> -	cxlmd->cxl_nvb = cxl_nvb;
> +	cxlmd->nv_bridge = nv_bridge;
>  
>  	dev = &cxl_nvd->dev;
>  	rc = dev_set_name(dev, "pmem%d", cxlmd->id);
> @@ -298,26 +298,26 @@ int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd)
>  	 * the top-level PMEM bridge goes down, or the endpoint device goes
>  	 * through ->remove().
>  	 */
> -	device_lock(&cxl_nvb->dev);
> -	if (cxl_nvb->dev.driver)
> -		rc = devm_add_action_or_reset(&cxl_nvb->dev, cxl_nvd_unregister,
> +	device_lock(&nv_bridge->dev);
> +	if (nv_bridge->dev.driver)
> +		rc = devm_add_action_or_reset(&nv_bridge->dev, cxl_nvd_unregister,
>  					      cxl_nvd);
>  	else
>  		rc = -ENXIO;
> -	device_unlock(&cxl_nvb->dev);
> +	device_unlock(&nv_bridge->dev);
>  
>  	if (rc)
>  		goto err_alloc;
>  
> -	/* @cxlmd carries a reference on @cxl_nvb until cxlmd_release_nvdimm */
> +	/* @cxlmd carries a reference on @nv_bridge until cxlmd_release_nvdimm */
>  	return devm_add_action_or_reset(&cxlmd->dev, cxlmd_release_nvdimm, cxlmd);
>  
>  err:
>  	put_device(dev);
>  err_alloc:
> -	cxlmd->cxl_nvb = NULL;
> +	cxlmd->nv_bridge = NULL;
>  	cxlmd->cxl_nvd = NULL;
> -	put_device(&cxl_nvb->dev);
> +	put_device(&nv_bridge->dev);
>  
>  	return rc;
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 02f28da519e3..f03e42db7c6e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1814,7 +1814,7 @@ static struct lock_class_key cxl_pmem_region_key;
>  static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge;
>  	struct cxl_pmem_region *cxlr_pmem;
>  	struct device *dev;
>  	int i;
> @@ -1847,12 +1847,12 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
>  		 * bridge for one device is the same for all.
>  		 */
>  		if (i == 0) {
> -			cxl_nvb = cxl_find_nvdimm_bridge(&cxlmd->dev);
> -			if (!cxl_nvb) {
> +			nv_bridge = cxl_find_nvdimm_bridge(&cxlmd->dev);
> +			if (!nv_bridge) {
>  				cxlr_pmem = ERR_PTR(-ENODEV);
>  				goto out;
>  			}
> -			cxlr->cxl_nvb = cxl_nvb;
> +			cxlr->nv_bridge = nv_bridge;
>  		}
>  		m->cxlmd = cxlmd;
>  		get_device(&cxlmd->dev);
> @@ -1880,7 +1880,7 @@ static void cxlr_pmem_unregister(void *_cxlr_pmem)
>  {
>  	struct cxl_pmem_region *cxlr_pmem = _cxlr_pmem;
>  	struct cxl_region *cxlr = cxlr_pmem->cxlr;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge = cxlr->nv_bridge;
>  
>  	/*
>  	 * Either the bridge is in ->remove() context under the device_lock(),
> @@ -1888,7 +1888,7 @@ static void cxlr_pmem_unregister(void *_cxlr_pmem)
>  	 * for @cxlr_pmem and doing it itself (while manually holding the bridge
>  	 * lock).
>  	 */
> -	device_lock_assert(&cxl_nvb->dev);
> +	device_lock_assert(&nv_bridge->dev);
>  	cxlr->cxlr_pmem = NULL;
>  	cxlr_pmem->cxlr = NULL;
>  	device_unregister(&cxlr_pmem->dev);
> @@ -1897,15 +1897,15 @@ static void cxlr_pmem_unregister(void *_cxlr_pmem)
>  static void cxlr_release_nvdimm(void *_cxlr)
>  {
>  	struct cxl_region *cxlr = _cxlr;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge = cxlr->nv_bridge;
>  
> -	device_lock(&cxl_nvb->dev);
> +	device_lock(&nv_bridge->dev);
>  	if (cxlr->cxlr_pmem)
> -		devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
> +		devm_release_action(&nv_bridge->dev, cxlr_pmem_unregister,
>  				    cxlr->cxlr_pmem);
> -	device_unlock(&cxl_nvb->dev);
> -	cxlr->cxl_nvb = NULL;
> -	put_device(&cxl_nvb->dev);
> +	device_unlock(&nv_bridge->dev);
> +	cxlr->nv_bridge = NULL;
> +	put_device(&nv_bridge->dev);
>  }
>  
>  /**
> @@ -1917,14 +1917,14 @@ static void cxlr_release_nvdimm(void *_cxlr)
>  static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>  {
>  	struct cxl_pmem_region *cxlr_pmem;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge;
>  	struct device *dev;
>  	int rc;
>  
>  	cxlr_pmem = cxl_pmem_region_alloc(cxlr);
>  	if (IS_ERR(cxlr_pmem))
>  		return PTR_ERR(cxlr_pmem);
> -	cxl_nvb = cxlr->cxl_nvb;
> +	nv_bridge = cxlr->nv_bridge;
>  
>  	dev = &cxlr_pmem->dev;
>  	rc = dev_set_name(dev, "pmem_region%d", cxlr->id);
> @@ -1938,25 +1938,25 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>  	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
>  		dev_name(dev));
>  
> -	device_lock(&cxl_nvb->dev);
> -	if (cxl_nvb->dev.driver)
> -		rc = devm_add_action_or_reset(&cxl_nvb->dev,
> +	device_lock(&nv_bridge->dev);
> +	if (nv_bridge->dev.driver)
> +		rc = devm_add_action_or_reset(&nv_bridge->dev,
>  					      cxlr_pmem_unregister, cxlr_pmem);
>  	else
>  		rc = -ENXIO;
> -	device_unlock(&cxl_nvb->dev);
> +	device_unlock(&nv_bridge->dev);
>  
>  	if (rc)
>  		goto err_bridge;
>  
> -	/* @cxlr carries a reference on @cxl_nvb until cxlr_release_nvdimm */
> +	/* @cxlr carries a reference on @nv_bridge until cxlr_release_nvdimm */
>  	return devm_add_action_or_reset(&cxlr->dev, cxlr_release_nvdimm, cxlr);
>  
>  err:
>  	put_device(dev);
>  err_bridge:
> -	put_device(&cxl_nvb->dev);
> -	cxlr->cxl_nvb = NULL;
> +	put_device(&nv_bridge->dev);
> +	cxlr->nv_bridge = NULL;
>  	return rc;
>  }
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1b1cf459ac77..1a795a2ddbe3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -426,7 +426,7 @@ struct cxl_region_params {
>   * @id: This region's id. Id is globally unique across all regions
>   * @mode: Endpoint decoder allocation / access mode
>   * @type: Endpoint decoder target type
> - * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
> + * @nv_bridge: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
>   * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
>   * @flags: Region state flags
>   * @params: active + config params for the region
> @@ -436,7 +436,7 @@ struct cxl_region {
>  	int id;
>  	enum cxl_decoder_mode mode;
>  	enum cxl_decoder_type type;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge;
>  	struct cxl_pmem_region *cxlr_pmem;
>  	unsigned long flags;
>  	struct cxl_region_params params;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ab138004f644..f1322f779346 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -35,7 +35,7 @@
>   * @cdev: char dev core object for ioctl operations
>   * @cxlds: The device state backing this device
>   * @detach_work: active memdev lost a port in its ancestry
> - * @cxl_nvb: coordinate removal of @cxl_nvd if present
> + * @nv_bridge: coordinate removal of @cxl_nvd if present
>   * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
>   * @id: id number of this memdev instance.
>   */
> @@ -44,7 +44,7 @@ struct cxl_memdev {
>  	struct cdev cdev;
>  	struct cxl_dev_state *cxlds;
>  	struct work_struct detach_work;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge;
>  	struct cxl_nvdimm *cxl_nvd;
>  	int id;
>  };
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index eedefebc4283..83b454213a77 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -64,7 +64,7 @@ static int cxl_nvdimm_probe(struct device *dev)
>  {
>  	struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlmd->cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge = cxlmd->nv_bridge;
>  	unsigned long flags = 0, cmd_mask = 0;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct nvdimm *nvdimm;
> @@ -79,7 +79,7 @@ static int cxl_nvdimm_probe(struct device *dev)
>  	set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
>  	set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
>  	set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
> -	nvdimm = __nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd,
> +	nvdimm = __nvdimm_create(nv_bridge->nvdimm_bus, cxl_nvd,
>  				 cxl_dimm_attribute_groups, flags,
>  				 cmd_mask, 0, NULL, cxl_nvd->dev_id,
>  				 cxl_security_ops, NULL);
> @@ -225,32 +225,32 @@ static int cxl_pmem_ctl(struct nvdimm_bus_descriptor *nd_desc,
>  	return cxl_pmem_nvdimm_ctl(nvdimm, cmd, buf, buf_len);
>  }
>  
> -static void unregister_nvdimm_bus(void *_cxl_nvb)
> +static void unregister_nvdimm_bus(void *_nv_bridge)
>  {
> -	struct cxl_nvdimm_bridge *cxl_nvb = _cxl_nvb;
> -	struct nvdimm_bus *nvdimm_bus = cxl_nvb->nvdimm_bus;
> +	struct cxl_nvdimm_bridge *nv_bridge = _nv_bridge;
> +	struct nvdimm_bus *nvdimm_bus = nv_bridge->nvdimm_bus;
>  
> -	cxl_nvb->nvdimm_bus = NULL;
> +	nv_bridge->nvdimm_bus = NULL;
>  	nvdimm_bus_unregister(nvdimm_bus);
>  }
>  
>  static int cxl_nvdimm_bridge_probe(struct device *dev)
>  {
> -	struct cxl_nvdimm_bridge *cxl_nvb = to_cxl_nvdimm_bridge(dev);
> +	struct cxl_nvdimm_bridge *nv_bridge = to_cxl_nvdimm_bridge(dev);
>  
> -	cxl_nvb->nd_desc = (struct nvdimm_bus_descriptor) {
> +	nv_bridge->nd_desc = (struct nvdimm_bus_descriptor) {
>  		.provider_name = "CXL",
>  		.module = THIS_MODULE,
>  		.ndctl = cxl_pmem_ctl,
>  	};
>  
> -	cxl_nvb->nvdimm_bus =
> -		nvdimm_bus_register(&cxl_nvb->dev, &cxl_nvb->nd_desc);
> +	nv_bridge->nvdimm_bus =
> +		nvdimm_bus_register(&nv_bridge->dev, &nv_bridge->nd_desc);
>  
> -	if (!cxl_nvb->nvdimm_bus)
> +	if (!nv_bridge->nvdimm_bus)
>  		return -ENOMEM;
>  
> -	return devm_add_action_or_reset(dev, unregister_nvdimm_bus, cxl_nvb);
> +	return devm_add_action_or_reset(dev, unregister_nvdimm_bus, nv_bridge);
>  }
>  
>  static struct cxl_driver cxl_nvdimm_bridge_driver = {
> @@ -282,7 +282,7 @@ static int cxl_pmem_region_probe(struct device *dev)
>  	struct nd_mapping_desc mappings[CXL_DECODER_MAX_INTERLEAVE];
>  	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
>  	struct cxl_region *cxlr = cxlr_pmem->cxlr;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> +	struct cxl_nvdimm_bridge *nv_bridge = cxlr->nv_bridge;
>  	struct cxl_pmem_region_info *info = NULL;
>  	struct nd_interleave_set *nd_set;
>  	struct nd_region_desc ndr_desc;
> @@ -371,7 +371,7 @@ static int cxl_pmem_region_probe(struct device *dev)
>  	ndr_desc.nd_set = nd_set;
>  
>  	cxlr_pmem->nd_region =
> -		nvdimm_pmem_region_create(cxl_nvb->nvdimm_bus, &ndr_desc);
> +		nvdimm_pmem_region_create(nv_bridge->nvdimm_bus, &ndr_desc);
>  	if (!cxlr_pmem->nd_region) {
>  		rc = -ENOMEM;
>  		goto out_nvd;
> 
> 


