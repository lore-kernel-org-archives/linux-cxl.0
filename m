Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ABDC433FE
	for <linux-cxl@archiver.kernel.org>; Sat, 22 Oct 2022 00:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJVAEh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Oct 2022 20:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiJVAES (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Oct 2022 20:04:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85A82A684B
        for <linux-cxl@vger.kernel.org>; Fri, 21 Oct 2022 17:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666396953; x=1697932953;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lbexaQso7hD8Hlra7rukOZeQNbUMKxvqccZBBlmRH7U=;
  b=gZC3kFwuka17GN8AZdtnAhK9gebNO4YdSwDkwMg9VleCM2PrUKKX9w/d
   UO2owUonGr4tZuUi4opAUrSDQ2BKXR6FwzsVAjepYMPM8cxSKnCG3fnb5
   VLzB10y1L6YpmQOa7kk1Fp7vYcETRVkq1axk3b5LzUVrdGLZSUIZQZBs+
   uSf5viiLtaQ0/KNdEu3UlX2ms9Q+8nQUCAiPzy1p1dAt93ciUKyDxB6k1
   9QrQSk0n3ybw9X4xoBlrQYiuo/iq4swdxX2lk0U3IPmQNWLcCv6THtd7B
   zg4PnH5UPOvY9kjLMI7F9+WJp3YFcLdREJO5W2PW0KvmkMNTIdn+Vz5eo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="307123276"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="307123276"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 17:02:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="805746726"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="805746726"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 21 Oct 2022 17:02:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 17:02:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 17:02:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 17:02:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 17:02:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4000WCmYB8xs0HaYcmEyz8HkRFHg6GP4bRrgWhK4zQtx7kUTH98n1QHT3DQ51T+U+rM3H4CPLKdP205nsevaJjPoK3Bjwm6VnbgX57rH8pIn6m/+m4K+AwLsxDAhnv1xc7flhIXHz9uuNkh8U5dG1aluzyd8ohpQQ0VljxBp5Sr7xqgXXMWbUjZRiIiRSArQMGogOobCVbpr+6A3z2JInUM/7K9IY0kuHaPPsnMPFk/Y7KzmGldJIDJjCDf5aWYxzzarikhD15uKfmcWxWv1M7dj9+icf29Xj/T6AFn4NNaDaBbDUlzYPOac3T8WgHmt61v/iQ/MgikWY0p936nyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1daPfMsLvksEhUKOc1hDl+8XCTq6AaXKCG9958aof4=;
 b=QoBcTLldcJsUwxOmXMx1baYRjkzQZXgktkaiuulp/CxPqC/aJ5EC3L0/xXIPJXP0+u3o/AFvqqXlEDidMfo0uQWPo6UugCCsHllCi+nX16kWl/3pdO+Bm1wyGUSjRFpnRyAyeDGfFVFYT1NQwRRRTuqIiWeBv1bH0DG4+b1pCVcRB18LTgVT4q8RlsBVXOMCFWVqBE/jWJpExYD2pmhxRbakUfbWTxYGEIQ4YbrOlxgQ4SP8/RZ9DvQGXvRpTPTjaueFFdV5a8EcB06TcthB/BInzcVTJRhycmo0hrkiUxW3cZz59qgBCbDnYUeOrfwFDtT7rOt2kTK3fSPzXZMDFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH0PR11MB5363.namprd11.prod.outlook.com
 (2603:10b6:610:ba::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Sat, 22 Oct
 2022 00:01:59 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Sat, 22 Oct
 2022 00:01:59 +0000
Date:   Fri, 21 Oct 2022 17:01:42 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v4 2/3] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Message-ID: <635332e65ebec_4da329485@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1663687681.git.alison.schofield@intel.com>
 <8c93daf7080f45ad4085d6e8556e4deac03f6322.1663687681.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8c93daf7080f45ad4085d6e8556e4deac03f6322.1663687681.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:303:86::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CH0PR11MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: 5686c6a7-e4cb-4742-7991-08dab3c0a3b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18zo2yWHt9kmnDWEj2u6eadPJBA2BIofFgZEA2dgnYrx99RAisJiJ+rW28Mt3FLrTba8Gn0gTVJxgfFl8L3wN0qsBhzbRB43WE8E6lSERiZXYmSTV0HBCyqD73nW9d1rHoq/UfQydCPYuqofTXBCiAob19btERu4zdi+0Om/LUI5pxMB1vnOHLULt5yyWnUHIXklikwPfXjE4keg1yWk8vzk3Sy/Mz7R82AWC+JysVuWdgSgq8iu/SW7PV5VHYGPevde0oZL4Mpcz3a6t4HxSVG67jMwH0GiVyXAU19F7kkGfBJHoRfkukYHDV2OxMEk6nCiy4ZAUlGCGGRG2Q7VAm8UFJdaEltwvwN2QPTs212OAVyMpXmLrHy0ZnopBcUwb+BxgH9XotZ0ehcVO90/bgtMwH5sf3oHnJKfje9x6YN9Fitq1Bspkwt5f9EKZts5xpsV501/IibsAy94uJatdYV6yolEG4DlzhJsG8deixmr0527V4zyu3zepei2ewx6es0O1Ih7C4fmLn6kVu72hzyFsr3LgKLqhCIHplenNcPFCFxz1fRXcTiAE+JYOHY1XtpJnjPEiV/0+6KTpAzkYxqAQUndHuOPESlwgDgnktYz/nX/DKLLjvTB/VBayn7n3XvUYOfAPcaNx00ZfkiASroZfr2XaXFvSkUZJf+b8T7Sm3ENd0NxM6cDnf1Yw6hFrCw1QMEcNJX4KSNws+CP4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199015)(9686003)(26005)(2906002)(186003)(6512007)(6506007)(5660300002)(478600001)(6486002)(66946007)(66556008)(6666004)(110136005)(8676002)(316002)(83380400001)(6636002)(86362001)(38100700002)(82960400001)(8936002)(41300700001)(66476007)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?clUW+aTbQG6w01Y9NcIDgMYXkAwAMgxHwuFhwMK10g7uqB+FS5p0wMlPp+H0?=
 =?us-ascii?Q?7NMGjs7yUivdJrjFCbnNyCXazocmzI/BtNOQ33YcN42UpX5q92UCN02G2IkD?=
 =?us-ascii?Q?LBFDQiQErV5f959xXWR7nJmeoKZ8x+3hW7wRtt2hog2lFxxPnY3vFRyFcQhK?=
 =?us-ascii?Q?9d2xz2rhn+nR//GSKOBDVyuNjgcielHxwVadm1Eu7JZ5nbndv+gZL39wq97W?=
 =?us-ascii?Q?dphS3CPvW5tsM885k+NBGXmv5qJ10xb66j2iOMRlCZRyx6xmMqUWzqQUP0jJ?=
 =?us-ascii?Q?vXcgCrEsmwaGof/+1AbuBZlAyEjv70AHnk34DU9Pi73p2g7Ths+64HZR3PNE?=
 =?us-ascii?Q?134Ro4LZJ4JJ02+QgGyubi2gmGaeZ0N/sucMo/RiRuBvz5WclvWs5r4iXRiR?=
 =?us-ascii?Q?5Wk8w6tTdb576aimdB/rqqbfDAXacX8ux4mwRg4Fh/x3SakBoiZoKiLGFPhX?=
 =?us-ascii?Q?XbhxVmYDFrQ3xRIcamWHzc6Bx5VR8OUF2Wgw9vPA0O5vrwQTrWqnGKWLBtS9?=
 =?us-ascii?Q?OjFoMgziLAzl5MlyjPjJJNp2bWPPUa+1yiR0xb4+ZYUi5UoxAwzvEIcaNwaO?=
 =?us-ascii?Q?qZInsVUzNvWOIFogWHRSUJXQl59CJH6EoFjSk9XYbmEKfvcsH8JFRI0GFHUi?=
 =?us-ascii?Q?JXYrrIkhzRPIWXgIf3VL7C6Vxh6x6sKtq8O51VGOFxpwBouGMUjMANXwO3cQ?=
 =?us-ascii?Q?QKMQbKvbhMGhUz7Vq1OO2Smxjusg2JZW2xSgxH4oJPlZEtgHkpRUrLO31eoz?=
 =?us-ascii?Q?u5E5GZH67LExDzC0KYjliZqeusI32lsF5+opOEFbGuazYMblKIcl3kogWc9f?=
 =?us-ascii?Q?zklEOzfAvBK25LSMlaKxcqdtS/ybMlde0f5Krn6M2v8fL1va2zlTULq8jmnK?=
 =?us-ascii?Q?GcbVCL2x38U/86UiJ59weESpok7sCSGHqp6lW4HGn9ZpGj+tSKoGBjeuL8a6?=
 =?us-ascii?Q?sWQ+SLV/xvX+Kivv8BwtzbemRUTpQP72vuKFEvHt8S4Cgpafcnje8NEkdJv4?=
 =?us-ascii?Q?FbfRSf08o/2fsm5FWyefhRvLYff3Ebeai/CpPo2iIhibDMCyewtQd6H2CVzp?=
 =?us-ascii?Q?ma8bm0C9gDKZ4GSPr0t6wBJ7E8IUeWlnPbfAllLsIP2PT+8n5ugy1j+wCGmM?=
 =?us-ascii?Q?W74GSC7CDFRo9NEizyqgTI98fr1AZyEH9U8bLK23Row10lTzr89+XMtmMqiX?=
 =?us-ascii?Q?DS4GYjV0K22B/wHn8nskRDV9UNGtflVCuofrJmqQnbvxouSd7q6UOtye5tCr?=
 =?us-ascii?Q?Sd3LDXPGb1FDX/xRrWiSNHsemTebCnvSzi9D4rUGaOR0BG8HccrlRpAUkjHK?=
 =?us-ascii?Q?qM7YvZArZ3JZVUtdj2q3yWpkqx1YwILSG4pgL1JoU12FxMq903XRGnYwei9w?=
 =?us-ascii?Q?6F+2ibFGKMXWGw+blqWLsbp9yXUYjxhFCjILrmfPcFc/tFP19inhc5OlwoII?=
 =?us-ascii?Q?ztbRRC19wFPpXv2kp5Gea8GrlIkxWo8isXGXdyCtcHaT8tVrKGMGqMpLz7Tl?=
 =?us-ascii?Q?l3/Qk877XrAL9v+QPsPx46E1JA/SHW7xI0tIUR4i1nMV5F4WKDNYiJUP3bjg?=
 =?us-ascii?Q?vO+YRkee3Yr074h6zEx9yVw6bWgSrVu41nSpiCGeyf/29raZLjoEfGduhiWW?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5686c6a7-e4cb-4742-7991-08dab3c0a3b1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 00:01:58.9318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9df3y9AuQ1wKeBvI40pjprtepvafB7Q1UMl2GKXfSEZBWYvbSO+UTfKyzkm+VhlYVw5QWWjiVMcWZvl0Och1UJ4Sg2qbbOUFyT0fTTw1Mak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5363
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When the CFMWS is using XOR math, parse the corresponding
> CXIMS structure and store the xormaps in the root decoder
> structure. Use the xormaps in a new lookup, cxl_hb_xor(),
> to find a targets entry in the host bridge interleave
> target list.
> 
> Defined in CXL Specfication 3.0 Section: 9.17.1
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/cxl.h  |   2 +
>  drivers/cxl/acpi.c | 133 +++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 130 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f680450f0b16..0a17a7007bff 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -330,12 +330,14 @@ struct cxl_switch_decoder {
>   * @res: host / parent resource for region allocations
>   * @region_id: region id for next region provisioning event
>   * @calc_hb: which host bridge covers the n'th position by granularity
> + * @platform_data: platform specific configuration data
>   * @cxlsd: base cxl switch decoder
>   */
>  struct cxl_root_decoder {
>  	struct resource *res;
>  	atomic_t region_id;
>  	struct cxl_dport *(*calc_hb)(struct cxl_root_decoder *cxlrd, int pos);
> +	void *platform_data;
>  	struct cxl_switch_decoder cxlsd;
>  };
>  
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index fb649683dd3a..51cd45d2ed98 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -6,9 +6,110 @@
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
> +#include <asm/div64.h>
>  #include "cxlpci.h"
>  #include "cxl.h"
>  
> +struct cxims_data {
> +	int nr_maps;
> +	u64 xormaps[];
> +};
> +
> +/*
> + * Find a targets entry (n) in the host bridge interleave list.
> + * CXL Specfication 3.0 Table 9-22
> + */
> +static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
> +{
> +	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
> +	struct cxims_data *cximsd = cxlrd->platform_data;
> +	struct cxl_decoder *cxld = &cxlsd->cxld;
> +	int ig = cxld->interleave_granularity;
> +	int iw = cxld->interleave_ways;
> +	int i, eiw, n = 0;
> +	u64 hpa;
> +
> +	if (dev_WARN_ONCE(&cxld->dev,
> +			  cxld->interleave_ways != cxlsd->nr_targets,
> +			  "misconfigured root decoder\n"))
> +		return NULL;
> +
> +	if (iw == 1)
> +		/* Entry is always 0 for no interleave */
> +		return cxlrd->cxlsd.target[0];
> +
> +	hpa = cxlrd->res->start + pos * ig;
> +
> +	if (iw == 3) {
> +		/* Initialize 'i' for the modulo calc */
> +		i = 0;

From cxl_acpi:

nr_maps = ilog2(cxld->interleave_ways / 3);

...so cximsd->nr_maps is already 0 when iw is 3, so no need for a goto,
unless I missed something.

> +		goto no_map;
> +	}
> +
> +	/* IW: 2,4,6,8,12,16 begin building 'n' using xormaps */
> +	for (i = 0; i < cximsd->nr_maps; i++)
> +		n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
> +
> +no_map:
> +	/* IW: 3,6,12 add a modulo calculation to 'n' */
> +	if (!is_power_of_2(iw)) {
> +		eiw = ilog2(iw / 3) + 8;
> +		hpa &= GENMASK_ULL(51, eiw + ig);
> +		n = do_div(hpa, 3) << i;

I would just use "<< cxmisd->nr_maps" and move this before the
power-of-2 loop with its own early "return cxlrd->cxlsd.target[n];" in
the 'if ()' block. No need to force these 2 cases to have a common exit.
