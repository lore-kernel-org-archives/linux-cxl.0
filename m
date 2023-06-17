Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64B6EB64D7
	for <linux-cxl@archiver.kernel.org>; Sat, 17 Jun 2023 00:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjFQA0q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 20:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQA0p (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 20:26:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FE63A89
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 17:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686961604; x=1718497604;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=fq1FNpS5VkWsGxrKFAgcdEnR/ruA+lLpNTE8SNo1mlw=;
  b=Tg4OuRNgsM4shbo1BtlrR+8s0k1O1yJNGI6xtUJVStSQrZtrUPXCSvDc
   DT14r0EbJqiDMwusA3bgzmDVa5KY1Lw1WpZ+1tZCGiO6ATCd6PF5dGLuf
   OWA6EjUFpnlF8oMqdheB/j2ZVs35JV8usfgQlKcrar4+zL7wP4IPMt1Pl
   dGaDkORIBKKStn4mTjyYDJcYIqdY3kUYC0Xyb7SdIt/DqOyU8S6u7Sf8J
   HTYYsRuouKcbBXgiKhvCknnGn071rNjCIYLpeW1rFRSJNycGeyjTHjiSi
   E4DYRLXC7KMA43Y6d8PcfvBy/Dzs0VfXeK9bFmfxa/Y4tcChWiNRTsIUg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="425282912"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="425282912"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 17:26:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="663361151"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="663361151"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 16 Jun 2023 17:26:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 17:26:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 17:26:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 17:26:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 17:26:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+r3wXWji6ZPpHVlWrSLmbvTCLphsjeOoMqH0u5RU7K873RSG2el3li2B7bA0Zgjeq0KpKVTNcotPBcdTecXi4YB5KxDbwn3Sqk4J336Io7hn0QPLfmIOBjR+8IB/TwvGrM4JowDYdkyJb0NgbALGjQl4j1DesR6Lqg0iSY/0HIyhiLWVlWDdBBPm4m52kGeORjkIs5e84TAz5fhzBSqvxrGNpBJbEAx0P+UsdGsoYOxmjPIGh1SUbBEfCvFdVnMpK3PzXVaCjL76x2tJ8T7B1rqrDIMAk/Wi1mQcfib2soCYpU/khRehk4X2zI3dKRZA3wEWWGv7oIed4HHcPYS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zk9z+Mn9BwKQqgNr3Eji6PNhOLg77XpuTiO9NdD8wl8=;
 b=cw6hyqE1r2jq7I5P1PcEWzt3pIDvb9WW90+6p3h5Z/ck9YQkdXkf0ZXd02tzrsD4qU5KRYM4ww9N8B+Fau5zlSyKpzpoVvQ+Jp4fC7QZiTUBfPlUH6uXBr4dk0hmeYVNoQwAf8aWp97l3wflrMeWNzIpsrKv77QGQ9sXSdGdAc82zjYHN0zcgxkm+JKcweMhT67o72PYRF9k7ohu50XEjx1kyNOVpUGGGnsUuQ6UZE3/YLtbX01inNNkWX1ZqwQAVZwkMcsP4HtClx3/LqJ/Q4edp6Tpem9tZP3ZpKMiYVtKu0WCjVk15POgwik69DJZuq1g0ZVVVpNa3wkeRJ9ovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB8245.namprd11.prod.outlook.com (2603:10b6:208:448::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sat, 17 Jun
 2023 00:26:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Sat, 17 Jun 2023
 00:26:36 +0000
Date:   Fri, 16 Jun 2023 17:26:34 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: RE: CXL/region :  commit reset of out of order region appears to
 succeed.
Message-ID: <648cfdbad83fe_362143294ce@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230316171441.0000205b@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230316171441.0000205b@Huawei.com>
X-ClientProxiedBy: BY5PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:a03:180::42) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e97eaf1-3c8f-46e6-c42c-08db6ec98280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpXfd2mnADJFgqEcZo/PmuEAsJxDsDeXe3OchUm2bn9dZrTXGrXa/6XgCnDdJ8Yp/XV6wgZMRpXf4w4H/JOjk3/PhqQDlnPsYDDPd6I5bF5y0wV69FpsP5X+Gygdg9xgeY5UvHuPIF4KEjkQJSculMbLL/JW7qNAkI0hW7s6tjuGWKWBOnMnPeqfgO1ijHdqxlsgKH1sjOr84bR8CVg8gsLgazWNwedoQ1k9KZFgGH9QoDOFaoaqlPbH2ewJlS5dVmNnV7KkIUuYGOc1koawE22krLj62JsJ4QuzGG+VDGbygP7bSqNEe2GSECkbED55pKB7iG95fxRjcOcD58on0JejtZqJyTigAdEs3gC+ileRUYsHO17FySPYrZlmxyHIwMNlFFTPw+0sxaXq0ocCYS8HS17zZFRsCR4xfbeiw/P3Urj4Pm6MaRrsaOHC4b95tCOjmdPEgawOzWsBx69V04+Xb15d1PcEkhM3lOkdRja2v3pwfCPkt/EFeRSqO1TzHedCYcA1P0vwdebJG2z3ZokFzc/1U9JtPzXrdOBC1Ag=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199021)(66556008)(66946007)(66476007)(186003)(6512007)(86362001)(26005)(9686003)(966005)(6506007)(478600001)(6486002)(82960400001)(38100700002)(316002)(83380400001)(5660300002)(8936002)(8676002)(2906002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h9vMpOMZ2j27SABWYQJ5lHjMi169LOlq3WmgZ8QB+r3oOrmT3Dr6POxuCgEq?=
 =?us-ascii?Q?1jd++SMn6DotB7xinxaooScIYo97s7nWO1jneY78mPZFDfWybPyYraYfIw//?=
 =?us-ascii?Q?POv3zwglOmqfh0cK7QZr8rG5EDPBjYz5+wcX4zpq8RJQzQAGqJyj3JzkFjKs?=
 =?us-ascii?Q?GvK57wzSDWWAp9iHCAHu4zfPQSvXawRLIZ1OvFY6e2EI+6qce/LG5kc9VI9K?=
 =?us-ascii?Q?sUCB8mbTy+mGmCBmxb+I2dazRPz6UYDpKxnHqENxYpSPkp31TgndKyglteFM?=
 =?us-ascii?Q?B+c4HBa+qQOa8dMHwczOx4dvDhizp+uoYWhqOtUgRYoSdxAfo/pfGcDQNXul?=
 =?us-ascii?Q?oHtHKkaago1n5SWc2GL9dQOssL0d2rvECR8wmHd+nzk74/6EhTkNwy0n+xSl?=
 =?us-ascii?Q?xJPcetHGkRCwmc5buBbgVc/G9U0XuVGoYae58W39tMax+Wmrmq2VVNNfdqfZ?=
 =?us-ascii?Q?fnfn9zFgJO/pEUVc5dd/a4ca+xbq+UdEBarv9iidb9yJlV1vMZs7NHIReJ30?=
 =?us-ascii?Q?zRe5Z+opca7npyu3EIvNaaBvMtzI2hwUH5sLTlgsye0AO4pY87szBU3br00C?=
 =?us-ascii?Q?OzfNJB8igTs6qrvRrENLMKJ/vT9xcew9f1rYzMx7hQsHOicOSp/owOXiuaMr?=
 =?us-ascii?Q?oqKdKXZaXKaD0trgowiVjBJmVlVW/pt8Ef53a6jIS7eflli9cskMVkxnm1ox?=
 =?us-ascii?Q?be3dqsIAa+7eyFtnUKIZT6YurrlNUtUfNio1XKWyEpwkOiLKP7JdwpSjlD8r?=
 =?us-ascii?Q?vNTEBhMdW+b29kVy02jqlF2Rcs128qWYI1V1UfLeuv8nQ2s9j8JWq52JOdDg?=
 =?us-ascii?Q?XSkomnkiwf1ZNaudVfn12I+7MkTURnNlAeVa1NiumZCaq7eWo8EF4FoJzYZX?=
 =?us-ascii?Q?VpsSrWDK/uuz0SXzz6q9myNUSdLWrUfBLILNCqaZB7gQdiEIt79XWwfEWPag?=
 =?us-ascii?Q?KMM/CpLVHDud5p3Vj53ehJVm+dEoREDEP7Q9Pe4s0HceT6mYeBNGQCmnH5YY?=
 =?us-ascii?Q?jfIN4ARyEQfmLdoUQqqW1JfL/9pB6GxGQU9sdpjsB3Ja2YFQBNzmpR7DzCBG?=
 =?us-ascii?Q?lWsFWF4y6NGgSwVv76lADZt6gC57hG444EyvSF8tN9t/piBoug8lBg0YTn4Y?=
 =?us-ascii?Q?HN6qn8r+pj1YUwJh1zLPdDjCv5sycu3ckEfYG4KsljyJl/SYcJBFRFk5NYz/?=
 =?us-ascii?Q?iFmLXPpfSp9dL2BDcst6iynHXdc4g0ymzEoc1wdBLsOXIbS2BW75Rw0dcWg5?=
 =?us-ascii?Q?Xqs6fppKPvLyR5HFgt/h9v9AUZnHSqv3mlTfCK7fqriP0tTQ4oAlTEzeZp3H?=
 =?us-ascii?Q?g37d/ZAO0VHIfpo0T33jaQZ7ovgH0TV+Wudsd3SNJIIZcKB6y4Tn2keudKLf?=
 =?us-ascii?Q?i54uuFv5s9UcU9/Kqu2ICOxXIPBdIeEcjYo+6IzQlOzRhzlk7qYMrfet2IxK?=
 =?us-ascii?Q?vT/hWHKpMDha/4WKHViU7ojeJcwklv0ZUVeRKC45gSwqMIzRzAjtlwYJ7SYu?=
 =?us-ascii?Q?ODsM7HEDHywVsceYRNmXPijdhV8z/iYW9NiVhusaNf9K+TfVCY4Y+pBeVlcH?=
 =?us-ascii?Q?l66sRZUDc3NqxlfMYIsZthp2GjSYvN2QV8po1l7t2GddTr0BTWYkTZQ38Yw7?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e97eaf1-3c8f-46e6-c42c-08db6ec98280
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2023 00:26:36.4653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KPb04i1Lo9w1d1Y22aksyhGjtjEA4lR14NpTm+eGxFrhfW6JOl4XfuHtXLDqoHbcq3Mr0OpMtaAyhAFuwwr9Z3033kCA8YHTh5fI2J5Wi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8245
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Ran into this whilst testing fix for QEMU uncommit handling.
> 
> To replicate.
> 1) Setup two regions on a direct connected Type 3 and commit them both.
> 2) Uncommit the first region once. (it fails with an out of order message)
>    Note that from here on the sysfs commit attribute reads as 0.
> 3) Uncommit that first region again.  It appears to succeed.
> 
> Reason is easy to track down:
> https://elixir.bootlin.com/linux/v6.3-rc2/source/drivers/cxl/core/region.c#L257
> 
> commit_store() of 0 unconditionally sets the state to CXL_CONFIG_RESET_PENDING
> 
> When the decoder reset fails, that is left set.
> Hence next call drops straight through.
> 
> Whilst it's easy to 'fix' the superficial issue by reseting the state to the previous
> value on error, I'm not sure that's sufficient or race free.

I think it is sufficient because the state transition is happening under
the lock and RESET_PENDING > ACTIVE. So any paths that depend on the
region not being active will be protected.

On the other side, if someone races to commit the region via another
thread while the lock is dropped they will either successfully
transition the region back to the COMMIT state, or will re-attempt
the reset. When both those threads re-acquire the lock one of them will
see that the reset state can advance back to ACTIVE, or will see that
someone snuck in and committed the region again while the lock was
dropped.
