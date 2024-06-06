Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDCE16415
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717641013; cv=fail; b=EZNv0xiZXe8FUHTjq9NlgXF155hhAgcMkQ71aClURvwYoy09hH6zvt0LQljvfkphfTqtRQb1FykNPJG2rKfSSbemTAQVDc5sn867otvgcVTZbDKT2ZUZbKPviobP/ptUOVSqNOy+pkpM0Puvr/SUQsap7kTuhDD0uyKALUKW2MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717641013; c=relaxed/simple;
	bh=aIiSOY7ZXtw2QEZ1es28/+OfUa3N2sKXH/IiE4rMRCM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RpaITwPHazZM61IRq1k3gdUqMs55H2iu7Ed4ZDPxUbdQ8M20IvRaLpcS8Uai9E6ey31gbieJnK1vi3D+SLSJBtdXb4DY1/vMQzI5n/W/j+5OTgnfbfEUV5iNbIfrSfnN/anAPbDkTar3Pm2/ZVxJchNqo7P5hpiIBedoJ2cww9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2OHKKaC; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2OHKKaC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717641011; x=1749177011;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aIiSOY7ZXtw2QEZ1es28/+OfUa3N2sKXH/IiE4rMRCM=;
  b=T2OHKKaCe/M8YgJEe711HhqCLxoa9CfGWfvPxJnYOz1OikzKTfmFpYto
   WHhlOGACudQOjp2/GvO0RBgTeXjtQ1K1goBDI1pmykwMV6CSCsKAKwCmu
   anTkcqwOu7F1nRqcodTZnyg7FjkUOwE6skvEOjTyAY0vDXu0sslVOsFGT
   YvKCA+eISmW3i1P3iykIOXqns/m4vJqYvlTCgwIjGSqm3poSjRy/Rg+op
   Pe0P9fN6gRIyajR+PULsocgr6zSKZ/ukGe7STdJiftoD5DYWpgvicfvge
   Bb6F45QC/CUeNz8sMX7gdm+dLCeIsYQ79XOtriJDuSw8muRbbSFagpx3B
   w==;
X-CSE-ConnectionGUID: l0Jz3AC5R4Gd6xux6IxsrQ==
X-CSE-MsgGUID: cwgiy0w2R0e1wYfURDiF5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14507171"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14507171"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 19:30:11 -0700
X-CSE-ConnectionGUID: KfDjwj+UTbelSTBxrjytBQ==
X-CSE-MsgGUID: rdEGzHQgS7ODf7w7hegjiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="42729445"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 19:30:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 19:30:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 19:30:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 19:30:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 19:30:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eV9BReod/eR/4/+ivJ2nq+UMf8cqvY3pIr6c/EpiDakKadBn+bAqBUz/ltYGMOJ7WwPTfD41Mk14bPmc3PWDoThT9iVw+N0V4McNoK+vK/JQf9nNUGjQ0yjJ7VVcGV1pq2Z8KhbED0VJnqAtIujob9fJrP2ia1GXGLsXZeUnWbh5VYhtw3taxMt6IX3XKNZ42FZYvihIPJbqNs7b4azlprghV3o5fjZR6PPM8z7TanNUpjx3W1vrPr5wsbJ94L5+QXrsMrrxiZtpbB/3+/JWG1gniYxbfHXrqnUKQLibc/CrS/1E7hg786aeGsFnTRCfViRK3AyHwkwwcKnxI/ipyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//3LmHDL35rzetFHB0px7t0TP7UIlR1y8zUE0oOEaj8=;
 b=GY2SaU7x69dW7OkxT/KnASvOnPI+6r+i6fNErsDrQU/crQY6aDpfPHWjrk6q/nvs645NNGStYbfHzT9UMm4TvrfUwhZ+aj+vFEFk/+oyLgU/EmvpNQPWwgmOU/B9Hp4HKMqFIuAI8xr3y3c9LXkv1yRN+TGeoLFMF0oW78ixIhcQRNHlrS6onWan7lufAMfU4dWycP0oNGXBpYhPhOAt8Oh8j1dzDn1NXfGQXF4SpynbST8TMMrfqBY0vK/kHe759knbKFCYV/ahlI9rTjd0Ii8ABU1406EPwgQj4vIw9NXdJCRKHiqy34+JS1z3NwofwSb/HL7hK6as1ZQM2SEzWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by SA1PR11MB8394.namprd11.prod.outlook.com (2603:10b6:806:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 02:30:08 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%3]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 02:30:08 +0000
Message-ID: <2e4b2584-f1f3-4e4b-a604-b2db4a28b5de@intel.com>
Date: Thu, 6 Jun 2024 10:30:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/mem: Fix no cxl_nvd during pmem region
 auto-assembing
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
References: <20240531070229.1596811-1-ming4.li@intel.com>
 <20240605125707.000064f8@Huawei.com>
Content-Language: en-US
From: "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <20240605125707.000064f8@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|SA1PR11MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6bde1b-6a09-411b-27a0-08dc85d094bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHVkclNva2JsMUtYS1JDRG5WcXhhMjNHbDFyekJyYXFWT05neis3TWhxSWdu?=
 =?utf-8?B?VExiZitpL3ZubERzUk9mcndFbnRrakR0WFBOQ1RzOUhKbUluMDh0U3VpdUlI?=
 =?utf-8?B?TFBTZk1zc3pTWFJldnhndThJc2FzWnU3WEJ1NWVLcm04WWZ3d2dNRndCc3NE?=
 =?utf-8?B?UmRlN2hhYUluYXNVOWVSVlR3bHBxeXNJKzdIaGd1T0R3TXNNTFk0aXg2S1lQ?=
 =?utf-8?B?QWtneFNJWFF4NTQ4ZGx4R2QwbWl2bk80TEFmNGVvNm5QajNUSEd6RkFncnZ4?=
 =?utf-8?B?Y2VQUXZpQnlFNUR1ekNNWG1idlhZT3I3L1JMcXJsV2o0RTFmN1IzbmN4WHpy?=
 =?utf-8?B?ZjBWK0MvZDU3czJVMkRHLzBNeWlVOWNTZVF0cjBEeE9kV2xjTDZ6V3NSZEpx?=
 =?utf-8?B?SWpkUkQvdVNQY1IvZlpFR0dGakRiTjkzVURabDQyQmo5Z01xcUtNeTBtWlZl?=
 =?utf-8?B?RHA5Sm8xU2FGbDZqc1duLzEvc3VqOFh3Z2huMlR5VDBmemYyaytOc2RiVER5?=
 =?utf-8?B?djRwcVQ4ZS9sQzVsQXdkU255TmJIMmtmK1NhRDdBVWZ2SEFsSU5jWTZlTy8y?=
 =?utf-8?B?ZlBpazNkdS9sbkhrWE1QNitRNkc0dlJSRWE5SE9tMW9RL0U5UWU4OGpkYnVM?=
 =?utf-8?B?ZUM3Vi9RbDZJOXR3cHdZWDIrSVg0S2tzNHRWczJmUGp2d3hzODBER1hQV1VH?=
 =?utf-8?B?cXUycXh3OUEyY0lIQkdNcElINHRiV2d4MmpWRXAxS2Q2cXRsLzZObHVlSVh2?=
 =?utf-8?B?bWJySENXcElBeGZ6K0ZJOTA3d3hIbXZrcHM3cmtyeFBxY2IwSDdiYm1JVUpB?=
 =?utf-8?B?ZDB4dW1SVTRBM2owTitzMUQxZ1lYRkxxenNNRTNEeHFYUVVOeitGeUpjWE1R?=
 =?utf-8?B?T2NrdzNtdWxPWjV4NGd6eTdiUFR1WVoyQlhTYVhpUDQwMXBpRjlZbFd2U2d0?=
 =?utf-8?B?b0U3RWI5WXlsSkhLMlhlNXlHK0RkMmpVZ0x0a3h4RkdWNEJTWUVENHVzR29X?=
 =?utf-8?B?cGlMUkwwaWhRNVJVTldTT3FOeXZoQjBsdVlUTVE3SGFSMGhVSHhiNkdHZmJ5?=
 =?utf-8?B?SWd2L3hpc3d4U0VNMGtvcDg4MElrV0hOUWdRaUJvSDFSK3pjUHJMWlJlaTJr?=
 =?utf-8?B?U0pHYzJ3aEJER3lIbFZIS3JrR21udW5XRDhsVlZHY1lTU2dnUnJIUWpFb3lS?=
 =?utf-8?B?dXBXRTlpU2tBc04ySjFiWWI2dHFWazhMQ2YzL0tJeFBleUtISmhPRnRUeDh4?=
 =?utf-8?B?UjZCOUJ2UUlDQnRhSkJmRUhXczVqb0tTN3p2eFIyTmNFa0poV3VHM0x1d2pk?=
 =?utf-8?B?b2lPeGg3Ymo1R1JKTThnQXQ3eWpyeGZDK1ZFS1VhSVZBMDBkcFN0Mnl5VnNW?=
 =?utf-8?B?dDNlQ2xEWVFSNGxleWtsRGxBVnpCb09IOTRXTHZNQ01IMDl6eEZYd1VPZXJW?=
 =?utf-8?B?S2JpODBSTkFQK0VvKzlRdTkxMjlZMUkyMVAwdXZQaVd2NkdXSzIzUVlkZy81?=
 =?utf-8?B?SkUwL2RUM0dNUFRUNTljNCtZWjk4dWNkQXNuQ1lkYWViZTlLU2M3VGJIUmIv?=
 =?utf-8?B?M1pVaHlVMWNzOS96SDljTWY4VGpnd2dKVEtZcXhiaFZEbno0UzJBTU51MGlh?=
 =?utf-8?B?Si9xNUMvRDFUTHh5TXNUbHdGMnlGYy9yelZvU0Q1cTlZT3RxbVVTQURNVzZ3?=
 =?utf-8?B?MjNGLzBhTjErbE5kMk12bkNUM1RFTXBIazBobjE2RDIrVXlMaWJ4eWZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWgvZGgrbCtld1lZOE5tYWVuL2dtcVJDOUROMDhXTEhPREZNNXJqd1NZNlMx?=
 =?utf-8?B?YXJCeVExczM0OWMweXhYdjdWcWNXeEdTL0NlTC9rdXRBNmdENkxGbGc1dkdp?=
 =?utf-8?B?UzZ5eGZuVXZhNzhrMEZDd3NCc0NhdEVaWHNMamFkKzNvZXlmcTVZVncyWHFu?=
 =?utf-8?B?TXJZTzlUL3pNdnp4dVJ2UzRLTXJCQVZ6TTRqOU1Yb0FFdTFlQXB1eUdUY3lu?=
 =?utf-8?B?MmVpbCtNeEhoeFI1a2k5dVBsZFo1cnVrWWliK1VFYSsrY3Q1ZGE1blNCSjZj?=
 =?utf-8?B?eUNtdmllNndpUTYzL2lTNFRRNjhjdjY0MWtXRW9uSlA1bCt4NU1LNTJiay9n?=
 =?utf-8?B?a2Nia3hSK2tZQ2VwUXBYMG1DSGpvbzRYejJwNndUSEpxcDc1Q1BEQjRjTERW?=
 =?utf-8?B?ZkJKWkNGMFBhdzJ4L3BUNE1iemxrSUhJWUk5ZE15MlJFOEtleXVWc05xNllC?=
 =?utf-8?B?ZVd2VnQvaVlFQmNneFN3UGM2UHVCUWRtaGk5QmJVSUlEWGxOWDVaZzFTemh2?=
 =?utf-8?B?RWRXNnREOEJpK3V0MGo1eFVtV25wZlFLYkFicjZzcFJuVkhwcmpjS3U3aVBI?=
 =?utf-8?B?dEpGeVZMYVlVdjVhdHNxV3k3dHhNcTlHUTdhUUZRYk1PZFNITmVlaktiTkV1?=
 =?utf-8?B?dVFvZDU3bWVtUUFBZlBwcDltOUJSa1ZvYmd6L2pSbGdVSHdPSTVPVHg0MWFq?=
 =?utf-8?B?UlJTZkVrRXdQUDlNSjdXNURQT1VPV3FLMklUMUJpMGczZHFXTkxNbVRHRERn?=
 =?utf-8?B?NE1WclJ0bkt5SkdZTGtUVzVrb1p0b2pMSWs0TUk3MHlVd2ZVbGxSZWZiREFD?=
 =?utf-8?B?dmljNTBRblV3b0tMd1MreEkyYXgyM0F4K0JRKzNxQTYxZUticUVqWHhqSkp2?=
 =?utf-8?B?cXVOWVgxdTdzNlpIOWw4VEFEMUVYRnZ1dHQ3QmR0U0JhMjZWQ1NuSldZN2x1?=
 =?utf-8?B?R0VCTG5rVzc1MTMwNEVmbHhFaWNrTnhLMDBJd2Zja1RmVXVlOWl0WnhKbnFy?=
 =?utf-8?B?UXM3OW93ZzBPY1lrTG15eDJERnJDOTlxR1J6MTVDRTcvdUdydnk5MGxSMmds?=
 =?utf-8?B?NEkwdVplREFVUnJKcHE4RUFkQXZoaEo4ME5SblF4dC9qSk9wT3c3U1gxQmho?=
 =?utf-8?B?eVcwQWJ6NWU5blBJL3pRNmlaRWZQY0FlOXZvMzkvMXlDZUF5YWZNY21mdkRJ?=
 =?utf-8?B?bk1LSGN6UUFPdXFCakFvTWg2Z2NicEVMbUU5d2lJd2lGc2QvU2MzOGNyOWVn?=
 =?utf-8?B?Q0ZMSWwvVzdKZ0IzWkxIMGRNejFQUHhxQnhZNGpSdExoTVhrSlZNMVFocjZl?=
 =?utf-8?B?d1MwQXE4RU0xV05RZDJQbUsrdEpIeWYxQ1NXMzE0TjVoUk5YbTFxSzRJZk9Z?=
 =?utf-8?B?aVpqWUN6Y0E2TDdjd1U1VXhUT2Y1MmdQdXhFTE9HSmlsRi9QT01abWtGQXlV?=
 =?utf-8?B?Z3dlamNtZVFFWC8yTzhxblBkS0dIbFdGZndUODM2U0dwVmpLamRjYWJGWjYw?=
 =?utf-8?B?R2hGeHdwUm1OMCswdkpPWjJUNUVicTRuSW9DakVqWi9kandJMlliZGdMcHNS?=
 =?utf-8?B?Q01kdVZqOWlMV2cydmdTdU5td2ZYZzlxalhTSHV4UUtPSm1LVW9oQlpTZE1a?=
 =?utf-8?B?b09NaXN4amxJMStteW9DbGJGcm9FcDBnMUN6YTdCL3J3VUJGdlFzeHQ0K1NM?=
 =?utf-8?B?dENGYXNjdW1pcWtWVElPZVV2Mm9ma1BRcGt4ME5PNm5vRjJVYUNpSkF3Q05r?=
 =?utf-8?B?Uk1zNld6UnFWMzdRQ1ZpTC9wKzRiNU9LdmM4dU1hQ294VmlVaXpSZ1dWdVgx?=
 =?utf-8?B?RkJaUHd4TWZHblNhQVZ5bzZXMlpCNEh5anp1TXJmWFltUjQ3cEYraEQ2VXFH?=
 =?utf-8?B?S0VQSFg2TWp2RU4rcmV3S1NjMGlUdjVGNnFsYmQ0M0p6MVBTVzJTQndSTkRz?=
 =?utf-8?B?V0lTZWVpSkkyczhwWHZhcUdNNTh6RmxxemxxTXRsak1CbWtZdzdGU1VFYjZh?=
 =?utf-8?B?ZmhJUGxWNDhPZXlGcGc3NGVmaG9UL3dLUTY5VUtvQyszbDZrUHY3RmRpbWdX?=
 =?utf-8?B?Qm41ZXR1ejIxS1gvOWN1YlFHODBqNUduRjdnU1ZNb2pwTkFzOGN5R3FYY3Vl?=
 =?utf-8?Q?sMPG3goUCoGroxb5J3zlB9Ysa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6bde1b-6a09-411b-27a0-08dc85d094bd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 02:30:07.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mR8tr4z7Ie293FWuE8kl617Bpq/gY4Jlbitdn94/RLiVdVczoVBkdF7bvlKT7meWCv4eSbPptna4kAk+ZDlzqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8394
X-OriginatorOrg: intel.com

On 6/5/2024 7:57 PM, Jonathan Cameron wrote:
> On Fri, 31 May 2024 15:02:29 +0800
> Li Ming <ming4.li@intel.com> wrote:
> 
>> When CXL subsystem is auto-assembling a pmem region during cxl
>> endpoint port probing, always output below calltrace.
>>
>>  BUG: kernel NULL pointer dereference, address: 0000000000000078
>>  #PF: supervisor read access in kernel mode
>>  #PF: error_code(0x0000) - not-present page
>>  RIP: 0010:cxl_pmem_region_probe+0x22e/0x360 [cxl_pmem]
>>  Call Trace:
>>   <TASK>
>>   ? __die+0x24/0x70
>>   ? page_fault_oops+0x82/0x160
>>   ? do_user_addr_fault+0x65/0x6b0
>>   ? exc_page_fault+0x7d/0x170
>>   ? asm_exc_page_fault+0x26/0x30
>>   ? cxl_pmem_region_probe+0x22e/0x360 [cxl_pmem]
>>   ? cxl_pmem_region_probe+0x1ac/0x360 [cxl_pmem]
>>   cxl_bus_probe+0x1b/0x60 [cxl_core]
>>   really_probe+0x173/0x410
>>   ? __pfx___device_attach_driver+0x10/0x10
>>   __driver_probe_device+0x80/0x170
>>   driver_probe_device+0x1e/0x90
>>   __device_attach_driver+0x90/0x120
>>   bus_for_each_drv+0x84/0xe0
>>   __device_attach+0xbc/0x1f0
>>   bus_probe_device+0x90/0xa0
>>   device_add+0x51c/0x710
>>   devm_cxl_add_pmem_region+0x1b5/0x380 [cxl_core]
>>   cxl_bus_probe+0x1b/0x60 [cxl_core]
>>
>> Because the cxl_nvd of the memdev is necessary during pmem region
>> probing, but the cxl_nvd can be registered only after endpoint port
>> probing done, that is a collision dependency, so adjust the sequence
>> between cxl_nvd registration and endpoint port registration to guarantee
>> there is a cxl_nvd in memdev during the pmem region auto-assembling.
> 
> Perhaps call out that the root above a parent port is the same as the root
> above the endpoint seeing as I think you are starting the search from
> a different location after this change.

Hi Jonathan,

Thanks for your review.
what do you think if I change the description as below:

"Because the cxl_nvd of the memdev is necessary during pmem region probing, but the cxl_nvd can be registered only after endpoint port probing done, that is a collision dependency, so adjust the sequence between cxl_nvd registration and endpoint port registration to guarantee there is a cxl_nvd in memdev during the pmem region auto-assembling. For that, change cxl_find_nvdimm_bridge() to use a port to query the ancestor root port, it helps to find the root port of an endpoint by using an endpoint's parent port so that cxl_nvd registration can be finished before the endpoint attached to the CXL topology"


> 
> Other than that looks correct to me.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
>>
>> Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Li Ming <ming4.li@intel.com>
>> ---
>>  drivers/cxl/core/pmem.c   | 15 ++++++++++-----
>>  drivers/cxl/core/region.c |  2 +-
>>  drivers/cxl/cxl.h         |  4 ++--
>>  drivers/cxl/mem.c         | 17 +++++++++--------
>>  4 files changed, 22 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
>> index e69625a8d6a1..31b398c13be9 100644
>> --- a/drivers/cxl/core/pmem.c
>> +++ b/drivers/cxl/core/pmem.c
>> @@ -62,10 +62,14 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
>>  	return is_cxl_nvdimm_bridge(dev);
>>  }
>>  
>> -struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
>> +/**
>> + * cxl_nvdimm_bridge() - find a bridge device relative to a port
>> + * @port: any descendant port of an nvdimm-bridge associated
>> + *        root-cxl-port
>> + */
>> +struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port)
>>  {
>> -	struct cxl_root *cxl_root __free(put_cxl_root) =
>> -		find_cxl_root(cxlmd->endpoint);
>> +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> 
> This is a different port in the now earlier query (not the other path you update).
> As you say any descendant is fine though.
> I'd mention this subtle change in the patch description though.
> (noted above)
> 
>>  	struct device *dev;
>>  
>>  	if (!cxl_root)
>> @@ -242,18 +246,19 @@ static void cxlmd_release_nvdimm(void *_cxlmd)
>>  
>>  /**
>>   * devm_cxl_add_nvdimm() - add a bridge between a cxl_memdev and an nvdimm
>> + * @port: parent port for the (to be added) @cxlmd endpoint port
> 
> Would calling it parent_port make more sense?

Yes, will change it, thanks.


> 
>>   * @cxlmd: cxl_memdev instance that will perform LIBNVDIMM operations
>>   *
>>   * Return: 0 on success negative error code on failure.
>>   */
>> -int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd)
>> +int devm_cxl_add_nvdimm(struct cxl_port *port, struct cxl_memdev *cxlmd)
>>  {
>>  	struct cxl_nvdimm_bridge *cxl_nvb;
>>  	struct cxl_nvdimm *cxl_nvd;
>>  	struct device *dev;
>>  	int rc;
>>  
>> -	cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
>> +	cxl_nvb = cxl_find_nvdimm_bridge(port);
>>  	if (!cxl_nvb)
>>  		return -ENODEV;
>>  
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 3c2b6144be23..f0cafc7ffb45 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2847,7 +2847,7 @@ static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
>>  		 * bridge for one device is the same for all.
>>  		 */
>>  		if (i == 0) {
>> -			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
>> +			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd->endpoint);
>>  			if (!cxl_nvb)
>>  				return -ENODEV;
>>  			cxlr->cxl_nvb = cxl_nvb;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 603c0120cff8..e8fca6c6952b 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -855,8 +855,8 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
>>  struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
>>  bool is_cxl_nvdimm(struct device *dev);
>>  bool is_cxl_nvdimm_bridge(struct device *dev);
>> -int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd);
>> -struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd);
>> +int devm_cxl_add_nvdimm(struct cxl_port *port, struct cxl_memdev *cxlmd);
>> +struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
>>  
>>  #ifdef CONFIG_CXL_REGION
>>  bool is_cxl_pmem_region(struct device *dev);
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 0c79d9ce877c..2f1b49bfe162 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -152,6 +152,15 @@ static int cxl_mem_probe(struct device *dev)
>>  		return -ENXIO;
>>  	}
>>  
>> +	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
>> +		rc = devm_cxl_add_nvdimm(parent_port, cxlmd);
>> +		if (rc) {
>> +			if (rc == -ENODEV)
>> +				dev_info(dev, "PMEM disabled by platform\n");
>> +			return rc;
>> +		}
>> +	}
>> +
>>  	if (dport->rch)
>>  		endpoint_parent = parent_port->uport_dev;
>>  	else
>> @@ -174,14 +183,6 @@ static int cxl_mem_probe(struct device *dev)
>>  	if (rc)
>>  		return rc;
>>  
>> -	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
>> -		rc = devm_cxl_add_nvdimm(cxlmd);
>> -		if (rc == -ENODEV)
>> -			dev_info(dev, "PMEM disabled by platform\n");
>> -		else
>> -			return rc;
>> -	}
>> -
>>  	/*
>>  	 * The kernel may be operating out of CXL memory on this device,
>>  	 * there is no spec defined way to determine whether this device
> 

