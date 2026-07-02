Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013057.outbound.protection.outlook.com [40.107.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5359939182D
	for <linux-cxl@vger.kernel.org>; Thu,  2 Jul 2026 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977336; cv=fail; b=mitBhm0lrvxjRmfF8nLn9CbTo2JVPXFqDK88Q78xQ9sXI5ofOROErycQE+fwEOA2XkT4kuCMpZN6cZD0Y2+xZvPXd5PdHCnbet9IKzR71toooXT60ujzP1b0jlucNZhSuJcZIAECk+Q9+BAYoMjNcgvWxWyLAQjqNhwQ+HZDObI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977336; c=relaxed/simple;
	bh=Bfxf6bBQlUt/oQ4JmOuZaFBqOXjjXlZSS2D8KZ3mRQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kMXr73O6rBiVLAXYkHANr7TxBP3ebCFAweT6BJB8FGZwQMP5cyVEZ/xk+2hkE+NDjq4YRoVLocHenX2rnB/Fsx6fFl4QggSqNaTLjZwohzRrKZZY7lr2j5yVu/BFcV9/iOtw6UaKkX4xrI8WswNtz919wlfMnT+UkEblPrK/ztw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WE/Ix3Xl reason="signature verification failed"; arc=fail smtp.client-ip=40.107.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WE/Ix3Xl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5Iggs2z2CV4vs8TH0EmIZDlY2uk1kVs2ThMuDrhFnef4o2nVtvpQUu7JxaaFfGemHilMUOBiO8/1geTL3RyNA/zxun+IRX4twl0+/NQ3QnMonZhCXm5tbIpgOmT2ZrvngdcDJrUEYH4Xbkbfh6pAFDEBnBY7BqRDxhAjvHWXyD144WH6yUvasYcvFFxeIOToEcBt6DZqVQlM+nFFABK6rY/mag60ONo9kwnMhN3BbJkBxDCNXDQar20NhxTVUqfNReEhMzC6ZLredZRsXn9cd5WJzlKNFjQ+sNYKeM5Icb/Nv5RkjnbJCoqIh2Tp6bmAb5BlOljJJ+t+7nOVRBTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLVOP90tdQElANuiSRaMNcYUsbZyKShTCQRbW9eg1r0=;
 b=S0/DTF2qCl4QnkBJPTHRZT4d092umpYtActmM24V6g47tGoqsyeb/qLG40ALqmt8Jwdjc5IbOiqM0XJ7kYuJEylMT0EUFqYVnQs2KhII29tzWHfzqqs44h+/2JPdXwvNgwfa8q1g20LKfxFQY7HtbvPdMkZjdye+HcoY/zcxHiSIljvCqoECGzvqMN+lVBE72OJum8TXKtV1n3xoNA+bN5X3xaYyWY1kUTxFF9pSz5/JSDjmYPQsOK1Bf4Qi8RktDfmETik4VUfuYw6ZISNXJRA/uO9N60NOHN/MjssOiZe8IlnYjwHswn4iUSubme6DNliAXAs2DuwkZZR2XbR5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLVOP90tdQElANuiSRaMNcYUsbZyKShTCQRbW9eg1r0=;
 b=WE/Ix3Xl8VGrhMzJxgXgrvkmsKw2L5WwauZ/l561ZD1BIeTH1CVWXPqAVlZOOvQZeU6qiDxAasOIowNO8aT/cjWGtSyHG7tfTEOAJuL6CzVquxPr4ql1HeGylKpXNZuArBbtL34CZaTkqcMi1jvbANzNV49KEfx2tx2276oHR/N6uYdZ6nZ29WewrBZEwYGuGUEMGkGAVeG/qWDToww8P8obeaSQLonTL64Nvcbz9JEk7lxz4485u3K56s3LRgwxMGA2eNALHolBxPwSOtxRUk+VtjWP6pQRYK6YkPiHmycfyTWxnHmgYrsQr/fOaphNNur1pTQ9mvKBhlOGG/HrmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 07:28:52 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 07:28:52 +0000
Date: Thu, 2 Jul 2026 15:28:47 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 1/2] cxl/hdm: Allow zero sized HDM decoders
Message-ID: <akYSpn_EyYTys6Fh@MWDK4CY14F>
References: <20260625092857.41139-1-icheng@nvidia.com>
 <20260625092857.41139-2-icheng@nvidia.com>
 <20260625094718.8D3FD1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625094718.8D3FD1F000E9@smtp.kernel.org>
X-ClientProxiedBy: TPYP295CA0016.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::8)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: a285436e-17c7-417e-607b-08ded80b90da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|56012099006|11063799006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Cpa/7JgHAU7bOxL9vhMEJIYd/y4QSY07dHgxFhQfxtykqg5L7g3ilUV3v9twJqz5UKwsk2xXqGdUbc6TFx6O17h+j2JPn9SvSWDEoQaopNKiV3i8rgcIY4kdpIx/Fbjj722Qh+7gXR9j9GXZCe8OxKeG3/EEnmFlxJ/QpCN0IkAS4o+uoI39tczE+SIUUeArlT6LoAxZY67VeTm0Fn0u35FV7qKtuLhDidOZj1jxwh2uv/ZVeKuQZ/7t0vDjcXPr9U48fC1aEFhhH8Eyk1B0FM1Ies4wUrrav7ftwPZhXTKt5pp0VJbG+RSFQPw/4od3Qyw8VU2XMWHUNmZA3Wv1ynbsPMbGzS0TNEYXDFj5KW2oWhLAi9h3x6i+jPbc7LFw1NZmnxpBumWH0MrKDn+FabkqDim8tTbTTHGfs1h+Gh3ioG4FH/6+Z5ZRvMjhEEVOsIZBpwEaXuhkOSZx2krSRlLmwtK8cYIMP2mVkRSdGvK4L8Z9cc6t7qfR7SElmCErF6EW16C6ojEDdu0do2HutO0AeIugL5MmOdDAZnXWyFiO0VFetRZ10AXvz7UONXiTTQ9VuCoeTldkbd9QqV6Uuy5ZWqs44wOy9t2lyFcDKWBWl+a4j1COiO6Xw+uGVTdik1hcnpIXAiouiukigNgNljFcEI9dE6jA7BtFFNREd0g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?tTSRfwxJLZv7/hxZeEoOphSliK+GmqXV3ngz+QBmpGP1quncBb7+2uXYjN?=
 =?iso-8859-1?Q?E2U50RSEICzlmHLnSw4VS5NL7fvQi/pFBwF5EpYhCm8TVgp/lX/whZnjzJ?=
 =?iso-8859-1?Q?56IAUYsCA5upHiuNeUG8bml/yWp78jGmCFTfWQUDCqcOcvVYTao3HDzXIe?=
 =?iso-8859-1?Q?M9owew9wd9ASi175i2ttIntWuDCQRDhnUgX1VF1UwA/fCDD4YpqUsioaAe?=
 =?iso-8859-1?Q?yJobDvufdW/2VbOX1NYK8zKaLdynyzdLeo3n//9NpT/QqYe9BP4frt7U7m?=
 =?iso-8859-1?Q?SBkCD17IbaK0+Nrs1SOJAvITSGJ+LEDBG0WNZZu+7AIkeL8Ey5Uq4gZCP5?=
 =?iso-8859-1?Q?eEqVkNVXTXAeaG5BGV1a1ln1qEtQ+fr4hramqjUpn6cw4/++1cvcJ19lBT?=
 =?iso-8859-1?Q?ZYqybhYYsPlUDW94hLUOeIwltKRop6Ul0ChO4ANxe74OLOxx6IOm2p8Oqj?=
 =?iso-8859-1?Q?fhy2vb/RMCmLEb6zKuB6ZurZFQ2uf8LaSBX1mt3aaLAq2+d4YjHcEBLnXR?=
 =?iso-8859-1?Q?grIOtFZBGTsXjwpQwA6cZPPqhlOfGfMM9kTmzCzlohl/0olU3Au7iGnBLv?=
 =?iso-8859-1?Q?WW/rrb7qSAdzsGGDIFV91pXYMyKnHYVqNkt92s6Tk8WDn43L97Qq9UeKAu?=
 =?iso-8859-1?Q?6NrHhtBDPe2ZH0uNv3A/7Szm3Z9MRVIGttR15mbN1ALPa9wZp8no1WHYHF?=
 =?iso-8859-1?Q?5y+70mNGJOxdxnwHGGs7hSIkD85xm7BFZDCwWnHdWekSA7X7lwrw6wO1tv?=
 =?iso-8859-1?Q?Z0/RdkfADsQlQl/itqDLfPFXXAv2w2fiqMqBOlZHiA60Eum/YOJuFrIo/y?=
 =?iso-8859-1?Q?XDDm6P5vFLc/ssnoUICTG2ZsvbGqUnGJ3b3G4YZrBZeJWAhtL17Ik7RAhT?=
 =?iso-8859-1?Q?q8sJ1qiTkM0fsm/12A6j78Kcpv9RkIztUtLU2RdlP2jaqkwkehJR+2MXF0?=
 =?iso-8859-1?Q?2vRRhOKa350yHczm7UtHqusuviWFtnljPuE6S85ZWm12QuWHo+eelR+mYD?=
 =?iso-8859-1?Q?N9bntcqm9THgQZelkROf4X6FdaGD7IR9U1eVDYvjitr3t4j64SW+/eSTdk?=
 =?iso-8859-1?Q?4JQOcngCdgTaqb73wrLtYUMJ9vyUIR+UD0XdgsR3IueA2Ok1CmqOfpMUyp?=
 =?iso-8859-1?Q?fKoBMOj8xyD340G54nEWcMXRS0XJZ1GOV4dHTkBUNCs4g1wJmqEUMnlYIC?=
 =?iso-8859-1?Q?xuSJXpKuRFdOgwdS1FV/WRajiKGpUklxt6NoqR0kjpmGXg7lBCSgQWCqKS?=
 =?iso-8859-1?Q?jyv1B09xc47lRS6DNaZWMdg/eY9nu/9qFsS/1N+l+/94Rg8rzjA6fLAw/V?=
 =?iso-8859-1?Q?iHpKEhwy92I6cskD3TCPDdkGfG6iQmgL79dzG2I3lK1J10dI4X4Frs2PbC?=
 =?iso-8859-1?Q?/QGKtpzr4iTkMIhAPSp0cDzSGJK2FfWSUenHSdUIVQm1O46kLqtLomfGW6?=
 =?iso-8859-1?Q?eRJQueSSuWIP6LJrjtN67sL6Y+YHSBaarVc7CLuHZLT/SUQvzJ7imhdSl2?=
 =?iso-8859-1?Q?6Mh/vMxGPMEp6PeHlzRgVabbT2ognP4RbMSJMrQemvWC2OGaIWl7opPD99?=
 =?iso-8859-1?Q?wzBueqq1kYUg6uHBud4SCcENdW/5Q1p68LD+CacjSyFuNZKkleJFE8puD5?=
 =?iso-8859-1?Q?6hsiVnrwHUO+KP9ykInU+g91MzU6GDXYYsy8aKgxvu63c4VMff/9336dmi?=
 =?iso-8859-1?Q?lrTvNE6Hccr6zGntJnqXCzn5G1IUk1GQN0FLbOQsdrlaMHGwzWon641WQ6?=
 =?iso-8859-1?Q?gFCvkPCSQRQy5vIKN7j5RynkpC8AgNe44kR0Ym8jdF0r4D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a285436e-17c7-417e-607b-08ded80b90da
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:28:52.3770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tXEWPYOkP2tnKg9wm0/tDNND78DJP04V7FCrTSgMPdDEnL4TVSbEq2Rlk+o9fSdn/qw+Cpb9K0yv3acijGPdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226

On Thu, Jun 25, 2026 at 09:47:18AM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] cxl_dpa_free() returns early for zero-sized decoders, permanently stranding their DPA reservation and breaking LIFO decoder teardown.
> --
> 
> commit 0afce63a5399c17fcedf2e4f736d16ed9b2f7179
> Author: Richard Cheng <icheng@nvidia.com>
> 
> cxl/hdm: Allow zero sized HDM decoders
> 
> This commit allows empty (zero-sized) HDM decoders to be treated as first
> class instead of being rejected. It backs them with a kmalloc'd resource
> since the resource tree cannot represent an empty range, while keeping the
> skip and hdm_end accounting intact.
> 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 0c80b76a5f9b4..ccbab2e21f060 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> [ ... ]
> > @@ -545,7 +569,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
> >  	struct device *dev = &cxled->cxld.dev;
> >  
> >  	guard(rwsem_write)(&cxl_rwsem.dpa);
> > -	if (!cxled->dpa_res)
> > +	if (cxled_empty(cxled))
> >  		return 0;
> 
> [Severity: High]
> Does this early return permanently strand the DPA reservation and break LIFO
> decoder teardown for zero-sized decoders?
> 
> By returning early for zero-sized decoders here, the cleanup logic inside
> devm_cxl_dpa_release() is bypassed. This means the kmalloc'd 0-size
> resource and any associated skip range aren't freed, and port->hdm_end is
> not decremented.
> 
> Consequently, any attempt to resize a zero-sized decoder would fail with
> -EBUSY because the reservation isn't actually freed. Attempting to free any
> lower-indexed decoder would also fail with -EBUSY due to the port->hdm_end
> ID mismatch.
> 
> >  	if (cxled->cxld.region) {
> >  		dev_dbg(dev, "decoder assigned to: %s\n",
> >  			dev_name(&cxled->cxld.region->dev));
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260625092857.41139-1-icheng@nvidia.com?part=1

I don't think this stands,
devm teardown still runs __cxl_dpa_release(), which kfrees the zero-size resource, releases the skip,
and decrements hdm_end. The early return only skips the sysfs free patch, and a committed empty decoder
is not userspace-manageable, resize already fails on the F_ENABLE check, and F_ENABLE is never cleared
since an empty decoder joins no region. Dan cover this on v5, I think it's ok for now.

Anyone has thoughts on this ?

--Richard
