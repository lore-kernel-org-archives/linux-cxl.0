Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E914643F4B7;
	Mon, 20 Jul 2026 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564800; cv=fail; b=Yd6cgEEeGTQHUA++bVnvLClBgp3V+XhgI+y17pLbudWe0tjAwd37WFm1tUpklvU0SWbLObMv9tPSZa6T7IntvRoNtqHCY6uEFuquJhnTBBLucNOe0FoPGXL+WBRRRK+SMgMHHlsXNjiGr+j0qW21SidR3rqX0sX9ySiXHOOQ1Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564800; c=relaxed/simple;
	bh=o1h469aCY62eF4j/pBsuqUEzPAx9M6Cfs7QM2QwBjYE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hGdlmRyKUSXrvZs4tBKfu3lQuqUQFhqMq3qVwTAxnUQ6VpkiEINvr6dlVirmvELn25W7enFC6L7q8k6MlLRpBMxLHP9Kg+/YKp+qwzU6bJCjwwZw72NFwLanZ5WRRiNNc8TDnSFUTwdi76PL+ZFKr/Li/Toeob5pkjsg+S/hdxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EtCkexKR; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EtCkexKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784564797; x=1816100797;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o1h469aCY62eF4j/pBsuqUEzPAx9M6Cfs7QM2QwBjYE=;
  b=EtCkexKRRwN/kKeR+3xpbdEUVsDaBPBUcDAOH1hTy5MoY5G5H8nKxaiX
   EK6LBLR+3okrLR+TSquQGVelBdHwfXRZlX/rMfkvwVMYG6uDhcddnUAtJ
   nO2HsPotGrXZadN98numP/lxI9grcLI4h4WJhf+J0w38mkazMB/21lvGi
   sz4knTt69C4N1xwhyE87I/USZKgI953k507iNpssY9/VgX5mYqJoOjX89
   I961XL8tRZWQ6iSatEVoucl0H++Hj3e2YG9f/S1tyef+18AlFS6cIB+tJ
   Vz+78LDQVz2O6IFnf06Qb46noffuGF8T8fmAgcNVGUATF+hbM+/yM4x69
   g==;
X-CSE-ConnectionGUID: u7t6aNpxTz+7OZENoRppJA==
X-CSE-MsgGUID: szLbcvxWSaCVoJ0q0Y1qwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84277693"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="84277693"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:26:35 -0700
X-CSE-ConnectionGUID: AboW9iGQRNeSBbiX6Z8big==
X-CSE-MsgGUID: +t4RWreuRFqjOCMdLuTXnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="262455466"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:26:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:26:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:26:35 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:26:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+nxbgRQjEiY4teDP+W6EUZ4MKCBdKuEOKaZZUUKhgjZ6kNQX2TuAInFEimfN3CkWya6n7OadR6WqgnmJzmfLGopIUB2YouOU8P2G1sTDeydsB8I6Gr4G2jOaYUa1hadPtOcvvJ42x+cLlD15mzTCFB0cOZHLnkZvWdMuqsQt4EJ49ZuPm2MgLBuGxbT+h3C8jv0eE/IOOJgKd9L8ONRZwvqtd3nA+SlmuiNGSGkAWAsXm4Soiol9mngZDUFhnKlMYpHmw3hCzjMOWAQPittV4ppMuwikB+02fUzlN8olJCWeYTH7LvJmb/BoKKKYtBh/V3el0EwaFV2jKV5jBQg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DISUqxs+uRESOWHWGWOkzgfkHxUPpzAKQIqz/41vj2I=;
 b=yaWbNJw3gKsd5FHGFkvsjrD/Jmpal4rnhs+rXUxzq/GbtGcs+R9mhCRqU7KcITgW+ZKCydqgvAcGXcIdxSAHrEbc5K9HfyB0SHav0FzSeAeXO0soMZ1+xUWWsuF9Zk2vXoiUzc5fchGJC1R2ArFgHUGVN11/T0dhH37mCxIQYep5whCTy5GDmoCcNLuefXeLx4WcjelhfavNh4mp0orfJcCv8R6GdJuJ7Am3uc0C4R5VG6O5n+tiuzyQA0i3VQZp9Yw91t6e1ntr5vy5IYTtF17S9b9ZWQxuDaGE1dF8af4AsF1IaXM3BztK9Vj2ASQ/8v6QGNzKiOijw14VDoIatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA4PR11MB8992.namprd11.prod.outlook.com (2603:10b6:208:56e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:26:32 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 16:26:32 +0000
Date: Mon, 20 Jul 2026 09:26:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<terry.bowman@amd.com>, <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 05/10] ACPI: extlog: Validate PCIe error section
 length before payload access
Message-ID: <al5MMi1DLD2rWV28@aschofie-mobl2.lan>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-6-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260717161647.1493259-6-dave.jiang@intel.com>
X-ClientProxiedBy: SJ2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a03:505::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA4PR11MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 760c3298-6e2c-43cd-76a4-08dee67ba8f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 58jxAyMOpdZtdJCzeMieOoSNATgE3IwEBQM2vBfiXH+NZtlEhEIeBcKZkaxDTQzwiF3CmzTsTcI7jTVCNObi4MObJBJH8BlRH//QNSAJKmgNW95Jvj604p6Pnr4Ry0gbQO/Y1QNwXjfQycNgjXkp0UEljoM923Jz1iO18OEZyn+Yuu8aDB8M1YAxAoWL89gEtWjy1aqYZllgq+uYCVmUxRyXj7nfegbEXIxmoIWWts7Oj3r0LyNzpUFPVvXDdbXdy5GP/vrQKGYRnlJWG1agF6gR8jK/zKZuR4smFXyF98NFliopyPpDdwUGwmvjoVulvBtPvnSYqXKzyJwna+v0khsbiox54ZDMWZGXV5KdaQ68xnTv2xVulnGf0uvy942EnusgdbHFpq3HfXYcGn6OoGkoAGBqmZbx9XKASSd4CR4q8p5gsRTfRYJ0o6x7WumkYBdq1V7ajZAIffqQJ/XqOUid6SwnFZ7+dJN9JeT3Fpy4lugZgRu9SOxlmfqNJvK4s0npAmzn05wdXdpdDaxSAxfTOwiJ5kMFf5xvR2uJEOGEg4XSWSlDMaSh4kAyE6EbmrFuYDXa2aZaxwOpbCCGkWNxYn+I9VmS/4XZ7e2D5NSjZhYx5etdD9cqJUibPiEyPhPI/mjW4K0cCfPKArd6LUKhcy4+N1l8BeP7hFsy88Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o4rhjTkBbZ0WCDHNIIO0YA7SZDcKzX8vayT4MxF7rpbY4ZZc/Vgf5dIxIfOg?=
 =?us-ascii?Q?TPfvXWQLboLH8aXQCPtXRTUBlX4hd18/ZIK+l9+8i+wpSVGboprdWbTOJZxG?=
 =?us-ascii?Q?3TqElIeivGgjp871p0aXGVOBenFisJ36uLmPGmzXZt77w0diRqLy35qPeyAt?=
 =?us-ascii?Q?R1jCufxkb4mMFNEegvHCIP8npnA5lXNK0nSJvrdZLOAkBiZeGiT/I3o1Zfb3?=
 =?us-ascii?Q?Sz0aj6tmlS5ia3mlcjdFyi1yj9BV+N8xMYEN9/ZLFSMRcHD8GHqN8FAo9oxJ?=
 =?us-ascii?Q?6PvsCO/5bNBwLsEAM3W3KBBFm9eoIBm1kwS351MmKl9Ms1FxvXAvcYwpHC1Q?=
 =?us-ascii?Q?gMz1+xKFCJwhXWx2SWgArsmkQ4C3W7wzxU1vXxrbQeLlZb8ghgfhwoKM65kQ?=
 =?us-ascii?Q?yz/X3/wjYVU3PTrWYn+N0cJMdPFElpHGNU5gFF3P+hOsWsNdfvmUg6Lj4CX/?=
 =?us-ascii?Q?ho3zrbfGqHZoYnFkFUOsI5Owf3ZveGYnOWmGGqERl8rK21DkxSbflej7wYRe?=
 =?us-ascii?Q?1AXIc7MnpatXUb48SCDM+tRSA6ggHcWrDeN/l2YBCexq/8ZH4ZhC8oUC9QxT?=
 =?us-ascii?Q?Uem0N7Uc2hTPQX0m01k7B/gAqY+hvGBhV8wKpuwOwkSLmzXm1P1et18iaOdK?=
 =?us-ascii?Q?aEKhCSlVGZ0IxZmEtR6D0E7Qa76/ySYSjOirsb1fFDvhpH01jxbyHJjOZTv5?=
 =?us-ascii?Q?SdQU0CwNj4cIi8RZTnsX9IC6Ja2+0aKEVV3rEtTLlsOpifGxjBXG/y2/rSE9?=
 =?us-ascii?Q?u7JHZTRPLd387s3ZiRdPlUeQ78kYLIiAXchon/n5YmpJ4ZMgnru+sAiliJ+B?=
 =?us-ascii?Q?Ula2dE6COBQyp/I/IRJpgjd+8/v1wPx9TifYx7POSgXgKw/DfQ/DSb4lrdDD?=
 =?us-ascii?Q?WSYqBih3AtBzba6fhaneiAVU1tIdOode1GNBFGpFEsDlcUGVd0+Ppifg0a/h?=
 =?us-ascii?Q?UhF/+cJWNwCo5rznVklugPKPbBuUeloZgs46U/CjPNNHfWW6ZepTJP8pe8EF?=
 =?us-ascii?Q?+FKOAEoX22OQZWm7VXKPAT614jtICBL7nlpu1GedvvW/VD3wwQZ1RTW89aAA?=
 =?us-ascii?Q?tVDFK535GFM9a5YPdgQx736RAK0SZaFn/YWtIoBwoo6mdbSxtLAy3ss+bTsW?=
 =?us-ascii?Q?1LTk76jtbhm5AFQr0dQL5PnXJu1QDjX9L1XwD0FyiwnNap6h0q1uCuP3IYkA?=
 =?us-ascii?Q?vvEUzP2qkETCJ+4vkTxPbiQlDlApXGjm9PFE+toVthTUxrwCV+LK3prpngmJ?=
 =?us-ascii?Q?x+G+YPW16Lj7979EOpwBmVUvCx2N0JYsEsLk80fQ+K0b3V5LiO3wrMjJnU6j?=
 =?us-ascii?Q?zv1Y8vrOmKv9uufneIn2i3haQBnQRz76+r5TFhbVZ8qvT/2vPuYqv4edsBdf?=
 =?us-ascii?Q?i152AeGtMs66ykZeL0csyDH/Ev7jNeMVqkvUqon6OGXyCQY3ZZhhezoEK894?=
 =?us-ascii?Q?Z0S7bF3FILpPyG/VpuGzY3w+dkTYkZNLti+lrLOakfCcmd6HZDMjHWo++Ppy?=
 =?us-ascii?Q?P1ZNjDKPoL9Lsy3xvX4NvUbwsaw9n+hQKzTtjuM3uKp4qDjAY34mQj3jTFiV?=
 =?us-ascii?Q?gYUre/kCfFUcaLC6vJrlZOxhGWIeaKaGcXVS6ZHT4jRrELgGVSANA4QioCAp?=
 =?us-ascii?Q?/xRTilSFV71kZPjVUUC/DUtYXoV+IyBav0m4sPCB57kaJSSyJ+TrkaOq1J8W?=
 =?us-ascii?Q?1Xj7TEwTf//tnc/gBzLxh6Ayee7m8ypX6C0GbZvfoHdDuDU3W4v2pF9jgyBQ?=
 =?us-ascii?Q?bonwAwmsFFLzgFKIGqiOucl0xIqdGBU=3D?=
X-Exchange-RoutingPolicyChecked: bxVn0MN2uO3KMUYx7mP2NAlitEA2zycAH4hVLB/Onc1W+5B0ADQFI52iiumgzxRity4cV7GqCpax7NZZ7t2+O1jfOTR1AGrQJsRnvICOZwj7BFZeO9SLK3rrAYFP5W6RTcAD8M4nn174eSFhyY1V8CIRaNIsib+mCLGW0iW9Ow1SGyLeqXSO6c1l3EM/917I/PaYqqkkUDwGaNX62AzVrU8S/dXs3lGGeuC/OGSuzUuTmQ0+pK5PETOMPqocDmoL/RLsz/DC84ANAo+wNWpl3HiwXsK7vmOy++K7uhijRzAlUrtWEGV2iX6DuhtLu1g6F29qExnE0e1seXSPl3z33Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 760c3298-6e2c-43cd-76a4-08dee67ba8f4
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:26:32.6057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTgxqLUvpwfTU1hEEAhnSaU+IXwvR/mKMfIsDpFxllZuQoN7n+Dw4e6droMvF5m51NHuPQ5pmvy4krlSP1vYkOrYL0FxxMMSWQDJW9GQReQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8992
X-OriginatorOrg: intel.com

On Fri, Jul 17, 2026 at 09:16:42AM -0700, Dave Jiang wrote:
> sashiko-bot flagged the missing section-length check before
> extlog_print_pcie() touches the PCIe payload.
> 
> extlog_print_pcie() reads pcie_err->validation_bits and device_id and
> copies the 96-byte aer_info buffer without checking that
> gdata->error_data_length is large enough for a struct cper_sec_pcie.
> cper_estatus_check() keeps the read within the estatus block, but a
> short section still lets stale adjacent bytes be treated as PCIe error
> data. Reject a section too small to hold the record before touching any
> field.
> 
> Reported-by: sashiko-bot@kernel.org
> Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
