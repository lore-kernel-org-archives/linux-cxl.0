Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BFDC61DA3
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 01:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjBVBsI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 20:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBVBsH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 20:48:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5F6AD10
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 17:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677030487; x=1708566487;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fc2c6hV//Td2KkssA1bSVo1zVhaVGS+fmDEx776LU2g=;
  b=hNRDMHE0ufWrVDZzbH9AYxbtyqV4XMFoZTWszmjKI8NGGVQz8LMKXkRY
   RFc3KavugC/M84i4TofO0s/3hA3w0l9+tLWD8GlEw+C2ZP7xnUElo1gOR
   m97hCG8GhsBoWyWshj1vfr6PK7sb77X5Q7bB4jDc8JfnGVZwtbILm+1vP
   SssI/8adCvzNKJx+Z4BRkBX0iAdPqWPjvH02CC3jZX+7bQEKmu3kaAXha
   eIY9youqm/DpsSIqlr+rvfv6Am/EMXZPxEXHLdjiTQwU70O/iBUcpUZa7
   Gh+1Zvi5iVLy73F0YWpfiffMJIkDqZO7ch7igTn2fSFhWVfZern3sULze
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="331476080"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="331476080"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:48:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="760776203"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="760776203"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2023 17:48:05 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 17:48:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 17:48:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 17:48:04 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 17:48:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpQ297mQoRzwEq6Uxa9UgVPFCK6RxYw6m/FLsMHE+cRrafhiRqfFZLG7hRlqOW1ekLin5KGCaELp7EWK10BEzOe46ZKSCNRzxaBUKvl2W2cx22J9dY10n1Djpy8l5/ZusopMIUrOCU9G2NYBgLGTXZn9/guUUyE/NMD2ErJdmvWUjwWZyPzPblqT7rq2Z9m486JSIp2dLOH3b+ZRd/HOOJAYfkunhll4is5YQrxuqS9216wdmUREeCHJTefQdFxCQ0IA7HDfBarKcRVFCV4G46RwCrNSabH/ShJjXnExWQkmfVYA4Z320xwStY+RGMZVRj7v1Cr2uhaXoMJn4mTU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOpxDQJoR1BRDCbVSEyFgbvMAdzwfpazgfuKlXYNhcw=;
 b=ZaY2ArSyO9Kcbv9lBvnhhWvBJZ7nSCCAcPGqPAar5JxqWUVHkrd4TWDsjj8NxCiQdC1bjIZ5MaXPEMY4wFx2CC4nqumQSfy23NMY8crUCeuJqKVr0YWx5wehNqY2WBMXKGK8yXagdB8Ei+AzR4oOYe7EaeSMchV7usHaHc+S1+Ew21hDgpp0cTGSCq1wLQna/ty+UghrckVBPkLgrr5QC9IpmTzyZ8Dkmi8JlNksk7pK08EyN1UjNF3BBffC2tH21J/bXbGsBUSOTYj7nUkkbjd+DDnrysdX0OOMD/6HjnYd6qchoj0OeYJ28JxEWcxJm8Vpw0VN+UNnWDfjISABFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB7835.namprd11.prod.outlook.com (2603:10b6:8:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 01:48:01 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%8]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 01:48:01 +0000
Date:   Tue, 21 Feb 2023 17:47:58 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        "Markus Armbruster" <armbru@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH 2/6] hw/cxl: rename mailbox return code type from
 ret_code to CXLRetCode
Message-ID: <63f5744e40c11_1dd2fc294e1@iweiny-mobl.notmuch>
References: <20230217181812.26995-1-Jonathan.Cameron@huawei.com>
 <20230217181812.26995-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230217181812.26995-3-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BYAPR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:a03:100::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 44724794-8987-4c12-cf9b-08db1476d50b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTwZ6O5podnCfLJWZPbKpOfuGNWx5U76cGyGYzoI8KIAthLqhmipzpsVlu6VmDie+NqC/WCAtZKIhTQxxUuNvRkdlAgJoaqR4WW8BM9ilA9HB/N1NYfH1xScFBDQR6cJk5W5HAcL3HdCV/rRZR3W4mqU1IBCQz/2qpe9rrqhAYPadFOzlKGqu8m4KYYsxXjQE2dXK+5BYSxqEAAqL+r0LfvOizqqRUf8a3Cw1Ty4KaX5NjvqSYe5pkpuRYJypeu8+tARb6rfOjOAkEZHtp3rNJxv03Y7mWCj2UJnYlPpHHpQ+mdSDU7voDr3/eYUySFVsnrh0WdfA0NLUX+Ljz4/4I8azwBaRBqBUVSIQ66yhI1LKtJZgsaN4BMxmyIjQUfu9JWfb7ITXcN1up1mFAzPgOaiJ8K4D1t0tOerRWPC03ez4WZ6Di0bWzLo+/3M22T6BWuzbE3Ud/gUXOc4pZkBE7QDacArc19yzLnBquvo4cV95uvFiRvz37JzxZ6f0uYrsch3NbGguduRDjCB0rX1opa4WThCS1NUp7n4v4dylnlkLvk1+F/L4girMLdBstr5w5TJrU202T610MyLsQTvx37xPWF3kQQUwupHrDQnZb7p9niCIF5BxKa+l9EXW0noHR6LV7KHGvsgRKoUy13RtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199018)(26005)(186003)(6486002)(9686003)(4326008)(66946007)(66556008)(66476007)(8676002)(83380400001)(5660300002)(8936002)(7416002)(6506007)(107886003)(6512007)(6666004)(478600001)(41300700001)(54906003)(316002)(110136005)(38100700002)(4744005)(86362001)(82960400001)(44832011)(2906002)(15650500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e1myCYCYx2WVF8MvbtAOeMHSvA695jp0z9CNuIB+IFHginS4NqdnGdPS+9Rk?=
 =?us-ascii?Q?MZDQAoqImk5TwCZbrO+Dx/VhLrJef0297w83tmz7i7nz2tGrYEtdZxEKK+GQ?=
 =?us-ascii?Q?KgzLtSD+F/CUeCLQ1gn9S72wkgwPjqAVoQsY5cXa2nbjs9bPp5uKSnrD5VVg?=
 =?us-ascii?Q?wDWp3ODCUMXJbcDFApVT/Jpm8S2UMivdgug4SA+YvbRwgp0Q7SRvlJS6xAzN?=
 =?us-ascii?Q?Mf4u7gc9/oRsfnpyPBDpgqqlCcZ1rhvmSQ3IwLh8UTUsVJNXm6/hAii+LoBE?=
 =?us-ascii?Q?FR6FUBR2f9XJfbPfpFzgt+cVaUxUwUTXc36xa0bDo8fqGGFJWQ03ypBED0I+?=
 =?us-ascii?Q?v1Z3Vhb31M3tQ991NsiNmh0ooToMwIfdtmi8yA4ozeRkg10/d43MIjXC7aUF?=
 =?us-ascii?Q?fmuLtxvUcRIERILHyogKVs4EXr42gEgvJll5PPonipC62qb+m+1zFEUmWRxZ?=
 =?us-ascii?Q?CoKP17HbTaw54TDJjyDBYgEymHzf3/lLuYRZ2/EXkzfCDf34Bz5vP5kG67+5?=
 =?us-ascii?Q?7vXTPYsnAR1StIcQG3SFjOgJweudB46KoJeZqPnO2okbDtJUqkb697Solhp0?=
 =?us-ascii?Q?rJszKtzlwq+SKhZJQ+zxYBUe3GazwveuSRUPnlQvFnnOs99cJEcg/X/Iw08c?=
 =?us-ascii?Q?YhrAah/DSahtyVhmeVNnAmVo9SULYc0LUOSF6+lmWfJ+8YV9U4eiavCJRnLL?=
 =?us-ascii?Q?XmOHpJ/DN5RjdCFqf9wO38xO76+48ScDqoWGCfK8XpjHijjVjpE5xyuhy+ft?=
 =?us-ascii?Q?X59ew/s8kxlFZLcwYU3hgvEFUMl+MLjSkSdWZffZYXM2lKaXDJUmq/DRD1oX?=
 =?us-ascii?Q?8zAuq0hPKXq5A8G9XqCswMqc/H2DV3uBnNJUt1+GGm0VK/lJVfg+paCEUMI6?=
 =?us-ascii?Q?kpSNmuWUvOLCriDDyElV4pG4OifExjtLh7aOoXmYW1SOVFQftnHktY5Wrt0S?=
 =?us-ascii?Q?NmhX0I+mI6rFv3eLRI266uZxB18GGYFY0ICNjGRa6cAp2JUXYZVB2ULv/VUk?=
 =?us-ascii?Q?tKTIUGE+pIqsDuX64mmL4knKgtFTnzeW789Lx9tKkcTD5mGSgE+ano/I2ap0?=
 =?us-ascii?Q?uY8/OvgB+qOLK+NN+x3PerzrUqN4lIGkVNfoCHcnyTZY0/IY4z06aau/p8TI?=
 =?us-ascii?Q?nCGXA5lqmeRjFCMlFN8lso+aSkUyBmid/MFTIUmDeikf0p2BFeNuKrhGVPF/?=
 =?us-ascii?Q?DiXhWXbiUKyZlni4RFMUFDX6BWDQVw9CslcMsTMimBaObgPQBM5ZxOn/aR08?=
 =?us-ascii?Q?W6uxzS1I2WsjOOz7RD+P4h+i2M6df7sfzl8/LmEx4y3SqbG8T/SFBWiypOSq?=
 =?us-ascii?Q?gy0fJ+Yx4mhoPlkS0LWuTSTKwKnfoKMbG1hA9+ieR0V2al9WxiYvQH3UmDul?=
 =?us-ascii?Q?eQu1G611215vk605+Y6oW4ZIe6Ha0GtG4/CAxOUhU4RAkHH9gjr84tOHXr9Q?=
 =?us-ascii?Q?uTokSDBZZRgM2y8FJEuawtbEKhxQMd0YZGywjf2LAWbNW7AS8zc7n4qH2bZZ?=
 =?us-ascii?Q?/PcZkerrKo6q1wH1Ng/NdtgcURHsr6L2Dw+0gZRDclHjFnO6A8cYDY08v7QL?=
 =?us-ascii?Q?aFdMq56GjPEFCiU6dNwMaYBdgguzFLl5tdhK+iHu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44724794-8987-4c12-cf9b-08db1476d50b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 01:48:01.7636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lo2DZ+fw/1VCUix3sgQDkjPad6NvhcmbqZmBvSP9dlcoc0DiHOd95+RUeHG3AmtEevtvDovdaktuYViIiKVXug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7835
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> This enum typedef used to be local to one file, so having a generic
> name wasn't a big problem even if it wasn't compliant with QEMU naming
> conventions.  Now it is in cxl_device.h to support use outside of
> cxl-mailbox-utils.c rename it.

Same comment as 1/6 but still.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 62 ++++++++++++++++++-------------------
>  include/hw/cxl/cxl_device.h |  2 +-
>  2 files changed, 32 insertions(+), 32 deletions(-)
> 
