Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18242C853
	for <linux-cxl@vger.kernel.org>; Wed, 15 Nov 2023 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZxoyw32"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFCA1B1
	for <linux-cxl@vger.kernel.org>; Wed, 15 Nov 2023 08:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700064075; x=1731600075;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=31moZYtjp2goB998RrTyCJDvBDRca/4bGrnN2ndCmY8=;
  b=RZxoyw32PX8fR9h1uMDh9YQ6/OY1pEE09wN1d2Th46z06sEcLfm6Jawo
   IOF1mR0ZurfNffhY6U8tFlAE8GyRKFBF5BoKsjHk7/+oc9DCOSJEIYKkf
   kL27uOMuSfMK42doSOUCDKphms8QrbmTchELKu1jU2TS+GSLBmmYUY9wM
   ad0TLTHgqWgxYS7FQDt40RMJG31DC7eSOXwBEq+JvD76wr8JDjupa1t/Q
   gs/5eSwwKjYbVmwBNw3iMPc5zumPeQbRZyeAd6OW7V5hJQGr/1vY1m2fK
   CYufCq6V7MLSMGUpNTzLK1gCAKPBe0wg+RDrpBdQF6NYLTkKLR2t2cQPz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="9538510"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="9538510"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 08:01:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1012307096"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="1012307096"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 08:01:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 08:01:13 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 08:01:12 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 08:01:12 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 08:01:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yfq+AmK9E/rgP0xFJOEMu2Sqm0J/qi/X/qibxJhw2Z+VWDK+zhUs7QQT7Oz1a5U61slqrDVo5/cVTQWIJRYfApk3247XrWxl9CkXFiJWboJKSYBc9w5FQUB7nZ+Gv/pJJI2V6KauQeIDftKk+m6FbMGMTCPglYfp6u1Qua4dR9ppHcOwYoSb055rCXUrPdD9kMrRd48tp2phKwslho3H7GEIQ3qqVpeOzodiP2WacQ1DYXN/KE9fc+c+CACP5IOd9kUyQH9yta7KpYKFSgPhHKNbfRp/ncTDmGx3M/8XJ4eRrE04OxVtLZDt9tvdaW8q2YJKQOTKcI3G/e7De3mKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKFZX+RAOsf7grFmzFj9+tS14S6jCY45WbGCfLO729Y=;
 b=NelXFU13zmrd6OLQ6Wh1U8JutxhzzTOMDxwLZLvJ7cT+l/qMV24OsY8e7wnXH3Ti0nbaU//KgEkqha7BrZ5eH2++DZxNzGo+in8dPYFpg6nDAVBEWo1w78kZ3/Wbpv6v7Btrom9dYvS1jRTTPTU1rItckfEYMWzC9qb3b7X7SjN2uoTJ+mtFo42rGRhhPl8t/p2zogDnScQWoMKoRM2jd4nSAMIbo+hJIiwqQmmOl2K3UAAO3VagQnsEo2uM+0wSyBjRwOvY8Fva4IsnPfdCgof4UhbsHPHSNyPQjBHu3Slx6qoJhTiHPTiOa3YMLvCsueOFbVwf/RMLZQ8D2Yi2hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4986.namprd11.prod.outlook.com (2603:10b6:806:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.32; Wed, 15 Nov
 2023 16:01:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::a49a:5963:6db:77ce]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::a49a:5963:6db:77ce%5]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 16:01:09 +0000
Date: Wed, 15 Nov 2023 08:01:01 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>, <vishal.l.verma@intel.com>
Subject: Re: [PATCH] cxl: Add cxl_region_rwsem around commit_end write during
 decoder enumeration
Message-ID: <6554eb3d8af14_fa4f2949e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <169948110840.509375.13862681045079385425.stgit@djiang5-mobl3>
 <654d5f7285171_af98d2949e@iweiny-mobl.notmuch>
 <654e90e4349f9_46f0294da@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20231115130113.GG3818@noisy.programming.kicks-ass.net>
 <20231115130624.GK4779@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231115130624.GK4779@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4986:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f2c14c-4c44-4a90-127e-08dbe5f4155a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFSfLEk8Iss7kifSLYVm4r2MUKmuUSrWF54yyvuyUvnaIggDdnmaoLHO++AJyruL2iFYrCS9y1D1LnhvGfmJ1kUgfl99KjtvUI/VdKnih+b5Jt2Cr1BRBZuVtb1g805zYtHOAkMABOiPTe9o4pU93yZdrX6Kpyu/6FuvcRLzfjTHn56p8b2SqkJfyLkl56NeBYRcYVzkqm5jCMYo3NqdFOlBH3oynsNAdtNJVrEmBGanLMWgdUSMp75m5cGmjmARUFPmOeM0C+qghkK50kNOVeNbXaFRMQcS5fLvwTa/xxWcJjHXiHb2TT2x4OFWHipk2q+jXPb0qwTL3tLODHcOBWpRl0vAYayNTHM+xiIELYz7nMvvEuVY9MOZlxGl+BOVGvpPAucjKUEEKv+H4rtZC19PzJ5LvMzpEVXNiRCV4Wwq+C63nNMfwYRrcMPpSV9H6HJVkM6A8eqVZVuA61XjN1TZjKLRmyXIMYJCECPBbfPDZHtKrFHmMqMAEhKt/0UXF4Gbt+QiLYQF5IfFJ0xzGdtKiDw7XzMQu1XvcZv/2sGoaApu2MV25+F6l8G8ABEw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38100700002)(41300700001)(107886003)(6486002)(316002)(66946007)(110136005)(86362001)(54906003)(66476007)(66556008)(478600001)(82960400001)(5660300002)(26005)(6512007)(6666004)(6506007)(8936002)(9686003)(83380400001)(4326008)(8676002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QoIrwdfrb6bvjPAr378cIsxWw3IvReKFDVuGjjKCsDXhQ5ogdLlYf0nKejC0?=
 =?us-ascii?Q?/PuhpSbPv1Nl4w9MIhSJ1jaDPhKiRc4mDiZp02L2HjIw5bq+21RX6eNmkTXE?=
 =?us-ascii?Q?CcoqDNrWWvk1EWp1So1JP2Sm+4UY7Q0vfvvQaM50koBqC8dzJHnUQHq3e/eP?=
 =?us-ascii?Q?UCaNHYTjQOvOtMPZp3Rgf34rIdGJIFOd3esOofrgjPQBYBa+qYL/bk3GmLmf?=
 =?us-ascii?Q?BaNG0L9/H7MMIYqo2hFXkUPyYs385FaA0vJ/s7e+QDKVu+9o7z9KhGLZ2kds?=
 =?us-ascii?Q?ochfNz6Wglfad1vEv6FTpsbdxbnRZSe3FHOZXuw5Iwo8IXVa7pJe6JFP4Qbm?=
 =?us-ascii?Q?MvMmfSFfkyp7py0wvcR3QS2gk3C67bPEnkrf/0ts6Pe56NseAZSxrhr/mOIM?=
 =?us-ascii?Q?f73bYFN0AKZnuZW3bfZ7mlbTthWjdJ4ioxTyekhq2vta4sI+34kLSXxjC07P?=
 =?us-ascii?Q?A++vfJ+fMvzJ05A9dvC7A2+NBqKm07DQH1VPlqa+VcFcMCktgWOKipkiCYJi?=
 =?us-ascii?Q?9KNGN17DGzPYDdEKXDh3Ig+p6dR9zr/8PjtKbosqAg5P4+eBmqGktpnNIIaX?=
 =?us-ascii?Q?nAuoxWn9ophsdXXmN9tNJxKOx0NiAjkPMaPgt62yGsktXN3XcBgNFGnoV4DF?=
 =?us-ascii?Q?fWNLUJhpavgWN2A5uod0DuuqK2tczPzxweIBtmPjqcb/7RTfMS4b9R1TKAKM?=
 =?us-ascii?Q?N17veaWDhyFs8hD8070t3L0DRjAv418IRQcL79Bz6V9p6ock8ZZnvGRI4rVB?=
 =?us-ascii?Q?v1Svo0GnhrP7XXHTx9nly2sZw0WfPmhxhdNowgQR28VvsUDbE3aLsNdXjEDP?=
 =?us-ascii?Q?dRvckXzCeO1pZ8DfICU9VM4fsEHVRZcwggYfZvtEEgDPBysvLb6+FOZDiWYf?=
 =?us-ascii?Q?h+b/yUAIyHz/2BVxeFOkHkQ1HXFoSS5UQAyJTbKtMXqwcLKrMg1TPQ7Vx3l2?=
 =?us-ascii?Q?hUPushqupYnpGrVI1M1HddP2kaIT7oYlfzsK7ZE6WAySqENXC7ZARzyxSTbd?=
 =?us-ascii?Q?V0zpznuIjKszpizHBG8Zr+LzQaXB3gmu/Fn34kYM4gZn8nojiP2GGUkv+slO?=
 =?us-ascii?Q?zCx0UEuK6CZ86mkFbO7hC5yhSSsa88aR4JKNXwj/73icyorE7GWv1xsxEmPr?=
 =?us-ascii?Q?vofxP0QQBqaPhEv+dVLumMp+T9XtS+sjG9c53PlScS9yOwfH170s7OIiq/wf?=
 =?us-ascii?Q?5vhwJQd214KsNLWEQ/cWd9MQ9Gq7s743RfALW03zydA0hI1Y5R9WfgflL5an?=
 =?us-ascii?Q?EmVdKaKTMjIifbFo5m5aWua7IbCRN7FnLn5h6t35j4bv2jcoZUz3NZNfe0mM?=
 =?us-ascii?Q?5MArn/X/+nA0u5S9FWUfiMd1CLcirBRnGiRGYuRKn+UxpQPG0C4i9Mr5fq+z?=
 =?us-ascii?Q?u0p61pi3J4CLtjPGY0a8bbM9A5cpYx1IWtVpP2bbsIzy4L+oAPp4IvPyb02b?=
 =?us-ascii?Q?LGjt7Y2cvRKZBsOcDYFEQRPuGmgrppAehFgN6Zz04EN9uM1xOxP70m5MvPiR?=
 =?us-ascii?Q?6YVzy0+a0TJ/32x7ocyjJzZ53WUkNCojhPHR4/6vTHsIdNlYH5+hvS/Mkscl?=
 =?us-ascii?Q?P2PZD4ObYGzA9s8lzcvNh+bsXJryuihgguMBc23XTChI+CTagNcyYrtUcLgG?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f2c14c-4c44-4a90-127e-08dbe5f4155a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 16:01:09.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEj0luasDW19706qaJkb4y6oCsE/ODNR5GuoQIOIVHfMCf83PwA0NzDfGmm8dF3oX0FzzWYcd4onNzWDE4DjUKigThyATOYWUIEl9HejNjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4986
X-OriginatorOrg: intel.com

Peter Zijlstra wrote:
> On Wed, Nov 15, 2023 at 02:01:14PM +0100, Peter Zijlstra wrote:
> > On Fri, Nov 10, 2023 at 12:21:56PM -0800, Dan Williams wrote:
> > 
> > >         /* decoders are enabled if committed */
> > > -       if (committed) {
> > > +       if (committed) scoped_guard(rwsem_write, &cxl_region_rwsem) {
> > >                 cxld->flags |= CXL_DECODER_F_ENABLE;
> > >                 if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> > >                         cxld->flags |= CXL_DECODER_F_LOCK;
> > > 
> > > 
> > > The alternative is a much more violent re-ident of the code to turn:
> > > 
> > >     if (...) scoped_guard(...) {
> > > 	...
> > >     } else {
> > >         ...
> > >     }
> > > 
> > > ...into:
> > > 
> > >     if (...) {
> > >         scoped_guard(...) {
> > > 	    ...
> > >         }
> > >     } else {
> > >         ...
> > >     }
> > > 
> > 
> > What's wrong with:
> > 
> > 	if (...) {
> > 		guard(rwsem_write, &cxl_region_rwsem);
> 
> Uh, that is:
> 		guard(rwsem_write)(&ctl_region_rwsem);

Oh, likely it is me not understanding when to use scoped_guard()...

/me re-reads the definition of guard(), and realizes that it indeed
arranges for the lock to be released at the end of the local compound
statement.

...and scoped_guard() is just a more convenient way to write:

    {
        guard(...);
    }
