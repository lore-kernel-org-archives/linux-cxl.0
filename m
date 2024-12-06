Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6E91D6DB1
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733465625; cv=fail; b=VWwhAaWcYGcu0sCFiItyE28JZ2V2R5Jg9p/JTHSoOSzuDASc68jTgEZJ0hKZ6N74DNTDVc7u9+NdL45bunyERItZOaYhJfvDeXcyv7edASFZtP0I2r7UWagnM5cIvPuah7VacBYdviN8aLqLr6mk92tRISFr1xeTWmLLf6JMt2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733465625; c=relaxed/simple;
	bh=DzhYZBPBZpZ43RsV38K/xQJRnN1Ek1xmKUiPPuJBW9c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qRS+2iRkr5MQVXWoT7lJKrzCv1m2V4EeTFYMdVx3GCZeHNASIJTA8cscmUddMqOrF84DJPzwW5diAB9TIWEj6Py3jQmN8MB+EqHfm6yl8f4JfF6U5R0fHC2fLo7KD3nihri4au0vwl5nTHMpJB3tms46HSR4v34WOQBoLwr67cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRl+9sEh; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRl+9sEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733465624; x=1765001624;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DzhYZBPBZpZ43RsV38K/xQJRnN1Ek1xmKUiPPuJBW9c=;
  b=dRl+9sEhZANF6Y6SsFT0C9e/+lBjLFZHxLoaeSWs410co6mrj4mLApBl
   f1WGJzvd+gkUtoLxNdyYYi0TbuRJjWooRJyD5ubnaFTTX2o895q+v7vEv
   jCCera58gNVKqz1yy2rb+DAviu1ND3SW1m3Lj9zFBmeL8rYms3LbyK6g/
   PbC8v/i8ht5u3PO02uMR8/NFzoONyoBX93h3PT7b+KBbvSzIdZac2flQH
   7S5k0SbVhg28vY4Y7oN9sRnzFy1icJ0t/ikdQu3P4fxq8h+PbOSLp0Bya
   F50xJV+0VGU8JlVnc6qIyLgwbUMI9mNPnKidE5Wv38aTIaKzWYkfjnaYy
   w==;
X-CSE-ConnectionGUID: LpHKyf0TRNCkLQZYv3YQIQ==
X-CSE-MsgGUID: N4Rf4f9XTeWqL8mEBbpbPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44479183"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="44479183"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 22:13:43 -0800
X-CSE-ConnectionGUID: 1C8unsTCSUGj7fbiqGaO/Q==
X-CSE-MsgGUID: F6PZulo/SS636aYO2NIXyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="99362188"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 22:13:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 22:13:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 22:13:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 22:13:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJye+ItaghPwaf77ifKt5B9Ks53xiW3YBKci7WwfmNP2IDWyQFTIebvjjE441kA6A819dpiok4/Ucy6ZjMPxOfj3BFycNdP7xcUejRfaTb9UoRk5rhYfOM4hiLWQG7QiKy2mf8xAKGxLm9hB8Pt7YKKH8joK5S6klWi8RV9p1fLc+5fjK1AHPO/LO6JGnAqpdcPobmHJUZUqvaBwyyKKEPxPdgl99WKCkELJOGeYgToxV7pm3bTNgS9BpilA5q3hMYWFXTfwCQpuTWBp8sPHIgpSCcZFpIKtxPT3y4/02Qj2NhxDAK6OanwT1ZSd7ECMn26X6nPlY9wI9/iEU9sxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGo3yzn5Hl1Gc3ccAdchHm8agiRUor4ufASPux4P2D8=;
 b=kryBeD50VM2cz8BeyJSxI3FV7cKDBnoNJiC+lI3QAczAWS/Q2G7X59X6dvKZl/wRU8aRcLB3DDN/fAPtWuEJ4NNb87+UWNtQTAVFxVcztaOdlxes6NaAPLuyxPwUP7hate4+Al7QualUG30JlQkVQTmier5Tp0DQPf4FmgixaB6X9QsKMDz5mbzzwhOZlFJhAkcd223zn1l3W74oK4iH20YGvj0sUxkIspmQzHbkF5j11WN3sIe3/NyTKIOMONrEM3J2mpxXnXfTjAArNXVmbJ5gdkokHxfs0+Mgt0NBC6tVvtjixGfEEEZ/z87/Z5afN92ZYoJ3YfbKc0mm2sbhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYXPR11MB8710.namprd11.prod.outlook.com (2603:10b6:930:da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Fri, 6 Dec
 2024 06:13:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 06:13:41 +0000
Date: Thu, 5 Dec 2024 22:13:38 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 15/20] fwctl/cxl: Add support for fwctl RPC
 command to enable CXL feature commands
Message-ID: <67529612753b7_25073294a8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-16-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-16-dave.jiang@intel.com>
X-ClientProxiedBy: MW3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:303:2b::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYXPR11MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 24963054-da8c-4805-b5bd-08dd15bd2149
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Em/whA0tHuM7KAIOVX5MJdf06HZKgJPnq88p9sUp2v/eW4y8UEAuOy433UDg?=
 =?us-ascii?Q?BG0SOhLkfkAz6EELJIa7sUhug5WHTC5bnGxiu7piL/JjBskpxffD8/PH0NnK?=
 =?us-ascii?Q?/Aq9+JWst4xcdWfbx8sW+XLWzBXCYeM6fM1+nD2XG+kH4mymsGtHqPrTi/Xe?=
 =?us-ascii?Q?ai+v5yz3b3gy+YhWqGT1cz64+wjsRFEALCwv+Lgx/hTlhGOkFNktjhq2jtXQ?=
 =?us-ascii?Q?ABR6aD62gsJ5Xe7uFtXImMdfdyfAVq8wKwcWOlwiKU5pbbAru1+L/1hq+83i?=
 =?us-ascii?Q?94ya2Pm6uwbla8jOjbuhufFjynZD+2vdrZYv+zndvVmM7VApCliQ6F6//4M1?=
 =?us-ascii?Q?lF95If+3PgG6R0AhWaZ2yacQUWIyNtUb7AXiBPlsAZxAc3mgi+VWk1vLk/Mm?=
 =?us-ascii?Q?wdWCfOEszSJ4YapL8s5oZtBRrWv26iEP3oLT/0pgL23MR4NDpJX8vG/O9yFE?=
 =?us-ascii?Q?+syuvwckANsp6WlT1srjaUiSxccmX7bneQmBkUBSj0/dfyTzOcMuryEd/Fi8?=
 =?us-ascii?Q?aU/NVxxMboZcEBfIv25jHleXxeSG/zZMEKGVWdWja5T4x3GLz6s5GInFpM7r?=
 =?us-ascii?Q?K+RlF8FMVGES5ZzxKO5uck73cP77HYmmlNu4ATn+ngRSkzqnl/oM5/hej2Wx?=
 =?us-ascii?Q?Z+6ECa02F29JTSM571Zh1g2vgpmi8zS1HuoYz+ywavAtVMp+Q81cySKLBxD8?=
 =?us-ascii?Q?G6nIcBV3zTGIMgcWNxmRI0N2CT6JbV1ECsymBMPJ76VYk//0WfETXtt3/5a0?=
 =?us-ascii?Q?lKTha4rk3vgcsLQlpVtgzjULOQspFr+kuNZ8czh8DLNiVZ3ldmkQGR1t1cOZ?=
 =?us-ascii?Q?iIChAk8ErJHdW6isklcZXvaCrgcmZ3m4gAVE8PWSHB4zz7kox8MUz8RupGTc?=
 =?us-ascii?Q?RU14SCEGTSWD+hYRQokYuDdMxHVDmPyv/5CdetmAsoRJhvw2Hsig3lYSkp1Y?=
 =?us-ascii?Q?WYsOICaP5/yaKTjyb4+PPiTTt3i4uK7iuEM60r/WkWCxW2TXfEHPnNhEl/IA?=
 =?us-ascii?Q?USri1b4alt9JqHV9dTn/V2yUbWamj8dcA8Xliypdx4Hyw3LsFOCwF++7iRHb?=
 =?us-ascii?Q?IM7K1DPe+vcysOMibEju+eoaSsZbDhhtYuSBYlmPCuCSGrKTcUGmCVgOzuYQ?=
 =?us-ascii?Q?mSEolGppb9svovRXB0eCgIHRL8RTVtDlAw2xmKCHWP81qlGuEWXYuVzO1n1w?=
 =?us-ascii?Q?UoorXO8lllILox19ffgExVCjhbAVBC7qCkifYCFE0fVksThXfJPWhZ+fLpdC?=
 =?us-ascii?Q?NZB/i8gQcICsGXzHvAKN0hBbq+E28dw0qWMS0R5AihpyFCJPh9kShgLHttq9?=
 =?us-ascii?Q?vcqNbX8AR6ZupMptnw3cXhbXCxS6Hp4/TTxw2bH4riKMEQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5cAVUHKMJMVfQTwVitBt2Aj2prhE7lSCM54Ujv31EXuz00z088uy2zhHDlbd?=
 =?us-ascii?Q?oqOfCccwNiNMrtm3VHkm9vMrj3+xRSD4RwEkfG8xwVDMVtfidjm8OtRh8+fX?=
 =?us-ascii?Q?Wq9JQ6efY25xsToSHOBqN/ww5PF8inqdplQyJ7xCfJPWZhCRou17y3pz9Wot?=
 =?us-ascii?Q?5UTkL2jaaJiapNCpp+f6rJWIuCF4cO8m1JNWnl4QXxVBJ3ETpzW/i6LM7qx4?=
 =?us-ascii?Q?BLCHgbdrNs8qjqsXSYpPDS7pd+NnJ2FJiwTnHdBv8XY2k1ReFtyoxwbkF8Zb?=
 =?us-ascii?Q?sPUO3fkYnb6aDA2AitAN6+wK5Dj+4SdoxRRlL5HJbXn2eWqWvmn+gqxXbuhj?=
 =?us-ascii?Q?/NBQuNPq9C5cIMZOZC+dqbGuPtSEkdGb3Zu07RgJQLnvrSu7YSCZ8GYKTD9/?=
 =?us-ascii?Q?McwwPjMyfi+qXpRYERuy2eBQUST6AE+MZAhCmUFa7T3dvTI1TJPb8RI+pQ7Q?=
 =?us-ascii?Q?/nTXSNzU8A5jRiuCEGUMMABeJ2bonNohhZl0DyQLKp2wOhIGU9MUEMC+7dF5?=
 =?us-ascii?Q?gspXYr342wKeKncPB6D+t+EWH1fZfbj5RmX+uVtaJy4BNTNmwRwKLqJbAH+G?=
 =?us-ascii?Q?QtM/1brni3Hv7UdmQo8jXUdI+C5rQJSIGxrrOKv0htv2MPovu1p7/R/5wvdz?=
 =?us-ascii?Q?/4jMxh39bTayrhxx532KtYaiHP3JBo1xalNNuAN1OA3Zte3X/tGrhkF5MfEm?=
 =?us-ascii?Q?PDLP5i1J0tsx4DaLN0qrUjp6IpRecqn9ub2xx9qk4D+nUmfwVcC9PV9k5zn/?=
 =?us-ascii?Q?XItqN9scTP8Tb5dYmQ44rigT+z7IRnaWW/FjhE7sgmJCm6kDR83OK6PGmAST?=
 =?us-ascii?Q?7Hgj9ceQ4Ux4bOItjYmBNCK0byV+/cMdcC67XMJa0NaSXHmxtNri3KXgvflM?=
 =?us-ascii?Q?rjQWy6+7AEi/+0lbPm4ZoCQexxgbMu7Yc//+eSIYbUhVTVUovrnm7PAlZdhr?=
 =?us-ascii?Q?6zAhLz84ZePjKq/Dnp3JrkJucxcGFB+tw+LZa3wPA9lNVE4NekbprFaMIAJE?=
 =?us-ascii?Q?2laTc4l3SZ7s+rM36kZPYghdqbqIm5PgV/K3BPaFx9XHgIdPVpkeeGQfvQIM?=
 =?us-ascii?Q?qNPMQYCRLKfYVRSduhVs29JyGfLuH1pdnP/yUjlTG9uJqALWIemUNwipsu9v?=
 =?us-ascii?Q?4+8JNV4W7v+USekc+rQs9mJ7FTXl5Fn1go/dNNGiqWTmfAdfRlDdoLAKvAtv?=
 =?us-ascii?Q?Sj3Usye0ZXAbszgKqahqKocLxOcNwBhMy3muGugqHaunneVmnXUm3oGx8bmr?=
 =?us-ascii?Q?guh8yYoPckhC0JlBzHMMjVztJCtdhwlIogjG3jhqQS9Mv0cyKM2FESqzE5c8?=
 =?us-ascii?Q?/k97NetNN0SOtIVGrRCKoH8sqmUVTlV+zNNGY530B2W2H/8MMSpksxEE5xHy?=
 =?us-ascii?Q?ontKaPqyiAJb7EaN+A0/DSJDa0PEf+CHa8pugWWrei+h8kjT0hYcD70TPm4v?=
 =?us-ascii?Q?Ev0l/YnqNoCzLmxUzzHOcdQ86Fs1e/lrMvWM2NF730ZXYKhAX3cny3r/3g+m?=
 =?us-ascii?Q?JPeJfrxwClkPUIDCzbMhZn2HsjgKiWcU29uUcKz5CaBbS6A4g63mg4OBBpvo?=
 =?us-ascii?Q?xk8WCe5xfjA636VGMGwCJX5BjImZ+tFP/BWfeAS2g1lBKTb6/mMw7dT+0whx?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24963054-da8c-4805-b5bd-08dd15bd2149
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 06:13:40.9661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ck7Km3BZzrhYEHl/0t3gQ/tMkcUmL20PEqASs/JG6AlcWd0L3nSTO9+eTBs8XPCiaWjdDPfvvCdQpMoloFnPa7P2xgYfcecBwIfaJFMlM8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8710
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
> to a device. The cxl fwctl driver will start by supporting the CXL
> feature commands: Get Supported Features, Get Feature, and Set Feature.
> 
> The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
> it indicates the security scope of the call. The Get Supported Features

I would not classify GET SUPPORTED FEATURES as debug, I think it is safe to
be at the lowest FWCTL_RPC_CONFIGURATION, because supported features is
just the provisioned state of features in the device.

It is even more safe because the payload can be cached and augmented by
the kernel.

> and Get Feature calls can be executed with the scope of
> FWCTL_RPC_DEBUG_READ_ONLY.

I think this is a good default, although for well known spec defined
features we should audit if any are suitable to just mark as
FWCTL_RPC_CONFIGURATION.

> The Set Feature call is gated by the effects
> of the feature reported by Get Supported Features call for the specific
> feature.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/core.h      |   5 +-
>  drivers/cxl/core/mbox.c      | 260 +++++++++++++++++++++++++++++++----
>  drivers/cxl/core/memdev.c    |   4 +-
>  drivers/fwctl/cxl/cxl.c      | 101 +++++++++++++-
>  include/cxl/mailbox.h        |   6 +
>  include/uapi/fwctl/cxl.h     |  29 ++++
>  include/uapi/linux/cxl_mem.h |  12 ++
>  7 files changed, 387 insertions(+), 30 deletions(-)

Ok, now I see why the initial patches were touching the cxl_mem_command
array, this patch is converting fwctl requests and plugging them into
the "user ioctl" path.

I would have expected to skip the need to define CXL command ids for
fwctl and it by a raw passthrough of opcode to cxl_internal_send_cmd().
Maybe plugging into the user ioctl path saved from copy_{to,from}_user()
overhead for this? I would much rather fwctl leave the CXL user ioctl
path alone and keep this all self contained on top of
cxl_internal_send_cmd() if possible.

...but do holler if that unexpectedly blows up the complexity.
