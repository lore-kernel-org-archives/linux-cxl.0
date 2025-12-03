Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE2213254;
	Wed,  3 Dec 2025 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764805618; cv=fail; b=raA665XNRcXcZQ7MvnDSgTUCXIDTyAaylGCZwnrEnnMSpBlE4UnavhFyfpxgINCURLplwnWjuqb3rKv8d1DXJdG+ElbPojX8tquvL0wXgx0G127wSej2kx+OU/QFu6jFYe21GmUfAwf0ncdsyUxEu40eQXz/PUIqC37cw16P9oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764805618; c=relaxed/simple;
	bh=pwq3RVu+Yyv/o1zIO3cHH4K2oSPtASF09lvaeJbs4L8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nStElVkrZAgwG/4FSwjgu7wxuSlI22nn6VCNMEIojtXYoJcuhK8z7qA93Q5Dz1MZZRdqM7aa+Qsid/gl7RQSjgKL7ZWzeAoNRGxzS6eE+9aFT6bNCAGkxJSGT38Lxm1EX1b0HULAkeJNXZYyBYEnruzJmO8IQWMG3cfa40cHjck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OW4cybQ7; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OW4cybQ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764805616; x=1796341616;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=pwq3RVu+Yyv/o1zIO3cHH4K2oSPtASF09lvaeJbs4L8=;
  b=OW4cybQ7guSWQob1Xu2gtS3foU1SU02h9GiMNHfUTa5I15rgtaFMMKfw
   W8lyphy02qEhOcDkJQunHGgkXahk4LEUpu3/yvEO3Pc1wSnUhRNGrdIF1
   2k2VGDr9sFdaFBEV9aZlkwqCYX+J8q6HxJTcZVo8Qcny5Ibywks6CtihT
   04/rjJZ5SQ0MY0c3CVpOM9SpeTvXBKIt+qOUTM2CzI9e7ut3TdJgsBuYY
   rfCje40mB5QO1XqcryGBu4jIk3Koro7TNllDz9MnxFYI5dI6Q0kfYlinT
   AkVSgLMYlEywAQ4akgHqANLm+7m/oldHqwLQk7qRSjRpIqPQxSMw2iy9d
   Q==;
X-CSE-ConnectionGUID: wv+QFuWZSu+siqC2+yI4uQ==
X-CSE-MsgGUID: WsKznwOJSS2xK0OxrV2yAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="69410219"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="69410219"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 15:46:55 -0800
X-CSE-ConnectionGUID: almmCjALTGO+QaQ4sYoDUQ==
X-CSE-MsgGUID: lNG8fmLKSkyZpZdF3akrgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="199961447"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 15:46:54 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 15:46:53 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 15:46:53 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 15:46:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9HdtJoS7frZazObcOpgXO3Zw56y8+4QXuxaJF7qqz0Y9yk+5OnsfyhEIlyoixjwoHVt808SYngvBGkv3mVNbYo9vYFLviw0CZLw4m3EwRjDNhVTQOYc9M0U2DnZrhwiF7GcpvEXSO62vuVLuTSIQ2dnQpahpxBtME+nEzxbHF4jjLUBFxD5Zlo5U2LzCDYaceLbClf2SBWRJo9XXqlJ1uCzAkigZmCvF7aYLp5rFZjUxJzYA3ZgGllII00AwNMF97DVF8L9LK6sAPZyq7gWAXT3dpina4f4zgYime3N5HyYkDw7IaH8zoibqXhG4V78/iYRnhN/8OyfS46R7qtqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heCeIjkZJLN63lEiGDqBvTmcUBPlZPp9jogYM9OMeQ4=;
 b=kQNl0JR1yqfZ9yjI7GtDqSYRDCpZECbHM+xkwGJKA28pa3GVlg4mnlGB1p0sxcR9rZ0W1Lk/fG/cAkMF0Z+DS33Ng/NcAih1peTsJ+7wHjMDopAQM1UVM4Ab/BKbS7MWOXc6lwNx6bdluhU1SCI9jAlUio2UoI6PPe+1zhEKfuga4D9v44TYUAQf0TRdv1qB7UFMxaQUZKzyWVieADudAt+3Vd8CEU0EgqNgGcqVN5zWwEJBIIe/fIiLTrtmRC33OGOOVhc4+RUpjiUuuKALK2U24EbFXtShUo+CoZeY1+bH9tY3sCtCdXklr2r8fYad+AJZnzSoF5zR+FXbMDkJkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PPF4C690C788.namprd11.prod.outlook.com (2603:10b6:f:fc00::f1f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 23:46:46 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 23:46:45 +0000
Date: Wed, 3 Dec 2025 15:46:37 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: =?utf-8?B?UGF3ZcWC?= Mielimonka <pawel.mielimonka@gmail.com>
CC: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>,
	<dan.j.williams@intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v1 2/2] cxl/cli: enforce HPA-descending teardown
 order for destroy-region
Message-ID: <aTDL3agcEsIl_Y0s@aschofie-mobl2.lan>
References: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
 <20251125143826.282312-3-pawel.mielimonka@fujitsu.com>
 <aS-5Zjhz-5Mkdqpy@aschofie-mobl2.lan>
 <360de9fe-75eb-4327-a35a-8811fa2d1201@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <360de9fe-75eb-4327-a35a-8811fa2d1201@gmail.com>
X-ClientProxiedBy: BYAPR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:74::29) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PPF4C690C788:EE_
X-MS-Office365-Filtering-Correlation-Id: efea4ea9-d1cf-45df-7260-08de32c637c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGdWQ3RHcFc0UGNDVmFka0VVT2dUNEpQem1VeFNpS1V4dDVQd1RtVUYybUV5?=
 =?utf-8?B?ZGQ4bWtiY0RZVkpKTFZCcitNcEVlbUVCc0QwU0tVdVBBaGxVeVB3WVU2WkRu?=
 =?utf-8?B?Z0dSa1BTMktIU2xpaXdwL3g2SDA5cmk4R3VUZDJUcHZDOXVLOEdDOGMxSUtU?=
 =?utf-8?B?WDRrTm83Wk5yYUJqWlRtK1VOWVgxU05sRG1MNHl4UCtmM2xXTjl2ajYxanJq?=
 =?utf-8?B?ZjBDckxLUGx0bkQrMEZCTnpNQThwdFJTSTVNODY2L2k1N1drUzlTTmZrc2o0?=
 =?utf-8?B?UjVuSXB0SzhCR2VvcnRvbVpxZ1Y1YVBVdzRBWGJnMUExRllQMUFuc091WWlh?=
 =?utf-8?B?UXZXbmhUYzJzajMrSHgwUUdNd0t6bGlFOGl4N1JWZWFaSUJ5aXpmc2tYRTlv?=
 =?utf-8?B?TTh6VHVyVlJkQXBmYTAzUlZzaTl0RkF0cTlXSHI5bEMvN0dwNFIzeVVzMFB1?=
 =?utf-8?B?MHZaTXp1UFhYdlJhNjNEY1RtUkFTd2tkeGhybjBGc1hTNnNhMEs3RXVKQ0VX?=
 =?utf-8?B?bXBSTEEvSVJGR0FHTlBXdGhhK05aNy84U0hrZU1tV1UyZG1Pcm9jeFZGSWlx?=
 =?utf-8?B?bHFHbE9RNU9OTU93MGV6SFgweFNUVmZ5bTAweFQ1SFpmTksyU3AvN05tK3lh?=
 =?utf-8?B?WTdZUzMrU3BVc3ROa2RvMkdDTHhSMjRSdjFONmdWVm0rdngyRVV0SU1TRzJr?=
 =?utf-8?B?WGhkTFE3cTBQR04rMCtRZXVCNjFOVUFYMFN0VlR0cmtyQ0JWd2htV1ZDRXlU?=
 =?utf-8?B?TDNJSXlrekhEYkltRHNsZkhGQUZwR3QrcEx5T2svenRTSGwvb0o0TGQyL2c5?=
 =?utf-8?B?eDhSY3JEb3I3VVdrL1lIN2oyRkM5WUtoM1U4cmxqdkNqczhKTWlnaW01S1NL?=
 =?utf-8?B?UUhEYzNaRHI3bmk0VlBLZzZRWU4zclFWSGdzOWIrYkpKdDE3TVJuTEFPRXF4?=
 =?utf-8?B?eS8zZkRpd1d0Wmx3SXplM0FaOVVKQzNhTmxvV1pYMzNWNG00RXZrZFpjNC81?=
 =?utf-8?B?VmR4Mkk5Ri9XOU5RTjREbnR4NUJNcWlpRHYwN21mSW1CS0R0NTVsQ1VNMTA2?=
 =?utf-8?B?ZjNZekJGTnlpV3BtcFBuMmFBa0d2THhLWUNON25JMXNSOXVtdVl0b0FlTnZ4?=
 =?utf-8?B?NjFIbXdMUVI2dWZHVENCUFoyRzdUaE52RHdXcmxWd3FqT2plWVovSEF3UURV?=
 =?utf-8?B?cm9hbERrT3pEUzQ1WUk4UmdWNzBzVkZMNFNhTzNFdkxmdEVNMk5TQ3F6cGxF?=
 =?utf-8?B?MXFYaC9rcy8wSng1bjZqbXZlbEJ4YWo3N1ZhTUNNY21tS1REbHA0RkZIWnNz?=
 =?utf-8?B?ODNlQzRvTmtJNUc1SjVLZTZ0OUtGZnFQUWdqblEwUmRvWVZGdnhLM2tMT0Q1?=
 =?utf-8?B?d2c0SFJyekw4QUJ1ZlVCb09ibWsxNU4rSWQ4KzFCS3htc1huVjk3VTVOUGEy?=
 =?utf-8?B?RGV0c2c5QnArbjVCYmlXbHJlSzNtcTFFa3A5QW9vUTVjdHA0NHd1Z2NITWFH?=
 =?utf-8?B?SVd2TzJTMmpoV3FUVE1uZHIvaG9JemprazY3MTdYTk8ydlBuNXJmYSt4QTUz?=
 =?utf-8?B?WHQvSk1XZTV1ZlpnclI1VHVOQWpFY3pDU3FnRUxHN3BUNnhiT0tzYURpKzJn?=
 =?utf-8?B?czZ4TjZuRXU2cE83ZFdPOXJ4VVh5cDE4ako3alNDaXFyT3RWTWVpL2Iyc2gx?=
 =?utf-8?B?SWJGUUtIUVhRT2t3VStoM1A5UWErTVVwQlNkUDNReElyN29IUXovbFJOM3A5?=
 =?utf-8?B?QXlnWVRLNldTSHRvdkM5ZTQ4aE5VY0dsWDVoWE40bTR2dkdSRHZpWE5WMi9k?=
 =?utf-8?B?WGxXVVhvRXpoUW5iYVM3Z3VGd1drZEluaVh3dEZqQVNONGlnMDRZdEVzY2lI?=
 =?utf-8?B?Y2ZLOW9KMllyQVRpSURHWFIvUUhCQlRFYVRSQmZKN2ZZcHlYTFNOUFFGSnc2?=
 =?utf-8?Q?9ydT6/438D7BRHG+skNlzo9ZYYrltFo+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0NIM2E3MFdLNXFMTzVxRWpoYWlkdFBQcTBSU0Qzd1RZdXZaaE4relVnWjh3?=
 =?utf-8?B?RkhBa0x6NlZQdVhrRk1mOGlvYUtjeTMwcnlqZVNrQXEwWCtuRGtLaGZtVHBV?=
 =?utf-8?B?Y2E1UUFhM1U5QmpVbVRqT05aWnFqQ2ZtbnhWbk92MTNqeWtJekFqbC9VN1Zh?=
 =?utf-8?B?RDVsa2Ntb3RtdG5oRGkzMUZwNDJ5NXpVenlTM29QalBDclNwVnhZZ3oxY2FY?=
 =?utf-8?B?ZE1RUndKMlVlSS8vdlUyOXF0d092eWNQTzZrZHF1VGF3WVpTY0RRV2xqTGtV?=
 =?utf-8?B?QitGZVVJSDhPVllIN2NRcmlnQU1SMnV6WGcxaGNyRFdscFhjMnJpdDZrelNT?=
 =?utf-8?B?OUZxWkdMZTlYY0V4d2Jsdjh2czV4VmtOY0NHdVh0RDJNeHl6NUNnSUIxc25F?=
 =?utf-8?B?OHR5MzliU1BQa2FReXUwai9TSk5CN1RMWWN0ZFg1NFNoS2hYU1NOZXlCMk1v?=
 =?utf-8?B?amhwNzEvTGZlcTVzT2libDZUUFZiZndsMDAxVkgrQ2dhMW5CNFlnVjFkWGNr?=
 =?utf-8?B?SHRTTzVhUEVZMjZ2cWVwanErZ2xlUzFNL0x0NW1tZzNZcFpNaXp0ODkvbGZu?=
 =?utf-8?B?T1prOWk0T1ovWCtmVlJsa2pwbFdlT1MxeVk0ZTZoU0tlUWRXdUxURHBJR214?=
 =?utf-8?B?SUtXY2l1ejgySkpQWWJSSnNaTms4MFBPa2lvQ1hSMGR6dVlzYUlyUGdiSXVK?=
 =?utf-8?B?M0FzMmdlWG83QnNKdXVWQWNDZGdWRFJoNzNSTmY4eitHcm00S3VQUDcxY3d3?=
 =?utf-8?B?Wmdub09oaGV0OUJrRE00TkR5dWFxTUZGbVkzZjNJVUNyZVRUUlpCVXdSUGxD?=
 =?utf-8?B?UUdOL2FMS2pSQU9mcUo5V3JqeUJiRVJLMURyMXpIdG1Ic3lrWVRHL0tkQkM0?=
 =?utf-8?B?V05zT1djdzBhTmJUL0NxYzlQcVdXNnplcktTRmtGcFVNVjNNSis1QkhzSXlz?=
 =?utf-8?B?UkY2TW93ZE1Idkpna1BJOWFCd2FiRXgvRENpWUk4SS9zMFEvZzFtRU9SQkJ1?=
 =?utf-8?B?amIrbWQ5UHFVYWpBbHVoZHppUENDSWJIQlVHWFpOdFlrUXg5UklKYjJHRTJF?=
 =?utf-8?B?OXZYRnhoRktCSm9objdRRWNXa0xkOU0vdGJCT3crOUZSRG5BN1liREtBR0xq?=
 =?utf-8?B?YTlxQncwVWxrV2RidjV4eTVhQXBkK3R0Q21xRzVrWkg2UkFHV1FoVm8rc1hP?=
 =?utf-8?B?T0VpNUhqeDEzR3JSbm53NG5CUUpKdGtSZFN0WFpIZGwreDFLUGNvNUI5V1JF?=
 =?utf-8?B?QndhUHdIZFo4Z0g2N043ckttQmhTaUdyU1ZRS2o4anI5b1RRQnMvb1BMeGJJ?=
 =?utf-8?B?MHJmSks4WStaT2g0M1Y1bWlPSWQ4dXgzamx6b0d2bDROTWZpWXR3RnhmM25E?=
 =?utf-8?B?TTFLanpVZFZIVXJrSm1YMzBOREZSSUFDRU54WExIMmpJWTFlMFdFTE1XSEpV?=
 =?utf-8?B?NXBlQVg5V1pkNjl2QmJNZDVPUCtKSm9LRXVjbWRPK2Z6V0xaYkdsOWJ2dmt6?=
 =?utf-8?B?UE9kVm83S05ocWpWOFd0Z0lRQjZMdFBOMGlML1pabmhNZDZLcUV0VnBMNUpZ?=
 =?utf-8?B?S2hoNDNFdzc2VE5Ua2VwUmtoMEEyQjJSMndRS3BVZHpJbWVUUUlwaHIxdUxI?=
 =?utf-8?B?cnRXRHJSdXh2Z3JLbjF2cEVKSUo4ZG0zTjJ2eTZETXdFQXJrNitVUWFkdHgv?=
 =?utf-8?B?QVA2ZXRtdDA4eG8zL0FjOERpQUljdWx1YzZGdU41d2Y3OXBDTk83clVpS2VI?=
 =?utf-8?B?V2Z6b1NnQWY5UmxjRzdxK3k4cmYzWENDZjFLRXFwS1d2ZHFnZDFsRDFra0FJ?=
 =?utf-8?B?OE12QjhFUDV2bDM0SElGa2ZkWDE3bE8zV1ZTcWhYbktqTVBwdzFReGZuUHZW?=
 =?utf-8?B?T1JUT1BSTFNPTkRxbEd2Z1VxVFZjMWYxenVqZ0NTR2habFgyWFgyM2RZbVJx?=
 =?utf-8?B?R0xnYXBQbXQ2UTZTNjducDdqdFB0bGVLN1I0TS9FMVZTamlSM0drcTdKL1JR?=
 =?utf-8?B?b3R2RVIwUlg1SHJ1ekUyZ0dZS09ITDRuNVQxNzRQdUlkaVZqcU9nYnZ6Z1BW?=
 =?utf-8?B?dm5BTndLZHpFaGpVNFpwVGJNM0tuQm1KeTgyNms5SkQyRkR4cnZtNGJBVU53?=
 =?utf-8?B?a2lZVkJ1azFJSXdkdXYvQmVxWU0xVXdxUWNkbFZsNkh4UzgwcER6MnBUT1hC?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efea4ea9-d1cf-45df-7260-08de32c637c2
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 23:46:45.5392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qr/6GQJkyQc7ubFXhxhlq0ISaC8QY8wVKSlC4lbcu2xKgkEtsAwCQ55LNA5rRD1gJ0m3dNhEk4B7vLut5JRJdhSk/Y2dcSvSuHBfbHlCP5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4C690C788
X-OriginatorOrg: intel.com

On Wed, Dec 03, 2025 at 11:13:10AM +0100, Paweł Mielimonka wrote:
> 
> W dniu 3.12.2025 o 05:15, Alison Schofield pisze:
> > On Tue, Nov 25, 2025 at 11:38:24PM +0900, Pawel Mielimonka wrote:
> > > Implement destroy_multiple_regions() and bypass the generic
> > > do_region_xable() path for ACTION_DESTROY. Regions are collected and
> > > sorted by HPA, then destroyed from highest to lowest, stopping at the
> > > first "matching after skipped" to provide user with better error log.
> > > This prevents attempts on non-last regions and aligns destroy-region
> > > with required decoder programming order.
> > It would be useful to add a sample bad spew or what happens now
> > on attempt to destroy out of order.  Folks sometimes search on
> > those strings.
> In all cases in which I reproduced this misbehavior, in log i could find:
> 
> "write(3</sys/devices/platform/ACPI0017:00/root0/port1/endpoint2/decoder2.0/dpa_size>,
> "0\n\0", 3) = -1 EBUSY (Device or resource busy)"
> 
> And the cli returned:
>

I think this string below is the one to add to the commit log:

> "cxl region: destroy_region: decoder 2.0: set_dpa_size failed: Device or
> resource busy"

snip

> 
> > 
> > > Signed-off-by: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
> > > ---
> > >   cxl/region.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > >   1 file changed, 57 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/cxl/region.c b/cxl/region.c
> > > index 58765b3d..1bf1901a 100644
> > > --- a/cxl/region.c
> > > +++ b/cxl/region.c
> > > @@ -950,6 +950,57 @@ static int destroy_region(struct cxl_region *region)
> > >   	return cxl_region_delete(region);
> > >   }
> > > +static int destroy_multiple_regions(struct parsed_params *p,
> > > +				 struct cxl_decoder *decoder,
> > > +				 int *count)
> > > +{
> > > +	struct cxl_region **list;
> > > +	int nr, rc, i;
> > > +	bool skipped = false;
> > > +
> > > +	rc = collect_regions_sorted(decoder, NULL, &list, &nr);
> > > +	if (rc) {
> > > +		log_err(&rl, "failed to allocate region list: %s\n", strerror(-rc));
> > > +		return rc;
> > > +	}
> > > +
> > > +	for (i = nr - 1; i >= 0; --i) {
> > > +		struct cxl_region *region = NULL;
> > > +
> > Here is where there is a difference btw 'all' and a decoder. 'All' gets
> > passed as an argument and the filter function recognizes it. But for the
> > by decoder option: "cxl destroy-region -f -d decoder0.2" argc=0 needs
> > special handling
> > 
> > Inserting this here worked for me:
> > +               /* If no region arguments provided, match all regions */
> > +               if (p->argc == 0)
> > +                       region = list[i];
> > +
> > 
> > Then with argc == 0 this next loop is a no-op but that is OK because
> > region is now assigned.
> Thanks for the suggestion.
> 
> According to the manual, "cxl destroy-region -f -d decoder0.2" is not a
> valid CLI invocation — a region number (or "all") is required:
> 
>     SYNOPSIS
>         cxl destroy-region <region> [<options>]
> 
> So the case you describe would normally be written as
> "cxl destroy-region all -f -d decoder0.2". If we want to accept the case
> where no region argument is provided, it feels like this should be
> handled earlier during parsing and the documentation should explicitly
> state that "all" is assumed when <region> is omitted.
> 
> Given the current docs, I would lean towards reporting an error when
> p->argc == 0, unless we decide to update the documentation to permit the
> implicit "all" behavior.

I thought I was being intuitive, ie specific regions plus a filter seems
redundant. Thanks for clearing that up. I agree w you that it should stay
as defined. It's a bit out of scope, but if you can fix up the parsing to
fail with a clear message when the required param is missing that would be
nice.

> 
> I've also tested various cases with explicit region arguments, e.g.
> "cxl destroy-region 1 2 3" with regions 0..7 present, and those paths
> behave correctly.

Great!

> 
> Happy to adjust in whichever direction makes the most sense.
> > 
> > > +		for (int j = 0; j < p->argc; j++) {
> > > +			region = util_cxl_region_filter(list[i], p->argv[j]);
> > > +			if (region)
> > > +				break;
> > > +		}
> > > +
> > > +		if (!region) {
> > > +			skipped = true;
> > > +			continue;
> > > +		}
> > > +
> > > +		/* if current region matches filter, but previous didn't, destroying would
> > > +		 * result in breaking HPA continuity
> > > +		 */
> > Use kernel comment style. See other samples in this file.
> > 
> > 
> > > +		if (skipped) {
> > > +			log_err(&rl, "failed to destroy %s: not a valid HPA suffix under %s\n",
> > I'm not familiar w the usage of 'suffix' in this context.
> > How about replace "not a valid HPA suffix under"
> > with "out of order decoder reset"
> I intended it to mean "the last region in HPA order". Your wording is
> clearer,
> so I'll adopt your suggestion in v2.
> > 
> > > +				cxl_region_get_devname(region),
> > > +				cxl_decoder_get_devname(decoder));
> > > +			rc = -EINVAL;
> > > +			break;
> > > +		}
> > > +
> > > +		rc = destroy_region(region);
> > > +		if (rc) {
> > > +			log_err(&rl, "%s: failed: %s\n",
> > > +				cxl_region_get_devname(region), strerror(-rc));
> > > +			break;
> > > +		}
> > > +		++(*count);
> > > +	}
> > > +	free(list);
> > > +	return rc;
> > > +}
> > > +
> > >   static int do_region_xable(struct cxl_region *region, enum region_actions action)
> > >   {
> > >   	switch (action) {
> > > @@ -957,8 +1008,6 @@ static int do_region_xable(struct cxl_region *region, enum region_actions action
> > >   		return cxl_region_enable(region);
> > >   	case ACTION_DISABLE:
> > >   		return disable_region(region);
> > > -	case ACTION_DESTROY:
> > > -		return destroy_region(region);
> > >   	default:
> > >   		return -EINVAL;
> > >   	}
> > > @@ -1026,7 +1075,12 @@ static int region_action(int argc, const char **argv, struct cxl_ctx *ctx,
> > >   			if (!util_cxl_decoder_filter(decoder,
> > >   						     param.root_decoder))
> > >   				continue;
> > > -			rc = decoder_region_action(p, decoder, action, count);
> > > +
> > > +			if (action == ACTION_DESTROY)
> > > +				rc = destroy_multiple_regions(p, decoder, count);
> > > +			else
> > > +				rc = decoder_region_action(p, decoder, action, count);
> > > +
> > >   			if (rc)
> > >   				err_rc = rc;
> > >   		}
> > > -- 
> > > 2.45.1.windows.1
> > > 
