Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE8C2882D6
	for <linux-cxl@vger.kernel.org>; Wed, 11 Mar 2026 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773272476; cv=fail; b=prDIAT+RI+b7MPWHVZY+xOXlRjz31/OCXtQ9/Izg/ZDuf30+l0h0IBxB0NKxzFMT0FYh5uP4WJF9cvn31jQwqzS/ltrj5Xc5ILgiaWivupzrSuHB9tNtqKrI+QpSMSvsxbMvTzeoSNQWareau93LwSQXcrYkVGNmfoSR2RY5ZDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773272476; c=relaxed/simple;
	bh=MFnz4oWn7+2t0s2mxoKF9xz32TgQCeuEcpTtT9mWnUQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LPKz7a3gpO7T3k2/t2vaKVgOpzncUyRz0xaiPgNpN2NyHTlfqal1z4R7M8NiUTFd9IXJiBsCPe76ZMsH0MDnQs1zEfrERlKMgDiblG+YntUI+QuJgth06VUExquPve2OIN+DYJ8s750MCz1wV5ozCR59zBBwZQ+bS7d/i4dyJxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1fwxzzF; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1fwxzzF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773272475; x=1804808475;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MFnz4oWn7+2t0s2mxoKF9xz32TgQCeuEcpTtT9mWnUQ=;
  b=L1fwxzzFfseQVvjBmJv6zc4r4/wrbAo0s9gr5ChoorEwIbKWXcg8OPuJ
   pdWvs3nYNJSsNzaF77fULetgzRf5/338n58NS24XlCNg22GHsFRKW3HWK
   1Jkty2y3JvMj9d2ge8lvWEe9Vv1HlknR44Y4m9PeMnxOi7Sjb7qkMm/qG
   f8R+SC5GNZFj34Pz6gM+GAgopEcjLcG/TpRd5ODjJ6C8fWTFyRjQSN7Ae
   j1HnQC2IwKjwyhAvMsr1yGMAe5eBLLek6g6VFIqIcixVLOQwnJUn/rFTc
   ijGSNE0mzutFugUY3GzJNTReHIcq4kvfu2GPRm5locmJlK6K4YO1o8TZd
   w==;
X-CSE-ConnectionGUID: W1DQDfSTSx+XplEyKg27cQ==
X-CSE-MsgGUID: 2FaNXpowSLSXJMka/kc1sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85058119"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="85058119"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 16:41:14 -0700
X-CSE-ConnectionGUID: UQBFl3mLScGqk+9tKrbrQA==
X-CSE-MsgGUID: xDTHKyPbQyKyLVfjnISEDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="246115312"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 16:41:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 16:41:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 16:41:13 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 16:41:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBHieRgLEMfxYwS93MsqkCKHTiXAv7par4jDRkLhDRqi3UJy2YWpKwFVv391bJJSwtcFjgu06nHUqcwGXcwKlSTRby3ZbvRozBraOxhZQO5E0XxfzoluR0e8xPlzp6kI5fR/jVgqiyeCRFApOY4EHDEPQe/iu1e9WRsPswPvz+HjgcDSvtJqD22s5w83WhNPwS+X+dIhtxEETHgYM2bsGVz+vRnC6k8gaqE8+1HJhUOGSuPppZPii2DP5xU/rJLbOguOd63zTgN1VdFrJ6Udj15ig6NwQoGmkzqbldQdhVg85/Wa8uPL/jwHppyy0fhWhqBumNBwe1BjXGbMBXx8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rfg2uZzPGGllvf4upfU9IadF0z33koiEH2MBXsB0ZVU=;
 b=S90gSKfmWcpTpqcm3pln6vMttsOB0vj/7wU7iDKd9L700UNbrhwxMRpPaerRNjKlcNuunzybb7gV6Of83RIgXVpiX6OEXckJZpT3LKXDC+BfvDju24b6BU/HyJ6z3XfzqfyxB6Vw090qaLOxWy0MdlDNAPd3+aNznk0JeHJsr8t+iD5zqK7mz+i96DR3MtX+C6dtW9ejB3/F7wI0mgdR0kwqLUG81LMnQleSTnF5ktZusEgZGRBAj21qntnYZfVVxEzp9aA2XVr8sypWViosXX0fnYx9kjJPs6Bees3ggp7cPm7f1jycJNfPBgrSciwcxpQjmliI1VsfVAMLTW6wUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN2PR11MB4584.namprd11.prod.outlook.com (2603:10b6:208:264::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 23:41:10 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%7]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 23:41:10 +0000
Date: Wed, 11 Mar 2026 16:41:02 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>
Subject: Re: [PATCH] cxl: Add endpoint decoder flags clear when PCI reset
 happens
Message-ID: <abH9jumyX8ayixE4@aschofie-mobl2.lan>
References: <20260311224705.3619121-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260311224705.3619121-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:a03:332::25) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN2PR11MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: dd151718-047d-4632-b583-08de7fc7ac43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4MnkQXOxvkBVzvBkrVNPXhEkFM351lOYsZfaNVZ2pJqd4VZgkY8tNjUm8AjAuEIqDF/xA5gx24DObAVk49zAxWOhQeiwoJTQMQ3pK3ojhBfhPIVOWIn+fMt+VZ6ysrBeZv+/WaX0bww8LWfTBkLSstofNAcpY2iUTC3cTFYlvFQ31TmdDYWLTGPnyeFVFrfxqWn3WJrGcW7nYxs9kg0szBAV6MPf+DPAOIdDQQ9PdJgiWtBXnwgbbVJHD+BV9lVKLTWVNJ+JXEO8S2n2ipb9lkrMxjm1wOyWhj20z13IwtdrZNNbieQtqC2WuCXWpUZ7SawhcffY9diwmFN8UAbLirjyHYMfLCH+I1UBG9tNJPhF5qBy1OZZt08QEvOLYMMVQ8ALaPEsDb+cWbglHHo+bznhsMYiY2MtFWG9AskK5C8XrzcahexHMM689+m0Bj8yMQW/e+znru1QvxI00eYkXxVTf0xwSfD07FNH22swC6HeFi0zXUxnoDr6MOt1cW8CVh1UBDTzrw3IOkQJ2e8b4Bo0KPVaf6Iuni6NhVtLwxN96Boc18RWh4IVZvKbzmdOfSgAuDJ2rkn2YjGHalBm6NKubrxBAx4dIx2/2k3ELknEodAkqXBGrHwqGiq+ddVA8TiZbhye8EOAFE/z3GrPHCpUwdJPuMl8KmFit4Psk3R5knlPVQJGOdx/RRIDIOse0mjvTFJVsHTYYadFl9qyENMduNF0vA3zTMBdQhPiepo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m+rpA4vVt4GDCajWAgKikWb5nTEnsz6ZgU2gUq6CGCW59XWW7Q9ZLyGFnRvb?=
 =?us-ascii?Q?Ex5wVLvQY5xZ5Q4/AT0baw/8C22uzbeChsBfBBOv/5y275+aHfzsmhWro0dH?=
 =?us-ascii?Q?CUCr11IIRP4jgYae1Cr2np161MqyiNjLkczlzVZCAyvYVAWirDq1wlSHF73s?=
 =?us-ascii?Q?HKHCWsuCxMwTct6GHZg/hpXECabYYvZnhatEbzHk2+jyxqsw54UyZ3d1VxJf?=
 =?us-ascii?Q?2upTMGHbVpVwDhRCWL94CxdgFRDIb1wlUlko0J9pmYvWLz5JINfqFxOmHVWl?=
 =?us-ascii?Q?/8BpSPL9CEbQh2iugTWxTMGIm5HZfGq1keHLSW/DotgJOu+2/Gci2nxOeSQ1?=
 =?us-ascii?Q?S7X+y+mnIy8Vg0BJ4/UFSdnnBFqmy01f8DVB6nD5Dhc+FLbUrE+5Vy6AaFTG?=
 =?us-ascii?Q?zIGrOPzAiEvUVREAj9jlHjARHo/U2edq4CsCP4Wc4EeSXkLMswfvlxjg4lRC?=
 =?us-ascii?Q?rrVSWQxYjGfLL2SR5GVYMVxpdyBi6rV633nvOFVaGMBggGnif6/XnFG5aYNd?=
 =?us-ascii?Q?VCAtrxrGKD9YDFch1JoE9g/PoeRTyMtKP3mV982x2kgqt7MW4cSQPcOsuIb7?=
 =?us-ascii?Q?g4yl2uxnsAqG6gqzZmwfp9DiahjSnKq7/plkg6wmiai1rXwWAMDD7GdJ92x2?=
 =?us-ascii?Q?Ffb2cckJ9K+Ta3UdtoRwK1MbIxt5TWvC1xdrgU9pOvuEiWhttAdRPTrxGPU7?=
 =?us-ascii?Q?jSbHEUx6uHvx3v33ao1XQzSWqs7oPOsrnNwVvAy4SUSSJkuzu28TfypDkEq3?=
 =?us-ascii?Q?j5uNRtfgR17SSmZSQHwfimMPF1zdftwH4iRsRjqGm8HDvbrdfmjL0XyHTX78?=
 =?us-ascii?Q?Rs49wC7W90Hy6NwTfQE6lvOuE6JHynenvsOGLrgMmKGM6HxGv3pehKa9vr9G?=
 =?us-ascii?Q?koDUXZ7ce5Pr6ejlnp+Wspi3FHhky/v0CjOUbxqgDxHeUOzL14Mcx9+Oge0n?=
 =?us-ascii?Q?4bT4zidCO/tMa3OpSB0vhk1xTZmHf7jed7NIlEZJv2nHk1pCkEJkUfS7UTl2?=
 =?us-ascii?Q?qO5cd4t9GoJM6HiH6uAS4Jm8dQcvO9yBM9bH1KhOHFLP6BdwgqAQ+5q/hBO7?=
 =?us-ascii?Q?jcJRwadXqxWy7YQ6ca70H5+9hQEC+srckJxqi35mtL6g3rPEziAucWlhG+6l?=
 =?us-ascii?Q?7NyczZk3T97rAzEuVXZzBZqHf6iUqgHNgOhSYfjxO0nWPpYXIZK/pzArIix1?=
 =?us-ascii?Q?mwwoXaj2Uk9gzQrzqjw8D2qh83fOXGSM6e/KJZ9Gqgb7xPqCbVGM/QjHKyHJ?=
 =?us-ascii?Q?X3nqxbRUPsG3yoSBbemXD7I0a9vCvOzQkCeU3X9KEoEdWKZSCwG1DAiSpbMY?=
 =?us-ascii?Q?xCo1BlkiEB7v4wwUUoj4bCbNqIacLRmq/4xuIHMMT4Z4GgvnC8eVXSHu0d3J?=
 =?us-ascii?Q?tF5lhb4Zv0fTaAIWHxxZi2Gj8uwMaWLaH5+fmkMNhBI97Ox8tNsx3+H11BtJ?=
 =?us-ascii?Q?3a+Cr7Kq4K97/qzLfoHGq5bDFSnYmSQtRsF9I+yTkz3az+c7YYO4uIpS/2mV?=
 =?us-ascii?Q?kwAy2Rb+Fru1usCv28aCeypMWP7DmolqG83HUfKv1a05DflFj08rZoac8pID?=
 =?us-ascii?Q?OJIsp2s2Vb60RDic7LUB3rfbLn4OqNIeIia1UtZj5V+Z97tKvL/sRpfGUdXl?=
 =?us-ascii?Q?cXOnIX6193JH21TN9Lcnw8K7bmVbiY9ZPom3QgqfwaiyGF0zRzgrc4mropVC?=
 =?us-ascii?Q?p3ulSF/2yQr7FZnDDmRYmtkA3T5lzeJWpWFuHPlE7Unfe9I/H07UHeKyM/7D?=
 =?us-ascii?Q?HfecBp9JQa7N7EfUctbZ3JRZ1wlBo/E=3D?=
X-Exchange-RoutingPolicyChecked: d3hY1G/UMA32xVDdabZnNCceUgvI2l9mkcYO9kG/tmCIyALvaf2MLPDC2eL/v1S66C071Y6N8ar21K08N7B7s8Yo2SKazS6l2Kf6yWPdefG7loD2WGAHYQpC7M/etP7kv4Q9UVbU7Kagrq/2O8y5RzdibEzDhAKTMD4sdRG+cGB1Hn1Rg2Be7eymPpbxZn5bll0Ja1a3MpjJiJKXyMbiJETsu6h9BIIMPQiEnf9NGcL9uZbe0AilOVqgr5Qdx8xcJN500fQvbJKrcBiNfuG/yrhkU5xQawhPCJYUMjh6ysmvi8r0Tyk3uvULHQxVHnzTzIWDQkuYNBvrpRhdI1E08A==
X-MS-Exchange-CrossTenant-Network-Message-Id: dd151718-047d-4632-b583-08de7fc7ac43
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 23:41:10.0725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3boIYlqYAu2JDjsUPdVkza7O4cIiEc7Hv6aswvcMSE9CWZENKoBu7D35ehMlNSmmK1NgFWpaTpSCf2f/iyjercnneMdQaTZFYfC8JtFPuWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4584
X-OriginatorOrg: intel.com

On Wed, Mar 11, 2026 at 03:47:05PM -0700, Dave Jiang wrote:
> When a PCI reset happens, the lock and enable flags of the CXL device
> should be cleared to avoid stale state flags after reset. Add flag
> clearing during cxl_reset_done() to clear the relevant endpoint
> decoder flags for all decoders of the endpoint device.

Some opinions in code below, but with or without any changes:

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Reproted-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/cxl.h |  1 +
>  drivers/cxl/pci.c | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9b947286eb9b..d4be082876f2 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -333,6 +333,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  #define CXL_DECODER_F_LOCK  BIT(4)
>  #define CXL_DECODER_F_ENABLE    BIT(5)
>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
> +#define CXL_DECODER_F_CLEAR_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)

Maybe the RESET_MASK to tie it to the reset context.

>  
>  enum cxl_decoder_type {
>  	CXL_DECODER_DEVMEM = 2,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index fbb300a01830..ac71dadfee7d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1030,6 +1030,19 @@ static void cxl_error_resume(struct pci_dev *pdev)
>  		 dev->driver ? "successful" : "failed");
>  }
>  
> +static int cxl_decoder_clear_flags(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxled->cxld.flags &= ~CXL_DECODER_F_CLEAR_MASK;
> +
> +	return 0;
> +}

Above is close to being a reusable helper where data can be the bits
to clear. Then the name cxl_decoder_clear_flags() makes more sense.
If it's special only for reset, decoder_reset_flags makes more sense.

> +
>  static void cxl_reset_done(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> @@ -1045,6 +1058,9 @@ static void cxl_reset_done(struct pci_dev *pdev)
>  	guard(device)(&cxlmd->dev);
>  	if (cxlmd->endpoint &&
>  	    cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
> +		device_for_each_child(&cxlmd->endpoint->dev, NULL,
> +				      cxl_decoder_clear_flags);
> +
>  		dev_crit(dev, "SBR happened without memory regions removal.\n");
>  		dev_crit(dev, "System may be unstable if regions hosted system memory.\n");
>  		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> 
> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
> -- 
> 2.53.0
> 
> 
