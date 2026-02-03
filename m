Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B3A1CD15;
	Tue,  3 Feb 2026 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077204; cv=fail; b=T+xfILhQqPCBaaExKa+Ny50NYT9Uuu3c4tej5mh5GPdADw9Qt6LK+oh/OLZu9Iku+0MSsi9vF2yp9FpETY4oxCUoHbkn7rbLUyyGKOObWBp9blAWFKDBRS8G+3km4NmRhtdo5F6F4ID+XDgUGr5AT9vPxJkiwTQ8XWcz1XoSHZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077204; c=relaxed/simple;
	bh=LCUk4PWaYW6fmvIryCubk0jl6CqYAJ2Mb0tB2va8/oE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=raB8h+6EU9CcgMkyTdB1TopGk7MfNbNJrOK+BhHP0tlz/3vp9A30Cn1rTyauHwQI0HRM5fdezmOJw/5BR2lr/CfGuo86qY+FNrSnh/ANb2tjBsHnQxuNOyxauJ9rSprPZ7C8Z5LQOtZyZztL1ao+jSVQDzr88nAXLlSXDMF4HaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YyZwgBx5; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YyZwgBx5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770077202; x=1801613202;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=LCUk4PWaYW6fmvIryCubk0jl6CqYAJ2Mb0tB2va8/oE=;
  b=YyZwgBx5eQfgPScjoTDangjjgSyYoo0yX+IM5hnaikUmsNoY+AdGV+3i
   mkFIn63Mx14CBS19KMU+2ivoofW0Skl09JSzOez4IIZIFYJB1127Z7ibS
   WpurJ34DGrq5pbmhl7w8ET9amr2pTVcxYJaleD5UGwMoSIL/m3LsT8MCc
   /Z1OCrqV0y49WpPtGIex6IWwEDbkeZ/6MTVEgkUXTOHbY5PbJj6ELDNt1
   A7IWlGG/hSFm8PzCresCoHmHRgMb/4BkO3fAKlF8Yi3XwFBONFd7INBat
   drerEXg9t4uqg//CLWTfbn3sYdfXn92JyL1K9NZexqHyBc+2P9SSS5AzM
   w==;
X-CSE-ConnectionGUID: dYPS1v8RTuu3+HH9VqroKg==
X-CSE-MsgGUID: yMIhuQd4SZKlBZXa/8WSEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71143723"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="71143723"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 16:06:41 -0800
X-CSE-ConnectionGUID: 5TI41KU1RTCe5kVxbYh4Ug==
X-CSE-MsgGUID: Z0si2tk7SUKtWIAEI4xpPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="240725204"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 16:01:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 16:01:15 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Feb 2026 16:01:15 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 16:01:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkhBpShz/Z+fbYIanVs1c+JsYYexlKkbawGrONX9wRCGMtudOV4DMZzxESA9CpGxbiPVWWKt9LCOn9l1jvJuCCPpQJy0mzlisuOba0m7PhRXEIhzTUi2L3pSiewRbTUy7MzqqDxJzZ6cVOy/cul/i6q73e66uu5UM/dc0r6R+PuiWESOL3YKBvwk7I74xdAeHiULhQu4lEl8Fn4C69/Q9u82zjxfMQYLmcTBELb6+OQ6Flm5znBfRFKP4qIDq+6vsri35eRf6aHHXhXlu+9+B7aFTFrEDu62AzMV9k8MSuTvn9sXYZtkRXL8THuGrpiV1dN3GwkexAS6556UmtRuuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daT36QhOZlJIlFJVughbyVb1lV6bl27nTliZIT9hhUI=;
 b=Iby9UmzGeHk9fCC4bI1b9M3Glm3y/vsfn5JoxntkiuXz++olDjYrphYR13sauXTPuuoy4rGGOj/JVo0Pse6V4HJ/4mh6TgF/Crc2AIwlclT7n3U/ob7xViaaQYPQHfETRwswWWOcNZe1c++XaC263QJ5RUy0+4gf6jdDUilWadhu3GCC9Y01k+yjtLbffFOLkBMnloZiKRTNh30sPc0GBH7opl6PuzLcmDO+cj+etOB2kl75N/QngCSTMeXeANzIAaRj/ZPIXUJ8M27/LO0unyffjAA8iicwfXGo9jxeZOCTQ0c/rnEsLFkug389Y4oFjI3yCGwht5aMhtsS9/pvsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 00:01:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 00:01:07 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 2 Feb 2026 16:01:04 -0800
To: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>
Message-ID: <69813ac070f79_55fa1005c@dwillia2-mobl4.notmuch>
In-Reply-To: <20260201093002.1281858-2-ming.li@zohomail.com>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
 <20260201093002.1281858-2-ming.li@zohomail.com>
Subject: Re: [PATCH 1/2] cxl/core: Set cxlmd->endpoint to NULL by default
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab41c7e-eb10-4f5a-6269-08de62b754a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ym9tZFRwTEZrUk9kcWZJNnpSOXVRWVU4TExqL29vWkJVRTBaWHhhNUU5WlAw?=
 =?utf-8?B?NGRHSmJZWEJ2bGRxL1VRbjg4dU1FbGlzWEo3dzg5dFJ3bjFMT0tuTHlsSFN2?=
 =?utf-8?B?WkxKODJyYlJvdnJhY2NFczBSUVB5eHhsTzcyejEyQnB2T0dkMU16elIvMkxN?=
 =?utf-8?B?WmhOdG8wNWl6cW1UVnJIYU42SjJNU291Z0oxd2FsbzFnUUNHYjZhVXlDSzQ2?=
 =?utf-8?B?aUZndTJhcCtRRjEwU0RmMzdreGRubHNWT0J6MkNjaXFnd0tYVmpTY1FHQ1o5?=
 =?utf-8?B?cjIreWkxSk02Umc2djM3YnNaWmM0bCtXT1pYKy95NzcxUVdhTGJYOGJPNElr?=
 =?utf-8?B?SW9aVDFlVWxpRmc0VXBHZ3pkWFdaQ3RVbUtnaFNHZWJzUjF3T1RuK2tneVJO?=
 =?utf-8?B?WjZBcklRQi8wRXBDRittdGorbUd4anYzOHNUS1FTNi8xdldrSmFKeU0wQVVY?=
 =?utf-8?B?dmVlS0lmOUViVktBV1JTVlZQd2ZQYVA5TEdzWnpwY3ZFTWdDNysxZXNGUk9I?=
 =?utf-8?B?cXB2bEFhWTFwUFYzemxOd21vZE45T2svNDMrZXgzZFBWY1ZYNXB2VHRxRXQ3?=
 =?utf-8?B?aTB2Q2VEUTBHcThublBKei9sK2VQcFN2eU1rMTZSVUlVeDRWenhxbW5rQ29h?=
 =?utf-8?B?VHpCNEEyclpNYmFIdmNuaEtJVFBWS0VrbG90YnkvcEFQMDVGWGwrVXNhMmpo?=
 =?utf-8?B?MVZ0aHlBVzdEQXg0eFpCUFJKaHM5QzhGdWtOZTM3YUtjaXV6T3ZaUEkzMUxt?=
 =?utf-8?B?VE5YL21aTldGbk51aEZYNDNlL2tlQ2ZqL0hlS1FJUC9mY0MxbTBWVlVMYnVw?=
 =?utf-8?B?dzFWMnFoYmxtZ3dIWG9RUG5yUzVLWGtxdXRya056S2k0TDdDUEZCWHJqeDNX?=
 =?utf-8?B?bEJocExmUXQ4bjgxTldxa0Q5QkNaTGRpRW1RU0lBUTdPa2RLTXYvcEhUeGxC?=
 =?utf-8?B?YzVrMDR5VWU0MGZ2czVHcEtrZkxnZ0pjR2ZJTkRQcG5Na2h2YnozNHpmM0JE?=
 =?utf-8?B?bUlwY0YvekFDK0YzV2IrdC9TL3NYNi9IVEFtWjJZamMxSDBWZ24vM2NzeDRh?=
 =?utf-8?B?eldHTjN3dGI4Vk9oWVhWMkF3cWNUeXhVUUlXUUh4Wm01U2d3WEtrN0hBd1BD?=
 =?utf-8?B?ckRpeXZnWDdIRUR2ZVlhV2I3NE1ZUWZqYU1qZWFqajNNQzVOMi9ocURTNk52?=
 =?utf-8?B?SWVFTjhOTlRDVlVLR2dSUWh6U2RNTGUzOUZTMG92czUwanZPRmVPeHN2VVdq?=
 =?utf-8?B?RlRmOU5mU0M5NXl5R1ZYbmJmY2o2U1h5Z0xUaUIrV2lldEZLdW90d1hUMlVC?=
 =?utf-8?B?VmNWYmNOMFZ5MzlqczNtOVZWQWZ0VEY2V3g2MjA5ZytCK0xCeGtRSjN4U00w?=
 =?utf-8?B?NEZkanZPMXFyNU8rWFl6dWE3MjhUdTNJUk1lN3RqWUExcFNzeVJ4VDJWVFRW?=
 =?utf-8?B?Rm8zNDJuTFRzZ0ZJMUMzeURjZ1dpUGtkekUxMFIwc0g5cElSTVZISERXWWRj?=
 =?utf-8?B?N0dMTjhvVzNHc1hZb0w5dFBwOUFDWkh6b3RKZ2JjNXUzZWFRUVJxb0p3cHpy?=
 =?utf-8?B?Z3o4MVFQUTdYSk1HeEFuRVN3RGNhejdCZ1J6VGV5V1hEVS9LaU5yZ3o0dFFt?=
 =?utf-8?B?V1YxOEZOTHc0RlcxMlRUdldZSUluUGdnbVFxNm1Qb3lYeHdlbHUzT3pWekh1?=
 =?utf-8?B?T1BPamZtcnhtQythYm1CalBCK2FMQzhvL2NRVjVSbVNGVmlTTDY5SmY2MmVI?=
 =?utf-8?B?LzFnOE5rb0txUWFKQVd3M2ErNWpLZXJIKzFEOUJSSVl1eHN2aDhhVHltWVdt?=
 =?utf-8?B?UjcxQjFSUXdSY1hZaVNLZytaeU5QZ0xJYmFRR1I1OXh1NHhEN00wcFMySDdV?=
 =?utf-8?B?SjB2YXNTQzVheWZ2RTVxZjZkT0xWZDdVT3NhblM1NU8zQ1h1Rzg0QTIxOWxD?=
 =?utf-8?B?dmVETUJGTWxHTjBYWmdma3dBMTJKUUI4anhPbU1CQm1QSDB6eml1RHVnZnVW?=
 =?utf-8?B?UWtKcUZpV0tMUkJ0aDg0dElzRlBSOVl6akd6dFdER0pUNUZJb0ZCSnZrbFI2?=
 =?utf-8?B?bC9acVlPbEFvazBaNHdpZFpEbmlyUEIyK0dqN3k2c01UOUpnb04wU2dqS1Rv?=
 =?utf-8?Q?SAeg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SytZVzhZOVdrNmxNU0VnM2xha011RDZVdjdONzNrM1hZUVRnRjhYNGVGcitL?=
 =?utf-8?B?YUxLSTRWR2YxR0ErNVhCYVA1eDhEUkQ4U0ZTK3NwU3I2UVQyd3hvalZUdXJa?=
 =?utf-8?B?Q2NueXBIYkFNVTQyY3Z3NlQwT0pjY0NTSGJ1MjhOZThRdEdtT1VPT0twS2k0?=
 =?utf-8?B?NjdZYWRrUTJHb215T2JFMmJzcVA4bndac3NoVXVXcDlDMDlMdk9JOVk0QXdZ?=
 =?utf-8?B?eUNHSFVrTEpkMFQ4ZFRPeGxwMDlvVERzeTRaQktxeU1GUXhvM3RBekdlV21D?=
 =?utf-8?B?RllKOWZDeENYYmlFVS9BVTBiZG5MTkhvSXJSdmFUd0dGZnREU1FhUUxrb2o5?=
 =?utf-8?B?NC85RUJrVjNhMDZZamRJdDNrRDV1RWl5c05lcGxnY3BXRVZTek5TbEFkQWtj?=
 =?utf-8?B?Q3VwOXZxczN6T0NsbkRZTjZ5eU9NWUg3MDl5K212WC9nZUF2bmc3NVF4a29t?=
 =?utf-8?B?aWYzUEY3NCtIU0l3TEY3TTdVTk1KZEZKUDd1UkJzU0hHSEQ4QVltUnZiaTM0?=
 =?utf-8?B?ekxwWHhRamhtTkxGdGo1VEdHZE8yZEJNM00zSSttbzNwQllQdDFKbSt0MlpE?=
 =?utf-8?B?VDNkNGI5NDlLSy9wYzVtbk1Td0x6VzVTT1dmMmdlN01mbVpOZ2toaEIxemtL?=
 =?utf-8?B?c2N0bEQzSTlPcm5UWjBRYk5aQW1QVnEvQUhYT2xBc0h0c0JYTjczeko2QURV?=
 =?utf-8?B?MkxDWDBWWHNqWWdmQ0Y5bjRxYXl0dmdRdXFTY1E4ZDNsYWFRbVU1dlFWWXpQ?=
 =?utf-8?B?Q0NvZitRMUUwVW9Dd3dtRTBpam8zRFA0WFQ4Z2JhTDlQazBUSEJ2SVZheTNT?=
 =?utf-8?B?L25QdFVwV0RZUEZTbk1XU1FwQXg2NWNXSVlNTGREMnpzSnVublNJVG9yblE5?=
 =?utf-8?B?MEROSUVWVmFuaS95ekFaak5yMFFvSGpocUM2eEkzekEwYVNBM2tMaldmUzVo?=
 =?utf-8?B?WEhPUmxiNERPUGViWVRlZWpLNWEwaEJBMkd0RzNhS0Y5ZFlIQmVFa1F3ejd1?=
 =?utf-8?B?M241b2h6SUxXUnEySzdKYWxVWFNDbEpNbXJ3NnlZMHpDT2draWZ5YTZEZWVF?=
 =?utf-8?B?Q3FReWhEWVdrd2MyKy9DNEpmUkVuYkZNTzd4UVRmdkFMZW9jOGlPU0VEMEdP?=
 =?utf-8?B?OFFwaXpNdlU0NG81cXNQUGlRdHptaU52dXFmb2Ryak1uVFZqY0xQeHJCTjRu?=
 =?utf-8?B?aVVHZlgrY0F3MGc5QUo5QzA4aVAvaFZ6T2hSZDh0Q2UzQ1UrSnpTZE0zL3dK?=
 =?utf-8?B?anVtMDIrWXlBdm5keGdGN1NFOUlYeFRsOXBFZGxNZmtkQmNQYzdScmlUcVhD?=
 =?utf-8?B?TiswdE9UU3ZhYUdJZmJhc1cxREc5M3BTVDRGanBEYWc5UVZUMDJzMFFoZUc1?=
 =?utf-8?B?eWpUNXpSS2psL3dXb0JUWTNCYmNUam5vQVY4cEVmTXlsRGFseHlkMndyS0xV?=
 =?utf-8?B?MUExbFlKR05hTVRtM2dPK09DUDFYZWNkYUU1VW44L1hmOVRaRkFvb0ZxaEYv?=
 =?utf-8?B?VFdVWjBwM2N6c1lsR1V0VXBIRXVIVFZob0cvSFQ0Vzk0MnYvYTVVMG9FL0Nl?=
 =?utf-8?B?Q0tkTU5XTkF2UHZKeG5xOFFMR2V5bzVMM2V1WTcvaXIrZmU1bkZPY2tWNE1z?=
 =?utf-8?B?eDBmcUd4OCsxRjdZK1gyMG1WTk9icDZyQ0lCY1dvY2pnMlAzK21LRG1qV0p0?=
 =?utf-8?B?MmdhZEdPK0VGL3JuWnJJTm95bzVxYjM1UmQxTHU2bHh4Ky9jUC9SU1lvRlRU?=
 =?utf-8?B?Rlg2STVRRzBYMVUyQ0VaeGJOWmVJMWlOMHVLZVlpRTJEcmVobkZxVEZyaW41?=
 =?utf-8?B?L0wvVFE3QUVhYm1KMG92WmhYN0RxWXZrSEw0aFJUcGt2ZW96VFZUNU9LL1do?=
 =?utf-8?B?MXU0UWxJZ3N3SjdiUUlhUVhDMUVyMDZFclQyc3lvQ1RmQTRLNmx4SS9DdHpX?=
 =?utf-8?B?R1VqM0tibXlzT1RuVkRVR1B4MWUrNlRuMHluNDBEYml2aTJRTDNNeXZGQnAw?=
 =?utf-8?B?SjhHOVY2WHc0YzdicG5wOW15UWRaTjZsSFFua0U2cUpTNkF2ZXlxMUlvM2k2?=
 =?utf-8?B?T2diWG5HUUNBaFpUdTZSWFk2dmdoRk12TldjOFltbTE0Q0lvVEoyeFROWGtn?=
 =?utf-8?B?UFkwWWhORUVGU1FNUUl0S1JTZVpORVFXcTZiSnhCV1JZSnBHZnhONS9xS2Fz?=
 =?utf-8?B?NG1VNDNWbkhJOEVNN0ZibWFwTUJOYUF4VWJaWE0rM1RRSWQ5TWR5SEhCc1VI?=
 =?utf-8?B?QVJlOWFkWElKdUg1SVJXSDkvK05XUkJwT1VSUVlVT2tlZFNiT09TenlVODBG?=
 =?utf-8?B?V0E3UXIrYm9WV1lja3VpaGlFWjhKVS9zSG0xYkd0U000Q0VpVWlFS1hMM25j?=
 =?utf-8?Q?AfQ2QxufIJrdkP6M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab41c7e-eb10-4f5a-6269-08de62b754a8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 00:01:07.5067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9L3E6EHeJqOcfD08vgYQkkiMk0MKKvRjVwcpWI4g/wntV+HH19mW2EscdOIrME9gASkBfugTlbTyBmoAXnqvhSQRMuKrl6RD8Kjlqqou8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5983
X-OriginatorOrg: intel.com

Li Ming wrote:
> CXL testing environment can trigger following trace
> 
>  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000092: 0000 [#1] SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000490-0x0000000000000497]
>  RIP: 0010:cxl_dpa_to_region+0x105/0x1f0 [cxl_core]
>  Call Trace:
>   <TASK>
>   cxl_event_trace_record+0xd1/0xa70 [cxl_core]
>   __cxl_event_trace_record+0x12f/0x1e0 [cxl_core]
>   cxl_mem_get_records_log+0x261/0x500 [cxl_core]
>   cxl_mem_get_event_records+0x7c/0xc0 [cxl_core]
>   cxl_mock_mem_probe+0xd38/0x1c60 [cxl_mock_mem]

Hooray for unit tests, but I wonder why this failure is so reliable for
you and absent for me? I retried with latest cxl/next, no luck.

No matter, it still looks like something worth addressing, but not with
setting ->endpoint to NULL.

>   platform_probe+0x9d/0x130
>   really_probe+0x1c8/0x960
>   __driver_probe_device+0x187/0x3e0
>   driver_probe_device+0x45/0x120
>   __device_attach_driver+0x15d/0x280
> 
> commit 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> initializes cxlmd->endpoint to ERR_PTR(-ENXIO) in cxl_memdev_alloc().
> However, cxl_dpa_to_region() treats a non-NULL cxlmd->endpoint as a
> valid endpoint.
> 
> Across the CXL core, endpoint availability is generally determined by
> checking whether it is NULL. Align with this convention by initializing
> cxlmd->endpoint to NULL by default.
> 
> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/memdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index af3d0cc65138..41a507b5daa4 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -675,7 +675,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	cxlmd->id = rc;
>  	cxlmd->depth = -1;
>  	cxlmd->attach = attach;
> -	cxlmd->endpoint = ERR_PTR(-ENXIO);
> +	cxlmd->endpoint = NULL;

So, this does not look like a fix to me, it looks like a bug report
against all the code paths that want to assume that a mere NULL check of
->endpoint is sufficient.

I think this unintentional ERR_PTR() trip hazard is now a *feature* in
retrospect to catch those cases. If something depends on ->endpoint
being valid, it depends on ->endpoint *staying* valid.

A proposed fix for this case is below (passes cxl_test), and if other
ERR_PTR() crashes show up I expect they need similar inspection. This
probably wants additional cleanup to consolidate boiler-plate and make
the critical change to cxl_dpa_to_region() easier to see:

-- 8< --
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 422531799af2..e652980098cf 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -39,7 +39,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 int cxl_region_init(void);
 void cxl_region_exit(void);
 int cxl_get_poison_by_endpoint(struct cxl_port *port);
-struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
+struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa);
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
 
@@ -50,7 +50,7 @@ static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
 	return ULLONG_MAX;
 }
 static inline
-struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
+struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	return NULL;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ef202b34e5ea..610ed6744ddc 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -864,7 +864,7 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds);
 void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
-void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
 			    const uuid_t *uuid, union cxl_event *evt);
diff --git a/include/linux/device.h b/include/linux/device.h
index 0be95294b6e6..4fafee80524b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -911,6 +911,7 @@ static inline void device_unlock(struct device *dev)
 }
 
 DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
+DEFINE_GUARD_COND(device, _intr, device_lock_interruptible(_T), _RET == 0)
 
 static inline void device_lock_assert(struct device *dev)
 {
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index fa6dd0c94656..7b923408b6c5 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -886,7 +886,7 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, "CXL");
 
-void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
 			    const uuid_t *uuid, union cxl_event *evt)
@@ -913,6 +913,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		 * translations. Take topology mutation locks and lookup
 		 * { HPA, REGION } from { DPA, MEMDEV } in the event record.
 		 */
+		guard(device)(&cxlmd->dev);
 		guard(rwsem_read)(&cxl_rwsem.region);
 		guard(rwsem_read)(&cxl_rwsem.dpa);
 
@@ -961,7 +962,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, "CXL");
 
-static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+static void __cxl_event_trace_record(struct cxl_memdev *cxlmd,
 				     enum cxl_event_log_type type,
 				     struct cxl_event_record_raw *record)
 {
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index af3d0cc65138..d2bee5608e50 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -331,6 +331,10 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	int rc;
 
+	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
+		return rc;
+
 	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
 	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;
@@ -355,6 +359,7 @@ int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
+	device_lock_assert(&cxlmd->dev);
 	lockdep_assert_held(&cxl_rwsem.dpa);
 	lockdep_assert_held(&cxl_rwsem.region);
 
@@ -400,6 +405,10 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	int rc;
 
+	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
+		return rc;
+
 	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
 	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 96888d87a8df..a7d391757e16 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2936,7 +2936,7 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
 	return 1;
 }
 
-struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
+struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	struct cxl_dpa_to_region_context ctx;
 	struct cxl_port *port;
@@ -2944,8 +2944,12 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
 	ctx = (struct cxl_dpa_to_region_context) {
 		.dpa = dpa,
 	};
+
+	device_lock_assert(&cxlmd->dev);
+	if (!cxlmd->dev.driver)
+		return NULL;
 	port = cxlmd->endpoint;
-	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
+	if (cxl_num_decoders_committed(port))
 		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
 
 	return ctx.cxlr;
@@ -4004,10 +4008,9 @@ static int validate_region_offset(struct cxl_region *cxlr, u64 offset)
 	return 0;
 }
 
-static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
+static int region_poison_lookup(struct cxl_region *cxlr, u64 offset,
+				struct dpa_result *result)
 {
-	struct dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
-	struct cxl_region *cxlr = data;
 	int rc;
 
 	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
@@ -4022,8 +4025,8 @@ static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
 		return -EINVAL;
 
 	offset -= cxlr->params.cache_size;
-	rc = region_offset_to_dpa_result(cxlr, offset, &result);
-	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
+	rc = region_offset_to_dpa_result(cxlr, offset, result);
+	if (rc || !result->cxlmd || result->dpa == ULLONG_MAX) {
 		dev_dbg(&cxlr->dev,
 			"Failed to resolve DPA for region offset %#llx rc %d\n",
 			offset, rc);
@@ -4031,7 +4034,43 @@ static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
 		return rc ? rc : -EINVAL;
 	}
 
-	return cxl_inject_poison_locked(result.cxlmd, result.dpa);
+	return 0;
+}
+
+static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
+{
+	struct dpa_result result1 = { .dpa = ULLONG_MAX };
+	struct dpa_result result2 = { .dpa = ULLONG_MAX };
+	struct cxl_region *cxlr = data;
+	struct cxl_memdev *cxlmd;
+	int rc;
+
+	rc = region_poison_lookup(cxlr, offset, &result1);
+	if (rc)
+		return rc;
+
+	cxlmd = result1.cxlmd;
+	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
+		return rc;
+
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
+		return rc;
+
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
+		return rc;
+
+	offset -= cxlr->params.cache_size;
+	rc = region_offset_to_dpa_result(cxlr, offset, &result2);
+	if (rc || memcmp(&result1, &result2, sizeof(result1) != 0)) {
+		dev_dbg(&cxlr->dev,
+			"Error injection raced region reconfiguration: %d\n", rc);
+		return rc ? rc : -ENXIO;
+	}
+
+	return cxl_inject_poison_locked(result1.cxlmd, result1.dpa);
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
@@ -4039,10 +4078,21 @@ DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
 
 static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
 {
-	struct dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
+	struct dpa_result result1 = { .dpa = ULLONG_MAX };
+	struct dpa_result result2 = { .dpa = ULLONG_MAX };
 	struct cxl_region *cxlr = data;
+	struct cxl_memdev *cxlmd;
 	int rc;
 
+	rc = region_poison_lookup(cxlr, offset, &result1);
+	if (rc)
+		return rc;
+
+	cxlmd = result1.cxlmd;
+	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
+		return rc;
+
 	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
 	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;
@@ -4051,20 +4101,15 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
 	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
 		return rc;
 
-	if (validate_region_offset(cxlr, offset))
-		return -EINVAL;
-
 	offset -= cxlr->params.cache_size;
-	rc = region_offset_to_dpa_result(cxlr, offset, &result);
-	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
+	rc = region_offset_to_dpa_result(cxlr, offset, &result2);
+	if (rc || memcmp(&result1, &result2, sizeof(result1) != 0)) {
 		dev_dbg(&cxlr->dev,
-			"Failed to resolve DPA for region offset %#llx rc %d\n",
-			offset, rc);
-
-		return rc ? rc : -EINVAL;
+			"Error clearing raced region reconfiguration: %d\n", rc);
+		return rc ? rc : -ENXIO;
 	}
 
-	return cxl_clear_poison_locked(result.cxlmd, result.dpa);
+	return cxl_clear_poison_locked(result1.cxlmd, result1.dpa);
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
-- 
2.52.0
