Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC826C77B7A
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 15:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjERPpy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 11:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjERPpx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 11:45:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F688119
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684424752; x=1715960752;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ayxvu1MKzr1iI3eUCKXAEnKsoOSWi0xeynqUKSScPgA=;
  b=OKm1P5qZ8TwEhIKOhCn5/KWUb40Xe0zrcf1QTtFsO3Y1zUFJH8M8dIE8
   s69NTu2zwZbe00TfVz56WiR9FGExp4x6SfOA8VvN9F2FrG4eJmU7L+Mok
   7lJfXnE/IpuXNaq57tbTNRTGUqqJ4YCnSPfQlHPCWK4eLzFUlljkn/OhH
   5Cy/oVjOy7QnADexP8DPR7ST+b+IN2iqVbe8tz25TjQ287lJgAG4ZD7BK
   jIJbxPWACM5UZpyc7TH4M8Aq4iwuIsxZnDTdKm4xREsITNwMSGdmwwGmo
   Ty3PO2O5W/BH024K+5QpRcxc/SZiJoDcGQBJkC26oeqaW/jYM5llxUh0B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336688730"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="336688730"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 08:45:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="846542559"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="846542559"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 18 May 2023 08:45:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 08:45:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 08:45:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 08:45:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USjIyPqlu4mldkYa2guHaswwxEGsq/Yka3XXGLqXBdvlaQNP5WliFpS/j73/y/XY8gh/vNI116da+1FJ/Kmrwm8+LMeIwT5M3VRMHdBrJQXBw24g9IQW6f2sLcqiSYyoZRKwAovqGCU1V+Pldcg+YJY2Tkv+SYcIVTSPCQqzxwcb0Ce5EX86RaBnBi9OnLK1WPueQyO6Aih5F4RMuUf4IhF35l/X8H9zor1Nwk5qDNoPF+FHh8B98RplxT1pHTG0mMLjXLBtLAmyow48XZqqL1T2/DO2sey2FWhSSSEGFr1GhiqGd0mFO4gyuzPXFYbNtfUtPeotB3D7NwF4gtmIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGUEY36f3oWphp0A552FHSxcNrRfI3ayiZYioU2wTNc=;
 b=Pp2+wADJ7HH6v/IL2pp5e+l1B+X8rCSWbCVP/xHjHDv2cAHrAJi28cA52tCb9dlZg6kyBE5kC2HlfICbLLPQj6GH8SzOCXkd3etornAoeONHOM56hjYuQlSLFoHsg5yn5lW5h54GJwbqZG6w982mPoWpbxP4QWzP61gBne89RFO7TZiDfD+u5VxKPDj1/xSwJ9nSaGBalphS/jCnppnWKVIL3rBvQNPXzxq+D7OnUmmspxP+a3RXD8VNodpAGFFNKxoo1dfIVsJRKBqnc/H+DK+hB0YlN8ORSNDZvNhoPz8EkmMGpZUgEGT2t+7oQhZP2dmo6NEk6SR6mVr/Z16p2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6528.namprd11.prod.outlook.com (2603:10b6:8:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 15:45:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 15:45:41 +0000
Date:   Thu, 18 May 2023 08:45:38 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: RE: [PATCH 3/3] cxl: Move read_cdat_data() to after media is ready
Message-ID: <64664822c3c97_163ae29449@dwillia2-xfh.jf.intel.com.notmuch>
References: <168428284429.2205351.8883627879572769367.stgit@djiang5-mobl3>
 <168428297113.2205351.16197713607932380832.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168428297113.2205351.16197713607932380832.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a78e6a2-d3a0-4da5-f1ab-08db57b6ef04
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EnpbnCK2ydlUP1Y2AOWzV02f2Vp9VpfjFjverRiyl0r3Rp5SWY/qPPmAtGQTmtT/VLO6TXP8t8ACKjjW6amai+65/zO6eyxGQRb2phUEId0nA1QDsT+GA26U2TO0tuBgUQ+ICoTem26Dk8f4ACqAMn/cXyFGI35fi+S25Sy/axIGnfTBM+Ujul8IPRE4bybY+PXNqG/7J0dvIV1oz5Im56OGnJt02jONayATb0mRGn9AJLXvHQzG2oZ7WkNIX6NZ8G7FT8yKYqce/9GM0CTuRYBzjH1taiBcMh1pLGv9oYHu1o+WnP7EWlcAuhF3LnliX7Aszf6JqyASFeBfHpt0noe/I/0Vd3jjtFDKIMokpCCer1N5EmTvYbElOuaEAN4ZhGly0jhCd2r/jntbOM7ZlFo59W/VjCYaqh9pQenbG1PGoZQ8AYW2ybjoDBxcVjFHEQbf31bt4vGmb1IjMFgAEA81skEg9zmtWo5aPZSDZIi4EU6Sz+cxjAWbKTBc8a+7MVZL4sVzYoaDxe8BMthlSYwE1J4MZFqYzI+UBVZKjG81KEXLBidZ6Vhv/l4Gepet
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(83380400001)(26005)(186003)(107886003)(6506007)(6512007)(9686003)(6666004)(6486002)(316002)(4326008)(2906002)(66476007)(66556008)(82960400001)(66946007)(38100700002)(8936002)(8676002)(86362001)(5660300002)(41300700001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cgoiOng4TJ9iZ37LJchtECET0pVBe8az9pJFvtyAgPr8m0wO67FeHBH7surS?=
 =?us-ascii?Q?FKriztSUwjiyTmcFBXE/zf+yY49/54gz+A7qtNgcd4t8EMKPbNOxSWJH1WMu?=
 =?us-ascii?Q?f+ndyZPgXIsZMP2BfNGFgCqwT56afzwLYcpVtvHRv1gmllKcPXDJAa9OH00d?=
 =?us-ascii?Q?oSWCn8lcok/eviiBVQFVrmJlCoVkVtf6O4jeqncZrwArwPdJn2bqKS03NFmg?=
 =?us-ascii?Q?ji5d4K+44lokIlvkCXPm6WfJVtf3n3ZaBWJQxinM5iFNJBls3ZMvCI1NbrJI?=
 =?us-ascii?Q?+GtsOTCk7UbX87s2iFC3NGbIQ8PznXEbah+BONFQa480HrSYmg4id6VlUyzM?=
 =?us-ascii?Q?kNKLdI2xGlCxj8/xvT4j0X4P9BJ6PO2UIvFM4HkL6WyjXHv8NVCT772opY1l?=
 =?us-ascii?Q?a1llx0YI1znak+BS6Gk56VlCMur6WqhCqIs1mPGXUJW/upfVFss7/6sLRXAv?=
 =?us-ascii?Q?6+JKvWyzzEMZTz4pb0PzbR60vqqOjxdhi9VSujYdZBMF2mEvfkTYGdL4KLJV?=
 =?us-ascii?Q?aBx1IV9w7tphgCFIVJNq9JFoSGxVcu1mj22WA9fPmJxlu7GIuJ2BUxzccZh/?=
 =?us-ascii?Q?UQ4GpotRZ0/XrGZqcycpz+TBSjdex6evwEbUTWLFhum08x4VNQrqjZYABzX5?=
 =?us-ascii?Q?BHllgPwmB8vO87TDjth1qF/Mij7EgIo4Ko3GUZrvf7C/no5s+c5STimh0WHO?=
 =?us-ascii?Q?LCGn+XhYZNWy6C4HNzumVnYK8ut8kV02dv1fAyaIOJ0znVWLBMC2T8hQrpyG?=
 =?us-ascii?Q?95YocGX/dboIzjAoeOov1OgMGIcTjk/bley4sYRDDD8Vu6qFn47oUORxpYnG?=
 =?us-ascii?Q?UR+t8P8QX29h68QQfpE9v5Dc/sd9sKoCGleeT9/ODVMbo5PfLxL9ALoUqA9Z?=
 =?us-ascii?Q?2IV3NTricXyCNQ1p6xk4ut29iRtsHUIXgApoc5Fig4uE1PtZtY0ECP/KttYQ?=
 =?us-ascii?Q?yYvyUgUMWXWit89Ikg4kz2qZe8HGo5KJduK61PH5RDqVBXGJBg64srTatUre?=
 =?us-ascii?Q?xj0YRpVMKchIXyFzPztGUAtMLzR4X8uMHZm6KufTba5ADsUf/69FQS/e3OuW?=
 =?us-ascii?Q?Y/dkWS9n517HKNCCv3MbgSuBuBc5TQkO8vOWaAGYoV655zriK4u42uE+WxDH?=
 =?us-ascii?Q?FcUOqyM5l4Az5h8MVketY0iA+auJLpGPYxHc8KnVFKmmhHTBMuYfop0TI9zB?=
 =?us-ascii?Q?9jcvlTx2I2tJM7UzJZILWp4xYwPmNrEiBkRkhU2GzB3a94R7/DiZs2h3b3RE?=
 =?us-ascii?Q?Ob/yrKZ/IDjnSK8DBGkGRayJhVSvHdAh2Y66UaSaUzqxpetDGsoiKkfvO0fA?=
 =?us-ascii?Q?O00bGB0HHqBBCz24CCtHglkIRaRUe/d4OSoLTzeN3OMsk6qf339WILgAfpgD?=
 =?us-ascii?Q?AQp61f0mBP8g+WlNxGdFDlax0AziC3/OylsrO2ogj9W3JrDGjC50I5UOlpEl?=
 =?us-ascii?Q?CJTYVnY7n2Xeds/HOZ8ROwSa6FavM1PrOGbVaPzoXh58kMh2qvDFGkuTkjxc?=
 =?us-ascii?Q?gjKrRfSdOfe3Y08HXOMR1QT2hmP+Ke2Ji1av/cAM17kXYEQ9GCL+Jv3RE/eG?=
 =?us-ascii?Q?sUhfWFGEBXlmdkb9WcfaXLtENc847KI7N1m9cvksKpKZV095YI7ji0hFmYf6?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a78e6a2-d3a0-4da5-f1ab-08db57b6ef04
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 15:45:41.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvY0zuhiFO44pr14IK54M34WTvxa7PE5Ez5RbHOFXySn38gFbuaunSYwdd/TtMu7abk92QmKAiYkOL3B2YaggctXBdztH2FJwapMO1byqGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6528
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> CDAT data is only valid after the media is ready. Move read_cdat_data() to
> after cxl_await_media_read() is successful.

s/cxl_await_media_read()/cxl_await_media_ready()/

> Fixes: 32ce3f185bbb ("cxl/port: Split endpoint and switch port probe")

No, c97006046c79 ("cxl/port: Read CDAT table")

...but I think because of the realization of where await-media-ready
needs to move to make sure that basic capacity information is settled relative
to when the attributes become visible. This call can stay where its at
and assume that the port would not have been registered unless someone
up the stack had successfully probed for capacity.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/port.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 40e7b7de8bf6..bebc297fde5c 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -96,9 +96,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (IS_ERR(cxlhdm))
>  		return PTR_ERR(cxlhdm);
>  
> -	/* Cache the data early to ensure is_visible() works */
> -	read_cdat_data(port);
> -
>  	get_device(&cxlmd->dev);
>  	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
>  	if (rc)
> @@ -114,6 +111,9 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  		return rc;
>  	}
>  
> +	/* Cache the data early to ensure is_visible() works */
> +	read_cdat_data(port);
> +
>  	rc = cxl_dev_state_identify(cxlds);
>  	if (rc)
>  		return rc;
> 
> 


