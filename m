Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E0E389DF0
	for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693638; cv=fail; b=WtiW6AQZgoQ5koyuLKic8drXEyqRKPq6vuS86tcNZSmXakLfaHElYVYKgIfovI8fGb5j6JeZrVq0QAmPe6gkkWICuNAIFpd4o27eKNnsAsGLc3Ai5nMHGonPb4CsZma5hSBqf+nIs4ZXnjqgkbBzMIDQU1HTtpRtSb+6wiMllQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693638; c=relaxed/simple;
	bh=ZP3Rtiz2WFhd1/kK+vDsdMig+eMWO9nwCrn27+CrgAc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MQAWHAX3mGaRAsz5vCFInlhaiGLetpOT/oIhGW4Lk6pTtm6ihs1pIdjcAoIoD72xRzumlH9qJhDbGlX97bWJhlzeOl7+VHSPA2qgPKy/wfv6aEYckE/VA1enF8xGyXLR6nsmBgC9fsqFPFHdmyMuZDHXBlhZ8OfAwKXL91QauxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3pFLkmD; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3pFLkmD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778693638; x=1810229638;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZP3Rtiz2WFhd1/kK+vDsdMig+eMWO9nwCrn27+CrgAc=;
  b=F3pFLkmDDxeGZgECuDjTg0d8k8kS5tml0EaKv2T7CQGF3Rd0Z3PKChL2
   ZfgZGxFc0BYviHVJiAwE4nygcsTvZVCqn82fDIF8bvlrgjze4pDT5u9gj
   u2LCFZ94B0f1dg91y+qOvDFYcICgfNGWwXle2K2BkIQYnuBH7VlnzaqUG
   L80/oB+RsSjNZhrBS9HXJ8ROmYAW2LYSRTlWcYHJQ8zcgQwwHuTvYrGsi
   bYojEVWxjBPAiwzMVgFZ9H1LVH93ZiIfD1u5RDSqvpU6FDNNg0T0XBjrk
   iUis2YR96iad2euOabqzh1M0z5fzBZaKXmbwoQxme4wlnBAsbLCXJvwx4
   w==;
X-CSE-ConnectionGUID: YIhVyHIHTqenV9VnG9Yutw==
X-CSE-MsgGUID: nqORMj7CQFmjC+ji4XTvBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90322792"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="90322792"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 10:33:57 -0700
X-CSE-ConnectionGUID: JUG3A+4vRxycS0TgySbicw==
X-CSE-MsgGUID: Gm9zAL4bQFeGPqedbpFahQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="239967022"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 10:33:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 10:33:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 13 May 2026 10:33:56 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 10:33:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAnmjGRjE+dFGAHylXuxiYCmHKXk04QZ26ymOt4OuDj9Z6RzW8OtKU5AMJ3e87YICHmVLGN6z5YowL06idHQDkJGgsDriBWtyKWvyoA/IJ91rmEr7TbDBU9J65NvN4RX5JwjUn1eNgOwGusO4ccdWxvjps38buU05zei+JBGlxsOQSdafF89U7ew+U/N+WAIkw+Db0lKS4KcQWjaQkyAPZ8aowuji7rwL1faRJ79zJIId/tcdo8lX76A8vYUNuxO7UZek791QRJzuZMT1jOt0pEzWc8NnDa1CXWs7vCfRt3zoMRqcEFWC3JWEJVD462QXowIVxImnUINdYWt+DBevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViwAQo2O7SXXswZQ2tnCFPyieLn6UMyJs7Ynyk+R0CE=;
 b=VHFQYQ2scAPBPaZQVjOzdtYlznbFethIkoNhYv4qQH1DkSK4XgqJg8Auh/l94IaR46LdOOAKT5sn4xdi5Itv78fEBSchg2FYDuUSfnhF9NMwk8ZplgCuHzfeEHciR7safJICQmkJ9u2PWsM5swy7nf414VVtIkDJYKqOsCiDG2QLnzX/rxt16sBhUwysuKx+0ZmtZ7v+huatdKYcxFtwLho/8vGMGw0/Pp4JB3+JSXlpE9G8/CFjx/TP8aPr74TS/Pj9cUPCtu3Jmd8l9rP9K36uS66oMfEgIp6rHAE24g4E7kZ7LGRl4OmJf5XkfgcVIZKUpn/Vhv3TZICPlpzoEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH3PR11MB8093.namprd11.prod.outlook.com (2603:10b6:610:139::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 17:33:53 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 17:33:53 +0000
Date: Wed, 13 May 2026 10:33:49 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v26 0/8] Type2 device basic support
Message-ID: <agS1_WH-h-P61KDa@aschofie-mobl2.lan>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH3PR11MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c560ab-ab91-480d-4628-08deb115cd22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: OBl2FURZmA8ONV3iu8D+zTfoNMDIoC7tO6iIRrP4k378vi3VUymdeuUZm2OjfOcyeogvP+L9JayDhYJ/WJjkXqpU195Npqhgr4u6Elbjs9nMe9MMtOGPXYfaovV2coQMqvkMr1g/TKhkk6XFdygedZbD2kxZ4/XUNRBz8omzXB4+mGiKumY+B3ifkw7HBvW53JLmRh7WsWq40024s2Y1CWHe6DxEtqa05YaSYomi8OQV2MaiVfRig+3proK5HgvaK+iZyftzDeyfuDZB/pwOFNupyL7dZVYC7s1U2NY7W+WoG632I9f5bUCTWBJI1PbqxM4qzRNllhEzpOh9gd5i8AF0U/6NJR7X0kTmZzdoaM84WCgZ4bBhw+F2YRFuuvk7dKT0HXtSYp0e46Gg09cX3gPbqxZpyEC12wdP60qRSpagPNqhhFFWzbEMJF7VPOAuPB78wYA4Nhl5WshImM7Be8DO8AZgAgmN3E38B/2zFgSdSs91h/kCJ9DHFksMVR85X3tjQCGjR/MxgwFdlDrQi2q7mc89417aGpJm8qYZqjDQAEfUqz/R1SJh6QJP/fIvdFpsitlUS9ZwqGNnFwRPUOUyQTcgdeZlyjzuQ9tvZ34x9HgIf8vwwTdRMiqTB92bJZbEjC25zjztANfrVu91+WCtKzoRpnWs2PIpqiy+/cId7x0wt4yuuxzAKc9zIwb+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ZBYxGoQlheDs/JK4r+dssu7Nv4yjAHiQwk22CHzW6SJQRW5I15gaifV1byn?=
 =?us-ascii?Q?55izpyBAqQGYp5j91HNU1mBDAkC+TPw1vla9Ejuh0+yKXfQU/toFFMq7vrhX?=
 =?us-ascii?Q?YuHSS0M5K7W31LKR/6VxcSt/LNlnO327H2ZpIeU+I0jEDVp27ZcqLK5XQYqU?=
 =?us-ascii?Q?aIlq6j6L7Kb4T4kaglYtBQKRPliWFf5iUpkOzN8SE0F09/tIsRVaPUTEwpza?=
 =?us-ascii?Q?MteSde0DbRRH2W7ttZWRTON85d9GAIcef8bCg3XIrRhNNT5qhRDivDUBhEAC?=
 =?us-ascii?Q?8jRiBH+THptePu4gwqFkiSWw2YR2ho12G+2rVDr8XYKy9UQrqDq2+L55D6R2?=
 =?us-ascii?Q?omJlmNUfb8em9jtuWqYMBbDqTYXT458F1qpgvD2izzEiuHxIYz7f9CMdDM4v?=
 =?us-ascii?Q?XUVrZofEhnxx9Wa/OOHtxGrKJ2lE1ExVg5zj4xk9tyJBk/ETMe8DWXT4+ksp?=
 =?us-ascii?Q?Q3ueRqHvZksufJvoJQ0OZbd3u9+85mxKUKI6y6nxxM69i+jjCri1UDhQu5xc?=
 =?us-ascii?Q?umyulamMlDsREKe5j4QJI98n9CeKmFlLQOl7IrnxSHMSen6ni4oAGvUvlBnm?=
 =?us-ascii?Q?pzf77oqeREZXm4yB7uH3ADfPmKNj+fCOeFix6MkM0g7oQOerYF29k4zjXLDp?=
 =?us-ascii?Q?NyRLgxgWj/V6Ym7Gtv5s3edTNyihI27Qh1DsD2/G2EX62HiN+yzBHqdCQCLV?=
 =?us-ascii?Q?3QE/LZJPlQsMQvjZg7EhTIMaP+U4rnN6yZGeh3Qk+oN46gK+we9n/RSdQLlC?=
 =?us-ascii?Q?inb18F1Qpo33JyOtqX1CwKgUm6UzfvpZEY9qMPwQSRU4KQ1cqk1lp61kW4Xy?=
 =?us-ascii?Q?ssaF00Roe+LxILRcD/R6kvAAe6eK6kVuuc1WRvmV1r+gwyGfoZgC4dhw8gjE?=
 =?us-ascii?Q?dsLZjaW4/eNWsws7bw+dDS64gmWiZ/d3q+MGNHd6izbZzfo8T2gH33C1+XDl?=
 =?us-ascii?Q?jDznuCTjOgXNcti0QZCparxGN9N1ogy9DPWKEBIqzs8WIPa4GABmeTlM5/RU?=
 =?us-ascii?Q?rhqYOiiystJ6+vYUGLPWzpGEUiSEEjjoPo96aIvJOKVq+1s+mcq/zs75U8/R?=
 =?us-ascii?Q?r9QyFKzDqawiCcTbgg83fQn3seNYQcpGkhThR4qcXVwnR4haO05LMXxd+BRI?=
 =?us-ascii?Q?rXbW4c3H7e07goMZqbnbt8taLSJE6qhp8YUL6TH1FBCHhVvGePr72b8uNJ3J?=
 =?us-ascii?Q?Dz0BakcfP1hirred//yvCVyg1efKbo3348wWYKUDle2rRDOh8IpqkpjpPkGM?=
 =?us-ascii?Q?s9PHeG+JN55ga9qOS+BBnppjBZry9ypDFDTpxwdwEXjpX0hNEN0Z2E0OAp27?=
 =?us-ascii?Q?NEHmUCxPfp22pTiXcFVMZy20Hh2Vum7x24HcHTvYbCcneJTizWfgQr9MoCIX?=
 =?us-ascii?Q?HrvXoazg76CGjz/QbikgT7mf4enkGYZpyXT7RYuhNltKQXk9lwxBLxT8FaY8?=
 =?us-ascii?Q?hdwyyvnNpZcXYBWPuYC+RAnEQ6ZS9+wrPEm5Y1Pzq4uqe4rKj8y9p7e+pHb0?=
 =?us-ascii?Q?8pxojbRbrDHZJRbBmAjjQiRfW66goJbHC982dWRCcSNuG8fyWXRjnkyxQRph?=
 =?us-ascii?Q?VjIVo/OEbB7yYetRhg+xJJVvXDNSN0jVhTC/qq4f6Hn+gI9eWUKQ3OSuifCy?=
 =?us-ascii?Q?jOLc8QQVOWbsI4kusa4JxKAQxuJKON7PDagyhCCRz/zkdI1dOD7o+jXz25aA?=
 =?us-ascii?Q?c6UhtjSS2gXKbgGELHYxN6oI7UjzNL8eARf4CWO7hkr9hOZ3UI27RWiz6DQy?=
 =?us-ascii?Q?eXSecOyW4g8HczeTawqbo2iV4u8DqNs=3D?=
X-Exchange-RoutingPolicyChecked: aioWpOyMwYkyizyx1qctfEnLdoo7ORn44h4RDdj36XhASGt6hG6vkmXcBtB6fGcvZl9vBQ3iskJP2U15IvR8QyoJNxqQGFaefaz1GYmvhgin+BJQhj4secJWTsw1Bwh5uMp7Q5OMoIJHrPlrcoT56zsFGbZHmtNFibrZHWYnlluVxnp8nvrz/3XhLCxYZSSQJ6JzmxOjq+0JLXcP9lXKRz3ebbqhkib4Jn4T4eXgzaACobHIWnEig8U47zTtDzkHdAJXbKgXpY2OX5h6oeaF4zAwwmppgvqET1iFCEc5+1kLLJ7ACkM96PcC/xwh9B6H7Jv9BoMh7tzP2b9Z6gf5Vg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c560ab-ab91-480d-4628-08deb115cd22
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 17:33:52.9377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHXn9HWtWlskuafUy02QGJgmHWzFGBzPZPsX7owVC0qiaogHJvEhuQng1mQ00LG3au78q2Ye9Jsp36/xmZNwonFgDx3isUDKOgp7dCsQIvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8093
X-OriginatorOrg: intel.com

On Thu, Apr 23, 2026 at 07:05:20PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> I feel this version suits better a RFC based on v25 plus the changes
> introduced. It tries to address the problem of user space actions
> triggering accelerator region removal, and extending Dan's approach
> in here:
> 
> https://lore.kernel.org/linux-cxl/20260403210050.1058650-1-dan.j.williams@intel.com/T/#m2d9e5c59ce4873641037f9bcd2f70d5679cda03c
> 

Hi Alejandro,

Can you spell out the recipe for building this. I thought it was
this set plus Dans incremental, but the comment above says this
set extends Dans incremental. 

For my review and IMHO, a single set with both you and Dans patches
stitched in appropriate order would be useful. Please use a base
commit that is a major tag, like at this point: 7.1-rc1.

Thanks,
Alison


> As discussed there, the protection needs to cover the accelerator driver
> handling of the region physical range for things like ioremap, and to
> offer a way for such driver to undo things or at least stop using that
> very same physical range if the region disappears. It ends up merging
> several of v25 patches into just one.
> 
> Another change is linking the region release to the endpoint device and
> keep with Dan's autoremove. This makes unnecessary the previous cxl_exit
> and similar actions are now performed inside region detach callback.
> 
> I think the outcome is quite promising, lowering the accelerator driver
> complexity regarding region handling. The cost is those new callbacks
> which I think are totally necessary for doing things safely with the
> region by the driver.
> 
> I have successfully tested the cases of cxl_acpi removal while sfc
> driver remaining, and cxl_mem unbinding sfc cxl memdev.
> 
> v26 changes:
>  - patch 6: it implements all the new functionlity described above.
>  - patch 8: region detach callback invokes a new sfc function for safely
> 	    stopping cxl-backed piobufs use.
> 
> Alejandro Lucero (8):
>   sfc: add cxl support
>   cxl/sfc: Map cxl regs
>   cxl/sfc: Initialize dpa without a mailbox
>   cxl: Prepare memdev creation for type2
>   sfc: create type2 cxl memdev
>   cxl: attach region to an accelerator/type2 memdev
>   cxl: Avoid dax creation for accelerators
>   sfc: support pio mapping based on cxl
> 
>  drivers/cxl/core/core.h               |   2 +
>  drivers/cxl/core/mbox.c               |  51 +---------
>  drivers/cxl/core/memdev.c             |  81 +++++++++++++++-
>  drivers/cxl/core/pci.c                |   1 +
>  drivers/cxl/core/port.c               |   1 +
>  drivers/cxl/core/region.c             | 125 ++++++++++++++++++++++++-
>  drivers/cxl/core/regs.c               |   1 +
>  drivers/cxl/cxlmem.h                  |   6 --
>  drivers/cxl/cxlpci.h                  |  12 ---
>  drivers/cxl/mem.c                     |  45 ++++++---
>  drivers/cxl/pci.c                     |   1 +
>  drivers/net/ethernet/sfc/Kconfig      |   9 ++
>  drivers/net/ethernet/sfc/Makefile     |   1 +
>  drivers/net/ethernet/sfc/ef10.c       |  72 +++++++++++++--
>  drivers/net/ethernet/sfc/efx.c        |  14 ++-
>  drivers/net/ethernet/sfc/efx.h        |   1 +
>  drivers/net/ethernet/sfc/efx_cxl.c    | 128 ++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    |  31 +++++++
>  drivers/net/ethernet/sfc/net_driver.h |  12 +++
>  drivers/net/ethernet/sfc/nic.h        |   3 +
>  include/cxl/cxl.h                     |  25 +++++
>  include/cxl/pci.h                     |  22 +++++
>  22 files changed, 552 insertions(+), 92 deletions(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> 
> base-commit: 6596a02b207886e9e00bb0161c7fd59fea53c081
> -- 
> 2.34.1
> 
> 
