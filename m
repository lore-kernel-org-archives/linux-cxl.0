Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6728C77B73
	for <linux-cxl@archiver.kernel.org>; Tue, 30 May 2023 23:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjE3Xa0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 May 2023 19:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbjE3XaV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 May 2023 19:30:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D9E192
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 16:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685489410; x=1717025410;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GghmWXNWjRQjpao27vixD6Xk1GPzIFLF8Qm2MrZanGY=;
  b=LGa0h0zee6jw/hy2EWwOC9gb5Gbk7clYj5kV58KwtnqPngpHyuPTHYXz
   xSwdst45vKmDMD8U75EL2hmNXdwDCc/NTgEPnCl5vZn8ugJGXQH8HQm8g
   1hekdP4SBvQHrk2wT8NgDe7vK7NnTXSacB7DbbNB/SzoGPkZ0NDWhxzQ+
   enLkbriUIOFwCBiwksSyYpE21AEKdXlMfyhHSIwESoCO2N7dqeqWK/+43
   eFLwdWkm81UMfbDGcoXYyoo5RXMmBCzp13GVx/pF9is8L6Be7whLDj1Cr
   79tKvY0BUY5NJJ7qe4AbZLGsV0ns4NeWYtHYGJelL9PYvclWEiZGw+lKt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="353918517"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="353918517"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 16:30:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="776537389"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="776537389"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 30 May 2023 16:30:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 16:30:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 16:30:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 16:30:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMj6CSibu1PNQVGP8POK2y1m0BAATSUweMkbbXFVGpcJC/JtjvNB6YB5nkTUZc/2jJOqo/gLTBlzaGiEP2/IvLRtR9JgxXqHSm7Rf6IvZL2TVHbaz5pNDH38o3jIZ4QTkZsdmjmJs1NJ8wS6zGjinJWBeKBV6HTSQhTiTjUpF3BEenjt1dnt24yuHAVE77JqdWA6MsSnXypgwqqWW2QlDPO9lFmVqglOCpbt8SV7zmXkGTg2jns+vtY8rBnAXiTm7XI0qCneCOz/CR+o9FuLLX3yY8XdnEycvpjf6Aqdi7LczhQni4Qr8f3I2e8A/LWrB0OKvsyuS9HQjEDAKogUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPSwS/bjl+alG+WDzVHv8cSm0aWPysV+Pe+KpUlOaWA=;
 b=YgR8GviN0T9u1fwMQNKWnjugZb9Pj0PV5L8J/U0KinA3a8GYnFkxaUZ37pj3NY0A30HAc1JPox49kR1fhS3RlNSNv0o1dR/Yw6o8n/0jEJjNLe2gV7dtK+jtfxBJZKDhys2cDMGJ8xNlEhGs3BFyjHKFaHB0L4JLxCUE3P9QDwSvPhwjDoP8e8A3FxDrD1a6bkF/iZqaw97YmXba4pMt6aCG3ZSEp2G5AAiccm7+0rR6cKXrBNiQqVV6aKYsYAUCutWuVCbM2bikyM5ZPW6IW7p25xY9x2sJol4Y2X6YDYkFzCwAnxDq9znzk+PsakP9Ln3Ue6Y0midUaq/Ut8pgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA2PR11MB5146.namprd11.prod.outlook.com (2603:10b6:806:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 23:30:04 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 23:30:04 +0000
Message-ID: <120e637b-c6d3-2f83-867e-42601cd16acc@intel.com>
Date:   Tue, 30 May 2023 16:30:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 1/6] cxl/mem: Introduce security state sysfs file
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <Jonathan.Cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
References: <20230526033344.17167-1-dave@stgolabs.net>
 <20230526033344.17167-2-dave@stgolabs.net>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230526033344.17167-2-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:180::30) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA2PR11MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: 09495542-d295-468f-bede-08db6165cb7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: af5m6uFYg+fNxHLQYvwFzWgSbZEI6Ubhd+BJNakCYA5ShrQwe/tLMuncgPgR01eJ47Lv4saDkqLUDzXLwhQlJSRrIydeSsJLgrS+B3LNxiD1dkKxDnG5TjZnFfV2tbdXs27v5sr4dhoenUTAioxMGWaGkiAebrAJ+3+R4Z3Fstb7Xw8wGS/amsDdtLmQSMs6EzAPV7OPEmNE4DIjFh2RqN80pJu74Mc3IdI9460ARq9g0zFDvyhibAtjqfk9LBkVG5Qstcfp6bx3KhGVLc7ORDILmPfPsatZ2X+f9XsKJ4jRseNHy2SkGu/SrrPnVCJHcI98az4U5kk2i0oaew6kK/BycaI7pQYkuc940fwhOUu5BXeWSXvJcjnhzbv3FiJoXDFIZQ3vqUttRmInHOEOsB/v/cjZxAJfSqu1GhERxeA4wOA02zD7bzP7XYPJKOe96qI/2gFjOjnAYMmpF6SzB8mCudpWdWMB8mVT1fYZpWm7IPYj56Xw6B+Tc+oPLRExKNoqtkl4bpBFG2jHVykjojg97XwZ5eutgTJjebVJ8zv/amyBBQh84yKusRfxBeHxe1l2eYrIY9BTK3EVMS8xWLQ2GfpdEM57wPNv8FSTOfU0r4qEchYCjzOecpALU4YLC9T7F5CbM1/LrzW7Ky+8Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(31686004)(66946007)(66476007)(66556008)(6636002)(316002)(4326008)(478600001)(36756003)(86362001)(31696002)(53546011)(26005)(6512007)(186003)(6506007)(41300700001)(8936002)(2906002)(8676002)(44832011)(15650500001)(5660300002)(83380400001)(6486002)(6666004)(38100700002)(82960400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWpHalVqRDFrem02Y1BoOTUwNStZaEdQbGw2R2h1eHZGd2QzN2VFL3VDWlVJ?=
 =?utf-8?B?MExhd2tSbzZ2TWREaFozL2FtcmY4SlMyazQrQ3htdURDcVIvNUdBc0pDS0dP?=
 =?utf-8?B?SlJVTjU3M1Ewc3ZSa2pmZ290ZEl3ZlVPeEROS2M4cUVPSDZFdkRqS3h5R3hj?=
 =?utf-8?B?SnpzSmo3RVkrVndoRzZTL2FuU2o5VTdUMSt4OHA1SEdXNW1BcXFqZ0Nhcnp2?=
 =?utf-8?B?c3hyU0dMZlNQOFJjTnQwZW5GZ3FaS0tHY1c4T2lZTkFEYlJEdkxyZmM5aHNK?=
 =?utf-8?B?MkZTdC9DdHhOZ3NNM3FkbHFac01zRktwK3ZENzFuVnQvb0ZCdlFaNU9YcG1s?=
 =?utf-8?B?YjhXMDNnMXRtME1FM05NSzR1UE1tOTZER3JMSEN0Mlk2YjUzeWtmYVQxYkZQ?=
 =?utf-8?B?bEFscy9hYjRnRHdTSWtRVy9xaUN6dUFyS1c4NFJHSk0vY2RVNHpPbXhQOC9J?=
 =?utf-8?B?Zy9UN1pBYmhuOHFENXN2QWF3Q1dKeklTc3k3UmJsOHJIUVNGdm1NSmFrdmhj?=
 =?utf-8?B?VjFHOGtuYXU3SkNBOU1nZWJ2azlCWVNjVnJSQVNPZE56WE13bXdrL3RpbDY0?=
 =?utf-8?B?KzNab3JnNktSWnUvNjVranBLb3ZCbEtKVFZnQ2N0KyszK2pZRFVaT0dINE5s?=
 =?utf-8?B?TGM3Rzd4b1U1b0t1dkFxV1pRcExkQm9rNmJTckVNUU5UWDVBOGV6cWcxb3lh?=
 =?utf-8?B?VitWS1pHRDNLL0dlb0xQYi81WERoMk1RQUFjNmtaU3BsOW9QY3QwR0ZqRjRj?=
 =?utf-8?B?T0hJdHlrWENSemhPbzlvM1VhQ01VK3FBK3dZajB2TUNTSjlKUFJGQkJZQnBp?=
 =?utf-8?B?MTcvZEVBU0htdFgrUkhXVkNKdzhpUUFhbEp0Wk8zYWZPaGM2ZmF1U2dHRnBi?=
 =?utf-8?B?cVFTU2FtOTBLSC85Kzc4NXZCQVU5S2MyazZtT1c1NE93eTZMWmI3WFNUKytu?=
 =?utf-8?B?THlQY3QzSXhSVTRKRkxuUDZtRXVzTU1DTDVQT3BrMFN4NmhuUnpJUTI2YURx?=
 =?utf-8?B?T2JQSmhUejU3L1lYSGVIYllPRWZYaW9MdzY4bElSWVd1cHgrVnQyLzlwMHUx?=
 =?utf-8?B?K1ZxTHBScHZpcE5OYk5rb3VHRlBnVWpqYjVGaU1ReTB5YW5BV1djZ2dlTHRs?=
 =?utf-8?B?dHgvekJGcWh6WVQ3VlZkRnNIMnBjMDhXRjhsWXIyaSsvZmpwMFRGTmdIUnJT?=
 =?utf-8?B?NFk4V1VsZWNaU1hkMEhrbnFhMGRhL1ppKytWdk0yRjBNT3VPdzVlc2lEU0o2?=
 =?utf-8?B?QUZwYjRRSkNuSkQyekRwOFhJc3hJQVZmbzZlMkk2WDZtaDVSK25UeTJwK0I2?=
 =?utf-8?B?Ung2SWk2aGw3OElia0pYcTZZU0FkTzdOT1dLVFRub0kzdEt4ZjlTd2ZFMlo5?=
 =?utf-8?B?d1Rsb0FuMGU0TkxubnNhdzNjWmdyZGhPK1RTeERrckJQcU9Qdk00ZlhXczhp?=
 =?utf-8?B?aGZMRXZtZ0ZQSERBYitHbVluMzEvcTEwdzBHY09UQTE3VmNQTEJmOGRLM25o?=
 =?utf-8?B?SVY2Rm5YVzFtR2FCSnpPTVZsTTh1RGV5OUhLUlY2d0dKSnVKMmlObkVLL2Ey?=
 =?utf-8?B?SktwR1JGRnFBNE5LNm8xZFRwMzFrZSttMjNXN240Znl6dVp2WjJmYzBYODB2?=
 =?utf-8?B?OXk1OTN5TXZqZ2FyMXI2VzRMVXJ2b1R2bjVGWVNrd2pONDMzNkQ0dkpDVVVD?=
 =?utf-8?B?Y3VMMklySXRzUzdLelpjcS9Kdmd4VmJjalppYlIxUFY1cmM5Y1R0QjNlaDBR?=
 =?utf-8?B?RkpyamRMQUplY3pGaHphNTB0VjJQSzFCRSsyWFE4emNUYmM2OUZHOEphejZk?=
 =?utf-8?B?UjVlY0dmTzRRc3pKTjZ1cTFKVTRUNTRkUjJuMFJIVWhZMTZNR1VySkhPaXcv?=
 =?utf-8?B?bUtIemhHVS9HbW83L2JSU01nU3VoMU50c2pJMWhkRVFJUE54T20zaXErZWpQ?=
 =?utf-8?B?aktJWXZHU0FTeEhoU09EbElWUmY0ZnFkVks4bm5vSlI3THNzWlhjMFZNd2Ju?=
 =?utf-8?B?ZVcvbzlHSTBzcTY1dEVkTTBIbGlqTEhVMDJwaDc3d3RSNXIwT1pZZ2U0NXMv?=
 =?utf-8?B?ZHJrM0MxVmN6UjRzQWFXRERWUDFiQVlCdVJBZ0hoWDB4YVYwVEo4VnY1czdV?=
 =?utf-8?Q?kbZXjC5vBp+Prds+7LF2fuuFw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09495542-d295-468f-bede-08db6165cb7a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 23:30:03.8650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hek47py/FyeNWGRDis4aITFi/4PbAVasqSrEOn8xgLloCubpjpo8OtYwLsv34enAcH04Qsz3LyXMxncpe0+RAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5146
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 5/25/23 20:33, Davidlohr Bueso wrote:
> Add a read-only sysfs file to display the security state
> of a device (currently only pmem):
>
>      /sys/bus/cxl/devices/memX/security/state
>
> This introduces a cxl_security_state structure that is
> to be the placeholder for common CXL security features.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>   Documentation/ABI/testing/sysfs-bus-cxl | 10 ++++++
>   drivers/cxl/core/memdev.c               | 46 +++++++++++++++++++++++++
>   drivers/cxl/cxlmem.h                    | 11 ++++++
>   drivers/cxl/security.c                  |  3 ++
>   4 files changed, 70 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 48ac0d911801..721a44d8a482 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -58,6 +58,16 @@ Description:
>   		affinity for this device.
>   
>   
> +What:		/sys/bus/cxl/devices/memX/security/state
> +Date:		June, 2023
> +KernelVersion:	v6.5
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Reading this file will display the CXL security state for
> +		that device. Such states can be: 'disabled', or those available
> +		only for persistent memory: 'locked', 'unlocked' or 'frozen'.
> +
> +
>   What:		/sys/bus/cxl/devices/*/devtype
>   Date:		June, 2021
>   KernelVersion:	v5.14
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 057a43267290..6e1d7d3610a2 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -107,6 +107,28 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>   }
>   static DEVICE_ATTR_RO(numa_node);
>   
> +static ssize_t security_state_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	unsigned long state = cxlds->security.state;
> +
> +	if (!(state & CXL_PMEM_SEC_STATE_USER_PASS_SET))
> +		return sysfs_emit(buf, "disabled\n");
> +	if (state & CXL_PMEM_SEC_STATE_FROZEN ||
> +	    state & CXL_PMEM_SEC_STATE_MASTER_PLIMIT ||
> +	    state & CXL_PMEM_SEC_STATE_USER_PLIMIT)
> +		return sysfs_emit(buf, "frozen\n");
> +	if (state & CXL_PMEM_SEC_STATE_LOCKED)
> +		return sysfs_emit(buf, "locked\n");
> +	else
> +		return sysfs_emit(buf, "unlocked\n");
> +}
> +static struct device_attribute dev_attr_security_state =
> +	__ATTR(state, 0444, security_state_show, NULL);
> +
>   static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>   {
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> @@ -352,6 +374,11 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
>   	NULL,
>   };
>   
> +static struct attribute *cxl_memdev_security_attributes[] = {
> +	&dev_attr_security_state.attr,
> +	NULL,
> +};
> +
>   static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>   				  int n)
>   {
> @@ -375,10 +402,16 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
>   	.attrs = cxl_memdev_pmem_attributes,
>   };
>   
> +static struct attribute_group cxl_memdev_security_attribute_group = {
> +	.name = "security",
> +	.attrs = cxl_memdev_security_attributes,
> +};
> +
>   static const struct attribute_group *cxl_memdev_attribute_groups[] = {
>   	&cxl_memdev_attribute_group,
>   	&cxl_memdev_ram_attribute_group,
>   	&cxl_memdev_pmem_attribute_group,
> +	&cxl_memdev_security_attribute_group,
>   	NULL,
>   };
>   
> @@ -551,6 +584,15 @@ static const struct file_operations cxl_memdev_fops = {
>   	.llseek = noop_llseek,
>   };
>   
> +static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	cxlds->security.state = 0;

This is not necessary with cxlds allocated with devm_kzalloc()?


> +
> +	return 0;
> +}
> +
>   struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>   {
>   	struct cxl_memdev *cxlmd;
> @@ -579,6 +621,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>   	if (rc)
>   		goto err;
>   
> +	rc = cxl_memdev_security_init(cxlmd);
> +	if (rc)
> +		goto err;
> +
>   	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
>   	if (rc)
>   		return ERR_PTR(rc);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 1d8e81c87c6a..5329274b0076 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -260,6 +260,15 @@ struct cxl_poison_state {
>   	struct mutex lock;  /* Protect reads of poison list */
>   };
>   
> +/**
> + * struct cxl_security_state - Device security state
> + *
> + * @state: state of last security operation
> + */
> +struct cxl_security_state {
> +	unsigned long state;
> +};
> +
>   /**
>    * struct cxl_dev_state - The driver device state
>    *
> @@ -297,6 +306,7 @@ struct cxl_poison_state {
>    * @serial: PCIe Device Serial Number
>    * @event: event log driver state
>    * @poison: poison driver state info
> + * @security: device security state
>    * @mbox_send: @dev specific transport for transmitting mailbox commands
>    *
>    * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -336,6 +346,7 @@ struct cxl_dev_state {
>   
>   	struct cxl_event_state event;
>   	struct cxl_poison_state poison;
> +	struct cxl_security_state security;
>   
>   	struct rcuwait mbox_wait;
>   	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
> index 4ad4bda2d18e..9da6785dfd31 100644
> --- a/drivers/cxl/security.c
> +++ b/drivers/cxl/security.c
> @@ -34,6 +34,9 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
>   		return 0;
>   
>   	sec_out = le32_to_cpu(out.flags);
> +	/* cache security state */
> +	cxlds->security.state = sec_out;
> +
>   	if (ptype == NVDIMM_MASTER) {
>   		if (sec_out & CXL_PMEM_SEC_STATE_MASTER_PASS_SET)
>   			set_bit(NVDIMM_SECURITY_UNLOCKED, &security_flags);
