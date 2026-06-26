Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811DA3E6DEC;
	Fri, 26 Jun 2026 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782465431; cv=fail; b=rwaTyuGnwaa1aQJhZ8f5xcJQMDEUOZv5MJ2tuX5BqFlSDfBUyfeSHb2jj/cn7+oPt8tQj2UNQvnBg+ewRXRJ2uWHtLv2HcHEMU6Yi+vnudHCGeXukWin1wQKr+T49P/uqLs9trFORwrGXhgSzvTn5XfiMih7Ut2qQ3U2MBwQ9Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782465431; c=relaxed/simple;
	bh=WrWgfIjmaUL1FLDCJXpoI51sMk7kppNa0kjpqa/xp5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y7xVeR4q+KYCthAtoDgnSBfSH2WGXD3GG9FxUXvkKYqv5+APertQrDeoKR/Cihvf2LSgntdzhW0UIO64IfOta4ESmw3L8qqjNK1HgBy/diVOeGjiITP+uqW9O1MNqx5mPKgSZB+DD1sMjYYfE+S6jdLGjUD2YNr9uT2IdjaT+y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dUy+O54E; arc=fail smtp.client-ip=40.93.198.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dUy+O54E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhHbuU+2+cvTCZi28wzNQr2JEP52jnu86dfqoDPxKU7fRBXjYQiwruKrNZwyptU/Ul6fQYwBL/PNOq3IjC4e9ETXNuqb2lJL1OaZnd0awr0KCJE2tluKnTi8UAJXL2VHqTWSccTaYCOQiA+LulPLyPAimeccVlwmnU/Dh0Rrb4iyZP3gbeU6Qn5kS9T7C+iIC2uRJYN+kBZIBzDq+1yrdsUyG9fMqfSkeXYUBafIXA09EOKf2gzPlebx+/teh2REVovR4i8hZV8+z/jHPN6Yzx4MqI+Q3Zkmingd6hKlatb9nhjZA8nWyxxuvRUgTjP4TLEjsvg9Zc30D3t4boQlxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=It2vxpV5tuUSX64XLFGFpl5PjY+X888yKrGOl5QpCNs=;
 b=c6v+6ChrZJgXjUtslbbLtFQ4TsabQutzNd48t8RDdE9UFjnNFDrPIKYUdZl3A83saunmEXfuiycF1lqSq2Q0XG9iJmZ0aEjCUy2jUt7g5QfymdDUCzfEd7062AxQiAGFa29SOLgxTNDJz8FMHAMrf7bwBzzB6ReYf3d7saemVlC80YPz6YaLnVhVklWVTspW7OnBirRQDCXmVdpJff5S55rFCff3lLxlR89wnbG+gXaQ6jzG7S92mSgn+EzkjSEQhk6GcdKWpahzxHwgcJ5xVh4/N4N7QnyPKytaB2ARbc1+b7LrbIemvEfsV8vktpFSPDYba7iAASbkezD3a2YsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=It2vxpV5tuUSX64XLFGFpl5PjY+X888yKrGOl5QpCNs=;
 b=dUy+O54EsPIunB+2wVjKxKNiDfMHVkbevE0tLf96a7Sm0WB75GQKa9m29fRB+umnXtpp1kd7WSdCFbo+cQbonCwZDO1R5iuRiRouJe5HTzoz3aJJxhcLHof1pKe6EmDugPcHRmssjRe/1wbvT/YvrbClNIyHwbXTVcG+ixGNm4MpnYVw9K9oXTvAqziokckPAdGup6sCcYet2lf4WUNpZTceHoqhRXGga1dfAqOu/6en/t51CTORrw1im6VosL5dZOhfk7IWaly2pCS+xvjPFv7fqAahkQy5AEIwgyWQVTlHN10b7qGS5PKhi2oUpz1XnRyDqh9ZNd5nNQpyMp3xJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Fri, 26 Jun
 2026 09:17:01 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.018; Fri, 26 Jun 2026
 09:17:01 +0000
Date: Fri, 26 Jun 2026 17:16:54 +0800
From: Richard Cheng <icheng@nvidia.com>
To: mhonap@nvidia.com
Cc: djbw@kernel.org, alex@shazbot.org, jgg@ziepe.ca, jic23@kernel.org, 
	dave.jiang@intel.com, ankita@nvidia.com, alejandro.lucero-palau@amd.com, 
	alison.schofield@intel.com, dave@stgolabs.net, dmatlack@google.com, gourry@gourry.net, 
	ira.weiny@intel.com, cjia@nvidia.com, kjaju@nvidia.com, vsethi@nvidia.com, 
	zhiw@nvidia.com, kvm@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 00/11] vfio/pci: Add CXL Type-2 device passthrough
 support
Message-ID: <aj5Brc9beJhsDdJr@MWDK4CY14F>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625165407.1769572-1-mhonap@nvidia.com>
X-ClientProxiedBy: TPYP295CA0039.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2fb675-b7d8-4660-dee8-08ded363ad76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|5023799004|11063799006|22082099003|56012099006|6133799003|18002099003|3122999024|3023799007;
X-Microsoft-Antispam-Message-Info:
	oaCSahkhLJc0uriOuHjOt1RkGg2dHaksbcgpr3/ILYFR84ChJFY7lo4qG5P79o3T7kDEhpNgvPihG2cHZVZvmLhqVIYIOL0lcZ/UflsXhAK5iy1x0aUapGUZnk7AkKvVtsyUHTW2i3/oQTuZdCP8u2CpBmgr7QlMYUeyb6NPhZ3d1Pk0i4DkOrUK/qKG1fFirrSv8/NwA4D0gRv8fFcjYD9Haro0Rc4vtt1U8l+uayBMdqfLE7Q0v+OntmPeLWIsLOuc5ExBeEyVW9yBvapcCX/e3tqpttbBXLTyvxZ5xjzAayksDva30+kWb+NSuIVHZqcv8XEtCbeEDiEX7g9QgasJLSGZr+Zcr/DoH9I2tlKWfM8wuBBmCPaMITH0gcDctQEKh9o8vMW7N7jMqKJoK9VmJF+r2pTNlyGBy5zRkwOmawfMooJeu9kqkJuJndhz2epcKN/TmGmckv9hi2klUqBx4fklKogY61RKh8Xb6gvRVApR0Dfmapt0F5C6M6ktZNLz7ERh5EH78KKi36DjzYxkPGo/SrLx2o2bc09Plj3WlqBEyF6WMgqTn3UCV0R4Pn9piXYh4RnpqJfxl/X73igIDP7glZq9WQH+QQty5RaOb/cCIkE9Pl/rjF8BSe/AMm0GPXVOcLUIOTm9AHE4D3lkayN37JFAwQ8Uh3BHPIU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(5023799004)(11063799006)(22082099003)(56012099006)(6133799003)(18002099003)(3122999024)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUpQRVlncDdEQnVUMmZHcWVOUnk4K3dwK3JhUi8wQ3hGS2xTOXFObUZuWmg4?=
 =?utf-8?B?VU1yK2V3NW5kK1FEKzhoZUFSR0ErS3I3SDN2M2dQUkxrQTJoNWx1ZXovQzBH?=
 =?utf-8?B?eFRDK0tON3R1OU51NGptMjV4WHRDbGFLd0QxbVhDYmc1OE9NcUVkZzdIVDZm?=
 =?utf-8?B?Z0kwSWZpVVU5R3p0ZkpJOStGSTFsMHFlT1VVZzUzMThTVHU4dFI4WFl6WSt2?=
 =?utf-8?B?Mm5keitaTzhJK0dPdnhib29Va0FzcmNrRmVKak8zK01teGVMOStwTVVqZGx2?=
 =?utf-8?B?Skpta0gwZFJhRXJpOGJwRVEwNHJENXk4Z2p3SkZ2K0lGLytRcENqdGQ3NFlR?=
 =?utf-8?B?blVEaE1XTXpMS0djRlFiaUZnYzVHK0M3MW5HVHpZS3hZbGxzZ0w4WGpySitP?=
 =?utf-8?B?UnM3eldFSlFyU2ZsbDl1Z2VrczRtc3huMDlSL2lScWtxaXlYZHEvblpHNlJk?=
 =?utf-8?B?NnB1WGpHNzk2OEJzMWVGMDVTa2duVFBVTWE2b2xOSXhpYTJGUUxrc2NBTUNE?=
 =?utf-8?B?UnhqdldNMWZHd2ZzVFMxRDM2UWJFcUw5d2phNlNEZGwyN2ZpbjkyenpuTlVp?=
 =?utf-8?B?TmtLeTV0d3Z2Yzd3R1Z6QTdUejRHb3g4TkVFWUJaM0ZWa2JaaitVWHNzY3E4?=
 =?utf-8?B?NWpDb0lvYlpZQzlEd0RBcFp4WHpnVytxbUYzajZ5RkMvaWUvcVcvcFh6Q3VS?=
 =?utf-8?B?U01VOTNRQ0FrZmpJU3RKcmcyQXRQck5WcnVHbkJ6RGJDZmJTS1lLUGM3QjB6?=
 =?utf-8?B?K1J0aDB0VW9pSnB3alhaQTBLTjRGWDlPOFNVeDZUQXlqWm5rOGVmTXB5ZVl3?=
 =?utf-8?B?NkFzN08rQ2ZaTG4vMGp3OGJYM29xTHlhNXpBSCtIWWdQbXgvN3ZTMkpwMHVH?=
 =?utf-8?B?dm5aMkdrQkw2anArSGJTK1A4ZnFveGtob0JwT2ZabWVRcldpc2RKMXlaVm9n?=
 =?utf-8?B?bmdQdkcxVmF2T1JCL2RZc3BJOUFDSkhaQnZLK0ZzNEpuYnBTemg2eUhJN2Qz?=
 =?utf-8?B?L0h0ZEJtQzllL2Y0eW4xcFFlWng5UXhwakpUOWViK2I3RWVBVGwyd25hdlN5?=
 =?utf-8?B?b1krMVlRKzh4QmIrKy9kL0tTSzRZa2YwRjJWb21YZk5CTDVwanAyeWZoRSs2?=
 =?utf-8?B?T205dGZmMHNkTjZzNWpRQ2w3ckhFQTYwQ1hqN05KS1llLzB3QU45ZWdtdzRq?=
 =?utf-8?B?YlJOSXNOZUp2TGZ6czhjUWRVSE96OFY3VVFPOFQ2YkgxWUxRWk1haE50dWx4?=
 =?utf-8?B?UnZUVHREWStKVktheXBkZTZqS3RQb3FxM1o3U3RQTFh1U2pnNlN0Sm9uYWdP?=
 =?utf-8?B?aEpwc3c1YzNKNlExclZRNGdjT2orcVNpTW1FUngzbTE5QysybDJWdTl5T2Yv?=
 =?utf-8?B?SkxPZE05eDJXNWJ4WDlGckRXYXZiV3M1WmdCSm9LMWlZMkNMOG9ydWZQYXBy?=
 =?utf-8?B?NjlOdVg3ejZlS0tWU3pBMFJRak9INHE2VExtTTNRQzRWdUFFbldheHBXU0ln?=
 =?utf-8?B?MjRYVjFCblk5UWFmWmFSeEtsanVLQXk2R0tWSUIrVDFuQ283UEliQW1CM3lX?=
 =?utf-8?B?NjdVOHVqTGdacU43YkoyWVgwWU9Dc09DanlSam5CT05rRFJkMk1XOE1NbHZZ?=
 =?utf-8?B?WGdWVTQzaThGYkxMSFFlcHcxZnpTRktUNHZqSWhHcHpaZTRzRDNPSitvelor?=
 =?utf-8?B?MVFIVTZMWkpPQ2U4cEJ5S295aEs2RW9PazFndGQyc0ZlS2tNRm5jTHM1K2Za?=
 =?utf-8?B?aVV2bFlNQjNsOXRYRmloVlliMmw4V1dNdWJ2V09sTTBVMXpQQUZUckxGY1d6?=
 =?utf-8?B?K0ZGKy8vdWRGR0h0dmZUeFBtQ2F4UnBkK3d4RCtNTEcwbFU3QkJSRmFnY056?=
 =?utf-8?B?dWlWREJhL3NPSmVzeksxSit6V0V2TkF2a3h4cWwzWWlmZHlmZTc2UlZ3bFRw?=
 =?utf-8?B?K3ZXSWgxS2swZTVTeWRXU0diaEkyNFRZdGJOVnZ6NjMxWmdud1A3czlBYlF0?=
 =?utf-8?B?RmlrWEIwMHJNSCtiWTl2d2RkTzRIbUJyVGYvb05IazJaeHNrUVRHUDAvcFRP?=
 =?utf-8?B?dDFiVmZnamVrc2RkMDAxNDNSVUxYWFJwOVFQbzlWdU1vS2JabzBHSGtSaXYw?=
 =?utf-8?B?blVtbWVBbTlmNU40Qnc2NXlWcW1rODhJVFdkLzhUZ2RQZGhSeUdab0o5ejMv?=
 =?utf-8?B?elRzd1A2RmVhNGcwZ21rZEw4YW5CMEduM1orMWMxV0hyOW1UdXMxMnJ4MkdH?=
 =?utf-8?B?MHpWYjNzVHI4SWpzUzNGM0QwdElwa1ZRbDJDNTVHZ0lwendTYVVtZmFoSlNS?=
 =?utf-8?B?YWt1V3VxU3JraVRGcHIrdnZJcXFiZ2xIeXRzZnA4d2tTSzJqZG1FUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2fb675-b7d8-4660-dee8-08ded363ad76
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:17:01.0244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zUXSmiH/q0W9JOaxCM1xo75gS28J9czhujl8Wnzto4WbyZvkJY+HSzT1DxxN0JOnUNgC+mDHlhNcKRWO4aV6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677

On Thu, Jun 25, 2026 at 10:23:56PM +0800, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> CXL Type-2 accelerators (CXL.mem-capable GPUs and similar) cannot be
> passed through to virtual machines with stock vfio-pci because the
> driver has no concept of HDM decoder management, HDM region exposure,
> or component register virtualization.  This series adds those three
> pieces, sufficient for a guest to use the device's firmware-committed
> coherent memory under UVM / ATS.
> 
> v3 is a rewrite of the v2 framework form, responding to Dan's request
> in the v2 review for "less emulation, narrower interfaces, and a
> closer mapping to the spec language."
> In this release, cxl-core exposes four EXPORT_SYMBOL_GPL helpers behind
> an opaque handle.  vfio-pci becomes a thin transport on top of those.
> Please see "Changes since v2" and "Reviewer feedback addressed" below for
> the per-area summary.
>

Hi Manish,

Thanks for the work, I ran some test with your patches applied on a real
CXL type-2 device, it's a GPU with a FW-committed HDM decoder. I want to
report the result early, the acquire path works, but the first CPU access
to the mapped HDM region crash the host.

So device BDF is 0002:81:00.0 , with CXLCtl: Cache+ IO+ Mem+, HDM decoder firmware-committed.

Binding the device to vfio-pci brought the CXL Type-2 path up cleanly
"""
# modprobe vfio-pci
# echo vfio-pci > /sys/bus/pci/devices/0002:81:00.0/driver_override
# echo 0002:81:00.0 > /sys/bus/pci/drivers_probe
"""

A meme0/endpoint19/region1 appeared, and selftest device_is_cxl() passed.

When running the 9th patch's selftest
"""
# sudo ./vfio_cxl_type2_test 0002:81:00.0
ok 1 cxl_type2.device_is_cxl
#  RUN  cxl_type2.hdm_region_mmap_rw
"""
At this point, the machine hung and crash.

hdm_region_mmap_rw mmaps the HDM region and does a CPU read/write to it. That =
access never returned. I couldn't capture dmesg or trace before it crashed.

I'm not sure if this is a platform/FW issue or something in how the region
is mapped.
Have you exercised hdm_region_mmap_rw() against your machine? or only cxl_test mock?

If a guest can hang the host just by touching its mapped memory, it needs to be fixed.

Best regards,
Richard Cheng.



> Motivation
> ==========
> 
> A CXL Type-2 device exposes its HDM-mapped device memory through HDM
> decoders that BIOS programs and commits at boot.  To pass such a
> device to a guest, vfio-pci has to do three things at once:
> 
>   1. Surface the firmware-committed HDM-mapped HPA range as a guest-
>      mmappable region.
> 
>   2. Surface a CXL-spec-compliant view of the CXL Device DVSEC body,
>      the HDM Decoder Capability block, and the CXL.cache/mem cap-array
>      prefix, so the guest's CXL driver enumerates the same topology
>      the host saw.
> 
>   3. Keep the host's committed decoder configuration intact (the
>      physical decoder is never reprogrammed) while letting the guest
>      observe and manage a shadow that follows the per-field write
>      semantics in the spec.
> 
> The series builds on Alejandro Lucero-Palau's v28 work
> applied on for-7.3/cxl-type2-enabling [1] (sfc is the in-tree consumer
> today). vfio-pci becomes the second consumer.
> 
> Architecture
> ============
> 
> cxl-core owns the CXL semantics.  A new file
> drivers/cxl/core/passthrough.c (gated by hidden Kconfig
> CXL_VFIO_PASSTHROUGH) provides four exported symbols:
> 
>     struct cxl_passthrough *
>     devm_cxl_passthrough_create(struct device *dev,
>                                 struct cxl_dev_state *cxlds);
> 
>     int cxl_passthrough_dvsec_rw(p, off, val, sz, write);
>     int cxl_passthrough_hdm_rw  (p, off, val,      write);
>     int cxl_passthrough_cm_rw   (p, off, val,      write);
> 
> cxl_passthrough is an opaque handle; vfio-pci sees no cxl-internal
> struct pointers.  The shadows are snapshotted at create time: the
> DVSEC body from PCI config space dword by dword, the CM cap-array and
> HDM block from the cxl-core MMIO mapping at cxlds->reg_map.base.
> Per-field write semantics follow below:
> CXL r4.0 8.1.3 DVSEC:
> - LOCK is RWO,
> - CONTROL/CONTROL2 are RWL gated on CONFIG_LOCK,
> - STATUS/STATUS2 are RW1C,
> - RANGE1 is HwInit, RANGE2 is RsvdZ
> CXL r4.0 8.2.4.20 HDM:
> - GLOBAL_CTRL RW,
> - decoder CTRL implements COMMIT/COMMITTED,
> - decoder BASE/SIZE RWL gated on COMMITTED or LOCK_ON_COMMIT,
> - cap header HwInit).
> 
> vfio-pci becomes a thin transport.  The new module
> drivers/vfio/pci/cxl/ exposes two VFIO regions.
> 
>   VFIO_REGION_SUBTYPE_CXL (HDM region): mmappable view of the
>   HDM-mapped HPA. The mmap fault handler calls vmf_insert_pfn() from
>   the physical HPA. pread/pwrite go through the memremap_wb() kva
>   captured at bind time.
> 
>   VFIO_REGION_SUBTYPE_CXL_COMP_REGS (component register shadow):
>   pread/pwrite only, dword-aligned (-EINVAL on misalignment).
>   Each dword dispatches by offset to cxl_passthrough_cm_rw() or
>   cxl_passthrough_hdm_rw(). No shadow state on the vfio side; cxl-core
>   enforces the spec.
> 
> CXL DVSEC config-space accesses use a clipping shim in
> vfio_pci_config_rw_single(). A config-space chunk that crosses the
> DVSEC body boundary is split: header bytes go through the generic
> perm-bits path, body bytes go through cxl_passthrough_dvsec_rw().
> The shim replaces v2's approach of repointing ecap_perms[]
> 
> Sparse-mmap is exposed on the component BAR so userspace can mmap the
> non-component portions directly; only the CXL component register
> sub-range goes through pread/pwrite emulation. The CXL sub-range is
> also skipped from vfio_pci-core's request_selected_regions() set
> because cxl-core's devm_cxl_probe_mem() already holds a
> request_mem_region() on it; the asymmetric skip is matched by an
> asymmetric release on disable().
> 
> Scope and out-of-scope
> ======================
> 
> In scope (rejected at create time with -EOPNOTSUPP otherwise):
> 
>   - Firmware-committed devices (HOST_FIRMWARE_COMMITTED set).
>   - Single HDM decoder (hdm_count == 1).
>   - No interleave (IW == 0).
> 
> Out of scope, deferred for follow-on work:
> 
>   - Multi-decoder devices and interleave.
>   - Guest-driven (non-firmware-committed) HDM commit.
>   - Hotplug, FLR, and sibling-function reset of CXL Type-2 devices.
> 
> Changes since v2
> ================
> 
> This is a rewrite, not an incremental update.  The structure of the
> series changed (20 patches in v2 to 11 in v3) because v3 collapses
> v2 patches 9-15 (detection, HDM emulation, media readiness, region
> management, HDM region, DVSEC emulation) into one cxl-core helper
> file and one vfio-pci consumer.
> 
> Framework replaced by narrow opaque-handle helpers (patches 6, 8)
> 
>   v2 carried a generic register-emulation framework split across four
>   state-machine files in cxl-core.
>   v3 collapses it into one file: drivers/cxl/core/passthrough.c
>   exposing the four EXPORT_SYMBOL_GPL helpers above behind a struct
>   cxl_passthrough opaque handle.
> 
> Shadow ownership moved into cxl-core (patches 6, 8)
> 
>   vfio-pci no longer keeps any per-field state. It forwards
>   (offset, value) into cxl-core, and cxl-core enforces the spec
>   (RWO, RWL, RW1C, HwInit, RsvdZ) with explicit CXL r4.0 section
>   references in the switch arms.
> 
> DVSEC config-space clipping shim (patch 8)
> 
>   v2 repointed ecap_perms[] to redirect CXL DVSEC reads and writes.
>   v3 keeps ecap_perms[] untouched and clips per-config-access chunks
>   at the DVSEC body boundary in vfio_pci_config_rw_single(); header bytes
>   go through the generic perm-bits path, body bytes go through
>   cxl_passthrough_dvsec_rw(). The shim is local to the per-device
>   path.
> 
> CONFIG_VFIO_PCI_CXL gates the new module (patch 7)
> 
>   v2 had a CONFIG_VFIO_CXL_CORE Kconfig stub; v3 renames it to
>   CONFIG_VFIO_PCI_CXL to match the vfio-pci naming convention.
>   The hidden CXL_VFIO_PASSTHROUGH selects the cxl-core helper file
>   on demand. With both disabled, the cxl-core size is unchanged.
> 
> UAPI rewritten with named fields (patch 5)
> 
>   vfio_device_info_cap_cxl in v3 carries:
>     flags + HOST_FIRMWARE_COMMITTED bit
>     hdm_region_idx
>     comp_reg_region_idx
>     comp_reg_bar
>     comp_reg_offset
>     comp_reg_size
>   The DPA terminology is renamed to HDM region throughout.
>   CACHE_CAPABLE (HDM-DB indicator) is dropped;
>   it was informational only in v2 with no caller, and re-adding it
>   for an active CXL.cache plumbing series later.
> 
> Selftests trimmed (patch 9)
> 
>   v2 carried selftests for device detection, capability parsing,
>   region enumeration, HDM register emulation, HDM mmap with
>   page-fault insertion, FLR invalidation, and DVSEC register
>   emulation. v3 keeps a smoke-test set of six focused tests:
> 
>     device_is_cxl                  GET_INFO advertises FLAGS_CXL
>                                    and a populated CAP_CXL.
>     hdm_region_mmap_rw             mmap one page, write+read back.
>     component_bar_sparse_mmap      SPARSE_MMAP cap excludes the
>                                    CXL component register sub-range.
>     comp_regs_cm_cap_array_read    pread of the CM cap-array
>                                    header at CXL_CM_OFFSET succeeds
>                                    (CAP_ID == 1).
>     dvsec_lock_byte_read           pread of the DVSEC CONFIG_LOCK
>                                    byte through the clipping shim
>                                    succeeds.
>     hdm_decoder_commit_fsm         COMMIT / COMMITTED state machine
>                                    and LOCK_ON_COMMIT behaviour.
> 
>   FLR invalidation, page-fault insertion under load, and full
>   DVSEC field-by-field write coverage are deferred to a follow-on
>   selftest series. The current six are the minimal set that
>   exercises the kernel-side contract end-to-end.
> 
> cxl-core prep patches split (patches 1-4)
> 
>   v3 keeps the cxl-side enablers from v2 patches 1-4 but each as
>   a standalone change so the cxl maintainer can review the helper
>   API independently of the vfio consumer:
> 
>     [1/11] cxl_get_hdm_info()
>     [2/11] cxl_await_range_active() split from media-ready wait
>     [3/11] cxl_register_map records BIR + BAR offset
>     [4/11] component/HDM register defines moved to uapi/cxl/cxl_regs.h
> 
> Reviewer feedback addressed
> ===========================
> 
> Dan
> ---
> 
> - VFIO exposes HDM/host-visible region, not raw DPA; docs/UAPI say HDM
>   region, DPA only inside cxl-core where appropriate.
> - One vfio-pci device = one HDM region / one decoder, no interleave;
>   hdm_count != 1 → -EOPNOTSUPP.
> - Global HDM on DVSEC Range Base treated as legacy; RANGE1/RANGE2
>   read-only snapshot, guest writes dropped.
> - No guest/kernel lock games; DVSEC LOCK and HDM LOCK_ON_COMMIT RWO,
>   fixed at create from firmware snapshot.
> - Opaque cxl_passthrough handle only; vfio gets HPA via memdev probe +
>   layout via cxl_get_hdm_info(), rw via helpers.
> - No multi-region accelerator case in v3; single region enforced,
>   multi-region deferred.
> - cxl_await_range_active stays in cxl-core probe; not exported, vfio does
>   not call it.
> - No guest LOCK→0 reprogram; guest cannot clear LOCK to remap host HPA;
>   kernel uncommit tied to COMMIT, not LOCK alone.
> 
> Jason / Gregory / Dan
> ---------------------
> 
> - memremap(WB) + request_mem_region on HPA; conflicting direct-map/EFI use
>   fails probe with -EBUSY.
> 
> Jonathan
> --------
> 
> - uapi/cxl/cxl_regs.h for register defines so VMMs need no private
>   kernel headers.
> - __free() locals on cxl-core/passthrough error paths instead of
>   struct-owned temporaries.
> - No "precommitted at probe" assumption; acquire checks COMMITTED in
>   HDM shadow and refuses if missing.
> 
> Dave
> ----
> 
> - memremap(MEMREMAP_WB) for HDM host mapping (not ioremap_cache).
> - Renamed cap flag to VFIO_CXL_CAP_HOST_FIRMWARE_COMMITTED for clarity.
> - __free() / DEFINE_FREE() cleanup in new passthrough.c create path.
> 
> Patch series
> ============
> 
>  [1/11] cxl: Add cxl_get_hdm_info() helper for HDM decoder metadata
>  [2/11] cxl: Split cxl_await_range_active() from media-ready wait
>  [3/11] cxl: Record BIR and BAR offset in cxl_register_map
>  [4/11] cxl: Move component/HDM register defines to
>         uapi/cxl/cxl_regs.h
>  [5/11] vfio: UAPI for CXL Type-2 device passthrough
>  [6/11] cxl: Add register-virtualization helpers for vfio Type-2
>         passthrough
>  [7/11] vfio/pci: Add CONFIG_VFIO_PCI_CXL with bind-time CXL Type-2
>         acquisition
>  [8/11] vfio/pci/cxl: Add HDM + COMP_REGS regions and DVSEC clipping
>         shim
>  [9/11] selftests/vfio: Add CXL Type-2 device passthrough smoke test
> [10/11] docs: vfio-pci: Document CXL Type-2 device passthrough
> [11/11] vfio/pci: Provide opt-out for CXL Type-2 extensions
> 
> Dependencies
> ============
> 
> [1] [PATCH v28 0/5] Type2 device basic support
> https://lore.kernel.org/linux-cxl/20260618181806.118745-1-alejandro.lucero-palau@amd.com/
> 
> [2] Previous version of this patch series
> [PATCH v2 00/20] vfio/pci: Add CXL Type-2 device passthrough support
> https://lore.kernel.org/linux-cxl/20260401143917.108413-1-mhonap@nvidia.com/
> 
> [3] Companion QEMU series
> [RFC 0/9] QEMU: CXL Type-2 device passthrough via vfio-pci
> https://lore.kernel.org/linux-cxl/20260427181235.3003865-1-mhonap@nvidia.com/
> 
> Manish Honap (11):
>   cxl: Add cxl_get_hdm_info() helper for HDM decoder metadata
>   cxl: Split cxl_await_range_active() from media-ready wait
>   cxl: Record BIR and BAR offset in cxl_register_map
>   cxl: Move component/HDM register defines to uapi/cxl/cxl_regs.h
>   vfio: UAPI for CXL Type-2 device passthrough
>   cxl: Add register-virtualization helpers for vfio Type-2 passthrough
>   vfio/pci: Add CONFIG_VFIO_PCI_CXL with bind-time CXL Type-2
>     acquisition
>   vfio/pci/cxl: Add HDM + COMP_REGS regions and DVSEC clipping shim
>   selftests/vfio: Add CXL Type-2 device passthrough smoke test
>   docs: vfio-pci: Document CXL Type-2 device passthrough
>   vfio/pci: Provide opt-out for CXL Type-2 extensions
> 
>  Documentation/driver-api/index.rst            |   1 +
>  Documentation/driver-api/vfio-pci-cxl.rst     | 282 ++++++
>  drivers/cxl/Kconfig                           |   7 +
>  drivers/cxl/core/Makefile                     |   1 +
>  drivers/cxl/core/passthrough.c                | 590 ++++++++++++
>  drivers/cxl/core/pci.c                        |  70 +-
>  drivers/cxl/core/regs.c                       |  35 +
>  drivers/cxl/cxl.h                             |  52 +-
>  drivers/vfio/pci/Kconfig                      |   2 +
>  drivers/vfio/pci/Makefile                     |   1 +
>  drivers/vfio/pci/cxl/Kconfig                  |  34 +
>  drivers/vfio/pci/cxl/Makefile                 |   2 +
>  drivers/vfio/pci/cxl/vfio_cxl_core.c          | 889 ++++++++++++++++++
>  drivers/vfio/pci/cxl/vfio_cxl_priv.h          |  71 ++
>  drivers/vfio/pci/vfio_pci.c                   |   9 +
>  drivers/vfio/pci/vfio_pci_config.c            |  31 +
>  drivers/vfio/pci/vfio_pci_core.c              |  68 +-
>  drivers/vfio/pci/vfio_pci_priv.h              |  93 ++
>  drivers/vfio/pci/vfio_pci_rdwr.c              |  17 +
>  include/cxl/cxl.h                             |  18 +
>  include/cxl/passthrough.h                     | 121 +++
>  include/linux/vfio_pci_core.h                 |   8 +
>  include/uapi/cxl/cxl_regs.h                   |  63 ++
>  include/uapi/linux/vfio.h                     |  46 +
>  tools/testing/selftests/vfio/Makefile         |   1 +
>  .../selftests/vfio/lib/vfio_pci_device.c      |  11 +-
>  .../selftests/vfio/vfio_cxl_type2_test.c      | 350 +++++++
>  27 files changed, 2821 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/driver-api/vfio-pci-cxl.rst
>  create mode 100644 drivers/cxl/core/passthrough.c
>  create mode 100644 drivers/vfio/pci/cxl/Kconfig
>  create mode 100644 drivers/vfio/pci/cxl/Makefile
>  create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_core.c
>  create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_priv.h
>  create mode 100644 include/cxl/passthrough.h
>  create mode 100644 include/uapi/cxl/cxl_regs.h
>  create mode 100644 tools/testing/selftests/vfio/vfio_cxl_type2_test.c
> 
> base-commit: 90cf2e0d702c8a132ccbe72e7687f33c04c14658
> -- 
> 2.25.1
> 
> 
