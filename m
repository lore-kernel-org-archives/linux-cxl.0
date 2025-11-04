Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BE523A99E;
	Tue,  4 Nov 2025 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762225484; cv=fail; b=IQWeYmu0dI6eprbYLHaVVzK6vhN7MCxjwIW3RedMqpSb5NIY0yUE2YQgaalvBB/Nhdpf2MBpPVR2En37jQbRelRzqrllVbQJtbkOw8M9UNAPol/gt4oA0/P8gJItJiBKwo0c+GJ/XBCsKSg/cH2qvkkb+C52prvLUH0qX5bH/58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762225484; c=relaxed/simple;
	bh=j5HHtF5xOiFuy6G92VKQT8hk3kxkhMIV5hpvCTcQAC4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tGlch9wzWW+aEZOEOBoEJ53rsFr1kMsjaSGdcIN65p0VhcwOa2hfcuqIGpdcbTNOAQ+N893IHNFNFtj+1Bum13whu+b6ix8XZB7kdjhjAu8d6H2Bn1+E7HbsOwlMKmQm9VgB5fQyTWWeG7SNti4CGic/pmveTrCEEDyHjrYa0A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J39ys79D; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J39ys79D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762225483; x=1793761483;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=j5HHtF5xOiFuy6G92VKQT8hk3kxkhMIV5hpvCTcQAC4=;
  b=J39ys79DtgyFbXV9gypbzZFYzR01RL/nOoVIIOAZ1TmVgXHC45aY73MP
   7hwvMHmOSrYy9L+Rn/0FwYHT354zR0v7kYTbL9K4hnrdJ3lk9h5UyApY/
   CuigVdLLAtxXjx8hXwP55aHvwxu4pfbyH8SHuW6omI8j7ojZnin9draPd
   k9tc3FgIoDgLEVKoEL3Wm52LJ2105hntlZDW6hDA7DTf1FW9GjBN1myOD
   17vNKR55QMeIdzsR4D1PDZ6YeQqnokbphqkFnvTWq+N0DaA+UkKhvMrtP
   kgeiEu1KgrWHEsx/uZwOvaqfJ5lNQ03gRk5zRgg/KgcgB0cxr2MzUTmMt
   g==;
X-CSE-ConnectionGUID: /Zr0Ar6nRnWLLhamprxwPQ==
X-CSE-MsgGUID: 40apY/z2QfmZjxZMvMKPWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="51882523"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="51882523"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 19:04:42 -0800
X-CSE-ConnectionGUID: 6Gq1a+p3Rrm/AjBrJs2bgg==
X-CSE-MsgGUID: 6t3SShbATGqJNaARXB37lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="217675904"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 19:04:42 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 19:04:41 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 19:04:41 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 19:04:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRzxSKGvbh6JaUoSe/gbjjxK9s7QH55SyfF81V8vFc4hQxroxTVOcRmUM4NNGTbmmmQT+LnUcVsG+j5QBmAkGcF2aRKIbYQ1ng/E5qVeO3NKReRxpjHyVsOAky4BGwKfTMJGNcDIGI+QEnyoPrpRYvsk63daFw0Yl+XsW1qD4tHviYAkR3TX5J3fGJN3cWO2rRp3WroMfdzNbGEbqhBLCNDCN+63AqPmrib36yyZPKj+WmLkPKeZBhjIbTToZc7qGAQeJMMw3p5m4ydDMHmBr4PgpCBCUUP3JPkV6d9h/OBUq4sbWPEnZG/OF1ITlFXUgfaiv7PD5G4UGJXRseEGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/W5UwCCHZmPZ2uQGGbQ+Ekt58FrlAeqn7d8W/hPRK0=;
 b=Vr2EDYlBS8fAxTRuYWJHfx4mXY2SnNM1NG2KgjZp4UCAZYV0CABePYX3aN+korx1YvHmo1DdR6su8ofs/SMAQUE98Y/m4vVRBVIjRg8V2lf4MmuCQOQEUILDMaXH9yoh1jd5lqItoTpaEp3tWr57Kp1gKIx3ckXdFxL9cFaz2dFjkh9dmUHKpSj/7tvaMk8WEARHBYLQpiYdKxCc/h5E7c9FE7zY6wE6MNlqNlwy+Zw6NcQFo4tYdZnMqQqTeTrHzIhDi+Xvn0GcMg5AloI8onkPPMns/yPh0oh7+LwTltOFWKXQexCukDrCbhwhBnWyAj8kNdjVWd2eoJG7rl+miQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH3PR11MB7300.namprd11.prod.outlook.com (2603:10b6:610:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 03:04:39 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 03:04:39 +0000
Date: Mon, 3 Nov 2025 19:04:34 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 04/14] cxl/region: Add @hpa_range argument to function
 cxl_calc_interleave_pos()
Message-ID: <aQltQuCZZ-eckUIQ@aschofie-mobl2.lan>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-5-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251103184804.509762-5-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:a03:333::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH3PR11MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: da5d2ac1-abac-463c-d7b9-08de1b4ee460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?udqQzkvA//O6tFLOe78xeQ3BKIQkRLR3YilWoohscr6XcUNKRvEGcKx3zZ3g?=
 =?us-ascii?Q?w3f0mJY/XS4EZb+0PwY8zV9LYlGJwafTQz3HUOQlLmQxm0cPwHQ1BAH8ZlPm?=
 =?us-ascii?Q?hjYQCoCFnJizUYXxXYCNazQ99RPB/S7+3GF32J0JGMq0umPkg8Lyn1Fkm6yx?=
 =?us-ascii?Q?Fh3uGH6AervV+tUlzjNOPP8Ieuvpn1hbHEASQUXpTwRDl49+qIlK/z4Wa2v8?=
 =?us-ascii?Q?oWWc2FdruWzzlTmuJh5GeiicHJt+iz610nqtc7v8rFNd+niqHexDZkzaqCBG?=
 =?us-ascii?Q?AH0XaIy9VoXBQ1TgCsF3+fMzV0rssNWwTbOrCzGF0qfbart/OENXzU8P/1c7?=
 =?us-ascii?Q?t7pCQmP1xv+jdMaopuM81lvHiVu7/l8KuEMF/aALXp1a4Api3lW2hMsmIy75?=
 =?us-ascii?Q?YrrrLXANSvZeD9fdNsODZuWgU5wutZgsU6VR8XXqQla8eap+3CHnYlB/FVXM?=
 =?us-ascii?Q?JfjQIi85liDKaFUy0m6h7m+TGeAmMNsGbaT1TOp9Njjw4EgulKnuBh3ugKdz?=
 =?us-ascii?Q?Z8g8p4MSH1ovlzzXTAX0OlBigLPn9uTzRAxKGOE25No6qQ4bclQQD9Lw/Eki?=
 =?us-ascii?Q?ek1EshrpVW8ofFfadQ7NkYps7g8tZJlXp4OFhOYWMWuR2XmDpJRuauKyZZKS?=
 =?us-ascii?Q?bZiphmlz7jxUvRHIRofTumNuUFhq0JYMVkEK6/xPGki+SVsV7mQA/AC87SsF?=
 =?us-ascii?Q?TgAs6Z54eGG8QtgM5KUZcYQW2iPVgM7cmkwWpwHlchwgZ2QV/nRsYNDwcl8Y?=
 =?us-ascii?Q?/WKbol6ieCvEbqDDHR8OKF/zCo7LLi5Wps2mI8++Dn0A2+5bwcV7HUYsWvHg?=
 =?us-ascii?Q?WxQZkEO4HGXxUTjuV128FNylew0SUBojk4pEbBCcsj4rWYnB9+792gqm4oKf?=
 =?us-ascii?Q?t3/2l2Mf16aq+OCtG3LvYOGXnd6xeFoeQ8/0h4V/ghiLipFPi9f0Tz1GB8+h?=
 =?us-ascii?Q?vBhrLJZmvkr01giSRQWiuM8PUlLoZgr91OaQn0e0YV2JuF8Z+Wym5yZgl0IT?=
 =?us-ascii?Q?7N1fle4A9ivlWIrsF02+E+vgwDktAyNVk73/cULq+P2Nj4Hu+jeJ2IZ4pzdy?=
 =?us-ascii?Q?Dn7Z12q9tAxzQmdyzciRqT+pQL7Eu31YOhKuFutg0/bYohCd0zvcXCz+rbYp?=
 =?us-ascii?Q?TNWozD766cjU4bzy7SS8w6Xja4Xj3PVoc6AgGFx5M762HFIXFbIIdJ96CqS5?=
 =?us-ascii?Q?Wq0GAwMplW8ImY+eCRcn2V4/wsD0H47s0RnBRk3ZHE60Mzbp+IbEVIcNDhIM?=
 =?us-ascii?Q?m+6EWtE5rkGsyWNn2fCyose+093Xa9RSrbVc8sSTCxb3j/T9OEt+zhVjXQS2?=
 =?us-ascii?Q?OUeA07eKGtRY+9mKniRs8xPYrJcejG7Ddxx2zv122xYbURRye6McfiwC/WEF?=
 =?us-ascii?Q?KKuwjt4LF0/nluMAAjdwb1puGa2a6JTPGBPibPUSbDmR9IRDwH+6QNZp8Jhn?=
 =?us-ascii?Q?g964wa/enBKPb58YLII+mInnuf/Sdloq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MNBzldhEvVVSLyrq/CZSLmxANZZAR1hg7Si6i009DB73SESwT08a9KVXBZuE?=
 =?us-ascii?Q?gp0C0DXcqQ0DKYjs4lkRzEEImKX79QaMdFDgY8sAYhC/n2lhlmrUP1OFoXUf?=
 =?us-ascii?Q?rdN7SKMjxkQPVfEUg17b+UgJKd6m3t2jyO92wiYJCu/SeaG+ZyfEdFPgyxFe?=
 =?us-ascii?Q?G178tpsavkTxp6Zxw0Kraamh0O+UVm005PVyxGOpdL1qUYUQsSj2pjY/fQ93?=
 =?us-ascii?Q?GXChFgO0UmDXJ07X02FRB+akFjhYOQxTIRatGZg48gJDPZwG3i8FHeZHcJ5W?=
 =?us-ascii?Q?gdLi2vbih5zo8p+06evmcWptmx8uUThPTyqdhSSe72ZrqS3ZxRedM+aZe+Zq?=
 =?us-ascii?Q?EIL88yVx9bmhGURYDMtY2sX2ezaiks27KEkM/hCk2sKXnysM4MaQMQERrl9L?=
 =?us-ascii?Q?truBVoNmAboX5sjo9BSBnrf9oMBb8he/O9RHEdC+Wth3aKslJ7aSQ63BlZAR?=
 =?us-ascii?Q?iZ1g0Pzl6lIjcG5UFw6Feem2y5pfYEOIkRxF+Beqnqg6GY2cmZt9w3BldX/F?=
 =?us-ascii?Q?NRrt7RxWb9pBq8U9c7PXpte7Eo9XZaJrgPYlMH6lIiIjqVw2pag0hjq3tEYx?=
 =?us-ascii?Q?QPft2BWlhO+Sb+mNzSWW3DFTC4WwtwC8bjo4mduWcQ62UoNyWL87KElEyOwq?=
 =?us-ascii?Q?dN/JnrfAz2QmxmNYGdpeVzlxl3hGCFI9MSKp/NwgcBo/MmXCNB4Y69Vco7G0?=
 =?us-ascii?Q?mLd1SKGAtIBjhqyzKBI1pQHNqwboRRUjLG0cfzMemMtR9CU7qZugC+wh260W?=
 =?us-ascii?Q?id2fU6vhGFV62pD4nNDoExTTe8W3fScef2RSmcrqwX9Emq5xpowZ14unuGPb?=
 =?us-ascii?Q?Z7+hf6PLOXCEdyhsiiDym1NDvPqqq+h3h6okdCOYy8YsS/eJLzJnycnIrynl?=
 =?us-ascii?Q?A6r0dRw/yALkO9AQnb4gfo5CYS5/DHwXKhHZgYuhaz2OnNurzNa7AGpFt8fm?=
 =?us-ascii?Q?LOdsSJw/0x9P16fErqG+XCbuQL7rEq9EoLFDfZ8BoeGFmwhW3z/4L9jcj50v?=
 =?us-ascii?Q?q2cyjVwYvI6guZbq2xVk0roTVMjI28UPtlPXUDNaPFLiKYyFLIuCCYlAbTQ7?=
 =?us-ascii?Q?wUQn/AHsSOTR7cw4Zx4jv0C4zvaStEoO6xYlnKO83N7/ghG7EChQtydbgT14?=
 =?us-ascii?Q?ymYyFl6BE165gD6VKJDGRRObdPfrK/OxsMOpJDRiKaCFkPZfObstzC2bQrjj?=
 =?us-ascii?Q?2kr79tEXvt1txwxrGknIeq5N1Ucyh7tmK21mEuF6ec0CdqehIwekCa6emZmq?=
 =?us-ascii?Q?9KgP9lSs6p/XrFHcD1Hp1ZHpdVlMgQr1wPoRFPiRyPLZ968kGLn5CSmv/R9Q?=
 =?us-ascii?Q?GAQLCNXxEhCQLgRft84E3kDTm91TuYaJUzvdVhVAkm7+hyBB+zJ+8r33IU5Q?=
 =?us-ascii?Q?VTht+OuAsoMen1seLINBpLgWshevgBjeIBA/UvRa4m5Sa87K3w5eHvf9ZWy5?=
 =?us-ascii?Q?eMDo4sUNNW9+fHGixWG8q2YEfOaSjAdrlQ3B71g/4WYmV4PUg3Xu8maaEZAM?=
 =?us-ascii?Q?46W646EdcVLx/yAy1q2I4YGqlibAC4ifpK5qHJ1YYmfH0bvbbHYf8XBaBZ9A?=
 =?us-ascii?Q?2Og7w+7yl+DkQU6iKxR/SisNk9iC2m6eVFy55uLfL9MM2P8BYk8kO/cagWKX?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da5d2ac1-abac-463c-d7b9-08de1b4ee460
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 03:04:38.9493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0N+32Rv+FTvR5SGWmkygTTWxK9gwE0fM8tlGiE3U6eQIQ+KzJ4fsc7ffa/Nictc8YlZL72xvUYOD8UDxUvwAWQWC8rUA4dMLkVBAqYmoy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7300
X-OriginatorOrg: intel.com

On Mon, Nov 03, 2025 at 07:47:45PM +0100, Robert Richter wrote:
> cxl_calc_interleave_pos() uses the endpoint decoder's HPA range to
> determine its interleaving position. This requires the endpoint
> decoders to be an SPA, which is not the case for systems that need
> address translation.
> 
> Add a separate @hpa_range argument to function
> cxl_calc_interleave_pos() to specify the address range. Now it is
> possible to pass the SPA translated address range of an endpoint
> decoder to function cxl_calc_interleave_pos().
> 
> Refactor only, no functional changes.
> 
> Patch is a prerequisite to implement address translation.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

snip

> @@ -2094,7 +2095,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
>  		int test_pos;
>  
> -		test_pos = cxl_calc_interleave_pos(cxled);
> +		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);

This is accessing the new hpa_range that Patch 2/14 started storing in
struct cxl_region. It stores it only for auto-regions and this is
a user created region path.

So the fixup is actually in Patch 2 - but this is the why. It shows
up as a bunch of dev_errs() from find_pos_and_ways() running unit
tests that create regions.


>  		dev_dbg(&cxled->cxld.dev,
>  			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
>  			(test_pos == cxled->pos) ? "success" : "fail",
> -- 
> 2.47.3
> 
