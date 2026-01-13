Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A90C2EBDFD;
	Tue, 13 Jan 2026 04:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768278724; cv=fail; b=Wm30fEskZaO1jflzB+aPBtiTUHJexkRi4KpoY6zSBnqvTYKzdwHDEDkOA1kxPJx9UeJuF3M/Zvt+sPk7v0XqcUsHngrffFKGFAA+qsa0RBqNOYV21gbOABR9jZO0qcPIQhU4gnKGbH7ONub0lBHzDwE8bLdOZVleB5HoMVjTH8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768278724; c=relaxed/simple;
	bh=jdqz00Yf5TYuNcEKR1LqEoI834TATxtHPH2hGUaDkRI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=PlrDLxDz3t55IdY+vNlLb2fOxEOKW8s09YpMCaztqBaN8F+xAHMJNEjDknna/s4NP3CLagq/EM5FrrWZFkiTVg/JdHvX6jGglUXUjcri05rsSem8bCtZLharcDx8WkEgZRCl/A4zyYWFu1y7FJwG+cfpxTuxgrNHFFpa1waV0qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WomicaUI; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WomicaUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768278722; x=1799814722;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=jdqz00Yf5TYuNcEKR1LqEoI834TATxtHPH2hGUaDkRI=;
  b=WomicaUIVmTl6X2k0eU3792/Y07srdxHFrGygPBi1QFXhkASWR9Z0bxv
   XHwRKiRnm6u86UmXfYTmp3B+92MgmlFxhD+dBsMxr7VfZRw6v/ppSvtAE
   nrLPbAMfTD5UjkUgecTOkwVP6j+goi2sGiXuQK8ok9rghG0XDXj5BuyhX
   9YnQILPw73aSLq5L5H8L1m67hAVj68DhdymavD2GkL0c1m2ngsebIYABr
   4hgg8Dj5/O8tB/mNA7x41s0tQe1Cr2KUxgeX+kLAFk7zb+bJs142GayR3
   fi+i07H2swRQRLYE/pdIY99qozzx4ii1UNNWi0wwbSA5G/Svt5g13lgze
   A==;
X-CSE-ConnectionGUID: cG1Mjz7yTq6c9Axr41/UEA==
X-CSE-MsgGUID: pxlS5yBwQkW8GDNFGnan6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="80923305"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="80923305"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 20:32:02 -0800
X-CSE-ConnectionGUID: kxGGkoHSSJy3AKKTtr8yyg==
X-CSE-MsgGUID: 0e6NLPqoQ5KTBS4TRVkjWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="209340618"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 20:32:02 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 20:32:01 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 20:32:01 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 20:32:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1GYSWLUpdrvAnOHHj27twkBqsH6gskz2a1syLVyvGgCWtvE6+NkvmYFtY4IzAMt/fuIjp8ddTyrEqDMq1MVmGr3iQty2Kmj01vZNEBBhyF9nXowAFluSYkHDgpY67Gqd1ztdCWo9xpHupAGDrr6Lh0X4nn7yWxXxK21hMpYrNCa4scmImmYlPnishYTGF54R77PdUVIOY94EKYxDY763A/lM6mJMYQpNwZgRVzwcUsMwKiEsBAz6EQHXIOHhgG79HV0GfvoHwLkSM8k78pdfqgVRD39IjpuU+5YZPBidBaVanEJYjdNgNDdTwEkuPlTbrD1a8bRPUMqeelMfYbZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yi3TxmJuY556pSdhvU8/45YdLFdFVFalX+1yTLlACCo=;
 b=Bilr01WVWt1BgTAFDnSMvY4ljfJAx/AEOK9/FEOTP0a3xWLn/zeSE0HkGkm47rpsxNk/pOckL4Rh4yszzKSm4AOx70PFNmXuEzSMkobxfhUDVB4gM9N6mbniBwEt+DN6ZBb2LbqUWUfmVpnYS5dCL/4Vm5Fmh2uwRNm5gV3qCG5Pt7o50S+uBxvzlJa7tNiznUJa4D/j8qFhiMBRzzp7qqG9wk3gwLefcYikPx91/3mCF3buMiExNc7pjp2bOoSDkk/VsHGSorg/5h5bjmHVNHypvvu8RYVs2Bqufe6+j2+6pQP65YJxtissfrz2fkdNEBNgjY8RAcEJYoqfr+vNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7775.namprd11.prod.outlook.com (2603:10b6:208:3f3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 04:31:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 04:31:58 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 12 Jan 2026 20:31:56 -0800
To: Gregory Price <gourry@gourry.net>, "Cheatham, Benjamin"
	<benjamin.cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dan.j.williams@intel.com>
Message-ID: <6965cabc68fda_875d100c0@dwillia2-mobl4.notmuch>
In-Reply-To: <aWV-H_YbSrmgAZYd@gourry-fedora-PF4VCD3F>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-5-gourry@gourry.net>
 <05591180-c299-42e1-b8a0-ddd74c5f2174@amd.com>
 <aWV-H_YbSrmgAZYd@gourry-fedora-PF4VCD3F>
Subject: Re: [PATCH 4/6] cxl: add CONFIG_CXL_REGION_CTRL_AUTO_* build config
 options
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f4f9a8-e2f1-4f1f-d0f3-08de525cb010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVBFcVhIeDY5cWE0cERRd1lOMmFXUVRyUlgzMDhpdlpuRWhqRGhmNVZmbTNq?=
 =?utf-8?B?UU1GWWpKR2xBUEgzTjNybzI3cG9KRVlSTzdNd2NWT3krMTZqeEJiZ3BzdHBz?=
 =?utf-8?B?SHNha0dYVEpuSXFNTlg5SFNiKzFGeTZ5NlpnTU8xMElzMGhJMHQrMXJ5d0VU?=
 =?utf-8?B?bFZzR0FBYjlWMElJZ2tpNElxdk5GZkp3WjFQWFZHdDRCRFp5blVldEhGaXho?=
 =?utf-8?B?SzFGbGVaZTNSMHRhT1c5K0c1WTVUTnQ4UjV5ZHlPQkg2MWN2Q2E1eGxSRmUy?=
 =?utf-8?B?ZmhvZkE0Yktldm1EU1lXU1VNcFhiWG1BcU9xeC9ORzNuYWVqcmFhMW80dE5h?=
 =?utf-8?B?Mkw5WkUxaC9GalRrblN4ZHB1dmRjOGVWM3ZHaVd2NTczQWxjWXVzMnJnZFZj?=
 =?utf-8?B?bFhtZTh5UWtXeVJucGg4aTFweU02L0hFVW9zam5qbmtLbnFmbUpsZ0dnMHV0?=
 =?utf-8?B?YUVmaC83TnllUm0rSTBDOWV4OEtUbkJDbTNGUWJCZGZMSTFEN3lOdGxvVzNk?=
 =?utf-8?B?ZXhIbEZJRVRaTmRxSk5MdlBpTWF1UGJMWDVTQ2VoaUtMQmJTd0VVUGJlaGF0?=
 =?utf-8?B?NVlxSlkwNFVHb3NZcXhmZ2owaCsvNGhKeDF1UmdhSm05Z2o0M3FzWnZMNFJt?=
 =?utf-8?B?OGM1NC8vQmxTRjd3b0tRQnVTL25PclpnejlIbDdwTGZiQUNhT3NiRUhWWDUv?=
 =?utf-8?B?aDc4cnlNSURQdEJPRU4zb1hTNFlxWVNNU2szT0hvdWdNMzNjTGhLNk9UOEJO?=
 =?utf-8?B?b2lGN3Z0NVhWVzN0Y1dhTDA1bXpoR1BhM0JBZEhMZHgzaDB2c1ZqdFJINHA2?=
 =?utf-8?B?S0MxYlZNZTB3OUFxSGY5WHJQSXdzYXlRRXRtMTFxcVpEcEVRV3JBRTd4alBr?=
 =?utf-8?B?bmpnMDExaFdKRmJ5M2srRzB6R0RSckdmaXlPTEtRWURBODlaM1hSL0RQY1Q4?=
 =?utf-8?B?Z0t3T3dHcWhDSDZvdEppLzhhbCs3OE5sb1k4RUZVd3NORHlkdWpNZGFYSmJr?=
 =?utf-8?B?b3Y1N25hOW5vc29nLys3SkM2aE5CZjlFRDJUMmJaTmlwVmhySzZ5bkxPZ1hR?=
 =?utf-8?B?N2FYR2xCc3NpdCttSU9lMm00YnNOSG5tb2wwQ1AvclVXNWdGNFY1Zk9DWHJW?=
 =?utf-8?B?T3k5OHJEUG11YXhENDNMR0tSamI3dnNBWk1wNkFjUk1iM2hsTkNGbjkvRFN0?=
 =?utf-8?B?SlZmOEdhUTZ5NmhYNjN6Mk9NYmtNTGZuQkF5M01ROTFjVGd1MXgvdnFEMDVq?=
 =?utf-8?B?N2hNS0VOaVIvcWE4YU1mdWVKdXBWc0JwWDUrQUl4YVhVY0hCUTFVaEpqR0ZU?=
 =?utf-8?B?N0RwTUlxM2FYZkFXclRBSTBIODdXQ29VNGpJZmc1eTFvLzluSWRFYWhNY1V5?=
 =?utf-8?B?SndXZTdnM1I4bFRpVjNGc0U4b3dTQVk1WEEwRXozaUNDSzFzRTJBSkdDQjRz?=
 =?utf-8?B?M01xOFpHZ29NZTcxaklIV0twZEp3MVdoY2JHVm4rUzJuRG9VUXBkRmJwT2Rk?=
 =?utf-8?B?bkVZQjJoYitBWk1PdEhURkpSMUt5YjBRRGtoQ2RvRThlVjBPdkorUFA2bEZm?=
 =?utf-8?B?alFGMEdBNTRyRzhhRnZhV1NrUUM3OHc0aHQ5cER5RG8rUE9UQXk4OTJLbGVS?=
 =?utf-8?B?bEFMRDFrN29wbUp1NUhRRUdYb2ZzdU83M3pnK2RLTTFzRlh4YlBCMG5NRmww?=
 =?utf-8?B?NmczWHNQMmhLYjUyc3N1L3ZzTXg5T05wcFNvc1R0NkY4ZGRCQ3N6RVpIWU02?=
 =?utf-8?B?VzBUZzdPVGhyVHJldEs5RUNFVCt3V1BvMmJlNHVZUmUyNVBESnl2RnczRzl4?=
 =?utf-8?B?czJhazZ1Z3VGQTkvVHEvTTNaS0RKRlJKS2xrS1hhM3RLSmN2MW1vbHhlc0Vh?=
 =?utf-8?B?QjdpSTNkWVFQbS91U2N2ODU5dkRLRXlQMHl6NVhFSWs4TDV0L1VtaktPODVy?=
 =?utf-8?Q?JD7HXTt880t80vOkR7aQhGVI7d8pOcU/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OS9TMTFhQ3FtcTBUMHRxYXFrd1B2WlFTUGZacVAxbjR0T3R6aldSZWpFcXV6?=
 =?utf-8?B?cGkzbmJoTklEWkcyQmJRQVJWS0tueG83UXVyTDhHZVQvYlNkL3RPaStzSmw4?=
 =?utf-8?B?MDhsVXlBS1Y3dGk2eU9qYmUyM1JreTJYckhLKzgzazRVblFtNFBoY1ZqaDRt?=
 =?utf-8?B?c04zRHhMWklqcHlMdmdkQkR2dzlnbGVURlIwSENuRUtpOUJWU0JRRnN0WGJZ?=
 =?utf-8?B?elhGRkphUGpPOUJSd0U3VXVSWDQvRmx0TFEzWEEvVExIQ0xKWlZiNVlIenhI?=
 =?utf-8?B?Y2h2MW1FRmFMNmZhUTV4OFFqMThwVkNObFhKR1J0Zkg2VFhGRjJsVVVROHhS?=
 =?utf-8?B?T0dBRGVtbjlTWFdlSysxekFSa2xDSWRPSVkwOGVxbklRVExlaUtDVTlyQXJY?=
 =?utf-8?B?MmRnZkZCVnVvdGoyclcrUFRsbHJRTEVKNlQ0RitBUXZIa2tCVFhZc1VITW82?=
 =?utf-8?B?SnA1RmcrZ1FCRHllb29qRmZ2eTFvWDdQR2kxZ1NDRkpQejJqTVI1TjJXZCtQ?=
 =?utf-8?B?anpjUjNibUVOVzM0UkppYzYzSGxTZUxOeXIvQ1loVXplWVBqNlZZZHgzb0xt?=
 =?utf-8?B?TG9vTVJCeUcyVnJVK0ZFeTg4VzNLVEZjOGMxVEtQNk53Nis1ZElFZE9PT3lN?=
 =?utf-8?B?UXRJSnNGazJSc2srZVRNWGVDWTZYeTEwSUNYTHlvYWNkVndmRkNEdkNFQ1dE?=
 =?utf-8?B?MmdHMmQ5Y0VseVlFdFhTcVh6RFVBNFZzQ2JCWCtPeEVNOS9laGlvdFRvZ2Nl?=
 =?utf-8?B?Y1M4elV1aTJKWlhLZkxLd1c4SHdVUXVPYXpOeTdnVWxCK281VXArbkNPRFJO?=
 =?utf-8?B?YkIwT3JxY3hFTTYyL2NHc2JpU2NiYnBPakpCQnNZOExDdVJvTTlrY3VvWExW?=
 =?utf-8?B?WFlKWlRoN2xDRnJLeUEvcHJWdkxZSG9jaFp1ZStJQVVrWHpVVHVTU2FRT3ZM?=
 =?utf-8?B?YmhNYjA2d0JyZFUzYzlwYkxUV0tseEVSMXErOWhod2lWODhiT0ZyKzZaM09y?=
 =?utf-8?B?MmtxWE5LNE51RlhkRVMvd1RhSUpSSHR2RmtiOFF6RndobTRTTGlhejFLbnZy?=
 =?utf-8?B?enF4d3dMMTJ3bmhCUnRMUEgydW9hYUZocEtFQjRjRUM5RzlQaDd1NnAxUElM?=
 =?utf-8?B?WG9DU2hvSjdDTVdpUS9yckpoY3hYUXNiMEVxRm1lSkNmaUdQLy9MTHpXRlJi?=
 =?utf-8?B?UlZleDFMKy9qUmhLTjBPenQzS1J5aURMdHlpNXhaWTBGSnBnSWQ2MFhNUDRP?=
 =?utf-8?B?dUtMeHJ5aTBxeVlvNnk1Z0JBMkkvNUJnSG1tQkxmd1lVYVJyRWthZ3ExeUll?=
 =?utf-8?B?VGl1VG5XK1YzREFENWVjZmxtendXZ1k3aXgwMVdqR2t6UlNNTllBa3V3a3BC?=
 =?utf-8?B?RzlPeHZrV0Z0Y2lhQUpNV3NYVFhuZ3g5Yy9YWFdvTFVkU3pzSzAxVWVIanIz?=
 =?utf-8?B?SWNxajRzUGs3WjFGUnVEcW5NZngxZkpwNldBOURBNFlFSi9JaHFzNDNDT0No?=
 =?utf-8?B?S2Q3RXd1WmJ3ZndOUGV5Rlhnbnd1emRIalNIVk1VK0hrQ1E1akJvN0xtUmxn?=
 =?utf-8?B?Z3A2REVXZEE1bVFjV0RtR2ZGUEJMcXdXUXRjeWIxSDRzbGpWbUNORUhzbWpQ?=
 =?utf-8?B?WjFWN0h2MjNBMi8yeHNjSk1ZOFRRU3JCZGkvWFE4bDJhSTFxZFlTR1BJdE5u?=
 =?utf-8?B?RVU2a1FjWkNRWDlFSTc0VmZ3cCtTSk01dkVjdFVHTTFYYUlnU0hWQmhCaVV4?=
 =?utf-8?B?ajZibTI4d09VVDFlbGlrdC9seXlPaEk2N0RkOWxacXBqeUpZUm83VVBFdklR?=
 =?utf-8?B?cjB0V25lS2RZMHpNakE2UyszMkQvdGNaSVAxT09EWDM2QzN0Z09tRzFCU20y?=
 =?utf-8?B?ZWk2ODFoaGpiQVlQUi9acDN1d3owdzk5cU10L0E1Qmg3Zm9jUnhsczJtUWxW?=
 =?utf-8?B?dVdQeHorRnJmMDN3Rk9TSmN1L0doSFNxWFQ0d1F5cVNZa2RRZUNzRVRzVS9i?=
 =?utf-8?B?bEN1c3RVcXNkSzh1NEJLbUxQUXdGd0FEM3c3Q25JRHVjVkJXQzc4cGJPSDdt?=
 =?utf-8?B?Y1Yvci9EUXNndGcvc1NiNWRSYklJNStnS0pmeU13MWhOSWdUTEkvZWlUNTRn?=
 =?utf-8?B?bElERFR6amlBaVhROUpSMFpWeTVpeHJHWVM5Um9XRHBOWjFCNXA5V0xuV1E5?=
 =?utf-8?B?bTZSQ3BFUjVxUm0ya0lBMTBabnBZZ0d4L0hySFY3N20wMzN3a241VndhVWRi?=
 =?utf-8?B?WThyU29jdExJb1NRaEJoS0x0YTFNcjc1TVYwY2FGeGFNbUhMTWNBejNBUUNn?=
 =?utf-8?B?Tm9KUHQzaWxzUWhSOHB2Rmh1VVNYazlpZkZycE5zZE9IU0ZDeE5LeThtRE55?=
 =?utf-8?Q?CZ1ddJ0WoL7jEaZ8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f4f9a8-e2f1-4f1f-d0f3-08de525cb010
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 04:31:57.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUUSfWOoOVaHJyQkwc/5hV/xyzt0RxfVL0XP0RnY4mt2JUxmwU6pEJWdaOCeCJyLxj0M7dOqLQ4RwmtLae5ElXciPnbh2lFukJgAHgntmio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7775
X-OriginatorOrg: intel.com

Gregory Price wrote:
[..]
> > If you remove the 'auto' mode earlier on, then you can just drop the first sentence here.
> > I'd also add a note about when a DAX region can be failed to be created (i.e. BIOS already
> > set up and onlined the memory).
> > 
> 
> I think I'm just going to drop this entirely, probably this was just too
> ambitious trying to create an easy transition from dax to sysram for
> auto regions.
> 
> The reality is BIOS-configured decoders "is NOT the way" (TM). If BIOS
> configures it - it's DAX, otherwise the user gets a choice (or they can
> tear it down and rebuild).

Is the plan here to "whither struct memory_block"? I can see value in
starting the deprecation process given the problems Hannes points out
and BIOS alignment causes massive numbers of those things to show up.

If yes, then even if it is DAX the distro might still want the option to
only allows for region-scoped "hotplug" rather than memory_block-scoped
"online".
