Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA161EB64DA
	for <linux-cxl@archiver.kernel.org>; Sat, 24 Jun 2023 13:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjFXNIT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 24 Jun 2023 09:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFXNIS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 24 Jun 2023 09:08:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76DB19AB
        for <linux-cxl@vger.kernel.org>; Sat, 24 Jun 2023 06:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687612096; x=1719148096;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7UP+SzIGSGZmO4X+Q46GiXJjolH9E1YpB4tBqboEgKc=;
  b=U408Gt+LJtu1ltnjdk9c9vyu8i+18M/+L4dBmjf9UCg1/X2vns98pNBZ
   HkOkgB6Zx8iG04m0eTH6L4a6umCVSKjbVND8PpV2R80KoT1Wi8i8nWAFj
   mDfcRFK/nsscZZl3LhQ0Qov7Rudc/X56K1baFKePc4hlG+RSAI2qHiiJD
   eypLmNmXFgic5PYPxDR2alTP29rji/NLC1a1Ck3Op39U3iunV+F/d5qFk
   GYgLPzD8BWrHwYIGmKAPIQZfuNuc+591x4jwO7l/7VH2/AI33mfG1uxkq
   c6DTWQzusYNlw2ANQAtUWmu/kLvgw/xG+ITC0BIillrlJ5w93+tbKT+ZR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="340535632"
X-IronPort-AV: E=Sophos;i="6.01,155,1684825200"; 
   d="scan'208";a="340535632"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 06:08:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="839742667"
X-IronPort-AV: E=Sophos;i="6.01,155,1684825200"; 
   d="scan'208";a="839742667"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 24 Jun 2023 06:08:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 24 Jun 2023 06:08:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 24 Jun 2023 06:08:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 24 Jun 2023 06:08:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 24 Jun 2023 06:08:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/yPf727Qcmf/4SzptGCc58KWvOKO6ZUYnym6majfq4dG9IiVFi+b26tojGTecC7P7vgc7QPrV+I9/L8V8wbqI/+6TLuoMz+ZiYD4Q6tqXQ7iUVmVxvLepiq66E4SQ73g+fKVgpOn77lHmjtc1o+RZl7k4YMGBF9/8JI6/IHvu00t+pkas6H6AlqspkTLseQVdFou4RV97v5wMqmpz+dKestWAFK2PJDSLMWBfZwh8bDgqANzf6+5F90cJ53D+4N3o4VHofmwXmmG4XeRuyaGOhf6gA+GhVfK4v9KlxW39gthbIvJxWK88a2iBwQDLsG4njCHvLBU1Qk+hHDC9M2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vnm+2/HcAvICFnhCHGvwcx4LcBrw4A6tshCeAZHdD7w=;
 b=S3QC71L1cTNxNtcK07wzYxSk86qSwF677Zw1M7X9WqhfaRPuKBWG+aItND4ybGIjTBf/RxfekDepVGrQrqDK93htrXLkAMAuGSGBdtyJ72jtx1qhb68BL7Ig6LwWVuqiZkAO4zmIifCtlrDAhDinZpUgw7NcRbjXDUiErUDEcMQKDS0XOosVlCyltBtQwQ0KdBqGdvucxGEijKgz26CKj5dqohNKGUH0xGkiBUtucYU0V2cYNt3DW8UyufQEonH55o7wMdFBsrTU2jnUEy1S/4nW0KZ9uGDcA2QuYEnaV/Mud/nmbe826srdgF+cvEwcM3H9UL3yG+yzSaX1KTjUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB7835.namprd11.prod.outlook.com (2603:10b6:8:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sat, 24 Jun
 2023 13:08:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6521.024; Sat, 24 Jun 2023
 13:08:10 +0000
Date:   Sat, 24 Jun 2023 06:08:04 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/5] cxl/mem : Read Dynamic capacity configuration from
 the device
Message-ID: <6496eab44738f_633d62946f@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-1-71b6341bae54@intel.com>
 <20230622165817.0000220e@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230622165817.0000220e@Huawei.com>
X-ClientProxiedBy: BYAPR02CA0067.namprd02.prod.outlook.com
 (2603:10b6:a03:54::44) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e63488e-cb0d-47da-f6bf-08db74b40ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pETRRs3WcioEcrO7Op5HpimTU5DhTkUh+o4quyI8krRXZx5z7fGNLRk/4O5TAO3zXg1ceW/2NHrFoQplwlsweCDDdAH2Kd+J2GizOJQYzSDFxaoWe/UR4BsFw0RLnrWynUV7jxJIT109niXEM8d39JF4NNiy+axjeE8sWyAXGXT2RrIsWf4/5N2KPPdkW6Ix5DyBGTLueT9woTsASgaljj9gc1rRZY8Pu6JbC5bxsSOO3TaXIi7aqnaZ2bDL7dJ7/92sY17DB2Vhz3Ybef85Sb9TqONzLOn1VoqjnpNdH42JYVQJTKCcF8Sfzs01UQ3UfJBUiua8dAV3qUnlpxaebCw2mIOXVZeZj4EDrNOP2gqNeyq4yJllrT1OXTlPhIc4V6Lm1OasyGe6WE0eGlvBhFpq9m7mAZDZufizEo8oItgDxjtouxP2ceTRVfK/knZXNTfnaUYHP3hLMndzl6DlaJq2hoFWzwRU9N88gm6NqxSmDwA//5jMUlLuEDc2URRJcdizOerEVzxokhD3N6PnYQvrMQUILOYN8fUQD1qINE0j40JTgSO+uf0lpwsU38nop35ugjG+muaoamKM0yVa9AO+YslSivcnGD+s1a4hsF6jY6yb3T6O5Ixgyj6srQE5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(38100700002)(8936002)(2906002)(66946007)(66476007)(54906003)(4326008)(86362001)(66556008)(83380400001)(316002)(8676002)(6486002)(41300700001)(30864003)(5660300002)(186003)(6512007)(6666004)(44832011)(9686003)(82960400001)(26005)(478600001)(6506007)(461764006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YlJlUkUTKsu2oJdmB889ZZ2pJp0qfoR/AGZK0OkvvVYBIlIT1d+FAdPTC65I?=
 =?us-ascii?Q?aubxcRgFbqyomtREJ3fdstrnWdXYb6Mq/juvs23hZa3oOiQzoqmVZ+IG+l+h?=
 =?us-ascii?Q?kZ3nWP9VdxEAwo1RkUQtFwtJjJ9HtNP/Lh64fS4PTkaw4/cvCUC/eLYoS6Hi?=
 =?us-ascii?Q?aFGDlu+4rym+Nmc4GioMNT9SXeaBBVH9m8tpHBo3PUGXoZNKb+rxMQuNkyRM?=
 =?us-ascii?Q?HpyCDCnNAIEbMKkN2JYIf7k2ohSN3j3u5EdXOCH3pPDvq8ocJrEWyQJk2Jo7?=
 =?us-ascii?Q?oBnAOg9YwIVh1GDZXkM66s14/NOY83m3jOrCdsqMzhdJm6x4v+MHXZU8qJAR?=
 =?us-ascii?Q?ZsxytaYC1l0zadS5aTHO1Zgk4OgbcJU/GPAbu/1BQkmqrQfcTzkzK3P+w71A?=
 =?us-ascii?Q?/jYRql0JLvrTLp5zT51Sr54zqreTwACCMPEeSDRtsj6MoSCa1o9kRiAH7483?=
 =?us-ascii?Q?P3W1RtsgeuZaqE+5Q/pvK9Z6ohL0NL+IY/nN2jsiWiGvCOf91Qj5YBwxEyJP?=
 =?us-ascii?Q?e40cMA2//zojnrqq/ixxygEkBBAXpdWHo1IZViHhGyfz9ZXMUZMLPVFtqRy4?=
 =?us-ascii?Q?0j7sb5kex160cHUGPwo6OGId0LC3LNb1CxpMsRfKKjgwvMoicezToOrElcO4?=
 =?us-ascii?Q?gvsPqlgr8xHUBXfyaR9YkHAQY/Kypio/euwZCeXfSycS/SdTO+72rAt8he0U?=
 =?us-ascii?Q?zgfeuGtrFVqkpgT9Sy9X5kxt0NTSvheEd4znpjYRWGAXHEQ6Q4o5fQwVB1dg?=
 =?us-ascii?Q?lSu6l/LyqvLNWvroiC9dGeP4j1oV4of/0656zeo8rMIYjCE/mfm4T4aNXXvo?=
 =?us-ascii?Q?7B7aWAahvG3Kmrj+aDJchK5+YBNNgauN2wdqBTh8o8xMvx+j12RIw1ghWt2A?=
 =?us-ascii?Q?0uiVDwBSmkM8WyzMRiIQhWG7gqLnp9o3u/ewc4smWhIfp/MQkLeJp/IfeRAd?=
 =?us-ascii?Q?QEnNhgSJyuiaOh6DEpBZfg4TsTgIaTl90M5Mr1DgCRvYXOHtlzB0mFpKs7mO?=
 =?us-ascii?Q?o+ds35teyEUvjvi6KHrdsljOGNCMU7FQBtx8D28k+WncZFjeC9dnseD84PAO?=
 =?us-ascii?Q?WX+f0lMR6MEjfiCOv2msm3pfjFZ2T2RqjkNDHoyg6ZThrwvrRrNKumRUfUhm?=
 =?us-ascii?Q?DDQMCoHHWCZ2a8pClV0vkHyMVVcv0qJ+Elro6bsypMwQ0Jn9cyHgOz7SoKj3?=
 =?us-ascii?Q?B96swWhNHdTCsSGEZvOz45NDYCKElcDoDE1AngRtEqdrQtqNdxfA9NVA64tl?=
 =?us-ascii?Q?aTyXMwtMwBEkG6GBJi5h8UPK5Q3HbMdI4j2SEA/yHFn5ODE2O4fJe6bhem8q?=
 =?us-ascii?Q?YqR1ysp2yJlyMCQI7ARDdQGq2FeD5kJKrjUBPHy56pBEwb6evsCmIT4EqXUE?=
 =?us-ascii?Q?uB6UHSuWN6tOkRxCE5ae3+eHtLzOqzVFthB32iSuHY+/pjm9MuGHmIpB4mvp?=
 =?us-ascii?Q?THzfmF4+ggeekrK1rUp/P2UfCpJwUhKVvjNUgWE6BlcMTPHu7HLDtVhVhh99?=
 =?us-ascii?Q?mNH2ThQPwt3HAdYEKvHeiRshxr1RsqXAqPMjz/cfrW+jzhA+6xarDo4rYc86?=
 =?us-ascii?Q?BgRm+q6IzhFvxuJVJmPspAzmDo70vAD+SSvNptmr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e63488e-cb0d-47da-f6bf-08db74b40ede
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 13:08:09.9478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrb8XwM/8aCF70rAPhl/g9O9H/oSePqSLQSV7Tt8WzOGrJQFz4dhnRLnr4T3hBV9wFhzoz9+dJN0zForSc2EsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7835
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 14 Jun 2023 12:16:28 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Read the Dynamic capacity configuration and store dynamic capacity region
> > information in the device state which driver will use to map into the HDM
> > ranges.
> > 
> > Implement Get Dynamic Capacity Configuration (opcode 4800h) mailbox
> > command as specified in CXL 3.0 spec section 8.2.9.8.9.1.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> 
> Hi Ira / Navneet,
> 
> I'll probably overlap with comments of others (good to see so much review!)

Indeed!  Thanks!

> so feel free to ignore duplication.
> 
> Comments inline,
> 
> Jonathan
> 
> 
> 
> > +/**
> > + * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> > + * information from the device.
> > + * @mds: The memory device state
> > + * Return: 0 if identify was executed successfully.
> > + *
> > + * This will dispatch the get_dynamic_capacity command to the device
> > + * and on success populate structures to be exported to sysfs.
> > + */
> > +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> > +{
> > +	struct cxl_dev_state *cxlds = &mds->cxlds;
> > +	struct device *dev = cxlds->dev;
> > +	struct cxl_mbox_dynamic_capacity *dc;
> 
> Calling it dc is confusing.  I'd make it clear this is the mailbox
> response. config_resp or dc_config_res.

How about dc_resp?

> 
> > +	struct cxl_mbox_get_dc_config get_dc;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	u64 next_dc_region_start;
> > +	int rc, i;
> > +
> > +	for (i = 0; i < CXL_MAX_DC_REGION; i++)
> > +		sprintf(mds->dc_region[i].name, "dc%d", i);
> > +
> > +	/* Check GET_DC_CONFIG is supported by device */
> > +	if (!test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds)) {
> > +		dev_dbg(dev, "unsupported cmd: get_dynamic_capacity_config\n");
> > +		return 0;
> > +	}
> > +
> > +	dc = kvmalloc(mds->payload_size, GFP_KERNEL);
> > +	if (!dc)
> > +		return -ENOMEM;
> 
> Response to CXL_MBOX_OP_GET_DC_CONFIG has a known maximum
> size. Can we provide that instead of potentially much larger?
> 
> 8 + 0x28 * 8 I think so 328 bytes. Use struct_size()

Actually yea and just putting that on the stack might also be better.

> 
> 
> But fun corner.... Mailbox is allowed to be smaller than that (256 bytes min
> I think) so need to handle multiple reads with different start regions.

Oh bother.  :-/

What are the chances a device is going to only support 256B and DC?  I think
you are correct though.  I'll add a loop to handle this possibility.

Anyway I've adjusted the algorithm...  Hopefully it will just loop 1 time.

> Which reminds me that we need to add support for running out of space
> in the mailbox to qemu... So far we've just made sure everything fitted :)

Might be nice to test stuff.

> 
> 
> > +
> > +	get_dc = (struct cxl_mbox_get_dc_config) {
> > +		.region_count = CXL_MAX_DC_REGION,
> > +		.start_region_index = 0,
> > +	};
> > +
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
> > +		.payload_in = &get_dc,
> > +		.size_in = sizeof(get_dc),
> > +		.size_out = mds->payload_size,
> > +		.payload_out = dc,
> > +		.min_out = 1,
> > +	};
> > +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > +	if (rc < 0)
> > +		goto dc_error;
> The error label is a bit too generic.  Why dc_error?
> "error" conveys just as small amount of info.  I'd got for goto free_resp;

Sure.  But if we make dc on the stack then we get rid of this entirely.  I
prefer that.

> 
> > +
> > +	mds->nr_dc_region = dc->avail_region_count;
> > +
> > +	if (mds->nr_dc_region < 1 || mds->nr_dc_region > CXL_MAX_DC_REGION) {
> > +		dev_err(dev, "Invalid num of dynamic capacity regions %d\n",
> > +			mds->nr_dc_region);
> > +		rc = -EINVAL;
> > +		goto dc_error;
> > +	}
> > +
> > +	for (i = 0; i < mds->nr_dc_region; i++) {
> > +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> > +
> > +		dcr->base = le64_to_cpu(dc->region[i].region_base);
> > +		dcr->decode_len =
> > +			le64_to_cpu(dc->region[i].region_decode_length);
> > +		dcr->decode_len *= CXL_CAPACITY_MULTIPLIER;
> > +		dcr->len = le64_to_cpu(dc->region[i].region_length);
> > +		dcr->blk_size = le64_to_cpu(dc->region[i].region_block_size);
> > +
> > +		/* Check regions are in increasing DPA order */
> > +		if ((i + 1) < mds->nr_dc_region) {
> 
> Feels a bit odd to look at entries we haven't seen yet.  Maybe flip this around
> to check the ones we have looked at?

Totally agree.  I already did that.

> So don't start until 2nd region and then check
> it's start against mds->dc_region[0] etc?

Yep!  It makes the check easier...

> Or factor out this loop contents in general and just pass in the single
> value needed for checking this. Biggest advantage being direct returns in
> that function as allocation and free will be in caller.

Did that too.  I did not like how big cxl_dev_dynamic_capacity_identify() was
getting, especially with possibility of having to loop for a 2nd time.

> 
> 
> > +			next_dc_region_start =
> > +				le64_to_cpu(dc->region[i + 1].region_base);
> > +			if ((dcr->base > next_dc_region_start) ||
> > +			    ((dcr->base + dcr->decode_len) > next_dc_region_start)) {
> 
> Unless you have a negative decode length the second condition includes the first.
> So just check that.

... exactly!

> 
> > +				dev_err(dev,
> > +					"DPA ordering violation for DC region %d and %d\n",
> > +					i, i + 1);
> > +				rc = -EINVAL;
> > +				goto dc_error;
> > +			}
> > +		}
> > +
> > +		/* Check the region is 256 MB aligned */
> > +		if (!IS_ALIGNED(dcr->base, SZ_256M)) {
> 
> That's an oddity. I wonder why those lower bits where defined as reserved...
> Anyhow code is right if paranoid ;)

:shrug:

> 
> > +			dev_err(dev, "DC region %d not aligned to 256MB\n", i);
> > +			rc = -EINVAL;
> > +			goto dc_error;
> > +		}
> > +
> > +		/* Check Region base and length are aligned to block size */
> > +		if (!IS_ALIGNED(dcr->base, dcr->blk_size) ||
> > +		    !IS_ALIGNED(dcr->len, dcr->blk_size)) {
> > +			dev_err(dev, "DC region %d not aligned to %#llx\n", i,
> > +				dcr->blk_size);
> > +			rc = -EINVAL;
> > +			goto dc_error;
> > +		}
> > +
> > +		dcr->dsmad_handle =
> > +			le32_to_cpu(dc->region[i].region_dsmad_handle);
> > +		dcr->flags = dc->region[i].flags;
> 
> I'd just grab these at same time as all the other fields above.
> A pattern where you fill values in only after checking would be fine, or one
> where you fill them in all in one place. The mixture of the two is less clear
> than either consistent approach.

Ok, yea this did seem odd but I kind of ignored it.  Done.

> 
> > +		sprintf(dcr->name, "dc%d", i);

I may take this out too now that we always set the name regardless of if the
region is available.

Although...  I wonder if setting the name to something like '<nil>' by default
would be beneficial in some way?  :-/

> > +
> > +		dev_dbg(dev,
> > +			"DC region %s DPA: %#llx LEN: %#llx BLKSZ: %#llx\n",
> > +			dcr->name, dcr->base, dcr->decode_len, dcr->blk_size);
> > +	}
> > +
> > +	/*
> > +	 * Calculate entire DPA range of all configured regions which will be mapped by
> > +	 * one or more HDM decoders
> > +	 */
> > +	mds->total_dynamic_capacity =
> > +		mds->dc_region[mds->nr_dc_region - 1].base +
> > +		mds->dc_region[mds->nr_dc_region - 1].decode_len -
> > +		mds->dc_region[0].base;
> > +	dev_dbg(dev, "Total dynamic capacity: %#llx\n",
> > +		mds->total_dynamic_capacity);
> > +
> > +dc_error:
> > +	kvfree(dc);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> > +
> 
> 
> 
> > @@ -1121,13 +1289,23 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> >  	}
> >  
> >  	cxlds->dpa_res =
> > -		(struct resource)DEFINE_RES_MEM(0, mds->total_bytes);
> > +		(struct resource)DEFINE_RES_MEM(0, mds->total_capacity);
> > +
> > +	for (int i = 0; i < CXL_MAX_DC_REGION; i++) {
> > +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> > +
> > +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->dc_res[i],
> > +				 dcr->base, dcr->decode_len, dcr->name);
> > +		if (rc)
> > +			return rc;
> > +	}
> >  
> >  	if (mds->partition_align_bytes == 0) {
> >  		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> >  				 mds->volatile_only_bytes, "ram");
> >  		if (rc)
> >  			return rc;
> > +
> 
> Scrub for this stuff before posting v2. Just noise that slows down review
> a little.  If it is worth doing, do it in a separate patch.

I believe Alison or Dave caught that already.

> 
> >  		return add_dpa_res(dev, &cxlds->dpa_res, &cxlds->pmem_res,
> >  				   mds->volatile_only_bytes,
> >  				   mds->persistent_only_bytes, "pmem");
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 89e560ea14c0..9c0b2fa72bdd 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> >
> >  
> > +#define CXL_MAX_DC_REGION 8
> > +#define CXL_DC_REGION_SRTLEN 8
> 
> SRT? 

LOL oh yea 'STR'...  :-D

> 
> > +
> >  /**
> >   * struct cxl_dev_state - The driver device state
> >   *
> > @@ -300,6 +312,8 @@ enum cxl_devtype {
> >   * @dpa_res: Overall DPA resource tree for the device
> >   * @pmem_res: Active Persistent memory capacity configuration
> >   * @ram_res: Active Volatile memory capacity configuration
> > + * @dc_res: Active Dynamic Capacity memory configuration for each possible
> > + *          region
> >   * @component_reg_phys: register base of component registers
> >   * @info: Cached DVSEC information about the device.
> >   * @serial: PCIe Device Serial Number
> > @@ -315,6 +329,7 @@ struct cxl_dev_state {
> >  	struct resource dpa_res;
> >  	struct resource pmem_res;
> >  	struct resource ram_res;
> > +	struct resource dc_res[CXL_MAX_DC_REGION];
> >  	resource_size_t component_reg_phys;
> >  	u64 serial;
> >  	enum cxl_devtype type;
> 
> ...
> 
> > @@ -357,9 +379,13 @@ struct cxl_memdev_state {
> >  	size_t lsa_size;
> >  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
> >  	char firmware_version[0x10];
> > +	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
> >  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
> >  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> > -	u64 total_bytes;
> > +
> > +	u64 total_capacity;
> > +	u64 total_static_capacity;
> > +	u64 total_dynamic_capacity;
> >  	u64 volatile_only_bytes;
> >  	u64 persistent_only_bytes;
> >  	u64 partition_align_bytes;
> > @@ -367,6 +393,20 @@ struct cxl_memdev_state {
> >  	u64 active_persistent_bytes;
> >  	u64 next_volatile_bytes;
> >  	u64 next_persistent_bytes;
> > +
> > +	u8 nr_dc_region;
> > +
> > +	struct cxl_dc_region_info {
> > +		u8 name[CXL_DC_REGION_SRTLEN];
> 
> char? SRT?  Also isn't it a bit big? Looks like max 4 chars to me.
> Put it next to flags and we can save some space.

Well if I go forward with the idea of having them named something like '<nil>'
this would need to be longer than 4.

> 
> > +		u64 base;
> > +		u64 decode_len;
> > +		u64 len;
> > +		u64 blk_size;
> > +		u32 dsmad_handle;
> > +		u8 flags;
> > +	} dc_region[CXL_MAX_DC_REGION];
> > +
> > +	size_t dc_event_log_size;
> 
> >  /*
> > @@ -617,7 +662,27 @@ struct cxl_mbox_set_partition_info {
> >  	u8 flags;
> >  } __packed;
> >  
> > +struct cxl_mbox_get_dc_config {
> > +	u8 region_count;
> > +	u8 start_region_index;
> > +} __packed;
> > +
> > +/* See CXL 3.0 Table 125 get dynamic capacity config Output Payload */
> > +struct cxl_mbox_dynamic_capacity {
> > +	u8 avail_region_count;
> > +	u8 rsvd[7];
> > +	struct cxl_dc_region_config {
> > +		__le64 region_base;
> > +		__le64 region_decode_length;
> > +		__le64 region_length;
> > +		__le64 region_block_size;
> > +		__le32 region_dsmad_handle;
> > +		u8 flags;
> > +		u8 rsvd[3];
> > +	} __packed region[];
> > +} __packed;
> >  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
> 
> This looks to have merged oddly with existing changes. I'd
> move the define into the structure definition so ti's clear which
> flag it reflects and avoids this sort of interleaving in future.

That has not been done anywhere in this file.  I think in this case it was just
a mistake to separate the partition define from the partition structure.  We
already fixed that based on Alisons feedback.

What I did do is move CXL_DC_REGION_STRLEN next to cxl_dc_region_info and made
it 7 chars to compact the structure a bit.  I think having that define next to
the structure helps to show why the odd length.

While we are at it I'm changing the sprintf's to snprintf's.  We are not in a
fast path and I'm paranoid now.

Ira
