Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2133.outbound.protection.outlook.com [40.107.92.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC513343F
	for <linux-cxl@vger.kernel.org>; Fri, 19 Apr 2024 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545085; cv=fail; b=gmgop1OZoF9ATvfGizOh4k0dkN1V9aB3ysNtESVwJ3vLzqblLGDZqAfsVlz1MUhb6jF4L2fqrH98PkkvP281oS+znsbf6+hQQOzemaEpu/j/RbG1UdwJv3OhIdc3Qxd1l4u6FIevPzOOXuA1B/K96jMeGoUIxz26XP/t20/56MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545085; c=relaxed/simple;
	bh=auC/qpSnV0/3wEAOFEun1M5MtU03xtcMJWCzk5uVM+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MGoxoxhYNMMJ4Kauv2SOF4FZhz3fjLfuSVsEupXRBaSjSiKhQDWFsgtoXH3sEy8aaHn/wOEO4Cbzy5N/iPNG/cAx0mcUjSDG58I78AxAsIjvwb2GP9g/U1eZIPavuN/eLbIbagZ2+eu0Hq97Wh9hYAGmqKoN9IJJNRyXK+9vWqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=ghjzQ8cf; arc=fail smtp.client-ip=40.107.92.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="ghjzQ8cf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcPuyp67wgP0011pFrC/F++hJZTCqFNTtAnzi08XV6yBpKMsLvNVr8gPHIPRC/6VQFjXylSeGLEBBg6zmbJ7M30LyDOdim6fCyFBvz6I+n9p6mlKANOEj8f3d+3GjvFV9a9Lnxib7pgXm1yiZT0WeQ31fHlcvrmDRKOLbPg8wbY9FJ8BoW9JYE3Q/tXCCclVa+TJa3QJfBnxhrJZBpnVSAtlXzubDBMUY10EBL103t8xAfHj7GSd9IpbGMUy/QFudUt6pHVweDL8LIbn1N58ZcIAvXWDPvhn2KAkDktZyCyvjEerSO2AAwH6Jveh2E3VC477T6Xl/zz82H/h2nAe6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LEIeJ59XQ4tY25j2qWCM5s+uK1iOy9vJBOEjUmYzOM=;
 b=PckJLvQoIoh2juPbUynXhfoKYmW5jiESAIR/4calkQ2xy0YOcwdsRQfrANY0JcZUobVAdLGHMyDrEXZ2qHtkDx8oMMV9U9tgTjhxH3IiiRqH/H5/o6BK3PzBq7kPUwpFuBezDOc99BL/KsywtH3ce1zrEHiRaeVoCCzfH9EXkeRgOvodez1BJavmWkmLMJNOgXtUuW7ZC+KjX9CK2/Yl6F+iXSz3jsDfWbwzcNqie3HZpdK4y2m3Y00hPfegjIiT01WEH7iNHNGEjbokBSSPgg4j0Y4Bhwxp44Ipv4CAd8XFoThp//qG012J4xoUK5b5MD3QDcjBr00h8omUfE9N2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LEIeJ59XQ4tY25j2qWCM5s+uK1iOy9vJBOEjUmYzOM=;
 b=ghjzQ8cfBIE8KnPOwurtbl+iFKCxdQjwR16/5/jx8HfpOkbvxDi36FzyxuURxvo/XAtnYrLSJcCKOONeNBjVrNqF/iQHnj1wkEOBh2ARlhFo+ZqdVOAvcWApB6qha6mgtVzEkY8mCYApuXXrq+OgE5tA9UBeCjMC5gGcv++/BAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MN2PR17MB3967.namprd17.prod.outlook.com (2603:10b6:208:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 19 Apr
 2024 16:44:40 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 16:44:40 +0000
Date: Fri, 19 Apr 2024 12:44:36 -0400
From: Gregory Price <gregory.price@memverge.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 02/12] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <ZiKfdJABS+ep67KP@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-3-fan.ni@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418232902.583744-3-fan.ni@samsung.com>
X-ClientProxiedBy: PH0PR07CA0073.namprd07.prod.outlook.com
 (2603:10b6:510:f::18) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MN2PR17MB3967:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1a412b-6ff7-49f7-8952-08dc6090020f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tEzoOt/dXukUDMfnpyPFxbhTulfZAVkWBNuD5BQFrGgx/GAuCGFk9JNaxVrB?=
 =?us-ascii?Q?yAUluqvMS66weYTZTj8ZKC6XXtmNor/y+za147xyP3zUGVeLQGAzJIb6PQZR?=
 =?us-ascii?Q?T0vDTBw+Dxq6nadljfH055OUiHrIQCaxFrME++nZDpZqyCMqrHw3HpV8uuSM?=
 =?us-ascii?Q?wTcTZ3qYy9wrwS9urzXvG17syruNxq3JVoIHNFpPri00rnN1ngr5+oN5p0zS?=
 =?us-ascii?Q?vL+myXLVx706mmbpLBnIXfGUOSWo/Q6wuLPIOa7FwZVUPuLljyUITgXmcXb8?=
 =?us-ascii?Q?QEG2HKHdJ17N/+izTN3xxDPKes9XqeYVHiD6o6naiEFBnasLRIuUYfDcNZir?=
 =?us-ascii?Q?AEvby8MCtmixFEyCc5o+KAzM/XFb6kKMTMdkmuPoTZ37gs7DDnMyjWP5+cLq?=
 =?us-ascii?Q?2Q54xJa32ZcrZvPAAa1T2T1OCSCCC8wUTmYLOHSvgdo0z3AyJswDGU60NiZQ?=
 =?us-ascii?Q?A3TPHw8bLxmIrU+rHAR0gSIBTPXeiiXU5YldPkWbMw5UkckzgIeDjU9iwjLY?=
 =?us-ascii?Q?R+U4szfgreHd5EX+kUCRdCFmdCw0K1YJvbz0Oal3JfRHu0WVBAbVyZKwAI5R?=
 =?us-ascii?Q?D4OO0hlZAAm8IL8R9JwvfH7UajwJ82IaFvQPcJL5pTyWirJMCb1Txv0bVeuL?=
 =?us-ascii?Q?hVA087Op8nHxjUyr2CjKNa1CQdP+Ppt7b1zQQuNo3JLHhaOt7hLd2CVC9DI6?=
 =?us-ascii?Q?GB1i/nRnywQyyocjSfY6IgNTwj8IjD2K3Tb8goouf3IvICsCW2UIlEmWEQBw?=
 =?us-ascii?Q?wfIHPyz8uBUR7Nk0rLmYZUr9vDmb3+7fz4ny4j8phDINfUSKmcbF3wyop7r5?=
 =?us-ascii?Q?1a8McsNwhY7f9owlRXgFP7abjxQWV5FVS/xWz7+mUCIaxacEcM3iNZxhrsMU?=
 =?us-ascii?Q?njwuWwzl8nSpYWb5SahQ/qMsl4mmDfo7agKeezAmRTRKPfNkahN4GncwzWSm?=
 =?us-ascii?Q?EzHriqrrWiSeGoZiF8qF9uc5AKsNujZ/l8t9kFaQftPUihrYUh7NxJL5wVV9?=
 =?us-ascii?Q?wjfFnp8JRU5nLsRVBSVTHgaKHZR9fpMiR1hfOfbmISaQS0OP9qclNaWz80Gc?=
 =?us-ascii?Q?DSbSQvaQKFwsguLrj/msCoflYu1GynISp9l42vNBFlNB/CEolaYF42pnPN7w?=
 =?us-ascii?Q?ALYpuhTgAy/j5oitD/AVmaWRnNQu7rY1bytUESxLD1xZ2eU6AT3AxM6UJEAr?=
 =?us-ascii?Q?C9JTbqNBkyMM+/57lgAWc8agaBSdfkwBlIjP/k1LSV2qVEo+jZJwifIQSJJs?=
 =?us-ascii?Q?xXFeWyrPmjGHLIM52u/A1Ep6XlTMTpD+zQ8NEEWM9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fjxoaHWuMV/eSn7bAYuEtgKjWcnx5aOns6Qw/HuOUw5zVUGL6CMf3LT1tlZf?=
 =?us-ascii?Q?RTrXzlWwgIetusBeZQRdvcZ3pXLLRhmrCeMf6aK0LbgX63jWDk0HG3I2aq74?=
 =?us-ascii?Q?mWzOuoI0HIt/wCxLEn8iBthCeYGZ4iPK/vUChlA05nOjpbmzsXOIXHImZyuT?=
 =?us-ascii?Q?fOslVzHlLrBiB9Yq/7CpACNXD232lMQz4ByNxYk8n265HnpfY2K71UFMuYEa?=
 =?us-ascii?Q?KhaZ86d2lW1s5mddvFaWFDK9je4fFDrjhFfPiUalRruB/FjyLP+BWFeIDsfY?=
 =?us-ascii?Q?1UhW2tJlAgR2G2kgEmEvEc4otKIBhi/NRQnw7uarINXQpH9TsmYfykVYhmjk?=
 =?us-ascii?Q?iPC8kmqvDBaIbkkJQ/6juFp0rTZZe/x6QDWCKi7groi9xlkYgB/ZMKBxC07d?=
 =?us-ascii?Q?MLdr4X7Nepbi7nkbxetOT6pDhh5JLegvoJ0pRGSZCVBXpFqbnEtRccn0eHVT?=
 =?us-ascii?Q?gaHfTQOe+B4q6P7M2hVEOmsS/D3djKOQ7xGNTJtvyfERyGWzsRRpJ2OM2/+V?=
 =?us-ascii?Q?k0W/sW0xT3rJYZsn6DwBqxrdngsG0d65NmEx3bd8amliyyazb2h38LTkbBlT?=
 =?us-ascii?Q?gSfeRdTJVatbm5TamvTUQAAAT/Ev9T7R7/dSrWl9PLYe1jWIVYCHkG1rRwsa?=
 =?us-ascii?Q?4b2HGumL0tboxjg+bQD6ZkcMKA1AJ/M4cCROtk5qetYrt/pzthglZurne/nJ?=
 =?us-ascii?Q?c15q/R6AFig7GCw0XyVu50+u7tYX0DUEajUoDPLntuXtSo8/Z6TcAjpxL+Jw?=
 =?us-ascii?Q?QW+zH6zSqMxISNasf7cyPp2bbYYCkR0qvOczV4Mwx/XJLNgEFHhP+dZFH3JT?=
 =?us-ascii?Q?1brLxZpfUeSB1/cCyBNkwZnnol7FOKnhPSvJ4jBDi3eXejK+Q68PIzvshQU0?=
 =?us-ascii?Q?uuYWpfVApcU218witPvMUCEkCKNtcLcbRXZSvawF/wYzQCMDxG4SsmgUZ3ue?=
 =?us-ascii?Q?kV2q2RJnNC7r6tjEs6+51G17KLQThMwFCsivrtT7btjg0Oxfh8PF+n1eYrp8?=
 =?us-ascii?Q?9ezw12NdlIKN2nQ7CsgbXLY+5i3wGr3CKnNxMpMMulXA7DHZyjPQ/FLKH7OT?=
 =?us-ascii?Q?LEKxxtq1pw3xlJGoxE7jClF2OTwbKsgikr89Q0wv2+tN/XJC4r9ggYismwyy?=
 =?us-ascii?Q?J9FbU8VZamgCVLoD7L63Omqm1UY5iPIoDVDH4200KLuUT69U++poB53X8T+D?=
 =?us-ascii?Q?nH+NQKrJAt7JBXIHwhiDY3Bvct5SZdy3vi6XL8DwMOEdRnE8+1A1AmC2kfPM?=
 =?us-ascii?Q?wGGDfr++TvGd7ioRncplmTXvqwQ2/HGerAxvbW/yn0etu+Imeo1fUK8nWByg?=
 =?us-ascii?Q?srN9zb5+BJKFdSwzSZuskPZMNzRuP9eD6heLAY+jjy9H7hdjSTKJFWeUYND2?=
 =?us-ascii?Q?IWL6Fg/N5I81oFM5iJBpItYE9va6qiV0Uis6NrF2tMlOBZ9vsQtw/81oSrm1?=
 =?us-ascii?Q?Z5ptnti4VxQZRoZzEayUJM2ldKjl8VdwfNH0PEunCZPwvGuGQ7JHr1GV7nqT?=
 =?us-ascii?Q?H9wNb0JAKxgnG89mJ4yruqNXuILTX0LTpOFQdxymY5tWhDNBUN0X144K7USE?=
 =?us-ascii?Q?5/QvfZuaae1XJ03nomrz7QbFsqvdAElCMx4qZFPXYFFI7WUWTcVpGmKfZ/FE?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1a412b-6ff7-49f7-8952-08dc6090020f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 16:44:40.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ty567O+YnXbS1dqpHjfkj6VbzOkXQNpcp7+ZMpc11P4xhqcCOSX6JiZjA8bVIimcozVMnDa3aTjuLBRuPZZJZVB4je58jahhpzyECrydKyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3967

On Thu, Apr 18, 2024 at 04:10:53PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Per cxl spec r3.1, add dynamic capacity region representative based on
> Table 8-165 and extend the cxl type3 device definition to include DC region
> information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
> Configuration' mailbox support.
> 
> Note: we store region decode length as byte-wise length on the device, which
> should be divided by 256 * MiB before being returned to the host
> for "Get Dynamic Capacity Configuration" mailbox command per
> specification.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 96 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h | 16 +++++++
>  2 files changed, 112 insertions(+)
> 

Reviewed-by: Gregory Price <gregory.price@memverge.com>
