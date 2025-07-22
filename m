Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F9C27877F
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203995; cv=fail; b=NX79naLNlwfqjEp7MdfocqG08lVGHcsMG3ibDHdV+FVSs7hi/UoHjHJIsMkIhOurUXx5EBto+0QjpniYdkZ33Tk4tt2wqRBDPqV+QpWy27ezv60NdnxbGLIb5rJhqyZaY7LW3G0pRJ83eFfCho9A/qGD0x5NQuQq9Qz7gfwKgGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203995; c=relaxed/simple;
	bh=jGbvWBtNHGwNxZeqGdRPoFzscqn4PFcNJ8PXt6cqOCc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=TTF8yq3oFVACYJ0iLs9D/IeB4WrMD2hwYzRXbVi6+ncQDPlj+mxIXSwRHjBCN74btld2sUodINefZGMxhZsibg91DHhfXw5f2A1ssPiYmkG3lI08wRkJU4LvSXi3B9+QS5mFjhbldDcPqWNW98hwlLusvipSi7YYLTdxc55RzGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XCjFsifV; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCjFsifV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753203994; x=1784739994;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=jGbvWBtNHGwNxZeqGdRPoFzscqn4PFcNJ8PXt6cqOCc=;
  b=XCjFsifV/G1qGf86VJcgMggYw79g3S/TV12CTpRSXHhRmVr1r2ifGKUY
   Y2prXvwGSOyeJemuax4iVauWTCpmk5ENyFLhXdF7hOytLE+jJzwkHJZtw
   I/ntP0Py/TROfoNiXVRO3M+wnKKr+/JOejYbSVO7QHFZfIReQFqCMz/My
   oya7dbL+y9q4V0jqPkvkbzA1LFlQubW9EVjSuPknnnMME0cLCmE5x1BN7
   vCiUUusUTXc7klolR4cK/51qO8aDDoc2bMpsVtqY2YYrXckOjh4lCJpqz
   X2OS34jlrVbHb4yA3xrU3LOKPxcgZo8NJJZO3xj6Jvy/xcO+mO3h4fVqv
   A==;
X-CSE-ConnectionGUID: y6ZmAcJqRWSX2mX945JGPQ==
X-CSE-MsgGUID: J7X70BrQR42kSEHm9Z/i9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55560626"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="55560626"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 10:06:25 -0700
X-CSE-ConnectionGUID: L+B3u0iTRauZTr/+4qAgCQ==
X-CSE-MsgGUID: S+n4R1Z7R6mK9KotlLA+3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="164660939"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 10:06:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 10:06:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 10:06:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 10:06:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kc2Nq3RDVGq9vdGYQCOj06/nvQwxd3S6wk4k9R8MJQWMbCUzz6dDGX9EObuC8DMSf8NFMw1eUp6KduqC94waWmQHfIOb8NXzYwkuOHhAwdMePaIA8dLlUn3lOfx5ypWbYpAlqweeLWbBJM970A8cWuT3U2TkhWF+W8VuuziFyu/wE7KVGaYS/s1bPX1waPeJl5ZuIxViTvFco7yxiZbSJKldIYqBUGfVCUdd16E1eZ63y/o4BbYm9QTnNs7QlA3idOab0FWp40DY2Gv8TTIJcvPczEIw6l3DoqjNQEymCfhLrMPvGtTp/EBWovdjqkPhyZkvAT1/krdGQ5cwZYQ//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX6W2CAqGsiTz9kQHRimZryRabdS2XuZRMrsG3KtU8I=;
 b=Nsi23Sbgtzrhrlm9jrWkod6STdqTUxKAXocBOIPZ6+iI4mQmyOpHOGY1FoWq8Sdk9bObY4Z6jg44kYK93H8SpGeIE0oyfh8INmmNlCEzXIrFv4hdk9hkk1MUMPN03UxoQfpPx+Zu1TsXMhL1h703M1dmc6xc1nYmdE782GF2BExtXbvQRhHPhS8+A3fDqM8frV6zxZeKfXS3NJJ20G9OhmwobGkixLnVVZk83FgVH/d+ur+wlNELzva4o6wn2/U71iJreZukuKMFlzEJQab1gaQxsYEHzPFpM9ncsD4UqdylFmPDNfpi9nnYBznza6Frp4e26TuzE/lBNHy/VVK+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Tue, 22 Jul
 2025 17:06:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:06:11 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 22 Jul 2025 10:06:09 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>
Message-ID: <687fc501db317_134cc710021@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250714223527.461147-7-dave.jiang@intel.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-7-dave.jiang@intel.com>
Subject: Re: [PATCH v7 06/10] cxl/test: Add mock version of
 devm_cxl_add_dport_by_dev()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e223b1-8fdc-467c-1c99-08ddc9420f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWRDb2duZHEzb2VsaXluUFdHT0dCdTk0OTNiUUlpelpKb3pyUjNLZTBzOTgx?=
 =?utf-8?B?ZDJJejFPdS9tdlRCdHM1Y3g4OWREdUFtZnRZOCs4UGRDK0dnZnE3a1NvcFB5?=
 =?utf-8?B?ems1ZjMxU3RKWEt0dXJRRkZvdjZncTVWYnVQb1pwSnFsVHEyZmE0SFA3S2t6?=
 =?utf-8?B?bzQrZDU4T0tBR1V5ZVpDTGx1SWxBMi9uVlM3cTVoVDdGNGpsai9RbDB4S0dv?=
 =?utf-8?B?b2hnR1B2MloxWDdXREVDamNDRTRMbExNLzdBVmZzQXdjWmM3RHhYZnBwUE5H?=
 =?utf-8?B?T1YzZWZ6T2NUZUozdityaHh4dDQwRVhxeU1rdnZwVDJjOXdjWk5ndHRPUC9l?=
 =?utf-8?B?NTNMN2ZwclgxRHlWRnd3S1NCUzB2RzN4ZW94Snhrak1rOXkxUmUrUlJXL29s?=
 =?utf-8?B?Q0ZZU3ZPOGw2Y3BiUStibDM1dnVrV1pGaWJMSHBpSFplWHg4NW9sZ0xpOVBB?=
 =?utf-8?B?UUpVeStZVVlNRFlkbC9LTVZ6TGdZRTl2cTBqcGRVT0FYanczODVtSHY1WGo3?=
 =?utf-8?B?Rysrd2pNV2JJTjJxUFJjWnZtdVl6RGZ5WjBuenRyTFpJdk56V2Y0RVIwTTlD?=
 =?utf-8?B?WWtYQWo4OXEyaHg1K2ZZMGRPYy91cHU4UnRyM1N0d3dLSnlVZjBBZDVBNUNj?=
 =?utf-8?B?bXN5endVOFV4STBMYlVYV0pGVmZyb0FOejUvajZ0S21tN0lyZG40YkpCaU5z?=
 =?utf-8?B?bXlycitzbytxTi82TmliV0VxQm1aZDJPVytVTlg5TFlEV2E1SENiNXQ5U0E0?=
 =?utf-8?B?OEFGYksvUGtGZjhYTmlFaHY1S1dPNmRWZE1HSFYxcVVGL0d2VmE2MldvYUs4?=
 =?utf-8?B?YTA5QWlpRXdWWjZPZTFiVTZVY1BwSW85VVhreEtSS2xIUXpHcUdtVzdYbW1i?=
 =?utf-8?B?VnNqS3UzV3A3Mjk4L0x0NUJzWkl2cEhBa1MvZHFNV3NUWm9lUFFEdzNQbWdn?=
 =?utf-8?B?cGJwZGRWR3RXbjZsekhHTmZlV29vbVFLWGVWUHRJdWtERHhTbjJBWmZXclhX?=
 =?utf-8?B?aXZJOFJWTWRBb25mSzkyV2FWQUJaeExhemdiNGs4Y3pJTWR4WUpIbHY5RjI2?=
 =?utf-8?B?MW8yMDVnT0FpK1F0eGQ0TlBBd3ZMNUtPc00vY3YvTkNaMmdkakc4dXE5SlBr?=
 =?utf-8?B?MkpVczd0ZDRqY0p0R2gzajFJOFFLbWxWVzlVY05xalhTRFFSOWtEWGhZSngy?=
 =?utf-8?B?d2pVa1dIRVl6Nm9qT3RNQXJjb3FGc3Y2QnRqY2FJTXdiYWlvSkR1L0xEUnpC?=
 =?utf-8?B?a0J0bFdBSlB3amM2VWs1RFBvUHdEUlVWc1Fka29sbm1oRDBNNytUVFpCWUJa?=
 =?utf-8?B?WmxDSnEyOGl2Q1crVCt3VUtnQldNY0R4UUJTbi9WNFEvOTFobG9BcmpZd2NW?=
 =?utf-8?B?TFVnZEtIU2dBeVZQTDlnd1FNaVhUVXRVUjRGRUF3QjBpMFI0bGNVanF0RUdM?=
 =?utf-8?B?TGs0RDhGYktncU1lMDJxd0psenlsQmMvbU1jVlgwSnF1b0g0TlZHSjN2SEc0?=
 =?utf-8?B?ZGoyY1NRWG9hRXF6Tk5EM1MzQkptWkhHd0V6Ulk3T0srQzhzL2w4MklJamts?=
 =?utf-8?B?c3IvdEtaN1hFaXJQNm5VWHQyUmJKRDZ5aWl5WFR0aS93Z0RjVFlSczc4eTBm?=
 =?utf-8?B?RWUwWG1XcS9IMjJtV1dtdjBnOTd0Z2VWdzRuRUVpaWR2WkdrN1N1OE5HazJh?=
 =?utf-8?B?THhyRkNYM09nMFl3QTBVR3pZTHVBZzBGRUNaclBTa3FZY3Zia3hzcUx3S1o2?=
 =?utf-8?B?RmY5VDNlY3g3N3VId3NGQ2pDUURTaGRXdWora1J2SWh6UUVCVzRXeGMrazM2?=
 =?utf-8?B?eU81KzJWM1ZjRi95QTdDYU5nZEJDMnQ5ZlpXcmczTGVDNnVWZ0o4ME5WdG5W?=
 =?utf-8?B?QTlMc2Fpd3VXREZldW1PQWM0cDdoYjkyY21yeUpNQzJYY3M5R2l0STJKelI5?=
 =?utf-8?Q?2XnaE71J6rQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVdwbXpPdTN3ZUFhb3IwNkN1YWZqYWRPWlNjQUIvaThQNmJGQkhuOE5rTlpU?=
 =?utf-8?B?b2xMYjk5SmRRTk0xNmR1TllPeDZEVmZHb0RwazQ5bFdaNUdIZ2tldFJUaE9y?=
 =?utf-8?B?Zm5lMTEzT2xGYXlIeEJOUkNMVjNVd21JNnlpdHczekl6WDRVb3RObGwwdnlv?=
 =?utf-8?B?YnJkalZ2VVZLbjFMY1FIZnA4MkdpbTRjdEYwSGpsV0RtVTBXRnRNV01HQVRU?=
 =?utf-8?B?Qmt0aVJXdTBJUDFHYWVDbU5CbkFPM0VYdXUzYWNicTg4TG45QXB6bGhTdDVP?=
 =?utf-8?B?Z3pEMUpKL1JNNy9HQ3VDQWMvUldqdUpFcHlYSDVrL2RYZ1ArMlp0RlhkSGdu?=
 =?utf-8?B?U0dDbHRKSUVsRUJNQ21wWUlWYW1MNVAzZnRrbFB5L29iQTdSQjJ4empZTXNO?=
 =?utf-8?B?cGFxOE9iWURJQmlDdTFOY1hJaUpFand4RXYyc2FZMU9ybXFTSkJHeCtIYThZ?=
 =?utf-8?B?RjNKS2duRDgvbHVtUUJuWmZSOE5aYVI4TGFBck9tM0VtTHVFSkR2dkIyVGNh?=
 =?utf-8?B?ZGdHbjlIbWl1M3YvclVzd2cxeFZmbUdmYURrS01tM29zZlJFT0YxdHRDdnN3?=
 =?utf-8?B?MFJsOUROVFRza1dRU01JT3R0WjlBZ3hRTGsrdytSeWkxYnJjZk9Ja1RXajhN?=
 =?utf-8?B?OWNNOVZ3TmpVZTduVVF1b3FaN3AyYmQ1WVAwV2kvZlZINUlPWW5oYU51NFhT?=
 =?utf-8?B?WWVzOXlseGlGTml3VHgrdjRNSFhFd2xBREN1UTg2QzJ4cEJqSDFBYjFTdm93?=
 =?utf-8?B?R1FPek4yTFkrR1BHN3QySnJyOURzZXpYRDg2ZFR1aXJveElRd1BaUU1jMlhL?=
 =?utf-8?B?OTh6WU5hNHQ0OC9sSk9FS3JseVV4ZW9kdjh6S1Y1c0lKaWlKb2VqYnNuOVd6?=
 =?utf-8?B?aHpSN29vZEE3bDRrSVoyNy81dU0vb2w5QzJXNnlzcUNpaGRjbFk4cDgvZDhK?=
 =?utf-8?B?Z0k5T1lIOFF2TzJVTThORldoNVB2dlRBV2JaL25LSnhuZjNWQ3kxTUZpK0R0?=
 =?utf-8?B?UnVySU9hVlhRZGJMdTNrd1JVSG9kRjdxRS9vUUpWMEpLNjRucnkzaCtRcWN1?=
 =?utf-8?B?R3dkY0tJTUFsZ280Q2Z2eUNkd1RBNkRBRm9FbWJZa0FPQ3hYbS83YWRQdWZm?=
 =?utf-8?B?aG1IREtMeDJDWUFmRTJEYmk5SFJIa25yZWVMWlpwN1FKbnpFbkZtRFlFUXMz?=
 =?utf-8?B?eG5BUjE4UmhSYm1UZUdrdjJ1MGd6RXhvdGh6dE5CYXBwL1RaaWdlUGUxbVhT?=
 =?utf-8?B?VDJFSy9neHRPT3dwU2thT0JIK25tVDkxc3BrQ20rTy8rQTlXcnovaGxiVGha?=
 =?utf-8?B?SHhmU0dka3h4MVdVeHBVRHhVcTRpK0ZXMFJJTGs5Y0YrSVpoL2VpNGFERDI4?=
 =?utf-8?B?eUJyeWpnaUovOG1ncjc1UDdtK3dybTRUb2F2Z09YQnAwWklMUzdHZFNCU0FW?=
 =?utf-8?B?dmp1L3dod0FUM0RBbGRhdjRkbHFGOTFrZ2gwWDVFTFBqMUJCNXdxNVBydU5n?=
 =?utf-8?B?THhBcEQ4cGszZ0ZNWEZoQU1oWnlmZU1VUVFodU9wL3VyYXZZUFRpTklPZUZm?=
 =?utf-8?B?OTY4Zjg3TVErdTRmaXVSQ00wUHJnZ3Zyb29pU0dNd0dZdkY1cys3ZHptbVA3?=
 =?utf-8?B?c3BLWFViVDVmSFVkZU9vL0gzL2RsVE9kK1ZFT3p6Z0M5OEh6NGVIMUxJa3pp?=
 =?utf-8?B?RlNZbHc5b2RiVW5uN0djK3h5NnJYOS9CcUlCdVZrdVFHNyttY1RNeWg2UStr?=
 =?utf-8?B?NGVUclJXd2xDdlJUYjNDb0hnM2cvR2tFMGswbHFYNWlsNVJzL1F6MjAxOVlZ?=
 =?utf-8?B?ejQxVlpLVi9JUDZLUE12Q0pvVThJcmFrV0V4YkZrTWlNMEVQVGsyMkRJNnA0?=
 =?utf-8?B?Z3dERUVDZlE2K1BFeWtPUS9JOVYrc0ZDbmVocWwzemFRaHYvZ1AzWlFyZGRF?=
 =?utf-8?B?Y1Vaak5TNHJUMSthZXpVMWtJOTlLUUQvNG1NSGF3bWRVOEZRbTZqeGFBVjIx?=
 =?utf-8?B?RVp2ZDlEMUJEeXVlRCsyUklFbm9DWCtYZExnaWFkZG1FZThjS0lubTBKWEdI?=
 =?utf-8?B?Um9ISUFjYjdHTktUcFc4Wk5lSEloekhRbEE5Ky9nV2h1OS9ucUhFeDNRcEp4?=
 =?utf-8?B?SUJEQWpSWkpvT0R2U3FlYURwYUdUaERNeGJuM3V2TGpWLysxRk5VeUdlemdK?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e223b1-8fdc-467c-1c99-08ddc9420f37
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:06:11.9028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uk+gqdxq7qjTxH7XPqSvFhsvOBwe6GRhjQpTo6A0DpfYx4sjV6hASPTet/iyUdESej4dqsUf3GGovpGEIxJJqPDFIpTK+4eYLQSXOZSh/20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5160
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> devm_cxl_add_dport_by_dev() outside of cxl_test is done through PCI
> hierarchy. However with cxl_test, it needs to be done through the
> platform device hierarchy. Add the mock function for
> devm_cxl_add_dport_by_dev().
> 
> When cxl_core calls a cxl_core exported function and that function is
> mocked by cxl_test, the call chain causes a circular dependency issue. Dan
> provided a workaround to avoid this issue. Apply the method to changes from
> the late dport allocation changes in order to enable cxl-test.
> 
> In cxl_core they are defined with "__" added in front of the function. A
> macro is used to define the original function names for when non-test
> version of the kernel is built. A bit of macros and typedefs are used to
> allow mocking of those functions in cxl_test.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>

Co-developed-by always needs to come with Signed-off-by. Go ahead and
add that in lieu of my Reviewed-by.
