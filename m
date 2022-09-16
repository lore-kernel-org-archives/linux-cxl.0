Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ECCECAAD8
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 23:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiIPXgK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Sep 2022 19:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiIPXgJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Sep 2022 19:36:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D8574DD1
        for <linux-cxl@vger.kernel.org>; Fri, 16 Sep 2022 16:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663371367; x=1694907367;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aYwQZ1+U4Y3Bm85vjY3XoQcRGEk7YL/Ga0OcdZRE7KU=;
  b=j3p9CGen67eVeItTk8qCPDOTnjEgpt3gGzTKCED/x3A7LckFtXl8xzLF
   T1WNFQBs4B2GRKyZcX3GQuxKsTkl/EmMACo+f3vqeInZzDvetQG/vSAYW
   oFOUHIdnDXuYEoZBswZv9ADk6qfUuELiVMEKqfIIMF3GrrCFNNRczLSjz
   Gyv/7eE2DJpVH2BUqXw9D1vkp74aiQ/F93TmbyC9P9msoDoDomx7Z+uuj
   CfE2YDgzaQVKd1LtjW3rLNouBKWjJJ9PayrkwzZhYxWRxLZmOi0PLT69O
   zULaUkw96tAnabfSEBexnLyaDfMfkle5gXvctuoXoOjJCnc/oCYEt8kqJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="279483188"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="279483188"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:36:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="862897512"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 16 Sep 2022 16:36:06 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 16:36:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 16:36:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 16:36:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 16:36:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a829uPlkAJ+8LtK80VVpPDf0wVAZH610pqeQdyQPyN4/0TYwT+FvXBiMH+KPZxjB35Hgnt6dzdEXXoE+sVnb7tR12SRT/74CGcxT1/J3jRTudLC5Le7rNqr1uG0n9kK8+1ceVIkraO59syG4lMbaSh0PEwVp/VfJDLeSttvINrPQKUQ5qlM3oOLIbX3riUfbOf16QsHHoQMzUw1RKGSUhFeULbqsBAnOpQ7gKx+1XpP6NLX44UrN1Yx2L3X56AIlsb/qTYAL2WqngikAW8mVpmW/+Lwvz4Y0ujlB1op+FKmyH5+fJhh7UZlVm4TZNRSTVfP1ahzbDjVjfZfWp+qshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2jVoH8xZOeTU5B0mJ1FwOEAHyi2CycexJV24HmoOKs=;
 b=OmGB7f4BR3sijXttMV2mxEIC+8bYn9k1l9EBVX8FQ4ojs6IyMrFwDZBz+tO1Kmf8m3dqMtMeGdG82fNmK5tZPj4Mpd/bdJ7+Hen2EsYwZgNQPLT4XBeXtEsy5RQiLsk57MPFR+Vs8SeOx+joKmlbdaItHRQyXx9L2SGUbqtQpogWxRgiJac4uSP82cPKWkvQfADkeRzmuVeBooen8vNeEqazFBU/+v7+r72LlIGaArYaRTh5syNguqLmn8f9Iuu2EOl6G14QOqRU9ZRX7MpSL01ddcl8Vq2q8jIV9Ykb2IWCbzCyAb6iFRCYAtctMxgH/oqkXxLYEt654AZW1NaxsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH3PR11MB7252.namprd11.prod.outlook.com
 (2603:10b6:610:144::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 23:36:03 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 23:36:02 +0000
Date:   Fri, 16 Sep 2022 16:35:59 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [ACPICA PATCH] Add CXL 3.0 structures (CXIMS & RDPAS) to the
 CEDT table
Message-ID: <6325085fd0b23_2a6ded29441@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220916232102.673102-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220916232102.673102-1-alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::32) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CH3PR11MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a35b0c-3887-46e0-3c68-08da983c37b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvJXFmurWYFP/nZCj4RkE7UrWfaBDyK/c4DLPkSy4zFtvmQogLRUbvtDc4uNpwUoj7/Noa7dcH7YO6B4hyGJ8Ywbxfj8bpKECID5JL2MnyujJpn5kgkYmiG4RFKAV90ItcUW4Bx5A3IQ9z51nwa+y4JvBpCK/qLf6eTGPdt5VoaK9dFUtYhkF+Vfb+CXhjyGFcSf+t22x0Sku/Un0fU/3QqBheeQtf6ocTtElKtFLmng7iZvi+fNq09HOKNjKu+2xArRAYiU7w+6oFnUDStBd53RciqFWfP8CPiQUhSwUhoV0CKV1t8FnHkqi1owwbsFK7k+MrC8IxvdG3vZ12zcdSAnMoM9dVpv1bnS/D/Ue6EdcBYfzKgQBHtqILsvWRdZVn0+hcUSxoWmxhr69Wbsmzw9lxBl8j9LvNFSt+2LchBlZcA9IEuE1QPhPkjy6Sidl2pLCJs0SyvsAlk0pOjRdcwfwn/L4Zl5uA/ApP9eKNgaJ184wJwp8yzjiSqGUs0L3F4F2Wx6NOSQITQATHXr2jN4qTnrESOQ2jq64dvkWRqdyqjettO9FKMIwv0BMUpVca3G6jax6ToL340zJ5GUbfnPQTIp5yoDEMei6n2L+z886eYPcln3LjreXfDkZae7sRKR/H39g6lnmMVXuJLpST4jvZ0fikUpeB+hyEKglucIAAO/ZLnBMjIsTstn8d2nDrL1z8+jsXdMeMrpSP/jNuXzQU2G89gs1NpJM4k11NLU3YNaXEgTH6lN1R2qaHG+odVwrzediu/WF8/IX7ad/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(86362001)(82960400001)(6636002)(66946007)(8676002)(110136005)(66556008)(4326008)(66476007)(966005)(38100700002)(316002)(8936002)(5660300002)(2906002)(478600001)(186003)(6486002)(83380400001)(41300700001)(9686003)(6506007)(26005)(6512007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2q8d8iVV3a+O1w6FKmfvt4dhsXDCkiUHZWlrLCQV2BD1NXiN66oeQv2Ebm3w?=
 =?us-ascii?Q?uO//03fV+9xy6V/2oxiHQwMuvIgq8uUP+VkUOFWTxV/QARIB5/sQANzZtoOv?=
 =?us-ascii?Q?FIKikXQ7a1+rjNtxCCn2gs0oMzgM9TmpaLQw3zGlVcjTGAKmtYeSHgAoqV9J?=
 =?us-ascii?Q?9GAEOWYhC3h07e8bl6ibbsmXbRCG3FcXfw5UqJdbyW9bK7cQCBRYYhw79wPj?=
 =?us-ascii?Q?kzsgVjctJ0xxLa/o+kHsMXE+JGQyCTNztb9fPgxuLLn9PcKDG7Bcb3w6DBEC?=
 =?us-ascii?Q?2ikfrfW5709gISF/U5w9BsTJZsEVy5kQ4ImJkIWlN4Qp5zVwe669FyBNrypo?=
 =?us-ascii?Q?7FTg2/z7PPWRo2/YM9CUn3u3SOjuzoRO1+vCUc39osIXWMtVO/RUFMHAn5cH?=
 =?us-ascii?Q?1xlW8QG7EugKzBrPQZcuuH6ulA/MN8W0lOV8DZDRaFKlOVh/tGXl8lf5EVuW?=
 =?us-ascii?Q?9jh0UkFuu0ZzE6HffIqDx+iYwJJ0ObJEjK9FcZSi4d9etfx2zh4XefbMjI+b?=
 =?us-ascii?Q?q3VNzjwJaAqed+MRt6mFUzk4wflHbZdNKeYb55TPAzeOOVrueME5hOXudQvg?=
 =?us-ascii?Q?BRq8aqQNN4ztM+O8iI2Jglz6Mcklz25kLOkaefXBt9lvRLllJKOoP68TS75l?=
 =?us-ascii?Q?zJqr5uj5oqu6xv85ogyBpq6IKN0FGxpOtUvNeM+a4MIsnBM+tZvQtnfb2aiQ?=
 =?us-ascii?Q?w7Jd5f8T6Vz72TGRvs5ofuK1Qu8g/9W2FF/W2AdcAZEMcVe6LCIqCwVUNLXy?=
 =?us-ascii?Q?FSYzPNnQ/wPoMddhyycuXktm4LHSrmXUVBgoVt5/G0C5o7ujOJHRmmZI09wm?=
 =?us-ascii?Q?LWH1x/tqfLVHGA3MNJXfmdwir5vII9nuJBS5k0nlw9BiBWkE4fWNLLblPSzv?=
 =?us-ascii?Q?r455eXWcUI0W4VAxWMomX6i6fpwZZbNBkChbXi29/J9E10tCvQpuRHQx9mh0?=
 =?us-ascii?Q?XS5ScraQjMXQmMr3cund4DwS1cNvK5Qqqcxzo1WmOP88URI57Hv0OPeiqrUt?=
 =?us-ascii?Q?v4mfH844qgzc6mZ5tmKU1AbhvYPTgEvC1TZT+HH0++Uo4IJkafZy1CLJGiIe?=
 =?us-ascii?Q?HjIEngh58RMCJm2wvksfHkDkgl8XipHae2kvFjCaUYWDBQeFCzHn6QoniviN?=
 =?us-ascii?Q?dqv9740vY1pH1i0Y7JwAhPjuKain8rK3XzfP39y7V3URbkHU7b5c797I8Zqp?=
 =?us-ascii?Q?HSaZl6b2nz+Zg3Qa0pzLPMAxPZXsJBtzh/I6C1l/9c9FhGhEjaZJ3JjWwjui?=
 =?us-ascii?Q?sTBeZMkyuRiQy7ddFTacJ6nOpJ20wBjiPIO4TZ7jxfix+uYS2J0FV4DcsO+C?=
 =?us-ascii?Q?CTjJRbLJeHnutrC/5al2/F81S/OLVAaHxtKhpum8E3X3dCIPLAwxWeQCf7fm?=
 =?us-ascii?Q?aYynnhDMfg/2vNwHELQapd6jzhydx0YuMEuSAfsQiFBMWOWMEpCXxw9y3+SW?=
 =?us-ascii?Q?6yFm9uUheLC7c4Ksg5g6jvvPiiMpuY/V5/zHVvx8EZyZqpHbn2/i4stAV//I?=
 =?us-ascii?Q?wo86uksr6IwLd4cJuAU6S3DGB7lQtHtyqxTO6igVFg5HPvNurZxmCmwK8HAf?=
 =?us-ascii?Q?Sx7sHBlAONZKoP4gOozITMNo3xDzicTtPEyXpqBFyvotWNc5o/EeRS7u2lY8?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a35b0c-3887-46e0-3c68-08da983c37b7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 23:36:02.8124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4T2ncxJO7Bh0xRS2YsBlNEW2DZqe2coVgeNzIwR5k7PaHlTAze3zfhMA345G8zgbg3ICl49eO0wgtsBXjp0GXtVWzV3c1TBh5Irh5AybxMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7252
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Prologue: The CXIMS addition to ACPICA was reverted, so, while I was
> at it, decided to collect both CEDT changes in one patch for ACPICA.
> Please review here, or on ACPICA github:
> https://github.com/acpica/acpica/pull/795
> Thanks,
> Alison
> 
> 
> The CXL 3.0 Specification[1] adds two new structures to
> the CXL Early Discovery Table (CEDT). The CEDT may include
> zero or more entries of these types:
> 
> CXIMS: CXL XOR Interleave Math Structure
>        Enables the host to find a targets position in an
>        Interleave Target List when XOR Math is used.
> 
> RDPAS: RCEC Downstream Post Association Structure
>        Enables the host to locate the Downstream Port(s)
>        that report errors to a given Root Complex Event
>        Collector (RCEC).
> 
> [1]https://www.computeexpresslink.org/spec-landing
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  source/include/actbl1.h | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/source/include/actbl1.h b/source/include/actbl1.h
> index 3de78b0d8f01..6041e8f4c289 100644
> --- a/source/include/actbl1.h
> +++ b/source/include/actbl1.h
> @@ -525,7 +525,9 @@ enum AcpiCedtType
>  {
>      ACPI_CEDT_TYPE_CHBS                 = 0,
>      ACPI_CEDT_TYPE_CFMWS                = 1,
> -    ACPI_CEDT_TYPE_RESERVED             = 2,
> +    ACPI_CEDT_TYPE_CXIMS                = 2,
> +    ACPI_CEDT_TYPE_RDPAS                = 3,
> +    ACPI_CEDT_TYPE_RESERVED             = 4,
>  };
>  
>  /* Values for version field above */
> @@ -583,6 +585,7 @@ typedef struct acpi_cedt_cfmws_target_element
>  /* Values for Interleave Arithmetic field above */
>  
>  #define ACPI_CEDT_CFMWS_ARITHMETIC_MODULO   (0)
> +#define ACPI_CEDT_CFMWS_ARITHMETIC_XOR      (1)
>  
>  /* Values for Restrictions field above */
>  
> @@ -592,6 +595,35 @@ typedef struct acpi_cedt_cfmws_target_element
>  #define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
>  #define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
>  
> +/* 2: CXL XOR Interleave Math Structure */
> +
> +struct acpi_cedt_cxims {
> +    ACPI_CEDT_HEADER        Header;
> +    UINT16                  Reserved1;
> +    UINT8                   Hbig;
> +    UINT8                   NrXormaps;
> +    UINT64                  XormapList[];

This might be the source of the build trouble. I thought ACPICA builds
in constrained environments with simple compilers that do not support
variable-length arrays.

For example:

typedef struct acpi_table_slit
{
    ACPI_TABLE_HEADER       Header;             /* Common ACPI table header */
    UINT64                  LocalityCount;
    UINT8                   Entry[1];           /* Real size = localities^2 */

} ACPI_TABLE_SLIT;
https://github.com/acpica/acpica/blob/master/source/include/actbl3.h#L234


However, if this is the breakage then I don't understand why:

typedef struct acpi_cedt_cfmws
{
    ACPI_CEDT_HEADER        Header;
    UINT32                  Reserved1;
    UINT64                  BaseHpa;
    UINT64                  WindowSize;
    UINT8                   InterleaveWays;
    UINT8                   InterleaveArithmetic;
    UINT16                  Reserved2;
    UINT32                  Granularity;
    UINT16                  Restrictions;
    UINT16                  QtgId;
    UINT32                  InterleaveTargets[];

} ACPI_CEDT_CFMWS;
https://github.com/acpica/acpica/blob/master/source/include/actbl1.h#L561

Gets by without complaint?

Otherwise that's all I can see as the reason why the first attempt
reported build issues.

Bob, is there a place where someone can reproduce the ACPICA build
environment to check these issues themselves going forward?
