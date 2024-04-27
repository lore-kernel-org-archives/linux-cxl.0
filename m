Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0156723D7
	for <linux-cxl@vger.kernel.org>; Sat, 27 Apr 2024 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176616; cv=fail; b=eYQ6fqiFWtaGnLYWf1Nb+yE/4Tb8rKy93H5qwMODa2uTfDco+tPWTgYEqzhztBNeZYyUJh4V4vz0Ja6ydLslLoeZDshh/4L0VxkKYGs8uYp4ulJbQk9MVQltwZ0rkPH994A+u9V2NmXaVYXfQSAeaz9UAktap6vp9XQSK13wa/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176616; c=relaxed/simple;
	bh=STwmQcN0PaZhAerk0ZjXektD5DjlGBjL9fUbIMkjfe8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OgPbhM1e/2mOqWaiSDNQmyOtH8YoQs6BNdsnGncuK5uoCTV2NaOuiD87+iuzcr4yxcnVmdSolfqMZdzlH93riN8ZLCMThSnrg6pj7yYU9I2jp0FaXqd1qSahLgFeO/3MzZBaUNGUlChDuL6GovC+CyREmtDMMe1t15m2M6CS3sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdQqoZbb; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdQqoZbb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714176614; x=1745712614;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=STwmQcN0PaZhAerk0ZjXektD5DjlGBjL9fUbIMkjfe8=;
  b=hdQqoZbbHt2jaIBuWBhdezePuYtz8FjcPZT2dUyAoFoYBwysiFSdWBPF
   oroE+N0i8NAjBYSXatOBdu2p1Hk22sv2XGBvkDWDvahp6h3541kYObbsi
   RWiJRiSg1Qpq1w9id5Hkyy9t+bAxvRGIbNzksWaBDiuiTvC8E6yJXf6dP
   AVOItViwmxycKNWl8AzH1T/2mi4QmVkyb32RifhUsJvHbAbVut5BnHgM+
   1I7a06hvJ79Xr8WzVWsfKY4tXDxzoeC2zP7ZuJqZeMAkdSz9QCeJS2JUD
   +aL4rzNlY9vq2ZFk0UKCUCcBQF1N/HUumqZAH+vogZd9VP950vBmNfXPV
   A==;
X-CSE-ConnectionGUID: +Ba+4ZodQwGgijfT6F2y9w==
X-CSE-MsgGUID: v7qfX7b7TNivgmHMdZ56MA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9776751"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="9776751"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 17:10:13 -0700
X-CSE-ConnectionGUID: dPtXDbCnQIe9VxoYxEgYSg==
X-CSE-MsgGUID: /3tcJmiiTe+I0imHBLGYYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="48795622"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 17:10:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 17:10:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 17:10:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 17:10:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 17:10:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhUxACvQbYyMNThwZ9JewPl6AJ+ci5XLnCwaojIPdJIn4XKkbz89fBUKZYZWGCXzWZsOk5LZX2IS2rUlJJ9grsHOTCCYdjKhg/yn4mhsrjtuFDKOqbAn3lbzrRoYv8Mzu4/y2II9s0VmDEV3ce0IyWKNgJJBrMF/21DQ4pn0vpgA9A84nfLIFd3XHWgqDTCxGkaUS2I3hbeoy+OyLbkgh2mbBKDADZbbqu5lANNPtuc8sDVpViozBIcB2EoexUI0xVKauZDN21eWKtCqAlKF76g3Vbhb8e/qnqPZRrVGKKbV7PrP64dwmRDePiJEmwJsMATmJdRqL/cJ6Tjn/Xn65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PS0FD3PC0bH6H5OXqONjlWt3GSL1Qz3xXmrgVmyI9M4=;
 b=hFyy8Mpjpujn/XTqOEMfr2E3CO7f8qF1fW552SBRPqQSUHrkhOjb0NUujPRPoU4S4RoSvxHz9HwG4whKLNMrbraUv3+5TmtqFNxH3Wq0N6d7WsNfuFVAjcF8GixYiZhMQkQRs6Db5c36ocIIMQ7FQr2tdXi4469CadTYWKACDj053EU1NDBuntGcQLtpzRzkBeMhXQ7vH5UucV47EIxEKuNpNeo2/FGCBF+Wyk3gb/eB46zmG90mYkF9MolaetXb/rkVd49miDMHEfb+v0xCeG/7bcOeOYFnVmL9ddL2N7s2IebMK8vKP1JmAxZkF16uOinxWHwWihiJ1btqZQEMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6525.namprd11.prod.outlook.com (2603:10b6:8:8c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Sat, 27 Apr
 2024 00:10:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Sat, 27 Apr 2024
 00:10:10 +0000
Date: Fri, 26 Apr 2024 17:10:07 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH] cxl: Fix cxl_endpoint_get_perf_coordinate() support for
 RCH
Message-ID: <662c425f15f73_b6e0294dd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240426224913.1027420-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240426224913.1027420-1-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0293.namprd04.prod.outlook.com
 (2603:10b6:303:89::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 632abbfb-1b4d-4605-d065-08dc664e66c0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iid6capD9AMQicQKBH+gxC5XjB465U3SUNmIkLNanZYyAbawUbIMNvCxhtAL?=
 =?us-ascii?Q?CP4megyc1Pu74B2JLN8I7er+++u266LHGQewgWQWsuQnmB0n9ClRY+Sso9Gw?=
 =?us-ascii?Q?qq2dcTXDznBLAR8RWY9E7QJ+YgSjdrcknbCqVR8DvFsWAUCUPqVjJKW16v6T?=
 =?us-ascii?Q?lNBxAKz0PzHj8pWgTGUklHHyMQla2YFUsX46Ysloa0u4Mz/8BUkZ6S+FQDfJ?=
 =?us-ascii?Q?Re1tiM3Ilvvp3Hm0nex83aSGtkWdtLcCt1I6+I2xVM/B0bNdNM0srbatJSQu?=
 =?us-ascii?Q?mvmmsQbF2Um48JPhpkUbYVI0FbuNbCQkvrI9UTXexEzhm3h0piPOi6+3fMzR?=
 =?us-ascii?Q?L4IIV+TX/amVfQmuxtMeG+7JKCEWSM3mQwGwKPxkpU8LlGQ8imOn6XlP+KB7?=
 =?us-ascii?Q?R2pJB4O1fCDApBkxwhgqHNCAXr0vWWYbi0QI5xPPxYt1pKpw82PyWKRrL5uj?=
 =?us-ascii?Q?t3pBVDhqjIzDtdt427r+lftUinDHl9cIV9mR4WAf0CdqSBwAK9Y5QG6oDVCD?=
 =?us-ascii?Q?2D3+K+ingjBVhLRRPQO/ysonoshxdMOG2RriPVVIrryyaAVvd7y/lbva7efR?=
 =?us-ascii?Q?yEUx3fWIlNwgh0i3kQU5/QUfv04eawJE4x18eJpGuN0kQQ+306WvUfn/dKCD?=
 =?us-ascii?Q?MK+bG8wCqn+fBJFf7/1Oo9wGkZM4dDPHeEGRuwAguSLUCULT0+1Rg9GpV5Ov?=
 =?us-ascii?Q?jLmNNYiQO0v4+uGPONXGdzqkVV11l2T94KobTMYWsUxGPpNtShob6HlZy8Of?=
 =?us-ascii?Q?h7HvZqno2BVkQ3AMMk/fZZh072IktedvjvyPiUr1MLqEfIWCL24YxXUsvt9N?=
 =?us-ascii?Q?vSCi3intp/5WC2Rl64CJ3iO5mjSa5fXuqzThDrbxYXgWU1rE4xv0r3nZnjjZ?=
 =?us-ascii?Q?sRVKLFaynwBKsemg9MxD/SuFtMFO97cISOjYsHKT8XXZya4mhjmTj1CoDUvb?=
 =?us-ascii?Q?7HRixR1zdeiyqOZ2q8wzhmZ/qW9ha21bL/jmaQtLXg4Xxa9FaMs25d3IqM5n?=
 =?us-ascii?Q?txPMUlVEwT570Pd6kmlU1kxhdXxA+57DiRuGPM1+7Nlh762qg+iqzKsszXA3?=
 =?us-ascii?Q?8QcaawfcGL7lokgR89jbtiM5PBmdSDyYwUV5pv3zH+XFFEOGUXM9mpSbKAdm?=
 =?us-ascii?Q?ByonMSFoOmlJToRhk7nX0d+ZkLBMpL/0k5BFDCaqoemOtJj+MMnwZCpgKgOP?=
 =?us-ascii?Q?T3IYQ7MAl2Adn99tju604BR6p4XnLHHMhn9cIHODQcceK6N1OwAwlasdoks?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o9EYq7ELdzDabYAjVXQQcFBYe0pBZTSlKQ18M1vmNFCap6vNfV+b3Kjc8dqL?=
 =?us-ascii?Q?mrdcF9fac7/Tkg1KiJRs1Ey9RXfWMqK7NWgKpSQRFe2/JJRB0mABPhW0UPSI?=
 =?us-ascii?Q?uutHc/iUD6c8cvHuDc4LfFkOsUh3EZ/IrUT1l+3RH9V/thAAnZFAAG0yMnnj?=
 =?us-ascii?Q?R3VeCCfzW4nHaJYoisfJLEHp6AQpiz/dTsOYWbGd3sRmtkcgktR0w4axxQ2b?=
 =?us-ascii?Q?w+FUPoyKKNfVaxvhWUl4go2S6aT9gpBmHY4V1KR5tyyjB1BPWIJiQ1uLK3lT?=
 =?us-ascii?Q?inhTJTx+ZDR/uXd5zdWDQr9zq5dmZIFO0yIYhQsO7+1K0/xAUHcQsZE/66gO?=
 =?us-ascii?Q?zkZuIRuHYKS1PxoNFdqyfv+ADNtgYlIJOO4xeUxe4L0PEiUMBtrhAjBjQwf1?=
 =?us-ascii?Q?5TAgDt/Pzw+Au49dYIE4Lm5Rjnh0ufxV+9pBINMbFZMMpsFj10JZiyMXsyND?=
 =?us-ascii?Q?JFTaE/ZmLZDzXyFXGofOW5xZ/Qb80xpn8XHQTMxU+qgi+pG9PSBWUUSfis7J?=
 =?us-ascii?Q?kSoOkCTj+61neIPHCAm6+yHICAxjbUQ5+hI+1nWb4OuCNf8hZqThtPX4OB/8?=
 =?us-ascii?Q?nXF9ICDRJIj3jO7T17xlND/d38bd3TjHVq4OClokGYL0q9SPcp2F5izOZNcv?=
 =?us-ascii?Q?uZ8JTpZam013V5EX8C5PzmrILUzIwlwWpQKTeAWaUgaE6GgZRIBKFuzYmKWd?=
 =?us-ascii?Q?tH6/BvApWT678Ih87WU31okLJpeVbOcbM0GxHpWjdPPPDC6TASuDSig7tKhi?=
 =?us-ascii?Q?t1F/WLao8UeHOB0cUNYETY9uT/ayY/bhERUnu584MYfd+BHE9bL3fFpGevCh?=
 =?us-ascii?Q?xv57xH+FhL158zRFeyltZXd7TQf85GH++hEOKGVy0HUjizgss750Fs9ZBFoX?=
 =?us-ascii?Q?4bMnLejmjeiwhS3kPWAfOVe62v8wu9xkeNY9XA2B5hPna8OV5jG9e4whPRVS?=
 =?us-ascii?Q?QP8uOQ9r5NK8u8IRqdUyNKm3MuoniR+Jcf3danZpibXwPQrcFOdGJFgY6pb+?=
 =?us-ascii?Q?G+/RjL2x4EJOWCZz+xJP3rpFn74k/js87a1a9Fxhw/mWwSd56MayrGpPvlYe?=
 =?us-ascii?Q?6DSSWd6R/lREjJjx+RwQshOCV+PrEt3SP7FGd6daguCk7gUPIIbWgmdjNA4E?=
 =?us-ascii?Q?VwyS20Uf+ph8KsBZTXnQqhSUCdxBP51E+u3+r3x0ER1rHCMkOHkj0NeDRAjf?=
 =?us-ascii?Q?1MaS+8PZtRwhXXvq0Yft63JrwzBiNN3YgVgXENhDDXpqXTNfmweR8Pw+Bz1m?=
 =?us-ascii?Q?RAt7wUov2O56UnUX5qldW1u30UJJCPok10/94q4o4oNHIDGUqpG7aq7lOu9m?=
 =?us-ascii?Q?2kmKL6fjeKdP7HI9jTafhnZh0m7EJ0aQkHjKWTFzdb4ewsxnT7ExIqV+4P/P?=
 =?us-ascii?Q?C/2bkjg+kQ0RAMJY56J05pEYnp5NxLHTy++QQA4ktHaTOUfIb/pLUdnvxadm?=
 =?us-ascii?Q?rQnKaKolBZslA6tyVaRYuauspZBOeIlgG8kpHitEhM8TZniegOhgaV/R0NSa?=
 =?us-ascii?Q?ie22k2vPLShQlsA2yh8XTPMSsQ8wb3ah9tZM3H3fJS/lbnaChcPjN815DhZa?=
 =?us-ascii?Q?0geSUe8SZtfjZjrc1WVhWxhPYLvdQUgw0LcjfRmprJ22spwfbVzM/kTPKmmv?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 632abbfb-1b4d-4605-d065-08dc664e66c0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 00:10:09.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5MJ1P/d4Tcwzo3Z0kTm5PUC2kAT7PojeY1ZxP4V0+tiIHEIUwHZD3nuh6Fc7tz6owSTVmghvzy29S0vYSHuft9Kzz/lMTtpeRfIpvYwKsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6525
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Robert reported the following when booting a CXL host with Restricted CXL
> Host (RCH) topology:
>  [   39.815379] cxl_acpi ACPI0017:00: not a cxl_port device
>  [   39.827123] WARNING: CPU: 46 PID: 1754 at drivers/cxl/core/port.c:592 to_cxl_port+0x56/0x70 [cxl_core]
> 
> ... plus some related subsequent NULL pointer dereference:
> 
>  [   40.718708] BUG: kernel NULL pointer dereference, address: 00000000000002d8
> 
> The iterator to walk the PCIe path did not account for RCH topology.
> However RCH does not support hotplug and the memory exported by the
> Restricted CXL Device (RCD) should be covered by HMAT and therefore no
> access_coordinate is needed. Add check to see if the endpoint device is
> RCD and skip calculation.
> 
> Also add a call to cxl_endpoint_get_perf_coordinates() in cxl_test in order
> to exercise the topology iterator. The dev_is_pci() check added is to help
> with this test and should be harmless for normal operation.
> 
> Reported-by: Robert Richter <rrichter@amd.com>
> Closes: https://lore.kernel.org/all/Ziv8GfSMSbvlBB0h@rric.localdomain/
> Fixes: 592780b8391f ("cxl: Fix retrieving of access_coordinates in PCIe path")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
> Hi Robert,
> Can you please try this patch and see if it addresses the issue you saw
> on your RCH platform? Thanks!

Definitely wait for that test result, but as for the patch and the
approach it looks good to me. It matches other RCH-topology-walk skips
like the one in devm_cxl_enumerate_ports().

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Now, that said, if someone can think of why the driver needs to do
dynamic performance enumeration for RCH (i.e. a platform BIOS does not
populate HMAT), they should speak up now.
