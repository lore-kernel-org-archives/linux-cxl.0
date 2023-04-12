Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A1CC77B6E
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 19:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjDLTfA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Apr 2023 15:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDLTe7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Apr 2023 15:34:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEB726BA
        for <linux-cxl@vger.kernel.org>; Wed, 12 Apr 2023 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681328097; x=1712864097;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=03SVyqb/fPsE5A7sk8r1SHb0L+eBFJfYjZLCzQICEG8=;
  b=I6BY1zwmQIS3yGhcGfuNGp7e2pNpuVSt/gW7wpwSCpQ4C8z1LvM5sxHc
   BGsiTRM/GdXCjKYamp1cy7nXotLu/RaMFUhL5IqJMm8+VtUtSJxoPz7V1
   r8UA/Dd+sfMUpFma8WjzPgjM/dhrBUoxVj3Kii/ijY6plsewTxA/WU151
   zVZpgszVwMO7ie+zFaixw8cTqI6+1IJwxFUhBvTpH83xm8fuwSdeTQdMa
   ryVMA45iKVtg8crcDsYtz0rXGXVaPuh0VhU8yufX98OfPt54TXsJEKoet
   RX1TyLABL8VXY1YISuWbhYesUncJ4rSh0ahKKg9R3mN5l7/mRidHeyeJC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="409145664"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="409145664"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 12:34:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="689027724"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="689027724"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 12 Apr 2023 12:34:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 12:34:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 12:34:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 12:34:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aX2lB++yFeB9YwCN6u2cgyfn7zAiFBXcQAHLn6PTepOBw/hRzzlmC4p8byRNeohyJ1iPknJKSGL8KIPHqTtR6dksoNqSm6i7vCNFvFuJhp93nqb68H8w9CeC9eTob84FslgoWg+YiU1WguGEfIUKag11sdc1JsoxXVDOFbeJ9rCXTIfSYPuT+stnU0KjE3aFaN6jYlxpLK6bQiK0S7mBd61KhW1wwJPAAVpigdk8qQmuFRQMnLYgcEcSl9dPkA/q3tuSDJnHldJfKLESyt0czo28ykXC0K5dR9pxQaQlbN3Ldmj7ZaddYZm2LGh0qEC4MR8tRI0HQdLiJuVP9VcsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaqdTRiGE9GpMtBobKlA11eTMxwqboKBjrh+f74H9J8=;
 b=c8BoLnJTSTWSby5pz6L+WwXZSTxvD3y5MlbLFUx/RvLK4L6QEDFlwVoaDqATuTezxnWyBQTYtHU1pKFKcV58N6PfFmpg8KLKXf9ZThu5/HFxFjExyBr2bVJvtbc842LnLrWJRwQq0N0bOlu226cbPw9UTq8Y63evFHBUJdC9OEqqL7zK3z/AtnDJnGAt3sojV8RTM9qeVVW4A7qjIWzEycBSSo0ZjIZWZBjWBuhOoXCDLUyxTv3ZGOBMm3mNoGudhBz688nKZuYHhdAUKiI/B8iQvNE0cql3v+j/csJWtgKqmVURoZTu9IKgwbr/7w3npwycWmVAv8J0HgDta5cczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Wed, 12 Apr
 2023 19:34:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 19:34:54 +0000
Date:   Wed, 12 Apr 2023 12:34:51 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v12 3/6] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <643707dbac39b_5f756294c3@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1681159309.git.alison.schofield@intel.com>
 <31ecc71e43fa584aa0c4b1cb1e9aa7b124461037.1681159309.git.alison.schofield@intel.com>
 <643643ada955_417e294b1@dwillia2-xfh.jf.intel.com.notmuch>
 <ZDb5LptUNNnej/cc@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDb5LptUNNnej/cc@aschofie-mobl2>
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca4260e-822d-42ce-420a-08db3b8cfd99
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BvvPgkT0Se4r8N146iSHjKyjN1+Fj6x12EgpGhwQBuCLn9D84gz0YMy4RWjLBVfngbD7zJscZ6pPirepZbL5Q0mqJ4MiSh/n70rpfKDXFEn+sYll2mjrOpevnfbKihQbR/XON9z74SRP/BuQU/J4/WaiOun8dBqv7WGQYDY2lVsEb303xH2SDUJtdBzY9S0EMF+NfGipshGlkrVFYPQ9lcz5IUfuGBwWFN1BlNDVx+SdpdabHgWQHoBYKGnHVZkPDDU7PdBqtvqMnkVaNAYwIAuLcGsDenB125nfjP6yFodHtfL+/AkgD9CHmccN/h+sIFmRL1C6zoKW6JnRbt+R5mJWEbMkqx+DcCYho/MNoHnbSTCUY0GqnE/SrTWhkcPbcsfuiKflFIroJptVyoCUUKDW1JVhFRyhUjpxzNWHnY2mn7+vFrH1G3MI1X0DjyN6NURTEf+IyetwBfqXmNvIfRhcral814+enLVUf3QdcbmgvVeHAoD3qkMRcnFbPlCnsKc06HXpmIVdorVQzTDNj8E2NFGlgnUbHTTve1p3e1eVeAseOzztd3tiTWpV4TYn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199021)(316002)(5660300002)(6486002)(478600001)(54906003)(41300700001)(8936002)(110136005)(4326008)(8676002)(66946007)(66556008)(66476007)(6666004)(26005)(6506007)(6512007)(2906002)(186003)(82960400001)(9686003)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VUe0owVyj8eT2ywab46KGz1COnHlyFC3avvPkUB/gu1ruCVkoGi52/6RN8vZ?=
 =?us-ascii?Q?AQWGTHSn4Rt00qyVih0tE00NjUxnlSivpqPA0i2dAVHiuU/WadGgkifl5zCa?=
 =?us-ascii?Q?fQx4uRHVcdaf31N9wfpO/NPp+DRB8Vb/qJfe+ShVpUPy3ERk6YI4D8PZFKUR?=
 =?us-ascii?Q?9aCGJPRXeagZzcqtEExwZE/2OcSU/cvjfWwM8Y4AqRY0I9xwc7AFKEIxgFr8?=
 =?us-ascii?Q?Gs2KsGFNyyCI9/CL3Xj/tUy0OjYEDyIkR7/JR+bN5yCGTrZsYQQyrvH1QvOO?=
 =?us-ascii?Q?Hs5cvKTbeCzRu0zup8YYdlszsScqPTFsUUIJ2Xc3Qxei88yUep4ekIPrJs4b?=
 =?us-ascii?Q?nflUiW0j8zJ2dnBWk6rgj5brzM2a7h3AJKzdIr5g+cqevJbvkidwTRzV69Uv?=
 =?us-ascii?Q?e/nSbZ720jtWz+wgc4c3K3uJwIO+qquszotoYmTmO2bIjZdE9pU38XnbefBD?=
 =?us-ascii?Q?5hSVb/5yAAGXHtTkVQQkejGeH6FHbUs05tIBHAT2XUhhh6gbPkkhO4GuZy+Q?=
 =?us-ascii?Q?JtWIoEgmI9qC2qIcdXxPUMLJza04yGgf5SFoyVoBY8ZjeVblKlq7QYMEnPTu?=
 =?us-ascii?Q?ZCpIz2aiufPX1VJYnsjVT3iCjCdfpz23atq5338y2tgkT6U9T/CklfLrNT2b?=
 =?us-ascii?Q?fm6zrq5Xchq9IvAJKT3KBtg7HaO4zfWV6plitUCMvdPdz6sdeJAsLmwdRiN2?=
 =?us-ascii?Q?JdbaSb25sR1BG7sWxPx5iYoi8yu/VYEl7y9mLsS1FoUk0FGIC2Y7MbWXCIsT?=
 =?us-ascii?Q?2GGvhF76a45wpYaPOmCnaU6STNPSicZOoE4l0kPry5VTZhTvi/X8YJopY7i0?=
 =?us-ascii?Q?QhrAeyW2pvUddpPFq/3SD+j5SDiEs1zr7DJvRdyyAaMlapXLtJR73eZYjYLd?=
 =?us-ascii?Q?JC6K7R87cUbvDS+2Vi7XqO13d3Lx2oaZbXeo9jY8nlVx9ZhlDlYKCziJBWvy?=
 =?us-ascii?Q?FuppmCCdihtwFfkDXQJqQ+Vjzm8kvNm3ZAgig1i/VIqVxTmYDjTQKLhvA6BC?=
 =?us-ascii?Q?UqUYl7ygKDsVfbS5lblnkSShsllCjPvzLnAoC+Pd5Uoj5Lh2KiRlaHDsYg3f?=
 =?us-ascii?Q?VeRa4JxlDp69rMRct7U8N4Y7ui1eD6lTLdAB+t+QGiDb/fREkfagRDHW2OM1?=
 =?us-ascii?Q?5+V9NtBwRzODos5iyZb671yuBD1MMvvCnbgdRA6dnmRP8k0LZOEJLmEG4P6C?=
 =?us-ascii?Q?vUBqYxH4pR1X6BqPBb8FTZUdew8nSd4BALCE1ngPljrPXFyqiJGtFkbCwaJ/?=
 =?us-ascii?Q?z1XQw/iSu90ftXYx0Vpfxj+nkP1NEkGtUSKVUtP5KTFRK/u0TeXwDtdsjiOH?=
 =?us-ascii?Q?CejdDC8G3F7oQFnE5VGMkJRIU5v/U5jKDzVeChPDMHSZ/dIXU2qkcJPdhPYk?=
 =?us-ascii?Q?pX6cWq60pHpTsXlk8zbiPb6PK8GyBx01LzGoSTwDM8dw0iun+HN5pAsrHinS?=
 =?us-ascii?Q?JlUT0RFl74eZoBMqEg/yY6cu0I9qQCqYPExHLSian8VQU6YZEtf/ZdXFu4cl?=
 =?us-ascii?Q?neh3BLXUjEgHCa63WCKOdYEjIgtzQINPnvX3Yf0h8tBTlnpxjzWz47E6dWnX?=
 =?us-ascii?Q?2U8+pMRRKfDqVEAcQiquw1WhsmKUY5eg5yYHql0oTFG0OdyqXgrp1T5ouzxm?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca4260e-822d-42ce-420a-08db3b8cfd99
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 19:34:54.1066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaFbld93Fo0fJ7WeJ+pcPksvBHf6mSBQsAuEigmzjW7JSfc/NuyVEuohB3q5LvqEb6vfojokK+ENEKsdNB581kDkWdAXrRjmQz31Q9vCSvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7605
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
[..]
> > > +	bool trigger;
> > > +	ssize_t rc;
> > > +
> > > +	if (kstrtobool(buf, &trigger) || !trigger)
> > > +		return -EINVAL;
> > 
> > Hmm, the caller could to this too...
> 
> Why split the work?
> 
> It seems having the caller do a little bit of work, and then pass it on,
> hurts readability. ATM, the caller does nothing, and here we do all
> the usual sysfs handling. The division of power is crisp. If it's not
> an efficiency concern, why make it less readable?

Ah interesting, I am coming at it from a Separation of Concerns
perspective.

The core functionality being exported is a method to retrieve poison
records and emit them as trace-events. Whether that is in response to
sysfs stimulus or some other stimulus is not something the core needs to
care about. An export of cxl_get_poison_by_memdev() is an API that can
have multiple users, cxl_trigger_poison_list() is an API that is
purpose-built for one user. The motivation is to have the core API be
potentially useful for multiple contexts.

One thought experiement is write a kernel-doc comment for
cxl_trigger_poison_list(). It would need to say something like "this API
is only for the cxl_mem driver to use for its sysfs attribute", while
the kernel-doc for cxl_get_poison_by_memdev() can remain generic.

So the general ask here is create new CXL core exports that can be read
and understood independent of their callers.

> > ...the below seems to be the bit that the cxl_core cares about handling.
> > 
> > > +
> > > +	down_read(&cxl_dpa_rwsem);
> > 
> > down_read_interruptible() since this is coming from userspace.
> 
> Thanks, got it!
> 
> > 
> > > +	rc = cxl_get_poison_by_memdev(cxlmd);
> > > +	up_read(&cxl_dpa_rwsem);
> > > +
> > > +	return rc ? rc : len;
> > 
> > The caller can do this conversion.
> > 
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(cxl_trigger_poison_list, CXL);
> > > +
> > >  static struct attribute *cxl_memdev_attributes[] = {
> > >  	&dev_attr_serial.attr,
> > >  	&dev_attr_firmware_version.attr,
> > > @@ -130,6 +177,7 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> > >  {
> > >  	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
> > >  		return 0;
> > > +
> > 
> > I am surprised that Jonathan let this slide :).
> 
> He caught it, so did DaveJ. It just won't go away.

I feel your pain, these things are sneaky.
