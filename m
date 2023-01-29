Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135C0C61D97
	for <linux-cxl@archiver.kernel.org>; Sun, 29 Jan 2023 03:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjA2Dty (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 28 Jan 2023 22:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjA2Dtx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 28 Jan 2023 22:49:53 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F12821A39
        for <linux-cxl@vger.kernel.org>; Sat, 28 Jan 2023 19:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674964192; x=1706500192;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IgvDu9Wj/Z2TB8Yk8oI4vxxjRlC/5G6VFcT/bl02WMc=;
  b=TJwp5+WQ6QXJxW5aPYON3yTVG5dmbKipDSi6iHWA4IGjYXFhynThX3Og
   z/tt9OJByNi6Nz9F79zvPo41Dz0OsB1aYrnFj+gL3mW83UodAAUies8UR
   1BEQ87mq7zGa4kWLuzgdjCRccg21LB8QcaAhYSHB24JSklz4JE3lAWN1R
   HCfvvj3iav4SBU/dsxQQjOU89cq+cPr5hkhaW3B4SUn6RIqgzb3cnUeoM
   6Z1QdOrrk/CA82qonIJHhACuSETlOpTQ/Xdhp+S3WJaP4Sx5eSWdjtQyv
   cRNgjpqtRN6B7t0voXOBzTHsGsMFYxKwGJw9PpV2bnw1RGgjh+5UsriQ0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="307702378"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="307702378"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 19:49:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="732303647"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="732303647"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jan 2023 19:49:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 28 Jan 2023 19:49:51 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 28 Jan 2023 19:49:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 28 Jan 2023 19:49:50 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 28 Jan 2023 19:49:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lotxe/EIpL44IgsfAbK/QwG+gdnKRNF+usA5Bvx1AX4iHTwLUwL9OIuqvD1AYF8JiwK6HUkUVfBgUCgyY+EvJqbmrsMsaGntYC5MI0DtpH/PwQFHil00ayZYxzqM+yK5dd4XnGAZHF1ksdWCuu3cyYIPoOE99DZj0Le9xNxv2b+oF93AcjuQrJCzkcDg1DGUGVkr44JF1ADUC13mESutVyQH5P06zmCJRGlZ7RWLdfCDInso7YXq1U4DD9eUi6CDMHMvmuZhcUxPtzvhR6RCURkDJKGfPYRPFpZsvhXWdMF/8gnCxciWcF81E/Tge3pHErOCJUI0e+GF4+vfUlbn4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vqj+mroBHrkQ0EwD3SysRbwFNrJkw27BNlemznzsa0=;
 b=kcYKX2VHtNQBpVmQ6zFgFv/BTJkzd/mUjw9fh84L7JHr3lf7waE3Jzjep6RVZUZC6h7nRC/ZgcA1a4oh+zocHjTA8gSBNyrF7YVOuh2UotdaD7kYMTQgvtDzjHwABSbDlrNX2xfuGqu0D62X6sc9K+T04rfoqMT6GcF6uHJMBxWx2wLeqT5o7XSuAbd5J8D8kYBuyE1NpecwLZkaQL0XZWEAYiXbxBoquZzuVQ8DkYG9zVcF1Uc80spHK5PNjY/AW9O6rWpGqeMzhcW1mW74OM7WZe81oqPVl3mbSBdyenCSiJEryvdwdg6Jbj0iNsLt2nifF2kURVst78sRIB0IqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7055.namprd11.prod.outlook.com (2603:10b6:303:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30; Sun, 29 Jan
 2023 03:49:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Sun, 29 Jan 2023
 03:49:46 +0000
Date:   Sat, 28 Jan 2023 19:49:43 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/6] cxl/memdev: Add support for the Inject Poison
 mailbox command
Message-ID: <63d5ecd71307a_3a36e529481@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1674101475.git.alison.schofield@intel.com>
 <97a0b128d0d0df56cea1a1a4ead65a40b9cf008e.1674101475.git.alison.schofield@intel.com>
 <63d458e7eed85_ea222294af@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9SMtfBK6FRrgW6f@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9SMtfBK6FRrgW6f@aschofie-mobl2>
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e3a684-18a2-4760-bc50-08db01abdd07
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGFJvl0u2S8HDsXdZwW7jmpi0YrHqzxNgndsBjWcDrONGReVr6dRh+ERf/blp2paJgSwXKOzRnedGsrBUMTfChsmPccQpa3oGly96TidvVW6bp9VGkY6GwSkY/81cR3iBI7tM8QoTfifnAAerzG9mpvAkxqCdQXvmICuMQiskXAqb9m9FWDzmNGJu0tLlYE2uoztPZwgdK8xdaQypXaR21zdxtzWvff1U47vKFRnbpHzeFHoKPnopwbAE5ziWPGd/x8PiyG1FaRyqJ6sEY2WDSWL1kacGWScNk1paK+SK8/N6LYUqqZypwQM8CpyfRbUEbDicWbrYAiGQMz7OQEwkRZ8ltjHvMB/mrtOSwg6XwSF9xEaYz464mxXNnNSTO6nmgUhoxMK9vdKgWlZB4/lVXr5bCicnbg0yCn7I9HINWAwvMndARQuaSy+Ba2CSrOB81vEsx87QOfj0IqkznqDJWzqEFHlKdBz1RnCyahw3zJrIbZrVX0MlUfF44tXGmjP+Kv7n+Ja/uhbvD7TOXOq5KyKEaGpfr9G2wtLeHVdkBG9mggmr8O2ly+3m2n1aKCNhOTJ3TD3SaxlsuoV46fPqZuzNBiNpPSQ/pWw99u7E1nvkhsRAmk7zRnn9FlB6WgsdtRVgS6Iz2QdBj8kWi7suQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199018)(4326008)(66946007)(66556008)(66476007)(41300700001)(8936002)(83380400001)(8676002)(15650500001)(6506007)(82960400001)(316002)(110136005)(54906003)(5660300002)(6512007)(9686003)(26005)(6486002)(186003)(86362001)(2906002)(38100700002)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aq1U+6ZJetcTMy/1FRcslnSfDRDwQL6IInKu7yc9BxaGAZWq1gCpfKY8nK+Y?=
 =?us-ascii?Q?lSIMZiTU4EjSu1bnwPQeTeHDHVdX9VkY9mrkp77lqS71Tqom9CeOxBfbikDg?=
 =?us-ascii?Q?7CfN8BheOklV4kIQs53ufrrK4X/nb/Gmhv+Sb0OQ0YxIU0uIujb7GtrOBKyg?=
 =?us-ascii?Q?Kd4Fb7nizjauJ3r/237zu3v2XBMaOASX7dgfuMcMgPRfAOC6Tzss7TajXsEe?=
 =?us-ascii?Q?voR99SWeDoSxlTWEUjkLgoeXwDpmS7PEUFfl40z/rlNcEWvPfJBH6U7rs46W?=
 =?us-ascii?Q?bjTpCGpPhneB6Fr7iXTnS0XAwp0hmiDLee2aSUcCJZY12zARN2MMNjmpsL6F?=
 =?us-ascii?Q?sRWqwdYzX+xHDrtDa6KsI0PfARAdSFW+aETedD2T3yh7ebO7kULiU90ryYSC?=
 =?us-ascii?Q?H/cY7shMA124OHbFCNF3b8Un+c+DHY0jg+PLPajq5kbYScuKfNZUNgNEXZsJ?=
 =?us-ascii?Q?tar5zy8fMqKWkalXpc6HmQsk6VXvF85nkrX/JTUq5uBAz/fQuXOCHpeqmvpa?=
 =?us-ascii?Q?Y18XH0KThcE3gs+qsZ32R9x3WemSJlRyF855gQvtfGjjADWN69AEYTeI97KA?=
 =?us-ascii?Q?vtW3HDBxezLV7rWVZ+yztpDoYzcHC5zK6ouNDl3rOJiml8rRZlksJow+gy7F?=
 =?us-ascii?Q?YAwibw4jvJSOSiZDqwuAsZzl/A25JeAYm7vofWtwDNDghb3ck2kn5OF9lCJx?=
 =?us-ascii?Q?JiLvP2z3+x0i2hBz2Ye2+bnTtzlH1VrjbFwjOoanPgKQI0NZcZXesDAYUYKA?=
 =?us-ascii?Q?IF6CgarbIfiLxbfqH6p4XeBurvQMiRWbDEk5Qk5upt+hALmMgmsw2SUKByp7?=
 =?us-ascii?Q?1OknrBoFPIHUXdgcC6TIIbpTIsz1WwW/r1NLMH77O9LXyPFbeiQeV5PXltVl?=
 =?us-ascii?Q?XimO2PPojebHZQUdSgWcyLhJXv8Ul+YN0uE+bGHhS5BXFnn5MmPY6FAboQPd?=
 =?us-ascii?Q?+p4W9lyjqRJNNbfJxUlxSeRIcVSrH9rZaif+Szyf4/npYE+jqxOjASlFY6Um?=
 =?us-ascii?Q?8oJRyzs/uIko5c0qNw6ULeV3c5OJuFvQlFpqNN6pbDdzKq3e/gYVw8vk0Evj?=
 =?us-ascii?Q?KGtq0cGTefBdXCGDOa6lwO63IPbN0P/FNbE1QoLprLQKV6ND5BcZ9JuYCJQK?=
 =?us-ascii?Q?RXAeEeFXPmtywrZOuAZoyd6Z8p8fUH9nMgAkYHHgn0SqunOjeyDOacRA04Q0?=
 =?us-ascii?Q?SQPnkVf4wn3L7FZ1mOMs2zg/zBbluIQ5XM+bKy3YnR42yyD1L6QWSJBjUgew?=
 =?us-ascii?Q?+CkzSNkmzjvgC2vrQHfKizdHN2/0k5ilScZ8jFIWtagImKjdAQ6SmvJN8zVn?=
 =?us-ascii?Q?G3eVAFhAakzhjzMRcrgxbdZxwNpaDnN+eZDU0zrE27KfFL8P9sKm9riOOtT9?=
 =?us-ascii?Q?1p/+UFlEbCVKyGQf77Cv7sRqOCwhz0JOSav3vMVFajUN3+R9/Acj0aBjIJxX?=
 =?us-ascii?Q?ByvDYDbgukvtKDvK2UA5ogDVNOJx6VDeV8tTA6ZR9oW5L8waYx95lqi+0wZI?=
 =?us-ascii?Q?ePynwQA1eVfbeXJHK1Gx75pA/5kIaUPNDB1yjMzTbpcowkBCSYiPMOx6vqBv?=
 =?us-ascii?Q?tzOZ3H446fST0tVQAEfyVuEtn9paNVE6W47e/s4Fk6F/4SUS9t+0rcxYDggn?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e3a684-18a2-4760-bc50-08db01abdd07
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2023 03:49:46.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzzO9HxhW/lQ24IXy/+rSCtkdbWOcOjmFKeYKlnNKLg1FBWzjsudZVPvfOZC5D4SwPbetWPlHZ9H53PDBwhtb29+mdCqDYiHbhdOMdxv5eM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7055
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
> On Fri, Jan 27, 2023 at 03:06:16PM -0800, Dan Williams wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > CXL devices optionally support the INJECT POISON mailbox command. Add
> > > a sysfs attribute and memdev driver support for injecting poison.
> > > 
> > > When a Device Physical Address (DPA) is written to the inject_poison
> > > sysfs attribute, send an inject poison command to the device for the
> > > specified address.
> > > 
> > > Per the CXL Specification (3.0 8.2.9.8.4.2), after receiving a valid
> > > inject poison request, the device will return poison when the address
> > > is accessed through the CXL.mem bus. Injecting poison adds the address
> > > to the device's Poison List and the error source is set to Injected.
> > > In addition, the device adds a poison creation event to its internal
> > > Informational Event log, updates the Event Status register, and if
> > > configured, interrupts the host.
> > > 
> > > Also, per the CXL Specification, it is not an error to inject poison
> > > into an address that already has poison present and no error is
> > > returned from the device.
> > > 
> > > The inject_poison attribute is only visible for devices supporting
> > > the capability when the kernel is built with CONFIG_CXL_POISON_INJECT.
> > > 
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-cxl | 22 ++++++++
> > >  drivers/cxl/Kconfig                     | 10 ++++
> > >  drivers/cxl/core/memdev.c               | 67 +++++++++++++++++++++++++
> > >  drivers/cxl/cxlmem.h                    |  5 ++
> > >  4 files changed, 104 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > > index b715a4609718..e9c6dd02bd09 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > > @@ -416,3 +416,25 @@ Description:
> > >  		if accessed, and the source of the poison. The retrieved
> > >  		errors are logged as kernel trace events with the label
> > >  		'cxl_poison'.
> > > +
> > > +
> > > +What:		/sys/bus/cxl/devices/memX/inject_poison
> > > +Date:		January, 2023
> > > +KernelVersion:	v6.3
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(WO) When a Device Physical Address (DPA) is written to this
> > > +		attribute, the memdev driver sends an inject poison command to
> > > +		the device for the specified address. The DPA must be 64-byte
> > > +		aligned and the length of the injected poison is 64-bytes. If
> > > +		successful, the device returns poison when the address is
> > > +		accessed through the CXL.mem bus. Injecting poison adds the
> > > +		address to the device's Poison List and the error source is set
> > > +		to Injected. In addition, the device adds a poison creation
> > > +		event to its internal Informational Event log, updates the
> > > +		Event Status register, and if configured, interrupts the host.
> > > +		It is not an error to inject poison into an address that
> > > +		already has poison present and no error is returned. The
> > > +		inject_poison attribute is only visible for devices supporting
> > > +		the capability. Kconfig option CXL_POISON_INJECT must be on
> > > +		to enable this option. The default is off.
> > > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > > index 0ac53c422c31..6541f54725cd 100644
> > > --- a/drivers/cxl/Kconfig
> > > +++ b/drivers/cxl/Kconfig
> > > @@ -129,4 +129,14 @@ config CXL_REGION_INVALIDATION_TEST
> > >  	  If unsure, or if this kernel is meant for production environments,
> > >  	  say N.
> > >  
> > > +config CXL_POISON_INJECT
> > > +	bool "CXL: Support CXL Memory Device Poison Inject"
> > > +	depends on CXL_MEM
> > > +	help
> > > +	  Selecting this option creates the sysfs attributes inject_poison
> > > +	  and clear_poison for CXL memory devices supporting the capability.
> > > +	  See Documentation/ABI/testing/sysfs-bus-cxl.
> > 
> > Could maybe clarify that this is meant for hardware debug scenarios so
> > that is the reason it is disabled by default.
> >
> Got it. Thanks!
> 
> > > +
> > > +	  If unsure, say N.
> > > +
> > >  endif
> > > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > > index e0af7e9c9989..226662cf3331 100644
> > > --- a/drivers/cxl/core/memdev.c
> > > +++ b/drivers/cxl/core/memdev.c
> > > @@ -142,6 +142,61 @@ static ssize_t trigger_poison_list_store(struct device *dev,
> > >  }
> > >  static DEVICE_ATTR_WO(trigger_poison_list);
> > >  
> > > +static int cxl_validate_poison_dpa(struct cxl_dev_state *cxlds, u64 dpa)
> > > +{
> > > +	if (!resource_size(&cxlds->dpa_res)) {
> > > +		dev_dbg(cxlds->dev, "device has no dpa resource\n");
> > > +		return -EINVAL;
> > > +	}
> > > +	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end) {
> > > +		dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
> > > +			dpa, &cxlds->dpa_res);
> > > +		return -EINVAL;
> > > +	}
> > > +	if (!IS_ALIGNED(dpa, 64)) {
> > > +		dev_dbg(cxlds->dev, "dpa:0x%llx is not 64-byte aligned\n",
> > > +			dpa);
> > > +		return -EINVAL;
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +static ssize_t inject_poison_store(struct device *dev,
> > > +				   struct device_attribute *attr,
> > > +				   const char *buf, size_t len)
> > > +{
> > > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > > +	struct cxl_mbox_inject_poison inject;
> > > +	struct cxl_mbox_cmd mbox_cmd;
> > > +	u64 dpa;
> > > +	int rc;
> > > +
> > > +	rc = kstrtou64(buf, 0, &dpa);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	rc = cxl_validate_poison_dpa(cxlds, dpa);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	inject = (struct cxl_mbox_inject_poison) {
> > > +		.address = cpu_to_le64(dpa)
> > > +	};
> > > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > > +		.opcode = CXL_MBOX_OP_INJECT_POISON,
> > > +		.size_in = sizeof(inject),
> > > +		.payload_in = &inject,
> > > +	};
> > > +
> > > +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	return len;
> > > +}
> > > +static DEVICE_ATTR_WO(inject_poison);
> > > +
> > >  static struct attribute *cxl_memdev_attributes[] = {
> > >  	&dev_attr_serial.attr,
> > >  	&dev_attr_firmware_version.attr,
> > > @@ -149,6 +204,7 @@ static struct attribute *cxl_memdev_attributes[] = {
> > >  	&dev_attr_label_storage_size.attr,
> > >  	&dev_attr_numa_node.attr,
> > >  	&dev_attr_trigger_poison_list.attr,
> > > +	&dev_attr_inject_poison.attr,
> > >  	NULL,
> > >  };
> > >  
> > > @@ -168,6 +224,10 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> > >  	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
> > >  		return 0;
> > >  
> > > +	if (!IS_ENABLED(CONFIG_CXL_POISON_INJECT) &&
> > > +	    a == &dev_attr_inject_poison.attr)
> > > +		return 0;
> > > +
> > >  	if (a == &dev_attr_trigger_poison_list.attr) {
> > >  		struct device *dev = kobj_to_dev(kobj);
> > >  
> > > @@ -175,6 +235,13 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> > >  			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> > >  			return 0;
> > >  	}
> > > +	if (a == &dev_attr_inject_poison.attr) {
> > > +		struct device *dev = kobj_to_dev(kobj);
> > 
> > I'd move the IS_ENABLED(CONFIG_CXL_POISON_INJECT) inside here so just
> > one spot in this function handles the poison attribute.
> 
> OK
> 
> > 
> > > +
> > > +		if (!test_bit(CXL_MEM_COMMAND_ID_INJECT_POISON,
> > > +			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> > > +			return 0;
> > 
> > Ugh, this is a problem. So "inject poison" never should have been
> > enabled for the ioctl path way back in:
> > 
> > 87815ee9d006 cxl/pci: Add media provisioning required commands
> > 
> > All the nice sysfs interface and compile option to turn it off in this
> > patch is moot since userspace can just send the ioctl if the sysfs
> > attribute is missing.
> > 
> > On the one hand this is already shipping ABI, but given cxl-cli has not
> > been enabled it chances are high that it can be deleted without anyone
> > caring (i.e. breaking deployed configurations). That would need to be a
> > lead in patch.
> 
> I'm confused on how to kill it.
> 
> I see it in the enum here: include/uapi/linux/cxl_mem.h, and I also
> see Ira's patch reminding us not to break backward compatibility on
> that enum. Do I replace with dummy entries?

Right, they need to be converted to "deprecated" entries that keep the
command id order intact.
