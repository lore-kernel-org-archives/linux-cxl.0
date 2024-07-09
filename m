Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E91B86C9;
	Tue,  9 Jul 2024 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720552763; cv=fail; b=kq9iRYFjgN3lmQRFXQ8ulki/KJLZP3HFxr95Zejh8uW3q/MBXEEuj3jnVbE7cdV5DTJVJSaRKZavLPd2OcrWmIMDAgTsEOwnOO6z/0WSsd/WwXqZajLGKOO9MYa6qBEqA4hq1JzpV1Z08mwHt9MT0+nWvvUqdQ+8t59BF73bYNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720552763; c=relaxed/simple;
	bh=QjZjhOJ/+N78UW4HDIHhkqc16VOE+MdMyTIMJEFGHE4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fy+U/P/HfLhzLVJ4FgZUEwGiT25A5m6PxbK4N/ByILzOvhFLbDabBUD+crTgEK5PaT4zA/lyZCsMwM1pi0iiV8cWzQ38rc0hnyiQ/Vaqz13qCImvs+sQf/c51IasFPDszwzFyN6f0Q5o80GVzRCZ05LmmF2EH5tkh26g7a76tkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/n224VY; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/n224VY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720552761; x=1752088761;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QjZjhOJ/+N78UW4HDIHhkqc16VOE+MdMyTIMJEFGHE4=;
  b=K/n224VYc2Fk2NgIy7rvo2lsCLyfKe3AAe/cl7pldq0LT1Iv5HdxDyJr
   jaV3ldi5OfD9newIUAGxgxj5vC2RMhXOpIzpT8Y1OJShHEDBnAD8LPP7/
   QVICkBiIZ/lXdxngu7VSZzJB3iPfgS761j/67liv9qZxfUNuqBrOdywMZ
   fcM+RfI/Zh6NmkCG2OP40kHwY+KjDGobaChaKz/Ll4AY+Zj/PDeOBXtJW
   OiszCr2NDrv8EhbhEGh5JtxbjEzJDt3ADBxNkA/2Tgw9vZ44E4CnsdhiP
   Tk+HiGUoQRqng7NUGHxC6KGykSP+r5qtIaqlzQCcX13b6qra05lF7L7CM
   A==;
X-CSE-ConnectionGUID: BmtpGQR/SgS+PvXkxPaVAw==
X-CSE-MsgGUID: W6FkOvsdQruTH8UubyRNJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17702227"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="17702227"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 12:19:20 -0700
X-CSE-ConnectionGUID: smlHoY11STe0+aEQS6uo4w==
X-CSE-MsgGUID: sWEZ20dDTV+z2Xx/ApkC4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="47871221"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 12:19:20 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 12:19:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 12:19:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 12:19:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuMHnWxjsPwk8pxIRzDBgEuRtdsfzRHGapcGEG+HwjiFRiQ3jYPhyAbOahx52aSPQLtK65cOkDOFV3vhcTh077NF8/N6twBCaJSz7VrA4Jg13wa3FStMJ7NOEf0qTkFOW9gZOCCkaU/DWSSyVWFwwH5WoEzpMeClutYlG03mfGRbMBFuGid4l0NSOfdxgLEqoWEqwenEcziPnIRG85TJ1sadx1T/Mr1Igiqyq346uJVwmvKtX+Gg9N+ZdgufLsKtJzl62O+3/r6klljuoImrhtO4sbIglNXxLCjUrHssf3JuS1Y8Z7XY25ulJFJcm57BwR5PvxROPiqi2fkYAHQ2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfEe5PjrDs8c3NeLN0Rxzsyd3KUbYTwOU/gOS0AqCM8=;
 b=jah/42dsUxVHE7+X6vOM12M/bJYdTLW3nKRPxQUKIGjXfueMnCBIF4rI7xYhB5Oa0HqxfcNnCl5reJHFnco5UjuodWtSxWDPjz34ZBXfjYDH2IUig2L0GoBkSeHGNELx741FrDVYU3+ThwX2oV5setcB0w5y0AWzNkcWwrofjVT22iGY4hgvJnDYc+tKS03ceadMi3CEuP9cSjb+RvW54aB9LGdjBk33nfkV7ixqESykiHIWTxBD7A5tBLkD1Gt0Z1uPLFDG+qOmkNlwskDJeUf730FFr+MhD4JkDwINDrOe0ddX8dZ8ZdQhAfx1u7Q7sjx781y8MDTE+kuAXHUfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6936.namprd11.prod.outlook.com (2603:10b6:303:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 19:19:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Tue, 9 Jul 2024
 19:19:09 +0000
Date: Tue, 9 Jul 2024 12:19:06 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, peng guo
	<engguopeng@buaa.edu.cn>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <wyguopeng@163.com>
Subject: Re: [PATCH v2] cxl/core: Fix the UUID of CXL vendor debug Log
 identifier
Message-ID: <668d8d2a96bfa_102cc29479@dwillia2-xfh.jf.intel.com.notmuch>
References: <045fb08e-6d18-4558-b7b2-b83c412307da@intel.com>
 <20240709141239.10737-1-engguopeng@buaa.edu.cn>
 <Zo2CjTCSnPmn6t8R@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zo2CjTCSnPmn6t8R@aschofie-mobl2>
X-ClientProxiedBy: MW4P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f8c67e-0f38-4efa-6d3e-08dca04c0201
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lSBC5BOGcn9gKgDHOdzguxU/byaY8UPzriM/tURG1BjvH+SYOhbjeu/ALgC5?=
 =?us-ascii?Q?juJx3H4a7WuDjyJB0Ei3TOhNCrhnR3TuUIAmnfik8KG+h0RD8TNYjyC0Hypd?=
 =?us-ascii?Q?Pe4PR2Szv81GH7TCiKvzNP3fSsQ19fmVqryzgxCvhE7VltrmoXIcNeBolOn+?=
 =?us-ascii?Q?WckR9kqe5JJkpxqFeHkj0icJUX0b2QCMdhDhYsJpMLw89T/EspBitj0kKIjr?=
 =?us-ascii?Q?0ogx50OgiWqAs423JcZfsQOFLcCFVOZEzx7Ih7RDra3oweMTJO19x2RyPB/R?=
 =?us-ascii?Q?cwf3EuxQ+dgVj4hULvlQPC3O0cK4w5XFSUw9UrRWtUmgu4tp0EsxpSaZavoj?=
 =?us-ascii?Q?oxaEOr+gPyvTCV1AlRfvMe0yHFjQ2QbIM3Wu97QPFNEoRqD+r0zRT+C0XzHa?=
 =?us-ascii?Q?F2hmwlQfTpjt9aw6NhSz5G7okPj6bIUdwq8SQ98cjP+1Q/S0ScqkX4pI7UPU?=
 =?us-ascii?Q?VGJeZGQx8YmPUwrnorO0LyC4M6K5AUYAuiplJrhUcXKL0gfgR/fHz3b+lS7h?=
 =?us-ascii?Q?3YK+ABflRzz2P+1Dq/7sSyfo4j9NiFAmsHtzwLQMiBAdyUQk2dtapv2xc2Uq?=
 =?us-ascii?Q?fozHe+T+2VXPOfZ4xqQKvqLcqEBXgJX5hq/bUgsqhp3Pukwajn/tx7USqYR3?=
 =?us-ascii?Q?xstBnUhocgUcvh1y+b45i+HOttGbEIQFuFBWQbFX5eEsSBMRgToH7cJWIYgB?=
 =?us-ascii?Q?z1hoKAvdjXluuMh1zKTaAzF5XnsCQahmkyYVBV7G/UtCCbrQKgBdT8/o4Pn4?=
 =?us-ascii?Q?OCeR60fnZ7sampUBwyAL0gZqhoyOJALbntQS3eQmAdBrtQYqMWBzVd9YO1Dt?=
 =?us-ascii?Q?Ry6944you1hqTzVUcsnz0GqTNZ6VFJP9qsX3Ylm+SxhcGGIS7QMx6qHl6Btk?=
 =?us-ascii?Q?fHZeFgwLBxlEUtnhE59DnOPMseYyJ/AN+KeJOXoEXeUWrslG3ti2vq1ichjt?=
 =?us-ascii?Q?oGGgoYCJo/9MQ2+QchSrtW+qk67ng86elBur2aMTX/fmB+yKChDBuVud4udF?=
 =?us-ascii?Q?GlAShhT65PZlvDMxPujtOxgZaq5USwnNNL1RnvFD1r61ctJ7u5HcjO2eOieW?=
 =?us-ascii?Q?ALfQ23g+0mGMzMzkUqWXkq/K5Fdmrqw0d2EVlt8Thk9R3zjF0hdSAgf5xfGL?=
 =?us-ascii?Q?bQx+iKUMfiIu/wUq+nJA+qbhWF8ItGc41106efHlRIqccelrr9FGvS34azU0?=
 =?us-ascii?Q?wUBVm7P1qyucnZ0n2SEnGctRKGH7A1P4D30wB8GpPb4UAilGvdO7Ytbt2NXP?=
 =?us-ascii?Q?WiGqF9p7NNCsvOAOENBjV2YNwgUldi3GcHXS4Fwaz4p0Cdk0Sd+ggJd1vJWv?=
 =?us-ascii?Q?GdQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0HFMQUP2kzsHdeAm0EYfYPTO6GWenqKYdFO8Cc9E/t0DEVEuUPqYtU4cvSuI?=
 =?us-ascii?Q?3lQTEQiF0j3gIcLCXjPJCyAvvEm9Vw6JogbLOkkrOXlMASWd5ubxQexaCRpQ?=
 =?us-ascii?Q?aQaf/Tmk/5BYh8dTBvvffFklq9KWNXqYjltzDQdoVkxsUbLrkxVirkohPWIp?=
 =?us-ascii?Q?38ontmsv4GsQy8dOsqPmUCFkB3qenNkBepTHH+nvT2KabP/HF7UpMcNqJvr2?=
 =?us-ascii?Q?q9vSxE4BVJCRmDEiPHCkYWaF3ORYU3UJu1JUv8NAkZzw6PHKTkX4mp2tZwrL?=
 =?us-ascii?Q?JCtphR/3yERuhLiqSEezvkpcVWx6U/nF4tr98w40dJnR8O0LxjuunkkN+EKX?=
 =?us-ascii?Q?5yXadQg0gO31ObcacVhXNXw9WyXhDB0wlTHYnsIgEoIwjpV6ao1+ol6RTjd/?=
 =?us-ascii?Q?mmCqeSOV2qBHRkmSMgnMkNoJDBYDlWo32pRmW9J/dk/2x0NksIgkk2PXLzsq?=
 =?us-ascii?Q?RNIYvIzz8fSYrG/SCXFlzzSobtlf8qQ8JUlYyOymnDmSWr8SuX79mrCFqAq2?=
 =?us-ascii?Q?DNHT9TgBtJRJQPCd1gVc9jjmzJThnh2wCvuNnZILRN16s2dbcIDcqi6zHFQv?=
 =?us-ascii?Q?0Rr3hEv76OUVFTr2u/Vd58oQuJJPn2c5rmQtosmqY8ehgTgnwBhHsfcAomDj?=
 =?us-ascii?Q?d3EmG589kBhGRqDZ7lBofe1+LPcsjBJ3aAuWVhW6bKvqCFnnqbJc38SxAY+n?=
 =?us-ascii?Q?CZnfr8or7VByJ1As9YzXtsXjDpsoplJYy151fHmsPefOb/uklL/bZZqqFFgz?=
 =?us-ascii?Q?YY3UMlxP2InRqvh6CBZMjUMM75oXLvfhXd1D6/TZYW4Dv5BNTP5yN0ElNOtD?=
 =?us-ascii?Q?1ARvTNZ9ipIm4aDQEyzLT2RGH0Im6R1AOvUIOhyfsztkrpO5U5Y47rMbsMd+?=
 =?us-ascii?Q?mqX6JrLYdhRHS1gu5wgh4ys3dxC+XhFBvixHr1slplLIQ7zM28dMFWmhVkjT?=
 =?us-ascii?Q?5tObLpFa2K3hWTi7TrRpSL4vHjA9tIfT8iqKG9NxyT0pS7tt/QJpARUOCiux?=
 =?us-ascii?Q?LgMx3ENfhindNUNxDRi9IVKc3+3179TjF1X+jPhoe6K43y90oMKgqxHewBU3?=
 =?us-ascii?Q?bBEt2sjzy9IxMHsVujr01gZSQhf/7wFjEgchQI/E6TrOKpVP/C+N7BAh5qfr?=
 =?us-ascii?Q?RdSeiomJ2NVp44IZSQvlQhUmdQz1d4gnuQlQ0SH+Kxq2af0oKY3CBUNSVCzM?=
 =?us-ascii?Q?tPP327UM6z8yWC/mARD8J4EmwMQnrYunH4aZYiOtI1N9YKhUtHDkleAdeaQ9?=
 =?us-ascii?Q?WicLt+R943WzvYGei1EDICt35mO6sFYaSn3Sr7RCmQUI/hchodKQLJ0gkdTU?=
 =?us-ascii?Q?dYOC/NKyenXUwMCbwLoEdGexte8yNRg5MhiKoiNQk/Lej/7DNGK1zvH3Ownb?=
 =?us-ascii?Q?8QIaVSw6FRuWdy8Nn1BjoCd1kOL6rH9ZTlrqYkmshQy6G8rny4CEnWpXbCYr?=
 =?us-ascii?Q?B91goefhIEQfTlKT0yo0FvsAjKtqdxN20lTaaaucsPGjMCBCKJxtnLgWCqmT?=
 =?us-ascii?Q?Du7QEzDqApmc7gpUxyUgiObGFvGPgIwjmvxuif2qWMMY6CAkSmEyKWmbAgFd?=
 =?us-ascii?Q?fylSrup4LUYknXuOrMWOvfmDdh0Kf9mLhRna0xPwSTgEuhDQRCvu+H+kYmoR?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f8c67e-0f38-4efa-6d3e-08dca04c0201
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 19:19:09.2505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lap11qComlbO4QzKxWygVBZ63mj0gMymCo1jC+VgjHmjnea0EQSvEHKjfLcqk3icjQHGP7SwX44menLltDQNvLiXyDzIWFvCjpcsztBwvhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6936
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Tue, Jul 09, 2024 at 10:12:39PM +0800, peng guo wrote:
> > Fix the definition value of DEFINE_CXL_VENDOR_DEBUG_UUID to match the
> > CXL r3.1 specification, although this value is not currently used.
> 
> I thought the value was actually used.
> Please help me understand by responding to v1 review:
> https://lore.kernel.org/Zow0Aw+vrXShXv+n@aschofie-mobl2/

I assume that this was some "by inspection" reason for the "how found".
This effectively proves that no one has ever tried to use
CXL_MEM_COMMAND_ID_CLEAR_LOG with the vendor debug log. It could be the
case that everyone to date that ever had that need is just using RAW
commands to do it.

To me this is another example of Linux command wrapping CXL command
failure.

To your point though, it would be good to get that user visible effect
into the changelog so that distros can decide about the impact of
backporting this fix.
