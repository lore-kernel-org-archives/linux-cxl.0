Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114121E991C;
	Thu, 10 Apr 2025 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744309670; cv=fail; b=synLoGbOPFcX1g8eG123SDn94zIA+QpZ53rrRa9hmzjbD2MEK/LZU5QX1OxQ4DeVIQU3A2azWYhFXAluxuCgfN0RelnKknOirq1zX+N93HErZFH3hCZgkMMlaKynrNEfe6xj+bHuBxnEruxf6k8YB9mm6hn+VH+8SRr/DMa/JW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744309670; c=relaxed/simple;
	bh=hXut8d2GB4ztkjT2IegZmCqu49t+CktKxA1ndxA7Kzo=;
	h=Subject:From:To:CC:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HxEqyoJgQRqfFSSOXPu7b1QK8Spd9XOIrogAWUbpRbmKUPgrHVk/VJ6WY8ExcDYbWl7Ps3MXkAJ78kqRGrMj6sumic0Zjci7OxQLPdpcT/MgsKc0B/1ZIFFJ1V4j2d/2TItctepbX+B/4O8TZWUV/XUFibfbgje1xmNggG5PsG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPFPZ3dp; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPFPZ3dp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744309668; x=1775845668;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=hXut8d2GB4ztkjT2IegZmCqu49t+CktKxA1ndxA7Kzo=;
  b=DPFPZ3dpvNjkqVHrKkhAMH4feTvz02Z+9JTcFMgnmOXLahvZBdBKGsJj
   HceogZL1ogZ7spoOLbQMHMn0X4q2P1XZNN8ASeJG0ik/1bhRtGJfk5KdY
   O+rXv2Yxalm35pncczigtGOsWHMXUAcTkKvI4DaUEEkKmvxLbog5jDW8Q
   BquRwVgCTIQrIKTp7D4WaI+YlPXsn8fJiGjZ2SzrfriO3MDDPB9bdcrrI
   nCYKej/DYUEcNA8Dv4JPAJ9XpPi5txHvT1J5ya0dm3pLERT+s+VSnT+QN
   vV6elow1gtLOOMGru24+rU7u7Cv9SzCm7KaRY8B+4BpzpB0NKECNO6xW1
   w==;
X-CSE-ConnectionGUID: wURhBaI4RBiksWuNJtGwNw==
X-CSE-MsgGUID: RXNainhkQEqxpDGlTcYMlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="71237453"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="71237453"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 11:27:47 -0700
X-CSE-ConnectionGUID: xTq9AoIfTPiCwFfrSBMLpw==
X-CSE-MsgGUID: xYN31ej7SE2OgaPCHz5nUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="159957483"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 11:27:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 11:27:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 11:27:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 11:27:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtU1qUwRo8PcwpyCFYuN/+uZzh3T636Qpvw49qc2KvBjgclW8PJeUeg1u5Zfxeepnn2pVDeS74Qela75F2wdI088hBIXHgyhf19S8822Ll17GN5VfrTx+6B7Zpth3/hV4DnUu7TpE+BEzf4/fGs8HDUKQ24ozy3WO+3Ep5EtwIdiofZHjGsfrdbINX5PSbZrgBV2HFVk9ok3HtE1hF1FxdYRQRB+x3kp1t27T31+KB7i/J4Bs/HZZB1RNcfMKWCv80ERmzZzWz8HgsEJcuJNBqEVVsVki0bpi7aktoJ5vZFrXfjlcLA4V6sniL5BScn1drVLIBITEIcQl9s/Nc3/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3I4Kx3wxfEoEBWyytf1RqT2AKherOSXHSg8Z4x6hvE=;
 b=C7I8vn8hLSv/Fhw1joolyYUv3gypNqJ/0bmA2xrubQykKRyP6IbxGt8b/VgTVY6lWOuxSBMLMZ5hbFtxg3ueZq0oY42NAyo20h78/F0sxTYQTTMAik7XeqTPMUtw6MGRCzG37WTm/oG0TRLa1Iu7KiFKaq12QOUDzVVJ2yvjq4O0HI2GDAS3JyUTCIC4J/0P5dzVATfXNGNKg40kU0VorVhgEkJa9q9479RNQr1JIUqifSOqoGvhO/sNYNnmMRz7a+TPB/poejaMv1KICtlzSGu5jTfsvTnpRt6OP66Udu3G/Ez5LctvWjvywkIBhi72Eqsr6q/xPOa4qa0fiCuTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB8861.namprd11.prod.outlook.com (2603:10b6:208:59a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.24; Thu, 10 Apr
 2025 18:27:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 18:27:43 +0000
Subject: [PATCH v3] fwctl/cxl: Fix uuid_t usage in uapi
From: Dan Williams <dan.j.williams@intel.com>
To: <jgg@nvidia.com>
CC: "Paul E. McKenney" <paulmck@kernel.org>, kernel test robot
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>
Date: Thu, 10 Apr 2025 11:27:40 -0700
Message-ID: <174430961702.617339.13963021112051029933.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <174430820360.604341.2116516906072729788.stgit@dwillia2-xfh.jf.intel.com>
References: <174430820360.604341.2116516906072729788.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:303:16d::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1ac8aa-545d-4370-5871-08dd785d6227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlkvK25UcEdXV3R0M2o3c2NoVlRaK2FEd0dqOHJYYmNrT2g3T3ZMT1ZyckM0?=
 =?utf-8?B?TzBtTHgxSHBqV2MzQStjdng5aGM2OVRXaU5JdnhPS0tjdUluMkJ1NDRWMkhv?=
 =?utf-8?B?ZTAvd2dlVUxNeGpoYXlrUGxFa2pEaWRXMDFaOWxYYWp3bURKVWw0K3ZPbDhq?=
 =?utf-8?B?ekZUNTlSTlNjK1J2TUpiN083aWtBcUw4cUY0UmZ2dXVxNjhUcnExbGw3azUx?=
 =?utf-8?B?YUpOTXhtSnFnVG9TWkpyYXI3aWlXKzVZQ29HN240Y2FkWkppYXA5RTZ3NUQ3?=
 =?utf-8?B?Sm0za0lmZExoN1RxRk03NmxFa0wraExpeFBvRFNrdGNINnpITDQvK3M2K25M?=
 =?utf-8?B?aVlzak1zOTRiSzRReFYxMEdUeDZDVWFuUUxmalJpd21GU2dJdE5rcy8yK0Jr?=
 =?utf-8?B?d1dFUkduVUtQTmdkSWRLQ1lHTWtjR3lFYWhNYnlNbjY5RFZwUlB4bVh5aVN5?=
 =?utf-8?B?YU9iR1ozbWRsbFd0UmVoeUo5aTJNZ3hxOU5IZDF5QUtNd09BdnNUR2hhTk1Q?=
 =?utf-8?B?bFowTHp6M29xcjNaOGhxMjZ1VEN5Zm94bmpTTkFoN29HcWZMN0FpUzFLTFVB?=
 =?utf-8?B?R3F3NUswQmVlU1FrM3RUUFIwYmlaQXc2c1g0cXZQOEQ4Y1l1OGk2aU16OUdI?=
 =?utf-8?B?UXlPTjFoa09sZ2g1RzVHK2ZablVVVXVxOTdxQ3YwS1M5MFFSajNuMjdkem43?=
 =?utf-8?B?Y0NzQzVGamxVUEJEUndLKzlnWVo2d2VTaVEzYzR3ZnkrbDFuZUlJMUlUMVhp?=
 =?utf-8?B?aEhkck5IVWczMnprc0xrZlNLK3dHUEpsZlZWYjQ5NVZmazZBelBJRTRmYnBt?=
 =?utf-8?B?QVRrOVA5S1pPek9hbG43MnBGelhZOHdNVWduTzB5bEJ4TlRxdnZ5NXAvaVJh?=
 =?utf-8?B?TXFNOHBLTTBSOTdOZ01WV1pzZS9maVZ6L0s0LzliM2FCaTROWWZ6NmNkVVVW?=
 =?utf-8?B?RXUzaXZVeWovZnk5Situd2p6VVllZHlqa0FKbjQwbDB3N2l1MWpCQnJ6NStr?=
 =?utf-8?B?TGpCUDBuU1U5YWNmT0dzNEhyYjN5VzJ0cjdzRkZmd21xMkVXMDJEVldQZXRl?=
 =?utf-8?B?Rko5dTdXQzV5MkVwMUxnYmh1eWx5TmR4SW82UEhKYzBSVXJYQytESzJlS1A3?=
 =?utf-8?B?eStOYjhHTjFoK2F5RXFicG41bnRwUHR2cGRNYXhMdzUwOFNkTmw4ai8wVWNo?=
 =?utf-8?B?OVdoNDdKUEtqbGdNbFM1Skg5TXJlK05RSUR6Tk1PeU44aHNDTmpFSExvZGZP?=
 =?utf-8?B?OWU2ZGRacklPdnQ4VXV0endtMDE1MDc1N0g5L3hNQmV5aDFzUkxYU3hPelps?=
 =?utf-8?B?Y1FLQkRpdm93QWhXZVVZamwxKzlpM0w1ODArZWlCK0JTNGQyTEluWHdwVGRI?=
 =?utf-8?B?ZDVzTWNnK1dnZmkrTWlRSTNZVkxsa2g3czI1NUJqRThPWk54Nll3c2tnMnQy?=
 =?utf-8?B?MU11VHk4NHVEcFo0RGJnd0IwaVF3SGxRUnIwbzk1bmJlVDZFK3pNamdhTGlk?=
 =?utf-8?B?U1BZbkp4NHVnSHc1UXZRa0hzRVJ2V1NHaW1LSFd5emhyc2RtTnorMDY4QjQw?=
 =?utf-8?B?b3pmQlB3dXlESHE5NHo1WE1uNE8wNm1vYzJuZUhURlNETlhVU3AyNis4d1p1?=
 =?utf-8?B?U1hrTFdVbVNQUkdWckVpdmNVNFprWmcxODN3U3E5MzlGb2lINXlUKyt3dVRr?=
 =?utf-8?B?aGtUUmtiT0JVQkRJaFhUL21LZ2RVd3ZtT3BsKzNFUlBJYklWbGl2Z05rYm12?=
 =?utf-8?B?bEZIV0ZlVlBKN1R3ZnA2OHNCMGt3aHNBSkY2VlhsLytrUmpwMGthVExsNHZU?=
 =?utf-8?B?OHFDSmFVbm5La2FvRDQ2UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEkyYWdaQlliYmVMd2RZK0xvU3U1V3hXajBqTnZ5TUVvTkJ3a1A1Wm92cWhm?=
 =?utf-8?B?ay9xazhoNHl3SEM0eFhIRzBtSWxjUzFENWl6dWdTU2tSb2pwVUFhamVSS040?=
 =?utf-8?B?U0ZzWFhzcVZUUWVwRnVRSTA4bXlyMGVENTNOUStwVm5nOUQ5SUhVU3FXS1BG?=
 =?utf-8?B?TytST29yU3ozT2dQTGwzSUFJeVJkSmIyK2RDRHRUV291U3AyM2dXNTQyYTcw?=
 =?utf-8?B?OGpoMWwreGpSSGdpUzdsdlZ6RjZPSW9LenoweTNSZFpmVWlzM2VCU1NmMUxq?=
 =?utf-8?B?dlhUWlJwci9zUXZYZERpRVZmQ3dKSWs1RWEwWFBOTVVlUktFZkoyd3I3ZVF3?=
 =?utf-8?B?SVNXemROL29oczR6cW1aOG9Lb3dXUml0N0x6blp4dk5RYVQ2SnVDaTRBd1po?=
 =?utf-8?B?T0hFVEhXS3RZNWs5RHozV1R3WWJ4azNseUhoMGhtajJ1STJDMEF4S1UxSTUz?=
 =?utf-8?B?aHFQNG5LZ2I5OWlpVjNwSE5wNmFLR05GYmROdTR6b3loZ1dkZ3ZvS1VYaldR?=
 =?utf-8?B?NHNiUU5vR2RNOEFwOUhLSGlaV0lZOGdFamQ5MkJERmR2UE1iOEdQWkxyVGlw?=
 =?utf-8?B?bFRWWW1EMXhXRWNVZFBiWlpQVitCbzczZkdpUjMrU29lejZINnZKRmU3UUty?=
 =?utf-8?B?VUZDK2tCWjM2bk5RK3BGSnJSU2ZYS05ZaVFXOUNGcE1SWVBnekdUQXRIVExa?=
 =?utf-8?B?R1hvNnJBdjlpa25sOUxJOFRicjN0NnJkUVludnBrWG5qRUc5SVFoajRMZktG?=
 =?utf-8?B?R09YdU9RTFIxWTRUQ0c0VUFmQlB6OVpjKzcvT1dLVHMxdGRlSmZsUUZOOGlX?=
 =?utf-8?B?RlQ5SnFRRUZtY2RLMGVsTER2aFVodGU5KzZpa2xJQ3c4RXFSTzdiZGNWK2F0?=
 =?utf-8?B?b0tRajloYVNOaytaQjdXYWdKRkw2MVZ3eEN4UmF0a0VrOUc2clVTVG5xSFFh?=
 =?utf-8?B?QW1ONFRGZkxsUlo0TGFYcDdjUkVYRWNSc1dUbmoyTXVQTEJEWjBRakJsZkVB?=
 =?utf-8?B?M0k2WlR4NmJ3Zk9RS3l2REM2dTVmdGZGQ0pVbU1TcnFEU1ZLUW8zNXkxVlRx?=
 =?utf-8?B?YWFHZnBLOU9acm5iOUl2VUhSd0xXTTR0Vm84cFhqa3NTZWdSbXp2K2JVcU4x?=
 =?utf-8?B?aDVUTmJpUWwxSTlPK0l2VnFPcmtWMFJHaWljVUJKSUF4dzZ1aTYyU1lKN3Ns?=
 =?utf-8?B?ZUw0cThyWHNxQ2NzODQvSEllZ2c2L2ZRNUpXdzhaekx2SCthSmZNRm5oRWxz?=
 =?utf-8?B?MWV0TTdoMTk2NWYwNE5MY0lxYm5tVVhvZ2RBNWRycElidXhSb3JqRGIrSmJB?=
 =?utf-8?B?anlDUHNLVXpQQVdicE45bC9MQmZaL1IyQzZJMlNIemhLQTVHU0pwaG4vNWdt?=
 =?utf-8?B?d0tjMHZPcGovVzRvMFhSQXAydnRVL0ZxdUVPb0xENGR0UFpNOXZNRGpVVWVV?=
 =?utf-8?B?QlAxdXhTaWs0aW1YNVlET1h6UkVqaDNqQnZ6VTQ3cml1NWVFazlLa080T0xD?=
 =?utf-8?B?cmxRaWVOSEpaSWFRUHFMcTIvVlBGN3B2a1lOWDZjbzhyZFVYOTJBNU9HWGVF?=
 =?utf-8?B?bnVUSmRPYk8vMThqdlFNZHk0Nk1ZZzJ5ZU1lejk0TVpET0UyODJXbkhGSTY4?=
 =?utf-8?B?amZldnExdStRNjhiRGNiSlBnMzh2Y2toeTVFRGh2MzA1eWM3L095TmhHVzlO?=
 =?utf-8?B?cXBLdmFiTGRoUm43cjlrL1NCYmMxT29xK1Aya2NsaUExNG1YNFJtc0hBZFo2?=
 =?utf-8?B?c1VXKysxa1RHMm9RRDNTVzdSM284bk84VFpQaFI3cFY2aTlCa0dZV1NGOWxU?=
 =?utf-8?B?U0Y1dk1RSXlqV1JqQVlIMVhacUFuRUZyd21nSmNyRlF6WXdpY0EwZU16N3Fh?=
 =?utf-8?B?YWdpMHZwTFRmdjZ1VzlraU9GbDhkVCtGV1pNY3FkWjJ6ekRCRU41d1ducTJr?=
 =?utf-8?B?d1dCcDlNQ0NjSE0zdFl2MW5NOE5iSjZabkFMWFBnZ2VmWkpzMkRDSVhVVjZM?=
 =?utf-8?B?TS8rMkNSNFJrNGpYanpXQVlQc0MvZUlPaWp1b01wSjE4R3NlMW1Eb0RaTzhC?=
 =?utf-8?B?dk9CVjZpQVA2TkpLSGpKQXlsQVdxdUwrbkFON1NaMVNRemVXamZOeHNEeXRK?=
 =?utf-8?B?TWhPYWMwTDg5dXdTWERNUTlCSXlualhhckNrL0ZtQVc4ZGtvVUUwS1dBZXdR?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1ac8aa-545d-4370-5871-08dd785d6227
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:27:43.1680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6ba3BDvDtSKrIdjhD7iMUY3o174cXgW3IdHLHjzwAawblJK670YuxoWggD2hEdmQbMTjXLN92XoiIf+YZKNdxloKa67M895eewO9jioo6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8861
X-OriginatorOrg: intel.com

The uuid_t type is kernel internal, and Paul reports the following build
error when it is used in a uapi header:

    usr/include/cxl/features.h:59:9: error: unknown type name ‘uuid_t’

Create a uuid type (__uapi_uuid_t) compatible with the longstanding
definition uuid/uuid.h for userspace builds, and use uuid_t directly for
kernel builds.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
Closes: http://lore.kernel.org/f6489337-67c7-48c8-b48a-58603ec15328@paulmck-laptop
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504050434.Eb4vugh5-lkp@intel.com/
Fixes: 9b8e73cdb141 ("cxl: Move cxl feature command structs to user header")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v2:
* Drop the tinkering with __align_of__ and just document the safety
  rules (Jason)

 include/uapi/cxl/features.h |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/uapi/cxl/features.h b/include/uapi/cxl/features.h
index d6db8984889f..490606d7694b 100644
--- a/include/uapi/cxl/features.h
+++ b/include/uapi/cxl/features.h
@@ -8,10 +8,19 @@
 #define _UAPI_CXL_FEATURES_H_
 
 #include <linux/types.h>
-#ifndef __KERNEL__
-#include <uuid/uuid.h>
-#else
+
+typedef unsigned char __uapi_uuid_t[16];
+
+#ifdef __KERNEL__
 #include <linux/uuid.h>
+/*
+ * Note, __uapi_uuid_t is 1-byte aligned on modern compilers and 4-byte
+ * aligned on others. Ensure that __uapi_uuid_t in a struct is placed at
+ * a 4-byte aligned offset, or the structure is packed, to ensure
+ * consistent padding.
+ */
+static_assert(sizeof(__uapi_uuid_t) == sizeof(uuid_t));
+#define __uapi_uuid_t uuid_t
 #endif
 
 /*
@@ -60,7 +69,7 @@ struct cxl_mbox_get_sup_feats_in {
  * Get Supported Features Supported Feature Entry
  */
 struct cxl_feat_entry {
-	uuid_t uuid;
+	__uapi_uuid_t uuid;
 	__le16 id;
 	__le16 get_feat_size;
 	__le16 set_feat_size;
@@ -110,7 +119,7 @@ struct cxl_mbox_get_sup_feats_out {
  * CXL spec r3.2 section 8.2.9.6.2 Table 8-99
  */
 struct cxl_mbox_get_feat_in {
-	uuid_t uuid;
+	__uapi_uuid_t uuid;
 	__le16 offset;
 	__le16 count;
 	__u8 selection;
@@ -143,7 +152,7 @@ enum cxl_get_feat_selection {
  */
 struct cxl_mbox_set_feat_in {
 	__struct_group(cxl_mbox_set_feat_hdr, hdr, /* no attrs */,
-		uuid_t uuid;
+		__uapi_uuid_t uuid;
 		__le32 flags;
 		__le16 offset;
 		__u8 version;

