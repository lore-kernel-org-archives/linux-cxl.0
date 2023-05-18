Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F47BC77B7A
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 03:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjERDHz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 May 2023 23:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjERDHy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 May 2023 23:07:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BCB102
        for <linux-cxl@vger.kernel.org>; Wed, 17 May 2023 20:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684379273; x=1715915273;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pfXnSWPlFFQOnXrJBI0hedwagWcTRp1j+rUj5zqq02Y=;
  b=TvqTq+o8GWIGSBLmlIAZMVj5AUuRmqxIiMsz1pqZEBB21VjbnLkRyBzh
   HxDl0UGDHMQl/jS6wxPL6YBVGKQCdZg+acelJDLUqzmSn4sN8aKcKCxwG
   g+cuCmExNdzXCn8SLB/X7D1k7UFMoM0tAy1omO8PFwPEEtmZBcXFaLI7W
   EpSh4zdrdqcbXGjvx9oT3p8pgsoI45ejnjrlxmv4A2UaCp1YxQ48OEwvY
   5jOU+8yI5JKqJldVbLZeoega2T9kJHxl90XxhB8j5bcGivpjQr4gG6Lc/
   zL5CviKfuah+6hMzd9w3OIxuNY2a/z2VOXpfWVNd0q76kJS+oMxErHZp4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="341346829"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="341346829"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 20:07:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="652471566"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="652471566"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2023 20:07:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 20:07:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 20:07:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 17 May 2023 20:07:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 17 May 2023 20:07:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijq3TfE87ogwQagxNN3YesC1CVYoaSoQjIZj2vvFoEPu1dEFxhwD+/QKciJJ9/XzckM694/d2ZJhH3APfN71O+ezOXrxAVnhkxfdbQtGsJ7/bnPWybjFu1PO1N0xwmKrdP3i3xWXTZ89PF63zzv546KO0E+rB0tUlSWw6PdSfl2aYUC0SNy8qu8TVhKtvlBjc7SROglgnXr2hTCAXFYPppmNJ53ToaVFi2Cznh3p7u+J6rL3D+9NitPSK8C3MsGioFRD/xDDj/eGa+frM9jCn4+He0a62Ro9WLPfCYSItAKpqRNy4sZrG2WBdJUWV4lJtqGz+B72yKDdKIbOBMgrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibafec3wTHF/jEdg35V/wCruSPp41COQf49+yydXJMw=;
 b=AuT0ssKf/cp8Swu+/oWsIe0cabbb+ckQGkAjLEF66U4Y5IoHAoARYx9ZoS2HYz0tzlS2XEg66n84yFeRLHLK50Stfic2O+IfiobQQti0tZ93O1eiYp+IRJ7MdS0zRiAFOTPY9DVjFDOSlx/4WDGTSaPRu21RKcdM8ZNq1V3exIN13gfencXtWmjCQpWD6HkSGgC8mA45jDAyC23KY6mN/t1RzxrrIM+cbCqcvvSXzreP8Vcksvc8xl/efthCizeiHxKpuyao/MR2pTBmXJdmefCILmiSAIV19Bh/VOfsba4xztK2Sksrs9Vj1IiMDdIPsOoygQtekA5d3486hi3Vvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7652.namprd11.prod.outlook.com (2603:10b6:8:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 03:07:50 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 03:07:49 +0000
Date:   Wed, 17 May 2023 20:07:44 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH 2/3] cxl: Move identify and partition query from pci
 probe to port probe
Message-ID: <64659680bd66b_109619294ee@iweiny-mobl.notmuch>
References: <168428284429.2205351.8883627879572769367.stgit@djiang5-mobl3>
 <168428296504.2205351.15006863208285686036.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168428296504.2205351.15006863208285686036.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 45405dd4-8b1d-400f-b33a-08db574d0fc4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HaOfg9s+0INXluR9/FsuOrEo4vXBiFPl50KdOBpHuHcNchhoT8vEI36msTwzpCC5kU7gzbiD8/hZ8Bvj9kvLUdaNmfjOPLnuvbq+zDlx+OZRYMQPVgBlJJ/+My1tE+gn96lj5OTjBBjOC1JtCjdjC/m+74PjIucEnGNVqbQMfZXAPaAQp3nJfPID41t85bz+xBAToeeMebtI1RDByL/yoGfpIM4MA47qItKoQEpo4FcfQ5mDpNWecH3cmtuJ75fYt+G6+D/ZrUjDWb7iTM9rNcyrvGRXsinAkKzanlDKKyhjU4xSyxFBEEu+wRlOke7016XqBfkGjjMjJuzw9bynAbscYrSRxLPVlBcEPY/b8g05nere6MzUHaJqzFhzGYZ+cPzkV0+ro/Z8i+y+H1Y+3piaL312DBpoGGb5+MQ3zfMbMdqOIVY3I+mFZqtZ1PzPZvUBOGB4VnPXKOwngX80JiYGUbdL8T9SfkcvMJzU6L3kJY7bqyMnz1yxOTh2H+HK7NvUDmsz0vMh6DZ4nwJ8vkTfrHkW3Cv9mnD3yputbni0HbeU/AFyyMUNpY8N63Jp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199021)(6512007)(6506007)(6666004)(26005)(6486002)(8676002)(478600001)(44832011)(316002)(186003)(4326008)(6636002)(86362001)(5660300002)(66476007)(66556008)(66946007)(38100700002)(82960400001)(9686003)(41300700001)(2906002)(4744005)(8936002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qyQbnj8k0uwN7tkxpQbL6AANp2/Rwk+LC2A4IR2uVZEh0PC7XjqqywrnrsZj?=
 =?us-ascii?Q?KlzTRgtRUHcxvx5Zzmc26B/5PcF4de1oTo188e9BbERUsDjleLHuU0/cnJXR?=
 =?us-ascii?Q?21Lsjaio7kSlCDnx4ovOYHtPtoxkCREqehQRxWq4ESjEHVrK9+f1bu5DsO4W?=
 =?us-ascii?Q?+bt9rSbTeEod1+ZpD/lSEB+RnlCIfxgW7Qd8WanyxP+AhpT3x/eY5hyIrAQe?=
 =?us-ascii?Q?pxpGTCmG3uZX5FJDQbcUr/DBq+l87uNY87qJgMVxEKxtOcYcROqiSe6A7Mig?=
 =?us-ascii?Q?G0LgvM9JFj7amPbk6q+MAkpIHv7bnsWFbC2N7s8WWDihnq9EQ4STTC8GoSQX?=
 =?us-ascii?Q?9/FatEfWpPH8DJdCnyJK5muIdk5QqSCaRG6bA19aKys36YitaKln5wvU5eQm?=
 =?us-ascii?Q?bkvX8dcy9+7SHDpD53l3VnttRH58Q5i+5kS6VkHExnfiSNYEkQmUtBYb1YzM?=
 =?us-ascii?Q?X7czVzM+PYNzY2CdFqbwGmH56pi/LEMkNHnfZ1N278WRRJ6eV6/kF15OK3C2?=
 =?us-ascii?Q?OsB5qfiTUWGUoWHhCiuChErEj+/KtKvOM1q+oN0BQIHUuA8sYnnBNRap3pNS?=
 =?us-ascii?Q?icxmex5n26azWzYaLBwkzhN2qDooGHHqiJRY4tK4dWkMAvr5Kes2g2w0bdps?=
 =?us-ascii?Q?bMa4EMI70LN8lelC9ODiYpLEBEcdoNiinTnHzz2pe/mtJLUT9PyuNzD3nnG1?=
 =?us-ascii?Q?wyHTwGMkqzf5je7cUW8299/4vt5iW3VmCYAPdPGCPjoXStc58HRKnJSVvY4h?=
 =?us-ascii?Q?r7W4lH+QibPXU+zAoHNm/Z9xc6U4QDOaOexINiA+FQgvugAGYidLyz4KHrUQ?=
 =?us-ascii?Q?+acNoAYac4KrODSOnm7vv47GaQb9Pl2/CYKT8YIzVbX6e9XViDGPZyZB3W99?=
 =?us-ascii?Q?bJhLD5pUao6CCt9qUyip/xtQBpB4lEnhACVeS2FqOS+NXMdGCvTQ5N7g7E6H?=
 =?us-ascii?Q?XEIltqOQmWj6IxCuP9hvH5x5uzSSGQOsmm68j98WNJg18a70CkoYGalZIalc?=
 =?us-ascii?Q?H2iM1FS8G82L9Ix9ZDkfvII3pFty00JCym7Meird5suptd+wyzQCvPPIFiAg?=
 =?us-ascii?Q?iKrA4kMQ1K3OzWvz1o2wdw30oAyriRhDfw/pIA+3cNcl1e4RaPEF0aYtFR5Y?=
 =?us-ascii?Q?LUddH2WZf8pQ45kkPYIftS5OVhbCbzdyqdWJnTqwyqF7TT/ydoJBAfsBZquN?=
 =?us-ascii?Q?npjGchT/N7MpSq8uK0O2GAGVa/CHmgpwvN+8ic0PiYGnBpOc5ea0ASL1CTT3?=
 =?us-ascii?Q?N2fQwHUwGnJL4iJcsmmC316QZbnEdcc7juvDOvjhGQs2H7KBaNooQ+hy+T+J?=
 =?us-ascii?Q?naODBNiSRrGdPqAhLTZ1rifWUQOxDFWmQPwIEcn/jCJm7JOBYlEt+Saq8ho2?=
 =?us-ascii?Q?aWsT4Ls6/f81EFH7SsDyfzQqe1xJWzC98wCO0SagKKdGANvo7rpN7WjLEhZ2?=
 =?us-ascii?Q?0nPIRa2mNvqhkFhhcjPkn95Lw1Ro4VTmgwf9Uv7EiR+HbYqRYM7v7x0yvs8r?=
 =?us-ascii?Q?qedB7vhpsGnf8ItDBYa6yVk2j/vlhaO+VgrJI6GuOy7ZxZTpk7UG/cGE83+T?=
 =?us-ascii?Q?5HM+BwDSLjfTwT+ThKfZoDcOpdP29EZPxBbYYzkz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45405dd4-8b1d-400f-b33a-08db574d0fc4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 03:07:49.6949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZ6KjcIrfwuLAizCrosZ/9MCP6burJoOQy7PGXXjtj73MdKb9gd6RCfba13uKKfB4ezwrpSqvosC2y3DqG7nvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7652
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Move the enumeration of device capacity to cxl_port_probe() from
> cxl_pci_probe(). The size and capacity information should be read
> after cxl_await_media_ready() so the data is valid.
> 
> Fixes: 5e2411ae8071 ("cxl/memdev: Change cxl_mem to a more descriptive name")
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
