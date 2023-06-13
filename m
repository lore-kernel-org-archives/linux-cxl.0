Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B746FEB64D8
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 18:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjFMSNF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 14:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFMSNC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 14:13:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58631AA
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686679981; x=1718215981;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cCZyBgT9apMNdNY39ERZglPNkkan3lA0Avgp21Z7E30=;
  b=Bwi2Ve7TYyEnmRUDUEYP5Z2WgaJnwI0aIiEr6vPY7YAqqVereNqYfG8M
   NhuAV0b6AqkozPnnoDIydRojmoYXbkopps5pOyFClRZpaQ/PUo6cLZGut
   VzTj6uP4IFRxiSAbLDC5rpIoHvpAmqYtF8l9LY2BUhrWfJgXq6dznLUmD
   MnpFFTInrPsv1vSoeMXnqoe9wFoQhT/WoFM9MriDiT+TD7RHR0YfjhCPm
   BOgBQSWBM5/uHm6yvSjp7l5cI97hTZsAAqaX4TyHuqTm/rQH71EhKW9EE
   B5rzfe9/vY5CYdtOZIdqIaIzSXDJtJeKKuDRujryCTW4NFEbIOte4/RKN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="355916022"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="355916022"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 11:13:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="744780000"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="744780000"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 13 Jun 2023 11:12:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 11:12:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 11:12:55 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 11:12:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8mcszB1Wc23LstXCoZzNb6h4qcJFUhyyHRIABTFQBoonVfEI7OsS/R0RvIM8Se67/2UQQrO6Gud9gYozwOaz9294HipRQ6DGlKqB1uEo2pxObIzhSDVupBIzSZ/myYLLBdylxQEbKUq/NNEmG/Rv50AqdM+m3B72YVeN7TQfhJiX6MhHD/ZsGc6z6F8HpnZ4u+49b9sQ9R2gu7szU8Qt6J6+c+wneZcvLYrjIB47aYFU3iyPTYKmV2Eb/lmU2X37gGCDWs0AhD9g4DBBdGPFg8vXJYQ1er1R8e+EH0zQTp68ajVOcNoBWY8peaqjNQRornb+NNtumDVvFD/SKLnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igc3o0GtZX497F2uNJnxDZhwbvhqblhW4Z2Yb/F2c24=;
 b=hL/DS4g7OxbdYSec3ehC9z46nwMP0n9MFYbGMWTA8PTSgLvie4gbmwbvGmjzDelzTeNND8/hdhRXBz4V0Kn03gdbaqnfXWsebEpZa19D7k86kdBxmGFJHIyQim05wGEh6Mjb7dMm2bdmefKi6wRXFY8euxIMk8UVGBz5AUCPsN4iNQCqeuAksEZbERB1RZEUxmZvpxHkMTAEIVp9NKJzz7MsQYNllU6Pq/EdqsiuEraOiqaGIMLomHGfcE+FHvNRPhoOR88Kx8CdhPMVkAp7wcMmuSYIASg6mn0X0b0jp/hC94VooD6jR0xVZjKQXNhyFNlRf0rCZfGkCp3msDqQGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ0PR11MB5167.namprd11.prod.outlook.com (2603:10b6:a03:2d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 18:12:51 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 18:12:51 +0000
Message-ID: <934796d1-2ead-ba00-0058-0f9c9b9becaa@intel.com>
Date:   Tue, 13 Jun 2023 11:12:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 2/7] cxl/mem: Introduce security state sysfs file
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <Jonathan.Cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
References: <20230612181038.14421-1-dave@stgolabs.net>
 <20230612181038.14421-3-dave@stgolabs.net>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230612181038.14421-3-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:a03:333::25) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ0PR11MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f19fe6-2b1b-4b43-7b59-08db6c39cd23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnROhOe5P0xQC3wgoutDq5V8fqRdXRDxKns6QcVSPEGlcAAekkuItaULZ+QIUnmgD8IJnaGQI9swG42kv15yMPWnIiaLRnPhNJWSjikwxgAj0DJG/x8vUTW7426z5xNx8wbx4zZ1pZPQpXONtrr4Y0KihghUQxAvimEVmuU4Po76G0kDOaJ3/Kfp98fyuNT2PBA/AfKklTCQ7/UcsdEe6pKB9I89SrI8XfmW2sWQ5x/LM/KEiiku+/kB+sOXCj3ZuxywkZ8ExiZl2bmChLTqJcIsNY16OKLZ+adFeBiJ0DSyiI9oW7fRv++yYoU77V47FxikPI+1QJIwb6Kkc9ggJXt/su75NgwtuNLLJS4yKBPdvQCEN9cR65gPba0OxnDhuaT1Xxq8cAS2Js2THMdKclMHfAKBBKxRu7OinEmF6fvk0vLIYChr99RhGmmtIBC5XYmp2mLLkjan1tFZsVYMnKGwkGQuN6QKZqzCgC9io2gMJe/aPt+0W6jJVAzPGQnwjKnle9gPyJxTIycAVCGDtkJhLhJMCxkcFddCcrI33SvBz0+34EilQeYXeDA4B8NC5wSjq7v9P954e6ZAg+zrtA2Gqt0RRfKruLuLNu/ssTQgQWEWyx9nJo0/jlujNUQbrbdXOoUG2Y7qgVDwzDPwsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(5660300002)(15650500001)(8936002)(2906002)(8676002)(31686004)(66556008)(66946007)(66476007)(44832011)(6486002)(6666004)(4326008)(6512007)(26005)(6506007)(53546011)(186003)(316002)(6636002)(41300700001)(82960400001)(83380400001)(2616005)(478600001)(38100700002)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmFOaHR5RjlxZkVlRlU3ckgzWDFoOHFJWnhjUVB4VE9PZ016QlBiU2M0Z1RO?=
 =?utf-8?B?ZUZZS3dtVUF0SzJzYWQvZDJ6enVRTW1ITWFOSk1PYi9lMTJabmUxZHljUDVm?=
 =?utf-8?B?ZDBqelppTEFIbjkwMDRIVGlSSXQ2dS91U1BqcU51V2FPY3gvMXhJeVBML2U2?=
 =?utf-8?B?cWdzNUJnVytIRGhBOTFtVEw0dk8yajF1NkVLUUdJWThSMkVFMjhETU5oWmhJ?=
 =?utf-8?B?dkR4RXpmbHZjZkxkR3FJSFJyM0JHOUdNWnFud0RNN0FmWkZvSHZ1Vm85enlM?=
 =?utf-8?B?VFpNTFVoakhwVGpCZzNEVFNaZUMyRXN0L3ZCcy8vczhMUnVvSFJraDYzcXEr?=
 =?utf-8?B?YWFXTWtCb2FYOTVERkRRaDg1ZWtyMEhST0Z2VXZ4K2srZnFWS0dEWUNFd2tI?=
 =?utf-8?B?NytEVkd4OVB3ZlBmWnVERWIrTEVRYW9HVlV4QmZwTXh4NTVsV2VDUEIwS1Vi?=
 =?utf-8?B?TmNaL0xkdW5MWE90UEl2cElvdXFyVUFQRFZzZzJTckJBcWhONjY2cHVtUWR5?=
 =?utf-8?B?T3Q0Z1NpcGJzTE51Q3E0UVpRT20yem9wWXpDRWIzcFlNVUF6cXRTNkljZHhw?=
 =?utf-8?B?aFhyOTRiUWVKQWxCdkhLMXVIR2ltQ1NRcFQ4cjVKbm03YWlhb2ZiTmplU0VD?=
 =?utf-8?B?dUs5elNpZVpwTHd3YXc1M0VRSWdFV3BlMmhCME5UTkRmWklJcVYyc3JYZFJy?=
 =?utf-8?B?SVF1QUNUWFBVSkRXV0J4bjdTMG9ucGIzbzNKaE5oNUs0ZVM2TnROTUtMUThS?=
 =?utf-8?B?MWwvdzFIMFhCdzRwaWNjeEZ6d1hnZHdZdTR1Z1IxY1FiWmpMaTVlMEZRQkkw?=
 =?utf-8?B?YitFRy9yQ0g3Ty9iRlJPSGZHb2hLbHJIdmZZTzE4UDRlNXZJVGVmaC90Nkgv?=
 =?utf-8?B?Vk51MnU0cWRhY3NsMndCbnlndDc0bGt1OURRaXVxY3JCYzJYaGFYaEJOY1BM?=
 =?utf-8?B?NXE3TmR0UWhCdFppQVZOTWlabDhSUzhWNDhjT3VIaDQ4OU81QVJObmxtNFR3?=
 =?utf-8?B?L2l3dzZmb09rOVpKejh2K0tBeTUydjhnVmY1MTZBLzBIRGh1Y1VLOGR0WjFM?=
 =?utf-8?B?RVgxR2ZtTU5BU0VUbVo2eEZBTFFQNnQvU29wRXg0MmZMR09YaEp4VVAyTVp3?=
 =?utf-8?B?SEhmMkdmbHk5MCszaTVwR010OGlmYlBTaWwreEFQb2ozRmV2MjJ4bmNCNmdo?=
 =?utf-8?B?Rjh2QmNEU1FWUUtvWEdEbCtRMHFVZjRNdDRITlFqb2ozVmlXakxzeFJqOUN5?=
 =?utf-8?B?bnVNVGV2TjgzejVGM01WTmtkRlVuUlkwZEJtUlYxNGoyeEFmbmNsK0JKTnRV?=
 =?utf-8?B?Q1BNdlh0d1RpOGRjYyt1bTl5Q1lEc01LWjBFV1VyTitwR3ZmbDRGNDNRVG1S?=
 =?utf-8?B?UUdTLzNjc01aYW1tRks5QncyemZnZEtqSmUrcWVUbElGbVNYN0wxMjc4c2lF?=
 =?utf-8?B?WnA3d2xYdG4rZkplTFlMbFozM0RtaTRNUWJyZW8zbmY5ZlZwckFGYnZxRzdr?=
 =?utf-8?B?R0dKb256WGtkSEhBODlUTm9pMXdCODhKeUNIQmdZNU5lN3BsRXlScURpbmtj?=
 =?utf-8?B?Z1c1YXhXdHVRSVZFNnRuOWZNanIvVG9VWTRJSkRVZ2VTR2M4R1l4TEVMYVcy?=
 =?utf-8?B?MnNpTnRJVitKU3JPRERFdVFEMG5Hb3dEdUVlZE5xNzk4N0tmK0NENU5TUUlv?=
 =?utf-8?B?dFJPYkptMWdZRzU3ZUFWN1cwWktwWlBtb2NwK3NLQ3Q2cVcvWmcvVWhreVlV?=
 =?utf-8?B?WmprUitZcCtCQ3pKZTlQZmRYeUhjNm9mSXZBdVJYelB4WmhPNmlpVW16UW1N?=
 =?utf-8?B?T1B1SGthYlhTRURFM1VLN2s2cXg0YkpBSmVsMXdEZDREOUZuM21lUEJQWkdI?=
 =?utf-8?B?amRLelhNeUllNDQwYUJpSWRKOHVKV29iSS85eWwxeTdiRDJaK2ZhYWNUb2J4?=
 =?utf-8?B?bVVydzdsOFVRMVhBUmU2cGdlcTdhRnJqbm9rUUx5M0FQaDN0Y3BWR09KYXRs?=
 =?utf-8?B?ZWd2QkpEdUFLbGJwdUR3bEZmb200NTYxc0NMUVJTRWpXMnVUR2ZHY2tNaVRt?=
 =?utf-8?B?REtxS3dCRXdBb0NlQmVKaWRERnovbDljRW9TTldSZndUVmZLR3c2WktTTFFx?=
 =?utf-8?Q?hAJulTka0RCiI6rDpFGd32nQm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f19fe6-2b1b-4b43-7b59-08db6c39cd23
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 18:12:51.5067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tywIeJ9vPGy+r5ig7TJaaaq5h5hjqV3zoPGMa41y7SIKlS18SWLFa69OFBOXSpo5Vnfzocn3eF0fODjNtQ7keg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5167
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 6/12/23 11:10, Davidlohr Bueso wrote:
> Add a read-only sysfs file to display the security state
> of a device (currently only pmem):
>
>      /sys/bus/cxl/devices/memX/security/state
>
> This introduces a cxl_security_state structure that is
> to be the placeholder for common CXL security features.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>


Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   Documentation/ABI/testing/sysfs-bus-cxl | 10 ++++++++
>   drivers/cxl/core/memdev.c               | 33 +++++++++++++++++++++++++
>   drivers/cxl/cxlmem.h                    | 10 ++++++++
>   drivers/cxl/security.c                  |  3 +++
>   4 files changed, 56 insertions(+)
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
> index 057a43267290..1bbb7e39fc93 100644
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
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 1d8e81c87c6a..091f1200736b 100644
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
> @@ -336,6 +345,7 @@ struct cxl_dev_state {
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
