Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F4CC38A2D
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Oct 2022 23:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJUXkh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJUXkg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Oct 2022 19:40:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0154226DB2E
        for <linux-cxl@vger.kernel.org>; Fri, 21 Oct 2022 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666395635; x=1697931635;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=USD9VMilM+mlJvSMEIH4EbVFKwXb6rWFBb1TpSFLCzk=;
  b=U5wFnafbtdu+SiPc5Uq/hNKJ/m34kVyHL5qx/YX4+kc97I9lPHFWEcsE
   gKEgA003OGS5gkEkINH52Avh2l4qZ6JrzHyO8EGPGrWVGI1Clcv0X8LcM
   pYhRY9AyhEOFKSfn5Nc5qkas2GOODDOd6jgqFYqlbytS1xL4Hj1XPR6Ws
   3uTbswuf5uEwlbWWTYr6Ce4IWGNioh2K/bPUNA8XP61eDyEMzPi3Gm10G
   HRNdRa0+AfqnHb6eOhMpo5Dg49PRS9xWqR17FcsuvAp5+1D+1xaKlYLWy
   qn/u49LyUILmub9MvcMsqokaVBjW9EsKWCANgo/Hk4SEv09u15XX13KhZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="287529354"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="287529354"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 16:40:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="755994196"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="755994196"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 21 Oct 2022 16:40:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:40:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:40:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 16:40:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 16:40:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bawYxy3Aal7DHkR/kldtQBkaMJKlegngKacuQFjTgryYANZmop+C3/F7SWrlmMu+D9waM4irBGSFOUXePi187KfOLstl8j/D+U7UoCwIYwmhAIDB4buDXkwm72Lgws1CzORm1p5elH5z2iK/2bKKVqrVXZspT6dPZB+dg9TazIuh9DymjImR7oi0B+mVq0AyNWRJm5KarcD4zhvKrZ/VEjDUeY7b2eyv2h5ZydR2BRZnXG93qe0uCsZfe3HbqSfZzQv8qwsCILWMna/o94DrcAhS0IIgy69ZYwUjKFB+5i7BscxH7xs8cZhGrhiL2OvGS/67eC6eEFo1ZrZOEYw/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAai6KYsNLc/48QDOjpKtgaY59n5VM/TGSQCbB+Nd1Y=;
 b=PblzkKaeUJnpOAJ3Sl1U1Qn3srg/NkldR2lIcBl0KqAFh430bDqUd9c+ze3o2fLpZUVXwXUH+ULCLpTn6QcziInb8uMEx77j85UEVxADVtNDtT2JOkJol+44ylMlxFF5tyiNN+PMaalz4kSDX0PveViWYypwXyFO2x1HSwwg5xjBsfF/Ms0/Pfr0kpSHxVM0Qg+6ctZdh6eDRG9jrQjfaJrzMSq6FfwPB9lexYRFo41YhFnJPcrZc3FFU+pw7xIq0y5HuTwVE16kJjtLHDeJtNLpFGmc8S8/v/OMv3boZGaeY2P7fhWT3/5eDI0hf1c3Dz4eXZa1Bene5gg6qm85nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH7PR11MB7148.namprd11.prod.outlook.com
 (2603:10b6:510:1ef::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 23:40:27 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Fri, 21 Oct
 2022 23:40:26 +0000
Date:   Fri, 21 Oct 2022 16:40:24 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v4 1/3] For ACPICA: Add the CXIMS structure definition to
 the CEDT table
Message-ID: <63532de882312_4da32948d@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1663687681.git.alison.schofield@intel.com>
 <f64aa41b63d8af9953f6b23f505b3d86b03d891b.1663687681.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f64aa41b63d8af9953f6b23f505b3d86b03d891b.1663687681.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:a03:333::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH7PR11MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: aafba438-6b60-4aec-c865-08dab3bda188
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VnnqGS6dxBJnhXFXFuB3sh/SLhLPZGyl5kR82F4KVBEOYEZL2gEc3WGW7Ibn8KgYwMv9Vws5d8nOAo9Gv8W+ePt6MxJUgj/JCRVwjG+inRDn9M/uoeQJkNqGqY790XhyurPTYwmM+I8IPC0+VkVxovXG4E4oCrnDShSOOtS6rcE8CBvkpHU3iIAdDT+EWPcvrThKuSXKerkgViVZ/kxqFsBrmrHeOxJiI4vlG37aRgrh5OnRMjqDFmIEb8740n4uecdu223F3JVomlkcUTjCZg6OAg3tjDSxu38eQHtA0Zp2FfuCqhZEgjDcSgAZNtchzVvwHmL4+nzTS951LgMRHlsMN0c2L6hUarYBGPQKnqqFgDh0cPYeWHm3E6w+eh3luHTAFgGd/O8TRIrfi81VgPvpARF3qPGbDi1HS0HFDocnwWqL4T6FQaRVD/+MTulVk7I0X3y7fLX1coEg02C+K35WJ67r3MILhgAK4s0WNRGamEyzqxs1laDOWKhPbxNbOoe4ZSPk/GwDxtNs36AnTt0Xe1k6iDscbdz5OFjYs0AkGHWSf5qfKW7G7JuGhZbM3qDUwstU2zMujmTtFwPvgKo28WgG376ootzLveqa/LOLdD674YyRqgLnb+1sneaZ5niMS3K2J416wN9xpFh0yO70DnIThfQ+K2AgtlZjIkwmk/PBwpxhII34yHHtjG7DLRsq+Y8K+TfibFxqYh6ENyifn6v6EYlZat+IMwDZv3FlO0h7Re5W1J3uJMI2UY9UMDsU9kwfN7+77K123Oh8HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(6486002)(966005)(82960400001)(478600001)(41300700001)(8676002)(5660300002)(4326008)(86362001)(8936002)(6636002)(66556008)(110136005)(38100700002)(4744005)(66476007)(66946007)(316002)(2906002)(186003)(6506007)(26005)(9686003)(6512007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I4bFet8dsgHyyxKcxEQa3utDHViCxIdZEglIUTfdatzlQwiYX89fUW7393Fe?=
 =?us-ascii?Q?sJnPxEKgRGr2z7K9QLyMHnRZqmtB0EeohEdWz7q7c9XFPb1f7UBp0GJnXgkL?=
 =?us-ascii?Q?+0UnY/9/5Uz5q0UVQixMtHIqCyqRHBOuS+2aUtr+w3UXAEQF23CKF9Dhuo8D?=
 =?us-ascii?Q?BbKRptJcnm649rnRgCzq6oFbrhXbBOGH/l2dStONmJYQBkX/JVXjCpdxu5LP?=
 =?us-ascii?Q?vMBVD1BUHcsoqbbUM/yjBm/qA8OKMu92K+ldULRS0TlIwkhX4Aq8e0Ohy+po?=
 =?us-ascii?Q?2k1OAXpH8VVlYaCVdL4pDkl/iFXlElaLmREKwqjD57a5fM1tr4Ux0QWgchSF?=
 =?us-ascii?Q?07GWYWQivNBBDW9XlK2MwIbYhjxpO62FaQgX0vF+ty56IoEo0x2akQd4g3rK?=
 =?us-ascii?Q?4zvWqXyGJQcM52TUZ/680zIxYjfAKGBoTsAFfyj28lJR+Qx87XZPLU+lX44/?=
 =?us-ascii?Q?z0C8KeAcvhpGt2sS+VWLXTQaOUeqSe6GQ8sJpAx8llDeQSOl2XUXkSv5cIMY?=
 =?us-ascii?Q?YhwJIp0xOGrjfJYU+2z6aSJq1g3B/TzvP6Z6/00j4qXDSOmP1lonCD8i4kSL?=
 =?us-ascii?Q?fXv4aAwJQu0MVkLG8Dp3r7lD4/HLbAexeZ8XFmTbpvc7uj7YcKnOshCttZs4?=
 =?us-ascii?Q?hcLKqVZk9fIZwA8DWkuPIOhbJouBl3k89XYb/4rq6eOhF5H8/LUAO16/gutb?=
 =?us-ascii?Q?8kP4MubdtsZvZGfKS8dGmm9N5WeaHhgiS1FK+Z1wnYNAZW+dIdwxZ/E6WO6u?=
 =?us-ascii?Q?GqHsLzUpOxXFIH0RUWbWfYgxVvKaH2OZUmbgYaMjQ0uhuB5lqSF3ukLNppv0?=
 =?us-ascii?Q?AHmvJF47hpaHTnPLRmaP/AW0YwVHG3k2hzL406Upa1XIXU4l/9xy+j2h95UM?=
 =?us-ascii?Q?NvbuCYwuiz6UlHt0B2QA6F27DULewcvQa2YGJNY2yT5npvOq2IM/Yi4ZruFr?=
 =?us-ascii?Q?pTmoOTPEQmJMNbSSCVcEhn3jTXhNA6t/xGjmbU2iqSeFrvOD9xlyhMiBzH00?=
 =?us-ascii?Q?ziV54npgpI4Fp00nxxTfpTZ3To+rPC5zLmebWID8nGKKx6IDO9QJ/w6R/boH?=
 =?us-ascii?Q?Sx4ycgPhK9mgT6Y4jk6KtOECsu1zXcDnfH9UIMb7okNvcZWM6seZ/efKK6t5?=
 =?us-ascii?Q?RkXZpPx2pII7CcnAvatnPD+BZQ5GUMUzIr2cymFjDJ68lJvCLPCoiUNbRart?=
 =?us-ascii?Q?UBa3hDsiwxMf1vuNT/75ur2N3rioAta3OnMV7GCahgypPWUltep2j3ufSmeq?=
 =?us-ascii?Q?DhAbfnoLqMig7zA7Mr9N6C1YunSh4UY71i1IYjGm738jc8mmwbv6WwxSk9MN?=
 =?us-ascii?Q?c5rs5SNI9zRl0KLk7KNDRclaFXORO2qq4GJKznhi5xj3FuADCuWJD9psX5rF?=
 =?us-ascii?Q?SqMgvrCWh4i5Ajssx0YEBKcqC+0t63ss+VqaPbVx+lyiYDAwx+wqt5FYQx7w?=
 =?us-ascii?Q?EjyOUV+JlMNGuy+uveOrMILOgUVXO9hHVeDOPKe0onR6xsTlD6ZgrxYvyfL4?=
 =?us-ascii?Q?i5i+sa+E24aulQXcLC2j3xhn2jqRYRGWQjL/qMkkEUbdnc6jciCSdvX+GSvA?=
 =?us-ascii?Q?tUD7BtoT/zJLZD+mkiF4NkdUo9WARovl4z0VMAzDs0TZRalM+nFs8NidYGgS?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aafba438-6b60-4aec-c865-08dab3bda188
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 23:40:26.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7guiQznnhWv0m530WQXxG3V7VGfhcEM5uAcFx9wCS+m0MMMZPbsvcnUEYi+G/pr80ptkI/1Y0mFoilymXNpA5oZ6txnG0Wwcs/yd/S5ltc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7148
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> A linux-ized ACPI patch is included here for reference. The actual
> ACPICA pull request is pending: https://github.com/acpica/acpica/pull/795

Looks like this is moving along now:

https://github.com/acpica/acpica/commit/009b287303fb
