Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D935C7618E
	for <linux-cxl@archiver.kernel.org>; Sat, 22 Apr 2023 21:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjDVVt0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 22 Apr 2023 17:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDVVtZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 22 Apr 2023 17:49:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5482C1FEB
        for <linux-cxl@vger.kernel.org>; Sat, 22 Apr 2023 14:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682200164; x=1713736164;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bMswMDDDa3sLhn7zU0jeQsiRf9O0mT31xC76RpQenUM=;
  b=d4gAZuKC3sfYpaIIV8wuAdD+qGh5YM2z99njcjA3Apbc9OceG+hrWIgr
   fXGCUQ0oljLcho7bJswibROcFN8reMcDp13bYqksm9a07mpON8tWlNP+v
   xDJ+SGeH35S1e0ta1BCd1RgMJw6/gFL1qbIB3Z64KCupPN5EKJkXjWAju
   scImzQJeFogN/7ZWRo0pvX8losL257yKUuWBVP2dRmKgppjwHx5P6bUen
   oI67Q7OU5fAYLYWLMH38/uDX6yV2TE50hZY0m+FNeusmp+fYaXYEgzOi3
   30ig6WFFgY5ubpf/2v7nKWhU+8KiAhsimHqAhJl7EMOVdY5PL0R8rPkw2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="432479874"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="432479874"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 14:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="938849413"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="938849413"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 22 Apr 2023 14:49:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 22 Apr 2023 14:49:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 22 Apr 2023 14:49:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 22 Apr 2023 14:49:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 22 Apr 2023 14:49:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFHYbNieIDgcl3wMqNBarDh2R8/mJGlFh9dlrrI2mCIpkN/XQ9VQ/U4eBku/KQ5gAGoCwDv35IGHo1iErftsiyE1Lph+BHS9ZQNSVPWVgJJxLmb+qO9iHxqAdmuF8ibe/r9k4W4rxIfvCB4tIIMRe5CWmt5BGeHLUWcJzaun/MrM1ZSUg2vw+QI8h+tk1l98yzlZY5Im0ionp4fB60ci+EuBtdo6cf5P1OGHQLNNm5KHZXIOx45ToBihDxJjW7alXbKNQQrSVR2PqOrPczG4eATbP7xcgWriBzRQIbHi8bhFftn7KvvnNyj09xlYhYt8TKB71IAdUGxUwxygD/IKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfvK2c4Tzm1cZiWmgA5LhXQU+e+iQtQMLzbLNl+2FYo=;
 b=DJxA4co1SKDKuV2mEFcYvZSX3j8LyvfJxKRClKZBu822ZM9AiwkMkrOCP1vfF9BQC9WxSG8bSTh4DblGYkaXjFOegINgJ2s2KXt8X/R+RyzDKUja5EzkMkAvvmlJHC/6N3D0urvWOEzecPUdYJD27l2pVAkbEewgtiH6tyFZtLlyuGumko0lV6nM4YR/YG7G9jzQ/7xo440fOw6pYZmxGhyC7z8JY6w+QOAWMeZFDX0KuBsNusaxdPrieUBW7YSVLWRMBqXKzyiKWKYdr8te5WbLumXZT3f+2aOQkXxxywhTn79iuckQozwOwzB/ybqYtzAu4P8zRYVRYEjZmBWuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5690.namprd11.prod.outlook.com (2603:10b6:610:ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.31; Sat, 22 Apr
 2023 21:49:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Sat, 22 Apr 2023
 21:49:21 +0000
Date:   Sat, 22 Apr 2023 14:49:18 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v6 01/10] cxl/memdev: Add support for the Inject Poison
 mailbox command
Message-ID: <6444565e7f86f_1b66294c7@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1681874357.git.alison.schofield@intel.com>
 <241c64115e6bd2effed9c7a20b08b3908dd7be8f.1681874357.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <241c64115e6bd2effed9c7a20b08b3908dd7be8f.1681874357.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:334::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5690:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c129672-675a-4679-1d58-08db437b6da6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NizwUFTd7b4Fn8g7VtL7D7cILWSV2a4MNuSKaNxevgI3UPdHD5M5DYzk9RjDoGCJpokF3Zv4qdpVHKfsRQ+/BHn/UsYbsz0/wqQpSE015iXHNnc9rDmzTMkBCtndS5Rak/rAX6U4moBu9iukcty9ZjF7/59gND8oqJhokEetdvN763yz0PpJDhwnHmvqQC5bd8DQepupVmmAKGuiHhi6yks906kNA42SZivwvXlu1BoUXw7/7Nml4JFn9TqypLazczP41KGn1jPKer+PbXqDJLaocSYvCjQcDilVvlyVaF7tAuX2hLAJibQgQjxdpKOgoRDo2oW8hR2+jwRH3meu8q0MZNhskkCrPa1CBrXI7EYX7ZfEXhgkR7rYxc3qDsxvF53AtkBz3RszDGZD5tnFgQx4TCx93utvpG4GJHUlvlVdvwm2RTzMoREbJi1I9fPNJuPBQXi0YxxPxuAco6Q6bBNgyV6VcQURtTjFLuB+c3VhhXUmqd8YarQMk3H5w9htwC2P3BxEJ1KVlEOGgZ3skEOCy03BZSfSSaNsbMQtocnnKGpM4u1Uhx687Wrhofx+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(15650500001)(6486002)(110136005)(6636002)(66476007)(66556008)(54906003)(66946007)(4326008)(2906002)(186003)(316002)(6666004)(41300700001)(5660300002)(478600001)(82960400001)(8676002)(8936002)(86362001)(83380400001)(9686003)(6506007)(6512007)(38100700002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HnhQ7Cj+iHssG4a0mNxU8OBMQZkN8l1pPdRwlYpC0lwTJ9pprf61P2Gg3blK?=
 =?us-ascii?Q?JS3z9Z99g1VHtCIt5QS41mSaMrCILsHQxP4eD23edJnRLa/IGePovbwkpKWy?=
 =?us-ascii?Q?X4QBlJxQIQ3uIvnhsjNkx+BuDLDud5p7liU0/NKA/QzM7FAVY45uzs3Vv6wX?=
 =?us-ascii?Q?0d/o4gxfgfGFdzkdwciIrFo05bpKThoLpOc++ODBcM11xBNKVwugB2cEdGcS?=
 =?us-ascii?Q?uAqYoHSpChLlBSzXoyWXWtwBoKmRmYkHY9BPkZ8Qw3zjCwzEuyMyXWTjJXM4?=
 =?us-ascii?Q?EB5syZjWWpvG/1HiGYotBpGweZKYSnCQ77H178iubrQOK6v8TSzDzBe0A3Et?=
 =?us-ascii?Q?Z1AFJtsyijGbOKVkwJAygJFjA+JAuBpNFk1ZVRtbuKZF/WBEU0k142i8NwA1?=
 =?us-ascii?Q?lZqgD/9idc8I6Z98qE98RGKt6WOqbGQ3gDlm9O3d/Qx3/uXOSyIkw2MvkcyB?=
 =?us-ascii?Q?BchMibGMcdq/Xq2ZNLLjTS1ZJElgeASK5VB3blmDJAArG9tjaoZO7lvdZ4Q8?=
 =?us-ascii?Q?I0qRa1NHgYV+wxwWLvhv9x8TxgLJuUGz1VyX0T8iRJJCBMsPZxLQ8d7aF42D?=
 =?us-ascii?Q?7TH1pF0A5cqwvwiYHOzDc0A7O7kEEr/k+amK7hpcXF+Kn+vxWkhP0fKrSrFY?=
 =?us-ascii?Q?n3Qv87D9nH69gd/mqdUyGDWvDZAI5L7Y1UL1H7lDqTZjHzxRb2OxMZ3M3Ue8?=
 =?us-ascii?Q?2rZhl5GXiTC3/Z/00YkGsfAzcm+7nIKZ36TGs3Qa3iZhIZMYFb17YztYMWZF?=
 =?us-ascii?Q?Dd8uwiGaNjhzKYQbNhoDHWo4n2JZdOooCdKvA7UJDGtfdJyzQu1C1Y5EqeXL?=
 =?us-ascii?Q?/9w6SCKS6Ys/fqSJy510B8zcPb2mu/5PORUGeei5FBOKcvw9QIDeShxNzD+9?=
 =?us-ascii?Q?GqxHFZwqA7Q4GRrZL75zu78zV976ztDAH9CgsT96z9OQrhZIwLh/h4E0wwtQ?=
 =?us-ascii?Q?8tGicaHjsVa1AD2ThQUik/TkjM/7C/AeR0WKyaXCfSedxe5Z9U1cBgLxBGS4?=
 =?us-ascii?Q?v7LsTyKV7AQxP1I8Hb1QbtgkWXdvqgmGDL115fHm9HEAjfUfdjhvTpEOkM+u?=
 =?us-ascii?Q?yEKimJUReACZC6fG90knT/tB/N2CzyeR/216iXAVipdKG3wdoy+ql6lGynPE?=
 =?us-ascii?Q?zleuyhHZ/Z2LheyiRRXN18Dy3PXLpBz2gBTeg/10y1LmLQhW89BllA4f2zzJ?=
 =?us-ascii?Q?zklbUgbvaiyr+TS4MAXzV4qFBf4ZrIU+6TuZOt4ExznY4V/tDRDltZi2duhc?=
 =?us-ascii?Q?2VUkWCw7TScUjCWPLj0eC5n4zOh98XtzFPA/4/T0cTV37J+TEd9oIQT0LKcb?=
 =?us-ascii?Q?VNflozYUn2AqA8tIWvFJ7cU5J+OpmL/RZ1BsdN0+GMwSUcAMOpAanNghjNAL?=
 =?us-ascii?Q?nkbcnrvJV2D2Sxf+dNWftJt6XMtIw+AqClxwoTsrkcnv5yd3rF3pWoPYizYn?=
 =?us-ascii?Q?taWTfJ47o9nPFqBHZaqV4HrPgAgMp2w2b3Sc8VhwLrISvPqXrbHCHW+iuamD?=
 =?us-ascii?Q?brqGj9pJKj+dmkn7UaZHJnm4w4+8/jp8wG/9noIRsubVdXaLgOOHacM4gptl?=
 =?us-ascii?Q?otOOmw9NbJeZvCneMBfIA0Sj5rIxMaoZfT4lAwHaetId+XL6sG1Mi/mYFZRG?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c129672-675a-4679-1d58-08db437b6da6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 21:49:20.7654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bws9xzighfTnhuOprdteaKNb9D+XzZNzAiuL0Oxg1ws1S88GeaUOV6sFze+MxN3FurU4lHfwPmQt2J4iBCMQ3vbvIoQE0UKaukIc+Q6jx8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5690
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices optionally support the INJECT POISON mailbox command. Add
> memdev driver support for the mailbox command.
> 
> Per the CXL Specification (3.0 8.2.9.8.4.2), after receiving a valid
> inject poison request, the device will return poison when the address
> is accessed through the CXL.mem driver. Injecting poison adds the address
> to the device's Poison List and the error source is set to Injected.
> In addition, the device adds a poison creation event to its internal
> Informational Event log, updates the Event Status register, and if
> configured, interrupts the host.
> 
> Also, per the CXL Specification, it is not an error to inject poison
> into an address that already has poison present and no error is
> returned from the device.
> 
> If the address is not contained in the device's dpa resource, or is
> not 64 byte aligned, return -EINVAL without issuing the mbox command.
> 
> Poison injection is intended for debug only and will be exposed to
> userspace through debugfs. Restrict compilation to CONFIG_DEBUG_FS.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/memdev.c | 56 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h      |  6 +++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 8db7f220f182..474f7c2f4f6e 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -160,6 +160,62 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_trigger_poison_list, CXL);
>  
> +static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> +		return 0;

This does no harm, but it looks unnecessary given that it is only called
by debugfs entry points which already compile away in the
CONFIG_DEBUG_FS=n case. It also takes no action, so why block it if
someone besides a debugfs entry point wants to use it?

I'll leave it for now.

> +
> +	if (!resource_size(&cxlds->dpa_res)) {
> +		dev_dbg(cxlds->dev, "device has no dpa resource\n");
> +		return -EINVAL;
> +	}
> +	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end) {
> +		dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
> +			dpa, &cxlds->dpa_res);
> +		return -EINVAL;
> +	}
> +	if (!IS_ALIGNED(dpa, 64)) {
> +		dev_dbg(cxlds->dev, "dpa:0x%llx is not 64-byte aligned\n", dpa);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mbox_inject_poison inject;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> +		return 0;
> +
> +	rc = down_read_interruptible(&cxl_dpa_rwsem);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_validate_poison_dpa(cxlmd, dpa);
> +	if (rc)
> +		goto out;
> +
> +	inject.address = cpu_to_le64(dpa);
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_INJECT_POISON,
> +		.size_in = sizeof(inject),
> +		.payload_in = &inject,
> +	};
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +out:
> +	up_read(&cxl_dpa_rwsem);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
> +
>  static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_serial.attr,
>  	&dev_attr_firmware_version.attr,
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 68b9db545aae..8a3ea9cabf1f 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -615,6 +615,11 @@ struct cxl_mbox_poison_out {
>  #define CXL_POISON_SOURCE_INJECTED	3
>  #define CXL_POISON_SOURCE_VENDOR	7
>  
> +/* Inject & Clear Poison  CXL 3.0 Spec 8.2.9.8.4.2/3 */
> +struct cxl_mbox_inject_poison {
> +	__le64 address;
> +};
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
> @@ -689,6 +694,7 @@ int cxl_poison_state_init(struct cxl_dev_state *cxlds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr);
>  int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
> +int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
> -- 
> 2.37.3
> 


