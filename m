Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B8A2836A5
	for <linux-cxl@vger.kernel.org>; Thu, 10 Apr 2025 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744286403; cv=fail; b=dvx4BwV5jypq/Eu5xIOeBZujEM42nIm/zm3hne2zhW2SgzaaWOoPFU1iIlm/qMfn9a9pHe9+2cSt+ttYYMyMpxHJcBoHFvMKQ1xhdxMIyk9HKufR3Ij3NYdxyqls2+3dQwRSYYkBTAVkRMRNgbtZn5ArhDvqrvHpkve9FnC5m6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744286403; c=relaxed/simple;
	bh=jVlJhdFHQd0vS502rzzA7Rfx3lNdlBU37jzh5nmE0V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uzinSIEl44n3pGJWi9qvph4oGvpH7vw5+sf5/Gkw83xXN3R0WOZvL1BtcD+sHqvkweLz8JWkWev1xEVCNMlsdSRDVnhw5QLByZMDDYW2H14WjcEsNEZWaOW66w58z1Ix/5+gscjmjuyWtpN3phYhhT23ddGAs2Tn+LfcANFmFN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qZ1H2Yfd; arc=fail smtp.client-ip=40.107.100.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qZ1H2Yfd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nk9MzO1cgpOg//fP/TpFF81826TiufQNSgxjFIfZf0us0I/A5vssxuOQA0TZ6JBeUQ80us5ALkfF5/8bm2aqkTYl4HsGa+hMGCbUy1kzj3kv4aaYBUp8jY3EpLPvi2hbJO0g7XpGmkfMspoPVJDQz5FQHwjuYedkDzIwWwhUO1GFz3kZzDsDRTCkiOJNIWWNvATZ8uJh5qFHwPqEXx3093VdqD/AqVWzFKA/j957PbmcBGlS3O8Cd0+kV2llAHGSm5ut7tvvqnbfUDt/ht2CrTv6jOttk/7jwqGM88O5fguqTl1ojFkNb4sHghUouJ+BO2fJzDLdCBUh+f7VZqCVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djNbO8G3KeWaH2TuLKoR1gwPu3clpRuvOk6kHpHVvzM=;
 b=azZteJHZpAzGYOTjo6hHiTIUCBQqn355O3QPbHJKhGiWjMxkUCtgblBFqtNP26IJQKMBUPBfw8Xe2xOfQms9EIJmCaL8sVHjUFKQkfzsM9Ou2aogvMqZ3fS1nZDqzLJJe9NxEjWhUGAFIOhOIi18AB56mHU2j5xdJ+TdpeA9bRxwSyTW2o3tLZeOpTIs7kCh5+sOVF8opEaoM01hK0biviLvN83HZ5PgCIm9erdwMltxXiwH3rggNy6Ss0PDdjELsshOyfUdFmW8LF7e+6pXrLGT+mbj6OGNJR3WNLfJo6yIK2eLFbIHz4za5Aq5+RFtVrfC6qfkKppDp6hYPYM5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djNbO8G3KeWaH2TuLKoR1gwPu3clpRuvOk6kHpHVvzM=;
 b=qZ1H2Yfdu1IMrkSkqtzEQI+2Mem5G/oY0M+siKhp/13qjzGHz7HuitAaU0e7EgzIaN1Ukt7a87vPBtfT58SaU2LE38KwpRoKg3Op0jHx5H6hKeIlwilByGVe2QQ9Q8mc7Ldw9h0AwyUsRGR64DhIcSjF1MkwKheqOKIBEvGU5bf8jJk7WLoyO9TmhTo0sO3BMn28PtAwWzRDbKqVlX9gPQ3rU4xWqctJo+MEeMdNDV1C7E1AUHyWrOWjq5T+7jVkmvncRO5jV+IbIXAusW3FtJ/YBDaCEfYQqiXRJ5oCA0NcEooxK3rgdF10BQdD+luP16nR0wfYfZ4VqdvVZWDHrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6383.namprd12.prod.outlook.com (2603:10b6:930:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 11:59:58 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Thu, 10 Apr 2025
 11:59:57 +0000
Date: Thu, 10 Apr 2025 08:59:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [tnguy-net-queue:dev-queue 2/12]
 include/linux/build_bug.h:78:41: error: static assertion failed:
 "sizeof(__uapi_uuid_t) == sizeof(uuid_t) && __alignof__(__uapi_uuid_t) ==
 __alignof__(uuid_t)"
Message-ID: <20250410115956.GQ1778492@nvidia.com>
References: <202504050434.Eb4vugh5-lkp@intel.com>
 <67f72679bb038_2ce629469@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f72679bb038_2ce629469@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: MN2PR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:208:23d::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: e08f8bec-bcf7-4fa2-a7af-08dd782736d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wCNCvi1qs3jwH/C7/783YY3oCAQsJ8whvHCgL8YJyn4YIku8d3ijUxu2V4Et?=
 =?us-ascii?Q?Bxq5rsfXhw3Y3/vQAJ7rh8k89/3DQYMMdvDAv/P1exwgR7nozm4S/abT03pt?=
 =?us-ascii?Q?qWPro+rrIdn486BOyxbi7nlzBID9mdo2p86LkgwLf/L+r3xHzLt69xx3ZwI4?=
 =?us-ascii?Q?FsG+UHylZkB4/BJFzWzQk2MwhwLeApwE1BfI1H3arx7fb0EUpDBZwfNtY4Iz?=
 =?us-ascii?Q?Jk8Wsa2F52mc1ocSlN0NeNaxyT/rQgYnsH/DkfntBVAIbBNlQP2JT7jRr+cS?=
 =?us-ascii?Q?/rUbHjHh0gb3oX3RpWthWSz1TWFjrqgkGIY+elx6uhHv0IbmOT7DovRya5+v?=
 =?us-ascii?Q?fQSGBAAnl5XOQmw0314hedh8D1R8zh9ZRjTXKAheScz1CzIQthPsHuMagPID?=
 =?us-ascii?Q?SOJyICSLRoMHtw+0RVn39QuUGcQ7DHFB+zl0eL8NmKOLyc9h+hFcLd+KEM1C?=
 =?us-ascii?Q?hDqtDTBF5s71duekR62B897KvWNlLECj1hulu2/jr4EkCSZK0conueZLn315?=
 =?us-ascii?Q?ItvhZjC5daoA98sNTLnAgCkoKo9v+17nWq6Ckb+di1WfiZhBnwKxVaJSIEVA?=
 =?us-ascii?Q?FzkeCzUQv96Dl6f9M+r5NK2HWF9q7OxbhUMZ8WvctYi+dSGsfHH+9rtN+xe7?=
 =?us-ascii?Q?RvK3vsMPA3r0KBNa0Ca/R4CpZXtfiUrQlS0C+FwH64f9oLwOoJ/ELxhurf/6?=
 =?us-ascii?Q?v56WUpGO3Mz1fsNX5DZFJIP2whvX45VFW0knJ65IXQc7dMcjYmn8zcLvhb+E?=
 =?us-ascii?Q?VbYHEK/pGH0Etm8G7YCXKVFyZxNqbFcV9AmJDnFo3x617dNBUfVhDalETxQO?=
 =?us-ascii?Q?9PH6O4m4Z0IllF6oBxHAKvGxXuJCq1KT9PMSjD2LqfiFnDCf6Ycr8m796d/7?=
 =?us-ascii?Q?g4uMmjuvf2LWgnI3552C7kotpaPRsl7pNAItfu06xiBurfA1m0Y8dhSYGSRC?=
 =?us-ascii?Q?/wCF5Y6xDjQ+i8lGcmOkV/a7C7L3ZUfasN3dGuoeFwHKP4KLcaSin7bhQ/jf?=
 =?us-ascii?Q?Yyg1KrMaa4mR8ptURi1k/VIaq57U++dvXFIcbg0eEVKyHib4bXtzSHseZyk7?=
 =?us-ascii?Q?uWzfoTtfApp/7BiVVTOwK8SY6pO8W5sZ3l7FMZZBfu2BbzJ1OWPq7UMpW26N?=
 =?us-ascii?Q?XMrfkUhR3E5gF7tIAxEpPXy6XBZp4fXgHPCkhg+CGmhmQIWvQniOyxGaxrpQ?=
 =?us-ascii?Q?PMgta+TxBE7MQiIp9l+Tz/pEMmuW3avq3ivezcBIeqimVp3JTzRw7+iheiqT?=
 =?us-ascii?Q?FXZs7NJtwXJr+ILjyFo8pm7GpSQHeIOOEXy+j7TkPn/7xujIbwJ6oejeXe/S?=
 =?us-ascii?Q?3A+w98P5E0wcEKU4+QxJTWYf5GC5QGCzuA/tWW2z3oH2FlfaIKSJdn0NcPBR?=
 =?us-ascii?Q?ucIKVgBXVLzU8M2pkNEB+B8uORZISq/Vrzh+jWPXEJBV7JYXl38kzexhdPDj?=
 =?us-ascii?Q?PyI+hRJ+KhY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hGRtBbsYLEnb6S2dylmqQejIwGRl+2HGA6TSdpwNvy+U4/rYGjFE3ztdHF5p?=
 =?us-ascii?Q?+zk7iVEZL1NZUZGmExjr6omHL1n0gq/DphcSN0Mw4ZNGmgMt5HlBY7oiBWuh?=
 =?us-ascii?Q?YUZ4fNtBpxrTQEhw/IW7leHaGokiGqHRcc2xZBI06VgyBu5QVUU05yPl/iYS?=
 =?us-ascii?Q?6Xq8y2Xs/WZb40LZCfix2efUPjwgx8t5KoZAGUxPeTlc8Y8laIjrWhqG6yRi?=
 =?us-ascii?Q?SHdkDrWH7gZxTL7npaOZZZpLUqEBXYOOC6LjkZy624Z03QqO48LXpy/Uq7BJ?=
 =?us-ascii?Q?WGpnqyMjibdK9epZZE3l+Z46hJd08WzZI0Lqb/afUh4CKBI9Z75OaT3KopLv?=
 =?us-ascii?Q?vLZzjBgxsw5WaE+2Va0bk02dqttbRYOvZBgVeObrnUfYH0enS51Ofp0LOA2T?=
 =?us-ascii?Q?Y9sk9AAvsHiK4KYJam85QOxd/HSKMVMsMChSOThYDKkPaR370ewmzr/WpVrB?=
 =?us-ascii?Q?5H3RamhK4MC31BBEhm2liWc+ZrX8+amsLp3HY4HNDZb8qBgjhdK/ntdTbcmC?=
 =?us-ascii?Q?Mn/U5fJurslq9dWS8UK4VjbuoQCS1RxoVc+L2aYzaoL+WC9TiNbs/i3lG78k?=
 =?us-ascii?Q?ybZ4UMYtQbJfMUHRbqif97QyEdvhy/QJ6Lgeyf857TYdRhl/qpfVxOwVOqsQ?=
 =?us-ascii?Q?EUgfsAp2qi3FlvUmSbbi0B1m2Ioc8sVnKVs7WJ42iB9UkYLxYWQR6TRXE6Zi?=
 =?us-ascii?Q?L7ntaSr1J1CG2LYaVT+6+rFkQWjXYtA2NWtGJB5RHjUP8DZd+FlL0AwLcp6+?=
 =?us-ascii?Q?Vbb+OJkjUB9djPs+wIU1L9cvzdgEiJQkvC4SN0z1aQIry52psVOUv4akr54o?=
 =?us-ascii?Q?gLFXXGUV8pn1ysKWgY91udE8wHlzSaIfH6VSiI3n6/Huudp/IYYhMj33xtXe?=
 =?us-ascii?Q?mwY/Ae3xZnMQx+gk5ozGp2CPp20IGGUG4Qygx4yIV3zK8mgjAAgClJSX/V1h?=
 =?us-ascii?Q?0bhdCD1wnr59DAye+1BpPIU4ssfMrpBPd1ecE7HzA4F5LJijJfbRYss1R1gN?=
 =?us-ascii?Q?FXcd2xhkAGntAtsi8JrQzNBvIaKhgKakUkisRbLmDnHohY3QSDjJiUzbMPVA?=
 =?us-ascii?Q?rtTa/f/Iea5IQZvDVWmcOVYXtyZG2HLq5cENsSJ021lorcDYh6zgWQIBijrv?=
 =?us-ascii?Q?VHzzCRmb2uqL5t4hh+m4RpLMsJfDPyMtdv5S6ENVuCJXxC4roDcw7FnjnIKc?=
 =?us-ascii?Q?Wo09cN/nnv2qanpsGkSvw7IUMGSrYonmf8ilS6mikyjdGtfI/AvMEUgmpxbI?=
 =?us-ascii?Q?pTPI1UmkxNHhy4th6p9+UBAQG7N4JKw4quI9C/J/cwzxSJu3BsclfYCsRH1I?=
 =?us-ascii?Q?w6VfcekB6HPFTq733m0AfBaLaP1MwRZ/XgjUOU7EgPz7JE+8D79zAc1cX4n5?=
 =?us-ascii?Q?QyY+rao1aFdd6f6Yrw8cMfsTXfgh0P665D6AE5ddIzHUoDkwRRbLBj/TfJ3h?=
 =?us-ascii?Q?GFgZ1dkX71h6XX9aWFLOzZtt0XX2a/DMqBM+xTtocDbPCwJ2kpD/QAPBS2Ki?=
 =?us-ascii?Q?HtuLxGimpuxRTDtWtLDg8sP6ai++ocuNTUjalasPULkfFbfV6dXgEOYhExJV?=
 =?us-ascii?Q?/qdsa19/a7rIIPkN9v/tFdhaxDLzD0JceC3OcBkP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08f8bec-bcf7-4fa2-a7af-08dd782736d6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 11:59:57.7449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFMjR0upzJYoZSnmx7DswsawZnHXYPBPt+X0U//3oaabG/KbNQc5mbD5DZAzgdb6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6383

On Wed, Apr 09, 2025 at 07:01:29PM -0700, Dan Williams wrote:

> diff --git a/include/uapi/cxl/features.h b/include/uapi/cxl/features.h
> index dd8874860cec..06a1ae3f3fd0 100644
> --- a/include/uapi/cxl/features.h
> +++ b/include/uapi/cxl/features.h
> @@ -14,7 +14,8 @@ typedef unsigned char __uapi_uuid_t[16];
>  #ifdef __KERNEL__
>  #include <linux/uuid.h>
>  static_assert(sizeof(__uapi_uuid_t) == sizeof(uuid_t) &&
> -	      __alignof__(__uapi_uuid_t) == __alignof__(uuid_t));
> +	      __alignof__(struct { __uapi_uuid_t uuid; }) ==
> +		      __alignof__(struct { uuid_t uuid; }));

Really? I'm surprised that the struct wrapper increases the
alignment..

Jason
