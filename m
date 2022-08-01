Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4C7C00144
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 19:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiHATND (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiHATMt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 15:12:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1104A264;
        Mon,  1 Aug 2022 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659380962; x=1690916962;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=llmr9PcaTkWs7QCCzXU/VRsMMWt7eKvsQCmxrsXR5e0=;
  b=Jnst1L+XEhxc4s5hw+ycVBQ3KK/0ukxB5TnAefYVXoMd7fNIOs6M/k3f
   udwlEe4xnaNw/NVvdq5CkMq8wKBatGXpLtSG+gKBKzG6YtqiImTiaxcNg
   LsCx1CHaJN5Rw47iBIcUC4aklbHqWlnrS2zwP4r37TWdLE1L/vh7vbCvX
   aj7SlVFD3uF5qq9GRIRGk8Twar/ZBQ79pqZ9L70/0pKysRPGTu+7CAGPQ
   jREtdDXtFrQs5qeY9U4ac6jbcC+g1gCJQtD67RSTjbn/+IhDWszSK3ozM
   pU6h7GSd9TyA2mXFOwDJ9QyQ1BtAPQX/J7R7/QcW2Y4m28S3TmxNyp3WP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="350934077"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="350934077"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:09:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="670153556"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 01 Aug 2022 12:09:21 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 12:09:21 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 12:09:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 12:09:20 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 12:09:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2b6uZz5aIRBOlyxBEG08TNV7raMzczjvS13DrOEIagjuXmgI3Ao3CzAminHRakwgfarEgYtSD7GNwLEBvCa7q/I9hxXsieQ0S+7hwVSqXiUrH7AvNfvklsjkaWTTXsHNiD7HjtpKBERCcaEdwUB6yfJp9gIr6xqBlw6hRvh7WtREquk08pBTIXSLfCL3S7oZON+h86zz04qzRuHJz91E+Mgf1cULuTbRMTHvhmDhJ6J9WAGXxA4QpddiNbSyWETYgcq+E4b/1V5ZLmpOXFa76aCk8OILltice1vWjSkJWrO902MQYiKcBeGMR7uU4lSZCK1IlR+y22kHp2FOHeK7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFvbdjce6I+5zmHiTN9vDmoXIoet8mXZ1TGbUIsPyL0=;
 b=GLq1MTN5GBM7n0zCoVMSVQiMQrd3IGuju5R+N+uvCRqiRPpuyFSjfLyiNYHueDLYVcQFlC2UuySx6gYEv6w30QY0kaQS0i/chVS2PzLk7mL87Tu+fsskXKmF75KuvV4SREvsnNUMO1hvyDKcoAjx/3QM0QqJBV65dGPAuK+U0op1lw+3F7f041ROe5vodIiKue7qq9mVOGj0jG2j8TQcR9t0mxJZvPHqOPRpU+I0L9qj7O3bmPeMqsUoFIcanfCyMed1lOQl1wGmVv9BJ5XBI+Mhz0bt3la/6RNs9lN0OjYvCm4BaJlxPy4kOmPEm5TZlZVMrtCIEM73NKZpSPTcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB3727.namprd11.prod.outlook.com
 (2603:10b6:208:f0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 19:09:12 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 19:09:12 +0000
Date:   Mon, 1 Aug 2022 12:09:10 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 2/3] cxl/region: prevent underflow in ways_to_cxl()
Message-ID: <62e824d66121a_b0752941e@dwillia2-xfh.jf.intel.com.notmuch>
References: <Yueor88I/DkVSOtL@kili>
 <Yueo3NV2hFCXx1iV@kili>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yueo3NV2hFCXx1iV@kili>
X-ClientProxiedBy: MW2PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:907:1::31) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00affa40-7a4e-40af-42d1-08da73f15186
X-MS-TrafficTypeDiagnostic: MN2PR11MB3727:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vxojbWF1KPgFmOpGNtYlMKgdy3uCtxBo0O3kpJCnpzKTIX5myyhbTAtqxYRc1zLCEpLpyMNw1C1HvOj6t75ubyqwKVynZwroOmAA509CuEgJKXndSs2gX7j+csA5ZKJxZz4uktsz8WL0dClthKr3OHzswD2eRMHORubs9oA+CN4dQMYNoTSZxDe81jQyFr5LLfzIPRWVifjP75dvfOYU/j0WNEboGYGWbG4FCU1V5XdfNE4UvcqP/GrM0oOo/zL1R6Bfuopzl7CiKVcPZyX/8YgsijMP9GvPil81oqkdZXeF1yfuJx4UZyVNf5z2JzQS6gUx3T4SfBHWs36FDsoEXOkySXGV8TDoU9eqFzjmulNNaGpGTkK3llEVQcijLT0vKTGZB3fa6SwlAzMSMkwwo+WzOG4BOsQAXS0qu/OTAsTZ4pNUHPAlM8EAcUBYPMoYI3Lbn+OwN5+jQYc1wXBcvP62rhaZLmSXB14257YKYwKtdpiKxTBvDAahmSbDtBYsK8Cog6ec/P8vcsM9ASqStyjqJExwAIH4UbB4uI76tRfMH6KsaFAzUkbBYiYVSKztCKNcbLcHlFYlBcf94hzNGHriiWfTX+TDAu0fi1QKd4MbLv7fR542cqh41Sp3mfr1I7aNCFMQ1A62WuVFrycigp6xxJkjVrScmiHQBHH/jxDLLpBu99xqU9vpyiPkH0x2k5rFlKSZKOHcy/4Zhhf4S7Q8T+NV1if1TLeFiIzQYE3AMew+hCthv9YLJBMiY5E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(136003)(366004)(376002)(2906002)(38100700002)(82960400001)(83380400001)(54906003)(8936002)(5660300002)(110136005)(6506007)(316002)(66476007)(6512007)(66946007)(186003)(26005)(66556008)(8676002)(4326008)(478600001)(6486002)(86362001)(4744005)(9686003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fuar8oAmoIkF+NnacjacVDOkxdY2FTFwiAaRUostPO04w0tDIjEurPX8mVtx?=
 =?us-ascii?Q?2HR3UOiD4VwOMfPfJWiWth0Kfwgbx0RKGaqVBGvz28JpaAufgOxhIyhldlRe?=
 =?us-ascii?Q?RWfTCxv/981HM2OTp1GAUGrHGPa+biVWtU69bijVe0/U9PC7re0HuRljUPai?=
 =?us-ascii?Q?SUcMuvkDwKUAOJTSYawVJELXljJyR3od06lXmrmgvDwb/Bo7cm7HHvbvSL8E?=
 =?us-ascii?Q?ajaKuWHEEy/Y3TP6McJgkyrwjUlddXS3wvPk4k35yRalUoM95xkZe1HqLlSN?=
 =?us-ascii?Q?VXcKwWKgEoQI0goLDQ4rmyWWJgC4lR/DUQ3jJ1BmiMiYotaFonjHnLmZvar0?=
 =?us-ascii?Q?h7WgMeD59CQLYrxWRIyjcq+u3VLU4MWHBq30dfNiY85Las49GPfIqvt7s1xT?=
 =?us-ascii?Q?dzJNvkcs/ThKAemxpOT/tRTfPerbslhVa5UD6Q89DgxIBnWbYk6WsMa94sjW?=
 =?us-ascii?Q?rPO1z7ilz66La9Sl7jJITlZm52MQlVrZkzVbMgDpV8DdW00trsal3yei2ARR?=
 =?us-ascii?Q?/8h1SX2DB8olBNc8Ap0q7dPLdNpk7qZrVngHstnr07jwXCFTYoPSyw3qwpPI?=
 =?us-ascii?Q?aB3LBU7Rava07w+ljJGlmUZ+tjqbCIOyCG3mDT4hPUc9wcQhyVoQeaww0tD0?=
 =?us-ascii?Q?ZvDfxaES8CNczIQtXdFTYf1Qwp4b3YQoUCA7JyUkHTTcNnVOQ6wbviackbYF?=
 =?us-ascii?Q?ptKh302cv6mw/qBNT1Ff+U8+fb93rwCSft9PQLMRDhT+2lREcRmTMi5c4bJB?=
 =?us-ascii?Q?TV9c0pK/wQtIT3a0e18ll8aldpCdty0BqXf9hvmgt5SfcsoVHlLVQKqzS/J2?=
 =?us-ascii?Q?iBcInhe9vWs9tEHQAF8w6gZFXSzmPcb0VYyl7twmqAPhS4TyfKpqrqFBa91P?=
 =?us-ascii?Q?mkVSb4tvS1bcMsCdyjAdCZukWlHEOO1WMo2RHv4qZF1oPotNSwHP83637iK0?=
 =?us-ascii?Q?/xpNMZsEq2hdWzggtA0BKOuMvF+dvLGsLju+RnlAUNB+Nx8qgkrvVk7kT0EG?=
 =?us-ascii?Q?gudj/JtUPGzf9+YaP40ugYIHkbZCwroK5NDRq6sRV9V3D/xuSK0x2KWKJ2/f?=
 =?us-ascii?Q?pKTauTxbJ6kG4z+FSnzKdW27rTXa0DYALom65pbDP0AwTab2zd9ZYoY7RxEV?=
 =?us-ascii?Q?DbfZHPvTF2fgpwNpUPG3QeI8FKLaQkjhYFmujzaeuJPcPqRHMuZ6lCHrvrOb?=
 =?us-ascii?Q?bI4UJdJuv6WGWXEcYNEGOZlbp5xVWNEg8K01uP7GMXHNXuTtHhvYkYj8lQGX?=
 =?us-ascii?Q?cXaVBj51ozqqwrX4PMFbpnrAbESmch3pA3BoNei5C+UjUq0iwJOG1Kkv7wbG?=
 =?us-ascii?Q?bWKe0xQoekDewcOyLZPM1iRBtoQz9eIX0F0jnmMKOoQMBQy+/zyimBxmn/Rx?=
 =?us-ascii?Q?JQpXpxm87bAkPN4WrwT9utTZL/uojcFaPF2Tv6tvPj5tMFB1jKIaqt9j9MgF?=
 =?us-ascii?Q?AIS7A4pX2VNQ3bhs8ftAYSbpwuKuZwvZv3jNRK+ZRkyxkkXemlbKKTUK+tqw?=
 =?us-ascii?Q?fXQfHMFaZeF5eFCKDJOwbAjqHADru6WVFlLeucHYfjRrdj5h/Zs3RnB2uBxg?=
 =?us-ascii?Q?J8a9RldNDlxKU/6q/N4C/I4fQZx2fdhwyxrU+MQ3iGvjSDWA4stEd46LhYPn?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00affa40-7a4e-40af-42d1-08da73f15186
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 19:09:12.0131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxUEWS9FiLQNzia3ngxLGt26Pbk5Ewm4H3+VjK3fvMviEMgEm+HmDDpJT0QUmA7wDo/F6tUrX6GLpyZLPIY6htNUKqafaavCCi7g4gQIwYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3727
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Carpenter wrote:
> The "ways" variable comes from the user.  The ways_to_cxl() function
> has an upper bound but it doesn't check for negatives.  Make
> the "ways" variable an unsigned int to fix this bug.
> 
> Fixes: 80d10a6cee05 ("cxl/region: Add interleave geometry attributes")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/cxl/cxl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 75674400cc8d..969953ce2609 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -102,7 +102,7 @@ static inline int granularity_to_cxl(int g, u16 *ig)
>  	return 0;
>  }
>  
> -static inline int ways_to_cxl(int ways, u8 *iw)
> +static inline int ways_to_cxl(unsigned int ways, u8 *iw)
>  {
>  	if (ways > 16)
>  		return -EINVAL;

Looks good, I'll go ahead and update interleave_ways_store() to also not
allow negative values.
