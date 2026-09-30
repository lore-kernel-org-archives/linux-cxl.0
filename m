Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E6F489FA8
	for <linux-cxl@vger.kernel.org>; Wed, 30 Sep 2026 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809934; cv=fail; b=bfbNr7+WbLP7/ABgvNr22QAhNZmhUo8t1L9aknOGu5Ftk2Qz/jQ/0kIpAezr8fXQ5wUfqNXPQ4E8ffMrRToVRYpTMpBoP0l8IVHhKlv/Bm1JWZQdLKHDgdAqen+Pj2zkmIoKIentPjYLpq55T7qkzHuI8M/ybIfnDjzXjCRlPrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809934; c=relaxed/simple;
	bh=amexrATYvD3OENSTYDLwYkxItYwQKV8FhndrO8OJbO0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oIM8VRFcA3n5Eww5dQr6piCxkqJ2p0XVzO9OsD1rzbRXyLmQsGCkr17Yryh/awyJ7vMk52sLgM9seHEjqoYfmz4XZEqt2eRgfjp2xd2XUoWPMFthYZ8IKOFoaK8BUcF5PE1Z57PDmmWRCgD9C32aWFg9gQQDbL4SAGJf11TJEo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m83KQTk+; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m83KQTk+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790809931; x=1822345931;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=amexrATYvD3OENSTYDLwYkxItYwQKV8FhndrO8OJbO0=;
  b=m83KQTk+5ZXwTmNYOPtgS0+ZtPShZXRIiZ5bGHIT41Oo0r/bXnp2mEa6
   /hUHE9DH4M8xfGHZafnuhjzME+xUrVkHVQcWGYtSrG1sxdCbkIRsyffpU
   7jGyZ5e+9SSP9XGMnzUlKnfxgxDRr50o4M6RE1uTTSgCY6q1xsRdivJAx
   6txMrypxCZw4eeExoz4ZwiAewdbEuvP35/4xbAa7UkCXyQpxfE0DngRC0
   rJlmwy4BXQCXPHKY76o4GYTL0i6NhSuq3etJ+qDzaaiQc6oroCazWYuRu
   FGvezTqXSaeG5kyL7OSmcyEwM1dnhY1ZWTTry5m3KH3kbO6eZrz59lXRq
   A==;
X-CSE-ConnectionGUID: V9JpBAD1RbaLIzrJmkY5ag==
X-CSE-MsgGUID: uGpYY6w9Tk+vCEHR27CQrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="107941373"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="107941373"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 16:12:05 -0700
X-CSE-ConnectionGUID: 5TAd0soVRSaJXzjkVzeUPQ==
X-CSE-MsgGUID: 1rH3jMr6QjCfawnvTRVv/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="280583859"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 16:12:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 16:12:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 16:12:04 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.32) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 16:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tP1KU47plOD3U7XhQ+GTlvE9SWeEbBgWG4a0boiWwdi33uKwC+mti1k4b6G4WpQ0+x8QsTIW4ilzKr8b0mfOrT/MAPf5hFZIMdACNCCZfgYuQo3ufEI4EhxE1+xwqdbKEpgymN6x3Fmz7aA/FlkPUiTDFTaOVMV0tSk/EjL0/vAswOiPFajmYhIwXikF2Du5ZD2dpwYpChBo29F5DtmeV0xJQGIMOvUWOqlUTT2nuKhVk7ptY+6QKmuBiH9qeuHPeOsLusWW2uKfGDkoE2MSaTTqGPJx0F3gmPk+T5HRg5xFyA1Ibz6c/X1dM6kpUA5eJn/lp/ZII/7PB13lIG6g1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMY/Mxy/25Sq2eaukuAsx9ZDWuuuYSJGzH2Z7k8BST0=;
 b=N7LUYZQVHEW0EF4McIjlq0ROy39kb+Xsoqr+odXjZxGe20dMgpXBY0FPSFvPEWfJFf60lOUgKBuu4mbLQ/+DfvJYDywILoKoLBnduT2opcx+xuCbi9lVLYxDCM2oDbrGPggFt1AcHeb3P9YRwF+zPMgo7gXuzJ6RcDq6kRJ7ZrNKhkSPYX4z9N/MBCp/Bbri68Wvpcxtjm//8KBUWo2cHU79VFJjH5YRKmZA15BWky1Br6PvCz9Oew496x8gbNkoCxSA+SU9zGM6H8A7JsePNFde7sbhY0ry8At1BUUfi63eJ+40ycN3QffLTWa/5dBFDau8c4iPjaXOansncutshQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ5PPF4990C6B9D.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::826) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 23:11:59 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 23:11:59 +0000
Date: Wed, 30 Sep 2026 16:11:56 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<ming.li@zohomail.com>, <benjamin.cheatham@amd.com>, <alucerop@amd.com>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v9 03/10] cxl/hdm: Add BI coherency support for endpoint
 decoders
Message-ID: <ar2XPKLCs92qUvmM@aschofie-mobl2.lan>
References: <cover.1790103847.git.dave@stgolabs.net>
 <ebc907df26d229138fb46051e5b9f4a2299b6432.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ebc907df26d229138fb46051e5b9f4a2299b6432.1790103847.git.dave@stgolabs.net>
X-ClientProxiedBy: SJ2P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ5PPF4990C6B9D:EE_
X-MS-Office365-Filtering-Correlation-Id: ad393e79-31e9-4324-bee1-08df1f483aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|5023799004|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: kxOqzktZ7wtlvtG3zxIgg1c6Jmc+G1pMTKiuDk9YCyuhN3T0bhGtmllpOuBN+tkISROtbse6cGgx1GPt2pGAPh3s7IL9Q410utSVNV6zCY9ez5ehsFmlDB1UN7n5izHFUTpk+CuPHV1FB4tmHgxmcs6FkVvYGDMQ+ZMjCIxER+Qevt6gfaAYuHwgVuzFLHEG0Tat/S6WAHKsNip2Bkwn2UDLRH1x+7Iel5/NoL1R3mLfSN91IQp3ytgje7qq6lcdMc3ahNR/7d4HWexCsdoPurdMjiS+ZGc53dHADQHrPRon9aW8WQnzaBK2ZW7dKrn+XjjeYrwhIyfM+RAI8TqlyteZ3jtRdCwUw0SNslFR+MjDWBpTM6sMzr/YxVXLkOGjaX/317D7jC71GPAKR5URMUPwlsd47+LjFPqOQb2PzrttOrk3UHVMp3i7WHXhsVQHsTTyzUFat7xG2zgIZf6una/WpSK42f3OBVjH6/+o7FLtl+2Nu107I8tgnFJAQ37d9PNJA6OiL6Tp6BpXIC+qr7Ws1dXVr+PjWWJ3ZA6OAOzW3ZVTEfqf3jrhhjF1dNRKNY22HtMqArKlXZAsboimWYxaU/pIxF12lTC74qhbdhsHF8pj3rK/N5Ilu7tkkZ1Xql5jG3cex6tM6ap0AoqtnLeR5Suxm1iiXiwyAdBE05Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(5023799004)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KujmoN7omIPSS1YNjkTeyqUzRlDx9Eb8sMr6PLpt0iZZir5AYnP27a5jKSwx?=
 =?us-ascii?Q?8OTWkmcOx6E1QUZ0IX9SxnjNk0Mc4y1wxXBq3VkXlq4FTaG8kIQIfwuiWv7O?=
 =?us-ascii?Q?+LxDPmXg3b1e111mSHC0s+oerVCjAftPcasXvoLxMZsrIwGc0eu4lYfYoMf+?=
 =?us-ascii?Q?V6Kk/xUElF//zABqm7PWufT+sD+WuxVEw1kMQB0Zkg0FiG4YOkSXRTDNhr6L?=
 =?us-ascii?Q?odJXyKz07tjvNBGHXf1GaGvFmgc0zoCKnNGb806xQhh0iGHiCqHTJm+IpMiu?=
 =?us-ascii?Q?ZEOImfyN+EcBkcYzkZcNYVDQHQgi58DO1vOD+OnXP4YNutMRwNtd3Y3F5ubV?=
 =?us-ascii?Q?ndmZtwWtCQJGfmfUFM3AqPrYfQ4vTciz8pD+5fZLyHCFK6U3SmpbMVBHoV85?=
 =?us-ascii?Q?Ql4cl8o/44LdD9CJN/WrltYtRsBYRG+RppI21bacNc/K32dHWs95SZfLn8My?=
 =?us-ascii?Q?JyOouH+tv1qwegplMeRaul4Z2zeweVzcswJbqdrSkkqFWcBvTyWxOO6/8pMr?=
 =?us-ascii?Q?AzMLHAa//6XgBJUI30Crn3NpbQOZl/hhKxWvFSozTWHkakgUM3L1ydkeAktb?=
 =?us-ascii?Q?ywgORZBd70tNQnv0mbhroS1QigViQIEJH8mGrcw9dUn/NvxBIcjEIaoqOgxg?=
 =?us-ascii?Q?wKxHvb7wnjB9jBMfBom6ixUgetmCWSYdrCslGv7Yz6cLjXSMv2zCptcPvo3K?=
 =?us-ascii?Q?P1pJBYN6TQ615jBjP7mFVuySYr9n5XF1/lP5OBnjVGKT3UMVt+C9/BOWXL8z?=
 =?us-ascii?Q?12CzTxACkq9ktIV9cStJOSSYdBIZCBy8MqKM/4ZG6NYvrH7dLQhTcPnGfzQ0?=
 =?us-ascii?Q?lHuXIvXxlPt+GeUXbFNqmRFaOtBxmy4r0cqiMkJebq7tdVmmFFqc6vLgb8xf?=
 =?us-ascii?Q?nraaQxPQwE75Z//kOCBw9BBr7JJWCcl9L3kgPE3ywsP1BXkYoN5xcRXbGwhh?=
 =?us-ascii?Q?Av9ke+m5roJCSYLWZQ5AejNx6aoE3CAwy25b8K34aPp/p4JmUDLmIenShlKj?=
 =?us-ascii?Q?EJbb0ygt8bqurmw/r37ouJu8NktXAt32ERO85gr5dFVSrIODphkzuUP7w/FR?=
 =?us-ascii?Q?3LMa6YNEqb8A3gp/XabLkMOcPr6eXKq5qV7Bgj+cxP2ypIAnJ0b5J2dIVmez?=
 =?us-ascii?Q?0sn4yiIvdk8Q9HxpIa95k/bDC45K3mRAQ2Iy5vvLJS/v0wbQnQDDJIEZOnjz?=
 =?us-ascii?Q?Hn3aon5vKtppP6bJQGQzw9fRsy8XpF6crp/ZsuFZwpFm3ooRHqbAoPELmSmv?=
 =?us-ascii?Q?TMvqTOYmT0cjMIfQF17DIFnNqXsgWXh6tE02Fa0ZEmRkQrXjYTejjooVp11X?=
 =?us-ascii?Q?kW80srW2fyaddFr6rx0+zPdzNsTtlp3QybBgi+oxq8uC+VBYilKwi2Xwud+E?=
 =?us-ascii?Q?KCgHAyUQtswyHzNPTV9e1QDompWyN6/hxOvFOK8/sj6znneZASx1HbMkmewc?=
 =?us-ascii?Q?cL2Opalbf/OYG9NSWXQk9hBNGf1L/c15sFmA6BHjWfEf86ixcikRfGp8Osb8?=
 =?us-ascii?Q?nwmoCvV8w26KRvh4AGEu9ktQpKhz2NJ78Cnvgit5c1TVLzrea7w7cOq1H5oj?=
 =?us-ascii?Q?xNVA0HPkAqlItfBZwAr1kqZaK5VydqyahNtOc4xT9EDupzum7Eq8v9jiONDq?=
 =?us-ascii?Q?RX8Sc4PzWjS1WtHUQVA7CCXyp+KLqox2FQapmVRzzqiKrod1sfiGDn7UC416?=
 =?us-ascii?Q?l76/kIXoLblNOWNfJcaSI3HHhJ0GPpBUBOU4GuV0XCDNAXgAY89XmtQjIntP?=
 =?us-ascii?Q?9S+VsM3OWsMdmEQgul3/8auDcKw1HfQ=3D?=
X-Exchange-RoutingPolicyChecked: xS6K3hfo/biECpv9jGtJCKTq5FIuI5MOsgROnsKD0VZXu7m1K6CHtkT021pJzBV9j01HI1C4WHw38qhPVCEYnHH1lqW9xo3oW8BPjhWq4M1AQbZTVgxFHX67caehkcVJaiqBtBBDNKmRHDvofDCVT0KQ2ufIX2fmKfv/KAW040ULkMIy326pglYQgijc9HRHHCtwPqGDGZPuuo1Gzo3vF8Ir1XlwAiMQKDVGjQvTLAMg1LmStWlyKnVU7VcrGmNAqEbnIN2KEzQrJF1FjYY+UIQp8OvwXYhjBRdFatGIDvhT3zLvO48rQaIuRgAsILD5p+/CfiKUqzKS0IxXTljZfQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad393e79-31e9-4324-bee1-08df1f483aaf
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 23:11:59.3884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O81/ZeNs2AhKoLUBWP59F/Ia3HzBNSU/91Hr3QBxK68ntL9jGvag63Scbns9l/1fdhlHN4L1iciyEcEL1ySmjd6Zw/llsRSAiKjlH+jpK30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4990C6B9D
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 04:38:40PM -0700, Davidlohr Bueso wrote:
> Cache the HDM decoder's Supported Coherency Models on struct cxl_hdm.
> A later patch has region attach consult it to verify the HDM supports
> the region's coherency type.
> 
> For uncommitted endpoint decoders, init_hdm_decoder() defaults
> target_type from supported_coherency: Type 3 devices default to
> HDM-DB when the HDM is device-coherent-only, HDM-H otherwise.
> 
> Pre-committed decoders with the BI bit set are refused. cxl_bi_setup()
> does not yet take over a path firmware already enabled, so nothing
> verifies that such a decoder's topology can route BISnp.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

