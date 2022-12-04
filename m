Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EA4C4332F
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Dec 2022 22:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiLDWE7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Dec 2022 17:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLDWE6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Dec 2022 17:04:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDA564DB
        for <linux-cxl@vger.kernel.org>; Sun,  4 Dec 2022 14:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670191497; x=1701727497;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tRgRtTzwjJHKEB6lYT47labq+c2/qHYczMgI0D0TFVo=;
  b=DtE6boKvc2O52oIWOEMVi/8DyFdAsVquwGsSMVNry2lgax9yUZfgcQ7e
   PvkwJ1nhFE6C3FyPct3HiYlIMR+wO6xcVNfEc+mjLezwEVkKw/Bk45UPX
   LX97ALN/Hh5VTPXBdEVJS7NL49YDrh6HlxVagw1E70gUbBG+27nxsa8L/
   jX5cK1SsP8ed5HvJveA7a7YcsxPU+XwYD0jqd1PRdmKEUalo5bpdYH44O
   7n1Agk87g5ch5s7/wMIAAVEgDBSZBT6rz3WMaY9k1q++VvYNu5Nl5x0DG
   O+g9KBx/bBHueMKE0Ff41yVtko4+jO5BkqZkuf7qZ0/ncRqTJBN7l/v9O
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="317371140"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="317371140"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 14:04:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="595991693"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="595991693"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 04 Dec 2022 14:04:56 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 4 Dec 2022 14:04:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 4 Dec 2022 14:04:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 4 Dec 2022 14:04:55 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 4 Dec 2022 14:04:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSQHuBG5aL6WhMui1Kg6S+jo1O0oXBkIq2D2/M58+mKNmh2l+x84oVtIWGQKBabNU/z+65YP2GWRhyy1lqxhKR8hsMX8j+RO+Y5l9Otlghwhqi3dNW9QMphL9mF6mi9QPgJRW9/FW743PhT3V/AKX0ZCuB40HoLxvku+JStT7bBB++jBz+a+Kgeb7uEMlNF2huKBOA9ROBq/0kvq3Lp7S0RQDyF8stgEEr+wDrc6iaUK/mqXC2ij7Y7Kx4ZSywGPm5+hjkXt0D9+bcxZfki/KBJhSRRDFwnsX1eo6xyB1Q1QWFeA/TrsNLWTbqa3RhKONd4Y2PSjgxhrCNqnPRTLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zXebCSeHAFsueJDKOxbRJCZ7DbhYhqCPS5cjDwAP6I=;
 b=VzW8fyj4MVsLN3Opl+fydDIS8aRWzEZdGnvHDBZuTbOVGx37ZwXI/Gv4YmTBtw5d9B6p19EZKuWcWJULKLLciKtX/EFZfZEROcamIkjmfQSP7kFHwSNrIU8h0hmcTXh9ZLfXcGGE6WczHM0v5Tlj4lavGSK63P99czik7cD25JCECxeScIlmIuiUHD9sPiRj5SNzsmLQYqWqxOqXQgAXYLHhUNUhi9u0UZM1Uer59lBjOaceailJD/3EFLkKSYk0NHaRRCf7W7Wxgl7dTECpE4irEDmDsm7+s0oZ8SAV5FHD22gDZ/GXFbpacjvAn1FEEXPrT4WsPPgI040ASgmEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL1PR11MB5336.namprd11.prod.outlook.com
 (2603:10b6:208:316::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Sun, 4 Dec
 2022 22:04:52 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.013; Sun, 4 Dec 2022
 22:04:51 +0000
Date:   Sun, 4 Dec 2022 14:04:45 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH 1/5] cxl/memdev: Add support for the Inject Poison
 mailbox command
Message-ID: <638d197d5393d_c957294ee@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1669781852.git.alison.schofield@intel.com>
 <3c260749c833f51d5cad9ae3912debcdf8b82753.1669781852.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3c260749c833f51d5cad9ae3912debcdf8b82753.1669781852.git.alison.schofield@intel.com>
X-ClientProxiedBy: BYAPR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::32) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BL1PR11MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 73482464-518c-47fe-6870-08dad6439029
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7kkGTY0WVPYGVUDCwasEr238g5zSUnEQ7e7yiV+6avZbRgHs8V/mtKGDD5GTs0u6wmGLmAA14gddrEdr2mBcDIMQKSaTwA++t7Sz2zIQn39fEZEbFFFDwQUH2LxE9fETSfE5I/jTUaTqZcPuzp4EHghl8XieZtBUQ9qRMEEXiA5MtGkcK3EVf3wBj4b9wZmjKArGX15tbejx900OIi6H8+6hxOOC7bzGd0QeKRsEgYCM7QrbvN+2eGlpxBu62PyfSp2lkEIGdW+uWk6pYR8WX8OQZ/XQlT3NzhcK62li/MzB/aq6+1gHAsFNIN6nv9GLZ7LJ7rkmv2tJ7dQZ5JzTRlm8OdtwlG4+hbB0lg+mVzpTmYwnifaMGBI1G2R4CODlaoJ3VCuH7OonATz8/Z3C/fv/sTxdIzb804K0OT3gj9qotCFWpyULndsr628yUbirgExUOfpes5JCFLZ887QA/+MvroR06LpzUbukv+4UFdcTSJWznNskZtNzvd1HME1j9aPUWJKQT8aJKgrAeB9peSzEVpJLjJsIKU/5cTXIA1RtTvpR/kas7j6JYED5FWEfx6wkstMge48FkfIes2LBtIgTri4AcOBZDeDZ55XuvejvVb5tHiF07PvGVQWmvvrW+1JgtgcIy6JEpU1GymdiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199015)(38100700002)(83380400001)(86362001)(82960400001)(15650500001)(2906002)(66476007)(8676002)(66556008)(66946007)(4326008)(41300700001)(8936002)(5660300002)(9686003)(6512007)(26005)(6506007)(6666004)(186003)(6636002)(316002)(110136005)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DTe3J9zzQGzTD8SxQ18GM9HJkRBJxB6vp1IQ7D4TMrCU/DswxGz8XMIIMAe/?=
 =?us-ascii?Q?FsaKxO2PbxCny0LtXmfMWpxqxw14st8dhL2yqzoTBXsTMAoSNioN9KOx0QNk?=
 =?us-ascii?Q?cUu5M2+SbQtEHCiAEhOY3IH/TGK6LLAdKpDBsvnYkC+G/a5XEQMllrtXl/hB?=
 =?us-ascii?Q?LAgaXeTtqc0oJ7KV4iWHbwVj6COEzrXVHs2ctgp2WF3FaAlDpRWPRgdaUPyi?=
 =?us-ascii?Q?AXQ0Eri8wOuMbBhF1IVUgtGjeTK0jJWCuhalbQTawYMY6e1Fz7RZ4A030akb?=
 =?us-ascii?Q?AXR0pwoo/GrOcav0RWrQU9d454QKTZdpzF7RLo6KGlcOeDPwmLtPklOzvbxZ?=
 =?us-ascii?Q?k9h9kez6N7zuGctuxk9nlrxpIpxId6s/ii56bzrq4zlxb+ZxdFXy/8m2f5kQ?=
 =?us-ascii?Q?RCpRGFRcLo55bhLNdgSd3Vv9G0nhSEUUJo0BHXwXLEvs6PdSJezw/eILvNRG?=
 =?us-ascii?Q?3MWtvHqbOh/omXd49zxqkVvbkwUA1PJBloGWBMJQKGeScXGtgc3OhAEhTp7W?=
 =?us-ascii?Q?lEMAxyKADxURxHXehaU3QHqinQ2Zz3kiLGCR9Z5axaPFVbW5gjc2sLzQeJ9p?=
 =?us-ascii?Q?L4N+L/qnlqx+r/Di7KqW22o+sKwn6zvxnK9iuRRUeNqxWKbJL6LQFWL1D8x2?=
 =?us-ascii?Q?IISrs+ZuV9/Tdi8x7isuv7i7Gbc/+LczADoOAp5eNyJfj09HUUundTvEFBdn?=
 =?us-ascii?Q?i55bY67bW0Zq5+WSVaLBc3DAWePpaii3R0OV2g7gYe4IR73+1TdhK1dXGDDo?=
 =?us-ascii?Q?kV5PaXde+6Yyye2A3Kqj9zGGPTdu8+992wHgKN+IFyOcw6fMo/+096YrbipW?=
 =?us-ascii?Q?t3MSRb1cDOgTjYQxFywxPAXuGIA5MwZ1hlbYQgfaRajVrv6dt6/1rL8nMJXy?=
 =?us-ascii?Q?WIj7kqTtZ8+2IHIpShYaJ5tlHsttU7l1dvrKBMmhDNVGaCDrl8P2USzrCM6x?=
 =?us-ascii?Q?cFlVGiA7gthkZGHynlmAMum9++OfirIsjly/w9IUwfjjXellqz5XlMTSrGuE?=
 =?us-ascii?Q?eTevnKSsRCyxI3cAJemUNskKooZb2BiyrmMMGaG6/ZSh0bwViQSURxCO4it2?=
 =?us-ascii?Q?pi9gpXhnFqgdf9DV/4H1f0X7zQfjaeNGnFqDvwHVvrPGdd0cu0wCh79S03r1?=
 =?us-ascii?Q?YsWg2aCw4DlCUKebSbzhiiZp2sdVzDd1KZOMSwMUS8biK2mwhNYgggtzb5yd?=
 =?us-ascii?Q?7dx4xYrgKevHnYtAQJjE1z6v36ftU9NOBb6fHk7Br+g3a9tCRHn0NSOAjlDT?=
 =?us-ascii?Q?Yo3tiDB1h6JpXHYQac5N9WtN7fBEWsXmICscS+f3UdqgglboMfACooRkOq2o?=
 =?us-ascii?Q?YLHtIFBRSYkG0OQRoBN5FMp92IuQmv+FnkSuBxh3ulkRpZmPoaeBG8MzGR+B?=
 =?us-ascii?Q?yt4K01qMRjCU4Dq6dhkyJbp78QeonVfTtAiZi60FaENNtwSBb4xA4CsER4wJ?=
 =?us-ascii?Q?YUragWVuWkDjd9ekKHMhr89u78P0eoPcDtgO24PjtQTdSWKcoC0sr+sYbRmu?=
 =?us-ascii?Q?WH/VOopzPW0nLS8hAtdAgR38d4SPby1fU5I3Eiz7+aKH3JB3g1x73oxKe0v7?=
 =?us-ascii?Q?oD9sSm/qBbqnm7Orb43mgwunxT+62ckW708Z8OrDh9C4yzSekjE6wS2GFAfW?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73482464-518c-47fe-6870-08dad6439029
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2022 22:04:51.0818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XjsQafhHGwOAbmoepG7lkz8y0AOAkjJcBPrGYyr9KM+aDSTvyqUW4jJy5R9OgxwbgsPC20i10uGPUi3WaDRbg28o+IhFv+GGYnreQ7b3Kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5336
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices optionally support the INJECT POISON mailbox command. Add
> a sysfs attribute and memdev driver support for injecting poison.
> 
> When a Device Physical Address (DPA) is written to the inject_poison
> sysfs attribute send an inject poison command to the device for the
> specified address.
> 
> Per the CXL Specification (8.2.9.8.4.2), after receiving a valid
> inject poison request, the device will return poison when the address
> is accessed through the CXL.mem bus. Injecting poison adds the address
> to the device's Poison List and the error source is set to injected
> error. In addition, the device adds a poison creation event to its
> internal Informational Event log, updates the Event Status register,
> and if configured, interrupts the host.
> 
> Also, per the CXL Specification, it is not an error to inject poison
> into an address that already has poison present and no error is returned
> from the device. The memdev driver performs basic sanity checking on the
> address, however, it does not go as far as reading the poison list to see
> if the address is on the list. That discovery is left to the device.
> 
> The inject_poison attribute is only visible for devices supporting
> the capability.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 19 +++++++++
>  drivers/cxl/core/memdev.c               | 53 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  3 ++
>  3 files changed, 75 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index b715a4609718..20db97f7a1aa 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -416,3 +416,22 @@ Description:
>  		if accessed, and the source of the poison. The retrieved
>  		errors are logged as kernel trace events with the label
>  		'cxl_poison'.
> +
> +
> +What:		/sys/bus/cxl/devices/memX/inject_poison
> +Date:		December, 2022
> +KernelVersion:	v6.2
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a Device Physical Address (DPA) is written to this
> +		attribute the memdev driver sends an inject poison command to
> +		the device for the specified address. If successful, the device
> +		returns poison when the address is accessed through the CXL.mem
> +		bus. Injecting poison adds the address to the device's Poison
> +		List and the error source is set to injected error. In addition,
> +		the device adds a poison creation event to its internal
> +		Informational Event log, updates the Event Status register, and
> +		if configured, interrupts the host. It is not an error to inject
> +		poison into an address that already has poison present and no
> +		error is returned. The inject_poison attribute is only visible

This description needs to clarify how much poison is injected and that
the address needs to be 64-byte aligned, or what happens if the address
is not aligned.

I also think this whole facility needs to have its own Kconfig symbol so
that it can be disabled at build time, and it likely needs to disable
itself at run time if Linux fails obtain CXL error reporting control
from the BIOS.

> +                for devices supporting the capability.

Stray indenting...

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index d08b7295a01c..71130813030f 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -142,6 +142,51 @@ static ssize_t trigger_poison_list_store(struct device *dev,
>  }
>  static DEVICE_ATTR_WO(trigger_poison_list);
>  
> +static int cxl_validate_poison_dpa(struct cxl_dev_state *cxlds, u64 dpa)
> +{
> +	if (!resource_size(&cxlds->dpa_res)) {
> +		dev_dbg(cxlds->dev, "device has no dpa resource\n");
> +		return -EINVAL;
> +	}
> +	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end) {
> +		dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
> +			dpa, &cxlds->dpa_res);
> +		return -EINVAL;
> +	}
> +	if ((dpa & CXL_POISON_INJECT_RESERVED) != 0) {
> +		dev_dbg(cxlds->dev, "dpa reserve bit(s) [5:0] set 0x%llx\n",
> +			dpa);

I think it's less that those bits are reserved and more that poison is
tracked in terms of 64-byte aligned cache lines. So I would do:

    if (!IS_ALIGNED(dpa, 64))

> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t inject_poison_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	u64 dpa;
> +	int rc;
> +
> +	rc = kstrtou64(buf, 0, &dpa);
> +	if (rc)
> +		return rc;
> +	rc = cxl_validate_poison_dpa(cxlds, dpa);
> +	if (rc)
> +		return rc;
> +
> +	dpa = cpu_to_le64(dpa);
> +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_INJECT_POISON, &dpa,
> +			       sizeof(dpa), NULL, cxlds->payload_size);

I would make it clear that the input payload is a single little endian
64-bit address with something like this:

struct cxl_mbox_poison_inject cmd;

cmd = (struct cxl_mbox_poison_inject) {
	.dpa = __le64_to_cpu(dpa),
};

...where cxl_mbox_poison_inject is:

struct cxl_mbox_poison_inject {
        __le64 dpa;
};

...otherwise its strange to assign the result of cpu_to_le64() to a u64,
I expect sparse would complain about that.

> +	if (rc)
> +		return rc;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(inject_poison);
> +
>  static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_serial.attr,
>  	&dev_attr_firmware_version.attr,
> @@ -149,6 +194,7 @@ static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_label_storage_size.attr,
>  	&dev_attr_numa_node.attr,
>  	&dev_attr_trigger_poison_list.attr,
> +	&dev_attr_inject_poison.attr,
>  	NULL,
>  };
>  
> @@ -175,6 +221,13 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
>  			return 0;
>  	}
> +	if (a == &dev_attr_inject_poison.attr) {
> +		struct device *dev = kobj_to_dev(kobj);
> +
> +		if (!test_bit(CXL_MEM_COMMAND_ID_INJECT_POISON,
> +			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> +			return 0;
> +	}
>  	return a->mode;
>  }
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 19a9e545ac19..0d4c34be7335 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -396,6 +396,9 @@ struct cxl_mbox_poison_payload_out {
>  #define CXL_POISON_SOURCE_INJECTED	3
>  #define CXL_POISON_SOURCE_VENDOR	7
>  
> +/* Inject & Clear Poison  CXL 3.0 Spec 8.2.9.8.4.2/3 */
> +#define CXL_POISON_INJECT_RESERVED	GENMASK_ULL(5, 0)
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
> -- 
> 2.37.3
> 


