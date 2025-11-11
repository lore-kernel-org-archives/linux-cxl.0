Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79F6355051;
	Tue, 11 Nov 2025 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860315; cv=fail; b=jwp7kflnVLYaXi+v6yWnlD5YbfQEjIEU/hpAI4DBne6KtklQ/mcPfxsUE1w7XROdP2Zmx3h66OrulqZpO6GOsfqXqM5DLSEdtZI8ornUuFEaq3X/bsb14/Cjs5oomzq3qXicx+BJSzz09ixKmh4m+7VuM17gRViYYaOSi0cv9J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860315; c=relaxed/simple;
	bh=Lig37gPuNLFFJTupDH19S3Zmh0IqiTdI4E4QNG5AOBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IYgcjhA5ILMJg/r7me0XMF1ceHTg5jMSKYi4Vzyl3dDtsxSMUN6jkwkZARaPjKcPQb6sGxDA0F6rJ8bDzb6Y5ki1p9qjOn3jrBnhp7urD36tUa+CzC6vGF3cQKengnsn2cl6weP1khl/rHSFIAIZsZCW2XORzF2egw/6J7rhRXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2g05ctfb; arc=fail smtp.client-ip=52.101.56.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2g05ctfb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7izBJWh5rlrF5uYiveQokwanLojCKIzCT6p+Lm8f4ImzXEZug1W+/E1RS7aIgCx2FRP3D+hnERJm4i0WkJa4v70rV0MVnDV2Q3Bcn5ky4LxNJCypkfPZrejeeSjdPU3BEghQzWOzq8zaBmxkn2h+oBbmN6oZY2b2bF+92N/ZjDxqIwyKiCTrNVzyWIOdaL7WVqLn1Fn3P2LyblU6qo1BpUZnsnPTInVnUpNTD1cPC1xVu1svh8kknPzVVhbepyqZ2kaBg8TVCFzoJiho+GY5ldyfzJ2HhhcN2e3NtbH+zdJZk/5jgpwudw8E55rZMg1P4dp2eMEVPRSI6Ak2+7qwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCxC4zVIl6e7eUJToB1liI57YqQb2EjRKFRWmUA6cFY=;
 b=Gv9Yxsu3eS0xWdAh5ugFPC66c+8aSswReuhmrMEWCXHTShbAiGJajj23r5bCu66gmEeifP21WQiNXbtCGsQdNejUDIpr2EEZaLIxqyC+r+vwgEF4dKn8yWxJ7dOmmjdSM3zF+E3hgWCTodRinJejvrRsoAyNWZe3ydTC7rth63TF9ncOxvypYAfCoKcX5ndiAealM3UgQkAEXSrHxzaKx9Pckgc5HnYdReG6FH+mUoyxNx3WQIsx4/XVzuYxWpAohpjtuYA7d21BpW4mdxlnmQBfX1UxxhWOsjentGNSATH24KwESpHPud7qvXiAfZMK8Tonyj9hzeiau9WlQQhOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCxC4zVIl6e7eUJToB1liI57YqQb2EjRKFRWmUA6cFY=;
 b=2g05ctfbXiVh/9gB3YAMlPR+cj3HlpwNvvanS77Bvf/W5JEIE4bpofaFShUXtE22gT61jtGWk+LSLUW/AIoJJdbUqnhKjyCLpdEILy+OX/kbXY0L0Gv54bRtKhqna6psm66FVVkg7h/36p1uECBjClSOKs2OfOOLWZGT/52C8YM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18)
 by SJ0PR12MB7476.namprd12.prod.outlook.com (2603:10b6:a03:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 11:25:10 +0000
Received: from MW6PR12MB8758.namprd12.prod.outlook.com
 ([fe80::621e:d58f:ba3:b52d]) by MW6PR12MB8758.namprd12.prod.outlook.com
 ([fe80::621e:d58f:ba3:b52d%3]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 11:25:09 +0000
Date: Tue, 11 Nov 2025 12:25:37 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 02/14] cxl/region: Store HPA range in struct cxl_region
Message-ID: <aRMdMe1zzPxeMW2g@rric.localdomain>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-3-rrichter@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103184804.509762-3-rrichter@amd.com>
X-ClientProxiedBy: FR2P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::17) To MW6PR12MB8758.namprd12.prod.outlook.com
 (2603:10b6:303:23d::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8758:EE_|SJ0PR12MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d52a46-d98e-4496-dfce-08de2114f903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TG1OaL9Ka+qt9qym3pgo3EME71phrmThpSyVYsAdf/JwEBxQ6c2KtvLdjl6z?=
 =?us-ascii?Q?JCqcrutS3Vi+5b/UYWt87+meibzh9nVr8JRDyRCZckjoFdywt2rLvAtmTfm2?=
 =?us-ascii?Q?oy3gJ2O47v0Q3zbMLc4+7YR+9+2g2n5SRah/bJ1zO8h9ISfRFzoapghHZWVu?=
 =?us-ascii?Q?shzYR8496eXI0COATQYnRGH9gjNZA1f83v93kxmWnQsAazYjt1ktPfeqZgOh?=
 =?us-ascii?Q?X7X+FYpqcppJmj5Y/Bvv0+TARTAZSYKMoeiGqTm5Y85V4JWoxoqV3hzuse06?=
 =?us-ascii?Q?P8tF39wgNorkyL1V7QmvoXIdNRdyp191LF5Dr6JAKcRvRr1q5O95B/kunzDm?=
 =?us-ascii?Q?FfaHz5IADeqDJOgNalX02hY4q5PtG2RM+G4NZleULABb8GmWU/9czkAbgzK/?=
 =?us-ascii?Q?Kd+MPdTUVfVPJxDPqnCxllKBkWRpU0ENFmuPCU5ILQjZTkiEibNZ1RFb/9/N?=
 =?us-ascii?Q?d+qB/uNaOR3aQ3CNH5lmdA2j4GoeBfzmfxWJai6aJDb6hRsbQCBq2drE2OZo?=
 =?us-ascii?Q?f1hNeyL2WjVmGffeOsJsHR/7uP0B7v5NL1n9UAc11fYT4hxkGcAFUcNuHgAD?=
 =?us-ascii?Q?KjH0Uwxs3/AwBv3fIUaXivP5UgO2hKxQe8j3mENlUuvzrMCgG5LUzm4Ac9Xq?=
 =?us-ascii?Q?KDX1s21vVuY40b2b65ikSjo78WQI5Q7Hm2m6+eA03DvslLOSvulmtEu+H7QE?=
 =?us-ascii?Q?EblJqfEk5DFCweh8x/Xl29grwrGvDxlYnYNyVEgNzvjUEPiu3tusIsqhZTs5?=
 =?us-ascii?Q?vAXuuF49DihZsCMpqNKFDnOScVl7yRvCI6x6YF0zJOvuD0n8OUeRnPYoLb3d?=
 =?us-ascii?Q?GXUxTF+C5ZprMIcVovjlvVdBaDq0sEFUsFwWQ9ld4fmVnxtlU5/xcIpxGkUB?=
 =?us-ascii?Q?9UPsZUYYYctxLASrmGUq1v4xg2iQwB+Em05sem+7s9wbJk6fZtlUy+VlJ/Nj?=
 =?us-ascii?Q?82qKhpZhVdTBmYzbKQkAi83mN/AyvhjGmlX50XWj+A1xEfCQYZQGCZ0NM7dK?=
 =?us-ascii?Q?Q5+VzdjRCkLzoe6TQ8LbhMET+cYnoIHWSRE8QZjlWSx/bNGy4ayI+4CQGMtY?=
 =?us-ascii?Q?iOHoUMkl/vRUuuvYhQWeE8od7+9IuQ4oSlQQf8aq1lyjL33rGarLBVysIZG7?=
 =?us-ascii?Q?k8Gtdcjt7vnsOw8G5Aom6pwKjmsIRyAsphlFN9E1PON/hILp/mMnbHLMQEmP?=
 =?us-ascii?Q?oBu9nEWwnrs0gX6H2nYA+AlComlwcSjCyhNqGBmjS147MN7f7WnpGUdlZNcm?=
 =?us-ascii?Q?FgG7WAWPrllelM4exS5M9ULkwzjUqUMbL90zIul4gCG0ja2CO2+rrygGLNoV?=
 =?us-ascii?Q?nuZT1R8Qi7FuJmlqCgsaLp14KPLQwpA7VcJBSTtxEu4Q+Qtblh3tSJ9lRORG?=
 =?us-ascii?Q?WZBvjUqHd0BZrBxR9PODQce5T/jvgGFIaZKXol8REsyaPyTIPwDxNLMpw1lr?=
 =?us-ascii?Q?JH4uQ67aR8KnVskiqT6j+W0RWaDkhs7W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KuvROvUFuto0M6BwDPerCchCXbS5rcZ+/Ftb8Cyo1VzCCkTRPycuoT5ETf3Z?=
 =?us-ascii?Q?lJ3Vjn2TGm5eEVYtAPnlT7v+5kXxpX0ZPj+0CtuyJLgQ3jp0BYjN57oN6pmJ?=
 =?us-ascii?Q?0rhyZuo1n/Ezr4NO4eZFDCIk9MOip4QInf8joPBbT9+WgXOmI1VQ5oj4vPoa?=
 =?us-ascii?Q?BTcJ7CKgpLlCXFK+Df1plDPgIBPXPf3jy5CHyQ4R81YFZoHrfZUZk+Uh0VM9?=
 =?us-ascii?Q?9pB+E+ZvpXeIbBoJt++/N5lM82s0sth3WewUSYGSWCLqvu38QokytNtx62L+?=
 =?us-ascii?Q?irtl9DFeFbDF5d1sCJhSTW7KGsY8gsXCzuANuTwb/wBClP4y0KTA13NKzBi3?=
 =?us-ascii?Q?qCH4Ub3JCdydPtdw/UPSsQB32K9x2cPtzm2rceaJoomhg1UasiFOPWDSyAvc?=
 =?us-ascii?Q?A9yN3oHemr9tCF40F0irZtu7WcAEepg1Uj6neCFCnqo/Drs1tcVjwwyws0t3?=
 =?us-ascii?Q?KVOC9Sh3B+RyQ/x0Xp0dIO+J3s+kJJJ3A7kCJubWKaSi/1k7JMRJbljQwIM2?=
 =?us-ascii?Q?aH2fP/uCuuHtIhZo7iR2ff7/IO3jOMxMSRTUaRZMUahwsdhKoN1qmyB6DK6s?=
 =?us-ascii?Q?EJFQf16ij9pmKjJq2I9hd0j16ozeIYIDaKniTRZOPidsDAG06u6rmThnoNWW?=
 =?us-ascii?Q?zZNY1ztrW5UcgENVCOQURdg1LHF9/3tNtbHnTepbOZlrHjgmHzLmXkP1oAwa?=
 =?us-ascii?Q?YVJLw3jf9tcneGBf/yz7+z9++9qU4xARrm8ZWHlTrvMPSsuV7HQGCzY1omPZ?=
 =?us-ascii?Q?9U6ef0okZqn6YVCvOp7GJyjwf7TPaxMGOBjIarBtPbXWJoT+boSck0jMR4ik?=
 =?us-ascii?Q?T7s67jnECjjyfkKdB8p1aY/AeSP4y54Tgb3M/mCv08+DuxgBl8muDofwrnOE?=
 =?us-ascii?Q?sYlwi48z4/ex2Z/TiXJIsClKyzp5yfmtoFtdTdqLAkhajm0/XJY4NVuy2Fcg?=
 =?us-ascii?Q?1gtqdEdJ5QG+50E2UIt7cybLoOvJADbTmhQHOcCKu/LYyPGlh3USe6oopqXS?=
 =?us-ascii?Q?mDJIZjg38C4Yss1zZNBvcr8XlOMh2De0zNrz46tS4TkyfLyDr4r4abhLZ2vs?=
 =?us-ascii?Q?Lq8VGI/Ev9Q1lxNSEZO7HjcZLA52BuODE7SaylDQZAunKC7I1j4mtYYqsoyk?=
 =?us-ascii?Q?kg4zydf3EEa6z8iM7JLcWD3Qov8mVQjrF/wgu3DJkX4UBBshkCx92MUE0vxn?=
 =?us-ascii?Q?mwvTUsLyHJM8TzVWV1kHWdSD6/ayZT4jvpKmruVaMLofCoq+0pBMGXi5P3Ce?=
 =?us-ascii?Q?PwQ5MT4psS4bU8uEXq3kJnxiinzdmD/c034KnOR006Gt0gBBYSxJ0aZpg7sW?=
 =?us-ascii?Q?DnAlUIHIpAAsdQ6XVkIwUzUE3V9kVe/cEtOsWOpPev0lnM8UNMKRo2xoDKtP?=
 =?us-ascii?Q?/zQx1ImgFDK3VLkeEffs07WoM7RNu5JdM9qjQVlD8oU/j8WQBeredyI8Xa4T?=
 =?us-ascii?Q?v3VKyv29ZTebK+Wuk0d0Bj5aXUyNVmUWpS2AdV8IzQGbWX4eBjb1FsHj1SIS?=
 =?us-ascii?Q?4nCISPht9TozlZHn7d2N2cTihLU270P0AnUdFFWJAnYi/VNSgcn3bSSfBwhh?=
 =?us-ascii?Q?WKWrcMYDah52SsbOBv+pjGAEaxYojdemjuXMtTLv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d52a46-d98e-4496-dfce-08de2114f903
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 11:25:09.7263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TmELQyI8U/ZI2IaA4NeSI0kWRXDB76eDegzMa+WAWAT6dTY7W0Dgx5pMdU2gbmxqspJ3a+eLinugmiZYxuckg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7476

On 03.11.25 19:47:43, Robert Richter wrote:
> Each region has a known host physical address (HPA) range it is
> assigned to. Endpoint decoders assigned to a region share the same HPA
> range. The region's address range is the system's physical address
> (SPA) range.
> 
> Endpoint decoders in systems that need address translation use HPAs
> which are not SPAs. To make the SPA range accessible to the endpoint
> decoders, store and track the region's SPA range in struct cxl_region.
> Introduce the @hpa_range member to the struct. Now, the SPA range of
> an endpoint decoder can be determined based on its assigned region.
> 
> Patch is a prerequisite to implement address translation which uses
> struct cxl_region to store all relevant region and interleaving
> parameters.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 7 +++++++
>  drivers/cxl/cxl.h         | 2 ++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 45b1386a18d7..a780e65532a7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -670,6 +670,8 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  		return PTR_ERR(res);
>  	}
>  
> +	cxlr->hpa_range = DEFINE_RANGE(0, -1);
> +

Alison, thanks for pointing out the wrong initialization for the
non-auto case. I think this must be the following instead:

	cxlr->hpa_range = DEFINE_RANGE(res->start, res->end);

>  	p->res = res;
>  	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;

Will change that.

-Robert
