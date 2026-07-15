Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294144685F
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117222; cv=fail; b=CJTACTzzLb+K/uyLx5y9Q3wd+KMAftjBbRgJWVrQf2ZY/KJu15l4N44QT13dgqx46VBYr/gdELk3JpFKnhK49s2G3Phrtf3woWjIpQFkfdkdJxPrPr9UiOhtH+XBgDRkJgXWLvbbQCVKnbguTYl0pFBYJH7e555IdFXJeb9krMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117222; c=relaxed/simple;
	bh=Qz95p29CMrugz+3gANN5t1v6k775W82+S619CJgWIao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SP3EZglELaJVru4PhIZPdpnR95E5kUgEtp9c5wweT0Kn1YK9tO8lUwFJaIKh29zSyIFiBmY7k54QftiSWzzfV2JZLhny4NAbDiFQV8Lhrdzm8l4mkdPcyZwMVRTo/Z9V7qjLSTuovvs9PQ8m8/uW80wp3b5y5Px39cCYyWco7Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JbVXlbv0; arc=fail smtp.client-ip=40.107.209.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JbVXlbv0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3jYzdM2Pi3BVkY3Us/2fdUOCw0FE5VILas/DvhQ/bNDu8bgdF4LImt7PrANxjc+amnX8Fe6IrtobnDfTrPyZaYQfOGbF3pXiYelGmsInjr+GTqT95YFtSQZ5d4hmeu6lG6/60B+ycb8Hx0c5y3aAUSXexCqYoeiQcfU/ryHLIMIVC2oNqoQtdVqR46HS6DqWJGf7mix97L8Ki8ejD6x00MouNkj0ADGPYgI6kwMZiGYDev4ExFgwBIF1WyvbXQuxhBQNJWW77FTImAeIl5sG7eIXjACrUSVWLN9CsqbivjGCOvO7heapzM4ifWLg2a0V5Rbf/7p8lkcekS1vsN9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uICcZ/dWLSe4RYcmifyifiXSl5y/M5NpXbr9kzhico=;
 b=gjeQyjdJ9rTyuXdtIg0X87BX69Z3+n+lirOhRyN7dTW1xdnfUk5OF+QhutF+lZdZnGcJIFKZ0WKEaYN99nH6Orz5b6RLjFj/FgC+Z84K/3PgJkGNnUnGSSgUNhnwteU5NiHcS0NEP/sxcnJjhWS5LTejHzL0Xz9oEROnhqehyqsNGVvDeBkAPAqOVba2Vfl4sZOAIOBgvZ3XIJHtLeELn7x1pER8BHQoVi8etQXmyrunkxkycUQP7/kOC2wHKTlzcK2SW1iXzWgxHBeU586btxLi1wMnJsovRAeCISV2fSdE3Oq3GhRo8WCyrUSVvLVqvBuP7nbCPtA8+vz25wPCuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uICcZ/dWLSe4RYcmifyifiXSl5y/M5NpXbr9kzhico=;
 b=JbVXlbv0WLGAPpr2ig1t+rS6iGNnXmHE8iErIg+mU2VTQREY5HXeLd+JxP1tnXesok9uEiDqCIbf5ltMRisn3TOjbhPwYCC3/B1zSA7n8pbcBXjDFJJvUGCvAjb5e/kJhZrHvDsq6gBFv28CGpmIrRAWLDuMA6EMJ+y/YFRrIDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 12:06:50 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 12:06:50 +0000
Date: Wed, 15 Jul 2026 14:06:45 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/6] cxl/region: Account for mixed-granularity in
 position calculations
Message-ID: <ald31dCKzDjcmF8p@rric.localdomain>
References: <cover.1781199122.git.alison.schofield@intel.com>
 <94ec26d420e0e40a2a991c1a4205e9e93cab44de.1781199122.git.alison.schofield@intel.com>
 <akITgju_8_6PoKFB@rric.localdomain>
 <ak2rSrmJt8H-0xAn@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak2rSrmJt8H-0xAn@aschofie-mobl2.lan>
X-ClientProxiedBy: CPBP307CA0009.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::12) To DM4PR12MB6085.namprd12.prod.outlook.com
 (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3d164c-d7e1-45f0-afe7-08dee2698d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|11063799006|56012099006|4143699003|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V6E8wsCchb1cg5NNddxviJCgCH+IZWHcVSpIHWxVv1VwWbxH25hZ8lMFY0UZg4A/uJh48+nEBJD3pPf5lR7fIG64UZ1zCRgePeqCdB/wgwUtWL+h3LAOhYiIjMZ2j9QInKATmtGXbb1WKI1FIBMGHBHctpZV6h7fYaPwOFISvYmjF1Hlhps7mngdSLyD/zaTSVlYuNkSxCbLpg9y8ecKPlI/cLzoJ5cPOwRW77RoDiO9TojdOrffV3/I3xCG/hduyLksSWi9v+UlnCJp2EGVJXaU102f5wc8TFqWdyEyLz5aoksQvajfnrI/rCW3yvp4pMeQXqMTKiBr1vi14nAMcWZUx+EufKtUU658Lu3/8WrOmJSmgVIPzsDaaB+xPlTBcqZSx0URFU6acRycGtnDL9Skl315LzT+V6EJk+N4WBGEFht9JvhBn8+wLZPyzxX6hxjLmEqQ7XBVet0JfbdGz7tSuFdGrr2ayuFfk1/7ermTJuA1UAc/PEp17PMv7bgVuWjI7Qpsgs4Y1T/4AuZmlOSXCKoCtpk6/jbYIrLgj9iiIE6MsiOGKpeLwQdNYSqOZWa+n30n7BIa8n/u6IegoPFQYLrWjcHohxV3LlmJEYtJLP1vrDqCqEjiEwQlukroS88QTqSqKNktZPIs9OIQHuAl+Ujl4XU9uKUnhfZEIU8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(56012099006)(4143699003)(6133799003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c7rgauNW0G6eByYuqoELJJ2GgpvQsyYdumyRc0R0ksvLCR5iWT/DVjyDHvZF?=
 =?us-ascii?Q?KfH7l/5Sxn/mWDAJR1Ud/xxbXSPIycbLYrQjM0WhMWUan2AwMCUy5Iyn4rHc?=
 =?us-ascii?Q?MI3qEBbrwPOt47ub6wLd4IeGFn/NTdhIuKE6dbdjW5wm/4VzZUQR+Akq0Z01?=
 =?us-ascii?Q?oEJUSsBzZZQUyvHrJ7qHf8ebKdcFxx03vtF8FdZ5xaCkGj47lRRMNEsy+HFP?=
 =?us-ascii?Q?LoH5besA9n5Uz4dJWiXZUr8w0CjbULf3qmKng4dSHbBORAiqV0w/ai14vCcG?=
 =?us-ascii?Q?YR2hrvCqVYugKDi82siNDdjQYKH8HixSgKcym+RqCmxfzTzJi4Kqgi+5/kQ9?=
 =?us-ascii?Q?jreLi444cCZ2lMr5suASPvjA963PIZtbiUXkpjAg4cXPCovESCbLoj691m7r?=
 =?us-ascii?Q?0w9XgBJxSoSuBkJZjIXj+FeUxOKhZ64wFYGv0xssAEl/FYXa+QgMX9OmHvF/?=
 =?us-ascii?Q?R8u/oSOW9zo4wcdE1aP9KuFArIh+Xav42U/yvNoO3y78pd+IGXWzQuGfrHmr?=
 =?us-ascii?Q?VMiykcn+jZcHH0jjoQdy6uGHyv7z5hlTAcswO28L7hmt8KBxypvio3TFdewg?=
 =?us-ascii?Q?TJTCYvVe+vwUgFAvvMSvbeECuMiOMwo5wu6XSBBdURtEsmzVqIaTTS9dqFC5?=
 =?us-ascii?Q?qGx+kHUmZenmr7DeLgaF3V2iMLekomvS1HJnmbjamqxGTITHiJhwW5W6CWvU?=
 =?us-ascii?Q?J/IyxmnKY52128t8LyPiR6FwP8Ad5QlqdonSfrhOh5TbU0jw05GYzNphRvtF?=
 =?us-ascii?Q?CNUI5GvnRFDwdFx3Pn5tJCiofMjj6kd94Qi+t60h7fgAoH18x+g3/cyrQcqe?=
 =?us-ascii?Q?AXFMPJTkGlq8G9SgqYDtRR58QwFzJqFRojZuPaQ9IWNLTLH7C3SSEDOn4p6z?=
 =?us-ascii?Q?q2L/M9RnOpAQtlvvtmxngw2UkTEEqjH2iTsZvCDg1xhdvIzaG+H14JTZq7MA?=
 =?us-ascii?Q?xOcffeyrJoJ3ZVWYqlQd1vKJ9mN/aCQwZmI8YgnwVn292i5lGtkMMsbUQLai?=
 =?us-ascii?Q?ZjyiuQAHbAURDt4Ppra8vdZhxXLsAzZ8AsGZWxdvdPqsynnsu3HCWMhBqF7u?=
 =?us-ascii?Q?qX2VmmQxSFTwbs7K41CNYM9yFlYRbjmWUHcWrxm6Wk9PGN1c5Gwq1Gat3zr7?=
 =?us-ascii?Q?W79fZbs9eclNWFx1Z/CYpWulA9Nsun7XJG0JVtNI7G993ThsaqAkI93hPEH/?=
 =?us-ascii?Q?x2Bj6AoY+k+nnpEkKuM9jNrEYx21sB5hCma+yVcJsmKkTxEXWGK//0ctRpcK?=
 =?us-ascii?Q?uVJxINe4nKbB5rmoNaZRcywU/CDqq4TbRJzBrUkhCHHsiSw7jG/P8lvMEvMJ?=
 =?us-ascii?Q?nGD1C4p5c4a18INCSg6wdnMO7nK//2BCn4cNq+DVbR2Ic0ZHXdZjyXz8Q50B?=
 =?us-ascii?Q?jZeIjvls1/hPb1urSO1P1osIOaYq4V1A+itkGWNzgLIRlEqYpyt/CRlVQwlu?=
 =?us-ascii?Q?rjPSULuHX0TLJyJqsiAJ6PRZtAJOSXVarVKCPos4kVSOSP7IZlcTLqZOMZQ9?=
 =?us-ascii?Q?2WuiRLidrbFms2WdDNiee5dYhikCyJNor5/6kNiTn4SF4PkxWxc1zYrHl3Ck?=
 =?us-ascii?Q?WJep02dvcVOADTsHbEcNz9HRdFCK1pIevNxOy12MRNquGqWNc1cS+9oU++aJ?=
 =?us-ascii?Q?HTscvOZU99qm19/zi0AH6tVsPnzCAcpFEWj4yaq5m05q/WHkSSz9F0yXNDFj?=
 =?us-ascii?Q?qGSekFd0c0ewYx/C5ASy26AuhGAJzuMZIn4Lpx4olef2VEf4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3d164c-d7e1-45f0-afe7-08dee2698d1c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 12:06:50.4288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NLjdzqEglQ1CWaedAikU+/r3lSOPNDQPshk1EX0MPv1Al3g068wjQgABiqBLQ46Ak3TXQ73dXrifhXWBFLt4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390

Hi Alison,

On 07.07.26 18:43:38, Alison Schofield wrote:

> Thanks for the review Robert,
> 
> It's not added complexity. It is the root decoder's contribution
> to the position, the piece you identified as missing from the
> walk in your follow-up on 1/6. Root decoders *are* "just included
> in the pos calculation" here: stride = root_gran / region_gran is
> the place value of the root's selector bits in position space, so
> the root step deposits the root's target index at the root's
> place value, same as every other level deposits its index at its
> own. It is the same information as the root decoder selectors from
> your follow-up on 1/6, just written as a multiplier instead of a
> bit mask, which matches the multiply/add arithmetic this function
> already uses. Without it, the endpoints get wrong positions while
> every selector check still passes.

But the endpoint position depends only on the factor-of-2 parts of the
lower address bits and includes the root decoder selectors. The
factor-of-3 can just be dropped for position and selector. "stride"
uses a multiplier to describe the positional bit within the total
selector mask of the root decoders. The term "stride" only becomes
clear from detailed reading of the code and is not obvious. It is then
used for position calculations inline, e.g.

 pos_distance = stride > 1 ? 1 : cxlrd->cxlsd.cxld.interleave_ways;

or

 if (dport != cxlrd->cxlsd.target[pos / stride % iw]) {

That is the complexity I mean, I think the code is hard to maintain.

As said, imo, the position can be just directly calculated from the
factor-of-2 portion of the total selector bits without the stride var.

> 
> Nor is it a "special case" of the model. It is the general per-level
> rule "each level contributes target_idx * level_gran / region_gran,
> which same-granularity levels reduce to trivially. The root is simply
> the one level whose granularity can differ from the region's in this
> series, so it's the one place the general term is visible.
> 
> I did check your selector-bit proposal. A selector-derived position
> formula gave identical results to the current code on every pow2 config.
> That was equivalent but not simpler. Issue is that it cannot express the
> factor of 3 of the 3/6/12-way roots, which consumes no HPA bits and is
> recovered by divide/modulo above the pow2 selector bits. So switching to

Stride does not contain that information either as it is always power
of 2.

> selector-bit position math would actually require two models: selectors
> for pow2, plus the value math kept anyway for 3/6/12-way. The value math
> we use now handles both in one model, so position calculation stays there.
> Happy to post the comparison traces if useful.

Finally a combination of 'mod iw' is used, which could apply to both
implementations.

> 
> For this patch: stride is renamed and commented as the root's position
> place value to make its connection to the selector layout explicit.

That could be an improvement, let's see next version. The
implementation should be clear and easily understandable. Right now I
think the selector approach would be better.

Thanks,

-Robert

> 
> -- Alison
> 
> > 
> > -Robert
> > 
> > > 
> > > Remove the temporary mixed-granularity attach reject now that position
> > > arithmetic matches the selector layout.
> > > 
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  drivers/cxl/core/region.c | 79 ++++++++++++++++++++++++++++-----------
> > >  1 file changed, 58 insertions(+), 21 deletions(-)
