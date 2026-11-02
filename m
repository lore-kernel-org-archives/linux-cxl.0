Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793608268;
	b=TyO+GQVrFA3lI97uuRkHyGwodCcSR0Q9om6ZBwCr1Ahpi1Rh0519gnVsoPIUcHV4cq1n
	 TYgs8up2oCq3mI/Xo/ltg93+6s9zYu9HF4rA0ZxEdq3cIATbTTuMN1NjojMQwqanJanSb
	 8L+n7VRkox9GOt/Vphv7YdWoQFSREL/h0zLwFL7QS+yK5K0Yr8wMvv6Ac7aQsLqKTZztl
	 lMEYiyIxtd+fi7CufjL94gst2d/buhxvBzwuQ3FygeWnLgyemgXZaf6Ftm0+BCB3IRLVh
	 bTCOooTYMkpNyiadqKAA92eEe3gBznIzYNRiiFfGZtGVmV7v7LbiWPdv2SyEB2DeXiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608268;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mtJlfq6a7VW/id5znaCNrABg+plgsEAQcVUC6ZfxKeE=;
	b=SRvEvIvRi3bQRwLzmEgu0o3XiwF+2eDHrfq+rCIfG1S9D/vt5VO4l8EoHBruXlRk/xVP
	 6Va/Q0HDGL6omGY4eL13D0fBw2w0A46bbZF3rAmm9hZO/DE5xAz/O9mGqiKootUE/fxhu
	 jbzvQiNsbGZBYmlPhs03u5Sh9YGHB9WTar1H1hJkwcR6ib/Np4LFXVRBBHECDM5RBdbYb
	 RAunNkLb77K0cbgROOzyMU1zvdeZIsEZ6Y97pJUU++pSrpicVW6DnSBb6tTnpgSwNu5oK
	 rZ0J4OyXx+43M0n+QlLvLW50sZCkhF1dxTY4dX0KZXAMfpnK9JYqUOnenvKPLENcmyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ptneGtvA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.53
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF39B606A326;
	Mon,  2 Nov 2026 08:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF39B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ptneGtvA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYMHFrzpcp5ex8bI9AJIqYsZyqMN6lw1ID+cugncQjc5+AhOcRz8/jsp6CVFoCuZMAM1LSq76F9Zsg5UMvvu6v6mbPYheJTvJKLHYP24YKOLWNB+MPEz59PO94AyG2aMc+sUU+3iHQMZwPN/2J01Ri38ofObh6uUWEYzycrv4LkMZmdxJsMG7k8wx5InGrkFKHmaHXAmNYVtJKmVAtIBlF2dMSjZyJitLVh/JABYn4J0Wg8A3HntIjiS/SFYeUHNJtsEdXxA76Qo+sKt9/nT7rE5S1FpUdaPEFow2m6Z/j2W3vT/lofY5MFhvVy4iDOGGfBUwPVe3uo8+fxe+SWhxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtJlfq6a7VW/id5znaCNrABg+plgsEAQcVUC6ZfxKeE=;
 b=rEqSJL5GSkR2dSeGDIoFTMu82nsqOwMe3HDDhkkW4OCKDL7tSSH1HdF8U9ESGZpLKyd3mFcn1Zsj5IeUhM7Rd4xdlvesd76rjq4j8ccywNTUpeErW0lmYvl3pcZygN/FB5Rru/rSaRzq9Dbf+DvaPuC1BWwAkXQ8VNu8bBzC/7aVd29fsR/oh0SG2dkaBwY5lIPPL3QjgGXaI6giMsiVEyJp7vQ5rhiHFhBM/53p2d3cwEwHpaGAQ6xv2oFfMU4Kf1cUUVcKmUMVF6e83sJFsoNUSM4Ej5tcrY7HdjdimDIFYGUKbiQWYqDDAyjJv8kA3buZxh+GHokhIe91uyyg8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtJlfq6a7VW/id5znaCNrABg+plgsEAQcVUC6ZfxKeE=;
 b=ptneGtvAPRpLkXDtHC8nZVZtq3nE4ItvktBK60tvOvKq9+BqkvJjm2vJSCBdE9N+0SJy5UpSOVhA7KihrhVYOKigFwk+CTz8dvR74APEn6esb8y7XJlBi7tj7Bl/0I7ZtVIelZvQRnsEzHyyqVbGS3MUxd2dU+m/nyYrlWEsjTWKmhCwszpIl5YBIdrkqDuelESBEBkNUVHqZozwDGWmh+a01QwdckabP3el5lGZoweJciJDAi7cfy6Rv5r4/2vSXF83S8CpqC4yoWj2hKem0nMG8PRJXDnqMiZSu6LptpXgzsD8ZrBLEARRUQc0l1rh5rLV/SDtbemmzG6OGyqExg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH9PR12MB070576.namprd12.prod.outlook.com (2603:10b6:610:353::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 08:31:04 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 08:31:04 +0000
Date: Mon, 2 Nov 2026 16:30:57 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Jongwon Lee <ai@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] cxl/edac: Mask DPA flags in the event record
 cache key
Message-ID: <auhH_eBMYqFznZlM@MWDK4CY14F>
References: <20261101013418.87326-1-ai@linux.com>
 <20261101013418.87326-3-ai@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101013418.87326-3-ai@linux.com>
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH9PR12MB070576:EE_
X-MS-Office365-Filtering-Correlation-Id: aa147469-9819-4a35-7638-08df38bba245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	k5JQIml5PPWqduV74JSce6PwviHDHWIbwVTcOt+8y9INjtcLSi4VHvq+UvdKLLuq4c2jBFHw2OUBDb0IgoTcMMnw50y6wugqFK7FzEFxjiI7/mPFdK6wBovPlDjqsr2NYhdw0R/hjUk1NvXuxNCHHbuRrPUhfO+4PGfdGOMRz7rysWp9kQdS3eu/dKhNbI2kwPAPT6teCg/5G4en+zDARQWxi6YEWrGK1Mziq8PRd+xE92ynRlGsuTEEzi/fr9ODbf8fXKgnVWSizmEceg2NwZ7iyOtokPx/1LLkmWaSsJjklSLmC33vxBwx4QfSFFNzjg4j5sgb3wMcHn482TIzEeBy5gpNjOWHRAIlAfO8+XrL7rxNi1XWDk8TBgySKoqHQqRvOfkXFON0DY51gd4u96MNQ7j4OJLP9rAVx0v1ZAxa8hKNjJxBimPN3cCP/6xJoGR1OwVKBleVDC7e+BMVcHOHAb/WbXPMmi1JmsaqT2xAgzVX4mJ01o+SU187uY8TZJhv0mkJK0sp3Py6kWjzLsxqFe+bruH3LnoGkg6BMT/4cv0OQ/16xIaSBolyoffQoEyxBLYeupfIM9jKZvI+vd1mSlaLukEUqv+kPjjbnjPJ+kaEbIcv0lBeXfLf5q/3ouxTrUe5V6QO9uh4Reu/zaMCBpZs14gc7XsZKb7DN+w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1wOBz4JTbMcMYtl4xvVvNUvXVCHcRkbjxAqT+E0eBN2JS8OS5i7/BKxJZ41g?=
 =?us-ascii?Q?qLicaOf+VKf7UV2dsIAN+5V3UAa6y7+StWQz2jegxNhd+cfvlDIv9X1BCXnA?=
 =?us-ascii?Q?/wxw8GyPIQya/Hd3BvbKR9VaoYIfBSTiptYOeUpWBP+7qJv78rGo9R7z0rMj?=
 =?us-ascii?Q?RDmIZG7ry0uvxFa4YSOTYeN73TrLQs3ibH2JWIVeE3hqMVXXPzlI8EVVj9AH?=
 =?us-ascii?Q?JpFY9/hEapZMJDck8h/pRn48tsto89XD15O0ZJcm855H4/tWRfHl/4DLiY9s?=
 =?us-ascii?Q?dQ2EAeP0+q/OHHSuyRRPCmY8cF37w2e17Kc+vNzwu02azEr5ql1yODfBwMaF?=
 =?us-ascii?Q?ym5nNTGPjVBBWPPo/6ofdaSDbXClTURtHPo2MLV9CHjAL0Y719Z56Zy9XMGf?=
 =?us-ascii?Q?RtzzxZduo7TT0quM9Bu4OA3RW7atMsS2u9ST0s+PTT0yqYBunnHOun+LWTbb?=
 =?us-ascii?Q?FOOwrRBRHQT3oPEWIAt4UgyOtkwL0UvbyLRrA4wvIru04oslG0NUhedf7a6P?=
 =?us-ascii?Q?mTKRYeDioUAiBeqxwD4TyHWVObxozeFAHtZFwSiU8LH2WEd/Y17c8OSfCBOP?=
 =?us-ascii?Q?3zUoDk4DTjMQO41BhfjI4kTfyMr5TsE3r57Ie+KuBzefcs2b6kytD1R10WwF?=
 =?us-ascii?Q?u68u+e99/ITb5t6RwXoQIctKL+BtydEY8DqH/3S5Sz1L8braIp6g9PlpP2NC?=
 =?us-ascii?Q?v6RjlfluYi8iQAPoavpYWwwKzgrk0RIYgR/NFlrhrorRRqVZE5MhoLJNf38u?=
 =?us-ascii?Q?cbclkWUwxHUSkcOauqQqR8iOFMO1yAxt6OweeIdGhNZHWMrHX02T0mPhsgi6?=
 =?us-ascii?Q?DI3TW/XTbeLmbEHGPvaKNdBJ+VZsDtlezBaLUQpRyRWOzOg0sTQbxJ3bYgzx?=
 =?us-ascii?Q?LWd7j+rOsnSEc48Qhk5E6s2lawfXkXgeaNWKdaEZgkkGQ64cOH0UFOBkqofz?=
 =?us-ascii?Q?OoufzRTwdTr0ytzNjSnzK9YpKtGfod0KWf+d6sq6mOH1Ld7kVBpH4qat2IU5?=
 =?us-ascii?Q?IECVFe+c/qt070U/z2xfzWYxBCRiJ3an8yihX6EhOb+vXAni0aU2/5pIcKT6?=
 =?us-ascii?Q?SUGlRyGxeVFuMWrBl4I5ecFkuA5G6nT2AaDAv/nJ7a2iJrExppVhqpPARbWO?=
 =?us-ascii?Q?+TbY77RiNOuY4rlb6J2/VSZf3MZDqDp4/VVrt+Jj1Tssa98dHSgT8mGPBTHi?=
 =?us-ascii?Q?wF+GShCwpbH4ade03k1dD3XNaFJATnh53moMwEnB+5lVxDq3R7VUYwjU4EQ0?=
 =?us-ascii?Q?KfRY2RN3rOHhYNKofCh6jdHFMHykclpn6/7VdQ8XRIzxaS4ZKkWqYaPzzWti?=
 =?us-ascii?Q?hiB5dLYuKUSrDXbPpsltoghE/KNoKvJRCngAgJnYIIR6H4JX7umC45l/vhcu?=
 =?us-ascii?Q?9xi8Jw6KJFc8Fa4PzuiU9lCAH1eXjDiLRljzU1ZIE3vfrNLNWI1aFXTTXTRk?=
 =?us-ascii?Q?qenz4L59Y1fyMJWkDuoNSNJKJm7Cif1mCpguwjM+x2WvB/c6Zny3SY53Kxtr?=
 =?us-ascii?Q?DqtqzjLnl/7b14M5H/CYkhV2OWgeBhU5LS2TdcLbetEQ4Waoyp7RGd2oC+78?=
 =?us-ascii?Q?eOb0n8hlGWB03vjzXTyMl4iIyV8Lo6aQndQVatdYyq4bUQSU2DSXMEczQ4yx?=
 =?us-ascii?Q?bLXqogRCyZUh/yxg8ovZSUufK5gHdorLv6rCA2xx/1zeWj2CL8JLWXy6X4xq?=
 =?us-ascii?Q?sps9LN9khS7fEYpzs87eQXyqIYvitLsNFTc2Jn2Q4bY6muqsJzkaKff3Nb8a?=
 =?us-ascii?Q?5Jm1LdBNEQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa147469-9819-4a35-7638-08df38bba245
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 08:31:04.6311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzqS905OXirK75VViZt9/UIt08EmGeq4WYDm/lIJ/ZjZ+hO0sxKJ7YxIaAbE4S21IcbOADLnVaVyTfui+fBGfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB070576

On Sun, Nov 01, 2026 at 10:34:20AM +0800, Jongwon Lee wrote:
> The low bits of the DPA in a General Media or DRAM event record are
> flags: bit 0 is VOLATILE and bit 1 is NOT_REPAIRABLE. The trace events
> report the DPA with CXL_DPA_MASK applied, but cxl_store_rec_gen_media()
> and cxl_store_rec_dram() use the raw value as the xarray key.
> 
> User space reads the DPA from the trace event and writes it to the
> mem_repair dpa attribute. If the record had any flag set, xa_load()
> misses it and the repair fails with -EINVAL. The raw key also lets a
> repair go through for a record the device marked NOT_REPAIRABLE, if the
> DPA is written with bit 1 set.
> 
> Key the records by the masked DPA and skip records marked
> NOT_REPAIRABLE. cxl_find_rec_gen_media() now reads the record, so do
> the lookup under the xarray lock as cxl_find_rec_dram() does, and
> return a bool since its only caller tests the result.
> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Signed-off-by: Jongwon Lee <ai@linux.com>
> ---
>  drivers/cxl/core/edac.c | 43 ++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index f0c12871bd..94d44a3dc1 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -918,24 +918,37 @@ struct cxl_mem_repair_attrbs {
>  	enum cxl_mem_repair_type repair_type;
>  };
>  
> -static struct cxl_event_gen_media *
> -cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
> -		       struct cxl_mem_repair_attrbs *attrbs)
> +/*
> + * The low bits of the event record DPA are flags (VOLATILE, NOT_REPAIRABLE).
> + * Records are looked up by the DPA user space writes back, which comes from
> + * the trace event and has the flags masked off, so key them the same way.
> + */
> +static unsigned long cxl_rec_key(const struct cxl_event_media_hdr *hdr)
> +{
> +	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_MASK;
> +}
> +
> +static bool cxl_rec_not_repairable(const struct cxl_event_media_hdr *hdr)
> +{
> +	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_NOT_REPAIRABLE;
> +}
> +

Hi Jongwon,

Maybe something like the following to follow the pattern of rb_parent
hiding the packed address and metadata encoding ?

```
#define CXL_EVENT_DPA(hdr) \
    (le64_to_cpu((hdr)->phys_addr) & CXL_DPA_MASK)
```

Or at least make it static inline.

Best regards,
Richard Cheng.



> +static bool cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
> +				   struct cxl_mem_repair_attrbs *attrbs)
>  {
>  	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
>  	struct cxl_event_gen_media *rec;
> +	bool found;
>  
> -	if (!array_rec)
> -		return NULL;
> +	if (!array_rec || attrbs->repair_type != CXL_PPR)
> +		return false;
>  
> +	xa_lock(&array_rec->rec_gen_media);
>  	rec = xa_load(&array_rec->rec_gen_media, attrbs->dpa);
> -	if (!rec)
> -		return NULL;
> +	found = rec && !cxl_rec_not_repairable(&rec->media_hdr);
> +	xa_unlock(&array_rec->rec_gen_media);
>  
> -	if (attrbs->repair_type == CXL_PPR)
> -		return rec;
> -
> -	return NULL;
> +	return found;
>  }
>  
>  /* Caller holds the xarray lock. The record may be freed once it is dropped. */
> @@ -949,7 +962,7 @@ __cxl_find_rec_dram(struct xarray *rec_xarray,
>  	lockdep_assert_held(&rec_xarray->xa_lock);
>  
>  	rec = xa_load(rec_xarray, attrbs->dpa);
> -	if (!rec)
> +	if (!rec || cxl_rec_not_repairable(&rec->media_hdr))
>  		return NULL;
>  
>  	validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
> @@ -1130,8 +1143,7 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  		return -ENOMEM;
>  
>  	old_rec = xa_store(&array_rec->rec_gen_media,
> -			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
> -			   GFP_KERNEL);
> +			   cxl_rec_key(&rec->media_hdr), rec, GFP_KERNEL);
>  	if (xa_is_err(old_rec)) {
>  		kfree(rec);
>  		return xa_err(old_rec);
> @@ -1160,8 +1172,7 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  		return -ENOMEM;
>  
>  	old_rec = xa_store(&array_rec->rec_dram,
> -			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
> -			   GFP_KERNEL);
> +			   cxl_rec_key(&rec->media_hdr), rec, GFP_KERNEL);
>  	if (xa_is_err(old_rec)) {
>  		kfree(rec);
>  		return xa_err(old_rec);
> -- 
> 2.55.0
> 
