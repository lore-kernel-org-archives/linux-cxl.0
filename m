Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB2EC43334
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Jun 2022 00:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiFJAbh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 9 Jun 2022 20:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiFJAbg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 9 Jun 2022 20:31:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312584A3E1
        for <linux-cxl@vger.kernel.org>; Thu,  9 Jun 2022 17:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654821095; x=1686357095;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6sBgdoCZJ8p0tqLm+67Z1v/m6PMXFUdlLoi3gI+ZZJI=;
  b=kOKd6I1v4EShKd1cU1Cmw4yhDKLj76K6nZiR4ockqU7d9u4HK0yJCaTM
   Nb58GdTC/jBoW8wh+PrUsojKgfzuPM4jqcObfK0/9imQfcpvvendE/YDM
   7SUtsiBl3nk7lrRcz79LiVtlYyVfrcgIGUFDOqJdVlhCZrj9pbigXYhsP
   sDdLCndQmtg5HSLEE9zCe3cBKwq7CUoJpfaMpTYA3up/2zJ43p74Nxi3l
   wVF3Do1A7AdWxX22m6PpO8juCfq2XLCcmUOVGFRE42TmtmIV6rq48AC02
   ldCpetiXtO3bG+09Vlw+peR4MMM3VkxTUgE1LqMgFfbSdwdCnbPAghUXp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257896560"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="257896560"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 17:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="580824487"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 09 Jun 2022 17:31:34 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 9 Jun 2022 17:31:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 9 Jun 2022 17:31:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 9 Jun 2022 17:31:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSFY4WVhn+sugSzL6qKzpBTCxDQdifHbEIFU6Q8QG7desseI7cu5s+q5fGvc9hfnNLB3KT1NJ1QnRxNevItDJXSzHb56gRBoDXK+wMPiDkBrAhSr6IdS9bgE5PHpdgcjWYYfY1VWpf24MWllTQqqeKaSwdBKjlB8g6MP1Py7r5jfro/H7YvJvHaI8sHVLTQeQp2RIst9x1woghPmNd5xWx62AnSDjJIIuR5kIiLuSm6WCQZI/XrhlIi3bvyNkIpslYgnJ66ovoW9t99Sm0YV0D/2D2a/70JPhGcL3OZ7c65v47KF6erV379m2iujxwSq8CqMyBjNQCmGbM4DQhFc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7FjsLhmu604w9sUdYPKwaVVHY4YqDyut3zUrqUEGkk=;
 b=WS/Ftb2znI29bhoQ8fMRIB+f4aMa5qIReaF0PEvR3QgQs7e4pJDhuLm1PaKXrecbohphVNZRCV4JCTvGHoqwbjZafaJGX6j0prMvgTzD4Qs8trAtQFq0mXoAv8S99vs4SYNpaX/gHU3PkWXPkeR51Im0ySvyj/uIVYi5zN4hATMdX/8876Vi8vP31qEOW2kolEElUxZpjTAVUdwiF9gA/De0ivAQiG8tWCY1B/qJ1k0kPMmqWMvApFXkAC43BkLlhDh373YG2WEc9kCGb/TRq6sk1DefZbdwVL438rSQsJDT8T7hOuaIFcGqAKoNynOeiSKi/TwozNWlQw9i1aXZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MN2PR11MB4240.namprd11.prod.outlook.com (2603:10b6:208:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 00:31:31 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%4]) with mapi id 15.20.5332.012; Fri, 10 Jun 2022
 00:31:31 +0000
Date:   Thu, 9 Jun 2022 17:31:18 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH] cxl: Fix cleanup of port devices on failure to probe
 driver.
Message-ID: <YqKQ1oaxP6IhB//f@iweiny-desk3>
References: <20220609134519.11668-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220609134519.11668-1-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: MW4PR04CA0274.namprd04.prod.outlook.com
 (2603:10b6:303:89::9) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ad7a3c0-a719-4189-421a-08da4a7890e4
X-MS-TrafficTypeDiagnostic: MN2PR11MB4240:EE_
X-Microsoft-Antispam-PRVS: <MN2PR11MB424057B513A78BEAAB9D828EF7A69@MN2PR11MB4240.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uaTonstlNZni2+NxB2E8PyaWJAUdhqMikWyKRXx3m+5ASzj/MlCltKxhae/zLg39CKtVWDqDcppmNffCrKvaWd3yB6dozQ+KkPwLuxJmEE06YaEl8qpPni9NTnXO/De4ulb29CO5x1c4V4XLDVJ7+H2DgDsF6Uhqo6/nvSFtkiO1X6CB0oH5adelKnniGsOGy6M62KqnqNAnTNB8nnM/enhzFarba8VNrEA5KV3+5biQjXk5JmVNSgl1HNSyoVUg3s6RoCZKR2jywvBR/VdSMb/XzpzYNybPlOaY/vZvsdUDxTUT1JLb30rEIRwFFFwPLPiXFnK47YmfNYPxlzmi4qlUEtNIqh6rKq3b2iS1x2WZgSyJSyXPh56B3pj6/tHTkE35DsLAo4cnMC7/vfVyyVJur9p1t6Lsyd8bE9kZZYMa0R2k7S7uk7kBPM2DSqWrA+JtE2QMv2gqycNnZPzKEdRUh/Nyn8To9NnyA1CWwULdC0SjwwwnmMsqTe8+0hxKG3J0K1QBPb2010vMBcoMdcaISuujpq4Gc/LrMJeLZYO1sfPmAlUhiBZI+XJa9lHJ8hg1351LmiEKGAzcgMKas4DB8kHGykqxGZTmBBlXYlZSBARmDgYYCmawX/odsSDTUskEOUSWujM2UwTEIETXhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(66556008)(66946007)(66476007)(44832011)(86362001)(6486002)(8936002)(508600001)(5660300002)(33716001)(8676002)(186003)(83380400001)(6506007)(6666004)(2906002)(38100700002)(82960400001)(6512007)(9686003)(26005)(6916009)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IqZ3Da3WcKwqApIhIcF2/oT9IOJX7GlXnyrsxD8c8iqrmVKnmzM5Kyu9HaOa?=
 =?us-ascii?Q?Bb6p/xlvseEzCz8zAw6jBajoTySYShxLXL4uqCGiZk0YzLT2TBbmXumgrnJh?=
 =?us-ascii?Q?lH6V2ALy961uibP0hdOrrHY2TCwa8t75ZqIMHECbOonAI9G1fQWwzz8279Pr?=
 =?us-ascii?Q?diqGOxM73m1OhjPCz3pngXzkQjrMfhexGGbDt7VPhmyfju+/wua5GH4PL9JT?=
 =?us-ascii?Q?6+W4VicaPioQWRTbXQu3V7+dXWDi8tXpsQA0c1Iy8AHHw171IaCpEn8dhvvO?=
 =?us-ascii?Q?PVk1DHgpmX/WS1tXQe5hOLaWFG+rhZ/fxGnTcx5sp1Ap466PaqkfHExhxf0j?=
 =?us-ascii?Q?FnSs9KNp3byJ0ygQCKCxaF/0N1FPjhvdef9ewHpL5VSRQwlErdGd4m+KVSMQ?=
 =?us-ascii?Q?5tC0SagS2AGGzCZQ+ZNZj7jJyzEpUdvpYR2uuPGkR1hTGePsmaFcjSSq5RZo?=
 =?us-ascii?Q?99ckK48wq+XTxpRcaKk+XtDvCux1OBYvywRJzf7qzgVFmV0+0iJOCkPi7gtD?=
 =?us-ascii?Q?I9/fXRiCIwdeA6Gt31F8rZXikfwdPSLtA8eNGRFAVbfzu/q0saJ+iu488aZC?=
 =?us-ascii?Q?SHhlBpcgYHwm4KMwivkzLHweitJZ4g55gbAk9ipRAKCBhufLuvekDSmmL/Zr?=
 =?us-ascii?Q?4ow8ntc7N4Ur9Y4O2z58p2YXVw04kYaX+UuW/t7n6/3xHs5l6YATJx7CaMtf?=
 =?us-ascii?Q?d8VQomJ0fEAF8V+0zvXgsDFQJ+8vNgIHGUE43K1FzY8EV1bMTCEL3/FUK1/S?=
 =?us-ascii?Q?iqisfNNOdzus0cgIaW54SxrOO1NvrmknpSDPy3JNACuAwqFLj1RfojiJgsKB?=
 =?us-ascii?Q?ijPFWYYLQPO8b7k9Vs7THGsnIP/WnKZshptTnN2sjpLdjAuUmczMBSf6i15D?=
 =?us-ascii?Q?z0WIHYUQdLAjPlUwXyE9WAkKWpOd2VM1vqODTg4ve+ts7OTDcKoh5hKU3enH?=
 =?us-ascii?Q?NpwmK+qlCdGzyZq9e4l72v3Oeg5gK1xYfvP5Ri6p5EaSTfxqoHGlGTrVn5LN?=
 =?us-ascii?Q?MV4SjOF4isxtx11yBac4p8IsqhDCMGs7R+pyJm78CF9XGUabli30sUr3QrAh?=
 =?us-ascii?Q?wKP3UiCCD75RAiC5UeFiWtO6E2KjSE6iB3DdSa4wvjthJo1wPmKVdSSW3a4E?=
 =?us-ascii?Q?BYRKtkmYMJCS+XzqCydK7+d8TgiTLutrX7H/pMwOg5Uyt+jyUXoMTQQm6Fhq?=
 =?us-ascii?Q?ZkZ96NLhl9CrBr6kFEq6vdKi2vBmdDxbAPKLiITovy12YfpYSPbgMrjOgtK3?=
 =?us-ascii?Q?qreupnkyVygzQKLBGOpxUiw4VjPkPWZVTwTasmPSug0K3iM7vslA3i1301aR?=
 =?us-ascii?Q?l8v9YNEn4DU9xlUgVjFHG8EOGDlT2nrvZApt2eQs7mXhBXF/C8z4m5YZMX6n?=
 =?us-ascii?Q?Kdxfyn86sLTi2LpwiR2WvO+nnGSpkEiViHK4O2ksVWp9XgOAT+R5PoiwMbzG?=
 =?us-ascii?Q?ldZEO/HLZD0H4eHLYRwXcupekMLUsM+mtDbH3Sf4KI8CxrUl7DquD0BMpq+O?=
 =?us-ascii?Q?NI+1V9tHO1Vl6ylsQKEuxXX2+QHowzRZCqZcyi5eUD8fOom9jPxDRjyNuuHs?=
 =?us-ascii?Q?2RFqRm84K4keQbAdFbdnaS+r4qpIcKx4cOXejsk5/JQGjFfI4h7QVKzgvRbT?=
 =?us-ascii?Q?t2A6v6NHLZpBbJPIYMSKwTMxWdmHWUCAhrAy2amzEgujIXHh/N2U4q+mj+UR?=
 =?us-ascii?Q?qy2uzJ9HjNVNH1sIWkrDwpULHMeMGyTGq2C10whbcZxAjq5OBAkMiP1PdvQY?=
 =?us-ascii?Q?cLN+ry70XtmfMRxmn8GFVfjSwk05tf8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad7a3c0-a719-4189-421a-08da4a7890e4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 00:31:31.4692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXCfprOPQPLmTZb5MIqFVXKlh95GC4Qc7cTid84SBT5G9ToNNU7zB278K/Dz6suRDMXUmvFym3yXJ0R7eoFwFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4240
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jun 09, 2022 at 02:45:19PM +0100, Jonathan Cameron wrote:
> The device is created, and then there is a check if a driver succesfully
> bound to it. In event of failing the bind (e.g. failure in cxl_port_probe())
> the device is left registered. When a bus rescan later occurs, fresh
> devices are created leading to a multiple device representing the same
> underlying hardware. Bad things may follow and at very least we have far too many
> devices.
> 
> Fix by ensuring autoremove is registered if the device create succeeds,
> but doesn't depend on sucessful binding to a driver.
> 
> Bug was observed as side effect of incorrect ownership in
> [PATCH v9 6/9] cxl/port: Read CDAT table
> but will result from any failure to in cxl_port_probe().
> 
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/mem.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index c310f1fd3db0..a979d0b484d5 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -29,6 +29,7 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_port *endpoint;
> +	int rc;
>  
>  	endpoint = devm_cxl_add_port(&parent_port->dev, &cxlmd->dev,
>  				     cxlds->component_reg_phys, parent_port);
> @@ -37,13 +38,17 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
>  
>  	dev_dbg(&cxlmd->dev, "add: %s\n", dev_name(&endpoint->dev));
>  
> +	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
> +	if (rc)
> +		return rc;
> +
>  	if (!endpoint->dev.driver) {
>  		dev_err(&cxlmd->dev, "%s failed probe\n",
>  			dev_name(&endpoint->dev));
>  		return -ENXIO;
>  	}

I wonder if this code is really required?  I think that if the suspend code in
cxl_mem_probe was reworked a bit I think this could be removed.

But for now:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

>  
> -	return cxl_endpoint_autoremove(cxlmd, endpoint);
> +	return 0;
>  }
>  
>  static void enable_suspend(void *data)
> -- 
> 2.32.0
> 
