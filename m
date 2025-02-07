Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB94176AB5
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738972049; cv=fail; b=ge62n6zviFtrIydjyWtk/kKYgpbXAp2YWxLtJ5yraWSiZ4H1jeCMDixIMsbhq7N8DxlrT9I34y9W6G8KvBjXJYFcH4GAUS/m2qqQckMmemtnkcEbwGPzIHglaqmqW0zqzSWW07q9dE3HEBOiyokNqyjY33KuT9g6KlcH/Jzfjzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738972049; c=relaxed/simple;
	bh=mlPnluzNr2ZSK1pztKEq3+ICJr2l2gH+JdB7c/eRPPE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ialinZceQsvJlkAPGS3zHNG4H0gztJ+aQ0kDMGA2Yu0OwiuLOUNQwtVDLgp2J3jdq0zTJbTcYKI48N3Vsp19iAormD+Y0oOIQrrP4Z6SFK6Pl8NZYt4kk67iv+ImUT6+rr+9K2zTFOJ/nLoZvsuHm6DiJOCI6ckQpG7MVcMI4/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFW6+WqD; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFW6+WqD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738972047; x=1770508047;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mlPnluzNr2ZSK1pztKEq3+ICJr2l2gH+JdB7c/eRPPE=;
  b=cFW6+WqDqep++tJtpzSVK29sRFBNuMw/4iJpL9mrnIPxOIRl9Fuom7+3
   ucnZlvDWLrvcxR6UVFioJPeYl0dMxz6ukaMGO82jEQ51u0ryE+6pKodd8
   y9OiPc5svcul7F+bMrXMh5RzHDR47guadDduEwDATENXe+tOjhNBM4vPS
   1bu3mzFhaBOlhPBHu8YfU7j73/g6a4AV3FbXrPFJKSx/BjEP1GCnqPLKG
   irZn14hdYJ7VDvgRvgz3okBeKdjEm0ooQskzHioWpbgON2eBLmthW+qFf
   Pu/7VKJyQSMkqCRrZO16z98bAh48bTB1+N81O8TEMNRAIYJI82KwT8TEk
   w==;
X-CSE-ConnectionGUID: +wV0SWrKSpixhiDqeSNe2w==
X-CSE-MsgGUID: 4++zgl4/QAGua2U0Ywhj3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50264113"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="50264113"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 15:47:26 -0800
X-CSE-ConnectionGUID: PnGwPjz8SUWFn/4skj/j+w==
X-CSE-MsgGUID: kxree/R9QEmtWroeWANEww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="111432175"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 15:47:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 15:47:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 15:47:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 15:47:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6DZQUcsUZ9aZhW41Py9mAiwhScaHekwF4kQzo5OzjpzX4fk5y1P2QrUVYPBowetyDGyLstDFpXixHWh90G0m7akYULq5epxsERjeU+wyF/FmRTxf9CiRBtmFDKHgJFegURF4ZZhFSCWyHM8f254kL/gxmGDk7HiUVNZe+m7vxgJgCoAqm4qTUjvBY8M5HmDUPShecKGX4ybGgskmilSGf1ovXZuZKRUTABLb3wc2qDFvp+RbZW/p2bnpkEc5II9k80BqWx6MDg60lKUPmRb0/GjYUWCgOfc/TCoFNNuAs5Z8WGIWzyEzFwiP3YBiZ1VDIQPlyfPYL2a0Ke/7jHVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lA8oQ8pdQq7h5ncfZ0MoDsjUXcEMkifH7hP8NZl+WkI=;
 b=cUjR98ZV+MeJGIiywwuI5+l9dhNnx3FNhTlhIcvKhJIBZBJIk7BaZy6KcNwzOPcUhad/rTq/CSMKF2YFCW5HeB92Fq/NkzsFKvYfUXF3fUK4Qy+kRzsZNou817wwatDNh4LraFKvbY/qQo7mihU3Qyi9h2ZYXAOOHUTiLMYyboXcZYt3SPW7A9DmBuVyC7eAnGGJgVwN+OVbqlTI/ysYDJv0ja62zaZwTW6qRhL9L/ybS3z5/a1hx15cWCPjAJDQHQGfJkpFco5w1K+dQwzMsyImo5c1PMnAPbciQwG75C6i1fvG2GD/HYXXUUmSLmaDCDlyhL/w+OGX6iiv00bulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB8074.namprd11.prod.outlook.com (2603:10b6:806:302::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 23:47:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 23:47:18 +0000
Date: Fri, 7 Feb 2025 15:47:15 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v4 01/15] cxl: Enumerate feature commands
Message-ID: <67a69b8390da2_2d1e29426@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207233914.2375110-2-dave.jiang@intel.com>
X-ClientProxiedBy: MW3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:303:2b::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 495536de-4384-412a-5118-08dd47d1c1b6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oZ5R8XjciHZJoMUGdcwLBpwYm9cRXvQunLblHzdxjVfsxlOAAHIB34j0xSe4?=
 =?us-ascii?Q?yZU5v3K2c55PcTGU850aYO+mcp4A/HPjV/ZIa4XG5aGN2KmaTYs9l3LU0C7Z?=
 =?us-ascii?Q?oAfRPrUfxmnVyjuEf6xAx5SU2UBUKW+n4Q46Ng2wMB3bLudKX/fooBWEJqhu?=
 =?us-ascii?Q?WbFJp7Dc3HzbUUhYzPDHqZof9jny07+u8geqWHNNucN/WJxX7+8w/AvUcBHy?=
 =?us-ascii?Q?YcnikK6DWECXEV0dJ3CjgXcJaDqyDPjLgCLd0tyI0d0lb2pGaZO6Cm3Vc1kJ?=
 =?us-ascii?Q?sru9Wwbb8qv0PYmM/5r2X9zr/7x2c+WaOpULhD3vTl6YO2Sit7U/UekToPpB?=
 =?us-ascii?Q?uqgyLK9f3zNQxtAor7CaTWMeBt+as5+Iulc6/FfH25M0TtR3yyzebsJvwlND?=
 =?us-ascii?Q?voZMPTJZJmzZiD5UimCeDkDWezkhrOUkn8NL3Q4OR2LYyv7whfIsv1dMcxtw?=
 =?us-ascii?Q?aWd+2xeJD2L8um8qAK2pBvZeCNRkH58NXKGcQOjIF5aTqHCzfLCA+fmrwRvk?=
 =?us-ascii?Q?yvIHpVD8JljK3LEhbXeQM8e8isloniiB/lMSUXNVHFidamnd4qkv/TeF9Gy9?=
 =?us-ascii?Q?UkCgF+tbse+W6zYfJ/3IrJUdUzxHLrlhcHhs//xld1fwLcKykn1BJPHsBHHx?=
 =?us-ascii?Q?5oT4UjxPA3LggKOAYjgwy/BSUCciav/4z88PMpbDx/GHy7Dlm3JBpm3ykdfm?=
 =?us-ascii?Q?fpfyty7wPQ61XTJeEyacvvp5rmWPYebpED9ZfxREfstURHEHmXImxLzTChJ8?=
 =?us-ascii?Q?gnX88ikasUXr1y/uJkvvPxiQR+kbpwu4hiCvjKtXcbSSXMcXQNEFds1A9G1i?=
 =?us-ascii?Q?jcU8W2SG8eSESi2ltGukKyAtmJSiJqWr/ghmp3IfmPTawx2ar1d6q6JeM+/a?=
 =?us-ascii?Q?yFEfgxIOVX8pMUNdAdk9lpwq5txgFu35ZfxO4eTwG/NG8yh9aBR/5R2dMv+s?=
 =?us-ascii?Q?TzR3MnWgLfjh/BkELf3RLSc6KG5eJFFavIOkC7abAq1YrQGJcx8caSliu+sA?=
 =?us-ascii?Q?hXDspdDnrfrogfaBaM+icAfvMVzyKTpfm+TVnaXg5cLS8ez2tp8aUrlJVT1q?=
 =?us-ascii?Q?1aSL3Toa5n33bHtVSYACZ8w2jUYTEqmoqWXTO5B/C1/+J9pZvh3pYu0Bk0x+?=
 =?us-ascii?Q?Bn24bct+ilUKOUoPMum7UVxp+IzDE62UsiyqtrPnS9BbtaQEWll8blR4Qe78?=
 =?us-ascii?Q?V39jBwAxah+UGOTXTL4nsEn2PMPNqwutZwgl5rFchfDvUaZ2RLtCgak8cTKD?=
 =?us-ascii?Q?m6VyU6RBzX4mII9wINcZnSWzcW7ri7YqYDSKDW/qJEMMK6FbfwOH/Wi1qOZ3?=
 =?us-ascii?Q?5MsJaKoY4nendmQ2YXuRTdejKtZsQRC8vNWyiGjdtjRdkM3m9lIaJvmaxtT2?=
 =?us-ascii?Q?8g1gAJ/xAoBUg6G5r4xLvFYj8wny?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cGpexwT+iQ88yRe16veKDClFqMTcxhv8+LHbrNRhtOkhvwo+h0hrRuBh8N7g?=
 =?us-ascii?Q?b4RSm8/pv034HYr6sCenjTMYFzO2Abr6UVr9MOAWeR1M7N2mZ7JDbBltaHkY?=
 =?us-ascii?Q?swu2f8T0AaNgPrvEXqXaWOcMkaQ2WxydgoYjymhjgAZ8P/DdmJytZmGHcslm?=
 =?us-ascii?Q?g8DDPDN3Cr8VtQMnTJSKRH7/KwV8TuG6+HJzYnyngM7r4UiiryQkK698entC?=
 =?us-ascii?Q?RvYV2f1euiTDNf/7vmCjAYL5Iwd20rl46e77JxXEez/3ucL64EYSMZ3ihvQd?=
 =?us-ascii?Q?Jk7H/hAymT6URZp3qIf/+kFKvfcFCLgLK/XRwJjw+Fex/W3TaBK7Hl/f7S+m?=
 =?us-ascii?Q?LHjQgQ/56JphwtuzWiU4XpAHrPdFw/Okt7tdz9uxjOLOVNLFBMV6izLx4cb8?=
 =?us-ascii?Q?QwdAHrfGu0uzadKdj/geIzMIZQ36uhDFSv5uIyuvybv0cbbmEtFUOtkAmYGy?=
 =?us-ascii?Q?CDkloGSOr3JjN3Y2l+ayOHnR3gtTVF4AIwBJjbVnusTC87lkeppsMYSX0lgv?=
 =?us-ascii?Q?5Y9974RddMpryr8fIxY+CvUnDZZ0j/5N1IHNPNe0T60iffjIRR4W1aOYQQKO?=
 =?us-ascii?Q?5sRn68N5XQ8o1wD7h3Vc5XEHr6pW6IavxDy+uzh+u2p0IXXc4/fkOGtEXhtA?=
 =?us-ascii?Q?Dea9fWp3LV6y5fGIvxhHXF5Dlu8pK5T9FCWrWtEJUj+6wSNO02p7sTzmr+5V?=
 =?us-ascii?Q?zTPqaa4IVUIL4S2LWmRQnHrhcfsrc0lY1Hd6OIjvyBesvLMaGzvQnCxnNen+?=
 =?us-ascii?Q?MHJl+OYnxATNzEpoPDjTNStThhTHGvO0atyXKw+f6Ye74RjfV4Mq+AgfSsYN?=
 =?us-ascii?Q?1+rFTaYHLODH/xaN8zsvWUnZididOp0Ma3avMd/4JR7tIWombzzkSqqWEU6E?=
 =?us-ascii?Q?SoGZpmZ5UFEgvzaF/KAhxjuPuqltW1WOZqxuIXzirJFyJjNqunS/idGsAN2/?=
 =?us-ascii?Q?wmUUPO3jxVC4BYG4Dveb8HgZjQrqzWoPO8SzNVMGwrlZunm4LIqXnw1DhDPc?=
 =?us-ascii?Q?9BDrExZXJOiRgXPiBHyN6hKSIvAsxmnAvAE/8TO87YPxla1Ft9KqOkXXlf5V?=
 =?us-ascii?Q?MTrw4UPGaDC9W1Ip84CqVEwpIJFC+3+og74U+UkrAKakTyVEG7kFiKw0d09L?=
 =?us-ascii?Q?aVb/NM9T+zmvn7t5wsGmuLQhlLEIX0QTw9ztk0uHhUjD/w3ZOdFCm87XP+cC?=
 =?us-ascii?Q?TgrWMmA85mBgmt/3AUgTypYRtlgA7Dvks7i3Jo8H/Rk7ecMl7074cmIN6XWG?=
 =?us-ascii?Q?hu54Jw2JJOHHAodFdJAVAW1YmPBY6VTO4RG3J3f6YDw2GZC4jkHizP/BNGA5?=
 =?us-ascii?Q?bexYheN/x0JHIImyHO3uhWh9U2ELWnmcrP0zouXSDpblhlzwGFuVclR5Vf72?=
 =?us-ascii?Q?QoCGvQAH7c0UiK5DTEaE+N7scB5gvoPFZgfnI1bejHn/XfHFVBSnjhCEkPd8?=
 =?us-ascii?Q?Aww/81yaQz7s71ML9DF2DQetjLa6s3AWeSkPtSwA5WVpki/Ao5RrIb6p1BZH?=
 =?us-ascii?Q?6u9Zwb/IKvviXJW7AlDFNNeylRDqJjVAHcCxZFa3hmMSzrK0Q57uJtBwC5+H?=
 =?us-ascii?Q?poq2D0kPRAs0whKdhW0wcNrMXTRavVnvucDhaFBIrRIzZB8ER3cKABN1XM7a?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 495536de-4384-412a-5118-08dd47d1c1b6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 23:47:18.1604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCCP6ImlXIeJThXsbdWB62g6voSxAV7Rp4YB+zt22WH1N0QUVKQWVJyyrDTowNUna0GYItzewKyIluxUZ+64UDwsVZO73nT+SwuW8WMGl6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8074
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add feature commands enumeration code in order to detect and enumerate
> the 3 feature related commands "get supported features", "get feature",
> and "set feature". The enumeration will help determine whether the driver
> can issue any of the 3 commands to the device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
