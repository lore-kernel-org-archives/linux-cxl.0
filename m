Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A52BEC53;
	Thu, 10 Jul 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752186387; cv=fail; b=W/x4bS2B1hbGY1zyqxX9zkW6oXyRfc83/Ok6RnzIcPr/ZdaYCLxAZ0ygp9eX8VSa0/C+rt7U2XwEh1j3ya+Q5psu/5ZLutWtwy2lhKbD/UtcO7h2TkqQ1/uhLV0A9zTzwdcqiAWi6kOje/n6ayzIdSVVDeMp2Hmv64zYtNOE7Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752186387; c=relaxed/simple;
	bh=lT2wnXbsMYsVpB1sljFIuxakCZTYhz+CfFT/iy/jbrY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=MSmwNUgaYWI11O/7uBjINdcj3M5Px+P7bSGrN/7WSZBxrvZ+1R2JrnLwiasFg1iEicfv8ndrp14PtuB40RG6opF+aGYP+8ncx5I3YDhqbfucRBvcfUiiQtj9/x4PltA8X5I9jVcgOg4422E77rrgZIySMVWNwIQJmv/Lpzv2v+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2CxJsTu; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2CxJsTu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752186386; x=1783722386;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=lT2wnXbsMYsVpB1sljFIuxakCZTYhz+CfFT/iy/jbrY=;
  b=O2CxJsTuOP45gL1XHw7eZBFkbmLaTFnOGjaj7XjREdv2/zaRNiTU8qmT
   tuUSWSSjPtNkktVM4zD1J3Tw5L6m0K+h/O34fEY/e2+La9t6hV/rwnwRw
   uwZNHNl0x5P5ic5V0VKo12PLIiJnZ0byF4fRX8Ug/NRO0qrGeuxqlBKnN
   gipL7JykP/6yNj0c02PQ2tI2AGqxyB8jJa05Y3aKTlvD8yUYcJeOnxYg8
   Wnta3LynYA9aSpMIHtPl30DYTe9rdpTDk/gIg9SJHdtcbACYm3AKMhnmU
   BLVUbzLpzMiuYq02xCXCh2OjOZ8tL7XS53RJpaKrrvOLGG6CI5DclKDqG
   w==;
X-CSE-ConnectionGUID: sKf1L2cwQd6kkrtAm+3jUg==
X-CSE-MsgGUID: 1KwNODOtRfiQsFKNyXxZ8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65830272"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="65830272"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 15:26:16 -0700
X-CSE-ConnectionGUID: X8bj0FgzQcaG+nVCCwRHtg==
X-CSE-MsgGUID: LO2lL4HfS9SAG1ZLlqFljw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="187215927"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 15:26:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 15:26:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 15:26:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.73)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 15:26:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEa7zVPFOhZ3Jy5DI88B3+9vLs+qq/NrL6Iz62x3uad4/HCSFIS6vpbVXHn/EPRd6cgoAos5ZfqWS/iPRwYq3R6UCA82y3f79aOx0dWEY8VhT43JYnM+TbJkXqV9z0PU7GEPUV8j4r3D0gku3SR3MIljSDw4wbIfRWOcGoZTk++bbElEt6/bCQw59qPJrF9tAZC3pQowCZHRObau5GWm3nKr4ZH1N9Ykgx0sAVnlOWVubNdhj8IVbVpA52Hv8R3o7yePNARiByKypB3bNZIhjIGBUheCFSdmhjtsdgGn4o6qF3QT5M71TB/nONVnRTX38524wbj0fnGjB6e6un9udg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTu3a7izpnBbMcN4HAwPuVEpoimsNUByfVMYxHqHrVg=;
 b=wDceKJitB15E+2t9hPEJTZph9ghpZs1KpVAg3K/CbmyyeHJC/HnhpM0CUFfogUqIVocj5sqLnrUspkiZom85pI/F8CxHfpao6DXu5cFWxWfsfUFSn+FJ8juOyfbIjeveKiTjt5EbENbB/+KdvF54lpY6o4URbgu6s7Trzql2xmEvHjwudu0GhtzGpkVkm82kAA+0YopLwXbUBA0OikXkwggl5qODfUDvHXIJIXuGw+CynZTOMu81QXoTDtGCmANW9P3k2/+yuaFJ2iY9yuMO4rHVlZVfwOuRkzj8EMF/R4e1SDbMOgItJiCjQ/3N2E57D4V023Oyeit7tPxbb9WO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6563.namprd11.prod.outlook.com (2603:10b6:510:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 22:25:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 22:25:52 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 10 Jul 2025 15:25:50 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Peter Zijlstra
	<peterz@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Message-ID: <68703dee2684a_588c100ae@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250623110808.00003fcb@huawei.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <20250619050416.782871-3-dan.j.williams@intel.com>
 <20250623110808.00003fcb@huawei.com>
Subject: Re: [PATCH v2 2/8] cxl/mbox: Convert poison list mutex to ACQUIRE()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:a03:54::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: a751f024-f4d6-4063-b31e-08ddc000bac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDVrSUJLbjJNRDByU0d2dkZXbk9GbW5mWldMdlpDcUlQbEhnQklBUDAxZ1d1?=
 =?utf-8?B?TUpDQnFRVk1rMkR4TWx5TGVocThZaXd2UHIvMkF5L1dIMTd0SzJRa1JtNDVp?=
 =?utf-8?B?K1hYK1VIdDZJRVdjZEVPZmQwc2tweE82cmt6NmorelVDclBLT2tLNDhpYUFy?=
 =?utf-8?B?M3NuR1hZaVJZOHFmL0Vzc3E2RjVtOWROUGV2SFA4YXFBVEo3T29NZEhsdTR4?=
 =?utf-8?B?MDN6RXFNWktTMU1QbXlqdXd0SnpQM0c0OHpRcXNtbUVDUjRsV0Jnb2dlSWor?=
 =?utf-8?B?VUZLdjRKaFRaQy9BODArc1M1bERybE15Q1FuVUp3UHhWbnA4ak5NVTZ4Yllo?=
 =?utf-8?B?Vm4xc3p5TFVDclZDbEp6UW1iS2UwWG04WDBUVkFQNU5qN3I1NjZ0YTBqTjdr?=
 =?utf-8?B?ZVoxVFk4MlVvR0lpU1A4VkpERU85V0tabFhrQ2R1STZiSUx2N2RSbUsxanJ1?=
 =?utf-8?B?b0dHajI4cThaTWV4VFc1TzFUUXpsWFVDdUtiV3VnTUhNWGE4bU05Y044VmVD?=
 =?utf-8?B?SmtUb0FOK0xLbHluQ1I3QUprL0wzNHNkd0ZjSm1Gb1l0eHl3SEVGTng1emhF?=
 =?utf-8?B?MXIyLzl6MnZua0ROVlAwMUZHYzBWTFdkTGlUb3AxVlpJVHRZYUhscEsyUi8r?=
 =?utf-8?B?MDVCTmJ6U1dhcU9ac1RRVmRZNjhTN2RRMWkrL0dxT3d3amNqaGVQRmYvU3ll?=
 =?utf-8?B?SW9CVk1RenpLb3htMGlBZ0lwd0VHS01lM3JqbVU3OUMvT2hWMXFIeFRPYmxB?=
 =?utf-8?B?QU4zS3J4aXJOelRPcXhvVFlSVHFRY2tybXVBNVFLVVd5VGpZNzVUR1pySHBZ?=
 =?utf-8?B?bTBOcFZwRTB1NnRlMy82TTRpRVdIbkxiTjEvazlkN20rb2d4ajJPeVBMRm1l?=
 =?utf-8?B?R2RxNEFJSndEQkJoYzFzTndVT05TVEtSQnd0MW5odmMwZGNBM0FSZWE2dW5o?=
 =?utf-8?B?ZFNDNS9tN0VEa2JpY3lFYlNnL0FYK1p6UjlTNG11eG1mQzVsRGRsYldJL2hi?=
 =?utf-8?B?MTNsdkRJSkVqUnd1WVJGM01yTzRaWW5tWHVRaldldjVIZDlLN2VqNmVQRFQ1?=
 =?utf-8?B?djVlTHUwY1lSV1lmZVBlOUtFU0NXcHhIejgzejd4KzJiMjIrM2VKc2EwY1lE?=
 =?utf-8?B?TTFBVzhkOEVjUUtqVy9YeThFUlAzTWZXUGI3TXZRS0VwRlhUbGlub0t3ME9V?=
 =?utf-8?B?ZE5wOWRHQ1kvUUxTWi9qU3pVR29STCtmcDdtYzJnRzVrVW9ON0lpd1F3RVFZ?=
 =?utf-8?B?UUZzOEVrNXBOV1RES3VPbDROSFNEYTlRc3NOZXA2L3Z3V256bHlLdzhQY1JD?=
 =?utf-8?B?V1B6L0duWEdtRitPVTV4U0hmekxjU1ZBMGZXRjZHL2drTmFKcDBsOHJqL3lF?=
 =?utf-8?B?aVh5Tm02VVIzWVJoYUhQVWdhcmcraU5VZEpLMHpDNjdmVWpnV0J2TnE2VUh5?=
 =?utf-8?B?UnVwdHNMbmpQYWgvZ2pKeitVdGtHdTBaY2p6Zm05V2FlQStqVnpaL0Vwc2wx?=
 =?utf-8?B?MGZOK1A3bDhGRzlOQWIyVGJ1RzltNTBqQ242UnFZb0Y1Wlo0ZC9VeVpuM0FZ?=
 =?utf-8?B?M3k5V21wRXd1QVZXanhJTkE1OHJFVFFHdy9rYnZtL1FhaEQ0cDdtYVhtdmNo?=
 =?utf-8?B?M1kvYk1SKzRjaVp0bnJRTkZlNDJzOUwwSU1FUERTWlJaMmNoTHRmeDdzMkxU?=
 =?utf-8?B?TGVTWTdwK3E0UXhBR01EemU2WnEvcytBRzdoSXdpVFF4WVNFZTJVbnZxNWNX?=
 =?utf-8?B?bENSeHRET2ZONEpkSkRINHFuRk1pUzFrQzlWN0QwZ1UrVVIwVW5CMDN3WmF5?=
 =?utf-8?B?OEtibENzSDArQTExQVdjOXg4d1ZjVVNWRDFOZVpuN01HWTJlZFpKallLb0V1?=
 =?utf-8?B?RGl4MXp4NURWV21FTm45cVNpMGpQQU9SWTFZTml1cVdsN3RQdm56OWw3RDht?=
 =?utf-8?Q?UCT3b/FJTMQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVpJTzc2UFJMSzVkZGwyWC9vUVRPbkg3L25LSGhyaDVOK0VWUU9rZWtNdEQv?=
 =?utf-8?B?MVIzelppNCtDVkNKaTZFTUJ0Q0h4bWxLMUlmOVdQUXd1clpSR2xkYnJlZm8x?=
 =?utf-8?B?L3hTcS9jbXJhN0FvelVHaXJKK1g1a1NtVGdkRGsvRWcxMUVMMHNtb25SbWdB?=
 =?utf-8?B?dGdYVUhRcXpoK2IzUkNxMlhJS1ArUU1ZaGxZNU9EQzQ0WEpYQzNpdDFaRGYv?=
 =?utf-8?B?ci81UDQxTnovTjVub0JaTkpJeDE4aEhVKzViT3hQUDRUTmpURTBCOWVTMnpH?=
 =?utf-8?B?dGgwazJGZTlONkhRaEQ0TER5VVJvT29pdTB3TVY5OEE0MmdlcVBySWpzdi9U?=
 =?utf-8?B?NUtjdHVlV0Y2cHBvOHhlYzdZczhWTUM2ZCtVVFlKV0Z2KzZwRTU2ckhxdnlv?=
 =?utf-8?B?cTQ2ODZWenVaVHVaa0Z2Zks0N3FvWnE5VU02SUtwUE4veHBNT081VHkvNytE?=
 =?utf-8?B?aWZFZXhBRTBHL3U4SE43V0p3aXkzNUdYOERteEVLaDNndjF2NU9hUTJZaFpn?=
 =?utf-8?B?WHlZdnJ3ZXVsN3hsaVZ2S3gvVUZLdmRQcHJ4d3M1Q0lmSjZDZzJZeGtKNEpU?=
 =?utf-8?B?Y0k2TG9QODNHV2FOOCtIdFdpTDN4alVpTzNCNlRqeW1ZWXllalZlWUlDNTZm?=
 =?utf-8?B?ZGE1L2VMWTZYb2lqWFVhZTlIbDJuaTBYOWZFcmhRZGd5STVES3hlaS95WFBi?=
 =?utf-8?B?Z3JIZ01la09SaDBSbkVNZkZwZ3E4cTFPUFdOZ2FwMFd2STN0b2x2cTdha1F4?=
 =?utf-8?B?NmhXTkFRUmxFTWhnUVJwOFF0OWJMODBYQUlPbS9zZTZxMDZjU2VpUkVzR3pm?=
 =?utf-8?B?VHczUERwR3FOOHF0YmhnajF4NkFJdC9DQWxyNk12NlYwVXBqN0grMFN4NW9K?=
 =?utf-8?B?U0FuSnJYMDR2WTdwcURRYi91ZERNcWVpcStkeVN4cWk5OGRzd1oyVENFaXhs?=
 =?utf-8?B?dnR6K0R4UHlHQlBocmtveURONE9JNVdrS1ZyRCtzeFpMRGRmbDlnWEsyUVRO?=
 =?utf-8?B?Z1RpOXhtSXphRWY2WUh1UTNxRXUzYU9GQVVjbkRqaG4vdFVBTFVsSkpDRlBW?=
 =?utf-8?B?VTJlTFA2dmF4REkyZCtvck1nMHdOMzdWMUxQYmN2dTF6OEhjK2QyM3lEN05w?=
 =?utf-8?B?ZkRMbkNPTmtaNTNkcnNrMG5SNUdhMGo1eWhrRm8xN3hqN0MvbzJlR1BGS3pY?=
 =?utf-8?B?NVVPV3crbUdmYTFnc2R4TGVYYnI4Y3N4OEt4cHQyNWw3NTRpSVVYRGhOTzly?=
 =?utf-8?B?YTloUlB4VlNsUjJqbmpVZFNDU05HM3RnZ2pjZGFTZWM1WWFpSWJMR3lMbmZJ?=
 =?utf-8?B?UG5VOGUxb3AyM1hRcUVyalQzOFRJbCtXZEVoaDVRNXByYmxNR1BmdjcvcW1U?=
 =?utf-8?B?SGZ0aGZ0Z0pDSHNpdXpvck81Qys2eEgyZVBmZnlWQWFLWEFHTlVkTkdHeGdi?=
 =?utf-8?B?V1NyNVE1enhlRnArcytPZnR4MUl5S1JSYXBOTk04cHNzcGVJdVRXZXY3ckZE?=
 =?utf-8?B?RGthaXErQkQzTE1TM3JLT1g3LzlQekxYVmVkTEJSVFZGRDN5U2hMOFpoQXZu?=
 =?utf-8?B?aVYvZS9EZHpUYlE2a1RjL3o1b2g2d2dTaXlwMWF1dHQwbGNSL3pWMmF6YnJk?=
 =?utf-8?B?QjFuZklPcXBKcmRMNFNFMFpOU1lkWStRUWFINy84eXpNNnZVVmZreU1uQjAr?=
 =?utf-8?B?OWVzU0pTU0V1R1hrNlJDcjRTeDdNSlVHN243SUV2dFVYNmg1THZQTUo3Mnp5?=
 =?utf-8?B?c0tycVhHZ010OXE5cXNSczdEaUhFVVlGaUhSb3pIdE9qWEhPbVZ0OHN6OW5x?=
 =?utf-8?B?MlNBUkZubzJQRTQ2Q3piSXdQMkdmRU1hekRxeG9uQm02RmhlQ1hpenhkd0g0?=
 =?utf-8?B?Y2tISWs5U1lTVnU2Skk4SUN4VXZ0WUNKNWkrd2JkamZ0TFVMVTJ3STVXRDZU?=
 =?utf-8?B?dWNpaVRzc2pHb3l6SnFNR1RiRnBVQVJXZ3NqbkRnalJENWkzbHJNbHBPL3FY?=
 =?utf-8?B?VXZFYnZXVlVOUWQvSGplQlU2WVFxbkdtS3BGUStCall0Zy9qenFFUEZuN3g0?=
 =?utf-8?B?UmgySk5DS1RZMHNic0RRRmJOQ2doeVZYWFhJeUlGdFRpZ245MlR5TDVwMGZq?=
 =?utf-8?B?dlZPaUhxdlJxNVVFdXZLU3hOdDk1Zm9XTTYzRUxiYm5STGlnQnJvZUZRdHJY?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a751f024-f4d6-4063-b31e-08ddc000bac6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 22:25:52.5274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AXm8SHNNdReL1bXpUyfDZBz0IuqBdTt/It8TAktqqs2om37BKmQIqO/dKlXDwLLbMl1hSHOD7QiNP6Pplp8ZtnUZ273RAcLlqVMUkUrRdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6563
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 18 Jun 2025 22:04:10 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Towards removing all explicit unlock calls in the CXL subsystem, convert
> > the conditional poison list mutex to use a conditional lock guard.
> > 
> > Rename the lock to have the compiler validate that all existing call sites
> > are converted.
> > 
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> One trivial inline. Either way
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> > ---
> >  drivers/cxl/core/mbox.c | 7 +++----
> >  drivers/cxl/cxlmem.h    | 4 ++--
> >  2 files changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 2689e6453c5a..81b21effe8cf 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1401,8 +1401,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> >  	int nr_records = 0;
> >  	int rc;
> >  
> > -	rc = mutex_lock_interruptible(&mds->poison.lock);
> > -	if (rc)
> > +	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
> 
> I'd slightly prefer the 'canonical' style from the cleanup.h docs in previous patch.
> 
> 	rc = ACQUIRE_ERR(mutex_intr, &lock);
> 	if (rc)
> 		return rc;

I took a pass at that conversion before sending this out, but came back
to the inline assignment approach because the compactness matched the
familiar pattern with other error pointer handling.

The comfortable pattern with ERR_PTR() is:

	if (IS_ERR())
		return PTR_ERR();

The same could be done here with something like:

	if (ACQUIRE_ERR(@class, @lock))
		return ACQUIRE_ERR(@class, @lock))

...but that also feels like a mouthful especially if there is already a
local return code variable that can be used. So,

	if ((ret = ACQUIRE_ERR(@class, @lock))
		return ret;

...feel like a reasonable compromise for compactness on a common
pattern. Especially if cleanup helpers are also generally accepted as a
reason to bend the "variables declared at the top of scope" convention.
