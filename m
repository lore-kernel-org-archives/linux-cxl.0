Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47DD32824B;
	Thu, 20 Aug 2026 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787191785; cv=fail; b=C2Sp2XAP2FD9h1ePpc6xArmlAUVPDrU4AuMNXxI3mS3FLcNOBfxEtkjn9YCFvBKWqZ4AI3oz6ZAWQ9s9QuG8JFoOtC5A0T/srbLz13hbEubOtsQUMDdLAu6kwKGQDI96I2iSAU8ioC3Rh59JTzGSfepYV1FRv8Nm0/fvdLwgKlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787191785; c=relaxed/simple;
	bh=ur4vGjV4qQtR0iwysCVUfnSiWztGTcEeBm8JS9DzldA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oRIH5XnyTiOMq/qCKQzJ9SeCCUTiuntMA+cdMcTqzqqIE1ORpDCwJMYP0dbVtVja4pe+iFooXeOLS/2gNoSjC5cufXrKNiaIfeOgxnX8f3QqL3AcqotKU30DmJ4ARTUOL6ytOA6kwZbznYJKB55thfAwe1ae680d35YVfXTmdFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PO32rHmp; arc=fail smtp.client-ip=52.101.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PO32rHmp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywvQnvNCE1gAdwnCWBFq4KAcC/HfmO13+eHWo5WTCGyjPqqRe+BStTBS/Y/2lueCemzpFtmS1+hhTCwPoCMZchXk8s6Bbgw9Io41e+Bjwgq5x0WIKjK+xmEj9UARFXjY9eXg+ripzB/ocI6xDVwjpvevNJqlLMwSVZM8b819Xb32iAvK3cJsFknyuZsptNV81e+6HFwpOSy40Cxr9o830HliaAwudXZjhnRuBes+V3pZPKrpXbQlu7GU+FZJZBl5JN5xeaf/LwNwegUgEml/7jb8d8Spwmwv5W/teQROWJSpHVZdbPXzb03aeFCdvEi1D4C8v//o6WB7VKYVDCrEpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbXT6eUdSO0xo0DY3uuoX3bAjwbrs88i21vUKQMJgaA=;
 b=HmpGDnD0cud16hDbX6qcjcIn0MnEy/UuwvzOD1KUc4DqNqZYhk6vrpYMjJl50v+SLRfCg5R3YxAjARHtTyP0bmyZw4L11uRPiUeoiiLs7uJ/C2JUQ7hSCTQpmScicvRNIZCq0T/5cSsS8mPvzArUSxCuWDHcwXffXeSwXn0WAVSqqniQikSIzLU64BYynbvXOrQ84yPaU4d9Dxukq/dOQHQv0xwS97OmJroHjhGszKu0Vr2YyMsGevY6QEc4SY02bQ6TJKXyKHiVPw/KdBzDYHoamitw+dGvZ+bqzjKjuSCjzrEaBF56TPBtW4M3IAOqymttyDmtBVIQYgUvIhcOdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbXT6eUdSO0xo0DY3uuoX3bAjwbrs88i21vUKQMJgaA=;
 b=PO32rHmpc7R2ixxGWjB0z/48ibaCC7BfFBi5V0t0Yq5otWpOa4wzZ5eAlwFiAmC+/aXMAEym1k/7vcJFS3kd7LiXBex77E8q70g4xsoknCyE4vgeXpO2SnmcYHhy/sPrUibQoh2k/+MFD81HkkTjJ2pe1Yl9wP52sur0l1JVO80ELlu7NtP9gh5v9DtfeHxz/YCYKv+QposTwcoSAVrIksR9xndsG2BaorM6lceM6twdW/3XDlzbxljsZ6MQmM3Tz7QPf4G7BgGGvCQaNYa/vElCB95gyui3I30bM3Jt0fF5d4EF33i4arpJ4CG1KOWZKzphduTP7n/tasy3uZjcHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 02:09:40 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 02:09:39 +0000
Date: Thu, 20 Aug 2026 10:09:33 +0800
From: Richard Cheng <icheng@nvidia.com>
To: shaikh kamaluddin <shaikhkamal2012@gmail.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org, 
	danwilliams@nvidia.com, iweiny@kernel.org, ming.li@zohomail.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, newtonl@nvidia.com, 
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH] tools/testing/cxl: Don't wrap cxl_core's own exported
 symbols
Message-ID: <aoZhnl_uj4KmoO5L@MWDK4CY14F>
References: <20260721084009.38100-1-icheng@nvidia.com>
 <aoXDe6OM1oWwVyK8@acer-nitro-anv15-41>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoXDe6OM1oWwVyK8@acer-nitro-anv15-41>
X-ClientProxiedBy: JH0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5d::8) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a606d52-f369-4056-c967-08defe60174d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	G60ZA17b2kUGsYrAQkerBYODa1Hy9X/p6jraZmw4P5NMjDgMbce1/OPF3wEkRrOGRivMJRSCnrkfsxoykQH9mCwbYBRyRUx2H0q3IEX8CO+CExbl0ir4mO2fRRalT14fd3zGsrJZlsAoXDvSOPshPVMGcfiyVhrpp6d564nOCMvSUQAzuWl7N063wJ3LejPpxRgFn/GIQeNYVdgPzi2uYq2dkPkswvMQwx0dtKpgXtIpzAO5Z5QjGULj3u/KUTZdwGjYUlhqtnGnKj0h4P/ejxkTQQ6mwMRpYZr4mdiu2XYot2Lvoa0FBngPt2yxKdwIQOaJcQeJuVOHUGN3UgY1XAw6UEu7WR5sPtIKzwu1lU9EsFR4jLhI9guQ8qCU8Vqsk8NjrbkOteGolOabSQHmqCFppwqWHZCEsiMSJ/ONc7ZrkzGxlyVe/3PGThftzdls+806Gq8pUKmH1lhbmkg0HLD3i6u801O5fNsGY0/a/90VuRcYprFoR7UX729Z24TqyHtw7KVZskmDl+rSuSyVkO0fDpdwOm4wur8BVTT1ERKuc8MTubDhFiEYe+CgydOdWwSfolnF3eBjc2xsVxjalayfaBA3C6lwDF7ijYH5lBn1lonBc3nzKpjAgn5MB1/962gdjzInak0ezr7hrIJygBS5SeZt/wKjzE/8Rv57Xq4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PQvbtkc8R8nMkZocBxyAsD3yhM9uR9ZkvGw4kYrDiI6bto6MJpGzJ9CMof4Q?=
 =?us-ascii?Q?3qf7J1ZDEuSV3GfOwMl3TBA1/SMJZ2Sp3P+vNISobLnr6DrjkOfMqH0r/QYl?=
 =?us-ascii?Q?LPfpO77pDxYlZedBoprFnxICvAzdgirRIuqBRkC1hElrqGn6hC5mdyMfVWEl?=
 =?us-ascii?Q?y4l443f5d1LRi5rCR89fUVmo4ILFSmSbyswbQFDnuS1ix5Lhbn4dnxSOcZaT?=
 =?us-ascii?Q?CBZRhegZ6fCCVAXae6sj5o9809eSzYnBnUSeBNx6/+iX7mChoC92oc6D7iWq?=
 =?us-ascii?Q?mur9sPNUIVE3T6MlHqZd9/eFjqacWctiPPtSAqXvW+n8I2ZH3sdLQV38DWSz?=
 =?us-ascii?Q?B5PKHFNZ9loO6ZknFIWNHj1p5GFKtH/L8FUkmahMhsXtXzjNDuAsuVEs+WaE?=
 =?us-ascii?Q?SFuRGgsz1NWK1b38qdMHq9C+YF88Tx7HbdVvrSILMOT4WQMkJyGUcVXE5Gg2?=
 =?us-ascii?Q?0q8NAFF8UnCRtBGF2F7AWyuq2U9+xY892kQueTwKSCp0YBLpd9o5aO7k5reT?=
 =?us-ascii?Q?PUpjfmW28dNzd74wrnBN12UughNFyMeTFZN5sHQrgy0EfiGa6xHXZiv5PWS5?=
 =?us-ascii?Q?2ZM6rqOEFienFNSMaoAo2zDja+A6xHylNrXr7RhKkQxA+nk4MiYPVrOk2N3J?=
 =?us-ascii?Q?rEa9rVQ4Ya+U/2qb+CvVHL6Mxux6nWEJJJ8pEzM+ZS6LjWT5Mzjm8WZElv3W?=
 =?us-ascii?Q?YNQVN86RU56I8h0631J1qbKdfEIcxt00Ie2fgTEif3TRqnJllnrKBAA+GVZV?=
 =?us-ascii?Q?qh+Gn65U8rn+m0KLKnctGV1tRfosMgIvKn/AfWFWbXk67U/FUO8xhHCmewGz?=
 =?us-ascii?Q?MkadfIWajaGmn/DORL4tOn1ph3u9+7bmN8a1MFi1GT0SmKQPOxCqAOnADNhe?=
 =?us-ascii?Q?FHBC3R0+3EF7nw30WtMuqQFBv0DchbP/WzQYTQtlnb0Ebv9M8IYqTHxHsLCf?=
 =?us-ascii?Q?rcj4mdKB27VbgULPjtMz3uX5EMJaAVrUCDvqhF+yiLBaKh/AmdjC3ErLQfvE?=
 =?us-ascii?Q?uXdITuGkEh9UPNt5lJh9ilIQ/xs3X6vtzavhozytB9QDms/OIjWmCx87wXIn?=
 =?us-ascii?Q?r7EbcBHWzsd4LfpI27Xg8Fym5+CAJsq+/g5fNi1p8CrtkJWy9FblDifx0l0a?=
 =?us-ascii?Q?crPy0LFntRjvXxN/qDavMQAMh2VKufV8bpl+pdLSx7TgEPOsAbdQy2HeoGl6?=
 =?us-ascii?Q?hahUhdW/7G3SUb+TnfCYUciO9IxRc3dNymeL4WcKqRjL/sk7TxVPn10Ej/er?=
 =?us-ascii?Q?27ynD9W9R6IsqYbRs1V0hmkQMEVuBWFhB1mGEhWGTOWWHtNAbqjFPKxy1KrA?=
 =?us-ascii?Q?xFY5LXE9DCaO/Q44XPPrE4ZKRsWmRl344TP5HtHKNiahf32im8gJh/Whup1M?=
 =?us-ascii?Q?g3bZnlF3+41A8N1BbtB0AWzfVf4ZY89rfObt+PvPwwciJWldm+Mol5IH+v0p?=
 =?us-ascii?Q?mPHl5sUrq8TpNkjN80DfPs7kwEMkbZHzX+2x8hP8kim5xce27Xf6MZSirbd1?=
 =?us-ascii?Q?JiApcimvRkYDeEh3Npz+nFagPzgznfe92FR/5hB4kovyxzTYgkW16E7ej73n?=
 =?us-ascii?Q?keobu/XtFKI8xQdl5xNOh2+ILioYor/hFrfZtegRVlI2RPTrPx53GHlJ+yJ2?=
 =?us-ascii?Q?96WMO5gLb7EYzeoLm4uqGS+6HCjwJrBac81psKaLN7BX8++PCDlJXQjVBkJd?=
 =?us-ascii?Q?DfUSLD/XvWe5LDnNMgsz80OS1s6cmGX1LKlqMH5StJelWUfk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a606d52-f369-4056-c967-08defe60174d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 02:09:39.9119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3G2UN1XKmI0fXSOaKsP6N9yX9LGsD0GHxnjrizkiwThCIViDgsvJYGY9+u9CziXm//8yLCCYj/RroajJQSHdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364

On Wed, Aug 19, 2026 at 08:23:47PM +0800, shaikh kamaluddin wrote:
> On Tue, Jul 21, 2026 at 04:40:09PM +0800, Richard Cheng wrote:
> > Building cxl_test with LLVM=1 (ld.lld) fails in modpost:
> > 
> > """
> >   cxl_core: .export_symbol section references '__wrap_...', but it
> >   does not seem to be an export symbol
> > """
> > 
> > cxl_test --wraps 6 symbols that cxl_core both defines and exports.
> > GNU ld only wraps undefined references, but ld.lld also redirects
> > references to defined symbols, so cxl_core's own EXPORT_SYMBOL entries
> > get rewritten to __wrap_* and modpost rejects them.
> > 
> > cxl_core never calls these symbols, so wrap them only in the caller
> > modules via LDFLAGS_<module>.o instead of the global ldflags-y.
> > 
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> >  tools/testing/cxl/Kbuild | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> > index 2be1df80fcc9..e49ce644b4b1 100644
> > --- a/tools/testing/cxl/Kbuild
> > +++ b/tools/testing/cxl/Kbuild
> > @@ -4,16 +4,20 @@ ldflags-y += --wrap=is_acpi_device_node
> >  ldflags-y += --wrap=acpi_evaluate_integer
> >  ldflags-y += --wrap=acpi_pci_find_root
> >  ldflags-y += --wrap=nvdimm_bus_register
> > -ldflags-y += --wrap=cxl_await_media_ready
> > -ldflags-y += --wrap=devm_cxl_add_rch_dport
> > -ldflags-y += --wrap=cxl_endpoint_parse_cdat
> > -ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
> >  ldflags-y += --wrap=hmat_get_extended_linear_cache_size
> > -ldflags-y += --wrap=devm_cxl_add_dport_by_dev
> > -ldflags-y += --wrap=devm_cxl_switch_port_decoders_setup
> >  ldflags-y += --wrap=walk_hmem_resources
> >  ldflags-y += --wrap=region_intersects
> >  ldflags-y += --wrap=region_intersects_soft_reserve
> > +wrap_cxl_core := --wrap=cxl_await_media_ready
> > +wrap_cxl_core += --wrap=devm_cxl_add_rch_dport
> > +wrap_cxl_core += --wrap=devm_cxl_add_dport_by_dev
> > +wrap_cxl_core += --wrap=devm_cxl_switch_port_decoders_setup
> > +wrap_cxl_core += --wrap=devm_cxl_endpoint_decoders_setup
> > +wrap_cxl_core += --wrap=cxl_endpoint_parse_cdat
> > +LDFLAGS_cxl_acpi.o += $(wrap_cxl_core)
> > +LDFLAGS_cxl_pmem.o += $(wrap_cxl_core)
> > +LDFLAGS_cxl_port.o += $(wrap_cxl_core)
> > +LDFLAGS_cxl_mem.o  += $(wrap_cxl_core)
> >  
> >  DRIVERS := ../../../drivers
> >  DAX_HMEM_SRC := $(DRIVERS)/dax/hmem
> > -- 
> > 2.43.0
> >
> 
> Hi Richard,
> 
> I was hitting the same tools/testing/cxl build failure on current cxl/next.
> modpost was failing on wrapped CXL symbols, for example:
> 
> .export_symbol section references '__wrap_devm_cxl_add_rch_dport',
> but it does not seem to be an export symbol
> 
> .export_symbol section references '__wrap_devm_cxl_add_dport_by_dev',
> but it does not seem to be an export symbol
> 
> .export_symbol section references '__wrap_cxl_await_media_ready',
> but it does not seem to be an export symbol
> 
> I found this patch while investigating the failure and applied it to my tree. 
> With the patch applied, the wrapped-symbol build issue is resolved and tools/testing/cxl 
> builds successfully for me.
> 
> Tested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>

Hi Shaikh,

Happy to hear that, appreciate for this.

Best regards,
Richard Cheng.
