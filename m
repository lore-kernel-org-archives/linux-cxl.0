Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487EAC352A1
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 06:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiLFGIC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 01:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLFGIB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 01:08:01 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D542DF0E
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 22:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670306879; x=1701842879;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VdH2xfM0uxgZx2QPAXfG0abvnBy3gJtO9ttNfyjC+tk=;
  b=AGh0+1Rv3jFHJKp5WUA9rOX+KYqHjhjSR0+89Eey4pb/b8mSeI7r0RnX
   smvXFwjAfmK7CWRkXNgP7BWqhpeZ7Y0zHlxif95P0ssLn75YvQzLvDXVm
   mOdt8EPk4oudiTBS3CEVsRfpG8zQefqeWobWZ22M9+i1LkeTrFIZ0ZBvk
   UVqzMgjNhPenqqrsBxZTwp30FG7uMK/B7CPeuTkwHb1A/bMKKCZs6XEij
   or3ZMcH3f+QIDaNcKvNNEZ8Yvruz0XRex1jKettJO0jCWFjsUToM5HMry
   D/jhVSdN5mXRja72t8c6OczQwFrEa+5QBGdwAQYOeiZMyCprt6biEHt8I
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="378709326"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="378709326"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 22:07:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="752503201"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="752503201"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2022 22:07:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 22:07:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 22:07:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 22:07:46 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 22:07:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWK8jZVDu6ngPsgWMCEGsfZoJnueX/Xd/UhCsUzgwKWKy9eN10m7OBxApvJfziUZgA8Sc3l6LjqUiYvGj7C/T5TwedKj3gfu5U7dTgT+JRu9RyvVC9HJ+sdizIdeG8K5pIRteTHiIaBHYiJniAESP9k4wNCipRl3VkGc6rSel/JcAZah8FwHmvRfhGoVe6OfbHnXIdyV8q0ZC6Bpz2BK2MuWES2Ui+Ws1VM0VzUNgnUItuQrWFjr7RTu/Dznx5WWNGuw9S6vA2hwvQpnnwG9aKi/dHz3tm2WXEMDdrbIUGjHNfqEyXh3dBVHXZScjYWFat/5G7aA+g7H1kcCAsr7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwwCb2xH5ZNeRH7ERfwPrFziHyoSvnZUEJRT/b4/PH4=;
 b=E5Cyn8MMA7JAmgHZvaef4D4nkL5SRxJd+TVvJg2iCRGYK5uh6KWEEAqOEVRQu9lKuiYWcQlsqRFpj/kgDz8N19o25Aiy0JuhtNWQdHKw6rXFl+8Uen2IlvbUAHbLXxubekbgtVDJ3IpxlOcgYbpiST9cpSiSserzkoFKL/KXkuB8VmBW9e4RIA8JLplXZsHfY/xKfpkgvM3bXDYzAsFjeflDt01JvL8SwoK8YNidQeob9T2aOKCcS61pvBaRYdgfbn9BXLLydcuAnq2Vy4E1Iygzmu//KQe0Ur9Vr56nLXqkD3cnN833zU1ZLNOgHuXbhLEwoBF3OcP/2tunG9/zig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Tue, 6 Dec
 2022 06:07:44 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 06:07:44 +0000
Date:   Mon, 5 Dec 2022 22:07:39 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH 1/4] cxl/security: Fix Get Security State output payload
 endian handling
Message-ID: <Y47cK/dIpDIckduD@iweiny-desk3>
References: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
 <167030054822.4044561.4917796262037689553.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167030054822.4044561.4917796262037689553.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR13CA0167.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 75056845-e93a-474c-dde8-08dad75030b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2hIQy/2BU5boYfIdSQVjqcLeecUQ9YT2bFVnB8tDouSrwAd20rslNEUI5PHA1tmdAO5kWbP0ZkHF3+miIq359ShwHbBH2x8jq9MTTJzYLHFrIbsVEWbNB1GYGDDtWMfgdHFTYc3CKEH9aTVfh9lQ6JLG/SDoaVsQk2mpFgMMviU760jkI4d2ZV3SeWvoF/zge2VQ9Jj5HRddFORWqLcONU6pxVWEE8uM4ac0hE0f0EdteBO7Bdt2/wPpoVquDZci+u/x9Vebgf4wJRNBHCdAmcZ4v578PZktlI+me45mTCk1wK/tlLFutE2aKHLIFTMnV/gKnltLUGCfxPl7A9pEIKsb/b4vWh5p5pVQ3nJd35VIwzU3bhQ/mojEyfUkKYmGQtaTyejIRWl3DrAOp9ctoqR8Wfu1Z+GdT6MiT/3St2uj1HBiSom8roH2rdN3i4vYVMuZsSYx09GJF3VXVsd3HtPwPd7XoGncdC/57OrBAsPffg9hJMWjpIG30VEq0nRV7e/SQ8gjeGp3nGVOd6sNS1U7+EW8EWboBIKtc935cjo/6zD/wDxa25OF0fUMdbmiA8E61Q/QvavJ/6/BfeWpSaypg3/U4MyE3EBKpfvmvL1D2TBcyVDq4riIk0hDVGY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199015)(66476007)(186003)(54906003)(6666004)(66556008)(66946007)(4326008)(316002)(82960400001)(6506007)(478600001)(38100700002)(83380400001)(86362001)(33716001)(6486002)(26005)(9686003)(6512007)(8676002)(107886003)(15650500001)(5660300002)(6636002)(2906002)(8936002)(44832011)(41300700001)(6862004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fBbPTQB5aKJ2eoV6EO7wG4KzzOBJiksLSm/L4MPanstfAUEiHIFst1vFpqu9?=
 =?us-ascii?Q?IO55Vg0qdlfXas7UmT5nOE3tr76e7LrrEeQErR7zrxnBfv7uYYuxLB8rbwPq?=
 =?us-ascii?Q?GpuN9cm4nRH+cOlUhCB1EzUlFbjjXf/cysAfjIEBKXYadbAzK9TY1jiN6RMp?=
 =?us-ascii?Q?/xEEexyU0TlbxunGHJlTYFV8j/D7o2RLnb7WQfPGF4EsnVrkqp5mue26vH9H?=
 =?us-ascii?Q?kYL3Su45mlP7lgiwwTaU1EF7Ql4tOpr5U3MkO1u9T3OMe3U3sR6RyY7j66NE?=
 =?us-ascii?Q?brtB4/ljc29wk4l4E04bjtP0c17GewPNBSzZp01fEHnOmgoqTAGvL7/Wgybr?=
 =?us-ascii?Q?sndvPetTDWzOsa2KEBvkkDSbqVGCdAVsSWwjpPgRbuB5kDezy/+Usd1OuFsk?=
 =?us-ascii?Q?Re8xBPR2r4SU5Rz6AYbw62EavI/J/NpuPQThdM9nky9iIKg10vc5m+OuCXmL?=
 =?us-ascii?Q?ZFBaLJjlbyfyALbb0tIppoePc3CjxwRAfgTTjJQt3O42zuLhmiXQdbbJCqim?=
 =?us-ascii?Q?xH3it00txjwNRQug2z4+Dh/6z99YpvXduUdJScqPDmmw736mETQNMV8jSAKi?=
 =?us-ascii?Q?ksjDjDfLU7nnZhGR4/ckQhYjXVm+vxwqABQVj9IepK+YpKY6D7MtpAR2ZdMs?=
 =?us-ascii?Q?wa1ucgGbGNeWsoGY9bYOiD8qx+wuKWmZHaysGekMb37fT2Y/Mn0FikK4+fJ0?=
 =?us-ascii?Q?IXvcbd/EYR5dBLKZHyDJ2ekotp+ZrtexuMZEP31qTOMNN3TY5+n0EvSDfESQ?=
 =?us-ascii?Q?vsMcMATvdP9zVICQe2oYWaWcyJ0jlqdhW1qQlvxKbnsYuklu+axs8Bx6py2S?=
 =?us-ascii?Q?gAmqSIfylpuSedI+yfAIITjuG1DvLJ2j99oQXorKbXoKBxCaniqw7iLEgUZo?=
 =?us-ascii?Q?gRktdJDH8JzKmsGjTX6pzi4Cna5pXmOun3DgjCfYnR222yBICIO1vszwg56i?=
 =?us-ascii?Q?p5stAdj15jcfRsfk0g7TVPYmjrBXQ5tTxPylhEEbnNTbP7Em0JFBAKdZJV2H?=
 =?us-ascii?Q?B8j6m4bvqu0CbYCE1eUWoAOHMfPCJYEhoyEItu+Z9u8vZARDQZsSbRaI8nxK?=
 =?us-ascii?Q?nWeC/1sPVko8rdWS0D91gGp902g/1OzneXW8pTj5TDnyd6GmUub1Nhe2WfBd?=
 =?us-ascii?Q?vJysTMD6QgvXQZllqHT2HDHdooHAFxf40f3pmX4gqEu+5vEVV2Y/MT+HAOGb?=
 =?us-ascii?Q?gpoEeBmJywt5h6+zEl4zTnEo6Hhr/ziDE70C83p8jMgsWHRe4wVP+EMacGN+?=
 =?us-ascii?Q?P8DscxN/eYoxSzPS7iBRGMYUVa0LoiN1nqJA1a8qsENeXmVD0dAy4ngcUHbU?=
 =?us-ascii?Q?Xbosx3P87PeflIpugjEXZiiGHAuAYu8mFG18ms+kos7XM4WI9gFaHEqHkMvj?=
 =?us-ascii?Q?kxOK2K1lgPrsaz/IPvVrhWlCc1mm9XYgujWstruF48EhE41qvY/d8M7ISwle?=
 =?us-ascii?Q?sWiTLiIGs5ahZITnHMkIepXj2AeZuph8ZdDqWN95OHc7+qFd7yHXt1/mnQ+r?=
 =?us-ascii?Q?KjkfNQnKUP6WVtx2dtMBlLyl7CTngznpMnk8UCbanvjwYJkDUf9ATWIF7I/N?=
 =?us-ascii?Q?wXy4p3bBri2QoDl7eC+W9rq/ZHwTNm1gU8UWeGCW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75056845-e93a-474c-dde8-08dad75030b9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 06:07:44.2594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tf2egfWASD52TNy0H3UPKQbu/iINvOSwMR7lmrSLJWNEX7/L2OG45b92Kdjm/3M24LJAaQczIOhcm/Ihlrvj1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6098
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Dec 05, 2022 at 08:22:28PM -0800, Dan Williams wrote:
> Multi-byte integer values in CXL mailbox payloads are little endian. Add
> a definition of the Get Security State output payload and convert the
> value before testing flags.
> 
> Fixes: 328281155539 ("cxl/pmem: Introduce nvdimm_security_ops with ->get_flags() operation")
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/cxl/security.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
> index 5484d4eecfd1..ebb78b8944f5 100644
> --- a/drivers/cxl/security.c
> +++ b/drivers/cxl/security.c
> @@ -16,14 +16,18 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	unsigned long security_flags = 0;
> +	struct cxl_get_security_output {
> +		__le32 flags;
> +	} out;
>  	u32 sec_out;
>  	int rc;
>  
>  	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SECURITY_STATE, NULL, 0,
> -			       &sec_out, sizeof(sec_out));
> +			       &out, sizeof(out));
>  	if (rc < 0)
>  		return 0;
>  
> +	sec_out = le32_to_cpu(out.flags);
>  	if (ptype == NVDIMM_MASTER) {
>  		if (sec_out & CXL_PMEM_SEC_STATE_MASTER_PASS_SET)
>  			set_bit(NVDIMM_SECURITY_UNLOCKED, &security_flags);
> 
