Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5F1D555
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 01:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724809007; cv=fail; b=FH3xUuxpCxrterZFAh33xNJPXG6x6gZ8Kqq/8UGSo3V5Y0zypoPQCtUPXmx1WN+aUnjsrnVz98cnl8h2cOi2sqNw5HT5AEk2Q6yNdHIXf7jb8LSc/oLAUqE3Ux9DOl1rV0SwHLfEb/2Kk2z9eozdxO4sYHHGwKBkJJKNNalgfNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724809007; c=relaxed/simple;
	bh=8iU9UZlCGsyAp2mS0VGTaWhORJpltP/nJ3Z6Fe4T+PI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GACPH6QdRnqbP7m8SIr5TGxAiKujzzXEOPglcrRorWu6dXBWaAIMnMeuOXI80FNI2ylE5JYBb049IWpnHF7Cbxmtc0vVwH86LAYJ71Z6MMEnq2GsncX9aqCcOUAiRSvVXVbkv6MpKzXaODRiA3JfnYcJZ01Pv5XK2CnBH2drOQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gh7Xk91w; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gh7Xk91w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724809006; x=1756345006;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8iU9UZlCGsyAp2mS0VGTaWhORJpltP/nJ3Z6Fe4T+PI=;
  b=gh7Xk91w9/LbuO2E79f5Dqm3XQVcHxDe7ljo7rkDlvgiqpm8WONHKhvY
   qOXxuVz9Jv0L6Li9LNxrHC05zKlJPKsz1BsbeGKIqCIOrf6mrUagJS0KX
   oz3qNRcc2U9XQPfUh4qjd6Xo7xVhsvau8dEG5FYBdSThU/oostihfPFF+
   QQaFN9xbrN+D7FzTpyufpSv2v7j93BK5fv4/ES4FYX+IyvYENXlcg7REi
   rvnjmWvP0zn9j2dmfPt84YR7+8e9e+EhQbS+kqvyr6hyj1WtpDJhXxnxi
   GFxXbtzFyK+8/OVVfTF7C7CmC0N5OD2clNIYQiFCT3Y9/4pck1F2R83ey
   Q==;
X-CSE-ConnectionGUID: I9saEpG7R+CB1rVpYF+ZRQ==
X-CSE-MsgGUID: faYW6pHvSSmeLEFiGhJNVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="34691998"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="34691998"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 18:36:32 -0700
X-CSE-ConnectionGUID: /FOh5nypRAWWu8XUcyNBvw==
X-CSE-MsgGUID: k+DbgRclSLW6dbZW6mdATw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="62719402"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 18:36:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 18:36:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 18:36:28 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 18:36:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sym1jYT3O1Q7Jz6hRpHw3Ods6htK3baTy3vBV+Bg6Mll+A++lfV0IJu1qHKcoTwd/LzoaB8nYeuN54xr/TIqlluGkBcg7DHxoaxbk7GfYsj7Ps1VjDwS+CM6a40dQ2I8WkoS6uDPZnaHxrNl2+8xk3YZG2qdgRYl9KiTsAz4KJ45hL7uTA2nABxPphy3Uf2W1OnjMbbzHxDU55LnHFAR5MfISoRE8KrVMQV7EIWVoto2qyqRVrkNIz3QB7ERI2ks+B7ExhRaKuMs4Rv1oty2ya6pXPfj7a7iy8qPqBClmMujtyCJiLQS1N+Vl6lGPc0apiQ5oySTZSVIkwg7wbsJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iU9UZlCGsyAp2mS0VGTaWhORJpltP/nJ3Z6Fe4T+PI=;
 b=hZNmgpxyEiQCYdf1rupI9XLPfZNhY4vV3j8GWL5f/8+AUKbGH60vja629C/D0qUOF83XOZ8swhPNrN4ff23g6yjYR7pOf1WHtihujv6JJof3OFx45AR8+TyHRLhfjdVXAWqaq27gh4Sgx6tDAFyH2PRLAG6tl8fe/6MnYAszIHHSlF7Pv7/GrL2fXB86JA1UzHAxiiOmCQUHFlZ9JYGtnxUxuYgB2C8yrtgb59/pq5mv3PQbaJK/fa/Qti1fChb4cPeTiBMqKcja8A9zHztCq711Dg+8kj+o7jtn+g6U7E9XkN2eKsa7dg4ThY+RXFGgsxHTvPphNu0Vbj6igKmTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by LV8PR11MB8608.namprd11.prod.outlook.com (2603:10b6:408:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 01:36:25 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 01:36:25 +0000
Message-ID: <69ec6922-08da-4ebb-a45f-24111f0ee2f2@intel.com>
Date: Wed, 28 Aug 2024 09:36:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cxl/pci: Rename cxl_setup_parent_dport() and
 cxl_dport_map_regs()
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
References: <20240827045755.1837473-1-ming4.li@intel.com>
 <20240827155655.00001bd8@Huawei.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240827155655.00001bd8@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|LV8PR11MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: bab5b0d4-d36f-4474-04a8-08dcc701d49c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXBmdFY4ZDJhVFdnakh6VWpHRXFWTVNOMGFhOUZZZkVmYXk4eUMwWGxoMkJ0?=
 =?utf-8?B?KzYxOUgrbklBaUJrbmxDY1ZpVE94Y0I3V3BQRHJzSVYva3hsRXNEOVhWUDJ2?=
 =?utf-8?B?bFF3dlVCbFlYaG0za2xhbyt6YnZyMGNodEcwYzNzcjJhdDJieU1COTUrdXc5?=
 =?utf-8?B?VHV5Q2FrNlZ3bHEzQy9JOTNESFAxajdKSnNySndVWWFNRzFocVZIVlBqTDlr?=
 =?utf-8?B?d0R3cm5McTE0alhkYWlPWG5qMUpydUx1ZUFEbWlMa3VjMGRuSk1Jek5Pb1lo?=
 =?utf-8?B?OS9tYklOMy9Ec3dYOFlOMldoTVlVNVhEczMzM1NGdWY4R0JuWEJSQ1l6NDBt?=
 =?utf-8?B?Q3VUaVd0b2h1N0tMWUVKK1B1dEFVVFRCRmtHZDY1YWMyUXMyNk1iQVhBUWFW?=
 =?utf-8?B?bTVGNW5SZUhlbm1jNVdVYTh6cXZlTjRRRFpsaVE5Tlc0QmptZS81TmkrNits?=
 =?utf-8?B?WHJuZ28wclJmV1diMmg5ZjFxQzVqaU9PVGxFOXp2QXk4alg2UFYweU1KRUQ1?=
 =?utf-8?B?WXBHd3dsN09wRW1PTHJoVXY1TVBodk05Y293ZklTSnlENDNRNlMwVE4xcGFK?=
 =?utf-8?B?REl1ZG5BZEFBNnVwcldlVk1nQXRndWc1d1I4LzRiaHpENDIxbDFUMElOdVNm?=
 =?utf-8?B?aEdkRnVIWXFPNFBqQjA1bnhoVk5rUWpHWk5jallJYXdyTitmZWw2UUdha0cx?=
 =?utf-8?B?VHI1RmR5RDRnL25yY0xZVVIyNUxUcW9lRlNLL2JMU3ZqQUQzVlc5M1lZRDJ3?=
 =?utf-8?B?L2lMeHdWVE9nVk15WFhYWVBDKzUrVjdHWmtZWlJRNWFlWFB1YnV5cW14OEdF?=
 =?utf-8?B?OU5LODl1UW81a1cycEZuVEk2Vkl2QzA3TSs5Tk5PMFhQR0FIZENjNGdqK2tI?=
 =?utf-8?B?cXEyWlN6d0Z0UnhWd2w3c0RKalJjNURFOUkwZ0RTSXdCaXhEa3FEQWYxNGg3?=
 =?utf-8?B?Rkd1dFQ2T0VPUG5mQktZcVVKU0xwbWlzNDZXWkZqTFB1Qy92ZTZ5SEQ4MGJt?=
 =?utf-8?B?NEtiMG9KRmtLUzh5a3lNRlR2anRJbmZaaWNjczdlWEliV2VycWlZbWxabUhO?=
 =?utf-8?B?Myt4U3dyYmp5R1NnMGR6OTZuMzN0ODZRS0RkYytTT2lFa3hveFMzWmtIVzBi?=
 =?utf-8?B?TXFlMjY1T1JDTjVDWWR2QXVUUnBpU3o3YnVPN3B4eGZZYVJNUWpKckdTdnBO?=
 =?utf-8?B?TUl0b2hZYnZkcUwzNmNEaGlIRVpZTWhTVURkYVFZTFVXNG5OTnE0M1JPazFL?=
 =?utf-8?B?MCtJNDkzT0hzbEI3SzJmSmZBbkdVZ1FDelRGaVdDVHdrZWpyZ21jYW9GOTZC?=
 =?utf-8?B?SjZzNUp1UHhVbkRPWUF3NW9jSGNhMnVML0tUUWVVYUJKbVBJREdJaDJtWDRC?=
 =?utf-8?B?N2x2cUREeDgvYTl0bnN5QVVVTFhhRjlweGxLUVFoOW43UXVvbG4vSytyOVF4?=
 =?utf-8?B?a1ZCT0tadlBGQzFwc0ptL1RVOWUyQmhEbTdFcjFqOEE0NjA3MEx6Y2VzbDJR?=
 =?utf-8?B?aGJZZlNya3lYZ3IrZENtTjZTWGVuRCtWVFpFR3AyZU1HVzdid3ZiK3dkdXlt?=
 =?utf-8?B?WURpQ3lMaE90MWxLaWZJWEVaYTBWbjUrbzFKckVUNHB5bWltYlVOd1BOck43?=
 =?utf-8?B?bmlGK2pBSUtZNHI0KzU3TGJvZVkxdGZYbkR3NURQL1YrdER5M0Jtd2p2OWlY?=
 =?utf-8?B?aXI5NWQzelQ2L0FKU0hPbDZwdFBpMVhqczBZdmJvZGs3SEJRTUkwYm5JWG12?=
 =?utf-8?B?Mm9MUURYTW9aZFFqdkdMQUdIM216WTRrT0ZRRGgyRHBTQUVDclVMbnFsZHoy?=
 =?utf-8?B?RkNaL2xadng3bGNpdU5hdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFNqbGJha0xYbFFhZzFBREVYZ3NVbmZ3YjMrdDhGU0I5YVFKYngwYWZkdzhs?=
 =?utf-8?B?RnpBSVFmTThZU01PY1hKSDgvd2IvSm5DM1o3b0VVTDN2UmwvOEQyeU1HMHFq?=
 =?utf-8?B?ZHZ5dXg2ejNxSGlseWtnRHhiSjh4Zm9wWTUrTW1kS2NTSHBiWjM3TUd2NE0w?=
 =?utf-8?B?R0NveGplUWtjTk1HUmVVTFFOODhRWFhCQm9LWEgyYTJSMEpvSEJBdE1KK0NQ?=
 =?utf-8?B?M21PKzEvcmhuMjh1NnpuRHlVU0cvK1BvQld5anovbEE3YVhCZGZhdzNlcTBO?=
 =?utf-8?B?Q09MT2FhZjUvVXZqZG1BVG9lSUhLV2UvU3hiN0tiL1AwVUIrVDdxYXFDaGhC?=
 =?utf-8?B?MXVKT3JtRExHLzhtUC9QRUJZT0V6dHJmdGZFVFBIQUZXQTEvZXZ4OTNwelNk?=
 =?utf-8?B?V1docmdVRTBiZkRyODJLUy9ZODFkeUt6SzJZazVXb3lLMUxFUGdLbXRScXIy?=
 =?utf-8?B?WmRmcklHOVNEU0F0eHdvYURndjVCOHpwcDBzVVcxU2Q3V3RIa0M0Vlk5WE1F?=
 =?utf-8?B?Z29vK3YyaEZNQ3lpTERSU0pKK3JaT0ptWGxIU1UxWVZMdW15cE0zOFZxWUly?=
 =?utf-8?B?MDZzcU1SenBybVlKQUh0SEJ1SjJQcXhUQ0szOWhQMWZUZnR3RFJQbjMzb3d3?=
 =?utf-8?B?Q2h0ekM0S2hpV3VnN0dXM0kwV1FoSWpPbUIrSGwyV21nNktMVFFXVHVFUWxx?=
 =?utf-8?B?cFR2YW1hUGRTeEVzVVhIVEk1dnFDZkRLMTYwRys4bUMzS25IVVZ5SHplL0Vv?=
 =?utf-8?B?ZkdzTVU3N2NyMVJqbDRDdVdQOS9kSWNtQWI2Q2FOcDBTcmRuLzFYMUh4L2lJ?=
 =?utf-8?B?VGxYdW1OcTk5V2t1blBRRWllT3AvbE1LQVJ1dkpNT2d3eTgyVnpMVE5pRDN1?=
 =?utf-8?B?dElnRS92MndJOGhSaWg0Z0tSZTFYM1RlMVQzU1NPay9nL3dwdDllRHUxenVv?=
 =?utf-8?B?QWxMQjYwcFdET1MxUHpIYlh6OFhtZytOemc3VWNhTEtzUDc1emdMT2t0VU5i?=
 =?utf-8?B?MiszbjlMQWMzbmhzTUFRMjdzd1FXRTdhZ0FPTWc2REcrd0M2ZUQ3b282bitY?=
 =?utf-8?B?VDR4aStCNXpybHFPVExvTHE1UGhtNTlWYkJuaUdoa0ZjeVU5ekNDMVArTmRM?=
 =?utf-8?B?MjVGaXZ3Z3JpcldWUVJYcVR1Ly9MVzFJajkwOVpyM3EzVmUyYmo5YlIwSE9U?=
 =?utf-8?B?QmlRNE11a0dNdEVzTGt3aU55S1ZJRzNIT1pNa04rUUtGWHdnVk94endGYWtM?=
 =?utf-8?B?V3AyUFJBOUZ6Nldna3ZLWTNuYUgyS2o1N3dBeWZUYUNFV1BqVlhJdlFzSlhH?=
 =?utf-8?B?c0dsYUE3ZTVkdDRuZG02UzlPM2ZnK1kzeElMTnFQeEhpaUVEWkl2KzR5Wms3?=
 =?utf-8?B?MmUvcDVuVGVOZktuUmIvclVsSEk0WVNkWVR1UVV4ZnhWVW42YzhiQ2pnOGRP?=
 =?utf-8?B?dEMvTVZ5U3cxT1l6QnJUSmw3K2dwUEZSaGNPWnJTSExTWkZsODBNM1VvVGZl?=
 =?utf-8?B?TGQwVG02czBVVk5WVjI5bmRPOGJraGVxTW56MVgzcXZKM2wreHZ6QXIwYkFn?=
 =?utf-8?B?a0IrNTBCN1NzV2VlTDl0YTdZVWtpMFordnJZTEpZVXRmYmNHNlM1bllTT1VD?=
 =?utf-8?B?NEpoV2dQc1M4eVhmRkxSUm01eDdtcW5tSzM5eXllcmM3K2xCOTlwZFNIeTNV?=
 =?utf-8?B?S3grcTZwOE1CUW5hR1VqWDN2MjFXQlBTMndkKzRGOVhYbW90MUljNFBBSTB1?=
 =?utf-8?B?RDQrTkNqeVJ1cVNUQVJ0SzhXNXhsMVp0bS93K3hFWjRzcWtESHVjWjlDV3F3?=
 =?utf-8?B?d0krSkM3OUtXN0FGQmpHR21RTWVmNlo0L0krcFA4V1ZVbjNhbzRsQUxOSEhh?=
 =?utf-8?B?ZmRmVUx1dkxxMEtJWFdTK1B2eC82b3BnTVZaZE5GUEtzS0l1UEozWFVFVWFa?=
 =?utf-8?B?NkJwUnpvbTlLczVCTi91Q0tuZzB6R01vbFEzY0tGaUhoQWNSQ25hb0RpU09G?=
 =?utf-8?B?Q2hqOFhnN2haQXM0d3V6VHhUYmZGSXJMLzhSR0g4WG9GNWV3Q1c1M1VSR1hG?=
 =?utf-8?B?MnF6MnhCK0FwRWRPVS8xaVVOaENCcU5VR2g1UEkvek0wby9odXQwZE5SUUU3?=
 =?utf-8?Q?8IxDwP2B2aIZTY7/CiMUisMlm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bab5b0d4-d36f-4474-04a8-08dcc701d49c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 01:36:25.8725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jm4+uCc+HTbI5KMENU/F+xaB1+sqU3s7hON07EaUhjPpmX3fk2YCuQluknJpp4YZLXT0XLUvPCS1j/SQyaFqmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8608
X-OriginatorOrg: intel.com

On 8/27/2024 10:56 PM, Jonathan Cameron wrote:
> On Tue, 27 Aug 2024 04:57:53 +0000
> Li Ming <ming4.li@intel.com> wrote:
>
>> The name of cxl_setup_parent_dport() function is not clear, the function
>> is used to initialize AER and RAS capabilities on a dport, therefore,
>> rename the function to cxl_dport_init_aer(), it is easier for user to
>> understand what the function does. Besides, adjust the order of the
>> function parameters, the subject of cxl_dport_init_aer() is a cxl port,
> Hmm. It's not just aer, so maybe cxl_dport_init_ras_reporting() is broader
> naming that incorporates the fact this includes the CXL specific stuff.
> Obvious that might be used to get more detail on an AER error report,
> but it's not part of aer.
>
> Don't want to just use _ras() because of all the ras control stuff that
> isn't related to this function.
>
> Otherwise LGTM.
>
> Jonathan

Thank you for review, will do it in v2.


>> so a struct cxl_dport as the first parameter of the function should be
>> better.
>>
>> cxl_dport_map_regs() is used to map CXL RAS capability on a cxl dport,
>> using cxl_dport_map_ras() as the function name.
>>
>> Signed-off-by: Li Ming <ming4.li@intel.com>


