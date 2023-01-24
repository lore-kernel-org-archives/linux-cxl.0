Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA57C25B50
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Jan 2023 00:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjAXAa7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 19:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjAXAa6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 19:30:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9784B3803C
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 16:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674520255; x=1706056255;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+WhUHbDAItlPQ42/26cDHmj9X/yPhKPSTDTYBtySh9Y=;
  b=GLiQrNTLBZm6UIWj3s5G4KnQaencWYG8Q4r2uS7u2qTRab4yCcn62W6t
   jxqLzdSat2waWIS9/suCfAyfvx7hg9DC5zFMEgiAqxDFEMqEHK8Fqaj1T
   vwqhIUbimmDxNgzytsPu9gceCDc50rseVjE/ilcVcYoUVq5gqnsQoqdh4
   96k8U/Wi9rkMixOd99mS37AX+cdTnxrbDTd2kCnyQrP3nTsZfRQnBowuE
   z+c/cTpcaa2g2LF6gL92TyyizSPL94mP0NCvcpIfqGMZDTXLl8aDIx4gs
   AQWebMZsgsqtsOgIr7lF4yzxzcCLuT6OuS+EONFiaBr6kOMxbC2CmwRM7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="328284852"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="328284852"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 16:30:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="663885549"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="663885549"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jan 2023 16:30:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 16:30:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 16:30:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 16:30:53 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 16:30:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxnMiox5TeTGBNrw1EH7tA+/wPc980gEiK5Uf1PsQmdVNbAv5x0T3okOleWnjsACxt61+mY3uxBMZ5xeStpUnpki5M5sfNrFHazZc7Jmm/6IPXduiaxscs0QBrAaYVHqJgW7vR1vIT5KXgcO6ei14GZIpuN6CsHDxt6Y1hgIYFOsQvJoYRtkVW85d85wYdBLuFewPJzSf5m6AZpNpYnhY6nSY/9hCzw6cby5nrkeLkZg+z7h2QbUXt9RU9D1P4B9WZVgkg3J1PrF+SHJEoY+QMqOOhGJvz5NZvkiCPzKH3BhoVYSee6kjVfaODJ0WArpvgy2GTm0Lo/R0meM+fIZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrCcrfnDIlWy/F43hz+3Yc+kwOeIl7uhOj9JhpU2N2Q=;
 b=TQtw9+XqznZr/oLNyElVtM1WFBfHddvaUrWVFVnQveoagdl/d1gS+0gLiWgaa37eaqEHGG5El5CpvZa3iodgEDmU1qDTYo1+g/5zIIoVto0dFW1RIxhKMatitULcnlal1Bu2Uf2qpcu0pp0eXq5BTibZigLYFLhPpJX8UMAgY9OnwOAQGaYKJfe/oiA64al4O6mqVoIHSr9QcT2L7t75jtW2dpZ+fwsP62/K+fi6H2i0HHSXCOLhPgGcUxjGk92iSO8gw570BLVWoKXKRnhEsuQ1G2wvJwfBx4zOvAwEcD7sKdO/5wEdRxUgFkw9VdFp58wpaBnkX7/sTRhAOuruHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5243.namprd11.prod.outlook.com (2603:10b6:408:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 00:30:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Tue, 24 Jan 2023
 00:30:50 +0000
Date:   Mon, 23 Jan 2023 16:30:46 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] tools/testing/cxl: Remove cxl_test modulo math loading
 messages
Message-ID: <63cf26b6cb40e_4a9a294e4@iweiny-mobl.notmuch>
References: <20230119232937.533986-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230119232937.533986-1-alison.schofield@intel.com>
X-ClientProxiedBy: BYAPR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:74::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5243:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bad823a-39c1-47d9-1b40-08dafda23e7f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KH1sbgFNg8MvF2e/yZDOtIuqLMeH/B+WeriPHNEmCcECW/hzuCgab/UKshL2YztmSQ/4RZyFQiIqcaEFRUfXmuc6v4ldqSVbun0bQ3YX2iYZXOGdNmaNSQILJu/c73c5KgD4jA/lTL1usDQZanENgvw9m86U5AvnS3lg9fS+i+AyAbXXXDHIm9MpfhLn20eUaL9KgpsfHDvvY+WFF5aaTgbNhArkxCa0/9NVFQhP5g8oa0NqWO3/pktbvlv5I8WcBpWMkKBOtR4lffwg03OY38J5O2h08pq5lKpOX+AGI6LX00u1ML4NnCnbu7xsX/+VI+xhvKvGAlE6FhP2ciUU9WUsct6uBM27vQkw+3nfKhSgxbWzyAMY4SJop9lEaPbGeicRQSJ1xt0l9XaOFvE+jkjJK2mTifAR7apNkNA68mLh5b9GnFOWpNTuSv2J6ZNOyzJorMN34WL1ZRdf8MHXkPKLaX8+D0PxWAggjABb0n7F8RtHYsgk0eM0aoUcT5nvHPdF1fK1it4bxggapSDcPzU1QO7nlURF1xO3sb1ZdUisBq6VXh7bqKsiuWswlRwPSa50Zx17s51n7Bb6Y6uiqoTZ83OXDgyxU0NgWNjTXF0wS0TKPK+567QC5gCrg/lLM36DZyX67ztvkVKnZUdHrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199015)(2906002)(6486002)(66476007)(4326008)(66946007)(8676002)(66556008)(9686003)(6512007)(6666004)(26005)(5660300002)(8936002)(41300700001)(186003)(15650500001)(6506007)(44832011)(83380400001)(82960400001)(38100700002)(316002)(6636002)(478600001)(110136005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JGqQrJ4Tx0AXAUGEZP8p0BjdAd5nk1vJ/4c3bfopfYAXtGxVVJLfS0h5Drm7?=
 =?us-ascii?Q?xxdkcGrWoIdq1w4AYIcmM5SXmRjb1zzas5X+hOWg3yawtQNwUs+/smIvhlrq?=
 =?us-ascii?Q?QIf+sHj4KUOyHtvIr0taqVteNG87i1FtahJ7eeC/BhwWVRoxl0D4WSSb8kHd?=
 =?us-ascii?Q?olUuPVx+aOqF4ngqtk1yA4z49ded9onoggts959SSnxoebgz70PzpiJOG92L?=
 =?us-ascii?Q?dVZSnLnUOTktOi8NPK4LPy1iWoEwLrog0vjhmDGFDVc9DXALLKEHmQ5uTk+S?=
 =?us-ascii?Q?3dPAjMmCjR3lXUaS4WXaqAOzq1dPh1A7DXaHk4zUWko8hiz7N1ZIQyT4A7dt?=
 =?us-ascii?Q?Y1XnnUv2FmFaMSqmxHM3Alcr/ZHYTsOei2LaFwH4j07BIksZDX15QTZRkAlP?=
 =?us-ascii?Q?OPTSaUXKTTAjrd7mPu/Yu/LaDYgRr0obUgU+osDqV3mMCfr3kccRYzINfeBG?=
 =?us-ascii?Q?h9phEg9RoczNAyFfcpoGAUDSFVz5C38Pih71ebyuGUZuJ+jvIRORz3qEPSBY?=
 =?us-ascii?Q?YLdPmwR7YNKVoUM1Fv+krZ+pHwCbW0MEgn+gAB/NjBoajBfc4CW4j7SaJ//T?=
 =?us-ascii?Q?BEslawLOUGGoQXiLlQdrIWPYr5gvxgM8+pR3vnZRjuKHbHTC56FdZff7arGb?=
 =?us-ascii?Q?cgckrHAASzFBDRmSJs3Tgng/9T/oZmd2hco1AVDibFvS2CCSPTkBoO6ILVUe?=
 =?us-ascii?Q?F10TYLG78f4Yj1skVL0jwCQ3RMvJy61rbjCYSNmT+ysg/8DTPRIFYG0s9vJe?=
 =?us-ascii?Q?9odEpWIaoKrceU7CfJKxEgy/HLbEsBmAHWuu1u8tln6osj1+rw2yQl50p6b9?=
 =?us-ascii?Q?q06QKqPw+IgVNgaynInL5KdGO0DPmGaXxyMoGnUfAi16z5KKOdRVMPbu7S2E?=
 =?us-ascii?Q?ReRldQLJGnm94ITNRbN7LdmS1MLIl+F8bm0+K2Msdw2o4sHZ/z9/0rXBudE0?=
 =?us-ascii?Q?N1zw82Lb8SSxOUUuHh3Y0Dv9Rsf8ECaqRPT/+gJ6BSr9jz0nFsmHRmPCGtbo?=
 =?us-ascii?Q?ZQCascPy0Sh1IpySBEZVdHTZVdffisCthmhtfebH21kVsYq96apZ+jYkufsF?=
 =?us-ascii?Q?bJc8ziK6v5nb3misJnSQ5DFKzkIQP/mTl7yvgcT9ZvL3mXi88UQM6MNXNyb6?=
 =?us-ascii?Q?KnEo22mEbK1l0XUi5m3Tw5M+2wpQwDlrBxJxLSLhCk2m7EGEIkQoY0Fi/Kj/?=
 =?us-ascii?Q?1+dzCC9NerzwGuEvN0mP4TnXyV2crqHDMmT1l+7TCJV+t1jTD3RH+3TlUXpq?=
 =?us-ascii?Q?mdHNSEebiIzP+dD3wFTIRpIqeVyxPVpv9BfcMjmszMDjQolQtXlpe9PNNujn?=
 =?us-ascii?Q?YhBj/e0lgE8qvpNtj592pdo5Ni8F8OHVRc6NiFI8jl+VpEVW8AE2v3g/HuIE?=
 =?us-ascii?Q?PosfvMSnSuBc65E5xyzpjd/qKjqPxjvmkF3KDJF/Vsp1RIY4qBnijrZh9m7Y?=
 =?us-ascii?Q?mA1Up8XPKWIexAkn0622vB739VW6u+o1e+XxYkEXNPMe9JTyJnFk/w8MPyfo?=
 =?us-ascii?Q?nBYz2y3VahqtVTbxacb2D+Ui4ZSINz8uv1IyETqqbmlE2JS/mV5Z19Wcg12J?=
 =?us-ascii?Q?dDXGsP3ZyveQeO6DjsBNanPQLWHUKiPKOceHJctk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bad823a-39c1-47d9-1b40-08dafda23e7f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 00:30:50.3892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsOrrBbegSg/DkBvWIlOwt1quFh06Uvu6oV6Zfj0fluF0lW/21AH9wFVCNHTxaddccylw7jfzPrRGgJlnwniZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5243
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Commit "cxl/acpi: Support CXL XOR Interleave Math (CXIMS)" added
> a module parameter to cxl_test for the interleave_arithmetic option.
> In doing so, it also added this dev_dbg() message describing which
> option cxl_test used during load:
> "[  111.743246] (NULL device *): cxl_test loading modulo math option"
> 
> That "(NULL device *)" has raised needless user concern and the info
> emitted can be discovered elsewhere.
> 
> Remove the dev_dbg() messages and make the module_param readable via
> sysfs in case a lookup is wanted.
> 
> The default option is for standard modulo arithmetic, so when the
> interleave_arithmetic param is not present in sysfs, the cxl_test
> module is using standard modulo arithmetic.

Is this correct?  I'm always unsure of myself with the module_param code
but I believe the sysfs will always be there but the value would be
"Modulo:0", wouldn't it?

> 
> Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")

I'm not sure this is the correct patch for the fixes.

Would it be?

Fixes: 7a7e6edfca85 ("tools/testing/cxl: Add XOR Math support to cxl_test") 

Ira

> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 30ee680d38ff..ede84de69f59 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1135,11 +1135,9 @@ static __init int cxl_test_init(void)
>  	if (interleave_arithmetic == 1) {
>  		cfmws_start = CFMWS_XOR_ARRAY_START;
>  		cfmws_end = CFMWS_XOR_ARRAY_END;
> -		dev_dbg(NULL, "cxl_test loading xor math option\n");
>  	} else {
>  		cfmws_start = CFMWS_MOD_ARRAY_START;
>  		cfmws_end = CFMWS_MOD_ARRAY_END;
> -		dev_dbg(NULL, "cxl_test loading modulo math option\n");
>  	}
>  
>  	rc = populate_cedt();
> @@ -1326,7 +1324,7 @@ static __exit void cxl_test_exit(void)
>  	unregister_cxl_mock_ops(&cxl_mock_ops);
>  }
>  
> -module_param(interleave_arithmetic, int, 0000);
> +module_param(interleave_arithmetic, int, 0444);
>  MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
>  module_init(cxl_test_init);
>  module_exit(cxl_test_exit);
> 
> base-commit: 589c3357370a596ef7c99c00baca8ac799fce531
> -- 
> 2.37.3
> 


