Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2105.outbound.protection.outlook.com [40.107.92.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D78133994
	for <linux-cxl@vger.kernel.org>; Fri, 19 Apr 2024 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545120; cv=fail; b=HkLya3K/PUr3RhMsNB15b93hZK1mLbTWyW6sayrEjBzKB7oMwayRETqLlldAoLdWQsXQE1JSnMsOOYFwaumT4szsivRJE6dJNEs3vX4wzAw6c2nSOrwdMig3Wjqu+A72ng+KvAO4haPTTblc4jETM7J7Yd63SlyuTkYrqDYkecg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545120; c=relaxed/simple;
	bh=rryzY5+POFnOMZcLz15mPc48vrPwKdO+UXpH/OMq0R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GMMiTJTgvQ7hF1DKdNPsK2wTMW9ykuyOUPY9eyPpsxTPHTTNutLn9krWdbq7/C8mnD6WQK78EKzW2+0KRW4PadiTEXnXvIt+5IzvMQZiz+BUcRyyF6aI9/MApufkzQbqXLr9i99X2VVERsdNY02x6gdnyia9/VU7FoZ4FgT8C7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=viaUJ6wB; arc=fail smtp.client-ip=40.107.92.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="viaUJ6wB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQqgZscgQCRQ0ZZnH4hDvMVd3nA/h0nua/N3UAVvXEVZJYUdL6hRAynmHA1SKm8Nbp8fllMG37WprKmtFcqGTn4nT7vXLBvtnno+Xy3bhTbplF5TMQMLlxrD/EDH0iSMOWv1OgM7GCYOZuNjuOrlqOlLxJZ/lVB+fOzuVETBzsfTWJ+C6/hly+zei0RgYQwiI/5xV7WW3lcAYWEAybxdWCVbMHatf3w9Wc/XhuDgSIA6hOE4X2kgqlSa12+Q+0YEIXOvayzs3IfkOslgH7DV1mPJS3INnd2ONk5dW1TdWG1nvfUmFgYj9DogVm2I1xFucBaXmRu68w5NXg8xMmGM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/y/xAEOfE/v+4U8XIUi4vr6HK56v8GElLQQLZdSrmc=;
 b=WZhSwdtUB+LW+jx+PEXjSdgS1brM2fEoxNFfuGSIrR6an/mbXN8j33YrODfmPM19w7Una9UNKzINXCD82AqZuvKI5pWUcuUOFymo/+bBGEBc2GzDTcsC42ZV5bL1KtTFsYxyxl84BkeTyWJTrPXmsZgNSxR9byxXIkVkLoOFZWSoTeCLelBMvXs0QPM6fKNwzFQ1G9e+MrRSLsE3y6nncY+hna7V4aUK468yW5E7ljL6wvWGIIM5XYvuOHXtDx6hi7O88Ub1QAaj8wcQOkLazhWNxRyG2RZiZoSSiI/qSyXiLTxZXaUZrTqVCcH3lDcxdPR4428kgzsqNSQShL4pXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/y/xAEOfE/v+4U8XIUi4vr6HK56v8GElLQQLZdSrmc=;
 b=viaUJ6wBa/R2UgAlbMXV6qB+T6kmKAbJtCHPimagdFLEUzdI+y0r9oI142eib03ZdRf6SRR10Mj5BOPR/K9gbsF6MsNWZJ/aAADTpYqgPcao+SjNpZ7oUDdD3TOp4l6eiTxDpOHLVwyYcwzJFinh/3lvy6PPbw0XXl4TfmxUev0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MN2PR17MB3967.namprd17.prod.outlook.com (2603:10b6:208:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 19 Apr
 2024 16:45:15 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 16:45:15 +0000
Date: Fri, 19 Apr 2024 12:45:11 -0400
From: Gregory Price <gregory.price@memverge.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 03/12] include/hw/cxl/cxl_device: Rename mem_size as
 static_mem_size for type3 memory devices
Message-ID: <ZiKfl9GVp/HeD98J@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-4-fan.ni@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418232902.583744-4-fan.ni@samsung.com>
X-ClientProxiedBy: BYAPR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:a03:60::29) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MN2PR17MB3967:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e56fd4-53f6-4045-be8d-08dc6090168f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R4u3ZfU8JQRlG03TvcjbMezemr4oCJJ6ztwZhdYbNfTCKcRkiDapZ+v8bUvc?=
 =?us-ascii?Q?RuB1ku38v/rMVaTTudg6/X2qzWCyaGjDtwFQGcRDT3djBOtwsUqBjVM4myz3?=
 =?us-ascii?Q?eAoeE6poS9T+UmmzPiARAWvhpzGeBI/b/wu6KMmwaK3AMnE/5WtwAH8t1SPf?=
 =?us-ascii?Q?wuNJPkplSh6o+c8gw9Bw/EUCk5zlWTT2D0vdmuk/nHiVdu41Hjs9WbxQhz/9?=
 =?us-ascii?Q?ixL382i1ZcrVJ7Nk9rTz6sxTZuFW0w+x78ObQg6plO6qVvtCwxznzo1f9sf/?=
 =?us-ascii?Q?d9pTlzJrFMUIn6FKwocuQsN7NCvuNJWsksGG3E0eKBUa9idwygn3PxG1Odi4?=
 =?us-ascii?Q?m//Qi7C5/j474CYmx2SFIThtBBtThhpBIc9V/QUeXUjZWQENo73AxgbP3mx9?=
 =?us-ascii?Q?PyAUc5pWED5oDNMXSW1AbOJBHDFXaj7xwO3pAtkhbCrkJ8aCESqmfiuWa+NQ?=
 =?us-ascii?Q?bpqPZfxnbjH+AOKUkacArIDdAFVAlfeQ9AnjkuZWZ53d0VaJWuSPVbZ1Qigo?=
 =?us-ascii?Q?HyNJtzCZkVnZDrDt7MkLSRD6g/aWqCBn+0v0b8OVxvr+t/wnqIhlbCgDQv+/?=
 =?us-ascii?Q?hIe9HsXSidPqimPFKpNEwzp67tle0OlK7VFhUrh738EQtY/BVW4lOkmiGPB4?=
 =?us-ascii?Q?lSbfwPzZBqQzUf1OHUmpo5kJYBUUaLUzkewJSgyi/+5s60FHxbxULcdZqZJf?=
 =?us-ascii?Q?A2Xk+e0qy3YPDpy+3kHnazbAqmEuK43QbathP4N5QqoQO3238PjsJD1+e6nF?=
 =?us-ascii?Q?lsX3db/TUX7cYj9GA7zkK8aYa+P0uSBwO2zDrLPQqcesFNTWUD/5SdXoYDHu?=
 =?us-ascii?Q?83e7laJ+Hxo6OXeUKKxxy16GfgrBll8gYP2+VkHqxVW71wXXznvURu4bxEi+?=
 =?us-ascii?Q?NI9EHLxb/srOPZtanAp1xOUUfomBWf1SVQcvEkx8zcnksmJTQGzY846gKRgK?=
 =?us-ascii?Q?msvP1IUoKlPTzXTIV5rSiHYDTRBKCU2DyhgWuYrSr1aaI1LmrsVQaVaWgOGn?=
 =?us-ascii?Q?4ec9rll/QtwKKemFgbQ5vtHAINIg6Bm4t3b0NV7fQBnMRd7YW59NuyWOOu2E?=
 =?us-ascii?Q?aXXE709RXvNi7Gh+l1TfRlw+CxQMAz19EY7WTeT9mK1dEV2pp50jNq7LtAqH?=
 =?us-ascii?Q?mtoDIeL6qVi41w7jZhjCUKbvrGTv9USe4sornfM3p+MLzMkF1nK8Zm18JQgh?=
 =?us-ascii?Q?crGF1jnoat0nDEXsDS8F4M/2dk80AQBX6AKwhRQVYAIPMBd1xzoB9CEjjrsZ?=
 =?us-ascii?Q?fVrSi+KqEk9MeAOE5D86BFOoGYl4vwBxkdbp7Fm9rA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D6OOh/SLDpPyhVoMsVPnOnSNAH5JPWaAX0gKovoqfle/aJvezYGqXgsG7h8w?=
 =?us-ascii?Q?fVpX2bGzxnvdeWUQp5iwHQDpjR/bFIr11B99IuFCvm6ElVMt36yQI9zKvfuh?=
 =?us-ascii?Q?H6xXLRgnJGqjdwvjZ3f99QC0nHUgp+SwTsPKQhVNLHxccZSrcbNWaP6gSujv?=
 =?us-ascii?Q?qj54dks+BJGl2LjaSIV+ulEs4H4b3MZWxkE2mZDtNh572sTFECSc6uYzdVTH?=
 =?us-ascii?Q?/fLq4Hmhd9wIXawWUjYuRMiQ1vbciirrn5E0CxqmevuxZy+fFqKb4WzfpSkC?=
 =?us-ascii?Q?Ghhyz1OyxvoNgi85sqDO8bshN3wEG8hGqxfF1T9bdsQuIlfAL4jOGXY9PNUf?=
 =?us-ascii?Q?KTbSZlGh7wnZtzMPHaR8N/0YUQQZYrPZxCS3Ky8PXtL1p0qJ+/XkWkOCdwGK?=
 =?us-ascii?Q?PkP1Ls1/CtB/O2U8j62+5XUSQRmKy4JUJVI0Eh+fKBzWDU8iqW8/YKe4fWMg?=
 =?us-ascii?Q?gi4V7EnKHSfAcqaUEn8KvO0VNvXpE7Cvmtjjn7YYKy9QKKZNoIqp4CQg/n4F?=
 =?us-ascii?Q?0jOepQLSQkjKPr0mrG92Y2AjoHSgNhJcx3JvsoSX/NsqsVJujwc5vwO20EML?=
 =?us-ascii?Q?EJJ5U7NOGI3qSS/AcOfutgqBONUpAlfgkYLldukN0KHE0xz9TnsII9CyseUe?=
 =?us-ascii?Q?6XhStsvDSl2bHIWcMMpiPPTM7pIdLEt6twd7QokhER8wGj3c/p5Q3GIhTvir?=
 =?us-ascii?Q?8kDMMgnQt/FywNPwWw92+5NWmONP+KDVtihihRuuJ3Dew4pskik0Sxajtipr?=
 =?us-ascii?Q?MEMIf7P5NpUccLArlLgfftSZo6qFAdASEZDw7+53koWp1n7ZOo2BD4uBcbaV?=
 =?us-ascii?Q?QOGpY4DsrEil5+WgToThEeBYqVd3nqgciTn8nxTL73NhNb29Tyj8wKf5dq3M?=
 =?us-ascii?Q?jmG74pLJTKPZC/cyfYWjut8GAk49bt01WFrgnS8P+xc95ulXfYf2EsfllBV5?=
 =?us-ascii?Q?p+f5Q8MZ06FRvxanpSa0vTcssYHzT+dy6IvnOGK+wjzXQ2ajfMBs2DJpgwcP?=
 =?us-ascii?Q?KEkTTGbC+3RPNIeaih3DkmXBnRP8Cr8c8Xyw+vnHaoxSNo40/t1oHScXvv67?=
 =?us-ascii?Q?xmmMZm0UTUiRctHZsWuvvJiPJ2qArJW8NVcJDmx0cQjjgCud0l+is2QWwEp4?=
 =?us-ascii?Q?RelvYozPPUAWkK/TiFCn3Jvs3OErPCKmIT/lGbpCZxtHtyPUBL7XsHvRyJ2n?=
 =?us-ascii?Q?c0bbMgDu8FeAaDCh/A2gKxFXGPBED44ggjI2yJbpupvFAZg8yl6pVXGgwAbm?=
 =?us-ascii?Q?K6f8tg30Bs1cO6IwlwOQIpaZ4Pr7lwoSFBUHweKQV1JSCpQJAZZYYjshdt7r?=
 =?us-ascii?Q?phEw+nLqXgBbNI4jnUVPgnad+OT6Qr4HvYr0FmoDiovT36IOAa6nFYBqihkG?=
 =?us-ascii?Q?sDIKkjRHGIpi+T59fliVq1ByCFi5HtXLxOj+9Sct0dtBhcOZ/8y4ueS6WGez?=
 =?us-ascii?Q?8GPGrQAazZUGuKIcVBXIOsO0aDhvkx6weIGYTcSgLlNspPVRFeJ0N6HP0tkW?=
 =?us-ascii?Q?40JDwpB18dhiQAySr+1PRibkaJ0Ezov3RBcMhpEevjGh9dMi0vapfYxuebY+?=
 =?us-ascii?Q?TjvLBU31G2KDpa1onCZD99B3G5k6Q3JTcllhvlvLkmsm1OfIh2HvmcWjmdPw?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e56fd4-53f6-4045-be8d-08dc6090168f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 16:45:15.1130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoQq/JpzAw7cICZwTtq10DwOyOM0jOryWww/NWyRRPI0hOHd/yjUF6q+oTMrCvT8x2pWDaqlfHM3pB47s/XNmUxjv420QYBWsLlO5NDvnBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3967

On Thu, Apr 18, 2024 at 04:10:54PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Rename mem_size as static_mem_size for type3 memdev to cover static RAM and
> pmem capacity, preparing for the introduction of dynamic capacity to support
> dynamic capacity devices.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 4 ++--
>  hw/mem/cxl_type3.c          | 8 ++++----
>  include/hw/cxl/cxl_device.h | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Gregory Price <gregory.price@memverge.com>

