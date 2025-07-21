Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB322D785
	for <linux-cxl@vger.kernel.org>; Mon, 21 Jul 2025 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129538; cv=fail; b=mj7pTi3NUQgz+zwPRZETmMVsDrjvrs0r81BPI6tWNYksW7uTWqE0XPfB6Ou/8c/D5zkujbSULKjrmzFwXQ/s0oJG+WKRGADIFGEUJYn7OOWlTl08rz0XkHQl5EIaQPZmEoPJsAMTvF5XYERfMGgEXq7Uv7X7jXzauePSalnnk8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129538; c=relaxed/simple;
	bh=r0oMdN1UPHpmKaIXtw1Gap1Y97sn6/AyRDcvpnHTsFk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=G3SGhaJ4p0Xu+9E0Pd55Wd4n2U/1P1n81v6NjuWhR4ptW/lYjzbl60AqgINbPBF5AA0edxBDrsrZHyt/YxRAKZM+6fuBFfJxflydFF4uRJlbpuY5ECefB+1b3gNiNPeVo3KIsZTHr8FE3M6uxcUlbdCfRbsY+0AoQ7mjOoMwLyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/mOteHX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/mOteHX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753129537; x=1784665537;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=r0oMdN1UPHpmKaIXtw1Gap1Y97sn6/AyRDcvpnHTsFk=;
  b=C/mOteHXhXG7RmDL38dSP97HD4fT3OJ5RMqNcgm5SCzZXe1AVWfMEDcX
   n9S99e4CYoZF+WlOjeaQZ8nBWC3IU1FBvJhkCh82DJU6B4S3VJmXr5HNi
   S6nKauHViI4cKY7rWxfLBbtTXMnDxt/IfgsxNJura6KXcD7cvGX88tivs
   WOklRkmjYbcEzsQvtV58/pARRyjQjq35h50BtTHc86m3dUHAp4iP/N0BJ
   3AqHiUV20OROjx5w0M2Hvrm9B8NVFjsMA1WP0r4JVLvYUipMX5L/7mTgM
   cTCXEWpOA11Rb5WhPi4+VjMxfY9ZsTBocH/ocbRJcGU7s+ByQKIJLyQkk
   w==;
X-CSE-ConnectionGUID: AgNQC6/XRaSaPKoPbm4d2g==
X-CSE-MsgGUID: s6rQD7hISpOJ0zOAo9zo9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55449992"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="55449992"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 13:25:06 -0700
X-CSE-ConnectionGUID: 0UpMeIO3R66Q3t/RV3mhrQ==
X-CSE-MsgGUID: buLdQfR+T3y2Z7U8WJecXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="158235741"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 13:25:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 13:25:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 13:25:05 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 13:25:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkZ/M3gzZ+ktOy/XbKCiuhzvgz255wBjZh29Ig2rlV0HshJ7hYEDOd7NAKbYvQjzq9ja8Ix8wiofpXnZjVajIGKhydzxfPl3haGfre85tcWPIrQv5zO9APx/790QqrrqIv/Xrr8XMS4XFx0qWFUmb4JnDdVXTUk70ylEzb0hLXI/dptrDtOJtm1LkulFC1lC2xCY7U9mXQNLssBbnJns103FxAVI3JqAHnnQPh4kOEhzjq1a48M3+8zPxJPVlDf95tdHxf1+mmwQcqqG9xhvjK5e2Waq0Jd77FK27hK3l0dmLZjn/vFyRMlsNPJo17S936JuVr35kS1fDr+xAxSdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PgNBrF5bfogsBl97p5SdZuAsMiU9SsNbIAgKkQPCbc=;
 b=fzbourGYH7GgAtE9+tem18DEwD2wadLUDH5dPBzQg2CZndZFw3yt7GRe/cZZM0YJE7pxya/5OCDFjoQlMZ7iaBxtkuataHVhx63gTqp7YRUT23enGwVbDx4IDd/1+2JRbidukke2ckhWj0Mr3PbV54c927TcGVndNDCTTcACl8732GxG5XGangABbtr3nh00y4zZJCWb+ho6F5kYFm/WhuyGbc/gTiWMTcsIwLshy39dPsaBMxpH+wuAbwdy6tl3P9S6DBXkHCp+yA2s/Y7JfeNbn2mVWt5dSse7ZeoQVcPMRr/NgyQ4g/Cx8Uwr2B9N6QQug2xTchF5Ayp00bSLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6554.namprd11.prod.outlook.com (2603:10b6:510:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 20:24:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 20:24:35 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 21 Jul 2025 13:24:32 -0700
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>
Message-ID: <687ea2008a8f4_134cc710098@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250714223527.461147-4-dave.jiang@intel.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-4-dave.jiang@intel.com>
Subject: Re: [PATCH v7 03/10] cxl: Add helper to reap dport
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 74890ce1-4bcc-4126-bf00-08ddc8949ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGQvRGU0Vm5QSTVoMVZsTExOQkZ1VUVPaVg5ZXp5WVkwWWYzWUo5MnpwS3Jy?=
 =?utf-8?B?U3Qxb3FsUk9Dc3gxUDUvb1grYi9RQTR6Z2E2TjZRSmpqTCtTdDhVYnJtRTdZ?=
 =?utf-8?B?NS8rWGd5QTZhSXZJcnB5Z0xpYStuTHNDVVlkcGQ0emExWHNrODBCTVkrdlla?=
 =?utf-8?B?UVZJd0wrUWpWemVXOXBUN3NJVjhrdytaUUVicGFVRGx6NDFMb0NGU0NVT1Aw?=
 =?utf-8?B?c0tseEE1cTd6Smd0MFhsTFVtSldFT3JKcStFWS9kZExva0tJMG9wQXdLR0R1?=
 =?utf-8?B?aXV5UTRESnlKQVV2RGs0d1FnTmc3R0pvaXBaVWdPZkd0Uk1ldEh5ckhNYm9h?=
 =?utf-8?B?U0tENlEzclNBM0p2dk5aMGhTek9sOE1kNWd0V2NpbktmRXo4VHg5N3FMOTF0?=
 =?utf-8?B?UEJPNzdtbExOTE9HczZTOGgxUjZiTEMwRlI0aVF6cjdVbDFlYUFVVTBDSUNX?=
 =?utf-8?B?bnJyTHJ0QzNRVG9vMFpHM0VFOXhadmFYZHVtRjB1dkJaZ0lDSER0bi9WRFAv?=
 =?utf-8?B?QlAyN3ltNVc1QXcydjU4aTg4UUNyaXliNjYzWUtlTVMvdkVMSEFDMWxyU2lT?=
 =?utf-8?B?Z0N1YUFzNm52VWtJa1V3MTgxMVRzNGRud1htWkUyNzF3TmQrUmZIS1M3cnlY?=
 =?utf-8?B?amFlNzBhck5va0JHN0RmTHBTN1dRZWJHQWk5cUExWTBkMWRjS1QxSG85RjFz?=
 =?utf-8?B?bXRKeHBodHFaOE1aZU1qVU1YZTN4ekNVYlp3bm1UakVSYm8vWDJvQTVhMGpl?=
 =?utf-8?B?U1A1S2pkYlV0eFFoWFBQTW5LekZWcTNtRlM2V1ZpK21GbTJkZ0l1SUlVS3pN?=
 =?utf-8?B?TWxITVhudm5sWHp0YURsODQ3OTlKNVJjYWVOaTlwQzlqN2JkaVR4bjI2MDNu?=
 =?utf-8?B?YXEzc1l2VW9GL0REVnl3YWdob3AvRm9YcVE2bzM2OFFIOTJVdC9vRXhJMUtK?=
 =?utf-8?B?WjhmVGZZZGFZaThJb28wZHB2dDFQM09zVW1wcDhLZXRNSURudytqRnVIaTd4?=
 =?utf-8?B?dXZ6aUEwWUE4S090L2gvazN0Q1BndW9ZRzBzbHFXRDR3K2Urb0FvZ3pmeU1B?=
 =?utf-8?B?aGFhZ3I0bVpDTGFBMjNDZU5KcGF3Slk3Q1IzcmlvSmh5Y0ZXUU8zQjdldk4r?=
 =?utf-8?B?bXEvY0ViU2hzeDY0TUxmZ2xvYjJ5WTdjUzZ1djVoTEs0dHYwam9NWklnTnJl?=
 =?utf-8?B?NHFEVmZ1WVZoWWlXS281N21Mdm5OQU1MbDhKSEdXM2ZCQ1FUamdDRzR2T2dT?=
 =?utf-8?B?VFg0L2FRc2V1OWlpV2dTV201bVo0QUI2WXFSVmx2dGhlSHpYV2xhWjhOU3pS?=
 =?utf-8?B?NXh1SGhhRnI4djBNL09wS2J0eks1RWdXMjFUQkpMUloydFE4MTU4Zk1FcW9G?=
 =?utf-8?B?blE4VHRiVjBDQTRiWEZsZnpyamlObGlDVVBuRnhQR0JTOVhvT0NOMElnS3NP?=
 =?utf-8?B?L1grZk1DZ3VjMmwwbFJpTmQrQmVycGIrVGtIOTlsdjViYjVxVE12em1FRFJh?=
 =?utf-8?B?RnVGWVphRytWWW1jNVJDL3JUNFRBc1d2VnhqRi9qZ3A1V3pTa0FvVmxGMnFI?=
 =?utf-8?B?ZjZyYmNJYS8yOTg5QTQrUHF4T3BjSWE3dThJUVFWNnZPTGpzK25tNGRIYWhG?=
 =?utf-8?B?NkMwelBSbjI5RVVCNjR3eVczQWZSU3FWU2dPdkZacDEveXZYdytQMmFQZ2x0?=
 =?utf-8?B?WU04aEZrdTFtZHZHRXh6aVJVWDdnMC9JMUlZbUQ0VUxpQ203eGs2c2w1VUlI?=
 =?utf-8?B?N3VmbWVJRjRQLzZRZC9DSGpRTmFpRXJjMDFGUlY4OU1vbU9WL2l4ZkNRcVpw?=
 =?utf-8?B?ZXpsckV0ZDVZdlZrVklFRE9aUVlTeHBhV3ZUc0NIQ051d3A3TnJNalo4TkdV?=
 =?utf-8?B?M2sreXFjdE5uZHNMLzJlY3RjSGFTQkRwSHJBN2xKMTdXWVdmUnVXN2UxbVpj?=
 =?utf-8?Q?qMYcugw8dJ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VS9DRzdOUG9VQmJGRUFjWHpHVFk3RnQ5bUNRUGJ5ZlRJNXdjSk5KdmVWYy9X?=
 =?utf-8?B?d3M3eENVT0RnYkhEVnFyOU1vME9POFpXNHdGODBkWm1nVktMSnpOT1NnaUQ0?=
 =?utf-8?B?RG9KSlVETmRkYzU5SkRSRGd3a1Mwb3oyZWhzYXltc0dsc0swRG9lRHV4aEg5?=
 =?utf-8?B?MzQxNS9aVzg1ZnVqdUw5VXBKYjMwbHRmeGI3cFExd3Y2MDVYVUxDVmhjeTFG?=
 =?utf-8?B?dkF3aXVDVXluWHd6V3FLSWt1UHlnZWNMdUJ5S2pUdlVCMHhsOG8zYkVlVUFW?=
 =?utf-8?B?aEs2c0ZGQjEza00ydG93OTdQR0xxZjBKZjhLMW91MkZGcEJ2ZnFBcUpXRDk4?=
 =?utf-8?B?aGUrRDdKRUdxbWVIL1dZQkVwTzE0cWVQNVB3WlpUVVM0Rzh2bUhhNDRvbW91?=
 =?utf-8?B?YUxodFhCZ1J0NS83VEFxQWN0MWVXZ3VSQTR2Wk1IRXFlUWdhSVRIRFZ2eTZw?=
 =?utf-8?B?cHY5YnVmc0tkTnp6cE03MGliUUlmVXNDbUJockwrRHllaU1BRWtwSDBNSDlu?=
 =?utf-8?B?TDRFS0tScHBzb2E3UXhrWStuelB4WkNBL2E5R0JmMStBdlpWVU9WbGVqSTNk?=
 =?utf-8?B?dzZSTDZPOEZDbXc1dzhUSmhwaXVtMXBvVmx2Z0h1MHhYdklnVDA1Um5PRWs1?=
 =?utf-8?B?cm9rMHk4Y1g1Y3I0MWh6K0h1SDZDN0tKWE5EVVVhdFM3RTRDZDlKRG9NcFRJ?=
 =?utf-8?B?WmVyZ1BuWFBXMmVkdHliZW9UZWhHWCtKYVlnL25PMGVISkZ6Z1BCR2JjeG1z?=
 =?utf-8?B?L0phSWJjaVJuL2tidDRWQUdCVDVqNXRZa0NRRHhVRldTRHJyTkJmL1NpbTls?=
 =?utf-8?B?dG4rT1F6RnQwSGlzZWo5R0dDanlOTXk5WCtKd2F4VHFGeXFvd1dVMDBnWU9P?=
 =?utf-8?B?THBmb1NVcU5yRXdZK1hBZFBoOXpHelpVSS9uQ3JZOU9mUllDcUFFM0d1UURq?=
 =?utf-8?B?ZVBKSnVuSU5INTlwaDlwVHlORU5xcW1seHNuZ2NYaTk2MC9KSElRdm9mUXkx?=
 =?utf-8?B?ZW1jSUxWUGlxcSswWFpXZWZQZ2xUY0h3dUpOTzBsajNBajJNQVVEM1NycFEx?=
 =?utf-8?B?dURPRTdidjQ3TmdHcGE4Z0p1MjBTL2FhNTRXTDFwYzVXTDM0RkFHdVIwc1Vz?=
 =?utf-8?B?UUFidFBxbUw5MGR6eVhQNEtxVXIzQ3F4Z3NKckYzWHMvVlZMYlZ5bGlSaGhq?=
 =?utf-8?B?TXR4Y2NkLzNoV3hUbytVdWgrVHdkQ2c0UmQyVEF2UlJ0TmFKKzZsdWtaV3RI?=
 =?utf-8?B?WUUzNzV6SEx1dmJReFpXV3RHdEFGK1crTnlRTjBKY0hIZ2VQdmxMTG9GSVQy?=
 =?utf-8?B?dnlpNmUza054aFlzMW5iTEdYWXZEa1lnUkpyb2dtSWh3U0M0YUIwb0ZPYSt6?=
 =?utf-8?B?OUlKRVR5TFkwMGlpRjJ3U3BQUjI4NGVKWGFNTGYzbnUwdHJLSiszT2NTOHJX?=
 =?utf-8?B?NFJSQ1orNmZlclZoZEd2akl0M3R2cE1qb3JhYU5rbUJzemMyeWw0ZVVRa0tn?=
 =?utf-8?B?VEdVajZQcUxYY2kwSXRid2xnU1l4bDlMaFVOMFJvbFArQW1jVzNkOTFTUStt?=
 =?utf-8?B?MElxczRDbG5uM3V5MXRNcWNGaUFMS2FDUlVHYjBSeC9yZ1BNcFNzRUNPa3N2?=
 =?utf-8?B?U3VGdzBPM3RoTUNhcjN1NzN2b0x4N0lvckVFaWtvTmRuRVV3NjhTMTVsV01v?=
 =?utf-8?B?SWZ0cFhDMTJMUVpSWVp5VytLc29DTXZyWHZlTWpVZXZ2Q2NyZmkrT3JRcUxD?=
 =?utf-8?B?SXlwN0RsZWluNk9wTXJaTmtWenZXWFIzN0JtdFpzSi9EZklrSEpCM01VSTAv?=
 =?utf-8?B?NVJpcTlrYmV5TE8wMFloZTB4YzcrUG16QkM2YWo3eUVrN0tPZmczcFBmb0Y1?=
 =?utf-8?B?d1l0ZlR4Z0xuVmFqcjQ5a2ZkTEtiN3ZDZ3NnQ0lZajFlL01kaURUVlVSQ0Nr?=
 =?utf-8?B?RDZGNGIvLzNsUUV5dGVGNzdzaDYzV0lYUTZ0dmd2RE53cWd1VC9UTUNJZ3lF?=
 =?utf-8?B?cEJCUStXUnkyL2JZWXNKajlBOTE1VDM3RTBjbnozdmVDdXV4dDNVejNCTklU?=
 =?utf-8?B?ZW4zTWMvcWpieFd3RkpVMGZ4VzJxRXdWMjJjUlFaazJMZWoxUzNvSXI4eWJ0?=
 =?utf-8?B?Z3NicGRia3crMXI4dnBZU3JDa2wyMmpNc0FjZFNEemxZYmxiWmc0NzhwaEN0?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74890ce1-4bcc-4126-bf00-08ddc8949ba4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 20:24:34.9731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYz1Cy7iohCxzcYPpj7bq9BoVsOmiIu0lpcocRfjw2lko6YzwyAAIkto5+iSZwiH92TsoOf9ONyiWOPb+gqHb/8DE2hOCbVvrdlxwXwtW0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6554
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Refactor the code in reap_dports() out to provide a helper function that
> reaps a single dport. This will be used later in the cleanup path for
> allocating a dport.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>

Simple enough:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
