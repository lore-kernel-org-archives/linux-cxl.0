Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C8C1ADC7E
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770328361; cv=fail; b=a4IcYRYwcB8fR0sD+4qcdYJm92IQk/L6HYl3djHlCRuAl5OT2lPVrOY94nhOHdqok6ntPDxZTRct97vyXwFcOe4FXUq3VE46JIwD0CVS7Mzmy0QYauFSeHIXXA2+psY/RCvubhfbYogawW+7O0PCz0kxhKmbo8mgv5HJTSDPl4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770328361; c=relaxed/simple;
	bh=O0xgKL9xpbPHZL7IiaERXoxIhno9fPTrb+qQmdn4fFM=;
	h=From:Date:To:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=eqpqKHl+3DeqqNClbCehlDaz8vUzfpYIu6ZT7/IbTrZIcj9b+ff3n5GuO2YznJMjfcRlWI3/GymnLUtVF/qz5qnQg/89ZqgLpDfL6aoM0ne9774jJF18YyzLMW6GXOAWQTDiTTvnZv0OVe/gIn6OfOkB22w1VPtqobEZoqV5BE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efs3Cl9S; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efs3Cl9S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770328360; x=1801864360;
  h=from:date:to:message-id:in-reply-to:references:subject:
   content-transfer-encoding:mime-version;
  bh=O0xgKL9xpbPHZL7IiaERXoxIhno9fPTrb+qQmdn4fFM=;
  b=efs3Cl9SoeBmNNKz68AM0BHWFCwds8KJKuxgKY72/r7jTKSpsgk3T9dX
   pW5GQZqLTjxCE8JEDs2RhGNr0NZJAKRzbxjXj4a1ADFMGOcScHoQMNYG8
   23QGuPyGjttTQbTTpmr1LDttu9VhoXGs6IFwfOTl0wFIg8bELwt3TiIC5
   IFJfx2JOv/8pUv6R5HerFyWk9V4dEJz2z1+O7S1vxD5UB5VXNKrCdmqNt
   cHDvZfC90AIy653MZkcnFDk7cjXHoZy8P3I5hGOnKAeWIBOTCYx9doVaE
   j1ZD3xftNGT8qf7nRDcspBvb/CqTnodm5fbqwr9vb+4f+gSZuDdBhXxDC
   A==;
X-CSE-ConnectionGUID: mn4qo+P0TY29yNCmaJCzVw==
X-CSE-MsgGUID: dpRsvFLsQEiCSu7So7Nzww==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71436047"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="71436047"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 13:52:40 -0800
X-CSE-ConnectionGUID: Rx+9g/ikTzGSyCjMsE4iNQ==
X-CSE-MsgGUID: 2xnGySl6TW+xoC7vaYXghw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="215658269"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 13:52:40 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 13:52:39 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 13:52:39 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 13:52:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ic33H02lgA1X1uMZCkgss+C84QkldR/jUlXETwPPiCXaNThtf342ULKJvpg7E62h7LD/0whElb4EUIyJDM0+IQvXjOj8mxv5D7aBICgnS/68GECzSxHq23Agz4juIkPvfwoikX/4y0ycgCW6VKHmrRw8/09+Ey6WKia6feTr+ywoPMwi2hlIGyGYy9B1hnKRtqPVkmSHe3ZCgQnS87fPooHdEZhcSW0DnvOgecTfusOmQweJDufhwjn79LCKY9oBGunqnuQZxa8nKGg5IUmvoCBq3wiIn6jAAYE1ye+uQcFYF+p9uhj2srQOAmw7hKGb2n0yYwRsKEApqSHXu0wD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmvU3Cpdw61u7PPHW9MgBNNDUplMGOb4XfJB9lc01DQ=;
 b=d35o9Od1ScIyfX6DkeqznYwa2mYsGyE4HYzu7gSVZfHnLGw7RK5A+Et5JroQXFXapspOdhOe2SzZRoaatm/QT6u1vzU1sP38jAX9aLZTv46LTzrbZPwKJcfec5em+/W+nVyxw9LOhBjyDCmGibWbxLPU+JUFmNJ1UuB9zXsdQnoBUznagQYrCR1Ec78m2igUlub3JQeHgrSc/r6NsmAmj5pWP5eyZ117p5Ts2XOMuPror5xYpyZTDL9Ol4ccTukO6BTT6XYFLfZUhUD4Jd7rTILqdFO3YYfTZSGsO0IcXovIPTOaf9Ri7MtmTQm1W66PIO0Mlikgy+XNWH6lyhhlsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6762.namprd11.prod.outlook.com (2603:10b6:303:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 21:52:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 21:52:33 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 5 Feb 2026 13:52:32 -0800
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Message-ID: <698511207f721_55fa10016@dwillia2-mobl4.notmuch>
In-Reply-To: <75eb28c0-e696-470f-8cee-c47bae6ee15d@amd.com>
References: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>
 <69810708cf7df_55fa10055@dwillia2-mobl4.notmuch>
 <75eb28c0-e696-470f-8cee-c47bae6ee15d@amd.com>
Subject: Re: RFC: CXL Isolation Support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0063.namprd08.prod.outlook.com
 (2603:10b6:a03:117::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f0ac39-7ca7-44d7-50dc-08de6500de5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVczYUFtYmpjbXhPemFFSURvcjNwOVlTbjlYTHFuRDZmWTAzbFg1UWs2Tm42?=
 =?utf-8?B?Y2ZyaUJSM1lOTUJCZkIwMytuVW9yWHo0VDU2aGJ6bmFXSFE5QUN3QUZ2YXZn?=
 =?utf-8?B?L1lnNm5JMmVRRXRLYVQ4MXgzUGNTNVQ4YW41eTkyek5ReTViSzNuTzhlaTZp?=
 =?utf-8?B?T0czZGdEOC9kYTF1TG9YcG01SmVOU3RoY3V0RVVhNFF1U1JrdG9id1A2WmFv?=
 =?utf-8?B?bGYzcmFXTm5KMGppWGpGWDdSbE5DNWk3TytFZVAzUTNQeWpZcFhxS2VUNHp3?=
 =?utf-8?B?a0J3cnVmN3ppQ0lvTVN6azhqcWlndXQ5dGNobkZpM25rOFRhR2tRWUdHbjYz?=
 =?utf-8?B?eTUzRDhkdXNneGhUaEJqblJ3SzBGTm1JV0VNb0VMNkNpbjhUOXRucHgzTHFo?=
 =?utf-8?B?VTFRYUI1UndBY0hZR254MlZoV2R3U0RNeU1iRGY3cW5LY1FxYnptTCtEejNs?=
 =?utf-8?B?NW9kb3VRZ2RDTmhZKzNMdnFpeTRQR0FRSmRtSG10YiszeEg2MnhINkhYKytN?=
 =?utf-8?B?Q1l3YzY1aGpUYXliL0FiM2lPYzQ1NFZVMkluWkhXNXVFWWphM015dXp3a2lG?=
 =?utf-8?B?bE52MWlCM2xYOUhnN0ZNb2dvSXRlZjZNb2owakFXMjgrYzB4RDFaNjk2Y2NM?=
 =?utf-8?B?c01uTjNuSTdQekNWLzhoQzlWcE0rcmRzRlVCVEwxSkg0L3JhcUc1dUYzMWVB?=
 =?utf-8?B?WnlKN3gwMzlXTEo3ZjBSSkx0cHI3b2xTNDVXTXhrQ2NaNmFubjNXTnVRNjVK?=
 =?utf-8?B?dEJkRGZ4OW9sM2JsdHJHMVNWOGRyTlkyTUg4S2JNRzBlSXZkZzNtSmx0a0NB?=
 =?utf-8?B?ZXJGOWRMZ2l2WmRPcU8wM0dZWTNxRnRybE4yTDBnZ3c0VlBRRjFOTUI0VnRB?=
 =?utf-8?B?em5rZm83bTVYdmozQWx0TkV6dExQSTY1ZnY1SUVpSTZJMk5lc2c5di9mbWZR?=
 =?utf-8?B?STQzak5GRkFCeUdiZlk4aElybUh1ZTF5d3hLYzJiQ1hPYXNNcW9Tdm1vL0Fy?=
 =?utf-8?B?K3JIQ0lWQUJZMTBweEJ3TURHcWlZdlowcWJ4bmpOZlNWQi9jcm5CUU9MVERI?=
 =?utf-8?B?YkRQVEJLR2lvOFNzUFZyL2R6OVNKcHRjdW80VFMySlFmUWFNNHE0VHRTT2NH?=
 =?utf-8?B?TldSOGdoRFV6UXQxekU1VHBBbS91R3BpV2taZWpGeXlHOUV4MUVlbGx0WVlP?=
 =?utf-8?B?YThqT1JiN1N0YnMvRXBudVVrQzU4c20rOFlCOGorMkJrTW5ucmpHc0xybndh?=
 =?utf-8?B?QjhVSExPT3hUQ2VLeXRRMEZCUUQ4MDFyaWMwemxydXFxaTdITTNXSzk2Wnpi?=
 =?utf-8?B?Zy9RT052OWZNMlp5MUZTUC9HMmFMU01lNGN6NlRBNFE5Y2VYeitJQ1BqTjlK?=
 =?utf-8?B?RUpXczh4R0VFNHZIRHQwOUZOVjVaZHdTaVROSFNXVFo3Y2VrR0orb09WNHRw?=
 =?utf-8?B?amhGcWZvYXFpS2VKalRhb1FpY3dWeVdxNVdqU3dDS1ZIY2Z1bUtjZDJnZjVj?=
 =?utf-8?B?VWFabWJzakEzaEh6eGpSS3NYeWJpWjRxR3RmU0JZbVlaQXd4QlB4TVJSR3U3?=
 =?utf-8?B?OVZUTi91QkhGRWgxWkpHNXBCdmk1Q2M1VHhlYXA1SDRBT05DeFVOM0lTZ3RI?=
 =?utf-8?B?N0NYc1NZc2N0NXZYSU1XSlNRaW9jeng5Y2ttSDJUcm11V3Nyay9Pb24yUEJV?=
 =?utf-8?B?elJqbDBNWlF1L29BTkkzS0FOK0JSc3RmVG1UNGtJdENKMlh2eVkzSmJsdG9J?=
 =?utf-8?B?TjZmeDk0eW9OVmk2dUEyMmlUTlg1WjI2cml0WkxxVjZyMXBJaklTcmY5NVFD?=
 =?utf-8?B?MzBtVVVFbHE1VTVmc0FSYmlZMGVubm55a3pUMkVmVnY2UWIwWWllUEtKWFBU?=
 =?utf-8?B?UEFsb1NMeXBNWlovRGJUcnpVOEl5d0xrMFdZcUtzYVhJc1RQNnM5RlhlL0RL?=
 =?utf-8?B?OVlvQXpSWWlpeHMwb1VmOHlSYjg0YnhGNUpkVU40U2pjU1VrbVR1b1JyVzZx?=
 =?utf-8?B?cnhqRy9yNXJ0Z1ZJc0l5N0p6OTNYbHhXdTMwVFVEZlVDWk5Nb0lzQlBtZE15?=
 =?utf-8?B?RGRESEtIRllFazA4WTNWd2pnSjgwYUwwL0pGVWw2Qko2eHhQUzJsempjem9W?=
 =?utf-8?Q?RQ+Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDRHRGt4d0JvNDVTNEJhOVo3WjN1bDU5UjgzSUJKVDBSNmpwQVlnK0tJY0lx?=
 =?utf-8?B?cmVqckVKZHI0amMzTGUrL2dNZjNaaHlZUUVGVkROTkRHQnllSjlydThmZ25o?=
 =?utf-8?B?VE9WQXZmUUJSaFNTaG1WY0pSd2ZtWnJ2aXhVRlpiWFE1UlhYNXJuTHNybjVX?=
 =?utf-8?B?Q2M3V1h6TzJrYWVFV1R5aytBL001ZmNBcHd3dVFlL29RRWYwMXppdlY1Q3VK?=
 =?utf-8?B?ZWQ1S1RjYndZcEtQMXZJOTgyTnFlZnY5OWN2MTJ3RmxxQnFCNnpYTFNrLzRn?=
 =?utf-8?B?S2xWZzROSi8xWng3NWJMWDF4ZURnTmVlRGZSWG1tRVdJTmdrYmpyN2E1Wjlq?=
 =?utf-8?B?TDJkRWFlU3VCL0dsRDJhZ0lYVFBCR2MweERJL3JFT1l0M1YzZkFPNVlrS0Zr?=
 =?utf-8?B?NzNXNWVqZ3lNZEYyckl4REFDbHp6QXEwdGtvbUJQbUpETHhNQnBKdlhQSzdy?=
 =?utf-8?B?Z004Y3BpNXFRb3JkNEk5by9aTmkxSHltT3RMNlJkcnUzWi95bEJldEd2VHlk?=
 =?utf-8?B?ZUo0OHZ2K0plN3I2WVRUMDExOXZqUnc4RDVCZjRiT0V2Sno1VDBUcWM5Y0pz?=
 =?utf-8?B?UU1EZFBRbjN1Vk85clUzb1o1WkpVaWFtOG5QOCtTQzV6MkJxTS95aGQ2c1dz?=
 =?utf-8?B?N01PQUpObkx4V2lMVDJiUEZXdW8zck44T1JKclBHVTN0VUc5eVhxWnc0aVBW?=
 =?utf-8?B?d2h5amkyVXN4eG53a1BRT0ZCYWhrWDlaYzFqWldnN3VFaEJ6UmtZa1Q3L2hj?=
 =?utf-8?B?dk0xbEpQQXNhMWFMR3BpOW8zSnNNTzNsY2VwZGhPeVZFLzF2NTJOT0V6U1NW?=
 =?utf-8?B?R3ZyZzVQbU9PN1pxbXFHdnV0KytmTmJkckE5Ynl3QXYvMjFMU3VROXhSUHVX?=
 =?utf-8?B?YnZxQWFMZGpkWGt1UVNZeC9kNFNjalJ5VmRLUmpKcm9kZXNOQVcvbkNnNWZq?=
 =?utf-8?B?V1d5SEJMTDVwTzN4WSt0ak9lSXRHTFJhQTllNmtjeHdjbk05YTl3R3dqbjBh?=
 =?utf-8?B?NGtHTWpFRlRuLzVjd3BrUkhPZWlpQXdCMC9PM0dWWWw5US9UWmtOdzhRYUlE?=
 =?utf-8?B?WFRjQjBGc09idU4xL0Z6enEzMjg0b0NYMno2eW9UUVpGa0taUXM0VzhkbnIx?=
 =?utf-8?B?STdwd0FqTEhXd0FSSGozMDZQbkpEcmdScFEydmxhby9aMitUVHMrWTF2Ulpr?=
 =?utf-8?B?SGgzbWZicjZKOGFlbGllTEx1d3Z2MEtlZk1Fa1RQZnZ6MDJKUjA5VTRqemVk?=
 =?utf-8?B?Q2o1V21KUDh5c0JrQnc2K3ZEanZDSEFlWktKSnBIUEdiMyt0VlRCbUJENjBV?=
 =?utf-8?B?bjlDeUtWY3FlUlJISmd2bE1qeHhhMm81M0s3Y3ptTjI3KzdOSnh0RnpCci81?=
 =?utf-8?B?bnJCWSs4TVBoc28rVmc3YWd1alJNamRaUVpnSTlQaWtFMUlYK0wrQVc1RitO?=
 =?utf-8?B?dW93MW42STFtOWlYVXkxcktJMDEzeGMxUnc4TkpqYXRWQUhKbzd5QUk4QXQw?=
 =?utf-8?B?bDJndWlhWnRUb1JtMCt6dEhrVnJ0SW4rRzZyNGViSG5PZEc3K3pDUGlrTXJs?=
 =?utf-8?B?WEF0ZFhmOFZtMVlaT1VYOVVjMVlkWlp0NWVzb3ZxTXZPcFUzOHkwZEJNdita?=
 =?utf-8?B?dFVaQk1IZG9oUnFPcFVGcTdmbnhVdE9Pc2FCN2JsQmo3aVVNNFM3Tk43RmlM?=
 =?utf-8?B?S0xMWlpzNmd1aG5DUDlOWSsvN1ozeXVMbW9zWTRNejNyU1JzOFplazVIQUxZ?=
 =?utf-8?B?NXZiTktDbFR4bWduQlN3NDYvSzFaWi92WERxRWRTTllqeXU5NEdJNXgwbU5s?=
 =?utf-8?B?VUttYmZjd293NlBLbTROMmxMNHhUZmNjUnQvZ1dBdmJ0Mk9XU0hSU2MrN0Vy?=
 =?utf-8?B?RDNyNzE1cVYzYTJKSGh5VmhJalVwU0tGcVVTTWk0K212ZDRzbUFvTFE0Y0hj?=
 =?utf-8?B?V1VDWEhscWxVL1krZ2lpVDIxZVJRWGMrUXBiR0oraUJDbDZSdzU5cXkrbzE0?=
 =?utf-8?B?RnJzaERsNVlSQ0E0REY2Sm1NYk10MXdrT25UQUkyUkNrbmZnYXFrY2d2bTVk?=
 =?utf-8?B?Q2xxalhuOUZpWlp6RjQ1ckJqLzBEaHl6L09tNjdldEE3c0xkN2hjYVBEWFBT?=
 =?utf-8?B?MFN4cnBkeE93YlNRMHdvdXRoWXkrdy95TC9Nd2IwVFR1QW9oZVpGb05GWUpE?=
 =?utf-8?B?b0VXc3BJSEEvZHErSENmc1ljaUhzTXFLSGFnTVllK09Wa09MdGNSZVd3b245?=
 =?utf-8?B?VXF6bFVlQmFQRHhYVVMyYmFRUVJjaFVzZ0Radk01NHJTQ0MrYndkZUVRZE5P?=
 =?utf-8?B?OFNMVGRKUk83Sks5eUtlbFhnblpHZE5GVGpLOXVCK2ZZVHFRR3VlMEZmc1Nm?=
 =?utf-8?Q?SFoD4KHx7jUZhv+Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f0ac39-7ca7-44d7-50dc-08de6500de5a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 21:52:33.8937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IieELLxH39eYLQ4zwfHor314lv9ceb2CQ51Bnac99POJHkbE+zegi2iOI+c3iIonYEPxI/WHKD6F+AfCDIbyHb4asWydWvBfpTASr+I2+6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6762
X-OriginatorOrg: intel.com

Cheatham, Benjamin wrote:
> On 2/2/2026 2:20 PM, dan.j.williams@intel.com wrote:
[..]
> > I am interested in the isolation for CXL accelerator discussion. I am
> > not interested in muddying through isolation for the general memory
> > expander use case without engagement from deployment use cases.
> 
> I can't remember any internal discussions about using isolation for only accelerators so
> I'll need to check and see if that's something we're interested in.
> 
> As for the memory expander case: would something like the N_PRIVATE
> node set Gregory sent out [1] be enough to change your mind on this?
> It doesn't provide the same guarantees as a type 2 set would, but it
> does limit the usage of CXL memory to be more like type 2 memory.

It is not clear to me that can provide the guarantees needed to make
isolation useful. It is still fundamentally a core-mm services
capability. That effort is not well served if it needs to handle the
constraint of: "consider that at any moment this entire node starts
throwing poison, the system needs to stay alive through that event".

> Regardless, I (really) won't bring it up again until we have someone who wants to deploy this thing.

I am always open to reconsidering positions in the face of new evidence.
The workable aspect of a direct-attached-accelerator first approach is
that the accelerator driver has direct ownership of the error model.
Compare that to the core-mm which only considers a page failure model,
not a node failure model. The direct-attached-accelerator constraint is
enough to get some core enabling in the pipeline. Expansions from that
baseline can be evaluated later.
