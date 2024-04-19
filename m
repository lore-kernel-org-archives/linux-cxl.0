Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2134.outbound.protection.outlook.com [40.107.100.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8011E502
	for <linux-cxl@vger.kernel.org>; Fri, 19 Apr 2024 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550823; cv=fail; b=fTo9N4CiZQfjg1Ca1iGr7+bJ/PjkwEoMjn0mllpLFvgWKRTkZhJ8rDbiKP/U0U4M7hc9ftxezC76dz8J4zRq7u7DDfXUeZbPUKIgbtrCC8vJFGTihhTk5T4cywn0cb25PxDJSmGucNRn08i56Axkge8FkRSwLqPy389QoCi6H5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550823; c=relaxed/simple;
	bh=JtFQqu2mwSWm4UfyzVn7aSXGheeZL3/8iL2pF1Laz5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kaPqLjWDjQR2qwfpHNDb+NJom4ryeborLwQCz3j6xW9O4/AuQUq8KseYXvykINH6SCTVgm7uFnmO8H1+qGThu/S4lyL+/NyZCZ261cwv1Qe6teosd9LE2WwW9b+VyoZzMZZN794kMZI7JOZcX9+CPWJ/Y8XyNEFAwQhh1MmaND0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=UauoCir0; arc=fail smtp.client-ip=40.107.100.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="UauoCir0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6E2QezGOpvUjlfgOPAfMOMnc3AH9U1gfuwutVBGViMcUJVBKjzE+J54225V2gO2Ue1Q+N+vEvmHBtgTz4ROYgcVCADCxNmsL8yA7pVCMUCwGjE/GDwdhmCmUXxtTlOPYnOZK+VfvnIUY+vrNEkPy4Joq7+G3ITE2AnLly3WH9g+aFfcFp/KfgJM1Aunj/C0tWAkOrfqbYW5W6jd6zvCnEFKjoQqyvMD6jp7Rz3Rzf+ErRra92t7/B2K8xRF3y3e5p5VRhqcab0sPeeG5buvAnPPIvGXKeo0j3WqBpxWLzSBnYtXhg798haRHGpCYsa1qVMYWC9dJe+Zp68hPzQeeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNUbVNZ89yvRJuY4igJTchbqwHKeFWAomGkTOW/jPVE=;
 b=VU0AkqJJWAf4/cn64WJ+5m8eo1XeZmt0SZqYjx2/GvWTqyejbhZ6+Zfj5pm3zy97SHvCjlV0wGfsdZ/wyJvwS4S+pbrp4R4/S8RX7l5i1OcWKh+GpkQy8J0ET69fymDU7SmpC7gQEZZ6VUHRSXgi/gMC+qPZ4rVEVTYafWoazf+NQqF2nX0ZL9qPzQ1DDflicFUYoXlHFzOLGY1mJHFZ6w4yplapzJw3J9DTfP5sDcD780Er/FH2qEoHa83mXMJ77WlIlQAMbzH2KFhKjm6Yi5dndTpr2ahV4DIRoctg7E5UAG1Tz/Eb3EribLLI3GwHcPZI+7ZGGAjxTUkHc11Hrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNUbVNZ89yvRJuY4igJTchbqwHKeFWAomGkTOW/jPVE=;
 b=UauoCir0xmbJhH2CMnH2ovif+drR7dlPWv/bnIapybWK/vJ+Vdnu+Fv3BKikSX8+0zk3ExgG8SmyNfzTpQGwvlt6Cfhro9A+lhEiEIj5/3/BamEb4whJsJrvwoGnY1dkczcFLO4SUtGw1SbN7niyMnYuQBQxnnjgOX3iM9FVZsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA1PR17MB5569.namprd17.prod.outlook.com (2603:10b6:806:1c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 18:20:19 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 18:20:19 +0000
Date: Fri, 19 Apr 2024 14:20:15 -0400
From: Gregory Price <gregory.price@memverge.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 11/12] hw/cxl/cxl-mailbox-utils: Add superset extent
 release mailbox support
Message-ID: <ZiK136P4/tNU2AZZ@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-12-fan.ni@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418232902.583744-12-fan.ni@samsung.com>
X-ClientProxiedBy: PH1PEPF00013304.namprd07.prod.outlook.com
 (2603:10b6:518:1::16) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA1PR17MB5569:EE_
X-MS-Office365-Filtering-Correlation-Id: e533d1bc-bbde-4030-3786-08dc609d5e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kMR5pboNNzFRmrX/s7KgHpua5caBkCyH0zMmT2jZtz066NEsSfMDkZKu2UEj?=
 =?us-ascii?Q?hhzdH30GCkwx8ufrinh7XMGHIgu+MMpQi6nLrgcjYOs9jwKkMPCB+t8Orj2x?=
 =?us-ascii?Q?k/en9y4BHolpVNPA0u1IIIGBUQsTtaC8O0VDhlp1WuXtoCrmPt1iWila7nL1?=
 =?us-ascii?Q?W1tLc3saMhonfVCC3Nq30weatXGGXiBxupgehtDqDY5cXc5DBMk7hUOgyNJW?=
 =?us-ascii?Q?CNpwVP1mFVPgy7/X03juFDEjxeZY+roQldY0SpQDwKDeWbUPESeMhtqn0gT/?=
 =?us-ascii?Q?5qBXYtAnjwYPBUMDmKLwjPtI74hCqoyGG04BgCcTaO+jm0u3U0yy8T4U/U5a?=
 =?us-ascii?Q?USYczkGne0QI/DDVHdRz0Ek6RQQduGEEj16lINfNS3y4Q9auaNBKxmBj/iPu?=
 =?us-ascii?Q?kP5/w2Te/LxgJcOomWXe7pnmbLNpwOOCdg/dz5VjN6xq85AXVihjQTWfDEwZ?=
 =?us-ascii?Q?Hp8gI7i91xTEzz7kCqwawcFbH8oBCWWYR8CARWjUYjgZYRq1/Br4SXuGJ1vX?=
 =?us-ascii?Q?JP09qwbQsksogZVxnQVMpfqvoAbh7Vf/yAEXIDFXX713w8NobRIGZZ0na6Ix?=
 =?us-ascii?Q?LqEfKWdRP/gLwyC/V3hsvmAtReZdR/F9i3OGBgD7OIqyWebM6SnALuA1z+Fp?=
 =?us-ascii?Q?zW5tIQ5bOT6ZLXpvZ9Iz6bp+Ukz8YLqV5OKf3UiW5o45KSE+L5RCRv+DaPgQ?=
 =?us-ascii?Q?kjbTLurksxs8HzFnp0CpJU8jVmpWPIUx52TImzzYgF/dgabuyDhGNGVWQKnJ?=
 =?us-ascii?Q?EZE5Bv9AyzNTCrOzPMOkU/aeKrOe61EbOwrbGAvCDEkFTWEsnBWs0V/+2+I7?=
 =?us-ascii?Q?OF1HusZx5bDhxgKsHSnZXJCJ7Xd/w+DqYg2AZ8Ta3KwoG+O8KVaG6J/4qarI?=
 =?us-ascii?Q?5O4X7p+7wZMYIrWo2SKQYocpu05Es4CtxZmDLpKS5YSKB/Gldz3w6x+RaQgY?=
 =?us-ascii?Q?vafz0V/W8GkwD7ELzvfDFEN3u78sb7gyp5kyXD8RW/AR97S6mHs3ZUkhRoQF?=
 =?us-ascii?Q?lfVzt3Gkl24C0j+8T5buGE8g/O2+Och12RCQW8Y5owucS1ajT32EoU1edWqd?=
 =?us-ascii?Q?8AonWm6AsYuMgrv5IFpbvN404cS1vnvdyQ48z0QZPt4GGiuwhkzKIQv0HFw9?=
 =?us-ascii?Q?KXk5o18YY2uIc1sl6eimi06rwPNepp+ICyxoezJFLdSkZDntpWNhhxl/idvX?=
 =?us-ascii?Q?6Ws4z3ChdnLv4Sz2iQEWum1vXygvD4QGBdrdkVGgl/G5p0G0wzeYO4QQRZVH?=
 =?us-ascii?Q?rjzmsk2qozUsqCxgc2dlCmsc7EOOsVBzLLkafGmcSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sKR1kTXQB0jfJDLItDwHKEiRRz4szjl6YgK74CYWbqISdV+ZOeGIaXJQQ/ZB?=
 =?us-ascii?Q?rg/pGIj2OI46x0sJPT4+Xsw9Wtn2wOIeZIfhrcSk48lmuXpNCp75POQKRE34?=
 =?us-ascii?Q?T1fduEQgrK1Ir2UcZiZvA8cpRwj+bL9oVmeynPM1HR8+WRKXeUo7Urw/ODLn?=
 =?us-ascii?Q?frgJd+6N6AbuVgPOj0UGVt55v+urj/h/Mh//MSSPzsIj/vsmOR1XXE/R+toJ?=
 =?us-ascii?Q?NH891wzrhK4dpHnCo6lG0ZQx78o8+uLbb6Qntc1/+S6UxLDFdZ74gbZBkAtX?=
 =?us-ascii?Q?2Njl2sjAmFCCRr9qMRvY3GqvgQF9ImaREycb/PR6wfoGIL9ot9rLv+C+WS5a?=
 =?us-ascii?Q?g3EuSVGtEJg4H4UvwhkSq3degj8AW+46Zj+QREKwixoHM5QkeJ5K/W/seM3/?=
 =?us-ascii?Q?C6oPHVPUmZWdXHEDH+dwLvoCVUcoS8WheHhhSwBNfZe3v4TquimtRkarpP14?=
 =?us-ascii?Q?0tBNXpsZZUe2RFUXbp/g6lMtuUYZ7aHULgtNlKwW2dz6wB7QptqmwlzmXAqq?=
 =?us-ascii?Q?RUGZ/FqFOELks9TkwUFbG81ylZJzykHvXWjxOs9ZjUWTO6oO+doxjnHf+e7g?=
 =?us-ascii?Q?I5H5qMPai+Hpl4ZmZwvPMvByrM2ImAoxCCzhiekUZX+YuY3dAdEerrBoZ7ya?=
 =?us-ascii?Q?1mgOPjP2Cpzb8D1xNwKa09yDOgJAXqlvy2+AxqBs0QsG7CiBPMl4t4YLQkE3?=
 =?us-ascii?Q?xC3QaHK1ZpwWT+7g50/p1BdHMtURy0+ZHHvbQRD1ndkkNy4YbSGJ2KbYeVqh?=
 =?us-ascii?Q?kLPdC0UNOmsON5inFgL/WR2IAuJ+sbglriDzpPeAnEDyiUzgqhWjJGmpkR1o?=
 =?us-ascii?Q?EmOMnbsGmcGkdNxtBwbQTdnnsxNj3mXT0P2jdyNAFqPgDc6lsQ28hwXGEl4b?=
 =?us-ascii?Q?LzgUxZ93lY53/mbvkdWNqUrLF2rWd7q/792xMSfdRuFeR/MwMiDG2gbw3Eny?=
 =?us-ascii?Q?wmK9cWp0Oxvz9bKPqINEvk9jcKzGWJgt1ePX1iB2aiqcGiUcPIkEMWZcpp4k?=
 =?us-ascii?Q?SVcwjrVdPvjfiTiIt5ZP3h8b5Daoj8yauhB/YH1cLL+eRBapNhw2QXWwZg0Y?=
 =?us-ascii?Q?xgOlibfCHnWuOXUhgiKT+n8qjl41AN3kpshtcclFwlI8Eo/ZGNnfzTbhwJtC?=
 =?us-ascii?Q?7mylcWNhApmLvBInidRq6a/tK9gdKrjtUprMGMUVtIRRaA52pkJeISRu1ukl?=
 =?us-ascii?Q?DZLcJ/2AvaTwzFg5WVybfxuMpAa/KyA4LUgi8NpaCiLENn2Jd1ZdjyH6nBK4?=
 =?us-ascii?Q?5QGXxNOiAG4b1Lt/0Z8+GzN5O3dePivgHyi59mOHdH3sV8XsQhw7ARr+ftW8?=
 =?us-ascii?Q?acZ9B1bJEL+3v2MHfDDFiJPl1oCr/4NvRDrURKqWxANSH6F8lvjfE2wZUCgJ?=
 =?us-ascii?Q?XWzQX11e6UNC7sCvWFRXDx6b0AdJYHOfYQ5a8cLrN5b8QGJzZ9A74PdIHXmj?=
 =?us-ascii?Q?ThejQ7MpdoB1t3HJmKqchIbpYfyKA1uMbBbDxCfNl/vsWtAHj2W4yt9m/PZg?=
 =?us-ascii?Q?4hT7yr5YCRk8dhnQBHLGAlWtQtQcr8dVjbUyKKnn876+jIyY0Vrn/Gb9rl5R?=
 =?us-ascii?Q?jAHphpkrhCjAdE78CAVboyhZ+v3F1lrcKr4aFrxWoC+gml0oXDvIKqMNQjS3?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e533d1bc-bbde-4030-3786-08dc609d5e83
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 18:20:19.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdxhWH1FrX4EanOA+9dOWSAqDtp0MIqwSRKxCpQFvzzDTg5CsNuJ7Pc8uzC6KDuZ3vBXNQAumGbocYVX7DHZb3Ws4jK9XHjja3BBE0phDhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB5569

On Thu, Apr 18, 2024 at 04:11:02PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> With the change, we extend the extent release mailbox command processing
> to allow more flexible release. As long as the DPA range of the extent to
> release is covered by accepted extent(s) in the device, the release can be
> performed.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>

Hmmm.  This will complicate MHD accounting, but it looks ok to me as-is.

Reviewed-by: Gregory Price <gregory.price@memverge.com>

> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 57f1ce9cce..89f0ab8116 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1704,6 +1704,13 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
>          dpa = in->updated_entries[i].start_dpa;
>          len = in->updated_entries[i].len;
>  
> +        /* Check if the DPA range is not fully backed with valid extents */
> +        if (!ct3_test_region_block_backed(ct3d, dpa, len)) {
> +            ret = CXL_MBOX_INVALID_PA;
> +            goto free_and_exit;
> +        }
> +
> +        /* After this point, extent overflow is the only error can happen */
>          while (len > 0) {
>              QTAILQ_FOREACH(ent, updated_list, node) {
>                  range_init_nofail(&range, ent->start_dpa, ent->len);
> @@ -1718,14 +1725,7 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
>                      if (range_contains(&range, dpa + len - 1)) {
>                          len2 = ent_start_dpa + ent_len - dpa - len;
>                      } else {
> -                        /*
> -                         * TODO: we reject the attempt to remove an extent
> -                         * that overlaps with multiple extents in the device
> -                         * for now. We will allow it once superset release
> -                         * support is added.
> -                         */
> -                        ret = CXL_MBOX_INVALID_PA;
> -                        goto free_and_exit;
> +                        dpa = ent_start_dpa + ent_len;
>                      }
>                      len_done = ent_len - len1 - len2;
>  
> @@ -1752,14 +1752,9 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
>                      }
>  
>                      len -= len_done;
> -                    /* len == 0 here until superset release is added */
>                      break;
>                  }
>              }
> -            if (len) {
> -                ret = CXL_MBOX_INVALID_PA;
> -                goto free_and_exit;
> -            }
>          }
>      }
>  free_and_exit:
> -- 
> 2.43.0
> 
