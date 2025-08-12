Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FE23596B;
	Tue, 12 Aug 2025 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754957306; cv=fail; b=OiWcl3R3j07Swe04jRMqGPZT1+K1EkVCePvhR3mmgaxFhK2dF48Q0Xi3X1EKYEsBKaOlUkkAVM01xb1NVRd/Gpn0mbq9GmNOwSuxZ25HR7kZMtedlm/tpugprAYQydkpu00ILbgSbMod2YIxNXiYQhEKF+VC9NZkb7rVmxvMJkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754957306; c=relaxed/simple;
	bh=ASq6hSSapDR+bBMe+bd9rrbAmTuuR8XjnX8u5L9NZWY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E6NOofwwvdZhOQcVAY5cxTSo0vBoQ4bSR8ZX0G/L8epmMMZ0fYlQiLp9z6KaYRh/4BhDNOJ8XEaHOmyTKKSOow9CWN2XiIlF4saOicLumvQl3qR7BFDPYMGBpo/WOLMhn7+yzJhLj4KBQDdH4qZVjpQNiDKRTV8RROv26gOHMIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCgxNF38; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCgxNF38"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754957305; x=1786493305;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ASq6hSSapDR+bBMe+bd9rrbAmTuuR8XjnX8u5L9NZWY=;
  b=mCgxNF38InQU+xhhPjVcd0kqYgVXyIVg3zZZyS4wB98TfyAS0IJihphf
   iOehtSiFVHKIIvCrGhJdEx68zuVBwg4sOZAXBfit6EsM/xgbOe3/qJBqQ
   QbyESXmDQlRL/1zhT09NxumwoWCFcRVcfHbi6jOWWyZZY3Pbr+RKFrQpd
   trCDEusqZU8mtqFrYVX01gV9GvEzv89TjKVVbHGmgzHxuW1wzMPOqniG7
   i2EwRnBBgatx8xPRagfXNkCO1gzA3cVcYgSS1h/8RRUaw7fplT14VtQOi
   +lTQKbcx14wNVk76xhiJtpl88Sy++V/PPzQ+areHcQQb6qIVA4LNAjKCg
   g==;
X-CSE-ConnectionGUID: stzIKBqKRT2fSSnnce7lLw==
X-CSE-MsgGUID: RIrF+MboSYm94YvrA2gfvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="59833227"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="59833227"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 17:08:25 -0700
X-CSE-ConnectionGUID: 1KEPqBdPTEq3UBl4tBH35g==
X-CSE-MsgGUID: gboPWiUwQQWhPSRUvmNfnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166402131"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 17:08:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 17:08:24 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 17:08:24 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.65)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 17:08:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciI2hBbY2jSIMvKAguLWqXtlqj+8r//Am+mdRmo2ll/F1eQuvkaRPKuDAVbcdeXUmF+c3I9r8vaPZz8UQ3pmAxqMDHqJa0XY3bbhjBqb075Rl/qVuFu0SGyiYjVh7jiywzytTjEyLoeQvv75ClPqxpD4pSbhKre1U4IGV4LjKtJQkIOdAwykdm3eGzg79A2hYe2E+lVOjC3PZ1KsJznxVPo07inH8OaOWJbmyiz9Tf8l8iF/Ry5FfDGOvXAGj3N5sFZ084Gbsf2HLQSTmyGQrv3NeHr+y4bdc+Y3bVqp2XcNIk6l0McNcaB7B9YoBaUrnw7wkqmKlB4snajejyQbwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSIi4fxoVJ5SKYkKIAIkNv1xUtn6mOGn1sA7gCGjCII=;
 b=vhuGsxHbrmRHjGNeL3EjhwLRIvLkxT6KEQ4Rk/W+n/MZR8ljVNrPzfFJ2F0rJ0dyZmcJAcR2Dh82WuD6v9I5VI/pfpt7phqsDOA8u1NCHxOCxTzzZ9YalG5NZ0X2JDrb1W1ihC/Y2JNdUjYIB15wmDEf5b/p1ecO86ZRTy+hOrr5Kxa1fnIVykzgvRgoKkt314hHpf4FOOwrnx0V7EAobSon2x62uZXzJidUtHfHBB9O33SY9AF3Opr15/HEu+lzJn/JZSueu+6+p7LzXgrVUNR7kT0aCRwZRhAqd2cha4uz1QvZYN/dsafYYtK2mRhUW1Dr8Fewz52jSrDdGoMEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB7156.namprd11.prod.outlook.com (2603:10b6:a03:48d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 00:08:21 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 00:08:21 +0000
Date: Mon, 11 Aug 2025 17:08:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Nai-Chen Cheng <bleach1827@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kernel-mentees@lists.linux.dev>
Subject: Re: [PATCH] cxl/region: use str_enabled_disabled() instead of tenary
 operator
Message-ID: <aJqF7cEue2rGg_ka@aschofie-mobl2.lan>
References: <20250812-cxl-region-string-choices-v1-1-50200b0bc782@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250812-cxl-region-string-choices-v1-1-50200b0bc782@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::21) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: d8018991-e8cd-4f94-8f32-08ddd93458c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wNPq5duHoUPfKM5LyhCw0Vj7c+zaH4G0dU527hcw+79cUSBGhkY6qX6RIKnk?=
 =?us-ascii?Q?oHfv+u2IaIEFyHyyjDiqsxGMPNFYbFRjlziUWbD++jATF4/9GLgfdNlcxhxX?=
 =?us-ascii?Q?Z4Fw0DhnBRfeuXbbdjtaIAscwy0dP18z70eEtgIiLawhoPEIpYRGAl5X/anf?=
 =?us-ascii?Q?WR9EMrFMvXS1Y36s+4P0ivzXRqXjJYRE7NmOB4MAKNfuywkEIWL+XL/5FihL?=
 =?us-ascii?Q?IJWTfzoJgHU/u1fejuY/+3UtaAUhif1lefBbL4DAADmRi3KxWVC/5o2bF9DC?=
 =?us-ascii?Q?GsJ+HnZQLUpxPQmVY6U0r+r4BfcHmvTbQhwiv9lfyD8uSsp7iaQwWusBw6Yp?=
 =?us-ascii?Q?QOukVT64hC/e/E7ccjlPgGtVpnCA1lJI7xYbCXnGUbqzNzok8L3RrhhmrHrZ?=
 =?us-ascii?Q?W9c0eQQqtSAhWG2rQm6RZX9uKQvAnRIDioe4Ig4Oh+dPHNHwPSfS+MiIqknn?=
 =?us-ascii?Q?aTmJ9U0cOtjlZBP2qhFB7Jluboaw2lwhfr/ijL0Q0W5qmFp85bgEQAoepLXI?=
 =?us-ascii?Q?qdAfrcgjLBzQELJMSJlAlCXHz0tSaCWrCod4NxpSRRoBhsgu4iKF4uhdXE2x?=
 =?us-ascii?Q?oQcIqYV++lxNgTYYqbUnf7rm76SWt80wL58qR4VxFbZeLQIVuM7sfvlZ/YvB?=
 =?us-ascii?Q?K1Q5jrR9fBIh4kMSN+0E3aPmu65E718yaoqa5OjrDhlLdXSgHubi9wtzlrcj?=
 =?us-ascii?Q?A9fnckldpR87PrbBnsI9lSNMMfTGnXQno34qB8pki5qW4vvsaKLgs5hjLhJo?=
 =?us-ascii?Q?ve9VAJ00a66hLCLPLLWGJXvciMaSxC+zEPX+/4tsGnJtQIGGrOp9HcIiPVjs?=
 =?us-ascii?Q?A7epcko/jOSkpllx4QE5OBfu9teRPwO418LKeZCYUhuPA77if06kujjtEI12?=
 =?us-ascii?Q?Ynge8FFeqKrCtWRiMMdyDV5BWhYEch3daRWHmA0ofTyjRyFFWEf8DbIQu7+W?=
 =?us-ascii?Q?GMjfgoQ+Ti7k83k/AvxyiRK9/ol6WVLRTmGI3tIXZHlHqSQCsq3v4KauKKHZ?=
 =?us-ascii?Q?vXBEIXgkQZq4RaHK66opGDUGSaByQrOEasJfJ1cflNg4Ze6Jm/jXTuVBQg9M?=
 =?us-ascii?Q?4BItnJLtH/s6/0WUPzykDnlTx/7pODnTM+XF0h/uzLx6CXRW4r11iraeyWis?=
 =?us-ascii?Q?KAvJUh6DrNSmByWBi2yx6uFvH2tyYsRFvime0tQTJMaFUJQ5tmcDoYv/oUiY?=
 =?us-ascii?Q?DOB6S2dT1DyzD4CuLIBI3g19H+axUt4KK90/gGgzK3JayqFnA0fNNYJTxGBH?=
 =?us-ascii?Q?mJESr1USYjCDHaM+DGwbcwRge2jKPa7+MZuOJRMtFiPp/VuCXEgOVFLvtEBq?=
 =?us-ascii?Q?CRcI0ZARpddovf3bTjpu0HAnmU6wlAihLRyxXfvJtEIVyMJ2nrFu6qeCo0fj?=
 =?us-ascii?Q?VTEADRIave4X09hIVNUJhMuELLy5efbd/PW6xzk0TWdPHUpqtvS+Z9ZczwvS?=
 =?us-ascii?Q?iVUfJHm6VLA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FpiUoXDebC9yScq7z6K9cKIFeO8B2TZWcdm0hD1+wdyb+0jTCoC+UCB8sAKD?=
 =?us-ascii?Q?tWPp2XaCmNZnm27ttssSXwqHaX786lc9c9FaFovT3QsHY2HxMa8RKBETWaRy?=
 =?us-ascii?Q?DxCC9hM3INK4pI8MI3LG3hNHFB9fG43N1dTgiBE54RocoW2hkVmv8NGI21pC?=
 =?us-ascii?Q?xdzgu/HdYxz/ZHuY90OFGXhtKceW9vn880AmExfcnCLfSZMOEDZckmmx5TwO?=
 =?us-ascii?Q?RcTGpTRUrLUiJ4Nrn9B9OdcaDpoApuoEpdNr4ur/RLmpfJrSbXjTKBN5ovts?=
 =?us-ascii?Q?2/Lbx3y9lVSoXbBhqtlySpb9Z1c4lKfGNVHq0EWH8++sfMmgycz435HPtv8c?=
 =?us-ascii?Q?H9UUGHePNg0AD1cOGNBj+hOqZuQeQx8p8cOxGRuQ/letpGZoPL3/cqwtfJdT?=
 =?us-ascii?Q?S07wWnGmbDvZO0z+iorziTOIvqpn2FiD3Oo0Hi7QspIc1+ZRRhbO7DWTJlEV?=
 =?us-ascii?Q?l/tBE4WqhIDxTXvNXBF/upgag8sONaOLJGzSKINR5GWZ8l7rI8j6J/ildEFv?=
 =?us-ascii?Q?IrIDB67+jTIZjutpHGKa7f/eXjTSDxkeD1b9reMojJ3fvgsfJUeeDQ7tJySK?=
 =?us-ascii?Q?oWlkjXkNjVa04Pxi/BYf8DVYZeCTV6018zA8FOm2sTdYqRviAJr39VVO0+1q?=
 =?us-ascii?Q?BKT2+MQDxZLtadzsQgKo532FGnrkq0Mr5t778MmQXtxZeXb8fRbWzKybKbWb?=
 =?us-ascii?Q?DklE6GwTPmD7eiIYTLn7ra3z4ipQgWoIbDDybbfOMcaZKqkUsXds1idNOv+9?=
 =?us-ascii?Q?xA731yNy0AGZV2SwSwc1JOpdDZy3V8xIo5Q9qnZ3MpabR4VLVvrorpDNU07G?=
 =?us-ascii?Q?cbZFf/yYNvBSdNjf/XM6nlEFqpx/eDpvLTHmSRjTE1QeEpk3h3LJS98aJBPn?=
 =?us-ascii?Q?NPDfnmAbOzOn+CFXZlBjXYteeOPT+3LaAHsDFXy+2LdS1dSk3H/+q6Q1q21h?=
 =?us-ascii?Q?cspo9QMpwRMqPq7NA56laeqN4eEYy0D6njG6V7fmHBaupA6hAU9H9qdhgWWZ?=
 =?us-ascii?Q?3u8stMBY3vmchCuxYonH2xNQk287Nn6u3fgZBEAyslvwcFgD7XUMSr4NqYg2?=
 =?us-ascii?Q?BqOJ1UjT1yRUT6pBWrQr1yG1ZUy0GJvhzeSzZvW7n0v+Bhmw+3sGg0WlwGVk?=
 =?us-ascii?Q?1NOZj/R05DXZASv7pAtR3JDoVq5EOkScwLyIX7wBcy2De2V9idvJwy6Vpwt5?=
 =?us-ascii?Q?z6FshxcKVy0T+/uyE7mV2CYgmX7zhJuF2wWSkDDyLqTQ+DG9CI9ZbcCV7b0X?=
 =?us-ascii?Q?RY9eF6RDE9bxbfaCJE0D6GOCj/dMabklg6FbkfeEpBGdeM4QEt9AZXsZYeDc?=
 =?us-ascii?Q?y+xxrSJe+L0IJaj2GGJq9V/G8/KBYHHtLrp84bwrsdH9uTritzXLbFCAxPrc?=
 =?us-ascii?Q?CG4zs0zfDcChCV4LIfQG065xMTjYrfD3HOOSOMbuMId3MHViGoi8D+c+NnwC?=
 =?us-ascii?Q?6NGFvbl53IUBM072gWJpxFLEymwE8vHIjW2pRbuzoyKIwU/gXJYc7dSgRiSJ?=
 =?us-ascii?Q?Z6jdavRmNSbj4okGaKXv2yjiiIuGXAVZDfk+zJOdv+dwUy5tS3xDctJCWAej?=
 =?us-ascii?Q?1fpxs/Xjs0sMV7Tgruk+/YoaRXTY7KWk1fK/hFtCwXIQIeeO03hN9ja+GQ/3?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8018991-e8cd-4f94-8f32-08ddd93458c9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 00:08:21.0217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVd4bw6p/GKX4jQlAygPKgmhR5UgRfSPt+mSqTvC74QLVsAONc6u66+Zo0sJ3fmUvAvbNe+iYKtkGz1SL6OPSNwFat96V1rtdzXUJqLlanM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7156
X-OriginatorOrg: intel.com

On Tue, Aug 12, 2025 at 12:49:46AM +0800, Nai-Chen Cheng wrote:
> Replace tenary operator with str_enabled_disabled() helper to enhance
> code readability and consistency.
> 
> Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
> ---

Thanks for the patch!

DaveJ - Please fix-up the spelling when you apply s/tenary/ternary in
both commit message and log. With that, add:
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Nai-Chen Cheng - If you're able to pick up a related cleanup, I believe
drivers/cxl/core/hdm.c has a place where str_plural() could be used.

-- Alison


>  drivers/cxl/core/region.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 71cc42d05248..83d58787b5af 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -10,6 +10,7 @@
>  #include <linux/sort.h>
>  #include <linux/idr.h>
>  #include <linux/memory-tiers.h>
> +#include <linux/string_choices.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
>  #include "core.h"
> @@ -1468,9 +1469,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  				dev_name(port->uport_dev), dev_name(&port->dev),
>  				__func__, cxld->interleave_ways,
>  				cxld->interleave_granularity,
> -				(cxld->flags & CXL_DECODER_F_ENABLE) ?
> -					"enabled" :
> -					"disabled",
> +				str_enabled_disabled(cxld->flags & CXL_DECODER_F_ENABLE),
>  				cxld->hpa_range.start, cxld->hpa_range.end);
>  			return -ENXIO;
>  		}
> 
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250812-cxl-region-string-choices-f5aa9832346e
> 
> Best regards,
> -- 
> Nai-Chen Cheng <bleach1827@gmail.com>
> 
