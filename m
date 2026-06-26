Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F553DC852;
	Fri, 26 Jun 2026 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458863; cv=fail; b=m2dU7zpgYjKFoS4nrKvA7xUE0zm+t/DTSsV98M8rRPFwVxx5CU+D5Q75llNf7M0R8BTk18QYc5XvDWXK//IyxeNwwUx23Zxgca8Lhvv6JY9GVgKirQYvLLJvRnMLXCDx5mYHnDMzINPoS4UPlz4r0n3VydLM+Ouq6sOlygiYd2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458863; c=relaxed/simple;
	bh=aGkPcAFVHHoXsy6DzwEkq+MexvaDvvDLY9RVqelYRow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g5qALrz499O6ckgqO5Zh9+UYCgawMWP5YR8LEi8OeQ6w4ks8Ofmymm5e7YY71xAJ2S++j74P//gwKyimvM7CN8JiEvkwZKe6A/NWpHJVZraGY4XEepuJ9YrDN+PR4QlFPHu4l2v5SWKx4zApVEgTrzHIouqNiMMKd2vu/nNITKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EcO8OX35; arc=fail smtp.client-ip=52.101.61.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EcO8OX35"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpzV5AFhsAO/d6vgzVdUebDF0/OTTGitZ5S8L3gvo0ku3wIdY64wU6vZMSMBzjYSGR7t70UeHkEdUM36b2XQAfbYaXQnJETkg6eIBht5vzONaKxoyHR+1fOz2gmdXIsYAoSY7MYaNUrwx8lHEJUax5f7I40Al0IZVuYUm5OvxERQkrt+BOPNLhqObfiNg8PpUzSoGkVgzEJo6HU5rWDo/h4gvoun2JPvQ1FxQ04PkO9eV002cQN8FrMcPlO1kOizQZdVhgflyguTYqZxpYEjsZtQkaNAbeT4CT4hhMKP28myAuOUvlQaeXjUZNDolByGI2F7s1fa1154akUlO8yq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JasOhJdJMckU6zI1eCbD+eTjIHM0KIhfJl2qT8EJN7Y=;
 b=dKWVQ67R+wyVyMFd899PZOcNYGc8fo/XPbNd8IJxXTCWActkf3xvoNrIgLuhEYkRTHiAciLtis3SylnHuPqhpD5vZR8ZiMe5EgI7X6SZow6dz9TbOxyr6H9KagPLCePRiMb89soCjAz1gcvM7xDVxYP2OHZu1fLYwZCLr94X8N//nvGYYwfUhwfOJE9Tkx2HvnCV9Fhely9oBFGlnZTG0/HZAy+ANgt35M538InasVrxLtJLkT2+qvfNkFUQOWmRFsXbloJ1kEQZVs9A60xun1iRhPuhSDaRDUyWmLjpS7+Kat1+lSKPS2/CEx+O+3m9FeLsfNa0KXYNlMHy7pZ0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JasOhJdJMckU6zI1eCbD+eTjIHM0KIhfJl2qT8EJN7Y=;
 b=EcO8OX35PyX4ZVQ1WgDqa9JAil7iZZeFOL27hse3+rX4DYxktzTnXTEch0jEwCYcdbPCqvw94q1JenoHpe3f23yNAWIs8S4Qoe9Qk6kkX2jzsQKl9gtemphKZv60myn8C2cTjmZOxAfTTLMz3/xBKEmYXtlbIV28lvfPPMERLrNrygQoznty9PkbjUohWHo/9wNzdn1t+InNoWYtpLoy3gbCz5B/GiPUDeIdlkiRggksAeRdhz7KY0Z2e2DXC9aTLmjbJRfqKbLdkU/jwa4z/4vt7qr7ZoPShP1umGO2HWHT+yZdcDgXhMbSl6sUp8mrOpa/10ubR+cR8Rqe4+ZKmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by LV8PR12MB9690.namprd12.prod.outlook.com (2603:10b6:408:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Fri, 26 Jun
 2026 07:27:38 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%6]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 07:27:37 +0000
Date: Fri, 26 Jun 2026 15:27:32 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Zhenhao Wan <whi4ed0g@gmail.com>, dave@stgolabs.net, jic23@kernel.org, 
	dave.jiang@intel.com, vishal.l.verma@intel.com, djbw@kernel.org, 
	danwilliams@nvidia.com, iweiny@kernel.org, ming.li@zohomail.com, kobak@nvidia.com, 
	kaihengf@nvidia.com, kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, 
	mochs@nvidia.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl/features: Reject Get Feature count larger than
 the output buffer
Message-ID: <aj4pYfg51dWr__mw@MWDK4CY14F>
References: <20260624134737.49166-1-icheng@nvidia.com>
 <ajxEGmGxOhryENl4@aschofie-mobl2.lan>
 <ajxHwh3s2lM98aed@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajxHwh3s2lM98aed@aschofie-mobl2.lan>
X-ClientProxiedBy: TPYP295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::11) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|LV8PR12MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: eb28bf21-0f88-4244-73fe-08ded35465d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|3023799007|4143699003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	f6zzZaDvgny7q+c4VnFPYNDgTiy7ddSKaEzUqSFxC12zvyxi1u9hWA0nFImDROKN2FvL47WEejWQqTDT/4qftl7tM0WaOvasgqNxD83VjmoQE5DB+X3Fnt2EqFieB8fdU+vBZ3htPC61/R5sEIIHIU2BrrXITwUB5SzHX0kGn2RF2sOhFqA/huphS9itw3cAzMoyPeVhuYtBlhXAQGREqCPGpgZg5W4Dm0NInJW+7NLEHAJxSQrz1+NEBrqEwgOG5/8u9gnRyds8kxcSeQi/bwzsKcCjF8/wm5Sf/csQi1g0SPKbmunihe8ZQ8cyo7Ec+jErljc7wVDyeg1HQ/TjCXzFwHiuOV2grDWdM0vJqYDdQQDzzoF7QkV+UAdpWZr5Cc6M47Nwj6MVIKmaEIcRcksU1iJE5ZrNT3YKQt67AlDGC45oF7dtuRaIpbUw+wOPEaBcgOOJWSaPj1ZdF3arxTG53KelhdXd3CHWu2IbajyRJQphwS3nLdRNC3V/0TiS0r0Gvdf3JT9U4tz9fe797DnXM0cXaOujyjMl0yXzTCMITwSwyOyRi4H/NGzJdeE77xFeLNLhR+3ZPTRKZ+5/ZKyYPF2WN3zWOgCp9tbc/4r2lP4uEl/0zXTii7vnZKrRcTvAvXFvio8DFqXSnHyi7BjWkYUVgWDKIoMBbrpkaGw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nI+JZS4gnpgDuVMcHNMnHvaLIlUh9nT5khfEAmjGEUh/CDjX/OjTYZmJ1qmy?=
 =?us-ascii?Q?DewwGLytHzHCpWPIf3mT4k9ZuQdEu6IH+AVo3/ir15t7xwbEbEncySPQGAlF?=
 =?us-ascii?Q?20UFKV7ZAVfEZcDp6mjFKCFBvBRkWyg2cSnnkgkjedB81hOJMq0b5SKyfvbg?=
 =?us-ascii?Q?lTuwMeblYpn7pvkA4y50yCa7Dh27kXAGHUnfA5SSwkNp31w1RkDikvxovLRn?=
 =?us-ascii?Q?bMI8ISJcJ+2DI/wLpzwYn1FODSZIxmmlhObFFTJpG/QO9xfpAi4/GmWTocvW?=
 =?us-ascii?Q?h3tXdzXTt2FG6BbNOBl9gWBXmxKgg9tGtjgoknFnlAkqVm/cHgSbloWLmTnd?=
 =?us-ascii?Q?k4cabd1UHnbPYGBVsqwQJRLvs9xFwW2TvzvWNvG+TH2I1ZrwywcmIQm2nrmc?=
 =?us-ascii?Q?qoFXSf6B4ElSXFy/yyx3VhKBjMGeALwJaT+3TUtz1Hj3qY/51D6LQH2utM4Q?=
 =?us-ascii?Q?dY6nADFRxzxj7dSbkuqNa6lDPBGR/7GDMJccf4s9HBcA+MGD1GU9dgS6qPE/?=
 =?us-ascii?Q?SrJbq0PshMF+Fn/gTRxdZsQRorO9tSjsXRNLQZrLxfdJfjZUIArqL4J0pB8H?=
 =?us-ascii?Q?GZKeCYm4eEjbyjOEevrp86Se5tajgshJy5GB0zpRanxDlRpEmPa7Sdm/hKET?=
 =?us-ascii?Q?845D28vXmJItjDHMcHjeO7zOl8DRzlfko5d0fXFZ8wNR2OJhqRb1/u3wtBdW?=
 =?us-ascii?Q?CXpgbTAkxxcx2eCeguKA4yv5M98gskhDilKFmCNozHc7qajujE0nsDmcxE47?=
 =?us-ascii?Q?x1IhHXX7c6nXO1Abmclqa0poVAf3g0xlWhWryGL5dWYQUxFHl9VkIJ55yS+C?=
 =?us-ascii?Q?tHP0Tg+UVHs3bX7Y0M+ds0YrYgABYT/Dujgphw6LZRah2GClThV3HnWC7PcQ?=
 =?us-ascii?Q?BkB5grpdEpAwaDMYtoBJ2Uo/N/W3gxzBJxGk+b5n3xjZfFEduFPJGLy8kcXN?=
 =?us-ascii?Q?ZFyuP92s90ZKODClsPKUejY9L42tJTthD5px0NvM7dAW8AdQg4ek4Z1jhPzm?=
 =?us-ascii?Q?kXKekRhtLS2KOaLAXMec6SyPBqDjpRZgy13GAp4xAhMvTfFtEF3l4Z8qOpIf?=
 =?us-ascii?Q?7Oe0YvEYeFF5VW67I8BfmUkA91ebBPjGZ5ez/JHZTBKDMqeXyHBO6BogDrl5?=
 =?us-ascii?Q?Q/zQsYNoee9lBguCH2LvupwQgU27N42av481EbUSOCT0g/iTz4GwySJ5OgNZ?=
 =?us-ascii?Q?0LnFcitXq7rKg2djCPhQu/88F3pJcbYHS2U9pXQxPSbSWF19yo62v+AsP3RN?=
 =?us-ascii?Q?913Y86JkASmpj8MYhWe/oCvE9r6p1TC8992BxDl842hsAdb3kdB57Rcw0n31?=
 =?us-ascii?Q?d2zjTJrBh42UOdNs0k6EsQGUohrF1k9WXXGM7F512HZJ6Ft2U8uIFhuoxqr1?=
 =?us-ascii?Q?uXxhoXcQ5efMFKjI2KKw0+3Hb7yib3JfiH8D+N1/hMriWigHjkxO749FGnyM?=
 =?us-ascii?Q?xmsxr2PjvNInjCYxVhygVUkYxVqrH+pNS5dTLpBZ8z9jXFEXuFy0Pys1/egO?=
 =?us-ascii?Q?NH41hjZa+1MQ9a4gFDJYwAhYDfH2ZVym+FZR0ZE/pIPrAAmFI0jCGtZ4pgZy?=
 =?us-ascii?Q?fsFhlYJu/JRyZWHgaZnaYIHP47RAGyr4cXXl7HkvVhxq3e7XSQGg0VhDdQ7u?=
 =?us-ascii?Q?AXDIXv94Ligp6zyKTAhB9MnTnH6RFmBnGJYyoJcua674kkZClIs34sv/pQ+h?=
 =?us-ascii?Q?7mfZRJmlfaUwdtUmEXaCcMyowfFg32Z8ADJbvafe9WntuNdrPWvyYlo1m3sO?=
 =?us-ascii?Q?+uqcOtPXdw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb28bf21-0f88-4244-73fe-08ded35465d4
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 07:27:37.6308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bimaykp7qCnywbr4CKqUIQxeCx1C21/5qMmjMVwhTnzR/pmUAKWUJpiSMZS5dhR1jOOPXCXspVn8xmvJwDbBOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9690

On Wed, Jun 24, 2026 at 02:10:26PM +0800, Alison Schofield wrote:
> On Wed, Jun 24, 2026 at 01:54:50PM -0700, Alison Schofield wrote:
> > On Wed, Jun 24, 2026 at 09:47:37PM +0800, Richard Cheng wrote:
> > > cxlctl_get_feature() sizes its output buffer from the user's
> > > fwctl_rpc.out_len, but the device is told to write
> > > cxl_mbox_get_feat_in.count bytes into rpc_out->payload, which is a
> > > separate user-controlled value. Nothing bounds count against out_len, so
> > > a small out_len with a large count overflows the kvzalloc()'d buffer.
> > > A heap OOB write reachable from FWCTL_RPC.
> > > 
> > > Reject requests where count exceeds the available payload room, before
> > > allocating.
> > > 
> > > Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
> > > Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
> > > Reviewed-by: Koba Ko <kobak@nvidia.com>
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > > ---
> > > Changelog:
> > > 
> > > v1 -> v2:
> > >     - Drop the reproducer and trim the KASAN splat in the commit message
> > >     - Sent the reproducer as a regression test in ndctl separately.
> > 
> > This patch itself looks good. Looking at the other bounds checks
> > Sashiko suggests, I'd rather see this all fixed up in one patch or
> > patchset, rather than dribble in as multiple patches.
> > 
> > Maybe it all fits into one patch, like this:
> > cxl/features; Add bounds checking for get/set feature commands
> > or maybe it works better as a set.
> > 
> > Either way, doing in one swoop would be nice!
> 
> Oh, seems I'm reading patches out of order.
> 
> Now I see this: 
> https://lore.kernel.org/linux-cxl/20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com/
> which looks like it covers one of Sashikos's complaints.
>

Hi Alison,

Thanks for pointing this out.

Then that would be no problem for me, I'll append my fixes with Zhenhao's patch.

so my original fix + sashiko's complain about cxlctl_set_feature() and cxl_get_feature().
I'll put them in my work and send as a serie.

--Richard
 
> > 
> > -- Alison
> > 
> > > 
> > > Best regards,
> > > Richard Cheng
> > > ---
> > >  drivers/cxl/core/features.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> > > index 85185af46b72..9c714ee42a41 100644
> > > --- a/drivers/cxl/core/features.c
> > > +++ b/drivers/cxl/core/features.c
> > > @@ -471,6 +471,10 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
> > >  	if (!count)
> > >  		return ERR_PTR(-EINVAL);
> > >  
> > > +	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload) ||
> > > +	    count > out_size - offsetof(struct fwctl_rpc_cxl_out, payload))
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > >  	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
> > >  		kvzalloc(out_size, GFP_KERNEL);
> > >  	if (!rpc_out)
> > > 
> > > base-commit: ef0c9f75a19532d7675384708fc8621e10850104
> > > -- 
> > > 2.43.0
> > > 
> > 
