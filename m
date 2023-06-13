Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0381AEB64D7
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 21:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjFMVXo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 17:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjFMVXn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 17:23:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DCC19B6
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686691422; x=1718227422;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VbQs7AYA6ey0CRt3fodvMTjebyTMj/F8pafce3puKY8=;
  b=YXsMJQl2UQMX9Ep2EY72B3UkhAeyocrpab2UP4MuKcF4ruGksdKkcPWq
   plWnHNzRYWEmNWjM5OVVjlGL86qNdSaRfYZMZW5IRcHYnrXnB1hu5ilaL
   v0x4qwHrdjDQVVS0h/kQGztMxz44EjQoIC+gDEhF+DHmkpRYkcN33I5lz
   /LKVo6P+AjRfgGZ0Y+eK3HstPKtLFfetr5g6GXk9i9MuJCjrm00Jyi9ky
   fbb98H76itm6cdcuf7V83I9orH3DPVBdqJHrDMAdjWtA2J/tksxJi+nAZ
   2iD/bDl8EJf/s17FGj+ZGQzYCNVsTy/eNDhXRbb3uQ+CajZV78MRMboUF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="424337450"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="424337450"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 14:23:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="714945955"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="714945955"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2023 14:23:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 14:23:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 14:23:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 14:23:35 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 14:23:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GL7mRbqBre1S7UqUbJgojHt+dcOjlT2iv/yc1BVE4+VlpH8K3Mb6QJjkUvwMyCwpwZvkamH9sijdRavJK20Q75ScOxajOOfGfMltjeEuP3uvC12dYhss2E5a+rzTfwXlOf6ooC3+YrJTXph6VPnzr4v5PamBD8wf9BUFIZFPTGm3UxPSCKOBkoamqSyc9rHdQdnwWJNFl2WA+7kuEOUinM8uD0i1qMgSReMKvN7deUXiXJw9abur6tpfiuA5XvLU9/OQkXQL80MInV7Ibirc4fpetyI64c2/mhtlgj7GDGeH1q6kACKtrfucCqFy/be/7xsGVxtbkzXmi5+WkqJdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/XMaBNj/sY7xKwXCyxgODsw5d186N+Rnnyc3EQPFpI=;
 b=fa13CxQRVbXEHirv9FZPNIfh2KyPBrHMU92R0wfQ2M9AxOXRgIkZcHqqo502/031SHNQNUghoAOIOW80AwK90ZTYpd5gUC3pxqctPkmltxJETZ3IGXGNQGNjSyKjCqHbSo6HbqqR0+GeDDqAFwA8AXjtidNO3DRe0c61jHONerC5cjXVK4UOeb89/D5cD8s+ddsORcnimIbK5872RwGH7UriTNl7fBwcZR7f65JmSb4vpYe/K01rTC8/9IbHbhob7Yxk02SAUtCyELV2bUwNhYND/V0uzZSfTMbHnWO4UJSS9twu7bZ2OOpRxFZlXZ+cboFNm84OGKUIJcikutLbXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5238.namprd11.prod.outlook.com (2603:10b6:208:313::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 21:23:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 21:23:30 +0000
Date:   Tue, 13 Jun 2023 14:23:27 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 06/19] cxl/hdm: Default CXL_DEVTYPE_DEVMEM decoders to
 CXL_DECODER_DEVMEM
Message-ID: <6488de4fc3e45_e067a2948a@dwillia2-xfh.jf.intel.com.notmuch>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592153054.1948938.12344684637653088842.stgit@dwillia2-xfh.jf.intel.com>
 <20230606122723.0000093d@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230606122723.0000093d@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:a03:338::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: 4914573d-e307-4b75-fa85-08db6c546ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +f21rBrTQYf1oHK/6DC9I8veIvAoBiw20zE4wuBOALn6ZSWRoZnKjq5k5MNdn/xWwzrkx3Ur7tjysa/2bjIIOmb1/BvUQchUlbXkkMOv4ZleuLkP2WpkrQlHPe91xCBVxYDZB0MMIhtBwY2tUdBCyZXZPZtD7S6c1EKArHxC+V/dv7d/RvaxUFB6r2mK9Nesj3vZYnAxWIBMryxnICk2HRhscmHjZ5PxzQyeiiaeTspjp/sIU5/kOjrny2A7ncOyuMldr5LPMVYXUAjfXZJTT8RQXOjvi2ROAfaZ/iwW//qCt9y+vql6nMGiCg7QbVv45WKjTVNHoMsRf8ARrU+OpEtaI3FivTH5N1e70SEE8gPsDmAD+WF3aYvFdsqOvRhVWMZwfGaC/CjVc8h81QUcA6pqm29IiwmF0+pPub+mT1r23joND5SSVlBIr2ZC6wnhGWBni18rhFyCO565KdYt8EjJk3WHKGoFW8RhX4kSOkQEL6rmOPCApRL6gWbYrAu1ObGz4ipC0+Ej34JXLtThJ28rjgJ4BPgZ7hl6DjvFfb6gNBtPbimZDRtP2e4yZ/lr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199021)(5660300002)(8676002)(2906002)(8936002)(66946007)(66556008)(66476007)(110136005)(6486002)(6666004)(4326008)(107886003)(6506007)(9686003)(6512007)(26005)(316002)(186003)(41300700001)(82960400001)(83380400001)(478600001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TmaRSx7zoQmO2WtUK9+jwEVwEyRSFSM4Hkf+kSVRO1WbT6bb8VTDjts2FraJ?=
 =?us-ascii?Q?UtS9nuP1PL8Tjic71kGUI5UxTNBuEOG2wkYC+kOTi+C6fiYgtO/RSK48yO1I?=
 =?us-ascii?Q?HFPZX35etZvtVW1PopRbIsi/TmR6bEfjv6NQb6mYpP+AqV1MjbMMBGnb5S+v?=
 =?us-ascii?Q?woP3dgcp2axmJgRpld4LmRgtCWI9nRYJ2liCGSrIPtCvjKkIsdR6kMuFm7Ue?=
 =?us-ascii?Q?9aOhEwP9p5Jf76Oxt7v//7tJBNvzsr0DFP0FfG7AC4Mt42Z6BBO0f+rf4wDP?=
 =?us-ascii?Q?huN90FT1Z/OwbN0EiNX9v286L7GwFOm+tU7AujzPl/piPLFPHVON88fcnf7V?=
 =?us-ascii?Q?mYwCyZRVZbRGe0Ba2eVdHhZsO7eJRxGiYsxN8EtKpPuhGvQOJSQrDH1kN+uP?=
 =?us-ascii?Q?2ckBgUdk123H9qPqBUhyMbaDwGMzyxRChOkH4ysQhlth7cujjrz4a6/7A8Fp?=
 =?us-ascii?Q?xwpXAA1nH288SKftv1R7DI/n2cCTQQbCBD97ll/0elSGa+fCJUYQ1J4hVm5i?=
 =?us-ascii?Q?I/JH6/eqBHD+7oQuOH5w3v/SocfthkFMcnG6o0mVVL3HaKQpvzR9FN7Y4Yj5?=
 =?us-ascii?Q?1P73PMkZHhORbuRgHwNfIug9ImO66Tg9fpb0pN/a5xJoDBNLcibquHEIzkPZ?=
 =?us-ascii?Q?bnVA5OtD7qA+otf63Wkuyg3r38OT596GvkeY5ZEp7f0/gnNuC0AO4vc6W1sk?=
 =?us-ascii?Q?uZ6ho1079ZFRV/I5/PpxBu1CmFPvuI+LcipbUBtPcPQwjVv8fFNTZ6dYW5Rv?=
 =?us-ascii?Q?FhVu2RWk5dS2giaCjk5feQQDuqyqy6m1h4D+TkCPy4Gd6wkpptuUnsiP/L2O?=
 =?us-ascii?Q?Qp/CRIe25zPuIHks9x+vKdUprSHXP+fynLf8K2ZcTsSWkh9T4AtfVYpHAkQm?=
 =?us-ascii?Q?r5aG+LSKlWqkKOejkgKCyqqPMbM1M4BoE6Ji0wjmKFsVh8IVm69DWaWxVB2J?=
 =?us-ascii?Q?XO3SB+n0YyFB2Tq43uflExWooMMHoV7rnRqtc2WwLcX+VzaZm0f+OSZ0jTdW?=
 =?us-ascii?Q?r4NkAzWY8Ab664lAQ015fRvMc85Eb9zoqjCi8H7TzXWceLFNxr4xjRw2Cb2f?=
 =?us-ascii?Q?4Z28sX/edgN9iO6WXo5IlX/4YvsykCnXxEmpK8ZTxbsEGMepgavQcAbITcOn?=
 =?us-ascii?Q?a63MZ6VQPDkk6I2RqvUYZJgyJOChG6KloHFzU2C1h3Eyak8WiciNEBX4sYY4?=
 =?us-ascii?Q?eYMWJOBgImnjigdaaZpJFoqW+ET0rrbqlKVph94n8xcWak3Tq6YfeImLv24Y?=
 =?us-ascii?Q?s0GIlVDlIA1prUvVe/S7E94+ov4sXJ06Lz3IaMxTUqNZ6FN5rAvU/VC6SSpQ?=
 =?us-ascii?Q?lfTLi40dw8KPZiSIxvCSY+E+hvpzhZVb7CilVL+XSNC6HdS6nGlHvppex4T5?=
 =?us-ascii?Q?8rRWTRW9AsnKrBPvfEpBq5iCdBuH9zbVJoNkEuLn7rkU/XSP8r2o+0PGjDQx?=
 =?us-ascii?Q?+Mwuwueav8JqqoG7wCefWxJVZb3Yz5xMZiHtvz1TiEIz17S3UkAEG54TmpJF?=
 =?us-ascii?Q?GB3sxOwtjpWLldwaNV4t+vVhXIP39VrsB4OYzsEuMANOfjerUFQ98oLacN3N?=
 =?us-ascii?Q?Y7KyzTFh3hEJb8Jwo8ePEbtV92PuCZZl4FGRdIkPLVB3iVo+pKaZjjTQF9IR?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4914573d-e307-4b75-fa85-08db6c546ef8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 21:23:30.1355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDu/oVc+0f9J0CDTHr9CBcB/C6Zuc1q/ZV3OajMc64aW5gx1jAuz3oW4qwwcBHRuHQ2XBNg7msKGQ9VmehQNd3GPrgM8iHmmhE/A2naM4dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5238
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Sun, 04 Jun 2023 16:32:10 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > In preparation for device-memory region creation, arrange for decoders
> > of CXL_DEVTYPE_DEVMEM memdevs to default to CXL_DECODER_DEVMEM for their
> > target type.
> 
> Why?  CXL_DEVTYPE_DEVMEM might just be a non CLASS code compliant HDM-H
> only device.  I'd want those drivers to always set this explicitly.

As it stands /sys/bus/cxl/devices/decoderX.Y/target_type is read-only.
For non-class-code compliant HDM-H device, or even a device that
supports mixed HDM-H + HDM-DB operation depending on the decoder, there
would need to be some mechanism to communicate that at decoder
instantiation time.

So the default derived from CXL_DEVTYPE_* is indeed an arbitrary
placeholder until a use case for more precision comes along. In that
case I think target_type becomes writable, and "none" becomes a valid
return value.

> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/hdm.c |   14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index de8a3fb28331..ca3b99c6eacf 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -856,12 +856,22 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >  		}
> >  		port->commit_end = cxld->id;
> >  	} else {
> > -		/* unless / until type-2 drivers arrive, assume type-3 */
> >  		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0) {
> >  			ctrl |= CXL_HDM_DECODER0_CTRL_TYPE;
> >  			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
> 
> This is setting it to be HOSTMEM if it was previously DEVMEM and that
> makes it inconsistent with the state cached below.

Oh, definite oversight.

> Not sure why it was conditional in the first place - writing to existing value
> should have been safe and would be less code...

Agree, that's busted, will fix.

> 
> >  		}
> > -		cxld->target_type = CXL_DECODER_HOSTMEM;
> > +		if (cxled) {
> > +			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +			struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +
> > +			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
> > +				cxld->target_type = CXL_DECODER_HOSTMEM;
> > +			else
> > +				cxld->target_type = CXL_DECODER_DEVMEM;
> > +		} else {
> > +			/* To be overridden by region type at commit time */
> > +			cxld->target_type = CXL_DECODER_HOSTMEM;
> > +		}
> >  	}
> >  	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> >  			  &cxld->interleave_ways);
> > 
> 


