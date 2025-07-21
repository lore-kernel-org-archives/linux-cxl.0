Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C72236FD
	for <linux-cxl@vger.kernel.org>; Mon, 21 Jul 2025 23:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139654; cv=fail; b=h5bcJlXm0/VxyqhfG6m0FUqOwpw6khQCCHOlUT/LrL+5IyDWtRd4mIv4+nMxH+EbUtSapMKn+hvnfqW6WQpP4L5nfuP3nyBgKLhbgra6/sQ3fzo7bXJDkod5voHR+q3wziYZ5pgz7q7hkYL17c6f7BFuV43cGBhh1lLe3G4rgvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139654; c=relaxed/simple;
	bh=cLj/ss/9jDvWRCQkVzLCy1Ho5YoKYAqKj8HpW38hFeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sV4LlgugFZcqCtu5SUHv0FP4hWbHDnYrAzVnVLfMJGOnWH1OTRN+RuxxDyBMBf45wyRKHIlkt8jKkk8GPkS5IBVYO3GwqVKLIZJcPOsxdxfrMr75MEbz2UUscyw0DNvILFKinyto0zXfOh2E+vz6TLrBEVSLsRdgliwIyapMaJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l7AK/dJ4; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l7AK/dJ4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZ3LW9izrmdPjDDDKBpGM4O4pGn/M2nC20ngAyrnxIdJtP5VM7fcdiFXca/FelkG0QiL/z7hCmiKJy6Uu/4ge2p5sIBtJt1A7oC35S3N5o7IWjYQ3PkXzkHL6Ux9yXCiGcFlJUZSanIK4kA5bicYVpW/Nsx/H8hCF9DvCb7SWW9jq+mbUgYi6AXkSmK9vJlB7rJ1u2m4762hOnc3uKMWQncdmjbK0lQyeC8NWjfiTjs9VuhlqlfgJyk4yeq4opoVcplgJrBm6J5sv+x96IrIocZTNDD4NjWi5GgI6iPlPVYPZbPR69iXmvkrmr3Q+NUJ/HY6DTRTqTQtZTw4KF39Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRpIRqlgMyXK4sp8+AQs2OjaXVRh/YNIS9+UQHRznxw=;
 b=KHUAoN5vvCeNDJd2YVThdEx1x9WwYyj5KSACLJ528VtfOTOiHA+A5bIZzBNITvext4P6hej6Eoj4tmntXpL+OgBlIOm48mKFS7VDvtE6T8nY9xRiNGgxaya4ogLRNzfflcc/vwaylGsP1k6w0MG+l7R2AaeqWLtnSjwAS6DwwAemdS865mV9pnAIZpqWnVpEmwuQlhm8WOq0bUEgGANvxQan/IyfqBAM8JdrlVHHGfg1fuv2hYihIVyOXBLrMmMvKA1gB1hFSRTojaS2+E0RN7devUvT+Sv6JBo3wz62GFGiVvWl3s1baJa89YuxXYGiSFHAU59xIYyYk6U3QpLLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRpIRqlgMyXK4sp8+AQs2OjaXVRh/YNIS9+UQHRznxw=;
 b=l7AK/dJ4ACIa7ZY6dQSoxErdLST3fzJEm1c4kNYvnwwTmOjEogX25r9iF3FqcBEtZJ4wn+zDsuvjo5hyz7Vhao2YFDt+8+MOEpANBduZl2ZgQGcXpcjdCdQNXQqE59/hxqnAouS6qvoO1PFVxXuelU+DOgsnt3A/LbtlhMDaiis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CH3PR12MB9396.namprd12.prod.outlook.com (2603:10b6:610:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:14:09 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 23:14:09 +0000
Date: Tue, 22 Jul 2025 01:14:04 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v7 04/10] cxl: Defer dport allocation for switch ports
Message-ID: <aH7JvK-67RgV8fP0@rric.localdomain>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714223527.461147-5-dave.jiang@intel.com>
X-ClientProxiedBy: FR4P281CA0320.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::9) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CH3PR12MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b238c5-75e0-4103-5eae-08ddc8ac4c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5q14FvVugfibLbSausrLKL6VcwprIrNR34PsB9+asFxkEcZb6kTaLfrNUO+c?=
 =?us-ascii?Q?9GOlNOzic+LBYkPte5ps2xI19WaZArJAhTRk1CRoGoQplBn4GI8JBbGf5UIx?=
 =?us-ascii?Q?y+SuITYfP+R+8PXLP6gzoUT/CUSPlCvV+yjgcZMyU71Clvbwzx/dxVST92NY?=
 =?us-ascii?Q?USbnqaQaQ4IAi9NBxjE7zZB4kMb4qutpVlfcM4spcPJgvb3qk4Gg/aIwxsRg?=
 =?us-ascii?Q?55jM462Ndi41hASByAI3HWWe/031gTzq37PhtuNp7ByunBbvBUEjtYzBgNXK?=
 =?us-ascii?Q?fSWIUebIC1Hum1lbKenIvg6QDdcB0ZJiRUm1VAdZGLTf6kFXNa4KJvxweqU7?=
 =?us-ascii?Q?HGAp4mJOdrXw9+9QcJzMOLj/9RGKPD7E2yLPZLQz87wqcCKk9j1OTNXQynID?=
 =?us-ascii?Q?ObdpS9C1A+CUGAAHT7zfcAKGaWND5ND3AqjWyzIv7vlG7OBFtX2E594UFcQt?=
 =?us-ascii?Q?mZ0f7Ww6S/kmjdOGFEA9NZZ+u9RnyPztwISmidc9lpHzXymuEkkcZJmLaVlL?=
 =?us-ascii?Q?l9HVGc1AqgoZzX1gBQ4tb9ueVFZ7qO6Rm/CaTVLag9ltDiofMm1wj7EFjw/D?=
 =?us-ascii?Q?MwXAVyJwSg8cKpE66KUXJBUja/GAxcoYOGUto6IcL+l4FyoTMvIlFIgwr3BE?=
 =?us-ascii?Q?JeqoAd90qNwWG7IrqYZ92Xhk3Rq/HJNXwQkIdxJlXJbkCDHzrWxlEY9+tySx?=
 =?us-ascii?Q?LUtSdCHVHg1Cop1zOLUKw0JEQ8fHoBLqPysK77moQStMbyP/ZBOmRIBvMJKR?=
 =?us-ascii?Q?UxF8qouFvBqCah87K1+SWvmdGUYHnbbb/IGwgRgbNhkua9i5HStTI/7wmLjX?=
 =?us-ascii?Q?cdxSzxdgBzRWETXdjUbhk0ppOnNDqeamEzMeI5VuPSvyFaHLtGm/0qo5IMOR?=
 =?us-ascii?Q?t5cGiDp2PsYbVVcOjQ4AtzroJlolK4DCKaCzGoJ8/oZYo2IjDtH1O6Wu+Urr?=
 =?us-ascii?Q?0iCuLqc5S1xWhbXC2MQVX/rJEWUmcXHwlfXmFKz4EXfL5OEtr7m+SiYxAAhk?=
 =?us-ascii?Q?BRDaFIrcxi9/Kc33elBNRQLpnKLOvpUVaZ0n2Sd6QkC4R3dQGCtHCHWOnyqs?=
 =?us-ascii?Q?Ay3NVNXt/OaPxFZqYqKg4E0gLt8En6Y6oeK448jaauqiP3nL9GGgR6MzVm19?=
 =?us-ascii?Q?NPMZFBoe65KhLU6SUEVQmNtHOIlqkONfpI9bZMl/BEyyQ2weTFA7Syf0D8vK?=
 =?us-ascii?Q?iWISjwYLyaglWFwiDzDWJwcRvd0hjS1A+qWsVGoqsLUI1tsjl4hg/Y++yur6?=
 =?us-ascii?Q?PuTPum2JuIc1WdGYGCM0lyox05Rh29XJZClgdpbTVpBzJjdtS8W71Dk3DV4S?=
 =?us-ascii?Q?KevtDKhY7zU0pd5My+6p0rJ/CgS3JHaogD+MVT7++SBqlng8foWJSlhcG9ig?=
 =?us-ascii?Q?Ge48jJI9jSNc4xVReyRjPJy7rbfc/6eVjJn+wVB05D1l0GhrxPnE31/HmRoj?=
 =?us-ascii?Q?KtNbdNYcMs4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oy23cem7luTdPDyL+cTj2DaMH+hQa6WTS6nafsR/u27KBJN0IGuDM59fd3hF?=
 =?us-ascii?Q?d0+lR9UuUEdXct1qdULiHeMGg1OFfJBaadvZijjOIW9gndf+Jzt23bVp/H3E?=
 =?us-ascii?Q?92yQiSGpNh5MnelvwFKp9A0nKjEKIxuwpjZwRaufq0hhtD75gT6IztXTSNxJ?=
 =?us-ascii?Q?mqVpEzJMwMaeksNNbEGPlkNt8+LAHaZjrgKTLT5gfFry5+ONaON08asMf+TV?=
 =?us-ascii?Q?6jotz7WLw+hie9glogRSBfwz7HqEQvkZ+dZlllXV5D9T5SEXHgklxRHBhc0B?=
 =?us-ascii?Q?AP8qDkok00UB5Nzjbpcdgkw0I10eHOcaOqoxEtB4mOUzhwZmS6fKpv+9hMJv?=
 =?us-ascii?Q?yZ09Cks+m7MjJJ4mw0YSikthsyJj0Z7f8ZKU/cqkYrmxSsiGFmmc493OyeZk?=
 =?us-ascii?Q?MGO37P73onFoTnGEVqvFV8G/yB1oKu1W8C0i9Mjhio7ZGqGfUUQlkGW0892p?=
 =?us-ascii?Q?FW4QmYSP8GVyuVQh3lKxur/rwQXvDkdo/tfNNaKuxP+TCoOCg0KXLv1WZg11?=
 =?us-ascii?Q?gF23AyuM4uihkmnLLC2nCC+5xdkm8rrzMh4Bs6UL5dnL2E3nXQwEgss3BMd8?=
 =?us-ascii?Q?JDYZU/ShJHt1AG7L9c6JFoRRLF2oiSiX8Z4UsetPAfVEdm+lGjhzvH4EV1U/?=
 =?us-ascii?Q?XNhNlaxDmc2z9ijfNz+lZhAXmoqd/fHA2NMHVX0PB6hvftvxtxNRVG9msVTZ?=
 =?us-ascii?Q?pEj3g/cExutKU5KQH59DSjsVQe44DuRD7DbxDFpupYZOjiAZz+uva9JNmXpO?=
 =?us-ascii?Q?C49bmfQRMCiMhyFouhmYtzl6TFbW2h+RQWOFDlTRsw8lV3ubswk9910BOQwO?=
 =?us-ascii?Q?BsX3y12KV/rdk6mkuCcgxwMVaQUXI2G6MEVXFVL6WDAvw9wAwHIX9wi83cOp?=
 =?us-ascii?Q?wwbM13YipEgVQJrbw0RVEKMOikUqJzIkggJbT9m8Bx7oZ6yLdwumdkFvv4aI?=
 =?us-ascii?Q?BSEn1gZhDfn90EhCRYbbyxQKRCuPHz0y5F4mx5/gtutJ6h3qyKuXpEgkBKZr?=
 =?us-ascii?Q?hRroft3lwGJ8Z1cVi53qDX3mmw7XVLQuclGQA72YeN76wuxq6awndQOUsFUX?=
 =?us-ascii?Q?k5UmVfg8noUrzq6M2A20TsFJH3VAKDIR2BEM0l0UrsDfPELhEr0nXlIFAwcO?=
 =?us-ascii?Q?k1hWIbGF+nI1Sfq4u+TufzynRy+4lQJ82CEn9v2CjR2tqNJVwsPQtKquMAxm?=
 =?us-ascii?Q?AjXSDyUXecPID4v8OWETcpx9Pi8+KezIRmUsP8Yp2KkMnceUxurcOSa1GJlI?=
 =?us-ascii?Q?RAl/WQy7a5/SU3QS3c4KT3bOUOyjSQDXimpeCEwOLU3WnZ/uXRdYpVUWW7Yr?=
 =?us-ascii?Q?AQIADRN5oRmqFJ6rVGgnEkLeDov3xkvCYT3p3sxhLaBYgWXLJP6JyABGBkQE?=
 =?us-ascii?Q?oeMFd0l4niPKYAA/uBNHHr8zkzk8ad3DHKKztkeTeNjaibxzDikCY6VGYPjp?=
 =?us-ascii?Q?m0PE+ZE08g1Fd+7Rcg0Gmw+YDn5r8GX1QWfts3hCtu3ZF2KiJnZ5HsjwNn8Y?=
 =?us-ascii?Q?JWCKiswn92vfm9kgWU6v4aVwTRYMV6XngoddHd9Y3S9Qv1NbQGC/UuHJMNY3?=
 =?us-ascii?Q?fjn7avhS85doJIrlaQDwKTx5LEjb5tMGINo/kIgP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b238c5-75e0-4103-5eae-08ddc8ac4c1a
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:14:09.7402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3B6YCpOLy1AC4HjDKEYxOXN69osoh3eXBNB5ERiyDOe/iXks9nKdeelwgoIW0IbBWeSO2fKRPBinwcsyjylE5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9396

Hi Dave,

see inline.

On 14.07.25 15:35:21, Dave Jiang wrote:
> The current implementation enumerates the dports during the cxl_port
> driver probe. Without an endpoint connected, the dport may not be
> active during port probe. This scheme may prevent a valid hardware
> dport id to be retrieved and MMIO registers to be read when an endpoint
> is hot-plugged. Move the dport allocation and setup to behind memdev
> probe so the endpoint is guaranteed to be connected.
> 
> In the original enumeration behavior, there are 3 phases (or 2 if no CXL
> switches) for port creation. cxl_acpi() creates a Root Port (RP) from the
> ACPI0017.N device. Through that it enumerate downstream ports composed
> of ACPI0016.N devices through add_host_bridge_dport(). Once done, it
> use add_host_bridge_uport() to create the ports that enumerates the PCI
> RPs as the dports of these ports. Every time a port is created, the port
> driver is attached and drv->probe() is called and
> devm_cxl_port_enumerate_dports() is envoked to enumerate and probe
> the dports.
> 
> The second phase is if there are any CXL switches. When the pci endpoint
> device driver (cxl_pci) calls probe, it will add a mem device and triggers
> the cxl_mem->probe(). cxl_mem->probe() calls devm_cxl_enumerate_ports()
> and attempts to discovery and create all the ports represent CXL switches.
> During this phase, a port is created per switch and the attached dports
> are also enumerated and probed.
> 
> The last phase is creating endpoint port which happens for all endpoint
> devices.
> 
> In this commit, the port create and its dport probing in cxl_acpi is not
> changed. That will be handled in a different patch later on. The behavior
> change is only for CXL switch ports. Only the dport that is part of the
> path for an endpoint device to the RP will be probed. This happens
> naturally by the code walking up the device hierarchy and identifying the
> upstream device and the downstream device.
> 
> There are two points where the interception of dport creation happens
> during the devm_cxl_enumerate_ports() path. The first location is right
> before the function calls add_port_attach_ep() where it does the dport
> allocation for the RP. Once the dport is allocated, the iteration path
> is reset to the beginning to try again. The second location happens
> in add_port_attach_ep() after the location where either the port is
> discovered or allocated new if it does not exist.
> 
> Locking of port device during __cxl_port_add_dport() protects modifications
> against the port and its dports while multiple endpoints can be probing at
> the same time and the same port is being modified concurrently.
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
> v7:
> - Return dport instead of -EEXIST (Ming)
> - Remove extra goto retry (Ming)
> ---
>  drivers/cxl/core/core.h |   2 +
>  drivers/cxl/core/pci.c  |  88 +++++++++++++++++++
>  drivers/cxl/core/port.c | 185 ++++++++++++++++++++++++++++++++++++----
>  drivers/cxl/cxl.h       |   5 ++
>  drivers/cxl/port.c      |   8 +-
>  5 files changed, 267 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 29b61828a847..8cfead6f3b08 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -122,6 +122,8 @@ void cxl_ras_exit(void);
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>  int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>  					    int nid, resource_size_t *size);
> +struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
> +					    struct device *dport_dev);
>  
>  #ifdef CONFIG_CXL_FEATURES
>  struct cxl_feat_entry *
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b50551601c2e..336451b9144a 100644
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
> +	return devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
> +}
> +
>  struct cxl_walk_context {
>  	struct pci_bus *bus;
>  	struct cxl_port *port;
> @@ -1169,3 +1207,53 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
>  
>  	return 0;
>  }
> +
> +static int match_dport(struct pci_dev *pdev, void *data)

count_dports()?

> +{
> +	struct cxl_walk_context *ctx = data;
> +	int type = pci_pcie_type(pdev);

The compiler might optimize this, but better place this after
pci_is_pcie(). The local variable could be omitted.

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
> +int cxl_port_update_total_dports(struct cxl_port *port)

I would prefer to name this cxl_pci_count_dports() or so (if the need
this at all, see below).

> +{
> +	struct pci_bus *bus = cxl_port_to_pci_bus(port);
> +	struct cxl_walk_context ctx;
> +	int type;
> +
> +	if (!bus) {
> +		dev_err(&port->dev, "No PCI bus found for port %s\n",
> +			dev_name(&port->dev));
> +		return -ENXIO;

This is not an error, the switch port could be non-pci. I think you
should add a pci check in front of this and early exit with 0 then.
This emphasizes also the cxl_pci_*() naming.

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
> +	pci_walk_bus(bus, match_dport, &ctx);

match_dport() should be named count_dports().

> +
> +	port->total_dports = ctx.count;
> +	if (port->total_dports == 0) {
> +		dev_warn(&port->dev, "No dports found for port %s on bus %s\n",
> +			 dev_name(&port->dev), bus->name);
> +		return -ENXIO;

This isn't an error either, there just could be no dports online.

Why do you count this at all? An empty number of dports is possible
and not an error.

I see, you are using total_dports only to setup passthrough
decoders. I think we should allow to setup the first dport with a
passthrough decoder if cxlhdm->decoder_count of the port is zero, but
later fail if a 2nd dport is found.

> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_update_total_dports, "CXL");
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 9691da831224..c1de6872e57f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1551,6 +1551,116 @@ static resource_size_t find_component_registers(struct device *dev)
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
> +static int update_switch_decoder(struct device *dev, void *data)
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
> +	guard(rwsem_write)(&cxl_region_rwsem);
> +	for (i = 0; i < cxld->interleave_ways; i++) {
> +		if (cxlsd->target_map[i] == dport->port_id) {
> +			cxlsd->target[i] = dport;
> +			return 0;
> +		}
> +	}
> +
> +	dev_dbg(dev, "Updating decoder target_map with %s and none found\n",
> +		dev_name(dport->dport_dev));

I that message really needed for debugging? It does not seem an error
to me. The success path is much more interesting, e.g.:

   	dev_dbg(dev, "dport%d found in target list, index %d\n", ...);

> +
> +	return 0;
> +}
> +
> +static int update_decoders_with_dport(struct cxl_port *port, struct cxl_dport *dport)
> +{
> +	device_lock_assert(&port->dev);

Already checked in cxl_port_setup_with_dport().

> +	return device_for_each_child(&port->dev, dport, update_switch_decoder);

Can be squashed into cxl_port_setup_with_dport().

update_target_map() 

> +}
> +
> +static int cxl_port_setup_with_dport(struct cxl_port *port,
> +				     struct cxl_dport *dport)
> +{

Argument port can be removed, it is dport->port.

> +	device_lock_assert(&port->dev);
> +
> +	cxl_switch_parse_cdat(port);
> +
> +	return update_decoders_with_dport(port, dport);
> +}
> +
> +static struct cxl_dport *devm_cxl_port_add_dport(struct cxl_port *port,

The name is misleading as an existing dport could be reused. Name it
cxl_port_get_dport()?

> +						 struct device *dport_dev)
> +{
> +	struct cxl_dport *dport;
> +	int rc;
> +
> +	device_lock_assert(&port->dev);

Why don't you move guard() here?

> +
> +	/* Port driver not attached yet, wait for cxl_acpi reprobe */
> +	if (!port->dev.driver)
> +		return ERR_PTR(-ENODEV);
> +
> +	dport = cxl_find_dport_by_dev(port, dport_dev);
> +	if (dport)
> +		return dport;
> +
> +	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
> +	if (IS_ERR(dport))
> +		return dport;
> +
> +	rc = cxl_port_setup_with_dport(port, dport);

With the removal of the port arg this could be:

	rc = cxl_dport_update_target_maps(dport);


That could be moved to devm_cxl_add_dport() along with the cleanup
below.

> +	if (rc) {
> +		reap_dport(port, dport);

Same here port, could be removed from the arg list.

> +		return ERR_PTR(rc);
> +	}
> +
> +	return dport;
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
> +	guard(device)(&port->dev);
> +	return devm_cxl_port_add_dport(port, dport_dev);
> +}
> +
>  static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  			      struct device *uport_dev,
>  			      struct device *dport_dev)
> @@ -1584,6 +1694,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  	 */
>  	struct cxl_port *port __free(put_cxl_port) = NULL;
>  	scoped_guard(device, &parent_port->dev) {
> +		struct cxl_dport *new_dport;

Why don't you use dport directly?

> +
>  		if (!parent_port->dev.driver) {
>  			dev_warn(&cxlmd->dev,
>  				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
> @@ -1592,6 +1704,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		}
>  
>  		port = find_cxl_port_at(parent_port, dport_dev, &dport);

That call could be removed as the find_cxl_port_by_uport() will find
it.

> +		if (!port)
> +			port = find_cxl_port_by_uport(uport_dev);
>  		if (!port) {
>  			component_reg_phys = find_component_registers(uport_dev);
>  			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
> @@ -1599,11 +1713,21 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  			if (IS_ERR(port))
>  				return PTR_ERR(port);
>  
> -			/* retry find to pick up the new dport information */
> -			port = find_cxl_port_at(parent_port, dport_dev, &dport);
> -			if (!port)
> -				return -ENXIO;
> +			/*
> +			 * The port holds a device reference via find_cxl_port_at()
> +			 * if the port is valid. But if the port is newly created
> +			 * via devm_cxl_add_port(), no reference is held. Therefore
> +			 * the driver needs to get a device reference here.
> +			 */
> +			get_device(&port->dev);

I would prefer the retry approach that would use
find_cxl_port_by_uport() here.

>  		}
> +
> +		guard(device)(&port->dev);
> +		new_dport = devm_cxl_port_add_dport(port, dport_dev);

I first thought, how do you ensure that dport was not yet added to
port already. But then saw the function that does something else. It
should be renamed.

> +		if (IS_ERR(new_dport))
> +			return PTR_ERR(new_dport);
> +
> +		dport = new_dport;
>  	}
>  
>  	dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
> @@ -1620,11 +1744,14 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  	return rc;
>  }
>  
> +#define CXL_ITER_LEVEL_SWITCH	1
> +
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  {
>  	struct device *dev = &cxlmd->dev;
> +	struct device *dgparent;
>  	struct device *iter;
> -	int rc;
> +	int rc, i;
>  
>  	/*
>  	 * Skip intermediate port enumeration in the RCH case, there
> @@ -1643,7 +1770,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  	 * attempt fails.
>  	 */
>  retry:
> -	for (iter = dev; iter; iter = grandparent(iter)) {
> +	for (i = 0, iter = dev; iter; i++, iter = grandparent(iter)) {
>  		struct device *dport_dev = grandparent(iter);
>  		struct device *uport_dev;
>  		struct cxl_dport *dport;
> @@ -1686,16 +1813,39 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  			if (!dev_is_cxl_root_child(&port->dev))
>  				continue;
>  
> +			/*
> +			 * This is a corner case where the rootport is setup but

"root port"

> +			 * the switch dport is not. It needs to go back to the
> +			 * beginning to setup the switch port.
> +			 */
> +			if (i >= CXL_ITER_LEVEL_SWITCH) {

Even after reading your comment I still don't know what
"CXL_ITER_LEVEL_SWITCH" means nor why this is a magic 1 ...

> +				struct cxl_port *pport __free(put_cxl_port) =
> +					cxl_mem_find_port(cxlmd, &dport);
> +				if (!pport)
> +					goto retry;

... and why retrying all this until dport is found for cxlmd all
solves this. Could this end up in an infinite loop?

I think that means if i > 0 (the root port is not found with the first
attempt) then there must be a switch port between EP and root port.

A better check would be:

	if (dev != &cxlmd->dev)
		...

It looks like there is no dport yet for cxlmd. Could you explain this?


> +			}
> +
>  			return 0;
>  		}
>  
> -		rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
> -		/* port missing, try to add parent */
> -		if (rc == -EAGAIN)
> -			continue;
> -		/* failed to add ep or port */
> -		if (rc)
> -			return rc;
> +		dgparent = grandparent(dport_dev);
> +		/* Only go down this path if we are at the root port */
> +		if (is_cxl_hierarchy_head(dgparent)) {
> +			dport = devm_cxl_add_dport_by_uport(uport_dev,
> +							    dport_dev);
> +			/* Added a dport, restart enumeration */
> +			if (IS_ERR(dport))
> +				return PTR_ERR(dport);

Move that check to add_port_attach_ep() and return early.

But, you could move that block to the check above at the beginning of
the loop before returning 0.

I don't see much sense in the is_cxl_hierarchy_head() helper. It is
used only in this function and possibly can reduced to the one already
existing check.

Please explain why that path is different? Isn't uport_dev attached to
a root port here and can't the dports just be added on creation?

> +		} else {
> +			rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
> +			/* port missing, try to add parent */
> +			if (rc == -EAGAIN)
> +				continue;
> +			/* failed to add ep or port */
> +			if (rc)
> +				return rc;
> +		}
> +
>  		/* port added, new descendants possible, start over */
>  		goto retry;
>  	}
> @@ -1727,16 +1877,19 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>  		return 0;
>  
>  	device_lock_assert(&port->dev);
> +	memcpy(cxlsd->target_map, target_map, sizeof(cxlsd->target_map));
>  
>  	if (xa_empty(&port->dports))
> -		return -EINVAL;
> +		return 0;
>  
>  	guard(rwsem_write)(&cxl_region_rwsem);
>  	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
>  		struct cxl_dport *dport = find_dport(port, target_map[i]);
>  
> -		if (!dport)
> -			return -ENXIO;
> +		if (!dport) {
> +			/* dport may be activated later */
> +			continue;
> +		}
>  		cxlsd->target[i] = dport;

Could the target map update here be removed at all as that is also
done in the new function update_switch_decoder()?

>  	}
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3f1695c96abc..de7883747555 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -403,6 +403,7 @@ struct cxl_endpoint_decoder {
>   * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
>   * @cxld: base cxl_decoder object
>   * @nr_targets: number of elements in @target
> + * @target_map: map of target dport ids to interleave positions
>   * @target: active ordered target list in current decoder configuration
>   *
>   * The 'switch' decoder type represents the decoder instances of cxl_port's that
> @@ -414,6 +415,7 @@ struct cxl_endpoint_decoder {
>  struct cxl_switch_decoder {
>  	struct cxl_decoder cxld;
>  	int nr_targets;
> +	int target_map[CXL_DECODER_MAX_INTERLEAVE];
>  	struct cxl_dport *target[];
>  };
>  
> @@ -584,6 +586,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @total_dports: total possible dports in this port
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -604,6 +607,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	int total_dports;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> @@ -902,6 +906,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c2);
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +int cxl_port_update_total_dports(struct cxl_port *port);
>  
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index fe4b593331da..ee7dcd7c4f24 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -65,12 +65,10 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	/* Cache the data early to ensure is_visible() works */
>  	read_cdat_data(port);
>  
> -	rc = devm_cxl_port_enumerate_dports(port);
> -	if (rc < 0)
> +	rc = cxl_port_update_total_dports(port);
> +	if (rc)
>  		return rc;
>  
> -	cxl_switch_parse_cdat(port);
> -
>  	cxlhdm = devm_cxl_setup_hdm(port, NULL);
>  	if (!IS_ERR(cxlhdm))
>  		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
> @@ -80,7 +78,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  		return PTR_ERR(cxlhdm);
>  	}
>  
> -	if (rc == 1) {
> +	if (port->total_dports == 1) {

See my comment above on enabling a passthrough decoder.

Removing total_dports would simplify the implementation.

>  		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
>  		return devm_cxl_add_passthrough_decoder(port);
>  	}
> -- 
> 2.50.0
> 

-Robert
