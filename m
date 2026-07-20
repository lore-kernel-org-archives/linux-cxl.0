Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13DE43D4EE;
	Mon, 20 Jul 2026 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564691; cv=fail; b=CpOPRATfV1HklPxq8S22dUiYqMqYgp+pQAAAierazXpuVpZpIGOUS0m6aRw9MZh4a0uRCtKDvFmTVMjUvmUfvNpggzDqCIxaeFGon6Q+EfsCyv0/sjPFJ1LnuXmuVNJ7xDTw44TOuk0gY1yETbjmBjCsCbvzhcSLBdYVFThbIlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564691; c=relaxed/simple;
	bh=ajCWnkcE3Q8/13XbGlldO060zgoDf8x/GFaN09BdaU4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KbiFV6KyVIWIQ9Oodi7biTpCeF2KYy19NSWz85eial4TyXKttsP0lQbOfhKBJGMj9gYJI5C5rbPZ5U4WF/sV6FODuqoO7MZLFGHHzhWTy3lwV7Q5mNQpbNhJtYBQC4BO9A1Qs8rWaVNsu4WxNvvyDIBCmNzqXF3JBIHW+EZK/A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWbukmdu; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWbukmdu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784564688; x=1816100688;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ajCWnkcE3Q8/13XbGlldO060zgoDf8x/GFaN09BdaU4=;
  b=iWbukmdupvDeETy26fW1IoBiTwGWCKWYmkYD6uULW7colZeuuaXxP1qk
   78rJ4BEXBuYSgXMq8bVx4UHvpmHyN/Wlgj7SndpWv4eSCf4hs/tob6AZK
   9PAFf6vjVyX01i3gsTpGgdZk8r8GJsdY0MlUMwG0E7JhRMg00xWy3h/Zp
   RoGXkI3FwAZqKUmE2Rn0DNjhTvKgx+s63mc9mjQqL0dsunC82NZ5wl5VI
   DthlPfunA+XVvbwaKH4brpE5N4j814Y1ZArS6qRWnZsrIsqvpL0lNiHOQ
   WobGd69Ho5FxQ53g7qF4xapx65Aj2rbWT7XNfmlS32b0VP2lCEUbrtxww
   g==;
X-CSE-ConnectionGUID: UHgoPZUdTMK+MAnBzcvPZA==
X-CSE-MsgGUID: qvaPHHbyR4CN4J3h1/zltg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85189841"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85189841"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:24:46 -0700
X-CSE-ConnectionGUID: tpMJLL8UTJm7oE4BL3NAzw==
X-CSE-MsgGUID: SGP+VnUtR8qyzBkkGlV74A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="259502846"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:24:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:24:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:24:45 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:24:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4QT/yIrzdb7635zuz6xTXjEtmI14VcY5kuuRTgPFFI3d5OFijZH8y2tj8IvGhs0LijZc+kj9TzlKMI+LH7rphnZWX89KotBLQZ/ppjdYTsS+LODHYqfJolgeNUueov9SOZN+QvmcvhbL5rPlE5iBEyhkqi4LE0EPSEruRbmG4lUzyoGO8tWlY1jdm1vEA99oZGGKuED0nBbVCtVujN9Dua60LFW7cY7gjXOhcauTMQkDC1XCtFMqsR70gstshzAfGviUNB9i8dzcgyKR51ynSGwfzGodpYmuYYxcxZqyfKwJCXpaO71MWu9j64ZIexyBSIcTVospcDxO6/nsB4epg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtJGkl37RD3WF5J3Ejwh7iaQQcQYdBOZCOUJ3iXnb6E=;
 b=xbOI/lh+3s62VzmilN7URFrV36KO5hTAvbEJTMtrlbqSXsTF8uqC/qdycjPmF1AFkJzLTKVsrCqQ32CD9JeJrb+4OaXKf4+Q7UKibxKrS+pvJNdqLMeLD1z3qkABSCBJmfrMZ13TitmBUMfnw8KqIkvfIMDvGVUb0LyrB+19rv7YedjQhzP6keImyUcA60zAsJG5KFmyrOOMST4DGWr7gpOv/vNNSFqzDk2lzn1vyAglYtym7CP684du9jMEzQt3+omF4c7BGOgchK5KkMVDQI7IdaR/ADcTnNLBpMAxLcneb5IF3gyFyYhWjYx9+JVwemQlVPDvPZxU66KZAu3Bow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB7509.namprd11.prod.outlook.com (2603:10b6:806:346::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:24:41 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 16:24:39 +0000
Date: Mon, 20 Jul 2026 09:24:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<terry.bowman@amd.com>, <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 02/10] efi/cper: Reject CPER records with an
 out-of-range error_data_length
Message-ID: <al5LwiO3-p5i15dE@aschofie-mobl2.lan>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260717161647.1493259-3-dave.jiang@intel.com>
X-ClientProxiedBy: BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da91430-c30f-4e64-e871-08dee67b657d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: H3hT3wZ4/F30heA1+DiwcxQ2QiVI0MHDL2L3oomgHWtAwjfRIFX1p3rA6JISF0z3OUmK6yWuRhtoppl8VMI7zGQes/MjY94ebA4vxoBTZVfPnfsKvHQ+CwgIUE2BX5bk73FBel4QcpXEsKKrhYA0DTGtXNC54uX5kVmPtq4Ct3SRJVxV2YnDgZG8yVJ+H6jcRfl5c8/9zKDffuJ8zpGGor5RSzTNjjykzcJSGGITmXsUtK4cP5JD9noGKSgT84EEFpfdHk05b5heuPmK3JmhdhZNySCGutc24gcolVWDM2jtXSPeEFT0tqhzDbyX2mV6ho2IvikdxoDGyKxXCqXQAu1uJ6MZYKqsG87UUuQc2sYDxpCoRiaZ6d/Nc5Ki4g6N0G4KW78w0qXyv/R60gZUb95Sjc2NWqOQgXgS5rxEII6MUxabocdE5V+61FbdToq4NtKBvshmWxc5WCkzOFjZwHTMjOP8pNs9801EJcrFHyprJhh3mV51ndMj4wz0XRK7+sWPehsN4+BTHXL3eJ0TZykcego/smYR3nqt64+O8vFhAUmC6U4vwlp13w40DNySongAE+eIWckoD4jmP9TZBFGr4n69BQOI+bKmS4R+Paw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yATIabybNAWRsDriiqQXhAN7nXdDnAjkTIWrklpsYPugM1lBW8mRcYlyRiZY?=
 =?us-ascii?Q?bvkekvJ7ItuRb4zeJrdRv/0gDLXGNkOjjb7RtW/CrFTXZpLuOaqXHeY+7Vbj?=
 =?us-ascii?Q?GNASgH5bix6krUrlevOmA0QJidXA0uqmsaeeQAqDU9pwsOTznaM9HcdeHoXy?=
 =?us-ascii?Q?UcGIzRqAtMUa6pwBn9YDtadCV7MPQzbIgf4MbpU+sbFZjKjiVJQraViGLdU5?=
 =?us-ascii?Q?RXvbgbP0/HLUwRDFotvfRTWGAtbbpnPIXpw5S7NE+FQLAhemlS2cKVWUz4OQ?=
 =?us-ascii?Q?IghNosxglCSgNY+EY0CSerlgt+reC4VC0pRmWxvI1Z8TqDRFHMEUqc9L3uw7?=
 =?us-ascii?Q?NBfXp7BZeyNR1cZ3J4CHh/AfHWaqhoNTVrg1mTUeBZIV615IxdxXsfXSDIVO?=
 =?us-ascii?Q?+HHmSs6hTxgEqGTfrZIiv61LTPxJHNVgLaP79Q563vacUzkisB/TfCEuTAkz?=
 =?us-ascii?Q?H9E+9x4YmpO798NgVK/NmHbgKI9n5sOwctuVyPMjuBM+vFZS5PW1rQYvLAWH?=
 =?us-ascii?Q?feCrAAUIKU3m0zPTTYmMeV0onQE0rUGvDm9aD9mp5G9G2/Nc0dW0X/ssw69S?=
 =?us-ascii?Q?+H5z0v2xj8VXckfz2BBQ0v1uy5AkvESuFFfLk4Yrj/h7Eopz1SSD53zMDO1h?=
 =?us-ascii?Q?9tJ2XPu30lYQEheNmUegDBcF7xCbsWaJtstreMf5pROeX790iZYE9dDRMkVD?=
 =?us-ascii?Q?QNk3+cRuCK63UaWl6XQfP7VIPUSgsvkuMv57gKRWzJSWBP2oT9eesK+jmnha?=
 =?us-ascii?Q?hA0+fQBE9YEFR8HWCCH3L5AeFXy1rH6+XK6dUzfcbEUxFnUtA97GNxYUXj3A?=
 =?us-ascii?Q?WtJIt2PheNUrc5H+yXb0QSbvLrp05JaCus5gsq+aWvR0pk1KccsMpBXNUNK8?=
 =?us-ascii?Q?UHndBl4uVfrR12PA5ooXpoT0iF30iQ4PZ4LJFxjeF+FJvY4fSapTiKQlzX7F?=
 =?us-ascii?Q?+4nI1sHzKdYQxNnWkTI0kdjq81Iv31qhWLIRaK15QuAoX7l+U4FG+AJIvnti?=
 =?us-ascii?Q?Yx6ElLlUZuYSk/uMtgmz5PBIh5Bm9Nqe1BQ1/ZNUEF09kLTCTMzHyPBrIAw/?=
 =?us-ascii?Q?Hc1f4kd5Oh/LuYYhMpJJAEEjqSI/9Ah/S2lE3nRGfQpllVGc35xep8y372lc?=
 =?us-ascii?Q?QCCHXvm04kr1lhmSSc4uhp6tDBbhFkMaCansBfUq0GsOQWDHZ/t7TAMGYur3?=
 =?us-ascii?Q?fFjRoGVkc+IHyiHyjeAfy9iOlVJDkAFiEeRlF51SA+gOpmgqKqh6dIVtVH24?=
 =?us-ascii?Q?Nq8jZRwqi+Q9PESwoVvlDExASaeLIqF991kU0H9bjJmwyhHtN+e4TU1tNxkc?=
 =?us-ascii?Q?9yKZTMJSAY9wnmkXB6LYmFRy+/a1T914SgtjQejqTYTCdsOnwX2w8XCUqF6n?=
 =?us-ascii?Q?OcG58exjFx3urS1Nzq80yyKtohea47pHrK6/dc+1erAhva1jRCIwvGaeSdq3?=
 =?us-ascii?Q?KJTH/Y6Pmsb7n8ImVxpZndZO0Cjt5xqm8A+SMEl3UR2iZcvHUd3rYSNZAR9f?=
 =?us-ascii?Q?6zGyjLMd5T97HAyOy1kPAhgi01RX2C76i/w+BQh2SnpEooBaCXQTEvOPoOCc?=
 =?us-ascii?Q?7mCQpHI1JJ7R9A1mN+sjXX+dSBMm4p2mR14z1xb5Tj4vVgC1j1ZoV0/Rz7eo?=
 =?us-ascii?Q?dTeIdbde1PEhCMp/4uBNLscjOlHoXDs90M/80NSqNuycp7vMKvCRPfF3FXdk?=
 =?us-ascii?Q?71bvle5oFha1SqSmXmPo76iFtlEfsRBV6c7XIUxG3U8m+1V1wSTEAcFiqWJZ?=
 =?us-ascii?Q?C+lLD0Earh575wBJNoayNRt34PrklfA=3D?=
X-Exchange-RoutingPolicyChecked: SmoJsmB/q/ycYg+VC4y+rtKW1V8MAOpvlgBInrbSDHZtNv9Lgt8U2a00TU9NY560FRKgfL/Pnc3vyRxca4emc6dBlchcUSalHj26Q6FSU6OqJsJwuER/gT4bi7BEPvUuYIV8C/WzE9na9VLyPGMA0111IA5h83YeiIDXlBrpLfpeQXnfcCE23iw6Y688vkjfkQ0ExNbFPCIAoT//MUuiUQ9VROjpuAVEBp6W5WmQVod0MElhd1bofTbCAzevQr77BleOrO1XOX0W4yq3aA6DcIjpYtRRwz9dhR3vfuR/j68xfOaAPZF/iZkjKnhWPEALiXzArnvjkVFXy+V4EBB4OQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da91430-c30f-4e64-e871-08dee67b657d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:24:39.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2/C3yxYcnt8BPrz0/afwzyuCaJc71+OLjQiDdyRC+PVaJYtJ1l3kkEzvJ7tnN4QOtS/25YMWX+f4JiC8In01HCNQnVLTqX5M+VFqJJgsgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7509
X-OriginatorOrg: intel.com

On Fri, Jul 17, 2026 at 09:16:39AM -0700, Dave Jiang wrote:
> sashiko-bot flagged that the "len < sizeof(*rec)" guard added in this
> series can be bypassed by an integer overflow in the shared length check.
> 
> cper_estatus_check() bounds firmware CPER data before the section
> handlers in ghes_do_proc() run. It sizes each section with
> acpi_hest_get_record_size(), which adds the firmware-controlled u32
> error_data_length to the header size using signed int helpers in
> <acpi/ghes.h>. A value like 0xffffffb9 sign-converts to a negative
> number, wraps the record size small, and slips past the
> "record_size > data_len" check. A section handler then copies a
> fixed-size payload out of it and reads past the record.
> 
> Reject a section whose error_data_length is negative once sign-converted
> or larger than the remaining data, before the size arithmetic runs.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260714231835.303081-1-dave.jiang@intel.com?part=1
> Fixes: 45b14a4ffcc1 ("efi: cper: Fix possible out-of-bounds access")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
