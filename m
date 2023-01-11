Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79851C5479D
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Jan 2023 17:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjAKRmC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Jan 2023 12:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbjAKRlj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Jan 2023 12:41:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1754CB484
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 09:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673458836; x=1704994836;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZtfmjjAo5SFRab0GNzbkMVb5MSCmlHuGD+3CfNaxsaM=;
  b=ZgC4swozAcpE/fyoaSTqaQp+4E12GDcCRD6ZBAsOJfRWPHTJ4s5LzprP
   a/WcK5FBqhFos6PXq0uJO2rQrK/RC9gCkQcHzWOTohrGq4jMPCJxyEHTc
   aLjUT4jIU8iP1ZxFCutLuhtsa0oYjmS+5HY+1hvLn46KVlIcT/df+HZdw
   FcbfaCdNL0VeQ4decLg8PddmjkWQD4qSw2UV1w63nK8c51nVyyzopyOHh
   HtN2iWbUNeGq3i7q3nFAfVCwT4HL7LxF2et2ekdgghAOreS8s7IsC4LwS
   ri8TvgHvK/4A+eMhXOlSIQcsqLqshdMakG5j+TJiQDDn2N9ushzWaoPG7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303854248"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="303854248"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 09:38:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="781479477"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="781479477"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 11 Jan 2023 09:38:45 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 09:38:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 09:38:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 09:38:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW3dPEOj2Aa0ZHKig1hMyER4kipPrX1RqL6zwCgsQ6xExjmXImm7jpQsuZwQvKDXAsvwGeHroP5Dha2aGxZZ7XMXZQQoAHTBZLTRsXJHEENSx2xmt0lqz6xQ23aZVYLi1BRzktCRqYmFblIEW7Kpoa1gwQB6GWEyJ2juhIifanq681e8DbC0p3qhrraZL7Z6t3FEpqFf+kOg/2RJKtAhbol8ILa1KF8xCF9rYIc9StYFUkdH/gL6d7r44fYAwiN7YEa4XWKG3JJYxnfFuutVXi0SPMvYEdjc6Gbyve1eDEKquYOx1KvlpyrTG10uoCz1zYzWXnqZtVmjfnzIbOhifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwKrWjPxkJ+9+tKyDfRJwG3yiMAiX+3iU5NeFbpswg0=;
 b=buLBF/LWAd6R4nt3GWH1Z7lziKb7lYhcgcqxJuuhBEK9WY4/O9P7t75aDD8l8bvpKRQzsYC63HYLoWTABdEohSDAcC89XZuImsEIG1sOaB3y0SqU4PkKEU36+0veXqUWpgZ3D+pc3aI6jhCMDnxphFuP1/ozHqINOB9a1QGyWebgF0ecnhPymCMRnwjRMPAJ+SiPVSpIKQjPXt9YTh5NcgHgV2/Nnv/Jca7J22oVcSbYc2NTJzPrR6uiYWL+VP5MMxXcM4cH7vVQ4EFoMCY7eekjoZSDIpVkE5Wlx83JHs2TjjzNrMuh4sgOiqNR9NgfQQFiOhstrvNC7p2kpCeJtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB8173.namprd11.prod.outlook.com (2603:10b6:208:44e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 17:38:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%8]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 17:38:22 +0000
Date:   Wed, 11 Jan 2023 09:38:18 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 2/8] hw/pci-bridge/cxl_downstream: Fix type naming
 mismatch
Message-ID: <Y770Cox/LZ88FK4l@iweiny-desk3>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
 <20230111142440.24771-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230111142440.24771-3-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: ba238dca-ff84-48ca-3bd0-08daf3faa295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TP8ZGCt6pM/1qWVEGCPhEVDe2Yx7rHsz/ni9JEafLCM+vdON3lLZCCuZc0cIUNHffwpwj00hNVgSWUa6yMk9Icai6wK0BQ1Lobm9UVzkVr83m+NEeV6MBiuvfj9YndPqhSRowu723YhH4pL9mIuMogwvXMOKDLHBagKLiroSWugoZ3Lq2BcGae45SP0/vS/TP/no9zyW0dNESMd7ezdjhZEf02N/p3UrFs9sfhpErTStrcS+FvyGMtLd1cLK2daMOXgTrjrJnDemgQbL7muYV5Amp9yICs04JpbxESAhotID9v7/K7ejNoQ5RemfGufAG8x5W6B9B2o6Z9c94KSkuJtaIiy38o86gVqlHmd/HqHGHxP1dRmzjdaOO+smtoL4rM2e5FQAsAJz2o5Iu6Whx2ZJJ+VeX+OMINGv9yFhPMr9LfrkRpx4U80rhSehI4tOBpek3TmZgqyrxdz2X1SRdgHjdZOk36JcUJUJfY5xhnhtJo8Jm8+zzGOvA1aG0sVYBG1dVisT4qbv+gxwuTSwrD91vwFYl4f6iq3yXr2L5QpAJRKV2xmqrdahNLXAiqYtjsof61yojVSaA6zjM1ShBP5MvBLZKdQ6dVeCbu7cCaZQdEYpMQQlposWAazhukxF9/cM3pCIEhLPG7/Je0aYUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199015)(41300700001)(6506007)(86362001)(6666004)(83380400001)(478600001)(8676002)(33716001)(5660300002)(82960400001)(6512007)(38100700002)(6486002)(8936002)(9686003)(186003)(26005)(66946007)(6916009)(4326008)(4744005)(44832011)(2906002)(66476007)(66556008)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZdJlr9FdQndcDXPU15hWX2Z4h/Z5SANyO6OTvW7oJRaND7qpNZ4TTNtoq47u?=
 =?us-ascii?Q?/8BB9AISiEm1OidpZO6y57eRbH7KXukgkkO0aCtgwGlgeCg76NO7lifrPxdA?=
 =?us-ascii?Q?UKxVPTfMuxLxigIY/4XOA6YksBD+LiK+NGHMG1B0XtWZBlZm5SDjaaLFWGTE?=
 =?us-ascii?Q?UrYTmBuJ6ZHIRIQyXbJSlyZzchLpwqqfZcXac5qnKC7Rhy5e+2Q3dcNGE8WO?=
 =?us-ascii?Q?e9kZSlrwa0kmh1VP+oUEZOG6ElqQSaRbtN7CKtSqWR2MRVdjECiEXFAjJdvP?=
 =?us-ascii?Q?eMDA8YYsnDLQZ+A/w50DC01whkNdMG3A1eDWSU0bSM+YSFxEP06LxdQ1uN21?=
 =?us-ascii?Q?G1iuOuskNzb7HWFctfPkZ1JF+OeBEe4JOTlZAY3bA20P/Ksixk2CnQcQtcDa?=
 =?us-ascii?Q?Zh/ocmLl2aH5YtEKMC6/6Ema7SDa2MgNop7wppELRDaFcrzCQ9CHM5wrY19W?=
 =?us-ascii?Q?UFwLaF9PXnM+ejaR9HGNOhFJ/82CuI+jdGXGlsxujHWafXFZ6Y6PII3ghgvH?=
 =?us-ascii?Q?V2JR60g22dXU8pIz7jnk/rXVfCOz/VAKBRge1Xpv+bjbKrmO6oG9EVE9Fvfg?=
 =?us-ascii?Q?LIMjNzsXldp9Mi8IiemwQnZE+Tebk40NvhygatwcZrlbf7zzg9ok2lfVbi/2?=
 =?us-ascii?Q?1A1a4JUyCmyiyITO6MMXhmzNx5z0heq5kXoRzD6/VnfJG5eM2dmwqSyRkcdo?=
 =?us-ascii?Q?X8RUsdWFZgMCpk1chmIfdfm28Ib5hq1aNpVdUuqUidYc3Gk2K2xZWA6cV18N?=
 =?us-ascii?Q?YMar9mOEoZvqj02VMJSOnrAs+3fYQk0YzC4II760QSQ7lzsB70KVt1StQ1rc?=
 =?us-ascii?Q?pdJj8Jm73CZRuvENMK/VVgjDd+hM/GUtG8tNXY4T/d/Y6p2EQZUzUZpELLZm?=
 =?us-ascii?Q?52Hj3if4KIwtanMc42AhYuj/AhdI+7TlIQfpVsXO/fGzMvtdgIJMsog80mc9?=
 =?us-ascii?Q?zHDjloIqUEcSTUBnWc0jw6R/Dy709v5b4E0xuIDEkfSen70XHUg8iP8JOTHz?=
 =?us-ascii?Q?Z7czU4CyNA2sWJmG3DR1LpLF198G0J4uG1sdqjRnGTjPVPg4UYVBzzgDRPAC?=
 =?us-ascii?Q?ZVdN3g+70ttRkZrHmE1noxOl0FzLQQDUJqXrm2I7rDvfBOeX4+fp3p7yGIyi?=
 =?us-ascii?Q?viudgWQVsDnODWq9HSnEx4ZlQBmnJrPy6d9vVBDnWJkyzycgZQB7wa4HFXIT?=
 =?us-ascii?Q?+OA4mpNPR0g9PFsmb4CDe48Aae/kVBmc9iYt1WlhVl1WX7qW3+lgX2m+Or/4?=
 =?us-ascii?Q?oJ4CcHaaBM26Egbuep4ueyBP0V/SRYDHCD7GOT4i/zpKbn6eYzwKvXuzMBtW?=
 =?us-ascii?Q?lOTVpQDtMJpm1WBmwzbfoBSCt18oVTHcwcV4JLG0OXCb41SRMDzWpP2DPA/j?=
 =?us-ascii?Q?UiPMWgZZ1QpYA+8VvAfsMBivDmyIpOdSalrk4LrpxYO5KlDs5TSYKg7dJLLP?=
 =?us-ascii?Q?izWCSSDmCet27V39fjuIUg+AkyoZMyIAjcqUCZqolmLRp7b5gW2tkP7bqPIY?=
 =?us-ascii?Q?genj9wG0K1V07boPuCRN/n4L2WkRMvJ4GsJmfBs4k+mT9Mh8Dt7lJYIdOMkk?=
 =?us-ascii?Q?bRzqVTBRZKF3nJ9FwOBo5OEt1JP+A7WJ5QcOEDsz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba238dca-ff84-48ca-3bd0-08daf3faa295
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 17:38:22.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rL4L4k6K6SzOWkqQmna3N4dkS+PxtFfULGROaLwULLArCt1Vs2IULJ1E6qNe0NGld4IlH6J0rpSWQfbbq/fTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8173
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jan 11, 2023 at 02:24:34PM +0000, Jonathan Cameron wrote:
> Fix capitalization difference between struct name and typedef.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  hw/pci-bridge/cxl_downstream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
> index 3d4e6b59cd..54f507318f 100644
> --- a/hw/pci-bridge/cxl_downstream.c
> +++ b/hw/pci-bridge/cxl_downstream.c
> @@ -15,7 +15,7 @@
>  #include "hw/pci/pcie_port.h"
>  #include "qapi/error.h"
>  
> -typedef struct CXLDownStreamPort {
> +typedef struct CXLDownstreamPort {
>      /*< private >*/
>      PCIESlot parent_obj;
>  
> -- 
> 2.37.2
> 
