Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B68DC4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Dec 2022 00:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiLNAmQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Dec 2022 19:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbiLNAld (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Dec 2022 19:41:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF6DCEC
        for <linux-cxl@vger.kernel.org>; Tue, 13 Dec 2022 16:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670978452; x=1702514452;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uv+zhvlb7litpudOqOg7m84CmOiDqoyMd6cweO9rBoQ=;
  b=Aup0CP3H8ZM+ikiztuBew2BGhsnbaLHQUNigKIlMzK3Ou5qZomPPo2Mh
   MOUesnlVZFUu0quk4m58yLmUYRKdVbSUBSHpxjG8seWMPSXukP7coghoq
   uWq+8oVOMZuzWIoZZ4wIjHCy2DONaLST7mlki26tQEIN0GJTfMlcDgUL7
   rZWqnEyUrIj0phj3NqEZavhaM748C7V2b5UnfHlgJs0Jauriwsf5HePqq
   1/FfXc91bnkwh9vVjkupQzp1OuxXe1owpU2B0UUYMBKMHWCCfvn403vGz
   ZZkVFh67k12etnNfrndoMne9tHFDbvyecZKlWNpr3zN5rYjMVnvUvb+ry
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="382576579"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="382576579"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 16:40:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="681342842"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="681342842"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 13 Dec 2022 16:40:50 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 16:40:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 16:40:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 16:40:49 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 16:40:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OG9a8nlPGkr3lFVT2hbyGNpjJ+WzDFTUlxnA252OgoOQtD8xRUbdiK6mKZf4ghsdp5+sxnfMiiE92SRe5Uq4HhklnRBi4FTjPnl9ii5qykYUwqFk0HPTQ5DLmmMGyPiVbBth9FdIOGM6RxdEWjkOEEVouRam6iSTShzG9eF+oJ5RvxYvZWZ/WY/MSEaDX2F2oSBi3ja9WYhzOqLRj3yIvm3pSMJuNIwKUywrPCxx+UTkKo1C+RCnwHcWoW29Gk8CpqedXEMrhWGn+qGIuRJGKnryHVtcAbsX4/wCd2hUb1bGTrZMonLJ8Qax2Y1e4Pwe0YuUh5NSEDarHPB+gg0mVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/N5vKPMaqMqplAX134CZ1Qo3nflYCfxxcubCji3vuA=;
 b=PoHtdI/MuiaVhw3e2MGLrnQXFGeNF8xDgjxxFjTEhkabIZmP2ArWXszzxjjIkQIOoTNPi8V6FGP/Rgot67O6DLC4BuAsI+ennj5pQAUZ4l4Xjbzec/NXs/oU/IgBF58bWjqqNi4zKgnpOXiRhXqtf9zG9WGlA66ND1yai8x3ySkLeKF3KK055tduk59Z4rlg32oIhn7zaLx81O4D1HDgrGiEYM9OUl3MDh9gQYBGW69yzDczmU+qIsGyQ010+d2qRGTXxwIjcJniS4GymcW75VGuwobzCX6MH4B7IIbAlBliRA9xEB9iafBhELO/KgGB9Op5A/TVlaGh1a/ocQh6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 00:40:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 00:40:47 +0000
Date:   Tue, 13 Dec 2022 16:40:42 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH v2] cxl: add RAS status unmasking for CXL
Message-ID: <Y5kbiv+YedUYjUhc@iweiny-desk3>
References: <167096738875.2861540.11815053323626849940.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167096738875.2861540.11815053323626849940.stgit@djiang5-desk3.ch.intel.com>
X-ClientProxiedBy: SJ0PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB4869:EE_
X-MS-Office365-Filtering-Correlation-Id: 2239a96a-16ac-4530-a10e-08dadd6bd738
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CL5Ni93z++AlfRoi64xaliaTYrKqUsoTrXtGlGyUxJr6F5986/q0zoYW0UlOFy7Fw/TmOPep34dmlaOXxi2DzHt+s+Lw46xUcIOfaLsQVqucIKesDIbJh2lfAi6HFzE16yKziEV2xEjnsxy3bYnN0Ol1CHz0CclrIB9c4/sJkf5NdtzSZA32MM5pBRhalVZUBq8Md1xp/8o/XNEqtynJJ46nbH2tf6Xf6J3h6ovhcWjPLRawXRP0fzCH6Fjnj7oCgXWiRVCDqvQnocPPNgwCfNAqwN67GQB7PX+CgtlRUB6087N2I1KCVdYVueheHloc7K/E0ZSo1uUxhstDiItG9Y0AvmNa//ot7pbrUUMowwOa97uy7f86fLctqm64J3YroWHipd0HOrtCN2yGLSFVSV3CpV4hWplruXA4GTAqrJoII0NqpmSkMLzNGgKCAP47JWIGsDYqtEk+8cxwj08XH2XEwkipvUaCq6EkKPU20wEVA66ysjcOEwSZQCy7mWohz2aazeHFGKXIm/1ITUiWchHsgJPr2l8nBlF5+3IHJq2iGXHewX75bfz4BChcY6PXU4uufSlZmsP71R4lQUxtIM7+a3idrUztf0VJBGJUv5Fh0bM3bID7tWGqVJsUfTEfEsC+uHU1JD1Bo3PDqUt+0YG7ZSZ7aG4ceCtDgT0xp8ROFa4fmvOEloFl5aTgZA240qRCjj9ugufQ8KJ+Hn4qsPFjitQl+hLI7kT3DO8vBefgGRaJLfT3VLsy+G6gP2aW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(44832011)(86362001)(82960400001)(478600001)(9686003)(186003)(6506007)(6512007)(966005)(107886003)(6486002)(26005)(38100700002)(6666004)(2906002)(41300700001)(316002)(66946007)(4326008)(66556008)(5660300002)(8676002)(8936002)(6862004)(6636002)(66476007)(33716001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2GVtf27lOclzUo5ZKC431/vKRqmw6T+VdyIXVylSLdV6JJj8cJKjWXNlsMuM?=
 =?us-ascii?Q?L3Ez6Yv6AvuOBsS1qilFUjIPExVhc1OOGGbk9UuFBiAMEHP1E+E1g/tkUrzF?=
 =?us-ascii?Q?oerzyjEA8wX/rsHPvmwYorUj6O8aAl/1qGezO3TFqr1gxcHmJzzgJRT0s+pz?=
 =?us-ascii?Q?6Miar1QCVjO/OmVHrs+3ul0vhPgmCVMEQI+7tErqpW+QGyx1g+h7maviymsP?=
 =?us-ascii?Q?Cu2+b7FCo+2FD5kIvfdG5PCUWiwkFq+W/GNL5m5fEpLmxQMX+jpkPrzjYWOk?=
 =?us-ascii?Q?vfBJ7TuVK/frLURtRb7GWuVPvDL803NfAurLROYk5wN9JFqTXXjmNgjgba47?=
 =?us-ascii?Q?vzd469HIZgF7BmJa+hqkINplkEalUoJqoP+06x5guSVmPxEoJRNeEgMGQdvl?=
 =?us-ascii?Q?Qy40D290w1+l6fs2C+3w4m8rICAhJHrURx0cHN9F8ykZQtw/Mj9GWnKBmwTe?=
 =?us-ascii?Q?G9hE4o2yiWdjJdgwK57CeeHKhQ/y1q0yX1GP77MvnnF0wVzFALWR5gJY6b8e?=
 =?us-ascii?Q?1UVNhKbawlC6t/WIJWMkP323CVzfGb3AQXuA28uaemW9XmwVofmZmoJQGj3K?=
 =?us-ascii?Q?SiOiijgtQPWL9z2l8psc9/deHHo5AIpbSaQ7wtZRXbCWHL5d0xbskreA5WYw?=
 =?us-ascii?Q?wPnc0yT9grSkOfa8cdDcL9tO9U1Q1jjXI7qn6B4vsxjrYDqX80XTnpwIsfE8?=
 =?us-ascii?Q?CW4SpzygXhJeRDAoZpdha9EwWs7uR6YeZxKTo6E4XfKA+hkxtMFFKCt2jm6k?=
 =?us-ascii?Q?sikKoirLtoxiaGKV/JxjIWJUSwdW7c9QMU4z/g5ujLGhtyXgEMJFPtCWwnry?=
 =?us-ascii?Q?9ut50WCLAUAPjF0acHu7h55fKgw1Plm5rP66I1F8lKk+7zWxhH/Vn+uWIokD?=
 =?us-ascii?Q?xPvSjgzgA2bDK6eqtulXFmQVHb9RZxASFrv5LEOUSUZwDJB+/g2jWdX0xoM9?=
 =?us-ascii?Q?iRJKeWeKapDmpaN3B6Pev6GQApDQV42U38SnqSTZmCObyyp27EJ+4f4dXf0D?=
 =?us-ascii?Q?zlAFUmPYIQ1SQzEV4NUdu1+SIh/BLNwCUu/yb3JylKOcWFi6yyALTh4jUTtV?=
 =?us-ascii?Q?egmHzZ7WQVJhWCUa9o5Zi8bAIObzXKuWU2o43OGlzzEC1gsC5dVMNJ286TLZ?=
 =?us-ascii?Q?OX7FtgNRdi7LZ6PgkRS53j4Z4KMYmMoAeft0uvDfg9x2KRIOUBJcHJKR2WsC?=
 =?us-ascii?Q?MMVozKlHHhQdn8WTXOf2L+b+8L83dnWpA7BQSh+ugrfWsXC8ziRpFhEEjB0X?=
 =?us-ascii?Q?xuG6dhiZKVQi/fMU0Ev8qgr9d9pKE6PzUeiPNyPJpp5l1cI2UySPsnEwebYa?=
 =?us-ascii?Q?GPPIfTadQYRdrmSoqMEe/fwxQ1BbeGQQLrdwv9bPr//UOeHqtzkppAhnTujy?=
 =?us-ascii?Q?33x2ytMogjSGpO20CKSHOUPmKGvQC4C4wefW9titAK/OhHMXuPrhDdtoQH5z?=
 =?us-ascii?Q?vlfpeBdZb2M6YWozhAR8GG8aQ9Z/JBy4qtVkfPAR59srrnAOvE1b3JgcpX/o?=
 =?us-ascii?Q?1hx8/yjsah+QjgaTxT1bAegh31zD8XFVXGxjWavXekSl1RqkSAaSaX6VaEBx?=
 =?us-ascii?Q?BOI+M5EM2171I8j3eEB+Xy5e1kbw9sn2oZy9kCUV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2239a96a-16ac-4530-a10e-08dadd6bd738
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 00:40:47.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQPykY4foc7MnICYoRp7uWK+/cHAelHPBv37lKFs59yEoaeh5u3roPUmWVvkXroN1iLPJJivNLpmFWHcJ7I2Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4869
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Dec 13, 2022 at 02:36:28PM -0700, Jiang, Dave wrote:
> By default the CXL RAS mask registers bits are defaulted to 1's and
> suppress all error reporting. If the kernel has negotiated ownership
> of error handling for CXL then unmask the mask registers by writing 0s.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Tested with a mod to Qemu here:

https://lore.kernel.org/linux-cxl/20221213-ira-flexbus-port-v1-1-86afd4f30be6@intel.com/T/#u

Unless I messed that up:

Tested-by: Ira Weiny <ira.weiny@intel.com>

However...

> 
> ---
> 
> Based on patch posted by Ira [1] to export CXL native error reporting control.
> 
> [1]: https://lore.kernel.org/linux-cxl/20221212070627.1372402-2-ira.weiny@intel.com/
> 
> v2:
> - Add definition of PCI_EXP_LNKSTA2_FLIT. (Dan)
> - Return error for cxl_pci_ras_unmask(). (Dan)

Why return an error code that is not used?

Ira

> - Add dev_dbg() for register bits to be cleared. (Dan)
> - Check Flex Port DVSEC status. (Dan)
> ---
>  drivers/cxl/cxl.h             |    1 +
>  drivers/cxl/cxlpci.h          |    4 +++
>  drivers/cxl/pci.c             |   61 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h |    1 +
>  4 files changed, 67 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1b1cf459ac77..31e795c6d537 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -130,6 +130,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
>  #define CXL_RAS_UNCORRECTABLE_MASK_OFFSET 0x4
>  #define   CXL_RAS_UNCORRECTABLE_MASK_MASK (GENMASK(16, 14) | GENMASK(11, 0))
> +#define   CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK BIT(8)
>  #define CXL_RAS_UNCORRECTABLE_SEVERITY_OFFSET 0x8
>  #define   CXL_RAS_UNCORRECTABLE_SEVERITY_MASK (GENMASK(16, 14) | GENMASK(11, 0))
>  #define CXL_RAS_CORRECTABLE_STATUS_OFFSET 0xC
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 920909791bb9..d138d9cd8e33 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -45,6 +45,10 @@
>  
>  /* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
>  #define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
> +#define    CXL_DVSEC_PORT_STATUS_OFFSET			0xE
> +#define      CXL_DVSEC_PORT_STATUS_CACHE_ENABLED	BIT(0)
> +#define      CXL_DVSEC_PORT_STATUS_IO_ENABLED		BIT(1)
> +#define      CXL_DVSEC_PORT_STATUS_MEM_ENABLED		BIT(2)
>  
>  /* CXL 2.0 8.1.9: Register Locator DVSEC */
>  #define CXL_DVSEC_REG_LOCATOR					8
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 33083a522fd1..03691570649d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -419,6 +419,66 @@ static void disable_aer(void *pdev)
>  	pci_disable_pcie_error_reporting(pdev);
>  }
>  
> +/*
> + * CXL v3.0 6.2.3 Table 6-4
> + * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
> + * mode, otherwise it's 68B flits mode.
> + */
> +static bool cxl_pci_flit_256(struct pci_dev *pdev)
> +{
> +	u32 lnksta2;
> +
> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);
> +	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
> +}
> +
> +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	void __iomem *addr;
> +	int dvsec, rc;
> +	u16 port_sta;
> +	u32 val;
> +
> +	if (!cxlds->regs.ras)
> +		return -ENODEV;
> +
> +	/* BIOS has CXL error control */
> +	if (!host_bridge->native_cxl_error)
> +		return -EOPNOTSUPP;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_FLEXBUS_PORT);
> +	if (!dvsec)
> +		return -ENODEV;
> +
> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_PORT_STATUS_OFFSET,
> +				  &port_sta);
> +	if (rc)
> +		return rc;
> +
> +	if (!(port_sta & (CXL_DVSEC_PORT_STATUS_CACHE_ENABLED |
> +			  CXL_DVSEC_PORT_STATUS_IO_ENABLED |
> +			  CXL_DVSEC_PORT_STATUS_MEM_ENABLED)))
> +		return -EOPNOTSUPP;
> +
> +	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
> +	dev_dbg(&pdev->dev, "Unmasking Uncorrectable RAS errors: %#x\n",
> +		readl(addr));
> +	val = 0;
> +	if (!cxl_pci_flit_256(pdev))
> +		val |= CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
> +	writel(val, addr);
> +
> +	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
> +	dev_dbg(&pdev->dev, "Unmasking Correctable RAS errors: %#x\n",
> +		readl(addr));
> +	val = 0;
> +	writel(val, addr);
> +	return 0;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -498,6 +558,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	if (cxlds->regs.ras) {
>  		pci_enable_pcie_error_reporting(pdev);
> +		cxl_pci_ras_unmask(pdev);
>  		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
>  		if (rc)
>  			return rc;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 82a03ea954af..576ee2ec973f 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -693,6 +693,7 @@
>  #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
>  #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
>  #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
> +#define  PCI_EXP_LNKSTA2_FLIT		BIT(10) /* Flit Mode Status */
>  #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */
>  #define PCI_EXP_SLTCAP2		0x34	/* Slot Capabilities 2 */
>  #define  PCI_EXP_SLTCAP2_IBPD	0x00000001 /* In-band PD Disable Supported */
> 
> 
