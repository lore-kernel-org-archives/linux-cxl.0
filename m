Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029B2363C60;
	Mon, 24 Aug 2026 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560403; cv=fail; b=ZnDVQtTVqMs4ZtncFWb6Ucm085cp2HLsNGp/fRhTl+gOJtnFvXWkbBZZnj7tk501kFa+i9AGqLepf8JmDqf+YOI72jeVltvJxmPjU9cQ/8U12KwSavXHo7Ce2nAyaC3BarwWSEPlHEljwDVYPUjeklngXrx5Mhd64HkpNykHjw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560403; c=relaxed/simple;
	bh=z8twWem0Ha6bzk4S6azkXIl3kY+D3EBoqQ3V9F5l7sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J9JZDAeDGvkaOWyVHIW+TTjC5ROEPR9JcSSU4/3PzTiPJw50W/avQcmfWheNTTLf5Hl6SNe6qt0uCQSggGTH1+l8ECKiprOwR2wLLW7ZNtauyTEBDNKHSQ183+KthI/+RHS8bizTR97Rxk0pFoLkPF+aVJDKED+naFiR6BkQC/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rMmmrROR; arc=fail smtp.client-ip=40.93.194.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rMmmrROR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cn9PcK/q/9qh30WY09ERp/ZxvWFGsed9ExZUHItwg/jWXEHUBPzdMVbKpGA/dJRg5jtn4JHWb3K4iGpfP3/xEyU2M717tfvh7U4/oReIE5htA3ZpGRE0K+eYreMGv4aFVUn+R+JfS8u11A5X9itMcbwJqqDAk2RNNodtKmI624dCe0dlQLsZNijNGvfrxdGl0AwnbMWsXjQDYbqrAbOfJNhTH1JJn58gWiw8wwDU6zjvBnwEaQwsEVsnWWlVqtPFGho3SxQ9V53qQSeDF2UOOY+lV/mOzpqVV1VZLbiCPJYonYTBBZB2UtXRWUNqj//z0a/4Zd7+Q9ujkxf6F1p8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKcjMdGshiJnYuDJ9omh3+W8v+G39rpe/TxRagk7JTU=;
 b=c3E06CdoDsJGujsfX8R0BQYHyb4b2XjhH0UHF6yTo3BhPXiAad25aA5MDP8scMAdOw8/kRkQPyC/zcQNRr2U+p8I6HYGNNp4iUJDTf9T+KtUvBRhG6JyIcxexWfr9sRnDicax8ryoGVcJUlhjpfNBSlTI9emJg38TgkBHw7XI3th+PVQSqX+oLk0ohXJd2B+rSZ9qOR093MlA3lpWWy22bCAB28abeHd6TQyHo2AGnc2I+PZm5HdNU3RRciEnoF0/kuVVdOywGMH3UInOFho8ihnVkbPBwheZL+rXV5ru+Qhlq5aftWKONLlcoHmc44JD7mzABRZtlJn6UhjPE8K4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKcjMdGshiJnYuDJ9omh3+W8v+G39rpe/TxRagk7JTU=;
 b=rMmmrRORKoqI9vUK59xdWYBaByINf8yrQx/N0OE4kV/Bqudz2FLMRzenu0NFAfcJqSEA+Mz3iu9ku7x4rCmYdEOgtB7MnMb63iB0Mj4kqrJrC16myYC6Y4b5oA/ELTTz+wC1/lZLHTMLLfPiPOqUcgW6CGHqWslHZSPy3UepHB837zZUEFhweKVqjDDZzmHFsSadnRRWQoZD52OFqQl1BKb6z4J78bkoKRfbGCgsxGEvVx0yGGvAUXbl1DUfwO56KH1dz2znFQ3djI8cJzSYeM1Tya+jfBdDnpysKHgqCLldBXgMr9ZektY3BdmTDCRonU/K6PemLPSyxQUev35TLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 08:33:17 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 08:33:17 +0000
Date: Mon, 24 Aug 2026 16:33:09 +0800
From: Richard Cheng <icheng@nvidia.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, 
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC 1/2] cxl/memdev: add support for mutipf device
Message-ID: <aov-jfhJtNtZJxlN@MWDK4CY14F>
References: <20260821155134.260053-1-alejandro.lucero-palau@amd.com>
 <20260821155134.260053-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821155134.260053-2-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: JH0PR04CA0035.apcprd04.prod.outlook.com
 (2603:1096:990:78::20) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: b720ee8e-52f4-40c8-4406-08df01ba588c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|6133799003|10067099003|5023799004|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	t2GxCJjS8f5QRSxghvWMTzrDnaFMlT0uOK2BkIZjWCJ89fqVqrU+Vnhpecd7y60mfVZiJ1WGFPKyj/ki6mzPX56R59PYFi91yUY5yLtN0g9/KpiFGTgwpot8gm3Jl/HoZMvSsfcobNNGvnC0LFEcKEcibO9fJfosbOmF6PDxqvxnxPeuLKF145j/ctnkOcG3T1ekaDv89djec1qrrA7rZfksNP/0tzXQ0BzdDi+9EfFSK9AMiUW1PHNQAK7n4X/IuKK9OcQKrm9HEZuXiLn+oN6DimNfs6HiLUYDcb+5Kw6C2u2DkjFgMQBvP9k6KhbrvXx7SWUWemuRjqoU/XY5g2WLOGpgJWYWGhAzgplF+yRJdk14CWGaGmYs8kQyPTyljv5CJ0HAqo9L6hVlru4nmjWhQFLkjwKl4XXNMuGS59uwV/ZjnuP2TRFRDG5cfpWeADX+MTzIUq87U9+Aq5szee5BkUjVaihz8sZz6gbOBEOJAjXP/KK0lqxXMquyj8G+pgCCqKc/uub+FSMo3DAaUgzHrWanIY1S+44BSp0u5oKpYy5opUL4fjRg6wGmpa0fOPbGdvDm6ZoSG0V2NP5Ljp5iuFfA0ywFyPnbsXccVilyQr+/J9sOkFsX0HF/bNV5UorJuonPF2Bdwlg1vod0x1x/bLtzZCuhy5pzt/+aSIk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(6133799003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rrkzRdsNqaBvnbL2pkigDiR8ObNoPekB1WMzWmvzdbIaDINvxR0K+yowpZn2?=
 =?us-ascii?Q?33DMGqgcgYNEc2AxV9oi77XF+SVgOuOnPCk4icb0eI/cIm6876990nFmRfsb?=
 =?us-ascii?Q?RpiYJLdFHOXgNHA+tr9/Ud1jH/UwP//Xdgchiqq8ywJT+vvuvdpEfc0FRGb8?=
 =?us-ascii?Q?aSEzUnnPn+0GC3yJ24naSyB5NsBDpctj+iZnujWkgBrU0noMOrjgDHk+w9pS?=
 =?us-ascii?Q?51e/mvyxXVRpyayxO1YMB9jhCzXNbmKdlKVhYSgEGD71wf3+T2yHMHktBYma?=
 =?us-ascii?Q?ouHn0AMxwY8/7Mlwcr75QVESMRsoHiHndchtwo5eR6ej43WXyKD2p9UMxZEP?=
 =?us-ascii?Q?kfID7ETIGfQylTvSncFQqtD/2ZLDGXmcEg4KQMIIg9BmCAdliJKZHfM/62dc?=
 =?us-ascii?Q?sG4bvZQf5B4dicWf+Auicbke4yB1VvvHlG1k3Qc0r3Siqunzqc9RQNTq4sjP?=
 =?us-ascii?Q?FVZCRhYsf1h0eeTv9rTOhzhPx+LvL56KW0Fq/x6V4ySRtK6IEpKpXKrEePZ0?=
 =?us-ascii?Q?dami2dFhdroUc4QAR8iIuMDLETK7dDMF+izvfaYS3BUGU7lc1NyoZ0eATzXi?=
 =?us-ascii?Q?F5c1M+8znVGve191Z7dIbG9fDyExWNVN7yVtxNcjumFn7TXgSpLa2f5ikbVB?=
 =?us-ascii?Q?8rzC2V8xmou/atj4u1mdGbM/7czexQW33YScPi3ZRoI9gAtclfdiMx5vdte7?=
 =?us-ascii?Q?t3qq/5RmkFuQcvKVnAumk/lBbh2FbzPgEYHOuyG3xAC/wZoOh4lzIGokXj6P?=
 =?us-ascii?Q?ZCMp3gZGx3bx45Bf/ucHc2hA+GPOzlRLdmcrGPjqt7OC5CHbMiIpvIrmYQNG?=
 =?us-ascii?Q?ct1Q+AWY9uZMOTgY3bDw6+LET14WNVcKrYYzW3VBLipgDJewkK1NjrDsgCDc?=
 =?us-ascii?Q?2XEH5tNJr1Fr14BAusdpNZq6HyIgpUeoQGUa0f9p2/dooiJ0wylfoOcszZHO?=
 =?us-ascii?Q?ptOu01Y99x2u3Y3EHfEkUmOVYa2NNn4TndgILqzUcONkpsNBYRUqVUm9JKWC?=
 =?us-ascii?Q?PSlmyY0NsC8MMeE9aPZCjIycqQULOLJtTrATFNh4BmDjH8uczXToZvambq8T?=
 =?us-ascii?Q?/Q985M51cd9q92LIDUiQvNoDYaNjPd/y6AIJYX3kkQfv1wLbLOJ/nrRdgtRT?=
 =?us-ascii?Q?1v5zpL92yGPEwzqXOWNQrN7cYhKYGqTLyLk6coZRB/1arpT0dzbwdThQhQd+?=
 =?us-ascii?Q?DPnOFvsQ+i3l4TKyaq+VCOViP3wWzveTNNQxq008nuULDkKJ3Xh3IDVwnSeT?=
 =?us-ascii?Q?P33jZ7ubE13fjzL23xYRwMel65WKTivjHmZXuLebR07sUFsQ8reM/H6Ck4Bl?=
 =?us-ascii?Q?LZxUN7lXjI24xCGZdmiMyM1bNgmaujnJs3rzVy0sSWebSNurWdXcL4eAtpeW?=
 =?us-ascii?Q?SPFK/TNo9IRxc1CZxzQZIinl2WX+Vp5dLCxvJsDBcle61nT3f8qubuBF2yfR?=
 =?us-ascii?Q?mEewWAqrTN1xEXFGPbJ+g7QoBVlh5/bGkIIHGIgu7/OSiQAFggl6JZcQWY+n?=
 =?us-ascii?Q?1JHDDzVED7sOWpl71JUS5YHNWsIgqdPntKtccIjwRUx2HMvDBCbwI9H1ZcTM?=
 =?us-ascii?Q?zRiGfJQokd9JxiDLk+xAVmzJaFfb4sTAJMVdIHfgnVSDqQ1QBEVdVXRVTmiL?=
 =?us-ascii?Q?bpyWiW86/decUPBiK4mejr3Bz52Q2SfqcylDjJqi3LC8yq0FTQiWlbRCCgeP?=
 =?us-ascii?Q?PHrVREWYhWMintZ0xjdcXbnNyIJIKkz6XfnxM15gqoWlMdncXKhp+iaIIG/l?=
 =?us-ascii?Q?R2zBDQmhnw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b720ee8e-52f4-40c8-4406-08df01ba588c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 08:33:17.5765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+ozCqYWuPDPsPHMPsghOoCR3aXti8Mnrg53HqGfGeFFsNQlkfzox2CGMmY38K5ldu0CecK8RuR376dwNxneJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697

On Fri, Aug 21, 2026 at 04:51:33PM +0800, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A PCI device can present multiple Physical Functions(PFs) but the CXL
> specs restrict to the first one, PF0, the discovery and management of
> CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
> obtain the CXL.mem range to work with somehow.
> 
> Although this could be handled internally by an accelerator/Type2
> driver, it requires to properly handle changes to the CXL mem device,
> mainly its release by the CXL core, but also potential CXL device
> resets. When this release happens, those other PFs need to be told about
> it.
> 
> Implement a way for non-PF0 PFs to register/unregister to the memdev
> linked to the PF0 device. At memdev release, trigger the release of
> those non-PF0 PFs devices registered to such memdev from the driver they
> are bound to.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/memdev.c | 122 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h      |   1 +
>  include/cxl/cxl.h         |   4 ++
>  3 files changed, 127 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9..327c4da3208f 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -26,6 +26,35 @@ static void cxl_memdev_release(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct device *parent = dev->parent;
> +	struct device *sibling;
> +	unsigned long index;
> +
> +	/*
> +	 * Type2 multipf support implies other non-PF0 PFs could be having a
> +	 * temporal reference to the memdev, only for registering/unregistering
> +	 * as sibling, requiring to postpone the memdev release and the sibling
> +	 * management until no further references. While detach_memdev() calls
> +	 * for pf0 release from its driver (parent device of the memdev device)
> +	 * it is not safe to invoke for sibling PFs to be detached at that time
> +	 * as it could race with PFs registering/unregistering as memdev siblings.
> +	 */
> +	if (cxlmd->attach) {
> +		xa_for_each(&cxlmd->siblings, index, sibling) {
> +			device_release_driver(sibling);
> +			xa_erase(&cxlmd->siblings, index);
> +		}
> +
> +		/* Several possibilities trigger a memdev release with one being
> +		 * its parent device (Type2 device) released from its driver. If
> +		 * so, such release is the context for this function, precluding
> +		 * the mutex lock and therefore safely avoiding to invoke the
> +		 * release again which would trigger a deadlock.
> +		 */
> +		if (mutex_trylock(&cxlmd->dev.parent->mutex)) {
> +			mutex_unlock(&cxlmd->dev.parent->mutex);
> +			device_release_driver(cxlmd->dev.parent);
> +		}
> +	}
>  
>  	ida_free(&cxl_memdev_ida, cxlmd->id);
>  	kfree(cxlmd);
> @@ -795,6 +824,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  
>  	cdev = &cxlmd->cdev;
>  	cdev_init(cdev, fops);
> +	xa_init(&cxlmd->siblings);
>  	return cxlmd;
>  
>  err:
> @@ -802,6 +832,98 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	return ERR_PTR(rc);
>  }
>  
> +static int match_memdev_by_parent_device(struct device *dev, const void *data)
> +{
> +	const struct device *pf_dev = data;
> +	struct cxl_memdev *cxlmd;
> +
> +	if (!is_cxl_memdev(dev))
> +		return 0;
> +
> +	cxlmd = to_cxl_memdev(dev);
> +	return (cxlmd->cxlds->dev == pf_dev);
> +}
> +
> +/**
> + * cxl_get_pf0_memdev - register as PF0's memdev sibling
> + * @pf0: device for PF0 used to match current memdevs.
> + * @pfx: device to register as sibling to PF0's memdev.
> + * @index: where to register the device in the xarray.
> + * @range: to be set with the PF0's memdev range.
> + *
> + * Return: PF0 memdev pointer or error.
> + */
> +struct cxl_memdev *cxl_get_pf0_memdev(struct device *pf0, struct device *pfx,
> +				      unsigned long index, struct range *range)
> +{
> +	struct cxl_attach_region *attach;
> +	struct cxl_memdev *cxlmd;
> +	struct device *mem_dev __free(put_device) =
> +		bus_find_device(&cxl_bus_type, NULL, pf0,
> +				match_memdev_by_parent_device);
> +
> +	if (!mem_dev)
> +		return ERR_PTR(-ENODEV);
> +
> +	cxlmd = to_cxl_memdev(mem_dev);
> +
> +	/*
> +	 * we got the cxl_memdev and the implicit get_device in bus_find_device
> +	 * makes the next steps safe.
> +	 */
> +
> +	xa_store(&cxlmd->siblings, index, pfx, GFP_KERNEL);
> +	attach = container_of(cxlmd->attach, struct cxl_attach_region, attach);
> +
> +	/*
> +	 * The cxlmd object does exist and it can be found in the cxl bus after
> +	 * creation but before attach probe setting the proper HPA range. If so,
> +	 * the caller will need to try later.
> +	 */
> +	if (attach->hpa_range.end == -1)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	range->start =  attach->hpa_range.start;
> +	range->end =  attach->hpa_range.end;
> +
> +	return to_cxl_memdev(mem_dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_pf0_memdev, "CXL");
> +
> +/**
> + * cxl_put_pf0_memdev - unregister as PF0's memdev sibling
> + * @pf0: device for PF0 used to match current memdevs.
> + * @pfx: device to register as sibling to PF0's memdev.
> + * @index: where to unregister the device in the xarray.
> + *
> + */
> +void cxl_put_pf0_memdev(struct device *pf0, struct device *pfx,
> +			unsigned long index)
> +{
> +	struct cxl_memdev *cxlmd;
> +	struct device *mem_dev __free(put_device) =
> +		bus_find_device(&cxl_bus_type, NULL, pf0,
> +				match_memdev_by_parent_device);
> +
> +	/*
> +	 * This is not an error but a possibility if triggered by PF0 being
> +	 * released which triggers the caller driver releasing pfx. It should
> +	 * not happen if the caller driver does the release of pfx independently
> +	 * but we do not have a simple way to ensure this here.
> +	 */
> +	if (!mem_dev)
> +		return;
> +
> +	/*
> +	 * we got the cxl_memdev and the implicit get_device in bus_find_device
> +	 * makes the next steps safe.
> +	 */
> +
> +	cxlmd = to_cxl_memdev(mem_dev);
> +	xa_erase(&cxlmd->siblings, index);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_put_pf0_memdev, "CXL");
> +
>  static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
>  			       unsigned long arg)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c401e3a1af06..430014c4a046 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -54,6 +54,7 @@
>   */
>  struct cxl_memdev {
>  	struct device dev;
> +	struct xarray siblings;
>  	struct cdev cdev;
>  	struct cxl_dev_state *cxlds;
>  	struct work_struct detach_work;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 802b143de83d..883ce9f1b73f 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -228,4 +228,8 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
>  				      struct range *range);
>  
>  int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
> +struct cxl_memdev *cxl_get_pf0_memdev(struct device *pf0, struct device *pfx,
> +				      unsigned long index, struct range *range);
> +void cxl_put_pf0_memdev(struct device *pf0, struct device *pfx, unsigned long index);
> +//struct range *cxl_get_memdev_region_range(struct cxl_memdev *cxlmd);
>  #endif /* __CXL_CXL_H__ */
> -- 
> 2.34.1
> 
>

Hi Alejandro,

I agree that non-PF0 functions must stop using the CXL range before it disappears.
However, I don't think cxl_memdev_release() is the right place to unbind them.

For Type-2 device, PF0 driver creates the memdev, and therefore the memdev
is tied to the PF0 driver, while CXL core manages its attachment to
the topology.

cxl_memdev_release() is the final object release callback. It can run much
later than the CXL attachment teardown.
For example, an open /dev/cxl/memX file holds a device ref. PF0 and the CXL
region can be torn down while that file remains open. During that time,
other PF driver remain bound with mapping to a range that's no longer valid.

I suggest replacing cxl_get_pf0_memdev() and cxl_put_pf0_memdev() with another
helper, e.g.:

int cxl_memdev_link_consumer(struct device *pf0, struct device *consumer, struct range *range);
 
It should live in cxl/core/memdev.c , and the behavior is something like

1. Find PF0's memdev and take a temp ref.
2. Lock the memdev
3. Verify that the memdev is still registered, driver-bound, attached, and has a valid HPA range
4. Create a managed devce link via device_link_add(consumer, &cxlmd->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
5. Copy the HPA range
6. Unlock the memdev and drop the temp ref

This helper can return only an error code and the range. The sfc driver doesn't need the cxl_memdev pointer then, and
no put helper would be needed.

And driver core would unbind the non-PF0 consumer before unbinding or removing the supplier ( memdev ).

I think this can remove the sibling xarray , raw device pointers and mutex_trylock() context check.

Would this modle work for your teardown requirements ?

Best regards,
Richard Cheng.
