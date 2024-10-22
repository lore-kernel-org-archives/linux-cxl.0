Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30E1494A6;
	Tue, 22 Oct 2024 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585164; cv=fail; b=Y/P7rr4di+dDlG7Iau5eU+fh+ufAtdbnT20AB4qJpjN3MONe+ute9R6P1E0fojWFsjGE8OE8PgDbDDYV/eHznBVv4pceiWVAS1frADfud0ViiVKheE7N15fNSIa6PbfC0v/iyKjowT4TA5DIeU8pSSUuukEsGjaO83TL1omo1bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585164; c=relaxed/simple;
	bh=Pgot3s2ddk8YO0afePXHOxXbUo8w+39jmqCJ5euRwN4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I/n0+yCZSfpnk50fhLuXrMkBzuEEYY0xLMipS2Y+HEUL/bt0puW8UTKqjI9BHVQfBxVQ5wZYJ9w5F9GcfbJjQzwPYJyrKZxSep2DGM+fpLccdbXdECpNDy3/jgZaXKMla+xvBm3PdSnYqSQSuWd7xbJYsX0k7pCBkcLX4933ulo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GS2C+W2l; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GS2C+W2l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729585163; x=1761121163;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Pgot3s2ddk8YO0afePXHOxXbUo8w+39jmqCJ5euRwN4=;
  b=GS2C+W2l03/HhLxQznuApC+q3r0wfTemJfDl2q/J2I9NxXnH3tF5mzZj
   MJvBl3jlsYq6cQ3JKJFjtlJfkl3XUIXZgGcnKTGroKVotHNWTd50ysO6I
   E4La4Mss/XRR9GQ8iRB/GzOj3UIIuNukMFQOlEyr96FdH8KinzHHhzNjt
   99TYIYoxgMoHcvSSXwkF7vmZMexEXU6eu0L2dSMtqABsJ9h2i93ZB2fsP
   MSrozcCOVEIBD6sFHvm+5DT9RSghp4iPyH1ld9nvEcMazyLjDv4Co8KWH
   th/6Qic2RCIjr0H+/lWoRL02GgFyAFvhCHry8vH9/H/GM43iHW7M926KF
   A==;
X-CSE-ConnectionGUID: lpkrVeyHSBK/tGZjTgrTZQ==
X-CSE-MsgGUID: MQVnX5eKQ1yJnGHNgD2aNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29258081"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29258081"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:19:22 -0700
X-CSE-ConnectionGUID: 51Yf3e9kQGiTaOyBIFHEyg==
X-CSE-MsgGUID: K44P1tNNRwqpVP5Mwh5QVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="80598547"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 01:19:22 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 01:19:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 01:19:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 01:19:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMQcxbbHiGLDZNieNjoVtegj6dZtLq7pSpHTAzKhhQGmYYVb3OL2Ukcl9JPKec4kghq+IRftNuX+tNiWzK8WLN936uQXbgmaMZhDpHBfJF38TEz6JQbmnd7H/Fxrl/XggeANIu8JXGSWXAtTVZnTCgQILonY1LAuE/QN4TgmZE7bWjt6xnCa8GAykRiz9lZ8dygxJs4g0m6pk8/w9nZz+1BUGlyZ8xCLNiq4D3uy+heU0rWqF7R1q3qgJcxo3ApZFVX9d15lI4Sxkx3c4DNFFM7KP2qB0LyhC5BVz0rN55M9Ubl6CHfX1Cudm78tmw21HttvCsMsEJYfj6NiSh9Lsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaNVusM+TeQ9qtavOLmS+uW6Zv7j58P7JtDqtVuCtCg=;
 b=qxCyg/qkdy/G69DMBG6boXm9BWAH1wx2q7QXIbyYLgL0phAZbh47BOqFcXIJV8DAjLrxfOsPSQfPMNN6cJ9bP9NFFRXHVUugzKcPrtNwq/VeAXBuKiSfkx9CZyQTMXwnSbW9FHSiXS9SGhgXbKmTkxqadxoMWTKwTJJcOwJbLL0kwf1wFFGviIRxr2SleICMq0XVeUIXk42NWrDb+bnjZ/gL/g7MTp3aLq1ervttgj7bi5xEeBqYnpNhGsjqh4SikcZnGFBVjL6VDBG3wmgs+tV7ouR8/NO1RgR/fmmjLRMswKDf+LhWyuDONMF+qB2/Y1mWswKPyf5eqD8WKruKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by PH7PR11MB6907.namprd11.prod.outlook.com (2603:10b6:510:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 22 Oct
 2024 08:19:18 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%6]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 08:19:18 +0000
Date: Tue, 22 Oct 2024 01:19:14 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Huang Ying <ying.huang@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Huang Ying <ying.huang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alistair Popple <apopple@nvidia.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Baoquan He <bhe@redhat.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>
Subject: Re: [PATCH] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
Message-ID: <6717600289c1e_2312294ab@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241022053835.217703-1-ying.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241022053835.217703-1-ying.huang@intel.com>
X-ClientProxiedBy: MW4PR04CA0106.namprd04.prod.outlook.com
 (2603:10b6:303:83::21) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|PH7PR11MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f71a22-4777-4da3-546b-08dcf2723916
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X2vUks3DZGlKBF4sXXchSyUZvKhCpFqhn8LjWExLcqQTIkwujwDZSidPmOYT?=
 =?us-ascii?Q?cKjdZdnc0oSZ8h2Uou3KvJtvUeORwQ0/KVsVLdsjHuEyNZA9r+LZaZax268w?=
 =?us-ascii?Q?STjHxK354Fvw6qEk5BgnmCdrlfMEA61aiTyyaIv0thDJcIX/NqBOAgxS4J8H?=
 =?us-ascii?Q?zxf+75FFe/W99msoWtkTkwRZAvNO6bqnA4WSu+NIEGD6uDWqHduMmi14g1W+?=
 =?us-ascii?Q?dTrhchKbtxoLHCpPV3bX2CQX8JFy1V7d/V60O+PQ8B+9Ygf8o5yW5maekqsV?=
 =?us-ascii?Q?851SNhUOHdk2bg40nxwJ4jy0wlYkGQ3rkLexcOr56rdmdQppMVhLfWZcIICT?=
 =?us-ascii?Q?z6B8XZYRjhTJM8Z0r1+0GpEoLifwd0RfiXY916RmTHDMVuLpaNZrLb3kcNEQ?=
 =?us-ascii?Q?7frSzxZusDIqPYt4OATlJ9Bdg+aiQwiAN6ofLQvsmrAkjuv4pn0RRWRBMPNP?=
 =?us-ascii?Q?zX1pbEuK7xHqc3AQgj4neK7VrS75DaQUvBQ1QmO8LMBEKQL5QVpOzys/MxI0?=
 =?us-ascii?Q?0H04TDhd7lcXSYUUk8xzLMUNhGqwIun+n+dvcuX/vONlUFnG9Su0FUlta6lR?=
 =?us-ascii?Q?6Ctz+RMJpubSUjZxbB2Q09+RMTO023zDLX2zGdQWoxRjTGewcbbzHV6ysMSP?=
 =?us-ascii?Q?O5+HIDdQ6mYwbwtEKpoFVJsegl7AiQwSD4aLHm82cjNiiyQ23UntQQr+Ailf?=
 =?us-ascii?Q?tPCGarulc2IDM81aaAOxmvORbkEnWOVYjoWB6gIJb2WZP5uCxckuIm96k8T6?=
 =?us-ascii?Q?Qrt8vL3NpLkM2MYL8AJBPeDKBXgvPXmIfGn2mRWwEau6IdyIigWeipmfgJZ+?=
 =?us-ascii?Q?MLcZBms1vTcyrByR2Ek+Gog4aholuAEth/i+Wcc2J/CSdd6Ph9tKIvjXIcil?=
 =?us-ascii?Q?OQpJ7e+sI/SOMmlVBtFzDaNI5irRDG5tlRvZvpxRvMQpR00pEpxVbRKACsoV?=
 =?us-ascii?Q?Hq5DBjJZhZoOAeAB3CTTdo64c8GOU/E0iijEOrS9AEpk2kHycu92KwvnrJD8?=
 =?us-ascii?Q?jM5KVnhWBKaVT+lCLVU/+fyunlztgQXTxtJgTIUOpFMJZvA3Xw24kDWc1/Xd?=
 =?us-ascii?Q?DOQbDKsIs29rmurY3tqZHiqx3i5bAPR7Byqy7Tt6oXnt+aVe8Q1GcipsKqj1?=
 =?us-ascii?Q?kMifPlDCJ+VotbKB5n28l05AzrOoCiMcUg3+/QnuSGutmzcIWCNZWO6klNl9?=
 =?us-ascii?Q?0hPv35As3sz+VOhkDYmcp83w4cYaTAO15HtD8EngfkiWmTE4bmFUBZYWsjn5?=
 =?us-ascii?Q?UVHxkZxeuuIAl/QZH7toiq4XM/xJKr8xfFABXanN7xcgWiB1YmdROcPzNJm2?=
 =?us-ascii?Q?hBOFiA9Z5jsKEwIMV3Ks5ADd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ii0fUdytmnH6ApJapMbWEft9dLy1u6na2o87cWTn2ieM45vBrLO4ZROTlZEj?=
 =?us-ascii?Q?9rhMD/nYK175gk2367DVh87Geu2Hol4adDFlP0cHuiHVavFyA7oeK9p37XRm?=
 =?us-ascii?Q?gpBGpxwH94NIvmJiJd12AskpsSn8VSqiYPCidQc/eHgCjvK3oCRlmIqQ6Pfv?=
 =?us-ascii?Q?2+OjaVArLFu3uxlpjxvudb3MDW007G1dYGL5hLTK9iZiqCbSHtjEd/K5WxxY?=
 =?us-ascii?Q?OEoCIGLSFdFojxHabb4vN38dR65NR596UON8JYMBPpcifV64a4aeSNcHjjh9?=
 =?us-ascii?Q?kwvk9gGysoJaWVKUXp2L7dhr5Sp0vap3dHyHWJlSlG7CBrqvwaZCJ1wd9DU3?=
 =?us-ascii?Q?PbAqIWOzFMmeIQURP67RpCjg6HZCfSK5iblQfW8oydYvtOct5B4Fm0SivVdN?=
 =?us-ascii?Q?oMAGJyRnI0Pp+JzHS65AvmrlBbLewTWwRhFs1LzPV2yBSYNaNOm6w2vWNQBQ?=
 =?us-ascii?Q?5W2YjkG8ulbgdNIv5a0evdCftGnNXr+IpwB+mfI8P165v+UQewrD+rRsrgh2?=
 =?us-ascii?Q?orLObeEatKD3fVpp4OXdY2Kl921bmImQoVwNVRRj8/4k1S5pr2NPrNX7HlEy?=
 =?us-ascii?Q?tnBQStyn6U8StEIaieALt/YKKuLS+1bth+ttHwjFfrAMipM/p81L9UcJ2oHM?=
 =?us-ascii?Q?OWkhQW3PBeLL8T69StW5ueV+glDG1PCTAWl38G7uQZjwMgJR2se2VsFATPc8?=
 =?us-ascii?Q?FX6r4dnC+wYuJrth4LNoUG4lOIVAyeyApf0El4faI3us9q1ZEYD3ucobVZy8?=
 =?us-ascii?Q?72Sde5F3LFMx/LrN62s9KEkk9xd1QgmeY2iD3814wlASYw9QEmzZxdobNi8t?=
 =?us-ascii?Q?qci+fEwUhRqompbrMICaEDg/ftawCO+R+N5AVHq+E7ZnpJ2ZqyhQB+Hpo7o3?=
 =?us-ascii?Q?qsKdHJcZEvWmEoi8KJMCvNNUsNyPhciP3eg7YJbUraias7Q5L9hSjrvDKdl2?=
 =?us-ascii?Q?t79KWlRTF8BiUX1hdHu2aLwVMWbWRa85kWqaG6fN7rt8tEOzEm8uxf2j1Bob?=
 =?us-ascii?Q?zHUO9beNFf7P3DZzIIRFh/piCdX2NVIcgaFlHR35QlI3aDPz9d8be7Oy/ipk?=
 =?us-ascii?Q?2CnAb3mqkf3XqWK/GSI87wc2yERhxv3wpj8nEJAGjMQ0g1Ub5PV+WTsNwLiE?=
 =?us-ascii?Q?tncOsf8NPJq/Cew6NeGvmmFtOvfcCdRZ5cUAlQubAmK+sosRvxDwDcK9KXsP?=
 =?us-ascii?Q?oDPRtL/9D8NiFvkq/MyJ95ByZju/SyNIbV6NytiirHz35j9YmW6iDjNAWFYD?=
 =?us-ascii?Q?sli/4hM8/G/zhUw8ViXgaOCpYOg8NBvUmaReZBj84VnAqY/mB5QpNqk5H79M?=
 =?us-ascii?Q?vekl8MtiFLxoEMYh/LHDsO4oVEAAIUXFyX8K7fgL6rLQBs8pvLN0t8zdsel8?=
 =?us-ascii?Q?ue93AKFBrrR7jwcKNGjdg0AKpTBm5eZaVEFjw3bpTNsM+SV98uT25divG9he?=
 =?us-ascii?Q?2pXgyRpZxFL06dnZEuHbmGc2sYfJTf5DfI7Ufk8tlY5DuAVV0nOYbiYExsY7?=
 =?us-ascii?Q?uFEd1qyTyZcBV+t8/ku0j1HTe8JZxqYCHqLMHHj7TVhVUyY3AseuD5agvUwe?=
 =?us-ascii?Q?SgSE2g5uZOtCM+BoDbw0jpgwPCcJR6oJMADL1/zOIUWo4+TFqPbm8AMDPmca?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f71a22-4777-4da3-546b-08dcf2723916
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 08:19:17.9030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqhZr24TyDyQW7wuKNOEzOZn+WwgksoLEuZDkh82OGMd/R2KuCMlzW7ByTJzsWZBKe5kmCnP08+PHvjfevjKU+AlUjJgUm678G8WxSvfniY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6907
X-OriginatorOrg: intel.com

Huang Ying wrote:
[..]
> For the example resource tree as follows,
> 
>   X
>   |
>   A----D----E
>   |
>   B--C
> 
> if 'A' is the overlapped but unmatched resource, original kernel
> iterates 'B', 'C', 'D', 'E' when it walks the descendant tree.  While
> the patched kernel iterates only 'B', 'C'.
> 
> It appears even better to revise for_each_resource() to traverse the
> resource subtree under "_root" only.  But that will cause "_root" to
> be evaluated twice, which I don't find a good way to eliminate.
> 
> Thanks David Hildenbrand for providing a good resource tree example.

Should this have a Reported-by: and a Closes: tags for that report?
Seems useful to capture that in the history.

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> Changes:
> 
> RFC->v1:
> 
> - Revised patch description and comments, Thanks David and Andy!
> 
> - Link to RFC: https://lore.kernel.org/linux-mm/20241010065558.1347018-1-ying.huang@intel.com/
> 
> ---
>  kernel/resource.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index b730bd28b422..bd217d57fb09 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -50,15 +50,34 @@ EXPORT_SYMBOL(iomem_resource);
>  
>  static DEFINE_RWLOCK(resource_lock);
>  
> -static struct resource *next_resource(struct resource *p, bool skip_children)
> +/*
> + * Return the next node of @p in pre-order tree traversal.  If
> + * @skip_children is true, skip the descendant nodes of @p in
> + * traversal.  If @p is a descendant of @subtree_root, only traverse
> + * the subtree under @subtree_root.
> + */
> +static struct resource *__next_resource(struct resource *p, bool skip_children,
> +					struct resource *subtree_root)
>  {
>  	if (!skip_children && p->child)
>  		return p->child;
> -	while (!p->sibling && p->parent)
> +	while (!p->sibling && p->parent) {
>  		p = p->parent;
> +		if (p == subtree_root)
> +			return NULL;
> +	}
>  	return p->sibling;
>  }
>  
> +static struct resource *next_resource(struct resource *p, bool skip_children)
> +{
> +	return __next_resource(p, skip_children, NULL);
> +}
> +
> +/*
> + * Traverse the whole resource tree with @_root as root in pre-order.
> + * NOTE: @_root should be the topmost node, that is, @_root->parent == NULL.
> + */
>  #define for_each_resource(_root, _p, _skip_children) \
>  	for ((_p) = (_root)->child; (_p); (_p) = next_resource(_p, _skip_children))
>  
> @@ -572,7 +591,8 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
>  		covered = false;
>  		ostart = max(res.start, p->start);
>  		oend = min(res.end, p->end);
> -		for_each_resource(p, dp, false) {
> +		/* Traverse the subtree under 'p'. */
> +		for (dp = p->child; dp; dp = __next_resource(dp, false, p)) {

Perhaps a new for_each_resource_descendant() to clarify this new
iterator from for_each_resource()?

Otherwise looks good to me:

Acked-by: Dan Williams <dan.j.williams@intel.com>
