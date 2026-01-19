Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B685D37FF77;
	Mon, 19 Jan 2026 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833225; cv=fail; b=LU9lC4yKEkI6cfWBcquOlSGmisuWDBPRPUYNQdj2w4mfXbuxHAHiSHbbtIbWgngKw20Y4iJ//aolqaFYvvpBYfgidDsMqWEMLfrlADuGqB7Fpo3D2TkGl3d8+KVudJKsurYwc08MczFJMMo7A0BGCpK+PVdPOA3pKtSs7Eor1HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833225; c=relaxed/simple;
	bh=zPvaNu0nyOaTsop5p3xCzgnjg1DZpR3UUwJhdZCIAHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q94E7sSy03zKx+y1b/b6audYE1ZFV928EeHlU3tpjVWgz6ezDFtwMLMGu8babZg+bITgSTHui7Qjd5U6GMw0yv8v6ZoIWr4Xg8LMXERsyiXrF+knIaxkmrbXHIBJc7RdaUeBpocdUNMEXuWZoSPY5zHLEX5FppIuqEAeal2b+jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pC7hCl7x; arc=fail smtp.client-ip=52.101.85.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pC7hCl7x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqlF1SZvsRBCoMmrIr0eni1ye2ZTRJMACSl+B0eYUyIc29sdahLJ25tLhbwPUYDpqwg46rycuML/djyJE2T5XhhYZgJHEJQoOUyLeHfAxlnjvXWUTeZbuuYDzIFAdid3shcg3gXMIcSKyPv87sk4VCcKEVlkH7TaJxwzgCfQf+deI4Obb5rzvRE3Z2PKMBc1dosbexlbPE5Y5l2/DzXqICua2pNXn2tLASc6ZqS1mX8j2f7jC+jyAZC1jNPWAr+aoexggKedFuIIUJ1FKjI8Jvf/EplIubQMEV1v5K3SMXmYWHC2VAHrL1s63/nHH/sxuc3niVSpxZpHxZvRlLUMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKZhd1yjNkC2FUrrZJPEJGKgQ4AmDWXav3lRd72l+b0=;
 b=QLSg7XJtRFrecIpBOV/j3JYhnsGq686d2hHWomKN7q18eu6+DQ4ZxfrNmQbo47fw7SbEyjM8QrUrZ2fH4R/QbPGezNHLMJSpLBhN0sc89BTfRzSACuu8uyDX3i1V1apDJT0LefcXONmx8mAGWLf0Owt8SLj7zlQ+V/9XgNajFqXECannVIjwYe9/21AUH9rqvOqVQ/aWp8PnhfW/zYc5KwHiNDbfXOYCVfh1kHhS90nD4gJirXnWZmQ+ja65wyhPpfuOG1kAeRjFVPLKsWrk8nQSfeKZmZbggF0lZVdjc7XQDUTqzK3vn242wekWybBjP5D3pBaCwV1oQFQwToi3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKZhd1yjNkC2FUrrZJPEJGKgQ4AmDWXav3lRd72l+b0=;
 b=pC7hCl7x4TVrJ3Vepr26ybwwnKfp2GBb2ey0Hw9me7Ugc4ATKcXMtzQOs8rcQynCWUQTRfEveY5EAhWvK8cG1y+5F/WUGp8wOUjV8wfmm+v+iKvMGuUHi1mPYq9ijw+DaZ8nApOriePvC4l53S2fQIikYH0hogFvHTorxeiS4Xc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ2PR12MB7797.namprd12.prod.outlook.com (2603:10b6:a03:4c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 14:33:40 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9%6]) with mapi id 15.20.9520.006; Mon, 19 Jan 2026
 14:33:40 +0000
Date: Mon, 19 Jan 2026 15:33:33 +0100
From: Robert Richter <rrichter@amd.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	John Allen <john.allen@amd.com>
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <aW5AvfcjLkSP2j42@rric.localdomain>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-11-rrichter@amd.com>
 <CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com>
 <aWehZwXsK1IXRNU2@rric.localdomain>
 <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
 <20260114180859.00004623@huawei.com>
 <20260115080444.GD830755@noisy.programming.kicks-ass.net>
 <CAMj1kXENYZq-UkCup6FSH_4tmpRe4xJN1_veuSWs-hxxAo=1Ew@mail.gmail.com>
 <20260116143838.GC1890602@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116143838.GC1890602@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: FR4P281CA0288.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ2PR12MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 107de4f6-7374-4adf-fc9b-08de5767bd47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?haWeVgMfK1wZmeeF/qdFdWqOsbDF7Oc+bVWzxSfFgQBfI1/aOEVBociAJggO?=
 =?us-ascii?Q?cJc3lrr15rEjTKx058LmaWrCj8IC0ydpiVEn7Xtc2n9Y/1qrtlowWaMWR9+U?=
 =?us-ascii?Q?lpbJjaPqRFpsPT2avpkjKDM4mUrgNQ+o407hbW/CMVl9WdVjZCoZjqOjCVBj?=
 =?us-ascii?Q?l5/IdNdMVt09P3+W8MVL9lFDxvfgAAD99CCJUxqIrj15qRR7PZygS7SDrDxg?=
 =?us-ascii?Q?bZSBHUU353jzWdcqZ6aSvmB/vgOvRXLoYNa99QnXMgf1OM7eK+cs4JtgqM5l?=
 =?us-ascii?Q?w4UrSrYhHUT0504jV4UBe+LS8mszC4R2GPGRzhpTLddySeRISsI8+hZNQrxB?=
 =?us-ascii?Q?KM2xzvxuAN5BfPZerdUtgA45jzuXNwpxFfCIQ+jS+nl7vltSfmR7P6r3Zb7e?=
 =?us-ascii?Q?qqhf4MEyOBSdNeUw9uUa106yWW5CQppHxUvYcrsuQt5uM6AcAFosJz6Tf2yQ?=
 =?us-ascii?Q?dLic4qHsoYL+yCdRQf0o/O33s/ImBxdybTw7/E7OkGftutwohxfkEKtLHAXg?=
 =?us-ascii?Q?6HDT+Zl3jT0RDv1H70cqo+iiA4UaNEE1D5CI0kWJXLCY+2d+a6BEv40f6hQR?=
 =?us-ascii?Q?E43aPu23BC8WMyJWbsdY+7IDq4ICu1HiB6zfBJdiP97Yx6D5wQhUBNX1LNhO?=
 =?us-ascii?Q?VffiQ9+9RiqggGPYrfsUbySl38Ka3m6UOzL5IsE3AETDrlnDoaPb0jh58eaI?=
 =?us-ascii?Q?681ulZdLy3H5qMHdr8vp/qtFVhA2wMdtoM0oYUC7sGSK9m5pyQOuFjfB1Xbs?=
 =?us-ascii?Q?A+LjWhPngO9dDcJvTUp5eqZtPXY6c4UfchbAm2GbhuFVDbPAmBbzr6pQ8p0t?=
 =?us-ascii?Q?J7H+nJVW+x7BK2YT6pdsRM01Hs/uyZ4BoTctMhXGYWQPYCWf+9ZJL7VGf27W?=
 =?us-ascii?Q?M41WE81HwSYh+oKtPphZl3SKX6rcnWAKv4JhpB98GPZr227CWKzzHxvtb+4h?=
 =?us-ascii?Q?GRsIbDzbBoffdS9gIkAqW4+nQ2a6QF+r5vE5iIrCcsz86nletVrgNsgPEvKy?=
 =?us-ascii?Q?OyeVuyQEKii7pa09p+wLEu9mH5Se1wYKY+ELjUk8Z1qSPLmcGc4XNkMWoqXJ?=
 =?us-ascii?Q?RCUm5daiSol3ldPj4XaL6TpkOrxsh0/c8aI9Cv46rsrLr70iUyOtLepQLtcm?=
 =?us-ascii?Q?N+5u/p7wxNz6w6kT9K2tvWKFnRqYm1sGRrlxEH/IGvsJEBCK/+2/Y0cMg+Oc?=
 =?us-ascii?Q?x25e2Cqg6uliRbsZ3jPaNR+LiAdGy6H0Lww8kZP58ftSf5fG4lER/DWmsEC9?=
 =?us-ascii?Q?CekUGhXrxW0nRGLBy4FZg45go4sCBswim7VGsLmzHcaex6wFPDPdgsKUmROq?=
 =?us-ascii?Q?6g/KVYGySuYuW97bz/5cayRowWzGoGhXzGHi3k0/it197P4Q2XRty+fxfrrF?=
 =?us-ascii?Q?l96bYp0LHUMuuZ5Yov1E0zmh4cyuaznvg/YRZO9Ju7ObGHsM/ytQrwqwd1Nm?=
 =?us-ascii?Q?lLLc1CVMeDwHLa90XtcwIU2Am1n2VKrEBkMb9CmZGvXGHoknalE+10FBOYWX?=
 =?us-ascii?Q?t8Gzfj5fHSEuHcUPV8lIOingwm1uLPAX40H3k2Cvtzr3HkudbJAhF48XOq0N?=
 =?us-ascii?Q?pNIVd0wfKfcT+INAwS7VqtZ6Cja0Rr3ZKJFI7P/r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BujB+R1yzXC0pPK11WwQc6f/umhpJAIzDdug/9Uw4Qblnu9sfTrKK4vvkJFK?=
 =?us-ascii?Q?JEeK5kOKMZR0YXmcwxKvxQipZfSiZkfyPiWsilQ6E/eVGICy5BWpXKBiBn1T?=
 =?us-ascii?Q?2ulcGXaOK596yxtEG3+/6Wx4Sp4VlwUO1mjq7KXONs6FL1SM/iHMrZLxkwQo?=
 =?us-ascii?Q?V52mw5Jx4/jApEEsHIc1JSXaiIiQDO0cloi/XNn+gRdbGNDtOZs5F3pdIyXs?=
 =?us-ascii?Q?rdyHBFVU48m6DXowAkKNafwb2UHF/ZuOWu26QsnVvTic2jUjmcNfllDeMK/B?=
 =?us-ascii?Q?PA5Nu2MG713VV6c+7V64TG0sSU9mfcVFnEMtPElmsA4HTTmUZofGLNKeUxtU?=
 =?us-ascii?Q?D27AWwgi2DEa9MSUe5yPT5Wk0wrf8BVt/56eBs+ZUBkrAszeup2Ph+PNtgTG?=
 =?us-ascii?Q?CM+Fsy3JRLIF8LPvfAcz2tg4BxY2iTNWIp4GnoBN0tOAycYjWafYUkUiDqPr?=
 =?us-ascii?Q?+uF/dMyS5S3937+vhB/GsxBlA5OQRDdx9tjVr5v51m/eorCVrW5UgnoT8+fu?=
 =?us-ascii?Q?6/HC7hwUZpa4z8brXPOmriB+Odmc/HNNigAIJE36VfFab4oo4gfdAYHJ7DIC?=
 =?us-ascii?Q?brzLH7ys3+z7AolYfGRJSj9ymMoH7xA2Ad4TifaHE+ZuhTCDz/3+VvhnzYV2?=
 =?us-ascii?Q?Mi3bvC2crtO/dY6YXoltfRguqZdpgRXff5fruXOa5iNc8/wnytgG02PqDWNc?=
 =?us-ascii?Q?HBQQDMYzHolC3A6fIFEGvGuq0OmNSVQ4l5sOAocG7qALJrHznDHHMJ1XyV0L?=
 =?us-ascii?Q?S7LsQMADe/xCujUhIIKfMPnz7euHFImZ01bGzT0ZRjzNO+QPrinPAJVeQePr?=
 =?us-ascii?Q?GvTP9VMDbXs1o0Z5TpK2UvpLHDekNCYvgxUHJTo9UoelJPaHsac3y/lYIzyE?=
 =?us-ascii?Q?XuxjbtmxwMOfMJjMT775uLyB58klCJ+RhulgWHZQCL80osI+JAf2GnB3bF4y?=
 =?us-ascii?Q?Ya7b4nWpBTQT390TPitUBr/6MiRSvMJqqke3OGCuDrRinZiGpQT9bvhVNZt1?=
 =?us-ascii?Q?kFcSNsPjK1u30kLCkLqfFc7aAQvdQJSBl3jSanN+D4PsAgHOmDlnXP+TdLUd?=
 =?us-ascii?Q?EY/53RSslVtiE25m5eCdkhIWLtctiYbkvPKG8OeUGX5EhpYniwaV/VT1azxD?=
 =?us-ascii?Q?UrUmQUT5U8ZO3P6tULzYwtQ6WVQ0s6zPitWBO2D0rmpqeMzFsrcabOFWgSeK?=
 =?us-ascii?Q?rDRMdPnP+RsIj50BH49exyeyD7Togl16ewcSEok6/EBcdkLAO75E7k1cNTSK?=
 =?us-ascii?Q?NwZH1ExVSc645bZbyJc/L/D/dwK5aGVU/cRgeBtQbzG33GQoSLsDIW+VxpHY?=
 =?us-ascii?Q?uWz+FUrw7BmBTtzzkhtjMBJ2FiPUzzVY7zn8T6PP7wsMk8nRdgZWLxqI5Agm?=
 =?us-ascii?Q?RLaiZrPkkalKpaDndX1Sf5PqMiIUmebzZjT5ibuD+bxOl4MR3ieF4yI32qGs?=
 =?us-ascii?Q?aBWXZgsLZuPzefxlzzsCMqdZU0CTE+rLQ0lA4Gxs1CPfVN+zp+C5VyBAh2MM?=
 =?us-ascii?Q?I+v1vIhRrl18hXuGzXoFMEYapKstviMJTGWNgeMvOqo0ilZOIIrb5dhN9Yuq?=
 =?us-ascii?Q?Ag/8STH6FuWv3mM4nsi3BAtrp3X5uSJcSQ2tegi/MmAemT9yMHl4LYdXySHX?=
 =?us-ascii?Q?a3TjSVuqqxYrD9gpVl3eA36VPLo6zUEGfyS05HJJazxa9wYj7Esk2sfQc7Sl?=
 =?us-ascii?Q?kxkieeu6kLKzOWLrcEO4hqWCi3ogoyQGIPwL4X+JvyxFeYY7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107de4f6-7374-4adf-fc9b-08de5767bd47
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:33:40.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYu5lL/p76ON0n4qRW4mNZKCkxLgFqOxKbg9uwWoI3nTLp70KxNtfK0cr6FAj2IJfE9OmSpmvMzqp9ULbsAZTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7797

(+Rafael and some AMD folks)

Hi Peter,

On Fri, Jan 16, 2026 at 03:38:38PM +0100, Peter Zijlstra wrote:
> On Thu, Jan 15, 2026 at 09:30:10AM +0100, Ard Biesheuvel wrote:
> > On Thu, 15 Jan 2026 at 09:04, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Jan 14, 2026 at 06:08:59PM +0000, Jonathan Cameron wrote:
> > >
> > > > Do we have a potential issue wrt to merging this as it stands and improving
> > > > on it later?  i.e. Is this a blocking issue for this patch set?
> > >
> > > Well, why do you *have* to use PRMT at all? And this is a serious
> > > question; PRMT is basically injecting unaudited magic code into the
> > > kernel, and that is a security risk.
> > >
> > > Worse, in order to run this shit, we have to lower or disable various
> > > security measures.
> > >
> > 
> > Only if we decide to keep running it privileged, which the PRM spec no
> > longer requires (as you have confirmed yourself when we last discussed
> > this, right?)
> 
> Indeed. But those very constraints also make me wonder why we would ever
> bother with PRM at all, and not simply require a native driver. Then you
> actually *know* what the thing does and can debug/fix it without having
> to rely on BIOS updates and whatnot.

an address translation driver needs the configuration data from the
Data Fabric, which is only known to firmware but not to the kernel.
Other ways would be necessary to expose and calculate that data, if it
is even feasible to make this information available.

So using PRM looks reasonable to me as this abstracts the logic and
data behind a method, same as doing a library call. Of course, you
don't want to trust that, but that could be addressed running it
unprivileged.

> Worse, you might have to deal with various incompatible buggy PRM
> versions because BIOS :/

The address translation functions are straight forward. I haven't
experienced any issues here. If there would be any, this will be
solvable, e.g. by requiring a specific minimum version or uuid to run
PRM.

> 
> > > If I had my way, we would WARN and TAINT the kernel whenever such
> > > garbage got used.
> > 
> > These are things that used to live in SMM, requiring all CPUs to
> > disappear into SMM mode in a way that was completely opaque to the OS.
> > 
> > PRM runs under the control of the OS, does not require privileges and
> > only needs MMIO access to the regions it describes in its manifest
> > (which the OS can inspect, if desired). So if there are security
> > concerns with PRM today, it is because we were lazy and did not
> > implement PRM securely from the beginning.
> > 
> > In my defense, I wasn't aware of the unprivileged requirement until
> > you spotted it recently: it was something I had asked for when the PRM
> > spec was put up for "review" by the Intel and MS authors, and they
> > told me they couldn't possibly make any changes at that point, because
> > it had already gone into production. But as it turns out, the change
> > was made after all.
> > 
> > I am a total noob when it comes to how x86 does its ring0/ring3
> > switching, but with some help, I should be able to prototype something
> > to call into the PRM service unprivileged, running under the efi_mm.
> 
> The ring transition itself is done using IRET; create a iret frame with
> userspace CS and the right IP (and flag etc.) and off you go. The
> problem is getting back in the kernel I suppose. All the 'normal' kernel
> entry points assume the kernel stack is empty and all that.
> 
> The whole usermodehelper stuff creates a whole extra thread, sets
> everything up and drops into userspace. Perhaps that is the easiest
> solution. Basically you set the thread's mm to efi_mm, populate
> task_pt_regs() with the right bits and simply drop into 'userspace'.
> 
> Then it can complete by terminating itself (sys_exit()) and the calling
> context reaps the thing and continues.

I can help with testing and also work on securing the PRM calls.
Thanks Ard for also looking into this.

> 
> > Would that allay your concerns?
> 
> Yeah, running it as userspace would be fine; we don't trust that.
> 
> But again; a native driver is ever so much better than relying on PRM.
> 
> In this case it is AMD doing a driver for their own chips, they know how
> they work, they should be able to write this natively.

Since a native driver introduces additional issues, as explained
above, I would prefer to use PRM for address translation and instead
ensure the PRM call is secure.

Dan, Dave, regarding this series, the cxl driver just uses existing
PRM kernel code and does not implement anything new here. Is there
anything that would prevent this series from being accepted? We are
already at v10 and review is complete:

https://patchwork.kernel.org/project/cxl/list/?series=1042412

I will follow up with working on unprivileged PRM calls. I think, that
will be the best solution here.

Thanks,

-Robert
