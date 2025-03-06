Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C81A23BD;
	Thu,  6 Mar 2025 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294660; cv=fail; b=cPPJFqUDXX2cVV0bQn8dW8M5QOt5mYFt8p4D0yQUInBkr4kEH/eJnTSHd75QaApaXy72rAYi+EUjCCn3tYIy4d9rmuBHVoYuabkgASrMDlZClEr13/gJGMSuKaHdqTS/a+m2R48tSWUJU4t4TYPuFWLXYJ4eoXXB0/SrCFnyKcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294660; c=relaxed/simple;
	bh=zdQ7pyBLoVcS372hvsFNH7I2eDn6qQPM9wYoHD59/qA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c7hz2M+NfoCJEfkelyQjwu54w23as1RV1AbsBTRdjocO07TSTjNN3CA3kAErFaSVUpTO9K9OIjsoYBjZbcNlnbcyJ6IBgWjZI67k0o/rRaohLJwOpzQBu49kVaZVpxdg9/rfQjvc2SZTDnosq58OnZ3onhubn8h02L2XIbl9kAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QB7XleiF; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QB7XleiF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741294660; x=1772830660;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zdQ7pyBLoVcS372hvsFNH7I2eDn6qQPM9wYoHD59/qA=;
  b=QB7XleiFJtie3uS5e9IXcQpQ4Bq9blAI20Q6O8SNu6od2rqY1S5izS/P
   UJ2YnIRzS+E4EkalxdK/BgLN/wXbacDZIL90AscTLOOyLNZRtNqiDWzCg
   Dxp2vGXLWyqzdPheJiQrGXUehzNkBWRddxjpYp5WQ2Nm8QM/NEQRssXqi
   E5kPRkNTYtR3aI3jSRCD+aNObpv1jwv2QbXnZi5k0l9UjyK/4Yw3+4ruj
   ugDQvZyERAhjAHuxffrDOXnBOf86jkbinsZbbax8aCSDrEoPFDxMRcyqr
   2v2WnnmESdi7SSKullDJMYr7SmOMyki4JCmcwPwQAglLJl/dohCG542a+
   Q==;
X-CSE-ConnectionGUID: kTOTGhJpSXGOxkSehumlQA==
X-CSE-MsgGUID: WEDGIcNzTY6vtQxi2U+HzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="64775031"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="64775031"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:57:39 -0800
X-CSE-ConnectionGUID: JXQAbK+LQUuCWX6fnlUz4w==
X-CSE-MsgGUID: 5SsDO0IXRgeR/Wtu3WZ3vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124338293"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2025 12:57:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Mar 2025 12:57:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Mar 2025 12:57:37 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 12:57:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhHq6paHWZomtT/DRrXJ2bnN2DJ9mHi2wOdw98gQnCP1UQk1FciiSMT4VdjiBT1A2PNaLU+Z4WHokJ3UjzMrgxkzqBTRgw44dl7MtCB/rN097oAa45YqFpdM8OIQfktCifEk3Mzc/gV6PElkNntkmhJisJo/e0ObO+bxSyQ3FMKRSCwztutAydHhp+0QawfItV8GeG/nCPNncOcdKE0UE2H77ODRj3IrwuIGWSJ6Jd4XqYw5Rlw8FfP3EzZjwMhZh1ruXZ8MNAhqUOgsMZ1lxPwPojOdenTKiSpPIyFKtAiQk17cNs5fZlUzeO0e1wzRycM1NzQEsoAyxWPHVVpa7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9HdY9yQiU14m7WUEhQZPiQqG39gmqL9zabg1HImA4I=;
 b=wa6FCxSRZ4ndE41aWTFgxGVYUjkLNNE62gSioCdvnWRJU/qzs0KsbyYxLKhF0VXkhrB51tSEJNZR/dJZad6+ke1mioW8YGw3BRGELjYS27BO+MiZH/CqhKgevv+Y94AA5Ss+d1dIOpZU3GdWZqUBNUBqsVjwx5vOIGRxuTc1wELafUOcSgJQxnG59B/LnCkdcSYQSvbdW6k/dNjots9OBArA6JHmoCii+PM9lLSqNDTzCvdkjVBL5Ttj8ljkxkEPLehTQmHetFWlP/cqxsZCPtWE+rQ3zLlbc0z88dqD1c2ChrZ8zhsDh2PMyWwujVXQLBUx6nkuG0c3jWA+/HaK7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4848.namprd11.prod.outlook.com (2603:10b6:a03:2af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 20:57:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 20:57:21 +0000
Date: Thu, 6 Mar 2025 12:57:19 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v4 11/14] cxl/region: Add a dev_warn() on registration
 failure
Message-ID: <67ca0c2fc9f6_1a7729461@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-12-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-12-rrichter@amd.com>
X-ClientProxiedBy: MW2PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:907:1::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: 49933dab-39b2-4f88-fcf6-08dd5cf17d23
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XypQCs1VsoHoxxPd8UUrPyEoPnV7n3FemWylZt10+/bfe4p5dXL5TJlQSUyN?=
 =?us-ascii?Q?jAqVXKT4HzHGcCB+ZvDWH6KDdRi7cIrLEH7QbyVvdV7dJ1r7foREzPC5+Cml?=
 =?us-ascii?Q?GDxd9i2/J00EW5ILXKXnnYga7NUXjgZ7rzJy4x8bSPYiYah5fyP5nkVP4rmG?=
 =?us-ascii?Q?/Flu80nsBp13BCE8HKwqxRZABtJiiJOAm7QJS0doEFR6NpbogRTLkR0WhUeg?=
 =?us-ascii?Q?DyuCC3ViVi6jGLfKtiUDbDtrtrYfrNZt6NtgIEeqxKGqeqw9919yF6MhUT9d?=
 =?us-ascii?Q?crDOI532M+PDhxbn0Hv7GlJXKiTbfkxH9yq6SLtfU1Q4zUVNJMujnV0jqciJ?=
 =?us-ascii?Q?Y9lJFraKfgqzWTcPiad8MpuTRNigMKYxyT8lyPFlRLXQRErSNv6kCa3hLb7d?=
 =?us-ascii?Q?7fnUhX7pmy2EpC0xrP7Sr87LSdIjyRwprnvVbT7bFGWIJaZbBjjI0wzLPDDo?=
 =?us-ascii?Q?yqItEM/PUM/M84y37yklWxkQzrxQ7sW61mBmnWoVKNXYhk8YbpbwRs470sAq?=
 =?us-ascii?Q?vUnFmf6HQNuWxuNGgflnJX2mk0Nf+UpSMPG3oBl1goLMbOjvDdhZ/3GbH+ua?=
 =?us-ascii?Q?yvRXkcywzjCz32f7eONzBDhjhAeQQkFexDMZpX6axr1ji9O/f+3WQo+jcdqG?=
 =?us-ascii?Q?cLtJpA6A4g0lmPnux0f9gpEi1qcdn/A8UsfTDyNsqm1SVTvkw58K3OE3igGI?=
 =?us-ascii?Q?068Vnd9vixTyFZfckJYLP6qeGJJCNoWHngLWgdKRfvS3J6xfcpb5TeeME1cq?=
 =?us-ascii?Q?F813vQ1WFaXPvUKdag9MKDr8kXgcbgjxSjUegECWXH5WlsrfkDlx71rbWQ9u?=
 =?us-ascii?Q?uxIxsP7ng8QLWTq0k4igykUYCevbuTYwzNMA281ljfeuDiEhehQ+Km2ybKnR?=
 =?us-ascii?Q?uWe+5PiBQt8TQhP/WC1c54mVMO6QbcdJcHnbG4PnEuRXaIttvQ6I72r5dhFk?=
 =?us-ascii?Q?ZYUK463oIUc0xgQTGUKPMwLURMoN7ZiEbok33BGQKOhMclw9AVWieUma1PG9?=
 =?us-ascii?Q?EGHaaQXGRfocu5CBRo7XvaktmNhyrLK2ekxF/lLEde+reHqfqlPsB6uoS3du?=
 =?us-ascii?Q?ZGiae0G9b9if364OChq0/YjzL1Mi1HEYjF8eg02cSKHMQVGpGEjJYBuAiQZc?=
 =?us-ascii?Q?e0KkYsp8e0N55/Y0IgXz7Om/Z9v2wYqJUL6TdYw++GGwXGINxOP32ld1yg3M?=
 =?us-ascii?Q?IxfTq8MfwmGpSfEUIfusjQqMDb5GilSXJgz9QLTvQYYO2jgJpjvRJeBbqm9f?=
 =?us-ascii?Q?AeSgNnGVsIBehBbApl5t4/BfrBudt//pMdASBsqPIsY6zidXcah3ChqqPdqG?=
 =?us-ascii?Q?ALF6yYRsjvs1YR8cCX+obgCMohX/iMS9Z6in5swCpGT30f6xu3SMe47Nu9hR?=
 =?us-ascii?Q?8gMKuhbHU21cbmMJTPBVM+eqIkpI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VNGibJOju4Ukf7KBv0tjGuBphobAyq+B442AN/6JdB5nVHe6TN0SLTxL99Tk?=
 =?us-ascii?Q?pSG2OmJmynw0O07Oh4LED+FIrdbOsFn0/+3DXT7XkokRRvWLVu5m6XOSuU0Y?=
 =?us-ascii?Q?CwlvDhh5j2nNcwzdOphmUSMPruF343uj+OaNpn+yLOCPZnzWzkiHWYnmeXaa?=
 =?us-ascii?Q?RSC12Ktpkey/AS85jwzeVMUB3DXXTDMFBYWsLoKMKrG5PSoMdOHXCFHcH/Ud?=
 =?us-ascii?Q?9SoWdzsm5zKoCZtCZFZkQPgV4+D+5q3t7ovUnFIV4cd9J4tyoPypekTAWvQz?=
 =?us-ascii?Q?xMvxlXaBZvG9zOBrxCywvMKhWJ+wY0BnKatwyW9NXVKcD0k0cAa080qmUZVE?=
 =?us-ascii?Q?VherIje8fyPvYxyK+VKAVyfvDbt+HNSVxJ7BqNJ9oTv/ohptWWq4SefXO8vO?=
 =?us-ascii?Q?lTrkxkuUDm+GARmqofYrfZxR9cyVm2qZ5hftrlU4Ab5B5jK2uguvXVP5BaqC?=
 =?us-ascii?Q?sy1j+MlO/60/aB83nnHaeLRmUZR7eTHWwp8Ng6lZTtFfWc+ZKZYAvGpyI2Bx?=
 =?us-ascii?Q?87Kq09sGyIRDqZUmwtWOI8z4586rbZGUDyRdwrWVED/3eo9ZllycLghT3hIN?=
 =?us-ascii?Q?Z26HSIKrfo2l7tYeYUNjISL4N1Cf5Ji2H6mnOSI9ozNlR5xy5hqEAj5kMWpI?=
 =?us-ascii?Q?LtNlLCfcxqgTBUD017h6bFgWB9kCh4znibxgkNyaqRVas+yPJiO6qiOXXZfJ?=
 =?us-ascii?Q?jrLu0nyu8kWSU7Mir0AicS2LNyoU8A071jGVEpAggW0H3TgSwWzk/aRZad4e?=
 =?us-ascii?Q?T16xWrJ57J45NPVIS/0EyQecuTawXzcB/vbWG3Nlx2zLot8qS21MVVumXV+5?=
 =?us-ascii?Q?SnJoBpSiN/lD9ju3YUstf3KRI2lwWvW+QTwAngMXlKWdHGa7HAeXCF4ChMJe?=
 =?us-ascii?Q?wuyjbTh0aBne/oyLzSakFsjyIiiyM6z2vUtYCIlSoGT4GYIFn0vwTmxtA14D?=
 =?us-ascii?Q?i7znRr6zj2Wy7LtHuvcirULA817XQCzn14QQPVb6AVoCknDWnP4CxLmwXCUA?=
 =?us-ascii?Q?idZN1+GvEiSNEsT+eZvV4UdytHrTzmvANp/C6Yy/caKmGYJsHdIUiDGBjX/k?=
 =?us-ascii?Q?2SPfIKCjT3g2n+UWOJ7A658+oJ5rnn/u2GkrN9gSUvOCoaJ8LeAuJDYliImb?=
 =?us-ascii?Q?asmkv2JK5BOMXSbl1yHPd+28+jCp7TQkRm3DWP31II3R3iL8wdCGvIptjuA9?=
 =?us-ascii?Q?EjZjKa+JUXFplvcRkvBsnFtUFJs29frogbNYEI1gNMNEvwKHERObx+yLsmtj?=
 =?us-ascii?Q?OQ1q5iT8oePBYbpfH3XYR2Q3zLy5N8uQ6fFSyLmm0pIb7CDzCe1l+uUF5y4U?=
 =?us-ascii?Q?3sp1PksgMCWagiOjDrYpRRgbmlgM3GUg0P8TeF1T4i2lvwY3qXc2rq90/mG+?=
 =?us-ascii?Q?jJtykbtcysWFJP7Ps1U5eamps7/mWlipK+p33I4WN/mZinUUPZyOyopB89lU?=
 =?us-ascii?Q?IK+grlmqJ2Sv34Y/16tvsPMvVikhcZTpkch6z/C9TO+jYM0cMW3jmddamo6R?=
 =?us-ascii?Q?Y2dBYxThfL89Hymgt9k2Q2f4G5VeXXuJcF9Rk8cV9pyhTiAoDz9A+8Bic++e?=
 =?us-ascii?Q?8OLqVdvRq4zLuPOkr+FZL4ZuAzIst/SH/nAH8SDg90QM1d6mgyQa8D93GqVc?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49933dab-39b2-4f88-fcf6-08dd5cf17d23
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:57:21.4735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55lPY6Iip4VYKoJkEm7442UsQYJyosVUK+cy4ZXmsaWvcV/nULbZdGSwuZ5wl88pZy2fIoHtCQbdIp2V/VHV+lGjvK5n+s/pwLw0G2zF2ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4848
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Esp. in complex system configurations with multiple endpoints and
> interleaving setups it is hard to detect region setup failures as its
> registration may silently fail. Add messages to show registration
> failures.
> 
> Example log message:
> 
>   cxl region5: region sort successful
>   cxl region5: mem0:endpoint5 decoder5.0 add: mem0:decoder5.0 @ 0 next: none nr_eps: 1 nr_targets: 1
>   cxl_port endpoint5: decoder5.0: range: 0x22350000000-0x2634fffffff iw: 1 ig: 256
>   cxl region5: pci0000:e0:port1 decoder1.2 add: mem0:decoder5.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
>   cxl region5: pci0000:e0:port1 iw: 1 ig: 256
>   cxl region5: pci0000:e0:port1: decoder1.2 expected 0000:e0:01.2 at 0
>   cxl endpoint5: failed to attach decoder5.0 to region5: -6
>   cxl_port endpoint5: probe: 0
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
