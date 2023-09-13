Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89514EEB57B
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 02:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjIMC7K (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 22:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjIMC7J (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 22:59:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0691A8
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 19:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694573945; x=1726109945;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tKgwoPCAWy3+CxHqLaY/S5uzMs6sOJ4Ck3/xFF+hJGU=;
  b=NpQbmMWyi1bfWtRrAHXYp7X8FqixG4JWxprPJlHfT3cpY9MprGLD8RBd
   G2KxpSTh3uvP5ew4WJfJ5KfRRrKx7bfvSZLxZM8N6youW/gC+PLsgQsWN
   pP/mBw+z4iExgCBwdWxAcNIBMY8/+b5I358RmhHYP3h29ZlKTrGQX6dOx
   MS24PYIz4CjtdhpiSuGVw5EDmuz3ktxZmC8lCbulPoCEXF2p7x/OT/MhG
   KlY7Ds612KOlJHb/arZ4cWurfG5TOY/Pv7s5w67UxVs3hMPWsD2F4ljkr
   boZwMIadGShVTV8J7vzw2nPdC6Zzvcg410mdqwSeeHo6ETTzmZt7swELl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="442578694"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="442578694"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 19:59:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="773267489"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="773267489"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 19:59:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 19:59:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 19:59:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 19:59:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 19:59:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+yaED5jUrcOvMaPeIV+/MfXYpuj0l6o72XDhHI5HKgqbtBVzjlVgwd2WfP1NVeySeurhuwCfH3Mn0k2RRdr1FqgClFFmYOAEMsFO8/y2Io/VwHNfOfD3F5Cd4KB4KPL+OtVcvjUsNyslLiCfoXbUw4mfulbUU+zPXJX10lrXtZB1ItPw97NILAldGxnTGJY8UDcMh+aY3zgP0a/Phg+YNlLwvP/z5FLRRxtZFfSlx1gw75pj8xu4+Oxxq9jU/P/tA0LqmLr4wgsV1TN27L5bEZPpSXsBxh8eTRpq30xd0TNfLjAVUtvgzWUgoRtOZzz3UMJHLp0v8n/HbUvIANrYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxHwwNCr1WbVOiIe+Fz/F7ivcGRU9JPGeWvR4WNud7Q=;
 b=XmeKHceodAgBIEhIKE16eg4MoWF4pdXvC5bm9OazQIjLMsymKFznj3le7Y6F2ksoDjTXrDEP+TKglSZY+iw+sFZgXnb7tKBAX6Q8aQ3f4dK6FoE9wTJ+ByzrBVADjbeLz4HHKXm7ZPHAZr9J53ADGMUwgW4toenOoW/Zm1y2hY+DMrzn++eMmWS/zE0Rl2Ld66k5T2QGUeOsuleiZjNIaIdmckeQEqScS/ppK3xzkZONGEj/uPSHoe8FZ6StbaLtaDcHweNqcejJa3apMji+krtpK9htUhnv/ZKLk49WgcywKE5hQBm6pgWpXHvHl7C/sEZxnmIgB2KHje0i+7/nWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7879.namprd11.prod.outlook.com (2603:10b6:8:f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Wed, 13 Sep
 2023 02:59:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 02:59:02 +0000
Date:   Tue, 12 Sep 2023 19:58:59 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH ndctl] test/cxl-update-firmware: Fix checksum sysfs query
Message-ID: <6501257312efa_71e582940@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230912-cxl-fw-test-fix-v1-1-bc544002cd02@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230912-cxl-fw-test-fix-v1-1-bc544002cd02@intel.com>
X-ClientProxiedBy: MW4PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:303:b6::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: a46bdd20-261c-48a8-3a20-08dbb4056230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUeQdy0L6tIg1TmvSMrFmDpAytvYulAZhjrLOFg3ZrHislZCrRhq4QMMt5bL7UFjWQKfM9UopvURe81XeNZDDn1qGDeQfyB26EvWDP/t5XpKr8sVpHuRia8I8xhwaPvD74CzMmsQ7mMzlwHfUfGVpBXuoB+Cbe4sR5BotymqkWda7hrTZ8MteQcUXC1a+aOMlzxjILhSJhITNuQTpjLywHoNn9BxrGgTGBc7BsR4qEAK88OWq5Na8doR4xp3xXNDVCjceI+zTGMBEbfHMSCFNIDdBOXjZs2I2aJrJ9h3IpYszXsSeorog+2PliPqvFYG5He3IwdlirzPEc9HWNgyLeXDkMUwjInAglp0o426KYYcjUkpj9NdgDWjNUwSShm2Rn+ef3aeMt4f4yfxksB9fTa0XIwUkY2ZJhHUt3z15JLdYkK8pCEwXR64MmhxlA/9Ejb4D4d2K7E7XT18C59HB8g4F0zg7S/aJ7WctZ2ffgAXUrjfyW1pO7wUH9yXRmuod+8C5Bs2vJwyiHmvuPhJc5DraqBF5FJ0Mf+SmpZZgREk8pvEG2TVhZRHZ90hf1ex
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199024)(186009)(1800799009)(6486002)(6506007)(6666004)(83380400001)(6512007)(478600001)(15650500001)(4744005)(2906002)(9686003)(66946007)(66476007)(66556008)(107886003)(5660300002)(316002)(110136005)(8676002)(41300700001)(8936002)(4326008)(26005)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K/z5kWLBNm6NNMnZIHg4kd8akKoslZkP3CIyl3GmbkJ5HAxz+fhZDQoR0Wgs?=
 =?us-ascii?Q?5vYa8kjbkL//bIE6ngEN/ZjGZTs/5oUN3skzMCRtw0TPD7X4s9l2tbwreZ8G?=
 =?us-ascii?Q?W9U5pJ5nM4njHFJ7awShfSxJbxZP6oEiTdld2ouTkDTgRZjPl9KRkIP87/K8?=
 =?us-ascii?Q?h2dEzIPnx+8NDYNtvj+q+kVYCM+4oIoEPJQKf7zCN13HC5to69rTIjVsQu/+?=
 =?us-ascii?Q?JWihqv5PkvYaUpUwYNAAlvU/kyPuiH6dXexR7VfIpgzy+sHQy83lAdN/obQH?=
 =?us-ascii?Q?uE3AJ3oz9PYOHW7F8YI6jvc+z86yane2dp1Rx7V3U89UX05Bw1ZsijEut1PH?=
 =?us-ascii?Q?O4oxNWhR+7ta4P1kmam9D2dXpsojMMtDzSh6zQDvTbwexZGzd88rVUZzR9sS?=
 =?us-ascii?Q?MKA0ZX+VqKckPbEM2Mb30qKLXjd7l9MzfqC4o4C/4FXL6vZwhnHZGjxLynLM?=
 =?us-ascii?Q?TXjCDjOerTiTg+NrkKcIszHd9GWdue4o/rL78aEX1gyQ6caNr/z3l1ni/QP6?=
 =?us-ascii?Q?5YEgGVZzV2FewLlKdBSucqjInlniMQRKFLcgddmuLwmzaXVBSvyInnGnVG38?=
 =?us-ascii?Q?O2sUETlCmXBCkEJiBQYLc1HqAb/Dsvu9D+bWa2SPRtQ4A3vX8DUF6F27Wzrc?=
 =?us-ascii?Q?5LPoTewRdVTZWtvuloLXHvjOcmcjQO4Zg1EG3KHqPhYHNh9Dbj5esSzpaN6c?=
 =?us-ascii?Q?lftIV0u6VwhYBrmqJxpLUs/LbjldwZQNrzdc8ekUmgP/x1bYdCXSgVDqg9PS?=
 =?us-ascii?Q?A3EoEtqN1waKnRwmKloO8zzNLa69oLuS3K40j3dvTeQvo/UcxQfb/ZZRRvVY?=
 =?us-ascii?Q?ZysrMRxs5vT387o3NYzPjrbRi7+CHXP50NVRPMFSBZBQxEeS2rMEqx4nKC9M?=
 =?us-ascii?Q?EwM5XztrL66RTXsE53Bq1zTZqfnqe0edWzHoRTsLGe91o1cFCuBYRxWqFM9I?=
 =?us-ascii?Q?BbtqiIr5vWCeyJ5Ryui3bNiGDt+vMgWYLx8Gz8F0c5hP8GxwCPgIiX3mIOJ2?=
 =?us-ascii?Q?SQzq9ZNCIhtsjuZhZj3uqGefrwJefIV10h0W0mtW5WYYiAN0qHZIn4hiyKtw?=
 =?us-ascii?Q?kUZwEQTIiCxJESQ84ncHdcOwTn1AlXOBfSSKt/hWNZ3xjRMMKSH1jqu08h/z?=
 =?us-ascii?Q?nt3g1udoDIaHBlaNjsum5If3jzEVEtljTGMHkMQHTv/XydcG7ySWWlLLegLA?=
 =?us-ascii?Q?Ux4fwThtTp90/0gWPjVqk907SuMyYboCbo6/RI+BRJmpBB9N8A4HK4Rn3Ah0?=
 =?us-ascii?Q?3e//5DEU1PaRzmxjo5ytVtTP+C79vJ2inPSbnzD/k/FzsXWVxLxJmTLZakGg?=
 =?us-ascii?Q?d89l2lKEGE31JIyAz0bDQiw3wM7Pq6VkbiA+/HH3MJ7SaOIjl+EekRJs338i?=
 =?us-ascii?Q?DRWSIKFqFVW9qBsMBMYus/0MfMgCg4oXeXgkzVbeSnFhUYyiRWXqMoSXJK5l?=
 =?us-ascii?Q?xNvw5lkG4v3De9XXW5w7HaRnw960j7xK0axuIwx6UwKXnXMfhUQgdYK2bELF?=
 =?us-ascii?Q?4sQ+4mpa+9XGACr42Zdk77giS6WM0Y7QZ2J/JestVxe4iZmZGdz5GqElz8/s?=
 =?us-ascii?Q?ycDAgvTV/bt0bKmBCCk5bQgyUkyv/cvhbgD7/tk0J4AY+cniu7DjFIA6kNr1?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a46bdd20-261c-48a8-3a20-08dbb4056230
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 02:59:02.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avuEeIMT59JGYv47GfPTFv3R/6sDVM1/0015W2u3vtJ7vg2xouz753ddLYx2hgNu5O5evOC4DRl5mKM847S0VlzJZJDerg306DEEj/eITE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7879
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ira Weiny wrote:
> The cxl-update-firmware test is failing on 6.5 and recent 6.6-rc
> kernels.
> 
> The checksum check incorrectly uses the mem device id to form the host
> name when checking the firmware checksum.
> 
> Get the host value from the mem device and use that in the query.
> 
> Fixes: 813809ed318f ("test/cxl-update-firmware: add a unit test for firmware update")
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>


Works for me:

Tested-by: Dan Williams <dan.j.williams@intel.com>
