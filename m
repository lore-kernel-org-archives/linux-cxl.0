Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8302C1865FA
	for <linux-cxl@vger.kernel.org>; Sat, 15 Nov 2025 03:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763175725; cv=fail; b=Nn3a2YG244N/yekej3zvf0jsZ9fdGIxBzPb/dOMyzhV4z7jbFS72OooGZOfIVy2PX5DDd1GKklh+GGNJUwwQxXL6sZGtkiIw9RuBkBjx1BlbeSN0O+z/kW5X4APOFoWXNp4UAa52/fk890jG60dCrLmjnc+Om508At9lk1ld90c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763175725; c=relaxed/simple;
	bh=fYkMG/FAA59lIyGVRp6FXk9qOsKaLcK4/LLEvLlsl7o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W5NmfdCn+IfwxHiL6cfs9ihaA/jMsXqX77Vov2LkwXLLOJJlwvYx+uASVQNww2LOQbph3NDfZ9+gr//IAmpX7/3je3xhCrEUW6lHCLNKxbYubVBtEV6L/EC1KRr2SJAyculxsG8HxQ8KJWwR6vsG3fcbyrc6gc8whb0uJmGx+Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUkEQwZr; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUkEQwZr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763175724; x=1794711724;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fYkMG/FAA59lIyGVRp6FXk9qOsKaLcK4/LLEvLlsl7o=;
  b=HUkEQwZrPtmo+9shRYdysShfaQmdazLeVV/ibRNuh93QhsstGWXJh4R+
   5Nj/livSwQhA0EgNg2FF5VUXNTOf1ZZJOvtBNfMAdlOkpV/OChhOIrI6X
   SN6XCxJhG9MiXVIqSsVrwdGapxfTZMJRuxMvVnd117nlzH3Q3QGh8yeSo
   PUiTJP7SMwVMijrpcnExlxlPF/kORGf2dOs1kAScxj6wF11e6Fsw07ihL
   yM6zPSlqTlm6fiMrR0TzcrZmxIFmIJGsBWLlxr01FjXAXYnnyThiund51
   v14ek6taqAoCHKtm3Rh6dWcpef/b34rIqyeQ8qsthl2BUuFQYkeWe1+mr
   w==;
X-CSE-ConnectionGUID: VxNNzooET1m+ACAHsLMeDg==
X-CSE-MsgGUID: HM07GV9ZRBqt6XoveWSl4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="75591371"
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="75591371"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 19:02:03 -0800
X-CSE-ConnectionGUID: SFy2nX1GTOq7CdHbB258zw==
X-CSE-MsgGUID: Y3lAhcWhT6SnGggxHYZOCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="190714063"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 19:02:03 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 19:02:02 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 14 Nov 2025 19:02:02 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.71) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 19:02:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoX9rvA7WlaU9Utr3N13E063d32tkOrhwBsQ2zLZE2gr9+MPvoZBTRB4wKcJbfQT/wc+3TFzC0De4EF7Qr9Htag2wsUBEnfTmtsQiP5VVRFDwq8eHxl4+XNikA9GEYYxWggLzXG/nBTOut5SvLEwaYjAJHfv635ebvABVAPy4iYVxVQPvlgpmVAmHkdSfK7w/YLtFtU8k8oDQJ7hWjZx2TqfCVttP2QSPw3lbWKIpu+sszOz1XpCU4CjwyLOa2mMbLg+0iUcGZT845JQEEHXvFzZeN6KEgiEZHJjeu9id/sdJgbRyhqFEt9GYYieA8d1H8gL3IZwFcwYnyWxjTw2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYkMG/FAA59lIyGVRp6FXk9qOsKaLcK4/LLEvLlsl7o=;
 b=bPr5m+InjQqayvTwAMSKdQOSd86wMaqM9OC20t7O/V/maUBwF72UQ2h6Dgwpn1CV3oycBLn86uj1Pf4C812LDISOp5G0blPU8/gVJXpHMWDBHoVXO2RYyKFLUW0S33NozCpT7ac4mbpS4X4D/VI0hL+vvPImu1T/u0bvpQoYgFgxbKrJ/IC9USXBcAnZHKf8qBHPppqwDZT+tCndhVismYM3ai5zbtBVjEUuF8GoHSAC4dcDg8896wmPSZkAbxl65Xh8xeLg0BoWVEoOEgf6AfrpCLBf+ZDwh97VVJjd+jtIjts/qlJgqDXjN1LdHnKfcjuX6SwLaHf6wNGH8m9Ekg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sat, 15 Nov
 2025 03:01:59 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%6]) with mapi id 15.20.9320.018; Sat, 15 Nov 2025
 03:01:59 +0000
Date: Fri, 14 Nov 2025 19:01:55 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/4] cxl/test: Add support for acpi extended linear cache
Message-ID: <aRftI7DN19PkxbFa@aschofie-mobl2.lan>
References: <20251031173224.3537030-1-dave.jiang@intel.com>
 <20251031173224.3537030-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031173224.3537030-4-dave.jiang@intel.com>
X-ClientProxiedBy: BY3PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:a03:255::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA0PR11MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e5c441-ec41-40d1-4e88-08de23f35811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?un3IW837zTdQPPwjbUNhdmfSgfxRd1WZaAc9z13g9qiAcPFuxUuiA5Tdu52k?=
 =?us-ascii?Q?uqUGz52eP4A9+AYPypWeWaYACXpYvGVnjodkEg//URbGIkPYbUao/gXXyFOP?=
 =?us-ascii?Q?Cg/vLOEEhhGnlJd7+v48MZg/aQyf36twj7tIX3/wSO0oTjq/VFvFLZMkhtGJ?=
 =?us-ascii?Q?Iix6k3r5hu51F6J4+98ZqIQqx3A0ypYKZQcjXEy/UbeWFR5LCqpuAMD7eUPT?=
 =?us-ascii?Q?aBr+Nwq4cJNm7VlqQTbwG+JyzPV4CWOebTkW76/lItV2N2BMTpHVP21eB2vP?=
 =?us-ascii?Q?UjdE4MfgQchgypJycihsLMb0lwPXs1NLBAcHA2mP5xdbbD8XF26Zv9d75lpX?=
 =?us-ascii?Q?LT5CdcEEXib1rhc55UUr9P5cq6/IxYRxjGt5hDql70GAFe3eiHCblr+0e+Wy?=
 =?us-ascii?Q?DqYMfKqzHxpwWVfkCG+caSfXHV5RT0Hu6oQG/rVMVFEzhzpCXKdICogsDa7w?=
 =?us-ascii?Q?mpAn/iwItr1ozVrTxDrLhtAnyio3kHBt+jVQvlssafGwS2lClOH21o2R6TFn?=
 =?us-ascii?Q?a09SM8ZSHQT5OI9or7ggwcZseU5l4GUAjQDILk8V0tHr976XoozH8YNVFS1N?=
 =?us-ascii?Q?sSTj9Qc0UaWsvKzm5jQLXSLkZ3UdjcSfSomK+UyfQ601/pQXNQTgXoo0mcd3?=
 =?us-ascii?Q?L4MpCdAVgoUZiobepACXZ3G1MiTdbbJTTIyslSbq2WFaGYbXkbAZ2dRIafE9?=
 =?us-ascii?Q?YmzwrCnhzSQ75QHLOheAlCHefF6+Lw6kp5D1RjT622Rzg1U69iS2E8OMMfsK?=
 =?us-ascii?Q?lVIUW9E2F9SXER8bkQ7p9qyf084rT/8NRyFl3KVqSVjKgJMOZsKP8imhOAuS?=
 =?us-ascii?Q?BV/7ULUyEsYHqyfOaXGjH/lYF42nz9kyYgYxg0emYAR5gSPOtyqGUAYkSrmG?=
 =?us-ascii?Q?3/miMixA2M4b8c7gw8Pc4bg9LmcxKW0EBQopCDDdoQyJuir+cVUXOPc2UA7E?=
 =?us-ascii?Q?cA5MSNSuPkYvHQrXC/0Zhp8qWuZcnJx9fvUkaCd/1WrbID5z7ueSSybPIWNS?=
 =?us-ascii?Q?J846gUiOGRSlOaVam912b2k1VS/actiFT9gpgwHPzefCJFnj6jFvJUU5pFf2?=
 =?us-ascii?Q?P7fFtxqFM93od992acrkTOBqhqwH7wQYbzilvHSngZRiXnvHSCwxzQXZ4wcw?=
 =?us-ascii?Q?N6Rs+WmaZStWZ9YMII6kjnz6EzfuMzMwRvOyGyUaz0pdOe7JDbdZvVds75by?=
 =?us-ascii?Q?kaYyLAtrbi4TSzis2jKVMvJ0MbSw0vVD9dHbgt0tDejQ5IU8R0lWB7y62khp?=
 =?us-ascii?Q?/02OD7pZMcgXAw0j1N9lTKDWde5UGuSkKYU1USmDqhrbk81l9JxvKCXAwkwd?=
 =?us-ascii?Q?NWw+dqiZ4GyybJSx4W73WZCIuXYOkDBaRT8F2wjGm/cVZCcA+QNFo2HKrTeO?=
 =?us-ascii?Q?q0Q7nXFlwlynLtyLQgBRgo18bROQ7oURY3UF7WRRE/Rgyiyb6EV4Lc7IasIw?=
 =?us-ascii?Q?vPE+LF0uRuyVkGSNtU1dhPJrj6foosC6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jki9HUCxi1Ymoec0WNPKSPy9v9KAO8kApL0yDaavdeoGYJjPK6NvqsL+7EBv?=
 =?us-ascii?Q?R5R0VzLqMOFa/q52I/BHwzw3+7l+FzRiYD+bfNozs4UGqGlQar8/bWMu5Va0?=
 =?us-ascii?Q?zI+SM2pia2KBMATzaz9q5gJk+yMZ78nKHawV3754vbbj1WpJUe1jt+wzKqJ0?=
 =?us-ascii?Q?FcJvLDoBpY9qqTjBHiuHCL1A5eHZw/QTcNe722r7w5yj5YnB1pcvnJyXQDDk?=
 =?us-ascii?Q?yNEfesvJj5PYTUW7cFKzF5T4sJd4gvhx7Y9nm/Wgk47ghYl4alhplEt1jS5B?=
 =?us-ascii?Q?AYMjvLO7+7krM/CdMRMdGXvO0QqYuoa6zHiMNW2lvmY9mL3NmLpLDawE1lep?=
 =?us-ascii?Q?ZLuKn8p0inEo2MBa2lFoXvbAURj1JyP9SDxhP+DVJfcMuoH7TtEJy4T5crjr?=
 =?us-ascii?Q?3zr4y7kSkuNNeSD9w3qoDwMxbjlm+lHETVHK8iTuvNvJoGEPBqQK3GI9lupw?=
 =?us-ascii?Q?ke/CBCl1y7fEa6jwnexJ0XcW8EOzaXiokCl0+PjZZNzZC4VL8+zqIJgzFzzT?=
 =?us-ascii?Q?QxcodBzN+561NpYz8FcJWUI04bt1TdNEBJX45YKe5NT2wInSt07R8s5sgOVg?=
 =?us-ascii?Q?1lRQctfYilBzgZ0WHshDx+Xw5IQTUjSEZqWOs2jrgv2hCRvNRs/Yz3rpKT3r?=
 =?us-ascii?Q?Ip/WbwdzsrZDJmCAugXosCV+CB3bi8sfE56Wv1XSBXLbe5Snp6DdZS67/fZe?=
 =?us-ascii?Q?/FtsKzMka5mJhWGNF5Zyg6rZqbrIPHNayeDk229b8wfo4Z8/VcWJXlxoPfpz?=
 =?us-ascii?Q?+CVnrymGtc1UIYhPTyulL+F9gdbXpKt67NAbMTF2WxZTtI2+FG0jfmqAM5qf?=
 =?us-ascii?Q?ht1eCfvNLcpeaS4MxaRuriz9kYAvbAlMFQJY5r9mv39HHAPZbDJQlr2jRWGy?=
 =?us-ascii?Q?ICbAz7zzHcxvP6lsV+K/diCHDwwObTQRj1DUUENZGjveIIk3CI/jRuGWYn1X?=
 =?us-ascii?Q?ZtIVI8WSs7Kh56jQ3nKNHTDM4bufzG0aWadHRhhU4erGgp3wg1tkNO4jjMbD?=
 =?us-ascii?Q?iYwmH0rk3Ik+BOh/KeywiJcs6x00JloCFh43ZiGt8nTo2lrsnRbWgC38BWmy?=
 =?us-ascii?Q?O3aOfK+Xu0ebZbmcsBKb9nZobsn+UIW9vuYGfDcdS5x+sr24K4mr51oFPMoC?=
 =?us-ascii?Q?cQeH3fqtT8szou86sMAJzmi+N8OWR+2wScNIdE1kLKO8gVVNcJ25knP7pJqP?=
 =?us-ascii?Q?IHamNCwYXiSTpkQtFFc9J9amUku3pZYNxVX8T7vxFnUOTTsZpET6WlTtDhg4?=
 =?us-ascii?Q?gG7OpTe/30LBORQoiDmrTJzbQpG8hlrJvHKT6+4OHAPSym+UVtBl7FiiMdqP?=
 =?us-ascii?Q?LNFA6uqQzmUdN8LNSfC3URgFVXPKhxE3Q8cW+HDaUeTBLj3yA5lTrF+dMp5g?=
 =?us-ascii?Q?8s+iTMaikJGW+dbAuwH+1dgpxgrUre7TzRpkZbxLZS9ucm3mX5H9Thsd0Zxm?=
 =?us-ascii?Q?/gIGrdPYLSYd8fC21Y5LDaQjYK8vzrWO0HKy2kdrN6myLOPImh2hy5MlateZ?=
 =?us-ascii?Q?yJQo+sefMuf1Caapb/1fb52a7nRo9GhG6ScrahtbHxGSvABKUXgAZChzgNLq?=
 =?us-ascii?Q?lCv8wLlh9oCc7qOib9AlSiPAUmbmbg99Nsv7U6qvqE/sv+4jqH/gfx3h5eaz?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e5c441-ec41-40d1-4e88-08de23f35811
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 03:01:59.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkwtjxIdavFan9sQ1Hormo4srS4x7EXkp8/ZyyFVAVEfUaqlva17uj/Lwzacawzw/g9MKUwMsUW+A+aoRUqDUvHNqeVPm6tuFirasvV3e08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-OriginatorOrg: intel.com

On Fri, Oct 31, 2025 at 10:32:23AM -0700, Dave Jiang wrote:
> Add the mock wrappers for hmat_get_extended_linear_cache_size() in order
> to emulate the ACPI helper function for the regions that are mock'd by
> cxl_test.

Tested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
