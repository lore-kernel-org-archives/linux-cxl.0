Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF75D2FE;
	Wed, 26 Jun 2024 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719362722; cv=fail; b=RpcDb6vQVZwTS27Ll9ye3d2fXCMKUYq32VL1R4kLa4x/Jjue6ahidZziiYJDJPqWTD8HVGhjgD0TCeEhjd4e7hehOOS4w9bL65dqeogNc54OfDe9yQrfys9kfx3+Kg0kIe6GO5lbLrWLqiejDgoKgGGSX8Zb+9EcuTIwlrg8QAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719362722; c=relaxed/simple;
	bh=YnLhjZB5cwCDWIaS8szisxtdRHj4lWrW1DhDcs+VTq4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g5NWbH2isxYgymBVm2416zuyDwuLJVaFFlk4w4UB056LkjcLvM8y0HSXgly9yTLEXyA/XbyIyP+t3fJBDB0WxMqbvrG443DCuNJZYJlTD8Z1sYTmJg88ul+oLyD56GRRvmVn6nakwHCe/x0SK91aNDNOTOP6CCQlGmrfoIMQCzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8HER5u0; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8HER5u0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719362720; x=1750898720;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YnLhjZB5cwCDWIaS8szisxtdRHj4lWrW1DhDcs+VTq4=;
  b=e8HER5u02EDjdTt9yAfWr5EKn7eKGu4HB/eu5Pty0BIjvagmm34Yt+jV
   ll+GsyF/oZznl2p2+HvdnTZaGlbqUskxI4d2+9B7BwoBycX6sSBfT/hi6
   TzSBpLRYrrdWGpr5vMKiGGftuto3J7NAOUbektzS/pnQK3dd7sSa12v+o
   m8PKxbjsx2AQEZHKm8LiAQJmgxx3vypojUWA5opT80Cpl01NE6jWB6Wsj
   8Tm0fBH4sgXTJsliHfFhGmK7+tD+YbychK7EmvUmTMoFiZwJxCPnkncNf
   jMOpO0+2CiUUk9/dh4Bgmq4o6raibxuzB/kzF7iuS/EgpMryWzWU66wW8
   w==;
X-CSE-ConnectionGUID: r/56U3YfR2Cef+c9+m5ulA==
X-CSE-MsgGUID: 7jRZt2gWRYe96TDrbN894w==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16093220"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="16093220"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 17:45:19 -0700
X-CSE-ConnectionGUID: HyOLFC6vQP+9PKv16TneRw==
X-CSE-MsgGUID: qKMQF0YAT1O5P80xmSLC5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="48274912"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 17:45:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 17:45:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 17:45:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 17:45:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bK9KihfUs8FMGdiZSg3ZZEtINQZKiDfMvg+Ty8B/x68Yu1sDc7e2vldsLyf5z5FoXjDk2Zmwm91efGu+sM1oqJhkE+KhfbwwYnqb2tEfBL7p/TvM7bGCFEq0x0ZtXOY2zifU12ZOKoGUp+hRUkr6o3imepxzVIh2nZmkp9bDZuo3WDiwo9KTf9cO6HgiX+1q6yXoWoeq8Q3dsnsCB4LDlgGEGAHcjEu/N1ZOqAH9tZ1kWvS+1jTUHG4Wnk+rfqR64vLpz5r7uOq5qjwnrbIympmJocCizcbUVMArElKN69ZmIkb7qh/hjTXui9aDrffkQZGtm5i499bNRdt9o6Qrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tCC5/KlEecDoIgIEdppGdwM5u1RPOGzGOTl1dpkuNo=;
 b=TDdpgja17gwtfWFz1FAE4Y+79k8oJ+7UikTUonuTjuMAUQgrbtScUPg/AuaCJ8LjoqhaJzze6g5B0PaK5YEd/1lbEKdCjkDKlOcv/KHIq8tx8eG4gXwyTlTeZmaSVcn+CUvx2GGgcCblFl1yVVITVhhwGyDrdOl73VgFiitlKdmqjZdjc3xtWkApZDcUxOAOUdnXWb0xysIyDPK51sYzbV8b6QTzbEPm+P1syuH/bZO+7MUlsuHUXqgUZ8isC1+8XpxbkdUpnnp2VOL6/L/t5Md2XHvt4InSu7D3S2QgFqauAaKCnV1sXA+/b6svHh31aNkRLZEf5KdDfZs8dYsKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5783.namprd11.prod.outlook.com (2603:10b6:510:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 00:45:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 00:45:17 +0000
Date: Tue, 25 Jun 2024 17:45:14 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Warn on unsupported platform config detection
Message-ID: <667b649a3a2d_5639294a3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240619125949.167936-1-fabio.m.de.francesco@linux.intel.com>
 <ZntcWQ7pMtOpuT4a@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZntcWQ7pMtOpuT4a@aschofie-mobl2>
X-ClientProxiedBy: MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 0745253f-f8ae-4424-7e20-08dc95793f86
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7co5K7AEZXn/kW3nlUz46VBg5xpXPYMUQch4+nHlxcFD10JoRNYoidpa67B+?=
 =?us-ascii?Q?YZTG029zEUC0VTOnUMjDr7S4Tj8NBqZMYF7/G3QZE7G7/cLp+GIeUcj+/NPb?=
 =?us-ascii?Q?V0Xz38I5dAcrz2cPjC5I9prpOGRMn0kbIozgChr3riUyVegsHex7AweXPXo9?=
 =?us-ascii?Q?jHkFaVhlSWWLcCBXBxsdPJvRTnX82KnB20Ru0pSy2eFbSycWJqrgUx9d2cfp?=
 =?us-ascii?Q?hJfTP5fGMxKCney7ewEbV0DVEYQHrIEJSOkRXcDiPj7eGPzTVxn3uCdHGHO1?=
 =?us-ascii?Q?QAIgwegXOuFQLNJuuQN1MNF3a4AIh+CNwO1zMPh+HBVrU0/aW2PBXMNmyHxi?=
 =?us-ascii?Q?6SAnjRXZvFHd+O0zAA5tSvG8bWmIEhzGuKHJd0bKrBHI//AnneTUPcrt539H?=
 =?us-ascii?Q?wfoVqEE5hK0ALuON/yTBrKNEd2IHhC8XveqCobYkM+8sLnSHT3vtTL9A+UQi?=
 =?us-ascii?Q?H1q8fo4qerfKnW9U1hB+ksiqp3Bkz4bewnha1O0X8rqM3aMnTR1Hp8POQ2+y?=
 =?us-ascii?Q?ZjVZN/eTjmBKsN2x9yeZD9ja+eo/GiwRmbbp4dxXctInrUlZQqroDRtMTsSO?=
 =?us-ascii?Q?gHG1tYO4F4+wIovuC2S9agJbokPus5ZfFYGQfb7D5KjmAs0KelXxn2OTL8Lw?=
 =?us-ascii?Q?Ti/35RDVELrPu977QXA6rXSU6sGNBf71jsLX3L/bfanWX9VjzGgBLlhzA43/?=
 =?us-ascii?Q?+yB4HT++qBFtRbL38hbGk0NWRgLbeFdm+sZyQpGSiB5fFLI9297M1lt/WUQQ?=
 =?us-ascii?Q?SXzYgfAAI4ergRUBKhO6UWLYzchOmJ8P4fj5gaT3J2PBpA/FLHL0GmLMttJ9?=
 =?us-ascii?Q?Z/KL0qYpcVdSdX/kAYkCmFjVTe+2I3gnjOVHXGMBYivnQk2J0WHd4k7ostVa?=
 =?us-ascii?Q?2fi2ntHaO7owRigy6q210lYytCQCzS7zAiYW/dpSNQOCfiQDmuM4OrT+9Ymf?=
 =?us-ascii?Q?ebvscXBM+5/sSaCOHoJwnFENhBPRclJJbI4NWJdi/FSSBj0LIeWW878ac8DB?=
 =?us-ascii?Q?EycvOrDi+P0VBmupqXIq3hNB5rvu3dUFavjFAlmSXq7agtvfcKqmp6rPTl6a?=
 =?us-ascii?Q?7QHW5D+DXE0DssjHQ15RwjllkmJOqW3KWDO13Fqfn5wqyNbyxlqHYBbUFLzI?=
 =?us-ascii?Q?vd2EAQ7F24/tqKmqHxKeQ2HkUxOqTJz3CULwGxg34phxvtE7+z6cVsWJNa2Q?=
 =?us-ascii?Q?fxnEQNof9Vgx/M9i/X9LziGDvNwstGec6U9yCresNpnULMhqaFWUvVvzKSEZ?=
 =?us-ascii?Q?AMdijHPI2WOVEIw8qnKNK6I1O/ceriekxoc4cSlBreuRStzD0Z8YRWAnirvA?=
 =?us-ascii?Q?+cAoIsq9ifWqqCWwRwc+xBHX1jC+2ah6ptK8cmsnQS2kdg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ao3VmyiPg2oauES6XSG4OZJn0TKh0EBHLQ0iatvWd4NpEKlMg0m5zEXOJd1E?=
 =?us-ascii?Q?jsg0NlHzAtbdK3w3f3sNesV2RTSMP1PH/5D0wHMUmTtSvQI5u5hlxqqtXCVB?=
 =?us-ascii?Q?H/65GyhY0luajMnTskWMdn47yvVYt4sbearetD0HRET2S0ebtPr2vt3NiuLR?=
 =?us-ascii?Q?1UzBOlrNYYDyNkYLaJnHFpEldeclcetK5Mdbz5m3NryB7JLYNMsi2NTA/7L8?=
 =?us-ascii?Q?I+q25TEfzEZiYE7Hd3tjix3DmGnRylQJ5edy8XkvE16X11cFtEk6yAipqk2/?=
 =?us-ascii?Q?6JydKBxFEsZlY5cudyXCooF1i91In5Oa7VdObO3dAt+mv1AoZUSvpk2myQom?=
 =?us-ascii?Q?YrBSotyKIBOUBEgex0vI+GaSR5E8qvLO2v13H23fCVsIjYVvLlgH4jzsclW4?=
 =?us-ascii?Q?XHGpoeLA2Q2Eg69bk4GNucsm2KNNYyEL1TvaoQRBVKCPeFfNtBNYDyx1CxmI?=
 =?us-ascii?Q?x5KPAtd0RvPbdkCerz7ofkbasOuBwuBI23TNFJ0TiObBelGkWEEYK67p5Chk?=
 =?us-ascii?Q?DtpglAH32LfwK/KBeapbMzpgj4JH/75eezu6MNwBP3yP3kBlc2bxlJptz3lG?=
 =?us-ascii?Q?1TK3mCpRH7OfOQOnRPzPC1Qvlwemi01D/HPGdcvSCqJVR/LAtQX0TOSq6z9x?=
 =?us-ascii?Q?25Vl5l67scTtFpQCEY+d5YYZvLV8hORvvgeyKnRR88wfmfvx0lGlspx8tokH?=
 =?us-ascii?Q?57lYKKJGHyJsgQ5qUqG5mkuhOu6XPeTMlOI8G8bWON/rFCCJnmeTUosk5wEg?=
 =?us-ascii?Q?3UsYHFYDorfMOrcOsnd9rgHQGYkNgSHFKQEQoteKmKITNerQ2qq/aWmfHT4t?=
 =?us-ascii?Q?SZAC5UwLI89+KK/Jw3dU2g4MuptL/Btg1q4I3G90z8H/GNhMSEum5OzxaJzn?=
 =?us-ascii?Q?F4XSo93zDntzw+JWm+NkwXOtrZX9XDa+cuUfEoIdspmslBvaQEmEfKHARYZM?=
 =?us-ascii?Q?U3u5V4twWcDls6z/mUG8X7ckOuhrJNpqEeReKTS6qCUZhgYqhhHwidGKFyjx?=
 =?us-ascii?Q?MIFhDmEpWi1Pb47ptkSj1MlZrx6758U++XgDePwMjYXFfg4UtSoFXzKtVQAV?=
 =?us-ascii?Q?GwNacXSPbBTHU9k49HtM3g8nbIRz05kfjesGkLfC0Kjv8nvTyopa7sNMURUv?=
 =?us-ascii?Q?sjk1sMvc5elQBPNXwhgJJTLjL7KEW7r4KziXxs4d9vX3VfHG6ChhIcgO+vW+?=
 =?us-ascii?Q?sojpjaa51U/+jQfKSm2yw0+n0p+bXSu6TOByUV3G52c/yjACwdf2m6WzjpvH?=
 =?us-ascii?Q?K+vo8wRZNz35V0JK+QtuvO8UZjpZw3wLOhpk2e9oCiFdbHGyojoJsJUHUGE7?=
 =?us-ascii?Q?8Zo7bkjL+71/tVyDNchBJFlX1l1el1nStLJGOGLBNXwVWCu8Y8og3SpEaLgW?=
 =?us-ascii?Q?G8Vhv8B7QRrfLeEhzZIKy3sRJTURyTGavn5xuttbtrIvGOr1q58adNV1g6QG?=
 =?us-ascii?Q?OyEIn1rtqEQNCx5xE+1xW92VGh3jtngONwpx2nzBjdfhBigd7OkLIISW61ep?=
 =?us-ascii?Q?EtmbDBZ/r6zWaKwoV9ZRs0WAGzlSOgeMnb/rymGEIbrLlOyNjpcgMhaTZyg4?=
 =?us-ascii?Q?rNKgIPFwpecEEAAshG8DU7VHk3hGJp+rkEy9ru+R40DB6pq5uNJOXGID6LJL?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0745253f-f8ae-4424-7e20-08dc95793f86
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 00:45:17.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTV7CFpuRI5PuXgkirECxta571etD0NQk54sdRsnlNodpIKyEwP/Xylo4zpSNGbH00H1B4ftN7V9J1LtmFX+yr5529nmmqKkYW6IwHf7PcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5783
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Wed, Jun 19, 2024 at 02:59:41PM +0200, Fabio M. De Francesco wrote:
> 
> Fabio,
> 
> cxl/acpi does a lot of platform config work. "...unsupported platform
> config detection" gives no hint that this is about CHBS's or an eRCD.
> Please offer something more specific. Thanks.

The message specifies "mixed Virtual Host and Restricted CXL Host
hierarchy" as the conflict. The relationship between RCH and eRCDs is an
exercise for the reader, and CHBS is an ACPI detail that really should
not be emitted in an error message. So I am struggling to imagine what a
more specific error message would be without paragraphs of backstory.

All that is needed here is just enough words for when someone posts a
problem to the list that someone savvy can go "ah, you fell into this
specification hole where CXL 2.0 root port registers are difficult to
associate with an RCH config, thanks for the report now we know that
Linux needs to worry about this case".
