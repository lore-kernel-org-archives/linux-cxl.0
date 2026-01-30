Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F8333CEB9
	for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795147; cv=fail; b=djJpkP12OluO0LrERTKkO2OPE/YXFCnfIpFfh9sm1yADkTGzHnSsk+NZuamaSX30R+sXto0nBhwE0W9C2jbq2k3O+i2w+d0y0wl1b+3xx5nSRh/feV0B0whKt/NxzFBQa1gMMCGhJ8dvPlvgQD/1vtgFwPhOMJRpBu7Ehn12p3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795147; c=relaxed/simple;
	bh=ZyrClDElZcGmv0CI+V0GwFD5ysGRPqreFl2+xG47+uo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nLeyL9LbavBLG9hoOBUcStbguraQk7okWygR0KDH6mS7d/w2wxLmYqXZSwRbiwJAeJEUQFbGs5b34Ix/0UoZMFyPmegkPARA5saLEPaRwYmaQSHmPIqUm5VBYaBHIARMf5z+wPAQ4Y70r6blHB2iuolHFfYnacoMHHe92mqx7Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ek/B8vGN; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ek/B8vGN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769795146; x=1801331146;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ZyrClDElZcGmv0CI+V0GwFD5ysGRPqreFl2+xG47+uo=;
  b=ek/B8vGNNdDYmgvnT3tamghGGYaxaGWKs20CKLo4G5+bFN6bO7UI6SxJ
   /PJJXTiCtxyPGOxmfvzhVcGcQ94Z2R7k+9FBAoUKnsMbv4+Te2QuNvOW/
   R2qkiurupg5Qlu/CAEhTpCXNXz2UaDa9yX84at1H3c5yukNTqStBDKnng
   lQ7H346dw+5KFiYIeeR1Z3D/KVCSntsssKgtj/75jECieBqidqXKahaKS
   srAARVQrEqmRW0TUfe62WwBgA8mLciaJtxqP1ilzzbk4sEqWLvVrjT3Ek
   sK83F62bTZagfPEj/F+AwdP92ENYrFb1FyicBUbjZ9/KplT+zDFR66Y/c
   g==;
X-CSE-ConnectionGUID: HGAszp/jRbuSZKMIKpCOoQ==
X-CSE-MsgGUID: +AEd2eSKQTOzR0s6pY10CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="82159573"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="82159573"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 09:45:41 -0800
X-CSE-ConnectionGUID: yTnZhgkzSrOZZauwrmtJnQ==
X-CSE-MsgGUID: m+NfnLt8Q+WnI9dHOxnTBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="213851591"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 09:45:37 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 09:45:33 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 09:45:33 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 09:45:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkCYqGQdXHhs1OKe3GVk3boJdO4371jf2RhHMglBovhwm7Vb6+3VkwWPbZ8iYghckXGZhmVNgKk4GYqPvacdsteMiDkvOGulY33LnCjeMtBel4RWNVUiCZDlLoJtpIU2AcYFBhPQ+Ead+jUkNDxPjYGPhWBgpAjcagthyf0/kIXK9X56gOUpp0b+SXoVOsanDq31m/pVtGozx1+sCupweVqzKywkyZnrMVYXPspdsqKtVZInolyMjFgj08SIeN4+BzD2JKkTnGxwvtxaadiVsAG2WBmp7nuNLuQclJuXFdY5n0ZBRCkzpaj3B0YFrwpfPvnkh6e2h/UdW336HcN6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyrClDElZcGmv0CI+V0GwFD5ysGRPqreFl2+xG47+uo=;
 b=rrO+ikX0x8JtxHMHP0G46silEygDYJEJaBJfbEsgpwsh1dvvMP3AAxMGKe5hEJVRMjmKPlTlmeTDjWeslwSWZtcuv5XU5g9Khul5A7ERcT8EsozOkSzoiCqv2xi8Yra93WqJ6dmY/6KaOlYsdq1tx7Uh8kq/NkNKgrwgLPsalunBJfIiFSyw4BnO1nmmLa5BwtkdQZuVXFcfcgITVrsToQP+8uzKBagBMkk9a/iVfN+4/QNPOQAlhyURjexpJ2pE05VrdiQck5liXMMTvUU0TTqIyrjQkftM1uiQU4slU93NdFpMPEpj9r5bNNv8l8Ri6QV6Z/zq+3/LZUEuce0Y3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB9225.namprd11.prod.outlook.com (2603:10b6:208:570::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 17:45:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 17:45:31 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 30 Jan 2026 09:45:29 -0800
To: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Message-ID: <697cee39ed313_1d6f100bd@dwillia2-mobl4.notmuch>
In-Reply-To: <2a613604c0cdda6d9f838ae9b47ea6d936c5e4ce.1769746294.git.alison.schofield@intel.com>
References: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
 <2a613604c0cdda6d9f838ae9b47ea6d936c5e4ce.1769746294.git.alison.schofield@intel.com>
Subject: Re: [PATCH 2/2] cxl/region: Unregister auto-created region when
 assembly fails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0056.prod.exchangelabs.com (2603:10b6:a03:94::33)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: f3af38af-0d62-47f8-80da-08de60275cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2hVZ2xtcVJWUDdCeEZBb29OcUgyekV4cUpwdVdKY2tXakVKMHJHN3hzYTJT?=
 =?utf-8?B?M0ZmTnFqVjNIUHQ2QXpNNy9ZTUkxTSsvNjRGdC94OEh1ZFQrVCtFWDdnSXVw?=
 =?utf-8?B?MXMwVDkyNTd2SWIxY1h3U01zSTIwdVp4MVNZNUU0Ujk4d0o0Q01aRWcxWTNC?=
 =?utf-8?B?M29KWVlwSDdiV3puUGRBZFlTZnBhK2F5N0J2Nk5JRk1NdExqZlFIUDZORnNR?=
 =?utf-8?B?alI2cDdMUmt5Nyt5RER5RFVxbEVYbDMzLzhFMyt6SXlwbEczN2VzSFM0dUxY?=
 =?utf-8?B?eGJHb0hTb216WkR5ZWFXOXhrVE8yK2pmbTIwcDlRUU1ZSEduNjRCa3FOdDEx?=
 =?utf-8?B?V0NpTktMbnRGT0wwTkhIeXM2MVo5UEwxU3FBN0x4OFN6MGFlQVh1Zmt1MElT?=
 =?utf-8?B?cUMvUWkrMlh1VFlGWm01YktKL2pMRy9ld1JwT1c3TW93NlpmWklTR0ViNEtW?=
 =?utf-8?B?aDROeTV4WDNkVWJ0R3Z2Rm5uNmpxRldTWEZrQ012NHVYeVVkeWEyWjlQdkFW?=
 =?utf-8?B?c01mV0xLL3cvN0RuVmVVSEpvN21PdVRtK24ycys1RnFOM2g5d0ZHeWt0UVlO?=
 =?utf-8?B?L091MmlMcm1COEVPUXJUamhIaXlhMEIzRXJyNldCODZOcmloVWsxWXlQRWZL?=
 =?utf-8?B?YjBzZlpOVThFdWN4R0ljOVBkdVlVQ0UzK2pRRmoxb0plY2tHaFR5RjVDeGNp?=
 =?utf-8?B?T2FIREF0VjhaMmFidFZsa0cva0RLTWsycE91WEFnb3RZSXFUZEE0c0xVeDFl?=
 =?utf-8?B?emhwY05oR21uSkZIbERHbC8zdThBQmw2cldUdW16TGlxSHFmTWFhNWVqblRw?=
 =?utf-8?B?dnMvZlZsbktHcUtGd1o4QXRBeGU4Y2ZTWlJkdWNaMUNyTEFSQ2gwOFNJMEJL?=
 =?utf-8?B?K3dMWmlHdUpHVXh1UmJzYTNCNTc5MDdsMUt6em5KWFQ0cTVnTUhzejdyUHRH?=
 =?utf-8?B?V1RkNDYybzdnUUQ5Y0NkeFVXMElZTUlXRVdjampidmVWVTJHSFEzdDRYT1ZT?=
 =?utf-8?B?c0xCd2d0Slg3UmhEc1VvMDNKMEZmUnBQWUc4azRFK0tOV3hTUk5FN3czNHgv?=
 =?utf-8?B?MUNzOGZoc3pncENqbTJTUFBXdGhYcU8rTnZ0ZE1FdUdpTWdub2F2MFljakIy?=
 =?utf-8?B?cnZuY2h5ZlRzL3YxUENqUlg1bUdGUHVWZE1CKzI3SmlKNEhtUTRCL0Yxbi9l?=
 =?utf-8?B?Vm13VGdNbjZiU3pwdFZMbDlpZzNWaXNiOHlOWUVqNjM2cFNsVGMyY3M0UjRz?=
 =?utf-8?B?bTV4bjVjbEsxczVVejBTWVd6OEFWYnB5K1gwTGVEWTNNcGhBaGVibUloZmsw?=
 =?utf-8?B?RjdXOHhmOEphOGgraTk5c0RyQmR0QzVkbmlWWitWZTFKbWFOdVJXemRMemJ3?=
 =?utf-8?B?RTN2R25Sb3ppcER2LzFjNncvVmlwbi9GeFhiNFV5VE1ZdDNFTnhFRmU0SEFi?=
 =?utf-8?B?Tm95ekNBaG9hN1NtQlpTSmI3WFc3ZEkvYnVGeFRTdkpyWmU2Q1l0Miswa09l?=
 =?utf-8?B?YjJ3SXFZcWhURG50dDBIQWoyL3lJVTJNdENKZm1iRVZjV2owSEI2OUNYQTZS?=
 =?utf-8?B?dFkxSzNRZ29zbEg0cUhHQnQzL1RiQXZIKzE0bm00T1VRdUhidC9PVHdWclRu?=
 =?utf-8?B?aHFCeksrL1dXTnlxZHRrczlsajB6b0NFb3BvUkR3c2lhY3BhQXhxOGhKbXc4?=
 =?utf-8?B?U1l6N3oxNk9jWGZVMnBFVDIrOWN0VEZNNU44MTd6MFk2eGZjY1ovb2l0a3hC?=
 =?utf-8?B?TkpyNnhjVnA0eE1kMTRCRDRNVFJTaHVybENHRWVUcDJxUnh1THFiNnU5anE0?=
 =?utf-8?B?NThzT2RoYjBZeG41YmtmVlFubXdRYkdIeVEwZi9xUkxrZEdZdlYvM0lZYThL?=
 =?utf-8?B?a1pjNDhBMFJIK1RuWWg2RHZab1R1dDIzUkVCd2NQRGtMdnZsOE9yWlFzU2pX?=
 =?utf-8?B?em1xZDFhYWpEUENEdnJYOG5UWmswSTVObDZMQ3ZhN01JbG12bTFmUWlUdVgx?=
 =?utf-8?B?TzdTcThJT3FnSjg2cGovZmlrV2lDSUdpd2JtZ205YTUyRVU0NFdZSlBqcVA1?=
 =?utf-8?B?b0JUbFpiRGRFdlI0dVZ2VndwcFpMWlpnNmdKWk1SV0FaeTZnaVhLWlJLN05G?=
 =?utf-8?Q?zISQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXRBK0psSzlKdDRYV0l5RlVoREhWRHJ5SmQ4UUNORjFXN1FSbmM0WlFDUGor?=
 =?utf-8?B?SldmL3g3ZzBIbUJSSlZ4WklMZ3NnSEQ2TitZWWgzWFIwSWxlOEl0Z2VzeTdB?=
 =?utf-8?B?TUZNTVJuL0Z2WnRaWUF4bjMzZDBjTE9ZVlV2UVpsWkFYSlc3SHF3RGxYV1ZJ?=
 =?utf-8?B?RzkxQXBhREdDTnZSUTRhc3dVekZZMnE3QVd1b3I4UWxkd2ZLdFNrZ3ZYNk1z?=
 =?utf-8?B?OW1qZHFjRnU3MFBxVmFka24rcStVWk5xTUY5ZjRIL042bHlycjhiTURMa1dt?=
 =?utf-8?B?ZkFZNVJQejk5UzlYbndJOUxaTFNlbGVpZ1lKR0ZaTlV2R2xpeTNnVGdpRXNa?=
 =?utf-8?B?WVJYSlFxSkszSUtGVjlVWnFoK01nakc1WWxVN09xMm9YK3JkR0p1S0lDUzND?=
 =?utf-8?B?N3hmY29ONWo1c3V5QmNFUklFWThBc3FFYmM1c2wrKzdPR3ZQZHZ5NWNlbndp?=
 =?utf-8?B?TmplUWVSc2NzWUx3bWVEMFJicWpKL3VTeU5ZMS92eERiOVczQlBGV0ZidVlF?=
 =?utf-8?B?akNwRGFxeHVRZzcvSXF2dUdrR04ySXo5Vm0xTGRIMlRoL3R6ZVVOdDdaUU1a?=
 =?utf-8?B?OEdXcVRJWGZBa3pUNFp5OEVMSjE0TG8wNnBUMVhEaWJ1bU5jMm4waS9KVmpY?=
 =?utf-8?B?TEtrZXMzbkZaTm95Q21ESXB2UDZaa2FhZ3M2eDRqdWk1Z1RKVHBqQ29WVHhU?=
 =?utf-8?B?WW11NFVOSGRvbXc1clJFOTdpRXRwNHUxMTA5MnBlbU0zL1FtVkpuNm5IdC9u?=
 =?utf-8?B?TkNGc2ZtakdGQVBRVzZINUVqaUd6N01JWEpacHh2cm9TS1R0MEc3d2plVUZi?=
 =?utf-8?B?ODgzdG9PYTNBcUJuc2F0RGl2bytjMUpYTzRRL1ZNOURBYm9BWWVTN0lGaWJO?=
 =?utf-8?B?VjhRSHg5Q2J6M0xtOVJ4bWxLR3MvT0pxT3JkU3FLTEhlYzB2V21oakJKREFh?=
 =?utf-8?B?REZMdTQ2VWlYMjZ3RzdubFE4aENaM2xDZTlMQ2Q5YmFBM3hWM3d2eGZpdEl0?=
 =?utf-8?B?Y2JEcjNQS2tMM1lYQXVrZW5oMk44aEc5Szl3YXJGd204dFowakNWZlBqWXNa?=
 =?utf-8?B?OGh6U0lYS0lkY0ZqOVI2TE5wT3FrOTFNLzgvNGg0c24renJyL0hUR0xYdFNM?=
 =?utf-8?B?K1VlYVJPMmNPYTNnTHJBVDlvZ3hLQkxmZ3dqN2ZWNUFZZFNHOHNaMHFvUi90?=
 =?utf-8?B?b1pJQzJjUHVDT1dkMU9RYWdvWWZEVGx3Q1pLZVlqeFdOZkEzMmNFWTUvNDlV?=
 =?utf-8?B?ZWpWcEx4SHpvS2puZXd4d2lwVHRWMkRoNjFuRVFNMVFzcFpad0pKdU5wK1VF?=
 =?utf-8?B?VmQrMFVoMmI5VGNOMFhnMndacjkxVzNWTXJDbjVESXZQNDZ5aER0SjFVb3V3?=
 =?utf-8?B?TitxcW1ROHhhczFtSVU1QmI3Um93OUVwMHRmd0FwcXRkNDQyZUhoOWIydHU5?=
 =?utf-8?B?ei91eC9oL1JXTExoOGZmVHFrbnQ5ekU0b1M1RkNIOHk3NFo0VDNoejc1eG93?=
 =?utf-8?B?dCtCRDNGZHRpZ3UxbVExRExRSzBPK2p5ZElnSVFrRHJ0dnYrSnU5akF6Wmd0?=
 =?utf-8?B?RVZJS1ZOTGlHMXVsbkk3TmVOZUl5SHJ2MWpTRzZnWWxuTGNBc0NxT2tqbE1i?=
 =?utf-8?B?T0ZnUDU4VjhoQXRQM3N1NjdQUW96a2tndUlxaTBuQ2NaVHZXOTNrdzc0amxo?=
 =?utf-8?B?eVE2aldJbU9KenJ4OXA0WHpJSitYS3dlZWtxS1FpUEJra3VMaXlRYzR2QWUz?=
 =?utf-8?B?anJPUnl4cEV0UEl1dGN6WDlCMkJRdGVLMFBST2dWWjByY1I0Y3FvZ2hhejdC?=
 =?utf-8?B?SVU0SzhZLzc1U1JkcFhWVEdLRWw1aUpoMVFOSkxDRmFMSk9TbXdsMFE4Q1dO?=
 =?utf-8?B?eFhmby9PUU5iSCtZeTNQcHZEVVhOek1QT3V3b2h2dGJIK0d5aFRHN0kxNGI3?=
 =?utf-8?B?ZDdjVm41V0J5RjBydWw1T2c0cjE4NFpQOEZLblBSM2tJYk5qZzQ4UVNEaGtn?=
 =?utf-8?B?UjNVTGxHMU5UUEh0TSsxTlhSRFVTaEU1eTlyVklwMlpPbzBocWl1M1BnNkEv?=
 =?utf-8?B?U1UvRFBpbkswdEI4U0d3emhXK3RkZ2d0Y2RjTkU4TnF2YWdkV0g4a0JrYVpa?=
 =?utf-8?B?VisxKzBIVC9VSDNLUGVPL1YvVmVxWHlWVUNRK3czQ29XM0VNajBhTFp6YWgy?=
 =?utf-8?B?RjFxM1AyS3RyeXd4TXZKQy9BRE9rd2hWa2lmSDV1M2Vub3kzNHF6VkNiMU4w?=
 =?utf-8?B?d05UVDFwNHNuV3FLcXV3b1RvaFgzZVFXVW12R1RXMk5aVmxtakxidG96MVRP?=
 =?utf-8?B?ZysrdkkrWEI1RU5vNDdSTitISk53MHN2ZGQ4dDUramxsMjJOOFJ4cGNnaHJo?=
 =?utf-8?Q?dZj5bLdipWRu73ao=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3af38af-0d62-47f8-80da-08de60275cfd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:45:31.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qyUtMGvxecwTVJONCARclbsiMxQLK8ch5bvKy6/rdSNekL5Ns4p/WxSSQ9la1FlfdOljrzH3UjKx1F5BxHfv0bcy/ic3ETEUFamvL5OqUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9225
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> When auto-created region assembly fails the region remains registered
> but disabled.

Right, that is good forensics, administrator action is needed to figure
out what to do next.

> The region continues to reserve its memory resource, preventing DAX
> from registering the memory.

I would rather have the partially assemebled region to continue to
exist. It can help debug the expected catastrophic error reports from
DAX enabling access to a memory range that the CXL side can see has
completely failed (lost an interleave member). If the failure is more
benign and DAX side access is viable, then the forensics matter and
userspace can cleanup.
