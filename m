Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CBC3FD4;
	Wed, 23 Oct 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686405; cv=fail; b=Bl1zws0jigh0CoZhAdy+TubL+12Wytxri0ol2lkxh6XAxDFYYjNvtVfAayjckftY3bLMkV486eVA9k0M8UMlr32tAeouSYmyegvrXlqiCIVId9+BT8TPFpLgZXOMYniD0SLOE4Dh2xYBinA+KuKxJerZrbIyO+eMrbSCm8nNlvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686405; c=relaxed/simple;
	bh=envY3lnlRqqtCUKbs5CtWG2h+p+iyi1zYlUxChx4Fz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M9HIOGLuCIvmG8QxPuX5LAvYqmC8YW8WXLVT70ERdluheLWUb4p+BIvuNKJnVOXDyge0AUdBSFvxvLJgh7Hzz49oRYS2eTGh+SIJTJi1JNcPeWsdFEdj1muDbnKRDXe1h6R26OjUPhT/PKh/NC1TgQ8UROJkVD+HvFm65uGXJEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N5QeDUvG; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N5QeDUvG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1AhmJfJKrf/tkT4RXKtYy+CZsA8muFo2KQXWudZ9a8SBYnr+CMFCf/BJ9Oqbg4A0kO7SPDWDn8qLUvP/XN39nPuDEkahI96oH+fes+QLO2Jy95fKyhRK3CwVb6xl/kgqmKRRgtjXeLJX5ItegpgDDtmMVePdhLDrhNeImnWziOoP7HGsTkWk3zqX4EaXgD4SF1wWbCGb9OsWUpzAFL2S1NhIjCob7WE5jlbEv9DO7NyRfw2Rmia3oNI9+SzZhkphCCxoGBmVnFdIfvN4uJ30rTMXKFwkKwoYqbown3cd3vNSqmzmkfMsxOfkj6ICeCRX0WwzWr6fWzozNqqhcLWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GNrm/dgEkXIUQnUwg+A3ceP6l8iTOWK1UzSPKNBZNM=;
 b=zRhhJSGPsvYea/18mIPRhlpyuI7rwbl3RUVO76kTVA1TcQnE4tTGSQA3S6x3sbtuwF3Pxt7kecnr8nj1KFdZ4+adQ+OHFGX2vOEnL+31ZgcrZhjaBYpcMgnaXXqTL7gyIHOVh9rJDWOIRzbq3pFGsGFxZhqoOWDIprWfbcEnb/3iSLuE8ovH/36IpDWSVqyx8O+8KJl7ZO+Q+XFEew6HESYNUEKEAY0pJAFZ+XRXUUg3EIOIDh37krpvBLOvKpnPr0OPulZCOEo/1T6JoOi6dTzoIkDc/PowylA9m3IwQ6WovukAITWUXLlt3xHdVp/m/ucFg7W1m0i/Qgn4YUkgWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GNrm/dgEkXIUQnUwg+A3ceP6l8iTOWK1UzSPKNBZNM=;
 b=N5QeDUvG1eEDn6EsZYs5GE60kucwpL6pZ6ObI7kE75INf5qkCADk2pFb7uuoGPdy1Njhuc0XCtkb+wrlukGLAJIjYLb5IDcxDcQZCUi0+a/KwTfXuRW+bOJd0F45MTMAzrqQV9qotKk4bNEFKkvVum92q+k7a30xByQ0WP628oc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 12:26:39 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8048.018; Wed, 23 Oct 2024
 12:26:39 +0000
Date: Wed, 23 Oct 2024 14:26:32 +0200
From: Robert Richter <rrichter@amd.com>
To: Zicheng Qu <quzicheng@huawei.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	tanghui20@huawei.com, zhangqiao22@huawei.com,
	judy.chenhui@huawei.com
Subject: Re: [PATCH] cxl: core-pmu: Fix the usage of uninitialized variable
Message-ID: <ZxjreAV-re-rfJsv@rric.localdomain>
References: <20241023105610.668964-1-quzicheng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023105610.668964-1-quzicheng@huawei.com>
X-ClientProxiedBy: FR4P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::15) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fdbe8c2-6f3a-45a6-ca43-08dcf35df1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7AP8tR4StxtgJ/9cJS/xsBtAfQ03IAXBU5ut+hB3Ervo1E2tbKBYMFQdhmEo?=
 =?us-ascii?Q?EHU9BCEiTiwZ0F/rLuWajTYX3aWjRKMDNHXd/nh2PlAbO5z9VAHvlPcVBg7x?=
 =?us-ascii?Q?cEu7NJxyusaLHH33eInQuCnuby6JtRCbVq2oWYINCWp7BOHo4qugl5on+q1Z?=
 =?us-ascii?Q?1PvXWQdDiHiGP3nidEDBBLfZQB2NTQDfvTveoye0dK5Do0RGjdNTAaXtKyTd?=
 =?us-ascii?Q?jYZR8MgGD6v/7Jw8G96vMxhynT8ZkFrdBEDUw+P6qACxZy3toL5052IvUKXi?=
 =?us-ascii?Q?AP61aQ45gN6CNJFjxGbwBWBSgrwm0Gjjc3Hii6CSaFeP2JGoEJQjVAi09Qi4?=
 =?us-ascii?Q?HJo9t+9nZK+0WPeH/Mi6Yblxr19nzrC+YleX2aeKBXkuBUGQBWXX/dtwFfZk?=
 =?us-ascii?Q?qQUQhkGt7LP4+J3hPSRw4xvAd7E5Vw4FaMdxF0lXgLmv5j9TPYRMl5Yy7Str?=
 =?us-ascii?Q?zmpxr8tYrjbvBUA5sjj2ZMqC/Cn3a6zzgSWfh3/9s8jjYcU7QOhnUSJ6CdcE?=
 =?us-ascii?Q?FgYaz7RNjwv5Ew9eKvcpeQcOfkypa2D8Ucz65lELcfmM4sfcPVztw385jJW7?=
 =?us-ascii?Q?kwc9VoS7eipxq4pcWirlP4VO8Xj7ThK5OIKh0MlpravwHPOXk6I5SqQ2Bk5P?=
 =?us-ascii?Q?7GvwEThVAM2h34TrvKUZA8os98Bd4yJFW8LXlIDk3Jme/OP+/BDr0EnCUSDE?=
 =?us-ascii?Q?LZaDjWog9VO53REANg/slS85RSeeitubkSWE51uQlTJSUFVjxSZRg8QWOu0a?=
 =?us-ascii?Q?u3aC/e8LKUZEqftdAxUGKQ/FV5waWQBMtBTvPT2OdpFyagmHwO3UO+m374Vf?=
 =?us-ascii?Q?Ahhle8raAHiEWsXgLOitF0PfSvTla1tIJFi/SI1tnk/O70KmzzUZUmBx5C3R?=
 =?us-ascii?Q?wuE/Kh4JNemyLXLygfAdxm80Kc+MA1kwkQ4CW/l8GHbMvlFXODzWAHKIjInJ?=
 =?us-ascii?Q?6gDk5gQuD4XH028+ec5VTztydaTMA+9PO1LQXBrwZrjmlNzlWnKBtASEfuoJ?=
 =?us-ascii?Q?JvoV4FOV5H5UK96WyqyuDI3JkBGURl1l1TFG+ifHppFBq8m9yvi9i6jCCxOH?=
 =?us-ascii?Q?nhISrWUwfZyhrAnOBbuuLI9NwSAjQbK/MKzBOmGCbONMfxgR5Sc4fd171PNC?=
 =?us-ascii?Q?HN05vNPjuxNtEWuSozmTlDv64BrFQgd/4AagL0TWsxARkzNBW6TgJvPHmfo8?=
 =?us-ascii?Q?5ht58p/ZBFt5q4CxLU5qDFU78YMLGtB2wcz08jvvHre+SqdL/RIUc+Da+5XK?=
 =?us-ascii?Q?jV56wUts/CrJEpsJ5Bmkg5o9zjQeXWkDtYK3oy5vY/w60zdCCo2lObXDmuUT?=
 =?us-ascii?Q?yifunT9aYmqu58rf2KLA+Kuj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?21izgYov41IKHpLwGqJqqgNuGIZBoN6wrHZItPkrvDl07pjQFuqUSDthD05c?=
 =?us-ascii?Q?s5i3b4DnKxwsrbgwXi7z6/+yPx7D2faopKpievvuDmdR9CL4kwAU8XFeEvJy?=
 =?us-ascii?Q?vp9/vPTnNiT6tL7jRvuEP0PC29BTKFYfwRD+FjpJAgyvVcUGzpo8JVazb3K9?=
 =?us-ascii?Q?WljQol0a5qGBf4y24qerh36+v1UfLbaQdkKZFDW2po/PPVEa98LkOecXmsW2?=
 =?us-ascii?Q?SrR45VptMggke1RIbR7rscGNJv/ULyor8clhIRnu4A7ZiKEPDsZwkAGGHbCq?=
 =?us-ascii?Q?smsz7OlAiG2wYOaj8cIMj2W+kfJFqclZmDFwoGAqaGBEn8lR5HGwxx/KhvWk?=
 =?us-ascii?Q?yuTVgmt64BA8HfdgiAo89FNQeq5hGPwUNAZmtNTgej/anP6VYUfK5b6LMP9g?=
 =?us-ascii?Q?/wQnnH1sNYDHcVKe4kDTMikILSvtXyMrVzb7NJ87z1NIRQ8Hm+cyqeyOzmN2?=
 =?us-ascii?Q?Oetl09cSH2+qwE58DlQoyZHtoCKNrYZRfNDfLCUQnzQ6QnycbcCpm0l7oyQY?=
 =?us-ascii?Q?6tgwRayxze8C8k69ovTrBpUtj4DJ02OKH31jVOjrQH4xfTpLDesR+y3jJWsj?=
 =?us-ascii?Q?5FCqIQPbTqRwbfdyg5gjpjSeW4Gk9YnYzuCTH2w/xaCrHgH74MF3ukG37aFR?=
 =?us-ascii?Q?wMZ6Pi+JbniURYbyFXPeYtl1hpo9W2bHbn1iG+y/SwX5x0i+6m+fZjdgIOTF?=
 =?us-ascii?Q?V/SQYUbWnIfM88jNAIfoxVu6sJPO00UJmDWBDZsr0jLyMvPJQnXxe/RBv4I6?=
 =?us-ascii?Q?lbzvz/idUj3CkffPVmCzYgOHHPBriW26/Rz+scm4yYkTlB0Fqi6VpV3FqvoR?=
 =?us-ascii?Q?+ff/0Hp57O1J4Y/w43MR5WE8BpRSvmy5/y89QI5pJADL6f4vWYVLgwuuanjT?=
 =?us-ascii?Q?uO6xXDH1mrX9igCV/ARxLBOG4+krfnRvxQ7p1i+brn6j5yt3x9V+g8hyBlRP?=
 =?us-ascii?Q?oMOSLZjsueSCwQ8fqTg1tQ2QzAvw3ZlGGjlyi5pkBwFokKtmuMYuFmtzaEGU?=
 =?us-ascii?Q?xfofUmVw69XhEQQ40c4uAJJM950eJ3zeC12STxBnx94RurWwgUAGFU7POXcH?=
 =?us-ascii?Q?CiLcz90r/K5kuFTFgrAh8EVkAhknpg8KEI52H8XuJsARnMPxQ4BvpoU7eLrn?=
 =?us-ascii?Q?qJ1ZaWPFJ8qZ4IM670MFAZyAh/4WKsSjtSYiVA4u8NR/5KljV9X2f7yaa/xM?=
 =?us-ascii?Q?cpw0q0r847ZYZnjPlDD3fuFJFZ0Lv5Uhlx3JB5i2SN/wqDsvMVtkMF2tQGxs?=
 =?us-ascii?Q?odXqlBfhJ573WDnnUaARbI+/gCR8CF6qcxMU6DP9i7sFQle+cefAC/IYzuPk?=
 =?us-ascii?Q?pjbxZC/3ZG4DM3K15PtePMyUFzARrvLw85S700eSFaB7R1R4Bb41FHRgpghC?=
 =?us-ascii?Q?6Le5Erj8U2cbxAdXzOcB3RLzlD4GTRLOBr7tU/h01/gbIvc2jrv1ginIVISj?=
 =?us-ascii?Q?wfJJILfiBK5mg2GtZVkTFamXJWoN/UYlByBc4hGC14jCVTWUZS+zLZok7LqZ?=
 =?us-ascii?Q?NOWBOH1bc8Gs6BYncPVNuxZvOGVTCOO2rOiJmJxadO/mLvFVqdHFv15dLhq1?=
 =?us-ascii?Q?EOjHt43hbzeGX7HNZ7AQU/k2KLxwG0PLTtkc+kQ0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdbe8c2-6f3a-45a6-ca43-08dcf35df1b7
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 12:26:39.4889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GaY5fVV+NQ4/TxIt97K33vlrUu7oYm78tejteZokECOJU1mfChqnX3cf+Psh/ZSUa/BDus3CAmgZTR0vXn0yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992

On 23.10.24 10:56:10, Zicheng Qu wrote:
> In the devm_cxl_pmu_add() function, the variable rc might be
> uninitialized before its first use 'if (rc) goto err', leading
> to undefined behavior since its value depends on the compiler.
> Currently, the switch statement is limited to the CXL_PMU_MEMDEV type.
> If additional types are introduced, it could lead to similar concerns.
> If the type range remains unchanged, using a switch case is unnecessary.
> To enhance code extensibility and stability, it is recommended to
> address this potential aspect.
> 
> Cc: stable@vger.kernel.org # v6.6+
> Fixes: 1ad3f701c399 ("cxl/pci: Find and register CXL PMU devices")
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> ---
>  drivers/cxl/core/pmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/pmu.c b/drivers/cxl/core/pmu.c
> index 5d8e06b0ba6e..2d12887c9915 100644
> --- a/drivers/cxl/core/pmu.c
> +++ b/drivers/cxl/core/pmu.c
> @@ -51,6 +51,9 @@ int devm_cxl_pmu_add(struct device *parent, struct cxl_pmu_regs *regs,
>  	case CXL_PMU_MEMDEV:
>  		rc = dev_set_name(dev, "pmu_mem%d.%d", assoc_id, index);
>  		break;
> +	default:
> +		rc = -EINVAL;
> +		break;

You might consider to use the -ENOENT error code and/or to
preinitialize rc with the error code. The default case can be dropped
then.

However, all those variants look ok:

Reviewed-by: Robert Richter <rrichter@amd.com>

>  	}
>  	if (rc)
>  		goto err;
> -- 
> 2.34.1
> 
