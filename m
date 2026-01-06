Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049A43596FF;
	Tue,  6 Jan 2026 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767724974; cv=fail; b=Qyy+H3m6fZcH3v165K7pC3eoUBGd5nc5sNrmFoqIgctiK7RUh2LBxaU42XvnJKaXgZFX682qxWt7DgnlIdvx+cYZiwstSDTrHGBjSP6U2NZIz6Chqo40ttdyDIQadt4KjazaPEEdEIfCfLqS1BsrjMaXwFsSQI4rHTN8g4xd5Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767724974; c=relaxed/simple;
	bh=i+BtqzkCJ2ODCeTig8zF+CiIfdbJb1ZqDUgaDUBjHmQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BqewSqxZrhDeuNSvd4OpPYC3/6N7MqMhFR0UZ/LGPYfr3kNAHFxkVgWzEuA2W4Ke70NorIQrcYaK+m3FWrbmsuVPo4TRpnc4DkPLaOLOynbzQ2NypSvw9uz10Os4VL4QD56NmIxpoWiflZeyzdTWXL9RZnByFpPFOyHEagvK6u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckzm/AIc; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckzm/AIc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767724973; x=1799260973;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i+BtqzkCJ2ODCeTig8zF+CiIfdbJb1ZqDUgaDUBjHmQ=;
  b=ckzm/AIcqMbCLoC3svCmDM24A48SE3QCQ2ygEplxsqKosE6Bibfd3MJt
   gpGS2MFhsO3AuBwM0jn8uGPvKnzpK9b3RdncuLDezhNhlC2fqUhTOzr3g
   J0Y5bdN9ARvSCzj0RCPA02Wtomt4ylCo6HwPEgIao02/hLLq/FGcPiqdO
   KV/BzoxHnnO/FTm91QNggBn+4hNOmMAvN9IYnzgvJEZ22p1yj85LjqLPK
   POpAVTLy2HP0/Z1s9xbwXV+VDuEFWioijhkbLfhMrqomhDBiJTCKJjb69
   bWdMrHh67/0wknqstP1utmTb5h/OtdENWx901QQK3/TVz4wH6rNb3SH8J
   Q==;
X-CSE-ConnectionGUID: +XdEofrhSjWqy0ZNupd/6A==
X-CSE-MsgGUID: HGN+2pnnTw6GstP7IM5xvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="72951804"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="72951804"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 10:42:52 -0800
X-CSE-ConnectionGUID: ilMXKdj5TmGlcIkfco9/Kg==
X-CSE-MsgGUID: +2zp59Y8SMO7Cdepbnb5VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="202978982"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 10:42:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 6 Jan 2026 10:42:51 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 6 Jan 2026 10:42:51 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 6 Jan 2026 10:42:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4qC12n1WCwWodAiMGrN6W9B9iW7J0Rj/kxTSEfeTFlchVQhn9feInSV9XotQWo/br+L9EpNyYUBBHNzylCtL/RgMZ4aKpxUmFJUwZT5aLasHBvKrurAfmAOhJsk1HS71LzuvG2wpcfRUoy4Ljh7y9lk80lUO8OfZqdkySjm3+vrA7QERp1Gr3Cgft5uwJUOiF/BGM1LyO1R+f5C3IGrq4XxSe25jM+XAfX7IDs/OteIPrVP9HE+Iv4GYmwrht+R/hsCCEVWk2mPunIsru9Nhd6ZD5VQ4e64VvIG+omqXP9lYl/sV++TTErPl14rQnYgK166Yqsuf/i0muVLEvTzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpkU2BFwxtdMc18PnvLuyuZqiYZUbujw+qDPu3JOIvs=;
 b=gozTOQ5T8PcwHJVFoidsx2q27OORx8LzqD5WrYniD4qNjHyYAOjA6jduF6jNxoCvAMAXVJX9W3A8ExwCZu2S+bAs0DHQdkHUUrEtkm2WC8EJ0VlGQIGJkhy6Jb2zMoZRvcZgrcBgabj9qNQMgAM2WmWdeJpLqjcb2ajCOSzfbVTA2R8UfQJrrhcgu1hYDO4GS/11/4iLhYD742kvWz8jOfSo/gkTqRcFCwwCaJVuQKNZejjOrekXteQBeI/4fdo5uZm1Aw6ypdmsLLYWSbgaR6LNIPFBj59kVELMI+2cv58AMgwE0KJKNvW3OTvJuldZvW9/F+UIG0vAsH/7gTbDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN0PR11MB6112.namprd11.prod.outlook.com (2603:10b6:208:3cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 18:42:44 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 18:42:44 +0000
Date: Tue, 6 Jan 2026 10:42:36 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl: Check for invalid addresses returned from
 translation functions on errors
Message-ID: <aV1XnLrAiONbeA_X@aschofie-mobl2.lan>
References: <20260106172358.350724-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260106172358.350724-1-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN0PR11MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2c137a-1eeb-40fc-f63a-08de4d536110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F+8Kbrw4AvPkro/k+zWi7mb0K9piKVC4Roden8tQ2XExHS8InWVODGTP94Zd?=
 =?us-ascii?Q?MtBzJxnPZB+4GZBXpn9FcF/RcLknWKjXc6PLvyBFEFzvaMkT1CeEHfkqPiA6?=
 =?us-ascii?Q?vUg3ROoau5N5MnGSG6qLnuy932ySQXoFn0HBo/DI3ay183br5dDi1VhqcdfP?=
 =?us-ascii?Q?5KwVhl5JqGeMfp+lQHzs+xCPwiiwGalk8emA6O8l3hP5RwV4xVdQ4mIkuaoa?=
 =?us-ascii?Q?rKjWT6N0cPededI3+R4QOgF6VG+/C1AAARRu+8g68dr9SBI3F64HjgjXmXrT?=
 =?us-ascii?Q?250UtU5iez6Em51+TA5IYSgTqJLKPFnonGsCqy8Sai+Smk/MQQMkRjF8Hcay?=
 =?us-ascii?Q?6ZB3G0fW9qCeFjNz2eqWCXSVUTN3PhXqwTvsw8nI3XjVphnCU+6CK9MVPcun?=
 =?us-ascii?Q?mCTOC9Uk2NNBbEcPxnGWx4K+y6SZ2AffySsakngqxuxRb1M0k7drkMvgH7mi?=
 =?us-ascii?Q?8Y9fVSZE6JQCi/LuP7s942EhU/ou8TiemoV2esbr5WRFdoFcJE5mZPWHkXHh?=
 =?us-ascii?Q?8naHG8wEVy3nV/CyngjOyfadNAQd5+XDupeV3kH9xWniXqYJv97LmUJZs11K?=
 =?us-ascii?Q?JjEvEDDT9ma9XaAFMrM94s6064muK+LokHbohWE85pcSw2hoEm1PyDUGBfdw?=
 =?us-ascii?Q?Mq/VkgyZq2ILZ2MaSPdLmFvvtQJb89BEHbdZkjiambJRc0ptJOnjHCciaFyS?=
 =?us-ascii?Q?M3VbuBuVp3HDzr63DZGmoPX5ZjBoyU3QOGkoyzYq3NEudQegv95wkpf7dujH?=
 =?us-ascii?Q?nJTNdC+4DGy9UY0cYGnmU8EImOLl6sTky9YFCjXk9oLnacdp74eDPuKeWMly?=
 =?us-ascii?Q?78+QGTyG1mj/idWrsIdSCUH6yi/Z6E2HVNPFlYO0WPDOlUvJlgrIWYlsPtCu?=
 =?us-ascii?Q?dT5eyxbuMXzrli8kmLogQCN2XxPwpecs+bN/gKxzEFUina1cZaw5t9EPj2gE?=
 =?us-ascii?Q?PgBut6GNYXQiRffzzNvZeU8uGX2cMyWpbVnv7My7Nq229/K+8ChDLMHSCb36?=
 =?us-ascii?Q?QATF0Im8Vq5jvfUKi6V30sPquTbFaU5ZWjDqRdm07u+IOMh1l36i0VKm8aOV?=
 =?us-ascii?Q?YmaVRRHpE2miaaFC1ZxuKySCq1InL7tF2M8Nbys4dbXabrLRJshUaOqHbK/R?=
 =?us-ascii?Q?vsbtaHBvh3s5fXujWdYctCRfZza41GwGsCH2YcD9KEHFI+i3TF33dCMkDGRR?=
 =?us-ascii?Q?rgIoJCBhMSmbjz+r+Yi5nI4Y9NnuZ2dqbpriztfooRjbZN606NxVJ65SB3gy?=
 =?us-ascii?Q?rLgSqh3ruonlJm3zAfzpJFfDGsUjKMW9U7buC1bou8Wc/o9Tt4eMZ67arF7b?=
 =?us-ascii?Q?ILODn4IuEIIvTfBSFqUclf1Za8mDm6zCF6LFaa/4HDt12AoHexsN2AjJkfhm?=
 =?us-ascii?Q?bITq67m78qTbyknnj7GEuHJU0uSgq8cW0tjfcdHXViR94mEDr7mDldoFjPku?=
 =?us-ascii?Q?xxxQ+PURlilLemouwPAO6zsOiNpDZjMv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g7OA/WT9dA54IffdC+oYMvltGdzO9o7SsJA8SO1qw+M8hSVAJYcLM6wmaEMR?=
 =?us-ascii?Q?fRqsHF26vyzL08UZoZ4gUiECY5b6lAQcYehf3v475BF44qjueA1uTj8Cw6ks?=
 =?us-ascii?Q?gLJwlEeTmb2hFSyxzC5liChEkDzfplnZgtrIXkvnyu4c9liV9QVW9rqAdYMd?=
 =?us-ascii?Q?RVIf4f/HY9xgDXNA9r42r/AXNo4DmYPdHJx6fIoY4wuty5yD3B87+2nw1c+s?=
 =?us-ascii?Q?rvvDQ/baTR95P2KMlFdtMYGmB4NR7gg06XBOHhmJaGKbW/+tkwZfUjh0CEux?=
 =?us-ascii?Q?fE++D0XGmokCeRSaI5KS3dCvdEvryluV4akDx9Xv7gQ0/8r4/+dDu30raCEO?=
 =?us-ascii?Q?1mTxjKQpGTFVaB+lzElh//5179UsjkD8ouumRnPcLihfRPSWcJio5bDh8XsS?=
 =?us-ascii?Q?7BXcLlwCwN9wMBLUxnWqlJ/luPWq71L2TPg0UC6irJWdSiffLJDYksTW7S5a?=
 =?us-ascii?Q?8t+819zW9sVrEu/vP4zjSAxdtu8gNyZXAjeLNs7uU9zJF16at2ZQBiwYyyc5?=
 =?us-ascii?Q?JpT4+irfW2wEUiQZoLrvKJwp34wkUkHNCnr8a5wR1Ojd6wPv1rwUlhgolpRK?=
 =?us-ascii?Q?9o34bK1C9AK9q6+2mxi6H+9ssMDRb3dXKze2LUyS4ZDT5Ua9X3lZat2XhriF?=
 =?us-ascii?Q?+vXAq4MubIzxfwk4Fq1ovXHogexZL1gZm9vM2T0u2B0MELOoAnRXhCsHDXB4?=
 =?us-ascii?Q?DQd2xG4/h3wd1MNJCytxPCqVJdqgsHATcTf5EcpmiRIMy+BmD6q0bru0HV7Z?=
 =?us-ascii?Q?th3Z8QHWE0ZFzvN6uDlmPqBCjGtr1WTPY3WjWsucIZPMKo5i70VgqxLTUq4H?=
 =?us-ascii?Q?iNOmcG+DbAlxOXSpsbOqnioVUanm8HKcljJonqbVouzaA3opHnQocMeSwMDe?=
 =?us-ascii?Q?pbGMspiWFs+WIYR5KKRoScElNzfgl8CLSsTugIjoahvYgHw2V3IwfD7q/AQw?=
 =?us-ascii?Q?2Hk8ItZaJiHU7fkrM/uKDr5aDnVKwE9DOSt6yH2xH/8KbTogAdAT4nzhckq9?=
 =?us-ascii?Q?ly0hzMxaojJ4kd0aLM2e8D01yWbx/nyvFTPqdp6qhFnXZlXpWxm8cpnFDN3W?=
 =?us-ascii?Q?6hQO8VkkH5l8PcAygUNej+PkpzghNXbGPf17B9sMVy6G1ufkjcjCJWeLqz/a?=
 =?us-ascii?Q?QNvEJ9ciRPuGapMplXcOwtKZMwF11TYULuUNxc6oMRyovZ5UCadg8TMGcKgi?=
 =?us-ascii?Q?oXSDqW+0ZiZQ9gCMeHyZxBguyhiBCx90zSuVB0Uj8dbH1sFHKihzwMNOIJkv?=
 =?us-ascii?Q?Hjd7amntYovp37oAjit5ThfnMYhBOh5nbDPeabvHOCh8HYGGfWHF+Bs7VJk6?=
 =?us-ascii?Q?bH1oEoeXun5Dx7NkQqbXmge8FYwu4QzE+mpwyZe2A8VHdVcXVM/9PyfRvQID?=
 =?us-ascii?Q?xY4MWGyUJYIlvfmf02weY/5egLzYwxj08mUbayNCSrDYzVeXGIH5a1yqCSB7?=
 =?us-ascii?Q?kCcGsPDk1lK4015OIblL+L2x6t5u29V/42mdvH9+8DK85OAUXvpqyvmJxt4W?=
 =?us-ascii?Q?x/c3CbZ9ng6a8Hi+vCIBm9Z7eG8S48TDwY9daIL65pP64ZGf1E0n5h+QKVE7?=
 =?us-ascii?Q?XOZQcQae/itEv6v3lfIRR4i/Xy5tDLcJPAsD5O3J07BD0rfDogRCqV0pVMD2?=
 =?us-ascii?Q?Ka5yFxGn8PL/XpI4wrSDicF6wop5TxGHm4Ol/QWZBxkex5pSUmLp66411jhw?=
 =?us-ascii?Q?SicWdm8QD/nRUCyEt8sVIGFhD0EEmY7RMneeKXoDHjcSrhQFevM+Mf8BCJRY?=
 =?us-ascii?Q?jnuA+yKQ/At6VFr7IzleiEFX9NgMEaw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2c137a-1eeb-40fc-f63a-08de4d536110
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 18:42:44.0930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhxSRUQPSqkq0H3qlyGVnl1gBxKyKSO/5Y2Nc4jiVJJn1bX4IPoBtHqb12yUx2l6Fr5gqiliaLx9dBx1T9eQ8gBDWS5pka2WNYt0VWYLDRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6112
X-OriginatorOrg: intel.com

On Tue, Jan 06, 2026 at 06:23:58PM +0100, Robert Richter wrote:
> Translation functions may return an invalid address in case of errors.
> If the address is not checked the further use of the invalid value
> will cause an address corruption.
> 
> Consistently check for a valid address returned by translation
> functions. Use RESOURCE_SIZE_MAX to indicate an invalid address for
> type resource_size_t. Depending on the type either RESOURCE_SIZE_MAX
> or ULLONG_MAX is used to indicate an address error.

Thanks for separating this out. A couple of comments below:

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
> v2:
>  * separated from this patch series (Alison):
>    [PATCH v8 00/13] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
>  * improved error handling logic and early return on error in
>    region_offset_to_dpa_result() (Dave),
>  * use RESOURCE_SIZE_MAX to indicate an invalid address for
>    resource_size_t types (Alison, kernel test robot),
>  * improved patch description (Alison),
>  * added line wrap for code >80 chars.
> ---
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/hdm.c                 |  2 +-
>  drivers/cxl/core/region.c              | 34 ++++++++++++++++++++------
>  tools/testing/cxl/test/cxl_translate.c |  5 ++--
>  3 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 1c5d2022c87a..031672e92b0b 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -530,7 +530,7 @@ resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
>  
>  resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
>  {
> -	resource_size_t base = -1;
> +	resource_size_t base = RESOURCE_SIZE_MAX;
>  
>  	lockdep_assert_held(&cxl_rwsem.dpa);
>  	if (cxled->dpa_res)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index fc36a5413d3f..5bd1213737fa 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3118,7 +3118,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled = NULL;
> -	u64 dpa_offset, hpa_offset, hpa;
> +	u64 base, dpa_offset, hpa_offset, hpa;
>  	u16 eig = 0;
>  	u8 eiw = 0;
>  	int pos;
> @@ -3136,8 +3136,14 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	ways_to_eiw(p->interleave_ways, &eiw);
>  	granularity_to_eig(p->interleave_granularity, &eig);
>  
> -	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
> +	base = cxl_dpa_resource_start(cxled);
> +	if (base == RESOURCE_SIZE_MAX)
> +		return ULLONG_MAX;
> +
> +	dpa_offset = dpa - base;
>  	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, eiw, eig);
> +	if (hpa_offset == ULLONG_MAX)
> +		return ULLONG_MAX;
>  
>  	/* Apply the hpa_offset to the region base address */
>  	hpa = hpa_offset + p->res->start + p->cache_size;
> @@ -3146,6 +3152,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	if (cxlrd->ops.hpa_to_spa)
>  		hpa = cxlrd->ops.hpa_to_spa(cxlrd, hpa);
>  
> +	if (hpa == ULLONG_MAX)
> +		return ULLONG_MAX;
> +
>  	if (!cxl_resource_contains_addr(p->res, hpa)) {
>  		dev_dbg(&cxlr->dev,
>  			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
> @@ -3170,7 +3179,8 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_endpoint_decoder *cxled;
> -	u64 hpa, hpa_offset, dpa_offset;
> +	u64 hpa_offset = offset;
> +	u64 dpa, dpa_offset;
>  	u16 eig = 0;
>  	u8 eiw = 0;
>  	int pos;
> @@ -3187,10 +3197,13 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	 * CXL HPA is assumed to equal SPA.
>  	 */
>  	if (cxlrd->ops.spa_to_hpa) {
> -		hpa = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
> -		hpa_offset = hpa - p->res->start;
> -	} else {
> -		hpa_offset = offset;
> +		hpa_offset = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
> +		if (hpa_offset == ULLONG_MAX) {
> +			dev_dbg(&cxlr->dev, "HPA not found for %pr offset %#llx\n",
> +				p->res, offset);
> +			return -ENXIO;
> +		}
> +		hpa_offset -= p->res->start;
>  	}
>  
>  	pos = cxl_calculate_position(hpa_offset, eiw, eig);
> @@ -3207,8 +3220,13 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  		cxled = p->targets[i];
>  		if (cxled->pos != pos)
>  			continue;
> +
> +		dpa = cxl_dpa_resource_start(cxled);

We want to return -ENXIO, not 0 in this case.
So jump out here immediately - right?

		if (dpa == REsOURCE_SIZE_MAX)
			return -ENXIO;


> +		if (dpa != RESOURCE_SIZE_MAX)
> +			dpa += dpa_offset;
> +
>  		result->cxlmd = cxled_to_memdev(cxled);
> -		result->dpa = cxl_dpa_resource_start(cxled) + dpa_offset;
> +		result->dpa = dpa;
>  
>  		return 0;
>  	}
> diff --git a/tools/testing/cxl/test/cxl_translate.c b/tools/testing/cxl/test/cxl_translate.c
> index 2200ae21795c..c2af918b853e 100644
> --- a/tools/testing/cxl/test/cxl_translate.c
> +++ b/tools/testing/cxl/test/cxl_translate.c
> @@ -69,7 +69,7 @@ static u64 to_hpa(u64 dpa_offset, int pos, u8 r_eiw, u16 r_eig, u8 hb_ways,
>  	/* Calculate base HPA offset from DPA and position */
>  	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, r_eiw, r_eig);
>  
> -	if (math == XOR_MATH) {
> +	if (hpa_offset != ULLONG_MAX && math == XOR_MATH) {

Prefer no compound statement. ie.

	if (hpa_offset == ULLONG_MAX)
		return ULLONG_MAX;

then continue as is.


>  		cximsd->nr_maps = hbiw_to_nr_maps[hb_ways];
>  		if (cximsd->nr_maps)
>  			return cxl_do_xormap_calc(cximsd, hpa_offset, hb_ways);
> @@ -262,7 +262,8 @@ static int test_random_params(void)

Here we continue to do calcs after we may already know that hpa is
ULLONG_MAX. Need to skip calculating the reverse_dpa,pos and go right
to adding this as a failure.

>  		reverse_dpa = cxl_calculate_dpa_offset(hpa, eiw, eig);
>  		reverse_pos = cxl_calculate_position(hpa, eiw, eig);
>  
> -		if (reverse_dpa != dpa || reverse_pos != pos) {
> +		if (hpa == ULLONG_MAX || reverse_dpa != dpa ||
> +		    reverse_pos != pos) {
>  			pr_err("test random iter %d FAIL hpa=%llu, dpa=%llu reverse_dpa=%llu, pos=%d reverse_pos=%d eiw=%u eig=%u\n",
>  			       i, hpa, dpa, reverse_dpa, pos, reverse_pos, eiw,
>  			       eig);
> 
> base-commit: 88c72bab77aaf389beccf762e112828253ca0564
> -- 
> 2.47.3
> 
> 
