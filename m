Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3502EB64DC
	for <linux-cxl@archiver.kernel.org>; Sun, 25 Jun 2023 22:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjFYWeb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 25 Jun 2023 18:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFYWe3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 25 Jun 2023 18:34:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4E41B9
        for <linux-cxl@vger.kernel.org>; Sun, 25 Jun 2023 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687732468; x=1719268468;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LWU93aCBRsD9MfOwGM1UDBVI7XH5qhZJ6fBQ5Lt4JOY=;
  b=n4vLpvkfXYgmX8WSXDPv84O/PhYSKtQdNYnsNIv26nlPxnntY/UDm12e
   L55eQPbPRNUhbh2T7mmB6FRm3pdSgSsgSoDCLOJ15ub343JX8Yw9r5Bna
   CIBfKkexHHXLgosNfwS7HPw2d00skg9D7sdnFTUcnnjhedl7bUw63mprP
   izeoMvrRXMpw0TLSYDPkdTqi9Ny/3t8b7geIdAxaRQHwSSqwLGNRVwulv
   j9mB0jNDhIWo13E8pfZOFefuuJWz32PMuegW4X6p4JikIzU+tmiMhm1SG
   UcWfQFjSUBLpfIHSEi/dKSJkb5sRMigl4whQT6or6ueLIXS2DxLJXnxyZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="391321636"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="391321636"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 15:34:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="829023877"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="829023877"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jun 2023 15:34:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 25 Jun 2023 15:34:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 15:34:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 25 Jun 2023 15:34:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 15:34:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfP9xfUyT2877Tqw7uK1yp0YoY105BmUy6TgCWrJQ7Qtn3lQ/Gz0Lq4J18Vgp16aASZIcfxuGKEO1dVXyEdJgT9FKq9gTzSyWQMy1lxeWYEZKxeaZzZPx7fo4thlKm1vt5v6L9X7+4utBYDlccHclt3ZKz6BOV2ZNny8KhUhmi8mcRgsqrluPtBU2n65mLbW83TySZ4xM0L6hWQLMcyg/QBK5bYxn/r+2J2qhlwnnQOFy1/XTGrkvIvuYoezyjTWkapdYdAR4I380ha4rWuNRr76RD0JXmxObKhqzFGJlLEuqWhe2SgieIhTCmd4eC1l1gsInIEv2hdeZOAicfO4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbGBKuEzFwURop+LnngoNQMxeo8SxVbPl50yVOmH8UA=;
 b=e7ym+ztzKef81ZOmyg1BgK9kQLE42UaAl86/fpNsLD5+M96KtB1YEwIi8pBr/jZWm0+p9Ru9WuXrBib3YSnoT2n/oiirgKXCW69bDb/Qvxz+M+2me5CylXBmNTPY79/mQEfWe2AE/7oqJ+qPdiqv0k+yfkPElOrpVQXMny32HruJb/H2VSVeLCIDacI6G2WwiX4GrdjO0bNgJ74wdB93nfGyvmvzoS8lwTRX/YEbYXWT9fodWcSGjKeny3jfxGUxCBgCDp1W17uL4ZxbCYvXfLWQiVXPqbGuU3qFB/ric+Bjp0GlBdEH59Sg+gUv+7J11Z8cxeDPt7ladbNxnk1stQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4757.namprd11.prod.outlook.com (2603:10b6:208:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 22:34:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Sun, 25 Jun 2023
 22:34:23 +0000
Date:   Sun, 25 Jun 2023 15:34:20 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <dave.jiang@intel.com>, <vishal.l.verma@intel.com>,
        <Jonathan.Cameron@huawei.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <dave@stgolabs.net>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH 4/7] cxl/mem: Wire up Sanitation support
Message-ID: <6498c0ec8cc41_8e1782946e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230612181038.14421-1-dave@stgolabs.net>
 <20230612181038.14421-5-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230612181038.14421-5-dave@stgolabs.net>
X-ClientProxiedBy: MW4PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:303:6b::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: d03ec594-e6fb-481a-0f03-08db75cc5346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iOqpndJPiEAEvLk+vRYpRhIGZYILd5CAX5aTJix4wUouOerHCaM3Eh0XX8gS+tEdTzeBAnVMdfswXd/r+GSwy72Dwfd4ZbB/vUXAUkm8HEp35T/haqR1nAY8qbrFAdudMrF+uhU8DVh3asDPI4FD8X2taQ+t2uMuiBh5cqX0yomj5+4/1wESdI44DDivbOePhqIrPwN1sR5XpmnecrWM4kpbOma6VmvcU1xFSGXJgQoSeOL7eZsK88EolQCMHppefzr464qmI0liuFPODxd4+p1Ik++rnf0JmRbNjUEyqsN4zAUW/luUZCQUW9+26z8rS66UzcM/JukRveEBRZyMFYMTDZg3fPxM+uJzd55Eb26uXrLDsL9e6J031MxkizOzX8Lj0OE6nTh+wVC/Rpyixja96AFelpT/1q0iu8YPSaF4pyvUzACH4pFQBpMjEqzsNBx6i5TfPuY1nUZ6k3V4n+7kBTMvlhEUUcQyuLIrqJUBLHPv3T26v5LfqfbM3XkLmRv43H6ejt/S36uzLUulbn7j5GGKHEcPjG+/HbJFRxhXRlS5wgbQaT/+vfJn/UH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(5660300002)(66946007)(66556008)(66476007)(316002)(4326008)(478600001)(8936002)(8676002)(6512007)(86362001)(41300700001)(6486002)(2906002)(9686003)(186003)(6506007)(26005)(38100700002)(83380400001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cdxnQA4Ol7YjOkZdliEBGn0FiGvPszh8kDL5oNXhceAXYm3DVkoKNZ+OxtbD?=
 =?us-ascii?Q?qoU0Ol+61rNq/Re9Fc98iBaWmdB7nV20efl5bEeJIU3uPdQqiBeNIVJgYB0N?=
 =?us-ascii?Q?8t/uSK7ebMb7hkONHKUL85iEk1GfQhkMKBWIGK0HJrk5IgXUqUXitYQLAVIi?=
 =?us-ascii?Q?V2x2FatSI/sLR5jOitg+C6xpVerg0mYjXX20OXW6YIHzN7ioQ18ThVyUlCMy?=
 =?us-ascii?Q?9bZJUrKAVFtrG0FT4GwLiWWFhb/gBRP7xnUuzrC5kKRS1DfN5fa2IwBEBq5l?=
 =?us-ascii?Q?sMlPby4Mm0FVJrUkJJCEWa4g1MguwNGW50BgL2zASv7FK8h359EweiEdqIVX?=
 =?us-ascii?Q?BRV8vMAV1UQk67ELVS18xeQKpC8yM/UgLGJCV+hyblBpMeb+C4YxFOm9FzOx?=
 =?us-ascii?Q?heRCWu9AQ/7c2sh7pTFBF2Wen9Axq1BfjPVZL0hIzq38nCYnEdC3Azpq5kJw?=
 =?us-ascii?Q?yhxOybEUkVYe9ql3vZf7j7Cb2FPlVeDZOLTZJpmNSCTlGeVrwN0FjO+i7XJn?=
 =?us-ascii?Q?jwvCp5GBySaS2hiusjCYzR7j5AsdFTVH76OJ1XYIgqPEApScOQQlif1BjfWB?=
 =?us-ascii?Q?tCUDjVu0c8Js/fArD0pM9OExAbWC7hpGAF09bWNhO3z5xcCVoRCqS2gOZ9Z5?=
 =?us-ascii?Q?bcwYDugvJFJ7XUCQr213Lkav7BqRIgnP3muSI+bKIORENN++WiVy82d8s++X?=
 =?us-ascii?Q?du5Iu6GnBk3dsVRON5D3C64K0M8MurjVqiwJ774SbdojmAgyCOR+RS1h5mVT?=
 =?us-ascii?Q?VjUvw0ZkzJYiv2NBvQjshl+HejJXHNyN88TjxrcfVf6VpCs+fQrOB40egItV?=
 =?us-ascii?Q?QRrmgZADESq4okmTKXRwQnhRKveEHgTyGGnlz+v/0UmwuVEDvdB+FqtS6YkH?=
 =?us-ascii?Q?Y57qTIMg9bQ1qj10oQPrOPJ5zVnEEzc13EkpLlw7+ZrIXSYaKxLL57oqPtWm?=
 =?us-ascii?Q?+nLMqjaXY48fYTw47o8YBdBW5f47qMe8nq+J/2rUB6YOw5xbPbdiO6grgSL6?=
 =?us-ascii?Q?GuCTqeoAcIqAhR2Ebz3zxGDPLw9LKFepqtKYlBvYBkvuhVLQpxeo3ns74QdP?=
 =?us-ascii?Q?IB732CAKrChzeQBCc0+KCa2SeBA7Sn5W+xEEb89+ej494ZmCCoEvoa+GAN70?=
 =?us-ascii?Q?bIQDwkAVuWVdO4V4uUi5Y/QYBChemBB1EUVp62TLyuR9RhcukfofYEscVNNl?=
 =?us-ascii?Q?Fd7QKGeVow93rLeT1TM+g85xDj1j/cC6otOzb5A+RfyZ7EUtwOv/eqiytvrR?=
 =?us-ascii?Q?zgie4JqzV8cqZlXrz61WF971SI8PA6w5nxCOIG+APpODAXuaAGEH6IH+SIDv?=
 =?us-ascii?Q?fF638Eli+F7wqc35amv2xUxewsZTRGuaknRIy92A3+9/rNQmepFp8dZ2wtDx?=
 =?us-ascii?Q?V8AkBS92761w6TbYdL3tt1lpP2AN/LZh7td3bVUhDw47L8Zy4JfOcYOJNHhE?=
 =?us-ascii?Q?Zwj9i9/Lce1OChnHfA+vFFXHwUrEWkl9R9zL2X/JcM+BkRn3hpqtg9D9Gc6f?=
 =?us-ascii?Q?SCOjwmDxLKZqQ+X73adypft8L9KQ+Fp7B2lLjm4uqu/2EE+H/uFp3ckTal6l?=
 =?us-ascii?Q?xzAp43ccIxlZ6mfqFn0sqvZkR/2pSJlnPsY6aAX6fxwjYr//+7Qq7mwVjd21?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d03ec594-e6fb-481a-0f03-08db75cc5346
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 22:34:23.5626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbznMhNSTwCvPZVUDZ/fYVlMREMInvNSGR9VxBKXEMWtW8CyYUYlMcfWutpOMO5buKzLbrd+L4VN6KscvOJzJUxpSKa7RtRcOnu4hkv1or0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4757
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> Implement support for CXL 3.0 8.2.9.8.5.1 Sanitize. This is done by
> adding a security/sanitize' memdev sysfs file to trigger the operation
> and extend the status file to make it poll(2)-capable for completion.
> Unlike all other background commands, this is the only operation that
> is special and monopolizes the device for long periods of time.
> 
> In addition to the traditional pmem security requirements, all regions
> must also be offline in order to perform the operation. This permits
> avoiding explicit global CPU cache management, relying instead on
> attach_target() setting CXL_REGION_F_INCOHERENT upon reconnect.

CXL_REGION_F_INCOHERENT is going away, but the sentiment still holds. I
will update this to:

"This permits avoiding explicit global CPU cache management, relying
instead on the implict cache management when a region transitions
between CXL_CONFIG_ACTIVE and CXL_CONFIG_COMMIT."

> 
> The expectation is that userspace can use it such as:
> 
>     cxl disable-memdev memX
>     echo 1 > /sys/bus/cxl/devices/memX/security/sanitize

I assume this will become 'cxl sanitize-memdev' and handle all the busy
reporting etc for the user?

>     cxl wait-sanitize memX
>     cxl enable-memdev memX
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 21 +++++++-
>  drivers/cxl/core/mbox.c                 | 55 ++++++++++++++++++++
>  drivers/cxl/core/memdev.c               | 67 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  4 ++
>  drivers/cxl/pci.c                       |  6 +++
>  5 files changed, 151 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 721a44d8a482..5753cba98692 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -64,8 +64,25 @@ KernelVersion:	v6.5
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RO) Reading this file will display the CXL security state for
> -		that device. Such states can be: 'disabled', or those available
> -		only for persistent memory: 'locked', 'unlocked' or 'frozen'.
> +		that device. Such states can be: 'disabled', 'sanitize', when
> +		a sanitation is currently underway; or those available only
> +		for persistent memory: 'locked', 'unlocked' or 'frozen'. This
> +		sysfs entry is select/poll capable from userspace to notify
> +		upon completion of a sanitize operation.
> +
> +
> +What:           /sys/bus/cxl/devices/memX/security/sanitize
> +Date:           June, 2023
> +KernelVersion:  v6.5
> +Contact:        linux-cxl@vger.kernel.org
> +Description:
> +		(WO) Write a boolean 'true' string value to this attribute to
> +		sanitize the device to securely re-purpose or decommission it.
> +		This is done by ensuring that all user data and meta-data,
> +		whether it resides in persistent capacity, volatile capacity,
> +		or the LSA, is made permanently unavailable by whatever means
> +		is appropriate for the media type. This functionality requires
> +		the device to be not be actively decoding any HPA ranges.

I notice this attribute is unconditionally available. It would be nice
to hide it on devices that do not support the optional sanitize command.

This is a minor fixup that just needs to be in place before v6.5-final.
