Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E4B19CC28
	for <linux-cxl@vger.kernel.org>; Mon, 21 Jul 2025 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129126; cv=fail; b=t9PfL1KnQ1z8JZqjI0fW3WgPNwEMwuIoRRytRA55yYhnPMagfY5bA4XV/+UNJnoWJkBYccQU3WWgYhdV4V+Pqt5CoeB03H/Al46EaK/KspZOHgQgOMtJqluExPLQBQIq5wVyOsfZpof5zslfelpgs0bXW2VkGTpn2Pj35KskP6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129126; c=relaxed/simple;
	bh=KfXrDVuL1DMwOZSYFNkcjxSzcLPTVVzqZLXUCBEmMHo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=riPQDFUZZV/HcRoTCLDXXLipoNSz1AqMOzo3Uw/GcgwrTsIDkjhvf1WwsiqBGkcgyC+K1XjCxCSXoVUE7HMIIAjaGDTVDhtgbNHNft1MkV711q/Z6Hefy/4FaX5H7wc4qgv2tr53iNQ7akgPmJ/Wc++86XURvKfl0nJ9Obg55/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+9V+4i/; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+9V+4i/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753129124; x=1784665124;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=KfXrDVuL1DMwOZSYFNkcjxSzcLPTVVzqZLXUCBEmMHo=;
  b=P+9V+4i/GvBnn3HIOBpRWq8BBSxNg7aR7+AYymP6xflrD3i2/bL9TWui
   z2xecUl9bLqZlRRSiltaYD9QHfpLSca7kSPMgH4EORvEXP+HJufxqYW91
   8lwBD1RVVKXn0Bt5uBJiQP6FCDVec4qOhWhPtSxifh+DKwVd+cppHMzbg
   1E9CmNtrqu1xrYcGbSJkz2MPItX0YL4IozGNQGyEsRrtMxyS0tW7b+UEh
   SQ/ZNmTW5w3qLvJN3JV0wgBV9mhUISKHjxe7qT4Lv5JX44cov6K0f9KXz
   8NRiDb06bKmhlN7wFPYCKillUpsT0K4ea3XVPO3ZUA8Ts3OCm3DIdWdZV
   A==;
X-CSE-ConnectionGUID: TR52vsyIT5uHSe4sJ0RUyA==
X-CSE-MsgGUID: VPEZVHUrStOwoh2f9y2uUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="65624979"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="65624979"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 13:18:44 -0700
X-CSE-ConnectionGUID: Z4yWfRP5S9mXejIFBnSYjA==
X-CSE-MsgGUID: dcKo4pBzSL+bTQ7ijfGjqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="182650681"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 13:18:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 13:18:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 13:18:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.75) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 13:18:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSHRRuHeLtF66GWEgf8XrFGCGNhnLK7BYAIvTjnW26LGOhjXnxj8uWdGNAEBO3REtfvk5oYTJxayvyfJ93MC1qClEb2uZCTRgZG1o0UB4NmL1cc1iLr+Z7uod/7/3wwLcR5/+/sd91Nnd9a5ZxhNOzAwbu1sOSXbpIaJQtvbuocp+5NqtBPFPmWHrpGN4d+4fwZD83paCCyMeGdNCEk8oLA38lk/JXIcfSLoP6zLLT/odBfnJOExMSImCyoAAZ+Hzd7mB3jonorZhrfHgYwOjoqvVmPn76W5vaCpfocjCpr06yH0nsEwMqxqmkvSPE64rD62WLpJ/psZoY5O90ayDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2u8avOLGMJ58yzJ5RzjXnbS9PQuXngIgBmc51JBS2a8=;
 b=zVjkLoLLkik9SLJhQx8GaIuqOEK4YaLoez09rEntviRtyC267prX8RXS1/DrY+1RZnm+WGCU1t4Q+PgL0qITLPdrY/PykijcBFUj9MUYaUa4jBLifIQ+HXPa3SeNbqr0qvSfthxbuIlkPhns1H07g7bi/iPUcUHho8dWMe2o2g+0iOEmUG3/iKts5gPzi+fbiPtKTmuNXjcQLsFV/SYG/3lmnaQ88mnw7e7hTGD5e1Qgo7d5yTNNEKR7RJsnfjh1Pn4xlzyRlgSbnOJXddN5Txd1oHLC5MtZmItRtcPPXoUvMoGzulQ4p1qYtj97rkC3kJi677Ykflub18H4/Drs7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4598.namprd11.prod.outlook.com (2603:10b6:208:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 20:18:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 20:18:13 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 21 Jul 2025 13:18:11 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Gregory Price
	<gourry@gourry.net>, Li Ming <ming.li@zohomail.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Message-ID: <687ea083ca60e_134cc7100fd@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250714223527.461147-2-dave.jiang@intel.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-2-dave.jiang@intel.com>
Subject: Re: [PATCH v7 01/10] cxl/region: Add decoder check to
 check_commit_order()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::37) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4598:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d40ab54-63bb-485b-c437-08ddc893b873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eU1Ba3dXMlZqenNHdW9DbTBRYk9yWmhRZkRyakVSL3RNSnJJZ1hhd010U3dS?=
 =?utf-8?B?NExXUDZZMi9MTXVDdUExSTRDV29OWnRWN3Q0N0xXMjVNUnl2b1NOVGVoUnVB?=
 =?utf-8?B?aFJqa1ZOWWNyMThPR0ZrVERWVUJ0Sko1cnB6enNJcGxISHRqZDdObkpwY1FK?=
 =?utf-8?B?cXFiS3pGc1pHbmEzVDFmVXVwaFA2Z2xvcHBOcnlyWTRkQjBTdU5jZzZIVWZs?=
 =?utf-8?B?QVNtWTRzVTJ2N0l2S0N5OFJwQnpFK2JVWTRtN0JyRWd5bXFnZklxNlFYQm5o?=
 =?utf-8?B?bU5sekt2NWxBWERPNENXd1d6T1FnQ1lzaG0zb1h3NHhpL1FNREFRd0NNM3hH?=
 =?utf-8?B?SnQ5am1CU2NvUkRZWlhiMlNWNk5kamJYY25BTjJVMnptOWVrVnpmWjdPNlVQ?=
 =?utf-8?B?akdUVWtaakpYbHE0QzBZUWphd1l0MmtsbzhTellOQzVlZVcveW9rUGg5STYr?=
 =?utf-8?B?Lzl4WlFjWkxCRWJFWHJsNkVYNHRscXl4YXQ0VVZsRERXZzFZYVovLzI2WkZT?=
 =?utf-8?B?WGlMTjErV29xMENWWER2MTkvT1ZvcmZKc1lycHlvODdNNWhGYktRNjlTY1cr?=
 =?utf-8?B?MnBZYjBUR2UzclFqZDNqb0FhOXF4dXlHNCtCVWRhR3N3Y285WmloTmVLSlNn?=
 =?utf-8?B?dTNveTZwbTRNY0FWTjlqUjJNZEVuWjdHYWNIbTF6SEVyc0FWSzZLUXk5VzJa?=
 =?utf-8?B?NEhTa29HVFVRMXVUQ2lZblNwMnFLalgvTzAzbk02NFFDSkRpRThxcDF6K0Zo?=
 =?utf-8?B?M3Z3MlJyZi9xTlQ1cnNtVkFyaUVrNkVxdXg0bHJLR2pIMExhdXVoejZXR2lE?=
 =?utf-8?B?Q3IzVmdzR3NiV3M1MXVnaXF6V3JSVnlRWWs5amt5WHRreEllaStsNHY4Uldz?=
 =?utf-8?B?eHJpNXNGNE1DMUtjemxtZmxqNVZrT3Y5TzE3OWNaaTRSUG5iRGlyOXhkbzFx?=
 =?utf-8?B?RlYva2hrM050anBzMTJtd2NPL0V5UUx5ZDF2OUhDamRzUWxiRkpCZ05ubmUw?=
 =?utf-8?B?a3Nmak1pbGRrLzlhUFpuM2tMT25kZy9FNzUvMXRPTXNjZ2hrbzFKTnE5MFly?=
 =?utf-8?B?UktXNnNXV2c5Qm9ZMWQzTENMZDVjVVlmVGkrcVlyWGVMemlpTk9KOEovSnVy?=
 =?utf-8?B?RFNmZTZFYTJXK2FlbTRrK3lKZTBwZGliZWw3eE1UdnhCLys1TFZxVTlSOVd5?=
 =?utf-8?B?bFNqMWU4aG4rZW9ZREM5OCttbUlUSHEzaHlFVTN5K0Q1YUFUZFcybHVsdC83?=
 =?utf-8?B?VFlpK1MyWjRnQ2RMSjRFY01RNElIbjVWbnlJUTJRQ0NzbzZOS0N5eXR3Ui9C?=
 =?utf-8?B?aXRWeDQySE1oMDdYdmtTeDloOTA2QlpOaGQ4dEZxdm1iWVlUbXNDTmlKdEZX?=
 =?utf-8?B?M3MzUDE1VDNsbk4ra1VLcnZNTHpxbjhMbG91aWNpcWFRb01IMExraFBESkd0?=
 =?utf-8?B?S05JUTNUMWE3aERrZmtDL2ZiRXNLOEJMdDltOXpKMnFHTFRhV25OcGJZKzVZ?=
 =?utf-8?B?ZlJ2SkZjZ0tLQUJlZC95aHdQeGpKWStuUm5YbUZ2SnlTSWQrd3o5V0dPb2ZC?=
 =?utf-8?B?YWIrUVA3bzhpMmwzVUs5b29BWVRISE42Z2JvNFBCb1o5dXcwVFBCdnByMktM?=
 =?utf-8?B?UVJTQmlKZ3V2WVRrSWpCR1BYSXI4cDQ5M0pGeTVJMG41d3NTZFhYT0JEdm9h?=
 =?utf-8?B?REVCcFd5a0FkRHFzd2dybmVERHBzZEpyZU9yOFhiWDdnRWswWkpKVXBnZ2dJ?=
 =?utf-8?B?UnQrTnVTT2dremJObnV5UUVEalRld2dMdmRXNXYvb2tmT3NnUDdLMFlZalkz?=
 =?utf-8?B?T2dGMzVyWTVRektORndLQ1duUEYzYUNUcGNLRTVkb2Q4ZW52clMwaXpBaVIw?=
 =?utf-8?B?SFJGSXJqYm14NWNYZ0owWElSSXN1Tzlvbm1lWDFIUDFuaHF4QUF6ZHhTbE4y?=
 =?utf-8?Q?BV5LJ5hEKTE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGpReVVGUHNtVmwwSUhONTlsdUROZGtwUS90U1g1elBSNXM2aU5KL0dIWGd0?=
 =?utf-8?B?eXNMN0xLUnh5cWlzaDdpWHJwRjdGam9SamZJR0RlRlE3b0l5ZjZmU3ZLVnJX?=
 =?utf-8?B?QmtIUmJ0cm9iWncybmN6TEM2VGVqYXlpNFJ6aEhIa2ZWZVJRK3hqT2Zrbmkx?=
 =?utf-8?B?YzloL0Z4enROMEpPb2U5YUxWbGdMeUNMVWhxdERaTXQ5cWkwOGdmU0tYY01a?=
 =?utf-8?B?UG9LaVhuV0xOTEJoT283OWROclJwNnI4MmtsREFLWk0vbGtvbTNGT2ZlVXFj?=
 =?utf-8?B?TUw5QXhoUFEraDIrTWNsdXU4SkdQdzQyRDBpT05BNlVYZDRSbWVaVU9OaUFM?=
 =?utf-8?B?TTFmYVY0dkVYNm13ZDVqbmw3LzduU1dKOG9NMHBLVFdJbC8ycndmdU00cXdi?=
 =?utf-8?B?NWpSSUZyaWJQejNEUWtiZDFhdHp5a1IwTlVqaFptazI2VUV0cnRoYUlHVGs4?=
 =?utf-8?B?Yy9vQXBTR1QzdXJuWXQyYU42VFVzVW5TeFB0MGlhQ09aVlo1WFllVkIvMHV5?=
 =?utf-8?B?WVhIYXkxd2dxdUxwQ0dVeWJPSHp1dVJMYXErRCtqS2RGcExVN3JLZzJKSFd3?=
 =?utf-8?B?bVJZOXlsUk9TT05uQkV3OVdsL2d4dTRsbmhJU0plbmRmRWhDbGoyalkycVdJ?=
 =?utf-8?B?bzBnNlhtZm12R1lkWFVCZk9NT001UGlHc0ZwSXd5QWNvd0RlZ3NsQldXc2I3?=
 =?utf-8?B?dGFyU3ZmbXdZSHh3bG91Z2pxY0w3RFpUaWNvNEtQdEJDalo5bFZBUXUrVTZO?=
 =?utf-8?B?SFlDSlFIRUZ3N3FUWFh0K3RnUFNXM09sUHhQd3lGZ1piVytJVVBPRTl5NVB4?=
 =?utf-8?B?Z1k0UjB1KzBJVGtiQ0N4VU13aktEUnpaMGFYbG0zS09PbkFIOExwb3h6UFl1?=
 =?utf-8?B?NDNhUVVsSC9ySjQzdVBNSkZDd2p5OWU4U0thS2NZc05IQjF3d3prL1VTaTMy?=
 =?utf-8?B?U3ozMnBUZ24vd3RGUDlXcmk1YkpncXduUjFpS1RQL3h3My9FSXJkNUgxd3pP?=
 =?utf-8?B?TlQ1NkVKUC9vVEVLL1A4MnQ2Qjk5bFp3bVg4ckNsNWp6aGl6L0tudjFtM1Vm?=
 =?utf-8?B?eC9wbzl4QnBtZ2pXQk9rdVBoOFlNd3lOMFZNb29vdEt3NlBOMWhWSHptczN1?=
 =?utf-8?B?WmJHd01mTDd3RGZTa2xBemhMd29DZmdqSEo4QkxaNjdvUjAxVVdXWjNDMitB?=
 =?utf-8?B?RUNFQzBYZkdSRUgyUjdsamNwazhEclVBRm5vRkllMXdySGVUODE2RjJTY2Zk?=
 =?utf-8?B?cVk5UlNINXlqYUcwN3ZNeUtMTmY5RkdsV1R2U1BNbEF5MjlGQlk0U2dvQlF4?=
 =?utf-8?B?K25jMExTa0d4VGRMTkxvUlA3T2srT2Y2K1Z2c0pvcTJWSndBVkliVTFPdVo2?=
 =?utf-8?B?bTNoTlpVaWdZc1pSb1VEOGRvWHhTUWNUZ1NKaWcxYnlXaVFjckhzUXlWOStV?=
 =?utf-8?B?YzF4RGY5YzdvdkJQSWxmZ2tvb0Z1SUZ6dmpCbk1xUU1DWGxtdzZSKzg5K0FD?=
 =?utf-8?B?dWZkZ2JGMVdMb0xLcVVENjVNdVVqVERBdkZzVEdZU0kxRVV3VEVzcUo0QWxZ?=
 =?utf-8?B?QWdPRm9ScWlmcnlMN0poR3V0RW5Pb0lFam5oWmNwM1NPYVNmL29YTEtWWFdR?=
 =?utf-8?B?UVFaaDZ0WmxadXhNY1pTTklDMi9zSXRsOFhna0R0ZDg2VnJ4ajB3bGhiT1k4?=
 =?utf-8?B?eWlaT0Y2SEIxOUQxRjlUd2I4M0tTR0R1d05PcTBsMmdaeDk3V200U0tmNlpI?=
 =?utf-8?B?anE5b1FFcm9MekZKeGVvdXIxWHpYOSsrbWJHeTNhNVVzVjhkR29mZ1Bna3Uv?=
 =?utf-8?B?ZDJHdHRXWTRpZlo1VmFod1ZQVnV5emQvUXJhTjJFalN6T1BGcnRBV3VMZTh3?=
 =?utf-8?B?aHVqQVJXRDFoV215cHAveGNFY3FIYW56VG5ySC9sRFRiZ3JrVzB6aWpaUnBP?=
 =?utf-8?B?QytwVUZNOHRQUEc0UDY2VHlWcnY2eEYwNzZWYnFzencyTVlybHFBdEFBbVd4?=
 =?utf-8?B?NzZzK2NnZVJvZ0ovdWVDVE1FT2NVcllMOVJOdThMeE9ncERpdWVZNUZnSENl?=
 =?utf-8?B?RWRyNzNKendpeDJUcVA1eTJEUXVHRTc0WDhWSUw4U2JmU3A1RHY3TGFKUjdV?=
 =?utf-8?B?UnI0OEtJQS9ZckdpRjNlUGlWYnc0My9GTFo4OFJtZXdJdVN2eW9HTDQxQXhw?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d40ab54-63bb-485b-c437-08ddc893b873
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 20:18:13.8241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyBwlxqVcDZaOx4WfvbrN9Z8efKLba1adFhgfUWrnaNBKtgzkRQdhTVdjMR4+BVDFyFumPMTJ+pE9lWVsWfTz4qRLv68lMpDHXCekn952MI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4598
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> check_commit_order() attempts to convert a device to a decoder without
> making sure the device is a decoder. So far this has been working due
> to pure luck

s/pure luck/cxl_port_attach_region() only handling switch port decoder
assignment/

>. Issue discovered while doing deferred dport probing when
> child ports are now in the midst of decoders due to ordering change

s/midst/mix/?

So I went looking to see if this change actually makes a difference in
the end, or if this was just the result of debugging an interim state of
the code that ended up passing non-switch decoders through this path.

The disinction matters for understanding code-flow and history here.
Like something is wrong if this expectation is violated in some future
refactoring and may even be worth putting a dev_WARN_ONCE() in this
path.

In fact I put a dev_WARN_ONCE in this path with all the patches applied
and it never triggers with a cxl test suite run, so I think it is safe
to do something like the below.

...but before going there, can you confirm the expectation that the
safety is not strictly needed?

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6e5e1460068d..63c3dc978797 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -787,7 +787,10 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 
 static int check_commit_order(struct device *dev, void *data)
 {
-	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	struct cxl_decoder *cxld = to_cxl_switch_decoder(dev);
+
+	if (!cxld)
+		return 0;
 
 	/*
 	 * if port->commit_end is not the only free decoder, then out of
