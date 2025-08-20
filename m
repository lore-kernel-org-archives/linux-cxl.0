Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26F6239E88
	for <linux-cxl@vger.kernel.org>; Wed, 20 Aug 2025 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693716; cv=fail; b=mb6rveQ5qtUfgl1zOKIaMbdQdhGVi8wBFGRAtoXWAxMqXAUEGFaJHzou2r91/gkc4eDFWw8U68jSAL77E1YWFUt/Txk1Adqz/isHk3bGxc6UffYnoxqmJ2U+9zdN9GBOld+Unik8keH7HN9NaK0lwFeDM+QSpISwEtAQT/aWYd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693716; c=relaxed/simple;
	bh=MsIUx0FQgB3CDfVz2x2x5kANav7GPzckszAzNp5fk6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mfSqrPdzkLa+mEz4GPmHWyIlJHA6X6j9l9llvibN6CX+cCuyhTQThQdvdW/8qPBllMO7Q68efjaqydvuKuSaOKLvHSJnymv+3s7zfC2XktRiZI/KovYGyKCkY07nvsi83V21KSThr9kkzC8eZl3dQOPIe/4tMiqA+Jp5o7EZit8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y5tr9dFw; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y5tr9dFw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8wWa4H/Ck/WayX+MKk00XBjwrrpWQvbNbs0v4OlbuD+EVwMfxiaaGJziFjDXuiVEO362XPsnGKTlVJXZVaHfK3I1Jl+2zMjzWlaLhS+//Yprs3tpMX3uxX5Man9Lc34UxXWhbD8cUYiIPcnGmoVkN0ttEYSpH4Xw7In57WpysF56kVuD3C/e/dk+XiuXT7yQ/I1p4me0AsEbdLzNjgvD2rEJ9KarU4CwScwXo7k2nUZi6FD7XiThKhelQlwNW7p9asNKRKKYk5yhQg7Lm5tNU2mP3mRZAXMYoc5oEMHY6fdurMQaHGwmIL11tTlaJCHBYWI9CEMzE1ZmNJv6UX8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpkT74PevPfRaHBJcIfG3N+jXI/7KfpMvNamFi3W5bM=;
 b=jXgJHORO/e2kUsQXlphZ6CBlWXIeM5ZYMlurRHV7urMtVRPXS+xpFHCVUac0oJ0ijmIQzi0dFp4S2RTslWrCeVPdnCaQPRCWuUN/hppk80HGQAiDrRWwqXgfhSri+PcuIkzNiu//dQ0qXqnCvXwSzIa7Qu22XBvKIhavYij1Ytj+WFFbpwhFzfhksvOOWQV6bzoCu/ZpmaXXPghizmxd2KKpdIWWdIywk8m6XxxtnsD/1RfHmNzXsFu9BVELrQdmWa00ppDqbprCSG4CdSC75hxTGrs+n5gksGWA+fbqhdWRAWtZRPzNaIHPFGCkNOeVOGVpJXImJERa76EwgpAHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpkT74PevPfRaHBJcIfG3N+jXI/7KfpMvNamFi3W5bM=;
 b=Y5tr9dFw0TgrAgAkWx7V2n6bP+3vCKkHztrSVRoyev/oi4CLw71OO48oUPK3/b0ykguOCbQOXpqgfXiBcB27Lv8SnHPHShXtfTKATSdanVlbMJ6GOgI6iD+MtMCWvgplOUnnCm0Cx03DpjQ7XeUNq8i1aGlZPJzlC33nEKY8sJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:41:50 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9009.017; Wed, 20 Aug 2025
 12:41:50 +0000
Date: Wed, 20 Aug 2025 14:41:45 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v8 05/11] cxl: Defer dport allocation for switch ports
Message-ID: <aKXCid-m65ou2WVV@rric.localdomain>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
 <20250814222151.3520500-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814222151.3520500-6-dave.jiang@intel.com>
X-ClientProxiedBy: FR4P281CA0324.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::14) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|BL3PR12MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c7341a-f804-4757-dbf8-08dddfe6ef00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hcl5YgdYBhLmzScCk5MLcrODPhxx4vm2AEzuCtr11GndWWen7DNhoWF27AyF?=
 =?us-ascii?Q?O50Xc6h9mT4UA5udF+ZxEHTQqg2fYwTVTiI2/tqplvIRSVzpGIz1FHs1dMna?=
 =?us-ascii?Q?E/77C3HwfG4KzLmv3fJoYWjmPqHebGkw/Uh5NgRiA8VvagfYLHxuSTKjaNzj?=
 =?us-ascii?Q?8jX9qTmnP//0TY1dswiPvKnmV+ZNCUWcYIaqusdRl2epFtPK57Wil2RLtCxh?=
 =?us-ascii?Q?lBEC/cNBRar/nuvWHUZrzQ1CSYI6v43si4BrA3rMUbuVlCVnYIkTE8tk1dHB?=
 =?us-ascii?Q?m+xepf6xERFdGrhP+Vm6x3GxxItFG4fASlHUB36E6j0SS3hOLV7e5//lWhX3?=
 =?us-ascii?Q?nG3RZIlnF7c7+1WRE+5Q5FYnoSgbvVcx1x+RmHLXfJ25xccNca9jGlAjPB7M?=
 =?us-ascii?Q?DMeHWHw4TdRWpahMy9+i2lb5s0E83FLr4QzmR+e9dtRpnEzosDIInOVxrlZs?=
 =?us-ascii?Q?GY3aFd4WcLRUnd6OOmYF0lCBOcKUD+BUCOTirLbmtP5GC3FMjAJ87Fs1Nv1S?=
 =?us-ascii?Q?pnUPY7vmL7o/7GyeWCIgMKpETOqvK2e45jeNi+zMAAzqn3qu5lVYNDlFPM/Q?=
 =?us-ascii?Q?R4iQCST/jaOBYMf5SFNtnV49ZmE8MsjJ6MW7E01UHds6r5w/DKs1SPgm2fnS?=
 =?us-ascii?Q?AJLFHjCRHvuz/Y7vIvbNBz2OeADXi7vRnbM3Pj9Y9WH8j0aK0uGwn/HegoNN?=
 =?us-ascii?Q?bKnYxOZg/d+LmNJgIO6vQMu4MIuyypRCXxSi64rMNNDYkrLM2M8g+8jq0xeL?=
 =?us-ascii?Q?JWcI41UzM6/hUGiXz/u2kOYgFy987DMhz+RDpBlsC7isCawgKBJaP4IimEs6?=
 =?us-ascii?Q?5M9GRDMWhEGuvkiJ1latHSQbD/F1PTApR55jrzM3Pn/e107lMhZJAAx+AbSu?=
 =?us-ascii?Q?sr1Rvrn1JliS6XW1SN/u+NxZe4juaIa61szWJdMC989PQ8wmMp5LFhyOt3Pf?=
 =?us-ascii?Q?sofOMFA6CgzJetBEujKRldXtCby1WqSTQn7C4pzRiC7KOxMLOjVr4t5Ej+pS?=
 =?us-ascii?Q?FCGmLvH3T8ySSwqAhAQIEqrB5lElHQ6IJFz1NuoHUjUNbb/Z5CSr+seUQBM6?=
 =?us-ascii?Q?29Y8O1NYYGC3Ajohg77djAwV4d1XpKf3765bq9taxnCxrmDQAQnDhlxk2cPu?=
 =?us-ascii?Q?k38hFJljM6icOr1IwuofUFzs+vm6GbeHzl916XrpQHM3t+EjyX8c2ygrp2CW?=
 =?us-ascii?Q?615sE/DcN8qX/qDrpnDaHc3GDyAJ9Trige2MmfCy/n+IJPcArbtHPlTmGpaN?=
 =?us-ascii?Q?nYY0mV8wsjmdJhRTpdh8S/5M3amPvvSv7lZDH+QYrHy+V3I96zKY2g2Qr0ih?=
 =?us-ascii?Q?vC0WuU+8mmLNOqUBv+AHW8CvCILAnBN3WzLosxtb93lsDKG4iJTGkKSrA8Rr?=
 =?us-ascii?Q?LMcepGtkwt7i6NlqgpNCcaTUMhaItU4F2sMqO5w793JpA8iAVUjTo0ywrNTm?=
 =?us-ascii?Q?RZbGoAGSVyA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DhqfJ3ZX5qkFyMOLyt9YDxbOGWXZTwlhXw4VyncVxNV8hZwwQFCUiLJXD5IN?=
 =?us-ascii?Q?HQkOj/8S0L7WEyhIi2zWTf+KrwyqmENvBTOw6u2MFxxCKaf+/A4+SR1doafV?=
 =?us-ascii?Q?1Er7NwDxelCTtlxy5WJQO9+fklLF3bji48272o71QO27Py01QV6ngXuIqNpg?=
 =?us-ascii?Q?kQCL9YY6EAhGPvDckvWYJ3Tj4yqX5SJApmagwTDn1ug7RX0/LLdZoIXsfTqS?=
 =?us-ascii?Q?CNK01tbnc9xmr+UGLyF6QX4Ypsb1wG3YJXoSvm8WR5cVsO8R0eDsZYHE2V17?=
 =?us-ascii?Q?g28SSUO999BHVebkg45a7HSzTG1y0xUqxS/7ck250U94frm0fC3sTJQ3ADyN?=
 =?us-ascii?Q?jQv9kVN7ZMk2bzZ5VcM/OF4Yh6JVbkCzeZfLiNPkxW6GTd+AftAD5UmS9YvN?=
 =?us-ascii?Q?WzaO1EYObxWaYl0Nn5xyEgZvYsxIgZGKWYljHb5JEGfwqIrG0CLHMM3snbYe?=
 =?us-ascii?Q?FISDy/dNfl+hTWFniJ7OONxVpFiUZ4v+MqI4rlkJuNVYUbPzUtnXsaoLBMs7?=
 =?us-ascii?Q?182uf+0NrOnC7HrfQq5IuwGJyrPubrmn3gbYgKgjX02C3X2YQGHI76Rb6ScY?=
 =?us-ascii?Q?K74xO3TGaNFoKhqQcPKBkIzhMS+l0/Gv1btHTkHRyTQokZ2KcSWkHAouTs7X?=
 =?us-ascii?Q?OeiQrkHPT9b4dH4rlRYSXxfCLTywaUeMBvJ7F6USMqFfbl3JCW6NZeTjtkzq?=
 =?us-ascii?Q?3AMe7D9EmaIXacBVQegYTDhwc2NPvmCjBPbhgTco/DNzP5RdIZOeb/682cU4?=
 =?us-ascii?Q?VxFnW16wjC5q2NWnpUrxYT4k1fVpToNgQ5yW4YjAAZAhGF1wKInkeYK8xA6r?=
 =?us-ascii?Q?I5h+WgqnnM8W4ij6SAu+5nbpn92qpnw7QLMRilVi7m2uh9vKsuEK5aRf++tM?=
 =?us-ascii?Q?VeKSRA00bGXwBMk2++TAALj1ghkId1FjY9Nln0U2QlF7Sg3qOS3X/w/uZFCS?=
 =?us-ascii?Q?tMrdjjHuhcIw7eA2rSVLOJGlfSNY81EzarK+P8m4DV9+cjQrFiBIZhQvYbfK?=
 =?us-ascii?Q?MY+vkpk6SSla7y1xy7aWKn9DGlKkt5yCz2MjQg1vLQvWCQLA+GFwjCnf7KA9?=
 =?us-ascii?Q?uGExmy1ja2nxEo1WvTj/fcY5x21NHfb6IUqBLbwDp+JbWml29G2tmXiSJvoB?=
 =?us-ascii?Q?BG1EvxUzhvPan5f6YlCOCkflYJVbnw+I4W899DTRAyvRbeFwrtSjgq2QeWEP?=
 =?us-ascii?Q?gqcpH1xolcNGRHomSS/911ON8WTr+u+RmTjE1WMxxFaIqUFxd/8odSiZaf3g?=
 =?us-ascii?Q?PnR+NufCIpaWYWDquSRjguoWPghe4TnQRAL504t6ZCmaOlzY2Zq+n0aQgVEj?=
 =?us-ascii?Q?rb7HO6em0CT8T4xUnz3KAHtB2vF2p58H4hP7T7d9VGAvZU8bJHRJW3PdH18Z?=
 =?us-ascii?Q?9ln9RtRg1OaU+oyTRib4GFKvaJ+doGwfY70bnsmwymJx91F/YvRaWWAn7/Gf?=
 =?us-ascii?Q?GOn9tnqaElu0tRBLxFtND7krjuzw2NcKRnCJBdWluvWFaYHf++WlcdMkRhB7?=
 =?us-ascii?Q?8k3AuDoOtIM6/mbCS/vqalm/KLItn1sXmIkM7uVJ8v52621nclkOVqAGHWnf?=
 =?us-ascii?Q?iUgCvgUJFbW3rz2i8RcfDKohGaQNLZ185Myc2wtY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c7341a-f804-4757-dbf8-08dddfe6ef00
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:41:50.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9aixT+oD753VgiKSA1jyDE8t45lYOovzL5rKMK/H3rb2gDBwQmqngXW//qdP9v6KKJCrn0LgAvBaLHvbXorYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641

Hi Dave,

see my comments below.

On 14.08.25 15:21:45, Dave Jiang wrote:
> The current implementation enumerates the dports during the cxl_port
> driver probe. Without an endpoint connected, the dport may not be
> active during port probe. This scheme may prevent a valid hardware
> dport id to be retrieved and MMIO registers to be read when an endpoint
> is hot-plugged. Move the dport allocation and setup to behind memdev
> probe so the endpoint is guaranteed to be connected.
> 
> In the original enumeration behavior, there are 3 phases (or 2 if no CXL
> switches) for port creation. cxl_acpi() creates a Root Port (RP) from the
> ACPI0017.N device. Through that it enumerates downstream ports composed
> of ACPI0016.N devices through add_host_bridge_dport(). Once done, it
> uses add_host_bridge_uport() to create the ports that enumerate the PCI
> RPs as the dports of these ports. Every time a port is created, the port
> driver is attached, cxl_switch_porbe_probe() is called and
> devm_cxl_port_enumerate_dports() is invoked to enumerate and probe
> the dports.
> 
> The second phase is if there are any CXL switches. When the pci endpoint
> device driver (cxl_pci) calls probe, it will add a mem device and triggers
> the cxl_mem_probe(). cxl_mem_probe() calls devm_cxl_enumerate_ports()
> and attempts to discovery and create all the ports represent CXL switches.
> During this phase, a port is created per switch and the attached dports
> are also enumerated and probed.
> 
> The last phase is creating endpoint port which happens for all endpoint
> devices.
> 
> In this commit, the port create and its dport probing in cxl_acpi is not
> changed. That will be handled later. The behavior change is only for CXL
> switch ports. Only the dport that is part of the path for an endpoint
> device to the RP will be probed. This happens naturally by the code
> walking up the device hierarchy and identifying the upstream device and
> the downstream device.
> 
> The new sequence is instead of creating all possible dports at initial
> port creation, defer port instantiation until a memdev beneath that
> dport arrives. Introduce devm_cxl_create_or_extend_port() to centralize
> the creation and extension of ports with new dports as memory devices
> arrive. As part of this rework, switch decoder target list is amended
> at runtime as dports show up.
> 
> While the decoders are allocated during the port driver probe,
> The decoders must also be updated since previously it's all done when all
> the dports are setup and now every time a dport is setup per endpoint, the
> switch target listing need to be updated with new dport. A
> guard(rwsem_write) is used to update decoder targets. This is similar to
> when decoder_populate_target() is called and the decoder programming
> must be protected.
> 
> Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v8:
> - grammar and spelling fixups (Dan)
> - Clarify commit log story. (Dan)
> - Move register mapping and decoder enumeration to when first dport shows up (Dan)
> - Fix kdoc indentation issue with devm_cxl_add_dport_by_dev()
> - cxl_port_update_total_dports() -> cxl_probe_possible_dports(). (Dan)
> - Remove failure path for possible dports == 0. (Dan, Robert)
> - update_switch_decoder() -> update_decoder_targets(). (Dan)
> - Remove lock asserts where not needed. (Dan)
> - Add support for passthrough decoder init. (Dan)
> - Return -ENXIO when no driver attached. (Dan)
> - Move guard() from devm-cxl_add_dport_by_uport. (Dan, Robert)
> - Add devm_cxl_create_or_extend_port() helper. (Dan)
> - Remove shortcut for the port iteration path. Find better way to deal. (Dan, Robert)
> - Remove 'new_dport' local var. (Robert)
> - Use find_cxl_port_by_uport() instead of find_cxl_port(). (Robert)
> - Move port check logic to add_port_attach_ep(). (Robert)
> ---
>  drivers/cxl/core/cdat.c   |   2 +-
>  drivers/cxl/core/core.h   |   2 +
>  drivers/cxl/core/hdm.c    |   6 -
>  drivers/cxl/core/pci.c    |  81 +++++++++++
>  drivers/cxl/core/port.c   | 287 +++++++++++++++++++++++++++++++-------
>  drivers/cxl/core/region.c |   4 +-
>  drivers/cxl/cxl.h         |   3 +
>  drivers/cxl/port.c        |  29 +---
>  8 files changed, 331 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index c0af645425f4..b156b81a9b20 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -338,7 +338,7 @@ static int match_cxlrd_hb(struct device *dev, void *data)
>  
>  	guard(rwsem_read)(&cxl_rwsem.region);
>  	for (int i = 0; i < cxlsd->nr_targets; i++) {
> -		if (host_bridge == cxlsd->target[i]->dport_dev)
> +		if (cxlsd->target[i] && host_bridge == cxlsd->target[i]->dport_dev)
>  			return 1;
>  	}
>  
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 2669f251d677..2ac71eb459e6 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -146,6 +146,8 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  int cxl_ras_init(void);
>  void cxl_ras_exit(void);
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> +struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
> +					    struct device *dport_dev);
>  
>  #ifdef CONFIG_CXL_FEATURES
>  struct cxl_feat_entry *
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index cee68bbc7ff6..5263e9eba7d0 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -52,8 +52,6 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
>  int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>  {
>  	struct cxl_switch_decoder *cxlsd;
> -	struct cxl_dport *dport = NULL;
> -	unsigned long index;
>  	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>  
>  	/*
> @@ -69,10 +67,6 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>  
>  	device_lock_assert(&port->dev);
>  
> -	xa_for_each(&port->dports, index, dport)
> -		break;
> -	cxlsd->cxld.target_map[0] = dport->port_id;
> -

The change of initialization of cxlsd->cxld.target_map[] could have
been a separate patch to reduce size of this patch.

>  	return add_hdm_decoder(port, &cxlsd->cxld);
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, "CXL");
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b50551601c2e..b9d770f1aa7b 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -24,6 +24,44 @@ static unsigned short media_ready_timeout = 60;
>  module_param(media_ready_timeout, ushort, 0644);
>  MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
>  
> +/**
> + * devm_cxl_add_dport_by_dev - allocate a dport by dport device
> + * @port: cxl_port that hosts the dport
> + * @dport_dev: 'struct device' of the dport
> + *
> + * Returns the allocate dport on success or ERR_PTR() of -errno on error
> + */
> +struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,

This function only determines the port_num. How about only implement
this in a function cxl_pci_get_port_num() and call devm_cxl_add_dport
directly?

That would nicely fit into core/pci.c.

> +					    struct device *dport_dev)
> +{
> +	struct cxl_register_map map;
> +	struct pci_dev *pdev;
> +	u32 lnkcap, port_num;
> +	int type;
> +	int rc;
> +
> +	if (!dev_is_pci(dport_dev))
> +		return ERR_PTR(-EINVAL);
> +
> +	device_lock_assert(&port->dev);
> +
> +	pdev = to_pci_dev(dport_dev);
> +	type = pci_pcie_type(pdev);
> +	if (type != PCI_EXP_TYPE_DOWNSTREAM && type != PCI_EXP_TYPE_ROOT_PORT)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> +				  &lnkcap))
> +		return ERR_PTR(-ENXIO);
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		dev_dbg(&port->dev, "failed to find component registers\n");
> +
> +	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);

So, just return port_num instead.

> +	return devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
> +}
> +
>  struct cxl_walk_context {
>  	struct pci_bus *bus;
>  	struct cxl_port *port;
> @@ -1169,3 +1207,46 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
>  
>  	return 0;
>  }
> +
> +static int count_dports(struct pci_dev *pdev, void *data)
> +{
> +	struct cxl_walk_context *ctx = data;
> +	int type = pci_pcie_type(pdev);
> +
> +	if (pdev->bus != ctx->bus)
> +		return 0;
> +	if (!pci_is_pcie(pdev))
> +		return 0;
> +	if (type != ctx->type)
> +		return 0;
> +
> +	ctx->count++;
> +	return 0;
> +}
> +
> +int cxl_port_get_possible_dports(struct cxl_port *port)
> +{
> +	struct pci_bus *bus = cxl_port_to_pci_bus(port);
> +	struct cxl_walk_context ctx;
> +	int type;
> +
> +	if (!bus) {
> +		dev_err(&port->dev, "No PCI bus found for port %s\n",
> +			dev_name(&port->dev));
> +		return -ENXIO;
> +	}
> +
> +	if (pci_is_root_bus(bus))
> +		type = PCI_EXP_TYPE_ROOT_PORT;
> +	else
> +		type = PCI_EXP_TYPE_DOWNSTREAM;
> +
> +	ctx = (struct cxl_walk_context) {
> +		.bus = bus,
> +		.type = type,
> +	};
> +	pci_walk_bus(bus, count_dports, &ctx);

Don't walk the whole bus, just check children of port->uport_dev.

> +
> +	return ctx.count;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_get_possible_dports, "CXL");

See below for my comment on possible_dports.

Since we only check for count > 1 the implemntation could be
simplified and renamed to e.g. cxl_port_has_multiple_dports which
could easily be used to call devm_cxl_add_passthrough_decoder().

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 25209952f469..877f888ee8f5 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1367,21 +1367,6 @@ static struct cxl_port *find_cxl_port(struct device *dport_dev,
>  	return port;
>  }
>  
> -static struct cxl_port *find_cxl_port_at(struct cxl_port *parent_port,
> -					 struct device *dport_dev,
> -					 struct cxl_dport **dport)
> -{
> -	struct cxl_find_port_ctx ctx = {
> -		.dport_dev = dport_dev,
> -		.parent_port = parent_port,
> -		.dport = dport,
> -	};
> -	struct cxl_port *port;
> -
> -	port = __find_cxl_port(&ctx);
> -	return port;
> -}
> -
>  /*
>   * All users of grandparent() are using it to walk PCIe-like switch port
>   * hierarchy. A PCIe switch is comprised of a bridge device representing the
> @@ -1557,24 +1542,221 @@ static resource_size_t find_component_registers(struct device *dev)
>  	return map.resource;
>  }
>  
> +static int match_port_by_uport(struct device *dev, const void *data)
> +{
> +	const struct device *uport_dev = data;
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +	return uport_dev == port->uport_dev;
> +}
> +
> +/*
> + * Function takes a device reference on the port device. Caller should do a
> + * put_device() when done.
> + */
> +static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
> +{
> +	struct device *dev;
> +
> +	dev = bus_find_device(&cxl_bus_type, NULL, uport_dev, match_port_by_uport);
> +	if (dev)
> +		return to_cxl_port(dev);
> +	return NULL;
> +}
> +
> +static int update_decoder_targets(struct device *dev, void *data)
> +{
> +	struct cxl_dport *dport = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_decoder *cxld;
> +	int i;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;
> +
> +	cxlsd = to_cxl_switch_decoder(dev);
> +	cxld = &cxlsd->cxld;
> +	guard(rwsem_write)(&cxl_rwsem.region);
> +
> +	/* Short cut for passthrough decoder */
> +	if (cxlsd->nr_targets == 1) {

I think we should still check port_id. That is, remove the shortcut.
If nr_targets == 1, then interleave_ways should be one too, so you
gain nothing. Plus, you also see the dev_dbg().

> +		cxlsd->target[0] = dport;
> +		return 0;
> +	}
> +
> +	for (i = 0; i < cxld->interleave_ways; i++) {
> +		if (cxld->target_map[i] == dport->port_id) {
> +			cxlsd->target[i] = dport;
> +			dev_dbg(dev, "dport%d found in target list, index %d\n",
> +				dport->port_id, i);
> +			return 0;

Only one target exists, right? Stop the iteration by returning a
non-zero here (caller needs to be adjusted then).

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_decoders_dport_update(struct cxl_dport *dport)
> +{
> +	return device_for_each_child(&dport->port->dev, dport,
> +				     update_decoder_targets);

Might need changes if update_decoder_targets returns 1 to stop the
iterator.

> +}
> +
> +static int cxl_switch_port_setup(struct cxl_port *port)
> +{

Could you factor out that function in a separate patch?

The function only sets up decoders. Name it
cxl_switch_port_setup_decoders()?

> +	struct cxl_hdm *cxlhdm;
> +
> +	cxlhdm = devm_cxl_setup_hdm(port, NULL);
> +	if (!IS_ERR(cxlhdm))
> +		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
> +
> +	if (PTR_ERR(cxlhdm) != -ENODEV) {
> +		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
> +		return PTR_ERR(cxlhdm);
> +	}
> +
> +	if (port->possible_dports == 1) {
> +		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
> +		return devm_cxl_add_passthrough_decoder(port);

Imo, the possible_dports handling should be removed as it only
introduces dead code. mock_cxl_setup_hdm() always returns a valid
cxlhdm (unless for -ENOMEM) and the mock case never reaches this code
here.

So how about moving (the "real") devm_cxl_add_passthrough_decoder()
and cxl_port_get_possible_dports() to devm_cxl_enumerate_decoders()?
devm_cxl_add_passthrough_decoder() would be static then and
cxl_port_get_possible_dports() will be a core.h function only. Then,
mock_cxl_add_passthrough_decoder() could be removed too.

I really would like to have a clean core module interface that allows
an easy implementation of cxl_test and avoid too much impact to the
driver code.

> +	}
> +
> +	dev_err(&port->dev, "HDM decoder capability not found\n");
> +	return -ENXIO;
> +}
> +
> +DEFINE_FREE(put_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) reap_dport(_T))
> +static struct cxl_dport *cxl_port_get_or_add_dport(struct cxl_port *port,
> +						   struct device *dport_dev)
> +{
> +	struct cxl_dport *dport;
> +	int rc;
> +
> +	guard(device)(&port->dev);
> +
> +	if (!port->dev.driver)
> +		return ERR_PTR(-ENXIO);
> +
> +	dport = cxl_find_dport_by_dev(port, dport_dev);
> +	if (dport)
> +		return dport;

What is the case if there is already a dport bound to the port? Since
there is a 1:1 mapping downstream, there is only one allocation and I
would expect that dport never exists and an -EBUSY should be returned
otherwise.

> +
> +	struct cxl_dport *new_dport __free(put_cxl_dport) =
> +		devm_cxl_add_dport_by_dev(port, dport_dev);

See my comment on devm_cxl_add_dport_by_dev() above.

> +	if (IS_ERR(new_dport))
> +		return new_dport;
> +
> +	cxl_switch_parse_cdat(port);
> +
> +	/*
> +	 * First instance of dport appearing, need to setup the port, including
> +	 * allocating decoders.
> +	 */
> +	if (port->nr_dports == 1) {
> +		rc = cxl_switch_port_setup(port);

Can't this be done with port creation? I don't see a reason doing this
late at this point.

> +		if (rc)
> +			return ERR_PTR(rc);
> +		return no_free_ptr(new_dport);
> +	}
> +
> +	rc = cxl_decoders_dport_update(new_dport);
> +	if (rc)
> +		return ERR_PTR(rc);

Maybe unfold cxl_decoders_dport_update() here?

> +
> +	return no_free_ptr(new_dport);
> +}
> +
> +static struct cxl_dport *devm_cxl_add_dport_by_uport(struct device *uport_dev,
> +						     struct device *dport_dev)
> +{
> +	struct cxl_port *port __free(put_cxl_port) =
> +		find_cxl_port_by_uport(uport_dev);
> +
> +	if (!port)
> +		return ERR_PTR(-ENODEV);
> +
> +	return cxl_port_get_or_add_dport(port, dport_dev);
> +}

That function can be removed, see below.

> +
> +static struct cxl_dport *
> +devm_cxl_create_or_extend_port(struct device *ep_dev,
> +			       struct cxl_port *parent_port,
> +			       struct cxl_dport *parent_dport,
> +			       struct device *uport_dev,
> +			       struct device *dport_dev)
> +{
> +	resource_size_t component_reg_phys;
> +
> +	guard(device)(&parent_port->dev);
> +
> +	if (!parent_port->dev.driver) {
> +		dev_warn(ep_dev,
> +			 "port %s:%s disabled, failed to enumerate CXL.mem\n",
> +			 dev_name(&parent_port->dev), dev_name(uport_dev));
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	struct cxl_port *port __free(put_cxl_port) =
> +		find_cxl_port_by_uport(uport_dev);
> +
> +	if (!port) {
> +		component_reg_phys = find_component_registers(uport_dev);
> +		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
> +					 component_reg_phys, parent_dport);
> +		if (IS_ERR(port))
> +			return (struct cxl_dport *)port;
> +
> +		/*
> +		 * retry to make sure a port is found. a port device
> +		 * reference is taken.
> +		 */
> +		port = find_cxl_port_by_uport(uport_dev);
> +		if (!port)
> +			return ERR_PTR(-ENODEV);
> +
> +		dev_dbg(ep_dev, "created port %s:%s\n",
> +			dev_name(&port->dev), dev_name(port->uport_dev));
> +	}
> +
> +	return cxl_port_get_or_add_dport(port, dport_dev);
> +}
> +
>  static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  			      struct device *uport_dev,
>  			      struct device *dport_dev)
>  {
>  	struct device *dparent = grandparent(dport_dev);
>  	struct cxl_dport *dport, *parent_dport;
> -	resource_size_t component_reg_phys;
>  	int rc;
>  
>  	if (is_cxl_host_bridge(dparent)) {
> +		struct cxl_port *port __free(put_cxl_port) =
> +			find_cxl_port_by_uport(uport_dev);
>  		/*
>  		 * The iteration reached the topology root without finding the
>  		 * CXL-root 'cxl_port' on a previous iteration, fail for now to
>  		 * be re-probed after platform driver attaches.
>  		 */
> -		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
> -			dev_name(dport_dev));
> -		return -ENXIO;
> +		if (!port) {
> +			dev_dbg(&cxlmd->dev, "%s is a root dport\n",
> +				dev_name(dport_dev));
> +			return -ENXIO;
> +		}
> +
> +		/*
> +		 * While the port is found, there may not be a dport associated
> +		 * yet. Try to associate the dport to the port. On return success,
> +		 * the iteration will restart with the dport now attached.
> +		 */
> +		dport = devm_cxl_add_dport_by_uport(uport_dev,
> +						    dport_dev);

port is known here, use cxl_port_get_or_add_dport(port, dport_dev)
instead. Remove devm_cxl_add_dport_by_uport().

> +		if (IS_ERR(dport))
> +			return PTR_ERR(dport);
> +
> +		return 0;
>  	}
>  
>  	struct cxl_port *parent_port __free(put_cxl_port) =
> @@ -1584,36 +1766,12 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		return -EAGAIN;
>  	}
>  
> -	/*
> -	 * Definition with __free() here to keep the sequence of
> -	 * dereferencing the device of the port before the parent_port releasing.
> -	 */
> -	struct cxl_port *port __free(put_cxl_port) = NULL;
> -	scoped_guard(device, &parent_port->dev) {
> -		if (!parent_port->dev.driver) {
> -			dev_warn(&cxlmd->dev,
> -				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
> -				 dev_name(&parent_port->dev), dev_name(uport_dev));
> -			return -ENXIO;
> -		}
> +	dport = devm_cxl_create_or_extend_port(&cxlmd->dev, parent_port,
> +					       parent_dport, uport_dev,
> +					       dport_dev);

You expand add_port_attach_ep() here. This function was originally
called if there is no *port* at all. Now, as the dport_dev is not yet
registered, the port may already exist, but it is not found since the
dport_dev is not yet registered and add_port_attach_ep() is called now
even if the port exists. I think we should move that dport_dev
registration a level higher to devm_cxl_enumerate_ports(). That might
need a cleanup of the iterator and the removal of
add_port_attach_ep().

> +	if (IS_ERR(dport))
> +		return PTR_ERR(dport);
>  
> -		port = find_cxl_port_at(parent_port, dport_dev, &dport);
> -		if (!port) {
> -			component_reg_phys = find_component_registers(uport_dev);
> -			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
> -						 component_reg_phys, parent_dport);
> -			if (IS_ERR(port))
> -				return PTR_ERR(port);
> -
> -			/* retry find to pick up the new dport information */
> -			port = find_cxl_port_at(parent_port, dport_dev, &dport);
> -			if (!port)
> -				return -ENXIO;
> -		}
> -	}
> -
> -	dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
> -		dev_name(&port->dev), dev_name(port->uport_dev));
>  	rc = cxl_add_ep(dport, &cxlmd->dev);
>  	if (rc == -EBUSY) {
>  		/*
> @@ -1630,6 +1788,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  {
>  	struct device *dev = &cxlmd->dev;
>  	struct device *iter;
> +	int ports_need_create = 0;
>  	int rc;
>  
>  	/*
> @@ -1654,6 +1813,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  		struct device *uport_dev;
>  		struct cxl_dport *dport;
>  
> +		ports_need_create++;
> +
>  		if (is_cxl_host_bridge(dport_dev))
>  			return 0;
>  
> @@ -1688,10 +1849,28 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  
>  			cxl_gpf_port_setup(dport);
>  
> +			ports_need_create--;
>  			/* Any more ports to add between this one and the root? */
>  			if (!dev_is_cxl_root_child(&port->dev))
>  				continue;
>  
> +			/*
> +			 * The 'ports_need_create' variable tracks a port being
> +			 * created as it goes through this iterative loop. It's
> +			 * incremented when it first enters the loop and decremented
> +			 * when the port is found. If at the root of the hierarchy
> +			 * and the variable is not 0, then it's missing a port
> +			 * creation somewhere in the hierarchy and should restart.
> +			 * For example in a setup where there's a PCI root port, a
> +			 * switch, and an endpoint, it is possible to get to the
> +			 * PCI root port and its creation, and the switch port is
> +			 * still missing because the root port didn't exist. This
> +			 * triggers a restart of the loop to create the switch port
> +			 * now with a present root port.
> +			 */
> +			if (ports_need_create)

Uh, that becomes hard. Isn't the iterator much simpler:

 * Start the iter = endpoint.

 * Find first existing parent port up to the root.

 * If that is the direct parent of the endpoint, attach it to the
   parent (add dport etc.). Exit loop without errors.

 * Else, create port and attach it to the found parent port (including
   dport handling).

 * Fail on errors or retry otherwise.

So, devm_cxl_enumerate_ports() should be reworked better, also address
my other comments regarding add_port_attach_ep() and
devm_cxl_create_or_extend_port().

> +				goto retry;
> +
>  			return 0;
>  		}
>  
> @@ -1700,8 +1879,10 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  		if (rc == -EAGAIN)
>  			continue;
>  		/* failed to add ep or port */
> -		if (rc)
> +		if (rc < 0)
>  			return rc;
> +
> +		ports_need_create = 0;
>  		/* port added, new descendants possible, start over */
>  		goto retry;
>  	}
> @@ -1733,14 +1914,16 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>  	device_lock_assert(&port->dev);
>  
>  	if (xa_empty(&port->dports))
> -		return -EINVAL;
> +		return 0;
>  
>  	guard(rwsem_write)(&cxl_rwsem.region);
>  	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
>  		struct cxl_dport *dport = find_dport(port, cxld->target_map[i]);
>  
> -		if (!dport)
> -			return -ENXIO;
> +		if (!dport) {
> +			/* dport may be activated later */
> +			continue;
> +		}
>  		cxlsd->target[i] = dport;
>  	}

Should that be dropped entirely as the target setup is done somewhere
else?

>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 71cc42d05248..bba62867df90 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1510,8 +1510,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  				cxl_rr->nr_targets_set);
>  			return -ENXIO;
>  		}
> -	} else
> +	} else {
>  		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
> +		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
> +	}
>  	inc = 1;
>  out_target_set:
>  	cxl_rr->nr_targets_set += inc;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 87a905db5ffb..df10a01376c6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -591,6 +591,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @possible_dports: Total possible dports reported by hardware
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -612,6 +613,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	int possible_dports;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> @@ -911,6 +913,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c2);
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +int cxl_port_get_possible_dports(struct cxl_port *port);
>  
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index cf32dc50b7a6..941a7d7157bd 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -59,34 +59,17 @@ static int discover_region(struct device *dev, void *unused)
>  
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
> -	struct cxl_hdm *cxlhdm;
> -	int rc;
> +	int dports;
>  
>  	/* Cache the data early to ensure is_visible() works */
>  	read_cdat_data(port);
>  
> -	rc = devm_cxl_port_enumerate_dports(port);
> -	if (rc < 0)
> -		return rc;
> +	dports = cxl_port_get_possible_dports(port);
> +	if (dports < 0)
> +		return dports;
> +	port->possible_dports = dports;

As said, I think the whole possible_dports part can be removed.

Thanks,

-Robert

>  
> -	cxl_switch_parse_cdat(port);
> -
> -	cxlhdm = devm_cxl_setup_hdm(port, NULL);
> -	if (!IS_ERR(cxlhdm))
> -		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
> -
> -	if (PTR_ERR(cxlhdm) != -ENODEV) {
> -		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
> -		return PTR_ERR(cxlhdm);
> -	}
> -
> -	if (rc == 1) {
> -		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
> -		return devm_cxl_add_passthrough_decoder(port);
> -	}
> -
> -	dev_err(&port->dev, "HDM decoder capability not found\n");
> -	return -ENXIO;
> +	return 0;
>  }
>  
>  static int cxl_endpoint_port_probe(struct cxl_port *port)
> -- 
> 2.50.1
> 
