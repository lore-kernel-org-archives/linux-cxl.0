Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4711DE892;
	Tue, 15 Jul 2025 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599380; cv=fail; b=RvnuYAUvG28szpazdEDWZQ7PI6nFkXdPHQP/RH82jyWXPP8HYs+4AcRBmHWv7oCK5hk8j5l22rToskUc0hHWBwpqVFFIxmhHJ2U5159ogStYxawleAlAtRnGumqD49T7G42BYWrKlLDUtjQGJ8wCUpLdp/QGT8nPL/kR06DZdJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599380; c=relaxed/simple;
	bh=7rs0vDMTbRW4seeT6XfvmpS08n6FS5wl+5FXSLvyK0g=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=uKU5Uqc6EdkOjAozsuDeA3ntBwDM81Eb8IHwyBi2o7JvA2aHrIRFHcTD7P7q7wF9SOEKJ0qaCmEGCladBAFSyTzuLB97VVrQstslK7j5EDdCRxJFzSe8+go9Neb71fgXO+vtNpuZOpae3smotgah9P4svlJz5ipxEdDmVhiPwYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtjwLeN2; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtjwLeN2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752599379; x=1784135379;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=7rs0vDMTbRW4seeT6XfvmpS08n6FS5wl+5FXSLvyK0g=;
  b=KtjwLeN2WGPJHt/t6ibwgFgbOXgCrflOB6mX/xdU7j9s6z8Dn/GVa2w5
   OwrI9rpv6Wk3/FYGf900ujReuYNmJ5VoUiWk96ts4y+NNbcOp5c5Moy3I
   Xojn/Ep4VboEzOi1yK9SxCDydazTtUHvAhoKebJXWQpH28lcE+I+CkViS
   KOnLk/xy5cF77uYL97CqUXQNrZ4MgG8+fFAqVEgizRqdiuD9N0gSJKRk0
   pHrBNLD6B+cATyU4EjzIEvLNd820wBnNd7tqFC81RQL4HXjXXpJKGUEp9
   yaBezRFWNipILGprWZFAWXhJ/gOLPuas8To3jrF5Z9Wz/9ZljO3CVelYl
   A==;
X-CSE-ConnectionGUID: B7X/TG/3RaCKMpJbnJkxOg==
X-CSE-MsgGUID: i7s9FUlZSTiO9vyxnkvmXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58641718"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="58641718"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 10:08:44 -0700
X-CSE-ConnectionGUID: Pe4fG/fxS7unD5JZhOBN8Q==
X-CSE-MsgGUID: MpRWkz8ySH+gT5oLridIaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="162918929"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 10:08:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 10:08:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 10:08:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.45)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 10:08:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6ZEodu4poViXmo3JSQMQBrHmS7s9CXnITYv0sTIwMcuPmntIQOBBpUESVZoLATheYDlHk1XBlynkwulPAkiJUJnh4VpiKxtP/52IULXfPTNyyKtFp3oypXiJffSz2oUAXNKtUKcTNJMpwZ53VSdkil5HhbXkaJ0CYOPmJ+W8Xtryn6VTdOyMSRqKeZcVSw12SXqbRa3mejUUf8ufJOP3QPnAheZQyy3vXmzPsbDO62Ar5NDVk9VCjhvDHi99agmlEejlRET85AjDWsnfgtFKtG+SrL36r66DPiRbip9MZ1lvNlFa9YxDp1bn6KsWsH/6VlUKp9krQIprPXMlnSshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxk7y198AIjweG3S6bptO0IeA+L/F2fOnlOssM5yK0M=;
 b=Aiuo+6Ffx34qABVJ9IVdZPcsjLC3qvxYOzhaHUAcIwYJz7mp8k5ZE/hwL1JKAD60fZJLdL63L+Ti4jnmGQs7FMNmWoKCHRV8sjcIixhMdIX8U0gt1Q39XxnnBwYpXjVCS4QR442qIP1SA5By6JMkgwozZuv8aVChzK9Udnsy7RodOf5c3tsNW15TXCTT3F8lO62woUmePQbXujC/MVpHI6zLKPlNA3bw7V0tgEHfHSVH2rGDWAxI8e2wzoc+7I+HpWBEZMAlpUcxEWIJz3/q4sCUEcWQNVeO4VA+mG2fPZp/zHVVm11jLMCFSbG7LqHjDHwXqODBHdhELoCEzinetQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB9087.namprd11.prod.outlook.com (2603:10b6:208:57f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Tue, 15 Jul
 2025 17:08:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 17:08:40 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 15 Jul 2025 10:08:38 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Peter Zijlstra
 (Intel)" <peterz@infradead.org>
Message-ID: <68768b164f794_2ead100bb@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250715163340.00002ddc@huawei.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
 <20250711234932.671292-7-dan.j.williams@intel.com>
 <20250715163340.00002ddc@huawei.com>
Subject: Re: [PATCH v3 6/8] cxl/region: Move ready-to-probe state check to a
 helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 078f88b6-f953-4c61-00f2-08ddc3c23edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clFqejFDVnU5WGg2T05iN0lNWGtqSVQzSC9CNHB2dmtWTGQ1Y0N6UWNVUmxG?=
 =?utf-8?B?KytCeElPQWNQTEhvZWVHdml5bW9aSXNMWXBSbUxvTFhkdkNmdFp1ME5VVThI?=
 =?utf-8?B?MW5MR2RQbDkySXBRcWlKY0hiV3dTSVYvOU9DYlhuQk9zbmpUZExTakIwMEFH?=
 =?utf-8?B?YnNadVVpeVhlaHJYb1p6RVdKa0QvZmZqU3kzR25RcXRjLzE0QlIwZlpLZGE3?=
 =?utf-8?B?TkxsTy9NVTJtRDFET3pGeDB4SG9NRFpocVM1ZUdzTGFBUXl5Lzh5ZGNuWk4y?=
 =?utf-8?B?cDF6L1cyRTA1QSt5WE04SVluZjlsM3BaaHhkMzhPREE4UEhKZGtRaXByWEY1?=
 =?utf-8?B?Wm4yZTR0STlUTmk3Z3ZTTmhYeTNOaWU4RzhWbVRDTU0ybjFGRkIvNVJmdXFx?=
 =?utf-8?B?MVlsclBFK3RvRjkweFlCcndGb0xOM3NHcVRDYVNuRmxnUUpINEVLSmhsNmI4?=
 =?utf-8?B?NW5Bc1BDekZ5WlBhcndDN0lzeFFJMTIrckJHdXY2RHdES2s3UEltY2tSY1Qr?=
 =?utf-8?B?OEVTeTc1Rm8rRWtVMEUrWkN0KzJnOC96U1dIWTdJTE03bmJuSThjbnRSQzJj?=
 =?utf-8?B?eTlsZ1F1RWxvTVNxWmJoQmdiU1lNcThiQnYvK0lvbng2N01tQmRLa3pPeU5D?=
 =?utf-8?B?dG5XaVNyZFI0dTRYY3NlNTBpd3NIR3licEo5dWhmdDVNUnhvcW8xVDRLZlVS?=
 =?utf-8?B?U3NyNHVlUi9hZ3Rla0o1WGdmaFliOHZoSTRmUmEyT1pnVzM2QStHNDZKa2Rh?=
 =?utf-8?B?UzE1WERJMWtxL2d4SHVyL2I4YWljMVRsNUVnMVpUcVRkcFFCRkNjdkJETUZU?=
 =?utf-8?B?b2F6dnFqdlh6bGhPRlNCck9obDdRdnRDRnp1T3VjVlEvTWRGMFJkOTdyYlN6?=
 =?utf-8?B?dk92dXBTdnU1b1NvZ2Z2SWpxcFVwRXRsa21xWTZEUnJJdHN2SnhrWVc3dUR1?=
 =?utf-8?B?Yk9nTnBYR2hET0lEck8xQk1vTVdVMHZyRlRUdVBBOENrd1NHMUFhNzVoWSt2?=
 =?utf-8?B?WGpwSEkyaEkrYlptUUlHTU9QcWpqZmJmR3VsOWNhcTlrQnQrd3VGZ3JPUlJU?=
 =?utf-8?B?VVlKaDVpMHdsMjB3WGFjZ2dFUG5NODJyWEtjZDZwT3Q2clZ5SG5wRWpTNjNX?=
 =?utf-8?B?WWVGRVluaTBlc2lVZkxKNERrdVU1OUF5aGtiek96WFFxUWNiM1FDVndZcU9q?=
 =?utf-8?B?YlJvMmFvOHNoVWdCRWZGbU5NZlhvcDVGUFZYVUl6LzJ4NHByNmpqcVhaSHhV?=
 =?utf-8?B?ZWllWlhqYXk4YkF5M25UUEdIeVdRVTJuTWp4bDZpYjQ3R0VzalhoOUFUMHpw?=
 =?utf-8?B?eGFzTEtJalYvR3pyMHkxbk1iQUF4SEhKZ2JnMEZINk5FTTVvSUEzNlRGeXVM?=
 =?utf-8?B?NWNsUHg4TUFJakVaV3IwbkNLTWtGUndHWDZFTkFNa0h2ZjdDaTNKbXJWUkFH?=
 =?utf-8?B?K2NUdTFQZWVKL2xsMnRXc2c2ZERTZVRSWkZjdUE3cHVyNm5od2FDK1M5Y1ZW?=
 =?utf-8?B?MnV6aEJqUHFVN3RscnJxUm9IZGlEem1wK2V5SGdtVTluUExLbGZqdmVnTDA0?=
 =?utf-8?B?OC9YTlhwa3JCckkvci9ZKzM3OXpaM1MxVUNndkxMam9QUEhXaFl5YVovUHBB?=
 =?utf-8?B?dDRGYkdqaVVKOURKN3ZSdG42S2FpRlVCcXZIdEVlQTBWS1N5SXYrUkR4dHpR?=
 =?utf-8?B?dHZSemJGcFAvVUtrcHhUTVErbEVadkU0K2ZDeHQ1MnVVVklkeWxiQU9tdHFs?=
 =?utf-8?B?cmFwQVRPRUZWVElBRjBxWCtaNUc1Z1paeGdiQlY4Rko3MFZSK0FVbW1EZ1py?=
 =?utf-8?B?eEhqeU0rODhLcHFqK2xHd2hLeHZ0ZnUrMmtIUkU4bFdjeFRjR2ZWUXpjanEx?=
 =?utf-8?B?RWZWVDFzam11M0ZGbmttb3BSU0kweXpaYWk3TVk4NUpsdGFKeXZxMFJFTnBn?=
 =?utf-8?Q?9ectxx27+E8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFdkUnEvbHdSM2VVN0c1Mnd2RW4xZTVveWhRWVZZcjEvMTk5Qkppc2VDSDdL?=
 =?utf-8?B?Tm9OZ2J4NjFPS0VOMlpZNWJKZkhnSnBHei9GZ2tDZXdQSFlSVTFWeDh4aHBF?=
 =?utf-8?B?Q0xPSkR1U01UTXdQOVBySDJGVzN6dXpxbE9CVEhpU3lhTmZldk80UWlPZllv?=
 =?utf-8?B?dXBnNy9IU0l1ZG1ic1hKa0JwMzhmMTFQeUN5dUhyYytiK0JqMWV6T2J6T3g3?=
 =?utf-8?B?UXgyYmhTeGhVZjl2TUhLdldzQ1pJT2lUQVpYeW1UMDJMc1ZMaTdBNDZvYWhp?=
 =?utf-8?B?N1FJVFp1VnJCNXI2enBJbUJNYXJ0czBuYnc3VDIyZndoSythTnRrNm42VlNU?=
 =?utf-8?B?Z0hZa1QxVHhzYmdzUTVkcEpZNHVGRGJIUlBFTklEM0RtWlhKU01YWTU0OEs2?=
 =?utf-8?B?bEFrUU53MUUwdUlucVRJQnBoYk5ZTTFwKy9QOEN2Z2hWaEJaZ0xSMDJCdDVo?=
 =?utf-8?B?VmFvY1lsejBzbUlPaE5xNWE1Z1BvZDkzVjV2Rzl5bVN1S2pxZWsvdjFxWXRW?=
 =?utf-8?B?SS9QTlRQZDJCSlhjam5kcyttN2lJVXNIMFlJL241aE44bEhMUVcxcjZXYTZ4?=
 =?utf-8?B?c0ZsNGRubHI0a1ZSWXk4M29yZ0piMEpqYzVLQ0cwai85dkMrVFdTLzd1VkpO?=
 =?utf-8?B?eFhMU3ZEM2MwTmRHUzI2ckNXeCtnSGNvSWNCREx5em1TM1l6ZU5SeUZpK2c4?=
 =?utf-8?B?ZGt6UCs4NW9XbWZHaWZSOS92WjQ2L0J5eDhrR1c5Q3NqYVNRL2VveTZnanND?=
 =?utf-8?B?d0NQV1ROZ2dKVXFHdWJyZXFudDBwdWxUTnVKWXd0bm1XQ2JxbG5mUldKTUc0?=
 =?utf-8?B?ZkdhaWRVd3YvOUNQMFRzczYwQzh1NmVQTUdaOE5uaDd4b3Fsc0YvcTUwVUhq?=
 =?utf-8?B?WEw3Mno4YnIveFpMQlVYRWpHdTNGNU5MWjFLVDUrd0VETDRjTGQzREZudDdl?=
 =?utf-8?B?TEtHVnZ5WS9HMWl3LzhYK1Z3eG1CUk5hSEwzVDVQR2NFdzV1NGExbThLWUM4?=
 =?utf-8?B?eHpyQkN5QjVFbDhFY0FTR3E3RlpIdmVZU3BNZVozTG5aRjlCVmZVMzhOSVlo?=
 =?utf-8?B?QWNibFBvbXBVcDJKUEF0bVVhQlFpZnQ1QUtOVkQyVlBITEt0aHBkcmhKZ3VP?=
 =?utf-8?B?cGF6bVR2bnNsT0lLeWE4eUVWZWk0OGZNNFo2a3MxMlQ1bDVxS2cyTDN1bHA0?=
 =?utf-8?B?Y3QvT2dhWjByWlNSdnMyYlBWUldpRG85YndFbXl6Q09vOFVmOE1NT0VWV093?=
 =?utf-8?B?VkVWZW9sRUI3VHpYY2pRcjJqaG01aUh3OWN0ekErVjVxbkN5L0Z3YVlidkho?=
 =?utf-8?B?cnZsclcyMjNWS0tKYzM5V1M3Y1B0cFc5bVM3TFhybm9tMW00NTA5SVJ1NmUr?=
 =?utf-8?B?SDRiUzlLQjNTWFExSEJweGl1Z2x2akNJOE56V0o2UE0xeXh4L1VaNE5aMmpW?=
 =?utf-8?B?bW9pemxoTUsrR3BwVTUzc2MyUDJ6Z0oxcjUrVitEWEQ1Q091OEVyTUJsMGVT?=
 =?utf-8?B?bllCd1ArdkdIVmtkdDZSQ1V6TUpndzZBa1ptbUZrK2ppMkV5SDd0YWQ3Mkpj?=
 =?utf-8?B?eGhlUTBLbnpkYmorc091QkRhN1lpWU1OQll1QzdVMFpVZ2t2UG1JZzBLcGJu?=
 =?utf-8?B?akZDQmVGc25jakR3UXRCT0lMREt3dDFkb2w0bmgySU10RVdrMXhDSGQyS3Ny?=
 =?utf-8?B?bVlDd09oQXd6bzloYzhDVFJWZUMxZ3FEZVpJVUlRR21Xb3krR04vWE9kMEF0?=
 =?utf-8?B?eitBQ0Y5SzkxaVh2Vmc5YXFwcHRpUGUySHgvTXBZZ3E5RUk4ODRpTlMyNVF6?=
 =?utf-8?B?U2RrbkZ5UHNwYk5lUXJwTFkxWVFYVTBhN0phNjNMbUNtZjJDeXhOT3dhS0wz?=
 =?utf-8?B?aldtRklCWGdWU1picWhQNjMzL1lqOUxvaElhT0ZUenUxMmdkZmxIc2c2OS9Q?=
 =?utf-8?B?ejhBanV4QlpLMit0QmdEU20vYzVYZUZVYUM1MnIwYWxzRkEwM3NNckpuZnR0?=
 =?utf-8?B?eUtpTXJXcytMcFI0VTZSd1M2MmhUbHVLN2hYZ3NSajZ4NFJZSXZjZ0hmOHVC?=
 =?utf-8?B?MC9VczFnWmJUQlZrRGoyYjJLTWhUS3FJL3hsZjNVcDhkUHhuZ0lhVXEzYmt0?=
 =?utf-8?B?UGIwQ1BIT01jZ0xTakVZbG9qajRMNU5JSmc1alhnVE1GVUxOSWZOQjNvT1JT?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 078f88b6-f953-4c61-00f2-08ddc3c23edd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 17:08:40.3184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aP4TuzlgtrbbUM6rdgtARsQtPs9LkFo0CbZFuxpFZlE5nYZ92YlneP5HdqaNfl56y4TZ8aC1B2nCCnxIgIqs8nTNopbrXGrJMOeJhiArqOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9087
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 11 Jul 2025 16:49:30 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Rather than unlocking the region rwsem in the middle of cxl_region_probe()
> > create a helper for determining when the region is ready-to-probe.
> I'd maybe mention the odd bit of 
> if (rc)
> 	return rc;
> 
> return 0;
> 
> Will go away shortly. Or maybe that is overkill for a commit message.
> 
> Anyhow, with that in mind LGTM
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> 
> > 
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 3a77aec2c447..2a97fa9a394f 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -3572,9 +3572,8 @@ static void shutdown_notifiers(void *_cxlr)
> >  	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
> >  }
> >  
> > -static int cxl_region_probe(struct device *dev)
> > +static int cxl_region_can_probe(struct cxl_region *cxlr)
> >  {
> > -	struct cxl_region *cxlr = to_cxl_region(dev);
> >  	struct cxl_region_params *p = &cxlr->params;
> >  	int rc;
> >  
> > @@ -3597,15 +3596,28 @@ static int cxl_region_probe(struct device *dev)
> >  		goto out;
> >  	}
> >  
> > -	/*
> > -	 * From this point on any path that changes the region's state away from
> > -	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> > -	 */
> >  out:
> >  	up_read(&cxl_region_rwsem);
> >  
> >  	if (rc)
> >  		return rc;
> > +	return 0;
> 
> This is an odd bit of code now.  Why not just
> 
> 	return rc;
> 
> Ah. Patch 8 drops the if (rc) return rc bit.

It was an artifact of how it was developed. I am inclined to let it be
unless something else major comes up.
