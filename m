Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3F6C77B61
	for <linux-cxl@archiver.kernel.org>; Sun,  9 Apr 2023 07:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjDIHHp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 9 Apr 2023 03:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIHHo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 9 Apr 2023 03:07:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A739159ED
        for <linux-cxl@vger.kernel.org>; Sun,  9 Apr 2023 00:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681024063; x=1712560063;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UICP3DSBJ4iLlpaCQDi+lYHgWflh7U4t7sPHZiiBhXk=;
  b=NuufJ480kHNBnDx0b0TuzximKbVHT155j2Dzd4o01TteNBQBmc4ywEKA
   hsigMhDTTDl2MIi/3melQb0GMkjeja7kfhIzGtkEZVkC2sUYrPI2ED5zg
   j+uNL/4vy/4ZdHmRrskkr5ULfAimdvsBufuspCSl2OtjSJFlPedrSW3Cb
   h7i39qB3hW2Xpa560zSR7DuWRM65zTkooTWa8ffvzzRnMoTX4J2BXqGHJ
   /SrPvzDMHQE6uDdKkoeQpWQAT4XkTC5h5BCFjh4NYEBQ5/J/vpgPg5+ER
   pTM8rBRdOio+/nxD4jSHQYrT/yuT71cPvH1vhkNXFmZdv1wiIuIzeW5Cn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="344983098"
X-IronPort-AV: E=Sophos;i="5.98,330,1673942400"; 
   d="scan'208";a="344983098"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2023 00:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="687935538"
X-IronPort-AV: E=Sophos;i="5.98,330,1673942400"; 
   d="scan'208";a="687935538"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 09 Apr 2023 00:07:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 9 Apr 2023 00:07:42 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 9 Apr 2023 00:07:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 9 Apr 2023 00:07:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 9 Apr 2023 00:07:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhDb9YjELrPqFOMytyn74sFSOSIH45VVdzyv98lgu1CzXEoHuXjffg4efKIBmV7ap38PBGybNBBvZ9hRY0jpsyKdEpDDcya+ZIk1ZSCCa45hNp7WZjwMAIV2cXkDngBFNLw4IIAOasC+Gb9kOpXhqYlKhTfCwuHDIjmqR/ESn88G1WWkTg6F+qYqD7Uw3Y7f2Rf2Q3D0Jqi7vWQzSUBYz0epFTfaicU8L0sHHrEuMU4Cs7BRWyq8S0Vm+a4nz1iq/wjxp3a5uVV456duQXNlbQS3pWpXNReYyVduumFLWezq7GfVU3Y5TrkaOrTb0Le4bVroJag+ZJ64AcvNyDKGNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3X14UcQ84JVbTvAPqtXNBsxpepi3EFJMl7whxdQqnI=;
 b=TPv5/aCANnXLD7hy9iPE0K2DK6mH9HKJIi9KnlliWOIGXGxFUYzpORb6ItDDXXHv07+x9SUzlSCnaFBGUkLCGRA/ll4+Lv9k6tp83uTpbcGquci4BRjTkn4GNLiI0qp2rwPC2Y2GEeKGh281Mv32OIEuGRrs6utOleRG17l8Bem6cQ7VY1rq9AY3nogtZLOLhWLLE7RtEORikD/YaYR1N0oFVX9vZhAcB/rrbEWcIByxB7RmYalrSb1To2LS5bOqnebDBFCcBI001Q2eHaJ5NtDrvwBcXKYk8+gUV7OkP/bRaTHKlFYWTHvzD5ur0NlasHY9lECXZ5CEUgUy5/kzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4807.namprd11.prod.outlook.com (2603:10b6:510:3a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Sun, 9 Apr
 2023 07:07:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6277.035; Sun, 9 Apr 2023
 07:07:40 +0000
Date:   Sun, 9 Apr 2023 00:07:36 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <navneet.singh@intel.com>, <ira.weiny@intel.com>
Subject: "release early" preview of DCD enabling
Message-ID: <64326437c1496_934b2949f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df0662e-ad04-4a8c-c7e8-08db38c91aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfMBQdSpht9FHRCeoyu185Z7YsWo4VJRRb7u7hlePAmoqdAnKnmZKMgrHwEBisaTGsmfRFReWzs1IW7krAKcG26s7XBs0H+O/v+ILUGrt1cvmHlLxwhzVKvJ+Rj3E+S+Zu8igzpxdGALaTsadLgFXl8+fy8Ck5Tleyu8kCsdN+v/a9vttanbH75NVPbmuLYgXpvaN+ab8d5NVfMvuVadtnjeMAWwgs1/oAYnDsemQSJ2VzCuL3bjqvXZtL0hISFiO44AQGRhp6wftYVEI3U6egYC4hyrkDzSC/eq4Ye4clxwDbDn2m/OET/uCou9b3rG2ZWoDlt6BzT17GPWcgpn5tAKaIBFjZaI7TeuBXNebeY/WDhSlpfZu4ThhsqIN/3SaIcl7yFz/et7dODMz+ERnUgDUEXUBIEiGxIAaFsICKJc7HGRxOVxdWEPadmzjtq1KD4BXfkY87MYuwBn9EriVS4oEFjxfSeKguN/v/Kfc/4woP+oGAE0E1kK1dqz97p7c27apS/1jLk8LeBQ8p0Hu84CVe/TjyZsv3tRnxGNUhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(86362001)(316002)(41300700001)(66946007)(66556008)(66476007)(8676002)(4326008)(966005)(6916009)(6486002)(478600001)(5660300002)(8936002)(2906002)(4744005)(38100700002)(82960400001)(186003)(6666004)(107886003)(9686003)(6512007)(6506007)(26005)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1FO4xTLogcX3J0coFIwdyF53ORjqQjqEdPsW5OmSRmMxBVu4v3apZm/xCV5o?=
 =?us-ascii?Q?g3fbos7a1+fNW6TxuVyBfM0LRQ92y1F5kxTTM6EFzN1qmOdJI3YliPYsLuq/?=
 =?us-ascii?Q?c2qvov+LGKjbatujFO5hiL3oe3NEwsxt0AIu19MvEkJOAknIteTEE5ppPwbC?=
 =?us-ascii?Q?vyP+cxLPAIFXywtHx5ec8kT5vRMaHZ6PF6o2pM5QA0JagOqDE2NL//4GzSXd?=
 =?us-ascii?Q?tM7RBARbyTFFUFv5kt69UHq+2fSRYyCF5GxJz584ZaJ5eqJAObEP20Yj5sDw?=
 =?us-ascii?Q?eZIzYNw+KPTDZRa0v/8X2R4XYHvx5t25Vn1+ri3CAZ+TaFK+TZsRFOWsFPGn?=
 =?us-ascii?Q?2grA5Lub4PmHeBhLaTO62kNJe0ifUQy8wuOY1KavTmNjnO4BNTYB1953MaMF?=
 =?us-ascii?Q?jnBMwyA0YNf3i8+UAk2d5n/twJCeFcu1r5lMhAjrg/FG1/nxJu+PSFY3UWjK?=
 =?us-ascii?Q?dVsLoLZdIsQSFyEqflQJrtoZYWHC1wu5NlRdHFj+xRw3agHi9gpG2EisC1nm?=
 =?us-ascii?Q?aq0I7PnmLT8+C2Slvl6xT+MCcLS84Frhd/ZQU78uBxy4DYf3re5awhUczOVW?=
 =?us-ascii?Q?cyE6f0Rod6AtkrjtDOB9vVslUGiBT9v1zSAu75Z27fhVqoFFZr6gvwwxQeum?=
 =?us-ascii?Q?ZChppI/R7wArVF0D+RzTkuweeGGsXbp3lvsFdg/F0CFeQ1RjyKW3KBaSE0ib?=
 =?us-ascii?Q?rIbLybVSTf4JjinkLGo1qVbewp9fG/EfMg6Zf79Q8zpTPCBco3zWfe9rNX3V?=
 =?us-ascii?Q?211mcxlZMBTQQSd/ysl0LsjuIs3gfdQ5R8WV0SG6JNLjJFbULzdNL/MBHIU2?=
 =?us-ascii?Q?rL0PJTAgDgAIMWJZ48Lx+Cml4bh7OckCyQZ7Qxp0V04fk+FLbMwSjys7Ml6m?=
 =?us-ascii?Q?1rz/bFFpG//UwbvtgbITIQzz3bbQxmiphaEG90gCfg1DxQ7ZtDvGMvnK1+58?=
 =?us-ascii?Q?GCsIKyGKQyzuQkkD/usj2ZZneqAhpqPy6OsGopvbaf2W93MKurBxW2b0Lo75?=
 =?us-ascii?Q?xNqUVQyGiHfR344gwf/xboTEbCuOoEP5xDJWFoFj8jTFskf3UwmyrBpEsYl+?=
 =?us-ascii?Q?oEMYaMIxXtlVm9J/tmOG1QGNxv2Bvf0WOqGVstMwIU6sp0mZ8ShRLaKHeZOQ?=
 =?us-ascii?Q?6SLlBdiT23RAiFDqaaN1JWOUXk3YOB1hTpXWQkA2Tyx0Adlc6XzIAYHfQw1Q?=
 =?us-ascii?Q?Uaj2xz1fpfRNwQNavIgpcFFgtrNruOO178PMbuV1nOhOJsB4GnTYjrMUE34w?=
 =?us-ascii?Q?tHyLzZZJ/Ykuu23OLtXbweJengc8bdXNso0NWEvhdOnB5RwDoWVuXBPR03ZU?=
 =?us-ascii?Q?vOTexvoeCe/CAoyCWiLw9hFqnt0EhVJ+UvjuazpQZfurEfAcBAzut9IAgg+G?=
 =?us-ascii?Q?7/VdBa0aewjDkEGZ1QTJmHIawGqxuRDN6R5P/xHTMQqXnBxrhKNMzXoswB0J?=
 =?us-ascii?Q?6LaqFasb9HrIfjMxr0C0jygw1YYbuFNRQkdLZ6JP8QVEMM/SOQTw2zfQNA3h?=
 =?us-ascii?Q?9NBZg/7vu048Tmo5oSD0pHVWG1GZ3rM6pl4nqYAb9OM1YJyaEeFExxvzn6ZP?=
 =?us-ascii?Q?4ePSlL0vnoUwPWHJabAxmb2i/ibgvUUwBnesZ5Cb5jlHPFngddt4gfmclUwN?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df0662e-ad04-4a8c-c7e8-08db38c91aea
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2023 07:07:39.6352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOsH669TQfMq4Lb+UePyI6/hNnjBYbNlg6++UQ6BcjKAANF6oFvbo+pf5tDwUHAem/99yF67ItTPzk/WAH+F48Tr6X9l0Q53OC7/WV4E6us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4807
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Here is an early draft of the DCD work that Navneet has spearheaded.
Given the interest level I thought it best to do the remaining
development and refinement of the functionality in the open.  For now
this is just a git branch that will become a patchkit on the mailing
list in a few weeks.

Questions are welcome, but I do not recommend a formal review until the
patches hit the mailing list.

This has had some checkout on an internal functional model, I expect
QEMU and/or cxl_test grows an emulation of DCD before this patchkit is
committed for mainline.

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.5/dcd-preview
