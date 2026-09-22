Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2AE3C5546
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790049220; cv=fail; b=PPOaFs4oEZIIINv9pdZQ3elmvAlrtzEevKeDht9YAYuwM+54zC+RK3wMHfuhjwxhdNeo6tz/OAotc7DBDhBlLLq0tz81Ll92mONfcVhwmfwlDJBpfUqLVIHSod0id/ZKrdzwSq+320wNdAB+n+noxD39WV+5/Z5/a3IlVg884Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790049220; c=relaxed/simple;
	bh=Q8WR2b+t1ez91mab/G/Vx/ka2t6zEubW7Je5rnlryEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IB5Uy52SNoq6+PtaB+yxrxzGNrhsJ2ln+r0VKBWSdIxKilVt95qW0T0ZAX2wo6M2kQnW0Hwlsa6g1RnUWewWzdl7VYrUrVT1hbqHo/j5sES1uUI1BF1KhovN4AmfSuaz161D3h6hxkWEpzHW405enVq6o3CpDXZoC2lUwpatGt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fjS/Nxmg; arc=fail smtp.client-ip=40.93.196.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fjS/Nxmg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIYDrZKPmZqVBboVqt7iWaMupL434P2hAf5B7IedD1nlTtcsRT99TfMEkaRm8KNwOQVNDeIxvU8sNfxH2Qo1jV/KyIcsEfP3p7m+LousaxSgAjjsDjhtnkRizlH5ueOUfBOeI/wiix0N9lPo/sZJ8VTrNCV3snWLa8Rw34WIMriOX//damDw9v4C7GGBdXWMKMx1ioXvjrLE3GbjC0uV5w0gy1FvCgCRKnZnud5bD7wCBUraBnvGn//Ca1uI5xqV1Cej89BsNRihMj6IE+btJCQfvdgRpyoO7y2kB8FBYgadRyX3QKv/Xyd7ceVlkhMVkl+2yOMcY+KcwOegfv94gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReHGAUYxs7tmIa9+VrRMhxwMeFOmnNSK7EixlmXOeqQ=;
 b=pxePuVwnlDTJ6CbPIwebOzXLJY56JlWjE9rtSXn9GTVoLVHfoELdYgWrNYKLMIFr0GG2k6ozaqZODSHDOxNogw5jJ4zBVX8O+XTmsZFQlxR9GCj8RC7nLQDUyO/dZ/zw4aFE26uTt7IJ5Zg/WA4GMUJTx2n2sl+ZViSF3+/5GN38qg4mT6K4dEVsE1HUv6prMHxBMzDPhXD3yCgFiZNUInruA5Bto9BFenXBLoa7EbOOSFa34W8xc9wE1ep52GzRnxYSmHugjvMZhxiZnM+SSlldx9TazbrJFEgOzCnm+kkj07Egsuz5KUiqGAKo20y/+/sm1dH8P0YhY8+TXLuyMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReHGAUYxs7tmIa9+VrRMhxwMeFOmnNSK7EixlmXOeqQ=;
 b=fjS/Nxmg5mZP0zEJjOK8/TudY2L7Wwr7BqocReRsNcwS2z6Jf2fwzF5M7uQPqWG2LfrALKtmws2TtLbSGDidTcizls8Xi7y3hSsDLwIyaiKfp+Zh4G9Xcrf9DdHDtcZvdeeJWLzsI0l+H9QOac8OHM4a4e/9hEaJ9Z/V35Yl+s0S1r4nKpVv1G+B6Y7ezUv6y0KPkOgHbINHctNeP+RR0ICQeyAHafhumEPU1ogPvDsSn03qO5sueQu/kgml7R888/Fb22icOhuSm1FgHBipCO2zZ7Pbmmq23N8FzoQAwdbYYs5SaFRogGBPqlGs9q2PhfMUeM4aKDZ14Ep/awTwpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 03:53:35 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0428.014; Tue, 22 Sep 2026
 03:53:34 +0000
Date: Tue, 22 Sep 2026 11:53:27 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>, 
	Gregory Price <gourry@gourry.net>, Ben Cheatham <benjamin.cheatham@amd.com>, 
	Ira Weiny <iweiny@kernel.org>, Anisa Su <anisa.su@samsung.com>, 
	Wonjae Lee <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, 
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [PATCH v14 3/8] cxl/cdat: Gather DSMAS data for DCD partitions
Message-ID: <arH67By0gfwd-b1e@MWDK4CY14F>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-4-anisa.su@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918203049.7273-4-anisa.su@samsung.com>
X-ClientProxiedBy: KU2P306CA0015.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 37124c00-9e89-4722-265f-08df185d1347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HV/Ledyjgwbv3p8PLBoj+4RNZ1Pp9tMwpNncAdqNxmoJBViIObroYs7WxT53B5gzt1tGWNRWGtccmOt/w7Opnxb0FuAiTVGPiHgsoFmrrn+kzK2lO8ED0RWXpLWiNt3pjlJcPaUc7NyR7k75WB4nXDq6+JiP6UveGM13/AT/aMVpvN9fIkiJQnIeceOr5WYSSGF9TLi28+Q77E9g5Q/SSp+vou46F0vNj8BP20W+SOrAQB2VcRaiCRpK+3DLS87KOaWLvC5UZbpZY7OXrD4W+415jBjckOytWQkD7CXF2wSJMooMKNKN5aAIB6ctnRdVeKz8iRoTpGLBnluBr/mZrqu1YfMq3dY7zwamp8Vm1vtXoKaJy+wOWUDuAgVXC6jVkEl1aAd1LB/Tuib5nbd+upJda/GD5WT8AP0uRbvYzPWao7ekOOZbLXHA4zN4gJZkfrxEEDn8ZwqetU8znkqfg0oA6bh4hoeBCiSgjzoFy+UaCDtpmTa7Hc+Ozq8o7TdqFS/UwnTaIO7zZr23pl85n5RZFSGZYLKLqjsBcQAq5XELMtEP1t1uOhxBj2rpZwQ0Cfcs/6WmUahwm1PpRAnb0GZqUQi+4S335UsLEIUgufqb+w9spDAcNtS5LZiLzh9yeqfDovYHM/ctddIbNCz2VACaUJz/mn32nWZCRn6Ab2Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pTn51X0HANkubrrnHu6cM9uRZKWuXr/RQpysdmneLsuzQrSYZJnyQCjIDhBT?=
 =?us-ascii?Q?E2Bjh3EoIPX1n/pkk2WlmeGasOcBw23j/j4nRGCYEObKVHYRe4AJP8F0U3Zr?=
 =?us-ascii?Q?1YzG8qM0TANHZ+CcwL4XdBWEYJ6kFvn6gGF2rBW81pSrqH0utAlJIqL0vrmK?=
 =?us-ascii?Q?G6VN/63C35suaQMijMDqfns6nCAECYgDX286uGhWKWb5A2vy2qSiN/xRDazU?=
 =?us-ascii?Q?H8RM+dpSnw2/iPRuNlq98inQFUef5IVHZ7jY4xKwp1uiS765kPfpKw9Wa5iX?=
 =?us-ascii?Q?v05artpk+21VwA/fBX/SIt5EoSWeHDKSNR75bBh4XyiD4rBKg0omdfc9l3nj?=
 =?us-ascii?Q?zM3dXxqVt/OY4ObfUT8LriXuYgATspGx1Zs1/vkZb4AizZTeQCuOnviWRNv5?=
 =?us-ascii?Q?6wCwQ/NV1gVNBmd4FminXGCpQhY73zeU41Qe28JfY9KXxx5E9KJB0hm8+ZQa?=
 =?us-ascii?Q?4rU95ZXg2kESrxWv7Goi46BV9Y4rw+jyVMPZrdoebhfbn+kxqyIYZnxxK1vM?=
 =?us-ascii?Q?SSJRqsj5ON7d4SFmaSZ8ZK8w4zbtZ7+IxVXj8ukcf74Lcrp+ZiRPvkD6a2xt?=
 =?us-ascii?Q?xaRUbjkB/OsV0JoiwH02j9A659FiE7mSPJKymsTB8r1HWpJgj0j4tmPSBtRI?=
 =?us-ascii?Q?JLZH3IexcZRprsucRPjY9hmxv/vb0885bsSK119u84NtQ6IVEfYXlhHOgB8H?=
 =?us-ascii?Q?4a27YwZIfHopcHYJzSj4MXEcBDBRSSLEEghppwLSlUCnvFRzYON05ih+/JKA?=
 =?us-ascii?Q?xtTdNs6xhx6GldfPIvUfzXWvE9IgS3sL/xqrT1OUzR6bxBotvn9dmSqhThpV?=
 =?us-ascii?Q?u2FFS9ero1JNXmZhfZk/05BBr5pxV55ZqFOTJA5+ET24I2LLBByX+lsNRoV7?=
 =?us-ascii?Q?fvqiNfhmrZqzWhjG5Sdv45mFV3Hz44Y6KaHPRMPo5WFRzzbeE/gDny9j5GwG?=
 =?us-ascii?Q?dU+MaU1B1Sc8toqLKrdwxh/39AO1FIyRSX/IVMS1ZMpAmiCHM4D8YzVBYUVn?=
 =?us-ascii?Q?XdWvf5QX4hHb33u3MlchvmCweUxLLMkdqbQrozq0jnJj2/Hjh5trGy8nYO+R?=
 =?us-ascii?Q?bdOHXxqKAnDbcPRyOo9uBCbvET5q4OT7f+A1EK7F4QV2LYYVgcbn9bmgXUIS?=
 =?us-ascii?Q?QY9aykoPX5DCDnTRBXjHFPr0V3igLKWDsm0TNp+cNlm4FQYG2culhPLWrE56?=
 =?us-ascii?Q?5VljTKcEju6qtLNwSqTo0wcvtf2cRZoFJXZ0lwp3YU8gwqZm7qmCadaW+Ht2?=
 =?us-ascii?Q?teBaa0WPmbH2IjOKvl8Y/ZH+WNhuxvGMgR364h3wjhzV+IIsbUwlRw3LRw16?=
 =?us-ascii?Q?boxo0yoFOrZ5p66kLWq2UlwQfi7PU+d/l6+sgn8L3QnVlG7MQwv1WwDt/RsN?=
 =?us-ascii?Q?v/NTc7oTT3RNgDQSIzVuBaiK7pFSD36/o0z6mdEb/eu/KKUw+0FA91WAiotH?=
 =?us-ascii?Q?X7+vQ5yXSs9ccGr3YnNoAsaXcop/0fZoKFQY9FQC4565xtlKoMPraU1V81Gr?=
 =?us-ascii?Q?j7kw9McxLpddxnOtO6YBs+hiB4pYNBvJRIGwZ7hZuPvSos4AjMrVwuYKe9on?=
 =?us-ascii?Q?Kwb/W/8Q5UrkT15NlaKzOoXNQaqEf2VM9UWFn1QU/iiJUlHJzpjEuYcRWwIv?=
 =?us-ascii?Q?swnbjEZdrlngj62LMlkOS+wwFfIXwmWzfuLrCppCbj39SwqlAIkd83P8hOd+?=
 =?us-ascii?Q?BQ4/vQLPBV1G8zARNYjM/vzfaOBvM1lRy4H1/GdqrlnyG4Efof1p6m9sMbOu?=
 =?us-ascii?Q?7d3HNCXRRQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37124c00-9e89-4722-265f-08df185d1347
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 03:53:34.6115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aP+mbe/8lQAfTwmIAbqvyXxfan0rMgNU+xPpLFnTS56p5VIxkczMW464SgpLsnzl7DabrBpNOwH+Zg3nT3XnVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701

On Fri, Sep 18, 2026 at 01:30:12PM +0800, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Additional DCD partition (AKA region) information is contained in the
> DSMAS CDAT tables, including performance and shareable attributes.
> 
> Match DCD partitions with DSMAS tables and store the meta data.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Co-developed-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>

Hi Anisa,

LGTM but I have limited knowledge for details of device's CDAT.
Other experts would be more suitable to leave their tag.

I have a question here only, I wonder if a CDAT with no DSLBIS supported is
possible ? seems that the implementation has the assumption that device's
CDAT would be always supported with valid DSMAS and DSLBIS.

Best regards,
Richard Cheng.

 
> ---
> Changes:
> 1. cdat.c: record the DSMAS shareable flag independently of QTG
>    discovery. cxl_port_perf_data_calculate() returns -ENOENT when FW
>    recommends no QTG for any entry, which skipped the assignment even
>    though the CDAT parsed successfully and the DSMAS flag was valid.
>    Richard
> ---
>  drivers/cxl/core/cdat.c   | 49 +++++++++++++++++++++++++++++----------
>  drivers/cxl/core/hdm.c    |  1 +
>  drivers/cxl/core/mbox.c   |  9 +++++++
>  drivers/cxl/core/memdev.c | 17 ++++++++------
>  drivers/cxl/cxlmem.h      |  2 ++
>  include/cxl/cxl.h         |  4 ++++
>  6 files changed, 63 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5c9f07262513..6e7950f12134 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -17,6 +17,7 @@ struct dsmas_entry {
>  	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
>  	int entries;
>  	int qos_class;
> +	bool shareable;
>  };
>  
>  static u32 cdat_normalize(u16 entry, u64 base, u8 type)
> @@ -74,6 +75,8 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
>  		return -ENOMEM;
>  
>  	dent->handle = dsmas->dsmad_handle;
> +	/* Shareable is CDAT 1.03 and later, DSMAS Flags bit 3 */
> +	dent->shareable = dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
>  	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
>  	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
>  			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
> @@ -255,8 +258,13 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
>  		dent->coord[ACCESS_COORDINATE_CPU].write_latency);
>  }
>  
> -static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
> -				     struct xarray *dsmas_xa)
> +/*
> + * The DSMAS shareable flag is a property of the CDAT entry and is recorded
> + * even if FW returns no QTG recommendations for any entry; only update perf
> + * if those recommendations exist, indicated by @set_perf
> + */
> +static void cxl_memdev_apply_dsmas(struct cxl_dev_state *cxlds,
> +				   struct xarray *dsmas_xa, bool set_perf)
>  {
>  	struct device *dev = cxlds->dev;
>  	struct dsmas_entry *dent;
> @@ -266,18 +274,34 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>  		bool found = false;
>  
>  		for (int i = 0; i < cxlds->nr_partitions; i++) {
> -			struct resource *res = &cxlds->part[i].res;
> +			struct cxl_dpa_partition *part = &cxlds->part[i];
>  			struct range range = {
> -				.start = res->start,
> -				.end = res->end,
> +				.start = part->res.start,
> +				.end = part->res.end,
>  			};
>  
> -			if (range_contains(&range, &dent->dpa_range)) {
> -				update_perf_entry(dev, dent,
> -						  &cxlds->part[i].perf);
> -				found = true;
> +			if (!range_contains(&range, &dent->dpa_range))
> +				continue;
> +
> +			found = true;
> +			/*
> +			 * part->handle is from Get DC Config, dent->handle
> +			 * from the CDAT DSMAS entry.
> +			 */
> +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1 &&
> +			    dent->handle != part->handle) {
> +				dev_warn(dev,
> +					 "DSMAD handle mismatch: %pra has %u, DSMAS %pra has %u\n",
> +					 &range, part->handle,
> +					 &dent->dpa_range, dent->handle);
>  				break;
>  			}
> +
> +			if (set_perf)
> +				update_perf_entry(dev, dent, &part->perf);
> +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1)
> +				part->shareable = dent->shareable;
> +			break;
>  		}
>  
>  		if (!found)
> @@ -419,12 +443,13 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
>  	}
>  
>  	rc = cxl_port_perf_data_calculate(port, dsmas_xa);
> -	if (rc) {
> +	if (rc)
>  		dev_dbg(&port->dev, "Failed to do perf coord calculations.\n");
> +
> +	cxl_memdev_apply_dsmas(cxlds, dsmas_xa, rc == 0);
> +	if (rc)
>  		return;
> -	}
>  
> -	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
>  	cxl_qos_class_verify(cxlmd);
>  	cxl_memdev_update_perf(cxlmd);
>  }
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0ef076c08ed2..7f63b86887f4 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -477,6 +477,7 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
>  
>  		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
>  		cxlds->part[i].mode = part->mode;
> +		cxlds->part[i].handle = part->handle;
>  
>  		/* Require ordered + contiguous partitions */
>  		if (i) {
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index c96c16cc08e1..d84a90320081 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1366,6 +1366,7 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
>  	u64 decode_len = le64_to_cpu(dev_part->decode_length);
>  	u64 blk_size = le64_to_cpu(dev_part->block_size);
>  	u64 len = le64_to_cpu(dev_part->length);
> +	u32 handle = le32_to_cpu(dev_part->dsmad_handle);
>  	u64 size;
>  
>  	/*
> @@ -1378,6 +1379,13 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
>  		return 0;
>  	}
>  
> +	/* The CDAT DSMAD handle this refers to is 8 bits */
> +	if (handle & ~0xFF) {
> +		dev_warn(dev, "DSMAD handle 0x%x exceeds the 8 bit CDAT DSMAD handle\n",
> +			 handle);
> +		return -EINVAL;
> +	}
> +
>  	/*
>  	 * Decode length is a count of 256M units, so a device reporting 2^36
>  	 * or more wraps.
> @@ -1391,6 +1399,7 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
>  	*part = (struct cxl_dc_partition_info) {
>  		.start = le64_to_cpu(dev_part->base),
>  		.size = size,
> +		.handle = handle,
>  	};
>  
>  	/*
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 15df8db314d9..8883c8850759 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -594,7 +594,8 @@ bool is_cxl_memdev(const struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
>  
> -static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
> +static void add_part(struct cxl_dpa_info *info, u64 start, u64 size,
> +		     enum cxl_partition_mode mode, u8 handle)
>  {
>  	int i = info->nr_partitions;
>  
> @@ -606,6 +607,7 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
>  		.end = start + size - 1,
>  	};
>  	info->part[i].mode = mode;
> +	info->part[i].handle = handle;
>  	info->nr_partitions++;
>  }
>  
> @@ -623,9 +625,9 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  	info->size = mds->total_bytes;
>  
>  	if (mds->partition_align_bytes == 0) {
> -		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
> +		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM, 0);
>  		add_part(info, mds->volatile_only_bytes,
> -			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
> +			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM, 0);
>  		return 0;
>  	}
>  
> @@ -635,9 +637,9 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  		return rc;
>  	}
>  
> -	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
> +	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM, 0);
>  	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
> -		 CXL_PARTMODE_PMEM);
> +		 CXL_PARTMODE_PMEM, 0);
>  
>  	return 0;
>  }
> @@ -685,7 +687,8 @@ int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  	info->size = total;
>  	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
>  		dc_info.start, dc_info.size);
> -	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
> +	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1,
> +		 dc_info.handle);
>  
>  	return 0;
>  }
> @@ -704,7 +707,7 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
>  		.size = capacity,
>  	};
>  
> -	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
> +	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM, 0);
>  	return cxl_dpa_setup(cxlds, &range_info);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 4fac65dbb808..9fd5af2e41d4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -140,6 +140,7 @@ struct cxl_dpa_info {
>  	struct cxl_dpa_part_info {
>  		struct range range;
>  		enum cxl_partition_mode mode;
> +		u8 handle;
>  	} part[CXL_NR_PARTITIONS_MAX];
>  	int nr_partitions;
>  };
> @@ -851,6 +852,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>  struct cxl_dc_partition_info {
>  	u64 start;
>  	u64 size;
> +	u8 handle;
>  };
>  
>  int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 4ef9511fbbdd..43edcde5bce3 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -141,11 +141,15 @@ enum cxl_partition_mode {
>   * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
>   * @perf: performance attributes of the partition from CDAT
>   * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
> + * @handle: DSMAS handle that represents this partition
> + * @shareable: Is the partition shareable (from its CDAT DSMAS entry)
>   */
>  struct cxl_dpa_partition {
>  	struct resource res;
>  	struct cxl_dpa_perf perf;
>  	enum cxl_partition_mode mode;
> +	u8 handle;
> +	bool shareable;
>  };
>  
>  #define CXL_NR_PARTITIONS_MAX 3
> -- 
> 2.43.0
> 
