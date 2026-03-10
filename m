Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413B231A07F;
	Tue, 10 Mar 2026 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167961; cv=fail; b=C09ir/GG5gJIiujkrcXS9xf+Ja+N5mqEaCOoq0vMzuvJiux8dY0AkMGPzekTe97oAA9nRlkHpop8bmz2hvAVxTwcoQTAp0nHi05D6TqUBf29AxtxkZnWhLOWMzPsjQRgqF5kWquDB3yhas4nwQ977LFe+negWSZORX5Gwyimcyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167961; c=relaxed/simple;
	bh=Sggy0gNGDqJ2cZTqw13XQ64IW184Wx2L/OTVwZYOGlk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Ibj1GxBws/a9TFFxIrRXz1Gub81Aw6h6FIEzwVB/eMXxDRyvaebCph+8JqhVqbL+ZsMw43oEiz4UOVeT9a2WIiSeboyhGQ+Kt1gWrKKsqwtYUNYV4csrSA1aznzAEpErRNuwevibnOeZGPGX2xSxfMs5ZbRi7uuHDJvSf2uWFp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LyWLL+0i; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LyWLL+0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773167961; x=1804703961;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Sggy0gNGDqJ2cZTqw13XQ64IW184Wx2L/OTVwZYOGlk=;
  b=LyWLL+0i4LKh2JTjm83/1D/xNbktcDmy0nkBZyHXNQea6lHU/7jGHGG0
   FxEjGrVonuNqkU0XxnMWOQ5o6ZuY/xs49yRQaIFhDnPEuEW053QnQxajG
   7WR4X7uPuSFtM6Hv8luz4JoZz7mC31fesRXKSszSjm2+Whf1cr+NqW/Zi
   NuWeHAEQIDx92a1Iey8MNgtC8SG9cS26USV5NfSi6VTB6SnEn7zpJ+/Zt
   bahb56O4aQBHjNbNnjlcpFi+aasivljkiHVE9AeZNYBGkIZZZ+oUC3Otl
   bXfazphmu1+aIe5B8XSpT+5c/6ltFUaLGJWaDj6Bt4uCtGG3F8WIKyPqg
   w==;
X-CSE-ConnectionGUID: vujlBv0kTV+qI9VVAxlVEQ==
X-CSE-MsgGUID: Ksp8FsV3SZGmHL2YUdK6iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="73926740"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="73926740"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 11:39:20 -0700
X-CSE-ConnectionGUID: gUKy/lx2Tz2AlqGN7nKzpA==
X-CSE-MsgGUID: 7Ux0eUoYQWmzEFChBwHKqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="222787694"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 11:39:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 11:39:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 11:39:17 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 11:39:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQrAV2GDtT/SZzbSvP7VMVSt3XZN+1oHbHM9F0+GaMHqSi7yOqZNQbEqRExV42VvDjSdpsOcciYHOlBQmyaZJkYyDLlisOJ2hyDZ5dWI2Nco2S6BXm+yPUkXUHTBm4cEVoz8P7qjNX4URdDifnVHX0BTjJ3/3tnVSQSOCvF9dWyaG0DybtsVN7gtwQUhA5n1oZFSWm/a1ygxF8L9q1ypl83qlRGXtJSTSZlCvjgXzJPAp6eCjg3Sr7ZU1Xwvqm1GJiXJz3LTU7SEmod1s9fvnwp1zWM2Me0YizODXtre9jmFm/HxFRwtNVMOErNDkWvxZFW/jgsDO2e2aykPABrXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0H/CYd3Tu3IqCNZ21ure89BiNSIacV3ps9C6pOjKLzk=;
 b=TaeRmXk6ye0J4/te7o/esNDCDuTT22YaFAA5T1XDKrPqT2T6o9Vopuj+ERVOjfQrsk26jn1yL1vSpQ2U+tJ9ydnWxBv/9aO0ixdKq0i2UIKRNr6pHdqqUUgdZLcfPO81Mmri3G/RFXvh68HYT6QHETcLT9bnXFlJHD2QSLpeSnraJ+EKLWGJgKXLfZO5nrn3Q18VTq+GfB2wyi83+bP7XSp9TiMarZ9ibUIGTgmYihWCqnx592CwWfusdLbKb5Kqb8jcRf1IhPwwyFTgvlRyTNmnrQfDPApjzDp0ti76mMtFPDjFtpp/mN43UKdmlUWai4KFPMIYcCsc9NHh+lTBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7034.namprd11.prod.outlook.com (2603:10b6:930:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 18:39:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 18:39:11 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Mar 2026 11:39:10 -0700
To: Dave Jiang <dave.jiang@intel.com>, Danilo Krummrich <dakr@kernel.org>
CC: Li Ming <ming.li@zohomail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, "Ben Cheatham" <benjamin.cheatham@amd.com>,
	<driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Message-ID: <69b0654e4ffd1_2132100ce@dwillia2-mobl4.notmuch>
In-Reply-To: <43577d8d-f95a-4964-abe5-3e0b7155e99a@intel.com>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-1-94fe919a0b87@zohomail.com>
 <127f99e8-f673-4cec-a573-be2257134f59@intel.com>
 <DGZAVHW9AW34.3UKJ8WV6QR8XI@kernel.org>
 <43577d8d-f95a-4964-abe5-3e0b7155e99a@intel.com>
Subject: Re: [PATCH 1/7] driver core: Add conditional guard support for
 device_lock()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: feae07b1-4255-4f50-0fdf-08de7ed45266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: sYIDuLUwLAVq0AnGzAJ2paxWDgkuSEhSUFwEMK64BUVNN6diuwsJZ2ZGCEDZlIkocaF8QKe10Dl77kqqHsmK9rQcVRx9++aPV1YYzgKovl75ZXZqaiB4vLsaoD1OC2tGHunG6NsIj7IWTMD0d7Hf3HTfJxiQC1k4NiLPcmPqN5fVFrljnxO9ZNIToyy/ehCMz0UaCo/POxB+PU8hPqeGQTfQ7G+ELWjdBoqNPaLiKrGrlF9vUBceVeiY5vMmwpEWQ1LzpUH5Klbc6Ua70AwNEiBsw1ODaoCmXK4YyHYJnBYzrgs4hH5CY5VeXKHnyLfQJBUGmRKMCLNlmTDu87E+9GLJweNBH4hB1iR1yHAxGjiHS+kDVEcpCYM0Go/0A2gHHCs2d8pH4iVd85vYeOIpNbOCa6ztP3Exc8BDO3vF8O1GGMIPNgoixuxpTk0qqsrD+Miwaqx9I9qKystXBpE/Z3b/Lf45MMv5VRG/3u6eFQrGESWwZkxt6bWoWT08IKFo0xMGvP3TMwk5SrCpLGXInVnUfQv4JUVsHTLgLz//gvFoQpomXBBmHZJZc1wejWjykd/ENHTWOfqG24R/QyEviFewlc4te0FC5XSeMKmhv6ll0hO92Q+4bOEnIkmQIAqEiYDMicX3r05IU5/mgxUc387lNZhwfW5WkQS/UgLWvhYEPFnprWfJCi+xM4WwIHC8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0NQN1FCanZ6L0hsZjZmN3dqem53UldCemhvZ2pmd1BJWHpHaUdiRjBkUkQ0?=
 =?utf-8?B?VGVrYkpRdmRIUEF1c2w4YmtpZkowc3ZNcDFpY1ZjdnhTenJMaWlTZHZBcTZi?=
 =?utf-8?B?c3JPcW8rZGgvT1lZcmJNRUF6bVlmQy93aWpIRkN1cUowejUvdDB5K2pXbnZm?=
 =?utf-8?B?STE2YkxWNUFxNWx0eWVMSHhhQ3RGd2RwWFF6RGtkQWxQd3NsSXpHdGc0NlVn?=
 =?utf-8?B?NmlIM0RUcWlFWUloYWlnaTJtb1pqWkh0di82UWdIOEh4b3lEU0hzN1I5c2ta?=
 =?utf-8?B?cU9uUnBNSlR5Uzhla2s3aFROSk56Z3dJNktKT2NqcmMvT1BSeWtwMVk4OWdt?=
 =?utf-8?B?cWhweEhwS3BsTXlRN1BOREM3YmdoeXo5c2tIdEZLL3BsZFRqejIyOHhjdXk1?=
 =?utf-8?B?TmQ0cFl0ZDJNUVFkZy8rc3kvaHliUFZ4VFFWdkVwWmN2NC9Yb25hc09KNjFK?=
 =?utf-8?B?SnE5b2Z5cXp0UXMrV3FLRXgxS25KWndSaFJrc1BYVWEwSFNhRUpsS1RHMDA1?=
 =?utf-8?B?UzV6NG5nMDNpajFwNklzOHdLbm5HSXNxRU1SUHpWY2Qwajl5RGlXb2UrKzhZ?=
 =?utf-8?B?dndScHVUOG1xUlV2K1lPZnh1YmJJa1BicmlORmRPOWt1TGRDM3NYU0lla005?=
 =?utf-8?B?SjU0d0ZUUGJVREhYSDFoa0F6UUZZeHlRMEFENDJnQlMydXZ5SjFGdHZuQlJ6?=
 =?utf-8?B?a05mY1FPMEtlbDlWaWhHRXVuNThnUWlBLzE3QUlZR3VITWxBSDAzQzhmUk5N?=
 =?utf-8?B?MXBBamVVUSs2VFFXZlVCN3BrYXhWT0VRT1dNdmo5T2RvQUhvcFNCaWc3bGNC?=
 =?utf-8?B?ZExYRnV0eVRUMTk0TWdRb3FlTGpvM2w4WWx0b1M1R0ZZZm50VFVGNlB2UHA5?=
 =?utf-8?B?UGdpOTlaUXYvZlMxWFpMcjZVa3hHTlY4d3pEKzFQeldWQUEwRUk4cVY1ck1m?=
 =?utf-8?B?aW5KY25jMnZOVGhkUUJEbVo3aEVLTURYa0xqaCtTU1F5NHVDMW5QUFhBVVJM?=
 =?utf-8?B?ZUJvWGg3R3pScFo2ZlBhaDhESFhoQ3V3ajVSVnVvdzkydFZCM1NPOHQyTWxI?=
 =?utf-8?B?Njc4Qit2cjlzdzlzUys0aThhTkU1Z1hpbTlKY3hJajFhWUozdXhqWUxRNTZO?=
 =?utf-8?B?K0RhSWxBbDJtdFY5Zm9rYzNiSDVuL3dUVzBGR2ZpNTZIQlAwbVJhUnJLVzlV?=
 =?utf-8?B?N1RIME1aazRlSGVmVG54THZNaU01QnpkVFhwMHA5elQwSHlPa1Zma2N6d0Ux?=
 =?utf-8?B?MEhZemJoSjBQdUR2L3I4UERyc25HOVFrRlRQR0JzdDRQOWZxa0hobVZjWWhY?=
 =?utf-8?B?UGloRExPYTRKbytMaFdYN3NsV3RPTUh5cGFjc0JENlFUU0F6TzFiWkhxcFJU?=
 =?utf-8?B?RDZYeDZuaGZUWTJ4d0NMd1dldktFVzBqUFAxUGdWeER4ZkZDR2MvbDExdWFv?=
 =?utf-8?B?Y0JubUpQaFNZVGltdnpxOER1M3BvcGRlV1ZGSHRDVVd3T2dBYURzNkFYQUpr?=
 =?utf-8?B?aldLZ2lCU3hPaHY5YXNlamNIQ3gwY09JQ3o5L1ArbUNpaXpRR3dtc2F1aGNr?=
 =?utf-8?B?U01QYllOUWw1Z3ljVDExNEI3RUFvZHVwczRpWStmSm4xeVQ2aFUrbDZMNkxP?=
 =?utf-8?B?OVplS0tJNGZRUHpXQ0QyY1lHWnd5U1hPaUg2K21rMjhEbzFuc29kbEdmUnJP?=
 =?utf-8?B?WDNsalVyS0FtcmpEdXI1Y2FGRHFnYkRhYVNUNVpDZGIxQkpUbFlleGNyM3lq?=
 =?utf-8?B?VHdWUU01Qnk1cEpQY2tKaGkyYkdFb1BKR2ZnU2dCOERMbFc2Z3BrOEtjZWph?=
 =?utf-8?B?bk1LQlRiaWhMR2MzVE0rM1ZhUnJPcVlxK21xaWpGRlNoc0x4OVh1NzF0dWJ4?=
 =?utf-8?B?Z1JHbkltckZNcFRHS003N01kOUVzRUtyV2JhcXkyQWFWMzVJY25RVVU0OUR4?=
 =?utf-8?B?MEpsSmpFMEJCdHNQbVNXaU8rbzFDTVJuM3ZYOEpaZHExQzYvdlNuY0l0cTVu?=
 =?utf-8?B?bU55bWY2Y0xNcDgrR0R5Nk5jQXpFbTg1WklnREM5YU43VmxBSDZWTGlwNTlp?=
 =?utf-8?B?eUl1Z09PelIyUGVwNmxZaDlYQWhSbEU0ZjJMVkpydWZKRnZyYmcwd1RRVC9U?=
 =?utf-8?B?U3RWc0tjc3I4WEdXVTQweUZMRUdiZlhEdDkrdHBWeStXQzR1TVlMRGZlaEsx?=
 =?utf-8?B?TGpCZ2pnMzdBODRndWcxSlZ1VnhTeTlsT2VzMG1Xc04wcGpDTHpEY0NSYW53?=
 =?utf-8?B?MFcyM09Zc2x5dThnWlIrVnNZS3p6YTNIQmVrMzZvZ0RMcXc5aU1SYW9MZGhG?=
 =?utf-8?B?WVBQVFNKT2llY3Rpenkyd3RDVEkwMHNZMFE3RXZZWFBQTyt2WWU5ZmZmc0tR?=
 =?utf-8?Q?tQTu1I/vLxJygykw=3D?=
X-Exchange-RoutingPolicyChecked: Tk5hMYUK5q2Pswo+gHpB13bXK8MSuUp7qFcWgYGrBC76o1zyzt0etAH/KpSlonOmuMSXA4B2Be5AUH2Nvg4eHEdTK+N7twHbzqouXJIcRUbYBwVJQ/Xxrd/0FctxUgGXQ4yQJ7M9Mw07LXXU7PTw66kyTgVFDP/C/UYJAVNHpuKHT6pL13xqUAQmhFr4iYkgNZV9Xz0EhsUVTdTaZNmL5KNhTfEpkQ+9Hi/rxvZkAAW/En8tqXbmwD1E47yaPCN/yS7gqZ95Dzp4yKsIhb0ZwCtloRykZCydF0jwPoKfG+RoKke5yEKQYCFobuEWjDFit8UgjbOMoVesaszFaybb7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: feae07b1-4255-4f50-0fdf-08de7ed45266
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 18:39:11.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBUubwC8q/TMULMCMngEcSa/E6x2qHz3o1k/hFmRnzk2jjc5+N3yC6ycK5P/0FO8m7FLPnQSNkw4yo6q5bkIJ+q2HCV2pP5hdd25CZlrXKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7034
X-OriginatorOrg: intel.com

Dave Jiang wrote:
[..]
> >>> diff --git a/include/linux/device.h b/include/linux/device.h
> >>> index 0be95294b6e6..4fafee80524b 100644
> >>> --- a/include/linux/device.h
> >>> +++ b/include/linux/device.h
> >>> @@ -911,6 +911,7 @@ static inline void device_unlock(struct device *dev)
> >>>  }
> >>>  
> >>>  DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
> >>> +DEFINE_GUARD_COND(device, _intr, device_lock_interruptible(_T), _RET == 0)
> >>
> >> Can you please just squash this small change to the same patch that is using it? Thanks!
> > 
> > Why? It is a single logical change and hence should be a separate patch, no?
> 
> For some reason I missed it's in linux/device.h. So sure ok. But
> typically I would like to see the usage if it's in the same
> sub-system.

I generally expect the same as well.

...however, when we get into multiple in flight patch sets wanting the
same API [1] it would be nice to have a stable commit id to share, Greg?

[1]: TEE I/O enabling also has a use case, and introduced the helper
with the "first" user.
http://lore.kernel.org/20260303000207.1836586-7-dan.j.williams@intel.com
