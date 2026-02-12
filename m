Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21AD2D9EC5
	for <linux-cxl@vger.kernel.org>; Thu, 12 Feb 2026 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770924550; cv=fail; b=QA0PRyudmiHuktJu2Objgb6vrYWdd00p+argBSGB+RkliOCisUs3tYMMVinV3P4UfsNKyPEzgeorM9eIfLd1uOYucy1lF7j9xWXc0ED6BLTZFC0VsrCMmVs6lemCeiDfTn+ZZGMI+7CHNU+nMDTEdfNXmY0GrWubeGs3cZ8w3oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770924550; c=relaxed/simple;
	bh=tjUiM0KcAAOmPT9vZ+bqbxMaQQgWeRcSNSCj/4zoapI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=umcdC4/lPkOjnTitR9bzHmzw0lbxDQsz+DoJLzKuZErhiG6G6O8Ixp55AcL4RMBxxzfg/5wVNZ+lwCOndPYZM/iAfSIFofNO7p4reJ8M2fCVBh7YdKu6UH6WDpAyGnDNVvWGcvGb/qnGamNoaJ52Ao0VQNMhZe3WljUGWV1v4wE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ez9EvlQm; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ez9EvlQm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770924549; x=1802460549;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=tjUiM0KcAAOmPT9vZ+bqbxMaQQgWeRcSNSCj/4zoapI=;
  b=ez9EvlQm+FOXFpKdCNQB4eqBUPzSt2IdXSHd8ZXWWsoU77jYU3H5gh7g
   ZFtrlucOPr/hUytOKTS/cvMyVPHQFkgpm0IxcOn0nn9hSul6CKoCbZV/0
   edY4d7xN+GjtYZoi50IryiouZ7qu8krlQhBBx/PqbNQ0TWspHmNzH746a
   6GOczC0WE+s2xVw0/G5KSjXn7TRZvDtD38PT9QjDItYCnZZn4ZBEM8UR+
   +lRP1JFubg1cE4NPELdDq3QvdJIU6V8M2c84cKQ3yDgZFs/6TeY56IiWd
   s6YCm9rXUe1MCs/o+VoqT7i5XlH7P8A9EbDEnYXSJyCdxmKLMfv4uugG9
   Q==;
X-CSE-ConnectionGUID: QBt47ayuQayeohGxNyYkxQ==
X-CSE-MsgGUID: mSdvCRXKSgePBT71ukvatA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75956984"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="75956984"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 11:29:08 -0800
X-CSE-ConnectionGUID: ODVsc53qSHaV0neIgXCq4w==
X-CSE-MsgGUID: 1iJY1coYRqWgqR/BoZKjgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="212537922"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 11:29:07 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 11:29:07 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 11:29:07 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 11:29:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRsxLI2HZKTupm2jNutN9sJdvwPZqgmqq3OSNeuIsU0bnmlluEZ/1DKXRocakwHjnLUNYEPmqm40/D1QQd/Sb5GE1x36Y+mBB09FSDwuTL9g6DY7K42bYi7f1vDjAuitcLznTN6Y+uNgjoYlfjHsgiyzlmOonoLADl4/9nHKfGRNdOvriXnrQPx0NOoo1EDnjBAJQl5/bzB0OdG4BhZblckGGJ7gjBdh/nX5qIEmF6t57Ca6QfdhFfSFXfJOvO3IuB+Eh0YVXDM/5LiWO4KxJF6z3hWLSuN167yN4A+UbmSy3j7s3T8mgEMue0uFbU5hzK72ia79fuNCNYx+XoZYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyYu7olHyJN3FzqgjQMY9GaTd/WpIgDI+N9okICDpkw=;
 b=a5YRmqp+lgevDilmSRKLLAb3CtqNrIswremE2UXLrffSVyQESF77pG09jeDq+NPOm74+o0C1/HA1Kf7wlo6ehvCGJqfaN6Lnr9PastPVKR5K0bjTeylnoSrPX2tdkLtCVfd9kluiwRwNzSo5qAt0eyl/Y9zVsRU6UFPQ8J3hSPqEjoOh1BgRfjj156I6fgDPx5VaXUNcdDhDUhJG7LJJvO4RVHg4Oe9fJupcZu4e+xkR3wDKXT4k+lvd1cOF8IGQUnRrsIA6n8Wk14AvqaOomkvNxc70LCmZBRu78p/RpyakO7iHmTOU+T85dDkgOU2ku1eJJYX5YIs9nuo5/RvJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV4PR11MB9516.namprd11.prod.outlook.com (2603:10b6:408:2dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Thu, 12 Feb
 2026 19:29:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 19:29:05 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 12 Feb 2026 11:29:04 -0800
To: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>
Message-ID: <698e2a0041223_8c32100a5@dwillia2-mobl4.notmuch>
In-Reply-To: <20260212062250.1219043-1-alison.schofield@intel.com>
References: <20260212062250.1219043-1-alison.schofield@intel.com>
Subject: Re: [PATCH] cxl/region: Delay inserting iomem resource until auto
 region commit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV4PR11MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a481a77-582b-427d-8c1b-08de6a6cfc60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmJ5cHk4NzVocWtpMHg5dzVHYkFKb2ZjWDhBRHpRbmdNTDZjbGxhcjZxUkdW?=
 =?utf-8?B?RldoRXl1NjZmSHc2Q3NOekwrbEFsTHFXMnk2UlpIdkFWMUFBaFg5NzI2V2Yy?=
 =?utf-8?B?V1RreS9OSXFuRjJzKzIzdEpxUUh1dWU2UU4zV0xOZzZRMWV1QlBmOUdGNk55?=
 =?utf-8?B?R0dtSVJaUkgzZWdEQlRLK21hQS9QcUJ0dnd2U0g1dCsvb3JJclpoTFRlVkI4?=
 =?utf-8?B?VVdMYmV0UnMzQ0NsQlZMMDU3aFBqekJicytQbnFodXFFTUE4elFacUhNd3pt?=
 =?utf-8?B?SHNwWHNjRXpLcDMyRVdTVDhpOTlDWi9Lb0hSY0VQZVY2YnQrYWJUL21XcmdZ?=
 =?utf-8?B?Si9la01HU05HUEdJY1M5cDFuajl3WHI2MTRnbXBySzF1T1NqM1hLbTRWamNv?=
 =?utf-8?B?TEJkSTA2RTVNZ1MvSVFGOE54a3htVGVIMWhYUWtmTThXNGVWNkJtQTJwR3Bh?=
 =?utf-8?B?a09yRDgwRVFsS1VMcEFIQ3N1SWFicVBKd3hYU0c4bTN2MVViMEI2bWFRK01l?=
 =?utf-8?B?RDJkTEpnNmtzM1l1U0hidzNHS1gvNndkUlE2aDBEaFNxQnVNTVI2bFpqTUJk?=
 =?utf-8?B?R1VHQk1FM2NkWHhjNENmOCtOcW5oYXBvbW5YVnYvM0o3c29Tbmd4ZjJhcE1l?=
 =?utf-8?B?VExmSmpOSHJCaEdGNHBDOU04TEVtdnlTc1V0NDl4RTdYbi9TYzlIanduNXM4?=
 =?utf-8?B?c05PYkEvRjJtbEdScGpjaTI3SWNMOUpUYVE2Wm93dmNJUVBGNlltY2kxOC9T?=
 =?utf-8?B?R2h5OXB5cVAwWCtkcGlvTmtrZERhVjZUdml5Q1RKdHR3dmcxNTkrQkI0N2NP?=
 =?utf-8?B?cEM1V3o1YnRoczFONXNGa3NYTjN6ZEFxd0MvN0ttNnZhd3JFczcyRUM1S2s5?=
 =?utf-8?B?emtwK2xyZnRselVlYWpEbW9yY2lTUmNNWnFDR2hKd2pYVURMOERObUtZYnIw?=
 =?utf-8?B?VmMyNWh1bzd4ck1UemtQRHFXaTEzQVpUbzFLNTdIWS96Mk1jdnpNSVRSSE1I?=
 =?utf-8?B?ZWQ5SUF1NUg3NldGMHJnMllHbDBFYlNqN1dKWmlWM1EvVldUaW43WFdxUVNH?=
 =?utf-8?B?REFrSExnN0o2MzhVTGN3NWJXSy9tRUJzcFNkeTlEZVNPUmdjZTdtVnVaM1lR?=
 =?utf-8?B?eU5UNCtpN3kxT0EzSWM3QmczU0lJNW1Pbmh5RTNhSjRCeG04dzllZjVwWmMz?=
 =?utf-8?B?RHFydzI5c2xkc0RKVXFQMk5ESG9uOEJsTDAzZ3B4V212bTNUbmVRbE5aUW9s?=
 =?utf-8?B?QklnS3BibmNYS2U1ZEZsTkxGYXhFNDNuNUxTTEZOVjRuV1hVamE4UFZ2T0dJ?=
 =?utf-8?B?cjlXME82S1Vmb1d1TTZnYzNma0JoeVBEbmltcUR2enc5YkNmeE1sbjRkNDcr?=
 =?utf-8?B?R0J0RmFGOUFsc1EvTFpMQ2F3WVBqK1BDYkN6eWx3cUUyZ1lkV1FaZVEyVTd0?=
 =?utf-8?B?WVRWL0psNjV3M0RjNEJXTyttWituWWcwSHF2dFdUUVUzWEpkU2RjSFNkaDJW?=
 =?utf-8?B?SWZuM01nMU8yMmQ0dDZQNWErV3JDYVJHR0tSblFhZDI4THhLTHNnZHlkc3Rx?=
 =?utf-8?B?ZG9EamRsclFob2FCWjFrejdpMmUycDdUTHlPeWcrdnFZL2RScmVDWHdxencr?=
 =?utf-8?B?RnozNEoyQTRLcHZXSlhhNSt2VThRSHJidE5mTnN3N29PcFNXdEtBaXhZYjll?=
 =?utf-8?B?OU1VMGxOK3Q0YzJZVExiUFRZRy9DQnJkYWU1SnR4TFRJbitSZGp4Q0ZwSFJD?=
 =?utf-8?B?Zm5yWGF3amxlVVdYSkdnYXRpa2dKMTlyUGhUZFgycXpud0JBL2xLOGxRTDhs?=
 =?utf-8?B?R3ZSZ2VpYTV1bDhTelBqaktEU0lra0toM3JnNWdVSnVEYzVOL0E0ZjJvcjlm?=
 =?utf-8?B?WUg2aGpzaHVhaWxyWmFZcEhGWGo5Z29XdFNxTktnYTlHa3dGdU9reU0xQ0oz?=
 =?utf-8?B?bzAxRlM2bzBiQVlsbGViSHNIMFhYSFNIcG9TQjhHaFkxYWx1R1J3VHd3Ritk?=
 =?utf-8?B?L1ZvZHRHdkFIbUtxdXRiSmRJalNPaDN6alJ0aDBhZDdQU083S0NqVXk2N0xW?=
 =?utf-8?B?Y3Z4TlExbnBWMWR6NXBNUmRNNE5XWFIwdCs3cU5qcHY4WVluZklJNWlvZkdp?=
 =?utf-8?Q?MnuylIVupZRk6XtzbYhAXY0E4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVpWM0RuRnhkc0Y5STNqUThQTFYwVVN1VmUyb3NiMlNURmxYWC9aOGZvVUpJ?=
 =?utf-8?B?NzV3WUZzVzdXcjRkQU9adlEreUtuTExnNWpkbzd0WmlUMmdyZ2k1K0hQRStm?=
 =?utf-8?B?WGlndlNvUkdQT29sT2xhNU5kbEdaaWtPd0ZsUk5JVHhxYUNjODJFRk5jUllH?=
 =?utf-8?B?REFhQlRlQmgvTkJScDhtSHliaktQSWF3ODNISW5TNkFsWVJkZm5sZ0NjT0lO?=
 =?utf-8?B?RTRlZkp2VVhXS2RlT2VXSDEvUFlGT0hKdjBPeXhKQyt6MTRlQ05kUG1lSXRs?=
 =?utf-8?B?Sk1lY2x1MkFFUDFBWWJJRG5hQ0FIbDB6ZWxld1daeVozRHBDcWpOZ2xNblhq?=
 =?utf-8?B?c2tWWkl4TzFCeGV2U1N6YUVqUVBzbFpua1cxQi9Ha3pIM09oVTMyNTRQcys3?=
 =?utf-8?B?dVdJZ2xJdE13eE15VExzR3BGZ1dsOWhrVENUVFZDNUVqQkNmdjJBKzkxU283?=
 =?utf-8?B?K0l3RGhoamFPcmwzUko3WTJWUDFrRXB2T3dqQVVOaUtHYUljNVJMMmhHa0lT?=
 =?utf-8?B?UUJBeGF6NFFoRGo5QVQxMC95ODlkcW1hZnZjT0RWNjB5dWFvSnRDa0IrL09v?=
 =?utf-8?B?YnJEMXVwUjNDQ0wrbmhwQTIySlVwUkZlNTJVUnJrajg1R0NCN21xUXZqMDJV?=
 =?utf-8?B?R1ZsNkZQN3l0WjBaVmNFczJKTmlxVHNrRUVDQVc5em1JWkU4K3l3S2lTdS9T?=
 =?utf-8?B?ZWhteUVSMUZXeHZiN0p3WDVqSlh4cWlDREQwRFpoRVhCOGtqTHByRy9udFpp?=
 =?utf-8?B?dXRNRTFjZisyWnltMjUxMU9tUjRNMGFKc3BpS0pUcS9Va0V2Z3cxZnRHOTVJ?=
 =?utf-8?B?KzBGYVJuLzFaRHFobVdKYUwrM0VnUDgySVJ0bkF2eEFDa29GN2tnZkJYcGJ6?=
 =?utf-8?B?Mm05dDE5TW5qc2hxM2w2c1BSQlJ6aFBoUlExTjVvaXUvZGNaSEVjWmNNVkJm?=
 =?utf-8?B?VnFmR0VidTMwejRFUFk3WXdDbzN4T1BmZnVDVk1pK3pETWxQb2EzR1JGcktZ?=
 =?utf-8?B?akh6NTJQZWR5Z0hvUkt1ZHVlZEVaVWVHWk4zOTBzYTlDN0dMaFJ0YjlUTnU4?=
 =?utf-8?B?aDhCeHE3b2pkVjBzQjdmaXNBWXJOVUhyOGJVQWhlZGRUdHB0M3dVaTJ1U1Yx?=
 =?utf-8?B?Ylk3UFYyRldXS1o5dWVBV2xobmRKSjl4em1xZzVXWGh5RlVPZ3VUSGVoTW41?=
 =?utf-8?B?bnc1cmpVd1VZZngxeEZVakZ6cXdqOG8rdGxlUXZna291VzF5SmEwWWY3dWk3?=
 =?utf-8?B?ZHFncFpwWkJlVExGWUpZcEpEWTNXcWZndjdOZjdjbS9KK1YyT1BRYkNMVGJy?=
 =?utf-8?B?VnNjZk5LenB1RFBFWllwYTVmUG9RMXhNRTRmUmJHblM0Rm43dmJVdzM5L21U?=
 =?utf-8?B?YUVSSFBTSkxCY2R6TDcvU3pla1Z6VGkzTEE4bWErUHZjR1RGcllTQnNPQklh?=
 =?utf-8?B?KzFTQzViVnoyZXV0WkhBOWhUZ0Y3dnliOFBIOXpLRkw5ajlpeUQzdXF1aTRr?=
 =?utf-8?B?eG1KNjVYN1dGQ0lXTWtXaGNsZi9MNWhsVzE3bkVZUTJZRGJQN0o4QVBnaGdH?=
 =?utf-8?B?U202Q2M2Q2NUN1Yvb21OVTY5YTBCSWp3czI5TG1NMHArNDFGQnF4MEdlYnBT?=
 =?utf-8?B?dnllb2xEWlloSmdydkxRdHM0dFIwZkd0cjN3c2FRc3lFRE84UlF6QUFKQU1x?=
 =?utf-8?B?U1RhZ0RlS3lYV2dpNmxQMk5ZWE5QVnByRG53ZnFlQ1FTRjhWSnpydVBvZWhD?=
 =?utf-8?B?NDUvQkVUYzVTRzNDeGxzczRmckRGekdnTkg4WjMxMU9YNmg5RlJadHdYSTFF?=
 =?utf-8?B?Tk0vWDd2a0xFaFBuUnV5bjZmSkhxNi9xT1ZtMUNzWkw0REI4OTVsUmMyVEhQ?=
 =?utf-8?B?UVg3a0phdVYvdmw4RGp2eStya256bW5HSHRObE5ENXc3eWdudng2UGV2UG93?=
 =?utf-8?B?UjZBTjB6bVFxb1BlbStSYml0MEp0QVhXT2t6aDAwRFBRZDZLdUd3TGRHRnNY?=
 =?utf-8?B?LzF2TzluNFRzNGlITlIybHJSK2c5RVlQcTA2NWlwV2dBeFJ5Q2ZoM2FQR0dz?=
 =?utf-8?B?bElFR0lJb3YxUnpmb1JoT3VWRGpjZ1VkeXBTQVNLN0I1ei9KL1Z1M3ZhSi96?=
 =?utf-8?B?aHBIK2ZhZnNsOFJ1UHZ4cTdnY2Z3OFVhdE05dEZpTFk3ZWRzOW85L1BRdk1z?=
 =?utf-8?B?Sy9wSC9ya0RYSEhhTzlBRUJqa3NqMEpVNWE3VUFBa1dHd25Ibm51MnFXdGFX?=
 =?utf-8?B?V2RRS0UzK3NzVDJyZFVFNk4xc3M5SEFMSG1HYlVnZUhWUFM1TmZ3bEdvcFkw?=
 =?utf-8?B?bmtvYmJ3ak1UN2hYM1JrMlcxeHZsMEY3dzFNSWl1ZFRYZ2pBbDl2dDBGRFV3?=
 =?utf-8?Q?aJiTxBB3ZATGe8+s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a481a77-582b-427d-8c1b-08de6a6cfc60
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 19:29:05.7842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a28LTNS2skYLfb4zlaJLsHUNL0QDHk7WtChHplxOZBPcNocS8j7tFfToAZC625dzm2iy/BDO8c0PXTKTJdqImmeDSINrdZtrkfwOah7Csk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9516
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> During auto region assembly the region driver inserts the region
> resource into the iomem tree when the first endpoint arrives and
> region assembly begins. If the region later fails to assemble, the
> resource can remain stranded in the iomem tree, making it appear like
> a DAX region is a child of the CXL region, when that is not true.
> 
> For example:
> 68e80000000-8d37fffffff : CXL Window 9
>   68e80000000-70e7fffffff : Soft Reserved
>     68e80000000-70e7fffffff : region9
>       68e80000000-70e7fffffff : dax19.0
>         68e80000000-70e7fffffff : System RAM (kmem)

...but it *is* telling the truth. The truth is that multiple objects
have laid a claim to that address range. The region9 object has reserved
part of the CXL window for its use. If the "Soft Reserved" and "dax19.0"
reservations are removed then the address space should still be reserved
for the region. The collision only occurs when drivers for those
competing objects try to mark the range IORESOURCE_BUSY. Competing
claims to the same address range are why IORESOURCE_BUSY exists, benign
overlaps are ok.

Note that CXL Window 9 is also reserving more address space than is
actually in use. Like region9 70e80000000-8d37fffffff is reserved
address space with no active decode.

> In the above case, region9 failed to assemble, yet proc/iomem shows
> the DAX region as being parented under a CXL region. In reality, the
> CXL region is in a disabled state and the DAX region is managed by the
> HMEM driver.

iomem resource parenting shows registration ordering, not actual
parenting. Most of the time the registration order and the parenting
lines up, but I would be surprised if any use case depends on this.

> Examining /proc/iomem is one way users inspect the memory topology,
> and with this patch that view remains accurate.

The ambiguity of iomem resource parenting can be resolved by looking the
device-path for dax19.0 ("daxctl list -RDu"). It is also resolved by
noticing that the CXL region and the DAX region are using separate
memregion_id values (9 vs 19).

The extra effort for incremental precision is not needed, the contents
of /proc/iomem are accurate.

> Delay insertion of the iomem resource until the auto region reaches
> the commit state. Introduce the res_want_insert field to track whether
> the region's resource should be inserted into the iomem tree.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> Putting this out for comments and I expect to rebase on 7.0-rc1 if 
> this is wanted.
> 
> Today it is built upon Smita's v6 Soft Reserved set [1] because it
> is with that set where the failover to DAX starts happening and the
> confusing /proc/iomem can appear. Without that set, the resource of 
> the failed region appears in /proc/iomem, but it's less confusing
> since it doesn't show any children.
> 
> There is an option for Smita's set to teardown the CXL regions when
> it takes over the resource for HMEM DAX, however latest revision, v6,
> has taken a gentler approach and leaves the regions intact.
> 
> 
> [1] https://lore.kernel.org/linux-cxl/20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com/
> 
> 
>  drivers/cxl/core/region.c | 32 ++++++++++++++++++++------------
>  drivers/cxl/cxl.h         |  4 ++++
>  2 files changed, 24 insertions(+), 12 deletions(-)
> 
[..]
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c796c3db36e0..2b977ab33af6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -480,6 +480,9 @@ enum cxl_config_state {
>   * @interleave_ways: number of endpoints in the region
>   * @interleave_granularity: capacity each endpoint contributes to a stripe
>   * @res: allocated iomem capacity for this region
> + * @res_want_insert: true if the resource should be inserted into the iomem
> + *		tree. Set to false after the first attempt to insert or if
> + *		res originates from the iomem tree via alloc_free_mem_region()

This is too much "control flow in a data structure" for my taste, but is
moot given the comments above that this extra effort is not necessary.
