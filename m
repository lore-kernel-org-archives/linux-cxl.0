Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC41F0E49;
	Fri, 21 Mar 2025 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552517; cv=fail; b=Ufw1CDlRtHxJGalrV9eJoOz4kZ+1d+VHinYyj8P8MoA8kMiHZJfy6w8NOcNPo8KrSKn76SIBX8lYN7MHc9SwwqtPTApiH46V3cigiG+P4mxMcyZZU7EJvIkHoCxarCm73EYfasi2+/lQGNoVzDx1JTQU2mMXShYoz11T/F5kEAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552517; c=relaxed/simple;
	bh=AyOGS5XYWRjJpmSdZlgnnLJLZfZ1WQWWq25i+nRnbNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K0Xd1p/AisyO4Qxo6P1Lpv6FjebklRXzkyl9X7D+juG6MIy3K/WoFKHiQw8BIzd8rHmSAdmrJ2xlCI+ZC7PJPq0DjihwCxS68uGea5c4JHikuwG2UDtjbzYQjS5amgAmghbf9Mt2FiiVctIgKS7a7vEQa3isFXYdrJ9oDr4Td0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d/ov1Q/v; arc=fail smtp.client-ip=40.107.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d/ov1Q/v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBKCyM8IMjuvInD2sO9JzidzyTMa/3aynkwlDIT/EHwdRLjJaAI7JPtwOndEve6ViXWm7jVvSQTy9CfwjXGVsXsV9j9LBLCTXZ+SKuamWz99pLO0n5HDLkHfY7+eevpD8Da3bQMC0nK0U3k7KugKtQbi/3SSgDNdHExuQJBUjtQq+qLdVdomYZhhXJdPHxESUh1ovRlmoyvu6h9An9I3Xv6gF58wM+uusbvLPeSo/5RxyEhfQnI1Fgu66vac6atRgefnr/fZlx8veh27ZtU0uLb1tuQgKtqVA7am8KzpSTVJv0NUdJ2JVudOcjppUNxTQ2PrL7KKAqJ9M7+YxUwh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvaoQ9SmFTYor7Zo5gp0klKM6L/+s1AXwP5b0a44FLs=;
 b=sYpdjko8F8nplA+nqTKy2Z0PPE9ITF/dlxJAbKd5NEsI7e1FxwJsKEuuv3qeDD9HclYyi7Xte2MxsRWt+Capbe5H1j/eExi0FxtkfSVgIAvkyzscAT0fOj5phNpOWWi/lRJGU99qlD19/mGBv+5VCASOgPgK2+yC3NJcUv6N5WZeLpjMh2f8/UrmLai57LRZ/54rJFQ6Ix03xA4WoXZslEhdudE+6UJEvxElbipZqVD/X+/bKn/Fk6arCM0i7vaXG9M05q43zlqhVD20lcVILHS97C+iUkTJfJgfZQ6Qq6gLLKteXWYPEmsIz7TCT6hfYbCf9to31pShxsit6nSFcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvaoQ9SmFTYor7Zo5gp0klKM6L/+s1AXwP5b0a44FLs=;
 b=d/ov1Q/vIGt6smsdwpeQK8UWCojlMACY5qQUeag733PP42hCwnSj/tljuF3yPISAYa23GzeqpF9qoUERLYvJydjbgHgnNcm3gYzI2beZdfMxjTDAUDFhDT4tm4aNW7esPpEaVgRDcO5qSwk6UAVY55d0G/qvEtER9b80+p1vT/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH7PR12MB6883.namprd12.prod.outlook.com (2603:10b6:510:1b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 10:21:51 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 10:21:50 +0000
Date: Fri, 21 Mar 2025 11:21:44 +0100
From: Robert Richter <rrichter@amd.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, ming.li@zohomail.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/4 v3] cxl/core: Add helpers to detect Low memory Holes
 on x86
Message-ID: <Z909uPbvRVlZ_J1Z@rric.localdomain>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <20250314113708.759808-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314113708.759808-3-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH7PR12MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: 620f23a8-cab0-4253-0682-08dd686231b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?llgDK2ttFlWtK+K9dU7PR+gR5TBUstVXmyuwU5jzg9AFZ2DH5dTD0OnuOs6Q?=
 =?us-ascii?Q?v+kueBbGKR2rEx8KfuzaWTacG5Nu1uOmtjzyeNKSTMPkonGWik/VejVD8KYh?=
 =?us-ascii?Q?GnGsfmtDby9a7IB6Ka8BpmoIlPGybQuie0c5+ISek/CM+r+LsMoEX/8Zk+c2?=
 =?us-ascii?Q?SVn8aQCYUUKBlrmXhy+IyZ+e6lJmaGr9DlK5CNLQCz+ST3I8MQbkkOssRrml?=
 =?us-ascii?Q?Cal5VJo46m+VjfQFl9lFAQ9bNNd7bEDWHnLi2SUiL/Eb2QAtUvoWZIG4h2wh?=
 =?us-ascii?Q?ugKozb8tBitsWJvS2NL+94/G8RrtLB6MsvyFtHyscTFqzegsOy85FIlkqYVj?=
 =?us-ascii?Q?Kra3pqkT42sjyZo/qiuknOs0CImz3ezgMphrGIrXgQUKfTjOOWlN519leshJ?=
 =?us-ascii?Q?XH/PYU4VuVLwV6kYEY5/R6oj42KwpEvy7n/mempm7jF8bIa/NSkX5I+VFETL?=
 =?us-ascii?Q?slaAZWdjVA7oA7v4inZmw5DO/ySR9eMwG53BaurbQF2/+IOrkHxsyyEVPqvQ?=
 =?us-ascii?Q?UXnS6sT86ck0+HbHaU79PWHgbnlFpRARdxi4ZUDOoD2cf5iLPcXytDMFWZQD?=
 =?us-ascii?Q?JBR8xCxZBH/SSBWvO3a0f9v9iS4z5GIHVryajbGvYRMkWSsfmjObSTw3ACB9?=
 =?us-ascii?Q?xDSZSQvZ+aLz4OgIss+6ozEyzLKmTjMAbOwTxRpZZZC1AGvLQCg5BRlY+Q8p?=
 =?us-ascii?Q?YqZTdxp4EGr5Trpq7blxUmnEPnTFH4gyxH55UHf2cmvYlKZ0royBxv7iy8Uz?=
 =?us-ascii?Q?UWEcu4wft5WT95PN51KR6eGwicO3n6Fg44kxX/AwTt9buxgsj4te8i5UVegw?=
 =?us-ascii?Q?nijpw6AN6lCc66cciDkYSAyqIB50gFMQjv8KfVyT4o/9qXZw2bcQ87+B14ah?=
 =?us-ascii?Q?qjr6XOHo7GOd7q2LvLJ1fRZBAoLosEYOJxFb6zKa4PNZVWM+rQAhma2XyGzi?=
 =?us-ascii?Q?UCvDXUDKYjigOedDB5eiX66k2PcuPxXc94qDvYaMG+NjSm+G/pZFHdyfga4E?=
 =?us-ascii?Q?f48yN7LoVMsdUB3+yPuCsXYKiAu0pknVrbu/quSuB1qbmXxPpWWvP2vU9jwA?=
 =?us-ascii?Q?5pcdPd93LF18UkgvwINjS8un8BZwYMouJoAHXjCYC3cjsZf/H1cmIRDrgK/Y?=
 =?us-ascii?Q?nLS6oN/qMHiYU5Mrx1uEMgkBdO3ndBeDcadrraarHJz8/ydwuEq9Nn+wUpKv?=
 =?us-ascii?Q?3PjgfgjZXFE5wn3nCBvbIBSGrlAkPcP1yd+U0N5BPAK/CoaQe057kB2/P3CT?=
 =?us-ascii?Q?cFhbNYFA2AvtO6npR+BGEpcTTUkuVWA9QpWvUmWbFfKRHCzhpAz57Ft1RZaQ?=
 =?us-ascii?Q?ptPeG4f4fmvvV/x7GyIElJKr8Tc+7pgLJKPlIUJn8XpLW8f3sLfcuNtXlO0n?=
 =?us-ascii?Q?i6QgRtFZx4h9Wm5OXcY+BPvXqFN1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DscLeFar9rVlrJUaW4zZJr7vVZZE5lyXRSj/IodFSKCCv+My+ZDAbGxLtTkN?=
 =?us-ascii?Q?pUUHpyzPB/+VF5e+DzPpbKaHNZje5ZsCvjV2y8HNLG8NKdxGipmPFRCiFAO0?=
 =?us-ascii?Q?53WFWm1ulR+F/lyjeQvkQg90OZitKYA9TP5X+vfS6bpsLc2xFEVzCzejIZUE?=
 =?us-ascii?Q?kGKAb43TZ8mVemS0h0MfRg5BCz6O22F2sBEAehmiwvU8tiBhIRAdyoV7xykZ?=
 =?us-ascii?Q?Eb45alOrt7cZtuLx2r0qmaa0+vbkPS8IsLtkLTEuIa1YbqRLadEA7wawHmJu?=
 =?us-ascii?Q?MddlVOBsyEExhBAEtMgiq8srvqe+dki8JSbzicqMbT9U6oYFY8tHv7fi/bh7?=
 =?us-ascii?Q?6JD5xL6xR/tpmE6jv72ncTH0ZQWzzeNwBWv8E/WzvaKVOkU7eo/qpuzvLOXg?=
 =?us-ascii?Q?kBnEYRTFoKeS2mD/77S0uRpdrDNGZtfpimNUjQyZ8SuxorejBH2SUJo+CPsm?=
 =?us-ascii?Q?w3+GKQStq/MvEleLWl9g5k/1v/IFXCBn3ZoePcDQrMrgV61lUrZ9DGDw7gn/?=
 =?us-ascii?Q?EPPv1Nw775onvxyvfE9t1DRbenioLYLF7rdPiba9kLZrJ4KT0ojZc0RfZcBx?=
 =?us-ascii?Q?UdMet9XZylxQypUzNFoRQlGvbKV6mlhKtUc6ITo0WKdECANAfpt7fNvwtuHR?=
 =?us-ascii?Q?tLs/9e2UKgluhM4La6zY/u58UNUjHABTvYrht8uZ7BYS5PQXEtiZONW000qa?=
 =?us-ascii?Q?BJFTmWFPrvnFBalPYPF2of+/b38U/kxabRZ/wfw7cgFjoeZl81HbgcShdeqm?=
 =?us-ascii?Q?Q5i86Xqofl1TNWZ8gw6m2hUJA+1BvbpaMyckyPj8hzGvpYh5TPAaC/LRVWZD?=
 =?us-ascii?Q?TM+MBqBZVvJyMv2Kjm12LSqc5SdBCO9nGo6BDcwXmsm5j3lgEmUSYNwh3k7i?=
 =?us-ascii?Q?SWLS6llnfe4MntXQmhwmVdRQa6u2OKO365iLxtVg7gnQaNXNduW9v5u/5TMJ?=
 =?us-ascii?Q?Z41GQyMN0GeLJ5hc+jhm1f2uiY760nJ2uvUEjBewxtRBEy3iAmPtRl3x3n69?=
 =?us-ascii?Q?/QpfDSQHhDnTOQNKs1OWjIdwrdoPOGhw6JmGGv+Ek7hhq2X2z1Qti2X1Xg2g?=
 =?us-ascii?Q?NbQ/YXGc++e0LpeaHDDCCtWbA9mWskCEBv1IZwztP9lWJQfZdx1U1w1aPi4B?=
 =?us-ascii?Q?IcX2o8+2vQtaE1fq+MN4I3SwjxuCmo5C2EOsOMDDXV8N9C89zOsmj4Sx2pUl?=
 =?us-ascii?Q?pJRUmJrEOHzywzfaI4SPYofdvbSfxkLnRySKFWf+yMyQbS9AL7zptcE5pIrs?=
 =?us-ascii?Q?af6GFGT3wrhv5SLwymNxJkS9TbLxxNPRZZp7M4rOYDdQrCca5up7rFKrsnCr?=
 =?us-ascii?Q?6KsFDj62BQ0lcWxELhTIYKbZyjjAMsqpXV1f5dZYFK+WisLKhJ5qXva3/xdC?=
 =?us-ascii?Q?ImDQ3+F5hIDxTdy2mDYawAtFIoEZhUgU520CI/mWo4NdKJPcsbf0MyCQewyM?=
 =?us-ascii?Q?ipdxuG00c4VHWzdGtZQ9UQWFa6Sk6bcaQpqGZeXAcyisN2bCbHk/wwph/bE1?=
 =?us-ascii?Q?m0a+sZSWtB6QOvn76Rl7Egnrrnu6YwM5tQdrGhBBxFulb8xNuxNjb4LAFbuc?=
 =?us-ascii?Q?3dw4jXkiaHQJHmVloB/WPvpMgyxfFaVqnoY02wH3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620f23a8-cab0-4253-0682-08dd686231b3
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 10:21:50.8220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwQPXBnTc+BdLYI04Xp2sFdHCwVZbm3/juR53i2N7qDKSqR2qj2rjjZOIHD1up4cXvec1+10OGfku56QEELF2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6883

On 14.03.25 12:36:31, Fabio M. De Francesco wrote:
> In x86 with Low memory Hole, the BIOS may publishes CFMWS that describe
> SPA ranges which are subsets of the corresponding CXL Endpoint Decoders
> HPA's because the CFMWS never intersects LMH's while EP Decoders HPA's
> ranges are always guaranteed to align to the NIW * 256M rule.
> 
> In order to construct Regions and attach Decoders, the driver needs to
> match Root Decoders and Regions with Endpoint Decoders, but it fails and
> the entire process returns errors because it doesn't expect to deal with
> SPA range lengths smaller than corresponding HPA's.
> 
> Introduce functions that indirectly detect x86 LMH's by comparing SPA's
> with corresponding HPA's. They will be used in the process of Regions
> creation and Endpoint attachments to prevent driver failures in a few
> steps of the above-mentioned process.
> 
> The helpers return true when HPA/SPA misalignments are detected under
> specific conditions: both the SPA and HPA ranges must start at
> LMH_CFMWS_RANGE_START (that in x86 with LMH's is 0x0), SPA range sizes

"... that for Intel with LMHs is 0x0", not true for AMD.

> be less than HPA's, SPA's range's size be less than 4G, HPA's size be
> aligned to the NIW * 256M rule.
> 
> Also introduce a function to adjust the range end of the Regions to be
> created on x86 with LMH's.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/lmh.c | 56 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/lmh.h | 29 ++++++++++++++++++++++

The split of the code in patch #2 and #3 does not make sense. The
"interface" you introduce here is out of context which is patch #3.
And in patch #3 the functions are actually used, so you need to switch
back to this one. Other than that, the code is not enabled here at
all, it is even not built.

>  2 files changed, 85 insertions(+)
>  create mode 100644 drivers/cxl/core/lmh.c
>  create mode 100644 drivers/cxl/core/lmh.h
> 
> diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
> new file mode 100644
> index 000000000000..2e32f867eb94
> --- /dev/null
> +++ b/drivers/cxl/core/lmh.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/range.h>
> +#include "lmh.h"
> +
> +/* Start of CFMWS range that end before x86 Low Memory Holes */
> +#define LMH_CFMWS_RANGE_START 0x0ULL

This looks arbitrary. An endpoint decoder's zero base address could
have other reasons too, e.g. the need of address translation. So you
need a different check for the mem hole.

In my previous review comment I have requested a platform check for
this code to enable.

> +
> +/*
> + * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
> + *
> + * On x86, CFMWS ranges never intersect memory holes while endpoint decoders
> + * HPA range sizes are always guaranteed aligned to NIW * 256MB; therefore,
> + * the given endpoint decoder HPA range size is always expected aligned and
> + * also larger than that of the matching root decoder. If there are LMH's,
> + * the root decoder range end is always less than SZ_4G.
> + */
> +bool arch_match_spa(const struct cxl_root_decoder *cxlrd,
> +		    const struct cxl_endpoint_decoder *cxled)
> +{
> +	const struct range *r1, *r2;
> +	int niw;
> +
> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	r2 = &cxled->cxld.hpa_range;
> +	niw = cxled->cxld.interleave_ways;
> +
> +	if (r1->start == LMH_CFMWS_RANGE_START && r1->start == r2->start &&
> +	    r1->end < (LMH_CFMWS_RANGE_START + SZ_4G) && r1->end < r2->end &&

How about removing LMH_CFMWS_RANGE_START at all? It is zero anyway and
would make this check much easier.

Can this being modified to reuse this codes for "holes" other than
below 4G?

> +	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
> +		return true;
> +
> +	return false;
> +}
> +
> +/* Similar to arch_match_spa(), it matches regions and decoders */
> +bool arch_match_region(const struct cxl_region_params *p,
> +		       const struct cxl_decoder *cxld)
> +{
> +	const struct range *r = &cxld->hpa_range;
> +	const struct resource *res = p->res;
> +	int niw = cxld->interleave_ways;
> +
> +	if (res->start == LMH_CFMWS_RANGE_START && res->start == r->start &&
> +	    res->end < (LMH_CFMWS_RANGE_START + SZ_4G) && res->end < r->end &&

Same here.

> +	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> +		return true;
> +
> +	return false;
> +}

Right now the default check is:

  (p->res->start == r->start && p->res->end == r->end)

Can't we just calculate a matching spa range for the decoder and
region and then check if both match? Both match functions would be
obsolete then.

> +
> +void arch_adjust_region_resource(struct resource *res,
> +				 struct cxl_root_decoder *cxlrd)
> +{
> +	res->end = cxlrd->res->end;
> +}

This should be squashed with arch_match_spa(): same style and
interface as for cxl_extended_linear_cache_resize(). Please generalize
the interface of cxl_extended_linear_cache_resize() first.

> diff --git a/drivers/cxl/core/lmh.h b/drivers/cxl/core/lmh.h
> new file mode 100644
> index 000000000000..16746ceac1ed
> --- /dev/null
> +++ b/drivers/cxl/core/lmh.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#include "cxl.h"
> +
> +#ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
> +bool arch_match_spa(const struct cxl_root_decoder *cxlrd,
> +		    const struct cxl_endpoint_decoder *cxled);
> +bool arch_match_region(const struct cxl_region_params *p,
> +		       const struct cxl_decoder *cxld);
> +void arch_adjust_region_resource(struct resource *res,
> +				 struct cxl_root_decoder *cxlrd);
> +#else
> +static bool arch_match_spa(struct cxl_root_decoder *cxlrd,
> +			   struct cxl_endpoint_decoder *cxled)
> +{
> +	return false;
> +}
> +
> +static bool arch_match_region(struct cxl_region_params *p,
> +			      struct cxl_decoder *cxld)
> +{
> +	return false;
> +}
> +
> +static void arch_adjust_region_resource(struct resource *res,
> +					struct cxl_root_decoder *cxlrd)
> +{
> +}
> +#endif /* CXL_ARCH_LOW_MEMORY_HOLE */

I don't think we will need all this helpers if there are platform
specific callbacks as suggested in a comment to v1.

-Robert

> -- 
> 2.48.1
> 
