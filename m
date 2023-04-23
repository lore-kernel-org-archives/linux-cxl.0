Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3E1C77B60
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 18:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjDWShE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 14:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDWShD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 14:37:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C74186
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682275023; x=1713811023;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N65rNOoIyc19c8At4TKpnbp40EuDSLWbJ+J/QL9WGlo=;
  b=nHMzSf4cUZ+wGOVCzGMMMZDQm9pL6BfabCmoOHjf8PyE4Qr+Z9MkCnX+
   FODJ1Z850DJu/r7YNiSQoSSZnMZPR0+5bhGt/iL8nakHstoSPc32oonVF
   83wVOl/vPO1T3K64xk97MvxITM8YB6iu7bV0UKiMhFw4d3FJtlrnP/ORd
   FwW/9mS2SkCj5Ra/pG2qs8mOEnkI2xhvVK/VnOC56w/eJt4wys0m+wbnx
   uzZ7F35WHwXrmsVvITEiQT0kdoflqgyGNASScww0CaDsWlRYkRtx8Swey
   KtyGZ4V5SdHXwbNroYMkVMIsyjiFXx/DQGNjfqpxpdeQrcIa0ao7Dp3Qw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="335189286"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="335189286"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 11:37:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="804355283"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="804355283"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 23 Apr 2023 11:37:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 11:37:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 23 Apr 2023 11:37:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 23 Apr 2023 11:37:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoqAHjKO20HV7CaqRqAtg1neSxwLpJhRablEH7pjG+dcGf0LwihNYxW/NXg2uOGAtJcxGpXBkRyKmjyiSEhgRwO68MiSEqRpTdn6fMKi0UvxTf1mL3cKdzIn1AGnTWLrM0IWeFgcXLRPzoPf+l3Yi5Hi2U1M0YdQB0HU+WOfLYGtqUC3e7kJWxsyTqS3lmQVDNqmfP2/T7wRvYPrG1/AXcKy+/eKU9/P1YSjRLww7IrJHfV3YZshR+wcvYHNp3WBsmNIZrdDQ0HpdiyVJxDikgqRLxyrNZgaapscti5Tm1k1s48wNehLQVEJVhfMPYgOHAOADmMUU51Ri+Ez9w0UFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Utif7UdOBx0agHSO1eIvFFANLSdZMtfSh3yAx0HhAFA=;
 b=Xc+sDto9yk6H6In7eb6K6o0ujxLAs1rcO4Jib+OUaRlh2UZeevBO5W3DgxbWpfgeQdLjjNdIoOi85tzp2JDVoGoKAI95Fmze5e9t1m28BJOWpmGbq8tzC8Y0YEsAJHeNSv7q6A9q7wzuDXJLNnq4Vfg6kshcw/bMjMmytLOI2ZeJ0dijCeVziivlQQxmMb+hN5mCXB4Wi7w5Z7x38p00yw9RQmGdwn4JvONYC/ccmawbp8+gFxeXKxdlOcCSRznBY9fEuB+BoTPnUah/SNzrEXi6lfKKjZ5Vw4vYUdJYBNrvnfGQ9o98aNNqK4fYMQVgzQudOPXhd4ZHkSAocEvP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB5945.namprd11.prod.outlook.com (2603:10b6:806:239::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sun, 23 Apr
 2023 18:36:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Sun, 23 Apr 2023
 18:36:59 +0000
Date:   Sun, 23 Apr 2023 11:36:56 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v6 03/10] cxl/memdev: Warn of poison inject or clear to a
 mapped region
Message-ID: <64457ac8d3bb6_2028294d@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1681874357.git.alison.schofield@intel.com>
 <f911ca5277c9d0f9757b72d7e6842871bfff4fa2.1681874357.git.alison.schofield@intel.com>
 <20230423163528.00004c17@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230423163528.00004c17@huawei.com>
X-ClientProxiedBy: BYAPR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 3336b9bc-b421-4b86-920f-08db4429b8e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RpiV8vr+31VRlxw6c40xGn3TOz0nJq7najjL7tVRm/FfXRBGBPH5xvPRi/vcgXQPHvwz5JzQIDcLEl5NTQCGktV5N8ZfnMjUbzLtV3lKVClydHwJ5S6uN3zAZe+b/rN9iZIrILaa5EM2uuq6FCdHCKOxJa0nPPqXNtJJRvaVcKgzsjrvuLX0ZPOB6xpnqrUwxdVyDrZ4Zh7y5RDAUU8p6PBAg8tNmePj+yQI9PcgiAtJw0havaFibGWoDlV7nfl6eBJEdqC9URbSqlz1QSZq5u3nWCtdGslK+5pF7xPOSSM1utxk2IiFFLgOStueB/qC7Q9LRyEwCRsxdkxdxDr9zsnxag3ljsm6tZgnI8mVpfzndaNSo0DOByTTrwCYe0lGEzFf8HRrbnuH8E9Wwx1P8N5j9KppOBJ3MGdVawHUAJ2/swD698MsxT/TsA2fpACv2Q/sPT/FHKLNX8x+s4sz1vVqhLk+WpFCR7FRUu1QNM8bb5L925NmxgcGu6bSV/3Isiz4wmFDWivl2O0cp9I1Lxq9YD8X1hJDTqwDJcv8obJ2wBnlU76IFs9nijMFnljRhDsYT5aZYLgRGTUnGdwEFGZ3dSVgcFMAcVNxJjVY+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(186003)(6506007)(26005)(9686003)(6512007)(6486002)(6666004)(38100700002)(66946007)(5660300002)(6636002)(66556008)(41300700001)(4326008)(8676002)(8936002)(66476007)(54906003)(82960400001)(478600001)(2906002)(316002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?teZv8+X7Z9i5ks2Jn/0vTSeaUFpWoFzbO2Jap8JPVMFPr5oF1yuFm3AcHVIz?=
 =?us-ascii?Q?Pwa0JZ3sjZTF6CdLa5i/VrNhB4P4jdJ46B/N9eAkeiV908YGFxya/ZwZemIK?=
 =?us-ascii?Q?Kzc/Nh5OiKqZcGhOmAI2Ze8JJBUGG8p/z8fEDHiXJq1JfTsJK0908HCnB9zA?=
 =?us-ascii?Q?WAPaICYXV5BLUqjDwHSIMSg1bFrgbUe1fBh9VXkG68lSprj5lFQzpKug8YYY?=
 =?us-ascii?Q?zx0eH1OkxM4kjZn8qMNEbp/Rize1V0hxJxoS821nMQFYhyPXQvmh4cxGOnan?=
 =?us-ascii?Q?Asd7+EQ/N9vEK45YXXrySE8KnaX8YL8c6BZ1cC3QDFBA4v7k5K5pV4Iguq8+?=
 =?us-ascii?Q?FTDGysdSN8JsvimcpVkWJUBjHTfCOxZ5j+8gZP1nJxsv+pYXqZbV5v3eTT6i?=
 =?us-ascii?Q?ufqhPM4dHk6bJzvrquNpQptZivGjuPVR2Qejh8JoUqmaqnde13sBDK8TqFT6?=
 =?us-ascii?Q?JE/JKI7R9P/x3a7bDsIn5ZtJmNj+P+BVicabhvjPLjDo4rr3UpGEl1mHNziJ?=
 =?us-ascii?Q?oMuAzTb6uj0lou2TzaXqRX5f4QVJsopF537gyeEpFZuZu+1hwm9PuwnNbTCd?=
 =?us-ascii?Q?lG0ner/GUW+3t07r0CN5pM/9szHpFM4fe+Rs3W1UwRJ6KStMKpLDyjf733Yz?=
 =?us-ascii?Q?aH3CN+adShsVKVSUk94RYs8cb7WUz9SQypTmKYodMl1iLuvWsvaoQYa3sjhu?=
 =?us-ascii?Q?SFpNYWzdkaQqDrJ4AhZ2F21QGQ8KUcvoiztXsAnZ/b2mhMv9d9C9TIzrRQQB?=
 =?us-ascii?Q?GjZDkwvwwBLSxCjrKMJaXKwC7Wst3PiIlPg2JUFsCKzZUcZUW0Xckr790rBn?=
 =?us-ascii?Q?EeO/hSZlFXolpKlUFyBaMxmijF1AdjoBT+ayCPdILQiwpsic46UVwTHabttE?=
 =?us-ascii?Q?m22tDVPOWwjU9LjpyIdnKe+pePxOEuPFvC21SnW8pYDoBp+AUaV6/eaoq6jY?=
 =?us-ascii?Q?6ZYUXriAYc36KJB60yTcAkLMG0kUnoSfXYezeaLqhfZVSQNsWZd1v9f0AMFB?=
 =?us-ascii?Q?37bIKvwY2Es51DzSv0ILw2CSvvAAqY9lQ9NHMtb/Gda/qsMGdMUxItDdTdKv?=
 =?us-ascii?Q?JWc4wUS5ycZHI+eNsGLjVzahH9V0LdUjwDfBc4QjA0VWlJQtZGjRkLmiIImh?=
 =?us-ascii?Q?LUP8eYkwXF7hcEIKpdjJSStlAcYf5NLeIFJ74OmruhT1tCiqqWMoM226uIvW?=
 =?us-ascii?Q?596/VNs6XtkMODEF2M4uTIQ/d9/jma0FyPUVmHkUBelnWnjEp8lUjil5lvM0?=
 =?us-ascii?Q?C4IeAIz6pPh+L+1CRoovIVz92yGSWc+LYOsjzSN2dIDrYU6Hm06+ZmfIq2qw?=
 =?us-ascii?Q?Pu4YYqEKhAobYaTRiP2x45IX17MkCO6WG1qhJPNQstqdYhiHUyudx3uJbl9/?=
 =?us-ascii?Q?BovBvwMAfFGrVm/XvTxxLWiua3KVyP4rnoj+FHG97Y7nszMiwQOg/R2zldk+?=
 =?us-ascii?Q?SVSu09dAzNAKn3PGCGzBiHvRDKmo8OAKku3JGXkOgn+mmYXV13viu33EKCP9?=
 =?us-ascii?Q?V5fw6yfuVQY9Xl4dJBTYpWhntVYXNv4CNdjQZNKS5dNIkvauilFAmtQoEvjm?=
 =?us-ascii?Q?PDb2XVgmKtVD0CY5jZ2vXm7Ttd74ti5nuquveTRLbwBSlssedSBl6wm0dcxh?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3336b9bc-b421-4b86-920f-08db4429b8e4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 18:36:59.1348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5o1W2IAuyBm4Qf6JPM96URrzoKyD1w1yM7UVBwwU8W30ZJwX4XxTH29I1Nn/Bo5pI7qPUzWbuGPYNulAGvZYRP8lAaVG06MO3m6UMSac4Lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5945
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Tue, 18 Apr 2023 20:26:27 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Inject and clear poison capabilities and intended for debug usage only.
> > In order to be useful in debug environments, the driver needs to allow
> > inject and clear operations on DPAs mapped in regions.
> > 
> > dev_warn_once() when either operation occurs.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> The warn for the clear says it's injecting poison.  Other than that.
> (I wondered why I got two copies of a dev_warn_once() message in my
> test kernel log).
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
[..]
> > @@ -252,6 +305,11 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
> >  	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> >  	if (rc)
> >  		goto out;
> > +
> > +	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> > +	if (cxlr)
> > +		dev_warn_once(cxlds->dev, "poison inject dpa:0x%llx region: %s\n",
> 
> Ah. This had me confused. I got two warnings from a dev_warn_once.
> 
> Should be mentioning clearing for this one not injecting ;)

Will fix that up on applying. I also notice that it is spelling out "0x"
when "%#" will do for the number format.
