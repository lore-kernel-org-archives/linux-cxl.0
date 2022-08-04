Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0918C25B06
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Aug 2022 20:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiHDUeU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiHDUeS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 4 Aug 2022 16:34:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161D44BD06
        for <linux-cxl@vger.kernel.org>; Thu,  4 Aug 2022 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659645258; x=1691181258;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Mfhv+cudgH43QvHy4juR/0e4Vsh6Bf41EHw6EvQdrV4=;
  b=GpVKO0jGrXn/sVsNNZAxvHt+TJtXb3NF7NFW7aAu7Z2yHfn6hFwx9lnC
   oKK1B/9NSBjlU/RcQOBh3oC7DKHXghfj3R6QtgqCwvX027D/jxaW3XGS1
   l3hTcpVJ50XvYfL5jBF9aFo568hZBwxd8tNu5YvrWdfBUdZKBgGqR1JvK
   3IA4Nyks4uJDyKjQ6ozuACW9hLsCoYQIyVsNv+bPTHu5AXThVM4teBPXv
   ksOA+JBccfP9TEz5QZHWaF+TabIGSBYBvKZ2iaisMcQFRE59RssB5w9QF
   +XzGnshpWsCmN8FSV5xDlG1qG3OS9D/FPHj4EaQwF6UoGqOvK+486m+w2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="376336798"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="376336798"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 13:34:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="706341137"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2022 13:34:17 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 13:34:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 13:34:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 4 Aug 2022 13:34:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeUCb3d30UUq+kdv5OcUcqXUZpdYzA9wQPk+d6tEDc5/Ly366WX2GvxHd+I0HU++kFb+iy2CoH8SBiFiy7PeznPp4w9wdDtKP7PECEjWZ95AVNa1t2oW26vpiCvpz9B750rRaULO2EnUrrRI9nBwF9Cr4r+D+UXSdDrM+Aq/dh9tFmo6GDqSLpwzkcOb+nPTpLQC1BIU2pUWkFuIHhWq5j+cfWs/f0BLvCHtQi0BdnOElABl3NHVFdjt6vSbkp7Q6REIO9A9Dp1EDtaFNfvdX7OFPXR4N00xKe0OQe2nPFn1m85x3ZK5BAQuyNvMXPIw/mlk4tNd1vnLTmNQcRr5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q492q5EjbmgThQwBFWe9GqXe0VhVZr77vzOCHKqIvV8=;
 b=gYN4S+d1+CwuI/ITdiDPq5njtZeYKI2qDDwu6eUmQyQPLlpZsxLTh9M8pMIzF+kwdJNe84lXpLa2u6gckmOr3NXiQhU8bbSKNlWWheLkR/9tco8UqQHBzGJ2EPp2q5XVDlQtwgibKGefu7im8tlEQhb2FWYJjjPD98hfkXWo71aK2OEexY8LGA75X6zjnj4fooKEoddziR3F8WRDws7TPOJPKdo1yKELVcJF1XsGDPQNny2v/jDc7t5dU5MT0GjYOLh7b3Jet5Oip2JNSOf1G7wa8PjEY6Lu9aUyDA++tUGzJ0HS3z5UMIfxgCz1X1s+z1BSWRJVj3VQqIQbOMLjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB3712.namprd11.prod.outlook.com
 (2603:10b6:208:f6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 4 Aug
 2022 20:33:59 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 20:33:59 +0000
Date:   Thu, 4 Aug 2022 13:33:57 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dave.jiang@intel.com>
Subject: Re: [PATCH 4/4] cxl/region: Fix region commit uninitialized variable
 warning
Message-ID: <62ec2d353338c_8814829453@dwillia2-xfh.jf.intel.com.notmuch>
References: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
 <165951148105.967013.14191992449932268431.stgit@dwillia2-xfh.jf.intel.com>
 <YurtcUKKDFUbjJp4@iweiny-desk3>
 <Yurxs8Fy0UXgspPo@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yurxs8Fy0UXgspPo@iweiny-desk3>
X-ClientProxiedBy: SJ0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85a294a8-c99e-4e17-877f-08da7658a919
X-MS-TrafficTypeDiagnostic: MN2PR11MB3712:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uB6l41sx2CEkXFlTE7s2SSbUJ0gIzu9AQ7lsYe3GZRM5S3UgzrA2TdZW4gECuR5/atfl32N6JRbVyEtr+YQ6A9os+4C9Sx0Dhsa+YGfn0lmo6nGsISc6WIoEGvSqwQuWtbW2GmKgweqS+JF+Lv8pH6FkDjZDpcWA1A/pMF/dZRxEvywaC5phCFrWy+ZMnIdSjXrBd3wPZOA+e3DcoGrkHQAiOmEg9Pyh29wyJAy848EZp36bP1iGvjS1y6m0O+V/hz6Rmjiqw/yoDZW9aAar4FnY81ycz23TWWycHBD4qW2OZTEDShIbY9hiuoqLSIN73pxRP4xCxwkv2VOtwc/WnxhQ9gsvddjQ43VpyhPRSTD8lxvD5nocbCmYWvI6Yq8FebtzLpjTcUIHdpjVN4QZ1AG9MdsALRt5hdH3drihJJPd2BgmJ/LLJw30clCmaH2rj76N2oFoki+Q8cpYAFk3ra4MGnpai7Qf3zI8yceGUjhgCSx6yFNVj7c90iFyJvpB47+48g4Cg9QWeW+119lMPVztSn2s0PO0KX6nWDDUA47gO1jDoFQ1szAMbn+v+qDQJwW7E7qoDCnkx8ARpXOclU4sHt5A5vNJs+aMtMOfolxda7ywb0i3X6rJJtA1jcOtuRxG2o/5yD43Qy6bk02fAv0kD8i8kVlYUOCfRdiakUOoEBQz9OhWVDK62s7qQm3zS7wvijMSSVLLnAhjavJTtfKCfY/sijacBzBI6XUhFZK+zppugE/D3UA+4bS1IoeY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(39860400002)(346002)(376002)(6506007)(2906002)(82960400001)(107886003)(110136005)(26005)(316002)(6512007)(9686003)(38100700002)(86362001)(8936002)(5660300002)(66946007)(66556008)(41300700001)(66476007)(4326008)(8676002)(186003)(83380400001)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FD7y0t6Ox+Amar7by4a3EYeBf9AauF8ZsrFH6PWC/CGAMe2RHsVKqMYL76Zn?=
 =?us-ascii?Q?ydIa8KSTYrWXMyr3A61aFLQt0DkG00HC4j56Oak4cbvn2b1PaD8BAIj2ZjfF?=
 =?us-ascii?Q?HTimXZ860ybAY21gv9T7HaNlyIfpnYNIuS8XOL4fZf9Xz3ZEBU5KtddnIIpn?=
 =?us-ascii?Q?me0VI5bx1Qds5b+d0X2PlqJtPwfvhMF2klNRPPXX1+HlCdMGIUYV19PkpLAo?=
 =?us-ascii?Q?AIqgoXO82tiQxOpIpNW8nQhl2Ycy8XRyyhjm9agAYibZyejIjqZh7qhwjM4Z?=
 =?us-ascii?Q?qGcabnA761qbVVx7DcuFytR8OPEJyd/4SknS6UTIo+qldhA87+fDOXBtUAJ8?=
 =?us-ascii?Q?DecnnmsmsDVSVWAHJN7SosocATj4R0JFgkcUYO4aw1TMTuGFUzT5q/Cx5wqN?=
 =?us-ascii?Q?Nu/CtZlqGwPTUlKtmJY3QfKGfCcDodex0vAluK/aMjkoVXDuxpi5xqKIXDij?=
 =?us-ascii?Q?PhPKRRaJzXwwlxdamxxzccocWFq92vILw1gMGB4Pnaj06sMoVcBvLPBlI1DV?=
 =?us-ascii?Q?m3PSVRhgoeG0YRu0/NBBOSCVW31xTH2/lF/a/M7uvaeMd6C018JnLkrCf2Aj?=
 =?us-ascii?Q?XfcBGJdVmCtd3mA8lcOBGhby1QUDlvKp5I56XbamxJYp8G9E9HH0OQY0S85E?=
 =?us-ascii?Q?q6WLfKPlcQ3A7mGq/UU+nnxi5zGhp39/40sT0dS9TA/sjDrIfjCTm6azgc+q?=
 =?us-ascii?Q?glVR8iSgJXQHo0mumIlGl4i3WKZbkZ6ctgnt9M8twAe6rznAAh4V22OBrDwV?=
 =?us-ascii?Q?u1U6r7EPDDikhQG9TcjIoIGHqIFYDNrdy7A2V1aSWgZJm+qfcV89C3mmp76M?=
 =?us-ascii?Q?zNY3MH3Gn6myNoUgaJy2jDje3NAFFdK0uGlH8DYlGdCC7tzktM5g9YsNhbmU?=
 =?us-ascii?Q?yPmavs20X1qdsBLf4puH1qOr+y157XUgOOLdLOFEykSbfPFmAYNAdfXgWqW+?=
 =?us-ascii?Q?M7tMl9bpAjFwIVF7U6Z5eFg2T004COMngFrvgH1mRvp6lHrxA/dp6sugqVhE?=
 =?us-ascii?Q?+BwCtGtl2UnkhFHtSmztYM4vdiNvqH2Jngjv0tFZvzWn4y4mjRUfoSZIegap?=
 =?us-ascii?Q?sGKtFgaPY7c4oqAbLkCztMoMYqHWgXMzWkYl6Yj8f6SwKrJENGQjsPwIiCq1?=
 =?us-ascii?Q?fhos2A2z/y0iM7MyGWfw8fGJ5gUju+kOMMePyl4dwn3B/IU7W4r3PVH9NN1w?=
 =?us-ascii?Q?OqAEzFU6c25kPoermRXXpA94RuFHQBqpPGa/AczzhCZnfisR1MfIzRZYDRKB?=
 =?us-ascii?Q?J78rmuxZHXTkyDSG085ixhMxIcKORQWECApB4l76HsshLCSkd4rlOdZ9drLh?=
 =?us-ascii?Q?7PSDBlrWj8712HjK/fvGwx6xYzAfcpX1fCsgfDzDAY0pn/0GwSUh6I1TU631?=
 =?us-ascii?Q?GTL7N8hxJs6vou2XIK51/6tUPdQ6WxqBMgkWTzkVZDpPoW9yQohDLzZq76dl?=
 =?us-ascii?Q?YSyUpWkLplZ2qU1BGpkcBf+NEiyKr2bpaiwn8KRBJL3405x7YDOneoTpZ+/H?=
 =?us-ascii?Q?XnBV1YLUIZC8qd2l/Jyguokg4U22evTnJUlmMDzYFgP5Z1mqKBwkd1vJCm90?=
 =?us-ascii?Q?aytjPCWBXmR12NSA1Y68gKkormL33JUGYNhyGEoQ/8k9reg7d3oE4X1TRd83?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a294a8-c99e-4e17-877f-08da7658a919
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 20:33:59.4287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbJiyVQw+8yGvFVcKmqVDdcl8WiXPQX/WrzCJ/3i1+nVHPfoPl/AHgqAT4j9o0fK3Wuv3hwukufd7tglKDJWRDAv7EjuUJzPreLTjubzyCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3712
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ira Weiny wrote:
> On Wed, Aug 03, 2022 at 02:49:37PM -0700, Ira wrote:
> > On Wed, Aug 03, 2022 at 12:24:41AM -0700, Dan Williams wrote:
> > > 0day robot reports:
> > > 
> > > drivers/cxl/core/region.c:196 cxl_region_decode_commit() error: uninitialized symbol 'rc'.
> > > 
> > > The re-checking of loop termination conditions to determine "success"
> > > makes it hard to see that @rc is initialized in all cases. Remove those
> > > to make it explicit that @rc reflects a commit error and that the rest
> > > of logic is concerned with unwinding committed decoders.
> > > 
> > > Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  drivers/cxl/core/region.c |   12 +++++-------
> > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 5c931b6eb4e7..a68e4e0cf169 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -159,7 +159,7 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
> > >  static int cxl_region_decode_commit(struct cxl_region *cxlr)
> > >  {
> > >  	struct cxl_region_params *p = &cxlr->params;
> > > -	int i, rc;
> > > +	int i, rc = 0;
> > >  
> > >  	for (i = 0; i < p->nr_targets; i++) {
> > >  		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > > @@ -180,7 +180,7 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
> > >  		}
> > >  
> > >  		/* success, all decoders up to the root are programmed */
> > > -		if (is_cxl_root(iter))
> > > +		if (rc == 0)
> > >  			continue;
> > >  
> > >  		/* programming @iter failed, teardown */
> > > @@ -192,14 +192,12 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
> > >  		}
> > >  
> > >  		cxled->cxld.reset(&cxled->cxld);
> > > -		if (i == 0)
> > > -			return rc;
> > > -		break;
> > > +		goto err;
> > >  	}
> > >  
> > > -	if (i >= p->nr_targets)
> > > -		return 0;
> > > +	return 0;
> > >  
> > > +err:
> > >  	/* undo the targets that were successfully committed */
> > >  	cxl_region_decode_reset(cxlr, i);
> > 
> > Doesn't this take care of teardown now?  Does the for loop even need to do
> > teardown now?
> 
> Never mind I think I see how this logic is the same.

Ah cool, disregard my last reply.

> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Thanks!
