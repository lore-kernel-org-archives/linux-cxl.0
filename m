Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE11D19CC33;
	Mon,  9 Dec 2024 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787898; cv=fail; b=iisPprgN4tTE91ucdzE4+zDCkHcBKxmKkejHa2rfhCv3sD2tqmybazG5WOciBi/TOd8sqxi/aDNiFnd7+7m4+S73KevwLonf3I+PZCWmEbqOeuzD+e4VAhu0zZRT/9LC/T9IPUQLfDt/4Qh4vtOHlx/ipQFB0S0NL2sUKmk5ShE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787898; c=relaxed/simple;
	bh=2/3JbubwxHb1cM5OjpriBz+5FtLCEwfkhuS3HSHGpcs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dX144JIBk+ElO2NdSQf+ApCSHxXnCxYoVcqDSLfq3pPVq4Lg3NfOR65t7Hom9P2v4PWLhvFtsLwPHWoq2RaUgTqVsYhuxxJAkPdFspIlPp4ptMIXNOvly3RUBSa977B8zflOpw3n0JHoQBUvfckclR/aDVq0OKJsqizl9Eo3QWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5yn75jI; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5yn75jI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733787897; x=1765323897;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2/3JbubwxHb1cM5OjpriBz+5FtLCEwfkhuS3HSHGpcs=;
  b=B5yn75jIyGzRIHFlU320rBjWn8+GpSGaCOtCJ3yjmlfrdW+oYbItw+7p
   9QrwfnBZ9iaSbU+W+RQk6MB4kbu3w/JZSFkiIH2Y/XLCvrRIJy9DCCYvC
   13qagHdqk704WNCAXlBBtdZGtnoSU9RylceYggKUEJ4sELKn36I2l4XZA
   qb/S7xhpsw5gHaoADyy1DClmjIbrs8yJYDKd9McCEwxYzizCeHNcbZrt1
   8o+Og1qS9wJuh1RVnrCla37AUqMk+Eu8nz0rrRxkS0Ryvjp3XEGuWJQZc
   MP4CoWxppN0ogn/hKdxTVpPXmdd62Z5isPHWGv2nFOwOKc2/teXIV5TnY
   w==;
X-CSE-ConnectionGUID: CTJYAIb4SpGGwBpbmARDcw==
X-CSE-MsgGUID: eSfw55LkQpKvfcQUTkXakQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34167967"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="34167967"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 15:44:55 -0800
X-CSE-ConnectionGUID: jNRXxdVjSw6fKG/CdCKoYw==
X-CSE-MsgGUID: nD4H6hEFQZ6WjD3o4WY9DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100257991"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 15:44:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 15:44:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 15:44:54 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 15:44:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwZl4Xk0L3Il8DzJRI4OBKHDey1F90Lnh65aw8Y3H+qNwErpMKulHcH6AoVQf5ealad4c6rEswwi3jbkaEYbZSvyezNl0f+4GvDF/O5+eDshFBrwDXCyh10XYWM0dcPRYdhDiUsaiWbOPWIXFA1C7IIGCTWoKgamEX2AHYeqJZreeCutHmehUdTFod74bI4oH6s74e4d54WR6IVEA3HNfHV4v8DvbOMmdQDLKeZCArObECl9VGyQ+oZFprD6P5z9Ypts0GreW8+VyWdutzIg4uIIsBHn9zuIjcS4gXoWZX8PNyQYHIZaY9ikSaUGw8gvOKcnu3ilTAE6IuSKRuSs2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2g+aYGmW5Qhp0kIAqEqUe/tKa7eQS0f8dEG6+jcbobY=;
 b=I8UA4sg9LDiKPnC9FB+bZ9j7KgDjdv5T29ZzETnHlZqAfUfKU5n7VaR19OoS+OHPVtdiG82k54dez6Xmj9tnIMCUhIcCh7EKczcSJ4s80tZsRQlqbC47/gmTG21VOnEStA2AG/M8Il4D/yfTazEElzbD7iOJKHQtNCDCoGFWeISqIKXqKi3ALVBWcEmHTP7zwYAyF3Pv9Q9D8pXkf3FpF8ANUCyBtDBKHGU14V9byAjaGqcd4cLwyrC1Oogf/iHNZqBpyVIX6E3Vxsc9T7c1ZXmhOGdQNDAmH8htjamyzPZyH1eJ9DBAruI6eMmGKurhgD/GYJnns8hhe5XqdlDzrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8537.namprd11.prod.outlook.com (2603:10b6:a03:56f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 23:44:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 23:44:51 +0000
Date: Mon, 9 Dec 2024 15:44:48 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Li Ming <ming.li@zohomail.com>, <kobayashi.da-06@fujitsu.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH 1/1] cxl/pci: Check dport->regs.rcd_pcie_cap availability
 before accessing
Message-ID: <675780f0693e6_25073294fe@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241129132825.569237-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241129132825.569237-1-ming.li@zohomail.com>
X-ClientProxiedBy: MW4PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:303:16d::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1f0fd5-7f36-4b7c-5c85-08dd18ab7955
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LCDyLMIuwbTaAGE6WtgTXieNRySohZ3SDlscEltcR8pq/rhIrk9WcYqUSDJr?=
 =?us-ascii?Q?hBGdcFIeLN4BfoyUdZFWsYyuBH/n1lGJJxJ4hsHvRBbv49J5AEU6dB1FlHDq?=
 =?us-ascii?Q?YGs6Y54BSeXJ0uKKDRmV2Rzve5Hgw+c0X+otxiEGYhxvri7KIKARD078uN87?=
 =?us-ascii?Q?FEpFNtLCnJymQgwyq521hyI9FJdzPdloH+38UcnG/8DptFJgg1f2Fd+xR1KE?=
 =?us-ascii?Q?Svw2JFmxPOdBFFUEOc5sLSr6fLvLzpx0hu64u4XDY6ZGhiNVev84oxM2bdSh?=
 =?us-ascii?Q?DvURPrKTBkE28y0g+q7nlQmKf1CqoU64FLJtI5PXh1iREa14PvMgwAc0b1jD?=
 =?us-ascii?Q?TBTcfZwTJUAw2kcjBzzQs5IEySJfG04xs8hSIHpvKonRj0ASs0CXva7bQxUQ?=
 =?us-ascii?Q?A7YRG+8hkRtOpaJwmLLdkMTLl3ikxgwMryoO4NorIC0DiNO2o8vtO1F9c8Fp?=
 =?us-ascii?Q?SBGW0nAUR6M+ERFyf7jefmT11iy/x/9D4Qlrm3VkMY/BEJMVvXvIa8YU61L4?=
 =?us-ascii?Q?ZuLElEiOGOi3/Oqo3nOGwcaLVpxghrVB1GPWx3gY5DOrTqV47oK0GswYDS12?=
 =?us-ascii?Q?Nzpj5Q7K7mzU7qDNUKZCO8cYGZkK3J2+zjLk28a410N6ZDowgVkhgr8Qr29d?=
 =?us-ascii?Q?+1nsaQNOPA5dt++zMqe+vJZQ8MG3djHKTDQ5/msGLCdC7IoLGVwvACm/Yui+?=
 =?us-ascii?Q?inJxldi5RndfM+ie8zFcxzEc/hpU4uMuNp+2yptoYuS5Z34owcvaoTUbaaQK?=
 =?us-ascii?Q?zdKPPkK+lSo53L0MaxorfXAdioJ3JB7lNiYtMyuEY4Btb7xBsFLk2Tg1n5g8?=
 =?us-ascii?Q?yW91JToLZgIPYcMWn+q0gLNXSzbhhVqcAQt+tuuiH9UfW8fChMoZjcy6qA7y?=
 =?us-ascii?Q?fboDdWjrOOsN3MaOV7uEKlzgpq7rOCTMfvB1o3mOJjHJ8AYaqTq7HIIcDuKp?=
 =?us-ascii?Q?xalpTGVuqBSEyWaGLQzl4TjRpdvaNSEdkuTz69MkXXGUZfh0xUfL+pNL2JP1?=
 =?us-ascii?Q?ZhS3xMVmt6DI+EyMDNZtA8olMIIen8pAHOoNX6zJ2jRXJV8yiFIGILaeI4fq?=
 =?us-ascii?Q?H8i4WlHdA1U0TGBfdY2XAPR6+HKQLxJ6Abvr2R/ilUZK8XYx4zjG4NKWnLod?=
 =?us-ascii?Q?f4UFPaWzEWaipi5ecWESVb0OHpjHkb6NeADO5mRpovLzc9TA4+SibpfXCzzS?=
 =?us-ascii?Q?B9hq5rkubbRDjdfGz3jn5dxgX/8Vp/H8MRhTJvtDOnNrTxFnyAbNvWOcoYZH?=
 =?us-ascii?Q?3Emo5LDZ9n7Q9B9LuhxS/dhWl5DbfL/Be8gkP3sLvzQnTCOPiNp0noI8WwS3?=
 =?us-ascii?Q?nDq8x7I6xzOY4J3lNFWZseNxY8ubZKD4pcs4HB9K3w/pmg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zEyXX2CPZ9KTey8cooNxx7lBmP6yGlswGvniW31DQsf1fMEDwkFsEw/J6ajl?=
 =?us-ascii?Q?woixy/dFJxMehbOQtjmCmNWEuDv4YZy4bodWpDarBShGMnNyKuZn7HcbLN+p?=
 =?us-ascii?Q?BIDv2lj5KXiHdS5zfWQlnIb1ur5FZavmHS6zGK/lohKi98WssKFGknqLvdIv?=
 =?us-ascii?Q?VfVY/nqNGM/enawR6ft2SQLhbjg0mlhnF4IwSALrz+/yuBGq9qFMXyeJUy47?=
 =?us-ascii?Q?mPbkeY7rtxEz4/TbWsZHdgcmIj3rDcUeX9RyBiYixaMc19HNc9p8p7Ml9bQE?=
 =?us-ascii?Q?J23C4zadho6oROjYZptMs0KpRJ+MhJWWSuMHtXsZa98/68M6oqk4dWAs3Xbr?=
 =?us-ascii?Q?BFsNy0oS07ZyTYd0z845wf+IY5KOskT8XQDWKNT0nA7sGbEp2YhYEPod0sJW?=
 =?us-ascii?Q?NZxKFspQTcrgXIOV5cg1ifGEyUDn817OyvOY+nFqTXv5vjQmEO0WyIjli91F?=
 =?us-ascii?Q?61/k2Qavh73UuNlt1+oW+9SYGFbCyZ3aYogOBWjcz2csz/0T2rV6m9H4E1D/?=
 =?us-ascii?Q?VQHitmsMaH2HuFXF1i8qblGXhhKrrpHwTKLkM388I5k0nWXdZ6PC/s/xyRro?=
 =?us-ascii?Q?0cJ3TiTrQQ5tEBPkhHkkLjBcs1xJIIkB+m0MyMkL+CgZd6Ew0YN9VPlgwHGs?=
 =?us-ascii?Q?U64LfzsW3iEcQTU50W+DH2+HFfJWPKC4u2NxkYYUwU5whUbJakzujPvyqSlB?=
 =?us-ascii?Q?E2a9vFJUq2lKgc5cnfCjOeBrN95K+Ilz+VDLy87Eon3oDH0wb2patKzXgt3d?=
 =?us-ascii?Q?xbqhvuauQzPNYjfvv8kFznlsmFYBEG2g88cdKn4bjiXt10Y57PbO0VOEcdFm?=
 =?us-ascii?Q?Nqz/RXCkWZKIrkHx2LRg3mHfUgLtbfDF3GxwktwbVszj4/CsvUCNinP/pkd6?=
 =?us-ascii?Q?5JWLs5n9e/Yknur8mGMOjCI9B9VrEKSvwfH/uHB6wTyewx7sGWM4yA/E+UTV?=
 =?us-ascii?Q?dcpG+fm24pvUODjtGvYRvbPJ517wxrR92iRoBMmFd31t19bQ1fpA/CJ3hLrz?=
 =?us-ascii?Q?af/3FMJ9NWURLASB5NM+ILeaReeWV0A/X9y+mhqApxFBIoYRZGK1O2J6EAhc?=
 =?us-ascii?Q?wvLMfZHpZ0858tO2yFXGTExPZ47ytqTsZMjAGVXsr5DDpyJBdIXHNU6h+dPM?=
 =?us-ascii?Q?hoRmoSKtm6fACyOUHwSE2e715K+ySHbNWGwBYp8d6ArE009JGQ657VeplUTs?=
 =?us-ascii?Q?SYb+BIYFw+sSX4AsbxpLH3aW1l3r6hvH7yuHgg1nGA+3y5OYiB8vU5QGrnnP?=
 =?us-ascii?Q?psJIpES4tj7qqRyzMOSiELUELYCfquclbhr4SIFRujv4IWMcUf6g2WSvAkfK?=
 =?us-ascii?Q?Ru3xBcpYOhTg91jQ5sXXjPZwx1qK8Z93EYNLDF2qkdDx9n0Z3br9G1xP6vll?=
 =?us-ascii?Q?UxptCTftpGSqbxKNrNYJ53ALU2siY5Bzi91//Fd5vVendruC0Hefo/GArza9?=
 =?us-ascii?Q?3POiOXtxvcDeLQvwqi9KeKSUrQ1Pj5CznhCYVkTHQ+OnFvCFo6mgqQ/gbLl5?=
 =?us-ascii?Q?Dad3hpA9PZ3XY/PTESaimGe4sQ4uWK8xnVXBMNyaubGwEpTem3OIX0GLq93y?=
 =?us-ascii?Q?0Dn/f2YCNawISmEI2I3ed4PSNNiubigOBfkcxM230RznX5Va/X547ONmMDmW?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1f0fd5-7f36-4b7c-5c85-08dd18ab7955
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 23:44:51.2172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdm4Pv/wtFraw7nNSp8Hch+Peh0jfEYqUgrqNoI/3TOPbJNDzdJ0uArEW8quY+FLcKTzJD9du94R/FJyJjvcxIgeQYbZ54CocmDuUcP/GMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8537
X-OriginatorOrg: intel.com

Li Ming wrote:
> RCD Upstream Port's PCI Express Capability is a component registers
> block stored in RCD Upstream Port RCRB. CXL PCI driver helps to map it
> during the RCD probing, but mapping failure is allowed for component
> registers blocks in CXL PCI driver.
> 
> dport->regs.rcd_pcie_cap is used to store the virtual address of the RCD
> Upstream Port's PCI Express Capability, add a dport->regs.rcd_pcie_cap
> checking in rcd_pcie_cap_emit() just in case user accesses a invalid
> address via RCD sysfs.
> 
> Fixes: c5eaec79fa43 ("cxl/pci: Add sysfs attribute for CXL 1.1 device link status")
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Hi Ming,

This patch looks ok.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...but it bothers me that the sysfs attributes are visible while the
attributes are in this -ENXIO return state. I will throw together a
follow-on patch to hide the attributes altogether when these
preconditions are not met.
