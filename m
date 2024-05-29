Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2134.outbound.protection.outlook.com [40.107.244.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922A335C7
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997460; cv=fail; b=nD0//WvAh5i6rmZH3gM/Q3Ef713duGamnfazhA+C35xrD9lMJ3awU9bpW9Y0DW//6WoWH1C0it4zAs8MyU81RN7ZJxS80oCIRmuNb9i5ktIJGy7k0FDzlpF1iG3tigHwXX0lGUkUYHfH2m1fPsmcJsJR/S78Aq2+7KUrYwu8jmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997460; c=relaxed/simple;
	bh=MXCDT4pBukMezItrf6dMU7/SNBNETdJFKyKXFJ86Si4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QDyRR2azJymfsH5bmGzicRNWvw3gPu8Cb7ZswAzMYCqWWiu+tIpVVhmQfHHlXzHzqd8JrYsyBV1i09bgEsUyuZDzNipAN7otzBR7pyt8pRKmvnazGPOYps3b+M2+UCRz1MjC+yvTpw89wzRb9bfJtUjbbVRcPMiq2ekPVnKZ1Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=mt+BrFdW; arc=fail smtp.client-ip=40.107.244.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="mt+BrFdW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8wewO0tzxi9a+D/VMB01SI1tTu1UpYsaHrn1dEg7l4T2Z4JsxoMXn/3hNeFsskka6dgrySpHbO6sYns9OXPZsxO2rC4Uk0N3t/zXeTL7NuvkvWcdAMt6LvrkuIGjy3o544Y2maP+mAI+EEh1JW/0YLZUKe6uz4/3OBUPMyfgWh2DHwmP4FYUV9XcpoB9t7kh240Le2UZjsDG/sSX9C9pDnqFLXQFPF2BmNRJMWu0naEWXnzExOLSWxHkMyjptB23FzlkoG5iMY9TQuXR3PUTPkmAKwNTNbfOPciFGYoWQ2WSh0fg3C98SGFpi18V9kGoordW9i7hfTeVNDwzEiwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqzq46sVirgMaOTJ4Yb21Jw2XrFQ+3AiuSNwEx+75dQ=;
 b=kCPpGzdNZG0YFG6efJD0ijNgGSopcc47+UnctXUHxbifKaxVz+0cVGupCG7c40oIf6LbJmWjM6mzmA2WfW6rqQ+9TuudXDnyCXgD+1QKhv0y2TsBrDK8DXHxx78iYMOj9c6QsbOCBMAOUE49LaOoZ1uqYRiCcucuog6WBAAxglW/y9kjtlsj8HoFCfa348ZH283tlQFvnbXu4zikjR9znsoobcmXrtYaP94KbtIwIIgVFVeKRm2qs0lWR6dz45kQETRkACGt5TahG/SX2t7IS7PU5uv2bDqjNPWj2VLBwrkVv5S7udmhpbdCGBklNE8KgEDP04ivKUc3ExVb4ZFLHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqzq46sVirgMaOTJ4Yb21Jw2XrFQ+3AiuSNwEx+75dQ=;
 b=mt+BrFdWjBYgwru9OT4j2SHD+Jux15jh1UhvoKCk4FNNr2u6YAzz1ngbb00JZyCmIk8DpiUUibFX36oBD1//t4Zh5eD5lC1XbU5cOKqWzerfq5Kl30abdnl5GAfIlfvxaB4RskTO7SfarnjiQswgEvVoiuaszH1a06a1vR3qaT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from MW4PR17MB5515.namprd17.prod.outlook.com (2603:10b6:303:126::5)
 by MW4PR17MB4259.namprd17.prod.outlook.com (2603:10b6:303:7b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 15:44:14 +0000
Received: from MW4PR17MB5515.namprd17.prod.outlook.com
 ([fe80::a27e:e0a5:9b63:297f]) by MW4PR17MB5515.namprd17.prod.outlook.com
 ([fe80::a27e:e0a5:9b63:297f%6]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 15:44:14 +0000
Date: Wed, 29 May 2024 11:44:06 -0400
From: Gregory Price <gregory.price@memverge.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: CXL volatile memory: How to restore the previous
 region/Interleave set
Message-ID: <ZldNRtWRXOhvfIdl@memverge.com>
References: <36106fcf-1062-4961-8918-4471fd313a74@fujitsu.com>
 <6656801ef0dea_1668729484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <a815a715-c0a7-4f7a-9c5a-982f697ddb07@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a815a715-c0a7-4f7a-9c5a-982f697ddb07@fujitsu.com>
X-ClientProxiedBy: BY5PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::46) To MW4PR17MB5515.namprd17.prod.outlook.com
 (2603:10b6:303:126::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR17MB5515:EE_|MW4PR17MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c2842f-2026-4f40-c628-08dc7ff630d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Np4Usja9EcVW0swjDtuXK11HhEzkOKRcyIP6Uzh8q7FIzDgoAoUwRHzvUf7g?=
 =?us-ascii?Q?8pOsWmIUs/Gi8zXKW2dgOtWvyX/92NGDs82j/AVKndZe7EkAacQV83DnER6R?=
 =?us-ascii?Q?LszyN2f913PigLuAKlSUILDp16w67Boqe8t5NHdiw16fHCZvON88LNQPiN6d?=
 =?us-ascii?Q?dHyjv8PInUsLo3VgNmV4re/TyKceiDDGg+o6egCuGevGjQzq5QxvV4PKaCB5?=
 =?us-ascii?Q?BsbiqBr/7XQL+Hg84jn1++8dBmrz9TWXO9thHgrWRPXsIFE33KA6t9zyBFeh?=
 =?us-ascii?Q?UArJFpf1iQihDdRVZtauaRjBLLWTxB83lA4Gr5G0aGf+9qb2paD2Dn+qGOSS?=
 =?us-ascii?Q?laQCgL2DGurs5z2JmyLnGAc5jgg6y59xCJMHOXpWgrDm0Gp9pWmLrHyClopG?=
 =?us-ascii?Q?oA+6tdoelbhEsSZ38qxxcBLQvD721TcHztuERjehI+bzOlGrO6i+zxV7yyg/?=
 =?us-ascii?Q?oO73HeUDEsExDIWy5o0hmvnb2DB/ikX6lZfegkJihh+NXVi4mDEavgyjLSUI?=
 =?us-ascii?Q?+1z3T5eNjpL1ZQlyMOsCHLzARngNh5lb0G57CDQdgAiTiYIQrxHlLUXpvcm6?=
 =?us-ascii?Q?s6xlXSXRDrbJ/bYTzIYak2oanwV+RATwr5dvyp/wc/MW6/x0x4xiu5avP6H/?=
 =?us-ascii?Q?gCzNyY+ZgSLKtcsiGKS5MRxgJXI5Blx0bdubpTFFm2NTvK7XJa27Ae/SzJ/h?=
 =?us-ascii?Q?IdM6zwZHnTDch0JjnOkslUKwW7XVYhJqbff6oQfc9SUcajsMXvkLIcX5qxh4?=
 =?us-ascii?Q?eA1DBxUhi/O5JfOgMJmVembRgwvke+AHUKPui/qtJvXyRPo3PFBJd7MkxlU9?=
 =?us-ascii?Q?CwaD2EVgnVUhcn/dqWMlbTobzWRr6SSxghm+ihOjgKrUjXOq8GgapnltdHRl?=
 =?us-ascii?Q?hHCWxkySZNz1cf6xYZuBKhK9YVVXwevgFnaOjbrwYaR2YBd0DY7DK02DKBuR?=
 =?us-ascii?Q?ROjWyd6hIMqi2yAAkk3oKkVSXneWjMaMmEfuvykgkAn4C4sUfUOcZocirauP?=
 =?us-ascii?Q?G15SDWhHt9tpWZz99nrUjw6P8+vDGCWkpoV/mlsoT/2nUxwauRcvNnBK8jtG?=
 =?us-ascii?Q?RkVBgTPM2SvAnNcFIU/ekOYIZ+pvS+tTua+KiU9FPdMYG7as3XpTdRLQe0Z2?=
 =?us-ascii?Q?utcR4R1PU0tz8UQNKY/ezVck1jxa7Qh25lsYiAav8Mt5UX765DD/h/dWs2CY?=
 =?us-ascii?Q?qtT279WH9pWsJD6GgjWu1uqR0LbPdNxOjeaeVFpU3q1cy121YMBR3wT6S+g?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR17MB5515.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RvBCBeIcZlZt2fBVKoVlOIWQAZZpp3U1cT0vOHLN2uX4/BrkT38XtJAm8IsF?=
 =?us-ascii?Q?nYivqwx/vVJUUMY3OUg9IM3kczvx8ghto0++qiOO8O4qOYGvfOSU1SPxQtYR?=
 =?us-ascii?Q?zBqGL69PUVnOYV8VxFeBriRrofJWypVHpWmK2sVmjSULo4rIKmCq4bMRv+qV?=
 =?us-ascii?Q?NX/xjMsHLeyv2H1DYHEUmebRAUpDvtuFm6t+iEkeTHh58zyotjafJ1RNKy7n?=
 =?us-ascii?Q?ARZuRivZog67WSHCSdB45H2dj24iBz8ST01tPES4Z919BEz8zUbdgy1Oj+bX?=
 =?us-ascii?Q?YisoReiCqJhhAswnkqMOUaaZEtuvtSqwVabjvHeSon8/qGCJoCafn/psKXyL?=
 =?us-ascii?Q?3Y87C/R8anJQpxSO06IQTYqc+aiT24U+g7jcQDVsdpfvS2Q2kw2UXYcZfmJM?=
 =?us-ascii?Q?PTgon21dOTW8lvguGkxr0FQUXHKNNb3Q9prFIU2hhZnfcYZ+uRCRIsvOtrrh?=
 =?us-ascii?Q?3di3RafiDnHDaB7BqZNXuFI1fut3eiJLiZ8moyOtO9fS0OY5ixFH8r1tfZbT?=
 =?us-ascii?Q?WlEis6CqlHYFNK/GnBv+sp5HGNp8Z8vOrbREEzoxiCrQGeyaOSk87E90Jk5U?=
 =?us-ascii?Q?DaPSYIaWzaTTT1w3ot7N/mYuDUTmL41RJIdq0aK0UkP0wae4An3kjy3tREzs?=
 =?us-ascii?Q?49cI6ejF0neqCwoBZQ63XOc5HszE2QJ5zX3pBOSAgxn+LDBjulHoWQ+cV1Kn?=
 =?us-ascii?Q?znag0hzCtVsddGTlLoOTuMo3EFsG0zE7FW2N6krrzhhX3BgzwuZrN03PlGna?=
 =?us-ascii?Q?i7z2At15TfnRrqG0wPhdEbd2yaXN78EQIF+HrWQznPu0fnGr1QKTis10vboI?=
 =?us-ascii?Q?2pnfNUNtZ8lkSANxnV+frAkBensLxIQ4LIeZbaDGtVuW9Qb099OwY7C8EYGQ?=
 =?us-ascii?Q?2yUYPfqaOcrnizEeyzUEsWc3YJBFjEpkQ3K7tI+9cn3m7Kb8/mOcp34gYeKY?=
 =?us-ascii?Q?tGzuLUNF5N0qutR8rf52EkYsqUXk1GasHeHsyXqWgIOZJtoX9Gx0rQCJ7VU5?=
 =?us-ascii?Q?3N7Pa0NGqkQ5DCh5XYKpVWYybunCL8vRwfG7dSH7KHj1Rup6jztbhpkqxrBN?=
 =?us-ascii?Q?0iYzp1fy0aBFZrh4id7UG9hYAqYYoWFjuRG8qXJlwZ+QFHKFwcMXDA+DJ1j4?=
 =?us-ascii?Q?zZ2UmXcMkajsEV1BVoSbeD2cUK6+ix6RsEtoK9OY+duJ/yjhMknvqIez8s0Y?=
 =?us-ascii?Q?T55XGgc0OHLTx0Gg9CrxWdozowe3LNvSI38mov/KxEIlYfSzDcnEUmwWkJek?=
 =?us-ascii?Q?skD+TmzaZGjCejLhiq9cPuZ/6p4aUYo/6CJMnyTYsgupGkeSwxsK0S2wbNH5?=
 =?us-ascii?Q?W//Urj+w+vObjkx345WohOa6kAxzbq3EVBUlS3SD2FjLpERv//jy7L7uF7f9?=
 =?us-ascii?Q?YqbwoThUJOK/uzWEp8eKkyu7oeeXCu675oqDiiXKWcgGCcfEfqUBVaLId3UC?=
 =?us-ascii?Q?v9IaN4HGUnRlOdX/6iCospNv+YyFpKZEO5+Oxsu7lIafubbGGSjCyhCQyUJ+?=
 =?us-ascii?Q?pc4U7cguIJeZ10CH/tuTcfJ+peL+Bp+LJixDWJ5kgQyLTH19l8SlFYiUa9rP?=
 =?us-ascii?Q?uTngEh7t36gNFmGdwqjnZ+L706Mi4NskUALMjJw3FIlBmQLf3Z+3z/YrsIPd?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c2842f-2026-4f40-c628-08dc7ff630d9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR17MB5515.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 15:44:13.9677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhVkzPg8/bQsbQfwFEZsAuYkG9b/qW72w2LeMW+5o9/Q7skdGNvKjfkQ1cMlTr/OzzH17NXv7Cp75M6iHkroK8NgyikMlSKCjRT5vvUWleI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4259

On Wed, May 29, 2024 at 10:19:21AM +0000, Zhijian Li (Fujitsu) wrote:
> Thanks Dan,
> 
> 
> On 29/05/2024 09:08, Dan Williams wrote:
> > Hi Zhijian,
> > 
> > I dropped members@computeexpresslink.org from this thread. If those
> > folks are interested they can follow this discussion here:
> > 
> > https://lore.kernel.org/r/36106fcf-1062-4961-8918-4471fd313a74@fujitsu.com
> > 
> > Otherwise, the way the wider Linux community learns about consortium
> > deliberations is through new published spec revisions.
> 
> Agreed. thank you.
> 
> 
> > 
> > Zhijian Li (Fujitsu) wrote:
> >> Hey CXL and Linux-CXL communities,
> >>
> >> I am trying to understand how the current hardware and software can work
> >> together to restore the previous region/Interleave Set configuration for CXL
> >> volatile memory upon the next boot, but I don't have the answer yet.
> >> Therefore, I have several questions and hope you can provide some suggestions
> >> and thoughts. Thank you.
> >>
> >> Q1, First, I would like to ask about the scope of LSA. According to CXL r3.0
> >> section 9.13.2, it seems that LSA applies to CXL memory (including volatile
> >> memory and persistent memory), but it does not explicitly state whether LSA
> >> is mandatory. My understanding is:
> >> - LSA is mandatory for persistent memory
> >> - LSA is optional for volatile memory
> >> Is this understanding correct?
> > 
> > I would say it differently. LSA is mandatory for persistent memory, and
> > irrelevant for volatile memory.
> 
> 
> Another reason for my above understanding is that the current QEMU
> documentation[1] also states this, and the actual code behaves accordingly
> (mandatory for persistent memory and optional for volatile memory).
> 
> [1] https://github.com/qemu/qemu/blob/79d7475f39f1b0f05fcb159f5cdcbf162340dc7e/docs/system/devices/cxl.rst?plain=1#L324
> 
> Anyone have other opinion on this?
> 
> Hope the CXL consortium can help on confirming on this point to
> members@computeexpresslink.org privately.
> (Currently the original mail cannot reach members@computeexpresslink.org
> until getting its approval)
>

Just to be concrete:

CXL Spec 3.1: 8.2.9.9.2.3

"The Label Storage Area (LSA) *shall be* supported by a memory device
that provides persistent memory capacity and *may be* supported by a
device that provides only volatile memory capacity"

For persistent: Required
For volatile: Optional

What Dan is saying is that an voltile-only device with an LSA is
possible, but the LSA isn't particularly novel or useful since the
data in the voltile region is destroyed when the device is reset.

Recording things like interleave set configurations in LSA doesn't
really make sense, given that devices probably shouldn't know about each
other, and an interleave set kind of implies knowledge of other devices.

So as Dan said: An LSA is irrelevant for a voltile device.  Anything
you'd use it for is probably better accomplished some other way.

> > 
> > The expectation is that BIOS, or the OS for hotplug devices, deploys a
> > default region configuration policy. That policy in the common is likely
> > one of either maximizing performance (maximize interleave across
> > host-bridges), or maximizing error isolation (create an x1-interleave
> > region per endpoint).
> >> What is currently missing on the Linux OS side is a default policy for
> > unmapped volatile capacity after all initial device probing has
> > completed.
> 
> I would say I can imagine the policy you mentioned. *policy* would work
> on some cases, but
> For a customized region, a default/predefined *policy* is not sufficient.
> In my mind, a customized region could be constructed with part of all
> the available memdevs(SLD/MLD/DCD), and customized interleave set.
> 
> So the the previous used configurations including memdevs and interleave set
> should be stored in a persistent storage that the region can be restored
> correctly.
>

There's any number of reasons this is a bad idea, the most obvious of
which is that your recording information about a set of devices on each
device.  What if some of those devices go away (or are upgraded, change,
whatever) and you need to do something different? What if you move that
device to another machine?  The state machine you create with this setup
is pretty awful.  I suspect in answering these questions, you end up
just resolving to save the configuration to disk instead of the LSAs -
which (as Dan said) makes the LSA irrelevant.

Really what you want is a smarter daemon that detects the topology and
implements the best policy given the current environment.

~Gregory
