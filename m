Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007664AA02C
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582440; cv=fail; b=TKOAsLrQZ8S7kkWQE/Ozejrdt8LglCxXoOfhVGUctGqhONmQC1c3t/xFUw13h493AT+x9DRyQE0CsKpKlgVWLQeeiTPt/n54UJcLPh+HrXiHBFob+NmBcz4HwM0xykfJiWi7bQY9B0Yeu/pHz5AYZzOmA7TSl6Yjelvu0K/8pXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582440; c=relaxed/simple;
	bh=w3zClcTTasb9NLQRPa0g4F6QZVnL0O68dCUV4aFBOTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eddNsENdRp8SO15vEWOVCNo+B6xOm1+vreDV/f0HeN8sQ82hXvBgR+QyH4Gqn4ZocBj0kbh30TbGV6/c781ED2Uc2pljCNWr1O5C61Ar4zX9ouhWdyjGRdOBEg4o42KFuhVJkpKjc3zL/Pa36MPOwwigH2/4u/TDUSicih6Va0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1y0sO7DA; arc=fail smtp.client-ip=40.107.200.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1y0sO7DA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzdYV3YK8YyX45Z3Tk0DXJCof+Wt5mzu3nqNcf00QgkPCyd1ug90rxHIjESw1f2OKPKmKmyxYpc0u340m5RspMkwp1vVzZGDRI/GNG7gxwmzYhmOfuyeKuAMA3hX+Kirzg7mfwL4oiL8uhOaqEEtqARbAZAHL3j9D/FhuXBnaYmyMl9aoqsloyik538+1IQ+m/NB6pd3RffIsX7c4NfvkRJngk+yQ/RWCqM9O6+xxh+lYtzIEpv5A4yLX0YnvDaE1y7WErqtEJNSMHHaOomjfeXdWtyhaC9S6rrwOsIXGbfr9TohFHHBH+oqH+9AhzifCuRS02GBdH7XCZ72p7wsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/r5euzn5wT5CCucAAWCFa44OE2Mij1/Iox4JDVxcDc=;
 b=OC8OtGyzN5lFDLB8yWYVXsspfI19c+Pg0aU3BUgl1MnmG7qMI7+nhybPjHZ4OvW6xF8YLbl/B8qzl8tTyt/ae+X7zpAosSxA5AqtF/XBPX0QxquR5pGMI3/jy+1+z2ybh9THrHcRcPzN9uRmIw3cxo9+SJzzvM9lbcZSoMVHL493+AMA2vCUxHghs/FtCx23sQM6XPVAMs1FVsfxdXnW8u5QOdYLxuZMvvSmIO+Gx6fs3eAnCQv50FR2A04Ym1Jc4TjwfqA3CJafOk0kDoT1jbWy97CFgkU+Rg7ra0gsqrCY7nhLH0UV+XoN/twjjvgcxqyRXU8VKCoRLO4Zg+EVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/r5euzn5wT5CCucAAWCFa44OE2Mij1/Iox4JDVxcDc=;
 b=1y0sO7DAK6oDmHskqjEU/AFCoP+ny/haXylRMQ7srHm9VewSWn8OEuqjnbq7/QfG0m8dBgQuEKIuCgTqMb8bhz1mnOLe9XS+1guW3jezp4SJRL0dmqcW6f3RtSaf5Et5HqWo1yF6xZNNNXLs6jdaWZh2/tbOLBT8SSLEkU1Sqow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Wed, 16 Sep 2026 18:13:43 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 18:13:43 +0000
Date: Wed, 16 Sep 2026 20:13:38 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 6/7] cxl/region: Support mixed-granularity user
 created regions
Message-ID: <aqrcUmji66Ge-4n8@rric.localdomain>
References: <cover.1788475206.git.alison.schofield@intel.com>
 <9929a7f5a2d8c05fe345252bef28c11fc36867c6.1788475206.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9929a7f5a2d8c05fe345252bef28c11fc36867c6.1788475206.git.alison.schofield@intel.com>
X-ClientProxiedBy: FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::7) To DM4PR12MB6085.namprd12.prod.outlook.com
 (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|BL4PR12MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d8836e5-a843-4dbf-d99c-08df141e3dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|4143699003|6133799003|10067099003|5023799004|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	N6J6MkDNgv5uXprsysqEmNT2SD9gGOafBitS/I2ROc58MhI1Avag5kB6eSav+aHo6ANwSgCc7Pt3XMAxv6mq314hLaPmKHbIxsjzTbB7wqBR+uDcPPUzE2YjoTjytmXeY5JOIZeZc3YmtD7v0MVTBe1eJZNhEX8eUMJHCegpxjvMRme1ziiEcm1kmitL8GQH6yAIUR94rorNjgEyIrEVIhRcptzy3e9mI6BCr822iFB3Z/l1gzvWk5flUqpoZV6hfFWmUDbO4z9AgdnxiHMv8K5i7cyYprylZU3AkKDZgl5IF5VDgrg9TlU0ptHU/AlSifCa4Fq3BJjZfmALW3U+POOf9bXZnCsXoJjqtT9fQbfj4FjrX2SUlHFd7Jt5ehRhxLtpyPeF7TjNgTEry4JRABrZCGp0Jw6ZkffYa5nHpNsklge8MH5Ypi13c1bRAMr60AzCTaIcDtSKxek1pK+HaOqYKdSUPeXPii2krUZdMaTUe4y33qnoZdkNfRq1Dule3zH4qqtASZ7kY3Cpyk6qWd/xcHaMfob3hQq6CyzjU+pS7VvGeCJsidcAvMT3szH3srPwASkTXC1JU7RgtzuTqNQIrPtI9bppsMKYU8+lM/lFPAxYTK4d4XxAuGHFg0BdAWgkHC97n0AjHys8Rw68ty8XHHJx+M9AuO14+JKoSv0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(6133799003)(10067099003)(5023799004)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?61k/rDeXEmxDE4JjoxevaawbQfDl2zWVNVRlAtQNoOmsOM8jJN39pL4Gnubb?=
 =?us-ascii?Q?exNcYovLDTM0ZAxA+JKQdoE4QjKb6iPAXLIfhXmgHkXH4shmMPGWUqdQSVFQ?=
 =?us-ascii?Q?YUS0jRp2K0UrXUNcwZGLO1cCXYCDa2AsFHnEmYCt1w9liv/Dv/y1VktJnjRX?=
 =?us-ascii?Q?IvLfLbmVABtxGQZBggBltmpQTprXNJ4lt9gu1iOue+G+Xj/xWGWWaE6Gg0Lr?=
 =?us-ascii?Q?OwSdYW77nexABLwNt0ZdP8ARRvPPXXA9SRg04nywq8h07FJzHSntGSzWFoyN?=
 =?us-ascii?Q?LF5W3ClDZRyVXXY2USqcC3WOWNCzJAlKqTmd1WHWZZ0X6ETPDLciLqx4pTJP?=
 =?us-ascii?Q?S/LzIZrNmbcX7eVbypAqXXZ5pnld+JcCnoSbh6bzTyrBfkAGbsMrks6lpbeo?=
 =?us-ascii?Q?uaZ6sm4k/JWo4YRXO7NvjtdHk1KT7RB0EuHj+6TfqYsYH30VMsZqwW8y+Dms?=
 =?us-ascii?Q?TMPzjOhAcKObhuybQXLXxIqwrlllZTtCaM+vlwDURpJjrRG4uOKNiIEAotK3?=
 =?us-ascii?Q?5Jn/HDQB/7O0vGpAFQohteT6F9gbo3sB3eZFb++YoBOeSaC5vh8elV2oIBtH?=
 =?us-ascii?Q?1c+Oek15XdrMJQqVHvosVWGg/8qwUhcJE6YVh+8izFSzoXWHMY+/brJqf14/?=
 =?us-ascii?Q?OdO1OWpKnomMPNuWrT5p4D1Q2Ep5PaqIDqjY2ICvjBvA0al3YSEcQGNwrpqV?=
 =?us-ascii?Q?RWzQIgHA3vdravdy9TP/392wVZASi7YDoR4/IRPJxav340I/xDGaD/PZHMmG?=
 =?us-ascii?Q?tAKHVAyYCtCRfoBZvUfQVdBsOfF+OdNU7+kkhqZS1eUBIIXyHgYMbdm0pACy?=
 =?us-ascii?Q?ndrQhXAsdM6H+ceTVedZEyJ+BBYHg3xotnvShTwYHfkwLsUCtuauJoSxfXzN?=
 =?us-ascii?Q?R6UT9s9kUjGPRuo9+mnyHQNMlguubiDxlqRd7rUzaCbGmbmOLO+7jYHt7tGd?=
 =?us-ascii?Q?Pgr3UQOicQ1Ap3cGEux2Axk7lC28xQIGeunOUmzIvZy4UIUBA6JXIneMYztX?=
 =?us-ascii?Q?MCANTzTjwomzEcEUTWfgvulqgr7sYySv8FtNgxeXUZZYqu44E4aY73uieqFT?=
 =?us-ascii?Q?CtwTOdcG1mab2YboQBKFOzCGergH8Hldms2otP4FUGTo1MANRXbEYC+dR1rd?=
 =?us-ascii?Q?T6S146li4z6U5QY5xIooBZwdtRI2lRhdvSczxLJJBzDI7bN4e8CkfewCxhbT?=
 =?us-ascii?Q?5rHACgAJI/jx4839tliP5mFI81tfBG5p8Xq1shw64F1Pn3Yd3dpYIHvpVDuO?=
 =?us-ascii?Q?/zOzW8UR+++zXOcGS2bPvivLQwFaQ/+tZi6tFvda8wvhWauBpb8bjhr2W5+w?=
 =?us-ascii?Q?CGILdgRY92IsD4qiR9rGQQ5+6cIImcWq3BUTf9syfcCcypuvCk+JtHC2QYpM?=
 =?us-ascii?Q?LBjhgLQqn1xc1+a4zzmvfA8/BjLa/LiXbkZPdfQta7ASFH5/TFSOPkWPKQ3g?=
 =?us-ascii?Q?h2BR0QMcwraO8ErhxcZ2nBqsznC4fa57noeqOqg0AfZPUIknDyT1UqOB9UvW?=
 =?us-ascii?Q?yxEg+6kA7ZM6uzMi68XzGkfkr/wvqA3pMJHBvNE3bgKS0cLeWJWytFJ2AKu0?=
 =?us-ascii?Q?S2lcSz1YyenZie0a/axuqUrbZ9Jhl8DMPSagUMokHUDZNUqstpN7CYdEwnnS?=
 =?us-ascii?Q?rNKzV7d19fExeQMu2HT7bd2RlnKL0347Wi+X8fCI2YW3HvKwdYN4XS+hceaQ?=
 =?us-ascii?Q?XSPHHvCor6ltqPJcaKOZoPaHvGFalJ5/nORCn/waJl4TQ5qF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8836e5-a843-4dbf-d99c-08df141e3dfe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:13:43.2956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKi39hzLdOAWmaQnJKtG0+IMbyM2cA1kzkTSkmttwJDsOVne/SNSbF4FASQmzL9IGFURWsyIuYPKpfE8P6wfcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481

On 03.09.26 16:23:48, Alison Schofield wrote:
> User region creation currently requires an interleaving root to have the
> same granularity as the region.
> 
> That rejects mixed-granularity layouts, those where the region granularity
> is finer than the granularity of the interleaving root decoder. A region
> granularity coarser than the root remains invalid because it produces
> incorrect DPA translations.
> 
> Allow a region granularity finer than an interleaving root and continue to
> reject a coarser granularity. Validate the complete ways/granularity
> relationship when the region endpoints are attached.
> 
> For example, CXL 4.0 Section 9.13.1.1 Table 9-7 describes a 6-way region at
> IGB across three host bridges as a 3-way root interleave at 2 * IGB with a
> 2-way interleave at IGB below it.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---
>  drivers/cxl/core/region.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5b7104a55fdd..374d8c2c32d1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -572,16 +572,13 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
>  	if (rc)
>  		return rc;
>  
> -	/*
> -	 * When the host-bridge is interleaved, disallow region granularity !=
> -	 * root granularity. Regions with a granularity less than the root
> -	 * interleave result in needing multiple endpoints to support a single
> -	 * slot in the interleave (possible to support in the future). Regions
> -	 * with a granularity greater than the root interleave result in invalid
> -	 * DPA translations (invalid to support).
> -	 */
> -	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
> +	/* Region granularity must not be coarser than an interleaving root's */
> +	if (cxld->interleave_ways > 1 && val > cxld->interleave_granularity) {
> +		dev_dbg(&cxlr->dev,
> +			"granularity %d exceeds root decoder granularity %d\n",
> +			val, cxld->interleave_granularity);

The spec only restricts that for Mod3 configs. Else, there is no
driver support. Could that added as a comment?

>  		return -EINVAL;
> +	}
>  
>  	lockdep_assert_held_write(&cxl_rwsem.region);
>  
> -- 
> 2.37.3
> 
