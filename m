Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF973EBF07
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930266; cv=fail; b=D3w4AkeV9Za9xDb+qF3eMF8PyzvzJRvObChdHjzK8v+6L2pUNDqR4PAX3c4riBVyGbiv09hWEm7sY0M+m/UWlIhk5wpATp1Czcy5+K+rdjc1XFJk+HVpgYybzSh112yToLJKADDk9zq6V/i9HQ7PLEHRJm0pGiOTxi+iXvFuPho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930266; c=relaxed/simple;
	bh=xEQNcLHDubrCl0OECGTTas6PTB8tx5TgvQGUbnJOkaI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PoEHMLYDqrNK7TaVQTu5IDsqcz8ynZJur8+WhbKpc56NuxJQnJ7gcUWpgJvbt7LGlqJlWz2IkOf+tJRLYongH1D6gyWDo+D24E2PvB5DuUpnvTEMnSNS9v1UsFGVdx9a82OnCTpFFMmFE5ohI9zykAfUqDE2sy3aqBopj/C70KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HtcxmpOs; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HtcxmpOs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784930261; x=1816466261;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xEQNcLHDubrCl0OECGTTas6PTB8tx5TgvQGUbnJOkaI=;
  b=HtcxmpOsZL3XPTKomHkuH0FPdqOMkGZ9/Z+jFIsAz6V9aE/hmbJ/IsLL
   POENtarosBCPdN6Lunxiui/hVIwFicGCWycTLvY3fBo3gA9CebSg2tE2L
   Un4dW5AdKwMvHtGw9bOq8uQm9kL+J967KJOgEc3MGDh8rAS2Bf/GD6Fli
   hq7AdeTgXzasTPn41LWXn57ZndcPALS6/d77t3AHas1nF6a4hqJ03v4lg
   pI4E1CmLqsvrpVNEebasMxGbgxEvqUe0CWJBfegqyG+JnBPy1+GjnLJ9w
   f0U/TFb57sUZ+AC4plTp0cYx1NNVHB67uZm1X1strZYQRjhDTiS6LCLnO
   g==;
X-CSE-ConnectionGUID: TgSEJXrrSMeEV/7hmAmzWg==
X-CSE-MsgGUID: Phcp3qIhSB6iSjist/6apA==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="103013045"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="103013045"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 14:57:38 -0700
X-CSE-ConnectionGUID: d5t01qUwQ0CsaXLf6nh2fg==
X-CSE-MsgGUID: hnQFYTUTQGyLypaoRFf6ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="255461464"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 14:57:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 14:57:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 24 Jul 2026 14:57:36 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 14:57:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D70J0NR8zT1okTaPrI5QUUHg1TYe5qArGnQthjQGEc57NsZA1XBeKDt5HiUNx0jL+IgbqOgQ9S7YlcMS3bw2Up1UJHzP9/2pfCo2TXrBusNgNWp9H3V368BukXRGNqcnuDxYIu/L3vlybjKtd1KPcWYJhgevkrCwd4eYQ4LdIPZ3hL9uyufGVbh5PhaiJBCKc6PDzTTIuBtfkee+yuv1Kn77boZ3HJqRTqEmXNQi5v/X3Mj3h+mf91q6ZmkbAjASdo5rp7doMPnQJq8lwRrPpajtPh8W/+jTERbjrDH7N53VWG/+yOG1ztN0O8IZf0ZWGqXj3O8y9+4oQfRJifVQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19LbyKVuiw0yHefafNVLupMNxCgUOcCChWSPD5SNYQw=;
 b=stnmIAXZTEzHmzvlhWSHqH4dpI+IY3CBpx3Rgr/Vv/R8kNOcjHRoqC14AQe5Dr+qMKBw1m49yGuBI6tb07vzv0IKr+jo5FC9nVsiwf5I+Rao2avhXOaYgsGG/sFkYdtrd8we4GWhrFvYzOd43mIaDEfNnxVG9pb+8GjSOebfW85UTxJM+7SDaIbj8wfpydCf+uJE9nov6PTd/mBFDcN2zHlhJUSAGX0CCbkrkn8cKcLVuesOokac1w9+ksKW1ZiJlueLkkGsQAq3xYOEz2tC40Sb8uMVmjbFbhPNslFMmVmXQZg+zZa4FoS3UyXyaPbYAPc+9sWT35B0E7lzfuEGTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB6773.namprd11.prod.outlook.com (2603:10b6:806:266::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 21:57:33 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 21:57:33 +0000
Date: Fri, 24 Jul 2026 14:57:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Dan
 Williams" <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] cxl/region: Use __free(put_device) in
 find_pos_and_ways()
Message-ID: <amPfyjkZAy9Tl-_r@aschofie-mobl2.lan>
References: <3a36953b5c665cb9544ba61dafbea0b0fa508c77.1784654628.git.alison.schofield@intel.com>
 <03aceaa0001651c28f221988c9e845f59bf1d84d.1784654628.git.alison.schofield@intel.com>
 <20260722005648.360ddf68@jic23-huawei>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722005648.360ddf68@jic23-huawei>
X-ClientProxiedBy: SJ2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a03:505::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 974e4763-4737-41cd-d0e2-08dee9ce90b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|4143699003|11063799006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: 3TsU1V0KOx0eKFBF70jJIqmYbnYPnDHGXhOPxm6P0wYP/S3+WEFER+LEczZrg2cEx6inrGfHKNezI/M5RbUVTT3R2LZby0WyiereCCFvoC6MPJe40pQEnyjxJxxMgExwMWVwnVWNjt24TAPfriNiSke40UB499PXVdMAqEg/vLnF1Df1KKael0S8k/9sBli3tfq7iBcf5kayoSb/KNH1a6K5Z0PZ+nKUFUyI7Vm88NDPVgYlAk5xBqH0n8KTh+g5Kjb1eGN7u3vIsfRoq+bv2O9cUI5ld2Kp1EXWzU+80/qUfezWDHPcPLgLPfxMBCrpQIRLr3TlAr04nhAxyh6BOqD1OzNWwI7NTEs1H2b76Nv8LYG0bPRT+14096JY/r70Exmu+3k2uJGlWpKeH+NKpJ4CHVSSzxLd1niaA0Xh8RjgqRcQoj56uBebQ9aIvHqV70Ufp7cjtnK3V39aNOLSvWIqwDoTjxDlE/nUdrzg/cqvnYhMfskb2gCQ9MsBIgn3p+UiFyD4bMxERJ/ywPDOERLGFKtmcRcFetMKVmR5VtKHPAQ5i2afsgr2EUSK64u86Aa7s0duMvYvWNdvAZl8TlKgMAtRpqNST3mHqDtnUsK0Giu2Ix8nngyfSgNrCWRAnWfemNGM8lKfwTye7ycy2jnUd1nJ/ish1io603k2Q2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Is5zDr9zBM+eYadgbMkhs/pGuPqLcAtQ51iojCKJvxl+iulzkiznj+43Mc8s?=
 =?us-ascii?Q?c/RMGFeBRjwOlnR30tLSn6QkidIVak2w1r9dSvEGI8g3pueaykJBFl43C1wK?=
 =?us-ascii?Q?WjseLYzksU2orllkqRCUK50gisHEGYxIGMetCCOdqe/ay5f993NpNOnovTdr?=
 =?us-ascii?Q?tAlCrvelEPycGvcfDwlgdmsX+3UjnytouN9qQwO4JsDNfbaIAAJ0sHfJQk6e?=
 =?us-ascii?Q?C9watWIkD86+O7Q1csqEIVJSEncqb9FrXiL+DhLVPUOgDc+2lmO/tuqpStYC?=
 =?us-ascii?Q?YuVdpe7X1Em5fFVOmiLOB7KEOiohrSBYp6DJWc3upnj3+PHg9dYi4qRefZC6?=
 =?us-ascii?Q?1YHh3eMREZod1KC732Hnj7v3l6u7h+z6ETv/0dc75zLzT8IElrS5mrUQQWSF?=
 =?us-ascii?Q?2cpwF9JLH3SfT3iVOGaU0KU0xoHXjIAOEFlwI9wBiRzee9C/GDlfF57/bZQM?=
 =?us-ascii?Q?jOAqoeZRSYRUgNx8Ge9DgU5v0qmI81FkKn0BFDxQLRi2PWnEJuRIelGD2K8c?=
 =?us-ascii?Q?m125SGZIt4rqgTnX1yXAwGNq0CFIAYVgbEUMhf7NeRHdaRpzThXx26eb58hL?=
 =?us-ascii?Q?4EymMexRGEpAn5OrHaVjG9ePZChp8Tc2BHVqQ5XVVQWPOgzPeeHuuYx1W9zf?=
 =?us-ascii?Q?xTq9rHaSK6xj/xZ6XWGrVW3lrsbS5AA+7qFm1Fc985GisVDF6Zl9EGye1+1N?=
 =?us-ascii?Q?CqK3IlK9bm/4CMQNLmhCv8dex5SEtTFXpFrVrfG/xHRFjwn9HNmfxzKbXFR0?=
 =?us-ascii?Q?QOntxDIx9dvFosd8h1E37ipZUa3BDh3rIT6bXUPQorO1G4T/6jSGEFbs0xZU?=
 =?us-ascii?Q?6+7UEx1r0imhDu1iemU6RqkgB99XffwWXb5T9inJLyO6eKtxsAL13tik6/uv?=
 =?us-ascii?Q?vGXy4tdaASdUCdetI1CkNpcQm+XqCeXzECAnNXj5if7NY6ichjRNwj34s0PJ?=
 =?us-ascii?Q?VArGvlGgsuY0afNqtWpFQD3ULavowzZPOKJ7eFsIALVoIqqQa8tQwsqG5570?=
 =?us-ascii?Q?pLbRNVSZ+80Zmj7IKzsspppql+eUwlgd/qEVIjYLQdpNEIDJV1+X4MemjHWz?=
 =?us-ascii?Q?iJolv1fg+rPHKsuAavuK3joz64bAUQqV0oi3l8clba5nafZfdCo/qTlL/oxF?=
 =?us-ascii?Q?qfD1/87kaPRsncTjvy0vVZxPc+/IeeORqEDI7Hk46i3BTHq26DUVgP+YAjCN?=
 =?us-ascii?Q?P6m+jJUwYKKVS3O7jYTRP9R45femhSHwEL8FFO9kVjUBWplSgywI/bObqrlw?=
 =?us-ascii?Q?bo3ZOtroJp0CIE/kZvUmGgjKc1trWYc6fr50RRJ3Ln4zHJBQd49Hh6EP8YNv?=
 =?us-ascii?Q?m/L8eagL/omwl+8x8Ppyvy+225sfY5knfrg0QQlliFv9t/XBY97V/O134X9R?=
 =?us-ascii?Q?FrZYSAG+80XOUMT7x/FSLEegikNOGiQRUq/rLlcylrPSM6E5Mj2WGGwHKa2M?=
 =?us-ascii?Q?L/FDWII1X3WXmcrHV3r8Zg0tPwt0u4O25jrJy0ebOz8DYdrBGX9zQtYGgvXJ?=
 =?us-ascii?Q?DIzhejw4oeRZZZqH6JcreZiCEyFlJyoADnQj0YDgUzFVchOfAvSrd6UMsn3x?=
 =?us-ascii?Q?hiqlqtPw3t2GjLMEW5xxex8n9idL2D/XyWdLdB4kOXaflnPpETNgNy9tdTAQ?=
 =?us-ascii?Q?VUAa2VsEI+U947KNwHrQ6VrLLq/DyAraf/LdTUQycyT+8ONUnISdidX9GuMQ?=
 =?us-ascii?Q?pf7wMb/IrF5FLE3xA0IyUMvd4e44xxcuOS1txcrl+jIAcx1EzZlB5SG2ehSj?=
 =?us-ascii?Q?HkhdY/g+C/LEzBz7pbWSeCY9/XAWxMQ=3D?=
X-Exchange-RoutingPolicyChecked: n7OICelYSWYk0VNqNw8KNbP4m5xKWZY/VoWf3AZ42fJGcrxWNqC9lnDA5iDGjGh3jpVIH2fnDLuE9lHfAMTc476XObJIbX6ga/1tbSSX+bGGjDgnWUMkAQXtSk642ynBPVqBXkIp95IPuHvKvedsbiS1pQHo1kAJ+UkeJnHBQHZuaKZfIyq54YKuJ3IEhGpI1vehVD1aTco1/0MTkjom6gV5rFysn/sxxp67JzQu6LXnLO4KSKtoQPKTI7pV0t3nlInSRilNb4jEsFjaPsUwdYTC5KUNaCwSKpSCaw4M8XqSSilFVtVBUzGI1PrrdkPAGUcAtCNo87skdx5Ut+aVIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 974e4763-4737-41cd-d0e2-08dee9ce90b6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 21:57:33.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUaJwc79ylQsGa1hoLIuobAOqmzK/dtV/5nHLhnApJf1MaJLyql45OQwXouUhx4PHjqrwNAHbejcpuw4RNMwO+Wx0ONnlXrSLCcP8X/D7KE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6773
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 12:56:48AM +0100, Jonathan Cameron wrote:
> On Tue, 21 Jul 2026 10:37:04 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > Use __free(put_device) for the switch decoder reference returned by
> > device_find_child() instead of releasing it with an open-coded
> > put_device().
> > 
> > This matches the scoped device reference handling used elsewhere in
> > the file.
> > 
> > Suggested-by: Li Ming <ming.li@zohomail.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> > 
> > This is a new patch added in series after the UAF fixup in patch 1/2.
> > 
> > 
> >  drivers/cxl/core/region.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index c86dd9d55e93..4d7d96d03ece 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1911,9 +1911,9 @@ static int match_switch_decoder_by_range(struct device *dev,
> >  static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> >  			     int *pos, int *ways)
> >  {
> > +	struct device *dev __free(put_device) = NULL;
> 
> No to this.  See rules in cleanup.h.
> This is the path to grumpy Linus if he happens to spot it.
> 
> Short story is declaration and destructor must be in same statement
> as the constructor.  Here that means 
> 
> 	struct device *dev __free(put_device) =
> 		device_find_child(&parent->dev, range, match_switch_decoder_by_range);
> 
> I would go long on that second line given it's only a bit beyond 80 chars
> and the two lines are horrible enough to read without becoming 3.

Thanks for the cleanup.h pointer.
In v3 dev is declared and assigned in a single statement after the
!parent check, formatted as you suggested above.

-- Alison
