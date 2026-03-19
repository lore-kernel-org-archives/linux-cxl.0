Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727333F7A86;
	Thu, 19 Mar 2026 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773952813; cv=fail; b=MxGeri6BX6fRQLqFDJXD/cQZHXtaqkWZOpAZaLUxd55XIohRAksK71tkYUwpi5iZr76+/D2kBlOEJU6lpOOpzXlL4kE1cs1HCu1YoodpvoODbl9uWfQuPOnA1FyvaBRXdf3x8e1p6dmtHHwWiQBXKgtklVzvkzrxyA+NjUv1kvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773952813; c=relaxed/simple;
	bh=4BPhsEjbP9KILMVzggGL0X8UfEAbXnn9Yt2Dm+l5BfQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=NkMPy4umCoQuaZscMobtBZE+Vis/YKBwmbXfP/mEfmkSxYF506SgVwzBdKxtMxl8b+jD0Eo7YZrhubliKFhWF25neONaAC4eQk2n07wEr+85E4AbWbGxhnGlvMQ6De9eSVOBf/gqMDNgtgI+td9Owci97tNFwzxemRiPW27VIgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZYCks4h; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZYCks4h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773952812; x=1805488812;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=4BPhsEjbP9KILMVzggGL0X8UfEAbXnn9Yt2Dm+l5BfQ=;
  b=IZYCks4h5Tou6pikRwHEj0Jh4Pd7378SC5F1hjc3f16AZnjAxdSvCrSC
   1omvQXjAHY3a1gT7OCf1nPqawtn9mzefWkgEqDfbS1FOt0xi65mpkTGNu
   orpWdhHWSxrm3SaOuUrOY1vxthZ4k3vobRsLZfw8K7G98VnxV5Gktz07S
   2dapFIznMi0I8w9zb3hWFdrpgnIgE30CsQDUZD3wSkzFk2zKbP7f9BSAS
   KF3NvEOs8Wy9iiByF/yZfsJIaxIHlGyewXa67CCf7zGBNo6NryHyw29Ql
   x06mBgr7GaMDtqC9gMuajnhZqmEguycpaSmx1nZqOU6/XFG7+M4tnG6JJ
   A==;
X-CSE-ConnectionGUID: 2XSr3Yz9S3S6qWuNmIJ3jg==
X-CSE-MsgGUID: b5M2Tzh/QqqsCuk836Gnmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="78941970"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="78941970"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 13:40:11 -0700
X-CSE-ConnectionGUID: 5+Jc5ql9TpONNymJ7oBqmA==
X-CSE-MsgGUID: YZgETZ8zSfKBPq93gptmRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="223106323"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 13:40:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 13:40:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 13:40:10 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.52) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 13:40:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUqZpxuQrGHSsplIfPimOL1FF+mxHIM+A51/EcEGkoMU2dUa99VxNhKlPcQVmLssHsUaH+W4gNtcWHyhhzA0VHYH/YB+llSwMhENJNfAxt20togFY24TrvRPqDyChSq1hPPkaphkpFIAgUyk2W0j38UpZbxT1mTBXi+1hDmzC3cU5FkqpasD06JxBoa88ENv+K6sEVGjH1hvDH/cIg3TcAaonMDCuFTffnkCeEZgg6F/ZFPklLKnnUU6T5BjYkRtVcqfN7wpnfoWeCFiIduJfD8JInthy1dAprAzrR0t1BTn56V8MVB9Krv2GMr+oZVmFqfn1nwoEnDowXISJPRNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zGPAe8EoD4RcwTUZFbc3eRJdaFdaZl7yHNorb7aKvE=;
 b=lqFSH+L3WIXhfVnhGga7t54PJEabW4Q8W5EcRsCyuF/jns+AjdUjPFaQkj+X/8LDvk0ATsLtFywpgr1BZWncx6wVJxZIDH+ZKQxy/p+9mcFdlUw4WqxdSYTMSvMjlDkG/PhqJfYtARsV/jGERRimrStBoYLQ1IUDOdD2KXUTRL600/27n+TlBTNZib9F7d7aWry1oJs2NAjR03Ya8On8iAYUW5SW002IQvfNYSud88Et5OfKMAZAvyMclR8BHMpHCMdy/dzD5IvmDd5zY2gPAvVW1bmTnBvdNzhJR9niI7XlvYFIEmXSwO9eZ76RH8Indxr+QsyToF0RQCyhJQFGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH3PPF23335A1E7.namprd11.prod.outlook.com (2603:10b6:518:1::d0e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 20:40:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 20:40:07 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 19 Mar 2026 13:40:04 -0700
To: Cui Chao <cuichao1753@phytium.com.cn>, Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Wang Yinfeng
	<wangyinfeng@phytium.com.cn>
Message-ID: <69bc5f248b90f_7ee310023@dwillia2-mobl4.notmuch>
In-Reply-To: <20260319074535.1709250-1-cuichao1753@phytium.com.cn>
References: <20260319074535.1709250-1-cuichao1753@phytium.com.cn>
Subject: Re: [PATCH] cxl: Adjust the startup priority of cxl_pmem to be higher
 than that of cxl_acpi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:303:b7::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH3PPF23335A1E7:EE_
X-MS-Office365-Filtering-Correlation-Id: 93666331-2643-4e48-2fa1-08de85f7b506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: HJqYYY1yrfmH9f38PWahu+9Fylwbh5bb+ozGcZCi0L4N/U7//3wZO6VQLyzQWVom6NDWWyZ4BV4BFf9xfvob5lxmxUHsQnTBW120xHp9lajubO4VZigljsfYY4kkCpAwW3XFeOWbstHfpjQ3tq7muyNu6LMUmiEUAeeSmtAk+aqSRCOYVYW38Hh1DZVvDP1xZhGq7QofoPSR4fSLesb4tjFuTraPj3gj8swXGe3HOx0AdVB+3x+jIzu9ayAyTmT2jFvHY8hARFJBXpc/A9W09iTW0d1xdA2Pm3QrQECaVbpKCdqbo95Pp7tL/ypxgdV8H/9y5x5KsBMW7bxUEwKAdUrZ0J+o56Ips+REsctrnUAwBZ9fM6b2LJID3RaFofuIp02Bj8Sko/Hngm1glET17nqhH9fuTM6XSoDJzYas9BE67LSbPUcyP+h0OaHBkBk+tCRUsxiUcyDoJKnGVW/RNf9Izx6xqlyc4pbzYU5DLucjfotBucDng5xfTHpI2SaFdOOYGXKCH32ngRY+2PIOQBoq0qDOK0crCIZQy9YelzTrafhRbHYRVVEeoo3ly9mo+mpvR1HmVEb3pf2NIMl9HEq/BmO+RZuiekVyduch6EvCQ9d6PK7UNVnR52Q7vL6294VPZt9iSMVv1Yz7DeEBrRBnX8ALiDRKgYcJxuzkZLWH9LYw4X9WZPXVRxEPIa6Zot4LjhJUQGuscVpWlb74T5Ou462XVAQKJdfn1pTPO6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2JrbjJmR1Bleit4dE9rVkU0SWtGOXZpeEVzSG1Ua28wdXhiMXNjUUlmNEhj?=
 =?utf-8?B?NG5mNU94OXlBYUNEOTVNMi9sUXdSRGpZVHVYZVRBOXlhNUN2YnhGUStIMGd2?=
 =?utf-8?B?NzdyV0RVa3ZVV2plblF1b0c5OGRnNVdzUW5nMllQcXRVRklpU2IrNVZvYmZX?=
 =?utf-8?B?V3JSUGl5TWxuNkpER2xWQmRUemRHUWN5cGRUMTZTcG5kWmRYSjYxTWxQRG1a?=
 =?utf-8?B?RS9ZVDdlNVVuZUgrclhqeTIyT1k1MWJzRDdDY090MEVJYnhFRDBaK2w4RVlM?=
 =?utf-8?B?RzdITWE3Q2UxZFE0cmFheXFkT3pXSG5DSU5XZEZqdy9EbnFDYnFUdUdCdGhs?=
 =?utf-8?B?SElSV3poQS93MUlaVmdrS1FLVDQ3NXNTV0ZIL0U2VHVseGgyMEpmdlZFTXhz?=
 =?utf-8?B?ZWQ4UGFTM2hwTGN1N2k2TmhXa2hjRy9kNkhLTEJtQTFqSk1NaENIOStxclZX?=
 =?utf-8?B?dGUxSy9LVDVqejg0b1JCOE5KbGFRYkRTcTZOdkJjUVg1cW5ybjZHM0gwZlNO?=
 =?utf-8?B?OFRVRFFqRmdlNGFVREdSSHhXNWI3VmFLUE40R29ROXhEZTRRaXJRaXo0eXJM?=
 =?utf-8?B?em4zY3dqcTJUb3RyNkRabmhGVm02YnBRamtWTzQxY0RzM04xR0hTU3hBM0p0?=
 =?utf-8?B?QmVMNy9ld1BVRnNXZ3JiSDFtTm1DYUY5ZExERG1lUnVPUWlUQ2gxUEkxbGd0?=
 =?utf-8?B?end0SFhWUUY4YnJoZWRMQXZ4QjJvVmdWYnZxWUZWaHJHV0xDUFRxOVpWRDNr?=
 =?utf-8?B?ZTUvaVpwQU11alBYYVZuaVZSS3ZjOURmVHMyMm1GNEdTUXpFMFpPQ2c0VlZN?=
 =?utf-8?B?Uldvb3lxSmZ4ekRrMHYwVDZ5eDlWTS9BS3pjelNQQW5wU2NBNnluSlllWk91?=
 =?utf-8?B?dExHQzVaTTF4SUo1MEJQNGYwNlJjNFpvclJBZllaOVpXa29CVVk3eFBra29U?=
 =?utf-8?B?U3RQWWZvRHEyZHl5UFF5UGFmWk84L1FyT1NQNlhYTE1mK1RHa3dxeTBHMVRz?=
 =?utf-8?B?SDZ1YU5NS3RRSFd2OGR0SU5HeVBjUXJzZjF4ckJpTEdYK2VtSFB2M09ZTC9z?=
 =?utf-8?B?UjhRTnNJTGhla253WU5Uc2VNZHorc2dyU25kL1Q3eG9UR2xieDF5WG44SWg2?=
 =?utf-8?B?YWtIRkZpd2xBNXphUnQzbEZabFB1ZHVsV3JiUDhJU2RaN0k2K3JMaEhpbEJj?=
 =?utf-8?B?OGt1MitydlZwUjBwS2FhZmJCMWw5N1ZzMzB3ZEdYdVBJY0RDVFA0TFJXUHJC?=
 =?utf-8?B?VHluNTVmZFo0OTk5Q3BGRE9CdVVtYVVuSkFCczRxelcvRThIck5MUE5JaTlT?=
 =?utf-8?B?Qnc0dTkyaVRpZ2NINXVhdEQ1cVIxUUF3OENqcGdia2FhVllXNmxiZytkZjdI?=
 =?utf-8?B?OWEvdGFSbGJnazBBQ0RxQThHeEl6VWl5Znh3NjQvTGhVQ0k5K1ppN29XbGI1?=
 =?utf-8?B?TWt6OGhyeWtreml3NlBBOGpuTUdSRkFhR1FTYWxFanNWT1A4QXBHTGNUNldk?=
 =?utf-8?B?TU54akpRcWpsbkVyUFJXSUoySmZ1blM3aHg4ejlsY2I4N000dFNjOGFsRnhC?=
 =?utf-8?B?OHhoZWFleVN5eDNDWjhISWFLeGJlaXE4bnhzNVkzZnFzVmtWQWNRdDlSOHAy?=
 =?utf-8?B?N29WYmZoenkyMGN3Tkthc25wZWdBaU93bTdZMHhNTEFFRjJBMys4WlQ2aFEx?=
 =?utf-8?B?QzhCaWNKNDVpY2laT25HYkpLWmtzSmVldm95cDkyYVpCU3pSR1l2YnBnWnZS?=
 =?utf-8?B?em9GTndZMk9neWI5OENwNDNjMHpMZ0Q4K0NDenRCbm9CYytsNkhONjVqZVpP?=
 =?utf-8?B?K3RKajZOMGwrb0k5VUdZVkpIR1p0M1hERnp0RFNoU3lDN2wrM0JlNWR0Uk1l?=
 =?utf-8?B?S0lSUXgrclBhQ2MrZmsrWm8yMW5oalJzQTBsR3JCM1JKZ21lZ3NKRUpobTZx?=
 =?utf-8?B?VFlvUi8xQ3lKTnRWVE1halJJSkE5Ukp2RFQzOGxSVHN1Smt6cENuYVVpb2JD?=
 =?utf-8?B?a3JqbXQyNDZzMCt1YUVzOENkSWhtaTc1MjRVVWpvZDdGT2tSNnllNDNQdVh1?=
 =?utf-8?B?alc2SEtURXFVMDBCZkNMVXJneXVZcVowYUpRTURrVzAzM3IwN0ZSS1V1MDJE?=
 =?utf-8?B?Q1B6Z1hzZENVUVlTUkRwWWF2RlBLWGI2R0R6cUFBMW9TSFRBU2VCSTlrWXV5?=
 =?utf-8?B?TkNhNnd0RmJtM3lvbU9qZTI3TW0wTzZrOHR1NjJCNmlSWmpjcnAycEZFYWZD?=
 =?utf-8?B?ZTQ1UHk3Z1JrTGRYenFqL1F1Qy94NytUai9FOHUvRmlWRk9DNW1YMWtEWEEx?=
 =?utf-8?B?bHhEQ2NuV2hQaTd1alhoOVpaT09IS1ZadlhTeGhlNUdSZjh0K1k1eFRJVUVM?=
 =?utf-8?Q?GkV9o20exAbBvL/0=3D?=
X-Exchange-RoutingPolicyChecked: PoB9/H/mWGnOX19ZPfJgf5vaxmXweSth0oPuHeYgb4tZG46NIa6bSA8acMvOHkBQU7lUM+2eylVfV9VPWlp8XiOpU81dJAx+Xfk5Jh3UIDO9O67Kz0Mgj3d/h/U+U/TTWhT1PoMYuaseEYz349YSflPPRqOq9kyyGLjJW0L64V6jrjgEq0WbYk5cE2DP/cwAq59jrxxOx6jDVBHlOUKAqmTK+h4MNM0l2XKslFKAsCi0qezklX5VjcIrD5upDwaQEnCIZ92a9llgNyvJ8NcdRbmOdgQWk73QtH11n/OgUap3xYzuCN2gcRvM5HYDTeGb8Yx+eSxGRusk8/LggHkwag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93666331-2643-4e48-2fa1-08de85f7b506
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 20:40:07.5973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PASZ/4n3eN9EH6ozM4qiYsjTVBxQpM2F1J4RWOR8v2w2T2LCj8LZCDzBDWzowcYzz8xqpFd3Yab6hBFF2Jjybn5evVgXQGPy9XADEayoDlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF23335A1E7
X-OriginatorOrg: intel.com

Cui Chao wrote:

Hi Cui, this looks good, a few notes below.

> During the cxl_acpi probe process, it checks whether the cxl_nvb device
> and driver have been attached. Currently, the startup priority of the
> cxl_pmem driver is lower than that of the cxl_acpi driver. At this point,
> the cxl_nvb driver has not yet been registered on the cxl_bus, causing
> the attachment check to fail. This results in a failure to add the root
> nvdimm bridge, leading to a cxl_acpi probe failure and ultimately
> affecting the subsequent loading of cxl drivers. As a consequence, only
> one mem device object exists on the cxl_bus, while the cxl_port device
> objects and decoder device objects are missing.
> 
> The solution is to raise the startup priority of cxl_pmem to be higher
> than that of cxl_acpi, ensuring that the cxl_pmem driver is registered
> before the aforementioned attachment check occurs.

Missing:

Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko")

> Co-developed-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
> Signed-off-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
> Signed-off-by: Cui Chao <cuichao1753@phytium.com.cn>
> ---
>  drivers/cxl/pmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 082ec0f1c3a0..261dff7ced9f 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -554,7 +554,7 @@ static __exit void cxl_pmem_exit(void)
>  
>  MODULE_DESCRIPTION("CXL PMEM: Persistent Memory Support");
>  MODULE_LICENSE("GPL v2");
> -module_init(cxl_pmem_init);
> +subsys_initcall(cxl_pmem_init);

Yes, this is a problem, but longer term I do not think we want to get
into this game of different initcall levels for different modules, and
dispersing the documentation for all these concerns.

So I want to match the initcall level of cxl_acpi and move the init
order management to the Makefile to disambiguate which initialization
happens first for the same level. There is already some documentation in
the Makefile about this case.

This matches what happens with all the other CXL modules that share
"module_init()", but fallback to Makefile order when built-in.

Specifically what I am proposing is a patch like below. However, my
change change is not suitable for v7.0-rc which can take your one-line
fix. So, for that you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...and then I will follow up to move it to the new proposed scheme:

-- 8< --
Subject: cxl: Introduce cxl_subsys_initcall

From: Dan Williams <dan.j.williams@intel.com>

Create a single definition of the early initcall expectation
of the CXL subsystem. Use that single definition to collect all the
documentation about how to order dependencies both within the subsystem
(drivers/cxl/Makefile order) and outside the subsystem (producer / consumer
dependencies).

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/Makefile    |    4 +++-
 drivers/cxl/acpi.c      |    7 +------
 drivers/cxl/core/port.c |    2 +-
 drivers/cxl/cxl.h       |   10 ++++++++++
 drivers/cxl/pmem.c      |    2 +-
 drivers/cxl/port.c      |    6 +-----
 6 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 2caa90fa4bf2..d449bffde205 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -7,6 +7,8 @@
 # - 'mem' and 'pmem' before endpoint drivers so that memdevs are
 #   immediately enabled
 # - 'pci' last, also mirrors the hardware enumeration hierarchy
+# - 'pmem' before 'acpi' because acpi wants to create cxl_nvdimm_bridge
+#   devices
 obj-y += core/
 obj-$(CONFIG_CXL_PORT) += cxl_port.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
@@ -15,7 +17,7 @@ obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 
 cxl_port-y := port.o
-cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
+cxl_acpi-y := acpi.o
 cxl_mem-y := mem.o
 cxl_pci-y := pci.o
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 127537628817..6d158c7b6ca7 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -995,12 +995,7 @@ static void __exit cxl_acpi_exit(void)
 	cxl_bus_drain();
 }
 
-/*
- * Load before dax_hmem sees 'Soft Reserved' CXL ranges. Use
- * subsys_initcall_sync() since there is an order dependency with
- * subsys_initcall(efisubsys_init), which must run first.
- */
-subsys_initcall_sync(cxl_acpi_init);
+cxl_subsys_initcall(cxl_acpi_init);
 
 /*
  * Arrange for host-bridge ports to be active synchronous with
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0c5957d1d329..aca31cdbc5a3 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2549,7 +2549,7 @@ static void cxl_core_exit(void)
 	debugfs_remove_recursive(cxl_debugfs);
 }
 
-subsys_initcall(cxl_core_init);
+cxl_subsys_initcall(cxl_core_init);
 module_exit(cxl_core_exit);
 MODULE_DESCRIPTION("CXL: Core Compute Express Link support");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9b947286eb9b..53086757cc56 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -909,6 +909,16 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define module_cxl_driver(__cxl_driver) \
 	module_driver(__cxl_driver, cxl_driver_register, cxl_driver_unregister)
 
+/*
+ * When built-in, some CXL modules need to load before others, see
+ * drivers/cxl/Makefile for that order.
+ *
+ * CXL has init dependencies with other subsystems. It consumes EFI runtime
+ * services (subsys_initcall), it produces IORES_DESC_CXL for dax_hmem to
+ * consume (device_initcall)
+ */
+#define cxl_subsys_initcall subsys_initcall_sync
+
 #define CXL_DEVICE_NVDIMM_BRIDGE	1
 #define CXL_DEVICE_NVDIMM		2
 #define CXL_DEVICE_PORT			3
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 082ec0f1c3a0..d5c5ffc72e17 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -554,7 +554,7 @@ static __exit void cxl_pmem_exit(void)
 
 MODULE_DESCRIPTION("CXL PMEM: Persistent Memory Support");
 MODULE_LICENSE("GPL v2");
-module_init(cxl_pmem_init);
+cxl_subsys_initcall(cxl_pmem_init);
 module_exit(cxl_pmem_exit);
 MODULE_IMPORT_NS("CXL");
 MODULE_ALIAS_CXL(CXL_DEVICE_NVDIMM_BRIDGE);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index ada51948d52f..4c1385953801 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -326,11 +326,7 @@ static int __init cxl_port_init(void)
 {
 	return cxl_driver_register(&cxl_port_driver);
 }
-/*
- * Be ready to immediately enable ports emitted by the platform CXL root
- * (e.g. cxl_acpi) when CONFIG_CXL_PORT=y.
- */
-subsys_initcall(cxl_port_init);
+cxl_subsys_initcall(cxl_port_init);
 
 static void __exit cxl_port_exit(void)
 {
