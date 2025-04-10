Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF98276057;
	Thu, 10 Apr 2025 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744281131; cv=fail; b=MVFYxsbBytQOA5tJIwebNVpVviBAYEjDHwX3QLXROxkHKkIbSJY8m3DIrKG9ShjH8kjB9uZqR20qxkqZ037SStKM4F3Bmb0Jp70Ry68jT1aCVWwIY456hQuWRfPZzBhhnVBFzXBuB1cEr849AX0IVcqRDvoT8udoQ6960VBGOqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744281131; c=relaxed/simple;
	bh=zbCOdAnaUcQxBAS/YxP1Yyat2bHT4BOaQyvTDcw/OU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lDcKgKSEhAXz/1DybHWrr4b4/moWVfxihrLJ4YvC6AI2gJZFQ2TcCDG8OowmAmh9TJD/sFAFpkLCq7E0w6envHgFjBoLiaQTrvjPQReGtQ1RHjFxnSbfls5Ogy8U8X/mWaW/XY9Gs7mo9cr3KlUkV305tF9rdbKDQZ24iguRPgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LE+xV1Fx; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LE+xV1Fx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQDTKRTGZA2kfqWR1hgkWKyvKjvh17P7nQEaJu6IchKxVKVIJfilaPbh3VEj9AM9BiTnOKj9UpMDtsdre4CGcMHCdEiuUa0IC0Cibvu6QEGmukfC0bDi6RC4uq5TcQ62avg5oBjA4J1Q9pnLibDsNRztuElHc4tYARbFR/+mTyW5wqZZPFjdSkMMa33AawegxYnJPSCPqazcQuVnk4rceJ7hnk2DBKcV8gW8mZPfpI2yYoqFNR5Yk7Wm01YgF9uMw5Hntq5uwR7cpXJCZSA9ouBiT3PppLVFn/iFKVohmFDvarIyrI/sPIfXIiF5ZiuIs9bSTi23Sm9//8YumRBT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtIPNEcBtdA8W+1n5SLW48EPd7piLpeiUF+UuBXieaU=;
 b=dfTIG+je0bUB97RQMaTmF5/eDFqPyS1ifbLD+4/1ApwLOb1CPeCYqI/s+rafk5nESz13Z6Sm5K1mcxjjZLAdhM6hUJJ025vMbTw5kJXWaYm3YQg/4HF75MsAbaER66hxANtlDHRLP/LK2rWcazzNNzxbiNS1hJYLxgfGrzaz2V6ndoD+7r39KwvTfDHk+dc1wCSwhdtytphwgQ6f/eodRkcI+613x0j/yTX7DiLjqWwpjOJwOKie4xFctmTaFr65tskaPfYHyZQN0LzgRvUiVNAR+nsPuaokpDZYWf/9IHYfSyicpJc+OFgHHIdU6hhBnHe1eBCb7VHmwrbaOLjZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtIPNEcBtdA8W+1n5SLW48EPd7piLpeiUF+UuBXieaU=;
 b=LE+xV1Fx1QswoB09gEhBE3lUnQLt1Sv8dJBP2j+52ctT+EA77fjOaKa5BDqGYIsL57xua1nsRI3epIu1wc9gGj8kV/aDGozSWMVt5fFHG0nrsNQ2q2kY8AIp+199qWNEawDFzs196o1VRUm0l+TxDSLHh/R8xDKY0nfCDZ1/nB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Thu, 10 Apr
 2025 10:32:05 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%7]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 10:32:05 +0000
Date: Thu, 10 Apr 2025 12:31:59 +0200
From: Robert Richter <rrichter@amd.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH] cxl/core/regs.c: Skip Memory Space Enable check for RCD
 and RCH Ports
Message-ID: <Z_eeH-YCh5A05nZV@rric.localdomain>
References: <20250407192734.70631-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407192734.70631-1-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: FR4P281CA0423.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::13) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: a0174f31-2fc7-4e8c-ce67-08dd781af021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MhDYbzxADWTAaDq2t1HvygVxXkSBAe9I883z/46kx/bTw1TM0UIpFzy39iMs?=
 =?us-ascii?Q?w650AQg2PEWPthg+LAUqBFi/9XfPAToYrTYyOuaYwyDUk1dT1WpDZT/Atf0w?=
 =?us-ascii?Q?t9gbfhArzaUUZSvP6urcphn7EPPpqv4UKyliaJynzqFg7Q5EyiKRjOwi9nxa?=
 =?us-ascii?Q?CHJC4kcBOoGeNMuDvnfaPiU0WaVEUnJvB/QY+h3BPZhOA73rqH9Ahtg9Fs2m?=
 =?us-ascii?Q?HlReh/5+14FHWJV5tguFlUBGVxkY6AlsWZQOt14Paqi+VIg0807rzUecY6RA?=
 =?us-ascii?Q?245vOsNSzoNEQn4knDyQu/JK1++QuVuPAhiDStPp0LKPQ8/TB6S8zmxs+sWH?=
 =?us-ascii?Q?xWlpBwAPlbRR75WpxwHsH7Bm1Oe5X1rdUyAZKFjHESiZFuiiLqvtMfMEdg43?=
 =?us-ascii?Q?PRTM2DxJxH1vARNvW7JYKcUBG7Vj0Z6YdPdrfwd//ibXJjztX0LoqQ+M+BOZ?=
 =?us-ascii?Q?pWam29HMuBIEHg8s0TLfgIeHL3nzHGGbvWjLqvo/MZKyyV/rTWI8YhEK9ADt?=
 =?us-ascii?Q?FkRVOxqTXnp9SbvlXZOvm4WDhxyjChRfZo8KzdCm4ReiaefxTfMdlT2xkQ9V?=
 =?us-ascii?Q?Z2oFqHzludTGc/ECDhvdx7XfGZALyv2ioABqjT2RC3v3oAIlPKVId2bKI9Sg?=
 =?us-ascii?Q?3HEZQzLyyyGAaeboOqyaDGQMQaW/jFCWHTsH8w8WBnCFrj0kRFezYMH4LCDu?=
 =?us-ascii?Q?oPFQ1/ZGm4RSaKL+qVK8vqbT3LgGaH5JelMx1qZMw2o/ABtv1cx5va4/Ci1e?=
 =?us-ascii?Q?jktjiJHBznkSU7cz039epVRVQrAAWCv1pFtstBKpkiw0uMkamMxYOLBOUAma?=
 =?us-ascii?Q?5JPq5WKjSrlPhssgrH8cwlYeU450jZlNzsUQTH695ovY+V/JmJxXYgRsqP5T?=
 =?us-ascii?Q?tWDCDXLLcOgIYwpIctimeTZe1egxR4aAFy4CChcKzakI0vGi4uq/cjgjB0bK?=
 =?us-ascii?Q?vaaSoj4KtGtuemj/odpQuTV86GEXzrPJSx+OIFZnwH2Kdo6i9++3MdZI6hsE?=
 =?us-ascii?Q?FotMsfVtiqk7YJq9DkU2i2mIkKewKYzAmS7Sv9uWJO0WdB24IIz+jLI6xkg1?=
 =?us-ascii?Q?KEvYKdsM3yNLIQpXXRL6Oo2sX2c5tQh9xLuLSIil7rZCiLKiRA1ITBYsvGzE?=
 =?us-ascii?Q?5iSnjPL1w7dmh6bWM5mBoOiN3IekYh2D0N3UqDakVbK+iYD7/TLVaocpoTpN?=
 =?us-ascii?Q?JuHAdvtprn1WWgo6FhSjnTrEw67uQtEv1z91kQxzIplQZBYDTtp0/mZ3OS4z?=
 =?us-ascii?Q?ggKOkAhATvNXIy6Z+EEQmy0sGjjVPcp4Fs9ul4NgCtwRliMhPQSeNfdban4b?=
 =?us-ascii?Q?Wybbq08WU5tHedc9LQTARCVB3VhU65OIY5oxJ2QkQY9el800Zjuf1IlyNuOq?=
 =?us-ascii?Q?MW99AvpUzPPsS/FSkA2KYjQew1hO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ui/BdnOMjhZC40qZCNFTvf6S/ubqkeFfeS4GxsaLY6c1gL+hb1hijdct2e64?=
 =?us-ascii?Q?MqWb38NelurCG1VjcC6Z1a/TVGA0QR5KfTDkYhGwLoIlQQTIuuiyIMhORY29?=
 =?us-ascii?Q?btSeu0lwneA0FHwflX9+dchUWyJRBpOGEp14XznGj9VNmWR5CBmhZzNJLQBF?=
 =?us-ascii?Q?yHbi0otXrOh4Rt8bH1BRfV6km8xpar77/lhx5G3XZbJrQ1wx63qp7JHng5JE?=
 =?us-ascii?Q?aOyyNXHCBs/Ol5haj7Ey581It7OeOKaj/kXrIQi03pmOp/vdmlri9Ejsjln9?=
 =?us-ascii?Q?NOkOqV5IQsJDK5wA8Rynih/6NZIBhR9R4JfF/wMyspCiOr72hyP0A39gb0kj?=
 =?us-ascii?Q?vDjN2ArC75Qx3QSFOM6wndNrEluRgEMMbiZWKEiHYHiIu52Qbbi8+i335IaT?=
 =?us-ascii?Q?PxKbXSTbuNz7BxfSJ9KadYcdPpgcfT4fomBbaNMlqFJG8G5Zn+9wu8VjiyM0?=
 =?us-ascii?Q?AzqrMHnioTshdM9Cw0VbWv5CaaMDWQjZcLsOCs8OfKiRaXD/1crwBBxoBx+B?=
 =?us-ascii?Q?xBCfq3vuycBaM0fc3cK9lTkbReCyojfVUCKiJcwjaykpgVc4dPZK+N4PTyZX?=
 =?us-ascii?Q?1qkFiMWzNUjtdnLga7qh9dt2/sqgswkastmNK0v4QPf9LzFPX7pXG+Rhiug8?=
 =?us-ascii?Q?Tj+9Z5sVS8YCprh7VxainSmaKkM8Nwwk9OIKzqMLFArOikLmbeX8/F/C5zrB?=
 =?us-ascii?Q?ll344A3beA2OTItl0+4b9B3pJZjkn98IrYnDFVGJuCd/bx+/QbX0w/c469ww?=
 =?us-ascii?Q?OuijJsCgargu/bIa+J2bxGCdYrDZ+hSWF5bUzJuxNnq9Bms2LsPMWd5OulJy?=
 =?us-ascii?Q?0uLkwRNF4zKpDbvTk2HPMHLHH4bG+5T2/rKC17gv7Hjm4gG2zvU50cbkUAiP?=
 =?us-ascii?Q?8AwqoE0I1F0nXITq+PRgERVz44rj+C70ocD9h4rJSx6TW4UR7BgYqC2Atoq7?=
 =?us-ascii?Q?pe1JHNSVrdAM8MDGfIDbOx9QYYOvTSSB+KQ1nkPgbl3Y4CeYS4BHn+jBi5KQ?=
 =?us-ascii?Q?6N4fO+Pj9Mn7LegwMB9z3L4Ey/9mrvBQ/hrC0YHo+xSQUZsEV9+LG80bzf/h?=
 =?us-ascii?Q?pLuWar1dVvX2mQC0Ch2i1MlifNZ7vNaDGPKrmDtN206Uxn/x830O5bs8UKU7?=
 =?us-ascii?Q?JQCncJMl91l9cWcRl4qh1YE+7t4duMFi16S/RKJ5cUgzImhZK5oaxVh6Q+0H?=
 =?us-ascii?Q?LbJ5ldXcQLOjPCWryGm9YODyXfTSFmO2qrO+SfYoteixuHIhupBh5BqNdruu?=
 =?us-ascii?Q?L4WAmetIN+2v/Vq3u+/WM0UFz7XdBK3+tpVIDOiRCSa3RzI4DxDqeZkOs9oI?=
 =?us-ascii?Q?8D6bIDyQKTBlrSt01nJpUTgtolFfSeYQQTbdCRMF4bl9bCdqKJPDGbku32ak?=
 =?us-ascii?Q?i1uUznqKjdi5JFfUHx2vKvZjmBdzqlFB09JtA5Lydsz7K4ytwfLhSH8EJQRw?=
 =?us-ascii?Q?caJG8MbtZOHjZ4KCu5fvunFd8VNwDAwkl5lyY3uF/IZrv5sYqH9E+3SkpV2m?=
 =?us-ascii?Q?1heJYNyvokzQI9P/iUr0VHaVxkgiz8Y+b6A38icdhtyP7NLbajZJ4OnHwtir?=
 =?us-ascii?Q?N6EoGY4Tby3kL+c4N6Rp9krgn0QTIgfr03QbDGgw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0174f31-2fc7-4e8c-ce67-08dd781af021
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 10:32:05.5213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGbnzAgCjJf6zldRcYAled16CpAmPuBi1y7QRIab+/a636EmIWdei+uU5LM09n6+XHcL+2oXKiy0FP0sXWB5Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384

On 07.04.25 19:27:34, Smita Koralahalli wrote:
> According to CXL r3.2 section 8.2.1.2, the PCI_COMMAND register fields,
> including Memory Space Enable bit, have no effect on the behavior of an
> RCD Upstream Port. Retaining this check may incorrectly cause
> cxl_pci_probe() to fail on a valid RCD upstream Port.
> 
> While the specification is explicit only for RCD Upstream Ports, this
> check is solely for accessing the RCRB, which is always mapped through
> memory space. Therefore, its safe to remove the check entirely. In
> practice, firmware reliably enables the Memory Space Enable bit for
> RCH Downstream Ports and no failures have been observed.
> 
> Removing the check simplifies the code and avoids unnecessary
> special-casing, while relying on BIOS/firmware to configure devices
> correctly. Moreover, any failures due to inaccessible RCRB regions
> will still be caught either in __rcrb_to_component() or while
> parsing the component register block.
> 
> The following failure was observed in dmesg when the check was present:
> 	cxl_pci 0000:7f:00.0: No component registers (-6)
> 
> Fixes: d5b1a27143cb ("cxl/acpi: Extract component registers of restricted hosts from RCRB")
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Reviewed-by: Robert Richter <rrichter@amd.com>

Thanks Smita.

> ---
>  drivers/cxl/core/regs.c | 4 ----
>  1 file changed, 4 deletions(-)
