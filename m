Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDB2C3DA7D
	for <linux-cxl@archiver.kernel.org>; Thu,  5 Jan 2023 18:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbjAESB0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 5 Jan 2023 13:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjAESBZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 5 Jan 2023 13:01:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F752559F6
        for <linux-cxl@vger.kernel.org>; Thu,  5 Jan 2023 10:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672941684; x=1704477684;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IzWzun66U8xg6ztbJR9e/Lj+9eSmDokrecoNeHxA3JA=;
  b=DBjXbMAxTWhF6dsvg3K76sAqlFoIpA6O5hbt+VFzcnOhZcInGRaVFs60
   aHJjeALZNZhWBRyN8JtlQUb11M8hDrWLfHtvdPNW4a5FqH674uQdPO1P+
   2XU4enS+U54NC4OYNWavlXg5EXqs1bBzV1P/VOUYfK0h09uaYRUFcNiEq
   1fqyOuHD1yv25S9fz2TFiO85DO7JCceyvSgpvWpEgEfEaMeLPt5ocj5f/
   ssfv5f3gJPizyCPS/q1QMpFyb602/v6cI3QXW+getWVBPZoknwNay37qH
   jw4DPF2nAR1B3wEZB83J6oiasiFB90qcOvzZgkuXSxx77KTWgL4wui6RQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="349490804"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="349490804"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 10:01:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="686205321"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="686205321"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 05 Jan 2023 10:01:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 10:01:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 10:01:12 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 10:01:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wxv2NNMgw2WKC1tDJpocBt4Vr7MfOkv2L0t4HXEOkYTzakpm+IE62DU3z1AOjXRsYQO4LKlgYnLCMNKlLbhIfnHAzAC+WY4jYR8yppJ3WMfKbDlYcQ2b5YgqBP/OJ8yB5alsdFcReTIA8ZixEH3914+f9bLNChWJ2HzEvVoEM/PfFTgnBgd6fJPI7twL20u4UAqXE1gcoGClnH+5IJSuPlIvtm12EWt8hLmRYn6N6DCgIqzx7EUwB0mVmodXdbsfYkgDStAcSBhb+Cv2Rc/DnXqOKXojiSmnuZUsVPFKsy9HqQzjSRL+XMA6lEvWMqaiXgAfsOD0tyIIWrvqSkTa5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3qTCAdTLTnIcx1QnT8proLszMPeuHLLn6WLvD9HeS8=;
 b=I/qOXrgObpb9lAEasb7OS5NlTBqhDWchZ4FkZkRtia9nD6bLH/hnLPGmwqmjs2q8GpJw4BGiGRK0i6ENs9uYVyeLV2fQeS+mtR6dW7bdmTgaifebN3ga/Fq5pws5DX/i87pTpBxF75XEAsjXrqhSvqYUGtMtDMRbTJWwqVBCXqmn6fQhxo5kFsAeCqur7INQdCbyM0gneQqRBy1TF36r+svlyoWY/hN+sHVl5GV7jdLoB7hkbOaNHzOjrnRndvPV214/383zKhCrebfahGqs08+CMhA7pn5pQK59HP58OM6XaRcyWVb8Tp8tVF9jsVi2F58WsGO1vjUppfh/hHrJgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN0PR11MB6060.namprd11.prod.outlook.com (2603:10b6:208:378::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 18:01:06 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%7]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 18:01:06 +0000
Date:   Thu, 5 Jan 2023 10:01:01 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/mem: Fix command comment
Message-ID: <Y7cQXfR2lr1UP0ng@iweiny-desk3>
References: <20221222-cxl-misc-v1-0-9343bab16e72@intel.com>
 <20221222-cxl-misc-v1-1-9343bab16e72@intel.com>
 <63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch>
 <20230105173626.00005460@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230105173626.00005460@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN0PR11MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 737d85ea-f7cd-46fa-cbde-08daef46d0fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61My88Fh0ra/F8ztwEF6swm0T2iQivIhSJ0eEhG/S/Vlu6XpCSESsxQP9ki7WAMoe1dRZvFLxgBQs+6+OyRxwdpuNx6LkHxvksDXrbTZUnYq1YCyXDBl5GsQGxxCtcE/ftf5FSHnPgvwSOrquAn/B6Y2qABiE1R/qFXbKqvHnNaLJzqJETpd68rGZk6GtiIwzj8/Pjjl2wIErDyEdvwVGM0IJngze/y0QpuSpzgZa9RIsTRWt1D6trtkgCn1srlTtaEzlaTEABsGpj56H2PUgPupnFV6ZVRUv67PhQvL4YaRvTg5AIJaKku7ghsAgiS1Kiu05zvtW5aPsPJA/FfRlpfzm1paoD52HfHj9ZMIkdSw3cSMmjBEZe3NwRW6gwlABy0zuCJMnkp4rxBIOYztMS4cZeZUkPjPajBzyjFJoRNkR2UADYDxARsr18zvHfjIHxdmo8Em0XzjaqUyybGbkhTwGBmxCBp9Sq6cle6u9OW6cylQZmsrYHFPZ6gSMyIYSh8rnYCxaVAQdA/tSlJ3rok4WL3/5/hDbU0GpDDNrQGhQYCkzaEbYrGCsIoR6pIU0YGEwWeW4yOiVIRjsIsllGdmdKchUMjb88qyLmQa6vVH1xeqZ7KDwj8Bw/NozcVpWAkT9ESiQHibXmyjr7kQdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199015)(83380400001)(6512007)(186003)(6666004)(26005)(6506007)(9686003)(86362001)(82960400001)(33716001)(38100700002)(8676002)(4326008)(8936002)(41300700001)(5660300002)(2906002)(44832011)(6486002)(478600001)(54906003)(316002)(66476007)(66946007)(6916009)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6T1RFayfbSNkY8BL4SawtVxCN3kFl3J/VZTV4nR9T8/+qO6qH+ebi384uYd7?=
 =?us-ascii?Q?5X6s4NWEfUETpprC1T1vm0PyA4RIxvo/5liP/r5viL7OxuOPrG/xgw7/NH5W?=
 =?us-ascii?Q?RJ0IDhCFJCzLbtfOTNLXJGk9ekU+4K0fM6hd7PZ5xu9MvubAbq+PfXmzH/10?=
 =?us-ascii?Q?HAL4fYmQACOsNN6kC1mL+nGzYZwAem+xxIjVT+jpTdCnoaQa4PInr+RvKq85?=
 =?us-ascii?Q?J2QDJHHtPZ+q015Atihx6VEe524T5mEzjQHg/8yy4Uz0wR5BgHcJPnxdHMtJ?=
 =?us-ascii?Q?Ai1aX9cy3jEm9FnEAFURo3+8DurGq7NTft/M6tlXVwigDNwi6+VddXJssl9f?=
 =?us-ascii?Q?ZbQpDXg9QwmZEVDj6F8otfYQfMBFNPlRsd4vwHRHdMEHXG5u6nOTrW/GDv8I?=
 =?us-ascii?Q?h2gG4px7vYtMEntEPZWSr7W6NzeuE19zO044EAHKA6WqdT3VoEiFzi3x8r81?=
 =?us-ascii?Q?6R5d8yfco39ROpJ1K2uoPLne7p7VNya9kJBDZQBE8jsBjSXvXokI+mCUS1Kd?=
 =?us-ascii?Q?oGNO1EXPCiCtM/NCJdbx3Odvus+A4Omv4fKgHIuRfzwkr7NEludGoHNCAnG8?=
 =?us-ascii?Q?TUgZwI/k1nDFm/wCpn2GfsZxJHLK9IIkQabcuajEeWKYb28tAesFMX3WBijt?=
 =?us-ascii?Q?G73LFMYqNB/usG7SP0yXJRnOENVhqoTyy7NR5s9GJZ+wqckinrYs6sMHqD1z?=
 =?us-ascii?Q?yDek2Hw580cRIP1XlVEheDu+HgiF2167R0zUihPCvW2qI4p5X1pwasS36+e8?=
 =?us-ascii?Q?jY7ruwjWhAACc5q/rtav7z0NBtdNynLOpqnT6iBIFNYVeDJCtlZ926dhdEKk?=
 =?us-ascii?Q?9thcRwpcp2gBtLRFPUBNBP4EFluqd+C9jJtFAHB9fHmb2tUFjcBjyndOPmYw?=
 =?us-ascii?Q?9TSwUPMsXSdZO2Ika0fzUL+ivohvfD4wynrgKLx923UOYqsMx8kKALAa3j29?=
 =?us-ascii?Q?h+AbdRN1lRD3XCVokELahJ5XXQ5066xZ/+QMjGOeHq8ahLSDaPHSYxMyRABK?=
 =?us-ascii?Q?KG6A0XmTNn3fu10sjD91CExixyT+hggF0n2pHkOUyhOQGkxXsXTihbdBHNJO?=
 =?us-ascii?Q?TvDcLdQvQbilhZvZYxgNjFH1Ni+UMyX3ZfaHPqe60VBVBpd0Vc5S9ogfTvZz?=
 =?us-ascii?Q?xVNKmBDPRI3kYxV+FTwLGa+L54RWQU1Bgskqnuj7j3my+CZVo5PUL7G45Icc?=
 =?us-ascii?Q?B2FcNN5LOaGPSHq4YKEtznSgxSR6upY0yw1CVTx5ivrAd0TdYDdPojSPqS61?=
 =?us-ascii?Q?yoUIeOkdUaid4enHZZ2PvFbIr4Mg7oO9fJ1qfdJXS30c6qxq3+W65enFERft?=
 =?us-ascii?Q?E6xwyiMf2EqPI1qRV+lvZGbcWlJkvTzAOR7KmPDOeZX/+IBZvZRaCaKsIsXy?=
 =?us-ascii?Q?jydbW5rXtdErCTGkkxsgW176yEzxR6PF/evOP3SKq5MLJ+8qlOqemnUUeCr5?=
 =?us-ascii?Q?ComvKcLhCyXYRhDz/x7pIw3bvdqH1giaJPPM7rCK5qKDr2kWrCOLmVP4L/8y?=
 =?us-ascii?Q?pbpapfZFe8mpsWM76ElwunYjmTZ8xKJ50KwshE56/xe/vlSneFwqbdyJ1hx8?=
 =?us-ascii?Q?8WB/GMtTyLw3A9lhW74L0gnMLbYI9Hi1WbpULGmy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 737d85ea-f7cd-46fa-cbde-08daef46d0fc
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 18:01:06.1823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/twmQ9SKefgH2eLPKZ2R/N2WPcFM+9BDcnIPwewBJj0rX95px0G/huEiDSVLeXzNuYhNtpD7vtnJ0X3wz4Z6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6060
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 05, 2023 at 05:36:26PM +0000, Jonathan Cameron wrote:
> On Tue, 3 Jan 2023 19:02:38 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Ira Weiny wrote:
> > > The command comment had some minor grammatical errors.
> > > 
> > > Fix them.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > ---
> > >  include/uapi/linux/cxl_mem.h | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > > index c71021a2a9ed..555f9140e2bc 100644
> > > --- a/include/uapi/linux/cxl_mem.h
> > > +++ b/include/uapi/linux/cxl_mem.h
> > > @@ -11,9 +11,9 @@
> > >  /**
> > >   * DOC: UAPI
> > >   *
> > > - * Not all of all commands that the driver supports are always available for use
> > > - * by userspace. Userspace must check the results from the QUERY command in
> > > - * order to determine the live set of commands.
> > > + * Not all of the commands that the driver supports are available for use by
> > > + * userspace at all times.  Userspace must check the results from the QUERY
> > > + * command in order to determine the live set of commands.
> > >   */  
> > 
> > It's interesting that these grammatical fixups further highlight that
> > the existing description was a lie. This new wording makes it seem like
> > QUERY informs about temporarily disabled commands (like those in the
> > cxlds->exclusive_cmds set), in addition to the device enabled commands
> > (those in the cxlds->enabled_cmds set).
> > 
> > It turns out this has always been a lie and the cxl tool checks if a
> > command is supported and enabled by trying to execute it if it exists in
> > the cxl_query_cmd() payload.
> > 
> > Now we could either go fix that, or change this comment to reflect the
> > current reality that cxl_command_info.flags is always zero and the
> > command info array is just telling you if the driver knows how to
> > attempt the given command.
> 
> I'd really like to see a query mechanism that reflects whether the hardware
> supports the command (plus all the other reasons why we might not be able to use
> it - ultimately the question is 'can I issue this'). Some commands may
> 'take a while' so it's not nice to have to issue them to find out if they
> exist given the discoverable nature hardware side.
> 
> Possible that mechanism is different from this one though...

Yea but I agree with Dan that the comment is wrong right now.  I somewhat
misinterpreted the comment and so my change was not correct despite Dan and I
being on the same page (at least in my head).

So Dan is not going to take this and I'm going to attempt to make the comment
correct per the current behavior.  If another mechanism is built then we can
document that when it comes along.

Ira

> 
> Jonathan
> 
> > 
> > >  
> > >  #define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
> > > 
> > > -- 
> > > 2.38.1  
> > 
> > 
> 
