Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF4211CA9
	for <linux-cxl@vger.kernel.org>; Mon,  3 Mar 2025 20:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035097; cv=fail; b=g86It2KUHFD/76QlpXEx158wRlpVFUHj7Wv8DcM3RvbVvUWq6ohu/lyuRcr5KE3rWCqWWYeEMzfBIHwB7H3pa5f3TNeeP+9SCMeLGiQFkITOPbIOrT53fkFXc/SMWNIAEVJN9sN7ggMXy4TI0uIk5zWdOBZJSV/0wisQT4/TEdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035097; c=relaxed/simple;
	bh=/v/FidRQWJqo2I95yOLAQHUEe/9VqNOO996+4CGH3uE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h85S2TE3VpHx+GwdLLOvv8pq+ilcXN1QyPfC6Uf5iIgdk7QpuTP2BPsdmqvyWo/PW1MS6tx9q1VMdK4Vk5YEISRFBPOSnu1Jh7fzTiq03Dz8U8PsjVmQQZOrlhcvyElrEVpNQi5ltPlSovWL0Aaa82YkF0LmAnl26SXriwNASOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2XXyFh4; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2XXyFh4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741035095; x=1772571095;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/v/FidRQWJqo2I95yOLAQHUEe/9VqNOO996+4CGH3uE=;
  b=H2XXyFh4Ke8YwTqaaxOeqwe1FPdR9HwKHl2y8hHzPYj4Hilj02yWfW49
   sZKw8D0mTvDlt1yKJYzy13lk4mtB/RFQMJRaq0YcSmbfShmmUmfk44i5X
   Qr/kxGLDeQiOpyQ/I8+3XQOPHkHzQs6I4veNgYeYh+X+UbA+t1aOQQ5BP
   c6K+gCfoIF7Uy2w5+4FehF563EIlL3UJ7FxeHjmo9oeWKhEwZQ8dfQhP+
   mT/Pi/4gSLsrToOGcwrz1kK2L3fbZej/umGh7QJT5b8ej+0QgFPHWK6G3
   DjsHHABC+VjQNPkC/OgF/ErYKTE8rPP1pQB+Q33RSGbSjBACkXeNqoCSv
   g==;
X-CSE-ConnectionGUID: lp8yFtp2TSqs/9XaE6KTFw==
X-CSE-MsgGUID: GUobNaCdRBmLKgpqRM+zNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52135540"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="52135540"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 12:51:34 -0800
X-CSE-ConnectionGUID: geMJLbHeTA+sK2HluE9YWw==
X-CSE-MsgGUID: Y/f0cYleTZuASp+cQkhwpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="155341705"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2025 12:51:35 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 12:51:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 12:51:34 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 12:51:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkfHIgEHcZ8UdMdQrxv+DdAPcFnlu8PK/wJ089jlxJZ3fsgQy4NBvwTAsuUodFZdznxDDxabo8B7bmxaEjoZBCM7yD2RGnsKP1BBXNSXCEydlYOsJpc7egyh6gNuuAzNPuQcXOCNPjEuCSdL5ZfzB+GpxITEDBmbDniz6bbj6m/8UpyTVyjcCL7BN8UUnvKmbtSK+zZT46ef4k8cC0fhNNf8Z8KLagltRPCawGmLAtgFQSqufNd6XV5kVJCkVtLG0TlWdlYFYzoxn8YFxMdmR9vW8v94ULD7VmcQWiWaYuo486S5luks4Un8u7EFbXsNzpfZKnuL5OD+/KK/TBunDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNQ0DNkdEd0yFomhC4bmTl02kzD/0/+ocluah1w9sPY=;
 b=Z3pnWXsunNHFVd/fqm+yTvEgyOq3OiM6ELcZpkBvvi+KN675K7z7FwjpQCaOV9F3vbP0GjeX2UCBWb/wPuwJzWMwuT5+P2RbUN/eJVVbn7FG9KMhsL1czIadB0IYuGWE5q9Mw/2EOBSar0sVtjc7htI/tKaoGltPx+r1eTUvryofqJWPipunf4pPPaxolXCVP0Fa94dFbNwjNHP7pPLXl8aZDe/2pbBmyW8pgxPnM22Dm0jescwn+yJDdk8/L/Y/hYSGyEhpa3vcqlpvmeR4rHW5DiIZxhIuY2E8Gdvn936EAP5OjSmyH1mFqisxCL9BUB4lTIjt5Ql/SYnBYkzMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SA1PR11MB8352.namprd11.prod.outlook.com (2603:10b6:806:377::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 20:51:18 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 20:51:18 +0000
Date: Mon, 3 Mar 2025 12:51:15 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>, <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>
Subject: Re: [RFC type cxl initialization 1/2] cxl: add type2 device basic
 support
Message-ID: <67c61643c3cfa_1a77294b9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250220200041.3891165-1-alejandro.lucero-palau@amd.com>
 <20250220200041.3891165-2-alejandro.lucero-palau@amd.com>
 <602d20fb-ab1b-41cd-9f51-98ca690b18c8@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <602d20fb-ab1b-41cd-9f51-98ca690b18c8@amd.com>
X-ClientProxiedBy: MW4PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:303:6a::20) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SA1PR11MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd2da6e-1ff2-4d9c-3f18-08dd5a952535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8ZYJmwPi35xRVzBVodMc7FsMymVlufGwdKtZw88YcDRwHlhV9ee8LDmetLo5?=
 =?us-ascii?Q?RRBnCoD91Tn/5lyCOxztoA6Zi/7rcF3ey1+uutv2Cx+Bqnlx182X0R5+pscR?=
 =?us-ascii?Q?cjjGSf3ziuScQ2UlPCvHnLT77v/cgzIfy4NZoQT5RIU+OKJ1xTGfmeWZkYyZ?=
 =?us-ascii?Q?clDQIt/pt44MY2wmq2vYmvFqi1t3x5jpVwdf7xUHXxylGAcJbsbKryy+0n2t?=
 =?us-ascii?Q?jKwS4V0V8Zl2sMlezim6dmOoRH+nY+fkDYqRi162/xG2v8XE46k1UNwBlk7j?=
 =?us-ascii?Q?2jZCItS5eTh7BxEZm/AvC9Fk3nOrA3w+6TJGEm5g3zJGRmBReh7LuFTaS/FV?=
 =?us-ascii?Q?X31g/0/U0a6lOJvNcqde1/GnmyhhkrfsPuO35uwmkz2lDMwhvqMoPAjbae36?=
 =?us-ascii?Q?Aia9FQZnjuZ++tdXPGjzc5NCm2AT+eRuaxXfWsLX0vJH9wp83cRmF+udeQHH?=
 =?us-ascii?Q?xnIM/HJ90xCD9gIme36cGjJNIF2+7QU5QjB91BXxW6+A2ivIDb+ihkVFXyme?=
 =?us-ascii?Q?GfmtOzOBSDOs4vutJ4Pig6+Dou7VEqQSld8DxP9JE6zuW/zNSWRNPYbBhtHy?=
 =?us-ascii?Q?UxN4ukf+2iABpUoWyDmoSbGU1dGlSyOy5mpa9rCCSZsr54x+OFnqYEz/pKAp?=
 =?us-ascii?Q?6cWEUhlesAELfcgEvVVVxHA6E1XDvC5Z6sHIM63jX8zdSjPFUhblx30+KF58?=
 =?us-ascii?Q?kdKDzT28oUK441OGXrI+I0GCBHj3HDyssUzYH5qmN3L0WNJVTJ37hcBOOuN3?=
 =?us-ascii?Q?F6DHJ0fCmlM13OZcVx58iBTE6n38yQ6/idpyfU3gHZefhPFMuxRr7L15W63H?=
 =?us-ascii?Q?+CmbMuF737Q5xWDwLELYLTQ/91rPmcUNhDOfG+w9fzgn4tM2cDa6vD3aNi+e?=
 =?us-ascii?Q?NgKoSICfGoh3MlBhTZpLOBvRUMpqC2pNiOWHjf4v/muKjD5EmVA4QZP66r+b?=
 =?us-ascii?Q?DEOLUlSpRrjGnEWb0wEiUqlIVnjgRG6r92xZxTXpZmqRCfZ5uDwyPCju8hHg?=
 =?us-ascii?Q?kze60bnqGylGYUcrAuXk39skqewpUCKZeDFI6lZ3pi197elF0yvvJpcr5dOM?=
 =?us-ascii?Q?AbLN507wXQ8cyKodq/Izb8Q4EJ30gD/ty8X75hzeKJH5gfIelnZOgu34BHuB?=
 =?us-ascii?Q?Jd0IB1XsbdGnlZfnqkKszTsPGOxoOSHK1SNAcbbKZBrD2CAJb1Dmo8Vcfe31?=
 =?us-ascii?Q?lmSHDx+MxBr9CBTuQRf9OLsO9BN8dMUpWqnVQUQcXGXFZEQSHofjTPrZeWaJ?=
 =?us-ascii?Q?GoCYt59hr9gsMTRlTjSGY9nK+DZVaaapc3RCRsPnZeys/abw/gocT3M644P2?=
 =?us-ascii?Q?LYipvrmFkIzoocHjymGVDQ1KTG8+5WvU6bUcaa16EhhYeaStcI3PcVtmCNl9?=
 =?us-ascii?Q?qOtLwdHo7L3S9tND9iQAIxODcNVK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tlmgnumnDnXIqbqbgxAHsKfK7QzIcZYNUHiakiXrTUAdQEC2WIGJbgX1ZnNO?=
 =?us-ascii?Q?GcQ28lJFDqUcq5cq6BkalT7HyWTIopSnljgS7U4ZD5VaaTtsrnORSAr+Xbg6?=
 =?us-ascii?Q?3yMepZjBp8q4rvQNX8qmSzVtzGxLu3V/pM4dJXu083YChII+vptbtG6fB0s/?=
 =?us-ascii?Q?T5tM9SlCHEq58Cy0yuzfMtS0xRlSMf7zTtCcJqX9V4VQJYUym3whkQsqOEZF?=
 =?us-ascii?Q?SO0w6QsKqA0b7k4N96gVUJMgg9FUWxQyQYANOElyIo6GzqGZmF75HpQ8UF68?=
 =?us-ascii?Q?tnzf23QA9DjAo2ATuOf8h7Ohi31bf2GiUCmZAodwYLALlOgyCQmR68i4h3a8?=
 =?us-ascii?Q?KUjJImyvaS+r/lhqlZxM10/vGCnDOl5ZOr9bG6ARF8a1iw/CazViaAiM75t+?=
 =?us-ascii?Q?mVOYB53m89S6abvEcPUCAR0jB4J2rgbxR3PGBUSgo4qPDlrXNMC9vBRyN6eS?=
 =?us-ascii?Q?u7r7KFVZtjE67QNZis6zYBuiUgY1eRrPIcOAkk3DVG+SzCpHplrEoLTaxgAK?=
 =?us-ascii?Q?yUBH99puPuupxnp96uGP8sNWNOSZT2m2CDWPkq+q5K+6Xg/2aAzsopiyXW00?=
 =?us-ascii?Q?L8Nm5eVCgCchrGiJczPcp3RpEKRn6iDanvk5/eEJAMGYurV2j8j0Qmt6LvbJ?=
 =?us-ascii?Q?9bCOoYFO59oLluKOfD1EetgcsQkItsAuH3zyzSUfmgTuLf7J2hyimLyXYrID?=
 =?us-ascii?Q?SS2Gi0V68lu5oaR+hfnKFqbseul/XvAPw5KhUYx2zvOALGM7dPp1AR7Ox7id?=
 =?us-ascii?Q?SbUaRbMnHCQwI1ZdQsF0VRjWdAL/iZFDxbgdFcVYj1dXtMjWyuZwdeb8a4Si?=
 =?us-ascii?Q?dmyggxC3Xeo32VhZ5naSeayam+ktyLMuYPP2dGqlZBZDH5oyZeHsbEYIx7Pa?=
 =?us-ascii?Q?sY+NwY6nJfNMf4M9gSEkxZIsntbmDQsTCAmXalElGi9+LORlbkFJCccJjVes?=
 =?us-ascii?Q?fTZqYiUnK7+EW33I5DDcjSSd9b1xOF/hOcyn7oLkPKc3YRQads52OlhGxORF?=
 =?us-ascii?Q?szT1Z1U+rr25Pk+cH87GBhHiIgPGeFwnDDvzutznWRheAtES0ggeb51eCYCT?=
 =?us-ascii?Q?Ciax/XEba1UT3VGNMXSJI/u/St23r7e0UxuSI6BgYE/rChWOHqbycKFfXuhA?=
 =?us-ascii?Q?pZmNPz8ZC4kci4HpwkkAF55NgnB+TwEdioiwaxRpQZkdyrN6Uz/tGv4xeXzA?=
 =?us-ascii?Q?9BPrxEUm6cLahdG2NrfVJDPdntYlkKIbpiA5XqZ9tWqRDzE9uPBzIkggR8hR?=
 =?us-ascii?Q?wgeDNQSv8cvFTcOQyeksRez8qVtRL+JaHJysXRZCn3TykGzm+MqWqyl4uFiJ?=
 =?us-ascii?Q?sDnx0DiGcZt/o0Z93YB8hyLPkvuIGjjVvFWthoeTI7jHP+e5B4xqcXaEi/Ru?=
 =?us-ascii?Q?yte5xzDl1/3xiZbDnjUYsPvJSD2D8FblIQddhp3m1+DMdUJt9CSznaQnhJrc?=
 =?us-ascii?Q?l1rDi88i69YUINwg68Gz/I35hroJsLCNqGhtoo2JxJ1/JDgg68r9nVp35mUc?=
 =?us-ascii?Q?1O/pjeNTVuEvYFuSKNyy2WpgqzEqMXb7GUfTQyP++BYjcGxtPKP2TlEieglW?=
 =?us-ascii?Q?C1zxmzfo+13OKBWE2TWyiw3g4o3ylqQcE23JOUD02/P0SvkwncsHeWmH0fTH?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd2da6e-1ff2-4d9c-3f18-08dd5a952535
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 20:51:17.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vMVyBh5OldiMqcsN/HrnYWjQtur6HDFk5AK+nmnbqpP182V6Lnso6J3jMC0Hq9XLGyN+uSMYoTYC6acQMutrlRmyifdHPsOtsCaDdD1D1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8352
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> On 2/20/25 2:00 PM, alejandro.lucero-palau@amd.com wrote:
> > From: Alejandro Lucero <alucerop@amd.com>
> > 
> > Differentiate CXL memory expanders (type 3) from CXL device accelerators
> > (type 2) with a new function for initializing cxl_dev_state and a macro
> > for helping accel drivers to embed cxl_dev_state inside a private
> > struct.
> > 
> > Move structs to include/cxl as the size of the accel driver private
> > struct embedding cxl_dev_state needs to know the size of this struct.
> > 
> > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
[..]
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2c49e33851b2..14d7f93e4584 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1484,24 +1484,31 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
> 
> +static void cxl_memdev_state_destroy(void *cxlmds)
> +{
> +       kfree(cxlmds);
> +}
> +
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>                                                  u16 dvsec)
>  {
>         struct cxl_memdev_state *mds;
>         int rc;
> 
> -       mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
> +       mds = cxl_dev_state_create(dev, serial, dvsec,
> +                                  CXL_DEVTYPE_CLASSMEM,
> +                                  struct cxl_memdev_state,
> +                                  cxlds);
>         if (!mds) {
>                 dev_err(dev, "No memory available\n");
>                 return ERR_PTR(-ENOMEM);
>         }
> 
> +       rc = devm_add_action_or_reset(dev, cxl_memdev_state_destroy, mds);
> +       if (rc)
> +               return ERR_PTR(rc);
> +
>         mutex_init(&mds->event.log_lock);
> -       mds->cxlds.dev = dev;
> -       mds->cxlds.reg_map.host = dev;
> -       mds->cxlds.cxl_mbox.host = dev;
> -       mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
> -       mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> 
> 
> Looking at the above, it occurs to me that it may be good to either:
> 
> a) Have a devm version of cxl_dev_state_create() or,
> b) Have an init macro (in addition) that takes a pointer so that you can use an
> allocator of your choice

The caller can always wrap the result with devm_add_action_or_reset().
No need to force comsumer drivers into an allocation regime.
