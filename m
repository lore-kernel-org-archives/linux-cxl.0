Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FF2C77B7A
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 19:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjERTBc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 15:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjERTBa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 15:01:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90BF13A
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 12:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684436489; x=1715972489;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=725BroEDbTCyAe43k0kMdTW++7B81HJKEPl8uMMWbxI=;
  b=V02li5y04vQNAv6KrGjOyIupUiS/0bHJGSEvgfN8v/SxuBgO4jYjixIr
   bvZBrFqNprtDQSngrDvM4vJu1iNmsKmIOA+jdXxxH1SULaQX2r6221XuI
   4e8wYFTLM1yPu+8IvzQBiCUGtQPtUFSJbOzIrMsLBNE67FN6k8wYw1mNV
   ytv9bWKcKattjESA7RVkeDplfIl6DjTXDofp03VO2bDzruGOnTCaKrhAs
   STe/vJi/xc9M7jW/L/eZIBkuOoNWF58kc7AERmpc4uARrmk76A7iTmpfi
   uzQB4qozzx+ZH8V6qvuFmL3vPBNjCCg9+vHhPSJoVtAWC2XN2uIi5dvlb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="380377933"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="380377933"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 12:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="652776459"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="652776459"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 18 May 2023 12:01:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 12:01:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 12:01:28 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 12:01:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaZH5+Vou4B7CcnXTHrELbsh6KedVlH21MTMLGf16yi/H0Cur69Pn+bN7AoVIHvVkEqD9i3JgbQ/gAvvEHkwUuZzm0nCUmX9vyPbLF79FfNNWgFOi3clOghh+lX7UgL9gxW6m3LnSQQItkE2Cln9ZUoxcMUJsGCFlSyS4zZNXzpSLkcRVdzC5MgPoNTWvBZusVEKRMAyz7JrB+sSLZH3xtyLh2+1rMjaZbBbw24ejl89Zh30ldVD2gZjwfIvFOWmi1rG9LfIQClf/HcKHLtSxVw+bWDyh4SKN0IQSXvb+AkAKY2ftylo2rP17ZVq5uBH8xNnoBd5FbpncA9qsUhJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BLik7bS7G2mdlbgWENEdmIJFJ13iey928xl3npLXeg=;
 b=NJMQ33QYRxvKuL8cPNBA0/F8KzBUdxo8BOIOT6/3XcsWPWajiwbdKL/pzVz1Hlp2skp42zO+aZooXg3u3kv2Y83QMBEY4fnx+PJp2/mtMQFfh20NQJXWjlNLec2zwdnyXEu64MghXPUK1f/QTgrEF7BBHXykvqb3HreQSeuFlunTktZC+yw6yKFfe+SiDjlGo6obRo8zJkUNdeZrsfOyA+5JSXERgTgqBeRThhADFmrU9BzSEziiBHNgbYMdngUJ+ee2QX/chlExtzXzHx1Q14mlyndfFfi1AwPZwUgHcybozwyahqGqkaGiL70nIDMk37G1GM5VK6n57EKAXmAriA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB8153.namprd11.prod.outlook.com (2603:10b6:610:163::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 19:01:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 19:01:26 +0000
Date:   Thu, 18 May 2023 12:01:21 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v2 1/2] cxl: Wait Memory_Info_Valid before access memory
 related info
Message-ID: <6466760139b73_114ccf294ca@iweiny-mobl.notmuch>
References: <168443095459.2957452.1648087475761987955.stgit@djiang5-mobl3>
 <168443110267.2957452.10368382491569241133.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168443110267.2957452.10368382491569241133.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da9cde1-f441-444a-870e-08db57d24764
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CP7trICTYuOv1mFVGSs17I3si+CZgsDWwcerbegxPBHKtNuV+T+qsfUaOhkVCrt0Hp7DvWfgNeJ7RzEN446FY+kV8C5zyoACXIWYxkIhUw76Rw1lMRJ7mqvLl7qcjYp/uQagQPNYx3NI0NBXF9Dw74OEU9aPb5+xfZR8i5x36oiWuhfXX0W6col9Zbj9eEHq/DuAIE8HCuSLe47E6Zh7SKL1HoM29vyR8oe0Z10FK4ZJkDjb4DblT67genbTM/XPrvGpNmyZiPAPJx00GS9IcUa+BJ+ZQi1ovnRYNtnN8XShMbAVyxWy54/R+9Ops+Lb7+bDHM7I4Dxy0WrYguzQoJTp1vN5At9I40SY+twaSIKVwXlfdWtARNTtpe0kCJshJDsAEp9P7eV5uY/zf7bJi0Z6G1esCvD4DCY6whCdzyjlBNOBdIlMB3Zh/Fek7OBLGGiYsnL0cu+wk/t8bHDgpTsJ3j4GOkJ20KWV4iBeIOIuDx7wqAQoNCVeCG1+0imFhHKLU2sABMlDl/cFYJ8SW6nQ4PXyIKYBopvUYmsFpIV4iyMZd/F5YO2dbQWyNqhb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199021)(38100700002)(82960400001)(41300700001)(8676002)(5660300002)(2906002)(8936002)(6636002)(316002)(4326008)(86362001)(66476007)(66946007)(66556008)(186003)(107886003)(9686003)(44832011)(6506007)(6512007)(26005)(6666004)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YgEoeLiEv6FsF1DGPBaFInR+JSQEMWjaG1eLVu1JtvOEBwMvj4tBhs5Pt5UJ?=
 =?us-ascii?Q?cgiGiCMrvDpicaC0pySh0aUwmKd+uKqpYDlT4hBEdmO8LxCK3K7ndt4BNDlW?=
 =?us-ascii?Q?TVv1qt3h2WMGn6jOOghidzAiMKFRZgQoUUS+g2ayqJZT1wWdGb8NM9BbE3Da?=
 =?us-ascii?Q?x3UFGbs3JUbfeDMg6mpvZBkiMM2+1nou+qEzdG7w0SACUBNBQzG5A538xxeu?=
 =?us-ascii?Q?X5ByEX96Waqw5cePS5HVP+heQc4C60eSiQFBQ1X1ikXJzd7Qr1AR1vrfx2OI?=
 =?us-ascii?Q?Tz6ao9d2ScDBPUfjP+oFmhzy2S+me8LgoE16BFV+sC0Po++t2E3mKZSy8pe7?=
 =?us-ascii?Q?HpC4ExZ+/LXqI8fqI1X15NMjTSN45tJdAfzvpJAc8QZNmjoGKXBj+7URGGrI?=
 =?us-ascii?Q?94G4P3saaforj/8HiVu33IPek3l7BZsIp6aD0s52vNlSs8P8u6LUffBzhl9P?=
 =?us-ascii?Q?EqAKLUh9Yh8Mh8789CNzyeS+8CSLk9c0tqlYoHfvZgvcBcvJDAbzlW9dMB22?=
 =?us-ascii?Q?7b5VmiRmESXdYPCFsUpae/Ebmcryxt8K92MiqGMLFRtkuZyPIi0CSkQ6TS8y?=
 =?us-ascii?Q?PmtTlqnOBT8ZA3EY8PWPq48yhBCsgVE8lPyH1VzeBp2y9yjPOcrryGJ/VHBD?=
 =?us-ascii?Q?Yn2SFW8WJAc/WAbXDzq8bJ521X8e9lAzWRxsDRBUTRXuB+Ed5jprs8ii4hSO?=
 =?us-ascii?Q?yMz868srIRBWlPk25shpWsvZjCs79u1fEJfzUQ+FZnXl8pHK5YJuJ/81yJIi?=
 =?us-ascii?Q?h17aLqpKAhW34b52R0jAvWOseBoxgMNzUJwS/XRppE+AE9heHmmPNLTAD9nw?=
 =?us-ascii?Q?g5ZrwZztm4t9GNL/Fj1N+ncT3MpkJbODUBlD7hRBME1Byj1HpmTrduJxm9n3?=
 =?us-ascii?Q?wc7aeXmqBjibaXvTTRTk9qWCQSZ3HzQWV9+MdyAnSCcz5TAhXZ8+d5gBds1Y?=
 =?us-ascii?Q?pcQUQWt7/5G4mHz7tFNbSZvEXxNpoEJHVEfskyzA7MhdxlCvQllnVp+edDYi?=
 =?us-ascii?Q?XHAl4LGC/vsrFMRiXn6ER+oRUsRVDf6XZqrtedi7pHgJ6Qqhyi6H/3sBpyyl?=
 =?us-ascii?Q?+9BcVKrDNu2UB0tuSH4HFO/IXflLpuUYindSX3pWjt3eyUJU3IQAR3t5TjER?=
 =?us-ascii?Q?RC0Fd3TFnlbRyU8J9TjRfn+NZ2PhqV9belevN6rlWnZX2QXDWkDzyIT/v3hP?=
 =?us-ascii?Q?IJr7vrHG+OBNJXrU2qppXUL+P+RSmqKP2g4akJVQ/2bm55x2FbDb8glKf1vo?=
 =?us-ascii?Q?3581sOOxnePpdjdFy8oiVsaARYLapj0dxK2EjzKHirxZpvzab40OiVrsMbzh?=
 =?us-ascii?Q?Vn7ccn1cyA1H7LbD3H20lVnCuA4fayNBfuUGfimiBFJsFs6JVflohvgfsm29?=
 =?us-ascii?Q?5k3GHzk8N8PGZUIw2KkvYUxthrwTOj8noMpG2Cvqp2YnIEetnHikwd37tGPE?=
 =?us-ascii?Q?HxeydkdLKAWHTVpuyQiFya/CWvT3EhcCoc60kqTSba4/cwqs7drptxoLCvv2?=
 =?us-ascii?Q?1fEqu1R0lcmm5Msmlr9G+Fq19zG/3X4YN2+3Mdr/G+wM0pwxE/osjo7mSEG2?=
 =?us-ascii?Q?WbXbAYWOY0BKWSBkvvusAImXQo4gFur0YV9Ms6cj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da9cde1-f441-444a-870e-08db57d24764
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 19:01:25.9132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBb8sDJugTW5e2fyuvtOqZ3ca2GO3cr+B/o1i5UlK8ZuppGjkmIXIYWEs4MHGNKyuvIfv3FYvoM5hbQT+/xh+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8153
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
> the memory info is valid for consumption. Also ensures both DVSEC ranges
> 1 and 2 are ready if DVSEC Capability indicates they are both supported.
> 
> Fixes: 523e594d9cc0 ("cxl/pci: Implement wait for media active")
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v2:
> - Check both ranges instead of just first offset. (Ira)
> - Add to commit log. (Ira)
> - Fix fixes tag. (Dan)
> 

[snip]

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
> -			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
> +			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);

I think this is still wrong.  I think this should be 'id' shouldn't it?
...

>  		if (rc)
>  			return rc;
>  
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

... Based on this 'i'...

Ira
