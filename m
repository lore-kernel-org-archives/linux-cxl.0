Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232F8308F28;
	Fri,  5 Dec 2025 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764929209; cv=fail; b=f8reS/n51A8aptXWXJN+Zw+beBNrh29IQQeCPWTGP5TxGYA7FWFkSO+YEzls/dpKbYRqyIyN/NFV1W771QJWwDSEQVkfMU0BgrcrF9sb6nHow5gfO/J9ZHOqEaO4oADl/kg9LKvdEWfvxUPVK1aZlJNOBskm9pvgpBrqPvvG/28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764929209; c=relaxed/simple;
	bh=uhEkgEY/P88JNrTR0x9pdF95qAzpUbRX6k70Emh82BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kGBOxPTaqCMYdR+f0J2QKyTrKLfrjLuIT9oQujSXMYfeMpWhl3w/GtdMa6s1He/VX4H38r2hxB4qN8o+Ous1mleaz3D0tbASCdNlH9X4cgnaP1tCwtqukCDGuS7Jo0t8Mwi3s9dRsDvPyFC1LXVgH2KGL7VR6WUCHsmQyFuqJGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fIuFkCxz; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fIuFkCxz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJLjv3lKqp9eCpjZKc/u/5UKazq1gy1YTGIkp/augBOUOY5x/9w3PJOzbXDlYDTCaKjp3qobqnzCx7Jo+x4mBwO+w6+qKJYVIm7q61CRgDGgO6fd94v+3J0hMu7KhKjEYq2H8RaE5ciLBBwW3adFx2s4M2Soag2PbMCNfLPhAuXSo3cP9KNHuAU/NN0CJw/aSmhUlYRTzM8NOUWtucvyONtNfAIiO+yWP63DAxhbEOsG34qFagB8qGUmoyCYr4KNhPtbOt9/X+ydLyJqYp28cZC8L+5g1APSlTdmOjBab0+rMy+gtzC+CWVz32LU96IXoAk05mdfZDe9GNMUFzeg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJu5m1fcf+C7cY2acRxWnRktjURMhEDOL+XLR22pel0=;
 b=yCX/5RQyI/IHtrG+6QUgAENhU80lhuZm5Mw2oFKhCC8fmigmx0JkDFla/HuTCqKCb83J6VCI9m2y1tx1dYhCaUGVEsZ9gPnet38zd5L95Wn0yk43o/3Y7LgE3J3nfhB8+X7YpZ5oNlOCwdQADIlYeyhrJLNjP+4wHLcbwhGiKDW+cGmr8ALpoLaZDrcaovlVgZNwEAdmanQ8QzFBfkMyJ0paI+J3HVwdV552kg5y/QQ+cv0GEGuD7lLGC+4oZIYmlDtRuvonpbl4ck1lTRWxsuj/aalFNcvipWtVmXdnMNNZBE1sew9ubzX71M9qIExpk390tS8XvSxKhigyDKakmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJu5m1fcf+C7cY2acRxWnRktjURMhEDOL+XLR22pel0=;
 b=fIuFkCxzVdqXYTLV0YJCmXwQVYP8/Hx8JfzYIOrqwC8icQNFbrF5hBkzSVJ1j2M3ixstZVwSgCAP8uB4brOZuDKMmCCBFqYC475G9wDF5f8uVy/ns8AjlWHmsU+U5yeAcqDD458CcKKLIhzPZqTlSsN4WZR9SF/SxD7CWgaLi+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 10:06:40 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 10:06:40 +0000
Date: Fri, 5 Dec 2025 11:02:30 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v6 00/11] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aTKttv6plTq0xTsA@rric.localdomain>
References: <20251114004021.1310661-1-rrichter@amd.com>
 <aReKmdOeHBBDWMuC@aschofie-mobl2.lan>
 <aRs4ILR8EEwnfOtQ@rric.localdomain>
 <aTEMeRzI0_zcT-S3@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTEMeRzI0_zcT-S3@aschofie-mobl2.lan>
X-ClientProxiedBy: FR4P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::14) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 847f369f-ef02-4f42-cd20-08de33e5fc06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Ss9lVGic+zREFGFnYmFVEBv8J2Jryw16NXUgJdS0xbHTaWGCqKxUkEauqQD?=
 =?us-ascii?Q?pNPpBLVW6jxKGPYJLp77Y4ZPsJd8oeThwSY6W0Sn5R3MHh3tUFTm9xiCFePA?=
 =?us-ascii?Q?106MowpxBsNuAdWrAKo2jlnIweSvLF3NDKg2MPAraMG+RWmduW49EpHsvAyK?=
 =?us-ascii?Q?Dxl/uTigqjMgyeINNlCDEybpn80NcMOUu8fxZEuVJpu7VWjZFaLF7rgNnVm1?=
 =?us-ascii?Q?EWF9sUih4Xz/a96ki8TOmh+fnbnwo9C78rcC+VPJd+wtU/1D3kSeKuoltnyL?=
 =?us-ascii?Q?vM+4kaBeaAAt7WuMsizdmk362PsBj8PBt2jLzwoaFhR/v5WOpcmept9i/DNH?=
 =?us-ascii?Q?qr80hN1WPpmY/GibRkGx+0ML7p6qXbvT9hv4ZhohPwT+5+UzMORR+DFynNI8?=
 =?us-ascii?Q?xOIQHJ9VwcW3M+vJNJ0NelsLPjpNHZvNTDFW/ohdVZ7Z2GvuXMIxlxUpxHSg?=
 =?us-ascii?Q?YwWtRwDv058f3aeMXytf6SAahdvxNUJXLhCdsHN08Varg1bqZk/S7Grmqzyl?=
 =?us-ascii?Q?C6mv3z56VaBNYrhtXN/b/yk0MW1yKem1jJ9lrahJ0fGTD9WGzABI2hknpTKr?=
 =?us-ascii?Q?xcpvZhwXpegEg2nC9bQ4VkAkFbhHaWiXwhyKlFa9op1PCR2/pxfeduCTqdlF?=
 =?us-ascii?Q?O1HhYCfnMEcG8thM48ybIRtTF9UvaLtdBk9jMZlMF/FUfs7pEVzNAUCVNS3L?=
 =?us-ascii?Q?OsSlIG/UIMPwnmWk6RQxUM9MCmbYNnHA3dTZyZBU+qVZn3mAtlXOqYgDpxDa?=
 =?us-ascii?Q?FjUJrg0FTYSADQEZOhnTabMEI4pOMd0oLjTWI61v70TSnSU+3hU2iCzPraOV?=
 =?us-ascii?Q?37OQ50QlClJghug8XqSWpgQWAamP5fmDQ9SV8WHGXur0lcVIShsCKI8zWTEH?=
 =?us-ascii?Q?ouqlHIxq8SWbw0518cMcy5p40tffUtFLDbUd3/EF0YZEZDvFIJ68UTpmRP0l?=
 =?us-ascii?Q?F9GmIeHEP6iue5SidPkaF8qxoyKloIFJ8xhTrCKoVzVyqGn1BChtt2+LNCMl?=
 =?us-ascii?Q?GdOhx/+yf/77z2XgQOdPbCFJfVBXhBFe8XClCJn60nkV1X4Yw1HJZw08o1sk?=
 =?us-ascii?Q?Kwqx8d/SJIxkWN7ED8P00coP2hdAO4hdurWmtPyjIufTYJEO2SUT75rICBYJ?=
 =?us-ascii?Q?Dy5yK3ODCH8XadOSs7nyjsiQ+EGXOF8TCuOfr+k10Cu1fR9s+6Q1X8swA9nv?=
 =?us-ascii?Q?DbVgsH76voIUUH7IxwsWPo3rWmB9BI0IhLvjUgiS6nIU8Q0pziw/Kt3iw8Xu?=
 =?us-ascii?Q?JG3jBRgMWZQxYYYX6U3NgHVPD9AK53Kx0GMleYUKPftl8gZxAWlvgLvFXKyP?=
 =?us-ascii?Q?ZHLuzN9800VYp0/Zeh4msA0Io4V9lKrcPl49Evfo9nlDJb3TgsklGSH+4TGD?=
 =?us-ascii?Q?+wQkcczXKBlOvJ10vzp9uNQfoEynzph5ENxUsFqnvIoaqA7mJYn6jfpiTP7A?=
 =?us-ascii?Q?bvxKbleMlu3bWJO3ti5lkb26A2uLw9Ef?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fjNKxVU22UWQZL6W99hweHUrHOv7AniGpsuTKQV2qwioPGd1xl9YayJcwg7r?=
 =?us-ascii?Q?ybDw1WxyN69kMCG7zZQ71jgR7nvnUdKadW+h24SFM3m0mU4v212IMu6jEixv?=
 =?us-ascii?Q?DhWsPvpl+HuEC/w05dcSpnX59m2D8exV2JL4SL+UkhELBCg6VHeTquVPy2Sz?=
 =?us-ascii?Q?OF6+8wwQ5JymZvRN4sFg0W3nn/K3qGgotuZrfL65IXvPDw4GNIMShLCXnNqZ?=
 =?us-ascii?Q?6DxhYy4+0WUEeL1kN0KsIcTl1hg2G4wgZVbwFDRS4Q4i8/oS+19hZ7sv2Hye?=
 =?us-ascii?Q?G1IcjNfKkqqs2PXgsLlF0p8+JJGa8J+w8EKzAwiuEqmeSaEitLThDcEmI7LJ?=
 =?us-ascii?Q?GmXOA+7TkTUgbJG8Ju1pRm7mNF04zfBcrBrQqIzwZxCNj8nuvvlsfYTMW1F1?=
 =?us-ascii?Q?jjlJne7G9UDgy8sE1VOVRC4b1fQXFB50bUUecOjjT37Gg1d5eCkeHvRxC6DF?=
 =?us-ascii?Q?taNQuehknsPgbL+Y9LAk2hUuwDz6+y8wKLv/vjeBSbbSNzDKom6Q9ODE+wNE?=
 =?us-ascii?Q?4qWHxqw3aAQelhs7AUcBY93POmI0gls21Xwe//jKo4xAZl0d+zCYFwTMlxQV?=
 =?us-ascii?Q?5feYbo0XSEKnAZYWfTheNfDg7v1gyiK0JdjRijxnKvhYTdygjlZ2NCUgf0ro?=
 =?us-ascii?Q?sNVT/z9alWBAj3k1eYDv15vgJrFHxzXZg080m+lj5Fhwz5+LTBjfCBuV73US?=
 =?us-ascii?Q?L2dqJaqG6SOWpEURCFgBmmr8pLgAUgRp+wcNso6vSov95GzdM1R3F/kRjXgk?=
 =?us-ascii?Q?7dNxsUpLlLG24gkaVju+MigNacnixzGBjicfaIPssrN+1FSaICKBS4ngShoG?=
 =?us-ascii?Q?xLz5DaeUchDiFAQCjE9rj3Klz4HAC/4baORPH4ZpLl+lyqMS7KujNDCQj+lz?=
 =?us-ascii?Q?G/pot59/1+KnIx8VegKwSpE1PuddZ3wt4Jpb3TPhYIV4Mc+hYmfqQHkZHNYv?=
 =?us-ascii?Q?lSfxH+pzGOeT+eVeN1JKKH2AcyLmzwFcoEDouTLA5z3k2Jkg3G645xHIA/hJ?=
 =?us-ascii?Q?MI5ApAIThVSlhVREJkyzma8dMo1JEDw0pozzu2+TsjKes7AgORikAjQnDOi1?=
 =?us-ascii?Q?MCH9QMqvQNgXi9sonEZQCJU41eK9w/TMqXsc2Asly5XLT/TIZnPmFJ8HkEUx?=
 =?us-ascii?Q?oHl8dWEUgZJR5DYPqn08B0oeNfR0rkCb4fduVG2xcNzJ9o3wvlyACDcOOZhV?=
 =?us-ascii?Q?ng5x7J+DWTLjoLkxPokrJ3dy69MiVQvhEolLVbwAR6PnV8HeZPZYG9kLzTyY?=
 =?us-ascii?Q?s0e1Ppn9uUdI8vp4nzbzEyUg1NlUEiMpKz+I3kzTv+a5JdrAedk2srp3TvbS?=
 =?us-ascii?Q?HhvjkML1VbIVjY4NeDblsE0V8IgyjY5DepqQVq8X9OPZfr29AzN0PRyh8+Cu?=
 =?us-ascii?Q?Rb3aSy8mtf2StQn6TBAs5zkrlm+jJ1jJ9YGGZfX3yZIsNoU1jmddQlxGHo2h?=
 =?us-ascii?Q?HRjKxF0sLkkL3jhXoVikDoG698abw8DgOBrs6h9NHXuTwiuwDeB51wlLWW+T?=
 =?us-ascii?Q?BX0t5RIGn5PYCAai3o8UFdztWCLMbygQDqTmJGNA2nF2/S0xKLVXKdXwWsmb?=
 =?us-ascii?Q?vzMURUJ6TG2FDtO5Z8pD5m+UvwLtGeY5X7p4ZJ96?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847f369f-ef02-4f42-cd20-08de33e5fc06
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 10:06:40.3646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqJphbpFIrfLjPF/y4Hc+qDVFyu7IV5RacBzDVI3SOU6Kowdx+2QYZ5DG+O4x5UQp4g3a5Yw0K7OTsQRQoM5hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783

On 03.12.25 20:22:17, Alison Schofield wrote:
> On Mon, Nov 17, 2025 at 03:58:40PM +0100, Robert Richter wrote:
> > On 14.11.25 12:01:29, Alison Schofield wrote:
> > 
> > > Does this work 'as is', no changes required, to support DPA->SPA
> > > (used in CXL Events) or SPA->DPA (used in poison by region offset)?
> > 
> > The PRM handler could be used for to-SPA translations, but it might
> > not fit well to other users such as profiling, tracing and error
> > handling. Those users are executing in a critical path from a
> > performance or stability point of view. Performing a firmware call
> > could cause problems here. Since the to-DPA translation is missing
> > too, a different approach to solve address translation might work
> > better, such as examining the region parameters. The kernel's address
> > translation library could possibly be extended and used too. That
> > needs to be figured out. Also, my main focus for the patches is region
> > enablement.
> 
> I see a dpa-to-spa prm routine. I don't know enough about the cost of
> using it to say it's not worth using for CXl trace events that want
> to report a SPA (from a DPA).
> 
> If we cannot trust what the address translation code will emit in
> this case, forcing it to ULLONG_MAX would be safest.

I will implement those handlers accordingly. Thanks Alison.

-Robert
