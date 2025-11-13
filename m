Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6F22882CE;
	Thu, 13 Nov 2025 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064636; cv=fail; b=k84dH4TdKP3VS4p2Z9KWAOU+KkmRvyb2FgwXXftArO8i0LkiPykfy5VfpQkXtgynUW3TFGDQyinD73+AW4mmckKdkBrrF33e9ol66zu48QkFwyHeCrEn/2xgMl8PCxbUqAJ4reTyrgWG96k1QrOSlmViYgWRnCiv/0O8ITVQYLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064636; c=relaxed/simple;
	bh=vMNav9QleXTFdUJbvd4gPQdB/6F+wctQ+w4Gf8jZgJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IT0ThxdrL3IZFukeG7Q9K6RhzHpxCi3AVSJopVNGUFgbR7sGKRIv8U2IcyUY3sX0D6hxcVqsLHXNN1amxIKay/5bYaxSqFnNY9IDnqooL2+RAtik02JzV984zSHkgjk5Msrk4CKmdio/UVkBIt5GkSDE8wk9aFscpT4ta9QyC6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=juUkEOXW; arc=fail smtp.client-ip=52.101.61.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="juUkEOXW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwJJTRgubDipj4WiOjYQTzMQixVlDIY3aP2YPFb05cBtu/lAE8pCsEE7LxLgLCanHE2/52Rrc+ClmygSOBDIPJsyUlz04ZmzeKJTqvhuLEMtLB8eVWz0GLHnDcgY9e/tq306loVp4Xtzd5aqA62CiUkkWY22A/TBTzDfrh3Z/34GFb/5++0raAtiCed8XCIKnpwfiTmrUz2Wty8fTFv7tFHE0EZeTP8CgdMrf/GfJcxpHd6eQLeYFamJjhxEpzplIdY5szq/wXzcBpFWpXoRmbTgk2rgqHn8GnS81EyqhiDsfIzdSX/nl33b+6YJ5ofB/17Q/g7zJSSEFzZPR0Td1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqPDktxjCbAibR1f0b/6SAZfDiQkLqri1geYha3bC0g=;
 b=IrrZ7yuaMDEqBNZ+Vlj0PL6B97UDAhIyHcZohtxqD+715rsKcFWQex7gK/7x2kZ1b0QdvhSev3cnO4k5XPEma5X/X/lwLIwK5Xy0XGPI5Q1tK3C9UAeEvvbsr5fqRhkiuEila+/25mCZZk0HMy7CbDjH4I++6dSmOM0LCUjB+gy3q63apgueuSDukGH9Jacs+JRqTyMGQ5gFkQPOiJPUq2EaUdZbB4vrAIrQLk1i/wf/hCKiikpiuu5qtJoFJj2z7fveifvGIQv6LkN/5Ef9NH0tM6qChvpj2m6/UM/o/d5L7MSkZBS2snN+6c05jktp5hW9ko1GXbM3AzaN6xvNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqPDktxjCbAibR1f0b/6SAZfDiQkLqri1geYha3bC0g=;
 b=juUkEOXWjiitleYS0iKHjpkQf2f4i7WeD5Wx2+QFzebHf3gJdEVL5HpolYB3eMKmv5EquDEM8XSYssOkZoZanyThmPYHmYo8vWDYyhZ5DGYNN/OE0bnoMY3SPVOpzfS8lLay1VjS4hof/axdSlqthokHrZaffv7SpDSBDOsAEU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 20:10:31 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 20:10:30 +0000
Date: Thu, 13 Nov 2025 21:10:58 +0100
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 14/14] cxl/region: Remove local variable @inc in
 cxl_port_setup_targets()
Message-ID: <aRY7UhpGpvOeWhAF@rric.localdomain>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-15-rrichter@amd.com>
 <20251111153644.000065bd@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111153644.000065bd@huawei.com>
X-ClientProxiedBy: FR4P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7e3faf-6d41-4599-166f-08de22f0b19d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iYpk8YWguMkf8XkFEHSz8BvmkDALasNlRKCnFeYnGJMbqGF/4IDWPBk9IkGu?=
 =?us-ascii?Q?8w7GaO2mKR6H9D2Xa5zqB8voowdkKWPSdgcHnOJgLvJwtnrd63gg+Pyczj7u?=
 =?us-ascii?Q?LZ5g/cOnb+JpP5oI4HPkhBZD+UyFltxxYEvf4UlvSwy5zLBY1IYj3AswJMag?=
 =?us-ascii?Q?Yllix+HFJ2MaqLs+wuqPxF7KHhb/yzBe9X+RobgLBTI7oP7MfJ7RxKB8IDsT?=
 =?us-ascii?Q?g2QHzZsigxUkgBETR972jD0e8Q/7WNfGAukOZumGTTdx5e20MF7Q1LL3GbuN?=
 =?us-ascii?Q?iK6By08Ev3CqzY00/IjbVNzEm+t2DQDpzAQbBvLvHMev4esYsCcwciGlZedH?=
 =?us-ascii?Q?9eQ//IIhM1TREwT8MXc3x1roqL6pym1pMpGiDge/iNT5fH+G/yyAHhqJWR/o?=
 =?us-ascii?Q?HC/AJwZ3tnzRg2hMmxkrPDUk6Sis0rggQvZJBow4/o3zi4uNxh4o3qWmaf/3?=
 =?us-ascii?Q?ed6p3jXXg/CPVHJ921VM44UgE5vrFG62blqNLk5OCb/0KeHnMAXScO5ImJyP?=
 =?us-ascii?Q?5Ma+3VBAo1YtL3ZBrBJigPi3BCyDDCmNLTKbtvLkyDN8JecjmLB8BfbASxb7?=
 =?us-ascii?Q?frfY6ShK38889aLtX4wtXJXSzRIsM15QHCIds0qftyadYysouO4drjraeSzk?=
 =?us-ascii?Q?ztrv0Ix20lpcLhh7GGtSY00IejXA6e4aYgEQE9ZKxd986ivY1yzdCICIH48l?=
 =?us-ascii?Q?RQwx/3p2NJAqxoNQsLQzodT34pXA9z7A/1On9zYF1KtQ3ozmBNfP6Xt/cDV4?=
 =?us-ascii?Q?1wwDctbXHZHm92Ji7A57bWXBBFxOc8Gh23nl+6YQSHg9EBCaYQ5O8mfAeUAL?=
 =?us-ascii?Q?6dX9RHC02OsbG1ARMz0afSPucJdD3AKY0QlD5QbpyiXhtQEwz7gTF3bNfi6x?=
 =?us-ascii?Q?ChkaBIMzf6fs1+SaEKpYuMj9Xk92cqS4r6Yjwc0OB5UGhJbaM0bWczB4nzet?=
 =?us-ascii?Q?FbkhUEdhOBfbOar/tLagOtibuXzENUcDmFT0WUh0JIRmSG168RAS3YwAG2ND?=
 =?us-ascii?Q?/hf7jLXEpzmbr7Yzhx2wWX3ATLRtHcYl8GRWZeOCZXeq6aqltF+kNWYD/QuA?=
 =?us-ascii?Q?qdI5TWVAa1rpjNoR2XOq+oWoV1O6b16Q+JBNTfeZMnn5vem8LMfj2URPcNu1?=
 =?us-ascii?Q?KISvrVymtu2FBjneYA9y8548Db4qlkuywRhMdL67cBj01PQ2+XqYRjNLiey2?=
 =?us-ascii?Q?Q1ocEupfbKSAh8wch3zYGprnhJb7Ry/dfcmmlfJrn2vlmzQPeT6iXzlPSjRN?=
 =?us-ascii?Q?u6YYeR3HEXfWbXiVhSJPvjcxzYyoBqgNUiH1WjOdtsBXNRdYN0nfZHSnBbMi?=
 =?us-ascii?Q?8MSU7mgHg3Kv46m/lcCEN8d8KbJfY0IwPKsuDRViOIqmxKwo8/C5/ODtfoFP?=
 =?us-ascii?Q?7k4vwteQg79/QbYnce54fRbXh0XHF5TFGdeRkMkfqqHvXt1AfC15sZ8RETeP?=
 =?us-ascii?Q?urJkEn9OS8Q+p+e821iEN1pBfadvGwm0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PLGkOm79k78QmgsLtWOEUxs1GDnSESpZRtsTjRKfpyWRqJW8jIAeJcE+vFJs?=
 =?us-ascii?Q?63lCPzvfdTZ32/GN14Mmt3e1CxwjtOfXe3lRbSB4V4KTqtG1mUL0gCqMgKJz?=
 =?us-ascii?Q?R45MBVbY9hfHjWLBDhLTUK6Dzd8Lz6La2fchhFDpaXB5/kypWLatR+9+nVPS?=
 =?us-ascii?Q?OnDFLntx1naFrxQjpLiQUHSBUeVT80cBirPHPE0o/ip3p7kSVMaOqLiYMikv?=
 =?us-ascii?Q?2Aaba7XhHLna7biobDdHzan6yKp+y3CBLvE2BcksHjvbX4V1MxPAwY+J53u3?=
 =?us-ascii?Q?yhse784DGl1pvmhPpgd2LOjzBRIpTpKyFLQyxkBE8Sjv5q3W8S/2QL2aTfPi?=
 =?us-ascii?Q?Ci0b7njvjnUOMAStJ0ea50/1Uyr6lq5NALYf8gpc9HbfwsKULdk4rmek4myw?=
 =?us-ascii?Q?4+APrycYDyI4C+U7ylEAty8PRQQ05JF3TEMJjFo0Cdf+UsMUytgz9ZxolqWY?=
 =?us-ascii?Q?FPEb3Z9uzW+a5AlJ8swzCB2HAZJpIfnNHiaarWTdim1eF8tG4YA2DCHILo9R?=
 =?us-ascii?Q?xqZ43D5OVI8fRyAr/ZtvZy05Vw9KaMv+te4uG/kc3t25rTcZHT5w6Zuo6q6m?=
 =?us-ascii?Q?EE0dyjpFZotWWYQSN7bR4kYa85h7btimhW8JpvHso3Whu+nwjGZ8DXWC4nDK?=
 =?us-ascii?Q?XWSS8+9VoUaoFKh3w6EAK8lpnVDGD2LT9a2/NGfv7LHv6isTBl//+JaCSNIn?=
 =?us-ascii?Q?lw+Y8jmCAAACu9BK+0WpYlY8XziotVK/elBnxb5/XwSgOsp2AP2TS9bTh6aI?=
 =?us-ascii?Q?oV8JAjAvIcdxJoWLRtT020afNozKv0y8gKb/w4L7Fj4huxC6vFPWBKLRhlho?=
 =?us-ascii?Q?+BPM6xjOxFXygQvqYuAmO8RlgjpdKDhxwFjrajtB7kaO3e6fNoKnKvuZoP+N?=
 =?us-ascii?Q?HQ1An532Tees5DesjiepvhKshAKeVuwpnM4bAUyi2+gxGE4mEC07ZjG9o3bT?=
 =?us-ascii?Q?4lRDjld5m54UxxohHzJeVkdcnIecjqR4q726I4QzeYgtslmIvPeu8la5mPiI?=
 =?us-ascii?Q?zsD6uQUhNs0hmPAmqCppQbg46tty5xg5um2hF5Dt/wMBJ1WSGJsZLOZWCpdn?=
 =?us-ascii?Q?AbUZycTUApe2CJWDYx1ivl4SeAKl5pIdT3IZI0Qm5+87z7vdf6JIuBFIe7KP?=
 =?us-ascii?Q?HuAlKxaxuOrch+j7Dp8QdCa6s3ywEMHnceEjGxmVOpF1dXL/98EJ/u/LiJ+I?=
 =?us-ascii?Q?2HKZNPKZoaAMTrqyrQQ16PEB1QXXgOZ+YsF5mtOyOKet1zH+zY9XkvoPXK5y?=
 =?us-ascii?Q?BXChBmcdK/eZl7VQUkJLz4HyCdxGKCM2T/PxDOOMmD1PgJZ/gJ00m2fUYkYm?=
 =?us-ascii?Q?RLrku5rc7BvoMgwXY++AozOFEvm9vKlmltt9+Ua/EZ5bvSzWp36Q/1Na1eOO?=
 =?us-ascii?Q?MNa5utvqNs1Zvv8OFzNYpMRkFPlSYCrnfpnlRwrMbGGXLIp+v3ryC3x7T/4/?=
 =?us-ascii?Q?wcoDM/ulNm8FQMGgT4FMJCEAe1nsFWP4z5DCMpOoAga/aT08GGbFEsv0Bgs0?=
 =?us-ascii?Q?uxV1JliFwMx6NqfVZtRJgI+aj5L7H9r3QYt9HzaTC0M+D/rPhdHHpjd9VJ+X?=
 =?us-ascii?Q?8TQKxsn+2H3sb3jvpi9CvtlVcYqAEL82lG3SZHFm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7e3faf-6d41-4599-166f-08de22f0b19d
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 20:10:30.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UzWbMommuYPk4pbeAy/TidYihRBD9UObVTsezL83++/sXANLBOZv9IR5i6mQzaWKb62vFlG0JaBuDhGSrZMPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034

On 11.11.25 15:36:44, Jonathan Cameron wrote:
> On Mon, 3 Nov 2025 19:47:55 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > Simplify the code by removing local variable @inc. The variable is not
> > used elsewhere, remove it and directly increment the target number.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> Hmm. I wonder what the thought process behind this once was? Ah well
> clearly not needed now and I can't be bothered to do the archeology /
> have too much other stuff to review!

The inc was there from the beginning (27b3f8d13830c). Maybe code
changed in the area during review process and left this as a
remainder from something else.

Thanks,

-Robert

> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> > ---
> >  drivers/cxl/core/region.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index dec003084521..a81fbe9cedae 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1332,7 +1332,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  				  struct cxl_endpoint_decoder *cxled)
> >  {
> >  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> > -	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
> > +	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> >  	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> >  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > @@ -1524,9 +1524,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
> >  		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
> >  	}
> > -	inc = 1;
> > +	cxl_rr->nr_targets_set++;
> >  out_target_set:
> > -	cxl_rr->nr_targets_set += inc;
> >  	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
> >  		dev_name(port->uport_dev), dev_name(&port->dev),
> >  		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport_dev),
> 
