Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1426F1FC9
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGNlehb1"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EE3A4
	for <linux-cxl@vger.kernel.org>; Sun,  8 Oct 2023 21:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696825061; x=1728361061;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=joSOAxpKrYgmg8TzlYDSs5J85c3Wsn8xN3Cz35ZXpmE=;
  b=BGNlehb1XbWI7p3Y5wl6YIic9LQdMrCw72U1xG6cgHJlxPabr2BK9azd
   ScsspO2E1ziqaaMHKa69sG9+7vun7ed68Wf1E63ZrnJCUYXyUIY1TBw8d
   Ye7W69TY6n7l/yAMhjQIiqNNNkmrgtRtrbLeHSxrL4uYKsNSTzXH8OMRu
   x0zrOZG/5JrcXJcrhkiil5WBLXpPn6zOWSso0vlAHrCG+K/tLWQ5UcYdv
   iKYv9pwLVxARue9hPnlPxIQPXu7269Q58UlLAUPvwOHjBJTYadu20ZMqJ
   3TD173Ubq9BxXlOaA6ZhoBFmX3u6OdCIv2y0g2RiykUgmYl4WPAiSgD2T
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="448259590"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="448259590"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 21:17:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="869086190"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="869086190"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 21:17:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 21:17:39 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 21:17:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 21:17:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 21:17:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaTz4ad9/FAxy4rwdl2nmMAQDrog+OlFLFJlj7hdDawJzXcalIjS+8+q08I6AHOthWNDQT2KmuUXC+2EDm0Zd8cyS/e5H4uQpk7sBz/fCkIzy9XXb7ytQ4WVY+Oii5ACHFCBTPKeXQeYFuLIAhfDBdSAUQ3XSFjqBjnFCybUKQRWrAK/ZOUFL8XRNbirW+pRh91TqCOYe6nTqeX83c7b0fLiE6JCS7qlMCP+ThiALkjCUsLOXq6pnWPcL1nVxhR+Djv5RK3/AHoiRPlrNA28L0+oFZOEoe/SgSDbGoaflUY2gqTro1dp79W/KSk3Ux/lOxewddqLiTQri6lKK4LVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUhlj+sWPyRlAQ58Q+p3mBcCoCeBmoT/+54xAL5Q3i4=;
 b=dEnsmbbfHEaEa4cf6SvkFv83e/P0goActjB0ZWB32A4fjrnviYN3q9i3LFq48sYbSaEWlV+SjxAbGcdb0o1LkR5EeQgNrq5sKYb5BnHtoImhuj2LjA1enqHcwNnFq2QeFcOOQ+Lo31DYLSg/6MQxNPQPga+9I2MICFeXe5bdI2j3BfNWTxpooVfw2tL8XoaGOS7+BJBEuZZgO54a8Fjsg/DKvKGhUc6mHrQWHZlVJkVp0xjykGfH39ugdH4K4SsSucNJrGI2BQ89Dj/QcWHaieX3cokQChiLwKB3SVLRvb1ojn8QvYtZvel8tsTovFQNV15Pldp/yMiGo6LnnCjNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB7968.namprd11.prod.outlook.com (2603:10b6:510:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 04:17:37 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 04:17:37 +0000
Date: Sun, 8 Oct 2023 21:17:34 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3 07/10] cxl/memdev: Fix sanitize vs decoder setup
 locking
Message-ID: <65237eded9811_1d988429470@iweiny-mobl.notmuch>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657719974.1491153.15276451196916291864.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169657719974.1491153.15276451196916291864.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR07CA0039.namprd07.prod.outlook.com
 (2603:10b6:a03:60::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d58f7c-3094-4b57-093b-08dbc87eab4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPvk8aPWO2Dndbvqjcza8+AFwHjA/uqc9kqXIozSIFwe8Jtk3mYL7IBXpnTHZVWXJB2yHLlHpynkg1puPMFF6gqnB8RDlecRl5D9Rd181Y9/hwrDN2HlW0iVhUmC4dP8rm6964QHaQYx0nbY8nlgR8dSCsO20xZGcndCgI4SnX+nHmeogbH3MIuVpkGlxjey5PnH9uQnYtNur4QzpS0jm6hMR8SaN915XgAn0l6T4y2K6H0u5Kbl4qDjIFlfItYxzePKH9XxKe6ShCoFbKkLRgf/VUWsgQ1VvDCpv1/fu/aBuk5VD77yudqczW87HX16SWEOb8wUjD9vanyfcBFGbX6KhHQoekMjbzUcDUibkGL/o2L5qBvSBf+laltf1tEzH8ckY9pZ18ZEBnh/c42zu7NcvD6mhVRRv2ZCnQ3l5OvZxoknLfXibzLvaaiiUWvLGCskC7Gi6x6OfrOei8HScsbVssbtgFbb9ENfFqgLElymsMQC+BBC2PZAORTZYr7pJjz3BGtIU2xopBVZZhcz+ysW3Ot50MXk8PyZkPWx0tqzga1nKZUkoUJFaBtN05c2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(478600001)(6666004)(8676002)(6506007)(6512007)(83380400001)(2906002)(4326008)(66556008)(66946007)(66476007)(6486002)(5660300002)(44832011)(8936002)(316002)(41300700001)(82960400001)(38100700002)(86362001)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?42BIP86yD8UwvgTu/L9Ckg85i+uvnceateKonsX+h0Dv3jR27x28nXf4PUog?=
 =?us-ascii?Q?sPemJX6HbwUmlfvUjm4ZvD5Q4PSjw89LkbS4tiQ4V1tt+OvmwMzkay3hbKqe?=
 =?us-ascii?Q?0P5PUitHir5M0ywylQwYz2prd5FOt2u47XMrVwbh6GOKwq8AjrUyv7UbnACN?=
 =?us-ascii?Q?Xdum/x2LDPWkXmFK65UiIbJPkrhoXxOOI85Tzdnw0oGntqayakipx3dUKXOl?=
 =?us-ascii?Q?4YGU0l67qNr/rhmNM6oMnFB1jFob7xdCMHzQKQ1+FDTrqXhrMdpYlLfgi05x?=
 =?us-ascii?Q?BZoYUW2SZ2fbwn0o5ORTdReT4NFmWMs44i1mAb5ZCvb97JDNpaS/BgZoxQc8?=
 =?us-ascii?Q?slGNbhfEpE0YhQXJggZ38/NKALGaU2S4WIciQ0+Dv85KMBf7q7nCE5A1iLIc?=
 =?us-ascii?Q?ns6dUM0Ltk8j8nNI/aFhGrSor7bvjmJXwVZZEom/3UcDijK1DwvJR5SBe/b/?=
 =?us-ascii?Q?vKAmHXrxdvnndasV8+0b2408+dNqI0jr7DiOUu+kc+CmQFZMgKVJHaNrCv0x?=
 =?us-ascii?Q?h1fxAIb3DYqeC6x9qQA45UKNzPcnktfHc2muDsXGCIoME6HaIgHMGUTzUUAO?=
 =?us-ascii?Q?jdJwpOCXAkuhrKIYmTE23OIlk6XBAgB3rOZaHRh7T8OgtJKN8qViYGCPMrtA?=
 =?us-ascii?Q?3SYxvekaKu6l2sDcmXHyVbb5QcU5vtqty8xIGm/PWg0nqAuIoq+zkOFiPO0o?=
 =?us-ascii?Q?m+Yw83PgSyxdR3x+mFTeGaPk57hAEXhFYdvVf9u1ZpvgU63DEdoIEoMmu2iy?=
 =?us-ascii?Q?tDPUEFhoRvuwANXCHOMZuX8yd9LRDQSXOLyWjf3uXPZ6qPXm5QG75MfOuuNF?=
 =?us-ascii?Q?QgFphEcZFDmLII/cCU6ATeWOUs6QU5n0Bs2l/4FiJQiuKikD0jsIl8X9iU9p?=
 =?us-ascii?Q?PRZFnLHaBdrL/r/G6K17AEmtll/CDTD0QSy2oS0uRU7Ic4rtBDyl+Lni++3r?=
 =?us-ascii?Q?YZL8v0WxV3/pj6SvvHZKTIngDLkHgkby/vW6uJGYb+kvEC/ppLceKTYIRcDx?=
 =?us-ascii?Q?obJFn1dffhdswevd1NJiul8e4okZmLpCnhcaU/JyPLPKP0WbforAFleUiqYY?=
 =?us-ascii?Q?uL/qBfteUDM/GHvDFPW6ny3281zAa/RA+jvzMeNyd0sInFJAcuwPLtW5OszF?=
 =?us-ascii?Q?6foJ3DJeD9fTX+Ky8+/5JzaBi1FXa2Cq0ExT3YHDR8d/wIvfTrjdoEJypbGp?=
 =?us-ascii?Q?Jl6cIEQ6Mzbsa8v/xvcJtyXIlkxx6C3CgGGSJEfiFLP+cOMRdNbxPJZ1ds6V?=
 =?us-ascii?Q?/5h5M5aEQfGP+RZYCBNBcb2qneJCek7Dvu3ZrqJa+2f7jjwDhVfo6KuxDXWS?=
 =?us-ascii?Q?Yw6XzWKQg1GRIxFaZ2tU6tsReuw1FvLbol2vlWWZP7GtxwIyLt8KW4aNIlSD?=
 =?us-ascii?Q?/EBj6NBzwH0XIaCluUgyFh2DnlvKxHcH00RM2RUuzg/Q86T/oOO8yK0fG/5f?=
 =?us-ascii?Q?tbUql3y/WFkxvshF9VcuuEB3i3RralMCkuRwe2FTKoZBG1kFpe1czPEHltqU?=
 =?us-ascii?Q?4o2MVDAcdfqO8wKqo+gmWBhGdq1xpLAMWLq97NBglLBvX3dSriH8yWuUzA42?=
 =?us-ascii?Q?RVfhoPB5OozD+/pVi98iztfZGdnuUHwNFFvAc1D8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d58f7c-3094-4b57-093b-08dbc87eab4c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 04:17:36.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89PDWbW/IV7TEJk4gQc2odDieVJghk38FFKwj4o00NshZ/YX5bRI62fhMbeG/QJ6FavmPlLWf07bTShxOCxXXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7968
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dan Williams wrote:
> The sanitize operation is destructive and the expectation is that the
> device is unmapped while in progress. The current implementation does a
> lockless check for decoders being active, but then does nothing to
> prevent decoders from racing to be committed. Introduce state tracking
> to resolve this race.
> 
> This incidentally cleans up unpriveleged userspace from triggering mmio
> read cycles by spinning on reading the 'securiry/state' attribute. Which
> at a minimum is a waste since the kernel state machine can cache the
> completion result.
> 
> Lastly cxl_mem_sanitize() was mistakenly marked EXPORT_SYMBOL() in the
> original implementation, but an export was never required.
> 
> Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

[snip]

> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -650,6 +650,25 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  		return -EBUSY;
>  	}
>  
> +	/*
> +	 * For endpoint decoders hosted on CXL memory devices that
> +	 * support the sanitize operation, make sure sanitize is not in-flight.
> +	 */
> +	if (is_endpoint_decoder(&cxld->dev)) {
> +		struct cxl_endpoint_decoder *cxled =
> +			to_cxl_endpoint_decoder(&cxld->dev);
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +		struct cxl_memdev_state *mds =
> +			to_cxl_memdev_state(cxlmd->cxlds);
> +
> +		if (mds && mds->security.sanitize_active) {

I'm curious why this check does not need to hold the mds->mbox_mutex?  Or
how this may be protected by the cxl_dpa_rwsem?

Ira

[snip]
