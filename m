Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D03F8EB2
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723428; cv=fail; b=iewKacjvwmID+iXSR7zGduEO1DZgQYC20sPZIc8EakP3OknYL/8q/x/BQz08bpncSkPr2Grfr0O7gHGVNxb8Q47WkDwd+dzlizFZfEaRl0C/Rj4nPg6N472xonZBQ4vRm+eQYOTiolp4a6lKokHvjJt4TqoaN/WHVRSdVmkHPXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723428; c=relaxed/simple;
	bh=yRNF5Tb/tbQsKCNwDsN+WZQUmABoK6Bq9Jk3N4XczEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XHb7ZdIbR0k4Wn2bv2uxi0twlyzIYf7XTAtb+3g9W6rIoc8fgPJC3ZjPWPxrHzI4dAlJaPP5KJp2YrvFoWVkEaDUrWe+J80Qbp6iv13P58Q9SpkY6ic9kNDlDHdjSJjE15E6DLLlK85C3JT9EwCoXElEnRWqSLiyJJPkpfEPpmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vUJ0hGAS; arc=fail smtp.client-ip=52.101.85.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vUJ0hGAS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jo7fyFkbGJat52fIhn3EevwdfodxwNB8wEQQs0o8Oxt/+G0tvFTrclGm6/v+yRcVw59kHAhDErXLaacBbK9KBpiIfxWBshbEfUD63K8JVeKQ8x/WVUYddhUYZhfX6/UUlVBo9hHsd+9uRC8+UVnAkvOEMcetDsR3xOEp8oWmcbxwGMzGQtWeMjCMHNad2oJ2Pm3ZzkrRguDoWkeUNQ80ZCZo7PFUr7xt181+Ia1Wa5Txp7NjBOjCYms9sf4epcwJX8PNezvrtSzZLyZeumBXbT9FSCrXWMH7BR5oHN9v/wBJ2USp1A1y2eVt6Nwm92d5M9hwO0BIVyHp3Il2OTgJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDRMBc+bSXE8g+z43EZT2l/pvFg1uFunEmtoCUKvBNQ=;
 b=sWhZnrOP4ebmsO/DlD2DSrUc6r4axn2df1H1Ptzc/tnfTkfsgmRnz74cOyvW3EFZwTlhEVnyOAv2xeS+HXMwuS5SdKZsFuPbRjmGr8c92vNaq8arQpzachqJqz+QSx0KUjrOCXodibc/BV/bMMvH27vOTFjD+UT0T6khtoO4BV73AHEnCwvT8HaI0d8hwcBAPVLzjIqi8ZzOeYdEu+I2VucQJKOeRGM2cj6sp8KHXZoF+sDwMAewKQAKm54ooKwhAAs4H3CWb9i+H/eFNkOjvs/k/rjJV4JJpS4HDJ23+VHM48OJQ0IYg/62/Iqg32hyX9R45N7yc8cTXVj/LhS4wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDRMBc+bSXE8g+z43EZT2l/pvFg1uFunEmtoCUKvBNQ=;
 b=vUJ0hGASQGxPl/U8W/Q7ATgXI38OrD15PiQfoLB3blTYOk/Nd0LdXVr1hapDe0w9MdE9SYNEtRPHpLf4GHR+HW/EZFPeHxBQVJk+6fAB+FDiLmdLZBlZVt7Uv2ZW7WImtC8Li7n+XDXJK+zdxf6N7wcGfaf86bkADZpM5CMWaa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 IA1PR12MB8080.namprd12.prod.outlook.com (2603:10b6:208:3fd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Mon, 29 Jun 2026 08:57:01 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 08:57:01 +0000
Date: Mon, 29 Jun 2026 10:56:55 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 6/6] Documentation/cxl: Add region granularity and
 multi-level interleave guide
Message-ID: <akIzV6JJUTWJx7Jw@rric.localdomain>
References: <cover.1781199122.git.alison.schofield@intel.com>
 <37c667b95699aaeb0e58104ece07d17720f55a18.1781199122.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37c667b95699aaeb0e58104ece07d17720f55a18.1781199122.git.alison.schofield@intel.com>
X-ClientProxiedBy: BE1P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::6) To DM4PR12MB6085.namprd12.prod.outlook.com
 (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|IA1PR12MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 7090fc0b-c656-4099-06b0-08ded5bc624a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|56012099006|18002099003|6133799003|3023799007|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	qcIKCuLG5PcVBKku3Y1J1mamgBym8y2eSdt/PDCNPzg9XuXMV6uXdteh73RDnOHi4Y5uEvOpqo4jqmnzorvRyBCtRv7ckosw73//P68edYSj2VOEB6bcLBaWAggNPm52C2Hg5gkynwEJUD8Uy5f0ugRuRWpBWVgg+KOM4ekZ3fchPyKnRu13aiV1Gs+ZwMkGeUKafx5MNwNRJUged3lpt7d6lmXyFyb1K4OMJo320/7BnIpN8g1nlkpXn32yAkC60me9F21Ov/9DRT9jXX9zfAb2iSCnSf6pEc67rJIXAdSEMYqR8OpSOWmptj91AWflvM024G3TrwMpZm8FAaUodTDnSRN7LuI5xJRyDgCFTcyJ6DI2wc7I5Sy2W056k/byBaODR5PevJX58hL861WU/tREjzNFsFTzDcRbmckkglMnxf0UwGf99T/PNM5g4k5NuPLxKzJMb3dQ8kU7diVM8M4EUBM0zmdQPlSvnaZ5+3MdU4IZ+CfYa9TarFsSgAot1j6ZoZ81FrrrNxwAbqit6Id1T4k/eI268zoaAk4ANi4La84qmWNkLfHfXf9V9CMiIZ0a10hfdJusO9s4JAWkYGuw0TPxOAQXk+THl6pXYy3i1v9AWjPPqbmRrd5e1yEm32xK47h697jteGbakS7Pi3ketJTDk7q/qek5QqJ8D0Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(56012099006)(18002099003)(6133799003)(3023799007)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e/Ei2fKWYwptSssZg/pBfOO96WoMmX0r+cu3Ank50h6WMjg28YdzQ18Awz1A?=
 =?us-ascii?Q?+Y+MS1pdw/DsAdyQtah1CADvKAES1JGQs3hLjxSqGoTC0iWVhxVmW5WkKSap?=
 =?us-ascii?Q?yR/yQYmSsDnZOrzb7WwIXHb9YD1pTerCygPYW+TKRR6SRc9nd2aoUbNyJBV5?=
 =?us-ascii?Q?BUdVTZ3/Gn1cTTo9SugizmsLAP4ez0nSWr6K1MK/bjqt7pU+gdOYY7x4FGZR?=
 =?us-ascii?Q?PvzS9mQcSNx+jO6dPAktNKQFOoPIWFo9kEyGoPGig3XArunxgJn17MQ7qf9f?=
 =?us-ascii?Q?S4yU7/ZhYJbla9WyLFLALCvAwDtbEEAz/xwdVzHr/m9YiRPYONBABLxt0r5K?=
 =?us-ascii?Q?7Sw61/rD63vZ0CCfGnKBXv1c04uA9m9gKGGZZkcNcWivgomi2NsyJF13itki?=
 =?us-ascii?Q?GqtXwf/D9RYiq22szxWglSdAcWJHc3IZB1/VZghs0Pl9QD3lXn6GY0vwo0Ve?=
 =?us-ascii?Q?2uWuf0UiyvfAOkZqKGcYiqimG91xtUFpWzAyi7lpcULNVOepjIgazLUtOHIh?=
 =?us-ascii?Q?RW9EefU0jq8+Ij65IpuUo17XKWrv/62TRtM0Tl5Umcm5GtTT4RMI3BNLZbrc?=
 =?us-ascii?Q?JPVRzpS6eEYSNJ7Ukg96714wnI6QAOo1WZGPU0bEj4LMmQOvy8d2KmlVQbYU?=
 =?us-ascii?Q?MxrI9NezUuWebFttHpnmg5n5zuKDZ/yqhD2gGeZaLOfX9L/aVgOOIv2xiiNx?=
 =?us-ascii?Q?lLbWuC0LXWxn/63hmfz2YpTtJP3jircbToK2BwyHpmc9O/Wmjh7G5YyhayWI?=
 =?us-ascii?Q?cdBl7RX5px2JXMcyffD+fKiN0DzqdgwYbhx29v/3q8JMV3BRvMbfnay1co4g?=
 =?us-ascii?Q?FN8+Fk+vgwT66jSMsVqrdfhJ4ME52pYZnX5CdCfS36BJNRppisHvW2oXJIXS?=
 =?us-ascii?Q?jKquCGx3fKVnad9KdHOCl0KUCKlDSu9pNTNTQDEChTKLD0lJAoW8+EOj184e?=
 =?us-ascii?Q?Bflnul/qqaaR43FYE5DhGWeIfCCzYMZScOdrgp8iT5U+7qGPvF/t4KlIghB9?=
 =?us-ascii?Q?R/QkKgkLpP0fBBioXOFFPnQnWys43o+qHCM7RcN7Hv7plYxsHU17Gd1QNCQo?=
 =?us-ascii?Q?uoPh5qad17xVkCNe9A8zqQSbi0cEPoy0XOYbFwwkoIEJHgW9OuKOcOLvw2+4?=
 =?us-ascii?Q?a7oRbq+r15Z5IABJhoHyI62RTCSaKKTWqPXo5+csR99n/K/p2dbFuy4QfWSe?=
 =?us-ascii?Q?iCu6WPfQRsGDUkn7iPkaqGvcU1b4rRJyfraXLpRkN7ccQbcxmh1C9SE9izJ7?=
 =?us-ascii?Q?lztQbRxfNHQK+vRZFY3qNmRyy8Mjdbhs1m7xfN7kPe2jzPdkjDSN9a1WQ5gH?=
 =?us-ascii?Q?71lx8Cc7jlcP23ahzNibBdEbGzBNCcMiudBk1/PIJ0vXiUAJU4AW6DKSDXu6?=
 =?us-ascii?Q?M3qeP+LnGX0FcJY8HbacGmpd/kof/lZ2KJ44rP3cPKcFoNX/dAzk0HAxrx3c?=
 =?us-ascii?Q?apVqBLx91vbvxJc/eB6Twybv9D1blh2eXlWRJVagghvPITTrUdq4YLXVrh1e?=
 =?us-ascii?Q?CQgYY/yINB0mW5FAgur/qVb59GMITKixS0qlAoOCJ60SeH9t+ybF6ew89z7B?=
 =?us-ascii?Q?101KKXcNQT64JtI1bF6BnbKJejfi9TzbBdste+BSSVUqD/QZR7yMWbqZq0iG?=
 =?us-ascii?Q?7UZfZS00ik54kV9XxCrRCgggSOD+/24J7C+BVPQABDDTNufQH23qle0gmXpt?=
 =?us-ascii?Q?9x9yWnHaOEIUhVDw64esB1eqj9STHjWDr9esT0kb3LQR0DWg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7090fc0b-c656-4099-06b0-08ded5bc624a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 08:57:01.4771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1K2Af8Mrb3jfGt/Yu2ZjfKLqyd9rlhMFAxE+ydqLPwYkYSXkPd57yB48K8is7KI8ckUwVSmIE8MsgZFq9zISQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8080

On 11.06.26 10:47:30, Alison Schofield wrote:
> Document how region and root decoder granularities interact for
> same-granularity, power-of-2 mixed-granularity, and 3-way-family
> interleaves.
> 
> Explain the selector-bit model used by the CXL specification, the
> legal layouts that result from it, the additional span constraint
> required by 3-way-family roots, and how the Linux driver validates
> those rules for both auto and user-created regions.
> 
> Assisted-by: Claude:Opus-4.7

We should drop most of the documentation as this just rewords the
specification. We should have a single point of source which should be
the spec. We should cite and refer to the spec to explain details.

> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  Documentation/driver-api/cxl/index.rst        |   1 +
>  .../cxl/linux/region-granularity.rst          | 486 ++++++++++++++++++
>  2 files changed, 487 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/linux/region-granularity.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index 3dfae1d310ca..1ae193ea4020 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -42,6 +42,7 @@ that have impacts on each other.  The docs here break up configurations steps.
>     linux/dax-driver
>     linux/memory-hotplug
>     linux/access-coordinates
> +   linux/region-granularity
>  
>  .. toctree::
>     :maxdepth: 2
> diff --git a/Documentation/driver-api/cxl/linux/region-granularity.rst b/Documentation/driver-api/cxl/linux/region-granularity.rst
> new file mode 100644
> index 000000000000..7d0d12e6e2bd
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/linux/region-granularity.rst
> @@ -0,0 +1,486 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============================================
> +Region Granularity and Multi-Level Interleave
> +==============================================
> +
> +CXL memory regions stripe accesses across one or more endpoints by
> +routing transactions through a tree of decoders: a root decoder, zero
> +or more switch decoders, and an endpoint decoder at each leaf. Each
> +decoder in that path uses a contiguous range of HPA address bits to
> +pick its target. This document describes how those bit ranges combine
> +across levels, the constraints CXL Spec 4.0 places on legal
> +combinations, and how the Linux CXL driver validates and programs
> +them.

This suggest that cxl spec 4.0 introduces that constraints, but it
doesn't. In fact, 9.13.1.1 just documents the combinations of
interleaving levels possible with 12-way, 6-way, and 3-way configs
which results from factorization of the ways.

> +
> +The relevant spec material is CXL Spec 4.0 Section 9.13.1, especially
> +Section 9.13.1.1 ("Legal Interleaving Configurations") and CXL Spec
> +4.0 Tables 9-6, 9-7, and 9-8. CXL Spec 4.0 Figure 9-17 (two-level)
> +and Figure 9-18 (three-level) illustrate the bit-routing intuition
> +this document builds on.
> +
> +
> +HPA Selector Bits
> +=================
> +
> +For a single interleave level with ``W`` ways and granularity ``G``
> +bytes, the **selector bits** are the ``log2(W)`` HPA bits the decoder
> +inspects to choose among its ``W`` targets. The lowest of those bits
> +sits at position ``log2(G)``, so the selector spans
> +``[log2(G) + log2(W) - 1 : log2(G)]``. Equivalently, the bitmask is
> +``(W - 1) * G``.
> +
> +A few examples make the geometry concrete::
> +
> +   2-way at  256B  ->  selector bit 8         (one bit)
> +   4-way at  1KB   ->  selector bits[11:10]   (two bits)
> +   2-way at  4KB   ->  selector bit 12        (one bit)
> +   8-way at  1KB   ->  selector bits[12:10]   (three bits)
> +
> +Throughout this document "inner bit" means a lower-numbered HPA bit
> +(smaller stride, faster cycling among targets) and "outer bit" means
> +a higher-numbered HPA bit (larger stride, slower cycling). HPA[8] is
> +the innermost legal CXL selector bit; HPA[14] is the outermost.
> +
> +
> +The Multi-Level Rule
> +====================
> +
> +When a region's interleave is split across multiple decoder levels,
> +CXL Spec 4.0 Section 9.13.1 requires that:
> +
> +   "all the levels use different, but consecutive, HPA bits to
> +   select the target and no Interleave Set has more than eight
> +   devices."
> +
> +Two requirements live in that sentence:
> +
> +* **Disjoint** - each level's selector bits must not overlap any
> +  other level's bits.
> +* **Consecutive** - the union of all level selectors must be a single
> +  contiguous run of HPA bits with no gap.
> +
> +The union of level selectors is the **region selector**, and it must
> +equal ``(region_ways - 1) * region_gran``. Because that mask is itself
> +a contiguous run by construction, the levels just need to partition
> +it cleanly.

The region also includes cross-hostbridge interleaving (described in
CFMWS). The region ways could include a factor of 3. For the selector
only the 2 factor parts are taken and the factor of 3 removed before.
The region selector then includes the cross-hostbridge selectors too.

Below, you refer to root decoder and Cross-HB interleaving. Same as
"region", the definition of it must be described in detail as the term
"root" is ambiguous (cxl root, root decoder, root port, root complex,
etc.).

It could be added that the endpoints are finally programmed with the
region's interleaving config (ways and granularity).

> +
> +The seven legal interleave granularity values split into two groups
> +(see CXL Spec 4.0 Section 9.13.1 and Table 8-116):
> +
> +* **Group 1** - 256B, 512B, 1024B, 2048B (interleaving on HPA[8..11])
> +* **Group 2** - 4096B, 8192B, 16384B (interleaving on HPA[12..14])
> +
> +CXL host bridges and switches must support every value in both
> +groups. CXL memory devices must support at least one group, advertised
> +through their HDM Decoder Capability register.
> +
> +
> +Same-Granularity Interleave
> +===========================
> +
> +The simplest case is ``region_gran == root_gran``. Each level's
> +granularity equals the next inner level's IG times that level's
> +ways. The region selector bits stack inside-out from the root.
> +
> +Example: 4-way region on a 2-way root, 256B everywhere::
> +
> +   Level    Ways   Granularity   Selector bits
> +   ------   ----   -----------   -------------
> +   Root     2      256B          bit 8
> +   Switch   2      512B          bit 9
> +   Region   4      256B          bits[9:8]
> +
> +Each level's IG sits one bit position above the next inner level's
> +selector. The region's effective selector spans ``[9:8]``, two bits,
> +matching ``(4 - 1) * 256``.
> +
> +
> +Mixed-Granularity Interleave (Power-of-2)
> +=========================================
> +
> +A region's granularity may be **less than** the root decoder's
> +granularity. In that case the root claims an outer selector bit and
> +the switches beneath it claim inner bits. The arrangement is legal
> +whenever both granularities are powers of 2 and the resulting bits
> +remain disjoint and consecutive.
> +
> +Two-Level Example (CXL Spec 4.0 Figure 9-17)
> +--------------------------------------------
> +
> +8-way region, 2-way root at 4KB, 4-way switch at 1KB::
> +
> +   Level    Ways   Granularity   Selector bits
> +   ------   ----   -----------   -------------
> +   Root     2      4KB           bit 12
> +   Switch   4      1KB           bits[11:10]
> +   Region   8      1KB           bits[12:10]
> +
> +The host bridge bisects the address range at 4KB granularity, sending
> +one half to each root port. Beneath each root port a 4-way switch
> +splits its half into four 1KB chunks. To each endpoint the region
> +appears as an 8-way interleave at 1KB based on bits[12:10]; the
> +leftmost endpoint receives 1KB chunks at HPA bases 0, 8KB, 16KB, ...
> +
> +Three-Level Example (CXL Spec 4.0 Figure 9-18)
> +----------------------------------------------
> +
> +8-way region across cross-HB / HB / switch, all 2-way::
> +
> +   Level         Ways   Granularity   Selector bits
> +   -----------   ----   -----------   -------------
> +   Cross-HB      2      4KB           bit 12
> +   Host bridge   2      2KB           bit 11
> +   Switch        2      1KB           bit 10
> +   Region        8      1KB           bits[12:10]
> +
> +Three levels of 2-way interleave each contribute one bit. Total
> +endpoints: ``2 * 2 * 2 = 8``. Selector union:
> +``bit 12 | bit 11 | bit 10`` = ``bits[12:10]``. Disjoint and
> +consecutive.
> +
> +General Power-of-2 Rules
> +------------------------
> +
> +For power-of-2 ways at every level:
> +
> +* ``region_gran <= root_gran`` is allowed; ``region_gran > root_gran``
> +  is not (the root's selector would land inside one region stride).

It is unclear what 'root_gran' refers to. I think you mean the root
decoder's (cross-HB) gran here (from CFMWS).

Since region gran is the result of the union of all levels, it is
always the smalles gran within all levels.

> +* Both granularities must be powers of 2.
> +* The ratio ``root_gran / region_gran`` is the number of inner
> +  position slots packed beneath one root target. Endpoint position is
> +  partitioned by root target rather than interleaved across them.

This does not give any hint of the bits used for the selector. Each
level has an individual set of ways and granularities. There are no
dependencies. The ratio cannot be used for position and selector
calculation.

> +* Mixed-granularity is always optional for power-of-2 topologies. A
> +  same-granularity arrangement always exists for the same set of
> +  endpoints. Firmware may prefer mixed-granularity to expose a finer
> +  switch-level interleave to the CPU.

Why distinguish between Mixed- and same-granularity? Same-granularity
is only a subset.

> +
> +
> +3-Way Family Interleave
> +=======================

Same here, this 3-way part is already documented in the spec, I don't
see much sense to rewrite it here.

The whole point on 3-way familiy configs is how the HPA translates to
the endpoint DPA and how the endpoint is selected:

HPA: <upper_hpa_part><selector_bits><granularity_bits>

base address: <upper_hpa_part><zero_bits>

In 3-way family configs the base addr (upper_hpa_part) is divided by 3
to determine the DPA, the remaining lower bits form the selector up to
the gran size. Think of prime factorization of the base address, it
will contain at least one factor of 3 and (sel + gran bits) nums of a
factor of 2. The selector bits also form the endpoint positions below
each host bridge.

> +Linux Driver Implementation
> +===========================

See my comments on the patches, a rework will simplify this doc too.

Imo, just add comments to the code where needed.

> +
> +Region geometry validation lives in ``drivers/cxl/core/region.c``.
> +The helpers and enforcement points below implement the rules
> +described in the preceding sections.
> +
> +``get_selector(ways, gran)``
> +  Each interleave level consumes a contiguous range of HPA bits to
> +  pick its target. ``get_selector()`` models that range as a bitmask:
> +  ``(ways - 1) * gran`` for power-of-2 interleaves. A strict 3-way
> +  interleave consumes no HPA bits and the helper returns zero;
> +  6-way and 12-way are folded to expose only their power-of-2
> +  component.
> +
> +  Kernel-doc: :c:func:`get_selector`.
> +
> +``root_pos_stride(cxlr)``

I rather would like to not introduce the term "stride" here. This only
adds confusion. E.g. the root decoder selector could be used instead.

> +  When ``region_gran < root_gran``, each root target owns more than
> +  one region position. The number of positions packed under one root
> +  target is ``root_gran / region_gran``: the root advances by
> +  ``root_gran`` bytes per target, while region positions advance by
> +  ``region_gran`` bytes. Same-granularity regions have a stride of
> +  one because the root advances on every region position.
> +
> +  ``root_pos_stride()`` returns this ratio for the position walk and
> +  the peer-distance computation. The same value applies to 3-way
> +  family roots: in value space they advance by ``root_gran`` per
> +  target whether or not they consume HPA selector bits.
> +
> +  Kernel-doc: :c:func:`root_pos_stride`.
> +
> +``is_ig_allowed(cxlrd, ig)``
> +  The region granularity must not exceed the root granularity.
> +  ``region_gran > root_gran`` would place the root selector inside a
> +  single region stride, leaving the root no address bits to choose
> +  among its targets. ``region_gran <= root_gran`` is required for
> +  every legal layout.
> +
> +  ``is_ig_allowed()`` enforces that geometric rule. It returns true
> +  when the root is not interleaving, or when ``ig`` does not exceed
> +  the root granularity. Endpoint capability (the IG groups a memdev
> +  advertises) is checked separately at attach time via
> +  ``check_interleave_cap()``.
> +
> +  Kernel-doc: :c:func:`is_ig_allowed`.
> +
> +``cxl_port_setup_targets()``
> +  This is the per-port enforcement point for the multi-level rule.
> +  For each level between the current port and the root the function:
> +
> +  * Rejects overlap. Two levels that share a selector bit fail the
> +    disjoint requirement.
> +  * Rejects escapes. The accumulated selector must fit within the
> +    region selector. A level whose claimed bits land outside the
> +    region selector fails the containment requirement.
> +  * Derives the granularity to program at the current port for
> +    user-created regions. Each interleaving level claims the lowest
> +    selector bit still available within the region selector;
> +    passthrough levels consume no selector bit and inherit a scaled
> +    granularity from their ancestors.

Fine with me, but all this is simple bit mask logic. Just comment the
code and use helper functions?

> +
> +  Auto regions reuse the same selector checks but trust the
> +  granularity firmware already programmed at each level.

Never trust firmware. :-)

> +
> +``cxl_region_attach()``
> +  Pre-flight gates that run once per region attach, before the
> +  per-port selector walk.
> +
> +  * Auto regions bypass the sysfs granularity gate, so
> +    ``is_ig_allowed()`` is applied here to give them the same
> +    geometric check as user-created regions.
> +  * 3-way-family roots require an explicit span check. A strict
> +    3-way root consumes no HPA selector bits, so selector containment
> +    cannot prove that the root and region cover the same address
> +    span. The span identity
> +    ``region_ways * region_gran == root_ways * root_gran`` restores
> +    that constraint. Power-of-2 roots get the equivalent constraint
> +    from selector containment and are not affected by this check.
> +    See `Span Identity for 3-Way-Family Roots`_ for the full
> +    derivation.

Same here, add it as comments to the code.

> +
> +Position calculations use ``root_pos_stride()`` so that both
> +same-granularity and mixed-granularity regions produce the correct
> +endpoint ordering. The position walk itself lives in
> +``cxl_calc_interleave_pos()``.
> +
> +Kernel-doc: :c:func:`cxl_calc_interleave_pos`.
> +
> +
> +Auto vs User-Created Regions
> +============================
> +
> +**Auto regions** are reconstructed at boot from the decoder values
> +firmware programmed. The driver reads each decoder's ``ways`` and
> +``granularity``, runs them through the selector walk, and accepts
> +the configuration if it passes the disjoint and containment checks
> +(plus the span identity for 3-way roots). Firmware is the source of
> +truth for the granularity at each level.
> +
> +**User-created regions** specify ``interleave_ways`` and
> +``interleave_granularity`` through sysfs; the driver derives each
> +intermediate decoder's granularity. The sysfs path runs
> +``is_ig_allowed()`` at granularity-write time, ``set_interleave_ways()``
> +at ways-write time, and the full selector walk when the region is
> +attached and committed.
> +
> +Both paths converge on the same geometry validation rules.
> +Differences between the paths are limited to how region parameters
> +are obtained and when they are validated.
> +
> +* Whether each intermediate decoder's granularity is read from
> +  hardware (auto) or derived (user).
> +* Whether the membership of the region is established by walking
> +  firmware-programmed decoders (auto) or by user writes to ``targetN``
> +  attributes (user).

This could be condensed to:

auto: config is read from decoder registers
user: sysfs is used to setup decoder registers

-Robert

> -- 
> 2.37.3
> 
