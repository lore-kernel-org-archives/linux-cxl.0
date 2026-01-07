Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E74227BA4;
	Wed,  7 Jan 2026 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767752387; cv=fail; b=qcFocHwYrWPuM4uVgRienM2H/9Fkf/dJSqjYMSdTpU/sKDF0bBw6vPvBSLAee08hzjJ5hCszY9sbgyoDI3Eax9ioz3I93KI0X4jNfuF+/ICFwrwjwqqids8yGRm6OK8b+qr2vFrFYoPtsOq14tf/YlEKQ1HiCGtbJ8/Ck8GpX5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767752387; c=relaxed/simple;
	bh=HxkhW6oiNotiDs0jB+UUVWf9S4yEKTkU00P+587jbbY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fgqzrB4ZjTapuCehnNn5PewkC3TJym0g51m4fh83BVmj73qCp4v7T/nB35zDGWiMAJPDYZxPPPuEv5Q0RptWanmTJwCVjX6/VzL3kAkV6GQ94mqD04Y2cI+O3o1zP8GKfUX2Q66mKtknBiQS++y0NTBNGY/VGYWxW2UwIoaDaYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moA75QW+; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moA75QW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767752385; x=1799288385;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HxkhW6oiNotiDs0jB+UUVWf9S4yEKTkU00P+587jbbY=;
  b=moA75QW+x58IRxtNbMiYP1/WrDZdMOigkgTkB7F1tA5BnfZgF1d5GJs0
   Z0o5pRt1aq/cjOdVqWXT7gakFVZ2w8TA9c5zEiXJLhgCZkt1JKeaX5SLR
   8K+ZjJ3a6FBCRBHmhmfLa5O/Re50HYODR9FhnOfb6LpbuNrdOAfSzJAsE
   30Qz0zDbgvcy6p6ox+pUZ0Z5EDMuguKLEuLJ0wHt1sCKuzf6AcAstSkI6
   FFBRSvKtHT73JJnnwKgLpkYXY7A30S/5v0MgCpoXz+db1KeoJswPGFojC
   frM7gn+1IEW6d5XjDTZLpIVMBBsJdWLzs4WGjb9RvM9G77gjdooB6K5q/
   Q==;
X-CSE-ConnectionGUID: w+HTJ3gRQsWCpRVdQixFkA==
X-CSE-MsgGUID: Ac16qG9iRh2VUSLGZIxbhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69101443"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="69101443"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 18:19:44 -0800
X-CSE-ConnectionGUID: 1mPZ2TxnRhGzWsNLbOrZlQ==
X-CSE-MsgGUID: 7pJRwuygSLWQfKvHpDOKsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="201935971"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 18:19:44 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 6 Jan 2026 18:19:43 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 6 Jan 2026 18:19:43 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 6 Jan 2026 18:19:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SngbRkZNxTU77MSLms6eWENa5Ts437WwM6fFmc7KI5D41s4ypiwBaoE79l47DjxFi+mHqJi1CFEtdXAF2FaSmbkBBIYBEhGEwy+cmeD65IPYqgNFrLg6LYlmGX530GqunJBBMbV/fQ9xofYdtxpe+cHmiC+RskK8eCRuWPqwGxhJaIsEuhIVmV0O2Gbt/0ACR+CoxKfaz7+fnCcoV6dI1IBmKbkNGmXHTXalqXsfkeEW/DWy90TgHAdUqWjPlv77lhFlqQFYrPl+juaBHewUP2eStzhGhCn9yX/kXTTMwRdDngjuUniCiuCxdm214lq3k2zr+B0dW+ncsrcliBXeGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pe04nLmB76MeY3Y/DJCQvlguxFOyrFUPR3fSsBt0asc=;
 b=ntRo8a1URkYeTYqKe1cvgzdjqJdrqJ7Y2vLlVRZZUrJTUM6j5yEjK9ctJ1J+9FmNRSzfw9VeHwO4C+PncUPeOlt85KdbZzCKeOzfNJpWON+ZslJBQ7Gts2ycU3NjMJ/FMjlu6gtkcfV7FX5NADYY4vtgXUr7C8Fo2RuUo5XapRW7eo7G6fhMzDSJJocoR5/stUrOwBtVW1RbTzfY+FCZLjJhPvQ3SaufO+D2oLf13fRqYeenKzcISBtxU+0oim3tNnlfgwWsZtIP/FrY/IesJraxzYntsyWdBtjg3tvKtIINOzOMAdrKkJilPbKbO6O+TZRDXIYHH2tzkzeiyL50GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ5PPF6E320AF71.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::833) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 02:19:36 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 02:19:36 +0000
Date: Tue, 6 Jan 2026 18:19:28 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-team@meta.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <corbet@lwn.net>, <rakuram.e96@gmail.com>,
	<alucerop@amd.com>
Subject: Re: [PATCH v3 2/2] Documentation/driver-api/cxl: device hotplug
 section
Message-ID: <aV3CsPl8Zsp5JtGu@aschofie-mobl2.lan>
References: <20251219170538.1675743-1-gourry@gourry.net>
 <20251219170538.1675743-3-gourry@gourry.net>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219170538.1675743-3-gourry@gourry.net>
X-ClientProxiedBy: BY3PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:217::7) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ5PPF6E320AF71:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b536025-af16-42df-b3bb-08de4d9333c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDdtV3pCSXlaVGUzSkxWNkdGMlI5aDRJSHVySDhsb2ZOOE9SaTZhS2dKazNS?=
 =?utf-8?B?bFJNRWN0d20yWjdwMmFCVE9CRVRjZU8ySEZPb1F5VFBpNmVQWGczeXJUOThE?=
 =?utf-8?B?UDNhWHlzM09GVnZBelYyTXRRYjZwc2tnUXFTYTd1ZXVVUnlrQzRWRW94S3M1?=
 =?utf-8?B?bDlCZk9Yc1krVzBDQU9SZzNQaVdsQTB6d0xVVzZoN2tmTmJnMW5ralg0ZXZ4?=
 =?utf-8?B?US9FNlkwUHkxNGh3ZkZDT1dJNUNYcTNMY2JkaUNBNGV3Z3Q1NnZ6NmZvaUpo?=
 =?utf-8?B?SlZlVmlMUndKUXpJTW5jbVFOSWNtc0ZQWWlQMVdON1FMR3RVQlJpK2RCSzFI?=
 =?utf-8?B?d0NnUHNEdC84azlSTnM5MW9IUE1MeTZRbU4wOGthUDNQdjdoazJXcG5wSXVz?=
 =?utf-8?B?cVVOVXhrUkJGZS9sZnVZQnE0K1Jkb2swdmEvSmxSNEhHcDZnRE1HUUYzQjFw?=
 =?utf-8?B?REM4UnFKdUkyVmQxQW4yRFNlOWo1bUhUVVlaSVNGRlJhSHJlM0VtSUE5cUVF?=
 =?utf-8?B?bXRZM0o1aFVXNFp2RnJCTzdEUWZYbnVvSWYydGMzcEJueHdDakxQTUZqRU4r?=
 =?utf-8?B?ZVlEWXN1SmdoL2ZZYmgxMi94QlIxQThueXF6aDZ0SVFGcmlQU0pCc1MvUDNQ?=
 =?utf-8?B?ay9nUVZkNHhFM2ZpT2RvQ2tjUk5zT1NIUTZWcngzYWs1S0hYQlZ1OW4vaFFw?=
 =?utf-8?B?NEo0WDJYcVp0eEJUUDRzRnpiK0JsSS9jakJCRy90OU1INWxrMVlINFM1Snh2?=
 =?utf-8?B?em9BVTBYOTBjcXJXSnorWDJ3ckNpSTdNWU9iNlNocGVrK3NJNDFjWHc3OVU3?=
 =?utf-8?B?N0xBUngxVDBDeW44N05LZVhlSDZZaUF3M05WenFyYTMxNzRRRkFQM2tPOFU1?=
 =?utf-8?B?MGVwQmtWbnJjL2ZJL3BYTGdCSWE5NFJHOUxyOVRLUE4wUU5tSG1yWE1nclhE?=
 =?utf-8?B?dy83UEhOSXdFbXZFOXZ4NU5QcGhjYlFzVGt6RjNVSFlkdFNxQUZjTXlmd1pu?=
 =?utf-8?B?NDdnZytYYWdXQjFJeTRodEk5RTdzT3lpaXZEeXBJVHlieitQSEtRZk5uMVFl?=
 =?utf-8?B?OVNuSWFQb1YwZHZIMUV1cnhabmlVWmpwdGorZ0tOOWJ6dWlzVWsyMHNDSjFq?=
 =?utf-8?B?TFdjdEQrMS9YNnV3YkRiN2ZCSFZoZUxXQ0QvNno0NHdRdXJROXhYdXI3eUpJ?=
 =?utf-8?B?Zk9LS0pDNmRsVHMvbDRZTm9Sc1JYLzFzWDhYRFdLZXUxZStneVVHOHBGZFhh?=
 =?utf-8?B?SVFLV3pBU1IwRjh4QzBKVjdhM3NodWlQL1ZVUUhzSG1IdGpkZVJjUm1XMHBl?=
 =?utf-8?B?T2ZBc0w1UGJSZWo3bTRBYkRQemdBdnNjQnk5S0NHeGdyZjhDd3NOdWUvdE5G?=
 =?utf-8?B?T3VFbXhXTjlpVFY4TTFDNVhFdlV1ZG5jbE5qb2hORVJLNk5zb2xQbUkzTnVD?=
 =?utf-8?B?d1Vla3N1SEcrcnY0S0RwY09CQktkL2pYaWhNcUNNOXRJMEJEbm5tV1hybnpp?=
 =?utf-8?B?eTc4SCtEdDhLS2laUThmK2FJOHhIS3dRVms5bjVPeVVGaVNZYkRSTkEvS3VE?=
 =?utf-8?B?MXk0dTN5NlhSZVJ3N3ZWcUNZbjJ5dE1FeXp2QnFuK1hMbGZqUGwyNUdSeHpL?=
 =?utf-8?B?TlpTaFhjdEFMcjhiejdiQ2pRSWZkQmw1UmFEWEYweEJ4TXA0cVlyaCsvM3hR?=
 =?utf-8?B?VVlMMys4bjdRT3R6ZnhZMlhpR2pibld2a0t0MEdJMHJsd1NwSC8zbnFEWE43?=
 =?utf-8?B?MHFpeWF6c25RQ2g3K2p3NGJCUjAyK0J1WkF3VmlFbkMycER4aWxXTSs0K1hF?=
 =?utf-8?B?TmdvNnI3V1FQQzdRWFNDWlU4RFRZZmJZWkNoYkc2aEk3S2IzSjlGMGJ4Yk92?=
 =?utf-8?B?YnVvV3M3c3VWQmNYbWN3cEZad1VaUmJEM2RnbVVtNE5WR1RYS00rdlJCVExx?=
 =?utf-8?Q?2dRg+GNKSzRkkeDHq7kpcMAo6QGQW/tw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWNNUnhwVU9NMUplOERidlozODdaUldzaUw1NWhYWG51TjlGemNhYjNUclUx?=
 =?utf-8?B?aFpZZXZkeEp2TE8vZzI3d1RhRnNDK3ZxZ0xITVl1VG9qTmc2eTVtMmtxVTg0?=
 =?utf-8?B?cjZSMXRDNXhiRWYxWnJPOVM5NGNjSjNPYjlTdlg0Z29mNDJqZ1VBN0dCbkNS?=
 =?utf-8?B?VlpSRkxnMEtUclBFT0xMZGk4aTNUZnllK1dQSGhONURpejRkNVNFcmhVT2hy?=
 =?utf-8?B?d0N2T0VwUFJGQmxCQk9BZHp1b2RacXFFbjhRbkVEdjh0RVRUK1N3blJaekpF?=
 =?utf-8?B?cTRvVXZsbHdSQUlSRisyaUgxZ0VEMzFnRkhHK0xNSldnMW5uNnBKcDVtWS9L?=
 =?utf-8?B?MW5NaVg2eGFSbEtNNnBhUDh3ZGhEMDJpSmx4Z1pvVm5HRmZBT1VYVzQ5QTlu?=
 =?utf-8?B?c2tnN2QzekgrMHNTdDQ0d3Z3ZmVhS3ZkRnRDanJjK2lRSjJ3a3VBbXU5VkZE?=
 =?utf-8?B?a2NyNWdCWDl6MllqdEgzQXdiZTRoeFlYcVNrdEIrMEZNYUtOSEpXaS9SaFVW?=
 =?utf-8?B?WWNDOXBIRTBQSE9Da3VUSzFYU3o1MzhMUCtMdThUUStTbXVyZzVhMTRJcDFD?=
 =?utf-8?B?Zlh1ZHVGbkQrT2czWWFGay9OcHNiNVdsS0Z2NU5FZVpIZHJuQzYxNGhSOXhB?=
 =?utf-8?B?WktTanE2RDh2WFBmS0dHWWNqYVNhNmNIWUhWTkNRZWh1a1R5cXZLU0VObnQ2?=
 =?utf-8?B?T05iak5JZHNsODBheWtDZnNGSW5NbVpqMEpJVSttNHJPdnpmL0RwbU1VY3ZF?=
 =?utf-8?B?NXNrRmExdjREUFJZZGIyREUzYmYwRTJrVXlVeE9ZTEtrVFBxaG1mOC9jMzIr?=
 =?utf-8?B?cUNLL3lFRmFRZGFNenA3bE5NOGxFYVhaVEc4OGJjR2VmdHFqL0ZaZEpJMnhr?=
 =?utf-8?B?QW0rb2ZDSkpYZ0d3clI4dXRmVHpvM0o4U1hXQVl1UWJJT0grbyt0RHRnUVNR?=
 =?utf-8?B?YkwvMzBudjZ4aEtjRHFYR2U2Sm1USFdZRU9TcExDVUhEOTZuckxJUXEwd2hk?=
 =?utf-8?B?TmhVbnh1RmRTNUtoYTc2NjBGTHdFWmZYQnN6cVNib0UvUVFGSGQzVGR4T0Rj?=
 =?utf-8?B?R2d2c04zSGMxS1B6dWxIRDdJSnp3aHV3NDZJd3kyTjhCWWtxcVVGbVpycTJR?=
 =?utf-8?B?UGlWTlEzSHF2S2J2NWJjMVNyRCtUUm5rRk5xYWtrWStpQVJsTzlhdlowbmNF?=
 =?utf-8?B?V0Y4aFJNNmxWb1poaC9mTFlGSGg4dW03WUIxSThrMEt4c1hYbi9lMDg0dzUx?=
 =?utf-8?B?b2VrRjdBYjV0TTFMbjNJclhvM2lFZEhOZ2ZmU3Rzc2FwQjVpdXgybXE3cFBh?=
 =?utf-8?B?bGk3bDgrbnpHOTBTN3NUMzdnR3JpUXZEZGxYREkwNlJOL2QwNWxYeURiaHZ3?=
 =?utf-8?B?ZGNRaE1HV3h1akZOS2dkNWh2MGs1a3pCMHp2ZFpxRVJhNlhtUXFiRzFGQkJE?=
 =?utf-8?B?OVoyeURSZ1NLZktOQmtkbXd4RC80M1ZuUmZHc05jZTU1ckx4RHlNbGdsMUYv?=
 =?utf-8?B?UnNCMEdKOGZrcy9palRLakJ6QTV3VFVDdVdXd3FNTW04VmxFVlVVbm4rRnph?=
 =?utf-8?B?cGxIWklvamtMMThRYlRGVWVheXZoT2pqQ3pMYzhrWi9SeCtRQVBHM0lLTXpn?=
 =?utf-8?B?ZVhIanhnNURKeW9YYW1VQnZ5dEFtTC9XeUxwVlBBMXZ1VE5PLzlva0RPc2hO?=
 =?utf-8?B?S05BbmF5aDdqb2FRSDNFeTFSdzZCajE1Q28zNytueHBpa2xHMkV6UmxpRVV5?=
 =?utf-8?B?YVlYNHZsaitReDlNTTl6NStOSXAxVlBZdE5rWnZySElDY2I3VXkzbFpMOXJp?=
 =?utf-8?B?emsycGxQNlVCNE9pVWgxS0RuOXd5WWlmdzloVy9OYmx4eXBYa043Nk4wSUVQ?=
 =?utf-8?B?UkVhbDhGMkhob05vSHZkUEM4aEtZeUF1TGV4K1VxYUZSQnFSUGRmaUcyZWxu?=
 =?utf-8?B?MU9uTTJ5bmI1ZGJFM0lsTTByWlZyU0wzY01yOUV2VjFmT2JEVXc4YjlpQlVx?=
 =?utf-8?B?U3AxTFdpT1ZlRkhiTHRkS3JGbkdYZ01HY2RJdklkaFkxWEJiWXVDdGRrb09I?=
 =?utf-8?B?M05MT2VORUROdk1oRThpRGZkQVQwRTdNZFl1L3d4WXRWdEV5MG01OGFQV2Vh?=
 =?utf-8?B?dFJDUW10MElLaUNtblZzdGZDaGhQYjVyb1hDajdGTnhCeWlFaUlLb3BrdXNZ?=
 =?utf-8?B?ekpsVy80Q1ViOUNKREltZmVIeWFZc2FnZnk5V1prSE54M2V4Q1doekFwZVND?=
 =?utf-8?B?TEkvSGNYRFRNdUtsUFd2bW82U29vdEtnelRlV3ZBZkJRSHFyTkxDaU1VVjlq?=
 =?utf-8?B?cS9WUElVME1idXlIUUxXM2tEQTNEc253NFBPSDBIaUUyZnZoMERiczhNMVdP?=
 =?utf-8?Q?TCBZzuMU19htW0As=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b536025-af16-42df-b3bb-08de4d9333c5
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 02:19:36.0231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okITKDvlMPrJrL3oCEoyeH8r/+qHvUkjrwPus9E60zRcDNLbR0tSyo3NdGHlGb1fCy+SAk/xuVFEyUckHiGedIZQkZC/H1r45evICgYxPo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6E320AF71
X-OriginatorOrg: intel.com

On Fri, Dec 19, 2025 at 12:05:38PM -0500, Gregory Price wrote:
> Describe cxl memory device hotplug implications, in particular how the
> platform CEDT CFMWS must be described to support successful hot-add of
> memory devices.

Who is the intended audience for this doc?

Maybe it's already in another section not being edited, but I'd
expect to see CXL spec references.

> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
> v3: Jonathan updates, change some italics to bold, add some bits about
>     Linux's expectations for BIOS/EFI behavior at runtime.
> 
>  Documentation/driver-api/cxl/index.rst        |   1 +
>  .../driver-api/cxl/platform/bios-and-efi.rst  |   3 +
>  .../cxl/platform/device-hotplug.rst           | 130 ++++++++++++++++++
>  3 files changed, 134 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/platform/device-hotplug.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index c1106a68b67c..5a734988a5af 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -30,6 +30,7 @@ that have impacts on each other.  The docs here break up configurations steps.
>     platform/acpi
>     platform/cdat
>     platform/example-configs
> +   platform/device-hotplug
>  
>  .. toctree::
>     :maxdepth: 2
> diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> index 9034c206cf8e..a4b44c018f09 100644
> --- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> +++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> @@ -49,6 +49,9 @@ up without requiring CXL driver support.  These platform vendors should
>  test their configurations with the existing CXL driver and provide driver
>  support for their auto-configurations if features like RAS are required.
>  
> +Platforms requiring boot-time programming and/or locking of CXL fabric
> +components may prevent features, such as device hot-plug, from working.
> +
>  UEFI Settings
>  =============
>  If your platform supports it, the :code:`uefisettings` command can be used to
> diff --git a/Documentation/driver-api/cxl/platform/device-hotplug.rst b/Documentation/driver-api/cxl/platform/device-hotplug.rst
> new file mode 100644
> index 000000000000..e4a065fdd3ec
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/device-hotplug.rst
> @@ -0,0 +1,130 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================
> +CXL Device Hotplug
> +==================
> +
> +Device hotplug refers to *physical* hotplug of a device (addition or removal
> +of a physical device from the machine).
> +
> +BIOS/EFI software is expected to configure sufficient resources **at boot
> +time** to allow hotplugged devices to be configured by software (such as
> +proximity domains, HPA regions, and host-bridge configurations).
> +
> +BIOS/EFI is not expected (**nor suggested**) to configure hotplugged
> +devices at hotplug time (i.e. HDM decoders should be left unprogrammed).
> +
> +This document covers some examples of those resources, but should not
> +be considered exhaustive.

Disclaimer noted, but as soon as you start writing about it, questions
arise. 

> +
> +Hot-Remove
> +==========
> +Hot removal of a device typically requires careful removal of software
> +constructs (memory regions, associated drivers) which manage these devices.
> +
> +Hard-removing a CXL.mem device without carefully tearing down driver stacks
> +is likely to cause the system to machine-check (or at least SIGBUS if memory
> +access is limited to user space).
> +
> +Memory Device Hot-Add
> +=====================
> +A device present at boot may be associated with a CXL Fixed Memory Window
> +reported in :doc:`CEDT<acpi/cedt>`.  That CFMWS may match the size of the
> +device, but the construction of the CEDT CFMWS is platform-defined.
> +
> +Hot-adding a memory device requires this pre-defined, **static** CFMWS to
> +have sufficient HPA space to describe that device.
> +

Isn't it more like the usable capacity of the hot added device will be 
limited to the HPA space described in the CFMWS?

a bit similar comment below -


> +There are a few common scenarios to consider.
> +
> +Single-Endpoint Memory Device Present at Boot
> +---------------------------------------------
> +A device present at boot likely had its capacity reported in the
> +:doc:`CEDT<acpi/cedt>`.  If a device is removed and a new device hotplugged,
> +the capacity of the new device will be limited to the original CFMWS capacity.
> +
> +Adding capacity larger than the original device will cause memory region
> +creation to fail if the region size is greater than the CFMWS size.

While it’s true that the CFMWS bounds the maximum HPA space available,
hotplugging a device with larger physical capacity doesn’t necessarily
cause region creation to fail outright. It only fails if the requested
region size exceeds the CFMWS size. Users can still create smaller
regions that fit within the existing CFMWS window, even if the device
itself has additional unused capacity

> +
> +The CFMWS is **static** and cannot be adjusted.  Platforms which may expect
> +different sized devices to be hotplugged must allocate sufficient CFMWS space
> +**at boot time** to cover all future expected devices.

Yes. Above is crisp. Might be crisper by suggesting that the 'sufficient'
CFMWS space could be achieved with one monster CFMWS or multiple CFMWS of
all their imaginable capacities.

Like my first comment, I'm not clear on why we are dipping our toe in
here, when understanding requires CXL spec, platform provider, and more
guidance. Are we describing anything Linux specific here.

-- Alison


> +
> +Multi-Endpoint Memory Device Present at Boot
> +--------------------------------------------
> +Non-switch-based Multi-Endpoint devices are outside the scope of what the
> +CXL specification describes, but they are technically possible. We describe
> +them here for instructive reasons only - this does not imply Linux support.
> +
> +A hot-plug capable CXL memory device, such as one which presents multiple
> +expanders as a single large-capacity device, should report the **maximum
> +possible capacity** for the device at boot. ::
> +
> +                  HB0
> +                  RP0
> +                   |
> +     [Multi-Endpoint Memory Device]
> +              _____|_____
> +             |          |
> +        [Endpoint0]   [Empty]
> +
> +
> +Limiting the size to the capacity preset at boot will limit hot-add support
> +to replacing capacity that was present at boot.
> +
> +No CXL Device Present at Boot
> +-----------------------------
> +When no CXL memory device is present on boot, some platforms omit the CFMWS
> +in the :doc:`CEDT<acpi/cedt>`.  When this occurs, hot-add is not possible.
> +
> +This describes the base case for any given device not being present at boot.
> +If a future possible device is not described in the CEDT at boot, hot-add
> +of that device is either limited or not possible.
> +
> +For a platform to support hot-add of a full memory device, it must allocate
> +a CEDT CFMWS region with sufficient memory capacity to cover all future
> +potentially added capacity (along with any relevant CEDT CHBS entry).
> +
> +To support memory hotplug directly on the host bridge/root port, or on a switch
> +downstream of the host bridge, a platform must construct a CEDT CFMWS at boot
> +with sufficient resources to support the max possible (or expected) hotplug
> +memory capacity. ::
> +
> +         HB0                 HB1
> +      RP0    RP1             RP2
> +       |      |               |
> +     Empty  Empty            USP
> +                      ________|________
> +                      |    |    |     |
> +                     DSP  DSP  DSP   DSP
> +                      |    |    |    |
> +                         All  Empty
> +
> +For example, a BIOS/EFI may expose an option to configure a CEDT CFMWS with
> +a pre-configured amount of memory capacity (per host bridge, or host bridge
> +interleave set), even if no device is attached to Root Ports or Downstream
> +Ports at boot (as depicted in the figure above).
> +
> +
> +Interleave Sets
> +===============
> +
> +Host Bridge Interleave
> +----------------------
> +Host-bridge interleaved memory regions are defined **statically** in the
> +:doc:`CEDT<acpi/cedt>`.  To apply cross-host-bridge interleave, a CFMWS entry
> +describing that interleave must have been provided **at boot**.  Hotplugged
> +devices cannot add host-bridge interleave capabilities at hotplug time.
> +
> +See the :doc:`Flexible CEDT Configuration<example-configurations/flexible>`
> +example to see how a platform can provide this kind of flexibility regarding
> +hotplugged memory devices.  BIOS/EFI software should consider options to
> +present flexible CEDT configurations with hotplug support.
> +
> +HDM Interleave
> +--------------
> +Decoder-applied interleave can flexibly handle hotplugged devices, as decoders
> +can be re-programmed after hotplug.
> +
> +To add or remove a device to/from an existing HDM-applied interleaved region,
> +that region must be torn down an re-created.
> -- 
> 2.52.0
> 
> 
