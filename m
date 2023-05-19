Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28EDC77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 15:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjESPeS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 11:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjESPeR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 11:34:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666C61A6
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 08:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684510456; x=1716046456;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lwAPY6kSn8wkpcZMUiDPowMHA3Cs/yrzSqD0tqoLwbk=;
  b=GHMagn8Umum1C2mrtZpjGlddJ+r7xohEoNkS1JZKQoWWaGe/U7erO/pa
   lgx+SoN/6wMabMu5DEqkLmzsenxkYcYbbDTFrfHR11+HQbDK0dawNe9b4
   /ODmTzUTH9bsmQq9P/Xpi5hG7DQW6nHXJmBNmNd4+Z8/5NDmFrKDfWEOQ
   L5woAMr+fVT7VeaetkgbII67HF8s4jdWX9TLwcTatmmp09JYQJ64fEKea
   JD73cSxgroFlBJ+Ofmk/bxJ4ir0GjDI9jMYCxT+sXNW4CeKYpI6ekvAVO
   dRbz0LszXqS+2Md7ZGeJnJuf6FtMnkOTKpHlExF9TJX+0+TCs01rL7HIQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="352421270"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="352421270"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 08:34:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="846922038"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="846922038"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 19 May 2023 08:34:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 08:34:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 08:34:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 08:34:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 08:34:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PY3U3doyytAScwCxqxB8GsHcO4CUjmcCZBwajNlV1EPSJtuZSJ2/hDnFNtf2SoPSA8AS/iuTb28p9S7VC9RVTvSnM+2OpUVUvEh6+ndZdDA0UNVBgha3Z1WDqy/FRiS4Y7XUP2qIQf1TNcxgqZBPr0OHvA/7aOy+p2o84+V6lRjAycKGzDQpsrNOfYNia3b+Y9nwHNHmXm/zeW81Obrq5br7UNbnVPGYVmMxZTwJDMY8ch5A1V98lBZ7rpiYoxH11GBT7DRX3AL5HiV48sUTWnoITUcSPkS/qFXWAmXR9XC/Otb/4QZ2Lg2H+jaIdgwz71hm7fd1jqGmWsqyUovW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRsxLBfZ7SQom5X69wyvR20uOf2y3Wf9+eHuhR05kV8=;
 b=dFEwdtsiHvgeRg1SlGQPEJ6Vl422Y9evI4Ob9KREWULOP7y9ulsNIpQIYA8DBO4ZcTMqYEwB39XNyKf+uS+Jh1/4XYwau9olWo9D6xoVC/qyCAFBRJ5SRE4fSV8FGQk4bF8MByGDxD3o1aVi3EV6A6uRnXG4VqVLhhnduJY9rjS5ATzA1wGMB29T5BnshBExpFOEw9eYktZWO1pdvduXMT06GMFVbLYyc++jixME3J2CPeACP0Uwk0M3l+Re8aqTCfc69z0qyNJIgFhPmOBBjtyqcIS2J8uX7pGAcekOE+xzdNthIpFDtufvaI8h9OH3iALpm+Ru0a3Hb+UHPMr/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 15:34:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 15:34:02 +0000
Date:   Fri, 19 May 2023 08:33:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v3 1/2] cxl: Wait Memory_Info_Valid before access memory
 related info
Message-ID: <646796e5c1dbe_123146294af@iweiny-mobl.notmuch>
References: <168444678631.3134781.16327910091008427181.stgit@djiang5-mobl3>
 <168444687469.3134781.11033518965387297327.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168444687469.3134781.11033518965387297327.stgit@djiang5-mobl3>
X-ClientProxiedBy: BYAPR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:a03:54::36) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 987e305b-a2f6-4b66-9c89-08db587e790f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1eOZFBcSdJCcipijMrxhIONANncDB90rRCQi4qgfR1u2SrGRk6s0f/SoYdfozmy1kUqWNdC27gQ1fYJHW0BxTPvmXjFB1kMBADMBbGlLklktZwXLE4lSVnBgDBXcuJEPk6cZyOY6YOVl0VBTAihKZQSgudy/cTLNTkc8hQCTa+pp4vuD6OteYt+tsBNgPLP8zWdr0M0WPJUqTUXYA7b+t1NN/Xg52RCNqrPoFd9vjRH+Yd/NfIv6A+mol+/jW/QkINEUiW/KcWIEH+CZNd+iH1gmIVHu4lGVgXpYwG1biZeZIPWOn9dUdxN2RnLQ3oqtSXj9WSjcOWgKCUE3yw89DC9PzpzuoLehYdvKuqKhNi1APh83B0/Vp+LJ2w8LO2heMcFCa7ryrFxVisUHnvWSNH7ISIdOYCzapIhtn7dOhj/u3Tc6G5rWFICecnVbQu0r6JP+TBRlJlZdL4CUvsbZB77EIbHKdoOz45E+GgUxBIHNuahso9xsTRib6GacTsiQhlCMH5brCDC2BV8iIVWRSlwaL21w0WvoXmcGjX5eToZILmfBJtRGx9BhMceOGeG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199021)(6666004)(6486002)(41300700001)(107886003)(44832011)(6506007)(6512007)(9686003)(26005)(38100700002)(5660300002)(83380400001)(186003)(2906002)(86362001)(8676002)(8936002)(82960400001)(478600001)(66946007)(6636002)(66556008)(66476007)(4326008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?obP7BkzH1jMww7yC2lZr0Ft/MViAKwPTTJ5aYly6RhK2Vq31z/J64zhlAmzk?=
 =?us-ascii?Q?naUyRi2NuK8NhTdSLisJ28W66+MCDGhRYLzib4G+3SVZMO9pP/epaqrKgzHg?=
 =?us-ascii?Q?DjXonnxki83wvDTmoFAuU0Qp2+zILhECFh3kQg72nGuNMPxmBkHVc75v3Oj6?=
 =?us-ascii?Q?9SYX/TVopVPQmSmU449e2ZkinwvnSgAEw3wqY0dcjmcJ6B+ij4BpzLgGRqKp?=
 =?us-ascii?Q?ynEIey0sqHOzX/rH0Y/q4BryZZvuwSGYnP9aOTTInpCwYM1eQ9RNk5vYNR9v?=
 =?us-ascii?Q?B4/BcWfDe7dFloriusI/7aYjBhe74f7rrPIs+8e7oUEJ/gxBpFTMfTt2BEFA?=
 =?us-ascii?Q?TuVYFQCqUPKTJ37b0EbhltOH0KorXDYNO29kmDFqVAcOkWZqktMoKVPZtD5N?=
 =?us-ascii?Q?B9o2NmrXZm8TYt6Zh5k2y1739/Dzn57YOsqCpxXgiZPgqrw5avwXZzRiDNoU?=
 =?us-ascii?Q?8s4uiwN/VJ5ZeP0w+armsg4aUtImGaG8qFVPrSwsig9/EwYLVP4Qxz020p6G?=
 =?us-ascii?Q?VSDDI71p6znaIGEOPpKcYiwFPM+CGkLoQjsV2RlBjHUyo6UYoqt1kSNGTQ0G?=
 =?us-ascii?Q?PSR4FkuF5WKu1+Tou3Mp1NlNJjXjM5kqh6sLXviVaRnVDUlnd08V+6rF7cqT?=
 =?us-ascii?Q?+S6WHQmlP2qLZDarfjiwUxRIhUxtQ78GnUAE4QJ4d6LUTP5Y5JFPT4r687xU?=
 =?us-ascii?Q?esVbLEo8WIuLrdAsHyQmmIL3Q3YV7G2W+pJamsPp3LxZUPI9Sy2sqIj+X/TK?=
 =?us-ascii?Q?jJtNGY635cvH+/j9U9rBejbNY+qtrN3Wp1r5jTzsnLZvWfZDlbmBq+1baUhh?=
 =?us-ascii?Q?r375ESkfNDuERq3ZumLHrtbSkf9jSonKwU6oNacCXPfwFKpX22NjABk2LpzG?=
 =?us-ascii?Q?zXKLqnHv+Kzvel/fKR9XOYG2PP4Z6u+XQjEVLc/Uwy4d/1v1cKWY5d6JFFfE?=
 =?us-ascii?Q?SoXT8ZJgwvLyS8ixtREj6isdQLHCnBaKMaLI8agW99NKVnK2/yClhb/8sqlY?=
 =?us-ascii?Q?wYYjl+Ad4+xR6hNK2O80EaoxO0ejGjUtDrqkyPzwDcFovFOMbDgFG4h1eU+x?=
 =?us-ascii?Q?Tz3D9z6NgKcD7LFWj3cUF00R10/4u3OOZwR07dusVjCQfh3hMBy1f36cb2hQ?=
 =?us-ascii?Q?5sLfvIiYDm6jkPJix8FfaRFQHVKOgf/6xMLkyhUL8y8igViel3yD0Lz1Pg+8?=
 =?us-ascii?Q?HBEdss47oD/3DvhP+JAd9NzaQIDKhlC7QLT7+J9eviw/EUTX+arQMXlqXUpV?=
 =?us-ascii?Q?OYJ2fM2bRKhMkw3btA/VK3r8jsmwuzMibpk3aS67lDHTWBc23xbSHY28oRj2?=
 =?us-ascii?Q?L3e6d/qaimqRiGoHv73+/zCF/raiU0dA773wzjXcFT2sMl6/RpreS5Pz6VXS?=
 =?us-ascii?Q?T0XMqFOd9Rav5SnHotFuWDUeERT654XqJ/Q4oTK1wyfOprj0tD8NMFh0mYXp?=
 =?us-ascii?Q?cnTUyTdt0xcJJwMXyfS8mU/td7cavQ7QFiT6CNkxXkBRJlsIwXJg2e4Na5K6?=
 =?us-ascii?Q?KyXnepI4+58wMXvsOvVXJQy57WneiB1FRlOqIGdlRPCagCkqdhTmeDzDr4dX?=
 =?us-ascii?Q?tb20byx18sKA8miN9MFhk7rnXiRje2mK0kdx0hI0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 987e305b-a2f6-4b66-9c89-08db587e790f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 15:34:02.5213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9bWkG4TJAElClvceZIPXXV5vRp7wIDFU5WBoPrWEfsO0Yy2b4VJ9IB1JK9Fenw+nqU5IMhhL9HGtFq+MBR8zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8109
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> CXL rev3.0 8.1.3.8.2 Memory_Info_valid field
> 
> The Memory_Info_Valid bit indicates that the CXL Range Size High and Size
> Low registers are valid. The bit must be set within 1 second of reset
> deassertion to the device. Check valid bit before we check the
> Memory_Active bit when waiting for cxl_await_media_ready() to ensure that
> the memory info is valid for consumption. Also ensures both DVSEC ranges
> 1 and 2 are ready if DVSEC Capability indicates they are both supported.
> 
> Fixes: 523e594d9cc0 ("cxl/pci: Implement wait for media active")
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Looks good now,
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> ---
> v3:
> - Fix range indexing. (Ira)
> v2:
> - Check both ranges instead of just first offset. (Ira)
> - Add to commit log. (Ira)
> - Fix fixes tag. (Dan)
> 
> Before QTG series split:
> v2:
> - Check both ranges. (Jonathan)
> ---
>  drivers/cxl/core/pci.c |   85 +++++++++++++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxlpci.h   |    2 +
>  2 files changed, 78 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 63f2f0b86fbc..206c4a31bd09 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -101,23 +101,57 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_enumerate_dports, CXL);
>  
> -/*
> - * Wait up to @media_ready_timeout for the device to report memory
> - * active.
> - */
> -int cxl_await_media_ready(struct cxl_dev_state *cxlds)
> +static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	int d = cxlds->cxl_dvsec;
> +	bool valid = false;
> +	int rc, i;
> +	u32 temp;
> +
> +	if (id > CXL_DVSEC_RANGE_MAX)
> +		return -EINVAL;
> +
> +	/* Check MEM INFO VALID bit first, give up after 1s */
> +	i = 1;
> +	do {
> +		rc = pci_read_config_dword(pdev,
> +					   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
> +					   &temp);
> +		if (rc)
> +			return rc;
> +
> +		valid = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
> +		if (valid)
> +			break;
> +		msleep(1000);
> +	} while (i--);
> +
> +	if (!valid) {
> +		dev_err(&pdev->dev,
> +			"Timeout awaiting memory range %d valid after 1s.\n",
> +			id);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	int d = cxlds->cxl_dvsec;
>  	bool active = false;
> -	u64 md_status;
>  	int rc, i;
> +	u32 temp;
>  
> -	for (i = media_ready_timeout; i; i--) {
> -		u32 temp;
> +	if (id > CXL_DVSEC_RANGE_MAX)
> +		return -EINVAL;
>  
> +	/* Check MEM ACTIVE bit, up to 60s timeout by default */
> +	for (i = media_ready_timeout; i; i--) {
>  		rc = pci_read_config_dword(
> -			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
> +			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(id), &temp);
>  		if (rc)
>  			return rc;
>  
> @@ -134,6 +168,39 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  		return -ETIMEDOUT;
>  	}
>  
> +	return 0;
> +}
> +
> +/*
> + * Wait up to @media_ready_timeout for the device to report memory
> + * active.
> + */
> +int cxl_await_media_ready(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	int d = cxlds->cxl_dvsec;
> +	int rc, i, hdm_count;
> +	u64 md_status;
> +	u16 cap;
> +
> +	rc = pci_read_config_word(pdev,
> +				  d + CXL_DVSEC_CAP_OFFSET, &cap);
> +	if (rc)
> +		return rc;
> +
> +	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
> +	for (i = 0; i < hdm_count; i++) {
> +		rc = cxl_dvsec_mem_range_valid(cxlds, i);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	for (i = 0; i < hdm_count; i++) {
> +		rc = cxl_dvsec_mem_range_active(cxlds, i);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>  	if (!CXLMDEV_READY(md_status))
>  		return -EIO;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 0465ef963cd6..7c02e55b8042 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -31,6 +31,8 @@
>  #define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
>  #define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>  
> +#define CXL_DVSEC_RANGE_MAX		2
> +
>  /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
>  #define CXL_DVSEC_FUNCTION_MAP					2
>  
> 
> 


