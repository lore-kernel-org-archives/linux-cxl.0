Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6332142903
	for <linux-cxl@vger.kernel.org>; Sat, 10 Aug 2024 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723277474; cv=fail; b=f/EvspJHP70r36kic/rPmFK6vis3OjuiGFId/ups5csUOT6e5haEW/r9aoqPPTt7oC0H6KDoA/tCbWC8yMRPPLDxUE4u+dqBwZ1FfqFPiOYIvqKdniLBSC7/dUhzI7GSI34Y/sEjUyos5IDEfNc1yfN/RTMU2LmBYzp61Yrzzbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723277474; c=relaxed/simple;
	bh=qveSbdasktkCVH0MQB78vGZ7lFIHiG1k5FvB4o0Iz4g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=opKdtcWFBnsuSZqgN7h95K4PWErwVrZHFjVAkGXUcg4aFzwgmv+B2uJdXgkIxibw+dwhhWiSQxXbl7lY7I5c0DKkQAQs//MirLbqIvHYkRK7kw9vQgkR7MIApAVXW/19GNQed8/LNjO9ICFNn2sLV84G9bKy+OQOQ95rIPU/GOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNyJB1th; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNyJB1th"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723277473; x=1754813473;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qveSbdasktkCVH0MQB78vGZ7lFIHiG1k5FvB4o0Iz4g=;
  b=KNyJB1thcCeM7KGSayg48Q8Pzrp3L4H0xHvLeShP6ShPVxJrE12CVTRb
   aTia7K/m8+H+XdHB+y+1n0insy6V86dBFf3hHN+BbG/cF+7V9ivU25ckd
   auVPfJE8bvtZKm6QzYHRgAJlCSfeRWg3HsHRn5+7xlx1vlf3W0+wtKK3C
   5IUnazjy4vCaP5K1CCG80It+iUXmJMY0F8ugEZ6cGUSHQzP5crpT0EbRq
   8guAHiqLUV5wVQwlGQBk2bKaOjMu/rbAgeDBKdWenPmG3cWOF2LCZ1VDh
   WrMkID2OvjA4xFNQmGMLIVTe2HD5VzOAPzNhfphcL3w4+bL2nKcaLc8Jv
   Q==;
X-CSE-ConnectionGUID: ULenEOsoQYuuJ7Hz47q8YQ==
X-CSE-MsgGUID: FnR0XbdQQauumhUCUpqAvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="43971827"
X-IronPort-AV: E=Sophos;i="6.09,278,1716274800"; 
   d="scan'208";a="43971827"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 01:11:12 -0700
X-CSE-ConnectionGUID: Tbm2nzvXSUSq4XEw5+QZzA==
X-CSE-MsgGUID: 3Ehi1Vh8Q1+6O5Tsjj5TDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,278,1716274800"; 
   d="scan'208";a="95304728"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Aug 2024 01:11:12 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 10 Aug 2024 01:11:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 10 Aug 2024 01:11:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 10 Aug 2024 01:11:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bX/A50MS+t7ofFUkiJU+nQCOspiF4sSc6jwqZYOlzgjJXMXqyzP3CBEwPxqeTKFXZ4oY+ZWwEpb5MSIC8Ww7HoCfRh3JtW+nZOzYYPq1FMlmQbfxDu/6U02TUttyr7SFbWU9FB+gCOTnPJw/vVjXzL5RE6eBwS7jZuxiJUn91AIeHTR5qp4X+JlFKv1k5n+V8ZjJsqbPb1+ojAimaOU6BrF5g4lX70WV8+6f8tJ33usKptAQx606YtKFlZFTebP4OtA2E/tiJWmDnFVEEAiLauOjix2fz9mFW/NOWOD2h0U3RsPgZHDfgP9ozL4Bbfn2jMfwEUq2SEcN/hqOWj19Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plGy7T60m9QJsFzHT0QX+9xBtAHSY5yPL+2OjZWVB30=;
 b=YFHwYCBfx1JH8/1R6VScH/Z0JVVLCNSEbu3d/hSmKKOfNW3kiBCvBW5iM4aXeq5xGGkhzksRkEmfvd+RoshWGb3Y3jvMs5JfbVQJUAUAaabVIzRDiaogoN7lo0srrNdBLvZBNKXawk24YPxEkqbjpPCnLhbP83+3oXdIgRRgtvbbuIwM75ZDKS0Axc29colnkApHW5Bg/xdhPce4GyWIP6G2IMWPMZgUPFhBmyNBDv/t27kUKBcwgwOnl4tAxNmdemIjDwghxm5ifSW9OzmNfhSKBwzfU7L9MUM39rQWsMtw6mdJoKOmnS+/k2HhWDKuSxYwDSqW+p46JsfOBaMNCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19)
 by CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32; Sat, 10 Aug
 2024 08:11:04 +0000
Received: from SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67]) by SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67%6]) with mapi id 15.20.7828.029; Sat, 10 Aug 2024
 08:11:02 +0000
Message-ID: <1e535e17-0e3e-40d5-bafb-58babbcb23ed@intel.com>
Date: Sat, 10 Aug 2024 16:10:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/4] cxl/pci: Fix to record only non-zero ranges
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <ming4.li@intel.com>
References: <20240809093442.646545-1-yanfei.xu@intel.com>
 <20240809093442.646545-2-yanfei.xu@intel.com>
 <66b66634acec6_25752945e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <66b66634acec6_25752945e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To SA1PR11MB7110.namprd11.prod.outlook.com
 (2603:10b6:806:2b3::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB7110:EE_|CY5PR11MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 49488ca3-d5e0-4bbc-cd97-08dcb913f95d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXY5TThwblFRM3IzWUFkRzJUNmtTQ2oxRElEdEVlZ2ljUElJSXQ4WEVITVdK?=
 =?utf-8?B?L1ZveUpvY1p0angvRlRoa3BlTnBmeVNick1xWjdDVmUwZ1NDYnprU1FtOFRt?=
 =?utf-8?B?alZXK2hzQ1NwVUh0SEpER0pjSW90NnBwTjdUb1ZDZDJkVHlJeCsyOFhENnFx?=
 =?utf-8?B?bEtCWVhodGwvU2JIV1ZTakplSXVzTjB4QzZqRFYxdkIyOG5vZ0NJcmptWU9z?=
 =?utf-8?B?WjVxV01WTW11enh4cnhDYkgvOENrdkM4aGdacGpJdkg5QlZ1QWJUdHlLMVVD?=
 =?utf-8?B?ZnRyZzdUKzBBSVloOE1RZUlwN0RDM2V0bjRvRmdsRFNEYW41cXdISExBSFF2?=
 =?utf-8?B?cWN1QWtOZHVXa0hPUVZyOVhwYkowenN5QWRXckpTRmpWcHpzNWVZYk50QW5i?=
 =?utf-8?B?ZHg4RHBaelpBSFpMSVNQdUcxVFR3S1p1N0dZdjNIYk8wdzgxbGNJS3hySDdG?=
 =?utf-8?B?a1ZYMzl5cnBLRnY1bTkrcGhtaUh6QXNxeWVoVHZxNXhMWVlzekJZSlRyemh1?=
 =?utf-8?B?ckhDbXBycGp4WHlKUVAyU3pOQVR2YVdkSFljZ2ErbUp3UjYxMDExRXp3ck4x?=
 =?utf-8?B?QW1FRXN5V0VsZXRxYlcxeDFYa3k1M0FEWlNRZ2xZRWJ5Y2tyNnRkZUhpL295?=
 =?utf-8?B?WForVEtHL0JYSENIUThKVGNQTHlYN21yZlJqMUpobnRYRnFjbEl2MG1qYXp2?=
 =?utf-8?B?VGMvNjhtdVZWY2tBSFA0Y1FNeEtZQzdCOTVqUWVZZGowT0lCNDhCbk1tSjY2?=
 =?utf-8?B?UVJMUmZJb0hoT0JEVGZ1OHQySklGaGRUWmtlRjhLZUpCMUVqU3c0UmdxZnd4?=
 =?utf-8?B?UDludWtXWkwvaDNNTE9hU2JPeEpTYWJWaUNOR29HY2dUdit3bDcrVjRTbERR?=
 =?utf-8?B?cWVaRjc2elJnUmwySGdZc1ovTVczbGZMVzEvTDQ4dis2UGNUSUZoOTQ0a0pF?=
 =?utf-8?B?WXpiYm84Qkpqb1hSeU1wUVAwWnRIbWJadDN4MEhMdmtWZ0JFdU5Ld0NZMmJ4?=
 =?utf-8?B?am44MkJKeGxQRXNUajg3TW5CUGdLZUUySWgxSGhjQURPVGF6MEpBSGNBaXhj?=
 =?utf-8?B?SnUzTkxveHIwV09zcUd1V1BEOXJKWTY4YXpVUTEwR0RUSHltcTRycUFiby85?=
 =?utf-8?B?Y3VaRmgzV2F1ZFRwMGFET1dKVDROYTYvTGtGS2Y4ZGZKbjNPRlV0anNSbldD?=
 =?utf-8?B?eE5MQXlMdU05bTZuQXJxNGxadzhwdXlGV2FOcHdtRHAvbWVvMTB6azg4aG5S?=
 =?utf-8?B?ZTlQOE5xVy9oY0wramxNTklhem9zUnoyVTUzQ2t2Y3d5NU1OUUpCN21TSXYy?=
 =?utf-8?B?ZnZCSHd3ZGxVNWVGdjBlUStFRXo1cnJZK0owWStiVjN6MTJDTmFrcnUwNmZJ?=
 =?utf-8?B?ZXlqaG9jRjQrNk5ZMXJlMW5QNFk4TENzQk1qQXNDMGNqdThvaTFkczIzc09N?=
 =?utf-8?B?a2pnUEkrY2c3dEljRndLQmUvSWtMM1ZlY1VwS1NacmJWa09EbW9lWjFQcXhP?=
 =?utf-8?B?SnlzemZZS1lwK256ZmRhc3FTM01sN0FNY3RKaXpJSzJHSnFCWFVoaUZhY083?=
 =?utf-8?B?aURFYTFHa0FzVDAvWEZFTEsybHdRZ1lOM2dsWFJlWUtPWTVOM3Nac3VIQ3ps?=
 =?utf-8?B?MVNlTklJYUIrMHZscXFSQU43d2tIM0VPU3lHQVcrT1dVL1RpUElRbHdMU0ls?=
 =?utf-8?B?YW56TXFBSlBFTnMwUUl5ZTg0MmtPUlR4UUcvTXhYWitGVitacUNtYTU4TzJv?=
 =?utf-8?B?SXdhYkpjYzN4S1RDTU9BdHo5ekR4eSs3SDZKSk90QjVxL3lWL3lBeStlaERw?=
 =?utf-8?B?Y1Z6QVI3Y1J2dXYyRUxOUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7110.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVZ5OEl4L0ZuSi9mZGJUcWJqS25Mc25zbzBFR0VxS1VYajhqZTFmSjlncVln?=
 =?utf-8?B?alRJYm50ejRkcEJzMlRMM0VDRTk1MEg1OHA3QndpUTM1VnBCbnNtdUFFYUps?=
 =?utf-8?B?dktRZXk5VXRleFg3NE1DL0gzR2dpTXdjcDNsUGE5QXpVRmYvSG9nMGJRekRR?=
 =?utf-8?B?bGRwUWljRXE2eGpOQ0dia1Z5aGFTTFlCekZWUmNZMDcwWkQ2NXcvMEs2OEVa?=
 =?utf-8?B?bDdCbFkxRTVIanNyZXVhRHZsbXh1WjVUbjF1cDZHNmNSLzVjMXFWSzRlVGJJ?=
 =?utf-8?B?MWp4MW5IdnBxMWtIcitsK1FLRStYbE9jSTNwNUlkSzJ5YW5Oc0YvTjhhRlAr?=
 =?utf-8?B?YzRCQzRqdEh0K3lyd0l6RHgzck5IZUlvaDF2MVZKbVBnb1VsaTY1aUNEOW9Y?=
 =?utf-8?B?QkphSjJyaFJiUTIvSFFpMzEvKzBlK2dXRFUxTE0rQmNaZFBGWDliV3dZOW5j?=
 =?utf-8?B?SkJERzNsMkRqOTcxY2QyTnpGSFZ2VnQ4SFVzMzEvSXU4YWFxTW81RG9ENXYr?=
 =?utf-8?B?U3YvR25lSmlJbXU2TEd1VnhMclo1VDJEMWxlaDYrWTV1RzNjVFlNa3dzY2ZY?=
 =?utf-8?B?bjhoanp5cDVva2NNMGFORU13VFN3R1ZjS21OQStzQXNoOE5jNld4UmtZSnJR?=
 =?utf-8?B?WjdRRE9Qc3puUU9uSysvWStDUEMxSEdjd01YU1pmOXIvbUh5RVdQNDcrVmJQ?=
 =?utf-8?B?aWl3L20zeWozUWFxRnpwNEZJUXB6aWlsOE5DclRZSk4yMi9veURqa0dMSzJQ?=
 =?utf-8?B?YW4rZkkraTk5Q0dLdlBWUFgvUmtRbGovZ293eTNjUDdueFFuMmJwYy9xbjVK?=
 =?utf-8?B?UFp4UW8rVWZ2Wm03UkFMbHZSTlNHUys2NGJURUJWbXNXaGxUVlRxRlR1cXd1?=
 =?utf-8?B?Tk9hUFExZFNSSnp1ZlQwR1gyek9yWCs2ZWc4TjVqWjJmOUNQUTNqWDNNVnU1?=
 =?utf-8?B?cUhlL2dYc0JxMGF6NTI3a29Wd3RvaTZLc3BYV3kwM3A1RUtJOEVQdWMzL3Jp?=
 =?utf-8?B?eXRsOVhRejNkNlZvcE90SzBWQkx6SDBNTEJzZ0tiaWJiRXFqNkp1cHFwZlJi?=
 =?utf-8?B?UVo5QXpMWWFWUXU5Slc4VWhwYjRTTVl3ZlY4UVd4blRtOGFBYnBSbDBmQ2dN?=
 =?utf-8?B?WGpFRlQ1cXR2NG4wUzJ4TExKOXo4VjA1QVArYVhoRVFFZ3NPNm9jLzBBb0hz?=
 =?utf-8?B?NWxVcUk4Q2VHZkdseWorZWlxQ0hrVGtneHZjYnhVb2tqMm1KZUNMVkhmSWls?=
 =?utf-8?B?bTRweW5zdEg3Y2JmSGdUcEI0UVNxMXc1R291ZndhZzU0aCtGdTBhUjdjaHdO?=
 =?utf-8?B?TkpDeG13QnpyMmlPY1NQN3lKL29Eei83Vk4wYVJDWFVWeFBvdzNZTWNhODRE?=
 =?utf-8?B?UGFjR0RycXFGZHRDTzllaHpGak1JWERFNTFiT0lxNVVXR1E0a3lPRU80Nm93?=
 =?utf-8?B?RjVXaWNDVGZMakVzeHJGMlp2Mk1rMFNpQmMzb1pJb29ZeU1vc0VRbTl6ZXJZ?=
 =?utf-8?B?K1VIdjBTdWF3QUpmTEVYK0hxYVpRbnFOaDBrZlQ4RXRpaTlDK3Jwbk1Zc2tu?=
 =?utf-8?B?ajNVUk1QZFVValRBNExUK0lMeVM4UjhGL1V3ZEdSTXUvaGE4YUpyTFY0MWZk?=
 =?utf-8?B?K05XbFQ1Kzh2aStGOXFRcmJYN2xBRnpsYVFXWVh6M0YrVFNtTXQzTUdUVEda?=
 =?utf-8?B?Y3hQdEFONkx5NXpxOEJvWUREdW1HaUhkSzg2ckt2ZXNlVldjalR2b2thZ2Vv?=
 =?utf-8?B?d0dYZ0s4S3ZmMFZKQnFBVS8wR2FJQWNFSm0yUG9qUktoZEtWNUp4cytjSnp3?=
 =?utf-8?B?NHBQaGR1dnVjcXRvV0FDODd5dDRpLzZ1SlFFT1JlVHl5bnNuelFCMUVxY3ZH?=
 =?utf-8?B?bnFsdU9sWkRmd2pJV3NUVzJpa2tOY0YvZWphdis2dTdNbDVOTEdacitWWTIz?=
 =?utf-8?B?Ny9yNHA1MFNRMW1KUGVkdFVUOTliQnlpV1pEOGlsekUrRnRKNUlHazB1NVVB?=
 =?utf-8?B?aGd2dmdzVVUzallIVjZWODFqYUJqeWVncllsMVkwUktmL0xVbUNiRVU3ZDhM?=
 =?utf-8?B?Vkx5N1VFcVgyb1ZXNnU2eHprT1FFZEUvbVd4RklWS2FvSmFleGdYSWZWaGRK?=
 =?utf-8?Q?BMJgCZIewyYjHfZC+3WYJ1bYF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49488ca3-d5e0-4bbc-cd97-08dcb913f95d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7110.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 08:11:02.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYA/zhcmhCWW+PE9T/ufEOmxKI87mj5k5hdYhskzM76IP0EiQBhakqnF3phvRFx0ef/DCeOnp0lvs9/dwgLy3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6211
X-OriginatorOrg: intel.com



On 8/10/2024 2:55 AM, Dan Williams wrote:
> Yanfei Xu wrote:
>> The function cxl_dvsec_rr_decode() retrieves and records DVSEC
>> ranges into info->dvsec_range[], regardless of whether it is
>> non-zero range, and the variable info->ranges indicates the number
>> of non-zero ranges. However, in cxl_hdm_decode_init(), the validation
>> for info->dvsec_range[] occurs in a for loop that iterates based
>> on info->ranges. It may result in zero range to be validated but
>> non-zero range not be validated, in turn, the number of allowed
>> ranges is to be 0. Address it by only record non-zero ranges.
> 
> When applying this should mention the potential impact of the change,
> something like:
> 
> "This fix is not urgent as it requires a configuration that zeroes out
> the first dvsec range while populating the second. This has not been
> observed, but it is theoretically possible. If this gets picked up for
> -stable, no harm done, but there is no urgency to backport."

Thanks, Will add in v3.

Yanfei
