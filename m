Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DE3EB64D8
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 21:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbjFMVGw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 17:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbjFMVGq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 17:06:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF4F19B7
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 14:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686690405; x=1718226405;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qVdWTKQ1wCdEL2RKLBZS5DOWookNg7eaTzOTI4AR3zQ=;
  b=eiJiHaHiIwHDhfvKMMSxO7h8lRwh9zu+0HLATbK1DDx/vFXPPsKlW49/
   eO+SamsfQje84r02a3yDgwoJtHr6ED/AGjeiWtJoH2GYcJ1XLRY8z2QU2
   0seNtG3jGWc3UfHYqVG4P9HvafKu5sg0P8podaid3mkyJi9kZepOefdaO
   odaZa9pVw5KeKV0leeFbq0oh3osW3YoJPwGM/TwK5PG5vgXqyeQewtAez
   1ESv4Jq+fg8qk6eqozJsbUU+v+pryaTg6w5BAoNL+ZV6LMr/TSazP0DWr
   JhOIwOpy8nGovAk0dgVYMTtc5B2H4+nD79PLVwXAjfWBVFJemc04PjKre
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="343141744"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="343141744"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 14:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="744829573"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="744829573"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 13 Jun 2023 14:03:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 14:03:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 14:03:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 14:03:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STxgcWZaz916W0FX4bGWIVVyqYmgqOyuzwOCd7rpecg4RbSTMIv/c0b9x6GRP+aKqPT/5UfUxGUQxtjksmVpTymeQcHMgWk2UcpD5VIJToXPdiDgWpbPBcYBgo2a3NJxXQplRnjzxb3Q5fGkt/JHeH2EARJRDDXooGcs6aJgM/LawhkKPz5n6SyVk8oO0ZnUc7o84sStFH0DTjbUxaUD+PQQFWOQ1pfXnlTJNR+gsKw1rEdxe20xIHXKjvyihiiJ1coWdCiwrL1OtwSNi9btq79XnGfpytPcAHAcLRNYwfpM/k7ZsG7r1/EQqkyCvHvJFPmKq36M17OMlC5WVZ3/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd17LmK8EaW9KBay82K3QYOIP6PCv+6/O6nWuclj/aw=;
 b=ALG5re2DYXEO5MjR8ziptX60vY/GIocF/aryes5Mrz0RAdrbEkCvmW8AkQ1lMQHBiCfzn9fFGS8l0EzZuemwF7/n8bKo5pGCIniKT8jX2CUJp6HVkctfVSD50+a5ggXj5ipNXfyE/ajG/CZTx0g3LjtT+g7s2wzhYtCYtQVhsNpIU3Gi+bC6vq2nQ2kTxjm4xC/ezfQtBjRRwQ0fE+PWhkTw5/dYn8OC0mpQV8YNtyxgDGstUgx3WGVyHVMSztDYw8PpSvCGVWBdju/ilvTt1dmaFD/K5CxzFN3TwxbmBsuEHN9vHSKUzGlIfy0q0wMTrNqOJz1X2w8x/8cqM1LN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6543.namprd11.prod.outlook.com (2603:10b6:8:d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Tue, 13 Jun
 2023 21:03:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 21:03:52 +0000
Date:   Tue, 13 Jun 2023 14:03:50 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 05/19] cxl/port: Rename CXL_DECODER_{EXPANDER,
 ACCELERATOR} => {HOSTMEM, DEVMEM}
Message-ID: <6488d9b68db49_e067a294ee@dwillia2-xfh.jf.intel.com.notmuch>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592152508.1948938.17633369037592532464.stgit@dwillia2-xfh.jf.intel.com>
 <20230606122108.0000110d@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230606122108.0000110d@Huawei.com>
X-ClientProxiedBy: BY5PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::46) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3ea62c-439a-42a2-4aae-08db6c51b136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4D9o7nvu9Gx1CTzEH1jl8ZdlhP2dzGiEVyy6wXagYXN7uE97VvtsOmv7Ef2ZuxjamS+XTqf3FuqWKr5jcv+YnfVdu7MgldXG7oTe0sPuMcEUtR2EaNCMpUXTV5rWxNXjEecoMMzEZKzxQoe6KAIHJMd4H9OaFmkafHYgW6He4VSG+JAAi1dSZQpNFqMUVYQ5zlOcur7a7mn6fGrcpE196Gu1Qv2fPVWXx6PGOBWEm9plBAUJzcuCNosU5FxYwfal8RL7UuuAwp7AdY2bwJe55waCNQkLzH8Mg8Ln3Redtcm4c5P6yB4FF3zmnfWQHPzajO/iDvAj7Vtt7Q2Vn3HDLY4V+Rx8TcX6P9+Fjq9dChYA3r2XuV2UFR64GjQSQFpiBz8oDOf82c4WHgp52K55DSMnAZoRA66IwxzetqxqlYSJKuLaVxY6blWVCaCvtxwy2QOmMd0g8wcOzC7Zl3F0HRlg46Ku7NkyWKRr7RfYSOdzJv+zf9wTvqSU0biIgK6X4K2CmWPkJIgYrtJXSEHlTbW1wMimocq1RNb3qRE40xFb+MjHxO9t8slmGjtPvQsF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(6486002)(6506007)(26005)(83380400001)(5660300002)(107886003)(9686003)(6512007)(41300700001)(186003)(110136005)(8676002)(38100700002)(82960400001)(8936002)(478600001)(66476007)(66946007)(4326008)(66556008)(4744005)(86362001)(316002)(2906002)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xxzb2CKAG5luYWaC2dKH0bz0zJrJSVMHDpmD7+BmD/GAkX4M4okOYtKVL1JL?=
 =?us-ascii?Q?zoo1MvKFShvo1tfQFDTOaPTx8ZeaLkXT1Ln8+pO18/yHmclPz/JTON+1JYGh?=
 =?us-ascii?Q?IIW27v1M1Yuo8lXlAc+MUnIwYuMEQSUbATq0RQoRsjA5mtnSxIxumN62EH99?=
 =?us-ascii?Q?4KYgjjXaQEl91N3craevqmRFTiEG2FtQdZiY2zvFTH1nC69lEufUXZuAa31J?=
 =?us-ascii?Q?DOsctWfDRWwNe5aGdFo1fCqN199JQPXwD2wyzQDT9SIWf7F+tCDdBS7YX1q+?=
 =?us-ascii?Q?otSbjxgjBEEyiISc4K3KWNCP7OGtUVn5Rwpr5+kAreVBdn+djG1gnQ7UGy9r?=
 =?us-ascii?Q?mz+2dQ4FerN7pTubxnuVQDCK+LYxpbM9r2VeOz2sj4pDdsOqtEuTjJsS6QKT?=
 =?us-ascii?Q?gT5B+z4c8uEZ40NgokE5roag18pixAY7UZ5nm9R6ie9PvMug8iIEC9J8m3pG?=
 =?us-ascii?Q?GBn1bJMpjMyIvOfraNWXwcgysvhZYRij70hx3XTrrzRWKId7nHUnbyZCgu0Z?=
 =?us-ascii?Q?Lv3r5Ug5cOiLO8NPZq6/oau/C8wuz1PIMuVfFL+LEluKmSLJok+vw+PPnGWy?=
 =?us-ascii?Q?Cr7Zh6x03VanscE8kqLgf020tx0oRZLFCHvpd18uuD8TkOJY9H93OD+0hOM5?=
 =?us-ascii?Q?kRj7DfBgGmz/Czghi3LE3ApOjzMYYgqusUsJHJ8Vh0tz18piYbyvJDMf3rY3?=
 =?us-ascii?Q?vHGIBg62nUTVd3Z4Fhg8CvJBWnGU5H2bvNVKyuLjm6H83JMn+ScVk8RiJV9i?=
 =?us-ascii?Q?93ZnMj92eOz1fJPzydT6qVrqatlU/Qp1KqLJaRHUeIpZgpcQL4yanNQm/YpK?=
 =?us-ascii?Q?GBcWcMd7QZlTJgem1F+ZLx+d2aNdnPNP1O6vyRROTJmNRjUgQY9fJDw7+uTW?=
 =?us-ascii?Q?ktzhdKPbXJeWtiksmAmSfunB55m8KyMXmMyO1fx8tIENPGhyFEuvRdJsbhOF?=
 =?us-ascii?Q?omKEtGZN0xOwzTn5MwAZDn2CSnLzJkKHju3LL+rhkp1u2tv+XFhB1bPX1nW3?=
 =?us-ascii?Q?kQfGqBkX4O8eyp6YjrSReF+JqZaKgWwMVGFio8BF6ibusuWuX1v5rJ5k72rR?=
 =?us-ascii?Q?uRKBwL74luHC+G7+p/TyTHmvAw+JRZdyg3GBOj0Wc6Se3w3RWuBthcEgSb+e?=
 =?us-ascii?Q?J5gik5RvF5xcH3l7EufecVo/sjN6nbzWEeQCBW9kAxvu0Wkw6f6qSzAT8Yny?=
 =?us-ascii?Q?U6adoPWAI/5adRqU1+GqGdwbH7wDyVxcILMBlMleqL8NwJlxwFB66JRgZx/s?=
 =?us-ascii?Q?hicRbR1g2HD3O5fhzeiAHgnowXFmsuNZZspLcJqTKwxHD9N1kAAgei7sKVnh?=
 =?us-ascii?Q?KZW1UPfzAELZRFmAQzNlXOpvT7KYpyD1aPr184wfbe/IRFXbgFKiEPaI/U0r?=
 =?us-ascii?Q?2idSfRmkYPJ7l2mMKLRW0fJvf9GOD4dqTgARmqPaCeYvfPZU8EFj2/uln9sQ?=
 =?us-ascii?Q?l3KaFV6/s0ZmLuPBZc6RkmA15GHkmaAJpeOS2CC4820hQcE/pjyhpw7mko5H?=
 =?us-ascii?Q?OQ/fpkddk0Rr7Hws4vRIPDe3wXOWOc/iaggZf1752ikYlXK92TmXSChAxT95?=
 =?us-ascii?Q?gYyDsZ3EGjt8aE9cBKVK+GHzWsp9K0sP3jebM6DzyqxDztX/Era8jp384rel?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3ea62c-439a-42a2-4aae-08db6c51b136
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 21:03:52.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJu2gxK4ah6mbimIjhpBDrml0o+V3bR8U7jON6SL72MtXSK+ovZB6wH7YhwjXhSC3fF0SlsMPuKmDuk53E/Tgi3GAkuCWR/WPfSKPKXj5q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6543
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Sun, 04 Jun 2023 16:32:05 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > In preparation for support for HDM-D and HDM-DB configuration
> > (device-memory, and device-memory with back-invalidate). Rename the current
> > type designators to use HOSTMEM and DEVMEM as a suffix.
> 
> I'd state this is inline with the CXL 3.0 spec naming.
> Device coherent address range vs Host - Only coherent address range.
> (or rename HOSTMEM to HOSTONLYMEM which I think deals with that subtlety) 

HOSTONLYMEM is more clear.

> > 
> > HDM-DB can be supported by devices that are not accelerators, so DEVMEM is
> > a more generic term for that case.
> > 
> > Fixup one location where this type value was open coded.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Bike-shedding aside LGTM

Thanks!
