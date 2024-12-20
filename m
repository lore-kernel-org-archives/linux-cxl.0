Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79214225A50
	for <linux-cxl@vger.kernel.org>; Fri, 20 Dec 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734738985; cv=fail; b=mJuv8CBoQgOBhF0bJnRsinc4qYjhUVbg5/aEemGHd/pIlYdKsWBEBFgkWPUy6BHwc7kqFTSlGBetLXWx+klxQjd6Z+1kFyXp86Skgh+mTqx7F+cODVqy2Qa9EF6vD3Em/gjw5e60394dvn517colU1KLNyqXD33vWOYMtLO60Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734738985; c=relaxed/simple;
	bh=J4RxlcmDQWb5GP07F6EZRTgs27Uw/Ux0Z+qNNLnQO7M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g3Gk82bSSPI99LEfT1aiBsYt9v9UUBvNAQyyHYk204ZZqaFErak/kYBuwC+KW9eRjQjkzL+frrtQOpfsn4BWwNsmShZmHV7YNFdUQY4dKNZeUBFE141R9yo1wngD4t2C/ViclXew9Cl2JvLCECE9OtcDnq0fmZmMy294//sopUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhs9M0zy; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhs9M0zy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734738984; x=1766274984;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=J4RxlcmDQWb5GP07F6EZRTgs27Uw/Ux0Z+qNNLnQO7M=;
  b=nhs9M0zyvCCiICyg+7DZw1y9kFIYDs2YMiA9y2YPxvOvYUfim5f+FgdK
   wMD7pm8n0Xr7MXzHZO0XI9JAe2HOjdIloxYNXDWwS/lMZnPYq6a3LoeUv
   pr42hkJ38alnHbBt+Kyg7WWBJAfA0TgJpzlFKtMhmCPjwm6kKTzdvANbe
   A2Wsxu1IQilgtsfKBrVNMxxJB4jIz3MUNydBHDKVjyqfUxnsBT2UuH/bq
   wHyjz/Y3f3smHYUx75JwHoiJoMGwZMPBdad06DV+ts9eHPv9xZMxnDpkV
   sGycjASTJODuaMp57sdzLdapE9zehogAp6l0pcAoBC63Kzcj61FRu7x+8
   Q==;
X-CSE-ConnectionGUID: OT5OpsETT8aYR/YLCpmuSQ==
X-CSE-MsgGUID: iMoBNc3dT4GzlJYw6tFpxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="38979842"
X-IronPort-AV: E=Sophos;i="6.12,252,1728975600"; 
   d="scan'208";a="38979842"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 15:56:24 -0800
X-CSE-ConnectionGUID: Cza4VWE/TFmIbDa3t6UBJw==
X-CSE-MsgGUID: 5NpbdkEtREKtaIRnV9lrcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="103713979"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 15:56:23 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 15:56:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 15:56:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 15:55:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCvma1hwOm4AOzG/fF86nkU2sJ/eEduVyio9Dm2E2QziVkMPBEqMKt7Ew3C3lkpNnvgjYKg4K5m8OUcQcNPCOJSxycNewGMIn89my76xyg1v6RbOYkbOA8JQiKwmWN3fxvyKC74lstj18G2V+ERsAfAWFh5jDy7F4Vap/wBqSkjxvo2r+MqHGyc23t7bKQcHAbzgMWtgj8tjuv7JzJvp5o6CBMrxuLI3/zwwZocy2uB+qwpxwcamaELWah/xhfrbyLu8H9P9ldoCD/hajdaroZ+F3zEGNVlIVZMHhXE+15mppx3lWu4psrOURDmb25ouDYk0xfS0qe6lJ+EnmaxOVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqKvwvTCyuGWGTai4ZuTG4M0YqY2mzrQXrrdH6mSSAo=;
 b=N8x6UUsbktrgis3de27FgkjytmpNersRtlp3bq3Imrgomx2u5umouZpWaEinuYS7xfW73mupgw7/FM8cvgVUNBW1WcNygooQOHvgvPVUqJPD7YAtCRvQ0GmMQ6st5hhkHbu4lpUQ3wad6lB9NKowsNhdI41I5sKSRxu5A7I4MYrqJm28CIpqadZkxKRbT5EFDdl775vbgP4rh9lS5lKDFwy76a5LCxGyUmnnY/DO01zR6e+LQwTxRDQTaBzJ3dCVgwIZfLtBoj3QehE0iD6o2LLH9f6r2+qqGawUarB7/PqIaTPmvywUBMHFn3aVti97RFz54GRoqezq7NgzPxfzVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19)
 by SJ1PR11MB6299.namprd11.prod.outlook.com (2603:10b6:a03:456::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Fri, 20 Dec
 2024 23:54:58 +0000
Received: from MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::a7ad:a6e8:fced:3f24]) by MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::a7ad:a6e8:fced:3f24%7]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 23:54:58 +0000
Date: Fri, 20 Dec 2024 17:54:54 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>, Ira Weiny
	<ira.weiny@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: Vishal Aslot <vaslot@nvidia.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC PATCH v1] cxl: add support for cxl reset
Message-ID: <676603cdee673_2ec99229411@iweiny-mobl.notmuch>
References: <20241213074143.374-1-smadhavan@nvidia.com>
 <6761ae926757a_2a169f2940@iweiny-mobl.notmuch>
 <PH7PR12MB796800828DEC6E60D7C7C0F1C3072@PH7PR12MB7968.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR12MB796800828DEC6E60D7C7C0F1C3072@PH7PR12MB7968.namprd12.prod.outlook.com>
X-ClientProxiedBy: MW4PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:303:6b::8) To MW4PR11MB6739.namprd11.prod.outlook.com
 (2603:10b6:303:20b::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6739:EE_|SJ1PR11MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c1b2e6-4112-4353-ed76-08dd2151b57d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akFDS3lDTFUxdG8reVpoS3RkN1Y2RDJJS0lSZkdneEVrSVBQNGU1d3YzRXdV?=
 =?utf-8?B?c3BTakdlWFlNTXBaYTRJLy9JR0htcDg0Y28yUytaQXU3YUs1S05VZ2o3UEU5?=
 =?utf-8?B?WXdxMFZsTFZ0RElISzFRL0dCOUpxbTZENVlzUmdPYllQSkdtdm5HMmFpS0Jl?=
 =?utf-8?B?Yi8wbWNST1kxdVpydnVPUy90UFZ2NEhKekM5UUpOZXM5czhJWENldStWbitk?=
 =?utf-8?B?RHRsOXFXY0VlYlRHaUdiSUlXNDBxM2tqbDBJTjR4Y3UrNHRwMVRQMGlRRk5W?=
 =?utf-8?B?cXQ5ZVdZc3c5US9PVVFRNWJvYzQ2SGhTTktERWQ0MDhoTVl3TUpOVlNBWU9t?=
 =?utf-8?B?YXlxZ3NZanlpTUZQV1owM1M5eVhCRk10MkRhRVRSampKNHdxdGRTN0dDQWUw?=
 =?utf-8?B?dkR0QmdjYW00RmhsdzJ0SDNrRnpGUDJTQi85RG4wampqZ0tTSTlCa3lDSzFJ?=
 =?utf-8?B?andyWDk4bldua1ZMek5pcWpsVEZJaitqT1dJck41dkpMRDRRUDNJZ21JNFoz?=
 =?utf-8?B?VUV6WG9QSXVOV09LQTZ2M2ZsaTRtTlBLamthbXB5dTNSV3Q5UU56Qzd2cXFY?=
 =?utf-8?B?d1AxTFZLY0xmZkpDNzAxV0JidkRFSGx5d1VNMk4yNnY1NGdJWlczZzlvYnJy?=
 =?utf-8?B?TlR1bnBEcGcwaVpkcUdJT2xwZU5SMlZHOXhmM1VhSVp2WnU3ZkNNekxValkw?=
 =?utf-8?B?SjU1VW9yMzNEUnFTcUFuc2pDMVhDSUFyUTJCSWFxemo3eGVjZkxOYUpLd2dy?=
 =?utf-8?B?eGFFZTArL2FoUUFadFhCWFVYQkdaZVBKbXMzbitNOUdKbWg4WXg3SUg0czN5?=
 =?utf-8?B?NkxoeDhGblUwa3IxSCtvdEhGNjBBazZNamVFc2lVS1hOR1E4QTZ4TlFnQlBV?=
 =?utf-8?B?dzdlZEs0aUpQbGpWWjRSS0RXV3lVeEF1WnFsQzg1cENkS1Z5ME9zRkJEQUlI?=
 =?utf-8?B?aTBlL0RFQ3pYZGxTa1JHd3ZXR0kyV2FJa3F2VlYxY0lFenpzcTBONTYzU2l1?=
 =?utf-8?B?Z1NUU3hNRTNXa3ZzZi9ucEdwelJxUjZEMkgwOTdmUjhpb2Z4eUU2MDc4b0Vl?=
 =?utf-8?B?UmR5Yy9QcmE5T085Uk41Mm1qeENJK2lvZHRwczBSa00wOEFrK2NsZG1pU09j?=
 =?utf-8?B?c3dLYlZYUlYxMDJwN24zQitlOG5Cc3pqK0FVRHB0MktYWGJvMDZIb01yTGJw?=
 =?utf-8?B?N0lYb25kRnY4ZVBCZnZWdHRHa0dOL1c4Ly9Pb09DYzB2OFJWNmRzaFY1Qzdj?=
 =?utf-8?B?b1dNRmFkSi9XUVhZODkzcWpEMmJDSlZoYmU5OHNXaHVoTUFOYlBldW9IZ0dl?=
 =?utf-8?B?WGFSZm9jbTVrTDBzbXFXNVAvVllLc2ZlcVNNVi9GYndLSm5pYjV5dzhudU1F?=
 =?utf-8?B?M0I2SjVwSEZZbjJiNUxlUTdSa2c1YncrQ0VDU3F5VW5PZlEwMlI3U0hSZVhh?=
 =?utf-8?B?Vm1TKzl0SThWb3JjZEkyRDNxcGVFOEZOSW5jNFlscEV1bHJ4SEQ2SFh0VHFq?=
 =?utf-8?B?ZTBiU0NJUWNzTlFqbDBMMVF5L1FZVTdaMGN2RUNKT2JLbU8raUE2b2dSQjNX?=
 =?utf-8?B?TERrNjBNN2NFbEhPbzlaYXhkQjRVcW9aT015OE1QOW1zNjZGeDIrVjhNMlVJ?=
 =?utf-8?B?Umo0aURzamk5LzJPV01LeVJJSG1BTjN5dHAxQ2V5RzlRbUtKOVdPM25pSXVV?=
 =?utf-8?B?UURtUEdjZ1M4WjJldVpRNThRdXl6UEFmNElYSnZJUnJEdXk3QmE4OTRIeHQ5?=
 =?utf-8?B?T1RHUU5SbFQrWFh2WkVpTWRLN2lZcDhjemJkOGNKRW1Kdyt5STNOeHhzVlpr?=
 =?utf-8?B?VWFtZTRuN1JiZ0Q4SlV6dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDlLa25kS2ZVbTNoUzJramlBVXQwdlFzSmV5R2RvaEtEeWVwYTR6ZmlkT0R2?=
 =?utf-8?B?NlBSUXFaTmxNUjBSMHZER0lNTm9FOCtVSjlCN2JaaWZYMmtvbHRudnBOendG?=
 =?utf-8?B?VE8rWENxK1BxUjllRjc2T1ZpODNyTmkwdlRjR1NZbXgvZlk0TndSeDVtVmRE?=
 =?utf-8?B?Q2hNR0loM01HMmJVdnV3bEprU1RnaDh2bnJtcEhWSXRRcnVmOFhSKzRpVGJm?=
 =?utf-8?B?M1E1WElmRC9STkt3Q0p0ZGpTd29wa0dKbE1HK0JXQ1NmK2lkNFRpNDlaV0JD?=
 =?utf-8?B?b1pjeUFFb1dGZGdkb0tSNC9EU1lSQWtyQjhJM0Z3Wlp4ZlFwVlR4OTR1U2gy?=
 =?utf-8?B?b3BmeVZzTmxseDFrM1RPN3VtclJBMzlDQ25EWUd3Skt6bUdmaDZNaldoOWhh?=
 =?utf-8?B?TGhwV21FaUhQMnVoV1N6eStaUVEwSDl1eUtyNCtXNFdGdXl3SEt2RGRnV1Qv?=
 =?utf-8?B?TXQvQXRMTU80QnExbk14QVIzeXRjOWxuZmtoMGpWdGRCUWNiSHRNM3l3cWpR?=
 =?utf-8?B?Mk9STzdFcDArdFpyMmJLOWc4a1Q5NVIvaEY5M0lHYi9QTzdMajh4aHM2Wktt?=
 =?utf-8?B?SkJ2SEhiVFY4QzR2ZUpacDZUOFpJMkU1azB5bDM1MkdscDhFVDRXd3J4NmE4?=
 =?utf-8?B?S053b093QVQxb0ovUVI1aE1nOW1RdER2aFl1MklmUFByRHJHUWhqSjdEYm1L?=
 =?utf-8?B?T0V2ZFZ5K3FyQmdDVStlbFp4SmRXa3hlTnVNV0pVQnZCVGZyS3dhb0ZGdDNa?=
 =?utf-8?B?T2NlNFhUUmVaOWZNeUxiN1NaWFFlT2RIOE5HZG5ybW91V241Nld5WCtVRVQy?=
 =?utf-8?B?eWw3WDFQeGxTS29PdlVZdFpjNzl2MDZabU41SG1QNHRHcndZT25jMHJSZnF6?=
 =?utf-8?B?Q3ZkT01JY1NHcURWeFJ5V3ppVjFZSi9KaVJrYnFCNVU3SDhneE1yM2E2aUVM?=
 =?utf-8?B?N3NWNjUwM2FXQWdOSVBDN0lKMDNhUjRZM1FaVmZSUnBtRGJCeDAvNFBRUXE3?=
 =?utf-8?B?WkdObGFOOGh5eVJDS2hibktvblJzNGhQQmRsNmlXNnlkdFRpbzVlSldwYSt0?=
 =?utf-8?B?YWoxTGp0eHdValk2YzRvZ1Y1KzF0bEswbVpzaE8waWRNMFRTQnhjOUwwQnZz?=
 =?utf-8?B?bFVWYW10VEFiMXk4cHJldUxCV3czc2JRUFEva2hXQUp3MDF6NjNFZk9yaU9G?=
 =?utf-8?B?RE9uZW5uVGZabnJteGpYcTdlOUV1VEZiaEJEYzc4R1g1LzI4RjJiN25hMzdL?=
 =?utf-8?B?WTNUVFdvRnhsS2dlT3lHYStrbGdYUklZNE82d0hacHZESXE2MlJxYlRYSjNC?=
 =?utf-8?B?QXNCeWk4RFdKUkhieDVHU2VmZUpZL2ZETWNtRXJhZmtIWkc3bHAvdTRhTGNt?=
 =?utf-8?B?Q0o4a2Q5eXg3aW5HbUZMRGM1bU51UERqWWU2UjJmT0dxbUhPaS9CR1ZDNXhm?=
 =?utf-8?B?N2xNSjlkY3k0N1JIdEVRemZ6Tkg2UlN4ejJ4RUl4RHRYYjdRek5iNER6Ni9Z?=
 =?utf-8?B?UExHVnBCNEgwY0VlZ2tLbXZyNmFFdDdTNkRudXpxaFNCcEpRbmZFeHVMTFFo?=
 =?utf-8?B?NlVMbFpkNi85Mzc1eC9ubXBsY1E1MmJjVE5LZzIvUVYyZkVVRE9Pem9pQVht?=
 =?utf-8?B?U05jUlNmWTl0NFA4dUFFTUwwKzVpbjlBTEorSVNyTjZ4dERYRTRHb1ZWd0R4?=
 =?utf-8?B?QzkvTUlVVzk5dXJ2eHpJS0dGeWVqaVVYdzZ2RFU4TzZ2SUI5V1YvY3h0akdR?=
 =?utf-8?B?T3NXamlCVXdCeEx4ZFJyUHI0Q3Z0QTlFNmdXNmdrWi96aGFNdG95RGdXTm10?=
 =?utf-8?B?SkUxOEpSOGlzZFJqZE81YzdKVDI2TUlRY2xUWjM1ZjIrcXQ4NEsxQkdVR3Jy?=
 =?utf-8?B?d2hiL3hkREpwbGJrSTA2Q0tYMWs5SXI3NTNXbm5lSTVGazdFQkZEZjUxbFNZ?=
 =?utf-8?B?NnlhNVdZQjAwbHpaTWl5dTFFUFpoOXl6UjlBd1pmYnJoVlZNOUdKN1pHVW9U?=
 =?utf-8?B?Y0crZmpIODFPa1dhWjc5eWZtVWFrei9MUU9wMC9kY2d4L1o0TGZMRUZtMVVH?=
 =?utf-8?B?cXZydGQwa2QxOW5XNzJJWFUxamFuVWwrK1BEemR2MWFIV2dQUmtYc3lqeFpp?=
 =?utf-8?Q?RNRJIm7dJWuYDVL8JkJCsu8LD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c1b2e6-4112-4353-ed76-08dd2151b57d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 23:54:57.9474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9aRp9dYNmbXfCJF3ivNO53CeHJIfJdGDqZpLudNZFoEOKe+j1IbKnDEevSEZNRM4/S/GOLMahRluuQt+X9sOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6299
X-OriginatorOrg: intel.com

Srirangan Madhavan wrote:
>  External email: Use caution opening links or attachments
> 
> Hello Ira!
> 
> Thank you so much for your comments. I’ve added my response below.
> Apologies for the slight delay.
> 
> > Srirangan Madhavan wrote:
> >> Currently, there is a lack of support for the CXL Reset method for cxl
> >> devices. This change adds the support and implements the common reset
> >> steps as laid out by the CXL Spec v3.1 Sections 9.6 & 9.7.
> 
> > I'm not sure what the use case for this support is.  Do you have a use
> > case in mind?
> 
> I think that this change would be broadly useful due to few interrelated
> reasons. Without the change, even if devices are capable of CXL reset,
> users will not be able to access the method. Considering the changes
> to support type 2 devices are being added now, there will be more such
> devices.

I see use cases for type 2 for sure.

>
> Adding the support would enable cases where more fine grained
> reset is required than bus reset methods/conventional reset. And FLR does
> not affect the CXL.cache/CXL.mem protocols. Spec also mentions cases like
> FM uses CXL reset for rebinding, error recovery. So I think that adding this
> change would be useful for all devices with the capability.
> 
> > What happens if there are current cxl regions mapped to the device being
> > reset?  I don't think it is enough to flush the caches.  Section 9.7
> > talks about system software requirements for the HDMs.  How are those
> > requirements met with this patch?
> 
> Sorry for not covering that. Your & other maintainer input here would be
> much appreciated. Since “system software” here is not very specifc,
> my proposal here is not very specific as well.
> 
> Considering different platforms might have specific operations to
> effectively clear the regions, some type of optional helper routines in the
> CXL core would be appropriate.  This way if required, a Type 2 device driver
> for example can choose to use it if required.

There are a couple of ways to go here.  For memory devices I think this is
on the user.  But I don't think that is a primary use case as I'm still
unclear of why a user would need to do any reset of the memory device.

For type 2 devices I think the use case will be device dependant.  The
specific driver in that case will need to tear down their regions (with or
without user space coordination) and then issue the reset.

All that said I think this patch belongs with a series which implements
some device support.  Or is more general for type 2.  Which is what
Alejandro (cc'ed) is working on.

https://lore.kernel.org/linux-cxl/20241216161042.42108-1-alejandro.lucero-palau@amd.com/

Ira
