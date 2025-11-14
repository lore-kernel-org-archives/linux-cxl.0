Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A65191F91;
	Fri, 14 Nov 2025 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763106463; cv=fail; b=Z45rNQsuyJ0cy8DJpjuGudkduYjdju0mjT/5B8oi6LAyoTC4kyg0kdzZHObYZ/5yH+ZXs8PziB0KpFmf1R0w5iJrgF4GoKhJCfmsKprAwDRVfnf+pzG6tqzomiRLxjY7PIzlKMLcE9mXDc9I/LPtqbGwBkgQmNQ/5P0cRDUiIS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763106463; c=relaxed/simple;
	bh=ljsVCjIFXltdRwkM9Cxne9AuvU2cwN8dLfMu8xlf62s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tsCeCmJKuOhh3g3HlQxGntqUEK3FTOaslNGTNoZarvJHYlfy+It+ce0aSXSp/MvISl0G0lhmzXAPaPW43BZx+mmrMwqjFxGGb/JaGXCcHWgZ5RazRVkYW+X2AqRQv+uA874a/wSFB7n1arxn2P1djr2/NnSFXcuSq2xnEyW4+Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DktPQsnF; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DktPQsnF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMCuH3g20uKFv9d7oVc1J/WzIzkLzA+lxEwkIvwqEyBNv1Y1DoEBmQyjVraY+FWyhnW9t5VhbL05q5Da0hLFjGebdQo2oz7C2P+BEExNQRUg/6JPUHCKWu6iqEyRGsk9n3zVKFpPCQpYofcCSDq8hJN0o9z8BfcTJpeUEpxLjHkG9/ldWsrbHObgnG+JHfcwJxzDmENkNaKedOOOZ8J+uKZ4XozPpB4u9RZDnYssTjaESUxuZb3EFzA12ZgdufvY+7QUjsSu7wTAnPStReYAFY9GHZSHxXyrb8eVsSpWtkkOTgSAmwVod5sfo96hQAqdmwdI1VgMvHieVqypfWxhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJLXDTMLrIQTU7ORtOD3vYdccuD4YCyDsYVY4B96AVw=;
 b=LFseh773SiZiJavdGHmY6E9naNT3uTM+V/AETteX7RX5cteJXjAT+U3seuMau60rJub4DoLml9Jy/hd2qY2lyN6E44CCALAQv6psex65W+Jc21OALLuLuOI3+bOo+AxaiiqUiSlbID05e5sCYhoJM7+62hpt2tvdzCRlO3CuyRb9RmgywXJSbV05G/P+TfQgmC+7YCyN54c9vIZVvoHhLdeS1qj+GtL/5/1+niI5UutCnnjkapLWO3fhi5zOOTSN++csvoHDig5momt90g64REBnaxi8N2dQochmmtH38l57drwGTIqwgZHMay0gbLpx5k4WAB8Y1QjUB6TdUZgHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJLXDTMLrIQTU7ORtOD3vYdccuD4YCyDsYVY4B96AVw=;
 b=DktPQsnFBfxYuMqIyg4+yYjdoWNvEkzPEn+1hO5n0FMA47Rh07qLO1EUN4wmFyZR7ImACqX50RsWThU5MA64n4R3EDodK3uxAog3S0qODxG/ysJwXufIeWtkdBXJtNBohxVT6vYGk4U+2bjtSRYN77zenjxYWmwxoob5pIAUUwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:47:39 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 07:47:39 +0000
Date: Fri, 14 Nov 2025 08:48:08 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 0/3] CXL updates for v6.19
Message-ID: <aRbeuNpBIE0E0wL3@rric.localdomain>
References: <20251114002632.1309139-1-rrichter@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114002632.1309139-1-rrichter@amd.com>
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: b22249c3-a12a-4339-8818-08de235215d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?keNKOb2/g39xvOByLvx23RKhuBLULs7i4WuDZdrjfSoRpTbjbG8d5r9nDjfu?=
 =?us-ascii?Q?pTH4TLSlddJywrI5rcVSfoC0HY5hp9v+Mwx7QRftjMhtGvwHfSlHTtFTpouY?=
 =?us-ascii?Q?GtqP9Ktubm4PCmdWIqALe2nhmswpGHfdHp0Uk9wfUnlD1HLqdkPOnegeZJKB?=
 =?us-ascii?Q?LgFxF7/ca+Vrw624tFrsd47jUQYMgeLOWmD2FGJi0IaPMbckDFKQ+UnsneZ/?=
 =?us-ascii?Q?jpvcBmhU89FrgEvDJD3oeURsNbNPF28k/730CFBzSW68S8kVzCzhFUh0AP1i?=
 =?us-ascii?Q?aRyVQssMZlNHkEl8RZh9p6PMP9d0ydiqqVoGlJVkfrvYWcOqrl5hyV/yA6Wt?=
 =?us-ascii?Q?9UZYrSty7pa2ohfPmomk3NmWW5h3DxmSmBN70PLLRnmGc2NnepKQO8lSJPyH?=
 =?us-ascii?Q?vFjYV+btTP0paPoxS6yrYhOPZ0hrY8YGq/BrxQNBFIGaxIr+NHe4IpBAASMH?=
 =?us-ascii?Q?/vzOQnz17P4Lm0DO9avg4rVNINjadQKte5L3x326dPpxGYjO4z/XaGlnbShI?=
 =?us-ascii?Q?WEhAD4ePfI5dZJfg36mmq1ie0j/lS8Lgd1b9IlCXH0yjP1q+TlKqju8obK9e?=
 =?us-ascii?Q?VhmWIwR/N4ZNhADfWVjLzNWpaW0ytASxmf8XXNKqUcErFDp+IQE4KFDc0+HW?=
 =?us-ascii?Q?YAwn7Uvn9yhJaxMJOQ+ShCHyNWQ7Dv5SpgQvvyNIpgeXIpaOSHTdyP9bpn8D?=
 =?us-ascii?Q?Qnz2UaEG+NAMsaGQcpg9skcVzNW2JCSihXwfJtpijUGbWuxMopI2GdKVb7An?=
 =?us-ascii?Q?EDq7OTjTYtFdeDjYWJiI9/3FFyq/kV5RJ8gNw0rQTQ+vROX6umTzZzyj3VJm?=
 =?us-ascii?Q?LHJ1N91/cIBRZVrJv/EB4/lLwyguW1c5epLeEWkKxke8LoFt+Jcc6Nb+IQPx?=
 =?us-ascii?Q?WK5dYVa9hzy3JJGSo+w4XcZ29AoKEhRfhBB31Jg5SQx6mP0JsLd9+jR809KM?=
 =?us-ascii?Q?hE13MRM4ME3s6V8S96SsL9e+NemTDmAF+DhbAyO7ee3rtuLnX4KimdeTXYfD?=
 =?us-ascii?Q?uESajsYppYSVreqIsiz8f3XWCsu+JXSkmQdSfGH+b1p9cHcUSzAeA69kA94d?=
 =?us-ascii?Q?hn8M1GTiLqwyhini96i4rc88ff9B+O1xnGsF9T2XP+ceV7NctYDZJe1XU9pL?=
 =?us-ascii?Q?p7IDG8G83QOpgS+739Gs6+85aDUCZ8jMTgUXn4Rq9oaBnzHumZR/QKJcFISW?=
 =?us-ascii?Q?zFbEGUJ1rzce05y0zMIv+CAoT4hln9OfIXLvQOaTxrheWLjPjO6ZB98ucFCK?=
 =?us-ascii?Q?I4IAleoVsqU2RxRzUJn+NrHx1BctpFlZT4xz0Xm+Ov+xAkVa7mx0MaxWDWox?=
 =?us-ascii?Q?ZewECfR+iuVAigVeVDBeNGXo1bH2HAZA4vR4bDj2AchkE0pjexcXnRM784fB?=
 =?us-ascii?Q?q6SeSzFgUi+ZlF+PpPOkWdmhhMcwlkwYA9EygPlRokczNc+ag7nBdC7BjS+6?=
 =?us-ascii?Q?2w1ETH0Z2j2KQdrK6rmfPeh47QaF1jeu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+HfPhZtLbZIQL9IlR2q/3tkewFD2KVWaCGbH56+mfqGkNmoca0pHryzVBiE4?=
 =?us-ascii?Q?CI9zxFV41crQ2s9uK6/7sM0QWpAmJvxOeFZc4G5BOPfl3tqV7ZZ2/E5jpfkG?=
 =?us-ascii?Q?+GDzDAP2dbPoBHYDL/N0UbBi7cJjdJoSeAu7TcDbi1GD+9PPQwLLTC/EzqM3?=
 =?us-ascii?Q?nyErJQmOuYvpshJd7Zi1E+dJOP5tOV8/9JJ9rk2jwf1XNzWwy5hzYng8H+o0?=
 =?us-ascii?Q?MNV0xbuoB4OayOnS/+S7+AloXixVwDWWiXUA3uzELI/I1D9ZXSux2H7YO5cy?=
 =?us-ascii?Q?Ec9ulBbHy5jEBilqibAbBLML2y+FoRZdzVlf3rkKtaWhtMMSx3j+yr2V7rIE?=
 =?us-ascii?Q?PpDCV9ytsxsh7RnCo9zKxRFpnfUkcP517x+QPfP2THKrB6he/iAITyhHFwJD?=
 =?us-ascii?Q?iNHYZSPm/1nKeKQ6N49pEbPq9zmIWwd9yVI5bLzQWgIWQCpAyI5j8T2Z9BZH?=
 =?us-ascii?Q?JDIjMMNVjwZyC3e50lIl8vebIzw6pYmbw64YJ1mJudFPI4+aG74narfBrHbw?=
 =?us-ascii?Q?7/a4KOl52TUnXZHEMUnkQamk5zYBZ6i3I4e3oTDXJeVnEt4H0EJOmpulmGaQ?=
 =?us-ascii?Q?xsb3Nav4zFwTt36JhoFyfVZ+AYjFqYF239Us3h03ePJ3TuUcyLX7Gh6qAIca?=
 =?us-ascii?Q?mXH6i+lJx1IdcmCBWShkibzZ0Ai2m1VuWIxwmMDRWdQaJT6JeTQJDGIgmrRO?=
 =?us-ascii?Q?uLeC4FyPjjePe6du8L2H7rtDE7RV+j26g7LnNOG3grUOK6DgMrwIFOc19N8j?=
 =?us-ascii?Q?rNPKMBl4mJh8XRRGbjz+X0ik26IPhirR8ainOr2FWfZ94gpwEY4XjwDF3VNf?=
 =?us-ascii?Q?wpKRe1ppAsRzZXX42KQ0BWOcHFULkmRmOLbQCuXyQeAVlSlKaluXHH942L/T?=
 =?us-ascii?Q?niuZtBZCCgVat4lAb6t5vkne4steLKd16877jmTO4lyRyog0X/qZ7SlqS8wy?=
 =?us-ascii?Q?Zvehgy3IQ4jOrUxqLjwwKYXqutH4KaWkm3FaR04qqINxd0NAD4mMP8wYxqU4?=
 =?us-ascii?Q?OpiSayfeLTtpclgs7y3nvPOhQ+Rf/JABYFjQHR/b8XiHr1WeJG4sZatVshij?=
 =?us-ascii?Q?5Ti4euiR8a9qDFrZ4WVBm36Dms23QjCnpAkUCaM9hYqWXLb5MFy8bV4QUIio?=
 =?us-ascii?Q?TPdQJIQuawWeMXv1ZTYOQ6mdXlhgTQNglUzODaxazzq9svExgfytIhV6C/f2?=
 =?us-ascii?Q?kiCgeq9MdkeMxtnxBq6FiGkoxF+jTpcaN1XA18DZ7F+7UslFXfqA8LmNFF6+?=
 =?us-ascii?Q?PcgCeFA5aSn2fZ/MkqXca4+dh6fUitcN6wDsJ7HIzAWkaqLEHzYeu/hky4zt?=
 =?us-ascii?Q?qP94q3MglQPd4nJxz0zoUZAd2OEYu5F3B2nGMo2y07kUkq93cd7xf9ITnn+U?=
 =?us-ascii?Q?QOJJHBWrkokRNLp7E6WoJWHf449MBX5CqA/JQvd9qP3pDhE2/JTZCdpKJEBq?=
 =?us-ascii?Q?Q92igICnW9Eu6iGd5loNl19pufGKBFnpBwuD0Guq3PBbwilnr5Qyz3G+iO3H?=
 =?us-ascii?Q?GUEfSPSgXP9VR5qPlRx8/0KiOVlhtPtu/Tu3YlkzwvULXvcdcoSGFuEUzCk3?=
 =?us-ascii?Q?oRZq6ZHU4Y415XTZUhqQm4GWY/nF82X43JxFZjMc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22249c3-a12a-4339-8818-08de235215d4
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:47:39.5236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRARWZWkkKbMCGiXds7bIiuhgOGTDEa1vhIt/gPe+JeBA4ps29G7Hea+MrU9aGq3hUvzun+oWF5o8gonP5TzKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945

On 14.11.25 01:26:27, Robert Richter wrote:
> *** BLURB HERE ***

Just noticed the broken coverletter. Hit sent before save. :/

Sending v4.

-Robert

> 
> Robert Richter (3):
>   cxl: Simplify cxl_rd_ops allocation and handling
>   cxl/acpi: Group xor arithmetric setup code in a single block
>   cxl/region: Remove local variable @inc in cxl_port_setup_targets()
> 
>  drivers/cxl/acpi.c        | 15 ++++-----------
>  drivers/cxl/core/port.c   |  1 -
>  drivers/cxl/core/region.c | 25 +++++++------------------
>  drivers/cxl/cxl.h         |  2 +-
>  4 files changed, 12 insertions(+), 31 deletions(-)
> 
> -- 
> 2.47.3
> 
