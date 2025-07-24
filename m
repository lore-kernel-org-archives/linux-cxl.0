Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F11DFE22
	for <linux-cxl@vger.kernel.org>; Thu, 24 Jul 2025 22:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753394921; cv=fail; b=Qyd+coyUOTr+yPNo86Kkp9BUswjnXGpFvlJuBYaPbIAwQG5BZtG0s9q7EIt0aC415/gIYFUxMy+tuchw+lexFenWMrRf1rCdaJotHk63HL7p3k+DJf+bK/fLuryT3kYZmKecA+wLx7LIM3jERcAYmzU09fL9X3bB+agki2V5mTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753394921; c=relaxed/simple;
	bh=6dhPkYBPoYz3fJ7mbb8ELzchccZC6I5vneC85gsyrTA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ng9//u/LRAAGUfIMKFL4Y5V/U6oSQgSXdJBuRi0zmgNptwmKAh4rzcVfxd5F6wiufRXM7tspMGi6G6Q/ZO8ej8WuLuKkg8phSJmFObJJoYmNvmxNFFZti4eL+MI1aB3Ae3NxYeKAykRw6yqs5IZnPYI4WpordalVRrFOyf18uGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jedko0L7; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jedko0L7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753394919; x=1784930919;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=6dhPkYBPoYz3fJ7mbb8ELzchccZC6I5vneC85gsyrTA=;
  b=Jedko0L7jp4EMp+ryvU/E8m0L1/OpQ04jvm+3q2VAMkEm6DeM6cKrORh
   MbLHBsyAicPz15ECZw783CwlQ9RlScruxaB2eE0ihMbFijYhGlcfhWQTr
   OBP+ux+rU/hzxLUDDQ5296YI/EyRYWJFo30iIAXYqMcdK3Bf/Rcm59arA
   P42Ymvsdn4pxkBr3OB7Gl/hBAqQQbjGIOo5JH/KDf6cYSYTGTqBsBCESe
   tF998ysNMjOSgOqgQVZEPYECgnZviUZjLk1rxemtAHEY7EWuo1UYbw8h/
   8NPRImjd9IiGzJYuRn3fpwCHXuPfKKCm4BsDkee6Jh9iSKS9Xi2HL5yR7
   Q==;
X-CSE-ConnectionGUID: ghNX0CX+Twau8O1b0HpLlg==
X-CSE-MsgGUID: 7JcECr18Q2qLeLcokhb/4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="65988540"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="65988540"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 15:08:39 -0700
X-CSE-ConnectionGUID: dluz7QyAR1Ozq6uinAPUXw==
X-CSE-MsgGUID: FaJsDv/iQUCRsyplFUgppw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="191409677"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 15:08:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 15:08:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 15:08:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.81)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 15:08:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ea1fmZyxn073rmCx/1ewEywqGMSQGBI62aK0D9HiAWeUYpMGcYdNdm9N5PFvWPQrFyW4RK77oKUV9owWShRr3AgIcjkCRWbKk009zH6h/2TPg+1hdOwjar1SeOPBX9GFjMwi4O/T1AaVZeGL0l7h68i5dynoBdUAui+NniOwhdk0BKCpAfbAN1YTWEnTJ5xHU3EeOvQegTx5VJeaby/wJe3uKvBfWn4TOoMa5HMVlsZAnfsRNe33+Uv/bkvLf463WOMvtZjRi/dZCr0ydjlvfKKhN+2kMCWk9m/eD2TwMJygsg3/hjlNdEUg8Xr/sJEs5moOQ+oN2xAZ87qsZVHQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZq8CM+CFdAPIBw4TFE1JBUjUrhxIwOzXBUcGta5jEc=;
 b=u9uDxxbBvj8sPPjjw5s9+34aySZnPFJkPmDWUp4hfCF06dAfI82qw88TZHJ5tKVmApIuPwTFQ4juqWeQFMZKk0pUH/q75fDfI2yt8HKMitHdtbNIV6V/jm08C1SJMiA7ptqh1aji2Wwofeuvodbp9IYgkDC0nYSym5Q3KfNDBsiVZZST/37Qq65PvpvjTpCiACFjwuw2BhFac+Cy/gc3rIwNKXXA54oerv0F21DaS/T9bv2zsRkkSrG1RFH7JjNE6c1ZwOpCLMsbCIlepQtNqT1n5eYxVHQPVOl59n7pExvdYmOAWQgm6V0KpnZbZsrwe/5zBHIwj7qtYqJ4AWC3ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by BL4PR11MB8871.namprd11.prod.outlook.com (2603:10b6:208:5a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 22:08:28 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%6]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 22:08:28 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 24 Jul 2025 15:08:24 -0700
To: Dave Jiang <dave.jiang@intel.com>, <dan.j.williams@intel.com>, "Bowman,
 Terry" <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, Robert Richter <rrichter@amd.com>
Message-ID: <6882aed88fa2d_134cc710024@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <d84c5b2a-5160-40a6-8cf9-066aeceda5a2@intel.com>
References: <20250721170415.285961-1-dave.jiang@intel.com>
 <12646336-9be3-4bc2-adf9-bfd59c589251@amd.com>
 <f1ddcc99-56d1-4887-ad91-714d59b9e9a3@intel.com>
 <400534e9-7763-4364-afb3-5ab9d11cde1c@amd.com>
 <baea9af7-d76e-4d17-9a7d-2363d4f6626b@intel.com>
 <68812fc03518d_14c35610053@dwillia2-xfh.jf.intel.com.notmuch>
 <d84c5b2a-5160-40a6-8cf9-066aeceda5a2@intel.com>
Subject: Re: [PATCH v2] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::19) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|BL4PR11MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4cfc4e-87f5-4c8a-efc7-08ddcafe9d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWlPc3JOb2RXd0NzbjVSd0ZlVG83OXh3MFlIWFhURDZFcnFqNGZMZVRJSkZq?=
 =?utf-8?B?c1hWcUd5QS91WWhZMngxaXM0QVpnSzVYelRDQldZa0VsVFE4U0NzWExCZllS?=
 =?utf-8?B?WjBjWHFJOThtK2hnWGFsRldxV2l5MU9yWVdoTktRM1NYUWRReDJTVzVvbWtP?=
 =?utf-8?B?UXIzYnczZHBaRFhJbjJlU0JwTnVaNGt3THh2TEY0S1ZmVEZEQmV6Y0FxYlFh?=
 =?utf-8?B?T1lzbVcrSGd3em1xblozYnlPeTNFU0NUbGh1MTlrQ1RjU2RIeVlJdGViTG5P?=
 =?utf-8?B?ZEUwZ2Uwc3VEWGNuTlYyUGNPUTBSaHNpTHc1MGJOOWNqTFpRNWN6ZDg1dUxN?=
 =?utf-8?B?S2YwSHBlcTA5bFRsODJBKzlrRzhwMFFXQzU0SmNaV3BpYTBkVHV5aUYzTkJZ?=
 =?utf-8?B?SEFPSHNLbXJVOFhLaWxnT25zWWEzTUorMlQxbU5kekxiUHZuNWNhU29TK1Nq?=
 =?utf-8?B?T1dkQkFIaU1ERmFkMERKMVpXRXdEVlFnRERQbGNQY20zc0tEOFdEZDkwWnhH?=
 =?utf-8?B?bkRXc1gyN2Uyc3lTV3pld3hnWEFaQ0o2NEFEUnZVSWZFaUJ1RU9COHVrMk5C?=
 =?utf-8?B?eHdKa2VBSnRCZmtxUzZtcHN2ZDZFK2c3N0J1Z2pDNFNacGlyVzRJeVhiWlY4?=
 =?utf-8?B?Q1VSL1B3NFFXRVJobWs0YWJJaWozWTlMc0lIamNHVXBjNmNUTjlnV3E0NkVx?=
 =?utf-8?B?NHl5UkM5OFdLM014MUFDVjNzRDNQeTFrSHVMaUtHNUZVWjRuOGl2OGl2MDlt?=
 =?utf-8?B?QUlNb1Z5YjNIZTNPcjJOa01nenh3aXNvME05MElITVJBakZ4SjhKMTd6Wmti?=
 =?utf-8?B?bDlaNjZFbDdJVVU3YXpjZXptNExscS85b2VkTS9rMzZwZ29EQXR0VEJqUDFj?=
 =?utf-8?B?MW5NbzZoYWovQmtvTzNGUy82Rk9xSUo5dlBQY29yUHc0L0NtMDlPQk15MFZY?=
 =?utf-8?B?UjJBNitza1dPT2d2M0EwQmwyU0FBZnhQZlNSZ0hqOENvdjhHUmtNVkNjQkZr?=
 =?utf-8?B?c1NlR3h3bnM5TzluTkN1bEs4OXhFV0Y4dFhNUzhxR2VnYmxKQXpDZXNCNDky?=
 =?utf-8?B?WHZ2c0YrdXRldkZ1UW9yV3BnZUZOYzA1UFBVN2dobEhtaUJ1VHVaUnIxRzB5?=
 =?utf-8?B?UmxuOVFUWXlBS2ZkMFhZWUExQmJjMnU5VXlOSmQ4WEY4WHRESEYybXcxWDZD?=
 =?utf-8?B?M0drN0htMXkxazRNcCt0MjZUdENCUWptMVREblRSbWErUFRYYmNLUzh6Q284?=
 =?utf-8?B?RU1hUW9sNzNSQnlMbjhHRmpRWDgyaVMzUFFiUFdIbnZpSXd5T1oxNDFpL1pN?=
 =?utf-8?B?QW1SVDg1alg3NFdSak5vUkxyYjVYSS9nV2hOUWZrd3RML3E0Q0dwdnNlVHQv?=
 =?utf-8?B?SFZQRCtMK21vRTJjRFlsTFVhSmtIWFBCcTUwQkFXeTVxcFFaOTRsUzVaWjhB?=
 =?utf-8?B?SmMzNnlidHQzZndMRUxjZUF2U0tUc0lpRFgzRGt4ZnRJalVJaGRzeFVXTDFv?=
 =?utf-8?B?eEhlaDNMNy9nYmo2V0w2Ujlhd2Y3WDNDbDFNVVNQVnUza3FrM3JxVjlRL1Ft?=
 =?utf-8?B?RmdjeDFMWHlPUjZmTThHS1gwNE4zZFA3RUhUYkRMV2dpWHhJRHNpQldibVFW?=
 =?utf-8?B?MlNVZHZwc0MvWEtiR3Y5czI0djNQWDByYkpxbk9zaU81dmFPM3hRZnZ5N0Rx?=
 =?utf-8?B?ZnhLcGhsZFJTSGZLNlZEYUVUVnlBY1hRbUpZOHVkMlllbDNERUhiU2lUV2Nq?=
 =?utf-8?B?aW5oKzZZVXJJNVJQdGNjVUx1WXN2RjhMd3BlYnNzZnkwbURSV1UwWXFabWkv?=
 =?utf-8?B?b0xQSXd3NzNGcWRyejd3OHFxRDJpZWlOQXZiWnRGdmwzY1dvQjFOdEdOLy9K?=
 =?utf-8?B?YXJVdTZTb05xU01GbUtZK2xxTTF3UGJaVkdjOUFRbFZyc0pEMW8yVkJWd1Bu?=
 =?utf-8?Q?Z+AaJgWY4Y0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2dQMTloWXBZZXhmanRvOGVJcDJjdDNMWG5paElEWlZXcTZpTVdDc040Tkll?=
 =?utf-8?B?VjYxaWNYUXdid1hUNGNYbXdNNC9RSWo0by9NMWlBLzhFSUM4RFU4L2F2ZmpO?=
 =?utf-8?B?eDhUTnkxU081enRIdkw2MFRJcCs2ak1lRkt3NFZBY2NQZUxrNTEwNVlRRFRy?=
 =?utf-8?B?T0hwTWF4a1NWMGR1bzR0OW5kL2ZFcGwwVEJXanpUa2prRVdpNGZWeUJ0S01C?=
 =?utf-8?B?akt1T3d1TW9LTWpDcU5XT1BwZWMvMUhXMzBGUjVlWHJhNDVGeEpoemMydkhM?=
 =?utf-8?B?UVQ5QjBibVZXMEUyYWloQlFGc3RrTlBNcW82RFBPTCtpQTdrQ25uM244N0hJ?=
 =?utf-8?B?dERLZkxOdnUxQUkreE04TXRaOFBYbGg5cGpnd3hBZ2E0cEtyRW84QURuYjVw?=
 =?utf-8?B?UnY2Wnd5SXJrZ3llVzdkcUdhRTdubWJWRHdKQ2RadWZMV3J3TForVnNMRzRD?=
 =?utf-8?B?T3d6VkhIM3NXRlZ0MFF6Z0ZGMGZQTGtYNEh6Z3h5MFAzVGVyNTZEeklPNDFt?=
 =?utf-8?B?aXo3VkgzS2MzTFlJaC91cEMzUDVnaWsyaTlqNm1qT2F2U2lDTzQwVmhFSlNn?=
 =?utf-8?B?Wm1jbTMvNzNqVjVYRXhqK08xQTN1UDhQcVFLVGh2dkVWZFR3NDNVbVJDWHY4?=
 =?utf-8?B?cStiUEdVRGM1TTRicDcxRU5meWpTZVJRWWU5RjBFRmFrQTJBQkdLZG12eHdt?=
 =?utf-8?B?T3BWWTloREJVZUMwOWpDVjlGSXNlL0Z0b0ZYSVA4OTFsZVhmZUVjdjVBQzI0?=
 =?utf-8?B?TUVwaDNtK1lUS1B1anpHSnhJclJXQmcyREJ0ZjR5V1d4Z3NrRVozUmpQMmpJ?=
 =?utf-8?B?SUF1Ylk5Yys0Nlc0VElEM2hpSFNDelhYa2dHWnJYaThEMnJpMlJzQnE4a3NV?=
 =?utf-8?B?a2hLeHFSNk5yOUYrOWFBdnExV2xNVEJFSHpxalA3NjlvT3VGUjl6cEFCQlZ0?=
 =?utf-8?B?dmNCZG9mUm9tSkZDZGlXTkowY3hxalQ1NEF3YVR3QkdwYUY1MzRxeDZtU0Fn?=
 =?utf-8?B?ZHJ6eDFtOWNtSksxK1I4L0ZwcE5yVVVVM0RsTktNbk1kQWtGM3poWDgxWmwr?=
 =?utf-8?B?aUc5Q3NNL3Z4MWJQcUY3aThsTmVVUzZTVSs0WG9kSlE0N2NiaVVnYzJQbnQz?=
 =?utf-8?B?QUxXcHFVKzFUaG9yMmxmQVdZbWw0UnpTYmJLcXp0Z281QlFoUzlNUW9VTGRK?=
 =?utf-8?B?KzBoMitjM0hJSVZCWXRFekRUdXZUd09LbE9NaUsvcnk3cDhJeU5mTjl2OUdM?=
 =?utf-8?B?RndWVUVYcURCeEZMNHhicnNOczByR29zN29Gb3pJalFsRDBReTROSmY4RVk1?=
 =?utf-8?B?UlAwKzRURktPRU1BZzRSMXJpbDdwUXA2ajZsOVdpNzJ5MDNYU3VOYjY5NE9U?=
 =?utf-8?B?WVA3YzlnWGZCVmZEb3c1dzlmSkVSMURMTm9ycERuWHJVaVNjMmpmYXNhVzdD?=
 =?utf-8?B?bStQWFJhakJUN3dTRmFTM2p6aHhRMUlhR1BHMDlsdDNXZGpZZ0hzRzJCbVRB?=
 =?utf-8?B?eElVOVRGSzIvQXhLcTR1c3VqdFI2RmR0OHNFaW1DaWQrKy9wVEZQMlM2elNy?=
 =?utf-8?B?b1hZcDY5VC9LUHVlUkszdE8zN0dWT0k1aE43TDZYZFBTdHBzUHArajhtOUpp?=
 =?utf-8?B?K2lPVHdXc0V2VEVkUzYyR0hmNjZWVFgwNXl2bGloWTZyQ3NucnhMT0laWlR6?=
 =?utf-8?B?UDEwSWMzTmVIa1NsL0d3alJPQzl4dUdUc0RFMGgzeHBBOGEzUDBnY0lYQXJr?=
 =?utf-8?B?MnJNQ2Jtd0I3THhZUVlqVEJrNzBXTWNPZkRaRFNnYVplalZoZ2JYVk8vaS96?=
 =?utf-8?B?b0VlYlVhSngyRXBmRzB4SXBsNmJLeFZBYW1JTEhyejlvMGFjUDRyL204NTI0?=
 =?utf-8?B?SHRWaGczREg1Uk1CNUdKZVAxaTlDQ1N5d1JOTTVvTXYrU3cxalhzTE1oakVZ?=
 =?utf-8?B?K0F3VjRIV2RIckx2Zi9aOVJtaVNnakk2VTRBM0l6VGl6RnNhUVBtamIzRGM0?=
 =?utf-8?B?OGhjcWoxVjgyYVpFVWdOZklOeTJaU1NBU1cxRm9NZG8xUjRWUC9TQlNUcDVi?=
 =?utf-8?B?WGlrTjBGT2lweTBBTU5ETExJN256ODdEa1ZGRXFTcllHWWRONGNycGlCV01V?=
 =?utf-8?B?SjFDd001dFVOZWRYdkdXcVZiS2dkVUplYkdZWDhqaG5MNzVtTUhqRCtkQ1px?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4cfc4e-87f5-4c8a-efc7-08ddcafe9d51
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 22:08:28.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHqfxEpWUVhafy36+8YTHpHvmhUgqKG4+f10lPhGopBr+ZQlXEnL8MiiJvmY+ptnFEIENTV1jCGsyVHkgha71KGpcCJPkzdeHpIak5MUKu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8871
X-OriginatorOrg: intel.com

Dave Jiang wrote:
[..]
> > Between RAS, AER, and EDAC there is significant overlap. You could say
> > that pci_ras.c is also misnamed because the error details being reported
> > are CXL not PCI. I am ok with "RAS" for anything that handles decorating
> > an AER notification with extra information, and "EDAC" for all the other
> > error notification / reporting / and management flows that handled
> > separately from AER.
> 
> I wonder if we should rename ras.c to cper.c and move the new code to ras.c.... or cxl_ras.c.

In the protocol error thread my ask was to just colocate all this error
handling code in ras.c [1]. No real value I can see to do fine grained
separation of these concerns. CPER notifications will eventually want to
trigger a cxl_port walk, so keep it all together unless someone can
point to a good reason to split them up.

[1]: http://lore.kernel.org/68829db3d3e63_134cc710080@dwillia2-xfh.jf.intel.com.notmuch
