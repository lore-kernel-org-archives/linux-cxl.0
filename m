Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4272346AC3;
	Thu, 25 Jun 2026 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379501; cv=fail; b=jQYuznxrOg7rTPJ0HDwRvCDZM9jhz9YFv4fnJUcX6FryrgzLup9sw+mnXtjex2jUpk1BHvnTcY/Y1AtuYPyGEEqUJhvoB79TW+kpi7msWiu3PG3zp+MHbxOwZQFkMgjcKyVIoSl/d1eLT5yEyiPh0UEzjeAYO7ZjvZ3hZG2SMso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379501; c=relaxed/simple;
	bh=amVpaaQ/FON4RuO7vffD0AQvdSLxr6rtytY57DJpwnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E650S0Bkj4gnOhqIjqT83VTzYa44xnI9OJOLIXTkGkXIsJX0rzxmKE+QjUNlchysOwuHZXAEFPH09xkkDosHOSSUrzMjTmLnymLkFtpAh4HeLR4JPQsIShINFAArrfSximch6PyAT0P46Gz88g8P8Hzg66Jt+HOUM/dFsx7ties=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hzMfE9tt reason="signature verification failed"; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hzMfE9tt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWxf0feqyEy9xOa/jXEpIpbm6qw2VXl8do1EI1ZZ6bt5sUbqYoFzL1c9cDPFOxwEnRgdRbmFAf+LoHh0H7J8sODYliX7VBFEqcq1jMzNyrISTZeE8fpXocbY2QXR7y5cleUTbzZwWMpj1Llo/lb5yL+RRXq63Y3KuSDTKfd/5b752BYu7Crry0zV079c3sVA3gqHqOsD9GSJIa9GX9jzeiqcRh9lBc4XkBbnRRXz6rr0K7JuttCtGPsI/sWkop3wN9UM3cFviWj5CgpjDz4D0mOX883UvHc9fGZEOOSDoo2FgreocnCxN75RsizHzbrKMdOYxKspBZoTk6OuS5Fpqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZw8wdDSN3Y0+aqOHcXEZAjsmk/DZdX+BFQDi2FjCAY=;
 b=RwL8B2SG1wxWKWYPaviWG827ks+riue3z+zKh+kUGsw/v514z+wLrs0Q28TSceY+7RY22h9oqkQcWY5fpZhST2AxdUNyQrDnR/fy/4JZykgM7Xdnj+359ReyCkaKDLvA2nwSU/tzB70xGP2mDcxmgGcRlD1LoAlL/K2lgKEP3am67lZse8wZ8Fgd5We2GdLvn6KdtTPxtEL9tG7lvoIz7xJBesqkP88zzUR/ONNd/LlCsfY1ZuoTLA9vcVuKxH/QiVdUkXS3ppOHTKuH7r+aXATgPSrHDFE0EJt6GXTKHRhiCBfffOdKTY7ZtnS0GND8+cmEGREYctA6STEaJFB9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZw8wdDSN3Y0+aqOHcXEZAjsmk/DZdX+BFQDi2FjCAY=;
 b=hzMfE9ttAIBHpYCT7xKmk4CkJJTCsktTnNFnFQyThYjwjxmkJ/HjkwtRf9Mz0+3fLWNrlfKtAot94R7kuoh0gWwvJuTsdCrOVL9sb/iyHN915EI0+mmfgLwbLDtd+7mblLx2hKp/zi5qpBZ43ADDoaiGHD81E+r0M4qDPvNHG4k/M2EqA9pd//B5ji16dMVIG//aBCPsde3irrPS4MaCXWWQI9qgdX5nEGiw0LrRe0h4JHrKhQskxmdS0LouoMl2JkRBTE1LH4WHJIRIVEt3SL+u+mhG2N/Bo/3P4PYz/LWBOymKY71BG2LVGkr7GJNGfPzrBIJcR5yw5Ifoxv3Yow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Thu, 25 Jun
 2026 09:24:47 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 09:24:47 +0000
Date: Thu, 25 Jun 2026 17:24:40 +0800
From: Richard Cheng <icheng@nvidia.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org, 
	danwilliams@nvidia.com, ming.li@zohomail.com, terry.bowman@amd.com, alucerop@amd.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, newtonl@nvidia.com, 
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com, mochs@nvidia.com, 
	Vishal Aslot <vaslot@nvidia.com>
Subject: Re: [PATCH v5 1/2] cxl/hdm: Allow zero sized HDM decoders
Message-ID: <ajzzeU5IbdUY37uG@MWDK4CY14F>
References: <20260623091019.33417-1-icheng@nvidia.com>
 <20260623091019.33417-2-icheng@nvidia.com>
 <6a3ae8f486d0e_3c9f100bd@djbw-dev.notmuch>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a3ae8f486d0e_3c9f100bd@djbw-dev.notmuch>
X-ClientProxiedBy: SI3PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::11) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ebafad-757a-4b61-f981-08ded29b995d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|5023799004|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nJnV4Taq0NZRo1LowaFJLJDZi4NzGX9fPEanVa15DviOxWNY3nSGIqQURVZmvlI4B4XZOiAiEFLCAPUIz9Nq9yJStMLmICsuxubj9eEfUThEYzfgShlEXQnLqpcedacLgq4z2Wxx4VZBGHohQXT9XTSOZruTEQ/uMip4N08VSBXMX/BTawEfsy2iKkISDY/LKBl/Ni71K7MPszaNAmpfFBQjCut0WB6yre5Qm1QzZHIumAzd4CevunOBBzK+M/gWny35WD2GAgnHBSD3+TADDtq2sgj/wAYq6FxkaeZOLKS4SUNdqZp21wem6DJ1VqhTKH/FRycrk6T8hjMYj6ix4XvRWBeSjHWklVYRso2zu0H58f5q3Ed6Rlp3tAAE0BLtXGktruLBPC+5ESUlnULHfnyt1So/MHJ8i11jZKiHjOPg8+d3gXciR9CvIwr8Kvj2Wwio2lJ468tf6FDyXWO7vJYrpF47hQB94svHh+bRK8udaz78g0pn+jZORq/8CAJ9qv6v9E+28v1oW3y06MM9DWjhvGMNulWBHLRlnwDDtYW0fMuBV6x9iGNBr/4CuzCoLrexEtnRebVi0M1yr65Hh0hxgRqcUg8z3GBBxgYOTC7mFTymh7n3RikZ+k2LkhVJyu6aJy0oIsrJgqtCn5HGWtvA3Kq+FEXSYB99rl04nRA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(5023799004)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?GikIFpTMnvL2Dp3aye16ArearqxZed8Qsffc8R6ndDmBEzyTxzXdaEqhWs?=
 =?iso-8859-1?Q?mBff95FZ5/Eb7dc235jiwDtJaLMtU/IXM5yLUENtiOyIySp90P++ws/Dhh?=
 =?iso-8859-1?Q?D4Z3PYCFv7+UIf5A0XEA8WjiP8vbel6VDNJLedJ/q2sBsZWqR7vWX8yODt?=
 =?iso-8859-1?Q?2OksVNoq/XIlofVKQHWUOLQyGrq1pjxjM3ujLD5wJWjOj5p2pt+rLmG3x5?=
 =?iso-8859-1?Q?pHyL9LKsWP1mVDJDxBirApdLGzBPt/Az4Fjcx4GLGOVQwo2vty6KFjJkwa?=
 =?iso-8859-1?Q?oimhvQfmmVYbnLrWuxx2vUKEqwXlf0BqqnsFZPvIgd2EZgElmmbn3+IT37?=
 =?iso-8859-1?Q?+jBmNVLPUPivB1xepRYb3foGihA0UN8qg6ohUsuYc+c0g9wEboB5uIBVmU?=
 =?iso-8859-1?Q?1dwHBSLrhpgj/Iqpx4IO+RaNkipSlWgk7FCf9Xctw6o1uYoKDoBLeoW01v?=
 =?iso-8859-1?Q?gqUvGCZkNHhh0pMCB45xSsQQCQd3aPeDOOR5tEN7KcFRNy+FaxmftBHaHE?=
 =?iso-8859-1?Q?44KVBVzGFWr1NJbpwqAyJ+7CRs0t0HPZ7ryKy6oz6/MUTR/KEPqrOiJiOq?=
 =?iso-8859-1?Q?tkoH3+iEbePjObt0kqcYyuVf4cnhQFleyCNvhGNeM27BcZwTNkYRqX/GmM?=
 =?iso-8859-1?Q?K1horKGTXkW/yzlAGXl9y6NzKcoPTWAnTvDWgeYfJ2zSLqviIPNoaLxQMt?=
 =?iso-8859-1?Q?V1jKAyW4V1gDpPX8rkRPQmkuvZCwvjI5Qpvuqb6OynpDF11Ro6K9Qhn1lw?=
 =?iso-8859-1?Q?1xXOjDFDobqMW1+2mXu2Wc4ft94pV/TCa70KkxEYFd9fKz8tSBS2ZTaWid?=
 =?iso-8859-1?Q?McW1Tiwl3k0mrNi1O/TtwqfabdKov3jD7PgvMgBorru7x75CgKuvX2dvf5?=
 =?iso-8859-1?Q?SRtcV3kPLJm4FHPC8wrFIN/mkSEh/VMx9XT2zbu6wmv/l/egyjZpmp0gGE?=
 =?iso-8859-1?Q?nnrw7N0zvJea2RQGHL2fDZ/CTK+04LN1B59tEX/1k1MHhGbAbXwxTb1mPL?=
 =?iso-8859-1?Q?+g5xHZkWHFUDOqdeLqOv7+kp+A9MeAakz4oxAYzp2w0pmJzKVEkz0GYsZ5?=
 =?iso-8859-1?Q?c+G4xoZwzOTeVkrq77i2a0eHpwC+rse6zmOh6lTAK8Flsbg7YymeliH7E3?=
 =?iso-8859-1?Q?JWXmT663sG3Kd45xB8RU0LOfyGgTdLI1iYg0pMY2B6SqZ5WAFUH8dA4Vvn?=
 =?iso-8859-1?Q?yuPIBVajjUm2d3YWXJ9FWjxyOO2ome4PcPGyB1WP+RFA9vLSyRUtq230FR?=
 =?iso-8859-1?Q?uNLakhZkp2tlOwOGlgOynpqfHYp0f5Z9w5oPt8zXUGGcdiXYc8e1mZeAIG?=
 =?iso-8859-1?Q?3JKqZeJBQIMgOZ1bBrdK1iCuoexQTiwENoA/8/qRAFFqa8xcin+h//pMwy?=
 =?iso-8859-1?Q?IG2tTyNQB17ZUxcpK4yANM8O3q+qQFL5pAPa0xBc9B+GetLiCx26zaBCYb?=
 =?iso-8859-1?Q?Y8lGYA//ErHCmwpNBNM1rqaNaSBZQ+ZIg6bkiruiKJuazXILfSi7D1cP2v?=
 =?iso-8859-1?Q?AHen4+qb4eQfsUqhYIWklj9sW2SbVXz5BqAA+I1iSpDvauCl7PtC9/xWGk?=
 =?iso-8859-1?Q?4+79PEQwVM5jIQ9KnJK4vmUi2Qa17HvoRIHcp2lxRXBKadoT0Q6LPY/lf7?=
 =?iso-8859-1?Q?iwFaRXhPU5A6qaID0BwsKXr3mY4IClAH2OJQUVPmarWMS1TGMVSyL3giZN?=
 =?iso-8859-1?Q?L4XlpiXQ4P8HSEw0JOxQfQiUspdgCGq+f8CtHXtzMkq88jmGrRI5oK8wqX?=
 =?iso-8859-1?Q?2ifNJ6sYUYKkIQHE0t+13tGlGSTjXz3AN/q+TA7/F8UmOn6zupnWnhHx+4?=
 =?iso-8859-1?Q?ouZ0lrpFgw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ebafad-757a-4b61-f981-08ded29b995d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 09:24:47.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJaES48QC8W85GZpigtpcS/ROmZFwkfEU8HKl8nZ9ncNX2j/cmuvO947NDIBHwYH+9Y/B2g6QnkHzeXdOivJ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862

On Tue, Jun 23, 2026 at 01:13:40PM +0800, Dan Williams (nvidia) wrote:
> Richard Cheng wrote:
> > CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and §14.13.10
> > ("CXL HDM Decoder Zero Size Commit") permit committing an HDM decoder
> > with size 0. BIOS may commit and lock such decoders so the OS cannot
> > program regions through them, this is a design choice rather than a spec
> > requirement.
> > The kernel rejected these with -ENXIO during port enumeration and aborted
> > the whole port, so affected systems showed nothing under 'cxl list'.
> > 
> > Treat empty decoders as first class instead of special casing them, back
> > them with a kmalloc'd resource, since the resource tree can't represent
> > an empty range, and keep the skip and hdm_end accounting intact. Guard
> > the paths an empty decoder can't serve, e.g. region attach, DPA free, and
> > poison queries.
> > 
> > Suggested-by: Dan Williams <djbw@kernel.org>
> > Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> 
> Looks good, you added the cxled_empty() helper and dropped the dev_dbg()
> announcing the arrival of committed empty decoders like we chatted
> about.
> 
> The comment on cxled_empty() could use come adjustment, but maybe Dave
> can fix that up on applying.
> 
> Reviewed-by: Dan Williams <djbw@kernel.org>
>

Hi Dan,

I'll send v6 to tweak these comments for easier work for Dave.
 
> [..]
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 1297594beaec..5231345ff78e 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -324,6 +324,15 @@ struct cxl_endpoint_decoder {
> >  	int pos;
> >  };
> >  
> > +/*
> > + * Some BIOS use locked empty decoders to preclude HDM decode aliasing
> > + * for TSP operation. Use cxled_empty() to handle that common case.
> > + */
> 
> Hmm, that is not the "common case".
> 
> /*
>  * The common case is decoders with no reservation, but also handle
>  * decoders with a zero-sized reservation that firmware may install for
>  * security lockdown purposes.
>  */
> 

No problem, amend it.

--Richard

> > +static inline bool cxled_empty(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	return !cxled->dpa_res || !resource_size(cxled->dpa_res);
> > +}
> > +
> >  /**
> >   * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
> >   * @cxld: base cxl_decoder object
