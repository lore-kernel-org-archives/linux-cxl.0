Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66112C77B78
	for <linux-cxl@archiver.kernel.org>; Sat, 22 Apr 2023 20:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjDVUyJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDVUyI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 22 Apr 2023 16:54:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043B92128
        for <linux-cxl@vger.kernel.org>; Sat, 22 Apr 2023 13:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682196846; x=1713732846;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GFO1uM8P0FGUK3yIgy39m1B8f7DYdMLriy2iOF4sTw0=;
  b=HWGLvyLXfurHEId2UBXA0/rNQCqLJhxT7e1KPinuGfgv8U8jYqZt84DM
   HhLZ5We+Yf/IVr+sxzzxj/+R5ww4kNPkty1G3izXqHtFZOmF2OglUaYFt
   TeVEeFIWvaDxy05LWaFf7TWF1ub2o5XEooj/DRKRLb3X2HiXcv98D+UH8
   YLiORCrI5p2DB066cZvpjJHRxz66fs8MyKeIOBoaYtgZqFG5RyqMr5+Q7
   lbxf5Z2SmVJu/pMZezXI2itBKVB4JDxUPN+PnJeK34lnMx3i1W/4uXzfS
   R7rD+VRcJSrhJ+jQ9y0JBRsr388RoPSJ8DzFI+ooKgVa7KCGUp01Xgi5/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="411476700"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="411476700"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 13:54:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="816781449"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="816781449"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 22 Apr 2023 13:54:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 22 Apr 2023 13:54:05 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 22 Apr 2023 13:54:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 22 Apr 2023 13:54:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 22 Apr 2023 13:54:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv4sZ3vQUs2vmTARVcg4WRLQ4qsjXqvy7kOi3uFi0cSTYw9kE34pEbXmxZTGKk1OsM7Ng/rlAkkc23g/Unh2QUdX+gqSis1GyIX9jyw6WlVnqq9jaHU7EKpmY6AowYlmEGZJ/VEooFZmBJtjJD88qjIm9EHlPgpKuQZL/g6pynfHnglOiXQ44kW/ki9G4QMeCPAJZrqkg2Fhwho3WDPXodzMKQfuqFcOv7i+pp1heBKGmP3UZtCfhcydlS6jmzQhGE8dQeFUAYmcwIMLvgd1nohYs5yW7CL0w+8q2TY3kKXvPYMAC0wBUAIbBZycmu1HbaCbIOM+XmpTobwxu5ieDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsF56xw1VvUYh1iJ8C1964VrpIG2trG8/Xg8NFANpKo=;
 b=ESY4X/uxyk5G+bqcb69lAXNyrimQLp0d2qrDBZBi4iE09temhbwihSU+Yf5dBXCrugQYzycnbuT3f/Bq2Cc1CUZb0eQqwY35qKsJA/Wd9YFpa/S77t/ldKZZnCnyVZkfd1ZhuWPixpOVQ9Cf53YXV7sHRDfdakmNdqOXUP51VO2x05EIz+rSo9rRa81Q8BXVeP/m7k2zWXcNsqITGeUc2mac69IZIC3MLmP5d26XZ2B3y3nOriqkOpjG978hc5D1m073ABKiZPzkJ4G77wl2oWFhITDZSfPhW8k76sbLrGY0NFyiVmBdpbAD9RVoR8DJr6iQX6W9gsbDFEa2DmjcGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8184.namprd11.prod.outlook.com (2603:10b6:8:160::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.29; Sat, 22 Apr
 2023 20:54:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Sat, 22 Apr 2023
 20:54:03 +0000
Date:   Sat, 22 Apr 2023 13:54:00 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Lukas Wunner <lukas@wunner.de>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/port: Fix port to pci device assumptions in
 read_cdat_data()
Message-ID: <644449689728c_1b66294e1@dwillia2-xfh.jf.intel.com.notmuch>
References: <becaf70e8faf9681d474200117d62d7eaac46cca.1678543498.git.lukas@wunner.de>
 <168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com>
 <20230422083502.GA31480@wunner.de>
 <20230422140534.GA8951@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230422140534.GA8951@wunner.de>
X-ClientProxiedBy: BYAPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::42) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b50548-e61a-48a0-db55-08db4373b422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZLa6whPp1+eriq+8lFEjVf5GiXeJC5e6ddl5sYuOscJNpeZtAFcioE0MrFX9cAEFv/60f8uaqbgOUA2Ht50UNgasNoEHviKbMe0RikvHtXrUz8S9j4yfabwsgPn6Pc/JyLBiE043NPOVMK87gVIBeMO05H5hVLHfp/S4r9FJkMtwXkZ0IpjiH57JyQAWNNnHQq/vSuDgEh631m/2hYoFuhsnr2F+SA0m0fno/odfgqVy0j6Sy1xdyoSVi2n/K9n+gjxnAe9u+CYmhhq+Q8gL5wwOMF0xLtjG/UqOPbmS0dDZkqBXblB/BW3Se634M3w7H3BbawA0AxwPKIWd1FWwdUo3XYzObtRQINDrldJhmlfNa/Jsh/ibZv+L/ocKK6vdCDRHZPicA3ywS8hySXle9eXPWjLkHcdEMDV4IlMO4kUNF9qDWXG6jDkyMmJapCHMYqOiPTA2ibsKmxg5cVt05xExvyvyNtXv0gtWGa4QkrTHGEIdqHJLSDaXmnxRbNpakNP+Fp99+BZZ1u9i76zTzhMRHrjGxreXCl+OGp0KsQ736Jt0sHZ+RxWdf+FCvte
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(26005)(6506007)(9686003)(6512007)(8936002)(38100700002)(8676002)(186003)(66476007)(66556008)(4326008)(316002)(110136005)(478600001)(86362001)(6486002)(66946007)(107886003)(41300700001)(82960400001)(83380400001)(5660300002)(4744005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5/u1DdTL0a3fp3jWvMXUrImOpTIIg33UAKhA0vWKnfEtRMJJUZCDGPVJhhSP?=
 =?us-ascii?Q?TLP2+tXMdE8w07r+IO7oJFO0GpWYshJhHiNUxRZLpII9pluiFRg9lIXUnNTd?=
 =?us-ascii?Q?GRcgP2v7QdZjjZQ7D36cmR/+xHHKvzDWM8s9+WsqoUJGHDzcBI93MVZF2M1t?=
 =?us-ascii?Q?79cv/SYu1p9VoSNgxcKUkKBw8lKaSz7++ULOpjpYUWG+7ar2xkcNnLoP5dMZ?=
 =?us-ascii?Q?fQRtwCNrZeA5RGPuJGuysZa5sinzO66EeflhBCwHK7pUwhxrV53DPsQ2g8nU?=
 =?us-ascii?Q?a4ColalFkxd879Cc50FgX82pD4ONOiIqSvphCPeldY6zq3J+HVzcMDcnhgs1?=
 =?us-ascii?Q?wh6komRrgRUZyaRZWk23L6pIaolizOZA1Lo7TkDciWf7abV+YzzbJc29U7Sw?=
 =?us-ascii?Q?STu7ekKCcqZxxZK9zuvlSX9k1Cjo8fm1l3rPZDd2MsQcNVhRVg2aLQykgKvj?=
 =?us-ascii?Q?SJ70UzCR036jHR86t+6rxBv6ndWT728lhN4ZCp+yHi9Ng5iNHDHxI7F6GcdG?=
 =?us-ascii?Q?dZOxlopgFKnno0nvVESmayMtvnun9YncbeZriRKfYkxiLdYmByIDMOpiFtv8?=
 =?us-ascii?Q?Pwlu7BEA1UfsOQGAc9yBXiyjLMYv4abwiysIJ2ZY4Pr2dSVBgcNbRdS4r+4Q?=
 =?us-ascii?Q?UbVz1CuY8gSgORcaX9Gy7NgCrh3L5o0xqQBcmnWyIMRSpSN7m2cfy5u2hPkx?=
 =?us-ascii?Q?1UxkjNPCbRbg51ojddje9zLfgwVqNqcEc7i6c+NfFDev5zeKwcjcyHuyuFgq?=
 =?us-ascii?Q?Ph4yKc2YeGcKxGo4l+UUlxv6MoKIOdhEaU1T7OXDdJy43g82/AWon/TISsda?=
 =?us-ascii?Q?qxq77WIEjqZeCHeZ2nyShW6Lqj5o/aB3eF523oLOx9okh0hyPZv47OC6Ry4K?=
 =?us-ascii?Q?NoQqS4/+ZXbasbhl5wY8Lu8c77UvTm2Zdy+ui1OQgT0Qz3H4PouX8FZSNGc4?=
 =?us-ascii?Q?xrzVBQwAGnDSXh7xUzxaaGq/yROqSkX0+w7vLKJej1IQ/8Y+6WDMKXrtjH8o?=
 =?us-ascii?Q?aIY15/xrBmOcYMFxKQshGLWKEh+Eu9X+e8ZIlqfCi9aHXv9C+g7vaNL7zlhF?=
 =?us-ascii?Q?i/zyfrgpEJUjf3CIKS87gEIJ3/V8KWrupeyDJxdN6Qj7tyAcY86VhvSTGSpI?=
 =?us-ascii?Q?+CFReLAKSiD47vGHVH6SCfpbVApcp0w0B+Fa9BjIE9/454PSoZMiheaetVMb?=
 =?us-ascii?Q?ZE0oQcLcmoVzMBxgNm/JhMZgVwJoXlXn+5T6cE6SW0WO0jMvq5hFkMTjyMH3?=
 =?us-ascii?Q?TrpBN3UQJEftF0vCdA0OkisbVNpkHD6YZgwglQIPSGmWGsXZwSvncTdOQT6Y?=
 =?us-ascii?Q?HRIYB1o73aGslltbe8b7WchWfCEMw1h8P2Ykea+iZHUyKOKCeldzouDdq3nN?=
 =?us-ascii?Q?mMEfCoBzhdnGBVm8quMXHVxC/xNQFmX+68wmR7KOZ/TfhBRM55ovE14c8STe?=
 =?us-ascii?Q?KHDz6AkAGbePmR82qWiZOF9hyA/zGVx826EnQSsKohaPhzCJW/EsAn0U7GJG?=
 =?us-ascii?Q?dlhTn2G1CMLdaOig3xcd8FHm3OZMW9owMEz9sm0TapXN7XLT+lctZNUqFBM6?=
 =?us-ascii?Q?4j9niGQpKiGK2p1bs6vNAmkGFRqr3vwmMBz+LxujOUNqS8O4tR0qIbNN2vZl?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b50548-e61a-48a0-db55-08db4373b422
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 20:54:02.7684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kh85xiYzlYdl6GPsZYLHyg/Pr40R/9iTRDiWqfpdKDL22eWKEDX0nGa9/Flyfn4tG/X1RhH0LWa/ULVmOvcDQuPS9omdwtIzoLRvzdx13Lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8184
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Lukas Wunner wrote:
> On Sat, Apr 22, 2023 at 10:35:02AM +0200, Lukas Wunner wrote:
> > I note however that before af0a6c3587dc, xa_for_each() was run on an
> > xarray which was not initialized with xa_init() on non-pci cxl ports.
> > (xa_init() was run from cxl_pci_probe() -> devm_cxl_pci_create_doe()
> > but xa_for_each() was run from read_cdat_data() -> find_cdat_doe()
> > for non-pci cxl ports as well.)
> > 
> > Hence can't this crash prior to af0a6c3587dc as well?
> 
> After taking another look with a fresh pair of eyeballs I think
> you may see splats with CONFIG_DEBUG_LOCK_ALLOC=y (even prior to
> af0a6c3587dc on non-pci cxl devices) due to the missing xa_init().

The xa_init() was included before in the removed call to
devm_cxl_pci_create_doe().

---
-static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
-{
-       struct device *dev = cxlds->dev;
-       struct pci_dev *pdev = to_pci_dev(dev);
-       u16 off = 0;
-
-       xa_init(&cxlds->doe_mbs);
---
