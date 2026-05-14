Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3AF2AEF5;
	Thu, 14 May 2026 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778743884; cv=fail; b=UBhvCuTrHbVyqmZEkl24qjJdbyM98NDlRp35BeXgIIIgvdVBaOLE97dgWUENNCua/yhme+UOr45newh5zyFBoK61LfHL8M5zfC8XfN5JI9Lt02wt3tLPK+/ufwTEwJSirA5HZKwcl/fSMDURuRMT5jwaIER2H/gQS5OghclgjkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778743884; c=relaxed/simple;
	bh=vZ8OzAi7wQMMYk0gNnyPivjPDODvcD9u6/okaLhdpj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=azeRZDgpFb+yc2emBx3z7h1CUiMtcDmr0uZYFLLEBfb0tAKgYseBdPFXd2TMdrXusfNWGGzaR2s8ooi/34ebv4Kajlst6cj6//qOM+COngIcA0JjP29fk+BAb1EuV7E0TPc1B5+ryO3EZuQxDyS02SzexrblvaoKaDmfKgT0w34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kteQfozg; arc=fail smtp.client-ip=52.101.43.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kteQfozg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeKuk1g9bGR37D7M2gFDKvObuQATsh7iIjVseHn1LrH1k3b8o8IJw/pzMCa+n4JEDYdc9TrzCi3EmhbeRstQewHwXKKmdMSB0s4XYHxb5z6B/h6q8W85VSxAr6XIQfmdBnFxWOM3bBsHIR3g0lXuYw+7ytt7jZ6bAgCxT1I0xemF4+t8BnM/Jr/HXkequHLl18qNuAWEeSfjScISFUR7cgNa9m6H4Rp8lxKRsjB5wrO766fLr14tez4rgNmnVW8n7rQUBwePjcAQNH5OxXHxEy7CJm4bFtmrUpnl3S3zp90Grls3iux9ngyuRaeRnLkhy6KVLP1LYsGZi27dhQG5yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIpn5L8lZ45LGZSjkIP+tODf4fR6c1+oLviSaMHo+YQ=;
 b=xztyKjIZCFUaYXR7h6EDb2CavbHUtoKi3W1+8fCjRtlUjpBGrWy7TdvvVyC2yadKxdMtz4eZj6Oq2iXfRmQCt0/oJRzHMXO229DsAjr8wnvXw+7Mlybo6Ec9TrSLUSQzCV0WCDVi1efhi53mof9DJ4j3hGq1Cr5Xyo44hzj7KLagPigg86U7LUw1RXk1ETLNtB5cDyYSsbVsGFPBFmI2CFAFOeABXYLLe1mGq0aqy1R4A+11eLJfNRSi/AXAS0KuVXGrNH8CFoOutCzXADk1XNi2KJ6+R2g0rq2qEhUCjSXbIjOdmI7I8THK+BQ2HKsA91XsYZ2zHeYyzkWS2xFFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIpn5L8lZ45LGZSjkIP+tODf4fR6c1+oLviSaMHo+YQ=;
 b=kteQfozgzhEGCbwUZAgOM+TNFhYuldhrWUBM2uMaJx5keNY99/YRvcVmbDDRI3RUB1Sf//ZC8lcHxpfBopwRF0ikPp1u2mKUbz8GXN+nMdsLkXkkBRXK4bLV87OBzUxVBZBBnSLgkAHgD3qMLmqkwwvNZvFLqDcwwNmkxkzalu229HqZ8pbHF8c0LgKN1gE5Mah0nh48MxaShhTljR1lzCaGqn3Hj/BKrv6yrhzvyvgyoSddnb9oW1vKwe2LnovqnMOS7re0pLYIgA8etAiVCrRtuqEOTYrh3jhh7Msbl9QO9dEacO8grPg6FmWLRJ7Uzbeq5TIsfpY2sUy2JJP1OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 07:31:18 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 07:31:18 +0000
Date: Thu, 14 May 2026 15:31:11 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org, 
	guoren@kernel.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: Defer probe when ACPI0016 PCI root bridge is
 not ready
Message-ID: <agV2e28XjW7yOUwH@MWDK4CY14F>
References: <20260514023238.49984-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514023238.49984-1-cp0613@linux.alibaba.com>
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MW4PR12MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 29544f24-7515-43f5-5d25-08deb18ac959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	TCxPY00WpPmlD6HoTKKNipadty02MtcFHGHIGZrs7LyI/WsBp/H9pPyRPny8HdU7XeuRJEuiTESqzAiTtUhcJVU844x9LeqZztMzjyap3O00Sxz+YQoyL0nRTqhPlHwxVtwRx7h6irtUXRGi0f4NZ2JHgtnVzkOcMVD6/KIRiNjyM3+GhYaQlNAdtCb/vKcUoDZPf2iXfoXEaBAyRSWJN405lBgsM+VxX+uTAgwG8AlU+Hs9M99/0BorjEyCH/EF7PD1QnZha+XuUo8nm2NntgMRUGO2OLyvm07nmLHp5iUXM0LcseYOTSQB4YLHSwawLKm4NwD2H53mcZcAm2xOC7WFr6608CM8AvWenCDEmigbXRv750tw831LjlmdLBcrv0c2A25p2/1ePkkH5tl6+YfWHXkST59hjVFfGCCrKR9RitLEeUNbUpAUVvdwPuum5eA6On9TsE1wAqS7x4GSH6BAvkauDvhTL4tvOZKFnr/qZym54OHh+2T+QYC3qTuwoxkYgZA1uhkX5whEcTBScPblN/MKFz04En6BEwSidmN0QViTfzF/qWx1bRxXsyButKnMF7UmA77Gmwnnwz6DmKwDFIIaC6QdZei6cGgorMENEhLKt3vbcLOoVhI0gep/jUWq9rNcHC3GIxCG7M2J/M9FKvORUuwaqtLNUYMTNqXrtsal9fnw15HdvzD6j3nq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AyfXfEIpwX7Zd+hyqzDB+/kFH7SuaHn0/fS2u8opf+z2kBfIM4QTEM9pLgk/?=
 =?us-ascii?Q?Js2aPOMQfC2Ljtvh1IxG1ViABo1cxCMVctJr3PT3blWZHRVO7UYuVzjiwdHj?=
 =?us-ascii?Q?0hJHdqKcUweHHahcuvDagwzg2n0ljI8S0lfZ/LCiRf1oJJq7JoIT8imoPBcj?=
 =?us-ascii?Q?cKp6TLNa2Odh0sp3o/jnrJ4ISnaDzsfOhqhrRn/mgeZrZNsmuz1ymTw9ZuDf?=
 =?us-ascii?Q?h7/xI2qN5dsoP/5ONPtIJqSWz7iQqvRqV5F+vuNZQNXcobZ/Ifm0tcWxAFK4?=
 =?us-ascii?Q?BNVkrvKIMXHs6cdQfXm7vVL+v4SSgJgQy6sfRF0N9PXlnHLvUWeY9sdW2IUQ?=
 =?us-ascii?Q?+ey9PPHesfV4rNydeqfyNHHLKJNdl4JBZdJaTuJRjFC6g5ix27u/Upynat1L?=
 =?us-ascii?Q?04PDZ1d8sEC/pzsYGG/062xoj0/J+wVo4Q/GAA5Q08CuYGhajMGZ1XOiNRhO?=
 =?us-ascii?Q?AMXvovSjmznZ084aJee8maTGby9vBS+isUoYBE58wNpMrbsSe6BsxKsPE7Em?=
 =?us-ascii?Q?RA1svFctMWtT8LjUvXtS7XR8Cxth3kV6B8jcLzOhwBo3KlFd6PsKPNOWOBTS?=
 =?us-ascii?Q?+dAAms1BYfeD3P7HJq6pGBKGgIYt8Il5ZPYZKUAMBD94EPfjP7PfHw8fe3XG?=
 =?us-ascii?Q?2CPOYCcYb7dvZz6BooNIySZEj0T9+AibvCoc7kIYAnqCOa5YZXHxYIQFU1fY?=
 =?us-ascii?Q?hx2PsMAg5hMKJkFN16kT3+SFeODTuVvOYqbw+xQMJnt9QuIqze9EpXOHh8Va?=
 =?us-ascii?Q?6lwh7WII5riboGCHpqz66xyR6SJWIiNuZb20cwmYveQ5cfPyA/CX+mvC2ZNt?=
 =?us-ascii?Q?i4hsmFIVfJrH/8tZV5mHSMKRjb6gJbH1qkFNiP9lirUc1zH0LYFIUUc4x0yf?=
 =?us-ascii?Q?AKHtwrLHf+TnNRK7+IWnnBCTdNhrQU0tNLy/YE1iSZ7tPR/DT4NJKvdQ8Igz?=
 =?us-ascii?Q?Sx4NjJIrrupCVLBpdpd1GMqaaoPj3MxWlApOOElnAKyCIwbIeo52mh2TePtH?=
 =?us-ascii?Q?YrWy3nMyzZmsCZajefdRpfvWW6MfpugvT7OGItO7ELCC/Y/Kz6q79pVeSKd0?=
 =?us-ascii?Q?zpCpSWaDCc611vINgVpIHF/rfTgOumgvB981zhYDqDID+aonpBze0a8fY0C8?=
 =?us-ascii?Q?wUqBVL8hj7djup5Hg/P+EpjN8XMkvnIu9dDvTMaFHUl9In01IYeBxl4dkiyZ?=
 =?us-ascii?Q?+uvTxKTjJr1dXwk5X+IlrmUluqOaueb5tVlPnzMuij5S+0rB1kp5QBwZ57Wa?=
 =?us-ascii?Q?okiwDMhvyyDMLYpenvCI/sVMSe9AAw0o3CK4ZFPp9f6oTjt8FRZtHpYCrM1J?=
 =?us-ascii?Q?bd6J7lCCSvI+iHKA7Ye6t3vA1mEm/omlMMqdJLa8dmoicbRvmmMRxdPoO+OK?=
 =?us-ascii?Q?IvdMJbufSjnHAYGRpK6uyRQDDaQF00VJqRYPVi2pE/vCMM+SIfb1LALipn1t?=
 =?us-ascii?Q?J9rLp5UpsqZ7mnBcxtsZUxZgM7LxbfFdiWNWu3SVGGqO8WRJybain+ulhRHP?=
 =?us-ascii?Q?v6TjVUycf/FE7rxp9KALr05iCAUlXrbIh9QrEaG1fA8J5Qat3FanJUuF5G4X?=
 =?us-ascii?Q?ihX33INl7qqk6uDfxFoiT1//1I6Gx18SaEsJ8iYYsJA8xoYX5B9wb01EbwRB?=
 =?us-ascii?Q?Rmy4mFyFxGEDz2KZABp+nObc6QNDtYsgPDZUerg9gD/ysDcTKoS7SRsZJwE5?=
 =?us-ascii?Q?bcGIYwbRWK/zB3W7WcqEbjbUgAKToiVp0UISBxCM95Av4RuxbbTAOEqbvAqK?=
 =?us-ascii?Q?ZG513mBOBg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29544f24-7515-43f5-5d25-08deb18ac959
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 07:31:18.0904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVJdI7TqMu/1ajRf4wdMO3O8AHU/Heel1RnV2SuQIP7GAdAkxaYVUk0L1/Rh2JY4/deeZqr6pEzbdYeFtB1GZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7286

On Thu, May 14, 2026 at 10:32:38AM +0800, Chen Pei wrote:
> On some platforms (e.g., RISC-V and ARM64) that use the generic
> pci_acpi_scan_root() implementation, cxl_acpi_probe may run before
> acpi_pci_root driver has bound to ACPI0016 (CXL host bridge) devices.
> In this case, acpi_pci_find_root() returns NULL, causing
> to_cxl_host_bridge() to skip the device silently. This results in
> incomplete CXL port enumeration on first boot.
> 
> Fix this by detecting the case where an ACPI0016 device exists but its
> PCI root bridge is not yet ready, and returning -EPROBE_DEFER to trigger
> a deferred probe retry.
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  drivers/cxl/acpi.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>

Hi Chen Pei,

Thanks for the patch.
I have a few questions and suggestions regarding to your changes.

First of all I would like in which scenario did you encounter the bug?
Any specific CONFIG options and the devices ? what's the error log ?

It would be nice if you can attach it for us. 

> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 127537628817..9952d0cff903 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -631,8 +631,21 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	struct acpi_pci_root *pci_root;
>  	struct cxl_port *root_port = arg;
>  	struct device *host = root_port->dev.parent;
> -	struct acpi_device *hb = to_cxl_host_bridge(host, match);
> +	struct acpi_device *adev = to_acpi_device(match);
> +	struct acpi_device *hb;
>  
> +	/*
> +	 * If this is an ACPI0016 device but acpi_pci_find_root() hasn't
> +	 * found the PCI root yet (driver not probed), defer the probe
> +	 * to allow acpi_pci_root to bind first.
> +	 */
> +	if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0 &&
> +	    !acpi_pci_find_root(adev->handle)) {
> +		dev_dbg(host, "deferring probe, ACPI0016 PCI root not ready\n");
> +		return -EPROBE_DEFER;
> +	}

What about strncpy() here since we already know we're comparing against "ACPI0016" ?
At the same time, why not just use "acpi_dev_hid_match()" ? it's widely used across
numerous files.

> +
> +	hb = to_cxl_host_bridge(host, match);
>  	if (!hb)
>  		return 0;
>  
> @@ -688,7 +701,8 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  {
>  	struct cxl_port *root_port = arg;
>  	struct device *host = root_port->dev.parent;
> -	struct acpi_device *hb = to_cxl_host_bridge(host, match);
> +	struct acpi_device *adev = to_acpi_device(match);
> +	struct acpi_device *hb;
>  	struct acpi_pci_root *pci_root;
>  	struct cxl_dport *dport;
>  	struct cxl_port *port;
> @@ -697,6 +711,14 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	resource_size_t component_reg_phys;
>  	int rc;
>  
> +	/* Same deferral check as in add_host_bridge_dport() */
> +	if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0 &&
> +	    !acpi_pci_find_root(adev->handle)) {
> +		dev_dbg(host, "deferring probe, ACPI0016 PCI root not ready\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	hb = to_cxl_host_bridge(host, match);
>  	if (!hb)
>  		return 0;
>  
> -- 
> 2.50.1
> 
> 

These 2 checks are basically the same, can we put it in a static inline helper or
a macro if possible? something like the following might be better

```
static int cxl_acpi_defer_host_bridge(struct device *host,
				      struct acpi_device *adev)
{
	if (acpi_dev_hid_match(adev, "ACPI0016") &&
	    !acpi_pci_find_root(adev->handle)) {
		dev_dbg(host, "deferring probe, ACPI0016 PCI root not ready\n");
		return -EPROBE_DEFER;
	}
	return 0;
}
```
and use it in your code like

```
int rc = cxl_acpi_defer_host_bridge(host, adev);
if (rc)
	return rc;
```


Last but not least, have you run the kselftests of CXL ? some mock bridges
are platform devices, not ACPI devices, you are using "to_acpi_device(match)", this
is not a safe runtime check when "match" is a platform_device, the code will read the memory
layout wrongly.


Best regards,
Richard Cheng.


