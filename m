Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F0E15AE6
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jan 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQSk47vv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704223642; x=1735759642;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wM/T8ID7WrFqeeFpbq0T3W6xdgfX5MrH6WwUAX2Bd0s=;
  b=HQSk47vv8j8staJeT7uV7Rtl8PwCc7QGU0iXbmaFjJvCrc3W+qojuZzh
   BRCTWm9gTQjgJTsMYSHCxcuGwFCCQLyD3MdaSRILcgorab0Edn7lZlXMO
   lDfO4eJJ553nmcjdgmITnDoo5lBWjNLWhZaKMJRIUZjypVC/Jp3kKDQVH
   gZGVr+My8NyBOp7c777qQPora7iHftF9DBPTds6BVs4FoF49EHeWy7qU8
   9ECieNkVHgmHbuzHo6EX1vsrSAM1TZHSqzOzm+CEMgyKveUI7LNzlW0P+
   QYNWf3nAd2tksmVPtBjXKffbtqOjfTOzFcZ0UeBapFHmfpf+BF3mYyolZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3749605"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="3749605"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:27:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="772930468"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="772930468"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 11:27:20 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 11:27:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 11:27:20 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 11:27:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2Bcfz59vtpwKVO0gBCaezZ7a87Heg9whIoexEeRQnfwQw8ZN1NBPlZtkjOy1Iuvm8A0gR6V8wAhJ7Ha/Iia7z8HtThAlBX62r7pl5rM8urc0l9oLoJh6/wl1qhJhg2JTJMW7v5wmisa7JBHbr8BlwCpdQQpz9VRfEpZIpdWTCfTLuV09rOh1Lf9Bc5idE6zTwDRU8nCbNyDDJujzqWZgwCEqvHw9qNUFvtTruUtXKJOkiqaHZtK7smZz0RLgY34dma/mHSZng/MZTuAemEHQxfmk4WbQy6wuXog86lkC+b2VufNlQJS1H4QaDSNOmj1ED5RQSslDVUn11ZT3pP6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBSyoEZ9h5YuTYTYGWmqbF67CJiqnBUJhZ9l2aPVbyM=;
 b=CATqNivdDcTVX7PqOFsGMDJ9CWG4iiYJ7SByFVLP3Qnwywyi1dsnZTm6fZTgYVmRY7aShdbItpN6e/lVFE3+uYEVyn0+uJaKQ3RsyJKGULLFKR5FOxvo/p63OoWeqCpLkaXo74m15CwYNepRfaPdayaCEmJCWQnlVX3x/BqTpIH77VQxgD5sfuC5Y+oatixAyROfR+UiW7ZdbviFMUFfBeNJJecZ5cxPr3cMrLAN0GrHJkuN1tJ5gSISVVeJbXen/O6DrNOSpMn33cFN/tXeEOgPv5/PlHdStD2AFq5ZhxhHIS9V5du1GuK61t9ThbbTt1Aep5D2Nk49MESer7RH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8543.namprd11.prod.outlook.com (2603:10b6:806:3ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 2 Jan
 2024 19:27:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 19:27:13 +0000
Date: Tue, 2 Jan 2024 11:27:10 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>, <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Fix overlap when extending memblks to fill
 CFMWS
Message-ID: <6594638e14a2_8dc68294cc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231223000025.1401076-1-alison.schofield@intel.com>
 <87sf3rf4ci.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87sf3rf4ci.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: MW4PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:303:85::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5000d3-5ad8-4b0b-937a-08dc0bc8d234
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKm69DqAMrNlll2CuN78nPOXm3tsBelFDC7nieIdvCa+0uO0J75GALNqr5HJTSY43/BgEIQKEuT9TSq407eAa5B6AzS/qLM+3uZu6LowFlSUlfpXEH5fBqGvDYkKs+bApo3EZpuLxOHhAvv5h635QSG2qdrZSzXiGnvUdsUs8touzAoSRpD56PPO01WNqR0VfWvXK4o4FekEJcKHEn6G8BFJ4WQSKRmmmMZkn8yQkwrpgBlAW4xZXCfKckm5WqHkfuAC1XyyzDJYiI0+tEzAbqcgtXEp0HOyV6AvxSPl2xmZxwzAkxvvStPkEdZMOn0VqdeFD1m1yvl1VS9VznbliewCZPRunV5W24CvZahqhRqaPOQ4d39otY4PNgGSm9PRmIBDGsDPhcGYxZwbzjJ90BYMHhM5ydMc4lJaBshOTclWwAPKm/LznntlvrGc7cXQsXM6kEMK54ucLN86x69a2V0TTkiwtu7eCBXsBbBVOzjfqQnPb/jLvSeS0U+Z7eEqw/SITChhJtpRf3E8W8n6y5M5jSFVvQ+A7q/vGJWwhBuwX9N2IEPb24wS1cVVcMM8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(83380400001)(26005)(9686003)(6512007)(6506007)(478600001)(6486002)(41300700001)(54906003)(66476007)(316002)(66946007)(4326008)(66556008)(6636002)(8936002)(8676002)(82960400001)(86362001)(38100700002)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?15dH9uSJAPXkYPvLvVMVF+tmZmKHRF7QYfoaS+RZ/nElCA7A7WLkAnXSmGKe?=
 =?us-ascii?Q?8cEzclb0jygZWYEVjIOptL7dQ0YF8lZ96sGB/CLhrS10+ag1frQIbXZABE35?=
 =?us-ascii?Q?XpmVXjMaddmUGiy3EZk7CC7a3W7er3VGPYWbP9hlYpIcO8Y32eY4YauESIsC?=
 =?us-ascii?Q?MlN1nVuQr3Yd+7uvVTApfck5rXhMiKEwWjX+xng76SbgmEsaZqvrZs6fStnX?=
 =?us-ascii?Q?zJ81+8YY/eNzkMyUz/POysDqM4osYRIrPXqsZTcjLZPwgR95CYFv8I8XjmKE?=
 =?us-ascii?Q?V+qYr+mq+QVtxa77hT/x5hN0Rew4jd/Y3UCdjC/DV9N4ymvjVPL3m9hpd6UT?=
 =?us-ascii?Q?zXNHnGK26SDm112h7lsxMq7UtcotS2+ImacXHzw4Vvu6isxW0OySocawMXIL?=
 =?us-ascii?Q?Gm/zKhNa/TPb9Dd/oCVLyJhzAwmaYBCWz/ILy+CaGmeZTmMXYRBXnN1C1zxu?=
 =?us-ascii?Q?FM6UdcWXL6fHzO2fv+j82/8cuPcQmBOCSVQhu2Znw9ZMuzIP2QzgYXvGQXks?=
 =?us-ascii?Q?SoZl4kEjiV9XOml7ApimQetd1HHpj0qYrYq9AsPcIVcEdrXMK95KOl8BwYA1?=
 =?us-ascii?Q?XkzZbDKaTaJmwB5iiRZAzMHtvQBt1jZHbaShSH7dE4TQLZ0N86nthu5R7kZj?=
 =?us-ascii?Q?yMj63QlLSHgbpS7u5qp8arG3Akafu8oUXvYP+CjBmGQ4QhjTakgcyTgsHB90?=
 =?us-ascii?Q?uqH/vsgyPEBHwnqbsG1zsztJAU11mu3R5CmLLdofQiV4fv3CdVO45LIR1Q3d?=
 =?us-ascii?Q?wVbHZX0FeTZVIQZLe/r5XPeboWEDFKxDpGfENEJoQokLTcEFvXPrHLnEe6iK?=
 =?us-ascii?Q?fXnzb0RAyeDbh6A93PqpmIEczQkESGvs6d42TApzawoYno/moAzsjzxWLSY+?=
 =?us-ascii?Q?aN4rhktDCH6QDo8ii6tmJSJqooF6kLii4nJ4k8ffMdLDKGJi6TormAXHJk/m?=
 =?us-ascii?Q?1/In12yrzAkipKVAONgPRMHBnbW+WrTHgTOmo5CmvLEVXM3lHEvCUCQUVcq3?=
 =?us-ascii?Q?sfcj5urq8g6RUi9EvldldnDNFIPjeaCDIFXDlEZEqJ6jmxcoifwsNLwCfHVp?=
 =?us-ascii?Q?9RyxEgcwq89gLmkj72NrjYZlYY7oLBaKDw1uEqkIC91XQ7i+9OD+fIBwa2mg?=
 =?us-ascii?Q?94HoWHtRAV9Rswmc5ckFYP6Z2E1Mo/xAMpPfiqi4PgY6Zk8UHxWmChZLv5BD?=
 =?us-ascii?Q?NHbyupi+403Gp0T+s15AgwWDq40X5nqQhBW2nEUdk37HtYKeFgFs3UO/ETNm?=
 =?us-ascii?Q?mWltipi6y47x+lUXoi3pP5wqdpNnArJaSA7jDZa6P5jo+yoTM5qOF/GnqFnA?=
 =?us-ascii?Q?j9q5K94juaAS+aWUBfeNsPHKHf+jNOxGyQF5/Sr+CgzIOww0hK7iiYxhKzRU?=
 =?us-ascii?Q?tOjVnj41QB4iGGsONkyou9KKhZ6PQtg4quDrvPTkIlSFk2qLfBGYD+/AP83p?=
 =?us-ascii?Q?zHYP8YFwj3IYRTpn9stLTT39aphVHUdablha10SwdkVyRxDo5+vM9mD2/7Js?=
 =?us-ascii?Q?bYqM2qlf1Vym/g7M83lRg1+O83hAUB7PVNkNbr7oOoG39XKRirWjY8R//eyy?=
 =?us-ascii?Q?my3D/UK46zKJsGvWtHp//XINBoPl6zYSJFa8Khcb+uWb6u5674bfc7lkwEr5?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5000d3-5ad8-4b0b-937a-08dc0bc8d234
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 19:27:12.9879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8d5bnks2eZGItWWqiIaSdwD54sfzTCUDlJIWufYCrLKzPAVCtUSXXINltOExFwusOzo7qcZqOllqAK1H74W9n8cg44/SCZwZEwQwemTBrv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8543
X-OriginatorOrg: intel.com

Huang, Ying wrote:
> <alison.schofield@intel.com> writes:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > When the BIOS only partially describes a CFMWS Window in the SRAT
> > the acpi driver uses numa_fill_memblks() to extend existing memblk(s)
> > to fill the entire CFMWS Window, thereby applying the proximity domain
> > to the entire CFMWS.
> >
> > The calculation of the memblks to fill has an off-by-one error, that
> > causes numa_init to fail when it sees the overlap:
> >
> > [] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
> > [] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xffffffffff]
> > [] ACPI: SRAT: Node 1 PXM 1 [mem 0x10000000000-0x1ffffffffff]
> > [] node 0 [mem 0x100000000-0xffffffffff] overlaps with node 1 [mem 0x100000000-0x1ffffffffff]
> >
> > Fix by making the 'end' parameter to numa_fill_memblks() exclusive.
> >
> > Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/acpi/numa/srat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 12f330b0eac0..b99062f7c412 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -308,7 +308,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> >  
> >  	cfmws = (struct acpi_cedt_cfmws *)header;
> >  	start = cfmws->base_hpa;
> > -	end = cfmws->base_hpa + cfmws->window_size;
> > +	end = cfmws->base_hpa + cfmws->window_size - 1;
> 
> IIUC, this makes end inclusive instead of exclusive.  That is, from
> "[start, end)" to "[start, end]".  Am I right?

"Exlcusive" => Exclude the last value ("cfmws->base_hpa +
cfmws->window_size") from the range:
[cfmws->base_hpa, cfmws->window_size)

> If so, later in the function, "numa_add_memblk(node, start, end)" is
> called, where "end" is expected to be exclusive.

Good eye, yes.

> And I think that it's better to make the parameter "end" of
> numa_fill_memblks() consistent with other numa_memblk family
> functions, that is, exclusive.

s/exclusive/inclusive/, but yes for the immediate fix. It is unfortunate
that "end" here is different than the typical meaning of end as in
'struct resource' and 'struct range'. I would love to see a conversion
along the lines of:

diff --git a/arch/x86/mm/numa_internal.h b/arch/x86/mm/numa_internal.h
index 86860f279662..8a0eeac9d64b 100644
--- a/arch/x86/mm/numa_internal.h
+++ b/arch/x86/mm/numa_internal.h
@@ -6,8 +6,7 @@
 #include <asm/numa.h>
 
 struct numa_memblk {
-       u64                     start;
-       u64                     end;
+       struct range            r;
        int                     nid;
 };
 
...and then intoduce helpers in include/linux/range.h to remove the
error-prone open-coded versions of all the range comparison math.
