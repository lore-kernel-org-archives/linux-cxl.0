Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE021FBE8F
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jan 2025 02:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737771998; cv=fail; b=JYtRkD33fqFrInVn6CV9s8rx8HaBOk/JyizeLwrhMJCvEYf+NVzruPav3tbjKgMCY4WG6Pgb+6JEF3k+/35gofWA3hFEb2lkkhXMX7kDd0w9G56SJ5Gges4gPLR10+Jgj2lxzFXiO2fT5EPov6qfOSsEXPhH4ZmKQ4KZ2N7c/zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737771998; c=relaxed/simple;
	bh=R9USCrGJ+4HKU6UgA4gZDVR/wfStkmLdQEZrKTMCSmQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bQKYJs1VZyfvWhtIaf5O3BsfL9mru3/QuFo4953lf4DOB2PGpdZuPmxMIWpdqbcsd4jDtMKxpU3wKEiwfJsCCLwMTwGp9WskN8zc0GumY9aPYnZXR7guGKM0aQkSYmikfGwx9InB2t6I2Na6b7npdFc6lKJ/VDxq5Hk/skKoYLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGAwEt8w; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGAwEt8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737771996; x=1769307996;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R9USCrGJ+4HKU6UgA4gZDVR/wfStkmLdQEZrKTMCSmQ=;
  b=QGAwEt8wDgLcjRq34CD6Ue8xgX9g02T6SqENjl5mrzs/6y43ip96ukTm
   n176iWGrYkRwos8S8sB3gO3sZivvdHoewN97QGlsi4beAF/iaGZVAeA5m
   FEZD8ABXi02MXKEQL1AENAb0j288btw8xMd+WhtDXWX+oghyzH1q29+Lj
   wXlhOd+YWNVDDsO+OJTOhBz7weEZGEf6x9TZY0gR05Wg5MZSHMaE+jkPf
   YUtOGI3BY7BfXgNi9aOhgmlIFilIF6rDI1e7AYYl72lX7OZtZQnWoCGH8
   wX22fUdcDQzzjz5AUTV4OT+1X0Yvg6mPenK5GrlpNKxwtYi5/BLdlJqtX
   Q==;
X-CSE-ConnectionGUID: H5HHlkEUTLu/wjMbt1nvhA==
X-CSE-MsgGUID: BsOOwH8ARj+1+ViKnW3hTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="41981598"
X-IronPort-AV: E=Sophos;i="6.13,233,1732608000"; 
   d="scan'208";a="41981598"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 18:26:35 -0800
X-CSE-ConnectionGUID: x03osQCyQy+dgr4QfhJ78Q==
X-CSE-MsgGUID: QbNrvuUKRNCG6KWx9tyZMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,233,1732608000"; 
   d="scan'208";a="108047363"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 18:26:35 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 18:26:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 18:26:34 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 18:26:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLLZHTDUXW2Q4LWVm1rxEP+ESd85Bht+ugWzypWpxLh/RhlZ5tVDEAlFQ0GC1uK2J05vjUMWSw/5ISJWtN9k/6mb0ZMiYZh6ZqUAXTLyFy2KDKQG3x8/aPHP+3ZnkD6pUZnsjQbp/iSf6MJzOC+TMevFwh6RTOa+GdQGeIAiBuXO7mqBoHS+vcuVVFoSBa3s9IbWB0I6YlIng2+6quNzYYIfOA9gsTYY4y8iYi81kCQKcIETPkCCPlorj0eDl9Ji/ux9WY8CLpf314OCNdgosGBCr0Nz+8O3b2OKaxG3lOam3xoE1HEZJ08hWWUNAWoeDNU0nK2MnHd9dUZho7Fgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5TnSWKeONYn82BVSc6VZflOWYbEH4mozwrn9FqkdgM=;
 b=dyCKu3SKn4o4VCepaVtqKpWnXKVEo4+Rg4kam95mcx3qSg8uNf7ENXZMhSzI0gZ4b8iu1/YrtKKoC9x4rwF69dlCK0nAh99i7X1z/sW+o9bHn0RsDZCCqfR3m9FrMUpC3axr1GBacw0KdIPbxu7AshP0iEEyZdHbWOS2kGah23IDex4S0E14C8JbqClFjs2qlFdQVvh07W8mULxQ/MJgQSjHXMiAFierHO32uYJSs1yr3Sw8eTukylwqqwaXtnrumlMiR8OimCCnIxdVe8n27m7QMF0gXBkazlF1oI9hd5fJqJBoRV+8ySE1i8uwFMcYzIL2/FLYxEpDXNJt3LPOqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7113.namprd11.prod.outlook.com (2603:10b6:806:298::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Sat, 25 Jan
 2025 02:26:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 02:26:31 +0000
Date: Fri, 24 Jan 2025 18:26:28 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>
CC: <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>,
	<hch@infradead.org>, <a.manzanares@samsung.com>, <fan.ni@samsung.com>,
	<anisa.su@samsung.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4] cxl/pci: Support Global Persistent Flush (GPF)
Message-ID: <67944bd4867f5_20f32945a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250124233533.910535-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250124233533.910535-1-dave@stgolabs.net>
X-ClientProxiedBy: MW4PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:303:8f::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: af666605-6c26-4041-9b6e-08dd3ce7ae27
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rI1FQJABoNUTl7ltZsf7qCkmHwqsmBEY8dnGJ27CZbIvv2L4aZEHJlg4eys8?=
 =?us-ascii?Q?dRq8whfWkfX1SZ0uGlT+Uty8JDo+b91o++rQptpjv53ET0mSg4EERV4JKNYE?=
 =?us-ascii?Q?tqMh5phWK9fRyU7QT4jPKrWI6Jz04YrZYUPMDofsjs1Y1I0eqZa4ofEiowp5?=
 =?us-ascii?Q?C3s0JSfE0gTUr0xsyaJVxEhaT/XWNvnvOX4D2qqpVlw1EQq4rSjKp3eqaMye?=
 =?us-ascii?Q?3nvDdV3qH3Ri71Sn8QVKzkmZN2ypqsN/HP3d+mq1OCsRG0RYV/5tEpbYSa5A?=
 =?us-ascii?Q?osgbPT/Mn+ioovW88ZNQCQ1oxV8jVbAJYWxyj4hOxHokWOjWuhL3uAh+OeiN?=
 =?us-ascii?Q?vXIhIpLE5dlHWiqCBiKcZx0BfBOmVuisPN2icssx7hISuZlI2bcTZKuQUIl4?=
 =?us-ascii?Q?3lMlcBHalK7ZG2nX4y373I1G9TRhAH3kiEmYEWZnYGWERPyllApbfgCH3Meq?=
 =?us-ascii?Q?VszB3UXNGKVXd1vYGOJmypNAe5Vaer9lQSdLYqX/PWW7zrQ+Cg8qccfh1le/?=
 =?us-ascii?Q?LAvQ4IKPYEtgb9mC6/gcp3Cpdr7Pj0vl4tyqzWSDzp2snPeuD7OVCbcJVdBz?=
 =?us-ascii?Q?Gi3EXxAInOBsxIkF1qopkuYwLYCsq1kcTQdLsv9LYWSub9SIIY+roGwuvzSb?=
 =?us-ascii?Q?cfi0FqOvjaTCEaeQBrbgHfyOisDo2cfiPefUthT+mUiMkrQYAw8z4n0CM1do?=
 =?us-ascii?Q?Kh7n0P3a6gPmZPue4URWUCdHcMVPTrfZExEUmAjKzS9Q8gkeUkpvrZi95Mx3?=
 =?us-ascii?Q?4cEfZuMMhfXXvUiCSg7cOFMcPgXvdDyzJCzNazbzxVsEPDgU7d0A6UUH9IAL?=
 =?us-ascii?Q?Xr8cU4V5wBlycmL4gsIMYOcwY15wFHI6yW0pVyf9XX68KuxdH3DGPEtDoFZ2?=
 =?us-ascii?Q?N2BA8Gz+0duBWMBb48yq7zyQrgG8Zt48lCAGfoLdoltiZOYupqiNYMF953Xa?=
 =?us-ascii?Q?vy9yNsTIoPdh1QaRU7FhXd2ivQ9keYijlyVfRE3wN7pAOOq9GXecwA8BvCsa?=
 =?us-ascii?Q?ijj85OBlar3ow1qA0wfRNo3WI8ZKun/NTKotCqp7HU6JbXg3QeEUTI/klxIB?=
 =?us-ascii?Q?Putmwmni2ffEh8JaqGUj0n91jRfU9/QRTUnTERKtQwabKq7EHhuv71IcRidb?=
 =?us-ascii?Q?jj4NfHHBwEMTpgvEt01QXV5KzYaJopIpvyG2OjP+ZISb6S+8b5oYb86crnAV?=
 =?us-ascii?Q?ff/cYjLp1FVsbEG4tWxQzkOowq071qffJBu5j6CQpGU/mPQCjardPGzXBJW1?=
 =?us-ascii?Q?IC4SjWYAWd0pHhbtoEdemZ5GLzkbwl9guPcckG/q1NQ72P/xcHM/T5uYdFxT?=
 =?us-ascii?Q?/4/p7MRPYKOquD4zF22/rx7FORCrys34Gq/f3a3hWI3B5IXH9k9VL0X53b72?=
 =?us-ascii?Q?kmCYuZ1kmLHTwAJ66GZNYlQOK4wv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YEVvpV5DSwi1tZgNXybcfZ97xJ8rTygOQd+6IL0g1NV6qJCD9ki7SBPL8NUn?=
 =?us-ascii?Q?q+ZhoN8sZcutLfMmtg1h7TuC8SrEBt4448VsDcOBlg/Jv4Q8XxP06hVi1yGa?=
 =?us-ascii?Q?33U0ezk01glUGW0W5jfj+VmyNEPps005qKMpeBEj6y1Sd9VMqO4HA4XWK2eT?=
 =?us-ascii?Q?YWV7v5lmm2ilZozdsJ/Z8Z7YkWFgh03X1ZXzI3QhL8hajArzfqgdPg5vMmfg?=
 =?us-ascii?Q?KRQ5KxAXoIFrRNc5uxo8mQvcA9pXMyMZ8KNaFWGeBvrKFM8bmTyyHxxz8FbJ?=
 =?us-ascii?Q?OYjoVEgqWuWVLf7k6ob5rAG1MHHnxTpoK9S7N7tkLz9LcM3GX4pMizDMeKyg?=
 =?us-ascii?Q?WOtV7TN0WLn4wrXXCFE89ImIO6fwuBWvFx9Caup8DROn34+JzeiSAfKGPQ4y?=
 =?us-ascii?Q?OA1ZFL6c70/BQfI+vuEeJXGqHD6oBHcV0iNBW/Xv1ffEL1liKgyfVZHMBmOb?=
 =?us-ascii?Q?/VpA3587GWP5CwuxOfihsBBBO+vlFeeE+Q5b1rSv/F7TUJbuc5qrNCjPGUrK?=
 =?us-ascii?Q?srLJpRdvCz2vCA3nBfnycvzYVVK0kz9G9pqh72HLSjc+0/ti3rcrDHWbd/ns?=
 =?us-ascii?Q?Ch4SrhLCa5O1cPKhNTGKtchrY9775ekXtpzTvVTwsGoA3K4PzF8OUZNPoWfE?=
 =?us-ascii?Q?tRnNJjqWE6l5dyN7y1JKiZT5R+NwNtCoZ3nPXmmJuL0QL2sLXoCKsXZO35/Z?=
 =?us-ascii?Q?AF6DBNuOWQrWyye3E30cYJs19KKLa7FZwbxGVsrOJw2zf/tKZ56QKSOPN/aI?=
 =?us-ascii?Q?E3le8IEYey5alG8REv/10HUm4OQYgt8j4IL2KlHQNrLVGkSIIe9DTs2mUmO+?=
 =?us-ascii?Q?pxvJWoelcPuM8aMbmEklYO24txfG7R+8N9LGPidchSOb4gHle3xyY/eaXyAz?=
 =?us-ascii?Q?jlkb89DjkjIGw0EgK8utHUsLfm08QzU/RzNAd7/aVXoqd3DvQEorGi0hu62w?=
 =?us-ascii?Q?JMVcxIQJ8YNM2iv+aNDAGngkp4X2sSLVYQkU7zeBb6FNKNcOQ5dXLGup5f+8?=
 =?us-ascii?Q?ofiCRpufntsUwWG8QKee6lhb1MNgdtSM8HPukUjO4dAQU9Gc20PcQT/KONpb?=
 =?us-ascii?Q?Rz74Q/zRwBPg1WSZb4zLlKWLfh4jI+MMHmK23k/Bg0LuRxrrn+zu+MYyyROG?=
 =?us-ascii?Q?XgZOm5gNLtGclP72uIZhima3eJ8ZOAtfLpw2hNk5HIhvdbrRPgUSYV5I3MMb?=
 =?us-ascii?Q?thPJCCumXem3ATZkbgAUjpr9d3LLPsqMFJxHRz3j3X9KgLFCGEN582jHG17s?=
 =?us-ascii?Q?qvyuV6a3sUvFIoRzo6TUGphY8tnKvUSSAxUW6Axe7BqxiuqvddR500bEvXH9?=
 =?us-ascii?Q?ZWMaAhwt9VwsXBd4Ri6ZVQF+oow+wQm+NiPI6WENAANV8zAAGXcn5EIO0GzA?=
 =?us-ascii?Q?RRyOFnS1EDaQ3RhJnEwlU4hYp1qtXoPJaoZzItDzVMoZKhzcouIuM9ZAqUue?=
 =?us-ascii?Q?3eRYIBcY0WsYkHp7dZvZU996CCltw9AgqcY0k3UQj+QlOwymY9RmSdiDcXIv?=
 =?us-ascii?Q?6RUbOZGzCzuNao3bd7ZzQJYv+IenWOB0eoPuVGpl6Vc2S/ltUWxYGMi37knL?=
 =?us-ascii?Q?SdkBTTCzL9vTocSvqbiY39SHcOwoNARyI2s+YNVowhRUsrjy8a0wB6NIdUvs?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af666605-6c26-4041-9b6e-08dd3ce7ae27
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 02:26:31.4665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HnrEH32xhvYlrfBheuRnmRkdIpjUT3Kh0GRV+mvpG6XJB2BPJQ3Yw2LlHs1T8MBeRt2Q1GEa2Djo47l6fmfvTyADiZ3L85WR7llrmKLESk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7113
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> Add support for GPF flows. It is found that the CXL specification
> around this to be a bit too involved from the driver side. And while
> this should really all handled by the hardware, this patch takes
> things with a grain of salt.
> 
> Upon respective port enumeration, both phase timeouts are set to
> a max of 20 seconds, which is the NMI watchdog default for lockup
> detection. The premise is that the kernel does not have enough
> information to set anything better than a max across the board
> and hope devices finish their GPF flows within the platform energy
> budget.
> 
> Timeout detection is based on dirty Shutdown semantics. The driver
> will mark it as dirty, expecting that the device clear it upon a
> successful GPF event. The admin may consult the device Health and
> check the dirty shutdown counter to see if there was a problem
> with data integrity.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> 
> Changes from v3:
>   - no rch checking (Dan)
>   - cache port dvsec (Dan)
>   - set dirty shutdown in pcxl_nvdimm_probe() (Dan)
> 
>  Documentation/driver-api/cxl/maturity-map.rst |  2 +-
>  drivers/cxl/core/core.h                       |  2 +
>  drivers/cxl/core/mbox.c                       | 18 ++++
>  drivers/cxl/core/pci.c                        | 86 +++++++++++++++++++
>  drivers/cxl/core/port.c                       |  2 +
>  drivers/cxl/cxl.h                             |  2 +
>  drivers/cxl/cxlmem.h                          |  5 ++
>  drivers/cxl/cxlpci.h                          |  6 ++
>  drivers/cxl/pmem.c                            |  8 ++
>  9 files changed, 130 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> index df8e2ac2a320..99dd2c841e69 100644
> --- a/Documentation/driver-api/cxl/maturity-map.rst
> +++ b/Documentation/driver-api/cxl/maturity-map.rst
> @@ -130,7 +130,7 @@ Mailbox commands
>  * [0] Switch CCI
>  * [3] Timestamp
>  * [1] PMEM labels
> -* [0] PMEM GPF / Dirty Shutdown
> +* [1] PMEM GPF / Dirty Shutdown

Hooray!

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>  * [0] Scan Media
>  
>  PMU
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 800466f96a68..8f2eb76a3c8c 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -115,4 +115,6 @@ bool cxl_need_node_perf_attrs_update(int nid);
>  int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  					struct access_coordinate *c);
>  
> +int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port);
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 548564c770c0..5b89ae5c5e28 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1308,6 +1308,24 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, "CXL");
>  
> +int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds)
> +{
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;

In the future I want to cleanup all these functions that take @mds just
to get back to the mailbox to just take the mailbox directly, but again
that's future work.
