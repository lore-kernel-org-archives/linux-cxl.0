Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27300EB64DC
	for <linux-cxl@archiver.kernel.org>; Sun, 25 Jun 2023 22:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjFYWow (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 25 Jun 2023 18:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYWou (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 25 Jun 2023 18:44:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80304193
        for <linux-cxl@vger.kernel.org>; Sun, 25 Jun 2023 15:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687733089; x=1719269089;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nFfAU1YqQ8ZZ0Wl8pZjJXEsrFa4ARCfkTBG9Gnqe1nM=;
  b=XP4M4Ca0xdz2rBCAww8VXbbWVrRvMFYtq/WgVYnqqa0lyXkgAlOsQ0Lv
   rGWkUjwMJhtR7opwT6ALP+eTf2doDHeZVX+PGMWl6VsHSrUWVmYSCHTOe
   iXCMeRqnmX0KnBXfsT2gsSPOrZeLtFX1LQQiqDRSY9tfzqTQ65VLvX6cp
   zx6RZv69n8cyewdj/Rc47tek+H4YOG9Gyh/VcWq2HZ7doQTNeqiCYuANd
   DP2HJpoKRteu+Gc/GX9arV5bgrUKYbvbkdURB5gw54CxM+hASGn50XC5H
   AT7Ol08jNwp7sXq6G9J5jQELsq1om5CYAVdo7xJimB1by145YvE6Q+UdI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="427117865"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="427117865"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 15:44:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="745579036"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="745579036"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 25 Jun 2023 15:44:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 25 Jun 2023 15:44:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 15:44:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 25 Jun 2023 15:44:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 15:44:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6iJliz6J1Hxh2PQCutRQIZVFmkJCuehUQh5d+Pyz8P9tlghXEkTHyKyit1ubFGK+H+PtZUhJevoc0eMTvbN3r4QMXzeS0BHrxPgMFKSS0esfLwOt/cIiV2V+UKiBhLhPn6DtX448ohAMSG4g6GdBF2BVJI8lErWIUlbYHvw4xZwMptWxDXxuTAujXQIjlLQCvII+sm7JmZYBDkg2wLRPP+PZ9yi05QlVdJJgp+IuNT1oya7E7xes1tNH22G0d1NsgusNKQTcpZrdAAPpsbrb11vZ3xeqb8d8AJcGK/9z0qv6jBp99eD5r1WygUXNibDM8HdMal9r6EmnXszQH1COg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnReErc8j/8SWGTJVQdQjAxEUZYQWDNCUwYt7pUW508=;
 b=QUNSwNFud+Nqft3oCYp79gRcXqVfPSCI6LnBynv6k4iR7Qp3gFMZXWgaKqVFKGgiPJGE2MQPgyAS3TEALDGFG82fYOFL+KxXwIt+7rLFBnZcuDCfDUYR6XOwfbMbILLK0u4MkFuOySmGcxDEMmvlS45xmerskuVc8AxATF8vcohHphSy/3RICaz7KY225QCt7U3nkGLu24ykfqdRwwZLe8CNsnkZ85+2n+T4VYEnYPJ+wEct+G2wU0pWRAFJbeZJ8f1CYbnRmkkqYTR2H8TP1zqqu6v/sU3gRcEfUuFwcCPkJJlJZQH0JvDML0LfbZNE3TjRTPgvzhHfh0VCxN2OBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6093.namprd11.prod.outlook.com (2603:10b6:8:b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 22:44:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Sun, 25 Jun 2023
 22:44:45 +0000
Date:   Sun, 25 Jun 2023 15:44:42 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <dave.jiang@intel.com>, <vishal.l.verma@intel.com>,
        <Jonathan.Cameron@huawei.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <dave@stgolabs.net>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v6 0/7] cxl: Support device sanitation
Message-ID: <6498c35a934ab_8e178294b9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230612181038.14421-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230612181038.14421-1-dave@stgolabs.net>
X-ClientProxiedBy: MW3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:303:2b::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4c7f94-3848-4010-95a4-08db75cdc5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1YRhOT+wRoE1zMk8wXDNg8WtzP2Yac/C0lqLFBWz1hqYUkVnMK08uvwchq6QCwXH4MYpoVEYcwPtnOM/J9IjcZqIPN8hUTy3PBmjBmV187YWuqVNMKWGAj1s29QRvIvpIsC+WQZJHrOntarojg3NhBzdQT1s7h6dPWdjYc73gDjs1j5afy24sB5C0bD9nS6cZsd5DhCA3zvOWSaIN4uUK2bzbjZink9EHco99W2LK3ZyGc0exHMp0/UGHEQNccm2GF0zNTMNxCORguAborlCR25e2hsorbyHqfO8q/HVRyn6kk0Uaxe3Yq7zeLZmz/Ur5TMJ5F2GSUKMsuO3UDlAP7hLzBFg67JogDOHaOolZ/MzV4n0ic9W2LXRrZSo2GS3caU6DZqa6mpcC71k89qRHPTYRzS/WvZcLcmFDxHd/elLFXGu1EL7fVlMlQaLNdehM9CCsiJvPFZIFw8j0DcuAEMiSmBLQc02Y+QqkqNVIua8ouka7LOv5VqPVONqE4kLl5Hj3w8wAwXQ10/uJ7lIBV8q7yVT+/dynHJwRtQ4ms9BBMmQUqAbW9TEQwZey0cPTw7WqNW42shYlcv0riDrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(66946007)(66556008)(66476007)(316002)(4326008)(478600001)(8936002)(8676002)(5660300002)(6512007)(2906002)(966005)(86362001)(41300700001)(6486002)(9686003)(186003)(6506007)(26005)(6666004)(82960400001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tPanSaFxr6iFRhlNGjpBCOcKD6UPdUMphE/GqYiebR1im1rEBded7QAetEtE?=
 =?us-ascii?Q?UeQwrNzPkQ0iuC8x9B72d7fgT90GY59NS+Iz0DN5XSsrCRQQ1FPWyFew0iyv?=
 =?us-ascii?Q?tkUlZ1UISPqg1eGoEQtfA+YH4JCPoLrjLoGEY5TVqGAWmZqXM8xGmEK/r/5g?=
 =?us-ascii?Q?HxRMyz2MGLnb4hbkJaj18pxyPBu838kX4glIWP5FmJr4jl4X8p0RuEIgjpit?=
 =?us-ascii?Q?vdbLXxf7wVZZ0cnoK7Ibzcr+NmsviPLZnSzqEDh+yBlmBTqMruNi3VijL3/t?=
 =?us-ascii?Q?Un9NSlfSBbUE/X/23hdq9P+lDoSD/WSyAML+87hMrnyhoErdE/zrbR/A74qQ?=
 =?us-ascii?Q?x602D3MeivKc6LMVHCSj/4eRmRCNdpO+LlPLIJR2VhiMLnGKd25knhvp+IxT?=
 =?us-ascii?Q?AOqwk2Vq3yflPAZI6xK7DlMd/Hx867V0kJuG6yeZfzKWBavI5b5FbNZ12ZBS?=
 =?us-ascii?Q?oNMxmXhzuuZcw2u3qri5r2nzgsSZqZkwaX8mHX9bao77a50UcbnQuNa0OyAZ?=
 =?us-ascii?Q?xZoMYaH5G1McXz6ncZBkLrG4TNs4ytbPjcPAWRvkC2fjQglCJzUMzKxKE7ca?=
 =?us-ascii?Q?GK/X3oWN+nSH7yCNdNO3lRg7CptPgNSkeqhfneqeksuPogvpuXg3nb6y+Rak?=
 =?us-ascii?Q?k3qbmUV3Anv+/aijEzZGDS7iwfyhhTCAejfdSBwlT2XmppA7jctFsjA30ayM?=
 =?us-ascii?Q?BWO5otDMgGoTHrZ+zXwya6jBcQSudiLM6wDHqi+PqNHNUaXvJt1YPDhmKsW2?=
 =?us-ascii?Q?/1Yk37n0FpqEHtpwSStVXNOytA0D4gYzXvESzHEZZET4YyA+BFgPGTSXkeg9?=
 =?us-ascii?Q?z36idW3ffaIuimLBl4dww7B2qjuRiv0FKM4hxIS3FFDLeAGaUcbGNL4bIlZ3?=
 =?us-ascii?Q?y7DMgQol7/99nU8rT7KcHadkrZThFu0AamI8Q5c+u8ROsEVZ/fQn8SGOII/p?=
 =?us-ascii?Q?aCxIR+JlNMux7jlI7wazfFkjnW14On4F3h2BIKI+qPoTHKYpxvHv7nd/oDg6?=
 =?us-ascii?Q?UlwG9IF22Loim64dnJn39H70u5Zpbpu3zvDdyJ/VngjnceRWSpR2m9Dk+tws?=
 =?us-ascii?Q?RBxwjsldsx+AzbKrErzLz/Ipoo88NgcciCf2ZVzsuIvVNqojFyjU1W70CUF3?=
 =?us-ascii?Q?gkCrRuXRTllymVI97UEy6z56acliRLB4W2FTSvIyhmNZMEZpHWMGYpOtilnL?=
 =?us-ascii?Q?r0TGZxpebgUYytuqfXiU6acQ6JgSoqcXlSbURu17BzuDdoG4LbgtgYACqrfa?=
 =?us-ascii?Q?m08bmITPACGNPnqpRo4+im9MEcvH9sm75JUZ1nsQf40ZOfYNfaGG2oaD3tM2?=
 =?us-ascii?Q?Bh8Z70/xsxlSRR0eqPTwM1YTu3uDKSEpvhsnSIi1ERZpYgoDKgYRDCKoIBbL?=
 =?us-ascii?Q?PDPcTcyJzlmiMJ6/SichiGMzrg3o/L1bfZJfHkWiiZlV3u2FoXiPFoKLjHK7?=
 =?us-ascii?Q?r6dO2fTPka7L4vXEwu1GdozuIvTFi78cdDnPbQ/5P02f+hP87pAp1fG7xJHa?=
 =?us-ascii?Q?oI8QdBPnGVwpKYtdF4VVeQiYj4U6zniagasH/GkJwKo5ewFuwJ+nS56vUNt7?=
 =?us-ascii?Q?YxCsgRYXaSiZwxFcF9atvC9aeSZbp8XaBzO97Tbri284wL2tDzP8goptCvds?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4c7f94-3848-4010-95a4-08db75cdc5e1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 22:44:45.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4/JazjkAMUi2r8etjJjabp9s8MomxEwogGkV13S+wSAXE4dgkrP8QAonD9dPMqBIzDbufj8728o8J4irZ96A5aFNOPNaoYS3sTEQYBeQvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6093
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> Hi,
> 
> Changes from v5 (https://lore.kernel.org/linux-cxl/20230526033344.17167-1-dave@stgolabs.net/):
>     o Added patch 1 which fixes bogus irq handled scenarios when it's not our interrupt.
>       This should be picked up regardless of the rest of the series  (Jonathan)
>     o Added security.poll boolean instead of using the timeout member (Dave, Jonathan).
>     o Do not explicitly init security.state (Dave).
>     o Misc cleanups (Jonathan).
>     o Updated changelog in patch 4.
>     o Picked up tags.
> 
> This adds the sanitation part of the background command handling. Some noteworthy items:
> 
>     o Treating Sanitation as such a special beast can make the code a bit invasive,
>       but couldn't find a decent alternative. For example I realize that this is really
>       ad-hoc code in __cxl_pci_mbox_send_cmd(). A lot of this also comes from the fact
>       that polling for sanitize is supported, so sw still needs to keep up and serialize.
>       
>     o Nothing depends explicitly on CPU cacheline management
> 
>     o All sysfs files/attributes in the security directory are visible.
> 
>     o Continue to use __ATTR() macros for sysfs attributes instead of the requested
>       DEVICE_ATTR_*() ones because of the naming the security directory, otherwise
>       names don't match.
> 
> Patch 1 fixes mbox isr.
> Patch 2: adds a new security/state file.
> Patch 3 paves the required sanitation handling code before actually using it.
> Patch 4,5 wires up sanitation + unit test.
> Patch 6,7 wires up secure erase + unit test.
> 
> Testing.
> ========
> 
> o There are the mock device tests for Sanitize and Secure Erase.
> 
> o The latest (v2) qemu bg/sanitize support series is posted here:
> 	https://lore.kernel.org/linux-cxl/20230418172337.19207-1-dave@stgolabs.net/
> 
> (1) Window where driver is out of sync with hw (Sanitation async polling).
> 
> [root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
> [  159.297482] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:37:00.0: Sending command: 0x4400
> [  159.298648] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:37:00.0: Doorbell wait took 0ms
> [  159.299908] cxl_pci:__cxl_pci_mbox_send_cmd:295: cxl_pci 0000:37:00.0: Sanitation operation started
> >>>> qemu informs sanitation is done <<<<<
> [root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
> [  165.897345] cxl_pci 0000:37:00.0: Failed to sanitize device : -16
> [  171.692050] cxl_pci:cxl_mbox_sanitize_work:147: cxl_pci 0000:37:00.0: Sanitation operation ended
> [root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
> [  173.373337] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:37:00.0: Sending command: 0x4400
> [  173.374498] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:37:00.0: Doorbell wait took 0ms
> [  173.375727] cxl_pci:__cxl_pci_mbox_send_cmd:295: cxl_pci 0000:37:00.0: Sanitation operation started
> 
> (2) Perform sanitation of more than one memdev at a time (Sanitation async polling).
> 
> [root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem1/security/sanitize
> [  351.287129] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:36:00.0: Sending command: 0x4400
> [  351.288403] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:36:00.0: Doorbell wait took 0ms
> [  351.289706] cxl_pci:__cxl_pci_mbox_send_cmd:295: cxl_pci 0000:36:00.0: Sanitation operation started
> [root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
> [  353.058614] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:37:00.0: Sending command: 0x4400
> [  353.059854] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:37:00.0: Doorbell wait took 0ms
> [  353.061126] cxl_pci:__cxl_pci_mbox_send_cmd:295: cxl_pci 0000:37:00.0: Sanitation operation started
> >>>>  qemu informs sanitation is done <<<<<
> >>>>  qemu informs sanitation is done <<<<<
> [  363.692138] cxl_pci:cxl_mbox_sanitize_work:147: cxl_pci 0000:36:00.0: Sanitation operation ended
> [  365.227416] cxl_pci:cxl_mbox_sanitize_work:147: cxl_pci 0000:37:00.0: Sanitation operation ended
> 
> (3) Perform sanitation of more than one memdev at a time (Sanitation async irq).
> 
> [root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem1/security/sanitize
> [  193.729821] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:c1:00.0: Sending command: 0x4400
> [  193.731071] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:c1:00.0: Doorbell wait took 0ms
> [  193.732360] cxl_pci:__cxl_pci_mbox_send_cmd:295: cxl_pci 0000:c1:00.0: Sanitation operation started
> [root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
> [  197.001466] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:36:00.0: Sending command: 0x4400
> [  197.002694] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:36:00.0: Doorbell wait took 0ms
> [  197.003956] cxl_pci:__cxl_pci_mbox_send_cmd:295: cxl_pci 0000:36:00.0: Sanitation operation started
> >>>> qemu says sanitation is done <<<<
> [  197.731473] cxl_pci:cxl_pci_mbox_irq:119: cxl_pci 0000:c1:00.0: Sanitation operation ended
> >>>> qemu says sanitation is done <<<<
> [  201.003258] cxl_pci:cxl_pci_mbox_irq:119: cxl_pci 0000:36:00.0: Sanitation operation ended
> 
> (4) Forbid new sanitation while one is in progress (Sanitation async irq).
>  
> [root@fedora ~]# cat /sys/bus/cxl/devices/mem0/security/state
> disabled
> [root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
> [   39.284258] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:36:00.0: Sending command: 0x4400
> [   39.285459] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:36:00.0: Doorbell wait took 0ms
> [   39.286723] cxl_pci:__cxl_pci_mbox_send_cmd:295: cxl_pci 0000:36:00.0: Sanitation operation started
> [root@fedora ~]# cat /sys/bus/cxl/devices/mem0/security/state
> sanitize
> [root@fedora ~]# echo 1 > /sys/bus/cxl/devices/mem0/security/sanitize
> [   42.697129] cxl_pci:__cxl_pci_mbox_send_cmd:243: cxl_pci 0000:36:00.0: Sending command: 0x4400
> [   42.698323] cxl_pci:cxl_pci_mbox_wait_for_doorbell:73: cxl_pci 0000:36:00.0: Doorbell wait took 0ms
> [   42.699525] cxl_pci:__cxl_pci_mbox_send_cmd:335: cxl_pci 0000:36:00.0: Mailbox operation had an error: ongoing background operation
> [   42.701119] cxl_pci 0000:36:00.0: Failed to sanitize device : -6
> >>>> qemu says sanitation is done <<<<
> [   43.285334] cxl_pci:cxl_pci_mbox_irq:119: cxl_pci 0000:36:00.0: Sanitation operation ended
> 
> 
> Applies against 'for-6.5/cxl-background' from cxl.git.
> 
> Please consider for v6.5.

This looks good to me after s/([sS])anitation/\1anitization/ throughout
and some othe minor fixups that I mentioned.

Merged for v6.5.
