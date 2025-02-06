Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3FB1EA7D2;
	Thu,  6 Feb 2025 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848200; cv=fail; b=ZxQB1XahsTli/yoqYk1M7kYlsZJQrK9mBQ30k1WVYqPNRUMFBAxugnnHlyZFMglglRDOcYDSt0fqzjgjlEAH1tDbUZVFHbJJ0C9Jc/ph+BhXMUWR4A8IlfcqDlodEpFcF1J+JvLoiA00m1Wl6f7FEFTzRWGzWds3AlYptHs9jDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848200; c=relaxed/simple;
	bh=lg3I9jyc6dZwUVV22x5O9ME4e+LCX63nbxOER3h/l14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GXPEwyRKG6aeSgHVlRzsJVNh88Pg5D60hxRtXgEhSqghL3bohb55l+JYOqOyJcN9entLG3a0WwFjKDCUhSDqP+aNdldyC2fqOrzaAQQsafXG9e2vQngNiBGkqX018IxDL9t8mzAwcKvRL1kmUvJqGRRYWV0ttzHpbvNmGPKUrhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zbc+ma9P; arc=fail smtp.client-ip=40.107.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zbc+ma9P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Do8Itm7prE9USDKX7ySnB8Miazx9t3QsiAikuPEqRglteamwIaC2qZN7cGc5OfoR2u0DLZXe46h+3ZkZLvTYYpkfQNr2LGr+b83sFs42v3HTjc7BFhkgAA2OSSbMH9SWUPhlQ1d8P/Oj40/UC9AB9emERLtpjh1kjSFDgCI5FUxBdMEUaAXtWdTvz6kzlXAI8y6oaAafnN/hBxxpC1U1iPvLf90gbzLjH9MWTjnLI/Q5gl+0tqrlfiSX7J3gAN5cdC6sdIDvZb0x245Ps3N+cnEwHDcvSX/u7rkWkf/E0xoMFrrI5HEPDovwxLlLTmv6C9jbnAlUZ55waUZYEzwgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iiRem+PiKP0O3HKvpyteBtozE7PTSBEWO4LYVa/mSk=;
 b=r21UWnv31piwe++w19qZwmSZ43Myg7urSYHNXdqc0oEM+g3D25f+6zdh/+aqwPmqs1cHepZ+htG7MImJJISKXw89I8dD8QC4gZEjcAOJkffiXS1K81JQDYhjFsqWNpiKCew2Q0QrBuHXosNec6+hpWpiUSU6/uTjcSq40WnKhefmuxglDtBuM4AIgBj472bbuJ7Z3du9ck6znkbmRhhQXdjc4UnhLWmBgXJmUfvXGFTZM0fRS+ctSzvABp+Q0J3EDcEUbNGgkjU1gBwbaTHUlbd3Yuy7YtQE8szHDfBlNs9/vMcuCxXBq8wTicp0G4IuM9YwMYZwMepAB0/UTKtptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iiRem+PiKP0O3HKvpyteBtozE7PTSBEWO4LYVa/mSk=;
 b=Zbc+ma9PbrfIqbPYvu+tK0Ooo8oR5oBItbMtjqiz418wQNQ0RCruXcXjz8U5b/nM7sOqfan9bqI49WMdL6MG0lJBlrHoF2nER2ZpxOlohnoharLd5hvsIpZJpR1mcduEwXrPPH8VbzYfrcSXqLXUyBTfAdoUhoqg7TxAxMUIzqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 13:23:16 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 13:23:15 +0000
Date: Thu, 6 Feb 2025 14:23:09 +0100
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 21/29] cxl/region: Lock decoders that need address
 translation
Message-ID: <Z6S3vciadA47epKN@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-22-rrichter@amd.com>
 <Z32sFDz-gH1tZgmB@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z32sFDz-gH1tZgmB@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR5P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::7) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9490ae-a0e5-4190-5b7e-08dd46b169d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L0JObBz7TvrGpY01+FKD2kvCfBgeoG/RpK0e9jEpuwkKKNGxzaulHllmKoZx?=
 =?us-ascii?Q?cxawznaruM8SC6vZFXpjqDUUUhOC7ryzIMzqQvlQMS73OFlyrY4vnKZVr/A0?=
 =?us-ascii?Q?meCS3t6Eb12qccbE/YD3eTToqyREMe83emJGJaOSq0sS4f/usv6p4ZFO4aJ4?=
 =?us-ascii?Q?GACa5X+wVX0f6ekH44ISvB+1o60tM4+NO/o7Z05QZy+rHYAn2ksDkTHUrpDP?=
 =?us-ascii?Q?eZAIx8zrM+MGeUN5zmh3lgtSO4TF2NdpW8yy4vqgQphNDXvkDLQRWEiQVlX3?=
 =?us-ascii?Q?SCCxHJfIZrpyNaGpAxOVb+IyCRa8XjUCMMsoK2Tnc2JGFfL89gtae314VLO8?=
 =?us-ascii?Q?6j1I92YIQSf1pyhgNWIrVq58jl+An74gitY4jdUj01+AcLHWU8NTxxSf74p8?=
 =?us-ascii?Q?3N+5FUU1Rf4eCg+3nvvJzLg3hYtjxl+SovE7fd+jbzyaVEICljR/xl5MOnW4?=
 =?us-ascii?Q?MyxyjNcaDdVBYCLP29biOZ6fwJkQHTjvxVhVqTKbBJq4/2QbWikn91Ntiw/Z?=
 =?us-ascii?Q?TB6zsQdrlS+0rEF7PDlmyKsHWalnaszEu7HH1KGTlbha4lIBuiwLNji6fVKF?=
 =?us-ascii?Q?TsJkfCBd5lLQJWqOG7Y9+BSm1jcdjxD4QfuRwUhlksfACDLAb1SgnWN2EEFE?=
 =?us-ascii?Q?lW3NYPhgoxRqA7WGY+z8oE302X+12hhydzbFrCuoS/RRnaPF7SPs7PpibGS3?=
 =?us-ascii?Q?GqwoLAxqIn6CjK6GZWiex9tRJMQ7uAX09LOoa0mdrsEkB+Xua41SfEp5c/3p?=
 =?us-ascii?Q?dIFbstY9z+C/nd+ZhmbY4Ew+wcRs2kjlS8mpfwIi0hHfeiSZLlDgLi94z/pB?=
 =?us-ascii?Q?dkNOvWsT4wdcFOUczV6D9dXvRY4B4Ch1hRcWFmP4Elv2KHl5qpOhGaseIPnG?=
 =?us-ascii?Q?is1GZXDr2vod+iUjbgRmf+YNd012rtYeCFMqjbfySNSlraL4sam7jj7aJT6S?=
 =?us-ascii?Q?ncyHSmaeqjYNE7rIKfQuuvi7w+jCn9AAXlpyNDFBm9956OCAgabAtT4T5HJS?=
 =?us-ascii?Q?zd0qZ9XpEWPclpOvnsU3L9YR1kQ8z+H3UTbd4rLCDr9PliEn7jMiZ1wQJDRW?=
 =?us-ascii?Q?FL1r/rbTqBvJN+nsRpEl6YNTyQuo7SFECz4O2Sytdr6WrkW+mPEzqIJ5hKlH?=
 =?us-ascii?Q?xF1aBGryRerhO2+MdWOasHMpJ/RfGsWAPpeYmyosydgKley4HhyHX3HuXB8P?=
 =?us-ascii?Q?UuA/ZUL/2puQt6suA8D2HT7p4GT2ZYJMBuSIP3QWOOQS6lqVySZHm7Qd0Ime?=
 =?us-ascii?Q?Xljz8QX3Bel4JmMdRnQnCXhXVI1KUp4alLo9WrpZDZKPLCQl2tpyryGPadiT?=
 =?us-ascii?Q?XgQXVXmRmMtNVcL5xeqhkWzrHGO51ka07UYiUZFVCZXguwz4Xcei0YqOuaW0?=
 =?us-ascii?Q?sOfQszoHx1sqUdzx/Jg7txgYuork?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TGlRf0Ks6DRCPbRp7bRI7ugnuY1XFod4wSUpGDWcdNmH9C09fCiOq22SOjxW?=
 =?us-ascii?Q?oNHJzGBfWcHoPH+xk7Avb7PXfGw/F39tVZpERcIbH4nZS/B7KyW3uJ6kvAjB?=
 =?us-ascii?Q?XpA8RLoHK7eIyRQBK3nD8s1z4ZG3WWQTDACeVHoVlMczlkd70KaccpghMnmp?=
 =?us-ascii?Q?3mwpPW9Wuhkxp+KvP2zrwREXsWHtjYPyeXzLCkRgNOLWtqqm7vFxWhHeEbxj?=
 =?us-ascii?Q?4iRQ+yvK4sfqt9jiIxXjIpV5gZsots+sdS7Ug+LItO2KqKpvG8iGjJrGnG6e?=
 =?us-ascii?Q?yZFnyJjdJNiCvfjZpIYf57Q13P2H1a1K+JWDSYyf3bp7C3jv7gTB3md84ABD?=
 =?us-ascii?Q?+lT7W6YqdfZ9+Nuu0Ikt+OQAFrAvmq1abFIIhES/K2BwWtsTjb+zLSTUKyaF?=
 =?us-ascii?Q?4HxXS38UIa/L9auAs7i8C7Ujv2NkKTOtyFqpuQ7bjEyCXpr3yin1My6cAP/0?=
 =?us-ascii?Q?+AkZo1ZNlMIH5tPZ/TzHLHecdwcpWgsHs4QrRNkmNFlURQEMgmFbo93OVIO2?=
 =?us-ascii?Q?/XgkO8/i31LKGsyJ2uhtzOqum+8h8SwCWLurvATMn6rDx5CsVJX7tkUluVfr?=
 =?us-ascii?Q?5auBZztvb78k3f099uvoB9NqlbBQUdgY5SiR9ztcQGgOCOhmNc1FdgWwEx6n?=
 =?us-ascii?Q?blC+u5+qmwsBb2ItEYat4FkND3F4sQ7yZoa0TRdzTxRYt5NgE7dIgYzIFrqv?=
 =?us-ascii?Q?oZz2N+ZodRcN27eWzt6cBek5bW7g9NJTiP1Co6xBss5k9hJwbzG94WDc4yM0?=
 =?us-ascii?Q?No75vJaRlFcf9OkeQgtIwl+aMt2q47sUr8nPw4HfHKEhXG+1nAS8EOgbkUrM?=
 =?us-ascii?Q?14U2VbH7BIv8rbIva37RFYHLAU187QgLcZOHBXlq0wannks0RhBR+5gYL+gw?=
 =?us-ascii?Q?x/c6IVVsxEE3O2315XHWdbCNmF7E25cI4cvur4EybJai8pJb2A98j4biAOza?=
 =?us-ascii?Q?oP3o4RGxmpIbinoAyW5CIofZ8iMFMI3zM5QaqmITvlzV5erWNXKvTha9pEL7?=
 =?us-ascii?Q?JGZDVkJwVCSFagVEeSEJbOURmhBtsQAchknDAglYDj/8cGV3QMcXQnPwALfb?=
 =?us-ascii?Q?fkXdwgo5N3V37Kh/uhQOV6zRykHBKNYaSQ97UTe8aILsuwSThw5N5M5WOe9q?=
 =?us-ascii?Q?G3tvSW2ERW47P7uRvIoFcsPhzluNW/qjd+bFNSH7arbdgdUnbthikb/6fBD7?=
 =?us-ascii?Q?rdHeNwbnE7Kg8wV276TXCP7mK1kRv2BH2i9QThgZlXtAdD0vhjWgiFkDfNh9?=
 =?us-ascii?Q?o+w8aV9lwLI9eMJvbXS6A3gKC/FQwXqVjXM8O36D9UO3tk3a7BFN1BNwJyub?=
 =?us-ascii?Q?RJmJcAy5KGgULVXrLNUEiKcNDfbphf1EyE1s+nST5tfMAd1UaOuSdLE+zRdr?=
 =?us-ascii?Q?gYM06+qhwqJ5OcROV87fFeiOAAKoRHMvO4KGFIxaiChyjKhpBom2yo6CL1QG?=
 =?us-ascii?Q?vek0dKX5YxOi86dGegWmnwvguYt8+wjYZdvoi6woGkRVPERROyYibD4XbC40?=
 =?us-ascii?Q?jzAYiuo9z2MJHnrOA+KGgmgeKepN0sVysX+qIcBlOPrWGSCxEo2oABiq0L3s?=
 =?us-ascii?Q?+b7Ygp/V9iUKVfrXpbEhb383NLPWYtlx4ni12RTE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9490ae-a0e5-4190-5b7e-08dd46b169d7
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:23:15.7542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbD2qH7MopMBv/g5QnHM6dUNWoUWN9zSZSKaUN4TPkbD9hpmlHpWAtFVzl1QEEQ4dv2jbs7bTRwrg187JWe8Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374

On 07.01.25 17:35:00, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 03:10:07PM +0100, Robert Richter wrote:
> > There is only support to translate from the endpoint to its parent
> > port, but not in the opposite direction from the parent to the
> > endpoint. Thus, the endpoint address range cannot be determined and
> > setup manually. If the parent implements the ->to_hpa() callback and
> > needs address translation, forbit reprogramming of the decoders and
>                              ^^^^^^
>                              forbid?
> 
> > lock them.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/region.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 8d7893878362..681c26abc26e 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -3353,6 +3353,17 @@ static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
> >  		if (cxl_port_calc_hpa(parent, cxld, &hpa))
> >  			return -ENXIO;
> >  
> > +		/*
> > +		 * There is only support to translate from the endpoint to its
> > +		 * parent port, but not in the opposite direction from the
> > +		 * parent to the endpoint. Thus, the endpoint address range
> > +		 * cannot be determined and setup manually. If the parent
> > +		 * implements the ->to_hpa() callback and needs address
> > +		 * translation, forbit reprogramming of the decoders and lock
>                                 ^^^^^^
>                                 forbid?

Updated both.

-Robert

> 
> > +		 * them.
> > +		 */
> > +		cxld->flags |= CXL_DECODER_F_LOCK;
> > +
> >  		/* Iterate from endpoint to root_port refining the position */
> >  		pos = cxl_port_calc_pos(iter, &hpa, pos);
> >  		if (pos < 0)
> > -- 
> > 2.39.5
> > 
