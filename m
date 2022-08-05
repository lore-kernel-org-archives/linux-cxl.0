Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365FFC25B06
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 00:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiHEAXr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 4 Aug 2022 20:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiHEAXq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 4 Aug 2022 20:23:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6451C129;
        Thu,  4 Aug 2022 17:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659659025; x=1691195025;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TfKWCcbzY1FUUo5IAKOyMyESkbVfD4bRB+QYhZYThPA=;
  b=kbPj62XkpWGx3ECypHjaxLeVn3BLr04uLcZzQ9wU4Zj5zpqYPja3q/8F
   rAg7+KHlwNfJbsOW3FJXDovX7GTo7+9fYqDAE9SzBxKXlSDpuu7bp4mrO
   yGou6L31KwWIRKX4YYeNNQvyC1fl1xCryP9iv6jR7wk5LvtpuNBpmSE/M
   Y0sBH0d4R1ithPfS/a46DVVFOWT/mTO5hVbQIvBlb2/bRiNyQ3gKEHtAU
   OA9LIkha/5k2IGRV6w6wRwyoKeKU5WaK9Cwlm/FSE1XqRcen49+accz00
   51E3KmlQhvJ4154xPQn2rbf4DGHc3rk3ViRUaFK0reEJF6+YDUq8IQe18
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="269858383"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="269858383"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 17:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="636304365"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2022 17:23:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 17:23:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 17:23:44 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 4 Aug 2022 17:23:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs1Ccp0pwn75Ni8o68dHSJwMUNSPZlOsbK+p2xAKJFRQ4GZBjpJwAPsCeB5RkDsVDNJ/6auyHS0igns6NiC7oZvvSStCx4WBauC1hSDWE5mdPhVzvTMkK+9IHqb1TjASD76JLzLY21Et4H1MEmJUSHP+Iiro8d3ekYTEzF6nuE2ZuULrlH4lPNRJhRFgw9MsJR474R1stNbQazRcEa9am/yDASp9fck/wQf8dcLul9yNn1mTpCTHFjhbMretit4ibavkF4mKMsr9SHfhfl54ocWgRJU3deLvxa54kP1IuRE63DdMfLb+QTB7B/warGcFRnPMYr4FB3Xg8F/d3GTtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqOPR2pYwBCZJGzK6Xt5qkuZ85cO51kWfjbjXnLs1lI=;
 b=hDH5l+JWI13ciZDFJ0MaOBRJD7wqKDJBI6cOx5PG0dq6uYUG9YgdX7P1qZNQrhtlGCJU1OIYfl3fV3pFPal3DoKoUhx9YdrHuBmcRmsof/OBxcVyDgfMWRELIM3Z/nxhdEmXJ9FXfMH2vwihvh7K5+dwJ9T7SN3JwNujqPDnA8YLOdxJ8v+K7U5g1nJtQ0cpIVwr8Y4df6cvDPXTZPgzBENU+wnubBNZdOl/VI1TR8HVZ5n6V1wTWh9VpRaD3nZaPQARby1uQ5w33f+n+R2F+BIL4TB10IcG/TeDSLQ4rN+egNZtiVujO4K0tGbZESTKzYY8T6JeYdh2yPFLAkW52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH0PR11MB4952.namprd11.prod.outlook.com
 (2603:10b6:510:40::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 00:23:29 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.014; Fri, 5 Aug 2022
 00:23:28 +0000
Date:   Thu, 4 Aug 2022 17:23:25 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] cxl/region: Fix IS_ERR() vs NULL check
Message-ID: <62ec62fd5812a_12f2222944c@dwillia2-xfh.jf.intel.com.notmuch>
References: <Yuo65lq2WtfdGJ0X@kili>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yuo65lq2WtfdGJ0X@kili>
X-ClientProxiedBy: BY5PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:180::41) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a012d38-b799-49e8-9114-08da7678b7d5
X-MS-TrafficTypeDiagnostic: PH0PR11MB4952:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3O7SbuCsPpbIqirDx+FcIa8LdX4qjqNLdq0dKnMgHyKxY/wJh0PajvH5XUCZWygdwCHnK1jvttnr8c9mz6yXZqq1S4HgnfobEmKx0cRXyMTAx89Q7pMfuKhx1NYmbX1Fc40l9AhXL8T5ht3f5GoEv7HU30qlWGwcSidpgqHpAnYmx89/mOg6axgJ6XjCV8tr0kj9snsFrjk3FSzpH2uwBY/0H5UzgoCrcQcm/lecGiPD5AqWuELDaGEUmrZnmAxtQ2qtmwdNymr3+BGNm909Nsmpgv47i6x0L3Noi55JERrLGXKtQw3jsTIckQM3kiM0NJ0YU+jTI3yQpNrazNqMc4ydkKBzGw0iKU+VcXZWdpn62cLnFv/icxfVpIbWfbPepiWfIod9R1FNpLEMIu4v0J4l8pXQvAofrqZIEwdeXz8A+VK3Egh80qGZIUq/zP9s6MsbXLfAZFVjgMBc1ot8ZSfEHJfDEiZifFHIP7GCrr4On+Jhbq/S5Ems+I+1PuQlKGx87Fv31aLSjXQ4QL3Q5RQq/qhSjpj1IlCFgIy2hq/MWVDBaH2bJd+e9sD2dn978VwKu/ydkU0BhgTd8dePyP6E52P3oLWbNOK0nHiWDoIp17xvorwrVl795QZX7GiM3omIzEPXTRwQ4RKqwJWYIPa2gQoAQWvXP06T6KnhuvS61kfnZygVtnkuRM/erR21rP/NP5yDTreQDwOkAAtMHj91eEiIo+PYU9fZ/9MBbRLoIa/Idn8nW6d27SsxCQr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(346002)(136003)(396003)(2906002)(4744005)(5660300002)(41300700001)(6666004)(186003)(82960400001)(38100700002)(6506007)(26005)(6512007)(9686003)(54906003)(110136005)(478600001)(6486002)(316002)(8936002)(83380400001)(86362001)(66476007)(66556008)(4326008)(66946007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u9ppfJDVSP+2li03h9rmyhYKpObOcIjr4d5/qZpzf2bMRKtN9vSIKbmGDqHW?=
 =?us-ascii?Q?oc50tr4wscT2qVJf0JvGpbQ80Cn8vUZY2Q3PvjUL3oKz2z1evSSTpu98mKbM?=
 =?us-ascii?Q?JRkMMkEyOfDQXtV3KroCqYxleXCmiTy+kAcwQhexobx1lKfK7dqRGB5gMFu/?=
 =?us-ascii?Q?16Wbhz+hxOhdgZEDoqF4xLdicamjnPop6M/WNOHs6bHpCWpitXSdKhwM7ktq?=
 =?us-ascii?Q?NHyEpN3rXXQrO0RThWMmsW3f8Z6Xs3RJpjvmZF+bpbOzuCv71lK72naDc6Bf?=
 =?us-ascii?Q?ex78MbEacou1IAeLkqxLDTCCfsAFy3l/e7aWJwQcdgiBYFl9PieVxj2SwmNB?=
 =?us-ascii?Q?vl6Mcp2zRfAlL2G7Omq2ZxYZ78HOxJm5zAnSGt+h0H2KqcjKiX83ke36kc3D?=
 =?us-ascii?Q?nBrtpegXU5tHsDaViN+HGPKG4o7mhAEn5bHfqck/LNTmL4697S3ehQ8VOkTU?=
 =?us-ascii?Q?h3FWyzfRUkM6Y0vdPbU6spfP0p07y6mdq8lXAeAXTFnudOHmMEYlGysTjC8q?=
 =?us-ascii?Q?X4UtTiEURek/lABmgrd/65vaAjnphIIW1sWsmiiRL4xajSP6vY3N/i8XMIfM?=
 =?us-ascii?Q?beNiWaIglOju121O48PNXj4dVvoVQ6cXrTVUkgpyEdwdBUr9ipmJBLIZMPqb?=
 =?us-ascii?Q?GBJXq7j4uyFw24mEUj7HaGebQn/2mZN912yrjkZTkKxnZNAeoVOBiMgKTUXY?=
 =?us-ascii?Q?O/QV9YAK2j7lf4G8aN1i2QL6JXS6fNTsJ+ySHIbPWbSDppCI6LtzRw6Wzdv1?=
 =?us-ascii?Q?1Tv+XadhwENsuYnqaoBjOh0yALy1NcMKgsqvhuSIk2mEh8vfuAKgY+14AUlN?=
 =?us-ascii?Q?TqhdVpcbLJtiqdb30vmeapXob3Kl2Tyl0AyFexp4jC2YnKK6lWN8NLrQhoUU?=
 =?us-ascii?Q?fDmKZmqay1E0eo4mMQOp/RupqChEwyIgwvhs1UL0/ZQVnlhZNhd5Zo1oIN6R?=
 =?us-ascii?Q?GBGmbXBPjYdbNz7RNLjF5gesmAy74Hfwr+a1N2Hg+5gP5kH28WcUKrqnclvk?=
 =?us-ascii?Q?at/8yF22YyZa/FWEMvsl0Kaoc27rCSXvbGeuDbzrWNZUU3IukLXdJBRVzfQh?=
 =?us-ascii?Q?r7ZceC5j+ejIC9s54h1igYcOZ6wNs/BYFRGOoxlVKvSlWvCqPQl1npbgWHPp?=
 =?us-ascii?Q?F1vN5P33mw9toUXNLAQj/O9UytzTOz+gFKVNTT6LRTqGBn7iN0t+8zdqDXNW?=
 =?us-ascii?Q?LnBOFPgaSHBbAVrXXP0SvWb6PsCiBTFP46F9zkJrnpYUd+DkY2wgnltmsCFN?=
 =?us-ascii?Q?aaaHlshZsddVIQLOfNBjthHfSgzgDOBjKzeVuorHGucIw+6leQPm6pQyRXg/?=
 =?us-ascii?Q?kggCrLMZl0u5CT/6sUDrJWn8BT/98v3HKD8jJZUzkK5hMP2T/9PPd5ci+BKK?=
 =?us-ascii?Q?hn5VJ9dj/9lA3isAUKe+MKh5px9SxXyqN6LfdapTVXBSeul/hE73AJLWP5qd?=
 =?us-ascii?Q?ZKd2c6c0XKbktB5jGTtWYQSRzn55CA11Uv6dwA03qyhTH4VCRCuOneNYOVIK?=
 =?us-ascii?Q?WGF/y5jA347mSSjfJRHeF8cGcSq7ptyja9Ogux+9fgi4fwsbtOSQbBh/NzLc?=
 =?us-ascii?Q?ajzOkhPKenXGRzEoMabzZpq9Iycugwcu4EjC+DBB0G57+HZgJgXi1RrgCk76?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a012d38-b799-49e8-9114-08da7678b7d5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 00:23:28.0913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oLPLD758iim28JgMS7XPOnt+di1Q3EuuwbaVSTL3LzdJ1/IG2m44kcfDEzlubxptW50uPk5QZnQVls0aXlg1f5sxWUkS2ubRuZIpaaAGEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4952
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Carpenter wrote:
> The nvdimm_pmem_region_create() function returns NULL on error.  It does
> not return error pointers.
> 
> Fixes: 04ad63f086d1 ("cxl/region: Introduce cxl_pmem_region objects")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/cxl/pmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index e69f99a0747d..7dc0a2fa1a6b 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -525,8 +525,8 @@ static int cxl_pmem_region_probe(struct device *dev)
>  
>  	cxlr_pmem->nd_region =
>  		nvdimm_pmem_region_create(cxl_nvb->nvdimm_bus, &ndr_desc);
> -	if (IS_ERR(cxlr_pmem->nd_region)) {
> -		rc = PTR_ERR(cxlr_pmem->nd_region);
> +	if (!cxlr_pmem->nd_region) {
> +		rc = -ENOMEM;

Thanks, applied.
