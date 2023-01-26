Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B586EC54E94
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 06:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjAZGZz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 01:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjAZGZy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 01:25:54 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3DB38E99
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 22:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674714353; x=1706250353;
  h=date:from:to:subject:message-id:mime-version;
  bh=h8CKLXKCOkJEhBNk2fFR/3T11FiQ8oZ744FwJ/MA0B8=;
  b=YzW58seYA2FMehgODfcGsqwWJgbhVsb/vUPDMZkLx2yn4N2yD7jg+HAb
   dK+VFJBEOqa6MCpayfO2IkDofUPAPGorGmrF8Nqbn5foxFGH81iqRHZfj
   j6hKGCVxCdbq2gNCkL2T37WjtkqnHubqOcZRspSiT02WQNRA+cFZbHHEh
   icmeWghVVhU7Ijr1Mu/JDDvn/d454S+hEJGqi1g6U+mM0GeeVUIkMRZWd
   3uD3iH2ri6Awb6xJWrt76h7mVrFbKzT8stGSQRK+s+JKhActlCsCPErmQ
   eI7eXUmiOEV9qb4QhN8T71jIFNb/bedt2V3UCzwyJL/DTj1FLjVIj+bCb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="328832742"
X-IronPort-AV: E=Sophos;i="5.97,247,1669104000"; 
   d="scan'208";a="328832742"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 22:25:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="726162593"
X-IronPort-AV: E=Sophos;i="5.97,247,1669104000"; 
   d="scan'208";a="726162593"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jan 2023 22:25:52 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 22:25:52 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 22:25:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 22:25:52 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 22:25:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEsPXBt3633adBub45asThFcoYISEZLDCfWSNdr9FWLe0/JH157EJZdhuCkVRgtGbWJrP3huRF8lQeATsAP9NftbqhYLt2dnjjQUEMxhLZZHJG3HRemiQhMBKiAXnuVJZy23WVTt5Wc6MnQLjIze9nBqHSLIFEB2MP+M7yqS8bVKsZ552GxRiVPFYZUg92+CEHugZKzc47Lh29F7FAVke6esVdmAkTTI+vdcN3Quc0jAtS8FFtdGMtRge6r/VdkNE3ZgsH8ob6tS7wv/qSMtPDmhJQ28A4k351Y5fa56X3nIGBI3FkHwySC3jUVOOT20RJDnXvZgvWSgZo5i5+V46g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8CKLXKCOkJEhBNk2fFR/3T11FiQ8oZ744FwJ/MA0B8=;
 b=JtucXQiUpZL0ZoigyuWY2ujH1EN8aBf5gw7feliyHXBhDOy0cvgp/g3Rdf+Jf4jz6IbeD1bq0h+I4gnZCtLAF13QW6krSPvKZoSC8xdho01piZnBNYdxlNaiTY/AohVUl6KdTO/YNwb3gc0bRTYepp2vzMUaacvdTSSopEX0MXOH3m1pp721WT1a85rpVT4Cq57ZPZlbEHb4kuyaizDLoohPf4bIiFMBEHuPCxZWWpz0dNvtkPtxW513c/xmJNodK74/UK5/nR9zxpHwZrNSX52CVKDaFmuPZROgAgIgkGAjY4ODfhvWcs0uvnhAcnU0+xDyb7ATeqrx5ggBwm0hwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO6PR11MB5665.namprd11.prod.outlook.com (2603:10b6:5:354::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 06:25:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 06:25:44 +0000
Date:   Wed, 25 Jan 2023 22:25:42 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
Subject: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:303:8e::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO6PR11MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 0891c44c-19f4-4258-cc67-08daff66277d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njov+o787on6RMvxP8nckR3TRkgt1U8RxTdb1fN+fwu4sYZkRyOx3NtrtKGwJMmRm686h9jERGWIEijyxnrIDXlpjx5oZhpH4V93RnhkKP683gi19nlPM+dnVyWChQy8ArjsK+s3BZId04CMgQabwc7n2ZRB9FcTqktRxdBOVEi0rkLxaMejVmbuhFVR76kW8S6n24zBigW9H3ziIdxT3ry/W9cb9AHHEeb4jIsNRfPzNGsRg1OdTUL+8W33GVauqu6JddSDQygVfcTWUJvwhvW3NGnZvuW+G+nb5EM5eMrNVhfZ6ITJ6L9VfQpWd5SAfuzqlOk+QQU03ZCJMkMVGNfetqensHYlM7YKt6nD/ci7gaJMvsOCIeQPM74O4NBK1x58quFr7DvRfKdFHe89/VxLV5202vUQjxIGCBMxm9El5HFQIEjXvxfd7vAwcOAD7EQ3hqZUKc5/9PDBo48qQgnwo0lnSsIcVs84pWbVMkct2E4S7wl4snkHvo1tKzPTt2ufytIh2xJQgoK/NNxzmKo2zFJe8HCnkY9oKOaakryn6W/cUPVwwW+8CO7Bi5YfuOWzm/n48HvqNyLB1Exd2YhyrZKZQkMWiwGsRWc0JLXY13eiDbhtUSi1Hm+TbDDgHWZI1AgjFypTON2oqUoQ3vM+x4T3+jNBkaEIErN3KI88+oDSlOd//AFIxFOIkZ7r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199018)(41300700001)(38100700002)(82960400001)(83380400001)(2906002)(478600001)(6512007)(186003)(966005)(6486002)(26005)(9686003)(6506007)(5660300002)(86362001)(4744005)(8936002)(316002)(6916009)(66556008)(66476007)(66946007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QWCk/MGVUowD7t8blFWxw7jaoPmdzpvzvJes9x61IdRkznW56MnkmshqKo0q?=
 =?us-ascii?Q?BfNcgTNCziE5A7ltjVOE0pycecdRfowR9TY9EoMQNthy3fPlQek+2IE54Jf/?=
 =?us-ascii?Q?pdaB5bl99vr3uQ4jcxYL9mreKQPxeJziAUILFtHAYgsF7jMbWGKY64PlJZAp?=
 =?us-ascii?Q?fyjjmKOAozIE3JzEU74c4LFvggO8HpdhMxIl7DZQbVFnQm4MggU2SqC1wlb6?=
 =?us-ascii?Q?K3XMsAmmRtj/QChNEcCPwSH2YJumwn/O874YLvjn81oopRAc2q3+7S3Xi10Y?=
 =?us-ascii?Q?qUOl0p/Wk8Wt1o87TBI0EqHgwDpBOf1l6NGKPIEVnmDk6HOAbi10uSkljku3?=
 =?us-ascii?Q?4UGv6oauAndr8prx/fm6FwBpRFsi95sUZbfbhumQUWRbC8+C9pfgsEHotE18?=
 =?us-ascii?Q?oOknjNRiLVyy7CWVBQgE4Svdkhi28lAowhycJOz8fMy3O6icoS4w5p/Z23+C?=
 =?us-ascii?Q?7tqJpOLfRTrXV6ZWVqcfX9iYkbR18PzDPWqJpeeDMHAljqWvbQ2Tz7I5w8LE?=
 =?us-ascii?Q?hPdEZfC4Nd7nrmLT16CaCY92ToB/fLiDwN8zE8ADpqoZAiNcMPmLgMBdf1+5?=
 =?us-ascii?Q?LSlFUPJBtlrhhD4BhF4IcIp2WQsIIipPP9lz2ILbOQFFlDXALVDXLo6PQoW7?=
 =?us-ascii?Q?8jPFA+gs1qNTEqdTMwdwNaXLN+qXKF9YksUTgm/jzKP6ExLXBWc9wH2mXAVL?=
 =?us-ascii?Q?bSwvpxbu8teNFDJ4PTj+WTwRKgZztIRUzdD0haUMiIRTVBZuCovWuY/7Cv3t?=
 =?us-ascii?Q?FeAYnbifw7Q4/RnQpm5e329TFhNBsOLJ40gtof5+8eXIcrKJ2AK0K3zPIWLV?=
 =?us-ascii?Q?ciRgHwkNfzxRBLD8CzK2XWk1To41y+bphqfPuvR0UHosK+uMoC01gAYQi7Ks?=
 =?us-ascii?Q?a2upb62BI1LNpEXpVJvD7Rhu8r1Xb23PPXxWzuzAaX78zNK/4TEaYk7rkL4b?=
 =?us-ascii?Q?LisSvJfBVQDXheq8R2+KoQk9QC9byj5DMJYcjZh9xtL0fzH0YkVXk2w32gIx?=
 =?us-ascii?Q?uGIW+iKwVZ/Vs63GFXFirYqAq3AR685RV5KchQf4XXtgUs4cczqu6/PRN9X4?=
 =?us-ascii?Q?xIbZlGNA2SM/yDFBTpsy/bjzI+Q83/lxv5Tq81v+uUKZmKaBYmeLU466OKjL?=
 =?us-ascii?Q?5rf5SlwLs/ohVI9sn4yp1U/XumctpIQpiSMovV+mzZPL+5mOMzpeIvcV7qzH?=
 =?us-ascii?Q?7+N04SQj9HMQOFBuCALs+/KCT/lSv1mL7O26+ify19+QAgE5x+OAYGzxiouL?=
 =?us-ascii?Q?yBEfFeJRh/bqMp3gXAcUv8ijkk4a+peRLZMU1Ohso23Eq5yvkAm9eUrBokZM?=
 =?us-ascii?Q?dvJBYHUNo/y3JScW9vLwKLEw8PJXg4vF4EghO9q/W/L6ZZjGvu6u9b5hE74w?=
 =?us-ascii?Q?RLGqsW9yStN5HtwsLRB3lkulOwiAEobk7VR54nT16K8aBGIaiX1OockroZoC?=
 =?us-ascii?Q?NurZsPjQRgoItehRHS6BdAP7xSRRpTICZxifFgVNDmQNsP1AF+a1YxVp9UdF?=
 =?us-ascii?Q?Ex6t3b72k5XkhDBtzhOzyYE+dc4NmIw98PbAiaQJyAr3sLroOJzenJOzcSBA?=
 =?us-ascii?Q?lomKOLfDLw5PlFa6sTpCrPf9x7rPd+N5Bq0gkG0e3In3RJHUIZfV+EukNS7E?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0891c44c-19f4-4258-cc67-08daff66277d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 06:25:44.3786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wwp60i4BcIyBJLDTbY2J6ISVgviQkFC9ag0TZ/HVk9KcTppt5c2pQcgyCCaLrPmyy6EMC7oJH1j9bTM16ZJa3p4zW4wWAFM5GdEvZ21QHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5665
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

There are still some sharp edges on this patchset, like the missing
device-dax hookup, but it is likely enough to show the direction and
unblock other testing. Specifically I want to see how this fares with
Greg's recent volatile region provisioning in QEMU.

I am hoping to have those last bits ironed out before the end of the
week. Note that this topic branch will rebase so do not base any
work beyond proof-of-concept on top of it.

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.3/cxl-ram-region
