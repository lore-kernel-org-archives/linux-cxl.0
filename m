Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B71D516C;
	Mon, 16 Dec 2024 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734384624; cv=fail; b=KclKzrJ2czLLHJ2SJ3AhuInHbn81s3izNFk1jlYXMR73tV41lhKz0vZvj3RtKVGzvoBnLwSqYgP0B8nVEzis0PhmBon6Mh4p+7vw9D/R7lt5Q9IUkeGuO3pE1tjlqU2bgss3HLtNwK/K5CS+NDyFHa2/tzEQEm8tEt7/zKyuQK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734384624; c=relaxed/simple;
	bh=4uWGbREiRoPb8dLpCRI6xEq1mDanrtUlFReSZPg9sk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ch6d8OYm60oXrY2I/7KeLxY+ZgjGMMTYC3fyhHqMv5qcZEQ/jAmvXcVahzbNrfCs2q7++XZiK9ZDfX2Q4E52hyFfXlzSiBsMw2BAw3QAZ/ZhgPPch2QpmHKVza6oE7B3XuE3sSBhikkmXU0O9/BAlIu1MkgxwsHK/MxPHAjkNeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uKA52j3f; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uKA52j3f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KC0E4oJz2cqzhuuTy4poz7A+/ShP5ry+ni9Mj27Iraghoy4WTMtW+bsSN4BdpiLqdiKzBHStzuHYeIDQMnhO6FvAy9z8g1LvTIlrtBLnWzSWF7o3H0V/N/c1DgHnmJK0XCCKSR7jfzEmUYQCxx4S4ohhcNVvwnKrNIX1oe15gQs405JY4Aoax1X9TALC5n7+NnF0xtrP1jUNOZgJARWPVaoL7wPV11N6zhnA/Wm+wzOxJjzTx5p/T89ama9zWa+rnw2rcrUetGwzVk1995Fz8ccsqxraIAXTZdDMDMMBkdl4m/1iUgaB8RTp1QN+g+Skn/YinXX3q0AuAwM2Belu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXVY2IEdTeq0amMzhCXniZYsQRx6UiUbJZS1cTT1j+o=;
 b=cw+14RS2V3y6Vxd9BcSiI7aMJzCd9XqIaNs3NUhh3rVlODQj4D0mcSuGMiyrIMITagkhWXno7dAx5AE4m5PftE4zVwV3IVmH9LCOwku7WexsFte3aTTJhV0og33L+OXGWwwWMH/1YBTiGL3tw+R9jUcd253aXjGsW13dG6jSi+C2pv7g+yY0+YT+CD20+ykr0z/WlaGWyTI0aAKiCxNXagFzhptkC+SGdRdxnajWfX7uhrW2DxY+/rxJKDjY3GqwPj4YIGW8oxtGU3mGswpH9NbB0NOvPpNvIIdu7+gA5vvqCNAqaO6mtskHdOoYAEHDBxFOxAoxa1hprUAa16hmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXVY2IEdTeq0amMzhCXniZYsQRx6UiUbJZS1cTT1j+o=;
 b=uKA52j3fR2bPP8pDqtIAhAXhUD4kzlrU1n1u2TWjlqhCAQvLzQeY9BvkrtE4lUzTbeWkgH3VBW/Vvbxb2OL04SV36ppTnI6bl6Nyt+ayuWKEjXlm13PmIvyu+fIbuFjd5/bHP5VAu6q0G7BhQXyss9ety5uKRq87FKmMPh8ZdUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 21:30:18 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 21:30:18 +0000
Date: Mon, 16 Dec 2024 22:30:11 +0100
From: Robert Richter <rrichter@amd.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Li Ming <ming4.li@intel.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] cxl/core: Enable Region creation on x86 with Low
 Memory Hole
Message-ID: <Z2Cb4wZRk3bihXfr@rric.localdomain>
References: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
 <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: FR0P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::12) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c1feb6-6737-4575-722f-08dd1e18d67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xkQgDa9oLLJ3dw8SjgnJZlq/FJMSTs0chUZdHfSvARjwU7X6LHIrwfJXPj4P?=
 =?us-ascii?Q?/SmUKFAXdiMdQDhC+Rf1xYL8vOz28bGi0lGTI7TTz9bqJaYHQFZP1L4XwNsm?=
 =?us-ascii?Q?Gh4fWSQCtuHEf3O2qCnwzy+VezcRDJskmXOy0Mt2xlrHkD7I2xuT1o/Z8CyS?=
 =?us-ascii?Q?iU96Tw56Vr9k0+5BIWmcI7TxjLUMndpRQ4eCWjUcTMRPSl1f0z+GR6P8mF9t?=
 =?us-ascii?Q?qOLSJMmmnko6dTFC6O6vCH+CyQGm1Jg35whjez8gHzkWQo1pxjTLHgNyyCG8?=
 =?us-ascii?Q?6/7Wkv65c7mWDJ2tAJCIy2g1MgT9ULlijazq0K4Q9+8TRwdKHPfR5QHVLCkd?=
 =?us-ascii?Q?5oFbdMz5cJm7Dr4+xO+rmXlbdRUJB3CGTyvX/0SfkKmTDiJ38zggpc63Qbr0?=
 =?us-ascii?Q?NTMiyrUCnYYH7vJjApCS25jQ03FP1AiLRXexzkzh+rTSty8yuDUqoMYZ4Bdp?=
 =?us-ascii?Q?bYyXodZnT2zGdGKOwAirs9VYc2+HXN/ujymmuJN8RdknWWVLUbC04mZ3WKiD?=
 =?us-ascii?Q?Y2YQNpKa/Ul2aSX8uwBFcT+MkDvFQebKPl0WtN3Orb6+zfR2Qr7k3+45o714?=
 =?us-ascii?Q?0vCRkB9hnWJdvxdSvaf07mqE/gJbtix18+wYmt2Gh8SOm03kafXo+pGcvIWp?=
 =?us-ascii?Q?Q+BdzdsIF1M/7pQ1OQGerOulHDQ3TFDng412avQ9ZEWuqaOnEOb7dEk+RqC/?=
 =?us-ascii?Q?Zo98sWWU+AIp7JxtoUignEhmPPc3PChGDJ4jaWSvyi3RjD7eth+i4JFWLUZQ?=
 =?us-ascii?Q?LfITz0WDORU8u70VHZSWHJKN+YmqY6SKmLnqmHtf+KyfN4+ZQlzjzx+49bcw?=
 =?us-ascii?Q?GocBSDnh0IRRQrxsjLGiTI/OrySb0E4fv+EIADLIdgWa8NOGHCckuvoSqbP4?=
 =?us-ascii?Q?bQs7TjijNXw9vVIyxbQI0KeifDljgMQam85tKJadO4cR7gHETIIiKoIDtABH?=
 =?us-ascii?Q?n8CJIQVUM2I9/41MC4OEtylRowF9irMGyDojU0CSYCBzIaFEMPMuPsc5SoRt?=
 =?us-ascii?Q?cUPQBztU+Gc+ivutzFBMCoiqkNWe2EKnErK1csmkYxPzn1z8dXjSQpEmQ0Ds?=
 =?us-ascii?Q?H5i1FJVuTSjHCtCitHH164LAjnLhdhAHcW2i8NMvGjFh365WDyOFpUcrk6mO?=
 =?us-ascii?Q?FWkrUKw1ammfFe4OOGGLDp2CAt/CzOqRx7mBtYNv0uJ3Lm9mna3HwsS5rYsS?=
 =?us-ascii?Q?gPiaKp7A0cLngICbF1m3hu3FhWW8Zt/ozzNCjvPgtKCdSQSRVZb9BXhJkxs6?=
 =?us-ascii?Q?+5aNCaDnGLy99f+4aqszR2d8RkPawDaBn8/ZUdxt7e6wChg8z1WhuORdukF6?=
 =?us-ascii?Q?WTXvuHYHQsXkNlY47XsCVUe7WBSU1vl3EqgmhgocpEhQbNP5Vc5d+/BzMLPk?=
 =?us-ascii?Q?GnvHETLZVtmIYwz8ed1x/2votJ5o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AtoTKemRa+NXzl4H032XJiLEDr6RaMtd5ryWzViUyKEmV7QgcaJIwf/pbixU?=
 =?us-ascii?Q?ThJ45dhwOshAEXEGE8vuyaGxw3jdfECY2gg7cxnPMpXtB+/9DKZsHzb2KXgk?=
 =?us-ascii?Q?/XpzBNZ3SFcwGXcbq1qtoa20XMno1UU+uiikxNmSgavEkFisXKpxeblrHou3?=
 =?us-ascii?Q?WItXwjo3VFXQUFa1nHMDobD+QlzyeuTo+rGvgUj0vKNnxnwOoWWi5OY/Vbcr?=
 =?us-ascii?Q?tLiPOUHXj3MkjGzFG39iUtn8TxN7ZGKmD/7JCcggjX+5mk4dn9xIgMJtY06A?=
 =?us-ascii?Q?Te1FUKDS4GmjeLkVz8OjstSGrDW7rDnpaR/FYmuceLE32hLMbOHVulraZC28?=
 =?us-ascii?Q?jJHl5cetCVprf0VIhifRy1sxcya8CxLm7g28LwSOvKyI4F5YXq9SLQNCCuYZ?=
 =?us-ascii?Q?ebxywFQRQQk/PrBQI+CcQEkh+Tjh+FtB3Vf29Ioa34Fc3PX+3D+Mb40r5oUH?=
 =?us-ascii?Q?csBTsFth8OI7My/m9SgBcem+Ciiyj8gDW5rJa/i7IAv54U4o/S1vLJcSfASM?=
 =?us-ascii?Q?Zfu0UHB7533hitrv/QUYU8JgUKwcFUdrIpWc1KlZYEJ/znh5dLxUHuPin608?=
 =?us-ascii?Q?/FT3A19ScL8djbiHE94fcuVBNfQIY2JhtPQyf0eNSxoJ8mPts/BSrnXExdOu?=
 =?us-ascii?Q?67eaR/mJhT9yvRSqOixCeaGDF3h+5T96yixsqredvxUlgPYl0ODrBr946nE+?=
 =?us-ascii?Q?MO6YzcZUt+7xpftddJNamOISd+02uI8Ga57FBZsH6CRqEqwp482dgstHA/Xg?=
 =?us-ascii?Q?vrMBaEX7UEQ8YaH93D50YLR/rg/kA4SmEGl250C3gU4sVdzDvOAaqPef5zkq?=
 =?us-ascii?Q?7zAxuRUXcTfZZmNpbasaCOUmCLK0pfCs+Vu/JOpyZNj53+8ERR4lfATmmmc0?=
 =?us-ascii?Q?nPgmD6dYK/DS0r5TMUJ3PgpqpliCKmxqyElIhj8i3V3O3WtJiu8Ug0jt6Hhh?=
 =?us-ascii?Q?uWXHpqmMzOAzJ05qzV/ZtqUrmroEKHqScgil+oxxWPQxHeANVkyRUh115NuX?=
 =?us-ascii?Q?k71RewdNaJ8q5/PBKWzEqNS5pVXwWaPLJwY7oHFAT3CpfcpWP2yIim1QT4FL?=
 =?us-ascii?Q?JFLXaLiPWM2tD5tG+eD+Rhn8qFhE0n4na84pEisJHuq2XIKf2LpCFV46iBcm?=
 =?us-ascii?Q?oLDTIQRVqNG+puvYvtaCrodJ5attxMUOhRboI3gbxM+0Yvxi7n5b2Gy5KQeE?=
 =?us-ascii?Q?UUAAPcIpvIjzKJsHk0a8HxRhUEGn3ZV8rLci0NbshnZKIQGuByN4SyHNfWPq?=
 =?us-ascii?Q?pxtkdeeDReVXWOgfLVL/0HqmDxZS3VU2x+y8QWzdcVAbFxn7V7cdTHwqKra/?=
 =?us-ascii?Q?aSqNVfod3vEmCHXf2qBvJOviSDkF0H1/x2sUuF/nN3DB6THLUlKjCDSSquDh?=
 =?us-ascii?Q?qVRM/3ZFZrQrrWVKJIEK1Pdv8cc3ra8bO37viLIzLk99UTAvrT+RwjUf6eV0?=
 =?us-ascii?Q?ih3DXMrEyGJe5xCqeNJHlymnMipbkYIx0yMNnBEzjH1sYsl0PlToMignwKkc?=
 =?us-ascii?Q?dc26OjF8NzxQ5opJ8esgBncZW2bv+FOQN9OwDOBAPL/Yw44PzG3F0rX4ItBq?=
 =?us-ascii?Q?xBSU32iVgZbhB0f9dmy8W/r4VHWuMpF+9s9ZCeg6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c1feb6-6737-4575-722f-08dd1e18d67d
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 21:30:18.8464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j24n8RR1NsnOLu7A3cZlZ5XpQxK1yM54/wyTp58IcMFrdKiwMa3DjJ1CRIy0cLTD4PFotW5Tmsg+b6lnTY352w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933

Hi Fabio,

On 22.11.24 16:51:53, Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> Physical Address (HPA) windows that are associated with each CXL Host
> Bridge. Each window represents a contiguous HPA that may be interleaved
> with one or more targets (CXL v3.1 - 9.18.1.3).
> 
> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> memory to which systems cannot send transactions. In some cases the size
> of that hole is not compatible with the CXL hardware decoder constraint
> that the size is always aligned to 256M * Interleave Ways.
> 
> On those systems, BIOS publishes CFMWS which communicate the active System
> Physical Address (SPA) ranges that map to a subset of the Host Physical
> Address (HPA) ranges. The SPA range trims out the hole, and capacity in
> the endpoint is lost with no SPA to map to CXL HPA in that hole.
> 
> In the early stages of CXL Regions construction and attach on platforms
> with Low Memory Holes, cxl_add_to_region() fails and returns an error
> because it can't find any CXL Window that matches a given CXL Endpoint
> Decoder.
> 
> Detect Low Memory Holes by comparing Root Decoders and Endpoint Decoders
> ranges: both must start at physical address 0 and end below 4 GB, while
> the Root Decoder ranges end at lower addresses than the matching Endpoint
> Decoders which instead must always respect the above-mentioned CXL hardware
> decoders HPA alignment constraint.
> 
> Match misaligned CFMWS and CXL Regions with corresponding CXL Endpoint
> Decoders if driver detects Low Memory Holes.
> 
> Construct CXL Regions with HPA range's end trimmed by matching SPA.
> 
> Allow the attach target process to complete by relaxing Decoder constraints
> which would lead to failures.

I am implementing an address translation series and will post the
patches in a couple of days. It solves a similar problem to remap
(zero-based) endpoint address ranges to a different SPA range. I
implemented a generic approach that can easily be reused here. With
only a few changes to your series it could be integrated there (I
could rebase my code onto your's then in a later version of my
series).

The change I suggest to your series will also significantly simplify
your code and the function interface. The general idea is to have a
.spa_range attribute in struct cxl_endpoint_decoder:

@@ -428,6 +428,7 @@ struct cxl_endpoint_decoder {
        struct cxl_decoder cxld;
        struct cxl_root_decoder *cxlrd;
        struct resource *dpa_res;
+       struct range spa_range;
        resource_size_t skip;
        enum cxl_decoder_mode mode;
        enum cxl_decoder_state state;

Now, then an endpoint is detected, the spa_range is assigned,
typically this is cxled->spa_range = cxled->cxld.hpa_range (SPA ==
HPA). Whenever a port is added, a function cxl_port_platform_setup()
is called which could also contain a call to
cxl_port_setup_intel_lmh() or so.

@@ -865,6 +870,8 @@ static int cxl_port_add(struct cxl_port *port,
                        return rc;
        }
 
+       cxl_port_platform_setup(port);
+
        rc = device_add(dev);
        if (rc)
                return rc;

cxl_port_setup_intel_lmh() does all the platform checks and
recalculates the spa_range for the endpoints based on the code you
already have. The endpoint's SPA address range (instead of hpa_range)
is now used to construct the region by changing
match_region_by_range() accordingly. This avoids the instrumentation
of all the other checks you needed to add in this patch (use of
arch_match_region() and arch_match_spa() etc.).

The only function that needs to be exported is
cxl_port_setup_intel_lmh() then. Everything else is generic code. This
is also a good encapsulation to other archs, vendors, platforms etc. I
think that would really improve your series. Let me know if you have
questions.

See also inline below, I have some questions and comments.

> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/Kconfig       |  5 ++++
>  drivers/cxl/core/Makefile |  1 +
>  drivers/cxl/core/lmh.c    | 53 +++++++++++++++++++++++++++++++++++++

Could you name this file intel.c and have necessary Kconfig options?
If code should be reused later we still can move it to common.c or
similar. It would be good to guard that having a pci_device_id check
to a root port or a vendor cpu check.

See my comment no enablement above.

>  drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++++++++-------
>  drivers/cxl/cxl.h         | 25 ++++++++++++++++++
>  5 files changed, 130 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/cxl/core/lmh.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 876469e23f7a..07b87f217e59 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -128,6 +128,11 @@ config CXL_REGION
>  
>  	  If unsure say 'y'
>  
> +config CXL_ARCH_LOW_MEMORY_HOLE
> +	def_bool y
> +	depends on CXL_REGION
> +	depends on X86
> +
>  config CXL_REGION_INVALIDATION_TEST
>  	bool "CXL: Region Cache Management Bypass (TEST)"
>  	depends on CXL_REGION
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 9259bcc6773c..6e80215e8444 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -15,4 +15,5 @@ cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
> +cxl_core-$(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE) += lmh.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
> new file mode 100644
> index 000000000000..da76b2a534ec
> --- /dev/null
> +++ b/drivers/cxl/core/lmh.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/range.h>
> +#include "cxl.h"
> +
> +/* In x86 with memory hole, misaligned CFMWS range starts at 0x0 */
> +#define MISALIGNED_CFMWS_RANGE_BASE 0x0

Could you more elaborate on this? Why is the base zero?

> +
> +/*
> + * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
> + *
> + * On x86, CFMWS ranges never intersect memory holes while endpoint decoders
> + * HPA range sizes are always guaranteed aligned to NIW * 256MB; therefore,
> + * the given endpoint decoder HPA range size is always expected aligned and
> + * also larger than that of the matching root decoder
> + */
> +bool arch_match_spa(struct cxl_root_decoder *cxlrd,
> +		    struct cxl_endpoint_decoder *cxled)
> +{
> +	struct range *r1, *r2;
> +	int niw;
> +
> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	r2 = &cxled->cxld.hpa_range;
> +	niw = cxled->cxld.interleave_ways;
> +
> +	if (r1->start == MISALIGNED_CFMWS_RANGE_BASE &&
> +	    r1->start == r2->start && r1->end < r2->end &&
> +	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
> +		return true;
> +	return false;
> +}
> +
> +/* Similar to arch_match_spa(), it matches regions and decoders */
> +bool arch_match_region(struct cxl_region_params *p,
> +		       struct cxl_decoder *cxld)
> +{
> +	struct range *r = &cxld->hpa_range;
> +	struct resource *res = p->res;
> +	int niw = cxld->interleave_ways;
> +
> +	if (res->start == MISALIGNED_CFMWS_RANGE_BASE &&
> +	    res->start == r->start && res->end < r->end &&
> +	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> +		return true;

This basically means that the region base is zero? How do you
determine the actual base address of the range then? The cxl test
patch contains a non-zero address. How is BIOS supposed to configure
this trimmed mem hole regions? Could you share a snippet of a CFMWS
entry for this?

Thanks,

-Robert

> +	return false;
> +}
> +
> +void arch_trim_hpa_by_spa(struct resource *res,
> +			  struct cxl_root_decoder *cxlrd)
> +{
> +	res->end = cxlrd->res->end;
> +}
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ac2c486c16e9..3cb5a69e9731 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -836,8 +836,12 @@ static int match_auto_decoder(struct device *dev, void *data)
>  	cxld = to_cxl_decoder(dev);
>  	r = &cxld->hpa_range;
>  
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> -		return 1;
> +	if (p->res) {
> +		if (p->res->start == r->start && p->res->end == r->end)
> +			return 1;
> +		if (arch_match_region(p, cxld))
> +			return 1;
> +	}
>  
>  	return 0;
>  }
> @@ -1414,7 +1418,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		if (cxld->interleave_ways != iw ||
>  		    cxld->interleave_granularity != ig ||
>  		    cxld->hpa_range.start != p->res->start ||
> -		    cxld->hpa_range.end != p->res->end ||
> +		    (cxld->hpa_range.end != p->res->end &&
> +		     !arch_match_region(p, cxld)) ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>  			dev_err(&cxlr->dev,
>  				"%s:%s %s expected iw: %d ig: %d %pr\n",
> @@ -1726,6 +1731,7 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
>  {
>  	struct cxl_endpoint_decoder *cxled = data;
>  	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
>  	struct range *r1, *r2;
>  
>  	if (!is_switch_decoder(dev))
> @@ -1735,8 +1741,13 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
>  	r1 = &cxlsd->cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  
> -	if (is_root_decoder(dev))
> -		return range_contains(r1, r2);
> +	if (is_root_decoder(dev)) {
> +		if (range_contains(r1, r2))
> +			return 1;
> +		cxlrd = to_cxl_root_decoder(dev);
> +		if (arch_match_spa(cxlrd, cxled))
> +			return 1;
> +	}
>  	return (r1->start == r2->start && r1->end == r2->end);
>  }
>  
> @@ -1943,7 +1954,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	}
>  
>  	if (resource_size(cxled->dpa_res) * p->interleave_ways !=
> -	    resource_size(p->res)) {
> +	    resource_size(p->res) && !arch_match_spa(cxlrd, cxled)) {
>  		dev_dbg(&cxlr->dev,
>  			"%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> @@ -3199,7 +3210,13 @@ static int match_root_decoder_by_range(struct device *dev, void *data)
>  	r1 = &cxlrd->cxlsd.cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  
> -	return range_contains(r1, r2);
> +	if (range_contains(r1, r2))
> +		return true;
> +
> +	if (arch_match_spa(cxlrd, cxled))
> +		return true;
> +
> +	return false;
>  }
>  
>  static int match_region_by_range(struct device *dev, void *data)
> @@ -3217,8 +3234,12 @@ static int match_region_by_range(struct device *dev, void *data)
>  	p = &cxlr->params;
>  
>  	down_read(&cxl_region_rwsem);
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> -		rc = 1;
> +	if (p->res) {
> +		if (p->res->start == r->start && p->res->end == r->end)
> +			rc = 1;
> +		if (arch_match_region(p, &cxled->cxld))
> +			rc = 1;
> +	}
>  	up_read(&cxl_region_rwsem);
>  
>  	return rc;
> @@ -3270,6 +3291,22 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
> +
> +	/*
> +	 * Trim the HPA retrieved from hardware to fit the SPA mapped by the
> +	 * platform
> +	 */
> +	if (arch_match_spa(cxlrd, cxled)) {
> +		struct range *range = &cxlrd->cxlsd.cxld.hpa_range;
> +
> +		arch_trim_hpa_by_spa(res, cxlrd);
> +		dev_dbg(cxlmd->dev.parent,
> +			"%s: Trim HPA (%s: %pr) by SPA (%s: %pr)\n",
> +			__func__,
> +			dev_name(&cxlrd->cxlsd.cxld.dev), range,
> +			dev_name(&cxled->cxld.dev), hpa);
> +	}
> +
>  	rc = insert_resource(cxlrd->res, res);
>  	if (rc) {
>  		/*
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5406e3ab3d4a..a5ad4499381e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -902,6 +902,31 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
> +#ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
> +bool arch_match_spa(struct cxl_root_decoder *cxlrd,
> +		    struct cxl_endpoint_decoder *cxled);
> +bool arch_match_region(struct cxl_region_params *p,
> +		       struct cxl_decoder *cxld);
> +void arch_trim_hpa_by_spa(struct resource *res,
> +			  struct cxl_root_decoder *cxlrd);
> +#else
> +bool arch_match_spa(struct cxl_root_decoder *cxlrd,
> +		    struct cxl_endpoint_decoder *cxled)
> +{
> +	return false;
> +}
> +
> +bool arch_match_region(struct cxl_region_params *p,
> +		       struct cxl_decoder *cxld)
> +{
> +	return false;
> +}
> +
> +void arch_trim_hpa_by_spa(struct resource *res,
> +			  struct cxl_root_decoder *cxlrd)
> +{ }
> +#endif /* CXL_ARCH_LOW_MEMORY_HOLE */
> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> -- 
> 2.46.2
> 
