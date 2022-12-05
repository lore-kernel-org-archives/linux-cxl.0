Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C164C4332F
	for <linux-cxl@archiver.kernel.org>; Mon,  5 Dec 2022 20:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiLEUQJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 15:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbiLEUQC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 15:16:02 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77355286FB
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 12:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670271361; x=1701807361;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=g5sIvF9Kw3s4cekX4aBsuPO0ClV+G1JrPVDJvNNHeAg=;
  b=Qs35zZLxq2Osz83ndSndnXM1+GCytIC0l2apLOF06HhZbOq4wUsduXAv
   HSFCvZd1L2yUkw8UPAA9r3Qp1CsioHtLmWbxNt5SrdlZdelRwaoaOwkKD
   BWrJEZXIanvfy3DsJCWjvuo6z2CldF8L4LA3RYTUBrQoO5l0EJs2sxwZF
   Axu22V+4qWF64kzDfAJG2QMJOqAD0TQ8u4vvqmKHT9pvU8Lo0IPm+VX9J
   gJVglFkwS+V9WxFkgUUulzdOzeG3glBusZecj6Zh7HOSiuhD3fA1B/UTU
   N5rQli0wZPwwwPoj/xEAOwl4IloFe3qBY7+fWHDVcovVNzLX+T/JzZV+O
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="378615917"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="378615917"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 12:15:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="623640798"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="623640798"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 05 Dec 2022 12:15:40 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 12:15:40 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 12:15:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 12:15:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 12:15:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eelLYUhiA1RGF5PsI6GAyr5xdcp/cHEMrj+oYmde/jN+dQXYpdCkrNecNLQL6aC4bA/9ZQ4VVeOKJAGeFLqRL8tfXdq6mFbHmntQrCQYwWBoJ8hcB0AW7ECPFKg1mB5TjOASCIe8OKWI+I40zun4VmQThDrhxqD4SZogwKzHxsyzl8d6ORH5R9wi58wwLu1WNPDH8Agx1Q2cl0n+EJEfMkOM5hXr+r1yPSK1VskbXT34AiMEHtpXs1V9fdMmmisk5iY+0pykWpHLGvZPjzaGRksiWFKSB54Q/TWrbJNb+4YowXetTBwmk3Uy97LXDSKgM6TjDXa4sirnYvYPviRXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Melu7mgmMtB4UE+7sXTN0enyKw35SbS9MM7j12rRm9o=;
 b=FjgEJ8ELGBolNncMwObWjwguFLp3KC7twFxh+CUBa0NKYwaXblgFHlXaH02mE9OITArH/Tyf0SpX3WdY7rZxOeUEhugHnLsBaKuxsWzk5RiWtpBWpvcjUxEjmGi+HmdmDrN1uRX0Btiixn2M9gupNZHlpWV+1clwLdqp8RM+XBvraR4EoOKP3gozXhirWiQVTtZnOrG443VxcGEwg/rIPe7G4pXfjfJ4GSCD2k7tBmKYLTbTNlqGgcNrW0wwfvWD9UycHUNSTJRPyggWq2zSAgGfhlT4Mchad7lPFc/ndVP6SJ2zrl8/LpMt9gLqDJmOLqnMvYIlDBYb0JiFXa3q+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY8PR11MB7825.namprd11.prod.outlook.com
 (2603:10b6:930:71::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 20:15:38 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 20:15:38 +0000
Date:   Mon, 5 Dec 2022 12:15:36 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] cxl/acpi: Fail decoder add if CXIMS for HBIG is missing
Message-ID: <638e5168d654_3cbe0294b0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221205002951.1788783-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221205002951.1788783-1-alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:332::22) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CY8PR11MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c1ef48-6132-4cdf-72c6-08dad6fd79ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zITV6Fahubxp/T2ukXTqgP2FZhfDyQFxFVQ4198S/MEIReKoGNFoSjHKOy8CP80qAKkLE0ts6r7dHmnrjkQkWfYHinMBr2bimqN4D/D8eYbRCr6dSj+cm7wzkdlRQMol1EMKaLQeOxlQKCtzeoFAXmTTQ3k73BgMIahrIeDBHSbgdFuIdapTyzGAyWCooSS6qGvy7uLgcl18rumlG/L22RThOcbnKi8KZL4c8XhEW78nRk6p72HQwVYb1/EWr0NyJwqaTs9gsYXIhIru7z++eE46M0Q1B3c3LT4jRFiRKSN+GBmvjI+rm9P7HZPLnHco+VpfZ4bxcgOoVXLmmjiPd5a1+M8q5EwPrsXRlObzfIPtq/lxxcupEpK2I3Uet7coWph47i26lWngnhi59pwfT73MO1GQASzDB9O0NQqNpO1WM1wKTbD8yv5Crzl+67WLNuPeCPxqC3wGBXkIGfZg4XqCyGMO1K6JvaEMpoqe3cKcPCHkiTjKgaS2fJtQuyN9u9c4qeJ/Vmu4JKqN9h3maLO5Lux2qre5GHQAkJdhMLj7yFmwCdxW1ue5JT1BmslhuN6x/WX87nmCEl0l9cgRr5hEX2o+e/xCpjrFKaK5Jg1eLV9vtQ++/Ogsey7jrSMqRG3xHjZatYvvl56ExpRINQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199015)(86362001)(6506007)(478600001)(6486002)(6512007)(38100700002)(82960400001)(83380400001)(186003)(8676002)(5660300002)(41300700001)(9686003)(26005)(4326008)(66476007)(66556008)(66946007)(316002)(8936002)(6636002)(2906002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BCRyLvjtulTkm+OLwla9E4gw34x/n4x8LlA1WZO+g5cQWSfrElhF7rFCMSjD?=
 =?us-ascii?Q?1mV6hj+YcdN6/yxPpw/E5Q1RMgEgq4zBblJbwqivXPJ+uS8Hz9Jpy2eG1Ah0?=
 =?us-ascii?Q?B6r31PLeUGLy1f2WIwaxEg3LlLOk8MZqcC2+wMXuEyF6fzw94BMEEk3e0qj4?=
 =?us-ascii?Q?3mrIiJht4UcakeJFfJY8Ue09wK3hS1PCf2rzccF9Z+5+M5/FvF48BmhF4+1e?=
 =?us-ascii?Q?g4md6zrf5n/5nMiECcVLGPUJ9MP/FRbzHusewRpNUFv9geSLY25WGldnyf42?=
 =?us-ascii?Q?Mtokyswu6JtzocSNVtUQ9aVtaivyD+8+nW49cRlmPN8xy60LRtigAZpOzKuU?=
 =?us-ascii?Q?ZjWfH6zUdM8YpQl/A8+/vaA4DT7DApw5ycHF5AUFstX98voZk9UKFspDKdA6?=
 =?us-ascii?Q?e4lmAqpMRgfLzW7Vh7wWtqkvOZG86SJmAe7ueQkQT6CkS+MkMhobNz3FJQVT?=
 =?us-ascii?Q?AR7tUe+Bxb6Z6+aDiE+a9ngZT9UwMLAjUJTu+1P3p21JMpKItEoLCDxVXNFQ?=
 =?us-ascii?Q?PIYz+BQYpwAq3vt3s2oFUMaAKSI5kcadxTEEUZcu4l7S9P81X/vJSjxtXvnR?=
 =?us-ascii?Q?9Ws1QlOsTUU3EMKOxPTqaA/eYxPbj7nzOp8H9VeTaANYiZqzQkTqch2ZMjKl?=
 =?us-ascii?Q?PzDq5q/WgYDTEwuScnizfIEEaCtbz+m18BzVjVkqMNxWeuucRHW6bJP3yS3w?=
 =?us-ascii?Q?hUuhBW2rWKaOBqddmQgY1fZv7KLHFow+in2dBJ0HAadPnt4Maf1isgQ1INLN?=
 =?us-ascii?Q?8Diom8zatEY4a6RLGMx0/NsZ1pontBBaHgeeTrM45GBoxZUEkbIm/vOAt//8?=
 =?us-ascii?Q?VtYr6/PcrMeumxh3FB9m6QvPwFhydBwhHFhxdr1/O3JLorffb9gtCBRQEbUY?=
 =?us-ascii?Q?55fRLQyTNuVYL7XCDR7Mdr5WXMuTP8L8BmbUWxNdUJB7m8lui6qrf9fVLFy7?=
 =?us-ascii?Q?AdHCDVK6+fagBma44JT1/e52uDEqrrIJ4npox39AVTcH48yUvz752gkh0/4k?=
 =?us-ascii?Q?i7bqsgnKUGVvzR4V8gjExql0UGzKNuI9AOlAr0oYkoCgUre3B1MlMzcUUkK9?=
 =?us-ascii?Q?/8Uq5+7g4G69KZ/elCxMSvqp7vau3jMXNILmCVl/3i86b7MFOnFKoJdn2oDb?=
 =?us-ascii?Q?TnZnH4HxV2LZQ+o9YFM4YNV+m2OCw3lUNjnKgpvWyn5Q4wJwPyRZuolD8ZS7?=
 =?us-ascii?Q?LrG4+xFMWQAO+Kxjb8CN328gDzJ13ur2OVkqaG6+HZTyOslKGOf9wOVp0T46?=
 =?us-ascii?Q?hH6kA81Bv37+GMeFXKwsc01ktB32ew3AVbc72pq1dPz4mLpOV1q9ELrWsh/D?=
 =?us-ascii?Q?vxR9L/vgaGripoVV5DuKf3Lrb+KJGwOfqhFuI6f5vr0pys7DkXhHD8K4Sf/j?=
 =?us-ascii?Q?31hmaog3S4H/1jL9B7jdmVZ0lZDpRbM3raaPurCyIuRva58px2dViU6jdPrO?=
 =?us-ascii?Q?pAMPTw/Erf6dQJ+0KB6UkYJzv9KIFOH50MEZVYeUgO/72YawF3HI6hkTQ2cC?=
 =?us-ascii?Q?eWVtdoKB54yD70WQ9nGhQ+RBE9FkyWsVper/iBT+MRUkl1NA3URBtMCAocEA?=
 =?us-ascii?Q?3IK9cgZIeMyWse84MWIp3yjsmPTs/yaTO9uuBUJE270iFu8qz9dA699vG0ju?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c1ef48-6132-4cdf-72c6-08dad6fd79ae
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 20:15:38.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbkGbS+KlLSrbAngETvcsA8z7bmQhlPwP/ede1Rhf30Vt9pSYmxRk678//bMvEaP5PR8JK6zZGsP3uYIPVPSQu2xjIOCc993kmAcnSuCGXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7825
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The BIOS provided CXIMS (CXL XOR Interleave Math Structure) is required
> for calculating a targets position in an interleave list during region
> creation. The CXL driver expects to discover a CXIMS that matches the
> HBIG (Host Bridge Interleave Granularity) and stores the xormaps found
> in that CXIMS for retrieval during region creation.
> 
> If there is no CXIMS for an HBIG, no maps are stored. That leads to a
> NULL pointer dereference at xormap retrieval during region creation.
> 
> Add a check during ACPI probe for the case of no matching CXIMS. Emit
> an error message and fail to add the decoder.
> 
> Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> Not sure the Commit-ID in Fixes tag will persist. (from cxl/pending)

Looks good to me, and yes that commit-id is stable even with the recent
rebase to fixup some authorship in the for-6.2/cxl-rch branch.
