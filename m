Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D51AEB64D7
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jun 2023 00:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241534AbjFNApV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 20:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjFNApU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 20:45:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA8419A5
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 17:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686703519; x=1718239519;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bqpo0Vi6IZpocFfH4Id5Owsl6sdU39clIpQ6rdm+rOA=;
  b=LiDeI4JpG/rkceETJ4VBGmIvo7eR/hQdSRV/1kTidILL+OvuB11Dl4VT
   5VcYC2kaJ892oynSyFltkH3S6KEacQ671rHo3OqwMwomNpsaFPBnb5mK9
   P9NI2kDcUE5ks2ILGNA6McKToaUGt/nzlQ0RYbviaAg1Tfk3SGlMHy/Vq
   DBVYnzErT4WB8emyNOUiQ2jsd0K7WdDL8b6bX5eo7W1dQhlpkcYfFXkVE
   P4V+29FaFlxCJ4LWss5zixJsqowzhfQgNA3gdAeij0q3dDspOy/keAbk4
   QgOp7MTdUO/RXONA3Lf1uYNyuHkMgPTZLDUeJFUC8ocTA7+ptzYqta6ji
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="422085698"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="422085698"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 17:45:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="1041977103"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="1041977103"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jun 2023 17:45:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 17:45:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 17:45:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 17:45:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f24v2t4zxXEn4DmvM1JPo831eO8mEPwZQ3H9Epb/PdzCJjGidYBlg6nssIrd9mJf9GdlIKxX8OJYWx2/4Taw/7L8KdLFYtM78StgNbaD7lyzzuBx5tblfb4rtHUQkKcxbxiLJzNmZmrbW44OHPKcy1nEoFbvvRmlvL1OQpkexG7xINmW6NgOVLqBVyIlY7nmmRfMU/HSPAxymwAdsNfhDqGmtOKcu6+JwCKZ5+XnSyUnFzZO+41OglN3vAygcL2i1UVAD04QDYHzKKcE7uQQjrWsVuq5n6gBgBpVAcim95kVraGKlx5IrIEB59tQ8oJbsDmi/Cm7NkVGPwuedqgkaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tgrqk6AUnRfrZUFvRf6a+IgfVTsOsOeI6MI/QgrHuUM=;
 b=NuT4kJ4CiBZJGbe4kRdIWuUawRe2LTbaUTNTjyrnKtXKsq3sowJ9E1A84THr7I0js56mojhdp8WI0rPHLLVitWA8TJewBofvq3FmhOuxNcVZF3Gi6U5/BH4WFSJwIzCwhxF/yquc8r8UklD2VGwtSxrPqutAsaIOFwhtFd/bqEIyy7h70+gNexPcWhh9zz1H0dZN4WD6gjq6amUmUDKVdGTGfNAMpFcF+YEL38/55rvz56xdJx9jcGW6a+llnuPCK/6Ngsx929lc5iZ1tklwhMHDhB5rR5AhTAvYGnXvQlTyXymBmtmZMOZpzCiF2aroFd8GB8EtFru6GajWix/vgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7582.namprd11.prod.outlook.com (2603:10b6:806:31e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 14 Jun
 2023 00:45:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 00:45:16 +0000
Date:   Tue, 13 Jun 2023 17:45:13 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 03/19] cxl/mbox: Move mailbox related driver state to its
 own data structure
Message-ID: <64890d99746c5_2f4fca29457@dwillia2-xfh.jf.intel.com.notmuch>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592151409.1948938.14287743104711770676.stgit@dwillia2-xfh.jf.intel.com>
 <20230606121054.000069e1@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230606121054.000069e1@Huawei.com>
X-ClientProxiedBy: BYAPR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::39) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: e9398188-6d9b-48f1-9a56-08db6c709eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gkGQyK7fDXpA/1+kOK4ZR/tX35jblVvVXhJHAwz7jB0EnkeXjCC2/GiTlgi6WQWLUwQGrahZ7Ex/QypdQGPZ3hzQdWdB2faCApdvWxKxVXSJtUmd4ljNRtlfCphiMjebgo97eqxFXiuUf6TsO0E1Y3DcaMWNWg3yOefYc8ZCrO2GYshK4HzzWkKlUbsQCgVTfx4Ph9r9K5IWaL1J0V+s/LVsU3zISe5xnVPjKdfGy6j5y+B+aeLKzZiPfa1Sbl3Bs1vPQnqVcbaoY8qj8oM44wMyxC1XshTMM1y/IRQnJo1zUGeVeSsB75x6C4f6d2K40wdUdqAxEJdmgDjpjlUExKNRepbQXyYQUHbPif3wA6yWeobQgdnBYM5i3grYQxRIHEtpYaZPioijjdZD3DFfCyD0+Ih6hsjalGQ5bsKNK+l4PLCe0QIhKeNjje6iMgDMOxGwblEM6cah8yeqoSbcu0uosjTSY47vfQwB6BCtoaW+TLpE8/dQ6lDRcjKhBoRjmcyw3umJ9tarE6jbNqiQ2yhgIYZ49zfO/hGsBPNNFoCsExlzdJFvYz1XBsdMA+u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(2906002)(83380400001)(15650500001)(86362001)(38100700002)(82960400001)(316002)(6486002)(6666004)(41300700001)(5660300002)(110136005)(8936002)(107886003)(8676002)(478600001)(66476007)(66946007)(6512007)(66556008)(4326008)(6506007)(26005)(9686003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5hDfJCvzq/BiSqYwJ0uYbWRVHjz85OVFHSjsT9DBkODIWAQCJgNsjiAMObB/?=
 =?us-ascii?Q?nbfQakGyHNXpiQ+pdFP1XbEPqg4L+QKuQ2u427GqvjYHDLIxJZOkfUDtdYBi?=
 =?us-ascii?Q?pS97dzKYYhDpbIbsu7xyIImL3TVA3PZvFhQKYEXPTGRL0cnHjm2jKZ45m8qZ?=
 =?us-ascii?Q?JDBHo1bh4/w5obQqfHxNTeBlwXgz/xRCxrHIDRU1uqawZKajcv9I7yrzBIGI?=
 =?us-ascii?Q?P/+ga8BN/dXcr7POoK3w2e4/DTyFGgLav5N9uyG9Z4PRHsbekiQjjRPS+766?=
 =?us-ascii?Q?e2ESm5DEU3ZSgvlxPHuTinD7CiAQuedoR+3OC7Gvvl48ZSBPNw89UVdxPASP?=
 =?us-ascii?Q?XDPBmP0VNd/PNm/T6+A4RZw8VfwgRLKUSulvZPgP1Dm/czCzMw+rBmT+ceFU?=
 =?us-ascii?Q?e63kJTKGsGj4IUvaZ2VvnnLIrGJFbjqI3hyMzukzNBpcBrgzF81DwG5l8UMm?=
 =?us-ascii?Q?+82jJXDHmLm41hgQZKn1cN6l09DRBC9uo4xEqFD4aQt4JDTifBOIJPQ2U3F7?=
 =?us-ascii?Q?P7xla+5K2aG4qy8zHTcETrpytWMGiocvqO0ql7UhsZb/9rVzPDjEHP9A8G88?=
 =?us-ascii?Q?7JwU5UY3tgOqEyUPT3tyFiBeZBKkCeegeitM5GfvFutzytVwwT/tsUrCTRSN?=
 =?us-ascii?Q?2wQhaYXdG4IygwdSZSyCQhdwHp6Zer6O4i8GDBJcdfR2vmtMFT2itAEmERCh?=
 =?us-ascii?Q?2gWwe8pOTx+QPQK26QS7PsOPtDtkZqQXQ7Ny8nV+W9LuMJTk1+16sgf7cIT4?=
 =?us-ascii?Q?jyTGLj5zC7/KJHIzXNEhxxVGx8vx3le3bHpPPnS0BX7uJE7d6Oddb5Sop+hf?=
 =?us-ascii?Q?h5rSlEWY+8HPRVrdbMYNwYc3YfFFJUNG5gihNPXki3o9NSJyWaepqDeB+GCF?=
 =?us-ascii?Q?y0Ml67jHTN8q6YL/6UkgQQ2Qipxb0CVAOL1zx54YTTUFAVNcFCyvpQ+79zdy?=
 =?us-ascii?Q?1gHph6iBgTvKhNcYXqqRiYGKBxh/aT0pdB6QVMLE5/cRTJs/pOacWhg5fx4m?=
 =?us-ascii?Q?ACbM4A1Qkvt5TOakslnKDugqF+PUDHscOihGFJCRqwqMJ7tapVwriZcs2yG2?=
 =?us-ascii?Q?HJOXqYuHOmFKRTzeXDDADBOhl5wHk3B7kHnKiyLsD2O+KcQoZp50a+QOt4VO?=
 =?us-ascii?Q?wzCI3qx8vdXjhAUC0mGwBiNq5UyIqzzlrzTspooY0GhvJL2WhEp1jRhuq6Pq?=
 =?us-ascii?Q?0BfELWZIllFWgvz0kpeohP83GlnxzGp4EpYbmSKJzsfK6D22hUOHGz9KoC0c?=
 =?us-ascii?Q?/i8Khw5zr7W40XyaLaRokHhxf5yYN1bfUtoZpZUdAZ3gnXRsMLtTMIcMN8mG?=
 =?us-ascii?Q?cAAhzueBF0fCsqJVFUBuQ1akPESpiUwNcNYcwYP3cE374yE17u8yAMgS+IkB?=
 =?us-ascii?Q?ujYEfLPRYUBd3PxMHJj9vqzm94iyVZ1JyqGx38MvJS2LHuYfwO7bQpDWkrIW?=
 =?us-ascii?Q?czdNi5eFDVsJmGR77D57raJl7XX/H5YX97645jZC0tKu+OlpgpUSu93VbFFA?=
 =?us-ascii?Q?jEDCNydQpJJu3tUXm9g42XgKfSyKNYQVQHFVpcNLvT68dA+WmZD6hPUIyp1b?=
 =?us-ascii?Q?TIpSmY04FTbgNddzUUdHkHWXe62y1+M0PvDzK6bp6U0ezcvgYle19gg3onq2?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9398188-6d9b-48f1-9a56-08db6c709eab
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 00:45:15.9441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQHt/V99V84gQ4O4kwbT9c6mCClxl5K80DtCAcaxv6f14FTmIAOv9+dtd28Mzf8l4OVtGVEfNFvLCm0cvbrDpxZGxVZ1j7FTfxSEWktksiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7582
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Sun, 04 Jun 2023 16:31:54 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > 'struct cxl_dev_state' makes too many assumptions about the capabilities
> > of a CXL device. In particular it assumes a CXL device has a mailbox and
> > all of the infrastructure and state that comes along with that.
> > 
> > In preparation for supporting accelerator / Type-2 devices that may not
> > have a mailbox and in general maintain a minimal core context structure,
> > make mailbox functionality a super-set of  'struct cxl_dev_state' with
> > 'struct cxl_memdev_state'.
> > 
> > With this reorganization it allows for CXL devices that support HDM
> > decoder mapping, but not other general-expander / Type-3 capabilities,
> > to only enable that subset without the rest of the mailbox
> > infrastructure coming along for the ride.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> I'm not yet sure that the division in exactly in the right place, but we
> can move things later if it turns out some elements are more general than
> we currently think.

Agree, it is more along the lines of: the current trajectory of 'struct
cxl_dev_state' is unsustainable, stem the tide, and revisit as needed.

> 
> A few trivial things inline.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
> > ---
> 
>  
> > -static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_dev_state *cxlds)
> > +static struct cxl_mbox_get_supported_logs *
> > +cxl_get_gsl(struct cxl_memdev_state *mds)
> 
> I'd consider keeping this on one line.  It was between 80 and 90 before and still is...
> 
> 
> >  {
> 
> 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index a2845a7a69d8..d3fe73d5ba4d 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -267,6 +267,35 @@ struct cxl_poison_state {
> >   * @cxl_dvsec: Offset to the PCIe device DVSEC
> >   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> >   * @media_ready: Indicate whether the device media is usable
> > + * @dpa_res: Overall DPA resource tree for the device
> > + * @pmem_res: Active Persistent memory capacity configuration
> > + * @ram_res: Active Volatile memory capacity configuration
> > + * @component_reg_phys: register base of component registers
> > + * @info: Cached DVSEC information about the device.
> 
> Not seeing info in this structure.
> 
> > + * @serial: PCIe Device Serial Number
> > + */
> > +struct cxl_dev_state {
> > +	struct device *dev;
> > +	struct cxl_memdev *cxlmd;
> > +	struct cxl_regs regs;
> > +	int cxl_dvsec;
> > +	bool rcd;
> > +	bool media_ready;
> > +	struct resource dpa_res;
> > +	struct resource pmem_res;
> > +	struct resource ram_res;
> > +	resource_size_t component_reg_phys;
> > +	u64 serial;
> > +};
> > +
> > +/**
> > + * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
> > + *
> > + * CXL 8.1.12.1 PCI Header - Class Code Register Memory Device defines
> > + * common memory device functionality like the presence of a mailbox and
> > + * the functionality related to that like Identify Memory Device and Get
> > + * Partition Info
> > + * @cxlds: Core driver state common across Type-2 and Type-3 devices
> >   * @payload_size: Size of space for payload
> >   *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
> >   * @lsa_size: Size of Label Storage Area
> > @@ -275,9 +304,6 @@ struct cxl_poison_state {
> >   * @firmware_version: Firmware version for the memory device.
> >   * @enabled_cmds: Hardware commands found enabled in CEL.
> >   * @exclusive_cmds: Commands that are kernel-internal only
> > - * @dpa_res: Overall DPA resource tree for the device
> > - * @pmem_res: Active Persistent memory capacity configuration
> > - * @ram_res: Active Volatile memory capacity configuration
> >   * @total_bytes: sum of all possible capacities
> >   * @volatile_only_bytes: hard volatile capacity
> >   * @persistent_only_bytes: hard persistent capacity
> > @@ -286,54 +312,41 @@ struct cxl_poison_state {
> >   * @active_persistent_bytes: sum of hard + soft persistent
> >   * @next_volatile_bytes: volatile capacity change pending device reset
> >   * @next_persistent_bytes: persistent capacity change pending device reset
> > - * @component_reg_phys: register base of component registers
> > - * @info: Cached DVSEC information about the device.
> 
> Not seeing this removed from this structure in this patch.
> Curiously doesn't seem to be here in first place.
> 
> Probably wants precursor fix patch to get rid of it from the docs.

I did some digging and it turns out the cxlmem.h is not even built
during a docs build, but I went ahead and added another patch to clean
up warnings from:

./scripts/kernel-doc drivers/cxl/cxlmem.h

I will note though that the extra kdoc descriptor was not flagged, only
missing attribute definitions are flagged.
