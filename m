Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBD5439332;
	Mon, 20 Jul 2026 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564907; cv=fail; b=aw63PVGHJIb+rguD4nREOeZCnN/0VMoiB6RpkQtbUu8yUm3YVNZrxJ8nEXoc7u3coIrJYz1/TSXcS62YBD6cEeanrnr1x1ePah2gRM+P2mWzl7xgf5JcR/UVvXA9QwN+0mvY+jujqyuUB4fUPGS7lpxTlyFscyAvCQPstReKAOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564907; c=relaxed/simple;
	bh=XAewKFBvdAV65gpZcjzdHYnoiGJSa4Je5H1ZfLaC3/s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BPof72d7ax6iJ2cjZFkIA3wve4oO55OZ8U0JfZgcqoGrUyvmX9qa+qVu7sffCPYQh8hHgHvF3tA5aKuph0kiVsDpZjnEM1QZDlDDqwmVZOn7zzbaRb6OlT+r135r5D7fzBWHSIeqWGzx+mqTE5Cz6nIRsOAWHMCltsArt89ls7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8K57ERu; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8K57ERu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784564904; x=1816100904;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XAewKFBvdAV65gpZcjzdHYnoiGJSa4Je5H1ZfLaC3/s=;
  b=B8K57ERuEERWZGZy89/p7SSlz6kG2ZBbfcN+aIA7ceNYMlSnbO1rDtiI
   2Sfek/TYsR3vBIQcJGtQ2csvMUxtaO7xrLOIQ6wuLVdJVj2Xf0yKtYCoC
   3Zi9kgcWMsDCnSaamum+WErJhHtG4T1TykQH/sk2FIZqHyzbE/xYtuFST
   4JOfidTXC9uR+ws8qeyexYjZKSIFnZypJnjoMx4LbvU5Wtot8OW94XrLW
   yU43HsmuKALfNBhJFW3P6tmRBI0szLgoBeCvs8EjzV2rl5RNYtWsWZyIh
   GK2Tj/54xnIY3MQ5IsTBzFpcPOsBKQxkw2UUmcLavm2TPk6RteFA0Ihaf
   w==;
X-CSE-ConnectionGUID: /6662UGCT7q4WH1X3uZ7zw==
X-CSE-MsgGUID: zYgRPrxSS5qNLTDrvajbGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84131588"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="84131588"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:28:21 -0700
X-CSE-ConnectionGUID: oX6pNyAKTJWev2OtDn8EPw==
X-CSE-MsgGUID: EXTy/AkVQpKMWJkc1bjRIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="254871281"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:28:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:28:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:28:20 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:28:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8ZXed+goUp7+G9XBe8huNU1rk7DUu+0kDbsjK8fBSPaIeKmwgmmY3bYuz4XWJ3Psuioljeyhx+Qm8EnigDItWFazXX3PGoGkSFyE+qDOAp6uVbV5+zNNWSxa3Kr5Si/m515C6vca0iS3a+XX5QZ7ao/vpDFzCBFg0G0GQntqCJ7Boxjo+KrwbEGQVYohRjDqTljEL4A4SKYzJaCrIQfa082ybRdY/EJrzSlBnMpjaJbYbuKnqH4jBkoHDSWdjSNPnXQwfUdnw/oqiyxulEr4ZqTP4gWoAxFd6O0KIRAK0e61iHxDDT5QWMGvTOZe4rBKaRmRdPuOp0TQIJH0Mpn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RXOYarGa7E9PFdFIGQaAVLHao3zFtu3hSzuPUZYz24=;
 b=kvHY6c6vLjYS6lxrhvB/2YI5TPPgN58xja9WOKtXZ+GFK0NBLKJVqEDGBBSznWFGR05f27FqCwHMu5X9wHEK9A8dvx2360p5wN8Ng2t/hZQ5SJ346i/1PzhTvBMr3E4CA5X7ck1CIV0fA/sgZDK9fleqitL87xLK09g1HMX9Pn1xEFk5H74fTwfPN8HWYiLEpMRmO6qf9csR11Fvi9vUU1I56isaRxp2iwtx2IMD4x3sUUsEPIp6G3MrcxmQDBRBwyfD5dDxOgTfevqu42u9Er7Rfx2guKehdrnfI7XPOnjqwa4K1AZ4stuN6OFIZOIp0sdbYVdtJ95gT5al1Tdo5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA4PR11MB8992.namprd11.prod.outlook.com (2603:10b6:208:56e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:28:18 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 16:28:18 +0000
Date: Mon, 20 Jul 2026 09:28:14 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<terry.bowman@amd.com>, <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 08/10] ACPI: APEI: GHES: Validate memory error section
 length before payload access
Message-ID: <al5MnsJBQF_OlufQ@aschofie-mobl2.lan>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-9-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260717161647.1493259-9-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA4PR11MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 005f8501-02be-4871-c3bd-08dee67be7f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: mUFHxR85ZmO3f30ho2mAiAu058gycgAhg+CYi2n7jLsAeRB1z3EO/CQQcI6fFjFucl+OsjKRLuzPq6D2H7GYdnu7qA18GDdEk5GYpn7TsEMnAn9nflvPtD2ECUIz43nd1Ns1ZMD6MSs4owRc2M7RezdaT7dtjDOwt27BRw36mI7p3VuauquCOqf66IjzQlgVVQkKBusb+P5pnLbkjg5cEIjMFBCJB1P8NGlCZn8bKEoX9mlDLwGyxSChVZlVv9Z3xJ3bSCcCyd2zc9U4UGKD1npTE/0W/MpxdUnRrgUgCIz1BdXlotlstLNu/Unl+m1yqSsBqsfVYZ7bgnascBJGXR/ShyYt9bIyLGhbq28X/7SssFgIfmZ4tm8cvC5ydDTw8/ZHA/Ok5ErCDhRpjEgbzr8xOvaXbBk0jrfxPGXxAUw3WD63+TAZ14HxpleqR/GtlSV+VC4ntmkm0ecrnKZB1ZXseKx5rrBBPY48mremrPe0ruLSCo7it5G2PXQQpkur1R1hwUweet0JY4D8kJnkdIkgou50uNVnLD1fWMQ5uk/oBp8B0EpeiyNVACCMW87acCfwjeYU8e8Q68k0orC+tuVHQVLlJzjhgAQg6meJBr4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oPFvmyGF41cawYErK1+Ny0xwDSCVUxiA/oysVzzWrRL6cDuSgzVnagdPifZ4?=
 =?us-ascii?Q?5aOZJNA8Kwz31rUPCrbUO27Jpn2m8LlYyYNcKZt3vUUih/qCkuElh9aZzXNO?=
 =?us-ascii?Q?QBndO6EX4Gizvwj0znoQ04YQkiRzHicG7w42TleniTmQSrquHts/xQoWVGpP?=
 =?us-ascii?Q?B7smovuZH67wvjBppGYa83bjd7CjyWKR/CGOLtdmr60Bh/vYVipKaUEQ4xnf?=
 =?us-ascii?Q?9/25TlbE5IeiM4EGUThIIuwa86lJpoGgGMy6CGETW+n2Vkk/XeVA/WHZkjvZ?=
 =?us-ascii?Q?ap8Qqhg9ZQIc65HBefEJzOELUaBU8XWPG14KuFxaJoKa7q7NkoY8gy4q9leO?=
 =?us-ascii?Q?p6MezrzovimvRHOVsdzaLcITMfoMBl5Frn2QdYprYEQfbAeKlMjdAn+OODV3?=
 =?us-ascii?Q?1dB2/96ifIctnqFiMUYA0uEPOvqwhf9caFczxaUWZslX+CrMl9dQ5uYJfI6t?=
 =?us-ascii?Q?hKs65beQv4ENqVZVp5DTE+TFpKRFedwY4360Rn8cqi+rcxXyM2PEyp+InqSs?=
 =?us-ascii?Q?dBd3p5MLxBZmGsNXOw5NgY7YpL3ZOqPmqIHVA1TkS0ru3bqHqDCerRs6ixwP?=
 =?us-ascii?Q?hm+OCRA6CrtqlUGP1Os5teEGz8sbPwaaFEhUAfmMZrp1sZndFmD/VDNK9stu?=
 =?us-ascii?Q?N4XwCeUAcTjs+D69vU5TUZRfBDRq0SKW9N7hYBi1eeTPqm/Eu6kWgA+RrHNh?=
 =?us-ascii?Q?Z2m0O0/76UQ/z/YC9d4DIAjtdZyEyxllQIb034MRSnfBi6WQ7BD1A2kVP3Do?=
 =?us-ascii?Q?Swca5o8sdDqdfYvjYq3p73Nhqmn0NN9Zta0fddEnLmgsKdNVZ5M7jtMe1Pgv?=
 =?us-ascii?Q?aTLFRG++1eCKK8UCKx6kvwaDXrFNvWD/Ye/MQQQWtiFVJTShrt/ozQlVxWeD?=
 =?us-ascii?Q?YTIsGAjI3nlDIuKhDUvDwo9CjCtw8H1Od7DM/rdp9uawAVXcSL1Oah3ChBc6?=
 =?us-ascii?Q?1mWm06mhdrFNJaXhC+FdJeR7MqXjHB15M99q9/u2PwM66K/ukBSni+EIQVk3?=
 =?us-ascii?Q?3hjt8Io2cLyXaxA2LgOHxeoBzra+LLkB3MjU23pjKVPfZPqA5XM9UOzJ5/Tc?=
 =?us-ascii?Q?vU6ekZ8hy7nao4dPrLvXe+ZSGzxY7yAffDyC1eVTS0ezSnl+vYz3T8e/pUKd?=
 =?us-ascii?Q?R9vY8obSedOHLsA1cKHLAh2qGkws6Qm87WLPFoohyK0/NpID+qCTFT/YZbA7?=
 =?us-ascii?Q?abLWsWbHi3rm3h1UE0yxvW4tWfz0TsgRWQ2mF+EqccAcATWXJyaNKmVadywh?=
 =?us-ascii?Q?F/CPC+4tD2oxR1KdWGypbcWYVaGcVTVrFgPqQf1DLRWKisqN1k1SzzE/FUCK?=
 =?us-ascii?Q?TPWIraw09YMHbvrr6pmjXxzlJ/YPf3idvvhqo74Z2Uy/X99KUKgNN0xZgTan?=
 =?us-ascii?Q?hwnyb+w9+bWRt+BXRp0LdHHu2ujSFmj3OnYELMm5uRguLoRP6zAgUddMxivH?=
 =?us-ascii?Q?Uo5zYrywvkz8y0ypYVIhgHFRCoz/oy5AMn9+D89Rs4Q2m5PUY0uNWkjnQp05?=
 =?us-ascii?Q?2pBGAPPOfx5S+3H/rRKmSN0hQaMLaVjaga77xTX9HMhg6tw1YZ1jSsR4Hs9m?=
 =?us-ascii?Q?Bd6jsYEsP13JguvvcIr4S/zMTJ/Tfc70NOFlnvjdtJOsGoHmlUtdyf9B4G5U?=
 =?us-ascii?Q?fcdTdn6sRsZ203lXCFJfOr6RREwAdbfVh1/h4kOm4S+NqPXv9mo2YPxeirt6?=
 =?us-ascii?Q?KZQ4JS9EfeA4hOAHsCjU2qCwHci0hrfojsgFHcfo8jMtVhEjFgYFP5Wr0emh?=
 =?us-ascii?Q?41RKyVdiGCzobl2n1w8cetOqQEFhfEc=3D?=
X-Exchange-RoutingPolicyChecked: P0NHlBXfE41WPthkFKBqHD+Ph0ObovXPy9ivH55OVoEcaEBOfCa7HJ6o1WnxpRYaxHoZoRdCMmgZ9H1Bp2bTbU/IRf49KgrPO/8g3pWqqX+WEJ9dTpIsZl24nVOuVl7P2mQc6E8tCwOq6mrMopfNNUout3R/UaSCDGMKX1yLOWvfNjqriqPNhhcQnlpvL7BjIVO3N55DdntS2d5me706RN4TUs9fcqtyflQgYgrVJJfP1PDPvnrpyOA/fUxR6iGaQQsDbVpqEIT2B7ch8/23esHysPcS5hBaoMSk1v7lb2Nyd9CmTIY0wtN8BSwQ+OgH6eHwiGZ18wkoQXE0k4Whcg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 005f8501-02be-4871-c3bd-08dee67be7f8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:28:18.1925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNHd1lvc9k4AHkMInHJJw/NP1sUhs2jBxAGTGtggWJ6RKg+b8auptS0xiy8lRRrlyjtv3lQa2eKuU033H457BNQGczRveXybplGLnhvdufY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8992
X-OriginatorOrg: intel.com

On Fri, Jul 17, 2026 at 09:16:45AM -0700, Dave Jiang wrote:
> sashiko-bot flagged that the memory error length check was placed too
> late, leaving the other payload consumers unprotected.
> 
> ghes_do_proc() hands the CPER_SEC_PLATFORM_MEM payload to the report
> chain, arch_apei_report_mem_error() and ghes_handle_memory_failure()
> without checking gdata->error_data_length. These read validation_bits
> and physical_addr (offsets 0 and 16), so a shorter section reads past the
> record.
> 
> Validate error_data_length once in ghes_do_proc(), before any consumer
> runs, so every consumer is covered. Bound against struct
> cper_sec_mem_err_old (the UEFI 2.1/2.2 layout) rather than the full
> struct: the section length is authoritative, older firmware legitimately
> emits the shorter record, and the trailing fields, though packed
> unconditionally by cper_mem_err_pack(), are only acted on under
> validation bits that a short record leaves clear. This matches the lower
> bound already used in drivers/firmware/efi/cper.c.
> 
> A malformed sub-record no longer reaches ghes_handle_memory_failure().
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=7
> Fixes: ca104edc1784 ("ACPI, APEI, GHES: Cleanup ghes memory error handling")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
