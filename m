Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB73BE162
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626786; cv=fail; b=bpw8+wqvKyQ53x1Lkn5XO7Dw4sXxdK/S6M043G7TfoSggoX6DFe2ivSSatiKt1WtWfiIfrFLMavJdtF8w437SiISg/4R8RTcBlXUoQZ1ML4DU8fvkJp4jzd1sDx9p3vIuc7Rjfd2K9xciZyy2LEtqnR05QouqfyLKtvGFU7TKl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626786; c=relaxed/simple;
	bh=yTTD2OgAbM5Qh2LZT/8bjTDyb+ITA6Olx2s3XjDEpUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B6jhxIeOzGKbjqwKtCRW1jS/6hfcSt/mDpQcY13m0s47hZKKgveI23aHbh/X4e8ghMru4BVwKvU8kFJzPN0WEz1JXTz3wJ3BpHYltsfxpEG3aUPHSxm2dCr1SDeS9JrZyNAda3h35A5YDNFk8YwrPp8iee6or5VqIMlT4OGPxe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tFAgHr1C reason="signature verification failed"; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tFAgHr1C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KI4fJL+A+lqtgIKeY0oHSYaMrGIbaHuyyu0Eyp/hgUKrWq4KvlZG6VCrk6AfR2vMH2HVlUTQe93/mLglB1AdNzS39R/dxn4J4gsC+PAChu+MmcP9g5Qyt5V+0BfVEdbSEMkpz4yClCM2YIzSkd6i/adFG8P52bsDOrTB8GNjdoNhjIT8bRAjlFKiqq/NFLueFrIvCbZ4aVuMsgPxPhv4yv4b7AO3DEHVmUBdFqhqnGpWP0vp5ny9ep2Rl/qmjDaaiaWYZd3O9vmarwapRZplXc4S+JF7l2Mi8/xln8ixnQ5MKCUgPBn6Qe+fG+j3bEZ/3/2jx6rmcD+APJGJ67h+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNe4uBYs7A0EwonS6wgJIyo2QJbhU8WcxvQOxIaHZX4=;
 b=KSHY1KnYFX987xfJNjz8O5usQS+bxK4eOXVor/XRyTyz3HSEAB019ZOOd6O2ZlGjIl6TMcX24HN3Sl9W3Jtgkx/9V15b26qK4WMPIQlgqqZyPrvikDH6dZzDcycwUPzTgQ3EJQKzusGI8mnpiLZNskXA5bxm2DrXnYa+gncMD+iYWdzBfQ0h6Qp/juwqGUkS3bjHAQ0HFyrXeNHi3dx4XFrGJSSUF4H8IAbW+YNmc4qRQ9Ob06LN9dJafHiOLyUl25VQ++J90bncKBV4p4YRN+kX4PGJCfDjllYGunb8MXAVUeZe/9A6De/P02XDmbW2ZObVGU2jNSfwPmHNmL39Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNe4uBYs7A0EwonS6wgJIyo2QJbhU8WcxvQOxIaHZX4=;
 b=tFAgHr1C9RwumDaMR5rtD48sIm6MTPJ84+zIq7VGNpq+rRLHyH48jLFLV45I76WVy0fTbREOW5AAtzE3wOk3HCG0RoF+l3xj0kPwFC7S12gqUyJsgJluHLRkv9gA6xm5vV9tinlCwYJv8TriUla8cXrQu6Nq1IzMdXeG3ins78REnskxcyeER7L8ZHpk4tCmZz6Eofxj7Glwlowm2ibqOngC+/LPcTrjy7uhCcolhCXM37AYDJ+Z9To7LAahNiMW53s6u3hKRGzk9qgdXcp4ymdPjGUvpcKAwTzXiVVMQL/LTrYsDlVTpruDBcLTCbvH7kOLSTvSXkkSNDHgYaT8Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 09:39:42 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 09:39:42 +0000
Date: Tue, 21 Jul 2026 17:39:38 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v7 1/2 RESEND] cxl/hdm: Allow zero sized HDM decoders
Message-ID: <al8-QBjeHI515V6R@MWDK4CY14F>
References: <20260721085715.39322-1-icheng@nvidia.com>
 <20260721085715.39322-2-icheng@nvidia.com>
 <20260721091624.9CDD61F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721091624.9CDD61F00A3D@smtp.kernel.org>
X-ClientProxiedBy: TP0P295CA0039.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::8)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: db4850d7-1bc0-467e-9943-08dee70bfdcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	5/Kcb1o1hiSe0jip/Q+BYu9TKQn1Xf8nPNE36apNzvi+fEJOnSRkOm2HYYbqrMF3vylFud9ipAmaVDUiaDSu2vfPoEHkMaZ4chE13YVmVx8O8oApteU10ZXi93fwS5YpFlZ+19cda4v0575WCRWC7GAr+nVXwdkzLYZCuY4J6xRn3bxANyYL86N0F05gkFEieneMHHAldu1rfmdpcEyqcKVy4knVEge0Z+JZcUwkJIO+eq7H4gNk8tmbF+FC8sqOEjgLkI8P+e+uY2RwRW1BRyOOdd8ftHfPvDY+BmxGY+rkkXhc96BtYtNFzzXJZMIaKMmS2zeyJtpaS6UXTZu45O08L7vbKGYHOYnUL7hfsLOD3MnplrLK/xwW9gaxhRBTO+RAbbNM01m6ofCFcSPA8+V413LdGe3f9HAtMa2kY3PT9bN+W01bckk05vpnr33qnoyl6F8XLtW7acPU7smC8LKnvfQhQ7d7SRKZcwXWg1iK7bOVjN1Ce/iNeTXE5ESQqe6/W1ihWR0bc7HEW2VzE2LOIDtjSzU3apYxc4cP7F1vi/cQyPR973iOtrwriopD1NKHHiWw2vD9izgynkVuNx0YuGsFZogvfPOloUqragx35MZgTaJpKeFnWsPlHAx1QZM5rhduK2xUw6+olwuiRIgrm6th21kkBCMakyC0miU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?yXh+Y9Zfk6giODoS7TXzzhfz+v+UDKYHf3OYQexcUsMgbqdI/bA5v8E9kQ?=
 =?iso-8859-1?Q?fym9J3vvZ/xu72fArzt5WaJGl/cGu13J7xYrtShHC0xWT+zUOmhR0U+vUg?=
 =?iso-8859-1?Q?EMCQIl7dbqolBOB+wtlaSHICRg3a5U2nFNximdHmWp5Xmwr4IbjkIY+rc1?=
 =?iso-8859-1?Q?bmnpSKB9c0AgXl4wgLYI34QCV1uvLPprxHYmPP6ziawWbiqt6lx2PK45ez?=
 =?iso-8859-1?Q?4ChtvV+nXjz9DRpldbbZ+AlCAF8GMo5j02tMpyZxfvrwNseLP0ERuryINV?=
 =?iso-8859-1?Q?MrnVH1mS+QPitZGmuH7wUX3K8wwBhsWcXsVyEo8rMxCM0PuOTMkM6qqOr7?=
 =?iso-8859-1?Q?KHtQobzYZ4YoM8J+TmmKhcLK59SuIh8NQhv8CjNYlmSSEMzOHzzMApZo1G?=
 =?iso-8859-1?Q?vsKZ6lDemxqow+kQRekQUdQQR+ryc5gT93mnz6/UKfvvD7OZci8stm7Wj5?=
 =?iso-8859-1?Q?ddyRTs2YuPOGC+O/onKyQl7glY0atml0actugB+jR48/ug/j20966d8hE+?=
 =?iso-8859-1?Q?sBDzcNvsCESCY56nAP7YkjMd4YO0KcrAjaGqyn9OyBrvuZFqqwXB22v2CP?=
 =?iso-8859-1?Q?VxpGt/ERUd3J+PGX9yCluipgAmpb8XKuIIlvUte+K+VSJne62/xIW0TmXY?=
 =?iso-8859-1?Q?vje2jQ3vSMdl3yA4zjgb7QCfBHFeR5kkqcxAmRJAQraIzl4VZV0rseyS35?=
 =?iso-8859-1?Q?G0AIPghxXtJQQ3F9GFEwnqDBUFM6ZBtVqSsjrtVgKvTloOO0BD2pKEL18A?=
 =?iso-8859-1?Q?yGgpCcZWr92AznrXn2Gnf+Apkm8rms0b9qEwajHY7eziBhXhuPKIvmCob2?=
 =?iso-8859-1?Q?/Zkvwd6PK+JncKA9stRWdH9WDEPvlJNshuCf3FLxPTbW/vB7DvGlHmphQY?=
 =?iso-8859-1?Q?QOVMNrbyxsDL2f55VYtnHdhQWa/mT6TY/cDd9VRYaFJH/xZiksZH5FFmfQ?=
 =?iso-8859-1?Q?jvbuHL5s2NQ5E95eSgbsxIvzAPDdNuPzfljHyJa9g6GWljtDfoPifFm7Db?=
 =?iso-8859-1?Q?CgrReDoiHNnKtOTrR1vTIs5zJ/LhzfVQhpj+g02ICe+MPbemTqR1DQet5U?=
 =?iso-8859-1?Q?wXRE7UrRe2iysRhO2VnwUNU+SAFe2o8AoXdETQ6uu8+8H8hzwQz/QtHs4Y?=
 =?iso-8859-1?Q?/LSimLp5s3mTmIqjsPlyoBDjD6XgYDK16iTYnMRLtTkCPZ/aVYfvrYpE9V?=
 =?iso-8859-1?Q?gnPZ6HUdmrMxG/LMCVTSF2V9tfYqWZuAYh/iCWoiLJXeD3rQ+uM+VaiFxs?=
 =?iso-8859-1?Q?qojD/YMkcevPBKntzxm/rBMZ3xX1S4N5thElrW0E/5sPtNeN2IvvMFLe8h?=
 =?iso-8859-1?Q?YaRs3BRIDNrYt3+PaRJqLGKJes+AcF3S9Jif2ROSeFoSUO5DbmZPSSLeNP?=
 =?iso-8859-1?Q?a0FgDDX3qzjSziqI36yKFg1kIT+8cafkSivY3ZUcX7IfeMdBEG0cFf8Wad?=
 =?iso-8859-1?Q?bu2wBedPM6b/5yVLCNI+WCNJYNnAoFcK78907XwK9vA52AgWjzIcBEmyAz?=
 =?iso-8859-1?Q?C6nOq3GF1Awedz78L9peRSSRmrksEPSXAGrh4uEXy11HCxNuqg3I5kjoux?=
 =?iso-8859-1?Q?uQWLHfSVXU3//jHqhJ0F1Q6Cqpeq/gn+FFCsgDd7/iHZ2dgqXqN3YI0dCQ?=
 =?iso-8859-1?Q?T6L5GvZ2KpWf60aLYZQV6gingac1jE9WGV87zNPYsic0tq1rnL9T6bZ63b?=
 =?iso-8859-1?Q?9UWEocQpVcl6N+RMH/tQSHLSIedxq/hjnKCmaaHcnbuDmKjyCLUZ9nwd26?=
 =?iso-8859-1?Q?RGDy7d7sHf+ZQNSgsi565gh1EaWg98xMGOxIgr5iYhnHGA/pHC+dUdfYXD?=
 =?iso-8859-1?Q?cRGFjNyPpQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4850d7-1bc0-467e-9943-08dee70bfdcc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:39:42.4779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FCS1Hdf7BNS8cZctH1jwkj8Q4rYDJG1xqlZXlUSHoT3EcVEn48E1PyLeHIpjZR/rzSrkmJvf1xwYiUcUa/odA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479

On Tue, Jul 21, 2026 at 09:16:24AM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] cxl_dpa_free() returns early for zero-sized decoders, bypassing resource release, leaking the DPA reservation, and permanently breaking port LIFO teardown.
> --
> 
> --- Patch [1]: [PATCH v7 1/2 RESEND] cxl/hdm: Allow zero sized HDM decoders ---
> commit 69f9a310ab608be9b469a96819d45389f215c346
> Author: Richard Cheng <icheng@nvidia.com>
> 
> cxl/hdm: Allow zero sized HDM decoders
> 
> This commit allows the CXL subsystem to accept zero-sized HDM decoders
> instead of rejecting them during port enumeration. It treats empty decoders
> as first-class by backing them with a kmalloc'd resource and keeping the
> skip and hdm_end accounting intact.
> 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> 
> [ ... ]
> 
> > @@ -545,7 +569,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
> >  	struct device *dev = &cxled->cxld.dev;
> >  
> >  	guard(rwsem_write)(&cxl_rwsem.dpa);
> > -	if (!cxled->dpa_res)
> > +	if (cxled_empty(cxled))
> 
> [Severity: High]
> Does this early return skip the necessary cleanup for zero-sized decoders?
> 
> When cxled_empty(cxled) evaluates to true for a zero-sized decoder that
> has a valid dpa_res, returning 0 here skips devm_cxl_dpa_release().
> Since the reservation is backed by a kmalloc'd resource from
> cxl_dpa_request_region(), does this leak the dpa_res memory?
> 
> Additionally, skipping devm_cxl_dpa_release() means port->hdm_end is not
> decremented. Because CXL DPA management strictly enforces LIFO teardown,
> will this strand the hdm_end watermark and permanently break the ability
> to free or reconfigure prior decoders on the same port?
> 
> >  		return 0;
> >  	if (cxled->cxld.region) {
> >  		dev_dbg(dev, "decoder assigned to: %s\n",
>

Ignore this one as stated in v6
https://lore.kernel.org/all/akYSpn_EyYTys6Fh@MWDK4CY14F/

--Richard
 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260721085715.39322-1-icheng@nvidia.com?part=1
