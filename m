Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE52DECB2
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jun 2026 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780820218; cv=fail; b=KR71k/y9HhX25RAa6MZsguw1KeEOkwATWYKknA15poQvoihKOtrIkpad+LyCPgG0udDip0i+VFikPl8/k10NWtygg4QS9dokyMZgHJeGnNP5Khzbn22kRDq+keVX4wr2XmRDhuWVdZC9f3E5cvo4C83vK8V5NCd8qWlxHZBqPZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780820218; c=relaxed/simple;
	bh=B1QWuMf181fAyuDOzJaaUt8YsiCD7ROwtDkp+/4g950=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UoNti2o/Ig7mikAnw2ug5KLJvAvWiXoKVLSZAOM++MqMvE7lWd3khAnw2XFS4lt3izVKH/c9evOn3PEntfIIvN5x73wGEDVTNmV2zCFVPHkLiTwiQ+0LLTf2oPdIjNrQCBaYXxFwbSkXqcrG+5zIZsxIAudLLaO3UgqJeKEuEfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OWLlW7DD reason="signature verification failed"; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OWLlW7DD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnBBEbb6Am873ctIAIZQvCQK9QW4TlC4MApOU0vgWl4tZtGehhjzif5nBXGSEXloo8BZsUq1Kl7l+rkwd+tGBqMmdosh0D3u8XHwU4yzwz6qvhuzwupXunvF8srXoKLcU/4n1gAMwCIsCTMUFuwZfQD5P2YGuUkcgjZZEdbitQpNtwP5lxhjWzDwOQja0jvGDV8TcinJSq8YrCjHgF5OQsgyXi8nslbN8QDkNoT54LqOSlbul4MZoJS+xJ+31zR7Q64Fg0fNnKNlRHTQ9/76qDRuDkLzq32iWTVykV210ysejbKpZE7k0ASwn82Cz4FisFM0+rDBkmuAR7IILnuiNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHaF6osDjdmPrCdKv9CyUaI8g/HzNP4ej1PDCjTEj6I=;
 b=Dsan4CCSL6IestEonAqh84NfejogOX0UEvLrxKrC++zEVqGcU9Ziw32+Y9dcdOhMCVwibmValaKBPEc1Pdo6p1+i36g6mBT/QpQIGeUSqmDyXpyJ90Sa8l8kerES67HUT7/hS80lDe9lYGHIX+RJy8GAa6HqZK4J13ugk0IC6U949+6By0UTQQEtRfS8qerQ138odEfe+LV8nU0I8pMFmbTmBvyW55h7d2yvmlBMCqgC/N1mTAzP1Kwoc5ttLRbRxG7Yy7wS3H9oFMKRicquOvAWlNgexmDFTONdd+cxjxBe1TELZlf6B4ObMc8gwCBHqL9juPG8ZPoGMLka/GffJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHaF6osDjdmPrCdKv9CyUaI8g/HzNP4ej1PDCjTEj6I=;
 b=OWLlW7DDi+mM/T7zY7JISyCvZ2KnFTVjLxKzFe7Pz700G7DsU+pRh3hSU4bqPyIiN4PCnNdXgohnASi1yV/SM6Ghtf0gRtJjDVPrGOe6fG+IGuvpZ+Xy7uuykgr7AGoOATetD77flwV+09X0lGtJY41lvCg5W8N0W4yeXLEM8sFDIh86DxO/rM9q4g80REx7ZNicHP0Hvm98FVU+APDP8dY4OaNw/wu2ZQsC+aE3uQKsyrApbiQycWs05BFisEJtKf1+7+jsLqdw8QKhug13iRyrWgzzDPkAMHeoX8cqIQXaRMNcj6A/+K+mGB0RTseQjn4gS+k8G9EaVu9etGj46A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 08:16:54 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 08:16:54 +0000
Date: Sun, 7 Jun 2026 16:16:48 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cxl/hdm: Allow zero sized HDM decoders
Message-ID: <aiUoynISLHPsZ6od@MWDK4CY14F>
References: <20260607053837.4389-2-icheng@nvidia.com>
 <20260607055101.672B91F00893@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260607055101.672B91F00893@smtp.kernel.org>
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 88638c49-67f0-4d0d-9401-08dec46d2280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|6133799003|3023799007|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	mt+AIps1o+xtym7/wVuUQmcpaL4+jtAxzTNkj2Vc6PqLg9KRiWWxkgaigjlthaOEhAQkJ8sZ+oLZAmst1Oe45RaG6eeTwBBUt3yLxkMHJNElZYhS12X59jvDjR2fxnH6KiYwdQO6HQFlXQLAwIlsM8UpiFpB/5L4PKNbDamn88t9HDKGv2Gi92vNSo+nYgeE0LbQIoae4ZtCcuW9PslODDXpFLEDTtcfZKzIHj4L/21XRj5oxNV1wGhcPVpTr+oZoE6qWP8cTV6PVsugSyCNW8Gytkruag7nK1yAll684nPDV+eM+uqHBxdTgvqtNefbFJJ2+JOxHlCeYkbphVyxcUj6TyQPEzU4YcQ9dQ398s4QbiEnqpz+xiI34eXdM0m4S0evdUPizsxjdf0MfYdIDP+cc7PbMYm/TRQUBosbaM4I4KVaRCaBV+kFkYz9GsfiyKFEhBYwoodo+S3uU4WV1liuHo5LCGYyD6xaZQAxTh5ZXltBqpYBQdNQnqAEaYtJhg2fngwNU9mckmwCcOh8r2pqafN3/FG7l1tWJy0wfdlk+aQDE9MCW4nIgIro2enCnMPPOL42JfmsMA4OK6wM4k9Lrw1caB0PoTM0VGOK17kCCl9hASxOjkMx/2/e6rABUvxLkFG+mXVUR/2l6XtbQ0E3iMEjE1zSEYJCPMJa/hUQF5CvQPY/4frOBU9UkT30
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?5pxgjBn/vikB7jMZSbIk4vy9Z5OehvV58w6/oXNbzV6S4GMs2rFfBkiEMy?=
 =?iso-8859-1?Q?/8iCG29wTdtqEvfYl76x0gnvCtGvs7Oi8iiWn4hkoCoVO5EGzkMoMy/tJg?=
 =?iso-8859-1?Q?KWlKS4OZa5eCezRLJDayRs+X+drz09zxkeFg4zAhN1+APF7XjAckEsDgHl?=
 =?iso-8859-1?Q?ocyuir//QvjxO+JF/LtxNVJt16kMToXMKpd2BbBuiwbYIv8XCeTvvs1hnm?=
 =?iso-8859-1?Q?yGr8vGTCSNJB7za1WEVY3exWREa3W0Lf21OZD6+zdY6bBv7EN+5Pg9bxGx?=
 =?iso-8859-1?Q?BHYmT/3btUBaewjirZfcYcyMYt8Ynka+9BcTgwu5HI9JFmZ1V0IIpH1rRw?=
 =?iso-8859-1?Q?fzhiDsE0G011irnKcFrJNx2S6UIhh3I6XSnv4J5hMCqU6Xp+nkMWLvHUOt?=
 =?iso-8859-1?Q?SijbkteNc6aQw9jr2minlAyWCugmGZAArafn9bs+lnBxawmzM1r2SV7xtK?=
 =?iso-8859-1?Q?RN2s6S1LAJ0qUTwZtyOt/WTLj6ALaETxDqK9xrywwulLvuyjwvu4ZecmNR?=
 =?iso-8859-1?Q?G/hKzFaTRpPt36zLPWbeSvCBBymfhEQTclbTPbSmB/Th84zkwbZxOfVB6G?=
 =?iso-8859-1?Q?YfS13MLeEKpJJB7PkVGkv6iS1j4ZIfvVb2ZTy/6hmgeuW667bb1R4BrEYK?=
 =?iso-8859-1?Q?KzDAJDChwlMHRymm2qeLewTw2XGJoLhRTqg/IbcHXTwWM4wEnalS5Ac0rZ?=
 =?iso-8859-1?Q?0WRSIgMQpijEbzPrWt13m4cxywkMnTRlLYm2cBJ0eN7hkCJ4UjLogMDLGW?=
 =?iso-8859-1?Q?BUFPyvuKOjIEiGgJn5EV2CpRA0vimjsLBzWP9oxnGkE+iUfFhNk7N6Q7w1?=
 =?iso-8859-1?Q?dORVBIRPqNflBhBzHQyevYxmgyoPYaNxCmh5Fa88q1kchdYwgC79mvnY13?=
 =?iso-8859-1?Q?/vZHLZjuYbVHQnVeJAVSQUb4T/KXwS3G9o3aODXyssfzTmassSyqlvreqe?=
 =?iso-8859-1?Q?StD3XVynh6jzMAgn3kT9vphF0yw320gfeXc0LsB6cNcGUSUFs9Dgmons9s?=
 =?iso-8859-1?Q?Dy1Y/M7lsYnXMA4WvFdVm+LnOedNcLbCtr1PdyC0sX6Z6JZsUo3MObwJoM?=
 =?iso-8859-1?Q?Zm6v0TfmDbMu3sXAfAjA+0L5F/Ldt2hUBYkz21WEGquk2imch+vQAHwOWh?=
 =?iso-8859-1?Q?hdadG1F2FBEkHc0TCzN7iP9AM4PjOATuSWzlqk/vHczP86h8iQLYiouhrG?=
 =?iso-8859-1?Q?Di6xz1ynmWlMGO7ZdoyuN08lH3pGTk7uImwrJxI4P16HoCuYiO5XgzcpHV?=
 =?iso-8859-1?Q?k75BDIOPTZC9V+Ov2YdeQyQo1MC+Nf3I+AIolvitidfU6IBv5VrQS4t37/?=
 =?iso-8859-1?Q?8Y1s58SSjZpdsuRY5c+8GNQnxYlYFVoKJdB9u+Tf/crVaD9zPwmSMslIFe?=
 =?iso-8859-1?Q?C+h9HXKTQZaag6TcHYWzUDISkZzY/iHt93VJnMi93fQJTH67/5KQn4bSpd?=
 =?iso-8859-1?Q?APGXRoZzgdnppS9ZAFX3QVhVJ3ln+m1F6H4G+g5bVWi7MTZNHpSiVVgc86?=
 =?iso-8859-1?Q?IxyxneGE/vA1lCWgWZQ2yNkjKD2p9Go3V3CuPJEKACM25qlUOE6qS3UVT0?=
 =?iso-8859-1?Q?RtYLnCjevpIemTC+bRVxL1Iv4OODX32hfoyWKi9i/zlnn+m3P+MgZa8BY+?=
 =?iso-8859-1?Q?1v5OZptU6E1GU3WfoceDvVJA8etBU/y52WQavmM+8hgeVUwd0Ue5Vn7aAs?=
 =?iso-8859-1?Q?ZPTD1N3kHfWGIxRCRTfyoeNY52nybyVpWtO8JQHdN7b+afabTn7VXNQlMI?=
 =?iso-8859-1?Q?MW7TZeFSHTsHyYg3D8TgkMnHGKlvGCvzewzxfDQCsAETaIl1VYkCJD5SM+?=
 =?iso-8859-1?Q?nHlqZZhvJQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88638c49-67f0-4d0d-9401-08dec46d2280
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 08:16:54.7077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMyALTo+Pxzrwuv5c68qlT0Iat6s8wsUrtTgTlHIYh7QubiXDtQa7ej6qfqBUd3RpRBX8LzRce7d/euZjxbIaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417

On Sun, Jun 07, 2026 at 05:51:00AM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Unbalanced lifecycle operation: manually advancing `port->hdm_end` for a zero-size decoder permanently breaks DPA resource freeing for all preceding decoders.
> - [High] The patch modifies the port's DPA watermark (`port->hdm_end`) for zero-sized decoders without acquiring the required `cxl_rwsem.dpa` lock.

Hello,

I've sent v4 to address these issues.

--Richard

> --
> 
> commit 9ef90cd8aa01ad12f98b0af61f61ae8863b14582
> Author: Richard Cheng <icheng@nvidia.com>
> 
> cxl/hdm: Allow zero sized HDM decoders
> 
> This patch permits committing an HDM decoder with a size of 0. It enumerates
> the decoder into the topology and manually advances the port's DPA watermark
> to pass in-order checks without reserving actual DPA space.
> 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> [ ... ]
> > @@ -1096,6 +1100,15 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >  	if (!committed)
> >  		return 0;
> >  
> > +	/*
> > +	 * A committed zero-size decoder reserves no DPA, but still advance
> > +	 * the port's DPA watermark.
> > +	 */
> > +	if (size == 0) {
> > +		port->hdm_end = cxld->id;
> 
> [Severity: High]
> Does modifying port->hdm_end here require the cxl_rwsem.dpa lock?
> 
> It appears other reads and writes to port->hdm_end are protected by the DPA
> read-write semaphore. Since devm_cxl_enumerate_decoders() iteratively adds
> decoders and exposes them to sysfs before the enumeration loop finishes,
> could a concurrent sysfs operation on a previously added decoder race with
> this assignment?
> 
> [Severity: High]
> Could advancing port->hdm_end without registering a devres cleanup action
> break DPA freeing for earlier decoders?
> 
> Normally devm_cxl_dpa_reserve() registers a cleanup that manages teardown.
> If we advance port->hdm_end here but cxl_dpa_free() exits early when it sees
> no DPA resource:
> 
> cxl_dpa_free() {
>         if (!cxled->dpa_res)
>                 return 0;
>         ...
>         if (cxled->cxld.id != port->hdm_end) {
>                 return -EBUSY;
>         }
>         ...
> }
> 
> Will port->hdm_end remain permanently trapped at this zero-size decoder's
> ID, preventing the strict LIFO un-provisioning of any preceding valid
> decoders and breaking manual sysfs teardown?
> 
> > +		return 0;
> > +	}
> > +
> >  	dpa_size = div_u64_rem(size, cxld->interleave_ways, &remainder);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260607053837.4389-1-icheng@nvidia.com?part=1
