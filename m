Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC2838E13C
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119922; cv=fail; b=C3ogiQ9Q2BvUbMXfotqfTwqhP1qiZ5i+N7G4GJ5HWXHtKd1v5MRH30vvpmiGV+1phXOAFECiCIeb1pAlOYlj+yub85e8WPTNhbEgsvbgc+U6mJhU7yFdRbhehiIpDjQtZU4otP1qeiUxiKvP30uEJijjrUhBJ/KtRPaMIGL0Yqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119922; c=relaxed/simple;
	bh=9Iy/c3NJ2mkRIO7cNwyhFKTm3HaSC9+aO/V6/fszXzk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=NdupKWm8JInoWG6CLCJ5pfA27aUtEYfm2qrnd7qKCkGNlVu65EfhBd7wj9eP0oBgi6Oiw+PVs/N3EXUIcfb4ae9iQd0JAiR/VFucArMgJwK9kfZ5B0bYIFzspCU9GzI8DA+6+m2c8P5iEvX8Y9AASTqVBpNjCdDgikDIx4D1Xrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6zZU/14; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6zZU/14"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769119915; x=1800655915;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=9Iy/c3NJ2mkRIO7cNwyhFKTm3HaSC9+aO/V6/fszXzk=;
  b=J6zZU/14w+7l+a5ohe2vU4Bpap0zuDH7/qButd1wF4SXw+4c6H6VYNBP
   kJ7+P2XBokyEBqEJfDDAF0/ZtE7Ubi4cO7V9s5xZXFdmunZ/9kwL/k67U
   lDH6OAxprzkIrpIIvJZwCTWtOVed5ToDpVTzgcFKWcmYXIRAezNxX/JEx
   0ezQLdKCKx5Qsfvqyh6ENXnQziAyy50T4SjoYb49AX0c3Kkk1MpmA55lB
   BUtjJXN09kYOu3KbmTgnEZCI4ihz9Xaax7x6JH/AVSgkNYNRQuv25zjua
   zXx9u0yxLzmWo6jbMV/tOR9I8Jr2wph8fqR6sRbexcJ64pqMmhH9x5N/N
   w==;
X-CSE-ConnectionGUID: TcMjCZTTSnqDM5IcOki2ag==
X-CSE-MsgGUID: 2Vn3x2kOQKSQjJrPyoUTww==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70287665"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70287665"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 14:11:53 -0800
X-CSE-ConnectionGUID: Bo5s7cx9TEW0BhFDGu4nsA==
X-CSE-MsgGUID: 58ZOZoDeQ6WmGyXBPooj8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="238107351"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 14:11:52 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 14:11:52 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 14:11:52 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 14:11:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJQUEKeGbsV/idCD1T1C+SJQ9szIfRsEB+XTK8+eiEVM+jzlnCocWQ5jjhcNJ5viKgMy+yhJpFvx0xY9kslpPd/9ZwFD6KJ8RQ+SJdWs27IJzIx7cexuklO8mvYVnBUWMbPPnMSaY5FmVOr8SYclnWZ+b/G2ENhK3e8dSTp9otqB9iuZegVMXRnXcyRt3Q+w2aSIV/+yZgUIPcsTekB/ur9MPTr0nxXii90Mk4nXvAGk3iq+ed2IKmEzBzc3bhg2rJ7ySAXqbn2MuNiSLIH8jO1F152iLMWSolaH1e6yY009tenDxA3ost2IrY869FVgEk0O9rgplIg5nO07LqVE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I65EhqgK0wesAvNrz8ox9k+uNq0yI+cghG4XyT2liGs=;
 b=g9unzGh7wIfUHN2aOKF+Udcv8E0cQzfyluam3F4c+GZBiPGqgEG9Mjh1R14nMhFRXVn3n/mFiuusBD9zuWdMtuo3yzcTvIdg/X3AF323QLGnlGfzwhm6yhmtbnqOv77irZIt7K0cZ5EqDcu/3a+Ij2fWwUiS4xW4I1L0Ht6Wr11SGYRGETZmsNZcSSWgOeSHwxJskaUg2oUehIO8Wz0+1KhJoezV28Cj5FJ/z1ebgG4omG1xF66X4d/y9cbXjTgnl6h39c87Fr0Liy4eDsroguIlrqPnb24EoUGgVjrFnQj+2lJUdiZO3YuF6nT/cZPPske4kTtvA7+0IM+wXT+3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB8152.namprd11.prod.outlook.com (2603:10b6:208:446::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 22:11:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 22:11:48 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 14:11:46 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Message-ID: <6972a0a2e29e2_309510046@dwillia2-mobl4.notmuch>
In-Reply-To: <20260122152508.00000518@huawei.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
 <20260122033330.1622168-8-dan.j.williams@intel.com>
 <20260122152508.00000518@huawei.com>
Subject: Re: [PATCH 7/9] cxl/port: Map CXL Endpoint Port and CXL Switch Port
 RAS registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::43) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bc90f2-0bc0-4341-b95d-08de5a033cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHBTOXViSW5kRy9JRm1qY3Q5Umo2Z3RxeVRGSXE2bzRJdVZ2SmtvaUlDR3Uy?=
 =?utf-8?B?ZmxGbXBmdjJNaExuM21GbVpzQml5YnBvdS9RV2swR2dYRTB2SFQweDJZbVpx?=
 =?utf-8?B?R0c4WUVHOS9kL25FZzdjak5nUnNOa0FCRXVPQjhkSU5KYUIxSnJCc1V1dU5t?=
 =?utf-8?B?bm1TK0pYNTI4T2VRZVVObFJqQ3FDanFNcEg0Z3pPWUovRUtnakFHTkxkcGxR?=
 =?utf-8?B?UnYrR1NUVHV0YzNOblpoZ05NZlQ0ektUNk1xbDI4WE5GRzUzRjcvdjBwaDlx?=
 =?utf-8?B?RFpnZ2J0VmE1cGQ1Wm5sT2x0YjhHdC9JRGhFSUJjTVc3eENyU0RpM1E1Vnha?=
 =?utf-8?B?MFg4dVVYYzJHMmxEdGpsaGdGdmIvdVBzQXdRU0E5OWYyZVBJTUl6bkJydm1U?=
 =?utf-8?B?U3VJMmFLci9tOVdEM3NIVkFMK2Q1UGc0SGpDdzJ3Y0JsbW5zc0JtT1prNDIw?=
 =?utf-8?B?RVhtVE9neU9HWThiN3J2TllheSttL3oybEdQMDJJdXVUUzVUOGdGc2R5dTZP?=
 =?utf-8?B?VktvVjlCYmZUWGhnV1BYeG0zNWxYaG9VVkVuZmVaWnR4MnRIZk9JTTBKMzZr?=
 =?utf-8?B?bHNGMEp1ZUN6cTE4bkVZNHZrUytGN00xVW16SXd5b0V3NzVTKzFCK3R1SkVw?=
 =?utf-8?B?QVVGajNhOHFZYnNTYWFmSC9ZV0lEOVY0UWZLd3V4WU10Q002cWo2QmNoaXZE?=
 =?utf-8?B?a3dadXNCZlJIb2V2NWVzZitwWjZmLzAzaStNeDNyeEI1RmlDOGNldm5Xc01C?=
 =?utf-8?B?ZVdxOU1QRG9XN0NrYkFDWTFNc3pnZzROU3pibG5WZkhVZXJxaTNSWWsvdUZo?=
 =?utf-8?B?aUI0cm1MQXlOSWVnMktQRjhhZ0Ftb24yaVI0bHhZQ2FRM3NQOUtMT20zSnMr?=
 =?utf-8?B?MDFRdktOdkhyUkUwdXphaVpBcWlESWE2ZERDUlNBRlFQVUpCcXlRV1REM2NG?=
 =?utf-8?B?NlJxWmJndWh4OU9qT1ZLMzZ3YlNPamdmWSsrdnJxNks3bmZ5RUtJeTNwaUcv?=
 =?utf-8?B?Y045UFhSUWpTM2JEdGFycUhXQWJ3KzhZRS84N05xL3pIKzVnRHRwSlJFWWFL?=
 =?utf-8?B?bUdDNWUxUURpenZCVlNLVjV5MkRYazE2cUdYL0VMMWpEb2dtY0dwdFV5NUh1?=
 =?utf-8?B?WWtRWHpiejRqcHQ3Nmx2bkVTMDJJcGZmR0xOS3BHWFB0NWVUQnY1TkhsNWR5?=
 =?utf-8?B?clJMaWZTSUh6RVFoMzdUS2JoM1M0dkFWRWFaelY0ZFEvS3dERExGOGRTYlpB?=
 =?utf-8?B?UFFsRUhTMmhGRmZLeXh1b2QyVUIvSEJpOEJOMmk5Q1djUVAvbTFoUGlSdEtT?=
 =?utf-8?B?dVkyYkZOVlc0cVF1NndyTVhtVkVBeENkKzRkY2FIZ2tHb2dLREsvS0JMZldL?=
 =?utf-8?B?Y2Q4blRaRk5HU1hzK0ZRbmtMQzZRbTg4d1c2bXA4UlpqTVlNTFZPZk1zWTBC?=
 =?utf-8?B?WnRLSHc4TjlYQzNXeCtTaTIvYXlVZWZ6aXV3SHhpN2F0TUZ5UlBScnduWmlo?=
 =?utf-8?B?cm1UMTNtVWpyeWNBRmFtTXlYQTdyM2RMYm5CS1lBcjZiL0FxZEZDTUlQVC9l?=
 =?utf-8?B?eDZrbVBpSlkvMjllRkFBTFJ0azFhOEkzYnE1Ly9RS0hrK2V1dHlvYldvOGti?=
 =?utf-8?B?d2JJWHk2eUJoS0xkd0dpcFpINGNDWFR2QllaSSt2Z3pOK0NjUitjcXdNalZm?=
 =?utf-8?B?OE56Vm96THF5SDRMdnV3MGV2UlhtVW5ZYk5KT3JhaHZJOEplRHF1a2pzcEFu?=
 =?utf-8?B?UUY4ckMyeWV6b2dLM0I0MjBxUE1JSE1vN2dpZXl6UnZBbG1abTdpNHpIRklY?=
 =?utf-8?B?RXJtWlZrakltNlZGeDV1Z1pWNHZ5bXZVSWdTUlRXQnNCVUdabXgrNExYWjF6?=
 =?utf-8?B?MENJR01acDNSVTZaYWVlNXdSZ2s3QWw2N0JHaG5jWFlPUWFsejJTM2NFN2xm?=
 =?utf-8?B?citnRlFsMkc5UEhzZnNmYkphR2Z1RGFnUGJ1RmpkSXdFNlVzbjc4cmYxU04r?=
 =?utf-8?B?Q3RrWFVPbTV3T1NVK3JXN1ZxMWhQTDZXRExaMHhCbG44NzJuUFk3SmtZWXNh?=
 =?utf-8?B?aGRoK3dadGNZRHFUbk5RQjdtb1RaZ2Z0eEFWMm9iZUo2WTBEMUpjZmZqYlly?=
 =?utf-8?Q?BscA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHZHVmNtTmNCZmRUdExiY1NXQ2cramNTM0FWVVVDUG5EVnd2MzlacXFJYk5q?=
 =?utf-8?B?N2drVnF1TWVydmtLeDZNK3Q2RmtONFJBNWxIQ1JGbnRYc3lIcXVqdENTOHJn?=
 =?utf-8?B?bG9EbXd0bVlabnJiY2hGM3pXZVZMaEFMMTBHNUJSaFVhbGZBU2Npa1lxdEps?=
 =?utf-8?B?cHhWSmhrdW1laGwwYWoxdmZrNmxQVU9IUWVvbFBhSmRtYWVjRzNYODduV2VU?=
 =?utf-8?B?TnN0WllUc01YcDhFeS93b1R4c0UwQ1YxVDR3cHRTclpZN3hBTGRXYis5TXBa?=
 =?utf-8?B?RG1QMjBLemxoMGRubzFkYUdvQmQ1Vzd1VmhRQkNBU0d4MWF1Q1JMWk9lZWoy?=
 =?utf-8?B?Y0xHbmhwYTNrSjVqMG9QcFFzMTVQTTI4cFJkNGRuUmlCK25TNXh2UzdId09S?=
 =?utf-8?B?VG9Va0FDUGJoNWprZm5pVm1vQTR4d0lZOU4vUjY2Qy85YWxJekh0M0N2SmFE?=
 =?utf-8?B?K2kyVkhFS2VLL0lOZm0rRGJuRVlJNGpOd285SVYvak9KUTBmalJjN1A0NkI2?=
 =?utf-8?B?R0x3L3ZxZytFVDV5WmxnMlFTbXRIWStQc2tUemtjZDVWQmMzTlA2TzBYQnlL?=
 =?utf-8?B?K3RBWC9YWnRtV0R0OGRyakNsN0x4TFhMWHBpZHZXSmIzUzdiN21yMytyTTlZ?=
 =?utf-8?B?R1B0V2Nsa0FIMEtOMWZpOXhKNGsvN1BJZ3ozQk51cDltMVFnMVpaa252RDFn?=
 =?utf-8?B?S3RPNEk0TEx6Yi9Qa2xRV2Eybm9jaHBFSGpCdXNuMHNvYjZlVXhuMUdDVWNt?=
 =?utf-8?B?UC9QVlJaYisrZEJiaGtJNGpiZ2FLRFJSTFd1a3h6RVR4ZGN1K1pleVJGVDdS?=
 =?utf-8?B?YVJnQ2J4RnZ0R0V1eWhXNXB0SS9tYStvVjJici92a0VLem0vMXcwS2tTZGFr?=
 =?utf-8?B?T3RraW9BcnBvZjVBT3orL2h4VGViNXB2UTZlUCsrSWFKYkVjbnZWNW1sSlpj?=
 =?utf-8?B?UzkzVnZlZzFVTkFuZHJDVU1WMzJFTmJMbU0xcTZGak4wUWlUTkxZWUtvV2NJ?=
 =?utf-8?B?N2I2V3F2ZUc5RG51T0J1MG1CL3RrUThielBYamlCQWV0QzRyQjlOdG9FQkVB?=
 =?utf-8?B?bmtOeUJRUmJLREZLNlJyb2IvVTZNKzY1M0hTMjhsM011ZEU3RFQzRjRoSUVT?=
 =?utf-8?B?Z1NWNXpxblZRU3JkWkxLdzF0aXNQckJSbDljbjRnUnBleTVSZG9sbm5iWXhF?=
 =?utf-8?B?UkN1NG1MN0ZTWUgySkxUaXRPbmhVWHlNWisyWmlmWmE4amVIa1BIa3JHYUJO?=
 =?utf-8?B?a3dZN2lzTGJQV2ZPWXFTZUQrYWFUY1lIU2cybXBHZEU4RS9mUk9neXl6Zy9h?=
 =?utf-8?B?eUgvUVRDU0pZb0YzVUJxajZ0SnBXVDBVTndhZ2p6WEpFNTg4ZDFJNGpxRmlo?=
 =?utf-8?B?dHpmcm5tWlJHeEVtd3A5ZGhpWkhhR1Q3N2lKOG9UNnQ4NHBjd1NHY0pJekRR?=
 =?utf-8?B?Y05PMzlmTU9udzY2akl2dVg4bjJ4bFQzakNPcFJwVHJGTElneHFBZ01IK3ow?=
 =?utf-8?B?d3ZvWlpQenRoelNad1ltSXl6Z3hWUTVlMjFVNUh5TmEvcS9UN0p5WEFlWjIw?=
 =?utf-8?B?OUNWOEtkYUc3dlc0MkxDall1MmEwdTFmb3FJd2VvOHVVS2E3bEh2UTQxSXF0?=
 =?utf-8?B?VUZwNHM2c2xURkRLNk9ISDVDdThLZStoek1pc25ndG9EL3hYb3BZM3ZoWUVG?=
 =?utf-8?B?cVUvT1A4KzFiemRVbmw2empRYlh1K1ByT3lCT295R0pKNGVJamlyYStkT3Ni?=
 =?utf-8?B?dDdlQ3hjTTJCQkczNk9lNTVoY05uM1Y2V05JTFRXaUQxTkNkQmFWVDVpdVJN?=
 =?utf-8?B?V0NQMWs0U3lxVEJrL3lna1VCTU1NSS9hanZvcWZmQVlFOU1TRUhHSTNDaXkz?=
 =?utf-8?B?QWZZblo0SWR1RkFyWkFVQVMzWER3ejVSaFVhWk03L3ExNjJBbFhobll4ZVFF?=
 =?utf-8?B?ZDFCZ3gyMGhneDcyU3NQSmVLb2RBK3VpV0x1b3dVSkorNitMUWNneDh3b0JU?=
 =?utf-8?B?MFUrV0ptTUlFdWkrdDlOSDgwdXJSaUpxWEM2SHYyWURLTlhKUHF1K1BuQWwv?=
 =?utf-8?B?SFlZSmlqdUlicFJtQUxRMHNsVDJ5bDRBR2VSbXFiY2puUHVZNGZSWXpaNFBP?=
 =?utf-8?B?YUpLek0yRU4rZEx0cGpKcmVJYnFhc2FJUEZzVnlYT1VJenhoeTdQcytZVUtT?=
 =?utf-8?B?aWVTZGZvV01pRmJ6Rkl2YnBiOWJnalBEN2d3WmgwcDY4RHdHcDNSV3Y0L3Zq?=
 =?utf-8?B?VDd0WUQxRFRhRnJqaUgvTTZwbHhXdDVlSEpqVUVzekszLzM3N25POXlSSmpR?=
 =?utf-8?B?dDVTSEdlM2k4NVNoTWMyeTRGSWs1clMwanZQU3dpU1VLVVI5VnFZNVIxVFZW?=
 =?utf-8?Q?eux0N6SzWpR7tb88=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bc90f2-0bc0-4341-b95d-08de5a033cff
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 22:11:48.8810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHcM25GaKPtwVld3qxcZLWe8p8clIT9g1XxAaJQ+7A2tVOLxDCt7VVwDm8ThgR8KCIS2LqhyOeS3Lqwr7uNXl7LIGsHBYry1K1swfumJblw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8152
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 21 Jan 2026 19:33:28 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > From: Terry Bowman <terry.bowman@amd.com>
> > 
> > In preparation for CXL VH (Virtual Host) topology protocol error handling,
> > add RAS capability registered mapping for all ports in a CXL VH topology.
> > This includes the RAS capabilities of Switch Upstream Ports, Switch
> > Downstream Ports, Host Bridge Ports ("upstream"), and Root Ports
> > ("downstream")
> > 
> > Update cxl_port_add_dport() to map the upstream RAS capability on first
> > 'dport' attach.
> 
> I'm struggling to see how this maps the endpoint registers (or at least
> how it changes that). So maybe the patch title has become incorrect?

It is time travelling a bit. The new / common devm_cxl_port_ras_setup() helper is
going to be reused for endpoint RAS register mapping in a subsequent
patch. So this can be renamed:

cxl/port: Map Port RAS registers

...and clarify that Switch Ports are covered in this patch and a later
patch adds Endpoint support.
