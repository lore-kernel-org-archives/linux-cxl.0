Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FFC3203B0
	for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769817531; cv=fail; b=eQ60jLQnssD5HLuaGquahE3iYTTVW5vNTW7Hbp0m10ZM1MvMM4GTzumJjsPzAjEH8X3/I0kcMbkcSEUI+x7qjMSY0lIAW1QblDeaSXH6lZfxUTXQbRnhVJ0qsxf4+2kLe+zPTJtippE7UC/9JjyGekA+cp5nUVRPuSS055LP7M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769817531; c=relaxed/simple;
	bh=384z6oSaBEp7X+2rzKMkCQuBGCKd1Wo8Nkc2OUc2wIA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=RiKyoFvDXwUsEaVSN6I2F6LICnaWag3dFT3lel7e7LozK/C8JCLcQy9EUVwuVTgvCef+A9mIf1gbYMZcJ3AE74sIwPHRLYTPnSgEbH10KeQLVGk6iBOXe56zKTX5erlgxDRdCICf54SUpXCpc2bYIrhtbKmSwzBfZLzjYjXGlDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jxnpi/a9; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jxnpi/a9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769817529; x=1801353529;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=384z6oSaBEp7X+2rzKMkCQuBGCKd1Wo8Nkc2OUc2wIA=;
  b=Jxnpi/a9E82JiwUwed+0YhzwBCatLbl49JudGCU9vjiSyo/J0/264t+5
   IrLhMsOJsKOmCFkoRnFHd7JOI5HVMAT6PGQRkyqMf1Xt2DF5XkojqDnDm
   vbjSM3opmRFgPAe22Rv04q6OCIJjpF/gC6NwsP3vf+lZdtZTPOyR4jhzf
   DUvKqT/jxUYijK7Yzh/ZehBpeLQ/q0v44d7AFW1ivVO/TAzbcKfPQ2o2X
   E9qZ7sOtOIqXmq9Cefy+GU3ufS3Daqw1BydrK+bRnPmOhHa1bCuwE2T1G
   CSprOxSFxwMa0cFLJ/zyM5oH0rVIbpc6wnzcoQ+cI/5TykUSWx+W6AlDW
   A==;
X-CSE-ConnectionGUID: qBdGqkLCQL+PGezF/fzUjQ==
X-CSE-MsgGUID: IJMVJeoNTYOiqXX5gUY1Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="81389001"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="81389001"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 15:58:49 -0800
X-CSE-ConnectionGUID: c7gSlZelQtmFfhRok28fLA==
X-CSE-MsgGUID: YaJWc4L3Sem4GZcnObhhNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="209207829"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 15:58:48 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 15:58:48 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 15:58:48 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.67)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 15:58:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xa8VxRRNVYhO+YCCaa1JZjrG0Dua9aXY2D+stGy6DuTPv87Srv+nZiIePPHVY2PELWK8ypv8Roe1Z3WOycHie7qK8JnrFVcNqUK52H55yXIlU21dFt13I3j8VzU/BJJpBmZBZJ4HNwusLPe7ZNFTit0EfekH9j2lw5eqQzW8Ov02SJMdXRncpr37vwuouuRW9pu7v4veHxRaYFvyeGfcYzjOVWpfFu2Y2dVOvD3qmoavbZ0IOxEW2NYMddv3hXZAa6aH9jUpQkK0bAar4PJVzEyVxHKkDP2nuAQoTOxbrkveqbmIM+Ezgd1BmNZ9r8l/V+c2+8QompNdnAoK6awHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0TRf9s1xoikOYo8iKhk2Sq7NnKzHvy8GmsZfw1zBYs=;
 b=crUKRE+95NAU6hDV1ZnuTAXGh25jZSm/TcxfUMFLw198Bk4gHsmeaRyEWedWnmvqZDkQJo1ZKUpvdv10Eid57SOwc6co2i5ElR2z9c99fsWji28DSfOK1UEloTVsv0FuHQOHLWqVx3ZhxNs/O9Gbj9yjMPeLv/B1iegTOBioTKKdPSzVf4zkSNftwcuqofjRJ8ezxSGYT1Ds2yk16A+axV07zkVetv+lFE3jBdUABd4IxoKwk9ong579umkQrfW5AmiZRUeN7gYdy7Ut7PYE5GOW+9UR/tLt0ZRDizMX69ObcOZm9+ugCTeFXa2CHQr/HRbHw6jytEqWDqEST7PxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Fri, 30 Jan
 2026 23:58:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 23:58:40 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 30 Jan 2026 15:58:39 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Message-ID: <697d45af71787_1d331009@dwillia2-mobl4.notmuch>
In-Reply-To: <20260123121441.0000240b@huawei.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
 <20260122033330.1622168-4-dan.j.williams@intel.com>
 <20260122115945.000062e6@huawei.com>
 <69728bf84936_309510070@dwillia2-mobl4.notmuch>
 <20260123121441.0000240b@huawei.com>
Subject: Re: [PATCH 3/9] cxl/port: Cleanup dport removal with a devres group
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0061.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::38) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c39701b-6fc8-411e-e5e2-08de605b7e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2ticUYvbTdFQm85bFVqN0ROU2NOclI0MXd5aitpS2tTWElHMkNZYVpnU3pX?=
 =?utf-8?B?b0RTWVd4Nk9sWDlPdWlLbmVvNG9yNkt0bCsxNFhQeEZoNDdLOWxiZTcwNTdJ?=
 =?utf-8?B?UGZkNTBsenZ3OHEySkp3QjdpWG5ZQ2J3Wm82WnRBSWlGUXgvRVJTdXhod04x?=
 =?utf-8?B?VVJTa3poc1FTbGczaUJNKzhiOExUT2lYNWpmRnJadlptRVlPSWpXZXQzVzZU?=
 =?utf-8?B?S3NoWnhMMFRUVmh3eDZiVWtTd0ZUNDdMRzdVblBaeDVmckhmVkt5dHBxYXpK?=
 =?utf-8?B?Z2ljMWFtaVFLazdnLzBHcERQZk45YmNJOTI5dVVPMlgwN25iVU4ydVZ5bENQ?=
 =?utf-8?B?YWFrRTR1dUVLWTZiVGs5bU1obDlmRm05eURpbW04emV1eXc1UWpmQ1R3U0lR?=
 =?utf-8?B?aWNkL0kvREQ0REl0U0E3Rnl4Tm1IWkVBMGtMbEZIeVVXR1FibnN3TnFHbzF2?=
 =?utf-8?B?bFdEUDA2STZTRG11SGVjRWZZUkRFR1VJUm5weXZOWU8rLzM4RVFxNUNLeEVj?=
 =?utf-8?B?eUp1dWZWVXJQckdpOUVKODRaRmlWaGhPRWdvY0ZQQzQrY083VnFLU2Rma1p1?=
 =?utf-8?B?RWk5WGJmdE5yaHZpOW0zblpxTVhNUDhra2E4TTREb2RwU0FQemhvUlhBR2l2?=
 =?utf-8?B?YmlDeE1OVEZxUVJjSVc3UUJYeUEyT3hMeGVyUGJuZ1hnNXZSUXNDVUJFeXMr?=
 =?utf-8?B?b0ZZODVJeVk2dFdyaFhuZUViN1RLb3RTNWFET25oVDlZTVlCRXFrMjlMcEcx?=
 =?utf-8?B?cVhrMFpEeUNaV09rODVrdk56KzFMazIzTWdpQ1FVaHZzcjM0aVNyekZsZWdK?=
 =?utf-8?B?eWRQMmpMUWovaGkvN2YzM3h1Q1phQnp5aWdsYVhlR2pFYmZOcE1MdytGYURV?=
 =?utf-8?B?eUY3ZVRGUUwvVWxwRGg5b3hLM3V0d3BUVGptVHJSSlZaKzZSNmJoSUw1b3BB?=
 =?utf-8?B?L25HS3MvZmEwczZvNXEzcFpWU3NIbVFyeloxZTlTVHdoL09pTytQZTJXalNp?=
 =?utf-8?B?R3VTcEFBWVlvczdrNnZzS0hEQkw5WVBiTzltMDBvSnYvUUdFdzByYmVDQ0d0?=
 =?utf-8?B?ZWxORllnRVd2b2t2OUNtR2EvYThka2g4U0tkdjZtbGpsMGU5UElYNU5JK1Zr?=
 =?utf-8?B?K01pcGdiRFZFRy83U1cxWkk3d3VxTGM4YnNaRngrK1dqeHYxNVgyOVhRRFgx?=
 =?utf-8?B?bkV3ekRKN3ppZGU5a29CR29hL2dRS0tDU3hXNXZOTHUrbTRsSzNQVS82VStz?=
 =?utf-8?B?bzRxZWVsZUM5MTBHUDc4SVJXM1ZhcUJXSjZsSzBvd21vSEpGYk91WVVxY01Z?=
 =?utf-8?B?cUtEUWFKU3hBVlg1eGpmTS92NDllWGRxcHIzSzQ4Vnh4SE9rVjZWdEtTVVpu?=
 =?utf-8?B?NnBONlBCUVl3bW9EK3oxY2R4eVNpZFo3OW4xSldZNENUU0djTUFLMzh0bE5F?=
 =?utf-8?B?andTZGdIMmhYZUxsbU1zRlJqQVRhRDhuenkzcEJHZVJ2WU83UFYyQVR3TWU5?=
 =?utf-8?B?UGJzclpYMGloSDlJMW40TDlwNU10eDRFV0ZOMlF0WXl3RDRESVJZSHJKWHBt?=
 =?utf-8?B?OVNlNUJ2aEhsTFJVZjl6TzBkVnBOOXpMUnllemszSU5ZL2hQSlh2aDZWbDBK?=
 =?utf-8?B?dGRaSkViZ1o5eDlWNElKV1lLQjlQdHl5ZzlQSThNUGNudGRlcXZHd1NhSHhR?=
 =?utf-8?B?b2RjMmg4UmZjM1dPZXhiVUhwS20xNGp1UGt0cnRMUUtRZlNZQS9mb2ZJSWt2?=
 =?utf-8?B?TkNvdW5OWXZ5R3dSQzQxQ2dSVm10c1JGRzRwOXZ2cmc2ZnZyNk9yblcycHBw?=
 =?utf-8?B?MWc2ZU9oYURacVBaeDNya3I1S2x1cDFFNHBPdURDNmczVHBheHpOTG1DcFpw?=
 =?utf-8?B?VEdEbUNpUEhrR1ptWE1JeW42WllwZThvYndxc0tJbjdIbGFORGNOMDlneDRN?=
 =?utf-8?B?RVB4ODZiaFJWemsvVXEyQTlwd0dRSXlLZ3U3Q0IxMy9PcGViMGRKdXhKWlNW?=
 =?utf-8?B?NDA5WDB6dlJHRm96QmxSaXVYWTlnaCtvS2h1RjlnRSs1ckprMjJKZENqQVNj?=
 =?utf-8?B?N3lmbUFYV3FsRjQwYjI5MS9iODRydXRGSE1rS2swdDVXMHdOT0VBbWdoR2Nl?=
 =?utf-8?Q?X9UA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjF2MjgyaE9JTDZOUE9Gbk5LK25hU3h6a0NWS1k0YlZzcEJ3aW9wTlRvRlcz?=
 =?utf-8?B?aGFkWkxwVGxFYkNWTXZ1M3NaOUxxbGgrMktLbXpSaUhqUHp0WlRFMkRTd1ZZ?=
 =?utf-8?B?dFdEcEMzL1pBL3lPZk9GUnBwYksyNURNTUwwVnJwMExqYW90MUJ3QWpkZVdw?=
 =?utf-8?B?bjA1N3pBYWVRaTFSNWJFSHN1UWtLUlAyZ3FrajZQcGZXTUU5U3lLbmxTUmdu?=
 =?utf-8?B?T2xIM09XRnZMOFZiZW9UTGp3aFhlZ21YTkJkWlJmdElEOXBScjJNUzUxV1Ur?=
 =?utf-8?B?V293N0tKRHZjMEkyZUVHWERWd1lrOFNOYWNZbitOVXJKMmsxMExQUVBTTDV2?=
 =?utf-8?B?YVBFbEFrWkZlb2xGVXNiT25EQ29QUGR4YUFrTEhqRHdWSjJiOGlLYmtTSTh2?=
 =?utf-8?B?T0haaFVKUnFsQy9DNFFhNHhaOUxHT0Q1OGR0eWxBYkpJTHNOVXdUd1VOOHl1?=
 =?utf-8?B?Q1ZsOFNwKzNOY0VqMkt1bGNRMlowYWdqN3lFNmh6cmpHbHIyUUs2YW45SjhF?=
 =?utf-8?B?ZGRzNktQam95RDdRcXZzMWtDcTJZanpBV29BZ0NhKzhJbG5peW9VL1VMQ29J?=
 =?utf-8?B?TmFROG1QaE00S2J6Y3BCSU9oR21aYmgxUnU0SytmK21tYmNaTlNVMldrQU1q?=
 =?utf-8?B?VFluZ2ZWem55dmhUSklub0FaUUNIYWI4eEtiajdsdThhbnROMHpheDZKM1ZP?=
 =?utf-8?B?MGNPUzFxZERPRVRxcTYya2sza08zbWFHQTFSWUdheFpJZTBYNklsQnRhVDg0?=
 =?utf-8?B?b3AyaXFrcG5zTGozM3B2SGVnR3J6TWppeDV5ZDI1OG91OEFTZUJwTlBVUlpn?=
 =?utf-8?B?SnQzNE1oN2k1ZzU1WkNFZ2VUVXM1bXVZNzQrMTRCWlNqUjBTd0ZRMmhiaFRv?=
 =?utf-8?B?NEZuTFN3KzcxNGxLVFhKb0tvOE9GamxtWjJLblNpbUloVG83ekJKK2owMjhQ?=
 =?utf-8?B?SzJDbEdNbXRTdGVpYThsRWVjc1FFRW9zcDhoVjg3U09lNnlGWU1GUUJJUGty?=
 =?utf-8?B?SmE4d1llTTFwdlRNNng1ditCMUx3TWJBSCtzN0podms3b0VpYWNxL1BINXpk?=
 =?utf-8?B?dUprNnc3dGhqejZwQ1Y4RVZHQ2ZCVnRMWitLWS8velJuUGVkcjMwUG91M2Vr?=
 =?utf-8?B?VXJjYjdpWjBuZ0V5dzZLdHdDL0VIYmg2QzJqV1hRNjloVkcyYktuTWZvOVJQ?=
 =?utf-8?B?RnZTTUVPeklhM2lmeUliSXZwMzdweFlZcDdkRTZCY1lxWnhDYjk0cFpMVUhU?=
 =?utf-8?B?azNMZUc2ai95a2tSYXhORHlIWFd3V0gzU0ZNM2ZiYm1WTGNrcmxDZVlLdG1y?=
 =?utf-8?B?aGFDTVB4YlptWG0xNWZPS3BVbFVuTEorOVRwV2lNb2VyNndLL0RZRndCQlg3?=
 =?utf-8?B?Tk9IQnZlK0wwdzNKTU0xeXJ0emY4OXdtTmU5aFJ5MHNDYVIwNUhTZFIxaExG?=
 =?utf-8?B?cERqeWV6eG4yalBlZm5GQXBuRkNFTXF3S1ZlcmFQbkxHSzdFSGxmdGtXNmc1?=
 =?utf-8?B?L01pTEhoRXN2SjZTYVFEeEpqU3ZrRTc5cXBsY1V4ZDFTKzRrMWswbVlKcGw2?=
 =?utf-8?B?akh6dXhWVlFZK0VraXo3UVpveHkzWC80czlDNnJNUHFCMDJIcmZBOGtlNWxy?=
 =?utf-8?B?RlRkOGJjSmFMTVNEVmVkZDJ3ZUpheVRaT1A1OEVWWnMzUFlLOFM1clBjVkJY?=
 =?utf-8?B?MnRNVmhNdmZzTjhDVWNsbEtWY2wyRFJhZHNsbHRzbGRZMGZpVlk2SlZSMkVv?=
 =?utf-8?B?aHhFVEVWVTgrSm9rd0ZDc0VJU3JVVE8xeUx1QVJLYUE4Q0g4Q00yL3Q0Qkty?=
 =?utf-8?B?U0d1ZFpsQWlsSUpoRlVNMVN0VFBPeFFiS1B3eDdvcHBhSGRpR2VHNlV6L0s4?=
 =?utf-8?B?WWw2alFqVjE5UVF0T3FzdGdualB4VjdUT0l3cmRhMDhtOWd4NEttdXIxSmZX?=
 =?utf-8?B?dC9DMmxLUFFVT2wvTzJuWUZKeWpvYndwblFGcnc1MHByRk1wNGl2c2NMTVln?=
 =?utf-8?B?cW8wSUhqMHJlQW5SaWFhS0hqVVlvaEdTYTJqUDhGa0tSMkoySDJUNkRGc3lK?=
 =?utf-8?B?c0xTT1d5aXZJZ3ViQVZBbU1zTE5yZVg3aGNBeEZoVTJ5aFQweVVzNHJBRFMz?=
 =?utf-8?B?eEpjNURxUUZVRlJTM3MyVktvT0RJdkVJeVpXVktTN3o1eHp0VERNRmp3NFdZ?=
 =?utf-8?B?czFGRjB2Uk9vNzNtZWQzVVR4OHgvaUFiNGRuMWpaOEtOWEs4NHdlL2FOSXNJ?=
 =?utf-8?B?bGMyNWJzVVkvbmovZURqK0M0WUJJU1oyV1BuSUxWeTR0eTg1Uy8yMkRRMXpU?=
 =?utf-8?B?MnM2N1lZYnhQMitrMitXaXhjZHZHOGd0ZDVzNUY3Yk1IY3FWU0pnMmpNa2xQ?=
 =?utf-8?Q?Cu5H3aHcUUDnMuzc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c39701b-6fc8-411e-e5e2-08de605b7e11
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 23:58:40.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6U9kMFkYAdmcDcN6/PFZQxT7mveV/2UvWZNsoDIGF4o+ldA0Kay9dCTJocl4vl7wg2Ny3N4Gc05vrITpZkuu0k0EJZR7NaRkbfXJLGSFC4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6604
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 22 Jan 2026 12:43:36 -0800
> dan.j.williams@intel.com wrote:
> 
> > Jonathan Cameron wrote:
> > > On Wed, 21 Jan 2026 19:33:24 -0800
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >   
> > > > In preparation for adding more setup actions like RAS register mapping,
> > > > introduce a devres group to collect all the dport creation / registration
> > > > actions. This replaces the maintenance tedium of open coding several
> > > > devm_release_action() calls in del_dport().
> > > > 
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > > Whilst nice, there is some logic buried deep enough that it might surprise
> > > anyone trying to grasp flow in __devm_cxl_add_dport.
> > > 
> > > I like the cleanup.h stuff but here I'm wondering if it is appropriate.
> > > Maybe just use a goto in __devm_cxl_add_dport()
> > >   
> > 
> > It is several gotos, I have a hard time ever writing goto again.
> > 
> > Maybe if you can clarify your "inappropriate" feeling. To be clear I
> > have heard this from other maintainers that are not ready to let go of
> > goto, but I feel this is rapidly approaching the reverse-xmas-tree level
> > of local maintainer preferences.
> 
> I'm an enthusiast for the cleanup.h stuff. This was very much specific
> to this case. I thought I wrote more on this in original mail, but seems
> I deleted the comments before sending!  Sorry about that.
> 
> Main thing I was a bit dubious about in this very specific case was about
> overlapping semantic meaning of the group and the the dport (which are
> the same address, but we only pretend that in some paths).
> 
> That is necessary so there is 'one' thing for:
> 
> DEFINE_FREE(cxl_dport_release_group, void *,
> 	    if (_T) devres_release_group(dport_to_host(_T), _T))
> 
> Which is fine but then the meaning is broken out in
> static void cxl_dport_close_group(struct cxl_dport *dport, void *group)

It is a fair point, but not sure how to square it outside of the comment
in the one place that needs the alias. These things are separate, but
for the convenience of DEFINE_FREE(), aliasing the pointer saves a bunch
of other boilerplate.

> + I'd have preferred we were explicit in the group being temporary and
> hence passed NULL as ID which we can't do if group and dport need
> to be the same pointer.

This group is the one that needs a long lived ID. The port group is
temporary. It was not immediately clear to me that NULL could be used
for that ID given the need to also create the dport group, but that is a
potential follow-on cleanup.
