Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1BD26980F
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111943; cv=fail; b=I5IHV5dQU4+35w/ZeJtiQkAVLfVb2GxFhZ2S56Syz5XYNo1FKxXnfYO3QommDgcOlwTm2dL3SmNPRl6IFscvPh90mJJKqRvpYfIWVKDfTNZa+q975QJ/I51fAkNWaCTEsKYvhsNoD6AY0ofnBFeq67Ii6TDIqDxHpswjpixyQEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111943; c=relaxed/simple;
	bh=pxtATdaXle2YHJvUdg3Fjm7XFdNsyAsUgAw2P47VhKk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=mOmHxaZ/cYuF6juMV7qO3qi4q6ORpGTCNVKBv/mMMRUmRAmYmvYM0WK4XS1bXkN4U1U7S/6eZW6XoBiI9Z8WyvRbvpyzpYV5rtQzPuBtGLdH4EK5T3DO2YV5Lf9+otYMmf3eCk2yTxUrSSRS+FqqMAYrqq8I+Ap4OVMV3MBaMpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtViYF6h; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtViYF6h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769111942; x=1800647942;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=pxtATdaXle2YHJvUdg3Fjm7XFdNsyAsUgAw2P47VhKk=;
  b=LtViYF6hdAlAC43xrZxIDD8yMXIbFKOiayH0nEbNbkADVKT4WYDGrrtX
   +uIOGCcDrr42P3dhZvY7zZnvZJ8C8Aesb+PIgVkalvtvvh7T5aoakCemS
   WAyiCAqHYUeCHgaGLJ7tzByQcB+LTtT4ZvNR3AMyu8UR+2qtYrJ3voKLH
   HUJg1r8+A2vCkLas3Kj7R4yBUZb9GhBw/I2R/HFcMypgp8xNSHGrDzsH9
   0AemV5DsnBSRFvKCCs9TXBMVE0iA3aJS+CdKY17ff/BOgoHIe5iZj/JFh
   5CN+xi1l1krU3d75PcrvvxZ2m1m1C77a5gHIGuciIW130JwJP6L1Vj+TB
   A==;
X-CSE-ConnectionGUID: 8Z3FdH3PQuC9IO+8h041Qw==
X-CSE-MsgGUID: 60xJ70YwQU6MoQgJEQ427Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70264789"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70264789"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 11:59:01 -0800
X-CSE-ConnectionGUID: DH6fW9YaRQWq+1EV31PhqA==
X-CSE-MsgGUID: d2bpXJnLQSSyMQGxkSdV6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="229790025"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 11:59:01 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 11:59:00 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 11:59:00 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 11:58:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIiAWMfa5gG+jAdakSmgb4w/rggepLf7xAqziRYe80iIp3wUbJka0esWfjXNXRRZ03qh4Fax4oItxWkQjw1ghqLpaEVsZLxhtEyWGoCwWhmoWiKdfOEDLmtWww24+QWg65CRhjZkOKWfeZNHc93kz3aTjh1zT7M6ff6AEwcq/K8gyipoaifrNBmxZVcUmVhlMo65AMpniHrf5plVHsojhrbtbhEjBftyLuSPpDRFe8ZM5O3U//clvqJ5CVaEvgTWYZ7ntneSw3ykVm8D7vZPS7bGC5dJj0XZFQBE5Lz7ZK16fVJBd5nMcffOLXJfKax3EA8T9Ico2xokrdgqrXGSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWnthSOnkTjAJSdfSECdqrK1SM4jfJJrl+dhpeHeZCI=;
 b=Y9lHOc4lLlS2Or2q7MwW8pSGQFZb+iuWVxwhJzdHN7feyxflkrWrtMXzr8xp/zXqnk4Jdbs9PymK7dzIolKfkl/PxBojXxixo38/V/X4+IWRCXkdY+keoNa03j20UGKlcjqICBTslC2JB05OnmxWHvOyaTC/q98Er7Mp++kmCK6kTlZzIWyiyFx2UruWKJyRkq8o+fakTJ4JTl8ue4L1Ru0zc4N/onrT9bSYR9g1Fs3G4c3Qq6hACS/Y+X0r6niazzvzETCW6iFWF9vAmrykBYJZYXIirk7qPi1VwnvXvG1kgQwyacrhR4BMea3tlGKfUlTDFnWZTE6IAmw6ECFDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH3PPFFA27DACA6.namprd11.prod.outlook.com (2603:10b6:518:1::d63) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 19:58:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 19:58:58 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 11:58:56 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Message-ID: <697281801f449_309510032@dwillia2-mobl4.notmuch>
In-Reply-To: <20260122113216.00004eb2@huawei.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
 <20260122033330.1622168-2-dan.j.williams@intel.com>
 <20260122113216.00004eb2@huawei.com>
Subject: Re: [PATCH 1/9] cxl/port: Cleanup handling of the nr_dports 0 -> 1
 transition
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH3PPFFA27DACA6:EE_
X-MS-Office365-Filtering-Correlation-Id: 8198e092-47f2-4e11-d6bc-08de59f0ade9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUJuQ3k1ZnludjlVbUk2V29SaGhjTnVQRGpJa1JQMk5SekloRW0zU1l1SExK?=
 =?utf-8?B?Zm13ME5OMFhPNGFpQWVDZ2pBeUhtR0FGVVdKeW16NVQrWUNzQmhpT3FJa1hZ?=
 =?utf-8?B?RktXMWRCRDZ6enladWFJVWUwalNXdGo0OWFiQU1TMEFIRWZ5YThrdERXb2lN?=
 =?utf-8?B?T2RzNEhGMjU1cnA5MzltdjVSSHhnb2FScDBweFNrRzNoUGdid3ZyN05vQ1Uy?=
 =?utf-8?B?TDVzZEFjemY1dUs4allFWE8vLzh2UXRCNlpyNi95UmY5NmJFZERPSEx0MXVQ?=
 =?utf-8?B?T2s4S21SUDBiVDVIeDVrYmpIM2E1dDY4VG13V2Fqd1Z0ZzY3aU8xdVhobFVu?=
 =?utf-8?B?TTJUVnlJbUYrS3N5cmVaM1JqZHpraHhMYitTOUpIZUpiQm1UMlFzUUNzc3pS?=
 =?utf-8?B?OUxSWmhvcVI0N3JqMjRJelYxLzlaNFBDZXFOUHM3bWppdDlPN2tvSkpwamhG?=
 =?utf-8?B?dEF5MDlkRVJFMTNDS1RZbUhLcXQ1YmE0aFcxYmRNOFhxZ0orS1c4cFVLL01H?=
 =?utf-8?B?aytzNlYwYzdDWFZTbnBveFBGNU5rS3pRMldVV20vNzY0aEhtZFFwNitFeTZy?=
 =?utf-8?B?S284aDR4bTEzVGpmOXRZQWFBclNqWjNoTzZ4bmRLMW40c0VvWFRnSkh1Vi9j?=
 =?utf-8?B?dUUvdjVjRE1EblJmamVLQ0U0b3V2TkZRai9EMlQyVW5wcTkycnRLVnE5bDhJ?=
 =?utf-8?B?T2o2VFYyZDdzQ2dNcXJOUjRCZjBWYmcyS3FwUUViTnBFeVFMZU5TUVBLV3Uw?=
 =?utf-8?B?V1B6aTJZQlpWTC9qeFNqZ2p2bjEzY1dHQjlZY3hCY0pzZDVkOHV1SWhYZENU?=
 =?utf-8?B?UkQ1ZDh3dDdlUUo3ZmNTMWY1VURIakRIeWl3c3d3UEVnVWs3bEIxbWhlR2k1?=
 =?utf-8?B?dFBySjJmWklmT0tMbmhNZVB1QmZQTk1yVVJaMi94MkVaYkd2MXZUQkFEWVEy?=
 =?utf-8?B?NXoxZ0QyL05MNWduRGFaYmdLVittM2Z1TWRTWXIybU95R1ZhU1J6VWJXbXNh?=
 =?utf-8?B?dEUzR24rMU93U0dVMWNhMWNLa2dyNXFSclNMRC8yWHh4U1VCWjlWL2dza2Zq?=
 =?utf-8?B?TjNRb3NhU1FuWFpOY1RLWS9iUmdNMjBGOUVOdEpWL1I4THBmdFVYaXg0anhS?=
 =?utf-8?B?Z2hmMkg4a3U2bEhxLytMRjIydGNBOUJPbkJiQ3l6VjdibGhXUjhCZ2hsbFVu?=
 =?utf-8?B?WHV0eWtVRUQ0RXhmV3RrZ2lMNVV1N1EwUzh0R2pRMURjTFBvdTBwdGxldVBB?=
 =?utf-8?B?dWcvNFhhZmsraXRvVWpyQXUvSmpCRHZiU1dPTExZa0YzMTVrdFlxSDlHTE1r?=
 =?utf-8?B?MDIwVGpZRUhRRklUTW02WHpodTFZSVpjNTN6djVaTkQyb0VjdktVMjhIbmZS?=
 =?utf-8?B?Z0NVenJRbXhyNzdLMmZQejROSW9jRk94aWJTZWFPbldCVDQraU54blFoNkNO?=
 =?utf-8?B?UzhkblZNbUM0QVJMVU1ON0NFUEQ3N044Z3ViZ3FMZERlcy9uV3JnRGUvNGR5?=
 =?utf-8?B?ODZMNlA3cE5qS1RtdHNnZ3RGbE1qQktsRlJpdFYwUndnL3k4QWlTaEhFWlRU?=
 =?utf-8?B?d1JQWldwdW91VHF2UWY2WHRhMW4xWUN2MGNpQ3h1amNyS09STkNtM0NKcC9F?=
 =?utf-8?B?OUx4L0FkcXYxMFAvRlBJaFNJdU9lY0NsNEJJejRhY2F4Y2YxTEZRUXVDQysv?=
 =?utf-8?B?Y3NiYlZkOHJmeUY3LzdxYWNBd2xLOFhTdjZ1RmFSUHR4RUNHVWh6MWtQd3FW?=
 =?utf-8?B?QzFpc2oyWlByZGNwYnRyZmU3UjNmdFEwc0d0UkJhQlJNM0JDYW50eFdIaks2?=
 =?utf-8?B?N1ByZXV5Y0ZBRXNYRnFYWkxEV0grdXFiakVKbW00T0ZFdGlDUllYZ21OZlVx?=
 =?utf-8?B?cms1dk5yU1A2a0x2bHNhQ05pV3Zsb3JRZHVpUEh3NTNJMU1oS2xreko3SVp2?=
 =?utf-8?B?Q2VEa1VzYVpLY1l2d0tObGhSSjdXZXRTZkE0MXBsckFnbEwxcXM0bUFVRUJw?=
 =?utf-8?B?WmpHRWN5VldQVkFuemZEdjRaUEtOSkhkSGdBdGhGdFZaWkUzekZsSEpoWW5T?=
 =?utf-8?B?OFlTamZNNGhTaUhURm5NSWxzZDR2UmppUTFoc1hKSksxNmRtNVRkd2xLMDZx?=
 =?utf-8?Q?sv9Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWtXY3lkaW1XVjBkc1BnakI2YXQ0azdUZXQ1Qms2MUxjc0dIUzJLcmVITWRv?=
 =?utf-8?B?NGcvalJFRjMrdkdUMEcrbFV5dXYyaThRZEthcjdWYWE2MmVJYUFNdDFpZ1NX?=
 =?utf-8?B?N3ZJL0lqTXdCNC83TTJaYWhHUjRPSFZlMjg4a3ZPOW9NT0l4RE9ZYzlPVG1C?=
 =?utf-8?B?L1dKM3RTS1dBOHZjRUxSakVBV3pmV3NjMCtTeWVKMFJGS2FpVDFKc01xcktz?=
 =?utf-8?B?alRmUFdFV3lHWXE1Qjg5b3U3T283N0dWaGYzcS9YK2lNeG5BRzhYSHhWU0JH?=
 =?utf-8?B?QUJ6QnYvOExsR3NHK3Z5dEpjUVN6UEJlRjNwZ3M0YXpuTkg4Zk1iNmZJSUJl?=
 =?utf-8?B?UFhtZ1ZxdzdYRm40UlorMFo4L2VPcHRqVUk1N3BsUy8zT2FvbjEwVnVydWwr?=
 =?utf-8?B?ZFBnek91dURRcDdaUG0zTG9idTNBTjdUWlVHa1ljd3M0MVAxR0Zuck5EQVVm?=
 =?utf-8?B?MHMrR0NER0FTK2FGcnczS0dsVTM3N3hiWVpMbmcwYXpkemdSWUk1RHNKNTZ5?=
 =?utf-8?B?NDR2UWpFKytQZlpndzlJeElxLzF6OUpodWdLNThsU3pRZE9oaVI4TnFXS2RY?=
 =?utf-8?B?U3I1bTBHY3k1b1R6QnYxSFE1UTFpa0FqNCtXdDFJSE42SXQ5SGtVWlJGUDYr?=
 =?utf-8?B?ck5ZbFhITXJGVDNRWnozRzU2MTZiay8zbEFLdWZDcHNUY05tamtLazJDU2d1?=
 =?utf-8?B?VWVwSnpoaU5NcitmUGxmc1Q1bHR5dUhrZlJiaDRaMkl6YUNnTkRUaUYzRlNK?=
 =?utf-8?B?N2hFS1dVR0NHVVFERTNKQ3VRT1BVTVNxSmRmb2ZZMTVrYS83a0ZVMEQzMitC?=
 =?utf-8?B?Wngzb0xWL2xjLzNBb1pRWSszOTBYK1RBU3FWYStpMWxmZ2xhMDZSWnNtMUpj?=
 =?utf-8?B?ZXZsV095ZFVQZnlNSTQ3UTZ5Q2FlbTAwOVp6SnQ0R240U0FvakxIYlVSNTRt?=
 =?utf-8?B?aEMyTUt4blhlank2MVd2TzNPc0Zyb0IvcjNjN3RZTllhbHN6eGZhVGdsR3VY?=
 =?utf-8?B?VGVVbCt5TUpmdXMrQm5odStEQi85Qzdib1REdjNTRlFRdWxheFcvTmJzWEtR?=
 =?utf-8?B?WFlta1B0bjBmVzA1U2VYd0svRFBPTFlvMmlaaEtzUUpDRWhaSmhiSmFITy9O?=
 =?utf-8?B?S3g3Undhc3VlTWRYWW9lS1hFSnlOZVRqd1BwMEZZOENiaWt6V3VqVmZKZzBm?=
 =?utf-8?B?VGN2TlgvVmVWbVp2ekpsdTBNdE12ZFpxeDgyUTRVbng3bVRBUHdBa3l4T3I4?=
 =?utf-8?B?TDV4a1ZDa3VPT2phTFJ0MVNMWEtmTDVRdGRmWnhDU1Bvd2tNemFZOHF1ZFFN?=
 =?utf-8?B?dmMzM3pZbHVseDErV2JSejZXcGY4WE9aWmpid09IWjZvSzZ4VnY0REp6cFZX?=
 =?utf-8?B?ekxKQXZTbk8xOHhwYkt1U2ZtbjFLRG1rdEVYdEQ1d2o3RDNGUHpLbWxZSzh5?=
 =?utf-8?B?RW8vRWFIMVNTeUc3cFovRUViTHQraXhsZUxrYkRqNVpPNm5ZYngvbE12YStl?=
 =?utf-8?B?N2hQMWMwVmYzOFlMUGp5S1M4NzV1WGw0UUJNdVdzb0pudFB6cVlpUUtsMURL?=
 =?utf-8?B?WVZORGlWTUIwUlg4Q24yT1ZkZDg2N1pmbFMwWWY1RFNkdndwUm16L0JaRjlZ?=
 =?utf-8?B?a1pWUEY2Y0pDcmtsZkNBYzc5VDY4MnJGKzFmYXdkQUh5MytSNUtpcndaempr?=
 =?utf-8?B?ekdqWjhmL296aEF2Njl3dDNrdmdhTzluZnVvb1V2RFZuTzJLelB2U1JHUVJi?=
 =?utf-8?B?SzNaakc4QmlwaEtRUldsbWNnQWtaTzd6NzdIVWR2cjVvcnI1Y1lmN0VYN21u?=
 =?utf-8?B?U3J5TWdkbU9TOXFBTkpuWXhYZVR4YzZtaWNrYnhHcWp5bWtDVjd6SFZrMHNm?=
 =?utf-8?B?WVNFQkgrejVIa3VGaWIrZmZ1b1dBZFlmU0FVRk1tT3lOTk5TUlBmWnU0VEwz?=
 =?utf-8?B?MnUrT2MrcUZ3ekVqeTVJbkVyTXpmVHRjNCtseFNKTmJYVXhKbHllaTljUFBq?=
 =?utf-8?B?NTYvN1RRYnp0bFBBWC9OYmNCM3R6K0NrQ1lRL0FlcU5IVktPZGttQTF5S1Ni?=
 =?utf-8?B?M0hmaFJYUG1pWExUV0piRGlOMzFvWWxjQm93MkppODc3a0FKZWM2VHptSy9r?=
 =?utf-8?B?SSt4VmNXNVNjUlhVd1NiTlNDNUlrRkVmZ1Q4dVN6RXBRUUY4VE9FREFhYWdK?=
 =?utf-8?B?YTg1UDJXK2tXSmEwSlJqcHFsckFjNlNGNXgwdEpIdVNlcTgvWjQvZFQ4VHpZ?=
 =?utf-8?B?ZEFCemxUMHJnWndUenVRcXNlZklsYk1ZVzdDNUpLZjZQd3BUcUNXNm1kWEJ4?=
 =?utf-8?B?YWhNZTBMbnpmaEZVRzM3TTRjNjZETGRFWmVadFR1UzFZZ1R6NGpZbHJlNmZC?=
 =?utf-8?Q?qJel9nydzFeCG/5g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8198e092-47f2-4e11-d6bc-08de59f0ade9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 19:58:57.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATuKOpIdomr01yQ+sgKfOq748Lt16QzxXykOqExzDpJj2sTjrB+3URgmye81l1+dY0wAuzwRbu+xRJjnCAyPhbmPOCCXw7drfB8kDUrRtIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFFA27DACA6
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 21 Jan 2026 19:33:22 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > There are multiple setup actions that can occur for a switch port after it
> > is known that it has at least one active downstream link. That work is
> > currently split between __devm_cxl_add_dport(), the add_dport() helper, and
> > cxl_port_add_dport() where decoder setup occurs.
> > 
> > Clean this up by moving all @dport object setup responsibilities into
> > add_dport() and all port effects into cxl_port_add_dport().
> > 
> > add_dport() handles taking a reference on @dport->dport_dev, and
> > cxl_port_add_dport() grows the awareness to setup the port component
> > registers. This removes an awkward open-coded xa_erase() from the middle of
> > __devm_cxl_add_dport() and instead tasks cxl_port_add_dport() with calling
> > the common @dport destruction path if anything goes wrong.
> > 
> > After this @port->nr_dports is always the count of @dports in the
> > @port->dports xarray, and cxl_dport_remove() is symmetric with add_dport().
> > With ->nr_dports now reliably tracking the number of dports the use of
> > ida_is_empty() can be dropped. Recall that the ida is only cleared on
> > "release" of decoder objects, and release can be arbitrarily delayed past
> > unregistration.
> 
> Given we only care about nr_dports going to and and from 0, why do
> we need nr_dports at all?  Why not use xa_empty() as the condition.
> 
> Does this now guarantee we don't need the extra nr_dports reset in
> cxl_switch_port_probe()?  That also made me suspicious of something
> funny going on as the count should have dropped to zero if we
> are in state to rebind.
> 
> Other than those this looks good to me and both of those are perhaps
> topics for other patches even if maybe they could be done in here.

True. I had just been assuming that nr_dports was still needed for other
reasons. It turns out that the original need for nr_dports:

    e4f6dfa9ef75 cxl/region: Fix 'distance' calculation with passthrough ports

...was obviated here:

    711442e29f16 cxl/region: Fix passthrough-decoder detection

So, yes, I would be on board with switching to xa_empty() as a follow-on
cleanup.
