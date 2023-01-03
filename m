Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4A4C4708D
	for <linux-cxl@archiver.kernel.org>; Tue,  3 Jan 2023 19:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbjACTFn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Jan 2023 14:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238754AbjACTFb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Jan 2023 14:05:31 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4AF13D2B
        for <linux-cxl@vger.kernel.org>; Tue,  3 Jan 2023 11:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672772730; x=1704308730;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DSgosW0nve8eLytruLOzcxqisoRwfPj3wR2g7RQktOY=;
  b=Bkn+vW9faqfTrojgWHQs57IFtFH/3ENQPE49M/taizS7FeInhEnKZD3+
   sqJSYO0m3A+8JUrB1K/JiMxpiu5PR3Tu8HPH3/NaHwYoXAUAQxILZoj0d
   T6Af1+QpepSzjouy5CLSeVyDNtIl8rFLTJU04oZ5Z4baVLc6RqduzXlLN
   QVhEur/5vdogu4KRbx7ha0pXk/JxLlp3bHyQPGLagqa0gMcovzkj/Yo9z
   2BNPJSaBNspa/LHVnyCR1mmypUzKWybZ68vX0r3g7gnx7MLjRLFlKYi/b
   7qMcNia0hEiOqkp7VTEcEguutRzzetIC/P3hn7gEOsQdyALv2e/yLwDsd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="309507445"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="309507445"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 11:05:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="900288179"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="900288179"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jan 2023 11:05:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 11:05:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 11:05:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 11:05:28 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 11:05:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=broHsRhPCEKcQfK3GnRLrN00jXCVkoxU30DMFyOBBpGIp05Rmys0faFFWWLokiP8UixU3ORu7yC/8L2sJngDHWcKijueTNehst/BmDNtrHNxByqnblfaBupykwgsU3CSfYGpWVSP8uc2i0M0WgzrLc0JYxSGNhgCCnfRVKPlw9LBHivLCwqYjC7+Z+QfUEpCazJrB2s4B/+1f9iEgMMk9irWpHHNnmYt0uVEvFvC0GTwfLsm/Rfu2Rv5IlwbLHnzJuW592NtVK26YurpqKqX8ktGzaOD68eL5gj+xZOdBcUGNtAc+K7/ACdXawfsLVbAJfA1rfE0/3+T4BBziAtUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQfvRwkRzMQtZLEmAeAcMnUlmyZfGCQ+BxP71gs8RwE=;
 b=fpwPnGGh3jjySwkw5BmdFQfH61Hvu5n4++CFfevHqu2Yq2cBYkcye/0HGFhq2M+hgMjTqi20ilQWQWPYIdTr7GOl/tD8FQ99VE7xGRsRPFdPIdI+vOCaDW8O+hiIYLjjiTlh9R7pgzT2BeJDqUoBlJKbenOmAza2uy1fvTSdlN4DF0QcoaYX467eFoPXASRsEzDzhXz3XU6afjNz0IfgzOoYMwocJJ1WLP+SOGP/2Pbv7R6gDQ/O2dH3N9gCtO00dbKefN72W5pAakMjIUjioh4leMyG8AlfQVuVg9xqqyMt08j4BDhG9DHUq0cF6JaXMQLevXLPtzXyeoizqdbgbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB6696.namprd11.prod.outlook.com
 (2603:10b6:a03:44f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 19:05:25 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::8dee:cc20:8c44:42dd%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:05:25 +0000
Date:   Tue, 3 Jan 2023 11:05:22 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Fan Ni <fan.ni@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "sunfishho12@gmail.com" <sunfishho12@gmail.com>,
        Fan Ni <fan.ni@samsung.com>
Subject: RE: [ndctl PATCH 0/2] cxl-list: Construct CXL topology graph images
Message-ID: <63b47c72a3cc4_5174129497@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20221220182621uscas1p22da97d084545a7b00f7bf7ea4df7ee3c@uscas1p2.samsung.com>
 <20221220182510.2734032-1-fan.ni@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221220182510.2734032-1-fan.ni@samsung.com>
X-ClientProxiedBy: SJ0PR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:a03:333::9) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ0PR11MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 91daca55-38b1-47cb-8c16-08daedbd7884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5EYhv+Fo+HWw6jrAcg1bYVNrPYskZK84YoXKKa6x9znsEZnf4jtiZ7GnF35ejzKnsEEKxmsHsnNxVQ9k5v5gv8zfqqIRCyoOmTnxyASjBP0/g+jnkK2wN9GhBeHIf5jXQsqqinWqXP1kJdVoGC252sgaCXLmhpnrsciQg4inw39ZKYEtgqeAFsllN4jOnyxq9ge7ZtYVZE/uYjwMf7dMJEB5bImXaC+wzbAJ6qs6l8KhMCJULU1ewyDAFv8XeG+c8XZ942sWPUNmJw1N1fMmv5zUqsgi+lbTlEa/CQKweSwevZSchdDEw9ZloMGQeYqx92zbR1ZWdHrIaE5xnYUK6gdrlwkkKAOFvqH32b7DaxmaI08ZCxouwXEtXJQ0qZ/BLPehvpT4ZTfuWotJYUU6577bDF3zueEfioeYYhVqd4rJdRRxK1Bv3sOx5keT7ZUEq4sj8vKDHdQru2IExY1fO5iO/WEYiaQMM6pwHuhtjWwsQr+//PvNr0kI42TvOg07M6BQXTqILqi9AUNvXnyYV1mzhXlkqLAxLMMn8OrU9EjPw4d+aWzI6TWSkY/icfmFs00mRaAocp6Y7iO/YGM1jGUDDtazuML0xV+kdI3iDEPNt6QJxqV1NqEte5p+BbD9cNm625uFklR5/tyAxbZ9OmBDcZvzme6crCr4QWOV2077kLdS6MKZhv+prNcWkPUTGUZS7QyU8NyrZIvpi7SzU+VPCZon3504E/LHTVclQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199015)(5660300002)(2906002)(8936002)(8676002)(4326008)(41300700001)(478600001)(316002)(66476007)(54906003)(66946007)(110136005)(66556008)(966005)(6486002)(6666004)(26005)(6512007)(9686003)(6506007)(83380400001)(82960400001)(186003)(38100700002)(86362001)(22166006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GFw8mvJI8wH/nwqDPqeU/yAXMKPmXQsjNNa17Bynz74BJUQlR5+EuptQtW2G?=
 =?us-ascii?Q?NPDsjNtVsnbF51pKRgS3ReWD8M91Mjk3xRyBj8UAL2tronopCjOVRuFrz4z5?=
 =?us-ascii?Q?Hcd8XwMB5vue67vmMZw/9aZn2b2xDuGb1jHGH3mmgVOmYiriuYfHgIl1gkeQ?=
 =?us-ascii?Q?KHQJkQg04edZWHEjDqKdrAXFaOUyxQ0K9K+58tSw36lzGm36XydNiRqX5qC9?=
 =?us-ascii?Q?drH+UA3VYmliqo7O06a6DKlQMPRbXD2RkJz60OnqeeciI9l1nCKIccMJDYXR?=
 =?us-ascii?Q?4CpPFURLkelg13QETGiVZAA6jIPiF048vStQJIjPekDecjYE7WaFgMfzDuoW?=
 =?us-ascii?Q?F2KQMQklc+gVGxPczhovxz6uq3TYihZFDSP/7O7Cmpy6cGfy0wD6lnJXLQNP?=
 =?us-ascii?Q?90ifceH3ENo0XR1+fQOUbkqBntozhuOOQ53+29LXMDvHP0QEm7d7Ji7PoeLp?=
 =?us-ascii?Q?PUyNZ34lKQ9xKIiCW+piVIA59DQ/1lWzQvwMYQhK/bOVud0T/AyOojahtUZo?=
 =?us-ascii?Q?iPkXRMWFlk3Ib3ICWvOlLx1mob37hBJVy+ZRmec1cXWhQwa5EH4JvH+iVGAJ?=
 =?us-ascii?Q?LFSR4acJfdO55uDKYmDeIi7dRHBkTCdiHUPRmFw2gjSD+88rVJFi6qt8k0i7?=
 =?us-ascii?Q?QO1/lOyH4u/eA1i6GmMb3VGs31hUWMfZj0YC8RFyBHWbMQDy95VQmNtvWWk3?=
 =?us-ascii?Q?htZ7ac2558ZWn1yWMsC4qWX1UJzsR7oBObVT0sbYejqNh/ka//c5e665Tcnj?=
 =?us-ascii?Q?r2V8gue5stvWtwA0OSRCg2EQew3aYuOY/4WmknR/H1TWif/Hb3ivzCgcnYgR?=
 =?us-ascii?Q?SjZro9wuk7XhRMLSziO5xapkZ59sqf2cqBnbwhw07GJkBJn6TeP3eqcry3dz?=
 =?us-ascii?Q?oHq2Xp4fB5dvHxXoDNwNzefd+199MYURkmCcGv6or1AGFZRQ7+WujcE22qr5?=
 =?us-ascii?Q?zjzv3id1QcCauB5CTQeZmPA1ElKJxlfY/38IwhAX7YGwOt1I9CUk15ctxhvV?=
 =?us-ascii?Q?MO+AqCgvYyde2R8YqQX4vRiNO/nopFUjgljyNhH/vDweeRK3Aw+hkk6auAiG?=
 =?us-ascii?Q?6efBQbILB8Zdh+Or2+D8+ESVuMknHBVVC2e/gLIKPzGkW5TZMdMh1PyUwiYI?=
 =?us-ascii?Q?hqeOVQy7SThdZ1H1/wWKQF8ykUhh5FACahIRF0xcp/IKnzUDuOKwcw5QfvnG?=
 =?us-ascii?Q?cf+OyL94VTZs1vDui0pewrwunMc6qxafpdJN8ESNSljO89lIKVRVwqbBUNXq?=
 =?us-ascii?Q?9Q7JjIxKlq+FKXqJsOeLLM9FWkmsoPubKkKYhGfCk4xdFwTVCIMZLhNjBlGl?=
 =?us-ascii?Q?9qtOFyIS4WZgxvjs/Qq1UObLBzhuC1AdVaYyJCJoV9uPBqOxTDRFHV420us8?=
 =?us-ascii?Q?DDL1p7isLhv3a3CQypjWhDB+Rqx30D4zEDLEWPIJN4cfk3Wyr3F7EYfRH4aU?=
 =?us-ascii?Q?q0PHQvljoHc1tt3O52skNjSi72p0tG1RrYA2U8m0vcarcETO1sUgbsQKhUCq?=
 =?us-ascii?Q?Jckry4TnGtImV9b1L+5wVCkhgxxQpJwUIvR5vbGScg7iTsUDNer9JwVWOw7m?=
 =?us-ascii?Q?AIIErZL0oO5tnCaEINySIgeZ4It1yC+K2RtZNjSkJ9pSICfDvsGrhNZjndcF?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91daca55-38b1-47cb-8c16-08daedbd7884
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 19:05:25.5088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfndTAsiHute4LXYgG+dLeRO4ihNg93A6esZKAo1knvNvZI5lbBvPo1VbQ6YU7hJZ1dg40EUS5nWt8CQ6a5uBkNkz9UGZ9cvwb6kJUnUCoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6696
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fan Ni wrote:
> This patch series extends the `cxl list` subcommand to show the cxl
> topology visually. Mattew Ho first worked on the code and provided an
> initial patch as list below[1].

Thanks for picking this up, it looks like a useful addition to me.

> 
> This patch series includes the following two patches,
> 1) Patch 1 adds a parent_dport attribute to ports and type 3 memory devices to
> show which downstream port a component is attached. This attribute will be used
> in patch 2 to generate the cxl topology graph.

I had a similar patch to do this here:

http://lore.kernel.org/r/167053491908.582963.7783814693644991382.stgit@dwillia2-xfh.jf.intel.com

The biggest difference I see is that your version adds 'parent_dport' to
memdevs where mine keeps it purely an 'port' attribute. So the listing
needs to have --endpoints to get the memdev to 'parent_dport'
assocation.

> 2) Patch 2 extends the `cxl list` subcommand to dump the cxl topology to a
> json format file or generate a graph showing the cxl topology. To use the
> extended function, the option `-o output.suffix` is added. Acceptable output
> suffixes include .jpeg, .jpg and .png for generating a graph and for other
> suffix, it will dump the json-formatted cxl topology to the file, which
> can be used the input file (with --input option) to generate the graph
> later.

I notice that the implementation enforces some implicit listing options,
disables --endpoints, and does some magic with looking at the suffix to
know what to write to the output file. That feels too restrictive and
makes the 'list' command a bit more difficult to reason about. How about
decoupling the support from 'list'? I am thinking of a scheme like this:

   cxl list -vvv | cxl graph -o png > cxl-topo.png

This has a few advantages:
- The graphviz build dependency can be made optional where the user can
  detect if the support is present in the build by the availability of
  the 'graph' subcommand.
- Listings can be created on one system and graphed on another which
  among other usages is useful for debugging topologies over email.
- The 'graph' subcommand can parse and optionally warn about the input
  json rather than implicit forcing of listing options.
- The json can go through additional filtering before being graphed:

    cxl list -vvv $basic_filters | jq $advanced_filters | cxl graph -o png > out

Thoughts?
