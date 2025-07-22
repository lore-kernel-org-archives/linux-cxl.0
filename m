Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C8C28467D
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212516; cv=fail; b=BjCI9GLTMGtQwdeHp7rlmIOoNlgQtTb9QuxE+MNEbsDiMyAW+9g14BX+IRnZE3+IlggGPcmPL9UOztGOiOsaESr4iUpHi/Lo4cyK/7xSP1gI+ldRHavWzrhTRFS1wsYRvpnLjGKUbfCbuPx3Q8W2SeWUCSrorBdbJxWioBjzKXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212516; c=relaxed/simple;
	bh=n8BpIeixGLX4KpvFyj5//U2nKu+9CtqAkEFqhUnEJgc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=KODQnbzUrySUd5R8ADaOku70gO0oNVn9PFzAWdZRJ4dmuxITbUTJxlwu+AHIocRATXfvoQfWNM4QMvW4RMd+idhA94l6VNigA9InnoJCNml42gdIXmAtILLOJh4CJztf4D5siYc+hwl/ulzulllEmyCTpHJ8LCFUNQSJP4qwjHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AuEEzuhD; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuEEzuhD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753212516; x=1784748516;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=n8BpIeixGLX4KpvFyj5//U2nKu+9CtqAkEFqhUnEJgc=;
  b=AuEEzuhDg7gNvme9TLxNtdQIgrijrLy+07uy6n2xZIKcaV8W6jiSEMBy
   caYj/6lU93qDaSytnMVYcFewiQYGwDozotWUi/oUFhtFGP4EjMdtaBIHv
   Ue/bWDKYzkhzeZpybYh01C2zq49VscJyD2X9KvkSz7RjMCxRLL48fPra6
   dxmf+jHIaYfVvj9rHV7ZXBzseZRL+gqJ+VA+annGAR27NyMIN3EZZJSJN
   U6DPZ1uSAgQAxhkvfppgFiUpY/9ViLtyFnzEKO5pwY10QpmHv33Beg2fE
   bwC+pGD1yA+d1otHJsyqBIRtHqsNxx4cp65tq0i5mhxH2G60j6fVJDpmK
   w==;
X-CSE-ConnectionGUID: 8XNZ30oyQ9G/9rnEB8fIXg==
X-CSE-MsgGUID: XoL7QqLFS1mGRkuRtYHiGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59136377"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="59136377"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 12:28:34 -0700
X-CSE-ConnectionGUID: Qnn4YUgeT/CfDOJ+SjRo0Q==
X-CSE-MsgGUID: UVqQ6rR3SICg3nfpIiAwtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="159283685"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 12:28:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 12:28:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 12:28:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.88)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 12:28:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7EEspkjBbPSU3Tz3c9jZgrxrRQ5QCXYDwA2gWKsVDxvr1m6YeldZDVo7vT6clxYfGy0OmCpiBPmDFhCYJkMfP2HG7gvhU0e4D4rq5LxAjCMJB57to5zeH/Wexv4Kgfzkw3GJ/J+v0rvI7+QkxWE/l1/fqXBgYS5K3Az+ttxZqvHHQYV/kU5rVw8HR8bzWC3lJShOBGx56tboR7bUQu/4mhLpjz5klvCaYedmT6qZDkbs6ckUfYLKSiCND9eX1ZBIfvfJ/tC6n4GEZCGMSdlwQy75rjjAcQ1LUNTbvUub2/Ew+4kRe/KaMqDon2NBDV3EoEgwDlxz62yz25VgnUGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pC5aVqNzvNfFrVF6K3p0CbvXI2jhIUooF+iytyRTlXw=;
 b=c8CsZRMivXB5d58xviFTEG5KEtG//S4iWQSeSR+EAs64KQdSHymiaxH1FCG3IlWjXzVh/2PnHZcZAdY0w/3pLIUjYMNSdq0mI9i6FMQd8HGx6BbvoYKKeUYJuvpz8kv//NwRe2/ZB7IYuFrlHY5+WHW1Z5mpCvkoUDG2Ygw7eORIO/INImJKMtIA12jEGs0MLPKv7w3jR0X80DYAuW+McUq6hGRUfhum2+tYJ2IA+rMApLbBSIyL1Ci9xUeptvkCFnObrvIm57CRmzXfCj3VBREQLwrgzUJugAuPYFzbSWrlB/zpn6AkeAo9EpgrUEWxwvul4ku01WuS9tYq1P8cOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB9517.namprd11.prod.outlook.com (2603:10b6:208:5b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 19:28:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 19:28:30 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 22 Jul 2025 12:28:28 -0700
To: Dave Jiang <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, Li Ming <ming.li@zohomail.com>
Message-ID: <687fe65c5cd80_137e6b1002b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <893e2652-ce0a-4bfe-b601-ab651dcda2ef@intel.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-10-dave.jiang@intel.com>
 <687fd8e884ccb_137e6b10065@dwillia2-xfh.jf.intel.com.notmuch>
 <893e2652-ce0a-4bfe-b601-ab651dcda2ef@intel.com>
Subject: Re: [PATCH v7 09/10] cxl: Move enumeration of hostbridge ports to the
 memdev probe path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: edff6c19-bad3-4a7e-2e85-08ddc955f071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1I0bmROOHJjbmhxTXdOMloxNmFUVWpldFdzOHZTZWd0bU0vNVFTbkpTbTds?=
 =?utf-8?B?UmlXQm5la3hwc3Q1K0xlSkVoSzVBQy9RNkxWTk9mcTJxSFBHd2llMVRHdFFR?=
 =?utf-8?B?ZkprVFd3bkg2L1N5MmlhdHVOSlAxeWpMazIyL0t2MUNMSjA4R1hSWHFUV0Ry?=
 =?utf-8?B?Y1lubDZGeGNVTUNROCs4bk9Fd0M5QTgwcWEySDZiN1hNc21KNHB6Z1g4NlRW?=
 =?utf-8?B?MGVSTG5ySjBrSjFmS21tOVlPbkVTc29nV3VMLzMyU3h4bytoS3hWRkdSVnFN?=
 =?utf-8?B?dUJkbE5KYkRKZGdZKzlydUJnNHVaSlU1VFo2QVZQeEhuQUtMTE9BbzdPeXRP?=
 =?utf-8?B?OTB4dnVEQWZ6L2JJa2hmaFhMeU1lVkNkdk1yeXVMZmpOQjMvUWpBUjZPNm1G?=
 =?utf-8?B?UzkyVXZLRVFuRks2ZU1mUzY1a2x1UzREWnB2TGZjdmJEZ1JSclAybE1VbXVi?=
 =?utf-8?B?c09UM2ZaWlJZMFZrL3doQko3czBNdXRCSXBoNytnWlFpZDhjWWQ1WG4zcFg5?=
 =?utf-8?B?b1lmUWQrakN1aTJnRTU0WFJCWVJNWVpIc2JDbnMxVmNVQUEzNWZxT3VsR0k5?=
 =?utf-8?B?emtGTTJ2MjI4SUticG1ZSUVRRkl4TXNHaWxRRXlBa3BzOUwwVVVzdk1RTFY0?=
 =?utf-8?B?Ry90S2xVZzROMGcvUk9QeHZHMmQ1V0RYcFRCVkU3SUJqS2FUTWZhSmhmTGZm?=
 =?utf-8?B?UkFWZXhNR0xwOVB6TWV5eXprbC94RjN5QThFSjhMRkIvaUFuYzhZWXA3VVBP?=
 =?utf-8?B?b1E3ZGpOSndwZzl1VDlnRTJub1hubXg2L2RmeUVHZDNLN1FCOGVnUkNRK3o5?=
 =?utf-8?B?eHZhdVFhRnNlT2FPbk80VDEvaDBHcGd1LytiZkM1RVpUd2lmMGtxV1RiRG1a?=
 =?utf-8?B?YzBKclZZSEFBa2ZEZy9QNHV1TmREalBSSlhIOGJDYjJTTlBDQjJUYTMrZWo1?=
 =?utf-8?B?Y2Q4bjllOUk3THNHeCs1ZWNnUVJWemRGejFLU0hIZ1grSzZQRlk4Zld3aDF6?=
 =?utf-8?B?SUpWc1BDS1ZJYVFHZHJnNkxLWE85M2lRMFdIcUZLV1JZSllLb1lxTG5ra1hp?=
 =?utf-8?B?VFU3UzVtTzBuRmEycEZ6VHdhK2V6SEVUa2M1dUdKMDl6L1g1YnQyUnRMcEIr?=
 =?utf-8?B?a1FLdFhwMW5lSzh3WmE2UmdZVzRIeEovSG9EcUQ0L0xKQjRmMzZKU2Rwb2l4?=
 =?utf-8?B?eEZpdGFWbWplUmh6aTRUYkdxVVNtUTkzSXQzZ2phSkFWUEVnb2I0Y1VvNUI4?=
 =?utf-8?B?RkVNN0o1Wnh0ZHNMRzM2OS9wSUJzdU05c09pbGhNc0M3U2FOcEJxSjl5cW03?=
 =?utf-8?B?czlHSUg5Q3o2WUxSNEVwbHZRY1dSc29oendVWnhLQkM2QXBYNTB6c2NIVkUz?=
 =?utf-8?B?ZWNmWGswSkZOT3g5Zi9mcjl1ZzJVbVhlQTFWR09QVEVsY0cvbmRVYjg4M0tS?=
 =?utf-8?B?NkFIR3R5ZkhZcW9pdjFVNlRNVTZ0dkt6UGR6MzVKNFd1SGtXR0dYOEgxVkZM?=
 =?utf-8?B?eSttMmZuOTBwVUhVNjJWMkhBaHRTUlJ3QUVpbmVEMGdqeENnVEFsNXR0SGw5?=
 =?utf-8?B?elJGb0pHcDdCOWVGNERlYldWSVFqS2EyYXdLOEk3WGR1ZFZQbFFFc1RZM3N0?=
 =?utf-8?B?TVNNS0g5MXBKSHBHa1lTYUN2clpjYi9UcWFVS0tpek9rbWxsR1YzK2RyZjZJ?=
 =?utf-8?B?YVFBV0I1SXVJdytBMFV4TXhQRHZwUFJwT2JUWWVkSWpRdG5kd09ucEtrM2Js?=
 =?utf-8?B?a3g2TEgxVkM2VjFsY3RHOFZYbVZHcmo3S2NQcnhBdDcvbHl3dTN3UC84QUlk?=
 =?utf-8?B?L2k4b011MnNCSExENFZ4d3YxWnlFSTNnYWFDeFNLeDRTU3NQZ2dwL1lIUHVM?=
 =?utf-8?B?bE5mM3YwT3NCOGFhNGo4amVvUjA1U1REejE3bjh1eWZOMUl0RTc1N1pGM25M?=
 =?utf-8?Q?FULF3q459oY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDZCMG9FTlh2KzJYNWJQWlVRaXBhRjZMdzEvZ0dzREJSMldkWG55QVQ3bTkz?=
 =?utf-8?B?S1FmRlpNN01Ib3hKcVI3SXplRDVmM2hUMVRoMURxbVVreU1IS3RUNExMRk5Z?=
 =?utf-8?B?TnRtZ09ocHpibGhieTZWQTJOaGh1THU4cGZ2Vzk5eHVXNW44d05RMkM5SGRz?=
 =?utf-8?B?QnlQUkVHcHUrRmxNajRQdWpIK05SZmlYeUJqOFNpL2IvUm9aQjJpNDU4Zytx?=
 =?utf-8?B?VS9ueGFDNE5xWVpkS0k0ZTFhNThaN3ZLektYcFNFS0FiL0RPSVNlQURvSmNI?=
 =?utf-8?B?ajlreFEyRGFTeDZhZnArc0l3RExZWFo1SmtMbDFXdDN5WCtVRm9UU2ZpY2kx?=
 =?utf-8?B?ek9pOXJrbTQ1ZG9wQXpYUVUrZGYyM2MzclhTb0hsVmZQTmgzbUwzSFBBekE0?=
 =?utf-8?B?akJ2ZzkyVFh4UmN6UzIwcXkybG1NM29JVG9zYlZrMWNGQXJaOXZ6MHVzTTVs?=
 =?utf-8?B?WnJnMFN1Q2NBUlpxZ29mQXRteEQ3YjBLM0x1MnBGVnJ4L2d2M0w5R2trZlVs?=
 =?utf-8?B?bmx4VUdjZnFuNjNoWnhIakFBaFVza25aWUQxNmR5T2Z5MDhYK2wxcWpqSDNn?=
 =?utf-8?B?TzBad1p6SlhRQW9wZ3VQMTZrQ1pISElQSittcG4xODJ0YXEybTFXUWVRK1RP?=
 =?utf-8?B?azMvUDBhR1AxVXd4YUpKczJRL3B0eGZXRFBtUzlZV3VRNTEwN2ovek5MalRM?=
 =?utf-8?B?MHEwQ3JObFdtdnJqTGYyUEdrMkdZSkZDYmd5S3ZqRlVEY1paa3ZObzc0Y0dG?=
 =?utf-8?B?b0xpRVBGdVBOaEFCQzZnbG5pVmN1YUFuRk1nWklSNENuUmhZbGNrMDlYZk9I?=
 =?utf-8?B?R1RTcUIxak5UN3Zrakg3MTcwYzNpVnF3N1kzMktzK1h6bS9kWmtEOWVwN0VO?=
 =?utf-8?B?cndHUlIvMnNMZFJUYjFsR1hFdEN5T1hVQ2t0OTk1NkVVamEza0p5WFk1V2lP?=
 =?utf-8?B?T1BsczZTYXBMZkJkL01CUlpmMjJtN24xZWhiOTRJaWdGdGNXdm82SEg2ZTBM?=
 =?utf-8?B?Tkh3WGNWdmpEWDNZejB4MDdxeUtuQWdMbzhta2lGRG5QRnBRVUN2SzM0Ym5C?=
 =?utf-8?B?dUhkaU1YYmRiMFpheVVUbTJ4R3pyRzd1NUg4RFcrNndNQVNPUDRYN3Q3RFBr?=
 =?utf-8?B?V3pXY29zaUx6L0ZNZzdqakczYXZkQkpHMkdDb3c2YS9yMmlhQjhLZklvZUJ5?=
 =?utf-8?B?ZHlHaFErMHg3NFVOamFKUjUzR1ZwbndvYWozcTN4Vms5UjlZZGh4eUdiVmJZ?=
 =?utf-8?B?YlZPQU96L1U5RWVxb2JuSlpqbXlnQWJ4QWVRZE0wbTlTVERMZ3dMS0ZHSmlx?=
 =?utf-8?B?MDYyRlduL0NTNUxGRExPbnRHT3ZlbjR0Wk8rUmFmYjRzakRvZEVRSFk5OGhm?=
 =?utf-8?B?aG9hK1lBYzVLRzdMTXE2M3NvakNjREFzaVZZUVE2S0pqTXFwb1ZZd3I0OWRv?=
 =?utf-8?B?SmxYN1dBVGl5VGpiQXVrYjhCMEtibDFkOUNjakYxYTlzaVB6eHdOd0NpRkQ0?=
 =?utf-8?B?L3IwWHlRSE5UMnhFYWxnTXZ6SlkxM3pTT3YzZVlKSU9vS3dZc3BwV0NsK0p3?=
 =?utf-8?B?TFB1aVRQbEtCZFBOQXJCMnZNTEQvZGN4WStnRm1ScE1nL3RUK085cWVQWmdy?=
 =?utf-8?B?cnV0cTB2VnJxQ29FTzhlRGlNTTRabnVnWVRld1V5ay9hVG0waXRBdzFlU1U1?=
 =?utf-8?B?TXFudFJ6WEtMemNjOUJ3WFBmdWFiMmNHRUJYcEdHSFk0S0JYWFB4YjdhYWlN?=
 =?utf-8?B?ZERwMmJlcFlidElzWjlHOS9pMGgxd0R1dlhlS05FRHZ6TVByOVlXcUI5Ym04?=
 =?utf-8?B?NXhKdDVERkErMkZpanF0clNDemE0R2xyOXNTWXF3bk5mV1JZajlSYVYweDVy?=
 =?utf-8?B?UTV5MmdWcVpHZHNMTjlpdTlBRzlvUTB1SXBHNUd2alhFdUVKbE5qc1hpWnNI?=
 =?utf-8?B?aDFBN0RiazlMb201dTNFZTdWczUxL1lUSEN2QWxGamozTERCWndQZHFEQ2dD?=
 =?utf-8?B?eWJTRjVhNm9tSzFFYTEvU1p6WmZYTlRwV256V2xMT2tNYzAvaWV1eDFVR1hi?=
 =?utf-8?B?dCswNkpraHBQemtGV2ZGSi9iRWlraFRHcmhXNWlzL1NiT1Noam54MTU1dU9U?=
 =?utf-8?B?UTlTMHIreUsweXRlVTBxM2ZvVXMxcjdJWmJrTEtabC9KcUZzdi9pNVJEOURP?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edff6c19-bad3-4a7e-2e85-08ddc955f071
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 19:28:30.1294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28i1rtr+Zlpk789/jqYts+8Iw5LunQQfpqplS1diZVpJCsaplvbCr+l/k4766d0zBXsCcT4K6IAOVIRCflRE5+h0FcMPItEqwcpM/nH4sdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9517
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 7/22/25 11:31 AM, dan.j.williams@intel.com wrote:
> > Dave Jiang wrote:
> >> Current enuemration scheme in cxl_acpi module creates the ports under the
> >> root port by enumerating the hostbridges after the dports under the root
> >> port is created. However error messages "cxl portN: Couldn't locate the
> >> CXL.cache and CXL.mem capability array header" is observed when certain
> >> platform has PCIe hotplug option turned on in BIOS. If the cxl_acpi module
> >> probe is running before the CXL link between the endpoint device and the
> >> RP is established, then the platform may not have exposed DVSEC ID 3 and/or
> >> DVSEC ID 7 blocks which will trigger the error message. This behavior
> >> is defined by the spec and not a hardware quirk.
> >>
> >> Setup an association in cxl_port to tie the host bridge device to the
> >> associated cxl_root. The cxl_root provides a callback that's setup
> >> by the cxl_acpi probe function in order to create a port per host bridge
> >> that was previously done during cxl_acpi probe. Add the calling of the
> >> callback in devm_cxl_enumerate_ports(). The observed behavior is that
> >> ports that are not connected to endpoint device(s) are no longer
> >> enumerated. This should also remove any excessive noise of port probe
> >> failing on those inactive ports.
> > 
> > I do not understand the story here. Why is it necessary to hide host
> > bridge ports that do not have endpoints attached? I think that is
> > valuable information for hotplug to identify available ports.
> 
> It's not going out of the way to hide on purpose. It's more that this
> is the resulting behavior when we are setting up the hierarchy via the
> mem probe.

Right, but that feels like a step backwards in system observability.

> > 
> > Now, if the concern is that host bridge CXL component register
> > enumeration happens too early then the solution there is delay port
> > register setup until the first dport arrival.
> 
> Are you saying to just delay the RP register setup until when dports
> show up, leave the enumeration as is?

Right, cxl_port_setup_regs() moves out of cxl_port_add() and gets
triggered by first dport assignment to a port.
