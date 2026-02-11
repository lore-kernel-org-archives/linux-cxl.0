Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D3E34402B;
	Wed, 11 Feb 2026 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770828272; cv=fail; b=Mj+X4nQAyQk5MnelPTsCMIR+rgFTzW861cXq/3pLeL+fXw4cr66WVaSVsz2qRMW2EHGE5RpkUEoH5U6zjyb7DUfd4DibyPROiAUY3XNzLY7dRBqGt/6rsGBErEuw49IK54dLOKf4i0LCfQnWpDfFm/rh7UFVm2R3VvDZhiGYVE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770828272; c=relaxed/simple;
	bh=TBLR5OZLdjoA2hZAEaFUH8TwUXyAm6z0BZdLhFA8e6E=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=YMrC2kljxLdo73xohIJSvBCYqW/6CseN7BH22RDREZOVmIQQCjJHPM0DjngOMMEMebVqpC8b3DRnkB75TwgLwexcJ1aM792msZTCbpXuIOp07wYa24zaslnYhST2/8EITzVHyxACXL3h/Bxr8Hgn6WR67B/60dRqco47vn6WTew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hxs5NCNl; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hxs5NCNl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770828272; x=1802364272;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=TBLR5OZLdjoA2hZAEaFUH8TwUXyAm6z0BZdLhFA8e6E=;
  b=Hxs5NCNlv54NKZmrodnvVtrxpKBMWPu7liKa6ISPaoVhb67ael4yd1fk
   sSDbSplJ/FhjWnsSU0M8y4E/X/ki2uRKvNSn+BcdkD6B9TiDgxPOjYORa
   3tDnNpkTfIJQbVjduqFglaYsZIF3hGVu348KCxxKuEod0SlPkf0j6Spat
   rD2IYPD12O74YV9Hp3OKe70qMlj27JYF76hb6d38oJ3d/n5TqTam9TJNw
   8pGsGyyaYVPpNpqEVeoj5R6JNH99xtyTkfhalJGb+0xxspstrIALmRhvY
   mqHpP0SwYq4gvjTOMo3NVajvlaOwGbSLZgCW2+FXuLwr69nGVxSwg27UA
   A==;
X-CSE-ConnectionGUID: 5JLsplP4TKu2aaDCxTF47Q==
X-CSE-MsgGUID: QYIjNE0VQpm4Wiq0+EPAmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71880498"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="71880498"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 08:44:28 -0800
X-CSE-ConnectionGUID: COf82hOzQTevoS0LDulRPA==
X-CSE-MsgGUID: qA7MpkCWSeCdAjzoodjtiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="211888988"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 08:44:28 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 08:44:25 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 08:44:25 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 08:44:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrKLusYxFJDwTusaxPR+anK9ZYscgsL9a4ERtgg34Ef/Em96aQTYiUlHLhabV6jKGpu9SvIuJawGuHg0fl/F+wt1qwVn/IXD0F5N9sfyzDrcleoi8xRY1qGuY3RyrwYyk3ALGN3b/bp2Baip70RFtLYNWUPkgJL0kPTAw27hB11YPamXlF3m2FnBeiRLDdyptbYZ3yCXbiCAGJvsKkWzztLlCNxjhsEcAA/eB37m1b/og67xSmVgIncvojtHoLosCnZV10BZrfMm4lTfl72+X8h7r4rxzfhozOil57y+V7AWsusnt5Nxlik16vjaa6oF6nbJ57Tzhp23nT9EE7aHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6/pV4cqC6UE26LyqqBf/zi2JdwoWK8504iGHetuJdA=;
 b=zU/VW9qXQgKz2ooVzvk9j23tsBAsOvNTYbPEXjjWmhJVk2qxGEiBH9wY7Yal8mCv9ihv+i4SGBVZ2vItVFoH7PkpiAa9OrkZG4l5O821OiPLC6A9DD0STSHqe0ceJESVk9lK0foLaos8uGA3GqZyMjN2dR1CjQdn5df68ERGJm4r3+r2mDO+muvEkYd9NbQ8NM/n7BJCJYtz8xTCijnUXuMxRkfgrM/b0gj57P6txVUAPcSZm9DEvP+YgrOA5G2Vi6ZkEj3oOVPzU6P835J+ISgKXDiM5cHCz/EnJyfmj5Mdv8d5Waxi4ZS6zpcTfjb4F9pnWs65ZMvKTF4cRaSGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB8236.namprd11.prod.outlook.com (2603:10b6:610:184::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 16:44:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 16:44:23 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 11 Feb 2026 08:44:21 -0800
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Message-ID: <698cb1e536bde_8c3210028@dwillia2-mobl4.notmuch>
In-Reply-To: <20260211151601.2082584-1-gourry@gourry.net>
References: <20260211151601.2082584-1-gourry@gourry.net>
Subject: Re: [PATCH v2] cxl/memdev: fix deadlock in cxl_memdev_autoremove() on
 attach failure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:a03:332::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f944acf-7928-4f69-a1f3-08de698ccf4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T083V0VISk8yWEFHZVFLa2h5Tk1TZVFEUmRyM0w0V0JUcDdFQ2lBcm1Ld3JL?=
 =?utf-8?B?QnZ1LzR0M0xUQ1BMazh0Tkl0V0JCZEVBL3E0RU1hZTdrWU1qVUM2K1hGUGtU?=
 =?utf-8?B?Z1J2STdMQjdnM3BEL0hzd2E5QzVDTkJucEIxRjJlNkgza1kzMlR3QndEUkow?=
 =?utf-8?B?ZnpNK243dXNMY3FoeGRiNnJrbEROam5aalQ5TDZQYzE5WlY2V1U5M3ZmcTh6?=
 =?utf-8?B?eHdwVEZmMU9DdGRla1ErM0s0ZklzRmVXdnZnS2hwbWFrZUdPNnc4aXpaakRE?=
 =?utf-8?B?NVRpdVFGaWRTZW1YNEF6U2l5Vm1BMVdteFV2L3ZQbTgxb2wwNFEwYXpsUDlx?=
 =?utf-8?B?RXQrNjJYUndIT2FTejVQclFRS2dOd0RWdlY0T3QyNHBpTDc4MHIyZXNUaEJO?=
 =?utf-8?B?K0Rwak5sclBydlFvZGdLZUplc2wyMXI4Y0JiY1UwVEVBa3AwbUNLUEs3bExz?=
 =?utf-8?B?QWdmdXk5NE9GU0wydVdPK3hGSm1veDEzdHVMTkpKeUdLL0Y4N0ZuRis5VE5T?=
 =?utf-8?B?UzVSUjlUK2dObDlTTW5GbDdUTzVhMCswSDFJOEJUNnZqcTB5UGZuZWJKclp3?=
 =?utf-8?B?L3hOV3QzSTlOWUFwSDV5c0ErWXFZcWphZUxJQWJwVGxMVnp6S2xWM25LYmNU?=
 =?utf-8?B?akZDSjZBZDIrd0VtNTNWUjBBbE10WnNpWkdsZWs0ZFFGWVRmSmV1NmRuKytF?=
 =?utf-8?B?Rk9TbzdpeTRpWE5wVkxtYlpnSmppK1pYNXhqVmw3Mnh5VTlFL2o5VkQvSHor?=
 =?utf-8?B?NEVpYTBnVWRCRUY3c3RDOC83QTBUUk9iZTg4aU9FZTZaUWNuS3JCN3hBWWFF?=
 =?utf-8?B?ZnhBV0JVRm1FaFl4aEVYMmM0TjV4U2kwQVpBbmo1ejI4VDZSajZPM2xVcUUz?=
 =?utf-8?B?dFNjYTkyclFPdVhjVGJIZ0pmS1A3R0ZoeWh1bXptNHB0NWhSM3JtbXE5VmlW?=
 =?utf-8?B?d3NzaXZwUHVxZGlrSjQ5WW1McVRVWlFqMzFGRjhOS0ZPMmI5SkVkdGtzbVYx?=
 =?utf-8?B?b3RPUmRJYWp3VFZDTWVFS1I0NGxnb0h1VW51RUdnTC9NbFlDbVFUMmVpNERP?=
 =?utf-8?B?ZUtvN1FvMVFyNlp1eTBJZ1BYNEdGWGY4SWpCeUFoYUFvZWZ3N0dkRjRMNE4r?=
 =?utf-8?B?NlRhRnAxVWVuUEJNTWpvZTI2a2tZK1NObTlwMm5TM29vL0hnRGNteTZoYXJu?=
 =?utf-8?B?WTlsdkphNmc1MklGa01BNEk3YVlWK3JTTW9DWmlmWTNuckhOWHJuWWl0bUx6?=
 =?utf-8?B?dDlyTUNteVRTanBlS00vUSszUUs1NTRXZmxWUm45WkhRUzBpdUtiZWp5NHh6?=
 =?utf-8?B?dEFyTXZmVDkzTmxjaDRzR0RlR3pRM1hvYlBUcEFDenRoWHdMSmtJeENhNDY0?=
 =?utf-8?B?aE9ZQ3dLOVhCQjY4WHAreWs1b1NHcUNHVE1nTlZtaFBxODJPeVUwN1B4Y1Z5?=
 =?utf-8?B?NXBUU0ZLQTVGYVMySTd3QjhrNG5qTi9hcmJVQVZnaUs5bGhyMTI5azQwQVhy?=
 =?utf-8?B?TFVheDl6Tk9zTXBQTmV4Y05pcEY2NVpaMzBaYVRJTmhSalcrRlBqM3ZyenBW?=
 =?utf-8?B?RkNXS1FZVVBUc0V5OHRUcUpHb29uclVJQXJnbU4rKzI2Z1BrTmxvZWo3NlNP?=
 =?utf-8?B?cCtQa2p4YStJK01zVG5obVNudWp4UlEvbldJUHR3d0hYY29wZjJiVHN2U0pv?=
 =?utf-8?B?WE9NWU52alBzS1VPL2ZsTDNyTzI5MTUyL0Y0b1NOV0J0cExCOHFLZHdZMTcz?=
 =?utf-8?B?eVFkY0d2UGNOSFpHZ3pSMHZXZkk5RG1HZE9USjhoNWplWDBzWE44VjJSVDA2?=
 =?utf-8?B?VThnT3F6eER3YU5XY2Z6YmxBSjRNeWdJT24raUttR0JrYysvVzZzVXBrTENV?=
 =?utf-8?B?MUpwTzlYNkdQMm85RFFLNEtncTlYcGlJU0V0bm5Pb2lUbXRLSi9CNFFXbmlC?=
 =?utf-8?B?alhYNG9iV0x3M0dIS24rWmlWaE1oeSsvTlZET0xUdlAxYnduQW5IOFN1eW5H?=
 =?utf-8?B?QThPVGUzMzlWZFBaUkNncWpPWnQvRnBoMzRnWkNHWVkrVVE0OXVqaThsWlhl?=
 =?utf-8?B?c25kZDVNYjJCVmtSbDJPU0dmc3hXQVprbFNDS2VpQ1FpVVlBR1RiYlJhS1hS?=
 =?utf-8?Q?WWCA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWxqcVJmeG8rUm15Qzc4SnBWMHN4WXU1Qm9tc0xNTmpYb3RJa0FkMGxFNzJn?=
 =?utf-8?B?ZWZ1RStMOGkvZDZtZGdpWHFGY3F2dXBBdnExQzNqcXhicWRyMDkvRDF0d1Qy?=
 =?utf-8?B?eGtGendrdFNqVFJncjNzK3RINVU4M3VscVRvVFo0WlNWQTFtbG9WeWVjTGFj?=
 =?utf-8?B?VzFHZVMvbmNzOGpKcCtBTjRDSUg4djFESXVvMG03MnVraWxEVEM5RysvUTRN?=
 =?utf-8?B?bTVFRTdpNEpvMDFjbmU1R1FBdkdKUjh6dGozQ2xCTXNZc0llSmgvSFBGNkd3?=
 =?utf-8?B?dU9JTlFDS09nSU9oZlp6M0xvYUpCODRNRVlxbHBtOVc2NVB2NGZtdDJvK1lR?=
 =?utf-8?B?djdLV0dkbDZKYlE0OXh6UnU3Qkp3dFZMR1ZpeTl4ZFJxeXhBRmM2Y1dPQkdV?=
 =?utf-8?B?dkZobVJvWE4wbHc5a2FRQlIvWmFZZW1Wcm1uTkdlVC9HNnpqNzdmU1VkbTN3?=
 =?utf-8?B?WUtJQzBOTGlnODJRdTVkZ1NKZm1JaEJaRTJQdXpOZkRmd3VFVUFGZnBqOXUw?=
 =?utf-8?B?TGhEWk11UldUNzdvN0NqM0lsekpZOXNRZWtVYmMvenYvb04vanBwM1ZjRktz?=
 =?utf-8?B?cEdYcVRGaHFVeVYwMS9BWUl0aUtpeEtMNXp3Z3Q0SEc3MVArWCs4SXE3SCts?=
 =?utf-8?B?MHBJNGlZRkRrYWQydHdlMTJub3ZXVFREbHo2ZGZ6UnZkUDVDUE8wN3NHc3RD?=
 =?utf-8?B?VDdiV3ZPNzh2RjVrc0w5Ly82clNobFlkQmtDRVptM0hsa3pYVlhIV1lCcHpB?=
 =?utf-8?B?citiOWE2SzE4RHZwTDBGSmdPOHV4ZFZGemkxdFpqZW5UVGUxQ0dYNjJLSDdu?=
 =?utf-8?B?RzMxcU9kTGlNNXJFQlNVM0ZwdnZqTmE4UGpMR0UvT3kzb20rUTZrSU1QamRm?=
 =?utf-8?B?Y281TG5NeFZjK2I4OGdWWVQ2dTFOSlYyUFdzYkNLN3Z2cjhwNFdvS0ZXdi84?=
 =?utf-8?B?UStWZE1lcTRRNlFYUzQyNzJMZ085UlRST242VkZvM2U1SEg4RzZzTEhNRjlk?=
 =?utf-8?B?K3VrZDVWS2k3S21qU2t0V0ZkZmpxMDhQWmZTcFFWdU9xSUJrMWMrSEFyV3o4?=
 =?utf-8?B?TGN2b0MwVnpZS1cvMWtNNGtCRG9ZNzN0TkNlYTROdG9GbkJMbEtTS1JWMlJD?=
 =?utf-8?B?ZXJxc1RKVDg3RzFpRG9ORnR4N21ocVdxdGdlZlJZWTR1TnZicjRBZUhZZEdH?=
 =?utf-8?B?YkFjVlkrR3B2VEJKUUdsSmRGNVljZ3JPdTI2Wkw4SGlGZFZ5alVVa0xCdzNr?=
 =?utf-8?B?MGhyeUUrd25UV2xJcmEvU1MzMlN0UW1IYmFTQ3BSTldNV2lwakhkVjhqYjhK?=
 =?utf-8?B?aWtWczJ2NXJnamRxVzhyZEdnb2hWNDRFbVhyMGNJeTdJUXUrbWI4aVIxSzRt?=
 =?utf-8?B?WVQ2RlZ6TDhMaGYraTRhaDNGa2xBMmxRUFQ3Y1Q4NXN1ODBaTnZBa2JnWGVx?=
 =?utf-8?B?ZWZTM2Ywd0d4bDdLVzk1Yy9IeUJyWXFSa1JxNGdyb2FFbkh0YWo2S2RsbG1r?=
 =?utf-8?B?d3VxK0YwbytsdG52eGIyQUs3R25QTmE0cjl3ZUROUDRDUE5MY1hPbnZxNlQ1?=
 =?utf-8?B?SnYvOXNXZ1F6eXdOYVlRcmtjUmV1TE96ekIxdHpxeU1KRnFiK2l4enJoR0Fl?=
 =?utf-8?B?MktpNlZsS0JqeUoyUnh5aGswaXJLM1dPYUYzMW1XY2psemxhbnFjZTlPTkhW?=
 =?utf-8?B?TDlrenI3VldYWVdWNlIvUnc2U0k1cEdQVFpOZ3JQQ3R2bzkrNFZ0Q1M3UWNZ?=
 =?utf-8?B?cEhBTHpya0kzL2RJZis1K1lkNnhpNnQ4dmt0OURhQkw2ci9vREJmTVEwSWFY?=
 =?utf-8?B?MG8yTzdLY1RxQ0Y2YnUwaXBuRUQ0bHFoTGoyWU02b0MxQ2N0TnM3UHJXK0pB?=
 =?utf-8?B?ZnRDMVV3NDZkaTJuR0RzcUVjUnJkdnNUcjY0enQ2UHA3L1pLK1BRbmRtcHFn?=
 =?utf-8?B?RHUyREgwSS9tcnpSOTk2LzhDbXZGMGVlNE9Wc2tDSERha0RMdytxQS9hcjg1?=
 =?utf-8?B?RVRRY3ViYjdNcGh4WjYwU0RPN1VITVYzejVnSGU1UXdESFl1R212Um9RQmMw?=
 =?utf-8?B?SW52aFFobFJ2VnYzak54b3Jaak0yUjhUd1dIL0Q3eWc4aUJPeHR3cHY2aG9n?=
 =?utf-8?B?NHIxS2ZWMWtXa0ErK25OMWJXZUgrTVVCQkhzZDNxR0FBYXgwTGZWd0VwdnZQ?=
 =?utf-8?B?bStlSE1sOGYxVllxL2cwNzFHMnFoTmM4Y3M3WVBmM1lYYTNiS1RIUTU5dktv?=
 =?utf-8?B?dzFkaVU1NnpLK2pyTHRoL3ZWTjU5cndla0RSVlFKSFZKOXFhd2NRYk8wbzNo?=
 =?utf-8?B?bHV2YVFUUmdCWkppU3FJZFRQSGxOQ25hSTV1aVJleENkQXpucXhQVG1kaVJZ?=
 =?utf-8?Q?rNzw+fDert4AAI2o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f944acf-7928-4f69-a1f3-08de698ccf4f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 16:44:22.9648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNAVIDEy7WuGilKvWvPtV/9I7df7zv0Y8efsYQJsFroVZFbkJ+OWtNHwRZ6Eg098AZAIjI1EFU4CwqnsdtwJiQaXgmNSzPte4ic4AMyKf7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8236
X-OriginatorOrg: intel.com

Gregory Price wrote:
> cxl_memdev_autoremove() takes device_lock(&cxlmd->dev) via guard(device)
> and then calls cxl_memdev_unregister() when the attach callback was
> provided but cxl_mem_probe() failed to bind.
> 
> cxl_memdev_unregister() calls
>   cdev_device_del()
>     device_del()
>       bus_remove_device()
>         device_release_driver()
> 
> This path is reached when a driver uses the @attach parameter to
> devm_cxl_add_memdev() and the CXL topology fails to enumerate (e.g.
> DVSEC range registers decode outside platform-defined CXL ranges,
> causing the endpoint port probe to fail).
> 
> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/memdev.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index af3d0cc65138..281acb3b9abe 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1089,10 +1089,8 @@ static int cxlmd_add(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
>  DEFINE_FREE(put_cxlmd, struct cxl_memdev *,
>  	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>  
> -static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
> +static bool cxl_memdev_did_attach(struct cxl_memdev *cxlmd)
>  {
> -	int rc;
> -
>  	/*
>  	 * If @attach is provided fail if the driver is not attached upon
>  	 * return. Note that failure here could be the result of a race to
> @@ -1100,7 +1098,14 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
>  	 * succeeded and then cxl_mem unbound before the lock is acquired.
>  	 */
>  	guard(device)(&cxlmd->dev);
> -	if (cxlmd->attach && !cxlmd->dev.driver) {
> +	return (cxlmd->attach && !cxlmd->dev.driver);
> +}
> +
> +static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
> +{
> +	int rc;
> +
> +	if (cxl_memdev_did_attach(cxlmd)) {

Oh, looks like the polarity of the return is flipped from the name. So
either:

    s/cxl_memdev_did_attach/cxl_memdev_attach_failed/

...or make the return:

    if (!cxlmd->attach)
    	return true;
    if (cxlmd->dev.driver)
    	return true;
    return false;

...and the make the check:

    if (!cxl_memdev_did_attach(cxlmd))

I am partial to cxl_memdev_attach_failed() because that avoids the
ambiguity of the !cxlmd->attach case which is ok with "cxlmd->dev.driver
== NULL".
