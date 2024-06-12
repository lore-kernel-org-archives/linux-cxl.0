Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A064028DB3
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718167444; cv=fail; b=mc7BoG+XZOWP8W5G8tsOMYZ2jez0z5oNsaLbeYHIV1YMSwILCmy6qsu4gppgC8QmHXJ+kzWhBP/AHJf5whHgbCRyVl+x4fh7j5Tzloz2zIae71ucLRr5gIp4AWrgWJBIrFI+eLlKn266guWwx7ls6IdxdgQGEHGupxlXMfTxlVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718167444; c=relaxed/simple;
	bh=bMgHY6EhnvekE1fx6JgkbgJSrJrO/sJfBtaVqxHhnus=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UT02cC5dtdSzlwmtdIzeSIIJ+PZizjM2RvHIyvgDFhIl46lMNyMtGnS7SQVoQSvbPHblvDPodr0qi6r8YWCv6VRDoBk6nUuLzgPvACFP0i7APtPAvYHNbScZx6sE68gVYlOJwSc5u989UGjY/HvYK/6zSsJU4TEpf6/+MzlX7vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jV01lozL; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jV01lozL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718167443; x=1749703443;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bMgHY6EhnvekE1fx6JgkbgJSrJrO/sJfBtaVqxHhnus=;
  b=jV01lozLJhV/lQfnIyukrXnD+Rld5gwnKwdMrbiiCG+gzsQ3J7qwS2SU
   8qJUlQ9MMQPIL1XpLXXIM+Z/bR9egH1zT0vSlXRpejAANF89ZaO4wjl+o
   MCpgZp72Pf2gcBMrt/48nTna3fj6iSe8Tz/Z8akubJuKuuaHOXtNpolp+
   Kcacwg/25RUO3pq4lo/CTWcFaWYpkaQDx/ydW7pXILkGS44vecmhXpgjZ
   9IyGXOEnfdPAzxcfRxqwAh3WcpKWACqF9A+me06NtsY3INFK692MFR3kW
   buUi4c1oGxqvCZ7pf05fd9knF4HwnGUq+TNepp7HcNeU+yHsRUxihw2s/
   w==;
X-CSE-ConnectionGUID: qv7xxHh5TsCqrZrU23nYfA==
X-CSE-MsgGUID: jC3EZ7gaRpWgwBS3hyWnFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14636540"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="14636540"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 21:44:02 -0700
X-CSE-ConnectionGUID: ipi1/glLTtmBa0Wrr98Njw==
X-CSE-MsgGUID: /8LnEfvyTKGV6OveuVs5QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="70859498"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 21:44:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 21:44:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 21:44:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 21:44:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odtMyh69X5Msi5BVx32lT5nUnYjfXPJKESlz8Y7Ccw9EemrJIhLbYKVJ2ccSIJNSSSA4cfKhFGRKH8zn8NIIhiOknz5NH0FtRaGfZQMirIfUfKuN+RqJe9YaX2jOFEp5jK08nGhnT1ZlNzDBymsK+c6vfRzstRXdrP+63F6ziTNFsiLeOCizX+Nq9/+HXrQ0/5ZsbfPTnXhVo5uWKzKIz9NMAefNWeDKAV6gwbtUbJY8J/5AxEnE2Ea9W+z+DrZ9bdrgdJeyr1yDRR2mE2k35esoAiykee72zodkeormoFowCte/Wv9CSbZk8dUwCjWfTeKwxa9I8BExg3Wzq5Lncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PXZMdiLVBDV09MvE/7AaczzZ+8rQupVuBfoc9GHbdk=;
 b=OBqKJqfzQpEj/gW9slQ7Ifgcridr3Ujxi45z00YeXm4+LrcZWwKFJ6OrX4DoT8m7kBmHXasNY5K4Pq7tQDinR4QpNj4X/4uf4X59HVgYqezlUJCQdO9H2tSE6ClEZ94rrbbx9bBjjlsJ9uVV+nqyio6NvJ3DMu9/zN5xnmc+CgH3D4YR/JUlbp/Od94/FmLr5hDtxs3cRJ2Qz2kUR+yi9NVIWzag2MqFmfwD8+qIRr2nUuiMq2bg2phipblbSg8/+GzrmJKVVtrpwpUt5CoTsOa4NVHb/CrGgGhTitTd1kiA2tkkFzuGPYkAjsvP0SjfxNSArEIXx+kti/JsACfesQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 04:43:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Wed, 12 Jun 2024
 04:43:59 +0000
Date: Tue, 11 Jun 2024 21:43:57 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <pieter.jansen-van-vuuren@amd.com>,
	<richard.hughes@amd.com>, <dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC PATCH 02/13] cxl: add type2 device basic support
Message-ID: <6669278d7fea_3101294e7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-3-alucerop@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240516081202.27023-3-alucerop@amd.com>
X-ClientProxiedBy: MW4PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:303:8d::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 994cb7cc-f55e-433f-7f11-08dc8a9a4657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JC/W3I7Zqf7tTBzfQsnURI4vMpdcPvLLpl6b4l7pUQFwfaSRBcdgxn206pT0?=
 =?us-ascii?Q?DXYyXvSmri00wPAH+S7GepHcP+lvdIazEadUubWlXcvZod7jYUThfLY8HG7l?=
 =?us-ascii?Q?7Vc32lj2adguSEtoJYPDv95Z9txNRKn2SNkpbz5yCoWCcUPbvPfxPvEdwNAg?=
 =?us-ascii?Q?XzQC7vfjC7PyINErDhZ1PbG3TK3EgGJ1PBa38qINtBne18b3xoIfzMbZLYip?=
 =?us-ascii?Q?ehelWj1Ajy11k7PXjkbEGYvfUFTEmZLTLJDYF4XlwvwxvyxGecxPU1LYNs9g?=
 =?us-ascii?Q?eDLWCObckdv+MLiLmtP8YaNk0z245OdVJ2HS+vUsbMAMK4XnvsvU4XU6TayT?=
 =?us-ascii?Q?9K0pqE+KT03uA7r7b5/lKOyL6cW/1jYO015FQtC2cxwSFB4Xw8NSqvgZa59N?=
 =?us-ascii?Q?GQUNN6DdbGHzput4T+3bijNvxuAaZ6SCptoxRct51Frp44otd0lMlHeAekz0?=
 =?us-ascii?Q?TPmhQsEt7nBEmF2kuQ0+VbjWb9+VVDjgba1kUc9AAKO9+xkd0Ye3DKS/YUTV?=
 =?us-ascii?Q?b52JzUfQotPdt9bTD1IiNcKKpbR0asKoorMF62Y/wVSzeDwNj3eaVWYON02M?=
 =?us-ascii?Q?/yf7GnZbUTkxsXPEm/fFjBcwPC/sHOQ7Wm1qla56YObzKLbkXYtK6J8ihNAU?=
 =?us-ascii?Q?fzQTxx5lFALTezUQHQI7IWdtqieZobzIR6A0RPfgJV+lb27BqEAsOU4yxV74?=
 =?us-ascii?Q?2Y/c+LnVopsmmDUeJRbbop1E1FZ5v1Dif1AD3TnqYZNPDERRj9SBJF/2jZ6r?=
 =?us-ascii?Q?kgHdnnvbyeS9m6l6YiMEaXDbC1cABgwFuqquESZVtvqWpKrHXo68DFusq0wK?=
 =?us-ascii?Q?mdnNATecomIFBg9Ancir+LDNdR3OG6aIWtdJe6JoXVp9QLAkDFFeJT1V2H08?=
 =?us-ascii?Q?IzVM0FDQYTfdio1klT5mCUlKAAkgqCM8oaxgJ13Iv9W7HtZ9LDDFiT/6d5cX?=
 =?us-ascii?Q?kVY7kMkNVr/Ab2CoEvtaoy57l2rYuHNeHBPttOW3kEKoFUgtnLjXRZoX5/QD?=
 =?us-ascii?Q?rZpUq3vP8sq+tKsOLxGJbJivHq4eZ/BlNpK42PCils6DAePz+2ewpivDaw7s?=
 =?us-ascii?Q?hLwpCqzKONku/4De6gq2vc102KQLg4qecibqfz51jM55R1m/tN+jVisesOPF?=
 =?us-ascii?Q?ZRi/MOvZ7ax/XXcMAAJUpA0iRX8w/0+gUIBknK8O1Izl9ATyTLR/3tpgSxo8?=
 =?us-ascii?Q?6xChlCSboJytkLaobqgRvaOk9qB4MEJzdxYqsFBFyuL9AHr1IBBNcbBPe6yf?=
 =?us-ascii?Q?sAfy2uFbq8t1WhkTWZ1C1xVSDPpLm8J1JzieHdCTPxYE5jdmBOgmEVeXOkfS?=
 =?us-ascii?Q?zPrk2NxppRUBl/vaVC9xKe+5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MKMfb8ZkJw+itrFDLJPcRtZsfa1ePVGWHX2iqtkiEKHJbQPps6cJsrUJGGsn?=
 =?us-ascii?Q?wBWPa4ayOAMU55l5CJsbeipLyuOpgh5azC3UopKhH7OiZ4mih1tXA1b23KYA?=
 =?us-ascii?Q?ZiN4JC0DWrjIN1x/6j5kskXiEAGM/FMk5mjA46XUDzcOOmiOGHkepEPYAZFV?=
 =?us-ascii?Q?7hArrk/f2qPEZk2Z9qJx3Scug3fYXg7sbpZ3RVNbYyK+LjyPXUmDNIEqEwOu?=
 =?us-ascii?Q?+/dxM5PJ1ih4txgpZsxg+WP9p7pbg5uznAJlOPy07MAe37hmMg1qfsiCty8g?=
 =?us-ascii?Q?OcM+L+BQC69gWq06A888AZDbpU+oyW8d8D7WbPj+3QSlyfpLrYHzDPUG3/Hr?=
 =?us-ascii?Q?+ytUOu7xbdqvOMzWXjgSp+fMnNY7wPW7kx1OmJoF6xoG2MbxQ4OxftyqGZu2?=
 =?us-ascii?Q?LG0bORMntEWAZvKBVZ7tzoHJ00nda8x2qnBwYQfcqZc4RDmBtGgKTsI87STg?=
 =?us-ascii?Q?5yPQEeWNgnVwZRqx8G9Io9xDWJaIk4wQ3Qlgyb7gUp2vSz0QLpzPiU4aOpNL?=
 =?us-ascii?Q?JYfmRGiddvAswoiQA3hHKD2Y6yMeDLOUhzrHR73X/LZKjOjrMHTIdiWaNdOa?=
 =?us-ascii?Q?nBwpvvktbuf4iZDvP3iaOH8DcofQoB4//fcTF1iX98eSrERGDl1iEuYmNwJk?=
 =?us-ascii?Q?gTcfF5PQhmZIiLn9pngofyxUPqgDkQfCX5Zwo9uMopmQbIvDV2iRAyXHhu8e?=
 =?us-ascii?Q?eTk2I9+DMYlmCup73lxDH4voXYKJHz0JF1fmPQtwGUXN8hwtEufbaVnVk3qb?=
 =?us-ascii?Q?kdTKjyY0wjwgs7FTPTHRDJHifb3gdiVnnqBCPyUG21RJpAXOUFZNxpllXk6w?=
 =?us-ascii?Q?kNXh6pi9q5wufMwTesfEFCOdzQBneJ07fzbPN2GTIpqJV7uAoMFDT941rqrD?=
 =?us-ascii?Q?Q2vBDC2+hhbrLNjHrmGvrgPGnp5qDvCEZxsfpYKpOYH362FcB98VN9oCnnkg?=
 =?us-ascii?Q?Z7xc9Pgi4v8p9n4vd/Ct8mQc9N9NYtOzhW1fbi5UUJy5fClnBYM4EL5RFClr?=
 =?us-ascii?Q?D8XTo7Mplh8U4lR2VbM9xIU5I42aIUehREz/+9IsgRB0hSR0epEIMDfVXflM?=
 =?us-ascii?Q?OVMGSWEpWEuU8ORUtmVZv6pKGM93P5Pkv+LqueZYIC8dVaS/vr3Tj9WLTFpE?=
 =?us-ascii?Q?MNq8WNGI635BA+XRYSBs/DtgkXg8VbO68V+3k20IXU/T8j/oG+3uXFuZqHL+?=
 =?us-ascii?Q?Zc1wtsUZZah/DoAcpN3bU2TW6UwBlE/flUL3MwroxkJ/1QskQPpQ119sEjzW?=
 =?us-ascii?Q?lEI8SPn4JYMKixgXOqeT3/AqATA3nAg12h5CXL7jLil/7TOMp/Fwqivusrfy?=
 =?us-ascii?Q?rVeHNex8v7kIOLEZ5hKuQIp37ITLH3DglgNgfIAHfNFPnjEhNzi+BG7tS6v6?=
 =?us-ascii?Q?d2Hn4TpCAi2ZBbbnRcUiip5Xo6tuXQkLcY/QPuEXxsQ8qV7L0nLLbmSs8hpf?=
 =?us-ascii?Q?fLMz4Fqp5OjV+VLvL7peyvnIlLpbAOjQbTRSUrf8ccNB0Uxjs3ZF26jj+qqf?=
 =?us-ascii?Q?Sxw+JFbeeR5jbS6qA/lc2z7Rq1XvGCx5M/xELEb9kqWWlZjLH7fsNxTEVrTP?=
 =?us-ascii?Q?O9FzOiAYoTw7nwBdt2gqycSWtC8JCSDJx1giR7DFz5wBGM9PAHmWdT8L+1OA?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 994cb7cc-f55e-433f-7f11-08dc8a9a4657
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 04:43:59.0288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxvDRFDHlnajNS/FvGcp3eJ9KxnJ9KuR3ecoYoYSom7w5gFrxSa1T3XPjFkfsR0ibiadug9eRb8Q4e1J//VlPHxyrv0O2ECs+wMLqcrnEz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6083
X-OriginatorOrg: intel.com

alucerop@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differientiating Type3, aka memory expanders, from Type2, aka device

s/Differientiating/Differentiating/

...actually to make this imperative tense don't use gerund phrases, so:

s/Differentiating/Differentiate/

This "imperative tense" preference is borrowed from the x86 tip tree
patch recommendations [1], which reminds me that CXL should create a
document like that to make the grammar expectations known.

[1]: https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

> accelerators, with a new function for initializing cxl_dev_state.
> 
> Adding a type2 driver for a CXL emulated device inside CXL kernel

s/Adding/Add/

I will also note that ChatGPT does a decent job at converting patch
changelogs to imperative tense.

> testing infrastructure as a client for the functionality added.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

It would really help me out if the changelog mentions what you adopted
and what you modified. With a Link: to the patch where the code
originated.

I will still review the parts I wrote previously to see if I still agree
with them, but its taxing to come back to this patch cold and think "did
I write this routine, or is this new?". Can you repost with the
changelog commentary fixed up to reflect that?

> ---
>  drivers/cxl/core/memdev.c           | 15 ++++++
>  include/linux/cxlmem.h              |  2 +
>  tools/testing/cxl/Kbuild            |  1 +
>  tools/testing/cxl/type2/Kbuild      |  7 +++
>  tools/testing/cxl/type2/pci_type2.c | 80 +++++++++++++++++++++++++++++
>  5 files changed, 105 insertions(+)
>  create mode 100644 tools/testing/cxl/type2/Kbuild
>  create mode 100644 tools/testing/cxl/type2/pci_type2.c
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 07cd0b8b026f..0336b3f14f4a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -659,6 +659,21 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
> +{
> +	struct cxl_dev_state *cxlds;
> +
> +	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
> +	if (!cxlds)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlds->dev = dev;
> +	cxlds->type = CXL_DEVTYPE_DEVMEM;
> +
> +	return cxlds;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
> +
>  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  					   const struct file_operations *fops)
>  {
> diff --git a/include/linux/cxlmem.h b/include/linux/cxlmem.h
> index 0d26a45a4af2..e8d12b543db1 100644
> --- a/include/linux/cxlmem.h
> +++ b/include/linux/cxlmem.h
> @@ -859,4 +859,6 @@ struct cxl_hdm {
>  struct seq_file;
>  struct dentry *cxl_debugfs_create_dir(const char *dir);
>  void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
> +
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>  #endif /* __CXL_MEM_H__ */
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 030b388800f0..a285719c4db6 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -69,3 +69,4 @@ cxl_core-y += cxl_core_exports.o
>  KBUILD_CFLAGS := $(filter-out -Wmissing-prototypes -Wmissing-declarations, $(KBUILD_CFLAGS))
>  
>  obj-m += test/
> +obj-m += type2/
> diff --git a/tools/testing/cxl/type2/Kbuild b/tools/testing/cxl/type2/Kbuild
> new file mode 100644
> index 000000000000..a96ad4d64924
> --- /dev/null
> +++ b/tools/testing/cxl/type2/Kbuild
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-m += pci_type2.o
> +
> +cxl_pci_type2-y := cxl_pci_type2.o
> +
> +KBUILD_CFLAGS := $(filter-out -Wmissing-prototypes -Wmissing-declarations, $(KBUILD_CFLAGS))
> diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
> new file mode 100644
> index 000000000000..863ce7dc28ef
> --- /dev/null
> +++ b/tools/testing/cxl/type2/pci_type2.c
> @@ -0,0 +1,80 @@
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/cxl.h>
> +#include <linux/cxlpci.h>
> +#include <linux/cxlmem.h>
> +
> +struct cxl_dev_state *cxlds;
> +
> +#define CXL_TYPE2_MEM_SIZE   (1024*1024*256)
> +
> +static int type2_pci_probe(struct pci_dev *pci_dev,
> +			   const struct pci_device_id *entry)

So to date, tools/testing/cxl/ has been for cxl_test which skips all the
PCI register emulation and just runs based on mocking core-kernel and
core-cxl interfaces. I would like to explore how far the cxl_test
approach can go and leave the PCI integration to when a driver can
reference real PCI ids.

Otherwise, I feel like too much development effort can be diverted to
this "proxy" and increase the timeline to seeing the real thing.

> +
> +{
> +	u16 dvsec;
> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> +
> +	if (!dvsec) {
> +		pci_info(pci_dev, "No CXL capability (vendor: %x\n", pci_dev->vendor);
> +		return 0;
> +	} else {
> +		pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability found");
> +	}
> +
> +	cxlds = cxl_accel_state_create(&pci_dev->dev);
> +	if (IS_ERR(cxlds))
> +		return PTR_ERR(cxlds);
> +
> +	pci_info(pci_dev, "Initializing cxlds...");
> +	cxlds->cxl_dvsec = dvsec;
> +	cxlds->serial = pci_dev->dev.id;
> +
> +	/* Should not this be based on DVSEC range size registers */
> +	cxlds->dpa_res = DEFINE_RES_MEM(0, CXL_TYPE2_MEM_SIZE);
> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, CXL_TYPE2_MEM_SIZE, "ram");

Especially at this stage of the driver there is nothing that require
QEMU emulation versus cxl_test mocking.

> +
> +	return 0;
> +}
> +
> +static void type2_pci_remove(struct pci_dev *pci_dev)
> +{
> +
> +}
> +
> +/* PCI device ID table */
> +static const struct pci_device_id type2_pci_table[] = {
> +	{PCI_DEVICE(PCI_VENDOR_ID_AMD, 0xbabe)},

Real vendor-ids should have real device-ids, also that particular
device-id choice is not appropriate.
