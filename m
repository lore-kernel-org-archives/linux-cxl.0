Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B44448CEA
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500951; cv=fail; b=X4ZxwEjhyQ9/r7vupBIpA/kref6sYVSk9P5L/0QSkdfzbJUicmAWQiRDUy6iEIH5jBx1fbjUwPIhEaFNQCezS0rDxehbdVOJ1/TaNYKsCVhZO3HJGpow4h39fU3JKrX+YahkV7oTSGuLHRgtFc7zHipXIn03MJLYfEgritzz+zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500951; c=relaxed/simple;
	bh=ps+NDvGIgnJ79yL62KHoDzzWNcRdEf3PuFtKoWOcWjU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pRjM0yL62tB0oil74Hc+XVavzG/f5fFjkuu+rROnX4X0WCVcCCSnlHl/SVcYEr0RL7xulQGVSNj3EupsTlpIY9szUUeweaCULtvBl0hjErPBO1RAWoopHBvHDSo+jRKwerODPgWdu78wesqBzkSJqPb7RdEEPd65o9i8+thJDnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YCi1PmvL; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YCi1PmvL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789500949; x=1821036949;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ps+NDvGIgnJ79yL62KHoDzzWNcRdEf3PuFtKoWOcWjU=;
  b=YCi1PmvL6xsAAoFesj1MziEeX78C6H1m7jAxb/oNIDEvdVYsW6sRvHc3
   FjmxngOOXTWvwWkJZCk8OGNif8V5woGMZ6pWgVmIf5aon7T/eqwvVfm4v
   iBhK8iUzQ+nibCq65+eGme1VJxLtKn8gt38JqiC+6tDd1HEwNQ73cJ4XN
   Cig/bqdC2MPf/4WVgPVGpXGmgUnoIoJdvJAQKtYy5iVayYlBNymr8FeC9
   YFo4/cwYIXlMumPOBKj2ZM1j7+xfqwhiJfIo9K+mfDncxJGghAXSzgLcS
   bMw2wT/3lYRRCOuwE00XD6OVe0q5JV+CiIUYOlYgPsrYvgflNpaQAUDpI
   Q==;
X-CSE-ConnectionGUID: +5CXubSsQAuUdv7dbFrkng==
X-CSE-MsgGUID: CAVfrcR4RIqx4GoemY5KoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89012443"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89012443"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 12:35:48 -0700
X-CSE-ConnectionGUID: IWF1i2iAS0uXfVAL0Wte4w==
X-CSE-MsgGUID: yPTgk8U3TYOpf9IhFfqOLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="272634331"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 12:35:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 12:35:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 12:35:47 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.61)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 12:35:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsMH4LWBy+pHnJUUOsWk+ewXIbs5ItJclRbU/SzbKNQ6HcZd2Ddc3lgAQB99qTcBey6yKgWQ8Kob8ZKHp/v5gcRJd9sAv1FOfRUyPySEkwQl3rFsRSTMfoiCupjXAoGvGog8GFY18yDy3DYizcf+YnMiXDmU7Ochx1cUcZmbTz5yZfCgjCxZ5J6Qeu95m66ACun01Gtrk6FF+7zrDFQohmHbGqLkq3pa3XjmA8j/iBzmwGTWjzLVSCnKXeYCzUXaSVHXBD1W5Fyda2o2lzAlWJxKkVPiA0WC+TUsBKrXG5EIWkzTkumpkB3sd3LhLQZmIkfvIE+Skl72lkNdS55cQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIHJ+DJlW3mPIw2YbpOKWaX+zLX4S9UUgy1OsVSodWg=;
 b=FK6BQpGTHYizNC4QuTL/2W++kpsMYN6C7QhCOw2iovCHhRSTZSB/SSpTn+b84tD6CCCxJe3vxwbMPpAmws53EGTzgLYC1dcArHa+aqPXwkMv+E0WgaZDAxV91RLUWemEjDqAa28YEhB2JwMHxeBWsp/jRUGNbEJeCtwdZILda8zP6zEnzT/vIfnswFz6ORqmf+9NhhStywpTCpOSFJQy9k8dA0VJsgC/WrFc0LVJxhKDPPebP4/ELa3hzKmG4sykwSqudGo7nmRdaM5u31cirOmnovx8QTX8XYS5n3+wcGFT4EdJW1lRnhhn9aioziq6YKcmSjo7ARnMEsEnwgH0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 19:35:40 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 19:35:39 +0000
Date: Tue, 15 Sep 2026 12:35:33 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Jonathan Cameron <jic23@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>, <linux-cxl@vger.kernel.org>,
	<driver-core@lists.linux.dev>
Subject: Re: [PATCH v3 2/2] cxl/memdev: Fix deadlock between poison debugfs
 and cxl_mem unbind
Message-ID: <aqmeBfIj08J4Uqsv@aschofie-mobl2.lan>
References: <20260910094017.4032170-1-kanie@linux.alibaba.com>
 <20260910094017.4032170-3-kanie@linux.alibaba.com>
 <20260910220329.20b62302@jic23-hlaptop>
 <08cbc221-a4b5-4674-ae5e-4e7b5df9293e@linux.alibaba.com>
 <20260912000908.5df0b62f@jic23-hlaptop>
 <87a780a4-7e69-46df-bbce-a3c021a0b44b@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a780a4-7e69-46df-bbce-a3c021a0b44b@linux.alibaba.com>
X-ClientProxiedBy: PH5P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH8PR11MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2c7d91-d0ea-4f0e-58fd-08df136085ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|23010399003|366016|376014|56012099006|5023799004|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: c+giOMcoe6BV21jlUHRddHDVFdbPIC1u5NVcgIIFzbGqLwAEx4woAnMyrGivpGV/WG1jigDpiUCcz7Z+MABkIg1BvwySU0TbawNL95kkCsYmeedlo1xtitp3H3OIgY+4fOnBPYhArFnNByi2OXJNv2xYhyUIGckES+vdonKdHQyGjHAsRYIeaGOXEh+n7gcp6Hsvoc4I2owS4k6Ri1aMF+KWdP814C3nY3IgW/aOMQr4/YyzPiJd/J0xMWL7mn4nqsOrQO0PIYaF9szthcyzHtuatRUpnsuTPJdSBGj8jMc0UMKczxw+S6U49h01n7LNEn+UDcwuXNXS8rS/RDEoo4cs/rggHftDsp50KpEcQ67x+SC0qqykLUjbhVCxLhvhuqqb7PV7smobcZ17Oci3WinPb4JqoH7Pc5Z2dwYGhpKstqSi7zaOtXdjpHJcqOpAWnRIcfsUEqMT0tE5i6mHdHQhjj+m8P8RAyhbNm99S9lFpzCVphksfMmobKIjgaWe78bIz4NxwEheNaB9+z4dYV4WOgERy98qx3aSl0KDVNc/OGoYkyQJADe8scEIQdCyyifFBo7z+72+Tdse/KBC1qdXpKGoI+MWlLNHf/0jilXNDjdDZCOMHGxgp1YZtPxUwnNdfCaoCjt4eBTmwUmp0J//6/q19sd1PYMULTb0k/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(366016)(376014)(56012099006)(5023799004)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkcxd0RYK2tEcE12MVk2TStmejUrN1pHVkpFdkNEQmw0eWVBRE9LWXBZRGhx?=
 =?utf-8?B?NGJITUw5ZkNOdGhpeVRSTDI4cUszVFpMeS9MOXJ6SWhkZVNDekVCeXhybVhS?=
 =?utf-8?B?bnFYYzlDYk84NEZ4c1dJREhIWlRGN3FyaXBxWG40dWcxM2ZTOVF0TzlvRE1j?=
 =?utf-8?B?VTlrMmRXRUo4OHYxZ1RFVVJhdjhidXdldnZLZVdhUVNNZTVJMTdqWSs1OVQ2?=
 =?utf-8?B?UGJoUWJ0ZDdKYW5RZmVjTjYxTGZ4YWxSYWdaMzllak9yZS9QbzN0SFZvUmxH?=
 =?utf-8?B?NjFBZWZERGVTbVgyU0RDc2gzeEx2TTVqZUkvR04zZjdJTytMNEpsRittSHVN?=
 =?utf-8?B?a3p6ZlE3RUVKMkIyUUZ0T0RzSjFwTmhzSFo3ZmduUUhROXFKSXd4UmF1WVJF?=
 =?utf-8?B?Z0pRUk5IcU5IZXYrQzBYN2NvSDNKZHNtUXcxcUlJSGdSTHJMTEREWWNpY1ZU?=
 =?utf-8?B?a1ZHNmkwY3JyaDFsRkVidGVZazE1bWtNOXN5S1hEZDJ2WG5NNzhnMlNMbzkz?=
 =?utf-8?B?bUVrNS9WaU5WU3dYV2RQNTZIVFd6K1dEVU81VmRTd2FVWEtrdW5wNHFScEhH?=
 =?utf-8?B?RDBpN0lvQUxZZEhWZnkxUlFEaUtCcXhMRkpQMmdvcjJKVkNMTm9Pemh4d3k2?=
 =?utf-8?B?Z2N3ZnpEcGxKYXU3YXBQRk1QV0l1aDhMKytPTU5lcU5Da1Y1ZnErMXNZRWh0?=
 =?utf-8?B?YjJQN0pDZGZXeHdsNEtFV2xqbjRWZm4vbmVwZXNjNEpiMkRaci9kRk1KWi9Z?=
 =?utf-8?B?OEFNQkNYVFZXZFlCaCtMWWxoRjJFUVc2ZmJlbXdCR0RkZnhLTWZ5L3I3RUVO?=
 =?utf-8?B?N0oxakt0NVgvMXExREwyWndOVWRaTHNsa0VUemdXSldoTmlUTEhDMmdTaXNG?=
 =?utf-8?B?dUoxekxJeUl5MnJ1TUhyQ0dqa20zT0ptWGJLZXJJM3dDYmtodXNXclJIK2RO?=
 =?utf-8?B?enBNRzN5akI3b1RsMlo5bDdUaDVNRmFtNHBmdVJQQmp1SWhhVThaZE9IVlFG?=
 =?utf-8?B?TDROSFJpWGMyd3QvK3hrbTNSSkhlZThMelpQemJtcHArdnpsRHdIbGUvcng0?=
 =?utf-8?B?R2NsMXB4dXRTTHFYcm4zUitJb200QzJCTmZPSUJMM2ZRZXAxZ09wR0l3RjF3?=
 =?utf-8?B?TkUvVlNScmRxeUJjYSs2Q2c5RzE0TVMvQlFvYnIvVTByc1ppbFlaWHd4OHNu?=
 =?utf-8?B?ZzFKMHZUZS9mbjNIUHRqVzRvd21WbC9tc042Z2lCOVFHN3hMSzlZT2dUeVpU?=
 =?utf-8?B?U2FQQ1NJSmFQYm9yTGhzNytVcHBSQ2tYU05nWDloMFlHc3k5QXpnWUtidGw1?=
 =?utf-8?B?bGs4cWRrblVETUlkMHZaR0JidDMzeEhSVklHd2xadWozV1UrSElEWmZRUlNj?=
 =?utf-8?B?REFEbmVYYm0wMGZxbTdjc1lRZlM0QUdibnRYMnpodDZyQW5SOGJidnhad01S?=
 =?utf-8?B?Yk5OZG9JQmltbVRUQklxUkR1OGdDUERZRHJCaUhxTTA2WWpINFdjRzZBUmhC?=
 =?utf-8?B?bkVoSGJya1ZqY05wSEFlQ3R2V2U3V0lBMFYySFJZQmRDd1NINC9nMUQvSUhj?=
 =?utf-8?B?U25wNWtwK0dKVUgyc3lMczdkRVY3REpGOW1TaHEzaXQ2UzY5dHRSUEtGN05l?=
 =?utf-8?B?aWl3Q3ZtcFRyeThGLzFpVGZMby9TVm1RVDlORFFFVFEyYUNXWlY2ckZPbzVY?=
 =?utf-8?B?ajRpS2kwdkZ2NW8vUVlac1IwYVpRSzNPc2ZBYXVvUTh5akRQQlJoWVQ5YWZI?=
 =?utf-8?B?YXVEUUZxSnhxUlcwVG40SDNqZWhRakRDTDFpa3dlcER1SmNPcms5dkxSa0l2?=
 =?utf-8?B?ZHpUeW9IdG9iRXhHQXNKTVRNWWJBTjdFMUJaODZtV0NyZGdDREdlQm5vRzk0?=
 =?utf-8?B?bXhHSHpWcmF4WDFCT1NKU3FGczl2dUNDTCs0L05aVTZKSGVmK0xVTmNDNWpi?=
 =?utf-8?B?MnhTblpaYWI4Ty9ycUl3SWMwbEUzMU5Qb3FOb1d3Q1NDa2lXdW5YcDEvRnEw?=
 =?utf-8?B?U0NSWFZWR0NaZmgxRGhhdzNOdEdFNnBRRzRmMk1WcW0wWDVHcU5MZkI5aFNs?=
 =?utf-8?B?VUQ5bWY1a1J1WDJCak5jMGI2S1dBczdZVW1JakVsbXlnb2toUnBBS1RRWWFq?=
 =?utf-8?B?ZnRRTTBLWmN6WkNzRVZ5OEJWT1Fpb3dYYjEwSmpmanU3ZFl0bGtueEN6OUlm?=
 =?utf-8?B?dG9aTG5mZkpqMGJxWTB6aEozVWRFT0M4c0V0blpLYXlxNDBPeFBpMXBYUjJF?=
 =?utf-8?B?dUR6a1hjTTZhalpldDBEUXYySGhqODBlY1JPeXhpWGhJc3QrdjBQSFRLVnRU?=
 =?utf-8?B?SC9tSW1VUDFzNGhhS09TOUpNSkJFUzRKY0tvY3dLa2s2Tm1yNUlQRlRFSVVa?=
 =?utf-8?Q?2VgMJzLoCk0EDfhQ=3D?=
X-Exchange-RoutingPolicyChecked: Wb/ajn1CZkPQSbJbd4IgBSjTCn2pcQl+Zr51KH6kr88hVfTWWElCpcg9mQouC7a3JQngvye0xYyGSCT7i3B5EC+s088pOzM9xHlnSHGoBQsuSMcU9ZfnJqlMJmKVWXhQ6B0W1YnHM43tcIwz8Bt7ei3yiZSl1N8bpteEePFmmAD+RNHSCeTrOoAap0IbOe5ZOdF+DaC7jtHgQpcPQLjdzovHTJALsrlO3p6yYZ4o5iIqKMOwfWJNeNqnjxwOwLCdsYe4qZfRZbcJ5n/GicCOMQvQM082Y08JrpQOisknC36WJ+vIOAlD3OM8htJmrm25dHiECnlqXJHbv8P8iyAXRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2c7d91-d0ea-4f0e-58fd-08df136085ef
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 19:35:39.8037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmDJyIOksPsczuFH2sbTVx1GQlg5GN2f92wK3L7YUmD9/VUmxlRMIyl7KrDosyunOrLnlH/eMRkaJlkdxQJsTyMr1FnDVAKmd7UZT4TotRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8107
X-OriginatorOrg: intel.com

On Mon, Sep 14, 2026 at 08:08:26PM +0800, Guixin Liu wrote:
> 
> 
> 在 2026/9/12 07:09, Jonathan Cameron 写道:
> > On Fri, 11 Sep 2026 11:04:47 +0800
> > Guixin Liu <kanie@linux.alibaba.com> wrote:
> > 
> > > 在 2026/9/11 05:03, Jonathan Cameron 写道:
> > > > On Thu, 10 Sep 2026 17:40:17 +0800
> > > > Guixin Liu <kanie@linux.alibaba.com> wrote:
> > > > > The poison debugfs handlers take the memdev device lock so that the
> > > > > region lookup sees a stable cxlmd->dev.driver. debugfs holds a reference
> > > > > on the file across the handler, and cxl_mem unbind removes that file
> > > > > while holding the very same device lock, so a handler that waits for the
> > > > > lock deadlocks against a concurrent unbind.
> > > > > 
> > > > > Both tasks then hang. The unbind side is uninterruptible, and it also
> > > > > blocks the memdev detach work, which runs on an ordered workqueue and so
> > > > > stalls every other CXL bus work item.
> > > > > 
> > > > > Take the lock with the trylock guard and return -EBUSY instead of
> > > > > waiting. An unbind that wins the race removes the file first and the
> > > > > write fails with -ENOENT.
> > > > > 
> > > > > Found by code inspection. Reproduced by writing inject_poison in a loop
> > > > > while unbinding and rebinding cxl_mem, and confirmed fixed by the same
> > > > > test.
> > > > > 
> > > > > Fixes: 574eda81d0a7 ("cxl/memdev: Hold memdev lock during memdev poison injection/clear")
> > > > > Suggested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> > > > > Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> > > > Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > > > 
> > > > Probably not one to rush in but nice to clean up the deadlock even if it
> > > > is a little hard to hit.  If it is possible to test with a hot remove
> > > > flow even better.  You should be able to do that with emulation in qemu
> > > > if you don't have hardware capable of safe hotplug operations.
> > > Sure, I reproduced this on hot-remove situation:
> > > 
> > > debugfs writer, state S, waits for the memdev lock
> > >         cxl_debugfs_poison_inject+0x25/0xa0 [cxl_mem]
> > ...
> > 
> > > With this patch, the hot-remove flow completed normally.
> > Nice. Thanks for doing that.
> > 
> > > > > ---
> > > > > checkpatch reports "do not use assignment in if condition" twice, on the
> > > > > two ACQUIRE_ERR() lines. Those are pre-existing: the unpatched file and
> > > > > the Fixes: commit report the same two, this patch only swaps the lock
> > > > > class on them, and the combined form is what all 40 ACQUIRE_ERR() call
> > > > > sites in drivers/cxl use.
> > > > We should fix that up. Oddly I thought we had, but guess not.
> > > I think we should fix this in checkpatch.pl, like this:
> > >       if ($c =~ /\bif\s*\(.*[^<>!=]=[^=].*/s &&
> > >      +    $c !~ /=\s*ACQUIRE_ERR\s*\(/) {
> > There are a few other macros that are wrappers of ACQUIRE_ERR
> > that should be covered in such a patch as well.  If you have
> > time send a patch!
> > 
> > Thanks,
> > 
> > Jonathan
> Sure, I have already done that, please see: [PATCH] checkpatch: don't flag
> ACQUIRE_ERR() assignments in if conditions

Hi Guixin,

I tried same about a year ago and it was not merged, find it here:

https://lore.kernel.org/linux-cxl/20250815010645.2980846-1-alison.schofield@intel.com/

Note that we in CXL land decided to keep using this syntax and ignore
those checkpatch 'suggestions'.

Send me link to your checkpatch patch (can't find it? ) and I will review it.

-- Alison

> 
> Best Regards,
> Guixin Liu
> 
