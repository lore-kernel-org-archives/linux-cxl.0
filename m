Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E75238D56
	for <linux-cxl@vger.kernel.org>; Mon, 21 Jul 2025 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129437; cv=fail; b=Pjc72IZm+FKO7ZRMYHK3FsaZn6vAUp5ewRucLThOp2NRJ4PPQALM5/yDLHhWbWIrERhOjrj2VtumsfRdX+HUTjqHVs9EnpNbxd/NIjUiK8ISxjO8YAuVY4KCrV8mhEtIZS8wjAiECA2YPCJx88w6jz1N/l4QPEFI9mAiuUjqVBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129437; c=relaxed/simple;
	bh=5CJuaXjWgpSn/8r3Uxx/gGm+t3KsG9nbvU/wr3oB6xo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=cHZLRlmBamCgXj+K+14FCwNw8qy1q8LfZJa99tPafgQchGBef9v1tWBkwLhDPl522iDv6zhNZvwRrshr65I2kEx22W7UJpZYR6HZ09VC66FN7fHPm1i8MQrkKS9yKsMhczSMNegDmZhcFGh95LvbMGtsZZWb7UVDzniDN0ypDo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDarKcxk; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDarKcxk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753129436; x=1784665436;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=5CJuaXjWgpSn/8r3Uxx/gGm+t3KsG9nbvU/wr3oB6xo=;
  b=cDarKcxkexG5cZ4fdidRmxFmQXSQillHvkJl4IaY3OZhwsG3YezpoUIJ
   wRlhrmT7i5XZ8akA1ZQO4jTt82Gn4lxmBjjy8guFAu/tkZtI5N0GStmsX
   ESVNfUBpibiFu2hkyEyKI7zBUno1n7Yduys8yH7KVBjR0Ah440R408iSW
   /LtGs2bshOzfVaKnjeWYmrY59lSV4csgF7Hn/aL7UYgvGN1w4xdJPEaGL
   B07Hf3eDy/pnUcO1TeAaMEq6D03KtnlvG4c+3Q8Xqr6+KTkCURu3egAIR
   mYN0btG9G3wnJ0QCofPZx4Daxy7gLui2t4AB0gakYRMLpzchBg1FDXo/l
   A==;
X-CSE-ConnectionGUID: ZjPpxEYjTcq+7wCkXDUtqg==
X-CSE-MsgGUID: au64CWYDTDSi3cicAzwO7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55207267"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="55207267"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 13:23:55 -0700
X-CSE-ConnectionGUID: QZSV8kFLSjKcr3ZIlTsn5A==
X-CSE-MsgGUID: 6iRvlh71TUK1PcuF5acnEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="159664982"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 13:23:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 13:23:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 13:23:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 13:23:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkRegxa6YVxiPEkh+NCJ1vh3+VmJaF8/CbSaySUcgvZO8R7bixttr9aVuwkVwL30CrTCwR1YaxdkaktNf9XpwjuliF47nJJEo7DP3s+jgXIIp+Qe8U0LU5mTmh8h6WpiG5rOEW7jaj096m8SxEdDxy/j8fWNpFEzapoZtclBF2uJsL6V7A388nESPaTsNmxuJp+1Yjt7azX4pxvgoUHpHxzEJ9vRDRujTENwREYoM/fAphnsWQ5Iyzs2TdB/6FVwDUiQxqoQ5a4BPZXxN0ZuZ37+mjLGxUiyBG2xmNEIpVp9HPivUOqQBSDeIakLxxsftQ82HlxcZ19E1e75adTf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rNhXwBce7PAfjFsyDyNIoGJEjQbRCqTBkQW6K0z280=;
 b=vJpAWGfYf5TKQGW4xwMVdFHBa6f8rW9T/jE/HagYUWN3JhK6eH6oUDFZVGgAk3xQKfWay55jV/fZz166RQfUcvi+b0ck2r2ODP9+EyyP3XG64YqTm8nLI9ZYpwxwhgQoCsv8vCSN9jOX5igvIJys/UWkPdXL1YuefXUbbTxWJntAJeqG1yxW0PrcAnw/xUfFwnistrNwAIIHt78N2slUmIyRfrupUKbKkAFm7ao1nhLsd579WQuylrs8HKixFtGyOS3tWTApywEUJVui12v+1yJRFSbYip/p3JVqGjNx1kw6wDZAPkXUoDfaPiBWWS6hmmus/Hxk+PKx9SmmU3IEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6554.namprd11.prod.outlook.com (2603:10b6:510:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 20:23:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 20:23:37 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 21 Jul 2025 13:23:35 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Li Ming <ming.li@zohomail.com>
Message-ID: <687ea1c7f38e_134cc710067@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250714223527.461147-3-dave.jiang@intel.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-3-dave.jiang@intel.com>
Subject: Re: [PATCH v7 02/10] cxl: Add helper to detect top of CXL device
 topology
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd899fa-4274-4835-4d70-08ddc894791d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHpNcFM5U0R0Slh1ajJnWW13RmVoNHVjQjJtMDFOQVVyaERaWldSbUhFdEdq?=
 =?utf-8?B?RE13bVovRnhYTVpiT3RKQ1ZyWlBobDNMeVJwakxVMjJucldaeGk3UnVEa2NN?=
 =?utf-8?B?V1ZuRnBPWHBkYmVMUit6YW5SVmtaU2tzUG9VVitYaU1xL1ExalhoZ0xxY25m?=
 =?utf-8?B?V0tDRjEzNDhPdmxyVzU2SStEQ3lZVGQrOU85Q250ank3U0dDREVuSUxnTTdG?=
 =?utf-8?B?OExMSVNSL09BaGF5bDYwSS84T3hGZ1VtUEMyRU1lZGhkUHF3dDBRT213U2Z4?=
 =?utf-8?B?Y29EeGV2cW9uOVYzOXJDeGcwajZ5QkJWdWhzakpUWHg2bG9yd1RjQ2dKOVdM?=
 =?utf-8?B?eUl0T3J2Tlpud1ZUbE9DK1QxdkxLTDczNWZDOFhsRlhhM0w4Vk0yVHdicUFX?=
 =?utf-8?B?cXhwMlBSMU1kalJlWDZJYVU4MmFIZDlWRlQxOHJaN0R2VGRzbktKaWRrTFN1?=
 =?utf-8?B?RjY0MGlpSVdyUzV6ZVE0TUFKbS9TUWVyQktMaHhPUzFxaU5ndEVPTk10UWtv?=
 =?utf-8?B?WjR0QUY4cmlZUWNxWTI0S2JpSFdPTjNJTDJ1dFlxZXM1Mm9jVTdyeE5MVzlF?=
 =?utf-8?B?VVUza3VZSGtJWjhNa2FRUHB4bGs3WWFZRzJIS2dzZk91czlHdmJmRzJLYWJR?=
 =?utf-8?B?UGgyNGVKVFBsOXpSa2xmTnNGT0s4c0dYekw4M0drbkYzYm9QdGJhYlg0ckVY?=
 =?utf-8?B?ZFJ5VmFMU0VmNS95eFlVdzRGTDNUMzdQRmllVEszTFUwejVxb2EwQk83VExS?=
 =?utf-8?B?TmR3ZmpyTUNCSUhCalRHUzFpdmh1T2FnODVkK0tSSFpXaTgxM1lMYVY4K1V5?=
 =?utf-8?B?UEF0cTZSTnJjMkk1VzRFbFhqalp6Sm9pc2dYWld4Rm8zUG1mMzdLeUs3eWpQ?=
 =?utf-8?B?TTVPeG0vSHBmeHJWTENSU2QvK2ZGS0V2VllZNXJjVkNTT0piN1BaZzBGVGFu?=
 =?utf-8?B?WlJYSGFXWUNGRDQvT3dScHU2b3R5bysrSHErVmQyY0dvdkgyeVcwMjRNV2Z1?=
 =?utf-8?B?cDZ2LzgvVmE5eGtzdWdiK29acDVJaVpTZ05hK01FSzZZWVk1TDJqcS9NY2dG?=
 =?utf-8?B?UWNqejA0R3hxanVTUnB4WmNCM3o0TU9rdTN3WUcvT1NIWWw0NWNDbUwzRjlJ?=
 =?utf-8?B?Sm54VkFHdjhaVFpyVGJHOEhEeTB2MGRORXB2Nm80RGEvN05ZK3dzY0xoRjg2?=
 =?utf-8?B?Zk5YMTlvOXJZRSs3Si85M1QvUGF5UFpnV0RKN0ZJUzZYaW9DbnF0NWM5QzNt?=
 =?utf-8?B?OFBPZm5IeGhJMkpEYnVMYVBEV1YzdS92TVdLaEU5WXZ3MmRENkp1V2ErNFB6?=
 =?utf-8?B?VlVqTGRQU1ZGdXg4T29DQlp6Rm5zMzNwUktpWm1iMUg1bXYwa3YwRWxkc0Zh?=
 =?utf-8?B?NjlRazN6SUMweHp3MDZFbUR4VytxaEp0QkhURUhwemhWSnRNcXRETEt3UmVH?=
 =?utf-8?B?cmlwTFlLQXdEWmdwb1V4V2FWNnNkVnZ6Nzl4R0JIRDkxQnpSRG1yeFFzMXA4?=
 =?utf-8?B?WGptMS9mUkdDUFdJeGdaamRwTWVMZzRRalprWERKQ3o3clhIVEJxd2V1SmRo?=
 =?utf-8?B?SE1rYjZ4R01YcERGNnJiU21IZGRDZlVhWXd6MDNiZnZwdmFJTWNSK1Q2MTFi?=
 =?utf-8?B?UW9nMk45eXFDRzQxTE42UFF0MlJFLy84WE1xOU9GVE51RUd5RnViRzVmN25V?=
 =?utf-8?B?aHRUNlVnTkJsWFFqUFViRzJBdHdPalV6Yi91bldHa1N3TXkyTFZBMUxtbjNV?=
 =?utf-8?B?VEFPVUxxcXBML0FvdXRwNEQrNFhra1hTRm9CVnIyZjZ1UEFRZ21sM3BHYzhW?=
 =?utf-8?B?MVMvZlhhaTBSaFQxbThRbHNweTJYWllBNlkzWU8wWUNkS3hxZXlna3d3TlZi?=
 =?utf-8?B?d0N6dGpyM1MxaFBGYldhQ3E2d0xVbncvYzQrYjZ4ZnF6SlFQRmFPaENlY1Vs?=
 =?utf-8?Q?F88NrbovijE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE16Z3hGUUpkcEN1QVVkdDlpTEcvWUpVd3hhZHJOR3pDeXd5VnJKblhlNXVV?=
 =?utf-8?B?TFNWdzdndE1xN3ZmeExqUXJLNHRtdHFqcER5TkZRd1BBL3VUakFuRnRHSytD?=
 =?utf-8?B?NVp4TDJCODRKMEdGQnViMTVtL3N4WWcvQVJtRTEvZ1RTS2FQVncycGRFcnh1?=
 =?utf-8?B?NXE3bnJsZnFlT3VHWEFoUEk2c2NXdmVYSDRhQlAyNENlZkVPY1lUWmRlVHo3?=
 =?utf-8?B?WllnWVFNRzI4ZjVCVlhaTXQxM052amgzcFhqVmprdWtPcFVscTRySmphR0NX?=
 =?utf-8?B?UUt1dG92ZnVBUWFObEMxdnNxQzZjVWFpSUxhdDU3bktVTXJuaFU3Zmhzb0p0?=
 =?utf-8?B?YjFhL2VCMXVhRkQwanlLT0VYQWY4TkMxa1J5a0JrbG5SMkFLMXcvZU5RaWlP?=
 =?utf-8?B?aGJaM3FFT3cwck43aUFqNnV6a0xZVVNqbzUva1FsTDRLWU5maEJmUFRBaERk?=
 =?utf-8?B?RjM2a1pLM3JNeFlreEtMK1hiNWtrWlI1UWxFVW5MblplcW1uRWZVazhxc0xt?=
 =?utf-8?B?bDlBZHZBVFN0d3I0VEFTVzZYTHdrMVUxUkc4cmdQc0xieG5tUmNKVEFxQXFj?=
 =?utf-8?B?RDRtM3FBMDdlUTdJd1BheWNxR3VFUmJQaW5CMms0MGZKQzhKekxVV3FxbWhl?=
 =?utf-8?B?cWRSN0VTRjczM2hBZDl0Q3czZ0xKRFFXaHFRT3A2bis5cncvdlZHemZsNkRn?=
 =?utf-8?B?eWFjWk5BNGVNT05tcURrcjBsbWpBNWdLQTlKYnlDVEl2ZzBIZjQ3Sk1yMEpo?=
 =?utf-8?B?QVR5TjBlcmY3ang5bDg5YUUwSlNwaURXNEZYaXA0MC9NS0UyUTdnbjNDR01h?=
 =?utf-8?B?NkcyM0pBdklJNWhQNEs5VlVpOHpsWTFBSkcwZ2hweHo5THpUUWxoMHY0bTdx?=
 =?utf-8?B?T01BZ2dzL3k3a3VuM0VpOVBBYzF1bGlvVllXYndPZ0s4ektWejBuUUVaVU1C?=
 =?utf-8?B?WUlVL2pXWEg1SkRCREdlSy93SndrMkZIamhlb3FRVmdnY1NvRWhTcXZYZERl?=
 =?utf-8?B?WTdXL0JiUktDZkV4eHdlVnRxYUZQNW9sS0k2S0o4Smttc0psSzFvb2NCTDla?=
 =?utf-8?B?dHFWK0hzN3VhVEh6bDVoTlZ0RDVKWk5tK0pWaVppbytYL29aRWJEVDNRbHFH?=
 =?utf-8?B?b1dNUkU1TkpOQWFid2k0R3duMytCZGsvZWFWYndJT1BpNjI2TnIxK0tzN3A2?=
 =?utf-8?B?eVFZUFNKNUtHdDMxVk5LYVZnRXRXYTFQelFuMWpTQU55amZ6NGw0RHJJdGY0?=
 =?utf-8?B?SWFDaWIwR0xwei8weHZiSVQrb2dXOTkxQW56NnU5TU1pWGdHNFZ6L1Rsa2xh?=
 =?utf-8?B?bFljMFowU0R3dHMrT01tc3F3VDZXL1FPSkVxOFBHMjRCMWpqd2Q3YUs0Q1Y5?=
 =?utf-8?B?aUEyMzhsc1hiUElwaytZMG5LZ2czTTJIMlUzZHRuRko4dmZ0YU9vVDBoSXNW?=
 =?utf-8?B?d3Nkb0hUa0dGaXc3MTIxN2FzN25kK2FsV09zeWNJbzdPb1pMeS9RZ2p1RnJr?=
 =?utf-8?B?cDMxRW5aWWQrYnhpSjNXclVIQkQ5eFZaNVE5ekJQT1dUeUxlaWtqZVd4RjBP?=
 =?utf-8?B?bVNpWlhoWExjc3ZrV3FOZGxERGdvOEpSSGZJelM5MjNSR1FDa0R0RzFJVVRp?=
 =?utf-8?B?dm1lRHFrWUFkd3Y5ZUpNQlhJazY5ME1nSW5wbUFmZFdPeGJvTXFSRXJhOGh6?=
 =?utf-8?B?OFd0UktxTXpzRVQzM2NsUytPc1U0NVNUSW95MEJhTGpaS05WK3pmOEliby8x?=
 =?utf-8?B?ejB6UEgzenZyZUhaZHBiZ0xuWlQwUGltNVJXME9OOEJ6NFR2a0hWZEhEN3U4?=
 =?utf-8?B?amhDQnZjdDE5TWlYUitoZ3ZodlQ2L01hSkVWOTZRWmNCZzVqTVNsQzEvUHZN?=
 =?utf-8?B?M0NTNXp5TzFyUTJxVHhKNXRTbTRmUXlPTWxLTWxyd0ZMdEhEWkRVa09OM0tH?=
 =?utf-8?B?YmlMN3NmWWNTL2JXMkNDMzQ5UWJFcXdLR3B4WGlwdVlYUHJ2NndGQzkyQ2xE?=
 =?utf-8?B?Rkt6VkNxa1dWTUorQjdNMVFIYzEzSzRyZXBmT2VrdzQ3ekVnNnp2ZlJQZHM2?=
 =?utf-8?B?V0ZQS0pBWURFNmg1YlcySTJEZU9VMmNTdDN2YmJGbnZvemtuWGI2T1o4bUlU?=
 =?utf-8?B?RnUvTU5uVEhVK3grYStNa3VPTkNSR05Ndlk3ekIybTdPMWpuVWF3NVhzWTk2?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd899fa-4274-4835-4d70-08ddc894791d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 20:23:37.1134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6D1IUlJ6fxqgYNZioUoCg18YAB9iBQmdGsS2ApBoszGxsrb6Igwq5GrVUzWXiTwMvjOPZhvG585saWc51c6DzzlLpZsTy5EjZveaWv4Bwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6554
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add a helper to replace the open code detection of CXL device hierarchy
> root. The helper will be used for delayed hostbridge port creation later
> on.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/port.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index eb46c6764d20..a49491c14d19 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -39,6 +39,15 @@ DECLARE_RWSEM(cxl_region_rwsem);
>  static DEFINE_IDA(cxl_port_ida);
>  static DEFINE_XARRAY(cxl_root_buses);
>  
> +/*
> + * The terminal device in PCI is NULL and @platform_bus
> + * for platform devices (for cxl_test)
> + */
> +static bool is_cxl_hierarchy_head(struct device *dev)
> +{
> +	return (!dev || dev == &platform_bus);
> +}
> +
>  int cxl_num_decoders_committed(struct cxl_port *port)
>  {
>  	lockdep_assert_held(&cxl_region_rwsem);
> @@ -1635,11 +1644,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  		struct device *uport_dev;
>  		struct cxl_dport *dport;
>  
> -		/*
> -		 * The terminal "grandparent" in PCI is NULL and @platform_bus
> -		 * for platform devices
> -		 */
> -		if (!dport_dev || dport_dev == &platform_bus)
> +		if (is_cxl_hierarchy_head(dport_dev))
>  			return 0;

I quibble with a new term "cxl_hierarchy_head" and the fact that this is
a PCI topology property not a "CXL" property per se. ...but not a large
enough quibble to ask for a change.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
