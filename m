Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C058FC77B6E
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 19:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjDLTQV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Apr 2023 15:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDLTQU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Apr 2023 15:16:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6813B61B6
        for <linux-cxl@vger.kernel.org>; Wed, 12 Apr 2023 12:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681326976; x=1712862976;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4tXBMHCMvX5yCwQas3tmNebtQgrGYr9h3OTJW3G0jvg=;
  b=jNdJJJ6C3Kf6oTZPsvCyZyWbkl2A5CxqDNkMbGWTy4tldcrvL1gVcrgR
   3i3A3sDv/hdEbSIuLHSwJL7y/oB3va/zz8kTY8K0ASY/rmSeTPEgmd89t
   /kMliapuAKUMypbuopKlzaeiXP1MHihhz6xdO+IgaSOTNLG4c9lEqu54g
   gZ7mYU7C565kN3zzHex/WHJU6pENNy9pJGAGVc7wts4A1u2f3ODVXwk3c
   TPVCdRu10YsekZx8P73E9bsh53do4YAFdcVy7XPCMXcoYyPzhTyostDZ4
   pgeijJed4wMpXrNxb7npXQ1Eepg/SLVXBLr3c1zr1zl/lhbpEmLK7ZDwU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323620168"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="323620168"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 12:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="758357517"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="758357517"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 12 Apr 2023 12:16:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 12:16:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 12:16:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 12:16:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 12:16:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z39ErfwboYUkdG28b/j9Sz3h5quHOBrb37pIkQYIOJFFzkydpQ3shMHoy5fMgnsz4FLEs3kRIU3PM9bhpk+5N9rRX2Wbwu6fy2u11eD3b74gTrXiejUCvoSraMBNIqodh+6PwuapXtSwOPD/SFryhpMArfkFgRUOFwCAG+qZ1pBbdt/bl9cRhjIuEA27dK6qw83QwvglWcZMtdT/9aJCQa2ZLzhDXMSX3ASYG3uba6ZQbXdmJs5CElFN8+REnd1xH5WjhWFWMk8cq4476yjC8WIjKebqzWisMSV1NrYuzR7p50h0rwxjAeBXQ3Yw0VhE4sc++cev/d5tpNfa+EoF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7yDKvirAZtvp9Xgb3YATbZix2WSx9Q09yOjEVhUWv4=;
 b=es3DftzGm2cRol0a7/TdaOKVFfc/iMQ1neCFB5qSLG3h9cSIS+zaAnSvVRiL1LjSwUdarLdv4GqXtXF78S5khgfm1vCWN+8/xMwimUnBg84cBzSUyepK7y9vmMuxhj+BUiWqnl2Id0smiuK++WaQFqmUQlNjLIr9a6fCYQXe6WVkx+GFyjWJcstiMGbOf2uIe4/OnNwAshbDl5Wq4L9Z7Pb/gJi9aSPEXL0MVrog+uv6E3FIyiFIYK50oRJuXFuyinlEO5u+CoCUwsT+AhxhpdN3qJrtMGRXxfdOT59NsEMUoPt905tk7jDeEMhyIZ8x2QJe/zOIWmUxMZbyM/RoxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8231.namprd11.prod.outlook.com (2603:10b6:8:15c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 19:16:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 19:16:10 +0000
Date:   Wed, 12 Apr 2023 12:16:07 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v12 1/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <64370377d9051_5f75629440@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1681159309.git.alison.schofield@intel.com>
 <e87e1792e147a46f348019cc772e06f2ea19e970.1681159309.git.alison.schofield@intel.com>
 <64360dcc59cb0_417e294de@dwillia2-xfh.jf.intel.com.notmuch>
 <ZDY3dR0vA6+zihxN@aschofie-mobl2>
 <64363f30a6370_417e294d0@dwillia2-xfh.jf.intel.com.notmuch>
 <ZDbx7qjw+SP+6sSe@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDbx7qjw+SP+6sSe@aschofie-mobl2>
X-ClientProxiedBy: BYAPR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::44) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: a880252a-75fc-4fae-6c2e-08db3b8a5fc3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dz+pbPISlQsGe3nWrHTVD+VrOYbDWJS7tXTSEkbECANHWcu4iZg699YsNCeHLjB9YbrG+3hN3TBdgfWB1RjaXh/VzsCNS1NaI0wEa8ZqzE897v31kODc9wOIuZbRKd6pxmgwS4bLekuAaO8z68wVtfFz7Bn7S3Z/9NQaTBBcu5HDjYC9o/KH2ojDugPlvFh6o4Rppj4pfjbkjYOe64CVc7FNqsiqzvOATP/R28Zbt43/PhkXwqb1I1+AOenzHIKHXN9WVePB3ZZ9QRLp2uwANBzqoVDZSIwOSvSz6RzEHy54B48vCLEHAN/MCl9nxYeotj2Go/NqD3gyS+MJhGTlxt6r+hmxpEBvFqDArAmISsJXIy5hqUnM/v8qqhLky8VWerIovuttkbMbNCPgBekN4sju5lE1mwRmmnt3BYlJV5hr0GVMWLld8WZmVwGvjZIppJ2w48xigk7QDz4VZu+kgYr/LIzc24StcIef12hJ1p0KSgnIz2g7Co4nFhawiNzhf+rUARZWWEKk3dXMdfHM9EPfcMEqBL3h2RVDnD5ULS8o7qvUTZ7t96bhwoDdSLy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(8676002)(38100700002)(5660300002)(15650500001)(2906002)(86362001)(8936002)(4326008)(316002)(66556008)(66946007)(82960400001)(41300700001)(66476007)(83380400001)(54906003)(110136005)(6506007)(6512007)(26005)(9686003)(186003)(6486002)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zRM11bm+rfOf+7mE+SLvqOxCXRjC2RecloarNgfa2GFnIHt0LMoqL9HwegP9?=
 =?us-ascii?Q?D7u6mEfXi4vLZ/rUuMhRfRuA+mpm6+uAAUvhi5Nydu4T/A+eJlvXhUd+rfP2?=
 =?us-ascii?Q?Si/LSS/LtI2uVnk462aHzxVYsnZj7DggoJkLw+HeUTEz9U9Ni54n8o/88nIb?=
 =?us-ascii?Q?7rffvsiIBSM8q1RE7dJcWBYVGckds08bu1q0DO8SKZg++WpP/psWAj2p61pT?=
 =?us-ascii?Q?n9eBdeLYgMCcyNY562a1C248/8+AZTVS40PLZVUS54dv1W9KyszGFJXqoViz?=
 =?us-ascii?Q?XuY6uSWn5xxmHlReRngHISApYeNrtOYhiBf8Jx8LvHcMlCpDSPNwO+LQivBr?=
 =?us-ascii?Q?FYyhD9etRutMCsqZEA/hAcqfN3pZaooCnlIGTl+BtZ5JbzCWS+sHP7x9kBzK?=
 =?us-ascii?Q?r66fpHx1WNppflSSKCJ3d+1y16QgKyH01fWpmbyG9PipiFMapMcyTcP9WCqJ?=
 =?us-ascii?Q?YUT+uHBGjOM13FH1ALx7Hke5FI7/nKDLiDp9PddV5wZMbKuFDz5KBrtVCMKE?=
 =?us-ascii?Q?ejXCta+nqqqLB7qjywoOJvNwOYi+Ys71127crXBhxMPrc1FVo7yl1zqhzrxC?=
 =?us-ascii?Q?MHNA5mbA9FB+YQucatBQYc1mWYVWSwQgH6LLJA4F2MfjPKrUy8BWBRrALait?=
 =?us-ascii?Q?LqqxaqU+YhikFxY8ISMjFF39y028sPKVtkfpCOnw6wpoyTm1lR/YvhoXP6jX?=
 =?us-ascii?Q?pA5wDUEsigYxHX5op6rNd2oKK3W6JltNE6fSzH5G1e/WMHzbSVHxXT8lXy1D?=
 =?us-ascii?Q?oHziR0lqPfXNM4y9ForrGzIK8qC5pawH8oKTcAuws5ab3Z6RWF7ogqr6XHT8?=
 =?us-ascii?Q?C/j78X/M1bq6GL+DcWp1ETcPWc1FHI9G8PpG426bTO+0RKlUGGjaz4/mLPWb?=
 =?us-ascii?Q?DXIAyvjiYwVYYpsY2A3nRAMeRurY4C29Ie793XFOsBw63os8piqQAXnyoCxu?=
 =?us-ascii?Q?Qlx/j+d9QM3ihhBsCG+UV1hSpcWoh1PipSmxpahxi5AG3M6M+2IpvKsC/qwp?=
 =?us-ascii?Q?/oQ+A1tF7iO3OE/NtcbK0n/I7Z4++AcW1O1IlB/9PsRihjktXbahof20NJfD?=
 =?us-ascii?Q?g5IHdKO1XqGO3EYujjMbklH6wnjTaFqtxu3pEOzmTJx78bcO793XMUB57BV1?=
 =?us-ascii?Q?qtgYLy//Z0vMc9jxoJkFfHi3uNC5t8USuEdNwaMokEDe6+pxJnzpbqzbqVfw?=
 =?us-ascii?Q?s2tv+KN+q/i+urJyggorkb3PBVwG9SZyGUZY4zpWEsE25QMclkGMYGmLJaC3?=
 =?us-ascii?Q?05LSpT4dyEAzKW1OyP87qdilbXCpdxCnDIIyd8hX1DDn4o/AmsiPRH3T1t8W?=
 =?us-ascii?Q?7K8zZiNqyOcdqqxWKz4j7Q9BZQD63vRyrmveWC5b6wRL26Emqv2sN48cekZu?=
 =?us-ascii?Q?F4RCR0NzF0lCYVzYjm2dYud1rb+41Ny2qulPsYYVt43H/uqHmyEEAt8/l7Ir?=
 =?us-ascii?Q?WJvPnx/DdQbWGMOyBtB42cSYWNNKbipLpkSFwQvITtG9LVRApiP1bcVNpY4C?=
 =?us-ascii?Q?LI3y8q0GR22VZ4hxyUcDFMm4iNOkjcu9nWJdIca5tBrn+6lewI1Io4AOfQO3?=
 =?us-ascii?Q?22z7eJN0pLhH8HUymk3PFvYzSE/0gKWgyenxtAy3QTm0SNIO1XPiFGiEZMSL?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a880252a-75fc-4fae-6c2e-08db3b8a5fc3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 19:16:10.3502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPN/nUUimDIn7aONs71ukitXDZSZPU4nlqA1JXcU7FJixT1eCkPLOYHRnJRPQzbRsBv+1x9yDOOV/Ev2acXSGAZK2HcowZFyGHZWIOSnLls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8231
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
[..]
> Once we deprecate, is there a way for users to determine what commands a
> device supports?

I think this discussion needs to be careful about the word "command"
there's the Linux CXL command ids and there are the device mailbox
command opcodes. The Linux commands ids are usually, but not always, a 1:1
match with the mailbox commands, but the functionality that the mailbox
command implements need not be wrapped by a Linux command id.

For poison retrieval the user will know that the device supports it
because the poison sysfs entries will pop up. For DCD the user will know
that the device supports the commands because the DCD region info will
show up in sysfs. So, CXL_MEM_QUERY_COMMANDS is only a mechanism to
enumerate the Linux command ids, the way to query device functionality
is via a combination of CXL_MEM_QUERY_COMMANDS and sysfs.

> 
> Can you post that deprecate patch preemptively? I'll update the affected
> series to follow it.
> 
> Please include SCAN_MEDIA & GET_SCAN_MEDIA in your patch for the same reason. 
> SCAN_MEDIA_CAPS is harmless.

I was going to say wait until the scan media kernel implementation shows
up, but you're right the sooner we deprecate the better.

>  	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
> -	___C(SCAN_MEDIA, "Scan Media"),                                   \
> -	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
> +	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
> +	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
>  	___C(MAX, "invalid / last command")

I was thinking you would pick up that patch in your next posting, so go
ahead and pull in that update.
