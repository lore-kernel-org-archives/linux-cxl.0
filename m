Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7AA1E7C15
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737759514; cv=fail; b=k5/QhcJDBfE6Y3G5L76UTsaqgQAE0ThVZB4EXiRBoouUaYIJjCixti4YmpcZVpTkMBIdZbFvJ4+1fK/9JD1njyYEOQRtcspdEHCxd3aTD+O49wtI9/1fZs7GKfWnJtho7Yn1MnHfTxZIwKJ85frPQHbcd6lacyXLxAiS9mJlDaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737759514; c=relaxed/simple;
	bh=gODKTz5PHAUXnBqLTw4nmGdUA1hJ5CwfEdrvlpCQspY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=azWyMnvoUpVE2eJUlQPxVnF/n1If6Ys85RaCXsbu+7YY9jY3vocInDmxLmuXbxn/n8V5vKwBzk1mXZH48gfYY54iIuDnOtG6VmYK2iTsyyJRluLaBFthwpeC/h5ne+UBcq0uggCJUA9DaTq2r/gwVaN37vxjHHxcmyRJsma2JuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNNJi/Vp; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNNJi/Vp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737759512; x=1769295512;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gODKTz5PHAUXnBqLTw4nmGdUA1hJ5CwfEdrvlpCQspY=;
  b=RNNJi/VpNZU0t+FTkPaKSSvyw2kvh3wsLvmOX8+65pI5RppDQk0YX1XG
   iZtw/4sOi+AkqJPnT4mGWzbz45IHGH+LM8WFekEmd9712Ya1T2rOlsDfr
   vodE+S187uovytasHhFAyBGbMXo/mdC9Vlbk6YCZOa1lCHbGsQZivzlPL
   WgKV9a2e9KCrZoZAYw8DWT21cTDq7D9CovVJRXUOMtR7/hmonkYoxvh8S
   1pigc93HLp+3euSB+WMF2yYdSH3HDggmF8pD+J8SpBdOKJ8OV6UogYopC
   ZbvrXwZkXUIwD387y0heJE76dtXQ9AhIdJsO126CpUBaHn/+64MZJgxJQ
   A==;
X-CSE-ConnectionGUID: cp3jugiWTlWGzYYcI0kkRg==
X-CSE-MsgGUID: LJgut3+eTKCmlBxaFXw09A==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="48896088"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="48896088"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 14:58:32 -0800
X-CSE-ConnectionGUID: PLM0BtJESHuARrhwIo9usw==
X-CSE-MsgGUID: V3xE0DUtRWOQB1xu52CWSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="107699143"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 14:58:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 14:58:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 14:58:31 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 14:58:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgPZjjanJV+FJB8qCq0Q4vMK2hYA2ixIGonfcwbWnR/oQd1F2P6py1PFBNPN58+dHX91M3zGJQFKFEHPXTukzcxmq0AoODtKx1GioOxGf3GyM18rM4SKvUDM2cdfiwCOZ7i3TGj4eVDOei2DIA9tRNLmFHeR6n4eXpSKpFWdNghUVHDRxgBAPcxNzFDjzMTMjs6xzP0wNn81fMcwGB9y8xMbQtZ2mRO+HFG1ulL0iE4x9+YWqXveHB9Jg5k1OfzcK1AzC9eZZ7FhydrUtw23s8eFyEqqXPMYyJ5FugYnScrrAJf1a7tXY1KsZVfKazFFZZoKy75O7re6Emppnc5eYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqGFIxMKZZTWAC366kCyi8HEwMtVgmtIv4Kzr+Dkfpo=;
 b=Ho2nYsCwqONVoprX31QSwOvrb5vSufs4CdcBHKVFEU6yvk6FWVW7A1LpCyuZlgbNVGd7CFgEoMR/YEXBCZOXDQLm+mWtnwdUnUz+CgcBrDv8wWtyp7UHyUVdUSvdhkMyRaKxgyaZmdS2Qb6fPaXLkmZjUpoKuhqv9EiCScUzcuswOlZ03YkL+1dO9MGc9d6313yacXwrWNo+N8+1/fEwuMLY4VgDQ2vjwlIfRTZTFSyfI3Oc57wmE+o+DQDdOQ8UH8f0TUBaxSwjfrKSqyeDWODVYIaEefncc0irn63XY3l9Vnr2HgBzi0D60NMlVS5ihQouyEhQVYa/s6xkiupzrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5793.namprd11.prod.outlook.com (2603:10b6:510:13a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Fri, 24 Jan
 2025 22:58:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 22:58:28 +0000
Date: Fri, 24 Jan 2025 14:58:26 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 07/19] cxl/mbox: Add GET_FEATURE mailbox command
Message-ID: <67941b1261dfc_20f329470@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-8-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-8-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3435e8-e148-4bd0-2142-08dd3cca9de9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FphVK7BlMAs3uh3SjR9XBTeqsvzV+xFceBlnizvmgkelBs2FCRF5OI4YCotv?=
 =?us-ascii?Q?yHu+I/YsVuH1Dq/tp0F2Szx4DuvP/7rFw0n2+ODEcG57nZfWn3sQZfACQ5EY?=
 =?us-ascii?Q?Pp/EwzYzyOCQZYjFFCiaE6wd+heNqp1KjjLnztIacCLExm8pkyT+3qcjtDhE?=
 =?us-ascii?Q?BVmRa2l5RIBPZBKmeBxdDh+eCCoEmgYG5e7UCj7G4wXgE96xRZA0zh8M16ru?=
 =?us-ascii?Q?HYhhhpCYfuE5Ja92ybiz5+jzF3+zVCrW7I0OjXjnjXATb3Co6TR4xeOa7sZn?=
 =?us-ascii?Q?BVVQD1I8PeWC2b8BTa5/IX0kLvQKLy94GWOLsStND5CsM/LDxc/RLW4D/iDp?=
 =?us-ascii?Q?yxekTw1AA1paOhndTvhm6HLk+2II2BubzXv+Zz/aMogjt185m594ipHGs1B4?=
 =?us-ascii?Q?xvqvPWGXZB5rkT8gJkvpCsk/E3ma6XnnHyl3mOiLo5qu0aEkpVrvTf4InOSI?=
 =?us-ascii?Q?1PY91+1sak1Qh7v0Dye6wU5LQpdrXh6S1VuQWYXnR07xoaeoF5ibTMH+U9B1?=
 =?us-ascii?Q?90QzsLeeR8INlOmsLBUiTGFSxDU/jZw6cycujCY4DA2f9cwLb2azVLgkULZh?=
 =?us-ascii?Q?W2qf/IX59rlxK7yq9MQh70cSxAAWzq+H8hWSM9Qpa7GlDv3cidXyJccZa+TL?=
 =?us-ascii?Q?om50rDXMTXL/AgLJyaMMxteJpTW/RUaU/bWMpKh7n6UwGWr/dffYJ6ubXRRD?=
 =?us-ascii?Q?/z4KCmwBnOl907fClpL7YBQGnqDRIR4eWHSWAdwxX7desc7NfirjG+StVRJT?=
 =?us-ascii?Q?6xgoxuNiP0yC+bDgC2i+Ak5iS5r30bM883sEmv7DQuM40tz8Ny5BUw6tOg2q?=
 =?us-ascii?Q?Dsw1e3y6OQHVfTxapanRMi4a1eT9Dz5WCNCAQ1Bo8yS1eU/ad2rTTNc/dql3?=
 =?us-ascii?Q?MKyGwL1JTxdVbXrQ1khV9UvV1LfSqIbQrbFo+SL/Th9GqbtmufSdql3Z6T3y?=
 =?us-ascii?Q?MQE2IPDvYIV2HP0Q9Fi+1o9/86kHwvcGl/NMQGst9oEwvaVF/XcypG3oLDQ6?=
 =?us-ascii?Q?hYpIQZtKZDoLi54ZU7qCTx/hYukPFfM0xofNhfUBBXewlExmoAyHnj5XAPBA?=
 =?us-ascii?Q?iFtWCLWdJnX0Pjs6eKNXoAnLCjG9xFSY98joNA9P7JvIcWJmr16r8P8yOYlY?=
 =?us-ascii?Q?1wbzXfwMvFOkafuQcC+yVRnPmVTVex++ls/zpIw21pFq6drmRKLERCZaeJjn?=
 =?us-ascii?Q?Tw8Skb8xs+eJOuD2rSU/9g/Ihv8xIohAo8E5B1ULA6uEn3IorG1J3WGXF6fk?=
 =?us-ascii?Q?cH2MEyo8N+T/iT3Cr4/cs3pvwrG9TbFrZC8VlAeQf/sLoXuKxD/nNLf0g5w5?=
 =?us-ascii?Q?s9rGJpjXi5I2nXuVtCLZffPkp5kS8vSI7wi/xJhMLO92stxe01ez0VGmSbZd?=
 =?us-ascii?Q?LxhvyWZqWf1ay5vsZj3Ift0QffiZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PpxbSQ5gl2zhnRrEu2WhQxOzV/TgFkmF9/9LmrCDcFBJ0m6f/6yKOOCmzQVz?=
 =?us-ascii?Q?yC9ERn/exdo2auPuNrq25dsb0H6pHPnvVhOVtOiFfPew5LibnJl8ZxkTwuRV?=
 =?us-ascii?Q?b8+xZYUK7vU4XrWnKucFHW3iffQQl6rF6qJg/zEhUWg9+pF642ET7dP+cWjt?=
 =?us-ascii?Q?KRKRNTpFkaS6RF+1Es/GFocYeaINomMlenknvajNd4tcmHCvYQbiXPOK/q3S?=
 =?us-ascii?Q?JrIWAlUERvzewK0XsXTTXwthXt1w47qvcelFX6uIxsSE3qfvGe01qhBhF4gk?=
 =?us-ascii?Q?FGQg07R4ec642dXT4yo+i8xJi0543S9TP4J7T9lo7mG1e+GOeoBJTYSsm88l?=
 =?us-ascii?Q?7w2AG4CgdQJLQDxmEwKmMePJqEzpFp9tIRGyQbiz8v8XNV61KyoN+vB9eDin?=
 =?us-ascii?Q?/vcQKz6GNbuDlbgJd6L5R4bCSrm6Ls6pfUK2Xo6qypS6L0LjepolFxjR062V?=
 =?us-ascii?Q?/616FDVNgOhAR5woVOcCSUlf5/UcD4T6OBnP+89AJcFvQtghA57sGwIGWDP8?=
 =?us-ascii?Q?lER/u8idUYDrRmeRNXb+DW367ZaTiF4oxXnz2b0CGsoa5HJxnGQYZkyBKuvG?=
 =?us-ascii?Q?wEpWzBDNpVJnFtrfmvL02PfcDYKLykJ1VPHt+9bEXxo1RJkpag6avin5v/A3?=
 =?us-ascii?Q?Gg/tywO4celk5T6Muc7wVl/EopOOYtNc4Bf+iWuok2Yq1GlEOyY0n7iTfqFP?=
 =?us-ascii?Q?/dhcjcAdO/dwJDs9Eca49eKnb6tISg1fqaLsXK/NbNr0S2VdiYbRSmdIdNpY?=
 =?us-ascii?Q?a8c7ieEEIMs1L0/Q0TSUWCePui6876jEU98Lf+yiUF8wmB5UskBXGuc3ffew?=
 =?us-ascii?Q?lHGC4/IFtx9v/ngpdJPj31IRf0D2UV1l8tX2OZ8CKTPZHlby/jen48FLW1gc?=
 =?us-ascii?Q?WtyItvXvaPVHcAhPfcE45UCqnGn2/gA2V3YU2KFdq8UFthB93LDuPMqkF3N4?=
 =?us-ascii?Q?2AeOsIype6k6KmxG29HTPTaZJ4qPsKtFhz4jmP9pDxT+tg1iCAAYQkvB6CXz?=
 =?us-ascii?Q?dvHvg/g48HRAKYNWJW94Tmb7NUatxi/rUPThUdGMdXHF0PjZ+dIyRT0NPZOu?=
 =?us-ascii?Q?r7yMGQumi/qX2H+dtdSXm3UwAI6hb6iMu2WQdof3vsMJNQ3pHOCzOn2L0Te4?=
 =?us-ascii?Q?QRkBbiWph0Od27cSmz8/a+v/bEnu8IiYKwgQ8xv2sx0Twu8Y/LUDcgLUuPnV?=
 =?us-ascii?Q?kqMU4kvrxLN7MvnHoaFFdyUq6N95D8VHYdHELoYwvdHiziVNw1HLkWIbWUrl?=
 =?us-ascii?Q?mMDvRTJrW0uVvEit08pZjeKtYfA3DXyiwNhZeYXP15A3HcUbiPJ4FrDiuZCN?=
 =?us-ascii?Q?ra/GsxJ1qZtp5sb9ZXHDLBfgIEDR5v2jDcTIC/yzgu3PpPxVEJkYw0aZMc6L?=
 =?us-ascii?Q?SqENSEoddoIeOlbCk9SCsyKfejWR4vQrRSOq0FQX+jjIjDl1wPvG0tbBw1WO?=
 =?us-ascii?Q?NT9BXlMusn8UQhl8nb6oaEG/a3EgCafUFvhgCrvb4iTGxZAx0E2ZOtXJU4wG?=
 =?us-ascii?Q?a2fg1s+aSJBJLJIMzBsxD6w9moPZb0q5JALPv0x4lfuAk044stvg5EjFm5P0?=
 =?us-ascii?Q?kh10Ouk4FON24ks6zIqxRn0SPzhTeruKaqXxOCibG9ddgdu6NwahPKB9A7Zf?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3435e8-e148-4bd0-2142-08dd3cca9de9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 22:58:28.8920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xW/q2wvwkVMr2KN+9S4NZCbh4Kpgkzsuo5Z867XS+GzL+cIJcGSa5DRJUktMEIziDvIX+MdDoRynMT3nYwt/CAzo8kwRR7SibwElsAbqyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5793
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for GET_FEATURE mailbox command.
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> The settings of a feature can be retrieved using Get Feature command.
> CXL spec 3.1 section 8.2.9.6.2 describes Get Feature command.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v1:
> - pass in cxl_mbox instead of cxlds (Dan)
> - Move to the feature driver model. (Dan)
> ---
>  drivers/cxl/core/features.c | 74 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/features.c      |  6 +--
>  include/cxl/features.h      | 27 ++++++++++++++
>  3 files changed, 102 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 66a4b82910e6..ab9386b53a95 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -4,6 +4,7 @@
>  #include <cxl/mailbox.h>
>  #include "cxl.h"
>  #include "core.h"
> +#include "cxlmem.h"
>  
>  #define CXL_FEATURE_MAX_DEVS 65536
>  static DEFINE_IDA(cxl_features_ida);
> @@ -97,3 +98,76 @@ cxl_get_supported_feature_entry(struct cxl_features *features,
>  	return ERR_PTR(-ENOENT);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, "CXL");
> +
> +bool cxl_feature_enabled(struct cxl_features_state *cfs, u16 opcode)
> +{
> +	struct cxl_mailbox *cxl_mbox = cfs->features->cxl_mbox;
> +	struct cxl_mem_command *cmd;
> +
> +	cmd = cxl_find_feature_command(opcode);
> +	if (!cmd)
> +		return false;
> +
> +	return test_bit(cmd->info.id, cxl_mbox->feature_cmds);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_feature_enabled, "CXL");
> +
> +size_t cxl_get_feature(struct cxl_features *features, const uuid_t feat_uuid,
> +		       enum cxl_get_feat_selection selection,
> +		       void *feat_out, size_t feat_out_size, u16 offset,

Is @feat_out guaranteed to be a kernel pointer, or might it be an __user
pointer?

Shouldn't @feat_uuid be a 'uuid_t *' rather than a 'uuid_t'?

> +		       u16 *return_code)
> +{
> +	size_t data_to_rd_size, size_out;
> +	struct cxl_features_state *cfs;
> +	struct cxl_mbox_get_feat_in pi;
> +	struct cxl_mailbox *cxl_mbox;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	size_t data_rcvd_size = 0;
> +	int rc;
> +
> +	if (return_code)
> +		*return_code = CXL_MBOX_CMD_RC_INPUT;
> +
> +	cfs = dev_get_drvdata(&features->dev);
> +	if (!cfs)
> +		return 0;
> +
> +	if (!cxl_feature_enabled(cfs, CXL_MBOX_OP_GET_FEATURE))
> +		return 0;

Per previous feedback, just make the caller responsible for knowing this
in advance, not checking every call. With that gone this function loses
its dependency on 'struct cxl_features' and 'struct cxl_features_state'
and can take 'struct cxl_mbox' directly.

If for some reason the caller did not know that Get Feature was missing
the device will still fail it anyway, so that boilerplate is not serving
any useful purpose.
