Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836D246B5;
	Fri, 12 Jul 2024 01:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720747663; cv=fail; b=CHN9bFcCf8NGlmWRkXUu2AaqazIYP0pPObmZrc7aDKX9znAhuUlOJoOcxcUqldx4Lc1nRGSvl64Dx8W5G6fIXBU5xKNTBTrjxYS8z+c4vC56mKmKP5X0kEN2vwD1/c1IU9k2FvbKahha3e4Mp/Hq9G20+xRc5EoUOFMh6bFqT1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720747663; c=relaxed/simple;
	bh=OzSNoR2narLPxKu66I7ndrka+KdicHg8ak+oOutbFkw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f+IGJomVneOVF9Lj1rWBJgjLEpZaH1OGyMw5cyx/qIyqVdtwkxXWj3PCE3UIrSrbKxAvVyG6RQtmEgZXb7jyBWWZENbqhl2q07aZXfm8aSV7gCa8TftcqercUFWA4uv42pkCaVnFZmStA9Qufq1XFTImy4gVYzaQxDfSHO+LI30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNssDpFL; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNssDpFL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720747662; x=1752283662;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OzSNoR2narLPxKu66I7ndrka+KdicHg8ak+oOutbFkw=;
  b=HNssDpFLl5W9RorHfMSZ8rJbp/zn/bDNBeMLjQTGW9qXf182RiIyBRQB
   dRLZlc/8Yx+EjgMWa99VBQ5soFsq1FG5UXP5WoQYZgZwnNDjlbbD3ovPW
   JwEyU76c9alLiGss8YU/PpuKemqC54xOISd+HyWkPbgvU+E5RuYXNyfFZ
   L9jHhoDj6ETmIcCLlbTnP6KcIYZHCH+NAEreqRweclqEfQS0Dm7/fFSvo
   OPr6kIfBe56hutwnMY16IgUx5zMt+6OpMRyXqy0LJECsYaVNHDo31ZAEd
   QHBwanUa9+57VAEo8ZZ33mjT8UZ6D2AyKWRiFBF9Gj4aPV6/YD2z04U4G
   g==;
X-CSE-ConnectionGUID: V2d0Zox7QQyRpD30xKmRTQ==
X-CSE-MsgGUID: ORvLl5EWRzKZRG3L1y93Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="21990290"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="21990290"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 18:27:41 -0700
X-CSE-ConnectionGUID: /qVsz/2HTZ+eKnPRUh58/g==
X-CSE-MsgGUID: PkeNFtqKQoSluttMKBchXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="49519109"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 18:27:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 18:27:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 18:27:40 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 18:27:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORtXSOivAeCWuJvYapX0+juna/0epVNWYvC1Zm+0Pd74Jwucq268Uuu2m3YO4DUwYSlf6c/cwHI0xeQJiFyJ9vz53iiKI0dBnaGSVQTVQ94GiWFUiBFYpp2dJvKtpiiFLfR0I67uO9p5GXphIZ1KhikuBuofVumhrBjvwjQbW6KzF8BXheAuQIlHFwAVNC690xuBxW2bGoc17eu8RvMqTHHaUYcAbYTZ6nj7L0nxlCv3MJhXiCSnTlldxbPEDq9fgQ0z0kemzId76/m4hF252jf+VRp1cyArhqWhf+7hPVlms5uO03f8XVIHcbyKmYsBDXWcFcRzHyj1xJvJOacBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjPmaaKHOucgQgpAj7HBIbkTqGtGql5j2r6faM4t92M=;
 b=uHAW8Xb12SSKtww2cAWtvvV7dK2CUYm+/kYol/4kq3o6bjrTkAmsHiQfaFHc3cTkAnQkdHC4rJojXudhR6K1uy5YHdKxEkgVtK9PBiPOCxePRcWbHDY4Ka/l3MbfArRHWHRFGkTB6ZpNQrcCHktdigKXNa7tEJeLGm3uyfirb4ELlgwokIQbMZJkYcBBoJdWXxtXVpoXj/cgqmO7RbkZ+BHQROswXDIT794KXJPpESdd0gGGe8QMNMDBzjR5fdIdebTGTsB06v0oT+ZdOSQlpBev0Ce1WbrVnAgp9STaPo06lpRayc2Yy6zdorjJ8sHo/uic6m9cSDcEU9MZplxftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5270.namprd11.prod.outlook.com (2603:10b6:208:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 01:27:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 01:27:33 +0000
Date: Thu, 11 Jul 2024 18:27:30 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>
Subject: Re: [PATCH v2 3/5] cxl/acpi: Add platform flag for HPA address
 translation
Message-ID: <669086821f136_5fffa29473@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240701174754.967954-1-rrichter@amd.com>
 <20240701174754.967954-4-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240701174754.967954-4-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:303:8f::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: c527872a-a290-4f6b-1531-08dca211cdc3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VgCvqvogDNJcmCxJ/HQKK32Ff5jNx7I2fyzt4JOsxzLeCx4MucQE7/FB7+gn?=
 =?us-ascii?Q?A0oZXVViH803d5WoobIu6/1oD41qgqqBsLqUxNFJxO651+sd9fT8SpIiVKvM?=
 =?us-ascii?Q?/t4UCjUFns94umzMhKsqpGbuLBuRrdp00glN3rwaKY3qGph4AONVHvTG1xnN?=
 =?us-ascii?Q?4eCdzmhpLboiGOiSG9hd8zZZbNdxsuepMYhPx3+hs9VFSpq+XDd9KVq5nyxk?=
 =?us-ascii?Q?Vx+M+TQkxmjC2KQ7oBha9xOda33i2y/oTsU31Cr0zApW95JW2AWIglPl0ZAX?=
 =?us-ascii?Q?LOnROplMfrmFd+pNDXFF+h9382hSj7ULpUD+CXyQrygxv2g1m0TK1q7xL1sE?=
 =?us-ascii?Q?Dr6dBSJChxdeC7YCWezSqgSeYCYSEcuGKylER9BGbRWkBlOHVGHE9cTnh5Jk?=
 =?us-ascii?Q?+SEWPIkcn9mIQPfU4/9+b9/Rab6zW+Bx8KiaeA6Q+NT2T6ptHtjac2S+K3Pu?=
 =?us-ascii?Q?XS0+ZeqTWrxsIP+fez/mBnNlvYlqcOwyOXO0DECgU7McH5QBxZqmXB0tta4g?=
 =?us-ascii?Q?DJ5npDjMsnsFcIrXI03Qw0guXb4Aom92LbsVax028FzQVY+kJyaopRu3tvhL?=
 =?us-ascii?Q?vvumHP4Wtad7plLcw2s877fbTJVyr4lbCFbn29Bi6BMWPIiUMby4H1CDJafa?=
 =?us-ascii?Q?IfYDHRqby3En7nwOsoo0kjuaqz/5NlgDjO1Hs/fsGNnr1vHUiMVeffkgDC2z?=
 =?us-ascii?Q?XG5UMOdirDBe12gfFpiDKBhiXbkzVc10uVRvZ7AhueeC8BTadmvYW36T4f9l?=
 =?us-ascii?Q?+ooS9UmJ05TBTtwD+1ZQm69WzGSttsM0pLYPkEhW9l4eiTaV+YnQhRwApgb0?=
 =?us-ascii?Q?mjxfwJuSOfvsgcfGetjwSakbfdZM2/IWB0yQAP681Dq/k0zDajOGYmg9H4+l?=
 =?us-ascii?Q?uzLoC9IWp3cVIiz/I9FEzqanK+j6DaPaWwR7VG8p86kGO3frFHGcg7zzZNG0?=
 =?us-ascii?Q?viSuGOyBPkU59iLJmtzuVDbt1Mn/ioxuxqqFp31nPRFeI5hknybzdmzbF8vz?=
 =?us-ascii?Q?6fbj/3Q12+pd8+ALBZ6wWIxz8f216p+s1dLGpba74KHGUQuUoay2361CTcSV?=
 =?us-ascii?Q?ecVdgbzYhyYGojKir9YLHrfTBF9RlRSm706cgf7KOYk++YNOJp7VXq4DROQN?=
 =?us-ascii?Q?crft9lqEz4SdkXu59SHxTpA7TxdvdgPi2kz1Ag1YaGHArrVU4nhc8Xf+KsSD?=
 =?us-ascii?Q?YwmDCyczL+AiG5Sw3NwThoKinX03ROx4/NPkaApB3Cnaw8972OptT5DTGv0l?=
 =?us-ascii?Q?U71p88acqfdGJhO8fm5fyjyc/Qolg1YiodkUF5KTy5VeYbHUiuHcTQlMrkb0?=
 =?us-ascii?Q?H+rlBICxKUoYCRa8FOGbMXCs6Rlkxhz7ckY+C1HmC/AOIg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K1Ms1yxFvTtqHaOvlDIuKQy3AM1B2Y/n8tmeVdiUzQi18YpU9I/kc+rT5hK6?=
 =?us-ascii?Q?NQlyFGQ0+xTQ2hc67R+dEcl2wx8mM4Hs1rl1UqPpnyzv8plWhyHZ2zXPM244?=
 =?us-ascii?Q?awx/heVltUKPKBw+6omjlGvivNrV8TQqrk6eAJ+HzK7aMqPOLTiC63GYhqwr?=
 =?us-ascii?Q?mvKLVp895WsBYLyAwKZI2hthpJHgKo19uzsFhJdg4g3tuvGBKp1oGCIloyRv?=
 =?us-ascii?Q?QVDAa/pyVFW+4GBbPm46SRISDF7kndqIXSIU0ZUkrehtYUoY2dT19UCYVpIR?=
 =?us-ascii?Q?Efn7DpoVQn1usmpTt1mQqbJwL/RL3gDNvd/3JbgrWiozHAVLQRA22mRPIhiJ?=
 =?us-ascii?Q?b0SBKCWFI023WuG0dQwNbl9GOZMIOAtJC1iXNkoWSWSrHAMUni3e5kw9yxBe?=
 =?us-ascii?Q?vB5tno2LhIY+NQ8+isClXa3vHsf8wQPuBt7JPsE9kgngkHchufI6Y59/POcB?=
 =?us-ascii?Q?CsxyCCqf9i81AXWei/rVlv54KOxC53YshGFhu0wTDzX/R+HGy21ZqhH/uzN8?=
 =?us-ascii?Q?mx17yUa/iULumrCzSkW0eX+SerFyC+M6vJTO5za01nbI6SdPGuccqk3/32gw?=
 =?us-ascii?Q?rAif8R7NmRwQ7piqXvC+5WEWqnlo0yS18+9P4Ku/zCZ7Ds706136x7AmHaps?=
 =?us-ascii?Q?Ox8vmTGUbdaKF0DWG0rJnuT/InGFCcOgo5/ikpsRypv2LGKjbMyVA7q7R5pM?=
 =?us-ascii?Q?k/24+8e4p1XwJQY4VwCw7QT2TSracUTb1S19fwgWuNBPRTg850jrhv+qakEs?=
 =?us-ascii?Q?qF4vO82gdi++0eEw17LchAHZyM4DFB+u/7Gyw4aL/Wl2VMhpspXBiVJlHHTI?=
 =?us-ascii?Q?2kllV7VCn59U5cRn1vFDthyvjWxP6ylLHeMtWGpEXMHOSIKYBVov2V1ajoWi?=
 =?us-ascii?Q?EY2MnRYn04nthDcwBS3k+kA+IoNC/90CockJTwCNVpWwloqDGgFkW3+8DS9f?=
 =?us-ascii?Q?nP0C5eYimXLdFDSkCqvAwGOjvrFt94oorXZkQI6cOmKY/PutiG97SmPNz67w?=
 =?us-ascii?Q?TudXjX9AXBOxw0CRP4VDSVhI25kgZYf10N7poJKfndlr7OwTNWcmm50hJEOC?=
 =?us-ascii?Q?Aa+2HikjSWD6qYiZfNuuPcMxukfw72ljJAM/Om8YqTFGCR7AkPLgcPV03uNl?=
 =?us-ascii?Q?0CwI3CsEl6ZOmkK/Fg7olz7shacnsdjXEA5iAEuSwBDcgN7TCsEqpweAkSQs?=
 =?us-ascii?Q?cREWsLHg8cqhrwVyX1/3cTZoUibnKjqhr+Dn0xBq+fK8Q/ECZzoatIyMwjLP?=
 =?us-ascii?Q?hUBy1n1z1p0l1UYMVeznNbLk7ZpOZaLPs5GqUKF7Jo3Gqt56vrbdA7UjZJQB?=
 =?us-ascii?Q?kyozOieGOqazPQETh4eRfeSMH5yn66+Ffgo/KSQ9LZUMADQ6uhiDhVzETFhd?=
 =?us-ascii?Q?ytRv7DJjB6YXasvw0ccoFsw0+ZSh6pEWpzPNVqVM8dL+LMo+W+SiAhbO25/R?=
 =?us-ascii?Q?hTHCmrbXAH3ugt8a+J7BxI3zP4Of8GzGkZuLmVc1AuR+7scgcA4ZQUWvHJ1l?=
 =?us-ascii?Q?mkrNCBFn8O0I6TC8zYDCZayqWUkbGhIh5bVa4GedpU2edHVlYHCcDSaGcskR?=
 =?us-ascii?Q?pyBFR6wlNz2/9sCQmNVro/VUjzdjvASoDmVb27ahLLy+8frUykURt4lTiDi3?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c527872a-a290-4f6b-1531-08dca211cdc3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 01:27:33.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xICOEVvmGLksnxT2Mnj8Wd5qOGfJ6f1W3iy6Z5Rl4aXSRb1JSxcW2Y5iDmHdo8mB4gdfdIEwH2YmD2d2tiJlf/ns/ZgfZtXc7OxPBIuP3nQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5270
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Adding an early check to detect platform specifics to (later) enable
> HPA address translation. The cxl_root structure is used to store that
> information.
> 
> Note: The platform check will be added later when enabling address
> translation.

It feels odd to have a flag at the root for this because the translation
is at the host-bridge level, right?

I was more thinking of a solution that does:

spa = cxld_hpa_to_spa(cxld);

...and then internal to that the code walks the port hierarchy from it's
host port to the host bridge. Then does something like

hb->hpa_to_spa(hb, hpa)

Where @hb is:

struct cxl_hb {
	struct cxl_port port;
	u64 (*hpa_to_spa)(struct cxl_hb *, u64);
}
