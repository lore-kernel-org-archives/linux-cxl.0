Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E333518A6D4;
	Wed, 21 Jan 2026 00:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955764; cv=fail; b=IbdXtWCWZGA66R4kicchSK4J2WhvNxIXTBvs3yRDnhOxUmEVIhvFUlhvUmR0VDauBUE8ozQRJXsc9j+TUyLZUYNm8p/l2V7z0IcCO60PomCypnMbvnDfHHc9h8suj9PQFWGeNbCSf8mg9TdCjz5/blLlS3nUo9G/+517ZWPT3go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955764; c=relaxed/simple;
	bh=HkBywtiOKz4vd0AzK0r1IKYaleHbxQRWzr5zj2wIWsE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=LowENSu0CIFneuCE0IwLTc9zd21QE+q3t1VIFvnE3sWML+uSuxYLvi7LIpNXe3AZ48JKaQt9BXCaX4rX/XR+n2Gt0CezjTL+lkTo5JEn9KenYNb+mLwVI5fRqA/UrmoDtqWm0CFcNwfmI89X6GV7opzq3R+UKSUyScYMJh1Iaag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PnQDJSh5; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PnQDJSh5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768955763; x=1800491763;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=HkBywtiOKz4vd0AzK0r1IKYaleHbxQRWzr5zj2wIWsE=;
  b=PnQDJSh5p+NECi+T114/uJAZ6GrVyEOUdQa36AZk+KPNctOwrWZUvIRn
   9X67GE2tcT3guF1WYNlmnppHzjlnVMheNMlgcqz30sr4kl8b1WOcy2Pq0
   dONB38KEyrVMLpYqnYgcI19+9lQ9y5+Mtf39YYVtq6rSXok1YnFT1F28L
   bclEs6xBABE8IOaaoEgD/FvEsNmf1QjjOhcu6AYLQLgqLh4RDqehYOknS
   ydocZtbWKTjQmDN0kGBqsR7kDebOvfR+WFKpYSj18txbpdXs/go/68T+w
   7mBlQJWqdEQxcfHkVSDtcNNW5+YDzmW5urcM6zlbxC0MYVW/Jtg0c8iVl
   Q==;
X-CSE-ConnectionGUID: w/t5olo5T8ixncwTcjYXwQ==
X-CSE-MsgGUID: H20liLNZQwCClfBl0qmR8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="73806028"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="73806028"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 16:36:02 -0800
X-CSE-ConnectionGUID: 8Jt/0TkNQMW06vFr4jxPRw==
X-CSE-MsgGUID: KcKA1dPDQBehZBlko/IiIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="229232940"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 16:36:02 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 16:36:01 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 16:36:01 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 16:36:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XraXttm0nh1u5bjI1b6Jkhqu+6Oq6OfueKHPFReOYbg5/fQK2d73SidyZc0WCi+8SznhGsJDsavDCnCyRIWF2vVnibOR2onio+39zuMKQWFb4U4wf8oVF61nz4CEYPcWKjoqrKaUIysEX+RUZvwLzHE8L/eG37gZznBfIgy4uJgs/xjxTZDFbY6XMMHXDBuy8kqrctE3r0M5fnSRMF7Y82qyi1rF/5Ovbmgs/i7GojOmtj8KoJdYADTVSPjiSq6jUJ+gJdZjVoQgcz4H6J5LaDdVJvqcQ689zsIVOed+vhdrHxfQMSXJJCNYFCHaEI3fd/7dm9JmJQK4RyEuXxEH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfxW4Tn7H1n9yCcNVco+Pot0c8T1jfuDi2osk5d04jk=;
 b=WrvM/Q7Z7yXHcvd78ec0Da0zzzHPNSQQ4s6acdzJs19WIcLPuzqlEUUZaI2Ec73ywlqiRGdKz2YpIDa1h4NMJLw1YSQ2ytoKRkRokcfJOwNnybThGL0pYG/TEP0XbH6RohUmZXSvkPR+3XkZZvSm3Lr4pr+1FkZrVnAi/iTKhbIj/JCulkaLERXiuQSIw1FnBJAweiL4kEvao1MEPN5egh28DTYb/OfaRi0HGpA0PnmPWq9h6r4qFABBGGdkRtxigRRD7PuWjA4PJAKAllcm8F45lOII/5kdSiGYGfpmU6TL8W9+hsD5NszyIs9xJl8qGOPLnjVhD/hoKoDKMHdYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7329.namprd11.prod.outlook.com (2603:10b6:208:437::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 00:35:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9520.005; Wed, 21 Jan 2026
 00:35:58 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 20 Jan 2026 16:35:57 -0800
To: Yazen Ghannam <yazen.ghannam@amd.com>, Robert Richter <rrichter@amd.com>
CC: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ard Biesheuvel
	<ardb@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, "Borislav
 Petkov" <bp@alien8.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"John Allen" <john.allen@amd.com>
Message-ID: <69701f6de978_1d6f1001e@dwillia2-mobl4.notmuch>
In-Reply-To: <20260119160342.GA659351@yaz-khff2.amd.com>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-11-rrichter@amd.com>
 <CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com>
 <aWehZwXsK1IXRNU2@rric.localdomain>
 <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
 <20260114180859.00004623@huawei.com>
 <20260115080444.GD830755@noisy.programming.kicks-ass.net>
 <CAMj1kXENYZq-UkCup6FSH_4tmpRe4xJN1_veuSWs-hxxAo=1Ew@mail.gmail.com>
 <20260116143838.GC1890602@noisy.programming.kicks-ass.net>
 <aW5AvfcjLkSP2j42@rric.localdomain>
 <20260119160342.GA659351@yaz-khff2.amd.com>
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:40::41) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a233fb-a04c-48db-b0b5-08de58850bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUxWY01VQmZYN2w2cEQyNWpSK2lRVUVqSnJocDhoc2dCREgwTzVVNW1sWFhm?=
 =?utf-8?B?VWVPYis3Z3hOdWhidFphZ3A2WWRtUTdjOVRDUGd1d3QxZ29DMFc0VDNreWxu?=
 =?utf-8?B?QjVSa1FjQlBnKzRmb2dWUHc1Wncxc2xsQndOblRvVlJvM1NRcTUrVFRKNFNS?=
 =?utf-8?B?WFQxUzRHcWlVNFdGNkRjdWJYelA1S2xtdDZocDRwQTRBVlIxeEFPclVxYWNa?=
 =?utf-8?B?UmtQV0doYkZuejd5NkhmTVN5U2lkUkt0dGtqem51SVliUXM1ODFOY0E2dWh0?=
 =?utf-8?B?eWJMRkRkd1U0ZWp5U0VpdFVLd0NjSmdZNm0yZm52bTlkOVNtcW45Z21iMk81?=
 =?utf-8?B?Y0tRSU5oVzd0dXNra3dPN01RR3NPUVJkclMzNkxQZ2dhckMwNDhDRkc5aitC?=
 =?utf-8?B?VXBkbFV0SG04OXo4dWlBa1hFdDh0Ky9hRWdtUVdwZ0czaVVzVUUyZUdmRnda?=
 =?utf-8?B?UlpINjYxVm12eWUvajBlVm1ONGl5UmNFZlRQc0VIN2hDclc4bXBZbWhTS3lP?=
 =?utf-8?B?ajJ4NXJvNWkvc3FGTHNGS2lTbll0L1RlUlg1dkFMZnU1OFUvZmhZUThQb3du?=
 =?utf-8?B?MmZRdk1WTTIvY1BDRUYveHJURitoNlZDMW5iRGlZL1lpMlpxL1l0bEU3VFQx?=
 =?utf-8?B?eGRTdVB3N0NyT242YnNtNURkVmFVVnB5Z0s4Unp2aEFtT3FnRHpKT2hqL0k2?=
 =?utf-8?B?SE9NU0p0U1VKWExqOXhEa2pmS2hlZUNMSEkxbjdCQ2NMRG1zS2tXaVZKQVdk?=
 =?utf-8?B?Q3ROWTIrRzJ1YVdic3lyUUV5RCtkeEIxYldpMmZZanU2UGd6VWVrcWRuenZE?=
 =?utf-8?B?TzFDbm4rYmRla0ZIWUlXOUJESG5maFVJZWQ0UVVXdmJiTWxTcDMwRVRodlJl?=
 =?utf-8?B?WlVuTmpyb2R5WlZnN09qVTNLc20raFBwdlArRTVWbnFPeVpvSTUxQk5iWTFW?=
 =?utf-8?B?TlR6dE1lenlYTFNkQlhaSndMRzdjQjhwYksrM1JNWkR2OVZHWkp1UlhaVVhT?=
 =?utf-8?B?MjFOS3A3b0FJbWJTVk5udDViVGRMc0hUKzZDTm5ZVDA4MjlrcGx3bzlBZEdH?=
 =?utf-8?B?TURNWGkxcnBjNlBLeXVBa2l3MVpkOW9ueGRwSlR1VG92Uk0vNFV5S1N5U2dK?=
 =?utf-8?B?a2hyRDJYQ21MVmJQdVh1Qm1XbGFFL1gxdGMwdVd0NHQ4TEZTS3dHSnhDRERo?=
 =?utf-8?B?ZVVlL3dYdytYdm1zYkxUYm45RjRLVHFNWHBNVmZod0lTZ0IrZzAvTjVtT0Nn?=
 =?utf-8?B?VkMycWVHNWozVDlUNXBPbFJBc3BBMUhEK1ZkdFFvZGhFaEVzSGd2aUpwalMv?=
 =?utf-8?B?S1NvTUpCUkx5SGpxWWdtMGpFaGJHcWFuRStEbk5ZdzhRZ2JkaTZmdEVhd3pO?=
 =?utf-8?B?aS93ell6SWdEZkEwZDRzMUd6bHI0c1VIZzVaUFU3R2ljNU9Ua1dSU2pBN3Y2?=
 =?utf-8?B?SE9OQnZnTExHb1hHYlhVTHYzbnpzaVRQV3I3dGZ2dXU0eVhBSERTOHoxMXJK?=
 =?utf-8?B?RVdaVEFIbGl5eitYQnEyRzJ6MmNPV1ZwdlJMSTBsNkRqV2JDSzJwenRUQ3JB?=
 =?utf-8?B?YVNVZythRFhjNENKMzJwOGlvcTdkR0V5YUExRzBRVzF0dDhHeGRhWGJqZjJ3?=
 =?utf-8?B?NjJDdVVBTjY2SlFTTUVmcTBJNk5Yd044a094TVBRYm1sYnpLalA4WVRpTFFO?=
 =?utf-8?B?SXpqVHJJK0V3QThIRTJsV3VhVTd2VWUra0hWclFpdXI2UW5qZGtReFdISzVs?=
 =?utf-8?B?dmJBaDM0QjMvRkN1OXhPNWRTT1pBcDFKc3RjYUpmUTFOcHdWbXRMTVZNRlVu?=
 =?utf-8?B?a2oyVVBQeGxFMk5Ib2VMOFUvM3djQlNkYUxtSkxSRVZsaVFaZTlmM2VyUWtk?=
 =?utf-8?B?S21LNWZ4MUg1OGRSY3VHcUUzMDIzVzVZelAvajZQeE1EL2FNNSt6RGV4MUps?=
 =?utf-8?B?K2tyNHRsR05BSGpUaWJuRHh5d1IyL2IyMUlRdXRSa05DZ2FzTXE5bllBOHdq?=
 =?utf-8?B?ODV6VnVydmxkdGkxUXRNUWtGK1RTSFNzK0kxSGFRNTU1MmM2cngyVUJ2bTFN?=
 =?utf-8?B?TlNWQklVSkFLQ3lub25kL3lNZEE1ZC9Pb0k2T1BXREhXeXJlR283TXAwOUlk?=
 =?utf-8?Q?MvlQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWd2RGx5YnNpbjc5R29ld0k4SHdVRjZ6bThhajI0UFMxamsrbGNCZDdUUDJS?=
 =?utf-8?B?cjY5WVUrVFd2c3BSSEZCdTZiWXdrTy9acmRkYnZXYlU3Z2VoZkl5ZjRMNy9o?=
 =?utf-8?B?SjFFMHp0NXlkZEdLbkt5QW4zWjY4OG5zUEhzS3Byc08xWXN4bld5YXQ0SG1v?=
 =?utf-8?B?Q1hCZ0VON3dtUVU4SmNNYVZPaW5nVGFnWWxQQWlnZVRIdzk4SWRCZURscS95?=
 =?utf-8?B?aEx5ODVOMTh2cXY1QVlsLzdYZk5WeHdMOFkvcGdOMFBHc1JPd00yZVpKVWZC?=
 =?utf-8?B?ZkJweFpxU1pxVnhwTHVLT3UwWGtmNU5xdFRTa2VMZGNENTVaSE00UXhMd2Q1?=
 =?utf-8?B?RSs3QzBQRU8wSVpQS01qVnU5WWJ6OWRFOWhHUkkyVkpqK2dUbFJ1SGp5Ylhn?=
 =?utf-8?B?dWtpY0Y3aFV1QlRteGFWWjFxY1VUWEpyU2lDb3JaZFEzYXlBWURvWWp0NGZ2?=
 =?utf-8?B?dmQ3R09ORm5ESkVVUDdpNU5IeTRLa0tLL1BwS0s1ZEM1Q2hJY1d1OE1vRDdn?=
 =?utf-8?B?N3Bjc1NoeUZ6eDhxN3pqZFRCYnl1WS9vODV1SkwzYTdBejFaY0xJNEpERXZ3?=
 =?utf-8?B?RzFJMnN5b01iODJFWEdqZ0ZjbTEvNDhqc1Q0WG1mVXg0d3R1azB4QlBZWkxY?=
 =?utf-8?B?QTZyS1lIVlhEWFArcU5kVkNIM2xpMDJHUnJGV2U5M1VRVEZqdzd0M3g3Ly9T?=
 =?utf-8?B?OFJrTDdobGdsZENtb0ltK09ZSkVNc3k2WCtTdko3c040UVhPS0dYRVl4RjNj?=
 =?utf-8?B?d1lGQlN2YXF3WGltOEhGSVdPQ2NhNDJ5NUhoV2UwdjcwUmMxK0ozUzNqT3hq?=
 =?utf-8?B?Z0dVbWFiVHRuclpIS3RMZkJyNzBCbUdkNjBNSXFXd1Vwanc5SWp2QWw4bHNi?=
 =?utf-8?B?SExZbzd5Q0ttQTJmYmdOVjZOaDA4Ui9xVGYxMUdIOXRVODdJbkhKM1g2L21p?=
 =?utf-8?B?UnRiZDVSbnlPY3FDMFRnem9GeGF5Nm1xWUpUaFpIbmN4NjlteTA2aEVKQWVz?=
 =?utf-8?B?eVZnSUVqYXowbHBreE5DZzVZUlJrNXpLMTdSem9VSzRJdlFCcXhZNFRaNGVP?=
 =?utf-8?B?cFppay85djd4ZGt6Qnc3bXJOREtvUzA3ZWh4dDJ6eThmNHhVRUNSb1FDYVMx?=
 =?utf-8?B?VlZVaFNCeDFBTWFkbnAyYmJDdWFublRVdjg2NjBtWkM4WVd5dFBzN0I3aEtW?=
 =?utf-8?B?QjcwYnZTcisrQlVETGdINTMweVlMVXpwSEhtUzhHVlIvQUVqeUZRWXVrdGRG?=
 =?utf-8?B?V08rSTMwTFJlTUtSRUZwVndRTWF0SWY4RW0yeXRwSDNvbEdDV1g0RkczRFIv?=
 =?utf-8?B?ejhTTjNhRmg5ZER3eWw3WDVFcWFCdlhpbGI2Njg2NkFRUE0rVlEwWlpHMXF5?=
 =?utf-8?B?YWhvWCtxdkR5bjRFUkFPT2VHVlVyRjB6WkhJRVRJd1RTdjZ1b3V2VUFTVlQ2?=
 =?utf-8?B?Wm5nNlpTSTlaTHprMEU2MWdNTVNBQkNQUmNiSnFnMzJrdWxET2xEb2lEQi9q?=
 =?utf-8?B?QlZVVUJqdmFQNzdEYzgrT3hYZGtteGNaWTlLY1ZBMzBlTzhPMFNBVTZmKzZ2?=
 =?utf-8?B?K2FDL2tWZDN5aGlFNHN1MlFzQkdXd01acXArdnRtL2hwamUyZXdsYzZabVU5?=
 =?utf-8?B?S2U4RVBTaHBtVzJHZktsbXBlcjZEbzJRSUhPNnJaTTRSVHhmTkRrTEZPUnV6?=
 =?utf-8?B?eFE4ak9laDBaM1UraTdwTHNOb0ZrZklCZG5SUCs5TnNEVkdTQ0pLTW9JZTBL?=
 =?utf-8?B?Z3BFSURyRFpvRDkySHRLU3RyQTFnUmtQMWVJaloyYndiWTNDTjh4aGlpNk85?=
 =?utf-8?B?Y1RjbUR2MXNzc0hLQWlzUVI3RHpMYmxsakdWYTRUZWJvK2FLdldyNjlzNzh4?=
 =?utf-8?B?MmZ4N1Y2Q1drZVBWNEhXUFpoTi9ISkNiYjJyWHdJQWdkcjYvRG1CNHk2LzYx?=
 =?utf-8?B?Mm52Qm1qRlpJTjhUNU4wOWZzN1BZZjNzZEpKYU5GN1BPUlpWaWtaK3pQSjR5?=
 =?utf-8?B?aDUvQ3NGQk9KK0F4S1pzSzU3Tkt4Szg0cHl4cURDMGFrNG56OVQ1cEY2d2h3?=
 =?utf-8?B?WFg2RGQ1MHBCMk85MnpvWSt3YVhpMjdQdWYzTCtMdUR3Zzh5MmZPYTBMdlNr?=
 =?utf-8?B?UXMvb3cwOU9Sbm1GZkR3UHBqWFVBSUFxL1JsWm4xLy9xVjJ0UmxKRlZRRnUz?=
 =?utf-8?B?ZnFHUm9FSFRydjhZZmk3TjMvWlI5N1J2bkUzc3NNUkcvYnhHMmxwTkdkZ05t?=
 =?utf-8?B?NEF4SGdMSjIwaDNUcEQzUE44enVNaDVLVHhRVGFXREgrSDdsRU9Od0J6R2JM?=
 =?utf-8?B?WWl4UEkwdkJ1cnEwMUk4ZDhndzlIZDh5akJsbFliK0RyNUxkcU84eDJ6b3BV?=
 =?utf-8?Q?MQKAhXMb3a0imXMw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a233fb-a04c-48db-b0b5-08de58850bd1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 00:35:58.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqNzoygzy7sBt3JuD2J+/5Hk+tNsmFKH7QqlC1jgbHwvVKV8A0VlPut7DjEcgXHIODWrGWfsXMcO6czKZNPP04/vcMgzn8zeleqgSsbvzTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7329
X-OriginatorOrg: intel.com

Yazen Ghannam wrote:
[..]
> Additionally, the same translation code can be used in multiple places
> (tools, FW, kernel, etc.). Most consumers treat the code like a library
> that they include. It's coded once and bugs can be fixed in one place.
> 
> However, with a native kernel driver, we have to re-write everything to
> match coding style, licensing, etc.
> 
> Also, new hardware may need changes to the code (sometimes major). So
> there's upstream work, backporting (more testing), and so on.
> 
> See the AMD Address Translation Library at drivers/ras/amd/atl/.

There is more nuance here.

There are indeed cases where there are high degrees of non-architectural
details in flux from one product to the next. For example, the details
that EDAC no longer needs to chase because the ADXL DSM exists are a
solution to the problem of shifting and complicated memory topology
details.

CXL is a standard that this architecture at issue decided to inject
software-model-destroying artificats like CXL-endpoint-HPA to
CXL-Host-Bridge-SPA (Normalized Addressing) translation.

A Normalized Address looks like a static offset per host bridge, not a
method call round trip to a runtime firmware service.

Note that there are other platforms that break basic HPA-to-SPA
assumptions, but those have been handled with native driver support via
XOR interleave, and non-CXL-Host-Bridge target updates to the
ACPI.CEDT.CFMWS table.

> > > Worse, you might have to deal with various incompatible buggy PRM
> > > versions because BIOS :/
> > 
> > The address translation functions are straight forward. I haven't
> > experienced any issues here. If there would be any, this will be
> > solvable, e.g. by requiring a specific minimum version or uuid to run
> > PRM.
> > 
> 
> This is a good point, and I've brought this up with some of my
> colleagues.

The more that software bugs leak into this interface requiring
consideration of versions and the like, the louder the requests for
"please move this to a driver" will become.

> The PRM methods are supposed to be able to be updated at runtime by the
> OS. We could think of this as a similar flow to microcode.

No, at the point where runtime updates are needed outside of a BIOS
update we have crossed the threshold into Linux actively taking on new
maintenance burden to enable hardware platforms to avoid the discipline
of architectural solutions.

Microcode is a confined solution space. PRM is unbounded.

Now, stepping back, this specific Zen5 support has been a long time
coming. Specifically, there are shipping platforms where Linux is unable
to use any of its CXL RAS support because it gets tripped up on this
fundamental step. I would like to see exact details on what this PRM
handler is doing so that we, linux-cxl community, can make a
determination about:

    "yes this algorithm is so tiny and static, PRM not indicated"

    "no, this is complicated and guaranteed to keep shifting product to
     product, Linux is better off with a PRM helper"

...but still merge this PRM call, regardless of the determination. Put
the next potential use of PRM on notice that native drivers are required
outside of meeting the "complicated + shifting" criteria that indicate
PRM.
