Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE03F3CAA31;
	Thu, 11 Jun 2026 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172814; cv=fail; b=Y6b4OlNRB2Yp1dJKeYg2BPz1sGR+rIp+Yc07j6oBZfsjUPFtNDvBtMQ3b9lNUY96Bh8SiiJJcp162EA7VA0KIBYwbB5DoR6z2AOMQm23iJp08fuw1zB4wY9rGeEsVqlVnQ/oMf9VjBfiMWA2h7nQxp8XD1hq5HjlCharyHfMEZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172814; c=relaxed/simple;
	bh=Xa/ztrlkMLSppX1v9zwTVtcTXqQqvdqoxDwBSQS/FiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kCyB5zmWabXxydks2p/hYkI9oEnEB752FPK/B4oyZFu6lQ7LWoHQVdcwxxr8oQj8ye6WmPoiir9fCRgoAt1immKEhmrZw0kN86J/94A2n9sexsZsJrECPPKhn+PFROc/1l/s/zLzPghAw3MlmTlTXkoor5JGf4K/ZLMNr/0C2uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CKMAHaot; arc=fail smtp.client-ip=52.101.48.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CKMAHaot"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKbiU1qQQY0f8ep+fUEWP9IKu2ZeLKYvS//6Zo3RNVhMDr8XtJEQaQd0GPr/bTY/hViNL+kTDV0Bw7URk4e2JoY1ghHxxuPSQsz7AMZUoc9bWotOn2EAgKy/EFgpYhfLbnTiIIJyoMSlUHo2W8YFz7DSZD2N8S7zkvG11l54hzFTQo/ywxwxGHYJzvT7cBPL7u1PiJV/Df5T4ZYq+yqQPG7+65Jjhp/MWdeuFoA4kVDA0HAekQnWD9neL0E6RneC1HuSnm6T7sDrQ7jQK7d9oC86OhU9Ymc6Q8DIO1BwQhS4n3dGDRiOqsSUON/5a9TZ1pxTJMbDXSIFoI9u5jLpoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxW1gEBqPhRQTFcBtpSCm26owbdQ+xrJ2zVACppBejE=;
 b=bzs2PZolLpx4YxzUmERjciapI6RpXl6O8CWIfbU8KPH6A27dR747cmkn2pbiWqoiZYhnLA3KOd3GfrAxFLzyx4MhlM+G+l6vuYaE3Kbny4ifadWxzKuUMIwx42KL1VxAD2Vup1i29go/LlAnZTdRdZ6pb1pEMzaKeVhzjhs5UScQbRqxgRTaUDjhFLO2eXWmvmO4ysDZFMFZc+oIGXGdG/WuDbhCIIAFGIezEt4XYdx3wCg1nAbGgG+zsINwGTEnTJtSj8cYb+CkkswCbnuHcHwfUOixlsFxMfR3pt32pAuHFXDyfEezSk6827MAmwv73nJ3vjAoOcfunN5RDdiSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxW1gEBqPhRQTFcBtpSCm26owbdQ+xrJ2zVACppBejE=;
 b=CKMAHaotY3QUfICy5Wf2Zmwss76xln9FqNQCuwt0prsPOliTrBTtbutqw4lKF5HOj4fS9rCTty530iUUJcds0s354KZ0QMWI7nIB1xUooAj0ye6rWyMDxbjhCZLGETI0YZ6Y+1zNmX3SB21c4JsQnzOH+fPNnq6+eSL/xD23MTEar4/+1qwNWWuMDxiNCs/uPFiYHCtIEMsXWkrbGLft5dh1BSLePvXbxO0LFjGpXYoNiuy+B/jF5ZMfYXwbeLegXgiZmcOC6ljY1xGrMXoCE0u+w2qvcoMwY6K8pH5X4M+ycFEaxE+3cFb7QlsKJ3PjNixKqT+f0a+P5IWxRbMmWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 10:13:28 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 10:13:28 +0000
Date: Thu, 11 Jun 2026 18:13:02 +0800
From: Richard Cheng <icheng@nvidia.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com, 
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com, 
	vaslot@nvidia.com, smadhavan@nvidia.com
Subject: Re: [PATCH v4 0/2] Support zero-sized HDM decoders
Message-ID: <aiqI31m6KjMJSyH2@MWDK4CY14F>
References: <20260607081345.61954-1-icheng@nvidia.com>
 <6a289e3665fc5_4fa78100b1@djbw-dev.notmuch>
 <6a28a3ba2e05d_4fa7810068@djbw-dev.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a28a3ba2e05d_4fa7810068@djbw-dev.notmuch>
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 466a2f8a-3857-46bf-ab31-08dec7a214d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	B5af7WsRHWo0Tsr1y4t9tWDho/dANuK0JQpwHuKrNdYi1bHzq+/Df+hVHU0UcAiy4eVvtBC7LB0CYY9+KLaQuApe8zRnLNUG5oSD9xz8aUr+ZvqaSQ80wy7/L5GgKlViuayVH9XHRae0rbnplAs1GirFbYMS3JwVaZDgE8Ew+bsLPKiy99PMc1xxf0TT1o3mSSKGFtyd+G0ml13ElB7dLSFZuDGr5IRj/VqmhT8qm81uxCZRTI90dL9GrNbjT3+2d5JGS2v4pjhwZhU8krG9yQbjMWp6b1lzUB4/Z3WBBa5v4ElbyoRFVMIphdC3X4m+BEG2uSLsV/9Q2CuHUOZJ6w1MlS39sdquNHIzfA7apLUIcBMi3T1szckSZCFMh9F6euQpE/57ghTIiusf6CvmYuCy6HhyAoAy7sZKHBNJ5BIELd89hAtH+k2o3F2rKNdw632mI/5cSbXNBd9RMAxFzWoSjsnVjXICnwogFI6877RLIX0We0dbqLbjkUIc0Fq+j2MV1B2bQ0804ssre04ShqIc5tLeH9Y7pr1pk4c9ne8WtYi6ZCt0/O7SdXzz2Yrdn7bl2NqbGTVhYS3eeZrWYRYtrhVfRcMHRd3Mf6Gjtz8P4L+JuHuhUKe2K5VVYu+xom1ur5ZRekCncNmwMrvEZ8ObRBkkTsIj/AYUYyps8/AndNzP8xXOUIJc9T+1IeJ4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x3NHdP/FsKNaBEygN/SpajxoQC3344dWDCXoUvq1RU+sOubfB2I/dNvkC/Ml?=
 =?us-ascii?Q?ds7hiWSe476cJ/Tji1VERRVs9QxAiat7i1LHLXZ6sCw/UqmyAizgaOFbp90A?=
 =?us-ascii?Q?gRfHFJ8JmnjWagiJnB7/PZcLqucrk5Hqbljz7/x3DGB3z81bBhdoMnG09gEX?=
 =?us-ascii?Q?q0uPCnolD+W8iIhyhTid85U7pRjCiXYTXX5v/Oqi6ywU/5EDTGbcy0rITjuj?=
 =?us-ascii?Q?gcBpAxr3D7OkdgtR20pvGm2ZxX+pqwHw3jIi+Vwh1uFzH+7oozxWXHfRiTRk?=
 =?us-ascii?Q?iRqqXRCT4/kAW21ZeSUNt9mz5I/8cCZm/1mabDnHKoGEI+ey+snNRtZBXnMr?=
 =?us-ascii?Q?vqTcNQP8Mm/QqalSgtP8QEA4Wkoh3b03grv4ZU7O8Cl60Jwltbhky245VFXV?=
 =?us-ascii?Q?Mk6fbTKAtGL/sUJyQwa2W+9oiBVdVlLCjUVkuhbCjmjnUJOKKVBrvx9DxaMU?=
 =?us-ascii?Q?QbeNUzQ+ZgtPZcKi+8pgY1LEYAW7aIW2elHppE3AtUa2GKl30LTzdGgGyM3G?=
 =?us-ascii?Q?m+862JV4IJ3bUxjvgemiVqyFI/RsscBlbysC9zCX/zFjk97f4T1tKk5FSEQJ?=
 =?us-ascii?Q?dubPHbrMB3EDZ6m45t9+k/BKSanNqiKtDwIjnV12YChi5EoohdNQjCFsHirZ?=
 =?us-ascii?Q?Wre7s1MR41wkm+Z1Kkz93dwK6O6AalucVkl/bBOvu3xf1ZSEDBGKlHDxtdeu?=
 =?us-ascii?Q?kWlR2fMEDBsYVYY7xO5oUWi1e7gIgj8NiIjDasRAUowHzegUKyWgL1qUneHQ?=
 =?us-ascii?Q?FNfd6ZncSHHpdB6w5Jp+1GLMe3W1QfLrbj0ZEFxVaSwNqX+ubVd+ZOew8E2x?=
 =?us-ascii?Q?ruEEEHYhiVq2v1yYYdCe0jvV1ECCGAfWgWRV1SYltSuBhUUevsBEvZnBMqI/?=
 =?us-ascii?Q?t+oKlm+W5DVAUdCXN+s5kzxOHT26dEb2jDvt43PQMjqlmXWxUxRotj7hPqG+?=
 =?us-ascii?Q?hWX9g/G2n/BTkU8mM2UvIB3rpBuGkeYaoKIx3UyD6EFIFqg4/nCVqCN1A0vI?=
 =?us-ascii?Q?tiFV3kdPe1uP73NF9CE9pnsPlFXo1JXuhAOIA8j2+vGhpNnmeA2KzSv/Ohsx?=
 =?us-ascii?Q?wfI66ZfYG8kSL2VExroMrZMc+nV46eSq6upKY/2bKaK4hyz/mZYYi8o1I1Sa?=
 =?us-ascii?Q?WUCerCKcW5ry+LJo0IUk3qSNLYEqTtc3Yj9O+8oWVrJBeozV3AmjmXUlLskD?=
 =?us-ascii?Q?giqLuPtKajZ3mhtAsUKyN1+LnUxRIM9AgMsksPVer68HpeIFbLfl8F4iHHgM?=
 =?us-ascii?Q?+4zxrmh93v7ldTOV3vC9T5+uq4fPcEGfZe4hqv+0d/3z5S9jh3h4FQtxuNe9?=
 =?us-ascii?Q?dwoAX+Pn5IqH11+y3Zx9ivKPESUA52+LVuVebyt85czvbbwpw8liVWr1VVno?=
 =?us-ascii?Q?fycDI2VmxdM55OuC3fOLZInUs1RDfqHRN6OCy1XYrTdMqnT1+x1GRjnW0lPT?=
 =?us-ascii?Q?vz14DDykrb8yBYG9v5RV2r1b70XSLRYQl5EAhl78kGQBOqFtZSio51q2pCEh?=
 =?us-ascii?Q?+inIhpTuftok21MRhBnQVNpn3m9CMU8jsZj4DJ2CWw4gJDuu3fs40FKcenD8?=
 =?us-ascii?Q?qcPJh7GziFnT5VtXrIYwuhDfFiTwjVHGuEXaJtqrRL0Zy/bl5pgIXDwiTdXY?=
 =?us-ascii?Q?Vyx4CTHtsiapHEYSdNfoPcYZe+5ISPOL3OJfx1BMTlVlvFah6AV8U7xukJA8?=
 =?us-ascii?Q?ssiXsHuDoW3zhiCQT/9pCDbv61HuyLTJ8dSDRC26POVIT0tD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466a2f8a-3857-46bf-ab31-08dec7a214d0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 10:13:28.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f12KvvpFAu/t82Qbqb2OmO5/2I04mmOst8oPdrrHxJw7u7llUdrwvPSdqy4fYFo7GPMmv5T5WzFKTpnvqkeung==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153

On Tue, Jun 09, 2026 at 04:37:30PM +0800, Dan Williams (nvidia) wrote:
> Dan Williams (nvidia) wrote:
> [..]
> > I think the way to solve this is something like below (untested).
> 
> ...whoops and unset apparently.
> 
> > It keeps @hdm_end aligned with the available decoders, and tracks the
> > start of zero allocations relative to their skip. I believe it may
> > also address the Sashiko report.
> 
> -- >8 --
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..3f9d97c9a3b7 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -209,6 +209,14 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
>  
> +static void cxl_dpa_release_region(struct resource *parent, struct resource *res)
> +{
> +	/* zero sized decoders are not tracked in tree */
> +	if (resource_size(res) == 0)
> +		kfree(res);
> +	__release_region(parent, res->start, resource_size(res));
> +}
> +
>  /* See request_skip() kernel-doc */
>  static resource_size_t __adjust_skip(struct cxl_dev_state *cxlds,
>  				     const resource_size_t skip_base,
> @@ -256,7 +264,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  
>  	/* save @skip_start, before @res is released */
>  	skip_start = res->start - cxled->skip;
> -	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> +	cxl_dpa_release_region(&cxlds->dpa_res, res);
>  	if (cxled->skip)
>  		release_skip(cxlds, skip_start, cxled->skip);
>  	cxled->skip = 0;
> @@ -336,6 +344,22 @@ static int request_skip(struct cxl_dev_state *cxlds,
>  	return -EBUSY;
>  }
>  
> +static struct resource *cxl_dpa_request_region(struct resource *parent,
> +					       resource_size_t start,
> +					       resource_size_t n,
> +					       const char *name)
> +{
> +	if (!n) {
> +		struct resource *res = kmalloc_obj(*res);
> +
> +		if (!res)
> +			return NULL;
> +		*res = DEFINE_RES_NAMED(start, n, name, 0);
> +		return res;
> +	}
> +	return __request_region(parent, start, n, name, 0);
> +}
> +
>  static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			     resource_size_t base, resource_size_t len,
>  			     resource_size_t skipped)
> @@ -349,12 +373,6 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  
>  	lockdep_assert_held_write(&cxl_rwsem.dpa);
>  
> -	if (!len) {
> -		dev_warn(dev, "decoder%d.%d: empty reservation attempted\n",
> -			 port->id, cxled->cxld.id);
> -		return -EINVAL;
> -	}
> -
>  	if (cxled->dpa_res) {
>  		dev_dbg(dev, "decoder%d.%d: existing allocation %pr assigned\n",
>  			port->id, cxled->cxld.id, cxled->dpa_res);
> @@ -378,8 +396,8 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  		if (rc)
>  			return rc;
>  	}
> -	res = __request_region(&cxlds->dpa_res, base, len,
> -			       dev_name(&cxled->cxld.dev), 0);
> +	res = cxl_dpa_request_region(&cxlds->dpa_res, base, len,
> +				     dev_name(&cxled->cxld.dev));
>  	if (!res) {
>  		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
>  			port->id, cxled->cxld.id);
> @@ -545,7 +563,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	struct device *dev = &cxled->cxld.dev;
>  
>  	guard(rwsem_write)(&cxl_rwsem.dpa);
> -	if (!cxled->dpa_res)
> +	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
>  		return 0;
>  	if (cxled->cxld.region) {
>  		dev_dbg(dev, "decoder assigned to: %s\n",
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7c6c5b7450a5..6f4d634b2cfb 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1433,6 +1433,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  	int nr_records = 0;
>  	int rc;
>  
> +	if (!len)
> +		return 0;
> +
>  	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
>  	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
>  		return rc;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..0d03e3bedb40 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2090,7 +2090,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (!cxled->dpa_res) {
> +	if (!cxled->dpa_res || !resource_size(cxled->dpa_res)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>  		return -ENXIO;

Hi Dan,

Thanks for your review, much appreciated !

Agree with your suggestion that we should treat zero-sized
decoder as normal one, I'll adopt this in v5, we won't make
it special case.

v4 never reads a zero-size decoder's SKIP reg, so *dpa_base
goes stale for that layout.
3 fixups from wiring the sketch up:

1. cxl_dpa_release_region() needs a return after kfree(), otherwise it
   falls through to __release_region() on the freed, never-inserted
   resource.

2. The zero-size resource needs IORESOURCE_MEM flags, or
   resource_contains() fails its resource_type() check and cxled->part
   never resolves, leading to a part[-1] read in poison_by_decoder().

3. A fully-burned device (decoder0 zero-size at DPA 0) still hits the
   Sashiko report: .end wraps, no partition contains it, and
   cxl_get_poison_unmapped() bails on part == -1. v5 gates the poison
   queries on part >= 0 and falls back to scanning all partitions when
   nothing sized was walked.

Best regards,
Richard Cheng.
