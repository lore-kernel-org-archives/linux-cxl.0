Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7341548C;
	Tue, 24 Feb 2026 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892341; cv=fail; b=Z631ro3NKDZBoi+blFZAu50g9bpXaD8d1JxPZhfjHvErQ9zY3TLxPeHmwzlZAvHazVDDwCF17QC4EQTWsA0psMkHkF5ArapbT7rnN1aOQ6CJL3y84Sv5V60SLfeSUxe2+Pn30jaPfWxc38BPa5ayl70lRu1zks1lOHI3NIWtbww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892341; c=relaxed/simple;
	bh=zyh7BShEixStuFeBU+UNgF21C612yVTZFolEhAf8odM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nyO0qFZU5I2LdK5UhoXQJtFU0Sm1kGtE+4P5y3OkCLPC0XvVupbSLqvHAom8uy6fFMTjbHwhVDy5LYNCMbv0G+beCZ3FkEV3SrnEsjyci5ksiVTmlqDBYqFbuHU3d9vd4hOpVF8xTNH3DBamMxPbYlGWaNLLxnhOtaARQqMGIYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBvgydp5; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBvgydp5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771892339; x=1803428339;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zyh7BShEixStuFeBU+UNgF21C612yVTZFolEhAf8odM=;
  b=HBvgydp5BkenxG1IB2+zPFtRoAjEZMx8HLlQ6DBvfRQHo/CCxDiiWJP6
   tptIkrCDLBR6u2hTriyEviLPhtv5+9jWH9mFfI3/vrHAW2GrnDZkySO+u
   HzPcn+2KlCG9R8JUa7BK5RJMRDxyQTUg/k+5yG2DFs8mhGjxmlEJaG7Dd
   6d3yUDs+mhhHN2DBkW2N1bpTIfC2/pqMU+263fWuvXiCGFOGiBGTdwnfc
   nIxbQIVtaRm/4gjpGbIQAY+hkuYCa03BJcrS9wwaie+U5AGNX4A962RhY
   5ilvChfRQNdseMC+ktm+uZ16U+qEYZKcGHz6lXon9cNI0Nx/ODciItzvG
   w==;
X-CSE-ConnectionGUID: yPrBLQXySKi3NtdAn5xdAA==
X-CSE-MsgGUID: qISdcTPqScKv/F3HSLQtXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="76730169"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="76730169"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 16:18:58 -0800
X-CSE-ConnectionGUID: Qi+ED40PSdyzhwNQ3XX7AQ==
X-CSE-MsgGUID: n1kaMA5ASU6AQiV5MurAmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="219242565"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 16:18:58 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 16:18:57 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 16:18:57 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 16:18:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOSagdi4xXRawc5Z4v6eTwykhyBI/N1FDlTCq+bSvNBDXs/BnZN5BdUCm81hpHXytZgBrQAHHya/CWVz6392JicyDz9I4eT25sIc3yXvumLQbh8oYWeGcjQPsF2UMcgXH8oGIfyfTQODYQzBN/HjV1631Tb5n11ImQGS3UZMZigcy1BfcFENXZgN3kxG5c0XzLlvZjz/9BuOIvSnrZmju7YdfuxjnTUVWnM6JpaeG+G52nZTFzAz+7KGsAdlUNZ86JblcN+Hxa6IijNgAp6jGxOFAeCPExDF5KC08wUyIykpX7pItQS/v90tzbZ67g1s/+I3r4ga3lC3ecUKfbjtfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7cDyKj4AlTd17cSXLuVI8x5K+rBroYJmDqBKOFpTVI=;
 b=mr2CVS2eRq1MbE0nbhu64rCBUbkwKRiV3ELEtBU/1NPA3VFfSYXwsnJQVoMawb+2ZAOkCZGKyeB+8IiaQsWmP19cpyY58ZkpQwpGhHVKC9L8iH9YHhHeyTwmh+71gn79o2L+JRX5OfthvcQFfGyg3Ks3a4AbZJH96KdMHBQj+AOwjutwCEzky5IpdEgWQH2B912P2nAmsBj/g+SOmBXYOhdBCGYzRkaKzKrUdCdHuAEi2dpzGJM0iXPyhk9zyzkW55wpu/ZpWpqkTL+903tb1l4kWWxWfKx5eMPcIVdc9yPlnMO03SslgHdHsutUzgev0/75eDedPMSmzHZ5WmVClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB8052.namprd11.prod.outlook.com (2603:10b6:8:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 00:18:55 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 00:18:55 +0000
Date: Mon, 23 Feb 2026 16:18:50 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] cxl/region: fix region leak when attach_target fails
 in cxl_add_to_region
Message-ID: <aZzuak0CpP6kTtke@aschofie-mobl2.lan>
References: <20260221043013.1420169-1-gourry@gourry.net>
 <aZyvGnKfWI1Mku-c@aschofie-mobl2.lan>
 <aZy1VGindEm-NbFn@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aZy1VGindEm-NbFn@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: c48a8d1a-20e4-4032-6bcf-08de733a4baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?grPjOFUrHvunFn6F/2O5bPxUwsM7vvzIgCr2bgMjWjAKof2EQKKxG5JPZFMC?=
 =?us-ascii?Q?eCkscUmJiMUEhe9KWb7HptPT9wCrPXwIob4D43zopsUxjCVLZLwbl+8aju6d?=
 =?us-ascii?Q?6N2lSLqED/gGJ4ciT3oGr0WJq9kC9Vol9/tFNKyBA/xvHKFag0V7plEiQOrI?=
 =?us-ascii?Q?8LdCudHpTXhh3TqCf+UQSwR8gL1GXdbRxdKA3uG29dMOfVPQbAIQu4/t5TYo?=
 =?us-ascii?Q?7inSBKr+ap+hPipzZkwofexOnbnzgd5dT5wKdjExi3QqXy43+kAAcIfU1R+0?=
 =?us-ascii?Q?vYnyxzHOGPtqkpb5bL0B4EacaCCjzmoXe+DpjdDX5JOLedIVf0ZONil4XYrI?=
 =?us-ascii?Q?F3oDui/SXVJcJiSy7XlMRB/tKdmWnbJ6C9zu0zL3V+qjj5LnZEmzwzcx7ZTr?=
 =?us-ascii?Q?x6QNoJOZ3LNq6jna4XgtOt7jYMkqNjiAEOeAAXDu4PX6Fmv1zdpgDFHpm7Q+?=
 =?us-ascii?Q?uyNDL/rcJU1ayt2ML0vjZRpM5f31XeWpmYeFQOEEDy9ycdA1HVHorcmqg1w9?=
 =?us-ascii?Q?O0X8DKeZQ6PYccCMiTNSddm5uy3oxZuLowvQoV0GFxFVHC2kByDm3TAcix3Q?=
 =?us-ascii?Q?61L9edOTMbRH5Ux8xcNwbxAgSju/A4+R9dy1bkljGsFeciNNPdjFPQi+RkDY?=
 =?us-ascii?Q?OKU9Sj0/cm20CAEf8KJ8Ky98OhgBatn01EQpnI/rAtTvqFZCRO73BFi+P1rU?=
 =?us-ascii?Q?OlDORajxDg3FyHoiJqNVZIKO7JzOf7O38oAtvbH6837d0YZ2wThaKCJ9bmH4?=
 =?us-ascii?Q?iwtLCN1+SS0Lk1b9qd6F79/PT6toPQ7bA5n2RtSCMaJkOo8l9gNHwiBVPajb?=
 =?us-ascii?Q?K3kAXAJLY5fkjNtIufesavebK3xN5eEkmrwqgHN68oR7lytGCNJSQutLsA1B?=
 =?us-ascii?Q?JVxdTWUuFOE593tCohUJavuiuhQvr7KYT3nmMl5RTuWdyw2KZuIJ+3zJOfsK?=
 =?us-ascii?Q?U6aYagIHwJS4d3VEdUHtq+5De+AkvDZjVr0apslaXY6B/ic6CUUU3PxNfvo+?=
 =?us-ascii?Q?wQNvtBtUxzFpXl03odVB2hrFEtnjdZQg6OLb2ReHvE+BKsBqSu/qJfhoNAWb?=
 =?us-ascii?Q?5MGDtR1Uqss6pqTzJXAYzQgg3y9Fzu4olnh9TcLeSqVafMgKxBucdDcHS1F5?=
 =?us-ascii?Q?Vitp6uAA2ihZUzkrbpEXQxu0wGpWNmZi5g/AZzyXHhl6UGh/yq9YWaQX2YnO?=
 =?us-ascii?Q?N0NCwgsNcuQ2zSEEOhc5/U3NASjtWCNjGLS0+VczBwjAkwIGUPPh4zf4K4EP?=
 =?us-ascii?Q?OCLt/OMr0lEvKwWNGs8tIi/BqsDUvpd0UzjkfZOhjsmknTHSPIUWcpa8Of31?=
 =?us-ascii?Q?o9XXsHzGPsRVbkCJsJMS3JlRtYc3ZDaiTl68g5ewqCPiJuriLy9/Gs0uZ/Be?=
 =?us-ascii?Q?Q1niYsfJkI4UvBtV6sYJP42Gb/bkgs9acwfWGWk0XI8nWH0+/Ke/xUy6HIKG?=
 =?us-ascii?Q?fPOj9u3r36vyXGTRVpammGicXzk3A6C5uvmHlroQXwPdXwikIUynDykeoGs6?=
 =?us-ascii?Q?lePoRjISjpjMN7ow9VArI8xoapwNQmpDxHPaUjjcjjFCvP2RHP4JosM3GKdv?=
 =?us-ascii?Q?KwNDDp/t5QqNWcF45+E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hEBcf7gJEuO4JdKRZf51QKkJKNh8r2AApWaCtMx+x488vFF2qUS6mpGPjlQN?=
 =?us-ascii?Q?1J08g9j12TTqH4SQkuKrsV7jUyma4T0s8VYXlaVTkjBk6z0Z8yy+/NUiRKn5?=
 =?us-ascii?Q?p0wBEBf8pu1IGzTN9XEx4yAQUWekNlN0fPgvX26xkJyvenDhuEqVODJUEIx1?=
 =?us-ascii?Q?HvVTpChMCLJ6nVk/WWUKEXeFqMpuqfhshzkhB7CVXvI1GBa6DQLW3KW1IfCP?=
 =?us-ascii?Q?SoyU0/bsIsmBNd505p8sOy2Q+rlz8XCEPsYO++fEIvp/tf03gsiNgykoNMii?=
 =?us-ascii?Q?ip54SMmStCZ3sRdpqXE6HwIta9oXEaKY2icQY8f5a/LjW44Y0nETg1dvmH/A?=
 =?us-ascii?Q?7mG7yhImrohPygLxf5r+FW5Cj7vSJ9cFUce/5QUXXIi9vOZYvnU7U1AX/F07?=
 =?us-ascii?Q?3YPjk74dGExowvM5zUbmGdQBv8a8/UUsI/IFi1B1cMpYrau5kZ0ATdIHdBma?=
 =?us-ascii?Q?j1vbcr/Y/66SoeQfVWsp80dlem8YBCZ1HHfLBoPF2RgaEffTSNsx1Pl97IxI?=
 =?us-ascii?Q?JHb9Y7KzK5E1Ra/FEoztpyfJ18LXzduOa3lgZDgfgUZzoRHy63Ugv2fugTJ7?=
 =?us-ascii?Q?1uOWN1JUjRzo0gg90iZvETOd9TF/bqXMF5dHgYm87IyYcdy476GQZob/pysE?=
 =?us-ascii?Q?fjD0SXcfmoXvYBcBNncagX4B9rODAxfZPTLmW3qGGcnXVWCrnftNW/0cMiZj?=
 =?us-ascii?Q?J3Nc/ElCGaa/jYQvohKn+pfROEGzwMN/aQf8JesGPEkSJzTfp1FCfX7Fod/u?=
 =?us-ascii?Q?m6n1wNfyvFshIp5v+yCWvRFU8kckJbnyB34eOMuA0rdVO8gioZnW1HIaeSwF?=
 =?us-ascii?Q?hDKRIaaqgA0cJIUJXuJhjLT0xwVoDXAUPRm8MkcWvs/rHfqoD2TfM6l8c3Yk?=
 =?us-ascii?Q?RxoAHsqBAO7R7sIRHhPRxcd7m4LMbfkPA1uCngwjlaemKARCRsCtO61a9dBC?=
 =?us-ascii?Q?urlT/E7qHxn4t6XymTMm1FaVUPZBTrUEvlfSi92PPnvrNfVWkpdr06JbfEYT?=
 =?us-ascii?Q?XbqkV02TWYzESrmzwGwisbd1uothsS0mN7so1PORlyFa0bxMfqLA+sOrr2WD?=
 =?us-ascii?Q?hMGh8Ji1fqOfZYpyuIsDtkFSca2fvSOWQxSPTaymBp0w0CFd+yHA9H6tatqz?=
 =?us-ascii?Q?+qxgI2lXiy1Z3fzwGbj1tVQlrtJUlhr0woHMivVM+8Ss/HPaFZ5EEB6T7G5A?=
 =?us-ascii?Q?hqZqYyVSMIZpmTrYLri++irjL0WgWZy38iV6bVc0Vq2kJ8Syc6GU5ls+xTAd?=
 =?us-ascii?Q?St0QpD+mGx3JSJY6zH6zyrplLhSdUV78SboyUnabgc/IVHY7w8EYmw2phmTc?=
 =?us-ascii?Q?H4c/qSkLXVvEh3IjPMVoG/iDDQ6E7RoS597KvX4OlIx4/azzSgsZ7eEzCqgv?=
 =?us-ascii?Q?oC3nzOtWJ8U64yOuXaXiRyqXOlwiOuKP2BOci6ltSF/sl0lbC0mLFYs2xJro?=
 =?us-ascii?Q?BQ6CKlx1YUbbefnVKVUjljSM9SMiHJUhRrWskPrXn5S1TaJneKCeuy8YUlM4?=
 =?us-ascii?Q?XmzoJsJ+BwVHQSRA7Ht+scgD0kxRe5k5BHiEFmJvE3dNwQnFUarEwbuCp3kK?=
 =?us-ascii?Q?0PZhL1QSBpejwkQVGWpmKCw35iIh8Qez5desN95HfSItdCHbq+q1IdU/w2xu?=
 =?us-ascii?Q?/5cex05mmi1pfCvEoFqaTOOsOXs+Jp7QTIk+RJ+zzKC5ewuAeS94jMePmx+z?=
 =?us-ascii?Q?YUC6dnntbbh3qZlfY2vMeRuAZJcxK2LMOfJEEaOEVxV1cySkBcU1GXjAan94?=
 =?us-ascii?Q?g8Dx/7wf2V30SaxSQnyRTALEisz25jk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c48a8d1a-20e4-4032-6bcf-08de733a4baf
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 00:18:54.9705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3UzxeAudrXIRLP6xeRRMOc00yxO00vg+FXBsJKEwsc8JiPJq+iPITxhBHQP9B+2X1qsYs72h+Zu2kyZ3GeCrOdvz/X6h944y2X5guXtxDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8052
X-OriginatorOrg: intel.com

On Mon, Feb 23, 2026 at 03:15:16PM -0500, Gregory Price wrote:
> On Mon, Feb 23, 2026 at 11:48:42AM -0800, Alison Schofield wrote:
> > On Fri, Feb 20, 2026 at 11:30:12PM -0500, Gregory Price wrote:
> > > cxl_add_to_region() ignores the return value of attach_target().  When
> > > attach_target() fails (e.g. cxl_port_setup_targets() returns -ENXIO),
> > > the auto-discovered region remains registered with its HPA resource
> > > consumed but never reaches COMMIT state.  Subsequent region creation
> > > attempts fail with -ENOSPC because the HPA range is already reserved.
> > > 
> > > Track whether this call to cxl_add_to_region() created the region, and
> > > call drop_region() on attach_target() failure to unregister it and
> > > release the HPA resource.  Pre-existing regions are left alone since
> > > other endpoints may already be attached.
> > 
> > I see you dropping this, perhaps just for the moment, because
> > the drop_region() you wanted to use is not available yet.
> > 
> 
> Yeah it's not a particularly useful cleanup in the current
> infrastructure because nothing actually uses this pattern (yet).
> 
> > This looks a lot like 
> > 	https://lore.kernel.org/linux-cxl/2a613604c0cdda6d9f838ae9b47ea6d936c5e4ce.1769746294.git.alison.schofield@intel.com/
> > 	cxl/region: Unregister auto-created region when assembly fails
> > 	When auto-created region assembly fails the region remains registered
> > 	but disabled. The region continues to reserve its memory resource,
> > 	preventing DAX from registering the memory.
> > 	Unregister the region on assembly failure to release the resource.
> > 
> > And the review comments on that one, or at least on that thread in
> > general, was to leave all the broken things in place.
> > I didn't agree with that, and hope to see this version move ahead
> > when you have the drop_region you need.
> > 
> > 
> 
> The important note here is the difference between auto-regions and
> manually created regions.  For auto-regions, you might have another
> endpoint show up looking for the partially created region - and then
> just go off and create it anyway because it thinks it was first.

That's by design, and that'll eventually fail too.

But - is see how your case is different. Thanks for the explanation.

> 
> But in my driver, i'm explicitly converting these auto-regions into
> other things, and if that fails it causes *all other* region creation to
> fail - even if it wasn't actually dependent on that original region.
> 
> This is only an issue if you have two devices unbind/bind cycling at
> the same time - i.e.
> 
>    echo 0000:d0:00.00 > cxl_pci/unbind
>    echo 0000:e0:00.00 > cxl_pci/unbind
>    echo 0000:d0:00.00 > mydriver/bind
>    echo 0000:e0:00.00 > mydriver/bind
> 
> If the platform has pre-programmed and locked the decoders, and one of
> the two devices fails to probe and leaves a hanging partially
> created region, the other device will fail too.
> 
> It's a pretty narrow failure scenario.
> 
> ~Gregory
> 
