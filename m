Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F228C5223
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 02:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719453892; cv=fail; b=tGZhpqGC4uPj3JPt5a3DTKV7MuiRqwm5crMe87yeXp9iqJ6kj+PvuD1iXJ5lMB0qHhNOz1Q1p8pxHS1+wjBfoAudv6vB4PjgMgI7iPQ27c2LVOTS6E/MVky4tALyMl3xHji9HdglX+y1F7jQvzlPszX3qqCUTOZ+Xxw+d+ZiFtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719453892; c=relaxed/simple;
	bh=zhbXIw3XeWZBiexTNreq2O0vrdZPJIzcqB5AYjxgA10=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e9/iHEOPQ6EN3VFjZgEktpqUyxNlfIj51wOiJ2LcoO85TrosKvpN482N3biwhKu67lm0eUtuzWdfZINfbDsnlDuJlqOKD4HK/2GHTnKcrxOmJP5W0I8n8SWVx5OvHoxyhZeO9mYQGhpUORTjJkhItwwv+ALF9vY09jlxUNbynog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJNAWDS4; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJNAWDS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719453890; x=1750989890;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zhbXIw3XeWZBiexTNreq2O0vrdZPJIzcqB5AYjxgA10=;
  b=YJNAWDS4Htcm1cerksBADpZEr9Imfby1n9sxOd8JvaVwoecqMr7QBXfI
   e4TWxKVhAXhBZ4soUVi4GQHuCVmeD728LlIogmWPE3wHQFysWX3didiqR
   mdFui5AiCkFTLrTCUw2ub3pJGh9bc4s+Pdv+u0qqf/HwdbKMM2Dw5Pefy
   NQ/uckckOaK/pIv+41kehFYOoGPVJZG9qZgwqrcdaDVxxdv8ZTm1jRcwT
   /1MZOnM9J0jcB36PLV3tdeya1JC6GtCdrcmrSXFFSsiplnQOxdaA0hsPQ
   5jlN+BrEEGE/ClqGmzgUR23zMBlwVg3Z6i2/T863Cu/9p/+cCiIlgd2ye
   w==;
X-CSE-ConnectionGUID: 2RbxXt/ESai5FRj+l4vg1w==
X-CSE-MsgGUID: Ucb9nZEmQg6kzMJ/Y8NLqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16517606"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="16517606"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 19:04:50 -0700
X-CSE-ConnectionGUID: VDYLtGdERJedieh1R9cUVg==
X-CSE-MsgGUID: dx5eDoCbR2eCfgB+UdLReA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="81762139"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 19:04:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 19:04:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 19:04:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 19:04:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 19:04:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lE6l78AV4BN4lvYmHrqFn0MjKTFyGIQG+Y10O/PSflJgzNRYLVVsKF3NO31bch+RlPkXeZm15WoJVFUGaaa2pHDa3MqHuwQ4uZlX/3uhwGxtX2Hf/E1LTlFkXOyoGnOfD/RgCVRPQRiMTZk0LOCzDZmgRKKJEk9bgv9U6YAqgrYFjw/tQ2ona3ct0WDAkvbuJ8/NHpABJv1qQjKKDRysu5RNLfmXKS19IsF8pgX+7iHiuSqjlw9dwp6obRoNvgBdTOCrDAk18qIFM1RJKu9riCfqkHXKKNRDctfFmD/7xrg0+71ZnKqtw2J3ShZJS925ccQFJJVq+FvXtzVpgzO/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98m7jysKPH1fCTwoIjfmUhtQ/81EN74cCUKWbzpHcB4=;
 b=m9eWxYP0ETw2jqBaouYU52nAktKNlm2IuQ3NjW6qu6BzPuTk8OreO8AAb2rflnE7q/ECpTWs35h3MssvY0ZIv21Y8i8+WgMjtHZhIgxlGy5y3NnicaS4xX6NgGPObLUkf7QBRMDu+O7n6YhoyTdlPKnVUSoaameO2oBuGxU+NZjt76MzSXsNifFzHH/HG/8Dtu2UF8fyQFZ6NwKmW0MoYAaY1y+EKpptkt36vnKogsrFiT/LTYPTzqxr4rScGnYba95ZruYUuRJlglijMpjlQ1amogndcgRmqtzFSAlSThOf7IZhrE8lQI3BbgQoy7zcr6bGCio2g+eFxDSgYuYFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6488.namprd11.prod.outlook.com (2603:10b6:930:30::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 02:04:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 02:04:40 +0000
Date: Wed, 26 Jun 2024 19:04:37 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Diego Garcia Rodriguez
	<diego.garcia.rodriguez@intel.com>
Subject: Re: [PATCH v3 2/4] cxl: Restore XOR'd position bits during address
 translation
Message-ID: <667cc8b537c2b_563929486@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1719275633.git.alison.schofield@intel.com>
 <e36eabffe2c2e1a7611cf8ba9ba8bee435bceb1c.1719275633.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e36eabffe2c2e1a7611cf8ba9ba8bee435bceb1c.1719275633.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:303:86::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 5883d545-b7fa-4b36-ee34-08dc964d80d4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3cLQ0qg/ik/Vt7yevIw/94Fm/rp11PIR1xJbeLV0JdtJ942xob8yTq8wjZzT?=
 =?us-ascii?Q?GbmcSNGadMj0I6jGfsz91vfYb5k+o+vm80TKIxFX4CuqPTEe6xixvoJ791LN?=
 =?us-ascii?Q?sf0slDntTm3Rxr9uSnIupIlIUYNhxgmomkq3mvDxsjyQwEV/kBVannuiEi0h?=
 =?us-ascii?Q?W5oNJF7q/bNmIomfcSWZIyLEjjt6m4H5du+dI7WMM7tz91G7IFacfKeT7+Ga?=
 =?us-ascii?Q?NXzcnpNig5qeF0QS8hSAhZKGFYSS5vRDjURSoGUsUSZ2WyrYVWTgMnbbL9VI?=
 =?us-ascii?Q?iCwORrmpyyOlK5FCLNoj0vWbLfxoO5GWY2gVljk5toCbrXHZxo9BRS4mmH/m?=
 =?us-ascii?Q?vrIzV/00ZX+PcxaZCjTF5DQEAP00P7RZhRAACR47LKvV4xQqMg0FzfV0whvC?=
 =?us-ascii?Q?66ZzqpC4Dch8LNS9xatJNfTqKDEazb5e3KJhJQ9aJxiuudroz1dtS88cxYl0?=
 =?us-ascii?Q?SVW4XU0SmX5frf8L/neKG9FjVSYzUhUCnf3GLkre3bSaDIXRNkNCD7+fUigR?=
 =?us-ascii?Q?vckctfEDk9v9smv4bKYYfVNjJuXsP3ehlqVTcCyQgKX4GUVjs2hQ+Jccfv3N?=
 =?us-ascii?Q?MTXvV/xMnh2VZiTxhJ52+ii2QR3QhEz3TYIqqcim/qVrhDhOpzhRvUpq14xF?=
 =?us-ascii?Q?44mTbOolZY1kuzWkiBnBL3SlZ9+MXJgYsAVwdyDhTO56aU7GuCF1DguehXp8?=
 =?us-ascii?Q?w7bZWZkDRTsoZ9wiT03EqWXbt/0+Tvdj/ou6Xlp1Wi4Fi/jyoo8rUOhV2Mbe?=
 =?us-ascii?Q?qehyDY2nPvZIJ+vcLTmdRYY2P5PDTD4TQBpKOkliqCTcBEmqhqLEmwgoTEFh?=
 =?us-ascii?Q?m5Mg2okTDToqDfEtGilBLLRpYNzFhhQ0Ams+ciXIoPZuI3Lb2Rz6TVIqMNO+?=
 =?us-ascii?Q?nSt2nJ3djdh6mqMo0eIbf1Mej+LfKZcHCfC4qPsaCeYI7uqc0pNuf2pToJVN?=
 =?us-ascii?Q?J+Hz70G2q2eokY+gUJ25Ar/zH5ZTcmqKMqB+B+0eFQG/JGnnfYxyqGvoI+Ed?=
 =?us-ascii?Q?8YHAtKgOZPiz+o8o+oKmUWBjf0PTvNe2a+X7Jlb0wWNo+A/OXoJYacq2KdNS?=
 =?us-ascii?Q?naNUJ94gO7MVkz4GhrOA/Gv1ByuxAdW5HrqU+gC4Zp7y49TsCc1T5pHE1ard?=
 =?us-ascii?Q?pF2WmyMzl9iWd+nvbZIILnexq4cNSeqeBbKhxR8F4Ur+KWrzZGf4mnExtTkS?=
 =?us-ascii?Q?euZJqkfKH8TWegN3vw1F91QFoC2hxDctl6B8ZLpq58ea2JnUGhrwE8ZxfVgg?=
 =?us-ascii?Q?YNfPe3jsDWNBQXb6V1KSwoI9MQWJ3JuJ8tSptSVKFFg6EA1835gAanHr+Blp?=
 =?us-ascii?Q?w90=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zQaFgEASfoM//up2T8AufPz89qcHV1hW69esa42MTjT+5qM82Ov2FNmE+EGR?=
 =?us-ascii?Q?BWTxOGBpetpFKlOzrc15lI1Vu/+U0JLPQsrx4RqvwELKRG0qeoFQ9TclBxoy?=
 =?us-ascii?Q?Pw/KaGNNbktw1S1UiSlio3mwaRBd6eswVwEojz1fBdxi5MBxMa29/5QqTvM8?=
 =?us-ascii?Q?Qatqq6MdRLwoKZkW0IQSFybJXEn3pMZaYO7scojnDYu8TeJR8dubXaVg1WtH?=
 =?us-ascii?Q?OWTWPV/TZtPMZRo8oES+uDg0+g4Hqs9B2gexhG2DC6k8ppvbpldt3XYzh4+f?=
 =?us-ascii?Q?+IlGZbsDCJGsSruKXlC2rrrpuKKQ8S4KlpRXYVRP78O7D4lvv/grrtyJoJzH?=
 =?us-ascii?Q?AQRnLu/gmtUY2GL88CcR272U82h0YWGPfn59BrSLi5uvbk9LXN92N2n1sCvL?=
 =?us-ascii?Q?0D1UWKqndymCmR1/aQIQ+ORgGiTeTmweE8IJHYQNYMadlq3zHDb3JG0VkWTp?=
 =?us-ascii?Q?H7Kl9EuGIUjbJhikT7/+PkaPW5ytlFlJo8bGC8hEpHUBLD9FgJZ4Sb082jZ/?=
 =?us-ascii?Q?E7apGUthWZ1fHF71HAEj2HZdG6YsMjkQ4pA4KaQ0rVXIYXKTX137wo33kud7?=
 =?us-ascii?Q?NNqzZkFWkQWeuqCyDjufMVFKU+EaPrXDRC++QXurmam2KfumF7PLg8udG8aN?=
 =?us-ascii?Q?gjIDm4AfLPRhBnPjQHbYwM5dctWi9mdPosqe9NZXWsrxgPgGQCugT+vGs7Bq?=
 =?us-ascii?Q?ZJdBm8pk2vHR4g0Qf6yEQvXl2ZTsYUQwpF0xOVe7ZeShjI/TIO0mS6CuuPD+?=
 =?us-ascii?Q?vif5j91Bs2prVLzeYVA6phN2NcbkrCCuvcuY4sW5WZTkpUAztyW6RzupI6XU?=
 =?us-ascii?Q?wIYfMuLQMJKtzvfldF5rkgsm5GHBVIqOa1KVJ5k/mgRN1aXjNpuvY6LnhQfv?=
 =?us-ascii?Q?G2XZKJjR64/Djyyg6nGgwr/3ugjI0SbOZY6benXpu5se7FhOGQZRsU8K9Jqm?=
 =?us-ascii?Q?vk7iy7/Uw3X1pRuBux2GGN2pTk0ThG41XGtNIRmbgXvv5G9yJej2HDV+jfBF?=
 =?us-ascii?Q?oaUeMFOOWmJtAfIS18BRmmcck5MPwen67VxhxwOcFUqtcra39zQee5p5eC96?=
 =?us-ascii?Q?iVHQodjs/GvuAYgys1+Y08FrN32f1HV2em6TUYaH6f0UFKZDSn7yhAxsj8ST?=
 =?us-ascii?Q?4Ul4IpHrMcqhbkUS79TtUOyaHVtYlzj7jY6+oDzGoviJwkfCnscgW62F0ICf?=
 =?us-ascii?Q?rCprzZH+Wwpn86RYKaEK/iWh/QMxfCaA7QAaFpebgCbXYTxx4F5qO6TGtPZG?=
 =?us-ascii?Q?lIMD4BetnfCy3Q7S/sSqHVvFDiwBpHCdwG1F8/R6ZknkSM4kzldvJVzmFXMG?=
 =?us-ascii?Q?IlwaL3WqZgyDB239yX9K+ucM70ffrwS4+9RcAjxc3fpS0SxMw7hh0TkTMTFA?=
 =?us-ascii?Q?1OI8ThFcnoTokAuvHl0Ivh2A+L3INIfNd+STpioOGBPftmoxs+VReO9sX410?=
 =?us-ascii?Q?KIV9anEKD7G0+NJzM2io9DUm09BcJiOa6SIj6AJlpoqhvaO+QvPbZ0n/SGel?=
 =?us-ascii?Q?1tp9b653Q/L7u/X+VaUsEYbOuw5bjSL8PwY4rkfJbNKsMTc0yssOQldKESgH?=
 =?us-ascii?Q?qKDUz5LKWqNkz8EGYhbTShIsz+r4YkMS8UiCmSvP2PUdplZwF3bOBINC0/s0?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5883d545-b7fa-4b36-ee34-08dc964d80d4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 02:04:39.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RyYtMpS9F5mFdo1niHL/ZYAgZOYkw6lgHSZoszet1HQx9Ivl2nJa+k3VjcTiv8TU9zxRld7hggRHbIXZgwNoTj9EQia/r9Gzw8KVLu97dU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6488
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When a device reports a DPA in events like poison, general_media,
> and dram, the driver translates that DPA back to an HPA. Presently,
> the CXL driver translation only considers the Modulo position and
> will report the wrong HPA for XOR configured root decoders.
> 
> Add a helper function that restores the XOR'd bits during DPA->HPA
> address translation. Plumb a root decoder callback to the new helper
> when XOR interleave arithmetic is in use. For Modulo arithmetic, just
> let the callback be NULL - as in no extra work required.
> 
> Upon completion of a DPA->HPA translation a couple of checks are
> performed on the result. One simply confirms that the calculated
> HPA is within the address range of the region. That test is useful
> for both Modulo and XOR interleave arithmetic decodes.
> 
> A second check confirms that the HPA is within an expected chunk
> based on the endpoints position in the region and the region
> granularity. An XOR decode disrupts the Modulo pattern making the
> chunk check useless.
> 
> To align the checks with the proper decode, pull the region range
> check inline and use the helper to do the chunk check for Modulo
> decodes only.
> 
> A cxl-test unit test of address translations is in upstream review.
> 
> Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Tested-by: Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>
> ---
>  drivers/cxl/acpi.c        | 48 ++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/core/port.c   |  5 +++-
>  drivers/cxl/core/region.c | 22 ++++++++++--------
>  drivers/cxl/cxl.h         |  6 ++++-
>  4 files changed, 67 insertions(+), 14 deletions(-)
> 
[..]
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 603c0120cff8..3678235fc9ce 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -434,12 +434,14 @@ struct cxl_switch_decoder {
>  struct cxl_root_decoder;
>  typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
>  					    int pos);
> +typedef u64 (*cxl_translate_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
>  
>  /**
>   * struct cxl_root_decoder - Static platform CXL address decoder
>   * @res: host / parent resource for region allocations
>   * @region_id: region id for next region provisioning event
>   * @calc_hb: which host bridge covers the n'th position by granularity
> + * @translate: decoder specific address translation function
>   * @platform_data: platform specific configuration data
>   * @range_lock: sync region autodiscovery by address range
>   * @qos_class: QoS performance class cookie
> @@ -449,6 +451,7 @@ struct cxl_root_decoder {
>  	struct resource *res;
>  	atomic_t region_id;
>  	cxl_calc_hb_fn calc_hb;
> +	cxl_translate_fn translate;

So the cxl_translate() => cxl_dpa_to_hpa() rename was good, but now this
name sticks out as not right because this routine is not doing dpa to
hpa translation. It is doing extended translation after the modulo
translation completes. It builds on the assumption that all address
decode below host-bridges is only modulo math, but that once the HPA
reaches the host-bridge it goes through a second stage translation.

In other parts of the driver this host-bridge level address has been
referred to as an SPA. Most times HPAs and SPAs are identical, but with
XOR math, or with AMD platforms like this [1], there is CXL HPA to
platform SPA translation.

All that said, lets call this method hpa_to_spa() and document it as

@hpa_to_spa: translate CXL host-physical-address to Platform system-physical-address

...then the code reads better:

    if (!cxlrd->hpa_to_spa)

...then it is clear that this root decoder is not doing anything outside
of standard CXL address translation that all switch and device-endpoint
decoders support.

With that rename you can add:

Reviewed-by: Dan Willliams <dan.j.williams@intel.com>

[1]: https://lore.kernel.org/all/20240216160113.407141-1-rrichter@amd.com/
