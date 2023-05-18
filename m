Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17904C7EE23
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 18:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjERSw5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 14:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjERSwx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 14:52:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3107EC7
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684435973; x=1715971973;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qxu3++f8ZuijNWsOSKN9a96bvR/qrAUd0caMMnz3QQI=;
  b=SSptKf9s4EtSmRRXHxyB5KYX+MTS1khpn4H6xJgwsOOTVScVwQ2ytgbO
   UH/d91xwlm8Me4Iwav9zfokJ2BYTuZt6MqpYVLUDbtIZjvYIe7v+9lVu3
   5KkJBCVB0WUyLlNxUGCQZpsgN2Xo/WCW8go4GXOVwsJuXngF4JFWzBOQl
   DNZEgI1mFWSN1/RwNS1Q2Up0T/SBQzQTT1CG5sltqx8FR3FRPUliBpS7e
   PlBhkkntBiI0UeU8Qgxcd1ILFwHNvFddm2KpElX4xIJjk0x0XqWs1R0DK
   qWcz02s8kq3Dy2wW6a5NPPtrDnLZrEukGSCRvBtscsSTaATaG2CUHuY28
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="352181323"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="352181323"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 11:52:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="1032303860"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="1032303860"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 18 May 2023 11:52:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 11:52:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 11:52:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 11:52:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 11:52:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqHIZ1B5VsYgmW+UdJe5ARXO4PN35kIkSYRw5/TTYHDu91BUaS6PhOmiju1KhEvUakURr5cHnx2pnWfJuamZurErif9YTwcKSYLCr2ZP8nZklfu/K1HfAkq5gYBo3x0Owr30l9O+FiORJ+D2ryi6CQZK/2DsjOzCV5pNXXAHMjQPI5NN1N1JifEWETBGtMjdy6/OlMjznXb9kvyLDblZQjwUVzYfEcTaQ6JIADpp/KhIQpJFRELa4eFS2xmU+5UnIjlvufhxdvLnNta7k4A3rlNmBX1g5F2geg1GLs3X22rqJjm3umd9X6BNovtEck22x+3EGp4tyyiXFP2JPZrA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnuyKB1sNvDCNQzAqbHy/5CC9ov/xUr+BcLUNXbKym4=;
 b=PiQTpcXQyIKK+pz9yOycik3fodZeiwL5lOhupsggjcPrm+2/ddV0nOQ308utprwkaWz/9W+Vpp7TzeXnHK6/QSA0UOI9pIvVcnSoIOBsU8lU3kNqL3S44hPOvcE4ww0I7eFd+/i8bQYucfMuWg4qT/PZej0JgkWfdwqaPDp//Du1VMNTm56GkRmkmSJ9bByqf+ELoW99pnyzk1kaa9r/VrWrjHaVlfi7L5BvR2r1hki0DTPCMjYksoWng+FzeNnKBlnTAkAlEcTgUa27kYs8JgacnkJtsTbaEPS6vecgC+45nXJ/qDyOfyD1eu4qmQWz4Ygv+HrsKJ5MgAkJc2nDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5497.namprd11.prod.outlook.com (2603:10b6:408:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 18:52:50 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 18:52:50 +0000
Date:   Thu, 18 May 2023 11:52:44 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>
Subject: Re: [PATCH] cxl/port: Enable the HDM decoder capability for switch
 ports
Message-ID: <646673fca74c5_1111d3294e6@iweiny-mobl.notmuch>
References: <168437998331.403037.15719879757678389217.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168437998331.403037.15719879757678389217.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5497:EE_
X-MS-Office365-Filtering-Correlation-Id: 2100746a-52cc-4ede-2534-08db57d11439
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ff2jZ8z+vUHKq0ixqyZKBMx7QZ1kVsf/38CiqIvyxXWvGFTyXdpvVV9Tdv9B7DxG4fDfhR3IajlrZr0bAK4htbhl5RUPrM6/pbGuNaR5QsQoeOkRRoyUZdROv7aqjiBuZOIOM3gL9qn3jrlBF5rvHCwaDEnaoxBZTCKFUWA0efOq3s9X/oXsa0hmUt9Akv36j3mpPTNqPuUD/wJYuKM8B1kUyX9KQ/jkKP+PbOdiNRcA40H5XXrt85IEkyvN8XMfVF590qiqFGc13sBpQ16b2cUd4ZK5tLP7j7RDElEsISBzniO3y8L3uokbzgxgD5h6fwAqe5wohqOS+XXViFBFIL6j1whaGxfThY4dy7jDR9U6ZWzieBnmRlDYMkD/8tuhrBzFpFryurjIymwjlLbDuec/m1kd9S8EJUmLW68N+eoONgTzp1wPo/ETr6Fl4195eRNwMCiRoVpoMyL8BcNNbiRV07/20g24PQc0IkQdpfYK5qKHIueT5rzEFJhANUzNZ+MSd+ofPd/gzkfHv9miTY2TPMiUoCZ19yuJzfnrdsR1p5KpOMm0kz1Fb9ezjz20
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(8936002)(2906002)(316002)(478600001)(41300700001)(8676002)(4326008)(6486002)(44832011)(6666004)(66476007)(66946007)(66556008)(5660300002)(6512007)(6506007)(9686003)(26005)(107886003)(186003)(82960400001)(38100700002)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z7wCphyqf5F2i/aA8qp4JQoFdd0qhE6DGG6bR50NcY02UOyhqmTGl51UEevc?=
 =?us-ascii?Q?X4gXAXx2FPFxC2kXKRO2DmDjZFkQJkoWw4cp46hvtuBqf6EMHddSuT9s6Og1?=
 =?us-ascii?Q?J9E7pkgP+Et22I40xHtIVmQkPiZIx8NfF+inrAR7VlL5lVjJxjX6rPv56Xcv?=
 =?us-ascii?Q?PC/wdcKUE2BR9mVjHidCMtzmR7XtLDcNogvdy9s3aMQ5djRhd7a+dsR4r5bn?=
 =?us-ascii?Q?YuBkuuMK6dwR+3KabD3LC5X03kfsD0x4wT5zdUpIOpnQhXJu+IYH6/1XQokd?=
 =?us-ascii?Q?aX7eWGHj1FiCz9AsTkNZDjXkmSrmFXER6VxzGv/aLS9YSzGuUwpbyPom4E1G?=
 =?us-ascii?Q?x5+U364q9NVoYNIdy4CdTW0nIKctZvsBsBwEzaswr21qmMx5TLVvg6JXergo?=
 =?us-ascii?Q?J+2yllo4tXmtkst2MlYicKlCXk1YggXirGg9xUFXiD0A/E6SvQ+YolNmAmY+?=
 =?us-ascii?Q?XcJxt4+q/q4uK4u2+x+C7MlsEZGKfQpa+Fl16xw/Wsbg2fLm0uL25iG4yM4a?=
 =?us-ascii?Q?ZNLCV4PcrFlc5lUys2m0xJTe5223GPT7GkQ2MFJRjy870Qoh96n81v0IqN2N?=
 =?us-ascii?Q?Z3quAjX/Lw4Dz1no7MX7HrwXHyGXQyNGl53ZYqaBza4U8cCHSKE6W8vi0Dmy?=
 =?us-ascii?Q?agJS5oWGuWVC7TU0P1oANSYz2MWz3bpEuFZZw8nSupXzixJ2grTscAe5jnwB?=
 =?us-ascii?Q?hIs0GTZHMGvljQdJEB6zooczVpmjetJdhrj+b2Up7nn15HR7hbP6A1wuLXZI?=
 =?us-ascii?Q?yVkTYW8BbMFqCl6JRsBYH+M5TOGo6AoIivy+NuoBmLWIK5hJrHQYXSHf/qyL?=
 =?us-ascii?Q?GkjDlmtFT42z0k2cq1S/f78IYy0DZcwHYpDDCdg+uwGa5gRtCY+zx/guq4yn?=
 =?us-ascii?Q?So45J/BotH6pO6Rt1OkURtfYNR7SjOctQ7EpsFkgxvLOISrgI8eRNrHvZ7lD?=
 =?us-ascii?Q?Y+EwY7snv+RAFhCjci9LPp6/q1DaUQ9yKaIq4vt2EjFtMMpgm9wq/vGfYy36?=
 =?us-ascii?Q?jRl53WtthZOfzCSQByQBlSVPqK6t8oSOlUxAdtaxcZzbegG+pACjoVNf2zmt?=
 =?us-ascii?Q?BlAsh26azk3BLF1fJbes0ob+V393Ame3pnVLciKOI58czuHgITmpHN0A/aAH?=
 =?us-ascii?Q?oBC79ZEJDLE9isP9KdwH3bPIUwSuNqGQg9RRFICqgSKZc7n6yLhwqacZOXHr?=
 =?us-ascii?Q?BuRDcKli5xARqW5zAerHJK9DFsrL8l9b6i8ltrV8y1y7CUw30kNJhbJC/eSq?=
 =?us-ascii?Q?rwmvbJC6WFRionigI2z4GBUh9QvL08yZHwdwzHMJzJc5qkGKg0hAZTt7K18q?=
 =?us-ascii?Q?y7GgIMBeVwix660xk0yc4Ntj2Ophurbko8Gfe1JVDCjGl77s0df3P0eSXpOW?=
 =?us-ascii?Q?2FRL1FwjCRsIHDwA70qrgk9PgejJKHQzmOpR7yuLLO6Nm46D+7OLhtPzNs4C?=
 =?us-ascii?Q?jYjXnDdPWwJltd+XighuSStvbHxsWVR/r3vP0hIetTCNuOOSbP0hEStC0qAA?=
 =?us-ascii?Q?d2pvNIawCDv5c4a1p1ezhHaFv+dn7gObWuvl1n9TqmjLqpa79QvbAdKb4x13?=
 =?us-ascii?Q?GgbTO7lmNgyDBTsKUvaj4s+L+k2xs2nPFwIgC78C?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2100746a-52cc-4ede-2534-08db57d11439
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 18:52:50.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35UhZdnK6q2di+k+VOisWnO4j8hiOx8a1q/PNmt9M0vEY8mf4TNA9JHdGECWt9lE2lIMgiSMMqPssQATdLuBbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5497
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> Derick noticed, when testing hot plug, that hot-add behaves nominally
> after a removal. However, if the hot-add is done without a prior
> removal, CXL.mem accesses fail. It turns out that the original
> implementation of the port driver and region programming wrongly assumed
> that platform-firmware always enables the host-bridge HDM decoder
> capability. Add support turning on switch-level HDM decoders in the case
> where platform-firmware has not.
> 
> The implementation is careful to only arrange for the enable to be
> undone if the current instance of the driver was the one that did the
> enable. This is to interoperate with platform-firmware that may expect
> CXL.mem to remain active after the driver is shutdown. This comes at the
> cost of potentially not shutting down the enable on kexec flows, but it
> is mitigated by the fact that the related HDM decoders still need to be
> enabled on an individual basis.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: Derick Marks <derick.w.marks@intel.com>
> Fixes: 54cdbf845cf7 ("cxl/port: Add a driver for 'struct cxl_port' objects")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
