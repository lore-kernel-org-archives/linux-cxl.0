Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012055.outbound.protection.outlook.com [40.107.200.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50AA291864
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569964; cv=fail; b=r44QzFZduItHWE8ZTHxQj/lNfq6NGhd1+CURyRSxx/Gc02l0PY6TFQsour1bIWQkcE85hE/cmkKjrlfUrCzNG8aNgsqsdUxqe2MrueHD0GpU5eyDkXf81Y4JLAoxtE+QCn9fxdTmsgLu/5PCL6yugJjDXC0wJ6M6u9b+6WZ1iy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569964; c=relaxed/simple;
	bh=NYrLCuq2CUwmXYVNoEOUpEc3jkSxiqWdJCiEAAsIJTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bx7nKErCujQes2twSE1N0mcjEuP0jgf7bplM5THtAOysHbMg1S/oi+J1Oa18UJTCFVADiPsh3co+COTqI9BU31TVC4XXYUGyQoKfUExMSUaTT8HDR/SkjMNDZEbC4KYDR025Pyu8ciP4+RBMwRMQKjqTflk4pgu9wdavgn4RI3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i9fmT2pB; arc=fail smtp.client-ip=40.107.200.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i9fmT2pB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYKHjH27FMTYvAKtLRZ5DzWXizjFkCu5I9l37C0GOmzAH/GZRtMJdymYnxpL/FmtkDk9wozXlUZMtwbycTr+wX1YijZsx4qkIv41wENUyS548D1KZ6FRnWXmabAE8gh1szaJrmbxeptcTKh/gPukJqUf59JSAROZRD8G4gZWsk45HmuV1Ysicp0ubbB2v2nvqtF6sTSsh/IwCB+BxsApIP2sRvxzmDCaalsriMv2u0D6QUqGVE02/ogn8xtwSlDfO9fJcrNu8G9EIQn5W+mRDPUJgJAi1whoOECkBp01I3KvrJJYpKdsDHxQgB92ERlutZX4wuOFbjK0TL2qvyqPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xni0nkj1Qfix7aguKNYWKNBraUvAvxFY9kXIwDzx/cQ=;
 b=vhjTbkXviwF5OnTiQGq+7+RJrWJh8cE73YA38JJTEgp24FIhltM9zUoCvS1r4tlSD1SGRQqfOP/0fB2fieQ3LP690m3N4FzxvsDfxKPsUqc0f6AeTTmRvjU15dRdpL7ljvNkKe62t04+8mnfj3HAiy4L2KwnuClqV/buqj51CxJtugv+jtuMgXkZwYGQ79J8M/eGYGtlLEWwtwjJTXJ5M0GZI8caWEvHgFysYgYEfMsqewMW/Y4vIhlXE//tUFsjwYL1c2n8WRvZ37P5ESBpqGWGO/HErOuT58F3/sBiv3T+8o+rF63nqE7vJP4NxTmXw5GPUywf3vXLZ3fRuqCSMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xni0nkj1Qfix7aguKNYWKNBraUvAvxFY9kXIwDzx/cQ=;
 b=i9fmT2pBGbhjdL1lFQ3Vl3wEFQiMwzEtJg5GJI6h/hvIkbljokzshUvelsk4NRRee9L/450vqaF46NDoB1cWQdJbAWqmzUfl6G3vwX36Gjxbn/0fhm+0rDjPU2xjhBWAC0v6ATYF7aswa8To2NS6+fpSHzCU8Jq1LRS4kN+gCgRHwGmo45ycf8hVE3riInJJionuYpvO7TDsXx/7cHu/KDg4MSQFkvJYAKvQKPo/5nny7uJs4kGyoK+mkprgMzvTGdC/uxkcLm6eF4SbcFYwFSNrGgMe4MYAUsLpS1i58kDgg+DCujmdPiFt8AO1nXGiwhbbI7fmXGvLy7jP5SVz9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 4 Jun 2026
 10:45:57 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 10:45:57 +0000
Date: Thu, 4 Jun 2026 18:45:51 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org, 
	alison.schofield@intel.com, djbw@kernel.org
Subject: Re: [PATCH 2/2] cxl/pci: Convert PCIBIOS errors to errno on DVSEC
 config accesses
Message-ID: <aiFXOfVqWir4lsOi@MWDK4CY14F>
References: <20260603185752.4149725-1-dave.jiang@intel.com>
 <20260603185752.4149725-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603185752.4149725-3-dave.jiang@intel.com>
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: a2856e87-fa34-4b32-b5a1-08dec22675d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|11063799006|56012099006|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	O4SpaApoJr3bHWyJTkRIMT4U7c1gDjyX76CPsXhGX9C/Y5XuviG93ASzpvzzTBpNNDyStYsH4gH+JZ7TuC9+1r8ZYir9t5D8epSuQ5oUZYlq+KCXslr7Fr4CBiH/tKxQr83G6kGYaaRnXoT439DnTxQfVcwgfpH4zMQBh1KQ9/WTFaS2vlDnuntGaWvhvg78Qhc6cVT4+VaFzEDUIj30R5SekbIYBHit5fjzxAQcKcRRD2K7KItrVASI5fl4mn18m6O8kSTqdTROhX5N2bM1uiC2v1khzHjmJJAzQPH/eIoIpk9afRv0EhyggfHqS71lklXLKnjKhTmjtEpDweDr2/xTTATa/Fw4GczPi8HeG6ojP9QqHm2Powo0Fr8TqABXz9PV5cMjUhqPSzTUPmfBqs80cw6wWRWLP8+qws8meR/wwGDHGILl4M8xVGD1OUr19jiXJTqt8YPOrLvegaBELu0WToqE/uBQEIHU6wCUbqYEVdYaQHEzgA7XO7HYSKxSZK3i0+Zf41W/oyHk7LbL8rBtp42VmbM5ohtJsjcB/oTQ31LUTSlmHnhp2VdolyGPNICquYjJqal63VguqGTnbIxVa2NKzmwGp9xT+FIe65Co2A+PuwmK4XAqSvWt3asznty0ABN9UHkXr1Y8pBoUTUZJy/HgCcH1uaD+HfrVe+ukT+1sAa5hIKCi73PyTPrQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5rPtUgAv1UzAK1HDojPDjjMo3AnAscA+hu+nI0R8pTzUVJLZpKrxWq/qY5va?=
 =?us-ascii?Q?wfD3fGxR2AokX484P3AorIjF2h5uLSGqJFPlpV98I/Yaj0xpmisBA8zgD/t2?=
 =?us-ascii?Q?uaAhibYsuX4Z7Vwku5KAN4fIr0fvrSG48DKh/OAiZjb0oOM/8t9wQ6n9H6V1?=
 =?us-ascii?Q?fQohHObtjI4vPiXCF8s1zxVCwMOIlyRgzxhhonU64mxbvz1oKDdawFj1qMx3?=
 =?us-ascii?Q?uB/NlJe9hI8JNEXQcbF53hxuXxu0oWQU8O4LXUYUJFGrtt0tB+M7/6SpK/kR?=
 =?us-ascii?Q?67OChcZk5JneLIfiK4rJp7pmZwo/SSTa6BCuxkbwzzmkOE13NN92nKOYNZ1R?=
 =?us-ascii?Q?l9A/Kh0A0TqejBfKUYPFxVkbt2BTVQeIyrIluuQxqXeFvBdmpDK/vyAjmV59?=
 =?us-ascii?Q?WJL/06DV01RJZ7i3xpENZjmY25tlLtCMrbcp44MVxiH6Ra55NtIUutEsRf8m?=
 =?us-ascii?Q?0TcNrhgVxlpXQleF5Vn4qlRab3f8pk1pkp88wj9gMWKTbH1a8TrlUF2N9dHM?=
 =?us-ascii?Q?KM6/aLje5zhGaCbAOJ2pokrKBgaODna4+KAOVkWfqBfmjMJOyjzSodu/5snE?=
 =?us-ascii?Q?LZjWr/X8jfVbCP2/Ckef6zK3InQRFcHOp3AlvqBAVq/gc2L7KSmEg1+gmlHT?=
 =?us-ascii?Q?58zAf8mm1hQ6jbZ67xES1hG9hD/W3mPfYL/ot6ijkzk4gD+sIpb6hgj9fJ2F?=
 =?us-ascii?Q?CjasT9ftSbO93NGYOFADZj9n/b+J86igrPU6oANqrcFe2Ggh9Ds7BiJ1B5Lo?=
 =?us-ascii?Q?hWYke57PIjqn9SEhEj+aPx0+o3vtJ+ycg99wP8DPvH2QO0tiYaQttwDNR7tx?=
 =?us-ascii?Q?sdUdiC6v7y6j/2E/TDrEWg27UMWBh71NbLOg5P0sS8lFOns3S5QD3D/SBzIT?=
 =?us-ascii?Q?qxapA/6cdbRuJtiajG3F098nfvAFpevEcpMXYTLFcKhfweSYKGxUshaDWYf0?=
 =?us-ascii?Q?ydnqByJzEP0/jlSTEoorH5WR5MD0nQw1st1gYia0IeShIFLW67UU1d7NCpSp?=
 =?us-ascii?Q?A84BumXsXWkWypEIQXP5w9bWP3tyDGZ8fCgARGiEWg8R5SH704L/bvxwPVvS?=
 =?us-ascii?Q?N3RbSbsjOlbf5SlMgve2FuT7neWaqSxx1IHewWuZ5E8GjWzjRknadi/HWp0/?=
 =?us-ascii?Q?IGAqMSJROoFjcEAZyFEmq98yKtnhxGyQubTgITa7iXfykmyo2PrV1Q8A1t5T?=
 =?us-ascii?Q?cfXL28uBOeOCAoZVamUfQ8NLwA8immF2CbmcEQnsZDM0UhOyZXG/bY9zOP7d?=
 =?us-ascii?Q?rSUNgnahEuuThIbymWwx1LeantVLtSFTOKm8WXC7doFCJ6sqJdxugsRyZj6x?=
 =?us-ascii?Q?x+qWu2JY3w/0CB9Bw4vFUXlDZZ6ZPQJtyOK9b4+hY8eTXHkgnXxqP+Ef4iYj?=
 =?us-ascii?Q?EH6J+jsYDtyzwD/O26KoRfwYWekP0nAYAFR12OvjdF1wJeh4ecTGYMwolmsf?=
 =?us-ascii?Q?fIQJqOahSAcfU5qAoHVm1MAqSiej09/LkrAJZ7AHeLUD7TSRyIeTGI1wbvOO?=
 =?us-ascii?Q?vf4k90kxBkCP4unmcdNi8Ypk6CKLRpYa0pyx7REvMmguQNuBZWW6VZGZE6zS?=
 =?us-ascii?Q?Gtwt4Zq1Akg6hWrS1m1rVCVk6AnSJhHUwMgNLgPOAUTUIYtVECiZG5r2KhyS?=
 =?us-ascii?Q?SeQQ0xv+jK4ez5P8THKqC70hVSUQjUrWFL7jQ88VYP4mBxnd71fn77qNiC/U?=
 =?us-ascii?Q?KUt/hD3hfc4v6CREF9Lgg+VGgB2yXTzp3vj+Ph3HcGdbcwu09oiKejEHbDGu?=
 =?us-ascii?Q?Ci1D8UZpQQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2856e87-fa34-4b32-b5a1-08dec22675d6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:45:57.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MrvkkQHG2Vp1N0MLXAcJEB+OYTmDFFBXTjYzdUWR/dwEjY2jDS9qkvt2aVEVS6u0UC87VJefu00XBSum8OYxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771

On Wed, Jun 03, 2026 at 11:57:52AM +0800, Dave Jiang wrote:
> PCI config space accessors return positive PCIBIOS_* status codes on
> failure that are positive integers. Several DVSEC accesses in the CXL
> core propagated these raw values to callers that test for failure against
> less than 0. Thus silently misinterpret the return value as success.
> 
> cxl_dvsec_rr_decode() and cxl_dvsec_mem_range_valid() are the two that
> have callers make such assumptions so far in the cxl/core. Convert the
> postive error values to negative errno values so the checks are correct
> on error paths.
> 
> While the chances of a config access failure are low, fix for correctness
> and to avoid confusion in the future when more DVSEC accesses are added.
> 
> Fixes: 6612bd9ff0b1 ("PCI: Update CXL DVSEC definitions")
> Fixes: ce17ad0d5498 ("cxl: Wait Memory_Info_Valid before access memory related info")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 43885c59a7f2..cb33dc8139dc 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -89,7 +89,7 @@ static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
>  					   d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
>  					   &temp);
>  		if (rc)
> -			return rc;
> +			return pcibios_err_to_errno(rc);
>  
>  		valid = FIELD_GET(PCI_DVSEC_CXL_MEM_INFO_VALID, temp);
>  		if (valid)
> @@ -275,7 +275,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  
>  	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CAP, &cap);
>  	if (rc)
> -		return rc;
> +		return pcibios_err_to_errno(rc);
>  
>  	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE)) {
>  		dev_dbg(dev, "Not MEM Capable\n");
> @@ -299,7 +299,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  	 */
>  	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, &ctrl);
>  	if (rc)
> -		return rc;
> +		return pcibios_err_to_errno(rc);
>  
>  	info->mem_enabled = FIELD_GET(PCI_DVSEC_CXL_MEM_ENABLE, ctrl);
>  	if (!info->mem_enabled)
> @@ -316,14 +316,14 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  		rc = pci_read_config_dword(
>  			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i), &temp);
>  		if (rc)
> -			return rc;
> +			return pcibios_err_to_errno(rc);
>  
>  		size = (u64)temp << 32;
>  
>  		rc = pci_read_config_dword(
>  			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(i), &temp);
>  		if (rc)
> -			return rc;
> +			return pcibios_err_to_errno(rc);
>  
>  		size |= temp & PCI_DVSEC_CXL_MEM_SIZE_LOW;
>  		if (!size) {
> @@ -333,14 +333,14 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  		rc = pci_read_config_dword(
>  			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i), &temp);
>  		if (rc)
> -			return rc;
> +			return pcibios_err_to_errno(rc);
>  
>  		base = (u64)temp << 32;
>  
>  		rc = pci_read_config_dword(
>  			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_LOW(i), &temp);
>  		if (rc)
> -			return rc;
> +			return pcibios_err_to_errno(rc);
>  
>  		base |= temp & PCI_DVSEC_CXL_MEM_BASE_LOW;
>  
> -- 
> 2.54.0
> 
>
Reviewed-by: Richard Cheng <icheng@nvidia.com> 
