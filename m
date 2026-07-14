Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C6A3806D9
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996836; cv=fail; b=Ev4g8LjRIjspyrhJ759m1RZKsfwnfWE+AjH81JdFswtYMjvXEGwd734Ak+8lW1qBi3u5hMNt0lMzITUjyo1p8rS32rfG91X19vb+7mQIL5M8l3kQisddpaqHhfnKQj7ZfLOlUTTjPLR1hzYV4+HUhtEUzmCTNui/V5u49WLd0bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996836; c=relaxed/simple;
	bh=dTuBFcLXye5G80quktmEAqNUSsOQA7nD8ZSf9TCcPd8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sJJyT0CWKHHhlfd8owJJ2TiQmDPHR/gfGePDm+51+Hvd8JrdsoRgOyFMIt8XBKS8HZPY2wxCmK91+61pWIXekQw76Jv3cNr8k90vsasyC2AanTBVP96ENL9kizUrpKi602L/PO6a4s20mTUNm8wVdTTXfKu2pxMDg9ZgKR4ID5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qn2FfkBS; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qn2FfkBS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783996834; x=1815532834;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dTuBFcLXye5G80quktmEAqNUSsOQA7nD8ZSf9TCcPd8=;
  b=Qn2FfkBScKuqNLgZTNN4vT49eT7MI/UyXjfB5Haqf6vYS65GNksW8rl2
   dggylQwaVgtm19EDi/OTZc3EuHzNX0rx+KqBFGLnTJ3xK2bM0353twk8x
   vnIHpNjL97JYnm4jHkGtVt04gdZpEYDpADSZ1soDY3F36rELuw9FmNwtO
   q+WxEYeDW3rxeZiAAsvLKVhuGlb53a5NvfkAdGvAVkcAKB+4oQGUCAVn4
   8Ar+5pfUizAOZKwbi603ozpsy7E1zqt9mJ+e2X30aC1Dp/L0OwYBqFaAR
   FYifYBo3nySF2x1X6kqOY6iSODSp42RZAG4nIPpudJY6sO6wcDZROBEmn
   g==;
X-CSE-ConnectionGUID: KZcJsoEfTfiVuol6aAE7+w==
X-CSE-MsgGUID: 5XYI1y5UTGe9ALQF+/iCkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="72135962"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="72135962"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 19:40:34 -0700
X-CSE-ConnectionGUID: F/KRzDPqTregdtwBgwQ6hw==
X-CSE-MsgGUID: I3p6O1KPRka0Gi80iyJppA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 19:40:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 19:40:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 19:40:33 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 19:40:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSj6HFLIkdldH/uzuxawzrXOk3j853dpUfB3ELI2gdBUzOi7PPTo9E92zxaD5/7uzSFBTCRQPWkL1dOYdM8FAr1T7TwqrBs3QRNGOANuYPJgim5kCTuZGkDIs0Vuecva+SpoSKriPugVNcs+DmMKQM0yq0laucA4BsUt9kgjpnRYflZtQiSzPK26s3iezKJ7P18iA7GDuoeqDPU26Q8U9dTyq+luYgi0yMG9tPhmRTWrhAESorVbyo8t0dfujNYu9erk6oy2DhnNgRrTTn8xQY5pjrRwfo7PfCgh3G6q++Ae9i57s99YChTCeQYi14FsCUW02RGvvWQwKjm8HjFZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpISfkZtNeoZssBV83iCfOjdM2vvH22socnnBwO6zXY=;
 b=AMlAXUda+I3CKshanowVPpmH/5tZmyChYdIh2q+Imes0jg/y4F3p/v7FPMd1cyyDVhSfbhMqoXBp0Oy/59zpHBrIErskzawVfJz8FJVvJCbKtz2avvXrBYRzmtMaRKxmzScTUapw1Pknnrpd+D32UfT0sKwTZ1H2b1I7TTpCW8qiaqmo6cAFRK0CNPrADG8eKCTegFlbwiloBaJfi/VmBUkmc0YQPxwpcXDJD00njjcXnVe2nxxGMtGcXszfaQWQ2ixArhTs/tHEoPhIHxEHXwIB+w7Gq3rubDMNwFjFR9InnbnhQg4BsTuVZOG6QSwUSEfOe43q/c8yFNHR7a42fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB6493.namprd11.prod.outlook.com (2603:10b6:8:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 02:40:30 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 02:40:30 +0000
Date: Mon, 13 Jul 2026 19:40:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <dave@stgolabs.net>,
	<jic23@kernel.org>, <vishal.l.verma@intel.com>, <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2] cxl/pci: Honor -EPROBE_DEFER from component register
 setup
Message-ID: <alWhmraULWuovQvK@aschofie-mobl2.lan>
References: <20260706224322.714934-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260706224322.714934-1-dave.jiang@intel.com>
X-ClientProxiedBy: BY5PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 189ee61a-649d-4f74-3cd2-08dee151452e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: y2njdRRk7VQSu7dg+Pl7rDM+k8x8CG0tvO4eWOyN2w3LFsPTRpHZK4vZWYwfBJZbU5//Z/YiyCKrIntDfGs5o0rxNkzUfzM7H3998rEF8oSUDi82+0EnryIyR8Dq8T+uS+2abwygmXoXWtOIrk4XHI2FL2hscMReMOAbOMvhryZXvkx1TpylVHElF3uCfzeyrgxrtmfsBYwMg/Aoyb9B6XRjghPmLAd6zEau4jvX6B1fV8SGXZcLOv38+nFgUPOW+dHS68+FpLDYpKNAV/4jA+DDlanEkk57KTXSKhaDDJwqoO+23f21Bskw+hQKeYWr6AF/8utVYSLZzfEDohq6k+HHaT2/vBsR+zWVQs4l2BivFPVIZso4L5Vdgh5/sSvZ17dyY4tCEPhIHTV0XH+6ezQBnHRaqRT172bepuWyfB7InlJV93efhcRlO81dsx8TW2kiaIMDpMCh52ZYRKv+Wgq/lVSY+sKNQk1jc7UkBADL0ZGztF44Sjvh9mo1UsUh7Creid/zq4ASxZXyF6Rc1FCoJ7gxFvxUpB8WPnxbv1IVwyma152rHEIsVomsqPSZxkKT21K9sXXZ7z5QHeg0ukWhjRxN7ppXPhtoEQj5j4O7+I3+oE+a+BsXUYTelA9CVhW9y4q6gdMTv8dJ98dag90A3HCL/Kt6VBzi0xG2umI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7TlVNvc2XV7GmnoWHF2plsBrtIZBQ2P0MBOUC4huTC3jaPueu7V4KbiFCkAC?=
 =?us-ascii?Q?k9lEzub410047yKzTpnufdKjWRTyBLSX5xXY8A5Qg7Us+u5gLqmxmpyMENcf?=
 =?us-ascii?Q?51IbirPXoV9w0gGZ6wCBssjNDojivfcJh+ct4dGf7LSvPvT1hGfczTNxqqQS?=
 =?us-ascii?Q?jDoOBpnWt3QwkUu3UXbCKQJCtxNB8j97vxAKY5yToREvKvHuviTKHOVON5Ii?=
 =?us-ascii?Q?KZkPwMvxjTkAHXKM5JNlCeMk335iltC9fR9JmE3U6AuZlnCi8AAM6qIh/tHw?=
 =?us-ascii?Q?+H7gWxZL6tEnGaUAdWSPaBnfTev8mQPwooBEih4JM172/56/VLq+kAc4ljjj?=
 =?us-ascii?Q?vo13yIc4+OKiCyjmUzdrAqzVCEm7GOqFhXYoCVY+puYy+FeaOdBQi8xu4DhB?=
 =?us-ascii?Q?LsQJmWhQFC0M1WJLjuijaYS4OphfGnPuz8A4tHhqz25U71ckc7KOdPXAVNj3?=
 =?us-ascii?Q?VMIa3VN5Nbosig1OoamHNgROZyxiSdygjyYwJ3sJoDK63JmmMIDUbwTjpAFB?=
 =?us-ascii?Q?BwMo/MYdZkVCn/1iogceuVDwNj8xCYFnj4YkC3wWOlffshd0VWUp7p7JFkrK?=
 =?us-ascii?Q?CE7uGl3PkS0/YT64x+WFoPq2oTdUjMR2rGJDxcsiYn39gKTtnm/90KBfebX7?=
 =?us-ascii?Q?zGxQZw6U040OKq2Vbihs4+7FNCLYu0XCWJke7Zj/KprIe/8D+Z9VCU5ZrxgJ?=
 =?us-ascii?Q?IYuxA9wpleQaqL/3NKd2x4rueBoSLL+Wdkuh8pT+4/iUi0z74QzALf5SVd9v?=
 =?us-ascii?Q?u16A0CZCWga1MrJmCAyyRRz6ct238i45PZ4npMmF15xVNKodznHvSy5vxias?=
 =?us-ascii?Q?CENDp4yzOQdv7H5HGW1p7CwdLUc7c5URQitOYPj1wfPCb0lDT4FZcW/NN5Da?=
 =?us-ascii?Q?8T7Pq21H3qfLtGVazSc/KE5sZIAw+UiWlwapQKaNFyhRTgAxdhN8334qhOaX?=
 =?us-ascii?Q?Po+cfJfxMoDeEmdO8p8CopsSRh2q2aRFxCifmJ1XNzzrF1MdrsHFDZRivTdz?=
 =?us-ascii?Q?cq6/rtmuta/tmvr3csgIw8i77Dbd2Ihlz3Nds34pg6c4TrLMef+rBt4FkPSO?=
 =?us-ascii?Q?XCWa3hWPjSeYXoUoVmk1Zp2xzjVmMjIaG9PeGC+EKmDWsoK6N6pR8enoocdi?=
 =?us-ascii?Q?JiRowmp9Jf57KcJTTCAW2vtG6RMKgeNiPfPSnW3ewBOiv3zXMs4RZl+T6DPP?=
 =?us-ascii?Q?fCs0EgCExIbph6gnB7ryKn8GU7DVjp/T2BEkHrIczbV0GyrzZv6T9qx04ulR?=
 =?us-ascii?Q?LYbdvrjxejeJX8+dB/K3fjGIU1KAP1s+tJ/532XXbX8kHwqY6M1oX5q4ZIZx?=
 =?us-ascii?Q?IFNGkXRW8MfkxSLkxIO3P2QyeXlhyD5ZkDrb282pzYxZiof2TrPqn4N3CgEk?=
 =?us-ascii?Q?g6W8B9c1wtWUFX3EiNFiO5AXvUIUaQnOF3ubpptvEEUcmLL7ofRfjMLqKPGH?=
 =?us-ascii?Q?rs2yp6QUHANMS6TPzMcOPm4l0By61NyO4DW/pjVm02b/BN9HZv4NRatNgily?=
 =?us-ascii?Q?4GLpKnS2w7wzwcB11aQvBzGloTlzCrVtujc7dkFQUPT9VEdpw9ZuHlTA8mA3?=
 =?us-ascii?Q?TV335X2RFoJLS4eqc2j9qK8sSSWd6B7oICPc/FmKzyi32yTQsnCEBagtDnF7?=
 =?us-ascii?Q?M+ua+juO3ztXOfwirPUBhQoOQI72dNH3iaSPkd36Uk4VTg31Kg0QTioFXAhD?=
 =?us-ascii?Q?MMKgLI5mWB708MfObgEchP7so6zkIH/h7+xITNzvVcKwAa56eui2cYK/P80I?=
 =?us-ascii?Q?1OTqr2Ro3Ny8ZGV7XCMoBBPqKmdEHow=3D?=
X-Exchange-RoutingPolicyChecked: a0vLFkazivkZAijsoh5JDlCKzRh5Ey8s0TDLY074YaKpY1LIY4kZE6otzSRFQzHUBXTJPNCqL+V1h1S1TXYMvcLZsvKZ+90zvGrkwOo+z/TqLLIbSSIhGevlYG//Ld9nD/vSilOmck5O3/lcbcjSOG0VYy8yJZ8Be2IbgANv+L/5OafD8M2zH1Rz2/p67zD+nQRfHr90m7wp6XQAecI3dYFnJDsNvvpIX1T7sc9sug4dA8i9oZHwiXZeE4gWgiBpoPfKAJl09kmLFkmvtylQerVQy7GJ/F9p5ejvETDSIpDs91cxDOQyf0sk0bTaQdMLO3KBE5ftGSv24Kxy4VpIpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 189ee61a-649d-4f74-3cd2-08dee151452e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:40:30.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RY6JdnonH5lzflNMdVSxWX0W05uTY7WZAFPHXcBKOkOhkSfPFI+wNTZIO3mc3ewAR4sYLnkOgIPEjQ0RuOC+XzkPlrklWddkYAg6Djrq9Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6493
X-OriginatorOrg: intel.com

On Mon, Jul 06, 2026 at 03:43:22PM -0700, Dave Jiang wrote:
> cxl_pci_setup_regs() for CXL_REGLOC_RBI_COMPONENT can return
> -EPROBE_DEFER on a Restricted CXL Host (RCD) when the upstream port
> has not yet been enumerated and the Component Registers must be
> extracted from the RCRB. cxl_pci_probe() treats every non-zero return
> from that call as the benign "component registers not found" case,
> logs a warning, and continues. The rc is then immediately overwritten
> by the subsequent cxl_pci_type3_init_mailbox() call, so the deferral
> is silently swallowed.
> 
> Return -EPROBE_DEFER instead of continuing so the probe is retried
> once the upstream port is available.

Let's get this one merged, and go after the Sashiko pre-existing
issue in new patch.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Fixes: 733b57f262b0 ("cxl/pci: Early setup RCH dport component registers from RCRB")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/linux-cxl/ajzhsubot_PSYtHQ@MWDK4CY14F/T/#m063bbf76b1c9c293ade52ab311018ae6bba11a44
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/pci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 267c679b0b3c..6a132a6c4c5b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -829,10 +829,13 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	 */
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>  				&cxlds->reg_map);
> -	if (rc)
> +	if (rc) {
> +		if (rc == -EPROBE_DEFER)
> +			return rc;
>  		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> -	else if (!cxlds->reg_map.component_map.ras.valid)
> +	} else if (!cxlds->reg_map.component_map.ras.valid) {
>  		dev_dbg(&pdev->dev, "RAS registers not found\n");
> +	}
>  
>  	rc = cxl_pci_type3_init_mailbox(cxlds);
>  	if (rc)
> 
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
> -- 
> 2.54.0
> 
> 
