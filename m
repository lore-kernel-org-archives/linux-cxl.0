Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98624C32793
	for <linux-cxl@archiver.kernel.org>; Wed, 18 Jan 2023 20:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjARUUu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 Jan 2023 15:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjARUUs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 Jan 2023 15:20:48 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832554FCD1
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 12:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674073247; x=1705609247;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/WuLKYD7ezYjXaXFZm9Wjq8O2MVzudYN/t3UuTjHpfs=;
  b=e5xf0ZfoDjmSoWNMk9/iUKr2PxoW8/7yDAIvOuX9AAGqRPC89TiTBSef
   e/NZYWWnUJYD6N7/K1cHB5AMdjwDiByZYXHRVuvmCKz/fpTgd3rLi3r4q
   gjpDwp1aFIBLuOuc/B+vdkuuOyDc9u1Gdpd4YF7A3af04o1KkU6NvqP/L
   1Gr3kiAV4nSeZ/52XGNfGa/mQ/qNXSb+rYORycOaFCfLV51JmAg+eOGIl
   jInup0vCTi85vxumZdh2jCudkwj3PbjLdSarLLAhm/0PteEmv2YZBnDmT
   2f7gtQPoeGkoLq1KWFtsnxP6gTrSE16U90eB1jOKckqhGGQ8toGjp+qGu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="411330865"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="411330865"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 12:20:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="609798877"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="609798877"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 18 Jan 2023 12:20:45 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 12:20:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 12:20:44 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 12:20:44 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 12:20:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMcwiAqDk5kVhjoocd1QxWuUcEpgUzcPVZ8/Xgz7F2Fc/UF2etSb1FIZ0bT3+2N7cyVLJKAs5VZB78ZRLrN9yjattSTOVG05r2nt2M43tXy7oCe6IrSmA3Boi0pjjQ+hsTT1bw8dgJiOqHpXSfzGfFQz2VK4jmN+du51mW2dkNQIvfcsdwCNNfxY/0nkepT7Yse47yfaKerTrvfIDvWnECioXnx6QpeFPxmmooK2XQ8sayW2eZcTk3zycnonWARpKaI0bnap0SLA5o8jABvUEez34J9ZZOwBZigmUvrS/x0RNT2A+6aD2chkzMS0sR69gh9RC95/6NczrUk4KbYl7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HA3cRSoYtkIgU537JOT0aMDIR0/zgbVHNPc2O7U/ubs=;
 b=lg08J+HXO6slZ5FpevS07FV8O67hEaDLR57637LTKZwCV4aAw3FJynki/O9mMf2sCLwNi5rymxsroG3b8pmyW9u1PWB77UfrHoDVm3hWFF0pwdvcN2iP+fT46Z079coWXZaHBavf/gA8zWtOfAa+Ol4qjhn9gfhCpw4hcNBzCAiTe5jkYmuqPVxlJR0ru8rCL3ICjEkxkOBMQtELIm0fuiq/vx21K90Agn3pIChcIdrxT+A5Zcp/xb009GprbrjeSaH4Qr9o2HJWRsoI686PdZhfUvmYDj4fFTCzqBXv9s4NbpUBma9kyMbHjhvPJAYREbUaR5iLNiPKd4LXkMlF/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7461.namprd11.prod.outlook.com (2603:10b6:806:319::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 20:20:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 20:20:41 +0000
Date:   Wed, 18 Jan 2023 12:20:39 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v9 3/3] tools/testing/cxl: Add XOR Math support to
 cxl_test
Message-ID: <63c85497274b5_c81f02941e@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1669847017.git.alison.schofield@intel.com>
 <54670400cd48ba7fcc6d8ee0d6ae2276d3f51aad.1669847017.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <54670400cd48ba7fcc6d8ee0d6ae2276d3f51aad.1669847017.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 3995e3e7-534b-4f1b-70f7-08daf991785a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4byP727OkhS0fclZMydpfvv7kIp385aMLrdwoeFW48MMFh+lxLZCYzrg9KPb0+l3Rvc7xAIHiyYnZv5zXiCfYqJSguD2CP9pmosWFVInYBED+cv32dHPXL7Krb7wut+D+pNTcXZFa0tjFLL0wcSpIVxm2vH1sSqMj1d5Nvyhn94z1OeevXVMv9Pw2zn4mtHA/o6iIQnOfYCe04XGSZp1yHbXHv5wP+wOMnPc7CcHiM24p+3B6+LhQsd/fyJOfPV1/pWxhwkNmx2c4mK4UpNll/1C3PgJXly3hXejvON2M95eDBKq9p5rB++IOscQutzvcvZlFdadaEvBKZ5S3QTtuaOE24jEWAT/sfNaFW49zv5XbF/tW/xIJ/pTl68GZfOIL2agrxHUaUwbRpw48BTLLwnF31xAsVohM5fuNUMN0ldyQlEGuGh/Ktpl1Ey33SeODwW2GSNicwNjIo/kFvI0LZUoooChPhw55hbOr0PZpPh5AJhBK7N9gJuIisy5xtfwCMFJjN8CnEoEJ6QzZ5XlHRnRqLFVO0niKa/uyKwEswtmUbEiDDFaeFg1y0Fbz771Rg8bDHIodKEXaQRKJaUudCS9yPcqFrPi68LUfkwp7G4xFzpB31rhHacC/jYOBjy4iDt1vM6LtGUEdi9T+03jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(86362001)(4326008)(186003)(8676002)(9686003)(6512007)(66556008)(26005)(41300700001)(66476007)(66946007)(316002)(6636002)(54906003)(110136005)(6506007)(6486002)(2906002)(38100700002)(82960400001)(83380400001)(5660300002)(8936002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QbZuwSudNlaGv5tPNkOJ/84U/s428G+wKmAunn2qlijTRm1jky3sBsL7rjiW?=
 =?us-ascii?Q?qaJu5wH0yR+cYHmxLFF4UUWiXoBgpUUj60/NopR+JB3FjxRu8F0806fDmemf?=
 =?us-ascii?Q?tucgyXKiwXy3C6GvVjC97zQAK1rpJzgfVrUBtIxH3DYavOXeJgoi6EAireVJ?=
 =?us-ascii?Q?AEun7dkrHXhWK5ggmCk+GeXHcOY3bVRIyfhBVMErvKZagbdoNnZwuh7OowQd?=
 =?us-ascii?Q?IEq5jLGGelXeCW8t9d3JW6ge5uRrId8DZfj1LFmmYEZu0BsZNQ3h4Urfl1BT?=
 =?us-ascii?Q?VEL0ItbqXYkqwWprVfYuRwdrUn23e6MKtbTHYvYcZFnHv8V2BP3GjyNeNoqG?=
 =?us-ascii?Q?5dJtS6COijRbNOZyWeWKdmZAVTOknnrtPSzx41WnDcPvZEEUAE8oBrHUT9Ba?=
 =?us-ascii?Q?PHVqhnZNU8V3C7duOnkO4X4AJCUdHUyrmYD9SWHfWBjdy0tjaar/1pCv0sa8?=
 =?us-ascii?Q?QdLHcOuRpoVaWAn+QiKZLaazjgfsOziQQJnLfkpOezsNO2olFihHT/TMsczy?=
 =?us-ascii?Q?apzTyjzB7GMLG3tIyLqi79My8H8ENqOE1iHscK4LlgKHdSMEzZ6P7SFIJtCj?=
 =?us-ascii?Q?rgd0cNa0TcpU+QCxiLlRGqsk/aCAV9fKDhyduRnAnff+lZvbG3rmX7pELwN0?=
 =?us-ascii?Q?CZTlOzl6+ZXaewrFxGJqJU3Rdh4IKLlZMLbcY+XvIg6x+dI4TeMo2U8kHL0L?=
 =?us-ascii?Q?2R0duI15pSn3glTXbzyBulnCWXKZOAxBGeaz+0h7vtFUBivsmHAvhUuyMcPs?=
 =?us-ascii?Q?bsdkVLeMzE8EHEZapa7/MVpY+EpbRYksjBRSZ13Um2vWVFWlmJPHpRDK1ABB?=
 =?us-ascii?Q?RDKD4I1NFk8CTmjJnR0IWvSOlbyFP3dTFdM2I07q4vAaRxoqFYsxP6KSYBza?=
 =?us-ascii?Q?MSTqChiUqS8t95NEMO6FIjC1HDSKZstUyExrKSLyGflK6ToC1sBLj2y6/0J+?=
 =?us-ascii?Q?XQEi3bj8nqXV1y8Z7zq+4HVX9AQ78FqdzPj/RUORu7VHDIRnknI2qIUTrE+A?=
 =?us-ascii?Q?rnT0X2eFlIx//AuXWJ4NCfdFF5nv2D0cCtlai//yrxaP5PaDATuCgggN5KWM?=
 =?us-ascii?Q?vU/6K2NyiOBRieSJCmtH4yIcyN0squ8Xi/qBly1LyxXs0yA9YYaqgUI8LYZN?=
 =?us-ascii?Q?WrTGFuBjRyRbB/d+/iJkPS6VFdr5i5KOvQEr1TL07mTSNss/JnZiZsbdGqVP?=
 =?us-ascii?Q?fKCQdcpr7ThK4wHbAZZPNFmn5NQvs3/Uuffj/NJtAFtSGtbwLB1LfWCCTF5b?=
 =?us-ascii?Q?edxE3bCo9Ue5/UdqBVJaDSL+b/zMdxzyvhsyuP+9qo16RE/OuutY6yLYYPI9?=
 =?us-ascii?Q?koK/73WDDzyxbMJf6XKHZc+Gwepk/Fl20K9lINYaJ/kAcfrdFzRcG3vyZ2Jc?=
 =?us-ascii?Q?JW2FilpsFOd3+yhTccT4zJ5D13Y5CbDB/jCE3dBswa4wi+9bpIquRikAlMnW?=
 =?us-ascii?Q?uZkOv8pv613zaNgtHZDM1NJQHkdUqr+aKUM/lx+WDVIZevHkOof1ozN3Xr5w?=
 =?us-ascii?Q?1tXJHZoHSdGuTVHFHiFJwSLo5VAFbRShQKEFoFOUvZdC6vb3Wsl7NvW0lLCB?=
 =?us-ascii?Q?nUXJdh1o1g/Xlzr6dv0cH5LPCR8LXwEBgk8R8AHM1hm7dpOmmfZibTmrUu+t?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3995e3e7-534b-4f1b-70f7-08daf991785a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 20:20:41.4082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqkAOarWZ8IcOp1+KI/yn3HtxHTLhicxjVEmPcFdCRcKAuezpGydvH/uT/gB83eHCGvV1mO/pIQojoXV3wH2WlO9jZyc4in8X+/cm4aW65s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7461
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Expand the cxl_test topology to include CFMWS's that use XOR math
> for interleave arithmetic, as defined in the CXL Specification 3.0.
> 
> With this expanded topology, cxl_test is useful for testing:
> x1,x2,x4 ways with XOR interleave arithmetic.
> 
> Define the additional XOR CFMWS entries to appear only with the
> module parameter interleave_arithmetic=1. The cxl_test default
> continues to be modulo math.
> 
> modprobe cxl_test interleave_arithmetic=1
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  tools/testing/cxl/test/cxl.c | 118 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 115 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 7edce12fd2ce..c7dba7550106 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
[..]
> @@ -897,6 +997,16 @@ static __init int cxl_test_init(void)
>  	if (rc)
>  		goto err_gen_pool_add;
>  
> +	if (interleave_arithmetic == 1) {
> +		cfmws_start = CFMWS_XOR_ARRAY_START;
> +		cfmws_end = CFMWS_XOR_ARRAY_END;
> +		dev_dbg(NULL, "cxl_test loading xor math option\n");
> +	} else {
> +		cfmws_start = CFMWS_MOD_ARRAY_START;
> +		cfmws_end = CFMWS_MOD_ARRAY_END;
> +		dev_dbg(NULL, "cxl_test loading modulo math option\n");
> +	}
> +

Missed this earlier., but noticed now that I am running it. If no device
is available then just use pr_debug() instead of dev_dbg(). That said,
these messages could just be skipped altogher and make the value of
@interleave_arithmetic readable via sysfs if something really needs to
recall what mode the test module is running in. I.e.:

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 14530fe1edc6..b7d7420e74ea 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1265,11 +1265,9 @@ static __init int cxl_test_init(void)
        if (interleave_arithmetic == 1) {
                cfmws_start = CFMWS_XOR_ARRAY_START;
                cfmws_end = CFMWS_XOR_ARRAY_END;
-               dev_dbg(NULL, "cxl_test loading xor math option\n");
        } else {
                cfmws_start = CFMWS_MOD_ARRAY_START;
                cfmws_end = CFMWS_MOD_ARRAY_END;
-               dev_dbg(NULL, "cxl_test loading modulo math option\n");
        }
 
        rc = populate_cedt();
@@ -1456,7 +1454,7 @@ static __exit void cxl_test_exit(void)
        unregister_cxl_mock_ops(&cxl_mock_ops);
 }
 
-module_param(interleave_arithmetic, int, 0000);
+module_param(interleave_arithmetic, int, 0444);
 MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);

Otherwise, the current code leads to a concerning:

"[  111.743246] (NULL device *): cxl_test loading modulo math option"

...at startup.
