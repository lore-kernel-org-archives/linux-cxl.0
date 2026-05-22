Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C13CAE93;
	Fri, 22 May 2026 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779445950; cv=fail; b=YJEMpVETcG/g3xlTZQQb1SA3hv06UjZe8aS2MvhzZCiLvQTk3EUiJkgVTfrbLVC276Kivpp3AQm83m4/Aok1hsUTKPzQ3dFuIlbyWRcZKP88rSfWFwXmFWJtO/UoI29rIdOjyoBR7/n98XtMuHZcxp76zOqbSggqMJIrg79+6ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779445950; c=relaxed/simple;
	bh=aJS1uZ+0HvjhTINkH6VKHhfoMDnmZQZKPlL0fGtsHP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IcPgCNEHF69CCaYF5FEZsKIHID3NEhiw4HSuD/BenEfl2DXAbsmUe2kgplfMeUgFLwwPjL2Akfa587LQxebN5dBlaon/NmKH700MxP8fhuTRn5tR20kgJq13lXLMkJtc/gGAFH8I87bbzPaxoP1nZ9Vb45+JuZf6iCBN0O5oP28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rfsTSHPM; arc=fail smtp.client-ip=40.93.198.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rfsTSHPM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agB5auBkxhrKhF/F+yvmVohJ/4DlVLeU8flZBzKij9efRRGSjmJhSoA/KdL4IrJ2UQGlJuC2mJBOpvJtoMaV+QY3Tvw+gb7pLMXfaSOoMSoykbULdvIOkolgXI4uheKumuF7NQNsHc+Mq02uPTaIGY4q/BPZxi0t6qGa3GR4Zid3adx9+u3uCbLvg9nMvJ1IOcHByCUMCFZbnaWgGU2hMhUz7Dj4Mtoki5xtp5FPm/Bv64tK5uisvO0bIgRMFfGaR/VoYr+EXnhyAwuOMMYc/qDenvytmIhBToFVP09s21pzYwvAjgxtydsX8sutBSlvBeY07mHIJyCwXGMI973smQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyT1uzw+IfAkYXwpTh3lXULyxzNbKcgi7PZMaqjFK4w=;
 b=gHpqgzhBqKwvxukFzwsaSZmvUuYyR4mjtVwYfExC66dvGw9iyxM5syrzR5OwtKLC95WoqzIfLgr0vz5x9WZGXIgZ2kPIbhIrrBu+8cj7eEsMzLJPM4+iUpUDMOLMZ9Lijz19pbUnS0bHSLR/VcCOYb6Tp//PeCgmByp7hUxspA+3U4E4Bdq7kq/5JE22Yueu5l8B8K//3sFxqr/gCWjXO4a00Vptvh8l1RMjXHZarCdiZI3hTPa2/H6n//+MKgOLTLbF6jMXsS0vBhNeFo+qp2SQNPDE3c5ZMaTmLIKWaCLt2nGdGSxxgKzvdOnWvPBvOHXK3t6yXPv8EYciWY4kPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyT1uzw+IfAkYXwpTh3lXULyxzNbKcgi7PZMaqjFK4w=;
 b=rfsTSHPMoFDhKf0d0exqPI20fBzRKTEJv+JyBBgm0m5VyvVnMy4KCRRskiAdsxnQ6xeEkH3VlbD109td1k4dzKY+MyYS0P5OHfRSOFj+Hpf0Kae4c5r1LShHryhCxa6siJga4A93tTBWlqUPX8McmVtlA2ko62EfGvj4anHTpIznlFtaQc30VIC6cJClXCMJ60nVdYTO45I93F0hAjXe9Ji4saWqIq81luup/uN4Nhp2+QxL618pRc6O7xsquhV3IrJ5ti3U/su7MN3c1pY1++XgMXkfTI3Oc1IlrTuDejhDzl2Kw746lOmWW2Gl53jAw2DuXzeu75QjXUpbF8kFig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Fri, 22 May
 2026 10:32:20 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%6]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 10:32:20 +0000
Date: Fri, 22 May 2026 18:31:49 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.ne, jonathan.cameron@huawei.com, dave.jiang@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com, 
	fabio.m.de.francesco@linux.intel.com, rrichter@amd.com, ming.li@zohomail.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, newtonl@nvidia.com, 
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [RFC PATCH] tools/testing/cxl: Support multi-decoder
 shared-dport topology
Message-ID: <ahAvg9I9geuaBrEK@MWDK4CY14F>
References: <20260521084806.28232-1-icheng@nvidia.com>
 <ag-xchhZdpqE9fXW@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag-xchhZdpqE9fXW@aschofie-mobl2.lan>
X-ClientProxiedBy: KU2P306CA0040.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::9) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|DM6PR12MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b2593e-a762-432a-83e9-08deb7ed5bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|6133799003|22082099003|10063799003|3023799007|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	4ZnVw/EcxCDMJBkMf9avuGy3hMaamTDpN7gEn1EMYIZj0UFgc3tdWIkWjfj/X6D/FuWUIDBmzpCiH+uxsiVQziM2PBi0R6ze0N6dQOn453ZCstFEydhhS3zS6MhBgSpq8283kmls66pz6tdS6aH5t31aUugpF4C2FnVCSkkBatwJOfiJTPz1y/XhMQPAFWAWu31RFNner4I3O+Z15mcizx7BFUFAe+5n/oxfsNrxj8HDLwLtvthMHFVpLDnQQTfgIcUBMlzEO++joClblhjehYydwT08kXYrv2GOPaGQsmFL1+V4BnFzjHZRjiYPq6lMQixSy93xVYu/w9vLjRVe9w9hAWv7VtB5hb399ol518S4DTxQXBj1u8Vc6Z6LVRvnLkTpgi2ykLS11E/JlU20AbZT2wBS6uFOgHRC/UCEndtI0pkGy8iQoFMYLEOzi79STItGgtKCDLuOpCP2EekPhvZ3wRBd8UffRwLbtWm4obufj2iIYa/U9elOJ0FKrnH7U0VAqlhP1RcqVu0CnEBTgg8UjbnRMH867mdCeaCLRkCTwkSIzPMLVWc3cJe9aHpJtrYiCJ2xIvDU5ypqWNwErVmSrIQ24dCuCU2AzN0/iDIrNFvssKa/ZbAHCdTrEiGq4oSaEkxt/zXN+H+FkzXg7UxxmjQZia8Vw9hCVU2TDoGkub3afb2Yri1p1QQJ/aPKaQrA9PyCXa3VVHYc1nZE+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(6133799003)(22082099003)(10063799003)(3023799007)(5023799004)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IuzUggTTFfwvvz6FBqUEHuNmliyJPGzL/atovIrHehMsuLSSmskl4Yh2DVF5?=
 =?us-ascii?Q?FMXBjR3Nou1FbAyP6YF037GvhEY5bq+JCrXvjdWzpeJ8EAf1NCSRQIqcnFaO?=
 =?us-ascii?Q?7h/0/FXZF/zIEbdyhgNydr+5sAwCqzRCwnGwV0KGqCbCxpmUQwSNU6PZe4U3?=
 =?us-ascii?Q?m6IuSYBf4mZYcKLuEC0rR9Gel90kBlzwMbDHW8wrPBOqMCH2LDBwg7sSmZ6A?=
 =?us-ascii?Q?mOquPZIrsN32xnmIQMUAUjR4S4F619fhGuwa5gxMNjCrhMbv3Ba9IGCNSpz/?=
 =?us-ascii?Q?lKwmJQFIvEE7CQ1TMSDfsW8uupQBQpSyK8K/c4FupsDEfRf3dQqeU+C0tOP9?=
 =?us-ascii?Q?mYtfJze8h96xTXXSMP94IWbb+fK2+67CMGWjAqGhisZRfyuZBZN1cd6nXg5m?=
 =?us-ascii?Q?S1R71dJKidlai9cTdecSJZGYoW3tsZrPhj0vpYbfsQBrituIdqusB4WRB2Z5?=
 =?us-ascii?Q?DEQseg9LcbswxYn1/3CUybyt2EBoZVeyxd9xJKwnztGvf+bPQFoy0Omw745L?=
 =?us-ascii?Q?w/SduAa1et7+jDm37Ks40ffWN8a7PEV4AwGJ43feSRyhrrIcPto+DKl+oL7S?=
 =?us-ascii?Q?auxyzfcBmfVuXPn3t44G/QlrA9jY+L2OhS0sVCBh19ujM6cmv09dXX79XYmI?=
 =?us-ascii?Q?lIKV/tXhgde4UxGIZJUxrZWAy07p6Qgdb/G+7BbH3/m6Y7p0MyutLOnl3gsM?=
 =?us-ascii?Q?KMsLHpDgTD87Umk2xSuRIkombC0WJU0rQU+F3IwxrqLm4j6keP5akZS2SkFJ?=
 =?us-ascii?Q?inPFZlj5srOquAUj815GqaRPVxuKRxEzE07qG+J/jktEgifKT/0qheZ7qlwo?=
 =?us-ascii?Q?BkrsvY2ES2y+/eJZ+VweASCxvdaG9u/v/Y7TsUBdinRyd/q7T5q8infqoPUx?=
 =?us-ascii?Q?KMzlPBVh+D95CL/RmSwUO6UXnVKK0Ls4lv/NYegjns6nD8JKYkkZPffFN+fy?=
 =?us-ascii?Q?HdEiGwOJMT4HGV+tj8X8IbkD4pu9e/2GltTlN7fdbCTVukydAuOolFQNJSHh?=
 =?us-ascii?Q?G7RtIsADSY76l9cdLCLkQ7FPZtoOXKa8ntKKpKM4cLH8aTziRl53xc2wBaM9?=
 =?us-ascii?Q?QhFn3f9oSETwlL+WAeWIXpxaLvtUMSz4JNvzffXtkY7UJTJAkoMwlrL0B+Xb?=
 =?us-ascii?Q?O3CRmk1jZ7UojRlPmGcOOKQs6xkqoUrZGJ0F5iYmG8gK/eISwISbIg4ZjgV2?=
 =?us-ascii?Q?yyNI8IP4I0Q0ZFpDYuMZkY8+x7AU4gckOCvzCEI33JD8qrmy14YZnyNrmweA?=
 =?us-ascii?Q?8wMSkcOd4VUWV6NNG0+bgFOPYQ/Nb5t1C4idLjuiRW7uouhEg+J5KI/+NreI?=
 =?us-ascii?Q?KrI8CfiJB8QecbeiMYjHkROC4WmqMSDh/BhTm7bZRBr1XDC3ljJ1meCHzbUn?=
 =?us-ascii?Q?kPUtOTSRcRZXv+doYz542LlSiApzPOza3kOejdIvGNbJF+5kJvbM3xvR6hMu?=
 =?us-ascii?Q?nFucrF2zzjOq/u5XEmoNBNARU69S2GgBn0mhWq9V4VovR3j+lXpL8CoZ/Kgc?=
 =?us-ascii?Q?dB+XQ8Br21kVFSVl6b3S4a61K85LUFpmBvy223QXYUJLjuEz26N9MN5Y3v6k?=
 =?us-ascii?Q?hYIWVcqUF0gif74IXwIumxVPwZGZn4Emr+qumMPMt0yMUQ1LqekWF6eNNZhZ?=
 =?us-ascii?Q?Y1UlLfPHtNE0eIxyRvGAZDAXl/dUDfI2zLYTIiwpgtiUmUxYj34iHaQEmHWY?=
 =?us-ascii?Q?+lB328kcXcExAyQusYNvvhQWykG7UksLgcGJZCwimh+2RWXq42TzHTD2eNfa?=
 =?us-ascii?Q?WThvfTKlgg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b2593e-a762-432a-83e9-08deb7ed5bdc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 10:32:19.9409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sK8tAgPzhLE1K1I8iOWk2lvr2GLyNFMvI6uAexvn7N9N6d5oWO+LiY/MSbzKyPKtxSW9Xuaz2Iupy3SmAaDI9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435

On Thu, May 21, 2026 at 06:29:22PM +0800, Alison Schofield wrote:
> On Thu, May 21, 2026 at 04:48:06PM +0800, Richard Cheng wrote:
> > Add "multi_decoder" module param to the cxl_test emulator. When enabled,
> > mock_init_hdm_decoder() addtionally programs decoder X.1 on cxl_mem.0
> > and cxl_mem.4 as a second auto-region carved from the next
> > mock_auto_region_size of HPA in the same CFMWS window.
> > The result is 2 committed switch decoders that share the same
> > downstream-port target_map[].
> > 
> > This is inspired by [1] so the emulator can detect and test for scenario
> > like that.
> > 
> > [1]: https://lore.kernel.org/all/20260108101324.509667-1-rrichter@amd.com/
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> 
> Hi Richard,
> 
> Welcome to cxl-test and thanks for the patch and the explanation.
> Before we add another module param and hardcoded auto-region, I
> want to walk through what's already available and see if it covers
> your need.
> 
> The fix for `3e8aaacdad4f` ("cxl/port: Fix target list setup for
> multiple decoders sharing the same dport") can be duplicated with
> the user create region path using cxl-test default topology as is,
> and that can be replayed as an auto region.
> 
> I've appended a script to demonstrate it. FWIW, I didn't know
> this for sure, and was wondering if the auto and user paths might
> diverge somewhere in this config, but they didn't. I was able to
> watch it fail without Roberts fix, then pass with it applied.
> 
> ICYMI there is a test case in cxl-topology.sh that detects the
> failure pattern but not a config to verify it like you point
> out here.
> 
> Your implemenation did make me aware of a gap in the region replay
> capability. On real HW, BIOS programs the decoders, then the OS walks
> the dports, and update_decoder_targets() is what populates target[]
> from target_map[]. But cxl-test bypasses that ordering. In cxl-test,
> mock_init_hdm_decoder() writes cxlsd->target[] itself on replay,
> which IIUC is why your patch called cxl_port_update_decoder_targets()
> from the mock to reach Robert's line. Lifting that call into the mock
> unconditionally, so replay goes through the same dport-enumeration
> path as real HW would widen what replay actually exercises. I'm not
> sure how we get there, but if you'd have interest and time to take
> a look at that, patches welcomed.
> 
> Does the user-create followed by region replay flow cover your need? 
> 
> -- Alison
> From 0fcdebae75d307036d83f8b7be971db305b83660 Mon Sep 17 00:00:00 2001
> From: Alison Schofield <alison.schofield@intel.com>
> Date: Thu, 21 May 2026 17:39:51 -0700
> Subject: [PATCH] WIP test/cxl-multi-decoder-shared-dport.sh
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  test/cxl-multi-decoder-shared-dport.sh | 139 +++++++++++++++++++++++++
>  test/meson.build                       |   2 +
>  2 files changed, 141 insertions(+)
>  create mode 100755 test/cxl-multi-decoder-shared-dport.sh
> 
> diff --git a/test/cxl-multi-decoder-shared-dport.sh b/test/cxl-multi-decoder-shared-dport.sh
> new file mode 100755
> index 000000000000..5f15b23f3a27
> --- /dev/null
> +++ b/test/cxl-multi-decoder-shared-dport.sh
> @@ -0,0 +1,139 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2026 Intel Corporation. All rights reserved.
> +
> +. $(dirname $0)/common
> +
> +rc=77
> +
> +set -ex
> +
> +trap 'err $LINENO' ERR
> +
> +check_prereq "jq"
> +
> +modprobe -r cxl_test
> +modprobe cxl_test
> +
> +rc=1
> +
> +# Regression test for kernel commit 3e8aaacdad4f ("cxl/port: Fix target
> +# list setup for multiple decoders sharing the same dport").
> +#
> +# Create two user-space regions on the same root decoder, claiming the
> +# same memdev set. Topology routes both regions through the same switch
> +# downstream ports, so each switch port ends up with two committed
> +# decoders sharing the same dport. cxl_test enumerates dports per
> +# memdev attach, which fires cxl_port_update_decoder_targets() against
> +# the already-committed decoders and lands on the line the kernel
> +# commit fixes. A pre-3e8aaacdad4f kernel stops after the first match
> +# and leaves the second decoder's cxlsd->target[] empty (nr_targets=0).
> +#
> +# replay_regions exercises the same shape after a cxl_acpi unbind/bind,
> +# so the regression is checked on both the user-create and replay
> +# paths.
> +
> +destroy_regions() {
> +	$CXL destroy-region -f -b cxl_test all
> +}
> +
> +# Pick the volatile-capable, 2-target root decoder. The cxl_test
> +# topology routes its 4 targets via 2 switches (HB0/sw0, HB0/sw1),
> +# 2 memdevs per switch. Both regions below claim all 4 memdevs, so
> +# they share the same switch dports by topology.
> +find_x4_ram_decoder() {
> +	decoder=$($CXL list -b cxl_test -D -d root | jq -r ".[] |
> +		select(.volatile_capable == true) |
> +		select(.nr_targets == 2) |
> +		.decoder")
> +
> +	[[ $decoder ]] || err "$LINENO"
> +
> +	# Decoder window must hold two regions
> +	# Each region size is half the window.
> +	decoder_size=$($CXL list -d "$decoder" | jq -r '.[0].size')
> +	[[ -n "$decoder_size" && "$decoder_size" != "null" ]] || err "$LINENO"
> +	region_size=$((decoder_size / 2))
> +
> +	port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
> +		.targets | .[] | select(.position == 0) | .target")
> +	port_dev1=$($CXL list -T -d "$decoder" | jq -r ".[] |
> +		.targets | .[] | select(.position == 1) | .target")
> +
> +	mem0=$($CXL list -M -p "$port_dev0" | jq -r ".[0].memdev")
> +	mem1=$($CXL list -M -p "$port_dev1" | jq -r ".[0].memdev")
> +	mem2=$($CXL list -M -p "$port_dev0" | jq -r ".[1].memdev")
> +	mem3=$($CXL list -M -p "$port_dev1" | jq -r ".[1].memdev")
> +	memdevs="$mem0 $mem1 $mem2 $mem3"
> +}
> +
> +create_region() {
> +	local size="$1"
> +	local region
> +
> +	region=$($CXL create-region -d "$decoder" -m -s "$size" "$memdevs" |
> +		jq -r ".region")
> +
> +	if [[ -z "$region" || "$region" == "null" ]]; then
> +		echo "create-region failed for $decoder"
> +		err "$LINENO"
> +	fi
> +	echo "$region"
> +}
> +

Hi Alison, thanks for the suggestion and I think this script is a better solution
then my patch, though I would like to ask can you provide the implementation of
reply_regions() here? it seems like a missing piece for me that I can't execute
this script on my machine.

Secondly, I want to make sure do you have any decoder with targets, and with some decoder
without targets ? I wonder your filter might report that case as buggy as well.

But the overall intention I can see this can be reproduce by the current infrastructure.

And yes I'll spend time to work on the region replay gap, I'll send patches once I finish the
work.

Best regards,
Richard Cheng.

> +# Similar to cxl-topology.sh - test_switch_decoder_target_enumeration()
> +# Counts switch ports where >=2 decoders are programmed (one with
> +# targets, one or more without). After both regions are committed,
> +# every switch port we use should have >=2 decoders programmed.
> +check_shared_dport_enumeration() {
> +	local label="$1"
> +	local issues
> +
> +	issues=$($CXL list -b cxl_test -vvv | jq '
> +		[.. | objects | select(.depth == 2 and has("decoders:" + .port))] |
> +		map({
> +			nr_dports: .nr_dports,
> +			with_targets: ([to_entries[] |
> +				select(.key | startswith("decoders:")) |
> +				.value[] | select(has("mode") == false and
> +				.nr_targets > 0)] | length),
> +			without_targets: ([to_entries[] |
> +				select(.key | startswith("decoders:")) |
> +				.value[] | select(has("mode") == false and
> +				.nr_targets == 0)] | length)
> +		}) |
> +		map(select(.nr_dports > 0 and
> +			   .with_targets >= 1 and
> +			   .without_targets >= 1)) |
> +		length')
> +
> +	if ((issues != 0)); then
> +		echo "$label: $issues switch port(s) with incomplete target enumeration"
> +		echo "(>=1 decoder with targets, >=1 with nr_targets=0)"
> +		return 1
> +	fi
> +	echo "$label: switch decoder target enumeration OK"
> +	return 0
> +}
> +
> +# Start clean so we own all RAM capacity.
> +destroy_regions
> +
> +find_x4_ram_decoder
> +
> +region_a=$(create_region "$region_size")
> +region_b=$(create_region "$region_size")
> +
> +check_shared_dport_enumeration "after user-create" || err "$LINENO"
> +
> +replay_regions || err "$LINENO"
> +
> +check_shared_dport_enumeration "after replay" || err "$LINENO"
> +
> +# Destroy in reverse DPA order
> +$CXL destroy-region -f -b cxl_test "$region_b"
> +$CXL destroy-region -f -b cxl_test "$region_a"
> +
> +check_dmesg "$LINENO"
> +
> +modprobe -r cxl_test
> diff --git a/test/meson.build b/test/meson.build
> index e0e2193bfd51..4abad21102a7 100644
> --- a/test/meson.build
> +++ b/test/meson.build
> @@ -171,6 +171,7 @@ cxl_translate = find_program('cxl-translate.sh')
>  cxl_elc = find_program('cxl-elc.sh')
>  cxl_dax_hmem = find_program('cxl-dax-hmem.sh')
>  cxl_region_replay = find_program('cxl-region-replay.sh')
> +cxl_multi_decoder_shared_dport = find_program('cxl-multi-decoder-shared-dport.sh')
>  
>  tests = [
>    [ 'libndctl',               libndctl,		  'ndctl' ],
> @@ -207,6 +208,7 @@ tests = [
>    [ 'cxl-elc.sh',             cxl_elc,            'cxl'   ],
>    [ 'cxl-dax-hmem.sh',        cxl_dax_hmem,       'cxl'   ],
>    [ 'cxl-region-replay.sh',   cxl_region_replay,  'cxl'   ],
> +  [ 'cxl-multi-decoder-shared-dport.sh', cxl_multi_decoder_shared_dport, 'cxl' ],
>  ]
>  
>  if get_option('destructive').enabled()
> -- 
> 2.37.3
> 
> 
> 
> 
> 
> 
> 
> >  tools/testing/cxl/test/cxl.c | 88 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 81 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 418669927fb0..929bbee471db 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -17,6 +17,7 @@
> >  static int interleave_arithmetic;
> >  static bool extended_linear_cache;
> >  static bool fail_autoassemble;
> > +static bool multi_decoder;
> >  
> >  #define FAKE_QTG_ID	42
> >  
> > @@ -1041,6 +1042,17 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
> >  	WARN_ON_ONCE(!cxld_registry_new(cxld));
> >  }
> >  
> > +static int decoder_by_id(struct device *dev, const void *data)
> > +{
> > +	int target_id = (int)(uintptr_t)data;
> > +	struct cxl_decoder *cxld;
> > +
> > +	if (!is_switch_decoder(dev))
> > +		return 0;
> > +	cxld = to_cxl_decoder(dev);
> > +	return cxld->id == target_id;
> > +}
> > +
> >  static int first_decoder(struct device *dev, const void *data)
> >  {
> >  	struct cxl_decoder *cxld;
> > @@ -1079,6 +1091,8 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> >  	struct cxl_memdev *cxlmd;
> >  	struct cxl_dport *dport;
> >  	struct device *dev;
> > +	int max_decoder_id;
> > +	int region_decoder_id = 0;
> >  	bool hb0 = false;
> >  	u64 base;
> >  	int i;
> > @@ -1129,9 +1143,16 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> >  	 * assignment those devices are named cxl_mem.0, and cxl_mem.4.
> >  	 *
> >  	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
> > +	 *
> > +	 * When multi_decoder is enabled, additionally program decoder
> > +	 * X.1 of the same endpoints as a second auto-region that shares
> > +	 * the switch's downstream ports with the first region, so that
> > +	 * the same dport ends up in target_map[] of two committed switch
> > +	 * decoders simultaneously.
> >  	 */
> > +	max_decoder_id = multi_decoder ? 1 : 0;
> >  	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
> > -	    pdev->id > 4 || cxld->id > 0) {
> > +	    pdev->id > 4 || cxld->id > max_decoder_id) {
> >  		default_mock_decoder(cxld);
> >  		return false;
> >  	}
> > @@ -1142,9 +1163,14 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> >  		return false;
> >  	}
> >  
> > +	region_decoder_id = cxld->id;
> > +
> >  	base = window->base_hpa;
> >  	if (extended_linear_cache)
> >  		base += mock_auto_region_size;
> > +	/* Place the second auto-region right after the first. */
> > +	if (region_decoder_id == 1)
> > +		base += mock_auto_region_size;
> >  	cxld->hpa_range = (struct range) {
> >  		.start = base,
> >  		.end = base + mock_auto_region_size - 1,
> > @@ -1156,7 +1182,9 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> >  	cxld->flags = CXL_DECODER_F_ENABLE;
> >  	cxled->state = CXL_DECODER_STATE_AUTO;
> >  	port->commit_end = cxld->id;
> > -	devm_cxl_dpa_reserve(cxled, 0,
> > +	devm_cxl_dpa_reserve(cxled,
> > +			     region_decoder_id *
> > +				 (mock_auto_region_size / 2),
> >  			     mock_auto_region_size / cxld->interleave_ways, 0);
> >  	cxld->commit = mock_decoder_commit;
> >  	cxld->reset = mock_decoder_reset;
> > @@ -1165,12 +1193,23 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> >  	/*
> >  	 * Now that endpoint decoder is set up, walk up the hierarchy
> >  	 * and setup the switch and root port decoders targeting @cxlmd.
> > +	 *
> > +	 * For region 0 use switch-decoder slot 0 (selected by
> > +	 * first_decoder()); for region 1 use slot 1 so that the two
> > +	 * regions exercise the multi-decoder / shared-dport scenario.
> >  	 */
> >  	iter = port;
> >  	for (i = 0; i < 2; i++) {
> >  		dport = iter->parent_dport;
> >  		iter = dport->port;
> > -		dev = device_find_child(&iter->dev, NULL, first_decoder);
> > +		if (region_decoder_id == 0) {
> > +			dev = device_find_child(&iter->dev, NULL,
> > +						first_decoder);
> > +		} else {
> > +			dev = device_find_child(&iter->dev,
> > +						(void *)(uintptr_t)region_decoder_id,
> > +						decoder_by_id);
> > +		}
> >  		/*
> >  		 * Ancestor ports are guaranteed to be enumerated before
> >  		 * @port, and all ports have at least one decoder.
> > @@ -1179,23 +1218,36 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> >  			continue;
> >  
> >  		cxlsd = to_cxl_switch_decoder(dev);
> > +		/*
> > +		 * Region 0 (decoder.0) keeps the historical shortcut of
> > +		 * stamping target[] directly so single-region setup is
> > +		 * unaffected by dport-add ordering quirks of cxl_test.
> > +		 *
> > +		 * Region 1 (decoder.1, only programmed when
> > +		 * multi_decoder=1) intentionally leaves target[]
> > +		 * to update_decoder_targets() at dport-add time.
> > +		 */
> >  		if (i == 0) {
> >  			/* put cxl_mem.4 second in the decode order */
> >  			if (pdev->id == 4) {
> > -				cxlsd->target[1] = dport;
> > +				if (region_decoder_id == 0)
> > +					cxlsd->target[1] = dport;
> >  				cxlsd->cxld.target_map[1] = dport->port_id;
> >  			} else {
> > -				cxlsd->target[0] = dport;
> > +				if (region_decoder_id == 0)
> > +					cxlsd->target[0] = dport;
> >  				cxlsd->cxld.target_map[0] = dport->port_id;
> >  			}
> >  		} else {
> > -			cxlsd->target[0] = dport;
> > +			if (region_decoder_id == 0)
> > +				cxlsd->target[0] = dport;
> >  			cxlsd->cxld.target_map[0] = dport->port_id;
> >  		}
> >  		cxld = &cxlsd->cxld;
> >  		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> >  		cxld->flags = CXL_DECODER_F_ENABLE;
> > -		iter->commit_end = 0;
> > +		if (iter->commit_end < region_decoder_id)
> > +			iter->commit_end = region_decoder_id;
> >  		/*
> >  		 * Switch targets 2 endpoints, while host bridge targets
> >  		 * one root port
> > @@ -1212,6 +1264,26 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> >  		cxld->commit = mock_decoder_commit;
> >  		cxld->reset = mock_decoder_reset;
> >  
> > +		/*
> > +		 * For the second region only target_map[] is set above,
> > +		 * not cxlsd->target[]. On real hardware target[] gets
> > +		 * populated when dports are added (BIOS-programmed
> > +		 * decoders are read first, then dports get enumerated).
> > +		 * cxl_test's order is reversed: dports were added long
> > +		 * before this point, so re-fire the update here against
> > +		 * each existing dport to mimic the real-hardware
> > +		 * ordering and exercise update_decoder_targets() with
> > +		 * pre-programmed decoders.
> > +		 */
> > +		if (region_decoder_id == 1) {
> > +			struct cxl_dport *existing;
> > +			unsigned long index;
> > +
> > +			xa_for_each(&iter->dports, index, existing)
> > +				cxl_port_update_decoder_targets(iter,
> > +								existing);
> > +		}
> > +
> >  		cxld_registry_update(cxld);
> >  		put_device(dev);
> >  	}
> > @@ -2049,6 +2121,8 @@ module_param(extended_linear_cache, bool, 0444);
> >  MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
> >  module_param(fail_autoassemble, bool, 0444);
> >  MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
> > +module_param(multi_decoder, bool, 0444);
> > +MODULE_PARM_DESC(multi_decoder, "Auto-program a 2nd decoder per endpoint sharing switch dports");
> >  module_init(cxl_test_init);
> >  module_exit(cxl_test_exit);
> >  MODULE_LICENSE("GPL v2");
> > -- 
> > 2.43.0
> > 
