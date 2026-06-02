Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3D6379EDF
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jun 2026 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386199; cv=fail; b=CQoVMgbDzKYc75HsbEfFOBOs0A/GL3iSK0Dw7Fpv0EixMs4V4JLmWBMNmYJqw1mcuVSWU0Zp04BO7Wx+e/pU3Qk0Ap9NitJZBm1xAqTUv/XGLBmiiN0j2yeNRJxxH3ZHQfiUAcwABvnCBEBcTLgJ7AF0BW+lEzoroVFMnDAHohM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386199; c=relaxed/simple;
	bh=6iGEFfMwk19m7Tk79o1bRm8fvmVBjh7tbQlQlOb81mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XmAOWxgu5MhULoo26Vr6TlSezVfNlrJak0CqA4OltVsXxw21BIPXerq1vMb+gD3BL/tyC+pAch+cmZRoFHN15R5BKDyRnhmhelLo9qCUPn6a4aUX3xnLcTih+JFWzR9QSsoZYJ1BBJfoWGHQqk+R1RSpzi7D5UwjoHooXMOm0eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=saHQOPQz; arc=fail smtp.client-ip=52.101.52.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="saHQOPQz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT8pLx6mzm3byH1IUbcimsFds4rnclu4S2xAAXYvagsVecKRpAwvGfLrxIpCamsNQJRVw/LCn09eJPyvjUB6RrO9+wGy/MZr9MIn0NULzLIJChP7xDvcjWstUn5WtZYAAicOWL0pI26BneVmM8hz+YpnTIU36GLvMuS68qvoBrOfWMNLkAr1rAhE7QQqCsNWe5hTyWCtKqHBoW2Ow6PxYGhYfdm8SP2rBGxZ7gdPbnopIg7QiJVcaZGXadQ+URJIrsUpe051/oK9TG/y/QLbAQxnRwlKWSKu/2TSGabLdTQeGxNPHM16UQZWjcdGL2hlh/Y2vsq3gzo04rNCzZ7pzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxCAe8bIF52MEo5qOrlbZSbXwCeI4N4iUGuCVe/jhb8=;
 b=gjRBv45a0BWRfo4XXOV8dM1VEKkOyb68zG6KZFB3aHqqNHN0MkR31xF0V2FmQKWI0qzSfqL2wmmNwQRz4cOvMEA2Zz56YdpARJKFZHYzcxZupzRXK5G17COBXaxfxlZbgSEcOfI1rNowzUaU0rJmJhoWFZjgH0f7oyfj8w3pji16TsHwh0H+YaxhRAwplO3WpaVF3CDrazUl76ZuUH0gcmQh3NmGfA+0ZJ5ds8VbEPBMvuSETNcL2GB9SfKPmFbQMCD9NEi0ovgUxTT8xQcMD1Qe5e6oNHqgYB6eU9kCNAlWDrWclNU32XkY/2JlTpBMDdr9KaCpgEA/tRyxlNLoXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxCAe8bIF52MEo5qOrlbZSbXwCeI4N4iUGuCVe/jhb8=;
 b=saHQOPQzHN3Nh+gLEJMSs7T20Lgksif3ey6NNI8a6M0OmbMiMBG2K/W1VA3MEiFNS033xhuq+DHmNByIifzNUgqGKj29OGrETBJFSrpLiBFyU6yqrmP16STX4x4dLk7dcCgbGtvLRU730V+4zUi1/IF2yBzdB+f109EAujgynvvyi2zdrYV44VJIowJayDJdpbTB08WCx9zwEVe23Cl4L2Xw4YOKef9f4YiHftusx1kCeiDyzs6LiPSBNghjIHvDC+3OcM8NLwbWtO4Y7xnZGjEOOwCRQ1fKFKEGHpSFOeQbs/haiBmVsRa40MGPthIEL0CyNMaLI0oJ4l8x9WzuEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 07:43:12 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 07:43:05 +0000
Date: Tue, 2 Jun 2026 15:42:58 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH -qemu] hw/cxl: Use host-only coherency for default CFMW
 restrictions
Message-ID: <ah6HGQ_L6NpgZWle@MWDK4CY14F>
References: <20260602043029.2341246-1-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602043029.2341246-1-dave@stgolabs.net>
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 9623d032-d537-4f41-6185-08dec07a94fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|3023799007|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	fG/JAuZ9JjXk0stdnLH9diNtmCtYRuDkkk2gA7QGbbashKY56i480LrDBTtiNhtSU8/fuqnoP6PUEPaUzQIvJf5dcvptefoRz3+QCSJftTmIdEaG/7CCHPwbO5V5anLLy2KK5EOC0hAYJFEuD4NUjNUdUVkILODrY0DMwFeMN6KJr1BgmSRDrj6pLR7yPMdvD9tOZ0TAmnDzJuIBCgt5UBjXslpLgE0TzF9MDdDUkEpVOXngZhPWIQ/eaUW4v7oHh3PxiU3qcHzl/plD1Kb7Q6x8SQEWf6uRmasq5xG/pGh1aaopkK3ZvLHantso9LYBGoDMRXZI1oAYG9lTPVJXi89CLk0gjGUrX7P/asD8lRyPxDgCL4AVAXZzKeAuVd3FKcJhQNg310cCG26+998WHMq7sf+KTi9jvi1eCz1lFxfOcKxWpLiQHSobOHNJVGmuou/DBcloeEjiVKjDgRCkS7eCP2jGw1dqWjgFTYyDkz64lMeSUJxBdJekPL0qlJlCjJuI02Yp1+10H3uEPwkUE8/imUmynfxkIxEgEmwVBHYjQQp/5OooZcOiGYEAzxLXqMSEJCz8ALkSLrobBeaNEHOWuvOZsWJvIGhjYcp4zdKxXzznYa7e0IWJT5svlBPRPRNTW/zDGw1xkRL6gD1o/yOmkpqex4uDBIp8CPKOg6XefArYBjOa/sC3aMrZjvYv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(3023799007)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tbgd4+mrGuKyvRhPGCL4n9QiypX2rqgODy58i1ufFNRo5UA7D4Q6Dp/FgmN9?=
 =?us-ascii?Q?akvxgYJxmFWLhqxbE8GBCo21A1BJo38RSx9BYvcpp39C0p3yqO/POBX7n+LG?=
 =?us-ascii?Q?rtAi/iL4twrkJj09Z07rB+DTYBDoqDDEcdFPkVKKwwCCLlDfqZR2/OxTD9fH?=
 =?us-ascii?Q?6mtSGGx+ItUr3OaWCBKP8/7ILHHVQPDbvPEXkeVDQbBEbVpCoOTRbLJoEb+a?=
 =?us-ascii?Q?q5yvOgNH1cQ1aTd2jJUQKD8/9Lbv9P2hCOb1cWCwk/5FBx0SrIMzK70VpImb?=
 =?us-ascii?Q?uz0XkYAxH5N5e9PwO6iMSkicg1iyTUnDOCZ+1kaujOpHix0g3azmZ1j19Czx?=
 =?us-ascii?Q?qda+P3ZQS5Ma7Hrmq+6cTUW+1Bi9GRr5oenEyYJeWrgtBvOx66RsTlK+ikn2?=
 =?us-ascii?Q?CJgiS+yTxpL2F8dLjiP/nGvNsk5yAZw97+3Ied0Zh6ZFm2Q96DA85e0X9Sci?=
 =?us-ascii?Q?8e1CfmbgGeYA0pFP36vssh21srZyxua2duqQCChtOE0ubqYizw/zIW+4X2G1?=
 =?us-ascii?Q?x9hIMQlO5EVFiKGOZzms/Smgp2nnPxnLzvO2GNt9AABsSLOUUyfenPjCKTQy?=
 =?us-ascii?Q?Lt8Cve1dCrh8kxphyy7htNOATMdYhZ9P4jmhXmDnTDXzeqTAgLJtU4B+KzN7?=
 =?us-ascii?Q?ag4sFB/au/MPSX0WgJsAGCgL5DxTYxIGtAcZkqLNjErGB3lplDM9Ajn7g9Lh?=
 =?us-ascii?Q?eCww+924C3+1JtUUJZQKidQbsbbWOLjvCz/xiKH1DKXM/MdPdKijEOhigSDT?=
 =?us-ascii?Q?61pury8C2JayzmsOCuzCXKzse8001NO8ScNcYPtRq6hlQLqPd2/CHsfTTCk9?=
 =?us-ascii?Q?acmnm4vWUN/Js3ZDFoKG6pPankXU9pXHNM4ySp4D9exRYisoGWqF8Vnq+IZU?=
 =?us-ascii?Q?YwowgBBcHnzgBt7Bcq1mS26FGeLy1qxgEyYPl8JnwDtZzxsQVeQ8OiX6Rbzf?=
 =?us-ascii?Q?IOJ4mIl1nnHqG1uKX4hJao7wjcRjeniuJaziYlXmq8aYHk8v2XG6GYa+8vq1?=
 =?us-ascii?Q?uHngFjrj+8EowdGF7YPsIkgSKd9oiQo7Ryp08Dshlfkq87Gxe66YKBGlrSC+?=
 =?us-ascii?Q?bgFNFiI7OflfEtzrdPf7AaM+YCfPS0Es04niwv9vhFl6YMsB5WgJUVrt0KNl?=
 =?us-ascii?Q?QVAxOeidta4kYhpNiSc8t93L3WKGSb8DTlpALGDJx60SlB9js0t1jhY7gQ3t?=
 =?us-ascii?Q?5BUQaMGRFAwoWwYBvCPsEtgH7U0JT8MLOZMnW9oSxcy2tQpmxSmIkZyNJbdU?=
 =?us-ascii?Q?0wF0PVILeHgZiTeZ+5neChKapErR+fqjLBfRW8IxD+yVOEBMjeH6Nerra9Vj?=
 =?us-ascii?Q?L2vikyF3DhvA0a7nmzr+s/ZcsTOJvvEPTOeGT+wDtw0gJkjsXtbhwfEbs28Q?=
 =?us-ascii?Q?Qq5mBSCd2p5bZPbuChFGQnNwG7ne+/jOS6vdYMDT2xtWYvo1HoXk7fh32WLW?=
 =?us-ascii?Q?VjwPAgVudkZrgXrOmzK4hVDYlNYhdB8d/fqJz/b/UO3SVe89J2Z6EmfgJOo6?=
 =?us-ascii?Q?6l3FsuDaG+YjVSLTjWrUZHFPheTw+lYEn3P8hge/5pypoTe7X37v5bAdYucm?=
 =?us-ascii?Q?MWCdMRnPtespWUBizrW0f413eMLc7mbMib9X4DcH12WV5lkwCsiKuilWtzYa?=
 =?us-ascii?Q?zL2E95W1egB2ez+GtU1kXO2aDo6LGUfxFsxWiYeNMNom60EXRWPKKIcy6XpH?=
 =?us-ascii?Q?BueEOyig4gUovEgL6dqbJ1fu/PKh98oUx3qrRkDKtEiA/Vtc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9623d032-d537-4f41-6185-08dec07a94fa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 07:43:05.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6M84nMiuDaPtvzZ3Sl8V48t47u5oYbLJOwv9Sq7h4rvkcAXZPOpc8L/Tv25Ai2duXlVcg2eg4UM37FnRTM95g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

On Mon, Jun 01, 2026 at 09:30:29PM +0800, Davidlohr Bueso wrote:
> Change the default CXL Fixed Memory Window restrictions from
> 0x2f to 0xe, dropping Device Coherent and Back-Invalidate,
> which are considered spec violations when using in combination
> with host-only.
> 
> For HDM-D and HDM-DB models, the user will need to explicitly
> pass the correct restrictions bitmask.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  docs/system/devices/cxl.rst | 5 +++--
>  hw/cxl/cxl-host.c           | 2 +-
>  qapi/machine.json           | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index 32b1b5d7733b..079f65660dc3 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -385,7 +385,8 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
>    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>  
>  An example of 4 type3 devices with volatile memory below a switch. Two of the devices
> -use HDM-DB for coherence, which requires operating in Flit mode::
> +use HDM-DB for coherence, which requires operating in Flit mode with the CXL Window
> +configured with Back-Invalidate restrictions::
>  
>    qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
>    ...
> @@ -405,7 +406,7 @@ use HDM-DB for coherence, which requires operating in Flit mode::
>    -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
>    -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
>    -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
> -  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
> +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k,cxl-fmw.0.restrictions=0x2d
> 

Hi Davidlohr,

Small question, how about states bit1, which is host-only can't be set explicitly in the example? the spec tells us host-only+BI is UB, so all of the devices in that window must be device-coherent. I would suggest a clearer doc so read won't assume they can do such thing.
 
>  A simple arm/virt example featuring a single direct connected CXL Type 3
>  Volatile Memory device::
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 11a455b28ab8..a2595633ff0c 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -64,7 +64,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
>      if (object->has_restrictions) {
>          fw->restrictions = object->restrictions;
>      } else {
> -        fw->restrictions = 0x2f; /* No restrictions */
> +        fw->restrictions = 0xe; /* host-only coherent, volatile, pmem */
>      }
>  
>      fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));

LGTM.

> diff --git a/qapi/machine.json b/qapi/machine.json
> index 11ce0457d2f1..f832f0b84a53 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -558,7 +558,7 @@
>  #     BIT(3) - Persistent
>  #     BIT(4) - Fixed Device Config
>  #     BIT(5) - BI
> -#     Default is 0x2F
> +#     Default is 0xE
>  #
>  # @targets: Target root bridge IDs from -device ...,id=<ID> for each
>  #     root bridge.
> -- 
> 2.39.5
> 
>

Just one small tweak about commit message, you said Device coherent and BI are spec violations in cobination with host-only, but in fact the spec only calls out host-only + BI as UB.
For device coherent + host-only it says "more than one bit within this field may be set", for me dropping bit0 reads is more like default hygiene than a spec violation.
Maybe you would want to reword that part?

Best regards,
Richard Cheng. 
