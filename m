Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88D27AC57
	for <linux-cxl@vger.kernel.org>; Tue, 14 Oct 2025 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469411; cv=fail; b=ie4QvCfeLKcH3Ox/K6bnZxi/m62rY3hDht9qYN8IeZp08OGjUtEF5L58+0sfm3s7eo1D82W8sHXH7arbbmKzQ4bNfz90NTZ7cEOx/cJyjg/RyjC1IaBJ50+VMlOut6v7BJFUZ7zhWDxAmlQV1w3C6UhG7f+2lGI5usG/cZeaxz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469411; c=relaxed/simple;
	bh=6Vwr/BU/lEgXIRrEFEtSuBBffTxjuaB/BLAWGa2VL9g=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=txzNn5sI9R/2Q7P/IqErAEol8TbPva6Yv6sL4rSanwqFFYWUT4/E5RC7InFPhaIt05niBngJs9l573MclzNIHSCeSKt1mhorrCgE7Pr1m83XlrChwO5qbz6CYUW23CVguYllwv0B0a81Mnxx4t8Xs8Ozjx9G6ps33nhhdG5HNqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjgRgL0T; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjgRgL0T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760469409; x=1792005409;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=6Vwr/BU/lEgXIRrEFEtSuBBffTxjuaB/BLAWGa2VL9g=;
  b=MjgRgL0TKVd/Xr/x5DWOUNpnBSq70Xt5d7wJd7+hx9Jkq3DJS4JZhlg0
   jbt4iW5oE8acBr1VTmoVQBmgSgsRXZ8t3d5IgEB5ScrdHqe+pmZr0yX93
   J1AiXqpx9sF9G2rdPOUu3kVM6AYw4L83acfac7tW27GcJ6W9nAO6BIcz+
   hv4IbSnSONUG/EDgaP53Q2RtiV2+CjEga1unBtR2btjb4c+DfxgujqlkI
   78D+7VOg5wrKMvCaCdbf8NWZ65S7qqCPqmyPsL10td9Ouk/EtDeBatjil
   LxjCABCaVHrI7BJsslk9LKSlko6DVufu+MesOAiB1QtLOrEACEuF62ILs
   Q==;
X-CSE-ConnectionGUID: 8raP9H+5SUKAfNaH502BHg==
X-CSE-MsgGUID: /Zzeh8EtTp6PYdwwAw9dWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62671980"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="62671980"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 12:16:48 -0700
X-CSE-ConnectionGUID: 5z0tfKbzSUioYu+w+kKNhg==
X-CSE-MsgGUID: Wd/oOWvlRxypZeYEa7qZlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="219109943"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 12:16:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 12:16:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 12:16:47 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 12:16:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUJ1M4mn7jR6q3JY6F48E1CJWpoejNkyMVJmKU0ly5C4YwLx5eLEbkPIqUaqWcsnBMCQT6yRILHx8SC/jS6lhtOoOj9BP5dn93nlSuaU+gLd85EZbkY6FGcOf6l81WX7UsGfV4ahxZDvLXJx80WItChLuBQapkYAUb3+BMMWKDMaxtEFFC6mU3+Qw9YS8NHi6BlhcBO+hkEQtNKy6MWe0jjItH6P9yOf4KnlPNtdyNkbb/AjPL2dDm2NHEb+uL4Zq0+fPAqNLFx+AtAraI693tLET+xqRXAO0gKsyfCmXuF1rX9ZS5ELcIxLxW3nMksVfZ2D/zoGSezv9d7CwXCmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhLZf+ynFo2w+ZY/lnEpt3X0l1aWd3YTXEJTBi5Nykc=;
 b=adLvnDNjVhJNpxGcUd5RJLGaf/D6toLTffPRyf3bEZQXGVJEeaMGiRWDutCNOTVCGREhYQBHoLsecEk0bE/LG1CO8/r7Si4Wuj2cEPdps4LLaL/lDqowq8f3d3ToBgvxx3jMq6hhPrNCG13ZL8Cst/+iNVAQSNYsMxuGV0wdSWt+ZL708On9cu2ORz9YD5+wSw5sYJN235UcdK5Zfe8cuqWY0dGhMXfTJl1GJzhUqeZ9VFSv0IoTa8nLiamx6K5fA1I+VYLBkTXNuUGdllU9rwAHkZSHGvmJfKRXisZJJHW95DZc/fhaF3Ut0XDIqmjXY6xaJ6o7rh2w/0T7WRb/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7167.namprd11.prod.outlook.com (2603:10b6:510:1e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 19:16:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 19:16:45 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 14 Oct 2025 12:16:44 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <stable@kernel.org>
Message-ID: <68eea19c7e67e_2f899100a8@dwillia2-mobl4.notmuch>
In-Reply-To: <20251010205755.205280-4-dave.jiang@intel.com>
References: <20251010205755.205280-1-dave.jiang@intel.com>
 <20251010205755.205280-4-dave.jiang@intel.com>
Subject: Re: [PATCH 3/3] cxl: Fix match_region_by_range() to use
 region_res_match_cxl_range()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c2d180-b106-49c7-345b-08de0b563705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGhFcFRtNG5JWTkzaHI4MTlvbXFnSVpUVjVMQmM3ZnpMamZKdGV1eTkvZ3Z0?=
 =?utf-8?B?ck1zdW1kdXhRNWhUdXAzTjJGWkUzV2Q2ZHZlbjZFaDZQYk1lUUFLN3BNelFt?=
 =?utf-8?B?WTFoNzhUSmwyR0t2elAvbWZxWmc2VnRZUXFJeFNTL2R1VDFPcVVseUNLN1Nw?=
 =?utf-8?B?bUpWalg3RXh6c0hZR2pwMnFpZDBFYmxvNWh2NEhEZXJyNkJ5QnFBdUx2UzZM?=
 =?utf-8?B?NU5xMldhbXQ0cytUVDVzRThaZ3dKaDhKQUdNSXZReGhPdWUzcm5kNnlnbUNL?=
 =?utf-8?B?Z29ielVFNkFHeURXaU44UVJmKytDeVVITmFLMHhGVklYZDNCSVdZWEtNNGZz?=
 =?utf-8?B?YnBSWGE4ck9qWE1NRXlFYTRDdE9qYTFFL2FSUEJPYlVTQXBVa25Eb09Dcmdi?=
 =?utf-8?B?M2tkZERRSUIvVzVCRjJIMDdaUVZmb2dXL09EaUVWWGhaSlF1RlQ4cjIxZmwy?=
 =?utf-8?B?K3YyRzBaanJMV3RVbFdYWUtET2R6SldsTEk2VFBUYVlMZEY4QXZOZ0tIcVI2?=
 =?utf-8?B?aHJpMm1yakxlWjdpV2YrTjJDbTkwWHB2L0ZFVER0OVl1ekI5V1huUzUrMk8w?=
 =?utf-8?B?aVorV0djakh6ODVmZnVjU2s0M3VrRzIzeEYzVUtMNVpxTE9UZ1VsOHRTcFcx?=
 =?utf-8?B?eXFnbnk1MHNQaHRoS3RYRE9PSnVuWGlUb2ZIdVNlSFNNTmRLbHNXL3A4TTJw?=
 =?utf-8?B?UnRMMlJQTFkyWkJ0OTJId1pyV0R2czlybTd3Q1ZFcSt5dXpTVHQzWFBUNmd4?=
 =?utf-8?B?NEw1ZmltTjJxV05EQ0JZTktudll3RUdqTGNhNEFiNDB3WGd6UmkyV01rb0Ns?=
 =?utf-8?B?ZmkrQThsYWIvZDcyY09UUXJCTzdMR2EyZTZ1VGxSRGRNK3psRG5LZktlTE42?=
 =?utf-8?B?RERHRm9JTzg0elpmRTdyTEpHaWo1WkpwNWUvS1lIdUpxaDhPb0lZUkJMZG9V?=
 =?utf-8?B?UFY4YjdwNHJzQ01kcEhCb0FqQkRjUUJPL1Nsc0lKRi9vanFTRnMzZWNaUkFx?=
 =?utf-8?B?bGtaSnl5c1JKanVhYkdiUU1kRDRoM0xIZGNXWEFnT0oyS1BWMndTYS9sVVJh?=
 =?utf-8?B?Rjd6bC9PUVRUZ3JFU2ZjV2c0Um4yV1BZdkhMVHpsZlErUmxZMGlmcG5xVEx6?=
 =?utf-8?B?OTd0aU5FMDJyaXhQa3NRTlY0TnZOSnhmU2FQRllRcnB2SXlPZXdzb1IvYUhk?=
 =?utf-8?B?VEdwQ1VORDJPclVzSXZYL0hLZ3Z2alI4a0g4MVJiMDVRM01lUmozeVJobUll?=
 =?utf-8?B?dno2d0pvZ1M3NTh0Z2h0eXQ3ZzVQVC8zSVg1M0tHZGlFaHllRWZJMERnMEs0?=
 =?utf-8?B?LzE3djl1czlqclgzMmFIZlBLQ1Nnd1F4R211QzFmSytnZzEvdDk4emRQZ29q?=
 =?utf-8?B?MEZnWUJsVUcybExUKzZVNTd1Q2FJTXR1a2FLTHkrWVpnSi9qbHV0ek5FL21S?=
 =?utf-8?B?TkZUQVZwMmxFeGNKd1oxbm5QY0VhOXFpWTJLYmR6SGtNNDE3U0JiUFc0bGxR?=
 =?utf-8?B?c2U3VFpObFZuOGpJNGV3UzRVV2VZLzBMbXJQRTNVQ0NIU1ZFcWkrbTBHUjNW?=
 =?utf-8?B?d2ZBSzNxRlpVaTF6SlBzSnovaC9yOXMwbE9nWEdaQVozOEV1SFdaTG91UEpP?=
 =?utf-8?B?T241cFZjaHlhME1kbmpvRWpGS1RYdW9CYThwQkNJb1VQVG5RVkE5U2s3MUZK?=
 =?utf-8?B?Vlh1d0l0cmRwMERRRldGWE9NOEhUamlTdWlXQk8wYUY5dHJIWXRPYU9udStS?=
 =?utf-8?B?RTl5TzZ4NlhyVVJBOTBMWDQ3b3g4NjJmNk11aVJOZ1hoYWJJaVBFQk5VclZT?=
 =?utf-8?B?L1ZUSVdTeXRJMGd2S3ZOaGNzaG1hcFh6REdRQUI0SGhsZnRlN0ZRTWszVU9M?=
 =?utf-8?B?VGRUQ0JSdHJ5ZHFNN3lFd0ZrQTlJVlRoWkNZZ0hUbkk4VVFrR0s0WHQveFAv?=
 =?utf-8?Q?FhbzcpQGpyBxICOYll7i79OYAiXzdHUt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmNvWEJNVGxWRmJ5RmtMM1JrOUFiYTh2U1hTUUlSNzJidmJWMWRwWjZuSnZY?=
 =?utf-8?B?TnY0RVFJcTJpcmx3L3RGSWI5TmJlRnYwOWh4elV5Q05FbmJNMHFBaTZPeDlt?=
 =?utf-8?B?R2NlQXArNm9EK3hreHVCSTEzNTVvTU5oM0drdHJ1RnFyRWhTcWtwMWVaUlpE?=
 =?utf-8?B?RkJMN2hYOHBEZU1GUDBZWFJUb2hEZ2ZtdFJzS1Y2SjZBc0RZNy9KREY0bjEw?=
 =?utf-8?B?VGpoYUJnbFY4UkJ0YytwaUZXSFJPeU0zaVRPM0hrK25BeFF3NHIyNDhYbFNI?=
 =?utf-8?B?VDVyaFAzeEpiRElnT3NkWlNteG43RE9RY1FrS3FTeXJIaVJrUzZjeWp2WWJT?=
 =?utf-8?B?cWk4ME1VT2NCY3Q3SUY4QjFURUkxR0QvcyszMDZ5ZnIzN01yUVk2TEV5dnlM?=
 =?utf-8?B?engrN2JvdWUxK1NJOHF5cmkzV1ZOcjZlZmJ4VStQTEJFd2dJV2dMZjdzNnpQ?=
 =?utf-8?B?cmdyWkthbkluOUMyZHpYYkQ2blhPVWVuVElIOEpzRFBKZnVYdHF1VTlDaGpv?=
 =?utf-8?B?cU0yRkd4djNIQkRIMEhuQ3pGVHQ4YTVzZlFyZ0w2NGJlT1NjUEJoN0Vyc3hk?=
 =?utf-8?B?YzN0Vkk2RHFhclhzSUNRT0g5ZitxYkVqQ3NPekNQWk5vTm5reVFueHIxaTEz?=
 =?utf-8?B?eTc5U09CcGNxQzVaUlppYTdTOGs0UUR6akFuQVFEZitreWNjalAwcDVoVFY5?=
 =?utf-8?B?WDdueldPc2xqTmwxRFpMeUtrWkEvK1NFZkpZcWIwcm5aOEZza2RtMmtETkNW?=
 =?utf-8?B?akNKdktvRkpXcVB5RnlTcWlVT3NRK3d0QkZ4NkhDK2QyUHduSnZBdW5seTI5?=
 =?utf-8?B?QXg2SnE2RzBKQ2lHMy9qdnVseXRMcURRTTB3QXZrd3FtaCsxWGhxaDhtc2xm?=
 =?utf-8?B?OW4yNHZhNjRidU9RRWh1bkhRUWNjRW1vVEU4eHZoUm9EWEk0OTUvcDh5WGdV?=
 =?utf-8?B?NXJIMVQxZWVuSjlSQmdldmRHVitqeWlaQ2lybDY1V2xWZFdxRk1NU1E3NUhp?=
 =?utf-8?B?eUc5WkVIaFZqRlNBKzlqTTQvWDlFOHh3dElySzJ1SW9KUCtaK1RDUFc0SWJZ?=
 =?utf-8?B?bzhacWM4c0NNdHBKUUpKNER6RWJuM3BWekpqUVBpYTdUaTBJM2FoYVJDRkRi?=
 =?utf-8?B?Y0kyRVViZ2g0c3JNOS9rNm1TR2Q1MEo3OTFGTlAxN0FBZFdiVG1Vb1Fpam1B?=
 =?utf-8?B?SjlKWkJOcG9IM3pOYlBlR3BEOGp6akYyUHpMMzJDd3JlZGVsbGNlRTlSR3Yy?=
 =?utf-8?B?ODVqeW5nL0ZRS0tqdm5IbEt2VERlN2ladXBVdHVLbiswV09aWEVWbGt0OWMw?=
 =?utf-8?B?R2hJbGs4bC9xcmhJSkJVTU8zaXlFUVI0Y0VoSSs3VTlndkVnVXlUd1hCUUxx?=
 =?utf-8?B?VTB4OUY4d3pGL3crOGtKcnI2VHUzUlRhWDRmQmlHVS8yWmQ0TStmTFYyekY1?=
 =?utf-8?B?MjJqeE9kUkhIUkFBNEh5dUdkbCt2MTV0eHo4eHZEOFpUelRKa1lMNWtOakUx?=
 =?utf-8?B?TFBlbTlEc0lPRGo3NXRFVmJjNDVSVytnVHBsYnVZMUxVbXpUb0R5WDVXNTd3?=
 =?utf-8?B?VWtXbEhNVmc3dml6T2liR3JuZEd3UTlyMmJ4elZNbEk4N21pRG8vTEpoby85?=
 =?utf-8?B?bE0yTXA5cE5rWmNxRllvbEROeFlKbEEwV2RRejkzKzlid0pibFJTNUd6ZFBT?=
 =?utf-8?B?QVRZWEN5U2tUZGhVK0NxNzA5c0JUODF2WnZHczU1RXY5eWJuV3EwVjh0bkxT?=
 =?utf-8?B?Zk1CeGRqb01oMU1RV0srWTY2NUQ0YkdEampFOTNXSUlIVy9SaElHUlZqYTU1?=
 =?utf-8?B?cW5vQWo0czMzWU9wRkd6aWRPUkJtaUtVeU5iVEFsQWZoRlp3QUtMQ3NHSlo2?=
 =?utf-8?B?aFF5ckd5ck40V3NETlBCWHA1YXhXODQvRFpuZWZNdnVWc2lMNlV3SlJiQUVO?=
 =?utf-8?B?eWJ0TUlXZHR2ajM5eE5DV08vY1RHb3Vody9IRDE4SmplMFhmWWlBN3Z1SXcr?=
 =?utf-8?B?MndpZzdSb3RBakRDNHFHR2NIRy84ZFBJWmVHWEdidVMxd2ZlZW03RCt1aU1z?=
 =?utf-8?B?S0xsMHE0YktFQkNJRWJBelJHMTlyV2NHa05GVFVSYkJhMlBSOVR0NTcxYUJy?=
 =?utf-8?B?Z1FZc2pNRUVDTjJJbFZOQ1RXQmVKOXI1VUJkc3dXYUJ0RWJBUjBPNGkxMjJR?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c2d180-b106-49c7-345b-08de0b563705
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:16:45.3723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMqk6/FixOdsARvdTwecmq6sliVDJJ1QVsE3lXgFP1BaYtwVmxJfJOT2hqwYpA/IvEdCCY9okD/jPo7+YAPHupXaARUOAbZR12QAPIppe6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7167
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> match_region_by_range() is not using the helper function that also takes
> extended linear cache size into account when comparing regions. This
> causes a x2 region to show up as 2 partial incomplete regions rather
> than a single CXL region with extended linear cache support. Replace
> the open coded compare logic with the proper helper function for
> comparison. User visible impact is that when 'cxl list' is issued,
> no activa CXL region(s) are shown. There may be multiple idle regions
> present. No actual active CXL region is present in the kernel.
> 
> Fixes: 0ec9849b6333 ("acpi/hmat / cxl: Add extended linear cache support for CXL")
> Cc: stable@kernel.org

Wrong stable@ alias.

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0ce50998c49f..be4521184328 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3287,10 +3287,7 @@ static int match_region_by_range(struct device *dev, const void *data)
>  	p = &cxlr->params;
>  
>  	guard(rwsem_read)(&cxl_rwsem.region);
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> -		return 1;
> -
> -	return 0;
> +	return region_res_match_cxl_range(p, r);

Below are comments for future cleanups / clarifications.

For this:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

I would never have guessed that a function named
region_res_match_cxl_range() takes into account cache size. Something
like "spa_maps_hpa()" gives more clue what address comparison is being
performed.

Additionally, this comment in region_res_match_cxl_range() does not add
any value to understanding the implementation:

        /*
         * If an extended linear cache region then the CXL range is assumed
         * to be fronted by the DRAM range in current known implementation.
         * This assumption will be made until a variant implementation exists.
         */

What does "current known" mean? Either the configuration is an extended
linear cache or it is not. If this needs to refer to what an extended
linear cache implies, i.e. that the SPA maps equal amounts of DDR and
CXL HPA capacity with CXL decoders at the high end of that SPA range,
just do that. Otherwise, there is no such thing as a "variant
implementation".

In general the future must always be backwards compatible and is not
worth a foreshadow comment to make that claim. A variant will require a
whole new spa_maps_hpa() implementation that does not break existing
deployments, but no such Code First ECN variant has been proposed.

So a future spa_maps_hpa() might be:

	/* Extend linear cache: <insert definition> */
	<linear cache compare>

	/* Foo bar baz cache: <insert definition> */
	<foo bar baz compare>

	...
