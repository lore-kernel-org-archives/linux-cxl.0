Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013020.outbound.protection.outlook.com [40.93.196.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A64F2147E6;
	Wed, 27 May 2026 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779854903; cv=fail; b=YNiimoKVgxYgy5cgUhx7yDklgYK3Gi/Ks3tviELCtFpb26RKrPAfRMYiFtrUkgjXVAYCVq8ySrzGeSViIp5lroGlzgJD2W0Kgmg2q4DEf2aiLzvEWxXRAXin0hrygpDna3kKCflPUvK9tfV2nR2ZtU1GJrWp+MuVZpQBusx8mZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779854903; c=relaxed/simple;
	bh=1xxqzidWl2UGmvNS8h0phb7d9ofUtw2l/ib78K8Fc0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kPfHJFSijN0L9xax0/tl3jdM67CXa0KAfbgaRC2I8Iyj5vSar+KI5OEp2vSzx9e22n85rcU2PHcA3bipbIjDYFxjxJNu5R3/LH06kmkiwJqva9f/a9it00SfyxbPZQMqPR4bKmBB2ZbByBT4592QMCKI4UMEcMRfETuSoEeuHAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZJ0g+d7M; arc=fail smtp.client-ip=40.93.196.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZJ0g+d7M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXUSr4KvDu1KUEfmdvsr76UH33vP2kLGE/8+cDFOFWQntW3z8Bo4WNCTT7IXDBl++R5b65PGklj3EfSOykAm1LcUVAB1tv088Phe9PVXI0MCR6mp5al279fbkKNU1bLbIQjP7rlW7vvYe3h4lhAWIQj4eqa0gzrHLU+dMGsr+s58AT4n+XuDL0SCxCNgmDx5GexpCnPqlty6RRdJkjcICLc+4S/Mpg2I9kavLBduUCXHTli6FAceo4gf4pDRHXUSUYSSlmwFtosO6ki5fVg0+YheNKOdkh+uN2cnxfC6NRd947I150KhXMHOR/4B6V/EoPn46ZT4GXoEbtx4BcrhGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2bLnk+Vxqw+rNY5WKkWVyKb8dc98EYvfY23PrOZUzs=;
 b=NDofQu2MwrvsEW9oHRh86vv0OFHP4oaCes95Rtn/w0q+mINz3YkzPXRupOVUJ/xME4nqooaKQW8j2+w1b7Dc1V/F26ZXcnNVmorVNBHcWsHwZcF+qFHXI3t1CuzOGhnGHqDKEp5qot1uEonMXIjQb7jMjzNmdsbgv9AAfgGJ3ngkK0ccqGXOi1cJeunKBLMveURz4bpoNJpnV7zL4miH+ZlI7WM+7/n6uWF6vFWLaTGcVzR1rh1y5D1c67+tj4aXSWzifeHWvJ5t6GJXfF2kc9yQ3ab2bJAsoWbDCJLkAPtNZIxkpIAW69Zr4Qytj9IxvYKMtBnrqVzYqLCwklE1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2bLnk+Vxqw+rNY5WKkWVyKb8dc98EYvfY23PrOZUzs=;
 b=ZJ0g+d7McMCjnrmqzwi3RrPq7MN6MA3EcsuHTiCoqSubw23j8a8PeSA7m1m8CoKwdPGRJcdMp1oaFzuWzPb/TstA1aW83724qTw7FZpG7V4TlkH7yCI97wQBk5/KBkeeTQV2hGrNG3DDYT0AVunDetwrjyQ9g5IdLPU0gUwfFYKCer1UrrckBajXaOs15gftU9MGdSmBZLKSujinA56VjNcav2UkIkpWLU7Q+CwG/BnKhl4Axc1rSezIASnLPQIXGi5asiTg8x5m3Kt+tWu5Hoz4d1oFtyykmJTcFleiRzsXNppzeU9XS9zlSLJNIKTobeF/enp2+z4NosKIYVr36A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Wed, 27 May
 2026 04:08:16 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 04:08:15 +0000
Date: Wed, 27 May 2026 12:08:07 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.ne, jonathan.cameron@huawei.com, dave.jiang@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com, 
	fabio.m.de.francesco@linux.intel.com, rrichter@amd.com, ming.li@zohomail.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, newtonl@nvidia.com, 
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH v3] cxl/test: Enforce PMD alignment for volatile mock
 regions
Message-ID: <ahZsCOIoIt9Ejom_@MWDK4CY14F>
References: <20260522054457.5429-1-icheng@nvidia.com>
 <ahYq-pJIfNWJr4TR@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahYq-pJIfNWJr4TR@aschofie-mobl2.lan>
X-ClientProxiedBy: KL1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:820:c::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: df672854-cb1b-442e-dec4-08debba59373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099006|6133799003|11063799006|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info:
	vF6NragmwutRysi2wkcgbgEg7wDspWizc1Tt5MPJrkx5HiuBF33DdAmuOGBLx7+QpPXXYly6nKavgoEZMNi/l8JCspBUUzP3FiAZY514vDo104/L/bEOBuwH2RpALMJyP8rhCr7AHOFbaI3qMqhw3LFXZddyBk7llnfJzsDONxVtZirRfN7P1VksuRbbMibZs2T2Sw5bFcN8uxl+S6X4r5AtAOQ5N7MUCtaDfp/2kLwmeloPMLrexg2cErI3lrPh70zDi/fWIcfLsJDz5YFGXLCLWxHgd2/DXY8d++NWehiruu+85W5oLhDc/uGzmwmetFDDLfE1as8DSreGnvfZ1vjuBA6hq4OsOR4MskRsrh/kcVQa2ORxVbe6SIP0kVqT71aoRpoJzYaa0GNc/WnArGXgSzIFmGyHuXbSmUmTZmOPsgTBelf23pchP324HchwOuQGQGkC5hLYUcoHW6thNi1vKonueOkjCpSI/UtoJfdkg/4BViX9pADIk1iJ6NgxqGuLKUKU/sVboZpJqzYVrA/KAJSxNsro9FnLwCMa6ySeBalbo+EgrxtXTZWxD/FPHu0taViEG+ILHkL+30vGaJ9QGpJIMx7ai8FWsRoJ6PY/vR+bmmNhvGJ9uY9Q49lhbdQOvD6Oi9StaqaZNXTrjwqICqepe0ourR3cbqxi3l1a82g1kFy/9uybo22ymX2B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(3023799007)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QdwrJXSLawVGBG/bXHd2PMA0H9sT7cpKEtuFO80pVp18adxCN+fxbsMQbttG?=
 =?us-ascii?Q?WAk891VJ2fiqUusdDo+wmJsURZrvlYUN9WKAGkPA2s4LFyxGNI0dNxG9xjpv?=
 =?us-ascii?Q?Wv0Pt/HUaDqkHGzhHlKZffU0WMRpKl1lMz9nRLEK9coJ5Evh31Kmz+3xPpdN?=
 =?us-ascii?Q?gX2Sw2v4a1q3XhBRS1EzAMKtGo15nMRj5/mXL6HKrVMXEIrwguKSi8vtOK68?=
 =?us-ascii?Q?N8G2XmD7cBEoxrUVDpJy0KFJOsMfCgYYboO/Oq8QMm8NXu6FQyym+/Mu53yQ?=
 =?us-ascii?Q?aSHkfIFaQq8XjRz1Gvl0uUCIRCB7SGflcwMFHX1ZlQ0AsNCSj3odjcL+GY3k?=
 =?us-ascii?Q?HN27klYD06AXDaKxZHT83PrtiYdsZkWKvAX1e30FBoFALjo56X9jnu9I1IRR?=
 =?us-ascii?Q?kDfo0nQxOGhwWBMWsm0V8pKJKkHL3HsBEOY0VRXa5lYIUPU6GSxAR6uqmRLD?=
 =?us-ascii?Q?rjLoSmemnohU9myFnhG+OJiPleENT/S/PkMqvXiV0rPPLhm/GXX50mD7DRU7?=
 =?us-ascii?Q?SJfz1ZXo/Hk7sflloo53nAdvtG+RdGoZ3UMkZDd8XNCU5wlwfTbAvaAamiB9?=
 =?us-ascii?Q?XC2CZMvQHC4l5xygOjMY7jy6eVaW04rzqT04b4Vu/svu39Awvc/2AQnw/8fX?=
 =?us-ascii?Q?T4i6plgFO39vlQi0ClTbOfkwsD1qW2FN8AYbYDOdWiqyIsg0QbmVYfhEtnWO?=
 =?us-ascii?Q?7UFgr6rVu5epUghVu+bhg+8R/fBM32WOp9TDmmjQxzBzZKE1TfPPyXrr51lw?=
 =?us-ascii?Q?vBeEtYipmcKzcPzhVbkgac4JS1VNdHfK/8K3WOh7aON77sxahO8VPHxKplaG?=
 =?us-ascii?Q?czZC7SzelSixscd3mxZNjn0W3rml/QBMfRTkY8W4QFzbhgdw/BWFEVE+9QFr?=
 =?us-ascii?Q?ujpmBa5TBLA8lG4Cs594UNUZDBP8jOkixovFCFm/0vBEFT65Wir4iQ3XmHkD?=
 =?us-ascii?Q?hdyiwYpGc5lZyHw93KeF6yz2NFiV9vHdQvObhrW8k5MtQCN0k8an34pZ4Nsu?=
 =?us-ascii?Q?oDlS0qseDe/xFYs/vNGrtHK7oU69P5G1G28Vei/P4aRFfs3zTOVzNJZfjkXM?=
 =?us-ascii?Q?GLxzNqVLYUxeneT0Wix3k330oFmj9FSeJa3J5/3YuIYjKaOqasxWxAUJRxff?=
 =?us-ascii?Q?Ff1l+C7kD8Jhe51xmqzS6CPgPgeFKsyItes49bNoPpprWMrxc30mdjLg0VmW?=
 =?us-ascii?Q?c3GjRox2SMyEVEj/XjaDPGvbuWlyyQgXVxUmOydtxYqT1Crz1832R/tFEkGz?=
 =?us-ascii?Q?FjF4BSwRMUHjbClkMNrZ7zStsOLC0S6F1cu5xvKb+2vOTJoUY+QRAPJ1LPxG?=
 =?us-ascii?Q?I7dglfDqN2ZxkVFb+mT/lFq1dZQ9sa3zw3FF8EhBGkcWV/Mn1tcXS1r0ul1n?=
 =?us-ascii?Q?xM/lfFsNh10pYz/kTGDA/0EoRHEAoCQifFGBWsE2zzggzncIZnvHF5/I+RXP?=
 =?us-ascii?Q?6uwu/WysXPYNBBxver1ujxxEnc4fiPWq+hRVJM0iI+MX5YZsmO8R2U4AGK7m?=
 =?us-ascii?Q?Itbj0Jo26gAfNCnzocOSD/AGko00u3oR1l2JXd8Bi5tKDWbWPwdBRBue6phR?=
 =?us-ascii?Q?UZUwcWtLkLZf/FgBFS32pPC9r88HSsOaGfihwnGOXdZOnrfTnAQCqE7kFvkB?=
 =?us-ascii?Q?GwHi4GUBey89bOnojATiaYghUMCFDR9LuK6JKyvqaSuwzJbPbEj9GF3justY?=
 =?us-ascii?Q?+3gMk8fmXW5+X5VNWR/wYHQfa/pbmvDHpP2MbepVF79OXuMAIa5O+GdoS5Ya?=
 =?us-ascii?Q?ohfoIyf5cg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df672854-cb1b-442e-dec4-08debba59373
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 04:08:15.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjKyh+VuNfcW87oSbg2ahnT2fWCpN+oh9b7HjN00B4rCvssgsMi58WfhsQTHbm2sjNGtsjAqYx1vPw3uq/a3ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218

On Tue, May 26, 2026 at 04:21:30PM +0800, Alison Schofield wrote:
> On Fri, May 22, 2026 at 01:44:57PM +0800, Richard Cheng wrote:
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
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> > Changelog:
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
> >  tools/testing/cxl/test/cxl.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 418669927fb0..7a1105f9a0bb 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -318,7 +318,7 @@ static struct {
> >  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> >  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
> >  			.qtg_id = FAKE_QTG_ID,
> > -			.window_size = SZ_256M,
> > +			.window_size = SZ_256M > PMD_SIZE ? SZ_256M : PMD_SIZE,
> 
> Why not this: max_t(resource_size_t, SZ_256M, PMD_SIZE)
>

Hi Alison,

Thanks for the feedback, but I doubt this will work.
"max_t()" expands to a statement expression, which isn't a constant expression so it can't be used in this file-scope static initializer.

I did the change and compile, the error is
"""
  include/linux/minmax.h:86:9: error: braced-group within expression
                                allowed only inside a function
     86 |     ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
        |     ^
  test/cxl.c:295:40: note: in expansion of macro 'max_t'
    295 |     .window_size = max_t(resource_size_t, SZ_256M, PMD_SIZE),
"""

So I don't think this approach works, I would like to stick to ternary form if that's ok for you. 
> 
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
> > @@ -1826,6 +1829,8 @@ static __init int cxl_test_init(void)
> >  	int rc, i;
> >  	struct range mappable;
> >  
> > +	BUILD_BUG_ON(!IS_ALIGNED(MOCK_AUTO_REGION_SIZE_DEFAULT, PMD_SIZE));
> 
> The rule we need to enforce is tha the actual auto region size is
> PMD aligned, not the default definition. So I think this needs to
> be a runtime check of IS_ALIGNED(mock_auto_region_size, PMD_SIZE).
> 
> -- Alison
> 

Thanks for the catch, I'll fix this and send a v4 to make it runtime check.

Do you prefer WARN_ON_ONCE() to be ammend or no? I mean

"""
if (!IS_ALIGNED(mock_auto_region_size, PMD_SIZE))
	return -EINVAL;
"""
or
"""
if (WARN_ON_ONCE(!IS_ALIGNED(mock_auto_region_size, PMD_SIZE)))
	return -EINVAL;
"""

Which one do you prefer ? or any other idea ? please let me know and I'll make the change.

Best regards,
Richard Cheng.

> > +
> >  	cxl_acpi_test();
> >  	cxl_core_test();
> >  	cxl_mem_test();
> > 
> > base-commit: 6779b50faa562e6cca1aa6a4649a4d764c6c7e28
> > -- 
> > 2.43.0
> > 
