Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912F4C25B06
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Aug 2022 20:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiHDU6X (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiHDU6W (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 4 Aug 2022 16:58:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268222A253
        for <linux-cxl@vger.kernel.org>; Thu,  4 Aug 2022 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659646701; x=1691182701;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=njeN3LSycRcjmVgMDJkY9lydr/eviPOse5dg5TwlRvQ=;
  b=MhwzvQUFBfgQMqlIXR5+yirMEvyzbUYlY/0nTT7rcTBHXEbZRIAf34of
   mpUKH59ChDSGHynznThNhqhQcIfsz+cSDYNWpVOVLmtQpserR7e9UshzY
   WMS0LNCav9BMVTYs10nnsXeDGvgL8s8CvC3C8fJYzdK+NojaDkdhFYatP
   6Wmj6C2Yv/ZIK1NVNAW7yfjDT7aiVq9OUhQAgEwmsRCGQH8t26cBG915E
   uVZi+XaAn0QmQR/PIgSDCklPK3bKuXzVp9sKsMqK2WsORXSs1wKPLXxdV
   OPMMOA3HbwjApK6bJ7HqBuQbpzW+VAhMOKqTs48BdBbJaRkoMvM//g6c2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="376340987"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="376340987"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 13:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="579228831"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga006.jf.intel.com with ESMTP; 04 Aug 2022 13:58:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 13:58:20 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 13:58:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 13:58:19 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 4 Aug 2022 13:58:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U24AdLaYKobQ16oLVoQI/4mxHuBwu1v3K/h3dMlE1HgzBle6cd7oEccSAYQHsGBLbAFiPreVy9g0yvpQKjM4xtCU+9amFb0d+nUW6YN/j2cSyGhzddXA74hkd4KwJLBVwgDHXSgyhzIKQns+1c/fqbyLYOLkRklZ6LZq+dHUqTCQzNgMgkb2CcCNtbuP/cB0OEDUwA+uqtr3DlTMu6Eteq7cW2+M6+8/m7ihpTESNQdsv+A8pBnH1yyXvBH9s+5Rl6uEsG70Z6wNxtemuUDZsGyX90pfkaZNpzI6X/YjsIULeALJPoUhmfLIOZXBS1bz6HpRnqH3UUkFZJwrSotKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzpj6YqLpLcd9LC/+kdJ89MN+pc9HlhXglPJ+nwI0Vg=;
 b=m0j8RiITYt+xF7oQTYuR/wAN3t3Em63fndqDmjyYBJJltEGwfD20zcl9bKPAkK+XODJkwnOLsx83XpSWUDPgQCxjJtl8vArh+PrN/LG0eE1KhskbhlE31Kv2vk5BSZ0+qg/bgZ0MevvwfFkMt+H0ObJfGn/ZH88kP7FZyq1Y5VptHeclI9q0+ZrgFYdvSd7ImKI0kEj8f7PSRMcHrhTmh6shX7ih4GBgpP8ee4zdl/loZdTmgHNgNjOFvT+F3IwssT/wBbP82RfIfSQNJgk49W6L8ZC3uQwnQS9AzQnmvb4z/WJ04hEfK0RFQyVG+dsv5RNpZiGGIKGYV8A3DWFy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR11MB1892.namprd11.prod.outlook.com
 (2603:10b6:404:105::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 20:58:11 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 20:58:11 +0000
Date:   Thu, 4 Aug 2022 13:58:09 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH] cxl/region: Fix region reference target accounting
Message-ID: <62ec32e135711_8814829444@dwillia2-xfh.jf.intel.com.notmuch>
References: <165939482134.252363.1915691883146696327.stgit@dwillia2-xfh.jf.intel.com>
 <Yuwt3NRrUHHTTydv@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yuwt3NRrUHHTTydv@iweiny-desk3>
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7e47d27-eece-4d7e-dfcd-08da765c0a8c
X-MS-TrafficTypeDiagnostic: BN6PR11MB1892:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHLGDgNE/4TnMaEOXcZuFfAsAeO/JmOIitr7wYrMmiZ1rQcPCpw7IL9JaWw0oZHZeLvoW3KObmqfwql3exIQnHoWCAPiveBCdqn8n+CizjW7dCjZoReROyG9+LesTRQDaWUbhBtB4LxbgZXg1NGIztzu3deOnKXdnIkQN+1Vo/NRvzD3gP53uR2lU3DHZQ4dlpoSRuRdQjbk3sKieBe+n0BARro3Y5ecG0sUg2KH7HTACZwQLq0v37hMc0JQgjmfMzQgi6hciTTsUwMwXJgybuxC+eOfC+Vtsvf7tAyRJlQNONzVI31USCvOr0qmpLEvxlVyq3UZaOB6eTFUKDW54IvrIofF0LM00y2VCD7XGsMySEKsZMdvvEedAfSDGPu2Epa8ZQfmWl6GYG/FgjpL7BWF2vqMgo5XpoTqexOCPyB2Fr+zhSoozA6l12DvlfWLPnw/z6RsW1vnUVDfrL9ViDOeABLmTrGOrHOoYMm+kDucjSSHR52Tcv2jGw40YpfiKbTclaaoTjIxF6y2NFEvk+QWlFS8HokWa7YdnDUSuT84w5D61AdcXf9a1S4Z4xrQ4l40U0W1t6YlBWa3l9GT5TBTtPBNsj6qOHykf+L3mMgk3VVNPJN0QC9/F27BzVy1EdEZJb0I5tAMB4g9aVlHY6Gq2G2DklzYS+3avXVe1CEQ13Q9pH+o/gU8LBxEwbCU8HIl1iI13hVeiZZQ2jFbW2F7+SUvO+r38ghVJq78KVj+rwswy7Ynbja0egg1SahY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(396003)(39860400002)(66946007)(478600001)(66556008)(66476007)(8676002)(4326008)(8936002)(316002)(110136005)(5660300002)(6486002)(83380400001)(86362001)(6506007)(38100700002)(41300700001)(82960400001)(2906002)(186003)(107886003)(9686003)(6512007)(15650500001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i0yVM3mlc7z6Xjt+ad5LfAK09nPvGVdXdZKeNR+XtWNZlLDW4QJYN9LihGn8?=
 =?us-ascii?Q?EwH7egSAu75994eVMmk+3lvvfdse6QppDsEXAqyHURTaKqCIY8xSdj5foF1j?=
 =?us-ascii?Q?KCVtaqdVk9BfokQJPhjvEf/cbitzE9z8SEKauxDjFLrJkaV6GG9fsCQ5r6YL?=
 =?us-ascii?Q?bLw/u0RCe9J/XzB9qC/iw6Frzn8TY2WbwhWJy+boAw8R1TV7Rxpjm2qu2dl4?=
 =?us-ascii?Q?A/syNIfroe9cQxs+0NTRW+Im7iCONeEvTlN8Msg9aQ6qf5NW+KpFWI+kHC2t?=
 =?us-ascii?Q?ilXnG3Wh1HUS2ASDFSbwvMBECEB6f3UoVW+gNtL5ojxurw1JPcb46KcTo+ye?=
 =?us-ascii?Q?6FRv5ur1EObmHMbH3nvpgmwhdPxOAqMhr38qi3vn41EqIQiRjzB8Q36vZ35O?=
 =?us-ascii?Q?YHLvpJIiNmhlFJNBjUlqNgAQf4Xg16kvNCDNRfNdC81/zTuuFP8Qnwo2kNng?=
 =?us-ascii?Q?0yk4nxyhgRJSY0GsqymFYqeZu7RptFh7InVolbFIcT+DMg+ZkneN4cxQ4BXj?=
 =?us-ascii?Q?fsa8okypgcjZrcPNfXOpAMJELxyEZoodsPCN0RprpnoVAjL93q3mDYuAA+PU?=
 =?us-ascii?Q?wWH02P6PNiF0BbaEEbFWcK/kCh2Dm/NY8FDG4ptg/qSxKhS+HXEwT2j43r6w?=
 =?us-ascii?Q?juNyrOdaSiE7ZzAptE9hpnbuUSP5RUZZYEffc+xzI+23OY4ULtniWBY+sWTq?=
 =?us-ascii?Q?b4XXYTmbE+vrdzFNKQkwX3cMm/NWXZCQZFIncq6HyAOmJ3tCLQ01MOLb3H8s?=
 =?us-ascii?Q?3fSq3p50SgNdyUMOsJf8mGOxqhaHZCoDEjlVtylY2255nKoH8aOT8N8U5RI/?=
 =?us-ascii?Q?VidVyTsxVeIw6CcARMhU7pxvPM0EARZfFtmpbU9XMXKxHgWg0Ackg0tiIwcO?=
 =?us-ascii?Q?UbTZ3m2jjH3Lm6dpvvlUkMQjsErkFurqMucHrfsdSc5GtrTnkyQox8RO3Tou?=
 =?us-ascii?Q?jrhrqLxt6PIVmAi/Cd8J55H9R1Ua+fbTD5kYgBDxVxLj7Tv8ngPWC+atIhW1?=
 =?us-ascii?Q?SgQ2LrkmoaAPO3yNgfvaE7XySxpZA24ypTi1TBMYN/GceyehYqHwHFgt8KgL?=
 =?us-ascii?Q?LclxOjno8zVLIULA/jD/tRJKUjDvv1vjigp+9pmufCtQ0RcWV3xI8KKXKEI2?=
 =?us-ascii?Q?vR19HXF9cSD0NoGkDn1xpeGPW8qVzSMAWvv3cW5mwmovzA2MasFKNjyZoC7E?=
 =?us-ascii?Q?77BW1mn8x16I00xHBH1tWP+ss6wfz/y0zXkWmiIjB9gXryeynrbjIVi8qxgm?=
 =?us-ascii?Q?4kxEW/N+ODMgx89Ntvkqpz62ROKp/xmxw/2bzK+ufIlpRgh0ET3Z1j0+sxn2?=
 =?us-ascii?Q?sUwSxbAmZJE4rkPnFSeVwBHp1GPl78UQAZEZtaZ2xwu9WExlecRZw98HohMm?=
 =?us-ascii?Q?gL6KrGmh2u5YUSrLGPUM40c6cJRXJWrXC7FCtWanjqufRzBASsLMAk4sOD6/?=
 =?us-ascii?Q?uP//xvvEqQSnBuyZO+rGW64rm5jEKM82X+a3KBwukUV5ILT07+QGVhzOCg0P?=
 =?us-ascii?Q?2ovQhnxqk6nVEHw8mdbuMMtDDLBaBQAyuiZQUovPT75/Y80TPIdcgcXNtA/b?=
 =?us-ascii?Q?3V0i0hfO+8wZubkponVxt1B30Wod3HgI2xBG/JgsOh7fb+lK+Cl6P7DQVB33?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e47d27-eece-4d7e-dfcd-08da765c0a8c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 20:58:11.3669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKURhb7mIlTf+/bR3WAJVflHbcxa05528b6rwh86k25yZ/pLs/fImoUU1YzVaZ5q4EOFkoFSLYnDP7p2tU8VzgA+gjS16aZCbMAC+UrhVs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1892
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ira Weiny wrote:
> On Mon, Aug 01, 2022 at 04:00:21PM -0700, Dan Williams wrote:
> > Dan reports:
> > 
> >     The error handling in cxl_port_attach_region() looks like it might
> >     have a similar bug.  The cxl_rr->nr_targets++; might want a --.
> > 
> >     That function is more complicated.
> > 
> > Indeed cxl_rr->nr_targets leaks when cxl_rr_ep_add() fails, but that
> > flow is not clear. Fix the bug and the clarity by separating the 'new'
>                                          ^^^^^^^
>                                          clarify?

It's a code 'clarity' fix.

> 
> > region-reference case from the 'extend' region-reference case. This also
> > moves the host-physical-address (HPA) validation, that the HPA of a new
> > region being accounted to the port is greater than the HPA of all other
> > regions associated with the port, to alloc_region_ref().
> 
> Technically this means the kdoc 'steps list' is out of order a bit.  :-(
> 
> But I like that this is only done on creation.  And I'm not sure it matter much
> because 'steps' is more of a list of things this function does.

Yeah, the steps are not compiled.

> 
> > 
> > Introduce @nr_targets_inc to track when the error exit path needs to
> > clean up cxl_rr->nr_targets.
> > 
> > Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/region.c |   71 +++++++++++++++++++++++++++------------------
> >  1 file changed, 43 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index aff4f736b63c..cf5d5811fe4c 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -709,12 +709,26 @@ static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
> >  static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
> >  					       struct cxl_region *cxlr)
> >  {
> > -	struct cxl_region_ref *cxl_rr;
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	struct cxl_region_ref *cxl_rr, *iter;
> > +	unsigned long index;
> >  	int rc;
> >  
> > +	xa_for_each(&port->regions, index, iter) {
> > +		struct cxl_region_params *ip = &iter->region->params;
> > +
> > +		if (ip->res->start > p->res->start) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s: HPA order violation %s:%pr vs %pr\n",
> > +				dev_name(&port->dev),
> > +				dev_name(&iter->region->dev), ip->res, p->res);
> > +			return ERR_PTR(-EBUSY);
> > +		}
> > +	}
> > +
> >  	cxl_rr = kzalloc(sizeof(*cxl_rr), GFP_KERNEL);
> >  	if (!cxl_rr)
> > -		return NULL;
> > +		return ERR_PTR(-ENOMEM);
> >  	cxl_rr->port = port;
> >  	cxl_rr->region = cxlr;
> >  	cxl_rr->nr_targets = 1;
> > @@ -726,7 +740,7 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
> >  			"%s: failed to track region reference: %d\n",
> >  			dev_name(&port->dev), rc);
> >  		kfree(cxl_rr);
> > -		return NULL;
> > +		return ERR_PTR(rc);
> >  	}
> >  
> >  	return cxl_rr;
> > @@ -801,33 +815,25 @@ static int cxl_port_attach_region(struct cxl_port *port,
> >  {
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> >  	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> > -	struct cxl_region_ref *cxl_rr = NULL, *iter;
> > -	struct cxl_region_params *p = &cxlr->params;
> > -	struct cxl_decoder *cxld = NULL;
> > +	struct cxl_region_ref *cxl_rr;
> > +	bool nr_targets_inc = false;
> > +	struct cxl_decoder *cxld;
> >  	unsigned long index;
> >  	int rc = -EBUSY;
> >  
> >  	lockdep_assert_held_write(&cxl_region_rwsem);
> >  
> > -	xa_for_each(&port->regions, index, iter) {
> > -		struct cxl_region_params *ip = &iter->region->params;
> > -
> > -		if (iter->region == cxlr)
> > -			cxl_rr = iter;
> > -		if (ip->res->start > p->res->start) {
> > -			dev_dbg(&cxlr->dev,
> > -				"%s: HPA order violation %s:%pr vs %pr\n",
> > -				dev_name(&port->dev),
> > -				dev_name(&iter->region->dev), ip->res, p->res);
> > -			return -EBUSY;
> > -		}
> > -	}
> > -
> > +	cxl_rr = cxl_rr_load(port, cxlr);
> >  	if (cxl_rr) {
> >  		struct cxl_ep *ep_iter;
> >  		int found = 0;
> >  
> > -		cxld = cxl_rr->decoder;
> > +		/*
> > +		 * Walk the existing endpoints that have been attached to
> > +		 * @cxlr at @port and see if they share the same 'next' port
> > +		 * in the downstream direction. I.e. endpoints that share common
> > +		 * upstream switch.
> > +		 */
> >  		xa_for_each(&cxl_rr->endpoints, index, ep_iter) {
> >  			if (ep_iter == ep)
> >  				continue;
> > @@ -838,22 +844,29 @@ static int cxl_port_attach_region(struct cxl_port *port,
> >  		}
> >  
> >  		/*
> > -		 * If this is a new target or if this port is direct connected
> > -		 * to this endpoint then add to the target count.
> > +		 * New target port, or @port is an endpoint port that always
> > +		 * accounts its own local decode as a target.
> >  		 */
> > -		if (!found || !ep->next)
> > +		if (!found || !ep->next) {
> >  			cxl_rr->nr_targets++;
> > +			nr_targets_inc = true;
> > +		}
> > +
> > +		/*
> > +		 * The decoder for @cxlr was allocated when the region was first
> > +		 * attached to @port.
> > +		 */
> > +		cxld = cxl_rr->decoder;
> >  	} else {
> >  		cxl_rr = alloc_region_ref(port, cxlr);
> > -		if (!cxl_rr) {
> > +		if (IS_ERR(cxl_rr)) {
> >  			dev_dbg(&cxlr->dev,
> >  				"%s: failed to allocate region reference\n",
> >  				dev_name(&port->dev));
> > -			return -ENOMEM;
> > +			return PTR_ERR(cxl_rr);
> >  		}
> > -	}
> > +		nr_targets_inc = true;
> 
> I don't think this is technically needed but I would leave it if I were you.
> 
> I think the leak only occurs on the extend case but I think it is safe to do
> this and does make the code cleaner.

Appreciate the detailed look. You're right that it's ultimately
pointless to do the tracking in this case because the cxl_rr instance
will be freed shortly. For the casual reader though it saves them a trip
to go read the details to convice themselves there's no leak.

> Regardless of the kdoc subtlety and with the spelling fix.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Thanks!
