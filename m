Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0D53C4B6F
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198502; cv=fail; b=rF4tBNVmXomI7YrT7rGE9+eMkvwCGYJmX7FqEEckz5GCcbcXV6uCTsIzVvbSOZaQ9hCplGsf3X0ZiOWEtvvRm0dDexUxrUl3lL3w4Vf1+ZpVly7ckWKo5KHpyNkqgzfK9zyK8NfojmaXG1oMvutGhh/5RNt8t75wLwa5JwP6sGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198502; c=relaxed/simple;
	bh=uGX/s1s8mgg8kjoPrkbWCd1eMz4QQNTNYCDfSrizxC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dSxcxuxbfHHstj5pv4ViGvO8O9CQNnBZj/uDtem4fOGcNoWRHxyY7B+bJwsJ0vDP2d4hSHA61Cy2UM4AIb9nRhnEX2I+FMycHtsTMnEKnwTigFYQ2kUPFHN75uDV4O82g2BUqYigasVAQSA4KnUbyguj2KhaE8Vd/p9ati0BIfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F9LkrcwZ reason="signature verification failed"; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F9LkrcwZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFKyLhQQOeYZlcB7zGTmWXv0zIiHYjDCMbT43a/iqJ1VtVN6EJNRQRuOeEej+GEle3DDhsPvv8BJNCit+FgDiKvLcP4fiu7JVOSfpfbRIMXxlaVgsxilKJetUWqdnGHXJ/OBsLQqqJTwztx5f4EGQ31fNowVyjnW8rmUdmObxFc5mR5SIamxdP1zBc1hXgThUwxsc3CiKPtcJSaVdm5lYiOK5XUS/Qawg+ob4zrED1P+12tHtH2yb4rrxnFfQcbrEEattJSbDEykeBgbizGkS0/y2tJ3Ew0mqlL9/bOI8x7SaNgbGJAmQNFVmucJwnmp0nsefad2Rsx74EDgf+YZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udhpF5IoUcPiXvLKoNo376Xk7f4vp4eNHyJKkqLbv7c=;
 b=cwSSSaYdDRzy2lu6q23KQkSEYc+kvR6zbePu9iFzWd5xRhzTcA9pAkZFR3f4+w8z9vr9pOfHNibjQJaJRSt7zWBpKJoLUuU4qQrHoLymzlH/F+emhHqnr2lco/sOTxhd1JI/1qJ0i8euRqviHKCNySZ+lmRN1tvZZjrOgEdnDM/oPRYx+2XA43Vp2PJncYLGWvApBDSevdiehD0QDG6tdbSN5UZ6qAqPMABeFZJDSeoEDh1SubgiBW5DaPUdesT2v8ipCkdGEN/rIYK55FmHVUY76P0vHSjtnLfyr681ukNnLCQeBFrnoWoXfyG4mp03WbPx7S7HQPXJ9fmKZfrvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udhpF5IoUcPiXvLKoNo376Xk7f4vp4eNHyJKkqLbv7c=;
 b=F9LkrcwZCWFDY6cp7my9ki1Cy9fYbzLV1IfiwsTlUx0dIZPMirPNypYeDD0a+RaWjWpGc+FF0Cpi6yftJTfvzcPYtrA12Hy5asQ+zT2XcX2wO92Q2W7vigWX5IcBw+FiDkjSwhbJzsLnkTDM6j64lJJXzuh2lm+Y3UvI+IgG23F5QqEUq9utPj1H6fAtgnOkjJ8RgJfADzc96iByalS++KHU8SSHFrkTzvnf49bprQaoJcv7Kg/aqedcwCM1QLbg59akQL87v3Tx/2hdPWNZ4trUwAJBatgo6o7qvOgCr6LwoBbxrA6tNITz5uoBXYemVoUdzmQoS2F5Oe2w5srpPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 07:08:15 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 07:08:14 +0000
Date: Tue, 23 Jun 2026 15:08:10 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: John Groves <john@jagalactic.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH V6 05/10] dax/fsdev: clear pgmap ops and owner on unbind
Message-ID: <ajowUKd3nmD7FxFS@MWDK4CY14F>
References: <0100019ecc094b6e-fc163bde-0396-4a33-909f-fb88e740be27-000000@email.amazonses.com>
 <20260615162230.F18F01F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260615162230.F18F01F000E9@smtp.kernel.org>
X-ClientProxiedBy: TP0P295CA0046.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::9)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: cd089202-1c64-4630-64b9-08ded0f631a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|56012099006|4143699003|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	MzyOgWDgf/aoqoOoC5m4kWFEwxLulx3eYQgBgnAIG2AhTpSSr3GMiyxxUwq2tnAHiZ1qacjm7+4ImQmaQty8MqeGDr/IAovwUMSeW8ozDPO4oXE6C/Hcu8RqK5/SFmG3oFQM6IQCWp6IQCjOoFGGSFHvXvzLxQlm0w1FQ4sA3GfkeV9MyI4ej/Xn1P1HqsaIv8VuDm/PyoNjmHFlmLLZ87F+TA6Scar1bu24so+vvJLMOIepSclasc2e0jS/bbrFo+iThq/wYSrtPLRG6wo25rrCg7cWxmgXdcvbATMvCVbieV3TYoZGnIpk3t6BQPwBny5SkcftNcDS1n0tZQbCEVAXKOm7NaD8thsuiAJ7OHt3R7ukX0OFu+syS/3cE5AasKYPPWNZol7MNRID4l3jhL9UplyDi0dNuJ5jCEu2PsxnjZz8OGw1pAGo0exxiIes8slML1oGjbBDBGHZR5/1JlrzEsTwpJ+Mwqc5Mv3HV+nFC0LC0uGTBXjip6ECv1SnNnVsw8PV8X5ICRwG5Km3IjIZAaQ2+wzxxUZkEVN+5uXVPhoY3WaUMl0JzJEk8vbgjsaaOeJuPDC1tiswhTBOiHjWKegnimVWpTTJTB3uyJCFkxQW3uKdSv1oJD0iUC0VWG5RNeKTi2qa1UTkVJv9So7krsV09fHPAHbAtqD2hG0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Vuy2pzlEjo8QCZKQUvD6bpN9r2AwGM7AkqFTXnoctVkvV6CvAxGFLPVxCO?=
 =?iso-8859-1?Q?+vWF7K9BOB/puDWhKhgMU5bT2sRTDP0Vale54GML+o9r/wDeLxwk5zWEDu?=
 =?iso-8859-1?Q?uojV8VpQJCp2cHWTS7Io/c6eKwt10pc5iWodIvWlxzLjBVeDMw/qEz5bm0?=
 =?iso-8859-1?Q?JIzkR1ZrlBJKyxqrFXodWyR/EFlP4+tXQYY2jgk+s3N3r9jwpKwW7vbVPu?=
 =?iso-8859-1?Q?F8tigbDLuJ3ZFldTByNPwAUBJ5VLk95NjvQOlEiZSN+po6ZuHVgdx7MThM?=
 =?iso-8859-1?Q?EplmbGsNPTO0+SXh7IaplrH7rn3sgV1gLYv7m2GwgVAG0grmrSQtxEE8iM?=
 =?iso-8859-1?Q?3QNzHZ4ASVWRIkCtK03OaRzJH8GVcSpBr96dQWbbXsUpSJTktGBz9GfKqu?=
 =?iso-8859-1?Q?MhpL6PLjdBf2OdTjqlO8cv8qe9i0AyYzbxHnx+HdN+p4XQFvkD/Ubjv0NZ?=
 =?iso-8859-1?Q?i7SzGPxOHKwEUbg9bjxTnhZdx/u2/lGx9843PdQSkxCo7iMoxicxbbnXyQ?=
 =?iso-8859-1?Q?9iOoDh4Y3LOSVHuj+vBzaTgQZqpPkfb4L2A9/6iowj+brKDsa96z7Y6Y1y?=
 =?iso-8859-1?Q?8zvoBTLC1DOGCvz0/o2w6ZGVrFuSyfJX6FbE4MjMBtvzeIyqaikBFdUG0c?=
 =?iso-8859-1?Q?8CDxzRtV3TMEssGFrxj9Lie0Ei3LrT3YQU2V8tM1l86drkh4iCXtnSMk0E?=
 =?iso-8859-1?Q?SBjuuEVLNzRcyODNpNxsXxAmlkqAQVIM6LCuKRSqQJLck5JukX14dcs4Xa?=
 =?iso-8859-1?Q?kbQ/dydhysl03HdZc5g5cM3B2l/wl3ENH7NCKwvXCvDPPOPymid44oC0md?=
 =?iso-8859-1?Q?3cvC+bXzDQKgMQ7oqt75wmq70Ojh7BDdXsB4A5Y+ps0fjC8GZizaqxEPNE?=
 =?iso-8859-1?Q?79hN3DLYrhy2BDcpSctVAzcbOWW9EcI/7btsQuKNmo3nsnwERAL6LCdyoa?=
 =?iso-8859-1?Q?7inytGBV93N7/WC+ZOxyyJI3za1U/ibFS4pwH9I62PRxvtqHTvWq0xQU5u?=
 =?iso-8859-1?Q?gzl3KNKaCm0MLJeuK+utkVUgTyMhvwy/NPhOLdbt+3u35fDZOU2L4B4Wec?=
 =?iso-8859-1?Q?Hb+YZAoZwKyvi3y8IjtTFecvZZJ4wjFZJX7m0Vws8t0rPxWmvG0Y7zNLVP?=
 =?iso-8859-1?Q?gqoyQ/JEzIRSyDZS2h8T+M1tBr/+mgaszpSJbR25L6aReCchKxC+2GfbXi?=
 =?iso-8859-1?Q?0puFzMlIqsI5olIZ7g4hqUFLL+wiWrazg5m9noUWb1vfjbpEgCLrzvmOOg?=
 =?iso-8859-1?Q?8S1yTatX8dpDS3kzfRXrzkcb4KuDiiadaOKVqzi+FAaWQbCWPgP8Vr5uq+?=
 =?iso-8859-1?Q?2TJEHIKFpGqnWPRR5LvQzsbMCvvbnMcsYK7YKQ8XlzKN/H+1LozjA9CCtq?=
 =?iso-8859-1?Q?Q9Tt4Idqf/tep/9q/+fwchZzRAl0tS5I5BsMpTXVMGDacPA6KwcPVDqdQL?=
 =?iso-8859-1?Q?AJ6lBpnWfdwyi/0kHCljXgVfJtTTmWLRIN6/Mk9yfj7kg2u1ZjCuZI6avx?=
 =?iso-8859-1?Q?JICOMzOPPUSdjfNM8fZfMUuBflyRPVwBoH6CoytuhXgNDqFOfWjEvDtmIZ?=
 =?iso-8859-1?Q?HanTq65fztSQunDndVvRngXrYMI66fjYwMmH2JslVA05s3KZ4bbSTcZVat?=
 =?iso-8859-1?Q?8OUg2sPlB1sd19DuM2HdLjYmjgO+fxi42avR/B1guG2f43tHPgJ0WQ5mJN?=
 =?iso-8859-1?Q?CUNuHWwW4rmaGX8tgVkfnE0d6dQAgWscOCg0/sdu8IKoCCm+SHK4GgOKJl?=
 =?iso-8859-1?Q?GiGctQEilRQ0ICqHWoe/HDiuKMtKZ6O/K1rAEpJDlg2I/zWNXBvdTPvqu2?=
 =?iso-8859-1?Q?fEhQFscCoA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd089202-1c64-4630-64b9-08ded0f631a2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:08:14.9144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gm71VCYMaPv7+FkzsfMw9wL9T0nv9FIBcL6GEmqSOlKAEcpzKmiEcMlcFiWgTwbMeJ67Fp0JkyYs0WOIUierUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793

On Mon, Jun 15, 2026 at 04:22:30PM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Incorrect devres registration order leaves an error path unprotected and introduces a concurrent NULL pointer dereference during unbind.
> 
> Pre-existing issues:
> - [High] Prematurely clearing folio state on unbind can corrupt memory for concurrent users.
> --
> 
> commit 7c895b5292c660c81442978247753fce9d42653f
> Author: John Groves <John@Groves.net>
> Subject: dax/fsdev: clear pgmap ops and owner on unbind
> 
> This commit registers a devm action to clear pgmap->ops and pgmap->owner
> on unbind. This prevents stale handlers from being executed if the static
> device is later rebound to another driver or if the module is unloaded.
> 
> > diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> > index 0fd5e1293d725..68a4369562f70 100644
> > --- a/drivers/dax/fsdev.c
> > +++ b/drivers/dax/fsdev.c
> 
> [ ... ]
> 
> > @@ -306,6 +323,11 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
> >  	if (IS_ERR(addr))
> >  		return PTR_ERR(addr);
> >  
> > +	/* Drop fsdev's pgmap->ops/owner on unbind so no stale ops survive. */
> > +	rc = devm_add_action_or_reset(dev, fsdev_clear_pgmap_ops, pgmap);
> > +	if (rc)
> > +		return rc;
> > +
> 
> [Severity: High]
> Does registering this action after devm_memremap_pages() cause an issue with
> the devres LIFO unbind order?
> 
> Since devres unwinds in reverse order, fsdev_clear_pgmap_ops() will run
> before the memory is unmapped by the devm_memremap_pages() release action.
> This means pgmap->ops and pgmap->owner are set to NULL while the memory map
> is still active and its per-CPU refcount is alive.
> 
> If a hardware error occurs concurrently during unbind, could memory_failure()
> evaluate pgmap_has_memory_failure() as true, but then dereference a newly
> NULL pgmap->ops?
> 
> mm/memory-failure.c:memory_failure_dev_pagemap() {
>     ...
>     if (pgmap_has_memory_failure(pgmap)) {
>         rc = pgmap->ops->memory_failure(pgmap, pfn, 1, flags);
>     ...
> }
> 
> Similarly, could fsdev_pagemap_memory_failure() dereference a NULL dev_dax
> pointer since the owner was cleared early?
> 
> Also, if devm_memremap_pages() returns an error, the function returns early
> before this devm action is registered. Will the shared static pgmap retain
> the stale ops and owner pointers on this error path?
> 
> Would moving this registration before devm_memremap_pages() fix both issues?
> 
> >  	/*
> >  	 * Clear any stale compound folio state left over from a previous
> >  	 * driver (e.g., device_dax with vmemmap_shift). Also register this
> >  	 * as a devm action so folio state is cleared on unbind, ensuring
> >  	 * clean pages for subsequent drivers (e.g., kmem for system-ram).
> >  	 */
> >  	fsdev_clear_folio_state(dev_dax);
> >  	rc = devm_add_action_or_reset(dev, fsdev_clear_folio_state_action,
> >  				      dev_dax);
>

Acked on this, I think devm_add_action_or_reset() should go ahead of
devm_memremap_pages().

What do you think ?

Best regards,
Richard Cheng.
 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the preexisting
> fsdev_clear_folio_state_action registration suffer from the same LIFO
> devres ordering issue?
> 
> Because it is registered after devm_memremap_pages(), this action will
> also execute before the active page map references drop during unbind.
> 
> Since fsdev_clear_folio_state() calls dax_folio_reset_order() to zero out
> folio->mapping and folio->share, could this corrupt memory if threads are
> performing direct I/O pins (e.g., via get_user_pages) and actively hold
> valid references to these pages as compound folios?
> 
> Modifying folio metadata while the pages are actively pinned could lead to
> refcount imbalances when concurrent users eventually unpin the folios.
> 
> Should this action also be moved before devm_memremap_pages()?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/0100019ecc080a68-8dc0c99f-ab17-4aa9-83d9-490e9c97ac2e-000000@email.amazonses.com?part=5
> 
