Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853DC38910E;
	Thu, 28 May 2026 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960878; cv=fail; b=V5FNkD1BBSl/HjZ4vwIulm24mFYbuOu1rMjlAbrXfSvc9y0GyZY3fCL9AuFv+pPcatEpvYg48+CYsY85Z6WyO+BX5nh7waN+Ium136yLRBtbWJixuKfo+xGa6ZPp2kCQBX65xgyVCRSZcbwp8qorhy7+MSj6Dridz5UUEL0Stgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960878; c=relaxed/simple;
	bh=aLJEJHfINaL3EBQPMm6N/9XYdppl4/0fKOiMuTCwDOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RUlDFxMp0fkzxJcbW5LwNCQzW3RUEJuM9x97RzvOJR4c5iriY0qoqcaXJYdwqxHbfyoT9IywpfuT9aydceNVuWpdrq/bG9XGCKb/fHyGUI8V1p/LyduzDNZrPfHqz8C5rjAhLV/GTNNIjDV3toLI21tLFxL3MCsUOyjp75tpJtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PfDMNmfh; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PfDMNmfh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuAF3VcW2tFBrZAQ09iyS/cRMmVCS+SjBQg0RVhM+H4C4VU6mQE+jd3MRDg+ciCP12G6+HDfmQ2QNwkWsmPfhfly0SqgjLhYX/SBwyL9bdS0w+mGhPEUDpJZY0pLAVq+N+4jnjCj7xA9rvZowinwZRJBGMna4C3C88hh+aCm4oXiwbmI2dTV5BRjzYJ93l5W7+WCxh1A/uaOnU/y5dXuvzGBYu5N9eda6s+htxNkt1RTEkztX3NvHmuNOTOVSjekW/Dd9zHw6puNcFgOXTpz2Rex74lzgMa7XIYZKGMoCsIztjWmcGiBWIsthC35Yewex7dbU/1rQdKTnzaIOV9NmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QyTxXThfCvjgN18wjJkk/CQq3EN74xCF+weW3yZcjM=;
 b=XARC5V7H78duxtYxTPs8rqksGjiFDQQieXtreoqBZCTbnhMGYD6IY3A4yT/aCMfAcFHEbLsZWA/mnrQToQUpwQOFiQf8GoDXevN1TzTqFOSSI9ujTzXHa9l2wRyFF9ods8f4KZSZYxkHR4ctu7jlvyKDsgYrV3bMp4lwfX+eH+8x3lwno+bUp5/K4BW6royn48tfXoG2Ch5HrkX24pxQjRLJtqvmsWfTp3GHh518hrXc0ameUhhHV+trb6bO0A30wc/IihB+ihrshlvAIW0l+gCEh2CKbRubv8ZIhL3c+kSHbQWw9rZL4HKxYZgE5Sr6fHJ7HEf2PeRG8aPtniTc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QyTxXThfCvjgN18wjJkk/CQq3EN74xCF+weW3yZcjM=;
 b=PfDMNmfh7ql23BP64itgBnnFKvzu0hlvOCIFtRIoKA9qP8VR+91i9IUH9wtnNbCC6NXeTpDmBpKr1XuvSJMW6spPw78eRZ651PvCJ0I9hBNzvQmGkeZEYA26dMx88AO97SmOxh5TfR5YbLEi7uFwyYIjB2fU9tBemOj0fIwPcJ8yiuqc1ufHr8dNvWEsJwE7ZhuRa10Y7vtfhdUs0PoEkplkR0EJ9DvRJUWQM8HGcCeMrK/wadkettzMY6kiWiB7X6JGYBW6UF9kskqPey6GIQgbDmOXyLhA+81IX65dP3LvdkXNHg4LqBE3xHWfKSaaunquucGmKxQKVxFheH+CGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA6PR12MB999200.namprd12.prod.outlook.com (2603:10b6:806:450::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 28 May
 2026 09:34:33 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 09:34:33 +0000
Date: Thu, 28 May 2026 17:34:21 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com, 
	fabio.m.de.francesco@linux.intel.com, rrichter@amd.com, ming.li@zohomail.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, newtonl@nvidia.com, 
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH v4] cxl/test: Enforce PMD alignment for volatile mock
 regions
Message-ID: <ahgLr89fPslB2ZdL@MWDK4CY14F>
References: <20260527090332.30002-1-icheng@nvidia.com>
 <aheU6K22fzjoZeK8@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aheU6K22fzjoZeK8@aschofie-mobl2.lan>
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA6PR12MB999200:EE_
X-MS-Office365-Filtering-Correlation-Id: 420bfac3-210d-4376-a2c0-08debc9c5017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099006|4143699003|11063799006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	sWQgXa8iSs3Q9ozgpoX7iTdGFa7zFElm6u/oSmdBflidK45nCDI6RCjfhup969NYYvEa2ujxmMDGzIhz97O4v/AGDOWp/R1YX81CDmV1bnKnIhVAyC5GICMEY4HRu6XAAlB/1YCGCw8GTDhmTjFetZ/HmTxhI+UQvkdvEPZpbh8ebwuDR31GCFfvYVXKd0y2bf3gU6qbw4d/O76WTpL5+Lg0JfT4+v+O9FuYDYEN/Zw36ikR6wG3rJL8veu2SiUaptDL07lrsuM0LHUMYBamcfwu5LSMDUT7BOYog5RxdKY3fwE/mcFg0YbDbWasEqwEbI5/exXpXb55qLYEoxRHRLQApNmNuRMvxJ6ctrmMZlc7u7IiQO1gKfA4z0dZCL36GRh85CwqSr6r0SuuduhqZVPRjI1drCheuOsricKH5xX0TRWz0z10D4Wui/3hgjy4zsRUGofm2322A9OGc/kpWiRE0OpyL6wUlA8/4VDDF0bhK9uBuBa0B900d8heuqS/P2bWt596DhKmloKy4amWgGQW9XGCR2neRfxhxvEq9PLrNGhRnnGQLmRqzu2MThzAUIn34AnCW0ccdRKWSlJjOYvP0jt4M/PHDbg8fY6H8isdU4PAp9MdeuZ1IN2IxCC/kpJtLSw3dDNuqAOaOBqk8YodQ0zBV/evnfBCc/LZmL2kSEzyn5hEkmCGAhTZZE/J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ANk2HwRyYDzOCjqoW3GkfH4inE2SPR5JNOLAIV55tu+VU64T68D89QGlQ3fi?=
 =?us-ascii?Q?s+V1YhIFQF84qqmAkLi5o4Sn0p+G0LTYH7GxZbUjnAFmY68NhiDp8r06aan2?=
 =?us-ascii?Q?KW74sVhFm/cCO+Ns5klVVfygEnx4pc624bY8r6YpSHjA8ivMqlfhLg+xdVH8?=
 =?us-ascii?Q?o8tdiKbnzqLKl25GyoX5PziydQOhmanXMVj+e7wyVp6zHfiaKuvEkuBL8IOf?=
 =?us-ascii?Q?m+M9NaKfBBZzHXmQazq4CWrfsK7wK5L33w1X0lAEYHRiwDbeuzJA0WSH/vhx?=
 =?us-ascii?Q?NdzAvmvbFSmdkTZuRJvTxBHH2xnvCVPJCVXmEwykIHW7fT4b6pMFHKIMchFM?=
 =?us-ascii?Q?xyCNtjGPpck672dNHCHzJYWPWseahKdLMuHFBnsoylI9eGqew1at7ZfZpjHN?=
 =?us-ascii?Q?aB69y93vuW4vparP2LRVJKANhQ+AqJvvwj5USHQH6H5C5BMLRPg7eYjWY8us?=
 =?us-ascii?Q?iNQhm7XFK1IVS+DmzvUmlVVPSe1qCG+9PDZF6GE7TXC0abdjfx/MykaTtawb?=
 =?us-ascii?Q?Pjv4misWsOpmE9MfTunsVD66GPQroPZBh3R74KBsAGQjwrlDFAgzHwjIekEe?=
 =?us-ascii?Q?DDhGf/+5VqURvAbQy5Cj3TmPb99LNkLqwI/vNXrKqckEn+YhY4FmeWFFi//V?=
 =?us-ascii?Q?MZ/TuKFV9yxPT+UcE6tORgkBoV1M1xKbqoGsLpU1cXsF5BfCafv5SqDEqfpQ?=
 =?us-ascii?Q?rxfc29j1qwRHvsPQutj45i94I9zrSFD7XooasCf2XxRCsDBG1kRzGJ/C5Apt?=
 =?us-ascii?Q?6ZSDZI5P65gaM22vl175/SutRrRGAEO29G7QBKJbVWCnAVXztk4+HxxMRR42?=
 =?us-ascii?Q?ag1Ob0d9nxmAb1x9TVaM87WLkNji2V+vJZs14VIGD0l4uS4AL1JwH3xcJMXW?=
 =?us-ascii?Q?Jdk2dgpcOs7kZnscVC0f+duuxt53Fq/3gFkKHHx5Fy0MVnj5zvYuGSxyQivP?=
 =?us-ascii?Q?w4hMZPqsM5EVs7pz6U9i+li8VhJ7eTvRCazgbU4VY3Nne/7H9RsyXyOfB0Us?=
 =?us-ascii?Q?j8qCT9UmDTVCYsrGTwCvo3qrclmjt0hntth8fRjXyiBDh2i4OUpDfEZ1eg9s?=
 =?us-ascii?Q?dYUOOlRp66xgfcuT0n8+ZvUSN0OWPzPjZD7q7Rhf2Exhec6NgArh75if63L7?=
 =?us-ascii?Q?81whYksJ34OWTI/LUpdd6RbpEaP1NCSq7dZ870jsckJ+t6BIouKQMr+5s3NB?=
 =?us-ascii?Q?FYfIhEWhDKr71DQVxRVFA9n7vI6TR/ZNQTI63+lvufnxt1YYoDgzaTQp/wQc?=
 =?us-ascii?Q?bqoKxhpfZ9vy0U42gNFuJ+jL6Xw6fpH1uf3i34GjSyb7WhbU9/AB6QbcK1YI?=
 =?us-ascii?Q?SHfdmXoy2mk55/Cb1FrotUEneg5oZqy+VL62kfoEFu9aVKrHcsWjo0hFCyYT?=
 =?us-ascii?Q?Abtf2kFZ76VV8XJM2RLxl2F266/IxJSDuHssUh5O1hP8eec8qwQyE+IPoVYe?=
 =?us-ascii?Q?6cMX8auYNHGFnyXVoAAoTkTvJpRg8pmpiD900vqs4D5z714o7lYYUaPJ3VOU?=
 =?us-ascii?Q?l0iPY1JxKQaPxzWBIfRMKnbianyDfVi7eSiiyh/ajd+aAzFxGLUGGqYxvq1D?=
 =?us-ascii?Q?CFB/OUmMjWEqVqxOLRsUWWMy5ApTpaHvqVcE2RS1iICr2Paej0FOiGZsCHOG?=
 =?us-ascii?Q?NYlvZuuy+xbs3zX91O+ymif6h0XekcEduBf6NW6bAxVHir/a0Ec9y57lMGNW?=
 =?us-ascii?Q?rBAX3RJuBUFN0hQ49vpyV8FP5lk3pUKqXHr6ra8DDHuR99cgLJ4gPelkp4+j?=
 =?us-ascii?Q?bunMnKxXxQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420bfac3-210d-4376-a2c0-08debc9c5017
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 09:34:33.7141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keRkBidGl4kT5dHyZOwQgAZ0czSv2uhsikoVJ2UuphyZjeBHg0sbrQ4mrvoakXZEJHdmpHUCWowF1B1xMoXiJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999200

On Wed, May 27, 2026 at 06:05:44PM +0800, Alison Schofield wrote:
> On Wed, May 27, 2026 at 05:03:32PM +0800, Richard Cheng wrote:
> > cxl_test allocates synthetic CFMWS HPA windows from a gen_pool with
> > SZ_256M alignment. On arm64 with CONFIG_ARM64_64K_PAGES=y and
> > CONFIG_PGTABLE_LEVELS=3, PMD_SIZE is 512M, so every CXL region carved
> > from a volatile window inherits a non-PMD-aligned start, and
> > cxl_dax_region_probe() -> alloc_dax_region() fails:
> > 
> > """
> >     cxl_dax_region dax_region1: probe with driver cxl_dax_region failed
> >                                 with error -12
> > """
> > 
> > Enforce that every volatile mock CFMWS is PMD-aligned in both start and
> > size
> > 
> 
> checkpatch is emitting this complaint, that I believe is a false
> positive, and I'm happy to ignore versus add ugly code to appease.
> 
> WARNING: Comparisons should place the constant on the right side of the test
> #36: FILE: tools/testing/cxl/test/cxl.c:321:
> +			.window_size = SZ_256M > PMD_SIZE ? SZ_256M : PMD_SIZE,
> 
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
>

Hello Alison,

Thanks for your kindness,
I ran into issue when running checkpatch script, that's why I tried to edit the line in v2,
should have decleared that more clearly.

Thanks.
--Richard
 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> > Changelog:
> > 
> > v3->v4:
> >     - Replace compile-time BUILD_BUG_ON() with runtime
> >       IS_ALIGNED(mock_auto_region_size, PMD_SIZE) check in
> > cxl_test_init().
> > 
> > v2->v3:
> >     - Correct hunk headers
> >     - Add base commit SHA
> > 
> > v1->v2:
> >     - Reframe from "fix start alignment" to "enforce PMD invariant for
> >       volatile CFMWS"
> >     - Bump cfmws5.window_size to max(SZ_256M, PMD_SIZE)
> >     - Gate populate_cedt() alignment on
> >       ACPI_CEDT_CFMWS_RESTRICT_VOLATILE so PMEM windows stay at SZ_256M
> >     - Add BUILD_BUG_ON for MOCK_AUTO_REGION_SIZE_DEFAULT v.s. PMD_SIZE
> >       in cxl_test_init()
> > 
> > Best regards,
> > Richard Cheng.
> > ---
> >  tools/testing/cxl/test/cxl.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 418669927fb0..6f8fa7504cad 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -318,7 +318,7 @@ static struct {
> >  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> >  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
> >  			.qtg_id = FAKE_QTG_ID,
> > -			.window_size = SZ_256M,
> > +			.window_size = SZ_256M > PMD_SIZE ? SZ_256M : PMD_SIZE,
> >  		},
> >  		.target = { 3 },
> >  	},
> > @@ -495,9 +495,12 @@ static int populate_cedt(void)
> >  
> >  	for (i = cfmws_start; i <= cfmws_end; i++) {
> >  		struct acpi_cedt_cfmws *window = mock_cfmws[i];
> > +		int align = SZ_256M;
> >  
> >  		cfmws_elc_update(window, i);
> > -		res = alloc_mock_res(window->window_size, SZ_256M);
> > +		if (window->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
> > +			align = max_t(int, SZ_256M, PMD_SIZE);
> > +		res = alloc_mock_res(window->window_size, align);
> >  		if (!res)
> >  			return -ENOMEM;
> >  		window->base_hpa = res->range.start;
> > @@ -1826,6 +1829,12 @@ static __init int cxl_test_init(void)
> >  	int rc, i;
> >  	struct range mappable;
> >  
> > +	if (!IS_ALIGNED(mock_auto_region_size, PMD_SIZE)) {
> > +		pr_err_once("mock_auto_region_size %d must be PMD-aligned\n",
> > +			    mock_auto_region_size);
> > +		return -EINVAL;
> > +	}
> > +
> >  	cxl_acpi_test();
> >  	cxl_core_test();
> >  	cxl_mem_test();
> > 
> > base-commit: 507bd4b66c85d5b65696150cc16d31ac0b2ab151
> > -- 
> > 2.43.0
> > 
