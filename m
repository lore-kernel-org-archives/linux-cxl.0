Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08366E7734C
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Sep 2023 23:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjI2XlZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Sep 2023 19:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2XlY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Sep 2023 19:41:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57FBF3
        for <linux-cxl@vger.kernel.org>; Fri, 29 Sep 2023 16:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696030882; x=1727566882;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5w479ZOggN5kbROAsgYfI7PTI5FFYlAd9QxnpKlPLac=;
  b=h2nt6F/fOhF4eQb9I4saf5SmbuJn4Wv5TiW+SNSbpISL1jKKcwpYAPcB
   zFwgLOQQkFOGZp5JI6rhYrPg8KFxTO8wFcMRY375/znO0qQloe7qqT5ZQ
   zA1NbZsUY3S+b8ZjCzo/F0wNi7T7W2stLemRPC2DkQ2YnOa4/qRVVVS8R
   QPoaxKalWBZWBllv8MnEhqKYoRTMikP+DL7KnjDUSiE2lJ2h4iEE+hEnA
   0yTfOxiU8Y1AZEgqBerOD5WGLgF3QbXGp/OhIqdDA1F5akhvuqidDuMbX
   C2nApqtjKaD2zj/6/nLggJ3UKUxA2Qf+r2WppXlRyNSqEbZ4ezPKaBJt1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="367459828"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="367459828"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:41:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="726736188"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="726736188"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 16:41:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 16:41:21 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 16:41:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 16:41:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 16:41:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFZpFNnFrpIjpBd5ayJyLZ1Al/UoiLcFN//FwJNc6u8EuuRr9R5aHUTg14eTvfnC60mh9kKALMu4Qt9w2nuPX9t3dt8WRVLs8GjCQgky+zOLZA6lDzHlhGfLXxhsD8RDOq7vu7ht2wjtV2DvLFITHqQtgSnVlYplVODodcx7vQSepXwbXVXU6Pmbt+vC64WselHRumwNvCR0THOLBiBLBtyzgLFwbbGMlDuZn1kv4hjWEtD+9B0Zs7FhG0QkU6Pmr+13/RJV0adO/W8/MG2Wggd/sXGaVrqti7jS+IT7iMODDj2t3AWJcIKpbxpHsoUWMuewcarmfIChmETDikSq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW4vy/wIve6AGjdbc7qG6Uw4MHB8Iyw0wlN3OFisGqM=;
 b=bYlHfs63XlnksnL+xXmIhzduO0idKCnPH59IGA5kWdt1J+pCcPeN+1SDBTn6t5FzipROKgRPByf9arM5R2vYWnvBdvBJCduuUpKWf2tgfI6oQmFQCCuQCbstlLAO9rIQrMWvzKv0ru/+noPIuH+jDgv6L/IsPqbp1rfbHlbG+ebLQrySYGJWxktGBjhLczFu0NT+snoLJsvwzd7DdoJZbGYUjzMc/1f4eIkBb+e5/Xwci0QtzCE/W2ncubyY05lVbqoKvUSFbMs5MgBApHi+F8OPZWeB1zHXh1CBMghoPgIm+71Akyw/69443LeUaXJwzgVnHs3NCSaMrY71YehjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7622.namprd11.prod.outlook.com (2603:10b6:8:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 23:41:19 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e%4]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 23:41:19 +0000
Date:   Fri, 29 Sep 2023 16:41:16 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>
Subject: Re: [PATCH v2 1/4] cxl/pci: Remove unnecessary device reference
 management in sanitize work
Message-ID: <6517609c8c6af_168c46294e9@iweiny-mobl.notmuch>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602897366.904193.9449207727775648546.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169602897366.904193.9449207727775648546.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 8946b572-1c24-4ad3-1c84-08dbc1459481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +24RCAl2yF2pjhmFig1RreP1K4XhIusl4ZnNeyKY08YBDxssNqU5YcQABLIUxDS2U56zTnTI3wfiD7+YNhh8jbEiC8QEHV4W4M5B8XugtXNWnjsvHcQ9CvBs0eeG0HOPf2F51y/cPIHUdTODwg0lCpc9BqK6OUgnI883qb5yAcbgicc2EUPyDEI81l7jDNE0L4u+GXGZp7XeiNNqb10LM1qxS14POrbGFJeJLRfjC6YcvxVisTzXG1oCBzY1qpGozBw3IzHdqf5aQiq4UFQNwt5bTuT78I5magPYwDYpCxyf09sMhKbzmRO7R8AXaTAjhSS2v/P68px/E56KfdnnOxmKXRkKLg+zp9/fKhLqO/DaMrfJQQfeEl7fN4kUe6Nlyyu7br1lQvZ9WxaMtll85MxoUMBkY1ONq9IP00PqZWTgyIoFll/ydx9TMQ1ik5hBJHVe4St8gd1wIRVnshHm4WBrCAzZD0KgxCXl6W/KY9E77cyd4Hoih5SkMXiQzWnC4uyTtNEJ/q2627acrpM1KHiwmcbUgxySi0X/L2vDlrG4jTI9i41eoV8A+cSLuFUw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(4744005)(44832011)(5660300002)(8936002)(4326008)(26005)(8676002)(107886003)(41300700001)(66476007)(66556008)(66946007)(316002)(9686003)(82960400001)(6666004)(6486002)(6506007)(478600001)(86362001)(6512007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AO8uTc25HA3K3clo0HM/ubGv6gr9xElgKrzGNQB40MsDi7Spnf5HR5LT7WEH?=
 =?us-ascii?Q?D79Tsd6OfUPggiHar73wpyAu8rOz4+dNJcT+qqgbxi4V8jeuyhUhljk7Q7LS?=
 =?us-ascii?Q?wtTRRWQdPhjEYUxr/d7cLnq8RSKcaMbZnrinTSwn+TKd2D51cT8PGNmYZNFe?=
 =?us-ascii?Q?UbuAh44lkeUFKp2/lF/Ke2IBMopm62nNV57MzcADCtQtihlITz27255dRVdT?=
 =?us-ascii?Q?i3Y37+KXxyRtpzvNDWdCFut5mM+l3+a8GBD+hjj4D+OzwWvfbw0fHKDbqsD0?=
 =?us-ascii?Q?xDT71gMee6Puqgmi5hwRsXo3gzVeiu9KWrkLe/tQcA7j2XinqyrlAIa0eFcL?=
 =?us-ascii?Q?FbwuQVWhsa2Y6DrYpeFjBC34F4mCuj7046b/ACzGgD4CIKiHsZuTP+YO+Ye7?=
 =?us-ascii?Q?a5zAM/sh3OUVRkvbl+h7WmGDAs/60SXv4knPSs5b57V2CiITfCtofweGHSRD?=
 =?us-ascii?Q?Dx2RNGGHBf9awQEzMrAAE87tFEPCafyaufRx3pNGlmjJofj21CaSLysZbq0i?=
 =?us-ascii?Q?udV4wHpLXn6lwljy253nl0j/9BxKthquH/AvV57Lv4ZbMPH9EyPIDCIibvDQ?=
 =?us-ascii?Q?ZzRxqciYrMMB3G355Lk6B1wJhdsGp/KK4vBT3Q6nJbxhNp/gGBpN1gI27HOU?=
 =?us-ascii?Q?Guf60WkfCdX0epE35/7GOHUJe8D08Vlw5wGy0VaGm2oWFP+7NrtsYFhWU5yi?=
 =?us-ascii?Q?nCeJueUm0PZGuRK0gUGnUMtpJ6sVuHTLRLnbWmPSaQpKonaoaMmVeSoNtrQ4?=
 =?us-ascii?Q?sGVsIEzu+hUEs9dTcQutBlvyWPbbcuVLEdDFfA7UMSvEjfWJNJUwhWMgB8l+?=
 =?us-ascii?Q?9wqGNULE/txV9cSvYcPpZPhjD9rXmv7rXfMv0njgm81bpQ3kpzAkrqlSDYdc?=
 =?us-ascii?Q?1Z9saC5dR1KaUbmziVje28rOO01BTcU6EFcVEXKqVLmF7uZNvq13c0regcyB?=
 =?us-ascii?Q?NLvEusxEfEbW7WPldtGUadUtPmtkf6DQL1716PXHr2SxRFnP7fu5Dg9/RZm/?=
 =?us-ascii?Q?fw31XkmqSyg4QZ8s3ZNuhWILtz4x59gInEjmHPKcxF2kOYaBqnNDIkAH49I+?=
 =?us-ascii?Q?1IPWN63BNwZ8H95F3Y+qpKko1vBtfqraz60Bbks9uYS05WLj9UB5LP8wYBvj?=
 =?us-ascii?Q?+Hr411jAsmaip+tOXyrHGGr6/hoy3mL4PIf98pVCctgy7lNcpFcskYA9Nfss?=
 =?us-ascii?Q?ZvJPLoHYQDg8GtUucNMUyTGExnf10gKXJKhnfkU1MgRnEbAUXDuawOoxzgBl?=
 =?us-ascii?Q?3lqFeXYy1jRZ8ifzbQp3v6N3VTSUsxFU+HvkcUNF0Yx9fJlV0TUTTLrB4kfu?=
 =?us-ascii?Q?lAlHGvWqmmhBFoHciO9PwR+8jDbfU6NfxcHi7j4ZtIOphyflFzXN0gxGOMD9?=
 =?us-ascii?Q?7sKcJyVJJA1e60/O24a3OvdaCnwiwxHEB3EX38n8bMm/EFO0mgIjByKW0RsN?=
 =?us-ascii?Q?eSxBzOp+eI0tBOYI0nz1O+yfQd2zvnhxz9TsMtMiedRRhBQBeqhA4tEtgAnd?=
 =?us-ascii?Q?N6vIDqUwYNFHqKuE3t4qKVYXg9criCY8cbQFXaJeno71fa+zWkxKRzyoPQc0?=
 =?us-ascii?Q?wpPzQpAtMEw+UFY4/swwTF9Mfk/EL33fLD+nfob0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8946b572-1c24-4ad3-1c84-08dbc1459481
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 23:41:19.3001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJF4j3P9aSmBdo2d1PYWAzop97n2pZrCT8Gf+O+xlcCneETwBLGJ/e+VqJCml0yjFzd5ehOOV222/+8bFYOrNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7622
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> Given that any particular put_device() could be the final put of the
> device, the fact that there are usages of cxlds->dev after
> put_device(cxlds->dev) is a red flag. Drop the reference counting since
> the device is pinned by being registered and will not be unregistered
> without triggering the driver + workqueue to shutdown.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
