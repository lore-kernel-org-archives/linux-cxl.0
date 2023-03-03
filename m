Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92631C678D4
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Mar 2023 00:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCCAxF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Mar 2023 19:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCCAxE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Mar 2023 19:53:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A072BD519
        for <linux-cxl@vger.kernel.org>; Thu,  2 Mar 2023 16:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677804783; x=1709340783;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c3Y6sPRu/W5n38bCEczmJl7JHJAWjXWa8n6C8fri2+w=;
  b=aLH0rxnZR9chWdKxtvbvXy8FhTEQs6/3QfLQyJPo5y3KaNPZlHesc3Pi
   qc6H2j/BoBN+Zpl6AkNgzX75a9fOVe0/51IYqA56Gsdxh1+PlmH4YueeQ
   GJdviW1SmVrAYlWpYe2rXG0ydbxbuL2jB20FhyfV5Nh/vpKaTP5mo0a4l
   JMLTi6d0zgE3h2eSVehzDQY9eEC1kJOywQ+DY+ZxOrudRbC/iyk8ChLk9
   QdOcA/fC4kkTcoKfoAjO2WJl+wwEKZvlTXtqvEt81+bbZKtKb0O6qbV0s
   mUd9LZ6PDPCUoFIeh/HvvEq7eE84AoWfxELVVM9q1m1KEoRLGhUu1R7V5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="318730670"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="318730670"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 16:52:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="849290939"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="849290939"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2023 16:52:49 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 16:52:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 16:52:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 16:52:48 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 16:52:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IA32/rY0ZXsgHGLTYp+6EzM2dcP99CQt5Tx7nnpva8dwn7WdWDqhQ+miDDRB0aMfYKqDPaexBjeIdNW6dJmhKiH3AA+F/UHwwjFhSpqUGfa8jEHk0UIivDf2sWoZ6ut1BY6eGI6Xi4yUCS2AlmSDrut1HBHQ5GKuV9Vr05sZ5oNp1N5qx37XtYYREQmERn50y7pJjXHHT0GmR4tVrQmt3gs1e96S782ZXAhqgVzHiqz95YaAm+cCUb9FsmXXTUZ27jVpGjvDZXkzuoSrR7aPIA6fJzKKpSbqI23yO65XSH38V/pG5MQP+BGuFMMkGD/hmiHkVHzhPFGvOfD6xpP9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDQfL9DB9EY5RhdLNBWaTuka7ySMvoncn0ee0xFb728=;
 b=bbeBJfhcp9HBvaO/3f8E4Cuq5ZfCKmmVG5ltta2/Hy5dtD6jpAa/oaat1uH/i0Nz2MF4oZ+LcWhpbCz+AZWNKTqOECZ6fdZCqgwN7JBO+l4x693mXzdMeeN2iHKSGg3jo9tO8VCXmy0VeZs9IVJ60RIjwLDpMnMW4Q/5umm8WIKTucWrCsuUIfkgg1e60UTz5yS/3BpcdwJEKtBN6YbexKp+1Y/u29drUgXV9icQviaabUqVi/65pXFaHmny7rLgq2elQcN7i6I6K3Ih/kxhYWWpVnDw+1s7ETJ09R3jywY0aCZ2WSoiyfy2qiN9/hHr0Jsj1VFgsVRoIdTTjpOJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB8020.namprd11.prod.outlook.com (2603:10b6:8:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Fri, 3 Mar
 2023 00:52:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 00:52:47 +0000
Date:   Thu, 2 Mar 2023 16:52:41 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 5/6] hw/cxl: Add poison injection via the mailbox.
Message-ID: <640144d9e4092_46c6029490@iweiny-mobl.notmuch>
References: <20230302101710.1652-1-Jonathan.Cameron@huawei.com>
 <20230302101710.1652-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230302101710.1652-6-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e885c80-b731-4d08-a4de-08db1b819ab8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NdQIW+rMiYYQutqobNxMHlFmT0HfgRPTmEZDCa4auvnaQoJkVNHLlWLbf1Vc3fxkQCleRFVCHUkBjhfMxAM92IqApxcr9EyMChwS3b2XrsH+kHqpucTWci5TgXmvGBL2dwIDDZZ0QxwCX4IgTG3mHBVob1b2b+K6C8rbsxtgZfAW237XGklD2kOa5HybNUGVbkyK/KmRoyURR18Y2vfL5V3XlH4xJ3MrxfVUub/SLyYL4xcnldFVGn37pQaalk5QSAt2M9sR5lqn2pZ9z0oLj2IJy2IratkmifOdghmJFAt0xWKcHgcogohCG5Jjulcz3CxdweIw7cDJeZymmTXum3wMYocDxvJe72A7G+Os4tY8PUqIO9Vr9zBCVshW46apmfSGF5FBXiNS3HnaOEVZ122qNyyfuiV75Ln6uz4oj1Sb9jGbnlunswdq1WesqXs+twDdhAw9HGQZrDzVm2V6v4u51TxhLfEcSnI/7XbUZuXio51w7y//jbNtS0nRV+6CwpQsf9sU6+ZxNaxemediVRK7YzrZSyT0EvUFiV9bRvTkywkilms5IQ+79Oha+jlW5HjLds3YOzyFG2K4P2yP/uXCAnyObx5cZIel776zZ/aW7XBAJM6oaBqrEkkz0w3BTsjqrYAzsZ1vZ7uCEkQ+eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199018)(86362001)(6486002)(26005)(54906003)(41300700001)(44832011)(4744005)(66476007)(4326008)(66556008)(66946007)(316002)(478600001)(5660300002)(110136005)(2906002)(6666004)(6512007)(8676002)(82960400001)(8936002)(38100700002)(6506007)(9686003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pXgjOEflUxbzkdEyC3UigyY9JyCer5cQlSBQR8vbtgFYEfcPdQk313SPr/8S?=
 =?us-ascii?Q?CyBwc2Q4xAC7pqEnjXU6nwDUlbiWypKCCtDCIltRCxywUi8STu69XcTd+2ew?=
 =?us-ascii?Q?Anex2Zh2wPl2/Le/7i1RH4VfXNua1ZMO9jHMBJeAc3/h1LGMyJop3g5HBDiU?=
 =?us-ascii?Q?njmnD690Nx7Fs5ole+dOEMZhxc3kBlvsw/CCjvImA4pLw1qiZWLEcBx4ZfLQ?=
 =?us-ascii?Q?BvLaflFkDcQ/+SYjVYrZ/KCfWDlyvk6mCXqp2dYHUV7tvXi/1HnQ2785hZrY?=
 =?us-ascii?Q?kd//oJN2spvmkSSo49VNrlXvFtSjJgpugfr8SYiR61budEQOSd07CTt/+ug3?=
 =?us-ascii?Q?6+pi0KJR7UchM580UbZvqUzfvq/KbLoW7iI8F4oE7fDmG67LVmAIsFNMvsFk?=
 =?us-ascii?Q?B+X0RWAqVHUWaUjHARW1j1OYaPvzFwAxb85fsDZ5XYbTlfiMx0OLE5GOmOa9?=
 =?us-ascii?Q?QIaKqmPu7KiiXmnNihR9JdbtIuhWWHzRUYnk/9MF6HYA6uGc8VcrubQZWoGV?=
 =?us-ascii?Q?EJ28Eh1QH8kjPzy0y3FLny1aRsOYZ4hzQyT62OX0kwkS4MV4htCkZty4Pzti?=
 =?us-ascii?Q?61UTdjnyQWZ/LBGqGSWa5rNXfwiV4KRYUWtUxDHvlYyXKegjpZ5ut2XW09AT?=
 =?us-ascii?Q?2qiNhE6ZDsjm5Fd1+NnEm+VE7aZhMe4Wysr9souP9w1KPIp74DkwBpXzzhy+?=
 =?us-ascii?Q?aaDUpg/iDlLgJXwMaSVArU6KGg7sjvr+8qx6Cw3P3o/nR+1m5yPI5P//wOyl?=
 =?us-ascii?Q?j8Ey0VGrC1DXKKP3Vsec3bcrnDpqGPtw8dTKWtyXibTKmLTRIsnSiUtssYzy?=
 =?us-ascii?Q?l0NjEn+q9zQpppeUzNQsA9ld/Sj3Qa+/YkVCk5uc6pKhJyZ5bMPyI7LK7Cn/?=
 =?us-ascii?Q?nHsIIcogRVWoFqI4/l2InO9i6Oc9APSfDc7CdLKHup43O5/JfRZuYemikNgt?=
 =?us-ascii?Q?XNTZUxu13gN43zBXjxrJLGWkl4AhMD85BThlhoQ4p36clbAL7oHSvyWrpoP/?=
 =?us-ascii?Q?upjYy3gLM2QI0YXJQFKuzlldRBT1+O/ZII03rV4lVmmaN6vbRr/4MsBLqHJE?=
 =?us-ascii?Q?Vbu9F2XRcNb8Lqn6fWK60evVaAXmdRMM2BIz4igPwZBr5wR9Tn1dgSyRUrz1?=
 =?us-ascii?Q?wK3ZNh2JTNwq41NfysGt99nZ0EU4cHTgvLkqzOzr4bMf/7V1qU5AFyvOL6PG?=
 =?us-ascii?Q?MNADfqPkgEzwjH+vBGnbajxFbu4CTBg4kch+3+/u8AWUITpNN2Hx9fact2SD?=
 =?us-ascii?Q?dtET72w3OhLYgvVJlaAuLe25uMm3zKspDFc94qLCcNyYCbO9ptc0xr1P7Hj9?=
 =?us-ascii?Q?n24IkXRT+dRE+X4EjgOORzYzTnWrgA8SO1ST2JUVluJV2xv25+Bjo1xI9lvv?=
 =?us-ascii?Q?49rM00c/Dyzz1uxV9j/kZZda9nB8+CStjlVAOdyEZ7wE+sCXawNFtlMklIG8?=
 =?us-ascii?Q?ndNckzaDxDFXT/3UHaaVXkfQ7yWZjmLK3ssjlKgwwMNG/CT//ZxUIDLZEHWx?=
 =?us-ascii?Q?BDiMmaNRHlX4leNR5OyotIxwBJ9+TKYQzzVVB7zaCM5W+kjJdlaXThYGbR1h?=
 =?us-ascii?Q?v+hMxmqVz9smKJ+i1/Cj4Og15MuF7PebiLjQJ2Ad?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e885c80-b731-4d08-a4de-08db1b819ab8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 00:52:46.4986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6oHabyWC6UFU8Ig5DNEJmAtuhYYmja8CI4aoQCYznJy70bASdkLp2HwAZAvNG/Uxe6qAkTmPjbY6oVwcyiNLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8020
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Very simple implementation to allow testing of corresponding
> kernel code. Note that for now we track each 64 byte section
> independently.  Whilst a valid implementation choice, it may
> make sense to fuse entries so as to prove out more complex
> corners of the kernel code.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
