Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A71C6FD1D
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Mar 2023 01:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjC1BLt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 21:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1BLs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 21:11:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E8A1991
        for <linux-cxl@vger.kernel.org>; Mon, 27 Mar 2023 18:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679965907; x=1711501907;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+fbXya11Agca/9Zax0YfbPHq03tCbly9m7IW8lnK7tA=;
  b=Z3/nTust7dLegT11kS67+kjWsrRm17UnKd65uqPwj9srZmHTYWgqAepE
   0rJmoYbW90yD4iY3Jg2YaI2fAwwhYJeh+zsYCS3POFHH0nOl0rM5nJJOs
   KtjzhEbd3vh3rI3BcpSH7Jk6WtORX/NrwQxOt3VyyfkyHzSdotw46fh/y
   z86W682qfscDUDyjV1njPJ3zFffve248n8ffFUrzVErR/lwN8kWmxn5xi
   NKAdeYUYEXiVsnxZZp/mMX7IlCJw6giZiMgHTE+JGhJQ0uXUo9w8GG4cn
   ZUl71sFqWozEIqZ/o1Kjy9L0emurD3oh5drKjblf5950BAQ6dPG4DxjdH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="342839620"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="342839620"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 18:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="683659773"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="683659773"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 27 Mar 2023 18:11:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 18:11:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 18:11:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 18:11:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAJQrcP59iPRY6Tv+gb5azkIRaqqoJhOvhnue/i0Qw7dMTjXSPS5WksKJ151rPGwh/KICRFB9LxZhTFYppnvXfMSUwjJ8LNp8kEfAdFKpXQtWa2M3hwcVfhERYGacWXhZETxq5vm6UhP/WIGNt9aY43pKZCT4Zm2TYv6FdLPMwBNuj5wE28IicETNccuFpPc/mgFJiSEklgeviGBMSPU3AN9MAryfbSEv8ZrSdbSCeBqx8SOeJtWzBOdTS84hudTTxJAQNZaiZl4Cj7mF/IIu5v5Oz4k3OENd0tzmmYVMLv/z5RP8UWxkIr+8uQkZbzyfidIBSvcmmWQbLRuteCfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40oOKpLMkC3FsKZqaRTi69JcF5t0lxpa7IBPPpo0Kq4=;
 b=MKwybr29ujeV4H5SmPU0iVzmf4L1jDTZIrEh6Jyvlo86h9/Wxhc1ZhWt8KTWsKXy9ekE+0czCojHbcSoAacBVUY5FNfvPUgOiufZmht/SOvInP1VaKGkDXOnDvxjPhoTFgpZziVxJ0Y7bj72DJSquzOLd2XyWfuzznThc0QyC76cLda4JTCv1TGjOIJ44IKbcvZn6HGB+WrB53lsj97dQxxGLzGU2NRs/a7Dm8n3hq4EHZsf+Wvd4vHAE9F7Tu6HcoD5fgNlqfjRX7qyiVCASp/aL3O2egy+QJGdDFWT6i1nR8fuTeKTgf6e8VIZfcxI5EHV7AYU3MoDXuSDFa/G+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4558.namprd11.prod.outlook.com (2603:10b6:806:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Tue, 28 Mar
 2023 01:11:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 01:11:44 +0000
Date:   Mon, 27 Mar 2023 18:11:41 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>
Subject: RE: [PATCH 2/7] cxl/security: Add security state sysfs ABI
Message-ID: <64223ecd8b2e0_21a829454@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-3-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230224194652.1990604-3-dave@stgolabs.net>
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: 6434330e-fe15-4090-0ff1-08db2f296508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJaEbCwMB+3YvHKR4ImMSl0OOI78/xEyCaDWkDYOz0cwlfDuOkta0gRTCL0SsDuorUVqquVWNaL1osprK0TpAyOqFygkJlbpU4J1WHiTEjrhZlz4v2ct99vyYZ7zzzPWVcP/Fpq6lb09b4pDhNl16ptrjuoRclbG9aGqac6S1wPR5/Lsdz2ZmKULTs+kQBIdILuoICNEc11CZ3hQtG1TFJN8nds8dSEbFuMhv0JoA4vnGx3L3Y44t+8NWmNnLxkJqTYLmEptuWGwB4ikZxmbkAg2Oco0BULb94iwZgUAxj9nX9IzjjsU8Jn2Izz05HzmfHG8+LbMAx4HHBzrZn6ey1zA6DmMn2BJCAvem/bC+FbvWWRtAGe/yCteTj4F7QnGFUuSkPzXbAYCTwqOk+UM/LjJID69TMhqpC/6jpCxrEOxY7NfYBKm0Fr+Djrkf7mUk+YnBeLMn0N+boajduv2BxkLF76U9+DjtbkX8cSbj30EfXGYrhHt+OtZ5HKTzGX/cjTkP61gN9zlkFNSSeSg/QhmAY2oQoObrxq3UcNcZ7MI31rwsnSY865FWnyrnL2/cXCzL0i22rVIpOjgpeDos2sYkM6+Fe9HICmZnHFdHZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199021)(83380400001)(41300700001)(86362001)(5660300002)(38100700002)(8936002)(6486002)(82960400001)(478600001)(8676002)(66946007)(66556008)(4326008)(2906002)(66476007)(6512007)(15650500001)(6666004)(6506007)(9686003)(316002)(186003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yXGjNYqCs5CSjOE6Ask40MSwX5unUPnI5nUr888GfJMxE5ZZ6D7ML0LLxLfK?=
 =?us-ascii?Q?7rfhFHeEctWxw16+ejalEw7F9DS6cxdpJIauhgNAYxV0/fCcIIfMI8ZhYYoI?=
 =?us-ascii?Q?cmvQk/5kYEiA+CwTuFxJMCpPMmuHHk4G8v/zDYzh4YuvU3XKf1CmUjpueraK?=
 =?us-ascii?Q?y8XR5vcsH52yRx14nHrHJB3Y7JuSPXMgURZMz8dE2hD70zjupJSYKa8FVwMc?=
 =?us-ascii?Q?cOxuI9W3M8M5/L9s1CA8SjiAzzAqWY+gBTcr/eQayU3fwV2IBlHwQkONyhxW?=
 =?us-ascii?Q?w76o9rfVQmFpgd0zB2T3Yui1Ozxu/k62WEkjlyzsKCWUtJuc0rmKW/XFYbTN?=
 =?us-ascii?Q?bhlVGrWD7GQurs3yyxszkBBx2XlKyQ/K3KqiHkuXpHr8tZV69LX0RgEdliAf?=
 =?us-ascii?Q?+t6FWFYdzhx4HG6Hy+ZvQcDXL0YDqGivKf+nJTGUzVxrrv1x0npQ9OUbf314?=
 =?us-ascii?Q?jRie9gMklqqkvH8n+kLi11YS/OTNjV1bTA6sS8ZFujM1qyKL7xA+G8Kmn3ZB?=
 =?us-ascii?Q?NQYbgAeWtUIvZ5o9SU3Kal/5qQMZ641Ss+DUuabREUNHPmQOpHYobmGr/rIO?=
 =?us-ascii?Q?IibLEOJQVvbvGpqlTncdR7uVlZBtQb9BOK4WRLAyy3M0Jgli+ATqqMWIID4T?=
 =?us-ascii?Q?6PKzL+wOUcOo7mKAEBXhgxVvPRuyCSIyVK2bEYTysz4nTVMtmnxXpZHatP/G?=
 =?us-ascii?Q?3TUL3LBln0aaXnY9ciIi0Cshq3EgwDZMeNBUwuFZTafyRbaqZMJHYhycNV2i?=
 =?us-ascii?Q?nqH2virfl+iMlBtJfEuNT/gIsxaIUydyuA4/p4N9D5H12/d+OT8mO3zxHweh?=
 =?us-ascii?Q?x0uVqhu0ajdjhO159UA6IYljuICIXanW3OvQOopKcznXc2s5PVZRV5s3dY0L?=
 =?us-ascii?Q?3U91g5EiMXCWX89T9YJwafG3korrlJ554NfaGjv3QPuF2UJnkg4SAD6bcm+E?=
 =?us-ascii?Q?kNgWmoHA0c+1Nn/Ww3mnqmPTk9HOg+qOF62QrUA/kEfztbsboBb9miBVffYO?=
 =?us-ascii?Q?lGNumqj9H+Q1EjYKAtiDb5W0QyZpyvcZJplwmYfn2cXAPSfVfc2Bg9XDzVTR?=
 =?us-ascii?Q?kpvb11TIp3FtiGHDYdXtywbyQQWRrpjKVe3T8eEcMR8FD3a9sz04VJO5ZQKk?=
 =?us-ascii?Q?t6yuPKoKC36flYJ1Ur8QSpa1kQ/KscayTMJSdnKQn2skvKdN7OjgWx83wbmc?=
 =?us-ascii?Q?hORFIdt6Rx5H4RiCXo0orkujx6QjIPi92aiQC0RC34SX1lYLCXwzogjc7vqF?=
 =?us-ascii?Q?/RIMKjCdZcVW3HkcBCJrmv9NwI1pmwdlYz8/xxPSu0YkhqmZsYESLvDRg3ea?=
 =?us-ascii?Q?Q3cFGHhcfMm6r/+/cw0wF75KMYflZahDgFxqNFJcjbI4ffWQ0adJ+uiemWC/?=
 =?us-ascii?Q?oUsxNpN5aRugxW1QayzpclYDJZVaMFtgzNjY2x+TTV79ssVEHkv8s5jOoJRO?=
 =?us-ascii?Q?jFatafOgrLeMYZ57oK/zc7V+HVDVqjkGweBgfyFZHGIAmmVEVTizxXohTxfz?=
 =?us-ascii?Q?SP3qPioB2J9nirXznpx5dNxYFPmnThR9mFhCVErO29paagA/ji2HQV6YU0TC?=
 =?us-ascii?Q?lJXMBsCd5KP6zkaMSyVi5Fzf1JLAm2EqEA7uk4RdErY3nVCWzc89t1GFw5bX?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6434330e-fe15-4090-0ff1-08db2f296508
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 01:11:43.9186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3k0Wb98UUIu4jLJA2iw67WVC/sz2r1Rn2j5bNC7DqOI3YXxK0IkX0G0dg9tqJAP0MFsyXVuRfDWJL/OP+lM8kSjiQFmifCXkLYdqkGzRiVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4558
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> This adds the sysfs memdev's security/ directory with
> a single 'state' file, which is always visible. In the
> case of unsupported security features, this will show
> disabled.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  8 ++++
>  drivers/cxl/core/memdev.c               | 49 +++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 3acf2f17a73f..e9c432a5a841 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -57,6 +57,14 @@ Description:
>  		host PCI device for this memory device, emit the CPU node
>  		affinity for this device.
>  
> +What:		/sys/bus/cxl/devices/memX/security/state
> +Date:		February, 2023
> +KernelVersion:	v6.4
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The security state for that device. The following states
> +		are available: frozen, locked, unlocked and disabled (which
> +		is also the case for any unsupported security features).
>  
>  What:		/sys/bus/cxl/devices/*/devtype
>  Date:		June, 2021
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0af8856936dc..47cc625bb1b0 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. */
>  
> +#include <linux/memregion.h>
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/idr.h>
> @@ -89,6 +90,43 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>  static struct device_attribute dev_attr_pmem_size =
>  	__ATTR(size, 0444, pmem_size_show, NULL);
>  
> +static ssize_t security_state_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	u32 sec_out;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_get_security_output {
> +		__le32 flags;
> +	} out;
> +	struct cxl_mbox_cmd mbox_cmd = {
> +		.opcode = CXL_MBOX_OP_GET_SECURITY_STATE,
> +		.payload_out = &out,
> +		.size_out = sizeof(out),
> +	};
> +
> +	if (!cpu_cache_has_invalidate_memregion())
> +		goto disabled;

I think this can go as security state can still be read even if
unlocking is not safely possible.

> +
> +	if (cxl_internal_send_cmd(cxlds, &mbox_cmd) < 0)
> +		goto disabled;

I would prefer to not have an any-user triggerable way to spam mailbox
commands. Security state should be read from a cached value that gets
updated when security operations are run.

> +
> +	sec_out = le32_to_cpu(out.flags);
> +	if (!(sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET))
> +		goto disabled;
> +	if (sec_out & CXL_PMEM_SEC_STATE_FROZEN)
> +		return sysfs_emit(buf, "frozen\n");
> +	if (sec_out & CXL_PMEM_SEC_STATE_LOCKED)
> +		return sysfs_emit(buf, "locked\n");
> +	else
> +		return sysfs_emit(buf, "unlocked\n");
> +disabled:
> +	return sysfs_emit(buf, "disabled\n");
> +}
> +
> +static struct device_attribute dev_attr_security_state =
> +	__ATTR(state, 0444, security_state_show, NULL);

This looks copied from pmem_size above, however that one is using
open-coded __ATTR() because the attribute name, "size", does not match
the prefix of the show() handler, "pmem_size_show()". In this case the
shorter DEVICE_ATTR_RO() helper can be used.
