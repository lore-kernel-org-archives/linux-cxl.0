Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753273A4F58;
	Fri, 22 May 2026 05:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428994; cv=fail; b=S+vPRVyr4COU4FGPWZmG6So9JkLmTNXXnNqAsSOZyQcGIFCwPfsABrV7UFSWdQPM7idHCfIPwLt9sbfI3e8uz/GWgk4pJMEMw63qk6wasQcBqGCw/8rYRzuLRCynKcYiuJ4Oj1nplTy8OMpas+5FRrEZT9SMHBt66q2xV7Jd/YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428994; c=relaxed/simple;
	bh=epDVr7IjwVIOUlsr+ZASeGgaNzJ0Cg/TIYuKbFbdqqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h4oDiEhz9CT9+uEPZfQtMbPy58tEhEGn12yifQ2tS9YsidWkk0g5lgV1QldXPn+whX6Hj87BZ60hGmIgzRQt6tirAdMOKs2hmPpaeggax4Vho+lzGjMShizWB3cLWmG9Hl+UAIpSLW8hNWfwhOxO3RiG02xY/FL03s2BUyLSEQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mqgxmRAD; arc=fail smtp.client-ip=40.107.209.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mqgxmRAD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCT9uNr4rzVm9sQt8pCp7w/mXHXkfBPHnn/jThof2Ny1dORy21X1L8mpZw7gWCv/ATGWTE+QLOXpXppUJl7N7lL7tzFbqjki53O65nYsuLJle7BLJtxi/QIOvRTFBCXpZqZQXI5wT0wQdy9ubfGfe7RLhXp3gCKJtvIEyX+CDz3by/i+fSsw0ATVGEH27OA7465QHzpAsub0yiLrwRpJTB2kjpFSuJApZGW069DSpSR9CNI6yrvTuUtBkqGNiTfUFkhKDY5dC+6kQqb2OmeCcE3BqHYkXRokOd00DVU0AdZWSjY+is+wmJLDFieTun6T0H7klRF4wZmnwJneSWSMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbauWmAy8pnxIUZFqXe23KVHTJg2CpNtzZjMNpU/s8g=;
 b=Vt5QHEg/v3X/0cyhbb5o/BtzOad6+I7hTsIu2R8J0wK8smlnhyGWjDKfeBtASqWjVVWO6BRvOczvjctjR3gxIQfgqE1MKeAlKiDDmgsNurjH6sdI9DEVxJHB6YZJXYUUZkdo4J5hK2223+QlRbI77uAxPHA50V6q/AQHWdX5Ha2ACBQSoqVM5VhtMq+z5THVe7HaGiVFffddAAbginOOhDmhzCm452cGrMlh/6pfWsb94c92xOhH3lhv6O7Cb8dcpEBT9L1D4Lsp1PBsifo/sxXzym9EU8NI1sn4XIwCMPhGDj06kc2FHexr0SPh0HKOM0suxZqsg/7F0b9gKRD7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbauWmAy8pnxIUZFqXe23KVHTJg2CpNtzZjMNpU/s8g=;
 b=mqgxmRADJQ+09Qg6kZDA7+Xpbbdz7kL3uTBmv4FaUsRTHwB8uUlfaeD1+sIVZchrzfepg85PaqN+9xToxhtHsHj3rLuMtEHDdtdqzLoOjt7cX5WiEmHap8oTNGq7wzf6PJw7VQ0myqsfP0BW7eXOIMq1wjg4vchkQrgxd9Y1xOdN0b9N5hojlXqCCidX4WOslLsRRQ9w98dpTOcRi2cBuO5TkgKVNbkAQ19qu/sa7LriRDGNNywR+oXZcmnb416WrlgLEx+1uFV57Zmycwcgy4TC/WeKTiMeXfw65Qvt2K293B9G7SteT/kLnBlG5a7asgyE0JTG0TTxqgTcOBXbSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA0PR12MB8861.namprd12.prod.outlook.com (2603:10b6:208:487::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 05:49:46 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 05:49:46 +0000
Date: Fri, 22 May 2026 13:49:40 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	jonathan.cameron@huawei.com, vishal.l.verma@intel.com, ira.weiny@intel.com, 
	dan.j.williams@intel.com, fabio.m.de.francesco@linux.intel.com, rrichter@amd.com, 
	ming.li@zohomail.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH v2] cxl/test: Enforce PMD alignment for volatile mock
 regions
Message-ID: <ag_uB3yzbU6fPAFi@MWDK4CY14F>
References: <20260521083257.27753-1-icheng@nvidia.com>
 <f98724ee-249e-46a9-9a07-3be0e436adbb@intel.com>
 <ag9qEdwvqc51Ju2B@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag9qEdwvqc51Ju2B@aschofie-mobl2.lan>
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA0PR12MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0afa74-cd0b-4a48-cc07-08deb7c5edc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|56012099003|4143699003|22082099003|3023799007|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	DmCgs0/vGOjFQDzw8HCwcLRq0Ah119PF2ko9gjTMGCKFtshyvElVpIa/S0EK5zF+Sd4BBQREPvXbnTEI9faFhIontwNUenf1gL8ezuwBZYL51laWkLoCRz6N0F9/HI8p6WOjJuvUqLtxYym0w3mj+vWNIgP8GVMfJyj7ox7sUN0ItNano1hoyY0EjPTIw6PpGdolnZYGJ67um3T180MNrdafN0w9p919tRF9PHh33FWLMmCeEi4lAIK0iMLsqZCxqoGVm84bBl48Js8LarbAKZOuzFtQ+F9GWeGwozoInO072uuMWQyb/6055knQCmPtdgLS1G12lmgtlgsEon43+gpgOjDj+bGbb8FbhLclHZ/J0IADtbW2aVQF0NHOINTW5PU+uJg2fMrXLdiBG4Tun9ZGNq3vv8Te22JP8zJGovr69O09BRIP2ZTpuimOf/pUmZGShXkS7cuGXm2ARZ3YyWDC9yvwgEqIA13uESKKJ21xk4Ne6lCkwLM5y/FpJn7qKiLjq1Md4bbXNvJnbP+j3vKgurPhpr+KhxR95bFDJR79ocrGKNYhN/WfSpnugVfFYKMrxyXu5ebpR526Y+f04onD0ydzMD1NdHcs+vfF0dr7K3wX1BC4ROnoDf5xX9IY6Xy5G8PSAltOENaycyULd2YnF/gLPe9rTOwKonCtHC2E3ZyPvSCZqnDVNBnB3qC5CGCLlQnYmQ5c+HUDkIS32w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(56012099003)(4143699003)(22082099003)(3023799007)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Kz3FJ19/OfQl8PSTOWyPQbIWlCbsf3UQu4kAId5txQy1ReiqIOkNxPvnZLe?=
 =?us-ascii?Q?v3YS9x4+K25BjnSKB+dHkDBsgyp+TDbX9rL2MKyAjMkojNzTqN0F1uXFdHFb?=
 =?us-ascii?Q?gNpVZuNWf5oCX/6mBfPkPYrHKSul1RoA/x5rl3uURU62S5BW6EnjRY3ICyVM?=
 =?us-ascii?Q?UqKWvuRZo2cXazfVgM2+5dOvyDG1IBRUwihLmo1ja8o7RilELfQLlUDKtTyI?=
 =?us-ascii?Q?swG2AwsreZ/Hy7XZBZricNIZzX1OVqAoRRDarvrfybvqixeQlRq4aLAQ27S+?=
 =?us-ascii?Q?FhNozrDTQWse2gd3dYF5GwNTaMA8/lvGjMl37hcsxwlFCNcK0nLy3V5NccWB?=
 =?us-ascii?Q?qKQMivJCDulcuzGp9gTnA79OUUwO/ZaRCx2u2tu/8kczeVit/OEsBfs1flEU?=
 =?us-ascii?Q?qHmehguHd55zaxfXosbOqmyU8mKIs1Ry9VUmuFBE+YU155xSoHEnZB/y3o1R?=
 =?us-ascii?Q?10zLobaUSxi+WG9se9PZxiVtWX6EZn+wfHsJJO8ZphXbnddtm5SzsWIAUwMo?=
 =?us-ascii?Q?u33UObEMDNZROIICpAXbVnJ079rLKwECKAgY2KiqMSj4QiulwAjcJbOmAIek?=
 =?us-ascii?Q?OR/a7Fs+PpiRnEiaXVrRerYcCpQxD2olA1c7fbu5/+USJQKKYfsaoYda60sA?=
 =?us-ascii?Q?RWWVaR1Oh9yk9p/aEfmecp8041UxHLff4emjVdozaHimITxop+fFelRHgpwN?=
 =?us-ascii?Q?9KBsrYBl30jx0+5JgNTD6jFt0sFrNyDgxdFt4U+CIObwG4RLmuc5mjCTqPcY?=
 =?us-ascii?Q?97gdgi+sYPeewzuLwvba+NQL4zBMZLu0DIKvPLCHVNiEUzDUQFCA1hHg5RH8?=
 =?us-ascii?Q?sZUqcWrO5P1uWVnuPucJh1CLvdfBW+DSnob6gj952R0lbk0QYTXhynS0PyYf?=
 =?us-ascii?Q?DZLfMnTvK57Hn61uwWRpxBYbhUfDlmSMFeVGCHrkuyq/5zCLeH9bFEJQ7Ap8?=
 =?us-ascii?Q?+r+kBc1hBo+bcUPZzei67TPzbrS5xjXC8++R+moV5Ue+OF5kw8jRX8nv7ZSR?=
 =?us-ascii?Q?xUqja2rVzuLjd3Vy7hMbhRrmI/0PPcCTZYzUcbjahAp/8wy2yAJkiFiy6Kqx?=
 =?us-ascii?Q?pMTtX4VnHHn5j7ICngIJJeTEKLEz3ZUXR0AcLa8vAkYYk4zSKoFMWhdgqUvc?=
 =?us-ascii?Q?0peOVnssDi7jLpnyxFHy3gmCXq+TEvce3GqtMx+FdhhdU8HVq08JDOdCI1lB?=
 =?us-ascii?Q?mXlvRf7YkneUupH+ftr8psxISeRKS5yvUTgZUEWsIoOARX+A8HO31FZfOkwY?=
 =?us-ascii?Q?MrU+sRjxLFSV0H445zcmEPbQcVOGqC8rlqGis7pMTy40OfkhgUKqWOIpyLeR?=
 =?us-ascii?Q?y+z0S9qSKtZxRYyi/KC41axdl+3AjqYNoA0RxoBWJ/yXrNIO90tBvi1Ew+R4?=
 =?us-ascii?Q?8gzLpQ3xs/tkBNtUQ2lER380Hk2+Ee++CDT6WgnTA/wSHEf3tjX6r7JHaVyN?=
 =?us-ascii?Q?X0JSNX7RHXvsdmD6rSa0KjglzrKewsyKE7LMlbB6lFzWaJz67D5qJlNbkc/Q?=
 =?us-ascii?Q?VCHBRL47f4nmt0cYgxYu+VMjQgnYhgH3ukDSsPyMkN/Jg1mp7X/Z8256Ti+V?=
 =?us-ascii?Q?B3oGAdiAS9yGCcyhqfZcna5XixzfP3YWvtfs3VGIdxpM+r4RL4MzdYcDSE1n?=
 =?us-ascii?Q?frv5aTMYQO6Pds8n+KTAobs7eNYsdmK9xCcYRdjHVx37BLd4X17ZCyDDMRyT?=
 =?us-ascii?Q?MT3JxPAOB9qCCPAv7v75mlmSkLl6klpIjUeVm3CJh3FyiVBAFgMmoxE2cjRC?=
 =?us-ascii?Q?JSkzoF1ISA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0afa74-cd0b-4a48-cc07-08deb7c5edc0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 05:49:46.2608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwCkolkTHVreEn31WWhW16hK4pz2wwxpd+bmzGckL6hCirza3p3Zg78GHvfalm9zyyGYA71TS5aTHk0ppsQZVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8861

On Thu, May 21, 2026 at 01:24:49PM +0800, Alison Schofield wrote:
> On Thu, May 21, 2026 at 10:20:26AM -0700, Dave Jiang wrote:
> > 
> > 
> > On 5/21/26 1:32 AM, Richard Cheng wrote:
> > > cxl_test allocates synthetic CFMWS HPA windows from a gen_pool with
> > > SZ_256M alignment. On arm64 with CONFIG_ARM64_64K_PAGES=y and
> > > CONFIG_PGTABLE_LEVELS=3, PMD_SIZE is 512M, so every CXL region carved
> > > from a volatile window inherits a non-PMD-aligned start, and
> > > cxl_dax_region_probe() -> alloca_dax_region() fails:
> > > 
> > > """
> > >     cxl_dax_region dax_region1: probe with driver cxl_dax_region failed
> > >                                 with error -12
> > > """
> > > 
> > > Enfore that every volatile mock CFMWS is PMD-aligned in both start and
> > > size.
> > > 
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
> > > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > 
> > Hi Richard,
> > I can't seem to apply this patch against v7.1-rc4. What base did you use?
> 
> Hunk headers are wrong. Maybe hand editing without reformatting.
> Diffstat is wrong too but that didn't affect application.
> 
> I'll wait for the v3.
> 
>
Hi Dave, Alison,

Sorry I hand eddited the sequence of this line
+                       .window_size = SZ_256M > PMD_SIZE ? SZ_256M : PMD_SIZE,
without reformat the patch.
I've sent a v3 with base commit SHA as well.
Please take a look while you're available, thanks!

Best regards,
Richard Cheng.
 
> > 
> > DJ
> > 
> > 
> > 
> > > ---
> > > Changelog:
> > > 
> > > v1 -> v2:
> > >     - Reframe from "fix start alignment" to "enforce PMD invariant for
> > >       volatile CFMWS"
> > >     - Bump cfmws5.window_size to max(SZ_256M, PMD_SIZE)
> > >     - Gate populate_cedt() alignment on
> > >       ACPI_CEDT_CFMWS_RESTRICT_VOLATILE so PMEM windows stay at SZ_256M
> > >     - Add BUILD_BUG_ON for MOCK_AUTO_REGION_SIZE_DEFAULT v.s. PMD_SIZE
> > >       in cxl_test_init()
> > > 
> > > v1 link: https://lore.kernel.org/r/20260519233523.5991-1-icheng@nvidia.com/
> > > 
> > > Best regards,
> > > Richard Cheng.
> > > ---
> > >  tools/testing/cxl/test/cxl.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > > index 418669927fb0..09c309af5fd1 100644
> > > --- a/tools/testing/cxl/test/cxl.c
> > > +++ b/tools/testing/cxl/test/cxl.c
> > > @@ -318,7 +318,7 @@ static struct {
> > >  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> > >  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
> > >  			.qtg_id = FAKE_QTG_ID,
> > > -			.window_size = SZ_256M,
> > > +			.window_size = SZ_256M > PMD_SIZE ? SZ_256M : PMD_SIZE,
> > >  		},
> > >  		.target = { 3 },
> > >  	},
> > > @@ -495,9 +495,17 @@ static int populate_cedt(void)
> > >  
> > >  	for (i = cfmws_start; i <= cfmws_end; i++) {
> > >  		struct acpi_cedt_cfmws *window = mock_cfmws[i];
> > > +		int align = SZ_256M;
> > >  
> > >  		cfmws_elc_update(window, i);
> > > -		res = alloc_mock_res(window->window_size, SZ_256M);
> > > +		if (window->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
> > > +			align = max_t(int, SZ_256M, PMD_SIZE);
> > > +		res = alloc_mock_res(window->window_size, align);
> > >  		if (!res)
> > >  			return -ENOMEM;
> > >  		window->base_hpa = res->range.start;
> > > @@ -1826,6 +1834,8 @@ static __init int cxl_test_init(void)
> > >  	int rc, i;
> > >  	struct range mappable;
> > >  
> > > +	BUILD_BUG_ON(!IS_ALIGNED(MOCK_AUTO_REGION_SIZE_DEFAULT, PMD_SIZE));
> > > +
> > >  	cxl_acpi_test();
> > >  	cxl_core_test();
> > >  	cxl_mem_test();
> > 
