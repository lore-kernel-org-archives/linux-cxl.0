Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0238BAE
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzzclNLF"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0887B1721
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 10:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698340306; x=1729876306;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=ZrMCJwlGVffiKgkMoJVLHSSV4vjursT/MIxgUyRpEPs=;
  b=OzzclNLFqH7rJ2GxMaNDyqcMoX2Irl9oIjLbZHni5+uW+bi0OShPSAWt
   vdejrVWeJHmV85g/+EFJHw7IxaaGDdtj3JMKKB5WnZeO6NJ18LwOTIDYi
   O267GigF4yHTQUuDHc64k5oSqfQf/pRrl4kBFvp5RrKjCAwhugkSUu3YG
   auiMF6J1QPP/um4UVuYRlRmQaLxz9j58UEdr6rdvi+zDrsyTo26/viwKk
   BKr7Jgib+RY4R9E09YRrK9bgh969+tgETG1LkcKGX/Fm87oz0WS5XArLe
   mfQnpjTaNvlJ+lZAaS6oBKtuhd7yePwMLQpoknMNeZurVR+by1MWkUB56
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="386486637"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="386486637"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 10:11:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="1090654512"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="1090654512"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 10:11:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 10:11:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 10:11:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 10:11:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 10:11:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBOByr61EnjISspnAN4Z4vI7rdiuTqN4Lz3nq9Fs5vnZJXUAmQ4ND2G+x/qqJdxrpur/NKfJi0Uboji3xMLNI9TBFNRo0btW6HyTwuYFPeIumQ5xHo5EOKwOB1A8vurS29gSHke5ZFO8osaDeuDGdNdP7f9/sPNY/B5Bau7cZ33BKJCvUmgS1CDrJbD8Wz4t14QqTETcTF2SEcrOZoydN0p+0zOH5gyLYQCxOjF9Kex8k8NjwmDFwrt3PXg04D3HU3mB8bpwGT89gcOcJu7WlDhxEWZ/3ot/JJQReQpK9m2X4U8t2FKl1SAZBhoilIXAbjSj1PRfZY0d1cmDiIxb4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwtlLHXRN38Xhcdt5UAP9lL8rT8hj/xre/GUhiC55Ns=;
 b=aYXUCm/096jEGzWZZj1mTe7/T3pkIkQfL4L3tNffLeFR0g3ZE/HivCHnlKlvbXazTuynsvDra6UwYm7dtw6tFxkXju1vDgq9HkhdmPgXlzFRb/A4b4usF7fZZ/lSB1XrTUrK5ZNxPkT4nJtWHqpSXTzvqLfePiHcJoAPkvmD40KSf9gsLOqL5AfyAeh063+bgF/dSA2a2/iEgbkzsToQJbQDlr0yyYzoieBKp8AVDNOkpBG3U8f4MF/bBN8ZbuRQUEugMFKdnMCbkZgV5wKHJKyHvJbD6/Vwn3be1F/Rgequi1BSQUsNQ+oBuQoUeApX3qZRJVo9hxH0dQi0zok1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7441.namprd11.prod.outlook.com (2603:10b6:8:141::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 17:11:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 17:11:40 +0000
Date: Thu, 26 Oct 2023 10:11:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jim Harris <jim.harris@samsung.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v2] cxl/region: use region (not root decoder) granularity
 for calculations
Message-ID: <653a9dca299ef_244c8f294d9@dwillia2-xfh.jf.intel.com.notmuch>
References: <169660931834.684402.2774329392272976121.stgit@bgt-140510-bm03.eng.stellus.in>
 <CGME20231025154855uscas1p2102cef0c09d3cd68e8f2040ca2264f00@uscas1p2.samsung.com>
 <169824893473.1403938.16110924262989774582.stgit@bgt-140510-bm03.eng.stellus.in>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169824893473.1403938.16110924262989774582.stgit@bgt-140510-bm03.eng.stellus.in>
X-ClientProxiedBy: MW4PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:303:8c::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: e798a404-6866-4fc3-c617-08dbd6469e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mnr5IzAylj/P5fDS8QSO+Kx+eAiZNgZ/2Q6h540RWVf584ZeMkLlx2KNKgw4vcMouyq6M2tRvSrNs36b2tJFBvXEHs9ddoKw8Quty2mx9CdKrdqfiQhOMnASuKFuv7OVJgJIRUwB7bqN438TayUP94OrQegJGo1M8M1kdche9+waFPpwJwBfBgCLp4MmsHyleyWGoo65gwF0u7Wltw2lEcWOPpPlgF7i98d33mhxNug2quhnrjUm/pCIA5rJR+vOn6isMNlrEl7RpAnSL8ReVVt+1GNbz7r8Jke7eDJH8xoFdFBifK6hP9/fanQLw6vqSMmUJE5F+KOa/Ozhs4TfsLUTMwtxbTEEsg1sUnCyFjZwQ5cEgVanN368i0PDHfKNvC0HVfv5xnk7wj7+jeFbXIw8nEPBdmyl3mMYm09/5WNh07TAnFxLu4pTmOFhCdIUHkzYDNLAc5io8M2Hpm3Zs7M05+UtuDc6nqzAjr5aPCAmfBFgN+jl9l1TvxfURFMw3aQ1oILNS8zvJgV6wLAgQm1bqlZTyFwb5eNd2OKiI7LS2QBSa9TcbPssXgIDu3YQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(478600001)(9686003)(66476007)(6512007)(66946007)(316002)(66556008)(110136005)(86362001)(6486002)(26005)(82960400001)(41300700001)(83380400001)(8936002)(8676002)(38100700002)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x2SfE7zzamIfOho3/DykTzm0+PaE0oviheTFnDHtNimRokj96pf2q6xQDszT?=
 =?us-ascii?Q?pGk0+fjoB7saQlyWCqDWinDSldERVS6xbxfTpraGvKFxsJFmyrh6GzX+c8WF?=
 =?us-ascii?Q?310toCgz6NfMgJtZGm1OHO8J3NfltIPHLl0b0nqjjEB2X5n8N/YIMerA1VPO?=
 =?us-ascii?Q?mPQ4dfpTgzzVov0r/IVnK1mKfeL1Xecf9G+RgxsVqpdLeABS1+CyZY6gfV5j?=
 =?us-ascii?Q?DHrFaNCYOWuf3bAlfFYjoSXFZBHVEqsc3oRUJQS4MY6eyxlzaswQSUDvoFf5?=
 =?us-ascii?Q?kx1mUTUX20luGmzV01iMP4Q4o1+9nQpRWC5cxx4r1ErpPs/kFIsfWe6J8Fvx?=
 =?us-ascii?Q?xe7YhzEb19AbS3vHYutQHKFvSSaXUeGBXkEn/g59D58jG6PXCuW1p0UqUxG3?=
 =?us-ascii?Q?oMrN6L+f5oYW4dpB6rpD4w76tpDU0DofvFpzRJk92UUJR3U034G/w7V+zPb9?=
 =?us-ascii?Q?FNRG1P+3rdIQbLU3ZEbA4/IWO5sT6mwvLbIRiwXF8x4zbb5qU14j0v2Im78c?=
 =?us-ascii?Q?O45XULacbdoQv5EI0pSYYywhTRequtMHJp6BxPkBw1H9GWs3vPSceIwAzP2H?=
 =?us-ascii?Q?ayqCoqEtWxGtWxuI4eA+en/kZoA9L9Ihk+P1JKTOYtucX9uUo8FTLz4PkTyO?=
 =?us-ascii?Q?fdM7gpYocc+8z2aekXc3I8Z/B/aOdt0FDdelWcDTxm8oJPJMck3btB1/Rx3d?=
 =?us-ascii?Q?1RYQS0XT97qicAKolVGqzwk2E7rBLKyzIfbOfay1UVbNAWEdgoKVwdUMMarR?=
 =?us-ascii?Q?kTzvlPESxra5iOdOyKCA3gFkuaOQA58z8MiHshk3DKb02FQPbBFiwnuSbwpI?=
 =?us-ascii?Q?5Uhzf4FNuv7G+nJm+Y/fRPBLxxYc+VAi+6b4wOk+IvTwqEtbb7vwPjFXtpli?=
 =?us-ascii?Q?ljHtCPQRzwc40+1peO81YtyyUUJYek0FJTGGnJLyGlkZoZOOXZfZ3qSoIiOm?=
 =?us-ascii?Q?FpD59vzn0AavEWbKBo8rKCBUguoCjlpFzOssKDx/amvdiaSQl353onpz4GEg?=
 =?us-ascii?Q?CW7Yg2vXa4Rxao7eLA9h4e1s0kRRMvvTUoLL0d5zc3Gda/Km2IKnC9HCpXqi?=
 =?us-ascii?Q?WcpGU1NxIfJpks2NVDFIs25GPEk6+0IUBFC/q5yDButk2DcuRGj3906fzklb?=
 =?us-ascii?Q?M2po24CPV7hE6ytaa/dQ4Tpm0W1GPeI4N3bb4EKjObBjRRaYNjJy4i9WsJKU?=
 =?us-ascii?Q?nV36qt7txO/ozo2iiDHkml/oOVdJOVK4k6nRuQem6IYYg1Hbj/epVdCe2zvq?=
 =?us-ascii?Q?k8ElTFbgtE+5uNJHZq8lqxZ86iqO1gDaMQD85l6Wxs2Jj6SgN7BUbSkhvpHD?=
 =?us-ascii?Q?N8WCqa59G2H6SkPo+XGbvgZ/Uno7WLEAfxcTSHyUu7DTXXaJo6C9mlW/lhSD?=
 =?us-ascii?Q?GH8Yfrga652GZrLvctyiWBjJD2dSBieVJ4OkTHluvQPAsUPNW/mqKy1C/dMD?=
 =?us-ascii?Q?2nuMkiIdTYiFLu/XoEkjthCep7DabPG30ZkeZ3ojsWWWtIb7jRy4lKrhtHEa?=
 =?us-ascii?Q?q/wLDJAenQRw1bnER5cLpmFboiutTp9Yk0DGzHB1AkwrS1wq/+25koXgOr3R?=
 =?us-ascii?Q?8mtYupA5FuscWBwPTwovQrViopPIkaxYFZlJz7AWsLv7QwvROfCxZII9uUqx?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e798a404-6866-4fc3-c617-08dbd6469e87
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 17:11:40.0134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgVBwGI1rw/9w3leuKbG1XNTlZAkXpuyd/EGBdY7rtLVjDLoBw57WC2q7Bb9IUn127boIFIzrZKM+0lzTX6qapA6s2oYMsZ1rPZts4dtRxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7441
X-OriginatorOrg: intel.com

Jim Harris wrote:
> Root decoder granularity must match value from CFWMS, which may not
> be the region's granularity for non-interleaved root decoders.
> 
> So when calculating granularities for host bridge decoders, use the
> region's granularity instead of the root decoder's granularity to ensure
> the correct granularities are set for the host bridge decoders and any
> downstream switch decoders.
> 
> Test configuration is 1 host bridge * 2 switches * 2 endpoints per switch.
> 
> Region created with 2048 granularity using following command line:
> 
> cxl create-region -m -d decoder0.0 -w 4 mem0 mem2 mem1 mem3 \
> 		  -g 2048 -s 2048M
> 
> Use "cxl list -PDE | grep granularity" to get a view of the granularity
> set at each level of the topology.
> 
> Before this patch:
>         "interleave_granularity":2048,
>         "interleave_granularity":2048,
>     "interleave_granularity":512,
>         "interleave_granularity":2048,
>         "interleave_granularity":2048,
>     "interleave_granularity":512,
> "interleave_granularity":256,
> 
> After:
>         "interleave_granularity":2048,
>         "interleave_granularity":2048,
>     "interleave_granularity":4096,
>         "interleave_granularity":2048,
>         "interleave_granularity":2048,
>     "interleave_granularity":4096,
> "interleave_granularity":2048,
> 
> Signed-off-by: Jim Harris <jim.harris@samsung.com>
> ---
>  drivers/cxl/core/region.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d63b8798c29..c25be26d0bdf 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1133,7 +1133,14 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	}
>  
>  	if (is_cxl_root(parent_port)) {
> -		parent_ig = cxlrd->cxlsd.cxld.interleave_granularity;
> +		/*
> +		 * Root decoder IG is always set to value in CFMWS which
> +		 * may be different than this region's IG.  We can use the
> +		 * region's IG here since interleave_granularity_store()
> +		 * does not allow interleaved host-bridges with
> +		 * root IG != region IG.
> +		 */
> +		parent_ig = p->interleave_granularity;
>  		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;

This causes the kernel to correctly detect that cxl_test was programming
an incorrect host-bridge level granularity value. Fixup the test.

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index fb6ab9cef84f..b88546299902 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -831,7 +831,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
                        cxld->interleave_ways = 2;
                else
                        cxld->interleave_ways = 1;
-               cxld->interleave_granularity = 256;
+               cxld->interleave_granularity = 4096;
                cxld->hpa_range = (struct range) {
                        .start = base,
                        .end = base + size - 1,
