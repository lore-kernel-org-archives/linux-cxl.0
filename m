Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8D6FD3
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 01:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723080398; cv=fail; b=a2e0IK9b85UVO9l5hiZLKlymZilP8R7dm1htVz8R5+GnavLCudJUr/Ry0TxvnXv0XegC8Ng48B8GhSvquQmzzBDgy0+UA1qfmfndT7XMtuQHbwHmjifkYt5vHBeEC1cRS56dU3uDXwNAEoeCvU1Ng16dilrZuIlySYUY9btP6xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723080398; c=relaxed/simple;
	bh=8ABQxoOnMJjkgnK+6lu6qe9A3mCZoeefBvu59C08Rp4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O1Zsv3Y7VMyDeU+O0Xgh4bDJ3zftLukzAg8ec93Da4hj6PXyyqs9NwCCkNmkDBAIFTqrklI9r2+WrKRDObZ6srw8eMjmIL72eYf+IDkLyM781XO7fgN/zRvjqsVKoHMaZGu/qUPlyUqU0D3YZwf5T0tDJxYC6JvnvNh0ZujRuu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqEtoMmJ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqEtoMmJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723080396; x=1754616396;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8ABQxoOnMJjkgnK+6lu6qe9A3mCZoeefBvu59C08Rp4=;
  b=YqEtoMmJJ4mCa+Pna41xyM1qzwWAtRSa9CjP56F+O1yJcBVcwGQRTEqY
   wQW33pZeKVIqzJ04tjGM1nnN01wtBBf8Nbp9hPGNfXqkOoHuKHbqnQwlp
   IIE6DsVEOMsKIzVrPzTO/94bG/1ymnz6j/d9uIXkSFuNoDaHpIXT2RlGH
   7HFQCxuNaC1q3E/WRxC5T0DqLSlRfehoPdn8IwC6Mb8l84uhYJh5CCJy2
   5BjGDzz3pnBvjjp+zmcwuCIbJUWANDpTKsDuPII+J8gbaL7r/76/MhlKE
   ijawHU+5WQZTnctnYQoO3Pw6vuR6DnmXFL4FS6PoqFLX1qI3B9QBYpExn
   A==;
X-CSE-ConnectionGUID: 6bPniroPQF6duhrEuVb3uQ==
X-CSE-MsgGUID: A8Qx0gnRRgOwNdIRay3eBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21155530"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="21155530"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 18:26:35 -0700
X-CSE-ConnectionGUID: 7c8nP+LlT86bZ2wsJaGrMA==
X-CSE-MsgGUID: 91eJt8BgQ+OTg8Lo79tO8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="61159383"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 18:26:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 18:26:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 18:26:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 18:26:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oir3VnAJclGWZIBHovgQr+Doa79lqgtBqzW+nOontkFVm2xyA1lTDIP2WEJGYGLF8/kbrtbQEqWBu1KFsz9cF6yomizLFDLI2m2BeYQWoIZ6EsID02kQiWbqql0ID+xiWW6WxVSpa0H65kaSmvS81PNm48CxABKcyy41bYGRnSiE3fUiYgIT4YU5q9W2vC5SSfjCdNi12DbroIgBO5kjVkHKodWhxKfTIeOoj8j8SctjjAFEmXcNTUgv6xCZ93ZAEVzQ29uobfibTYDML6Xw8B9OD3bCb7DFzqFIBwdwPXbdGSdhYPOIVwWeDaBxkWkvPdGnz2WW8t+arHfr6A6iNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAswnqTxyR0AL1wO3hZDl+AGRdn4nUiViTtBcji4kZc=;
 b=fA62+CTnVuDaLqM8ILbikFuTOWO//WB1OapnVEbqvSayaF2cy1PvelNmocm+ui+chXYryAdHnqCKvY5s8QLy+x0S2XzwWuBrYFHM7vWdpa/sibY7ApshRRgoKrtYJ7+lYBz/PVZ41RLJncf3MdNd2MTyLKJJtcsbCO3+YejC/mdT18kp/WGnB+BXuZR+AsiXimMw1iGKCcJ6eJ+B3PEd1qHxxJmfkvdB86dyPxT+nPLtO4I3KlOrFmFMzp/kgP2RjDDs9C28NXcy70iTO38DgHg92Y/8Cham7YRTKcRqZmOsa/BY3yZEOdSrvCYfrPHn1UPJ+Pd8PJ3zFejXUviotw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by SA0PR11MB4525.namprd11.prod.outlook.com (2603:10b6:806:9d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 8 Aug
 2024 01:26:32 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 01:26:32 +0000
Message-ID: <1aa667ad-8581-4cc2-90c8-1c2fbd0592a9@intel.com>
Date: Thu, 8 Aug 2024 09:26:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/pci: Get AER capability address from RCRB only
 for RCH dport
To: Alison Schofield <alison.schofield@intel.com>
CC: <linux-cxl@vger.kernel.org>, <rrichter@amd.com>, <terry.bowman@amd.com>,
	<dan.j.williams@intel.com>
References: <20240806041547.1958787-1-ming4.li@intel.com>
 <ZrG0wKU1XgEutEO/@aschofie-mobl2>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <ZrG0wKU1XgEutEO/@aschofie-mobl2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:3:17::35) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|SA0PR11MB4525:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ccffdcd-bb86-4798-4275-08dcb74922ca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckozTFRTN1NnVzh5QnBFU3Z1ZHlZWCs2RHJOZytXbUZFSUxSY1pDZDdGNmRa?=
 =?utf-8?B?WmxIK0p4S3RiMFY3dzRKeWN6TWxvbGJJajBuMFF5MFNZSng2aWR5WDFHeVNP?=
 =?utf-8?B?ZVF4ZkJaeVBEcktrK2ZmWEpIeFpUQjE1bmJaY0phcGp2TytBbGJtSTRBSjJu?=
 =?utf-8?B?ME5LOUN2NmZrQU5ESldHU1IrSGp5TGZPUm1OOGZ2Q2RrN2F3VW4vR0lMS1h1?=
 =?utf-8?B?VkJmQmZ3ajZFanF3aUZKcHRHOGFEeGRzd1hYaXBCV3pYcEZETlk3QXdRMnV4?=
 =?utf-8?B?THFnU3pkUXNUbTNvQmtDK1Rva3M2OWtDR2tOU0xMcFpJZjVyaWJHTVVGOHN6?=
 =?utf-8?B?ZGxYM1NQZTdOY21uTEVmc2VueXB1RmNjNkVRbUFsMnRyZE41aDR1VUsxQ1c0?=
 =?utf-8?B?YXhOYU5zVEVVT3FKWTlCZ2EyeGhiczRpTTBoNXlVSTF0Y3l5bENBOVlkY3Z3?=
 =?utf-8?B?NGJnNUFWRFFWWW5PRDE0TzNWZGs1RDlnbjJiSHVkb3dSS0RISTcrTFFla0Fa?=
 =?utf-8?B?VlF0eEljOFRTaktIeW1VQVFXT2NsbkltcVJ1bnFla3pFQ0RJUVU5V3NOY0RQ?=
 =?utf-8?B?N3FGNDB3TkVoWVVxMjRHV0VJV3o4ZVlGOFJQdkZDZG5CTmg0c1paUVdxN3lQ?=
 =?utf-8?B?U1dpeW1RZ2pZbCtsaGlSZDE4MEdJeTVxMWx4ajk2ZlFXa1NmNnNOekFJVjBB?=
 =?utf-8?B?VitTZDIzVStyd1pJR1AxTFlzbHdjRFZ0bHdOb2FTUXdKa1I1cmU4dENKYTdJ?=
 =?utf-8?B?Z0s5NzJpNnJOWmVYNWVuWnlhci94R0RrK1JuZDJ0OWJNaWtiOTRtanZLck1W?=
 =?utf-8?B?cURxQlN3NnFCQjNkbStEVFBYTVlJdWthcmpJaitvdWI3RU0xbTUyUnM0MVhB?=
 =?utf-8?B?c3lQNWRVK0FCSWhMamlHWWozZHNTM2FZeFpIeHU3OFJGbERGQUNXZmJJb1cr?=
 =?utf-8?B?L0VxYlc1Yyt1blRQdmNNNmNKeG8zaFRmVjRtU3JtZnpnbTR4UnNJQmY4Rm5K?=
 =?utf-8?B?U251bEpmNURMY0MzeTRyZXlXWFU0RHZmRklDUTQ1djJmR0MramNVSDNzdFUv?=
 =?utf-8?B?bmxWWXdDNXpyRzBxQ3A0T0ZQa1NEUFhJUUUrNE8rclY0T0ZicHMzTHp3ZHpL?=
 =?utf-8?B?anoveDFKbldMWWlIcGpITXc5dDlBR1c4d3NvNnBaa2JnUk1aZm55RjRpNExD?=
 =?utf-8?B?b3BRaUNsZGoyeHBRRWYwTm0rRkdGSkFZZ29aL2REeTJjZWFOUXZwNzlwSVFT?=
 =?utf-8?B?OTFta0JaWlJlT1Z5cWNldVpPb2dIM0pqMGVvZGZuZmpWOEsvaDNSb1V5ZGxy?=
 =?utf-8?B?Z3YwSkc3NUtqTTRudXY1Uko3VlByS2NQVklIUXZKenBORWJkZm9kazR4SmNK?=
 =?utf-8?B?bytQMXBPMFhjRkVsdFhva0g4S3BDZFVCNWN0VFErdGhkUFY2dWExWmdWdnVy?=
 =?utf-8?B?S1BKTW9LL3o0NWo0WElIWkorMU5uakpoNE1PVmIrQ0E5cmhoUFdIOXByb2l6?=
 =?utf-8?B?YldlWUFVa3NSQnE3Y2ZUNFJ6Wk9md1ZzTlZrWUNFRDlNM1VMdzkxTEhVa1Fm?=
 =?utf-8?B?NGY4QVFuR3ZMY1A0UCtRL3ROVjRnZit3dzJTZkdNd25UcXhTd2Y4ZzVjV2Yz?=
 =?utf-8?B?VjJoZ3NhQ29MNDRRNld0VFB4OGYxK0d4c0x5YnBITVp6a0RHcHRXcFc1N1ZN?=
 =?utf-8?B?cDErY2JYVVRpeEpqUDNlNXdrYXVFdlJZVmF6VVhTWk9nQng2SG9UZ1JRQmxJ?=
 =?utf-8?B?Vi9leHFEWFJNTUVOeFRvaE91MXY1S3ExZUV1RS9ma1c5cURwQWwzanA3SzZE?=
 =?utf-8?B?Y2NuYys4R3pTTVNLOU5qUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blZSb1k5clFhMjcvL1lHdXpUVnVkMkhzWXdBY25WcFdqcmxxWE9SeThCSUg3?=
 =?utf-8?B?cXVHTjdURzZyYmZGMkt1NTVHdWd6VUdCWFNGY2JEYkNGL1FtNHFwbFpVTkc4?=
 =?utf-8?B?NW1qSDBmU21YTlVNU0JzbENaUjFmVU5lQm5PYUhSa1ZVcGtNc0NEcklncjhm?=
 =?utf-8?B?WldLdlVzei93ekNiYm5ZVG5Gcno2bEVXUHFtK0YwQVVxbnc3cWVBWlBUZUlS?=
 =?utf-8?B?UGxvU2tJSFRKYlQ1eHBQS0kwQ1pwR3hSYU94M3IxTSs2RWJnWHlxS3pnd3hH?=
 =?utf-8?B?OS9iMlFOOEt0SnRPWUdrdVgrcTZvVk5WUzFCUkFoN3cxZ3RHRVRRUFhyTUpt?=
 =?utf-8?B?a0wwY0ptTmZPWmE4RXFwMzRjL0QxRGlZQzlNT1l1ZTZFR2NQYmprT1cwYXc2?=
 =?utf-8?B?MVNOZDVTRlg3UGRQUXBTN00rbEU3TmJaTW5jRk9WbXhZRE1VSEtzSWd3VExi?=
 =?utf-8?B?Z3hmOENpelU0Mk5UMVFyYTFiUlQ5TDI3Q2p1VjBCM2RSYmNSdmFUNkRnM29u?=
 =?utf-8?B?Y1dsZnFnY0FObDZ5YjlNZjdXZ3B1dklMYUpqVnJ4ZUxFTm5uQ3VFMHJHVkJh?=
 =?utf-8?B?U3FxU2lpeU9IOHVrd0h5UGYyUG1qVHBtbGhPenJGWGVnaFQyOEE0RVBIN3Zv?=
 =?utf-8?B?Wi9IZFMzZDl4dFhkallZWTA1enRWV3RQclVaWERWU0sxWlBKQ0lLWHd2bFJ3?=
 =?utf-8?B?L0FwTmI0aWM2anJnV2FLOGQ0c2VBWHMwZjF1eTFkL2pHaGgySFJBQmYwYXBL?=
 =?utf-8?B?WkZPRVVnUkFRN2tsTHRoSGVWZUZrQkluSkp3b2JmYzNoMEpiQkVXMXhkOFhP?=
 =?utf-8?B?ejVkUzd4endBZDlrODZxM3BtVnZRM3RNRTVSTERiR2pKcVNLcDNqTlNnb25o?=
 =?utf-8?B?ZThXM0FvY0RmQ2JSV2EvakJvTkwwb1o2VUxVSzJIdXd3NFBvMjU3ZUdpVEZM?=
 =?utf-8?B?YlI5VEdiMVRKSWtSQ1diOXB1VWFYNWMwck54dmhyMGs2MXpucllsN0dXMGRm?=
 =?utf-8?B?UlRYZjJqMmhrSmNnZjZoZDFUSkJRLzZac0Y2aHJUYmNGTDRjbXRZSGFWVUR4?=
 =?utf-8?B?a1g1QzBmSnJGYlhGbUgvd1p1bkhvenVpUUFmczB1Q2dNSUJ3NDdPOXN5UmJF?=
 =?utf-8?B?dDFZMWNZeDdkV0NDVTVwT1lqZW1Ua1pFOGIzZi9reE0rMmNBYlVGUEZQUXRC?=
 =?utf-8?B?M3JvWERacVZHSlJxS05pTURFUE5EUHBqZGpTMTl2ZmhkSWdPZjFpcmhRUGN2?=
 =?utf-8?B?Nm9kZkh4R2lUWnlQWHRWeWJXaVJxcmZ3U2Qvd2tneUZmelV3bEtvTFlxa2dM?=
 =?utf-8?B?VWVocm94eEE2SUxWVzdIbit5b0pmZHI2cHRMZThqcGczODVON2t5MFhOQkgw?=
 =?utf-8?B?UjJ5SjcxNkpNOUdkV0Z4ckloTytEeWRTc21YSFFuVDd3TjY3YjhlTXZGV0o1?=
 =?utf-8?B?bnRBenpWY0IzR21oTmhEcko2YlFiTStuRFRZRDBRTlNTRzJBYkJhMXdOV1VO?=
 =?utf-8?B?dGJHdjIxd0Z5K0xMaU1vYmh5UzZkSi8vZkJxUmVQVnNCeEY4S0hycGNMTlFJ?=
 =?utf-8?B?aEcvS3lJVzBSSWlSTVJrN2NRNzUyNjdRbFAzMG5BT0dlRUhXbUY5MlUxYThO?=
 =?utf-8?B?WHUwMGpQcnJIQlJlYUl3SWxnMCtjSm5wT2NEcCtpZmRuNFR5UTNxMHlDNVhw?=
 =?utf-8?B?V09seXhJT2FCelptTVFuYnErVzlqcjJxNjlwNkdkeHI3NDJtQUszdWxLNjZD?=
 =?utf-8?B?S1J4MjRsNldabjd0MlIxNDY4aU5IL0MrWjRMTlYvR0dnRE5EL21HRFJRQm42?=
 =?utf-8?B?LzNRK0xDM0liczdkVkk3M0NCT3c2NHpvNUREcHlWd2Njd0xKNGpoMFRydGpu?=
 =?utf-8?B?Z2h6dXNFbXhiMi9aR0VsODcwZmJoSk1DY0FObnY2emY2Sm9kR2FaUkVHMFdl?=
 =?utf-8?B?d1U2aVlIQ1lkbHE0Tnh6MnZHSXY1eVdaVzZnb0RwNU9IZGxlMS9kMVUvRk5H?=
 =?utf-8?B?VXNQYUVFcG1kS29YYWRiaDh6cHZGQ2dVcmN5WE1ObXBnRmJ0YTd0YlpMMko5?=
 =?utf-8?B?NWpndVViSTVabVNYcGk1S213VksvVXhqSGJvSkRzNUZYL1pBWTdTc3VlNnIx?=
 =?utf-8?Q?SizDIDW5o1PVqu/hpsDh3N6UZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccffdcd-bb86-4798-4275-08dcb74922ca
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 01:26:32.6858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7JBeFuKuPkS4BFLTbZrDu/ItG9JlIisJVTn56MXrvOAdyqzX58YZqiPVlAvfbQyR/tcJeE4SZApHcHQEaBmsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4525
X-OriginatorOrg: intel.com

On 8/6/2024 1:29 PM, Alison Schofield wrote:
> On Tue, Aug 06, 2024 at 04:15:47AM +0000, Li Ming wrote:
>> cxl_setup_parent_dport() needs to get RCH dport AER capability address
>> from RCRB to disable AER interrupt. The function does not check if dport
>> is RCH dport, it will get a wrong pci_host_bridge structure by dport_dev
>> in VH case because dport_dev points to a pci device(RP or switch DSP)
>> rather than a pci host bridge device.
> Ming,
>
> Please add that this leads to a page fault. (from off-list chat)

Sure, will do it.


>
>> Besides, cxl_setup_parent_dport() can exit simply if a RCH dport in the
>> RCH topology created by cxl-test, in the case, the RCH dport's dport_dev
>> is a platform device, and RCH dport with an available RCRB and AER
>> Capability is not supported yet.
>>
>> Fixes: f05fd10d138d ("cxl/pci: Add RCH downstream port AER register discovery")
>> Signed-off-by: Li Ming <ming4.li@intel.com>
>> ---
>>  drivers/cxl/core/pci.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index a663e7566c48..f8a3188f5b17 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -4,6 +4,7 @@
>>  #include <linux/io-64-nonatomic-lo-hi.h>
>>  #include <linux/device.h>
>>  #include <linux/delay.h>
>> +#include <linux/platform_device.h>
>>  #include <linux/pci.h>
>>  #include <linux/pci-doe.h>
>>  #include <linux/aer.h>
>> @@ -834,11 +835,16 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>>  {
>>  	struct device *dport_dev = dport->dport_dev;
>> -	struct pci_host_bridge *host_bridge;
>>  
>> -	host_bridge = to_pci_host_bridge(dport_dev);
>> -	if (host_bridge->native_aer)
>> -		dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
>> +	if (dev_is_platform(dport_dev))
>> +		return;
> The above, dev_is_plaform(), is the cxl-test only case - right?

Thanks for review.

Right, only dports created by cxl-test using platform_device as dport->dport_dev.


> I'm wondering if we need to mock something differently in cxl-test
> because it is unusual to have a cxl-test special case in the driver.

Make sense, what do you think if I implement a mock function like mock_cxl_setup_parent_dport() for the case? The mock function can check if the dport is created by cxl-test then skip it.


Ming

>
> Let's see what others say.
>
> --Alison
>
>
>
>> +
>> +	if (dport->rch) {
>> +		struct pci_host_bridge *host_bridge  = to_pci_host_bridge(dport_dev);
>> +
>> +		if (host_bridge->native_aer)
>> +			dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
>> +	}
>>  
>>  	dport->reg_map.host = host;
>>  	cxl_dport_map_regs(dport);
>> -- 
>> 2.40.1
>>
>>

