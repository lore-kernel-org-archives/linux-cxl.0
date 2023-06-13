Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BADBEB64D7
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 20:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjFMUxt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238776AbjFMUxr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 16:53:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5D310F4
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 13:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686689624; x=1718225624;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BhBPeHHJzsRiTvUzIeVkK4cM1CFwsGCbAmf41q1P/p4=;
  b=ba9tpA3GwAKFV7LoJ4tt8QlHGN0YD7koSQPUMjutj549+Uk3/Pki9RZ7
   ZgNVcJuZp7E3fwl5yPJbfAjQexeRauDfi/+LHNE849LFEbSYp/KAqgvQ4
   TJM910F+x+YRfdO7PDXu3u9dWV1k+1UVl52S+FnxTAZPNS/23TF1dXPnC
   eGAYX1GUl5Viz33YHE5TXQ8/sYBVJY4XM8Q4bNMVZwELujk1/OYqJ5N5u
   Q/ZWEPOus4u2FjthIK2BEXsX5DHRHoRH+5twQMQ13rLijwDrUgZfA340Z
   pWtdKuNVdOrIMuSiBPTCHd0JWWqXT5QJ5gPHN9r/OP3Eba5PxF8vY10Og
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="424330975"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="424330975"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 13:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="856251368"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="856251368"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2023 13:53:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 13:53:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 13:53:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 13:53:42 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 13:53:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neGp+zpwLcG2BbeMbjo2a+PToqNCOVcNiGISAS6nlx68R7/fu0SunagjQfI1zs7BZ2SANuhe7Uc/y/Vx7SSu+mMYMpqRxybuZ9ez68SaoqUvfu6eA6e/VKimZGEDc910k5Vt2SInix+STYjAubVYmDWL8hPrA+HslNno18F+v19ghIz63I6a35jUYOxyG11+8GdkSbBBudp83SvWQqdgYA+OvoIxOePp8ThrM2BkCefdmMfH5rA2Mkw5XHGqlyVVS88j39+xXXiA9cym2JCuVMSs0/TdLgYnO+t8fpeRhR+wwb75tiRNEKBd9fLuRRuvBggU0KEGiy6QvkChxZQ76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+QLgNHgvW63O0gcwRiLfymETVW4ZKkZKyXnGCgLdvI=;
 b=Dsg6WBJMJsR4GbS1tyRyLrzBL866DGS3dEWTmda1K5lKITrthZKGeqS91Xj7AXHM0+RRTkxljvXeOJXGY4Oo007B5b/igSpY7xucvzfcSCshWUykvCdx+4bVTTLXvaGx731sCNh+YZyGPJ9GZSlsjHEV7pyQlkLwPKHRLVrwRCBLjo9hBjFUgcYlsirU5tmtyxAdLZ8UjMGPyiuzf3X2y8COgau+CHg1h5glQCkCwpCLnGER8F/be6AQI6zuzsGyNtpbdL7AE4P0K643dKMzurPtiRI0SNu7blTkXnVJiDqjpW5M3OZQkydRA6XNdkEyJCjvaXeGZ3nBIWy0DfkktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6226.namprd11.prod.outlook.com (2603:10b6:a03:45b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 20:53:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 20:53:38 +0000
Date:   Tue, 13 Jun 2023 13:53:35 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 04/19] cxl/memdev: Make mailbox functionality optional
Message-ID: <6488d74fab6b7_e067a2946c@dwillia2-xfh.jf.intel.com.notmuch>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592151963.1948938.7831940219025967692.stgit@dwillia2-xfh.jf.intel.com>
 <20230606121534.00003870@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230606121534.00003870@Huawei.com>
X-ClientProxiedBy: BYAPR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:74::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: e374f82e-7769-44ba-5760-08db6c504345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IIxLNiIR1RrQNn8yToePoQmx7L0xQlvEXA7lZDr74W6eeMX435zuPAdIASe71xILxiz9yW29OsEhmUWTtjRAw4eps9DFspIN94iQz44XzZT+OSMpO0rfXVqfsI9+6Qnsr0ah99br+ez9kOTXvyL19yuQcClCAvLfInPuyVLto4bEcHDcakVtEZ3tn7Ua2iemcfXwtVk/cf7I3Ez2f6borbjBZmwC5B1TDKpd/3sJZNPvGkHcrMBafBWr/CxlN/oIZ7xnMPGlyUtc2P/TdSG6q1BR4DGss3RpVFOpoLQfb5R0KdzvfrJL0ADJVS5mx+qEWqo7Xj/RUsF/loexP7xb1ZDjRDsl0d2htaX1Vd/dyRwRMCAg3vRxD+jRgutV5Lzd+CIB+gn6TKpPvCi+ghbninJFmg3wo+6uQ0iN6l5LSld6JE7Fgi6XDSOJNclCMiq86dIWONQDE0ZnvKKUv9nWip/SRfvisZUc1R1gQi1+2DlY8wZa4mfsvWp6aPsMi2hjkpQn2yeqxwyjVcl8NH4H5HsBVzbFwr3xwYfDwhuKARS7P/jg4xqH6tNTYNODrkey
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(5660300002)(8936002)(15650500001)(8676002)(2906002)(66476007)(66946007)(66556008)(110136005)(6666004)(6486002)(4326008)(107886003)(186003)(6506007)(26005)(9686003)(6512007)(41300700001)(316002)(82960400001)(83380400001)(478600001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ygVYX51uKzr+PMXxXZDG52PZLZbI1PaCNAiuurfV2/PTym8ZJU8gNZ9NPS9i?=
 =?us-ascii?Q?ReyfnvfJ7KtxF5CREZqgTS0Fxk75MoPtfT0bLFTFz21xbBfQAuaS0L3u6Xdq?=
 =?us-ascii?Q?Fred0Rr1YNHiEQGMmygt/zVCchCRCxHNw8Nse+w0NwoyvuycAJ79ssu+AT2Q?=
 =?us-ascii?Q?P5rQwzEe7VNLQ0Fg2QD/WLZAtNvzkKLua5ocrwlzMR/9bip4uSYKDtIOrVL5?=
 =?us-ascii?Q?NXBWKK+nG7x1LdGA8il8e63TtR+pGqLDBgC9NH/TTKJH3xtuLBI3bzddVYgG?=
 =?us-ascii?Q?YBcZw0YxpOz+VuxmUNlaXgbKCPRSlDe2xJ5wShQnUlFEcSlKjwnxDESnh+X1?=
 =?us-ascii?Q?At6yEQ4gTm+qhWrhCNkp7vbjU9D8IGkj+kEuNKfZKljygqDhZdjM6QtArJO7?=
 =?us-ascii?Q?QpAJr7eEQt+Mgww3tY6rNKH/mnCv8Hih1U5RCG+NRvvJPrwP2e/ElTT8V86U?=
 =?us-ascii?Q?GfyVUkejKoyhgZpLc6j50+G+My1VvmyjhMkCJYm9qvaPCpt7apkzL2bqlEWO?=
 =?us-ascii?Q?YMHLgRgc+wnMxazdiaa8TqAtllyok213JaOh9p56GODgUS22JTK/gv/kn9u2?=
 =?us-ascii?Q?NpoTx1lAPAz7L5rKvwv7L5VZ+BPWMfAnNx9TbMU9Deky9+WxO6mfOGqDTpBB?=
 =?us-ascii?Q?UTeHMGGNOwOQG+YN0V7tRM33GCxT2lDWHDrRj+5IthIP7Y+tqffmYghw3NSt?=
 =?us-ascii?Q?cz2M5ftQiI1HlGY3Ysj+v/jPpo5poXeTVgYwiM7SA0LipuaNtpoGa4KXAdSF?=
 =?us-ascii?Q?3zIvA+0x9dCmymGpmYDjVHXH5nivFRSeUdCQ9R+s/DE8LfzsbAFE+8p/q7H9?=
 =?us-ascii?Q?Ff/ESdVoDBYGc2T+pmYz3wZqWIDWQ11TiqG8pPN93+2XomRJAYU7Xts/ASxM?=
 =?us-ascii?Q?5ob1zuAApdwcJADCdtRYviYyDrLwf0XTfe9EC/TA7v7XH7uEDabcmcfF14n2?=
 =?us-ascii?Q?8T4Av/i6aPieoLg10LLThS1Co8VMlZIog+mbrJaGhJErxiHgujGYv1BOQGy4?=
 =?us-ascii?Q?M/hrXx5ssvc5LrdWLZVowl2LUuDpvWmj1+sINQ2HeCiiUIflfUanZmiU8DVv?=
 =?us-ascii?Q?XuRsI4XIIT9sPGPRO2ZkF5MBfIxSFFNW7vDzFUC0Dt7QwKEPCW7W9fSXyLIW?=
 =?us-ascii?Q?GfCcL7Nm9rqxo/IqHYv6DW+VBKG7+y/hWz3e2dg18DkiApSHWqZaeweIEwLn?=
 =?us-ascii?Q?FAFLrspRHZcm3YNM1NIDRzCFJip073SA0b/WaNqfROjwD0MQc/eekYLsAijy?=
 =?us-ascii?Q?7Zlkygd5TVk1oOXSUcqfPwxvOziBJplJtKgn/+OVTpFC2dsthUL+/j9TdypB?=
 =?us-ascii?Q?9TtfvimVa6AiRim29zsDovHsZ52xEiw+JmG8VARwNi39t+nXA/Y4OFp/OMz+?=
 =?us-ascii?Q?uzyPXB94C1SWS+uc7todEmLbGBUz7DYnxP8QEko3gs6hbYQQL2lXxOrvl17i?=
 =?us-ascii?Q?6lBav+fIo0qJrGPw3HziaLham4LfesLVfWvue+8kgYqo6NBjvtqE7HXilmR0?=
 =?us-ascii?Q?gVl+L1CnbwhNDSIbKGxeJl1BIB9KJiY+FXdzQScsVYOCRYdah835+9/Au6Ng?=
 =?us-ascii?Q?jcPBLSmm8SHAZpmagOuoBZpcRg2LBIBIuaHXsd/GwLk6SA4q+2hoZe9V/5Pq?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e374f82e-7769-44ba-5760-08db6c504345
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 20:53:38.6860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZpxOHHWtU20cAVE8E8/jEJBDswvCw1CajeGJ08a8SiTggezU71fYaTVuuzrZCnYvccdkPl4TeSPBNVokI5ZotZUMt2bVs/St4h9fldUjq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6226
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Sun, 04 Jun 2023 16:31:59 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > In support of the Linux CXL core scaling for a wider set of CXL devices,
> > allow for the creation of memdevs with some memory device capabilities
> > disabled. Specifically, allow for CXL devices outside of those claiming
> > to be compliant with the generic CXL memory device class code, like
> > vendor specific Type-2/3 devices that host CXL.mem. This implies, allow
> > for the creation of memdevs that only support component-registers, not
> > necessarily memory-device-registers (like mailbox registers). A memdev
> > derived from a CXL endpoint that does not support generic class code
> > expectations is tagged "CXL_DEVTYPE_DEVMEM", while a memdev derived from a
> > class-code compliant endpoint is tagged "CXL_DEVTYPE_CLASSMEM".
> > 
> > The primary assumption of a CXL_DEVTYPE_DEVMEM memdev is that it
> > optionally may not host a mailbox. Disable the command passthrough ioctl
> > for memdevs that are not CXL_DEVTYPE_CLASSMEM, and return empty strings
> > from memdev attributes associated with data retrieved via the
> > class-device-standard IDENTIFY command. Note that empty strings were
> > chosen over attribute visibility to maintain compatibility with shipping
> > versions of cxl-cli that expect those attributes to always be present.
> Hmm.  I'm not keen on this, but I guess we've ended up in this corner
> so don't have much choice.

We could start with fixing that expectation and then set a deprecation
schedule for this workaround. I filed an internal task to track this.

> 
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Trivial stuff inline.
> 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index d3fe73d5ba4d..b8bdf7490d2c 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -254,6 +254,20 @@ struct cxl_poison_state {
> >  	struct mutex lock;  /* Protect reads of poison list */
> >  };
> >  
> > +/*
> > + * enum cxl_devtype - delineate type-2 from a generic type-3 device
> > + * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
> 
> Bit of a naming collision with other uses of DEVMEM but I can't immediately think
> of a better name so fair enough...
> 
> > + *			 HDM-DB, no expectation that this device implements a
> > + *			 mailbox, or other memory-device-standard manageability
> > + *			 flows.
> no requirement that this device
> 
> Expectation is a bit strong the other way to my reading.  These device might well
> implement some or all of that + other stuff that means they don't want to use the
> class code.

Fair enough.
