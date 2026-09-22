Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAC438F654
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048671; cv=fail; b=Qfr0RAT/tjwNUi7G67c8HQwLE9vqmZFlts5xxR0zsM/GeNw/9PxWs/xLcntuzGlfXG3f2tWJ9wiuIUNrNR4ePu5lU5RRnjPdlC9gUrdiLmDwh6RgkYk3eXhvo9D0KI1gHT5A4MVR48w5S/Ko4Y3j/wQQGZcW7T/8Iaq5BRMgCK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048671; c=relaxed/simple;
	bh=LQR9LWQKJCPtVyII7sf7oS8WTCDKACxFNrNlNQijJbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kwvHSXwB8uBO+sMiJZH92rUN4gEsdTG1o48eNF6sDHfWLue3Saa6OGE69jA6GsrENuYuq1ZllDCrISVw3Md/coz8VGYIf4CSbTgVSoWzG8axQBjH6n2G/QZvai08z1htX9wN8dWqBkuqxlCRfLBX6j/c5hBj3vQpftSbAKbOD8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EiJlHWsN; arc=fail smtp.client-ip=52.101.57.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EiJlHWsN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcHf95WIp/C3kjycB6DkFJrrjHbe+4/fzGMzVI5x83ipSx1/hFU309pOsGduFpXVkGxgpKuXadyN/qg/pZSph3On6rqKJXE56hLy1caZDJ0zQ7G6KDdgqg8cu4nQMXIphTF6syzaGucIctrdNSDjzQJicwg19yU1IMPbRTPPNlC+QLL36mAT/79Ctg1VBR9/9a+K/HNu0c+kX1VNTely8zmB2Y22G/D8sF38aZz9CK/1qrYHpNfc+Lul2zvg0cxyf4A5e7mSmeM6w4w/lyFt/uyJFQMGGTYcLyHqLBaqMv5I+bBRKI8pAZUNKMsU18a41D4nqy3dV15fJuMaFjDPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXhA1+OJT7ZCtyBqzuOZ34GpNpiJ2ISSuxhkvSLmrg8=;
 b=b33LudRP2Ee4F77nWlek1OKXrr5PXiJY5kFbm3sDw1eigRZvJ8BXfi/sQCtmjmG6OcmkDeDnYUqQRpQTDuL2jC8jzBasQn+AlOB1UJU9yNg8u26YIYhrt49MYCslKigGuFU06lnpDfYWXI81w25vRcKkwTeMnHMBBvr1iysElvHW58NdrhTOlC+Kg1oyVeenLumKgJdCDwr9zbvnMMivkp3XePW+gUhQ60Sa7xQPhxjEb71iWipLnh1IvekxnnHor0IPlspySW516nP4sBS4DU+7UCubuzylLCLgViFBaZnr7B0xFSeZbRUHK6I+K5NP88dY62YhFgvXao+g4zoplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXhA1+OJT7ZCtyBqzuOZ34GpNpiJ2ISSuxhkvSLmrg8=;
 b=EiJlHWsNZmPAxNcH8xigZd9R2l5nmd500XAw340dxJWGdqGG4wUo4A/J0owdqj/vPJBnHCKD9RY43LRIxZh/1eFYjVM5AMI67FkKGkpv2B4Eqjre43T3/M+aIagKLJWMm6OxvLheWcKVBlmuodP/GnwPRAopuMMMK+WT1kbfPGG4iuSrMfTxPJrXndlL/qyedQt004jju0QIteHq3yOXckaCo9T95xXf6izsVZwD/RowL8oFxR6Gm3lJoX2nxuLgJTrv1WldiyYcfp7pBpR8DeBPSunfR6ryB+kWhySHAE6duyGYF3WAelaEWtbAeYodydPNq/rfUt0mFlgJxBed+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 03:44:23 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0428.014; Tue, 22 Sep 2026
 03:44:23 +0000
Date: Tue, 22 Sep 2026 11:44:16 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>, 
	Gregory Price <gourry@gourry.net>, Ben Cheatham <benjamin.cheatham@amd.com>, 
	Ira Weiny <iweiny@kernel.org>, Anisa Su <anisa.su@samsung.com>, 
	Wonjae Lee <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, 
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [PATCH v14 2/8] cxl/mem: Read dynamic capacity configuration
 from the device
Message-ID: <arH3l77e_qQuyYWp@MWDK4CY14F>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-3-anisa.su@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918203049.7273-3-anisa.su@samsung.com>
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CYYPR12MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: f3acf9c8-0ac6-4cfb-3c94-08df185bca76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|4143699003|56012099006|11063799006|5023799004|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	6wjcWQpMvrm6mMrNRGejuBCvLyQxRSRLL8swfULW7DbLvI5q5AoASKBzt6DsUDDSYMMM8XTOW2rceW3x/T6wyMPhv3kZOt3U62x02ZkzWfa/fq4BgSl6+/YIft0iCI2pyJgSfXETSz7au70XcWRUW8KcoP6WvU9s/Jd+M6DeokJizVrVp5xw2TBlTv+nzz9Rhiw1VN3DJZNyXSEogASSPRh90/oAnOb1cCoGklOMGceiKCdvudMsZtg0rAi+T5Us1X30bu7OC4wxI08DQGWKijxvoeOkQ5XIXsbgYh3SNOZ1k0TnK2pskoubyT+HPlRUHjkGsV+OxP0wYss2+Zi2pE7VOTzocd/nB6VAq0l7VTzG60HIoLOb6BG1aP2R1q+mnmDWjpzSueYviuxsVw9azC8PywXsYbbgmVZiyHd4A5ksMh3ak8q2QMUu7PM6/0KAFZZXHo65y4CMdGUpzowPyIsf57U0KyLMBFjmdDi8Ru+0o6esiW5QhRndaCVnCt96eIQ77fy7raFxEFRv/LSALrvJPu8AwLsXZ1GlgisIygY4cSrWq1kkVpvQ5UdEMeFaXZB9k13DCJnfBsZGVHJivOd5/MMzy40+oR86QEv5rBxh2lB33Jj0ptMHVleCTpwvNjUt7IPr72+xeFaTlZao3FkdZr1WmGLktz/rqmufNKE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UohUA7JopKZ9yY0m2rb3vWMq7ss9ALhUhy66KY4nqpDBG7JH6MRcVS0JHxaO?=
 =?us-ascii?Q?BZPLuqFBpFLbWfsgf3/KoQJq+w6iJ70N8BM+fBiVehop8XfkSw22SuQb/OWu?=
 =?us-ascii?Q?CCWxuKi7lIKVlP5FvchahEt25zswRjnhq2Cg2IVQfmVYpJAoLcr5gqOoOg0g?=
 =?us-ascii?Q?jMddvVhA1DzXXnSHlkXo5JeIlAQjEFH/gv/jo3yP8jmdSxN9MP+RGXqKYb3e?=
 =?us-ascii?Q?y0LSkD8l9vsvWmKtCSgTaq74r+xjnmye6KlfM/6T22NBTDG/wp5kQdmttRoy?=
 =?us-ascii?Q?1jIrJ3F8uour7URm9mTFzdALluI86hJzatum4LhIb29bYud6asRcRglPCkra?=
 =?us-ascii?Q?377zHTPAqwZRQjKqbQY/JWGmusQLRDxZgrzfI/rSyZkbh1a7Cb7x/AhyLivf?=
 =?us-ascii?Q?w3lQo0RJ0zaOxZuLLGLKA4vPxCWPcFBwJdptPuoPaEBRwA0lEbeC+/NBDcXW?=
 =?us-ascii?Q?Wixle8TQo2idX4vYoPnk7xf42hzrgaL7rp6XCXqU54PmGwc66q4SD4qfC7EF?=
 =?us-ascii?Q?6ifDMHtsKwVa5TsJX8vG5SFzzs19Py8MHfVT1HwAsdvfkFAsznf1sexmci6R?=
 =?us-ascii?Q?I892fCj8fh6dBbWdi8AsK9OqeKIEf3c3Auxdoi9r1Py2/w9D87TS/avPZe9q?=
 =?us-ascii?Q?+uZWtcEEboy+sSGSAUIFoDdS1KT7oBP8Wxp9i6tbgFhTLuUx5DVYFGJ1wi4C?=
 =?us-ascii?Q?AYJBDcNEtfKcZQIe/Llc/H5fLkGEdOIN57M73xs6xcQroWsEQpHr/p/f0jy1?=
 =?us-ascii?Q?ljQMn0iii78fjhpa7Es1+qTOVRjOqHNIihR4T85J49Wv0mzUTGnvvA7VSafI?=
 =?us-ascii?Q?65HUnVzDapJnMjYXDTVDFfKJ6pNwjm5Ql/h2k1/22a1K8/Hd6UntwPX/JWS3?=
 =?us-ascii?Q?i2TxexUZwN98VHu4SLc+GnEBigS5NYmUxs7gmVf7xEivTROP4Guqde89bKrj?=
 =?us-ascii?Q?me9064SS+6O8urzq2lsE6cOnJUgsfxbk7sBtfQ0ZQZcCTRgyfmGTFLJhVNyR?=
 =?us-ascii?Q?GNEO07ZfeG23v5F1DqttjEX/0Jq6yd5JgxxW76q82b7ipyiPAsqSEWPROl4V?=
 =?us-ascii?Q?zpacF9AomVdEFaqqRkBJtIneEYnIq4TNlmS0479Y/YyPxeZkJfk/Hn1kLfzt?=
 =?us-ascii?Q?6qbQsp1kOHTw7G2QvP9C0aG8jGnYHeEmUPACpz/myBasr+NQ0MVdtaxZ76/h?=
 =?us-ascii?Q?JQinQRvgX8eicbJW5/2Zcmci5QeZJsnTe/wGTNW6kBNBw71tHIZ5slSQt6zY?=
 =?us-ascii?Q?HsFXc8XJLQqKtzOKZfTIUr4/dGICy1QYFiVnZAyu67uYnWSmMsdq5NZNoM5O?=
 =?us-ascii?Q?TMxT1Uo9BOJesZ13IlGUBIktq+E0rpsn6Wrxaq5XSOH2OYyu1avSvAPYTBB8?=
 =?us-ascii?Q?TQE/w602BfcrU/rzMa2kdWo+OrZpPrWmJu5lOnCEj3TyhwXKUpqlBHEcmrWa?=
 =?us-ascii?Q?5PP2ihWpF0a3K84mCOL1ofIc06tsETm64rFfZ5ccI5ftdveOSygWnpyFKwm+?=
 =?us-ascii?Q?YWIK3iElk2QGmF5/6UawNGNPUzFaZZRiDzA3Y+odHZOLF0bd2A3Cjch8W5tN?=
 =?us-ascii?Q?5SabEB/UeBdZUjbA4nc9UgOT4KlQ6fwuj3U1sxEkirffCoe+ZYNe+p+5FlDQ?=
 =?us-ascii?Q?5YCckEq2FzE//2BTvuHRFF3nBykYq6SlkyxWQ36L9jicWty+2r7O5gZcv/Tp?=
 =?us-ascii?Q?NOJTfQfIHhadpzAYaRvcV86k7P7UDjmi8Y/rM1S4q/3xSk2Hs5b9vAui+RUd?=
 =?us-ascii?Q?eQZp3VCQIg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3acf9c8-0ac6-4cfb-3c94-08df185bca76
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 03:44:23.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dH/6G/UAXVTSZ3M0AzDFEoXLjA6KJ0znm6OInAMOsJKT8ZD4BJBJcrM8ZptfU/V2KygqkhjIZ+u1sKqJMo8NqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8655

On Fri, Sep 18, 2026 at 01:30:11PM +0800, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Devices which support Dynamic Capacity (DC) are configured
> via mailbox commands. CXL r4.0 section 9.13.3 describes the use of
> the Get DC Configuration command in order to obtain DCD partition
> characteristics.
> 
> Implement the DC mailbox commands as specified in CXL 4.0 section
> 8.2.10.9.9 (opcodes 48XXh) to read and store the DCD configuration
> information. Disable DCD if an invalid configuration is found.
> 
> Initial enablement for Linux only supports one dynamic capacity
> partition. Read all the partitions the device reports but validate
> only the first, and configure it as 'dynamic ram 1'.
> 
> The specification requires that volatile capacity starts at DPA 0 and pmem
> starts at the DPA immediately following it, but DC partitions only need
> to be 256MB aligned according to CXL r4.0 section 8.2.10.9.9.1 Table 8-347.
> So a device could leave a gap between ram/pmem (static) capacity and its first
> DC partition, or between one DC partition and the next.
> 
> However, Linux chooses not to support gaps between static and dynamic
> capacity, and requires the first DC partition to begin at the DPA
> immediately following static capacity.
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Co-developed-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

I wonder if we can have comments in code explaining why linux doesn't support
gaps between static and DC, otherwise this can be a bit confusing why
the 1st DC partition needs to be immediately after the static part, at least
for me.

Best regards,
Richard Cheng.
 
> ---
> Changes:
> 1. mbox.c: do not refuse DCD when the device reports more than
>    CXL_MAX_DC_PARTITIONS. A future spec revision may allow more and
>    Linux only maps partition 0, so read only the first 8. A count of
>    zero is still refused.
>    Jonathan
> 2. mbox.c: reject a decode length that overflows when scaled by
>    CXL_CAPACITY_MULTIPLIER. A device reporting 2^36 or more wraps and
>    yields a plausible looking partition size rather than an error.
>    Richard
> 3. memdev.c: reject a DC partition size that overflows the DPA total.
>    The wrapped total reads as zero capacity, which cxl_dpa_setup()
>    accepts silently, so the device enumerates with no DPA and no error.
>    Richard
> 4. memdev.c: skip DC configuration when the media is not ready, as
>    cxl_mem_dpa_fetch() does for static capacity. The DC base was compared
>    against a static size forced to 0, disabling DCD with a misleading
>    gap message, or configuring dynamic capacity on a DCD-only device
>    whose static partitions were withheld.
> ---
>  drivers/cxl/core/hdm.c    |   2 +
>  drivers/cxl/core/mbox.c   | 237 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c |  48 ++++++++
>  drivers/cxl/cxlmem.h      |  55 +++++++++
>  drivers/cxl/pci.c         |   6 +
>  include/cxl/cxl.h         |   3 +-
>  6 files changed, 350 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..0ef076c08ed2 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -446,6 +446,8 @@ static const char *cxl_mode_name(enum cxl_partition_mode mode)
>  		return "ram";
>  	case CXL_PARTMODE_PMEM:
>  		return "pmem";
> +	case CXL_PARTMODE_DYNAMIC_RAM_1:
> +		return "dynamic_ram_1";
>  	default:
>  		return "";
>  	};
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 199bb986d674..c96c16cc08e1 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1349,6 +1349,243 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  	return -EBUSY;
>  }
>  
> +/*
> + * A partition unavailable for Dynamic Capacity reports zeros for decode_length,
> + * length, and block_size.
> + */
> +static bool cxl_dc_partition_unavailable(struct cxl_dc_partition *dev_part)
> +{
> +	return !le64_to_cpu(dev_part->decode_length) &&
> +	       !le64_to_cpu(dev_part->length) &&
> +	       !le64_to_cpu(dev_part->block_size);
> +}
> +
> +static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
> +			struct cxl_dc_partition *dev_part)
> +{
> +	u64 decode_len = le64_to_cpu(dev_part->decode_length);
> +	u64 blk_size = le64_to_cpu(dev_part->block_size);
> +	u64 len = le64_to_cpu(dev_part->length);
> +	u64 size;
> +
> +	/*
> +	 * Not an error; leave the entry empty. A partially zeroed partition
> +	 * is rejected by the checks below. CXL r4.0 Table 8-347.
> +	 */
> +	if (cxl_dc_partition_unavailable(dev_part)) {
> +		*part = (struct cxl_dc_partition_info) { };
> +		dev_dbg(dev, "Partition 0 unavailable for DC\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Decode length is a count of 256M units, so a device reporting 2^36
> +	 * or more wraps.
> +	 */
> +	if (check_mul_overflow(decode_len, (u64)CXL_CAPACITY_MULTIPLIER, &size)) {
> +		dev_err(dev, "DC partition 0 decode length %#llx overflows\n",
> +			decode_len);
> +		return -EINVAL;
> +	}
> +
> +	*part = (struct cxl_dc_partition_info) {
> +		.start = le64_to_cpu(dev_part->base),
> +		.size = size,
> +	};
> +
> +	/*
> +	 * Block size is a power of 2 and a multiple of 40h. is_power_of_2()
> +	 * takes an unsigned long, which truncates blk_size on 32 bit.
> +	 */
> +	if (blk_size == 0 || (blk_size & (blk_size - 1)) ||
> +	    blk_size % CXL_DCD_BLOCK_LINE_SIZE) {
> +		dev_err(dev, "DC partition 0 invalid block size %#llx\n", blk_size);
> +		return -EINVAL;
> +	}
> +
> +	if (part->size == 0) {
> +		dev_err(dev, "DC partition 0 zero decode length\n");
> +		return -EINVAL;
> +	}
> +
> +	if (len == 0) {
> +		dev_err(dev, "DC partition 0 zero length\n");
> +		return -EINVAL;
> +	}
> +
> +	if (len > part->size) {
> +		dev_err(dev, "DC partition 0 length %#llx exceeds decode length %#llx\n",
> +			len, part->size);
> +		return -EINVAL;
> +	}
> +
> +	if (!IS_ALIGNED(len, blk_size)) {
> +		dev_err(dev, "DC partition 0 length %#llx not a multiple of block size %#llx\n",
> +			len, blk_size);
> +		return -EINVAL;
> +	}
> +
> +	if (!IS_ALIGNED(part->start, SZ_256M)) {
> +		dev_err(dev, "DC partition 0 base %#llx not aligned to 256M\n",
> +			part->start);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "DC partition 0 start %#llx size %#llx blk_size: %#llx\n",
> +		part->start, part->size, blk_size);
> +
> +	return 0;
> +}
> +
> +/* Returns the number of partitions in dc_resp or -ERRNO */
> +static int cxl_get_dc_config(struct cxl_mailbox *mbox, u8 start_partition,
> +			     u8 partition_count,
> +			     struct cxl_mbox_get_dc_config_out *dc_resp,
> +			     size_t dc_resp_size)
> +{
> +	struct cxl_mbox_get_dc_config_in get_dc = (struct cxl_mbox_get_dc_config_in) {
> +		.partition_count = partition_count,
> +		.start_partition_index = start_partition,
> +	};
> +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
> +		.payload_in = &get_dc,
> +		.size_in = sizeof(get_dc),
> +		.size_out = dc_resp_size,
> +		.payload_out = dc_resp,
> +		/* The device must return at least the fixed header */
> +		.min_out = sizeof(*dc_resp),
> +	};
> +	size_t expected_sz;
> +	int rc;
> +
> +	rc = cxl_internal_send_cmd(mbox, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (dc_resp->partitions_returned > partition_count) {
> +		dev_err(mbox->host, "Device returned %u partitions, requested %u\n",
> +			dc_resp->partitions_returned, partition_count);
> +		return -EIO;
> +	}
> +
> +	/* The trailing extent/tag counts (CXL r4.0 Table 8-346) are not read */
> +	expected_sz = struct_size(dc_resp, partition,
> +				  dc_resp->partitions_returned);
> +
> +	if (mbox_cmd.size_out < expected_sz) {
> +		dev_err(mbox->host,
> +			"Payload size %zu less than expected %zu for %u partitions\n",
> +			mbox_cmd.size_out,
> +			expected_sz,
> +			dc_resp->partitions_returned);
> +		return -EIO;
> +	}
> +
> +	dev_dbg(mbox->host, "Read %d/%d DC partitions\n",
> +		dc_resp->partitions_returned, dc_resp->avail_partition_count);
> +	return dc_resp->partitions_returned;
> +}
> +
> +/**
> + * cxl_dev_dc_identify() - Reads the dynamic capacity information from the
> + *                         device.
> + * @mbox: Mailbox to query
> + * @dc_info: The dynamic partition information to return
> + *
> + * Read every partition the device reports, but validate only the first:
> + * Linux maps partition 0 and nothing else, so a defect in capacity the
> + * driver never touches is not a reason to refuse the device dynamic
> + * capacity.  The remaining entries of @partitions are left unset.
> + *
> + * Return: 0 if identify was executed successfully, -ERRNO on error.
> + *         on error only dc_info is left unchanged.
> + */
> +int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> +			struct cxl_dc_partition_info *dc_info)
> +{
> +	struct cxl_dc_partition_info partitions[CXL_MAX_DC_PARTITIONS] = { };
> +	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) = NULL;
> +	struct device *dev = mbox->host;
> +	u8 avail_partitions = 0;
> +	u8 start_partition;
> +	u8 num_partitions;
> +	u8 partition_count;
> +	size_t dc_resp_size;
> +
> +	/*
> +	 * Bound requested number of partitions by mailbox payload size. The
> +	 * 256 byte spec minimum, verified in cxl_pci_setup_mailbox(), keeps
> +	 * the subtraction below from underflowing.
> +	 */
> +	partition_count = min(CXL_MAX_DC_PARTITIONS,
> +			      (mbox->payload_size - sizeof(*dc_resp) -
> +			       sizeof(struct cxl_mbox_get_dc_config_tail)) /
> +			      sizeof(struct cxl_dc_partition));
> +	dc_resp_size = struct_size(dc_resp, partition, partition_count) +
> +		       sizeof(struct cxl_mbox_get_dc_config_tail);
> +
> +	dc_resp = kmalloc(dc_resp_size, GFP_KERNEL);
> +	if (!dc_resp)
> +		return -ENOMEM;
> +
> +	start_partition = 0;
> +	num_partitions = 0;
> +	do {
> +		int returned, rc;
> +
> +		returned = cxl_get_dc_config(mbox, start_partition,
> +					     partition_count, dc_resp,
> +					     dc_resp_size);
> +		if (returned < 0) {
> +			dev_err(dev, "Failed to get DC config: %d\n", returned);
> +			return returned;
> +		}
> +
> +		if (returned == 0) {
> +			dev_err(dev,
> +				"Device reported %u partitions available but returned none at index %u\n",
> +				dc_resp->avail_partition_count, start_partition);
> +			return -EIO;
> +		}
> +
> +		/* A DCD reports at least one partition (CXL r4.0 Table 8-346) */
> +		if (dc_resp->avail_partition_count == 0) {
> +			dev_err(dev, "Device reported no DC partitions\n");
> +			return -EIO;
> +		}
> +
> +		avail_partitions = min(dc_resp->avail_partition_count,
> +				       CXL_MAX_DC_PARTITIONS);
> +
> +		/*
> +		 * Only partition 0 is mapped, so it is the only one checked.
> +		 * The rest are read to complete the enumeration and dropped.
> +		 */
> +		if (start_partition == 0) {
> +			rc = cxl_dc_check(dev, &partitions[0],
> +					  &dc_resp->partition[0]);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		num_partitions += returned;
> +		start_partition = num_partitions;
> +
> +	} while (num_partitions < avail_partitions);
> +
> +	/* Linux only supports the 1st partition; nothing to do if it is unavailable */
> +	if (partitions[0].size == 0)
> +		return -ENODEV;
> +
> +	*dc_info = partitions[0];
> +	dev_dbg(dev, "Returning partition 0 %#llx size %#llx\n",
> +		dc_info->start, dc_info->size);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_dc_identify, "CXL");
> +
>  int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9..15df8db314d9 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -643,6 +643,54 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
>  
> +int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> +{
> +	struct cxl_dc_partition_info dc_info = { };
> +	struct device *dev = mds->cxlds.dev;
> +	u64 total;
> +	int rc;
> +
> +	if (!mds->cxlds.media_ready)
> +		return 0;
> +
> +	rc = cxl_dev_dc_identify(&mds->cxlds.cxl_mbox, &dc_info);
> +	if (rc) {
> +		dev_warn(dev,
> +			 "Failed to read Dynamic Capacity config: %d\n", rc);
> +		return rc;
> +	}
> +
> +	if (dc_info.start < info->size) {
> +		dev_err(dev,
> +			"DC partition 0 base %#llx overlaps static capacity ending at %#llx\n",
> +			dc_info.start, info->size);
> +		return -EINVAL;
> +	}
> +
> +	/* A gap between static capacity and the DC partition is not supported */
> +	if (dc_info.start > info->size) {
> +		dev_warn(dev,
> +			 "DC partition 0 base %#llx leaves a gap from static capacity ending at %#llx\n",
> +			 dc_info.start, info->size);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (check_add_overflow(info->size, dc_info.size, &total)) {
> +		dev_err(dev,
> +			"DC partition 0 size %#llx overflows DPA space ending at %#llx\n",
> +			dc_info.size, info->size);
> +		return -EINVAL;
> +	}
> +
> +	info->size = total;
> +	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
> +		dc_info.start, dc_info.size);
> +	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_configure_dcd, "CXL");
> +
>  
>  /**
>   * cxl_set_capacity: initialize dpa by a driver without a mailbox.
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 0c8e23276dc6..4fac65dbb808 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -407,6 +407,8 @@ struct cxl_security_state {
>  	struct kernfs_node *sanitize_node;
>  };
>  
> +#define CXL_MAX_DC_PARTITIONS 8
> +
>  static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
>  {
>  	/*
> @@ -689,6 +691,39 @@ struct cxl_mbox_set_shutdown_state_in {
>  	u8 state;
>  } __packed;
>  
> +/* See CXL r4.0 Table 8-345 get dynamic capacity config Input Payload */
> +struct cxl_mbox_get_dc_config_in {
> +	u8 partition_count;
> +	u8 start_partition_index;
> +} __packed;
> +
> +/* See CXL r4.0 Table 8-346 get dynamic capacity config Output Payload */
> +struct cxl_mbox_get_dc_config_out {
> +	u8 avail_partition_count;
> +	u8 partitions_returned;
> +	u8 rsvd[6];
> +	/* See CXL r4.0 Table 8-347 */
> +	struct cxl_dc_partition {
> +		__le64 base;
> +		__le64 decode_length;
> +		__le64 length;
> +		__le64 block_size;
> +		__le32 dsmad_handle;
> +		u8 flags;
> +		u8 rsvd[3];
> +	} __packed partition[] __counted_by(partitions_returned);
> +	/* Trailing extent/tag count fields unused */
> +} __packed;
> +
> +/* Trailing counts; cannot be a member after the flex array above */
> +struct cxl_mbox_get_dc_config_tail {
> +	__le32 num_extents_supported;
> +	__le32 num_extents_available;
> +	__le32 num_tags_supported;
> +	__le32 num_tags_available;
> +} __packed;
> +#define CXL_DCD_BLOCK_LINE_SIZE 0x40
> +
>  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
>  struct cxl_mbox_set_timestamp_in {
>  	__le64 timestamp;
> @@ -812,9 +847,18 @@ enum {
>  int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> +
> +struct cxl_dc_partition_info {
> +	u64 start;
> +	u64 size;
> +};
> +
> +int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> +			struct cxl_dc_partition_info *dc_info);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>  int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
> +int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>  						 u16 dvsec);
>  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> @@ -828,6 +872,17 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>  			    const uuid_t *uuid, union cxl_event *evt);
>  int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count);
>  int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds);
> +
> +static inline bool cxl_dcd_supported(struct cxl_memdev_state *mds)
> +{
> +	return mds->dcd_supported;
> +}
> +
> +static inline void cxl_disable_dcd(struct cxl_memdev_state *mds)
> +{
> +	mds->dcd_supported = false;
> +}
> +
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c7c91e8dc51d..2fe9db4b3d86 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -868,6 +868,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	if (cxl_dcd_supported(mds)) {
> +		rc = cxl_configure_dcd(mds, &range_info);
> +		if (rc)
> +			cxl_disable_dcd(mds);
> +	}
> +
>  	rc = cxl_dpa_setup(cxlds, &range_info);
>  	if (rc)
>  		return rc;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 802b143de83d..4ef9511fbbdd 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -133,6 +133,7 @@ struct cxl_dpa_perf {
>  enum cxl_partition_mode {
>  	CXL_PARTMODE_RAM,
>  	CXL_PARTMODE_PMEM,
> +	CXL_PARTMODE_DYNAMIC_RAM_1,
>  };
>  
>  /**
> @@ -147,7 +148,7 @@ struct cxl_dpa_partition {
>  	enum cxl_partition_mode mode;
>  };
>  
> -#define CXL_NR_PARTITIONS_MAX 2
> +#define CXL_NR_PARTITIONS_MAX 3
>  
>  /**
>   * struct cxl_dev_state - The driver device state
> -- 
> 2.43.0
> 
