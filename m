Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B952DC433FE
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Nov 2022 21:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKBVB4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Nov 2022 17:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiKBVBv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Nov 2022 17:01:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2F0DF25
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 14:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667422910; x=1698958910;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QhVUEKMaYbM1MWg3lx/7jyyzaKqgsq0qA34UaMMwKRc=;
  b=gu/FtVc1gAW4VNQI/HtO7saeevXIdrvfOayj6dZjAlE7ZIoiaIovkxZs
   We4bwVoIbhZfdGqJkPN56wB0nh3CCjWvZy4lBTL/crRjzRRywvFiyXQIE
   hIUwU6BHxwIr4d0GHdflp1fW8HFbEQkaL+SIE+HOcTxDQmloqsvwMUuZa
   oF68AG7Frv53Y9+RwsS7groHKvwlUsuMp469hxLDVm+KGwLvsXvMA8Wp8
   WVsDavC6kzXG4B29CpvVKNrLV/UmCT+i/nHz1c6h547XGkfpEEr68ftEr
   5f4n2/jJugsLZLLVcPOZypb8dhMnycUHgP43wG3SkOY1Rr5WID+bkC6oz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="289907296"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="289907296"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:01:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="759693314"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="759693314"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 02 Nov 2022 14:01:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 14:01:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 14:01:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 2 Nov 2022 14:01:49 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 2 Nov 2022 14:01:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdUmD1xn8/B8AKW+iygiyO24tg8TZqiIBRSVgMONvC6/Y+Y54xXd7TzDje2zwa+Kw4NzRQXdmeO1vvARnJZqUIHrVkdfAho/sLjfJZcWDfYzoRgXz7TlFkoi5C3UKEVjDe5DnJYwO8BA0xhUAdtO4XYegG0id6SAYMYhwY2zgV/LUCHuQ6m0ntSO9PhPiI1y/jERclsotAhFN3JGeg/m24XcGldfr5K522VjruTHvJWGyC4vla0jtdlqB2Zu24gR6U/LhblJj4O6dVnVyvIB5nVho76Pg3TqtU3pbzoMA4BrFcvGclDopAsnGJ3wsxAhILd9GM+CownHCniuRyhX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2F+xPRiqWOe5/3P71bmfVgqmdgT/bfpFALmBxQW7Oo=;
 b=e6gCD3zUUckJ1M8Ua51osz3C9d8NUxC0qROjnWWkCTl0bUWYQ7St210ZKWJ3tLgXZwWCMKLG7/OhCOG28Vo8tMc/Ij+rIHSnyyYyEoa/PXdP1bkSFe5X116DlEwVDclcj8xPb49f1tt0imPo8xm5A2OVAhzE2lyF/dYMmeU2AzlVngXhXurPNgaZ18FXDGFzFAszZboJjv7ERgqw1JeKNdukqXH8ZgCr520pqy8fH99P0/BVYLu0XMh7FEYXeenBDLyC1213ceCdiPSqSn3bSb+lQsLS/esJD59k5/EGFr0AonvO+5DoAZYDRn3IyhhJJZDfMumqFkyRTIIbSNAzuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6747.namprd11.prod.outlook.com (2603:10b6:510:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 21:01:46 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 21:01:46 +0000
Date:   Wed, 2 Nov 2022 14:01:41 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/7] ndctl: cxl: add helper function to parse trace event
 to json object
Message-ID: <Y2LatYdIX7Nw75hf@iweiny-desk3>
References: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
 <166318847529.3087953.18405653106756321818.stgit@djiang5-desk3.ch.intel.com>
 <Y2Api2kdhBrRepeq@aschofie-mobl2>
 <653ef2ee-0de3-1536-bf88-c7ea9cc67a4d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <653ef2ee-0de3-1536-bf88-c7ea9cc67a4d@intel.com>
X-ClientProxiedBy: SJ0PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e815bc-5abf-4f50-d350-08dabd1573fa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nxj9HwiOU3t3wqrFhoaRje16s6A4tdE3oz/2oGnZN3ersfIKIOzvYrzKm7fJaZpqjQHMtzFh7634Q/gBip6T0gpfeZQDTKLt+d6iCUoPJ+h1lvQ9qWlNRqzjIbfmT7jWn+DlrE+Wuu6j7rmr+Qd2EIUIrenyjaDkANmEgQlpvr8Wx0p4bzsab6l7njgBvJbjFWpFlG6uTuavkYBn/1wQt5I/hdAm5TRvGgGmMpGiUx2BS0a02B2YV6r3YB+x8g+SiwXGVjNR0bK1YZFwPIu7ycMTzcMQ5oM/ZTdqDyrgd8Ou/OWVl54ED4Unqf+5NeULlpXu5YStehcaFnSchzixdxY9/dS6pyUSgi8aVbKz7TMmOjfKjpBAyq8uLj4ZI1T/cLGbwWx9KcXsJvN5hiFLAEl8knQNBQCORugueGsCbhMMffifGohTqOFM48K4IcH5+MHu8VoKMdjDZuTQnQLGufJiJq44AOkck5GTq7kerUdwupsi4SOTVCMwxwdUtYYE4ifgWNZrj/45010Q1lV9OsTGRo1drKPtWsG/70uet4o7VfoyZSvMFy3EmKM6vdGFnlInU1O7/usOS6+8rComa8OpqZ8AM43MdXngzqepvQIg+Cedyhris76eCcHmLdm56c8F62b3RsurhO6NVmccRM8Dt2v2Nkpup3vlFFKAQRUscPywy1DvmXX5hWiiSScq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(38100700002)(478600001)(82960400001)(86362001)(316002)(6666004)(6636002)(6506007)(66946007)(33716001)(53546011)(4326008)(107886003)(66476007)(8676002)(8936002)(6862004)(66556008)(5660300002)(186003)(44832011)(26005)(2906002)(9686003)(6512007)(41300700001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hk64POsMwggWzfI4FWaI2TcoqtlZ1H3hygFPvEICLTP2isBRbLZxB99XrcRt?=
 =?us-ascii?Q?HBrsM74zaxWeZbkCJPprO5V6eI20uR0jm93nnBCALKpBdpJjwNmh4zs9yjln?=
 =?us-ascii?Q?e0uccrmW1L0pn5nG9bCCuw6/AOShtPmWKTEHk4w1fKXhtOTdGHKyN7YdV7sL?=
 =?us-ascii?Q?I82g5oorJRsw+zSH63Qwty2NcFlJRNG9zLqvzmpqxndWWyc/WyFlJRskZw8i?=
 =?us-ascii?Q?rhEKkfa5BELHe/HEQZlOB/fxdA0YLqvRzG/PyOmfl7T02JYKDKGv3+Azw35q?=
 =?us-ascii?Q?5gk2iduxGzu3DnN4KWvf8TX4qAoYSUIHgZrW7SvqVD0zeDs+++SVIDiwgofy?=
 =?us-ascii?Q?a0GdpeFK6U6M2cT3+jiygfn0sRMdwqLRaaQfPlcp9+KzGvNynF6ODNSRwKvP?=
 =?us-ascii?Q?B61WmAIR9AtbihispPgKlCnirE+d57gU2bjc7niXJMr0P1IWCmxygxqzd9e+?=
 =?us-ascii?Q?6IO6RX1W2gjFmanc+GA8jSBeSe9XcWJPY5FiPAYk1UqeD7Eo+f1qscvzk8Kd?=
 =?us-ascii?Q?OUsJaCsU01bJDlhi6MfEJMNDqKMBWvwC0QvvVkwyRmrsZyErvTt7GYOnLRrw?=
 =?us-ascii?Q?fd7aNn/neQO0aeQAl1OZUs6LH2isiQVy0Egzny1vtg5nUu3V4MeWi9dDm/ko?=
 =?us-ascii?Q?VA/qHSdG3EfoTGTlw3Pufk42kpVm2jWglkSWDResFqzxAwI6hD9Edcz22apN?=
 =?us-ascii?Q?jOEgX5MU4fvYhkuJzH6hMkkMGqit6FE+uDNcXBSgKpuFsJT8lX+iWBhUOaM7?=
 =?us-ascii?Q?4ZeFl9KiBbZW0ehWPchKZ1t960hXUCpEhxvTrFrgLfztOQJFC4/V+T9z/4hY?=
 =?us-ascii?Q?saG0xqZC+xYU337+/PkHLkMqv4AXUFGssw1dB9v7c5Hs69POFtZM34dClNCF?=
 =?us-ascii?Q?W/QZRxxJt3e9XaL8ypE32HBdbFb+JkEtPyiuqwQcVwWQbEzZsESa0dAL2uOY?=
 =?us-ascii?Q?oGuSnu8OBSQV9DCtBlZ7nMR/JX84u3MNAt4Zs7y4TeDJixF8MGAHu6Xwg4NU?=
 =?us-ascii?Q?NcCD3zZf4Aeo0TpiPZr0TUwwJN8fRJpQAnU0+FGm3i0LLN7AsPMpktocZioh?=
 =?us-ascii?Q?M9I2l2XuUI4FmwAySwGayNzGgR1IK92GM2su+2CK7/nGoEs25InnJt999W3v?=
 =?us-ascii?Q?WMjtd3jofJLp5TgjtsxQwmxLEZiiIQaj6Sfu9G0AczxJHqCf7yYiomYZDjN+?=
 =?us-ascii?Q?tM/m14p2ey0i4+PKofj4jfYr7IYyBOE/5M6cFSwRS+Azl+JjiNlL6pTOwk0C?=
 =?us-ascii?Q?Aouo3M6JmuQMB2LS9jOqz44n7pXUcinXYoqz/MS3QqJ20tcWS25fjWogrS8K?=
 =?us-ascii?Q?JtSJ8P1KKM7fDphz7jgGh2rXokM+gPDtcpog/jflzO443FueUobUbakgeEks?=
 =?us-ascii?Q?N0OCjHsgbC3dWjFc+EivuC6YI1RPHPYpmZ6Emi8vcut9jZ2vmv8M9WYIGaDJ?=
 =?us-ascii?Q?1YwGDQkp8K/4eoptORwr5Uqp4cu/9FIIsBMp4kflE1vykaV5r1mmMyzlwCQy?=
 =?us-ascii?Q?qJCyNu+MaA2ogoElXjbGvGJcYwBEUxBAXgTEgwyqkPQxBnHipejawJd4OAHl?=
 =?us-ascii?Q?1eVFJMkNjkQq2thb85gPtNwaVT+ICVr7a+50aN/d?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e815bc-5abf-4f50-d350-08dabd1573fa
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 21:01:46.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYWnVqly6M3+N9fs3DxuooldqZdgmQiSe6GP5pxyiLWjGjGuzrlenv6XDNh1Fxvei6ZeZyKDNVyvEeS7L37Wwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6747
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Oct 31, 2022 at 02:37:02PM -0700, Jiang, Dave wrote:
> 
> 
> On 10/31/2022 1:01 PM, Alison Schofield wrote:

[snip]

> > > +			/* check to see if we have a UUID */
> > > +			tmp = strcasestr(f->name, "uuid");
> > > +			if (tmp && f->arraylen == 16) {
> > > +				char uuid[SYSFS_ATTR_SIZE];
> > > +
> > > +				uuid_unparse(data, uuid);
> > > +				jobj = json_object_new_string(uuid);
> > > +				if (!jobj) {
> > > +					rc = -ENOMEM;
> > > +					goto err;
> > > +				}
> > > +
> > > +				json_object_object_add(jevent, f->name, jobj);
> > > +				continue;
> > > +			}
> > 
> > Insted of comparing the field name, is it possible to check for
> > f->type of 'uuid_t'?
> > 
> 
> Yes. I talked to Ira and he'll change his uuid to uuid_t from u8[]. That
> should make it better. Thanks for pointing that out.

So after unborking my qemu I was able to actually try this.  And it did not
work the way I thought it would.

However, in the end Dave and I figured out how to make it work using the
__field_struct() TP entry type in the kernel and some mods to cxl.

Thanks Alison this is much better.

Ira
