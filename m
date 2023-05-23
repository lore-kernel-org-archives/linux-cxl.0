Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC14AC7EE23
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 14:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjEWOSf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 10:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjEWOSb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 10:18:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172B0C4
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 07:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684851510; x=1716387510;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=56wdjb0bhIlMFeFV/PfUyEL0Z4M391VQM8UyOF8iito=;
  b=mGONnscWsEnBGXnAjsj15lmUz6zWQSzE3b2DVrtzwO6NY8fFCxP7nGeo
   7tJDXt8Frq4USpxAHsegRBTRFBtj2XBPeDsWjJlLPPP4OHLFnx12q9vne
   n3Gq338VO8qgPzy7wfUugMWnfxLxG0ASHCuIRsTAB0dXmrONf+ycYIYMl
   WCpdteF7MXjVuoEnq3VjpimZ7YhxyYn5EEKnp+Cg7C3Z99rjnQukVTAoO
   US9k/oZS3+fVJG3reQ0g7S4o3tVD/wArjxZwCV6ds1rCpCcQSTHxd5Z3n
   mXYnejgIhJKp5uOGEyyYYuMlHKOUyUbTwubqT1zG1HQsfEDIeLNLw1umL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="332862806"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="332862806"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 07:18:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="698072310"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="698072310"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 23 May 2023 07:18:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 07:18:29 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 07:18:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 07:18:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 07:18:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fpkt752+/Pfkx5mo/sLfxMKE8+h6gAS19iOrxRP0o2Wvs9KHRGp4si9AdiJnTMGiS+brBM8wJmSJCfgodlykqV9RHhNOIPnid/Zh7g4gUwvAL3D5Y5/FwkouPrDU2+mR730q+lcCLZY55xG9WYGCVoBhtfdLxltU+zttgdMB5mus+hzxaZvqq14j2DpRNzAZeQWs8XULXRjwAVXhJ8zOfvviTbWxXf28mOqs4FehEsz+tArPTfqGJ3Yk9+ESpXp0ZkZQEUxC5Urj/Vfbz22uN9ulsIq55/abfopPNHspgyJn4MiUfkDC1Qc6e3GhvwdNwNJrQJILDqvHglqY3WH1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6bNv4MG2xCw5JcaMOJTVp1ogechQHUE6O+9Qac3U+A=;
 b=Ha3e89B+0MVAvHuke4gxFLH+j80LJIKaQOWgfy/3alBKfI29qZmB3dTf7n2VFDxhl7HsT26Drq6VAby6RfOFBS1OroO0wl6WOX4c2xDy12JiP5afxgzXo7gG0RqxW2h/kF9YLfQCj6tftNCHJ5VGuRimzvtLZKQ6LqLJjr1xo0AMVE9t5f5vpFPsxrE/lAdAsBS03nEHBqiBb9sa2YHeH0EgoAi5KwwuYCx5PbovIi9KlLAk7qQJYS7lUUauxkFo9tsWMVXkuhQ8y3cmOSS+jxHxtdCypqk7Rm2jMz5ym8Ne2LAYeCikLpUNW9ILe7RAogpsDAnuIez4Gr8Gl0BsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5539.namprd11.prod.outlook.com (2603:10b6:610:d6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 14:18:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 14:18:25 +0000
Date:   Tue, 23 May 2023 07:18:21 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH RFC 1/5] hw/cxl: Use define for build bug detection
Message-ID: <646ccb2d82bee_165815294b@iweiny-mobl.notmuch>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
 <20230517-rfc-type2-dev-v1-1-6eb2e470981b@intel.com>
 <20230518105416.000054c9@Huawei.com>
 <64668840a067b_114f6029416@iweiny-mobl.notmuch>
 <20230519161448.00001983@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230519161448.00001983@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0197.namprd05.prod.outlook.com
 (2603:10b6:a03:330::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5539:EE_
X-MS-Office365-Filtering-Correlation-Id: 7978b05c-6cd1-4384-0324-08db5b989276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5oajMnYQ93defHsbPpjsfvZ3FTFG7xVxwceahINe4TvA9N0mZdJgSZefsvaOqhmzhu3nxVLj+5YPPYcyk+qx5LgP5+ly4bRQtnRif3vVQlLCDL46GeOzplSOt3JuIftfPwdmbvUxQWA4+jSU/HYFc03BxmVsdRLljgkYcInwub7aImhaW52ZHlmoZvGKq0BDpLA5g3Uuj6Ue8nLPLJIFhjWrGKB6bRfdtgmlt/Y3Cigv6XOsbQ3kirHmjg4ugfvOYXYUwGj3C1DFbO83bOF31485v7QHZCdZLv+ZKH0Xq0DOn0isou8xD20tSFcD+vh54k8TGuWMzxaukYGL5L+OzNxjLFoMljUGJkAuBSDTRkwcBZttQk74sT2XuzYb1M3Yi9W9NDckvUN703ad3vz3TNTOD0OPI4/OfoP3qgi7pABA+cvqJ5JpFjEyk63csB7tfr7iAHQ8Onis2vAoM6feYJwKlKKOKKOiNZPy+0G5JmcPRTcjwfknJJQpYE0hEl4pTp0PCXN6frkuR7M2jloKO8mZvyowZwRjK8B7T9twlPZxCECOoFysRn1h5WPZ6/W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(2906002)(5660300002)(44832011)(83380400001)(8676002)(8936002)(41300700001)(66476007)(4326008)(66556008)(316002)(110136005)(54906003)(6486002)(6666004)(66946007)(478600001)(9686003)(6506007)(86362001)(82960400001)(26005)(186003)(6512007)(107886003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a8BIgUp1PJTChvYA4QW5JZfeZSD0lz9eF7jOOGQswYylwX0NpArzwQHmnQ65?=
 =?us-ascii?Q?cnDI7U8lg09Wa67VocI+to965kVnXiyE3WWWuBulvhalqfOBwVEV9kOoqEfo?=
 =?us-ascii?Q?quMFn56OV0LroXWhMwztVmU+bKikpgOr9BwRi4TFqXwwiLHL9pctjyyuUk4D?=
 =?us-ascii?Q?WawVhXZndWPi/6Pe2tUim+9YkoHHmq2Z5LDc5lVhdiSfgeq1IpZPaiSPnV6t?=
 =?us-ascii?Q?e+Wq4LKXMicbUka3gP+pFX+01XPMYwMWQBa7Vhx9ws7LZYIU/W2YmWX97XoS?=
 =?us-ascii?Q?pk6IeXZGv7bndNyoN0s/0IXU6doNloyU1Pi1nEr+VbPtZkaRX1FGgPkXtrtO?=
 =?us-ascii?Q?+s1JXcNNpFC7oC//oM236WCAItyRxCKyYZlcHibPy/1PLnhJzzxmJiKxoExh?=
 =?us-ascii?Q?2Gtc4znAfiexW9KR7AwspwlDtC0dgbez7j3POSEde1W+40VwAo/zdnW4Qgkc?=
 =?us-ascii?Q?aPjY8nvlowfvhs5bKm2RPwUUeKSxoJaPeYvenZ/MXqVLY+f7fj78lLQgU+iX?=
 =?us-ascii?Q?04zBmRNrqrAs5RNZNsHv28gecUc0FiUIwsIFhVS4oZ/Y5/oO+a15vwLsgsPo?=
 =?us-ascii?Q?lsdRrhE8zmwOPg9xN3P1Alrp0+ICmZ9iVbNTXmoTWN/Ri/6Y7yuBu81hQVMT?=
 =?us-ascii?Q?DJ8nh+nBOtNM9I4tAzy2MOsZRb15pVVgIk/+I4c6737tICVCPaQb91D2wyl0?=
 =?us-ascii?Q?laYsXjAQe1J6qOpSFC2AkjeszRVflU0QiPbOR94QYM1425tXp/zzauGsQWxn?=
 =?us-ascii?Q?6neYWsrIvBasAB+Xu5D/d6gdNkshEEmXr0wexPnEj7zbTrt8iQorqk7a8tDz?=
 =?us-ascii?Q?Xitz86SvGJDf1NC/3ow+/hCDCf352BwIM3BZHL/x+08Iuk74BGFbWr2X067F?=
 =?us-ascii?Q?zCg0O2AmWT+aThVat5Vh2a1c8IM0RmroGJGd0o78/r5GTV3hY63FKfTpa+M+?=
 =?us-ascii?Q?Ckf+a5G0UbMW2mdNyp+6EE3khVdTWbk68b+dQLgU7xTkPnWdT5sWZB2pEonw?=
 =?us-ascii?Q?OFpB+XHlma0E49xDhobcOjYU0MY1CBbMUDsbNr8EHZSStub9sNPOC9oFaipW?=
 =?us-ascii?Q?obWbM8/oosL4eaaT+czdtz8XK6hAfapHkh/F1WpR907REOisiWEjACuNrCBF?=
 =?us-ascii?Q?GMxOSHPD4xj/Y/aWQqu8Xov9cHIstEz/Bwk30IGI1wzRe+BsUA3hvLX0Idjp?=
 =?us-ascii?Q?mutotdOB4Nm1dXLUG14wloYAkKRJ1EyagbGcn3YZVpxpIaVsLyR1Se6nqEGE?=
 =?us-ascii?Q?2mFOLyqgo/YLd0Cz0s3n/HkKq1eWAYoWvWvz2DlKPY7fqasrlTvSfBq0rfFU?=
 =?us-ascii?Q?ULCIz7VbkyfcbITWALL+ilS8YR/lcftlG9eLnWLhg5tKwkHjXZYHQS99VPAR?=
 =?us-ascii?Q?brb6aBOBnGydBmAF3XxnOcYmn59DTvaHfKS/rDtym3s8MF8lwadJcC/pjTcc?=
 =?us-ascii?Q?8KDe9KHM6vQVzaE1IaMQHgFKUSwXkDbwmxaSeYcV5rd5OoVy0ssHgtZcM4tV?=
 =?us-ascii?Q?E1pDZ5KOqoAtQkXYeh/CzFSYEnUtzw9jXvFPy5/XsA9aidJlo9z9CbZwe/y9?=
 =?us-ascii?Q?L4UO+kkjSoKzhwL/BFxQsqMrY1Rv/hH/dTSVkMTs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7978b05c-6cd1-4384-0324-08db5b989276
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 14:18:25.6337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0W7eAq4N7NkXocarc5bCmromEnNkQXJhxpHmzt6pvdceUFguX07sMtcAb+71T4aAhzCETW3GEdt2z4ujzo0Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5539
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 18 May 2023 13:19:12 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > > On Wed, 17 May 2023 19:45:54 -0700
> > > Ira Weiny <ira.weiny@intel.com> wrote:
> > >   
> > > > Magic numbers can be confusing.
> > > > 
> > > > Use the range size define for CXL.cachemem rather than a magic number.
> > > > Update/add spec references.
> > > > 
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > > 
> > > I guess we should do a scrub to move all refs to 3.0 soon
> > > given it's horrible having a mixture of spec versions for the references.
> > > 
> > > For future specs, we should only do this when sufficient X.Y references
> > > have started to appear - I think that's true for r3.0 now.  
> > 
> > For the kernel side I think Dan is taking the 'if you are updating it then
> > update the spec' but otherwise leave it be.  So since I'm touching the
> > code I updated it.
> > 
> > I agree, it is a pain to have to look at the 2.0 spec but you can do it.
> 
> Only if you are either a member of the consortium, or happened to have
> grabbed a copy in the past I think.  I've had people mentioning they can't
> get it today.
> 

Oh.  :-(  That seems unfortunate.  I've emailed the CXL admins.  Perhaps
they can post an archive page or something?

Ira
