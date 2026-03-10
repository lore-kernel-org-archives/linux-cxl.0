Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED531C5F11;
	Tue, 10 Mar 2026 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171082; cv=fail; b=i0jFLstPJrzUkS0+QuumTmEVT71+bNtFV7lKj5tf9T2SbcZB+P+BjCNKfEn86ILsTa9QMsCAafz/Ca/i6bMm/vI3W9GxMIqu0iX7/n97sC4fQ/xYzYPJZQflpiALqgiv4c6lTxz12OuEPFi5qu768B+36gtFAtYCrzSYKSsFrTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171082; c=relaxed/simple;
	bh=2rzKC+5HMDetC1sqliIPPqyJJqH4A4TBgPSoSy5n+Oo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Zb1+Jf7SUDLHMVoL9+6jmK3+vGv1k3seOxshjeXY9qdm5Lo3wmyNv5O9PyDrYeuiwKhxN0D7jSbQtSPNnNjQWD8LTGTc7hiMAfQ8/eB1L/12742sy+LVRrdkoAdzdHXwGN9cHa+TQtm3HZ4vjW1cJQ2vQGDBAfMdRpNIODk+8uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBI0zcvX; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBI0zcvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773171080; x=1804707080;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=2rzKC+5HMDetC1sqliIPPqyJJqH4A4TBgPSoSy5n+Oo=;
  b=OBI0zcvXtms3qh4xlwYBT1W98sZ8PlBocWf3ccEBOGJXSB3qn3b64K4g
   9aqYwdg/mLTnvYohEWZJrQ8QDwhXsUxr50RMAJlSI4ZIUPG6UCDo91jaM
   DJRcZMiO+EXCdKTGsrWHPDeAKT3jAztApRXS6AtEUq9/gb6/JDGc9+sEU
   NvRtAvG26ccoY1IF9fsyDKmX2BKoXufDSab0ncu6E9vUZEY3rHZYPpmms
   N6TrWz42H6m6ol/q1RsKQVNuVCuTiEOIUYJYyX9Vuq76EbQTl67L0HoH9
   toAc3Tfc/FF9JQTrAmnur07ohdDFbE1YAd7HyuJwjulKs5/DMV7hHxFee
   Q==;
X-CSE-ConnectionGUID: ey4CUC00QHaKWWWIeSHO3Q==
X-CSE-MsgGUID: XUoaalLvT1SobdgnbLnirg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="77835069"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="77835069"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:31:20 -0700
X-CSE-ConnectionGUID: Weu0ALViRJSlDHA6sNhJlQ==
X-CSE-MsgGUID: XggzUXPoRIqe1wvmAiQZBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="225179096"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:31:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 12:31:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 12:31:19 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 12:31:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWFxnn0uGGm9i1UQF4C085ZRObNGqIqcXj7We4bJIwvQb8Yg3Uh3tSd9KmwodECynxDd0wzHveYmGGuMOHWmohBttFNhGIGwysQnu/Mso/lA37HI/VEItcCxiDIqnlik8gqDLlmUFLO3qwFY/Svt5hgRQME1y/DXA9gAKfDlh0hwFLWbvXvMyW0kiuwNh+eyJB+EN+FI5pK+JdbeicfLEABYZInZZEW9CS71B+/klQPGsg8EKgs0zXpIIty3C/BTjIxcR9mI+0+9dxdbb0NzvwZQdG4XAAVrpk6qle+JNnAFljf94D8MKUOB73KuIOqDNlwEBaZiArh9LM0uJ3gWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3fNziSAbJ73wD6PE3kOPn3UBszbt+usEzV4kY2v+U0=;
 b=SJoGz681WtT7tElssck7Sruk97rpI2HoFUezhI/ZPo9DGbX2VXyX84ltUe/SIz8yCqprhNCIWcsa7E1o7Y9mJdnNJHdCAxf3OnIv9YjolpbGSkHyhQt0eIoSTHWqa6ap2MBE0CxLRLm5UqOIxupjZhA2yn/Nf/oOXBVeqYcNlL/5+l90vDFaaB8QE0PoYNjNg5e7icLDgAVmW21T51l5r7wxs1botiZxJRH4Hkvwsk7CkY2ECeMcaeyAGFY8yoVOt2weIUuVfA2LIRrWc+x7Dbil6h3y/W5XawEZIeYMXGaNZn0Uchh+YU95C/aI5nDKuAEEtVAb3rnL/FNxsEzc1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB9614.namprd11.prod.outlook.com (2603:10b6:806:4c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 19:31:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 19:31:17 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Mar 2026 12:31:15 -0700
To: Li Ming <ming.li@zohomail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Danilo Krummrich" <dakr@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Ben
 Cheatham <benjamin.cheatham@amd.com>
CC: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Message-ID: <69b07183ee202_490a100c9@dwillia2-mobl4.notmuch>
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-6-94fe919a0b87@zohomail.com>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-6-94fe919a0b87@zohomail.com>
Subject: Re: [PATCH 6/7] cxl/pci: Check memdev driver binding status in
 cxl_reset_done()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::42) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb3ef56-5204-4681-a4b8-08de7edb9982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099003|18002099003|22082099003|7053199007|921020;
X-Microsoft-Antispam-Message-Info: d1DcRCIMKa8USVT740Z0CScAS4/vA6kVlszUuBs2E2nByVWiTU1uhjnW5SYg6GV1IpYu2alUIHtJDgtuHnSNs4dWG1w+gHFFV3svv2iSVN2t4LmAhET/7jMc8gryDxkclqEOAbHAUytTpjQGhl8LxHe5oi01OEP40qwTCOQ9CFzWoWAox/VCigVJ1EOPPWx+gC0wK6GcK8nSe18H7qxdzlWdPDZC7omWLW7Qyze8Wlw31y6RmvaZJ8+AWyzfK13icf+3igBtooqu7aGpFwwOSbVbmfK3PeyKYcpdLCvb3uDR8drhZc11jWTpLOiEb0uhhr5f1AxjyJ3VFzE2SliH9G8rCOa45Nl8jPrTMRcTC38XYtUpiAtbu15e8EejYDyycF8bu4uORUIgaiNsjevqtEuR9Z1m9dp6upvWI9pf/TEpi/GrAI3+1EbGHS+qY/AWjRZz6FH3uXUGEOGc2XTNhF/EwwCE/L+MPe4OB9ww8adAx4x4RPDBZPifozKFPeOC4ddQ3TRCBi8XMAshIsxGtJ9oDKKoQ5ZVi+BeI5u5HqQLwTfIK/ZDJlHeJJAAFDBarkcUvOoq33a5mVBu4FX7Oy9fyvbGn5QjrLClvcGEBlzFuJMGlwb5uihP4o0dw5C3B0PuAM47bn1PD2+6nqDyFJgR5eiPT67op9hnpOGAyKbHFOc/xZm6az7GjsHS59kmLrpV3u6ydU245mu2FHyYpqw/ft7oZc8gfbrcFjCTVdBu5lDIoy5SZhYX+Pbq1NY3v9oQng6mH3VQ8HrWHlcmDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099003)(18002099003)(22082099003)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlkreStoTllwMHBRUkhRUEdqU3pXSFlMbDVnekIwU0JUSDMyVHhsN0Q2b3dq?=
 =?utf-8?B?UUNORlNNcVFCekFCTm1mcnk3UXdqakc4WU5QVTZsbFlTSjArL0NsYXFWSkhN?=
 =?utf-8?B?YXlOSTNrNlhzYzBuUUNLOUwvVlpuTXVIcW9NZU02cUxYT3N5aWlWczJKTWhR?=
 =?utf-8?B?OTQyaXh3MmlTc29UYUZGV0F0Z0JpVWEyQlBXUmE0WDlrK0xDYk1yU081OE5q?=
 =?utf-8?B?UTBlNWhsM2ZnaEpUeGt4aWtsTVVwR1NYYXljWWNQQUtmSnVsd2hTUUpYa1k5?=
 =?utf-8?B?cTJiZE9rMTF1a0t5eXFVTTU5dWtXZ0xodmJKTFRaU0I2OGVocUIwS09kTzBn?=
 =?utf-8?B?aE9NUE01aHh0dVVsWTNIWE0xZHg5dndISkcwQ2JBTVhaMUwrTFZ4VDloOWg2?=
 =?utf-8?B?M3c2RkFTbForWk5CcFh6c1dJNjhRZlpqZ0lVTTMvendqUXA5dlZReG8zd0Vo?=
 =?utf-8?B?dXR4TGVSUElMWUxIc2lmQ1QvbVlXcUI4VTRHN2pJY04zTVlUS1BXeDJRSm01?=
 =?utf-8?B?RVJBMWZyVXJwYjhmcEtzQjV2N1hEeWhiY2JIcGZOaGdSaGV6VDZFRmNkNTVW?=
 =?utf-8?B?QitKc3hVMWFkVmErVUdMdUkxRHdoRlVSQXpNQndDNHI4dklUdEFIUjFKSXZz?=
 =?utf-8?B?ci9IZFo5N0J0WUoxbWlyZkt4KzJTUkY1MGhHRU1UMHB6eWgzOU5ZTUxjV044?=
 =?utf-8?B?MkI2ZFR5Mmc0anMyQmIyYjNnTktlQU03Y09rdkF4MEhLaUJYTitTSVFGR1VE?=
 =?utf-8?B?amhqUTJITmxMOHhCcjQzU2dwODRHQU5NeThhaXBnN2VSTVprNGpCVVBWNzB6?=
 =?utf-8?B?Zi82MnFmeDRDbmswVHlITlZhTlp6aStXVjIwS1BRcERJODB1Zit0M0VhYmV6?=
 =?utf-8?B?T3lRWUJyVVNWbUE1SnRvTjZmM29XSlcyOTRuSHJENm1Eb1ZLZzZ1ekNoclk2?=
 =?utf-8?B?N0EzdFR2OFZ1YmtyeHk3b1ZFc1dPNDR2YXhtZGl1V0Q3N2FVZkJ1M1F5cEto?=
 =?utf-8?B?WVBmeEpQektWSlEzSVBpWmFxVENjVHN4R3VaZGxKQ0JGWjBWT1RMZXZjVEsz?=
 =?utf-8?B?aVVOWkZSNGpOblhMNzA2dm43OG9EeXNzUVRobmxaZFJiUlVEOVhOb1YvRFdQ?=
 =?utf-8?B?aUZIaXF6ME9SdzBjeE1IRmJBY1RORG1WNUovQ1ZvejZSbEtQQUdJWE9EeDhC?=
 =?utf-8?B?QkNob0JicG4rN2pJdHB2dDE5TkxMLzc0aitqYUJhdDZjUkxWSFRnaU5LT3pG?=
 =?utf-8?B?LzkyZWkxTTlVNExFbXJibkRQc3ZHa1FkMzZYeDRjWUdZM2RRWjlTM1cyTFBS?=
 =?utf-8?B?V2w3UzVUNFdDbTZNT3czS3FQcG5CcTh6akI3d0llVUZQaDU3Q0k3QW01MzNM?=
 =?utf-8?B?a3UzZmRoL0g0STBidFExTHpDcVNxaDhTc0RMUko3WGttdUpIdmdKWlVBMDNm?=
 =?utf-8?B?ZElkYUtMcUVJM0ZncXVjQk5iVzUraUlhUFE3ekJRQ1RvZUZCQUlxeU1UdGpi?=
 =?utf-8?B?aUVLdjlacFIxdGs3RmpNYVVUVXEwM0UwSDdHSzdhWVdhWG9wK0U0UnYzY2ow?=
 =?utf-8?B?cWJhakJzVmpWa1JaSEZrbGtzVVJyelg0RURnTWpiV292QTZCWEhPM2cwTVll?=
 =?utf-8?B?QXV1YzRlZ25tY1R1UHJZaTFaUjMxeXkraURQM3MrSmt6TjUrV0dnTUJhZkZl?=
 =?utf-8?B?L3NNbDNhVS9Sdk5CNm9VSUF3R2dLUkg4UU1jM2hCZVZzMU5kemQ4ZFlZZCtI?=
 =?utf-8?B?TENLM3lNeVcyTlc3a0ZZcE5zRVFJd3JjcjdpQVlpSm9zOU9xOUlnUGhxQnYx?=
 =?utf-8?B?SnArcGsvSHFCaWFNb21kK0RYU0N1VE83WWdON0tmZTlaR0tzazY4RXlNTlBN?=
 =?utf-8?B?WkRNYVNEWndHM0JUNDlzalVVcFhoTk9pdEZXdnVFU2RqUlRUZm1JcFU5TTBI?=
 =?utf-8?B?WlFuT1ZBbUxqdFNTayszVnIxaWxWeXU0ZEN6K3cyaGtrOGp2U0Z6cmhqYjNa?=
 =?utf-8?B?TDRMeTRRV2dMR3dqcnpUNnZCV3lvMnd1cHB1TGdXQ3l1LzFwRWttVS90QlBQ?=
 =?utf-8?B?dEdJc2pHZGkrWDk3S0tubDd4T3QvYTltaUtwMmZvaUZaSmU5dDB4QXN6NjFQ?=
 =?utf-8?B?V3RZVHRZQURxZ0lRQzlyUEg5YmoxdkxVSkRMNjR0R05pL3NzcEtIbEhacFQ3?=
 =?utf-8?B?elg2bzdsWlAxR2piV1BIT1JGaXpxbnA1MXYzZVRnUFhyZS9MZVJZQk84WjR2?=
 =?utf-8?B?enp5RHRYdlFxaFlBeHpia0M1SUR4OHM2WWdPQW5TTFM1NXA3ZktDVUo4S0xt?=
 =?utf-8?B?V2dRYVdDV0NNcENvMGVTeFJqbnRLQi9IYXByL2ZlSnV0Rk00SHFsRGtHSU1H?=
 =?utf-8?Q?zcwnt7YmHR+hgKbg=3D?=
X-Exchange-RoutingPolicyChecked: Hw/fQEiaURP8m5hzJzRWh+GD+91eIcc+usZzan8VcU6VZDiU7ODkRlpK5g339ArMS3PlmOAFsycAbVHAB+Q4rN/Mh77rLfZfNqHNdq6nVOXTTl9xpvbjLKMTK9Mn5HJboKY0CA4Y3xLSRvELFtX1VOka/iQ++XLsl4yvZJjtMPod6RSuWNwaUOAPcQ1tVd6AHor/7ju/iBKGQbIrtkDLkStHYkAZmlExMNyeVPN1PbRMyq+PhY4ksQiiD/aJU2i4R7wACbBqvHgSRwXfnXt0t6/jgl7PyQqUqLKjBzY4T5IafXI65zB2hyWRXdezyPeuufDrb7GPID1cSIeWPUhwsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb3ef56-5204-4681-a4b8-08de7edb9982
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 19:31:17.2625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHmCtoGVwzu+qjRU6iawMLBA5ZoZolJSkoevuYfAnnw8sWG1d2CvS+flZDRYrh9FqNuTn9gPw0dCuiPeoEiGkadsaoiubyycYp/In7qgZP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9614
X-OriginatorOrg: intel.com

Li Ming wrote:
> cxl_reset_done() accesses the endpoint of the corresponding CXL memdev
> without endpoint validity checking. By default, cxlmd->endpoint is
> initialized to -ENXIO, if cxl_reset_done() is triggered after the
> corresponding CXL memdev probing failed, this results in access to an
> invalid endpoint.
> 
> CXL subsystem can always check CXL memdev driver binding status to
> confirm its endpoint validity. So adding the CXL memdev driver checking
> inside cxl_reset_done() to avoid accessing an invalid endpoint.
> 
> Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index fbb300a01830..a5922116db2a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1043,6 +1043,9 @@ static void cxl_reset_done(struct pci_dev *pdev)
>  	 * that no longer exists.
>  	 */
>  	guard(device)(&cxlmd->dev);
> +	if (!cxlmd->dev.driver)
> +		return;
> +

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
