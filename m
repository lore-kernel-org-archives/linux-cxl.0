Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D0EC5479D
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Jan 2023 17:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjAKRhd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Jan 2023 12:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjAKRhN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Jan 2023 12:37:13 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824713B910
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 09:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673458410; x=1704994410;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GE3PgrNw/XTdFAHIJ4NY0YJdA79X0QCabrwQRfj8JOM=;
  b=V/JK9xAPTPytYW0x+HmBQWQO1RDsXKr2zBwjJ2nZ+13nePmepK5oYDiF
   0ye1xHsIIeZY7wTIAjXVVbFzSh2QW6t6S8QWn8uLdemIbecZ1jso+AnnY
   +SUkaB+zDSES4Y+c2MOR8hf15+jJfq3fna9EL+08B/exwdSjXFnU+LKIp
   gtft20jTPbjjYRo3DUu+QOOGJDRqXCUFMIZRxgEMJJam56eu5fe0fLtgV
   ZchHiqfK3lslilfNT4c0OFBz9jX+FyRLfgkSm2M801iNOSAj75XUWHLu2
   nlkfwhnLLr79pZPxkxPFYsh/FbeOGD8imlRcZ3bfdhDvq074durYJJ7eB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303178637"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="303178637"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 09:33:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="799910622"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="799910622"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jan 2023 09:33:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 09:33:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 09:33:29 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 09:33:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pcr2R7uM/0kPu0fwh9WRxA3+PmqDPEu4C6jTrqZd9Pbg2sz4B2fH51tw1ugJ1OvlTkjcWQvAJgY6+bRun3au7Z2FyxxLTZ/xdmVJZ1fCku7Cel6C29afDd7dMGBs5O1OL3pc1FjkvApIJHyWqfHIvp1CpXKHHc160kX1oZCDn4mXk9rjfrEkW1S6wAO21j7GaTHiVJ8WtDxWgkD0BPfjNAeV4G85aYjcrB+kTmO42aLStUThA6hiRA9bDkJhmg18GJIKue/pWB8R3A1lH4rAiQArqxnCdl7GxiIFPsDMo2ls9ZMEaYpxZMMpyHIALHlUYRGAL8hAckYcvn5z5OjmNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqtKc+eDksEWqyubZvmalVgQeQQ1RV+mm8hWaUJ2qOI=;
 b=SHgYRJUlgUvXn/BioioTQNiU2cItOvwXuDnfhjagSgwJmCwIO6LarU5RxL5fVH5coi2cU2h72VbF9ez3ORebfx4QJY28InYy+neJ1N6MowUz2U0zMV5J5JkLtsy/O+dME36VXYQ2tgO7awpsfdIayVdcdZJ9H16+YV64h1BzDdL0dcUiKz63QlSDIoW6ESNeukVsYKJxY4o7gdLj/jdQ+LAGzXeMyOiFgfTLncx+GfTFCNEHiwURkau64f0HdgSqDNyVjiafr5/KXXaZ8OGudiO2/N6fLNoJ2xCVjHVQdzPfkigwHqFgLZq+H9VUHuwWONUuv0xLxEoHIsEoYlH1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB7476.namprd11.prod.outlook.com (2603:10b6:a03:4c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 17:33:27 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%8]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 17:33:27 +0000
Date:   Wed, 11 Jan 2023 09:33:23 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 1/8] hw/mem/cxl_type3: Improve error handling in realize()
Message-ID: <Y77y47RsN7dyvKwn@iweiny-desk3>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
 <20230111142440.24771-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230111142440.24771-2-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BYAPR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:a03:100::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e939261-bb99-4986-28bd-08daf3f9f2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2c4WQ07gj89DF/LuTITbRABSME76bdrYTu1foXaBUp9PwvVwvGVN9GG1ap5PDcgvUy8n0k0KmPypHdCCzaF5kDs3f8p0d8IuhKIiyxZhZ38FwoGZBc6Es6Ba4resUmwcKXw7wntM7dVUSvPvzjP+yYf9AkUWJYQWtZu5Jw8rVHCfX7Yb8+cNYbMVBy8PNCILlUr4R2FxvmBiud7gSEs6q3KESeQpUt3jZJvSFneogUOqny0uMHGNdh11pzeIX5rN8iiQty351B8djAUJ6EZAnTSO+Ot5vNWgcvXn7TDcBLniuRO6pVFYkedCLub9fEgCJ1IJVI1D5vAGgE8mz2NH2Oqr3LHw3o+RR5vXwPqYuMliRMJB5VwedCK12XRdOcQhzBiC0ohF0bVi1eI4g8oq1HZ2Cv9blMkHhYTo0rwYLL1fLKTLc5ffXHvPg2HT2NAQsAecu2eXvZNZlo1g6Ca2IA0FxsmRYyyxI2lC3Mk8e3pWSmhReL3PMWBcDqSqAP0pLMkzoFvrrpULbPYQPyIX3WaFOdXwwRF1tuySd3BBGFkfIqQkxJbmJFOjVQ+9bL89MVq81k8nDgxGK4WwN3cycY7TJfrJ5rJCPyifcbR6AvVwtF1UR9atqQJPMX1UnZ74q+Y95vZyEe/sMrhbCL+Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(2906002)(54906003)(4326008)(5660300002)(6486002)(44832011)(86362001)(8936002)(41300700001)(66476007)(8676002)(66946007)(66556008)(82960400001)(38100700002)(6916009)(316002)(83380400001)(6506007)(6512007)(6666004)(9686003)(33716001)(26005)(478600001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qzz84GuJhHqD2NMzGC75+Qb1F5izlmVyVoHAEIZmMMSq5jB5mP+0xLANUwPb?=
 =?us-ascii?Q?us4/cnl24cfKZAtA6OHOP+43eU3U7N/iypQG8IskELan45zts530jbSjX3Yu?=
 =?us-ascii?Q?AXkenIgsjJ7eS8cjuATfceX0zgPJy5rbLcsM34WXKXAreMXC5xPoXVnRWxTC?=
 =?us-ascii?Q?+YLgo4Siztsr+RIhLPAgO156g3011CTkvTf/MCrmbrUQhG41nodkg299zyaG?=
 =?us-ascii?Q?csPxmeHRzDNiyOweLk0rHRa6cFIQ1H6vx36fZCspMu6/cld9ImZA9Zq2M2l1?=
 =?us-ascii?Q?ojaJqlk00++9yk8bcAAYfijyjgoQ0FsejQNwSPziyJp2ej0jL0wbcVzhVdW+?=
 =?us-ascii?Q?zUdx29Htk13a8XB0n4lVNDHJhz/lNKf4yudFIr0Cqm/ufp6kzLkDamsu5gxi?=
 =?us-ascii?Q?ICoYievhm+oKepaaD5q5jfl1olxCwZi9NSxAhSb3I2BINSKS2ukUhFa2CuC2?=
 =?us-ascii?Q?hf9o7aJA97h9JANIFL6XQyzDR6OV4BrCEscAVYR9k5SRZDLCZVJldvhA1VEK?=
 =?us-ascii?Q?9reEsLuRqaR4RW0PZ92EhtoJN9q1LiyQpCyF+l+u5IL1hX0KSpwD86bOBdoV?=
 =?us-ascii?Q?j9lBstiTysgP8QDDzO47aw+8P1tIn19pG/HRTDRZh5y4XMLBQ8YTmzxdJRUr?=
 =?us-ascii?Q?xPkTrE+Bw3fMAT4/Q4T+JskUzDUH9DBpU95LfkiZkl6WFF6je4o6CRurC1jH?=
 =?us-ascii?Q?E1RWLB8kXZorp21WSJKwt98L6q/5BjLIorw1Ox90izKVqVR9zKQmt9t1OE7f?=
 =?us-ascii?Q?J0TX45fKcKwgZZcybflEGZholAJuV6rXQ4tW8Q7Wzem0rMBQ6w8xT7WZ148p?=
 =?us-ascii?Q?1k2/+F4C5Ar/g+/caMtOovY6lXH5TjTy72SMXB/dytNEVNqlGLJpxfPpYGY+?=
 =?us-ascii?Q?zawBE3NOuD/U1aysL2ADPxtFp0CBI7tnv25y631qRNw3kGIoq95IFyPZmSQf?=
 =?us-ascii?Q?+uWV9TQYcfDJeTQC8AAMPlrugV5oySrr+wuj7zsACOvRLIf/0n4nVPcUKUek?=
 =?us-ascii?Q?Z9myckgL4SpGpEJs8/IeZdYE4iq2+1+MN0kT/gM2Teq3fzaeLAynTLntsfFa?=
 =?us-ascii?Q?cCSphTmcTfmp6TgQEj93zKiNIPCH7EBNxPbmUoLBUCa5DlTnWZWy4HdhdB5U?=
 =?us-ascii?Q?WuIGrlzUABDGkmRTuJc0xvwi3X8+6VwFFjhhVQdUtzx+NwkiUcnBrIcY4fuw?=
 =?us-ascii?Q?jrdeRLYoV4BlEMsCfwVEcFSa9yGZ4sTeLRXOza9VerOLc2E9ZqbIaFYCVKJ5?=
 =?us-ascii?Q?I2IZvaLd2iltjO2upau/8jbfFWEUlubW6VqHc8X4coBFMuDIEk8NvvExx21/?=
 =?us-ascii?Q?/YEfC40Rk7isOEvBT+W8j5aL2wDqtQfT8ymd1udJz1rqG5yRDp83SA9vjztk?=
 =?us-ascii?Q?X4dE7rpRP1t4Cfnm3V1UWFO01FvGzpaVxPht+NZke+sqZILzwA3ujTk2vCUl?=
 =?us-ascii?Q?f/SUSczlF/pLEYDtYV8E77ETKqNV/uS8UCfQn/QjbClEl/TZKEKrIWgoy+Si?=
 =?us-ascii?Q?30sYhqXRjfjyb3S3LlMMLmV+Gpjltl3HEIgnt0ixorpJ1M5ZLU9fGyB26gD9?=
 =?us-ascii?Q?h3H6hIujVnOqF1hjgzVjL/naTw/+gkpzB+6EVgv9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e939261-bb99-4986-28bd-08daf3f9f2be
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 17:33:27.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mA3ZdW4bNo0wQhuDJ/y3K+oXfe4RbzY6kCMRABSXKX1fv1pESSaCYDu/N64Gr+e9GDkp47SZAEtz/GDykyjPew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7476
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jan 11, 2023 at 02:24:33PM +0000, Jonathan Cameron wrote:
> msix_init_exclusive_bar() can fail, so if it does cleanup the address space.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  hw/mem/cxl_type3.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index dae4fd89ca..252822bd82 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -401,7 +401,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      MemoryRegion *mr = &regs->component_registers;
>      uint8_t *pci_conf = pci_dev->config;
>      unsigned short msix_num = 1;
> -    int i;
> +    int i, rc;
>  
>      if (!cxl_setup_memory(ct3d, errp)) {
>          return;
> @@ -438,7 +438,10 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>                       &ct3d->cxl_dstate.device_registers);
>  
>      /* MSI(-X) Initailization */
> -    msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
> +    rc = msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
> +    if (rc) {
> +        goto err_address_space_free;
> +    }
>      for (i = 0; i < msix_num; i++) {
>          msix_vector_use(pci_dev, i);
>      }
> @@ -450,6 +453,11 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
>      cxl_cstate->cdat.private = ct3d;
>      cxl_doe_cdat_init(cxl_cstate, errp);
> +    return;
> +
> +err_address_space_free:
> +    address_space_destroy(&ct3d->hostmem_as);
> +    return;
>  }
>  
>  static void ct3_exit(PCIDevice *pci_dev)
> -- 
> 2.37.2
> 
