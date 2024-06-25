Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904285EE97;
	Tue, 25 Jun 2024 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719358893; cv=fail; b=bOLxDzkgS4kYGVuk+Q1KlEGffg//yw5Fb3tQzAR7pV5Qy3rLVreUZzOaoEY5Bz8/alM0CvZ9P0cXH9iZEg0k34+uE/WRsJ3Od5ufuVUa/HM+180Y8psmRAJ9eDkmghIVFvno1jjlvjQ2CHbkWR93ZmgVJIa+S1uvyMCCV9uu63o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719358893; c=relaxed/simple;
	bh=KUYCY297Ubmjteponce1VvTVtI/sdSAOrqf1iFOghHM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VnKhJYg+Oez+368B7ftkaqEa9eMHAJaTsvNreBIDQL84Ah4/LdUffNEyWD5Tj0HeY/VvMjBYsnCWOpuQCLYI7C8Dh5SeTC6PYpyksmyRm2cfUDom2YvV/o8xwmfBDuG3NxYyywzv+bMBvD3a1sHOdBm/3aFDe6EYwsXG2qQ/4VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LExx27kE; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LExx27kE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719358891; x=1750894891;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KUYCY297Ubmjteponce1VvTVtI/sdSAOrqf1iFOghHM=;
  b=LExx27kEP5pWT2FSPhX+CNw3VRRQuamKnfUHPbWMtprXb0jRPirQbP/v
   AsuSqnPMyXSqH3/F16pnGc0TEX5QpU5oHof0RRkUI0SQx0azoIf/SWcJ5
   IzHEgkE47GPor89AVrzWqu+Y1zT00rvRfaOO4+fKGy83IYdwegEFOABoD
   yIrSUAmULZHv+TfmK/jJsh3kfPMhXIZqIonOURFZggEvTkjEHVG8V3uSv
   5Cqe22bVSuP61qOvDYvzKQA5mU2PO5ELhxyI2crOEZl859roPrZJPIb1P
   CmB1Ma1TUEz1ZGoqdTzZhAPNkCfQJHQ37D4HBuwO2DzFna78/MoEzeYuT
   g==;
X-CSE-ConnectionGUID: taDnIs8OQrGEvTSVHaG7UQ==
X-CSE-MsgGUID: FAqsctNgQgiyB0qflWZKQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="38919436"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="38919436"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 16:41:30 -0700
X-CSE-ConnectionGUID: arOtSWchRtChY69oT3bJnQ==
X-CSE-MsgGUID: q6/PBvseTWCNaYIn2u0teA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="43879074"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 16:41:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 16:41:30 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 16:41:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 16:41:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 16:41:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJZvQJHyupxTp9xUJB5F88J6o7c0VllYtxKQRwFQk4NvOqORHv5OEhpZ1huTHRYBWq3NfdaN6xxMSw3uv/C9QNdYwPpNz0JZpcNENKXbJOkQh8PmWkz0aEm8bVf3ffbjuSUob5svZle0pGzj4HzZ+mDYdII7/GosKbtg77McMtXV6Y0u9HjwJ1vEGpS003ZK43PVZXmHzCq+mLNj9Kb1U84snzOIBcu0mXP8j3zZmGOEiCxtu3pepeNFLfsnLG8uee5BKMbJYdvydu6a5W/zVFuuofQfWK+n/eYXTD/75l5kGEz6YBQNoblHBoBWEnjJyxZE2sjXj3s5uoxb/Ae2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLhceIObIUW7voR6xBLudCK1SDTvUKjigXAyPGr4UEw=;
 b=Nm5IVShNSgABgLoUEBppXrvFkKbLVClK43y+n00Irt8m99Zi6gFnXmbOMnc4Fk/rop3hh3UsuNMWmqf8fkj/+3S1dLUWdBeLkILn+x+abu6fVVttQnVDZGoQveCdxuD9QjL0RSIl1ER2AvjciEtoPt68/w0wQ/zM2FN7GP5wqPDx/9oAuSfsQq33ZxQDyO3eOC/vkaIyPYvhAUhxjoUY2ZsLtTON5fWNtaGofoEj3H3vbWvnJJ7aFoEDz0ltBhFzAjklv8cunSrJ3GtS9TwAmt+TgZp+wxjXKoAoNzKYT1Y1eoXACNYVWfwCiUU3M4nhjSyAA2iyaqrc6JhZqTfQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8465.namprd11.prod.outlook.com (2603:10b6:610:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 23:41:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 23:41:26 +0000
Date: Tue, 25 Jun 2024 16:41:22 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Warn on unsupported platform config detection
Message-ID: <667b55a2865ab_5639294ef@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240619125949.167936-1-fabio.m.de.francesco@linux.intel.com>
 <ZnXpPGV57o7v4xYT@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZnXpPGV57o7v4xYT@aschofie-mobl2>
X-ClientProxiedBy: MW4PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:303:8f::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 57976085-8830-49dd-35da-08dc95705407
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YHuAuDeJKEfmFYYf3xxtOnEQjNWZ/YkIaaQTO5cYdltWv7Wqc+M0IUaQ861C?=
 =?us-ascii?Q?3qxI4MZ9xFJf8EqiRShdySI5vXrToh47r0C26X97ghAsO0obSiW8FrNaA/jM?=
 =?us-ascii?Q?r8Q6iQ5aS3WBT2Ua4hag/GaXgI1G+L08Zsw2Kc5nni4rSqpBZjM/zdFejKT1?=
 =?us-ascii?Q?3gzpA4hUZ2wmzWWvwuNWBld6G3MRSuGl9XDEtfhl6VsaYDx1ZOo+cnu9gcA3?=
 =?us-ascii?Q?/Z7bNn0mDQYNKsMMCutZq3x45D4uEpGrgjNT00c4Unmmid+skMjFY2vCs2WH?=
 =?us-ascii?Q?bL1Rh/v8EelglUrFLL3xsm2fdUb56VTIO4fJBjgB4EJKN2vGUCq3+azD6Cw8?=
 =?us-ascii?Q?YMFqx+jdEWZyrvZ8QE/zSO1D4BrBFXUCxpBJ90ToJ9k6RQ/LAwCKjMC21ysn?=
 =?us-ascii?Q?PFchK3WQa/itJRwgMq0kFvXpzGcXUQVConcPIEF5KR7Gv2a+L82EVlIcr/aH?=
 =?us-ascii?Q?thR0/o3yfmw7oxl4SzYxZK+zfktza2aUzv5mgajym63HY89pu+KmV159QxiY?=
 =?us-ascii?Q?8CkwzdQghpTRsmupvVFIc+GbnDGJ+cAFltMtrAVs2cN8hUPHE2nMZ0+whTF8?=
 =?us-ascii?Q?Wna06LFnuINKGO0/XlfBHnK5QpL+gJfx7TmaPKI6sFkb4WsrrVcx8Ta7447k?=
 =?us-ascii?Q?W2JhOmUOuArUbNiv5ZK3nCngQIElFswtTMHHvuwA3hwRD/Dq+Is9w33W2Lem?=
 =?us-ascii?Q?hzhuUEbF5Ekakhjm4INE3e5zFAhPofdVsshH4sRS2+RsXJx2FvJRn79XhfmG?=
 =?us-ascii?Q?/3kw6imtsYEB6mB58inTRZswtKIyzRbd/+NqgHcgXuPCIySpPNxjP62KkQR0?=
 =?us-ascii?Q?+lvocVWf4aS6Zn6F9yr2m6j4AOeqxaDUBHXXgde+hlbl7n/v2Ua75MBtfkSI?=
 =?us-ascii?Q?IfG6JU6Nm6nS1iYeXMm182rxbO8woQ3zSyZ6M8Xr5kofA8WzsQuX+HsFY9+S?=
 =?us-ascii?Q?7zpKtk4tZTeOTgwU07VZu65xW0kTYEY6z0McIEIL229Xp8G/+e1jNFd1Mkw4?=
 =?us-ascii?Q?96Pn048jVKkps9vtVGQ8ZlaPR54Pwa5Xtgo7HtiNiYL7D7XzqBCd0+BZ+eh6?=
 =?us-ascii?Q?59DjIud+6YhoLExmLpDPkegb364k2JaV4Y9mbA8YEQIyHZ0l1UqmBne2bxa5?=
 =?us-ascii?Q?WIpxz/3qjDp0g98qBVq/qKN1Y9jZC+G4apC6xMDzOaoCQ0gk2FkO7CUPcimh?=
 =?us-ascii?Q?iBwej385gmCYqNnZ+hm3jDllp+B1j9S7Y0CM/gSeL2Rh6zrMUusmrfMtKySQ?=
 =?us-ascii?Q?P3P9Z0hL/XdoGYUhx3OJpAFCHLrT5soH2qXRK5qqw8BrjtSZVcZq6nRpxcMC?=
 =?us-ascii?Q?+9JuIYyJsu36oR5Ins36YG7j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f+IasLmwlGejrB20SC8H4/Im2O5GKQWkN5G5TqlpwXlr5Q2EfEzEi4jYEp/9?=
 =?us-ascii?Q?b2yjOvazVU51mD3VjygCFwdyXu2aRevF1nSVEHcdpZfShbk63hbpWQRc6eAw?=
 =?us-ascii?Q?JIDvNpt+t519SgOdNn2Hh2QVWNc7q6XPP4FY60v/s+k/t3pNYFXulvWvI1i2?=
 =?us-ascii?Q?4iFHzfC4kgboSBfjSDn/U/ZQXz1F4AXHBUvLpt75xuXE/fVNObfNHRr6X6yr?=
 =?us-ascii?Q?rfq+zpJGL18GMpx/TkV5mApHHOjCtrE4EVE7PczFEpRMMh2TKP0C/9QwTQYX?=
 =?us-ascii?Q?b9yyAa/Py8APXi2MeKBqdq3buxZc3mf/zGs+wyTjHqsi+DC/azfOp6xpcE+n?=
 =?us-ascii?Q?G6FHy3Tw+iiLCk+ZLim0CvOlLDGzYqmmpjsf/Pk/7kj618VLEqchL720SXkU?=
 =?us-ascii?Q?E2kpJiPqY/cKkAUKY9gV28PhLwwkcit7CeaV9TaXXUsuUsi+xUp8AYKIwsE8?=
 =?us-ascii?Q?BiFEZKnn5LV+qz1qEysrC7B0Tz/wla7xVdoF5J5WWcU2uIMdz3M2jFfqrVos?=
 =?us-ascii?Q?s4QmBgYDY0T61z3GQNiW+KbNc3koeq9hA/vu5nGkvtHX+G+W7iszttEn3vMQ?=
 =?us-ascii?Q?csiCWNgr2VdKjk2r/GHYp767ifzY5TKD52CShay6N78IYrM+iJJdtahYl5TH?=
 =?us-ascii?Q?0pErt4mvslClQ5Jxjpyq6M/CjJNoOmFrcVyxXkQCsbo3fIOSqd49FD6oUkYK?=
 =?us-ascii?Q?kxGbpx+5mdxmv8rP+7gjiV21KlwzsOyIpE5UueEwrQoaAiTALYwMPBmxHit7?=
 =?us-ascii?Q?k4Djv0JQuCuz7KqNElNVCOJVwyA0ESr42R5rMUE5PonlIKpg7IpGDlOEQAuE?=
 =?us-ascii?Q?w+ovX45LPrG76Xccn+iq4BQTWaYlNL+XGAIvx3d7CnJ/vNjWDFfgsXoyVRl5?=
 =?us-ascii?Q?w+TC9lTOqikLsSTOGObi7f5vMKpo3c6puo8U2TtAMZzknjqY8hdwzBcauJNT?=
 =?us-ascii?Q?8xsnnfOQacS/HMh3ZyPBtbUycdxJY7fPuoiMKZVazGQ4lIIg/rDxnuVMnrSn?=
 =?us-ascii?Q?jmswXEYPuJw9pSWrgvgKFJem3OIIh7QQ3FhWOWcBEmS/J4zrNAYqvnBiwQek?=
 =?us-ascii?Q?Jm73SFT78vA1Tbi2hRxLC1bPWUwNy+Rq2KEDdbtfWyuZBpjkkgBGQFELQBYU?=
 =?us-ascii?Q?3XCwegG9H3sb1LQIWyxPe42blknvgyrAbUFGhAH8Ab6M6d6jNEPmPoANiaRe?=
 =?us-ascii?Q?n0vjHLKoWZIPw9WlK/IzchiwxG2KVYpOlI08GXK8l5yGAOteoKA8aTAadYpZ?=
 =?us-ascii?Q?LHjKGfV4luasq059vnRB9GR8FWg++KF7gFxD1V7KJLWSpgmbvs8chaAbGIoA?=
 =?us-ascii?Q?8/YlcP7KoUdmKEfEWjC4th7NiW5uOJaldsDxSCqRHyXG8g6L8aAO9B29tbhH?=
 =?us-ascii?Q?YFHd8cy9Okdjz/LxrEQxCNtn8J2E+K/AJ1FpoG33SzyK1163MvlfjhMFBACT?=
 =?us-ascii?Q?KugjPWihhD4mT4bR1d4L3VL4KGzqRIR5JDGHoRjb4piGFHn+ULBUKJNU9+Km?=
 =?us-ascii?Q?bGASrqZ/ZKuEd2dh6LpFoZU7oIVHeVOw7cl+4VHjxfkAuXTJ8bdlQnjWsWSX?=
 =?us-ascii?Q?2MlQos6Oqx65l6MUZGZQFducSPZC1DVYFUq/+tjcGFjbJ8x2DDqZw7V/Ouc2?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57976085-8830-49dd-35da-08dc95705407
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 23:41:25.9508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sagnkVzTUnVPqcKqBG4+eAV+DOznL4K9jPyTkpVwvQ/gzf/3ki83IiiyrObFCGXXvDaOt6spv4eMmIoWYeeQH4rCx60RKM8UOmyUWklRKpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8465
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Wed, Jun 19, 2024 at 02:59:41PM +0200, Fabio M. De Francesco wrote:
> 
> Hi Fabio,
> You've written such a detailed commit msg, that it pulls me in,
> and now I want to understand more....
> 
> 
> > Each Host Bridge instance has a corresponding CXL Host Bridge Structure
> > (CHBS) ACPI table that identifies its capabilities. CHBS tables can be
> > two types: RCRB and CHBCR.
> 
> Is there a spec reference for this?
> While you're spelling things out, please expand RCRB and CHBCR
> 
> > 
> > If a Host Bridge is attached to a device that is operating in Restricted
> > CXL Device Mode (RCD), BIOS publishes an RCRB with the base address of
> > registers that describe its capabilities.
> > 
> > However, the new (CXL 2.0+) Component registers (e.g., Extended Security
> > Capability), can only be accessed by means of a base address published
> > with a CHBCR.
> > 
> > An algorithm to locate a CHBCR associated with an RCRB would be too
> > invasive to land without some concrete motivation.
> > 
> > Therefore, just print a message to inform of unsupported config.
> > 
> 
> 
> Were users seeing this and confused by this silent failure?
> What did it look like before?

This is a "by inspection" realization that the CXL specification
currently does not define a mechanism for finding CXL-2.0-only root-port
component regsiters like HDM decoders and Extended Security capability.
Rather than go through a fire drill of clarifying how that is supposed
to work, just the known conflict for now.

When / if someone actually shows up with an eRCD (a device that forces
the host-bridge into CXL 1.1 Restricted CXL Host mode) then we can
consider if Linux needs to do the work to support that. To my knowledge
all of the commercial devices on the market are so-called "CXL 1.1+"
which support training in VH (CXL Virtual Host) mode when attached to a
CXL 2.0 host. So, Linux can likely live with disclaiming "eRCD attached
to a VH host support" for the foreseeable future.
