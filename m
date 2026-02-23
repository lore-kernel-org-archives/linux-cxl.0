Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C6F33121E
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771874617; cv=fail; b=TFD0OlToAKIPJQWebdlbVWAQW0opbB4VJNhzKIfhTnNKJ6A0ePqvct4Mq0lfccvLWK4ymt0Qou+OWd43Xm6ffVyacRyQJdMLtp4ZkGRE+NnpMpeqEBY57IR6VUeOMXGARpJSOHbUokMdIy15MLaRS6YTVtXtHChoVp7zwwqHmLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771874617; c=relaxed/simple;
	bh=uxeOzpGj/SDIrMZxu5JkbhNDcsRmkMKFBjm+goHi8zg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LS1vOMR4Mf3uoIrtfIgRM/6XYmRHuCbJ9B1pP95ux6HH25S/mm54Vx4Py7ZRaXcvY9fSPOoiQ+ZotdvsqhRINvaEcDPT3/632FHm2t9S7ndEW7z5Rh5NpGoNDLfWPmmCC77xQ+uFjGXUINaDjCOCBx4qwxWNyOW47TmxlFDQaKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVGmeELP; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVGmeELP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771874616; x=1803410616;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uxeOzpGj/SDIrMZxu5JkbhNDcsRmkMKFBjm+goHi8zg=;
  b=mVGmeELPNGmtyF713VIjaxuI5uy6LONRggAHdWUvxnJCJkOtTsDeXtfs
   WAeTy0A5ljsawH2sd7QwZZA5cPhYD2yFqh2cyhcp9g90WKDCHj8uN2hbw
   WCwaZWv3WZAP9+FFI66sUiRw0283cEeUv3zlkAcfMv+xioouPQJ/fTLOm
   MYEUYtX+C9Waj7WYxLJ2eBJi+kVCNyef+YBQ9v5+YYln5msmDhhhPVCNR
   FffQdkQc85Hhv8uFGRnK8hdE3VTXV9BcTGsvMi5CRgw6fuZvowywZeUKJ
   EoEfv93PYI6jeKi8P6Dbg7PQMgSbXE70QeoK8940Lk6DLmTPg/mcWcKZf
   A==;
X-CSE-ConnectionGUID: FC/SHtoIQQWGYAELa3iL8g==
X-CSE-MsgGUID: NbpnkCaDS12f1PTzbKs5XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72982084"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="72982084"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:23:35 -0800
X-CSE-ConnectionGUID: aVvTqfHcRseO/O/Pvlc8XA==
X-CSE-MsgGUID: 0MaRlp1+SjydHH6oa+ACjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="238622579"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:23:35 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 11:23:34 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 11:23:34 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 11:23:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgJCXVbnvEDZVQ6kFbgUSjQkqs/vzkKksdfJyeddzpkuWeK/we28qtB8DAeI+x6oRv83luB1HXMYuwHJrehDCSfBiNCKkhEYaaRO/5HRH3YydDc2JX4vwnL8P4OUu7PRnVb7tctnywJcJzfHhDjTcWRwks910nCT1LZL+NKmUH4dDFchSM/HzzerhEOKhZgTZ1U+aWFgAhIcyC/JFe/uLMs2E9J4OtxQl6ijCDVLwJm4yshNMH7DTpPh/q/KPCkwlGvHoO0PbLEwBmS51CAPzcCzEZcr/oO2OJGEmFJvwsBPfs4wsG3QUHKw2xpT+QjZjIUorRBcwACXra3+QcWgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMcwZCm4KWZdIrJFbqRgMccj3q4DMe8hPbFLlF8nkuk=;
 b=pbB7zEHy66qekKJD0mifDRdgbwpAZGsEl+45dkWX7LnKkp6NKM2pKS2q14dYqeotE5T+PkzjiyuHJDpudY0K69h2fVA59p521UmhKR+8MycDo0+6BBe/XNgnMmea2tvYXhkFMeZWplCqVUILgqEAiT/8TPFBM+O2rKeyCe4x0QVmtIcD3SXKTPz7awvw7iHCH+IVHkBiPynucscfQHkerTaIyk1Tgzt1jPptqimw2cupsUYxJAVvZ699WoelhX4+vt6Ge1Kab7IDSy9A83XjenGCEmIh+TlCrxk1h7kgV9OOZdbcu2lm4tzm2cU7lHIL7zaNF9J7jg6mm9BnDhfAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH0PR11MB5315.namprd11.prod.outlook.com (2603:10b6:610:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 19:23:28 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 19:23:28 +0000
Date: Mon, 23 Feb 2026 11:23:24 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/mbox: validate payload size before accessing
 contents in cxl_payload_from_user_allowed()
Message-ID: <aZypLDJLdhqfpTHn@aschofie-mobl2.lan>
References: <20260220001618.963490-1-dave@stgolabs.net>
 <20260220001618.963490-2-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260220001618.963490-2-dave@stgolabs.net>
X-ClientProxiedBy: CYXPR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:930:d3::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH0PR11MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: 822e03ae-995d-4a20-2425-08de73110599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?slZw/wGXlKiPdhvszSSd3Dnwpj8iMO6N9wCUGBrzt1FOqqqH3UrEME1uzMWV?=
 =?us-ascii?Q?22AQnthZXpvKxDAyLWALHFnQbplmi/z9QmlcEeZ3Oc4jE8VSresuXnnzYYua?=
 =?us-ascii?Q?VSA519ND3AoO/MHM6jWtfZIbirCSC4jZBNq7bTp72VwVUB6p7Si6uPUEC/DV?=
 =?us-ascii?Q?HVWb5hZiVs+AV1CIjOTWLCPvrWjxNmSEoz2Eapc1baXCJVSLZ86DmZWqEI1M?=
 =?us-ascii?Q?EKMBz05lCZpur5qRyf/daEkYppx0JUXt+/uS/QD5ax+glsdApU/P7Tg4J1IP?=
 =?us-ascii?Q?zYTks8Rxymw15FskEMNFonDmDyFxrTgr/00KkXkQ7vv6vJTQuH4PH9Wefk+h?=
 =?us-ascii?Q?im9lhnkkWHqcaEXAyVoMGgOmuL92roa9UEXsTXwquhZjMhlIPbd9RIpdeylP?=
 =?us-ascii?Q?91pfGNhRYqEe2FaM3c1kIB48fB3FYtsa4lbv6dDOFpeDO5+M4EmqNdE7PHH/?=
 =?us-ascii?Q?qH9+FtMxyb8h++zU8XEpaKwn0HGQOuEcZGi46XBW9kw7Px/iQGQW3MBf+0Pk?=
 =?us-ascii?Q?MOhRhN/Ti3zZxRsLROL46rRkjBKU6z3VdVc10wr+kTIAmKUz3VAxJOhJmmNY?=
 =?us-ascii?Q?CZNdSn70HQgEWHUHEnBy4grLnxB70zpBCOB4yc7RGLf6hNdoKOxnTvkOVsaz?=
 =?us-ascii?Q?TFUJ7s3QBjKj401K+kgKCUAHLI9PoRE2l37PkHagPRJSWwrh1vB5QxZzqs5j?=
 =?us-ascii?Q?WT3OMHkkmT4wyyJSefgWmQxEqEZNlvCdv4BEH1ad0wDnJftQFHGrWtMS9nys?=
 =?us-ascii?Q?bxbi/FTNCsh/wskQACRobO2567RMOHxrLt8FK5he3q+/GyrYl+pQp+1OaptE?=
 =?us-ascii?Q?t3ZWi527FSeKNPfzkrS6kxwrNv1UKF2Ei3sbyAemakeIz1BUTvXfpPY3mZeX?=
 =?us-ascii?Q?W+x6JoFqOVntU5dmoNct7l1gSTOsEIy0fRPxky8b14F+d15php3LGrZV6xCC?=
 =?us-ascii?Q?TQW6ngWxz32zBBZm1ZxukiM3/PRETY15TjuTc/hONR3j2+9B7GAPdplQp0Q/?=
 =?us-ascii?Q?KAkKCQ9YuEnKkD7ga2jMgvkcD7sv33DbZHjZ1jP5MWXbSRI1UZFTJI3rmFco?=
 =?us-ascii?Q?Kc4T7g+OEESy5MHdoaEkXRIZ9TrwegEWB2BQCfmwUmfvQSg0wfgW6yZtDB7u?=
 =?us-ascii?Q?BRAe3eV2nmIbLJGJNNRJugQnX4jSRceXLJlc5wOuQN7IEMWcUZiiQtCFr4Ql?=
 =?us-ascii?Q?kcvIOTzKmuNwlCtHfrSeoS+H7nOPQxI73sd7muNHokrqgEV+tNa+cc8743hu?=
 =?us-ascii?Q?ugpCivjqZ+XozL7HXxtzG9jHLFAS7D4izeIh/BBzsqBA+8V5N4nBnjmSg1DP?=
 =?us-ascii?Q?fCv4byHe3NxMp9axBzW4EiS3erWxLRLYIca39ltkbMWYReNOz3wDThuRjbm6?=
 =?us-ascii?Q?raec2/UlxOUKwS7Ex+MRxg6gY12rM+hCkOXrkb8c02+FzIhp7okZzJyi0Lnn?=
 =?us-ascii?Q?S84I42Am+3uVQvgJd5sYADOY1JnkOr4SeE8mwkLKskJFES2COQCh8TT9Gu29?=
 =?us-ascii?Q?dIRn4H/vI+UwhBrFaMlCCjugNG51zjKms4qkBsUJWjvZHYZdaChXAy2q4cgw?=
 =?us-ascii?Q?U6igfxPF1oWXG4MkajE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGxNdn/ZzhUYk46M8oZxNQWxN1lAm35Tyk8XMmXc3ZU9ySOEOkRvutlSns1W?=
 =?us-ascii?Q?h/3WHwJJv4DMjO/twRUEcP1eWOcirTcCKbsL3/CsRwVOuNP51csNcT8oowrm?=
 =?us-ascii?Q?+Ge5i4PgZvAVeYf6IR+cBBbh1gHDt5+HJmpX4wP+Sf0wL4m8GrMJFxDSsycm?=
 =?us-ascii?Q?IiT/+vpsAZ2tJ9FGyCjWR434reldjCgPq5DdVzCDHUxYhDEXb7BkzAgzV4wW?=
 =?us-ascii?Q?R7dikaQPp7ITvzH2gdC0VQsnMbDmmcsElhdKJ9VGdCuh2ZP2lejvdfvP6q5X?=
 =?us-ascii?Q?f7xAwSN4oqk1HHTJ4SubnDeNTPDxaa3DOHS0Vq0cGMD/FLeQWTgP7LN7/sRS?=
 =?us-ascii?Q?lrFO1Myf9dDUlGoX1FbzMmoGSXZRClaqzV7AAHAwQWdC0qU8lrtR7fyDIsdf?=
 =?us-ascii?Q?b10fHu702/musFwmWQ+fkUmjnLAuShnVr0OzctMBZYAkc2aCn2V6gEsrr+bn?=
 =?us-ascii?Q?jGc7yvW9tbIvuX2HFBwXQWFcqXs0J/LCrM1pzvAaBCYC8hqe4lQBhp+ywjdx?=
 =?us-ascii?Q?lx91tzNcO9DwTRf9miwonzU3RiBNYV0R5FB3UehxsLumBx3yuS1WbOB7HQd6?=
 =?us-ascii?Q?hMY8jzufntASDub+SJkd6JTVqUK+uFt2WVEh5UE+qFK3+QWX68m/ISJpF7zV?=
 =?us-ascii?Q?22R+k59VN28Hs7xbq6j6e1xfX8W8E87Zp5Tbok+jpRjesEm6gygjdkgDulsj?=
 =?us-ascii?Q?K/yPBV6PJn4K5iX9LY81gtWFECET33kLKAfKPukw11N0Oe2Eu/P1IgoryY9L?=
 =?us-ascii?Q?Prvv6YVHrSjSsm8pMQ4SlssZJ2WTWAop9HCMz/ZO/47doQUVJwfORo7EUTQy?=
 =?us-ascii?Q?fGINAUxho3NNfUQN+vgFLwmdGU4jONEWtMetZHbl0Z1RUcfVXs8Tcj9TBcF4?=
 =?us-ascii?Q?sI6b0vE2EyaijHIuOi9efJYuS63pDXrDYGllh2tUSwPw2M2IbxgjJSjuLW9u?=
 =?us-ascii?Q?zcIUlNST6h1M8tA68GcUzr0GAM7/OUD1mBr06bH6QQorWMAsh4l3AdFY4ymW?=
 =?us-ascii?Q?No87JtPwD3MHhh6igcqigTy5FniuelJY+Oc+RCjfuEuSTulEcqXMjVPNXZxt?=
 =?us-ascii?Q?0TBiarAL+DwIoxJWd6rjCNa/vhbND/3LeCoauqYC253MIcycKJ3GUZHG+WY6?=
 =?us-ascii?Q?8e1dg9CrAq9l9/fHK4b2rb5Y8cIezv6Lh8iRcGreQF73xXl4OPnDN2vtHHXe?=
 =?us-ascii?Q?A/LLezhid4+fwmuB7sQHpPrKnSztCO7UHESJG0AJkZHAlpDPVJnRusYgyfFH?=
 =?us-ascii?Q?v8Xjojql0MmYapanLN26RZUSDsHT8kmoTaKbJAyoqV1/ePaGmoUoDFL/jjbO?=
 =?us-ascii?Q?6gJZEtUpaL9nMLp6m7cOoUQijmfpn3LdosOZtJOk+QvZNc5ULA+jDGxjmK/B?=
 =?us-ascii?Q?Nseze4Kj68r1cHM+v06Q9OFRNRhQlOCdKKZ2izx88GW8IGieg/AIhscbgUBb?=
 =?us-ascii?Q?DyyRHO/lvc1Q1vqBRkXS0hjaPumNVtk+lNfdpPm7JR+hkqgoyGFBzhikBNvc?=
 =?us-ascii?Q?0mJlv1d2xH1Xr/8EYpEPHo1stktuJDxloUXL4jE7YrHgEMd9psg36+kMtNvd?=
 =?us-ascii?Q?MO2wDto1BSzPu7dPvbQLkzQoZLW2MW7Fozdy13Uvtl7UGPwjoooK6kaHGkl3?=
 =?us-ascii?Q?NOl+sMasE4mY7mk2eUGwZvk8bpoP2cuE7vtdVWliYnOKtZSNkllT9xwGA4Sd?=
 =?us-ascii?Q?vpHZf8Gd/8b8Q5TxtzgXt/jiho6Pouaydntc3uWIr2J3o5IabzoZ5iqz7C8X?=
 =?us-ascii?Q?UhbxY/1VQigeUYNxWnvhWghDTfBjASw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 822e03ae-995d-4a20-2425-08de73110599
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 19:23:28.0814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exm7u/DyynM8qJEFyYjF1tXlQMB+afyrMKMJKCwpMs5jePpnWCn6EcP/IjUdMaoZbe0yCHGMbeJ+yd9W5YyVImPvM7+19BrLNA5NYWJhEQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5315
X-OriginatorOrg: intel.com

On Thu, Feb 19, 2026 at 04:16:17PM -0800, Davidlohr Bueso wrote:
> cxl_payload_from_user_allowed() casts and dereferences the input
> payload without first verifying its size. When a raw mailbox command
> is sent with an undersized payload (ie: 1 byte for CXL_MBOX_OP_CLEAR_LOG,
> which expects a 16-byte UUID), uuid_equal() reads past the allocated buffer,
> triggering a KASAN splat:
> 
> BUG: KASAN: slab-out-of-bounds in memcmp+0x176/0x1d0 lib/string.c:683
> Read of size 8 at addr ffff88810130f5c0 by task syz.1.62/2258
> 
> CPU: 2 UID: 0 PID: 2258 Comm: syz.1.62 Not tainted 6.19.0-dirty #3 PREEMPT(voluntary)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0xab/0xe0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xce/0x650 mm/kasan/report.c:482
>  kasan_report+0xce/0x100 mm/kasan/report.c:595
>  memcmp+0x176/0x1d0 lib/string.c:683
>  uuid_equal include/linux/uuid.h:73 [inline]
>  cxl_payload_from_user_allowed drivers/cxl/core/mbox.c:345 [inline]
>  cxl_mbox_cmd_ctor drivers/cxl/core/mbox.c:368 [inline]
>  cxl_validate_cmd_from_user drivers/cxl/core/mbox.c:522 [inline]
>  cxl_send_cmd+0x9c0/0xb50 drivers/cxl/core/mbox.c:643
>  __cxl_memdev_ioctl drivers/cxl/core/memdev.c:698 [inline]
>  cxl_memdev_ioctl+0x14f/0x190 drivers/cxl/core/memdev.c:713
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl fs/ioctl.c:583 [inline]
>  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xa8/0x330 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fdaf331ba79
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fdaf1d77038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fdaf3585fa0 RCX: 00007fdaf331ba79
> RDX: 00002000000001c0 RSI: 00000000c030ce02 RDI: 0000000000000003
> RBP: 00007fdaf33749df R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fdaf3586038 R14: 00007fdaf3585fa0 R15: 00007ffced2af768
>  </TASK>
> 
> Add 'in_size' parameter to cxl_payload_from_user_allowed() and validate
> the payload is large enough.


Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Fixes: 6179045ccc0c ("cxl/mbox: Block immediate mode in SET_PARTITION_INFO command")
> Fixes: 206f9fa9d555 ("cxl/mbox: Add Clear Log mailbox command")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>


snip

