Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624AF2BDC16;
	Tue, 16 Dec 2025 05:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765862529; cv=fail; b=FPejNjaVIYRuPdmDYXBTWOkaBQRliQ441+rkpVgoVZT2SrRVhZ+Nx7xRjgebglUdeqdqEM9CvYJLh8J9zOaGAg6horxSX5bDhrsL7ictAJ5sIFOGmQEX4vr5OW8Q9O1U3UKKb0pz3GDC45eCbFX6ohLMOQ8NWUF3whBq0RrnYb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765862529; c=relaxed/simple;
	bh=3XbzMLnSXpzFCsmObnO3SD8ranLduwhrFF5YeYFkDyI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l1TeLBtfNsUBreKnHHXpp7nhu2LFvrz6Q9asCnLF0rT4B5AMY5ip0m3rcBXp6LuScsfRm4+5cKJHhFyOxxxLmtzrRVWFwdlzjUnoIVUJY0tt9jy9G019UvSWJQlGBqjrbiu5A0QgEqC3V/m282ggHwDMdHy9Tfv7StF8KwmFJ68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOJ/pwul; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOJ/pwul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765862521; x=1797398521;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3XbzMLnSXpzFCsmObnO3SD8ranLduwhrFF5YeYFkDyI=;
  b=fOJ/pwult6cLnZpwQu05AupEDc36y9qSEnaARA4NpWml0E0vQGEs+q+m
   LALxmWO4KlKvEkGy2pIyJ3NEZicAUO8uhD6wgAyf1hMKpVs+nFtoqBDE7
   Qx9V7BXrpL5liGeINAnZnsY7Od+eHRuqSqZSjyBPkC+vZMVdgWIGLw/8+
   M+zGhQijdJQQ0XU1JO64mLtTy8sAV2EET1Ev7d1hdKNc9a+AvSUSokmvh
   I/dvhwX3C7NFOIz0MlCaB3HSVylHggtz8wPZnSMSw8qkochDs3TUkH0iw
   sxspPjAVv+KRCKptyEa9S47N6e0UCWFCsinEUaze4GXh+9CJPNw4I4jAk
   Q==;
X-CSE-ConnectionGUID: oA78VQ/2RQ6z1VtgFMUl2w==
X-CSE-MsgGUID: +yb4U1Y/RxSjiyl6VhdYWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="66761763"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="66761763"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 21:21:55 -0800
X-CSE-ConnectionGUID: 3+5GKN84RTaqexKUEmGnuw==
X-CSE-MsgGUID: avjcYuZ3RjSBlbFDKrkt/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="197971186"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 21:21:55 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 21:21:54 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 21:21:54 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 21:21:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzKK6ISRK2q5/EOzpgW552OGe8h7Aon9V8C8RFvlESeqWCodj+Ov+HSdZqcMDlD+Tvumxq7/5VnkfCNfph6/btpUPvYLoJcxh5gYZC6EcmcivttOD+cruP4Ntno+8RjPtNzX91dvGwck0tEwZv+42wkInUSaswp+9MUNiK+BDQRG3jEvn/qDIGatFpj5iioUelRaqnpqUK9ZPdbkmejEBOk4J94+GnU4e59XxiB978d3O/isy+iaVA7xiadZNxWXUPC9eiodpzWNymw3uohbaRyYJUFq9/PeMjnYu1yMjjvaQqlJNthsfNFB4Vmzz0bDgnz09Rfq7NIR906PreFEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bN3PSqGnuT+2FEH3SNUOev+M3JfajnPmQlz5yF4uZGg=;
 b=uPu7qcHYvCKJO4GrZW4be4/wAvRZ4wil6JeoFwtRq10VFr1ygnomz+GotiT1eZtMNafErtgV8NpRyfUWFSh+pfe28Gy0QWDw+Vby2fAkTiEYuHxGsEml2uxjaXhai/SDP6s7FwLAbynnuiAk2hpSdP6oKtkFFMhMzLYV/mVD4tvZmhC7zi2qWoO1kFURDilLrLFRnP7b54OLWFP/8e0xeA8lyIC4NbR987r3llDAoiWXDeyteapf4w982ntPvxrKx3Te9T+zSmdyiIm1ig1Hxzy8C0FUyU+dkMhRCJjC+u63jnFbNXcw/U5nXmmKrRba52eo5Zqpxo78bcBNEwbYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB6989.namprd11.prod.outlook.com (2603:10b6:806:2be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 05:21:52 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 05:21:52 +0000
Date: Mon, 15 Dec 2025 21:21:48 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v8 13/13] cxl: Disable HPA/SPA translation handlers for
 Normalized addressing
Message-ID: <aUDsbCutp0JPD4UX@aschofie-mobl2.lan>
References: <20251209180659.208842-1-rrichter@amd.com>
 <20251209180659.208842-14-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251209180659.208842-14-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5795cb-8000-4741-45ae-08de3c630533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?INoFUaz1GFxQUMyDo4xqO32xJvz1PmKaOpu13XRpLeseMk0n2DVAj8D06Mbm?=
 =?us-ascii?Q?sNs5V0UAL3UUaSHt7ty4qWPfPMlTDmcJF2Hd2/FNkPRDzZp8tC2jlp/wiw6v?=
 =?us-ascii?Q?yJtUDli69F56yJMrDeMurgZjZEjqCVHykrN50quia26MYjTR7lTKgs4sEJ7I?=
 =?us-ascii?Q?RcQm2zNirtcjMCucd8wfNoE1z4gRLTlrWiSG9FEY8qV84YOLPIb+H8ZiOx+K?=
 =?us-ascii?Q?yrkeOMzAYKDjWxAeQoT8lZQ+/DvgG12gM1Qk8+1Jh/ILW1nB0SPN2jJ3CDan?=
 =?us-ascii?Q?15LE6weDmV9EX+liBVkcl+3uuOyq3v5vYYk+SAS9V7fLKWqUetYX+7vz3EA6?=
 =?us-ascii?Q?PjsODsYs983WNjR6Q8eDmsom2rhZ/mbNm++j0i/hNvER6hyCytzXcQP/86t2?=
 =?us-ascii?Q?HFA3q9RM6Kg11TlEguDJSobCwUDVh8KzzyZ4ACv7ymsOPP8/AxaQ5u0cxLSF?=
 =?us-ascii?Q?K2L8I+1WGXAqAed8kpslY/2L5Bi3h2mwRIevfNVDsL6h8JEKXQselx+rlhFK?=
 =?us-ascii?Q?PP2iy3ARRMcxH06cmCverQeSGn/1yoME3pJ9LZnaxNhhVyNCqGSiU5+UDDuU?=
 =?us-ascii?Q?qNJ9qwOE6xknG+RFHyblOnI1/xxBl0Nj0GMMjwWAHVzHAi2F5WHxF8tBVYJp?=
 =?us-ascii?Q?tD66vO8kDGUTP/wB0V7lMQcN5zrZEHM3EdGOzfj/yvHCCvbvos18fySXRlIP?=
 =?us-ascii?Q?r1i8wcZ7T20wOUaSODvcxSo28KLUjORXSOtFygmdiMEIS8JY1gOQsW9Mstv4?=
 =?us-ascii?Q?vpsoqPttAnLxgQOdh/DmfyIH0CblUJ8rhuJY0/HgVK1EfhisJSiYT76Zzgun?=
 =?us-ascii?Q?wspbifoMK73cVJHOP/IFTqZ1+w+oLU95u58IiCoIAziTJfYAwQrxm5DgDL+A?=
 =?us-ascii?Q?BaR4cNw0gpad/U79Odf7NQgvWHg3DgozdAvZCR89LMz3zuLQ/4FbSK7jqLKn?=
 =?us-ascii?Q?+ZWSz+TxImrjB/W78cwUdjQ5uqyz8XWDvPLP8kqNs8bwwU6I0TIs35pip61Q?=
 =?us-ascii?Q?r4sIvx0X7rZZ077DWGUnMmruncrdo3p+JmFodFXiT8DGFIoZ37xWNAYUm7nP?=
 =?us-ascii?Q?RkDKemRQwcL4FPzUSJ+3qotfXUxoULhLDv/SENIaHr69teDSl+PY62xJkG3J?=
 =?us-ascii?Q?XTmOrntLfQ3q0LyQwwgMwF5IErLrP/Kjnle2TY1RJnjqsLwNtC20DohSSd2K?=
 =?us-ascii?Q?UNkFddK09KoDXTzqr4Al20jsnCb/00EwgrTk4P2/7JM/OyFKHidMGRJns6BT?=
 =?us-ascii?Q?piQewEI5gl/HXgK7F/iyeJdcK3RaZB/he1OHmnic1bIO5RIqPJnLUV/VzOLC?=
 =?us-ascii?Q?rSD7zJSvzrM6G675N9nUduzXMrEbIrHljQ9K06zwydIL+oGWZ7iaFAFNId21?=
 =?us-ascii?Q?8BM6Oe0EuRVymzPLi1rbu07PQ22mLAL7xrEAr6sLjssjsYZpEeCr/W5xWZy6?=
 =?us-ascii?Q?GKEvxyVOBnO3IHzYY3xTJzu/4bECE/6P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jCkPmXjEFsPKouvS9hxfVKFzhNxZnnqwnsrE65INAGra/49PaRtKLJPSXi/T?=
 =?us-ascii?Q?ZIVzEDaF0Gm7G43urBb8mYbRw+2htRAV220UsDC9tvTC20vONuaKmuV3f/DX?=
 =?us-ascii?Q?j3rx20ZAQwp6+aqFvwZvygq0S87G9BQGZ7VQTtTH/sTaS+NUsgGQdoYsXGaW?=
 =?us-ascii?Q?IYii2y88pkitPbsB2KZvoTYZPKj7mkJhDymvPp1pKMVCm3tIXUn5wRUNoDqE?=
 =?us-ascii?Q?3orjPD4O20kFkne6ey+5r6WUGFXNgmWFsZy5ZThMbfZMas1S+nRd8NLClugI?=
 =?us-ascii?Q?8jgjF7OPstu88NTHlGa4I25KVGToymB/XD4k2DpefTwJWKYspuzr4SGjw6Yd?=
 =?us-ascii?Q?wtcVeSGTj8y7gxiLC27WLiHEqDkEf7v06xCtG8xfAgzeXnrj968ZyQqk+m5L?=
 =?us-ascii?Q?uff/ay+dqXkgzu+5BsIbtHMnaCgvrIVWItdf9PxVAr1I37tp74qtZhfRUTlf?=
 =?us-ascii?Q?AY7dftbqmDXCbV22TBBIs9HbeHzqFW0z+a2mOE6ErWBfvB8yXnnOUx7npOSk?=
 =?us-ascii?Q?xKUfsLm2dG71xeiZtNK5+SnOED2YraG6qtbgAO+C+wp8hl3PljyEkR+uCriI?=
 =?us-ascii?Q?QOHwkobJvEB8xHURJXmQgrPQSyqjxmdOnKORZO9eunvMKY3osOFxPXOmD7+V?=
 =?us-ascii?Q?LYr6RHChr/QCuyVnlQbmcLDkHgtazy7y+7N4uqF7MpN78CYbJC+2pP6vEPGi?=
 =?us-ascii?Q?WuDR/gxnSMti5WvoYIY1ZWGsLmC7ntlWG78i0jh088HI1p7tl/kJgrvYpnr7?=
 =?us-ascii?Q?CjjtqDAUl0Mogu9mPz4J6wof9VFrqM4d2dQ3H4NNOUeP8gyXDGXb7tGiTQcf?=
 =?us-ascii?Q?/cUkpIbhnF+9BetvZNCyI9NhRqgWxW+7rGeCuxUXM6FydGLDkeF67I8b+E1O?=
 =?us-ascii?Q?vYumiDC4fSJ3RW3w69q0MH4WMmMxHxh9qqd+vp1z9a+XB+gSpnYW00e/Smqo?=
 =?us-ascii?Q?2/ZYjv/tjsrnmTYMt7WVi4hmu3dheF+GkzP0fkbZ6XfMWCZzYusMbumGsiM8?=
 =?us-ascii?Q?oUCkrG/y+yWEW5HjQwhBVyG3nm//RdAh4HbeYaRONjpyBBdIxYYeVzWNh0p1?=
 =?us-ascii?Q?30TuHZsgnuaxnhwzTDeCeAxEcvODYPM75Qs5F262Vp1jJt0IZ7A9FBS8ilEo?=
 =?us-ascii?Q?k0Zri0XDdBbWCF28Qlnm2IB73FelEQiKkBZAE/Qne7oYW50Ura0HlFMr2Gg1?=
 =?us-ascii?Q?pPLbXKlS7vu/RB2n375UxB8djp+/k4co4MMzjkFS5hYop216CYs0fFwkDTFM?=
 =?us-ascii?Q?R2LVv3P+a9JQMYW0xoxrJelTESPidTADwAfZzCUOZKmJ36y8MuSYSJeRJFuR?=
 =?us-ascii?Q?tpuC1ERC4VyezV0MNltqe0Cfzy/qivFJ3BYHrwaozjWXrr0rdwGYb0YBHSYe?=
 =?us-ascii?Q?kWOcrF13HOpqU2nB7dc76FMLBwsjKGsbj0E+WnFJjggxy5USjj33i616l2b8?=
 =?us-ascii?Q?1RcfQdUx4PfPcMysQ14YdiSUsa8k9RGkfkHFEOMKYqJg3Wl+i1H763o+I2Ac?=
 =?us-ascii?Q?OzPwtt6v/f579CT+kzpmgakLf1iR54lHfzcQNZSe9JiVhiSJf/20pEYi9Qz8?=
 =?us-ascii?Q?ybCX8ZXOqINaHbnlehSKlcnh8RlN2AIbGkyYOP+gqmfHm7K/NUchtH6JZb1f?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5795cb-8000-4741-45ae-08de3c630533
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 05:21:52.1725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Co1hOkuTMSIn43fggb44/nKMGhA3OKrL1OGZ7/GSYJ9l7BhLPxxpQZCBi0XPA6pRUY/mdh+ObMGoeutEriue+QYAVpGjo/17DC7O2HB14Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6989
X-OriginatorOrg: intel.com

On Tue, Dec 09, 2025 at 07:06:49PM +0100, Robert Richter wrote:
> The root decoder implements callbacks hpa_to_spa and spa_to_hpa to
> perform Host Physical Address (HPA) and System Physical Address
> translations respectively. The callbacks are needed in cases where HPA
> != SPA to convert addresses for tracing and error handling and to
> setup Poison injection. Currently this is used for XOR interleaving.
> 
> In AMD Zen5 systems with Normalized addressing, the addresses of
> endpoints are not SPA and those callbacks need to be implemented.
> 
> Now, as ACPI PRM translation could be expensive in tracing or error
> handling code paths, do not yet enable this direction of translation
> (hpa_to_spa) to avoid its intensive use. Instead, mark the HPA invalid
> and return an error for this case.
> 
> The spa_to_hpa callback will be used in region_offset_to_dpa_result()
> to determine the endpoint by the position in the interleaving
> chunk. With Normalized addressing, the order of endpoints in the
> interleaving chunk is implementation defined. Do not use this approach
> and and return an error instead.
> 
> Disable both HPA/SPA translation handlers for Normalized addressing by
> returning an error (ULLONG_MAX).


Hi Robert,

I did suggest failing gracefully, like you implement here, but now it
feels like we are 'weaseling our way'[1] out of something.

We can shut these features down at a higher level rather than tiptoeing
through their implementation and adding a clever exit point.

This struck me in the changes to cxl_dpa_to_hpa() work because I suspect
the work that even gets us from a DPA to a CXL_HPA is not accurate for
Zen5, and so we're being wasteful going through the motions of DPA to HPA
only to know we are going to throw it all away at the end in an HPA->SPA
callback. And then for the region_offset_to_dpa_result() it seems silly to
even offer the inject poison by region offset option if we intend to fail
it every time.

Please consider this -

SPA->HPA:
region_offset_to_dpa_result() exists to support inject and clear poison by
region offset. That's an expert user feature for testing only and I'm
thinking we should just turn it off for Zen5. By turning it off, then the
debugfs attributes will not be present, and it becomes a no-op. Note this
also avoids users seeing but always failing attempts to use the feature.

How to turn it off?  Look in region driver where we turn it on based
on memdev capabilities and add an arch specific check.

HPA->SPA:
cxl_dpa_to_hpa() provides the translated addresses that get reported in
trace events for errors and also for actions related to poison list reads,
and poison inject and clear by memdev. Please note that when we say 'trace'
in this context it's all about how we report the details of these errors:
poison, general media, or dram errors in trace events. It is not about any
performance path tracing activity.

How to turn it off?  Look in cxl/core.h. Here we turn it on for CXL_REGION
and off otherwise. Can you expand that to turn it off for CXL_ATL?


-- Alison


[1] To "weasel your way" (in or out of something) means to get into or
avoid a situation using cleverness, trickery, or dishonesty, much like
the sly, slippery nature of the animal. 

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/atl.c    | 35 +++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c | 21 ++++++++++++++++++++-
>  drivers/cxl/cxl.h         |  1 +
>  3 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
> index 4bd2289b8bbb..9d05a83bde73 100644
> --- a/drivers/cxl/core/atl.c
> +++ b/drivers/cxl/core/atl.c
> @@ -57,6 +57,39 @@ static u64 prm_cxl_dpa_spa(struct pci_dev *pci_dev, u64 dpa)
>  	return spa;
>  }
>  
> +static u64 atl_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
> +{
> +	/*
> +	 * PRM translation could be expensive in tracing or error
> +	 * handling code paths. Avoid this for now and return an
> +	 * error instead.
> +	 */
> +
> +	return ULLONG_MAX;
> +}
> +
> +static u64 atl_spa_to_hpa(struct cxl_root_decoder *cxlrd, u64 spa)
> +{
> +	/*
> +	 * The callback will be used in region_offset_to_dpa_result()
> +	 * to determine the endpoint by the position in the
> +	 * interleaving chunk. With Normalized addressing, the order
> +	 * of endpoints in the interleaving chunk is implementation
> +	 * defined. Do not use this approach and and return an error
> +	 * instead.
> +	 */
> +
> +	return ULLONG_MAX;
> +}
> +
> +static int cxl_prm_setup_region(struct cxl_region *cxlr)
> +{
> +	cxlr->cxlrd->ops.hpa_to_spa = atl_hpa_to_spa;
> +	cxlr->cxlrd->ops.spa_to_hpa = atl_spa_to_hpa;
> +
> +	return 0;
> +}
> +
>  static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
>  {
>  	struct cxl_region_context *ctx = data;
> @@ -183,6 +216,8 @@ static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
>  	ctx->interleave_ways = ways;
>  	ctx->interleave_granularity = gran;
>  
> +	cxl_root->ops.translation_setup_region = cxl_prm_setup_region;
> +
>  	dev_dbg(&cxld->dev,
>  		"address mapping found for %s (hpa -> spa): %#llx+%#llx -> %#llx+%#llx ways:%d granularity:%d\n",
>  		dev_name(cxlmd->dev.parent), base, len, hpa_range.start,
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2c070c7c7bfe..130af1cf95b7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -623,6 +623,21 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(mode);
>  
> +static int cxl_region_setup_translation(struct cxl_region *cxlr)
> +{
> +	struct cxl_port *root = to_cxl_port(cxlr->dev.parent->parent);
> +	struct cxl_root *cxl_root;
> +
> +	if (!root || !is_cxl_root(root))
> +		return 0;
> +
> +	cxl_root = to_cxl_root(root);
> +	if (!cxl_root || !cxl_root->ops.translation_setup_region)
> +		return 0;
> +
> +	return cxl_root->ops.translation_setup_region(cxlr);
> +}
> +
>  static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  {
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> @@ -666,7 +681,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  	p->res = res;
>  	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
>  
> -	return 0;
> +	return cxl_region_setup_translation(cxlr);
>  }
>  
>  static void cxl_region_iomem_release(struct cxl_region *cxlr)
> @@ -3663,6 +3678,10 @@ static int __construct_region(struct cxl_region *cxlr,
>  	p->interleave_granularity = ctx->interleave_granularity;
>  	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
>  
> +	rc = cxl_region_setup_translation(cxlr);
> +	if (rc)
> +		return rc;
> +
>  	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>  	if (rc)
>  		return rc;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 20b0fd43fa7b..f4623728a815 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -653,6 +653,7 @@ struct cxl_root_ops {
>  			 struct access_coordinate *coord, int entries,
>  			 int *qos_class);
>  	int (*translation_setup_root)(struct cxl_root *cxl_root, void *data);
> +	int (*translation_setup_region)(struct cxl_region *cxlr);
>  };
>  
>  /**
> -- 
> 2.47.3
> 
