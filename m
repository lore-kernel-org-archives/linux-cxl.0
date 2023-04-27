Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75677C77B73
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Apr 2023 17:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242835AbjD0R36 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Apr 2023 13:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjD0R35 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Apr 2023 13:29:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0EFE5
        for <linux-cxl@vger.kernel.org>; Thu, 27 Apr 2023 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682616596; x=1714152596;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q/k/y0OspwvMt69EtVsQpDXJATi0XxNmFo/wGICtKas=;
  b=XLyEcwetVz5LVQuH7ASXbOwLlizus83lZjG7N3NkMBWTPqurYlGAYMcb
   eFkpXbGZZuGOJgk/yFokWoEM78due8W3NQkRVS9STixkR8fn4WBJvhhoz
   OVIhbn9VeWHkfpqJGqOXJ1Sil5ZPFuTyZUDb7j7XPL+UAjfLjT/Y8kSEb
   aRGl8UMKmyY0azotj9N8JYf/5hiX0i3kzz2e9Ez6Y+0Y5JZNXmBYryBWU
   ELBAOrnyTABsSCzgL+yO8cQqROPujQerlIgS1kfm97inNxcLJeb7+79A9
   T6iYnSAMlFOFh7gu9S1LP51K+tuBeFhD2mBDz39N8A6Uf4nvXV7ut1PW7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="327841572"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="327841572"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 10:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="940751908"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="940751908"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2023 10:29:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 10:29:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 10:29:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 10:29:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhNMXXmVUBPRGW0XLlR6lgMmjIG5lK8u8sVHcr0qBoyjIcsDrfVwJT/Ligmt1amejgH47upLRtrjJt+RxlbOPorlfEC9/gtj/dZM9xFwacfPvKL01TiS+imxpmGWjSkA/+8buhlQ4iNtxPxOPveV2hbOCJ1ebsE/5rzxYuaN196jOP1Ctcxk8zsoNOlYGvRn8MDPzQdFkDlE2QlLlY6KFCxOYQQh6s1hKZM5XSo4SsoKbzzmj3FgBQQBSCz3NHg6ssdbbIH7xxGqe2qDxo0MgmPwFc/Q7AZ7yXmlX+YKJPFYtqhOX/eRMExg0W5q+MbSxrfnwhLJUlvd72ZBvsnwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzkxV5UHZ3kEFrT7qOC8UqvHAR7vx5q9c4YyJzoH4Qo=;
 b=IXQGrztr/qYJEclrONdNpCsxHAyS0Qg3XSI2lymdB72hOST8ZNXfeM8KrJt+yzRxxv4yM6t3xUcJA7anHtqWrpa7r5SWyWG2A/Q+PsPhVBbcqc34NaU/AuubKy1u2I5ankPkO8DgTuORfMGLpvNNOzxoxyNmo3izE9fTO9dTncd1kJLL9WGoQdPuw/stDcuGbepuiijYzuVpMYQvmAeV40FN/D+RkYGs6jLBsfh6+pa19235hZVEagJLrBy+Myvn8dowtGJfaQ8i/NNWAEHKqUbqH7Zt+OiZP8nAWiZ0M1hjhIXyQF/ml0fMbL1cp6HCOvKYn3U/DjSSxFyvOx6nqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ1PR11MB6300.namprd11.prod.outlook.com (2603:10b6:a03:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 17:29:44 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 17:29:44 +0000
Date:   Thu, 27 Apr 2023 10:29:40 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH v2] cxl: Warn of flexible array in struct
 cxl_root_decoder
Message-ID: <644ab104a774e_15f1a29490@iweiny-mobl.notmuch>
References: <168261044311.369593.10950998135160952191.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168261044311.369593.10950998135160952191.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ1PR11MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cbf569d-5278-4a0a-688d-08db4744fd5b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ai4HNq0dQWiSg+CZCfA6dfupqdBKEZOwxoaejHP6V5wFAokBQQrP+R+MAY6UAfA0Efk+I0HEffGlCeywtUWKx5XWmJkXfcJcwHGT6wICMOsj1rDYBD6gumTiaXDqhLH/prHW/c1oFAQ84g5BvJGOEc3S9aLilA/5xh+kzX3/GKyPYFejKj1zfLJiqaJGKEeqeJBlSWEUfHgOUhGSto8KCK57TMaHgve2rEX8Mn/mbu/F0NgeDI89j/7ebh3xeWYlCt7STBY/Eji+X2ZglhsScugTwOuzBoXj0/z+Lxwm9Oya8lZ4JtwyMRG58h/6H/dHNTwn8DkHYd3ZSpFgxQqlTtvEv3HKXpSD+TIOsaQ7QYtK3RM9G0ryiUTeVAdwN3h/GB7Uf2BWo0NrhTpwAbkroxm3ORdbQEl3SBwqvkBxzQ9CV/iG/tc73gkQj1ROpto0iZyh6qL+rt+BY8tvTOb2yrD1wWrrGOK4u1gMW1ozQ1NNnF79qWro4ib67Nfkq7+qLemjp2/S0FfJSgw2EavlUhsedoyNtvMsmt1C/jOSHzHEiv8Hmn83oSGDpaBMDdS8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199021)(41300700001)(26005)(6512007)(6506007)(9686003)(5660300002)(82960400001)(8676002)(8936002)(83380400001)(44832011)(4744005)(38100700002)(2906002)(4326008)(316002)(66476007)(66946007)(66556008)(478600001)(86362001)(186003)(107886003)(6666004)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LjkN/mPWki1NfKawhzHniC02ofccf+RmSwI1DLar92P2Y8q8Eke37lA8tZUF?=
 =?us-ascii?Q?THcQuVO1y1Tm0GdZ2fr1Wwx0qChMSTxYhY52u8Lb46DMvi2gZQ8cyU51vcrM?=
 =?us-ascii?Q?JbJqKStSyBWm0TPkHxVpDwLMjCU6dVjWHOsIog8bXce5aPEC7xZjANEbr6Ea?=
 =?us-ascii?Q?MJRs+dGzjLh/TkXjN5lNRqWDBd9TjGsCZMpnGZgcYMI+yQnSO6GquG06myUr?=
 =?us-ascii?Q?z3T9eeJVDqY+NJ1DcKM7UUXz7cM0mfDVQFWM8m8AXknwHaa7+pnpEjEOd3Jm?=
 =?us-ascii?Q?CBdLRa/DqpnJJvy5YGnnHO7Y4Z/k6y8LO9mpBq9sEpE9vGrZskhYLAzvCKhJ?=
 =?us-ascii?Q?t0q0W66I8ps9ISfQgLFL4UTJyb3BS3lP8+atKHbMUqum2RQu6/kJvoxxXS3g?=
 =?us-ascii?Q?doebn2WyQfS5uZaN2V6j/yYU4t7EBW12jppdjv/Vl7zllJuQQvrXum1R6/ET?=
 =?us-ascii?Q?VjNOVFx8KYRAjcNHwCLw9gd+LI/dMbtnMHai2HfA5Uq//kFHyn9CM371aFYG?=
 =?us-ascii?Q?KGF9wIm1MU9UjSs21fYFrP+0j7y6AjuUdNWu4UXYaOcByT1g0BfjkF+SsyTy?=
 =?us-ascii?Q?YutxtwGpObYGOk3W3oOCVNDIqAIkpyTlz9ttFp0aF3C8VO5pbjXrQQ8fWRqQ?=
 =?us-ascii?Q?rkSGmzW2mrz+22+A65pbAe1mNjnnv1ohft47mrGVARB0Tjscl5TVQeYjJKPE?=
 =?us-ascii?Q?7JE7WT+1q9xyX5J9JJsCjQ8ovgTQMcwPTtlUTFNtvcIteCXPmOqw9bumjR3y?=
 =?us-ascii?Q?Pn+OkputcjmAO7NZHOvY72+40MqrYprQSHmumA5/UhEmAqqbW6uCHpCVphBP?=
 =?us-ascii?Q?Bs0gmRwNq8ORmFs7aBvilRkO6EFQu7tpQPpZA1RDhJZvciKae+lmtgqzPQxF?=
 =?us-ascii?Q?Ti2Njpz79W3ip2S1IHDLNxIMAgz4UIXdC0MGJauSV1SQhXmgdy3a5QMH5Iur?=
 =?us-ascii?Q?bixvVQ1mbbfMbBKQOybN41or3/R2xH5sYKW9YyJZ+3KE3FpZPC4XLlgxHJvT?=
 =?us-ascii?Q?9w1P17Bt4WPvsEhFTTEgIkSZSql65TfFXG1G944Kz0cAipNN3nKwoYlji5Qu?=
 =?us-ascii?Q?vh11UqnT9aRKDNjpsmz0V4VjM0p9iwHQ75VdFZRdBceKUjugHjPo6Ah19sK2?=
 =?us-ascii?Q?jP6ghspcnoNa6VP+QxgaheWmusx8zSO8ZUxhxqlOEy7i53bIef2o63mGZf+N?=
 =?us-ascii?Q?Kkjj9zyc3yts8FP+4S5pKNlEU1A9jEs2ATvsZX71Qtdpfn2Wp3DiaDhGX9oA?=
 =?us-ascii?Q?rVCFcTKzTwaPn2hprpEtVrKv+HDGM4Y1FD0LkLcz7pCPCyjzEmBU/47yy+9A?=
 =?us-ascii?Q?XHzhPlze74wnyfKVhUGMtK8hf1SQrIZKeys+LJdIhxFe1jJgHEAWZJyhT5VL?=
 =?us-ascii?Q?j/sMIKEtL5+1iCH6ZxOigib3p9q/J7Hoh5wcxtN17y6W2DRtP/l7amsvwstN?=
 =?us-ascii?Q?I+/snIgJxD+/ztIU7E3/Dbz+1IPg33xOBDqCVDn3JzKwgvfc4QhQREPOmq5D?=
 =?us-ascii?Q?6H2iPDhRhjCKzFiB50FfBYYxslUPjZYwNaubBVC+nXtNCDXxfM/Mc3Ch9e8n?=
 =?us-ascii?Q?37hUkH6mGtzH3rrSUj2DbM6mr60/zjS7bHmltbi0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbf569d-5278-4a0a-688d-08db4744fd5b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 17:29:43.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYswEQdEk1qrToiVxj4e3TYeaDM8c2ykntga71WVUt7yX7pmJOVGhyqh9dF6ZbSbLbmVKdFH8mbtc8hb2pOjPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6300
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> The 'cxl_switch_decoder' member in 'cxl_root_decoder' must be the last
> element due to 'cxl_switch_decoder' has a flexible array at the
> end of the struct. Any variables placed after will be corrupted.
> Add a warning comment to 'cxl_root_decoder'.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> ---
> v2:
> - Clarify subject (Alison)
> - Fit comment under 80 chars. (Alison)
> ---
>  drivers/cxl/cxl.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 044a92d9813e..7db7e217b6f3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -419,6 +419,7 @@ struct cxl_root_decoder {
>  	cxl_calc_hb_fn calc_hb;
>  	void *platform_data;
>  	struct mutex range_lock;
> +	/* Must be the last member. Struct contains a flexible array */
>  	struct cxl_switch_decoder cxlsd;
>  };
>  
> 
> 


