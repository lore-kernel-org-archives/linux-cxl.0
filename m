Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215B031ED6E;
	Thu,  8 Jan 2026 05:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767850559; cv=fail; b=PhmRee9SdVs1aJ5bGmV2tnQA21n4QzI4iaHjz4hCxyEciCvCw/BBtoJquj6JaoOpYAlF+5M+E/lM4lRhhosWo2uGYBNgNn1u4dFGsJFQarO7hg7PhnthD78dWyN/3kNIZ5LaB+tYRbL2Xxe0eQBeKuBwC6olxMESTuPLeNBYHMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767850559; c=relaxed/simple;
	bh=xApRfBGxYp69bddmkuuP878D5mavdW114e9PD0+/ZFo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b+IhtT9M0ukOVPcn4Lm7MNHljxMQ7XKSpoRBSNgaS49Me8dcj1chT2aOpBvUKY6ii67uPHCbZvBsdhhUxZw7aDRL7NP5uzWrGj+LUrsEfbpgjsWIVcuDDUPWnirhRgtsDIXbMoF+9i8bqXLSMnSLQp5ZDRPsb9NWusYf3fPne9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjuYDe2K; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjuYDe2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767850556; x=1799386556;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xApRfBGxYp69bddmkuuP878D5mavdW114e9PD0+/ZFo=;
  b=gjuYDe2KdfUrniy6OLTjC60pPgcnHD7/xzC7P/Bs+xDSAy4hiaWzD2XV
   IbBENxqSxXTJVd9JT2lMtDcscs3TsLvIHnkgF7EZfYnm7n6hW3Uw7Z5OC
   T0Hxo87dlSfjenltIjB+P0kYult/L3tEh1nirTqCnB6Citcm6ePVJAoJf
   w6D42p1N8BCJZWNP8sCBJ2XMCqRTlLoXOW73Vj4aoFFcbQdkJVUg0bH1h
   o+rMBJ+1l1JDXzuKbBtwEY7JrIIHMJA5xDE8vwbdTWALaiVbLGN1916OR
   tJ+ekb35QLEe3AX7GYynRxiKml33k7BFS8YO6lKduuMjH5GdOib/JN6VI
   Q==;
X-CSE-ConnectionGUID: ANP9r2EPQ4O9wLKQzI/jYA==
X-CSE-MsgGUID: Hj+uacbMTXeEqxcPTuS1fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="91884816"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="91884816"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 21:35:55 -0800
X-CSE-ConnectionGUID: S3CRjhwLSoO/5nHMkhUu2A==
X-CSE-MsgGUID: S4unGX7cRpyPW7nN4mSRKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="203551103"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 21:35:54 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 21:35:53 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 21:35:53 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 21:35:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHFKzhyn8/tdJ7cPvQsA3iYte6jm8CSnEeSdlmeZND7+Hf+QTXlQ0Pju4okSC5REVNaXGIhrevk8d83A5t1kk+rFzyg+5Pt4YinRcP8kT9oqcuPVZ1XKTxZJ0BhdStPd8uH+4QjfJqT3OkSMCB0Ru9v9PiQoggZfhrUBrVzqGTwGPZWgPECVSSqV765Fv7X0pyKbgJNCcnZqFjfcciSju8rl4w1E6AmPDeCh4bpBlyxacys1z4ZZweJK5zl+Gxwvu85y2KZQbTAfPZ3wCPO0JX9I3sgggml8fer+nTOJaFacKo8Y/Omrq2aGjqRIALozy1qo6y9x9SFwmy24Lml7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pxgELGLaLn0/iCPiEWBTnhjwgY/6P+mKJpPfzRUn9A=;
 b=IsQ2amKhdijns9HA5WRgNnzm9Jh6Sc+a7DNjKbz8Jikwnpc5wPi2FDfqrynRy+VZhga95QrMhSdfMJ9+lytLsAyN3WPiWpWnpKFeNPib6HJeMrOg8V1rEui95JeGTokic/LEClulvup7qkfM5KxvY3kY9iB6SdNMTHPYPescY8XWt9DXyyePVaG9b4SB1oyLcPqols9fWHB4DqYtgFgqYj9bWRJRT0Vy7MtYaoKmJAcXzBjIaln2FZNsw+xHsK2k1kW7maj60BFwYSkZD7xDs4mXufkCDM1bDTAi2bFpgyL95dwY87qFBqR3tAPxxfPcln5dx0AsukHHFwn+rTOcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB6126.namprd11.prod.outlook.com (2603:10b6:8:9e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Thu, 8 Jan 2026 05:35:50 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 05:35:50 +0000
Date: Wed, 7 Jan 2026 21:35:47 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] cxl/port: Fix target list setup for multiple decoders
 sharing the same dport
Message-ID: <aV9CMxeE2KMlbXHH@aschofie-mobl2.lan>
References: <20260107100356.389490-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260107100356.389490-1-rrichter@amd.com>
X-ClientProxiedBy: BYAPR11CA0103.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::44) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d13fb7d-ee20-4b42-20f6-08de4e77c88a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aQ7U1yYoyqvPpJA9zy10SJ/7eqfRbv39yz0lRsySTVBIhIdK6FEREsKSsjgR?=
 =?us-ascii?Q?K6t4mZfU1lsgT4nHake/hu5cLAAzq415Z4sL/i5+sr6Ze1IHBHCfV2ayl40S?=
 =?us-ascii?Q?Jsx6bC5rZrzkDlVp4Je9NvAuV/OByMyouZlbDNmDPUf3LTIw6CSOjeTfN8AA?=
 =?us-ascii?Q?JxCeVwkVcsU6oJU3zv4/3ffOP8onjIRYzfQ5O6DV968nWeILZpQ7eK9u79pA?=
 =?us-ascii?Q?PEkMgO9zevH9qaojeqRhid9yDgYN6FoQFrLr7z7KurcbfmjABsf/gdefToB3?=
 =?us-ascii?Q?ujTIoIg66IgbBEE7gAC9hEec/XQFMvoQHIxH/UjPz7VkU+acAXF9XjSmcQLV?=
 =?us-ascii?Q?JnGnnPmZYi7iBs7a7k89JwptXAQUtkfsRo7gGw+VWpw/eQb5qYt75oD9Nc1X?=
 =?us-ascii?Q?0ByqhKkAyrLFwiNw/z9oH03K0dUdRoofd4jQ+E0kUj5hXl3SzprxvCtM17F0?=
 =?us-ascii?Q?7qgWy4LSjoQc3VjCw40Q5bX2EtUUEqqReTIaPN24VnioTFMUWbvoWnlU61Qq?=
 =?us-ascii?Q?mOUlhaqGPkORRqK5TPS+Cbi1kO8hrn73NG5UBGao7gux3WXJ6IjwIm12bklT?=
 =?us-ascii?Q?aJB4fLZQK11Z0qF/qFIYlPqLzw9ChqIzXBkdel66nagaK2+SXveMFwS02rQP?=
 =?us-ascii?Q?Dw7hPcgkhYE32e9qLcFA/LaeaInJOofDzA0nv+QEwyKUTa+4WjyiaCrEalSx?=
 =?us-ascii?Q?qAt9lDpxuDmb7o/hRU+aaOt/R4vQouQtH7TEOhkVAkDSXJmhJr50e4CSAYAh?=
 =?us-ascii?Q?oFJPVk2YWac2i6Twn4oUyot/XpGWuVKdn5TpTcMRXJ7pZtrvRNg0vh+Wcirt?=
 =?us-ascii?Q?tvGajCb4WAE7fFNa3UZ/8xgOvzZnjQRriG+Ekwyjwe87zEwHgN9rdBt8taaG?=
 =?us-ascii?Q?vMh3RTKFOlV27Y+UY4FLKpme5PxNHa5TEDLKYut3UjRU41taVosxVz7AKWib?=
 =?us-ascii?Q?scedLkjOchn50RndFdMUflA/sJ/4nDOaEG0cFGQhLyX76I+1T1fdODhZweJw?=
 =?us-ascii?Q?MTh/tC9S8gDErCBhYJMeyRS4ElrRHME82AA1BS6aG4VuxPJ8XOlZ80jkuyd8?=
 =?us-ascii?Q?Qk+E+jOlhJJXQAsX93JD1P0FVR+2BT1qNf8cFlqeDXbdL2qxuk3u9INcMl1l?=
 =?us-ascii?Q?UEFamtTdIAwEnNfSjufsKrnejIdWG/k5gc6EsrRLz1MZMMTUhiPlcsaa0Q8K?=
 =?us-ascii?Q?BOxNWqBNkVoSIjPc+/N3vLN+FGD4TsavIWLkiS773PZU9Hu/UQJp7JzAqf9x?=
 =?us-ascii?Q?q93nYoULO9YANoDMzU4zVofXnBEYB9JQkkpztWcZtwgXbd8a6a4/u4hDYhb8?=
 =?us-ascii?Q?+oZyemjvNRywf3Csk9vCMrPuuoSwOdBgk2isBbn3RV9OqmH2p0nanP4G3ygg?=
 =?us-ascii?Q?U3p9+qc77V8cab+9XCHRPsEXdD/8kPM9gQMtotAP00qq7qPAc+D6C+Vfv4mJ?=
 =?us-ascii?Q?mU1KJJq0UlenXyJCrnVdg7Yxt/UB1e2M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BtQg6JtFqFdNLq3TJWcmEWvUzcmi+iPjLgbrO2qCF9khq3AHHCs3cdIosws0?=
 =?us-ascii?Q?ZOAY8BUTzKniAAV0dgjjrPJ/xQIm0HVowzU2vMdosHm+M9CGZSFBaDLdrZOy?=
 =?us-ascii?Q?WF6Rf1JlSWzkfLPpC+eezTFMXRF4SbZHCQgmU/2n5qcyM3ZQJED/yXFSVzt1?=
 =?us-ascii?Q?UfJKVM3hutBWjFkZP+upfdTwKVJH0R58otecxvURko4zv+TsdJ8FvW+YHwj2?=
 =?us-ascii?Q?UptF0eIUZZRCbe8XqlctP0M1vTNgpzai+wqSx6EFw0uue2Tc6Vl9UcApHqNb?=
 =?us-ascii?Q?4jP4OKhvMxAOd3zwi8ubKB8nzbHdzVE3tbx57gjXleFFW8RhTCp6342yqktI?=
 =?us-ascii?Q?rOtXGORMevWXE46CAA4MDiTIQWSbZqcRHBX+IwtYYYMZc5ps5ZX+0wTrQb5H?=
 =?us-ascii?Q?+cU87V+J9qKUx4JJQNz+LCsw5jfBkeVFOoFlsW9XrnITOToymVo9bSb2SNRH?=
 =?us-ascii?Q?8xGwd0JVh5v2WM58RiTquQ3+az7VQOG1OUdm+S4/xV4fBSXk2j+pJMsKU5H2?=
 =?us-ascii?Q?QDbqFVeKA89elc5imTyuEPgSySmKpBZqdmHKGNKVeeHoUTpK5mkYBj+ApriK?=
 =?us-ascii?Q?D34nq5BVrimI+iy8/FA/XA6NShlWQXgPJx+R1MMNg2KMR+5PVmuKK6KfVeLB?=
 =?us-ascii?Q?GG2WX3Q8tsDBCqBkjUN/wFdImaG9gHOoyyoZY1tvhPBqWUxzVyaQByL6VMH5?=
 =?us-ascii?Q?w9yWzcs1AtvVee8UxE4TJ8Bv7zJad/PhvQ+Cc/PKfSZx7w3l6jakRcSMmApr?=
 =?us-ascii?Q?Mg58CkmlkRwE/SmU4yE3cjjfgCSS2ghXG/7ENOYP/ckvsWSXTwM2lwxcdsAq?=
 =?us-ascii?Q?GxCoZKRnMEZykRaFssg8xPrv4qgPs44l7PykYkzY8t9O0BcWu+6Lfx3DgtqB?=
 =?us-ascii?Q?jlk5+fPRlKSbg9FUPCfv4vgvMUyqhKGPVVjInbwJJ9qMNdW8gIxJ7mbNb9as?=
 =?us-ascii?Q?XfnWPORJJ0UReQ4Bb10IOI9g44zwr+faHEtIpXuGUxbb1tOTBHtRsnZi4/3T?=
 =?us-ascii?Q?EvVN6Cezg7YFZLnbOSzi/R/IOW99/rYxKozBXOXZH1QZLFndHCdFAzgTtlsd?=
 =?us-ascii?Q?/yYf1jgK2xqn5WrI4H+OSRug7Y7isPF37hpch4vY9jA0m2jeRNQn19E0vFZP?=
 =?us-ascii?Q?cT9rb7n9bf54OWre7NFH7yrNUmeAuvze39sL8OZAZg+m44YaRdrHuzp5FlRv?=
 =?us-ascii?Q?ePnJ+CUlLj4WB8ETBEWJkr/Uaax1m8YphoWy4MBiTzOrFThKgk9z6+mCVDvg?=
 =?us-ascii?Q?C/gEECuvDFfNiHpbBrMqo6YLWF3x0EXNCvYpIAT3NWhZcD+uGs7WyIdvSK1A?=
 =?us-ascii?Q?zl7hmCImKpqBnAOQkty+HAqT6kLHmEZMudQWbjZmIEz0iTeuSgb4Ij04Vaqo?=
 =?us-ascii?Q?IHRLUJGUrcUjoyeCAkTaInd+aT11Y4QAFhLlL0J5ADZ2fpYEHJFfyYlTUHAP?=
 =?us-ascii?Q?AwM2/kfJZGCmEcIpmLvOB2l0gjlMY+q2yj8cv/Q9jKOMLaaN7vfQFaH57ZA4?=
 =?us-ascii?Q?c8ffnX3phKh1eIhl34OJJyeyyBQvu1oMkkO8kSwYSK36VFsrSk50DvE7wLac?=
 =?us-ascii?Q?n74kFyf74Ng9bE6riPZq9U2fm5GpcSAOh6O8wnXiVES4D83B9UI79gNKlmmL?=
 =?us-ascii?Q?FZp4JMA77qcx98SD1P/fDDN8f3jR+GzLWR3ekGOn2L7Hb2G6nFny3k5qDAaG?=
 =?us-ascii?Q?uOUeUcPbIDJBPHNqia477CWifzlEvVbt3lQawLhl60TU1p44S/UgAnwU6+wA?=
 =?us-ascii?Q?8N8ZZk77vx7N7VG0OnIg1pwiPZyySYE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d13fb7d-ee20-4b42-20f6-08de4e77c88a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 05:35:50.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+QbVmLjEdBy3RE86PtfJyMYrhvyigpQWwWAeySxI/t3hJIBnEs5my2qxkU96Be/3ZijOjXErkvdQ0Cg/+8c6jUoqEhqs1C9W+1GnbQGtJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6126
X-OriginatorOrg: intel.com

On Wed, Jan 07, 2026 at 11:03:55AM +0100, Robert Richter wrote:
> If a switch port has more than one decoder that is using the same
> downstream port, the enumeration of the target lists may fail with:
> 
>  # dmesg | grep target.list
>  update_decoder_targets: cxl decoder1.0: dport3 found in target list, index 3
>  update_decoder_targets: cxl decoder1.0: dport2 found in target list, index 2
>  update_decoder_targets: cxl decoder1.0: dport0 found in target list, index 0
>  update_decoder_targets: cxl decoder2.0: dport3 found in target list, index 1
>  update_decoder_targets: cxl decoder4.0: dport3 found in target list, index 1
>  cxl_mem mem6: failed to find endpoint12:0000:00:01.4 in target list of decoder2.1
>  cxl_mem mem8: failed to find endpoint13:0000:20:01.4 in target list of decoder4.1
> 
> The case, that the same downstream port can be used in multiple target
> lists, is allowed and possible.
> 
> Fix the update of the target list. Enumerate all children of the
> switch port and do not stop the iteration after the first matching
> target was found.
> 
> With the fix applied:
> 
>  # dmesg | grep target.list
>  update_decoder_targets: cxl decoder1.0: dport2 found in target list, index 2
>  update_decoder_targets: cxl decoder1.0: dport0 found in target list, index 0
>  update_decoder_targets: cxl decoder1.0: dport3 found in target list, index 3
>  update_decoder_targets: cxl decoder2.0: dport3 found in target list, index 1
>  update_decoder_targets: cxl decoder2.1: dport3 found in target list, index 1
>  update_decoder_targets: cxl decoder4.0: dport3 found in target list, index 1
>  update_decoder_targets: cxl decoder4.1: dport3 found in target list, index 1
> 
> Analyzing the conditions when this happens:
> 
> 1) A dport is shared by multiple decoders.
> 
> 2) The decoders have interleaving configured (ways > 1).
> 
> The configuration above has the following hierarchy details (fixed
> version):
> 
>  root0
>  |_
>  | |
>  | decoder0.1
>  | ways: 2
>  | target_list: 0,1
>  |_______________________________________
>  |                                       |
>  | dport0                                | dport1
>  |                                       |
>  port2                                   port4
>  |                                       |
>  |___________________                    |_____________________
>  | |                 |                   | |                   |
>  | decoder2.0        decoder2.1          | decoder4.0          decoder4.1
>  | ways: 2           ways: 2             | ways: 2             ways: 2
>  | target_list: 2,3  target_list: 2,3    | target_list: 2,3    target_list: 2,3
>  |___________________                    |___________________
>  |                   |                   |                   |
>  | dport2            | dport3            | dport2            | dport3
>  |                   |                   |                   |
>  endpoint7           endpoint12          endpoint9           endpoint13
>  |_                  |_                  |_                  |_
>  | |                 | |                 | |                 | |
>  | decoder7.0        | decoder12.0       | decoder9.0        | decoder13.0
>  | decoder7.2        | decoder12.2       | decoder9.2        | decoder13.2
>  |                   |                   |                   |
>  mem3                mem5                mem6                mem8
> 
> Note: Device numbers vary for every boot.
> 
> Current kernel fails to enumerate endpoint12 and endpoint13 as the
> target list is not updated for the second decoder.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Using the cxl-debug messaging you used to explain this, I was able to
see this in the default cxl-test topology. At 6.18 we stopped seeing
all the expected dports and with this patch, they're back.

