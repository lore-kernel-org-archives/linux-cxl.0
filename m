Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D210FD
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jan 2025 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765938; cv=fail; b=pqCKVkIWyfbP0G8HV+VoEBvIo3kv7J0Kldj1oeww4ke/+TqL8G2PY2p/1j1UsQdkEhRV5ilATuZG8Rj5Y+XJWpSHHueyvkNrmGAIxvItO0WutxH6OU98gb5JIqbjYrq1TDC8AkYgWPD/I81WwD6j145KZsEAv9YvZX69WGAafNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765938; c=relaxed/simple;
	bh=rLv7WyZMvuJrsaGwW7eynqvJq6L1XvPSOsaBlmG/6PM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d/M0MvLe2L3cCWhsuNnH7MB6gp0S394wtFRG3KuNgWynWFQ5264uIGnhqbiKkBTyVIZwPDxd64iq+pH8VxwYiy3YTQnHsw46Hc0BLOZBbkULuJJCuFTu2deAHHXJnEWryjFZ+IsVskuMYBpu87c9kr2yMpCISMVwJaHycJzhVZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXj+yoxe; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXj+yoxe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737765937; x=1769301937;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rLv7WyZMvuJrsaGwW7eynqvJq6L1XvPSOsaBlmG/6PM=;
  b=IXj+yoxe55KA0SCVHY0oWWmqLDoVguSaAcFtyVW3nzRzH9BX6Vnm/6xW
   Q5dJehVZGMxldYN7jKyOzQ21unDnchSmW9Q593ouTBxjmbjPcG/3P8pkS
   HLJZRk1P8D2jMCx74ZKfIp4MwbN6JWeKMba3lPPSlNXMVB9PmzSSb2fx8
   IcW5JDxomM7uhNqREsmx/1gFmDPh7fEwGI1bjwUCach4JWeW+bxG9Dthp
   itwWbQL7a4Rsue2A5Dy6RPSREEFk8kZpplXc9AAypElAkQIPrFeqGL/R5
   fu3bs2bKH2GCGBjlRDjOKjy+sSqc1PQTGfDGEBuvuPM0zqPVYsPlUihls
   Q==;
X-CSE-ConnectionGUID: auwztRzPSOW4E/rmxl5tEw==
X-CSE-MsgGUID: ntG8PeUkQyCEEYhHGDsooA==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49301699"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="49301699"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 16:45:36 -0800
X-CSE-ConnectionGUID: khkNTYEBTraFt5ThoQaE0Q==
X-CSE-MsgGUID: YuthETCeSGuu5f52sWEg8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="107808286"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 16:45:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 16:45:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 16:45:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 16:45:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRJJch/OwvgXBvZSlnnbPSGDZuBh0xHJoAmrKgl28CyC+l5oU4RFLKZoBjKaEAPClUC/eAjsTlkJ1AaPwBRVBa9cP6/WwbQtMAWiLDDFQFqXtRfJXj18suu14sNHF0p8sxfstFT8xugLvdg3jTqJup0MbsMrIba+Wd6ieEd4moapAwnScpUc4PmekIDBgHH+fcNL8cfJm8aJHcwSfoxJNhJvCc2J24+XyiCELVBvNnO6O1PgaZTKZze7WpvIrmQRLVkcgTVeNK6VOe3CoJhanQJOmJG8VJPd8f/iS/SU6uiGsHJQAeLTWcWMl5xw1uNAHEDXD0qw0JaoN4zk0KnCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqmK0va/7UVgMpm0DvOdYra/JzwuCmnJL2UIZgwy4co=;
 b=R1OaJ7OVC2Sbe+fzDswKYiv1LQYYw5uUN4Dtu1RrDXUWiQhc3au+WZ296pyPOKThGyIgr3AR2Vrk8TRWqo1teMTNySk3VEHRTM0sGDrcld3Zel323crB4RBAP6kvw3RW5jKNVD3jy3Cv43R+zYBZsoa5iTCezq4Ws7y30okFZ+wuGZw4ukYqdzVPoixUTIrrtoCBov1dhhoH8qWT/58FfFW9EAn3+eCzeBfCUNmJkBsHJDF53gLh2oKaRZ0G1Ypbcq3fSRt7Fs1zjNlKDEwcAFTyF4hW/7K2ZDlMhwxNpdO18PiWUxNG/XdO5eEO9lT4uSaljSQAMbKOLeDdefsoSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8556.namprd11.prod.outlook.com (2603:10b6:408:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sat, 25 Jan
 2025 00:45:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 00:45:32 +0000
Date: Fri, 24 Jan 2025 16:45:30 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/5] cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
Message-ID: <6794342a35629_20fa294bc@dwillia2-xfh.jf.intel.com.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753636159.3849855.512949598685608224.stgit@dwillia2-xfh.jf.intel.com>
 <0ebda6db-8431-3ef3-9c24-d19cbec7f338@amd.com>
 <6792aedf7fb0_20fa294bd@dwillia2-xfh.jf.intel.com.notmuch>
 <ecaa87d1-29d3-eb41-5a92-ecd74a9bae2c@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecaa87d1-29d3-eb41-5a92-ecd74a9bae2c@amd.com>
X-ClientProxiedBy: MW4PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:303:dc::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c31b2f-fb9a-4d80-22de-08dd3cd992e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?eIg9248yUwKP7Q6vvrRoIs7GvWEH3wo7Q7teQiNXln/qk6JOkVTFzGaCll?=
 =?iso-8859-1?Q?3ct7lI/inkkt9BCKsRYgRNPD3dLpyVidliRWkt2uMj5suz6ZZKSkmsYsxr?=
 =?iso-8859-1?Q?KuPM4Ihk1drzGefKok8OQine2ZUYsRqgWXMb2SDrZvf/WoFbu7QGGmfL2j?=
 =?iso-8859-1?Q?ZgG7cykqDa3skKPW+ggKIfsA8Ue5d7hg8wadhh9u4pBcCv3/LSoeHOzrAa?=
 =?iso-8859-1?Q?8Rjsnd6S+m3M2TQzZXOAUGQxUKi8UlrFmATTLQrlBzF2jSPjplvB7E2N5B?=
 =?iso-8859-1?Q?CdKOd/2Zs5tJg8r1w63AFVOTl3AKg7KOZqBSqWhNiavIXeYd2eoSNmcfZ9?=
 =?iso-8859-1?Q?iYBlyo5xlvrd/JH/BMNf9pGI86r1Y6tLsC9669w8LujXGl1MfmvU3gsSzy?=
 =?iso-8859-1?Q?UkeLA9TwvUiNwpwSaIwmijv53Kvbjo8SGYoPZ5I0c7CJ+MnZg6WLsQd7jc?=
 =?iso-8859-1?Q?punqhnIi7EIvgszv0lu029+Cvp0Qb4WqeBiS/JkUokn6K15g8ye0xs1XeI?=
 =?iso-8859-1?Q?OTTwalEKi46yzr41hiCah1wDbQNzyWl5JIl3c4o2BtNCyYPo7QeEEpDrmZ?=
 =?iso-8859-1?Q?L8wmZVKaTUmVUH7IexWh4NhkIzfIp+/VdOsdULhZkLDyJFw3GxsRKErlUx?=
 =?iso-8859-1?Q?2qSGWpjQptB4SrLN0+yfMfzPVAY8QPWJdntIM6taNsw2gZGqiJDCfQXW6B?=
 =?iso-8859-1?Q?Ogz7c3egVRC2NMpS1nshV41PS6kQF5AknBhKI7iu6dbVPNE4jfSnrSNNCN?=
 =?iso-8859-1?Q?A7jkLNpqlUAcYtVdg161S3Uz6hh80GggM5JM4bNRCrpt8iy8nIY7fOU8Xj?=
 =?iso-8859-1?Q?Nmwf835Ppbfg82McGhTqkbDwc3ydl7m4q7qatw4gFuNLI3MI6PYzee0Opo?=
 =?iso-8859-1?Q?kaHhIK7Bm88a+CGKj5NEm6NRJl1D2W9XtHkq58WlVorVPQMmtYrkWod/fa?=
 =?iso-8859-1?Q?+3Sn7r9gfUoq0FWe7bkvuG6bY0xcQNQ8MdwIySQSiXgPvYDssfYQFy1P7P?=
 =?iso-8859-1?Q?Do1za76YX3fbyThmI7SqAVJYBH4CLgWy+tIR74r3jQhzMtSFFrm9lAybYd?=
 =?iso-8859-1?Q?kieqbltYOejJsC6rpcZwFKqFN+U58z1yfRafo2Zq75TtTpyOjX21Ct3epk?=
 =?iso-8859-1?Q?ZF4LsfJk1R7O8I39hXUjjnMyVYMQcP+gLjRCGKOjGQ8twDClHKbICUwrlE?=
 =?iso-8859-1?Q?H58ZLrI+G0luPF1ZX4UE7wCupTDQZn3fjfsbs+2DtUIJ0DbajZUWV5WjpB?=
 =?iso-8859-1?Q?1PmY5Cd6JDwsOf2rJ3PNgqaixWC1HspJu6FSivncmnomK3I9PPN8YZ4dh1?=
 =?iso-8859-1?Q?w/4BDqQ4x8vvbD9bOFVUxndFT/mVCyJ5Hv7pSxhQdAJ/Thak4UkAlrnmmc?=
 =?iso-8859-1?Q?2Bg9ekLjcucUwMp0Y9WmxKvFIh+otKYDXUYsIl/Bjve8HKcMMZLYcbP9dQ?=
 =?iso-8859-1?Q?7DdAjtb2eKpf18Jg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?oI+A0UejJdiLI+F44uwVawspUxCM86r9nTvS8WB4ScknB8ahehD9hTGwZR?=
 =?iso-8859-1?Q?EnHgztjboCfKgdkozBDjBaHeRDN7uVzsL2jxvuH/savYGi0gWleWNx8w68?=
 =?iso-8859-1?Q?U28jnUh55jlwBssFX4LEmt2W3ESfWa+RgeIeI3tQqx6RxRHiADqWeqqspD?=
 =?iso-8859-1?Q?oFETpAvhKIkhva08XTOeS4kaFQpkD15pZsO3PlenIqq9mjVhLPJM/S2waD?=
 =?iso-8859-1?Q?6rNm/tWuYLtIncyAlwDeDqG7Lkq3Ks+RpRxeEkI1dlvuvPPqmNE4JJkHPX?=
 =?iso-8859-1?Q?FgknsdxFiEi5AUwZDhWg97Fn3NZhpPIsEAtavZC/bug96mIP6N7xnZnpBf?=
 =?iso-8859-1?Q?shAIicULbZmJ4zgQshaxuZa2iKTc4rIrB/WzibaSKbPglMfGtIqOyfvhtx?=
 =?iso-8859-1?Q?EzmjCMh6FjnBd5TZq+GxDrNiXyZiXRaUDSAocxpzNVYLcajwPktN5yrvsf?=
 =?iso-8859-1?Q?tXgX2xJBitrZPKfTkW3kFARbegLqAQtVAuHxnTEVYZY/lQdetM90RUxfDE?=
 =?iso-8859-1?Q?AUgM1XCMIopd7596toiB0xD7YfWJlQSxzxM5HSO7xIfcQBsdJAt9saJC3b?=
 =?iso-8859-1?Q?4yVHmbgdSk/RPmmMGfaNiCvOr1G4WCAzosgjTgbE+IX/D31mXubD9agfXe?=
 =?iso-8859-1?Q?9meaVkx1MQXmLeUVzkvNUlXsCsFddYsjdIaHMFi4/3EBROm7IgoUaNW92l?=
 =?iso-8859-1?Q?IhmHmfI/nHqH5CfJtC1eB5191PH69YF+0pkJVat2ktx5vyBVbpAY5Wsioc?=
 =?iso-8859-1?Q?LKlj6fzanLT4VWRhzVKUZ0tpc4peDo6gArTZ1rtT8WrWs9zju4tE70Fj1B?=
 =?iso-8859-1?Q?hXFOh8ryCJTza5mm/w4eJKJhIOAGKrTKVcs5mLXtD+AXVXEbXJZXvoTume?=
 =?iso-8859-1?Q?oDKFggM8uSJ9+xIEMAQqauZ4Ct/lWRw003DgVnaTlqIfqMPUe63B7c1IFk?=
 =?iso-8859-1?Q?QMmxe9Dus1k/qNAZcVU/AonvkxCEjckE/kb+KwOdMvbgV1I7sssX61OK4e?=
 =?iso-8859-1?Q?i+aZ5lHpgj4CJzVx+8twiLfyZnYJKFm0aStPS/6M+I3h1umRfrdgDaxC2F?=
 =?iso-8859-1?Q?WQMB6MFlehFMgm5octWoC9bLti1DEzKllTWi3BrFeXYLs1v9S/Q0tw3mpq?=
 =?iso-8859-1?Q?zxBhNWHw7CmY0GBl5t1tf7gJ1QBvsa0/VZtWPZ60HBtvUJXqYY1WhCTiTr?=
 =?iso-8859-1?Q?oN5F+Y7wlCuSN/7isxDkUPkkesP9UEFbnWlUxXwCKROZeoZlI+zKVYzx6n?=
 =?iso-8859-1?Q?qdc2ioBjXgi7R8c+gmnn3duoKtcFcwLSy01Kdt6nd8d2+mwtpzt8qolKi+?=
 =?iso-8859-1?Q?zB05VnLqObvqFacEl4Z0AtXU1BMRmvYwkuUE5XycR98PgSxZIPj0YvQFNl?=
 =?iso-8859-1?Q?xP2yAJc2W3PuPyLHHvqFZl72VenpRJjMObgWZA7qO+d+eWD1hk4P4J/gAT?=
 =?iso-8859-1?Q?wxs4QgswUfT6TuxhtfURQQEsPImstd5SHV0+gbsptgTsmWdWOtT09LgCAV?=
 =?iso-8859-1?Q?MoKqWCR8MaNKsThZkeqC37Hj35RBxtWOp6v3G/FM6qV9/KPiuL7Ns4v9/G?=
 =?iso-8859-1?Q?886c9WWdxmLUeOysW0j8AN6+o6B4ecjSzOL38RUbl95kWZ/LYCPlDlS6qm?=
 =?iso-8859-1?Q?pMZlNMsLbaCjtvN6NckTW02UWg+MFQ4En2Hp2s3cXiNg6UkWSonZohBA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c31b2f-fb9a-4d80-22de-08dd3cd992e8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 00:45:32.8304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJyFivXgyeeKHVdgNxrEpwXTNl5I/m2zE8l6rSN3HrGbqryZQJ7oKyTyytO3Woh6d04kfmsOg2a8QvF6XPEkzgj4MrVKuB3ZhArRFPh5NPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8556
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 1/23/25 21:04, Dan Williams wrote:
> 
> <snip>
> 
> > xa_for_each(dsmas_xa, index, dent) {
> >>> -		if (resource_size(&cxlds->ram_res) &&
> >>> -		    range_contains(&ram_range, &dent->dpa_range))
> >>> -			update_perf_entry(dev, dent, &mds->ram_perf);
> >>> -		else if (resource_size(&cxlds->pmem_res) &&
> >>> -			 range_contains(&pmem_range, &dent->dpa_range))
> >>> -			update_perf_entry(dev, dent, &mds->pmem_perf);
> >>> -		else
> >>> -			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
> >>> -				&dent->dpa_range);
> >>> +		for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> >>> +			const struct resource *res = partition[i];
> >>> +			struct range range = {
> >>> +				.start = res->start,
> >>> +				.end = res->end,
> >>> +			};
> >>> +
> >>> +			if (range_contains(&range, &dent->dpa_range))
> >>> +				update_perf_entry(dev, dent, perf[i]);
> >> This is checking if range contains dent->dpa_range.
> >>
> >> I think it is just the opposite.
> > This looks like an equivalent conversion to me, what am I missing?
> 
> 
> I guess I was confused with dpa_range in dent and assumed that was the 
> full device DPA. But now after studying the code in more detail, I see 
> it is right ... but confusing :-)
> 
> 
> If I'm not wrong again, that range_contains should really be ranges 
> being equal, what range_contains does also cover ...
> 
> 
> It would help some comment explaining what the function is doing with 
> the information coming from two different sources, one being the device 
> CDAT, with potentially performance numbers per partition, and the other 
> being the mailbox GET_PARTITION_INFO command.
> 
> 
> Anyway, apologies for the noise.

Not noise at all, a good review of this function's decisions after the
fact. Dave, do you want to follow on with some commentary for this
function?

I recall part of the motivation for range_contains() was the fact that
theoretically the CDAT DSMAS range could be less than a partition, or
cross a partition boundary. The policy here is about explicitly not
entertaining devices that want to get fancy with the CDAT. So, the
kernel just picks any DSMAS in the partition and uses that for the
performance information. If somebody screams and says the kernel needs
to be more precise (force mainline to carry more maintenance burden for
their use case) then we can revisit.

> 
> >>> @@ -567,6 +578,9 @@ static bool dpa_perf_contains(struct cxl_dpa_perf *perf,
> >>>    		.end = dpa_res->end,
> >>>    	};
> >>>    
> >>> +	if (!perf)
> >>> +		return false;
> >>> +
> >> This change seems to be an improvement or hardening. Not against doing
> >> it, but seizing the change, the function can be simplified using the
> >> parameter without any local variable.
> > No, it's not pure hardening, it is actively avoiding NULL pointer
> > de-references introduced by the new scheme to not track empty
> > partitions.
> >
> > I.e the new to_{ram,pmem}_perf() helpers return NULL when the partition
> > is zero-sized. Previously this code path would do range checks on empty
> > partitions.
> 
> 
> That's true.
> 
> 
> But I do not see the reason for using that local variable that I know is 
> not related with your change.

@perf was never NULL before this patch, it may be NULL afterwards, so I
am not understanding the "not related" charge?

I.e. previously, cxled_get_dpa_perf() would pass perf entries related to zero
ranges, but now to_ram_perf() returns NULL for those cases.

However, I could move that decision outside of dpa_perf_contains()
rather than deleting this NULL check in patch5. I'll do that.

[..]
> >>>    
> >>>    	if (!cxlds->media_ready) {
> >>>    		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> >>> -		cxlds->ram_res = DEFINE_RES_MEM(0, 0);
> >>> -		cxlds->pmem_res = DEFINE_RES_MEM(0, 0);
> >>> +		*ram_res = DEFINE_RES_MEM(0, 0);
> >>> +		*pmem_res = DEFINE_RES_MEM(0, 0);
> >>
> >> This is a good example for the discussion about the  patch hardening
> >> resource_contains. The initialization seems fine but IORESOURCE_UNSET
> >> not used.
> > To the contrary, I think these changes are an example of "updating
> > resource_contains() to check for zero is a band-aid that does not fix
> > the root problem".
> >
> 
> I agree, but it does not preclude some resource initialization as you do 
> here not containing the IORESOURCE_UNSET flag and some other code 
> triggering the same problem I faced, so the hardening of 
> resource_contains still useful, IMO. But I'll tell Bjorn Helgaas that 
> patch is not required anymore for CXL leaving to him the decision to 
> apply it if he considers so, following the concerns you expressed there.
> 
> >> it could be argued the resource is set, but it is a zero-size resource
> >> leading to problems in current CXL code.
> > I challenge you to find problems in current CXL code after these
> > partition reworks.
> 
> That's an unfair challenge ... you removed resource_contains ... :-)
> 
> Let me think I got some credit for that after my heads-up ;-)

Oh definitely, you did.

That was part of my internal monologue / uneasiness with the Type-2
patches, something like => "why is CXL sending 0 sized resources to
resource_contains()... oh, no, this whole partition tracking
implementation needs a re-think".
