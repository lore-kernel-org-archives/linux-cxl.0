Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D077C7EE25
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 03:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjERDj6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 May 2023 23:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjERDj4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 May 2023 23:39:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284C130E8
        for <linux-cxl@vger.kernel.org>; Wed, 17 May 2023 20:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684381195; x=1715917195;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b4OL1Oob879P2AepDNx5qXVYgJvKSA/emACDPh6Z/To=;
  b=hRNyELCax8lu87+/HqpW8Kw+LgZ9RliAvyFgJyjivEj9hcoyGpVW1qYJ
   vNL/jZxFINvchtwAb8Qbb9NTRHmbfi1jCnZh6xgchgfwDR5Argd6PFhX6
   eHDS0htEdcV5OgjNnX3XZzj4aKXi0/RRpbqJHU4WP4F6HnuZg2oon49FD
   3ZVqfX1CsVrFeVEe8OM7v1J2sZG29eyUu2mAg+ifuB0pXWeerJyAEY6G9
   JSmJEaDs7Lb7UkGBBy6Plyomk7ES90wUaS/8BHyknhE9Fu4G2BhR+WuDG
   Bp1pCMTGqKJmsJcw5mZPmtOJJh33k13z3MK8j/gzWOvXJJw7XtBunilbk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="336516964"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="336516964"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 20:39:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="814158950"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="814158950"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 17 May 2023 20:39:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 20:39:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 17 May 2023 20:39:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 17 May 2023 20:39:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHTR/5h4sJnYT+jW25fe1gXeUTg2xNjptaP5+7afkNY+ueUV5MvMmorxDpotDByoIT+MfjbqHSXKakPCM7WKAj9IuI9nHfPoWjSPRt5/B/gooeSWevHswYzsHcPQ3MmGogLcQMC+4TMpsrg3u8PNn7e5b1GKWJOFjA0Fz27Ld69tDkqSGy/0EU4+4fqJHwOE7mR4Nd/qDQ6iWpAthBX5WOhqmnULId0cjMrA2cva8lW+q5tKiZFVVuUlGeu8uJhpK2Hf96VInToXI27fwQMnQEFKQ4B9hEzTAMbnR7/j5GwU2nRvvmNeF1+Ahc4S946Mq3b1/A6vUsifLKhbwtI7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNHhN2yPpwoexXfQ5yePd9Wm0nTVqqo1g7YlUGl6TI0=;
 b=j/4++aSkosqVwlyJu/+tOeORd9WPp/QrVr4Qpmjstvr6ByDjZYp8F3oAwD1cI7/As9LvA9cd5s1F9VK3VqbGAFOSRju1Sa+DUy0eKLS2h4uIdJyGjP2tVp9XvTT39PFzClOGN+HyJJVQV0IC4hD/GRbrPhIR6EGxObRq33DlkbAmyOEHdOjklvFzt2oMSj5oK8TUXMSVcbyFVpL63DhaTw4zFoNs0knNQOTisCtvBwXx5VaIxydce39gCM+LVK6YzJe2Sn4zNqx0kDWkT9dzeaCO+MEetinnSL4mdNh2NIqyqPXbKARNt9VSoYZUWO+AEHtpOY+emoSaMK6v79JG4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA3PR11MB7977.namprd11.prod.outlook.com (2603:10b6:806:2f3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.35; Thu, 18 May
 2023 03:39:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 03:39:50 +0000
Date:   Wed, 17 May 2023 20:39:40 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH 1/3] cxl: Wait Memory_Info_Valid before access memory
 related info
Message-ID: <64659dfc73774_1098d429459@iweiny-mobl.notmuch>
References: <168428284429.2205351.8883627879572769367.stgit@djiang5-mobl3>
 <168428295907.2205351.12793990978386772732.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168428295907.2205351.12793990978386772732.stgit@djiang5-mobl3>
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA3PR11MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afca15d-2055-4165-13fd-08db575188c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xxya/YFS9qomBjMQmgW0rnRlHYtpDd0fImBw5lOiPl6XELjGVBz8xsQwLZDGy3e/aDU7xqEAI/6gHoBOJpeNMrV/sSWjFOeiSTTPyRSMYdi8w9j+t4n7fTJ5pQgq/pFThrCNyoUIMmK+fRLiN+Z2ShtYlSka9xkUzQNgXe9ciq/jcAY8iNZ9/b5Hoo1sx3pOZayFG2mOJCpC+vAmieitE3Zvr5/4i/YEG9lASfmDcpSHYlRfZQRW2wyWGCSyR5d2EgfJmhOZY3RkC8c91hasBxnIsb1SQT8/h9vxRn4+UDKlrC59VpWH71XjPsKOB5CXAxRtyeJbtS4c1rar8bUwQhrJ/LqMDcLxutni47vTWo14MzI0ke1cQ608uGjYW9xJ2MHLvDjJVhz75qqFjlfpHxkjaDTmWJPDiihmPwL/5n+WcweZuGrjiKplz7Vr/EHws17YfKUqnbJkQJSPa7/KjpjUxEjNodtqWAed5SJXzo8er0WOQFXBlz3Ssbsv9PcxOOu3gX4tZgIa4wU4PDe9K8pVZrKKS2NFay2Hd5VWU6SbMezmOPH3vbOTin9e/my6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(6506007)(6512007)(9686003)(2906002)(186003)(86362001)(107886003)(26005)(83380400001)(38100700002)(82960400001)(41300700001)(6666004)(6486002)(6636002)(4326008)(66946007)(316002)(66556008)(66476007)(5660300002)(478600001)(44832011)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fe/l2hszf+fnSjG7eseX6TuIDY0+siPCZVg+4HGlYPdKeYunvoBQsMU5O1VH?=
 =?us-ascii?Q?sM/z94aJ5HtsLtYt0nsPg3D1abnJQo2ZGx0pYiU0YqPdCu4MXwOopEvbAQ6U?=
 =?us-ascii?Q?1HNDoU74uxEu+qLPmqzvnQQSlmg5MqKXAcaq2dXyt7rXjJSYWnDY5bKZn/A5?=
 =?us-ascii?Q?c+NmTNO/UCbfjlklbb1gMKfIZ4DyCRde65gyFRiJ40XOg/hPKxd1NosMRdoK?=
 =?us-ascii?Q?6aWyLwMhnJpFF4xfL1hDZVrtFJfRU5iezQ8bHF+P+hTzs4ccVVjC5qlPpwYo?=
 =?us-ascii?Q?3nBp/lMWYB6m76+EUK2buqJDkF8mT+qX9H/eAxZFfZYhmdaYmFCAIOdoz0Wa?=
 =?us-ascii?Q?CbkgCxKQ5P9bkugnE0Tlu+O/O9dW+hAXxfN9fjNAcjzd37Aw1PF8Y9bgvmiM?=
 =?us-ascii?Q?uyef/WHlIrcHl3i/GIKkJ6331gWhgX9hGjxwop/bjOoQKCwdEqBqXQ+E7YcH?=
 =?us-ascii?Q?A0ddAM+AG1mRgyQeztG2pCugrsCTrorouAHe3NMFDOBlmdFQCrczBCOuFWNz?=
 =?us-ascii?Q?GCwJStnPglGQ7VkArfAvDJ8RGQmP/Hl5bosN47jBR0GvDULQ7GUJ4aVYAt0T?=
 =?us-ascii?Q?DIurDzwzQb4IkK/xfxmBTROUyH8Hgb5wBhDs5cqcepDLL0Sn8qISm76Ivaof?=
 =?us-ascii?Q?m+zo4RF9G3IsL5qZDJ8M1mW33nE7Ni2wmeM97MakO1q+9v6Hnr5xju7nSa5o?=
 =?us-ascii?Q?LgbBkV7FzDIQkTVl4+ERwiqowrAJFf7YbjFoG0adJV2Y1kNfc+74JowD0Coo?=
 =?us-ascii?Q?aLlhtCKs76Ri0Y07VDUsGdOVrcn3AJdYpGT6eg0EUT/qdO7mtZN/wDL8373+?=
 =?us-ascii?Q?hykkc19HopoI+Og8DPHc6WOe77RZwH4mfbm4S7/La42id4iDzFP9J1gBvUwV?=
 =?us-ascii?Q?o8+GxF1xrbDsE4nOyjLoEgCj/4lgoCo2dOpl15bT2R3Z4YrcU0WJlc7thUFV?=
 =?us-ascii?Q?xTER54uGo5q9obChmNhQedgDpSpUZFaZg/jmDrDtpE+l5MXuoMNDez3V2Zu0?=
 =?us-ascii?Q?QvlO7UiKKECuZ2ckyXg92VAurPsnrEMrPvX5e0NZ1ynxavNIqZoM3OH/hWfO?=
 =?us-ascii?Q?wNJEkA7qTDSBiu7jknQJCHyfZusSePrqwM1xRPhk0yZRPboJUi8AhP7r9x8i?=
 =?us-ascii?Q?kxzXZU+qXYU6MTR26fn9Anp6eK9q+PP4GnsIPRjv2SaaZfYrLQV9UeodhUWP?=
 =?us-ascii?Q?ShbrtjXt4nzh2kKiBGe8t2cmWK/pArj2pDNbgjtWNOkTOrMcgV8uRe9TTigu?=
 =?us-ascii?Q?Hcf+GJpGv6asfgfwCNj15SLhD7+W9fSU48t5PaKXZml/01yb0r9pe1n7NAYu?=
 =?us-ascii?Q?+P/Sttif7cxWfjXX4K0JzNaxdghRSdcmTkzfDdeCCN/N08O/68pPR1AjS59M?=
 =?us-ascii?Q?LUPuu8JGUDRxM5cXqx98o27q05t8uXGuG23/iKghuy/EotspgHI3ON7ijTTU?=
 =?us-ascii?Q?4bp0BkZoQjBKiX9umcQ4xV7HyIZ2x/hQU3uvEqOnEtvS89h33dRcrpVgMA50?=
 =?us-ascii?Q?qHPU6X3DgbXkV3XNmNGAe2WELwSFQ5cyyHPJO/ShuqrNkODkMayT0bdPj8Nk?=
 =?us-ascii?Q?L8Jht2q4F83y4evEmFJJQeYPRBUIKDHMyNvAwU6T?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afca15d-2055-4165-13fd-08db575188c8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 03:39:50.7018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkptYnY2j7O1C7YTK95a8S6JjSycV8mDYzgAm/yuBu6ostyu3fSaSSHrSmbRxHiSIjlpcFZbTgMaDySrA1gtyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7977
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> CXL rev3.0 8.1.3.8.2 Memory_Info_valid field
> 
> The Memory_Info_Valid bit indicates that the CXL Range Size High and Size
> Low registers are valid. The bit must be set within 1 second of reset
> deassertion to the device. Check valid bit before we check the
> Memory_Active bit when waiting for cxl_await_media_ready() to ensure that
> the memory info is valid for consumption.

FWIW this also ensures both DVSEC ranges 1 and 2 are ready if the DVSEC
Capability indicates they are both supported.

> 
> Fixes: 2e4ba0ec9783 ("cxl/pci: Move cxl_await_media_ready() to the core")
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v2:
> - Check both ranges. (Jonathan)
> ---
>  drivers/cxl/core/pci.c |   83 +++++++++++++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxlpci.h   |    2 +
>  2 files changed, 77 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 63f2f0b86fbc..484a8b0b96b9 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -101,21 +101,55 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_enumerate_dports, CXL);
>  
> -/*
> - * Wait up to @media_ready_timeout for the device to report memory
> - * active.
> - */
> -int cxl_await_media_ready(struct cxl_dev_state *cxlds)
> +static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	int d = cxlds->cxl_dvsec;
> +	bool valid = false;
> +	int rc, i;
> +	u32 temp;
> +
> +	if (id > CXL_DVSEC_RANGE_MAX)
> +		return -EINVAL;
> +
> +	/* Check MEM INFO VALID bit first, give up after 1s */
> +	i = 1;
> +	do {
> +		rc = pci_read_config_dword(pdev,
> +					   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
> +					   &temp);
> +		if (rc)
> +			return rc;
> +
> +		valid = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
> +		if (valid)
> +			break;
> +		msleep(1000);
> +	} while (i--);
> +
> +	if (!valid) {
> +		dev_err(&pdev->dev,
> +			"Timeout awaiting memory range %d valid after 1s.\n",
> +			id);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	int d = cxlds->cxl_dvsec;
>  	bool active = false;
> -	u64 md_status;
>  	int rc, i;
> +	u32 temp;
>  
> -	for (i = media_ready_timeout; i; i--) {
> -		u32 temp;
> +	if (id > CXL_DVSEC_RANGE_MAX)
> +		return -EINVAL;
>  
> +	/* Check MEM ACTIVE bit, up to 60s timeout by default */
> +	for (i = media_ready_timeout; i; i--) {
>  		rc = pci_read_config_dword(
>  			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
				  ^^^^^^^^^^^^^^^^^^^^^^^^^^^

CXL_DVSEC_RANGE_SIZE_LOW(id)?

Ira

>  		if (rc)
> @@ -134,6 +168,39 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  		return -ETIMEDOUT;
>  	}
>  
> +	return 0;
> +}
> +
> +/*
> + * Wait up to @media_ready_timeout for the device to report memory
> + * active.
> + */
> +int cxl_await_media_ready(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	int d = cxlds->cxl_dvsec;
> +	int rc, i, hdm_count;
> +	u64 md_status;
> +	u16 cap;
> +
> +	rc = pci_read_config_word(pdev,
> +				  d + CXL_DVSEC_CAP_OFFSET, &cap);
> +	if (rc)
> +		return rc;
> +
> +	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
> +	for (i = 0; i < hdm_count; i++) {
> +		rc = cxl_dvsec_mem_range_valid(cxlds, i);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	for (i = 0; i < hdm_count; i++) {
> +		rc = cxl_dvsec_mem_range_active(cxlds, i);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>  	if (!CXLMDEV_READY(md_status))
>  		return -EIO;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 0465ef963cd6..7c02e55b8042 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -31,6 +31,8 @@
>  #define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
>  #define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>  
> +#define CXL_DVSEC_RANGE_MAX		2
> +
>  /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
>  #define CXL_DVSEC_FUNCTION_MAP					2
>  
> 
> 


