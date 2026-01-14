Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A3123278D;
	Wed, 14 Jan 2026 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768399227; cv=fail; b=ZHYcqEI1qC9mLcb0VB8m+XluIDLI3NuQdwKp69i8xQJaJl1ycOlUVxnCjj7oOm/7gaZ2kSeZunGaod8HyPdV0RiU8SxsRNVBHEeM560OxjySSKExxzZS7AT1QRx09yWf54pRxd3Xv/KTob2eRe9KyunN49k0GC/DK2gnQY6pGL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768399227; c=relaxed/simple;
	bh=oH4AqAvW6Ppj+THTxGFHSyei6mC5dYbRYlQ0rzLA6jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DbJfyxIDuzNriECCByRRQJYj8Jt/1hL5Jwz2JUfpvVS+TWPdlvrzE4FGj27dbZiqs72VsuTbvJH8WpGlx8rvU8DcaxtuL7cqRTIWx9VPdOZxJ6tlAMpuSODwwfRalCUsUXeCgFIXdcCDWWsOjU96XAfT6BKENTbJK2t9eh4AgII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tfqBt65I; arc=fail smtp.client-ip=40.107.200.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tfqBt65I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnxsjNsYVsvT1iwkuX85kMmM7V3tN80zKNY3k0qljr98js5o5bJ44R+7tcj7cdc/N2SjXiMudYtz1/1WmfJMDTnqGcRk6zlXtbtIpexsf7NZ4lMoabC4uEpX3z9ejpzMmnlyKIcKM/iCA+dhYCfFN4dORWI6x+jek05PfHdZy2tnsZ1ECjn1rUoQ7+7SV4zIV30fyjxZzlQ3jWhiFRX3Jj3SqCBDwWTnENR1undTQr2YLWA9GrXv2uHllVSIW1rNCwL2BLvw9d1e5xizakc6wWZL6SViyv3suLJzo7+kqR6pu17wirG2DNxzn3zpqhjuypn8CuT7uRrjlCZq67l/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/BTWYknTM3EkdzofBVlBqiRoJ5hyOjdsNWsCCtF3KQ=;
 b=vPKdtoTEp5doH7TVRLw1m6vh2l6/24DKUozO2J0EyXPYoY6YojPYLXqEBaL8bC9ZwF4OXWhLAwyr8dohf2H3UA6bzcGu1Y06jJlP8qhgQ5RrzVJ8peQ2OropwPUPsEwWa7Ra/wkYUSiKTPanqfndgnVDWNq4/WIsXc3VI8QKZl3SMcuBXveIs5RXDyp8ROvseBN/9yIQp+kSsjqpOA8hd4INyX5ukxllo0a6nyWAgrAQxT2MpsxmG9MpVC4K9EnNXmEq4nhJJChisvb0z+M/Swt4L1gPKUVZsxGwIugH3cVo28Ng9OI96UJ8hfAbUgr8gi/DPVwfQxN2CCuqmGVnAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/BTWYknTM3EkdzofBVlBqiRoJ5hyOjdsNWsCCtF3KQ=;
 b=tfqBt65IxgSzZVe4ORpr11WmXldILYmv0QhcEerQmIfVvr5JXjAspmPnvjOFiEioXnyT9jf/PkiRSI8KNw4un12vUglhnGapjF4W8VYYrKNm9K+TSrzckhBHhfOz4p1cs7X3bzQdOPzp2FA2NDxoDkISZr6cfupw+FJTU1qnHiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 14:00:18 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 14:00:18 +0000
Date: Wed, 14 Jan 2026 15:00:07 +0100
From: Robert Richter <rrichter@amd.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <aWehZwXsK1IXRNU2@rric.localdomain>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-11-rrichter@amd.com>
 <CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0425.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::12) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|BL1PR12MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: 8686934f-7967-4565-afb2-08de53753d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zE7l5wUEDoXfHjnVdACVsPbOxG0INpc1mkWD2Q/v1D19mJWqX5P7AunE2PQQ?=
 =?us-ascii?Q?guELHP5AvDruDUgc0T0SiyLLwFd9TBI74mlBzg7TaDFZuqoXkfBhAwHfyGe3?=
 =?us-ascii?Q?j8v6zrRLy2bC57eUyfyluKvmJlhYBcwRaL9MAYiaBQB0CZNeJUOgaHvB7per?=
 =?us-ascii?Q?8AH8cARpcv7iL7A5B5tnShsRePXZ3YXTJqQrKIhlAMcSzG+rEcYGZi15at+O?=
 =?us-ascii?Q?F9ukgTU8XzKf//mxfS2gFWSbBYJer54vqL8sBcmSMsC7G5Wcs15JnuyxcfY4?=
 =?us-ascii?Q?u2+Pekts+uFKWhqmHVwRoAtKZJ2GigRBCGV61zk9LDEV60G3MqN7PE5TX5O4?=
 =?us-ascii?Q?mP95Vn4uG+aojTOP0Ubczzo/El1e1rlxyAg2XKRAvFyZauzV8WGTX9rpNxNd?=
 =?us-ascii?Q?n/TSyh5a9YLiSS6KJiSz1Q9PYJibI9zHo6DOp1KWlhg+nP/GU4Ze5OMwMeX4?=
 =?us-ascii?Q?RxL4dg786kUTCgZgV3OQoBUvfHiGEM4cUzLSUtwBSo+n0xuVwewDTNDQziC+?=
 =?us-ascii?Q?xb0ktJCeik0DS0u2toZdFA60/hVKs/IF4nUBr1GX3hI+Pi8jZKwdSwQhfVQ9?=
 =?us-ascii?Q?9kcnKXda975yiuLZAX4V/7XF/uoISVQltyEOCKWujde5iLGJlrVgB/tjHU3j?=
 =?us-ascii?Q?xOLeIK4sFvHRBurOR7buJa2OZr8Us7jFkwK7x+UJA0ZbfHAmrWiGuXra18Tj?=
 =?us-ascii?Q?AGxcFHqRbywpiK3saEBctMCRmYA7gLNM/BGawantmZD4x9xvOidh+SDpiq7g?=
 =?us-ascii?Q?mxcbXyxyfIBgkdCX5aIrV0O+KdcbpqVWd7b8tZPwebDOZiQnd/ObroKWfAoK?=
 =?us-ascii?Q?JJ/dw1Jw+obetyhO50f5AWrQoDGT9bKhlAm0DC8k0YCVdbOGC0Gv42kRSpX4?=
 =?us-ascii?Q?AbPBVXLff2Cp9xb7P0hJ6ERfDgT2XP5ZDPdB0ESNgk03G6vmkYisPeBQZEbF?=
 =?us-ascii?Q?+fzfblvZQeIig4zLWZWYZCUcbWfVH01iIszpdFBAb1FDzpvguUML36PXJ3Mj?=
 =?us-ascii?Q?7ath/5miiAnyuSembyF8Ld+xw4OeKLmUHz4buuBL13kxIpaT2JKvQD063JpN?=
 =?us-ascii?Q?OIEYSlJqf9kOyxMTzP+WwEVrz1q1y8f9t0DXRFNkKkv45amfAtz/YKfBwkCl?=
 =?us-ascii?Q?h/y0mSCv5zlL2VdrhKn9KwvmBPG5cQjY+NdKwWbFcu+uUf/Wu/pf1H2+ZY04?=
 =?us-ascii?Q?UMRvRBa9v7DtWTq1LVtGu/82pf+qLv2wanJ0RwWfm4Ddd+FG38wzFFZvOoL8?=
 =?us-ascii?Q?zQFjjha3bBIBgqUa7B7ID6ga3cOn2Psrb8Ggp/was6EORV4SObld2FgnvRpd?=
 =?us-ascii?Q?KHvtmkTU2Z2LbGnNzR1ihadeQxwZA6MNPXW6VN507CqCVWkjHcYA6UgrhVOH?=
 =?us-ascii?Q?QX/mhlrG+5IAycgIH4hahreoO3lnP8BZwLsJXVijMcmlbIzXCOc8zGwzlszC?=
 =?us-ascii?Q?lxd7WVBj5Ln6rjD4Wj/UqF6rEGxCXgTcf0Z1qE1eNK3D6yQoxnSVooAzlwIE?=
 =?us-ascii?Q?cwgBFrJ+B5aei+qyjl5hnf63i6J78Dyc1HaWql0MbzqifUqY90LMv8BG03mz?=
 =?us-ascii?Q?lI969wcpsBs5ZWeOjWE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1jFvBywQpp9r2EZiEZL4LC+MQ/Nc1E8zyl3jRZaSInmstQMYGlo2sGMXxGNZ?=
 =?us-ascii?Q?NfYWb4E6CerQGjrGmloKRAk8BHpBavrWiWNfAEPUd8NoqZ508FmaX5zwlZtM?=
 =?us-ascii?Q?utNRTqDq6wE2RnF4rEPpyGU7rFHYRDB6j9JzZLrfvU5ghPgGGC+O4/I7x+3h?=
 =?us-ascii?Q?eNqbzHIYPKCV3dMS26Qv9+/2R1l8zlBQ6ricwD1BqEWlKJ6SvOIG2JyLUSAN?=
 =?us-ascii?Q?z3hYkN0V1hq6qCYJPqpHmSd68jDwcqFa4XxOvZvz9HU2ZIH+Gg/G5cUl5x1D?=
 =?us-ascii?Q?xPdM2KaNLnHqFKZ5c3QroRcBHHBhhL9XIs9CPgmdEywLslisV8APXJdnOIh9?=
 =?us-ascii?Q?oPzKAMJTELEkyEgDCJokbxwx3P4vpA+wK7fRSKMImrZ6JL0esFKQldAGSA5b?=
 =?us-ascii?Q?jCZMRHRtGEGVDQbGaD9hEFLGA6fXFSr+JDgul/yRtRg6UEsIQoFzKca8Mjmc?=
 =?us-ascii?Q?qv3D54nLfWNFNOoIcioU8EVraIo3xXxL7H8JULGf+LB9ui76GezbLWBGWXxv?=
 =?us-ascii?Q?Y3Xhp3AheZo8oawfnqIyVAi+cFSSpUje9VuLmhf2XSK04dQlw7uOKxY2HOTO?=
 =?us-ascii?Q?V0tZgjpWgLrkYueEtGVsM8LXfSLLj3ZVnwHZfOe+U2t6+U6UP7cdGNvF9XPW?=
 =?us-ascii?Q?IeaXYC+DpvZR/xknPK43u+sYiifGQpqouocvYtUOjOqUfg+8mTgX93JCqdz5?=
 =?us-ascii?Q?WCYlOU7XV1InKTMBrKlVJtcn8DEedVh5nA0yikLv843U97dnI+7ETBmZeEqv?=
 =?us-ascii?Q?CxAUWGZeQv8FFDjIypDnnulc2X4qHqb32ASpimW2VSPUa13Md8V48BjqTya/?=
 =?us-ascii?Q?E2ZZSMiE2i52Ij8n72ezGwqi16gAr9AX0AtvA8K2NmOAbfyqyFCqQTBgyYCB?=
 =?us-ascii?Q?uPSkZd5EO6lpnz6Qd/0AhL3Yno7mHh27NY6x9bc9uIL7Mf9HXGH/I9/QNVcN?=
 =?us-ascii?Q?TkJjmKbQ6fTkcilUYdWYhLXE3y6sbCo6YVxLwTy7DjgUyIWNkbcqKzea2mtm?=
 =?us-ascii?Q?WObGE4lfFXAlSHzxQDnkbYFaxzWuSyf0UqufJ/jc7n8YZQOupT566/HeoMTh?=
 =?us-ascii?Q?Elh2RQP0xoMGrd1YDuRbR67dE0hGZFoxtVY//qSCfCGcVh61NF/yPtMVcjK7?=
 =?us-ascii?Q?vjyD0W7fajyzzOZLCF+1x+L4IZd2jfmbwmDhVbnU/4k2dt6jexqJBvOZ92X9?=
 =?us-ascii?Q?hb7saTYN05XZvSRKPs2dvt7sVe0SoYO4XgT0+k8qbAu6OxV6R4PY9V3VPwv8?=
 =?us-ascii?Q?cMcwB3nMU21xsLiudaz11KZMYkBTQ3Py31/NhmB/FkE5tPOekdQD4wML9kc2?=
 =?us-ascii?Q?e5KGzXllwNm7syex13kT9NmsViUl5pz9937JqrWTzLaB26pIJeIs4CuAUnud?=
 =?us-ascii?Q?/H+ZNeLrRDqMczMNIG+30Vh1lJVH4oaGtcso9DT6glu72Zie8KcyR6TYA/nJ?=
 =?us-ascii?Q?L8H9Sc7k8Mj8mpAPTeXMWLsvDclKh211KsREEyMABaJnU4oOqcZ8CZLhwmO/?=
 =?us-ascii?Q?j6P38TcTjQvznZK2i9iinSphMY9+QEHEjH5A3WbzLwdWe1UMhvqVW86D75nC?=
 =?us-ascii?Q?dRWG+zW1/SAPPBI2MQp+p1y0NfHn9+vVBDJpdc+NzoWciOd33cy0o8nxq6Pg?=
 =?us-ascii?Q?gfXcwn6o/q4Y9uHA6IaxbxBD8IFQhZjZAaikAbMxj0uHNWz83/VWWJ1mQ3kz?=
 =?us-ascii?Q?hp5QP9JdHHxE1BcU/0PC49ZA//VMp1nUTDkeDnUFBM6UCBev?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8686934f-7967-4565-afb2-08de53753d59
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 14:00:18.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qtuBybLTFyZyy/UPKyeegEK//O6BhyQPGEjd5aDCevhMPGw4pkkOXPcwCDiVh3g4Xc+NCVLTsaGkiNmuGPKUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731

On Wed, Jan 14, 2026 at 08:47:22AM +0100, Ard Biesheuvel wrote:
> (cc Peter)
> 
> On Sat, 10 Jan 2026 at 12:46, Robert Richter <rrichter@amd.com> wrote:
> >
> > Add AMD Zen5 support for address translation.
> >
> ...
> > Do the following to implement AMD Zen5 address translation:
> >
> > Introduce a new file core/atl.c to handle ACPI PRM specific address
> > translation code. Naming is loosely related to the kernel's AMD
> > Address Translation Library (CONFIG_AMD_ATL) but implementation does
> > not depend on it, nor it is vendor specific. Use Kbuild and Kconfig
> > options respectively to enable the code depending on architecture and
> > platform options.
> >
> > AMD Zen5 systems support the ACPI PRM CXL Address Translation firmware
> > call (see ACPI v6.5 Porting Guide, Address Translation - CXL DPA to
> > System Physical Address). Firmware enables the PRM handler if the
> > platform has address translation implemented. Check firmware and
> > kernel support of ACPI PRM using the specific GUID. On success enable
> > address translation by setting up the earlier introduced root port
> > callback, see function cxl_prm_setup_translation(). Setup is done in
> > cxl_setup_prm_address_translation(), it is the only function that
> > needs to be exported. For low level PRM firmware calls, use the ACPI
> > framework.
> >
> 
> Does the PRM service in question tolerate being invoked unprivileged?
> The PRM spec requires this, and this is something we may need to
> enforce at some point.
> 
> cc'ing Peter with whom I've discussed this just recently.

Interesting appoach, need to check if that works. I haven't tried that
yet. Though, that needs some rework of the kernel code as some high
priority code depends on the translation and that would cause kind of
priority inversion. E.g. an interrupt handler cannot wait until a
dpa-to-spa conversion is done.

For CXL it is only used for region setup in the init path and process
context. For tracing and error handling those translations are
disabled. See patch 13/13.

Thanks,

-Robert
