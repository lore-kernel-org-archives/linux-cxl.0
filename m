Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5873732D45B;
	Mon, 12 Jan 2026 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252220; cv=fail; b=ur963iVPVn7f4D8OiEMBZR/xvmlEk1C0tOKOh1ePinM9Z2n1mtUD31x1S9JjW4R7sdwFoI//O+d7Vutgo70WKClbaGC57jLtTcH/U0yVCIkXhv+eSurxFexHVLQn/UnI3aTUF3ZrK1dhfLMCBecJ2q6z3FixH1lEbB+87J/IY/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252220; c=relaxed/simple;
	bh=NMDLmlIlcrQJJQdiYWSJBg4ymap5DPqICYnLVbwniaY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=MxIIqwD99GPQlLALMPO4OTVV/P3QV9mublSCN5pSRihw18bnXZP3REP413yy0Uu6q3Zs0YO2EDl+FVjo8PNJkPtcTfevHu0XNGTJblLyx60yVIq4PHlxn5nyOTvtzHGNJeQheAK03AIVTizR8saJacAoMFfLEdlUhnLJfP0Yz88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4V8+aBL; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4V8+aBL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768252219; x=1799788219;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=NMDLmlIlcrQJJQdiYWSJBg4ymap5DPqICYnLVbwniaY=;
  b=M4V8+aBLQsYckrFRI/j0A0OWFoqGrTCLjuRxll017zcW/E1N+/W+3XhD
   31dpZUcvb0+vtddesFqyWOnPYMcO9KWDCjz3e780NXhaaqxlhJQoyZCgA
   vJ3exLnQyuZ3Mdg3gsqO9WWDGP35xoW0VOxNOh7kxey+VKB9J0qaKW8tF
   5zlsD3QqEnVpB8/N5vJgsF+ILDJXQ8mEx6k7RzR1KajQF4e0SOZ3jW/OL
   qNefeDmlSzAll2rUuhbokOxindGojAYWxjE4MhVSCRiGEiX7foMrRytgN
   VNq8d8fFxtdS7yL9r0r8Jl8EjS5A9tUc9++oehxtjZYHGSels6t2+lZFT
   A==;
X-CSE-ConnectionGUID: 0Ofin4awQdOInYxjSs7YPg==
X-CSE-MsgGUID: aoEvQ6PDTSabGulBv4L20Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="73386344"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="73386344"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 13:10:19 -0800
X-CSE-ConnectionGUID: I195qHrtSVmDd5bU3r8OIQ==
X-CSE-MsgGUID: psK56bq1QVygZrtTH02rpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="208347300"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 13:10:19 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 13:10:18 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 13:10:18 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 13:10:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R05iHf7NT65Zan8JqJvdUBLWbCTulLeRWSD9Y3cg5chcAaz0lMQtkXYQUndcpLd44iEXYadZqBAwb9UJBlBJ7/11O/V7iFbk/+UJxUSTxJK6DkxEjc1Wm/86lm9USqiDPBiK6lfzBBK69pxMOwydEu4iXEK7Xt5FC3Wi3Ym5dU4AfbqYV3qu1pMkdXvIM13KvytFATbJgUWScnGixoQF4wJUd+Qy7xWUxd+QQVSl/hWA5s+iPqBFSE0Q+IdnUPwpEIox9hP2iMellu913aKXB+uQcpU9bcal72yVj8E/+NODkTE4gdyxImaKLazqILgv9t8dmuk4OJCCRQD7TDvpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2HVncCqfP6xvlD2zADzXAhSZPs5ADJ3H0Ezu1IGoxs=;
 b=G7D0v4QkjrqxUVbDyqXmmyGu68boZWZlQ/ME4PKchX1zX8/AqMLzHny2xqzEHsL3dppgwr+CcRP3bKKRoELg0EkxQPFgk3xU52fTrEITcHcq/w5Ea5zhxL7cFxi6V+IArtqUjNAgF06Ex+HVeyHRX9CfkYp23bQ5rljvADyo+UoI4y3IztpZZouJDUkE6F9Bnvz7ghvM8E+uAz05lbqc8fdWDf2cWbeL/iclypuQYy7eP6ud4trkPqkLCvT6dezkNfrAvfC0FDgjzm76k/aeryqQpZAmba9MxrK1sHvWt1nTh6MsrloqT+B49l8KGdm57dS00mABPaf6Sr+XsijJfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7985.namprd11.prod.outlook.com (2603:10b6:510:240::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 21:10:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 21:10:15 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 12 Jan 2026 13:10:15 -0800
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, David Hildenbrand
	<david@kernel.org>
Message-ID: <69656337337f9_2071810063@dwillia2-mobl4.notmuch>
In-Reply-To: <20260112163514.2551809-3-gourry@gourry.net>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-3-gourry@gourry.net>
Subject: Re: [PATCH 2/6] cxl: add sysram_region memory controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 5053d650-b4b7-4f8c-7250-08de521efb95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SW8waENDOExhWEgxM3VCZElDL3FyWmxsczZOUytjMEdrVDdtcW5EZ3hGZlQw?=
 =?utf-8?B?djlpbGZxeWx6bmVha2Zpc3NDV1FlakVFd1k2UlFOUlJLdGF1bjNPQ3IyKzB0?=
 =?utf-8?B?dndoeFZTdGtFYjArbUVNMXVreDVGdmZpdmJDMkxqeXRmd2pIdU93d1J3VkNR?=
 =?utf-8?B?MTVFOFp3V3AwZWRmWG41Uitwa3BXbVdJTU5VcCsvUVRYWnZsVjFTV2thWld5?=
 =?utf-8?B?N1lqY3BXVGhBN04xK1lNd3pMcHI2Y1BpWUQzVG16Y3YrTHhVTVNQTVhQRExn?=
 =?utf-8?B?TE84Yk9GNVFPQ2M3Qm5UOXJaZWQ3cjl0aEQwZUtkVytadFBzY2hjZjFUbE9O?=
 =?utf-8?B?TThWTGNGN2xWS2RGMHN4N1Vud1BRWkgvditTNGR1aCtoMmJ1KzQycnR5TENS?=
 =?utf-8?B?UGpxTzVjQUNKTkhQR1Ayd0d3YkNjSmZNWGNDK0oyaFdDTVcxOG5vMjU0ZmpU?=
 =?utf-8?B?ZEZ2TElkbnVEcTRoczNEZWE1S2pZZVoyaGhpQWc2R1lobWJMZ09RdVZlUnd3?=
 =?utf-8?B?RnBvQ3hXU0Z5Q2IweGdKeXdwcDB5Z2p6Zi9NS2E3bSt5bnFHdHJ5cDU5VnZ4?=
 =?utf-8?B?VjN3Tm5ubDFOdWIwV3dmbXNmMzE0YTBxdzhMRDVkVWIzKy9zS2h6UXIrT01T?=
 =?utf-8?B?cVArU2pKWmVDak4yL3FyUTlmNVdZcndaRmwrYlI3emUxOTR4S2ZWckR5MWY2?=
 =?utf-8?B?bC8zY2t4QTdLTngrR3lBcWU2TTZMRHQyc0cwTU1zUVRGMFVYbXhtcU9nbnpN?=
 =?utf-8?B?SUZCY01FdkYzcklhVlNVMUFmM0U4WnZSNUpSOHJKOFlTajdUOVYwdWJSM2ZT?=
 =?utf-8?B?T3EyU2NOS1dOdDZTRUZuOUF1UnNSanZwZGNKNTFhcWxxamJndTVjczlGaCtB?=
 =?utf-8?B?R2JHdndEUWQya0F4a0dkVllWMzJ0dlU5bEdreUJUdTFRYmJndnF4WGF4aVg4?=
 =?utf-8?B?Q3AvMnNMZS9FZTZGWGJWYlVmNGRveUVsVGRzOHpWTllWVHFQcmJieGNTSzZP?=
 =?utf-8?B?dis4MVNsMkxrb05GK1BxdFMwMTVOeXQvT0NCcFE2MDdmbkh3ZVl6VW53bFhM?=
 =?utf-8?B?ZXpSV0lmS2FaeFZiRVN3d1o0Vmx5dkhaR09NQzRJL3I5bXNTdFlmS1Y1emZ2?=
 =?utf-8?B?NndkazFic3psRTdtVGkrdGlJQ25LaWtPNEZFNDZobENUdmNwK1hDbjVBQUFX?=
 =?utf-8?B?S2dYVkRFRTMxejdlVTZkTkNzQ1oxQkZTRDRmcFZSbkF3OVpkWFJKbFd1OS9E?=
 =?utf-8?B?SXFLT1BBSjQ2YU5jc09MV1Ezc2lyaURoY1NvWU9Sc25ERGsrNFNHaXRJdmVP?=
 =?utf-8?B?L2NOWjVVRkFGb21aV0d1aldXbms1QU9ZcS9NNktZRHN6Tk5XUEV1cVllcU1K?=
 =?utf-8?B?RzV3VDNDdmNGUFBrcVkxZTM0UUFWZStjUFZzSXhYei9LVnFQTmRGckxPaXVN?=
 =?utf-8?B?eFRrWVBvTklFYW1hMFMvQmUrZGlLUDlhRkdPZFBKS05qS3hmUVlvVjJoZEZM?=
 =?utf-8?B?SHZ2MlI1ay9SOEFvaWd4enV5NFlKWkpZNFV3RmhUbXordUs2a01NcFBRNGpp?=
 =?utf-8?B?ZkNtbWNMNlAzRm1CTFAzWEVjazVPK2xUWGZOSEMyWWtibXFGWE1kTEwzNU1m?=
 =?utf-8?B?ZDRqemV2TzUzRis5eDF3clhycitWMzdENTJwZUhIYW44SXQ3bnJIMDFIQWJV?=
 =?utf-8?B?VUJMOGROZHBDK2dVZGx0YkI5OHh5WFNLOWdNY2QvRS9scVI0Yk5oYStOT2xu?=
 =?utf-8?B?Z25Jb1g4MlltazlOTFlyVjUzSjNKRlBTYjRmWXg3MENKSC94bDNnWjdGZFp4?=
 =?utf-8?B?YlVPU0cvSTl0YW9URUoxN2drSjVNdUx0UHJIMXJTYWxZVlF1MklTbE1ZS3Jv?=
 =?utf-8?B?SUtxcHNvV1J5RHdnc2pFcGJyN1Q4V1h1R05ycGNwbzB3eDk5TzFTSWpTQmRW?=
 =?utf-8?Q?greHTcO3E4CHBiQvebz2zNiBLGfYf9cw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE9jNE5aTzZaaU1rRngrbUI3RXRzSTd1UFBsWVloL1ZQRGxQeERia2ZEZTFx?=
 =?utf-8?B?eGhUd0x0YlNsaGN6WTc4MTJZazl2aHJJa29mNlNBUjVoUnRLNVNNZXNLaW0z?=
 =?utf-8?B?N1F1V1E1N2FteXQxcEgwcjdyWlRDQzl0WWN5bjlYOVAyMlo2U1loWkkzNFlk?=
 =?utf-8?B?eHZaYXdWc0ZoemhFRGtwSTlWckp2UWhTdndkTm5PSHdlVjc0V3NKaS9kSStO?=
 =?utf-8?B?Zjk4aDZaeHhqSXAwZVM4aWMveE9ad0ZQNTVlbXpFamhESXhoMUhmTERkd0pI?=
 =?utf-8?B?VksxclBpazFwY3kzS0wzN2dFVktiTWIxK1FpNEM2YUNZMHBBdVowS2ZXQzJt?=
 =?utf-8?B?d3J6QUxRUUtsS29paDFzdU14V3hMbmxORzRXam0wN3dCRHM2aFI1WTRPaUtK?=
 =?utf-8?B?cGM5Sk1lQnRoUUZGTE1IVEl4WGRUbE1Fd3JwQ1VmZVRoellzQVZvclYrL0Z5?=
 =?utf-8?B?WHRhMlNMN1dmQW5oYUM5Yk5GSngzTU5kVlA3UWNYZE5tS1FKclMydGZ5U3Zq?=
 =?utf-8?B?aE9ScmNreVlyRzNrVVdGTDBnKytxUkxEUzN6RmJ3Ky9jclora2xWdndjNkhQ?=
 =?utf-8?B?UkNJRGJ3aWZacU5QTjVnazI2U1YrR2RDTjdyWFhDbzlVRkNac1ZzejJkRTVZ?=
 =?utf-8?B?cUN0SDJpR2NnVFE3YytpNnhxRHRQQkR0SENwVk5qa1E5N0YvN0tMZUttQ1JZ?=
 =?utf-8?B?QitOeGZwOCtCNTNma3JNV1dVWlR1dzJnN1pSSjVtKzN6SHJjdnplT2NGa3BB?=
 =?utf-8?B?QkdudThHc2QwVFpSUy9hUFhOOGc0bW02akQxcFNJbmRDaVVlaTROWk80cmRK?=
 =?utf-8?B?b096Yko0UFdkdXBoeFFmdzQ1YW84alU2NkNyVGU4dUFFS2M0VnFpMXhIUXpU?=
 =?utf-8?B?L2JtcHRVSWtaSC9PZ29ETWIzSWNlVVpvTVJXaFhRS1dmTkNDWjlVVWxhNjQ0?=
 =?utf-8?B?VFpjSXoyb0hmVTFQOUZqYWx1VkxhZXhNYWpKSHFNQ3NJQnJud2toKzNDVEFY?=
 =?utf-8?B?M3lTbTlCT2dEZERkdGEzcU5NZk5aRXZCdTRxMCtkaEV6RGdDUDhoYXkreDk4?=
 =?utf-8?B?anloZHA0Tm00RGI1OHI3OGl4T0w0dUFNVDdMb0lOTytHUjV3M0FhcnVrc0tv?=
 =?utf-8?B?cjJaUUt0TUoxRVJ6N0tLS1U2WW1tNG0yb01qWkdnWFFvV2dlTjIrVWJqSytl?=
 =?utf-8?B?QXpWUWNBVjZyZzRIT1UwL0dxVlRSblBkSUtCaFhoK3RvOTF5Nk1aVlpNR3NE?=
 =?utf-8?B?QXl6cWV3SlNHckxlT2NBN0dIYW1Eb2U2WUpaMVJJa0NRb1lZR3NYWUpRWjFj?=
 =?utf-8?B?czZpek1wQ2RoeTFCSUNMOHlEb3F0OWlDcnowZ0kwTXF2L1MySUdreXUwN2Q3?=
 =?utf-8?B?UFB2M0doSXJDTVJiRWdaWVhCNkdWYTlwNGtOZjVIQzRCNWVnWktSOGM0aDg3?=
 =?utf-8?B?SGxtREpYUUo0UEtWaXVtdFo1MG9FY0krb25jMk4yVnhyQUkva2kzUktLNGh0?=
 =?utf-8?B?bDVENFhiRndrQ29mWjNWSW02R1kybkQrV2JaTzM5VzZNb3VGbGMyN29MYTM3?=
 =?utf-8?B?UGF5a2sxZlNCeWlJZUhSclBLSGhMUGd6WnVEQUJOWUJHODJTc2tEZkFRK2wr?=
 =?utf-8?B?Y2NlS0dIQkI1QlF6REVBQTYyMnB6N0tTeUhGR1FmVUdLVTgvdDMvVE5IZFor?=
 =?utf-8?B?bkUvTlliNlVkck1LNFZXSkVQaTdoTGhVeHEzL2xWUTJ0QWRSOVdwWC8xYkJY?=
 =?utf-8?B?S1pNSjJXYmhxRnBFcHNuR21Rck4vM1RpL0pLVEZ4M0dSSHN3dVk5ZUlPeE5t?=
 =?utf-8?B?c05kbXRnekxVRUtOQng3bWJsalhGM09EU3BFY2NWMlpOUlEzQTNsVFNjRVNM?=
 =?utf-8?B?QndnNHZqci9TeWZpQXo4TGFWcnNvSnZjRzBoZWZKOFBVQjBPWS81QVBzaFdW?=
 =?utf-8?B?dnEvb1U1ZDVZZmZWcW9lRXByWmFkalBDQ0tpQTBrMWJpc1hISWNvYThBb1Nu?=
 =?utf-8?B?UG1VdmJvMmZZUVhxdmpQNXArYmpldCtVVlI4Z21uRDhxQU9EbjRpY2R0S0ov?=
 =?utf-8?B?aC90eFdFa1Y5bTNoNUFYT1NPbCtYVE1LbUZqNEYvNW5hdHN0ZVpIWkZvOTNS?=
 =?utf-8?B?M2FTaW4zN0dwY242Tk5zNzJ2WVlBRXhza3huS2FncnVNV2NKQ2dsRHVsb3Nq?=
 =?utf-8?B?d3UxTHBJNm12em1rZFo3TkZkTC9mQlRyOFg2alI3VnZFbTR5b3JYbyt1Mmtu?=
 =?utf-8?B?ck5JQnVOMHZhdVVUWlZ1bWZlcnl1eDJpY0hnNXNHZGVqSTFNeGNoSmsyajlu?=
 =?utf-8?B?eEtENmtXMm9zZ2VieEZLb3o3MlpRZHJNZHk0RG00ejlQcVJCUXpoRlk1Qksy?=
 =?utf-8?Q?45/RllzBRx31cE14=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5053d650-b4b7-4f8c-7250-08de521efb95
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 21:10:15.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCbLJeI9OvdclQHF4gf57BU7ih70FbcQmksvfg1xeyZCduHyPfMQurELW6pi4f07YCbtdK1anEsnDNpMwDT+kU1qlUbVBBEgc5H3GgCI4kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7985
X-OriginatorOrg: intel.com

Gregory Price wrote:
> Add a sysram memctrl that directly hotplugs memory without needing to
> route through DAX.  This simplifies the sysram usecase considerably.
> 
> The sysram memctl adds new sysfs controls when registered:
> 	region/memctrl/[hotplug, hotunplug, state]
> 
> hotplug:   controller attempts to hotplug the memory region
> hotunplug: controller attempts to offline and hotunplug the memory region
> state:     [online,online_normal,offline]
>    online       : controller onlines blocks in ZONE_MOVABLE
>    online_normal: controller onlines blocks in ZONE_NORMAL
>    offline      : controller attempts to offline the memory blocks
> 
> Hotplug note - by default the controller will hotplug the blocks, but
> leave them offline (unless MHP auto-online in Kconfig is enabled).
> 
> Setting state to "online_normal" may prevent future hot-unplug of sysram
> regions, and unbinding a memory region with memory online in ZONE_NORMAL
> may result in the device being removed but the memory remaining online.
> 
> This can result in future management functions failing (such as adding a
> new region).  This is why "online_normal" is explicit, and the default
> online zone is ZONE_MOVABLE.

David's early feedback aligns with my own with respect to not creating
new "online_*" ABI terms, but I want to go a step further.

Part of the proposal here solves a fundamental problem with the way
dax_kmem operates in terms of fixing the complication of dax_kmem
depending on fine grained / multi-step online control via memblock
sysfs.

If we are going to introduce a new omnibus way to online entire regions
at a time then that goodness should first come to dax_kmem and then
potentially be refactored into a library that CXL can use to skip the
device_dax indirection.

I.e. the end result would be this "hotplug" mechanism that fixes a long
standing dax_kmem problem and then go further to drop the indirection
through device_dax and have a "hotplug" mechanism directly at the
cxl_region level.

> +int devm_cxl_add_sysram_region(struct cxl_region *cxlr)
> +{
[..]
> +err_add_group:
> +	dev_set_drvdata(dev, NULL);
> +	/* if this fails, memory cannot be removed from the system until reboot */
> +	remove_memory(range.start, range_len(&range));
> +err_add_memory:
> +	remove_resource(res);
> +	kfree(res);
> +err_request_mem:
> +	memory_group_unregister(data->mgid);
> +err_reg_mgid:
> +	kfree(data->res_name);
> +err_res_name:
> +	kfree(data);
> +err_data:
> +	clear_node_memory_type(numa_node, mtype);
> +	return rc;

...btw, this feels like too many new gotos in the age of
scope-based-cleanup. It also feels like a bunch of duplicated code that
CXL and fixed up dax_kmem can share.
