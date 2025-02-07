Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770CA8479;
	Fri,  7 Feb 2025 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738950521; cv=fail; b=XOWukIHULnz1GRZxRqtidbtzUDU65yfds2+h8qdMFxHEst7yARyrUKWm81tZPA7YeQWdf2cZK8hLwXN7xw140wJ2PXLi/dJIHt+kczqfp8sF4aCUsZaN27WDo3HsalP1GV0mAJcO3I8a8GQzL+t2yxzaXhqO0ivUhMModDETx28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738950521; c=relaxed/simple;
	bh=3+8lSagud8DqwH0V7xLpTzvrPNxSHE20jFOBsdclSd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=csG6k8vlEKUyUzgcE0g647axzEBDixGu0AYnBNg5AgkqaKQi0UGzWNVYOjBoUUrXfnMgnTSeujQE/CaVJaZowDeGna3c5ba3Cm7q/REFl4O4uPts9HdpvHJrfmrU1h1qj13ydqBqrKC3H9zSSQNvj5mIjCJqFOFLfDJdx6+sXuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g8xShaFw; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g8xShaFw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEtooPGQh2th5qvjHqSj8zovleL6otUfxRIPAd0K+VUtfB1rm3F3nsMYUO4mvNo0WQkq6kbqX+2BrlSsBGhG9Zd6SiMMxO1M4RgTV6cdU9bSeirvAA2vW2lzhj5ZUfVVcLNl4eLxEfUoDhzuX5VOG/tXz+Kt1ZOrGTsQaetO7tAFlX2hpYokz9v3TVZhgdOQt896c5JJooKQ7nst6cVp1WqBQKgaUA1UbxiLCXJNpQUThGx8YhYKveSdx7IRIrxefJBGO0clQdpYgPcMuxdENvgSoMyd+SrrvomzEUFqNpiA7tembngc+lehq34+K41My7z3cpxvUdqM9NDbJBuNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0lpQocrNV25VPUaazYzOfJqONrenmWxJMsHM5XOrYw=;
 b=yJ74M7vyFqzaflpzMjfhQSMmtWzlg0HZyJ935H2O0B73zGDxVkk77+vPjCkBXMaHi1PKTgpIX81yq20g5GZ+gP325i73RcMT+53eJHivZjMbGSYY8X74VeBAAE+At/0mlvHmGmJ9iwwCsjVACoN25Bzs6S+1dkq4hQit/XL1wDhP4SfYZal2g91uaPH+kLLo3c8UxOAWh35SkykpBFPUkuNm6wQmLXRb3F1M0wl4cR9ZxVYNUh/LEmrk5Iorz3nDfNGDleCSotF90bAPrtDQ9M/GynM2wYE9XjnPA2sHIgddR23ayxY8SZzSHpEb8vBYeYXzG298J1TTsLfpMiXuqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0lpQocrNV25VPUaazYzOfJqONrenmWxJMsHM5XOrYw=;
 b=g8xShaFwnFuIeREag21hKVSaE2VynF+G3q2hV7jvFiNw+cjVsvRUrXzgmsCpB4MjT2f708tL+V1MBZlXBq78OTpVW7dgpc80jx5WM7YO+5F46RtuDcrofNiHU8tdPIdg8Ll15Syq4tmGDOyngYyh9Gp1cKKYem59G8rTy0W84R8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 17:48:36 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 17:48:36 +0000
Date: Fri, 7 Feb 2025 18:48:30 +0100
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 18/18] cxl/acpi: Unify CFMWS memory log messages with
 SRAT messages
Message-ID: <Z6ZHbmkCGRGRJC_U@rric.localdomain>
References: <20250207153753.418849-1-rrichter@amd.com>
 <20250207153753.418849-19-rrichter@amd.com>
 <Z6Y1NloQyDCal8EP@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6Y1NloQyDCal8EP@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR0P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 3958299c-62af-419a-2066-08dd479fa595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?du3Kn3Faq682lsmHwk6GTs6f0eHgaGWcqigz+gS1gpf6ihXMsWxg3gBkygmT?=
 =?us-ascii?Q?6NqJuOaUNx8erbqTGNml8THfzt3aolPxg2okV/N2ay4BqHqidNRwQ3KTn4+2?=
 =?us-ascii?Q?p/Ew1fhcsPL+oIuvVHrv6yMsqy6EDgQZDMne7IOvGg8lwg4pdMsnOgEcU12/?=
 =?us-ascii?Q?W1jZnjiS0Ili6b5kWBPfOkctyeH1EaYxC8pT3F2pVOnSle/NLHt/sjc48BiD?=
 =?us-ascii?Q?J/UZyocg5P6Otlcwfel6QNmiTtxBCnnewXsnl56b2qtaoYYZoADteG+EjaNz?=
 =?us-ascii?Q?vTchypgUuhA1qUKA1c8RtS4Zt5kG3picX0RgCHzelVox3LuZBVUqdQ4et+f9?=
 =?us-ascii?Q?EGxY5nDtP+bPsoYCDwkXo34x3v9QV2hpW9gz/4qQjUNW9SBajlx7gbNswrZr?=
 =?us-ascii?Q?NO99FB1zemxU5xgw5C+QGcrarmaa6GRv/YxcgaYilg7bVsc0lLTBxzanHAu+?=
 =?us-ascii?Q?DrvgSI0NzdJkdxFyNzWgrQYDLm8cEZCXfLXHJIHgg80RS8y0lz53j4qEoAHG?=
 =?us-ascii?Q?t88Lqg3/smkGFXAgfTTg+4cM7dbm3J495SBhhpZ19HE6NXjUHvTMKX1TpJxd?=
 =?us-ascii?Q?lnhUH0G1Hqh9OwjcSuZ3jO8HL/ZjiDcYCo4t1xYnIT3uitdPuR2O3wuHz2zQ?=
 =?us-ascii?Q?xlc/4Fh/OFizTzcl8dVLLT0jpbikXZs99V3mmPNRISSqWpi8plSJsb7D2/QH?=
 =?us-ascii?Q?zokCu79St4N9+bvW3m25YPgejYqVqiid/dNFsHodjU46YTgzrllMoquj28p3?=
 =?us-ascii?Q?oAKRct738v3FbiNN7hVWr85x84qksDCmRa0p9gECu+qrFvzqUcXgLLfQbNZR?=
 =?us-ascii?Q?+aIcsT3ygg+OaY4TNOfG9qj3eDiKnj4C4BVGdWVjfkmrs9A9VygT5vTIJryZ?=
 =?us-ascii?Q?Dotrd/YLCIOdtRiJaK2mojlMPSDdxdgWe0SlgKVF2H5IKY2G+SqGR1yjm5Z4?=
 =?us-ascii?Q?KH0pe2tetNeh67/tIZzHBV/GRv5/DrE6Da5XGFG3utF7/syhVdGyt/KsFjjB?=
 =?us-ascii?Q?Jmslv6Ck5pdlRNTMTKVbpFet2FNFIMLe3WlPbPQBsk7QtwMEcLjjb72lhVwY?=
 =?us-ascii?Q?+nscm2hy6X8NnJ1TgfvXNX0XbzryxjAd6myUSXca9K0BV/13Hc24My7dIHmA?=
 =?us-ascii?Q?HQIWuyc6vIVDZsNI3nk+mYsjSyU3J1g8eiUXMaa4fBmQqSDzeKECyXbFwCtM?=
 =?us-ascii?Q?psnmWm2sYVeB8AI/hJuL7bq2N4CgM9oFJtNI0wA2TW4NMXRmGlq+2/XccyQY?=
 =?us-ascii?Q?vSAiviyCMzF0g3S4zue9FfK7GO+MJXXSYosdvTe38I3R6xBlqBWDWYRv0HAB?=
 =?us-ascii?Q?MpaAy0A0LA32RQ25g9m07hv0ykE+PkWSHtVDH+bSvbf2NuPMNxikwNVEL/ur?=
 =?us-ascii?Q?J59kT/JGxYAFfiAsw95F8KZ6h6wk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K/OWj8sW9jLNhzlLHm0w1J0XNBSgcpt7HP8mZisS7BkXqsMIFkKxbzMSO7M7?=
 =?us-ascii?Q?uP5hgguIreLeIdUvI6RcNZgb4llIb/OAD/0Y4bmu2Okftp9zASERlzNwa1U6?=
 =?us-ascii?Q?BULBAD6MmLQl4zeSttyew3cW90LHcEjJ34NFYk6vfTDCr0B4YEVvA0YcaL03?=
 =?us-ascii?Q?T/A1zFzVM7rmycJpU0OexdlXlrYNDInLTp24sowj9v2Scd1IOr5xx5uBWW0U?=
 =?us-ascii?Q?qRT8lWvUXzB8CxOIRF4q6sbje0SPbvrTfwP1ZYytVEY5XJWIQA3CZEynbh/V?=
 =?us-ascii?Q?5BrenTGNEZz4x+Lk6NGjZqKL7no+q2MkXh+M29SFw24HuQhAKn6WGirpq/mR?=
 =?us-ascii?Q?HxgyqZ+ht6uGbDLQ7zacWHwiwczZJnHzf0oSgtXkX9VsbmJvnmLCXlB5c0xi?=
 =?us-ascii?Q?rf9wlZ8qHGVHqNlCqB168V8cLmxc9sA3V/KGGede7gQf49RnopRg7ESc+uHv?=
 =?us-ascii?Q?APS5x9tflp5LI3m3BAnV7+MV5rR29CCe0ktof8LLthUOcFHL1OsgyWR6h4dy?=
 =?us-ascii?Q?CfuBcIMI+K9EfrQEbWRcvPMe41bek5CCLDZb3hKqGmZj9lLuGzvpqrhXdN/Q?=
 =?us-ascii?Q?uRhdVMeCQjXcBFg+J8g0ajw/3NH9V0J2Ka1xN5Y8K2qitKoRoIfZabk1rYTQ?=
 =?us-ascii?Q?l2XwdNmXRABen+RynkTghNxlLikzar6qU+K4lHEaWAjIeJ8ZSS3QlQqykoDi?=
 =?us-ascii?Q?0IO30lByxqybFp0Jigxo3BVOWcOT432uHpNPW/HoRQWLBaWWVFT40OJ5KBUH?=
 =?us-ascii?Q?PssqKCb6Y64nVlN05QyyG2QU1+ZM7HEtrrKERJ9dsVEn/Pf2wajLmMY3hTA1?=
 =?us-ascii?Q?IL8/Zy1c9R3g8q88kHdvuOqQeyOO+7SchaXlQ7LmyoAVxL0/VThtFb7EnCLI?=
 =?us-ascii?Q?utqilAaaGGyhLiLgr84jdnOuug6fzKlzYLBJFko3PjBN9/uVz2dQOvfTqMB/?=
 =?us-ascii?Q?UIqn5GGMxPuv1BSvHFZAh8k5f9oFepAF0yexI3+YNPrxbLsIJynuMfv1aHSA?=
 =?us-ascii?Q?GJHhrBmOS4xhyjxT+GuT4EjZE/T9jJxNV/wnD8dwANAnHyUgFuFGzCe0NA/e?=
 =?us-ascii?Q?aB6hph94ml4EIIEng8HDetPxCFFwXRlt0bpGJhK2mrlrs1rHT/n1j+9vExch?=
 =?us-ascii?Q?8fnWcel3K/1PCdxl2fRJrlKnW35SVkBUaNTLJ1elTKC83eKTjPUUKUwXir9p?=
 =?us-ascii?Q?pNMHJ5WtloKeGjbPG+fQWqNyNLLNse5ho5+gCQBeEMWu1X1/GXhkv3IESvic?=
 =?us-ascii?Q?rV3JoxtBQYlx9ED4Sc8Bv+VB9m1M5MOPCtMpOt32LytP3N/yG3xQaseNnKYf?=
 =?us-ascii?Q?tBL4SXX4ah+raheAUf5oERolshJPSoQgA2Hf18feri8HLm8ugUsLRuvlxbei?=
 =?us-ascii?Q?VUMBc7GwRz5BztPd7vof4PVs/6AjYJhG4M1g1BLR808ZaByX5UUo1ZPxfPU1?=
 =?us-ascii?Q?Ob9udkbHl4ZPg6TWnL8YgH2dYl7FVPjWO11xoZhOd85ftwio1C2oLoYoQdXJ?=
 =?us-ascii?Q?9MR37z2Z1OIszXPdRXCjXhj4oJWWtGjV71TGLt3XIQUBj5cfliCgh9yHNJAq?=
 =?us-ascii?Q?qMJd7c7SEzRu+jQOq0nvQkRH2uFfYcIhXB4IA2Dn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3958299c-62af-419a-2066-08dd479fa595
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 17:48:36.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gf7Jk0QWWX/eR88qwlhdCEh9GGl/c+l5hazKFYl4JawAAwl4b+XYsd7pe3ZS3Os0WQ9rtWQ4/4FkTCcF8PO/bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705

On 07.02.25 11:30:46, Gregory Price wrote:
> On Fri, Feb 07, 2025 at 04:37:53PM +0100, Robert Richter wrote:
> > CFMWS entries have a similar importance as SRAT table entries to
> > describe memory regions. For CXL error analysis and memory debugging
> > information of both is needed. Unify output of both messages to
> > improve logging. Change the style of CFMWS message according to SRAT
> > output. Also, turn messages into a dev_info() same as for SRAT.
> > 
> > SRAT pr_info() for reference:
> > 
> > drivers/acpi/numa/srat.c:
> >   pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s%s\n",
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>

Thanks for all your reviews.

-Robert
