Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF46199EAD;
	Thu, 22 Jan 2026 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769062186; cv=fail; b=IvRcCoV3zI375lGlZGfiVBGBJpGGnvWdI2U9sjSgPNYmRmnGlwmRYkfeA4+7XJK5x5D/gsRf9LOENDD0Br6XmpDPmkz0yoXR+iV2MWlbrln07LSFimQ2S/bjE4T+ZOGZu31LF1ynztkA29maKVTssACwiM4C+DM4vV3QTh2t7GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769062186; c=relaxed/simple;
	bh=6snykjWG5XnJ7TCdlmXzH6n8my7LZgTt77rxQITRayg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=XOUB2kPfr8/u1EfEve5iP1YOTBbovQBeRXjdBWbzEoUyuAuhROqf514Y95pfjdcCYlhN660XjX/D3fIWNODhCDrjd1bWtwTLXdhqaeQipKNlnn08kfxFgX/KMfO4g2i8rpt9fxlbCX9+JpZtccN72nS5vYk61HW9kE3SMAgCXp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWiuM8Wr; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWiuM8Wr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769062184; x=1800598184;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=6snykjWG5XnJ7TCdlmXzH6n8my7LZgTt77rxQITRayg=;
  b=fWiuM8Wr7i/MdKoRAV+Q+m0gboZo04+qagdBs+Z7JunmqFUesIbH+Qou
   veS8tJokytrgrSSRndWZWXNLpXWhu1jZjjbjjpZiqjYqh+UrDkkpBBmXc
   n+fSP0yUxQ8aTKCv+RRPtE6F0LHXAN/GAGYlZ6y8xy4tPF6FYjRCWmhRm
   uy8ueH6eGrGDUPqSxTK7Hbmv83uubdnCgQ3ULcb4ddQ3hRnpXG9ggxuxs
   R/FZRkzbpQ2darKUji/uzx7j5h2JxMDaYXHgmj3fcjFYnRsYWq4lYGC3q
   6M/Rk7t9bisEB4Z4gYz5tGsjo8wrlktxFtU4vaMBm9ybf0bakeN3BDRD4
   w==;
X-CSE-ConnectionGUID: ymDAc9OuSLWrQgYTvbu9Eg==
X-CSE-MsgGUID: UCzyR1RcScehz9T0JxBeoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="57859912"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="57859912"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 22:09:41 -0800
X-CSE-ConnectionGUID: WBil1oNoRo+He5Q5dJ/Exw==
X-CSE-MsgGUID: 43XDtqEuSE2316fAeQ28fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="211659949"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 22:09:41 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 22:09:40 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 22:09:40 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 22:09:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYimz+IfdT8e1kk5Oor0wdt/Qjv7uljhW09yVFXWih0i0J4+P2BQYtCNl19K/GWgw4gdx9aVvZRNZqLu8PurQQUKUh95/zHzke9q2r3LCq8JlgdRrHeaWZFDxjyWZx18hvFzXR+kvWi1dF+Q1+8iowRXBuvr7Kx4Y4PDw5jtMrmQZM8rOLuEuHWv25aun8Tzqi+Dw0updumyW/NJiAbBh6nd5Hp+qbr4dGrZShxmCPKicOT1EvaBlaJXHGSWRE57gIuvF0gL9kloFckPFe1D+vgMDtPEtDiaVBs+rnzNsjOGZUvJ1uqmdNBPqMqFJbW2a8wceKIwph2SMwGNCPL4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIQoyywrkFiltfN8q4q3aM2qB0a+513tRIjb8h7FsLk=;
 b=ABdTvzMdJEF/hKfTk5bKZcQtbb+j+VqXE5RSKnAx+LyA65+m1C+JaPRwVoNMuBpnqodueoP2vwfbfe5GkJ7K4/4sN37XPYGfkhgyQt7yMI/IlexPSvTzRfZiNApEKRx9IsnXFKX3MtPQR3tCkRqflF+wxg4yp2gjnR2IVaE45r9lR3GTDVTclG6XGUlJeMo2UKyy8/1A08POUsxNgIXuZwt/Umlwa6ytukp2Ync9Il4E1J3RAjyLPFLE6ncBZeeHITDiPKnVZfSFFUXMiXm8Ux3MW1S/ccKHzlAKL0iBEA7yMpib9a7LomDwKOxBXYIFwtTSxoCojwItcxzHgI3RJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 06:09:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 06:09:36 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 21 Jan 2026 22:09:34 -0800
To: <dan.j.williams@intel.com>, Gregory Price <gourry@gourry.net>,
	<dan.j.williams@intel.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Robert Richter <rrichter@amd.com>,
	Peter Zijlstra <peterz@infradead.org>, Dave Jiang <dave.jiang@intel.com>,
	"Ard Biesheuvel" <ardb@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Borislav Petkov <bp@alien8.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, John Allen
	<john.allen@amd.com>
Message-ID: <6971bf1ea0ebf_3095100fe@dwillia2-mobl4.notmuch>
In-Reply-To: <697186008aa26_1d6f10061@dwillia2-mobl4.notmuch>
References: <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
 <20260114180859.00004623@huawei.com>
 <20260115080444.GD830755@noisy.programming.kicks-ass.net>
 <CAMj1kXENYZq-UkCup6FSH_4tmpRe4xJN1_veuSWs-hxxAo=1Ew@mail.gmail.com>
 <20260116143838.GC1890602@noisy.programming.kicks-ass.net>
 <aW5AvfcjLkSP2j42@rric.localdomain>
 <20260119160342.GA659351@yaz-khff2.amd.com>
 <69701f6de978_1d6f1001e@dwillia2-mobl4.notmuch>
 <20260121145817.GB1784626@yaz-khff2.amd.com>
 <69714e9728d2d_1d6f10075@dwillia2-mobl4.notmuch>
 <aXFdZ_uzXJ8shieZ@gourry-fedora-PF4VCD3F>
 <697186008aa26_1d6f10061@dwillia2-mobl4.notmuch>
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:217::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c44cc9-fa3e-4b43-a6a3-08de597cd1ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWdRMXZOWEJTeXBsd1VsLy9QQW9meVpjWTBBSnh0MWgyTEIvWnk5VWF1bzlF?=
 =?utf-8?B?TXU0eEVVYmtVaDkyTEYxbm5pZ3dxZVhCNXZENmNaTVNqd3ZTZTBoU0NrVzNh?=
 =?utf-8?B?SjdBdDlmWVhNYUV3SXA0cTVGdFJ2OS9kQ3BhWHo0RnpiTkljYmg4N2RTM2Qv?=
 =?utf-8?B?aVVwZXIyV0NjUnMrSVBrVzlTemVHKzBmU1RMMlNNZU5nTHlsTFRpZitUOFI2?=
 =?utf-8?B?UGFVVUFWcGkzdGlhdWxoOENKU1M0RGh0dnUzd0VXcnJkTVdXVURoeFhjRDVw?=
 =?utf-8?B?empNYlB0RHFQRWQvRTF6VU9BQm1TUVM2ZVhHWVZqTzlQZFQwR1lRbURybTho?=
 =?utf-8?B?SS9hQW5aMW5Fb0k5NkIrdmRrTFZ1N21nWDRUdTZCV2ZZWmx1QXl5R3RZNjNO?=
 =?utf-8?B?Rm1INzI4VnpsMG4vT0xlR1RUL01OS2tYaDVSYWhxb01HQ2s1ZWF3TlFKeS80?=
 =?utf-8?B?REhPR1kzTUlHZ1dvakRMdWJlTEt4RlhacExrdGhuUHFQeUllcGhSMmhBbXU2?=
 =?utf-8?B?L2lrQ2N6UldWeEVNVDU0WTdlRFY2VjZhL0gxcFZUcG91QU9zSkd4MmxFVDIy?=
 =?utf-8?B?RnNJRlRHaFdZbVo4MEV1ZTBBb3phR0dnSEJsTTVqcTBEdnU2eG0zcWZrS2Zm?=
 =?utf-8?B?bmtRZ2lLRERONVdvREFWZVYwWEJRdEFBNkQ4NTluaTBOWElTUHZTLzZ4WXFq?=
 =?utf-8?B?U1FoYVBadWJxdkozMGovbzkzRGRRR2gyOGF5UHZjdjRkQTdzTkF6RHR6aHlC?=
 =?utf-8?B?NFJtblR3bVNqSVkwaG9nL05UUEdlQkVVdEZOUXZaQ0tqSkJDZlp4cTZHenFU?=
 =?utf-8?B?UG1lSzVFTnJ6TnEzMFFjRWNTY1FkQnBqZjZHbTRVVG9UOXRzV2lWdlk2dGVG?=
 =?utf-8?B?SUVUTVI0L2N6Y0Q5ZkhHNy9veTRjZWhaVW4vbmhTKzdDNWNZYm9XaVJrSWZs?=
 =?utf-8?B?dmg2R2lvMUs2ZmlUdG9JY3pPbExHMjNxemFHRUE3YTdVcWJVMURLbVlpdkoy?=
 =?utf-8?B?aVVGUWd4VmdUaGE2dytRMVZDejNTdk12aUxUWGFkODEwSVZBd3JiVlU4N1BT?=
 =?utf-8?B?U2UwQ1RvNXhDVGY1MmVTOFhXZkJsZUJhcW8weG95a3kzWVlMS0FtZGZJdDlW?=
 =?utf-8?B?QUREZzhmT2Q0RmpXdTBYUDJRSXlhVS9XbGIzdThmUFVmM3AvaDYvL0FtQ2ow?=
 =?utf-8?B?QnUvNTA4K0NCendITEZXUm9TSlluanZVeWxQTC9FbEFSZXg0SjFyVk1panhD?=
 =?utf-8?B?bTZYZFJSQjBmLzZCM09LNHQ5Q1dRYXlJTXZyemZ2UC9JQlF5Sk00dWVwWDNI?=
 =?utf-8?B?dWFVeFhsT0tIb2dEbWZKNXMwZWxKT1hvMnU2VHBwYk4yYU5OVFpvZG9EcFBp?=
 =?utf-8?B?NzQ0Qnd6YXVJczFCMUdyVzlHUWlGSWwrcW5xakdKVDU5d1h2MmtDYUVocUtD?=
 =?utf-8?B?THg0WjdCSnRvZmdxMFVWYjNEUHBoeGQ5RE1HRm1WWWo3dnRCUVZwUHpCRk5k?=
 =?utf-8?B?MjVXTW1mQVhnNk1nN3kzeW1OdEZGS2RpLzliQ0VjcGI0WkZWdEF1TFZKdEY3?=
 =?utf-8?B?aWJUY29Zb2xyUitrUS9kenJObWo4ZlFvMEVNdERUc1BxM1c3TU9abm1EYm9O?=
 =?utf-8?B?d01pYW5lZmprMGFubWhiVURyb1lVWDZwem1FV3Z0emxyU3A2MXJiR1JYVWQz?=
 =?utf-8?B?RHR3M3hOYit6MHcyem1oSHdnK0ZLTDlJbWRLOG1QOUZrbk95Z0dyUTdUbHhv?=
 =?utf-8?B?a3IrOXVFaDZYVTJFL1oyRVkwUkpvdnNBMHB6S1NxYkRFRFI3QVRmL2t5aHNr?=
 =?utf-8?B?djd5YmJoWW9tWndPazZBbzJORENqL1hpeWFWZ1JhNGpiL3ZiRDVBQkNWdWtB?=
 =?utf-8?B?dmFVWjlVWEFrRDVja05zb2loNmord3ZIeUNZREZwbGhPd0dDSm9ZQlVCSnpX?=
 =?utf-8?B?ME9HeDIvMnNkSWNkWVBJVmovYlNFY3lyd3JCbmV3aTNpMjd1YUh0eWNNcGdu?=
 =?utf-8?B?VzJTaG0rSnZUcVdaMk1jLytRT2xPaHFHWW9ydlNqNUkzMSt4YmtScHpqdXNV?=
 =?utf-8?B?ajVSQjQ3U09GbGtjSTBPSGR5L1ZjYjVneGZleGMwMFhpZEZPOVF3RnAzZmls?=
 =?utf-8?Q?5TB8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2VmdFF4a2Z5MkJUcXdEZ0xKTDd4Q0k2dVZMSG82ZTIyTXJPWWlPa2FiRnFU?=
 =?utf-8?B?MTVtMk9sdEQ4dWpPSmMvVktUNHVURWtrdEpKUW9jSDdtcXczWURzbC92VCty?=
 =?utf-8?B?U2x3bEhOOElPdlZsNlNpdCt5L3hrSzBUeXFKcDVNcmQzemJ1RVFYV1lkVEZF?=
 =?utf-8?B?NTZ3Z2RmbXBRYjYzbXBFUjloSitCd3NVWmJpZ01WVWNtdlI5dStNaGlKREdR?=
 =?utf-8?B?d0NaSVM0cUFYamxpTkNqeUpweDJNcUcvaDVtYnBrR3dNcHlkaFZBWlBBZ3Zw?=
 =?utf-8?B?MUpSekpFRXF4dER1NkQ4K0tEcUE1R3F5YmREbXg2UCtHSitZcmErK3gzZFJt?=
 =?utf-8?B?TE1hWXpnV2FUMWEzYnp4K1dXR0JZeDJaZWI2UGRabTRKVDk2Z0RWbWhmanlL?=
 =?utf-8?B?aVhveEp1dGRJKzM1Qnc0VEIwZEE1dkZza1h1dHc4dzc4VEltYzViZTlyN1VY?=
 =?utf-8?B?U3RaZ0lNa1Z3NCtPd3lIQy9BVGozcEFzMnl2SkNlczExTWRzeWNjQVNWYjhR?=
 =?utf-8?B?dXozb2lLNFloZUpYN1BpL3JHM1FzRHdETWR3RFgzS1ZoemZlcmE5WFdVUnhk?=
 =?utf-8?B?UXdYY0F1cXI4SUpOUUhDbmMrZmE1ZW5nWEs2Nmo1djZZOVJWK2ErbFp4YlYx?=
 =?utf-8?B?dkh3WnZVanB6UUx4eVVrM0NnNG1kZXcxT3k0T1QvaTZGTE9MSHRFZUU4QTM1?=
 =?utf-8?B?Ukk3a2JZOFZGL2Z4NUhkS3MzQU5jTExML1MycEpaaFdVM1ZJcUFXcHNhZjUv?=
 =?utf-8?B?MmY0Y1l3ZDNkM0xDTmpYeHZ1VzlQNHZKb0FQRGxpeFZBcFhDZ1FDam5ZNHo0?=
 =?utf-8?B?UW8zRHlpbDlQdWhsWG5TSG0yNDUxNzkyRi9VTktjM0hqMmZJMHRaVEx1Mlov?=
 =?utf-8?B?bjFkSnR5dlBCeXRSaExwbHRvajFzUm8vMDM4d05mVHVxZWVaaU1mdHpuUEdP?=
 =?utf-8?B?Q1REN1d5akx2eE1kc1hIRVZqdFNNdVZzS3VXYzhkaGVOSFRQOXJsZGsxNVl3?=
 =?utf-8?B?VlB5Ui9NbEx3OUEra0xFSjBGZDBaZTdFemhtNWFrZGpuOGZ0cGtiTldmT0N6?=
 =?utf-8?B?ZnY2TmVacHFIUmZ2d2ZmaktSNGR1bGpRODYvOUxMQWNlcFV0ZkxmNWxXQlBw?=
 =?utf-8?B?Sy94UE00R1E2UDFDanBBTDVhblduekdFa1FnN2NrTFVvU1hoQU42RUFhQjJM?=
 =?utf-8?B?Vy94U1Z2MGR6T0g4d2ZTLzNkVHZ6K0N1RHZ3aWw1VU9HY1hmZHFNUEZRRVBy?=
 =?utf-8?B?Z09SMmc1VTN6SXRlQXlhMmtMcFhqcG5BRFRiVFRlN1NML203dU53TDRzV0wy?=
 =?utf-8?B?cGNRNGZ6UlAvdWhhK0lzeGgxdDF2ank5MWpmQm1QdXJ6c05oaFMrbGl1OWJw?=
 =?utf-8?B?SFNhcEM4bEI2cmVyQlhUYWdaT0F5dnVhclJNTjR4TkpjNWU0NUFHRHduMGl2?=
 =?utf-8?B?SVY4TVN0QVNtNVRkMkljRU9rUWc5S0d3N1Q1YkRBVzhVbHVzU1hmbmxvYUg5?=
 =?utf-8?B?UERRbWtJSHFzZEFVQzRhTEg3WUpBTmczSzZkc281N1llZkp3VDRqUktyS0Ex?=
 =?utf-8?B?bHRvRFI4V1puSXpKUnNDSXpiKzdJTkJmVzFJVmFYSjU4Q0tIWlJSUmt2cGVz?=
 =?utf-8?B?ODlZUDV4Sy9Ca1lVK2Q2Ym0xOGE0UGNHV3FhTU1XdVFLcExtN1dFeUZhMEJI?=
 =?utf-8?B?cFlPRzArQWNoQ2orVWYvMWd0U2FKT0k1S0FEb05LK0hIY3JzY3g0SHNYVzFN?=
 =?utf-8?B?MVNLN254dVB2akh0TjdHNEFnaHRVWEN1YlZoZkNOb2NiNitCalhuRFpsMW1D?=
 =?utf-8?B?RFJ5T1dqNVppQUFadzVaSTlndjZBTDM2UWZvb1Y2QmhrdlRrNVE1OE05YlZ1?=
 =?utf-8?B?TEExMlhpMmRtdEJjSDB3TzM0Y0c0UElrY1Rla0c4bmo2MGI5TnJqYWY1UFlQ?=
 =?utf-8?B?VmVaUzM0SWRadWUvWmhsbDgxZDV3VmwzRWkwTWFPSmk0cGRZWDRPUkMwRG1X?=
 =?utf-8?B?YkZDcHhlNnJmQ3dUcElhVElidmpFcGtMZCtyc3JvTFcxQ3RjYU9OdUVldzI0?=
 =?utf-8?B?Rmc1WU5yczlZMkYyZGE5RWRzNDJrZzAwdGVQc1ozYkg5WmpxNlJpdENNQ3pi?=
 =?utf-8?B?RW9pSVp0Ri90S3pwVGFBUXArN040NFBPZy9oei96ZnYxdnBOWFIvMThVY1pF?=
 =?utf-8?B?bjZtSEsxSjVGQ1R6L1V2T1cxQUhDUUZQbXhPQm0vWi9iNE1jNWUza3FROUpZ?=
 =?utf-8?B?Q3FkMWI1OUljbFBrOVBOVVNjR1VXZlE0aUlxQ2R1b2FLK1gvKzRrSGU2alZi?=
 =?utf-8?B?TmxlTGhqdkNnMDlLYTZqbWFJeHFOZ1l5dzhpYWsva2diRjZteGU5V0FIL3Qr?=
 =?utf-8?Q?zNUDAnBk2djYq7dA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c44cc9-fa3e-4b43-a6a3-08de597cd1ba
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 06:09:36.3690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUZoahM9a8/j0CdfWkirMD/SRqET6h/GFo2MUArGx1RU16/vlr7I9CQqg4zHQWUGMHW4DH1yuiMotTyKBhNEicR4272H6t1coOzIbGAnZaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6083
X-OriginatorOrg: intel.com

dan.j.williams@ wrote:
[..]
> If the above is even close to being correct, I would merge that in a
> heartbeat over this PRM proposal.
> 
> Robert, do you really want to be spending time on trying moving PRM to
> userspace vs just doing the above?

To be clear I am still of the opinion that even if it is confirmed that
Gregory's algorithm would have done the trick with a new table, proceed with
the PRM solution. The PRM method appears to be already shipping and it fixes a
long overdue problem causing end user pain. The request is do not plan to ship
new PRM without clarity on why a native driver approach can not work.
