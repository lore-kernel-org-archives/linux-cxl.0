Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81F2C7EE22
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 23:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbjEKX4h (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 19:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbjEKX4e (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 19:56:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B60C2689
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 16:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683849394; x=1715385394;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ywjKTy+5H039YHlkcA+WwqSHxGwpz4mhbglba7HZChs=;
  b=GMRTLq9VBSLo7uSpepNQCglm6gFexahgrZegDdSxj1xhRHRteK+yCsKn
   MYTpMMAdCQEbJJYw+W5PC586JmPtKtWEgxYDOGSXvQAj7uLPs9EMklqrg
   ANNKKy4Mdn/BSJxnLf0ycfR7zPlusANHTsL2G/cAUkkqDZjw9pE3iJQSr
   nUdsRvs6MSEd5IcyFu2Fhupg2AspSWWl+KSRcKAwFLmMcJBssj7QSSWOh
   ZjsdGHk/iAPynjUUiQLTd+GxRhoIzIhe4ontKsFsP0iLRa5fkNRisdiGw
   LUrqwY3SpFtBuoWtzGsas97gsb5IzevzkFs8JW++bGsgufG4PYsswd0Gu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="416284993"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="416284993"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 16:56:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730590594"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="730590594"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2023 16:56:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 16:56:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 16:56:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 16:56:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqZFNignkYrwaDmsaCVvbqJ0oq20zQk4EvciQlXoHgvhwBvqQsO/9OGubnw10o85MWcb5FYuVubf64lgJRQTIbA3kkNOxU6K4q6k/6J5GgUEpBXNO0kBe5LhAD4YNYQTUrIjjyNxp/HGguaKPsORt5akuC7DU0+t3RAAjCL+coBduzoCDuOo5beZjC/PZEukdPCBkVN8sdBfgq3IjMeUq6RXj4YY3gRdEWiyoC2f/geFSFntStbjWF1MGvaT+Lpma7aBGnade/cWRaLWbJePg1WdLPBDRnAKxG6EjmTxX5ibRNQuZg98vQESGQtxB72iW4u8PpHI1psYZ9UVnGkK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmp5tH2WLjeEtod41T/m7PFCY+Om5CzgtvUKttBstGQ=;
 b=XHS+s8/Z2vXptmK61aTy0WGA3ujjlk/6Ihkfi5w1+zPO9IzzzZ8Kenuzc2AN0MTejFKugeiqfXbfgYrt4v161OZPKFv8GvsxJKe5nrj2GOkAQAIa/8inqhYc2WatH2Vlfr8gCZVCGGkE2ecb03LgTolWM/LBObUX8zTKNWESL/utN+pebXMpOPfNhWDm68awWgN3SZi+1RyfHmJxSkhTxP4ifQ9QgyDebQ1rtuanIShSezUrhb2EKFzmpV8LDBgl065Lqwd8TETslqdYfxPYzbMajwZoCyGxk9o0qt/JKkCd/kp9EvYhm377RYNjHklaNxR7q4SLCKSsS73A0Zot6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB8024.namprd11.prod.outlook.com (2603:10b6:806:300::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Thu, 11 May
 2023 23:56:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6387.022; Thu, 11 May 2023
 23:56:30 +0000
Date:   Thu, 11 May 2023 16:56:27 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: RE: [PATCH v2 1/4] cxl: Export QTG ids from CFMWS to sysfs as
 qos_class attribute
Message-ID: <645d80ab569e2_1e6f29416@dwillia2-xfh.jf.intel.com.notmuch>
References: <168382784460.3510737.9571643715488757272.stgit@djiang5-mobl3>
 <168382792890.3510737.9466824452406784924.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168382792890.3510737.9466824452406784924.stgit@djiang5-mobl3>
X-ClientProxiedBy: BY5PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9766f0-55a2-4d90-4770-08db527b56df
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94fufap6pCVZVFCY4pRRwreHuegjSLusQkGi55F5Ts8Q8ftyaXfS8Vi+pcr8hXpuIQWXE30S0ilCEbUVVqwOzxBA8+0NWOsmao/lEyu56fRWMFNW4KL12h6lC9XAYw/UHVkeolD9cLchqqR4DWe/o3GYZ2d1QYrLxOr0BV2BqANoTOv2iI3mf3RI9mHGLotRAPPoOS0Pm4lV/rujSSDq7q07ZmEmyPJiYwK21Xxbm2tyX+ZrNO2IxTb7VvhtxPiZP/XuDEpfbt7yzLR4F0sJ1xjifB867o5cklzxj1ywJZ758p556YGQGwfYT/mAMJ2m6JL7YWo6vR67cYmbQfIn7ifAz9GZfSm0QlhLdaA90hrJGsKiAc3AzMd3d/xRNNTOOYATeL1fLh096SD8AYni2u8frE9hJQMgPhyMKatdF9SAH36Ot8VYk2JUb9FVOlfivX4Yq+3i/8x8NVe2ywyitqgC1RzrNoz4W1WnuuhmdH1/RQMgWq5ZL4L+0cwSviToQmjE0c17b5j1gp0zZj8YR8dh+zNHhh1vCYpzvnDLb82rq/+XWC3QdcgNxwMlgpNZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(4326008)(478600001)(66556008)(316002)(66946007)(54906003)(66476007)(86362001)(186003)(107886003)(6506007)(26005)(9686003)(6666004)(6486002)(2906002)(41300700001)(4744005)(5660300002)(6512007)(38100700002)(8676002)(8936002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6xVbIx54WdFGQ6NI4jOk+7Nd4+qMYFnrO7v6rw6Gd/UBhyF8+zjYD0MyTCqP?=
 =?us-ascii?Q?KZ0XAonglZiaoqShwCFI7C3X/UBiiG0952+LOQD229nuL4ktPS4TV75+/o3y?=
 =?us-ascii?Q?ij4pbSm2uOIUNdpW8TkcVfQpNDppgwSC3a5lzct8gTNOxuzz8t/MEjLJ60yr?=
 =?us-ascii?Q?QvXej72Lzg3on5iu636z+gztyevqQYkSyOTMZwJREyy94aLoEcptOZ8/vXtL?=
 =?us-ascii?Q?lrQSUf7EChBd4I0BxKF9icjMl9VfIRBg9am5eUx0ULtzZ0mSVC1t9hGqfXfx?=
 =?us-ascii?Q?gv0UXF/8YdCndNsOI31Gah9+/zAvqmEo9xUq/owF4+3jml9gPtNMRKufmmHn?=
 =?us-ascii?Q?aedpWGW22FbDjqngWkjFnYB9QpOseLHrIq8WtCUr8H+9r0Cen33yJ+fzhvaa?=
 =?us-ascii?Q?CRtASTk7yHNuKJN1pa6L1XlvkOmoRikZEoSggaNNM2Id0gWr8F69Mf7Qqbnv?=
 =?us-ascii?Q?mwV6s+Xx+D5QoR7MAcpK4Wd8z+FuLIoh8h7C+lTDwYGZuVQdMZ95BdluN+xV?=
 =?us-ascii?Q?bThzQBSgLe0fZcqHw0Dew60WCp+AXySCmCcMxeZcE6wQCscafqOeMTnK5NFq?=
 =?us-ascii?Q?/09rhApIlU5Gj0CuTEHvxrgUKKoasUqGrkH5wmDmC5zChOATBYZBzvmwS31o?=
 =?us-ascii?Q?qTuCabwAb5i3JlsdEPyJ0UcNb3zeq0y+z/lEPBZ8ST/hGAolePpT9gTDYtPX?=
 =?us-ascii?Q?GeRzlaOvMeWrz9fYWdGRzK9daELAzhbll5zKPrqkwaIzotYUFbWjZRTr16bT?=
 =?us-ascii?Q?qJHdFyNO2uMYlq0qfIwszuKkAHoHwZ2k+8Souwwjz3utab+5VZd11Bx56aCP?=
 =?us-ascii?Q?TFONq+x/y8WxLF5xann/1WbgKNJJviXspjrrHkehTBgc/gOXWPsCPMCu/0rm?=
 =?us-ascii?Q?LaZZW7uspjEctIWHh2JkFrm6iKNiarGpjUlpXfv4Y10IWO+3LXioYAtMKlbW?=
 =?us-ascii?Q?YfDo0iragfJFKUQY5IOWIKj1AXKeRI7GfaHzUHLswEaAinbtBogf1K7KOom5?=
 =?us-ascii?Q?HOk8SCl+Z3prxhNllRjPYQFvAkovHs1YOIuQbC8uo3RUGytMN3162GfXUYhj?=
 =?us-ascii?Q?KOAELb3U1n9oP69VSQsY3tyvsmDaSTsYqpZ8O+/7sjo1a/mFjREFgz/sBVOo?=
 =?us-ascii?Q?mlJ44GqLX5RhB9XBE4L1UI7VCeF0Cc1hIzEgDS5qmeU4m+QCTNIJX7Z0CpPE?=
 =?us-ascii?Q?cFjSkaB/cjDbWEIu1VNBHoq41+xDb94MP/6kp+HD512Xek4gvoWa4X5Rvktq?=
 =?us-ascii?Q?a/YpbmMLlAWQMokoNL0dI2U7EA0JUvDn2j+OG80YyKCW/yy+t+ti7qPsWEmi?=
 =?us-ascii?Q?leUhWHAdaNWvUrynYk6KvU5iVqZHvu73+L+ub4L7B2KE2tYwBCPOlp5pWWau?=
 =?us-ascii?Q?DunrzgYI7hHas99ccZv5xiGwDvaTF7Ap/sZiPQ/s1mhA0/FQWRUOooGgO941?=
 =?us-ascii?Q?ntpOHeHDtsgPUtgOLhQS5Ji4IL7fzSu7eGlEhDsNbmT3UMZ5WchlrhiqrNAc?=
 =?us-ascii?Q?HpKJiqNuJ28iNXlT0c0pXNwA++551g4YWI9NDwynjv4TiHazyrBAWY2FSZ55?=
 =?us-ascii?Q?kzv4FnidZJAH8WQm7DZmuQm8ckGgDl0uRJ9VVI4KBK3fDIBNC810UmH6i/Ig?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9766f0-55a2-4d90-4770-08db527b56df
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 23:56:29.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqtB5LDtvifwzg/rip0q5GWlYZH4Q6v2awd12ImIc5layrk+MK/04WWp/u1cYtBMILe4POsKmg3KUSvZFcqKiPDASn0LS5c033Abj6T4qZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8024
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Export the QoS Throttling Group ID from the CXL Fixed Memory Window
> Structure (CFMWS) under the root decoder sysfs attributes as qos_class.
> 
> CXL rev3.0 9.17.1.3 CXL Fixed Memory Window Structure (CFMWS)
> 
> cxl cli will use this id to match with the _DSM retrieved id for a
> hot-plugged CXL memory device DPA memory range to make sure that the
> DPA range is under the right CFMWS window.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Looks good to me.

Will apply to a for-6.5/cxl-qos-class topic branch.
