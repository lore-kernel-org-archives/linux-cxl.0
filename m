Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF36A2C181
	for <linux-cxl@vger.kernel.org>; Mon, 15 Sep 2025 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932191; cv=fail; b=owL1QPuD/tlyDC7wjLNIaepbmkl6qawqVF+UjRVlmJCTPHQ2C5eF7cSOuW7LDRFHG0Nr3huywca5Lg1/XIqes+cC1IAuT0WWkZGZzMS0aG/hFUJTrwlNkQ1xAEs6Fe/iEAfh4ZSU44h8RBSM1tjCXRJ6OKihddPnsXF5Xnmi3Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932191; c=relaxed/simple;
	bh=fAdxoTqopbsFFdc+DJNa/iTtdaQj4K6a84hIOrza99I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uKorFHFCnrbORbq6rw2l6y20mzC6t4khKjxMKxG1ugqFjjcX0B1yMZucJLeP3hvRibrrsKS7BA7GTyR1nfAkY67aJ8Ms7SZ8KhBqzTpecZTg2ogWdQ474NhKlRlO4R+DKhwbD9Sp1wG98lulDQb5OO7QBaNgd8ErLXPwt5U7lF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gvli4sZ+; arc=fail smtp.client-ip=52.101.85.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gvli4sZ+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvAE5ilXoDBSd4ivtgFiUHs6Q2MpgC2rB+yTGXl1BVq1hSN5eqBgvMK1DGQ1PZ3nRzMpdmvzx4e916o/6ulodWRCXoYSGBHubr4WllYuxzRWsQ0yHM+kCQtN5EUybqmwIZe25yvjY6+8kwmTyeD1/cilmakFrKfu+YkXyIdGRGY7blRmO0XgjIKVw3iDsGUg5u0NlqdFEHygo3DVDgDLbvS5//y+50VVOcsdpBw4vEs2RtB3aR/uczecLBjp2VCHHplcAfZixugtCMAohv7D2GqP2FSpO2njYX23+FURdBnJ5uP0TmLo++ZrvGu0tvHOfwXL/xRTM2lt4i53bAtcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkYY/bLv/KTRbGdvF7teX1Gojl7V9TnPOq59UPcIUtg=;
 b=byxrKDO1059gzEhjPFKj2czpymFUlCVuCxjSX/UOvmpxxWKJ8hOQ7kLoscTqs8thiIdOlx/z7Od/Rf8PrHBIv/5B2Ru65INxLh4j4k/N7G0BhWR5BZebWVlBwZNJcUE9EgY4fYhOtOxwuvPNETy/47tS9LtHDMyaD8jS+XtCGxk81zsiXdUzgLou2iH9WlY/boMWca4eSd2oZjMEgeouCKL2gyRAgpssDENH32vvgHL6A79HRetc8/qG8lPNMVd5FeMO45MreJAz900GCdiKX8e0CR9DGTNGS1sNXLevVJFUVbgUsg4QjAe3SkZm62nPfOD6Z5ZwpwWS3YSgKUERKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkYY/bLv/KTRbGdvF7teX1Gojl7V9TnPOq59UPcIUtg=;
 b=Gvli4sZ+a9hVqHJeQ9E+SH59CEWIp0v4vPON+Og7tEBzuMyugPULWxh2TNU/5Ad0W+dIKpPoHeZhD2sEPvclD3O5CkT76v62JJOGAuENU+SI5ABgRWZvEs/fvFV6gRvXJZR4i+5/4dz+tENVA7r2m0mwZXSflsgxPR6ipR7GYGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 10:29:45 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 10:29:44 +0000
Date: Mon, 15 Sep 2025 12:29:39 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v9 03/10] cxl: Add a cached copy of target_map to
 cxl_decoder
Message-ID: <aMfqk-OYuupeKgoB@rric.localdomain>
References: <20250829180928.842707-1-dave.jiang@intel.com>
 <20250829180928.842707-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829180928.842707-4-dave.jiang@intel.com>
X-ClientProxiedBy: FR4P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::7) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: e58138c2-cceb-4fa9-a967-08ddf442c9ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nBB1sX66pfl/WEmY8Yfi5uS/jMOV/5wNsY5A6rtiWt/BZPmxaDW54bux54xC?=
 =?us-ascii?Q?+wpgs6PnnRAQRAU0WRL/luLDyTs0rIwYulu54ex4MdJn9rvpmbYs1ANRjirf?=
 =?us-ascii?Q?6FXo0RVAENsB/CuqODvWbI8A5aQC41dmSOnjlOCddC3bkQNYJxHha+ROOghv?=
 =?us-ascii?Q?9WkSLrILpGH7tKXDa69v10oPlmGYvY3kvPr/F1TVkwviUsErsOEbp+IavqaS?=
 =?us-ascii?Q?pj2cGF6R6N4WmRwUqBLiW/3qn63xxmMHkeIYN375l0sqC76bzPZUPXCi564O?=
 =?us-ascii?Q?q+vFouOG58EYj44ZPXfYuGCWtxH5RC3KVuhB7dhw8uoSozfpLkdyZh2NxNn5?=
 =?us-ascii?Q?3359rDOCU/hdarg1SsVJOzHD6Q51Q1k4xTnVS8uK3/BAm6Y9csU4c+dbcBlG?=
 =?us-ascii?Q?O1iv9pupKGkv/g+sm2qAwg04KvamSeClXUSPz/wKxbp6NbK6K5RTCLaCAHwJ?=
 =?us-ascii?Q?6uXcoW/VdAZeY3efUwhOM1LRbvMcbFsWMbpNgLU8GzooorTVjgxJrVO/mpEO?=
 =?us-ascii?Q?duLuLY2Pr0A/K699vpTrKA6zXJgoBBciCv+xFUp11XneMzPW4i1yFu1BnqPx?=
 =?us-ascii?Q?ZgftB+4RM624uxvI0i7uVu+kh17x8lF3czwAG3ZaSIqiEAu7PMD3O44obY9j?=
 =?us-ascii?Q?K2avpeNBbcD8o9D1w4r+R13KNCNy4ghDnmQ1eqxAj8oMkdKGnb708dpXP5nZ?=
 =?us-ascii?Q?22btOZpHXz6mik9eSjZfdn6MMXacrDbKCZ4vyseo5tFJyGj3tSDlsWjrdx8j?=
 =?us-ascii?Q?khRa3bBxF3xbcb6tFONUNcbozR9Nz75lb8rEvFNydmwlSsa+a3TRbAGKe42x?=
 =?us-ascii?Q?QH8k3kTCAeVTIo/kDl6Pmaa6gCp/l5CZrAMnYCUnDsYGa1NiNfXdRyEQieFW?=
 =?us-ascii?Q?YNxDiPkuaETeJKAVj0+tcGEsfw/w+2k5w4h/Ug5vJriRUb2pciPvdk8PDCGM?=
 =?us-ascii?Q?IbAkDWljdI39L9zD7oVhjQRC0OlHrQyJpvPDbITx0LYI4AkoDZdIkkkEsBGd?=
 =?us-ascii?Q?wyTHCOQrZAHlvhLNq6xt+EAZduNQ3oDImq7J9AdAhtWIO1vJuZ2CJubX4Ezm?=
 =?us-ascii?Q?iDRghsk0O/2LGaRn+CyfqNlg7QRhWeCvieWuv7iHNYI0kHLF2RAAxhBNweHE?=
 =?us-ascii?Q?tFYgi7wxgWDiG9crnsPeMyquvt52m5DfhL6MSiQ7iy8Vc0nCu6IdD33J4riT?=
 =?us-ascii?Q?c1PYCOzjVu85pf0t/ohPyk8WmTFBH5HECvw6APoEv9x+9cOAyLtfIF9oAE4V?=
 =?us-ascii?Q?PaEfh8kvU3odKtUiiwTHb98CmMSGQMlzYQi+OxQK/t+hqUIXuTmpqMiBL2vS?=
 =?us-ascii?Q?CZHP4zjb9Lc4jL08cIN+mtgeDeOFCEQmHI5ha+5IpuhyVBLocGTPoVOReZxg?=
 =?us-ascii?Q?Nltwp6u7h3SJyE7EFd/kh4pWJ/KTdhQaaFZqHvHCoa6EuxIhfpFmpJLQl6PI?=
 =?us-ascii?Q?9Xvx5Ktx2Tc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?76m26iKMwb0iZ2QQOzIIMBSBPdp98W5F2likm38w4C3eFgXuozNG22CYC9pJ?=
 =?us-ascii?Q?is10uEdPv0tSZmETyOcdr4d4/6Z4qo+8v0hA5vpxalUfKXiU39WKD+bzBpKL?=
 =?us-ascii?Q?GKT7glszYE1biWOaWHR3eTvqZVo1c2ANlvWQPf1rHproLiVSzQCtWhb52cqv?=
 =?us-ascii?Q?rlD0WT8rCFSH0t8bqxUmyCfJQ5Ec5O/eBm41wO82VIb6N8gu2pNWmIpr6quk?=
 =?us-ascii?Q?J/hR2xMPIRm+oSt6UMQzSM5KMwNcy+PfZ+UqzHlVRmds1qI3Kx/P4YHUuViM?=
 =?us-ascii?Q?YM/R6w+5MCEcgqTOOWxZS2qL4Pb67jGStuOjPF6koaqSFbRB+KsmfJ15dv9g?=
 =?us-ascii?Q?k7MrhmtmUfn2Wzwxgt1WclJV/4/MfOFCjZDOJvi83+4DsoNJAa2aobPYgw7L?=
 =?us-ascii?Q?mFlNde4Tz45KZ5VIlVPi3X4pqFqTJmEsrL3gRPvYKgmrFtU/5aJa2gIdyCZp?=
 =?us-ascii?Q?tUNW3XOdHzMeXg4djYLc4O8ZC/li3nFNd//xQubX21zoGYaFd6sFkeP8YGoM?=
 =?us-ascii?Q?RLsFlb4g1Q6KtBraIkBUllszvrlUztvQ+xic8Iwibnt4qiRx2jy+MebuWgkn?=
 =?us-ascii?Q?EWNBSNq+1+4jNOHd4Co5bRwp9N0M/T/t8V3gdMuzLe5N6a5xurj7/cPRYC5z?=
 =?us-ascii?Q?+a9ApUSHl2lYmttJiMvF6mflde8VOMRjGC1BXGQkXvdzY55qSDejdyZl10/h?=
 =?us-ascii?Q?m7p1UjsEYEwhDqc/Hdb0ArKfzr2xi7TVrY+0JqaX2MvnFNxFWaQB6wkxVRDo?=
 =?us-ascii?Q?8PbKQ4XR/MdmHUPXjZIRQiSkcKe8+icFwkhNa07wozUjT+BhCA//K5Bvaisq?=
 =?us-ascii?Q?TxV/JUvyMDt/X2pTZEfbUtcah+LB0KHV2EiZb/oojpmsQphD7CUmZEzBu7yt?=
 =?us-ascii?Q?9ZrmgoF7RDNAXyjNLWPWleiXPrRZ2TOoMDEeg1YX1yxxV5ZRqdP/Zj/CwCJx?=
 =?us-ascii?Q?PF1o4M1xMqdZ8k/oSaEB5PLPqKJpOeM0Tp0bw85gt9RmDYVkLJ63HVGtw5IF?=
 =?us-ascii?Q?sX20jPUvD/j2GEqILgo7TesLZD0ZHRxNw+tom8vyO+he7x2Ay+rk0yR5+Ktu?=
 =?us-ascii?Q?DZsqSynIopyefrCFEr9h5I7pnQPZ/sqNmt4K9uCkxBf79ii09BVbUStOKsdj?=
 =?us-ascii?Q?1KpPLZA6JnbQb083G8hBZp72WW8YyirM1J5LldOiJWkaJyfKaQlzUJIhYpXf?=
 =?us-ascii?Q?tUOOpwLAFPPejISeVw0CnlA603lMq18AntquETa63mOJlgfK+vAGkqwpcOEn?=
 =?us-ascii?Q?oBDifSMOdfYPvhp7DT2sjlQIYXt32xeXg8dEfYcq9GDzeVvx9m4guG5s7hL5?=
 =?us-ascii?Q?YOnwsRtAfKv9A/Smvr0WHansY8vLjOZIK/3HNh4Gv56Z31UnyNmrZsuQwUvS?=
 =?us-ascii?Q?aQWJjgZD64YWhtTWUhtTnEaSIbHLn5sGObrkmr22pSEm7B82+pJc7Fhs4RLs?=
 =?us-ascii?Q?OkR0ZjRRlIwl9eRg8j8ATXngTuyh49dqHt4aIndpl9KfqtkcG2dkrXr6GT42?=
 =?us-ascii?Q?Voltg3cx486HbGooo9xkjMfmijdCT36L6b7ud1MF+L9KJ62DC1Eq+zQ7VYIi?=
 =?us-ascii?Q?QhVE4Lw/8h/OUC+h/dB+QN5E1jl/ykGWLX/L9uxH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58138c2-cceb-4fa9-a967-08ddf442c9ad
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:29:44.8739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EAN2vi6J4NFE+mVztPw8rAk8y54EvlqXH7SjXaBqnsNME3LJjUgoASIBvoEkfqmOf/sMkKWPrHSboMiEV8qzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930

On 29.08.25 11:09:21, Dave Jiang wrote:
> Add a cached copy of the hardware port-id list that is available at init
> before all @dport objects have been instantiated. Change is in preparation
> of delayed dport instantiation.
> 
> Reviewed-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v9:
> - Add region target_map update for manual assemble
> ---
>  drivers/cxl/acpi.c           |  7 +++----
>  drivers/cxl/core/hdm.c       | 20 ++++++++------------
>  drivers/cxl/core/port.c      | 22 +++++++---------------
>  drivers/cxl/core/region.c    |  4 +++-
>  drivers/cxl/cxl.h            |  8 ++++++--
>  tools/testing/cxl/test/cxl.c |  8 ++++----
>  6 files changed, 31 insertions(+), 38 deletions(-)

> @@ -984,7 +982,7 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>  }
>  
>  static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> -			    int *target_map, void __iomem *hdm, int which,
> +			    void __iomem *hdm, int which,
>  			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)

Stumbled over that again in v9: Use 80 char limit here.

Anyway, not a show-stopper.

-Robert
