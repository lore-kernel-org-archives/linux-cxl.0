Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C54CC352A1
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 06:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiLFGlt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 01:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiLFGls (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 01:41:48 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB081C130
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 22:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670308907; x=1701844907;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+n0SCz0VxzA3V6Fl1a1aG0Axw+5ZTCtrcM3hIqwMCDE=;
  b=ZXDvUVDcYKMfRrwei+dI4FPJDQfGifPjDVJljh2Y1/HbLJIyBrZXWaj6
   uonLxTQXFZTR2BI5JpNns5VaM6LXv3TzsoulyL6F7oq/2S0foRP0RR0Qs
   bdxitSngahWdySxNNgs/wwOo5lU5eID/URStwynWcWAcX3qdiulwqyWV5
   t5hP9As4npsc/0gIGXVYLzDHlr+faEu8c1y5ZRF9uE5Ye2uNLJKKVbUho
   +2qDncU7p8WH5eg6PTnZry6Cyb8nyF+yn1PBuGI+NsU2mGrfFK9JOjhzv
   K59cwwNe6ZK98ajISxqv0Qp8wZkQiNaEtKykvqCVzEDAuIGh5U7iO/rY9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="315256710"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="315256710"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 22:41:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="676867904"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="676867904"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 05 Dec 2022 22:41:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 22:41:46 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 22:41:46 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 22:41:46 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 22:41:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsdwJlmkMdcePLtTwNtpQTAozldcsuOgLQNES9AWOccRffbcIeu4+l5HxIm0Fm2NrfI1Put2yF1PASqhGCsrVYQ7lKHf5Jw0J3AUAjZWOcIehhn9IjTE/ZcugYlmDB3I2ZVxS9Oj88xXVXQs3yxkgd+vivel29+UjlCEez3a7djvus/C1uLJjfBrkpZr4XewG8c+rb9Bki8FeSIMT2JsmD1PRDTGVCUfxJ4gKKCLqizg9ISMblu68/qHNuEvTvNAnl36l+9otAWQGKTPYdHei3U1evV/oAYxt2TuIutGCiTGF9TmOWLT2Fx6OOKm0eDWle8FsLSy+xz/gUycmIIz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xmt+0reHq921i6oLq2PKEEWXGClGncsE6dCw4BjOwZk=;
 b=M7YIE8RqMlr3osvD697Nq4X7jWUg52gbyMwjDh3JXVTntIdmQn7OaI4xax18aK3J5cFFaCE9o+jaduYd6mU8E9XPI/Or9Ht4qBcrjTLhbwsA1EU72alPNtbtIbSFkdN4eLR5avcGY5y2DGNYgpgmqiaJEFKi4YIGbywOFrgSfcvKvI1enFSjJ8kDU+BvS5AUczoU80zhEPD7ESWgH2k5aitv/XgubT8wnP8WhKKWzp7Pk0ecId9BJ7TtyVLnUX7I9ZNBKB9tUYJl5How5BMArgEuTV+3kurNiOPWTkgbimRvPR4RVSmN8eF34lixVkdA70o1dx47k/JZjkE+JD3R5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Tue, 6 Dec
 2022 06:41:44 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 06:41:44 +0000
Date:   Mon, 5 Dec 2022 22:41:40 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: [PATCH] cxl/pci: Add some type-safety to the AER trace points
Message-ID: <Y47kJKrrAtrsYG8e@iweiny-desk3>
References: <167030091477.4045167.15174636482098463885.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167030091477.4045167.15174636482098463885.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BY5PR17CA0045.namprd17.prod.outlook.com
 (2603:10b6:a03:167::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: d28ee7c7-a20a-4108-1556-08dad754f0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87UzUzn9GA0qW8jksbtMmxJMWZZ2uMKaDwue18nmvL4LARhCDnlYlcj92lJU8c9RYrkbgQIRT15sv6QDPUMj6fPku7rJiiXv5x75ibuDqAB/om+VFtYtzRTEl9USlQMwnctBwnm8Hwz89nLC1CmGpsRPMv7Kd22KZEChpZZYui8DJZQQ5YL1XhfjsKOkpSrgqfKRsWio9zsCU73XvZfBri/iErq/i5IJ5hs4m2JCFpObB2vBfE7GuOgeZ/drxv7pPVeK5KrQ+N0GEvfz6xbRRS5DVAQwGs2FWx9IUlx8Oc4MRBvujwOG6J5itGecM516TWKaG2gUhn73L6tjwmB3VnDj/xxi9anC3u4pes5XRBgZOF3y0e6jInBSo9BGYFNpWwKc6DaNykduoo6OdiVWuKj+69ZyilRcmIkHPfgFn6xsVsVqkCAQMsDuj8CcsqH7HH8t/NJk0+zv7pcInMPx7yD6XN6aRHJ2FXDxQ10+PXvijcEfsJfUMohoAlURp+5omu3SOAhROpaTZJ0O6DYdE+nYbVIMyObyhoq6Mhv0H4yrHC6b/uzZNj5YwNmc3lOy1k+uF6wB3bv9s3i54GeeJoamaUKqv9yzYu8l0FjBmJO60ZbdfpRPyHSZMzcR2AyRQcCvP+m/Q1/FZuu8TNA/xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199015)(54906003)(6636002)(316002)(2906002)(66556008)(41300700001)(66946007)(6862004)(5660300002)(44832011)(8936002)(66476007)(6486002)(478600001)(8676002)(26005)(4326008)(6666004)(6512007)(9686003)(6506007)(86362001)(83380400001)(186003)(33716001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KaOxvszUq9Spk0MUpEQeak8AU29piCRx6FMtqE+1a2CdcfIrn+oLPrjkyLmP?=
 =?us-ascii?Q?rgnaWX5fnVmraMs3Jn8ylUtJL6W45V+H6SIJ+b5mkfrFwxFlLfj49mhStm30?=
 =?us-ascii?Q?suBHExELo5ts8W9xMG5ydym+v2titm1WSPbRb+dLgQ1M8HfUJT8gk4PU6duG?=
 =?us-ascii?Q?VBQv2sx7KrceBXWeioRHh6X97f0eMwRE/IWQ3oBN7lVneeqBgZ6TaKFF2MoV?=
 =?us-ascii?Q?ZdJKjbBXT93mYtyhDIHIG405miiDUuTjy8CVpJKMfiNJGqKJ1NiMeyngSrxL?=
 =?us-ascii?Q?IyCfW5ortqiZBz6NoGxgiP0XNekGuKYY2Cdf2HI/vkiKRDeRy2w6iUNV15/t?=
 =?us-ascii?Q?q+QsU8vem54NKIulIm8xjOGz5VXhLArYTlJ2rdkDYF0jGeR8SgmSNWUdmk88?=
 =?us-ascii?Q?cePP2FPtBqXslvwE2PIQOtMVdzB/WYCN36ZCktYPemUtZY7DbWgTVTRkgF7V?=
 =?us-ascii?Q?691N7HYtBc1RgOwBmIgDT/D0ueSHn+qRDP8QOHI4w/5yKJzTlFYNAoxenhGo?=
 =?us-ascii?Q?NB3KaXNs+ERQngE1YpBYiPouT4C1s8rQyh4cIsKenAvsPMu58XwM7X9LGTW/?=
 =?us-ascii?Q?eocQqAyYMEWGZituQH+N9+GK920nHUK1moNEzPH7GyI+hySMmkqHG/xu6JJG?=
 =?us-ascii?Q?yfXwk/ZZuypsi2By75zkHu+UhCF6SuLV1yQNs36iUNkOsbW4VWyLqgQIoZr8?=
 =?us-ascii?Q?IvQ1/omwaWdiizmNC9pRIegMMkYf5rEKI4SFG+6OEzrYxQO/QvRdiPcalSo9?=
 =?us-ascii?Q?EYpbOxy9FSwN85bn1fYSSFQvtroonKf0/qzBwtDdEC4YJpgM8agq/opRM9vf?=
 =?us-ascii?Q?wUdRHOOrXq9AL5RZinmqLqUW/0zXa3laoIwmZp50Y44Wy7gQSwWRlMGu5WVK?=
 =?us-ascii?Q?LI8UItO2eFlg/0cMx/NDVcJFrYMNTfUcJqi4RJCkcimKM7VILMcQOAc/kEie?=
 =?us-ascii?Q?/QSZyMEU8bXFWc6Y/wQEBItZZaLUBv/mdIwD0cnasde9bJjfE/wLpWCL1Vra?=
 =?us-ascii?Q?jkM9g3Jzh/uDVwA9suVI55jIvC6ZpAQ202QmS32/c3HAf7OusYnIkxUUfNRD?=
 =?us-ascii?Q?C6q+v0pk2TQc8vXku/KWmIGVcCa1jdLEYNamGBbjlVB300n9u9mg8O2CLodE?=
 =?us-ascii?Q?yEChBpsiyGecp8Qikt36DBlNVo5vWkNWDiSO5oWkUVeKhM+pcPkihjLNZ5Pn?=
 =?us-ascii?Q?Y79h8BZxY9j4KK1HLq4dMq1uHGSAHjz2eI95iZYdZCz+YlMsRiojzTTA+woJ?=
 =?us-ascii?Q?kCv4KFvgFQ3jpAg3FW6gQArmOAOtXPdKj835WISiD5OY9fhU+ZR1a0oW2Rhw?=
 =?us-ascii?Q?zEwUYThpNz3DcL/SpwME4CsW3A1/mxt5J0oSP+4yzDdLv8TnY+wRVKpc+hsc?=
 =?us-ascii?Q?/rWtJZ6FcEbQOAcB4I9pR0LNK4fmFEYSkei2SoCz8g4p122smoebOfxdn3xD?=
 =?us-ascii?Q?7nrmYgBtGEEWBa2pqVUrD8DazyR2zI3sHDyAP618SgGAEkcmGr4tRaqrchCo?=
 =?us-ascii?Q?e5mm6/P5MF4NrFfDgzRbVkG1QmOqCedrlazv8BE2MImC5dQDll/V4V+ud8mo?=
 =?us-ascii?Q?LRMdg6AnGeoDyk1Nl/sJNVatOGIxP08ZBINKjM4E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d28ee7c7-a20a-4108-1556-08dad754f0aa
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 06:41:44.2811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTBTw0CHqKmovMV4/a6VxArIBHJN0wTS8n0u6u8ZpdNVh5HFs39agq9irxtYA9TmySzNYidx8V96rYuN+JHNmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Dec 05, 2022 at 08:28:34PM -0800, Dan Williams wrote:
> The first argument to the CXL AER trace points is the source device.
> Pass a 'const struct device *' rather than a 'const char *' for more
> type precision / safety.
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Sure.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/pci.c          |    4 ++--
>  include/trace/events/cxl.h |   16 ++++++++--------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6cec9fa9326c..cced4a0df3d1 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -562,7 +562,7 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>  	}
>  
>  	header_log_copy(cxlds, hl);
> -	trace_cxl_aer_uncorrectable_error(dev_name(dev), status, fe, hl);
> +	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl);
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
>  	return true;
> @@ -644,7 +644,7 @@ static void cxl_cor_error_detected(struct pci_dev *pdev)
>  	status = le32_to_cpu(readl(addr));
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(dev_name(dev), status);
> +		trace_cxl_aer_correctable_error(dev, status);
>  	}
>  }
>  
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> index 72c3e2870a9e..ad085a2534ef 100644
> --- a/include/trace/events/cxl.h
> +++ b/include/trace/events/cxl.h
> @@ -45,16 +45,16 @@
>  )
>  
>  TRACE_EVENT(cxl_aer_uncorrectable_error,
> -	TP_PROTO(const char *dev_name, u32 status, u32 fe, u32 *hl),
> -	TP_ARGS(dev_name, status, fe, hl),
> +	TP_PROTO(const struct device *dev, u32 status, u32 fe, u32 *hl),
> +	TP_ARGS(dev, status, fe, hl),
>  	TP_STRUCT__entry(
> -		__string(dev_name, dev_name)
> +		__string(dev_name, dev_name(dev))
>  		__field(u32, status)
>  		__field(u32, first_error)
>  		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>  	),
>  	TP_fast_assign(
> -		__assign_str(dev_name, dev_name);
> +		__assign_str(dev_name, dev_name(dev));
>  		__entry->status = status;
>  		__entry->first_error = fe;
>  		/*
> @@ -89,14 +89,14 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  )
>  
>  TRACE_EVENT(cxl_aer_correctable_error,
> -	TP_PROTO(const char *dev_name, u32 status),
> -	TP_ARGS(dev_name, status),
> +	TP_PROTO(const struct device *dev, u32 status),
> +	TP_ARGS(dev, status),
>  	TP_STRUCT__entry(
> -		__string(dev_name, dev_name)
> +		__string(dev_name, dev_name(dev))
>  		__field(u32, status)
>  	),
>  	TP_fast_assign(
> -		__assign_str(dev_name, dev_name);
> +		__assign_str(dev_name, dev_name(dev));
>  		__entry->status = status;
>  	),
>  	TP_printk("%s: status: '%s'",
> 
