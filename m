Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF02DEB64D0
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 18:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjFMSME (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 14:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFMSMD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 14:12:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7486518C
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686679918; x=1718215918;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eGRdQcfYxlc6x0cl/cqHAlAYaENmQgAIcGEyxTx16WA=;
  b=Un/1DyBz4b5GSrRLbFv9Z3AyGWQabq8oUD58F5Nqj79Wq1xZIgO7JmiX
   eu04kgih5tr4PPn19u+SkeZmK3e04X2QYJerMz29ugGtNv/3/w1IlMFuc
   +Dh+s+j7fRbvrAiJDbLEARe2NSpMlkbZvLpWk/UWost8yn+GHzv+yInwg
   zQ91M3l4i0HhF4oupDn93UB8dky68dzfo2Nii5H+S0VMsun1dJzrWdQXk
   u35BJiB6H+Z4nEc53LCfHobX/Ygj5lIVDF+JTUHejrkP4MYvq7MTD1k58
   +AxMetG0d0vUpCQeuJIZaoolL4ad327jAMXZVaWKduy1ASSxiUIQlYTwc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="355915647"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="355915647"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 11:11:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="744779498"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="744779498"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 13 Jun 2023 11:11:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 11:11:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 11:11:56 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 11:11:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCiGpB8q/+iBwaabga0Z3iUfDIirKghvXW8u+ppQRmZW697cgNF6hfatJOiq0z2vAvEJo/YKZNyH/FdApY6Q8o9UrVzgaSYE+irYo3ZJxhVqW1Tp1rAM5ZOcq+zhULKVi1jvJ3K/+D2n8YQ7vfgPcYdIvxObI4dxQ5924+jOFcnosIisGo4XcXjN1GmzXV3BiBe70RvEuod+/cxYzWZtMC94NH8OL6jG0YOTreYZyGMSvJujEUqgj5CKAHfwT7C8q+nXhIvfkWfzGJ39uLcDr7IDOJi8B4fPZWFO93Yr0cprOB5wNi5ZcwXSfWKOLsifEdMHoXiHDdK9Tlngz2JDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0x7gG7gfd5Y6LX7zx+oesaVlRz9lSqI+VvojFWpQz2Q=;
 b=U1vJhZIIAcRPMPo/SIDl2N+4kpuSb3kOmoMbpFVv3bYaJvYusly/HtS5TXv/PkboIC0MjVDidkSvLmt9Ypi/8jfSYoKJXc+EkOP+Ek96/gibwmFT2IHePG7M4Babo3kJlH1MbOiWB3Y2HDOt0Lt/uF2dek2/B/aFkYOOB8u5j0ufu0svshvnbTqj0NHe7lOtVecbfSs+Rs/7bhHP2AAgLsi4xT1GS1vyHxfRQhc48VASo1MiHZTEHcJG6TdbmBU1UUp5fJ+5I1dZdMEpDvJ8SFJPqFGHWHHvU2snRYF4MpNqEK4h54z4DC0iXpH7nZdo8+iV9zVzhkzElleshoZjeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY5PR11MB6209.namprd11.prod.outlook.com (2603:10b6:930:27::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Tue, 13 Jun
 2023 18:11:52 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 18:11:52 +0000
Message-ID: <38974938-cec6-317a-9c8a-b80f183d5c90@intel.com>
Date:   Tue, 13 Jun 2023 11:11:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 1/7] cxl/mbox: Allow for IRQ_NONE case in the isr
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <Jonathan.Cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
References: <20230612181038.14421-1-dave@stgolabs.net>
 <20230612181038.14421-2-dave@stgolabs.net>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230612181038.14421-2-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:a03:333::15) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY5PR11MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 62513136-5f93-4ee4-bc2a-08db6c39a979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2K67u3mYXn+hWfTp01/HJ7UjBgNskFBSD2MrDVcbC6SgTOFIgaAnlYkAnQr+821gmwWWw4kYeNAMVdCTYiu01gm8Ho1jo1Kf7OuWWyfBLjF7McYikFot+R+HpK/AUeX1QQaOOyCye75q4KC/fd1kXRQ0ww5ZeqoE0p1u12N+l8O0Qky8PNDR/aI0P/+fmSE+gP5VLWXg8FbRS8hIL9ZyYbxrkHQw0laovAXDopu47LAlzm5nx16PITfBWj2WJr8uEIMUkPnmwq5rF9L+yHDKgA+d4QUOiHy4jKySfBAbsqR+24UUD15Yn6cNtgmIDbtTO0Z5ePIsfuGmOEXeJZGhlQZg3FUSHeH/Yklg5+Io2Ump543hPjihupKRVWt+CjnHJh2ScmScfHubJovKkInJ1OYPeuTOhAgO4dWMIY3rCnQRk0aQcPiG4LQoVAqgWKUYHDRW2WpRGYOQdgnpafLjLD0xdlFTic6GDyCdNRp7smMqFX+CkfCYi8fn7fB6tTLg0ZuuWIsVpagWNKEBfqsd/O0ZDywnysy7kh4F+weKtgSSCBxJeS9kFBTQ/K91dJTs3xd3QusUrilDTyYUuXYHdOPu3c7IgeGZE3M1cPg/e9QlzVMrs66v3lO6scOQlwAXcpk7Pt1PJZJFPPV5oGr/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(83380400001)(44832011)(478600001)(82960400001)(8936002)(8676002)(316002)(86362001)(41300700001)(4326008)(5660300002)(38100700002)(66946007)(66556008)(31696002)(6636002)(66476007)(36756003)(6666004)(6486002)(2906002)(186003)(6506007)(2616005)(26005)(31686004)(53546011)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2J5aE44VzJMVHFuelRwZkkvTXB5QkhTMzFTa2VyREdPbVBlWmhuUmxSMTYv?=
 =?utf-8?B?V0QyZFhicVNGZzRqMUpNRTg5R0dsRXhITFJXV2Nlc2NEWmZhV25HZ2pIcWJr?=
 =?utf-8?B?K1A4TW1ONS9uREo4S2hMdUdHRk5LN21RcXVKckwvcC8zaVh1VWFpRmx1Vzl2?=
 =?utf-8?B?TVY4UHlUdU1LMWRpYzhreVZlaHgvVmJEMUFGV2I2RVUvRmdqRnRSc0k2VlBl?=
 =?utf-8?B?SGdMbEtGbDdZd05sbHNXc1NZWi9tZWtEMEpqYjA0YytDYkgxbE5qYWh1TEZa?=
 =?utf-8?B?bVNiSnpLeElTWWhuRVdzYm1jUm1TSlJ3WEMrZU00cGhrUFU1NkpTbzB0ZWFL?=
 =?utf-8?B?UHRhVlM0SnNCQm4vSG1UalVEMHVaOTR0Z2k4amRpNlg5R1I1WFl2NHlFa20v?=
 =?utf-8?B?RlZTWkRwakVjUThrcDJVRlFQQXY3WFJpRllRbytOYjczNWgyYUIweFdpWnAr?=
 =?utf-8?B?OGVmT3dldTU5QUpSUnE0SGo4RERhdnEwWnNYUFRMSXVGZ0VaMjlGM0VDRXhU?=
 =?utf-8?B?cFRySGdiMnI1TFhlZ2NjMnBBcnF0WE9YVG9aK3RZSTBscVBONThyQisvcG91?=
 =?utf-8?B?WUJra05iZVM5TzJjK0JaeTVnc25nbk9Gak16d2NHSDA2b1RTSDBFTVJDUWFm?=
 =?utf-8?B?Q1lJL2EwaWIrQlJGUVNRelVnTFBnOUZOcFEwa0FmVk9IMmFrQXQ2MUxoSFlC?=
 =?utf-8?B?NTFRU2tHYkFla3ZEY2xVNmN0bUtDdHQ0ZktwNWVIeWZtYUxRVWRrdDlmVHNl?=
 =?utf-8?B?Ri9WS3ZTUTRxWGpSZ1ljZ0dSMTVoVllMV3RPcU5Pa25MdkRYOVV4Q2d5YkNi?=
 =?utf-8?B?QjI2QlpZaEVGWmdURUQ4ZVllMGNsV254ZzkvVmx1Q1h6MC9LL3BzRXBPcXI0?=
 =?utf-8?B?THo3SEFEVzF6a2Yvb2hHN1RXQU5yWWZlY1ZiTUFEVXBrTWR4VDEvWW56Njlm?=
 =?utf-8?B?ckpEVDFhcUNFK2lqdTczUGl4SFd1NXkwQStMWGR6d040S0xsVm9ONXBMaVUw?=
 =?utf-8?B?cmFod2txRnR1M0hmaUkwTkJxWmtIR0tPLzZCYk5idjF4bHZWWkRyQXNLUDFP?=
 =?utf-8?B?SFhMaHlDaVgwUGdNOUtqWlN4YVNUN3NFb25wcGpKN2RJcUEwc3Zibk1STG9R?=
 =?utf-8?B?eHBZSW9RTVVsWWd5ajlhQU5PMVd5Y1lselhkUytUNTJLNzUwcGxERVBrTlVN?=
 =?utf-8?B?aUo2cHlocFNMRXpUZWU3TXlnb0xtaEN2NUFZcDNFYXJzUXFDZ0pxY3p6LzRZ?=
 =?utf-8?B?VEZXNTVmT2dOREJ1YjBRbU9idklkSFcxbTJuVTUvYXVIclFoN0FPbDAwdEc3?=
 =?utf-8?B?V3B5ZnBNYVBzZkVXcEljdmJtenNzeTd2NGJwUHZPeWJKbVlUd3VuK2g2VHA2?=
 =?utf-8?B?Q2RXSW9vaUFzK3J2OEdFWDBlRmgwSHdndmlrZEtSSjhZVmhIL2dTa0dtQlB4?=
 =?utf-8?B?WEZEQjByKzdhMDBCcStkK2FYZ3dNL3B1WmIxalhoRW0ySXBvMld4MHdsaWM1?=
 =?utf-8?B?L21rcHdIVnRPZitXcmNUL2J3Nk9rbEhvejFCV2FQaFI4OHJLQ3gvNncwZzNn?=
 =?utf-8?B?b21lMkw1MCtvZDYrRXY1dDNsTFZyYmZWZnEzRFE2MVhMczYyQWdRU3h3bHpo?=
 =?utf-8?B?dzBxc3hGZFpLNmwvdTdmT2c0ZDBndWsvT3owSWEwWStHNS9DQzdkdE43SDdy?=
 =?utf-8?B?NlA1Ym9vbXFHdk1hb3VFNlRZYzZDNlIwWkowdHpONTJPdS9ra2JkL2VwcUJR?=
 =?utf-8?B?NDVjZVFnSmtuN0Y0M3JaZ3Q5eVNCQzgzd3QrQVpnNWdpVkVsQTlIVW13NEdG?=
 =?utf-8?B?K0RMdVkvNHZCenU3UkpKV1dYL1NaVllZMXZEMmtqQ1hhTnp1aVg1eGlDUHBI?=
 =?utf-8?B?MmlwMVJvcituNEU2dGJLcFJWRlJQWVJPNnpKOTQzeThWanFZdUZYbzhUQU9a?=
 =?utf-8?B?T2VNZEtjOGhCcW9Qb3F0S3JsVkZwMTVSWFd3ZHZJVmRreENUdFI0RE9DcTdW?=
 =?utf-8?B?bnd0WUNkSUM1eDQ1TEJ2QzhJQitTRnVWTSt5bk5FaElQZFhOeEhHQjRNZkhy?=
 =?utf-8?B?bHo3Qk5xYVdHbjBremdPaEVFWW5tYlJRR0lNblRweG9BT2xURlR1byt3KzRm?=
 =?utf-8?Q?OFpBlmF8Y8gjdcGfTcC3JIvmC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62513136-5f93-4ee4-bc2a-08db6c39a979
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 18:11:51.8830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2iBJEK8hf6geb7k/wd4mNd7EvzkUTvv3TjL9kLTJbKhsxkoYViOjxHRcLIoEqhL56azYxjdOqxla2MPQ986Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6209
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 6/12/23 11:10, Davidlohr Bueso wrote:
> For cases when the mailbox background operation is not complete,
> do not "handle" the interrupt, as it was not from this device.
> And furthermore there are no racy scenarios such as the hw being
> out of sync with the driver and starting a new background op
> behind its back.
>
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Fixes: ccadf1310fb (cxl/mbox: Add background cmd handling machinery)
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>


Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/cxl/pci.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index a78e40e6d0e0..4b2575502f49 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -118,9 +118,11 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>   	struct cxl_dev_id *dev_id = id;
>   	struct cxl_dev_state *cxlds = dev_id->cxlds;
>   
> +	if (!cxl_mbox_background_complete(cxlds))
> +		return IRQ_NONE;
> +
>   	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> -	if (cxl_mbox_background_complete(cxlds))
> -		rcuwait_wake_up(&cxlds->mbox_wait);
> +	rcuwait_wake_up(&cxlds->mbox_wait);
>   
>   	return IRQ_HANDLED;
>   }
