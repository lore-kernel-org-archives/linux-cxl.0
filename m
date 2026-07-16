Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013004.outbound.protection.outlook.com [40.107.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826B537F8A5
	for <linux-cxl@vger.kernel.org>; Thu, 16 Jul 2026 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191547; cv=fail; b=nu4DRdd9ad+bN5VyWnLp5DcP512K58mGkhiQmNprHX9PE38DAGzVfdosOBBHIl6hhTDqWwPsSILZLWtok/HADxFTzg9Ypd09U0CCUhpowRX8tW+GbSbOPMbuZXjqpXZ4aI71+FSDjln4gUVlQZ1uS7xJm25nxGL0iPiBv1KrlSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191547; c=relaxed/simple;
	bh=cR+ekDhuz88SwuBivcix4qf+uvASfBefWU4IlSKncCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aRiS61isDmrGvXAH03iX7aG7f5MGFM0YINArPT/Q9s9n9pvufEIEnmluy7M1xIgxKR0XRS4VkEbZnSEOT665cVR3y3Fu1sh97IdoDpu4jNSE4HmK845barGKpCF1VfhFw6fZGJuU5N9VhnpMfGzHKNcN1KR1U2difahJVPYHO6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ikuQrUtA; arc=fail smtp.client-ip=40.107.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ikuQrUtA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IC60JClaFVytvn7yLS8t35DN8tS9W+ZhbdgJXaHQlacUk2xuMOlX8dIH2WZaIvW14KfFJSR3gKIh82va2Mc+lRvsH2LAX3O025t0t3DPYDQDP8qdusuPqGearuHWRaFXJgso5RRKiQ+5MIs+8RnOQ82JSN4lx5CCKhRQgZmLY3+bwxmlhjSQkXToYgkM/P3jesNnP4eRc/7DTBzfFmFzNhL+lpJ82Z76fuxOl3EZN/gV+MgdUTduDuBJ4fnf7GqiwpvH857j2GHolaHWK+mwIpWvNiq/JP4VU9L9QU05juibNZNvRv+eNcvuVE2nAp3AyymUktSE9qk0XBQUf+yDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2axD5md1Acn+soOTDR9bPugil55Sx7P6Mm22woMAts=;
 b=BeF5heqrCz5YppO9DxNUpv/Mh5oI8s3llkUfv4kZjolTdDvxcVIt/juepAj5F+qQ6f3btpLSZGqAVq/V+refHD01LGwGk5GOpDPIDb/F9rY9nEAQfMmxgl/lgibFjZe+08IsACZ0r/yLwnzXqc4xirqnkKf3LXTCjtv5TN/neb8m3fPHugpQj+AiR1gxcQkhLko50liCdxHPZLd01KXu3I6ThQ/r1/NwIlIoIVSDi+EDX6/Grk5rgsXWocuoiaC6iWYIKogcEwI+MVNcPOfs7uAUuVS6ms06UYXz+yFA4EPQDhTg6M5+GFfnp3wN51M9Cl7m81+lXdVCqtMtcJ1iRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2axD5md1Acn+soOTDR9bPugil55Sx7P6Mm22woMAts=;
 b=ikuQrUtA7TrcHLl1PUWWfBuXMqu1Wpe2VagUZezT9BSkf+R6KCeUEomwDJvILNa2HQQzFfp0vHGoHZ8ZJvVTxLGLM+dJ/Dt1Rz/UKFyvC6duvLNNG5nXSIUUftvJHY8ZwrGUo6s8OWmuRFm24VqULYZ18OyM38GA0acsMc/thEYAU03AjOo5qLwBrniD56+SUyNiXfbMawxgS27ekXP1p4DwUrHIs/9Fv2D5aID7PtCuDs+U+CyK6c0hd/zuffVCLLO44nVrFH1awCTrDMPj2rU+U8c6wRJ/mtnL1PAFj5iMQhBhXMduz8oyV80pJU4bZ65welGnRzGyA/GbE+WWag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS4PR12MB9796.namprd12.prod.outlook.com (2603:10b6:8:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 08:45:43 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 08:45:43 +0000
Date: Thu, 16 Jul 2026 16:45:37 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org, 
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: Re: [PATCH v2 2/3] cxl/hdm: Make switch decoder target parsing
 endian-safe
Message-ID: <aliaC8nyFGjtJ7vo@MWDK4CY14F>
References: <cover.1784150131.git.alison.schofield@intel.com>
 <5c7d0e84f2397764e7dac2e12ecb6cdaf47fcb0a.1784150131.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7d0e84f2397764e7dac2e12ecb6cdaf47fcb0a.1784150131.git.alison.schofield@intel.com>
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS4PR12MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: d3bc3189-59cf-452d-ea45-08dee3169eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|4143699003|10067099003|56012099006|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	hl2TfEb7Zbqz7e6ZHHKjPTGDzLNglp0e+7kg0EmQWrEyJOBuOZG3YEcz+4g/y7UeU1hK6lzWVD3uR7qNhHLrPmljMnKKZ9YN57s1n8SssDPZQ4NCxZ2t607xWhco4K3AEkbowR9qYHugnImXjL/O4+RnRm0bWTzhlFxqAUCKIZpHXqJTlHLi5vl8dKCxyiiSz92i0Pk3GGHLTl1KYX3By8sGRHZjOOsQK5hVDr1LMhhNVMXOZkKpDKmkX3hk4VUL0FT11a0TKoBsX88hV6FB23lriX1kmufY8Mm4JvClNDTcpLX81EWa6EA2023cLAIOPU4Vyxt/t1PGzx0VPM1yH/1R8siPgmpQAElUCQQNCq1Q63vCg99y2Z5HCyImvzmspbwKGtqLwsoimDDv3eHcouKC+SCjp2ZsnHX8eTW9NKagV+PP6IZxQYMxR7J6lBhrBhCjVXlivbeDV1pYhsrZgmbKzVMcTZHLDXVZaGjFV7iwRbIKt1JYq1NN0XT415dYMuT4vTJT8vO7LuyQiVwWT3cpIUMHRG+rlNY8eN9tr/h5k/NnNp7tzn08EPiiLtKbl4qjDGKNTFB6ro0sSiUM30C6N8q8GUu9XAgTK+lReHAskgZmah839at1RIcSWmAJ8/PwHFCrWmcZ8G6dQ1rWSewKqETaWCuKdfGrxEDrobo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(10067099003)(56012099006)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/xyZG6IkN5eyxqd5oou06gu8Hf0uuhF+IEGup2n45WiB/KLkw50C1FA4bSD?=
 =?us-ascii?Q?T5vuC5cgmkkcPuSp2ADZTSBCgiNhy6IWU3efNH4dvTWX+G4lwWqdJLyVoigE?=
 =?us-ascii?Q?OME6X1QWyq1PZMehUnUMKvzHHp4Vx/0FJRNAvGVv2fwTHEeFLYGWC4lJVkoZ?=
 =?us-ascii?Q?FxoBK8Hp0qDtx1MOJQsMvWWVkVEBLrivqinuOOPIojp+mGT9Yd6M0mqiGjAF?=
 =?us-ascii?Q?7B6SqPrrDUj8jal+wdxbdkhChCq8js/HbA+Wn+pgS5fuJT/J9Gax3hzAcbHi?=
 =?us-ascii?Q?psR9oD/JpHmrkvHpZa7iCqW+tyoSxifJMZxL2bfRx1vhFa28Shx+4qXjH3cy?=
 =?us-ascii?Q?aqxN0UyhatjL27GshiKAupq5bZmji6YVRUtvW3NdqIWcCjB2obpT4vSmhIRI?=
 =?us-ascii?Q?Bh6wwZebQ2N2UbuYql+zoFP2D6+phAhUReGeOSvcPyu1/E3t8tbPfkRt9Q7A?=
 =?us-ascii?Q?c2LVLwtmGZpM3iRlMcl4/eK5Q7xj2MY9ksvQ37iUbIUnnxxN4hln5HaFanH8?=
 =?us-ascii?Q?a7hPUY4PKG233BUG8+jrunlqMAq/KxgiDDvCGDYwwFDJt9y1VTBVPEZLJU/q?=
 =?us-ascii?Q?Z20VwzGwU3bogyYUb7AUqM/JsN8FM5ThL4zwWPLa1+3CFrj+gqllY8e3JEXI?=
 =?us-ascii?Q?EMW7VPKUO4gzEVOiSQh2mYQpK9dC5V1fZMPuzKG8QEz9e12fF/M3GJPJ+G78?=
 =?us-ascii?Q?lnW/xt1ISvZj3FkcOsV53MQEZKjdrDSc4uOXYOE1c5sugP3HZUl8c1gJEY2Y?=
 =?us-ascii?Q?ZQr3d8Lt0cdQLSyGd6pnKS/5y/K/2Ti6vN9XNtrK7JjXSb8ZByA6EVcU5kiE?=
 =?us-ascii?Q?jS+/F3y8GddXKAZHplxs533EX4TVIK56Pl8QHHNM/8PEQn0Xb3qoHnLJ5fl/?=
 =?us-ascii?Q?8mHWh7dCKwEnzmyjnFAaf8VFYI640u4cRJdppOCIlctev4CgeUVFVcIehgFc?=
 =?us-ascii?Q?OyGBmUCgSRvkr+renCvk4Tg4LgiEgPTyP/x4QOq19qqnjQzn9pneiqAmButR?=
 =?us-ascii?Q?5yhAD6A5fiJwJOp8RN82glfWiV3T073CV6iiyQAzD9vWAZO/2a2c3uij3Zsy?=
 =?us-ascii?Q?AngHDvWbTEvMK8L1t7g7+D/dS3hE/SBeVQIhLh5fezsgPLhxgmoe/N2RGkF3?=
 =?us-ascii?Q?LZL3cOuJ39dW+TJazAXHv2BVa+GygJZl32ZKcDo/fLDx+P9N1jh7BTj6mOR+?=
 =?us-ascii?Q?don0s1zyk6y4tRmWcbTdDwPASZFhq+Wb7fJVzLAfVC6JtlMBAW4h2iAop3c6?=
 =?us-ascii?Q?TyrbEfiQ8Y2k3BnJi4BZxrrSt4dwbjxDEugDfrfydQLeQvugIaiSE79OyWf9?=
 =?us-ascii?Q?mRyQGEhF9/WQc+81r19zpIV/HIyQbzj33NzsPBVVPq1rF3x+bWxt+CYeqGTW?=
 =?us-ascii?Q?+Z9h45gG0xLR9EMkWpLGELJk1ISUpxmwtUjcIMerFryGtCY20l+wb8TpWQ36?=
 =?us-ascii?Q?ot2Ic+5NC7Zjeh8E7DESLEUdCrusN5iIVJ/EYRFb0H64jWJOfDqbR/QxBWyL?=
 =?us-ascii?Q?eDe7FPgxOfviERkBIAQ9vRCy0ccN7+yHxbbTDUrmWaMraD8xHrFJco8O4aIF?=
 =?us-ascii?Q?JjUA+XCZVV7Qfbz577tGGUgK9ciAGnUBmniV04I9fCRBXQM3N/uouqhelnIq?=
 =?us-ascii?Q?UwYxJlaLVy9uGHnxf9vYVmY5xncB8fzjXL4WoxUfXAqO0nc/kntshAS7bjny?=
 =?us-ascii?Q?Ig61wo6hPRwJlBE3aYBTeBavMyWCtm0fIHjakZyUBYs3k4JC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bc3189-59cf-452d-ea45-08dee3169eba
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:45:43.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qw77AM5bzf3wZW+COhM1saqLNTya8L332wIJmzlNmIMjtgqJJpiIbMcRgSpPkDHXIfFKj32PSqh7wCVjFZfDiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9796

On Wed, Jul 15, 2026 at 02:45:48PM +0800, Alison Schofield wrote:
> Switch decoder target IDs are stored one per byte, starting with target
> 0 in the least significant byte. The current code accesses those bytes
> in memory order, which only matches register order on little-endian
> hosts.
> 
> On big-endian hosts, the target IDs are reversed and the decoder is
> associated with the wrong downstream ports.
> 
> Extract each target ID from the register value with an explicit shift
> and mask so the target mapping is independent of host endianness.
> 
> Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/hdm.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 9f005f3193e2..51ab154a73fe 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -976,14 +976,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  {
>  	struct cxl_endpoint_decoder *cxled = NULL;
>  	u64 size, base, skip, dpa_size, lo, hi;
> +	u64 target_list;
>  	bool committed;
>  	u32 remainder;
>  	int i, rc;
>  	u32 ctrl;
> -	union {
> -		u64 value;
> -		unsigned char target_id[8];
> -	} target_list;
>  
>  	if (should_emulate_decoders(info))
>  		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
> @@ -1112,9 +1109,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  
>  		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> -		target_list.value = (hi << 32) + lo;
> +		target_list = (hi << 32) + lo;
>  		for (i = 0; i < cxld->interleave_ways; i++)
> -			cxld->target_map[i] = target_list.target_id[i];
> +			cxld->target_map[i] = (target_list >> (i * 8)) & 0xff;
>  
>  		return 0;
>  	}
> -- 
> 2.37.3
> 
>

Hi Alison,

This is a good catch,

LGTM,

Reviewed-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng. 
