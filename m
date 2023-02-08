Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14358C636CC
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 01:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBHBhN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Feb 2023 20:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHBhM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Feb 2023 20:37:12 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887BA11661
        for <linux-cxl@vger.kernel.org>; Tue,  7 Feb 2023 17:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675820231; x=1707356231;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=83LKD0xNgTio130xFXtPNS4aXKA0Y4p4jhGmIpnzPm0=;
  b=npuSm5Q5vLPmPliK6N4sI7GGtcgXfXdRuxjq+DFCUhDNWWAL7SVxjWu3
   sM6p9VdAMyokYxP0CRKqY50L9L83bG68u5c8kY/0VNQxmrOd7N0//5zxF
   FEyoXQeMpmriWAmpiFCZnRmOzPjmAPYqqK6ArnPAh3dguxU3HmyRQxds8
   mG+AuHTmgcKX/q4oN/4sF71LKMH9fVnLf8BJqpCv3oN0LYdysSiMLhapl
   Of7gOgVFa6ordKAoZnqRYDg4WoNcTflOJn/wd6ESgXZG0dxNvIiytdJ7I
   TGR/nTXOkDq7X9geIVhw7NWpvdjR+SPnvpErUjLcuB9V0FILm2CvdK7ok
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="331810472"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="331810472"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 17:37:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="617025508"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="617025508"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 07 Feb 2023 17:37:11 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 17:37:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 17:37:10 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 17:37:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VK6d5fWz2cLYy4ElXM/DLV5DvQs9F2FgKx724CIKdavo0GL1y1FD+uI5BYPdW5aOl2uyzEL4iN7VcSFN21bO8TTLDEeHxt+9UnzyvWg3nGXx5wg+j9vz+mZ9M2NjuW/YoRlwlM4T0UiefT0fcM2svobn+ULDyqkAHLowjn4mzT2twaBoJPBOVBvBziToFEE7oohFAi3pBeowRS5/kgHqx0TH060Q2hs840MilCfJC8XGKr0HVdDxbZLp5u3GRgVL0R+riWwKYD2J9bfAODBvCmVC78HGSnbKHAzn8ou2YLKI5bMUGB1Y88YL4roCjvbCmceR1g8SL6d5WIJ5aNR1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pk2lfouxcADstNcqeDxd/9vZOoOjgJ2BUnuqD05Djk=;
 b=HuOUOrNF8gptjdqYs2hJCLRZun0G48K5P+oIux04QzPIsyEzsWcfdFfZEC13q18SdC7yY18KeytTu5S8MwGH1/b380PQurNJKDtc0vLLVWsDDRUf6HiRFXY0qzwuREzYCydFWmb+12WJvepqOqPLa9LZgTOIjHAB3TG4Am9yXyu8a8Mbp+UIm2L5e4kRgxCsr/ZJdpU/y2DMbQ/oNKO1rN0hJll8dti+IuKKEhld/WOtCZiBiopKktPw+YjDk/ECVORqywRXvosQ8KVl9AhYlZV4WZ01dTsBM7EzjDAIf0V/ygIsYe6aCG6GvRoCjQ8OZn/bVFXqmFwT5gsaztqXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7211.namprd11.prod.outlook.com (2603:10b6:208:43f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 01:37:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 01:37:06 +0000
Date:   Tue, 7 Feb 2023 17:37:03 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v3 8/8] cxl: remove locked check for dvsec_range_allowed()
Message-ID: <63e2fcbf8bcda_e3dae2943b@dwillia2-xfh.jf.intel.com.notmuch>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
 <167406536836.1455071.374208676614721474.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167406536836.1455071.374208676614721474.stgit@djiang5-mobl3.local>
X-ClientProxiedBy: SJ0PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: b59ca9e7-9712-4cbf-c156-08db0974fc81
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCqaA75Z1VMgTXZxKhmK/mhi81uzXhOHDNqsZb4G0Oz8A2QVeUH6BQfjo0mEbiq7HlqYsj/tRWPwZEcoAKEtc51K95cCag80HOj3ZUH4svcAZ/gvpVPlUymSGasSHGfvD6TCtsjUFKHiWITzuC7iKbUEJ1zaGuNlzx0oEfE08Jliiy+MJXSvm6iUkXdwdSoBVadEQd5Bk6zXow8BZmwNEVNaqzGuHvLDaRcwwK91KMO9kWLO3FdGhzGp6+MDmFuRQwU8CZDbC3AbIyd2+xITuRvYPRjkiT1RdgbIMPWqpeTxGcNXR30pAPP8yWCFv8zIsIAX3moQutGQeSIKZ5Bnm8ZRAKnTJZtazrXDV4IBeRDiBKjmBMchJ8v2qV5hrFvqgVXeUcaZZamGFedLTMiGX6deB8WehFoNdSvp56s4RjxaeDBy6wlj7WIHCdzeocJKHLSnfIHWbsuBRGAalczALDLiOI8IPh5yD4AnpQ7cH9noMFJhCEIveL+kKn37htciAB0GjjT4LIMk/tyxJ4fWOFGCJtKTXAms8n+3gGwCg/OYEh7S87ZxJLDIjsPWoMftDxkk6qPZs0xczwWrfV2GQNmAac9sfv6unLIUsR6jGa7Pi56O+HUa4EYSjT6sqGLiABBqmKyDqp6qCgsIx/4tNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199018)(82960400001)(8676002)(26005)(6506007)(6512007)(186003)(9686003)(6666004)(6486002)(86362001)(66556008)(83380400001)(4326008)(66946007)(66476007)(478600001)(316002)(38100700002)(4744005)(5660300002)(2906002)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CSG/H4tw5rP6eTA+z6aVD8a10Gsv1rDXmEPcqTfw7EnaekUtPj9l/eRI3Nvb?=
 =?us-ascii?Q?V010R6YzJ1vwqJQuMzLbwNwqvJMF5siRpBRtqZUliS6p5pNAd+0R2VTEF+vK?=
 =?us-ascii?Q?jrAR/nqlEdB74GIm0QRpfSS5KNh/Qy5tgVzZcZuXgTrokul1wAyFhEQV2GeB?=
 =?us-ascii?Q?QUxykxkjgyvhshee1Z7RtveZ1/rmLVhHChMPvTAxGPibgFxEe4sCiePndYvl?=
 =?us-ascii?Q?87X63fEe2Drs7iWePuTP8ByvSyCEqIONOglyHAqMMrhjvHOJrQfNJzvEe4eI?=
 =?us-ascii?Q?+V92CA8WXamgQ36rHyioHap5bpY3R4dV1ZueI4RzUtrpPGjCSUVWKxa3HnNB?=
 =?us-ascii?Q?r/eBJb7/jqqqkeD8PoBYvO1U3q9QZ0gi5LoYSy1olyZ2nbbl3mD8O6XbZsS4?=
 =?us-ascii?Q?SQOsyz3bgJWVCur8VWPIeVElVkjLhhNBwcqWIKqhUZuUP2dYjbtdhXjZqK7j?=
 =?us-ascii?Q?gcGKkL1K1sr7q0LNCJobHOjhOgNpZKQOoItsmohWWEdb5xdYVnjVSQ10YEmf?=
 =?us-ascii?Q?QhqVnA9RkZWLPu/mOXA80gSeQOlRuYOuhbUNroli0tb7hu8CaBtJnGzyRTvO?=
 =?us-ascii?Q?aD8+tK1OFIld4h9jwdeHzJ3GMD4wEhSrK1N3n37LCqqzpv0J5VmF5xMTWCBG?=
 =?us-ascii?Q?B0C0sOZgzZw989hzzKLfKhW2fPpZjzpzcFsLrvwJrchN+/vtRFQIFG01tFQ9?=
 =?us-ascii?Q?YqBQsbINU3e0BbffaAqMQ/bATG6uZRwS+wtKVIXbg9tWh6dK0IiOE1cHgoCV?=
 =?us-ascii?Q?RifE0x0V+5b6aU5shvqXN3lF4i5TeU8Q+5wmgJjZH3xq+EHKmXGJLc12KXXl?=
 =?us-ascii?Q?6AULvKpXcdoP0tHGhFV0aMAXCyzD9wSNiP9hUDL9WSEKHgwSDpwQZmaADavp?=
 =?us-ascii?Q?n7vqEHjnIaKSXicpx5MOBMWP2TJPlfOntMTWho4Y23z9uojF/SwDb5eoa4jA?=
 =?us-ascii?Q?P/oN8E+REEWOh7G51UyTSd1fr6D9EhTYSQ/bReoQ1O/vfvXbhCfYB64XMYvK?=
 =?us-ascii?Q?KaZc/L1cKcUTK4K+AdQ7DAaIhJ2UfQ9CnQurq4eHSoFsuvptyb8JxWpH0RGq?=
 =?us-ascii?Q?In/0AODoxiaV2cmfIrE302QhGLuufg/I2pdp0XcQ9z6bxZPpQT2XOv7sqjmB?=
 =?us-ascii?Q?9a7EAC1i9K513pxsUqwyQjT5d9LXX3mgBLI/G9BXr2LySTkrou/hZnTaBCjm?=
 =?us-ascii?Q?5Ls1xk3Ux4EkIQHUNyVaWsM5cFRb6KPf0B/kIcTLpusMsIOthK0WDRsaAcB9?=
 =?us-ascii?Q?aVyzma7I66m+bd0sfbiRHeGO/tbCTbfFlU1NmwnAsINDay+6hoRdG5tlPXXw?=
 =?us-ascii?Q?sToPVZzhAsG3Qy7/O9ApDyqtMZbAYI7fa8xs6TUoFsb9lYnFI8Iq8TaGudA6?=
 =?us-ascii?Q?Vxka6XCfL03z4IoLhfXQDPyiGex8ireM2tE3Fq3w28DIMIIhHlRZ1lfhtcTd?=
 =?us-ascii?Q?gy8axZHjvfSpdp+wmLWa5E3Vf292SfDS1/Tgy32bVc4itebBYVpqeQL1W7KN?=
 =?us-ascii?Q?4Nsb2laTwxcydHQa9j61LcFHG9HSIhwSHmVniiBGnUL18Kfuk9iQUwHUjpjH?=
 =?us-ascii?Q?nqCrmZrwDFMWwBJ0LEERcklHy9MqIiazqa/OSWqaUxlBwTouE8EDfPyx5N5t?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b59ca9e7-9712-4cbf-c156-08db0974fc81
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 01:37:06.2307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uXvymdbRWEJ+Cr+5phBiREOE/edEdLCczWDZitsd/uOVVfaJx09EVAlmU0sEv0VibEW6DIaKdpqXXZdS6H3vu3bMiZyVoajTxQLa/DHdLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7211
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> There is no reason that the  CFMWS will always set the "Fixed Device
> Configuration" bit in the "Window Restrictions" field. Remove the
> CXL_DECODER_F_LOCK check.

This description says "what", but not "why". How about:

"Remove the CXL_DECODER_F_LOCK check to be permissive of platform BIOSen
that allow CXL.mem to be remapped."
