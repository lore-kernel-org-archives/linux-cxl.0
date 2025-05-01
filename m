Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C55228
	for <linux-cxl@vger.kernel.org>; Thu,  1 May 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746113590; cv=fail; b=SZpyiO5FVkzxZMTwKti/Uooia5LkFbjXfMb1bf8VvkKyYt9Bsyo6BU3qj793eSjxQiCcQ3sXrDs6YUZLtaYQxN72/7i/DPtVV7yGlvIEnOt5gx0zlpCQVWtoxn/1sTHOBKxCo1MISQxWbdztBCnLfES3TBvGSE6ZytYHoMsxJ6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746113590; c=relaxed/simple;
	bh=bqgZurCEUbx6ozYAtiZfy7Q/ZS2v94JbxxKYdouXdcY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=WtBVnjrn/wJ9w7wR/O8zfJsnwtWKDRTIXaxlQzPRNIfxD4ZI0hBeQAzr3F9ZwLiC1l8/rDXuWeioHYEdkVlAeXkh7M9yPFSI23Eml03DwMAUIb1DXn1PK30P3Vquj6+B2FE8HAoSwb3Tq6PSRC7DoGv5zEH/H2DGMUswsbHPIr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSr0VWcc; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSr0VWcc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746113588; x=1777649588;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=bqgZurCEUbx6ozYAtiZfy7Q/ZS2v94JbxxKYdouXdcY=;
  b=WSr0VWcc+oWgxYAyzxtjEwJ4fQXoiEvbHyp3U0aP6Kgt2ahksJ3aXGkC
   ozbnNCu9ONUVMaeuTxGuTg6QEffa5UaXMb9WI2oFEGz/g5/+DZPnTNKf4
   H/NGy2M5Pb5MaOdsjWJtK7zyLXCtjoh0CbnxXY042Nc/ES37k1IWDHXHQ
   JihfbTYXWIryLuj9bp/T2rQ9QA4JJb21W3TRqbumZt3KDnDYyEvBwLn25
   uHMyDlXettLNXh6v/8G2jEjQh7TUw5HxdUnFIrMmCgixECq7TLUrph8k4
   yw9E1kxo8G/Ia/yIOONKpcE7X4fdD40XGlm8kqyda8EoKO5lVwfPlUWQ4
   A==;
X-CSE-ConnectionGUID: hixFmRAARHGAyFxuyjJCEg==
X-CSE-MsgGUID: lmn4msD7SwWqvu6jqnh8hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="51601599"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="51601599"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 08:33:07 -0700
X-CSE-ConnectionGUID: FK3YJjVWRP2xD882OVm+KA==
X-CSE-MsgGUID: hULn3lnDTvmZpT8MYAW5tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="139588392"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 08:33:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 08:33:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 1 May 2025 08:33:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 1 May 2025 08:33:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKrwDPaUmb0WEZ4s/4CMYCVnvWeBDYLTayV025gybW+700cvxpV3yCWLM8AYnT67CXsqxVeqMlt3sc+Zff3v1z/cbnv02J1Yyaloj+/JwaUFoEMAAiAOwNXq89Fl+81hiGgZbwout6vTHtzzfmQpQgeUpjMPuX020E8+kKGC+WxQYm4/9ruMzC227dOTEBlnhYemg4hen+zahSvZO4WYw7LxiuuwAnowvy/HcixtpYehDIa5GfUXjm0cRakLqiLJm2Un/f/1pNm09MHKGiEOsqpe0xf0ldTlM17v9MxUbs8r9p+Guakc8DzOjMmLk8VxUG1p7l9gLczxROUsoVbnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGlgqE0vKsUnXWyqrdrTLpJuXXpjtyU8riLPWAbsrZ4=;
 b=ozMbJ6O2G+S7Jyjg+VuGkzvsz8PyW1ZXJl3i4Agert6BGWbZeZ83PB7Ar+bsAPlHG+pTbdAYFtGZzzSJapQxx2bcWGixs0g2mr31m95Nvu9knY+xKYdIgMSTQkis5itO7nPBeYXYFYAtNOAF9x7VIohaaWpkiGkgJl0e5qexSHeO6PLN6An+m0hUfwQ/av5mQppU5jBwXtKjGz6ABN+HGh33fRmBFgWm7SH62dn1NC5SYfHPCN3FKMUchkHcwfRStPkMWjCDqvLlLXrkgYYZjExMSpxrwqXoxV+hEzKszGjJRKoCI2DUt0+6EcQjBOidO3V4K5xSTj4V6Sl2jeh/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Thu, 1 May
 2025 15:33:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.012; Thu, 1 May 2025
 15:33:01 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 1 May 2025 08:32:59 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Message-ID: <6813942baf2cb_29cd51007c@dwillia2-mobl4.notmuch>
In-Reply-To: <20250429235953.4175408-1-dave.jiang@intel.com>
References: <20250429235953.4175408-1-dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/test: Address missing MODULE_DESCRIPTION warnings for
 cxl_test
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: b3dcf836-0e15-4de1-e6c3-08dd88c57558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFA4dldmWDdaL3krOVRIZ2RHdUNIZ2ZBL01KbFZkbWJjeTdScEM2OHh5OG9T?=
 =?utf-8?B?TmdFQkZmSEo2T1BLQ2pQSFplcXhOL2JGV0xTMWpsQTJiVFNBdHRYS01RMk1y?=
 =?utf-8?B?MmJlcmRIZXRlRzV3RERDMkp4YWxpVldpQmhBUHdEakxJSktTMU54ZjZhbmtS?=
 =?utf-8?B?ZnliV3hsaUFmSytzVG5QUENWSlkzT1R0Z2JxNTh1ejFUZUxsNittcWM3TTZD?=
 =?utf-8?B?OWQvUjhSeU1FbWhBYlNyUDdDOGZLK3ZlYmZ0cDNscUcwak53Z2hVREVxcW95?=
 =?utf-8?B?UFAybFl3NTRpK0Ixbkl1UDVtVllzSWN3QzllbllwNzU5OGo5QUZwNEFYYVNp?=
 =?utf-8?B?S3ZUYjVqQUw3a29NTDAyS21qVHQzRW1OdXFxcnZEYkZnTkY1T3NQSEdHQW1q?=
 =?utf-8?B?Q1ZGTURrSUVOenhyR1JBSGl3YkM2bjhHVHNPcWJrcDV6dlpmNEtMdExCMzFt?=
 =?utf-8?B?OVNsNHNqZWxBc0dBOHIvdEFtWDZScWxpTnZ1R0wyZnNNU09sV1ViWDhibVlG?=
 =?utf-8?B?cHRoUnJibEFzQ0kyYzdEKzlsMFJXVEtrRmszZE9Idlc5WG5nNFlNRitadjg2?=
 =?utf-8?B?bVlZdzR3VUdmcHRSZFRpcEZraFBoOU9NS2lxMU02dXIwMlVZZHVRZU5LOGoz?=
 =?utf-8?B?UGJiQS9QUTd1VXVBMmFDcEQ1a1JBbHFDUXZUcTBnY0tubWE1VkJLeUNRNmVm?=
 =?utf-8?B?VWN1V3kyOEtHREJLWG1yZDR4eVczSzl0UzhZUDFnRXpuSFZKTEZxU1lWSXh3?=
 =?utf-8?B?NVlDMVprSEtZR2VuRjNHOVhmZlpkM2RhbDZ5UHI4ZTRlUWovL2VmcEJ0YU83?=
 =?utf-8?B?MW9QNmFRQ292aWVQZU9LSERTK09td0Nnd1hNd2RBWUxNQk1pVVJhVy8zODls?=
 =?utf-8?B?d29PNGFoZG44UHZSZFZ3dGdvb1lma3RSYUpyVXZ1NW5qdXJ4aFZHeTNuZVVG?=
 =?utf-8?B?ajVZc1hia3QvbEhnZWYydWY2WEdaTmFCeXJQYjZVWmtSaHhibFFOVGZHMGEy?=
 =?utf-8?B?QVZrVHVEclV1cEExc3hUd3dJamNaeC9ZR0EyMVN5NXI5bGd6UTc4UWdNV0pL?=
 =?utf-8?B?YUpuNWsvcm9RaEdsdDg5bElLVzJOd2NXWTdkb3NrUU9LdTNKVFJ3UnpTZGZ2?=
 =?utf-8?B?M1llRjFQTHNPWXNLRmJzVzlUbmtSaFBzTHNqb0xoK2hEZVBIS1N6aktxSE95?=
 =?utf-8?B?MnhPa1IxdE82RmRwdmh1ZTlWTW1JWUJrS243dFM4cXJ4NE45R0xHQTkvYkVD?=
 =?utf-8?B?WjlqVmtaNHREeEQzdEZOTHlqMU9BL05BKzBZM1ZRT3Ezb1UvWStvNnBXaFJ0?=
 =?utf-8?B?Y1RTMWU2TWhjUktTc3o2QzkwV2NadGR0dHQrWSthTk84cFlad3c2U1MyS3dw?=
 =?utf-8?B?QU00VFRObUd4MnpBdFkzRksvTWp3RVBiT2lrTURkS0ZVVVNUd01CZnpldC9M?=
 =?utf-8?B?WXVUMCtNa1dRL2NBeVBSUGJMK2dtQm5mSGQ1L3VXVlRtUmNxNmxYQmttRm9j?=
 =?utf-8?B?SEF0djN4dVhDTHpUUytkOERLMnQxTmIrNWwzd2ltZ3RjMnF0NXZiOFZVUHJt?=
 =?utf-8?B?UjVBUU03ZjcrSFpJWVFQOHcyK29TcFFUVUNuQkdHd1dqSi8ycFdreExSU1Zk?=
 =?utf-8?B?N0lDeW5GcUptNm1TYmR0bGdVNGJoUGdFeEpPcUtNM043Y2xqT09HSGxIOUxL?=
 =?utf-8?B?cmZIVWN5cUk3S3lWaVljMmVMVUZHTEt3dU1PQ1BlbUlqQm1EMzViV0h5M2NE?=
 =?utf-8?B?L0VjWW1oZlhRam8wUUVXMUkvdy84K3o1REZyUXVySEtXNkVLblk3SU1zb2Rx?=
 =?utf-8?B?Tzl4Vk54OG1sSURHZFFZUGUwc2NMMmRoVGNyMmZCaGh2MUQ5ZW5MZ3QvbkR6?=
 =?utf-8?B?c3puYWNySzdQbUVCQ3NPazhmZzN0SU5XTDBWY1lKcnk2eElvc3dIUGVQTXBt?=
 =?utf-8?Q?Rs0YuIPULIk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnpyMm9wZVJGaU1ZTExQYnNBM3FCQnRiS0s3NEhURjlFc2VnOUtUTmlDb2Ry?=
 =?utf-8?B?ckFyd0VveVc0eU5ZVjVtMU9NdlBiekpYZzdxdHUvWjlKUmwwQlVDZTdYeEJJ?=
 =?utf-8?B?eHlHa204SlcvOGNnV3R6RlY5NnZpNXhWOVh6UGV4TjltRUVPK1dRbktZS0pP?=
 =?utf-8?B?dVN1amN5Q1JibE5OTWZlVC9aUFZ2bW5KL1c2NnU0RUxKdjg1Ymk5WVowVFNX?=
 =?utf-8?B?S1lOVk83aDBORnJqQUcwNEMxQ3lRcTNYNGw0dklGZUxYTkc0U3Z5T3NkeThy?=
 =?utf-8?B?Y1hQU3RPNzJGcy9ydlU0WE1rYlEza0s1YTFUd1ZiOWdZRnA4d1dFVzVMZWdm?=
 =?utf-8?B?WUtRcmtUMXJxQTBScVIzQm52dVl3WEJiYitUSWhUUGFNUmtyR0lqTkdIYlNO?=
 =?utf-8?B?WkxBZ0RwL1duK0lsOWV1RXlWZUF6cmdXeC9zUExRa1Q1c2Y4eDZtOXFLcS9T?=
 =?utf-8?B?b0ZLZjZGSVRDY3MzSHkwMTJUU1NjNlB1VTdvQ0JsN2N5aUNBRlJLd0w0OFV4?=
 =?utf-8?B?TlRsZ2ZxM0N3emdqRDdCcnJ5Z3F0bTIyR2oweSttaklaeWNsYkNleGNUb1BN?=
 =?utf-8?B?aWxIU1owdzRkTTZTYk5IdkdwQmVRMVpvdlhwUzdvTCthWVlMR3VwYlFWWjh6?=
 =?utf-8?B?NmJsa3RhMFhrYnlGTFNtNkVseldsdjlqa25kdzZtTFFtMnlUaG8vR1dVOFlp?=
 =?utf-8?B?dC9vOFd1ZzQ2OU85WkpQT1BvOXFJZ2ljUFFSSmVlN2lUeTJvaG84YjEzOWg5?=
 =?utf-8?B?b2FmV1kvUVFVb1VtV0ZOV1NpRUo4ZlBrWHlXY1lrRXQ1cktOeC9pVGJTdGhp?=
 =?utf-8?B?eE9pYjBrN2Q0S2pFam0rNUZsRlVLbDdwK3NLVzRDQ05QMEJLQmNlajRzUUhN?=
 =?utf-8?B?SVBXSFZ2eThsdkYyOXZBNXJ2YnQxN1E0WVhDNnNNc0R3ei9KWlhYTGpYMTFr?=
 =?utf-8?B?ancyZ0FXRjV0VEdScjNIUUZHMWNhRjA4RjRKbHpIUU5tTEw3Z0NDTzNXWnhH?=
 =?utf-8?B?VlIwbHlQdFRESEVnU1FJWktQYjE2SzlHd3hhMDZOTHdINDdDdTNqM0JETE5i?=
 =?utf-8?B?L28zcUhZTG9sRmFFT01nQ1hjN2lEdnFCaDN2TWsrY0xsMEp3Sjh6M3o1ZXZt?=
 =?utf-8?B?VURBUzFsenp4U1VidEtGcFVtUTliVUtTdnFlYzBzRUw3b0NydmxHQURwcjJY?=
 =?utf-8?B?cUdwREVLbFhXWVZZdWsrWmVlTjhtZGZ6R2dUUGdsbU53Z2ExejhpZkVBWS9L?=
 =?utf-8?B?N252dmtvelNCN1lkaDZKTHdPTE1LcmwyTzZqZUppcVl5SFcwOEtvNU0zbGVC?=
 =?utf-8?B?MFJKS3lLUm1NeDZKcmwxWC82cVAvWHBkSjZrcUs4NVVVS20rcHJ0dUZSM0dU?=
 =?utf-8?B?QVNKcDlKVko4akhmU0tuRUp1SUZYUWk4WGVKdHlLVmNGdjlMQmV3N1JFb29P?=
 =?utf-8?B?SkFmUkU2QjdDbmdDKy9iZlNpNnowRTJNZENsQmZHK3hycTRoZ3BqeHdLZ1NL?=
 =?utf-8?B?L1ZJaEZyL0h5NmxiTEVWRDJiR2M1MDlQRHlPK3BhTWh2eGdpQ1l1UmYxN2t4?=
 =?utf-8?B?MEk1QjNqaXV3TTg0NFg1Y0FkQUpjdG5pczlXcWV0NFV5VXRYKzM1OXJwTGRu?=
 =?utf-8?B?eWpyRDhiRmZVbnUxdWx3eDJCWEJPM0szR005TjlCVjhkcjZKcnRjUFh1M1Fa?=
 =?utf-8?B?RDZUblladUpXcEUxZzlRSnQ0NWRCZGlDWXJOS2Z6TmRuaWpkdHBOUlI1SFlH?=
 =?utf-8?B?cWZ3d0c5dzlJenpyRW5xbENEZWZrS1JLeldZaVlIK3BkOTd5Tm1PcDFRZHFj?=
 =?utf-8?B?cHI5NzFVazh4NXdVZmJHRVN6MFFnODNrS1QzOHFITDZsb1poSHBhd1dqY0Fi?=
 =?utf-8?B?YUI1ZVA0MlZuWFQzS0wxQ1JtTUVNb1RaQm1pNXkydC9LdHpWRDJtOC9qVVo3?=
 =?utf-8?B?SmdreXpzZ0dwUHVvSFIyTEdRdEMxRTR2RnZxRUNFdXRyQk5ZVVFlVHZxcWUy?=
 =?utf-8?B?Z3NoQ0RXWFo4NVFna0N3TFdhKzltRlREM3JTeFlCK3ZzYlFoOFJHVFdwT3Zx?=
 =?utf-8?B?SkV2b29wZXNtbWk4bGhUZVRVRWVXMnk3NWk0TEV1czN5ellHTUVZa3U5WDR3?=
 =?utf-8?B?SzJrQ0JPS2JVK1dXQzIwNnNqcUFJcWFEQ0NPQm9BWmFGWVpjWmJ3bTViQ0Yw?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dcf836-0e15-4de1-e6c3-08dd88c57558
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 15:33:01.7375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rm8U3mGh6xkyQsCHCze72IF4TFn3jlWD/6FmybkGgjXK2sU5VVywJfuC96dZSF5AR7VEHjxc1sSgZBO/pEoTwrkAT1FqGXtckN6qDYxZuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add MODULE_DESCRIPTION() to address the following warnings:
> WARNING: modpost: missing MODULE_DESCRIPTION() in test/cxl_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in test/cxl_mock.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in test/cxl_mock_mem.o
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c  | 1 +
>  tools/testing/cxl/test/mem.c  | 1 +
>  tools/testing/cxl/test/mock.c | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 1c3336095923..eb36408d287a 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1527,5 +1527,6 @@ MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
>  module_init(cxl_test_init);
>  module_exit(cxl_test_exit);
>  MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("CXL test setup module");

In all of these I would s/CXL test/cxl_test:/ to clarify the
relationship. Other than that:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
