Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BCEC77B7A
	for <linux-cxl@archiver.kernel.org>; Tue, 16 May 2023 21:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjEPVt5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 May 2023 17:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjEPVt4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 May 2023 17:49:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EBB1FD6
        for <linux-cxl@vger.kernel.org>; Tue, 16 May 2023 14:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684273793; x=1715809793;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qqQqhwjbkMyh+J1EU/qxgzM8yZ98dPDmq8x4sYJuqWM=;
  b=AXkrTZLIN0FGvHfOJqKPTVX9sjcbeE+0Z1CMOKLfqAPlhziS1vSDxvHm
   rsbNu2LdoH5s6/8vsZbJmRWfyM3jltIGzLnRRO+h3i9XQwScmsShF0cTm
   oM+DSqpIz/++DBBY1ILD9EaCeH2j1A0c6I7U94rG/e4MKtwNm5rAQlSJw
   db+ca3/O7P4j2HfzWqHjnEVX6f5i+ydP2LlAsDjdIxlKIRuZkK67dhuzm
   pL3TXds8c01O5f+tDMXQA0EWKeHrT7Ncutw4+x2Hh0OoWV+mk/nIwlURi
   0S59vV0tSTsYHvBpm4fr7XR03mBvg6g3bYaNayLL7FoYdaE+FmI7NXtsZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="340978341"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="340978341"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 14:49:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="813609195"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="813609195"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 16 May 2023 14:49:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 14:49:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 14:49:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 14:49:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 14:49:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIxgW/vrTwTI51wo+Ir+UmK3lSDdLmW2rrIyNU5u2JDFcMqGdfbGShXf2dKNJRfkmAbaxMUTLZ1nLJqYn1EVzq142VV3jSvqG7DFmu0Gn5mwg+RgAIQZFxj30X6loRrFGpKZRBkaDknpLfNqrCpjqRbmTx7YYY7rljWBQzlOSDNXccPKmiPvRbR2GJiZX8UcxEnXo5D8dgAj/hKsOa4X3QdVY9PocHc8H/mM/U8BAGlSfdx0nbKwCYtHOk/XC6g/8rJ+DlNljwkapHEWvHRG3rzxKjLMSjTAHezUc1cH1RuhsLWnw9ydRO5La42hoPt1yeMrBxq2Mn2ghZEgvYgzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qebnK3QmrY/f+9WvFTgXHNqc/9iatMSzxSXnYGGtJM=;
 b=cl/4XNMJSHmrQ31ApHEEUGB2bHeMnR9FM/TQ9i6U/DSootQnQHWOU/2/CWoC2JUAv8Wg7w9Igw9TtrqoQ06GDOffoO5oZwfrABN+1g7fi5Z8PJ8FO97UguE9cyhHClDaxfm8Y9c0RbwOBt+Gdk1OwyJQ3ROWFUUiEZN48mnEjWzOG6WvJZJ0bSxxOtF0ZpSqDmjzAU62uGoEPZPAm5k/7Gk2gXp33iDolYcYCls8mTD6ygJktHPKRHl6DrLrYXiNhWGBamdM9FoNBniepCzsFNaWTLP7cggrezULQOv3VvhNh932fMk5t6v5NeZuLHaAbmEqeAzBgm+tx2Af6w/rrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6520.namprd11.prod.outlook.com (2603:10b6:8:d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 21:49:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 21:49:49 +0000
Date:   Tue, 16 May 2023 14:49:46 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH v5 00/14] cxl: Add support for QTG ID retrieval for CXL
 subsystem
Message-ID: <6463fa7ae35c4_250e2941f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
 <20230512162831.00003b34@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230512162831.00003b34@Huawei.com>
X-ClientProxiedBy: BYAPR07CA0067.namprd07.prod.outlook.com
 (2603:10b6:a03:60::44) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d6a0f6-0028-4dad-c562-08db565778fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9zqNpoOV0jln9SU5MjFoabr41qMb/vs7FEI8jBKHWDWeyI2xfeMwRWWfAGfY3eHSXSEkjPB3nuUe2wtNK+95k1e3erhDDDDxNjIcXTKTr0EHhiqBPHlCiw5RRdoZUL2rIbG4zLRu7tjpkEA68vM/DjipsJmBp9ANuww/nfGp/zZgrCcJHJPzC/mtNb65Qqdg9BShaKjYaRpH7ApsrMcybomwKO+TOv+LZqgb9d1lYDg3wZAMaF7M/icZECMPlg2QSSrPLiVRumj8nHoXTrU/b3NvBARfrnrvHpCzDmRMK5B+xkf7v53g1wXZwPS8znVYBtDlBff84WpTCMkTt/F81LIuFT6DCkXdUgDg7eqYn26h2XtyJOCB+lZh72VAq4R92ixIgMIcooEjuEWWpT3BGjAhCseu1SNgTeWuu6iWLr9WDlGteQljsdgUyAa/JUn1Q6exhocxH+RQR5PQ/F1kqWLVW+hVtXdnCagQuqmOHbBE3F32g0N43jXmWUuzoqchT8xAwZ2pX3bt3PWFFO5cvxV99L6Tt2EIKaHXda1HvUFRoz0mGeCvH3d5TFfpn5B/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(478600001)(38100700002)(26005)(107886003)(186003)(9686003)(82960400001)(6506007)(6512007)(2906002)(8676002)(5660300002)(41300700001)(8936002)(6486002)(110136005)(66556008)(6666004)(66476007)(66946007)(316002)(6636002)(4326008)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GdgNqOTamcogdUtVI8rWluSg1Y+cgDd49a+7WvBSTvv5Z1ulzOERo1WQHnU9?=
 =?us-ascii?Q?ExbdJqPUPHYHhkwFErtgGrTqqlkdx1+y1DhNffI4Odu48tLXHZ5ZxvZAhclM?=
 =?us-ascii?Q?QJ4LYyb1gfaatc2pyCNfAXSrBOMlbaj88oPM+QQKzBKxiQuOCLzJv8yqPxMY?=
 =?us-ascii?Q?6U4MLHhKQP6tYHYW2WyUE4fh27MMf1IhtuSckfy6eqkL338K455dcW5TKD6A?=
 =?us-ascii?Q?MZIP6H7PZu405B5n8X/7fVvn+RuNKYdMtmlabny9TJY2njdKxyBSBMLwNZlY?=
 =?us-ascii?Q?/1vDs4J5eXyx0ySPI3tMIYJFU5u7h2yWHl5G1sFx6x6l0VIKrS9ycYuVwWc1?=
 =?us-ascii?Q?N5OLda7IdSCkr368ZyGJB2yhjQb2pqBEmjHffD5+0TqRf7bLqkQS4k7IiS15?=
 =?us-ascii?Q?GcgMZARJFw0+JTdswtdHV1GrLzYkovg9AEfPez0q8xMrcYFXlBHlmcOUkTej?=
 =?us-ascii?Q?MWoBZIvSeZx/pmjtWObKFp7jjA5u7p3lsOEo8YDUw4eoRUh9btw+ncEuAfxK?=
 =?us-ascii?Q?WnpaZ21j4YBq04KADzeP+fHaFJ/eKHGqQX1XS90yYkkO9ELGCsQSsZDv3TZQ?=
 =?us-ascii?Q?Lvn02w/HwW4NkYFtpnDte1iYND5Y+bOGFOuAGDk3VblxqM7YUJkLdAmFraDr?=
 =?us-ascii?Q?+n1kAVXtoyCJE2LLFwFvKvwOvRPm7Gz98C4Rcy4qSDa24iXeO5lj6PBv++Ts?=
 =?us-ascii?Q?zGdRBwHC4Wf3/yQQFVC6uMlt1+yeUtO0pZq3igvHFzJt2q7KMTdO2MdjHJw3?=
 =?us-ascii?Q?3VM/i5gWFr58LgN304TckXffzpdk9+B6GuPU9l/+GI5UBRmdgYvg6gavZ6CP?=
 =?us-ascii?Q?hzP1F3KnPxQUMjU5z7yL41CZVuFY2p9U7N0M9i1i5TwklvkykpIjiNJHVJBG?=
 =?us-ascii?Q?QSioc2X3ZT9KBhTh5XajDFmD3JmSVnaQ6775DM/SH+vaxJOf52tjN+9oii5H?=
 =?us-ascii?Q?+ejvY+jLKs1cLn9WgLuBl+1yyFIziJLQ26fqLb/oTVkYGfUec0084NiiXXma?=
 =?us-ascii?Q?leFPQHqUaSbyZ/DcZh+VQP3ipPondbQyVOCJGr+ZyGRkUSG2aNCA+IZYCork?=
 =?us-ascii?Q?rcEDZgOBHGrZ2JSLps53DtYdKOHdSE+LSWxt2vENy+GwzQNTV7pE6ITjbKAx?=
 =?us-ascii?Q?r1tDHd8Yb0CFoGN6oAFbgPKx+mdfvaindZGSSo/WTA0bbC+VHq0d6jy6LPED?=
 =?us-ascii?Q?NS+6/sWx+xxdlbBDSiHfmtuwypyU+irlr1c/mxNVm/IEx2DWVbwRWa2gNeMk?=
 =?us-ascii?Q?kw/7BI6Sm0atDkeEOJmhRP0udXBAPbgA/vVdEysGqYAeRN/5FpyIw7g0qRl9?=
 =?us-ascii?Q?oJJaxikF4CxmuRIqNR1gUOJomdjnzQX02NpZ8z0GSw9IQjAEJ/VfaQ4j1qEw?=
 =?us-ascii?Q?4kXJ3a7qvCkW0OJPIpkw7oRHaAkvLpbr066Ofljr6UTf2hMRa8r3ilBet4UW?=
 =?us-ascii?Q?oxElOQlmazcx2RdtR24mc/rUwIlYi7/XILtT6J3gL/Btssl7o3Rm1WcVlaqx?=
 =?us-ascii?Q?GPk0H4gu60hC1iahk0mfdNzLSgQ3bPCgPYu8/5FHHolZ3QYl70sHmLOSVnZk?=
 =?us-ascii?Q?gYPkLyfuapndt3CaOS3gLzdPehEJGPcW+/+T1wE0KepRZlj1PuA6cBLrrt9k?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d6a0f6-0028-4dad-c562-08db565778fb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 21:49:49.6660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWrSHZ31JJQDCExg46ou41Ne+N3kGajryxioFZo6OKYhVpt1Y3dpHRJYc36znTXYdY+RBeGTKRaRgzpJ13UiewBQhQUJQa/ctghgCu/374s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6520
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Hi Dave,
> 
> > The QTG ID for a device is retrieved via sending a _DSM method to the ACPI0017 device.
> > The _DSM expects an input package of 4 DWORDS that contains the read latency, write
> > latency, read bandwidth, and write banwidth. These are the caluclated numbers for the
> > path between the CXL device and the CPU. The QTG ID is also exported as a sysfs
> > attribute under the mem device memory partition type:
> > /sys/bus/cxl/devices/memX/ram/qos_class
> > /sys/bus/cxl/devices/memX/pmem/qos_class
> > Only the first QTG ID is exported.
> 
> The QTG DSM returning a list was done to allow for a case of mutual
> incompatibility between the first QTG that is returned for a particular
> performance point and the CFMWS that it points at.
> 
> CFMWS might say 'no pmem in here' but due to some RAM device that is a bit
> slow, we might end up with a QTG DSM response that says put it in that CFMWS.
> 
> Hence the fallback list.
> 
> That is currently hidden by this approach.  It makes things more complex, but
> I'd really like to see the whole of that list rather than just the first element
> presented for each region.  I think it's fine to let userspace then figure
> out if there is a missmatch.

There is some confusion here, the "Only the first QTG ID is exported"
statement is with respect to the case of multiple DSMAS entries per
partition. For the case of multiple platform QoS classes per single
DSMAS I would be ok if this qos_class returned a comma-separated
list/tuple.

So, for example, in a case where DSMAS0 for the 'ram' partition results
in QoS class-ids 0,1,2 and DSMAS1 for the 'ram' partition results in QoS
class-ids 3,4 then /sys/bus/cxl/devices/memX/ram/qos_class would be
allowed to report "0,1,2".
